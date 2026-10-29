Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5107.1793249019940967034
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Oct 2026 21:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAXJtSMzuJq7VoAAA--.39S3;
	Thu, 29 Oct 2026 12:41:49 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADnd2g3zuJq8xUnAA--.4491S2;
	Thu, 29 Oct 2026 12:40:24 +0800 (CST)
Message-ID: <79f05129-a012-463f-bb44-d3d5f6851fa0@cetc.com.cn>
Date: Thu, 29 Oct 2026 12:43:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-selinux][master][PATCH] openssh: restore
 SELinux labels for /var/run/sshd
To: yocto-patches@lists.yoctoproject.org, yannik.tannhaeuser@gmail.com
References: <2064468.1787219475342773998@lists.yoctoproject.org>
 <20260904164959.632803-1-yannik.tannhaeuser@gmail.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <20260904164959.632803-1-yannik.tannhaeuser@gmail.com>
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C6CowADnd2g3zuJq8xUnAA--.4491S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAgYPCmrh+hMOtgACsZ
X-CM-DELIVERINFO: =?B?/3H6Vac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOKAVCGp4YV81L5jQR5ux1rjh73V4mCJKO10RA636dY7zqLb+klUqe0ron7/SyGr+oh5e
	ug0Uksx/ay0/3rFbnj5e0aVt22SB2FNRllEVa0O0Zlvz92+LsOJSkrjbVqC35Q==
X-Coremail-Antispam: 1Uk129KBj9xXoW7JFykJFWDuFWrZrWkKry8Zwc_yoWkJrbEy3
	93XFyUKrykCr47Wa18tF17Awn5CFsIqas5tw18JF43ArW3AF40vF4DGF98t34ktr9rZFW5
	Cr12vFWayr1IkosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjgY5I8CrVACY4xI64kE6c02F40Ex7xfMxkIecxEwVAFwVW8XbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUklb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E
	87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kIecxEwVAFwVW8XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jr
	v_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U8Tv35UUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 04:43:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5178
Content-Type: text/plain; charset="utf-8"; format="flowed"

Hi Yannik,

I just built out the image and things are correct regarding /var/run/sshd:

```
root@qemux86-64:~# ls /var/run/sshd -Z -d
system_u:object_r:sshd_runtime_t:s0 /var/run/sshd
root@qemux86-64:~# matchpathcon /var/run/sshd
/var/run/sshd   system_u:object_r:sshd_runtime_t:s0
```

Regards,
Qi

On 9/5/26 00:49, Yannik Tannhaeuser via lists.yoctoproject.org wrote:
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
> View/Reply Online (#4735): https://lists.yoctoproject.org/g/yocto-patches/message/4735
> Mute This Topic: https://lists.yoctoproject.org/mt/120642291/10573603
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/15343253/10573603/1695603168/xyzzy [chenqi_hycx@cetc.com.cn]
> -=-=-=-=-=-=-=-=-=-=-=-

