Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8595.1794468748996061713
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 23:32:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAXAdcJa_VqL_kGAA--.27900S3;
	Thu, 12 Nov 2026 15:30:18 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowABn+WmBa_VqTFE0AA--.7985S2;
	Thu, 12 Nov 2026 15:32:17 +0800 (CST)
Message-ID: <af80b66d-46e1-4c4b-a7d6-e97428921ef7@cetc.com.cn>
Date: Thu, 12 Nov 2026 15:32:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH v4] refpolicy: update to
 latest git rev
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
References: <19810872a41f8dd6ac59dae1aa8e722866cea603.1794462087.git.wenwfu@qti.qualcomm.com>
 <20261112063642.728190-1-wenwfu@qti.qualcomm.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20261112063642.728190-1-wenwfu@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowABn+WmBa_VqTFE0AA--.7985S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYJCmr0bxcYCAABsw
X-CM-DELIVERINFO: =?B?vY7ws6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOBjikTaASO0jFnSVrl+VCd5fz+2oYsNpgrf95wd8otBQ0RarPPQ2qsEaoTqTGMZOBS8R
	L+SGBlfqcfSkEd/GOj1bATXBU7bTYZ60R7Dau2xY9bbs01sujNIBsgWz6bGNEg==
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr4xGFWkGw4kurWfGr18tFc_yoWDZFg_GF
	WDZ393ur45AFWUtF48AryfAFn0934fKryYgr4xKrnFg345Aw1Skr48X3WfGrZxKF1UJ3W0
	gF9rWFyY9r17uosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8CbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr
	v_JF1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU88HUDUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 07:32:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5320

Merged

Regards,
Qi

On 11/12/26 14:36, Wenwen Fu via yocto-patches wrote:
> * 6072cfa851a3 unconfined: allow perf event access for
>    unconfined domains
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
> ---
>   recipes-security/refpolicy/refpolicy_git.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
> index dbc8cc8..67a727b 100644
> --- a/recipes-security/refpolicy/refpolicy_git.inc
> +++ b/recipes-security/refpolicy/refpolicy_git.inc
> @@ -2,7 +2,7 @@ PV = "2.20260922+git"
>   
>   SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
>   
> -SRCREV_refpolicy = "acf41c52116fef3a9dcd8f1f39b133e0372fce7c"
> +SRCREV_refpolicy = "8f247dafb92bd12cbfb53a11ff58be17a88df86a"
>   
>   UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
>   

