Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2584.1794370872124947678
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 20:21:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AB4L3mJ2428068
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 22:21:09 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [pseudo][PATCH 33/34] wrappers: Don't re-block signals in nested wrapper calls
Date: Tue, 10 Nov 2026 22:21:01 -0600
Message-Id: <1794370862-30908-34-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1794370862-30908-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 04:21:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5290
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mark Hatle <mark.hatle@amd.com>

pseudo's own calls to wrapped functions, such as fcntl() for the path
lock, go through the full wrapper and block and restore signals again,
although the outer wrapper already blocked them.  Skip that when this
thread already holds the pseudo lock, and keep the outer wrapper's
saved mask for exec*().

On a tar/chown/find/ls/rm workload of 40,000 files this halves the
rt_sigprocmask calls, from 3.1M to 1.5M.

AI-Generated: Uses GitHub Copilot
Signed-off-by: Mark Hatle <mark.hatle@amd.com>
---
 doc/program_flow      |  4 ++--
 pseudo_wrappers.c     |  6 ++++++
 templates/wrapfuncs.c | 21 ++++++++++++++++-----
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/doc/program_flow b/doc/program_flow
index 4137cf0..5fbdb5d 100644
--- a/doc/program_flow
+++ b/doc/program_flow
@@ -62,7 +62,7 @@ libpseudo execution flow:
 			return enosys
 		variadic setup (if necessary)
 		if pseudo_disabled  return real_*()
-		pseudo_sigblock
+		pseudo_sigblock (unless this thread already holds the lock)
 		pseudo_getlock
 		if antimagic  rc = real_*()
 		else
@@ -74,7 +74,7 @@ libpseudo execution flow:
 				drop path lock
 		variadic end (if necessary)
 		pseudo_droplock
-		unmask signals
+		unmask signals (if they were blocked above)
 		return rc
 
 pseudo execution flow:
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index a4e9015..13d7ede 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -58,6 +58,7 @@ static pthread_t pseudo_mutex_holder;
 static int pseudo_mutex_recursion = 0;
 static int pseudo_getlock(void);
 static void pseudo_droplock(void);
+static int pseudo_lock_held(void);
 static size_t pseudo_dechroot(char *, size_t);
 static void pseudo_sigblock(sigset_t *);
 
@@ -226,6 +227,11 @@ pseudo_getlock(void) {
 	}
 }
 
+static int
+pseudo_lock_held(void) {
+	return pthread_equal(pseudo_mutex_holder, pthread_self());
+}
+
 static void
 pseudo_droplock(void) {
 	if (--pseudo_mutex_recursion == 0) {
diff --git a/templates/wrapfuncs.c b/templates/wrapfuncs.c
index d7fb548..2fa4212 100644
--- a/templates/wrapfuncs.c
+++ b/templates/wrapfuncs.c
@@ -20,6 +20,7 @@ ${maybe_skip}
 ${type}
 ${name}(${decl_args}) {
 	sigset_t saved;
+	int nested;
 	${variadic_decl}
 	${rc_decl}
 	${paths_decl}
@@ -44,11 +45,17 @@ ${maybe_async_skip}
 	}
 
 	pseudo_debug(PDBGF_WRAPPER, "wrapper called: ${name}\n");
-	pseudo_sigblock(&saved);
+	/* If this thread already holds the lock, an outer wrapper has
+	 * already blocked signals, so don't block and restore them again.
+	 */
+	nested = pseudo_lock_held();
+	if (!nested)
+		pseudo_sigblock(&saved);
 	pseudo_debug(PDBGF_WRAPPER | PDBGF_VERBOSE, "${name} - signals blocked, obtaining lock\n");
 	if (pseudo_getlock()) {
 		errno = EBUSY;
-		sigprocmask(SIG_SETMASK, &saved, NULL);
+		if (!nested)
+			sigprocmask(SIG_SETMASK, &saved, NULL);
 		pseudo_debug(PDBGF_WRAPPER, "${name} failed to get lock, giving EBUSY.\n");
 		PROFILE_DONE;
 		${def_return}
@@ -66,8 +73,11 @@ ${maybe_async_skip}
 			pseudo_debug(PDBGF_SYSCALL, "${name} ignored path, calling real syscall.\n");
 			${rc_assign} (*real_${name})(${call_args});
 		} else {
-			/* exec*() use this to restore the sig mask */
-			pseudo_saved_sigmask = saved;
+			/* exec*() use this to restore the sig mask; a
+			 * nested call keeps the outer wrapper's mask.
+			 */
+			if (!nested)
+				pseudo_saved_sigmask = saved;
 			${path_lock_begin}${rc_assign} wrap_$name(${call_args});${path_lock_end}
 		}
 	}
@@ -76,7 +86,8 @@ quick_exit:
 	__attribute__((unused));
 	save_errno = errno;
 	pseudo_droplock();
-	sigprocmask(SIG_SETMASK, &saved, NULL);
+	if (!nested)
+		sigprocmask(SIG_SETMASK, &saved, NULL);
 	pseudo_debug(PDBGF_WRAPPER | PDBGF_VERBOSE, "${name} - yielded lock, restored signals\n");
 	/* not strerror(), which can hang on systems using locale data for it */
 	pseudo_debug(PDBGF_WRAPPER, "wrapper completed: ${name} returns ${rc_format} (errno: %d)\n", ${rc_value}, save_errno);
-- 
1.8.3.1

