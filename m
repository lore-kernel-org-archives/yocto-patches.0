Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DA910706DC
	for <webhook@archiver.kernel.org>; Sat, 14 Mar 2026 13:14:05 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9338.1773494043934410423
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 14 Mar 2026 06:14:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=CniX+xSQ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20260314131401a00ea096a70002079c-5b3xeh@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260314131401a00ea096a70002079c
        for <yocto-patches@lists.yoctoproject.org>;
        Sat, 14 Mar 2026 14:14:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=dWIke7cfTiLRUlR/5VD33aVdGfXalnUEELLLmHxpm3M=;
 b=CniX+xSQ1jx3QgQp6E35fJhCGEydaskJNyxKuTsPtGb7S/hLeaGI9EWUJ29zLdnp/OPWdH
 bs8cxyAqu6RtM3zdfsV410yZWnipetVqBIDxJOL4U07U34t5k9nJJAzljh5k0BsBsSep3/Lb
 STso9TCmyfuRexo4HlzAAdKk2CF+1xVuWMqDTQJLALFuGZE9IZXCO2B1bDz4h5RUJENQUpTb
 uIGanq6aMWrWFSt4rMTU0wn6uawcPcdDoY+RVvAcltCoC1B2Rlk0MX+0WxTMPcn21Wuu9xNv
 UiPP670GUQzuOzFXfldQDNvubZI8Jvy3b6SWnDVX8ZvS3dJ7K6YJds/g==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [meta-security][PATCH] libtpms: fix build with glibc 2.43
Date: Sat, 14 Mar 2026 14:13:58 +0100
Message-Id: <20260314131358.318029-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 14 Mar 2026 13:14:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3461

From: Peter Marko <peter.marko@siemens.com>

Backport patch stable-0.10 branch (not tagged yet).

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 ...ilation-error-in-TPMLIB_GetPlaintext.patch | 34 +++++++++++++++++++
 meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb |  4 ++-
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch

diff --git a/meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch b/meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch
new file mode 100644
index 0000000..3a82473
--- /dev/null
+++ b/meta-tpm/recipes-tpm/libtpm/libtpms/0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch
@@ -0,0 +1,34 @@
+From a20f8b6a22f1ae60d96ae7e554f5e13dd431471b Mon Sep 17 00:00:00 2001
+From: Stefan Berger <stefanb@linux.ibm.com>
+Date: Fri, 2 Jan 2026 11:37:31 -0500
+Subject: [PATCH] Fix a compilation error in TPMLIB_GetPlaintext
+
+Fix a compilation error that newer gcc versions may complain about:
+
+tpm_library.c: In function 'TPMLIB_GetPlaintext':
+tpm_library.c:441:11: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
+  441 |     start = strstr(stream, starttag);
+      |           ^
+At top level:
+cc1: note: unrecognized command-line option '-Wno-self-assign' may have been intended to silence earlier diagnostics
+cc1: all warnings being treated as errors
+
+Upstream-Status: Backport [https://github.com/stefanberger/libtpms/commit/a20f8b6a22f1ae60d96ae7e554f5e13dd431471b]
+Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
+---
+ src/tpm_library.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/tpm_library.c b/src/tpm_library.c
+index f48f4fd3..7b2ea687 100644
+--- a/src/tpm_library.c
++++ b/src/tpm_library.c
+@@ -435,7 +435,7 @@ static unsigned char *TPMLIB_GetPlaintext(const char *stream,
+                                           const char *endtag,
+                                           size_t *length)
+ {
+-    char *start, *end;
++    const char *start, *end;
+     unsigned char *plaintext = NULL;
+ 
+     start = strstr(stream, starttag);
diff --git a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
index 3727bb3..7f00216 100644
--- a/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
+++ b/meta-tpm/recipes-tpm/libtpm/libtpms_0.10.0.bb
@@ -3,7 +3,9 @@ LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=e73f0786a936da3814896df06ad225a9"
 
 SRCREV = "17f253a767f6b5b7813ae33f12bc79c479576cdc"
-SRC_URI = "git://github.com/stefanberger/libtpms.git;branch=stable-0.10;protocol=https"
+SRC_URI = "git://github.com/stefanberger/libtpms.git;branch=stable-0.10;protocol=https \
+    file://0001-Fix-a-compilation-error-in-TPMLIB_GetPlaintext.patch \
+"
 
 PE = "2"
 

