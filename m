Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28785C19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 13:30:39 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web10.15310.1740749433618615778
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 28 Feb 2025 05:30:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OWx3oLGi;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4721325e3b5so16215441cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 28 Feb 2025 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740749432; x=1741354232; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zT6EFRJ6QFaS9Dgl6CZh2oPiCEjD+LiXxGjlL10YZxI=;
        b=OWx3oLGimbErbNB51dj4KpDTDGiNcMUDIMD/YA+lnjNCLa5tSXK1JnvGXtOv0k+cau
         K9qTRm3ifsZSFzQVhlwUvZfaOeU6L+VL2doGW4fDZPaOslsmvbjeW5E/hJaumfeKTyD7
         uyoivVVOdR+U9qBB7/3DM1YRGaHWM+3zyr+F0g4CM5OMWqtZyA56kN4k5gujy/pzUNzP
         mFNyGYVRKJvSTB/ZEJSiRq9vB4c/Jn2mODMrE8TLtAh4d+2jZU/TrX9m82zLo5YcQB2C
         UCqyNVulgEHytFXTsu9tA3Y7eds+vLkNSOsrCYj7X47FGJleQKs5Bin/DUhzqe9v9/1u
         lCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740749432; x=1741354232;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zT6EFRJ6QFaS9Dgl6CZh2oPiCEjD+LiXxGjlL10YZxI=;
        b=aEpgUWUECr91CUW5YvKv3LGYuOKCFp6001QAKVy6WWFKBcatP8ifkEBYQjZ6nq4f5J
         TccFy8bH81nREtVhsKy6FQD2/iGgOD0IxLirUCZRWth+v4vjufrs0SdJ9V2Pe9ydwmP8
         6ePYLGwIXEvTKq0eB5euC3W9BgjEZFhqaKRZyk+7hR9R6S6H9YpsmQgCMpHD+76Mv06g
         L24qbbY/GBUFqsrot4ghLESDISUKnUy/EYPO0fxm+iqWy4W5UYs+j/LVZSqhVPqt+kD8
         UWaTSFYrMo2l1nzgaSHidLg7f6E+RNbwBnSAorov10kgmqjFw/EQkaAbb+0sEe4kn2fr
         3h6A==
X-Gm-Message-State: AOJu0YwMM3Iz3VkU/GNbDGvS/MYEb6A9wcSbPAxKlrB1+d2e9qcO3Oxn
	t7iiZ7lEqmkBqEO6o3Ke8dglu6PkQYkZjmkHTXHm8kr10Q4haaDfk8JxJUE1
X-Gm-Gg: ASbGncvgTyvlj2IUUrfaoxlI7nUpH+mcGgbl2sNLq9jYGDkXH3Gn5MPjRaOqdJeJGUU
	XI314+kgxq+0cWv11yhSOcvnKmDiLARr1aWW1KD3Y0jfWZbH1NGAfjVCe7fnoL0VoZiV1QSfs4I
	xvBuXKVciXmQXUGY+PJKB0UY5KhBLSE/84Z8aWxWZ3nM4hvXQAGIoIs7UnRsKSritTat1dSuINO
	5KIcwI8zcHeFbNVrR0mhwwQrD5aSfbEknjKc0XZeBimIy0V6y3BasARZhvMjoGyNdXfB0BM+5XD
	DuHKoG191KCCivSl9XCm2Z1upc0yJYQU/X7/3QtYtriHqKOUGcbvsw==
X-Google-Smtp-Source: AGHT+IElCQFZv0IK0OUFXLLcuINNni7jCQeCT/+W/t73kjzzX1ECtsWdGOuSFNxH7AUwH0NUjx9U5g==
X-Received: by 2002:ac8:7fcb:0:b0:472:1512:c601 with SMTP id d75a77b69052e-474bc0fe9a9mr33576061cf.40.1740749431718;
        Fri, 28 Feb 2025 05:30:31 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47472409b3dsm24665661cf.59.2025.02.28.05.30.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:30:31 -0800 (PST)
Date: Fri, 28 Feb 2025 08:30:28 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] rauc-conf: set arch to
 machine
Message-ID: <20250228133028.GA1093@localhost>
References: <1828187512D580A8.767@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1828187512D580A8.767@lists.yoctoproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Feb 2025 13:30:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1137

On Thu 2025-02-27 @ 09:55:29 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Since this bbappend is modifying the rauc config file with a MACHINE-specific
> search-and-replace, the architecture setting of the package needs to be
> MACHINE-specific as well. Otherwise if multiple images are built for the same
> SoC, the sstate mechanism will use the first-built SoC copy of the
> rauc/system.conf file, which may or may not match this device's MACHINE
> setting.
> 
> At runtime this leads to compatible mismatch issues:
> 
> 	# rauc install <bundle>
> 	...
> 	LastError: Compatible mismatch: Expected 'nanopi-r2s' but bundle manifest has 'rock-pi-e'
> 
> These errors can be worked around by using the "--ignore-compatible" cmdline
> switch to the "rauc install" command. Or can be fixed by updating the
> on-device /etc/rauc/system.conf file and restarting the rauc.service systemd
> service unit. This patch, however, is the more correct, build-time, fix,
> rather than having to fix the issue at run-time.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  .../rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend           | 2 ++
>  1 file changed, 2 insertions(+)

Applied to meta-rockchip; branches: master, and scarthgap

