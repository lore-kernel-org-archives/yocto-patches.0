Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43806C7115E
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 15:04:42 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.21505.1750172681206160014
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Jun 2025 08:04:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=FJYCphrP;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD2CE43981;
	Tue, 17 Jun 2025 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750172680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYoKJ65isAQM2G4EeZZvJSF9iyy9PxrkD0kxE+XSJl8=;
	b=FJYCphrPQ3/Pd/eQU/DxILZ5LgATNWsmF6GeUDNGEmD5vTvdmmtTGUvFVf4g+RFCqMCXEp
	6UMC0irehR9PG13Sb60CzfVXHKr6xjmEp0T4kYEE0DsECZqvKeifGCg+WQPMpW61aB4Mdd
	MOF0hIjbz4/nsLriv1ZTvsXdHZ95MXLF5Exgh4j+XxU/jmVgDEaV5TBR/hSPcIFRkzV/2d
	mUvBj4Y79Q3thM70e8viMU5vGrtwvSAQ6u95xrg9X54aP9iDrX+fWC8mZmBv39EcTCBfPh
	oU7ZSGOV6ru6kEt/VPOlm7U3gHyMwSZYxe2M1O/ifVlm0LtLPsienYAmvd+bvw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 17 Jun 2025 17:04:28 +0200
Subject: [PATCH swat-tools 2/4] pokyciarchive: fetch tags with --tags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-improvements-v1-2-6125d17583fe@bootlin.com>
References: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
In-Reply-To: <20250617-improvements-v1-0-6125d17583fe@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=871;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=tepz+SE1Qn507MjAlINH0kBznn2IntzYV96TJF8Cob4=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoUYQGhGkOLbzLnnQ+HY80BUV6sP/jpXDW5YH0R
 DDisOrPwSKJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaFGEBgAKCRDRgEFAKaOo
 NlKWD/0WCC1F6HX89osPriRmiYV7bP4hgTiF7SVW7tcwMDSjQ6EL8nj1QLOVNhlFohHAI2Ix4Ja
 /VRrbgAci1wNBGzbpXE+xxLalmASLK8Xtqz9zi8EOnpw0NeFeAqAjZWA0Ykl27Sw3TnwQ2GIqHb
 a2Znux+zXjJEhh61L4LTtZ1/uBZ+iWtyuQ+pbu9FrHAyo+qWPb9WyV7TLmA4v+sRX0lOVMd4Fvi
 GfLX76nr+W67onzHcNnQgPZJAiEexoBlapJY2ff3jmrNMzg6ABRgEZhrgiUFuyP5QX/kBdseu8c
 fOIgkzsnvoNbKc6YKKoEqLHzZf5yZBV6M65FwFdVKd7RDv7PSvRDV1CTS71DZRQfsFotJfK/3h2
 y14zOnMvxNBtxsBlqZXD6gw2WvoHWuR0EXRsDT92p91/PF4uxG1v/whc7jTIY9woli49FWf2PaO
 1ilgNhngZPzjkoEVS8P8HFKqjqTFFucT7zvWhhSiGDMYbZES7wUCHRC0HsdndoxBxcAkVT6GtHo
 9pMlX5vDtisY8hahB4hB05zO9smWvyA8sxDh37UDav8hDEY/nYCNu++gpmls9gpeStu9OGCg2L+
 BQvh5Fhz7vWO10XC80E4CRGrZsFX/26TYtrai8ashflkK+pnHtYUXLdDnwgKaR4GC+yWzrouY7v
 zv5hvlAeDns1uIA==
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1651

Using 'refs/tags/*:refs/tags/*' for fetching the tags for a remote
removes the previously fetched tags of the other remotes. '--tags' does
not have that behavior.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 swattool/pokyciarchive.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/swattool/pokyciarchive.py b/swattool/pokyciarchive.py
index e464b37..93d8dc1 100644
--- a/swattool/pokyciarchive.py
+++ b/swattool/pokyciarchive.py
@@ -45,7 +45,7 @@ def update(min_age: Optional[int] = None) -> None:
         repo.remotes.create("archive", ARCHIVE_GITURL)
 
     for remote in repo.remotes:
-        remote.fetch(remote.fetch_refspecs + ['refs/tags/*:refs/tags/*'])
+        remote.fetch(remote.fetch_refspecs + ['--tags'])
 
 
 def get_build_commits(buildname: str, basebranch: str = "master",

-- 
2.49.0


