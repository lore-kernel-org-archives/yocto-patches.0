Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4074.1793242752654235829
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 19:59:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wCnYgUNtuJqs0oAAA--.1172S3;
	Thu, 29 Oct 2026 10:57:18 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADneWqyteJqzgEnAA--.25465S2;
	Thu, 29 Oct 2026 10:55:54 +0800 (CST)
Message-ID: <0a30344e-aacc-4b71-a87e-82fa30e122dc@cetc.com.cn>
Date: Thu, 29 Oct 2026 10:58:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] refpolicy_common: strip
 POLICY_CUSTOM_BUILDOPT before passing to make
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 rchiluka@qti.qualcomm.com
References: <20260812060045.244559-1-rchiluka@qti.qualcomm.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20260812060045.244559-1-rchiluka@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowADneWqyteJqzgEnAA--.25465S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYPCmrh+hMMEAAAs-
X-CM-DELIVERINFO: =?B?XNuYSqc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOKAVCGp4YV81L5jQR5ux1rjmJBeMPRNVr8yjJ1OG7eLk6oG3vgHRPJzfSk6z8bAQkAFT
	zBgRrVV0Cp+Jomm75ySdhWiKs4vOoP98FHXh0TCBNaVFgKI1nPbcORymNJvlMw==
X-Coremail-Antispam: 1Uk129KBj93XoWxJrykCF4fWryfKFy5WFW8Zrc_yoW8Gr1rp3
	y7t34Yya4jqFyIgrnrCFy8W3srGas8Jw1UuryDGFs8Awn8Ja48C3ykX3s7Wa1fZry7Awn7
	Ar1avay7Cw4UAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrUv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYb7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r126r1DMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07Ui2-5UUUUU
	=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 02:59:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5176

Merged

Regards,
Qi

On 8/12/26 14:00, Rohith Chiluka via lists.yoctoproject.org wrote:
> POLICY_CUSTOM_BUILDOPT is passed directly to the refpolicy make command
> as CUSTOM_BUILDOPT. When layers use ':append' to extend this variable
> (e.g. POLICY_CUSTOM_BUILDOPT:append:distro = " option"), BitBake
> introduces a leading space. Passing that raw value to make causes:
>
>    make: *** No rule to make target 'option'.  Stop.
>
> Signed-off-by: Chiluka Rohith <rchiluka@qti.qualcomm.com>
> ---
>   recipes-security/refpolicy/refpolicy_common.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
> index 014714c..1566591 100644
> --- a/recipes-security/refpolicy/refpolicy_common.inc
> +++ b/recipes-security/refpolicy/refpolicy_common.inc
> @@ -126,7 +126,7 @@ EXTRA_OEMAKE = "NAME=${POLICY_NAME} \
>       DIRECT_INITRC=${POLICY_DIRECT_INITRC} \
>       SYSTEMD=${POLICY_SYSTEMD} \
>       MONOLITHIC=${POLICY_MONOLITHIC} \
> -    CUSTOM_BUILDOPT=${POLICY_CUSTOM_BUILDOPT} \
> +    CUSTOM_BUILDOPT=${@d.getVar('POLICY_CUSTOM_BUILDOPT').strip()} \
>       QUIET=${POLICY_QUIET} \
>       MLS_SENS=${POLICY_MLS_SENS} \
>       MLS_CATS=${POLICY_MLS_CATS} \

