Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E9BCCD195
	for <webhook@archiver.kernel.org>; Fri, 17 Oct 2025 14:29:21 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.16829.1760711359845393795
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 17 Oct 2025 07:29:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=o6yXxosp;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7960d69f14bso17113746d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760711359; x=1761316159; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4Mia+xTTO7YsYj7/axkmx0NIvSeymx8y+KqLzOeDd8=;
        b=o6yXxospqpOoEPaRn8+vrsV1d6pjCfuzy+Ry9w/w3pG2wDv3+7Oym8yQ0lHeY5LnOp
         iaxugv++8iRRk4CC74psuRLOIXLrwBqT7ezl04Dc+XisMJVJ3+aWt7wYx6oC3NtePwRd
         6q4xsTZHoAjxdswdUVSBoHKvS/zgzfA0hmtX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760711359; x=1761316159;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4Mia+xTTO7YsYj7/axkmx0NIvSeymx8y+KqLzOeDd8=;
        b=vX8r1GrEfXgGNOUIVIwV/5ZN0iT4qGWjqIbOpsM+5jteOVKw2UmZokSe+XSF0/ZUww
         iYltpJ0XKju7vInPf8PxPQN+bicrn6WjDTxqsk1KkfygzyYBKbvRisYQ9nknFnnJ0kzi
         OfqtqeKIll1SgpxTKvAycQFokNjcsZqVi8WOskRowD3RHsqxmqxngFCAmTLKjOiF3ney
         uWw3hMX/KxqOaXgQQjEnrhCwAaOwyEEG7R+VP292T53k4KqFPN01svRejkoEzCD8GZkb
         V1NW7TaXiIgoS9tYt0kTW8y3f7r/V9X6CVxD4P0zg5GUXgu+s+xKd8SRzGPsBIEX+1tp
         0d7w==
X-Gm-Message-State: AOJu0YyhldxNUEASXzkjy4RO+eVBlt43cSfHCDGc1l7/W6xxZOATFMAt
	CzvOnXEME+9edLuXvcn9C8TjUIW2CC3/PhbQCHuN5cRL31o/6FBu7NNSWpE+gr9jCR4=
X-Gm-Gg: ASbGncv1s+zjiMfcm3aKlk9Zhs03VyopXu9lSfeLq1UAZuWQ9Z/iQnWz4S0WP4Z6mE1
	G6wJ9dDBz7qwoSRMfhm2DjbKC8/X3Lwvx/rq1YqVcbPras2lcjevpbILJcfdqmamfVtP4JCCXK4
	OMVqfcKfT1tU2xq2GZIpxenUFkDUNZplhQBlW2R8+hthNs6IYqoDwnXu/BsuBARsRznCeo0b5Xk
	IMVoLOiEWz9tlnBAjKk9dHbWMAsYZGmDMhCWqNdTjMR/zbuOIOryyx2alH24mkQguGPU+nMzyZk
	DJTKMhNhjMMeVOfFSpn2SbAQIhCfjuWFrM33bFMjdk2EXkeC8UgSJ2UD1kb2XIyKPXHqPLKBMA4
	EHwF+HBpx1HVRV1mfEcZf4fXrc9oeqnAyqfM3vM3hSaAJdeYHZu89AV7zOL++00/x4dsbIxeYzD
	PSFHy57/c3kPtleAnBSz5x/F/xCQGMgu+2vF0=
X-Google-Smtp-Source: AGHT+IFHYG6AaD/SB9+6KtaLw28HerpHNojmPsVwm+xe+bwG9AsfyLt8s13lNjJDDUYCktlVOXfC+Q==
X-Received: by 2002:ac8:7d49:0:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4e89d28f497mr46786001cf.28.1760711358325;
        Fri, 17 Oct 2025 07:29:18 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c16fe1e25sm34315606d6.1.2025.10.17.07.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:29:16 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:29:04 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Marta Rybczynska (Ygreky)" <marta.rybczynska@ygreky.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-security][PATCH 01/15] kas: use repo name
In-Reply-To: <e1d64ff2-80b7-4a99-8329-0d227199032f@ygreky.com>
Message-ID: <af60652b-486c-0aa0-9733-2f4af98c8829@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com> <6cbe841e8b09ac4804e8c87e23f81d68f97c17f4.1760648348.git.scott.murray@konsulko.com> <e1d64ff2-80b7-4a99-8329-0d227199032f@ygreky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 17 Oct 2025 14:29:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2349

On Fri, 17 Oct 2025, Marta Rybczynska (Ygreky) wrote:

> Hello Scott,
>
> we do not need this one (removed from
> https://git.yoctoproject.org/meta-security/log/?h=master-next)
>
> and it would actually break the build for meta-security

Oops, I wasn't paying attention, thought I'd filtered that one out
previously.  We definitely don't want this one on master.

Thanks,

Scott


> On 16.10.2025 23:22, Scott Murray wrote:
> > From: Marta Rybczynska <marta.rybczynska@ygreky.com>
> >
> > Use the repo name directly, otherwise the build can get the wrong clone.
> >
> > Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
> > ---
> >   kas/kas-security-base.yml | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
> > index 17f4bb3..e5af7bc 100644
> > --- a/kas/kas-security-base.yml
> > +++ b/kas/kas-security-base.yml
> > @@ -6,7 +6,7 @@ distro: poky
> >   repos:
> >     meta-security:
> >       layers:
> > -      ../meta-security:
> > +      ../meta-security-staging:
> >         meta-tpm:
> >         meta-integrity:
> >         meta-hardening:
>
>

