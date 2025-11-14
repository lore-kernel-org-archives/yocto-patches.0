Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DDACE8D76
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 20:23:17 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7730.1763151787596229017
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 12:23:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IfV7lgLS;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2d6df99c5so6953785a.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 12:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763151786; x=1763756586; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYq9RKHWYudguq+qZwrp6xscqsCTHDuWxzOHjjJV1AI=;
        b=IfV7lgLS1s4m9WkxLTeKd5nv54I23cjWqTkpmDsLPkXt3D8vC5ee5Hv8QdqbampJ/J
         rS+JAJuCNJs5JbykJ7z/5u5lF1zZLlP38UQicw/B63aC6BOPP7lyJ800VxIIhCuyTdso
         67zsootbJUT+/EuRgxKLGmE6sxaqZC4t1EjQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763151786; x=1763756586;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYq9RKHWYudguq+qZwrp6xscqsCTHDuWxzOHjjJV1AI=;
        b=WuU0JH54qj1/6Se/yBEun4z2o/lhq0GIdvS9gKwnoHLq+A8t1U6Oxg2ozWzNUGlGjn
         WKD1MSiPuEep4du8iKlsNQP2alHve05HWVjpjXVymcjUXTGFu9sLaxTU9cRbcJs103YO
         Xe/78pTXwySnX+y5oJa1cYd/S8gXNwaJdMZVKdzgyljk+S+3UkvSY9RAANB8sGzNL0fv
         /NDSh5N43HL93Hd+npb9cRI0m/i+2TvFD1pxvktwYdY7oCTl801EkAl0STlsuyE7utZv
         6IM7fL//j8ZC+emClWdWPOab17s5jDwt/LgnjTPUHBQLq9jE6wSAR+J0hBlAlHlDiSZo
         KMdQ==
X-Gm-Message-State: AOJu0YwN/DXTdvUKY/S2pA3jPkbZwqy4QiTPvLxqSCzXHlSFhbK2mrCG
	X1CNNLULUJnMFt9RgMSD1q3zQGoc+1dcyK1qv8SxTBBmE7ECkxPf/Ui8K7iWBj6nI38=
X-Gm-Gg: ASbGncvkY2WmzqK/siwsbrxaeXKR6aKd4tGjOhMiaMuXdOOlDjwf9tjZ6cwChZPx0iT
	qJCCuvvAbginEDSTzTpHmMtJ3RB7g1Ml99jT9fWJRas+1xBN6PNmXZn1N9PbKsd9sn+6sWzHRqy
	BtZw+4ADYDOzxlXuEjetzeYD9bPDYFeKVNZpLREh7cHtIc13bCjX6X7JU2avHK+0bdP/uud+Pok
	iOZLAFtfRusmHezK3Q6M4e8K1M1ITdxeyYgiDar4izNzbXjsxB+BbhD4tKWYnkSVP9Ghy20XCtB
	bsPaXuRcUBEjPujy0lB4yiz9a3ZXLMYiO177RzFVRB44jxLzv0Vp1Dq9jBDRyT82zkXg6FnOBPN
	LbDxgwgVg5nQfwcc82GOgDOCNhZWE7cYichIzrgFv7NolMN0Jwp/evb1Em3VtVV0+goM+sPh1A/
	YI1IkUbW6BbrneRx1L3Kp0lz3lUhcfnhoYIME=
X-Google-Smtp-Source: AGHT+IHCb13ruRNf4HPHFZNhJEMbFnygb0NPQ8MqN/5xfuKrjSEnxH2SsccYwIN0NZj55rNGrWilqg==
X-Received: by 2002:a05:620a:28c9:b0:8a0:2690:a1b5 with SMTP id af79cd13be357-8b2ac35ffe9mr1127566385a.45.1763151786298;
        Fri, 14 Nov 2025 12:23:06 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af062acasm401364785a.53.2025.11.14.12.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 12:23:05 -0800 (PST)
Date: Fri, 14 Nov 2025 15:23:05 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Hemant Jadhav <hemant.jadhav@emerson.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH v4 1/2] clamav: Add recipe
 for version 1.4.3
In-Reply-To: <475758.1763147781661145661@lists.yoctoproject.org>
Message-ID: <d0cc74a4-d13f-cf83-b3c0-b6b150416b33@konsulko.com>
References: <20251114154052.3651845-1-hemant.jadhav@emerson.com> <58f6364a-0faf-9296-588e-1798cb52653c@konsulko.com> <475758.1763147781661145661@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 20:23:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2575

On Fri, 14 Nov 2025, Hemant Jadhav via lists.yoctoproject.org wrote:

> On Fri, Nov 14, 2025 at 12:05 PM, Scott Murray wrote:
>
> >
> > To save me from digging into this myself, can you elaborate on why
> > upstream now has all these license files as opposed to the one the
> > previous version had? Are they vendoring a bunch of code from all
> > those projects now? If so, can we disable vendored libraries to use
> > system provided versions?
>
> The multiple LICENSE files are present because the upstream project
> embeds modified portions of several third-party libraries directly
> within libclamav, rather than linking against system versions.
> Actually, the same embedded code existed in 0.104.4 as well. The old
> 0.104.4 recipe only declared LICENSE = "LGPL-2.1-only", but it should
> have included all the embedded licenses too. I think this was
> missed/incomplete in the old recipe.

Okay.

> Answering to your next question: Unfortunately, NO - these are not
> optional external dependencies but embedded code that is integral to
> ClamAV's functionality. The recipe is already using system libraries
> where possible (bzip2, zlib, pcre2, openssl, libxml2, etc.) - the
> embedded code is only for components that must be vendored. (regex,
> YARA, inflate64 etc.)
> I haven't explored lot, but I think system equivalents does not exist
> for YARA fork and specific LLVM bytecode components.

Hmm, that's unfortunate.  I am curious what license compliance folks
would make of some of it, as there are differing schools of thought on
mixing GPL and Apache licensed code (FSF says no go, IIRC), and even
though they discuss it here:

https://github.com/Cisco-Talos/clamav?tab=readme-ov-file#3rd-party-code

I do see at least one source file on an initial skim that IMO would
probably need clarification if one were auditing.  Documenting all the
licenses in play is probably the best we can do to try to give folks an
idea that there's a bit more going on with it.

Thanks,

Scott


