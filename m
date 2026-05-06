Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74581CD3446
	for <webhook@archiver.kernel.org>; Wed,  6 May 2026 16:21:53 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22608.1778084504989347773
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 May 2026 09:21:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RzKTEPIl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44e5624c053so2128956f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778084503; x=1778689303; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/1l2qbUZLSVctx0hjiGNMun4FHDXgWHSfpHr9WS1ywU=;
        b=RzKTEPIlZWmjs5i/N1hgQLK8A9jwsGtCZrdS8/uczHBnG6Xcp6oMOSpKZ3MvYeDGyO
         w/LsXAWsw+Dhk8Gq/oBEWOpM/hxeRvbgTWRYSZIgSiszvA+VselPUqg9MqlE/cn2w5Pz
         vB+uEfxcSb/GC/hDFq9RI/DEShPlbjgRZqodY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084503; x=1778689303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1l2qbUZLSVctx0hjiGNMun4FHDXgWHSfpHr9WS1ywU=;
        b=UkMMuabra3GDPAfVgjp+mbHkUW5cUR7v1+OnjqTvkn8Cbtm5Bs42WRU6zTxeypZwPk
         kOn1R2Bw6BEDEBbzkM7mzxJvdeGA3IaChRBWde/kLa06pkrkz+ymxjC5q4cz+ufqg+Dt
         icV31LNZSuASLvm5jlKcHlDd1FoXnW1moPU+czng/79LCalajULoAH4esb+4+Uyr959S
         hXstzRIqaoQhTzRDaMBAVtmQSB48A0zlXUJSKZgb5CoNLWtpL9smT4+vY71vWWNui7hF
         XNgXCdw55N86CNEBG/6Gv8DpGM37zV8rl8MPfp68xJkHU09ASS/g32Mb67Ha7vHZUM0g
         wIHA==
X-Gm-Message-State: AOJu0Yy/t/k3QfoakqgFTkHuh521K1RoF9lmUi+SZK9x8URDkAj1biQ6
	gRUnLEarUB7lBNztJLAaRdvWJXE7uK/kKmVXpPaNqCFZsDmvqj6kI/843NDzOMGtj7GbTrlV4RL
	04X6J
X-Gm-Gg: AeBDievnEgT21b//tu/4pk7dETh4+lT++YFRUF0UpJd5C3MCfvhjoQfsT4JPToje3M4
	QkpXcQ6WsU3zcEfEIth8E/prIno6+K+ouWhHLwTf/nmvI0deh+yDkGzQ9OMKlVfZpsUoeh83BaU
	cRmq5fUM8jHrDqrQBGVl29OLY9d64D19aMY4v49W28WmKSVIT4tD9EvmZCCupPyxy5K85OyBXEe
	dFopb/7vGBhiDhyps+nZlnW9G/7i0lac9V3AiJpmtmXoKIkSU5LPo2jPPGMHctZdCsOVHWQNwDk
	Xi3NtLpNg9thWvTl6ztKEGOxcDZvziuCxYqx0Q/j8j+25YGsmWWYLvtDJ42b35U6FDz+X+z4nu8
	ZHiuwaI0DTrgpqnhHog0vbie1ayCSiFUt9iF5/40jnnE2hXeG9txBa+fOkTtVSoEPXXNiwNM/Av
	fVKEfiNrFBrZcgBOgfY9y8EolTWX0mtYjVC/p1cGmzqxryYMKTqybQJFF6H3QbgurqwCphrkZWj
	Q==
X-Received: by 2002:a5d:6489:0:b0:452:8286:86bf with SMTP id ffacd0b85a97d-452828686d5mr958405f8f.1.1778084502507;
        Wed, 06 May 2026 09:21:42 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5409:94a2:bd3e:6c21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960811sm14318822f8f.27.2026.05.06.09.21.41
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:21:41 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 1/6] publish-artefacts: Drop ptest images from releases
Date: Wed,  6 May 2026 17:21:32 +0100
Message-ID: <20260506162137.4180049-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 May 2026 16:21:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3922

We are currenty publishing a lot of release artefacts which we suspect nobody ever
uses. Drop the ptest images since there are many of them and they're not something
people would likely use. If needed someone could easily generate what they needed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/publish-artefacts | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
index e4c6661..8881b7f 100755
--- a/scripts/publish-artefacts
+++ b/scripts/publish-artefacts
@@ -59,11 +59,6 @@ case "$target" in
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemuarm64/*qemuarm64* $DEST/machines/qemu/qemuarm64-alt
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemuarm64/*Image* $DEST/machines/qemu/qemuarm64-alt
         ;;
-    "qemuarm64-ptest")
-        mkdir -p $DEST/machines/qemu/qemuarm64
-        sha256sums $TMPDIR/deploy/images/qemuarm64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemuarm64/*qemuarm64* $DEST/machines/qemu/qemuarm64
-        ;;
     "qemuarm")
         mkdir -p $DEST/machines/qemu/qemuarm
         sha256sums $TMPDIR/deploy/images/qemuarm
@@ -138,11 +133,6 @@ case "$target" in
         sha256sums $TMPDIR/deploy/images/qemux86-64
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemux86-64/*qemux86-64* $DEST/machines/qemu/qemux86-64
         ;;
-    "qemux86-64-ptest")
-        mkdir -p $DEST/machines/qemu/qemux86-64
-        sha256sums $TMPDIR/deploy/images/qemux86-64
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemux86-64/*qemux86-64* $DEST/machines/qemu/qemux86-64
-        ;;
     "genericarm64")
         mkdir -p $DEST/machines/genericarm64
         sha256sums $TMPDIR/deploy/images/genericarm64
@@ -181,11 +171,6 @@ case "$target" in
         sha256sums $TMPDIR/deploy/images/qemux86
         cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemux86/*qemux86* $DEST/machines/qemu/qemux86
         ;;
-    "qemux86-ptest")
-        mkdir -p $DEST/machines/qemu/qemux86
-        sha256sums $TMPDIR/deploy/images/qemux86
-        cp -R --no-dereference --preserve=links $TMPDIR/deploy/images/qemux86/*qemux86* $DEST/machines/qemu/qemux86
-        ;;
     "genericx86")
         mkdir -p $DEST/machines/genericx86
         sha256sums $TMPDIR/deploy/images/genericx86

