Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28347C36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 15:30:22 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.50341.1744039820443095166
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 08:30:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hpAjhbAA;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so4365466d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744039819; x=1744644619; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mr5AqMCh5rC3ZLWe0JsgEJH7kpTf0vPiqlDEi3QNT8M=;
        b=hpAjhbAA+a3tHPKmfgy8X+cdRNaa+p8Kw73LQDKcigOBu3iCrxo3AwNaD17RPsK2X5
         +LmDN+TJ9cox+9LBcW9wRqeAucBo2KXlcGruGTAcTvIsaQBwuKHCQiRfvD0SsM3LpVo1
         ++ldhTUvOmyzNfodNBA7qreZvOxzzmFgByt2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039819; x=1744644619;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mr5AqMCh5rC3ZLWe0JsgEJH7kpTf0vPiqlDEi3QNT8M=;
        b=MkMTY6V7nwu7qr38NRbPD4jqhDbwdnRbfxElovUZHSsl1WOCJdP0qKfdBrFmIyrSmj
         vARMCSZznwsSEmhfxp72UC/HsYyv8Yb+fs2ywPqUvKae8q8yblPwjhGtsIMhDyceQH+p
         aO8kqwJKh8VEJpvbYTbBnwJD+qJwRDL1sKLF97maxsGJMMJogO2rPE71o3Kb5WQsAUP5
         dG0xFWkXfepTcH3hevrRrGRrqIRmR+fWNnkvMd4sLMhXoYaYXO//UzE9XR+FWRAs3Sao
         12ArvtVRvgkJfrSPQcO6PXnTeoj5ekh/k1GgK3syBRimcSg90PaAeJ9ZnCuLe3DKHC6U
         KiCg==
X-Gm-Message-State: AOJu0Yzm3ecizCTXqBQ8YQcaFDyRsOFpm0SbenhCD8YRdD4WR++YkBAi
	njaasrTsED0uIl1isGNmhxTiIRUxAlGxpEDAvx3BJrAVx/bVBpo84skFUa6IXb0hO+E7qUPFD3A
	j
X-Gm-Gg: ASbGnctLo5d+hHkMy7REosLyLm7UFZt87va+3SsRlornoy9HizxUHBp6/kqnyZe7D4D
	cE30QodESkIV88OsBZoTujtzgF+IfVvIMass39mnxxeL6hSbjxHbGF0TPAPMvkHg8lJoat2+MC8
	xDmk7Zo3Uo5ZNWOjZG3+ibym8yqYLxIClzV/PXSxGtT6LWytkiQwiIHiB/4dzelNI2iRTq96ky1
	3cxNeQC6/cE/xP7XHmcXBbfx1XAIbgotvJqKkR++bu2l5PAvhi7/orDo98M52wg6NZv5HaepGBe
	ueyUfk5rI68OEAyOtxcXSar9FDWgxka2dtfPEYIRN9jiv8Fv3wyKL+IxKIrPVaM6IVsp5u96N84
	wXJI=
X-Google-Smtp-Source: AGHT+IGJqHkhAYKbHDXjGXIN9W68HJJWAlJDBZxb+vR8+OSvEN42Eg8NmhSiJvMIf9djIW9rxCPyOQ==
X-Received: by 2002:ad4:5baa:0:b0:6e8:903c:6e5b with SMTP id 6a1803df08f44-6ef0be791d1mr264748866d6.9.1744039819121;
        Mon, 07 Apr 2025 08:30:19 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76ea58d71sm610953585a.89.2025.04.07.08.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:30:18 -0700 (PDT)
Date: Mon, 7 Apr 2025 11:29:45 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
cc: "Sambu, Soumya" <Soumya.Sambu@windriver.com>, 
    Khem Raj <raj.khem@gmail.com>, "akuster@mvista.com" <akuster@mvista.com>, 
    "MacLeod, Randy" <Randy.MacLeod@windriver.com>, 
    "Yang, Liezhi" <Liezhi.Yang@windriver.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
In-Reply-To: <CAMKF1soMKkj2j6RsRnj32P6BRCChr+4RV8UBvyYkqQPPbhA8Pw@mail.gmail.com>
Message-ID: <5718125c-833e-4c55-7b2b-b5d381872933@konsulko.com>
References: <20250318032001.2031160-1-soumya.sambu@windriver.com> <d8e7feba-e083-300f-a82f-c483162da8e0@konsulko.com> <CY8PR11MB7921603720483CCF392BC06C81A62@CY8PR11MB7921.namprd11.prod.outlook.com> <CY8PR11MB79218088835F33FAD84274B381AA2@CY8PR11MB7921.namprd11.prod.outlook.com>
 <CAMKF1soMKkj2j6RsRnj32P6BRCChr+4RV8UBvyYkqQPPbhA8Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1325704340-1744039818=:18999"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 15:30:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1293

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1325704340-1744039818=:18999
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Apr 2025, Khem Raj wrote:

