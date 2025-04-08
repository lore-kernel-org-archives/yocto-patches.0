Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDF3C369A6
	for <webhook@archiver.kernel.org>; Tue,  8 Apr 2025 20:51:36 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web11.6962.1744145489143704028
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Apr 2025 13:51:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=NDkMkgdv;
 spf=pass (domain: konsulko.com, ip: 209.85.166.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8613f456960so73054339f.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1744145488; x=1744750288; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pRKrnQm3ZJwi3HqEvcHqlROneXJ2W74GsYtXq6CIQ/s=;
        b=NDkMkgdvsesXN9G8vYj+mUHv3RaSTmUVnhuAw3Jf5x0tJAhkLi7ykLcoyvJDi/PCMI
         lWNRRyMOapOv0Cy4kdk/al+RPvJvOwJxB9ikvGwkDI3nZ5SMS3utuqoAYqqyXVyKURDd
         Q61vvIDCv2o77o4doLcL/UgkYyZghzh3zoQFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744145488; x=1744750288;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pRKrnQm3ZJwi3HqEvcHqlROneXJ2W74GsYtXq6CIQ/s=;
        b=T2jQtV6n78XdLIzsrii5JY/h+xLK4Ihrnfns3rhL7i6ESordFURygN2meq15XRcowp
         kwRjJmWaIgYP3/dt7wY9+FGGaUjeqOfV2LUasC6UzkQ7+I7upCLvHGLupltGV9Yyg80t
         l/kX5beJdQo4L51XmYMAfRLT2nkRCnup9YOByYluMIhGU6r0BjbsVBWU36yMLAU33p8x
         K/MuVQixlmUCvgcCaRI8mtaSYPnjBS0DHHPhrvxQOn6Rz0048syYZCw2aEzKcdY+/aWZ
         wssz4t9/RN+bBbugK461tHC2UQoZute+iN3hRTBh6CE+v6l2ATBwuYpZnM88HdIIPa+y
         bz7w==
X-Gm-Message-State: AOJu0YxyiGk7psVT3ywwTZmPMt5lWYnx/UHa5QEg//jREFY/S+nxlUI+
	DsE/1BLiITgCX74fCHHjA83XyyPqktgYsRZ7/X0o3NJGy8aXVsdfS/fvHAz5lBtuYY56Cdv4pp0
	X
X-Gm-Gg: ASbGncsWV0a88B8+lUJB8OL9OX7YRnhuxQIUR+kbLotPGu+mozCV8JaFEOtStv064X9
	L7u0cICBaltz7SHKtmQQ3BvLakNUVTirjqvXpCKpqrV/MVgAYo3ma8GsW8Q9HiXLM2bwD0tPkcY
	GKQMUbrq+g1mowrejofXRfDDKzwGv6H6t7KXmB1gD7CawGYfgNXww1OC6NGS3Wh6/jvDUT2f2dd
	iufUR+nTOx/O/HvTf2Ibyk7XL5HYJM0aTRPR26yGt2Xn2KToTBGS53t8A0wz78SV4hd88+66HKe
	clWJ65CVHU2SRFnl+hHJdP5Vobs6nyKOOOz4rNvhzQtKfTXIFW5Ozv0GDgpUejhrh4wAONchAeW
	j004=
X-Google-Smtp-Source: AGHT+IHETWWa9nmAjIbBnsBfsbAYfvOTiwpSA8V9gHkOvv0PuMlw90YYPh/afWObHVNPAmYveCfBKA==
X-Received: by 2002:a05:6e02:1f09:b0:3d4:2a4e:1272 with SMTP id e9e14a558f8ab-3d77c2b5150mr5284905ab.19.1744145487983;
        Tue, 08 Apr 2025 13:51:27 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d703b6c3bcsm6406235ab.3.2025.04.08.13.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 13:51:27 -0700 (PDT)
Date: Tue, 8 Apr 2025 16:51:26 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
cc: "Sambu, Soumya" <Soumya.Sambu@windriver.com>, 
    Khem Raj <raj.khem@gmail.com>, "akuster@mvista.com" <akuster@mvista.com>, 
    "MacLeod, Randy" <Randy.MacLeod@windriver.com>, 
    "Yang, Liezhi" <Liezhi.Yang@windriver.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1]
 mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
In-Reply-To: <183412FA0374DFBE.31078@lists.yoctoproject.org>
Message-ID: <0ced6e87-1823-5a99-aa83-cc3ebdea6940@konsulko.com>
References: <20250318032001.2031160-1-soumya.sambu@windriver.com> <d8e7feba-e083-300f-a82f-c483162da8e0@konsulko.com> <CY8PR11MB7921603720483CCF392BC06C81A62@CY8PR11MB7921.namprd11.prod.outlook.com> <CY8PR11MB79218088835F33FAD84274B381AA2@CY8PR11MB7921.namprd11.prod.outlook.com>
 <CAMKF1soMKkj2j6RsRnj32P6BRCChr+4RV8UBvyYkqQPPbhA8Pw@mail.gmail.com> <183412FA0374DFBE.31078@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-1051094544-1744145487=:18999"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 20:51:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1336

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-1051094544-1744145487=:18999
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Apr 2025, Scott Murray via lists.yoctoproject.org wrote:

