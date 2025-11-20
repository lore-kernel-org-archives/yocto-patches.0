Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA3CF8844
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 11:57:45 +0000 (UTC)
Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32564.1763639863268209540
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 03:57:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=Qj4XXPF4;
 spf=pass (domain: rootcommit.com, ip: 23.83.218.252, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 934CB121354
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 11:57:42 +0000 (UTC)
Received: from fr-int-smtpout18.hostinger.io (trex-green-9.trex.outbound.svc.cluster.local [100.127.179.109])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id E1072121166
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 11:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763639862;
	b=sr1ekTXdXO9qhomXtI2tYmduRBPzCVYJGbBivyT+GnWriA5DLAQdj+oVvfzZFT3ZE2MfZS
	4SQOMVNzeg6sRIMckDFXukWO1tAAqiv2qCxaPu2AARb4dsWgxIoUAiXmD5eic1DAi8K6pJ
	EmqYLZc7z+w0X1uWH7iJNKJXP5KoFb8fmmAtDncY7uGNlF9nvGu/ix4NHPmPTtLCxpjjBr
	3se2aU/T0Iu2J/00+2LqbfrvXD6BsnHUmSnHhfRdJ9/jZGvQtqtDgZyPFVmd3bEh+t27fG
	fKL0QzN7sdn1HDljTVhHaX/s7k3q/APHBSIqBGHyAuGC2eLM41NgGku92s7WEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763639862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=V7Jd5GR0w9yza7bUjkQwHa3Sxxobe1vro8DhtmskvlQ=;
	b=zngZjg/0p4+V684GANtVX2cwTqYIsMKXhIB6fVYD0eyN5ktDXpbtzp4n9KmKjPqSZ+FFeB
	5kURTtsmZTO3sC2CeNyFiFas4/DVPFNkYtdqNv3B4RW/PkpRQYQVrk4+V9ofCSn39pkvpy
	UGY//oUVNwTH0UPIsE811U2WcdkKvrliKwK2yeiISY61fH1APSaImct13xUB0lPUmwNXiq
	fehbNEjdZ4ErRfRIpYjkFisOp/FXA3/4jc7GJVB3PrXlFM89gxpyOkHdqFTIhUpCsoN+iN
	sJLs62dQw8uZ80g1xuoz7q2QhCefUkGlsQssPk1RyWbRen0j5QWE5sYt9+OtvQ==
ARC-Authentication-Results: i=1;
	rspamd-55b59744f-bwz9h;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Minister-Wiry: 67aa0c42202525b3_1763639862447_1460373149
X-MC-Loop-Signature: 1763639862447:3273067806
X-MC-Ingress-Time: 1763639862447
Received: from fr-int-smtpout18.hostinger.io (fr-int-smtpout18.hostinger.io
 [148.222.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.179.109 (trex/7.1.3);
	Thu, 20 Nov 2025 11:57:42 +0000
Received: from [IPV6:2001:861:4450:d360:a066:6d43:e556:60e2] (unknown [IPv6:2001:861:4450:d360:a066:6d43:e556:60e2])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dBxfy602jz1yT3;
	Thu, 20 Nov 2025 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1763639851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7Jd5GR0w9yza7bUjkQwHa3Sxxobe1vro8DhtmskvlQ=;
	b=Qj4XXPF4pYjUfoC9/hIZPcq/Sa2ckQ1jaHEhkDr24jv1LZCUk+EgACvIIYeFoStBQ1vUXu
	khgPVzN8Pqnx9OMm9Tvd3PVTyHMWnVWCUDS/Rr4Q9JJvsbHph1EpJe1Lc2NkS23jR1mulx
	3z6mHZiU29OYd2BZorwzrh8RV33kXj/bvMm3Z33o6g3K3W5Tef/6qBzedUeRV7hoKADoE4
	r/naL0IPevmJD/8H6GWH+wMS8sLmAAcAfvvoVwTfeSQGbNINCxImqLKllW+cUJpS/cRCu5
	GhZtno9VRSlMw03iQvwaTMoo4fmBOYFi7qB6N2eoGuN5gdX9A31T8O7pGdQ5Sw==
Message-ID: <8d9d5a5c-6d8e-4063-81b6-134d777843f1@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com
Subject: Re: [yocto-patches] [PATCH meta-rockchip] orangepi-3b: add
To: yocto-patches@lists.yoctoproject.org
References: <20251120-orangepi-3b-v1-1-3d31722d6fef@rootcommit.com>
 <71898d93-c240-42be-a1b2-42ac1e5b854b@cherry.de>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <71898d93-c240-42be-a1b2-42ac1e5b854b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Nov 2025 11:57:30 +0000 (UTC)
X-CM-Envelope: MS4xfOgTBrNgZt8VvjMVec1wdGfW8IR81asbnXvgFWf4stYj7WaAtJwFe3zhyYpDav7wssiHFErPhM+BQlXZlZYyPzd34NXCX4GNb27rEi9K3mWC9W3wMUrB Ec7EPkdkM6E4tz5XbKfkGoG/AuJ/P3iGAc6Q+y+ICSn/mhulxYH6HSO+hpCmOIDIO+jyFrK+GGK57km2WRfNW/PQpi72yY8E9eNdB7AgZRDkP79ZQ9M/RkbM BkUnnu/NGzm/N/EiZqrv+nN5VDd2POU4ecPn/2GlxttkeZI/q7EJZHiLwVr6jy6fih6SKaWJgO/sJyUfTSQKvmZ2VRWorxtAUwXg9bcY1DSGZa+U7SL7XOrt 3oFQyvZFAT8EDzx7WRzI/oyFNw+HpL+cOcdCGtUZ72/LhrPx7hY=
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=691f022b a=l2urqJcD81kOlpy6CkxEZg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=5dAzR5NRAAAA:8 a=d70CFdQeAAAA:8 a=iGHA9ds3AAAA:8 a=kw2uuM4Qmaw6E2AY4mAA:9 a=QEXdDO2ut3YA:10 a=tFHjQltceoMA:10 a=ZKAZAlVgJm32z6MX8p4a:22 a=NcxpMcIZDGm-g932nG_k:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 11:57:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2627

Hi Quentin

Thanks a lot for the review!

On 11/20/25 11:35, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Michael,
>
> On 11/20/25 11:25 AM, Michael Opdenacker via lists.yoctoproject.org 
> wrote:
>>
>> +++ b/conf/machine/orangepi-3b.conf
>> @@ -0,0 +1,11 @@
>> +#@TYPE: Machine
>> +#@NAME: Orange Pi 3B v2.1
>> +#@DESCRIPTION: 3th generation SBC designed by Kunlong Co.,Limited.
>
> Not sure the board identifier number really is synonym of generation. 
> In any case, should be "3rd" I guess :)


Oops, indeed!
I just imitated the machine file for OrangePi 5 plus, which claimed it 
was 5th generation.
I'll remove this mention of a generation which is indeed dubious.

>
>> +#http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-3B.html 
>>
>> +
>> +require conf/machine/include/rk3566.inc
>> +
>> +KERNEL_DEVICETREE = "rockchip/rk3566-orangepi-3b-v2.1.dtb"
>
> There's also another device tree in the kernel tree for an earlier 
> version:
>
> rockchip/rk3566-orangepi-3b-v1.1.dtb
>
> I think we should probably also have it in KERNEL_DEVICETREE.
>
> Looking at the U-Boot code, the bootloader should be able to load the 
> proper DTB based on some runtime detection.

Very cool, done!
This looks like the best way to handle this.

>
> In which case, the NAME part at the top should simply say Orange Pi 3B.
>
Indeed, fixed too.
>
> Otherwise looks good to me!

Thanks again.

A V2 is coming soon once I'm done testing.
Cheers
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


