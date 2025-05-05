Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0113C3ABB0
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 14:08:17 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.51283.1746454096781268477
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 07:08:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PkkMhl7s;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8efefec89so45780676d6.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 07:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746454096; x=1747058896; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bWIWDSqLFNZa1LC9keaFIrvWH287oxknvsp82Ve3ck=;
        b=PkkMhl7sPZUT423q4roQKJ6NEfoAi9QZuVHsAPqg7WoJwYoCU8rrMStFimTg44OS7n
         1LSs4L9/FhZkYCQVALhEwIpWbpXezmBlPZjWNFq56bReom/AZTjy6/m3MfyhgAm+a2B9
         gVPD4zPvmUUzE3VsHUyBA0pwGtamtmSyDALE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746454096; x=1747058896;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bWIWDSqLFNZa1LC9keaFIrvWH287oxknvsp82Ve3ck=;
        b=Bj0VIiBoG0QJJ1S5YCaZSbxlGX0xfF9+48gSZyVlVSNGiIP7yY1Za2uxynTVs+9CsG
         UFQYsZqieALTirBIwBwMpABFu5mSMoeF2U0y/irJe/ncXy2kHR1b3nPp0V4EDHwnEfuT
         WMaxZmHunNx4D7NiYa13d2OvjBX8v1277G27FDFhqrsbSzXFNikMOzJRGEJXD71Tg/Ry
         QjCZ+ebIAq8qZyLg9MS+HP9GjqgUnNyBP1cXSX6fxSA0LleoNgwEFa8npgE9eg1XcmiG
         dZmWBZlilN3W7CO+nWM6CYa9tDB2Enl67mSt/HJbsuIpJrOUHSiFG+2+WhBq2+e1mQXS
         HraQ==
X-Gm-Message-State: AOJu0YxT+Lo45e/oqEG8nSbvSFqnkBOTCmLGu+msEfjAklH11RvPhb+p
	ke6jav2zdqX4TZN9eDyvXTBByjIUkbC9GjPB9j+KXXWMiXaKpOyBq4HTNEOxx6Y=
X-Gm-Gg: ASbGncvaiXVWDP9ONgYu7N7NB/EIe/Sk0h9efU3f6dUvR8lxp46Ljp90piN50YkkwjW
	EDwbu/jfQbJ/KwiTNS1paIc6HF419DPYyR4RQRxE8zZGLhIcD054AL1Jcpeb9pvXAU3bSGN+iFR
	EKQAbyUFxWCOdi+YDt4+MVGgo89eWSuWPgEsysrFJSB8z+gMTcxiKkNmmEMY1J2Xi1dSptmCr1H
	c4xLd0mf4HG2EaAbTKMsS+WqR8DLfBuo9BkIhaMAsI8B54weizzL0q4DVTlYDlDoUmSh5BApMU2
	tblP048YfATVbDnY6Q+dc5T9LVJr8M9SBr1ScOdTF1AmHBiVvNKsM5Q6aCgnkd0MQQqPzcV9eo0
	=
X-Google-Smtp-Source: AGHT+IG2KH6zazik4CzRG1+uByONvgpBrV48HLeH99URHnEgE5FgRiox0jU5f+f1nfSM+zXImxmryA==
X-Received: by 2002:ad4:5c8a:0:b0:6e8:fe16:4d44 with SMTP id 6a1803df08f44-6f5157f11b8mr213041816d6.31.1746454095555;
        Mon, 05 May 2025 07:08:15 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f480fb7sm56062486d6.112.2025.05.05.07.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:08:14 -0700 (PDT)
Date: Mon, 5 May 2025 10:08:06 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Marko, Peter" <Peter.Marko@siemens.com>
cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38]
 cargo: pass PACKAGECONFIG_CONFARGS to cargo build
In-Reply-To: <AS1PR10MB569727FD0B9979F109D1CD53FD8F2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <a6380ec1-ff7a-68b6-25b7-021467d77acb@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com> <e5d4f65414368beed7b69e2c94482075aa2a0d81.1746130391.git.scott.murray@konsulko.com> <AS1PR10MB569727FD0B9979F109D1CD53FD8F2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 14:08:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1501

On Sun, 4 May 2025, Marko, Peter wrote:

> This commit creates discrepancy between cargo.bbclass (from mixins) and ptest-cargo.bbclass (from oe-core)
> It needs https://git.openembedded.org/openembedded-core/commit/?id=98d03d31de4010534b1a00d29409d3486a0ab0b9
> Same is true for scarthgap/rust (which triggered me to send that patch when testing last scarthgap/rust update).
> We probably need to copy ptest-cargo.bbclass into mixins to apply that change.
>
> Peter

Thank you for mentioning this, it pointed out a lacking in my backporting
scripting that resulted in it missing ptest-cargo.bbclass changes.  I'll
try to get things fixed up in the next day or two.  Do you happen to know
if python3-bcrypt on scarthgap branch would serve as a reasonable test of
the class?  It's the only non-selftest user in oe-core that I see on first
glance.

Thanks,

Scott


> > -----Original Message-----
> > From: yocto-patches@lists.yoctoproject.org <yocto-
> > patches@lists.yoctoproject.org> On Behalf Of Scott Murray via
> > lists.yoctoproject.org
> > Sent: Thursday, May 1, 2025 22:40
> > To: yocto-patches@lists.yoctoproject.org
> > Subject: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38] cargo:
> > pass PACKAGECONFIG_CONFARGS to cargo build
> >
> > From: Jean-Pierre Geslin <jarsoper@gmail.com>
> >
> > In order to allow rust packages to define PACKAGECONFIG options, append
> > the contents of PACKAGECONFIG_CONFARGS to the build command.
> > This patch was already submitted by Bartosz Golaszewski on older
> > version but was never merged. It will be really usefull for Rust recipes.
> >
> > Signed-off-by: Jean-Pierre Geslin <jarsoper@gmail.com>
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > (adapted from oe-core commit 16745b20452de60ae2474433cc1a2fb1ed9f6a64)
> > Signed-off-by: Scott Murray <scott.murray@konsulko.com>
> > ---
> >  classes/cargo.bbclass | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/classes/cargo.bbclass b/classes/cargo.bbclass
> > index 76a3966..461d100 100644
> > --- a/classes/cargo.bbclass
> > +++ b/classes/cargo.bbclass
> > @@ -48,7 +48,7 @@ oe_cargo_build () {
> >  	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
> >  	bbnote "cargo = $(which ${CARGO})"
> >  	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
> > -	"${CARGO}" build ${CARGO_BUILD_FLAGS} "$@"
> > +	"${CARGO}" build ${CARGO_BUILD_FLAGS}
> > ${PACKAGECONFIG_CONFARGS} "$@"
> >  }
> >
> >  do_compile[progress] = "outof:\s+(\d+)/(\d+)"
> > --
> > 2.49.0
> >
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#1446): https://lists.yoctoproject.org/g/yocto-
> > patches/message/1446
> > Mute This Topic: https://lists.yoctoproject.org/mt/112569359/4454441
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> > patches/leave/13703729/4454441/683413657/xyzzy [peter.marko@siemens.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
>

