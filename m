Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB91C55822
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 21:14:08 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26953.1785878041067256037
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 14:14:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=co5ArRJ5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49802c418b5so2319485e9.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785878039; x=1786482839; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=O0ul5fXv0qy/ENB5VK/kQE2F08QrtJz2BhOgU5ffFCE=;
        b=co5ArRJ5KWzX9kgPH6mnBnP0SJJTvQbwUZfLMVqFOZhikOiX+gfMb9UQGyWJQpHo4B
         f28HfmtH7pwPwmYkdgNFs4qkXvFEBPV9KgOYPZw3sLz1S6WbsQtJbPXj3G6C3VNVwsWf
         489MTK50L3IowVKeKRdjKL3v7mTWReAnmOP7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878039; x=1786482839;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0ul5fXv0qy/ENB5VK/kQE2F08QrtJz2BhOgU5ffFCE=;
        b=Q40aXF8mhSuEDiYrRWc7wTMN841BxdTUeWJARKQ7tM54t3Nb95HBazb0WA01mi6ylJ
         SJPPg14pf8QJK9L7hvIPENFt2Fsno2yV8K3mOSYMhEiwEHFimDSIDZsorEz7X7ffpYUJ
         keiPDIgEAX4uL4tZZb5eAQ6pfHxxIqHukBAoCy/zTXDSOXLbyinRU8UUuLDxOV4HCJ3D
         E287dtvpAesPZWXKWRjeZ8JmupVwEO68P/9gq21lDZc7v7iaw3dOJR3yiIoaki2eVYU/
         eL3kVvDwFbREyfrN+/pFfkDTZrijByRmVIy0qqqMPk7Fma/4xRsQEdt/qjj1dYgWsgm6
         khSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrszDrZ+b5u9YDIuDaZoOFolytt10ACSNueJu2tnr9+zU1PPHoVuYpDMvR21cYINlXDIOCFOF0DZhYzzdKT@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzVO2B5xti3M+wOGtV38TLQ0/FtTS9tKI9MxhTXOvW5TlNCVhLx
	wWJqwvyDUNZ66nV3NWlnQWIx2zFfDHhBMtKxc+pYTFZKryu0rcaNoIlcYdI/cgvpz2c=
X-Gm-Gg: AR+sD12aynt4qFobHefTFuU828ObBxmenNPrcVXnwxU2GltTi6cTpDhxrPNj0kuf9LN
	RFXrlXdVeGtakFwcwvnHuZpe/3+vKfHgij/Qw3JRTk9OHaP9CcldsFY2L8qu9elrxIyb79BOQxX
	uv3H3k4sS0eqPa5foUdkzo5ozq2C7uIMJLSiLTtB6wswE2QAjc06lkvlW3zYXsPN9xB9Si9N8Af
	ebRvfEhi07qqk6padXGFc9vVCTyLIpVbocPhKGnuxEDunS6DPrldN2S03Ce7a1q6oXk7m3Kw/Oy
	T9Y+lz2mxJsoBs2b2YYRgLbMbNlLXTulr9kXLVpnc+M8mvJDMB0W38G6fSWeLMEx92ySNzRxEed
	xa72RQpHf4868iUk2wtnfpyuNCx1vhFDeL5vRnyqrhmBAUSxRRLVutNfrm7CKI6JStLGY9aaOpm
	4Qj4F4Tft/y5GSB8Pgy4AkdK3iNURArIu46agShF0VTu/7+2clBrFrWlXfvIW/AzJ3mQx6zODeH
	D4zz1OxMEbl3Fo7FYBTCyYPxn6vQIuXmXmgZz94WP+Urb6I16Y+/g==
X-Received: by 2002:a05:600c:4ed1:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4994e70edb5mr13619025e9.3.1785878039218;
        Tue, 04 Aug 2026 14:13:59 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:cf1f:6744:c6dd:c3ab? ([2001:8b0:aba:5f3c:cf1f:6744:c6dd:c3ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a101ac9sm112643325e9.15.2026.08.04.14.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:13:58 -0700 (PDT)
Message-ID: <92c180949cc82cbd9025c7673c2ffb8a43896fda.camel@linuxfoundation.org>
Subject: Re: [pseudo] [PATCH 0/3] closefrom/close_range: protect every
 pseudo fd, then drop one
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>, 
	yocto-patches@lists.yoctoproject.org
Cc: Mark Hatle <mark.hatle@amd.com>, Mark Hatle
 <mark.hatle@kernel.crashing.org>,  Paul Barker <paul@pbarker.dev>, Randy
 MacLeod <randy.macleod@windriver.com>, Vincent Haupert	
 <mail@vincent-haupert.de>
Date: Tue, 04 Aug 2026 22:13:57 +0100
In-Reply-To: <20260730050730.7-1-bbnpreetsingh@gmail.com>
References: 
	<15f732196c35cafae077a46b2ad4b88ae6191630.camel@linuxfoundation.org>
	 <20260730050730.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 21:14:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4624

Hi Baban,

On Thu, 2026-07-30 at 05:07 +0000, Babanpreet Singh wrote:
> Yes, that's fine by me, thanks for folding it in and for redoing the
> commit messages. I see the fd-protect patches on master with 1.9.10 on
> top.
>=20
> I've also read through the close_range respin on master-next. The clamp
> and the OP_CLOSE_RANGE exemption match what I reproduced here.
>=20
> Sorry the __open64_2 hunt cost you an afternoon. Happy to run the
> close_range probe and the OE reproducer against current master-next and
> report back if another data point would help.
>=20
> I'll add a note to bug 16339 once the close_range side lands.

We're close, we just need a new version of the patch which makes
close_range and close_from use the same OP call within pseudo. Do you
want to write that or should I?

Cheers,

Richard

