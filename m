Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA67CD5BDE
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 04:33:02 +0000 (UTC)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13085.1779856371432904255
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 May 2026 21:32:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=eJnxABJ+;
 spf=pass (domain: gmail.com, ip: 209.85.219.52, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b4298d271fso213713326d6.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779856370; x=1780461170; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZhthQer22FSkAZAdfLE1Pz1GKlbC/za0py4PPLlq/o=;
        b=eJnxABJ+ml0MrFnv2Uko3LOr4tftta2CH70B18ZwkE69r4nNbain/TX0vSKXDkbZw/
         XiBE+VXnjEGvF4cIrXS/B1106G5cRBpyxsccN473g3V1tHnHex1cIViRJq0lZ/Yd7DPO
         rDpOLMuvV2wbsJYE38UhgZz4Qcxv/HisTg+V2hB+tbosGcosNndPed559+GHgntfJ9v8
         jnQZZF/kDlFgz3l4fF9Py5hrb2Y+wNePn7N6DtOdLLcQAbQRrNhhQRb6c9wv6eZjfDZF
         e/J9ReRmkzXS//f5PXSvMvl11F2ud9uHT5p/leptb318EZZG+1oDdARHoTzHgJyVTZ7B
         /oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779856370; x=1780461170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZhthQer22FSkAZAdfLE1Pz1GKlbC/za0py4PPLlq/o=;
        b=DFjI2GM4/hB6aV3T1Yb9LYVHhfJq7TqVC/8e/353ojrqoa1SIexE/WlkjeTe0Ev6WX
         QIr/OLCpQItHNyi26vNoDdsx23tWAtaC+4q1m8/T7hvWVOBdhtqyplu+/I6EBG53fs7z
         x4Fn1i9LJCEpee90m9bIpippMYEdoY3vdRstybbgMN8ij007YYEj1ExMtpeG0ASfu81J
         XefR+bzQ3n2vJ/wuI26GgHF1TMw3642o/pysQJLnEy7HsLrRwfPCQm5T4BAUoNqX87FU
         potmsKWAptDtHKqDt4EtC9xnRT/GC0O5/yysW2edsVuKeTSCEHE8WiuDMyEKSUxoH8w0
         L7wQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5ByNbJ0YDQRpcolMLPApRlqac4MY+OjN0ZphAcGQlNcVYF7kYwQ+4fi3lwcy3tJeS91doR5PGS8636+8/@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxuoanY1A6+IrL7evg0JxJtrPKcDFSyglrS7C0pYt9MesTETIFp
	5mNu5oOS3OBSb8+aEMaUr2MuwJRbvQA7FMwVJb+I7nbmIrlIlfRHmpuH
X-Gm-Gg: Acq92OEm/1gv8vQjzAtp9JvTtIyldPjvFV9nAz9fkCDkBV1CP5JofUFgPSijecRvwCY
	XSU1qEQCaew4Tiktbix3g27jXAnZYLZSHQpnPfVt55k8h9IRUiumE78E2+Bul6IfdMTvNb9QIge
	S6Nwy0HPg4diSjhHxgD0KiIDvFcHKPt3PSm/wNOt8kjDGebpdTiDr8VnYlwMsOZ49Xup3PkMbMq
	LD74KdvI8uj+7sywHlhx3GxnlY5H8Zh3zsXu0zSpmqj0zhOmv75r4WjHB1uebKDjt2sCla5Jw0o
	sr2fobgu0dybivQykLeQXK/Nh1ig/nebcZUy0Xn41UL8eWjh8N1OOtHoNqqh8M6idWEIEG3dCHe
	2YTlZH7hmSLCnjxgSew6hjZ6KtKAtOiRXyfeThqyYX3ACqSuT4E3Icp6altwCtW0LtBsFW0UaTV
	FoqXTH4CrR3oFrnlP7WzTDJ9wfId0tzVsytOELHw0IYr9QiRi2M2pyRsihayvaeVVNf4O7bGOUR
	UzG5JVGy5PNYDI=
X-Received: by 2002:a05:6214:130e:b0:8ca:2a4f:7364 with SMTP id 6a1803df08f44-8cc7b60171cmr379820606d6.29.1779856370257;
        Tue, 26 May 2026 21:32:50 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e6832sm159692616d6.30.2026.05.26.21.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 21:32:49 -0700 (PDT)
Date: Wed, 27 May 2026 00:32:46 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+yocto@0leil.net>,
	yocto-patches@lists.yoctoproject.org
Subject: Re: [PATCH wic] add basic b4 config file
Message-ID: <ahZz7v5I08_FI6Eu@localhost.localdomain>
References: <20260424-b4-v1-1-04ede4cc261f@cherry.de>
 <6976ce0c-ce97-4adf-bb6c-c75c89a7e674@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6976ce0c-ce97-4adf-bb6c-c75c89a7e674@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 04:33:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4062

On Fri 2026-04-24 @ 12:26:59 PM, Quentin Schulz wrote:
> OK so this is very confusing. The default branch in cgit is
> origin/feature/no-create and I got my info from the README.md there, which
> differs from the README.md from instructions in the README.md in the master
> branch where it isn't requested to Cc Trevor.

I asked Michael Halstead to take a look and change it. We think it's
fixed now.

> 
> On 4/24/26 12:18 PM, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> > 
> > b4[1] is a very nice tool for mail-based contribution. A config[2] file
> > exists to set up a few defaults. We can use it to set the To recipients
> > to always add, in our case the mailing list, and the Cc recipients, in
> > our case, Trevor's address.
> > 
> > Additionally, automatically provide a default prefix so that one doesn't
> > need to not forget to run `b4 prep --set-prefixes wic` for each series.
> > 
> > [1] https://pypi.org/project/b4/
> > [2] https://b4.docs.kernel.org/en/latest/config.html
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> >   .b4-config | 4 ++++
> >   1 file changed, 4 insertions(+)

Applied to wic, master branch. Thanks!

> > 
> > diff --git a/.b4-config b/.b4-config
> > new file mode 100644
> > index 0000000..dc2b2ab
> > --- /dev/null
> > +++ b/.b4-config
> > @@ -0,0 +1,4 @@
> > +[b4]
> > +  send-series-to = yocto-patches@lists.yoctoproject.org
> > +  send-series-cc = twoerner@gmail.com
> > +  send-prefixes = wic
> > 
> > ---
> > base-commit: 5974ade11032f218841d9f449ef0efeee3f9a2ca
> > change-id: 20260424-b4-0ee9ab75fa75
> > 
> > Best regards,
> > --
> > Quentin Schulz <quentin.schulz@cherry.de>
> > 
> 

