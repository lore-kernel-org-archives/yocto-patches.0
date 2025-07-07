Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A0EC83F12
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 14:05:51 +0000 (UTC)
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
 by mx.groups.io with SMTP id smtpd.web10.218.1751897145972113554
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Jul 2025 07:05:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=R81Tr0gU;
 spf=pass (domain: bootlin.com, ip: 217.70.178.235, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6889F44237;
	Mon,  7 Jul 2025 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751897144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwjDK/ZWdpJKixoKwiSW0euSxhi97IFERMg5a1mrSc0=;
	b=R81Tr0gUhp3dPS+/0vM6D0INKHfiTeTqbPPhnsO+D0mH95bxcowvGfIfIZlR3HYEnxxNJg
	JrAbvtEB0k2PF37DJwha07ppaPExnx2uhKX79Ua69m27WTiLZMAfAPhzyaXjaqS1TJoka9
	LT1MmZ1tB6GcBGmrpOHeod7yHt+ZcWxrGGaJcPjqUMgTBxlSKzYX8fvHlhUcZvrKf0AkY8
	x0S9S4zqRgu4hNkmBZvo7Lxgp804HJy8tXT5RzXMdmAJ4YrUSPeWyoyOMYGWxMrF1aVmT7
	rv1npJf8FrkjOcGx3ck1Lfpi5wQ/x2vSkcziwjKkn/DOiHt7oD3HNIShLvqblw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 07 Jul 2025 16:05:25 +0200
Subject: [PATCH yocto-autobuilder2 3/5] docker: Allow to use any worker for
 builders of previous releases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-contrib-mathieu-popup_title-v1-3-d683ba953b96@bootlin.com>
References: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
In-Reply-To: <20250707-contrib-mathieu-popup_title-v1-0-d683ba953b96@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751897143; l=898;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=5i7fbzbfqtRX8GPZX6Bm8n6aGq6nnmyfYx2W7nKa4Ls=;
 b=Wa+UdS3IfKUUt7WhlWL4BPYg+rIu/z7W8Jk91p7/bOFkUs7WpQL3hPW/UHW/ewrSrVGHVzdRN
 KwdzsATp9hECSvYGzkHhxK8W7Lp5ruKx53Dil/s1en4w0fWeVj54Skh
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1773

As today we only provide dummy workers, allow to use these for any
builder, or some jobs would never be run.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 docker/Dockerfile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docker/Dockerfile b/docker/Dockerfile
index 3538aff5e640..6948a1155548 100644
--- a/docker/Dockerfile
+++ b/docker/Dockerfile
@@ -109,6 +109,8 @@ RUN sed -i \
         # Change location of sharedrepodir and publish_dest directories \
         -e "s@^\(sharedrepodir *= *\).*@\1\"/sharedrepo\"@" \
         -e "s@^\(publish_dest *= *\).*@\1\"/publish\"@" \
+        # Use any worker for any release \
+        -e '$ a workers_prev_releases = {}' \
         /home/pokybuild/yocto-controller/yoctoabb/config.py && \
     sed -i \
         # Change location of sharedrepodir and publish_dest directories \

-- 
2.39.5


