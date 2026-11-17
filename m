Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8394.1794877873077305511
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 17:11:13 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wAnEJYoqftqrj0BAA--.1850S3;
	Tue, 17 Nov 2026 09:08:57 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowADneWqfqftqBdE4AA--.15994S2;
	Tue, 17 Nov 2026 09:10:55 +0800 (CST)
Message-ID: <954eae3a-f2ab-46e9-9952-5cd29bdc4c2a@cetc.com.cn>
Date: Tue, 17 Nov 2026 09:10:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 6/6] refpolicy-targeted: allow
 ssh_sysadm_login by default
To: yocto-patches@lists.yoctoproject.org,
 Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc: chen_q07@163.com
References: <20261116025714.2558951-1-chenqi_hycx@cetc.com.cn>
 <75e87558-98fa-42a4-83b6-efd9eff0ad1d@gmail.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <75e87558-98fa-42a4-83b6-efd9eff0ad1d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowADneWqfqftqBdE4AA--.15994S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYOCmr7CF0F1gABsV
X-CM-DELIVERINFO: =?B?ai2mMac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOLy7F2L/bYVz82xzNKeppBi1DhA57aachUQmapsukth0vaAJ65ETpTgGmYBYBR3gGS+Q
	Xrnj1rNajR5ZInFY7z0IyXf5aGfetzUvNCkc9xNWtSY6zgOiH25fwGpNl9QclA==
X-Coremail-Antispam: 1Uk129KBj93XoWxJFWkur1UGFykGF48Kw1xZwc_yoW5GFW8pF
	W8CrZayw4qqFWxArnrC3WYv3WjqFWYv3yaqa4UGw1kZa1ruF18Cw1Iq3y3WF1DuF43CF1x
	AFW3Arn3Wa1UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3qc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_KbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxUzv38DUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 01:11:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5460

Hi Clayton,

See comments inline.

On 11/16/26 22:49, Clayton Casciato via yocto-patches wrote:
> Hi, Qi
>
>> The targeted repolicy is a looser policy than standard/mcs/mls
> Nit: repolicy -> refpolicy
>
>> variants. What surprises users is that a looser repolicy does not
> Nit: repolicy -> refpolicy
>
> Yes, this surprised me: https://github.com/SELinuxProject/refpolicy/pull/914
>
>> allow ssh login while the sticter ones do.
> Nit: sticter -> stricter
Thanks for your review. I'll fix these typos in V2.
>
>> @
>> This is because Yocto's targeted policy is making users land in
>> unconfined_u selinux user by default, and unconfined_u is treated
>> as privileged user, thus being forbidden by default as the default
>> value of ssh_sysadm_login is false.
> A Yocto mechanism could be added to map users; I do this in a private
> layer.

I currently don't like refpolicy-targeted using a patch to change the 
user mapping: 
https://git.yoctoproject.org/meta-selinux/tree/recipes-security/refpolicy/refpolicy/0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch

I guess there might be some better way but I haven't got time to look 
into that further.

Do you want to fix this refpolicy-targeted with your user mapping 
mechanism? I think that would be a very good change for meta-selinux.

>> @
>> Change to enable ssh_sysadm_login for targeted thus minimal by
>> default.
>> @
> I don't think ssh_sysadm_login should be enabled by default, given:
> * RefPolicy upstream doesn't do so (secure by default)
> * Yocto generally doesn't do so [1]
>
> What are your thoughts on adding a configuration fragment instead,
> similar to [1]?

Good idea. My main focus is to make testimage work for the 
refpolicy-targeted so that it can also be tested automatically. Looks 
like this is a similar use case with 'root-login-with-empty-password'.

I'll use this approach in V2.

Regards,
Qi

>
> [1] https://docs.yoctoproject.org/security-manual/securing-images.html#considerations-specific-to-the-openembedded-build-system
>
> Thanks!
>
> Clayton Casciato
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5407): https://lists.yoctoproject.org/g/yocto-patches/message/5407
> Mute This Topic: https://lists.yoctoproject.org/mt/122288866/10573603
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/15343253/10573603/1695603168/xyzzy [chenqi_hycx@cetc.com.cn]
> -=-=-=-=-=-=-=-=-=-=-=-

