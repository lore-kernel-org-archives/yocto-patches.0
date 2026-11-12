Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.285.1794500400916248986
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 08:20:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ACGJxKv2743931
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 10:20:00 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 3/6] ports/linux/pseudo_wrappers: Report Landlock as unsupported
Date: Thu, 12 Nov 2026 10:19:55 -0600
Message-Id: <1794500398-31706-4-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 16:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5329
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

A Landlock sandbox restricts libpseudo along with the program that sets
it up, so pseudo can lose the server for good: reconnecting may need to
start a server, read the pidfile or fall back to changing directory,
and later operations need files such as passwd and group.  Fail the
Landlock system calls with ENOSYS, as an unsupporting kernel would,
much as seccomp filters are already ignored.  Leave them alone while
pseudo is disabled, so tests can still ask the kernel about Landlock.
Document both in README.security.

Tested with test-landlock, also with the client forced onto the
fchdir() connect fallback, which this alone is enough to fix.

[YOCTO #16493]

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 README.security               | 14 ++++++++++++++
 ports/linux/pseudo_wrappers.c | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/README.security b/README.security
index 45533f2..11b9b4b 100644
--- a/README.security
+++ b/README.security
@@ -141,6 +141,20 @@ that user.  The resulting metadata can only be trusted as much as every
 process running as the build user.
 
 
+7. SELF-SANDBOXING IS DISABLED
+
+libpseudo has to keep reaching the server and the filesystem on behalf
+of the program it is loaded into, so pseudo turns off the ways a
+program can restrict itself (ports/linux/pseudo_wrappers.c).  Requests
+to install a seccomp filter through syscall() or prctl() report success
+without installing anything, and the Landlock system calls fail with
+ENOSYS, as if the kernel did not support Landlock.  A program that
+sandboxes itself, such as xz, runs unsandboxed under pseudo, and one
+that refuses to run without its sandbox fails.  This doesn't apply to
+programs pseudo does not intercept (see section 1), and the Landlock
+calls reach the kernel while PSEUDO_DISABLED is set.
+
+
 RECOMMENDATIONS:
 
 * Run pseudo only on build output that is private to the build and is
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index 5e26aff..7d1e7d9 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -77,6 +77,11 @@ syscall(long number, ...) {
 #ifdef SYS_seccomp
 	    && number != SYS_seccomp
 #endif
+#ifdef SYS_landlock_create_ruleset
+	    && number != SYS_landlock_create_ruleset
+	    && number != SYS_landlock_add_rule
+	    && number != SYS_landlock_restrict_self
+#endif
 	    ) {
 		if (!real_syscall)
 			real_syscall = (long (*)(long, ...)) dlsym(RTLD_NEXT, "syscall");
@@ -109,6 +114,19 @@ syscall(long number, ...) {
                 goto call_syscall;
         }
 
+#ifdef SYS_landlock_create_ruleset
+	/* A Landlock sandbox also binds libpseudo, which then can't reach the
+	 * server (YOCTO #16493), so report Landlock as unsupported.
+	 */
+	if (number == SYS_landlock_create_ruleset ||
+	    number == SYS_landlock_add_rule ||
+	    number == SYS_landlock_restrict_self) {
+		pseudo_debug(PDBGF_SYSCALL, "syscall, refusing landlock.\n");
+		errno = ENOSYS;
+		return -1;
+	}
+#endif
+
 #ifdef SYS_openat2
 	/* There is a CVE patch (CVE-2025-45582) to tar 1.34 in Centos Stream which
 	 * uses syscall to access openat2() and breaks builds if we don't redirect.
-- 
1.8.3.1

