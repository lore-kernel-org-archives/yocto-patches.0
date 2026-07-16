Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CEFC4450A
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 23:08:23 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2481.1784243299726639965
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Jul 2026 16:08:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 66GN8CES3040332;
	Thu, 16 Jul 2026 18:08:12 -0500
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 66GN8A0C015063;
	Thu, 16 Jul 2026 18:08:11 -0500
Message-ID: <dcda9217-a9be-4451-97d0-d83ddd6dd70f@kernel.crashing.org>
Date: Thu, 16 Jul 2026 18:08:10 -0500
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
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <b6bfa88be0a54a3edf8e55571d4be4e1d54e736e.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 66GN8CES3040332
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Jul 2026 23:08:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4498



On 7/16/26 5:46 AM, Richard Purdie via lists.yoctoproject.org wrote:
> On Thu, 2026-07-16 at 05:56 +0000, Babanpreet Singh wrote:
>> pseudo's close_range() wrapper has returned ENOSYS unconditionally sin=
ce
>> 35433e6 ("ports/linux/guts: Add close_range wrapper for glibc 2.34").
>> systemd v260 deleted its /proc/self/fd fallback and treats a failure a=
s
>> fatal, so under pseudo every fork+exec dies. That is [YOCTO #16339]. F=
ull
>> story in v1:
>>
>>  =C2=A0 https://lore.kernel.org/yocto-patches/20260715054142.7-1-bbnpr=
eetsingh@gmail.com/
>=20
> I had a quick look through this and it looks ok to me, thanks!
>=20
>> The v1 question about OP_CLOSEFROM stepping around five of pseudo's
>> descriptors while others exist (pseudo_prefix_dir_fd, pseudo_pwd_lck_f=
d,
>> pseudo_util_evlog_fd) still stands; happy to send a follow-up if that =
list
>> is short in both places.
>=20
> I had a quick look and yes, we should really be protecting these too.
>=20
> That said, I couldn't see what pseudo_prefix_dir_fd actually helps with
> and I couldn't see why we need that...

This isn't a part of the system I've touched in a very long time.  I THOU=
GHT it=20
was the fd of the directory PSEUDO_PREFIX, so then when other files (sock=
ets,=20
etc) needed to be opened, it was all relative to the fd.  This allowed th=
e=20
directory to 'move' if necessary, since we were sure we could still acces=
s it=20
via the 'fd'.  (or I'm completely wrong and remembering something differe=
nt.)

The only 'definitive' reference I can find doesn't explain the why, just =
the=20
what doc/program_flow.

I wonder if it was done to hold a file description on the directory so th=
at if=20
the PSEUDO_PATH was rm'd it wouldn't clear until pseudo itself was unload=
ed.

--Mark

> Cheers,
>=20
> Richard
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4494): https://lists.yoctoproject.org/g/yocto-patch=
es/message/4494
> Mute This Topic: https://lists.yoctoproject.org/mt/120294678/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201=
099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

