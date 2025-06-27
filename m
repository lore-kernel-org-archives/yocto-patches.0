Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9193C77B7F
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 08:46:05 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.8630.1751013953865265307
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Jun 2025 01:45:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DfBA/lYb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so1736703f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 01:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751013952; x=1751618752; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wxxilm4VkzxTwEgGt1ae/oWWIamqQPJRu7Gtm7bPE0g=;
        b=DfBA/lYbRxP9BGRimdykuebJdJDYsiMNPFWHZCkiwBIDFM8i75Qs0YW3vVg1L7rWgb
         PnF7B3iwh9f35co27s8p54Ge6IYiMjmhj90Epdaz4CIdFnv6wdwovS2P5U0yRN7wfPZY
         Jpd7swWnBycdA4JRV6sqrIsyrek7UCmbmHNEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751013952; x=1751618752;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wxxilm4VkzxTwEgGt1ae/oWWIamqQPJRu7Gtm7bPE0g=;
        b=Xmawy7zKkw7zUUPvKXlNHAdjwrub/RTLu+3ODKmCTmSa9nxRoc1SyAGOYgV3sL++oI
         MuvUaekTV6G5QZiaw/Fu+ENvn6++3ED22zJDc0CgZsdtTYjfEarxORHov+WNzzVaigJG
         wwdTLAJcYpuigrRQ7dzD3Bhc9lWOwEwLeS1KJ/7QQ+0QzyK3nT9y0Kl3CECh+FHvv9XB
         5wwMaGGpfOEZrfWs7UBytFEZe1YqykV17lvCNFpRWqwwOWoyCVqG92VMtehfH7Zrqx98
         L/bu753hrm7fo6wOh8YD+T8z/PKlWxrEF0WZpIm15pNKBEjcoVUsPqjhPm+44me7dEeY
         o9Tw==
X-Gm-Message-State: AOJu0YwXVr08cBW/g16z0u6xM5byV5JpytF/1vrcwVVyz5OQ0FfPQXK2
	XRTT7MMJtMFUavzzOHzNp6gStDS6wgHWSbw95dp++9mGRvdBRCI8TVn1rUaZ77jDZeE=
X-Gm-Gg: ASbGnct18ga5taOY7jd8kT86UI+nE/MrE2jtfKc0p3D/F4ik/WElfSV4cKWQ44L5xbB
	1ItBQC7Mjo3VduMSdJgy9AFelgtPBnlpukS38AaguXJh2rAL+aD/xCcVt9RoJEM6J4gs9iX1XOb
	X1oCJ85ssqtmyKX/dzMT6xcXGT2BF/Kl3feLWifc4aC/7WiTYgrE3h0tMb95+titKxHS8J/Fh6F
	XAOCnG5nKN5NM++rW3oZeq3MU2WENRiuLRUdWnBSf3prIhhTKjq1b3Jk1YF3ANRlaO/iMn9FjE9
	FQ4ihRzGXFqBiE02im8jkEdunmv0F7AKcJOwrYJA+N/hud4TsW+UJuVcRw7lzWi3CwPScQnRMJm
	g6V/ZNAncBv1HnN5LCpbwgWf172ZSUhV4yNPqgU+0GhuyIVugZCI=
