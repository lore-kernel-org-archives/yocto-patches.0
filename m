Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDBBD7878A
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 15:17:30 +0000 (UTC)
Received: from goldenrod.apple.relay.mailchannels.net (goldenrod.apple.relay.mailchannels.net [23.83.208.74])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18871.1766157443799494954
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 19 Dec 2025 07:17:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=D421HGpF;
 spf=pass (domain: rootcommit.com, ip: 23.83.208.74, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D7763801624;
	Fri, 19 Dec 2025 15:17:22 +0000 (UTC)
Received: from fr-int-smtpout14.hostinger.io (100-109-2-65.trex-nlb.outbound.svc.cluster.local [100.109.2.65])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id D90A8800C41;
	Fri, 19 Dec 2025 15:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1766157441;
	b=tX3X59LpjcrQ2JFaaTglBM3DcvkJhj8KniB6yG1NWtQbUwYL2TWkaQkMcKbBSN/L93LuJT
	cEyxvpZRGL5Mt6VNuXV1IdhUyVPYOFot/l/LpTQblCDQSwDdVk22vJx+pvMPkhq/hOk9Is
	7nNulPEdaUT2qaQmUIqeSaph0cVi92SGhHgPAMDszQBjFYQ4nSiOlRWqXoCvQ5O1WJT390
	xCSsD07gkc2P0+snN2184GO3RsJ/7HtWRJ3g1hF+v2zISDK+ecTY76+6kV5vjXt3UaEgGp
	XQPn+N6otG0+8MJhrkRF2ddQlIGr/SbZ2Ittb4ATp5zhdLgeX3KYmaoGt4p4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1766157441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bixQ/qGojkB8LVWtfHnwjECgCwY0zaqjiIwbjpXvRaA=;
	b=oa5xYlfMmJhpQNgW5YV9HWGnZ6DyKB9s5irNYUs1KGMhtUsT/uiyz2YJ2M+a9by3IJeaCk
	BtASvFbsGz4rTFfJrtbW7RKQPQxw8W4dA4XYjjpd+5t88TwpyxFWHZ7nz24vv0LTYVS8HZ
	2592F7MVxW7hrpeJh3JGR5ZG9pEbFguXo7JHMG3KQiGfNypGZa683Jq5CYdSJETBen1Go/
	z33eJ3QbjWaYn/nhFyT9DGg4DspBKGMXhBO66jdkyN2Q1QN/K1NDtXQjcJOaWmcBylJLtj
	soUOxlxjiaCNXGUynE4UvvlQuRVgSukfu3AcvR8pxq/DiYBLkPk7S3qQrANr7w==
ARC-Authentication-Results: i=1;
	rspamd-78fcb7d87f-76lz2;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Good
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Glossy-Harbor: 5b3f93e11d4c3490_1766157441564_4131693214
X-MC-Loop-Signature: 1766157441564:2524922239
X-MC-Ingress-Time: 1766157441564
Received: from fr-int-smtpout14.hostinger.io (fr-int-smtpout14.hostinger.io
 [148.222.54.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.2.65 (trex/7.1.3);
	Fri, 19 Dec 2025 15:17:21 +0000
Received: from [IPV6:2001:861:4450:d360:b6c6:22ca:202c:384c] (unknown [IPv6:2001:861:4450:d360:b6c6:22ca:202c:384c])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dXrk65dnSz1xyP;
	Fri, 19 Dec 2025 15:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1766157439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bixQ/qGojkB8LVWtfHnwjECgCwY0zaqjiIwbjpXvRaA=;
	b=D421HGpFQDqvPWHAGp+ZAQvnngjyhbMfrfK9Qp3yEVVjxtZa+rofvkdz75xJdlRYBPjVQN
	emX5CJX8BWWlV/kY9yqM0rKcpzoSOlMR+Dg6qkmxU7RzptHMKJW0i5ruS8QLxbO9c21AB6
	4nyyg/A+qLCG1eGcoLUQsUlkSlPFg/ogNLrVEoqzwJbjIiaPEDOr+znhlbUNtWMdzKu7MU
	vrk7zs9wjEEwQTbHZqPEMrW510pRq1afK1A8Kgsva/xjSvlVJp9u6lUs+bo+yuBT07lRt9
	2xK+5upBo3Sx1OIU5qIM9AMqd2Tf/QjDP2LNtOYejqmdiu4x4nP1xlp219L75g==
Message-ID: <add50e10-f93c-4124-a9b1-caaedf60dda7@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] tinker-board-3: add
To: Quentin Schulz <quentin.schulz@cherry.de>
References: <20251218060321.2194839-1-michael.opdenacker@rootcommit.com>
 <026999a3-ef46-4590-99ab-bbd8fbb0affc@cherry.de>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <026999a3-ef46-4590-99ab-bbd8fbb0affc@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Date: Fri, 19 Dec 2025 15:17:18 +0000 (UTC)
X-CM-Envelope: MS4xfAsk9yh1+yY92EW27R6/autZEY6xdj/4mXr4Cwwmmw3ko26h43GT4uFi4Dj9tZ+mICRRD+NRmWhyLvIUZimCtGuCscTCiIUqAb39Vv93iza0lMdYemDp FJ/aCgylwN9tGnesR4BVPXT6SzJvIGmJuLsSybMjhy2EFsR8F+6LVGdQpu0lHGLULq2ONU56PJjPduXPccy4VcTl/WDjfdOpVYnCf+InQt9f74li5NubP9tp nT0PDDTYnNWH4Z6TqqODY4E0x8jsDs5n6rQXIJ41+cVJQZ2vwfHpFBFWQ/BDFW9AYhCTvaq1SirF3QSUrqYEMYLjZM9GcIGR2J/GOa1+tiL/HYQbSS0p6d1T IYYs+U5w39/PtCiUjw50E6LkmalSWApODNutqNN02OBT/q9Dk+H3k9CsVa1oU4Ur3sWi+Uy8
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=69456c7f a=dqk5TzrUznxRrYcIKFAfaQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8 a=d70CFdQeAAAA:8 a=_oUSXZN_6neA2UNA2EQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 15:17:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2835

Hi Quentin

Thanks a lot for the review, much appreciated!
You're my top (and favorite) reviewer :)

On 12/18/25 11:46, Quentin Schulz wrote:
>> +# Kernel provided by https://github.com/betafive/meta-linux-mainline/
>> +PREFERRED_PROVIDER_virtual/kernel =3D "linux-mainline"
>> +PREFERRED_VERSION_virtual/kernel =3D "6.19-rc1"
>> +
>
> Not sure we really want to do this. Maybe wait for linux-yocto-dev to=20
> hit v6.19*? We used to do this for some Radxa board in the past I=20
> believe.

Understood, let's wait for 2 more months then ;-)

>
>> +MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
>> +
>> +# U-Boot doesn't support Tinker Board 3 so far
>> +# but boots fine when configured for a similar SBC
>> +UBOOT_MACHINE =3D "soquartz-model-a-rk3566_defconfig"
>
> Can you maybe try generic-rk3568_defconfig instead?

Excellent, it works!
And instead of displaying a wrong board name at boot time, we have=20
something correct in U-Boot's output:

Model: Generic RK3566/RK3568
SoC:=C2=A0 =C2=A0RK3566

>> +++ b/conf/machine/tinker-board-3s.conf
>> @@ -0,0 +1,10 @@
>> +# Copyright (C) 2025 Michael Opdenacker=20
>> <michael.opdenacker@rootcommit.com>
>> +# Released under the MIT license (see COPYING.MIT for the terms)
>> +
>> +#@TYPE: Machine
>> +#@NAME: Tinker Board 3S RK3566
>> +#@DESCRIPTION: ASUS Tinker Board 3 is a Raspberry Pi like SBC based=20
>> on Rockchip RK3566 Processor.
>
> s/Tinker Board 3/Tinker Board 3S.
Fixed, thanks!
>
>> +
>> +require conf/machine/include/tinker-board-3.inc
>> +
>> +KERNEL_DEVICETREE =3D "rockchip/rk3566-tinker-board-3s.dtb"
>
> Do you know if Asus has provided a way to know at runtime which of the=20
> Tinker 3/3S is currently running the software? E.g. via a GPIO or an=20
> ADC channel with different voltage values?
>
> This would help us only have one machine for supporting both. In=20
> U-Boot, you'd do the auto-detection and load the appropriate device=20
> tree based on that.


I don't know, but I can investigate. That would be useful indeed.

>
> We also need an entry in the README for this newly supported board.


Correct, fixed.

>
>> diff --git a/recipes-kernel/linux/linux-yocto_%.bbappend=20
>> b/recipes-kernel/linux/linux-yocto_%.bbappend
>> index 2dba3d7..684d33a 100644
>> --- a/recipes-kernel/linux/linux-yocto_%.bbappend
>> +++ b/recipes-kernel/linux/linux-yocto_%.bbappend
>> @@ -30,6 +30,8 @@ COMPATIBLE_MACHINE:rock-pi-e =3D "rock-pi-e"
>> =C2=A0 COMPATIBLE_MACHINE:rock-pi-s =3D "rock-pi-s"
>> =C2=A0 COMPATIBLE_MACHINE:rock64 =3D "rock64"
>> =C2=A0 COMPATIBLE_MACHINE:soquartz =3D "soquartz"
>> +COMPATIBLE_MACHINE:tinker-board-3 =3D "tinker-board-3"
>> +COMPATIBLE_MACHINE:tinker-board-3s =3D "tinker-board-3s"
>
> NACK, it isn't supported, you said it yourself.

Yep, see you in 2 months for a V2 ;-)

Thanks again
Michael.

--=20
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


