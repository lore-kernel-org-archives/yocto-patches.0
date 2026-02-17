Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41064E909DC
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 16:47:08 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16707.1771346819261213567
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Feb 2026 08:46:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 61HGkwQ3445990;
	Tue, 17 Feb 2026 10:46:58 -0600
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 61HGkwxr020134;
	Tue, 17 Feb 2026 10:46:58 -0600
Message-ID: <b23ffa70-0347-4fbf-999a-abfa2b2daaa6@kernel.crashing.org>
Date: Tue, 17 Feb 2026 10:46:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH] ports/linux: define __NR_openat2
 if missing
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
References: <20260217154814.483670-1-yoann.congal@smile.fr>
 <CAMKF1soOjJDt_UaK4e2wjn6anusCAaa0NnNXzEpkBESnsDVEuw@mail.gmail.com>
 <59b56ed7ba399f476c72c1375dc3f84d14b10220.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <59b56ed7ba399f476c72c1375dc3f84d14b10220.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 61HGkwQ3445990
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 16:47:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3252



On 2/17/26 10:44 AM, Richard Purdie via lists.yoctoproject.org wrote:
> On Tue, 2026-02-17 at 08:38 -0800, Khem Raj via lists.yoctoproject.org
> wrote:
>>
>>
>> On Tue, Feb 17, 2026 at 7:48=E2=80=AFAM Yoann Congal via
>> lists.yoctoproject.org <yoann.congal=3Dsmile.fr@lists.yoctoproject.org=
>
>> wrote:
>>> From: Yoann Congal <yoann.congal@smile.fr>
>>>
>>> On kernel <5.6, __NR_openat2 is not defined. To support build on
>>> these
>>> older kernel, define __NR_openat2 at the value it has on every
>>> kernel
>>> since 5.6: 437 [0].
>>>
>>> [0]:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
>>>
>>> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
>>> ---
>>>  =C2=A0ports/linux/portdefs.h | 10 +++++++++-
>>>  =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
>>> index a8b2be6..32b95ba 100644
>>> --- a/ports/linux/portdefs.h
>>> +++ b/ports/linux/portdefs.h
>>> @@ -54,7 +54,15 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
>>>  =C2=A0#endif
>>>  =C2=A0#endif
>>>
>>> -/* Debian 11 and Opensuse 15.5 need this */
>>> +/* Ubuntu 20.04, Debian 11 and Opensuse 15.5 need this */
>>>  =C2=A0#ifndef SYS_openat2
>>> +
>>> +/* On kernel <5.6, __NR_openat2 is not defined. Import the
>>> definition from
>>> + *
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
>>> + */
>>> +#ifndef __NR_openat2
>>> +#define __NR_openat2 437
>>> +#endif
>>>
>>
>>
>> it will fix compile time problems but I wonder if it will run okay on
>> kernels < 5.6 ?
>=20
> It will be fine. The code should simply never get called and even if it
> did, it is just returns an error code so it wouldn't make any
> difference to the standard behaviour.

Even on an old platform will return ENOSYS which SHOULD be the same as if=
=20
openat2 was called on a pre 5.6 kernel.

So shouldn't be an issue.

--Mark

> Cheers,
>=20
> Richard
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3250): https://lists.yoctoproject.org/g/yocto-patch=
es/message/3250
> Mute This Topic: https://lists.yoctoproject.org/mt/117858536/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201=
099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

