Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FFDCD343F
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:01:14 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4512.1778205668116700911
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:01:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CheiWr83;
 spf=pass (domain: konsulko.com, ip: 209.85.215.170, mailfrom: tim.orling@konsulko.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c801912c903so641177a12.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205667; x=1778810467; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebl3YGTub9MrTIEoegIDvC3JC2jHUfps/hvTT6lZxpw=;
        b=CheiWr83nqcpnIjAz1vewu3LeIGlSvWGFpOtdNRurOoJBjljLj9zdEDqKn+zjfobOa
         hUEOmlpb/0J4oDjYp91/94M8dhGqJzRsLT49Dt6e9gDoYahrl7dk4J6OuouWT684qEl7
         Ce7KJ0z/pUt4io3Wyzs/h6QJf1hNBvBWaVFHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205667; x=1778810467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ebl3YGTub9MrTIEoegIDvC3JC2jHUfps/hvTT6lZxpw=;
        b=hXNGwKsDdfOQq/82aKZrcwW7lwtj4aiqQXvKPfn+qPqv2bvBO7o+fSZmFgL1nfRCEd
         42C19mwF1RFcUVDksGSUahutVCH6/eNGOukXMTmhbvuQl8KnXo2w34oNXicuscUR1IQH
         zGvbKxNBkKGhvZdwp8aN4jcf3chcHk3tTmyXyOLexqlR2vStM6KSfHemTJxGGaye1GIJ
         83350fXIP24ctJpD8Lg2BH5E9lvAwPFY1FHbL6l3D/342y7+smifsOSrf7kmYeSU/34S
         M5vfO9LkWzcvBixvmGuYfpLI1obZiaN3/SC3VCyOu8PUn2neY5JXgWyf2p2p2LaRy9v5
         ltpA==
X-Gm-Message-State: AOJu0Yxjp3iK9ADbZ8vBzuM1QTCbjZIKCUxS08RE/MTczGiFNL5vAfRJ
	58TjpGEcIGYZ91Ub6h9FLJsbx3lWO+h+KymQOJZqWF52lWZQTGmrzOybC+M8RoQrdcUe5DyNknP
	zMrQq
X-Gm-Gg: AeBDieth42cYHA3if0fXKXBO06S8pGIRLZa9bVXWJGcEdeNVxcjnxhib/T7BS+IPMLk
	ZczuftwX9POfeYFJLM+x+ab2ev01f0xxw9B+Lp4zg6MIm9YYGxfAQpFHWZRVkdJbUOauRVimN9p
	FsjE00mi0zw/AnLCUWdfR2WN3KDy70X4xc/J1V4OiCHFZC7pT1EaS/UzIumy+gC4RSPkejJA2aJ
	nkWR+PfxAnJQ0F4SRQuSLWSJXfKNcUylqfuZAjQ7agPrbCEFblxH/zUhH2D98Nb5kX/+BQsKE+n
	Yrci94m95QCrmac/cWbpogU9AaZwB+cucfpjNhpF6NCqn26vHh0fEGRJd5wKimIyp71VQe9Dquf
	r3kc61Q2xKPZs3qdw+hhTUFoYOi0KYjezrWOit410Vr445VjO0njgq1O9SJ5xHCL++FrrPJeZmE
	J1RsIvQuG5ia4W8I4rzpb++WupwjA0Zao5gM10MM5WWUg3iaqDPgL2tg6J8W6TguGB6q/dvKwj1
	y0ZWOK4yU0f
X-Received: by 2002:a05:6a20:7292:b0:3a3:33bd:319b with SMTP id adf61e73a8af0-3aa5a99f71emr11485161637.39.1778205667288;
        Thu, 07 May 2026 19:01:07 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267735eccsm132092a12.32.2026.05.07.19.01.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:01:06 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 11/11] config.json: containers-library: add mosquitto and valkey demos
Date: Thu,  7 May 2026 19:00:34 -0700
Message-ID: <601c281165450b2be14de46bb9601e82229ca5f6.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:01:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3950

From: Tim Orling <tim.orling@konsulko.com>

Extend containers-library with two additional demo images sourced
from meta-yocto-containers-demo:

  * app-container-mosquitto: the Eclipse Mosquitto MQTT broker.
  * app-container-valkey: Valkey (Redis-compatible) key/value datastore.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/config.json b/config.json
index 7cdf91a..a9a2e9c 100644
--- a/config.json
+++ b/config.json
@@ -1950,6 +1950,18 @@
                 "BBTARGETS" : "app-container-python",
                 "CONTAINER_IMAGES" : {"app-container-python": "python"},
                 "CONTAINER_VERSION_RECIPE" : "python3"
+            },
+            "step2" : {
+                "shortname" : "Build 'mosquitto' container",
+                "BBTARGETS" : "app-container-mosquitto",
+                "CONTAINER_IMAGES" : {"app-container-mosquitto": "mosquitto"},
+                "CONTAINER_VERSION_RECIPE" : "mosquitto"
+            },
+            "step3" : {
+                "shortname" : "Build 'valkey' container",
+                "BBTARGETS" : "app-container-valkey",
+                "CONTAINER_IMAGES" : {"app-container-valkey": "valkey"},
+                "CONTAINER_VERSION_RECIPE" : "valkey"
             }
         },
         "vcontainer-tests": {
-- 
2.43.0


