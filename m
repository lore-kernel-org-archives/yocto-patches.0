Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5FFC43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 18:59:41 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52620.1782932377697564304
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Jul 2026 11:59:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 661IxZ4f3780214;
	Wed, 1 Jul 2026 13:59:36 -0500
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 661IxZPB023691;
	Wed, 1 Jul 2026 13:59:35 -0500
Message-ID: <229fadfc-4c6d-4f04-9b4c-61c949e3243b@kernel.crashing.org>
Date: Wed, 1 Jul 2026 13:59:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH 1/7] pseudo.h: Avoid accessing
 unallocated memory
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net
References: <20260701131336.3578279-1-richard.purdie@linuxfoundation.org>
 <1a6863b7-b95f-4330-913d-8230827212a9@kernel.crashing.org>
 <340bdc220ec5eff7e0542e825ddde89ce451531f.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <340bdc220ec5eff7e0542e825ddde89ce451531f.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 661IxZ4f3780214
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Jul 2026 18:59:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4352



On 7/1/26 11:47 AM, Richard Purdie via lists.yoctoproject.org wrote:
> On Wed, 2026-07-01 at 11:40 -0500, Mark Hatle wrote:
>> On 7/1/26 8:13 AM, Richard Purdie wrote:
>>> We can call STARTSWITH in cases where the item being searched for is =
longer
>>> than the string itself. Switch from memcmp to strncmp to avoid access=
ing
>>> unassigned memory.
>>>
>>> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>>> ---
>>>  =C2=A0 pseudo.h | 2 +-
>>>  =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/pseudo.h b/pseudo.h
>>> index b6c13f2..1152c19 100644
>>> --- a/pseudo.h
>>> +++ b/pseudo.h
>>> @@ -99,7 +99,7 @@ extern char *pseudo_version;
>>>  =C2=A0=C2=A0 #define PSEUDO_LIBDIR "lib"
>>>  =C2=A0 #endif
>>>   =20
>>> -#define STARTSWITH(x, y) (!memcmp((x), (y), sizeof(y) - 1))
>>> +#define STARTSWITH(x, y) (strncmp(y, x, strlen(y)) =3D=3D 0)
>>
>> I've not looked at the users of STARTSWITH.=C2=A0 If they are all stri=
ngs this is
>> fine.=C2=A0 I believe memcmp was originally used because it could be i=
tems with nulls
>> in it.=C2=A0 The bug may be that 'sizeof' was not calculated properly =
(specifically
>> checking both X and Y, only y.. which can lead that the issue.)
>=20
> It is only used by pseudo_util.c against envp:
>=20
> pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=3D")) {
> pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=3D")) {
> pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_PATH "=3D")) {
> pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=3D")) conti=
nue;
> pseudo_util.c:		if (STARTSWITH(envp[i], PRELINK_PATH "=3D")) continue;
>=20
> i.e. always on strings.
>=20
> The bug is that y can be longer than x and the memcmp check doesn't
> check for that. I could have put more logic in there but we may as well
> just use strncmp.

Agreed, if we're limiting to strings then better to use strncmp.

--Mark

> Cheers,
>=20
> Richard
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4351): https://lists.yoctoproject.org/g/yocto-patch=
es/message/4351
> Mute This Topic: https://lists.yoctoproject.org/mt/120064771/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201=
099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

