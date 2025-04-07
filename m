Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDCBC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 14:52:41 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web11.49190.1744037560450319598
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 07:52:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=S6Hqgbi6;
 spf=pass (domain: gmail.com, ip: 209.85.167.169, mailfrom: raj.khem@gmail.com)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3fe9fe62295so1256245b6e.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744037559; x=1744642359; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOhRYzdIaKf9HzFQbVvMkV2IJmJ5VdovhfMksW2zjUU=;
        b=S6Hqgbi6qxVectFrpBjC0g8/r0NHuqIlDX/33gMbsrnGjlP311k8LWasEE0GYCub0Q
         nzYmFTZ5buax8mJyiM4XwEtywsYsEN4lOv9ihQVR8jn545Vs6YAlll5jIR2V6Q4rKbk3
         FCrWm7GLSD8hnZOxl+noIHO7X57p47LTIv9kGp/fIAT1I8Fp/LgHZ2Wutu/R1HG2F6Zx
         1+pkoX2QODE93wJVWBVbsYM8uJkDFfxKCxulg761YMyHMB9hdLmMrjNB/cC1gul1okWu
         NWVNpHJGoXrKbUfeOLi1ctSfEAzziDWga4fav0M8qfy3Fid9gj7oBK5U+z83noCzC9rw
         6+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744037559; x=1744642359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOhRYzdIaKf9HzFQbVvMkV2IJmJ5VdovhfMksW2zjUU=;
        b=rWvMKzpVG1xmlh6h4UsMpH9wouLta88k63kMgEGT7zN+0KV7Oy3M3qhv3e3h6/nGRF
         NeQIT44PfPy4G2/E42PLIk/rsiDUXRti4fEs/JkYVIdn7Che/5nHiag1sHFIMIkT+EFo
         kyKcSxb6+r6BJVT0leCfGTt/YL3+Hs3G/1S3WIH3RyJQTaONtOxu3OVC8XvvbnOdoyeQ
         CFnSEFx/bJbMt2MHhdLB5kFxbqcYj/RJqhxwibow+qitomu96BaLzRS4LWu/XKE6/voF
         V6yp05xSwFDdsS8GXCmM7fCA9XmdHeMRZ6au34FLRnTZrmxhTINni2IA5gU28HW0FdID
         9KSQ==
X-Gm-Message-State: AOJu0YzdNvQg2+09i3FLS0dH6zNLXKXmRy68sqXzuoBkwdk1m4QIxxis
	Jb7MQDq3wj/PA7ivoLZk/4DfqY1lPs+Hj237fLdSWYz7KsHsKvX1bRIHuVwltxgdTj14kUHedp0
	NKYyrBg8EoSJWYqagJDJhySW3i4w=
X-Gm-Gg: ASbGnctF+8wVJNXT4mws1Ert2ndK4fFMlcuxvvuUWeI9YRJxTpx2bZI5tEBz0mKOgrw
	IXgwtLWnJHAJjX00Sm0Qql+8e/PJyE9VzjTuIs0BLjM7++zc8+xXgyJWXyJ8uQvLwbpYHBeg7DD
	a9wg8nrgCB5+UTzpE7z6bx2OOKVsr0oEPTztKe
X-Google-Smtp-Source: AGHT+IFUxNnP4qybvFpvb3t9v0UcSNs2NlXl5fy3Ur0EhEYQI8F4MlD4oD0B/rgeySGJZeUe/i0NrJEQKFXtju8HuxI=
X-Received: by 2002:a05:6808:80aa:b0:3f8:30c1:ccc6 with SMTP id
 5614622812f47-4004557a034mr9290452b6e.8.1744037559471; Mon, 07 Apr 2025
 07:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250318032001.2031160-1-soumya.sambu@windriver.com>
 <d8e7feba-e083-300f-a82f-c483162da8e0@konsulko.com> <CY8PR11MB7921603720483CCF392BC06C81A62@CY8PR11MB7921.namprd11.prod.outlook.com>
 <CY8PR11MB79218088835F33FAD84274B381AA2@CY8PR11MB7921.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB79218088835F33FAD84274B381AA2@CY8PR11MB7921.namprd11.prod.outlook.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 7 Apr 2025 07:52:12 -0700
X-Gm-Features: ATxdqUGKJvQWRUox6TztEmurbBLAZmGAu3JDngINUNt8cWG_0-np3rNOMjfpg-I
Message-ID: <CAMKF1soMKkj2j6RsRnj32P6BRCChr+4RV8UBvyYkqQPPbhA8Pw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
To: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"akuster@mvista.com" <akuster@mvista.com>, "MacLeod, Randy" <Randy.MacLeod@windriver.com>, 
	"Yang, Liezhi" <Liezhi.Yang@windriver.com>, Scott Murray <scott.murray@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 14:52:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1292

