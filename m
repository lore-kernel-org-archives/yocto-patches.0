Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2E2C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 15:48:33 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14691.1785253710109353677
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 08:48:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZjFb8VpA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f7872abb6so6837f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785253708; x=1785858508; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PAWa02177S7+bcyeXvE+uNuORBb9x1OKqJkr3HPFTlI=;
        b=ZjFb8VpA1eu++s33mHk+sL5akRGu9jdPBia/BslVTWmaFSpV1jmM7yDcf82QEPleR4
         +AWyIrCXhgwdTOHUjJQ0E4ZoxROGakUpxq3GX0bZt0q6DLL4su8pyCWGXqjrV+9SE3FQ
         oyD+ds1VPSCbvjTGe7yoAxu1VhJQHIQ1MbTAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253708; x=1785858508;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAWa02177S7+bcyeXvE+uNuORBb9x1OKqJkr3HPFTlI=;
        b=NV/gAVaWdxDbvzRL0LA5z2KRlK1Aogivaewm2x86IlSXxUYrZa8buHCFx9WWMS1BbR
         1sRANk2eXcYvqyQ7S0tT4J89UpLPshAXqSCvvEabNkPnXC1VH8QoRI7g8SaVIUxvs6lp
         9dH0tjiu15vqEc+YTt83Se6M+D4HFziCSwn3lNBE7ne7TpT66Jt97gSMX7GJHWICRrzy
         pluG/McEMiuMw+k4NhER5SSdWDTgcM8VOuN02Tj37GqWhBxu6GuUNJgJcqtkyZ9DgXr/
         wcs0jSO93AyRHpCpgAWOx3OkZX4LtfjAAgGbzJ30aneUrfswn9V0oQ6zhoQcAwX9UJjJ
         B34w==
X-Gm-Message-State: AOJu0YwQKzUOA43fc/llJFFaYg/QXe4juSIobc2fxg8wEnUk7EqcjDTx
	7wUG6PTmpqJZOLczwGGMlcbMb7mcZzccmZfC0AxTLo+ZTOBiOsxOeVyn9B/pN1iGImbFdUYhTtT
	Qxmt1ihk=
X-Gm-Gg: AR+sD11RLMKwuzlQUpLNPfh7wo26SjP1L/R8mxCu4mqk9x7rfNnR1UuvA6U58oJG11B
	lbxnW0DHPZKc959mMgYroWizkwHc+qveph1hfblU65YTl93zx7MNMGgyRX/X+QIDBAGjFYCWz7A
	vb2BcImLkXw5NA5iU39avKy2zSc96+wSrIMB2SvLDcMWa/C2UTESmIN6s69SAt9k/ax5gFovRLD
	GboAjabb7sWFCJo3BuMekknvhAx2f7jFTBik2qfk24ADlkxoZiWGwAQqH1+hRhsuGa5UEiAsgSb
	97ACdcL8aujF2RZVkneXMXmsXW21aIOhtWb3V1mJtNJcdC1AYUuKmq1rho7+copYpABne+9ewmR
	GLBhS2Voemx9dbENQvydKLJFgdLmC1FEm/g0vtmkMizATB3ficOukBYWepRqb7Qq8wiygzKtp5T
	H5znHe9V2imCCMWhGdBo+vTyrRC2T8ZvL4E9NEQ9jXHTRJ3qJOkNJ0UcJpTd9OIoTI
X-Received: by 2002:a05:6000:25c2:b0:47f:9256:4d74 with SMTP id ffacd0b85a97d-47fb1ecd5c4mr3662480f8f.31.1785253708277;
        Tue, 28 Jul 2026 08:48:28 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1? ([2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a94sm118461f8f.8.2026.07.28.08.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:48:27 -0700 (PDT)
Message-ID: <0d639037bc3b1306cfc2e971cb0a9bfbac7761c0.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH 0/3] closefrom/close_range:
 protect every pseudo fd, then drop one
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Babanpreet Singh
	 <bbnpreetsingh@gmail.com>
Cc: Mark Hatle <mark.hatle@amd.com>, Mark Hatle
 <mark.hatle@kernel.crashing.org>,  Paul Barker <paul@pbarker.dev>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert	
 <mail@vincent-haupert.de>
Date: Tue, 28 Jul 2026 16:48:26 +0100
In-Reply-To: <18C6660077364169.3010641@lists.yoctoproject.org>
References: <20260718043750.7-1-bbnpreetsingh@gmail.com>
		 <20260728050815.7-1-bbnpreetsingh@gmail.com>
	 <18C6660077364169.3010641@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 15:48:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4559

On Tue, 2026-07-28 at 09:14 +0100, Richard Purdie via
lists.yoctoproject.org wrote:
> Hi Baban,
>=20
> On Tue, 2026-07-28 at 05:08 +0000, Babanpreet Singh wrote:
> > A gentle ping on this series and the close_range v2 it stacks on
> > (which Richard okayed on-list on 16 Jul).
> >=20
> > I noticed pseudo master has moved since (now ca47829, with the
> > memory-handling and openat2 changes). I've checked that both series
> > still apply cleanly on top of current master, so no rebase is
> > needed.
> > Happy to rebase and resend anyway if that's more convenient.
>=20
> Sorry, we haven't forgotten about this, we even did discuss it
> briefly
> yesterday! Mark has struggled for time and I've been juggling a few
> other issues.
>=20
> There were a few fixes ahead of yours in the queue, I have those
> merged
> as you mentioned. We then have yours and the logging fixes along with
> some tests Mark worked on which are next.
>=20
> I've pushed your changes onto master-next where there were some minor
> conflicts with other changes. I'll run some wider tests on the
> resulting branch.

Further testing showed the problems came back so I think I messed up
the testing somewhere along the way, sorry :/. I'm pretty sure the
close_range() implementation is the point things break so there must be
some subtle issue in that code...

I'd suggest we reorder the patches and get the skip fds and drop the
prefix fd patches merged/queued, then come back to how to get
close_range working. I still thing one common op codepath for both
cases makes the most sense.

Cheers,

Richard


