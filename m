Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E707DD2D8FC
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:59:38 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8216.1769511577134819986
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 02:59:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=h+WZoQbQ;
 spf=pass (domain: linaro.org, ip: 209.85.167.52, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b6c89d302so5417421e87.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 02:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769511575; x=1770116375; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+uysY4Ui+zITLuhUhFkuUEfEwZU1cAiunoNtdgVojH4=;
        b=h+WZoQbQGAGpmugiV+FjmMSn2CWtdlq2rjOFhYuO04tJMeexg3dt8sjTik4Yfis5+I
         mJASHqoa/gTCz/ueeAlChkgZdFwYfyASPN+OKKbBVVIxATzwAmYdd2fkUstz/nPnCEfg
         oLL00DneODy+97jS5c9IdQ95OdxVPDKPLNXmF9EHlTx8OsOeGe79Sb/2XRjPRpaH3UZJ
         3jXt/S7O9BSZQ7xBvLWERWgwrLgAyTCLqmEnXpwVHtuMbgHYlwGj2DLfQoRNmEvLHXKf
         jSvaJ4iF7WJ5l7fdqYrNNDiNIObh6pXjWh82u8QCbpW5pUPGOJpVAe6jS1T0MDg3Fuzh
         SQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769511575; x=1770116375;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uysY4Ui+zITLuhUhFkuUEfEwZU1cAiunoNtdgVojH4=;
        b=vqIKYtsHekxiTkppSQoLpqFmID9e00uLjH70k03QoypL/2P9hWbetPQ1wxikDXCFYX
         wDSl1vvifaQX88MyKqX5Q+B1PGxST0wgzFMfoSk+7pVtWQsKNj93HzosBS2Cj1zfb3xc
         MRcMSFgjG/l0egsF2KwIF6+JtlsRbQWWenM4tSoK28hAC1fCszysPh/qWMC2ykzCokgS
         iE3dt4ue7LpQesjbciwIjUNGplg1mEBzzl6pxsPp4rxAF0hovr+fibyoEywvOdp21Qwd
         6+YmbEwZv15nm3dqu3V4M7Mxr4YizDuyED6FlPLcz+tKm0DE9QJJaqXMx56WbkczaoqK
         ZxLg==
X-Gm-Message-State: AOJu0YyLnQNUeehNWr3fG/+8kUA7zdpPv2lc5XHrV4f2YibEVahnC6bQ
	VENZdXrhV++ikNK9Gnv3f907JTKUyhkCKJCXWjmHzogY820PsDfpdZIZvhOEFQwdjb8=
X-Gm-Gg: AZuq6aIsyaV3FImh6lm5xDfRYO2s2z6qF9GkedA7hrrs42Lut5CQcI25DjceSKZXm2W
	WZCkBmF475RfKTjH7S02d23A4ZZhtK3CqO7IzQue09KpUqgglJGiZzDTJQ9tNXWYFJTD14LBwzR
	T+6HXnEcvFA51o/JGIXCTIGhjBDC3FUf92OH8uhVNTDS4z1KLmwOO1/BsCmUAk4xiX0f9MHj1zF
	b2voDocOZRXPzOX209Nd6ddp1WKfRNSCU6Su7uG0HPpzw8LvwgtOJYzfETmMNdRr5wGVRydPYrb
	5a7D+lrgwvVcLO2Ne7bfVwvos8ZhmEADEJDakSNliehm3JDbdr8fu6vDIh14tQaj2prt8pMVN1Q
	0zn9F3CiazAn7FsSj0EO3z99p+LGdctTCZX7KN9aNATpLBUEiPIolJTH6hQDu2yt7Yc1NXtj7Qe
	yhMj/vtKUsTLAkVRAvqoApc6zt3rcEesg6rNyEW/2s6fVyBBAcTH0ZUdU=
X-Received: by 2002:a05:6512:252a:b0:59d:f71d:9d51 with SMTP id 2adb3069b0e04-59e0412d189mr634192e87.27.1769511575107;
        Tue, 27 Jan 2026 02:59:35 -0800 (PST)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48eb32bsm3408729e87.38.2026.01.27.02.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 02:59:34 -0800 (PST)
Date: Tue, 27 Jan 2026 12:59:33 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] send_qa_email:
 add git-describe output if possible
