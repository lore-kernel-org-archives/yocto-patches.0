Return-Path: <ariel.dalessandro@collabora.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BC9C83F1A
	for <webhook@archiver.kernel.org>; Mon, 21 Jul 2025 18:18:35 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
 by mx.groups.io with SMTP id smtpd.web10.48584.1753121910091934310
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Jul 2025 11:18:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=ariel.dalessandro@collabora.com header.s=zohomail header.b=b9TQ+gwC;
 spf=pass (domain: collabora.com, ip: 136.143.188.112, mailfrom: ariel.dalessandro@collabora.com)
ARC-Seal: i=1; a=rsa-sha256; t=1753121907; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YWLzH6pkZs6o/zYU39ZwKz1m/rSxYLoxW8LWxuMm2Y33kcgAqxitmT4mr/Weqd6F8G2n2Ne78KKghIn4ONcWvB+OSOcKfcfo3hHkNz7VG3twpRS0eu2/g2d54HcezpRnxFWNd1bMv/GOUgGZdplSMUFhTnldGUEx11eHjXetyUU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753121907; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/kFqBZdEBQTqt9ukKZkpYCm5vs0MSKorNbhnWo2Lk/0=; 
	b=VjyCC1dACt9Cd0vc7ZgvSnQqFuRcPOJ4MighTvZEJt+alLqayGp54mko0fKiVuMnZB7um2UyMVSxI9q+Mz0ZhQgq13tJTLbbZlgYAfllPwelPP5/SJta6QuOVg2tDNFMlLImXzfl75pIR3Wfu4TcjoKPJ8affeoDSDhzUpqpA4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753121907;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/kFqBZdEBQTqt9ukKZkpYCm5vs0MSKorNbhnWo2Lk/0=;
	b=b9TQ+gwCET8yIVNob3RvmAkjm3t5ggqsXCHnnUak1H77HVN6LzSgM8AW6bwe06Ts
	Ur/Pf84xVNlr0QbwwjLlWzc6bJUyk5wWmiD5LssLJUqY6gGI03VrZd2YZKqId/hYov/
	1j5QkH1oEEzUUIzOmdZum9ICWPbuCPDiA5L6Uq0g=
Received: by mx.zohomail.com with SMTPS id 1753121903854607.9292222810839;
	Mon, 21 Jul 2025 11:18:23 -0700 (PDT)
Message-ID: <052a381f-fd83-46c7-ae3d-d3bcb2ed8fac@collabora.com>
Date: Mon, 21 Jul 2025 15:18:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com, raj.khem@gmail.com
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [meta-lts-mixins][scarthgap/nodejs] Create new branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Jul 2025 18:18:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1820

Hi,

Currently working on a chromium `136.0.7103.113` update [0] in 
scarthgap, which depends on a major nodejs update to version `v22.11.0`.

This is request to create a new branch in `meta-lts-mixins` [1] for this 
purpose. The new branch should be called `scarthgap/nodejs` pulling from 
the following repository branch:

https://github.com/adalessandro/meta-lts-mixins/tree/scarthgap/nodejs

[0] https://github.com/OSSystems/meta-browser/issues/901
[1] https://git.yoctoproject.org/meta-lts-mixins

Regards,
Ariel

-- 
Ariel D'Alessandro
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK 
Registered in England & Wales, no. 5513718


