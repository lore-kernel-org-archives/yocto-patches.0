Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A71C7115B
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 15:04:42 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.21506.1750172681610330688
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Jun 2025 08:04:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=GmT5kSYi;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 161AF44263;
	Tue, 17 Jun 2025 15:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750172680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eNrB5GMuYw5qccQlm1FHMpIzAR0fs741grMNY21/zc=;
	b=GmT5kSYiAg7IxNZ404IMN3d7M81zKm7uVqrI+kX6BUgMK6JF29ZqrE0q61+llSAGZ/ar3t
	QiJhlddjVbBfhLRJz809fKC7Z4liw7zz6phXv5ssCDI9aYa8FWhm25ZhAPXWSpk8ZsYO5o
	Ga0gcHaGq0NzWNRGctmXVpGg6IK7h4+Zq0/HVtUvfSUp7b5RBeliQp9eJGl4H63KAXDNRZ
	8IrWJLOTidYxZRpmMJwt1OObjEBd5mtSkf9pUC/hrB8MfQyFgJo0wRRU4du3h5gUYKsAST
	H7dzfdGPkesUoclMlSvQXOBCnyjZ6ZfLzlKyDKV/m0cTr/DKTOKNYcymV2C8Vw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Jun 2025 17:04:29 +0200
Subject: [PATCH swat-tools 3/4] Add a b4 configuration file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-improvements-v1-3-6125d17583fe@bootlin.com>
References: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
In-Reply-To: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=367;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=EgjnrAKST0PqXYYLQwHoXCXoIAtKTrVre1JVOXELOJk=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoUYQGqFRch15IKBHDENzTJnBzT4FIHpXiLsJKz
 /Y7jEYf4cGJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFGEBgAKCRDRgEFAKaOo
 NtnOD/wLQwDbRfUqlzajB+1j3KzwUjlmJea4X+E8d+O+7yA1WJKjM6poLAAD97dMMGxC/bIVFvN
 ZC7imC9ms9GytBldPJAm8hliI3168bK5FRULAxlHMMPs9UAq7+EbRVEG5wclrOTcfvlNJARGzKk
 JcybCh2IwwY0YkVfBHo6do3Tj9fU04+n/dqaUBQQ1XGJ1XVUtKxCvmhZmuVZZ/mMce/7jgBbCc+
 UGt+ZwhvmG+Y421FY1iMuLCk1il8FwPbg7WS7dsJlr077PZ+E1m/gqiSQ/mlLlYK4tHwEGIU1Lo
 9m3d1sfioQvPKJ9RGKFtL8qlziQukQGaqf0A0mNHs7tS2I5XyDiwmjs9J1EV6yGsGyQja+vjPT2
 6HqWxwX8VPZQs0bR1AkUTaKauwQAFVElpjL6/uEJMqezDxtaIG7v+r4WYjNGvYA4DD6k11hsbdD
 p3z25oaTurpVRLUD0knwC9KgPrZJouKW3lAaUBKYbGTRX8yM5beCk+wuC4WhTbO9kcPStNjBsCG
 /3R2UuHZMlL/LA8PZTM5gjerip+Y6uIXU1eDjGcq0Mi+XQWD0j8FE4ZJz9trGWvKSWtdJcHU+VI
 ZVrLJDTweRGXZSiKLH7JH2ZAiqmzSJFzCz5ingqCVtGb0Axi+6QkwLAha1nosuD55OSm0hfzgH1
 9IWiN4aClohyWGA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheeigeeuhfefgeehfffgueeiteehieelfeehjeektefgkeeuheeuleduvdelgffhnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehli
 hhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Jun 2025 15:04:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1653

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .b4-config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000..5bb51f4
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,3 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  send-prefixes = swat-tools

-- 
2.49.0


