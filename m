Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671A5C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 12:08:33 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
 by mx.groups.io with SMTP id smtpd.web11.84452.1718712507880659829
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 05:08:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MdiiHA39;
 spf=pass (domain: gmail.com, ip: 209.85.160.170, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4421c014b95so31303491cf.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718712506; x=1719317306; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0egok6CU+9MaqOoaHpEL4FgXEVRdLg9IzTp470ijPs=;
        b=MdiiHA39Nk17zDXtDgovZVwsJf8GW1p3RwVQmTJWloM4eJ2QewrdfNWwjTHuTmbn0b
         q7n+/ivwZavpIhoOJJ0Jtw//0E3OalM73OPa6OQTd4CpnEV1xwHp+aDSMH2YF3gSw0/t
         4WiWph3V3NcwKynfjFo4EuNBlpCy6rK1+DcqVAUykMg6c6M29BJHwXVBKpxiO+/EiiDv
         yEiPiJIscp+U6ufGkNAIVUKt00tULMBjCCt8Sh959bhbY0af9XpRiTiEWcIenpNuhK8a
         zlfTu7xKU5fIBdcbwW3jjVvVhg2z5IyzepQ3LPsRpq4sMmjHckB/ZbpbUfZSVqAr4zc6
         d95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718712506; x=1719317306;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0egok6CU+9MaqOoaHpEL4FgXEVRdLg9IzTp470ijPs=;
        b=sM8h03+AGZxErXAHetXyPqrdfNY2spdnSBk9+jCqLPbcOppV1aQNYNitmMYsZVjDgM
         qeMniP99hbFtdV7Ous3ip27luuE/RVX9CIA0xkDPHK+AWCh/iGov1pPA9hF6w3vj21rI
         w3Apm7PbllBc+CcaEIdTluC7y41rcXwxRlMjfaDchWDtJ0Cdp3+pSd/ac20piAttH5OZ
         knVOHIA/L42/w49Oxz8mqGEFhlKDYScN6fdWyhCRv25YpVw0KbvGkVOgW7cvLmJDns0Q
         7SI7DEAmeD0W9DIsRdRiCMvuqMJ+rpv7kTVM4O0f5y6YzwNL4MCLP5v58xgeP7+gDBeo
         3VjA==
X-Gm-Message-State: AOJu0YzTxHN6uFst4Oh+cNh0rqXdNWNaFV4C9EJafD/WYRVCNtBVZK0N
	daG4kAz63IsgysHOLNPKxWuguLYPXMVhQMQdK3cT7EES6Lw+rwpnw+w85g==
X-Google-Smtp-Source: AGHT+IFDnhDH+/Qdk8s+1kduoSgd4ISwj6gX4Zgg0bsO6XM+C/QyBS8dMZk+V7/9oo98S/dyHjJONg==
X-Received: by 2002:a05:6214:21ca:b0:6ad:753d:45cb with SMTP id 6a1803df08f44-6b2e23840femr40493896d6.20.1718712505514;
        Tue, 18 Jun 2024 05:08:25 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5c4663fsm65594896d6.66.2024.06.18.05.08.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 05:08:24 -0700 (PDT)
Date: Tue, 18 Jun 2024 08:08:22 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next: use
 AUTOREV
Message-ID: <20240618120822.GA40144@localhost>
References: <20240617230735.13593-1-twoerner@gmail.com>
 <fb7d421b-9db5-461c-b89d-05cb9c5016ee@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fb7d421b-9db5-461c-b89d-05cb9c5016ee@cherry.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 12:08:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/338

On Tue 2024-06-18 @ 12:04:48 PM, Quentin Schulz via lists.yoctoproject.org wrote:
> Hi Trevor,
> 
> On 6/18/24 1:07 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> > Already the SRCREV that was used for -next has been rebased out of existence.
> 
> Mmmm, no. It's still there, just not in the master branch.
> 
> > Also that tag that was originally proposed no longer exists. With a repository
> 
> It still exists. https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20240611

Yesterday at noon my time I cloned the linux-next repository on a machine I
had never done this build on and that tag and commit ID were not there, and
this is still true:

	$ git tag
	...
	next-20230310
	next-20230314
	next-20230315
	next-20230316
	next-20230317
	next-20230829
	next-20240613
	v2.6.11
	v2.6.11-tree
	v2.6.12
	v2.6.12-rc2
	...

	$ git show a957267fa7e9159d3d2ee1421359ebf228570c68
	fatal: bad object a957267fa7e9159d3d2ee1421359ebf228570c68

	$ git pull
	...

	$ git tag
	...
	next-20230829
	next-20240613
	next-20240617
	v2.6.11
	v2.6.11-tree
	v2.6.12
	v2.6.12-rc2
	...

	$ git show a957267fa7e9159d3d2ee1421359ebf228570c68
	fatal: bad object a957267fa7e9159d3d2ee1421359ebf228570c68

> > that is rebased so regularly, the only thing we can safely use to hope for
> > valid builds that don't need to be tweaked every few days is AUTOREV.
> > 
> 
> Or... use ;tag=next-20240611 in the git fetcher and force people to use the
> network for radxa-zero-e boards.
> 
> I personally would vote for using the tag instead of AUTOREV. Kernel
> maintainers rarely (have they ever done it?) move tags around so that should
> be fine. Whereas using AUTOREV on linux-next is basically hoping that
> nothing breaks from a development branch, maybe too much to ask for right
> now?

When I click on the commit of the link you provided earlier it says: "Notice:
this object is not reachable from any branch". If the tag is not accessible
from any branch then I can't specify a branch to the fetcher. If I don't
specify the branch to the fetcher then I get flooded with "...you didn't
specify a branch, and we're going to make this mandatory soon..." messages,
flooded!

I also got an email from someone yesterday who had tried the radxa-zero-3w
build and it failed for them. When I do the builds on my machine that I've
been using for development, the build succeeds (because the repository
predates the assumed rebasing). If I then go to the ${DL_DIR}/git2/ directory
and delete the linux-next repository, then retry the build, it fails.

When I try the build on a machine that has never done this build, it fails.

I started my change yesterday by using the "tag=next-20240611" addition to the
fetcher and was surprised when the build failed on a different build machine.

I think AUTOREV is that safest bet here.

