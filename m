Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.286.1794500401045310330
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 08:20:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ACGJxKx2743931
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 10:20:00 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 5/6] ports/linux/pseudo_wrappers: Fake seccomp filters set by prctl()
Date: Thu, 12 Nov 2026 10:19:57 -0600
Message-Id: <1794500398-31706-6-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794500398-31706-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 16:20:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5330
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

prctl(PR_SET_SECCOMP) was compared against SECCOMP_SET_MODE_FILTER,
which is the seccomp() system call's value.  prctl() takes
SECCOMP_MODE_*, where that value means strict mode, so prctl() filters
were really installed and strict mode was faked by accident.  Fake both
SECCOMP_MODE_FILTER and SECCOMP_MODE_STRICT.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 ports/linux/pseudo_wrappers.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ports/linux/pseudo_wrappers.c b/ports/linux/pseudo_wrappers.c
index 7d1e7d9..e3cf18b 100644
--- a/ports/linux/pseudo_wrappers.c
+++ b/ports/linux/pseudo_wrappers.c
@@ -240,15 +240,18 @@ prctl(int option, ...) {
 		return rc;
 	}
 
-#ifdef SECCOMP_SET_MODE_FILTER
+#ifdef PR_SET_SECCOMP
 	/* pseudo and seccomp are incompatible as pseudo uses different syscalls
-	 * so pretend to enable seccomp but really do nothing */
+	 * so pretend to enable seccomp but really do nothing.  prctl() takes
+	 * SECCOMP_MODE_*, not the SECCOMP_SET_MODE_* values seccomp() takes.
+	 */
 	if (option == PR_SET_SECCOMP) {
 		unsigned long cmd;
 		va_start(ap, option);
 		cmd = va_arg(ap, unsigned long);
 		va_end(ap);
-		if (cmd == SECCOMP_SET_MODE_FILTER) {
+		if (cmd == SECCOMP_MODE_STRICT || cmd == SECCOMP_MODE_FILTER) {
+		    pseudo_debug(PDBGF_SYSCALL, "prctl, faking seccomp.\n");
 		    return 0;
 		}
 	}
-- 
1.8.3.1

