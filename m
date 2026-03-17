Return-Path: <hfranco@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76258FD7091
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 20:19:33 +0000 (UTC)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.86159.1773778764196888868
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 13:19:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=gOUewtEm;
 spf=pass (domain: baylibre.com, ip: 74.125.82.54, mailfrom: hfranco@baylibre.com)
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-128d2e3074fso8019669c88.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773778764; x=1774383564; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oM/VIjqkgSQs+XEWbOLI6HAJ91CsV/EpaHv1HKemBZg=;
        b=gOUewtEmxQiHhsE2Z8GoT1xU9brBAiteOXgWnu8OWpRTnYKbOwO0Ucf2U4qGWj2LD7
         tR+0kfj3597H7/KICe1moQenKh71nNaAFX12wjLf0McZMZA2A0UB1ZVb2WIldx/2LX44
         thgEAnA3ygdu2nGnXeu+dfM0xt06yHaTEf/LwYaoXlzcKge8vWUnGW8JmMWP6KKTcnu7
         zcmq1Gtb+57331kcHZsmQ7w4dyk/GI7eAa/eBLZbe4HYB6jm8nwNFKPM+8iG+uMbZVWz
         mUazZPxNVccjnbzDyKkHZF6Cdr+7pvaJfcAe7TD40tRncpAptGnIEuD/IEPAfISL8xcH
         opbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773778764; x=1774383564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oM/VIjqkgSQs+XEWbOLI6HAJ91CsV/EpaHv1HKemBZg=;
        b=MDx1xeZ5DcmdJ57M0TKJDu7RVAaRhIXK2wG8qIekiH4Oho/nv99lWXjJmjx8PM9iSQ
         WDMQaerjLqQuLscAP7L5aQAnJD2P1akAVEPdG6Q2JQFwwe+IfpfTjjYumUVomzsrD71m
         WSwQKb6eBC8bX8DzL+9GxxolZSQD2Btgt7jJYOrjuSPjiwR6hOwhK/kC5lyQE5X4bVW3
         Li//5+ePW+xD+CHU7c9eDb4giUJRwZkQuoEDtVlQT1vkuiXWnmdNohGc95E1GfsHw76D
         j0sD8xDNUPz759tOmBSyZA1ohOpGmz/gaYl4fYn+VRX2sFpo0VzdnfaZJ7IiZBYz5sud
         rLBQ==
X-Gm-Message-State: AOJu0YySnjJ1Ua+wRBKT3a+F34x+cLIZtSvdQCj7LTLmLW+bWGLA3Zkp
	11VvPTiBpqXr04Pj94oyCSP5qbS3n/gP7z3dTkYoKbKfB+DSrWZHoO6pfCav/Teecow=
X-Gm-Gg: ATEYQzwdChEKiw32WVMpuyPHj1SY8PmwAXdOqehLpnIMrpe5Lx2m8PA3EmlfGLvo9q0
	bhm+72f16PJ+p6/gU4hXiFRDzcPwpAV/DYDBAGUqhDH4i4JYDjuBjbJt7iX8Dwb1pjWEAXSr/r7
	bMATTu46eE77XVF3dol0ZoRU0rVK+tPtzkNW+7F7tkwW8Gk/Q6bvBkCNsonwsXrtJTPmS9L1qmS
	cwEUjcyvkcYHP4RM7ztSTTV8o9aiEJ8eWGiG7pPQV9gFe3EWd3gIURVn+fSCVbA0G887jj9/Eug
	E8/pmelqJP78Sn8cYF+/chFy4V5D6FTc3W25OTV0WccEpIsPhYf1ULOyanxQ922sQYRgxAMs2D1
	Ict/B07nVXakRjdcYfc3suW7xbnRe3Ok3o9EydAH67P2/kYovWIIbVo7dGWN6oy56K9pvT/NqEJ
	9QiO9fj+8IAJEA6ahKHvAX1bPU4E1Kd8Ul3rEgYic7M6oOr0S+kuwzBW/+PCUH0yTJ0q7spfO9m
	A==
X-Received: by 2002:a05:7022:68d:b0:128:d2f2:5cf8 with SMTP id a92af1059eb24-129a7177e11mr518450c88.34.1773778763489;
        Tue, 17 Mar 2026 13:19:23 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c0:c4f1:ec8d:3c3c:583d:3ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e56062e4sm757741eec.30.2026.03.17.13.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 13:19:22 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:19:17 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: yocto-patches@lists.yoctoproject.org, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, Yi Zhao <yi.zhao@windriver.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
