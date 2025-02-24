Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D8C021A6
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 11:00:06 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.86255.1740394804500003943
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Feb 2025 03:00:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=KMs5GjQM;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6072E44202;
	Mon, 24 Feb 2025 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740394802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jF7VFp1yzSGGjKbhhJfQe2Iz7UnSOwMFE8RcMvE8BJ8=;
	b=KMs5GjQMwozgFfyxC99UHBaYqcQqadZjZHij3l1KMUT/aXyypwPw6TPwqdS6nV6NpP4LOW
	b9RpEo6Z+gkvkfpKIXliUbNdQFnxy25Sj7Q6UZlpBK4XB20PNCTM02oJ4e1C7QkUy3ODDu
	eOCQtoS2cJlpeqMCyAFRHCvzA+Sadsj1OZzeY1HsKpUYSCxFOk96KiAlb/Zi/Zk106jdk2
	747ALofiQsPwMyrGHOAqveu9TROros/P6etRayaycq6yUd4BKZur0PZ4KdPVB6HsVDZoDT
	6/yebMrrIqSeT55HSP6RdAfJyV94swDd0jpazdiGPnszCXBlsryGjxS6a98esw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH layerindex-web 0/2] layerindex: Allow staff to set Yocto
 compatibility
Date: Mon, 24 Feb 2025 11:59:30 +0100
Message-Id: <20250224-mathieu-yp-compat-staff-v1-0-9b8d07f00af7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJRvGcC/x2NwQrCMBAFf6Xs2YUYEhB/RTw8m41dsGlIoraU/
 rvB4xxmZqcqRaXSddipyEerLqnD+TTQOCE9hTV0JmusN9Y6ntEmlTdvmcdlzmhcG2JkA4cL4IM
 TT93ORaKu//KNXtj6JgVZ+SsPuh/HDytXq015AAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740394802; l=800;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=fvHn6XvgqkHXA8mrxljfB09lzeL7JPS+Og+XaOZRjIs=;
 b=EzcS6rguv1gsfr2hxPnQEdSyow52Ru7Dv5GK3AZkctGaLo2TJdOyC4iECf6qbMaNnegeuhqSy
 tfBZiYgj8LCB3UisJbXlpaShkKe3MDa8m15Vb4OQV6FuMcNO8znT8dy
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuedufeevjeeukedulefggeetkeduuefhkefhvdfftdetheeujefhueevkeehheetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmp
 dhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Feb 2025 11:00:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1121

Fix ticket #15738.

Also fix local setup with current mariadb docker version.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (2):
      dockersetup: Switch from mysql to mariadb binaries
      layerindex: Allow staff to set Yocto compatibility

 README                              | 4 ++--
 dockersetup.py                      | 6 +++---
 layerindex/forms.py                 | 7 ++++++-
 layerindex/tools/initial_db_dump.sh | 4 ++--
 layerindex/views.py                 | 5 +++++
 5 files changed, 18 insertions(+), 8 deletions(-)
---
base-commit: c1dfe6e1c05b3414fd1dc1f8e835a3dde3690a30
change-id: 20250224-mathieu-yp-compat-staff-0a4a8aa5d4e5

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


