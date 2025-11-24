Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C065CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 15:11:58 +0000 (UTC)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18906.1763997116903426740
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 07:11:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=l+ZD/Rfv;
 spf=pass (domain: konsulko.com, ip: 209.85.217.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5deb0b2f685so3704246137.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763997116; x=1764601916; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czfQU4MWpyPuokRFuR5upOMZHN76S0/317ahnEgNmxE=;
        b=l+ZD/RfvYrnKmTzcP8/Lbp5ECDGNoBcTeBhoYUoRjI8NZFReFhhALefUct5KSCfnnc
         2Q7IOt9wahACYCou1E3LWhociWeCYMO+cb4VDDXHLyED8stL50hjXKWAIEA0yLaHSSU2
         hPvGu+4rUfupo0R4WhnOb+lnQgmz4Ly3XiULk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763997116; x=1764601916;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czfQU4MWpyPuokRFuR5upOMZHN76S0/317ahnEgNmxE=;
        b=l3fmNGLVXKwCNJiVvHYyLlMVgQZGukH1/Ax3K8zxlvErqkduWhxmQDZPuIEU7KG8p4
         8zn4WzbXwmwX2wCqeWSYGuYCbEmt+jxlBcSd8t0lwbZO2ObND0w/iP0xJnPBIgl05bEk
         nJvXNwl6xOqj9ZnB6KskKzyEgW3al/1xSlY/XebWWAe3QyvRqJeFECLRF0pP5IkQmi1g
         Ng8dylhHDdt5HG7OgC2O3a2ZcPM7nwe3GOGVMRVbKaktwlR1PeFeGC3XAYuiFxxUFbUu
         FbHrNvDBhCIW8lxxv5vQ/h1+jt1ZuNM1nqU3WHScQYOXSe5tGAw9MhC1yA2XUfdlmly3
         1/Yg==
X-Gm-Message-State: AOJu0YyzPdozvKdpwPrpP+VT2l0Y2pz5Q7YIk8oa/mnADF2LJMltLd7m
	NT9b7ggUjS6EDsz6A+cJ6k9uAu5ZmXc9mqGaRCUkKN3dHENeMtCTBU2EHAkl2VcCCRM=
X-Gm-Gg: ASbGncsan4w0ncfXIN+hpwJMlg9HeC5o+goQFwq5hFPaaowrHRtzHrqaav7Ai4SPUqW
	MBeZOLeM21IDeeXhKtXzF3R3lNm+AfYGjH+kQY61WqrjY8QcmBNAjUXabQ/JXHtM9xUeAy4U6NF
	LlE3EqtkIteCBVpmh149kwgdMoycXL0EidzahyU/3fZ2xxvcV6zqxfblwFgRSWp7AsrB42SdA6R
	ynjhwbKYPfqMMboLp5cCOwzTeKYfTR23H5Kc0EUJ59KPMRF0k5o3dKu2llUOqELr9bU/vUyxPua
	h1FIIxudLVfK1Yv13VvlYBh1zuwYRxCC92ZnHcNtB8f11QJ0Ufj9SmjODrxlCAHuYklaV26L1mL
	dSuL/VoPKSGCzXww24M+soC2WbOB/z/ytTtQd9yXAYH6G3MAxPMs7iSkDayc4wE2HzZ6gpguWin
	Lio0Ttf9+X6UrhLF5TUV5C2pSnkKJB4sv6Um3327VJp2nCrg==
X-Google-Smtp-Source: AGHT+IEgVm5N+0uuIRBu76EXjhDzq1AD5Mz53gwq+A5Qe2rJLHGttisFRjWnW7Bj5ms91bX7/YJegA==
X-Received: by 2002:a05:6102:808b:b0:584:7aa3:a329 with SMTP id ada2fe7eead31-5e1c3bbbed7mr6572299137.4.1763997115735;
        Mon, 24 Nov 2025 07:11:55 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e48f0d8sm101630286d6.25.2025.11.24.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 07:11:55 -0800 (PST)
Date: Mon, 24 Nov 2025 10:11:54 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>
cc: yocto-patches@lists.yoctoproject.org, marta.rybczynska@ygreky.com, 
    skandigraun@gmail.com
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH 04/32]
 scap-security-guide: fix fetch
In-Reply-To: <8b9bc9e9-4b5d-46e8-9ef6-36158827ae14@gmail.com>
Message-ID: <d1d56518-68a4-6553-e768-c209dae1bd8e@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com> <7425c3ca03c6dbb21ba02d7a97787709cb51f8ee.1763938436.git.scott.murray@konsulko.com> <8b9bc9e9-4b5d-46e8-9ef6-36158827ae14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 15:11:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2698

On Mon, 24 Nov 2025, Clayton Casciato wrote:

> > From: Marta Rybczynska <marta.rybczynska@ygreky.com>
> >@
> > The project does not keep releases in branches, instead they tag them. The stable branch
> > does not contain releases, so we use the revision only.
> >@
> > See upstream issue [1] for details.
> >@
> > [1] https://github.com/ComplianceAsCode/content/issues/13543
> >@
> > Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
> > ---
> >  .../scap-security-guide/scap-security-guide_0.1.71.bb           | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >@
> > diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
> > index 5e45332..e277ccf 100644
> > --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
> > +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.71.bb
> > @@ -7,7 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
> >  LICENSE = "BSD-3-Clause"
> >@@
> >  SRCREV = "459f0abf2ac08d36e5fc4a2619bc75cff7000da9"
> > -SRC_URI = "git://github.com/ComplianceAsCode/content.git;branch=stable;protocol=https \
> > +SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
> >             file://run_eval.sh \
> >             file://run-ptest \
> >             "
> Hi, Scott
>
> I would suggest instead updating the SRCREV to
> 879672a39577a8b8c9413641c9e6b8a0bd4f12bc.
>
> See https://lists.yoctoproject.org/g/yocto-patches/topic/116289037

459f0abf2ac08d36e5fc4a2619bc75cff7000da9 is the commit that the
v0.1.71 tag points at, so it is what should be used in order to avoid
confusion.  Now it is indeed the case that since this change was made
upstream have reworked their stable branch by merging all the dangling
release branches into it, so we can potentially drop this for scarthgap,
I'll try a sanity test build.  The upgrade to v0.1.78 is queued on
master-next, my plan is to take it as is, then we can drop a one-liner
on to change the branch, then backport to scarthgap in the next pass.

Thanks,

Scott




