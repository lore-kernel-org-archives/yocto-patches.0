Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2583.1794370872121178194
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mK2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:09 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 34/34] Wrap execvpe(), fexecve() and execveat()
Date: Tue, 10 Nov 2026 22:21:02 -0600
Message-Id: <1794370862-30908-35-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5288
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

These weren't wrapped, so a program that ran another one through them
with an environment lacking LD_PRELOAD or pseudo's variables, as
env -i does through execve(), ran it outside pseudo: its files were
created and changed as the real user, with nothing recorded.

Wrap them like execve(): restore pseudo's environment, honour
PSEUDO_UNLOAD, and log the exec when the server is logging (execveat()
only for absolute paths or AT_FDCWD).  Rename test-execl to test-exec
and extend it to run env through each of them, checking the arguments
get through, that an empty environment gets libpseudo back in
LD_PRELOAD, and that PSEUDO_UNLOAD keeps it out.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/common/guts/execveat.c   |  29 +++++++++
 ports/common/guts/execvpe.c    |  29 +++++++++
 ports/common/guts/fexecve.c    |  21 ++++++
 ports/common/pseudo_wrappers.c | 141 +++++++++++++++++++++++++++++++++++++++++
 ports/common/wrapfuncs.in      |   3 +
 test/test-exec.c               |  50 +++++++++++++++
 test/test-exec.sh              |  31 +++++++++
 test/test-execl.c              |   4 --
 test/test-execl.sh             |  13 ----
 9 files changed, 304 insertions(+), 17 deletions(-)
 create mode 100644 ports/common/guts/execveat.c
 create mode 100644 ports/common/guts/execvpe.c
 create mode 100644 ports/common/guts/fexecve.c
 create mode 100644 test/test-exec.c
 create mode 100755 test/test-exec.sh
 delete mode 100644 test/test-execl.c
 delete mode 100755 test/test-execl.sh

