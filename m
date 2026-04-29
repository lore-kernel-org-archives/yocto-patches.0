Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253BCCCFA13
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 15:40:21 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14504.1777477219213955964
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Apr 2026 08:40:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UC77QHzy;
 spf=pass (domain: konsulko.com, ip: 209.85.222.179, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8ef45a6d9dfso958663585a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1777477218; x=1778082018; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75T3lYJAlUQpJYnN7VsnGFJ0i6+aqa+3G7BCTuTeozw=;
        b=UC77QHzyYRS4Ol4pG2jWqz4XSAeHE1LegsbNT47pRve9UdlE8ehpJtWGARtEU5pLNo
         3cQT8p29ajIaEuHNjwBNLuR6/qLZ77gqgILJMUCw3vabvualBMFV+gymlcIqKxUxn9vP
         Tseqh83MCp2TBH+GP0TdQv8n5iYRIMFcEqRf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477218; x=1778082018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=75T3lYJAlUQpJYnN7VsnGFJ0i6+aqa+3G7BCTuTeozw=;
        b=NnSTfOnsnVYLBRaCmyen9CKS8keFfJzk7DX7h8+kd5oMvSXOHm+fxnTXFTuO5NUw12
         FUbSnIUuKFKTJjXcbTOlMIZ7cCmBrtUqt940W9ONzApf27KyZpPajhA0hjXWftD+MhTG
         j7XAAMpskr4xLWjdxa1xj168ioQqQHn97uBcBYHz1YXIXJpCjY4RayHXW6EHUnatqjqe
         eYEDmc17C3mtFJsTJwLRihD/V/FP0Wqxvbn15cjTgDkfMEJdUBvZuzPKAgflh2ekAxX6
         iQKoYESiSSpggHm+UTFA2ClzO9yYwFPn+ZnbjgEv1wllTzJ+LYkIKUA03DuTVBFsTeDz
         am9Q==
X-Gm-Message-State: AOJu0YyApOFB58CDuoqpiO+nNpvXUoyyaQMECC24tPjPgoV7GNGxGtCm
	dX1lk9QHW7QOh6pnpcwx0PDrMsbyh18MPbkJlsU7ugzoVBf9l+eLxv4mtCpup78fHEyqE+ORu9w
	1vwTi
X-Gm-Gg: AeBDietKT1G3QNvBKRl7rieYzjn+U1Y9c/c+lqrMFpJrMtjz7AqKRq4bk5zovipfAAu
	LPJzxyBxTE/tuSdvwRsdA3x/qKoVzPOTYfBvSb9tAG6miBz+nBgtsyh0lVwwaWEKowyMalAnFPy
	DIP1kmeE0Jdkc9IlI8MAmu1nLWBplccXLeXMPy+OskgW5Wi4TBNTrfqYl60VDEIwrO1+CJb+O2z
	6w0xZhcgyOH9+rG65El2qi/53Lg6GIWxt+gLCqn2KxONKkjnSRXGm30uzmNWIoUaWAtg0cBx77A
	zGtEnLPw4o0Z6HsIkuWeoNC6VekbgLMGWYjXU4b5PuxwgtF2ipy7mu34YBBi7AU5fNkMPje5SDa
	R+0fXrOxwXmU6anSpCQ/3g6PBuJnFGyKcwO7dEudeQOXBJ2xBvpvIPFM6HeSk1QDxlYlTEAB1Na
	tDseVVsam1m9ES9d4LYxl6g3GAspAQH/SLxOtUXAykteuBuxEdEgpI52UbqbhtQbD5e47rGeMwU
	Ce+xfndnSqT6mbtJvDIRjILkeoActFpg9KpAuqq3eRyC68WKnha9r9KoTai14UtZYLwhywTf/0F
	GqO/cB/ysQ==
X-Received: by 2002:a05:620a:17a7:b0:8d7:2745:6462 with SMTP id af79cd13be357-8f7d9207da3mr1092946485a.38.1777477217886;
        Wed, 29 Apr 2026 08:40:17 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f940340f1csm207924185a.44.2026.04.29.08.40.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:40:17 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 10/13] ncrack: Update
Date: Wed, 29 Apr 2026 11:39:40 -0400
Message-ID: <07439815e7ba85123c74440a478e464324c80f95.1777476608.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777476608.git.scott.murray@konsulko.com>
References: <cover.1777476608.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Apr 2026 15:40:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3884

Bump to HEAD of ncrack's master branch to pick up build fixes for
newer gcc's.  PV has been updated to indicate that we are now
building something newer than the 0.7 tagged commit.

License-Update: copyright years refreshed

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/ncrack/ncrack_0.7.bb | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/recipes-security/ncrack/ncrack_0.7.bb b/recipes-security/ncrack/ncrack_0.7.bb
index f389e3c..c0a38ca 100644
--- a/recipes-security/ncrack/ncrack_0.7.bb
+++ b/recipes-security/ncrack/ncrack_0.7.bb
@@ -4,12 +4,14 @@ HOMEPAGE = "https://nmap.org/ncrack"
 SECTION = "security"
 
 LICENSE = "GPL-2.0-only"
-LIC_FILES_CHKSUM = "file://COPYING;beginline=7;endline=12;md5=66938a7e5b4c118eda78271de14874c2"
+LIC_FILES_CHKSUM = "file://COPYING;beginline=7;endline=12;md5=8df67d60bde9d6c7b7030546ab47bf4b"
+
+DEPENDS = "openssl zlib"
 
-SRCREV = "dc570e7e3cec1fb176c0168eaedc723084bd0426"
 SRC_URI = "git://github.com/nmap/ncrack.git;branch=master;protocol=https"
+SRCREV = "7fab46addcb99326cbf60f41dbde22a1e87aebad"
 
-DEPENDS = "openssl zlib"
+PV = "0.7+git"
 
 inherit autotools-brokensep
 
-- 
2.53.0


