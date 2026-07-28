Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE51C53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 10:48:27 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8667.1785235706471921401
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Jul 2026 03:48:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O0uB9wy1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso24236625e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 03:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785235705; x=1785840505; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ITXqnXAT2c1ZGP6PfuPu6J0TcTqMEosKvJVFLXrHmrI=;
        b=O0uB9wy17rTghrDSb0AYfsogbWMQ2ySnWZsUXi7KDoyYRZl2BtbkHnEkLVnC59z8by
         HblO9o56sy6GS9lJ2Tkimb7J02BgBM9lEn/qy5WqNXl3cqW13bxTeR7nUGrCba1En7kK
         edj/GCt8P1u9CEQhiZJL/5sZ4fEHCa39IdNB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785235705; x=1785840505;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITXqnXAT2c1ZGP6PfuPu6J0TcTqMEosKvJVFLXrHmrI=;
        b=ZeAcw0IA3q4WszFvQ4YZ5vb/uNHrfR6+tUdgpFgA/uPt2DjkMVE5jMLJu5gPMSefD2
         tvRK1aHOWBqnV+6Ch1IZnk1E4jAXsCvUQ4NqObhp0RgW94/Bvd3hL4cJZan2NX5ek1mY
         e+/v4KmfiSuG8VhrSF2YjCjuaPZoSx5q9wClMuxNZU/iw0X7kFXFeheYqWux0Unb33zN
         1+BrIum5CV38w3YrnPh71OozK8blfmqtwFSLshLMD8HiAdl3yIogz1CVhMZwhbZNgO1/
         nKDZjBVnv+M0PNjX7cDwTmyDDgtH8AaQjJI9o4W/8JYwoujlBb9Nljb2CoO2u5KRtTSz
         ctdw==
X-Gm-Message-State: AOJu0YxEOnMcXGXABvfWgSUnITqgOx+obU7K25nSzxTMjZleKlE5cN0X
	NIBy0sgqOZ5SaC8Smnlqe26BWWMb7sA6HaAnTRyO3MjNBn9qDcpWBh4Ob6JyVI2MkOWdTICi+hI
	lEy/swNw=
X-Gm-Gg: AR+sD13f9CtNwzKmdzR3GqNEoTZoqPH5PVAVjqlGsXe5jRSa7zYlY1D8JSQZJxf47U4
	BsDB+NHQB6L57CUTC7vz9EOCwLahZREaKssacoVJ+DFF3GizrBJl5RwOjawDqbkMqqDiss/N9OD
	f3vmyS2IWhZFu12V8ebYDI0Ei+fsVoCqVl6N95sFh/JybgnY/K5jG7zqK9t45fRJRo0IhA6WQqe
	5+rL+C2fOvpPEpJCdzAq7IqMygl5WZMH7BcyJ8XJ3vwj78ikvStxrimxN39BLZp4jeX73TjeaTO
	S86hc8RXmdp2G1qUvXbcpWraceOL5iO/kSFmot3a2dt5cbshFXknAwwL3Oqmm6banJGqgh0+IUC
	ZaByhRyeRDMaMyPjZDR9rNrRH7CzgrkEc0jiMLRyinSTZN8GKkUfi4Gk24WyKGF3aAClMr1tApo
	BxYqMxKzO4eOzb4gr18IYmYIZJo7nMwkcK1CucCwpr5Cbc1igxRzZH+ozvobOv0PwZ
X-Received: by 2002:a05:600c:4504:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-496c93d0e44mr7142485e9.15.1785235704690;
        Tue, 28 Jul 2026 03:48:24 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1? ([2001:8b0:aba:5f3c:901:c1b8:a3bd:87c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957d41ed1bsm258107895e9.2.2026.07.28.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:48:23 -0700 (PDT)
Message-ID: <a5225693f4c1f4d2066f584cff289f615d2ac406.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH v2 1/2] ports/linux/guts:
 Implement close_range() instead of returning ENOSYS
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Babanpreet Singh
	 <bbnpreetsingh@gmail.com>
Cc: Paul Barker <paul@pbarker.dev>, Mark Hatle <mark.hatle@amd.com>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert
 <mail@vincent-haupert.de>
Date: Tue, 28 Jul 2026 11:48:23 +0100
In-Reply-To: <18C66CA235EABC94.3010641@lists.yoctoproject.org>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
			 <20260716055633.7-1-bbnpreetsingh@gmail.com>
			 <20260716055633.7-2-bbnpreetsingh@gmail.com>
		 <18C669BEC7E582E7.1643407@lists.yoctoproject.org>
	 <18C66CA235EABC94.3010641@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 10:48:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4558

On Tue, 2026-07-28 at 11:15 +0100, Richard Purdie via lists.yoctoproject.or=
g wrote:
> close_range(3, ~0U, xxx);
>=20
> Whether we should just force maxfd to INT_MAX always, I'm not sure. I
> don't think the high fds are usable.

Checking into the kernel, it would never handle fds between INT_MAX and
~0U so I think we can just clamp to INT_MAX for our code.

Also, I don't think pseudo needs both OP_CLOSEFROM and OP_CLOSERANGE.
I'd propose we just add a max parameter to OP_CLOSEFROM so it
effectively becomes OP_CLOSERANGE, I'm fine with renaming it too. We
can then use it from close_from with INT_MAX as the upper limit.

Are you ok to tweak the patches like that, handle the type conversions
safely, add a test for close_range(3, ~0U, xxx) working (with ~0U) and
then resend?

Cheers,

Richard


