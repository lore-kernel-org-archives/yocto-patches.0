Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34477C36005
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 09:45:38 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.44313.1745833533294842322
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Apr 2025 02:45:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JqIsCtl2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso31901115e9.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745833531; x=1746438331; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQ38lVZa55sD12VQKP6lqgjQAKTk0i1HtlARUt+k7H8=;
        b=JqIsCtl2GFIerYV6Bx1b2JbkYThXsTV3VnveNmgLv2mDxILS0FymJB9B4/a/UFh68a
         kSEpTTEjiSqBEDqa28u+GDUtCK+ux3BYSe5R/K2K/Gr6PWEAboHgoiFlFxzBhELMVGlH
         MiYpNBrtT8oPEIWSGBZeMowQymV2jnNcEI1+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745833531; x=1746438331;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQ38lVZa55sD12VQKP6lqgjQAKTk0i1HtlARUt+k7H8=;
        b=DrNpeyXBHA+n/WrAs/n0mSXPL+VvAGjNF8oqS+2GNXcXp1fmPPfcL4vtA1w1dOpXhT
         COydnB2RzPG+w4RBahPpZTkU2QstD+IzkIpOQih+YjnwwPaRCCB1r7YFnadsxxkXllPX
         UQ7c93nNMupvwAgFAEa+JiPY3FRvArrRic3xUGMmgj0/DbIERZ2r3alP3auT901AKC/9
         augZ8OAQ9z6ia4RMRCHJUihZvR5qqNOb6WNN38e/4P4YrVtK7ylmYlwN8RrDXSCWWDVZ
         ymhvFBy4paCvHALndq3rvmhT5KuJWp0kaNagmhybmSAVSl0K/rtfYovkhIVyxjKGXYxC
         m5sQ==
X-Gm-Message-State: AOJu0YxLlNDRUtNlUnsCjD/j/4vOhA+fAujicChx1kQ3ULFtiX9BZwM7
	sUyjxBgs8ALh8EaP0qWk/9V531Jd8uR4Mulew+MjgYt3RUwrOjQ0i8s5CxWcKDrz43n/WOF5cJ5
	t
X-Gm-Gg: ASbGncsTjhk4Ebr24r+PTaYypwg722G4XZZUg+6EBrpoP3WEKZf4gYXoIhksmcxIt/0
	PjXXCF6H2blk2Q3Yt50paEgenSliSni73rGacJdIaTqmcduCAkvGTC6cWuNgHk0Mb4/Anpn0XfS
	Qk3oX1byfPqorFjF9ekRNdZBFFinKQ4JsLu/xvZMYY+dP3+xUXJ5WvFqtzXg62Uy94LAZ8FV0ta
	zY0QNpKahLZ8MMXLxgkzYIYikvNjIxKWMlp9zjnZVtjEOT3/f2p3TbO1E8QECGxfYEgFtu2ydQV
	zESLd0+qxDFlMKR3WHFJl/laggUEtfDY9SDtqzR7fB/ZdJiQqUF0NjqFqBq+5RqfFBv850/p0tz
	0G6Z9e3BIwX25DdRLwrfuwOWHYO3GF+ONYOBxF8Ix
X-Google-Smtp-Source: AGHT+IGvzGtbtUNajWTTL1cGnk3WA6gK95OcxsHteYo379CWToOo4BWDAuGBA5nSKfbCnKL+Q6MMgQ==
X-Received: by 2002:a05:6000:4211:b0:3a0:809f:1c95 with SMTP id ffacd0b85a97d-3a0809f1cfcmr3496894f8f.53.1745833531257;
        Mon, 28 Apr 2025 02:45:31 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9969:e6a6:49a5:9ef1? ([2001:8b0:aba:5f3c:9969:e6a6:49a5:9ef1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a530324dsm116867765e9.10.2025.04.28.02.45.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 02:45:30 -0700 (PDT)
Message-ID: <962736f53e74160579c266835dacfca786d3b362.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][scarthgap][PATCH]
 config.json: add a builder for meta-webosose
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Mon, 28 Apr 2025 10:45:29 +0100
In-Reply-To: <8641.1745829497357307449@lists.yoctoproject.org>
References: <D926NE9BWQNP.24UZVBATV4CNF@bootlin.com>
	 <8641.1745829497357307449@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Apr 2025 09:45:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1405

On Mon, 2025-04-28 at 01:38 -0700, Hieu Van Nguyen via lists.yoctoproject.o=
rg wrote:
> Could you please merge this patch and schedule support for the
> webosose build for the Scarthgap branch?
> Please let me know if you need any further updates.

I've merged it, sorry about the delay.

Cheers,

Richard

