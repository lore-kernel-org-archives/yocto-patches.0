Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12303.1793932703119940994
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Nov 2026 18:38:23 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wC3StUhPe1q7IcDAA--.14009S3;
	Fri, 06 Nov 2026 10:36:18 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADneWrLPO1qw8MtAA--.53598S2;
	Fri, 06 Nov 2026 10:34:51 +0800 (CST)
Message-ID: <e6e43759-c5e3-4c0f-8941-a1bfbdb3b7c5@cetc.com.cn>
Date: Fri, 6 Nov 2026 10:37:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches][meta-selinux][wrynose][PATCH 1/2] selinux: ignore
 CVE-2026-59676 in components excluding seunshare
To: yocto-patches@lists.yoctoproject.org
Cc: Darsh Kelaiya <dkelaiya@cisco.com>
References: <20261105070309.834959-1-dkelaiya@cisco.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20261105070309.834959-1-dkelaiya@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowADneWrLPO1qw8MtAA--.53598S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYDCmrsh9MK3gABsJ
X-CM-DELIVERINFO: =?B?Bixgxac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOAN5QhYBP/Hfs96vmoQs/I/SyEZVp72leht5t9SdM/GI6hR2i1NfzIzvwJJteSdkfJyR
	jCfHeJ/vkmXhG2KFWaWLKWIs9QtIqyraOmA/GD2SgXwEM0CKMz3g7TrgLtk8bA==
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1rJrWktw4rurW5JryUXFc_yoW8CFW5pa
	42kF47GrW8GFn7Wryku3WjgF4j9ws8Ca47GrWDGw4Yyry7ZFn7Zw4vk3sxWr47XrZ5GFWD
	Ar4UAws5Ka4UAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYF7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1K0PDUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Nov 2026 02:38:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5246

Both merged.

Regards,
Qi

On 11/5/26 15:03, Darsh Kelaiya -X (dkelaiya - E INFOCHIPS PRIVATE 
LIMITED at Cisco) via yocto-patches wrote:
> From: Darsh Kelaiya <dkelaiya@cisco.com>
>
> Analysis:
> - CVE-2026-59676 affects recursive deletion in sandbox/seunshare.c
>    and is fixed by adding O_NOFOLLOW to openat() [1, 2].
> - SELinux components share a broad CVE product mapping through
>    selinux_common.inc [3]. Only selinux-sandbox builds seunshare.
> - Set not-applicable-config once in the shared include for the
>    components that exclude seunshare, including native variants.
> - For BPN selinux-sandbox, remove this status flag after parsing
>    so CVE reporting detects the source patch carried by its recipe.
>
> Reference:
> [1] https://security.opensuse.org/2026/07/15/selinux-seunshare.html
> [2] https://github.com/SELinuxProject/selinux/commit/38f0a4d9a683f2cd2472d4502842df5d5b8255a8
> [3] https://git.yoctoproject.org/meta-selinux/tree/recipes-security/selinux/selinux_common.inc?id=1c3a699f363167571ab39fecb0fe6f56691a4e20
>
> Signed-off-by: Darsh Kelaiya <dkelaiya@cisco.com>
> ---
>   recipes-security/selinux/selinux_common.inc | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/recipes-security/selinux/selinux_common.inc b/recipes-security/selinux/selinux_common.inc
> index aaf0b90..bf7aa78 100644
> --- a/recipes-security/selinux/selinux_common.inc
> +++ b/recipes-security/selinux/selinux_common.inc
> @@ -21,3 +21,10 @@ do_install() {
>   }
>   
>   CVE_PRODUCT ?= "selinux_project:selinux"
> +
> +CVE_STATUS[CVE-2026-59676] = "not-applicable-config: The vulnerable seunshare utility is built by selinux-sandbox."
> +
> +python __anonymous() {
> +    if d.getVar("BPN") == "selinux-sandbox":
> +        d.delVarFlag("CVE_STATUS", "CVE-2026-59676")
> +}

