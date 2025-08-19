Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CECCA0EE6
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 14:37:54 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web10.16029.1755614268442173164
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 07:37:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=c8OjLlnL;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e87068760bso634827385a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1755614267; x=1756219067; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=er3fGDkr6r9xNhhS/WFdlBCcmEwK9O6++zZMZ3qRZ0I=;
        b=c8OjLlnLk32sJ+v/PtlFj/BIj6UNNjj1n9N2Tfh4x69YIJY53gClYgTiRSFzadz+0X
         PpNtp46ksVNLjudoZmOWfpIkCHs7OzvxIeR8iptHiPVyS5wpBxcPdf4MTr9XUAO4qeQG
         e6GQO3gK35gBBBOE4CBBa4zjJw5DTkQ+WnOSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755614267; x=1756219067;
        h=mime-version:references:message-id:in-reply-to:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er3fGDkr6r9xNhhS/WFdlBCcmEwK9O6++zZMZ3qRZ0I=;
        b=vh6jG1Lm0oRLSa6fMp1/5radE7NbE2mUXs087YMmKHrBjzXGwq1xTmA3BOBpvDqRxo
         ROSZrC4tAIt3PYW7i69fOKJMuLPQnw7xyelPcVeyAMKIR4QVKjsQQuN2JZUUHNU/E4G3
         1n7CRTlbd2uHq2ijvcoGB4h8dt2ngoV/6liZfd/INrFW7pqWcN2q903JNOTmF+X4Hwy/
         Fh3Z5C/tHuxMVkWIlVWcMfJYYk9/4sVSXfFrksdOCxf2ZUf5/MLeM6qUBNgJd0dwCAHT
         sAzvHPMgyyqBBBH7orMCd3PJ7GcRgKH6U+Q3VXhv6iIAF9mIoxceMVgDJhlDr2fKBJfI
         RTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkZ8BGLZ3XKKqGKfMiy+dHbP16/hQABET3DG1X4gH6KYfx6puSaG6+zzIL8mazqSKC03CsERXnugI+56BL@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzlQGxy6d1bYxU6nLcgXrlOOKrR6a9LzHCbme1g1X/7quvrSVKK
	bpV0TRzFPiUmo9OssukugjNwF5tCx62KWIG7anildyNrjDudfp0oVpvmAh7bU/pzRCk50kpNmYZ
	Lu24O
X-Gm-Gg: ASbGncv8eLztBtZTy7Nl8WxX9vVRB0CVzWsW1OAWU7KgxRkfLTeVkf0EN22HaCty7UD
	lmxRvxqlC1K62z7flxqJAqMwdLxqeYNbbwGX3pnR3DAue8bdExlfCfvJL5j2BVbmT6ZB7O7z9SC
	mD+OpwEQ/wOQqGeRpp1zUs6ShW3VYwLHTeqPfM+nRff40zG4e4Ncyw3+9b1LszWk4naaRtLBG8a
	BbwypFJWku+j3dMrI5W2ihk2OFN5Htw8WIopjwUXGqIXF3Ouj0QKS7iJmbWyKScKakVMRydIwG8
	ywrmXmaIL95RXFF979YqCo97AWfYGVbmFDcIPLZP0FgmUlKpVxWuaByn10VLhIGun3ZyEYWMYfY
	0ErDtlRLtRazvDxUVibBItaejpQoN6TnwYKsEG3JHmIBihxzJeJ1K0gVz
X-Google-Smtp-Source: AGHT+IFQSnlDA/LZjwrIFyGuftZMpPUGu37GoLbNjEHV9TeGLOluXJt29HibX0ULCSg3ZcGtlCNH/A==
X-Received: by 2002:a05:620a:198d:b0:7e9:f820:2b3c with SMTP id af79cd13be357-7e9f820600fmr153585885a.72.1755614267268;
        Tue, 19 Aug 2025 07:37:47 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11fbd3879sm67936901cf.35.2025.08.19.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 07:37:46 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:37:46 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Marta Rybczynska (Ygreky)" <marta.rybczynska@ygreky.com>, 
    yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-security][walnascar][PATCH 0/7] Assorted fixes
In-Reply-To: <15651dbf-91f0-47e7-8898-2331f21dde30@ygreky.com>
Message-ID: <20a64593-1502-3594-50db-3dd5713757d0@konsulko.com>
References: <cover.1755464538.git.scott.murray@konsulko.com> <15651dbf-91f0-47e7-8898-2331f21dde30@ygreky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 14:37:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2058

On Mon, 18 Aug 2025, Marta Rybczynska (Ygreky) wrote:

>
> On 17/08/2025 11:07 PM, Scott Murray wrote:
> > A variety of fixes for enabling CI against the walnascar branch and fixing
> > outstanding build issues, plus a bump of scap-security-guide to its latest
> > version to match master brnach since the changes are minimal.
> >
> > I intent to merge these to walnascar branch in the next day or so if there
> > are no objections.
> >
> > Changes:
> >
> > Anton Antonov (1):
> >    parsec-service: update PACKAGECONFIG options as lists of cargo build
> >      features
> >
> > Marta Rybczynska (5):
> >    scap-security-guide: fix fetch
> >    CI: update build for new CI
> >    .gitlab-ci.yml: add logging of jobs to files
> >    gitlab-ci.yml: fix file redirection for qemux86 build logs
> >    checksecurity: update the debian package
> >
> > Scott Murray (1):
> >    scap-security-guide: upgrade 0.1.76 -> 0.1.77
> >
> >   .gitlab-ci.yml                                | 45 +++++++++++--------
> >   .../checksecurity/checksecurity_2.0.16.bb     |  7 ++-
> >   meta-parsec/README.md                         |  4 +-
> >   .../parsec-service/parsec-service_1.4.1.bb    | 15 +++----
> >   ....1.76.bb => scap-security-guide_0.1.77.bb} |  4 +-
> >   5 files changed, 39 insertions(+), 36 deletions(-)
> >   rename
> >   recipes-compliance/scap-security-guide/{scap-security-guide_0.1.76.bb =>
> >   scap-security-guide_0.1.77.bb} (95%)
> >
>
> Good idea to backport those. I'll run a walnascar branch CI to make sure, but
> I expect no surprises.

I've gone ahead and merged these to the walnascar branch to unblock
anyone needing checksecurity or scap-security-guide.  There's still a
branch-specific patch to the CI configuration outstanding to make running
it against walnascar straightforward, but I have smoke tested most of
the build configurations locally with gitlab-ci-local.

Scott

