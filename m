Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C78CE7AE8
	for <webhook@archiver.kernel.org>; Fri,  6 Sep 2024 08:20:03 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.30375.1725610794366295742
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Sep 2024 01:19:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=hE9VSOj8;
 spf=pass (domain: mvista.com, ip: 209.85.215.179, mailfrom: hprajapati@mvista.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so448808a12.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1725610793; x=1726215593; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPrEcOu2QYl/sJy22pkLVlEUcdUEWQNNVJFjZwX/tJc=;
        b=hE9VSOj8Jy48yEWVj2K9tJPvYGUUTxojrsSIp22YzDxHwcrYYzIv7chzFAXOAJJ1Hj
         9WO4AQycq1eFtiKyWAgkjtVGrd046x9XNHC6Nv3aPK/Qnz6kuJeNFHr1LAp6P8qvp7sL
         dD4xbQRZDG/ruHY22S7tG8GUfbpXVS6P19xCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725610793; x=1726215593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPrEcOu2QYl/sJy22pkLVlEUcdUEWQNNVJFjZwX/tJc=;
        b=dng8w8chuDegAimQ7qrLeWesWEAVb/V6Swdqz6GBOvy5I/NBEQasddaDc3E3pN4ojB
         JDWN6TgNMw2y+i/JdV0ca5Qkvh6Vza9MnfahBgXKiAzvQrB4HyQaSmCKhEdbBKtWYzFh
         XZYWBVgdD7yON8FO2RIT/HKzdMKe9iGoLPZPMUdw6dC60y3peGCS+tfyY6OsLLmiu0sr
         2vOtoE1O6X31PbygfvGc4Ht1zwiEWTViuOm1Ma5fY58AZFZjMgfF8TAjaaz2pW7wTHpy
         QOEOO0M0vszM7tAhUp3whgaPlzVR2HG6g2Sj2lQC7xRUjFGEgMstiRlB6P9U9JYPRVAa
         +SIQ==
X-Gm-Message-State: AOJu0YwY0Sg6XxB+IZ5e5Hju69SjhHyTAU0wu2g1MnU3TW9B/jTX6FhP
	Z5rmuikJW/Sxm65ypIkdOgNecQ5LrpkJ3Ab/MtXQ44bykn7cQB2nt01MSWJqZTPFL8eRlbB16hK
	w
X-Google-Smtp-Source: AGHT+IHIG3rrkpM64gRTr5Hi+9n16fHKF6iL9WtIK2EA/ST2hHsInXrWOoduVC2o76RUvg1svIFHFA==
X-Received: by 2002:a05:6a21:3213:b0:1cf:1a90:fa6f with SMTP id adf61e73a8af0-1cf1c10bd3fmr3034317637.20.1725610793185;
        Fri, 06 Sep 2024 01:19:53 -0700 (PDT)
Received: from MVIN00016.mvista.com ([43.249.234.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718d64a5cdfsm848356b3a.91.2024.09.06.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 01:19:52 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCHv2] clamav: fix CVE-2024-20505 & CVE-2024-20506
Date: Fri,  6 Sep 2024 13:49:40 +0530
Message-Id: <20240906081940.72172-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Sep 2024 08:20:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/613

Backport fixes for:

* CVE-2024-20505 - Upstream-Status: Backport from https://github.com/Cisco-Talos/clamav/commit/8915bd22570ee608907f1b88a68e587d17813812
* CVE-2024-20506 - Upstream-Status: Backport from https://github.com/Cisco-Talos/clamav/commit/88efeda2a4cb93a69cf0994c02a8987f06fa204d

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 recipes-scanners/clamav/clamav_0.104.4.bb     |   2 +
 .../clamav/files/CVE-2024-20505.patch         | 118 +++++++++++++++++
 .../clamav/files/CVE-2024-20506.patch         | 124 ++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 recipes-scanners/clamav/files/CVE-2024-20505.patch
 create mode 100644 recipes-scanners/clamav/files/CVE-2024-20506.patch

diff --git a/recipes-scanners/clamav/clamav_0.104.4.bb b/recipes-scanners/clamav/clamav_0.104.4.bb
index 102f267..d7beade 100644
--- a/recipes-scanners/clamav/clamav_0.104.4.bb
+++ b/recipes-scanners/clamav/clamav_0.104.4.bb
@@ -20,6 +20,8 @@ SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/0.104;protocol=https \
     file://tmpfiles.clamav \
     file://headers_fixup.patch \
     file://oe_cmake_fixup.patch \
+    file://CVE-2024-20505.patch \
+    file://CVE-2024-20506.patch \
 "
 S = "${WORKDIR}/git"
 
diff --git a/recipes-scanners/clamav/files/CVE-2024-20505.patch b/recipes-scanners/clamav/files/CVE-2024-20505.patch
new file mode 100644
index 0000000..9c73051
--- /dev/null
+++ b/recipes-scanners/clamav/files/CVE-2024-20505.patch
@@ -0,0 +1,118 @@
+From 8915bd22570ee608907f1b88a68e587d17813812 Mon Sep 17 00:00:00 2001
+From: Micah Snyder <micasnyd@cisco.com>
+Date: Tue, 16 Jul 2024 11:22:05 -0400
+Subject: [PATCH] Fix possible out of bounds read in PDF parser
+
+The `find_length()` function in the PDF parser incorrectly assumes that
+objects found are located in the main PDF file map, and fails to take
+into account whether the objects were in fact found in extracted PDF
+object streams. The resulting pointer is then invalid and may be an out
+of bounds read.
+
+This issue was found by OSS-Fuzz.
+
+This fix checks if the object is from an object stream, and then
+calculates the pointer based on the start of the object stream instead
+of based on the start of the PDF.
+
+I've also added extra checks to verify the calculated pointer and object
+size are within the stream (or PDF file map). I'm not entirely sure this
+is necessary, but better safe than sorry.
+
+Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=69617
+
+Upstream-Status: Backport [https://github.com/Cisco-Talos/clamav/commit/8915bd22570ee608907f1b88a68e587d17813812]
+CVE: CVE-2024-20505
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ libclamav/pdf.c   | 45 +++++++++++++++++++++++++++++++++++++++------
+ libclamav/pdfng.c |  5 +++++
+ 2 files changed, 44 insertions(+), 6 deletions(-)
+
+diff --git a/libclamav/pdf.c b/libclamav/pdf.c
+index 01f32e07a..40eea19eb 100644
+--- a/libclamav/pdf.c
++++ b/libclamav/pdf.c
+@@ -1009,8 +1009,26 @@ static size_t find_length(struct pdf_struct *pdf, struct pdf_obj *obj, const cha
+                 return 0;
+             }
+ 
+-            indirect_obj_start = pdf->map + obj->start;
+-            bytes_remaining    = pdf->size - obj->start;
++            if (NULL == obj->objstm) {
++                indirect_obj_start = (const char *)(obj->start + pdf->map);
++
++                if (!CLI_ISCONTAINED(pdf->map, pdf->size, indirect_obj_start, obj->size)) {
++                    cli_dbgmsg("find_length: indirect object found, but not contained in PDF\n");
++                    return 0;
++                }
++
++                bytes_remaining = pdf->size - obj->start;
++
++            } else {
++                indirect_obj_start = (const char *)(obj->start + obj->objstm->streambuf);
++
++                if (!CLI_ISCONTAINED(obj->objstm->streambuf, obj->objstm->streambuf_len, indirect_obj_start, obj->size)) {
++                    cli_dbgmsg("find_length: indirect object found, but not contained in PDF streambuf\n");
++                    return 0;
++                }
++
++                bytes_remaining = obj->objstm->streambuf_len - obj->start;
++            }
+ 
+             /* Ok so we found the indirect object, lets read the value. */
+             index = pdf_nextobject(indirect_obj_start, bytes_remaining);
+@@ -3093,15 +3111,30 @@ void pdf_handle_enc(struct pdf_struct *pdf)
+ 
+     obj = find_obj(pdf, pdf->objs[0], pdf->enc_objid);
+     if (!obj) {
+-        cli_dbgmsg("pdf_handle_enc: can't find encrypted object %d %d\n", pdf->enc_objid >> 8, pdf->enc_objid & 0xff);
+-        noisy_warnmsg("pdf_handle_enc: can't find encrypted object %d %d\n", pdf->enc_objid >> 8, pdf->enc_objid & 0xff);
++        cli_dbgmsg("pdf_handle_enc: can't find encryption object %d %d\n", pdf->enc_objid >> 8, pdf->enc_objid & 0xff);
++        noisy_warnmsg("pdf_handle_enc: can't find encryption object %d %d\n", pdf->enc_objid >> 8, pdf->enc_objid & 0xff);
+         return;
+     }
+ 
+     len = obj->size;
+ 
+-    q = (obj->objstm) ? (const char *)(obj->start + obj->objstm->streambuf)
+-                      : (const char *)(obj->start + pdf->map);
++    if (NULL == obj->objstm) {
++        q = (const char *)(obj->start + pdf->map);
++
++        if (!CLI_ISCONTAINED(pdf->map, pdf->size, q, len)) {
++            cli_dbgmsg("pdf_handle_enc: encryption object found, but not contained in PDF\n");
++            noisy_warnmsg("pdf_handle_enc: encryption object found, but not contained in PDF\n");
++            return;
++        }
++    } else {
++        q = (const char *)(obj->start + obj->objstm->streambuf);
++
++        if (!CLI_ISCONTAINED(obj->objstm->streambuf, obj->objstm->streambuf_len, q, len)) {
++            cli_dbgmsg("pdf_handle_enc: encryption object found, but not contained in PDF streambuf\n");
++            noisy_warnmsg("pdf_handle_enc: encryption object found, but not contained in PDF streambuf\n");
++            return;
++        }
++    }
+ 
+     O = U = UE = StmF = StrF = EFF = NULL;
+     do {
+diff --git a/libclamav/pdfng.c b/libclamav/pdfng.c
+index a5daa2891..977a95e4d 100644
+--- a/libclamav/pdfng.c
++++ b/libclamav/pdfng.c
+@@ -450,6 +450,11 @@ char *pdf_parse_string(struct pdf_struct *pdf, struct pdf_obj *obj, const char *
+         if (!(newobj))
+             return NULL;
+ 
++        if (!CLI_ISCONTAINED(pdf->map, pdf->size, newobj->start, newobj->size)) {
++            cli_dbgmsg("pdf_parse_string: object not contained in PDF\n");
++            return NULL;
++        }
++
+         if (newobj == obj)
+             return NULL;
+ 
+-- 
+2.25.1
+
diff --git a/recipes-scanners/clamav/files/CVE-2024-20506.patch b/recipes-scanners/clamav/files/CVE-2024-20506.patch
new file mode 100644
index 0000000..4462780
--- /dev/null
+++ b/recipes-scanners/clamav/files/CVE-2024-20506.patch
@@ -0,0 +1,124 @@
+From 88efeda2a4cb93a69cf0994c02a8987f06fa204d Mon Sep 17 00:00:00 2001
+From: Micah Snyder <micasnyd@cisco.com>
+Date: Mon, 26 Aug 2024 14:00:51 -0400
+Subject: [PATCH] Disable following symlinks when opening log files
+
+The log module used by clamd and freshclam may follow symlinks.
+This is a potential security concern since the log may be owned by
+the unprivileged service but may be opened by the service running as
+root on startup.
+
+For Windows, we'll define O_NOFOLLOW so the code works, though the issue
+does not affect Windows.
+
+Issue reported by Detlef.
+
+Upstream-Status: Backport [https://github.com/Cisco-Talos/clamav/commit/88efeda2a4cb93a69cf0994c02a8987f06fa204d]
+CVE: CVE-2024-20506
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ common/output.c | 51 ++++++++++++++++++++++++++++++++++++++-----------
+ 1 file changed, 40 insertions(+), 11 deletions(-)
+
+diff --git a/common/output.c b/common/output.c
+index 968cea09f..f3ea7f980 100644
+--- a/common/output.c
++++ b/common/output.c
+@@ -58,6 +58,12 @@
+ 
+ #include "output.h"
+ 
++// Define O_NOFOLLOW for systems that don't have it.
++// Notably, Windows doesn't have O_NOFOLLOW.
++#ifndef O_NOFOLLOW
++#define O_NOFOLLOW 0
++#endif
++
+ #ifdef CL_THREAD_SAFE
+ #include <pthread.h>
+ pthread_mutex_t logg_mutex     = PTHREAD_MUTEX_INITIALIZER;
+@@ -323,7 +329,6 @@ int logg(const char *str, ...)
+     char buffer[1025], *abuffer = NULL, *buff;
+     time_t currtime;
+     size_t len;
+-    mode_t old_umask;
+ #ifdef F_WRLCK
+     struct flock fl;
+ #endif
+@@ -357,18 +362,36 @@ int logg(const char *str, ...)
+     logg_open();
+ 
+     if (!logg_fp && logg_file) {
+-        old_umask = umask(0037);
+-        if ((logg_fp = fopen(logg_file, "at")) == NULL) {
+-            umask(old_umask);
++        int logg_file_fd = -1;
++
++        logg_file_fd = open(logg_file, O_WRONLY | O_CREAT | O_APPEND | O_NOFOLLOW, 0640);
++        if (-1 == logg_file_fd) {
++            char errbuf[128];
++            cli_strerror(errno, errbuf, sizeof(errbuf));
++            printf("ERROR: Failed to open log file %s: %s\n", logg_file, errbuf);
++
+ #ifdef CL_THREAD_SAFE
+             pthread_mutex_unlock(&logg_mutex);
+ #endif
+-            printf("ERROR: Can't open %s in append mode (check permissions!).\n", logg_file);
+-            if (len > sizeof(buffer))
++            if (abuffer)
+                 free(abuffer);
+             return -1;
+-        } else
+-            umask(old_umask);
++        }
++
++        logg_fp = fdopen(logg_file_fd, "at");
++        if (NULL == logg_fp) {
++            char errbuf[128];
++            cli_strerror(errno, errbuf, sizeof(errbuf));
++            printf("ERROR: Failed to convert the open log file descriptor for %s to a FILE* handle: %s\n", logg_file, errbuf);
++
++            close(logg_file_fd);
++#ifdef CL_THREAD_SAFE
++            pthread_mutex_unlock(&logg_mutex);
++#endif
++            if (abuffer)
++                free(abuffer);
++            return -1;
++        }
+ 
+ #ifdef F_WRLCK
+         if (logg_lock) {
+@@ -381,11 +404,16 @@ int logg(const char *str, ...)
+                 else
+ #endif
+                 {
++                    char errbuf[128];
++                    cli_strerror(errno, errbuf, sizeof(errbuf));
++                    printf("ERROR: Failed to lock the log file %s: %s\n", logg_file, errbuf);
++
+ #ifdef CL_THREAD_SAFE
+                     pthread_mutex_unlock(&logg_mutex);
+ #endif
+-                    printf("ERROR: %s is locked by another process\n", logg_file);
+-                    if (len > sizeof(buffer))
++                    fclose(logg_fp);
++                    logg_fp = NULL;
++                    if (abuffer)
+                         free(abuffer);
+                     return -1;
+                 }
+@@ -462,8 +490,9 @@ int logg(const char *str, ...)
+     pthread_mutex_unlock(&logg_mutex);
+ #endif
+ 
+-    if (len > sizeof(buffer))
++    if (abuffer)
+         free(abuffer);
++
+     return 0;
+ }
+ 
+-- 
+2.25.1
+
-- 
2.25.1


