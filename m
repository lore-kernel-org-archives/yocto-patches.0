Return-Path: <wuxiaotian@loongson.cn>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA39C28B28
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 03:21:42 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by mx.groups.io with SMTP id smtpd.web11.5467.1741922499165652795
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Mar 2025 20:21:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: loongson.cn, ip: 114.242.206.163, mailfrom: wuxiaotian@loongson.cn)
Received: from loongson.cn (unknown [192.168.100.1])
	by gateway (Coremail) with SMTP id _____8AxQK28oNNnnN2VAA--.41215S3;
	Fri, 14 Mar 2025 11:21:33 +0800 (CST)
Received: from [10.40.24.15] (unknown [192.168.100.1])
	by front1 (Coremail) with SMTP id qMiowMDxu8S4oNNn6xJKAA--.10085S3;
	Fri, 14 Mar 2025 11:21:28 +0800 (CST)
Message-ID: <c9ed6f55-7bb4-4dd3-b1f7-4d4791eeacce@loongson.cn>
Date: Fri, 14 Mar 2025 11:21:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH 3/3] configure: Add support for
 LoongArch
From: Xiaotian Wu <wuxiaotian@loongson.cn>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 yocto-patches@lists.yoctoproject.org
References: <20250309060039.454124-1-wuxiaotian@loongson.cn>
 <20250309060039.454124-4-wuxiaotian@loongson.cn>
 <cc8eb00a6f3790f6e66a6cc868dc3c56d18dd406.camel@linuxfoundation.org>
 <b2f92374-8bf6-4b73-9c24-ddcbfc179c9a@loongson.cn>
Content-Language: en-US
In-Reply-To: <b2f92374-8bf6-4b73-9c24-ddcbfc179c9a@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxu8S4oNNn6xJKAA--.10085S3
X-CM-SenderInfo: 5zx0xtprwlt0o6or00hjvr0hdfq/1tbiAgEBCGfTZuAE2gAAsm
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4xAr18Jr45KF15GFyUArc_yoW8XFWfpa
	nIyFy7GF93uw1rGFn09w1vg390yrykGFn8XFsrt348JFWvkw1xKr409rs3CFy7Xw1fAa1j
	va9Yga47Wa9IyagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Mar 2025 03:21:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1204

After re-testing in OpenEmbeded, it looks like we only need the "[PATCH 
1/3] pseudo_wrappers.c: Add support for LoongArch64" patch to work and 
not the other 2.

在 2025/3/14 09:17, Xiaotian Wu 写道:
>
> 在 2025/3/13 23:48, Richard Purdie 写道:
>> On Sun, 2025-03-09 at 14:00 +0800, Xiaotian Wu via 
>> lists.yoctoproject.org wrote:
>>> Set the default architecture based on the current machine
>>>
>>> Signed-off-by: Xiaotian Wu <wuxiaotian@loongson.cn>
>>> ---
>>>   configure | 11 ++++++++++-
>>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/configure b/configure
>>> index 39b5fbe..9fbba9a 100755
>>> --- a/configure
>>> +++ b/configure
>>> @@ -22,8 +22,17 @@ opt_xattrdb=false
>>>   opt_profile=false
>>>   opt_passwd_fallback='""'
>>>   +UNAME_MACHINE=`(uname -m) 2>/dev/null` || UNAME_MACHINE=x86
>>> +case $UNAME_MACHINE in
>>> +  i*86|x86_64) opt_arch=x86 ;;
>>> +  arm|arm64) opt_arch=arm ;;
>>> +  loongarch32|loongarch64) opt_arch=loongarch ;;
>>> +esac
>>> +
>> Using uname like this is not cross compile compatible and will break
>> pseudo from building in OpenEmbedded. We can't do this...
> Here the default arch parameter is just set based on uname, just like 
> opt_arch=x86 before, and there is still support for rewriting the 
> actual opt_arch with the --arch option, so the functionality hasn't 
> actually changed, and the expectation is that it will still work as 
> before.
>>
>> Cheers,
>>
>> Richard
>
-- 
Best Regards
Xiaotian Wu


