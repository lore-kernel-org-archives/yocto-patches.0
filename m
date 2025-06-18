Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E273C71157
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 15:12:34 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web10.1364.1750259547069206453
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Jun 2025 08:12:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ighS8Igf;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6facc3b9559so102030596d6.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750259546; x=1750864346; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mhtIfvyxEa7k2PZdD8uYb9CzoRgZCnrH0QwfqM3ubDk=;
        b=ighS8IgfpSWN4VUPZIW+2OPXed+DqnYrh5RsAcx/57ic7F62golBsshr+6u+PNlse/
         1XQswKl7bODpe1njRFyjY7IheD3ZzRIO7Kgg2r3dl+SpUvW+zI082DJX7/nywSgBLFtM
         eaZt8MQUSV26XvUIgKJQcVvEW879eQR0++wds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259546; x=1750864346;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhtIfvyxEa7k2PZdD8uYb9CzoRgZCnrH0QwfqM3ubDk=;
        b=h/zv74Dz+t/LzSg+NDGzcPAwtjIJkNsNSqNdutFhv5UUXEK0IZww4hAc4wFJEJt8Nj
         Pi4RxpGOpYZ3oRC/FXziY0t0Ux3ANuZJD9K1SEwNv8Nkqi/nvJM4ReIK48BaVq6KgIzD
         uwjWYhR/7oCaCc2BIOlYkuni3DCfDQrCSdAZaauKNCDrOVcaSH/rSt9sDsE1TugLnCAI
         y7vo9n7kXgNxfIrcvyz6Uar0J14G1X3zz0XCkmnGn5LtHA0kloiDDUte18GQu997NaXL
         1U+/YP4pFlCeHQ5f2uWniWPO2zDz9kcPlUgPVqgmh1yLx4DHwzeiGul/kj96STQur3qE
         26HQ==
X-Gm-Message-State: AOJu0YzLJ22wfoQbeKt2RgZegQTRxNs5FBTO7w5acfXfIcxqjpBB1AFA
	/kYM3xRcUGY8tY16p95J6fC1ayGzADjKvz9rIfOgOYXu8dgXSqhpZaRAPjkbd0ssPpBTd2ChxCL
	G9oZn
X-Gm-Gg: ASbGncudxTYSnmAUG/Yhf3/e5Ydnz+sZbbw1x27AnO/gOqFKedfaLfKIlZ92kKqdhTY
	gmsRKgPp5Xqf1etzVBksvLGuYWzhi8/j2ZIoJpZXFaejGrBjxmZYov3Qd+5geIBvqyOZiJGat8i
	o7UFnKSu0XfaDmNJPgkHswV29mJz25NWCkB5FKxRvegvFYU2RWw6eH6z9eHWflcxu6/vb9HGlaZ
	G+YHeHEDmm3/BsNop/Tal0GKcrozJkBUFs6EOpOeXYcw2kIRz35A5gwUSDZVpY/x/nNYYfJuj+x
	oIjKX/KDE82KY19rRrf6jvAVAEPJgLNpJTWd/o6A5yvZYNvfolvMyyOP9fHZHCrz9No/xDciK2D
	5u2F93XlGrI6LUQ2WFesu
X-Google-Smtp-Source: AGHT+IEFMeDwwVofJBBLSEHfcyLT2KWZeYkSZuGj/BWseMQj8DhSE05nDi+K6S1Ql0UA5T31wZ20rA==
X-Received: by 2002:a05:6214:3387:b0:6fb:5f1d:bf8c with SMTP id 6a1803df08f44-6fb5f1dc1a3mr96643466d6.11.1750259546051;
        Wed, 18 Jun 2025 08:12:26 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb4fe7ba68sm42593516d6.69.2025.06.18.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:12:25 -0700 (PDT)
Date: Wed, 18 Jun 2025 11:12:24 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "lepotoman via lists.yoctoproject.org" <lepotoman=msn.com@lists.yoctoproject.org>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust][Build error]
 Rust 1.80.0
In-Reply-To: <9960.1750237305887246239@lists.yoctoproject.org>
Message-ID: <00589c87-6ba2-ae3b-525c-b09d1b08d72c@konsulko.com>
References: <26140.1750230376932992667@lists.yoctoproject.org> <9960.1750237305887246239@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Jun 2025 15:12:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1661

On Wed, 18 Jun 2025, lepotoman via lists.yoctoproject.org wrote:

> I don't know about how you work.
>
> Does I have to propose a patch ?
>
> I mean, if it deserve a patch, I'm ok to do it.
>
> Just, I don't know if the bug is due to a problem inside the meta-lts-mixins layer with my configuration (ie : I cross compile on arm), on the bug is due to an external layer I don't control (I begin in Yocto and everything was already setup by Asus for the TinkerBoard).
>
> What's your opinion ?
>
> I don't know if a lot of person get this problem in cross compilation...

I have tried reproducing this here and cannot, and so far you are the
only person who has reported an issue like this.  So for now, I am going
to chalk this up to a build environment issue on your end.  The file
ownership symptoms you have described sound somewhat similar to issues
others have reported for other packages when using less commonly used
filesystems or overlayfs setups with some container runtimes.  I would
suggest trying a different build environment to see if that helps.

Scott


