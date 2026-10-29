Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4211.1793243291915429117
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 20:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wCnYgUxuOJqJEwAAA--.1201S3;
	Thu, 29 Oct 2026 11:06:25 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowAB3umrft+JqbgQnAA--.24663S2;
	Thu, 29 Oct 2026 11:05:03 +0800 (CST)
Message-ID: <64f380e7-374a-48a7-a5e7-dd10870057e1@cetc.com.cn>
Date: Thu, 29 Oct 2026 11:08:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][master][PATCH] package-labeling:
 Add postinst command for labeling
To: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com
References: <2064468.1787219519532860987@lists.yoctoproject.org>
 <20260904163548.631624-1-yannik.tannhaeuser@gmail.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20260904163548.631624-1-yannik.tannhaeuser@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowAB3umrft+JqbgQnAA--.24663S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYPCmrh+88MEAABsg
X-CM-DELIVERINFO: =?B?Ft7BrKc9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOEkTYeE62+DeeO976bFwx8vloLpbuwcxIFke7cH+Dou5deF0erPbmYOMZPH4qHCylqtV
	gorfsstOi+VIULzCk4jAEYa0bMNB+TtixUOq/xJ7xoMJJdYddIxKgUKBBEJbSJlIy0FoSM
	VTRec0FBIqFNo=
X-Coremail-Antispam: 1Uk129KBj9xXoW7Jry3CFW3AFy7Cw4DWw1xZwc_yoWktrcEvw
	4fWryDK34DGr47Wa17KFnxArnY9FsFvas8tw18JF4ay3y5Ar4DZFs7Wr90ya4rtry2vFyU
	uF9rtrWYkr109osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8GbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	GVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU8oa0PUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 03:08:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5177

Hi Yannik,

I checked your patch, and here's my view:

1. On target, the package manager should be able to do the relabel. For 
example, RPM has the ability do that. The current Yocto is not enabling 
'plugins' PACKAGECONFIG, but if you enable it, 'dnf install' will 
automatically relabel the newly installed files.

2. For build time labeling, it should be done at rootfs time (e.g., by 
selinux-image.bbclass).

Regards,
Qi

On 9/5/26 00:31, Yannik Tannhaeuser via lists.yoctoproject.org wrote:
> Hi Joe MacDonald,
>   
> please let me know if you have any suggestions for improving the commit.
> Or if you are not interested in taking this commit.
>   
> Thanks,
> Yannik
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4733): https://lists.yoctoproject.org/g/yocto-patches/message/4733
> Mute This Topic: https://lists.yoctoproject.org/mt/120642387/10573603
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/15343253/10573603/1695603168/xyzzy [chenqi_hycx@cetc.com.cn]
> -=-=-=-=-=-=-=-=-=-=-=-

