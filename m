Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF1FEB104A
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 10:28:01 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36820.1773138471567152455
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 03:27:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kX4u5zCT;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso6899300f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 03:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138470; x=1773743270; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4/eXk6PXbf63ASPwziBF1/yvM7Q+dU3JkEwqNU15XU=;
        b=kX4u5zCT5zWh1aVm0yLKDF3xxKMFKtQ4V1DXdGcoDeFNMpQvhMwXDjICbxZ8wTSI2w
         75GssCxEa++/lWk/aov4TLBgPazccUaDJY+2pF7gLp9F6+4qXslMWj/gi+QhAcJMK/jr
         HsE8lB0eewgaXv2eOjqMkVCUcgGuqXGhwTi1svJs+Mv2PrPj/tJm//v6g7Ch6SyeIN5v
         H7jgRUpZxTMmmto4KhFE98BpAON9iU8bFxPvCwaOzqsGgOLMVH5lMasp/VSePRmP5PlH
         Nha/YMqqY1fI9sHlpuAMX0y91f7Ek0eW5xFfLTHFQtcCcamCq1AUx3GtRqsIj9DzOUQ1
         R4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138470; x=1773743270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4/eXk6PXbf63ASPwziBF1/yvM7Q+dU3JkEwqNU15XU=;
        b=CfxT/a3mrKWZSCrk+6Ci1AuOyhZk0u45Xq8SXjQnGP2aavqK9QESgTmJuUtsw0tpwh
         S378okU21e4Lz5yO8L9TReByzK5TnPYG8Ckv40N4HezGE9k3Ip0HW5dVwjzJjgizHkYj
         IxCstRdN6p+AIIg9JQ4gH9N5ubKzIkI74c45ZJX+OaJNmW4lMOKgfItvdNxHmg5JEp7r
         SRduGmb6kQ+XMJPWKvmeZLsF0q7LyP2we608rjDzJVKOCirjI2Io639Jv5bdGIT84ayf
         G4GwRshCEmSOgiQcmLCcGKEjrHcALAEsP6IYA3Xg4QbsowB4rGQHwh+zZDnq/nJLx/Fe
         MUJQ==
X-Gm-Message-State: AOJu0Yw1PaDAvZM1+dGowM3ucP3hu9HDNAcvGzpmPgYs7CcW5be7gIUX
	IJesM0/Rxo4WcF7/cVOZLDbqAId+Asg3fbaIAnkR72ftA7TdHKif4/QKxF9ThNg0
X-Gm-Gg: ATEYQzx+s5Tb1tAjT6Fdudz78QfuvZAK9c8+WK6izW0fyTDaxYpZUPeAYjfoCgytdOv
	SwH8tf0OomuxADdbw4eP7p7mlVGSqlbBIUsrVLuagFcLIRLAtuY7O60SmimSptz/y/FThzHHrnq
	tUY6jDYDA5rmZedvBPieULwTltQHT/iK3bRO27jvA3TtyhhB1hUAL19sObiV7FXCErfFJL+r6SB
	p33LyaWKx1NWZKEGWXeFiWXhUV89c6X8Sy9RZRHeD0karr4pUQwGVP/LWqsvB0ctB13ey5i4r7G
	1kj2iVGKVQ+JTfHXCxhhkkYAyMExcP95tXFy0qlS1fBKlJ46oPeuV4EKtlJoy234V+RiHcvv4Zm
	zxW1jhRGxZ0jDIgxEzv2+9xXkgY4f0lH1K3ibPjAb7xc+zO0sqlYs0AvQ9IjDUAbB9gnUE9O/cm
	VTgINIJXwm31/2LcallvsXKjh/2xfLsU15f+9A
X-Received: by 2002:a05:600c:4507:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-48534a29447mr145944795e9.33.1773138469525;
        Tue, 10 Mar 2026 03:27:49 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa7aacsm81044585e9.13.2026.03.10.03.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:27:49 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Armin Kuster <akuster808@gmail.com>
Subject: [meta-security][kirkstone][PATCH 2/4] packagegroup-core-security: remove pkgs
Date: Tue, 10 Mar 2026 11:27:37 +0100
Message-ID: <20260310102739.2743995-2-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310102739.2743995-1-martin.jansa@gmail.com>
References: <20260310102739.2743995-1-martin.jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 10:28:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3392

From: Armin Kuster <akuster808@gmail.com>

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 .../packagegroup/packagegroup-core-security.bb       | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index fefc66d..87c5b7a 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -10,7 +10,6 @@ PACKAGES = "\
     packagegroup-security-utils \
     packagegroup-security-scanners \
     packagegroup-security-audit \
-    packagegroup-security-hardening \
     packagegroup-security-ids  \
     packagegroup-security-mac  \
     ${@bb.utils.contains("DISTRO_FEATURES", "ptest", "packagegroup-meta-security-ptest-packages", "", d)} \
@@ -20,7 +19,6 @@ RDEPENDS:packagegroup-core-security = "\
     packagegroup-security-utils \
     packagegroup-security-scanners \
     packagegroup-security-audit \
-    packagegroup-security-hardening \
     packagegroup-security-ids  \
     packagegroup-security-mac  \
     ${@bb.utils.contains("DISTRO_FEATURES", "ptest", "packagegroup-meta-security-ptest-packages", "", d)} \
@@ -35,8 +33,6 @@ RDEPENDS:packagegroup-security-utils = "\
     keyutils \
     nmap \
     pinentry \
-    python3-privacyidea \
-    python3-fail2ban \
     softhsm \
     sshguard \
     ${@bb.utils.contains_any("TUNE_FEATURES", "riscv32 ", "", " libseccomp",d)} \
@@ -47,8 +43,6 @@ RDEPENDS:packagegroup-security-utils = "\
 SUMMARY:packagegroup-security-scanners = "Security scanners"
 RDEPENDS:packagegroup-security-scanners = "\
     isic \
-    nikto \
-    checksecurity \
     ${@bb.utils.contains_any("TUNE_FEATURES", "riscv32 riscv64", "", " clamav clamav-daemon clamav-freshclam",d)} \
     "
 RDEPENDS:packagegroup-security-scanners:remove:libc-musl = "clamav clamav-daemon clamav-freshclam"
@@ -59,11 +53,6 @@ RDEPENDS:packagegroup-security-audit = " \
     redhat-security \
     "
 
-SUMMARY:packagegroup-security-hardening = "Security Hardening tools"
-RDEPENDS:packagegroup-security-hardening = " \
-    bastille \
-    "
-
 SUMMARY:packagegroup-security-ids = "Security Intrusion Detection systems"
 RDEPENDS:packagegroup-security-ids = " \
     samhain-standalone \
@@ -92,7 +81,6 @@ RDEPENDS:packagegroup-meta-security-ptest-packages = "\
     ptest-runner \
     samhain-standalone-ptest \
     ${@bb.utils.contains("BBLAYERS", "meta-rust", "suricata-ptest","", d)} \
-    python3-fail2ban-ptest \
     ${@bb.utils.contains("DISTRO_FEATURES", "smack", "smack-ptest", "",d)} \
 "
 

