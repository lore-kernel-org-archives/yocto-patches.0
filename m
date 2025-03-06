Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9C2C282EC
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 13:20:22 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.12979.1741267215193712332
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Mar 2025 05:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=O2ZBc8HU;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23C0D20453;
	Thu,  6 Mar 2025 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741267213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4ItauS4/P4a6UiRQ+dgFO8A0sBJXev/prym+xlFlheM=;
	b=O2ZBc8HU0u6G9WKfz8dZaLwY+bRaUdTAgZSVNny+TmA+d14ESiC+Oyrzm/3wqf9c9BSAXD
	Z1vtQlJMNmDPNjkmp74sjMbyUMopwMRwCZgh9GINpbQoUubQeLJKf8Gvv0CUJ7EjnkxGOP
	/S82JuJjJkxUaIOnIsZh6a0NgwSpGU7ep2t8UTblK7D5YIVXhaPMDNSvJ7AqTD2ot6J7VM
	IeqnT9hYtxAkAK4cCXNDW6Nnr7sOiLJai5Km3m/gSpr3kZsQ01zsc7AldKB9JdmbuYpzzA
	yJBKIpNE4fOI7CVsUQn+nxBcQUZ6RQzMc+AQ1e6/cNDeuxaFdlwqeRcTQ9xRCg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/2] docker: Build local git and add
 more workers
Date: Thu, 06 Mar 2025 14:19:44 +0100
Message-Id: <20250306-contrib-mathieu-docker_multi_workers-v1-0-d208b643cfae@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPCgyWcC/x3NTQrCMBBA4auUWTsQU63iVURKmkztYJuRSeIPp
 Xc3uPw2762QSJkSXJoVlF6cWGLFfteAn1y8E3KoBmvs0bSmQy8xKw+4uDwxFQziH6T9UubM/Vu
 0IqFpz+HQWT+erIWaeiqN/PlvrvAVnwVdyTIUngOphdu2/QCD5GTsigAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741267213; l=656;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=O4J0JBf1/HzQvfnCjap84TCcKwkFguPtlxTLLclJqls=;
 b=VqG6wkTDgUOfr13jiccRvfAtsbq0L3CjkeF6N5VrOE9JALwyjQ0qTQN+ypGJ4iyqTvB/8IoRt
 OAqBeg4sNQ2Bz7OFxD+OS7BKOprJRj9bre8fXd4igmJND7nWtgjj1QI
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuudefveejueekudelgfegteekudeuhfekhfdvffdtteehueejhfeuveekheehteenucfkphepledtrdeifedrvddtvddrgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdeifedrvddtvddrgedtpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Mar 2025 13:20:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1160

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (2):
      docker: Use current git version
      docker: Allow to add several local workers

 docker/Dockerfile   | 15 +++++++++------
 docker/README.md    |  8 +++++---
 docker/compose.yaml | 42 +++++++++++++++++++++++-------------------
 docker/entry.sh     | 16 ++++++++++++----
 4 files changed, 49 insertions(+), 32 deletions(-)
---
base-commit: f05bf111572dc966b3edae183ba0dd595adf8416
change-id: 20250306-contrib-mathieu-docker_multi_workers-038d462cf722

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


