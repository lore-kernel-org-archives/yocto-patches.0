Return-Path: <elmehdi.younes@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD0FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 09:35:26 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11075.1777887317967830323
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 May 2026 02:35:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=m4fE9lY0;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: elmehdi.younes@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso1227070f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 02:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1777887316; x=1778492116; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n8rg0UrKN1mXfmCzYtogPWbhx2DFoCN1UwST3/+MOpg=;
        b=m4fE9lY0XE0dXDU+9JvyXGWsGZqNNJaCf/Wb8iHfE+p37IcLjGC6caLWq7lE03Dizi
         I5p5qFrrwqMgiT7JS+jvpI2keC0Q7C/1R0EDCESHzqRbcF5qdJoDye9bvUBgyb0OjoZI
         dLv3v0FaSUIw4l39Nx1Rf6q/gJLCrabIwtF/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777887316; x=1778492116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8rg0UrKN1mXfmCzYtogPWbhx2DFoCN1UwST3/+MOpg=;
        b=fRulaFCpGNDaFmg5eZ8UxFkKT2bLOT0+CqtMCpG8LcMC+eJ/W6Xsh01VySwpFnj+IE
         SJEXdKn3vlZTnNbTemyFA23J7en67UN8wUgF2cqPFiC+1ByDyru7p+0lOSgP+ePVC6AM
         +Y8PdkecAauVxpm6603z9ovd1GrKikmYzVu5+NT/3aDzx0kxLmEGNJyUwq6VmS1tfrnn
         mGeDWbzCzQ0udzwcQY/ycgfQVNQWLywUfEV0CKSwxNHTHcevtdOQb+Q8owtX8U3ok025
         vGI61bVhEZn04WHYuQRts81Mzkxyvlh2MgVYoudXVcQqQjr7BOjmzsxXhIgAnpcyq/Jh
         j6Sw==
X-Gm-Message-State: AOJu0YxoUeqScjXUoZyAAjYDDig1o+xTmfE0V0R4WbHrABWaoy+fRsBi
	i+yEWvlA05tduF8E8a8lujjWotYObUq8qfNqqE4L1uETHLbtDS33jUsVCvOtHQ3GFp9lNidhlQn
	1LtW9Soc=
X-Gm-Gg: AeBDiesY9HbhQ0jFV77nVE5fNKwpVLVM4y9l5pbN1WPqgJaxfMQm6tJ0/Q3gRKXQFYY
	dHj9Pc+CSjtQK18rBysyHAFYJ9FYl0RQYDr1kVrs5nVgYe7VwoLDV4qqJ3IMz3/Ep2T/X05YIyW
	WM9nIUEAfpbgEWhM7Twxb+HjGjDnp5F5jQniTVSl0a8Bk0w7O11KY+eTIZFWVDHrfcMOp3J3djc
	yaecsdSVMiKMTRpXYdXGpHF3EsXgTxLwDXJKUJP8ft7wxUnwbmFAn2tnuxzlwqgN/DmnIHm0NGC
	3px1EWmoIVsQCD+Bqm/jO+lBI5BXii01jtBsxSMa/pZM2iEFFKnLXB9RsXGDpuz04OyRtS3cvpy
	GR6oOdSjS1ylBw+yXc4p5Ylo86LM2YYU69tM0lHQNXN6wJXTmcS+fvV1rIf/s49XHLLOba9iR4j
	zmmBdVRFqOuEFNt3kBF7TNWR0r+smHVv7caUyd90RXDKtvV7QdTooM3tO4GdT2bXt2ZF7D58i20
	583B35O9DBMb9qUMTa5Hhewfs1wzfkZ
X-Received: by 2002:a05:6000:603:b0:446:ef9a:8f41 with SMTP id ffacd0b85a97d-44bb6e8e014mr14167666f8f.40.1777887316013;
        Mon, 04 May 2026 02:35:16 -0700 (PDT)
Received: from FRSMI25-BOLET.. (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ef50e59sm23970090f8f.10.2026.05.04.02.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:35:15 -0700 (PDT)
From: El Mehdi YOUNES <elmehdi.younes@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: El Mehdi YOUNES <elmehdi.younes@smile.fr>
Subject: [yocto-autobuilder-helper][PATCH] meta-oe-mirror: select systemd through INIT_MANAGER
Date: Mon,  4 May 2026 11:35:06 +0200
Message-ID: <20260504093506.1434307-1-elmehdi.younes@smile.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 09:35:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3909

The current configuration appends systemd and usrmerge directly to
DISTRO_FEATURES. This leaves VIRTUAL-RUNTIME_init_manager set to
sysvinit while systemd is also present in DISTRO_FEATURES.
Init manager selection is expected to be done through INIT_MANAGER.

see https://git.openembedded.org/openembedded-core/commit/?id=0b4061c5d50261f826d0edb4b478d2d305274b7c

The current meta-oe-mirror configuration breaks the autobuilder with a
large number of "Nothing PROVIDES" warnings/errors, as seen in build 717:

see  https://autobuilder.yoctoproject.org/valkyrie/#/builders/82/builds/717

Signed-off-by: El Mehdi YOUNES <elmehdi.younes@smile.fr>
---
 config.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 3c067d2..beef339 100644
--- a/config.json
+++ b/config.json
@@ -1813,7 +1813,8 @@
             ],
             "extravars" : [
                 "LICENSE_FLAGS_ACCEPTED = 'commercial'",
-                "DISTRO_FEATURES:append = ' pam systemd usrmerge opencl'",
+                "INIT_MANAGER = 'systemd'",
+                "DISTRO_FEATURES:append = ' pam opencl'",
                 "FORTRAN:forcevariable = ',fortran'",
                 "RUNTIMETARGET:append:pn-gcc-runtime = ' libquadmath'"
             ],

