Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2563.1794371289099913999
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:28:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4S8mF2429215
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:28:08 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 1/2] Send client requests over one shared datagram socket
Date: Tue, 10 Nov 2026 22:28:06 -0600
Message-Id: <1794371287-31540-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794371287-31540-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794371287-31540-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5295
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

The server handles each client's stream connection separately, so it
has no way to tell the order of requests queued by different clients.
That doesn't matter while every client waits for each reply, but it
prevents sending requests without waiting: a process could change a
file, tell another process, and that process's question could be
answered first.

Have clients send all requests, after the initial PING, to a datagram
socket shared by all clients, pseudo.request.  The kernel queues
datagrams in the order they were sent, so the server handles requests
in that order even across processes.  Replies still go back over each
client's stream connection, which also carries PING and SHUTDOWN and
tells the server when a client goes away.

Requests carry the client's slot and a per-connection serial number,
returned by the PING, so a request still queued from a client that has
gone away is applied but never answered on a reused slot.  The server
reads each request with one recv() instead of FIONREAD plus two reads,
and drains the socket before exiting.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 README.security |   4 +-
 doc/overview    |   3 +-
 doc/pseudo_ipc  |  36 +++++++++++++
 pseudo.h        |   1 +
 pseudo_client.c | 150 +++++++++++++++++++++++++++++++++++++-----------------
 pseudo_ipc.c    |  42 ++++++++++++++++
 pseudo_ipc.h    |   8 +++
 pseudo_server.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 348 insertions(+), 50 deletions(-)

diff --git a/README.security b/README.security
index 45533f2..5564448 100644
--- a/README.security
+++ b/README.security
@@ -133,9 +133,9 @@ ignore mismatch errors in pseudo's log.
 
 6. THE SERVER TRUSTS ITS CLIENTS
 
-The pseudo server listens on a Unix socket in its local state directory
+The pseudo server listens on Unix sockets in its local state directory
 and does not authenticate clients beyond the filesystem permissions of
-that socket.  Any process running as the build user can connect and
+those sockets.  Any process running as the build user can connect and
 change the database, and the database files themselves are writable by
 that user.  The resulting metadata can only be trusted as much as every
 process running as the build user.
diff --git a/doc/overview b/doc/overview
index 96c883d..c9497e5 100644
--- a/doc/overview
+++ b/doc/overview
@@ -19,7 +19,8 @@ to the virtual environment.
 
 Underlying this is access to a server process, which is automatically
 spawned by the library if one is not available.  The server process maintains
