Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2564.1794371289296305506
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:28:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4S8mG2429215
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:28:08 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 2/2] Replace FASTOP with requests that don't wait for a reply
Date: Tue, 10 Nov 2026 22:28:07 -0600
Message-Id: <1794371287-31540-3-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794371287-31540-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794371287-31540-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5297
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Most requests only tell the server about a change, such as chown,
chmod, creat, rename or unlink, and the client ignores the reply, but
it still waited for every one.

FASTOP was meant to avoid that, but it sent requests over each
client's own connection, so another process could overtake a change it
had been told about, and it dropped errors.  "Half-undo FASTOP"
(449c234) fixed the errors by having the client wait for every reply
again, leaving FASTOP identical to OP; the server's early-ACK path
never ran because the message type had already been changed to ACK or
NAK.  Remove it, its op "wait" column and the dead server code.

Since requests are now handled in the order they were sent, even
across processes, send these as a new PSEUDO_MSG_ASYNC type without
waiting.  The ops are marked in a new "async" column in enums/op.in.

The server only replies to an async request if the client must abort,
for instance after a path mismatch.  The client reads that reply ahead
of the reply to its next synchronous request and aborts then.  So that
an abort isn't lost, a client with requests outstanding waits for them
with a PING on the request socket before exec() and at exit; the exit
check doesn't wait for the pseudo lock, which another thread may hold
indefinitely.  _exit() and _Exit() skip destructors, and are used by
forked workers such as Python's multiprocessing, so wrap them to wait
as well.  PSEUDO_SYNC=1 makes every request wait, so the client
aborts in the call that caused the problem.

On a tar/chown/find/ls/rm workload of 40,000 files this takes the run
from 21.8s to 14.3s.

Add tests that changes made without waiting are seen by other processes
told about them through a pipe or by reaping the process, and that an
abort is still delivered, at the next synchronous request, _exit() or
execvpe(), with and without PSEUDO_SYNC.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 doc/overview                   |   3 +-
 doc/program_flow               |  11 +++
 doc/pseudo_ipc                 |  43 +++++++---
 enums/msg_type.in              |   2 +-
 enums/op.in                    |  50 +++++------
 ports/common/guts/_Exit.c      |  16 ++++
 ports/common/guts/_exit.c      |  16 ++++
 ports/common/guts/execv.c      |   4 +
 ports/common/guts/execve.c     |   4 +
 ports/common/guts/execveat.c   |   4 +
 ports/common/guts/execvp.c     |   4 +
 ports/common/guts/execvpe.c    |   4 +
 ports/common/guts/fexecve.c    |   4 +
 ports/common/pseudo_wrappers.c |  34 ++++++++
 ports/common/wrapfuncs.in      |   2 +
 pseudo.1                       |  23 ++++-
 pseudo.c                       |   2 +-
 pseudo_client.c                |  72 +++++++++++++++-
 pseudo_client.h                |   2 +
 pseudo_server.c                |  42 ++++-----
 pseudo_util.c                  |   1 +
 pseudo_wrappers.c              |  43 ++++++++++
 test/test-async-abort.c        |  44 ++++++++++
 test/test-async-abort.sh       |  40 +++++++++
 test/test-async-order.c        | 188 +++++++++++++++++++++++++++++++++++++++++
 test/test-async-order.sh       |  23 +++++
 26 files changed, 606 insertions(+), 75 deletions(-)
 create mode 100644 ports/common/guts/_Exit.c
 create mode 100644 ports/common/guts/_exit.c
 create mode 100644 test/test-async-abort.c
 create mode 100755 test/test-async-abort.sh
 create mode 100644 test/test-async-order.c
 create mode 100755 test/test-async-order.sh

diff --git a/doc/overview b/doc/overview
index c9497e5..7b7ab1e 100644
--- a/doc/overview
+++ b/doc/overview
@@ -47,7 +47,8 @@ client can restart it.)
 4.  The server code.  This code is fairly simple; all it does is maintain
 the database of file information.  Operations consist either of a request
 for information (e.g., a stat(2) call) or notification of a change.  The
-server sends back failure or success notices.
+server sends back failure or success notices for requests for information;
+notifications of a change are sent without waiting for a reply.
 
 As a fairly typical example, the progress of a stat(2) call is:
 
diff --git a/doc/program_flow b/doc/program_flow
index 5fbdb5d..174f443 100644
--- a/doc/program_flow
+++ b/doc/program_flow
@@ -14,6 +14,8 @@ libpseudo execution flow:
 			setup pseudo_functions
 			setup log files (PSEUDO_DEBUG_FILE, PSEUDO_EVLOG_FILE)
 		pseudo_client.c: pseudo_init_client()
+			wait for this process's asynchronous requests
+			setup PSEUDO_SYNC
 			setup PSEUDO_DISABLED
 			setup pseudo_localstate_dir_fd
 			setup PSEUDO_NOSYMLINKEXP
@@ -30,6 +32,7 @@ libpseudo execution flow:
 			pseudo_setupenv()
 			if PSEUDO_UNLOAD
 				pseudo_dropenv()
+			pseudo_client_flush()
 			real_exec*()
 
 	fork()
@@ -77,6 +80,14 @@ libpseudo execution flow:
 		unmask signals (if they were blocked above)
 		return rc
 
