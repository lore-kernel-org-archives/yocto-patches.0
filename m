Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1414EC27C79
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 05:19:51 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.13568.1718774386495645620
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 22:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hB+6GvKW;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-440f1d9377dso28810761cf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 22:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718774384; x=1719379184; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOHY/gkJeW83eDqaOgrMOhKTsJdvlcbd6XeZhC8mLnI=;
        b=hB+6GvKWOVvTrmK8aZwVul15+iUuj0PcvX5aO6kKLkXSlXf8dkEWd3QMn541VFF/Xb
         QhRBtPRWIDKI0fgPX9hdUDctOf2s3uPkFC5L9N1Xr817/VgfGOWLLIBee72g0gpYVaV6
         7FX0IGFq4wvxIWd/HJ5JnZlf64vsgRD4zPwjG+X6Z/GeeOo35nlawCLLukYwmyVL+I8Y
         9nBYECR1+HiQwKKk20QalI2bNpaUMY9nvw7maMZ1/S6sl1FL81sBzAcuk3andqL/QY1W
         q1BVVMy87RndHos5cgtEJuAyQ6/y8amcXCHytwH9FbHzfXUYIBBIPgih4Tl30AhmIHIb
         9h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718774384; x=1719379184;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOHY/gkJeW83eDqaOgrMOhKTsJdvlcbd6XeZhC8mLnI=;
        b=Jr1QZ8crMk08ZRS2lMNhZDuWGWOoEhaX24/LTISjaspe6Sx4nq7LKUP8G+fcW/zP6g
         Er+nCQ1bxXCPAUC+PSbe+9/eKcGB5bP6nhc1xD/5W0lj63FIfb0fDkVwZjtLl8m5SCAX
         Flqh6YVZQk+fEixhmN8ukMdeFkHVhqKsLdpiliNZUW2lh5fZit7yXS2dwY1/TSuurh6Q
         1d7qt5nAnGYdTdw8TZLdJpHISJV9ipTCEyAG1+vNwajrpKMSQI+Q8bIVy1bg+CK5MOQy
         5zcQ2h5blApk6S8pVG5RJ9WYqlaNWd5nF17UCGxYFRxbfiIzcwTWAtURryw21R8Wa5bW
         vvmg==
X-Gm-Message-State: AOJu0YyGPEP6cQ8T+nzjodB6zBPdjJRgrxHVq13mfEFaq1eMTtHzQPfn
	DbPDV9t9HS0a3GhzQGUZnxeTywGr2LN+/9cV1zOm7sMkf8kAjYAKIUoGJg==
X-Google-Smtp-Source: AGHT+IFLowucAUYfspAtZ3cm8fPz+NGbFx4GlgFqPr4+pnGq7Ro8oqBDmw+CcmJvE444r2hMRD06NA==
X-Received: by 2002:ac8:5741:0:b0:43a:c04c:e3d3 with SMTP id d75a77b69052e-444a7a6af2bmr20257261cf.34.1718774384182;
        Tue, 18 Jun 2024 22:19:44 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2fcc54csm62213751cf.67.2024.06.18.22.19.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:19:43 -0700 (PDT)
Date: Wed, 19 Jun 2024 01:19:41 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 4/4] rauc demo: add
Message-ID: <20240619051941.GA26444@localhost>
References: <20240522230808.14409-1-twoerner@gmail.com>
 <20240522230808.14409-4-twoerner@gmail.com>
 <87a55431-aad6-44e5-a897-2b98f9bc77d2@cherry.de>
 <20240619045259.GA6665@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619045259.GA6665@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 05:19:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/347

On Wed 2024-06-19 @ 12:52:59 AM, Trevor Woerner wrote:
> > > new file mode 100644
> > > index 000000000000..1aac59addc26
> > > --- /dev/null
> > > +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf
> > > @@ -0,0 +1,6 @@
> > > +[Partition]
> > > +Type=root-secondary
> 
> Ah darn! This isn't supposed to be root-secondary, I'll have to send a v3.

Never mind, now I remember why it was done that way. No v3 coming (at this
point) ;-)

