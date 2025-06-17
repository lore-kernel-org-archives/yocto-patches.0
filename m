Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356EBC71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 15:04:52 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.21507.1750172681867581183
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Jun 2025 08:04:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=NgASZqpR;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A4E644256;
	Tue, 17 Jun 2025 15:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750172680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYfkHrEcpD1x3qJhPASRw/j+1ap6y9QIByhMYdXBTOo=;
	b=NgASZqpRViTYRpZc/24lvynmdAw4W2ZAvtgTCLvWjyk32Qok6xyxbNVbqtZ2/X9wDwLHBL
	CciCye9zVFTZtWophIt8BiyWZA1YC4EpbOJj5A+arrPx6LcAUp96NjeYaSIBPRzOqAILHK
	qm7sOc143n/Nf9DRn5GRZX6mcExDCccYwN/UNf65oBxRuIk1xYjwW00jnNEDc15hFu6Qw2
	pjzj1gAaCIYMsOKpqt+5H87mNMIrl5TQnFYYuMYUUHqbCWpEcb35A/GdkYLvIliTfOypQl
	EbqZFm1QQb5me6fy6jZzj7EhU8dhZR4L/cTKJS2+WchOHGd01s7eyUXu/W+0lg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Jun 2025 17:04:30 +0200
Subject: [PATCH swat-tools 4/4] README: add a contributing section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-improvements-v1-4-6125d17583fe@bootlin.com>
References: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
In-Reply-To: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=q3EFDiK/CcpHPeg2mqJRdn707lE9G5AtVTKNCwENYug=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoUYQGmcqbULG40OG6qOc4i4yj9AgXQBfC9Rj9d
 9DCwMtgM/+JAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFGEBgAKCRDRgEFAKaOo
 Ns1MD/4ozNGjWx85L2bXpcjZtGy1B3C31JVxI3g4y3WaW46Hir7HeoTvKb55nOpMxN0bjy64ni/
 szqJc7/D0OS5hBMD8sZ8wGkb+GPXccy1RfGyUHKjq6yBQ40SQnf8wPcm1utM+xb2t+IjyCAl8kN
 N2F189i2oezfAXJZSQ8yQDu1V4m6/fk8PD7AWifkIkD5GiCdRQPijsQbdFAcv+CnTANDgPxm4gq
 czR5xm1c8JXn+HMRwuCvcdZ+c2gwvOLlpXlebp+6dbyhTvQnOCo88wf01LwIl0MWjlKaXC3XM2k
 t1HCv5T/p37ERzvxAsNuzJysXUFjJaBFAvTtrgRLFgkt9FEEpUxPftThPIFnbwEF/1gLxKNztC4
 xrTL8xEEcszaNpLkN4yq7VYqWDavcULmAsmFH6R1yjrjGiJ5zsoiUwXsT313GScVbSqEzscOBEw
 4dlqE5/Ytx15LnvGjRWkRKQ2mjIB0wG1z1EVdooPPicKyZ42QI3ycxyhL/Q+S2E0Os28SK7lK0y
 NewWYfzrrcgrUEh1wKt0ekzbSTYXrP6K13w9LTYTjh4MbZ5hyyBh9bINvL2xWmNSVFqu2wMIgJH
 kNweUTQrpo2vq7q1WAJNtHLoKVK+oExcWPKctxdxuBaf2tj7Tsdc+fUGpWFYUkkFyLeO28XThPY
 ibnWwIfoQwXqmRg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfevjeffteelvdetueevieeitdegvdekfeelfeduuedvleetgeejueduvdffvdehnecuffhomhgrihhnpehgihhthhhusgdrtghomhdphihotghtohhprhhojhgvtghtrdhorhhgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghru
 gessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Jun 2025 15:04:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1654

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 README.md | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/README.md b/README.md
index a7e6772..102e336 100644
--- a/README.md
+++ b/README.md
@@ -94,3 +94,22 @@ Publish new local triage status to swatbot Django interface.
   additionally importing `readline`. We should either investigate the root cause
   of the issue or get rid of one of the modules.
   <https://github.com/IngoMeyer441/simple-term-menu/issues/98>
+
+# Contributing
+
+Please refer to our contributor guide here: https://docs.yoctoproject.org/contributor-guide/
+for full details on how to submit changes.
+
+As a quick guide, patches should be sent to yocto-patches@lists.yoctoproject.org
+The git command to do that would be:
+
+```
+git send-email -M -1 --subject-prefix='swat-tools][PATCH' --to yocto-patches@lists.yoctoproject.org
+```
+
+The 'To' header and prefix can be set as default for this repository:
+
+```
+git config sendemail.to yocto-patches@lists.yoctoproject.org
+git config format.subjectPrefix 'swat-tools][PATCH'
+```

-- 
2.49.0


