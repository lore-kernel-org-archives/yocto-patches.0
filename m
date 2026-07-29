Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1060BC54F51
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 14:55:34 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13315.1785336924388802575
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 29 Jul 2026 07:55:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SvhF7hR3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956242332dso9185005e9.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785336922; x=1785941722; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WjC8uJe3cnHYXyhIzTYbhEwpKHQgSYr432dFYAQsHgY=;
        b=SvhF7hR3PqhG90uiPqz4VYRWa3xNh6qBG14Yp7+DZXNWWmhYsLPKmJuZr7StdSdE55
         oQPpm5XGPRi8W0tgMa8D+N8IuyyMci2OE2HeEFLRySwxLAizNFcYOR2Th1sAxx8ABjIU
         uAPPYu0agFcQ1cN8daS/Wu2MnwiCdrtXouI+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336922; x=1785941722;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WjC8uJe3cnHYXyhIzTYbhEwpKHQgSYr432dFYAQsHgY=;
        b=ki91YN71meMk9rPynapYjkLHzYrRE47b+pg4CG41bJJUs06OgZUDOSPySbnbGT/nvr
         vbPTpG4POpmAFOYPI+DOzISA8HfPChVezWiv8QPVpm/GbeFm27otxc6HdJs/sBEbDKp/
         Le6i6Z/K5EIWnEOp8w+i6p5PqaIPUl6k3MNNT0yPU32xqDFjShNPgmqxW64z1rtdgPa2
         vIliu5RlFOBFQylTHLpPPeNXZpX8QRWcPD+9+LgUjypv1CFsgxnshcffPCrm11I5Ps2/
         Yuyvyyen+pwOQeUD2nPhNeUikmMEJqM9spGu9/nVFQnCd5FVHg2TOWihwE6IaqvmxNG5
         YdJw==
X-Gm-Message-State: AOJu0YzcJCgIy/OqIvXDMcdMEgPmKR/FiL4XHq/IVH+yZbKfKVXenpsB
	GL9kG9SDxorNyQtNIRluXhW3zb3sshUPf6/W5UUon6NgrzKK2g3Vlcc/2GFzDwCn1reNgszEmKA
	Xz8PmFHM=
X-Gm-Gg: AR+sD12J1sZUikfYJ9T3Sm3BG/lAHfYlr18KRFw3dWHRYJc3pCNdBIX6CkgGqlwfUe7
	vSCZHyo+Z38BafWKoY4JlkZAYVsQqI9NBzE6KYGrxCNNzN/k3+6HSZHVF4nr9d+SrXUZ1r561BL
	SFiSFXsrKSG13hfRQrN18nS8QuuMQKMwFoODIl6sVp/huDZwqc4JoowXsiRXAI0msGje4LRfRC9
	+2nK+RMgcuxr5U4T0Gnx9Sot2J3ZWoR1w4dWGTc+U/mCtzFlv3d5vjuk/as7DXmKRLslhtJEjhj
	G7Z/wC7IS74zc9WFado0N7cBtXrYv9Uv5oFGOa9PzLd87+3GAhee38NwwvLflb6HsAzTV3CQu2H
	/2LiC55yizAVcua2FeUTXJp7/A6kxciiVGWoEqYLaFoTqUQtZRXm817B5CQ/fsYqbrI/o3zOXAu
	EYkkfjz3J2rOeU9e3c+J9xRB+F6gAZkXA7/BKJay0eEJIi0uWxZVzGOE4xkcbq3s9YkNI8JMfLQ
	wUSjOOkeNxk6/j5hYJ0kwe1UkdfVs3bXBtlgm76HUW+aFVyXtFbgA==
