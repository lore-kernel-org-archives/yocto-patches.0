Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3C9C02196
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 10:52:27 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.9324.1738752746263481450
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Feb 2025 02:52:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ScGroDt3;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44BE742D46;
	Wed,  5 Feb 2025 10:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738752744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XbN9f6LrXwPnKioiFLzRtFTz9/zv5IM3YtOq9sBtigQ=;
	b=ScGroDt3ENIp7RcUZbGzfKZNmGz6sRrlpOTiBUT+mYAGYw/1g0qLxiRWGJ3RIHhwSwNKcG
	+0QcjHrFjWbrlEtPhJxzyVZPIxCZrZuqcHO0Eg99uXGVMgE9238I2BDQp84ZjiLIfYHOOD
	30JU3wL/YgCzyLmR0cZ+uhNr+uAGQmrDsNtsIyHpsWWs7k5XQC1e193h2HF+l2oIyTI1Dt
	1mfBNYKHrPiWIZwDgRDbcvrbBwVOOq238hZnpUXqmlICe+VrIJZ4poLi8oz1igo9MAC4Uk
	MQVMIuFNVrfGzpbgh+Z0lx6SYiPthnipI9B7vrrKJdXv5H8Db+ktLYKjpH64sA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 0/2] Add docker file to create a local
 instance
Date: Wed, 05 Feb 2025 11:52:07 +0100
Message-Id: <20250205-mathieu-local_ab_docker-v1-0-b1543323b7e7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdCo2cC/x3MTQrCMBBA4auUWTuQRFqoVxEp6WS0g7Ej+SlK6
 d0NLr/FeztkTsIZLt0OiTfJomuDPXVAi18fjBKawRnXG2d6fPmyCFeMSj5Ofp6C0pMT2pHM2Qy
 WhjFAq9+J7/L5n6/wVSqKvhadq8TAycHtOH7TIANQfQAAAA==
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738752744; l=1110;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=xVUY4kK7OPwLuU7tn9zm0AO5jxWCRqpTYjy1b771V0U=;
 b=tFQcDUnM4zgduqNyRyLX6PVMMPA7+oDdL/S8OAA44pTerz/UCJzwPC8GX83OK7WgIEj03xrbp
 OyBXlc3KFsJAuzk8ZuSWihoqOJpiLee68HrtcW9Wl8X6Tit3wDhpJiD
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuedufeevjeeukedulefggeetkeduuefhkefhvdfftdetheeujefhueevkeehheetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmp
 dhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Feb 2025 10:52:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1038

Creating a local instance can be a bit tricky, even using the
documentation provided in this git: using docker files should ease this
process for everyone.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (2):
      schedulers: Fix missing parenthesis in field label
      docker: Add docker file to create a local instance

 docker/Dockerfile                                  | 114 +++++++++++++++++++++
 docker/README.md                                   |  23 +++++
 docker/compose.yaml                                |  36 +++++++
 docker/entry.sh                                    |  23 +++++
 ...builders-Do-not-create-tags-during-builds.patch |  25 +++++
 ...Modify-free-space-check-to-work-in-docker.patch |  36 +++++++
 schedulers.py                                      |   6 +-
 7 files changed, 260 insertions(+), 3 deletions(-)
---
base-commit: 8f6709cf0fad448ea87d80b50cd2ae375e5066b2
change-id: 20250205-mathieu-local_ab_docker-19c03061c69d

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


