Received: from BN1PR04CU002.outbound.protection.outlook.com (BN1PR04CU002.outbound.protection.outlook.com [52.101.56.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6217.1795472861692492157
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 14:27:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=T2xC49TZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.56.16, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5lJQaNLaYrERxQh6m7KjC/wKa7v95D3bz3plmPZXgKv8YjI3fI6d2UsvJ36PEhoNTeiXqCOz7SpeVObSvXZp1nTnH6g9Ba7DDGDtRt2KtaafYZ3AeRC5c3XIiqtXcjfoo4p4DSYcmMihcwK0+80G/14BHytZDeqKZdVF5ygoQuCIpzMi/JjGDMMeYxTBDL6kX29yKwEMSfFyOXvaWTYNGrXgu7jA6WQlQSMs+47tCUdhDTZ1fJlvZ7NtExkbEnAbjI1o54OBkfPBM1qN4axl446D8EdbXvIAlkokyeacf7gQgE8yLLT+O2IbIpSfwJ8Gj3M/tE5D0eB8S50XmmvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6UPCBporWndRC49x+pbyWDxYCbDBoL+D+HP08Wxwpk=;
 b=JnnBt48HcE/nN42DN3/KkmM6mWDk0lLzjlLyGPRK9gGX0WyHP5XwFI9gEK3yrdlBAJVxxAEChf5zLH/E8NJoYVNNUEbiSQvberDajvHtX45vAzkX4rHLBMpWFiiZ8o6UvB2KiTt4WZexNIoAMoZKw371EShHyyWbKULZFMzZft1lTK7/PXooef8ANRUlsHhdbqaDc4o8Gjs1kT9OLC2YrQ6WH5xQctWkKM3V01Ik+jTnzgcItUdvHC3mpVpDgs1rcMYaYDPnAAflf3iLd9W4eySkB/iTI4RtIjIeuiXEqARWq8T2MhMGX5dcRPaEhqzRnXajcjqYTivQu7AzmvPrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6UPCBporWndRC49x+pbyWDxYCbDBoL+D+HP08Wxwpk=;
 b=T2xC49TZgeH+R1yAw0GEwN5k4Wo3MQ2Jnm1DqyhxxrUoNd5OfAt4vDS76xG5ER2FtEBSco8Yv+SP5tHJIxGPXwVgMI1rhy4VvgdMgtU6yUG1jp9sg/BJPKVHaVmIhcT6RohZmdizG6n1OhmGvgcpvz5ahH3kRFsOsXD2McbpaD0=
Received: from BN0PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:143::10)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 22:27:31 +0000
Received: from BN3PEPF00022BD5.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::42) by BN0PR10CA0012.outlook.office365.com
 (2603:10b6:408:143::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 22:27:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD5.mail.protection.outlook.com (10.167.248.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 22:27:31 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 16:27:29 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 16:27:29 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 1/2] Send client requests over one shared datagram socket
Date: Mon, 23 Nov 2026 15:27:27 -0700
Message-ID: <20261123222728.2343685-2-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123222728.2343685-1-mark.hatle@amd.com>
References: <20261123222728.2343685-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD5:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c5070c-7cab-404f-d268-08df49b0f6b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|11063799006|56012099006|261021123027099003|261022105027099003|261021130227099003|261021133027099003|261022113327099003|261022115727099003|261021121427099003|261009223027099003|261021135927099003|261026121527099003|261022075727099003|261026130827099003|261102123227099003|261026135527099003|261026140227099003|261028144727099003|20046099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: gJbL1QyBXChcAsG0EdAg151AdYzDphV+IUzshLA8lEJo+FqCmi5dyF+MI6yahnCzImcLsPsh4L2F69vcFa/bvhPucTVy6OCLy0ZUvPsNoCWvl6bHDSx9QDXHokIcg0NXVcqftaKNukfuqU63RbVd317WIkUk1hNDXUpiqmTfSZqbWNbtOKBzJxtfayDdQDHOOW2LM3PE9g2Cj39S4xcTM/heabPBv5xdsdhThB2/fuucgimTs2jWB+0GKgLBN3OwtE58kkcZA+q4S+Qvw4H1W3M6EeL70xaoBSj7AgnqO2S/f16ck1qUyv8t2d+uemzXiNIW3ASCFs+zJSUTesBVHNf+V2esw1j8fHpY30y8GE9zN+fOmq+t2uKuzY6lVkqYCY0A9Y8NId4uoo+iH+9mSDsCRWkcNcwSreVx08uZzQc/UBGPfyeMMrP4KjS5zTrweICnVIVjgu9ZeT2v5DQUdfZdd/S5YBY4S/45L2MaguKnfjwbLPmgbWhnOaiyOWdZrYTV2Xq0c1rPdu6NQNZ2YoBmGaBl8s64Otg06xsJsK8Vb/fv+VPMEaJ1Qna3fNWJbXbsrDPLLmNGDd7ooOMmcD5XnTBd7r6j1TvkSDGtVyo3NVxyW9FUy6JsirKgi8OhDjLbiT1e77gZzsZgEDMYqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261021123027099003)(261022105027099003)(261021130227099003)(261021133027099003)(261022113327099003)(261022115727099003)(261021121427099003)(261009223027099003)(261021135927099003)(261026121527099003)(261022075727099003)(261026130827099003)(261102123227099003)(261026135527099003)(261026140227099003)(261028144727099003)(20046099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ThzJq1bnnM/334Hhdz1aqoIgbnrUHTZ9l/3DFTd/A2ZlZUhCp9GFTx+UKoPwfkF8S3uXcbcITRKNZ6UUejqLJS9jBjDUaSDT3jU/MbWHEFmO7Hzk9BIfyLWiCwUZeecZkQjw60f8JIBDPjdHnHuo2IpDrSAkPpLp4IwxDKPwsBxlIKmBx0yrGZdc9+ay85YInWnwyHupYSL7+kWjYBFucJt3qWIXNIHKNd3Q1zZzRnt57FWwTGrR46yXV/jE8rTKnNvz0+2+4j3rAr/Ct+yTDXHKrzCfWkaymwu4YuwXZXqMFDFYX40V2uqqx+ABYs10/DWONbJOHzVLuuHxkTllK2przJ1Ma1/HyUmhCtMcryaFwnNBkkxc4vO3eHaoCb+J3SOUN1NNIxuldDlA3FnO/cJSLa7yBHdTwHN1OI85PDtlQ4p33e3bX9sHV47iXEHs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:27:31.1788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c5070c-7cab-404f-d268-08df49b0f6b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 22:27:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5494
Content-Type: text/plain; charset="utf-8"

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
 doc/pseudo_ipc  |  36 +++++++++++
 pseudo.h        |   1 +
 pseudo_client.c | 158 ++++++++++++++++++++++++++++++++++--------------
 pseudo_ipc.c    |  42 +++++++++++++
 pseudo_ipc.h    |   8 +++
 pseudo_server.c | 154 +++++++++++++++++++++++++++++++++++++++++++++-
 8 files changed, 356 insertions(+), 50 deletions(-)

diff --git a/README.security b/README.security
index 4067f96..d58f7d3 100644
--- a/README.security
+++ b/README.security
@@ -147,9 +147,9 @@ ignore mismatch errors in pseudo's log.
=20
 6. THE SERVER TRUSTS ITS CLIENTS
=20
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
=20
 Underlying this is access to a server process, which is automatically
 spawned by the library if one is not available.  The server process mainta=
ins
-a UNIX domain socket while it is active, and maintains a database (using
+UNIX domain sockets while it is active (see doc/pseudo_ipc), and maintains=
 a
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
=20
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
=20
@@ -44,6 +69,11 @@ only sends PING, OP, or FASTOP.  FASTOP is used for oper=
ations whose result
 the client doesn't need, but the server still replies with ACK (or NAK on
 failure) and the client still waits for that reply.
=20
+A PING on the stream socket registers the client: the reply gives it the
+client_id and client_serial to put in its requests.  A PING on the
+request socket is answered once every request the client sent before it
+has been handled.
+
 When run with '-S', the pseudo program
 runs as a client, sending a SHUTDOWN message to a server -- but only if
 it can find one, it does not start a new one.  In this case, the server
@@ -84,6 +114,12 @@ deleting carries the database's "deleting" mark (see do=
c/database) when
 the server looks up file entries.  The server uses it internally; the
 client doesn't set or use it.
