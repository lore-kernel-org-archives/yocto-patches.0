Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCBBCD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:04:15 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44956.1781183053547661578
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jun 2026 06:04:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=JGXTVQl8;
 spf=pass (domain: smile.fr, ip: 209.85.128.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490e1904089so11779795e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183052; x=1781787852; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7eEJDzF610PnTzkBn2OJz0NkWxK1I5RfZNXFv/QdHE=;
        b=JGXTVQl8yEXZi7r9MSYYk4qxMeyv5PskBFrfK9InGxLKC2oi/yDgpv4oUXqleN/VEw
         SOyu5eh5C2Ab9CbbfxnhhMqHvsmnoKEq/eXL8c9D2O0n3V93tMDFIWbjUuISGAQZNy08
         Rf7iirwZtpD9p8BSyP66wxMXI3Ze7kRr7EatQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183052; x=1781787852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w7eEJDzF610PnTzkBn2OJz0NkWxK1I5RfZNXFv/QdHE=;
        b=ArnmRzB+0gNuqwGRlPTIttFoVmrf1cBzNcfPfCZtJRUGvpRSGoZO3GXpyAIUe8dcqV
         x6PhyKGvakTLUjLrA79Fh6Wi4+8t2AvL13p2c1ARqPo88TMo1rswqWTmF0BITJUGxX6b
         rJq20Fmre30rHrDWAkeHeLqIovdF5Xzp45WhuMt2JI9xvro4XKP3EFeXXm0/qz3iunrZ
         1xVqGwhMbgSzdwBYhYy9KFBS+m/hRqM4jr5m2XIPCJjM6Zt6y96hvT1wxqlzJeMLJKjU
         Lw6WG9RwkwP7+7I5n4K97KZs7hrVMFUdJtKaqD0GKC7QOtcajwe9eae75MVkD5JYQY/0
         Kd7Q==
X-Gm-Message-State: AOJu0Yxhrfn2Gi7I0uFwKmXAfJXCTomhJ3jy9H7Dy7X6Rpu/MeJvhQuf
	vbmv/LdbGwIraD2pZ5e6JX2ZBe6TFiUbhJQQBBOVvMsHjV6Az0S7eVHNRtUHnqgu+aEmXJB3o3c
	GqPn1
X-Gm-Gg: Acq92OFc1focrm/Bh857uMbjnq3yQnmhIVy16VsUDLbr5gOZnOkjiPjxp54Ezsp94Y4
	96Dr34Z4CCZwh3+y8ajcc0uK5VOyLzW8jEsAnX/YykptXQDsUC1B6t5wZoNZY3nyxPAsgDivelD
	lFuYQKJPRHGouxRmCbuA7ZCLYdjsm9l6VfhEZqzclzrkejhdGWAuUX5oSo+gk6OqMw5S7CHXWRV
	nWbc4yCVohMXPLibbc1PGJVIXG8lQfGxZXOyTHHWOOl921QoFN5QU0yVLuJeavD+QOeU6dXIHrh
	K0+WM53ML+5UsBa+PWPaxptB7BQ80+5Zccx++riJEnFvLcWHNZHvZGKaVMhYKfrtkwx4SWEg+Gx
	C6pAn2Y94LgiyNI22GgIBbHFZgGNEg94d0xMGPxu4yDqVNYQ27TRvpXMjQmkAOkYSa06c6J0YpS
	kBeqJcPiNrzFBuUMAH956cDzZtAP5DLOdQ4o7kJxQdPz3zeP6XM0coXFTz6/RNjohxiEkQ2OB3X
	IkWS32Mzapma0AixSstCPmlZmr6gJbYpqsQjGY=
X-Received: by 2002:a05:600c:c04b:10b0:490:c2a3:3302 with SMTP id 5b1f17b1804b1-490e561e473mr26472455e9.35.1781183051769;
        Thu, 11 Jun 2026 06:04:11 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e4129daesm34014685e9.0.2026.06.11.06.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:04:11 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [yocto-autobuilder2][PATCH 2/2] config: add Ubuntu 26.04 to scarthgap worker list
Date: Thu, 11 Jun 2026 15:03:38 +0200
Message-ID: <20260611130338.484322-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611130338.484322-1-yoann.congal@smile.fr>
References: <20260611130338.484322-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 13:04:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4215

From: Yoann Congal <yoann.congal@smile.fr>

scarthgap successfully passed the bringup builders on ubuntu2604
workers:
* bringup-fast https://autobuilder.yoctoproject.org/valkyrie/#/builders/97/builds/22
* bringup https://autobuilder.yoctoproject.org/valkyrie/#/builders/96/builds/34
  This one was from the -nut branch but it did not changes during
  merge

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.py b/config.py
index d102c93..63e8b56 100644
--- a/config.py
+++ b/config.py
@@ -205,7 +205,7 @@ workers_prev_releases = {
     "whinlatter" : ("alma8", "alma9", "debian11", "debian12", "debian13", "fedora39", "fedora40", "fedora41", "fedora42", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2204", "ubuntu2404", "ubuntu2504", "ubuntu2510", "perf-"),
     "walnascar" : ("alma8", "alma9", "debian11", "debian12", "fedora39", "fedora40", "fedora41", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream9", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2410", "perf-"),
     "styhead" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "opensuse154", "opensuse155", "opensuse156", "rocky8", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
-    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "fedora41", "opensuse154", "rocky8", "rocky9", "stream8", "stream9", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "perf-"),
+    "scarthgap" : ("alma8", "alma9", "debian11", "debian12", "fedora38", "fedora39", "fedora40", "fedora41", "opensuse154", "rocky8", "rocky9", "stream8", "stream9", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "ubuntu2404", "ubuntu2604", "perf-"),
     "nanbield" : ("alma8", "alma9", "debian11", "debian12", "fedora37", "fedora38", "opensuse153", "opensuse154", "rocky9", "stream8", "ubuntu1804", "ubuntu2004","ubuntu2204", "ubuntu2304", "perf-"),
     "mickledore" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "fedora37", "fedora38", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),
     "langdale" : ("alma8", "alma9", "debian10", "debian11", "fedora35", "fedora36", "opensuse153", "opensuse154", "ubuntu1804", "ubuntu2004","ubuntu2204", "perf-"),

