Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24620F53D83
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 17:58:10 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.57215.1773683886366801065
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 10:58:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EgdSzq5f;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso40935875e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773683885; x=1774288685; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hylxfi95qKIoTUw0iZBvAr96aaKMjWUmoaF83tdAYLs=;
        b=EgdSzq5f68ZoblUZbiiwrMZx0Qtmlw5msv9q5gpywhJ5rG6JxOpOsaTehdQ94zYA1d
         s876eOaNda/DEOqeBhwPVOnPcymMlxh5xxctpBKDbUlsps5yL9+PWD5GLbtBLbokRjHR
         xx19EFoofhqLkHSGQPBlCYdmrmnr/mmmwZTnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683885; x=1774288685;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hylxfi95qKIoTUw0iZBvAr96aaKMjWUmoaF83tdAYLs=;
        b=FEso6uQGL8vw5M60cZWAeL5Ojo9MxuyfdTudf5E9tVKYLcGJ2ae8tVo1/AF/MgPuHu
         k+e5aeNH0P3C1C6e/b5ZZT4uUIgWI7nIyWtADjPaBo7q/v9DSW3s8u+CJymsIbEK92NB
         vR2Hk7kgPhtnvd39SXBp9zyCqZhO3r6ODxrUrbZNQTx7wNo3THpKKixBD251hsaFtNkr
         Q2qAQJZ20zW4bWYYkt10dVpKKqxvjS2oXB6gPrhGI40rpTaq/Z1R6nei/Fiaz3qvamdr
         n6zPa2uRPaFR5JcuMMryXup0//PTQIHIrMKuX62bCG9IKliFgzPsF2Yc/ZFADQtARADR
         WyJA==
X-Forwarded-Encrypted: i=1; AJvYcCVqc7ZzmVWqsH7o1opLBSWWL2KEvo9tjzir8bHq2lJYfuIN4tEJTsclIrwLM4vDYamGxfOIitD3X9R9pnf7@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzKOcrB9q8RD3GAF09ifckrIKteAW9tlbe0OIlKMzgmuTopADop
	5CCiNlNATHN3Bzf3ej4C22u4FYyg4kMgK7/Oi5FiMJl5G3mFZyudxvNhsuFKZFBg1TY=
X-Gm-Gg: ATEYQzyBnLNkQvkFOqr4Tn6YF3jRJggaxh80XCGBtbTNM+AKjJy2BKOPloiL1oCxXGs
	B7rpAARrV9BDYfYmW1qwcROi2GGrTwFwJ94LCR2FIVNlqmXmD3DrUo31s5/GKr6I70mht6JrjHG
	pPoiUEMbAu4g1WbrOvKXJARNbuLyjXWUsIMe2sXqgiYkt2lE6CblYpHsDbQdv0GP+KvBPdtjNH9
	S8aAGgf3JwMf6NEbFXjuQ+GJrxTcH2VHq1HrrvRm1oWJ2CR42dPzjWG11zXGA/BwRGO9xfLgCeL
	rR3Gu5Hg+K0y6lavrMSSvmy5BGumFxvQLtFdQuOaxk8erKvyO8vOFZUDwfhKoDArqZHi1I6yy7V
	f4hInvWJW0lVL6qRIrYp+kbSmaYXF1BsRfEWaj11PcFhY3GdmQELMqlL3vHriBarJJHXl0EITSd
	bZjXrzzIX9xMR/GVI/BBJFmEJ4Yx0Q/iaHbTnyK4apBKICpuVFjiSnevU6w54/ETYv5T9OpKQim
	wxtwjNuuLyEyCed3/wYL8ofIA==
X-Received: by 2002:a05:600c:c162:b0:485:5574:8ccc with SMTP id 5b1f17b1804b1-485566ebcabmr227356215e9.13.1773683884663;
        Mon, 16 Mar 2026 10:58:04 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:1225:f5c3:a704:878a? ([2001:8b0:aba:5f3c:1225:f5c3:a704:878a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fad1sm16098545e9.1.2026.03.16.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:58:03 -0700 (PDT)
Message-ID: <e5929265c4fa4b29e6af838976f2a145f5ed19bc.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] Running Large Language Models
 Locally -- Contribute meta-ollama to Yocto
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: hongxu.jia@windriver.com, Michael Halstead
 <mhalstead@linuxfoundation.org>, 	yocto-patches@lists.yoctoproject.org,
 Khem Raj <raj.khem@gmail.com>,  Alexander Kanavin <alex.kanavin@gmail.com>,
 openembedded-architecture	
 <openembedded-architecture@lists.openembedded.org>
Cc: "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>, Robert Yang	
 <liezhi.yang@windriver.com>, Randy MacLeod <Randy.MacLeod@windriver.com>, 
 Mark Asselstine <mark.asselstine@windriver.com>, "Holmberg, Tomas"
 <Tomas.Holmberg@windriver.com>, "Chen, Qi"	 <Qi.Chen@windriver.com>
Date: Mon, 16 Mar 2026 17:58:02 +0000
In-Reply-To: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 17:58:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3475

On Fri, 2026-01-30 at 13:20 +0800, hongxu via lists.openembedded.org wrote:
> ChatGPT[1] has been popular for several years, perhaps you also know=20
> Deepseek[2] which is an open-source language model and run locally.
>=20
> The local runner to run Deepseek is Ollama[3]. It lets you download
> and run large language models (LLMs) on your own machine, without
> relying on cloud-hosted services.
>=20
> That is good for Yocto, so I integrate ollama to Yocto-based Linux
> system, build from source, offline install and deploy.
>=20
> For the convenience of review, show it on my github [4] temporary,
> - The BUILD.md [5] provides the steps to build and run on CPU by
> default, - The BUILD-cuda-x86-64.md [6] provides the steps to build
> and run on NVIDIA GPU =C2=A0=C2=A0 with CUDA for x86-64

I appreciate there was a lot of discussion on this, I'm not going to
try and respond to all the points individually.

The TSC discussed this a few times and is not convinced that either
this or the proposed meta-ai is the right way to proceed with this at
this time.

We are keen not to repeat the past and create a "catch all" layer like
meta-openembedded where it is unclear what is needed/used/tested and in
which combinations. Equally, a focused layer that is target to one
specific use is also not appealing. We're aware that the rate of change
in this space is extremely high and that will further compound the
problem.

We would suggest that people work on their layers outside of
git.yoctoproject.org and that as things get established, it should be
clearer what the best solution is and we'd be in a better position to
make decisions once there is more consensus and we can help focus
development and adoption.

We can see the potential for a common "meta-ai-support" type layer
where the common dependencies used by the integrations could be shared,
but this is not what is currently being proposed.

Cheers,

Richard (channelling the YP TSC's discussion)



