Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C431C55ABA
	for <webhook@archiver.kernel.org>; Wed,  5 Aug 2026 13:07:31 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39911.1785935245075197338
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Aug 2026 06:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=OT3UpEyD;
 spf=pass (domain: konsulko.com, ip: 209.85.221.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5c3163a88a1so249331e0c.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 06:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785935244; x=1786540044; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6id+pzl86k1fbQPzMlt1BXaw7QVc51KI26+6LK4kwM=;
        b=OT3UpEyDnLlyTQyxfDukKctV/fkVSppGXk/T4/Ms5//pdSFJVUC6wKZK+2A/rsIYTo
         tmGMDlv5XLJCwrR7/M/+hGAXHZ4WB3+05Bsr0TygqpiTPut+ijct4PrJxXL5eL7fuYzx
         CS5dMHoB+URGeGANYI326DxDHHg8q3ly7mRPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785935244; x=1786540044;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6id+pzl86k1fbQPzMlt1BXaw7QVc51KI26+6LK4kwM=;
        b=gGXPtAqE3ArPtkR/4VUhmM6//Cm+CqFHR9cx2vZEdJPN77YMp1gGZGai6K8JQxXk8K
         TwtpS2hIY5TNjSJ3iEPrJ04Z+Kyxw7ZQkfq4NPfnlSYHrM+e8/QsTfa/qo8lqab+4Cjc
         X6gloXxu5E1F7oZYvKKPy1xMOuRMyieVCHdJiEPo6swfmjSVBCWV9IdMM8Olgt2Wh0xL
         491DLSqhi3IlxCswRT/7cdL72FZJcBo7pY2uMTGjYpWmHkh8AaWxrAUfqOx+QaRyKIWI
         vjd05nThjYc09X3N4ei+NQTps1Wpn4g6WVk855M/ZjIRqX3qE8SVnsyvlaQO3bc4NUlh
         VeVw==
X-Gm-Message-State: AOJu0Yy/qdXkBPi58yjfAaR0FjbsOMJjpl4qui3fnfCswiQnt211oq8z
	Nsu/o+nceh+o6AQ1Eg1nwYwjhh4OWw66RMsqYIQHo+5WbeUiRTs85SU3FOcnWsqfC3A=
X-Gm-Gg: AR+sD12tff8d+xPxxXtlWph+tp8UzLuz7Id2WhPupHsvQxvy5Qfe3+3HXzYH+oK3/iz
	6fp4SaAYP8EtnmPLc5zw/E9x4RmWssUkN6hIic9Ne6sZmcn+nRNlkbu0EiSlcte/sJm5lj40dwj
	mvK3H+q2Du3t7MAs6CrZ2GruAs4wk6vg1zfVKkm5Psabia2H4djFDQNCKk8rX/S8HJ4r1PRw2IP
	OgAU5ZdIzuJw1QCn3ZeP4lbxX87zUtgmG84ljUwcVbhUiY7xeseHm8ck51DSikX89zO+4HGPntX
	uddNfb4Tf0VMdMbtTxJFfhdtXx2+WqhXgSkacHQxrZmHv/F90l1IPkVv2crWGRUpjQQkCqok0u8
	bOr5/1dGN3gMV4PzzN9VxpFgCGGvHq0zzfkbxSlzOM3p3cQonL/jDN5BjewJm9EUdA2p9fAAAY+
	VjudfFp1L/kjreBmFKsdXQN4I5j6sEqb/+3xyJWYN6c8zMb4kUR4HlfLFSX2emkgF5D5C8GUBXw
	WpUVAMm+YOCIwHc8D2lYhqS5xHEMpdvmpuVt2JRmNzA7AtsopLFhPNxEZcCvN+RjWvoD8jD8Xqd
	TJEluqpP
X-Received: by 2002:a05:6122:e20a:b0:5bd:81fc:ebe9 with SMTP id 71dfb90a1353d-5c3d8de0fd0mr805676e0c.0.1785935243727;
        Wed, 05 Aug 2026 06:07:23 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d0916f25sm1450662e0c.16.2026.08.05.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:07:23 -0700 (PDT)
Date: Wed, 5 Aug 2026 09:07:22 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Marko, Peter" <Peter.Marko@siemens.com>
cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Subject: RE: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 00/35]
 Update to 1.96.1
In-Reply-To: <AS8PR10MB50733593873B3ED9907CF072FDD42@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
Message-ID: <e2b84b07-72fd-0339-5c52-31738110803e@konsulko.com>
References: <18C75C9B3F4EC7FF.1793795@lists.yoctoproject.org> <57b8baa1-9c24-b9b1-fcc7-5f4ff8172fdf@konsulko.com> <AS8PR10MB50733593873B3ED9907CF072FDD42@AS8PR10MB5073.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Aug 2026 13:07:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4635

On Tue, 4 Aug 2026, Marko, Peter wrote:

> Hello Scott,
>
> this update puts scarthgap+mixins ahead of wrynose.
> I think I'll update to a commit somewhere between the 1.94.1 and 1.95.0 bumps to cap our scarthgap at wrynose level.
>
> Are there any plans for wrynose mixins layer so we don't fall behind there?

Funny you mention that, I already have need of one to be able to build
something without a bunch of Cargo.toml hacking, so I plan to work on it
this week.

Scott


