Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C77C02196
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:46:37 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web10.9238.1738752390116838935
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 02:46:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=HBqgGqiK;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F80D43419;
	Wed,  5 Feb 2025 10:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738752388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZpThSV0ji7MOirLMo3Ekki/svfMbhQU5BmyFLkD0Tyw=;
	b=HBqgGqiK6wr35WcMDP/uBdvD/LX7CqN4bYH8Iww1YwihAwTLJWBPGKXrFxiut2WZ5Czxwz
	1aKyTZPj4WXznwu2fh4uRag3UqC7VRLFansUV6YIuYol7caYtTuyyMR+PMVvvugxGymbPQ
	CNCJfTNCIc73yLmEy+xAUREyaaxUJPlqz6/0MY2hzVJWjNY2zHheShpPEeEQFEr+c2r4L7
	iKULvmJr2ykMD1sWbp5oqVvNQtYUBFWwwBjRlom9p+6+J2C40x01hGLGv53pJCiCPNs1+g
	7prDDb10ULCngHqYRlqahmHlavAwjrx888MbPMYWDRtLlCbqGGxH246DJNVRFg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/4] Fixes for buildbot 4.2
Date: Wed, 05 Feb 2025 11:45:50 +0100
Message-Id: <20250205-mathieu-console_view_upgrade-v1-0-fc1194355870@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF5Bo2cC/x3MSwqDMBAA0KvIrBtIRiKlVylF0mTUAZuRfGyLe
 PeGLt/mHZApMWW4dQck2jmzxAZz6cAvLs6kODQDarQatVUvVxamqrzELCuNO9N7rNucXCAVBjv
 15jp47A20Yks08eff3+Ervohytciz8hooITzO8we7vLtSggAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738752387; l=3245;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=q5FMwr8kH3Qdep+MAx6S2Y8JqxSKYfSiNjgokVdvNwk=;
 b=9xtKMI5XbudMaFqUQoL7t3YOjGLDrAl4XtfrdbwbvBwbUQhOxn6xRgGe4kM7/islpnVNfPc6c
 jtAGJ6cOdkIBQ9AwB7m4bwXyXPoFJpDa+MlqbXHoUdmmT/eL5i+iMQp
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptedvuddthfevvdefleehjefgueevkeefkefftefhvefhffefhefhvedukeejtdeinecuffhomhgrihhnpehjshdrmhgrphdptghsshdrmhgrphenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepmhgrt
 hhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 10:46:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1033

This series add various fixes for buildbot 4.2, both in buildbot
configuration and in the console view plugin.

Most of the modifications are in this plugin: buildbot switched from
angular JS to react JS, so this plugin has to be rewritten almost from
scratch.

As I am not really a JS developer, I would be happy to get any feedback
on these modifications, especially on release selector where my changes
do look a bit overcomplicated.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (4):
      builders: Fix configuration for buildbot 4
      yocto_console_view: import console_view plugin from buildbot
      yocto_console_view: create our own console
      yocto_console_view: Add release selector

 builders.py                                        |    2 +-
 steps/writelayerinfo.py                            |    2 +-
 yocto_console_view/README.txt                      |   17 -
 yocto_console_view/package.json                    |   78 +-
 yocto_console_view/setup.py                        |   16 +-
 yocto_console_view/src/index.ts                    |   19 +
 .../src/module/builders.fixture.json               |    1 -
 yocto_console_view/src/module/console.tpl.jade     |   39 -
 yocto_console_view/src/module/main.module.js       |  496 ------
 yocto_console_view/src/module/main.module.spec.js  |  228 ---
 .../src/module/releaseselectorfield.directive.js   |   68 -
 .../src/module/releaseselectorfield.tpl.jade       |    5 -
 .../src/module/view/modal/modal.controller.js      |   22 -
 .../src/module/view/modal/modal.style.less         |    9 -
 .../src/module/view/modal/modal.tpl.jade           |    6 -
 .../src/module/yoctochangedetails.directive.js     |   21 -
 .../src/module/yoctochangedetails.tpl.jade         |   42 -
 yocto_console_view/src/releaseselectorfield.ts     |  152 ++
 yocto_console_view/src/styles/styles.less          |   89 -
 .../src/views/ConsoleView/ConsoleView.scss         |   49 +
 .../src/views/ConsoleView/ConsoleView.test.ts      |   97 ++
 .../src/views/ConsoleView/ConsoleView.tsx          |  498 ++++++
 .../src/views/ConsoleView/YoctoChangeDetails.scss  |   18 +
 .../src/views/ConsoleView/YoctoChangeDetails.tsx   |  149 ++
 yocto_console_view/test/main.coffee                |    2 -
 yocto_console_view/tsconfig.json                   |   27 +
 yocto_console_view/vite.config.ts                  |   64 +
 yocto_console_view/webpack.config.js               |   26 -
 yocto_console_view/yarn.lock                       | 1755 ++++++++++++++++++++
 yocto_console_view/yocto_console_view/VERSION      |    1 -
 yocto_console_view/yocto_console_view/__init__.py  |   16 +-
 .../yocto_console_view/static/scripts.js           |    2 -
 .../yocto_console_view/static/scripts.js.map       |    1 -
 .../yocto_console_view/static/styles.css           |   79 -
 .../yocto_console_view/static/styles.css.map       |    1 -
 35 files changed, 2908 insertions(+), 1189 deletions(-)
---
base-commit: 8f6709cf0fad448ea87d80b50cd2ae375e5066b2
change-id: 20250205-mathieu-console_view_upgrade-d65f3186c231

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


