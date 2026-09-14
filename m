Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA98C88E77
	for <webhook@archiver.kernel.org>; Mon, 14 Sep 2026 21:51:40 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9550.1789422694903703537
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Sep 2026 14:51:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=CvCWbpcq;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-910316a2fc9so53915496d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789422694; x=1790027494; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c5AGKSUELXf1PYelu0ZfZ6o6JLyUcg5XL8ObWP5/k68=;
        b=CvCWbpcqlkK2jlG69Mcf3IVDuqA9GGNl7RhU56C7QGT/0dRf0EzApCPPGQY1Ti9xkr
         47GQtwhAiM48uiL73SRJrew12wyhUKrN2CdcK8ieuWyxkl998vMZlGwKNMqIVZmMNHXY
         SA6BmEJlhGmRRWJOkSpZKsuJbb+AvX/4VoPtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789422694; x=1790027494;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c5AGKSUELXf1PYelu0ZfZ6o6JLyUcg5XL8ObWP5/k68=;
        b=rCOr40LNGiGJvXBKdBcy3z0yeJlZB0eGN9hBMdIKMj221zHz+ActQ8ZoWYdIpZ9tSR
         7f9lhjZOXWDuqDXoaMqE49D+zJCPCCPWPi3cfR9TymUWAVcH7Uo1MV/bcgVyk5pbuLz2
         8eHG9p8kL/4fPsgKINFwlGokhIkxLdIkxuCDo8R8C2Zo7bhLxMdN8gy7qo3PgzkyEZWt
         SmgCwkzRJVHB5SG+PVjaLkTRSPJuir6gTbedTTZgfgFJOVe5iKAIl2vGRz/cXQr3oN/1
         CKZSQN47p3DFGCPayUmb95xNvf5mECX7smhQS8M1bj4D4K/S4xlZvCdqtuQ7UVwATAB/
         MLuw==
X-Gm-Message-State: AFuF++mwOB4hc8P/VOeeO2rjoLqalLuDOMxhnVx64BI9bckWqDFDqcOf
	aW2Bf7MPt+DzLnSNX8r4aAE3f/8D1C4MO3bfjRZSuvsijoi1AdDZ7QIi8Q8rABpCeFE=
X-Gm-Gg: AYBFou0r1sH7a9hcCELhAFSVPic/PU2E0vnj6hxtoMNMxzYAn09EsYR74ROtQdQh48u
	FIBFpSAzirxlDvHDFGIxe5eT+kqjFNX0ygylff+3BRcanbYYgavIlC3vrhBaFtUv6kvUQYpX3aa
	qPf++EqthdS2CimD8HgMtHc3q4nPi4LRYYQ+6TUokZx2VfZOuqe6Z9tt18PKlXv4yYPywmXLg9e
	7OGSH6S7ilyV6llMS2eAdXzCAuRfbegKu702XcY8zR8BZMmBdwVLMvJWOIb4yKJrmbv4PSbGGqr
	Li7YMC7IYr8AUtIMvZPgfKfk3LNTCixiJCXRVij9YnKJ7DyfN/Uhr9xdmkVNP5fPPEuxtnfj328
	5E6zoBpnQfz+OpdhSx11Jf2EaP0JD6KrETwtsNwi1THfAgN4cEumyKcxic56otWnjRLAz3FYpL8
	D4q/O1EdbJHrPznTuuKmvatqVKWdw9nCMsVQf1kkV0Vp0nYrMyFHMdEMiXn/3Hz31/4aBIPho3V
	MQSe3WNNf17I/zdzGUObwTe1bTWGdKeLJxbEnh5CvW2lXU1GVSpaiqLQDb+Dqd6ZsflQO/X07Ie
	mIeXhHP3xBYHGO+D/3EKTNSTX644
X-Received: by 2002:a05:6214:d68:b0:910:3451:b180 with SMTP id 6a1803df08f44-9122e6529dcmr72342206d6.33.1789422693569;
        Mon, 14 Sep 2026 14:51:33 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f5e880csm103973816d6.49.2026.09.14.14.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:51:33 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:51:21 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Marko, Peter" <Peter.Marko@siemens.com>
cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [meta-security][wrynose][PATCH 1/2] tpm2-tools: set status for
 CVE-2017-7524 and CVE-2024-29039
In-Reply-To: <AS8PR10MB507351E265141452DAE68DEFFDBC2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <31c5c523-c6de-818f-9a8e-ea452be021df@konsulko.com>
References: <20260721164643.39248-1-peter.marko@siemens.com> <AS8PR10MB507351E265141452DAE68DEFFDBC2@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Sep 2026 21:51:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4843

On Sun, 13 Sep 2026, Marko, Peter wrote:

> Gentle ping for updating wrynose branch

Sorry for the delays, I have substantial patch series for master and
wrynose worked up that I just need to finish testing.  They should be out
in a day or two.

Thanks,

Scott


> > -----Original Message-----
> > From: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> > Sent: Tuesday, July 21, 2026 6:47 PM
> > To: yocto-patches@lists.yoctoproject.org
> > Cc: Marko, Peter (FT D EU SK BFS1) <Peter.Marko@siemens.com>
> > Subject: [meta-security][wrynose][PATCH 1/2] tpm2-tools: set status for CVE-2017-
> > 7524 and CVE-2024-29039
> >
> > From: Peter Marko <peter.marko@siemens.com>
> >
> > CVE-2017-7524 is a historical CVE and new cve-check does not undestand
> > fixed version data. Debian report [1] shows fix commit which can be
> > linked to release information.
> >
> > CVE-2024-29039 is per Debian report [2] fixed in 5.7.
> >
> > [1] https://security-tracker.debian.org/tracker/CVE-2017-7524
> > [2] https://security-tracker.debian.org/tracker/CVE-2024-29039
> >
> > Signed-off-by: Peter Marko <peter.marko@siemens.com>
> > ---
> >  meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-
> > tpm2/tpm2-tools/tpm2-tools_5.7.bb
> > index e1a0c5d..c06115b 100644
> > --- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> > +++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
> > @@ -18,3 +18,6 @@ PACKAGECONGIG ??= "efivar"
> >  PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
> >
> >  BBCLASSEXTEND = "native nativesdk"
> > +
> > +CVE_STATUS[CVE-2017-7524] = "fixed-version: Fixed since version 3.0.0"
> > +CVE_STATUS[CVE-2024-29039] = "fixed-version: Fixed since version 5.7"
>

