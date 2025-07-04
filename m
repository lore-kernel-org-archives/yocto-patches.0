Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D641C8303D
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 14:05:28 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.13191.1751637925813410831
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 07:05:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZAQivaSp;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a5123c1533so448627f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751637924; x=1752242724; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxGxu5y4Mi0pT3PRC8wm4sb+eAW4Fds3t1wJaaxYY+c=;
        b=ZAQivaSpp47NUfCIjv3Lxl3AdhFdPZ8DbdhnZNkdJQz1CtJ/do1J/o7zqdpLHkh3n8
         6qljmhvdKimk5XLO2ooy2SUjbYXY/y5H/ddoMoPoLCrlHcf7foXiN29AnGuK+9lJ3Ylj
         g+H04NSOp562SQp6PoBnr96gapGxbkwdf9xKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751637924; x=1752242724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zxGxu5y4Mi0pT3PRC8wm4sb+eAW4Fds3t1wJaaxYY+c=;
        b=AF4fVj5r33b9MfelUB+h/CiOvLuKslmIhRpSYR7VIkT3I9xWsem4cH1fJAGkmNb/8l
         xSDen77re/1mqOjalx9Yus2wfc4AjmF9DmIEq7ECvMipxsKzpBzxyicULbka0YryW/QC
         hIKFOrFDnTNmJ5MGpn5eCUeZIzsrlq1ywDwHri+Hq62VxGu2JWDh3fn6C0J6dHmY/vsP
         MtprhYgDn6uVHQ/o8VJm6d9JTDfG0tSuVDJ61EojXsd+ZAn4TaKduDRPun02VjrtVubP
         koLuAREDoXDX2AuSi78l5kUqIA5bAeCGx7iBfpcr3pmZLa+/Tz6cOTq0AGDj6mbBefsp
         9vbQ==
X-Gm-Message-State: AOJu0YyG/I1cyCSttVPrwQwSOlFCJJR7gLQD2CJlUbKN0nxdH6fysctK
	gE6y6QXtzZo/3rF7jbuW64LPTy0prJAZQcXGgQFlMs31Q73OULLxNZwTnnOW/RRTZgAGhxKzUts
	Gumrz
X-Gm-Gg: ASbGncsVn2jGRgf7soVN7agjQi6cXraj84asntofPy4UANY+a19dtA2unFpS0rinf2u
	62BLjy0pUningLAitN7gXtmOD0CvWBg493U1IR1eS3/cgdz2P0A4Oatw8oj1VXogXhzZ7kYnY4y
	BZ2euXRS2+nbwLTy4QBrYHmQRzEsm7vx4kUBZTDpO74tlXh/PL4nS/GVxg0EpaHkxsMD5X6VaiZ
	BZp0lHjeBiRAYbKdMIFT6aDYCwNno/Oh3VxoP1BhxRgBwAO+nRSnufvsVll4C6pIwgNUXOxvSqY
	gh5jNzFv6no6uM7AR5/ESpM6e5FrJ2a6g2LLL2IUPpQvMItMvMF+z25ACJDKKFeWiW4+o+pqa6P
	nv/kyRp+nl2jhVqGFkfBNKRy52dbt0WPzIAU6f4awrkEgBB1aJpg=
X-Google-Smtp-Source: AGHT+IGHyPRBnFpyhusqmg2nW/D8+1w/o45cbsyr14VhYmq+eYQaGCesyl6aZAKRi3PEJ5g5vcJ1xQ==
X-Received: by 2002:a05:6000:2087:b0:3a4:ee3f:8e1e with SMTP id ffacd0b85a97d-3b4964e5281mr2414741f8f.39.1751637923314;
        Fri, 04 Jul 2025 07:05:23 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:6ff3:dcb5:7901:3609? ([2001:8b0:aba:5f3c:6ff3:dcb5:7901:3609])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c6c9sm2538953f8f.89.2025.07.04.07.05.22
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 07:05:22 -0700 (PDT)
Message-ID: <de08503fa719068700339deb279b538fc3a54abc.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [ptest-runner][RFC] Implement ptest-runner to
 match previous documentation and current state of run-ptest scripts
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Fri, 04 Jul 2025 15:05:21 +0100
In-Reply-To: <zPYp.1751544122388050827.FCRW@lists.yoctoproject.org>
References: <zPYp.1751544122388050827.FCRW@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 14:05:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1751

On Thu, 2025-07-03 at 05:02 -0700, Erik Schumacher via lists.yoctoproject.o=
rg wrote:
> In my opinion, a ptest-runner should work with what is already there.
> It should parse the output, looking for lines starting with "PASS:",
> "FAIL:" or "SKIP:", keep track of the test cases inside a run-ptest
> script and should output valid junit.xml files.
> =C2=A0
> Therefore, I implemented a proof-of-concept drop-in replacement in
> Python3, using only built-in libraries. It's about 200 lines of code
> and does all the above: Finding and selecting run-ptest scripts to
> run, parsing and collecting stdout, analyzing the results and
> creating a junit.xml file. Some work is still needed to fix minor
> issues, but with this message I wanted to ask if you are interested
> in this re-implementation of the ptest-runner? And if so, how to
> proceed?
> =C2=A0
> [1] https://lists.yoctoproject.org/g/docs/topic/113728319

One other data point to keep in mind is that ptest-runner was written
in C to minimise dependencies. I appreciate you've only used built in
python libraries but it does mean always installing python onto the
test target, so missing dependencies on python would be difficult to
detect after that.

I'm therefore a bit torn on which direction is best.

Cheers,

Richard

