Return-Path: <francesco@dolcini.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F28C77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 08:29:05 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by mx.groups.io with SMTP id smtpd.web11.8452.1751012943841468577
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 01:29:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@dolcini.it header.s=default header.b=mdVmcV+T;
 spf=pass (domain: dolcini.it, ip: 217.194.8.81, mailfrom: francesco@dolcini.it)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6FEA71F9B1;
	Fri, 27 Jun 2025 10:29:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1751012941;
	bh=63OyEPjcXMPT2pnoPFXFamOWnPjzJDTDRpTAbcTVrt4=;
	h=Received:From:To:Subject;
	b=mdVmcV+Tx7HMrCbDqsrT6wcp1eUxsrzWhD9tKkuWElBusvE261aN2t2lZf2BM2KHn
	 GtocvZF5gEliZnN6pybn/JprwgzRijkAimyL+1g4uzFm4BmCTCF3JvZp4Jbkh3RVtR
	 bFTeFD8LH6+62T2oDNeDEABBRC4WChZVg/yaAAPh5REexvoq87gE2ss53UvaucOolX
	 s4sS8ADgarDe9kwXL3WKu+YwdFz5Jr1mc87dzEhM1EluJq/tsWT4NW28HzkxRJp+CM
	 arebp+MIjJRVTu4dOKUUDFjhw4Aim6ii5m3M/3jZcZoiIJSMY/1DDPN8vWGSUsaJ+X
	 zmA6EUBUHUCUw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 284B57F825; Fri, 27 Jun 2025 10:29:01 +0200 (CEST)
Date: Fri, 27 Jun 2025 10:29:01 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	yocto-patches@lists.yoctoproject.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hiago De Franco <hiagofranco@gmail.com>,
	Marta Rybczynska <rybczynska@gmail.com>,
	Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: [meta-security][PATCH] layer.conf: Update to whinlatter release
 series
Message-ID: <aF5WTUvd638TC9ME@gaggiata.pivistrello.it>
References: <20250622173729.13803-1-hiagofranco@gmail.com>
 <20250627074019.GA5745@francesco-nb>
 <066e1255466f5be3f01581e9b6498abc0450b110.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066e1255466f5be3f01581e9b6498abc0450b110.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 08:29:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1707

Hello Richard,

On Fri, Jun 27, 2025 at 09:09:35AM +0100, Richard Purdie wrote:
> On Fri, 2025-06-27 at 09:40 +0200, Francesco Dolcini wrote:
> > Hello Marta, Richard, and all
> > 
> > On Sun, Jun 22, 2025 at 02:37:29PM -0300, Hiago De Franco wrote:
> > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > 
> > > Update to the new Yocto release series.
> > 
> > I understand we are on a pivotal moment with meta-security maintainer
> > discussion [1].
> > 
> > And currently we have our whole integration and testing blocked
> > because
> > there are build issue on meta-security layer master branch.
> > 
> > Do anybody see a short term solution, to solve the bare minimum build
> > issues?
> 
> There are two sides to this. On the one hand, you'd like the issue
> resolved ASAP as it sounds like it is causing you a problem. Whether
> such a change like this should cause you such a problem and whether you
> can in fact work around it is a discussion for another time.
> 
> The trouble is as soon as master gets fixed, people will go back to
> focusing elsewhere. Many are already finding ways to ignore it until
> someone else fixes it. There is a much bigger/deeper issue here.
> 
> Since you have a key dependency on the layer, I did have a look at the
> commit logs but I don't see any patches from you, which is interesting.

Hiago is in my team, working for my company, Max the same (both in Cc here).
We send fixes regularly as we see stuff breaking (oe-core, meta-oe, ...).
You'll find commits from my team just grepping for the toradex.com email
address in meta-security, oe-core, meta-oe and so on.

I am genuinely trying to help, because while we can send patches to fix issues,
we need someone to apply those. And Marta already volunteered, and that's great
(thanks Marta!).

The desire to have it building, as the bare minimum, is because once we have
it our CI will just do its job and we can send new patches as issues as seen.

Francesco


