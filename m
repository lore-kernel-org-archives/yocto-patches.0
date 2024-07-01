Return-Path: <gael.portay@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D2C30653
	for <webhook@archiver.kernel.org>; Mon,  1 Jul 2024 12:34:55 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.18704.1719837289894183183
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jul 2024 05:34:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fZnCHgVT;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: gael.portay@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4256aee6e4dso21942165e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 05:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719837287; x=1720442087; darn=lists.yoctoproject.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vo2Xf7fI2IFALngEXL+p5cJ3lOGt1HpXUdQjQgutj9Y=;
        b=fZnCHgVTCAjmScZLKejTkAeMaiTTon+9/TUwkqnqk9UNwFwKD87J0R7gQbIm3hBCR0
         2zw/g5LSP/TrQZuoSIlRUA4if5+mTgI9XH/DF3X+PN1zuSqznOpLfddxSgHifTWEdu3y
         Wk7pfmMIO0qmAwH8ne+CTx+sBMlHDX+6PhuhnMOEIkBECLLT8l9pMVQelDErD2lfPExX
         8GAxDIco+gOPEPUR3nfNiw3vJAIbDkaDIShJEim8G/K8LHq/tifbkcXh6tMXGRbfz5My
         xF972ZGTN7hMJjvxOlEgqz07QWpOyKlSOJsmvEu8sYa1g8fXGnz+q+2/VRyawRqgA7w4
         CQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719837287; x=1720442087;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vo2Xf7fI2IFALngEXL+p5cJ3lOGt1HpXUdQjQgutj9Y=;
        b=BODa1W1d7PH+nkF/AkOG0ZKdqEK23Xmv9mAjrzf3gSh/hxb61hzrg6oh+saWtbFg+r
         b9NX+kag55HFonSkZjqEq6SsSW7jvCvDbMqgrfvarSQB2iFBSZIbvAO/zggxpCUFwbji
         EKsSaBL4G90IXDwUrlonA88i8TQT2esNg/MhjPwFICeQY9uGTdcrU+YEjdwy2K/doOWK
         QzTPhW7Ew8M7ZcayTs/y92PZViR6rWk7p6mktPoTH6v8A+LWxeSO0qO4aFQCbw3qTTek
         91gVQ99E84wBVCtrXzAyFOI0bvwjhBd0PePHOvGsmh0Xar4EMcPy9BeSsm9NPJeyLXIf
         AK0A==
X-Gm-Message-State: AOJu0YyIzgY4HXI0vcRtqvSQS3TmpUz51hKO9rFz6PP891mR4F71G71J
	oW4zLlj/RoYjH94h/WhkVaeRuplbqIvlW0HZhbr2RDeeSuxD+hOi35JRPzH9
X-Google-Smtp-Source: AGHT+IG9A+TY/e6msbNb9RPR3NDM+H87dfj+a2WxUM7calHZblSjmcft7wXjtNsmIxSRI1yDlZOMlg==
X-Received: by 2002:a05:600c:1c88:b0:424:ab90:ecf0 with SMTP id 5b1f17b1804b1-4257a020ecdmr38158805e9.31.1719837287263;
        Mon, 01 Jul 2024 05:34:47 -0700 (PDT)
Received: from localhost ([2a01:e0a:ce:f2f0:3a7c:76ff:fe01:6f05])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e0661sm9843444f8f.47.2024.07.01.05.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 05:34:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 14:34:46 +0200
Message-Id: <D2E7FQ0UNZDW.1APBADSZZNJ95@gmail.com>
From: =?utf-8?q?Ga=C3=ABl_PORTAY?= <gael.portay@gmail.com>
To: <yocto-patches@lists.yoctoproject.org>
Cc: <gael.portay+yocto@gmail.com>, =?utf-8?q?Ga=C3=ABl_PORTAY?=
 <gael.portay@rtone.fr>
Subject: Re: [yocto-patches] [meta-security,kirkstone][PATCH 2/5] sssd: fix
 ac_cv_prog_HAVE_PYTHON3 value
