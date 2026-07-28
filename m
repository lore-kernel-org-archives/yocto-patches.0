Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F05BC54EFC
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 09:22:57 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7690.1785230569623246107
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 02:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UwEzpWNv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47de008b020so524769f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785230568; x=1785835368; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VydumS4qCtDI3PnXwKDUx8CYESA7n/rbgpUGDWzQVaA=;
        b=UwEzpWNv0abmR7hVo5C+aDKmuVRlWuBvk1H18a1aS1+VU0tku2p9aZvUNBH521XLm0
         hZfHUntYFY/ri/iAOA6ThGXS/uErxbZTG5KSILEmplwjoUPRqSFSwUcr+GFsqI4FIbqd
         V65lniviwz6wrLI4EaPGm50Zi7OxqdpXOWp90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785230568; x=1785835368;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VydumS4qCtDI3PnXwKDUx8CYESA7n/rbgpUGDWzQVaA=;
        b=AaoWx4Ja1EoRnC1U7v+QpHnYNoSe5/lZ3XNth62Ir9T9WRZOIS0RYvs04/rw0PHQ4k
         syMxdJxNBs2X53uYQEknAR5Vgc2QGGZOgFCT+msIzAxTCs+bkfL9qu7ylyJEi39cGEep
         q0568gythOr9AfvHvwh8BKd5XFenwhuY+rAUzU3/qg0xQxNDSPEs0Np+ew5oX5c+eCMT
         0W75478v3SzhCesmudmzTWWVt09N6aMQQyyfDIlaRbr/w2MQStijrGQmFhZJFaOATy0h
         p1+dAeXmH9JKlBRzSos78VMhCp0MZDPsrw3APbxVBIxif9+m3wM0kkJzd3sBlepj1JRp
         eH2A==
X-Forwarded-Encrypted: i=1; AHgh+RozbEBsACU8Uq78/38rCYQLvst/4pRQfRYch2RYnIHhQXCTqMRcNxolhW9SRFmbBFm5pldF6NY7OKPd68s4@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yy8M5j7K5DAO29c0uqJLj66a97FoUFCIiNQacYspWdfFH8vor+z
	6lMK2A1WhZfumj0+2I6hTtcyplgUUZdZk+Pbf307SjSj8AY/JA26ZIXUn/Wui3wg85Y=
X-Gm-Gg: AR+sD13w7lxdmERu1IgP+uwElLb3aE9o5ADJ+Q+IlxuupWyLXcxBGvVVuNJ2zZGf38/
	7CQeaMskcoPmbmUdbiV8wdVOZm+eUbgqiB1xWLNTARSA0aDFBqf+QSs9PmPGn/8Fsj6qCU5zJWv
	heV7Y0k5QKaGMqdaO5+6kwkeZTfo+Pz2dknPntuFwjCZNvDK4q4MT4U79yg/OK7JEBat3IS2Po9
	90Uiqn5PmTWDqE13+4+7bdDwacbUKCIcLOY3YuHeqhalYWCgnLPIwoPnp5WvTkWkfR8glVtKpOb
	ftOkJgvDWgdFFah2yso4LQySm+LgYDDhqbrBgrMDNsvas9f7XpEDgmPuVBZXDU/rsWpo95Pwiar
	1uLFLvwLTlw5QLHo3on5yMBK4gb2PSW959Xgn4Nh3D9QMpJXfxgRm2/wBSSdscs/CIFMzLk0FaX
	o4aLra3fT/J3Y9Ck3kIqsUopZoyZmNMI+3DXkTl0h/K1DpnNaOv0PYJcLwIhJqP/+p