> On Mon, Apr 7, 2025 at 6:12 AM Sambu, Soumya <Soumya.Sambu@windriver.com> wrote:
> >
> > Just following up — @Khem Raj, @Armin Kuster. Does creating a mixins layer for meta-openembedded sound reasonable? Would really appreciate your input.
> >
>
> I think adding bbappends via dynamic layers inside meta-lts-mixins
> layer for this rust branch would be
> something to consider, that will keep it simple for end users of this layer.

As I stated in a previous response, my issue with that approach is
people's expectations of my testing whatever random packages in various
layers they want me to carry patches for.  Debugging build failures of
the in oe-core like librsvg and python3-cryptography has proven a bit
of timesink as it is, there's no way I have time to build test and
potentially fix issues with multiple flavors of mozjs, chromium, etc. on
each Rust upgrade backport.  If Wind River absolutely needs this for
their customers, I'll gladly hand over maintenance of the Rust mixin
layers to them and they can do it...

Scott


> > Regards,
> > Soumya
> > ________________________________
> > From: Sambu, Soumya <Soumya.Sambu@windriver.com>
> > Sent: Wednesday, March 26, 2025 8:45 PM
> > To: Scott Murray <scott.murray@konsulko.com>; yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> > Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>; akuster@mvista.com <akuster@mvista.com>; raj.khem@gmail.com <raj.khem@gmail.com>
> > Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
> >
> > That makes sense.
> > Should we create a mixins layer for meta-openembedded?
> > So far, we only have mozjs, that needs a bbappend.
> > @Khem Raj, @Armin Kuster - Does that make sense to you?
> > Regards,
> > Soumya
> >
> > ________________________________
> > From: Scott Murray <scott.murray@konsulko.com>
> > Sent: Tuesday, March 25, 2025 5:34 AM
> > To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> > Cc: Sambu, Soumya <Soumya.Sambu@windriver.com>
> > Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
> >
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> >
> > On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:
> >
> > > From: Soumya Sambu <soumya.sambu@windriver.com>
> > >
> > > The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=${HOST_SYS} and
> > > --target=${TARGET_SYS} respectively, which leads to an error when using Rust from meta-lts-mixins:
> > >
> > > error: Error loading target specification: Could not find specification for target "x86_64-poky-linux".
> > >
> > > Updated target configuration to resolve this.
> > >
> > > Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This was fixed by explicitly
> > > defining the linker for Rust.
> > >
> > > Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
> >
> > I'm not planning to take this, since carrying bbappends for recipes
> > outside of oe-core is outside of what I had planned to support with
> > the mixin.  If I take it, I will be signing up to test building those
> > recipes on every Rust update for at least the next year, and it would
> > somewhat open the door for people advocating doing the same for
> > scarthgap/rust, which has 3 more years to go.
> >
> > Scott
> >
> >
> > > ---
> > >  recipes-devtools/rust/rust_1.81.0.bb       |  3 +++
> > >  recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++
> > >  recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++
> > >  3 files changed, 30 insertions(+)
> > >  create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend
> > >  create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend
> > >
> > > diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
> > > index cc00053..2d91d68 100644
> > > --- a/recipes-devtools/rust/rust_1.81.0.bb
> > > +++ b/recipes-devtools/rust/rust_1.81.0.bb
> > > @@ -146,6 +146,9 @@ python do_configure() {
> > >      # harness are debuggable just from logfiles
> > >      config.set("rust", "verbose-tests", e(True))
> > >
> > > +    # Override default linker cc.
> > > +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}")))
> > > +
> > >      # [build]
> > >      config.add_section("build")
> > >      config.set("build", "submodules", e(False))
> > > diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-extended/mozjs/mozjs-78_%.bbappend
> > > new file mode 100644
> > > index 0000000..8e8c24a
> > > --- /dev/null
> > > +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend
> > > @@ -0,0 +1,14 @@
> > > +EXTRA_OECONF = " \
> > > +    --target=${RUST_TARGET_SYS} \
> > > +    --host=${BUILD_SYS} \
> > > +    --prefix=${prefix} \
> > > +    --libdir=${libdir} \
> > > +    --x-includes=${STAGING_INCDIR} \
> > > +    --x-libraries=${STAGING_LIBDIR} \
> > > +    --without-system-icu \
> > > +    --disable-tests --disable-strip --disable-optimize \
> > > +    --disable-jemalloc \
> > > +    --with-system-icu \
> > > +    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold", '--disable-gold', d)} \
> > > +    ${JIT} \
> > > +"
> > > diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-extended/mozjs/mozjs-91_%.bbappend
> > > new file mode 100644
> > > index 0000000..c0214b0
> > > --- /dev/null
> > > +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend
> > > @@ -0,0 +1,13 @@
> > > +do_configure() {
> > > +        cd ${B}
> > > +        python3 ${S}/configure.py \
> > > +        --enable-project=js \
> > > +        --target=${RUST_HOST_SYS} \
> > > +        --host=${BUILD_SYS} \
> > > +        --prefix=${prefix} \
> > > +        --libdir=${libdir} \
> > > +        --disable-jemalloc \
> > > +        --disable-strip \
> > > +        ${JIT} \
> > > +        ${ICU}
> > > +}
> > >
>
---1463811583-1325704340-1744039818=:18999--