+	# on exit #
+
+	pseudo_wrappers.c: (destructor) _libpseudo_fini(), or _exit()/_Exit()
+		pseudo_exit_flush()
+			if this process has asynchronous requests pending,
+			and the lock is free (or already ours)
+				pseudo_client_flush()
+
 pseudo execution flow:
 	pseudo.c: main()
 		pseudo_util.c: pseudo_init_util()
diff --git a/doc/pseudo_ipc b/doc/pseudo_ipc
index e4ec750..8186cd6 100644
--- a/doc/pseudo_ipc
+++ b/doc/pseudo_ipc
@@ -20,8 +20,10 @@ changes a file and then tells another process about it (through a pipe,
 by exiting, or any other way), the server has already queued the change
 by the time the second process can ask about the file.
 
-It also means the server reads each request with a single recv(),
-rather than a header and then a path.
+That is what allows requests that need no reply to be sent without
+waiting for the server (see ASYNC below).  It also means the server
+reads each request with a single recv(), rather than a header and then
+a path.
 
 typedef struct {
 	pseudo_msg_type_t type;
@@ -53,26 +55,41 @@ All messages contain every field up to, but not including, path.  If
 pathlen is not zero, an additional pathlen bytes containing path are
 provided; path is null-terminated.
 
-Every message from client should get a response from server.  The server
-usually sends no path back; the exceptions are replies to xattr requests
-(attribute values or name lists) and the list of client PIDs in a refused
-SHUTDOWN request, described below.  Note that
-all server responses will in general share a single message object,
+Every message from the client gets a response from the server, except
+ASYNC requests.  The server usually sends no path back; the exceptions
+are replies to xattr requests (attribute values or name lists) and the
+list of client PIDs in a refused SHUTDOWN request, described below.
+Note that all server responses will in general share a single message object,
 and future operations may cause that object to be reallocated; the same
 goes for messages received by the server.  Basically, pseudo_msg_receive
 is not thread-safe; this is part of (but not all of) the reason that there's
 mutex stuff in the wrappers.  (The other part is the "antimagic" being
 able to blow things up.)
 
-type is one of PING, OP, FASTOP, SHUTDOWN, ACK, or NAK.  The client
-only sends PING, OP, or FASTOP.  FASTOP is used for operations whose result
-the client doesn't need, but the server still replies with ACK (or NAK on
-failure) and the client still waits for that reply.
+type is one of PING, OP, SHUTDOWN, ACK, NAK, or ASYNC.  The client
+sends PING, OP and ASYNC, and the server replies to PING and OP with ACK
+(or NAK on failure); the client waits for that reply.
 
 A PING on the stream socket registers the client: the reply gives it the
 client_id and client_serial to put in its requests.  A PING on the
 request socket is answered once every request the client sent before it
-has been handled.
+has been handled; the client uses this to wait for its ASYNC requests.
+
+ASYNC is used instead of OP for operations whose result the client
+doesn't use: chmod, chown, creat, link, mkdir, rename, symlink, unlink,
+did-unlink, cancel-unlink and set-xattr, and open and exec when the
+server is logging.  These are marked in enums/op.in.  The client doesn't
+wait for them, and the server only replies if the client must abort
+(RESULT_ABORT, for instance after a path mismatch).  That reply has type
+ASYNC, and arrives on the stream connection ahead of the reply to the
+client's next OP or PING, which is where the client reads it and aborts.
+To make sure an abort isn't lost, a client that has sent ASYNC requests
+sends a PING on the request socket and waits for the reply before
+exec() and when it exits, including through _exit().  A client that is
+killed doesn't, but the server still applies its requests.
+
+Setting PSEUDO_SYNC in a client's environment to a value other than 0
+makes it send OP instead of ASYNC, waiting for every request.
 
 When run with '-S', the pseudo program
 runs as a client, sending a SHUTDOWN message to a server -- but only if
@@ -85,7 +102,7 @@ reduces the timeout to 3 seconds, so it shuts down shortly after the
 last client goes away rather than waiting for the full timeout period.)
 
 result is the result of a particular operation.  It applies only in replies
