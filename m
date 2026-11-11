Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.205.1794419940201621281
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 09:59:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6ABHwxXh2544292
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 11:58:59 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6ABHwwnH024860
	for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 11:58:59 -0600
Message-ID: <93a6277b-ad92-4a4b-9494-ae2e634b7e16@kernel.crashing.org>
Date: Wed, 11 Nov 2026 11:58:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][pseudo-1.9]PATCH 00/10] Backports from
 master to 1.9 branch
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: yocto-patches@lists.yoctoproject.org
Reply-To: yocto-patches@lists.yoctoproject.org
References: <18E709C4691EC596.864843@lists.yoctoproject.org>
Content-Language: en-US
In-Reply-To: <18E709C4691EC596.864843@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Nov 2026 17:59:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5309

Note, I have NOT pushed this work yet to pseudo-1.9.  More testing is required 
(master and this backport) against the path serialization/lock changes.  These 
tests are on-going.

--Mark

On 11/11/26 10:15 AM, Mark Hatle wrote:
> The following are backporting a small number of fixes:
>   Add open_tree test case
>   Fix makewrapper compilation warning
>   Don't require linux/mount.h (part of the open_tree work)
>   State a minimum gcc 5 requirement
>   Add in the parallel rename/link locking
> 
> It is also adding to new files:
>   Add a README.security and AGENTS.md file
> 
> Note, there is are a couple of additional pending changes likely
> specifically for Yocto Bug 16493.  This is still in testing and
> will be sent to the list once ready.
> 
> Mark Hatle (10):
>    test: Skip open_tree tests when the function or syscall is unavailable
>    makewrappers: Don't generate unused _int paths with noignore_path
>    ports/linux: Don't require <linux/mount.h>
>    configure: Require GCC 5 or later
>    pseudo_client: serialize path changes across clients
>    ports: hold the path lock in create and metadata wrappers
>    ports: check created files under the path lock before recording them
>    test-parallel-ops: Add a parallel create/rename/link/chmod test
>    README.security: Add information specific to file/process security
>    AGENTS.md: Add to assist future developers
> 
>   AGENTS.md                           |  85 ++++++++++++++++++++
>   README                              |   6 ++
>   README.security                     | 152 ++++++++++++++++++++++++++++++++++++
>   configure                           |  25 ++++++
>   makewrappers                        |  23 +++++-
>   ports/linux/guts/fopen64.c          |   5 +-
>   ports/linux/guts/freopen64.c        |   5 +-
>   ports/linux/guts/openat.c           |   8 +-
>   ports/linux/openat2/guts/openat2.c  |   8 +-
>   ports/linux/portdefs.h              |   7 +-
>   ports/linux/statx/wrapfuncs.in      |   2 +-
>   ports/linux/wrapfuncs.in            |  40 +++++-----
>   ports/linux/xattr/wrapfuncs.in      |  16 ++--
>   ports/unix/guts/fopen.c             |   5 +-
>   ports/unix/guts/freopen.c           |   5 +-
>   ports/unix/wrapfuncs.in             |  56 ++++++-------
>   pseudo.h                            |   1 +
>   pseudo_client.c                     | 108 ++++++++++++++++++++++++-
>   pseudo_client.h                     |   5 ++
>   pseudo_util.c                       |   2 +
>   pseudo_wrappers.c                   |   2 +
>   templates/wrapfuncs.c               |   2 +-
>   test/test-open_tree.c               |  25 ++++++
>   test/test-open_tree.sh              |  15 +++-
>   test/test-open_tree_attr-syscall.c  |  12 ++-
>   test/test-open_tree_attr-syscall.sh |  15 +++-
>   test/test-parallel-ops.sh           |  53 +++++++++++++
>   27 files changed, 615 insertions(+), 73 deletions(-)
>   create mode 100644 AGENTS.md
>   create mode 100644 README.security
>   create mode 100755 test/test-parallel-ops.sh
> 
