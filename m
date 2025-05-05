Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2B1C3ABB0
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 15:19:18 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.53261.1746458354651971885
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 May 2025 08:19:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sZCVQkxw;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f2c45ecaffso46187676d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1746458354; x=1747063154; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ewf9A+2DkbME+lxfqe66ypgX980jomng5tTx9PJSAtE=;
        b=sZCVQkxwgTHulWay/NMLVUid5DD0ZWrfifWZKp6naY15vOUfsIPPsVoCxX95zg5KrF
         ALYT1yR2MuV2wtG/Uao+47BAsowHKzSD2Uq35dSERiHvUVJYFNaayqnL5kihzqpeLe41
         hbIl7pPiN0STgpbmZu9IByUzzrS3pLclNm0VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746458354; x=1747063154;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ewf9A+2DkbME+lxfqe66ypgX980jomng5tTx9PJSAtE=;
        b=bi+q79v+Q1U2J1aYhx2CPHPccbUmehyrWKBusyzxXV7K3HTm7yS3YfaLUScPD82imO
         0QygiXnXuNEPUsH7sSdWwlEvQJSfWQGVo9GARtd1hd8Bv41Sb6b2GRC0FKPyvHR4nE/g
         xZ7f9Tzx5QAyH5CSDRnc1pGFR5XdHLc6PYQDW+bdk3gmP8zK5G+3VZ5kbKTxXKYQuTWk
         pZqXcDJA66tANdG5SQq0CFjgBemUu4Pk7zXRHv/7l1Kobjwk7mh6KW93khK/y5GutTaF
         rVDtgLjmmXTyJIxEabO8b86r7F8dird4NfzVI6N0giiZ/sc70FBI/KANglmYrnruUP3j
         CAcQ==
X-Gm-Message-State: AOJu0Yyn7HWR/N6WGIfQee6r+idTtRD3/rrBySVzB/a75svEPwMoaxrf
	9DYzX+mFxkBgyC8zJNsRtMMpk83hFUyGyj3EZc3CclYxQ90dwuFcGzx8gu/Goy8=
X-Gm-Gg: ASbGncuEnHXY8X65x2xEx5anfL//72p03RO79I/BAN/QnGLi3huMtcd1bZo/jA7iEyi
	qEh26oN2RxLqEZrfHhjteEh0HCxocpYcOG3vplFa9VYxRcPlfJVNFEaLPlur+nI24lCVWJ8Jp0n
	5gM8tBplf77cUB8n5ZVGoCyfcLcmGuVf2nRfYcOacpCxuGeVl7e9CBEdO09TFpAn4tIxI7ghizN
	fT+B5T/axOVqKO4ep1vdgQLaCgt07r6805RODxVRucAkDHtOqUBnAG0mwW2bg6N9WhumWm+QQPG
	Mjd1hH2sGKy/q6HStE1h2q5zqFhqZLdkkYPQiGiMfKuSA2QWD7kpy7cQRk/eNWZy9E34PyIvB94
	=
X-Google-Smtp-Source: AGHT+IGO8Z8oZbRU6/2dBnyKtT8ogvDGZ3aN0zIrlbiWGibuT2NOngtccVLA81LVWyPG7xwj6rlIFQ==
X-Received: by 2002:a05:6214:20ac:b0:6eb:2e88:d47b with SMTP id 6a1803df08f44-6f528c54ea0mr111119776d6.17.1746458353648;
        Mon, 05 May 2025 08:19:13 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3462sm56724326d6.37.2025.05.05.08.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:19:13 -0700 (PDT)
Date: Mon, 5 May 2025 11:19:12 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Marko, Peter" <Peter.Marko@siemens.com>
cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38]
 cargo: pass PACKAGECONFIG_CONFARGS to cargo build
In-Reply-To: <AS1PR10MB5697F1856764460365441738FD8E2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <8d815308-e90a-2da0-0c42-07e3bcd227ce@konsulko.com>
References: <cover.1746130391.git.scott.murray@konsulko.com> <e5d4f65414368beed7b69e2c94482075aa2a0d81.1746130391.git.scott.murray@konsulko.com> <AS1PR10MB569727FD0B9979F109D1CD53FD8F2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM> <a6380ec1-ff7a-68b6-25b7-021467d77acb@konsulko.com>
 <AS1PR10MB5697F1856764460365441738FD8E2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 May 2025 15:19:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1514

On Mon, 5 May 2025, Marko, Peter wrote:

>
> > -----Original Message-----
> > From: Scott Murray <scott.murray@konsulko.com>
> > Sent: Monday, May 5, 2025 16:08
> > To: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> > Cc: yocto-patches@lists.yoctoproject.org
> > Subject: RE: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38] cargo:
> > pass PACKAGECONFIG_CONFARGS to cargo build
> >
> > On Sun, 4 May 2025, Marko, Peter wrote:
> >
> > > This commit creates discrepancy between cargo.bbclass (from mixins) and
> > ptest-cargo.bbclass (from oe-core)
> > > It needs https://git.openembedded.org/openembedded-
> > core/commit/?id=98d03d31de4010534b1a00d29409d3486a0ab0b9
> > > Same is true for scarthgap/rust (which triggered me to send that patch when
> > testing last scarthgap/rust update).
> > > We probably need to copy ptest-cargo.bbclass into mixins to apply that change.
> > >
> > > Peter
> >
> > Thank you for mentioning this, it pointed out a lacking in my backporting
> > scripting that resulted in it missing ptest-cargo.bbclass changes.  I'll
> > try to get things fixed up in the next day or two.  Do you happen to know
> > if python3-bcrypt on scarthgap branch would serve as a reasonable test of
> > the class?  It's the only non-selftest user in oe-core that I see on first
> > glance.
> >
> > Thanks,
> >
> > Scott
>
> python3-bcrypt is not a good candidate for testing my patch because it
> does not use PACKAGECONFIG but it also does not seem to use ptest-cargo.bbclass.
> Grepping ptest-cargo in oe-core and meta-oe yielded single hit -
> hello-rs, which also does not use PACKAGECONFIG.
> And I have seen patch for rpm-sequoia to use ptest-cargo, but again,
> not PACKAGECONFIG there. So it seems that it's a feature only for
> custom layers right now until rust/cargo recipes emerge.
>
> Peter

Interesting, python3-bcrypt uses ptest-cargo on scarthgap, but that use
was replaced with ptest-python-pytest on master branch in December.

Scott


> > > > -----Original Message-----
> > > > From: yocto-patches@lists.yoctoproject.org <yocto-
> > > > patches@lists.yoctoproject.org> On Behalf Of Scott Murray via
> > > > lists.yoctoproject.org
> > > > Sent: Thursday, May 1, 2025 22:40
> > > > To: yocto-patches@lists.yoctoproject.org
> > > > Subject: [yocto-patches] [meta-lts-mixins][kirkstone/rust][PATCH 19/38] cargo:
> > > > pass PACKAGECONFIG_CONFARGS to cargo build
> > > >
> > > > From: Jean-Pierre Geslin <jarsoper@gmail.com>
> > > >
> > > > In order to allow rust packages to define PACKAGECONFIG options, append
> > > > the contents of PACKAGECONFIG_CONFARGS to the build command.
> > > > This patch was already submitted by Bartosz Golaszewski on older
> > > > version but was never merged. It will be really usefull for Rust recipes.
> > > >
> > > > Signed-off-by: Jean-Pierre Geslin <jarsoper@gmail.com>
> > > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > > (adapted from oe-core commit
> > 16745b20452de60ae2474433cc1a2fb1ed9f6a64)
> > > > Signed-off-by: Scott Murray <scott.murray@konsulko.com>
> > > > ---
> > > >  classes/cargo.bbclass | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/classes/cargo.bbclass b/classes/cargo.bbclass
> > > > index 76a3966..461d100 100644
> > > > --- a/classes/cargo.bbclass
> > > > +++ b/classes/cargo.bbclass
> > > > @@ -48,7 +48,7 @@ oe_cargo_build () {
> > > >  	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
> > > >  	bbnote "cargo = $(which ${CARGO})"
> > > >  	bbnote "${CARGO} build ${CARGO_BUILD_FLAGS} $@"
> > > > -	"${CARGO}" build ${CARGO_BUILD_FLAGS} "$@"
> > > > +	"${CARGO}" build ${CARGO_BUILD_FLAGS}
> > > > ${PACKAGECONFIG_CONFARGS} "$@"
> > > >  }
> > > >
> > > >  do_compile[progress] = "outof:\s+(\d+)/(\d+)"
> > > > --
> > > > 2.49.0
> > > >
> > > >
> > > >
> > > > -=-=-=-=-=-=-=-=-=-=-=-
> > > > Links: You receive all messages sent to this group.
> > > > View/Reply Online (#1446): https://lists.yoctoproject.org/g/yocto-
> > > > patches/message/1446
> > > > Mute This Topic: https://lists.yoctoproject.org/mt/112569359/4454441
> > > > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > > > Unsubscribe: https://lists.yoctoproject.org/g/yocto-
> > > > patches/leave/13703729/4454441/683413657/xyzzy
> > [peter.marko@siemens.com]
> > > > -=-=-=-=-=-=-=-=-=-=-=-
> > > >
> > >
>