-to OP messages.
+to OP and ASYNC messages.
 
 client should be the client's PID on send, and the server's client number for
 that client on response.  (The response isn't checked, and this is just a
diff --git a/enums/msg_type.in b/enums/msg_type.in
index 578d571..8435599 100644
--- a/enums/msg_type.in
+++ b/enums/msg_type.in
@@ -4,4 +4,4 @@ shutdown
 op
 ack
 nak
-fastop
+async
diff --git a/enums/op.in b/enums/op.in
index 5854b74..f9b5e22 100644
--- a/enums/op.in
+++ b/enums/op.in
@@ -1,30 +1,30 @@
-op: OP; int wait = 0
+op: OP; int async = 0
 chdir, 0
-chmod, 0
-chown, 0
+chmod, 1
+chown, 1
 chroot, 0
 close, 0
-creat, 0
+creat, 1
 dup, 0
-fchmod, 0
-fchown, 0
-fstat, 1
-link, 0
-mkdir, 0
-mknod, 1
-open, 0
-rename, 0
-stat, 1
-unlink, 0
-symlink, 0
-exec, 0
-may-unlink, 1
-did-unlink, 0
-cancel-unlink, 0
-get-xattr, 1
-list-xattr, 1
-remove-xattr, 1
-set-xattr, 0
-create-xattr, 1
-replace-xattr, 1
+fchmod, 1
+fchown, 1
+fstat, 0
+link, 1
+mkdir, 1
+mknod, 0
+open, 1
+rename, 1
+stat, 0
+unlink, 1
+symlink, 1
+exec, 1
+may-unlink, 0
+did-unlink, 1
+cancel-unlink, 1
+get-xattr, 0
+list-xattr, 0
+remove-xattr, 0
+set-xattr, 1
+create-xattr, 0
+replace-xattr, 0
 close-range, 0
diff --git a/ports/common/guts/_Exit.c b/ports/common/guts/_Exit.c
new file mode 100644
index 0000000..5c93d2d
--- /dev/null
+++ b/ports/common/guts/_Exit.c
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * void _Exit(int status)
+ */
+
+	/* NOTE THAT THIS IS NEVER USED!
+	 * The hand-written _Exit() in ../pseudo_wrappers.c flushes
+	 * asynchronous requests and exits directly.
+	 */
+
+	real__Exit(status);
+
+/*	return;
+ * }
+ */
diff --git a/ports/common/guts/_exit.c b/ports/common/guts/_exit.c
new file mode 100644
index 0000000..06f2520
--- /dev/null
+++ b/ports/common/guts/_exit.c
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * void _exit(int status)
+ */
+
+	/* NOTE THAT THIS IS NEVER USED!
+	 * The hand-written _exit() in ../pseudo_wrappers.c flushes
+	 * asynchronous requests and exits directly.
+	 */
+
+	real__exit(status);
+
+/*	return;
+ * }
+ */
diff --git a/ports/common/guts/execv.c b/ports/common/guts/execv.c
index d4031b3..dc3540b 100644
--- a/ports/common/guts/execv.c
+++ b/ports/common/guts/execv.c
@@ -33,6 +33,10 @@
 	/* if exec() fails, we may end up taking signals unexpectedly...
 	 * not much we can do about that.
 	 */
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execv(file, argv);
 
diff --git a/ports/common/guts/execve.c b/ports/common/guts/execve.c
index de2f1d4..29cb637 100644
--- a/ports/common/guts/execve.c
+++ b/ports/common/guts/execve.c
@@ -27,6 +27,10 @@
 	/* if exec() fails, we may end up taking signals unexpectedly...
 	 * not much we can do about that.
 	 */
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execve(file, argv, new_environ);
 
diff --git a/ports/common/guts/execveat.c b/ports/common/guts/execveat.c
index 10e0d52..b591dc4 100644
--- a/ports/common/guts/execveat.c
+++ b/ports/common/guts/execveat.c
@@ -19,6 +19,10 @@
 	if (pseudo_has_unload(new_environ))
 		new_environ = pseudo_dropenvp(new_environ);
 
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execveat(dirfd, path, argv, new_environ, flags);
 
diff --git a/ports/common/guts/execvp.c b/ports/common/guts/execvp.c
index ffc94be..2d0c8f2 100644
--- a/ports/common/guts/execvp.c
+++ b/ports/common/guts/execvp.c
@@ -33,6 +33,10 @@
 	/* if exec() fails, we may end up taking signals unexpectedly...
 	 * not much we can do about that.
 	 */
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execvp(file, argv);
 
diff --git a/ports/common/guts/execvpe.c b/ports/common/guts/execvpe.c
index 37e4927..5fc544b 100644
--- a/ports/common/guts/execvpe.c
+++ b/ports/common/guts/execvpe.c
@@ -19,6 +19,10 @@
 	if (pseudo_has_unload(new_environ))
 		new_environ = pseudo_dropenvp(new_environ);
 
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execvpe(file, argv, new_environ);
 
diff --git a/ports/common/guts/fexecve.c b/ports/common/guts/fexecve.c
index a0162d3..8e64ae0 100644
--- a/ports/common/guts/fexecve.c
+++ b/ports/common/guts/fexecve.c
@@ -11,6 +11,10 @@
 	if (pseudo_has_unload(new_environ))
 		new_environ = pseudo_dropenvp(new_environ);
 
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_fexecve(fd, argv, new_environ);
 
diff --git a/ports/common/pseudo_wrappers.c b/ports/common/pseudo_wrappers.c
index 2ad0814..a391b48 100644
--- a/ports/common/pseudo_wrappers.c
+++ b/ports/common/pseudo_wrappers.c
@@ -445,6 +445,29 @@ execveat(int dirfd, const char *path, char *const *argv, char *const *envp, int
 	return rc;
 }
 
+/* _exit() skips destructors, so collect errors for requests sent
+ * without waiting here instead.
+ */
+void
+_exit(int status) {
+	pseudo_exit_flush();
+	if (real__exit)
+		real__exit(status);
+	syscall(SYS_exit_group, status);
+	for (;;)
+		;
+}
+
+void
+_Exit(int status) {
+	pseudo_exit_flush();
+	if (real__Exit)
+		real__Exit(status);
+	syscall(SYS_exit_group, status);
+	for (;;)
+		;
+}
+
 /* no profiling in fork because it wouldn't work anyway
  * half the time
  */
@@ -543,6 +566,17 @@ wrap_execveat(int dirfd, const char *path, char *const *argv, char *const *envp,
 	return rc;
 }
 
+/* not used, the hand-written wrappers flush and exit directly */
+static void
+wrap__exit(int status) {
+	(void) status;
+}
+
+static void
+wrap__Exit(int status) {
+	(void) status;
+}
+
 static int
 wrap_fork(void) {
 	int rc = -1;
diff --git a/ports/common/wrapfuncs.in b/ports/common/wrapfuncs.in
index 9b01bf2..10a5fae 100644
--- a/ports/common/wrapfuncs.in
+++ b/ports/common/wrapfuncs.in
@@ -10,3 +10,5 @@ int posix_spawnp(pid_t *pid, const char *file, const posix_spawn_file_actions_t
 int execvpe(const char *file, char *const *argv, char *const *envp); /* hand_wrapped=1 */
 int fexecve(int fd, char *const *argv, char *const *envp); /* hand_wrapped=1 */
 int execveat(int dirfd, const char *path, char *const *argv, char *const *envp, int flags); /* hand_wrapped=1 */
+void _exit(int status); /* hand_wrapped=1 */
+void _Exit(int status); /* hand_wrapped=1 */
diff --git a/pseudo.1 b/pseudo.1
index 2ccf6bd..2475631 100644
--- a/pseudo.1
+++ b/pseudo.1
@@ -798,6 +798,21 @@ suppresses informational messages or warnings; errors are always shown.
 The default is
 .IR info,warn,error .
 .TP 8
+.B PSEUDO_SYNC
+By default, requests whose result the client doesn't use, such as
+.IR chown(2)
+or
+.IR chmod(2) ,
+are sent to the server without waiting for it to handle them.  The
+server still handles every request in the order clients sent it, so
+other processes always see the change.  If the server asks the client
+to abort, for instance after a path mismatch, the client aborts at its
+next request that does wait for a reply, or before
+.IR exec(3)
+or exiting.  If this variable is set to a value other than 0, the
+client waits for every request, so it aborts in the call that caused
+the problem.  This is slower, but can help when debugging.
+.TP 8
 .BR PSEUDO_UIDS ,\  PSEUDO_GIDS
 These variables are used internally to pass information about the current
 emulated user and group identity from one process to another.
@@ -855,9 +870,11 @@ or debugged in that context.
 Filesystem performance is noticably worse under
 .I pseudo
 than it is otherwise.  This is probably because nearly every operation
-(other than reads and writes) involves at least one round-trip network
-communication with the server, and probably some kind of database
-activity.
+(other than reads and writes) involves a message to the server, and
+probably some kind of database activity.  Operations that ask about a
+file wait for the server's reply; ones that only report a change do not
+(see
+.BR PSEUDO_SYNC ).
 
 .SH SECURITY
 .I pseudo
diff --git a/pseudo.c b/pseudo.c
index 26c7a36..70f439d 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -1087,7 +1087,7 @@ pseudo_server_response(pseudo_msg_t *msg, const char *program, const char *tag,
 		return 0;
 		break;
 	case PSEUDO_MSG_OP:
-	case PSEUDO_MSG_FASTOP:
+	case PSEUDO_MSG_ASYNC:
 		return pseudo_op(msg, program, tag, response_path, response_len);
 		break;
 	case PSEUDO_MSG_ACK:		/* FALLTHROUGH */
diff --git a/pseudo_client.c b/pseudo_client.c
index c5b960f..79e1e29 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -53,6 +53,13 @@ static int connect_fd = -1;
 static int request_fd = -1;
 static int client_id = 0;
 static unsigned int client_serial = 0;
+/* requests that need no reply are sent without waiting.  async_pending
+ * is set while some may not have been handled yet, so their errors are
+ * collected before exec() or exit().
+ */
+static int async_pending = 0;
+static pid_t async_pid = 0;
+static int pseudo_sync_only = 0;
 static int server_pid = 0;
 int pseudo_localstate_dir_fd = -1;
 static int pseudo_pathlock_fd = -1;
@@ -454,8 +461,17 @@ pseudo_init_client(void) {
 	int need_free = 0;
 
 	pseudo_antimagic();
+	/* collect errors for requests this process sent; a forked child
+	 * leaves its parent's to the parent
+	 */
+	pseudo_client_flush();
+	async_pending = 0;
 	pseudo_new_pid();
 	client_disconnect();
+
+	env = pseudo_get_value("PSEUDO_SYNC");
+	pseudo_sync_only = env && *env && strcmp(env, "0");
+	free(env);
 #ifdef PSEUDO_PROFILING
 	if (pseudo_profile_fd > -1) {
 		close(pseudo_profile_fd);
@@ -1470,6 +1486,15 @@ pseudo_client_send(pseudo_msg_t *msg, size_t len, const char *path, int tries) {
 	return -1;
 }
 
+/* Send a request that needs no reply, without waiting for the server. */
+static void
+pseudo_client_send_async(pseudo_msg_t *msg, size_t len, const char *path) {
+	msg->type = PSEUDO_MSG_ASYNC;
+	pseudo_client_send(msg, len, path, 0);
+	async_pending = 1;
+	async_pid = getpid();
+}
+
 static pseudo_msg_t *
 pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 	pseudo_msg_t *response = 0;
@@ -1488,7 +1513,16 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 	for (; tries < PSEUDO_RETRIES; ++tries) {
 		tries = pseudo_client_send(msg, len, path, tries);
 		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "sent!\n");
-		response = pseudo_msg_receive(connect_fd);
+		/* replies come back in order, so any errors for earlier
+		 * asynchronous requests arrive first
+		 */
+		while ((response = pseudo_msg_receive(connect_fd)) != NULL &&
+		       response->type == PSEUDO_MSG_ASYNC) {
+			pseudo_debug(PDBGF_CLIENT, "error for asynchronous %s: %s\n",
+				pseudo_op_name(response->op), pseudo_res_name(response->result));
+			if (response->result == RESULT_ABORT)
+				pseudo_client_abort();
+		}
 		if (!response) {
 			pseudo_debug(PDBGF_CLIENT, "expected response did not occur; retrying\n");
 			/* the connection may be gone even though the request
@@ -1496,6 +1530,8 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 			 */
 			pseudo_client_setup();
 		} else {
+			/* everything sent before this request has been handled */
+			async_pending = 0;
 			if (response->type != PSEUDO_MSG_ACK) {
 				pseudo_debug(PDBGF_CLIENT, "got non-ack response %d\n", response->type);
 				return 0;
@@ -1511,6 +1547,34 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 	return 0;
 }
 
+/* Whether this process has asynchronous requests the server may not
+ * have handled yet.
+ */
+int
+pseudo_client_flush_needed(void) {
+	return async_pending && async_pid == getpid() && request_fd != -1;
+}
+
+/* Wait until the server has handled every asynchronous request this
+ * process sent, so any abort they caused happens before exec() or exit().
+ */
+void
+pseudo_client_flush(void) {
+	pseudo_msg_t msg;
+
+	if (!pseudo_client_flush_needed())
+		return;
+	pseudo_antimagic();
+	memset(&msg, 0, sizeof(msg));
+	msg.type = PSEUDO_MSG_PING;
+	msg.op = OP_NONE;
+	msg.client = getpid();
+	pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "flushing asynchronous requests\n");
+	pseudo_client_request(&msg, 0, NULL);
+	async_pending = 0;
+	pseudo_magic();
+}
+
 int
 pseudo_client_shutdown(int wait_on_socket) {
 	pseudo_msg_t msg;
@@ -2299,8 +2363,6 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 #ifdef PSEUDO_PROFILING
 		struct timeval tv1_ipc, tv2_ipc;
 #endif
-                if (!pseudo_op_wait(msg.op))
-                        msg.type = PSEUDO_MSG_FASTOP;
 		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "sending request [ino %llu]\n", (unsigned long long) msg.ino);
 #ifdef PSEUDO_PROFILING
 		gettimeofday(&tv1_ipc, NULL);
@@ -2308,6 +2370,8 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 		if (pseudo_local_only) {
 			/* disable server */
 			result = NULL;
+		} else if (!pseudo_sync_only && pseudo_op_async(msg.op)) {
+			pseudo_client_send_async(&msg, pathlen, path);
 		} else {
 			result = pseudo_client_request(&msg, pathlen, path);
 		}
@@ -2334,7 +2398,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 					(int) result->uid,
 					(int) result->gid);
 			}
-		} else if (msg.type != PSEUDO_MSG_FASTOP) {
+		} else if (msg.type != PSEUDO_MSG_ASYNC) {
 			pseudo_debug(PDBGF_OP, "(%d) no answer", getpid());
 		}
 	} else if (!result) {
diff --git a/pseudo_client.h b/pseudo_client.h
index ef959e6..b9a8405 100644
--- a/pseudo_client.h
+++ b/pseudo_client.h
@@ -19,6 +19,8 @@ extern void pseudo_magic(void);
 extern void pseudo_client_touchuid(void);
 extern void pseudo_client_touchgid(void);
 extern int pseudo_client_shutdown(int);
+extern void pseudo_client_flush(void);
+extern int pseudo_client_flush_needed(void);
 extern int pseudo_fd(int fd, int how);
 extern int pseudo_client_path_lock(int shared);
 extern void pseudo_client_path_unlock(int fd);
diff --git a/pseudo_server.c b/pseudo_server.c
index 6109f67..7016adc 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -508,7 +508,6 @@ serve_client(int i) {
 	if (in) {
 		char *response_path = 0;
 		size_t response_pathlen;
-		int send_response = 1;
 		pseudo_debug(PDBGF_SERVER | PDBGF_VERBOSE, "got a message (%d): %s\n", in->type, (in->pathlen ? in->path : "<no path>"));
 		/* handle incoming ping */
 		if (in->type == PSEUDO_MSG_PING && !clients[i].pid) {
@@ -570,20 +569,6 @@ serve_client(int i) {
 			} else {
 				in->pathlen = 0;
 			}
-			if (in->type == PSEUDO_MSG_FASTOP) {
-				/* respond instantly */
-				send_response = 0;
-				int t_type = in->type;
-				int t_pathlen = in->pathlen;
-				in->type = PSEUDO_MSG_ACK;
-				in->pathlen = 0;
-				if ((rc = pseudo_msg_send(clients[i].fd, in, in->pathlen, response_path)) != 0) {
-					pseudo_debug(PDBGF_SERVER, "failed to send response to client %d [%d]: %d (%s)\n",
-						i, (int) clients[i].pid, rc, strerror(errno));
-				}
-				in->type = t_type;
-				in->pathlen = t_pathlen;
-			}
 		} else {
 			/* the server's listen fd is "a client", and
 			 * so is the program connecting to request a shutdown.
@@ -621,13 +606,9 @@ serve_client(int i) {
 				die_peacefully = 1;
 			}
 		}
-		if (send_response) {
-			if ((rc = pseudo_msg_send(clients[i].fd, in, in->pathlen, response_path)) != 0) {
-				pseudo_debug(PDBGF_SERVER, "failed to send response to client %d [%d]: %d (%s)\n",
-					i, (int) clients[i].pid, rc, strerror(errno));
-			}
-		} else {
-			rc = 1;
+		if ((rc = pseudo_msg_send(clients[i].fd, in, in->pathlen, response_path)) != 0) {
+			pseudo_debug(PDBGF_SERVER, "failed to send response to client %d [%d]: %d (%s)\n",
+				i, (int) clients[i].pid, rc, strerror(errno));
 		}
 		free(response_path);
 	} else {
@@ -654,8 +635,10 @@ serve_client(int i) {
 	return rc;
 }
 
-/* Handle one request from the datagram socket, replying on the client's
- * stream connection.
+/* Handle one request from the datagram socket.  Synchronous requests
+ * (and PING, which a client uses to wait until everything it sent so far
+ * has been handled) get a reply on the client's stream connection.
+ * Asynchronous ones only get a reply if the client must abort.
  */
 static void
 serve_request(pseudo_msg_t *in) {
@@ -663,7 +646,7 @@ serve_request(pseudo_msg_t *in) {
 	char *response_path = 0;
 	size_t response_pathlen = -1;
 	int id = in->client_id;
-	int valid, rc;
+	int valid, reply = 1, rc;
 
 	gettimeofday(&tv1, NULL);
 	++messages;
@@ -681,7 +664,6 @@ serve_request(pseudo_msg_t *in) {
 		in->type = PSEUDO_MSG_ACK;
 		break;
 	case PSEUDO_MSG_OP:
-	case PSEUDO_MSG_FASTOP:
 		if (pseudo_server_response(in, valid ? clients[id].program : NULL,
 				valid ? clients[id].tag : NULL,
 				&response_path, &response_pathlen)) {
@@ -690,12 +672,18 @@ serve_request(pseudo_msg_t *in) {
 			in->type = PSEUDO_MSG_ACK;
 		}
 		break;
+	case PSEUDO_MSG_ASYNC:
+		pseudo_server_response(in, valid ? clients[id].program : NULL,
+			valid ? clients[id].tag : NULL,
+			&response_path, &response_pathlen);
+		reply = (in->result == RESULT_ABORT);
+		break;
 	default:
 		pdb_log_msg(SEVERITY_WARN, in, NULL, NULL, "invalid request type %d", in->type);
 		in->type = PSEUDO_MSG_NAK;
 		break;
 	}
-	if (valid) {
+	if (reply && valid) {
 		pseudo_debug(PDBGF_SERVER | PDBGF_VERBOSE, "response: %d (%s)\n",
 			in->result, pseudo_res_name(in->result));
 		in->client = id;
diff --git a/pseudo_util.c b/pseudo_util.c
index d9312d0..4253eaa 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -58,6 +58,7 @@ static struct pseudo_variables pseudo_env[] = {
 	{ "PSEUDO_DISABLED", 15, NULL },
 	{ "PSEUDO_UNLOAD", 13, NULL },
 	{ "PSEUDO_ALLOW_FSYNC", 18, NULL },
+	{ "PSEUDO_SYNC", 11, NULL },
 #ifdef PSEUDO_PROFILING
 	{ "PSEUDO_PROFILE_PATH", 19, NULL },
 #endif
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 13d7ede..2b1b39c 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -57,8 +57,10 @@ static pthread_mutex_t pseudo_mutex = PTHREAD_MUTEX_INITIALIZER;
 static pthread_t pseudo_mutex_holder;
 static int pseudo_mutex_recursion = 0;
 static int pseudo_getlock(void);
+static int pseudo_trylock(void);
 static void pseudo_droplock(void);
 static int pseudo_lock_held(void);
+static void pseudo_exit_flush(void);
 static size_t pseudo_dechroot(char *, size_t);
 static void pseudo_sigblock(sigset_t *);
 
@@ -67,6 +69,7 @@ static sigset_t pseudo_saved_sigmask;
 
 /* Constructor only exists in libpseudo */
 static void _libpseudo_init(void) __attribute__ ((constructor));
+static void _libpseudo_fini(void) __attribute__ ((destructor));
 
 static int _libpseudo_initted = 0;
 
@@ -119,6 +122,32 @@ _libpseudo_init(void) {
 	pseudo_droplock();
 }
 
+/* Requests that need no reply are sent without waiting, so wait at exit
+ * for the server to handle them: if one of them makes the server ask the
+ * client to abort, that happens before the process is gone.  Another
+ * thread may be blocked indefinitely inside a wrapper, holding the lock,
+ * so don't wait for the lock; that thread's next request will collect
+ * any abort if it gets one.
+ */
+static void
+pseudo_exit_flush(void) {
+	sigset_t saved;
+
+	if (!_libpseudo_initted || pseudo_disabled || !pseudo_client_flush_needed())
+		return;
+	pseudo_sigblock(&saved);
+	if (pseudo_trylock() == 0) {
+		pseudo_client_flush();
+		pseudo_droplock();
+	}
+	sigprocmask(SIG_SETMASK, &saved, NULL);
+}
+
+static void
+_libpseudo_fini(void) {
+	pseudo_exit_flush();
+}
+
 void
 pseudo_reinit_libpseudo(void) {
 	_libpseudo_init();
@@ -228,6 +257,20 @@ pseudo_getlock(void) {
 }
 
 static int
+pseudo_trylock(void) {
+	if (pthread_equal(pseudo_mutex_holder, pthread_self())) {
+		++pseudo_mutex_recursion;
+		return 0;
+	}
+	if (pthread_mutex_trylock(&pseudo_mutex) == 0) {
+		pseudo_mutex_recursion = 1;
+		pseudo_mutex_holder = pthread_self();
+		return 0;
+	}
+	return -1;
+}
+
+static int
 pseudo_lock_held(void) {
 	return pthread_equal(pseudo_mutex_holder, pthread_self());
 }
diff --git a/test/test-async-abort.c b/test/test-async-abort.c
new file mode 100644
index 0000000..d0af068
--- /dev/null
+++ b/test/test-async-abort.c
@@ -0,0 +1,44 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * chown() a file whose database entry still has another name, which makes
+ * the server tell the client to abort.  Prints "returned" if chown()
+ * returns, then does one of the following, which must deliver the abort
+ * if chown() didn't:
+ *   stat     a synchronous request
+ *   _exit    leave without running destructors
+ *   execvpe  run another program
+ *
+ * usage: test-async-abort <path> <stat|_exit|execvpe>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+
+int
+main(int argc, char **argv) {
+	struct stat st;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s <path> <stat|_exit|execvpe>\n", argv[0]);
+		return 2;
+	}
+	if (chown(argv[1], 1234, 5678) == -1)
+		perror("chown");
+	printf("returned\n");
+	fflush(stdout);
+	if (!strcmp(argv[2], "_exit")) {
+		_exit(0);
+	} else if (!strcmp(argv[2], "execvpe")) {
+		char *args[] = { "true", NULL };
+		char *env[] = { NULL };
+		execvpe("true", args, env);
+		perror("execvpe");
+		return 2;
+	}
+	(void) stat(".", &st);
+	printf("survived\n");
+	return 0;
+}
diff --git a/test/test-async-abort.sh b/test/test-async-abort.sh
new file mode 100755
index 0000000..53cef39
--- /dev/null
+++ b/test/test-async-abort.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# A chown() whose database entry has another name makes the server tell
+# the client to abort.  chown() is sent without waiting, so the client
+# must still abort: at its next request that waits for a reply, or when
+# it leaves with _exit() or execs another program.  With PSEUDO_SYNC set,
+# it must abort inside chown() itself.
+#
+# The temporary tree has to live below $PWD so that pseudo tracks it.
+
+tmpdir="$(mktemp -d -p "$PWD" async_abort_XXXXXX)"
+trap "rm -rf '$tmpdir'" EXIT TERM INT
+
+rc=0
+check() {
+    local sync="$1" how="$2" expect="$3" out status
+    : > "$tmpdir/a"
+    # rename it behind pseudo's back, so the database still says "a"
+    PSEUDO_DISABLED=1 mv "$tmpdir/a" "$tmpdir/b"
+    out=$(PSEUDO_SYNC=$sync ./test/test-async-abort "$tmpdir/b" "$how" 2>/dev/null)
+    status=$?
+    # put the name back so the database entry can be removed cleanly
+    PSEUDO_DISABLED=1 mv "$tmpdir/b" "$tmpdir/a"
+    rm -f "$tmpdir/a"
+    if [ $status -ne 134 ]; then
+        echo "FAILED: $how: expected abort (PSEUDO_SYNC=${sync:-unset}), got status $status"
+        rc=1
+    elif [ "$out" != "$expect" ]; then
+        echo "FAILED: $how: PSEUDO_SYNC=${sync:-unset}: expected output '$expect', got '$out'"
+        rc=1
+    fi
+}
+
+for how in stat _exit execvpe; do
+    check "" $how "returned"
+done
+check 1 stat ""
+exit $rc
diff --git a/test/test-async-order.c b/test/test-async-order.c
new file mode 100644
index 0000000..72d16b0
--- /dev/null
+++ b/test/test-async-order.c
@@ -0,0 +1,188 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * chown() and chmod() are sent to the server without waiting for a reply.
+ * Check that another process never sees the old ownership or mode once it
+ * has been told, through a pipe or by the process exiting, that the change
+ * was made.
+ *
+ * usage: test-async-order <directory> <count>
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+static char *dir;
+static int count;
+#define WRITERS 8
+
+static void
+name(char *buf, size_t len, int i) {
+	snprintf(buf, len, "%s/f%d", dir, i);
+}
+
+static mode_t
+mode_for(int i) {
+	return (i % 2) ? 0640 : 0604;
+}
+
+static int
+check(int i, int want_mode) {
+	char path[4096];
+	struct stat st;
+
+	name(path, sizeof(path), i);
+	if (stat(path, &st) == -1) {
+		fprintf(stderr, "stat %s: %s\n", path, strerror(errno));
+		return 1;
+	}
+	if (st.st_uid != (uid_t) (1000 + i) || st.st_gid != (gid_t) (2000 + i) ||
+	    (want_mode && (st.st_mode & 07777) != mode_for(i))) {
+		fprintf(stderr, "%s: got %d:%d mode %o, expected %d:%d mode %o\n",
+			path, (int) st.st_uid, (int) st.st_gid,
+			(unsigned) (st.st_mode & 07777), 1000 + i, 2000 + i,
+			want_mode ? (unsigned) mode_for(i) : 0);
+		return 1;
+	}
+	return 0;
+}
+
+static void
+chown_one(int i) {
+	char path[4096];
+
+	name(path, sizeof(path), i);
+	if (chown(path, 1000 + i, 2000 + i) == -1) {
+		perror("chown");
+		_exit(2);
+	}
+}
+
+/* Each change is handed on through a pipe to a process that is already
+ * running: chown in one process, chmod in a second, stat in a third.
+ */
+static int
+pipe_chain(void) {
+	int p12[2], p23[2];
+	pid_t c2, c3;
+	int i, bad = 0, status;
+
+	if (pipe(p12) == -1 || pipe(p23) == -1) {
+		perror("pipe");
+		return 2;
+	}
+	c2 = fork();
+	if (c2 == 0) {
+		char path[4096];
+		close(p12[1]);
+		close(p23[0]);
+		while (read(p12[0], &i, sizeof(i)) == sizeof(i)) {
+			name(path, sizeof(path), i);
+			if (chmod(path, mode_for(i)) == -1) {
+				perror("chmod");
+				_exit(2);
+			}
+			if (write(p23[1], &i, sizeof(i)) != sizeof(i))
+				_exit(2);
+		}
+		_exit(0);
+	}
+	c3 = fork();
+	if (c3 == 0) {
+		close(p12[0]);
+		close(p12[1]);
+		close(p23[1]);
+		while (read(p23[0], &i, sizeof(i)) == sizeof(i))
+			bad += check(i, 1);
+		_exit(bad ? 1 : 0);
+	}
+	close(p12[0]);
+	close(p23[0]);
+	close(p23[1]);
+	/* send all the changes in a burst before handing them on, newest
+	 * first, so the others ask about changes still queued behind
+	 * older ones
+	 */
+	for (i = 0; i < count; ++i)
+		chown_one(i);
+	for (i = count - 1; i >= 0; --i) {
+		if (write(p12[1], &i, sizeof(i)) != sizeof(i)) {
+			perror("write");
+			return 2;
+		}
+	}
+	close(p12[1]);
+	if (waitpid(c2, &status, 0) == -1 || !WIFEXITED(status) || WEXITSTATUS(status))
+		bad = 1;
+	if (waitpid(c3, &status, 0) == -1 || !WIFEXITED(status) || WEXITSTATUS(status))
+		bad = 1;
+	return bad;
+}
+
+/* Several children change their files at once, so the server has a
+ * backlog from each, and leave with _exit(), which skips the exit-time
+ * flush.  The parent checks, newest change first, as soon as they have
+ * all been reaped.
+ */
+static int
+exit_handoff(void) {
+	pid_t c[WRITERS];
+	int i, w, bad = 0, status;
+
+	for (w = 0; w < WRITERS; ++w) {
+		c[w] = fork();
+		if (c[w] == 0) {
+			for (i = 0; i < count; ++i)
+				chown_one(count * (w + 1) + i);
+			_exit(0);
+		}
+	}
+	for (w = 0; w < WRITERS; ++w) {
+		if (waitpid(c[w], &status, 0) == -1 || !WIFEXITED(status) || WEXITSTATUS(status))
+			bad = 2;
+	}
+	if (bad)
+		return bad;
+	for (i = count * (WRITERS + 1) - 1; i >= count; --i)
+		bad += check(i, 0);
+	return bad ? 1 : 0;
+}
+
+int
+main(int argc, char **argv) {
+	char path[4096];
+	int i, fd, rc;
+
+	if (argc != 3) {
+		fprintf(stderr, "usage: %s <directory> <count>\n", argv[0]);
+		return 2;
+	}
+	dir = argv[1];
+	count = atoi(argv[2]);
+	for (i = 0; i < count * (WRITERS + 1); ++i) {
+		name(path, sizeof(path), i);
+		fd = open(path, O_CREAT | O_WRONLY, 0600);
+		if (fd == -1) {
+			perror(path);
+			return 2;
+		}
+		close(fd);
+	}
+	rc = pipe_chain();
+	if (rc) {
+		fprintf(stderr, "pipe hand-off failed\n");
+		return rc;
+	}
+	rc = exit_handoff();
+	if (rc) {
+		fprintf(stderr, "exit hand-off failed\n");
+		return rc;
+	}
+	return 0;
+}
diff --git a/test/test-async-order.sh b/test/test-async-order.sh
new file mode 100755
index 0000000..5dee635
--- /dev/null
+++ b/test/test-async-order.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Ownership and mode changes are sent to the server without waiting for a
+# reply.  Another process that learns of a change, through a pipe or by
+# reaping the process that made it, must see the new values.  Run it
+# both with and without PSEUDO_SYNC, which makes every request wait.
+#
+# The temporary tree has to live below $PWD so that pseudo tracks it.
+
+tmpdir="$(mktemp -d -p "$PWD" async_order_XXXXXX)"
+trap "rm -rf '$tmpdir'" EXIT TERM INT
+
+rc=0
+for sync in "" 1; do
+    rm -f "$tmpdir"/f*
+    if ! PSEUDO_SYNC=$sync ./test/test-async-order "$tmpdir" 500; then
+        echo "FAILED: ordering broken (PSEUDO_SYNC=${sync:-unset})"
+        rc=1
+    fi
+done
+exit $rc
-- 
1.8.3.1

