Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3638C7EE31
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 09:08:35 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web10.9146.1751015312891055755
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 02:08:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=eOGe/OZJ;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553e5df44f8so1761157e87.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751015311; x=1751620111; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K1NQB2+BQR8oxIgqMPvaJd6rTGdVCPsos54x+pArxk4=;
        b=eOGe/OZJRX+gBpbPhDJRSG/Ruc3bjMIWwYAKxjTtSMzDf0/VADtPrgGrVhxPjQImCy
         h2VK0PEJ8z82ugrMoZi/y5u8BDU0/OfDdnyThl9tq9LyD7XXupa1T2eW9brML1UnbRbp
         dgRC3fWHn8LdrYTDSaKfCIC8AWQMImlC9xB3+Cd+043nJEhjpEEY6ptf/GWE4UDKS8vI
         T3Wv9LzI8Pu+S7iUIipHQ4J/IH2aQkVgsdNLNUztPXirrCHlhKzLgXjOXLEdl/F1FYpO
         CQuaHMWu3/DI3osI6mjYeAo+5l+dmP6If3mNdo1VFco5QuQCcnm24BazZeK2NJqipIDU
         PpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751015311; x=1751620111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1NQB2+BQR8oxIgqMPvaJd6rTGdVCPsos54x+pArxk4=;
        b=ivNiovw85G8NzArkD7dWNwPuBlkM96GO4nzjEHJD8no63u1h6ooQkMSrzG626yk4Hn
         BfFW/YXrU/WlM6/V3mven4pdgb3E6ImULVzXrBm30hre1tIjmmawJP3AkofZtQWF0UCt
         z5gPotYoyihYHuEAXpAlgykl2Q6loIQNfNvxxwDDgf6Zb0rIAFQg3/1XE66jvuyhih/9
         CeVqIba+0GXrX3gaIcbwzf+E05DlWdyKMOXoHgo38aWogtAmfMc1DhW/HZhZFd7PtmsE
         QXvMdvJuWuiEqGDun8l53rLutrE/4UsnUjeOtPrRrxQsKDnE840UC0QAYXH9VWn/Dlg6
         9wGg==
X-Gm-Message-State: AOJu0YyBJ2nrzda0U5A9nptzv0Pqc5s3qcWWY4Z9tgm++47MGG5TgmiB
	lDBq/fjWjAcAibw+ktvcUsUdMPsxJ7nBO8vCEcJFLlwDHDKc4xtkWBbWFolmiQARqbCNMzBDx1s
	WbV0ORE0=
X-Gm-Gg: ASbGnctbQdUsCOVenbJtJyKe+2Uzf8hGUuRxHZvrKXMTwNFSqIkx9AeenaL6gjuGDXv
	Q7sY5YwmprJ9ZV7S4LjskgO/AhvbnxUCu9PmCP8r3bwIz0DC5+LlZNzyxRKakckEkPTrn6dxW5C
	6uZh0b6NE9IFFMFNFXRxPaV097XtlVS0Z7EAVTLDPgW5Tc0DMzH3UwxeFb5J4o3CCZJ8Mg/IIme
	OiG5d8U8Qqmdz9xQHrevGlUINIPqxyNhXKqO0QMtKBfNJG2t6GcJWIAmh4Ay+a1K/Zqm4s+UQi6
	qj5wPVJAANRweIUymLpaSckMoQ7lbOzsw4u9iza7UdX3WuJOZXkPEsdXFvsTm2+Z4JY1JsRnkd0
	cAEm7STAPNQbe+1wfh/8=
X-Google-Smtp-Source: AGHT+IFo4cCtu0k+MI4dQSyk44+7KYkYAhFT9F0OoGrW4o9Ea8cjrE50ndor280TKOcRdVgwGhg3Hg==
X-Received: by 2002:a05:6512:3ca5:b0:553:cdd7:368b with SMTP id 2adb3069b0e04-5550b8bf091mr982954e87.43.1751015310608;
        Fri, 27 Jun 2025 02:08:30 -0700 (PDT)
Received: from nuoska (87-100-218-141.bb.dnainternet.fi. [87.100.218.141])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2c5326sm367282e87.145.2025.06.27.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:08:30 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:08:28 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Hiago De Franco <hiagofranco@gmail.com>,
	Marta Rybczynska <rybczynska@gmail.com>,
	Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH] layer.conf: Update to
 whinlatter release series
