Return-Path: <enrico.scholz@sigma-chemnitz.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD92C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 19:24:15 +0000 (UTC)
Received: from smtpout.cvg.de (smtpout.cvg.de [87.128.211.67])
 by mx.groups.io with SMTP id smtpd.web11.44235.1737401046248431643
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 11:24:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@sigma-chemnitz.de header.s=v2022040800 header.b=zovZqiRi;
 spf=pass (domain: sigma-chemnitz.de, ip: 87.128.211.67, mailfrom: enrico.scholz@sigma-chemnitz.de)
Received: from mail-mta-2.intern.sigma-chemnitz.de (mail-mta-2.intern.sigma-chemnitz.de [192.168.12.70])
	by mail-out-2.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTPS id 50KJO2fv1859661
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 20:24:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigma-chemnitz.de;
	s=v2022040800; t=1737401042;
	bh=n5iVHt/QpIhw4gsXlOHG/xVOvcfYtQ896QvylAf6ItI=; l=1098;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=zovZqiRi3gcSf9t84Yead8gUFXcvJvn34EScf7iY4+53lhXv3XocZNe+iWjedJIMO
	 xa/5rHMuQRfT0EpOaAjtdIS3FNVtbB7/uX7tpo/tLEMhMdnCEmSzRAjmV2zJ/OtC+H
	 ZpO2aDWe2eKYTneNMBJJX7E0aNV/qGZ4u2ChEPNSoCj+9z7botFT8l7MHY+zVvMxa/
	 6kWJ8/Iq2DFshr2yWDoh/KDQOAjD/4eedKLPJLBtxBTsjtSuDVaig+a5xNKqE08mua
	 8/iqkZYNnvnJWIL5n2JBvxuB57/lQEtE6kwYLdhLFedic4AsoIoo87U4nruDcH7RSL
	 VZcgyRGjZlUew==
Received: from reddoxx.intern.sigma-chemnitz.de (reddoxx.sigma.local [192.168.16.32])
	by mail-mta-2.intern.sigma-chemnitz.de (8.18.1/8.18.1) with ESMTP id 50KJNxLx2314155
	for <yocto-patches@lists.yoctoproject.org> from enrico.scholz@sigma-chemnitz.de; Mon, 20 Jan 2025 20:24:00 +0100
Received: from mail-msa-2.intern.sigma-chemnitz.de ([192.168.12.72])
	by reddoxx.intern.sigma-chemnitz.de with ESMTP
	id H4F3XEJ1F0; Mon, 20 Jan 2025 20:23:59 +0100
Received: from ensc-pc.intern.sigma-chemnitz.de (ensc-pc.intern.sigma-chemnitz.de [192.168.3.24])
	by mail-msa-2.intern.sigma-chemnitz.de (8.17.1/8.17.1) with ESMTPS id 50KJNx8d1816282
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 20 Jan 2025 20:23:59 +0100
Received: from ensc by ensc-pc.intern.sigma-chemnitz.de with local (Exim 4.98)
	(envelope-from <ensc@sigma-chemnitz.de>)
	id 1tZxNP-00000003GFO-0sHJ;
	Mon, 20 Jan 2025 20:23:59 +0100
From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Scott Murray <scott.murray@konsulko.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-lts-mixins][scarthgap/rust][PATCH] classes: rename to
 classes-recipes/
In-Reply-To: <1f6cdeb4-c868-e32c-4372-123371eb4b12@konsulko.com> (Scott
	Murray's message of "Mon, 20 Jan 2025 14:00:58 -0500 (EST)")
References: <20250120165117.737681-1-enrico.scholz@sigma-chemnitz.de>
	<1f6cdeb4-c868-e32c-4372-123371eb4b12@konsulko.com>
Date: Mon, 20 Jan 2025 20:23:59 +0100
Message-ID: <lybjw1ffw0.fsf@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Sender: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
X-REDDOXX-Id: 678ea2cf8c284250d7b37cf9
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 19:24:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/990

Scott Murray <scott.murray@konsulko.com> writes:

>> bitbake looks first in 'classes-recipes/' and then in 'classes/'.
>> Hence, content had no effect and was just ignored.
>>
>> Rename folder so that it overrides the OE-core classes.
>>
>> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> [snip]
>
> I'm pretty sure this is incorrect.

Logic is in [1]

--> first iterate (using $BBPATH) in 'recipes-%', then in 'recipes'


For now, it does not matter because classes in OE core and meta-lts-mixins
are very similar.  But 1.81 seems to introduce other data layouts so correct
classes are probably important.

I stumpled across it while fixing cargo-native build errors [2]



Enrico

Footnotes:
[1]  https://github.com/openembedded/bitbake/blob/0329a7e3ac694737f2d2c1861f65492551360663/lib/bb/parse/parse_py/BBHandler.py#L53-L68

[2]  https://lists.openembedded.org/g/openembedded-core/message/210043

-- 
SIGMA Chemnitz GmbH       Registergericht:   Amtsgericht Chemnitz HRB 1750
Am Erlenwald 13           Geschaeftsfuehrer: Grit Freitag, Frank Pyritz
09128 Chemnitz

