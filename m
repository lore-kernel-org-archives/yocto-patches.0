Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB010C5DF94
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 05:32:14 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15418.1787635924679718930
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Aug 2026 22:32:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [117.61.153.123])
	by mtasvr (Coremail) with SMTP id _____wA3IaO5KI1q02gCAA--.11678S3;
	Tue, 25 Aug 2026 13:31:38 +0800 (CST)
Received: from [192.168.0.4] (unknown [117.61.153.123])
	by front01 (Coremail) with SMTP id C6CowABnmmprKI1q7DoeAA--.46853S2;
	Tue, 25 Aug 2026 13:30:19 +0800 (CST)
Message-ID: <0e3d5991-481f-4ba7-8308-94378c40c29e@cetc.com.cn>
Date: Tue, 25 Aug 2026 13:31:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] refpolicy: upgrade to
 20260729+git
To: yocto-patches@lists.yoctoproject.org
Cc: "joe.macdonald@siemens.com" <joe.macdonald@siemens.com>,
 "yi.zhao@windriver.com" <yi.zhao@windriver.com>
References: <PH8PR02MB114498D2471C4BEAB5F5A2770FEA62@PH8PR02MB11449.namprd02.prod.outlook.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <PH8PR02MB114498D2471C4BEAB5F5A2770FEA62@PH8PR02MB11449.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowABnmmprKI1q7DoeAA--.46853S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYKCmqMShwO+AABsA
X-CM-DELIVERINFO: =?B?+KrFppMTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9GxIaQvpGboqnYa+ZXUsHlzEhzMySoCfY9TbEIBlpQlHv1WRWlGmo9NvsHkN9uF4BwhM
	B+qqRX/fu2BHj5NNNl5rs4g6oena4Cqylr9Fl4EGiukbPNaKFaI1+7IwKsexVw==
X-Coremail-Antispam: 1Uk129KBj93XoW7KF1Uuw4UAF1fJry3ZFyUtwc_yoW8trW7pF
	Wrtr90yFWUX3WxGFn7CF13ur42ga98Aw4aq3yUCw42y39xAF1j9a18KFy7XF48Zr1xJwsr
	GrWYyrW3Xay8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrJv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYo7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x
	07jUiSLUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Aug 2026 05:32:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4685

I looked at the repo and there's no RELEASE_2_20260729 tag. Or am I 
missing something?

The last upgrade did not actually upgrade to RELEASE_2_20260616. If you 
want to do the upgrade, please use RELEASE_2_20260616.

Regards,
Qi

On 8/18/26 17:44, Fang Wu via lists.yoctoproject.org wrote:
> Update SRCREV to pick up the latest commits from the SELinuxProject
> refpolicy upstream, including:
>
> * a7e7df1b seatd: allow self fifo_file read/write for signal handling
> * a1a878c2 adb: add SELinux policy for adbd and adb shell support
> * fdea2b8d wireplumber: add SELinux policy module
> * 0e8bfe52 tpm2: fix tpm2-abrmd D-Bus communication under enforcing mode
> * d3e82b72 lvm: label dmeventd on all distros, not only gentoo
> * 74cdfe59 pipewire: add policy for PipeWire multimedia daemon
> * d4a85ae3 wayland: Label sockets under /run with wayland_runtime_t
> * 5352d9c1 Fix file_contexts for systemd runtime generator output directories
> * 9417c19a rauc: new module for the RAUC embedded update framework
> * f9578765 Allow net_admin to the nfsd_t domain
> * 66a1682f rasdaemon: optionally permit access to ipmitool
> * cc59e75f Remove mptctl_device_t type, alias to fixed_disk_device_t
> * (and more)
>
> Full list at:
> https://github.com/SELinuxProject/refpolicy/compare/30d3cf5abd18...a7e7df1b5bb6
>
> Signed-off-by: fangwu <fangwu@qti.qualcomm.com>
> ---
>   recipes-security/refpolicy/refpolicy_git.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
> index 4d207a2..a3742e4 100644
> --- a/recipes-security/refpolicy/refpolicy_git.inc
> +++ b/recipes-security/refpolicy/refpolicy_git.inc
> @@ -1,8 +1,8 @@
> -PV = 2.20260616+git
> +PV = 2.20260729+git
>   
>   SRC_URI = git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy
>   
> -SRCREV_refpolicy = 30d3cf5abd1872d3da5dd44de37de4251674f736
> +SRCREV_refpolicy = a7e7df1b5bb6b98297c3306bc5b1832a5d86a47a
>   
>   UPSTREAM_CHECK_GITTAGREGEX = RELEASE_(?P<pver>\d+_\d+)
>   


