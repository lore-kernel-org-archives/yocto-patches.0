Return-Path: <frezidok1@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159DACD8CB2
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 11:47:26 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18634.1781092042237948227
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 04:47:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=GptkZbdj;
 spf=pass (domain: gmail.com, ip: 209.85.208.45, mailfrom: frezidok1@gmail.com)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6914a658115so5935174a12.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781092040; x=1781696840; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKjJo4h6Iz1eCSezgQvZevQhOFuwgYtcblIWuWOlzfg=;
        b=GptkZbdjY5tLbWQKP7lDTswdwMcOH+aGIaZjAy5UHi1dyb8Bh+EtVlFm0r4A4mdScF
         NjalFRQ3vm/SVZMe69C/OwyysIedFzsjgTy5LpfDv7cnG1r9PT01WLDlmJrU9Ehuioq0
         rKm1tGA71EhWXhItP74fpKQBDnRMUMF+U/aRshJxGucHJDPw3+rwGOgzXiILeYOqqVHb
         TYnD342NQkoHEByTmbzHMnJifXUHnuQjyUh+l1SnDg0A1jU/SZWi3lB+Z/UShTlV+eLr
         LFsy0HKtSCaOvc14Oa3R2iziOd5LzWDVeNBU+Y5Map7Gnprc6oDYDtaGEvFlJ84H904I
         hbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092040; x=1781696840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKjJo4h6Iz1eCSezgQvZevQhOFuwgYtcblIWuWOlzfg=;
        b=ZGwr4sb1O6EydaOZhX2D1ci/cuOTobp6bMOt4d33z3ZV6cgKI0aF/uO2VjtJUfGMr3
         xp4S5R0k1dqSYR4sRzUKUPgtGaga96OBpGi3/4UGaRulRo/+MeDh+8TCKw4rIrhPrrmz
         zHF829vY3cvJe3pp3LMmkfTStFgcC7O9Rbjjcas96ILUbycfB8bJBxZbby+kSbpfi9IT
         7j2SsD8dI5+ugd5LvH9wTkjtWtKH8jm31EBVa5MCujiCjgpqJsKRs6uUXAkRpR5kaQPf
         aHwRUKtXd7tD8cjZcNjQW42SOdbYyKuhhIet4FJxAZWST+jCsOfsKsu5bq3p35pMDzNs
         +0/w==
X-Gm-Message-State: AOJu0YybsoMVL+9OT3Ht7oaqbkuWwnUewE4lZLEuiM1Zo0BrfqP1xFKR
	p0bRUBNZwW7S83b0s/xy0/SwcGlTAzTB46FLqGtZe5fBHSyMQ5HzKLr0am/qrTt/
X-Gm-Gg: Acq92OG9Kiwxx3ikT5RTyQUo1NPFLGGOWpn/dA+qy2JFb476x61LzWhAB+DJHx+dUGO
	yLEPGNFR27sKUaa6jXSw5XZfNEEMKj1YEIaCtU16oBKXqRWjFisACSLuIl+hVdJIZswzL6FB3M7
	KhDj5sOolN4Swl9sQJOpoRPq+0OnCxgcPJVTlwbuN7WWRo3um2jB6oAzidfKZket60RJpxMv+dN
	Kz3uUFY/bam4TeYcjJicZ/0wguiCSTkHID/77jeNqb9jN3K9gFkWN8l0rerSSMTPfiZDFgP0O4Z
	dJjzqvSd0dspVIy7ZitpNSaGIBwjN6IQDAnehDOXOmVvr5plQvxFXvLS6gyRVSvQobltZPnU1w7
	nRt/zGulmuDaDbDjfBAQUJFf9Exy27cgHc+5BVzcCruN8kEB1TI3UC2xAw28LDERF8ZaUDEXHVc
	C7GyJlM/UeUqcmu0u6jPwXVDScuk+t
X-Received: by 2002:a05:6402:43c6:b0:67f:7e9b:afe8 with SMTP id 4fb4d7f45d1cf-68fa4c267femr10916580a12.6.1781092040478;
        Wed, 10 Jun 2026 04:47:20 -0700 (PDT)
