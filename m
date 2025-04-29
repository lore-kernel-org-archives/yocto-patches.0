Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD934C369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 22:12:25 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.web10.3421.1745964738816472729
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Apr 2025 15:12:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=eyc1sLNT;
 spf=pass (domain: konsulko.com, ip: 209.85.219.50, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so3679886d6.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 15:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1745964738; x=1746569538; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdw0GEgzHSOU8jgyvSoynccx/2NFjZqVmEbZNsKjIyM=;
        b=eyc1sLNT59eqPFpDmVnLeGvkH5vJaWgMydL8k/sOy+6GXyDiT5iaWOfCla+TABTVwT
         AgHGQhWT0sYlh/cB2IhjGpAx9rROcZ2DfDvVw4fWvPPUJx9+lGXg2amnS5QONisHc6PU
         t2cPg8lL8rNKAgq6Lo3i3/E5xI/eBLLT8bZIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745964738; x=1746569538;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdw0GEgzHSOU8jgyvSoynccx/2NFjZqVmEbZNsKjIyM=;
        b=CcSgkiJyzX3l8K2ocDdfZx/PePuJKrWShz7F6NpsSW3OqRDsO2101VMbMib2QiPvG/
         c0GAJPEvmR9MT3+HiRes1MzeyJMJVwmP6RHoUvCuA9dWXjFzkb9vyOmmyIi62pQ+K+Ec
         IBJ6uf8cnmngtQ1leXxwUKG8rDFEYtI7atOn6TT/BI1fWHVxpF5XVxNIckY7Pbx9tOsg
         fTyZI22LPpJELyCnCJ585R24TrmJdll4daSOuD/ZyNaTE226kvOW4MGtD9qLPaXd6upf
         JIfBGItVieU46mkQDuEF8TStlJ6c2SgsoVdqenOieeNERYLM3wgZviuBfx/L69TzyqHJ
         ll6g==
X-Forwarded-Encrypted: i=1; AJvYcCUHtqjf5fM+A2WnBt3+47pJaG6OuqSRo/b7jzoU7Pt9Yw0x1mNOD/QwNOpWB4bJntQLmvLSDOZKkFlbqTYm@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yyt+hCkdab+QnASGBphp+YIJHk2qAIttvUHKfahV3VnZLaEIDhA
	OnocgBWoBTN2ZHZk2dWmIchrhDh47C8iKATMb6z77uMziTIIJH9TrdPKqsu2tIM=
X-Gm-Gg: ASbGncuBUPl4UP7pGSSuRHGJhA1eaGAvY/CQJL8bl0tXknLN4f+asOy7PI+g73KXFlk
	MipgvL0ZvTHiCI8vM1wsLHB9+6/Fvjr50lT7evi0TCIFTU9eqm0qlVENhciDdrRGBfbNSgb8/4C
	qYqtoCCpamhFaiODKw/X7ZeMl9lT8pMNdBBrwFjeX45IUkhf/dkcEa7/+CxfLA1nMBDbyu5+wcq
	oZUArcNKbeuDgYLR5rzZ6tAukuaII9/3s2SLuFmvlpRTax/PdU9bFTnRpNAyzk0oD8Ua1WgtV+p
	5kjjGD1mX3+LpdJxRk5O9sZ1/MT+qw3i0w+ssErbRvbUF8nr0rvFbk14aWDBP+RlzaA69RFFcRI
	=
X-Google-Smtp-Source: AGHT+IEwT2+lDzTB4hURHb1YrlZIaI2gPf531odS1kSbKApx1KtDPq79n8IVQKM2TJqCYb1yTrDGnw==
X-Received: by 2002:ad4:5c8b:0:b0:6e4:5a38:dd0f with SMTP id 6a1803df08f44-6f4fdc8fc2fmr10095316d6.4.1745964737759;
        Tue, 29 Apr 2025 15:12:17 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4fe6abee3sm747296d6.13.2025.04.29.15.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 15:12:16 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:12:03 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
cc: Khem Raj <raj.khem@gmail.com>, "akuster@mvista.com" <akuster@mvista.com>, 
    "MacLeod, Randy" <Randy.MacLeod@windriver.com>, 
    "Yang, Liezhi" <Liezhi.Yang@windriver.com>, 
    "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
In-Reply-To: <CY8PR11MB79216DC25AB00009E2C1BD9181802@CY8PR11MB7921.namprd11.prod.outlook.com>
Message-ID: <7f70b6cc-1942-bf33-71e8-0cd1fca87e17@konsulko.com>
References: <20250318032001.2031160-1-soumya.sambu@windriver.com> <d8e7feba-e083-300f-a82f-c483162da8e0@konsulko.com> <CY8PR11MB7921603720483CCF392BC06C81A62@CY8PR11MB7921.namprd11.prod.outlook.com> <CY8PR11MB79218088835F33FAD84274B381AA2@CY8PR11MB7921.namprd11.prod.outlook.com>
 <CAMKF1soMKkj2j6RsRnj32P6BRCChr+4RV8UBvyYkqQPPbhA8Pw@mail.gmail.com> <183412FA0374DFBE.31078@lists.yoctoproject.org> <0ced6e87-1823-5a99-aa83-cc3ebdea6940@konsulko.com> <CY8PR11MB79216DC25AB00009E2C1BD9181802@CY8PR11MB7921.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1948647116-1745964736=:3578"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 22:12:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1421

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1948647116-1745964736=:3578
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 29 Apr 2025, Sambu, Soumya wrote:

> Hi Scott,
>
> Just following up - do you have any updates on the documentation you mentioned earlier?
>
> Regards,
> Soumya

My apologies for the delay, I got wrapped up in some other things for AGL.
I will be pushing some updates to the mixin layers in the next few days,
and will include the doc update on the dynamic-layers requirements.

Cheers,

Scott


> ________________________________
> From: Scott Murray <scott.murray@konsulko.com>
> Sent: Wednesday, April 9, 2025 2:21 AM
> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> Cc: Sambu, Soumya <Soumya.Sambu@windriver.com>; Khem Raj <raj.khem@gmail.com>; akuster@mvista.com <akuster@mvista.com>; MacLeod, Randy <Randy.MacLeod@windriver.com>; Yang, Liezhi <Liezhi.Yang@windriver.com>
> Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
>
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Mon, 7 Apr 2025, Scott Murray via lists.yoctoproject.org wrote:
>
> > On Mon, 7 Apr 2025, Khem Raj wrote:
> >
> > > On Mon, Apr 7, 2025 at 6:12 AM Sambu, Soumya <Soumya.Sambu@windriver.com> wrote:
> > > >
> > > > Just following up — @Khem Raj, @Armin Kuster. Does creating a mixins layer for meta-openembedded sound reasonable? Would really appreciate your input.
> > > >
> > >
> > > I think adding bbappends via dynamic layers inside meta-lts-mixins
> > > layer for this rust branch would be
> > > something to consider, that will keep it simple for end users of this layer.
> >
> > As I stated in a previous response, my issue with that approach is
> > people's expectations of my testing whatever random packages in various
> > layers they want me to carry patches for.  Debugging build failures of
> > the in oe-core like librsvg and python3-cryptography has proven a bit
> > of timesink as it is, there's no way I have time to build test and
> > potentially fix issues with multiple flavors of mozjs, chromium, etc. on
> > each Rust upgrade backport.  If Wind River absolutely needs this for
> > their customers, I'll gladly hand over maintenance of the Rust mixin
> > layers to them and they can do it...
>
> After thinking this over last night, and some discussion on the YP
> call this morning, I'll walk the above back somewhat.  I'd be willing to
> consider setting up minimal dynamic layers in the Rust LTS mixins for
> recipe tweaks with something along the following documented guidelines:
>
> - Submissions would require the submitter committing to documentation of
>   themselves as maintainer of the associated bbappends/recipes in either
>   the top-level README or perhaps a new MAINTAINERS file.
> - I will not commit to any testing of recipes supported by the dynamic
>   layers bbappends, i.e. those maintainers need to be prepared to do their
>   own testing on Rust upgrades, and having any complaints about breakage
>   directed their way.  This will be documented in the layer README.
> - dynamic layers will only be considered for layers from meta-openembedded.
> - This may be more contentious, but I do not want to take non-backport
>   changes to the Rust components in the mixin layers themselves if they
>   can be carried in a bbappend in the dynamic layer.  As an example, the
>   rust recipe tweak below is something I would prefer to see handled that
>   way (i.e. with a rust bbappend in the meta-oe dynamic layer).  My
>   reasoning is that such changes are likely to increase my backport
>   effort over time.
> - Straight backports of newer version recipes will generally be
>   considered out of scope.  There is some potential for negotiation if a
>   package on a LTS branch becomes impossible to compile with a newer Rust
>   version, and patching proves extremely difficult compared to a bump to
>   a newer version.  Note that such version bumps that require backports of
>   other components from oe-core will default to being rejected since
>   even in a dynamic layer the potential for side effects on downstream
>   users can be very difficult to gauge.  An example of this from oe-core
>   would be newer versions of python3-cryptography, which require maturin
>   support (and a bunch of associated Python changes) unavailable in
>   kirkstone.
>
> If this seems workable for folks, I can push some documentation updates in
> the next day or two, and will consider refreshed patches after that.  As I
> mentioned on the YP call this morning, I do have some more work to get
> python3-cryptography building with Rust 1.85 working for kirkstone/rust,
> so that may impact things a bit.
>
> Regards,
>
> Scott
>
> > > > Regards,
> > > > Soumya
> > > > ________________________________
> > > > From: Sambu, Soumya <Soumya.Sambu@windriver.com>
> > > > Sent: Wednesday, March 26, 2025 8:45 PM
> > > > To: Scott Murray <scott.murray@konsulko.com>; yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> > > > Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>; akuster@mvista.com <akuster@mvista.com>; raj.khem@gmail.com <raj.khem@gmail.com>
> > > > Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
> > > >
> > > > That makes sense.
> > > > Should we create a mixins layer for meta-openembedded?
> > > > So far, we only have mozjs, that needs a bbappend.
> > > > @Khem Raj, @Armin Kuster - Does that make sense to you?
> > > > Regards,
> > > > Soumya
> > > >
> > > > ________________________________
> > > > From: Scott Murray <scott.murray@konsulko.com>
> > > > Sent: Tuesday, March 25, 2025 5:34 AM
> > > > To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> > > > Cc: Sambu, Soumya <Soumya.Sambu@windriver.com>
> > > > Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
> > > >
> > > > CAUTION: This email comes from a non Wind River email account!
> > > > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > > >
> > > > On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:
> > > >
> > > > > From: Soumya Sambu <soumya.sambu@windriver.com>
> > > > >
> > > > > The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=${HOST_SYS} and
> > > > > --target=${TARGET_SYS} respectively, which leads to an error when using Rust from meta-lts-mixins:
> > > > >
> > > > > error: Error loading target specification: Could not find specification for target "x86_64-poky-linux".
> > > > >
> > > > > Updated target configuration to resolve this.
> > > > >
> > > > > Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This was fixed by explicitly
> > > > > defining the linker for Rust.
> > > > >
> > > > > Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
> > > >
> > > > I'm not planning to take this, since carrying bbappends for recipes
> > > > outside of oe-core is outside of what I had planned to support with
> > > > the mixin.  If I take it, I will be signing up to test building those
> > > > recipes on every Rust update for at least the next year, and it would
> > > > somewhat open the door for people advocating doing the same for
> > > > scarthgap/rust, which has 3 more years to go.
> > > >
> > > > Scott
> > > >
> > > >
> > > > > ---
> > > > >  recipes-devtools/rust/rust_1.81.0.bb       |  3 +++
> > > > >  recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++
> > > > >  recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++
> > > > >  3 files changed, 30 insertions(+)
> > > > >  create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend
> > > > >  create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend
> > > > >
> > > > > diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
> > > > > index cc00053..2d91d68 100644
> > > > > --- a/recipes-devtools/rust/rust_1.81.0.bb
> > > > > +++ b/recipes-devtools/rust/rust_1.81.0.bb
> > > > > @@ -146,6 +146,9 @@ python do_configure() {
> > > > >      # harness are debuggable just from logfiles
> > > > >      config.set("rust", "verbose-tests", e(True))
> > > > >
> > > > > +    # Override default linker cc.
> > > > > +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}")))
> > > > > +
> > > > >      # [build]
> > > > >      config.add_section("build")
> > > > >      config.set("build", "submodules", e(False))
> > > > > diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-extended/mozjs/mozjs-78_%.bbappend
> > > > > new file mode 100644
> > > > > index 0000000..8e8c24a
> > > > > --- /dev/null
> > > > > +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend
> > > > > @@ -0,0 +1,14 @@
> > > > > +EXTRA_OECONF = " \
> > > > > +    --target=${RUST_TARGET_SYS} \
> > > > > +    --host=${BUILD_SYS} \
> > > > > +    --prefix=${prefix} \
> > > > > +    --libdir=${libdir} \
> > > > > +    --x-includes=${STAGING_INCDIR} \
> > > > > +    --x-libraries=${STAGING_LIBDIR} \
> > > > > +    --without-system-icu \
> > > > > +    --disable-tests --disable-strip --disable-optimize \
> > > > > +    --disable-jemalloc \
> > > > > +    --with-system-icu \
> > > > > +    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold", '--disable-gold', d)} \
> > > > > +    ${JIT} \
> > > > > +"
> > > > > diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-extended/mozjs/mozjs-91_%.bbappend
> > > > > new file mode 100644
> > > > > index 0000000..c0214b0
> > > > > --- /dev/null
> > > > > +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend
> > > > > @@ -0,0 +1,13 @@
> > > > > +do_configure() {
> > > > > +        cd ${B}
> > > > > +        python3 ${S}/configure.py \
> > > > > +        --enable-project=js \
> > > > > +        --target=${RUST_HOST_SYS} \
> > > > > +        --host=${BUILD_SYS} \
> > > > > +        --prefix=${prefix} \
> > > > > +        --libdir=${libdir} \
> > > > > +        --disable-jemalloc \
> > > > > +        --disable-strip \
> > > > > +        ${JIT} \
> > > > > +        ${ICU}
> > > > > +}
> > > > >
> > >
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#1293): https://lists.yoctoproject.org/g/yocto-patches/message/1293
> > Mute This Topic: https://lists.yoctoproject.org/mt/111764095/2167468
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170805/2167468/856840347/xyzzy [scott.murray@konsulko.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >
> >
>
---1463811583-1948647116-1745964736=:3578--

