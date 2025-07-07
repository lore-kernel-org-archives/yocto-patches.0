Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD83C83F0C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 14:05:51 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web11.216.1751897145635947009
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 07:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=LTeKSBaJ;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC4C444276;
	Mon,  7 Jul 2025 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751897144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GktgeoHXCVHW7txNch5R3AHOfnhFAUZMqNS4Mycs/1U=;
	b=LTeKSBaJfjprfNLMejZlD72wryl55NTb5KXGfWLJLcKgv0YTd5lNWCGTq/Xq5bZyy5y8hd
	uxitvVfzcC2xFCLheYC+7JWhmvhD+HMsF3o8l4KOpZkXCBVidEYCQBab9/cDZhw7qm83JY
	/glQ9pwEAdyPxw1mULfY/T33TCLzDuOO9B+jBNecFhDwEJ59L8Se6IANnIkuoqmnTmu6FW
	LgUg0/fKFscCGpnQ1nPkhKbd2gwOYtj5b9wwVmxjf8Rgz4VlWP7wDzJPYm1xoXUcsr7cQD
	TSMWynwZdSRATzGUjfhW5/L4XVSFBxJ3xsOfKiO/t35195U0MUuHhNYVxxNXrQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 07 Jul 2025 16:05:23 +0200
Subject: [PATCH yocto-autobuilder2 1/5] docker: Add note about using a
 custom buildbot branch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-contrib-mathieu-popup_title-v1-1-d683ba953b96@bootlin.com>
References: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
In-Reply-To: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751897143; l=2146;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=8oFpFXW3wlBN17Z6EH/ktreaNwZBYPYthXBs7rcvTHU=;
 b=Ze/zcV9QnD7MwnMRi3o5CItkmHC46dVUm9jsZuJeZVOF5S/oPgWOeRWelJiraw6nuDFkRDIrf
 aV56WygC9QeDhMQMUfkew0C2W80r57v/ECzU5nU82GkzKOOPgg2RFg3
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdthedvhedtjeeuffehffdtheefgeelleetkeeugeehhfeihfelhfevgeduteelnecuffhomhgrihhnpehgihhthhhusgdrtghomhdphihotghtohhprhhojhgvtghtrdhorhhgpdhophgvnhgvmhgsvgguuggvugdrohhrghenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihon
 hhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomh
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Jul 2025 14:05:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1771

Adding an example of using a custom buildbot git and branch and add all
needed dependencies.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index fc6e6635a873..d46e7f403bb8 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -22,6 +22,7 @@ RUN apt update && \
         iproute2 \
         iputils-ping \
         libacl1 \
+        libcairo2 \
         liblz4-tool \
         locales \
         npm \
@@ -39,6 +40,13 @@ RUN apt update && \
         xz-utils \
         zstd
 
+RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
+ENV LANG en_US.UTF-8
+ENV LANGUAGE en_US:en
+ENV LC_ALL en_US.UTF-8
+
+RUN npm install -g yarn
+
 RUN pip3 install --break-system-packages \
         buildbot==4.2.1 \
         buildbot-www==4.2.1 \
@@ -49,12 +57,18 @@ RUN pip3 install --break-system-packages \
         buildbot_pkg==4.2.1 \
         websockets
 
-RUN npm install -g yarn
 
-RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
-ENV LANG en_US.UTF-8
-ENV LANGUAGE en_US:en
-ENV LC_ALL en_US.UTF-8
+# Uncomment and update following code to use a custom buildbot branch
+# RUN pip3 install --break-system-packages \
+#         git+https://github.com/mbriand/buildbot.git@mathieu/workers_limit#subdirectory=master \
+#         git+https://github.com/mbriand/buildbot.git@mathieu/workers_limit#subdirectory=worker \
+#         git+https://github.com/mbriand/buildbot.git@mathieu/workers_limit#subdirectory=pkg \
+#         websockets \
+#     && \
+#     git clone https://github.com/mbriand/buildbot.git -b mathieu/workers_limit && \
+#     cd buildbot/ && \
+#     make frontend_deps && \
+#     pip3 install --break-system-packages pkg www/base www/console_view www/grid_view www/waterfall_view www/wsgi_dashboards www/badges
 
 RUN ssh-keyscan push.yoctoproject.org push.openembedded.org >> /etc/ssh/ssh_known_hosts
 

-- 
2.39.5


