Return-Path: <joe@deserted.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BE8C3DA61
	for <webhook@archiver.kernel.org>; Wed, 24 Jul 2024 15:26:10 +0000 (UTC)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
 by mx.groups.io with SMTP id smtpd.web10.13468.1721834764327890925
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jul 2024 08:26:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@deserted-net.20230601.gappssmtp.com header.s=20230601 header.b=ntS9G9kD;
 spf=none, err=permanent DNS error (domain: deserted.net, ip: 209.85.222.174, mailfrom: joe@deserted.net)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1a6af9401so307193285a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 08:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deserted-net.20230601.gappssmtp.com; s=20230601; t=1721834763; x=1722439563; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SsVunqNvTLAtVKLhDyFtHTlPXonnJtr1myaP/K4Anc=;
        b=ntS9G9kDfvR0mT2duHipsgMusLukvaD7ltWnItkTkqrUxM9B6jKUKTeUXyn7cqfKHC
         5wieO9TVwIez7nlJkSfamZ43RERIQFk79OFD/LuKLaUd809inOQKCtFGnYWArnS+ZSe/
         wAn1M5w2p8lPwfx/zzkIMH+IZZpOF0HxiWFq3OrDZxEzUnxywPB1M4fptW9hCdTCtelM
         W1W3DZb8hhJrv7iWVfI+y30PpgwReVMPHGSiRgkobwR2AxhGrR6MeCQreknm2vDquV70
         3K4uINoogBbYUF4i4HeS3Q9Xm/FAexEI04v5rKEIcMFvOJ15uH8198Y7z9C05/QJi9PD
         UgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721834763; x=1722439563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SsVunqNvTLAtVKLhDyFtHTlPXonnJtr1myaP/K4Anc=;
        b=SQNcX/r1/zhKAnUmYZFG5VevhzykeFaMXHx5guw7dCvlOO5Q+9YshN8okVsadmNYnk
         Pv0QE/zC7DKSvEfn2zejvQQCEnWKitq0IqwPNE2VWPEFx9UVqccA4NDq7Xr6EdpL7q23
         Td4LLc6oLQj5ECDdLnxfVaXHiBQNbc7tP5YAsAg4Q+bU6tqrD2unBd9ZHdCUP/d5boZi
         p3SrBw3A1pK470WBKCFY9J1Js/RZyA/8h2YvRai24Tf12XhlSSD84Am0qWKYWGYTh97G
         /7JHSGT7XOcyOOD26wzHCjcL3RNtQ1VQb+egomynqbHdmRwPd3+ON2BAmS6IeH8IINg7
         WzCg==
X-Gm-Message-State: AOJu0YwbZIRXHok3P5b1F5JxIxUNjPNVp94Z+kuUudx7itCqH9z+KeGn
	ULqfMUCtcVLiQamXaheEWuQtY3+ITjAdqSZoW1m2mHj3Va9kBA1DmqCvR1GLaw==
X-Google-Smtp-Source: AGHT+IE/5l3AMGgJuie0UYLLTqlEoq5iCZJTVE1q36u6mwP21rhDaqhl0fDFp78/5VZTYSsno2fxkw==
X-Received: by 2002:a05:620a:4304:b0:79f:f85:e82 with SMTP id af79cd13be357-7a1d455dcbcmr1094485a.10.1721834763241;
        Wed, 24 Jul 2024 08:26:03 -0700 (PDT)
Received: from nightwinge.deserted.net (bras-base-jkvlon0513w-grc-21-76-64-181-148.dsl.bell.ca. [76.64.181.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fba3b9sm588295985a.29.2024.07.24.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:26:02 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:26:01 -0400
From: Joe MacDonald <joe@deserted.net>
To: Yi Zhao <yi.zhao@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, joe.macdonald@siemens.com
Subject: Re: [meta-selinux][PATCH] shadow: comment out pam_lastlog line in
 login pam file
Message-ID: <20240724152601.2ti6auxh3mfpptnt@nightwinge.deserted.net>
References: <20240724141329.3326073-1-yi.zhao@windriver.com>
 <20240724145353.7yxqlbaetvims2tz@nightwinge.deserted.net>
 <df0f4afd-77cc-4cb9-9b84-2f385be71527@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df0f4afd-77cc-4cb9-9b84-2f385be71527@windriver.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 24 Jul 2024 15:26:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/453

[Re: [meta-selinux][PATCH] shadow: comment out pam_lastlog line in login pam file] On 24.07.24 (Wed 23:16) Yi Zhao wrote:

> 
> On 7/24/24 22:53, Joe MacDonald wrote:
> > Given that this is deprecated and disabled by default, is there any
> > reason to keep this in at all, rather than just removing lines 67-70?
> 
> Although lastlog is disabled by default, the code is still there and
> users can enable it via configure option --enable-lastlog. So I did not
> delete these lines. In addition, keeping this line will allow users to
> easily switch to lastlog2. Just change pam_lastlog.so to pam_lastlog2.so
> in the line.

What about commenting it out but also changing pam_lastlog to pam_lastlog2
since that is part of util-linux 2.40+ and that's the version in Yocto
today, then?

-J.

> //Yi
> 
> 
> > 
> > [[meta-selinux][PATCH] shadow: comment out pam_lastlog line in login pam file] On 24.07.24 (Wed 22:13) Yi Zhao wrote:
> > 
> > > The pam_lastlog module is deprecated and disabled by default in
> > > linux-pam since 1.5.3[1]. Comment out this line to avoid loading
> > > pam_lastlog module by default. Users can use lastlog2 provided by
> > > util-linux as an alternative[2].
> > > 
> > > [1] https://github.com/linux-pam/linux-pam/commit/357a4ddbe9b4b10ebd805d2af3e32f3ead5b8816
> > > [2] https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=c2e299d0acb2fa4ad1691452fa0eae76520bbdb0
> > > 
> > > Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> > > ---
> > >   recipes-extended/shadow/files/pam.d/login | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/recipes-extended/shadow/files/pam.d/login b/recipes-extended/shadow/files/pam.d/login
> > > index ec5bba9..eb43f3b 100644
> > > --- a/recipes-extended/shadow/files/pam.d/login
> > > +++ b/recipes-extended/shadow/files/pam.d/login
> > > @@ -66,7 +66,7 @@ session    required   pam_limits.so
> > >   # Prints the last login info upon succesful login
> > >   # (Replaces the `LASTLOG_ENAB' option from login.defs)
> > > -session    optional   pam_lastlog.so
> > > +#session    optional   pam_lastlog.so
> > >   # Prints the motd upon succesful login
> > >   # (Replaces the `MOTD_FILE' option in login.defs)
> > > -- 
> > > 2.25.1
> > > 

-- 
-Joe MacDonald.
:wq

