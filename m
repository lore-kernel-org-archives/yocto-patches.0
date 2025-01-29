Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B2C0218F
	for <webhook@archiver.kernel.org>; Wed, 29 Jan 2025 18:58:18 +0000 (UTC)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web10.20739.1738177090108584703
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jan 2025 10:58:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nRagAfMv;
 spf=pass (domain: konsulko.com, ip: 209.85.166.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-84a012f7232so29869739f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1738177089; x=1738781889; darn=lists.yoctoproject.org;
        h=mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/4KjogVT6BhzEIO9YBqKF4YffvG2xPu89ok7/PMbYvE=;
        b=nRagAfMvukGWGjcPLLo5KaTiF49Wze37TvTt5auD38kXKGNJUsQNTEDn/B1PVFcWkO
         slZPXh64tl/jjZOHjjKs5hBvA5cxEaEwyjs2VeXJUvrxwBH7MMaXVPb0RrrxSqs/wkjZ
         tXWIbmhDmdR+NjHtUjABHhYFvCTpnRtLS0ATs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738177089; x=1738781889;
        h=mime-version:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4KjogVT6BhzEIO9YBqKF4YffvG2xPu89ok7/PMbYvE=;
        b=ZJw82LCahkAQa/9uNYem8jpfjUmgUJoYeF9uDUmRpmVL7y63eZqYtdrqSox94OsQpC
         2cHI1y4glqwxWKmtrzFWcVWbFY3PpDEqZt8eSHuQPrr3Sd8xvx3tUJCxUwIQEu6O9vFV
         LmQmE/D/ZlNDBxkOVV5uc0zN3TisQ8W+NSWlP5sw34eXA4nJJq8k76eWQtvRXfHP8ldw
         Nf9gel/lDnCCwFeSrQD7kZkQQr45ky4DDkBblzjiPRCASPcEbEMbPXhK6SCfYuGfWK3a
         hIm7YWRULNvu8vJyIOmJw/JRCKg1QsFLU7bXJdouv06W1THymfZ9ddAMGAcpOyr4giWf
         xMlg==
X-Gm-Message-State: AOJu0YyrPSvzNTat0EPBcqAp50m19F+jhy7A3r9xB6QOzR4YEewYxuKu
	RngEcC4Zc33mEw6RT6jfBxdjBNj0Jq8xGz3OZB2BwsHNMwBXsi2hlTvS/hptzVSXxSVEXC1G6yL
	0
X-Gm-Gg: ASbGncsmRApXIvy7ZEpnixwGYDcFIsy2m4G+DITwf0nRPAs/Trjw+B9yiwsNaEYDT3R
	dXq6grAC1sjRg2iOogCaYY9W8Bo+8Bbif+lL7Lgr2PSxm63ee7/aKpZT0OE7WTSIMiuHJnFnzoO
	emGWhzmX6VA3+2koTzCUnKSSB8UTXoD3mE0S5lGEbznKWJ2O5WCQsVrcRG964mlGgPPQO6oeOuW
	xkE4KuRm6FwEX2SRDa80+O9usi/KPfi4m6BAdI23jRb2B97GeqOsP8pAquYiDpAuBIwY9KhICxs
	5dfT36sjTUlhReO7fV2fkiYAViZvO7+W89d4dKIGfxee//q6qA==
X-Google-Smtp-Source: AGHT+IFKjqhUKum5+m8PO52QDSOXccVGC4XghB4Ha3RFhBp9zVfHg05/tK4v1NpausCGwWuP5ycvlQ==
X-Received: by 2002:a05:6e02:1cad:b0:3cf:6ea9:9c0f with SMTP id e9e14a558f8ab-3d008f97f7bmr3880695ab.8.1738177088960;
        Wed, 29 Jan 2025 10:58:08 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec5cceee79sm869035173.126.2025.01.29.10.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:58:08 -0800 (PST)
Date: Wed, 29 Jan 2025 13:58:07 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org, yocto@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust] RFC on librsvg support
Message-ID: <5ed9ec27-cc24-f086-afe9-c77ead2f359e@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jan 2025 18:58:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1023

I have just pushed out the patch series to bump the scarthgap/rust mixin
to Rust 1.81.0, and I have the same mostly in hand for kirkstone/rust, but
there is an issue I wanted to get community feedback on before committing
to a course of action.

The issue stems from librsvg >= 2.59 now needing at least meson 1.2.0,
which is a lot newer than what is available in kirkstone.  That rules
out backporting the librsvg 2.59.2 upgrade from oe-core into the mixin,
and dropping support of some kind is not feasible as the librsvg 2.52.10
recipe in poky kirkstone does not build with the backported Rust toolchain
changes (note I mean the various bbclasses here, I've not gotten to the
point of trying to build it with Rust 1.81.0).  Another more general issue
here for kirkstone branch users is that librsvg upstream have recently
updated their supported release list to just 2.59.x due to the effort
required to backport fixes[1].

The upshot of the above is that is raises the question of how folks would
like me to proceed with librsvg in the mixin.  I see the following options
in order of likely increasing effort:

1. I stick with the librsvg 2.58.2 recipe and leave things alone unless
   it stops building on a future Rust upgrade.  This is effectively
   sweeping the issue under the rug for now.
2. I do upgrades to newer librsvg 2.58.x releases (currently 2.58.5)
   in the mixin to perhaps provide a bit better story wrt security fixes.
3. I drop the librsvg backports in the mixin in favor of attempting to
   instead carry a replacement recipe that builds the same librsvg 2.52.x
   (currently 2.52.10) that is in poky kirkstone with the newer Rust
   toolchain.  As mentioned above, at the moment I'm currently unsure if
   2.52.x will build with 1.81.0, so there is some more risk on that
   front.  The argument for this would be matching what stock kirkstone
   provides.

I would appreciate input from users of the mixin on which approach they
would like to see, especially options (2) vs (3).  I'm sort of ruling out
significant hackery to enable using new meson for building librsvg, but if
someone has already done similar without needing to carry a lot of
baggage, I could maybe be convinced to try that approach...

Thanks,

Scott

[1] https://gitlab.gnome.org/GNOME/librsvg/-/commit/7672fc63

