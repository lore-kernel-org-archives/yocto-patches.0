Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4663ED69114
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 14:44:08 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.96034.1732805038460514416
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Nov 2024 06:43:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Reins9Mm;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b673cb2708so45771685a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 06:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732805037; x=1733409837; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acF+Uw8lJfqVp3l/O3YPW4Dte0sCUoFGCncCWkj2DA8=;
        b=Reins9MmcgrcB9fkuqc+jITwpvZwYk0TgyIJxbUt/5oZhBJJiGwIosouYE6/dsjMFG
         je9QT5NLCcU1j1xJbQQN6plgMvRwXMRq1Et8JR757Qbc6iwENBdjosnR2Kc/Wffb5Pbe
         iSGRjt7mj92tS0gEhvB7aek7CVGc80Jejror5Qu23HCYHd+dcARBjy4xE6TlcwK3hGA9
         NwciUgV9zz+287FjUPPpjP9uNpnyQS4Z3SfSJxJzmva3UJid+pyJu610IXBMt3Z3XNbG
         zy4nYeE32qOTtiSS79j+c1+SnehE4pozsXxKZ2KvqSyRpvSaLP/2e31yy6Ksc9EKTOIH
         1TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732805037; x=1733409837;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=acF+Uw8lJfqVp3l/O3YPW4Dte0sCUoFGCncCWkj2DA8=;
        b=X0Oub/OYlknH094lYquLHjbdv1kWsnBq4diI9pfcg1PIAPf3hYdLG2/aeP9aSynUoj
         99WmvJWVNyvXrxHi87f09MfbjWMW7piljSHJSTjdSRU2pedldVGRibEyKZsHfG+EmLDc
         AymZ/58u5PFiSw/RNYKmb70ldvqaZ1MsvOES0Qnmg+pMWbLvLJ7RyGwqJBb0cb8ev1G+
         PlCrtv+AeyzO794SMF7ZFkccrgQF75Er3IpeuyZ4bGBnfrwJh3lEWFUIiMgRTwuc911/
         e0iwG8ZD5KHr7L3L9WC+ZEhoE+uCu1b4+rwCtgFFUWH1lC9YwOhM9oKPQyWATPV1mv5f
         EOCA==
X-Gm-Message-State: AOJu0YzbrtJqw5uzoWgSVbo92PjK0uswQXghNSMAsEXwTrAwePODqT0c
	wi2DxVqUU6qSvlS7A7kmiXW2h1XA8qTZG6urkjXbj6TIORCA96Hy
X-Gm-Gg: ASbGncuB2Or3I/PkElPdTIXvDNpO0iNdISyhMg2eReCYbsixTZFTSWKWqj9tOkkyPxF
	tZ/feswX43UJqbLR9xZw3xVTS+P56/xUItVURVUjQUlZDYNFVNiGVJY47DjZk0WAkNqrUFArY4H
	CKbZNOUKM9zcOJM1mB8C96ptY6drLXGZUSbxOj5wUyPBVAQgHLf9bXMLKF69+QDl0hlgaixLRAB
	G175S6gONnWQQ7G/KFeB8IT9QKtIJs4V9RZUW3yfKBrhZsuUhOLkVxlHKJyWPLh4q5CFGS7kOEQ
	Ug==
X-Google-Smtp-Source: AGHT+IGu5lbdTr0kCd/P/Xr+31TawfGwUCIJO96MHVq8GYjM56x8qyeOaNOACS08Mw/4Ebbzd/vcVw==
X-Received: by 2002:a05:620a:2451:b0:7b6:6b34:87ad with SMTP id af79cd13be357-7b67c44637fmr866430285a.38.1732805037348;
        Thu, 28 Nov 2024 06:43:57 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b68492cb70sm62484385a.33.2024.11.28.06.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:43:56 -0800 (PST)
Date: Thu, 28 Nov 2024 09:43:54 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip PATCH 1/2] bsp: rkbin: rkbin-ddr:
 use glob pattern for finding DDR init
Message-ID: <20241128144354.GA32500@localhost>
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
 <20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de>
 <20241128005526.GA17984@localhost>
 <cc7d79bf-e199-4478-a290-c4926b21e27e@cherry.de>
 <CAHUNapRvAB5OPtvApDmzM31727KGXnCO3TUe30ZTnELKqZ7YPg@mail.gmail.com>
 <46943cd2-1a08-4357-a32d-eeaba34194b8@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46943cd2-1a08-4357-a32d-eeaba34194b8@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 14:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/855

