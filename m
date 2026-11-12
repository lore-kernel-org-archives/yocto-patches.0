Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7744.1794463250710156194
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 22:00:51 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wCnOt2RVfVq2esGAA--.32000S3;
	Thu, 12 Nov 2026 13:58:42 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABH2GgGVvVqsT80AA--.59336S2;
	Thu, 12 Nov 2026 14:00:38 +0800 (CST)
Message-ID: <811395f2-4874-4728-8c50-2ed887d21b27@cetc.com.cn>
Date: Thu, 12 Nov 2026 14:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH v3] refpolicy: upgrade to
 20261109+git
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
References: <4a8dcdf93c4a51793e95ba1e2ffa9ef1f12a37c4.1794453367.git.wenwfu@qti.qualcomm.com>
 <19810872a41f8dd6ac59dae1aa8e722866cea603.1794462087.git.wenwfu@qti.qualcomm.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <19810872a41f8dd6ac59dae1aa8e722866cea603.1794462087.git.wenwfu@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowABH2GgGVvVqsT80AA--.59336S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYJCmr0bxcT7wAAsd
X-CM-DELIVERINFO: =?B?trngb6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOBjikTaASO0jFnSVrl+VCd5eECpTUZ/686rR/WTCKRhLkhmjMgX4vj9/N5IJUutFMXov
	iNbuq3l/1R8UqRNKhoJ2c0duxW6JhNXkW2Qrz3YgIRSZp2ONeknfqyEbZK9ZbQ==
X-Coremail-Antispam: 1Uk129KBj93XoWrur1kWF48uFykGw1DJryxWFX_yoW8JF48pF
	4ftF98CFW8X3WxJ3WxGF15uF12va45C3y3Zay8Cw42y398X3Wj9w48GFZrWr4F9w47trs7
	t3sIyrZxXay8AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3gc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_GrJv73VFW2AG
	mfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5R7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2
	IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l
	84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1Y6r17MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUiSLUUUUU=
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 06:00:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5316

The PV number needs to match the release tag. So it needs to remain as 
20260922 for now.

```
$ git tag | grep RELEASE_2_2026 | tail -5
RELEASE_2_20260312
RELEASE_2_20260616
RELEASE_2_20260922
```

Regards,
Qi

On 11/12/26 13:45, Wenwen Fu via yocto-patches wrote:
> * 6072cfa851a3 unconfined: allow perf event access for unconfined
> domains
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> ---
>   recipes-security/refpolicy/refpolicy_git.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
> index dbc8cc8..de0bb56 100644
> --- a/recipes-security/refpolicy/refpolicy_git.inc
> +++ b/recipes-security/refpolicy/refpolicy_git.inc
> @@ -1,8 +1,8 @@
> -PV = "2.20260922+git"
> +PV = "2.20261109+git"
>   
>   SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
>   
> -SRCREV_refpolicy = "acf41c52116fef3a9dcd8f1f39b133e0372fce7c"
> +SRCREV_refpolicy = "8f247dafb92bd12cbfb53a11ff58be17a88df86a"
>   
>   UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
>   

