Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD57C02194
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:52:27 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web11.9482.1738752746250564722
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 02:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Cq6QAu1O;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1B864318E;
	Wed,  5 Feb 2025 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738752744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COc4x8iBIxPzjR7pxZABxQ5aPvF9exh5hmlOARwKTeQ=;
	b=Cq6QAu1OzOJ2dxirn2CtWGBuB+WOu09kgiHcwAyxQDTe2VlSmwxjzXk1Ub3WiLdq8V350W
	tthJRVAHjfmFWmiZOvaxisOaNYa5GzXdVgH4H/1KjwjxOi++aLi7cnUBAE1MMCXFkwD3hu
	n8FcFOtJqdob0oMR65sfj0EUkYud7L0pR5ElPJmyMQpiMPQ/xcLy1u7LecZ9kQt0fodsiP
	8E08oe+z9LS6pwFsBzyyVsLxu86GEX2O0L69rder4svnvLe/SVtCRCLA4gjgyaTYNoclmC
	jsY0tAZiOCWe4aF85c1rJ6aQ/EQ8nY9y9AhZYhsDdbYf1wiMxLx1nwwpQl8/GA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 05 Feb 2025 11:52:08 +0100
Subject: [PATCH yocto-autobuilder2 1/2] schedulers: Fix missing parenthesis
 in field label
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-mathieu-local_ab_docker-v1-1-b1543323b7e7@bootlin.com>
References: <20250205-mathieu-local_ab_docker-v1-0-b1543323b7e7@bootlin.com>
In-Reply-To: <20250205-mathieu-local_ab_docker-v1-0-b1543323b7e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738752744; l=1571;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=tZYhmUuLnLUGfb0Y+7tByzMnSdUD3D15544r9hqyd28=;
 b=8cJF7rFGRo1o7LTNdTI2wTQcJCk/pM5vKux10xZ5c4sCrR9S/Hjahxhy/esnRtnhVnI26SQKz
 0IuWYgO/ltnBD3se1htXV8c7n73mNSkTc9z4hDPk7Yvr/4aP/AVVY7c
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgto
 hhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 10:52:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1037

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 schedulers.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/schedulers.py b/schedulers.py
index e4760ed8bf1d..aa6099984e79 100644
--- a/schedulers.py
+++ b/schedulers.py
@@ -403,7 +403,7 @@ for builder in config.subbuilders:
         reason=util.StringParameter(
                 name="reason",
                 label="""Reason (please note the reason for triggering the
- build and any expectations for the build's outcome:""",
+ build and any expectations for the build's outcome):""",
                 required=False),
         properties=props_for_builder(builder),
         buttonName="Force Build"))
@@ -461,7 +461,7 @@ def parent_scheduler(target):
     reason=util.StringParameter(
         name="reason",
         label="""Reason (please note the reason for triggering the build and
- any expectations for the build's outcome:""",
+ any expectations for the build's outcome):""",
         required=False),
     properties=[
         ReleaseSelector(
@@ -535,7 +535,7 @@ schedulers.append(sched.ForceScheduler(
                    ],
         reason=util.StringParameter(
                 name="reason",
-                label="""Reason (please note the reason for triggering the docs build:""",
+                label="""Reason (please note the reason for triggering the docs build):""",
                 required=False),
         properties=props_for_builder("docs"),
         buttonName="Force Build"))

-- 
2.39.5


