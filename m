Received: from PH8PR06CU001.outbound.protection.outlook.com (PH8PR06CU001.outbound.protection.outlook.com [40.107.209.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6052.1795472862293373966
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 14:27:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=vnVXIw2K;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.209.7, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GT94mH5iF43XZaZEFGA0LQpTuYlLUSXT61HChE+lowUvWDrUF8oqOYPrhAyiBTN5wAcnPq7gnB8BedZ0S7MD92dLnSw+puADubXqdz8cYfJG0NCc11ZqpYVmGbTWjjGWXh6ADD4PyIvfXwuF9JEm9NgpTuD7BDcP6gP43mWDr5/AMaAB36vdFU6hEwNUOju5jcXdqbWliUaeUBQw7xTQd9oVCpsKsTBD2OOn3MqG2QctwPm9BLGwR5/1um40Wcwo1CI4/77V/NvrtR0sBWrSyCg3A5WEAphqqqV6sIVNZXzIX+1cMaOSyPQmldfnDUU9YUqo58nSaSha3FlvSCW5lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVtGSHtaTGD2czQVyRq8l18sA1FRlbIIL/17k21P/t8=;
 b=xV4faxHZcq2Q/NQ5G7H4Dtx8GiIUXpsAB6RqWiyuI0FqTOcvqb0qtmnbB+VhPjzK/s0lMXV+HJjsYSjogbM8uSviezIEOZvy58M7i6glxJMm59HX5Npw1/JHcPSQ9FChK8UIDnLH1Rcw3Ev2aTpDoscxzz7O31KKHqI/WLjU0ACmzgHxKkK8aV74F32/Yx2ljmSTxr966MtRo04mf1YC1V+9Q/TiY8fRe/W45MOb/wFaQeAxnPIYtuwkOb5VTD55twHLwBTa6EYOQUUJO/oWq9wYCABYZomsL0YvUBe1RjGsMQTdWkDXJkYIp5DzWfDozOQ9MK8DMron4txGjFKggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVtGSHtaTGD2czQVyRq8l18sA1FRlbIIL/17k21P/t8=;
 b=vnVXIw2K5FocAv+DLq4X/la7LBTT80N3e5Zv/Kt6yezesFFB2P+mBoknInWG2xrNELu9BKYw3wnHeDo3Nifh8ukYcM9zGr0b/yOLSgVv30X7HcRL/UTBvmOwgvf/2cZR533KterQE8BbujEJn0GhV7cCfTwWITKujqK/gMPrn7I=
Received: from BN0PR10CA0003.namprd10.prod.outlook.com (2603:10b6:408:143::35)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 22:27:32 +0000
Received: from BN3PEPF00022BD5.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::84) by BN0PR10CA0003.outlook.office365.com
 (2603:10b6:408:143::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 22:27:32 +0000
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
 2026 16:27:30 -0600
Received: from xcolc230100.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Mon, 23 Nov 2026 16:27:30 -0600
From: Mark Hatle <mark.hatle@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [pseudo][PATCH 2/2] Replace FASTOP with requests that don't wait for a reply
Date: Mon, 23 Nov 2026 15:27:28 -0700
Message-ID: <20261123222728.2343685-3-mark.hatle@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123222728.2343685-1-mark.hatle@amd.com>
References: <20261123222728.2343685-1-mark.hatle@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: mark.hatle@amd.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD5:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 0279c455-ee6e-478a-fa7b-08df49b0f72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|10067099003|56012099006|11063799006|261026140227099003|261021135927099003|261026121527099003|261021121427099003|261022075727099003|261022115727099003|261102130727099003|261022105027099003|261021123027099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 7aZcknTFQr+HoUGKb1O9+4whAYAfy1oDX52isbbSY6GCh+eStvfEd31GT41T77y2WJDFR2hrk0QJXo536ZHwu04wwPddIbOaF60NSnrsw9mMZBrGvQMeEyk4+UhDpcxXZws5AKw0vAfkbjFTdXKputaIpKEYH6N05Vr+TglUIdKg0VatGolODjB22yMl1bM8k3MroVR74fZt26yZQ7Io2R452UxV80Gc/X7qS0HRe03m5Aeo3NVhspLST+mctExviCRGmqJ830XpsOrEI+TyJ0c+dG2dPUswjNQPixzKULQWKmC1IzQClNj8HGF6OCgdPAMHafOj/VkdQUMvw5njGuMUFdR/xE34upNWNlTkNQUMyaX82DmVQqCyhMgqGbBuD0PEB7vg5GU7j64UGUh2+hZAAEEU2bjVeZu++//ppaYF5dV+RDAaYMRqt/Ydtp4GhLpA1bOwz1p8zOjmh8i9BFZzTl6b8tWxPs9asxYa4k+wLS4AXt3U2Nb8k3cm5QasP8iWyXmmHfUGaUjWOC0pVr771g8YVIjc19RmMnnX5SjMnlmruzP8FwDIUaESiFw9agNgv9aY28xgiVy5nYJvDo9hDc5XS69pB9hJIiWfoHoPIsWJkMPZgfew6DtmrVfS43mBRy1WGQXkALsuoCNLJjU09coQEiGfplf0pyXLTVPIesIEP+YXmX9Z4/ThTfyOCPU22KnRsVKmGNcfN0nQ1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(261026140227099003)(261021135927099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022115727099003)(261102130727099003)(261022105027099003)(261021123027099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nViTuRzfKo9EoJMYj1YQh8cfkrZo7hWcF0wpnItYvDC8RWQjOfMDMiLxhv/m3iCeuQkjg5NCseoKiulgUM9k68YWYGpj8Iw+8oTiOdNliXZJ7NTKQNK+O87sRfm6f+39O3kASsohYCCevP7ijHXgsafCSadQK7K2pOjAW5yiqX3pKycjoVp4OpA3Pn7h1UwS2xVUMsNG6XJEyq0O95xVmWgNfUR0jIshDHAEexTQD3Y80EymiPEngBvltVUBgoGoUWLUU/jH9MzWzVSgle/ERQlId3eyUolItSvC3IWYUbrWZzPr98Y/KBlZ5kWAnb8mPpugfxmw7qXl2uELoeLdsJJ7WBJwm6LSvpI+ObLsfbqg2/wBSHzDYuk4ZamxiSlvqb07Qj+1cCw2zoRxFzHaUypFByOBJDlqzbxatg2LhFPaBy4JMwnrwIrVP9J1wW2s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 22:27:31.9595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0279c455-ee6e-478a-fa7b-08df49b0f72e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 22:27:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5495
Content-Type: text/plain; charset="utf-8"

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
as well.  PSEUDO_SYNC=3D1 makes every request wait, so the client
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
 doc/program_flow               |  11 ++
 doc/pseudo_ipc                 |  43 +++++---
 enums/msg_type.in              |   2 +-
 enums/op.in                    |  50 ++++-----
 ports/common/guts/_exit.c      |  16 +++
 ports/common/guts/execv.c      |   4 +
 ports/common/guts/execve.c     |   4 +
 ports/common/guts/execveat.c   |   4 +
 ports/common/guts/execvp.c     |   4 +
 ports/common/guts/execvpe.c    |   4 +
 ports/common/guts/fexecve.c    |   4 +
 ports/common/pseudo_wrappers.c |  24 +++++
 ports/common/wrapfuncs.in      |   1 +
 pseudo.1                       |  23 +++-
 pseudo.c                       |   2 +-
 pseudo_client.c                |  72 ++++++++++++-
 pseudo_client.h                |   2 +
 pseudo_server.c                |  42 +++-----
 pseudo_util.c                  |   1 +
 pseudo_wrappers.c              |  43 ++++++++
 test/test-async-abort.c        |  48 +++++++++
 test/test-async-abort.sh       |  40 +++++++
 test/test-async-order.c        | 188 +++++++++++++++++++++++++++++++++
 test/test-async-order.sh       |  23 ++++
 25 files changed, 583 insertions(+), 75 deletions(-)
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
=20
 As a fairly typical example, the progress of a stat(2) call is:
=20
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
=20
 	fork()
@@ -77,6 +80,14 @@ libpseudo execution flow:
 		unmask signals (if they were blocked above)
 		return rc
=20
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
@@ -20,8 +20,10 @@ changes a file and then tells another process about it (=
through a pipe,
 by exiting, or any other way), the server has already queued the change
 by the time the second process can ask about the file.
=20
-It also means the server reads each request with a single recv(),
-rather than a header and then a path.
+That is what allows requests that need no reply to be sent without
+waiting for the server (see ASYNC below).  It also means the server
+reads each request with a single recv(), rather than a header and then
+a path.
=20
 typedef struct {
 	pseudo_msg_type_t type;
@@ -53,26 +55,41 @@ All messages contain every field up to, but not includi=
ng, path.  If
 pathlen is not zero, an additional pathlen bytes containing path are
 provided; path is null-terminated.
=20
-Every message from client should get a response from server.  The server
-usually sends no path back; the exceptions are replies to xattr requests
-(attribute values or name lists) and the list of client PIDs in a refused
-SHUTDOWN request, described below.  Note that
-all server responses will in general share a single message object,
+Every message from the client gets a response from the server, except
+ASYNC requests.  The server usually sends no path back; the exceptions
+are replies to xattr requests (attribute values or name lists) and the
+list of client PIDs in a refused SHUTDOWN request, described below.
+Note that all server responses will in general share a single message obje=
ct,
 and future operations may cause that object to be reallocated; the same
 goes for messages received by the server.  Basically, pseudo_msg_receive
 is not thread-safe; this is part of (but not all of) the reason that there=
's
 mutex stuff in the wrappers.  (The other part is the "antimagic" being
 able to blow things up.)
=20
-type is one of PING, OP, FASTOP, SHUTDOWN, ACK, or NAK.  The client
-only sends PING, OP, or FASTOP.  FASTOP is used for operations whose resul=
t
-the client doesn't need, but the server still replies with ACK (or NAK on
-failure) and the client still waits for that reply.
+type is one of PING, OP, SHUTDOWN, ACK, NAK, or ASYNC.  The client
+sends PING, OP and ASYNC, and the server replies to PING and OP with ACK
+(or NAK on failure); the client waits for that reply.
=20
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
=20
 When run with '-S', the pseudo program
 runs as a client, sending a SHUTDOWN message to a server -- but only if
@@ -85,7 +102,7 @@ reduces the timeout to 3 seconds, so it shuts down short=
ly after the
 last client goes away rather than waiting for the full timeout period.)
=20
 result is the result of a particular operation.  It applies only in replie=
s
-to OP messages.
+to OP and ASYNC messages.
=20
 client should be the client's PID on send, and the server's client number =
for
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
-op: OP; int wait =3D 0
+op: OP; int async =3D 0
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
 	rc =3D real_execv(file, argv);
=20
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
 	rc =3D real_execve(file, argv, new_environ);
=20
diff --git a/ports/common/guts/execveat.c b/ports/common/guts/execveat.c
index 10e0d52..b591dc4 100644
--- a/ports/common/guts/execveat.c
+++ b/ports/common/guts/execveat.c
@@ -19,6 +19,10 @@
 	if (pseudo_has_unload(new_environ))
 		new_environ =3D pseudo_dropenvp(new_environ);
=20
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc =3D real_execveat(dirfd, path, argv, new_environ, flags);
=20
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
 	rc =3D real_execvp(file, argv);
=20
diff --git a/ports/common/guts/execvpe.c b/ports/common/guts/execvpe.c
index 37e4927..5fc544b 100644
--- a/ports/common/guts/execvpe.c
+++ b/ports/common/guts/execvpe.c
@@ -19,6 +19,10 @@
 	if (pseudo_has_unload(new_environ))
 		new_environ =3D pseudo_dropenvp(new_environ);
=20
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc =3D real_execvpe(file, argv, new_environ);
=20
diff --git a/ports/common/guts/fexecve.c b/ports/common/guts/fexecve.c
index a0162d3..8e64ae0 100644
--- a/ports/common/guts/fexecve.c
+++ b/ports/common/guts/fexecve.c
@@ -11,6 +11,10 @@
 	if (pseudo_has_unload(new_environ))
 		new_environ =3D pseudo_dropenvp(new_environ);
=20
+	/* exec() skips destructors, so collect errors for requests
+	 * sent without waiting now
+	 */
+	pseudo_client_flush();
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc =3D real_fexecve(fd, argv, new_environ);
=20
diff --git a/ports/common/pseudo_wrappers.c b/ports/common/pseudo_wrappers.=
c
index 2ad0814..208f4e8 100644
--- a/ports/common/pseudo_wrappers.c
+++ b/ports/common/pseudo_wrappers.c
@@ -445,6 +445,24 @@ execveat(int dirfd, const char *path, char *const *arg=
v, char *const *envp, int
 	return rc;
 }
=20
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
+/* _Exit() is equivalent to _exit(), and glibc makes it a weak alias of
+ * _exit, but callers bind to it by name, so it must be exported as well.
+ */
+void _Exit(int status) __attribute__((alias("_exit"), noreturn));
+
 /* no profiling in fork because it wouldn't work anyway
  * half the time
  */
@@ -543,6 +561,12 @@ wrap_execveat(int dirfd, const char *path, char *const=
 *argv, char *const *envp,
 	return rc;
 }
=20
+/* not used, the hand-written wrappers flush and exit directly */
+static void
+wrap__exit(int status) {
+	(void) status;
+}
+
 static int
 wrap_fork(void) {
 	int rc =3D -1;
diff --git a/ports/common/wrapfuncs.in b/ports/common/wrapfuncs.in
index 9b01bf2..ab433fb 100644
--- a/ports/common/wrapfuncs.in
+++ b/ports/common/wrapfuncs.in
@@ -10,3 +10,4 @@ int posix_spawnp(pid_t *pid, const char *file, const posi=
x_spawn_file_actions_t
 int execvpe(const char *file, char *const *argv, char *const *envp); /* ha=
nd_wrapped=3D1 */
 int fexecve(int fd, char *const *argv, char *const *envp); /* hand_wrapped=
=3D1 */
 int execveat(int dirfd, const char *path, char *const *argv, char *const *=
envp, int flags); /* hand_wrapped=3D1 */
+void _exit(int status); /* hand_wrapped=3D1 */
diff --git a/pseudo.1 b/pseudo.1
index 1b5c537..c00dc64 100644
--- a/pseudo.1
+++ b/pseudo.1
@@ -880,6 +880,21 @@ suppresses informational messages or warnings; errors =
are always shown.
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
@@ -937,9 +952,11 @@ or debugged in that context.
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
=20
 .SH SECURITY
 .I pseudo
diff --git a/pseudo.c b/pseudo.c
index 26c7a36..70f439d 100644
--- a/pseudo.c
+++ b/pseudo.c
@@ -1087,7 +1087,7 @@ pseudo_server_response(pseudo_msg_t *msg, const char =
*program, const char *tag,
 		return 0;
 		break;
 	case PSEUDO_MSG_OP:
-	case PSEUDO_MSG_FASTOP:
+	case PSEUDO_MSG_ASYNC:
 		return pseudo_op(msg, program, tag, response_path, response_len);
 		break;
 	case PSEUDO_MSG_ACK:		/* FALLTHROUGH */
diff --git a/pseudo_client.c b/pseudo_client.c
index dc3ce1f..44a6b88 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -53,6 +53,13 @@ static int connect_fd =3D -1;
 static int request_fd =3D -1;
 static int client_id =3D 0;
 static unsigned int client_serial =3D 0;
+/* requests that need no reply are sent without waiting.  async_pending
+ * is set while some may not have been handled yet, so their errors are
+ * collected before exec() or exit().
+ */
+static int async_pending =3D 0;
+static pid_t async_pid =3D 0;
+static int pseudo_sync_only =3D 0;
 static int server_pid =3D 0;
 int pseudo_localstate_dir_fd =3D -1;
 static int pseudo_pathlock_fd =3D -1;
@@ -454,8 +461,17 @@ pseudo_init_client(void) {
 	int need_free =3D 0;
=20
 	pseudo_antimagic();
+	/* collect errors for requests this process sent; a forked child
+	 * leaves its parent's to the parent
+	 */
+	pseudo_client_flush();
+	async_pending =3D 0;
 	pseudo_new_pid();
 	client_disconnect();
+
+	env =3D pseudo_get_value("PSEUDO_SYNC");
+	pseudo_sync_only =3D env && *env && strcmp(env, "0");
+	free(env);
 #ifdef PSEUDO_PROFILING
 	if (pseudo_profile_fd > -1) {
 		close(pseudo_profile_fd);
@@ -1533,6 +1549,15 @@ pseudo_client_send(pseudo_msg_t *msg, size_t len, co=
nst char *path, int tries) {
 	return -1;
 }
=20
+/* Send a request that needs no reply, without waiting for the server. */
+static void
+pseudo_client_send_async(pseudo_msg_t *msg, size_t len, const char *path) =
{
+	msg->type =3D PSEUDO_MSG_ASYNC;
+	pseudo_client_send(msg, len, path, 0);
+	async_pending =3D 1;
+	async_pid =3D getpid();
+}
+
 static pseudo_msg_t *
 pseudo_client_request(pseudo_msg_t *msg, size_t len, const char *path) {
 	pseudo_msg_t *response =3D 0;
@@ -1551,7 +1576,16 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len,=
 const char *path) {
 	for (; tries < PSEUDO_RETRIES; ++tries) {
 		tries =3D pseudo_client_send(msg, len, path, tries);
 		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "sent!\n");
-		response =3D pseudo_msg_receive(connect_fd);
+		/* replies come back in order, so any errors for earlier
+		 * asynchronous requests arrive first
+		 */
+		while ((response =3D pseudo_msg_receive(connect_fd)) !=3D NULL &&
+		       response->type =3D=3D PSEUDO_MSG_ASYNC) {
+			pseudo_debug(PDBGF_CLIENT, "error for asynchronous %s: %s\n",
+				pseudo_op_name(response->op), pseudo_res_name(response->result));
+			if (response->result =3D=3D RESULT_ABORT)
+				pseudo_client_abort();
+		}
 		if (!response) {
 			pseudo_debug(PDBGF_CLIENT, "expected response did not occur; retrying\n=
");
 			/* the connection may be gone even though the request
@@ -1559,6 +1593,8 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len, =
const char *path) {
 			 */
 			pseudo_client_setup();
 		} else {
+			/* everything sent before this request has been handled */
+			async_pending =3D 0;
 			if (response->type !=3D PSEUDO_MSG_ACK) {
 				pseudo_debug(PDBGF_CLIENT, "got non-ack response %d\n", response->type=
);
 				return 0;
@@ -1574,6 +1610,34 @@ pseudo_client_request(pseudo_msg_t *msg, size_t len,=
 const char *path) {
 	return 0;
 }
=20
+/* Whether this process has asynchronous requests the server may not
+ * have handled yet.
+ */
+int
+pseudo_client_flush_needed(void) {
+	return async_pending && async_pid =3D=3D getpid() && request_fd !=3D -1;
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
+	msg.type =3D PSEUDO_MSG_PING;
+	msg.op =3D OP_NONE;
+	msg.client =3D getpid();
+	pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "flushing asynchronous request=
s\n");
+	pseudo_client_request(&msg, 0, NULL);
+	async_pending =3D 0;
+	pseudo_magic();
+}
+
 int
 pseudo_client_shutdown(int wait_on_socket) {
 	pseudo_msg_t msg;
@@ -2362,8 +2426,6 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
 #ifdef PSEUDO_PROFILING
 		struct timeval tv1_ipc, tv2_ipc;
 #endif
-                if (!pseudo_op_wait(msg.op))
-                        msg.type =3D PSEUDO_MSG_FASTOP;
 		pseudo_debug(PDBGF_CLIENT | PDBGF_VERBOSE, "sending request [ino %llu]\n=
", (unsigned long long) msg.ino);
 #ifdef PSEUDO_PROFILING
 		gettimeofday(&tv1_ipc, NULL);
@@ -2371,6 +2433,8 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
 		if (pseudo_local_only) {
 			/* disable server */
 			result =3D NULL;
+		} else if (!pseudo_sync_only && pseudo_op_async(msg.op)) {
+			pseudo_client_send_async(&msg, pathlen, path);
 		} else {
 			result =3D pseudo_client_request(&msg, pathlen, path);
 		}
@@ -2397,7 +2461,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, =
int dirfd, const char *path
 					(int) result->uid,
 					(int) result->gid);
 			}
-		} else if (msg.type !=3D PSEUDO_MSG_FASTOP) {
+		} else if (msg.type !=3D PSEUDO_MSG_ASYNC) {
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
index 89a81f2..f6a0482 100644
--- a/pseudo_server.c
+++ b/pseudo_server.c
@@ -573,7 +573,6 @@ serve_client(int i) {
 	if (in) {
 		char *response_path =3D 0;
 		size_t response_pathlen;
-		int send_response =3D 1;
 		pseudo_debug(PDBGF_SERVER | PDBGF_VERBOSE, "got a message (%d): %s\n", i=
n->type, (in->pathlen ? in->path : "<no path>"));
 		/* handle incoming ping */
 		if (in->type =3D=3D PSEUDO_MSG_PING && !clients[i].pid) {
@@ -635,20 +634,6 @@ serve_client(int i) {
 			} else {
 				in->pathlen =3D 0;
 			}
-			if (in->type =3D=3D PSEUDO_MSG_FASTOP) {
-				/* respond instantly */
-				send_response =3D 0;
-				int t_type =3D in->type;
-				int t_pathlen =3D in->pathlen;
-				in->type =3D PSEUDO_MSG_ACK;
-				in->pathlen =3D 0;
-				if ((rc =3D pseudo_msg_send(clients[i].fd, in, in->pathlen, response_p=
ath)) !=3D 0) {
-					pseudo_debug(PDBGF_SERVER, "failed to send response to client %d [%d]=
: %d (%s)\n",
-						i, (int) clients[i].pid, rc, strerror(errno));
-				}
-				in->type =3D t_type;
-				in->pathlen =3D t_pathlen;
-			}
 		} else {
 			/* the server's listen fd is "a client", and
 			 * so is the program connecting to request a shutdown.
@@ -686,13 +671,9 @@ serve_client(int i) {
 				die_peacefully =3D 1;
 			}
 		}
-		if (send_response) {
-			if ((rc =3D pseudo_msg_send(clients[i].fd, in, in->pathlen, response_pa=
th)) !=3D 0) {
-				pseudo_debug(PDBGF_SERVER, "failed to send response to client %d [%d]:=
 %d (%s)\n",
-					i, (int) clients[i].pid, rc, strerror(errno));
-			}
-		} else {
-			rc =3D 1;
+		if ((rc =3D pseudo_msg_send(clients[i].fd, in, in->pathlen, response_pat=
h)) !=3D 0) {
+			pseudo_debug(PDBGF_SERVER, "failed to send response to client %d [%d]: =
%d (%s)\n",
+				i, (int) clients[i].pid, rc, strerror(errno));
 		}
 		free(response_path);
 	} else {
@@ -719,8 +700,10 @@ serve_client(int i) {
 	return rc;
 }
=20
-/* Handle one request from the datagram socket, replying on the client's
- * stream connection.
+/* Handle one request from the datagram socket.  Synchronous requests
+ * (and PING, which a client uses to wait until everything it sent so far
+ * has been handled) get a reply on the client's stream connection.
+ * Asynchronous ones only get a reply if the client must abort.
  */
 static void
 serve_request(pseudo_msg_t *in) {
@@ -728,7 +711,7 @@ serve_request(pseudo_msg_t *in) {
 	char *response_path =3D 0;
 	size_t response_pathlen =3D -1;
 	int id =3D in->client_id;
-	int valid, rc;
+	int valid, reply =3D 1, rc;
=20
 	gettimeofday(&tv1, NULL);
 	++messages;
@@ -746,7 +729,6 @@ serve_request(pseudo_msg_t *in) {
 		in->type =3D PSEUDO_MSG_ACK;
 		break;
 	case PSEUDO_MSG_OP:
-	case PSEUDO_MSG_FASTOP:
 		if (pseudo_server_response(in, valid ? clients[id].program : NULL,
 				valid ? clients[id].tag : NULL,
 				&response_path, &response_pathlen)) {
@@ -755,12 +737,18 @@ serve_request(pseudo_msg_t *in) {
 			in->type =3D PSEUDO_MSG_ACK;
 		}
 		break;
+	case PSEUDO_MSG_ASYNC:
+		pseudo_server_response(in, valid ? clients[id].program : NULL,
+			valid ? clients[id].tag : NULL,
+			&response_path, &response_pathlen);
+		reply =3D (in->result =3D=3D RESULT_ABORT);
+		break;
 	default:
 		pdb_log_msg(SEVERITY_WARN, in, NULL, NULL, "invalid request type %d", in=
->type);
 		in->type =3D PSEUDO_MSG_NAK;
 		break;
 	}
-	if (valid) {
+	if (reply && valid) {
 		pseudo_debug(PDBGF_SERVER | PDBGF_VERBOSE, "response: %d (%s)\n",
 			in->result, pseudo_res_name(in->result));
 		in->client =3D id;
diff --git a/pseudo_util.c b/pseudo_util.c
index 5899a4f..415825a 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -60,6 +60,7 @@ static struct pseudo_variables pseudo_env[] =3D {
 	{ "PSEUDO_ALLOW_FSYNC", 18, NULL },
 	{ "PSEUDO_IO_URING_SECCOMP", 23, NULL },
 	{ "PSEUDO_IO_URING_FILTER", 22, NULL },
+	{ "PSEUDO_SYNC", 11, NULL },
 #ifdef PSEUDO_PROFILING
 	{ "PSEUDO_PROFILE_PATH", 19, NULL },
 #endif
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 5e0bacf..91596ea 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -57,8 +57,10 @@ static pthread_mutex_t pseudo_mutex =3D PTHREAD_MUTEX_IN=
ITIALIZER;
 static pthread_t pseudo_mutex_holder;
 static int pseudo_mutex_recursion =3D 0;
 static int pseudo_getlock(void);
+static int pseudo_trylock(void);
 static void pseudo_droplock(void);
 static int pseudo_lock_held(void);
+static void pseudo_exit_flush(void);
 static size_t pseudo_dechroot(char *, size_t);
 static void pseudo_sigblock(sigset_t *);
=20
@@ -73,6 +75,7 @@ static void pseudo_io_uring_init(void);
=20
 /* Constructor only exists in libpseudo */
 static void _libpseudo_init(void) __attribute__ ((constructor));
+static void _libpseudo_fini(void) __attribute__ ((destructor));
=20
 static int _libpseudo_initted =3D 0;
=20
@@ -130,6 +133,32 @@ _libpseudo_init(void) {
 	pseudo_droplock();
 }
=20
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
+	if (!_libpseudo_initted || pseudo_disabled || !pseudo_client_flush_needed=
())
+		return;
+	pseudo_sigblock(&saved);
+	if (pseudo_trylock() =3D=3D 0) {
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
@@ -238,6 +267,20 @@ pseudo_getlock(void) {
 	}
 }
=20
+static int
+pseudo_trylock(void) {
+	if (pthread_equal(pseudo_mutex_holder, pthread_self())) {
+		++pseudo_mutex_recursion;
+		return 0;
+	}
+	if (pthread_mutex_trylock(&pseudo_mutex) =3D=3D 0) {
+		pseudo_mutex_recursion =3D 1;
+		pseudo_mutex_holder =3D pthread_self();
+		return 0;
+	}
+	return -1;
+}
+
 static int
 pseudo_lock_held(void) {
 	return pthread_equal(pseudo_mutex_holder, pthread_self());
diff --git a/test/test-async-abort.c b/test/test-async-abort.c
new file mode 100644
index 0000000..d2a28d6
--- /dev/null
+++ b/test/test-async-abort.c
@@ -0,0 +1,48 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * chown() a file whose database entry still has another name, which makes
+ * the server tell the client to abort.  Prints "returned" if chown()
+ * returns, then does one of the following, which must deliver the abort
+ * if chown() didn't:
+ *   stat     a synchronous request
+ *   _exit    leave without running destructors
+ *   _Exit    the same, through the C99 name
+ *   execvpe  run another program
+ *
+ * usage: test-async-abort <path> <stat|_exit|_Exit|execvpe>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+
+int
+main(int argc, char **argv) {
+	struct stat st;
+
+	if (argc !=3D 3) {
+		fprintf(stderr, "usage: %s <path> <stat|_exit|_Exit|execvpe>\n", argv[0]=
);
+		return 2;
+	}
+	if (chown(argv[1], 1234, 5678) =3D=3D -1)
+		perror("chown");
+	printf("returned\n");
+	fflush(stdout);
+	if (!strcmp(argv[2], "_exit")) {
+		_exit(0);
+	} else if (!strcmp(argv[2], "_Exit")) {
+		_Exit(0);
+	} else if (!strcmp(argv[2], "execvpe")) {
+		char *args[] =3D { "true", NULL };
+		char *env[] =3D { NULL };
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
index 0000000..f6545da
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
+# it leaves with _exit() or _Exit() or execs another program.  With PSEUDO=
_SYNC set,
+# it must abort inside chown() itself.
+#
+# The temporary tree has to live below $PWD so that pseudo tracks it.
+
+tmpdir=3D"$(mktemp -d -p "$PWD" async_abort_XXXXXX)"
+trap "rm -rf '$tmpdir'" EXIT TERM INT
+
+rc=3D0
+check() {
+    local sync=3D"$1" how=3D"$2" expect=3D"$3" out status
+    : > "$tmpdir/a"
+    # rename it behind pseudo's back, so the database still says "a"
+    PSEUDO_DISABLED=3D1 mv "$tmpdir/a" "$tmpdir/b"
+    out=3D$(PSEUDO_SYNC=3D$sync ./test/test-async-abort "$tmpdir/b" "$how"=
 2>/dev/null)
+    status=3D$?
+    # put the name back so the database entry can be removed cleanly
+    PSEUDO_DISABLED=3D1 mv "$tmpdir/b" "$tmpdir/a"
+    rm -f "$tmpdir/a"
+    if [ $status -ne 134 ]; then
+        echo "FAILED: $how: expected abort (PSEUDO_SYNC=3D${sync:-unset}),=
 got status $status"
+        rc=3D1
+    elif [ "$out" !=3D "$expect" ]; then
+        echo "FAILED: $how: PSEUDO_SYNC=3D${sync:-unset}: expected output =
'$expect', got '$out'"
+        rc=3D1
+    fi
+}
+
+for how in stat _exit _Exit execvpe; do
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
+ * has been told, through a pipe or by the process exiting, that the chang=
e
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
+	if (stat(path, &st) =3D=3D -1) {
+		fprintf(stderr, "stat %s: %s\n", path, strerror(errno));
+		return 1;
+	}
+	if (st.st_uid !=3D (uid_t) (1000 + i) || st.st_gid !=3D (gid_t) (2000 + i=
) ||
+	    (want_mode && (st.st_mode & 07777) !=3D mode_for(i))) {
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
+	if (chown(path, 1000 + i, 2000 + i) =3D=3D -1) {
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
+	int i, bad =3D 0, status;
+
+	if (pipe(p12) =3D=3D -1 || pipe(p23) =3D=3D -1) {
+		perror("pipe");
+		return 2;
+	}
+	c2 =3D fork();
+	if (c2 =3D=3D 0) {
+		char path[4096];
+		close(p12[1]);
+		close(p23[0]);
+		while (read(p12[0], &i, sizeof(i)) =3D=3D sizeof(i)) {
+			name(path, sizeof(path), i);
+			if (chmod(path, mode_for(i)) =3D=3D -1) {
+				perror("chmod");
+				_exit(2);
+			}
+			if (write(p23[1], &i, sizeof(i)) !=3D sizeof(i))
+				_exit(2);
+		}
+		_exit(0);
+	}
+	c3 =3D fork();
+	if (c3 =3D=3D 0) {
+		close(p12[0]);
+		close(p12[1]);
+		close(p23[1]);
+		while (read(p23[0], &i, sizeof(i)) =3D=3D sizeof(i))
+			bad +=3D check(i, 1);
+		_exit(bad ? 1 : 0);
+	}
+	close(p12[0]);
+	close(p23[0]);
+	close(p23[1]);
+	/* send all the changes in a burst before handing them on, newest
+	 * first, so the others ask about changes still queued behind
+	 * older ones
+	 */
+	for (i =3D 0; i < count; ++i)
+		chown_one(i);
+	for (i =3D count - 1; i >=3D 0; --i) {
+		if (write(p12[1], &i, sizeof(i)) !=3D sizeof(i)) {
+			perror("write");
+			return 2;
+		}
+	}
+	close(p12[1]);
+	if (waitpid(c2, &status, 0) =3D=3D -1 || !WIFEXITED(status) || WEXITSTATU=
S(status))
+		bad =3D 1;
+	if (waitpid(c3, &status, 0) =3D=3D -1 || !WIFEXITED(status) || WEXITSTATU=
S(status))
+		bad =3D 1;
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
+	int i, w, bad =3D 0, status;
+
+	for (w =3D 0; w < WRITERS; ++w) {
+		c[w] =3D fork();
+		if (c[w] =3D=3D 0) {
+			for (i =3D 0; i < count; ++i)
+				chown_one(count * (w + 1) + i);
+			_exit(0);
+		}
+	}
+	for (w =3D 0; w < WRITERS; ++w) {
+		if (waitpid(c[w], &status, 0) =3D=3D -1 || !WIFEXITED(status) || WEXITST=
ATUS(status))
+			bad =3D 2;
+	}
+	if (bad)
+		return bad;
+	for (i =3D count * (WRITERS + 1) - 1; i >=3D count; --i)
+		bad +=3D check(i, 0);
+	return bad ? 1 : 0;
+}
+
+int
+main(int argc, char **argv) {
+	char path[4096];
+	int i, fd, rc;
+
+	if (argc !=3D 3) {
+		fprintf(stderr, "usage: %s <directory> <count>\n", argv[0]);
+		return 2;
+	}
+	dir =3D argv[1];
+	count =3D atoi(argv[2]);
+	for (i =3D 0; i < count * (WRITERS + 1); ++i) {
+		name(path, sizeof(path), i);
+		fd =3D open(path, O_CREAT | O_WRONLY, 0600);
+		if (fd =3D=3D -1) {
+			perror(path);
+			return 2;
+		}
+		close(fd);
+	}
+	rc =3D pipe_chain();
+	if (rc) {
+		fprintf(stderr, "pipe hand-off failed\n");
+		return rc;
+	}
+	rc =3D exit_handoff();
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
+tmpdir=3D"$(mktemp -d -p "$PWD" async_order_XXXXXX)"
+trap "rm -rf '$tmpdir'" EXIT TERM INT
+
+rc=3D0
+for sync in "" 1; do
+    rm -f "$tmpdir"/f*
+    if ! PSEUDO_SYNC=3D$sync ./test/test-async-order "$tmpdir" 500; then
+        echo "FAILED: ordering broken (PSEUDO_SYNC=3D${sync:-unset})"
+        rc=3D1
+    fi
+done
+exit $rc
--=20
2.34.1

