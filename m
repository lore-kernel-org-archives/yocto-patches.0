Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD9CA0FF2
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 14:03:02 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
 by mx.groups.io with SMTP id smtpd.web11.13366.1756908181594311519
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Sep 2025 07:03:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BrauyI0t;
 spf=pass (domain: gmail.com, ip: 209.85.219.180, mailfrom: twoerner@gmail.com)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e989adfefeaso5062557276.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 03 Sep 2025 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908180; x=1757512980; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1BYrbdG6ZmTJogsRV4pA4SFYdu78Xqlw9aaws7CvihY=;
        b=BrauyI0t6uFmQXqyZqZk2rVoOEfofFpCtve0LiyccsD9DTxSLtZq+a9SvSMGdx+mK+
         aCLbhvkymKTgjEeceY+AhgJPq+xT+AJ33NXvOTSskJFY2Vrtt9mKsuX7W/Kem9f70EWe
         b1G/3dAAzC3Tocx1Mdk8C1a/elAVumFnvrVvNMju0HWiGEpP01hic8hGC2fHAnFyLjfS
         Y8KpI97GEjVYkv7S2KCpA6F1BV/SglWZQ6Mg5sQyfAS9+QoSu53GFMcTdwq0lMtyhIfM
         M7UX8IscCE5IfcDz8ntZZSVhcr8oxQvllPhHNFc/Yr5v8rVJjZfr5dM9IXSLk7/4LZLA
         Q3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908180; x=1757512980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BYrbdG6ZmTJogsRV4pA4SFYdu78Xqlw9aaws7CvihY=;
        b=J9jJqpwf67mNA7o7DWKGzXhZ0a2rohRWC+DzgNjLD7cOis69ULfsucZ+1XvKxLDtf2
         Q9vLBgeT23sAJDzW6XkvMalC7dviBk7EBxG7yKf9l1Nkx2nAyBHGSQOwZt8SR5zN8A+k
         Wxzkz5EljT/YqdOrLDivD0Le1iAcVDkd7Y1NGVwpElGkVuHRmL6Vmo/7zBM2fSkFQaW4
         AgK7lBsD5/g9lm/PoTkwexhsGWT/reRpw30ZMtIbGyWi4s9RhPFPmmG8pASgoY6/14Ir
         bzfA9nwkj0eTx4nDXOwfRLAInegfskqGf8IH0eSgfMENexAH0s6FLVmbOlf2CT2/C5+9
         0nLg==
X-Gm-Message-State: AOJu0Yz29GePYva/AOcVaJd3lsagXCAcnp1BoGSL/PHwVoZPHEymP/i1
	Mrnrp/SLp1Eg9gg5LbQmVAJGVK2O/dAqjsiWHGxbtzdgaoaUN1tnw6e5N+C6Iw==
X-Gm-Gg: ASbGncv/mBSP6HWY494Obr1JrSnHtLykutDZD27SNd4SPEio6tSPIu3+2INrMYROKIF
	WpVRHfYHjvE11tk8gpwz0/+rZYi7u6lPzXRybVKHi2V6CZiu8UBA70zr0XnI1iZfsgHrXqomTjD
	TdVjTFOgb2c6RfBVqX2SGrdBbKOBPQQA5H2628l6AK8XZ/FbsGBq/FYeHe5vbYhlCD0MSSorcWp
	Ndt2N8UZ8pUodNH8M0hwAJ3VEk5zsSEnDV2Gnq8Zw1dvliBchytOzFdkS89/Z/hPyJxmURN6FAd
	6pJ+szvNfHCOObLN914wzyP2TluVAfpB91ktujkgENFSY2BG1AHNXLpI2ymLWQsqC6MdW1HJchh
	/LI4yzFEzha7aw6GZrmx7vGE+q2m0CmXs9B0NyfLINyda8a/ZU3EwhtaEwu+zO8eZ5+Ti2odorX
	Qo
X-Google-Smtp-Source: AGHT+IFBcsKxRfSIsM4cKxDupiT0iMsQldTdAuV9i43JfzGRGmWZbbVdsdFhRuXs18pgW6TpBBB9YA==
X-Received: by 2002:a05:6902:1021:b0:e96:f4d2:ee16 with SMTP id 3f1490d57ef6-e98a583b506mr16474400276.42.1756908179608;
        Wed, 03 Sep 2025 07:02:59 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-725dda254d4sm7397936d6.8.2025.09.03.07.02.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:02:58 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH] xf86-input-mouse: drop
Date: Wed,  3 Sep 2025 10:02:51 -0400
Message-ID: <20250903140251.39966-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Sep 2025 14:03:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2120

oe-core has dropped this recipe, therefore drop it here too.

Link: oe-core: 7c86172b7353 ("xf86-input-vmmouse, xf86-input-mouse: drop recipes")
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 conf/machine/include/rockchip-defaults.inc | 1 -
 1 file changed, 1 deletion(-)

diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
index e52a6869fad0..9a5cf3a4cdc7 100644
--- a/conf/machine/include/rockchip-defaults.inc
+++ b/conf/machine/include/rockchip-defaults.inc
@@ -22,7 +22,6 @@ XSERVER = " \
 	xserver-xorg-module-exa \
 	xf86-video-modesetting \
 	xf86-input-evdev \
-	xf86-input-mouse \
 	"
 
 # misc
-- 
2.44.0.501.g19981daefd7c


