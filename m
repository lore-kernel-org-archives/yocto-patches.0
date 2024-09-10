Return-Path: <rsangam@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB2AECE564
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 09:11:44 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.18700.1725959498459728496
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Sep 2024 02:11:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=NvC7m6Ll;
 spf=pass (domain: mvista.com, ip: 209.85.214.174, mailfrom: rsangam@mvista.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc47abc040so46094785ad.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Sep 2024 02:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1725959497; x=1726564297; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+WVzyRvh7TmLEKpDTPo1pNCNS3fxeenIeUt5cpuzPA=;
        b=NvC7m6Llh2c5ADu3Ilt4yUR+y8UNcmD8g60c8CfPBLs8Nfgat+lJbzRnr2JjjIo6fZ
         CTmtSgM8ShLMqdj1cI0pW+q4z5ZW0zmOdvsmTiHhpUMBrvS2npqw9InS+h8MYOTOZXaO
         w7QQThKXfjvX4a+ndPsixGYvD3vmdAqL3W43I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725959497; x=1726564297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+WVzyRvh7TmLEKpDTPo1pNCNS3fxeenIeUt5cpuzPA=;
        b=AXr+eP47es8jE0sG/F3i9YBW0m0EoXDGlo2zQRDJj6WnmNXnBRV72nsabB3zf5aE7k
         V+fV4eHTOz1N4CYyBbE3ipmK+vZsVTsFIqErKF1FH7sdGKmztPkIpW+yVUgK+BrmCIhO
         UfUbj4Fq4y/udkSunUoIuCu/W9zvAbMr6sRH0q3tN4ZKYCvUdnE0Gv6uV224Z532wrWs
         q9ScSJq1YaE4HnjHmldIBI7lbox3qUGWdLoxoXxFbgiBPLZYWrjBt7cZWIBUNblw+FiS
         kZGnzeIHnmqH2dxvq5I0OUKmzvFSzb2/sYfGJSbFVLqmAy/g1rEYy30+ahXUfOh/2MCq
         f4Qg==
X-Gm-Message-State: AOJu0YyTllYrgH6TKmTprgAR3VaUn2HgzHAbjz4alMcYRC8tkmzrylHE
	mXsGuqUvsPNcvjA70eIXxpBKoYm21K5uZySIhZ+KaQAS4OIrcjdOC9pCCeXfH/VMT+pvHowHDfI
	o
X-Google-Smtp-Source: AGHT+IEQIWleFMqPAdqc8IAp/vMrMaLpwGGse73Nka2bYQzsUcwQO0Bejzz22vBfL372MdXc+yFycw==
X-Received: by 2002:a17:902:cec2:b0:205:5f54:75a2 with SMTP id d9443c01a7336-2074c738420mr512465ad.51.1725959496866;
        Tue, 10 Sep 2024 02:11:36 -0700 (PDT)
Received: from MVIN00040.mvista.com ([49.207.208.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f31235sm45153275ad.253.2024.09.10.02.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 02:11:36 -0700 (PDT)
From: Rohini Sangam <rsangam@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Rohini Sangam <rsangam@mvista.com>,
	Siddharth Doshi <sdoshi@mvista.com>
Subject: [meta-security][kirkstone][PATCH] clamav: Security fix for CVE-2024-20505 and CVE-2024-20506
Date: Tue, 10 Sep 2024 14:41:29 +0530
Message-Id: <20240910091129.187699-1-rsangam@mvista.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Sep 2024 09:11:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/641

CVES fixed:
- CVE-2024-20505 clamav: out-of-bounds read bug in the PDF file parser
- CVE-2024-20506 clamav: ClamD process writes to log file while privileged without checking if its been replaced with a symlink
Upstream-Status: Backport from https://github.com/Cisco-Talos/clamav/commit/8915bd22570ee608907f1b88a68e587d17813812, https://github.com/Cisco-Talos/clamav/commit/88efeda2a4cb93a69cf0994c02a8987f06fa204d

Signed-off-by: Rohini Sangam <rsangam@mvista.com>
Signed-off-by: Siddharth Doshi <sdoshi@mvista.com>
---
 recipes-scanners/clamav/clamav_0.104.0.bb     |   2 +
 .../clamav/files/CVE-2024-20505.patch         | 101 ++++++++++++++++
 .../clamav/files/CVE-2024-20506.patch         | 113 ++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 recipes-scanners/clamav/files/CVE-2024-20505.patch
 create mode 100644 recipes-scanners/clamav/files/CVE-2024-20506.patch

diff --git a/recipes-scanners/clamav/clamav_0.104.0.bb b/recipes-scanners/clamav/clamav_0.104.0.bb
index 18e8329..0a6b92a 100644
--- a/recipes-scanners/clamav/clamav_0.104.0.bb
+++ b/recipes-scanners/clamav/clamav_0.104.0.bb
@@ -21,6 +21,8 @@ SRC_URI = "git://github.com/vrtadmin/clamav-devel;branch=rel/0.104;protocol=http
     file://headers_fixup.patch \
     file://oe_cmake_fixup.patch \
     file://fix_systemd_socket.patch \
+    file://CVE-2024-20505.patch \
+    file://CVE-2024-20506.patch \
 "
 S = "${WORKDIR}/git"
 
diff --git a/recipes-scanners/clamav/files/CVE-2024-20505.patch b/recipes-scanners/clamav/files/CVE-2024-20505.patch
new file mode 100644
index 0000000..72db71f
--- /dev/null
+++ b/recipes-scanners/clamav/files/CVE-2024-20505.patch
@@ -0,0 +1,101 @@
+From 8915bd22570ee608907f1b88a68e587d17813812 Mon Sep 17 00:00:00 2001
+From: Micah Snyder <micasnyd@cisco.com>
+Date: Tue, 16 Jul 2024 11:22:05 -0400
+Subject: [PATCH] CVE-2024-20505: Fix possible out of bounds read in PDF parser
+
+Upstream-Status: Backport from https://github.com/Cisco-Talos/clamav/commit/8915bd22570ee608907f1b88a68e587d17813812
+CVE: CVE-2024-20505
+
+Signed-off-by: Rohini Sangam <rsangam@mvista.com>
+---
+ libclamav/pdf.c   | 46 ++++++++++++++++++++++++++++++++++++++++------
+ libclamav/pdfng.c |  5 +++++
+ 2 files changed, 45 insertions(+), 6 deletions(-)
+
+diff --git a/libclamav/pdf.c b/libclamav/pdf.c
+index a52833520..6b408dbe8 100644
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
+@@ -3095,14 +3113,30 @@ void pdf_handle_enc(struct pdf_struct *pdf)
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
+-    q   = (obj->objstm) ? (const char *)(obj->start + obj->objstm->streambuf)
+-                      : (const char *)(obj->start + pdf->map);
++
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
+index 98c67a2cd..164de37d6 100644
+--- a/libclamav/pdfng.c
++++ b/libclamav/pdfng.c
+@@ -450,6 +450,11 @@ char *pdf_parse_string(struct pdf_struct *pdf, struct pdf_obj *obj, const char *
+         if (!(newobj))
+             return NULL;
+ 
++	if (!CLI_ISCONTAINED(pdf->map, pdf->size, newobj->start, newobj->size)) {
++            cli_dbgmsg("pdf_parse_string: object not contained in PDF\n");
++            return NULL;
++        }
++
+         if (newobj == obj)
+             return NULL;
+ 
+-- 
+2.35.7
+
diff --git a/recipes-scanners/clamav/files/CVE-2024-20506.patch b/recipes-scanners/clamav/files/CVE-2024-20506.patch
new file mode 100644
index 0000000..27465c9
--- /dev/null
+++ b/recipes-scanners/clamav/files/CVE-2024-20506.patch
@@ -0,0 +1,113 @@
+From 88efeda2a4cb93a69cf0994c02a8987f06fa204d Mon Sep 17 00:00:00 2001
+From: Micah Snyder <micasnyd@cisco.com>
+Date: Mon, 26 Aug 2024 14:00:51 -0400
+Subject: [PATCH] CVE-2024-20506: Disable following symlinks when opening log files 
+
+Upstream-Status: Backport from https://github.com/Cisco-Talos/clamav/commit/88efeda2a4cb93a69cf0994c02a8987f06fa204d
+CVE: CVE-2024-20506
+
+Signed-off-by: Rohini Sangam <rsangam@mvista.com>
+---
+ common/output.c | 50 ++++++++++++++++++++++++++++++++++++++-----------
+ 1 file changed, 39 insertions(+), 11 deletions(-)
+
+diff --git a/common/output.c b/common/output.c
+index 8d66f62a1..99aa711b9 100644
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
++	int logg_file_fd = -1;
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
++		    char errbuf[128];
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
+@@ -462,7 +490,7 @@ int logg(const char *str, ...)
+     pthread_mutex_unlock(&logg_mutex);
+ #endif
+ 
+-    if (len > sizeof(buffer))
++    if (abuffer)
+         free(abuffer);
+     return 0;
+ }
+-- 
+2.35.7
+
-- 
2.34.1


