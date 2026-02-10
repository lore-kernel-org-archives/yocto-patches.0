Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0995FEA3F07
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 05:35:52 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13944.1770701743818207525
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Feb 2026 21:35:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BOWeYmxt;
 spf=pass (domain: gmail.com, ip: 209.85.222.169, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c9eedc2363so535254285a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Feb 2026 21:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770701743; x=1771306543; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgjNW2qgUWYgRDKDWhlKkcI5hH4YninsNTFbctR5hsg=;
        b=BOWeYmxt1cMz7xKteG6kIPAGYNyrD2iHdRtbFpNdL+g14m2sVOm+K6aWme4iLzh1Um
         487KI0Odjg9NdD0Afk4NRYB67699sggRjm0XFme48mEp5rKl/F30aOQjMk9iwY5RcykI
         mgzAgtHFIkvTZojV9vIS9uyxkkpo8+9+4cF7D8vaiVNgMXnWzvwDiOR3d2jnRhYFafC0
         rXhzvkp/FGzNfwTyoPWVz1O6S9pVpp7KVFElsqi+971NLlGLUrrHXl7IMpNCRYqZ+aHZ
         9cJBJIjRUTMWxhRXdnann1q2R177sbRikFVDX3er1GFmSDDG2sagJ7E9aAwXDUuAK0ln
         qV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770701743; x=1771306543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgjNW2qgUWYgRDKDWhlKkcI5hH4YninsNTFbctR5hsg=;
        b=bwt1z1ZvQdckNeFm0jgV6jTXEZd9R0pzIMX5Fj+bzH1tIJ2T0SLEu2COwH6Bj6YA4W
         skN8ca/RF9Pc3+XwCTAqLBF4YjtfeSenFuuPGnonXKcAYHVeA3UUV2yegaZ11XvazFjc
         pvj9Pi8NnT9TbDk0PemoLL/wsZ0azW4j95lXu7iifeIGEOBlJmjk5guiA8yq1qeY8i92
         fQjaM24RSu0oMh60BHgkQIToQGDIHFb1WhcV1teNX/9U3ETPk/mi22xh6KlYI11itVXz
         tuxMdam9fsrTkwT4ZijRV0TrGMW6G3sMaYltbilnvLOjW6viVL/2uHcMiAn0cgraRTwt
         5AHA==
X-Forwarded-Encrypted: i=1; AJvYcCU5GcmucW9sieovAZGWhq3f/FXapBd90OZ2vEEzXUP6BBj+tjQGPRtG9h5kts+gaG7CBCO+weoI6gl3mmZv@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwFREUX+HKjvUx8IxDR7EkgQEBMp+krGP8BHBFfDmDT0/37CtLY
	YhY/XuG6UkgToMTxtLUnAJ8vX8yY4pJRKrzvLXsbde0KDMO/dEM2fdn0
X-Gm-Gg: AZuq6aJGU5jUx6wa7i+1hzXFQEvdVNA2bungGP+DzcZeCBrCkTfn0+zGhuZBQ5+5i2u
	IrJm4UNYB2RkSovs23Z8gT4wdZdJRzg3WgC7eZ3q1aw2ZJte2U+GJuagxwq/je/DhorOdO7rtjw
	CpKTLr1xT+sUP7MMn3DIbtH+svfoOLNumXfgodzGm6wUuAWsclcyR9fgi7iG+TO5PI3op1BxXM4
	PhGT1U6hIdI6nu1LRVsCGfzJ7ELA+TNqzkckAoHAJXgspVSQ8achh3FqsFUOsggbYZ65QDTWcyb
	i5Z7dLMPjd/1L7hJDsepD9WDYpmu3LD1PMPdS8oIW2U9jn5L8F+QHm7SDrzm9zMCBXr9zBAfQED
	AfU8VryRDlWTZ9/xNTWmehd7altvkPkcrpr+n2MdWYTXYl00jzRRb4lBYgV9LaYVGbZVl95bQTP
	aP8bsBRUZvTuBPD95x5JFq85PXzRMkj9TSmnUsv2w11PWBlzSs08PLo0qtTktOB1+HFQ==
X-Received: by 2002:a05:620a:4888:b0:8cb:d24:7b61 with SMTP id af79cd13be357-8cb1f7501famr117632085a.57.1770701742765;
        Mon, 09 Feb 2026 21:35:42 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f7308sm1007857785a.4.2026.02.09.21.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 21:35:41 -0800 (PST)
Date: Tue, 10 Feb 2026 00:35:39 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+yocto@0leil.net>,
	yocto-patches@lists.yoctoproject.org,
	Peter Hoyes <peter.hoyes@arm.com>
Subject: Re: [PATCH meta-rockchip] bsp: fix upstream TF-A deploy desync
Message-ID: <aYrDqzi7UjkIvYuW@localhost.localdomain>
References: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
 <07c9526d-259f-4ef2-894a-076599bbe045@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07c9526d-259f-4ef2-894a-076599bbe045@cherry.de>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Feb 2026 05:35:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3207

On Wed 2026-01-21 @ 06:11:26 PM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 1/21/26 6:06 PM, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@cherry.de>
> > 
> > Since commit 7bce36a2c64b ("arm/trusted-firmware-a: Use
> > firmware.bbclass") in meta-arm, the BL31 firmware is deployed in a
> > subdirectory named trusted-firmware-a and the binary is simply called
> > bl31.elf without any other string.
> > 
> > This differs from what it used to be by the use of the subdirectory and
> > the name of the file itself. This is an issue for us because the U-Boot
> > recipe is given the path to the BL31 binary in deploy directory and that
> > now was wrong.
> > 
> > The second issue is that we want rockchip-rkbin-tf-a to be a drop-in
> > replacement for the upstream recipe and have nothing to change in other
> > recipes dependent on *an* implementation of TF-A (such as the U-Boot
> > recipe).
> > 
> > We can either fixup the path like was done in 2a13a49da4af ("fix u-boot
> > for tf-a firmware") but we'll need to do that for all current and future
> > SoCs (and also wasn't a complete fix as for example px30 didn't have the
> > fixup applied). Or we can simply adapt the rockchip-rkbin-tf-a recipe to
> > deploy the same way that the upstream trusted-firmware-a recipe does by
> > installing in a trusted-firmware-a subdirectory, simply name the binary
> > bl31.elf and update the BL31 environment variable in the U-Boot recipe
> > to use the new path.
> > 
> > Because RKBIN_DEPLOY_FILENAME now contains a directory in it, we need to
> > make sure the directory is created (with install -D).
> > 
> > This was tested with upstream+downstream TF-A for RK3588, upstream TF-A
> > for RK3399 and PX30.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> > ---
> > This is a follow-up to
> > https://lore.kernel.org/yocto-meta-arm/28377373-a3e8-4416-aa7f-488cdfdbcf55@cherry.de/T/#m76f7d4b56849cc28fe80a76953f4e6e61ff0f7cc
> > and
> > https://lore.kernel.org/yocto-patches/dd990ccd-a418-45bc-b708-d3b1fc763ea5@cherry.de/
> 
> Forgot to say, but I think you want to branch off a whinlatter branch
> *before* this patch as the meta-arm commit that broke us is only in master
> and not whinlatter.

I broke off a whinlatter branch back in June. I try to create the
release branches once I'm aware of their existence in oe-core rather
than trying to figure out the last possible moment before they need to
be created.

