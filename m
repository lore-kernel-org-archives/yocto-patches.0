Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.334.1794325380919387736
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 07:43:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AAFgxr82327190
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 09:42:59 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AAFgxe8009883
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 09:42:59 -0600
Message-ID: <c4c69d83-12dd-44b9-80cd-16704461177d@kernel.crashing.org>
Date: Tue, 10 Nov 2026 09:42:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [pseudo] Master has been updated
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 15:43:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5258

I've updated master with the latest pull requests.  I also tagged 1.99.1.

Note, 1.99 itself is not really a release version, but more of a 'we're trying 
to get to 2.0', so the tag is more for convenience then an expectation it is a 
release.

For 2.0 planning, the remaining item is the parallel rename/link fix.  This work 
is in progress.  Once we determine a fix for the issue, and it's been tested 
"enough", I'm expecting to declare a 2.0 release.

--Mark
