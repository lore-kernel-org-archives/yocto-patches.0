Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B37FCCFA13
	for <webhook@archiver.kernel.org>; Mon, 10 Nov 2025 21:09:43 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1881.1762808973669716070
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Nov 2025 13:09:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=c6MV73iO;
 spf=pass (domain: konsulko.com, ip: 209.85.160.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed82ee9e57so49905721cf.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 13:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1762808972; x=1763413772; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfroi657PzaG6hCVGW7jvIAPbkVFozCU0V9ZM5+eoVQ=;
        b=c6MV73iOyLTImrDebQSLspu3FxMyR7/37JmR+CX6trIDmo1XWYI88PSvKfzgUDaTAF
         BJC0YrDpwusJLSBHmw7zaiuwy3Vh/Ef8qKL06s3YsWw26jdbYiZcU49guikCMVCsAe2E
         YHhizGDpvHsONjASBISt3SoErkyhE91O6c+xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762808972; x=1763413772;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfroi657PzaG6hCVGW7jvIAPbkVFozCU0V9ZM5+eoVQ=;
        b=OKkSzrleCHDcDYiqq57UbxIhpos7nbGIcWadgqI3dPWRiAUL8KJwBA2K9XgAJW1OdE
         C/+YNYPrbDYKENNSNha2liS09iUEWDCVxUrah1rXdP28Iiw/I3f9/yMLSQ0He5G7+K24
         dY+j5Vg6IJWKM6LApJvi7IraowMtQUJnLoeju+NTP28VAoLq+sIwQwjKr2f7eHxr7MkX
         TRXKWYSeU36pIJdI+cwHfAI7I0x9KTg1aHOzw43dnHAQU15rqSdhBJ+NWY0uubYGoulU
         GDlbwpxQPAQ1uObjjLvnUEVrzjw/N5KIyoG5lUxPPsoppHn5NnN5jW3hvB1uzHcPUwAW
         t2Xw==
X-Gm-Message-State: AOJu0YxU0s9+jLdb+aHh6g4PsLgMfh5QmL3A2uMg+d3tBat9a1li97C/
	IftQqBCCXg4BPMYKVZfY8gUb1DB7LagAz+w0yjGa2pnIKSCskHLeyBKY2uFFgWgK+TT5inYxWs3
	rtvsF
X-Gm-Gg: ASbGnctBjrmRoRGKq2fuWSMj4DcblQ1KNQD/4QE7nuahBnOe86vQRDddGKJbXDgVJqC
	+lP6O9YZqIPo0pd0xc2+G03ahsDyQQ1bMdcw/ZtBccULijYZcio1PwaOb25vCAHm3B4NYcV+lXO
	RpezQPRJb6jEM/I0Z+FcdfLW/F3Wa53ISrLeFKfQK0VaNP+1f0VTUX2ZKBGZC3KLJYT40qOA7BV
	AtMI5XZ6kAdWaXPm4BH5Ko10cFcbXoXmEiHZH4wti3dmGFM9hcZcmjnbcauOlgVFazUflXhWI6Y
	Eb3RKvTMow0g52BRJjb9wKzyAL5v8hs5BAuMUaAhOFpWQc86SRhZGI51GW/iGOkR8/QA9QAPZMx
	2BeXI3PbcarmTrfALODexxuw/uyksemOh1ynFlcQlAJFyOzaIs4rNxqjYOdu+ITN46luyP/PxFD
	lUaFzm09ZLNdjo7eOhXGMiq9XCbimO5OPLsToHey/wxvHykw==
X-Google-Smtp-Source: AGHT+IGpRvl6NfSz/2M+/n4HC4WoEajPDiKupff69BJf5Kv/mOThEG4MFmrBzY8jv5fZEL1DlCupcQ==
X-Received: by 2002:ac8:7d95:0:b0:4ed:6574:3a90 with SMTP id d75a77b69052e-4eda4f11931mr119009981cf.35.1762808972377;
        Mon, 10 Nov 2025 13:09:32 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2355e776esm1063246485a.21.2025.11.10.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:09:31 -0800 (PST)
Date: Mon, 10 Nov 2025 16:09:31 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Johannes Aalto <aalto.johannes@gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH] Update
 README.md with SDK configuration instructions
In-Reply-To: <20251109175336.257896-1-aalto.johannes@gmail.com>
Message-ID: <ee2c9c46-ad4a-fd96-df53-2154f2966521@konsulko.com>
References: <20251109175336.257896-1-aalto.johannes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Nov 2025 21:09:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2475

On Sun, 9 Nov 2025, Johannes Aalto via lists.yoctoproject.org wrote:

> Add the required configuration for creating the SDK.
> Motivation for the change is that the steps seem to be slightly different
> than the config for plain poky version of rust (and I guesskirkstone/rust
> branch too).
>
> Especially, line like:
>  SDK_TOOLCHAIN_LANGS += 'rust'
> and/or
>  TOOLCHAIN_TARGET_TASK:append = " libstd-rs"
>
> seems to create a broken set of libraries due to having duplicate libraries causing build
> errors like:
>  error[E0464]: multiple candidates for `rlib` dependency `std` found
>    |
>    = note: candidate #1: /opt/poky/5.0.10/sysroots/cortexa72-poky-linux/usr/lib/rustlib/aarch64-poky-linux-gnu/lib/libstd-370fbb2cfd29928b.rlib
>    = note: candidate #2: /opt/poky/5.0.10/sysroots/cortexa72-poky-linux/usr/lib/rustlib/aarch64-poky-linux-gnu/lib/libstd.so
>
> (although, I'm not quite sure if this difference in config is intended behavior)

I hit the duplicate libraries issue myself last week, and at the moment I
don't believe it's unique to using the scarthgap/rust mixin layer,
oe-core master branch likely has the same problem when using non-trivial
images.  I am going to try to pin down a simple reproducer in the next
couple of days to foster discussion about whether something should be
done in oe-core to avoid the issue.  So, for now I'm going to hold off on
taking this, once the situation is clearer I will reassess.

Scott


> Signed-off-by: Johannes Aalto <aalto.johannes@gmail.com>
> ---
>  README.md | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/README.md b/README.md
> index a00a00e..0f5c30d 100644
> --- a/README.md
> +++ b/README.md
> @@ -29,6 +29,10 @@ Notes
>    support are included, and the backported Rust test is included as the
>    "rust_mixin", it is not guaranteed that it will always be in a passing
>    state.
> +- To include Rust support in a SDK, do the following in e.g. local.conf:
> +  ```
> +  TOOLCHAIN_HOST_TASK:append = " packagegroup-rust-cross-canadian-${MACHINE}"
> +  ```
>  - The intent is to track any further upgrades that occur in the master
>    branch of oe-core, with an expected end of support in April 2028, the
>    same as Yocto Project's planned EOL for Scarthgap (per
>

