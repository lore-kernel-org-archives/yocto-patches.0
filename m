Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A967BD4663B
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:46:58 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.709.1768517217300253447
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AZdTiG3R;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8908f5ed4aeso14639156d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517216; x=1769122016; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RwqMO45OtcwJYISgvKXNfcWfnmovdEdxs1d+TiveXQ=;
        b=AZdTiG3RrefQb06mVd8K7y9jOw3tQulrKh/IlLNN9iC34w0bUDTL+s0z5gZAE0kidO
         oXV75dvI1FlN89XrOuYLl/Do3hFNRjlfiR45921XDKIZdoKVaW3RDa4gPuUSqqbnyPDa
         md2oiaGpSKzkuGKbAjtpGd01C3hMdOGb4lOls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517216; x=1769122016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1RwqMO45OtcwJYISgvKXNfcWfnmovdEdxs1d+TiveXQ=;
        b=rbpo4nKVCsYEuGXn24PBjO76a1LvMR8ZYEihDuhkjy8glP2OZuib2qDD+UTmqUTRQt
         x2e9J7QsZsqkx6qLzR8hi1iujgtpRrCobatA2vdkGy8D+KO3POD3+suSoMhHD+TqKree
         ykA1Vaka9KpuP8kcPVBdhztdsb3B6kuoLQkiSNS3Z/2onH7rzLVvPEwq8jJoe/0zpXZI
         dm6CNTm8ig6T48JRNS8UD7CqpC1gkzKqzh4WGt5DFcTnu9FR5VGbMDBj/qG2RN4rp+6W
         q1D+RHljt0rCxrwYco39kPTkaRTmyaiKgXxZ2HIXeKvGWGAq3IcqEScHq7SsAafCPhjF
         aksw==
X-Gm-Message-State: AOJu0YwSQlyi0Oeu0XYkwG1ipCa0d6pHdykmoZwN42C9De7vt7pVm6d2
	Jes+8OM6aSNHax5C7jOfUPLQ61jx1PobgrY5Yi9rXoh+oknYY6BLFIBw4dBcJnQR9NA0tdjrwPJ
	6WK1U
X-Gm-Gg: AY/fxX5ZMciE7ivcc1HHOSUEpeTtTTrKGhAYqvnYjWOhhD6qL8iwMrAWszr/PhaYiU6
	zadaJmUFIzVzCt0RoT/aVr6qdGHP5rRYAj6r1XAKTcEKuFYfIdq6l/4KTitU8rjKO5SiXBkIgA9
	HLgDlu0L0gvW5/zllvfLtKlK/WDG/fSUfSk6cgsos5WQtNML7T31f3L3bU6ZS3ugA/Ica5DrOVB
	yTxVLBjvfBYak2+qWoI80ssNRdlr6j5/Bh9eXaWfN9MHT2QWMAwwwSuxDB0A1HXunDhvcKed3ZF
	L9h0xBnvi47KqtyHc4EQ/VmV/dQHeTljL6COTXuhtium6hXKWX099mGxygNqffyh5oPH41UBNBI
	R6e/qX+xc2D8valoMHSCXu9CzRXjFUrlPkjzc5KiV5KW4H/3nKZCzssUKoqOEsZ7eSS1pYCiwVW
	k4bGEwv6xHHzOxIgCSh0dZ1z97guTUDdgMXxbiJgz/+ZvE/HNq+9L1X+WxWFCgpXU1BUWQaWQsA
	oSv9zKaxwa9+BF/e8dro2aRpo8iqfLYQTd2Oyupe+kaoNL+I8a3xENhoG87HZk=
X-Received: by 2002:a05:6214:495:b0:880:5883:4d23 with SMTP id 6a1803df08f44-8942e2c8ca5mr15394966d6.16.1768517216117;
        Thu, 15 Jan 2026 14:46:56 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:55 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 6/9] checksecurity: update the debian package
Date: Thu, 15 Jan 2026 17:46:27 -0500
Message-ID: <c5115b85fb6e134d29a7ece58a8c9d8c69475b50.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2971

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

The previously used package (nmu1) is not longer available, use the latest current
one (nmu3). The changelog between the two:

checksecurity (2.0.16+nmu3) unstable; urgency=medium

  * Non-maintainer upload.
  * Fix "missing required debian/rules targets build-arch and/or build-
    indep": Add targets to debian/rules.
    (Closes: #999082)
  * Fix "Removal of obsolete debhelper compat 5 and 6 in bookworm":
    Bump to 7 in debian/{compat,control}.
    (Closes: #965448)
  * Fix some grave packaging errors:
    - move debhelper from Build-Depends-Indep to Build-Depends
    - remove temporary files debian/postrm.debhelper and debian/substvars from
      source package

 -- gregor herrmann <gregoa@debian.org>  Sun, 26 Dec 2021 01:56:10 +0100

checksecurity (2.0.16+nmu2) unstable; urgency=medium

  * Non maintainer upload by the Reproducible Builds team.
  * No source change upload to rebuild on buildd with .buildinfo files.

 -- Holger Levsen <holger@debian.org>  Fri, 01 Jan 2021 19:17:53 +0100

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
(adapted from 828a78314f51b919baf638d64e8e12c0c0a408ad)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-scanners/checksecurity/checksecurity_2.0.16.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-scanners/checksecurity/checksecurity_2.0.16.bb b/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
index 8006c9f..6a223f8 100644
--- a/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
+++ b/recipes-scanners/checksecurity/checksecurity_2.0.16.bb
@@ -4,14 +4,13 @@ SECTION = "security"
 LICENSE = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"
 
-SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu1.tar.gz \
+SRC_URI = "http://ftp.de.debian.org/debian/pool/main/c/checksecurity/checksecurity_${PV}+nmu3.tar.gz \
            file://check-setuid-use-more-portable-find-args.patch \
           "
 
-SRC_URI[sha256sum] = "9803b3760e9ec48e06ebaf48cec081db48c6fe72254a476224e4c5c55ed97fb0"
-
-S = "${WORKDIR}/checksecurity-${PV}+nmu1"
+SRC_URI[sha256sum] = "12b043dc7b38512cdf0735c7c147a4f9e60d83a397b5b8ec130c65ceddbe1a0c"
 
+S = "${WORKDIR}/checksecurity-${PV}+nmu3"
 
 # allow for anylocal, no need to patch
 LOGDIR="/etc/checksecurity"
-- 
2.51.0


