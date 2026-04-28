Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9B6FF885D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 10:34:23 +0000 (UTC)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9972.1777372453399040105
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 03:34:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Iy2lYweE;
 spf=pass (domain: gmail.com, ip: 209.85.219.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so161861716d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 03:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777372452; cv=none;
        d=google.com; s=arc-20240605;
        b=DFOB/FqvObj6jiRrr8JSHrJc3zl0i9AonKUy0cSq71gx4yLI4aunBWZDKDt/Q/U0bu
         7EvGhL1f7p3eHM+bYJyjnBGjhRa9fCUX+YwNNIBBytYDhelL4pgqSBlXeuV7Mk3N26Zx
         i6JUEaASxjYN6zr8WFCI7FiQGH87CHYj5yPEbShfb4jp3xo3hBRUScrO6K45b8ug64tm
         v2xA20DKZ0B0pDlqkyIgHTwNlc6AyyL61444Pz+pJi7pHwAqxq5vsXukftNrw3MC7fxr
         Qs2CIKLugKTuXPiWqGAbdYNL/8PSM2MMdH7BerSHCgSsSzG/r5ikjpTSsRHVrXnj8DUb
         tV6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tZj9oDyaPmTrdK2Mphm7Wg4xfuv6Upmvf42TZJ/iuqw=;
        fh=5f3juoVmFZAcDZXxw6MpSCyKznmuK5IWEecktzwNVBw=;
        b=SYyCujU6SzvxyEjoF0sOVvnYCAVrIKrVvbGzwfB8MhbIa1MWILRa3D8KDTiMgz3+iY
         pFEVaenO9R27OP8V/qazi7fyKZd+btfOwh2raMHYa7/x1iW9DJ4xjxQytFjsHqk30eKM
         BK3+x/MaOIsAfCKeyRJxU2BmM3ACs/cokKS8UjLwpZkF/scTEwhaor/6NQouyoGekv4/
         1A63NtM0ZPJ85/85+qmCqEktWnJy+tnZ5uwxOpKmy4EXAQ0pjRTJTzcusl8swpETp9wP
         T892rvVzP/O4EhO6vQnuWzYxM+u0robnOB/Z6nFv/3ict3usk339kmbdcXgO0YM0YVK+
         GHgA==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777372452; x=1777977252; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZj9oDyaPmTrdK2Mphm7Wg4xfuv6Upmvf42TZJ/iuqw=;
        b=Iy2lYweEUnbXEsh1WT3/ncuTGJ4TaCUK742M9qIslKEFROHXWclXYmuiEEmTCHyHZL
         FN/msX3xw+i9AfYfYSUtZwSiJUs1JqcOviLFC15g3Vn8UOtBv9iOO7I2uvcJudXOg59F
         7wt/b/Bd9R7mn5KXDXWGm/UffU+djy3z5YYbHB0SVRF9vGzVAil5crH0tMmur7yeqcje
         r8DZfPpFf0+DiliETBvhaUNfraLRGCBqqkwjVx9f8KZdxbmyIYDPGEDtuAsF3rPvDGWH
         WndGhFS9RDZVTOjW+gRAtCuZeymyoIbluwV5VAv2+TrFJZjQtRv05IVJlZltZE1Sor69
         +DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372452; x=1777977252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZj9oDyaPmTrdK2Mphm7Wg4xfuv6Upmvf42TZJ/iuqw=;
        b=DYQJTWrQQCqNQLI6zZwfxrRHE6oL3PHoRDCrInNxhyPinUoNEVhRYkKRQm2gc9N9uG
         /n7d1cKwv1uTJanwf5ZsDF+heuB3Q2Vv+UHLV7wf2uwcF5akyOGVdHOZr/t8UNFkN27c
         k8vENz9UMa7R0I0HsOHg1iP3yxP9rmxn0lHWP+fi5lN/yG0kVyJEO4sfRfiHDfJYp5xo
         o42IfaQwvnue8r7PYjY0jsuug7pQslrxxNoKer03raR/9wiV3XkfSYuNFmfcz/zmt80p
         6/j/nc5ul4NxczJn9SLqpiRrimSmfSNx2zbmmF15YAJjliiMJRk0Ui2AM7WvMRErnCCr
         K/4g==
X-Gm-Message-State: AOJu0YyVfWvLkMeQFIrD8/b99se3UbrlSPP+598HgbVh0ijdLPR+6c3n
	uvMZEI37mxaqONVG5BPEKyG20oY/nP3and2W8g78rgLWXQVBH9qxUlcGeOngZsLD6uy5/ogmcH6
	XYY1Fgl9iSSis9b1l+BGClidvUTCZVcU=
X-Gm-Gg: AeBDievvumHIl3KMaff170yF2essLYCiQ7nEVilQxPSpEzSsHe/VvtSc3LtE+76kAcU
	qy/tflyBiUHxDQz4EC889IBsbmaDfm4quKuphefC6FfxvI83FO9cgkSi0SkO6l4Z+1OQMywd1g6
	qI867q68sw8LDC3DeywLppU4ljl9jUITOnbcj+4UbdsnI2HHzetawRMCLup8l2XFcv8u7Lispqm
	/NLySFA0NNJq4ZYb2pAwqy0+lDsfY7EqB7oAWgWoQu2i6Wq7yzjZQEBwGDmO+t3R5BUqJRipiYN
	8YW9AcSMXHcBK0dt95OKoY4XKnJ7XNqNGaYpJnuSQfrgL2xaGR1j
X-Received: by 2002:a05:6214:401c:b0:8ac:a097:2810 with SMTP id
 6a1803df08f44-8b3e3061c35mr39155626d6.27.1777372451307; Tue, 28 Apr 2026
 03:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
 <20260424114603.2444938-7-daniel.turull@ericsson.com> <CANNYZj9xmzFLVb0ECP7LYbvtf09rafXc0CbAz7o31gNdZE6CkQ@mail.gmail.com>
 <PA3PR07MB107211FACF80A58913CC8032F8A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
In-Reply-To: <PA3PR07MB107211FACF80A58913CC8032F8A362@PA3PR07MB10721.eurprd07.prod.outlook.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 28 Apr 2026 12:34:01 +0200
X-Gm-Features: AVHnY4Lf4xydzTIygmYa9UBEP8yQm98PWyTPdtPvtfAbWXSZfE6fLxqGYJl_3-c
Message-ID: <CANNYZj-6+eQXqKEmUmh_NSg2c=QjuQhAOUcrMbUDBcFLeTJKgQ@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 6/9] upgrade-helper.py: Add minor option for minor
 version upgrades
