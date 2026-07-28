Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19603C54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 08:14:23 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7086.1785226453827393364
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 01:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Tk4gMxmy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so34182515e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785226452; x=1785831252; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZLU1Mymbs1By1DnKrUcd+Yb8Phh4kt6HZz3SCHp1dpQ=;
        b=Tk4gMxmyxhCu8dwiM2dnf6wTfzZpg+mNSw7MlEiHMZNPEC4zK84iLvxGKwZlj+cWrV
         i7cv40ptJY0kL624efZBtJU1H3tFiO4N1fAP5G3pmI1bG61kw4o+GmezM8Hv+JY8ZpxQ
         p3u7YXrCc9Bi7OTUihY8yxAqarIO0UCLhRrjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785226452; x=1785831252;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZLU1Mymbs1By1DnKrUcd+Yb8Phh4kt6HZz3SCHp1dpQ=;
        b=oO+nrEA38UdJoO89QKGGNiJmVVLiEQ22SZuoqwRudvKZQG+nAzPtgkAZE1c+T4D2jG
         GAXz2F/niWJU9An7X96cf9e/NHemL7RZI7UZmA2Inu/eps10f+JMZTsN8DHsdb4uV73K
         uTr3OUkDle/9EnzYV6xO+MztSOn9+mne1cawb/MenHckGwmCEvTKst6GbLBlDw1oXC/h
         RfdKkXWMh1w6zsotOiAegI5kFy/EitsJslrdWS/SWyIAMVco2fckd3Y/fITO7W/Tbs4t
         xA0l/tDGCOViSJz0ThMsx4gIIKVzICzkj/UboGNGHVaH94QroZga1hCchUsyjWYADqDw
         +pUA==
X-Forwarded-Encrypted: i=1; AHgh+RrWmiq2QBLU58pl5RYCnrrE6rEyLiiPkzqJXdLCFUr/UyHttDsJdsINcyED2rIsXz88IYntADhvUJLBhmT4@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxxIP5PJeYePzj9oW1g/gQ+9YgdCtCkcufoHeUpLT2XgSHNXdOA
	JQp3xM7qtpLWVt9UoA6E6mx62chUfKgjBmx9DEJrGKXe9POBOvgwLsRI+GHk9OGvb/c=
X-Gm-Gg: AR+sD10FbpEVXD1X/O6MUVNDGr/oZlNKfis1X71jKwiQe4KS/VBc61gRV0MWPgWvfdT
	Ai4ZfMbH2UKEVj/Ui3v4eI6KHwnyTv74KI7GJpm4KYEoC5vkXRA54q2Pd1ejeK6aJ54gWbLKNvL
	tZYHMFMUUB8KFRBgqOKmN76ah+FStgJIjQDEVP1EbG3FBxBeusjJZSbKA38qIFwx8uqeeADk5Wr
	8AjTiNvRaqqR/MQqiQfiOJw35uWCHKYfRMM/xwD2/0aunEc1M3MsnG+o84741oxCUtaRp++UBn4
	w0QAlSYE26gCDEGtpcc/149i3OPi91rikyuTB0SfnifTv+VfQ0u1qdKBPjblD/wX02dh84yNlef
	JSmYpBwbUohCIMyqRV3iyrWt7EWkzcy345nGUAXrQgk51eRb+9OM7LI/sIC5XfzGWFKCW+2oZfp
	c6O3nc+ijLFxnqhjyx8Xa4A5BnOo7JuYyV8P/FRmCXdVfjYR5RNyURtb7liW8XJ18V
X-Received: by 2002:a05:600c:4fd2:b0:493:f262:b8 with SMTP id 5b1f17b1804b1-496c641e88bmr14243285e9.1.1785226452091;
        Tue, 28 Jul 2026 01:14:12 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1? ([2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45e92eesm60666425e9.15.2026.07.28.01.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 01:14:11 -0700 (PDT)
Message-ID: <3f41919cc11d28ea17386dfc8199708eead00644.camel@linuxfoundation.org>
Subject: Re: [pseudo] [PATCH 0/3] closefrom/close_range: protect every
 pseudo fd, then drop one
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>, 
	yocto-patches@lists.yoctoproject.org
Cc: Mark Hatle <mark.hatle@amd.com>, Mark Hatle
 <mark.hatle@kernel.crashing.org>,  Paul Barker <paul@pbarker.dev>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert	
 <mail@vincent-haupert.de>
Date: Tue, 28 Jul 2026 09:14:10 +0100
In-Reply-To: <20260728050815.7-1-bbnpreetsingh@gmail.com>
References: <20260718043750.7-1-bbnpreetsingh@gmail.com>
	 <20260728050815.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 08:14:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4555

Hi Baban,

On Tue, 2026-07-28 at 05:08 +0000, Babanpreet Singh wrote:
> A gentle ping on this series and the close_range v2 it stacks on
> (which Richard okayed on-list on 16 Jul).
>=20
> I noticed pseudo master has moved since (now ca47829, with the
> memory-handling and openat2 changes). I've checked that both series
> still apply cleanly on top of current master, so no rebase is needed.
> Happy to rebase and resend anyway if that's more convenient.

Sorry, we haven't forgotten about this, we even did discuss it briefly
yesterday! Mark has struggled for time and I've been juggling a few
other issues.

There were a few fixes ahead of yours in the queue, I have those merged
as you mentioned. We then have yours and the logging fixes along with
some tests Mark worked on which are next.

I've pushed your changes onto master-next where there were some minor
conflicts with other changes. I'll run some wider tests on the
resulting branch.

Cheers,

Richard

