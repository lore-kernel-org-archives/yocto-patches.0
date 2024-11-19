Return-Path: <ryosuke.saito@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3649FD60D14
	for <webhook@archiver.kernel.org>; Tue, 19 Nov 2024 03:08:57 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.12474.1731985728839263220
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Nov 2024 19:08:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=waaLM65v;
 spf=pass (domain: linaro.org, ip: 209.85.214.176, mailfrom: ryosuke.saito@linaro.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2124ccf03edso3303705ad.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 18 Nov 2024 19:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731985728; x=1732590528; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBvfPp8UXmhkK7s88Ai1rm5fGsxZc+2sUiNGpNw04fs=;
        b=waaLM65vfvbU66s0aUz1ac4ipVY+GSjJGCRo31ZiTmgkWzCrSmPSFnD9O7J/StFE2v
         UpnQEpYQUxiBY9b92l0F/4u5sZzlL7pdi0avhNmzTxFn2aJPUyemWZpGkYCyaCBgVEXP
         tXgBV5TrJPAVH/fxJUva6Uu0zZ+5wHbHnetbJpsseyQiuprwaPU3lAvQQIEEg5Tn9+CP
         CAVrVwrQ7U5yw8J6xGCuDXH8Y0eC7RfvOiNgxVv8Sm4YdagIYNBiBHTp+u3pr3BAtXiL
         ngZcTnf7NuZR26/lbPevQlMOlMVVvbC2XqU4aSKbYumDkc47BvESdMj6gFRmjoPlr5H3
         k5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731985728; x=1732590528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBvfPp8UXmhkK7s88Ai1rm5fGsxZc+2sUiNGpNw04fs=;
        b=nxEj9kKiTyhvSLcw1syXb0pthtXc7EeN9Ix/4jfm6IxyCCfDIEW73Aanujvm3dxxNM
         u1bZeMPPLCCuxwXutF+QTL/7b9mTrI5F//2su/kufpaz7f1w+1Q4zd+eeYgKCXB0iuLG
         4zvvcZfaQNc+25Q+BBjm1spy7jRiRDHpxoG034vVXDZdEXirU84VJ0hRQLzoWqunCWQT
         cTJ5Pvhs0Vy12aP5i69Q6lGT1Prqfoxjehtm6B3Al/aI+ZH3wbAR+AhpxA9Kgm2C0KNP
         u7QKrSKDUTVxmtJB6sRZxKBif5I9wdG5F97QgeGQ+8oOrwB6QyNOC3EbyZfgT3hPgald
         YkCA==
X-Gm-Message-State: AOJu0YznCWiYfYNZeVZ7b66j1Bf5wSO7T0gANG9QaW7vTGXhtQDukl+P
	vYx+p67Se18jzc4BUP3pZL+pLXDFxcC1sSZdJfX67NsL/76dML8XfsWovCpC4ULJ0Imvc+CGbm3
	4
X-Google-Smtp-Source: AGHT+IHk9cupkvgZQkkFcTeOYLvp6hKqCqAVI3BYecyhnF6Sf/b+1a71QS7LktHRQGQLOGMRdD8WrQ==
X-Received: by 2002:a17:902:dac7:b0:20b:79cb:492f with SMTP id d9443c01a7336-2124a8f8f7fmr30777305ad.43.1731985727657;
        Mon, 18 Nov 2024 19:08:47 -0800 (PST)
Received: from fedora ([240d:1a:3a7:a400:9a57:aa11:487a:b54f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212473bab29sm8598105ad.93.2024.11.18.19.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 19:08:47 -0800 (PST)
Date: Tue, 19 Nov 2024 12:08:45 +0900
From: Ryosuke Saito <ryosuke.saito@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: raitosyo@gmail.com
Subject: Re: [yocto-patches] [meta-cgl] [PATCH] ocfs2-tools: Add missing
 readline dependency
Message-Id: <20241119120845.736d5a012d755f26008abcc2@linaro.org>
In-Reply-To: <CAMKF1spA4GBsR4h6Bx34a1cG8ZePTHU_8=8K+2UukfmHZvnvdQ@mail.gmail.com>
References: <20241118153117.307424-1-ryosuke.saito@linaro.org>
	<CAMKF1spA4GBsR4h6Bx34a1cG8ZePTHU_8=8K+2UukfmHZvnvdQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Nov 2024 03:08:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/822

On Tue, 19 Nov 2024 00:44:54 +0530
"Khem Raj via lists.yoctoproject.org" <raj.khem=gmail.com@lists.yoctoproject.org> wrote:

Hi Khem,

> On Mon, Nov 18, 2024 at 7:31 AM Ryosuke Saito via lists.yoctoproject.org
> <ryosuke.saito=linaro.org@lists.yoctoproject.org> wrote:
> 
> > This patch fixes a build error during the ./configure phase:
> >
> > | checking for readline in -lreadline... no
> > | configure: error: Unable to find readline library
> >
> > Adds readline to DEPENDS to resolve the issue, enabling proper linking
> > during the build process.
> >
> > Signed-off-by: Ryosuke Saito <ryosuke.saito@linaro.org>
> > ---
> >  meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
> > b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
> > index 28b82c2cda94..69daff031a04 100644
> > --- a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
> > +++ b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
> > @@ -31,7 +31,7 @@ inherit autotools-brokensep pkgconfig systemd
> >
> >  DEPENDS = "corosync pacemaker \
> >      libxml2 linux-libc-headers libaio \
> > -    e2fsprogs e2fsprogs-native \
> > +    e2fsprogs e2fsprogs-native readline \
> >  "
> 
> 
> Is there a configure knob to enable/disable it ? If so that might be used
> via a packageconfig

I can't see such 'readline' knob in ocfs2 configure script.

Thanks,
Ryosuke