-a UNIX domain socket while it is active, and maintains a database (using
+UNIX domain sockets while it is active (see doc/pseudo_ipc), and maintains a
+database (using
 sqlite) of files known to the system.  Files are recorded in the database
 only if they are created within the virtualized environment or have been
 altered by it; files merely read are not added.
diff --git a/doc/pseudo_ipc b/doc/pseudo_ipc
index 0d9d6cd..e4ec750 100644
--- a/doc/pseudo_ipc
+++ b/doc/pseudo_ipc
@@ -1,5 +1,28 @@
 MESSAGE PASSING
 
+The server has two UNIX domain sockets in its local state directory:
+
+pseudo.socket
+	A stream socket.  Each client connects to it, sends a PING to
+	register, and gets every reply on this connection.  pseudo -S
+	also sends its SHUTDOWN request here, and the server notices a
+	client going away when the connection closes.
+
+pseudo.request
+	A datagram socket shared by all clients.  Every request after the
+	initial PING is sent here.
+
+The kernel queues datagrams from all senders on the one socket in the
+order they were sent, so the server handles requests in that order even
+across processes.  Once a client's send has returned, its request is
+queued ahead of anything another client sends afterwards.  If a process
+changes a file and then tells another process about it (through a pipe,
+by exiting, or any other way), the server has already queued the change
+by the time the second process can ask about the file.
+
+It also means the server reads each request with a single recv(),
+rather than a header and then a path.
+
 typedef struct {
 	pseudo_msg_type_t type;
 	pseudo_op_t op;
@@ -16,6 +39,8 @@ typedef struct {
 	unsigned int pathlen;
 	int nlink;
 	int deleting;
+	int client_id;
+	unsigned int client_serial;
 	char path[];
 } pseudo_msg_t;
 
@@ -44,6 +69,11 @@ only sends PING, OP, or FASTOP.  FASTOP is used for operations whose result
 the client doesn't need, but the server still replies with ACK (or NAK on
 failure) and the client still waits for that reply.
 
+A PING on the stream socket registers the client: the reply gives it the
+client_id and client_serial to put in its requests.  A PING on the
+request socket is answered once every request the client sent before it
+has been handled.
+
 When run with '-S', the pseudo program
 runs as a client, sending a SHUTDOWN message to a server -- but only if
 it can find one, it does not start a new one.  In this case, the server
@@ -84,6 +114,12 @@ deleting carries the database's "deleting" mark (see doc/database) when
 the server looks up file entries.  The server uses it internally; the
 client doesn't set or use it.
 
+client_id and client_serial identify the client's stream connection in
+requests on the shared socket, so the server knows where to reply.  The
+server numbers every connection, so a request still queued from a client
+that has gone away is never answered on a connection that has since
+reused its client_id; the server applies it without replying.
+
 32/64 bit:  This structure should have the same offsets for every element,
 including path, on both 64-bit and 32-bit machines.  (Check with 'offsets.c'.)
 It is *not* an error if sizeof(pseudo_msg_t) is different; the padding
diff --git a/pseudo.h b/pseudo.h
index 6a7339b..253a21d 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -131,6 +131,7 @@ extern char *pseudo_version;
 #define PSEUDO_PATHLOCK "pseudo.pathlock"
 #define PSEUDO_PIDFILE "pseudo.pid"
 #define PSEUDO_SOCKET "pseudo.socket"
+#define PSEUDO_REQUEST_SOCKET "pseudo.request"
 
 #define PSEUDO_SEVERITY_DEFAULT "info,warn,error"
 
diff --git a/pseudo_client.c b/pseudo_client.c
index 58e8810..c5b960f 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -46,6 +46,13 @@ static char *program_invocation_name = "unknown";
 static char *base_path(int dirfd, const char *path, int leave_last);
 
 static int connect_fd = -1;
+/* Requests go to the server over a datagram socket shared by all
+ * clients, so the server handles them in the order they were sent even
+ * across processes; replies come back on connect_fd.  See pseudo_server.c.
+ */
+static int request_fd = -1;
+static int client_id = 0;
+static unsigned int client_serial = 0;
 static int server_pid = 0;
 int pseudo_localstate_dir_fd = -1;
 static int pseudo_pathlock_fd = -1;
@@ -429,6 +436,18 @@ pseudo_profile_report(void) {
 }
 #endif
 
+static void
+client_disconnect(void) {
+	if (connect_fd != -1) {
+		close(connect_fd);
+		connect_fd = -1;
+	}
+	if (request_fd != -1) {
+		close(request_fd);
+		request_fd = -1;
+	}
+}
+
 void
 pseudo_init_client(void) {
 	char *env;
@@ -436,10 +455,7 @@ pseudo_init_client(void) {
 
 	pseudo_antimagic();
 	pseudo_new_pid();
-	if (connect_fd != -1) {
-		close(connect_fd);
-		connect_fd = -1;
-	}
+	client_disconnect();
 #ifdef PSEUDO_PROFILING
 	if (pseudo_profile_fd > -1) {
 		close(pseudo_profile_fd);
@@ -1110,6 +1126,8 @@ client_ping(void) {
 		server_pid = 0;
 		return 1;
 	} else {
+		client_id = ack->client_id;
+		client_serial = ack->client_serial;
                 /* The server tells us whether or not to log things. */
                 if (ack->result == RESULT_SUCCEED) {
                         pseudo_client_logging = 1;
@@ -1254,6 +1272,7 @@ static int
 client_connect(void) {
 	/* we have a server pid, is it responsive? */
 	struct sockaddr_un sun = { .sun_family = AF_UNIX, .sun_path = PSEUDO_SOCKET };
+	struct sockaddr_un req_sun = { .sun_family = AF_UNIX, .sun_path = PSEUDO_REQUEST_SOCKET };
 	int cwd_fd;
 
 	connect_fd = socket(PF_UNIX, SOCK_STREAM, 0);
@@ -1296,6 +1315,21 @@ client_connect(void) {
 		connect_fd = -1;
 		return 1;
 	}
+	request_fd = pseudo_fd(socket(PF_UNIX, SOCK_DGRAM, 0), MOVE_FD);
+	if (request_fd == -1 ||
+	    connect(request_fd, (struct sockaddr *) &req_sun, sizeof(req_sun)) == -1) {
+		char *e = strerror(errno);
+		pseudo_debug(PDBGF_CLIENT, "Can't connect request socket to %s: (%s)\n",
+			PSEUDO_REQUEST_SOCKET, e);
+		pseudo_evlog(PDBGF_CLIENT, "request socket connect failed: %s\n", e);
+		client_disconnect();
+		if (fchdir(cwd_fd) == -1) {
+			pseudo_error("return to previous directory failed: %s\n",
+				strerror(errno));
+		}
+		close(cwd_fd);
+		return 1;
+	}
 	if (fchdir(cwd_fd) == -1) {
 		pseudo_error("return to previous directory failed: %s\n",
 			strerror(errno));
@@ -1313,10 +1347,7 @@ pseudo_client_setup(void) {
 	server_pid = 0;
 
 	/* avoid descriptor leak, I hope */
-	if (connect_fd >= 0) {
-		close(connect_fd);
-		connect_fd = -1;
-	}
+	client_disconnect();
 	if (client_connect() == 0) {
 		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "connection started.\n");
 		if (client_ping() == 0) {
@@ -1327,8 +1358,7 @@ pseudo_client_setup(void) {
 			/* and now we'll close the connection, and try to
 			 * kick the server.
 			 */
-			close(connect_fd);
-			connect_fd = -1;
+			client_disconnect();
 		}
 	}
 	pseudo_debug(PDBGF_CLIENT, "connection failed, checking server...\n");
@@ -1381,8 +1411,7 @@ pseudo_client_setup(void) {
 			} else {
 				pseudo_debug(PDBGF_CLIENT, "ping failed to restarted server.\n");
 				pseudo_evlog(PDBGF_CLIENT, "ping failed to restarted server.\n");
-				close(connect_fd);
-				connect_fd = -1;
+				client_disconnect();
 				return 1;
 			}
 		} else {
@@ -1394,11 +1423,57 @@ pseudo_client_setup(void) {
 }
 
 #define PSEUDO_RETRIES 250
+
+static void
+pseudo_client_abort(void) {
+	char *local_state_dir = pseudo_get_value("PSEUDO_LOCALSTATEDIR");
+	pseudo_info("abort()ing pseudo client by server request. See https://wiki.yoctoproject.org/wiki/Pseudo_Abort for more details on this.\n"
+		"Check logfile: %s/%s\n", local_state_dir, PSEUDO_LOGFILE);
+	abort();
+}
+
+/* Send a request over the request socket, reconnecting to (or starting)
+ * the server if that fails.  Returns 0 once sent.
+ */
+static int
+pseudo_client_send(pseudo_msg_t *msg, size_t len, const char *path, int tries) {
+	int rc;
+
+	for (; tries < PSEUDO_RETRIES; ++tries) {
+		pseudo_evlog(PDBGF_CLIENT, "try %d, request fd is %d\n", tries, request_fd);
+		msg->client_id = client_id;
+		msg->client_serial = client_serial;
+		rc = pseudo_msg_send(request_fd, msg, len, path);
+		if (rc == 0)
+			return tries;
+		pseudo_evlog(PDBGF_CLIENT, "msg_send failed [%d].\n", rc);
+		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "msg_send: %d%s\n",
+			rc,
+			rc == -1 ? " (sigpipe)" :
+				   " (short write)");
+		pseudo_debug(PDBGF_CLIENT, "trying to get server, try %d\n", tries);
+		/* try to open server; if we fail, wait a bit before
+		 * retry.
+		 */
+		if (pseudo_client_setup()) {
+			int ms = (getpid() % 5) + (3 * tries);
+			struct timespec delay = { .tv_sec = 0, .tv_nsec = ms * 1000000 };
+			pseudo_evlog(PDBGF_CLIENT, "setup failed, delaying %d ms.\n", ms);
+			nanosleep(&delay, NULL);
+		} else {
+			pseudo_evlog(PDBGF_CLIENT, "setup apparently successful, retrying message immediately.\n");
+		}
+	}
+	pseudo_error("pseudo: server connection persistently failed, aborting.\n");
+	pseudo_evlog_dump();
+	pseudo_critical("event log dumped, aborting.\n");
+	return -1;
+}
+
 static pseudo_msg_t *
 pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 	pseudo_msg_t *response = 0;
 	int tries = 0;
-	int rc;
 
 	if (!msg)
 		return 0;
@@ -1410,36 +1485,16 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 	 */
 	pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "sending a message: ino %llu\n",
 		(unsigned long long) msg->ino);
-        for (tries = 0; tries < PSEUDO_RETRIES; ++tries) {
-		pseudo_evlog(PDBGF_CLIENT, "try %d, connect fd is %d\n", tries, connect_fd);
-		rc = pseudo_msg_send(connect_fd, msg, len, path);
-		if (rc != 0) {
-			pseudo_evlog(PDBGF_CLIENT, "msg_send failed [%d].\n", rc);
-			pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "msg_send: %d%s\n",
-				rc,
-				rc == -1 ? " (sigpipe)" :
-					   " (short write)");
-			pseudo_debug(PDBGF_CLIENT, "trying to get server, try %d\n", tries);
-			/* try to open server; if we fail, wait a bit before
-			 * retry.
-			 */
-			if (pseudo_client_setup()) {
-				int ms = (getpid() % 5) + (3 * tries);
-				struct timespec delay = { .tv_sec = 0, .tv_nsec = ms * 1000000 };
-				pseudo_evlog(PDBGF_CLIENT, "setup failed, delaying %d ms.\n", ms);
-				nanosleep(&delay, NULL);
-			} else {
-				pseudo_evlog(PDBGF_CLIENT, "setup apparently successful, retrying message immediately.\n");
-			}
-			continue;
-		}
-		/* note "continue" above; we only get here if rc was 0,
-		 * indicating a successful send.
-		 */
+	for (; tries < PSEUDO_RETRIES; ++tries) {
+		tries = pseudo_client_send(msg, len, path, tries);
 		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "sent!\n");
 		response = pseudo_msg_receive(connect_fd);
 		if (!response) {
 			pseudo_debug(PDBGF_CLIENT, "expected response did not occur; retrying\n");
+			/* the connection may be gone even though the request
+			 * socket still works, so reconnect before resending
+			 */
+			pseudo_client_setup();
 		} else {
 			if (response->type != PSEUDO_MSG_ACK) {
 				pseudo_debug(PDBGF_CLIENT, "got non-ack response %d\n", response->type);
@@ -2124,6 +2179,8 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 			startfd = pseudo_grp_fd + 1;
 		if (connect_fd >= startfd)
 			startfd = connect_fd + 1;
+		if (request_fd >= startfd)
+			startfd = request_fd + 1;
 		/* the fds below startfd are the ones our own are mixed in
 		 * with, so close those by hand and skip the ones we need
 		 */
@@ -2132,7 +2189,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 					i == pseudo_localstate_dir_fd || i == pseudo_pathlock_fd ||
 					i == pseudo_pwd_fd ||
 					i == pseudo_pwd_lck_fd || i == pseudo_grp_fd ||
-					i == connect_fd)
+					i == connect_fd || i == request_fd)
 				continue;
 			pseudo_client_close(i);
 			close(i);
@@ -2152,6 +2209,11 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 				if (connect_fd == -1) {
 					pseudo_error("tried to close connection, couldn't dup: %s\n", strerror(errno));
 				}
+			} else if (fd == request_fd) {
+				request_fd = pseudo_fd(request_fd, COPY_FD);
+				if (request_fd == -1) {
+					pseudo_error("tried to close request socket, couldn't dup: %s\n", strerror(errno));
+				}
 			} else if (fd == pseudo_util_debug_fd || fd == pseudo_util_evlog_fd) {
 				/* both are stderr by default */
 				int newfd = pseudo_fd(fd, COPY_FD);
@@ -2257,12 +2319,8 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 #endif
 		if (result) {
 			pseudo_debug(PDBGF_OP, "(%d) %s", getpid(), pseudo_res_name(result->result));
-			if (result->result == RESULT_ABORT) {
-				char *local_state_dir = pseudo_get_value("PSEUDO_LOCALSTATEDIR");
-				pseudo_info("abort()ing pseudo client by server request. See https://wiki.yoctoproject.org/wiki/Pseudo_Abort for more details on this.\n"
-					"Check logfile: %s/%s\n", local_state_dir, PSEUDO_LOGFILE);
-				abort();
-			}
+			if (result->result == RESULT_ABORT)
+				pseudo_client_abort();
 			if (op == OP_STAT || op == OP_FSTAT) {
 				pseudo_debug(PDBGF_OP, " mode 0%o uid %d:%d",
 					(int) result->mode,
diff --git a/pseudo_ipc.c b/pseudo_ipc.c
index e51fe0e..e3dd064 100644
--- a/pseudo_ipc.c
+++ b/pseudo_ipc.c
@@ -188,6 +188,48 @@ pseudo_msg_receive(int fd) {
 	return incoming;
 }
 
+/* receive one request from the server's datagram socket without
+ * blocking.  Returns NULL if none is queued (errno EAGAIN), or if the
+ * datagram was malformed and has been discarded (errno EBADMSG).
+ */
+pseudo_msg_t *
+pseudo_msg_receive_request(int fd) {
+	static pseudo_msg_t *incoming;
+	ssize_t r;
+
+	if (fd < 0)
+		return 0;
+	if (!incoming) {
+		/* one spare byte so the path can always be null-terminated */
+		incoming = malloc(PSEUDO_MAX_REQUEST + 1);
+		if (!incoming) {
+			pseudo_error("Couldn't allocate request buffer.\n");
+			return 0;
+		}
+	}
+	errno = 0;
+	r = recv(fd, incoming, PSEUDO_MAX_REQUEST, MSG_DONTWAIT | MSG_TRUNC);
+	if (r == -1) {
+		if (errno != EAGAIN && errno != EWOULDBLOCK)
+			pseudo_debug(PDBGF_IPC, "request recv failed: %s\n", strerror(errno));
+		return 0;
+	}
+	if (r > PSEUDO_MAX_REQUEST) {
+		pseudo_error("dropped oversized request (%ld bytes).\n", (long) r);
+		errno = EBADMSG;
+		return 0;
+	}
+	if (r < (ssize_t) PSEUDO_HEADER_SIZE ||
+	    (size_t) r != PSEUDO_HEADER_SIZE + incoming->pathlen) {
+		pseudo_error("dropped malformed request (%ld bytes).\n", (long) r);
+		errno = EBADMSG;
+		return 0;
+	}
+	pseudo_debug(PDBGF_IPC, "got request, type %d, pathlen %d\n", incoming->type, (int) incoming->pathlen);
+	((char *) incoming)[r] = '\0';
+	return incoming;
+}
+
 /* duplicate a message -- currently totally unused */
 pseudo_msg_t *
 pseudo_msg_dup(pseudo_msg_t *old) {
diff --git a/pseudo_ipc.h b/pseudo_ipc.h
index d945257..1fc20a9 100644
--- a/pseudo_ipc.h
+++ b/pseudo_ipc.h
@@ -26,6 +26,8 @@ typedef struct {
 	unsigned int pathlen;
 	int nlink;
 	int deleting;
+	int client_id;
+	unsigned int client_serial;
 	char path[];
 } pseudo_msg_t;
 
@@ -47,7 +49,13 @@ extern int pseudo_access_fopen(const char *);
 
 #define PSEUDO_HEADER_SIZE (offsetof(pseudo_msg_t, path))
 
+/* largest request sent over the datagram socket: two paths for rename,
+ * or a path plus an xattr name and value (at most 64KB)
+ */
+#define PSEUDO_MAX_REQUEST (256 * 1024)
+
 extern pseudo_msg_t *pseudo_msg_receive(int fd);
+extern pseudo_msg_t *pseudo_msg_receive_request(int fd);
 extern pseudo_msg_t *pseudo_msg_dup(pseudo_msg_t *);
 extern pseudo_msg_t *pseudo_msg_dupheader(pseudo_msg_t *);
 extern pseudo_msg_t *pseudo_msg_new(size_t, const char *);
diff --git a/pseudo_server.c b/pseudo_server.c
index 13caced..6109f67 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -41,6 +41,7 @@ typedef struct {
 	pid_t pid;
 	char *tag;
 	char *program;
+	unsigned int serial;
 } pseudo_client_t;
 
 pseudo_client_t *clients;
@@ -51,6 +52,19 @@ pseudo_client_t *clients;
  */
 static int active_clients = 0, highest_client = 0, max_clients = 0;
 
+/* Clients send all requests over one datagram socket, so the server
+ * handles them in the order they were sent, even across clients: once
+ * one client's send returns, its request is queued ahead of anything
+ * another client sends afterwards.  Replies go back over each client's
+ * stream connection, which also carries the initial ping, shutdown
+ * requests, and tells us when the client goes away.  Each connection
+ * gets a serial number so a request from a client that has since gone
+ * away is never answered on a reused client slot.
+ */
+static int request_fd = -1;
+static unsigned int next_serial = 0;
+#define REQUEST_EVENT ((uint64_t) -1)
+
 #define LOOP_DELAY 2
 #define DEFAULT_PSEUDO_SERVER_TIMEOUT 30
 #define EPOLL_MAX_EVENTS 10
@@ -346,6 +360,34 @@ pseudo_server_start(int daemonize) {
 		pseudo_error("couldn't listen on socket: %s\n", strerror(errno));
 		exit(PSEUDO_EXIT_SOCKET_LISTEN);
 	}
+
+	request_fd = socket(PF_UNIX, SOCK_DGRAM, 0);
+	if (request_fd < 0) {
+		pseudo_error("couldn't create request socket: %s\n", strerror(errno));
+		exit(PSEUDO_EXIT_SOCKET_CREATE);
+	}
+	if (request_fd <= 2) {
+		newfd = fcntl(request_fd, F_DUPFD, 3);
+		if (newfd < 0) {
+			pseudo_error("couldn't dup request socket: %s\n", strerror(errno));
+			exit(PSEUDO_EXIT_SOCKET_FD);
+		}
+		close(request_fd);
+		request_fd = newfd;
+	}
+	rc = unlink(PSEUDO_REQUEST_SOCKET);
+	if (rc == -1 && errno != ENOENT) {
+		pseudo_error("Can't unlink existing request socket: %s.\n",
+			strerror(errno));
+		exit(PSEUDO_EXIT_SOCKET_UNLINK);
+	}
+	{
+		struct sockaddr_un req_sun = { .sun_family = AF_UNIX, .sun_path = PSEUDO_REQUEST_SOCKET };
+		if (bind(request_fd, (struct sockaddr *) &req_sun, sizeof(req_sun)) == -1) {
+			pseudo_error("couldn't bind request socket: %s\n", strerror(errno));
+			exit(PSEUDO_EXIT_SOCKET_BIND);
+		}
+	}
 	rc = pseudo_server_write_pid(getpid());
 	if (rc != 0) {
 		pseudo_warning("couldn't write pid file.\n");
@@ -384,6 +426,7 @@ open_client(int fd) {
 			clients[i].pid = 0;
 			clients[i].tag = NULL;
 			clients[i].program = NULL;
+			clients[i].serial = ++next_serial;
 			++active_clients;
 			if (i > highest_client)
 				highest_client = i;
@@ -407,6 +450,7 @@ open_client(int fd) {
 		clients[max_clients].pid = 0;
 		clients[max_clients].tag = NULL;
 		clients[max_clients].program = NULL;
+		clients[max_clients].serial = ++next_serial;
 		highest_client = max_clients;
 
 		max_clients += 16;
@@ -491,6 +535,11 @@ serve_client(int i) {
 			}
 			pseudo_debug(PDBGF_SERVER, "\n");
 		}
+		/* tell the client which slot to name in its requests */
+		if (in->type == PSEUDO_MSG_PING) {
+			in->client_id = i;
+			in->client_serial = clients[i].serial;
+		}
 		if (in->type == PSEUDO_MSG_SHUTDOWN && !clients[i].pid) {
 			pseudo_debug(PDBGF_SERVER, "shutdown request from client %d [pid %d]\n",
 				i, in->client);
@@ -605,6 +654,93 @@ serve_client(int i) {
 	return rc;
 }
 
+/* Handle one request from the datagram socket, replying on the client's
+ * stream connection.
+ */
+static void
+serve_request(pseudo_msg_t *in) {
+	struct timeval tv1, tv2;
+	char *response_path = 0;
+	size_t response_pathlen = -1;
+	int id = in->client_id;
+	int valid, rc;
+
+	gettimeofday(&tv1, NULL);
+	++messages;
+	valid = id > 0 && id <= highest_client && clients[id].fd != -1 &&
+		clients[id].serial == in->client_serial;
+	if (!valid) {
+		pseudo_debug(PDBGF_SERVER, "request from departed client %d [pid %d]\n",
+			id, in->client);
+	} else if (in->client != clients[id].pid) {
+		pseudo_debug(PDBGF_SERVER, "uh-oh, expected pid %d for client %d, got %d\n",
+			(int) clients[id].pid, id, in->client);
+	}
+	switch (in->type) {
+	case PSEUDO_MSG_PING:
+		in->type = PSEUDO_MSG_ACK;
+		break;
+	case PSEUDO_MSG_OP:
+	case PSEUDO_MSG_FASTOP:
+		if (pseudo_server_response(in, valid ? clients[id].program : NULL,
+				valid ? clients[id].tag : NULL,
+				&response_path, &response_pathlen)) {
+			in->type = PSEUDO_MSG_NAK;
+		} else {
+			in->type = PSEUDO_MSG_ACK;
+		}
+		break;
+	default:
+		pdb_log_msg(SEVERITY_WARN, in, NULL, NULL, "invalid request type %d", in->type);
+		in->type = PSEUDO_MSG_NAK;
+		break;
+	}
+	if (valid) {
+		pseudo_debug(PDBGF_SERVER | PDBGF_VERBOSE, "response: %d (%s)\n",
+			in->result, pseudo_res_name(in->result));
+		in->client = id;
+		in->pathlen = response_path ? response_pathlen : 0;
+		rc = pseudo_msg_send(clients[id].fd, in, in->pathlen, response_path);
+		if (rc != 0) {
+			pseudo_debug(PDBGF_SERVER, "failed to send response to client %d [%d]: %d (%s)\n",
+				id, (int) clients[id].pid, rc, strerror(errno));
+		} else {
+			++responses;
+		}
+	}
+	free(response_path);
+
+	gettimeofday(&tv2, NULL);
+	message_time.tv_sec += (tv2.tv_sec - tv1.tv_sec);
+	message_time.tv_usec += (tv2.tv_usec - tv1.tv_usec);
+	if (message_time.tv_usec < 0) {
+		message_time.tv_usec += 1000000;
+		--message_time.tv_sec;
+	} else while (message_time.tv_usec > 1000000) {
+		message_time.tv_usec -= 1000000;
+		++message_time.tv_sec;
+	}
+}
+
+/* Handle up to max queued requests, returning how many were handled. */
+static int
+serve_requests(int max) {
+	pseudo_msg_t *in;
+	int n;
+
+	for (n = 0; n < max; ++n) {
+		in = pseudo_msg_receive_request(request_fd);
+		if (!in) {
+			/* a malformed datagram was discarded; keep going */
+			if (errno == EBADMSG)
+				continue;
+			break;
+		}
+		serve_request(in);
+	}
+	return n;
+}
+
 /* get clients, handle messages, shut down.
  * This doesn't actually do any work, it just calls a ton of things which
  * do work.
@@ -665,6 +801,12 @@ pseudo_server_loop(void) {
 		pseudo_error("epoll_ctl() failed with listening socket.\n");
 		exit(PSEUDO_EXIT_EPOLL_CTL);
 	}
+	ev.events = EPOLLIN;
+	ev.data.u64 = REQUEST_EVENT;
+	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, request_fd, &ev) == -1) {
+		pseudo_error("epoll_ctl() failed with request socket.\n");
+		exit(PSEUDO_EXIT_EPOLL_CTL);
+	}
 
 	pdb_log_msg(SEVERITY_INFO, NULL, NULL, NULL, "server started (pid %d)", getpid());
 
@@ -693,7 +835,14 @@ pseudo_server_loop(void) {
 		} else if (rc > 0) {
 			loop_timeout = pseudo_server_timeout;
 			for (i = 0; i < rc; ++i) {
-				int client_id = events[i].data.u64;
+				int client_id;
+				if (events[i].data.u64 == REQUEST_EVENT) {
+					serve_requests(64);
+					if (die_forcefully)
+						break;
+					continue;
+				}
+				client_id = events[i].data.u64;
 				if (clients[client_id].fd == listen_fd) {
 					if (!die_forcefully) {
 						len = sizeof(client);
@@ -780,6 +929,9 @@ pseudo_server_loop(void) {
 			pseudo_info("done.\n");
 		}
 		if (die_peacefully || die_forcefully) {
+			/* apply requests clients sent before they went away */
+			while (serve_requests(64) == 64)
+				;
 			pseudo_debug(PDBGF_SERVER, "quitting.\n");
 			pseudo_debug(PDBGF_SERVER | PDBGF_BENCHMARK, "server %d exiting: handled %d messages in %.4f seconds\n",
 				getpid(), messages,
-- 
1.8.3.1

