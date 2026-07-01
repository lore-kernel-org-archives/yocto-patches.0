Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF3FC44500
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 13:13:52 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.44827.1782911624508925392
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 06:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P8u8YDC8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b1710405so3475445e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1782911623; x=1783516423; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IpM5ZuLgfex/2/vmLYQ/z+u91sK8SAoQNKJCZbGnbM=;
        b=P8u8YDC8xcSSS3uZy0EJ1M09EBCjtu/KpKctkHR9qd1XjEETP8pby8XXrQg5Dj7g4D
         q3f9NLZVEqLi4PHj7J2d1PEU47pPH9V+QGrEPlZAtDKJ+TnY7acsVpDdDHtcXFo1eCNG
         j+P1XQVNTHXvPy/BeM1djl8NZZ+hgz3C5WDhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782911623; x=1783516423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0IpM5ZuLgfex/2/vmLYQ/z+u91sK8SAoQNKJCZbGnbM=;
        b=I2SjqtgAHsa2mi2l9VOXTBr3r5t4BjmULyYjBlaF6TSOfC/EnSlXHh9JsmNY/8tebp
         ZWFEWsvhXTbnesziEZCEJGFz/I8FZ/tRoTGxVORZMlbGJC2KYu9zaIQDGNnT6OwAD8tz
         p3vgduWVarihpicaFozMZ9djKiKhlB/AVTSpBLzTxP3wirDMShjnO4EYMQkW278JZq4+
         UY4H0vJdmeJDZRq5e4cudC9Vz9EClN5Z5Fu9lN5g+mv3Rkrmn5tWNFn0v+lklmg/Zi3S
         aVlec4tji31/e1KJ+r7d5aMst5Ev6nUy5mqL+ePiDm9uqukYGC3FnncW0MTXeeL+3Ly0
         UJ3w==
X-Gm-Message-State: AOJu0YzYP3yP+c3HlUiPFejQNGIGJr8re7AIsX4c6MYmPvHUaAQnW//M
	b5pQ6CZXiXhtmouksKDzuB4yNZAWaqnjfmSU+XHpeW7MAS6Uagf2YfYxu016UNoID8tYIpcJ+kc
	40EZ2
X-Gm-Gg: AfdE7ckoPLuS/QK4MPSsO7o+29c5BrQfsM+OiSJOZes/bqoelYOiLkshcbt+9dcsYHG
	9sdgRRyMe65CNtOyv7zv6uugwQwvRHSjQAc/OF0OZK3ZOInPQgGtWUrSEzLC1XqevxhwEm0jL0Z
	vzJ0tE60e5Wh1zKQN3n0kh3gWCriukimM5IAg6USpFtifQJDIH7xZmQK47T0lPPU30ex8cG61F6
	1AssW1EaLTJXWX3Qi/QErtEusO9Thae2ZF1J00OyTk32whbC56hnhdw4A28IXdrwIfbVEo1GZnI
	0laGi5M4pUYAolg5gK6Ze+pvPKzLOO112wbpFUZr0hm/2w4YbugBchywzMS8UTaKLdRPml71hKL
	eohw9Nq/gZM3jZ9jbjFTnxfTcDutWPPo0BerqAXqTgxFgFpC5N90h3stwbpGGow7ketFulgbH2w
	N0NYZplMlDJ8FisglT5SXGbbKdZDmlmI6oGYF2q8m26Q==
X-Received: by 2002:a05:600d:c:b0:493:aa28:38ad with SMTP id 5b1f17b1804b1-493c2b4442emr20131315e9.10.1782911622729;
        Wed, 01 Jul 2026 06:13:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6b3f:20f2:ee05:f032])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567884770sm17568280f8f.33.2026.07.01.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 06:13:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH 5/7] pseudo_util: Clean up memory handling for setupenvp results
Date: Wed,  1 Jul 2026 14:13:34 +0100
Message-ID: <20260701131336.3578279-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 13:13:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4347

