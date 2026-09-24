Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C8BC9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 15:20:05 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.924.1790263203151584233
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 24 Sep 2026 08:20:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AasAoPQ5;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.76, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4858bc96fabso1912274f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 08:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790263201; x=1790868001; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EqXqIDO5eo9c3JHIzn4P7rWmSsBTfCH/2RXwZCr90fI=;
        b=AasAoPQ5/632xhuTN1qNF6Y6h7+fPeN3QV3t+KaFW/OtOB2ZihzlTb7+qVJd7roN0F
         h0xpdrxAofxsOnbJZfHip9PiRxsnwDZjYqHLAitXhN4YDPq4LhNFv+NaX1jVcKAyLObB
         YMC6MrHH5MnDrCPjGobEBGd9hX957OWAqsVPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263201; x=1790868001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EqXqIDO5eo9c3JHIzn4P7rWmSsBTfCH/2RXwZCr90fI=;
        b=JAoeBK9H83HbPX6nGB+VzFNrNTIx4PnIoKWm8UzCzDTHO5QfZf+foFFVVKTUD7gNL+
         MYQRvrUm21Nepk7pJ7cckti1O/ta9uFYH+ruuk+w3QZz5pxo0kPD+mCl+u3Got5fg4me
         vgbcTdQiS4nquhvhlYSwKm7PTCFBatjq+/ivMyu9+/+j2ghgCjrAg7llkLQrriHIGnDQ
         97TiX1D/yQlu+d0vjMNEyCsF8BMCaW8de/ui9SMpI5Lh4OSgQdsgGHL+Ay4Yf6LftkYh
         gCmKeGOpS8cRjqasN/Lk1Q1RMUxNOG7xGqs1J7Nes29/e5oopFuf4hlqQMf2E7FDzxmw
         vvQQ==
X-Gm-Message-State: AFuF++mFww/iAukiG6xdkZcSUHe3zyDhiNXC9ER6BeGEC1T3E/Nl07KN
	uHWnSLVria0fY6rvOyVZBWkBskxfnbtkIu3ix/F2Mw5ID1VKZTKM1+M9/St7G9Qqv0dfVckoNuV
	wV3KmvCM=
X-Gm-Gg: AYBFou2ZVtcnPTKQFlIBOpoSXVhFIwM99ZGPLQQjhJZTLGpVy6rQ5VrqgDJwK+pSn5L
	PkW/jw0wpMDoT4NY1vcvQj4v4+aGRpqNgya7Hcyo8S/lIUqU39My0noXwMmB8Afd6pTb34IUaBf
	C3IBLvpzkIoF5PwR8eno2t1rR9h16fkK6bQhythAKW2Hx5hZNghLH466GVugRB1tbKrIjyin/4U
	J7cwQpcQTEBFXcLqD+WbS6dgo4tWPytDtjpbA6CLggVaBgwjHFGC42UtZuMNjjj/htn0+nk3tjv
	Vzkv0L3aLMFVWtIdl1CM8CNvM661vd8QLwcdYfhwIWKMY54n3AxDdTBdea9UerZyf5ioD8mkGHt
	/NXAVALQimdQnwD/3l9yIWsFz8/mhLg8lqeWxIVNeki9/5mAfG+MabJrBLOMKjcfBI41nKUNQlh
	fcNsZhXL8IZuX3MT6DW8Db4ZRrODCCAH9LjVhNRqnHAMO1GyKivN5zq6sxe/Fu9fDnqIjWcMMsl
	4gTBROmN0ev03tYV4aYyqOLBxrk8pKJZs1s
X-Received: by 2002:a05:6000:2007:b0:487:f18:9a3e with SMTP id ffacd0b85a97d-48872ac7711mr4428024f8f.43.1790263201186;
        Thu, 24 Sep 2026 08:20:01 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d896:f63e:1133:71e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868779472sm15971597f8f.23.2026.09.24.08.20.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:20:00 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Move meta-mingw from check-layer to check-layer-nightly
Date: Thu, 24 Sep 2026 16:19:59 +0100
Message-ID: <20260924151959.1084244-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 24 Sep 2026 15:20:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4953

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/config.json b/config.json
index d4b2ec2..17c241e 100644
--- a/config.json
+++ b/config.json
@@ -1248,7 +1248,7 @@
             "TEMPLATE" : "reproducible-meta-oe"
         },
         "check-layer" : {
-            "NEEDREPOS" : ["bitbake", "meta-mingw"],
+            "NEEDREPOS" : ["bitbake"],
             "DISTRO" : "nodistro",
             "MACHINE" : "unset",
             "extravars" : ["MACHINE ?= 'qemux86-64'"],
@@ -1263,13 +1263,10 @@
             },
             "step3" : {
                 "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-yocto-bsp --machines beaglebone-yocto genericarm64 genericx86-64 genericx86"]
-            },
-            "step4" : {
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-mingw"]
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv"],
+            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom", "meta-riscv", "meta-mingw"],
             "step1" : {
                 "shortname" : "Test meta-agl YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
@@ -1317,7 +1314,12 @@
             "step11" : {
                 "shortname" : "Test meta-riscv YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-riscv --no-auto-dependency"]
+            },
+            "step12" : {
+                "shortname" : "Test meta-mingw YP Compatibility",
+                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-mingw --no-auto-dependency"]
             }
+
         },
         "metrics" : {
             "NEEDREPOS" : ["bitbake", "meta-openembedded"],

