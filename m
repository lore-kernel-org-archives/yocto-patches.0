Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F4ACAC585
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 17:10:37 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web10.163.1757351428361011002
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 08 Sep 2025 10:10:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ytsmDmb+;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B85004E40B52
	for <yocto-patches@lists.yoctoproject.org>; Mon,  8 Sep 2025 17:10:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 878416061A;
	Mon,  8 Sep 2025 17:10:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CB59102F28D5;
	Mon,  8 Sep 2025 19:10:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757351426; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+0QfyZMVdBOg6IiTJ8zSaqSBQPBey3M6H/4ALf7IYw4=;
	b=ytsmDmb+fzRs3oKRn/PC8iuS+jXLHiITNZhug1O6g4JszIm8X7I7Rm4XVxVKbjhDgndfG5
	e0vxbIY7mBID2514POxtbrqxxejOkqSMWCMUkp2xhCa6TwthDBh9yg67C/hp3hziMnog9G
	JmGhxi2OM98zKkGql3K2dlEDRgR/9aiX0KjjSwKq8eCn58ERb7lxAdAwUcovcn+fYZrGwR
	CcuZyWREaU4qTUx+DT2tEDaAJslz8O3zjMpKcVa28sz3xUGlm5lR3NfJm83AZ1992w2rV2
	vca4VoI5owxEP+qLSEswYAi5VloNnT2e6lMABv80pdYlWrZWUD1I8A4nAedMZA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 19:10:18 +0200
Message-Id: <DCNL34O2QH6B.1EA45518GP23E@bootlin.com>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder2 0/3] runconfig: Add
 build configuration as properties
Cc: "Bruce Ashfield" <bruce.ashfield@gmail.com>, "Peter Kjellerstedt"
 <peter.kjellerstedt@axis.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>,
 <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <20250904-contrib-mathieu-build_props-v1-0-0ffaafcd01cb@bootlin.com> <d6f02c8cba213acdce5b0ec41704d265ab5ea9d8.camel@linuxfoundation.org>
In-Reply-To: <d6f02c8cba213acdce5b0ec41704d265ab5ea9d8.camel@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 08 Sep 2025 17:10:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2147

On Mon Sep 8, 2025 at 4:24 PM CEST, Richard Purdie wrote:
> On Thu, 2025-09-04 at 17:48 +0200, Mathieu Dubois-Briand via lists.yoctop=
roject.org wrote:
>> It was recently brought to my attention that the "Build properties" tab
>> on buildbot could contain more data. One is the build configuration,
>> such as MACHINE or DISTRO, the other is about the poky-ci-archive tag
>> that is automatically created on a-full and a-quick builds.
>>=20
>> This series aims to improve a bit the situation, by extracting DISTRO,
>> MACHINE, SDKMACHINE and PACKAGE_CLASSES from the config.json file
>> describing builds configuration, and adding them as build properties.
>> More properties can be added if any appears to be useful.
>>=20
>> It also stores poky-ci-archive tag as well as a web git URL in
>> "poky-ci-archive_tag" and "poky-ci-archive_url" properties, on a-full
>> and a-quick builds, copied to all sub-builds. I'm not convinced by the
>> need to have both properties, so I'm open for any feedback.
>>=20
>> This series has a dependency on run-config modifications, in
>> yocto-autobuilder-helper git [1].
>
> The challenge is we have to patch all helper branches we're still using
> when we make a change like that, which makes this kind of change a lot
> harder to merge.
>
> Cheers,
>
> Richard

Oops, I had the dependency order wrong for a second. So I confirm I had
no intention to mandate an update of all helper branches, but only
master.

I will try to come with a better idea on the yocto-autobuilder2 side, so
it can work both with old and new helper code.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