On Mon, Apr 7, 2025 at 6:12=E2=80=AFAM Sambu, Soumya <Soumya.Sambu@windrive=
r.com> wrote:
>
> Just following up =E2=80=94 @Khem Raj, @Armin Kuster. Does creating a mix=
ins layer for meta-openembedded sound reasonable? Would really appreciate y=
our input.
>

I think adding bbappends via dynamic layers inside meta-lts-mixins
layer for this rust branch would be
something to consider, that will keep it simple for end users of this layer=
.

> Regards,
> Soumya
> ________________________________
> From: Sambu, Soumya <Soumya.Sambu@windriver.com>
> Sent: Wednesday, March 26, 2025 8:45 PM
> To: Scott Murray <scott.murray@konsulko.com>; yocto-patches@lists.yoctopr=
oject.org <yocto-patches@lists.yoctoproject.org>
> Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>; akuster@mvista.com <aku=
ster@mvista.com>; raj.khem@gmail.com <raj.khem@gmail.com>
> Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]=
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
>
> That makes sense.
> Should we create a mixins layer for meta-openembedded?
> So far, we only have mozjs, that needs a bbappend.
> @Khem Raj, @Armin Kuster - Does that make sense to you?
> Regards,
> Soumya
>
> ________________________________
> From: Scott Murray <scott.murray@konsulko.com>
> Sent: Tuesday, March 25, 2025 5:34 AM
> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org>
> Cc: Sambu, Soumya <Soumya.Sambu@windriver.com>
> Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]=
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
>
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.
>
> On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:
>
> > From: Soumya Sambu <soumya.sambu@windriver.com>
> >
> > The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=3D$=
{HOST_SYS} and
> > --target=3D${TARGET_SYS} respectively, which leads to an error when usi=
ng Rust from meta-lts-mixins:
> >
> > error: Error loading target specification: Could not find specification=
 for target "x86_64-poky-linux".
> >
> > Updated target configuration to resolve this.
> >
> > Additionally, `mozjs-78` encountered "linker 'cc' not found" error. Thi=
s was fixed by explicitly
> > defining the linker for Rust.
> >
> > Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
>
> I'm not planning to take this, since carrying bbappends for recipes
> outside of oe-core is outside of what I had planned to support with
> the mixin.  If I take it, I will be signing up to test building those
> recipes on every Rust update for at least the next year, and it would
> somewhat open the door for people advocating doing the same for
> scarthgap/rust, which has 3 more years to go.
>
> Scott
>
>
> > ---
> >  recipes-devtools/rust/rust_1.81.0.bb       |  3 +++
> >  recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++
> >  recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++
> >  3 files changed, 30 insertions(+)
> >  create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend
> >  create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend
> >
> > diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/ru=
st/rust_1.81.0.bb
> > index cc00053..2d91d68 100644
> > --- a/recipes-devtools/rust/rust_1.81.0.bb
> > +++ b/recipes-devtools/rust/rust_1.81.0.bb
> > @@ -146,6 +146,9 @@ python do_configure() {
> >      # harness are debuggable just from logfiles
> >      config.set("rust", "verbose-tests", e(True))
> >
> > +    # Override default linker cc.
> > +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD=
}")))
> > +
> >      # [build]
> >      config.add_section("build")
> >      config.set("build", "submodules", e(False))
> > diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-exten=
ded/mozjs/mozjs-78_%.bbappend
> > new file mode 100644
> > index 0000000..8e8c24a
> > --- /dev/null
> > +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend
> > @@ -0,0 +1,14 @@
> > +EXTRA_OECONF =3D " \
> > +    --target=3D${RUST_TARGET_SYS} \
> > +    --host=3D${BUILD_SYS} \
> > +    --prefix=3D${prefix} \
> > +    --libdir=3D${libdir} \
> > +    --x-includes=3D${STAGING_INCDIR} \
> > +    --x-libraries=3D${STAGING_LIBDIR} \
> > +    --without-system-icu \
> > +    --disable-tests --disable-strip --disable-optimize \
> > +    --disable-jemalloc \
> > +    --with-system-icu \
> > +    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-go=
ld", '--disable-gold', d)} \
> > +    ${JIT} \
> > +"
> > diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-exten=
ded/mozjs/mozjs-91_%.bbappend
> > new file mode 100644
> > index 0000000..c0214b0
> > --- /dev/null
> > +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend
> > @@ -0,0 +1,13 @@
> > +do_configure() {
> > +        cd ${B}
> > +        python3 ${S}/configure.py \
> > +        --enable-project=3Djs \
> > +        --target=3D${RUST_HOST_SYS} \
> > +        --host=3D${BUILD_SYS} \
> > +        --prefix=3D${prefix} \
> > +        --libdir=3D${libdir} \
> > +        --disable-jemalloc \
> > +        --disable-strip \
> > +        ${JIT} \
> > +        ${ICU}
> > +}
> >

