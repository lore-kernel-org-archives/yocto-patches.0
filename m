Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B25C3ABD9
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 10:03:49 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.98398.1747217024178166866
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 May 2025 03:03:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SLpqWYO1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441ab63a415so69605725e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747217022; x=1747821822; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jNAN89tD76icLTO1o34S1CMnZzEbuobDrFJUbyBADbY=;
        b=SLpqWYO1/sKfhha7swPx9olqHTwWwZMDxj31mN5X8U0kX1TY9kjlN7G+Z++zN5Z5E7
         BtkRTK2LA6Ms3vvENYWdIVwyA+SePrx7OTF0yMKylnfRIcS2KDuU/WAlMTVCZ8PdiHt8
         Pq9FJvLc012WXoUbYqbskp+/+6nk8J+Fvg8Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747217022; x=1747821822;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNAN89tD76icLTO1o34S1CMnZzEbuobDrFJUbyBADbY=;
        b=eXA5THml4WJFhnd2pOEZAAbw30uPTRRniZCnPSYpMuESXnP+S+URhlKdHoGXT51LB+
         KqRWhjqoRxCL3refg7E7RwIxNStOCDiDkkfeAWjRb4/d4BgREj/aw8OZ22FGi7YpxPh3
         GJvO6kiREKC/Ev4l2fL8W+kisJW1Q4MtxWOerB8vb5fKNZsIuW07xAGi4wL/AIpwjRE8
         yAYvmO76MJlF7h2q9uDjFL4DSLer0PTmqW0N0HWZ3+72etE+56m8JS9aoZxyYcP/2Frr
         5w5XBt6iE1L5UUQXU/ze29H/MQJjHLGX/jpFZpkZOl9+oBvTXRVOkLyPc7GwByHD1U64
         DSPA==
X-Gm-Message-State: AOJu0YwkbDqjez4jbzGMflZDzqCBV2/u581ID/UVkgQgrdF/S9Od2YfU
	Qo2KN2una+EiT8endKFvEdHQcigRkDUsNyM45lCJGI/aq2GEHso8p1c/2PD33yKW8mUnrWQcXOH
	U
X-Gm-Gg: ASbGncv7JVq2cJpYKn220UxWoD8IS4pG1uXlrzLNkES/D8Nzq4vQhNXFauWC5RFY6Iy
	YAk0h2CahrO+hqFaTtz6CZZC8I02DeMvVO/vnPCLMfczLn3hHRnaX+mtyzsjG5Mr7EUS2nEF+wN
	XKwsQGeOTGZgjfjvr45EocZJafepWGeIwmccgo31FLcfo6aM99lwWqXb15wg1q7+sHp2/ruaIX9
	DPk7GQWU8xVQZVQFp8Lss8B9Z5Ij6AROPRF06zQPEMvXFWrvGHverd0wvp2F1sHgiHu5R8Y8/0j
	o5jQ2UhLWhnnYyXZ4bZBU4h3m73yipVLE4ZJBhQesFp8bwf0d3sZO5Wc4RW9anFeI/mHetbL8Cf
	XzaFKKw0daoQ1JjQwwZFqUotoSlkm2x6EYQpYy0bah6BWzhRz+lI=
X-Google-Smtp-Source: AGHT+IHNfcyGflAFcmmS69cQrUmRjiVmLIikCpPVRuPY4e90jUWW38+89yfbhBzNnYbGtq2foGvUOA==
X-Received: by 2002:a05:600c:1c19:b0:43d:412e:8a81 with SMTP id 5b1f17b1804b1-442f217986dmr15215625e9.28.1747217021922;
        Wed, 14 May 2025 03:03:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac80:8bbf:3444:fa34? ([2001:8b0:aba:5f3c:ac80:8bbf:3444:fa34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfbesm19488239f8f.10.2025.05.14.03.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:03:41 -0700 (PDT)
Message-ID: <7a817043adcb5421810d800dcbd77ccef071a825.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [psplash][PATCH v2] configure.ac: improve
 option handling logic
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Olivier Benjamin
	 <olivier.benjamin@bootlin.com>
Date: Wed, 14 May 2025 11:03:40 +0100
In-Reply-To: <20250514091413.451634-1-olivier.benjamin@bootlin.com>
References: <20250513141757.397196-1-olivier.benjamin@bootlin.com>
	 <20250514091413.451634-1-olivier.benjamin@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 May 2025 10:03:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1553

On Wed, 2025-05-14 at 11:14 +0200, Olivier Benjamin via lists.yoctoproject.=
org wrote:
> The configure options currently use hardcoded values in the
> [action-if-given] branch of the AC_ARG_ENABLE autoconf macro
> to determine whether the behaviour by passing GCC flags.
> The issue is, that this branch is always taken when the option
> is specified on the configure command line, regardless of
> whether it is enabled or not.
> This means that the opposite option can never be explicitly set
> as passing it would match the branch, and result in the decision
> variable being set to the same hardcoded value as the other case.
>=20
> Use $enableval to set the decision variable to "yes" or "no"
> depending on whether the option was enabled or disabled to make
> it possible to explicitly set the default case.
>=20
> Signed-off-by: Olivier Benjamin <olivier.benjamin@bootlin.com>
> ---
> =C2=A0configure.ac | 18 +++++++++---------
> =C2=A01 file changed, 9 insertions(+), 9 deletions(-)

I've already merged a couple of very similar patches yesterday?

Cheers,

Richard

