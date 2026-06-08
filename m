Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7D0CD8CA7
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 10:48:16 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51735.1780915687246615566
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Jun 2026 03:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=Y/VERZaz;
 spf=pass (domain: 0leil.net, ip: 83.166.143.168, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gYpfY2dH3z6CH
	for <yocto-patches@lists.yoctoproject.org>; Mon,  8 Jun 2026 12:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1780915685;
	bh=hjukqbJOIVKRr8J1F4NwrQetMNT+oyFIh9rV+Rxjxos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y/VERZazoJzWW+R36HUPAJsNfp84ehuqdmcJAcECGAWBQuqSjXV4IZi+vn8lJ0kvC
	 WpF1qFrJ310QnnnCRptXwkCZY1UnyMy4j9kl5Ec27OZTZmY9AOwY8Q4jZIL38wXzZd
	 ht8HwcbofuV/zdbnI024UEqgVvA44A40gclu7wGMOYnLBAoY9ursC/FW0s5Ddamr0m
	 SMj7xOpHF7MVejrCKyvh4Rl3+XiFnsaX7dxCkkuJJdWPftf6Qx6ulMtNZe4G+K1Maq
	 82K9Q/zMUu39g4GI6NtcaZ52J7L51PpqnKShorops0Vk1NHs1dwiQQe5HPRJT39BWm
	 K6dRN9C/+CeoQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gYpfX5V3QzWTF;
	Mon,  8 Jun 2026 12:48:04 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 08 Jun 2026 12:47:58 +0200
Subject: [PATCH wic 1/2] README.md: add example instruction for sending
 patches
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-to-cc-v1-1-a1e3e7462875@cherry.de>
References: <20260608-to-cc-v1-0-a1e3e7462875@cherry.de>
In-Reply-To: <20260608-to-cc-v1-0-a1e3e7462875@cherry.de>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Jun 2026 10:48:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4174

From: Quentin Schulz <quentin.schulz@cherry.de>

Let's actually document how to properly generate patches for wic so the
contributor doesn't have to figure this out on their own.

The git-send-email instruction wasn't tested, I just took it from
meta-perl from meta-openembedded and adapted it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README.md | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/README.md b/README.md
index c6fed66..0066ae4 100644
--- a/README.md
+++ b/README.md
@@ -57,6 +57,13 @@ When sending patches, please make sure the email subject line includes
 "[wic][PATCH]" and follow The Yocto Project community's patch submission
 guidelines.
 
+When generating the patches manually, this will generate what's expected:
+
+   git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix='wic][PATCH'
+
+Nothing, except running `b4 send` to actually send the patches, needs to be done
+when using [b4](https://b4.docs.kernel.org/).
+
 ## Licensing
 
 GPL-2.0-only to match the original OpenEmbedded wic tooling.

-- 
2.54.0


