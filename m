Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93ED6FED3F2
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 17:04:14 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27358.1777050244064090868
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 10:04:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HrkCx6xn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d572f7437so5330851f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777050242; x=1777655042; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xU0rIaPZGErw9F7pBJ8ww++leUpGhD91izNLwR//yME=;
        b=HrkCx6xnfZ6POevMaMau035XQxRoz41D4wUyimW3OuvQf07Jibg0OU1nSKiTtPL/pn
         VeR+4hvtNt5xjXlo8PvpcSWaZQtWsrAhFk5PoAFUgW07qhyb1L9BVWCTj/9Nnba476M4
         XXmIKFomy7Q8Yla66tSUfEmGj+4Cv2t+niY04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050242; x=1777655042;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xU0rIaPZGErw9F7pBJ8ww++leUpGhD91izNLwR//yME=;
        b=QjZ9w9efnkbHAl81ANnttJ1hFNTk2Np3fGIn4Y3fJfdN550y/H9USGzhWqbemloFCl
         JebtQ/NX7cyWk1qgbHXTpo90SQx5JDEsMcXC9uFc9WVGAqgx3BQn+7P3rSv+eV2UbOB4
         LiHDQ/TiejpreJPMvrIfb6tH7/iEUDMUsqjg9zRB8Unl+B9WEUYWkjAi8misVOIglVKo
         817/WAWTiqtQ0s9U2q2e/xoJlDtT/q8jT67/b4XmalgghXJHOIJDopg9H2Dnb1WmpH99
         sQTuobeNEtdDbID+82Wku/nYpxRFmstUyf8Owz4QmvIfz3wkZvIU16n2m8UziambpuqJ
         WY7Q==
X-Gm-Message-State: AOJu0Yy0J0CEpUCGKBqJWLCxypME2WObEt5bOJQumxAuU6Aiud1vHHYy
	wDL2y202Z+t0mUfqx6jTBDupGl/jr7k/4zYDi75GVdOPXYezbzvoKyGFnYC92cPhIcfStvFGCUr
	rFobmTtI=
X-Gm-Gg: AeBDieugC/MWhDey++MdLbZ1NGrCPSND47wTvDQwotfyWppb+clSZo1zBMEZt5vgX5L
	pPcK9eEEwa/2mZTWXkGjABYXVYvu4Q8bXgXy6QAq9QgwSd5a/v+KgbD3eVvlUea1YjPhL6nDaW1
	mjzxiLD4l8kF8azuknKIyDZUgwEkCMa9vUC1wfuVN39eqgI091FbiBoxKfNlMz+ScDRwYp83cFT
	z1D3ycsbJhVlLUBivoy7LbbKN+6OejeFvKh5HwBWkkH7ThFPSoSKvyqr7JtTzIRv01gnuXkxf0q
	fwQVv0NT5u7ZdYPeGD2Ju8gxbBcu/jRoGAj4qEVHzLOHOO6UdznyIvc7yejoZFt22xogu30O7EZ
	Ikgh7JPpAYPk7aNRlLHPhpqAvEvnC38fkwd75A4Bxkazz2eR7xlmt7Hpv+NveYsYLsQvYu9KOhl
	r0QdaY9Tv78UC0oGQpZN+IVqKHBv8O2oaOgkx6pjI+BgxXfTCiaRF63JFwJxBQxO0kGWRYLyifg
	M/Cxi5oSDNZSdzbsEMvw4uuOdg=
X-Received: by 2002:a05:600c:8587:b0:488:a797:f0ac with SMTP id 5b1f17b1804b1-488fb7880bdmr339705315e9.28.1777050241635;
        Fri, 24 Apr 2026 10:04:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6633:2b7d:813b:8534? ([2001:8b0:aba:5f3c:6633:2b7d:813b:8534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm628433395e9.10.2026.04.24.10.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:04:01 -0700 (PDT)
Message-ID: <de8caefe20ca7301a8f104e8d9751ffd8ca50e38.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [auh][PATCH 2/3] modules/steps.py: refactor
 compile() to use parallel per-machine builds
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Qi.Chen@windriver.com
Cc: randy.macleod@windriver.com
Date: Fri, 24 Apr 2026 18:04:00 +0100
In-Reply-To: <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
References: <20260414053202.3869771-1-Qi.Chen@windriver.com>
	 <20260414053202.3869771-2-Qi.Chen@windriver.com>
	 <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 17:04:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3806

On Fri, 2026-04-24 at 16:04 +0200, Alexander Kanavin via lists.yoctoproject=
.org wrote:
> I understand the idea, but unfortunately I do not think we can put
> this (and the following patch) on the Yocto autobuilder. The
> expectation for the builder jobs is that they are expected to run
> only
> one Yocto build at a time, and the autobuilder will:
>=20
> - configure each builder to use carefully adjusted limited resources
> for that one build (via the fragment in oe-core)
> - start several builders on each worker machine to parallelize large
> builds (e.g. a-full), but no more than a certain upper limit, and
> queue them if the limit is reached on all workers
>=20
> This patch breaks that expectation, as auh build is not using an
> exclusive worker for itself, and shares workers with other builds.
>=20
> It also isn't clear how this patch was tested and benchmarked. Did
> you
> run a substantial upgrade job with it? Did you see a significant
> speedup?

Whilst we do need to be mindful of this, I suspect there is some room
to parallelise a bit. How much parallelism is this expected to have?
Some existing jobs like oe-selftest do run a lot in parallel already so
this could be not that much different to that...

Cheers,

Richard