X-Google-Smtp-Source: AGHT+IEm3ko514bKVZ2yS5WQTzgLjvfFEUMBLlUMrlASeRncUllmOLaZT4wvZsE7JbebdEFT01vDww==
X-Received: by 2002:a05:6000:25ca:b0:3a4:f744:e00e with SMTP id ffacd0b85a97d-3a8f4548f84mr2259164f8f.4.1751013951607;
        Fri, 27 Jun 2025 01:45:51 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ef04:c18a:8ac7:33db? ([2001:8b0:aba:5f3c:ef04:c18a:8ac7:33db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7fa8aasm2051540f8f.27.2025.06.27.01.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 01:45:50 -0700 (PDT)
Message-ID: <5b8869c965db71c176b0bc8b74510acd7570bf6d.camel@linuxfoundation.org>
Subject: Re: [meta-security][PATCH] layer.conf: Update to whinlatter release
 series
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: yocto-patches@lists.yoctoproject.org, Hiago De Franco
	 <hiago.franco@toradex.com>, Hiago De Franco <hiagofranco@gmail.com>, Marta
 Rybczynska <rybczynska@gmail.com>, Max Krummenacher <max.oss.09@gmail.com>
Date: Fri, 27 Jun 2025 09:45:49 +0100
In-Reply-To: <aF5WTUvd638TC9ME@gaggiata.pivistrello.it>
References: <20250622173729.13803-1-hiagofranco@gmail.com>
	 <20250627074019.GA5745@francesco-nb>
	 <066e1255466f5be3f01581e9b6498abc0450b110.camel@linuxfoundation.org>
	 <aF5WTUvd638TC9ME@gaggiata.pivistrello.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 27 Jun 2025 08:46:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1708

On Fri, 2025-06-27 at 10:29 +0200, Francesco Dolcini wrote:
> Hello Richard,
>=20
> On Fri, Jun 27, 2025 at 09:09:35AM +0100, Richard Purdie wrote:
> > On Fri, 2025-06-27 at 09:40 +0200, Francesco Dolcini wrote:
> > > Hello Marta, Richard, and all
> > >=20
> > > On Sun, Jun 22, 2025 at 02:37:29PM -0300, Hiago De Franco wrote:
> > > > From: Hiago De Franco <hiago.franco@toradex.com>
> > > >=20
> > > > Update to the new Yocto release series.
> > >=20
> > > I understand we are on a pivotal moment with meta-security maintainer
> > > discussion [1].
> > >=20
> > > And currently we have our whole integration and testing blocked
> > > because
> > > there are build issue on meta-security layer master branch.
> > >=20
> > > Do anybody see a short term solution, to solve the bare minimum build
> > > issues?
> >=20
> > There are two sides to this. On the one hand, you'd like the issue
> > resolved ASAP as it sounds like it is causing you a problem. Whether
> > such a change like this should cause you such a problem and whether you
> > can in fact work around it is a discussion for another time.
> >=20
> > The trouble is as soon as master gets fixed, people will go back to
> > focusing elsewhere. Many are already finding ways to ignore it until
> > someone else fixes it. There is a much bigger/deeper issue here.
> >=20
> > Since you have a key dependency on the layer, I did have a look at the
> > commit logs but I don't see any patches from you, which is interesting.
>=20
> Hiago is in my team, working for my company, Max the same (both in Cc her=
e).
> We send fixes regularly as we see stuff breaking (oe-core, meta-oe, ...).
> You'll find commits from my team just grepping for the toradex.com email
> address in meta-security, oe-core, meta-oe and so on.

Fair enough, thanks. I do recognise their names and there are 5 commits
in meta-security from toradex which is appreciated.

> I am genuinely trying to help, because while we can send patches to fix i=
ssues,
> we need someone to apply those. And Marta already volunteered, and that's=
 great
> (thanks Marta!).

My point was that bandaiding this as requested can actually make the
problem worse. We need people to realise their dependency and realise
this isn't going to work unless people find a way to inject some time
on the layer.

For example, I know from experience, Marta is very busy. Despite great
intentions, I worry the turnaround time for her on patches might not
meet expectations.

I could easily push some patches into that layer, and I would get an
easier life right now as I'd not be writing these emails. I would
however then get another request to quickly fix something else and it
would spiral.=C2=A0I gave the same repsonse about meta-java recently.

Meanwhile, if I did push changes, people wouldn't see the issue and
would just pretend it was business as usual. Whilst hard, the correct
thing for me to do is not to merge anything and let this play out and
resolve itself.
=20
> The desire to have it building, as the bare minimum, is because once we h=
ave
> it our CI will just do its job and we can send new patches as issues as s=
een.

Help with testing and such fixes is good however please do keep in mind
that the layers really need to develop and grow and adapt to the
changing world around them (like the duplication between layers in this
space and the different competing tools). That needs active maintainer
and userbase participation, not just fixing build issues.

I'm spelling this out for people in general to understand the
challenges here...

Cheers,

Richard

