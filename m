Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFE2C7EE30
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 14:19:53 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.web11.9248.1750947591348836713
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Jun 2025 07:19:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IlS1oqjX;
 spf=pass (domain: konsulko.com, ip: 209.85.219.48, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso11247856d6.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1750947590; x=1751552390; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0se/5/BW0PCEhIousUGh8U1PtIHchBpmcrp7ZL+h0r8=;
        b=IlS1oqjXs13GGbmdivF0itPpFE5QMY3lYVVwW/GSwjU7h4EdUJciRg+1udhEKkGMVL
         8aiPZ5u8YRaL28jxBHs3LKcB3Kh67nL4f+j3hIa9QZ9jjHYPO+YqX9+TB8wSjIMjNtNd
         YgFsYdrywJ2EDSAxMlCtVjwKBZ4+brfoS+vk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750947590; x=1751552390;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0se/5/BW0PCEhIousUGh8U1PtIHchBpmcrp7ZL+h0r8=;
        b=U5jPfHy0XMqSKn902IF5pb2Sjs+c/b99xjO1UO0deAFs5ssKOQYRF/Qe4yybFAOGrC
         NHJXz2LSqdncbJWbG/sAPRbRmCe9lrb2wD+W/rqlQi7bVNb3boKTBtNemE9EQGUuNjDk
         jc6CqfS+aSjThz8xozg2lVxPlqOkSIxcqOSAROD5DobPg2bWMMAB70/vGPAEaTPvSB2u
         qThtr3K2NVBj2EudiZAFuFR3pwuvVX0DQRQYB+kElCRos9StLfjv2Sg5z8Mlvqc3LPJ4
         tQMMLZz1UAgbElj1kU9EAFXdWdu+o8/5LsZOMnTNDD0VsMe6Kj7o01CBQnA+Y9Mdz0vq
         zhYQ==
X-Gm-Message-State: AOJu0YxVYd/Jeb0FUy9dW5f6JSwJpnOpMiIwUEGHL1mBrpF+4McdeeqS
	GQVXdKAeb2D6lqFvO7izEDkStqoRIakmp4HR+Mtg33kpCAe/vZoiE3GKKybqkJ4OZvi8pm3PlPe
	0CG8s
X-Gm-Gg: ASbGncvQoJ5YipWAfV53BU9+vewJ7Uun4kmulZaQWofBl5Z9nrUhJjyLWRri1a510+r
	RBp9FdvKzl5jnAI5yzkarCJwyiVrW+yQ6GDWc9+NzjX4/ca+WFyjjH2PvFzq80S+P+U82Wex9hs
	g/QZKhQhspTDuSjYz98uXNcXVmJVa6EtSSBoWbMqhozQnMcVEctQ8MsoAlwk8s1pwgioBphw282
	SnA8KYIH0B3adftHhWIjRZRouYle2xQD3uqLr4TN5idHJpbLEekBrQuzOIV+hoklpXMTXpevo4C
	gI+Gn8+NeybTfV2txoUw5WBHnYVNinFKonU0B85iVqzS5AAi/GiksnXg8y/fJXFeyAkPYjhMdLs
	KOlCB3yS7uhY32NkCES6t
X-Google-Smtp-Source: AGHT+IFiqwfwIWWQQ/8L+skluK/WSbdDy8iB9n4Ousy9HDaEoTvgvsIHYWDXWIqy81rbOnhb4vMG5g==
X-Received: by 2002:a05:6214:4520:b0:6fa:c0ca:ba70 with SMTP id 6a1803df08f44-6fd74d0d183mr74830006d6.42.1750947589910;
        Thu, 26 Jun 2025 07:19:49 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d443223d15sm4676785a.85.2025.06.26.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:19:49 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:19:39 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: alex.kanavin@gmail.com
Subject: Re: [yocto-patches] [meta-selinux][PATCH 2/2] Adapt to UNPACKDIR
 changes
In-Reply-To: <CANNYZj8hvFiu4774qYFkBUu1NCiX8wLtOPnXu8hFb3S-u4SnUA@mail.gmail.com>
Message-ID: <fb5c3279-262d-2874-d537-6789688538b0@konsulko.com>
References: <cover.1750882005.git.scott.murray@konsulko.com> <848dd8066de86d3feeb520ef49e902548743fcdd.1750882005.git.scott.murray@konsulko.com> <CANNYZj8hvFiu4774qYFkBUu1NCiX8wLtOPnXu8hFb3S-u4SnUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Jun 2025 14:19:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1700

On Thu, 26 Jun 2025, Alexander Kanavin via lists.yoctoproject.org wrote:

> On Wed, 25 Jun 2025 at 22:10, Scott Murray via lists.yoctoproject.org
> <scott.murray=konsulko.com@lists.yoctoproject.org> wrote:
> > -S = "${WORKDIR}/git/libselinux"
> > +S = "${UNPACKDIR}/${BP}/libselinux"
>
> This is correct...
>
> > -S = "${WORKDIR}/git/libsemanage"
>
> ...but how can this be correct? In the absence of S in the recipe,
> default S from bitbake.conf is used, that default is set to
> ${UNPACKDIR}/${BP}, which doesn't include the 'libsemanage' suffix.
>
> There are several other spots in the patch with the same inconsistency.

Those recipes all pull in selinux_common.inc, to which I've added:

S = "${UNPACKDIR}/${BP}/${BPN}"

to avoid the duplication for all the recipes where the subdirectory
matches the recipe name.  If that seems too opaque, I can mention the
change in the commit message, or if that doesn't seem enough, I can
change all of those recipes back to defining S separately.

Scott


