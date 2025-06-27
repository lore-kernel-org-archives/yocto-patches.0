Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A09C7EE31
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 07:59:35 +0000 (UTC)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by mx.groups.io with SMTP id smtpd.web10.8130.1751010028123966331
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 00:40:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@dolcini.it header.s=default header.b=iFKuh+/c;
 spf=pass (domain: dolcini.it, ip: 217.194.8.81, mailfrom: francesco@dolcini.it)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id D1C7D233DF;
	Fri, 27 Jun 2025 09:40:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1751010025;
	bh=S+SD7laa+Zc5JhGyCHZYoOFwBmeOo774Bn50ruycJqw=; h=From:To:Subject;
	b=iFKuh+/cfdUlVX2Flha5URCmcgDQ1TysnGkSi4CW3KntJplmceFKZJrs6tXjKVSYi
	 fovIOWjYOorCV5+FiSxsEG2BTUII7lWPvY5L5wKFZ1kCpsTkHVcQeTPK0fqmix71MP
	 4USmRqYmkpMUVY14TP3OSLqRsg0Gj24BzMRry+xj0BaBDqzm2u24OuFddlzSFf2j/Q
	 xI7aSasMzj69uyAgCsZg0B3S+Dw7Ym9n2+oIVUoWUE0axmZTRn/5YSjy4H3pGNX71a
	 Idje3BAZ8opxZu9pWkVZQYmAgyjRwr7Lir8MeVBYscXZd0h4lg4so6Vgh51pI65p1H
	 RwXEHawPFEZ5A==
Date: Fri, 27 Jun 2025 09:40:19 +0200
From: "Francesco Dolcini" <francesco@dolcini.it>
To: yocto-patches@lists.yoctoproject.org,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hiago De Franco <hiagofranco@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Marta Rybczynska <rybczynska@gmail.com>,
	Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: [meta-security][PATCH] layer.conf: Update to whinlatter release series
Message-ID: <20250627074019.GA5745@francesco-nb>
References: <20250622173729.13803-1-hiagofranco@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250622173729.13803-1-hiagofranco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 07:59:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1705

Hello Marta, Richard, and all

On Sun, Jun 22, 2025 at 02:37:29PM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
> 
> Update to the new Yocto release series.

I understand we are on a pivotal moment with meta-security maintainer
discussion [1].

And currently we have our whole integration and testing blocked because
there are build issue on meta-security layer master branch.

Do anybody see a short term solution, to solve the bare minimum build
issues?

Francesco

[1] https://lore.kernel.org/all/20250623202701.12590-1-akuster808@gmail.com/