X-Mailer: aerc 0.17.0-0-g6ea74eb30457
References: <20240626133913.790145-1-gael.portay@rtone.fr>
 <20240626133913.790145-3-gael.portay@rtone.fr>
 <8af766e7-bb2b-400e-83df-3e5b20087f98@gmail.com>
In-Reply-To: <8af766e7-bb2b-400e-83df-3e5b20087f98@gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jul 2024 12:34:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/399

Hello,

On Mon Jul 1, 2024 at 1:12 PM CEST, Armin Kuster via lists.yoctoproject.org=
 wrote:
>
>
> On 6/26/24 9:39 AM, "Ga=C3=ABl PORTAY via lists.yoctoproject.org wrote:
> > The variable HAVE_PYTHON3 expects a boolean value[1] and the configure
> > script raises an error if the option --with-python3-bindings is set and
> > if the value HAVE_PYTHON3 is not "yes"[2].
> >
> > The recipe sets a non-boolean value to ac_cv_prog_HAVE_PYTHON3 and thus
> > causes the task do_configure to fail.
>
> Does this apply to master?
>

The change does not apply as is because of the context has changed a
bit: the line below has been modified since kirkstone.

> - armin
> >
> > This fixes the value set to ac_cv_prog_HAVE_PYTHON3 by setting it to ye=
s
> > instead of $(PYTHON_DIR).
> >
> > Fixes:
> >
> > 	| checking for python3... (cached) python3.10
> > 	| configure: error:
> > 	| The program python3 was not found in search path.
> > 	| Please ensure that it is installed and its directory is included in =
the search
> > 	| path. It is required for building python3 bindings. If you do not wa=
nt to build
> > 	| them please use argument --without-python3-bindings when running con=
figure.
> > 	| NOTE: The following config.log files may provide further information=
.
> >
> > [1]: https://github.com/SSSD/sssd/blob/2.5.2/configure.ac#L323-L325
> > [2]: https://github.com/SSSD/sssd/blob/2.5.2/configure.ac#L353-L377
> >
> > Signed-off-by: Ga=C3=ABl PORTAY <gael.portay@rtone.fr>
> > ---
> >   recipes-security/sssd/sssd_2.5.2.bb | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sss=
d/sssd_2.5.2.bb
> > index fe82452..98a4b5e 100644
> > --- a/recipes-security/sssd/sssd_2.5.2.bb
> > +++ b/recipes-security/sssd/sssd_2.5.2.bb
> > @@ -41,7 +41,7 @@ SSSD_UID ?=3D "root"
> >   SSSD_GID ?=3D "root"
> >  =20
> >   CACHED_CONFIGUREVARS =3D "ac_cv_member_struct_ldap_conncb_lc_arg=3Dno=
 \
> > -    ac_cv_prog_HAVE_PYTHON3=3D${PYTHON_DIR} \
> > +    ac_cv_prog_HAVE_PYTHON3=3Dyes \
> >       "
> >  =20
> >   PACKAGECONFIG ?=3D"nss nscd autofs sudo infopipe"

The line is now:

	PACKAGECONFIG ?=3D"nss autofs sudo infopipe"

>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#395): https://lists.yoctoproject.org/g/yocto-patches/=
message/395
> Mute This Topic: https://lists.yoctoproject.org/mt/106889412/8642966
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1340402=
1/8642966/1905432541/xyzzy [gael.portay+yocto@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

Regards,
Ga=C3=ABl

Here is the change (untested):

----- >8 ---------------------------------------------------------------

 .../networking-layer/recipes-security/sssd/sssd_2.9.2.bb        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9=
.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index 058d80d..2ab72ae 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -38,7 +38,7 @@ SSSD_UID ?=3D "root"
 SSSD_GID ?=3D "root"
=20
 CACHED_CONFIGUREVARS =3D "ac_cv_member_struct_ldap_conncb_lc_arg=3Dno \
-    ac_cv_prog_HAVE_PYTHON3=3D${PYTHON_DIR} \
+    ac_cv_prog_HAVE_PYTHON3=3Dyes \
     "
=20
 PACKAGECONFIG ?=3D"nss autofs sudo infopipe"