Message-ID: <sss57j2a6lhf4xwqyggszbhfmucmso6v4grod7qjlwkpmi7i3a@msq74hhqkens>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
 <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
 <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DH59MQQ8LHWC.25HPETRJUAGLI@smile.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 20:19:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3493

On Tue, Mar 17, 2026 at 07:23:35PM +0100, Yoann Congal wrote:
> On Tue Mar 17, 2026 at 6:40 PM CET, Hiago De Franco via lists.yoctoproject.org wrote:
> > Hi Richard,
> >
> > On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrote:
> >> On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctoproject.org wrote:
> >> > 
> >> > On 2/13/26 23:42, "Uwe Kleine-K�nig wrote:
> >> > > With SELinux enabled for the target it makes sense to have SELinux
> >> > > support enabled for the native tools, too.
> >> > > 
> >> > > Note that for native packages DISTRO_FEATURES is filtered, thus up to now
> >> > > it never contained "selinux". Append to DISTRO_FEATURES_FILTER_NATIVE to
> >> > > make "selinux" propagate also to DISTRO_FEATURES for native packages.
> >> > > ---
> >> > > Hello,
> >> > > 
> >> > > I use this on scarthgap, but the patch applies fine to master, too.
> >> > > 
> >> > > During a debug session it took me quite a while to find out why
> >> > > 
> >> > > 	ls -lZ "${IMAGE_ROOTFS}
> >> > > 
> >> > > at the end of selinux_set_labels() didn't show the labels added by
> >> > > setfiles.
> >> > > 
> >> > > Best regards
> >> > > Uwe
> >> > > 
> >> > > � classes/enable-selinux.bbclass | 2 +-
> >> > > � conf/layer.conf��������������� | 4 ++++
> >> > > � 2 files changed, 5 insertions(+), 1 deletion(-)
> >> > > 
> >> > > diff --git a/classes/enable-selinux.bbclass b/classes/enable-selinux.bbclass
> >> > > index 3dc61d6931ff..0c9f52e74cec 100644
> >> > > --- a/classes/enable-selinux.bbclass
> >> > > +++ b/classes/enable-selinux.bbclass
> >> > > @@ -1,3 +1,3 @@
> >> > > � inherit selinux
> >> > > � 
> >> > > -PACKAGECONFIG:append = " ${@target_selinux(d, 'selinux')}"
> >> > > +PACKAGECONFIG:append = " ${@bb.utils.filter('DISTRO_FEATURES', 'selinux', d)}"
> >> > > diff --git a/conf/layer.conf b/conf/layer.conf
> >> > > index 4e04e5cc7e6a..ca981db57019 100644
> >> > > --- a/conf/layer.conf
> >> > > +++ b/conf/layer.conf
> >> > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux = " \
> >> > > � "
> >> > > � 
> >> > > � PREFERRED_PROVIDER_virtual/refpolicy ??= "refpolicy-targeted"
> >> > > +
> >> > > +# With target support for SELinux it is very helpful during debug when the
> >> > > +# native tools support SELinux, too.
> >> > > +DISTRO_FEATURES_FILTER_NATIVE:append = " selinux"
> >> > 
> >> > Can we add this to the doc (e.g. README) instead of enabling it directly 
> >> > in layer.conf? Since we haven't directly enabled DISTRO_FEATURES = 
> >> > "selinux" in layer.conf either.
> >> 
> >> I just wanted to add that putting that directly in layer.conf will mean
> >> the layer isn't Yocto Project Compatible too.
> >
> > I am going to send a v2 and take over this work, already asked Uwe about
> > that.
> >
> > But before doing it, I was wondering why changing layer.conf will make
> > the layer not compatible with Yocto Project anymore. Can you explain to
> > us the reason?
> 
> I'd guess it is from this criteria of the Yocto Compatible layer[0]:
> > Inclusion of any layer in the submission does not change the
> > behavior/configuration of the overall system without the user
> > explicitly opting into those changes
> 
> By putting a 'DISTRO_FEATURES += "selinux"' in layer.conf, the
> configuration changes globally without explicit opt-in of the user.
> 
> [0]: https://www.yoctoproject.org/compatible-registration/

Got it, thanks for the explanation! I will send the v2 patch soon.

> 
> >> Cheers,
> >> 
> >> Richard
> >> 
> >
> > Thanks!
> >
> > Hiago.
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#3491): https://lists.yoctoproject.org/g/yocto-patches/message/3491
> > Mute This Topic: https://lists.yoctoproject.org/mt/117794339/4316185
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13179410/4316185/929767106/xyzzy [yoann.congal@smile.fr]
> > -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
> -- 
> Yoann Congal
> Smile ECS
> 
> 

Regards,

Hiago.

