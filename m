Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD813C83F09
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 07:15:42 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.9615.1752045336286231547
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Jul 2025 00:15:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=U03xb6+l;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B04D4437D;
	Wed,  9 Jul 2025 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752045334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g27oigGQyoHY6jYg6LGuJvroYYUD5NZWoE/rwX7lMoE=;
	b=U03xb6+lHPVCMdoU/rtuB+AG5DF4eA3WfDASQcX1Q1Vow4y2Go5AMBcxK+2WTO69pGnLyc
	NLkYSQ+UPp7QYmmvCXx1z/G2FyfjfKJuSxmKnfAp/8CSY222T0dk5VQ+B0gnBgLsDRUv44
	r5n0WcwXTpW/Of47aZrF86yxmB2VimBWD8zR7MaaylgO4kcjI25WPBnMNI+SCPOkjQv4UO
	7+uRGP/I0wVjiwt/s+DWuEQPduaiohY36L16yyjC6ki4u3amJD1U6KmXqfFG8nJ5r/L2Fh
	iLMM9dOGaGgDh+sLNcw3i3XAyh1NZ1d86+FFYZ8znAtApT3lmqJASlUQP5/cuQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 09:15:34 +0200
Message-Id: <DB7C8J07Y9GO.25OVHBHK1Z0G0@bootlin.com>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>,
 <yocto-patches@lists.yoctoproject.org>
Subject: Re: [swat-tools][PATCH] Add a parent build column and filter
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
References: <20250620-parent-build-filter-v1-1-4ddd7b3207c8@bootlin.com>
 <DB6PVF3X5TB3.1RJMGWID88B8R@bootlin.com>
In-Reply-To: <DB6PVF3X5TB3.1RJMGWID88B8R@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffhvffuvehfjgesthhqredttddtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelkedthfeuieevjeeihfdtieethedvhfdtleegiedvtdfgheehleekhfefveelfeenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeftgekudemvggsrgejmedusgeksgemrgehtgelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfedprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprhhoj
 hgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 07:15:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1788

Hi,

On Tue Jul 8, 2025 at 3:44 PM CEST, Mathieu Dubois-Briand wrote:
> On Fri Jun 20, 2025 at 11:08 AM CEST, Antonin Godard wrote:
>> To be able to filter failures by parent build number, e.g. filter all
>> failures for a-full build number xyz, add a --parent-build-filter (-p)
>> option to swattool. The option can be passed multiple times and can be a
>> regular expression.
>>
>> It is also displayed by default in show-pending-failures, after the
>> column "Build" as "Parent".
>>
>> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
>> ---
>
> Hi Antonin,
>
> I really like the overall idea, but I believe we should also add a way
> to identify the buildbot instance this build number belongs to. As the
> build number is not unique across different instances. E.g. You have ids
> that can refer either to builds on valkyrie or typhoon.

Indeed I did not factor that in when writing this!

> On the other hand I don't want to end-up with overly complicated ids, nor
> overly complicated logic here. Maybe we can just use ids such as vk/1234
> or tp/1234 and have a built-in list of known buildbot instances to do
> the association.

Maybe we can default to the currently active buildbot instance (so no vk/ o=
r tp/
prefix, just defaults to valkyrie). The prefix can then be added if needed?

> Tell me if you want to work on it, otherwise I will try to rework a bit
> your patch later this week.

I can try but I can't tell you when I'll have the time, especially this wee=
k I'm
pretty busy, so give it a try if you want and CC me in if you want some
feedback. :)

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


