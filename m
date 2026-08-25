Return-Path: <chenqi_hycx@cetc.com.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B38C5DF94
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 05:40:24 +0000 (UTC)
Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15497.1787636418966216744
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Aug 2026 22:40:19 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [117.61.153.123])
	by mtasvr (Coremail) with SMTP id _____wBHQKOsKo1qrWoCAA--.11349S3;
	Tue, 25 Aug 2026 13:39:56 +0800 (CST)
Received: from [192.168.0.4] (unknown [117.61.153.123])
	by front01 (Coremail) with SMTP id C6CowABnmmpfKo1qpDweAA--.46894S2;
	Tue, 25 Aug 2026 13:38:40 +0800 (CST)
Message-ID: <64883715-b8f8-4e62-81db-9a0c968a1a08@cetc.com.cn>
Date: Tue, 25 Aug 2026 13:40:13 +0800
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
X-CM-TRANSID: C6CowABnmmpfKo1qpDweAA--.46894S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYKCmqMShwO-gACsF
X-CM-DELIVERINFO: =?B?wNHfM5MTIGijefgSB8euu+6OLk7VHJpweJu2O0jc6H0leTZ35Rt/fA/pqtc40DVWE/
	da9H0+NkjjyUeUvxa5zYm5GFG/tMpfOeoBC8qGeUTNUBWgmJ4tH2Yd6cuyKTlmt4Y2kO7E
	/XLtVvEHsxkW5RkMsHj/0Neg/qYHkaL59/ekq0KV
X-Coremail-Antispam: 1Uk129KBj93XoW7WF15Zw4ftryxur47CF4Utrc_yoW8Xw1Up3
	y7t34Yya4jqayIgrsrCFy8W347Ka98Jw4j9ryDGFs8Awn0qa4xCaykX397ua1fZry7Cwn7
	Aw1ava9rCw4UAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrJv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	126r1DMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UtwIDUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Aug 2026 05:40:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4686

The strip() function only removes leading and trailing whitespaces.

Your original problem looks like a quoting issue. Does something like 
below solve your problem?

CUSTOM_BUILDOPT='${POLICY_CUSTOM_BUILDOPT}'

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


