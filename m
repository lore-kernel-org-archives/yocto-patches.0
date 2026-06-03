Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67384CD6E55
	for <webhook@archiver.kernel.org>; Wed,  3 Jun 2026 21:54:05 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31447.1780523642642177318
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Jun 2026 14:54:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 653Ls17T2276748
	for <yocto-patches@lists.yoctoproject.org>; Wed, 3 Jun 2026 16:54:02 -0500
Received: from [192.168.2.62] ([192.168.2.62])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 653Ls0e1032207
	for <yocto-patches@lists.yoctoproject.org>; Wed, 3 Jun 2026 16:54:01 -0500
Message-ID: <fe118c84-52fd-4815-9f40-f4238c22ae1a@kernel.crashing.org>
Date: Wed, 3 Jun 2026 16:54:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [pseudo] New version tagged: pseudo-1.9.8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Jun 2026 21:54:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4131

A new version with the setuid change(s) has now been pushed and tagged.

--Mark

