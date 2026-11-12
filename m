Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8561.1794469325514822758
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 23:42:06 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wD3_9dNbfVqp_oGAA--.9062S3;
	Thu, 12 Nov 2026 15:39:57 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADnd2jDbfVq_lI0AA--.52346S2;
	Thu, 12 Nov 2026 15:41:55 +0800 (CST)
Message-ID: <fb31aa8f-48a1-4c55-88f0-67be748552e1@cetc.com.cn>
Date: Thu, 12 Nov 2026 15:41:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][wrynose][PATCH] refpolicy:
 backport perf event access for unconfined domains
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
References: <20261112055125.704676-1-wenwfu@qti.qualcomm.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20261112055125.704676-1-wenwfu@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowADnd2jDbfVq_lI0AA--.52346S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYJCmr0bxcYpAACsf
X-CM-DELIVERINFO: =?B?Uh0rg6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOBjikTaASO0jFnSVrl+VCd4ewnjaqG6IgMmD3EcNZ6xapvfscOgof6rfGfJf1jkampBs
	PPE8V5k8TsDgO1HJuFZGBhtJygRmfNfVrfTISZfH1VOJjjy3Q+9aNlqFFChAIg==
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1xJFWDtr1xZr45ZFWDGFX_yoWrGrW8pF
	48CF9YkF48XFyxGw4xCFyY9F17G3yrGws8ua4Ygr48ua15ZFyUu3Z5tFy3WanYyr47G347
	t34SgF4fGa1UJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GF7v73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYo7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x
	07Ut9N3UUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 07:42:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5321

The patch should be in refpolicy_common.inc because the `unconfined` 
module is used by all refpolicy variants.

Regards,
Qi

On 11/12/26 13:51, Wenwen Fu via yocto-patches wrote:
> Unconfined domains lack the perf_event permissions needed by perf to
> collect performance counters and tracepoints with SELinux enforcing.
>
> Backport refpolicy commit 6072cfa851a3 ("unconfined: allow perf event
> access for unconfined domains") to refpolicy-targeted to allow access
> to their own perf events.
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> ---
>   .../refpolicy/refpolicy-targeted_git.bb       |  1 +
>   ...-event-access-for-unconfined-domains.patch | 35 +++++++++++++++++++
>   2 files changed, 36 insertions(+)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
> index 321407d..a416854 100644
> --- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
> +++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
> @@ -15,4 +15,5 @@ include refpolicy_${PV}.inc
>   SRC_URI += " \
>           file://0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch \
>           file://0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
> +        file://0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch \
>           "
> diff --git a/recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch b/recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch
> new file mode 100644
> index 0000000..a356218
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch
> @@ -0,0 +1,35 @@
> +From 6072cfa851a3598bfa86622dff9c680c2e662901 Mon Sep 17 00:00:00 2001
> +From: Wenwen Fu <wenwfu@qti.qualcomm.com>
> +Date: Thu, 5 Nov 2026 10:02:03 +0800
> +Subject: [PATCH] unconfined: allow perf event access for unconfined domains
> +
> +Unconfined domains have the perfmon capability but lack complete
> +perf_event permissions. This prevents perf from collecting performance
> +counters and tracepoints with SELinux enforcing.
> +
> +Allow unconfined domains to open, read and control their own perf
> +events, including CPU, kernel and tracepoint collection. Add the rule
> +to unconfined_domain_noaudit() alongside the other self access rules.
> +
> +Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/6072cfa851a3598bfa86622dff9c680c2e662901]
> +
> +Assisted-by: Codex:GPT-6
> +Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> +---
> + policy/modules/system/unconfined.if | 3 +++
> + 1 file changed, 3 insertions(+)
> +
> +diff --git a/policy/modules/system/unconfined.if b/policy/modules/system/unconfined.if
> +index 6c48561238..c627d38dcf 100644
> +--- a/policy/modules/system/unconfined.if
> ++++ b/policy/modules/system/unconfined.if
> +@@ -59,6 +59,9 @@ interface(`unconfined_domain_noaudit',`
> + 	# for io_uring
> + 	allow $1 self:anon_inode { create map read write };
> +
> ++	# Access own perf events
> ++	allow $1 self:perf_event { open cpu kernel tracepoint read write };
> ++
> + 	# Userland object managers
> + 	allow $1 self:nscd { admin getgrp gethost getpwd getserv getstat shmemgrp shmemhost shmempwd shmemserv };
> + 	allow $1 self:dbus { acquire_svc send_msg };

