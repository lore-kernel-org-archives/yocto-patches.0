Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.284.1794500400916107413
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 08:20:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ACGJxKw2743931
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 10:20:00 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 4/6] test-seccomp: Check that seccomp is never really enabled
Date: Thu, 12 Nov 2026 10:19:56 -0600
Message-Id: <1794500398-31706-5-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 16:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5328
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

Ask for seccomp strict and filter mode, by prctl() and by the seccomp()
system call, each in a child process, and check the call succeeds and
that /proc/self/status still reports Seccomp: 0.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 test/test-seccomp.c  | 121 +++++++++++++++++++++++++++++++++++++++++++++++++++
 test/test-seccomp.sh |  12 +++++
 2 files changed, 133 insertions(+)
 create mode 100644 test/test-seccomp.c
 create mode 100755 test/test-seccomp.sh

diff --git a/test/test-seccomp.c b/test/test-seccomp.c
new file mode 100644
index 0000000..b600716
--- /dev/null
+++ b/test/test-seccomp.c
@@ -0,0 +1,121 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * A seccomp sandbox restricts libpseudo along with the program, so pseudo
+ * pretends to install one.  Check that every way of asking for one, by
+ * prctl() and by the seccomp() system call, in strict and filter mode,
+ * returns success without leaving the process under seccomp.  Strict mode
+ * would kill the process at the next call other than read(), write() or
+ * exit(), so each case runs in a child of its own.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+
+/* matches test-openat2-syscall: the shell wrapper turns 77 into "skipped" */
+#define SKIP 77
+
+/* Seccomp: field of /proc/self/status, or -1 if there is none */
+static int seccomp_mode(void) {
+	char line[256];
+	int mode = -1;
+	FILE *f;
+
+	f = fopen("/proc/self/status", "r");
+	if (!f)
+		return -1;
+	while (fgets(line, sizeof(line), f))
+		if (!strncmp(line, "Seccomp:", 8))
+			mode = atoi(line + 8);
+	fclose(f);
+	return mode;
+}
+
+static struct sock_filter allow_all[] = {
+	BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+};
+static struct sock_fprog prog = {
+	.len = sizeof(allow_all) / sizeof(allow_all[0]),
+	.filter = allow_all,
+};
+
+static long request(const char *how) {
+	if (!strcmp(how, "prctl-strict"))
+		return prctl(PR_SET_SECCOMP, SECCOMP_MODE_STRICT, 0, 0, 0);
+	if (!strcmp(how, "prctl-filter"))
+		return prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog, 0, 0);
+	if (!strcmp(how, "syscall-strict"))
+		return syscall(SYS_seccomp, SECCOMP_SET_MODE_STRICT, 0, NULL);
+	if (!strcmp(how, "syscall-filter"))
+		return syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog);
+	errno = EINVAL;
+	return -1;
+}
+
+static int check(const char *how) {
+	int status;
+	pid_t pid;
+
+	fflush(NULL);
+	pid = fork();
+	if (pid == -1) {
+		perror("fork");
+		return 1;
+	}
+	if (pid == 0) {
+		long rc;
+		int mode;
+
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) == -1) {
+			perror("prctl(PR_SET_NO_NEW_PRIVS)");
+			_exit(1);
+		}
+		rc = request(how);
+		if (rc != 0) {
+			fprintf(stderr, "%s: returned %ld (%s)\n", how, rc,
+				rc == -1 ? strerror(errno) : "?");
+			_exit(1);
+		}
+		mode = seccomp_mode();
+		if (mode != 0) {
+			fprintf(stderr, "%s: Seccomp: %d after the call\n", how, mode);
+			_exit(1);
+		}
+		_exit(0);
+	}
+	if (waitpid(pid, &status, 0) == -1) {
+		perror("waitpid");
+		return 1;
+	}
+	if (WIFSIGNALED(status)) {
+		fprintf(stderr, "%s: killed by signal %d\n", how, WTERMSIG(status));
+		return 1;
+	}
+	return WEXITSTATUS(status) != 0;
+}
+
+int main(void) {
+	static const char *hows[] = {
+		"prctl-strict", "prctl-filter", "syscall-strict", "syscall-filter",
+	};
+	size_t i;
+	int failed = 0;
+
+	if (seccomp_mode() == -1) {
+		fprintf(stderr, "no Seccomp: in /proc/self/status\n");
+		return SKIP;
+	}
+	for (i = 0; i < sizeof(hows) / sizeof(hows[0]); ++i)
+		failed |= check(hows[i]);
+	return failed;
+}
diff --git a/test/test-seccomp.sh b/test/test-seccomp.sh
new file mode 100755
index 0000000..396e314
--- /dev/null
+++ b/test/test-seccomp.sh
@@ -0,0 +1,12 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+
+# rc 77 means the kernel doesn't report seccomp status, so we're skipped
+./test/test-seccomp
+case $? in
+0)  exit 0 ;;
+77) exit 255 ;;
+*)  exit 1 ;;
+esac
-- 
1.8.3.1

