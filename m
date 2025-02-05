Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B78CC02194
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:37 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.9237.1738752390113723969
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 02:46:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gCePgy4z;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64D4143423;
	Wed,  5 Feb 2025 10:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738752388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFJMXeDq4082kZRekh//zGLsVEfny7CSgx9HP2246Ow=;
	b=gCePgy4zEcyRGeg5VAco1ED9qo/S2tZ2Y1LvlhdrAl7N4abZmSm102hdvDxuissJKZkfAQ
	dzJTppZnAqqlI2NODyP+lUZdH2msh6fgRhM/6lilOdm/u4EYHiA+3sig8wcLfcz0MTRlHh
	DSjkygqDoYRFsWE1Yo/vTbXWRSZQczEAayAG6Wuh67F7yuhFNBrAu9wTvoABiE+qsuv+jx
	wcHCRJnXYf2UumrLhfSoRIDqFG5SRvDWTm2hdNExy2fWXZmzxTyytoV5QPvvAsBJsun5Pd
	nNiqgnCnNVmEO3/dOntEDN8T2dk3UNbnonww9aqlNebfWaDvVJUguUgHmTlo8Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Wed, 05 Feb 2025 11:45:51 +0100
Subject: [PATCH yocto-autobuilder2 1/4] builders: Fix configuration for
 buildbot 4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-mathieu-console_view_upgrade-v1-1-fc1194355870@bootlin.com>
References: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
In-Reply-To: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738752387; l=1200;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=D7AlAiwv5rkD9pSgFdIGp2l7zZAxyvc9mtlwlM10nyg=;
 b=XXJN/zNYhcjFZIOgUkWkU7VMzja6/UG4K1EBl3vyrdiZSdBvpPulrae6Adri1ddSUeNz7lc0/
 0PK0S51WZUtCXCNpzet6nVcx9+yHmV4ZYkn4D6xrQSatI75OTfmKq97
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegso
 hhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 10:46:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1032

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 builders.py             | 2 +-
 steps/writelayerinfo.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builders.py b/builders.py
index 4f2bf00e5387..14ea1df1192e 100644
--- a/builders.py
+++ b/builders.py
@@ -231,7 +231,7 @@ def prioritizeBuilders(master, builders):
                 time = time - builder_bonuses[bldr.name]
                 #log.msg("Adding %s so %s" % (str(builder_bonuses[bldr.name]), str(time)))
 
-        defer.returnValue((time, bldr))
+        return (time, bldr)
 
     transformed = yield defer.gatherResults(
         [transform(bldr) for bldr in builders])
diff --git a/steps/writelayerinfo.py b/steps/writelayerinfo.py
index d2c196f2174a..a0669bd10df4 100644
--- a/steps/writelayerinfo.py
+++ b/steps/writelayerinfo.py
@@ -41,7 +41,7 @@ class WriteLayerInfo(buildstep.ShellMixin, buildstep.BuildStep):
         cmd = yield self.makeRemoteShellCommand(
             command=writerepos)
         yield self.runCommand(cmd)
-        defer.returnValue(cmd.results())
+        return cmd.results()
 
 
 @defer.inlineCallbacks

-- 
2.39.5


