Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FCBCD5BCF
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:16:05 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7098.1779624959135452321
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bcPKfaVF;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8c7154725easo103250836d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779624958; x=1780229758; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtJ2P9Q2AMfClIgt8f+P4Vs19Sb9QdV+0GYmVPc+b44=;
        b=bcPKfaVFocsCOOhgL8b5r1Sts3CV8XVZBTQ9itdPonjmHe8LorjAflPWOrlBI4UwFy
         1DO1Zr1UVKX9B3LtE2eYUdaCoAElhDx3DguAhpq4LqZJ+fC2EFz5nmSGijURQgOqzV4E
         HNHNs45++8K++ZZyfsQxvFctYmha8Qxv1ELlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779624958; x=1780229758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FtJ2P9Q2AMfClIgt8f+P4Vs19Sb9QdV+0GYmVPc+b44=;
        b=cc6QE8FLQarQth/Oe6lkjajgKcntyHf8JhxPyXWVbLerUZ3zTzRsb6sOgS8dsQa/vC
         x9SSrquC/6yL0K6kvScB211zlNb4oEUqYCJ2C3q545lkON973J5r0ulHS5w0+WO/SQZr
         842Qg8BO2pE8Wd+W3vSvGZSPeSHbZX6lZ9ENYGqi2TOG7WNN9D8ugkvdB6mq1PtZp8Se
         g9UztbbjRdUTh07C+vQkb9gPG1MXfp9Yn4TVUtpaIfp1i10UmgzDTakfMTr8/yxassnl
         x8RYrqVnt3PL1Yy4nFPNMkKn2uQ3kWU8eu8o9niREaQWRokY95KsyWAXC779QYibWIJ+
         bASQ==
X-Gm-Message-State: AOJu0Yx5VerR/qpL2QfcHV5ZAiFumZksMfFWUPeuGZLS+3slIZid+9vL
	JYwAMbKpgbqg1N7L1uzFYou/zaLhj5uLMqeXoi+Jk3Vaf8Tto681cScQgyypwXPV94ZtwmtYe78
	tP5c1
X-Gm-Gg: Acq92OGTjZz/r/yMmXwNneYuksyvQPBmBGRuTzYvM4cpWLDa/DVIBNbFPdamgDA5GWr
	9+39ldOndFGl1R/jbwPAk0pScFaO/0aGpzBoT2YNGyOAn0Lb7BVQhR1tIIjrnIwvDHmWafXobJ/
	D6S/V/tZT+tdX9KosrgiqPPcVKYER0sNn2ISeYSCvu1rbUB2FBIDPNI3dw2qeqTSJuzkszjRc3n
	vEBq5fBoGwKnFHqGoy4YKq7r1Q/gH10imjgjQW4Zz/GAEiXFCYTrTtVQsqB/9wm9xMbC75KWvhX
	AacWzSG20jvMVAIEKrP2o7hI2cOKGA5tlW82IDW4rQXzpmUWDRnZreMj3wpV63KzDARhq2+4ghn
	kOhWpUu3+i0U9HFS+giOUZq1tAySZ+7GE7kmcqG2EjsbCwBI9uf2ZC0P6kwRuMxVKn8Q3VmzZ7f
	l7faMmQ7ByX7uP9Ouy6bOJiJfEAVI2wVUK0XJL84Pl8tTgrD29Au2TKnQfyN3/S85ZoWkaYby0C
	PlqiDuOrFySTvqPYlHGhJlaylYiqztvhMc22hQfhWlCBV3cbvW5AOc9tPuRVCL/
X-Received: by 2002:a05:6214:501c:b0:8ca:1e0f:f20c with SMTP id 6a1803df08f44-8cc7b5f0c35mr165887106d6.4.1779624958013;
        Sun, 24 May 2026 05:15:58 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm82385186d6.38.2026.05.24.05.15.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:15:57 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 03/13] google-authenticator-libpam: update 1.0.9 -> 1.11
Date: Sun, 24 May 2026 08:15:30 -0400
Message-ID: <7a505194a88cbf39e59b1d0258cddc7ad2aca2e4.1779624335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779624335.git.scott.murray@konsulko.com>
References: <cover.1779624335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:16:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4009

From: "jason.lau" <Haitao.Liu@windriver.com>

  Changes from 1.09 to 1.10:
  - Shorten syslog name to work with rsyslog (#172)
  - Update config file with grace period in all cases (#193)
  - Remove printing QR code using Google Charts URL (service shut down)

  Changes from 1.10 to 1.11:
  - Change secret key bits from 128 to 160 bits (#266, #271)
  - Add support for black & white terminals (#268, #270)
  - Fix grace_period for IPv6 link-local addresses (#265)

  Also fix the .bb recipe:
  - Fix typo: RDEPNEDS -> RDEPENDS
  - Use new override syntax: RDEPENDS:pam-google-authenticator
    (replaces old underscore style RDEPENDS_pam-google-authenticator)

Signed-off-by: Haitao Liu <haitao.liu@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...tor-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-security/google-authenticator-libpam/{google-authenticator-libpam_1.09.bb => google-authenticator-libpam_1.11.bb} (85%)

diff --git a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
similarity index 85%
rename from recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
rename to recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
index 333caab..713f60f 100644
--- a/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.09.bb
+++ b/recipes-security/google-authenticator-libpam/google-authenticator-libpam_1.11.bb
@@ -4,7 +4,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 LICENSE = "Apache-2.0"
 
 SRC_URI = "git://github.com/google/google-authenticator-libpam.git;branch=master;protocol=https"
-SRCREV = "962f353aac6cfc7b804547319db40f8b804f0b6c"
+SRCREV = "016774b0b75ee8f5e80028998d386de762ba1697"
 
 DEPENDS = "libpam"
 
@@ -18,4 +18,4 @@ EXTRA_OECONF = "--libdir=${base_libdir}"
 PACKAGES += "pam-google-authenticator"
 FILES:pam-google-authenticator = "${base_libdir}/security/pam_google_authenticator.so"
 
-RDEPNEDS_pam-google-authenticator  = "libpam"
+RDEPENDS:pam-google-authenticator = "libpam"
-- 
2.53.0