Message-ID: <aF5fjPM52yH1S5ej@nuoska>
References: <20250622173729.13803-1-hiagofranco@gmail.com>
 <20250627074019.GA5745@francesco-nb>
 <066e1255466f5be3f01581e9b6498abc0450b110.camel@linuxfoundation.org>
 <aF5WTUvd638TC9ME@gaggiata.pivistrello.it>
 <5b8869c965db71c176b0bc8b74510acd7570bf6d.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b8869c965db71c176b0bc8b74510acd7570bf6d.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 09:08:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1709

Hi,

On Fri, Jun 27, 2025 at 09:45:49AM +0100, Richard Purdie via lists.yoctoproject.org wrote:
> On Fri, 2025-06-27 at 10:29 +0200, Francesco Dolcini wrote:
> > Hello Richard,
> > 
> > On Fri, Jun 27, 2025 at 09:09:35AM +0100, Richard Purdie wrote:
> > > On Fri, 2025-06-27 at 09:40 +0200, Francesco Dolcini wrote:
> > > > Hello Marta, Richard, and all
> > > > 
> > > > On Sun, Jun 22, 2025 at 02:37:29PM -0300, Hiago De Franco wrote:
> > > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > > > 
> > > > > Update to the new Yocto release series.
> > > > 
> > > > I understand we are on a pivotal moment with meta-security maintainer
> > > > discussion [1].
> > > > 
> > > > And currently we have our whole integration and testing blocked
> > > > because
> > > > there are build issue on meta-security layer master branch.
> > > > 
> > > > Do anybody see a short term solution, to solve the bare minimum build
> > > > issues?
> > > 
> > > There are two sides to this. On the one hand, you'd like the issue
> > > resolved ASAP as it sounds like it is causing you a problem. Whether
> > > such a change like this should cause you such a problem and whether you
> > > can in fact work around it is a discussion for another time.
> > > 
> > > The trouble is as soon as master gets fixed, people will go back to
> > > focusing elsewhere. Many are already finding ways to ignore it until
> > > someone else fixes it. There is a much bigger/deeper issue here.
> > > 
> > > Since you have a key dependency on the layer, I did have a look at the
> > > commit logs but I don't see any patches from you, which is interesting.
> > 
> > Hiago is in my team, working for my company, Max the same (both in Cc here).
> > We send fixes regularly as we see stuff breaking (oe-core, meta-oe, ...).
> > You'll find commits from my team just grepping for the toradex.com email
> > address in meta-security, oe-core, meta-oe and so on.
> 
> Fair enough, thanks. I do recognise their names and there are 5 commits
> in meta-security from toradex which is appreciated.
> 
> > I am genuinely trying to help, because while we can send patches to fix issues,
> > we need someone to apply those. And Marta already volunteered, and that's great
> > (thanks Marta!).
> 
> My point was that bandaiding this as requested can actually make the
> problem worse. We need people to realise their dependency and realise
> this isn't going to work unless people find a way to inject some time
> on the layer.
> 
> For example, I know from experience, Marta is very busy. Despite great
> intentions, I worry the turnaround time for her on patches might not
> meet expectations.
> 
> I could easily push some patches into that layer, and I would get an
> easier life right now as I'd not be writing these emails. I would
> however then get another request to quickly fix something else and it
> would spiral.�I gave the same repsonse about meta-java recently.
> 
> Meanwhile, if I did push changes, people wouldn't see the issue and
> would just pretend it was business as usual. Whilst hard, the correct
> thing for me to do is not to merge anything and let this play out and
> resolve itself.
>  
> > The desire to have it building, as the bare minimum, is because once we have
> > it our CI will just do its job and we can send new patches as issues as seen.
> 
> Help with testing and such fixes is good however please do keep in mind
> that the layers really need to develop and grow and adapt to the
> changing world around them (like the duplication between layers in this
> space and the different competing tools). That needs active maintainer
> and userbase participation, not just fixing build issues.
> 
> I'm spelling this out for people in general to understand the
> challenges here...

FYI, me and few other colleagues from Linaro also have an interest in
meta-security contributions. I see that it lacks quite a bit of
CI infra and for some of the features like TPM support I'm trying
to contribute the missing pieces.

I think the layer has been in "best effort" state for a longer time
and it should be clear to all users that it's not in same best-of-class
support status as poky. It may help when creating products but the
maintenance, security support, testing status is a question mark which
users need to handle on their side.

I wont be holding my breath for things to change drasticly but can try
to help where the features like TPM match. I hope a maintainer
is found to handle contributions and basically ask the hard questions
around CI and testing. It is fine to ask for a test for regression
fixes and new features. We all will benefit when features can easily
be tested upstream, not just in product configurations. I don't think
more is needed at this time.

Cheers,

-Mikko

