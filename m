Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1D2C98315
	for <webhook@archiver.kernel.org>; Sun, 18 Jan 2026 22:56:46 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24569.1768777003432735074
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Jan 2026 14:56:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=BjV8X/ZS;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so23787095e9.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Jan 2026 14:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1768777002; x=1769381802; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=su7bbLE76G42eQmFWgcK8Xlnw9rgMW7tDX3f3FXTrNs=;
        b=BjV8X/ZSulER1V0SewuFXh+XHkb/JwqXVCAOFPjz4K1DUjZUfJUXwlqGkq292EaboT
         41vVJnRRpUeLyF/4DWZfV8V9jYfBvin00hB70sPHXuDsCLLMR5MeGJSj9TdqV+xyY6m7
         FTxMQS9pV2yaR5bREsva6Fdvq2mLt8kPX3EqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768777002; x=1769381802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su7bbLE76G42eQmFWgcK8Xlnw9rgMW7tDX3f3FXTrNs=;
        b=TFT+BUHbSejN1Q6V8Huw4oh8tQl1o/v/L9vtg4FLFaQfeQWFrBa8Cax5HRfUjsp2Ey
         UuOuS7eZFtZku46s3upepU2oVRabczEByAzYGF0CEr3BGd8iyz/O0V8N6LyL2fVOchj9
         Fb4zxPETPNthW5CRgvV7UAQ/KQnStcw5NlmNbdUoB1WUq0HdGUCKRjWx4QXNyTvoj5ju
         WXrR2CQJkMsHxLcaoN01KwWFuPfIne9QS9BxjrdJttOOQoPTXjRbmOG1Y6KTcm0Du3WP
         GVaU7rAIwhyB6IIWythzfI/HlGwu59u1KoVzeDJ4s7gHrUqG6JV7nhQuHZfqY/eDkwum
         lOWg==
X-Gm-Message-State: AOJu0YwYQ9sn/werqpRX0Zzd50/BZ6jYVQ0ttow3f+kF239g65eXEElu
	RyC17dkWJRKvjxwiy7I0OTcQqwgaC9M5jUGUABoD2DKVULbuW/ld1joNnOi+movhXwxm0a5Xmey
	sDqNxP0A=
X-Gm-Gg: AY/fxX5z4OR8nvDE94pSHNCb/v6piw6WT5Ank79D6Zb0OcNl/6VSs/R+pujYTGb7rMW
	wjXNc8PznMQXtMsAET5qhWPnQhH5e2tEPBwpD8iAYO2/OX92GQ8JO4JL9sh649TTjOxwmhDT9iE
	BaMHN4Z/rHcOSuRdwI8yQWMc421EPfIxU46ICixve8p6UwtJ8jLAbkVEnv2e6nVtLx0s/hkKZB4
	ntMVN+KWp+Ny8a+GesciSaH56VuxwSjeYOujACxm522Wa0pqupkxRio04qQdUb76nC9drYe7Czt
	HO+xk91fhMLVKulfFyAfyrJvgVj7+ItTfHJ5oK3wI+9JwyVyMTz00y/AmyaqQbCbGHYbJTpRdUo
	uAo9rxUQgze6tS6VgFFoibJ26/nsyx8mxXjb0lV8oh1U7TVVddKtOxczD0i8Vsyz/05j9k2UetQ
	b+o5uot5Tl7+PyMLB2wpxErtHazWX1m6auumRw5zp/i1nTa6IzCVUJKKe5SLVKKMc04CN7SGQkP
	ku6arXIJVWwqnOs
X-Received: by 2002:a05:600c:548d:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-4801e2a4c3bmr119989255e9.0.1768777001646;
        Sun, 18 Jan 2026 14:56:41 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00d7d0f271c59dc868.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:d7d0:f271:c59d:c868])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9fb193sm68142135e9.6.2026.01.18.14.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 14:56:41 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH] schedulers: add whinlatter branch default for meta-arm/meta-virtualization
Date: Sun, 18 Jan 2026 23:56:20 +0100
Message-ID: <20260118225619.1910046-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Jan 2026 22:56:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3005

From: Yoann Congal <yoann.congal@smile.fr>

meta-arm's master does not build with whinlatter[0].
meta-virtualization has not diff master/whinlatter now will at some
point.
Switch both to whinlatter by default in the branch selector.

[0]: https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3080

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 schedulers.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/schedulers.py b/schedulers.py
index 0fa6d2d..34dbfcc 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -75,12 +75,14 @@ branchdefaults = {
         'branch': 'whinlatter',
         'branch_poky': 'master',
         'branch_bitbake': '2.16',
+        'branch_meta-arm': 'whinlatter',
         'branch_meta-gplv2': 'master',
         'branch_meta-mingw': 'whinlatter',
         'branch_meta-openembedded': 'whinlatter',
         'branch_meta-yocto': 'whinlatter',
         'branch_yocto-docs': 'whinlatter',
         'branch_oecore': 'whinlatter',
+        'branch_meta-virtualization': 'whinlatter',
     },
     'whinlatter-next': {
         'reason': 'Stable maintenance - whinlatter-next',

