Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31810.1795563526755272494
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 15:38:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AONchMT901642;
	Tue, 24 Nov 2026 17:38:43 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AONchLN027373;
	Tue, 24 Nov 2026 17:38:43 -0600
Message-ID: <b96fc668-158f-4478-a97f-19f74ed8f4a6@kernel.crashing.org>
Date: Tue, 24 Nov 2026 17:38:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [pseudo] Version 1.99.2 has been tagged
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 23:38:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5513

All of the pending commits have been pushed to master, and version 1.99.2 has 
been tagged.

It is intended that this will be the 2.0 version unless additional problems are 
found.

--Mark
