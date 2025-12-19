Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC1D7495C
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 06:34:27 +0000 (UTC)
Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11785.1766126059736265318
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Dec 2025 22:34:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@rootcommit.com header.s=hostingermail-a header.b=VdjE9vkC;
 spf=pass (domain: rootcommit.com, ip: 23.83.214.25, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D0DDC720F81;
	Fri, 19 Dec 2025 06:34:18 +0000 (UTC)
Received: from fr-int-smtpout12.hostinger.io (trex-green-8.trex.outbound.svc.cluster.local [100.102.180.166])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id ECFB1720BD7;
	Fri, 19 Dec 2025 06:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1766126058;
	b=dxkhzFzhEzXjhOouhsfAKho24ZYr6rscdjd49CVNs4P7uZ5EtzeJSc77cS4jCyYQtkRjr5
	3aG/UtZhbPl2y7/3Mqx5Er5HyO4ROcRjyqLrqB6WjquPGqkIqtPzV/LbSRZ6YH6Wv0uelw
	ssxt+MPFJLHYjRp8yhOx9VlHTAHHBsQeAPb4HsIlqoXQzCnEXNDA/FP5gR2BvwuH4Z2kO9
	Vkk96/ux5bYhJzy5zPOPWNJQ3MVpTWplkyyV9IGQJYMp6gAP+YkADNhsvgRP03vAdAvSP3
	3VkA4ZkhNVswtYUkFbrQWw5azm4X2zU/PPickTDBHUXjuVf6Udwf1vuf93j15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1766126058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dFwPPXufBGX7VMYG7ThrohQrOca9GgDXS+G8XNueQEY=;
	b=B99PutymaOZa9FjRr5/9taNkob27tx1L9cOXxSZYldJ90Ob5yulbby+kUwwjXw1AROFXF6
	e1hh5GHLagvqbjbinA3ncfYUElrhR9MQNfESKi9XV00Ig6i7nPk85iW5cN+m2YZow0TQyL
	Ny8IFEIQqlNSchzfIOZ6gMujX8V9n+Bwnb04eGA0J1ScjoYmN2tFHN3T1WJ3e0a4zJGPgM
	+O7cPnrxDII55G85ExCqZBqinzLJf/rx3eBYFjKgye32fCZljJd/23H8/uaz+tz6LsLP26
	QQdrcfLbhDJpQcI8gx2xAn3cA9xL7/jWBcYUrV4+11EZslFQqFzIayVXHOEyow==
ARC-Authentication-Results: i=1;
	rspamd-547f5d9dc7-lf8fq;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Rock-Battle: 5c0314fc3152ed7c_1766126058655_1747641395
X-MC-Loop-Signature: 1766126058655:3885057504
X-MC-Ingress-Time: 1766126058655
Received: from fr-int-smtpout12.hostinger.io (fr-int-smtpout12.hostinger.io
 [148.222.54.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.180.166 (trex/7.1.3);
	Fri, 19 Dec 2025 06:34:18 +0000
Received: from [IPV6:2001:861:4450:d360:acbc:85c8:6fe1:767c] (unknown [IPv6:2001:861:4450:d360:acbc:85c8:6fe1:767c])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dXd6b6Xh2z1xpD;
	Fri, 19 Dec 2025 06:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1766126056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFwPPXufBGX7VMYG7ThrohQrOca9GgDXS+G8XNueQEY=;
	b=VdjE9vkCLm38CXF6jBNLo4oj3T5ajhHcDq84s4y9EzX74yhNg4PxY86xI/J85V/YOc6M3R
	YFJkmV4m4k0944S82NDk5saXZO9VoAtoW9qeqaCW08mzK28g5prYmuZci/kpKRjEP8/v5w
	Q3s918Lrtmr+pxTpw3H7kPqn6igW5Fasswok4dHHJgvCC2xpxkN6oDHHpEAZ7pFUdwFFdu
	+F4mM6Q/brkCf5V+PoA9HbHG6+NSc+vPYOpTtIU3jY+Mt+9GLnMg9V47PMFoJeSbAwVa6t
	kivUbi8eScxqh++shZ+qTaBp0CeId5WBEQhrmCTEIz+HSia9UV8oh//ISSxdwA==
Message-ID: <2faed21a-9745-4f67-a2de-efe1f56c4141@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] tinker-board-3: add
To: Trevor Woerner <twoerner@gmail.com>
References: <18823A0A6BE7E236.1506149@lists.yoctoproject.org>
 <38a42c2b-3025-4516-8aac-c9136ee6e55b@rootcommit.com>
 <20251219025010.GB5613@localhost>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <20251219025010.GB5613@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Date: Fri, 19 Dec 2025 06:34:15 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=NuiDcNdJ c=1 sm=1 tr=0 ts=6944f1e8 a=3KgNOvecfSDjBda/iPf6Uw==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=d70CFdQeAAAA:8 a=iGHA9ds3AAAA:8 a=h008hTMyyYeqU19Cri4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-CM-Envelope: MS4xfCt4X9Nr9VoL57ibf1SzpATDdQPTjj8ItGY66b2aq9SMfashWYlCbVW1s0ZbgaHbZFXNdQqVpAtXeMcN5EiJJpFD9+DTKExoC1EddWexMRy5dqKeYLeB 2jH+yhfEr2da60APhR8tdbBSan6fNruEmaPBIG7TWQv/j6XQ2zV1bOmwrS+Fl4XYaurpj+hPagKcjW4mSWjZ6i7WE4vuainnpuQwilCYb/GLPe2xqBzEb1jX 3AX8rUQ0Q0NEHlUCeFO63Jh2c2hVx24SRngBj+2VRL1BDQ5xMJjlCiTmfMqeeiIvRwxLX3fIkKwItn2UCaXNOBROxccVhagWgBaS757t/nQ3wwc1VEAyFHCD 5nS/q7s5ME/GkBcVkHOs7YtGT4BGnmbOg2pSZ9rLONnPzuGy08u1AlGvkG0RQwhN+s4e0c8Z
X-AuthUser: michael.opdenacker@rootcommit.com
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 19 Dec 2025 06:34:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2822

Hi Trevor

On 12/19/25 03:50, Trevor Woerner wrote:
> On Thu 2025-12-18 @ 06:10:07 AM, Michael Opdenacker via lists.yoctoproj=
ect.org wrote:
>> Greetings,
>>
>> On 12/18/25 07:03, Michael Opdenacker via lists.yoctoproject.org wrote=
:
>>> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>>>
>>> Add basic support for the Asus Tinker Board 3 [1] and 3S [2] SBCs,
>>> with the Rockchip rk3566 SoC.
>>>
>>> Support for such boards was introduced in the 6.19-rc1 version
>>> of the Linux kernel:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D9f80b3952318d7ef18573a5010f06118602f992e
>>>
>>> Therefore, the https://github.com/betafive/meta-linux-mainline/
>>> layer is currently a prerequisite to build images for such machines.
>> Is it fine to require an additional dependency to the "meta-linux-main=
line"
>> layer here, as Linux 6.19-rc1 isn't supported by linux-yocto-dev?
>>
>> I could add a machine dependent string to LAYERDEPENDS_rockchip, but I=
 don't
>> want to pollute conf/layer.conf.
>>
>> And it seems BBFILES_DYNAMIC is for recipes only, not configuration fi=
les.
>> Thanks in advance
>> Michael.
> As much as I like Paul's meta-linux-mainline (and use it myself from
> time to time) I would prefer of meta-rockchip didn't have a dependency
> on it.


No problem at all. I fully understand you want to keep meta-rockchip=20
clean, and it looks very clean compared to other layers).

This being said, having a board in a community layer like ours is a way=20
to share code and foster collaboration, all the more as OE/Yocto can=20
help people focus on userspace aspects while keeping the early boot=20
details transparent.=C2=A0 It's a bit frustrating to have to wait for 2 m=
ore=20
months, but its not blocking either.
Thanks for your review!
Cheers
Michael.

--=20
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


