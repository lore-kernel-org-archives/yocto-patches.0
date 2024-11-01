Return-Path: <ariel.dalessandro@collabora.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE20E6B258
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:57:45 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
 by mx.groups.io with SMTP id smtpd.web10.37159.1730465860516410323
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 01 Nov 2024 05:57:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=ariel.dalessandro@collabora.com header.s=zohomail header.b=iZ82yXrb;
 spf=pass (domain: collabora.com, ip: 136.143.188.112, mailfrom: ariel.dalessandro@collabora.com)
ARC-Seal: i=1; a=rsa-sha256; t=1730465857; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S2FwURxiH4BwZzTQB1/mu5C6mVRBeFSnpiqu59EvJmO0Iw1cKFKl1/c5Aj6G575LV+YZdVehrCb4J1bY9k5Y1vkG8JJ613ddjL1q7iaeXlKaXBpmpRe2fDUOpFG0nuDkuJ8GimSNluudnTY81A1SsfHACcKiorf1GBeMDr2hFm0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730465857; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ytTi+u79Zp5OlS2eU7552Poi+EUWfunGILKrvo7rHAs=; 
	b=k9c3N2Oy8j6IrTX5rSjFWko3Y2c2PFzXwZ0buqsEnjjqPceAEM2kJs0LrAz98H7snggM55g0uCyWiYQLXxX8+YMnQrngDoXdFbOup7nBKm6idtVihS2C3cwLuYtIoWzhe0sjnL/6PgE3LHfFTfHRNSSLncXvMtf+Ru+GjKxe4ZQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730465857;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ytTi+u79Zp5OlS2eU7552Poi+EUWfunGILKrvo7rHAs=;
	b=iZ82yXrbjfP7PPFdsuwouUYblMdytEY/iuWLgTDaMp1JAqm/K2cCDOIjIT4SUJf/
	DqyFCc8znQIRDOPcItJcvkW0ousFikRN5A+iOLVatPQl3iPSE6Xy7AmQcZcmXuoqAqB
	EDEhB24eUdg1wcXHsGcAxptAhiamQia9pcaulwf8=
Received: by mx.zohomail.com with SMTPS id 1730465855210502.2374499784146;
	Fri, 1 Nov 2024 05:57:35 -0700 (PDT)
Message-ID: <f379ec20-6a31-4dfc-a524-21a7f06b709f@collabora.com>
Date: Fri, 1 Nov 2024 09:57:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-lts-mixins][kirkstone/rust][RFC]Release/branch
 kirkstone/rust-1.74
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: scott.murray@konsulko.com
Cc: yocto-patches@lists.yoctoproject.org, quaresma.jose@gmail.com
References: <fd647dcd-fe6d-4e7e-ad5e-983aca24c086@collabora.com>
Content-Language: en-US
In-Reply-To: <fd647dcd-fe6d-4e7e-ad5e-983aca24c086@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 01 Nov 2024 12:57:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/782

Gentle ping :-)
[+Cc Jose - as I've seen it active]

Thanks!

On 10/25/24 1:54 PM, Ariel D'Alessandro wrote:
> Hi Scott, all,
> 
> Question regarding `meta-lts-mixins` layer. What's the criteria to 
> create a branch pointing to a specific rust release? Apart from 
> `kirkstone/rust-1.68` and `kirkstone/rust-1.70`, could we also add 
> `kirkstone/rust-1.74`?
> 
> We're currently working on getting `meta-browser` chromium support bump 
> to verions `129.` on kirkstone [0], which requires `rust >= 1.74.0`.
> 
> Of course we could just put a specific requirement using a commit hash 
> for the required version from `kirkstone/rust` branch, but it'd better 
> to have a tag or freezed branch instead.
> 
> Thanks in advance!
> Ariel
> 
> [0] https://github.com/OSSystems/meta-browser/ 
> pull/843#issuecomment-2430696039
> 

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