X-Received: by 2002:a05:600c:e549:10b0:495:745e:7430 with SMTP id 5b1f17b1804b1-496c659066cmr54402765e9.20.1785336922510;
        Wed, 29 Jul 2026 07:55:22 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3647:86f2:68ea:efc7? ([2001:8b0:aba:5f3c:3647:86f2:68ea:efc7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d70144sm63819085e9.2.2026.07.29.07.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:55:21 -0700 (PDT)
Message-ID: <15f732196c35cafae077a46b2ad4b88ae6191630.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH 0/3] closefrom/close_range:
 protect every pseudo fd, then drop one
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Babanpreet Singh
	 <bbnpreetsingh@gmail.com>
Cc: Mark Hatle <mark.hatle@amd.com>, Mark Hatle
 <mark.hatle@kernel.crashing.org>,  Paul Barker <paul@pbarker.dev>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert	
 <mail@vincent-haupert.de>
Date: Wed, 29 Jul 2026 15:55:20 +0100
In-Reply-To: <18C6B495C3317260.3067440@lists.yoctoproject.org>
References: 
	<d7ac8b50020fb439b47c512be36b674cccdc0b86.camel@linuxfoundation.org>
			 <20260729050807.7-1-bbnpreetsingh@gmail.com>
		 <18C6AE58128B91FB.3067440@lists.yoctoproject.org>
	 <18C6B495C3317260.3067440@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 29 Jul 2026 14:55:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4567

On Wed, 2026-07-29 at 09:14 +0100, Richard Purdie via lists.yoctoproject.or=
g wrote:
> On Wed, 2026-07-29 at 07:19 +0100, Richard Purdie via
> lists.yoctoproject.org wrote:
> > On Wed, 2026-07-29 at 05:08 +0000, Babanpreet Singh wrote:
> > > On Tue, 2026-07-28 at 16:59 +0100, Richard Purdie wrote:
> > > > I think the missing piece is this:
> > > >=20
> > > > - if (op !=3D OP_CHROOT && op !=3D OP_CHDIR && op !=3D OP_CLOSE && =
op
> > > > !=3D OP_CLOSEFROM && op !=3D OP_DUP
> > > > + if (op !=3D OP_CHROOT && op !=3D OP_CHDIR && op !=3D OP_CLOSE && =
op
> > > > !=3D OP_CLOSEFROM && op !=3D OP_CLOSE_RANGE && op !=3D OP_DUP
> > >=20
> > > Sorry for the breakage, and thanks for chasing it down.
> > >=20
> > > I can reproduce it both ways on master-next at 6d65d74, with a
> > > probe that
> > > opens an fd and calls close_range(fd, ~0U, 0):
> > >=20
> > > =C2=A0 no PSEUDO_*_PATHS set=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 OK
> > > =C2=A0 PSEUDO_IGNORE_PATHS covering the fd's path=C2=A0=C2=A0 SIGSEGV
> > > =C2=A0 PSEUDO_INCLUDE_PATHS set, path not in it=C2=A0=C2=A0=C2=A0=C2=
=A0 SIGSEGV
> > > =C2=A0 same env, closefrom() instead=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK
> > > =C2=A0 all of the above, plus your line=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OK
> > >=20
> > > For OP_CLOSE_RANGE the path comes from fd_path(lowfd), the ignore
> > > check
> > > hits it, and pseudo_client_op() returns early with result still 0,
> > > which
> > > close_range.c then dereferences.
> > >=20
> > > Two things before I respin. Do you want the three fd-protect
> > > patches
> > > resent, or will you carry the master-next commits since you have
> > > already
> > > resolved the conflicts? And the ignore-path line: fold it into the
> > > close_range patch with a Suggested-by, or keep it as your own
> > > commit ahead
> > > of it? Either works for me.
> >=20
> > You can fold the above piece in with a suggested by, it doesn't make
> > sense in a commit on its own. I can take the other fd-protect patches
> > if you're ok with that change, I need to update the commit messages.
> >=20
> > Whilst most builds are testing cleanly, we are seeing these two
> > failures:
> >=20
> > https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/4403
> > https://autobuilder.yoctoproject.org/valkyrie/#/builders/23/builds/4466
> >=20
> > which look like a pseudo problem, and that is with the current pseudo
> > master-next. I think there is still some issue remaining somewhere
> > unfortunately. I'm afraid I don't know what it is.
>=20
> One of those doesn't look to be pseudo, the arm one definitely does
> though. It looks like it may be arch specific.

It took hours but I was able to work out this was a missing __open64_2
wrapper so I've sent a patch for that. That is unrelated to the
close_range patch but somehow implementing that triggers a different
codepath in systemd which then broke. I'll retest things and check
there isn't anything else.

Cheers,

Richard

