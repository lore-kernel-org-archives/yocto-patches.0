Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7861.1794876104726352206
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 16:41:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wDXv7FCovtqvTkBAA--.1746S3;
	Tue, 17 Nov 2026 08:39:31 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACHGWq8ovtq6ck4AA--.15285S2;
	Tue, 17 Nov 2026 08:41:33 +0800 (CST)
Message-ID: <452777be-1505-46c8-bace-cf22e5b5ed8c@cetc.com.cn>
Date: Tue, 17 Nov 2026 08:41:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 3/6] refpolicy_common: ensure we start
 from a clean state in do_compile
To: yocto-patches@lists.yoctoproject.org,
 Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc: chen_q07@163.com
References: <20261116025620.2558594-1-chenqi_hycx@cetc.com.cn>
 <20261116025620.2558594-4-chenqi_hycx@cetc.com.cn>
 <ac2f592c-a707-4bad-ac36-3f003ba449a5@gmail.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <ac2f592c-a707-4bad-ac36-3f003ba449a5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowACHGWq8ovtq6ck4AA--.15285S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYOCmr7CF0DcQAAs1
X-CM-DELIVERINFO: =?B?361pWac9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOLy7F2L/bYVz82xzNKeppBgNcx0QwbAnc5S0zjQM0Bao1o9u2FApvFzLFNBz12cLfH/0
	fdhm/AQiNCVIB+5UUai0LReB8E/1ugNpQnsCIfqYixr1d1CyVuj923K+b3Rm0g==
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw1kJr45XF1DCry7ur48AFc_yoW8WF4fp3
	Wv9rWUtw4DtF4xAa97C3WFvr10ga9Iva9xtryDur1IyFyF9a4xJ3WxXryag3s8Gw4SvFy3
	XFs8JFykJ3yUCagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3qc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_tbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUkmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	kIecxEwVAFwVWDMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXV
	WUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU
	crgADUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Nov 2026 00:41:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5459

Hi Clayton,

This 'make bare' not only solves the legacy booleans.conf but also the 
legacy modules.conf issue. So I think it's a correct thing to do.

There's a POLICY_BOOLEANS variable recently introduced into 
meta-selinux: 
git.yoctoproject.org/meta-selinux/commit/?id=3fc98271005b8c5a9ccb77ddb6aa675106c4dfe8

For your use case, you can use one of the following ways:
1) Switch to use POLICY_BOOLEANS
2) Copy your custom booleans.conf in set_policy_booleans:append

Regards,
Qi

On 11/16/26 23:11, Clayton Casciato via yocto-patches wrote:
> Hi, Qi
>
>> @
>> The `bare` make target is to "delete all remaining generated files,
>> including modules.conf, and booleans.conf."[1]
>> @
>> If we don't do 'make bare' at the start of do_compile, legacy build
>> artifacts such as booleans.conf, generated_definitions.conf, etc.
>> will remain there, making the building results unexpected.
> This may be the correct thing to do but would likely break my current
> workflow.
>
> In a private layer, I keep a "booleans.conf" that I apply via
> do_configure:prepend.
>
> Thanks!
>
> Clayton Casciato
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5408): https://lists.yoctoproject.org/g/yocto-patches/message/5408
> Mute This Topic: https://lists.yoctoproject.org/mt/122288860/10573603
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/15343253/10573603/1695603168/xyzzy [chenqi_hycx@cetc.com.cn]
> -=-=-=-=-=-=-=-=-=-=-=-

