Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3759FC9EC2
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 23:26:07 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.760.1772839560092999178
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 15:26:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 626NPxQX1904224;
	Fri, 6 Mar 2026 17:25:59 -0600
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 626NPrIi020989;
	Fri, 6 Mar 2026 17:25:53 -0600
Message-ID: <e75e0eba-fb5b-4e39-8cdb-d67dfdde9110@kernel.crashing.org>
Date: Fri, 6 Mar 2026 17:25:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH 2/3] ports/linux/openat2: Add
 dummy wrapper
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net
References: <20260113231729.2698563-1-richard.purdie@linuxfoundation.org>
 <20260113231729.2698563-2-richard.purdie@linuxfoundation.org>
 <CA+chaQd5DzfJb7WKZVwZbGUqK_U6zttpNwpG7zm41LM_wbv_Hw@mail.gmail.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <CA+chaQd5DzfJb7WKZVwZbGUqK_U6zttpNwpG7zm41LM_wbv_Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 626NPxQX1904224
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 23:26:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3351



On 3/5/26 11:00 AM, Martin Jansa via lists.yoctoproject.org wrote:
> I've recently upgraded my Gentoo to have glibc-2.43 and I'm working on
> build failures caused by that, I'll send fixed for m-native,
> libunistring-native, dtc-native, systemd. Now gettext and
> pseudo-native remain (when building core-image-minimal).
>=20
> The pseudo-native is a bit strange:
> https://errors.yoctoproject.org/Errors/Details/903979/
>=20
> In file included from pseudo_wrappers.c:300:
> pseudo_wrapfuncs.c: At top level:
> pseudo_wrapfuncs.c:11537:1: error: conflicting types for =E2=80=98opena=
t2=E2=80=99;
> have =E2=80=98int(int,  const char *, struct open_how *, size_t)=E2=80=99=
 {aka
> =E2=80=98int(int,  const char *, struct open_how *, long unsigned int)=E2=
=80=99}
> 11537 | openat2(int dirfd, const char *path, struct open_how *how,
> size_t size) {
>        | ^~~~~~~
> In file included from /usr/include/bits/fcntl-linux.h:492,
>                   from /usr/include/bits/fcntl.h:61,
>                   from /usr/include/fcntl.h:35,
>                   from pseudo_wrappers.c:23:
> /usr/include/bits/fcntl-linux-fortify.h:36:1: note: previous
> definition of =E2=80=98openat2=E2=80=99 with type =E2=80=98int(int,  co=
nst char *, const
> struct open_how *, long unsigned int)=E2=80=99
>     36 | openat2 (int __dfd, const char *__filename, const struct
> open_how *__how,
>        | ^~~~~~~
> make: *** [Makefile:162: pseudo_wrappers.o] Error 1
>=20
> If I use const for struct open_how to match:
> https://sourceware.org/cgit/glibc/commit/?id=3D0f0a5cd338998f4b603f52f3=
ce2163df0db7b814
> then it builds fine, but I assume you had some reason not to use const
> (as this glibc commit existed before pseudo change it seems?).
>=20
> I'll send the update for ports/linux/openat2/guts/openat2.c
> ports/linux/openat2/wrapfuncs.in if it makes sense to use const here.

Answer is that it wasn't a const on the machine I was working on.  So I s=
uspect=20
we've got some mismatches on older machines, but it should be safe to mov=
e non=20
const to const.

--Mark

> Regards,
>=20
>=20
>=20
> On Wed, Jan 14, 2026 at 12:17=E2=80=AFAM Richard Purdie via
> lists.yoctoproject.org
> <richard.purdie=3Dlinuxfoundation.org@lists.yoctoproject.org> wrote:
>>
>> From: "mark.hatle" <mark.hatle@kernel.crashing.org>
>>
>> For now fail politely, most callers have fallback behavior.
>>
>> Signed-off-by: mark.hatle <mark.hatle@kernel.crashing.org>
>> ---
>>   makewrappers                       |  1 +
>>   ports/linux/openat2/guts/openat2.c | 23 +++++++++++++++++++++++
>>   ports/linux/openat2/portdefs.h     | 13 +++++++++++++
>>   ports/linux/openat2/wrapfuncs.in   |  1 +
>>   ports/linux/subports               |  2 ++
>>   5 files changed, 40 insertions(+)
>>   create mode 100644 ports/linux/openat2/guts/openat2.c
>>   create mode 100644 ports/linux/openat2/portdefs.h
>>   create mode 100644 ports/linux/openat2/wrapfuncs.in
>>
>> diff --git a/makewrappers b/makewrappers
>> index 67c73e2..0d73cc1 100755
>> --- a/makewrappers
>> +++ b/makewrappers
>> @@ -209,6 +209,7 @@ typedata =3D {
>>     'ssize_t': { 'format': '%ld', 'value': '(long) rc' },
>>     'struct group *': { 'format': '%p', 'value': '(void *) rc' },
>>     'struct passwd *': { 'format': '%p', 'value': '(void *) rc' },
>> +  'struct open_how *': { 'format': '%p', 'value': '(void *) rc' },
>>     'uid_t': { 'format': '%ld', 'value': ' (long) rc' },
>>     'void *': { 'format': '%p', 'value': 'rc' },
>>     'void': { 'format': 'void%s', 'value': '""' },
>> diff --git a/ports/linux/openat2/guts/openat2.c b/ports/linux/openat2/=
guts/openat2.c
>> new file mode 100644
>> index 0000000..da01b31
>> --- /dev/null
>> +++ b/ports/linux/openat2/guts/openat2.c
>> @@ -0,0 +1,23 @@
>> +/*
>> + * Copyright (c) 2026 Mark Hatle <mark.hatle@amd.com>; see
>> + * guts/COPYRIGHT for information.
>> + *
>> + * SPDX-License-Identifier: LGPL-2.1-only
>> + *
>> + * int openat2(int dirfd, const char *path, struct open_how *how, siz=
e_t size)
>> + *     int rc =3D -1;
>> + */
>> +
>> +       (void) dirfd;
>> +       (void) path;
>> +       (void) how;
>> +       (void) size;
>> +       /* for now, let's try just failing out hard, and hope things r=
etry with a
>> +        * different syscall.
>> +        */
>> +       errno =3D ENOSYS;
>> +       rc =3D -1;
>> +
>> +/*     return rc;
>> + * }
>> + */
>> diff --git a/ports/linux/openat2/portdefs.h b/ports/linux/openat2/port=
defs.h
>> new file mode 100644
>> index 0000000..8e4e33e
>> --- /dev/null
>> +++ b/ports/linux/openat2/portdefs.h
>> @@ -0,0 +1,13 @@
>> +/*
>> + * SPDX-License-Identifier: LGPL-2.1-only
>> + *
>> + */
>> +#if __has_include (<linux/openat2.h>)
>> +# include <linux/openat2.h>
>> +#else
>> +  struct open_how {
>> +        __u64 flags;
>> +        __u64 mode;
>> +        __u64 resolve;
>> +  };
>> +#endif
>> diff --git a/ports/linux/openat2/wrapfuncs.in b/ports/linux/openat2/wr=
apfuncs.in
>> new file mode 100644
>> index 0000000..96ae8a7
>> --- /dev/null
>> +++ b/ports/linux/openat2/wrapfuncs.in
>> @@ -0,0 +1 @@
>> +int openat2(int dirfd, const char *path, struct open_how *how, size_t=
 size);
>> diff --git a/ports/linux/subports b/ports/linux/subports
>> index 099ea59..b202c27 100755
>> --- a/ports/linux/subports
>> +++ b/ports/linux/subports
>> @@ -70,3 +70,5 @@ else
>>   fi
>>   rm -f dummy.c dummy.o
>>
>> +# For openat2, similar to statx, we need to be able to build on syste=
ms without that support.
>> +echo "linux/openat2"
>>
>>
>>
>>
>>
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3339): https://lists.yoctoproject.org/g/yocto-patch=
es/message/3339
> Mute This Topic: https://lists.yoctoproject.org/mt/117253067/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201=
099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