X-Received: by 2002:adf:e19c:0:b0:47f:8282:42be with SMTP id ffacd0b85a97d-47fb1ecacaamr1809909f8f.18.1785230567636;
        Tue, 28 Jul 2026 02:22:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1? ([2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6ef25sm52107789f8f.36.2026.07.28.02.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 02:22:46 -0700 (PDT)
Message-ID: <9297eef9b9ebf2871edc82fa03aa03550a622575.camel@linuxfoundation.org>
Subject: Re: [pseudo] [PATCH v2 1/2] ports/linux/guts: Implement
 close_range() instead of returning ENOSYS
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>, 
	yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>, Mark Hatle <mark.hatle@amd.com>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert
 <mail@vincent-haupert.de>
Date: Tue, 28 Jul 2026 10:22:45 +0100
In-Reply-To: <20260716055633.7-2-bbnpreetsingh@gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
	 <20260716055633.7-1-bbnpreetsingh@gmail.com>
	 <20260716055633.7-2-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 09:22:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4556

On Thu, 2026-07-16 at 05:56 +0000, Babanpreet Singh wrote:
> The close_range() wrapper added in 35433e6 ("ports/linux/guts: Add
> close_range wrapper for glibc 2.34") returns ENOSYS on the assumption
> that callers handle that. systemd v260 no longer does: it removed its
> /proc/self/fd fallback and treats a close_range() failure as fatal, so
> every fork+exec under pseudo aborts:
>=20
> =C2=A0=C2=A0=C2=A0 Failed to close all file descriptors: Function not imp=
lemented
> =C2=A0=C2=A0=C2=A0 '(mkfs)' failed with exit status 1.
>=20
> A client side op closes the low descriptors one at a time, skipping the
> ones pseudo needs for itself, and returns the first fd above pseudo's
> own so the caller can pass the rest of the range to the kernel directly.
>=20
> CLOSE_RANGE_UNSHARE is handled by calling unshare(CLONE_FILES) before
> closing anything, so the closes only affect the caller and not other
> processes sharing the descriptor table. Unknown flags and an inverted
> range are rejected with EINVAL before anything is closed.
>=20
> A range starting entirely above INT_MAX cannot contain any of pseudo's
> fds and is also passed straight through.
>=20
> [YOCTO #16339]
>=20
> AI-Generated: Uses Claude (claude-opus-4-8)
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> ---
> =C2=A0enums/op.in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0ports/linux/guts/close_range.c | 54 ++++++++++++++++++++++++++----
> =C2=A0ports/linux/portdefs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 16 +++++++++
> =C2=A0pseudo_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 60 ++++++++++++++++++++++++++++++=
++++
> =C2=A04 files changed, 124 insertions(+), 7 deletions(-)

Unfortunately there is something wrong in this patch. I added this
series and your other series fixing the closed fds and with this patch
present, we see failures:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/50/builds/4259

i.e. linux-libc-headers do_install fails, which is one of the first
pieces of the OE build to use pseudo. This should be reproducible in a
OE build with "bitbake linux-libc-headers -c install", with a patch
like the one below applied to update pseudo.

As soon as I revert this patch, the builds work ok. I also tested with
the second series applied without this patch (patches tweaked to apply)
and that also seems to build ok, so it would appear to be something in
this change.

I've not dug into it in detail yet but I wanted to share the issue now
I've isolated it.

Cheers,

Richard


diff --git a/meta/recipes-devtools/pseudo/pseudo_git.bb b/meta/recipes-devt=
ools/pseudo/pseudo_git.bb
index 9f02d90568..01a66ae21e 100644
--- a/meta/recipes-devtools/pseudo/pseudo_git.bb
+++ b/meta/recipes-devtools/pseudo/pseudo_git.bb
@@ -1,6 +1,6 @@
 require pseudo.inc
=20
-SRC_URI =3D "git://git.yoctoproject.org/pseudo;branch=3Dmaster;protocol=3D=
https;branch=3Dmaster \
+SRC_URI =3D "git://git.yoctoproject.org/pseudo;branch=3Dmaster-next;protoc=
ol=3Dhttps \
            file://fallback-passwd \
            file://fallback-group \
            "
@@ -12,8 +12,8 @@ SRC_URI:append:class-nativesdk =3D " \
     file://older-glibc-symbols.patch"
 SRC_URI[prebuilt.sha256sum] =3D "ed9f456856e9d86359f169f46a70ad7be4190d604=
0282b84c8d97b99072485aa"
=20
-SRCREV =3D "ca47829825f297d7bf83665c0541a9de4aa78009"
-PV =3D "1.9.8+git"
+SRCREV =3D "7f509ca924d27109335c4575d1fb67745c7b3abd"
+PV =3D "1.9.9+git"
=20
 # largefile and 64bit time_t support adds these macros via compiler flags =
globally
 # remove them for pseudo since pseudo intercepts some of the functions whi=
ch will be