> On Mon, 7 Apr 2025, Khem Raj wrote:
>
> > On Mon, Apr 7, 2025 at 6:12 AM Sambu, Soumya <Soumya.Sambu@windriver.com> wrote:
> > >
> > > Just following up — @Khem Raj, @Armin Kuster. Does creating a mixins layer for meta-openembedded sound reasonable? Would really appreciate your input.
> > >
> >
> > I think adding bbappends via dynamic layers inside meta-lts-mixins
> > layer for this rust branch would be
> > something to consider, that will keep it simple for end users of this layer.
>
> As I stated in a previous response, my issue with that approach is
> people's expectations of my testing whatever random packages in various
> layers they want me to carry patches for.  Debugging build failures of
> the in oe-core like librsvg and python3-cryptography has proven a bit
> of timesink as it is, there's no way I have time to build test and
> potentially fix issues with multiple flavors of mozjs, chromium, etc. on
> each Rust upgrade backport.  If Wind River absolutely needs this for
> their customers, I'll gladly hand over maintenance of the Rust mixin
> layers to them and they can do it...

After thinking this over last night, and some discussion on the YP
call this morning, I'll walk the above back somewhat.  I'd be willing to
consider setting up minimal dynamic layers in the Rust LTS mixins for
recipe tweaks with something along the following documented guidelines:

- Submissions would require the submitter committing to documentation of
  themselves as maintainer of the associated bbappends/recipes in either
  the top-level README or perhaps a new MAINTAINERS file.
- I will not commit to any testing of recipes supported by the dynamic
  layers bbappends, i.e. those maintainers need to be prepared to do their
  own testing on Rust upgrades, and having any complaints about breakage
  directed their way.  This will be documented in the layer README.
- dynamic layers will only be considered for layers from meta-openembedded.
- This may be more contentious, but I do not want to take non-backport
  changes to the Rust components in the mixin layers themselves if they
  can be carried in a bbappend in the dynamic layer.  As an example, the
  rust recipe tweak below is something I would prefer to see handled that
  way (i.e. with a rust bbappend in the meta-oe dynamic layer).  My
  reasoning is that such changes are likely to increase my backport
  effort over time.
- Straight backports of newer version recipes will generally be
  considered out of scope.  There is some potential for negotiation if a
  package on a LTS branch becomes impossible to compile with a newer Rust
  version, and patching proves extremely difficult compared to a bump to
  a newer version.  Note that such version bumps that require backports of
  other components from oe-core will default to being rejected since
  even in a dynamic layer the potential for side effects on downstream
  users can be very difficult to gauge.  An example of this from oe-core
  would be newer versions of python3-cryptography, which require maturin
  support (and a bunch of associated Python changes) unavailable in
  kirkstone.

If this seems workable for folks, I can push some documentation updates in
the next day or two, and will consider refreshed patches after that.  As I
mentioned on the YP call this morning, I do have some more work to get
python3-cryptography building with Rust 1.85 working for kirkstone/rust,
so that may impact things a bit.

Regards,

Scott

