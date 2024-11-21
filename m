Return-Path: <dorum@noisolation.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E11D6ED17
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 12:29:23 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.9551.1732192154909951442
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 21 Nov 2024 04:29:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@noisolation.com header.s=google header.b=aof0PosI;
 spf=pass (domain: noisolation.com, ip: 209.85.167.45, mailfrom: dorum@noisolation.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53da2140769so883960e87.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 21 Nov 2024 04:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noisolation.com; s=google; t=1732192153; x=1732796953; darn=lists.yoctoproject.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJweWKaCKni/T7IUzZab2Kf+G1KLzD+9tCgCqYNKGiU=;
        b=aof0PosI3BkAqlski05Qr3t9Nx7Dd+34IcK/+YcCrOEonS4dc9IrkUQlj3/dib9q02
         xtAs3SPzEW8Jyu/2h7YB3Ke7PPXAE7nEtiOYl192WOmmZuBm29e07ASD7sx5C02yhdGH
         L6HA6TNLZDw6kQ0+Ik4+Vy2L5pn6V3DeXEan02QXKp+G0saAquFwkbg7DSYe7ZfcZqJ4
         h9rUXTeU/qsey8CbFxcKC0rqinRzMm6ugw3d3JUxM2qNOzvEB2SpZWkSx3tMK+mJR5UX
         4yDiOc3dB+cP/7E7EB9ow26m36P51fKefqklIIixGBfXPSV6qcnMHKIHlYy4Y3FyDnjz
         tmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732192153; x=1732796953;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJweWKaCKni/T7IUzZab2Kf+G1KLzD+9tCgCqYNKGiU=;
        b=uikIvT6kZyh36Y4PfUc7Sm+6hTdvBM4tbv+t3j8K+qZgPTfuQmZDF07eZkJKQw9CEc
         gAppayFQbfZYsf+W5uR7HC9fQXyqoPV6z18rjIr03s9/cL10EPbpZ5hVCeHlgh4OfpJi
         WVxfloxn+igWX6uF9aiNl30y/Uag1iXH5zFcsTpXyWZyElL7ts2GA8ZduVOQTpFA67na
         +Itb8XoNC4UrBD1HQESttivgzEAe6pixWSvrnJ3UdcXp2HrydsyB6Jo1bIGZ2zdmsSLO
         xXRTqjddBfSlRDTcC7RPxbf6Xptpz+fDJ92TtkdxqbOfPH0jFnRtS7/YnDQri5yIWpL2
         HvPA==
X-Gm-Message-State: AOJu0YwqwKZQoqKx+G6VwjvK/uN2IXWWeBm8a0fUmcLhFiD0saFqqD/Y
	P3nKCso+K2zX7qm9r0aeOeyB3y0na1zv1duI37lyi8qd7fV1Ge3/4LHk53ArTQI=
X-Google-Smtp-Source: AGHT+IGHw/aUMcc3Cdr+fzxLAzlc6ZN2lksxutekRRIGE0m348u+rRJT4zLAbAaDISOHYepyUpy+QA==
X-Received: by 2002:a05:6512:124f:b0:533:d3e:16f5 with SMTP id 2adb3069b0e04-53dc1368c6amr3359271e87.38.1732192152928;
        Thu, 21 Nov 2024 04:29:12 -0800 (PST)
Received: from smtpclient.apple (203.237.92.62.static.cust.telenor.net. [62.92.237.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd47b542sm971454e87.253.2024.11.21.04.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2024 04:29:11 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [yocto-patches] [meta-lts-mixins] Create scarthgap/rust branch to
 backport Rust 1.80 to Scarthgap
From: =?utf-8?Q?Martin_D=C3=B8rum?= <dorum@noisolation.com>
In-Reply-To: <fa7168a8-5e96-9025-8fcf-c13df18e54a8@konsulko.com>
Date: Thu, 21 Nov 2024 13:29:00 +0100
Cc: yocto-patches@lists.yoctoproject.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9FBDF944-527C-499A-A6C7-FFFD49B6B458@noisolation.com>
References: <C9A737D5-315E-444F-8D89-1B190D13D3AC@noisolation.com>
 <fa7168a8-5e96-9025-8fcf-c13df18e54a8@konsulko.com>
To: Scott Murray <scott.murray@konsulko.com>
X-Mailer: Apple Mail (2.3826.200.121)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 21 Nov 2024 12:29:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/830


> On 20 Nov 2024, at 23:02, Scott Murray <scott.murray@konsulko.com> =
wrote:
>=20
> On Wed, 20 Nov 2024, Martin D=C3=B8rum via lists.yoctoproject.org =
wrote:
>=20
>> We encountered this issue as we tried to upgrade from Kirkstone
>> to Scarthgap and were unable to build code which depends on Rust =
1.78.
>>=20
>> To enable our upgrade from Kirkstone to Scarthgap, I created a
>> meta-lts-mixins scarthgap/rust branch myself, with backports from
>> the current Poky master branch, in the style of meta-lts-mixins
>> kirkstone/rust.
>=20
> It has been my plan to create a scarthgap/rust when required, and
> similarly track the latest versions from master as with =
kirkstone/rust.
> I have not had a strong need for it yet, but had mentioned on the YP
> call yesterday that I was going to work it up for next week.  If you
> don't really want to maintain a branch for the next 3.5 years, would
> you be open to waiting for that and my doing it instead?

I didn't know it was coming up so soon, that's great news!
We just encountered the need now and made our own mixins layer,
and I figured we might as well share it.

It was never my intendion to become the maintainer of a new layer,
I viewed this as a contribution to the existing meta-lts-mixins project
(That's why I retained the maintenance section as it was written
in the other branches).
I probably should've made that more clear.

> Also, there has been a request for a kirkstone/rust-1.75 to have
> a kirkstone -> scarthgap correspondence, and I am aiming to get that
> pushed to meta-lts-mixins this week.  =46rom what you describe, that
> seems like it might be a better fit unless you explicitly need newer
> Rust.

Our goal is to track Rust as closely as possible. Using Rust 1.80 from
Poky master is perfect. We currently have dependencies which require
at least Rust 1.78, but the Rust ecosystem moves fairly quickly.

>> I kept the recipes as unchanged from master as possible,
>> but I had to replace ${UNPACKDIR} with ${WORKDIR},
>> as that change turned out to be incompatible with Scarthgap.
>> The Scarthgap version of the recipes uses ${WORKDIR}.
>=20
> With kirkstone/rust I've tried to avoid changing recipes as much as
> possible to ease future backports, so I would suggest not doing this,
> and setting UNPACKDIR =3D WORKDIR in the layer.conf or in just a =
minimal
> number of places in the bbclass's if possible.  The former has been my
> plan for scarthgap/rust myself.
>=20
>> I kept the master branch's Rust 1.78 recipes,
>> even though they don't work.
>> They could be made to work by setting different shasums for different
>> Rust versions in 'rust-source.inc'.
>> I kept it as-is because if this should be fixed at all,
>> it should probably be fixed in the master branch first
>> and then backported.
>=20
> I would just drop the 1.78 recipes, as you do not want the hassle of
> someone seeing them and trying to make them work.  If you're keen to
> make a go of maintaining the branch, I'd suggest taking the alternate
> approach of starting with the first post-scarthgap update commit and
> working forward.  This is more work, but has the benefits of:
> - establishing and testing the workflow for updates for the life of
>  the branch
> - allowing downstreams to potentially pick out the various
>  intermediate Rust versions.  I do not make guarantees this works
>  for kirkstone/rust, but it should in practice.
>=20
>> I haven't tested this extremely thoroughly,
>> but I've verified that a basic Yocto project with Poky Scarthgap +
>> scarthgap/rust can build librsvg (a Rust library).
>> I've also tested it with our real-world Yocto setup which
>> has some application software written in Rust.
>=20
> Note that unlike with kirkstone, there is some potential to keep the
> Rust selftests working with the mixin layer, so if you want to run
> with maintaining this, I would suggest looking into that.

All of this is good feedback, but seeing as you're already planning
to make a scarthgap/rust mixin soon, I think I'll leave this as is.
Feel free to use as much or as little of my patch as you want
(though seeing as this all more or less just worked when copying from
the master branch (with the exception of the ${UNPACKDIR} thing),
I'm guessing most of this won't be too useful).

Regards,
Martin=

