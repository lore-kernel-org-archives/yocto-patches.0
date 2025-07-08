Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BB3C83F09
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 13:47:54 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.19411.1751982470361240127
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Jul 2025 06:47:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=GaiEfmwr;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E863442CD;
	Tue,  8 Jul 2025 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751982468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDbmNj3gdUSDnGBQX0gEH07ttULeApk0ug5YkJGCH5g=;
	b=GaiEfmwrUBcau7FFFEMjSQiNcvH2zQFJr8NjSWyOYQy/vaG51ZGzIzfrXcesqjFKP9wrHY
	QEtqSl+bJ+frMRTf2j75cnkaYLfMPZcSqheAMoreOXGL6K6uFARo4gvLuqUgsmAVQ8OLtS
	cnb61ItvZhVRaF92rtBxsF5BHmsjSOo+6O7GeLh3Vw5SovQafjHpiAteJbPn91CwKA1wXK
	roDtpgfVYml3H79TjC/iN4/DCtlvXxPaPadzzILUxNjEfqaZY03Sh199PZIkJrdx+h4B1F
	cKqUoejOMsa4edjen/xIwY01BQgU6FZMue4y2oXA7RaLbZl//FeDJ4O6mkFokg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
To: yocto-patches@lists.yoctoproject.org,
	Antonin Godard <antonin.godard@bootlin.com>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [swat-tools][PATCH] Add a parent build column and filter
Date: Tue,  8 Jul 2025 15:47:19 +0200
Message-Id: <175198237191.1273441.14070662695899215838.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620-parent-build-filter-v1-1-4ddd7b3207c8@bootlin.com>
References: <20250620-parent-build-filter-v1-1-4ddd7b3207c8@bootlin.com>
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
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 13:47:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1786


On Fri, 20 Jun 2025 11:08:15 +0200, Antonin Godard wrote:
> To be able to filter failures by parent build number, e.g. filter all
> failures for a-full build number xyz, add a --parent-build-filter (-p)
> option to swattool. The option can be passed multiple times and can be a
> regular expression.
> 
> It is also displayed by default in show-pending-failures, after the
> column "Build" as "Parent".
> 
> [...]

Applied, thanks!

[1/1] Add a parent build column and filter
      (no commit info)

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

