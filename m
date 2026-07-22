Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA95EC44536
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 20:54:30 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10126.1784753670047571554
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Jul 2026 13:54:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LG8xLPeJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f707e5d75so2825061f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Jul 2026 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784753668; x=1785358468; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZwVm7MyKw7xnEqWCE+k3j8QWi/IaCN/Nl9QZUhmNIdo=;
        b=LG8xLPeJ0oJyx0DzD5kXZvJW40Qt6MRVbzGULQfP5PufQfYtXyL5Jr3ntJnEhkzHfZ
         hSqKeBpo/NjuENS/mlYSiWwLo8Ep6oKtFVsf5sqOmxCc39V7tckFL7PZbPUy6H2U71t5
         CuCBDza7FDmCDczizrmtePArKtm0OCUnlgkdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753668; x=1785358468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZwVm7MyKw7xnEqWCE+k3j8QWi/IaCN/Nl9QZUhmNIdo=;
        b=NdYWHEoLn+OkuemVue3ZO0D8LnTd62N93FsT25IJh1MKIoMzOHxmrXSzJgTjU32oH+
         WwlfkZe2InvpHay1XrHiF30Yo5kLApR9Ghz3J+xzUams6KGbLR7jiU2+qWg8oROx1bY8
         0/uNmUBGpJb+GuycdjV34uObJva7Zr+F3hQ92TJbAw2pROL6zcTMoFZY7U6JdfboRlwC
         v3hZy/Ng/S1L6i71IKayIiRtua0bv+EePf20HvoYmbliZSLOoa8Y+PUl11ITcA0o/54A
         OpvjKEuQV153ct4xJHkQP3iWSErHbZSXqJF6NK9CQEMDsq69X/NqB1ZY3AjV/quR735R
         EzKg==
X-Gm-Message-State: AOJu0YylgOHN9NwNQethmItgIF8u8t3z6LASwpKwbItMa+KuZPBmqK1R
	3xR+oTm9K2JaMLfRP0HqnwpcNHncGDR5Vij6H8LXZua1MeeavxBdlzCou3sgDMnoWC3b5cbwPjy
	d5ytcmpA=
X-Gm-Gg: AR+sD11tUTY+ag2wIv9Ph3PKfOcUpKBPOXrDFzlO4QdUVgBtBsj1OplGmFDW6rXfBGn
	1T6FttaBKEEmiF0LN9E0I23zw2DmOEMWby0F1aqbiOOiEDOpHI1QcgPRs/EPPHw++uO/FKaVbg6
	pd6vzMYsyEPNGSDAg0IobFvsr/ee+jiRSdebwAvkqR7ri/N7Hg17nafjFdvwkeqmYSZ8H3SjgjI
	620Y8jZw7iAjVBlBnEBYLjv9cbszSM76iTYfJb8QampZ7QoFgFFtaoMrvVFXfVIQvdayIqeWceo
	OJmmpYs5FAc+QkEcuuTlYpvM4g2cVriZAhko+fqzl4VZc0wfeZZBGGhyRZDcp+eO7oPUa2DmoMc
	r2ibf1CdbqYaWX1b3CHhT2YOIvxF9B0HA/pHTWDYAY7PkXBBBhBk+YONjI8XZgdYPXwNAr+PRkm
	+LhXpq9kFzXPedZ+qupvf6ZmVo2Wo7/F4=
X-Received: by 2002:a05:6000:3112:b0:47f:6fbd:8a23 with SMTP id ffacd0b85a97d-47f8da6e52cmr473278f8f.9.1784753668149;
        Wed, 22 Jul 2026 13:54:28 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2add:73ee:28e7:c242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fa9sm9940031f8f.20.2026.07.22.13.54.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:54:27 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Drop x32 support testing
Date: Wed, 22 Jul 2026 21:54:26 +0100
Message-ID: <20260722205426.3978178-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Jul 2026 20:54:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4531

The linux kernel plans to drop x32 support. At that point it is not viable for
us to have this so we may as well stop building/testing it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/config.json b/config.json
index 4d329e3..97eec0e 100644
--- a/config.json
+++ b/config.json
@@ -819,24 +819,6 @@
                 "OE_FRAGMENTS += 'core/yocto-autobuilder/multilib-x86-lib32'"
             ]
         },
-        "qemux86-64-x32" : {
-            "MACHINE" : "qemux86-64",
-            "BUILDINFO" : true,
-            "extravars" : [
-                "DEFAULTTUNE = 'x86-64-x32'",
-                "baselib = \"${@d.getVar('BASE_LIB_tune-' + (d.getVar('DEFAULTTUNE', True) or 'INVALID'), True) or 'lib'}\""
-            ],
-            "step1" : {
-                "BBTARGETS" : "core-image-minimal core-image-full-cmdline",
-                "SANITYTARGETS" : "core-image-minimal:do_testimage"
-            },
-            "step2" : {
-                "SANITYTARGETS" : "core-image-full-cmdline:do_testimage",
-                "extravars" : [
-                    "TEST_SUITES:append = ' x32lib'"
-                ]
-            }
-        },
         "qemux86-64-ptest" : {
             "MACHINE" : "qemux86-64",
             "TEMPLATE" : "ptest-qemu"