Message-ID: <aXialapXFRTMKLh6@nuoska>
References: <20260126085252.178615-2-yoann.congal@smile.fr>
 <aXcy6iZSrBkErjvm@nuoska>
 <CAMSfU+7Tm8W9ZBej-L7S9tJVUo6wJx6tQmiUBWavY9XpHdJ+8Q@mail.gmail.com>
 <CAMSfU+5Kx7GNqRgymCn0WzKGZZfz7E7Pt5tZNLi+U1bn5aTjYA@mail.gmail.com>
 <aXiJLd11pS_eKmRS@nuoska>
 <CAMSfU+4+F9ahjCA1oh-KeR3SUsuF3wKFca3rYQDOPqocwM2MJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMSfU+4+F9ahjCA1oh-KeR3SUsuF3wKFca3rYQDOPqocwM2MJg@mail.gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 10:59:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3117

Hi,

On Tue, Jan 27, 2026 at 11:46:03AM +0100, Yoann Congal wrote:
> Le mar. 27 janv. 2026 � 10:45, Mikko Rapeli <mikko.rapeli@linaro.org> a
> �crit :
> > On Tue, Jan 27, 2026 at 10:40:10AM +0100, Yoann Congal wrote:
> > > Le lun. 26 janv. 2026 � 15:19, Yoann Congal <yoann.congal@smile.fr> a
> > > �crit :
> > >
> > > >
> > > >
> > > > Le lun. 26 janv. 2026 � 10:25, Mikko Rapeli <mikko.rapeli@linaro.org>
> > a
> > > > �crit :
> > > >> On Mon, Jan 26, 2026 at 09:52:53AM +0100, Yoann Congal via
> > > >> lists.yoctoproject.org wrote:
> > > >> > From: Yoann Congal <yoann.congal@smile.fr>
> > > >> >
> > > >> > This would allow to quickly identify commits that are not on the
> > right
> > > >> > branch.
> > > >> >
> > > >> > Partial example of output on my whinlatter-nut branch:
> > > >> >   bitbake: 74f8a927ca6a20342072e5579182aea917b6dc30
> > > >> (yocto-5.3-3-g74f8a927c)
> > > >> >   meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a5bf54c07
> > > >> (yocto-5.3-1-g6973ca6)
> > > >> >   openembedded-core: b4e7819b99d9c1a8995eba87e6f466fd8c77e14a
> > > >> (yocto-5.3-73-gb4e7819b99)
> > > >> > (It shows that every commits are correctly after yocto-5.3)
> > > >>
> > > >> The output may or may not work, and may actually confuse users:
> > > >>
> > > >> bitbake$ git describe --match yocto-* origin/master
> > > >> yocto-5.3-52-gcdd79c1768ac
> > > >> core$ git describe --match yocto-* origin/master
> > > >> yocto-5.1-4541-g6c31c2a73185
> > > >> meta-yocto$ git describe --match yocto-* origin/master
> > > >> yocto-5.0.10-40-gc23c19e0b300
> > > >>
> > > >> and I don't seem to be able to find out in a few minutes which branch
> > > >> of bitbake is used with core and meta-yocto whinlatter branches
> > > >> since the branch is not called "whinlatter" but bitbake version.
> > > >> Oh bitbake
> > > >> default-registry/configurations/oe-nodistro-whinlatter.conf.json
> > > >> has it as "2.16" but openembedded-core doesn't seem to know which
> > bitbake
> > > >> version is correct for whinlatter.
> > > >>
> > > >> I hope this works for "whinlatter" and other releases in the future
> > > >> but the tags are a bit messy stil.
> > > >>
> > > >
> > > > Yes, agreed. That works well only for stable branches after the first
> > > > release.
> > > > Maybe we can only take this patch for those branches?
> > > >
> > >
> > > This is something I can check locally before greenlighting a build for
> > QA,
> > > just tried it for 4.0.33-rc3.
> > > => We can drop this patch.
> >
> > Is there any possibility to fix this for yocto 6.0, for example that
> > yocto-6.x.y tags
> > would be aligned on master branches too?
> >
> 
> I guess not : the releases/tags are usually done after the stable branch
> separates from master => the 6.0 tag will most likely *not* be on master.
> (Or have I misunderstood your question?)

Release tags yes, but pre-release RC tags?

They could be applied to all repo master branches. Now that poky is
gone I think this could be fixed.

Cheers,

-Mikko

