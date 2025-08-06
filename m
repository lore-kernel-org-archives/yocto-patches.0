Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B496CA0EC1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 15:44:33 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.28545.1754495066279750866
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 06 Aug 2025 08:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=lfe0/4tN;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F43E44339;
	Wed,  6 Aug 2025 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754495064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pbn6VKCuGWXsUX7XeqSwSLmrNp6jMsXbTUC9eiwjJyE=;
	b=lfe0/4tNftTyETuBoKiKR1nIKg0nBKbzDMLGjeilQIRwHi4sQfw4h2SdABN9dZB3MSYoO5
	+wTH1XofRC8UaORZr+4i0CUikhcxcnbCj465DQ5XSE+UotayZ38T1ScSVXQ7acz+YW/xQX
	sj9gZ7sxIWu/TQQD1F0YOgNwe3l840LJTKI6/xPaOQK/rABbWAxZa85+4YKDmLd0E14hCo
	VhX6hcNgdZqFGJSEiurDWXYeq9J3bgqBe+eL8yJlEy/Yj1FbaYMkQ6bpNWCJT9Q2SELziQ
	MASALaRP4iuob9g9LhSjGv3K00kKDOg28BbYmdwu4wOJQBopHqvSRGGY33X9+Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 06 Aug 2025 17:43:32 +0200
Subject: [yocto-autobuilder-helper][PATCH v2 2/7] config.json:
 yocto-supported-distros: use --check-worker-statuses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-check-worker-statuses-v2-2-59dd990d22e7@bootlin.com>
References: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
In-Reply-To: <20250806-check-worker-statuses-v2-0-59dd990d22e7@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=866;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=ffxx7FO1xCikDkuFSJ8Zy8mpXveI5ojIMmTLK6EGl3U=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBok3hW2ClfObrZS4s6p2ufzg4TOca5hcjqR9MUS
 gVbMrsC7KqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaJN4VgAKCRDRgEFAKaOo
 NpAzD/99iqBlJMbrwz8CEA3tHA1RRkIvww1K7wpGyQUixoyRse0dNEdqwsDMEpmvTy6uzZf0aWV
 G/B9o2MIolgINcZAh2WkfVi+KhKjny7u0Ryf5mE+B29yPmqsu7pWrdCloLIUtA4CvyGCuwknUOz
 /T/wtbjupgXTIvCdGYz/0T7FXsrMNYEgRMqpdybbfGH1gMs9LCvVTEv4dJUnMDj1vJn7SRGd4wQ
 ON/UOCC/mski90vCjtUkMUBgwUplv+iP7sQBEzxmGL4i3PIy57umjvp/caWhEfd45vz+jH/Zg8e
 p/nTtl4GyUaOICKfQOfv0rZayoG3xkqWYibxCX4zvzr76bemnHdgeiysLrtmY6Txpyu3ktwZKEy
 MABEm5/FDrFDzOFmlrKWavaUoOWV6MppNan95Asz/Q/Z/gDDmbf+xIZbzjK8m0h3lX5SMbGG8A0
 wdWyrrnm+8LHYP+P0+dc2a5fkvtIZ+kj0eXOxIZuZyY7cfdv57FsmfpJZfByeyVNa2IwxPdFXsQ
 8MkfvZBKd5xearg+9U/Iu/KQWeQ+I9I5qfjzcy7B0nGLBHUk+cq8OnWf94+pEl9rEfd65wohbhb
 byLH4wa+5946UhVwd4QnwTJSStUbtzTx7GRutdZ03/vUlHe+eWfyRx+Om+m6teefoJCAkLEMduZ
 DQ+WEQsqtKHZlqg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvt
 hgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 06 Aug 2025 15:44:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1892

Use the new --check-worker-statuses option. This only makes sense for
master.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 171e885..16ff72f 100644
--- a/config.json
+++ b/config.json
@@ -470,7 +470,7 @@
             "step2" : {
                 "removevars" : ["SANITY_TESTED_DISTROS"],
                 "shortname" : "Compare AB workers and SANITY_TESTED_DISTROS",
-                "EXTRACMDS" : ["${SCRIPTSDIR}/yocto-supported-distros --config-from-web --release-from-env --compare"]
+                "EXTRACMDS" : ["${SCRIPTSDIR}/yocto-supported-distros --config-from-web --release-from-env --compare --check-worker-statuses"]
             }
         },
         "trigger-build-posttrigger" : {

-- 
2.50.1