On Thu 2024-11-28 @ 03:00:12 PM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 11/28/24 2:51 PM, Trevor Woerner wrote:
> > How about a variable to hold the version e.g. 1.18 (or whatever)?
> > 
> 
> Considering the filename has changed already for RK3588, I would suggest the
> whole filename?
> 
> Or two variables?

I think that would be great, thanks!

> 
> DDRBIN_VER:rk3588s ?= "v1.18"
> DDRBIN_FILE:rk3588s ?=
> "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${DDRBIN_VER}.bin"
> 
> So that in most cases you only need to update DDRBIN_VER but it would be
> possible to change also the whole filename. This could be useful if you want
> to use the eyescan one for some reason, e.g. rk3308 has many possible
> frequencies for DDR with different uarts as well.

Do you know what those eyescan frequencies/binaries are for?

> 
> > On Thu, Nov 28, 2024 at 5:23 AM Quentin Schulz <quentin.schulz@cherry.de>
> > wrote:
> > 
> > > Hi Trevor,
> > > 
> > > On 11/28/24 1:55 AM, Trevor Woerner wrote:
> > > > On Wed 2024-11-27 @ 04:12:58 PM, Quentin Schulz via
> > > lists.yoctoproject.org wrote:
> > > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > > 
> > > > > To avoid both having to modify this file every time the
> > > > > rockchip-rbin.inc SRCREV is bumped and also having to override it were
> > > > > a user to have to mix and match versions for different products, let's
> > > > > just use a glob pattern.
> > > > > 
> > > > > Note that the glob pattern should only match one path, which is the case
> > > > > right now.
> > > > 
> > > > I'm not overly fond of the glob method. It was only back in June of this
> > > > year that I pushed a patch to move away from globs to using full
> > > filenames
> > > > explicitly. The savings seem pretty thin compared to the potential
> > > surprise
> > > > factor when, one day, multiple files might be selected.
> > > > 
> > > > Do you feel strongly about switching back to the glob?
> > > > 
> > > 
> > > I feel strongly against the status quo :)
> > > 
> > > We can add a check that only one file is matched by the glob pattern if
> > > necessary and fail otherwise with bbfatal/bberror for example.
> > > 
> > > If we don't use globs, I need to override the do_deploy:<soc> to replace
> > > the path if I'm building a different version.
> > > 
> > > Here's what I needed to do on Scarthgap for example in my own layer:
> > > 
> > > """
> > > diff --git a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
> > > b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
> > > index
> > > 9d381a6afadf7dd66855f6635b5f1f053eecba15..299bb2ac476bf9d988925cbd983a66158a8bdf4c
> > > 
> > > 100644
> > > --- a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
> > > +++ b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
> > > @@ -1,5 +1,12 @@
> > >    FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
> > > 
> > > +# Remove once the following series is merged and backported:
> > > +#
> > > 
> > > https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de/
> > > +SRCREV:tiger-haikou
> > > <https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de/+SRCREV:tiger-haikou>
> > > = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
> > > +SRCREV:jaguar = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
> > > +LIC_FILES_CHKSUM:tiger-haikou =
> > > "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
> > > +LIC_FILES_CHKSUM:jaguar =
> > > "file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
> > > +
> > >    # The files are created locally by running:
> > >    #   ./tools/ddrbin_tool tools/ddrbin_param.txt RKBIN
> > >    #
> > > @@ -24,3 +35,14 @@ do_deploy:append:rk3588s() {
> > >            fi
> > >        fi
> > >    }
> > > +
> > > +# Can be removed once the following patch is merged and backported
> > > +#
> > > 
> > > https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de/
> > > +do_deploy:rk3588s(
> > > <https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de/+do_deploy:rk3588s(>)
> > > {
> > > +    # Prebuilt TF-A
> > > +    install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf
> > > ${DEPLOYDIR}/bl31-rk3588.elf
> > > +    # Prebuilt OPTEE-OS
> > > +    install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin
> > > ${DEPLOYDIR}/tee-rk3588.bin
> > > +    # Prebuilt U-Boot TPL (DDR init)
> > > +    install -m 644
> > > ${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin
> > > ${DEPLOYDIR}/ddr-rk3588.bin
> > > +}
> > > """
> > > 
> > > The last part of the diff shouldn't be needed.
> > > 
> > > If you don't want a glob pattern, we could maybe use a variable to store
> > > the path to match so that it can be overridden in bbappends?
> > > 
> > > What do you think?
> > > 
> > > Cheers,
> > > Quentin
> > > 
> > 
> 

