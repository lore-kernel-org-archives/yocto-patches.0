Return-Path: <ariel.dalessandro@collabora.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E12E6F06E
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 16:27:26 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
 by mx.groups.io with SMTP id smtpd.web11.41912.1730478445967182917
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 01 Nov 2024 09:27:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=ariel.dalessandro@collabora.com header.s=zohomail header.b=ABrApr3t;
 spf=pass (domain: collabora.com, ip: 136.143.188.112, mailfrom: ariel.dalessandro@collabora.com)
ARC-Seal: i=1; a=rsa-sha256; t=1730478432; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lvY0BhZbhwFoTSwHZsdtgU9s/fKgHYACJyD+40Sbwda2Hv0anFJ7lK2JeECt9EYnivGOrEL0+wleS/cGS+f1Z3kiGykmYlMOidi1oqsXqEAO79t0ScPXVL7KtH+UcxH+/O/8DYgbHWYf+nOO2FMBihzlONPQwSlsQNYaxTmd96M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730478432; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kSPhuwnyQ9il0lSD1z9FiQL+s8tnVTypaWP0YpO3rTw=; 
	b=lR8erkTii++cJ5ySueitpHvR/dQlnRbzGEZxiMRXB5Gf1nxVTtluIro0XLuYCaTG7ISZQs8k/8SheRU9DLfVb+fwYMRMlMsiO8kU9vzL3Ba4bosFRfAkZYsLwi4yfFsZ/kD323kmaZlPSlzkwoo+xntzAz2o1OBoTez9JPoNdh8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730478432;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kSPhuwnyQ9il0lSD1z9FiQL+s8tnVTypaWP0YpO3rTw=;
	b=ABrApr3tCOK7sCqSHo6kxEOLzkzCkv1XfioA+Adg3LbX2l1eGlgUgW1xIytthjF1
	lwO8TGVPSc+fv4BQeSN16sJfHPzqthj33y8V/2tzubP1cNO8DU0y0OfxSueoUA3D7tP
	KaJyHphKVKp+xDXUAkD4xmlnWd5QOXE0SefB8GLI=
Received: by mx.zohomail.com with SMTPS id 1730478430391405.85602330247275;
	Fri, 1 Nov 2024 09:27:10 -0700 (PDT)
Message-ID: <e3efc225-d2a0-4561-8554-6b3e3dd20ba9@collabora.com>
Date: Fri, 1 Nov 2024 13:27:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, peter.marko@siemens.com, raj.khem@gmail.com,
 max@igalia.com
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [meta-lts-mixins][kirkstone/clang][RFC] kirkstone/clang branch
 proposal
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 01 Nov 2024 16:27:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/783

Hi all meta-lts-mixins people,

We're currently working on getting `meta-browser` chromium support bump 
to version `129.` on kirkstone [0], which requires `clang 16`.

Scarthgap `meta-clang` layer provides clang `18.1.6`, but kirkstone LTS 
branches do not accept major version updates [1].

Could this be submitted instead to 
https://git.yoctoproject.org/meta-lts-mixins/ as a new branch 
`kirkstone/clang`?

Thanks in advance!
Ariel

[0] https://github.com/OSSystems/meta-browser/pull/843
[1] https://github.com/kraj/meta-clang/pull/1024#issuecomment-2451851507

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


