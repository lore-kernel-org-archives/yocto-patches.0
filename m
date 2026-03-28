Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA1E10F3DE3
	for <webhook@archiver.kernel.org>; Sat, 28 Mar 2026 10:02:50 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8214.1774692164400425594
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Mar 2026 03:02:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=xruTBn0e;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=Xwow5pqJ;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB8D0140017C;
	Sat, 28 Mar 2026 06:02:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 28 Mar 2026 06:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774692163;
	 x=1774778563; bh=KUiTY1yfymlqKUWIeoYGxT+ve3/JLr4JgU6tjdCRi+A=; b=
	xruTBn0eIOYDLsd/GUF9O5zrCoEldCLUcG4Z0iyICZhhywx7rFRM/1nPdvN0kwj6
	6jADq1YcTOg5CKjA+zRRgdwqP6J1UYAIOkb+yjGwdrZoqq5K6OeVbf7XF4DEQEz1
	C72gWYQ02nkDyavW4KgflO/0PZpVVoJmAVKCddcUAulhaxHKY/8Fi6f/8kg7NfWm
	/cYmOnQ3TM6U/Kz8THpj3aj3ek77gzqYrsVwmYtXJgbBf43KgWPQmS1x/A5JfwI8
	z5f/V7Dptgo4dB+Nv3DKQv90wJEgLQOHSPQ0ENrm9rneti0F84JsLH6c3n3EJVyt
	qyFFnmV3I7LGcwrr4p27IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774692163; x=
	1774778563; bh=KUiTY1yfymlqKUWIeoYGxT+ve3/JLr4JgU6tjdCRi+A=; b=X
	wow5pqJucy/7H6bRTKEt90PbZ2ubc6WQCTm28d48YCQwgH5EpanAJH8VKw8+CmJN
	i9owywYJWv/fgd+z+pqo1v3/ykOb4L27IgELJjyt/XtzrEeGZhL3su4p970duHug
	vcFtkdj7Q/U8kZqhHPQEIVAh+8eHXpQwpBkJKGU5hqBYUgVeDid79Q9dGu8L/YHS
	ChZ41DrX+cUT9NpRUU9Wumrqx7nlQfEQBk38POXV7NDMmetiQA31RBOMs6LyEewM
	PBF1QeR0LdSV4HNx3PzrVJFtXWEDHyDnE+bsGY3uMmqaDJPESXaC6QgRZjtBUHdN
	aMi9VY7o3HRkvnesKHakA==
X-ME-Sender: <xms:Q6fHaZMA-5KXtJq2eXALk9ifI3DdBue2G6Y9MjvNDET-j1kKZ3ML6g>
    <xme:Q6fHaR_wevFrwG49OHJV7fF-UDwJtHglG9orl8TjRqqaoNOWHjBAyEe7-XSMbUn4j
    FWw_nWFIDMZxySab4_5w7cp2t3VY-vY3biMkrv3ZkayxKYznFLoC_M>
X-ME-Received: <xmr:Q6fHaV4N8bcKjrlLQcA72mj9jYkN_0qHB3DQ-jyDqLh5EUUk51Aj3Uo8ofQzcX5l2JxWNnxi-Iw2r0GeI8vt0ilEy1KBrrg>
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
X-ME-Proxy: <xmx:Q6fHaQ1uJ-IOY9vofKGLQMuea0VatURjZTcjQdQ9wNMGNt91mN7N7Q>
    <xmx:Q6fHaUAHbFtwXNU5yHXWlZOqbkb8pQSmILGAA9UjBE7IiFYk-d4uhw>
    <xmx:Q6fHaa2BGshl4WL0sfnJ2k63xCxaR1dCWwxP1o5OfxYN1FdTw2Kwkw>
    <xmx:Q6fHaWtX23Cch7yzvHVbsWqFFyRVeh6eWH3MzxQAo7Pu8MdwpSv9AQ>
    <xmx:Q6fHaYzvVtk_U35JU6Hej3eq8rpkIuQg0wGi7nKKqqbTkTRgNg_B2kHg>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 06:02:43 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Sat, 28 Mar 2026 10:02:25 +0000
Subject: [PATCH yocto-autobuilder-helper 2/2] config.json: check-layer:
 Test with supported machines from core layers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-checklayer-v1-2-36bb1873751b@pbarker.dev>
References: <20260328-checklayer-v1-0-36bb1873751b@pbarker.dev>
In-Reply-To: <20260328-checklayer-v1-0-36bb1873751b@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=2VlkK6umkPsZ+sYkIMlCF/Bu2CnlD3Zp9m9UJrQa7LE=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWQeX+54pHVmomR3xrdLnZk7u1k0f12OCLnw7DKT64fSk
 niGxbMPdZSyMIhxMciKKbJs7vl6/2mvI29GyC0FmDmsTCBDGLg4BWAi1hWMDN83b1YM6+Ph5o7x
 Ktk71exKyk1R5V2bL3jxRC94yarO+42R4VCm5txb5Xd+sWe5ZzewiIqoGZ8UD2BYcC+kePpLKW9
 3JgA=
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 10:02:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3572

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 config.json | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/config.json b/config.json
index c778d26f5b84..31cf783a60ae 100644
--- a/config.json
+++ b/config.json
@@ -1302,17 +1302,19 @@
         "check-layer" : {
             "NEEDREPOS" : ["bitbake", "meta-mingw"],
             "DISTRO" : "nodistro",
+            "MACHINE" : "unset",
+            "extravars" : ["MACHINE ?= 'qemux86-64'"],
             "step1" : {
                 "EXTRACMDS" : [
                     "bitbake-layers remove-layer meta-poky meta-yocto-bsp",
-                    "yocto-check-layer ../layers/openembedded-core/meta"
+                    "yocto-check-layer ../layers/openembedded-core/meta --machines qemuarm qemuarm64 qemuarmv5 qemuloongarch64 qemumips qemumips64 qemuppc qemuppc64 qemuriscv32 qemuriscv64 qemux86-64 qemux86"
                 ]
             },
             "step2" : {
                 "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-poky"]
             },
             "step3" : {
-                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-yocto-bsp"]
+                "EXTRACMDS" : ["yocto-check-layer ../layers/meta-yocto/meta-yocto-bsp --machines beaglebone-yocto genericarm64 genericx86-64 genericx86"]
             },
             "step4" : {
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-mingw"]

-- 
2.43.0


