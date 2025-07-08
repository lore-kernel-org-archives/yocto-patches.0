Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA18C83F09
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 13:49:44 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.19287.1751982582202560562
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Jul 2025 06:49:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PVVBNd0s;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 33503204CA;
	Tue,  8 Jul 2025 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751982580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skCEf64d5/W1beiaFdDKT2aY4nYhsXsa2ysjQibRtKg=;
	b=PVVBNd0savnmoC7mGranTVrYNN1/cDotYOsinI09diNnuGB69gl9ByzYu7s7ixZX8/WNNI
	y1tpL/Qsf1/yD2JPuZdDvCHi9F54qeMaiGEJcYXGo5K14sD1S0th4JFk0B3u0b1tcG1cTX
	fbhMEzHeT0B+CS99j4L4JoTUhvq/8WLYBaY7m3ZienqTU+6/4lx3Rq9iLPeSTkkd6oaaUY
	2VJZnbZ9FpsGpczUjLDjr9UFuGDMWAUnOsszgdcsdnxBwPDMLbeUhxHcr3iuZWGk+4xp/p
	Xyiop/K1atRLUE8A8YYKtbD8W7I4StHhN29+PssFDBfxpgwwMkoO4I2//bOrcA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: yocto-patches@lists.yoctoproject.org,
	Antonin Godard <antonin.godard@bootlin.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [swat-tools][PATCH] review: add a confirmation menu before exiting
Date: Tue,  8 Jul 2025 15:49:26 +0200
Message-Id: <175198254533.1273990.964284045024083848.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620-confirmation-menu-v1-1-dec1ab0b9626@bootlin.com>
References: <20250620-confirmation-menu-v1-1-dec1ab0b9626@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepueeiteejgeeifeejkeevveduvdfgiedtveejueetkefhieeukeejvdekhfelhffgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegsohhothhlihhnqdhmrghthhhivghurdhhohhmvgdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgus
 egsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 13:49:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1787


On Fri, 20 Jun 2025 08:52:48 +0200, Antonin Godard wrote:
> Add a confirmation menu before exiting swatool. This way you can go back
> to the main menu quickly by spamming "q", without fearing to exit
> swattool entirely and having to relaunch it.
> 
> 

Applied, thanks!

[1/1] review: add a confirmation menu before exiting
      commit: 1bcc6bfbcfca01ee91eb72eb113293ccdd089459

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

