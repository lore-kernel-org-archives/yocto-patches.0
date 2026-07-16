Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C178DC44512
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 23:16:33 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2586.1784243786754094982
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Jul 2026 16:16:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 66GNGFh43041209;
	Thu, 16 Jul 2026 18:16:15 -0500
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 66GNGEuO015996;
	Thu, 16 Jul 2026 18:16:14 -0500
Message-ID: <302f2831-696c-438c-b25f-ab38a6489142@kernel.crashing.org>
Date: Thu, 16 Jul 2026 18:16:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH v2 0/2] close_range: implement it
 rather than return ENOSYS
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org,
        Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Paul Barker <paul@pbarker.dev>, Mark Hatle <mark.hatle@amd.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Vincent Haupert <mail@vincent-haupert.de>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
 <20260716055633.7-1-bbnpreetsingh@gmail.com>
 <b6bfa88be0a54a3edf8e55571d4be4e1d54e736e.camel@linuxfoundation.org>
 <CAO8wpHypNwFNKPCnwzcgGcMVqHK9DscZ1XO8U1GD29W1kU-NbQ@mail.gmail.com>
 <4321836d169d2ff0e80884717ec1de4aaa868d83.camel@linuxfoundation.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <4321836d169d2ff0e80884717ec1de4aaa868d83.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 66GNGFh43041209
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 23:16:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4499



On 7/16/26 11:55 AM, Richard Purdie via lists.yoctoproject.org wrote:
> On Thu, 2026-07-16 at 08:46 -0700, Babanpreet Singh wrote:
>> Thanks!
>>
>>>  =C2=A0 That said, I couldn't see what pseudo_prefix_dir_fd actually =
helps with
>>> and I couldn't see why we need that...
>>
>> I flagged it since it is held open and a close_range() sweep will wipe=
 it out. I hadn't checked if anything still reads it untill now. It seems=
 like it is just kept open and alive and the socket connection=C2=A0+ fch=
dir() has been moved to pseudo_localstate_dir_fd.
>>
>> So, for the follow-up I'd purpose:
>>
>> 1/2: remove=C2=A0 pseudo_prefix_dir_fd
>> 2/2: add pseudo_pwd_lck_fd and pseudo_util_evlog_fd to the descriptors=
 OP_CLOSEFROM and OP_CLOSE_RANGE step around
>>
>> If you'd rather keep the fd, I'll drop the removal and add it to the p=
rotected set in 2/2 instead.
>=20
> I'd suggest making the series the other way around, protect it for now,
> send a removal patch on top and we can look at the removal patch and
> test and check it isn't really used anywhere. It is possible I'm
> missing some usage of it and I'm curious what Mark thinks.

I agree.  Maybe it's no longer needed, but we're not sure.

The code was introduced VERY early in pseudo development, 2010 era.

The variable, pseudo_prefix_dir_fd was introduced in=20
551bf567c171c9f6f475f02de80e35df9563dce7, but this is based on an earlier=
 commit.

^33d9386 (Peter Seebach 2010-03-16 19:26:24 -0500  713)         pseudo_pa=
th =3D=20
pseudo_prefix_path(NULL);
^33d9386 (Peter Seebach 2010-03-16 19:26:24 -0500  714)         if=20
(pseudo_dir_fd =3D=3D -1) {
^33d9386 (Peter Seebach 2010-03-16 19:26:24 -0500  715)                 i=
f=20
(pseudo_path) {
^33d9386 (Peter Seebach 2010-03-16 19:26:24 -0500  716)=20
pseudo_dir_fd =3D open(pseudo_path, O_RDONLY);
^33d9386 (Peter Seebach 2010-03-16 19:26:24 -0500  717)=20
pseudo_dir_fd =3D pseudo_fd(pseudo_dir_fd, COPY_FD);
^33d9386 (Peter Seebach 2010-03-16 19:26:24 -0500  718)=20
free(pseudo_path);

Unfortunately this was the _FIRST_ commit.  So based on that, there reall=
y is no=20
history why this was added to begin with.

 From looking at that first commit, it was using this fd to spawn the ser=
ver and=20
change the cwd.  By holding an open fd on the path we were sure that the=20
directory wouldn't be removed until all the FDs cleared.  (Some filesyste=
ms you=20
can't delete open directories, other just postpone the removal until the =
fds=20
clear..)

--Mark

> The protection patch makes sense and should be easy to merge compared
> to that.
>=20
> Cheers,
>=20
> Richard
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4497): https://lists.yoctoproject.org/g/yocto-patch=
es/message/4497
> Mute This Topic: https://lists.yoctoproject.org/mt/120294678/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201=
099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

