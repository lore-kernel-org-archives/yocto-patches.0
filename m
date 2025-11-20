Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314C6CF9C4C
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 16:54:57 +0000 (UTC)
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1264.1763657693419378628
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 08:54:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=dOctarVI;
 spf=pass (domain: rootcommit.com, ip: 23.83.212.16, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 49D1B8A3102;
	Thu, 20 Nov 2025 16:54:52 +0000 (UTC)
Received: from de-fra-smtpout3.hostinger.io (100-98-121-252.trex-nlb.outbound.svc.cluster.local [100.98.121.252])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 24D1E8A14E4;
	Thu, 20 Nov 2025 16:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763657691;
	b=usrkGI6D0RX4PFSU/X2/zX6b8bb6UQfGgxNRezoerwi4QkNCQlNfELhoXd8R2qGMQG4PAU
	E+fx9tqn89t7EcOgrnydiBbHaZ4V4lkxOlwRuY+FCuszZ92OvVHYavSelLlsHk9uZtGTkN
	SBY/A+bkgKYqrioqizmC3RORSY4qL7X/YM6WNv5rhCVxf3OW74p3VzWkJeoWJ5miamploR
	kaLcG2b4vZWIFw4PyOWHGRtcyK+Ad5z7QGZYArUiLZOIIF85+tfX2VVoOMHB/dsiLfzSgm
	E/9p41utr0Dkr8d54iRku47uzapAZo6xQ7+9DYAhr1Y5dK6iRAboMPDuSxNYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763657691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=T7J7ryUUjgnQiLS1TeaHgcSbc5R42bJTjj2eMikeUAY=;
	b=bIsK0FIsywBQFu+MLB4AZadqzJc7eK+qOcai2wtxVnwtN2ASgVV+TnGWMb1X3SIOTIVY1G
	gbiUSxAKd2t6IUouFqyDli5/w76QQfu7ZkBv46YSn/8GJhnPsTFEaSH9YlIyYJOCvp1hnW
	5UKMfACcmWgOkqoXgT/eMC31N3xTNYVjRdwBe74pUhOLIl8tXsKbxr7wTK0/Ij8w5F4b9n
	CAQ2H7hksNpzziqpzgMoKdYAdyuI7J67jofW8JKgOX32Kcm0BVAfyJ12skp9Is/iht1j3F
	UazRaHa+Ev9y86DbX0m9A39WiRXonCh3vyLgeFqtGag8J5C86VJfg7rmuk2sdw==
ARC-Authentication-Results: i=1;
	rspamd-55b59744f-glt8g;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Absorbed-Cure: 21f48aa951c74c48_1763657692037_4254970304
X-MC-Loop-Signature: 1763657692037:3249599790
X-MC-Ingress-Time: 1763657692037
Received: from de-fra-smtpout3.hostinger.io (de-fra-smtpout3.hostinger.io
 [148.222.55.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.121.252 (trex/7.1.3);
	Thu, 20 Nov 2025 16:54:52 +0000
Received: from [IPV6:2001:861:4450:d360:c7dc:44be:8206:c29e] (unknown [IPv6:2001:861:4450:d360:c7dc:44be:8206:c29e])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dC4Fs3Sq8z40Gq;
	Thu, 20 Nov 2025 16:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1763657681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7J7ryUUjgnQiLS1TeaHgcSbc5R42bJTjj2eMikeUAY=;
	b=dOctarVIKrQXB8Fg7Xr0lOxvqBAndA+a+ACNrYr/XcenXH72jalIbhLbXw34FNoARCwL9j
	Gs3xUGYeQlBI7vLoPRz23lrqLIvMG3nAF5CMg4ezlovWrg1d4GVR7nDk48BXsS4wLigtwZ
	2i3WYPwiU93JMaEQFK+wxo/l+WAulPBHtKbYm1LftIdb2vpZcsFWLSpMb1LjCtc2UyGoAC
	KWDtSFxnKScMtUyp3slz60kMajbP6HwB2E1Tig3i2i4PyBpNgGrgIkNKAPvhacbdlxjcf8
	HQUDeiqLlX9mRf1jgjnY6nMqDpPH91Nk1tBQFFJNvk/BurG2v2cWs+RqcMDiyQ==
Message-ID: <ae649aeb-d73d-4d51-8f69-cc6a2c2633fb@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, yocto-patches@lists.yoctoproject.org,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [PATCH meta-rockchip] orangepi-3b: add
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <1879B0158049C4B6.1423420@lists.yoctoproject.org>
 <f176e971-d19f-47a1-a591-d2a501d16079@rootcommit.com>
 <58102c94-8c32-450a-bccf-1edd16bbad3f@cherry.de>
 <20251120-petite-copper-chupacabra-c70e6e@lemur>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <20251120-petite-copper-chupacabra-c70e6e@lemur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Nov 2025 16:54:41 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=691f47d1 a=CjJ265PZljfpLgeKkM6P3g==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=iGHA9ds3AAAA:8 a=x2kahHhQNjU0SA6zWFYA:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-CM-Envelope: MS4xfE5YloqJGyfYjHLEIxWGQ+HVNMbpNCl2wy4KPZaDm2hrKkw2kpclcSGbQHFRNjGQaSqt6qHh9ZZOxGB4Z+OKMfhEVjRxQH/xQBVYdyPLVfZcQgylPUqm ZxZaYlBMv3XeqlC6QzqDMGF9HHnNYk1hXIZOHZxoDEsWI8F0ffvoGuqSGNf+ljSfjswD74oaQqSy58lRrZ8w7Xl1VOMlVyrBf5YW3A4EfR3n10hB07CQSUed scHCruP/mH1kq53AeIz8os1AgvVa3fEYR7eLn7X1pfu3gnKN5CdWhScEQBJLI3vD1ACvanGDr44ZtLsG99pR2tXwQHpmzQyaaCNhgS3NWG/eX3xvMwB0YjsN INbHKLVz2XvoeuZIoyvkm9NnLD8pqyHU/6GYcqvrwA9Ryh4fyGv1myBfLR4A0DWc5CGhA53nx9Z/eVlweEnrL+AkT7172rJwX5VBRnASLfKVMLQllAg=
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 16:54:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2632

Hi Konstantin

On 11/20/25 17:38, Konstantin Ryabitsev wrote:
> On Thu, Nov 20, 2025 at 11:40:05AM +0100, Quentin Schulz wrote:
>> On 11/20/25 11:34 AM, Michael Opdenacker via lists.yoctoproject.org wrote:
>>> Oops, it seems b4 messed up the subject line.
>>> It should contain "[meta-rockchip][PATCH]"
>>>
>> All my patches sent by b4 have the same pattern as yours. Glancing at b4's
>> code, I believe this is how it's intended to work, c.f.
>> get_rebuilt_subject() in src/b4/__init__.py
> I just accepted some patches into current master that should deal with
> [presubject] the way Yocto lists expect that to happen. Please try them out if
> you can.

Do you mean meta-rockchip? I believe I have the latest changes and I'm 
using Quentin's .b4-config file from last year...
Cheers
Michael.

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


