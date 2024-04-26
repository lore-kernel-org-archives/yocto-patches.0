Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8EC4345F
	for <webhook@archiver.kernel.org>; Fri, 26 Apr 2024 18:35:58 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.3507.1714156550928488702
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Apr 2024 11:35:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UGGJFfXx;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b514d3cf4so24826686d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Apr 2024 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714156549; x=1714761349; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXmy0kyqLLIrcn93OQae7dPK64WpzjdwVMUdHE9EDOg=;
        b=UGGJFfXxCKIwNDyZvKjcPebj4B6+5JaOgDXda+y/GYsXv7S/OTSYopEsSUi4ENjoL5
         zVAvAxQWpubhJPadG62rESBMjY+xfJu8Ge5NU3dOpy4ZetWBAtYdy33bpkTcDGa69Qpe
         Ln5ILXv35mZcsONfosH/Zr591FAPqO4maoioiLn24pD5+VG7vphhZ2b1qXMAQSGVORKn
         wY1OFVKVtlTuFscHtfzVrO5lyMULlJmd27/bR6kjo/FPkcojo7lco9li7FwZkqq4dDUg
         Dwzu+UKxTzpJJMV0nnMAbLXpPdXTtIMItAAFW1YIaUqpzgwnZTG/329SWWxv+LheOJqR
         2quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156549; x=1714761349;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXmy0kyqLLIrcn93OQae7dPK64WpzjdwVMUdHE9EDOg=;
        b=ExD53SnnOFShRzoewNw+8p3i/DLSyXE5rRHiQ0cKvwOOTFXKCmg+rOv4YSJ7mbQF1W
         Hvvd5u6sGVX0o/mncOrn7ff8Xop7GjwN4yAUd4V+D2kMNLlIl2CASOxQEoImOGSTiDlU
         OwaMXBRlK62HelJiAU6TXTBwKJIBsHvS1Lyn5d+65PYlx857/BlyJyDRUL4PaHze4Z8Z
         89NFIAO973VFLuwfjrM0nbsN2bqde/hbEEE8CQDFt1m9n2lDr194ObFEVl3ewhMsTIr0
         qjXob0JYBKlAXURH1Edc0m68TBTMDpGqFELrA5IUFmTAax11iy2an+295kAlg01REHsm
         CMLg==
X-Gm-Message-State: AOJu0Yy81gJSocjMa/tilqNtAIQUucURVbfQAejL3g+wusyaLpssKpDX
	YU5g26B1eZZKRvkCGpU1iYUTU2PKXW4fCWXrbhde2lLjuLgbnBH8WixgBg==
X-Google-Smtp-Source: AGHT+IEXpKrJtBRsmcm1gIAgNa4EFu7AR4SxODZUqLolqPn2Egl6VRLAW+GkJHIQCDBL4O42odFMXg==
X-Received: by 2002:a05:6214:529a:b0:6a0:b1a2:7540 with SMTP id kj26-20020a056214529a00b006a0b1a27540mr2546929qvb.61.1714156549186;
        Fri, 26 Apr 2024 11:35:49 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id ml20-20020a056214585400b006a0b3ff2cf7sm415300qvb.39.2024.04.26.11.35.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:35:48 -0700 (PDT)
Date: Fri, 26 Apr 2024 14:35:46 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] enable stored
 U-Boot environment
Message-ID: <20240426183546.GA29649@localhost>
References: <20240411011638.12198-1-twoerner@gmail.com>
 <bb4b9d20-b71d-4907-9df4-e3fbdd07275a@theobroma-systems.com>
 <20240417141930.GA11714@localhost>
 <1d35ff20-9a01-42c9-b001-a7df1310e60c@theobroma-systems.com>
 <20240424174350.GA35393@localhost>
 <9e5785d5-5c63-4467-bacd-6f0af89ca515@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e5785d5-5c63-4467-bacd-6f0af89ca515@theobroma-systems.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Apr 2024 18:35:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/70

Gosh darn! Yes you're right. I kept saying WORKDIR over and over but I meant
DEPLOYDIR. I must have been distracted or something because in my mind, the
whole time, I was thinking $TMPDIR/deploy/images/$MACHINE but I kept writing
WORKDIR for some unknown reason.