=20
+client_id and client_serial identify the client's stream connection in
+requests on the shared socket, so the server knows where to reply.  The
+server numbers every connection, so a request still queued from a client
+that has gone away is never answered on a connection that has since
+reused its client_id; the server applies it without replying.
+
 32/64 bit:  This structure should have the same offsets for every element,
 including path, on both 64-bit and 32-bit machines.  (Check with 'offsets.=
c'.)
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
=20
 #define PSEUDO_SEVERITY_DEFAULT "info,warn,error"
=20
diff --git a/pseudo_client.c b/pseudo_client.c
index 3d86768..dc3ce1f 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -46,6 +46,13 @@ static char *program_invocation_name =3D "unknown";
 static char *base_path(int dirfd, const char *path, int leave_last);
=20
 static int connect_fd =3D -1;
+/* Requests go to the server over a datagram socket shared by all
+ * clients, so the server handles them in the order they were sent even
+ * across processes; replies come back on connect_fd.  See pseudo_server.c=
.
+ */
+static int request_fd =3D -1;
+static int client_id =3D 0;
+static unsigned int client_serial =3D 0;
 static int server_pid =3D 0;
 int pseudo_localstate_dir_fd =3D -1;
 static int pseudo_pathlock_fd =3D -1;
@@ -429,6 +436,18 @@ pseudo_profile_report(void) {
 }
 #endif
=20
+static void
+client_disconnect(void) {
+	if (connect_fd !=3D -1) {
+		close(connect_fd);
+		connect_fd =3D -1;
+	}
+	if (request_fd !=3D -1) {
+		close(request_fd);
+		request_fd =3D -1;
+	}
+}
+
 void
 pseudo_init_client(void) {
 	char *env;
@@ -436,10 +455,7 @@ pseudo_init_client(void) {
=20
 	pseudo_antimagic();
 	pseudo_new_pid();
-	if (connect_fd !=3D -1) {
-		close(connect_fd);
-		connect_fd =3D -1;
-	}
+	client_disconnect();
 #ifdef PSEUDO_PROFILING
 	if (pseudo_profile_fd > -1) {
 		close(pseudo_profile_fd);
@@ -1136,6 +1152,8 @@ client_ping(void) {
 		server_pid =3D 0;
 		return 1;
 	} else {
+		client_id =3D ack->client_id;
+		client_serial =3D ack->client_serial;
                 /* The server tells us whether or not to log things. */
                 if (ack->result =3D=3D RESULT_SUCCEED) {
                         pseudo_client_logging =3D 1;
@@ -1280,6 +1298,7 @@ static int
 client_connect(void) {
 	/* we have a server pid, is it responsive? */
 	struct sockaddr_un sun =3D { .sun_family =3D AF_UNIX };
+	struct sockaddr_un req_sun =3D { .sun_family =3D AF_UNIX };
 	struct stat st;
 	int cwd_fd =3D -1;
 	int use_chdir;
@@ -1295,13 +1314,19 @@ client_connect(void) {
 	len =3D snprintf(sun.sun_path, sizeof(sun.sun_path), "/proc/self/fd/%d",
 		pseudo_localstate_dir_fd);
 	if (len > 0 && (size_t) len + 1 + strlen(PSEUDO_SOCKET) < sizeof(sun.sun_=
path) &&
+	    (size_t) len + 1 + strlen(PSEUDO_REQUEST_SOCKET) < sizeof(req_sun.sun=
_path) &&
 	    stat(sun.sun_path, &st) =3D=3D 0 && S_ISDIR(st.st_mode)) {
+		memcpy(req_sun.sun_path, sun.sun_path, len);
+		snprintf(req_sun.sun_path + len, sizeof(req_sun.sun_path) - len, "/%s",
+			PSEUDO_REQUEST_SOCKET);
 		snprintf(sun.sun_path + len, sizeof(sun.sun_path) - len, "/%s",
 			PSEUDO_SOCKET);
 		use_chdir =3D 0;
 	} else {
 		pseudo_debug(PDBGF_CLIENT, "/proc/self/fd unusable or path too long, cha=
nging directory to connect.\n");
 		snprintf(sun.sun_path, sizeof(sun.sun_path), "%s", PSEUDO_SOCKET);
+		snprintf(req_sun.sun_path, sizeof(req_sun.sun_path), "%s",
+			PSEUDO_REQUEST_SOCKET);
 		use_chdir =3D 1;
 	}
=20
@@ -1349,6 +1374,23 @@ client_connect(void) {
 		connect_fd =3D -1;
 		return 1;
 	}
+	request_fd =3D pseudo_fd(socket(PF_UNIX, SOCK_DGRAM, 0), MOVE_FD);
+	if (request_fd =3D=3D -1 ||
+	    connect(request_fd, (struct sockaddr *) &req_sun, sizeof(req_sun)) =
=3D=3D -1) {
+		char *e =3D strerror(errno);
+		pseudo_debug(PDBGF_CLIENT, "Can't connect request socket to %s: (%s)\n",
+			req_sun.sun_path, e);
+		pseudo_evlog(PDBGF_CLIENT, "request socket connect failed: %s\n", e);
+		client_disconnect();
+		if (use_chdir) {
+			if (fchdir(cwd_fd) =3D=3D -1) {
+				pseudo_error("return to previous directory failed: %s\n",
+					strerror(errno));
+			}
+			close(cwd_fd);
+		}
+		return 1;
+	}
 	if (use_chdir) {
 		if (fchdir(cwd_fd) =3D=3D -1) {
 			pseudo_error("return to previous directory failed: %s\n",
@@ -1368,10 +1410,7 @@ pseudo_client_setup(void) {
 	server_pid =3D 0;
=20
 	/* avoid descriptor leak, I hope */
-	if (connect_fd >=3D 0) {
-		close(connect_fd);
-		connect_fd =3D -1;
-	}
+	client_disconnect();
 	if (client_connect() =3D=3D 0) {
 		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "connection started.\n");
 		if (client_ping() =3D=3D 0) {
@@ -1382,8 +1421,7 @@ pseudo_client_setup(void) {
 			/* and now we'll close the connection, and try to
 			 * kick the server.
 			 */
-			close(connect_fd);
-			connect_fd =3D -1;
+			client_disconnect();
 		}
 	}
 	pseudo_debug(PDBGF_CLIENT, "connection failed, checking server...\n");
@@ -1436,8 +1474,7 @@ pseudo_client_setup(void) {
 			} else {
 				pseudo_debug(PDBGF_CLIENT, "ping failed to restarted server.\n");
 				pseudo_evlog(PDBGF_CLIENT, "ping failed to restarted server.\n");
-				close(connect_fd);
-				connect_fd =3D -1;
+				client_disconnect();
 				return 1;
 			}
 		} else {
@@ -1449,11 +1486,57 @@ pseudo_client_setup(void) {
 }
=20
 #define PSEUDO_RETRIES 250
+
+static void
+pseudo_client_abort(void) {
+	char *local_state_dir =3D pseudo_get_value("PSEUDO_LOCALSTATEDIR");
+	pseudo_info("abort()ing pseudo client by server request. See https://wiki=
.yoctoproject.org/wiki/Pseudo_Abort for more details on this.\n"
+		"Check logfile: %s/%s\n", local_state_dir, PSEUDO_LOGFILE);
+	abort();
+}
+
+/* Send a request over the request socket, reconnecting to (or starting)
+ * the server if that fails.  Returns 0 once sent.
+ */
+static int
+pseudo_client_send(pseudo_msg_t *msg, size_t len, const char *path, int tr=
ies) {
+	int rc;
+
+	for (; tries < PSEUDO_RETRIES; ++tries) {
+		pseudo_evlog(PDBGF_CLIENT, "try %d, request fd is %d\n", tries, request_=
fd);
+		msg->client_id =3D client_id;
+		msg->client_serial =3D client_serial;
+		rc =3D pseudo_msg_send(request_fd, msg, len, path);
+		if (rc =3D=3D 0)
+			return tries;
+		pseudo_evlog(PDBGF_CLIENT, "msg_send failed [%d].\n", rc);
+		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "msg_send: %d%s\n",
+			rc,
+			rc =3D=3D -1 ? " (sigpipe)" :
+				   " (short write)");
+		pseudo_debug(PDBGF_CLIENT, "trying to get server, try %d\n", tries);
+		/* try to open server; if we fail, wait a bit before
+		 * retry.
+		 */
+		if (pseudo_client_setup()) {
+			int ms =3D (getpid() % 5) + (3 * tries);
+			struct timespec delay =3D { .tv_sec =3D 0, .tv_nsec =3D ms * 1000000 };
+			pseudo_evlog(PDBGF_CLIENT, "setup failed, delaying %d ms.\n", ms);
+			nanosleep(&delay, NULL);
+		} else {
+			pseudo_evlog(PDBGF_CLIENT, "setup apparently successful, retrying messa=
ge immediately.\n");
+		}
+	}
+	pseudo_error("pseudo: server connection persistently failed, aborting.\n"=
);
+	pseudo_evlog_dump();
+	pseudo_critical("event log dumped, aborting.\n");
+	return -1;
+}
+
 static pseudo_msg_t *
 pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 	pseudo_msg_t *response =3D 0;
 	int tries =3D 0;
-	int rc;
=20
 	if (!msg)
 		return 0;
@@ -1465,36 +1548,16 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len=
, const char *path) {
 	 */
 	pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "sending a message: ino %llu\n=
",
 		(unsigned long long) msg->ino);
-        for (tries =3D 0; tries < PSEUDO_RETRIES; ++tries) {
-		pseudo_evlog(PDBGF_CLIENT, "try %d, connect fd is %d\n", tries, connect_=
fd);
-		rc =3D pseudo_msg_send(connect_fd, msg, len, path);
-		if (rc !=3D 0) {
-			pseudo_evlog(PDBGF_CLIENT, "msg_send failed [%d].\n", rc);
-			pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "msg_send: %d%s\n",
-				rc,
-				rc =3D=3D -1 ? " (sigpipe)" :
-					   " (short write)");
-			pseudo_debug(PDBGF_CLIENT, "trying to get server, try %d\n", tries);
-			/* try to open server; if we fail, wait a bit before
-			 * retry.
-			 */
-			if (pseudo_client_setup()) {
-				int ms =3D (getpid() % 5) + (3 * tries);
-				struct timespec delay =3D { .tv_sec =3D 0, .tv_nsec =3D ms * 1000000 }=
;
-				pseudo_evlog(PDBGF_CLIENT, "setup failed, delaying %d ms.\n", ms);
-				nanosleep(&delay, NULL);
-			} else {
-				pseudo_evlog(PDBGF_CLIENT, "setup apparently successful, retrying mess=
age immediately.\n");
-			}
-			continue;
-		}
-		/* note "continue" above; we only get here if rc was 0,
-		 * indicating a successful send.
-		 */
+	for (; tries < PSEUDO_RETRIES; ++tries) {
+		tries =3D pseudo_client_send(msg, len, path, tries);
 		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "sent!\n");
 		response =3D pseudo_msg_receive(connect_fd);
 		if (!response) {
 			pseudo_debug(PDBGF_CLIENT, "expected response did not occur; retrying\n=
");
+			/* the connection may be gone even though the request
+			 * socket still works, so reconnect before resending
+			 */
+			pseudo_client_setup();
 		} else {
 			if (response->type !=3D PSEUDO_MSG_ACK) {
 				pseudo_debug(PDBGF_CLIENT, "got non-ack response %d\n", response->type=
);
@@ -2179,6 +2242,8 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
 			startfd =3D pseudo_grp_fd + 1;
 		if (connect_fd >=3D startfd)
 			startfd =3D connect_fd + 1;
+		if (request_fd >=3D startfd)
+			startfd =3D request_fd + 1;
 		/* the fds below startfd are the ones our own are mixed in
 		 * with, so close those by hand and skip the ones we need
 		 */
@@ -2187,7 +2252,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
 					i =3D=3D pseudo_localstate_dir_fd || i =3D=3D pseudo_pathlock_fd ||
 					i =3D=3D pseudo_pwd_fd ||
 					i =3D=3D pseudo_pwd_lck_fd || i =3D=3D pseudo_grp_fd ||
-					i =3D=3D connect_fd)
+					i =3D=3D connect_fd || i =3D=3D request_fd)
 				continue;
 			pseudo_client_close(i);
 			close(i);
@@ -2207,6 +2272,11 @@ pseudo_client_op(pseudo_op_t op, int access, int fd,=
 int dirfd, const char *path
 				if (connect_fd =3D=3D -1) {
 					pseudo_error("tried to close connection, couldn't dup: %s\n", strerro=
r(errno));
 				}
+			} else if (fd =3D=3D request_fd) {
+				request_fd =3D pseudo_fd(request_fd, COPY_FD);
+				if (request_fd =3D=3D -1) {
+					pseudo_error("tried to close request socket, couldn't dup: %s\n", str=
error(errno));
+				}
 			} else if (fd =3D=3D pseudo_util_debug_fd || fd =3D=3D pseudo_util_evlo=
g_fd) {
 				/* both are stderr by default */
 				int newfd =3D pseudo_fd(fd, COPY_FD);
@@ -2312,12 +2382,8 @@ pseudo_client_op(pseudo_op_t op, int access, int fd,=
 int dirfd, const char *path
 #endif
 		if (result) {
 			pseudo_debug(PDBGF_OP, "(%d) %s", getpid(), pseudo_res_name(result->res=
ult));
-			if (result->result =3D=3D RESULT_ABORT) {
-				char *local_state_dir =3D pseudo_get_value("PSEUDO_LOCALSTATEDIR");
-				pseudo_info("abort()ing pseudo client by server request. See https://w=
iki.yoctoproject.org/wiki/Pseudo_Abort for more details on this.\n"
-					"Check logfile: %s/%s\n", local_state_dir, PSEUDO_LOGFILE);
-				abort();
-			}
+			if (result->result =3D=3D RESULT_ABORT)
+				pseudo_client_abort();
 			if (op =3D=3D OP_STAT || op =3D=3D OP_FSTAT) {
 				pseudo_debug(PDBGF_OP, " mode 0%o uid %d:%d",
 					(int) result->mode,
diff --git a/pseudo_ipc.c b/pseudo_ipc.c
index e51fe0e..e3dd064 100644
--- a/pseudo_ipc.c
+++ b/pseudo_ipc.c
@@ -188,6 +188,48 @@ pseudo_msg_receive(int fd) {
 	return incoming;
 }
=20
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
+		incoming =3D malloc(PSEUDO_MAX_REQUEST + 1);
+		if (!incoming) {
+			pseudo_error("Couldn't allocate request buffer.\n");
+			return 0;
+		}
+	}
+	errno =3D 0;
+	r =3D recv(fd, incoming, PSEUDO_MAX_REQUEST, MSG_DONTWAIT | MSG_TRUNC);
+	if (r =3D=3D -1) {
+		if (errno !=3D EAGAIN && errno !=3D EWOULDBLOCK)
+			pseudo_debug(PDBGF_IPC, "request recv failed: %s\n", strerror(errno));
+		return 0;
+	}
+	if (r > PSEUDO_MAX_REQUEST) {
+		pseudo_error("dropped oversized request (%ld bytes).\n", (long) r);
+		errno =3D EBADMSG;
+		return 0;
+	}
+	if (r < (ssize_t) PSEUDO_HEADER_SIZE ||
+	    (size_t) r !=3D PSEUDO_HEADER_SIZE + incoming->pathlen) {
+		pseudo_error("dropped malformed request (%ld bytes).\n", (long) r);
+		errno =3D EBADMSG;
+		return 0;
+	}
+	pseudo_debug(PDBGF_IPC, "got request, type %d, pathlen %d\n", incoming->t=
ype, (int) incoming->pathlen);
+	((char *) incoming)[r] =3D '\0';
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
=20
@@ -47,7 +49,13 @@ extern int pseudo_access_fopen(const char *);
=20
 #define PSEUDO_HEADER_SIZE (offsetof(pseudo_msg_t, path))
=20
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
index 0a30b27..89a81f2 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -41,6 +41,7 @@ typedef struct {
 	pid_t pid;
 	char *tag;
 	char *program;
+	unsigned int serial;
 } pseudo_client_t;
=20
 pseudo_client_t *clients;
@@ -51,6 +52,19 @@ pseudo_client_t *clients;
  */
 static int active_clients =3D 0, highest_client =3D 0, max_clients =3D 0;
=20
+/* Clients send all requests over one datagram socket, so the server
+ * handles them in the order they were sent, even across clients: once
+ * one client's send returns, its request is queued ahead of anything
+ * another client sends afterwards.  Replies go back over each client's
+ * stream connection, which also carries the initial ping, shutdown
+ * requests, and tells us when the client goes away.  Each connection
+ * gets a serial number so a request from a client that has since gone
+ * away is never answered on a reused client slot.
+ */
+static int request_fd =3D -1;
+static unsigned int next_serial =3D 0;
+#define REQUEST_EVENT ((uint64_t) -1)
+
 #define LOOP_DELAY 2
 #define DEFAULT_PSEUDO_SERVER_TIMEOUT 30
 #define EPOLL_MAX_EVENTS 10
@@ -411,6 +425,34 @@ pseudo_server_start(int daemonize) {
 		pseudo_error("couldn't listen on socket: %s\n", strerror(errno));
 		exit(PSEUDO_EXIT_SOCKET_LISTEN);
 	}
+
+	request_fd =3D socket(PF_UNIX, SOCK_DGRAM, 0);
+	if (request_fd < 0) {
+		pseudo_error("couldn't create request socket: %s\n", strerror(errno));
+		exit(PSEUDO_EXIT_SOCKET_CREATE);
+	}
+	if (request_fd <=3D 2) {
+		newfd =3D fcntl(request_fd, F_DUPFD, 3);
+		if (newfd < 0) {
+			pseudo_error("couldn't dup request socket: %s\n", strerror(errno));
+			exit(PSEUDO_EXIT_SOCKET_FD);
+		}
+		close(request_fd);
+		request_fd =3D newfd;
+	}
+	rc =3D unlink(PSEUDO_REQUEST_SOCKET);
+	if (rc =3D=3D -1 && errno !=3D ENOENT) {
+		pseudo_error("Can't unlink existing request socket: %s.\n",
+			strerror(errno));
+		exit(PSEUDO_EXIT_SOCKET_UNLINK);
+	}
+	{
+		struct sockaddr_un req_sun =3D { .sun_family =3D AF_UNIX, .sun_path =3D =
PSEUDO_REQUEST_SOCKET };
+		if (bind(request_fd, (struct sockaddr *) &req_sun, sizeof(req_sun)) =3D=
=3D -1) {
+			pseudo_error("couldn't bind request socket: %s\n", strerror(errno));
+			exit(PSEUDO_EXIT_SOCKET_BIND);
+		}
+	}
 	rc =3D pseudo_server_write_pid(getpid());
 	if (rc !=3D 0) {
 		pseudo_warning("couldn't write pid file.\n");
@@ -449,6 +491,7 @@ open_client(int fd) {
 			clients[i].pid =3D 0;
 			clients[i].tag =3D NULL;
 			clients[i].program =3D NULL;
+			clients[i].serial =3D ++next_serial;
 			++active_clients;
 			if (i > highest_client)
 				highest_client =3D i;
@@ -472,6 +515,7 @@ open_client(int fd) {
 		clients[max_clients].pid =3D 0;
 		clients[max_clients].tag =3D NULL;
 		clients[max_clients].program =3D NULL;
+		clients[max_clients].serial =3D ++next_serial;
 		highest_client =3D max_clients;
=20
 		max_clients +=3D 16;
@@ -556,6 +600,11 @@ serve_client(int i) {
 			}
 			pseudo_debug(PDBGF_SERVER, "\n");
 		}
+		/* tell the client which slot to name in its requests */
+		if (in->type =3D=3D PSEUDO_MSG_PING) {
+			in->client_id =3D i;
+			in->client_serial =3D clients[i].serial;
+		}
 		if (in->type =3D=3D PSEUDO_MSG_SHUTDOWN && !clients[i].pid) {
 			pseudo_debug(PDBGF_SERVER, "shutdown request from client %d [pid %d]\n"=
,
 				i, in->client);
@@ -670,6 +719,93 @@ serve_client(int i) {
 	return rc;
 }
=20
+/* Handle one request from the datagram socket, replying on the client's
+ * stream connection.
+ */
+static void
+serve_request(pseudo_msg_t *in) {
+	struct timeval tv1, tv2;
+	char *response_path =3D 0;
+	size_t response_pathlen =3D -1;
+	int id =3D in->client_id;
+	int valid, rc;
+
+	gettimeofday(&tv1, NULL);
+	++messages;
+	valid =3D id > 0 && id <=3D highest_client && clients[id].fd !=3D -1 &&
+		clients[id].serial =3D=3D in->client_serial;
+	if (!valid) {
+		pseudo_debug(PDBGF_SERVER, "request from departed client %d [pid %d]\n",
+			id, in->client);
+	} else if (in->client !=3D clients[id].pid) {
+		pseudo_debug(PDBGF_SERVER, "uh-oh, expected pid %d for client %d, got %d=
\n",
+			(int) clients[id].pid, id, in->client);
+	}
+	switch (in->type) {
+	case PSEUDO_MSG_PING:
+		in->type =3D PSEUDO_MSG_ACK;
+		break;
+	case PSEUDO_MSG_OP:
+	case PSEUDO_MSG_FASTOP:
+		if (pseudo_server_response(in, valid ? clients[id].program : NULL,
+				valid ? clients[id].tag : NULL,
+				&response_path, &response_pathlen)) {
+			in->type =3D PSEUDO_MSG_NAK;
+		} else {
+			in->type =3D PSEUDO_MSG_ACK;
+		}
+		break;
+	default:
+		pdb_log_msg(SEVERITY_WARN, in, NULL, NULL, "invalid request type %d", in=
->type);
+		in->type =3D PSEUDO_MSG_NAK;
+		break;
+	}
+	if (valid) {
+		pseudo_debug(PDBGF_SERVER | PDBGF_VERBOSE, "response: %d (%s)\n",
+			in->result, pseudo_res_name(in->result));
+		in->client =3D id;
+		in->pathlen =3D response_path ? response_pathlen : 0;
+		rc =3D pseudo_msg_send(clients[id].fd, in, in->pathlen, response_path);
+		if (rc !=3D 0) {
+			pseudo_debug(PDBGF_SERVER, "failed to send response to client %d [%d]: =
%d (%s)\n",
+				id, (int) clients[id].pid, rc, strerror(errno));
+		} else {
+			++responses;
+		}
+	}
+	free(response_path);
+
+	gettimeofday(&tv2, NULL);
+	message_time.tv_sec +=3D (tv2.tv_sec - tv1.tv_sec);
+	message_time.tv_usec +=3D (tv2.tv_usec - tv1.tv_usec);
+	if (message_time.tv_usec < 0) {
+		message_time.tv_usec +=3D 1000000;
+		--message_time.tv_sec;
+	} else while (message_time.tv_usec > 1000000) {
+		message_time.tv_usec -=3D 1000000;
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
+	for (n =3D 0; n < max; ++n) {
+		in =3D pseudo_msg_receive_request(request_fd);
+		if (!in) {
+			/* a malformed datagram was discarded; keep going */
+			if (errno =3D=3D EBADMSG)
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
@@ -730,6 +866,12 @@ pseudo_server_loop(void) {
 		pseudo_error("epoll_ctl() failed with listening socket.\n");
 		exit(PSEUDO_EXIT_EPOLL_CTL);
 	}
+	ev.events =3D EPOLLIN;
+	ev.data.u64 =3D REQUEST_EVENT;
+	if (epoll_ctl(epollfd, EPOLL_CTL_ADD, request_fd, &ev) =3D=3D -1) {
+		pseudo_error("epoll_ctl() failed with request socket.\n");
+		exit(PSEUDO_EXIT_EPOLL_CTL);
+	}
=20
 	pdb_log_msg(SEVERITY_INFO, NULL, NULL, NULL, "server started (pid %d)", g=
etpid());
=20
@@ -758,7 +900,14 @@ pseudo_server_loop(void) {
 		} else if (rc > 0) {
 			loop_timeout =3D pseudo_server_timeout;
 			for (i =3D 0; i < rc; ++i) {
-				int client_id =3D events[i].data.u64;
+				int client_id;
+				if (events[i].data.u64 =3D=3D REQUEST_EVENT) {
+					serve_requests(64);
+					if (die_forcefully)
+						break;
+					continue;
+				}
+				client_id =3D events[i].data.u64;
 				if (clients[client_id].fd =3D=3D listen_fd) {
 					if (!die_forcefully) {
 						len =3D sizeof(client);
@@ -845,6 +994,9 @@ pseudo_server_loop(void) {
 			pseudo_info("done.\n");
 		}
 		if (die_peacefully || die_forcefully) {
+			/* apply requests clients sent before they went away */
+			while (serve_requests(64) =3D=3D 64)
+				;
 			pseudo_debug(PDBGF_SERVER, "quitting.\n");
 			pseudo_debug(PDBGF_SERVER | PDBGF_BENCHMARK, "server %d exiting: handle=
d %d messages in %.4f seconds\n",
 				getpid(), messages,
--=20
2.34.1

