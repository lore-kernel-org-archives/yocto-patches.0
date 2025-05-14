Return-Path: <olivier.benjamin@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1CAC3ABD8
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 12:07:50 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.100947.1747224460441171499
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 May 2025 05:07:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Fw5FsZBQ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: olivier.benjamin@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22D7943908;
	Wed, 14 May 2025 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747224458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rNCtZ5/X7Z52l2UtgVIGurppbcbeP5/FbodpxobeAQ=;
	b=Fw5FsZBQdOcwQOygGvPTWXS9fIHLVy2lypr3Pno6ebLBvUhAnaM6VESwttL61kOoIh96H3
	xJFRcjivbUKLYgICvbsEcARvh93sKcRguqFiZVUdSOcqLpPWd59HwpbaDLmPSCImH+Q0iP
	zDVrNSZ6ScqxPE7IzaWyVgf8kOwN9AdNO3CN4Cnk8iOaAO0mH9EG7N4oisN8VrMRcqqkkn
	8p7VtsLU9Ur91/l1zVoEu5B5Zw/fp/pd7Fk01NLk/ohsfdYtPtpr6jHszpNLhKNvy4YDr5
	BUJJBVEQUP6W3upz+LEyr+kKMjS+n2tUn5OmE+uZhlsuR7KTGRvIICqKmTBScQ==
Message-ID: <b953f15e-2b5a-46ca-a427-69483a43f9e4@bootlin.com>
Date: Wed, 14 May 2025 14:07:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [psplash][PATCH v2] configure.ac: improve option
 handling logic
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250513141757.397196-1-olivier.benjamin@bootlin.com>
 <20250514091413.451634-1-olivier.benjamin@bootlin.com>
 <7a817043adcb5421810d800dcbd77ccef071a825.camel@linuxfoundation.org>
Content-Language: en-US
From: Olivier Benjamin <olivier.benjamin@bootlin.com>
In-Reply-To: <7a817043adcb5421810d800dcbd77ccef071a825.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeileehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepqfhlihhvihgvrhcuuegvnhhjrghmihhnuceoohhlihhvihgvrhdrsggvnhhjrghmihhnsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgtdeghedtkeetjeejleevhfekueejtedvkeetgfeiuddttdfhjedvieffteegieenucffohhmrghinhephihotghtohhprhhojhgvtghtrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehiedphhgvlhhopeglkffrggeimedvrgdtudemvgefgeemvggtfeekmedvgegvtdemfhehtggvmehffeegvdemieehkeejmehfieehiegnpdhmrghilhhfrhhomhepohhlihhvihgvrhdrsggvnhhjrghmihhnsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvpdhrtghpthhtohephihotghtohdqphgrthgth
 hgvsheslhhishhtshdrhihotghtohhprhhojhgvtghtrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: olivier.benjamin@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 12:07:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1555



On 5/14/25 12:03, Richard Purdie via lists.yoctoproject.org wrote:
> On Wed, 2025-05-14 at 11:14 +0200, Olivier Benjamin via lists.yoctoproject.org wrote:
>> The configure options currently use hardcoded values in the
>> [action-if-given] branch of the AC_ARG_ENABLE autoconf macro
>> to determine whether the behaviour by passing GCC flags.
>> The issue is, that this branch is always taken when the option
>> is specified on the configure command line, regardless of
>> whether it is enabled or not.
>> This means that the opposite option can never be explicitly set
>> as passing it would match the branch, and result in the decision
>> variable being set to the same hardcoded value as the other case.
>>
>> Use $enableval to set the decision variable to "yes" or "no"
>> depending on whether the option was enabled or disabled to make
>> it possible to explicitly set the default case.
>>
>> Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>
>> ---
>>   configure.ac | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> I've already merged a couple of very similar patches yesterday?
> 
Perfect, thanks for the confirmation.

> Cheers,
>
Have a great day!

> Richard
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1553): https://lists.yoctoproject.org/g/yocto-patches/message/1553
> Mute This Topic: https://lists.yoctoproject.org/mt/113105445/9805101
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/14189878/9805101/580066470/xyzzy [olivier.benjamin@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

-- 
Olivier Benjamin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


