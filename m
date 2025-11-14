Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE60CEACC9
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 20:06:57 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7415.1763150814984915172
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 12:06:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=AI/5X1pQ;
 spf=pass (domain: konsulko.com, ip: 209.85.222.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-891667bcd82so232031185a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 12:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763150814; x=1763755614; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWb4KSbwv56psLCwqT2ZH1MBttMtC5QE1qmRqggNtow=;
        b=AI/5X1pQ2MqdgLYFRN0gkWRDv6TzW0Wrrs9KPPmHckSmXgbv6tW3R6uHkQMxpqoGJm
         qwADpurat6DlH1pvtu41Imtkl1DDerO01pwyxJXscPpbDtZSDNCDKCEW/i9KXhhnVmhd
         Vgt+QCpTrIIoF6ozMDfMBRirZUmEZeab/VUjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150814; x=1763755614;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWb4KSbwv56psLCwqT2ZH1MBttMtC5QE1qmRqggNtow=;
        b=OZuBVFwnfQ1U3kc+S9ig1UdK8d0ua6SDfDLi22piZTKBBJzQdBX6nkqPk2pVcAoP+a
         PEvm08KhijFgoShWjuZsepkp1/sZWmW89YoikfQtVv+uhH+SLPjR0c7olAWlTJJVyjiC
         WWme1lVmMn2B/GmUB2RhgvQJry7dCSOKzADEJn8RCxq+//WsocfNH/wXmh4Q4bxYYJo0
         D9dU3ypcFyuEoHenBBCEX/NCruH8k6AjGgwDh0uCMaIX6natZT7lPOn+/yszYuqjEEbJ
         1EtQF+vQYxeAk3P3UrHrzvwt1YddiKSid0dCgh4WSdH6GpEHzpU5rWOJ9ZpJpKn1S0ef
         B0Cw==
X-Gm-Message-State: AOJu0YwUCjYr0pn5FcwAapD9o5UXQlDo13VaaadPtsCC2LBlvsafm8Tq
	1QJW5W9r65q48ReoWTQ/pZfpFSg7ALKYb45rtsbED2wMlfz82JXxm2iAyFGiCmzghIU=
X-Gm-Gg: ASbGncs8yHQUt3gmIPesInU9g8GDdCHizBOPSzcMsJYX4Vm41QsrNBfTyvymulYQez4
	xG38/C2rNsr9NzUwG6YNXcFNnfplYLA9nRd5vmY/OWz+XBi0WHA1P/NJAA/i33/aFunn0FEyTk+
	DKH105UP6+RXhp405yhGKg7atJIMuAbvGu4/edMMrdbhHYBACrZjkh5xXnAv1kzYlNUXWtlRjh0
	ONB9iaILv0v7tJGRNuI1TWlE34F8YoInwALCrdNy0Re2yw6DfoVTm48sRdIqMe6IAyAAUQ9qeZJ
	UHTRtKhb1Op31NI2FA/gDljHyJf9VUJv/TvqnD8vHIHZ2U29udmG0Y4WqkWAP14zbU39cxhExtY
	QInTXNDuir31J0aeXPPdMaDIHU5FUkIxLz4mjM4wpRrcp0d/KTUjn/HgvfbxvAwdpbHF1XQEjlR
	dWGESzViF2zjctkIQUN7se3YKrpxSNw/xiK7w=
X-Google-Smtp-Source: AGHT+IF5haTRtRA01cf0Ws4W/l0gm4gnbawqqMSzThlTXmZ1DiBFi9VTP5GOy2YM4BLJkH5d7dQF1g==
X-Received: by 2002:a05:620a:4455:b0:8a6:1a5d:7af4 with SMTP id af79cd13be357-8b2c046f01amr680231985a.20.1763150813695;
        Fri, 14 Nov 2025 12:06:53 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2aeeb19b5sm402739585a.22.2025.11.14.12.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:06:53 -0800 (PST)
Date: Fri, 14 Nov 2025 15:06:52 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Clayton Casciato <majortomtosourcecontrol@gmail.com>, 
    Louis Rannou <louis.rannou@semalibre.com>
cc: yocto-patches@lists.yoctoproject.org, rybczynska@gmail.com, 
    pascal.eberhard@non.se.com, yi.zhao@windriver.com, 
    Louis Rannou <louis.rannou@non.se.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 1/4] openscap: update to
 1.4.2
In-Reply-To: <e7aa30d7-259b-41f0-b855-4477fb5317f2@gmail.com>
Message-ID: <8af11be3-964a-d405-cb2a-b173f133fe90@konsulko.com>
References: <20251114-openscap_bump-v1-0-1c8169b8e332@non.se.com> <20251114-openscap_bump-v1-1-1c8169b8e332@non.se.com> <e7aa30d7-259b-41f0-b855-4477fb5317f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 20:06:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2574

On Fri, 14 Nov 2025, Clayton Casciato wrote:

> On 11/14/25 1:29 AM, Louis Rannou via lists.yoctoproject.org wrote:
> > From: Louis Rannou <louis.rannou@non.se.com>
> >@
> > SRC_URI is based on the github release instead of the SHA for more efficiency.
> > [...]
> > -SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
> > -           file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
> > -          "
> > +SRC_URI = " \
> > +    https://github.com/OpenSCAP/openscap/releases/download/1.4.2/openscap-${PV}.tar.gz \
> > [..]
> I find the devtool experience is significantly improved using a
> repo rather than a tarball.
>
> Using a repo allows for cherry picking (especially useful for
> non-master) and use of source control history.

While it's a tar file download would be slightly faster than the git
clone, the recipe has been using a git URI for a long time, and the
devtool comment is fair.  So my plan is to merge Yi and Louis's update
changes, keeping the git URI.

Thanks,

Scott