diff --git a/ports/common/guts/execveat.c b/ports/common/guts/execveat.c
new file mode 100644
index 0000000..10e0d52
--- /dev/null
+++ b/ports/common/guts/execveat.c
@@ -0,0 +1,29 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static int
+ * wrap_execveat(int dirfd, const char *path, char *const *argv, char *const *envp, int flags) {
+ *	int rc = -1;
+ */
+	char **new_environ;
+
+	/* as for execve(), the path is not canonicalized or redirected
+	 * into the chroot environment
+	 */
+	if (antimagic == 0 && path && (path[0] == '/' || dirfd == AT_FDCWD)) {
+		const char *path_guess = pseudo_exec_path(path, 0);
+		pseudo_client_op(OP_EXEC, PSA_EXEC, -1, -1, path_guess, 0);
+	}
+
+	new_environ = pseudo_setupenvp(envp);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+
+	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
+	rc = real_execveat(dirfd, path, argv, new_environ, flags);
+
+	pseudo_free_envp(new_environ);
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/common/guts/execvpe.c b/ports/common/guts/execvpe.c
new file mode 100644
index 0000000..37e4927
--- /dev/null
+++ b/ports/common/guts/execvpe.c
@@ -0,0 +1,29 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static int
+ * wrap_execvpe(const char *file, char *const *argv, char *const *envp) {
+ *	int rc = -1;
+ */
+	char **new_environ;
+
+	/* as for execvp(), the file is not canonicalized or redirected
+	 * into the chroot environment
+	 */
+	if (antimagic == 0) {
+		const char *path_guess = pseudo_exec_path(file, 1);
+		pseudo_client_op(OP_EXEC, PSA_EXEC, -1, -1, path_guess, 0);
+	}
+
+	new_environ = pseudo_setupenvp(envp);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+
+	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
+	rc = real_execvpe(file, argv, new_environ);
+
+	pseudo_free_envp(new_environ);
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/common/guts/fexecve.c b/ports/common/guts/fexecve.c
new file mode 100644
index 0000000..a0162d3
--- /dev/null
+++ b/ports/common/guts/fexecve.c
@@ -0,0 +1,21 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static int
+ * wrap_fexecve(int fd, char *const *argv, char *const *envp) {
+ *	int rc = -1;
+ */
+	char **new_environ;
+
+	new_environ = pseudo_setupenvp(envp);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+
+	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
+	rc = real_fexecve(fd, argv, new_environ);
+
+	pseudo_free_envp(new_environ);
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/common/pseudo_wrappers.c b/ports/common/pseudo_wrappers.c
index 2cbc946..2ad0814 100644
--- a/ports/common/pseudo_wrappers.c
+++ b/ports/common/pseudo_wrappers.c
@@ -331,6 +331,120 @@ execvp(const char *file, char *const *argv) {
 	return rc;
 }
 
+int
+execvpe(const char *file, char *const *argv, char *const *envp) {
+	sigset_t saved;
+
+	int rc = -1;
+	PROFILE_START;
+
+	if (!pseudo_check_wrappers() || !real_execvpe) {
+		/* rc was initialized to the "failure" value */
+		pseudo_enosys("execvpe");
+		PROFILE_DONE;
+		return rc;
+	}
+
+	pseudo_debug(PDBGF_WRAPPER, "called: execvpe\n");
+	pseudo_sigblock(&saved);
+	if (pseudo_getlock()) {
+		errno = EBUSY;
+		sigprocmask(SIG_SETMASK, &saved, NULL);
+		PROFILE_DONE;
+		return -1;
+	}
+
+	int save_errno;
+
+	/* exec*() use this to restore the sig mask */
+	pseudo_saved_sigmask = saved;
+	rc = wrap_execvpe(file, argv, envp);
+
+	save_errno = errno;
+	pseudo_droplock();
+	sigprocmask(SIG_SETMASK, &saved, NULL);
+	pseudo_debug(PDBGF_WRAPPER, "completed: execvpe\n");
+	errno = save_errno;
+	PROFILE_DONE;
+	return rc;
+}
+
+int
+fexecve(int fd, char *const *argv, char *const *envp) {
+	sigset_t saved;
+
+	int rc = -1;
+	PROFILE_START;
+
+	if (!pseudo_check_wrappers() || !real_fexecve) {
+		/* rc was initialized to the "failure" value */
+		pseudo_enosys("fexecve");
+		PROFILE_DONE;
+		return rc;
+	}
+
+	pseudo_debug(PDBGF_WRAPPER, "called: fexecve\n");
+	pseudo_sigblock(&saved);
+	if (pseudo_getlock()) {
+		errno = EBUSY;
+		sigprocmask(SIG_SETMASK, &saved, NULL);
+		PROFILE_DONE;
+		return -1;
+	}
+
+	int save_errno;
+
+	/* exec*() use this to restore the sig mask */
+	pseudo_saved_sigmask = saved;
+	rc = wrap_fexecve(fd, argv, envp);
+
+	save_errno = errno;
+	pseudo_droplock();
+	sigprocmask(SIG_SETMASK, &saved, NULL);
+	pseudo_debug(PDBGF_WRAPPER, "completed: fexecve\n");
+	errno = save_errno;
+	PROFILE_DONE;
+	return rc;
+}
+
+int
+execveat(int dirfd, const char *path, char *const *argv, char *const *envp, int flags) {
+	sigset_t saved;
+
+	int rc = -1;
+	PROFILE_START;
+
+	if (!pseudo_check_wrappers() || !real_execveat) {
+		/* rc was initialized to the "failure" value */
+		pseudo_enosys("execveat");
+		PROFILE_DONE;
+		return rc;
+	}
+
+	pseudo_debug(PDBGF_WRAPPER, "called: execveat\n");
+	pseudo_sigblock(&saved);
+	if (pseudo_getlock()) {
+		errno = EBUSY;
+		sigprocmask(SIG_SETMASK, &saved, NULL);
+		PROFILE_DONE;
+		return -1;
+	}
+
+	int save_errno;
+
+	/* exec*() use this to restore the sig mask */
+	pseudo_saved_sigmask = saved;
+	rc = wrap_execveat(dirfd, path, argv, envp, flags);
+
+	save_errno = errno;
+	pseudo_droplock();
+	sigprocmask(SIG_SETMASK, &saved, NULL);
+	pseudo_debug(PDBGF_WRAPPER, "completed: execveat\n");
+	errno = save_errno;
+	PROFILE_DONE;
+	return rc;
+}
+
 /* no profiling in fork because it wouldn't work anyway
  * half the time
  */
@@ -403,6 +517,33 @@ wrap_execvp(const char *file, char *const *argv) {
 }
 
 static int
+wrap_execvpe(const char *file, char *const *argv, char *const *envp) {
+	int rc = -1;
+
+#include "guts/execvpe.c"
+
+	return rc;
+}
+
+static int
+wrap_fexecve(int fd, char *const *argv, char *const *envp) {
+	int rc = -1;
+
+#include "guts/fexecve.c"
+
+	return rc;
+}
+
+static int
+wrap_execveat(int dirfd, const char *path, char *const *argv, char *const *envp, int flags) {
+	int rc = -1;
+
+#include "guts/execveat.c"
+
+	return rc;
+}
+
+static int
 wrap_fork(void) {
 	int rc = -1;
 	
diff --git a/ports/common/wrapfuncs.in b/ports/common/wrapfuncs.in
index 9a44ac1..9b01bf2 100644
--- a/ports/common/wrapfuncs.in
+++ b/ports/common/wrapfuncs.in
@@ -7,3 +7,6 @@ int execvp(const char *file, char *const *argv); /* hand_wrapped=1 */
 int fork(void); /* hand_wrapped=1 */
 int posix_spawn(pid_t *pid, const char *path, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp); /* hand_wrapped=1 */
 int posix_spawnp(pid_t *pid, const char *file, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp); /* hand_wrapped=1 */
+int execvpe(const char *file, char *const *argv, char *const *envp); /* hand_wrapped=1 */
+int fexecve(int fd, char *const *argv, char *const *envp); /* hand_wrapped=1 */
+int execveat(int dirfd, const char *path, char *const *argv, char *const *envp, int flags); /* hand_wrapped=1 */
diff --git a/test/test-exec.c b/test/test-exec.c
new file mode 100644
index 0000000..82ceddf
--- /dev/null
+++ b/test/test-exec.c
@@ -0,0 +1,50 @@
+/*
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * Run "/usr/bin/env A=A B=B C=C" through an exec function.
+ *
+ * usage: test-exec [execl|execvpe|fexecve|execveat [VAR=value...]]
+ *
+ * execl() keeps the caller's environment; the others pass only the
+ * VAR=value arguments given, so pseudo has to add its own variables back
+ * (or leave them out, if PSEUDO_UNLOAD is among them).
+ */
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(int argc, char **argv) {
+	char *args[] = { "env", "A=A", "B=B", "C=C", NULL };
+	/* argv[2] onwards, followed by argv's terminating NULL */
+	char **envp = argc > 2 ? argv + 2 : argv + argc;
+	const char *fn = argc > 1 ? argv[1] : "execl";
+	int fd;
+
+	if (!strcmp(fn, "execl")) {
+		return execl("/usr/bin/env", "/usr/bin/env", "A=A", "B=B", "C=C", NULL);
+	} else if (!strcmp(fn, "execvpe")) {
+		/* searched for in the caller's PATH */
+		execvpe("env", args, envp);
+	} else if (!strcmp(fn, "fexecve")) {
+		fd = open("/usr/bin/env", O_RDONLY | O_CLOEXEC);
+		if (fd == -1) {
+			perror("/usr/bin/env");
+			return 2;
+		}
+		fexecve(fd, args, envp);
+	} else if (!strcmp(fn, "execveat")) {
+		fd = open("/usr/bin", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+		if (fd == -1) {
+			perror("/usr/bin");
+			return 2;
+		}
+		execveat(fd, "env", args, envp, 0);
+	} else {
+		fprintf(stderr, "unknown function '%s'\n", fn);
+		return 2;
+	}
+	perror(fn);
+	return 2;
+}
diff --git a/test/test-exec.sh b/test/test-exec.sh
new file mode 100755
index 0000000..4308631
--- /dev/null
+++ b/test/test-exec.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: LGPL-2.1-only
+#
+# Run env through each exec function pseudo wraps.  The arguments must
+# get through, and for the functions given an explicit environment, an
+# empty one must get libpseudo back in LD_PRELOAD (as with env -i), and
+# one with PSEUDO_UNLOAD must not.
+
+test_exec="$(dirname "$0")/test-exec"
+
+"$test_exec" | grep -q "C=C" || { echo "FAILED: execl"; exit 1; }
+
+rc=0
+for fn in execvpe fexecve execveat; do
+    out=$("$test_exec" $fn)
+    if ! grep -q "C=C" <<< "$out"; then
+        echo "FAILED: $fn: arguments not passed"
+        rc=1
+    fi
+    if ! grep -q "^LD_PRELOAD=.*libpseudo" <<< "$out"; then
+        echo "FAILED: $fn: pseudo not restored to LD_PRELOAD"
+        rc=1
+    fi
+    out=$("$test_exec" $fn PSEUDO_UNLOAD=1)
+    if grep -q "^LD_PRELOAD=.*libpseudo" <<< "$out"; then
+        echo "FAILED: $fn: PSEUDO_UNLOAD did not drop pseudo"
+        rc=1
+    fi
+done
+exit $rc
diff --git a/test/test-execl.c b/test/test-execl.c
deleted file mode 100644
index 31b803c..0000000
--- a/test/test-execl.c
+++ /dev/null
@@ -1,4 +0,0 @@
-#include <unistd.h>
-int main() {
-        return execl("/usr/bin/env", "/usr/bin/env", "A=A", "B=B", "C=C", NULL);
-}
diff --git a/test/test-execl.sh b/test/test-execl.sh
deleted file mode 100755
index 8715822..0000000
--- a/test/test-execl.sh
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/bash
-#
-# SPDX-License-Identifier: LGPL-2.1-only
-#
-$(dirname "$0")/test-execl | grep -q "C=C"
-
-if [ "$?" = "0" ]
-then
-    #echo "Passed."
-    exit 0
-fi
-#echo "Failed"
-exit 1
-- 
1.8.3.1

