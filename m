Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.6025.1713920570969814581
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Apr 2024 18:02:51 -0700
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0OsoL018486
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 18:02:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=B1WIM
	Vsn0dWRyuzUNiXD/h9JsmjmLW3xzBf/vFSTLW8=; b=P617caoaOBM/ZAZpH5gpz
	FhJfFxjSg+wg2v3xZUOFTVOYml6ZAojrIXn2rUeAU6UsIjFH7S1mmrCYLY89029R
	AMnlKCSOieYymatWAMjYIfvf/XOjnerlZGXjdy8BWSwMlLR0G9qYNRchfzOkMIpL
	4BMAzK3M+amv2lt38RTBjz9LzYx2hC8U2mcjkqtleyas36e0URxV/7VuokVSMGf3
	A3I+sEWeF3wTuCstQt2CSxMd6JjOpkPjjH81abXVkl9TM86wiK8fsYxblrlvtSAE
	FNPYvIra7DPRx1o59HcyHzbbwvDu5zjInavlt9D9yrr1VztKmurEdN3NFZpQZDT3
	g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xmd7gk8y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Apr 2024 18:02:50 -0700 (PDT)
From: "Changqing Li" <changqing.li@eng.windriver.com>
Subject: [ptest-runner][PATCH] utils.c: fix pty setup
Date: Wed, 24 Apr 2024 09:02:48 +0800
Message-ID: <20240424010248.3211147-1-changqing.li@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org
Cc: randy.macleod@windriver.com
List-ID: <yocto-patches.lists.yoctoproject.org>

From: Changqing Li <changqing.li@windriver.com>

subcase test_tevent_trace will fail if run libtevent-ptest with
ptest-runner, but if run directly, the subcase can successfully.

The failure related to how pty is setup:
In child progress, after close(0), the master pty will use 0 as file
descriptors, and then master pty is attched as child stdin, and slave
pty will also be closed by func close_fds. This will make epoll_wait
will get signal EPOLLHUP, then test failed.

Refer:
epoll_wait(3, [{events=EPOLLOUT|EPOLLHUP, data={u32=2625883648, u64=94496201362944}}], 1, 30000) = 1

lrwx------ 1 root root 64 Apr 23 01:08 0 -> /dev/ptmx
l-wx------ 1 root root 64 Apr 23 01:08 1 -> 'pipe:[4261]'
l-wx------ 1 root root 64 Apr 23 01:08 2 -> 'pipe:[4261]'

To fix this:
1. Open master pty in parent process
2. Attach slave pty to child stdin
3. Remove detaching controlling tty from parent process
4. Remove seting process groupid for child process

Refer:
lrwx------ 1 root root 64 Apr 23 07:35 0 -> /dev/pts/0
l-wx------ 1 root root 64 Apr 23 07:35 1 -> 'pipe:[37001]'
l-wx------ 1 root root 64 Apr 23 07:35 2 -> 'pipe:[37001]'

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 utils.c | 66 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/utils.c b/utils.c
index 46918f4..8a6acca 100644
--- a/utils.c
+++ b/utils.c
@@ -341,25 +341,31 @@ run_child(char *run_ptest, int fd_stdout, int fd_stderr)
 	/* exit(1); not needed? */
 }
 
