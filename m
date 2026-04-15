Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D3AF428DA
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 20:19:51 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4553.1776284390705975404
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Apr 2026 13:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eH47dIUv;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50da9a7928cso59193951cf.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1776284389; x=1776889189; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n42Pm9HXSilayI0BBx+UdA1zswjNZVrjfKavR/wDRm8=;
        b=eH47dIUvgOS9Sfhs2cDRq1VxjukcEprDlMW74ebIBeWxtbZxHmOIWuxdbiefdRHCoS
         uvkONwwXD9SRv6USbjjBhN908G2+5/GXVJ0wzwXAeNEO/JLzykEmHmCaWsvAxrAXFIK1
         nk2/ehV6uNQmEWnZsKScC8x3tyzl5JNbqrTY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776284389; x=1776889189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n42Pm9HXSilayI0BBx+UdA1zswjNZVrjfKavR/wDRm8=;
        b=N81AH7cTiBZqxKU0DfkyGn1UjRZaFIdhupRGjVKrXMe9Z2vT0ZRiTeRrymw0WVbfEr
         7RTHE1oK+uyydPVxsqjjYxjbnJnZkF/yFpmKQYJNQP6eKESGUoCGidjaXBISVr+rbuCI
         zj6+wEi0j+Y8dCBXB8xBB9i1Tv9O1HsovAftA21in8HBzRPurnTOf5E7QPNdjdvd/nB0
         +tC7e5ZXCWYYLV4SPvuVYLrzxZ5vdnHNW6PAdo2vECNk5uZL7H8DFEXrgNB3SzzD3dLH
         4Hckp+boTQxhDUqLzPp8OmiIfjV5irimPCIor2SJ0+2XQOPAfbC46KkAbBC4dbWoxnYv
         zieQ==
X-Gm-Message-State: AOJu0Yxuh90iJo7ytBYRPZvWX16Bef52jK2loalHfzuMhMkNx2Ce6ySv
	pwPsKe9MZXbB3c16E3BgEk3X9yKy7dumqMfSn0eu2EkR1VGYJ5amehycWKbzmHukWcwtoxLim5r
	/jcHo
X-Gm-Gg: AeBDietF3ZoVoGBTsBWIm8bboW5Xi+K0I3GLjEYQGCqHiHVUtjVoxpAjx1KKWeuFEMh
	Lty5SZ9SksHc6G11ItIGT1oobq2CtEtIQzVBMeA0pC+wfpyIinDoOzID/hE1nBas7jCFkXss5c5
	O6dR+e6k62OTlZGb0uuJ/+BeuhYgyDRrY5bgh+jqGYyLeL9ABGfv0tw0i3AiBOvfm8//aY06790
	2pp9iqJ9bVYk/dEYxjacL8bFKddWx2MCqevobDIJpNc1S1Vr0XT7po5choYyPvI/8UyE+q/Iz7J
	lAx903eK16f9r02damCQID6iQKhUN3tH2UnbVk8x2VaYj/C256+N361sDaXeoQJK05jrIuWZ9QF
	jFMYtmUHKlkHiJT323bpJ5RI7b7IBA2m4+agH9YCJOdunNIrcf4Ikyqdx0cH8ZoWGq//BYJHh12
	vN81dW0lo/TS43cgdUM+qaBDQkNl5X1NRlA/HArRVjztAkkXykCsRqBnItWgZYtG8xeWTfCBQXG
	SHbcY8vqsGa3uK7gRBldKL3L1zVtijoWMhQgqcjorcSQNb2o+YvFf2rtObcY3Bm9uqjLF0d8Zs=
X-Received: by 2002:ac8:5f47:0:b0:509:1766:2f4f with SMTP id d75a77b69052e-50dd5c1c7a5mr343436371cf.54.1776284389470;
        Wed, 15 Apr 2026 13:19:49 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6ceb80f6sm18569376d6.46.2026.04.15.13.19.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 13:19:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 7/7] isic: fix RDEPNEDS typo
Date: Wed, 15 Apr 2026 16:19:27 -0400
Message-ID: <bd6927e1dfc19b2b9619da85e03fb06b6fb6dc03.1776283733.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776283733.git.scott.murray@konsulko.com>
References: <cover.1776283733.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Apr 2026 20:19:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3715

From: Haiqing Bai <haiqing.bai@windriver.com>

Fix typo: RDEPNEDS -> RDEPENDS

Signed-off-by: Haiqing Bai <haiqing.bai@windriver.com>
(fixed RDEPENDS:${PN})
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/isic/isic_0.07.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/isic/isic_0.07.bb b/recipes-security/isic/isic_0.07.bb
index 8e0f5ce..9ebb669 100644
--- a/recipes-security/isic/isic_0.07.bb
+++ b/recipes-security/isic/isic_0.07.bb
@@ -31,4 +31,4 @@ do_configure () {
     oe_runconf
 }
 
-RDEPNEDS += "libnet"
+RDEPENDS:${PN} += "libnet"
-- 
2.53.0


