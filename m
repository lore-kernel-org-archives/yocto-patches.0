Return-Path: <ariel.dalessandro@collabora.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74A0D65C7C
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 11:36:58 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
 by mx.groups.io with SMTP id smtpd.web11.35170.1731584212647942714
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Nov 2024 03:36:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=ariel.dalessandro@collabora.com header.s=zohomail header.b=BpzXqNi1;
 spf=pass (domain: collabora.com, ip: 136.143.188.112, mailfrom: ariel.dalessandro@collabora.com)
ARC-Seal: i=1; a=rsa-sha256; t=1731584211; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oGErxPiXxO/uXlftsiDR9P59aBLAyWLVqBOUZ8DTK8Sb/w3R/2wKOkPRi0UF+veWvHmiQx4KWuQIPdJj/EigmIRooqYINJ7K2RnjIbEIcG9Mh/+fX91tE4OxPTr1LOPW8oGbFfDi+igE45qncv5SmdRz9ANvghkGikHg9bcX314=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731584211; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AFH8XTk+QQjZPESwKcaC/2C3w6xAbaWPOAnHQ7fk6Gc=; 
	b=JfBRqEmIdpWiOsAmFiJ7b9QGc7mbkIX5t+xilr8o1P4wVCSE6pKe7AJjVMy+/Pg3+sNGYf11FcnbJ3+J7clY3ofLhnXIUu32jrckfGyVN3uAn0ipeGgnmuKW5cUI+7PAOhc7QfuyVi15doWw3c78/fj342wGnLO4jweAsrI63K8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731584211;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=AFH8XTk+QQjZPESwKcaC/2C3w6xAbaWPOAnHQ7fk6Gc=;
	b=BpzXqNi1r0Pjplcf8JbxvkBuUnzpPRCAXgjpnrohvnrUps4Kfjl1cRRNlWfTP/gq
	EtXwm6ymNvXpOnL5hR/MVDCh0dfda12Hloyww6c54MxWj5t7ngggeyzDEcY+ZHX0411
	OoAZMY6K+V6XqCjaoRJ1hRuV2yFgIaPOlDhTQnGk=
Received: by mx.zohomail.com with SMTPS id 1731584209107918.5113530384343;
	Thu, 14 Nov 2024 03:36:49 -0800 (PST)
Message-ID: <a02d0dd1-3b73-4b33-b7fe-f5dee2b54750@collabora.com>
Date: Thu, 14 Nov 2024 08:36:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches]
 [meta-lts-mixins][kirkstone/rust][RFC]Release/branch kirkstone/rust-1.74
To: yocto-patches@lists.yoctoproject.org
Cc: quaresma.jose@gmail.com, scott.murray@konsulko.com
References: <fd647dcd-fe6d-4e7e-ad5e-983aca24c086@collabora.com>
 <f379ec20-6a31-4dfc-a524-21a7f06b709f@collabora.com>
 <44086b2b-aa3d-160e-adec-2ee8c7f93f9c@konsulko.com>
Content-Language: en-US
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <44086b2b-aa3d-160e-adec-2ee8c7f93f9c@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 14 Nov 2024 11:36:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/800

Hi Scott,

On 11/13/24 11:46 AM, Scott Murray via lists.yoctoproject.org wrote:
> On Fri, 1 Nov 2024, Ariel D'Alessandro wrote:
>> On 10/25/24 1:54 PM, Ariel D'Alessandro wrote:
>>> Hi Scott, all,
>>>
>>> Question regarding `meta-lts-mixins` layer. What's the criteria to create a
>>> branch pointing to a specific rust release? Apart from `kirkstone/rust-1.68`
>>> and `kirkstone/rust-1.70`, could we also add `kirkstone/rust-1.74`?
> 
> When I created the existing ones, it was to track the version of Rust in a
> specific YP release, but given how quickly the Rust ecosystem moves, that
> eventually started to seem not that useful, hence the switch to the master
> following kirkstone/rust.
> 
>>> We're currently working on getting `meta-browser` chromium support bump to
>>> verions `129.` on kirkstone [0], which requires `rust >= 1.74.0`.
>>>
>>> Of course we could just put a specific requirement using a commit hash for
>>> the required version from `kirkstone/rust` branch, but it'd better to have a
>>> tag or freezed branch instead.
> 
> It would likely be better to target 1.75, since that's what is in
> scarthgap and will at least see some security fixes for a couple of
> years.  I spoke to some automotive folks at OSS EU that described their
> requirements for supporting Rust code on kirkstone and scarthgap, and I
> did tell them I'd consider a kirkstone/rust-1.75.  If it would also meet
> your requirements, I'll work something up once I've worked through getting
> kirkstone/rust updated (it's a little behind master atm).
Agreed, makes sense to target whatever we have in scarthgap.

In fact, it's Rust 1.75 the one that fits our needs, because of RFC 
#1522 [0].

Let me know if there's something I could do to help here.

Thanks,
Ariel

[0] https://rust-lang.github.io/rfcs/1522-conservative-impl-trait.html

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


