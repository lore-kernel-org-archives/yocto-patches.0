Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C144C83F03
	for <webhook@archiver.kernel.org>; Wed,  9 Jul 2025 15:48:35 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web11.419.1752076108285992074
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Jul 2025 08:48:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZqMiubqt;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d9e2f85b51so1074185a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1752076107; x=1752680907; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V42XXYv7m09rQH/AlIWENYJyosUgiR2+jxco8z568Sw=;
        b=ZqMiubqtIPdhJ8UHRVu3+cXtBI4AcMLNQuf9mwhsR9wA1D4/jrkUVfznNYbYN3TMts
         Dw2EVi+8GHEO035/HknBDwQkM9biB3Jsp5Uw7VtJCaW3v9YmK0n4bcLWcV4/K9ybQ039
         GY042wrMi3sPi/flgoY7kZOlBsOXbg8cT/0wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076107; x=1752680907;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V42XXYv7m09rQH/AlIWENYJyosUgiR2+jxco8z568Sw=;
        b=ZXx1mpVjyQOP2Z2B8TBzBTK4gBDqh3gArhUzMLZpameyCLXbD82btmeD5Gy8sfe7B4
         boHGP8bKxh68qaLh/JUikkswEVzNmpdLNj+GiVjGNvc8hHHPcPe/Lw8fBVAKYDc4cOCq
         Pk+/4xuEwkvELWhunk44Ke47agmW8FWkr+l7P/3IUHTzLyem53I+mgwOtMtzWMx3Qflx
         +riw3E+LtsHTjtus37p6qbNxcFI6ReUANvPh3SIEqZ2zb0wSZ7fDmOdbEn9Zgq/Iizi5
         hgGhwezXcw6ntwmyrBTsPnc9qfMeW5HY/RfUJH0dXRaDM2uJ5XSLuEtFMuULbnpSoKWj
         oUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSgBDo/n3Ceidic2UqHPoKWKQlTKY1p3ACC4rLNgJA1HZ29KFrkWZgofmclz3OKJzaybYUNj1he3XA0y1C@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwbVYIqtavghlToi0MsR3mKvTqYgvvW0U9B6lU5h+xPpa8Fro3V
	dFUvC1wN75WpHWwW5tPZcfkgFOxoMZdmZl51fm4jyTkirQAskdnvoE9tC7sPYx8gdVQ=
X-Gm-Gg: ASbGncsU1TVuEI9JxT+Snnn9CC6ZWF/cikG30Lfg0D88VGNPxPm8ruAGCN+ccnAWMr0
	rBcbmpdAikWqoFxtoEIZwh3CApNuvLJZdG5pdhGneCKO90+AemytK/PhAm9dQLFsFIE+AOn0iEI
	WkoYKOjjAZHy5ov7HSIBJhxRI4FhTrXkBS2h/9q3OikXSq04vXG+e17GAAEKEYNl09opdakwZU5
	bwZooxV8lXpvGdNBjdteklF6bUL5L0qFSPsrD8RyZWeELfL854UG0g4KLKLnaL0oJsXj7WifbT7
	Jr8mTw62Vf+XJEc2dpxp9ljuKkRah5GO4F76g5sQymYXfFWt0ydu1boApVHoeSdPfJSSfsSl4Fk
	Lejf3otvfGzkDMA6r/8IZ
X-Google-Smtp-Source: AGHT+IHObrtD4PikRH5foyk8+rF04ahdEFocHGt9B0WucEGImvBPxj3jqtOe5WabebenugQ708T0AA==
X-Received: by 2002:a05:620a:4510:b0:7c0:c469:d651 with SMTP id af79cd13be357-7db7e15338amr389339985a.57.1752076107057;
        Wed, 09 Jul 2025 08:48:27 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeb2052sm952002785a.106.2025.07.09.08.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:48:26 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:48:25 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Randy MacLeod <randy.macleod@windriver.com>
cc: Yash.Shinde@windriver.com, yocto-patches@lists.yoctoproject.org, 
    scott.murray@konsulko.com, Sundeep.Kokkonda@windriver.com
Subject: Re: [meta-lts-mixins][kirkstone/rust][PATCH] rust: Fix DEBUG build
 segfault with p384 crate on Rust <= 1.85.1
In-Reply-To: <a2703f2b-0c6f-4180-9395-e0e9c60cd0da@windriver.com>
Message-ID: <1fde4016-2fa0-2b91-4024-7f84caa430fd@konsulko.com>
References: <20250709072014.1978605-1-Yash.Shinde@windriver.com> <a2703f2b-0c6f-4180-9395-e0e9c60cd0da@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 15:48:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1796

On Wed, 9 Jul 2025, Randy MacLeod wrote:

> On 2025-07-09 3:20 a.m., Yash.Shinde@windriver.com wrote:
> > From: Yash Shinde<Yash.Shinde@windriver.com>
> >
> > Backport a fix to address a segmentation fault in DEBUG builds when
> > compiling\
>
> No, too much of a change.
>
>
> Sorry that I wasn't clear, I wanted you to provide the two line
> change that changed the debug build into a release build.
>
> Scott,
>
> Will you take that?

I prefer to take changes that are straight backports from master, but
I'd consider a less intrusive patch (i.e. the 2-liner you mention) if you
have a real hard requirement of supporting 1.85.1 with it versus being
able to go to 1.86+.

> At some point, we'd update to a version of rust that has this fix - 1.86,
> right Yash?

I've been a bit busy, but plan to try backporting the 1.86 and 1.87
upgrades to the mixins next week when I'm back from an AGL event.
If you're okay with waiting another week or two for 1.86, that does
seem a better approach.

Scott

[snip]

