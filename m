Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB10AF428E0
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 20:19:51 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4573.1776284386444988967
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 13:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ngNHyFDG;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c9f6b78ca4so848805885a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776284385; x=1776889185; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOajnEUAWdGhadAr0KsjO9e0qb1yiolOX9SX5/g4cNo=;
        b=ngNHyFDG3BBxzxeEU9OjYpnCjwZ2BiOZ70bWI9Sy7VrwNDUckKqxe/lSZNsmaCjvIn
         6sj8OhAIAp+UPPWpO9c5eOjlXHNwEuws/pGPBr1qs7WyFjgeKz3WzE3WxjyaWY9D7Gqa
         THnrnmKF3ZPvVc0PwwLxq5/ivRj8wBtGVkplY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284385; x=1776889185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BOajnEUAWdGhadAr0KsjO9e0qb1yiolOX9SX5/g4cNo=;
        b=L7KIywwUw7qfgxKUKSFAJriu/aDp6lFkB3fJnRqxBT3Ev651rePqY5hVCBiWM8hr/0
         LYxU0/1tOppenKUmFWmHoDiNNNRcFRxg+4CyS0tVGUDIWZ3V+rad1FwU5SP2ER3kfyEI
         oAHIWhPBR9m4zreY1vMphnUXfvOEE5qm9XdbEeqTrqp3h1S1DD1mJTU1nDwNMiJ7fwGG
         GL3jOtBxmv3+CFg/ExCss/ZlZuxHM1sOLGipaXWugq1aQeLi9Dobm6e6iEtyX46liVXH
         DD6Xgv/UPnVxuGh4O1U2M1WIWDGulmaFVX5KNoN5fh4PVd0mAwlvh6Q2bnEGiA6Fo0MS
         g0Dw==
X-Gm-Message-State: AOJu0YwzprtUwl8tFwEbNCNVo5phgb7AjiRKBaPoU3fBqYCIeWjw1UkV
	8vPBSDe40supK0UAuIZSD+eWRBCPuGhtJzSQOeNm1T2rLUlLTmRtGWK0gaMJLugTnFcySnN1gcH
	8oLtH
X-Gm-Gg: AeBDievyKRdV0z1pU+6KA3lDHugQKYMAJ98141A0hD4CSdC/Qk4PdYeGNECQa6m6xLT
	d9nVoaNWMrFJCWzncKpa/vBAPycnfybzk1Y3XM5r4uV2nfhA8gyhunUfTmkfXcClE0pBIBgGiw0
	JUirIY4qi/wtqhSptFQ15Dq9/FjvtxQ4BjJdcV7NW0fstb8Eb9pbxf9wENtd6qFvrgGGdy5ddBS
	7iUjxCHOLWffGKiZa3+oY5HmKSEvVqbAo2lRJ2J18WiQgWXLsExtIU201cUVsbhph+Wo45WgtlR
	Cv+9r1MVXalaoTjIHUTJJd+ZiRQ5Edo7kQP6bwJ1Dypw+DOH7vNiYhlnbVNNJ9gW7yKee+5aB5U
	VXGFsgMBWP6/QAghHdLsSpVEp+CYCFnso4Nwrq6EZWgWZR9TNVctZP68A1NY2qdsLkplQb9d/+2
	HB9o3FahJuBtwcYDFnmiFfMzFu/Zr+Odn3iEg6XSHsl2IsBQmIcrRxGnvmjRSK6yFC3rBYfGZ87
	dC+rncfqNy8Do7cgVpdtifOYnzD/C6AlGAHYFFQRgdNtIYpP4H2c3rGYTko3VRy
X-Received: by 2002:a05:620a:4713:b0:8cd:8fc7:831f with SMTP id af79cd13be357-8ddcfca61aemr3525779785a.56.1776284385026;
        Wed, 15 Apr 2026 13:19:45 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm18569376d6.46.2026.04.15.13.19.44
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:19:44 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 1/7] libtpms: fix build with glibc 2.43
Date: Wed, 15 Apr 2026 16:19:21 -0400
Message-ID: <62a62bc7c0231c86d9e759a6f976d9b5e410a62c.1776283733.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776283733.git.scott.murray@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 20:19:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3709

From: Peter Marko <peter.marko@siemens.com>

Backport patch stable-0.10 branch (not tagged yet).

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
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
 
-- 
2.53.0


