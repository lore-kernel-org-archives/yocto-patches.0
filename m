Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5150.1793249354653968979
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 21:49:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wCHQgXcz+JqQVsAAA--.1391S3;
	Thu, 29 Oct 2026 12:47:24 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADneWqHz+JqzhYnAA--.25795S2;
	Thu, 29 Oct 2026 12:45:59 +0800 (CST)
Message-ID: <ec878264-7808-4429-8945-62bb7a7ac003@cetc.com.cn>
Date: Thu, 29 Oct 2026 12:49:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][PATCH] layer.conf: update to
 blacksail release series
To: yocto-patches@lists.yoctoproject.org, ricardo.salveti@oss.qualcomm.com
References: <20260927180737.1320993-1-ricardo.salveti@oss.qualcomm.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20260927180737.1320993-1-ricardo.salveti@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowADneWqHz+JqzhYnAA--.25795S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYPCmrh+88P6gABsZ
X-CM-DELIVERINFO: =?B?z3bWNac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOEkTYeE62+DeeO976bFwx8tzFziNmON8jZfwnKDzHz8+tKstVddowC+f5aypJ/YjuyRR
	sBUkFRXMz6zgJUsMIq5s+PDkc1h3eBPVSWSvg1bF11PGRtM0sMtuaBgP43icfw==
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFyftr1UWrWkXw43Ar4rXrc_yoWDAwb_Aa
	1kGwn2vw48AFyxZa1fZr1kAr1fGw18A3WrXayktwsFq34Y9ayFg3yDGayUJw1xt3y5ZFy3
	WFy5G3ySgF4j9osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8XbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
	XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr
	v_JF1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU855r7UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 04:49:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5179

Hi Ricardo,

I'm going through all the patches pending on the mailing list.

I pushed the same change before I found yours. I should have checked all 
the patches before I started doing the fix myself. Sorry about that.

The LAYERSERIES_COMPAT_selinux is now 'blacksail'.

Regards,
Qi

On 9/28/26 02:07, Ricardo Salveti via lists.yoctoproject.org wrote:
> OE-core has switched to using blacksail release name. Adjust
> LAYERSERIES_COMPAT accordingly.
>
> Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
> ---
>   conf/layer.conf | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/conf/layer.conf b/conf/layer.conf
> index 245b4ef..3069dc6 100644
> --- a/conf/layer.conf
> +++ b/conf/layer.conf
> @@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
>   # cause compatibility issues with other layers
>   LAYERVERSION_selinux = "1"
>   
> -LAYERSERIES_COMPAT_selinux = "wrynose"
> +LAYERSERIES_COMPAT_selinux = "blacksail"
>   
>   LAYERDEPENDS_selinux = " \
>       core \