> > > Regards,
> > > Soumya
> > > ________________________________
> > > From: Sambu, Soumya <Soumya.Sambu@windriver.com>
> > > Sent: Wednesday, March 26, 2025 8:45 PM
> > > To: Scott Murray <scott.murray@konsulko.com>; yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> > > Cc: MacLeod, Randy <Randy.MacLeod@windriver.com>; akuster@mvista.com <akuster@mvista.com>; raj.khem@gmail.com <raj.khem@gmail.com>
> > > Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
> > >
> > > That makes sense.
> > > Should we create a mixins layer for meta-openembedded?
> > > So far, we only have mozjs, that needs a bbappend.
> > > @Khem Raj, @Armin Kuster - Does that make sense to you?
> > > Regards,
> > > Soumya
> > >
> > > ________________________________
> > > From: Scott Murray <scott.murray@konsulko.com>
> > > Sent: Tuesday, March 25, 2025 5:34 AM
> > > To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoproject.org>
> > > Cc: Sambu, Soumya <Soumya.Sambu@windriver.com>
> > > Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 1/1] mozjs: Use RUST_HOST_SYS and RUST_TARGET_SYS
> > >
> > > CAUTION: This email comes from a non Wind River email account!
> > > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > >
> > > On Tue, 18 Mar 2025, Soumya via lists.yoctoproject.org wrote:
> > >
> > > > From: Soumya Sambu <soumya.sambu@windriver.com>
> > > >
> > > > The mozjs-91 and mozjs-78 recipe in meta-openembedded sets --target=${HOST_SYS} and
> > > > --target=${TARGET_SYS} respectively, which leads to an error when using Rust from meta-lts-mixins:
> > > >
> > > > error: Error loading target specification: Could not find specification for target "x86_64-poky-linux".
> > > >
> > > > Updated target configuration to resolve this.
> > > >
> > > > Additionally, `mozjs-78` encountered "linker 'cc' not found" error. This was fixed by explicitly
> > > > defining the linker for Rust.
> > > >
> > > > Signed-off-by: Soumya Sambu <soumya.sambu@windriver.com>
> > >
> > > I'm not planning to take this, since carrying bbappends for recipes
> > > outside of oe-core is outside of what I had planned to support with
> > > the mixin.  If I take it, I will be signing up to test building those
> > > recipes on every Rust update for at least the next year, and it would
> > > somewhat open the door for people advocating doing the same for
> > > scarthgap/rust, which has 3 more years to go.
> > >
> > > Scott
> > >
> > >
> > > > ---
> > > >  recipes-devtools/rust/rust_1.81.0.bb       |  3 +++
> > > >  recipes-extended/mozjs/mozjs-78_%.bbappend | 14 ++++++++++++++
> > > >  recipes-extended/mozjs/mozjs-91_%.bbappend | 13 +++++++++++++
> > > >  3 files changed, 30 insertions(+)
> > > >  create mode 100644 recipes-extended/mozjs/mozjs-78_%.bbappend
> > > >  create mode 100644 recipes-extended/mozjs/mozjs-91_%.bbappend
> > > >
> > > > diff --git a/recipes-devtools/rust/rust_1.81.0.bb b/recipes-devtools/rust/rust_1.81.0.bb
> > > > index cc00053..2d91d68 100644
> > > > --- a/recipes-devtools/rust/rust_1.81.0.bb
> > > > +++ b/recipes-devtools/rust/rust_1.81.0.bb
> > > > @@ -146,6 +146,9 @@ python do_configure() {
> > > >      # harness are debuggable just from logfiles
> > > >      config.set("rust", "verbose-tests", e(True))
> > > >
> > > > +    # Override default linker cc.
> > > > +    config.set("rust", "default-linker", e(d.expand("${RUST_BUILD_CCLD}")))
> > > > +
> > > >      # [build]
> > > >      config.add_section("build")
> > > >      config.set("build", "submodules", e(False))
> > > > diff --git a/recipes-extended/mozjs/mozjs-78_%.bbappend b/recipes-extended/mozjs/mozjs-78_%.bbappend
> > > > new file mode 100644
> > > > index 0000000..8e8c24a
> > > > --- /dev/null
> > > > +++ b/recipes-extended/mozjs/mozjs-78_%.bbappend
> > > > @@ -0,0 +1,14 @@
> > > > +EXTRA_OECONF = " \
> > > > +    --target=${RUST_TARGET_SYS} \
> > > > +    --host=${BUILD_SYS} \
> > > > +    --prefix=${prefix} \
> > > > +    --libdir=${libdir} \
> > > > +    --x-includes=${STAGING_INCDIR} \
> > > > +    --x-libraries=${STAGING_LIBDIR} \
> > > > +    --without-system-icu \
> > > > +    --disable-tests --disable-strip --disable-optimize \
> > > > +    --disable-jemalloc \
> > > > +    --with-system-icu \
> > > > +    ${@bb.utils.contains('DISTRO_FEATURES', 'ld-is-gold', "--enable-gold", '--disable-gold', d)} \
> > > > +    ${JIT} \
> > > > +"
> > > > diff --git a/recipes-extended/mozjs/mozjs-91_%.bbappend b/recipes-extended/mozjs/mozjs-91_%.bbappend
> > > > new file mode 100644
> > > > index 0000000..c0214b0
> > > > --- /dev/null
> > > > +++ b/recipes-extended/mozjs/mozjs-91_%.bbappend
> > > > @@ -0,0 +1,13 @@
> > > > +do_configure() {
> > > > +        cd ${B}
> > > > +        python3 ${S}/configure.py \
> > > > +        --enable-project=js \
> > > > +        --target=${RUST_HOST_SYS} \
> > > > +        --host=${BUILD_SYS} \
> > > > +        --prefix=${prefix} \
> > > > +        --libdir=${libdir} \
> > > > +        --disable-jemalloc \
> > > > +        --disable-strip \
> > > > +        ${JIT} \
> > > > +        ${ICU}
> > > > +}
> > > >
> >
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1293): https://lists.yoctoproject.org/g/yocto-patches/message/1293
> Mute This Topic: https://lists.yoctoproject.org/mt/111764095/2167468
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13170805/2167468/856840347/xyzzy [scott.murray@konsulko.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>
>
>
---1463811583-1051094544-1744145487=:18999--

