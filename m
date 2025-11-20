Return-Path: <michael.opdenacker@rootcommit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDACF857F
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 10:34:25 +0000 (UTC)
Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31241.1763634860786597845
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 02:34:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@rootcommit.com header.s=hostingermail-a header.b=NwPknAi/;
 spf=pass (domain: rootcommit.com, ip: 23.83.223.141, mailfrom: michael.opdenacker@rootcommit.com)
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 050164C1B40
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 10:34:20 +0000 (UTC)
Received: from de-fra-smtpout3.hostinger.io (100-98-37-83.trex-nlb.outbound.svc.cluster.local [100.98.37.83])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id B41DE4C15F1
	for <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 10:34:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1763634858;
	b=tdXBXprtotM5/4anAAg9IbcOCMd88EToTvXtvyZUqqMqbEl2YJdVg58Zoah7tCOENatGsh
	iOt5621OjXXg0ZqjZ67Mdd3LRsIGJH3ArHKxp6bdSXw49agT9liRcuIMtheM02tfHVsFxF
	e92esThHokFg1cLoliCG5PmP4BKMk3A44ETjjXjpY2dei4owCeCJaZR6+pZbo/D7KIffoI
	kmFGGvJjm7vo4M4a6cVrTH61Ip7CBccVgyt/7idS4qQPSPlghd2a4MnBLHRb7Vto3aTpBE
	M+0GQoa3kL3mbxTlmZSrxP0brz1togqAv19oB3Z/YhjgPL8wyYe26XXoovBGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1763634858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=BlF/rfZzJsKOuIZxeAHKJw55Yi0HEvzWbVBg6BrsgRI=;
	b=K7P7YozIQbnjjSnXh4bOmAm2eO6SjzNYoWNtKlplDZ9kaEjIEiHfgyVzXnoosp4v5BFAx+
	83IzrQ2PEzvUI/GyUBrMTWOASowRSfShiIbcqiZD3jyp8ClIwukxw01C0joXEgZql20M/o
	FuQs121LKHw0nlw/llriX8MMQo/pSJXlVXG9BzCHbgRWHMZd5BJkLA08gVs2/wjt5Fpvup
	1cPa4+UoJdqSJ30Gd7myGiG23fP8Ygd6WdelLZy4dIWoKDwbZLBNfIthlJovCbUysWhENB
	EP7MVpi2IIYZ/sZCN5cVOL9hkOZrJG5UZOEiivE22YRLmuUyhK08qrahdPdHkg==
ARC-Authentication-Results: i=1;
	rspamd-5ffd6989c9-2v6j7;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: 
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-White-Wipe: 6bf78de07a0ffba2_1763634859225_144398891
X-MC-Loop-Signature: 1763634859225:2573216735
X-MC-Ingress-Time: 1763634859225
Received: from de-fra-smtpout3.hostinger.io (de-fra-smtpout3.hostinger.io
 [148.222.55.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.37.83 (trex/7.1.3);
	Thu, 20 Nov 2025 10:34:19 +0000
Received: from [IPV6:2001:861:4450:d360:a066:6d43:e556:60e2] (unknown [IPv6:2001:861:4450:d360:a066:6d43:e556:60e2])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dBvpv5PHtz3x74;
	Thu, 20 Nov 2025 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1763634855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlF/rfZzJsKOuIZxeAHKJw55Yi0HEvzWbVBg6BrsgRI=;
	b=NwPknAi/8PSWeN6Cx4fvCy6zaonD+YJ9ZyJBGj66xYp5e2ASMy1iTukuX9uPdIZZ5s4HPf
	JLSqL5RTjC0mSpi8LXEUqNr4Bcs1yDvRKWyY1EPnwEeVqbqDx02PJ/++iTR7zsE5arF1GD
	WVwrvRhJetszB6r7dFPtj35o3Zgf7a5LslyyKf5T+Pgi5GEhHFQYohO9AzSSlKHe8S90cV
	BbKUDnw1aoEhFGDwqyJTil8YK9ixr30pZq63p3GI1SGXgA2WKAAX63AH8d3IDCGNofGiss
	PduC9wl55zJnjMBYwD6pdcgd8EJDLltNpRNJH5kupIyggaDrUnYHQhKTl0kEvA==
Message-ID: <f176e971-d19f-47a1-a591-d2a501d16079@rootcommit.com>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com
Subject: Re: [yocto-patches] [PATCH meta-rockchip] orangepi-3b: add
To: yocto-patches@lists.yoctoproject.org
References: <1879B0158049C4B6.1423420@lists.yoctoproject.org>
Content-Language: en-US, fr
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <1879B0158049C4B6.1423420@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 20 Nov 2025 10:34:15 +0000 (UTC)
X-CM-Envelope: MS4xfKOn7M1LFksnV5X9wAzGvWFGXEDqosrWm3KaCpyjR0wRBWBAtweYX/4x04/YifdphK/5UrKJUTr3FemX+8oHEL9xe7sAJTbHxjb21w47YrjxqExv3mTH 6u6gL/oLqDUATMcySvq9Tfj6LKfVWt3DBERr9VpQQto6OHM8g3AHYtgtFVwY/g6aMzgTN6f/Hr11EBkJs63fxQmaCj9ayAJ+90m3Vd/gyCTfbgsnnMDGamNq +dBw2MyrY/xiylgpQ2oORgV5Z8UUwuYTMK2MSxdUCADygw0Bux4JKpbPnPLPKnHnGitWKcP2AlY95IfquaJTYRaNUEFLzZnUPju8QEouQvGvQZ7JsFoMPWTb /ggbJMvLeeZKeu9fSo8ar5DWhkZ/H6Mz1A558GN1oCt2K+A9lL0=
X-CM-Analysis: v=2.4 cv=ALriHGRn c=1 sm=1 tr=0 ts=691eeea7 a=l2urqJcD81kOlpy6CkxEZg==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=xvVKIM8KDtsgExuWMyoA:9 a=QEXdDO2ut3YA:10 a=URPqgtl0u8oA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 10:34:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2622

Oops, it seems b4 messed up the subject line.
It should contain "[meta-rockchip][PATCH]"

Investigating...

-- 
Michael Opdenacker
Root Commit
Yocto Project and OpenEmbedded Training course - Learn by doing:
https://rootcommit.com/training/yocto/


