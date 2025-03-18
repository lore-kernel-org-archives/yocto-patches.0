Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E72C282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 20:08:47 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.5177.1742328519277473263
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Mar 2025 13:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 52IK8b8H026065;
	Tue, 18 Mar 2025 15:08:38 -0500
Received: from [192.168.2.109] ([192.168.2.109])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 52IK8ZuP005010;
	Tue, 18 Mar 2025 15:08:35 -0500
Message-ID: <6b79f551-eca5-4cef-b0dc-104b2e3878d4@kernel.crashing.org>
Date: Tue, 18 Mar 2025 15:08:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH 2/3] Makefile.in: Use ARCH_FLAGS
 instead of -m32 and -m64
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Xiaotian Wu <wuxiaotian@loongson.cn>
References: <20250309060039.454124-1-wuxiaotian@loongson.cn>
 <20250309060039.454124-3-wuxiaotian@loongson.cn>
 <89631d665d97b77ad40924cd5abc003e77c8dcb1.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <89631d665d97b77ad40924cd5abc003e77c8dcb1.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 52IK8b8H026065
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 20:08:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1217



On 3/13/25 10:54 AM, Richard Purdie via lists.yoctoproject.org wrote:
> On Sun, 2025-03-09 at 14:00 +0800, Xiaotian Wu via lists.yoctoproject.o=
rg wrote:
>> Gcc on Loongarch does not support this -m32 and -m64 options.
>> we can use the $(ARCH_CLAGS) variable instead.
>>
>> Signed-off-by: Xiaotian Wu <wuxiaotian@loongson.cn>
>> ---
>>  =C2=A0Makefile.in | 4 ++--
>>  =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Makefile.in b/Makefile.in
>> index 48fdbd2..0bb8a88 100644
>> --- a/Makefile.in
>> +++ b/Makefile.in
>> @@ -157,10 +157,10 @@ pseudo_wrappers.o: $(GUTS) pseudo_wrappers.c pse=
udo_wrapfuncs.c pseudo_wrapfuncs
>>  =C2=A0	$(CC) -fno-strict-aliasing $(CFLAGS) $(CFLAGS_PSEUDO) -D_GNU_S=
OURCE -c -o pseudo_wrappers.o pseudo_wrappers.c
>>  =20
>>  =C2=A0offsets32:
>> -	$(CC) -m32 -o offsets32 offsets.c
>> +	$(CC) $(ARCH_FLAGS) -o offsets32 offsets.c
>>  =20
>>  =C2=A0offsets64:
>> -	$(CC) -m64 -o offsets64 offsets.c
>> +	$(CC) $(ARCH_FLAGS) -o offsets64 offsets.c
>>  =20
>>  =C2=A0$(PSEUDO_PROFILE): pseudo_profile | $(BIN)
>>  =C2=A0	cp pseudo_profile $(BIN)
>=20
> The whole point of those lines is to generate 64 and 32 bit versions of
> those files. A single ARCH_FLAGS value will not do that and it would
> break their existing usage.
>=20
> Since these targets aren't actually referenced anywhere I can see, I'm
> wondering how you ran into this in the first place?
>=20
> This wouldn't work on Arm either but we're not running into it in
> normal build usage.

The offset program is specifically for (from docs/pseudo_ipc):

32/64 bit:  This structure should have the same offsets for every element=
,
including path, on both 64-bit and 32-bit machines.  (Check with 'offsets=
.c'.)
It is *not* an error if sizeof(pseudo_msg_t) is different; the padding
happens after the path element.  (Note:  This is contrary to C99, TC1, bu=
t is
correct according to the current standard.  Anyway, gcc's always done it =
this
way.)  The data written are always pathlen + offsetof(pseudo_msg_t, path)=
,
and that's correct.

So really it's just a utility to verify that IF your architecture has 32 =
and 64=20
bit variants, that you can ensure that the data structure is the same for=
 both.=20
On ARM this _might_ be useful, but I don't think anyone is really running=
 a=20
combination 32-bit and 64-bit system.  Same with other architectures (PPC=
/MIPS/etc.)

Thus the existing implementation is fine, unless someone has a specific w=
orkflow=20
for a specific architecture where we need to use the tool to verify IPC=20
compatibility at runtime.

--Mark


> Cheers,
>=20
> Richard
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1202): https://lists.yoctoproject.org/g/yocto-patch=
es/message/1202
> Mute This Topic: https://lists.yoctoproject.org/mt/111597330/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201=
099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

