Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1339BE77198
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 10:06:07 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.17061.1736244362152340535
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Jan 2025 02:06:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=ZUHsIh/L;
 spf=pass (domain: linaro.org, ip: 209.85.167.51, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5401c68b89eso18552851e87.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 07 Jan 2025 02:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736244360; x=1736849160; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GPGUufHQ0UPz3VhTxikpQ4+sruRQbw8B2zUR0lrygPY=;
        b=ZUHsIh/LdavPkAucjXrY1rO089oIzujBOsWtR/kbURkspRVUkht5+KG5twdAlQm74f
         7Q/YdijM/lNuOQNJmhh1yFYjhUZEFLBJQmLOFT7STFVvsgrOheA/m8R+YlOZD4DdcG0+
         BYo77z4za9AvPCjhw9fo/8e4Ru6U44xC4+wx4l9/gfX4Y6AtdNwBOT21r3GYKka3Al5C
         K/7T6RABuiPSxdNVzbjEHLlnQA/TY07yMdRcHXShQUtDojcs8Mx8OA4QTGs0WkOHlcdq
         j6I4dKoKX09qPmLC0M2YR3NUI+n7r51u2jyEXZPFkGDimyQBRmmTEDS6xiqE5MB0r6bR
         yJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736244360; x=1736849160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPGUufHQ0UPz3VhTxikpQ4+sruRQbw8B2zUR0lrygPY=;
        b=t9KbsOYzfgANQUDOsJRvsbdTSaiCRUdhh4t5xEEYTV1fBzbOcrP3KxLtpPauLdXI+C
         529jEaqPmFpk/1JSQFGQPeC61FvWM95T1zG7GQDz7Wkuh+jqd7I5G5HujPfC3cKMfT20
         U2MJxKi21d5WhEHwqYdmu1FKv3Cr5xYj/ajJbF2VfG/CD0hEC/jcvtTWc6fZxZEerHXk
         SkydDRP3EgFFlP79mcNEFZncg1NKZnOTKIYNI0hwJT+7CaspA7xUvMSLSbSMiKgXUFij
         3B8X30NqDUp68eYtCFxVYZFckJjriyWdBGVhnFKOeIX+IpJ5K4akdFyvOX3MmN1Fmx1V
         cokw==
X-Gm-Message-State: AOJu0Yzu8Fx/8yEiu/ICQ6lBZzR2hIKYOa+Bwg86XGPHLfqf9B/WJqFC
	hFoiCBKgkHZWSaP54m11Rl4rTQ6e0B0gfgMEjQUD5hEdYEme8CfhHC+9w5XXWe8VOoz9KV13+kR
	7
X-Gm-Gg: ASbGnctDigtLv4zUiZCQt+7w6XoKqaZdg3VteHu0tCuRKRzlEKtSwoB2rRKwAStwbji
	orAjUozLWFK686CSpUwDZGj02TKSwRwbabyXxdRHhOUCrnS1L7tOSU8bMo2Yn2opRvnn+0nrDBd
	rWPTCQQx4/q+IspQn7nrLhgLJ2guPhJShRJ60ZRpRIKNFHVKZ/nvK6ykYltueQ/8lffME9HBx+D
	/3IALwQ4fS49DFBN2N0uM/keynZG9taGp7on7bvPx8hNiNaNZ9j+lasZqfMNyOAcLzlwjUdKpEQ
	iPf6Vg==
X-Google-Smtp-Source: AGHT+IG1usRFW0nd/mwQWtauQ3OlNzZFzs97i5LHkD7omTiWTbcZTkyHN45nhlxiT+3xI3nSBQzxxQ==
X-Received: by 2002:a05:6512:3512:b0:53d:f2e8:b37f with SMTP id 2adb3069b0e04-5427e96328amr511507e87.6.1736244360235;
        Tue, 07 Jan 2025 02:06:00 -0800 (PST)
Received: from nuoska (78-27-76-97.bb.dnainternet.fi. [78.27.76.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223813848sm5226844e87.166.2025.01.07.02.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 02:05:58 -0800 (PST)
Date: Tue, 7 Jan 2025 12:05:55 +0200
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg.sommer@navimatix.de>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 12/18] systemd: enable TPM
 support
Message-ID: <Z3z8g79Tq7Sg80em@nuoska>
References: <20241220140441.271395-1-mikko.rapeli@linaro.org>
 <20241220140441.271395-13-mikko.rapeli@linaro.org>
 <cdqveqfiivyicrtsjzbnlxopvohsbxuybabhwdntygisoc4pz2@tnbgemicyfef>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdqveqfiivyicrtsjzbnlxopvohsbxuybabhwdntygisoc4pz2@tnbgemicyfef>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Jan 2025 10:06:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/970

Hi,

On Sun, Dec 22, 2024 at 08:37:05AM +0100, J�rg Sommer wrote:
> Mikko Rapeli via lists.yoctoproject.org schrieb am Fr 20. Dez, 16:04 (+0200):
> > Enable "tpm2" support if "tpm2" is in DISTRO_FEATURES.
> > Also enable cryptsetup, openssl and repart features which
> > are needed to use TPM device to encrypt filesystems with
> > systemd configuration. See:
> > 
> > https://www.freedesktop.org/software/systemd/man/latest/systemd-repart.html#--tpm2-device=
> > 
> > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> > ---
> >  .../recipes-core/systemd/systemd_%.bbappend     | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644 meta-tpm/recipes-core/systemd/systemd_%.bbappend
> > 
> > diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> > new file mode 100644
> > index 0000000..82b79ba
> > --- /dev/null
> > +++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> > @@ -0,0 +1,17 @@
> > +PACKAGECONFIG:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'tpm2', '', d)}"
> 
> How about using `bb.utils.filter('DISTRO_FEATURES', 'tmp2', d)` here?

Yes, this could be an improvement. The end effect is the same.

This patch is already merged so I'll try to remember this in future updates.

Cheers,

-Mikko

