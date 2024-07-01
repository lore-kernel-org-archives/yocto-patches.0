Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF99EC2BD09
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 12:36:55 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.18744.1719837406818111055
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 05:36:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ps0Q2EE0;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: gael.portay@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-362b32fbb3bso1731754f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719837405; x=1720442205; darn=lists.yoctoproject.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSnfPit2kCc8iFBr4hv7ZZOIt4GAsE1ZxkeGZTOZZh4=;
        b=Ps0Q2EE0eyb17aqtJLSV+FnD7m8vTQLLNRBu9LDtXj035eXXihkw93tssJbgxQPYxF
         ZdtNJstSOAh8OG/tmnfwUeAh1HsPOKrG5jLBFNIMbNZTz4tzFyfh42HzdLiM5XmlDqbc
         voRukZxAubyjNLyCLQUAVN1HkXY5FCpMusLG8G03ZlQtu4HIwc2ex5qGE+4gK8yvheKq
         xAge7W9Xs1lVuPo45vjHvZALKtfEhk/YJ9PO1GhjYKPfims58j30jhyIvdJYgrh545wW
         iq+hqlaFQqhZu58zcFzQId/CmJmObCOOBxGTSrLmNkFaGlpsGlZLmV4LNHKWCkw1NIOk
         /00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719837405; x=1720442205;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gSnfPit2kCc8iFBr4hv7ZZOIt4GAsE1ZxkeGZTOZZh4=;
        b=WlA3w2PIEk9jWADi24/t0KjWc54uaOAT5kQX7NqY019jSmRkTy7PmqQU10DRREYMII
         cWy/hHjg/xXEkwY6MPCb2S31qttlL+MntXKk/8q0RRwRRTuExI+6e9Go1OzuljWJCYV6
         c2lzZeohTVyb2otrJVxpfFsx02g1axF6fZQvYdt9ZqYoptuvdlO4QXv4xtk9iMqADioF
         Y12JHRnQTQVDzyjy8N92riP24o3NSUyJiXi7P8WAqTGvKzVMEb7UnQ4W0U19bxqbRCtg
         XvqgNwo3HXtdcNH021uLS154yaw3iS7cECNwgxnpR4zf9XpqvNboQpyqnf3K2ASDCTvc
         es7A==
X-Forwarded-Encrypted: i=1; AJvYcCV5nq0Gt55AbVcAQSYyCrFVJMSNk/dfH3GoDoD60crROU9x4FvK7WrUuK7C9y/28Nhj4kPRUlpPoThBjknHtGffyBYjohl+r5SpOF+NvGQea098u6Y=
X-Gm-Message-State: AOJu0Yy+auFOJA4U+ZDWUClVHqgvjxos0leiE3sbIAIf9iu74exBQhWr
	eqM4bAycpgAWPjhdfq8OLEhfzG48LsVAZXVsHeHo4a4vipQBtVVy
X-Google-Smtp-Source: AGHT+IFlFqQv29bwPtggUVvzBm5gkLDUZdx+gevMf+MowS1C+B+qVAZkdQO42yLpBg3RBB0Vek/KGg==
X-Received: by 2002:a5d:540f:0:b0:362:5a6e:2649 with SMTP id ffacd0b85a97d-3677571b850mr3199127f8f.56.1719837404876;
        Mon, 01 Jul 2024 05:36:44 -0700 (PDT)
