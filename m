Return-Path: <ariel.dalessandro@collabora.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E228D149D6
	for <webhook@archiver.kernel.org>; Fri, 25 Oct 2024 16:54:52 +0000 (UTC)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
 by mx.groups.io with SMTP id smtpd.web10.484.1729875284349117326
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 25 Oct 2024 09:54:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=ariel.dalessandro@collabora.com header.s=zohomail header.b=eI/7vaes;
 spf=pass (domain: collabora.com, ip: 136.143.188.15, mailfrom: ariel.dalessandro@collabora.com)
ARC-Seal: i=1; a=rsa-sha256; t=1729875282; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=exU9+tXypyOkTf13doCzTNazDv4MA8B8Cu90A+R08sA9Ucl1YgdWjsE2PWZnKXUG0O5K8rr1L/f+UEX21uA5TVENUzx//5UimzdkuRD66wlkvwsIiHP9aatcwucinA+HHv1pkvI58tyl1Ls+ex+xglUQQ8Ma1QVRITDxzf2sV/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729875282; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+runWI2bBvzlMl9C71FsDbAAYCi3vSCaQw1q+RHia4g=; 
	b=Ow+xghssV+zHlyU1Xvr3TXmW8wW0S5l3n0Ca/i33t2tsZYJ+AfG5nh+PHZWTJl+kntaGtqp5Ux6VXXYRGJlzpcpKSfPKYtaJnl/Oxc9hz5D9RYW40fh4ZUiDuWCo7h63qPAJSlMkQH7vwgwfZvn4flJWMxEfJS8TxvtJrXjfXBE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729875282;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Cc:Cc:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+runWI2bBvzlMl9C71FsDbAAYCi3vSCaQw1q+RHia4g=;
	b=eI/7vaes0hteR9JjMAvEn7gfJk+4q35Tywp7n+YDqOtD1gma//4UKiHI6cGPGQy5
	EpgekhLpRT1BHBV47hFjQze92qREeMzkl6/HhqhXy8Cu/oDczgmTc074K5qJa/Cr0l4
	fioAwfrmA9hIFEN0Uk2wGajsfS8aD/T0XWDL16tc=
Received: by mx.zohomail.com with SMTPS id 172987528086974.91977544047904;
	Fri, 25 Oct 2024 09:54:40 -0700 (PDT)
Message-ID: <fd647dcd-fe6d-4e7e-ad5e-983aca24c086@collabora.com>
Date: Fri, 25 Oct 2024 13:54:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: scott.murray@konsulko.com
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [meta-lts-mixins][kirkstone/rust][RFC]Release/branch
 kirkstone/rust-1.74
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 25 Oct 2024 16:54:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/760

Hi Scott, all,

Question regarding `meta-lts-mixins` layer. What's the criteria to 
create a branch pointing to a specific rust release? Apart from 
`kirkstone/rust-1.68` and `kirkstone/rust-1.70`, could we also add 
`kirkstone/rust-1.74`?

We're currently working on getting `meta-browser` chromium support bump 
to verions `129.` on kirkstone [0], which requires `rust >= 1.74.0`.

Of course we could just put a specific requirement using a commit hash 
for the required version from `kirkstone/rust` branch, but it'd better 
to have a tag or freezed branch instead.

Thanks in advance!
Ariel

[0] 
https://github.com/OSSystems/meta-browser/pull/843#issuecomment-2430696039

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


