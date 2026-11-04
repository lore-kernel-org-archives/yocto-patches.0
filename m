Received: from cetc.com.cn (cetc.com.cn [220.181.39.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4303.1793753956360250545
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 16:59:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cetc.com.cn, ip: 220.181.39.39, mailfrom: chenqi_hycx@cetc.com.cn)
Received: from mail.cetc.com.cn (unknown [123.125.172.206])
	by mtasvr (Coremail) with SMTP id _____wDHStztgupqfU8CAA--.11542S3;
	Wed, 04 Nov 2026 08:57:18 +0800 (CST)
Received: from [192.168.31.243] (unknown [123.125.172.206])
	by front01 (Coremail) with SMTP id C6CowACHGWqZgupqO+0rAA--.46007S2;
	Wed, 04 Nov 2026 08:55:54 +0800 (CST)
Message-ID: <6cfb18e0-8ac6-41a3-9af4-ca734692fda4@cetc.com.cn>
Date: Wed, 4 Nov 2026 08:58:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-selinux][RFC] refpolicy - add "Yocto" distro upstream
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Cc: joe.macdonald@siemens.com, Yi Zhao <yi.zhao@windriver.com>,
 yocto-patches@lists.yoctoproject.org
References: <9fa9f7cb-b82e-4d7e-83af-8027c39590ea@gmail.com>
 <7b3e26c9-b524-4b0f-ac88-5403e256c5d7@gmail.com>
 <24e6a59f-522c-4ef0-a5fd-29af4c160560@windriver.com>
 <7c117fe8-9698-4320-84b6-c53a321f454e@gmail.com>
 <87d913cc-61eb-4527-a080-d77877ede9a3@gmail.com>
 <7933a8f6-337d-40f7-9e07-c5ff8a1f5739@gmail.com>
Content-Language: en-US
From: Chen Qi <chenqi_hycx@cetc.com.cn>
In-Reply-To: <7933a8f6-337d-40f7-9e07-c5ff8a1f5739@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: C6CowACHGWqZgupqO+0rAA--.46007S2
X-CM-SenderInfo: xfkh015lbk5un06fv33fof0zgofq/1tbiAQYBCmrp5NIFtQABsI
X-CM-DELIVERINFO: =?B?INDaH6c9tbm9bwt5VqgwP2Pu2dSP9LtrOQxHOAXUJl/eWtrOBydmTZkAAV6p44o2Ir
	PoOGf+ybSYYtFb9Hm0wXO+e7o2FKA3CYsrg/yFemNK7UGAS2q+uamwPAu9IoyLf1bINPNZ
	nNR5DB9J00HAmvSpXpPr+huwpdocE1MfV6nyTjuYJIkirY2cRgTuIWA86e7YmQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7tF43Ar43JrykAF1kGF1xWFX_yoW8Aw4xpF
	W5JF13Ars7JFy0kw1Ik34jv3WFq3yFyrW3Xry5W340vFZ09FyUJF4IgFyUuas7uF1rXF47
	Aw43Ary3Ja1FyacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3qc02F40EFcxC0VAKzVAqx4xG6I80ewCY02Avz4vE14v_tbIjqfuFe4nv
	WSU5nxnvy29KBjDU0xBIdaVrnRJUUUkCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20V
	C2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkIecxEwVAFwVWDMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuY
	vjxUcrgADUUUU
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 04 Nov 2026 00:59:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5224

Hi Clayton,

I'm very glad to see this! This is exactly what I was thinking.

I haven't started this because I need to do the following work first:
1) Upgrade all recipes to latest versions. In particular, refpolicy 
needs to be upgraded to latest tip of master branch.
2) Establisth OEQA for meta-selinux. I've added some runtime tests 
recently. But there need more.
3) Fix things for latest master to ensure there's no AVC error for some 
selected images.
When the above work items are finished, we'll get a good baseline + 
automatic test cases (OEQA).

With this baseline + OEQA, we can sync with refpolicy upstream and 
maintain the refpolicy Yocto distro in a much easier manner.

Any help is greatly appreciated.

Regards,
Qi

On 11/3/26 21:26, Clayton Casciato wrote:
>>>> On 7/23/25 10:42, Clayton Casciato wrote:
>>>>> >From the upstream maintainer, Chris PeBenito:
>>>>> "I'm not opposed to this, as long as meta-selinux maintainers are
>>>>> willing to maintain/contribute to distro-yocto sections."
>>>>>
>>>>> Are the maintainers and wider community open to this?
>>>> Hi Clayton,
>>>>
>>>>
>>>> Thanks for your work. I have no objection. I think it is a good thing for both upstream and meta-selinux.
>>>>
>>> Thank you, Yi!
>>>
>>> I will leave (at least) the first commit to the maintainers to allow for:
>>> * a decision on the name (e.g. "yocto" or "openembedded")
>>> * prioritization/timing of this effort
>>> * use of historical knowledge and potential patch culling
>>>
>>> Clayton Casciato
>> Hi, Yi
>>
>> Is this still on your radar?
>>
>> --
>> Clayton Casciato
> Thank you for taking on the maintainer role, Qi!
>
> There is an open opportunity to upstream meta-selinux's RefPolicy patches [1].
>
> [1] https://lists.yoctoproject.org/g/yocto-patches/topic/113634417

