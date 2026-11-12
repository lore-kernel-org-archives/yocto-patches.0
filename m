Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9348.1794473984559070716
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 00:59:46 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAXAdd_f_VqngUHAA--.28130S3;
	Thu, 12 Nov 2026 16:57:36 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2Gjtf_Vqe2I0AA--.59954S2;
	Thu, 12 Nov 2026 16:59:26 +0800 (CST)
Message-ID: <7f2c3bbe-b30d-49ea-8f21-3b868c54b54e@cetc.com.cn>
Date: Thu, 12 Nov 2026 16:59:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][wrynose][PATCH v2] refpolicy:
 backport perf event access for unconfined domains
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
References: <20261112055125.704676-1-wenwfu@qti.qualcomm.com>
 <f5bcd8a79a7056170c9c66855b032d44116490ee.1794472623.git.wenwfu@qti.qualcomm.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <f5bcd8a79a7056170c9c66855b032d44116490ee.1794472623.git.wenwfu@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowABH2Gjtf_Vqe2I0AA--.59954S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYJCmr0bxcb4AABsb
X-CM-DELIVERINFO: =?B?F8hqm6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOBjikTaASO0jFnSVrl+VCd6xPlxPcuQlDV+xrx5IYrVsuFDYt7GdfsyuGeX50eWzCWLb
	bbnPokMwBrGUmE5j3vJGnMs+Xb3Zai4VW29rbzKo27o0FgZzXs9kR1sH9P5HHw==
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4ruw48tr18XFWDAF4kKrX_yoWrWFW3pF
	48CasYkF48XFn7Gan7CF15uF13K395Ja98W34jgr48uayUZF18u3Z5tw13WFsYyr17G347
	A34S9F4fGa1UArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GFDv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYO7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc2
	xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXV
	WUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U8sXo7UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 08:59:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5323

Merged

Regards,
Qi

On 11/12/26 16:40, Wenwen Fu via yocto-patches wrote:
> Unconfined domains lack the perf_event permissions needed by perf to
> collect performance counters and tracepoints with SELinux enforcing.
>
> Backport refpolicy commit 6072cfa851a3 ("unconfined: allow perf event
> access for unconfined domains") to allow unconfined domains to access
> their own perf events.
>
> Apply the patch in refpolicy_common.inc because all refpolicy variants
> use the unconfined module.
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> ---
> Changes in v2:
> - Apply the patch in refpolicy_common.inc for all refpolicy variants,
>    as suggested by Chen Qi.
> - Renumber the patch to 0059 and truncate its filename to 63 characters
>    to follow the shared patch naming convention.
> - Update the commit message to describe the shared scope.
>
>   ...-perf-event-access-for-unconfined-do.patch | 35 +++++++++++++++++++
>   .../refpolicy/refpolicy_common.inc            |  1 +
>   2 files changed, 36 insertions(+)
>   create mode 100644 recipes-security/refpolicy/refpolicy/0059-unconfined-allow-perf-event-access-for-unconfined-do.patch
>
> diff --git a/recipes-security/refpolicy/refpolicy/0059-unconfined-allow-perf-event-access-for-unconfined-do.patch b/recipes-security/refpolicy/refpolicy/0059-unconfined-allow-perf-event-access-for-unconfined-do.patch
> new file mode 100644
> index 0000000..a356218
> --- /dev/null
> +++ b/recipes-security/refpolicy/refpolicy/0059-unconfined-allow-perf-event-access-for-unconfined-do.patch
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
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 014714c..d896d88 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -74,6 +74,7 @@ SRC_URI += " \
>           file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
>           file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
>           file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
> +        file://0059-unconfined-allow-perf-event-access-for-unconfined-do.patch \
>           "
>   
>   S = "${UNPACKDIR}/refpolicy"