Currently, the environment array allocated by pseudo_setupenvp is never
freed. Fix this (and the copy created by dropenvp).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ports/common/guts/execve.c       | 4 +++-
 ports/common/guts/posix_spawn.c  | 4 +++-
 ports/common/guts/posix_spawnp.c | 4 +++-
 pseudo.h                         | 2 +-
 pseudo_util.c                    | 3 ++-
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/ports/common/guts/execve.c b/ports/common/guts/execve.c
index 1144f7c..c2be66e 100644
--- a/ports/common/guts/execve.c
+++ b/ports/common/guts/execve.c
@@ -8,7 +8,7 @@
  * wrap_execve(const char *file, char *const *argv, char *const *envp) {
  *	int rc = -1;
  */
-	char * const *new_environ;
+	char **new_environ;
 	/* note:  we don't canonicalize this, because we are intentionally
 	 * NOT redirecting execs into the chroot environment.  If you try
 	 * to execute /bin/sh, you get the actual /bin/sh, not
@@ -30,6 +30,8 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_execve(file, argv, new_environ);
 
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/ports/common/guts/posix_spawn.c b/ports/common/guts/posix_spawn.c
index e15e68f..5896893 100644
--- a/ports/common/guts/posix_spawn.c
+++ b/ports/common/guts/posix_spawn.c
@@ -7,7 +7,7 @@
  * wrap_posix_spawn(pid_t *pid, const char *path, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
  *	int rc = -1;
  */
-	char * const *new_environ;
+	char **new_environ;
 	/* note:  we don't canonicalize this, because we are intentionally
 	 * NOT redirecting execs into the chroot environment.  If you try
 	 * to execute /bin/sh, you get the actual /bin/sh, not
@@ -29,6 +29,8 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_posix_spawn(pid, path, file_actions, attrp, argv, new_environ);
 
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/ports/common/guts/posix_spawnp.c b/ports/common/guts/posix_spawnp.c
index b2e1fc8..f3dc16b 100644
--- a/ports/common/guts/posix_spawnp.c
+++ b/ports/common/guts/posix_spawnp.c
@@ -7,7 +7,7 @@
  * wrap_posix_spawnp(pid_t *pid, const char *file, const posix_spawn_file_actions_t *file_actions, const posix_spawnattr_t *attrp, char *const *argv, char *const *envp) {
  *	int rc = -1;
  */
-	char * const *new_environ;
+	char **new_environ;
 	/* note:  we don't canonicalize this, because we are intentionally
 	 * NOT redirecting execs into the chroot environment.  If you try
 	 * to execute /bin/sh, you get the actual /bin/sh, not
@@ -29,6 +29,8 @@
 	sigprocmask(SIG_SETMASK, &pseudo_saved_sigmask, NULL);
 	rc = real_posix_spawnp(pid, file, file_actions, attrp, argv, new_environ);
 
+	free(new_environ);
+
 /*	return rc;
  * }
  */
diff --git a/pseudo.h b/pseudo.h
index 1152c19..a2d402c 100644
--- a/pseudo.h
+++ b/pseudo.h
@@ -66,7 +66,7 @@ void pseudo_new_pid(void);
 #define PSEUDO_MAX_LINK_RECURSION 16
 extern char *pseudo_fix_path(const char *, const char *, size_t, size_t, size_t *, int);
 extern void pseudo_dropenv(void);
-extern char **pseudo_dropenvp(char * const *);
+extern char **pseudo_dropenvp(char **);
 extern void pseudo_setupenv(void);
 extern char **pseudo_setupenvp(char * const *);
 extern char *pseudo_prefix_path(char *);
diff --git a/pseudo_util.c b/pseudo_util.c
index 5e77977..599cf31 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1005,7 +1005,7 @@ void pseudo_dropenv() {
 }
 
 char **
-pseudo_dropenvp(char * const *envp) {
+pseudo_dropenvp(char **envp) {
 	char **new_envp;
 	int i, j;
 
@@ -1036,6 +1036,7 @@ pseudo_dropenvp(char * const *envp) {
 		}
 	}
 	new_envp[j++] = NULL;
+	free(envp);
 	return new_envp;
 }
 

