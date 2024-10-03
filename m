Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96888CF857F
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 11:30:23 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.9210.1727955022362706993
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Oct 2024 04:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KJNS98+d;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so7448755e9.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Oct 2024 04:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727955020; x=1728559820; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JE5YqYtSDqStvuoxlAPhD/Zjo25lXOfkBNH/VclMqw=;
        b=KJNS98+dEWsZXrm9/ngWqIGEaFaR0EwqNoRbwtGNXcVWr2Q+F7L1rni1wfGp1crmTz
         B8m853UGMzOZzDmix3SSVviOtAS8i8oBo1jap3AjlcjEWcRS5qMvMS9qAJwdEsEKO1J+
         Ri+8YZ4WJcoXwGczwBZ4NtviU8kfwJqsrMwZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955020; x=1728559820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JE5YqYtSDqStvuoxlAPhD/Zjo25lXOfkBNH/VclMqw=;
        b=tGqfMV+i9EPxQco8e2VQ1P5MqYULu/+mxLI6uCi0DGp0m+TpfJs2gfAIHCjT7E2Kvp
         LBxw0MYXk3+LBH4UPRW8aFhpzUI+frIx+x4oijER4IP+QCRjv0JDUrUvw7CX3W5Lb502
         2FmR6HgS8Ym4nrQUuGhuxX6x4aZHZTCmHFTHRkrMPTzg92IFurqpZzb/XOVedOgfDDsf
         VL4RZknDD6xWOPlGqhbF2apu8cNUyP2SaoiT56IOThMw24k1LwJJAZlfABSh3J/na5XI
         EhctFzK03wV/mLXV+fQVNcx25T2eXsECalygGVB1Peu6TIpXEU9CoFVd04R9xNfPLD3D
         ypxQ==
X-Gm-Message-State: AOJu0YwvWwuOBRUeYNbawo36OchvjU6o363RmWhtLqDe073je5miT+66
	RuyyGDNav5XdxRnR/SpPBRwws3T6Ko+tv43CaYEL4kPeM9Yr40iGprTInX7gW6G0i7zOb2i1tLC
	k
X-Google-Smtp-Source: AGHT+IGz23W1lZNDhIB9/dNEO4kB0j3MNSx9HfhNttBz4KUaJ1OIzVT3WrgDHxuk30gps6z3apdWpA==
X-Received: by 2002:a05:600c:3b08:b0:42f:310f:de9 with SMTP id 5b1f17b1804b1-42f777c07ebmr46566175e9.15.1727955020409;
        Thu, 03 Oct 2024 04:30:20 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cae3:f165:6194:3295])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8026567fsm13370075e9.26.2024.10.03.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:30:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [PATCH 2/2] ports: Add wrappers for posix_spawn/posix_spawnp
Date: Thu,  3 Oct 2024 12:30:18 +0100
Message-ID: <20241003113018.3531433-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003113018.3531433-1-richard.purdie@linuxfoundation.org>
References: <20241003113018.3531433-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Oct 2024 11:30:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/687

Add wrappers for the posix_spawn functions since they're being increasingly
used on modern Linux, e.g. in python 3.13 after:
https://github.com/python/cpython/commit/2b93f5224216d10f8119373e72b5c2b3984e0af6

They can be handled similarly to execve and use the setupenvp functionality.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/common/guts/posix_spawn.c  | 34 ++++++++++++
 ports/common/guts/posix_spawnp.c | 34 ++++++++++++
 ports/common/portdefs.h          |  1 +
 ports/common/pseudo_wrappers.c   | 95 ++++++++++++++++++++++++++++++++
 ports/common/wrapfuncs.in        |  2 +
 5 files changed, 166 insertions(+)
 create mode 100644 ports/common/guts/posix_spawn.c
 create mode 100644 ports/common/guts/posix_spawnp.c
 create mode 100644 ports/common/portdefs.h

