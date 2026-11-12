Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.287.1794500401196055110
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 08:20:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ACGJxL02743931
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 10:20:00 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 6/6] ports/linux/pseudo_wrappers: Fake seccomp strict mode in syscall()
Date: Thu, 12 Nov 2026 10:19:58 -0600
Message-Id: <1794500398-31706-7-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 16:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5331
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

seccomp(SECCOMP_SET_MODE_STRICT) reached the kernel, which then kills
the process at its next system call other than read(), write() or
exit(), and libpseudo makes plenty of those.  Fake it like filter mode,
as prctl() now does, and say so in README.security.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 README.security               | 12 ++++++------
 ports/linux/pseudo_wrappers.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/README.security b/README.security
index 11b9b4b..7249b5d 100644
--- a/README.security
+++ b/README.security
@@ -146,12 +146,12 @@ process running as the build user.
 libpseudo has to keep reaching the server and the filesystem on behalf
 of the program it is loaded into, so pseudo turns off the ways a
 program can restrict itself (ports/linux/pseudo_wrappers.c).  Requests
-to install a seccomp filter through syscall() or prctl() report success
-without installing anything, and the Landlock system calls fail with
-ENOSYS, as if the kernel did not support Landlock.  A program that
-sandboxes itself, such as xz, runs unsandboxed under pseudo, and one
-that refuses to run without its sandbox fails.  This doesn't apply to
-programs pseudo does not intercept (see section 1), and the Landlock
+to enter seccomp strict or filter mode through syscall() or prctl()
+report success without doing anything, and the Landlock system calls
+fail with ENOSYS, as if the kernel did not support Landlock.  A program
+that sandboxes itself, such as xz, runs unsandboxed under pseudo, and
+one that refuses to run without its sandbox fails.  This doesn't apply
+to programs pseudo does not intercept (see section 1), and the Landlock
 calls reach the kernel while PSEUDO_DISABLED is set.
 
 
diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index e3cf18b..e8a2780 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -104,7 +104,7 @@ syscall(long number, ...) {
 		va_start(ap, number);
 		cmd = va_arg(ap, unsigned long);
 		va_end(ap);
-		if (cmd == SECCOMP_SET_MODE_FILTER) {
+		if (cmd == SECCOMP_SET_MODE_STRICT || cmd == SECCOMP_SET_MODE_FILTER) {
 		    return 0;
 		}
 	}
-- 
1.8.3.1