+/* Returns an integer.
+ * If it returns < 0, an error has occurred.
+ * Otherwise, return 0 means successfully
+ * fp should be writable, likely stdout/err.
+ */
+static int
+setup_master_pty(int* pty_master, int* pty_slave, char*pty_name, FILE *fp) {
+	if (openpty(pty_master, pty_slave, pty_name, NULL, NULL) < 0) {
+		fprintf(fp, "ERROR: openpty() failed with: %s.\n", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
 /* Returns an integer file descriptor.
  * If it returns < 0, an error has occurred.
  * Otherwise, it has returned the slave pty file descriptor.
  * fp should be writable, likely stdout/err.
  */
 static int
-setup_slave_pty(FILE *fp) {
-	int pty_master = -1;
-	int pty_slave = -1;
-	char pty_name[256];
+setup_slave_pty(char* pty_name, FILE *fp) {
 	struct group *gptr;
 	gid_t gid;
 	int slave = -1;
 
-	if (openpty(&pty_master, &pty_slave, pty_name, NULL, NULL) < 0) {
-		fprintf(fp, "ERROR: openpty() failed with: %s.\n", strerror(errno));
-		return -1;
-	}
-
 	if ((gptr = getgrnam(pty_name)) != 0) {
 		gid = gptr->gr_gid;
 	} else {
@@ -384,9 +390,9 @@ setup_slave_pty(FILE *fp) {
 	if ((slave = open(pty_name, O_RDWR)) == -1) {
 		fprintf(fp, "ERROR: open() failed with: %s.\n", strerror(errno));
 	}
-	return (slave);
-}
 
+	return slave;
+}
 
 int
 run_ptests(struct ptest_list *head, const struct ptest_options opts,
@@ -406,16 +412,13 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 
 	do
 	{
-		if (isatty(0) && ioctl(0, TIOCNOTTY) == -1) {
-			fprintf(fp, "ERROR: Unable to detach from controlling tty, %s\n", strerror(errno));
-		}
-
-
 		fprintf(fp, "START: %s\n", progname);
 		PTEST_LIST_ITERATE_START(head, p)
 			int pipefd_stdout[2] = {-1, -1};
 			int pipefd_stderr[2] = {-1, -1};
-			int pgid = -1;
+			int pty_master = -1;
+			int pty_slave = -1;
+			char pty_name[256] = {0};
 
 			if (pipe2(pipefd_stdout, 0) == -1) {
 				rc = -1;
@@ -435,8 +438,9 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 			}
 			dirname(ptest_dir);
 
-			if ((pgid = getpgid(0)) == -1) {
-				fprintf(fp, "ERROR: getpgid() failed, %s\n", strerror(errno));
+			if (setup_master_pty(&pty_master, &pty_slave, pty_name, fp) < 0) {
+				fprintf(fp, "ERROR: setup_master_pty failed, %s\n", strerror(errno));
+				break;
 			}
 
 			pid_t child = fork();
@@ -447,25 +451,32 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 			} else if (child == 0) {
 				int slave;
 
-				close(0);
 				/* Close read ends of the pipe */
 				do_close(&pipefd_stdout[PIPE_READ]);
 				do_close(&pipefd_stderr[PIPE_READ]);
+				do_close(&pty_master);
 
-				if ((slave = setup_slave_pty(fp)) < 0) {
+				if ((slave = setup_slave_pty(pty_name, fp)) < 0) {
 					fprintf(fp, "ERROR: could not setup pty (%d).", slave);
 				}
-				if (setpgid(0,pgid) == -1) {
-					fprintf(fp, "ERROR: setpgid() failed, %s\n", strerror(errno));
-				}
 
 				if (setsid() ==  -1) {
 					fprintf(fp, "ERROR: setsid() failed, %s\n", strerror(errno));
 				}
 
-				if (ioctl(0, TIOCSCTTY, NULL) == -1) {
+				if (ioctl(slave, TIOCSCTTY, NULL) == -1) {
 					fprintf(fp, "ERROR: Unable to attach to controlling tty, %s\n", strerror(errno));
 				}
+				if (slave > 2) {
+					close(slave);
+				}
+
+				if (dup2(pty_slave, STDIN_FILENO) < 0) {
+					fprintf(fp, "ERROR: Unable to dup slave pty to stdin, %s\n", strerror(errno));
+				}
+				if (pty_slave > 2) {
+					close(pty_slave);
+				}
 
 				if (chdir(ptest_dir) == -1) {
 					fprintf(fp, "ERROR: Unable to chdir(%s), %s\n", ptest_dir, strerror(errno));
@@ -481,10 +492,6 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 				do_close(&pipefd_stdout[PIPE_WRITE]);
 				do_close(&pipefd_stderr[PIPE_WRITE]);
 
-				if (setpgid(child, pgid) == -1) {
-					fprintf(fp, "ERROR: setpgid() failed, %s\n", strerror(errno));
-				}
-
 				time_t start_time= time(NULL);
 				fprintf(fp, "%s\n", get_stime(stime, GET_STIME_BUF_SIZE, start_time));
 				fprintf(fp, "BEGIN: %s\n", ptest_dir);
@@ -608,6 +615,7 @@ run_ptests(struct ptest_list *head, const struct ptest_options opts,
 			do_close(&pipefd_stdout[PIPE_WRITE]);
 			do_close(&pipefd_stderr[PIPE_READ]);
 			do_close(&pipefd_stderr[PIPE_WRITE]);
+			do_close(&pty_master);
 
 			fflush(fp);
 			fflush(fp_stderr);
-- 
2.25.1