diff --git a/ports/common/guts/posix_spawn.c b/ports/common/guts/posix_spawn.c
new file mode 100644
index 0000000..def14c8
--- /dev/null
+++ b/ports/common/guts/posix_spawn.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2024 Linux Foundation
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static int
+ * weap_posix_spawn(pid_t *pid, const char *path, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
+ *	int rc = -1;
+ */
+	char * const *new_environ;
+	/* note:  we don't canonicalize this, because we are intentionally
+	 * NOT redirecting execs into the chroot environment.  If you try
+	 * to execute /bin/sh, you get the actual /bin/sh, not
+	 * <CHROOT>/bin/sh.  This allows use of basic utilities.  This
+	 * design will likely be revisited.
+	 */
+        if (antimagic == 0) {
+		const char *path_guess = pseudo_exec_path(path, 0);
+                pseudo_client_op(OP_EXEC, PSA_EXEC, -1, -1, path_guess, 0);
+        }
+
+	new_environ = pseudo_setupenvp(envp);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+
+	/* if exec() fails, we may end up taking signals unexpectedly...
+	 * not much we can do about that.
+	 */
+	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
+	rc = real_posix_spawn(pid, path, file_actions, attrp, argv, new_environ);
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/common/guts/posix_spawnp.c b/ports/common/guts/posix_spawnp.c
new file mode 100644
index 0000000..b2e1fc8
--- /dev/null
+++ b/ports/common/guts/posix_spawnp.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2024 Linux Foundation
+ *
+ * SPDX-License-Identifier: LGPL-2.1-only
+ *
+ * static int
+ * wrap_posix_spawnp(pid_t *pid, const char *file, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
+ *	int rc = -1;
+ */
+	char * const *new_environ;
+	/* note:  we don't canonicalize this, because we are intentionally
+	 * NOT redirecting execs into the chroot environment.  If you try
+	 * to execute /bin/sh, you get the actual /bin/sh, not
+	 * <CHROOT>/bin/sh.  This allows use of basic utilities.  This
+	 * design will likely be revisited.
+	 */
+        if (antimagic == 0) {
+		const char *path_guess = pseudo_exec_path(file, 1);
+                pseudo_client_op(OP_EXEC, PSA_EXEC, -1, -1, path_guess, 0);
+        }
+
+	new_environ = pseudo_setupenvp(envp);
+	if (pseudo_has_unload(new_environ))
+		new_environ = pseudo_dropenvp(new_environ);
+
+	/* if exec() fails, we may end up taking signals unexpectedly...
+	 * not much we can do about that.
+	 */
+	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
+	rc = real_posix_spawnp(pid, file, file_actions, attrp, argv, new_environ);
+
+/*	return rc;
+ * }
+ */
diff --git a/ports/common/portdefs.h b/ports/common/portdefs.h
new file mode 100644
index 0000000..e6233bc
--- /dev/null
+++ b/ports/common/portdefs.h
@@ -0,0 +1 @@
+#include <spawn.h>
diff --git a/ports/common/pseudo_wrappers.c b/ports/common/pseudo_wrappers.c
index 92dfaa8..2cbc946 100644
--- a/ports/common/pseudo_wrappers.c
+++ b/ports/common/pseudo_wrappers.c
@@ -411,3 +411,98 @@ wrap_fork(void) {
 	return rc;
 }
 
+
+int
+posix_spawn(pid_t *pid, const char *path, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
+	sigset_t saved;
+
+	int rc = -1;
+	PROFILE_START;
+
+	if (!pseudo_check_wrappers() || !real_posix_spawn) {
+		/* rc was initialized to the "failure" value */
+		pseudo_enosys("posix_spawn");
+		PROFILE_DONE;
+		return rc;
+	}
+
+	pseudo_debug(PDBGF_WRAPPER, "called: posix_spawn\n");
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
+	rc = wrap_posix_spawn(pid, path, file_actions, attrp, argv, envp);
+
+	save_errno = errno;
+	pseudo_droplock();
+	sigprocmask(SIG_SETMASK, &saved, NULL);
+	pseudo_debug(PDBGF_WRAPPER, "completed: posix_spawn\n");
+	errno = save_errno;
+	PROFILE_DONE;
+	return rc;
+}
+
+int
+posix_spawnp(pid_t *pid, const char *file, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
+	sigset_t saved;
+
+	int rc = -1;
+	PROFILE_START;
+
+	if (!pseudo_check_wrappers() || !real_posix_spawnp) {
+		/* rc was initialized to the "failure" value */
+		pseudo_enosys("posix_spawn");
+		PROFILE_DONE;
+		return rc;
+	}
+
+	pseudo_debug(PDBGF_WRAPPER, "called: posix_spawnp\n");
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
+	rc = wrap_posix_spawnp(pid, file, file_actions, attrp, argv, envp);
+
+	save_errno = errno;
+	pseudo_droplock();
+	sigprocmask(SIG_SETMASK, &saved, NULL);
+	pseudo_debug(PDBGF_WRAPPER, "completed: posix_spawnp\n");
+	errno = save_errno;
+	PROFILE_DONE;
+	return rc;
+}
+
+
+static int
+wrap_posix_spawn(pid_t *pid, const char *path, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
+	int rc = -1;
+
+#include "guts/posix_spawn.c"
+
+	return rc;
+}
+
+static int
+wrap_posix_spawnp(pid_t *pid, const char *file, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
+	int rc = -1;
+
+#include "guts/posix_spawnp.c"
+
+	return rc;
+}
diff --git a/ports/common/wrapfuncs.in b/ports/common/wrapfuncs.in
index 17440f9..9a44ac1 100644
--- a/ports/common/wrapfuncs.in
+++ b/ports/common/wrapfuncs.in
@@ -5,3 +5,5 @@ int execv(const char *file, char *const *argv); /* hand_wrapped=1 */
 int execve(const char *file, char *const *argv, char *const *envp); /* hand_wrapped=1 */
 int execvp(const char *file, char *const *argv); /* hand_wrapped=1 */
 int fork(void); /* hand_wrapped=1 */
+int posix_spawn(pid_t *pid, const char *path, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp); /* hand_wrapped=1 */
+int posix_spawnp(pid_t *pid, const char *file, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp); /* hand_wrapped=1 */

