Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52139C021AA
	for <webhook@archiver.kernel.org>; Fri, 21 Feb 2025 11:09:13 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.20793.1740136145529383924
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Feb 2025 03:09:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=T1aJdcUV;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 155F843224;
	Fri, 21 Feb 2025 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740136144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gaD4CJTKo1q3DRUVchn41qcMKVFZ9mca0eV5iq5maI=;
	b=T1aJdcUV/4+dv2JDcs83a9qfvvi2w3IKW/7X07BctfIHDDCdtbvwWZQO8cwHRQwYEhShsR
	6QhoefWagdfPoFkEaKB7tIuJf/o8uiRKXQVKTrK0z7QHU/wpNx8LgXHd58u2o147n0NMHo
	s7yPt2C7KfCPrS3nZ/FpewIS/C/x3CTaTY2BoXjbEkmBxSirBsRheamzOuYSEgldwShmmJ
	7mY8JbxvyjQo3w8FwhCqWtXyn/Tr6wFd5RDuooF2LCL1KLJSeG6b6sQMQMxITlmfspgulF
	HYoFryu+RTeTQy2An0TMyhIjk6WN7eyIbMCIm0c6LxyyxiSetux+BIkZW6xZ+Q==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 21 Feb 2025 12:08:36 +0100
Subject: [PATCH yocto-autobuilder2 3/3] releaseselector: Fix selector not
 applied in some conditions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-mbria-release_selector_bugs-v1-3-13d166ff0ca1@bootlin.com>
References: <20250221-mbria-release_selector_bugs-v1-0-13d166ff0ca1@bootlin.com>
In-Reply-To: <20250221-mbria-release_selector_bugs-v1-0-13d166ff0ca1@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740136143; l=925;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=iOc9zdICGQNJZqsQMYH5rHZV/iX/KXrOmsOCMVVRaVs=;
 b=r2tcvRXelTGwVy3NzVksCJN8mlCfNyBzSfHwhK6ftYr3UPE+Vp5MSG80RLpBBvbvnzX237iEy
 nm/NP1wg758B4qwqWPdttngIJDZQybiQpfV4axevwz7gyPqGeXcxBbW
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihohgtthhophhrohhjvggtt
 hdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Feb 2025 11:09:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1115

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 yocto_console_view/src/releaseselectorfield.ts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/yocto_console_view/src/releaseselectorfield.ts b/yocto_console_view/src/releaseselectorfield.ts
index b330c4cb2ad7..93ce46382f95 100644
--- a/yocto_console_view/src/releaseselectorfield.ts
+++ b/yocto_console_view/src/releaseselectorfield.ts
@@ -144,7 +144,7 @@ buildbotSetupPlugin((reg) => {
 		const prototypeDescriptor = Object.getOwnPropertyDescriptor(element.constructor.prototype, 'value');
 		const objectDescriptor = Object.getOwnPropertyDescriptor(element, 'value');
 		Object.defineProperty(element, 'value', {
-			objectDescriptor,
+			...(objectDescriptor ?? prototypeDescriptor),
 			['set']: function(v) {
 				const realFunc = prototypeDescriptor['set'];
 				realFunc.call(this, v);

-- 
2.39.5


