Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C0C36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 12:01:13 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.6733.1744200067899125307
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Apr 2025 05:01:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PJMpsMcc;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7A4B4435C;
	Wed,  9 Apr 2025 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744200066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+H/pFxi9y4XE8u4pFGVXmWj2aY1cK0djzx61Ws/KgSU=;
	b=PJMpsMccBsVB1ILb0zVPNtd8Rpwilq7D0kJZ91G25n9WiTTuAmsbClnmMdTNh1Iu4St0u1
	C/Au0Gkg4ivMb69/Rem97r7AtyZbhKPhXz5LukbDn06niRJRtc46RDZItl77HeZFECrjal
	7gACr3xHEUCUBH1ViCHqHNSvwDOUgeLrL1f5uhG8xaya2qBFD57gS39c6UiV3Kn9DXIIYX
	uikfInRockiaSoh3EyQ29mjQrYYjOI4HlrPMPr4Px2fYEvd3E9eh9nigeOaRgHisgxHpmo
	XDYPk8RpaJPpk7i1t1w649AylRLGP/MPKxg0IyuukJ6YtAOOKcKzeL5o9tD3kg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 09 Apr 2025 14:00:34 +0200
Subject: [PATCH yocto-autobuilder2] schedulers: Fix meta-webosose scheduler
 codebases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-contrib-mathieu-webosose-branches-v1-1-d7039069357a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGFh9mcC/x3NywoCMQxA0V8ZsjbQqQ/QXxEXTRptQBvpwwfD/
 LvF5dncu0CVolLhNC1Q5KVVLQ/Mmwk4hXwT1DgM3vm927kjsuVWlPARWlLp+BayalWQSsicpGL
 YMjEfaKboYXSeRa76+T/O8DVuhqE3o673KMXDZV1/dwtaq4cAAAA=
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744200065; l=1501;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=v4nl5Gj3PxF2nsgggr6ddT4kASelIcQej5NbmuenWBQ=;
 b=UYV2FGvssMKTzOJRXW/A1d3jANxNu2+9KTOQuVJ0xhCgTpuJwV48gptzQrDG0dZXkhTVprndD
 YoB9Io7FXoYCLXHD3QEaQ5ins1oZGnsXvtYaJtbWIbbmaEkfeDT6M4z
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehleegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelledtieffheelveefueffkefgheevvdeugedutdekfeeghffhfffftdegudfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghom
 hdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 12:01:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1339

Make sure to use the correct yocto-autobuilder-helper branch when
building meta-webosose. Kirkstone builds should use kirkstone branch
instead of master.

Prepare for supporting build of other meta-webosose branches.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Meta-webosose will have to be built both for kirkstone and scarthgap
branches with different configurations. Prepare for this by making sure
correct branch of yocto-autobuilder-helper git is used.
---
 schedulers.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/schedulers.py b/schedulers.py
index 2cd2d9d22c3c..dd34363498de 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -644,4 +644,5 @@ schedulers.append(sched.AnyBranchScheduler(name="bitbake-docs-changed",
 
 # Run meta-webosose for kirkstone once a week on weekends (2am on Friday)
 schedulers.append(sched.Nightly(name='nightly-meta-webosose', branch='kirkstone', properties=parent_default_props('meta-webosose', 'kirkstone'),
-                  builderNames=['meta-webosose'], hour=2, minute=0, dayOfWeek=4))
+                                codebases = {'' : {'branch' : 'kirkstone'}},
+                                builderNames=['meta-webosose'], hour=2, minute=0, dayOfWeek=4))

---
base-commit: 21b5aa780ea79c32b340d53aaef808520983b88b
change-id: 20250409-contrib-mathieu-webosose-branches-a3cbcc6b1bd2

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


