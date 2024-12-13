Return-Path: <ariel.dalessandro@collabora.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A66E7717F
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 16:16:34 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
 by mx.groups.io with SMTP id smtpd.web10.19719.1734106589819066582
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 08:16:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=ariel.dalessandro@collabora.com header.s=zohomail header.b=lIt3LQ1Y;
 spf=pass (domain: collabora.com, ip: 136.143.188.112, mailfrom: ariel.dalessandro@collabora.com)
ARC-Seal: i=1; a=rsa-sha256; t=1734106576; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fRs0Duh7B4vnqM4wg18rRLse2v+M7kh1NZoz2JpqjmclDkLfmNeMuGXtzS6yVAiF9o18u92NwyyhgKGjE7tu3qvwD3/7zOzh3E24lrYhoznl/ukP6XcQp+XqdoGu/JJFfKmoEfc9sssNdkW9xMBEDQsVNCZOSzKce8r9VDn0Ang=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734106576; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8FfHZW8x+HfyJ7NeRnTfuA9SzVmpeDRZV3mrJLUwoHw=; 
	b=gqt5N28fGAPmqDFab8KTczkEKfiPKM1AtaYin8fn+9rn0Y20v00XbgPFRPDOvOg8ej8XUeDPf7uTG3OXBJOGGAyQvoTIQPLRN0HHqhfLf5rk96jhzOKf3Ufgmo4vilQJ33zSaC/11D4lTOdnlgLEuTE2GzgnWvRUTvDuxVOew1k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734106576;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8FfHZW8x+HfyJ7NeRnTfuA9SzVmpeDRZV3mrJLUwoHw=;
	b=lIt3LQ1Y8byAOGAB2hJ1DFhwglTjZWNdVhiuedTqlPFBEjf3jLWDgNQpfZU6e8Dk
	xWaVZZmFn25S4/Di1THJLuvHi4CZjjhNG0VfHSlT0AkhSvilfBmsO2gU48u1gtKppfR
	0Oaq5S6tpnqxBKCdBC6X7OlisiC19LPg4iNUer+E=
Received: by mx.zohomail.com with SMTPS id 1734106574015538.5088224350944;
	Fri, 13 Dec 2024 08:16:14 -0800 (PST)
Message-ID: <4403aa70-ff4f-44d7-a191-d5e79c3b14cc@collabora.com>
Date: Fri, 13 Dec 2024 13:16:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/clang][RFC]
 kirkstone/clang branch proposal
To: yocto-patches@lists.yoctoproject.org,
 Martin Jansa <martin.jansa@gmail.com>
Cc: scott.murray@konsulko.com, peter.marko@siemens.com, max@igalia.com,
 raj.khem@gmail.com
References: <e3efc225-d2a0-4561-8554-6b3e3dd20ba9@collabora.com>
 <CA+chaQex3k7a1ksiDUGYU-We0KYRP4apaV5WiPSVy5+1ZGgS5w@mail.gmail.com>
 <CAMKF1sor1UBoFpmQfc3JjuoGDQanBnLCt_ncWo-12K02UXhTLQ@mail.gmail.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <CAMKF1sor1UBoFpmQfc3JjuoGDQanBnLCt_ncWo-12K02UXhTLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 16:16:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/903

Hi,

On 11/1/24 2:41 PM, Khem Raj wrote:
> On Fri, Nov 1, 2024 at 10:40 AM Martin Jansa <martin.jansa@gmail.com> wrote:
>>
>> Hi,
>>
>> it might be more visible as a branch in meta-clang as previous
>> multiple clang versions for the same yocto release were as well, e.g.:
>> https://github.com/kraj/meta-clang/tree/dunfell-clang14
>> https://github.com/kraj/meta-clang/tree/dunfell-clang12
>> https://github.com/kraj/meta-clang/tree/kirkstone-clang12
>>
>> if Khem doesn't mind having another branch for kirkstone there, then I
>> would prefer kirkstone-clang18 in meta-clang instead of
>> meta-lts-mixins
> 
> Yeah I am ok with another branch in meta-clang.

I've opened https://github.com/kraj/meta-clang/pull/1040

    [new branch: kirkstone-clang18]: Backport from scarthgap #1040

Please review, comments welcome :-)

Regards,

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


