Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B9EA4FC3
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 14:08:05 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35678.1771855675178000803
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Feb 2026 06:07:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=dOUTlt9V;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so41191695e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 06:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771855673; x=1772460473; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYoxSKLrz+cwCXVfS/TACRQBb4iohTW85YSVIvA859Q=;
        b=dOUTlt9VrqRotB15AzToDVGx3yu0E+P4BRr61r/NCr5+nl+9NMOUj+ds0zBCs4trhw
         nVQ5vEPsMc2+piCXASP4XlSDMhLlPuvf8iYpv9P+p3Vmh9ofIKZPDXzSJ/JA+NNz1DKV
         oovx3SunJ0vV6Gef613Ark7rBEdXXULk6SAls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771855673; x=1772460473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYoxSKLrz+cwCXVfS/TACRQBb4iohTW85YSVIvA859Q=;
        b=q2fs2+B8aa87e4ndBith7VON783SpxC+0bSQ2gsvtOhhyaYK4sLvi2SKm494xOK67E
         lRA5JqwrlYl5nEznOTuBSewvLuUVh9nMKDZoAoUAXGgEJlGdoavFePaScfZQcx/10dyV
         YJOv64o4eCQWJZ8hrXDghPMwaVkMH6fnI1ZicuCy8qKNCJ07DJ6FzqsSoFP8CHCoryYf
         urpd7rxWbVOSx7im14MWMT5/JY2nYdb1RGXBo5dA2GohcC61IVz4t/vKstIE3cHiOFf5
         e8dlb90SVTFKIrd4YHV1zKWF83DhaXapXX6l5tUkgxSg2GGyHIl4A8tGQdJkoIwFl1vD
         hdyw==
X-Gm-Message-State: AOJu0Yz5JpBZullkGgKI8ExtzCkIbTrx1shd1+heTuMpw5s8KifmfwKR
	ODW1JBeQe/f+7suYBzRuCl9gmL7cMbymXnnSBDdAy6nh2ALWxpjb1//Vvy6xHixFgHPUxn7y3tR
	GS9Xj
X-Gm-Gg: AZuq6aL1/4nkfPLVfFEVUyLZy1qm7/OLjULOfWQ24+v/ORAc1z1c5jV20rgconDZQBw
	N9VyqG2VDQfYTwcUzFB/J+XE4p8tbHAHT3ueI8sXEEQJQT2sjZJk+dCuU70tTGc6qLChgWl1UyC
	7+y5kZkiQVJA6QzeD3ytxpkvfbbgZ7WNkQLfTDcIHRm8KVYpbDf9PcBvciDTuVYbspeybZmJ+yN
	aP3ksyXF40g/oJe0t0TVGAvACgoFNeJhgklSQMVV7bkMIL1u0o/b92xm7HC8TXDsZHNx+XrO0sU
	3Xkl+KuDMoHj0DsW4Gr0sjBHklMei4JyncK/w263yjjaK7YrmSI0JKlwWc8cpl9YTW4VhLRJkA+
	guHGvqDCkGIgSGEv3fWfffoAQlxtRkML58grcMj1d3icjisfYI+Q9AVqz/Aoq/GMsWiIi4l3N52
	vVVu94oWi1trIu0vjC2SghjX3tDXcbZzIasYHZrtMB49DkxmDNqI29UIAkClmP1lnfJeQa6VkMD
	dBqYLpOYrRXYeKLeeTJNtPF66Kt
X-Received: by 2002:a05:600c:45cc:b0:483:4807:210c with SMTP id 5b1f17b1804b1-483a95f5611mr162527495e9.24.1771855673273;
        Mon, 23 Feb 2026 06:07:53 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00f13df544104db802.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f13d:f544:104d:b802])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a8df83bcsm218081765e9.13.2026.02.23.06.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 06:07:52 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder-helper][whinlatter][PATCH] config: remove meta-agl-core
Date: Mon, 23 Feb 2026 15:07:31 +0100
Message-ID: <20260223140732.40312-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Feb 2026 14:08:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3268

From: Yoann Congal <yoann.congal@smile.fr>

AGL does not support whinlatter, no point in running this build.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/config.json b/config.json
index e08507e..24caba7 100644
--- a/config.json
+++ b/config.json
@@ -658,23 +658,6 @@
                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-weston:do_testimage"
             }
         },
-        "meta-agl-core" : {
-            "NEEDREPOS" : ["bitbake", "meta-agl"],
-            "ADDLAYER" : [
-                "${BUILDDIR}/../meta-agl/meta-agl-core"
-            ],
-            "DISTRO" : "agl",
-            "BUILDINFO" : true,
-            "BUILDHISTORY" : true,
-            "PACKAGE_CLASSES" : "package_rpm",
-            "extravars" : [
-                "AGL_FEATURES = 'aglcore'"
-            ],
-            "step1" : {
-                "MACHINE": "qemux86-64",
-                "BBTARGETS": "agl-image-core-autobuilder"
-            }
-        },
         "meta-aws" : {
             "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-aws"],
             "ADDLAYER" : [

