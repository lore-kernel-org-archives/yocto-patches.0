Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D71AD68BE1
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 06:10:12 +0000 (UTC)
Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35449.1766038210827137635
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Dec 2025 22:10:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=MLUe2daz;
 spf=pass (domain: rootcommit.com, ip: 23.83.218.246, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5AF5F761F56
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 06:10:10 +0000 (UTC)
Received: from de-fra-smtpout6.hostinger.io (100-109-39-174.trex-nlb.outbound.svc.cluster.local [100.109.39.174])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 877BB761ECF
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 06:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1766038209;
	b=UONEhhWpgz0MF4MigghTZLgMFaE1iA9zghHmPyCqw+L8L0sKsItb4vLZnmXRlOXpFMCYWj
	Vg9Dn304bngBMYDpG2DpkkOIn7XFoiPq/2Ff8mbXfkosk0cX5wiNHkvM1AyTeuT3Kq3fD7
	2dWVM4lzb9QIVhBJB9HLfd+xLVKOdPL168X60YgcvCnZ5eT0gfrxyC1cQMp89IrnbYvVpp
	BWaqhlE2pBZ+aja8oqUnXekUORO8nU3F+Lz3f8P5VeF8oiT0VHUTu1mVbU3/zX6QhRE0/V
	+33znU5AGLwHPuK1fU6hG1FoHUABU/wt7jgW3g1I7OLdF1AARlBokr5PPLl0aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1766038209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nKukG+KCP4sO8RzNR0bDZnjn3VuBo+dTJXxh/eojIk8=;
	b=JFOrOrlsflglGCcm/SWG+jMEDc3/Z6kwcf38IklGYdIfT0WaHlW58XcBmCI83lnIzMm2jn
	u65mu1A7LwWCF5t5KE1iWzf2AjuytEt+4HTo0TCW3YQP0WDDC12b/1RPQmLznkqAR/YUd3
	Pp1KUsdn0JJkLbJMzkfTgrUlNLJ92Tzr2/rsqlgBe/geWhoo8fYD6ff9Mff0/TjmTRPLek
	gankDQCt1UvTl4qGNZmJ35zXEFllpMXbZSk0h68VWh6PMDyokMKk+7QuEb2o+HZr45iAyA
	lSo2cuZtXasd6xnW4JsrRrnZ2jaIaw7ht+v47TZQVb7CvQczWCpTNP3jsQ5rww==
ARC-Authentication-Results: i=1;
	rspamd-6ccd5b4cc5-52bbd;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Minister-Eyes: 4076a60d3d7c635e_1766038210116_389396285
X-MC-Loop-Signature: 1766038210116:3135032052
X-MC-Ingress-Time: 1766038210116
Received: from de-fra-smtpout6.hostinger.io (de-fra-smtpout6.hostinger.io
 [148.222.55.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.39.174 (trex/7.1.3);
	Thu, 18 Dec 2025 06:10:10 +0000
Received: from [IPV6:2001:861:4450:d360:6f03:783f:9b5b:57c1] (unknown [IPv6:2001:861:4450:d360:6f03:783f:9b5b:57c1])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dX0dC4VWJz3wmS;
	Thu, 18 Dec 2025 06:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1766038207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nKukG+KCP4sO8RzNR0bDZnjn3VuBo+dTJXxh/eojIk8=;
	b=MLUe2dazLp4hYmdjL93dWNYkmQkI5VoBgskG5ryBY/itU5Qu6XsNTPiTwNg8/bUgn+A6Uc
	HP9m7wegorSd3i8RKt0P7kYPbs823qeq/ziBjHNGnVvPY5PI3y3VRK9XBonckTdLJX+yDz
	Xv02u40q5UQLV06l2++7cDTgGixypYnHdf8lcCPsOLWa1goP3TcQljRyKCLNGNqvdjWuU0
	6rIBBtUSiXravcCmP4q8MlHD4+z6d0PrnGMN5kvWgxoedQ3oay/crYmbPp4agYIRhYIutO
	PvDq3yDGKi1SZwNkuVoTxPf/5Err52bIS96r9N4bC7l9vvDbXymb7Q8MjCYbCQ==
Message-ID: <38a42c2b-3025-4516-8aac-c9136ee6e55b@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] tinker-board-3: add
To: yocto-patches@lists.yoctoproject.org
References: <18823A0A6BE7E236.1506149@lists.yoctoproject.org>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <18823A0A6BE7E236.1506149@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Dec 2025 06:10:07 +0000 (UTC)
X-CM-Envelope: MS4xfMwM/LqNtglCFrwM8KXu0EaQAm0W46JgZ8ksHN5c3VK/EI6Qz0VRPSXcohp76xICcTiID2ES6uFaisDHyn7WT49+z2BUjOtlyW3AjspE+hNTvfy1JCDD gs0H3583XOdDKfQD2wH06aQVXUusxUhqzI5qdF16VKtrxHsokzsHFTmICcEMLqwRWfpQRKXjegSPIpoIxNySlDSnvjIKtLMyoMH1n6TXB5efmdapQ7IXr9xo rOhtG33jPFGA/q77xxoH8PzTBc1HrK7Kkla0M68ISj0uxuuE0NfOllNkA1hbicjoyvqFmclTLbz48wZVLSU6eJU8Z9bY5GL0svUtV9CVxnZE81h0nIkbCsiv 3nv9y3shKadZW3zYWpqxbX10VJBkTYEKcC+cWQawdXCF690To4s=
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=69439abf a=TJDTwvido1ACHfu3sFfMdQ==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=d70CFdQeAAAA:8 a=iGHA9ds3AAAA:8 a=RAwSPnCn06-KmIGCFX8A:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Dec 2025 06:10:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2814

Greetings,

On 12/18/25 07:03, Michael Opdenacker via lists.yoctoproject.org wrote:
> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>
> Add basic support for the Asus Tinker Board 3 [1] and 3S [2] SBCs,
> with the Rockchip rk3566 SoC.
>
> Support for such boards was introduced in the 6.19-rc1 version
> of the Linux kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f80b3952318d7ef18573a5010f06118602f992e
>
> Therefore, the https://github.com/betafive/meta-linux-mainline/
> layer is currently a prerequisite to build images for such machines.

Is it fine to require an additional dependency to the 
"meta-linux-mainline" layer here, as Linux 6.19-rc1 isn't supported by 
linux-yocto-dev?

I could add a machine dependent string to LAYERDEPENDS_rockchip, but I 
don't want to pollute conf/layer.conf.

And it seems BBFILES_DYNAMIC is for recipes only, not configuration files.
Thanks in advance
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


