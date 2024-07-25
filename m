Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D9AC3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 11:10:26 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.33946.1721905819774593999
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Jul 2024 04:10:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=FFRLmuCB;
 spf=pass (domain: linaro.org, ip: 209.85.167.50, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd8807aaso26571e87.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 04:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721905818; x=1722510618; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tow9UneJWxyK3PMANLgPU8tFLnCsnrPr/FleBJ3vuOA=;
        b=FFRLmuCBXoTaBHjuvagEwOKoclV9bL+EwxC3zZhj38abnabEfdQ3jKIaPqKVefUci1
         sL3mkYGIjYkz7oEbdG5tLc1WyHCxrye81SM6USUG4mGrOyvVDfrhPp87+St0KTkP2voI
         5flRMeNNj79j/p2NKD8WHs1rN6W+N8zrawk22ZmsGQ6cg6A8voFXfo5fdjvpzSToPt2u
         Hu8V7IfUY7IYVY9JU8XYZuO3LOiGFECs/yI8QzqKQoRtDbOv3h/OwRmbCML4D30YYPS2
         He7hApSSGTRfnJ3MPm+6fog/fx3sdX8QABgEJJCSyx37NIvgsAvcRd7ucOPvtvME+pSn
         KJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721905818; x=1722510618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tow9UneJWxyK3PMANLgPU8tFLnCsnrPr/FleBJ3vuOA=;
        b=szYVWJ4nCNb/GZye435+zcaPD79H8KbWo6HRgYM6cZWF16A9jH4Dlm1OFuoxXdgp+n
         2odUP0IMNZW4bRPyaPKDjtUxlm+AOhIc3jK4W5p0PHm06TUz/9hKQM4nmCf4GlvQSBoW
         vMI/bTT7mGlqqkcTj82OYBnMpRTJyFA6a3FFGpyOsgcnB2zp4VVagW94zOocv+GVlnb6
         oyJgalncvVIUbJ6q+43vIi1vVqIlvv2jQf8wZjveHr0z3l6nFFuTK715Mdsh6XjjdOg/
         AwXykCj6+ChhLF0624hLYkowIWYVNj+27/6Umhh0GycVGK6U6axuanZqROzf1tUGGu0a
         MkmQ==
X-Gm-Message-State: AOJu0YysUzNuA8tbUVBJptjm6drTwgTGugjYi+foIu8PXTeVbaKHEgoL
	7LxFg+kBjil6FaRKLkICxZ5cc2y8CsqA7z+DFfgB9wk0+VE1d33jjn+2ldAstQc=
X-Google-Smtp-Source: AGHT+IF1zZV0rJgYhDm6vMYYaZZQn2HIa0rfhitW35naprW70K2t6j4DxpWwbyEwP8OIC7kCYEq45w==
X-Received: by 2002:a05:6512:280a:b0:52f:eb:aaca with SMTP id 2adb3069b0e04-52fd3f1df2dmr1920931e87.32.1721905817736;
        Thu, 25 Jul 2024 04:10:17 -0700 (PDT)
Received: from nuoska (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c3a207sm189029e87.306.2024.07.25.04.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:10:17 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:10:14 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 01/17] bastille: UNPACKDIR
 fixes
Message-ID: <ZqIylhVh-2a_ELGH@nuoska>
References: <20240725090131.75860-1-mikko.rapeli@linaro.org>
 <CA+chaQfVw=9mFAPm3VWVKCKT3upPsigVwMMxLzMzviqVjCm7tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+chaQfVw=9mFAPm3VWVKCKT3upPsigVwMMxLzMzviqVjCm7tg@mail.gmail.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jul 2024 11:10:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/477

Hi,

On Thu, Jul 25, 2024 at 12:35:58PM +0200, Martin Jansa wrote:
> new poky?
> 
> poky is just reference distribution and name of a repo. The change was
> implemented in and is required by new oe-core.

If I use poky together with other layers and update to poky
requires this change then I don't it's wrong to say that new poky
version needs this.

Should I change this commit message to something else in a v2?

Cheers,

-Mikko

