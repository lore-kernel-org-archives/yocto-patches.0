Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F38CF9EDFE
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 14:53:47 +0000 (UTC)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21838.1776956022954754780
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 07:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=DiHs22tj;
 spf=pass (domain: 0leil.net, ip: 45.157.188.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g1fH92NWjzFMn;
	Thu, 23 Apr 2026 16:53:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1776956021;
	bh=kjp+pb1KBHdr61wnV5eTZisK9ObNAJ97DobXo4xMIQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DiHs22tjXDv33vAktzoFUbSoCVZRTt3ScjWCkaVjFpXCXALNZTkCgNNVo48gAO0Ik
	 VKpVnZtq0VKPQvHZHdZIpDlRBtPnymWMXQXGqksGZHGNKWAc1h3/zAncGpn3if7hyI
	 pzM/xyrZL9Y0LZnn/Pkd0hhswHPuECGkkIjlHsS7wIrqYn4R2AHHzBoVSa5fUNQCQY
	 r6iyV3VIFZeXk44bZP6EOQhkg8w4U0DZV08eqS7XVQabgMDkX6XmXBqWjcBoZUzMU2
	 A3k30UbpifVN4nRePlZDUfJiYpIbKofjEFBDfSjgtvd0zOIeZptYQQyue0ZuFQu/Az
	 WWgfSmQ8f3DPQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4g1fH86cHqzQqq;
	Thu, 23 Apr 2026 16:53:40 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Thu, 23 Apr 2026 16:53:35 +0200
Subject: [PATCH meta-tensorflow 3/3] fully remove unneeded python3
 work-around for tflite
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-python3-14-tflite-v1-3-68bca178a550@cherry.de>
References: <20260423-python3-14-tflite-v1-0-68bca178a550@cherry.de>
In-Reply-To: <20260423-python3-14-tflite-v1-0-68bca178a550@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 14:53:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3778

From: Quentin Schulz <quentin.schulz@cherry.de>

tflite used to be only compatible with Python 3.13 but we already had
Python 3.14 in OE-Core. To work-around that until tflite caught up with
the newest version of Python, meta-tensorflow had the option to use
Python 3.13 via a tensorflow DISTRO_FEATURES and changing
PYTHON_BASEVERSION.

In any case, since tflite has been updated an now supports Python 3.14,
the Python 3.13 recipe was removed. However, the remaining of the
work-around wasn't removed, still requiring tensorflow to be in
DISTRO_FEATURES.

Remove tensorflow DISTRO_FEATURES check and Python version as we know
it's going to be using 3.14 now.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 BUILD.md                       |  3 ---
 classes/tensorflow_ver.bbclass | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/BUILD.md b/BUILD.md
index 5a94800..7941b91 100644
--- a/BUILD.md
+++ b/BUILD.md
@@ -16,9 +16,6 @@ $ . <ts-project>/oe-core/oe-init-build-env <build>
 
 # Build qemux86-64 which runqemu supports kvm.
 $ echo 'MACHINE = "qemux86-64"' >> conf/local.conf
-$ echo 'DISTRO_FEATURES:append = " tensorflow"' >> conf/local.conf
-$ echo 'DISTRO_FEATURES_NATIVE:append = " tensorflow"' >> conf/local.conf
-$ echo 'DISTRO_FEATURES_NATIVESDK:append = " tensorflow"' >> conf/local.conf
 
 $ echo 'IMAGE_INSTALL:append = " tensorflow"' >> conf/local.conf
 
diff --git a/classes/tensorflow_ver.bbclass b/classes/tensorflow_ver.bbclass
index 902fc87..c20602a 100644
--- a/classes/tensorflow_ver.bbclass
+++ b/classes/tensorflow_ver.bbclass
@@ -3,23 +3,3 @@ TF_ARGS_EXTRA ??= "--config=v2"
 
 # Uncomment the following line to build tensorflow 1.x
 #TF_ARGS_EXTRA = "--config=v1"
-
-python __anonymous() {
-    if not bb.utils.contains("DISTRO_FEATURES", "tensorflow", True, False, d):
-        msg = "\nThe official TensorFlow is tested and supported under Python 3.14\n"
-        msg += "Please add the following to local.conf\n"
-        msg += "    DISTRO_FEATURES:append = ' tensorflow'\n"
-        msg += "    DISTRO_FEATURES_NATIVE:append = ' tensorflow'\n"
-        msg += "    DISTRO_FEATURES_NATIVESDK:append = ' tensorflow'\n"
-        raise bb.parse.SkipPackage(msg)
-
-    if d.getVar("PYTHON_BASEVERSION") != "3.14":
-        msg = "\nThe official TensorFlow is tested and supported under Python 3.14\n"
-        msg += "Please add the following to local.conf\n"
-        msg += "    PYTHON_BASEVERSION:class-target = '3.14'\n"
-        msg += "    PYTHON_BASEVERSION:class-native = '3.14'\n"
-        msg += "    PYTHON_BASEVERSION:class-nativesdk = '3.14'\n"
-        msg += "It will apply python3 modules for 3.13"
-        raise bb.parse.SkipPackage(msg)
-}
-

-- 
2.53.0