Received: from localhost ([2a01:e0a:ce:f2f0:3a7c:76ff:fe01:6f05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8ed0sm9959847f8f.28.2024.07.01.05.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 05:36:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 14:36:43 +0200
Message-Id: <D2E7H83H7XQL.2QA71MQ8MWIID@gmail.com>
Subject: Re: [yocto-patches] [meta-security,kirkstone][PATCH 3/5] sssd: fix
 issue if build machine is Debian
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>
To: "akuster808" <akuster808@gmail.com>,
 <yocto-patches@lists.yoctoproject.org>
Cc: <gael.portay+yocto@gmail.com>, =?utf-8?q?Ga=C3=ABl_PORTAY?=
 <gael.portay@rtone.fr>
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240626133913.790145-1-gael.portay@rtone.fr>
 <20240626133913.790145-4-gael.portay@rtone.fr>
 <81745254-5cb8-4cd2-aa63-368803e104d3@gmail.com>
In-Reply-To: <81745254-5cb8-4cd2-aa63-368803e104d3@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 12:36:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/400

Hello,

On Mon Jul 1, 2024 at 1:12 PM CEST, akuster808 wrote:
>
>
> On 6/26/24 9:39 AM, "Ga=C3=ABl PORTAY via lists.yoctoproject.org wrote:
> > The configure script guesses the target system from the host if no
> > --with-os=3D is set[1]. It is untrue if cross-compiling.
> >
> > The guessed host operating system is used then to do specific things
> > fort target build.
> >
> > The commit[2] passes the downstream debian option --install-layout=3Dde=
b
> > to setup.py[3] if the host system is debian based, and thus, it raises
> > the error attached below as that debian-specific option[4] is not part
> > of the openembedded[5] world.
> >
> > This sets the Fedora operating system thanks to the existing configure
> > option --with-os=3Dfedora, that is relatively sain operating system for
> > the needs of openembedded.
>
> Won't this apply to master as well?
>

The change does not apply as is because of the context has changed a
bit: the line aove has been modified since kirkstone.

> - armin
> > Fixes:
> >
> > 	| (...)/build/tmp/work/aarch64-poky-linux/sssd/2.5.2-r0/build/src/conf=
ig/setup.py:25: DeprecationWarning: The distutils package is deprecated and=
 slated for removal in Python 3.12. Use setuptools or check PEP 632 for pot=
ential alternatives
> > 	|   from distutils.core import setup
> > 	| usage: setup.py [global_opts] cmd1 [cmd1_opts] [cmd2 [cmd2_opts] ...=
]
> > 	|    or: setup.py --help [cmd1 cmd2 ...]
> > 	|    or: setup.py --help-commands
> > 	|    or: setup.py cmd --help
> > 	|
> > 	| error: option --install-layout not recognized
> >
> > Note: Upstream has introduced the "unknown" operating systemd with the
> > upcoming version 2.10.0[6][7]. The change can be backported.
> >
> > [1]: https://github.com/SSSD/sssd/blob/2.5.2/src/external/platform.m4#L=
1-L31
> > [2]: https://github.com/SSSD/sssd/commit/e6ae55d5423434d5dc6c236e8647b3=
3610d30e2e
> > [3]: https://github.com/SSSD/sssd/blob/2.5.2/Makefile.am#L32-L35
> > [4]: https://sources.debian.org/patches/setuptools/68.1.2-2/install-lay=
out.diff/#L7
> > [5]: https://git.openembedded.org/openembedded-core/tree/meta/recipes-d=
evtools/python/python3-setuptools_59.5.0.bb?h=3Dkirkstone
> > [6]: https://github.com/SSSD/sssd/commit/7b32dc0ab877a9061b52868b8efe68=
66c3144b63
> > [7]: https://github.com/SSSD/sssd/pull/7398
> >
> > Signed-off-by: Ga=C3=ABl PORTAY <gael.portay@rtone.fr>
> > ---
> >   recipes-security/sssd/sssd_2.5.2.bb | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sss=
d/sssd_2.5.2.bb
> > index 98a4b5e..9991667 100644
> > --- a/recipes-security/sssd/sssd_2.5.2.bb
> > +++ b/recipes-security/sssd/sssd_2.5.2.bb
> > @@ -73,6 +73,7 @@ EXTRA_OECONF +=3D " \
> >       --without-secrets \

The line is now:

     --enable-pammoddir=3D${base_libdir}/security \

> >       --with-xml-catalog-path=3D${STAGING_ETCDIR_NATIVE}/xml/catalog \
> >       --with-pid-path=3D/run \
> > +    --with-os=3Dfedora \
> >   "
> >  =20
> >   do_configure:prepend() {

Regards,
Ga=C3=ABl

Here is the change (untested):

----- >8 ---------------------------------------------------------------

 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9=
.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index 2ab72ae..cce6786 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -68,6 +68,7 @@ EXTRA_OECONF +=3D " \
     --enable-pammoddir=3D${base_libdir}/security \
     --with-xml-catalog-path=3D${STAGING_ETCDIR_NATIVE}/xml/catalog \
     --with-pid-path=3D/run \
+    --with-os=3Dfedora \
 "

 do_configure:prepend() {

