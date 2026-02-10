Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD36EB26E3
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 16:25:35 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23792.1770740730479458432
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Feb 2026 08:25:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=r4DutsAS;
 spf=pass (domain: konsulko.com, ip: 209.85.160.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5032e15525aso52850631cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1770740729; x=1771345529; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfFSAUY5icPixIDq3zanAEEA3p00jB7py46jDZB5vuc=;
        b=r4DutsASKcM2EJ9t/q32X36cB4rp2Yy61abpcxKTdixT05r2knub6D55v6wcXSifZl
         H9oquAyLpm63TGYYmF7qeTVFjEzXIYSkb+mR21jFzYr3LL/jFu3jA6W8b9vkMe6Ld/HR
         biLrh7vVbbWU/1tiHHekcSO/tUGlPlzeR/cBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770740729; x=1771345529;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfFSAUY5icPixIDq3zanAEEA3p00jB7py46jDZB5vuc=;
        b=LFq24G/vYOuDZ9QSgV2inXRIFfq+gXR+8HW9e4b1nU0fXZRLzOCNFk+kCwHRm78Jdl
         vdkrpqHO8en8W/0HRC1Ae3OH3/QUHZXkJuw6pPFyM7Vfamnm4ZPrrhJlimefdiKF97e7
         NwUs/aA/+uwFPJfKb4kymYxyEPJlbMVVSk+aSlixesalLuurWMb/stS7emzUdUUWoSXO
         yJvDNN7tdb+srlWz1jYVw/hLdsl/TgfOtI/hBTZTMvL7c97HIVcPrvPxyix0m12dlMdl
         GzJwhH6z3zclBj1GauUMKoCN8tAqwf5RaNvPdcWs28qmfOy3SqWUr9PqxYjvy6PTopgQ
         59Dw==
X-Gm-Message-State: AOJu0YxhUHfCfwFX2MGtgUO4PBOvYdQdmvC32jvfwa7nLr88AwE2JB+X
	jgiIN1jCfoWvOSekXnuiXwG5zuvNRrZpnHWa+SneQUQm88G6heZA7uxUojNNw4BNBDxYEJh4esH
	qSVan
X-Gm-Gg: AZuq6aKNN23tq5XOG1d9Ah+BeYs8FXnUO2KWfQpEYmMCV3hzJINYoJT7JFqc0nkDvAv
	rGkZR/E1Qbgju8yXweCAnEUgFeoMaROhwmQOmNOfSw5nlJ4tz5j01DOdJ7wUQBQl6tlHuvoTGC6
	SeNs0nz89FIdtXtdLHBvUdjqHykqPINeOwlHC6uHyO70iCe1ToDmwxUOE8S4fnBTyLwLmQ00dHZ
	KHTa4MTmgzRC0yGh0OHAuvWsVJglgZmcTs1XpldwNGx3KZ6QH6sk5mPFFnuuksUM4fKmhjmvBW+
	/1a3YjxzDYUF1XlBCMJw3YAVKVtYKwgzsCy/sqYoXj/oSYEuQiU/IA9rWuFfpJIrw0qTHVgflV4
	bT9ZbdZNDK0DVxljPU2X7io3nj57U6qBJk+Bs42jR9jCigAD+vAuaNnR9WkEMLAwpx4mvMVci3P
	wu0MYy/hE2S3d35dus7O0Kjhbsf12eodgGZcWEAWzdjTcXXTG+bsB5oEjLRrXjNF4TyitlhfV5q
	07j1oW+7MmolkrXPk1aWfSp03vViMHt8LidOuuWv5M87Xk=
X-Received: by 2002:ac8:7d42:0:b0:501:458a:9a45 with SMTP id d75a77b69052e-5063988b5ddmr216618721cf.30.1770740729151;
        Tue, 10 Feb 2026 08:25:29 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50638c37b75sm101510701cf.0.2026.02.10.08.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 08:25:28 -0800 (PST)
Date: Tue, 10 Feb 2026 11:25:27 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Zahir Hussain <zahir.basha@kpit.com>, 
    Nitin Wankhade <nitin.wankhade333@gmail.com>, 
    aszh07 <mail2szahir@gmail.com>
Subject: Re: [yocto-patches] [meta-lts-mixins][kirkstone/rust-1.75][PATCH
 0/1] Ignore Windows CVEs
In-Reply-To: <1891C55AFA272B5F.426509@lists.yoctoproject.org>
Message-ID: <8eac3e81-aa32-8119-9363-cfcb935d8ea5@konsulko.com>
References: <1891C55AFA272B5F.426509@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 16:25:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3211

On Fri, 6 Feb 2026, Scott Murray via lists.yoctoproject.org wrote:

> This kept falling to the bottom of my TODO list, but I did some testing with
> cve-check last week, and decided to update the patch since CVE-2024-24576 was
> also showing as unpatched.  I intend to merge this to kirkstone/rust-1.75 at
> end of day Monday (5 pm Eastern, Feb. 9th) if no issues are pointed out.
>
> Note that I considered applying this to the 1.68 and 1.70 mixin branches, but
> it does not seem worth the effort, as they do have other unpatched CVEs that
> would require some further investigation into addressing.  I would recommend
> folks using those mixin layers that are concerned about CVEs take the likely
> easier path of moving to at least kirkstone/rust-1.75 instead.
>
> Scott
>
> Changes:
>
> Zahir Hussain (1):
>   rust-cross-canadian: Ignore Windows CVEs
>
>  recipes-devtools/rust/rust-cross-canadian.inc | 2 ++
>  1 file changed, 2 insertions(+)

This has been merged to kirkstone/rust-1.75.

Scott

