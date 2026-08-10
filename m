Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F33DC5AD7B
	for <webhook@archiver.kernel.org>; Mon, 10 Aug 2026 16:04:23 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33112.1786377857837370149
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Aug 2026 09:04:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 67AG4EjJ4055582;
	Mon, 10 Aug 2026 11:04:14 -0500
Received: from [192.168.2.32] ([192.168.2.32])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 67AG4Epe020853;
	Mon, 10 Aug 2026 11:04:14 -0500
Message-ID: <c98d9769-1e97-46f8-8431-02244ca2ae22@kernel.crashing.org>
Date: Mon, 10 Aug 2026 11:04:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org,
        Dmitry Sakhonchik <frezidok1@gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [pseduo] Status Update
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Aug 2026 16:04:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4656

Richard has luckily been able to step in and pull in a bunch of bug fixes 
recently.  I've had limited time to work on this, but hopefully will get back to 
it soon.

The big remaining pull request we have is the logging infrastructure change.  We 
are anticipating to pull this in soon, and when we do it will be the first patch 
on a new 2.0 development line.

1.x will remain to sustain the existing LTS releases and user base
2.x will be created starting with the logging change, and future development 
that is deemed too disruptive for the 1.x line.

Anyway, just a quick status update.  Thanks for your patience.

--Mark

