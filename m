Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44755CD8C9F
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 10:48:16 +0000 (UTC)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51643.1780915687590043922
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Jun 2026 03:48:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=GHbnyw/1;
 spf=pass (domain: 0leil.net, ip: 45.157.188.9, mailfrom: foss+yocto@0leil.net)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gYpfY6KF2zk40;
	Mon,  8 Jun 2026 12:48:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1780915685;
	bh=d+3bcSrEYgRKiGK5u69QVzRI1hMfOFztexlrs8kdstc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GHbnyw/15WLSNJ0jMVTOSawL7fkt5KNuZLlEHlh4el5tHxHHMgIC8ZOhx1Re2M7u8
	 h+59vdDK0/2NHv7jxLXfwm7UUfvMAc4GY1U14/Ii9lMRIoCj7qwJ9o7vU+AsromvIx
	 EJsnDeoBY93QwdnDt9F+ig8Wyo2Qhz7ODs4BBhfjfNJZNlUE9+Sjtk7AgVNm67nFxN
	 BiVhl21XG196tjVCUgvbl+ey0yx9mf3+R+h7yUcRv0KZJHvjx2F99Nkrvoi6s2Sbre
	 hoBfPqGpO8LEnB8ABGJipp0+qkK8lDsHr/Kr+fHUr4cg7foH4Ui4+Q2UYhIWl4PMgM
	 +ySKkew/7o88g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gYpfY209NzXkj;
	Mon,  8 Jun 2026 12:48:05 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Date: Mon, 08 Jun 2026 12:47:59 +0200
Subject: [PATCH wic 2/2] README.md: add Trevor (the maintainer)'s mail as
 Cc recipients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-to-cc-v1-2-a1e3e7462875@cherry.de>
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4176

From: Quentin Schulz <quentin.schulz@cherry.de>

The instructions now match with the .b4-config file.

Suggested-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 README.md | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 0066ae4..3259019 100644
--- a/README.md
+++ b/README.md
@@ -57,9 +57,13 @@ When sending patches, please make sure the email subject line includes
 "[wic][PATCH]" and follow The Yocto Project community's patch submission
 guidelines.
 
+The patches should be sent with the mailing list (yocto-patches@lists.yoctoproject.org)
+in the To: recipients and the maintainer address (twoerner@gmail.com) in Cc:
+recipients.
+
 When generating the patches manually, this will generate what's expected:
 
-   git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --subject-prefix='wic][PATCH'
+   git send-email -M -1 --to yocto-patches@lists.yoctoproject.org --cc twoerner@gmail.com --subject-prefix='wic][PATCH'
 
 Nothing, except running `b4 send` to actually send the patches, needs to be done
 when using [b4](https://b4.docs.kernel.org/).

-- 
2.54.0


