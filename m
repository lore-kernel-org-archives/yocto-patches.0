Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B9ACD4F26
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 09:48:42 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17508.1782208115114115962
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Jun 2026 02:48:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=WGeZn6YE;
 spf=pass (domain: gmail.com, ip: 209.85.216.52, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37cae998401so2415409a91.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782208114; x=1782812914; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9327Uoxk6JQ5v6Izimj0zR2Z8OyxMV1e6Sz7EuNoWpE=;
        b=WGeZn6YEXCELsriwxSFYnNJ1Ov4+c2HYeuC57oX9DJjP7UnBJsA2iRRO7eKUmG1lAi
         mPsMKoK1MuS/bcLEdDxBzAQfvHwFnYw3kEwUh1PsFxRq/OiTtukptoVzYEd8C5NKO1ZB
         UN4AO+I5Sq0hPhc1LD6d1Xr0Pe7RCksKbLCHxtlnyOfIU72D/Gjdra/7rAwg8w0z5QSn
         /XQ9gaToUPmKC6cXex4/8edqtZa2xRH3lyCK2B+ZCM5/2Oeying8T+PqgspQoj4e30ez
         39V7B01/xc3GSIkuG9kKItEysB/IN4SaGxK5WR6ba/MqfexjBquyAZHv30R6tHPGZPAk
         nXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208114; x=1782812914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9327Uoxk6JQ5v6Izimj0zR2Z8OyxMV1e6Sz7EuNoWpE=;
        b=U7/rEqGPoc58t/06IFStnUyW0WbdhJ7SMYjHAxTTo9O3L25LlJsCNe9hyLoKipcqqH
         6gykMKkh91M7MbaEDaRXB1wwQcJitWNMi/9TevxBqjJqrx8Fk1G85t1DRAJhIydX640F
         R59HUtC3tgKv6/Jt2Nr3x5EL4oQKTcFEX3leyzSZDUVSRG23vv+a0AMeUAPmuDl1GqZT
         XUwoWnrs+W2j3gbWs8YOGt5FEnuY8h/0F/Bv30wN9tx3Tm6b1uYS+Y00/sjMbBNLNBdJ
         5b9MCRiVvckQ9ptAfotUsE0v/IRv8LbseCbAsiL9fYkMA4vKtwM8l24b4YoDkBQAu/mA
         hjzQ==
X-Gm-Message-State: AOJu0Yz27GeGv663kx4xPHE0NVUOg92QHMLyn3qMAkBy8+M+Fk90co08
	yAtfsyOoHKXg/CwdOsY32SsGL3uVUNopgkOHxf/j36oz0dZRm3rxRoo/6quGqg==
X-Gm-Gg: AfdE7clcu10OA+7ukBGBpfiR8Rhy6XbD6UTmZDtmTs+WvErXEYuN+M+Dlgdm7U0Ubmp
	O7K4yu6DMRiTX/DjiXZraayf5iZOROD34B8Ut0NdxizpBJwrkG6fUngpsXlRT4RIB52g0ed4svI
	2HgyME6sfU7jYEBPC0kD78IZnxBlfVauH47vqtgMDiHc5YG+N/8OwiJWNxAV0y7PIOVYAWUgxuA
	letgzQjL7zZXPZBQ3l9M4xpewddRxsM3fN9Z+RotMs+zdfVNwC4aq7JtycK8oFPf9zrqMh3B/8S
	Hd371dRLlEsz0TxR4z/ckjbQAR5UHjsdoiJtAiTQ8MvvNnGfxejuRewp5l86d6yKCQWbCRutkkk
	e4yYmvOUTsgd9Vo3hJs3CS3vf9yaf7YyHw6IihwF1Niugh2S+MDTsZZvw2ht8R6R5TsFEzEwaUm
	ks5CblmANvaBFQLKi4
X-Received: by 2002:a17:903:46c7:b0:2c6:b87c:e5a3 with SMTP id d9443c01a7336-2c718ed74e6mr187087975ad.15.1782208114173;
        Tue, 23 Jun 2026 02:48:34 -0700 (PDT)
Received: from LL-868L.kpit.com ([157.45.208.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfd9d2sm117994015ad.56.2026.06.23.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 02:48:33 -0700 (PDT)
From: Jackson James <jackson.james9803@gmail.com>
X-Google-Original-From: Jackson James <jacksonj2@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: careers.myinfo@gmail.com
Subject: [meta-lts-collab][kirkstone][PATCH] jpeg: Reject unsupported number of components
Date: Tue, 23 Jun 2026 15:18:13 +0530
Message-Id: <20260623094813.130228-1-jacksonj2@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 09:48:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4276

From: Shaik Moin <careers.myinfo@gmail.com>

This condition was already checked for incremental loading.
This commit adds the same check in the nonincremental
code path.

Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
---
 .../gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch | 47 +++++++++++++++++++
 .../gdk-pixbuf/gdk-pixbuf_%.bbappend          |  4 ++
 2 files changed, 51 insertions(+)
 create mode 100644 meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch
 create mode 100644 meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend

diff --git a/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch
new file mode 100644
index 0000000..d5bf327
--- /dev/null
+++ b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf/CVE-2026-5201.patch
@@ -0,0 +1,47 @@
+From 4d6eb46037d1b6a298d5db293dba57bbea4d0d08 Mon Sep 17 00:00:00 2001
+From: Shaik Moin <careers.myinfo@gmail.com>
+Date: Thu, 18 Jun 2026 14:51:28 +0530
+Subject: [PATCH] jpeg: Reject unsupported number of components
+
+Backport the fix for CVE-2026-5201
+
+This condition was already checked for incremental loading.
+This commit adds the same check in the nonincremental
+code path.
+
+CVE: CVE-2026-5201
+
+Upstream-Status: Backport [https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/commit/6cce9311e70b969cbcc6e3e1e74ae1756ed02d5b]
+
+Reviewed-by: Matthias Clasen <mclasen@redhat.com>
+Signed-off-by: Shaik Moin <careers.myinfo@gmail.com>
+---
+ gdk-pixbuf/io-jpeg.c | 12 ++++++++++++
+ 1 file changed, 12 insertions(+)
+
+diff --git a/gdk-pixbuf/io-jpeg.c b/gdk-pixbuf/io-jpeg.c
+index 9ee1d21..60ad0d0 100644
+--- a/gdk-pixbuf/io-jpeg.c
++++ b/gdk-pixbuf/io-jpeg.c
+@@ -625,6 +625,18 @@ gdk_pixbuf__real_jpeg_image_load (FILE *f, struct jpeg_decompress_struct *cinfo,
+ 	cinfo->do_fancy_upsampling = FALSE;
+ 	cinfo->do_block_smoothing = FALSE;
+ 
++        /* Reject unsupported component counts */
++        if (cinfo->output_components != 3 && cinfo->output_components != 4 &&
++            !(cinfo->output_components == 1 &&
++              cinfo->out_color_space == JCS_GRAYSCALE)) {
++                g_set_error (error,
++                             GDK_PIXBUF_ERROR,
++                             GDK_PIXBUF_ERROR_CORRUPT_IMAGE,
++                             _("Unsupported number of color components (%d)"),
++                             cinfo->output_components);
++                goto out;
++        }
++
+ 	pixbuf = gdk_pixbuf_new (GDK_COLORSPACE_RGB, 
+ 				 cinfo->out_color_components == 4 ? TRUE : FALSE, 
+ 				 8,
+-- 
+2.34.1
+
diff --git a/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend
new file mode 100644
index 0000000..6a5584e
--- /dev/null
+++ b/meta-oe/recipes-gnome/gdk-pixbuf/gdk-pixbuf_%.bbappend
@@ -0,0 +1,4 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
+
+SRC_URI += "file://CVE-2026-5201.patch \
+"
-- 
2.34.1


