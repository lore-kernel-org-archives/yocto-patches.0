Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33507C71157
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 15:04:42 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.21504.1750172681205884308
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Jun 2025 08:04:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=YSC7acp2;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 16DBE44250;
	Tue, 17 Jun 2025 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750172679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JnMVUg1q6OzQk6u1AFIJJvQcKffPePagXluXVsPdDGw=;
	b=YSC7acp2QDAysO2MzY5mZbRJJlitszBFqbbQFsHo+uryKt3j8Y7QR4/I/ak16on8VGBZgC
	K8P/BZAKhyOH6SpV2CtGE7YMq58nJ75mtT+fYe2X34h+ff+/jPu5e88XJWvwY6YT/FHJCS
	nrF2tmy8V+jKSdKnnG0KLD1Yh2OoegwK+ygRDcxN+PBoAnuZ+RbVvzA6KS0AZcackb777C
	StsuoqIkOZQf0T8BX+myWoYwj3f9wkWvmm+dslywSrf5K3ozrEik/EZYh7jXbNZrmM5ewG
	s6SUYKpTiStPStj1t609smurW39Q8Wn46+7BGBC47WCykoz7G4GbY3pwNdy4oA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH swat-tools 0/4] Improvements and fixes to swat-tools
Date: Tue, 17 Jun 2025 17:04:26 +0200
Message-Id: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPqDUWgC/x3MTQqAIBBA4avIrBM0+qOrRAurqQZKxRELorsnL
 b/Few8wBkKGXjwQMBGTsxm6EDDvxm4oacmGUpW1anQr6fTBJTzRRpZYz5NZWt1Vk4Kc+IAr3f9
 uAL5MlNG5g2F83w/PHCsHagAAAA==
X-Change-ID: 20250617-improvements-e5cbad7184b0
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=632;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Mpo5z88qA/T++qXYf/YgB96/v3JWKvFihRzoBchPk9o=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoUYQG1gUOXqRiDUfPRRLSiJIVbkpXd1yDV75/h
 9mZEBzBCAKJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFGEBgAKCRDRgEFAKaOo
 NsJ1D/9E0trxdD9hjF3r9cFUlHIZ1A4gXzLZMc3vezK/qMSY6z/6r35YPmTnUQxCQN3kGyeVZZE
 LkSFOYi+z6EB2oIeFEW3Wu2XFJ7u5vEEveAc+fu02ABBTzr19GdGIwjDoXBTiqmo1MUQSSH/6/8
 D7ba1DvjJwL+a/uwI778VkixZoIfYT9vD+5ruv4XY6n1+GBI6o+tU8QorsRyMg4c3tQFSyeN/md
 tcsa/uSozPo0bvX+WpN8eqz6INGP4PJ1BWilPz1bFE1/kPJqySkxfFLrODDEkoJZDrAvSf7b0mX
 356jg6pU+bLeQGSvIcgztXCxbver5e/uyD/ZH1iGGN1l90UWsNOxnJqEtuym5d12PG53bs/j66I
 J0Ax/WLvUzUooaPGQ1Ks4ZSH+ci+JxrXBUchzOZfF1LzNg9yVCUxjx/WN8i+Ylo+4ZXjhQ2v3bW
 IR7PkM9z6LuxsRiQ7WQpgQXngvwPm/tfpqjXXbwli0rj/BLiMBq7uAHnA/QA1rd0yIQ1/qjkPP9
 uNMcNlWjiaQdDHJhTcRhTVau5eF1a5BuaW9xsiZ9rBKv8EMF9tdduEPUdumHVzHCJmdyojDqAZA
 9xmdD0d4lR900emkeqAIC+V7AiouFW/Ai77ANNEGMK8yRRK720hGduxi7OPMOOmzPjs09zIIPyx
 5IkEyw4L45IB5ww==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuddvfeekffetleeuvdfghfejgeffudevgeffgffhjeetjeekvdfgueevtddujeeknecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhst
 hhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Jun 2025 15:04:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1650

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (4):
      main: fix --yes short flag
      pokyciarchive: fetch tags with --tags
      Add a b4 configuration file
      README: add a contributing section

 .b4-config                |  3 +++
 README.md                 | 19 +++++++++++++++++++
 swattool/main.py          |  2 +-
 swattool/pokyciarchive.py |  2 +-
 4 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: 72997bc94167082b3767571f1833ac805cdcb4a4
change-id: 20250617-improvements-e5cbad7184b0

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