To: Daniel Turull <daniel.turull@ericsson.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
	"paul@pbarker.dev" <paul@pbarker.dev>, "ross.burton@arm.com" <ross.burton@arm.com>, 
	"yoann.congal@smile.fr" <yoann.congal@smile.fr>
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 10:34:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3865

On Mon, 27 Apr 2026 at 14:30, Daniel Turull <daniel.turull@ericsson.com> wrote:
> That said, adding recipe variables to already-released branches (scarthgap) means backporting metadata changes. The CLI flags work today without touching any recipes, which is why I started there.
>
> Would you prefer I rework this as a recipe variable for the next version, or keep the CLI flags as a first step? I mean only one option (--stable) that can read AUH_UPGRADE_POLICY if present otherwise default to patch?

Please see my comment to 5/9 for additional thoughts on this. The
major point I need to stress is that the correct long term
maintainable thing is to extend existing oe-core mechanisms, even when
such changes are difficult to backport.

Specifically:

- the version check functionality in meta/lib/oe/recipeutils.py should
be extended to support checking for latest minor and point releases,
and possibly other ways to provide stable updates (e.g. commits in a
branch, or a custom regex for e.g. openssh's 10.1p3 schema).

- 'devtool check-upgrade-status --stable' or 'devtool latest-version
--stable' would return a list of what could be updated based on recipe
metadata (e.g. UPSTREAM_STABLE_RELEASES = "point" in some recipe would
make devtool query recipeutils for latest point release within the
same minor release)

- then AUH would simply use these mechanisms to do stable updates,
when it's run with --stable argument. It would be a trivial change; it
wouldn't need to know or care about how to pick the correct version,
just call a different function to obtain maintenance releases instead
of latest releases.

Alex

