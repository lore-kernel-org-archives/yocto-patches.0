Return-Path: <ariel.dalessandro@collabora.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF83E74AC1
	for <webhook@archiver.kernel.org>; Tue,  3 Dec 2024 16:02:25 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
 by mx.groups.io with SMTP id smtpd.web10.23574.1733241737619406930
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Dec 2024 08:02:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=ariel.dalessandro@collabora.com header.s=zohomail header.b=eJU5ZZU2;
 spf=pass (domain: collabora.com, ip: 136.143.188.112, mailfrom: ariel.dalessandro@collabora.com)
ARC-Seal: i=1; a=rsa-sha256; t=1733241736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T5pJo/XP+HtEL7t2qIoS9gg9GGlQ4ePkRG8uPdlqhyla0FROzvRyAnu3D95QpnskME9VMYiQCP7LU2aoIBjY79Vn6K4cr1QPljzrbkNAtEwB+V6Pl8M+/+4pf6yjNfgdxD9huXhJZcKO+gyHBUJ1gRgKQA4vfblqQiH1TliRT5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733241736; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DPIcd3VFZG9vB9WzzjQlUWfG591aX1Gcu6eOYSUxwyM=; 
	b=mFQv3skDWWz+tH7RLe7m5iSX65u+kNFE6c6qbNxrsD1AUB8CYwtYBsE6J5gEJZud3LO/3CIjelPBROplbV+J1oAhFGzuYztG3l3NsrrtqYa3ua7v9IupJo+Lvc69pK3WLTPtAp3ZLUrYBzeCwoFYeav1VrXW0i9aO9ZAkINGfNA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733241735;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DPIcd3VFZG9vB9WzzjQlUWfG591aX1Gcu6eOYSUxwyM=;
	b=eJU5ZZU225LeIHnljUXfJbMzRko4TzjE7xY0m70yWyDIZxS+6U0f3tcrC3RQLpwm
	jb0kLcbfph9/DZAh/X1ZROSh58VMLaDtpl151HAu8d5SCaJHYxAMqKEzHW1LEFyOps1
	OwjH5B0WqFcrywmvGH6CudolToySQL6h8JM7SrhI=
Received: by mx.zohomail.com with SMTPS id 17332417338911023.1780994565852;
	Tue, 3 Dec 2024 08:02:13 -0800 (PST)
Message-ID: <f832a960-735a-402e-9561-9a62cc044510@collabora.com>
Date: Tue, 3 Dec 2024 13:02:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust-1.75]
 Announcement
To: konsulko.com@lists.yoctoproject.org
References: <c34d810d-d539-9613-074b-892d066340d0@konsulko.com>
Content-Language: en-US
Cc: yocto-patches@lists.yoctoproject.org
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <c34d810d-d539-9613-074b-892d066340d0@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Dec 2024 16:02:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/861

Hi Scott,

Thanks for your work and quick responses.

On 11/26/24 3:33 PM, Scott Murray via lists.yoctoproject.org wrote:
> I have just done the initial push of a kirkstone/rust-1.75 branch
> to meta-lts-mixins.  The intent of this mixin is to track the ongoing
> support for Rust 1.75 in the scarthgap LTS release, allowing a common
> Rust toolchain for folks needing to target both kirkstone and scarthgap.
> 
> Note that the while the branch is derived from kirkstone/rust, their
> common history differs a bit, as I discovered a few newer commits that
> were out  of order with respect to oe-core history that needed to be
> removed.  I have updated my backporting workflow to hopefully avoid that
> from happening again in kirkstone/rust.
> 
> Please drop me a note if you use the mixin and hit an issue.
I've tested this on my side, not issues hit.

Thanks again, regards.
Ariel

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


