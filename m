Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95AAC71134
	for <webhook@archiver.kernel.org>; Wed, 11 Jun 2025 19:32:28 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web10.4234.1749670344061095365
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Jun 2025 12:32:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RvY/gpT0;
 spf=pass (domain: konsulko.com, ip: 209.85.222.174, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7cadd46ea9aso30329185a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Jun 2025 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1749670343; x=1750275143; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE9IwwziG7Uznxc/z76MWCo+4URnNZed9Ad6b6B6kyk=;
        b=RvY/gpT07kDD3GuDIfZgLsTUYJ50ul5/PnqgGDTlTGqGadN/b4/IFZSgVzVS897U+L
         Jadha1OpAWEQnSTP5W1O134VGklKv0NFbhWo7evRIWxdC8nXPKtI50GxFetI7EvxKbf6
         UWmP6ePxzl4x1ay14LUyqn9voPfemFsHbIr2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749670343; x=1750275143;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE9IwwziG7Uznxc/z76MWCo+4URnNZed9Ad6b6B6kyk=;
        b=ha2G9QXzG+rMpG3V+Wi80ypQxbfweyRFaGqWOqY2HbVbqFE0rqcrw74naXGFxBrDHs
         2uhexIY7/9VLK4Qalo3G9mNb6g9JX4D4CM8bo8fISCDtof9WzIl49GmZdpQ1kr6M/8e7
         2/XNuPwq0o6clgoyUtflhi3TQZD7jJrknZK8W5YNFxLjL9jLR+hVY6J4niwoxK5pxr1A
         mXTy9wWnYLBY3/X+gfNKltiFLpA2u0pR07azPQwzevzlVL+Zg3SMPLa3VbcJInLbzeQ4
         ZFZjpJtVF9IdYep52A8wePK36XxmyAEgvzDDAlKQluQbhSO9mNnotTdttdqxSoj5vvyb
         CypA==
X-Gm-Message-State: AOJu0YwXorsfs//SLm7ZptT7USs1/p3Tw1MhfYf80/35CXM0yZm82R2T
	J+a9qocG49vxcKNfnmc9t1nKm5wsmyn6L1IvG+M75LqTLa4HzPXkmyXSBmudEF8VVzidj3jzeLG
	5Rf18
X-Gm-Gg: ASbGnctUwifygZutv3bdcr9EkIiEWWpOZ2d+lGWrIueYaLW3yG6dx8BjmexoQq5MiNH
	0O8ScLUQth34mYWa5YyC2QcE0D9P4j4Rg4tdToS0HJPTdfpdZXjMDqrx//8i1WX1oG8eO8UaEdX
	SvBjQwJ3sG9mXM9QmkIdpPhagrGAOYJZ/DgcIZU3hkxGlaf0kBIJqRj01mEd63FuUjurjQES57J
	rKjEpO50V/8rxUYSJCzm57oMHmSXstPwdjYyZxgqSjWSbB0VHXm0rhkaXPi6jeVX5R330MwdtGU
	bbu1e74vsc7M76O1QD0/Mbmam1K44UvmUW8vUP+rfvBo9RuXDp+c6ck/FRYX36b3Hqfto6/cPe4
	7vMQhuEZNgkosHH58lUdLivH45W9hezM=
X-Google-Smtp-Source: AGHT+IE8XVu3m5wQjsWA/eIZ6i/EknwSk/swl/vV+hmHye4YPRayMtUQ166XY3ZA+bJD8vjEHvRYqQ==
X-Received: by 2002:a05:620a:3185:b0:7c5:405e:e88f with SMTP id af79cd13be357-7d3b29f3bddmr110878185a.21.1749670342662;
        Wed, 11 Jun 2025 12:32:22 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61bfaesm902421085a.80.2025.06.11.12.32.21
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:32:22 -0700 (PDT)
Date: Wed, 11 Jun 2025 15:32:10 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][Build error]
 Rust 1.80.0
In-Reply-To: <szGz.1749647353353443131.4PnY@lists.yoctoproject.org>
Message-ID: <036a708b-c723-fe56-47c2-3574a0bdaa87@konsulko.com>
References: <szGz.1749647353353443131.4PnY@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Jun 2025 19:32:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1634

On Wed, 11 Jun 2025, lepotoman via lists.yoctoproject.org wrote:

> Hi everyone,
>
> I'm new with Yocto project and I'm trying to update for a project Rust for a Tinker Board from Asus that use meta-lts-mixins. Repo is fork here : https://github.com/TinkerBoard-Linux/rockchip-linux-yocto-meta-lts-mixins
>
> I check it from the official repository and they change nothing.
>
> Basically, their version is using Rust 1.75.0 and I succeed to build their project with Rust 1.76.0 by changing the head patch of the meta-lts-mixins.
>
> I'm trying to build on the Rust version I need which are Rust 1.80.0.

Which specific commit on kirkstone/rust are you trying?

> After a try from a clean environment, I get this error :
[snip]
> > new RPATH: $ORIGIN/../lib
> > | tar: build/dist/rust-std-1.80.0-aarch64-poky-linux-gnu.tar.xz: Cannot
> > open: No such file or directory
> > | tar: Error is not recoverable: exiting now
> > | WARNING: exit code 2 from a shell command.
> > NOTE: recipe rust-1.80.0-r0: task do_install: Failed
> > ERROR: Task
> > (/source/yocto/build/../meta-lts-mixins/recipes-devtools/rust/rust_1.80.0.bb:do_install)
> > failed with exit code '1'
> > NOTE: Tasks Summary: Attempted 6118 tasks of which 6114 didn't need to be
> > rerun and 1 failed.
> > Summary: 1 task failed:
> > /source/yocto/build/../meta-lts-mixins/recipes-devtools/rust/rust_1.80.0.bb:do_install
> >
> > Summary: There was 1 WARNING message.
> > Summary: There was 1 ERROR message, returning a non-zero exit code.
> >
>
> I try to find where this download are made but the recipe contains only this part :
[snip]
> And for me, it's little hard to understand where the problem come from. Even in the tmp folder in the build folder, I didn't find where the download are operate.
>
> If anyone know where this error come from I will appreciate help.

As I mention in the kirkstone/rust README, not all versions are tested.
I believe 1.80.0 is one that I ended up not really testing, as there was
effectively a jump from 1.78 to 1.80.1 on kirkstone/rust.  I would suggest
trying to get whatever Rust project you're working with to build with
Rust 1.80.1, or even better, 1.85.1, both of which I have tested, and
were/are the latest version on kirkstone/rust for significant lengths of
time (and are thus somewhat widely tested IMO).

> Last question, meta-lts-mixins require which minimal Python version in the environment to be build ? The readme talk about a Python version that should be 3.11. Does I have to use this exact version ?

To build, the minimum Python version is the same as kirkstone (3.6 or
greater).  The mention of Python 3.11 in the README.md is specifically in
regards to using cargo-update-recipe-crates.bbclass.

Scott