Received: from ubuntu1.. ([194.87.83.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6912faea64dsm5997164a12.19.2026.06.10.04.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:47:20 -0700 (PDT)
From: frezidok1@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Dmitry Sakhonchik <frezidok1@gmail.com>
Subject: [pseudo] [PATCH 7/8] wrappers: Change pseudo_diag() calls to appropriate macros
Date: Wed, 10 Jun 2026 14:46:09 +0300
Message-ID: <20260610114610.60776-7-frezidok1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610114610.60776-1-frezidok1@gmail.com>
References: <20260610114610.60776-1-frezidok1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 11:47:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4198

From: Dmitry Sakhonchik <frezidok1@gmail.com>

Implements [YOCTO #12141]

Signed-off-by: Dmitry Sakhonchik <frezidok1@gmail.com>
---
 ports/darwin/pseudo_wrappers.c      | 3 +--
 ports/linux/guts/fcntl.c            | 2 +-
 ports/linux/guts/fcntl64.c          | 2 +-
 ports/linux/guts/getpw.c            | 2 +-
 ports/linux/guts/openat.c           | 3 +--
 ports/linux/openat2/guts/openat2.c  | 3 +--
 ports/linux/xattr/pseudo_wrappers.c | 3 +--
 ports/unix/guts/getcwd.c            | 6 +++---
 ports/unix/guts/linkat.c            | 2 +-
 ports/unix/guts/nftw_wrapper_base.c | 6 +++---
 ports/unix/guts/symlinkat.c         | 2 +-
 ports/unix/guts/tempnam.c           | 2 +-
 ports/unix/guts/tmpnam.c            | 2 +-
 ports/unix/guts/unlinkat.c          | 2 +-
 pseudo_ipc.c                        | 2 +-
 pseudo_wrappers.c                   | 2 +-
 16 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/ports/darwin/pseudo_wrappers.c b/ports/darwin/pseudo_wrappers.c
index 3f05936..a7a1341 100644
--- a/ports/darwin/pseudo_wrappers.c
+++ b/ports/darwin/pseudo_wrappers.c
@@ -73,9 +73,8 @@ static int
 posix_permissions(const acl_header *header, int entries, int *extra, int *mode) {
 	int acl_seen = 0;
 	if (le32(header->version) != 2) {
-		pseudo_diag("Fatal: ACL support no available for header version %d.\n",
+		pseudo_critical("ACL support no available for header version %d.\n",
 			le32(header->version));
-		return 1;
 	}
 	*mode = 0;
 	*extra = 0;
diff --git a/ports/linux/guts/fcntl.c b/ports/linux/guts/fcntl.c
index ffb50be..d6babb5 100644
--- a/ports/linux/guts/fcntl.c
+++ b/ports/linux/guts/fcntl.c
@@ -89,7 +89,7 @@
 		break;
 #endif
 	default:
-		pseudo_diag("unknown fcntl argument %d, assuming long argument.\n",
+		pseudo_error("unknown fcntl argument %d, assuming long argument.\n",
 			cmd);
 		rc = real_fcntl(fd, cmd, arg);
 		break;
diff --git a/ports/linux/guts/fcntl64.c b/ports/linux/guts/fcntl64.c
index 99de43d..169fc6d 100644
--- a/ports/linux/guts/fcntl64.c
+++ b/ports/linux/guts/fcntl64.c
@@ -89,7 +89,7 @@
 		break;
 #endif
 	default:
-		pseudo_diag("unknown fcntl64 argument %d, assuming long argument.\n",
+		pseudo_error("unknown fcntl64 argument %d, assuming long argument.\n",
 			cmd);
 		rc = real_fcntl64(fd, cmd, arg);
 		break;
diff --git a/ports/linux/guts/getpw.c b/ports/linux/guts/getpw.c
index 5aa0bca..111799e 100644
--- a/ports/linux/guts/getpw.c
+++ b/ports/linux/guts/getpw.c
@@ -12,7 +12,7 @@
 	static char pwbuf[PSEUDO_PWD_MAX];
 	struct passwd *pwp;
 
-	pseudo_diag("warning: unsafe getpw() called.  hoping buf has at least %d chars.\n",
+	pseudo_warning("unsafe getpw() called.  hoping buf has at least %d chars.\n",
 		PSEUDO_PWD_MAX);
 	rc = wrap_getpwuid_r(uid, &pwd, pwbuf, PSEUDO_PWD_MAX, &pwp);
 	/* different error return conventions */
diff --git a/ports/linux/guts/openat.c b/ports/linux/guts/openat.c
index 656ac2b..0a44063 100644
--- a/ports/linux/guts/openat.c
+++ b/ports/linux/guts/openat.c
@@ -112,9 +112,8 @@
 		 * stack to stuff that's going to try to drop the lock.
 		 */
 		if (pseudo_getlock()) {
-			pseudo_diag("PANIC: after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
+			pseudo_critical("after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
 				path, rc, errno, save_errno);
-			abort();
 		}
 		errno = save_errno;
 	}
diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/guts/openat2.c
index a0acbe7..f1c523e 100644
--- a/ports/linux/openat2/guts/openat2.c
+++ b/ports/linux/openat2/guts/openat2.c
@@ -147,9 +147,8 @@
 		 * stack to stuff that's going to try to drop the lock.
 		 */
 		if (pseudo_getlock()) {
-			pseudo_diag("PANIC: after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
+			pseudo_critical("PANIC: after opening a readonly/writeonly FIFO (path '%s', fd %d, errno %d, saved errno %d), could not regain lock. unrecoverable. sorry. bye.\n",
 				pseudo_path, rc, errno, save_errno);
-			abort();
 		}
 		errno = save_errno;
 	}
diff --git a/ports/linux/xattr/pseudo_wrappers.c b/ports/linux/xattr/pseudo_wrappers.c
index 0b65920..896c84d 100644
--- a/ports/linux/xattr/pseudo_wrappers.c
+++ b/ports/linux/xattr/pseudo_wrappers.c
@@ -66,9 +66,8 @@ static int
 posix_permissions(const acl_header *header, int entries, int *extra, int *mode) {
 	int acl_seen = 0;
 	if (le32(header->version) != 2) {
-		pseudo_diag("Fatal: ACL support not available for header version %d.\n",
+		pseudo_critical("Fatal: ACL support not available for header version %d.\n",
 			le32(header->version));
-		return -1;
 	}
 	*mode = 0;
 	*extra = 0;
diff --git a/ports/unix/guts/getcwd.c b/ports/unix/guts/getcwd.c
index a5bf2ef..f9d6bfc 100644
--- a/ports/unix/guts/getcwd.c
+++ b/ports/unix/guts/getcwd.c
@@ -11,7 +11,7 @@
 	pseudo_debug(PDBGF_CLIENT, "wrap_getcwd: %p, %lu\n",
 		(void *) buf, (unsigned long) size);
 	if (!pseudo_cwd) {
-		pseudo_diag("Asked for CWD, but don't have it!\n");
+		pseudo_error("Asked for CWD, but don't have it!\n");
 		errno = EACCES;
 		return NULL;
 	}
@@ -33,13 +33,13 @@
 		if (size) {
 			buf = malloc(size);
 		} else {
-			pseudo_diag("can't figure out CWD: length %ld + 1 - %ld => %ld\n",
+			pseudo_error("can't figure out CWD: length %ld + 1 - %ld => %ld\n",
 				(unsigned long) pseudo_cwd_len,
 				(unsigned long) pseudo_chroot_len,
 				(unsigned long) size);
 		}
 		if (!buf) {
-			pseudo_diag("couldn't allocate requested CWD buffer - need %ld byes\n",
+			pseudo_error("couldn't allocate requested CWD buffer - need %ld byes\n",
 				(unsigned long) size);
 			errno = ENOMEM;
 			return NULL;
diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
index 60fbf63..ff707c8 100644
--- a/ports/unix/guts/linkat.c
+++ b/ports/unix/guts/linkat.c
@@ -82,7 +82,7 @@
 		rc2 = base_lstat(oldpath, &buf);
 	}
 	if (rc2 == -1) {
-		pseudo_diag("Fatal: Tried to stat '%s' after linking it, but failed: %s.\n",
+		pseudo_error("Fatal: Tried to stat '%s' after linking it, but failed: %s.\n",
 			oldpath, strerror(errno));
 		errno = ENOENT;
 		return rc2;
diff --git a/ports/unix/guts/nftw_wrapper_base.c b/ports/unix/guts/nftw_wrapper_base.c
index 000fa18..b9f761a 100644
--- a/ports/unix/guts/nftw_wrapper_base.c
+++ b/ports/unix/guts/nftw_wrapper_base.c
@@ -68,7 +68,7 @@ static void NFTW_DELETE_FN_NAME() {
             NFTW_STORAGE_ARRAY_NAME = NULL;
             --NFTW_STORAGE_ARRAY_SIZE;
         } else {
-            pseudo_diag("%s: Invalid callback storage content, can't find corresponding data", __func__);
+            pseudo_error("%s: Invalid callback storage content, can't find corresponding data", __func__);
         }
         return;
     }
@@ -82,7 +82,7 @@ static void NFTW_DELETE_FN_NAME() {
     }
 
     if (found_idx == -1) {
-        pseudo_diag("%s: Invalid callback storage content, can't find corresponding data", __func__);
+        pseudo_error("%s: Invalid callback storage content, can't find corresponding data", __func__);
         return;
     }
 
@@ -102,7 +102,7 @@ static int NFTW_CALLBACK_NAME(const char* fpath, const struct NFTW_STAT_STRUCT _
     struct NFTW_STAT_STRUCT pseudo_sb;
 
     if (!NFTW_FIND_FN_NAME(&saved_details)) {
-        pseudo_diag("%s: Could not find corresponding callback!", __func__);
+        pseudo_error("%s: Could not find corresponding callback!", __func__);
         return -1;
     }
 
diff --git a/ports/unix/guts/symlinkat.c b/ports/unix/guts/symlinkat.c
index c96ff3e..5673912 100644
--- a/ports/unix/guts/symlinkat.c
+++ b/ports/unix/guts/symlinkat.c
@@ -38,7 +38,7 @@
 #endif
 	if (rc == -1) {
 		int save_errno = errno;
-		pseudo_diag("symlinkat: couldn't stat '%s' even though symlink creation succeeded (%s).\n",
+		pseudo_warning("symlinkat: couldn't stat '%s' even though symlink creation succeeded (%s).\n",
 			newpath, strerror(errno));
 		errno = save_errno;
 		free(roldname);
diff --git a/ports/unix/guts/tempnam.c b/ports/unix/guts/tempnam.c
index 26ae3e1..e2d2c75 100644
--- a/ports/unix/guts/tempnam.c
+++ b/ports/unix/guts/tempnam.c
@@ -11,7 +11,7 @@
 	/* let gcc know we ignored these on purpose */
 	(void) template;
 	(void) pfx;
-	pseudo_diag("tempnam() is so ludicrously insecure as to defy implementation.");
+	pseudo_warning("tempnam() is so ludicrously insecure as to defy implementation.");
 	errno = ENOMEM;
 	rc = NULL;
 
diff --git a/ports/unix/guts/tmpnam.c b/ports/unix/guts/tmpnam.c
index 190d260..60b66e0 100644
--- a/ports/unix/guts/tmpnam.c
+++ b/ports/unix/guts/tmpnam.c
@@ -11,7 +11,7 @@
 
 	/* let gcc know we're ignoring this */
 	(void) s;
-	pseudo_diag("tmpnam() is so ludicrously insecure as to defy implementation.");
+	pseudo_warning("tmpnam() is so ludicrously insecure as to defy implementation.");
 	errno = ENOMEM;
 	rc = NULL;
 
diff --git a/ports/unix/guts/unlinkat.c b/ports/unix/guts/unlinkat.c
index 7e4f87c..9889b2e 100644
--- a/ports/unix/guts/unlinkat.c
+++ b/ports/unix/guts/unlinkat.c
@@ -23,7 +23,7 @@
 		 * with that flag unless the real AT functions exist, so 
 		 * something must have gone horribly wrong....
 		 */
-		pseudo_diag("wrap_unlinkat called with flags (0x%x), path '%s'\n",
+		pseudo_info("wrap_unlinkat called with flags (0x%x), path '%s'\n",
 			rflags, path ? path : "<nil>");
 		errno = ENOSYS;
 		return -1;
diff --git a/pseudo_ipc.c b/pseudo_ipc.c
index 838eba2..e51fe0e 100644
--- a/pseudo_ipc.c
+++ b/pseudo_ipc.c
@@ -165,7 +165,7 @@ pseudo_msg_receive(int fd) {
 	if (!incoming || header.pathlen >= incoming_pathlen) {
 		newmsg = pseudo_msg_new(header.pathlen + 128, 0);
 		if (!newmsg) {
-			pseudo_diag("Couldn't allocate header for path of %d bytes.\n",
+			pseudo_error("Couldn't allocate header for path of %d bytes.\n",
 				(int) header.pathlen);
 			return 0;
 		}
diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
index 9ae1200..662c276 100644
--- a/pseudo_wrappers.c
+++ b/pseudo_wrappers.c
@@ -249,7 +249,7 @@ pseudo_magic() {
 
 static void
 pseudo_enosys(const char *func) {
-	pseudo_diag("pseudo: ENOSYS for '%s'.\n", func ? func : "<nil>");
+	pseudo_info("pseudo: ENOSYS for '%s'.\n", func ? func : "<nil>");
 	char * value = pseudo_get_value("PSEUDO_ENOSYS_ABORT");
 	if (value)
 		abort();

