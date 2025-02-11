Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A97C021A2
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 14:48:43 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web11.737.1739285322073187847
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Feb 2025 06:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=HVMDA8d+;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F13C204DC;
	Tue, 11 Feb 2025 14:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739285320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWZtsjvZOp09lHjnL8rddMYikdpnk9UyDoXbYZrzrc8=;
	b=HVMDA8d+Ze7Pysa7TcWaMtv0cERajlwamlEwnjdvxUkOac2wpKJHwJb44YaqNbC0sJLeKs
	tr6oQsK9f88GjqBDC9yT2G8Zm7BD0X+KKKja0LL+/Ir/Jh3kuZbBj2f/ILPpgm9xE7Fj3o
	Mj+eaHJX3ERXQAh90BuBa2cc1TNFMP1/E/z5nBxku4bQlFHPucnPetEJmYwfuUVIdbIsGb
	dTyNYljCqVo+rAUOp3bCQ9gFz8N+s8lFX0aoAk1F2jHWFsxoehTcMYGZ27Mt7SRpkXqR/r
	4JSTilzitHYvJmqU/Em5V6VcnV9G3Ew7KW6Bvni2PjJwQiAS/tgRPyKcQEQoqA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 11 Feb 2025 15:48:20 +0100
Subject: [PATCH yocto-autobuilder2 3/3] yocto_console_view: Fix output link
 on valkyrie
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-mathieu-console_view_colspan-v1-3-d94a8c55acf9@bootlin.com>
References: <20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
In-Reply-To: <20250211-mathieu-console_view_colspan-v1-0-d94a8c55acf9@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739285319; l=1145;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=qEL5bY3gb/e8qoBXQTbPp6P3JsQ9m6mcpTqiKSpsAbU=;
 b=01nOSiFlCpfW9jNdSi99Muhgtg4uAMOKY5Z1cmRkRXaICOJJI8hmJbyQ8H1QpF1EjX/ihPMrG
 5Kw6syk0D8tBZ9bzV9Y2ip+CB8Fz4lIFB8WeBfUskXJ03mpf/3OtoB9
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepheegudeiiedujedvhfdvueeugfeghffghfefhfdthfetffefvdeuhfduudfgkefgnecuffhomhgrihhnpeihohgtthhophhrohhjvggtthdrohhrghdphihotghtohdrihhonecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmp
 dhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Feb 2025 14:48:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1055

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/views/ConsoleView/ConsoleView.tsx | 1 +
 1 file changed, 1 insertion(+)

diff --git a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
index 93c51b340b17..a1a338684fd6 100644
--- a/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
+++ b/yocto_console_view/src/views/ConsoleView/ConsoleView.tsx
@@ -191,6 +191,7 @@ function selectChangeForBuild(build: Build, buildset: Buildset,
       if (build.properties !== null && ('publish_destination' in build.properties)) {
         change.change.publishurl = build.properties['publish_destination'][0].replace("/srv/autobuilder/autobuilder.yoctoproject.org/", "https://autobuilder.yocto.io/");
         change.change.publishurl = change.change.publishurl.replace("/srv/autobuilder/autobuilder.yocto.io/", "https://autobuilder.yocto.io/");
+        change.change.publishurl = change.change.publishurl.replace("/srv/autobuilder/valkyrie.yocto.io/", "https://valkyrie.yocto.io/");
       }
     }
 

-- 
2.39.5


