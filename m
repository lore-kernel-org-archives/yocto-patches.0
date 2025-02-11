Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38DC021A4
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 14:48:43 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.738.1739285322097809037
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 06:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PmSmnjGD;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF587204D9;
	Tue, 11 Feb 2025 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739285320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uhRHSQnFuFa6dqwzK00ZksER0c+lXR+LPo62G31a5fw=;
	b=PmSmnjGDD8Y/sUATKEacCLjPSnidqDTARfDYuK0d1S/ha3Sy19i9moUEci04RmBOIxsxzc
	aFD7xZqhQTiyXE0xObjlqlYzIrbpqWZRcfi7fvHgho3JSsaZPUp+sCUoOcZjRWd/X4rLSb
	Ek27e50TP6NfbXm4cEjaD88Z/dHverD9/FlZtPDelrA69jqEbfETuCgJPneeCCHSm94WVO
	Hm9nivi/NaRs4X5ScRi1DawzjATPsG4Es1PLU22DEbqU2aJKtPdseufFmeGmIaUinSbqGO
	1CC7eq4THoA4gkBbn9ScbynH0/ZSg+SkiQauXD8PPgrSPTEnxKY2lXoo6+m66Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/3] yocto_console_view: Fix various
 small issues after migration
Date: Tue, 11 Feb 2025 15:48:17 +0100
Message-Id: <20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFjq2cC/x3MSwrCMBAA0KuUWRtIggp6FZEyTkY7EDMln1Ypv
 bvB5du8DQpn4QLXYYPMixTR1OEOA9CE6cVGQjd460/WO2feWCfhZkhT0cjjIryOpLHMmAyeMRy
 tt44uBL2YMz/l8+9v8FWqarBVfTSJgbOH+77/AEdAn3OCAAAA
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739285319; l=805;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ReOkQXBqBi4kWbOalUcCXE2eAf6dYE/BC0C3PQrTATQ=;
 b=pvTHMsJxkzCVa5qG3aALvREflvhe1L3aMRvp6g0yLLxkNSN67WmTFzQchU6TRDIlv6zSfL6l8
 9ahSYONE3ZcDSrRQiDCpHaOrVaqg0jKEoZFpm5wfyJooKSy++9NQjC1
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuedufeevjeeukedulefggeetkeduuefhkefhvdfftdetheeujefhueevkeehheetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmp
 dhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 14:48:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1056

Now the migration to buildbot 4.2 has been made, several small issues
have been found. This series tries to mix most of them.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (3):
      yocto_console_view: Group similar builder builds
      yocto_console_view: Keep known revision mappings
      yocto_console_view: Fix output link on valkyrie

 .../src/views/ConsoleView/ConsoleView.scss         |  2 +-
 .../src/views/ConsoleView/ConsoleView.tsx          | 37 +++++++---------------
 2 files changed, 12 insertions(+), 27 deletions(-)
---
base-commit: dab2c9bb81540511e3cc9581f53db1c103714913
change-id: 20250211-mathieu-console_view_colspan-a6ad40201c9c

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


