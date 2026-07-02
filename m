Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5820BC44506
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 04:45:41 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62845.1782967534907356382
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 21:45:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CS+Ndl8T;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46cea75d96cso117770f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 21:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782967533; x=1783572333; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=czrmO2kkPQ5UZ1erTeLkCYpIS23IvRRHAIhEwyWtyJI=;
        b=CS+Ndl8T6cEfAp+1yAcbFAAjObPw/lMkwe+Qo4+P/X4YpYWoAHUi6YSfxc6BoSmCwq
         T84tW/dLsMugIjklRD9EfcgTMSyWNq3oIBJKMa3jhOzSlFTKA2KEkuPoP2RJ8gMxXw93
         rJhEXM1w02j1x+Ms8j5tfnRWcjEJd6gX1N/Al4AXYTPXANZMOi6CyM99qAUmZrhAzufx
         kfF91Xpp6bndugTRUKN85cP6RLxIp8wcVNOYhinAAkPfM7XIeZA7R/hdBGVhaWvv2+mt
         koWD2vcOYcs3h3j/uJ6TnFoCElv9GJhU3rWjoN7XmDoS2Ru6BV9FJDqSHdQ1YkHq5tAp
         3vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967533; x=1783572333;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czrmO2kkPQ5UZ1erTeLkCYpIS23IvRRHAIhEwyWtyJI=;
        b=DBEhA9/D5vzxVhOrhiRDwNbMxoMclXh6Tufp3yFVqq3umhngmgPATcpEPh5Omm+sPa
         2jwgyUmCqWzeKGwuPxmB5YJaymL+q0yUrQWdUJ4JPi3PAFF/FWdDCff649o6W9IKSNEX
         1IONnePVK0jmw+1Zkv4EVjM+3FVcTR0Ff9+sTVHBTTw4nYgD5jwlQA1fME50ggKl/bKG
         SSnydvx0qx9KlupdKliTquNMoyN4VYDLeSW6ltNn2tCkNFypImTVELupIiLsziDN0mcg
         m6a1l8yTQOwASm48//ZyMBqdhcofTT8SCoElDgWvaPgtLTA+7vtO+65iiMG14ylWyy7x
         ieGQ==
X-Gm-Message-State: AOJu0YwlTsJOUXLugRrw3YHWV+jZ70Am1PXynZ8RGMXSgbR85eWek6yE
	q9HhoOlFIMsocSD3YpgACm9atSESMdArm4KePD7IgXSCx4MQA6qIeWjpRCQXsSXj
X-Gm-Gg: AfdE7ckzqrG7Q76R1a2aaLAmFwfzXP7USkmgDW8K8ORzGTOxaq6TYEXDYDFAkbZqHaF
	iAdGo8cOIm7yXLanjneyrxO0xQUgM9+SdeBa5XGr3F4vQgDfiy5FRYQZwj0thpf2CzP8OHZ9za6
	UmkIk09mP6FIx1J4K7Szk4hmEZza+vdZdT5XF5+HjA65HU+iVQPKC1GY5avcOpDAonMmFAc6E1R
	Y/fbhbWpLEWnOaIaWtCebmllO2t0dPkk6O6vK3n1Ny8TMO9DVuyAi9prKSQdYDi/q8jeqjckUo7
	GoWQlZec9flBMfEMGS/dThGtmENquIFZAQuL3WmFnUeEUo50TniRbIrNHW4eGGrp5Y3mTk8jnj8
	dnTipif7EEKNXH/6HRktPROfU+BR9vqvGB5+O4iYQYIMVKAtcjENwCcjubpF1ixVBLOSPcK2iT2
	53P8y2GuUW6/yBU/h/Y6RNQ1tyVKIN9x+9ncafEmwK0n/09qTNEbzz6Bp9E3aObxR7umzG
X-Received: by 2002:a05:600c:8189:b0:493:b879:9c19 with SMTP id 5b1f17b1804b1-493c2b99b4bmr35143305e9.7.1782967533184;
        Wed, 01 Jul 2026 21:45:33 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:8a40:d7a5:890a:fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm15405275e9.6.2026.07.01.21.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:45:31 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH 3/6] wic/help: List missing option --workdir usage string
Date: Thu,  2 Jul 2026 06:44:21 +0200
Message-ID: <20260702044425.846351-4-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
References: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 04:45:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4356

This lists missing option --workdir to usage string for 'wic create'.

As reported by CLI:

	$ wic create
	usage: wic create [-h] [-o OUTDIR] [-w WORKDIR] [-e IMAGE_NAME] [-r ROOTFS_DIR] [-b BOOTIMG_DIR] [-k KERNEL_DIR] [-n NATIVE_SYSROOT] [-s] [-f] [-c {gzip,bzip2,xz}] [-m] [--no-fsta
	                  wks_file
	wic create: error: the following arguments are required: wks_file

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/help.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/wic/help.py b/src/wic/help.py
index ee5697f..b213e32 100644
--- a/src/wic/help.py
+++ b/src/wic/help.py
@@ -120,6 +120,7 @@ wic_create_usage = """
             [-r, --rootfs-dir] [-b, --bootimg-dir]
             [-k, --kernel-dir] [-n, --native-sysroot] [--sector-size <bytes>] [-f, --build-rootfs]
             [-c, --compress-with] [-m, --bmap] [--no-fstab-update]
+            [-w, --workdir]
 
  This command creates an OpenEmbedded image based on the 'OE kickstart
  commands' found in the <wks file>.
@@ -141,6 +142,7 @@ SYNOPSIS
         [-r, --rootfs-dir] [-b, --bootimg-dir]
         [-k, --kernel-dir] [-n, --native-sysroot] [--sector-size <bytes>] [-f, --build-rootfs]
         [-c, --compress-with] [-m, --bmap] [--no-fstab-update]
+        [-w, --workdir]
 
 DESCRIPTION
     This command creates an OpenEmbedded image based on the 'OE
-- 
2.43.0


