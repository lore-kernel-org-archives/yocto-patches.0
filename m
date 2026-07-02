Return-Path: <gael.portay+rtone@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56B5C43327
	for <webhook@archiver.kernel.org>; Thu,  2 Jul 2026 04:45:39 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.62377.1782967535873837545
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 21:45:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HCZlKlkQ;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: gael.portay+rtone@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46f88060e8dso205561f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 21:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782967534; x=1783572334; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T8F+TXev7j7zGeJGtTyRbE+PSRDECIxTHcRQPSQN7z8=;
        b=HCZlKlkQb5AIC+RVLZpMCstG7bgqa9Tr9zYk6alj8wbxKYQory7jTx9U/naNviCXUr
         4RHnLLKUyJTcsxbnjgtjkiXeVSfCY48I8z/1i5QMmPfMiENtz8RgsEQC7csmLlQwLS8v
         nadUAZSZo6WFN+tNklB52rsvgMMIsuAKZ6dKcFZEE4O5RFEK3O1nXQHoxmUF/QqkjODr
         oeRiE/wsrGlQWP64Xs/uFTJeUr7VHZEsrrF5CqWrKPY3k78OEQjpwfsqu7JVaAOUVZWn
         g8fqdjlyZOksaocgoKbs2flZrEv/iGJY2UorXQpISy6fWIVtHghuAbc5h6Q7TYP8fMje
         7c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967534; x=1783572334;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8F+TXev7j7zGeJGtTyRbE+PSRDECIxTHcRQPSQN7z8=;
        b=eFtnhkNN9+ze3uKggoHGXtM6cTTK2xPeuwm/YN6Y3HRPIFzt/aAGuiOLoj/ldzs/Y6
         kW2zKt4XKZUYnol/sb16fmQ7Y33W+cTUBkuTb7Zl2RF2y4qeBNbmSPopZCdHNZHsJ+MX
         pOgpmMIrwQ/6tstbw1P4hcYJpKUQSuBhxRJ+fdldepMaR+Tv/tP+VBSLdLoF5NJp9LUM
         HcGydpg9WYriIkGtNbtqWV5wGe5GyCFpup2UihXcm9PbiVyJMHuI31L9UMAVO/9FXWIN
         7BS3NE8Avg1M0UPBFnEDZ3I1XdNiRs6M1AkW6nrucox2Bkwja+8WrisTBHqOoIICSTSG
         4Y/A==
X-Gm-Message-State: AOJu0Yz66jRACJZmQCAWARBYLiksy3NbQnS6Eh7Glv1h+h/pzKkt3FgF
	Y31CqVByJhqVIxdIEXrbzK3JxEsGd9plISfSwSV/js/ZeYXm0ciohPwLcFBLR0Gx
X-Gm-Gg: AfdE7clRexBr9OwcskPstaN9v8+zqGpRMLWn+OjgeJ8muiq9jqupVFzWn2sBEDHd9JF
	ubaWKRMdW09AtnA/kPDe2Kb76Zg1RdbsxrKl1TCXjHc75pcUW4Yg5+BDLY1QpWMD56jMoyLSFzV
	EJnuot9HtINVNySJvkPoyuyHuNcRP41zUrMTa1bj49IjKOH4K/+6apy7w2fyo4WyoPbn/snG0em
	xVx90OUif5djgXo1Xdhwi9q7HThs3kzjTGC8FglDZPXrDxrASxh16vTba8BTdx8WgAbvv53DVU+
	M4RFwJPi7rULbGE4tRbxu18VTaH50kZboB8KScdKHlxj4i7dJKYFy7IzzbxVbLAlieghL/Wqcnv
	62+8MQQ1mJ49yjzVoWlYLsMtZy4FFqOW7NXjtSrtm7NCkmiA0p6VSH+FgACLuQ4Wo4TyXQQ2sWu
	Rny1cX2nI6wk1gPCRG2b/sBYbhC6feFJtTNJmEoKrw3hvbltlo5nnXxNvs5Q==
X-Received: by 2002:a05:600c:c046:b0:492:5bc8:5e6a with SMTP id 5b1f17b1804b1-493c2b7f331mr27207185e9.3.1782967534057;
        Wed, 01 Jul 2026 21:45:34 -0700 (PDT)
Received: from chipmunk-161.. ([2a01:e0a:ce:f2f0:8a40:d7a5:890a:fa7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm15405275e9.6.2026.07.01.21.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 21:45:33 -0700 (PDT)
Sender: =?UTF-8?B?R2HDq2wgUE9SVEFZ?= <gael.portay@gmail.com>
From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	=?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay+rtone@gmail.com>
Subject: [PATCH 4/6] wic/help: Use comma to list short and long options
Date: Thu,  2 Jul 2026 06:44:22 +0200
Message-ID: <20260702044425.846351-5-gael.portay+rtone@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
References: <20260702044425.846351-1-gael.portay+rtone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Jul 2026 04:45:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4357

Usage and help strings lists short option + comma + long option for
every options at the exception of --outdir and --image-name.

This replaces the vertical bar by comma for consistency.

Signed-off-by: Gaël PORTAY <gael.portay+rtone@gmail.com>
---
 src/wic/help.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/wic/help.py b/src/wic/help.py
index b213e32..cbdf529 100644
--- a/src/wic/help.py
+++ b/src/wic/help.py
@@ -115,8 +115,8 @@ wic_create_usage = """
 
  Create a new OpenEmbedded image
 
- usage: wic create <wks file or image name> [-o <DIRNAME> | --outdir <DIRNAME>]
-            [-e | --image-name] [-s, --skip-build-check] [-D, --debug]
+ usage: wic create <wks file or image name> [-o, --outdir <DIRNAME>]
+            [-e, --image-name] [-s, --skip-build-check] [-D, --debug]
             [-r, --rootfs-dir] [-b, --bootimg-dir]
             [-k, --kernel-dir] [-n, --native-sysroot] [--sector-size <bytes>] [-f, --build-rootfs]
             [-c, --compress-with] [-m, --bmap] [--no-fstab-update]
@@ -137,8 +137,8 @@ NAME
     wic create - Create a new OpenEmbedded image
 
 SYNOPSIS
-    wic create <wks file or image name> [-o <DIRNAME> | --outdir <DIRNAME>]
-        [-e | --image-name] [-s, --skip-build-check] [-D, --debug]
+    wic create <wks file or image name> [-o, --outdir <DIRNAME>]
+        [-e, --image-name] [-s, --skip-build-check] [-D, --debug]
         [-r, --rootfs-dir] [-b, --bootimg-dir]
         [-k, --kernel-dir] [-n, --native-sysroot] [--sector-size <bytes>] [-f, --build-rootfs]
         [-c, --compress-with] [-m, --bmap] [--no-fstab-update]
-- 
2.43.0


