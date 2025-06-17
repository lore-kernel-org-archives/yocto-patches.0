Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36343C71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 15:04:42 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.21436.1750172681212361428
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Jun 2025 08:04:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lpaoGviR;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8EAAF44262;
	Tue, 17 Jun 2025 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750172679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=khk1vPCkzmudH77U0yD84XvEYE+/BHico6ln2CmlqU4=;
	b=lpaoGviRUaEhu9q50KyozFSMlwhNgOH9GdGrkoCgm7CMhQNw2CRRhzsokVOg2TNFYmqaNp
	hHRcR3IkJWDYs/uxD+V9Iv9k5+LgI+eHUYtvDfcreprmGitbWY0akgLgbCFw+6lekYnHO/
	j3n7mZokQnQJ7hMJsdfds7da8O7mydNDpixGDvVQ7Tf1Ukn8dKH6anr7hDjCcArfMLpmBL
	14ZnkSogzO21f16vLJJsK6dVfaep2Yv7YvjLLrmibRsqRJmB0tFbiSGgOI97BDBX6o+WU1
	sdwHfUvSL95yxxFcoP5O7Zebvu6/XV5C5CReXkQWahZgvjilnMzif7zAgDPBhg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Jun 2025 17:04:27 +0200
Subject: [PATCH swat-tools 1/4] main: fix --yes short flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-improvements-v1-1-6125d17583fe@bootlin.com>
References: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
In-Reply-To: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=717;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=lLniafjWjIHK9NkX8yXf552Uhra0ou95RbL/JnQedT4=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoUYQGKkjmUcNgWRtzqOuM/FXvHz3TqvDmJ8P1L
 uMe+Aog6tSJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFGEBgAKCRDRgEFAKaOo
 NjQoD/9CLGhIoKqJHOiJseAUQCEB6puESOZ0bBBHIltGQrtBZdSr+atW49vEP/XGyUvnlDRbY8R
 3z399DItHAX4fs7w2B8zpXBuo+ovuLkXo+s5E+ULzVYY309NZ1oRo0IJj1cghU4MCDfjp582RYC
 sfmRSbUnTvzwgAbvxnF/1SKX0KnKPwnKXhONAlIdUJXWmRLXEWEFj4loN3yL2i0TFx1m4pBMxvh
 soYHdRZTUJ8/VFa5JnrbMa8knOYchNK8FrioIWXnvJp6smiIYLsuSteVkVA1zMkdhlSh26yEGKp
 mPhG8vz3RgzzdWwwO8eA1B+GV5gfSK/d6Vtp2pdSbcqdiXJXsEwrWd9Zx4wsZ360+5iHJl0RXjH
 zC2WI7F3HOZhaEeX2l9rN6QLH0YIn73JSDntll7amrbc6A0Jxv/rZBl7oR3Zsv6lpxlGS0DNJL2
 p456gcNM8UquH2pPdTDUQdv6LSMzqMp57Ja2yJ8uiENMa1UVhqSboWN4mquawMsIXfWa8d1kpxx
 ZRO+T1sYvLy/F9XQmh/HJOK1THl7W/QIMoZ5G6eZRNJnrfFgP4+4WTh38P9y4cUq91gEEPgTWXC
 KHDgmvV3YEMGH96QvBs969eMWMdK5CViUE7wMKMpVVMqxpNsDk1qy1IfPY6+13tjDdMxs6i+RuB
 NawMLmv0yXoEsew==
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1652

Should be '-y' for yes, not '-n'.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 swattool/main.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/swattool/main.py b/swattool/main.py
index ce09bd5..a101340 100755
--- a/swattool/main.py
+++ b/swattool/main.py
@@ -383,7 +383,7 @@ def review_pending_failures(refresh: str,
 
 @maingroup.command()
 @_add_options(failures_list_options)
-@click.option('--yes', '-n', is_flag=True,
+@click.option('--yes', '-y', is_flag=True,
               help="Do not ask for confirmation for each failure")
 @click.argument('status',
                 type=click.Choice([str(s) for s in swatbotrest.TriageStatus],

-- 
2.49.0