On Thu 2024-04-25 @ 02:21:57 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 4/24/24 19:43, Trevor Woerner via lists.yoctoproject.org wrote:
> > On Thu 2024-04-18 @ 10:43:10 AM, Quentin Schulz wrote:
> > > Hi Trevor,
> > > 
> > > On 4/17/24 16:19, Trevor Woerner via lists.yoctoproject.org wrote:
> > > [...]
> > > > > 
> > > > > > +}
> > > > > > +
> > > > > > +do_deploy:append:rk-u-boot-env() {
> > > > > > +	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut
> > > > > -d'=' -f2)"
> > > > > > +	mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o
> > > > > ${WORKDIR}/u-boot.env
> > > > > > +
> > > > > > +	install -d ${DEPLOYDIR}
> > > > > > +	install -m 0644 ${WORKDIR}/u-boot.env ${DEPLOYDIR}
> > > > > Just install at the top and then write the file directly to DEPLOYDIR? Or,
> > > > > actually, create the file in do_compile if possible?
> > > > 
> > > > But I want this file handled correctly by do_deploy when sstate is being used?
> > > > So don't I need to do this in the do_deploy task?
> > > > 
> > > 
> > > Not sure to follow what's the concern about sstate? do_deploy sstate
> > > monitors everything in DEPLOYDIR so everything you install in there shall be
> > > under sstate?
> > > 
> > > For me do_deploy is for moving a file from one location to another, in
> > > DEPLOYDIR, nothing else. Everything that involves compilation/configuration
> > > is in do_compile/do_configure, so it's a bit odd to me to see a call to
> > > mkenvimage in do_deploy.
> > > 
> > > I guess you could have an issue with sstate if you use WORKDIR for
> > > u-boot.env since this wouldn't be under do_compile's sstate? But then just
> > > use ${B} for that instead?
> > > 
> > > Can you tell me a bit more about your concern here, I'm not getting the big
> > > picture yet :/
> > 
> > Firstly I want these files handled correctly by the oe-core U-Boot packaging
> > so they get included in the image/sstate correctly.
> > 
> 
> Using WORKDIR as a way to pass files between tasks is a terrible idea,
> WORKDIR isn't properly cleaned. However... this is an issue in the
> "upstream" U-Boot recipe, not something you can deal with in your bbappend,
> so let's ignore this issue here.

Yep, agreed.

> I'm also not entirely sure how the sstate works for do_compile... Couldn't
> find any sstate-indirs and sstate-outdirs for do_compile/do_install with
> bitbake-getvar or a quick check with grep. Do you have any idea how/where
> this is handled?
> 
> > Second, I'm pretty sure that anything you want inserted into a wic image (i.e.
> > all the "--sourceparams=..." that are specified in the wks file) need to be placed in
> > ${WORKDIR} for wic to find them when assembling the image. I might be wrong
> > about this, or there might be other directories that are searched, but I do
> > know that putting these artifacts in ${WORKDIR} will get them included in the
> > wic file as expected.
> > 
> 
> I hope you're wrong about this.

Yep entirely. I was totally thinking DEPLOYDIR the whole time, but writing
WORKDIR.

> wic is run as part of the image recipe. It
> should therefore not assume anything about the location of WORKDIR of the
> u-boot package recipe. The recommended way for exchanging data between
> recipes is to use either SYSROOT_DIRS (and DEPENDS) or DEPLOYDIR (and
> DEPLOY_DIR_IMAGE from the other recipe; + do_task[depends] +=
> "recipea:do_deploy"), so I assume this is what's used by wic.
> 
> The `wic create` command called in do_image_wic (IMAGE_CMD:wic) seems to be
> trying to get data from three directories: IMAGE_ROOTFS, DEPLOY_DIR_IMAGE,
> STAGING_DATADIR (and BUILDDIR passed as an environment variable).
> 
> U-Boot upstream recipe takes fw_env.config from WORKDIR and puts it into
> DEPLOYDIR as part of the do_deploy task. Therefore, we need to put it there
> (WORKDIR) now, so that we don't mess with the current implementation of
> U-Boot recipe.
> 
> However I don't think there's a reason for putting u-boot.env into the
> WORKDIR before installing it into DEPLOYDIR.

Sounds good.

> > Thirdly, the default U-Boot environment is placed in "u-boot-initial-env" (a
> > text file). Later "u-boot-initial-env" is converted into a U-Boot environment
> > file (i.e. apparently it has a checksum prepended to it) via `mkenvimage`.
> > If all of that takes place in do_compile(), then the user will never have an
> > opportunity to inject any variables into the U-Boot environment before it is
> > converted to its binary form. So by doing this operation in do_deploy(),
> > it gives the user an opportunity to inject things between the creation of
> > "u-boot-initial-env" in do_compile(), and it's conversion to its binary form
> > (i.e. the form that is including into the wic image) in do_deploy().
> > 
> > I've had rauc working with my rockchip boards for about 5-6 months now, and I
> > know when I put that together initially I wanted to inject extra variables
> > during the build. I'll have to revisit whether or not I still need to do that,
> > but even if I don't, doesn't mean it wouldn't be a nice feature for a user.
> > 
> 
> Agreed that's a nice thing to have.
> 
> We could use a do_compile postfunc for the mkenvimage part though. And then
> you could always do_compile:append to modify u-boot-initial-env file before
> your postfunc to create the mkenvimage runs.

Okay.

> We could also simply have another variable called e.g.
> UBOOT_INITIAL_ENV_EXTRA_VARS whose content is added at the end of
> fw_env.config in the upstream recipe (or in your bbappend before calling
> mkenvimage). That would allow to extend it.
> 
> I think it'd make sense to add support for creating the u-boot env "fs" (via
> mkenvimage) to the upstream recipe as I see this as something people could
> reuse on other vendors?

There was something else strange that I think I noticed in the upstream
recipe. If I'm not mistaken, you can do an environment or you could do a
script, but not both. I'll have to double-check that and maybe take a stab at
fixing that as well (if I'm correct in my reading of the recipe).

> Thanks for taking the time to list the reasons, I see better what you're
> attempting to do in this series now :)
> 
> Cheers,
> Quentin
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#63): https://lists.yoctoproject.org/g/yocto-patches/message/63
> Mute This Topic: https://lists.yoctoproject.org/mt/105454848/900817
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168745/900817/63955952/xyzzy [twoerner@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

