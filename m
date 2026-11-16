Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33967.1794850853355220286
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 09:40:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AGHeqBu3497279;
	Mon, 16 Nov 2026 11:40:52 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AGHepAn001521;
	Mon, 16 Nov 2026 11:40:51 -0600
Message-ID: <ee9c9aba-d3e0-4819-ba5e-bc1c87ac8655@kernel.crashing.org>
Date: Mon, 16 Nov 2026 11:40:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][pseudo-1.9]PATCH 00/10] Backports from
 master to 1.9 branch
To: yocto-patches@lists.yoctoproject.org, Yoann Congal <yoann.congal@smile.fr>
References: <1794413712-18072-1-git-send-email-mark.hatle@kernel.crashing.org>
 <DMT7HDZT3P6O.1DHC10SI0D1UB@smile.fr> <DMUA3YZ5XCVE.34QEVSM08HIU2@smile.fr>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <DMUA3YZ5XCVE.34QEVSM08HIU2@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 17:40:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5409

I've pushed this version and declared a 1.9.13 tag.

Commit is: 26afebdaafa416eefa51553fc28d827719c5aed5

--Mark

On 11/13/26 12:02 PM, Yoann Congal via yocto-patches wrote:
> On Thu Nov 12, 2026 at 12:46 PM CET, Yoann Congal wrote:
>> On Wed Nov 11, 2026 at 5:15 PM CET, Mark Hatle via yocto-patches wrote:
>>> The following are backporting a small number of fixes:
>>>   Add open_tree test case
>>>   Fix makewrapper compilation warning
>>>   Don't require linux/mount.h (part of the open_tree work)
>>>   State a minimum gcc 5 requirement
>>>   Add in the parallel rename/link locking
>>>
>>> It is also adding to new files:
>>>   Add a README.security and AGENTS.md file
>>>
>>> Note, there is are a couple of additional pending changes likely
>>> specifically for Yocto Bug 16493.  This is still in testing and
>>> will be sent to the list once ready.
>>>
>>> Mark Hatle (10):
>>>    test: Skip open_tree tests when the function or syscall is unavailable
>>>    makewrappers: Don't generate unused _int paths with noignore_path
>>>    ports/linux: Don't require <linux/mount.h>
>>>    configure: Require GCC 5 or later
>>>    pseudo_client: serialize path changes across clients
>>>    ports: hold the path lock in create and metadata wrappers
>>>    ports: check created files under the path lock before recording them
>>>    test-parallel-ops: Add a parallel create/rename/link/chmod test
>>>    README.security: Add information specific to file/process security
>>>    AGENTS.md: Add to assist future developers
>>
>> Hello,
>>
>> FWIW, I plan to integrate these onto my stables branches to test them.
>>
>> Thanks!
> 
> This series passed a-full on scarthgap (on first try!):
> https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/5116
> 
> Integration was done with this patch:
> https://git.yoctoproject.org/poky-contrib/commit/?h=stable/scarthgap-nut&id=7a6ca5322b313aabf826b0105eaf37a0add2f3b0
> 
> I plan to do the same for blacksail and wrynose. It might take 1-2 weeks
> to get sufficient testing on all those branches.
> 
> Regards,
