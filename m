Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E525C83F10
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 14:05:51 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.217.1751897145754452065
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 07:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=A+H5HpgX;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DF6044279;
	Mon,  7 Jul 2025 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751897144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SS5jlOlmM45xLjMXfTL3LovJGvCde2FFVzTgZoVzbhw=;
	b=A+H5HpgXKX7a9CvPmvUtLActlGn6EN53HGqUBr276prmxMNMY3P1XEifFwkGA4lI2MfhN5
	CrVLwDcxAyiwTTvze1G+6WB5CoM5+FsYXUAJ9IyxGYkFJWAqvOcuUXL/TnGMb10ta2R8BC
	ROXyQsqiK5kn8CMcS6K60f2xU2gVS3/cx/1GG12Zu46bqgQZlCW6pezuS2pdEMdfGdIiu/
	I0i1y48mGswUobiqP3fFZFPyeY9n7M5FHMKR/KRyasf/p12wkYWhqnasli5KnCAGWpcU65
	92JhAF5y9oQ8Cq7Svc6XNJPc9mYqF4aSWbdBOuj1SoXAfuWpKsI19D8uQahDnQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 07 Jul 2025 16:05:24 +0200
Subject: [PATCH yocto-autobuilder2 2/5] docker: Fix scheduled builds
 disabling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-contrib-mathieu-popup_title-v1-2-d683ba953b96@bootlin.com>
References: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
In-Reply-To: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751897143; l=1028;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=HiHbQ70+16Q8E7zXoCB6cfOFcZr/AzFVgUNcVWoDVN8=;
 b=3wxFqB75FilQ64mDS6esyydYfZpSBYaAvWN5qb+DOK9gqFCQz+S1dBPctwadWvHiHsAbfTIsL
 wrWEAbMQPXjCzSS6M+sX8w3uTMWw48mGApJpUlmEH/DUXxLrtTooDVk
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtt
 hdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhm
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 14:05:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1772

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index d46e7f403bb8..3538aff5e640 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -122,7 +122,8 @@ RUN sed -i \
         /home/pokybuild/yocto-controller/master.cfg && \
     # Comment any sched.Nightly schedulers \
     # We try to support multilines code blocks by counting parenthesis \
-    awk '/^schedulers.append\(sched.Nightly\(/{comment=1} /\(/{count+=gsub("\\(", "(")} /\)/{count-=gsub("\\)", ")")} {if (comment) {print "#" $0} else {print} if (count==0) comment=0}' \
+    awk -i inplace \
+        '/^schedulers.append\(sched.Nightly\(/{comment=1} /\(/{count+=gsub("\\(", "(")} /\)/{count-=gsub("\\)", ")")} {if (comment) {print "#" $0} else {print} if (count==0) comment=0}' \
         /home/pokybuild/yocto-controller/yoctoabb/schedulers.py
 
 COPY docker/entry.sh /

-- 
2.39.5


