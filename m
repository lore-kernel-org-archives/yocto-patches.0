Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3F110F3DE1
	for <webhook@archiver.kernel.org>; Sat, 28 Mar 2026 10:02:50 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8213.1774692163791829384
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Mar 2026 03:02:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=i8RHn/gT;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=m73j0v9Z;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 028FF1400173;
	Sat, 28 Mar 2026 06:02:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 28 Mar 2026 06:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774692162;
	 x=1774778562; bh=LZw555W8XHJME+9W9O69U7Bdc4owVTcTKTJI41bS5Gk=; b=
	i8RHn/gTjbZ8s19jt1gGPIP28Mn/21WeJ9Gq4VKAU522OMiMjA1KjXPlW72SFr9L
	PVLCqImyHaaivMrkVDWhwV9ISt+8bUcfxBsm2AAnhk0jJUfCbEfADLoc317feRxq
	McUmdvtTfKiinv4IYovsNWvBaTL1pORI0+3qb01aP9TZJkZ1PKj/J6TTs8+1Hbnd
	MI6n6OQNQjdJLQSoaG1vIESB9mk0pGK+MLNsS39UvnUn8CAy3DxK0gez2jOB9aH/
	vP1slK1oPLtVoBEVxarTl6XlzGqIkXQKpnJHSXj5pF33oFyItgZROaEDc+tYe9ZM
	zen7t/4wPPnJtQtR6Jd6jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774692162; x=
	1774778562; bh=LZw555W8XHJME+9W9O69U7Bdc4owVTcTKTJI41bS5Gk=; b=m
	73j0v9ZJkyyYdUwJ70Es9bjkOJwkFxFMKDo2Jrc2VxMMD2Iv3tv35xK+i3U9za4e
	XCg+iYs3HMQ88DdlEw/jIrzbC3gbXp8Hd8HnOlMsvGVedDmfH6CBfTYyxW5bh0SL
	JdDOGhlCT7YJNCzXTgV6TwqgstY32dIxSkpYFr6Ic5EolN6Mq4EgJJr/0TTw735h
	OPROfCa4OSGdgkwx+9K7e0l8ubuA+3+ia+3sN2zd5mr7E9UJv/3iN497dTGmG/cc
	0TQLglFp+EoJXdha7hvkdsRik3TKmPe7pbYQdy5kW/IRwyGyxxl/rc1b/9ZMhvOX
	7LxTgyHw5ZvgYM1WzAyBQ==
X-ME-Sender: <xms:QqfHaQSlmoJ09Wz6AG2JIviDSqmS-wb4wCTd8_mUg6Ze7iCmCjxzeQ>
    <xme:QqfHaTx6XfzOY7sBPsBN9HN4hAxtXbXMO4plOxJs76wyOgZ-S5vyK48kGYs2cFNAk
    GSJJWRm4i8uVB6gxIHFWXlxO0VrkA_b3THc1a1t0oOYYTAHGqgBcmk>
X-ME-Received: <xmr:QqfHabfpN1vHytBD0_fVRYRryKrW_8SRRgUVyIyV-ndWcdGk5cPxKY35TkXyJ2-p-l_HtJFFtTJsl77g3jMWCKpQ5yAu_jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgv
    rhdruggvvheqnecuggftrfgrthhtvghrnheptdffvdffjeevhfelieegudfgieefleefue
    efffelvdehfeeviedtieeukefhleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihohgtthhoqdhprght
    tghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhope
    hprghulhesphgsrghrkhgvrhdruggvvh
X-ME-Proxy: <xmx:QqfHafI1V2H0etWmRSESkuwxUDVxr46sIPHy-33mW24cdWUttlKqQQ>
    <xmx:QqfHacHhd01V0fmui2FE8jVFu7j6IqAimz8blB4iVy9egKouRb0-pw>
    <xmx:QqfHaZpwYsrpmvgG79KP4XI9SBYucRpvb4trHA9QDtqTxGMICpDwNA>
    <xmx:QqfHaVQAodJSlIzgMjoG_Mul6bB4C_AS8QVVwcYD1gDY_iBky-1aKg>
    <xmx:QqfHaY0ez9HXT3h5x_0t3V92Y_4AYKtRAbfl-fkCa1paYeATCklglelN>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 06:02:42 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Sat, 28 Mar 2026 10:02:24 +0000
Subject: [PATCH yocto-autobuilder-helper 1/2] config.json: check-layer: Fix
 testing of core layers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-checklayer-v1-1-36bb1873751b@pbarker.dev>
References: <20260328-checklayer-v1-0-36bb1873751b@pbarker.dev>
In-Reply-To: <20260328-checklayer-v1-0-36bb1873751b@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=w1joqYqbTTIDj6jR5BZS72kOtuHe3DLd5kmXUsJ8LCw=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWQeX+4YMIPjyOVfTz5NmZbPGbznz61X8cceXEuRqvtx0
 IjLcuMCn45SFgYxLgZZMUWWzT1f7z/tdeTNCLmlADOHlQlkCAMXpwBMZGE2I8N7RsbIlxsau3kS
 X6p+X7ZVgvnQB6X/IgF/k6bzOoXaJFxn+O/VWLdkW5+M2dsr3WJ1777u8DkXeKXnYVbpvo29nkb
 mViwA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 10:02:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3571

We need to ensure that meta-poky and meta-yocto-bsp are not in BBLAYERS
when we try to run yocto-check-layer against them. We can also now run
yocto-check-layer against the core meta layer.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 config.json | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index 0902e8620b0d..c778d26f5b84 100644
--- a/config.json
+++ b/config.json
@@ -1303,12 +1303,18 @@
             "NEEDREPOS" : ["bitbake", "meta-mingw"],
             "DISTRO" : "nodistro",
             "step1" : {
-                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-poky"]
+                "EXTRACMDS" : [
+                    "bitbake-layers remove-layer meta-poky meta-yocto-bsp",
+                    "yocto-check-layer ../layers/openembedded-core/meta"
+                ]
             },
             "step2" : {
-                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-yocto-bsp"]
+                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-poky"]
             },
             "step3" : {
+                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-yocto-bsp"]
+            },
+            "step4" : {
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-mingw"]
             }
         },

-- 
2.43.0


