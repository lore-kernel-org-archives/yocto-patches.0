Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4757CD6E6E
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 19:38:06 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3563.1780601876975143757
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 12:37:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=sFeDqJFY;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8cce22e029cso27516926d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780601876; x=1781206676; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gpOoVIRe8ptCOsCXxnY+gxWlbffdP+h7ODZKBhGmAs4=;
        b=sFeDqJFYlxJ438NyfPi4m2POVRQaWNW+jsbuman+SCpSAIfFi27HDs+jVmchGzbve6
         J0hkeXRDfW3ki23MywVixd9qP8DZUwBQZZ+ZB2SNfxTLFiZ7QxnZRwGrpASrsEjvndqu
         MeRPATu9SxAX5bB2skggnmT6nwyPihRQPrB1FSDTldLOevdXgBcRBA+eEm3GRJGIIh69
         kifnMYH3JpgtLa1BIrnDZFN4KJTwjzimnAZ9AKU5zwwiOTnDDsbf+o3kodtBPAiLSI2S
         5cpRXuMMiST0tKwhJYHndgQ9hUJCIeohG6SIu76kdGQKoPG/AUgfbBCJu3AS/M7uPWzz
         GWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780601876; x=1781206676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpOoVIRe8ptCOsCXxnY+gxWlbffdP+h7ODZKBhGmAs4=;
        b=RVF5fgtHBu0rPV6SWbJQIJBX8/kR6Q8Kp0dSoVR/IInk8DYkc9kTocbeZgzl64f6nA
         11ZsGqq1lIxTnZ9/PvQ4CDiJl1OlfHq730TA9I8DJr6IDW/A2RLQ3RtI1o9BeZTvme+Y
         t7bWJ1wTNh0AuzMArN6Sn2PAYL1h4Ici02IpQrr8HVCsMhOW31VfijwGYvOfYlP819MG
         w8q5EdJGbXWy54agSrfrYIU4alB7NCje8LM+LhKUroGq29WAYH2EOT0AhdlV1I4gWhdS
         Qp0sHSje5iIUNyHWkt9xKJdX84kFewgoPS65XeV6+T1sTJfDUI+hH2QShshSw/AMtyNx
         0uEg==
X-Forwarded-Encrypted: i=1; AFNElJ9URLtHOihOSwL+Ir4rgFee4BfOgdePE8rZD9yYoOtanOOacw7nkw8Nr3E7ZA1FYYQ17OGEXcg9zYwpfgHk@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yw+6oX8A+sPTdk/+S6QlgnWP95mqo4qcQ+oQOUgkJzKOd8wPPgN
	YUDX5upfdYHn6ZsOWPxnUpWe1ad6YALN1eQiS3+5emKSCyiRxWUnmZqDjiquwA==
X-Gm-Gg: Acq92OGizETw7xaegZ/qidhx9NQO0FM9fS9NFulTRh9eUqnbY7C/pt+GxJBM7tf+047
	JIH5+Un9eR+0uyrg0wfM5IN6TbVrQBcv7NV6fI+4Mvj9ivDuLqSnP7S49KFnpq9u9d29rLA1Z/8
	raLJSWwiSLFx3xWIMx1cO1JgNNA+bYvJA14f6VX6oM41cH1r79ivc5olttWjP7+8llFKHAQW4Wu
	k3r16XGgAvv3NCxuA+/oE2ZChIqI2zeqiXWphSTbHcs1r0ten3eAiJjHLt8HkTXz5hNUpfCYwFg
	4Sj2jt2A5yTgycFdrnG41p8l9I+2CF/Dl/gCNNKifZqAtMVeL9a8nolbNZrk4S5Soy7HPVJ7NLE
	zeKM/fPVNWGU2UC3/m1LHMtq1SPBx3e7tMXsy/7X+cALquswrx8FC6dwiq4qcTR7huIOc7lqNeN
	VYJQvloMD45cDUjKI5lwdJdr8j8eF6Va9efnG061PHsEf3ocDh1oDvggGfBDiKDPuU5IAR3FrE7
	Y9Adc9jePxg5/A=
X-Received: by 2002:a05:6214:c66:b0:8ca:1e71:c5fb with SMTP id 6a1803df08f44-8cee7551958mr193846d6.7.1780601875850;
        Thu, 04 Jun 2026 12:37:55 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fe25sm61800546d6.3.2026.06.04.12.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:37:54 -0700 (PDT)
Date: Thu, 4 Jun 2026 15:37:52 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+yocto@0leil.net>,
	yocto-patches@lists.yoctoproject.org
Subject: Re: [PATCH wic] add basic b4 config file
Message-ID: <aiHUEFS-ucG_p3kV@localhost.localdomain>
References: <20260424-b4-v1-1-04ede4cc261f@cherry.de>
 <6976ce0c-ce97-4adf-bb6c-c75c89a7e674@cherry.de>
 <ahZz7v5I08_FI6Eu@localhost.localdomain>
 <d288802d-3752-4da6-86b2-fd55dd0a6a5e@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d288802d-3752-4da6-86b2-fd55dd0a6a5e@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 19:38:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4141

On Thu 2026-05-28 @ 12:15:36 PM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 5/27/26 6:32 AM, Trevor Woerner wrote:
> > On Fri 2026-04-24 @ 12:26:59 PM, Quentin Schulz wrote:
> > > OK so this is very confusing. The default branch in cgit is
> > > origin/feature/no-create and I got my info from the README.md there, which
> > > differs from the README.md from instructions in the README.md in the master
> > > branch where it isn't requested to Cc Trevor.
> > 
> > I asked Michael Halstead to take a look and change it. We think it's
> > fixed now.
> > 
> 
> I think too, thanks!
> 
> > > 
> > > On 4/24/26 12:18 PM, Quentin Schulz wrote:
> > > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > > 
> > > > b4[1] is a very nice tool for mail-based contribution. A config[2] file
> > > > exists to set up a few defaults. We can use it to set the To recipients
> > > > to always add, in our case the mailing list, and the Cc recipients, in
> > > > our case, Trevor's address.
> > > > 
> > > > Additionally, automatically provide a default prefix so that one doesn't
> > > > need to not forget to run `b4 prep --set-prefixes wic` for each series.
> > > > 
> > > > [1] https://pypi.org/project/b4/
> > > > [2] https://b4.docs.kernel.org/en/latest/config.html
> > > > 
> > > > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > > ---
> > > >    .b4-config | 4 ++++
> > > >    1 file changed, 4 insertions(+)
> > 
> 
> Your gmail address is in the Cc recipients, which doesn't match what's been
> requested in the README.md in the master branch (only the ML in To
> recipients). Should we patch the README.md to align with .b4-config or the
> opposite?

Might as well update the README to add it.

Thanks!

