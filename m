Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8358C2D0CD
	for <webhook@archiver.kernel.org>; Mon, 19 May 2025 14:18:24 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.52040.1747664299997722891
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 May 2025 07:18:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=qcIfZTL9;
 spf=pass (domain: linaro.org, ip: 209.85.128.52, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so33846735e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747664298; x=1748269098; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ESlZ5wESC8CxqnKpqmBBhX4iTvVOa75HMHZbTBrD64=;
        b=qcIfZTL9O4s4RCFH/BuYbVs/BiEoNWJF5gGJOV5CAn7xBYqVZzbm13maQ+YjRADRW+
         UCV9R+BBnojcNfYPgjW9uy6DOkMj47z73wBGFNRDO0LSItpiNXwj4UiiF0djLV8J+URT
         v1DlrpXiJYONpoFgWmEAbkAnqnTY5hZhI4dUuOo405mhNCTe+ZyUUjgI/eqfWPHMBrT5
         U8AmL33KiKFoGLmLKh0R56zCDOO3KPzBspuPavmh5HeFbEV/DV52dtc+8TQFHi2ouQvj
         qNlOnyVhzM2EfQejwa3b7MogTZjAeGLkeNRH0O1HLwvREgqb5HLwyJRHdLar4z/9L2Nu
         W2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664298; x=1748269098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ESlZ5wESC8CxqnKpqmBBhX4iTvVOa75HMHZbTBrD64=;
        b=s6L7kcV+11em2dCUXj43qQLXwfb7vdoM/Mi9mBPAdQbCn4EYQiHv0QhHRT1t9F+CUm
         OmrgxnZv1rqJAfmHRfX2E2/KP4i+rSTcuDTSBGA9MG+0bed61lClZduEl75782cmDSaQ
         Xz+pKA7N9EZe0iUkxn3loV1AL4OYnKkQy64sYTSjlpEbnFhKqa43/h9iFs/6fnmh1xRQ
         2wlIFKIQRy11wGlIWyi9m08SkAujelL8h9Y3jjSaPnd8pidC/LA1Vc2RAEkphUtdAglY
         xokT6k7z2RR+rtEBY2Ln8qFc02RF9Ohn2iEpNA5/fMgejK2kDokl9FOF6T15xDoi6s4K
         CAnQ==
X-Gm-Message-State: AOJu0YyJpj+ZOOtiEbbYlnGSoVSQBjNwsDOA3tDpjctRIJxsaShY2eHF
	5Ixg6mK4nFrmgvmVOqXbkD47cRTKwOzr+E5RRXjgU9/aFUq/B40KJHnrhGU+66EH+MgzULfBmns
	81id9Ta8=
X-Gm-Gg: ASbGnctjkqHI/DT8sE29k67WOc4aSskJDYj3DN2Lg8koEbg712MSYftMJikEMX7zoOL
	Zy42BrC+8HupTWYebMwEpazeIu/XiIO6VwPcn0h5OxuzvPp271LzNFjvBlDcKZYEmqpTIZzbjtr
	yASDpiZFQfGo1E8xsAVlFJ4YgQiUPmZq8nUHKE6gqtZmmYqQwM0T4+rDGqsJDWXd7NsvXqQbuAX
	SWwNXlbbDZCJ77RtY1QrmFKLKB4vmUR9sa6+hxOM0ebWilLhk27WYt/vQ2lsjHa479DZVfk9At0
	LCv327hx/vVooirIcwwlW2x2x30hB44skfpTeeLD1/gsis4Q
X-Google-Smtp-Source: AGHT+IGcF91h0xNS9n8AIWtXAFs39yuv0EFTdD7a1Xr4xrgQ33BGScnGC6iUwGBG4GW2dXuUK8djjA==
X-Received: by 2002:a05:600c:3c99:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-442f84cb4famr154098475e9.6.1747664298014;
        Mon, 19 May 2025 07:18:18 -0700 (PDT)
Received: from nuoska ([62.48.241.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85bb20sm146254955e9.0.2025.05.19.07.18.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:18:17 -0700 (PDT)
Date: Mon, 19 May 2025 15:18:16 +0100
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-security][PATCH 2/3] systemd: fix empty file list with sed
Message-ID: <aCs9qGvep0KiLjZp@nuoska>
References: <20250507082719.1220303-1-mikko.rapeli@linaro.org>
 <20250507082719.1220303-2-mikko.rapeli@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507082719.1220303-2-mikko.rapeli@linaro.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 May 2025 14:18:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1562

Hi,

On Wed, May 07, 2025 at 11:27:18AM +0300, Mikko Rapeli wrote:
> If measured-uki support is not enabled or build is continuing
> from previous stages, then the matching file list can be empty.
> Fixes build failure where sed says no input files.
> 
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> ---
>  meta-tpm/recipes-core/systemd/systemd_%.bbappend | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/meta-tpm/recipes-core/systemd/systemd_%.bbappend b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> index 82b79ba..c53b1e8 100644
> --- a/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> +++ b/meta-tpm/recipes-core/systemd/systemd_%.bbappend
> @@ -11,7 +11,10 @@ PACKAGECONFIG:append = " \
>  # TODO: use swtpm-native to calculate TPM measurements
>  do_install:append() {
>      if "${@bb.utils.contains('DISTRO_FEATURES', 'tpm2', 'true', 'false', d)}"; then
> -        sed -i -e "s/^ConditionSecurity=measured-uki/ConditionSecurity=tpm2/g" \
> -            $( grep -rl ^ConditionSecurity=measured-uki ${D} )
> +        FILES=$( grep -rl ^ConditionSecurity=measured-uki ${D} || true )
> +        if [ "$FILES" != "" ]; then
> +            sed -i -e "s/^ConditionSecurity=measured-uki/ConditionSecurity=tpm2/g" \
> +                "$FILES"

This is wrong and breaks builds. Need to unquote the variable to get
files seprately and not as a single argument. It is a bit odd that I
did not always see the failures but only after rebase.

I'll send a v2.

Cheers,

-Mikko

