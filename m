Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9582.1795485674142654396
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Nov 2026 18:01:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AO21DRk717962
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 20:01:13 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AO21CpI029498
	for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Nov 2026 20:01:12 -0600
Message-ID: <b491af15-9b38-48ed-ae75-b2e54370e374@kernel.crashing.org>
Date: Mon, 23 Nov 2026 20:01:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH 0/2] Implement async i/o and fast
 operations
To: yocto-patches@lists.yoctoproject.org
References: <20261123222728.2343685-1-mark.hatle@amd.com>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20261123222728.2343685-1-mark.hatle@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 02:01:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5496

This is JUST comparing do_rootfs times using buildstats.

Wrynose pseudo (before the file locking fix): 304s

The current master-next: 331s

master-next + async-io/fastop change: 272s

Moving this over the whole build, comparing master-next to +async-io was about a 
2 1/2 minute difference.  I don't have comparison of the wrynose pseudo I'm 
using, due to differences in build order.

But based on this, it looks like it is worth the additional complexity to enable 
this code.

--Mark

On 11/23/26 4:27 PM, Mark Hatle via yocto-patches wrote:
> These two were previously sent as an RFC.  A minor issue was discovered
> in the previous implementation.  One a case insensitive filesystem it
> had both _Exit.c and _exit.c which caused a conflict and problems.  The
> implementation was updated to avoid this problem.
> 
> Yocto Project (wrynose) was used for testing, along with my layer
> configuration.  For a build that had 32447 tasks, I prepopulated an
> sstate-cache, then removed the rootfs and package related cache objects.
> 
> The build difference was 45 seconds, 17:30 down to 16:45.  I believe most
> of the time was rootfs construction.  Offline testing showed a measurable
> improvement when running some 40,000+ operations.  (This is on a 64 thread
> Epyc w/ plenty of ram, so I expect a larger difference on slower hardware.)
> 
> I'm running additional performance benchmarks with buildstats, but this
> is enough to send to give others a chance to comment.  I'll reply with
> the buildstats info once I have it.
> 
> Mark Hatle (2):
>    Send client requests over one shared datagram socket
>    Replace FASTOP with requests that don't wait for a reply
> 
>   README.security                |   4 +-
>   doc/overview                   |   6 +-
>   doc/program_flow               |  11 ++
>   doc/pseudo_ipc                 |  73 +++++++++--
>   enums/msg_type.in              |   2 +-
>   enums/op.in                    |  50 +++----
>   ports/common/guts/_exit.c      |  16 +++
>   ports/common/guts/execv.c      |   4 +
>   ports/common/guts/execve.c     |   4 +
>   ports/common/guts/execveat.c   |   4 +
>   ports/common/guts/execvp.c     |   4 +
>   ports/common/guts/execvpe.c    |   4 +
>   ports/common/guts/fexecve.c    |   4 +
>   ports/common/pseudo_wrappers.c |  24 ++++
>   ports/common/wrapfuncs.in      |   1 +
>   pseudo.1                       |  23 +++-
>   pseudo.c                       |   2 +-
>   pseudo.h                       |   1 +
>   pseudo_client.c                | 230 ++++++++++++++++++++++++++-------
>   pseudo_client.h                |   2 +
>   pseudo_ipc.c                   |  42 ++++++
>   pseudo_ipc.h                   |   8 ++
>   pseudo_server.c                | 186 ++++++++++++++++++++++----
>   pseudo_util.c                  |   1 +
>   pseudo_wrappers.c              |  43 ++++++
>   test/test-async-abort.c        |  48 +++++++
>   test/test-async-abort.sh       |  40 ++++++
>   test/test-async-order.c        | 188 +++++++++++++++++++++++++++
>   test/test-async-order.sh       |  23 ++++
>   29 files changed, 931 insertions(+), 117 deletions(-)
>   create mode 100644 ports/common/guts/_exit.c
>   create mode 100644 test/test-async-abort.c
>   create mode 100755 test/test-async-abort.sh
>   create mode 100644 test/test-async-order.c
>   create mode 100755 test/test-async-order.sh
> 
