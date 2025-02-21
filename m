Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A40C021B5
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 11:09:13 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.20833.1740136145479490127
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Feb 2025 03:09:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=AoIDLD15;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B66543201;
	Fri, 21 Feb 2025 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740136143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uCWwd4X0PrYAS1F9hRBK5gh6YT9QRV4FUuGrn3gcBfM=;
	b=AoIDLD15F4mKWboctmyscxOh6rea2b4mkPg48b7B/EVq+xKji7/2ZWsX5F7VvFSHPNtdXp
	Bep6lRXKIZiWpQ6jXM7boxMo0OVC87eoQD+3JuMm34sx3d7LgOwPK2pCrjnF5G3uq9Hjbi
	xEVHeNFGdGWCpCl3PZfJGurl4AEVUvaHYeydufMyU3sVqJ/b5eCfb0CHMLKITkcltOWOV+
	ixqzvQJ+TSADVWhosU8/fv4Pc4cd/0qxS4geP8MCRU6zeDE1NCrRuh6yTNFqtGFF25OQmu
	ChGZ34DLD9eLXGydWEMoZVe3U7dx55xS5uwAXS2iPH0UslmXMMWZrluozQVwjA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/3] Fix force build window style and
 release selector
Date: Fri, 21 Feb 2025 12:08:33 +0100
Message-Id: <20250221-mbria-release_selector_bugs-v1-0-13d166ff0ca1@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALJeuGcC/x2M0QqDMAwAf0XyvELN7Mb2K0Mk1cwFnB2JHRviv
 1t8Og6OW8FYhQ3u1QrKXzFJc5H6VEH/onlkJ0NxQI/BI9buHVXIKU9Mxp0V9kvSLubR3NlT8M3
 t2gS+QDl8lJ/yO+4P+KcSOspLilmmgRWh3bYdc+WP8IEAAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740136143; l=707;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=/XfKSRwFmNJ3N9kAmp2ngBLEbK66qHcaPePpfFFaZtg=;
 b=gfAlwNx4nkIHoUA7pTIIMkKdndfvdqJgh8/xYhYnyKQ3t7h5hdFJLQVWTaM2uJ0g/GRxwmatw
 joyncskiK8oBNJf/R4pdvIdG31HtIK6Ksic8INeJ2oP5twGLYm1dlVX
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuedufeevjeeukedulefggeetkeduuefhkefhvdfftdetheeujefhueevkeehheetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdro
 hhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 11:09:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1116

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (3):
      yocto_console_view: Fix release selector use with keyboard
      yocto_console_view: Override Force Build form CSS
      releaseselector: Fix selector not applied in some conditions

 yocto_console_view/src/releaseselectorfield.ts     | 72 ++++++++++++++--------
 .../src/views/ConsoleView/ConsoleView.scss         | 37 +++++++++++
 2 files changed, 83 insertions(+), 26 deletions(-)
---
base-commit: e42afa8f880cae3c927cf8b366b7364d9c109b0d
change-id: 20250221-mbria-release_selector_bugs-30a5049745e6

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


