Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA9E6BF30
	for <webhook@archiver.kernel.org>; Fri, 30 Jan 2026 16:56:31 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15340.1769792189103859478
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 Jan 2026 08:56:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A5H6hUGa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so4051121a12.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769792187; x=1770396987; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6wPO7GJp7A+HQhNEbSVlcqtj6WL4UhlwVB5pbWErtBg=;
        b=A5H6hUGaLsBXi5LFoA56PHVSYa5cmPYKe5U6v5zpst/DiK4QOR/qz6TAM6NgXMfMQO
         d0QWMw4p1dw5/GMM6X3RbxwWGmRp2gaoIQbkgyr3MWhikTwHm7Ye231M6Bmalb7bcvLs
         bcGKRPtCNFSBQYpx2xtiarOiXbEOuaqMzXkIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769792187; x=1770396987;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wPO7GJp7A+HQhNEbSVlcqtj6WL4UhlwVB5pbWErtBg=;
        b=pWMa45H3RxLRt0vjzXjQ8XFJz5WFmkzMT8PbaDuCse3PyKb4ziUR7KJ/CxkNE1usph
         6mJ43Vt/kYzILkvYsDo56tSirYYgPMT7zrWe7N5t42rsfpeg5xULfeyYPijto0fy1v0v
         IY2GG+sMVSTWcZ9pet0VU+l5phy3ShEfu8pVQ3IybF/sX1ECmCdVNq7ySh6ztYkVCVFM
         ObZJy4tbGrJYhDI/dNSl+5+2A46hHXA2E9QsleixccJrNV92HuEwZRtQksbTaaBytIVv
         nmmvGB2eUYkdmf8mrNfVSil+n2Do1TabaO6j2e6W08rIihfpFTY2sy4v7K+lh5IYU/YH
         c48A==
X-Forwarded-Encrypted: i=1; AJvYcCUjSG7Vqn0suFHslcARxcUaMFjdqF8mtb/sr/LuQBOLkl5qziY4L3dyyV2+mciKnf/SBf95wX7p0APnuZVW@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzaXP/+RK3i+TEQEY6s9tqboen286aAp2/URVkFHWXKAzOoXc4v
	BNpwnr49CrEg8ahgf+TTInh1qWzOJzoFQwaJswoCY1bN56xmnwFtfg3FMmZJa2eYeYI=
X-Gm-Gg: AZuq6aISkUvNxVNcbzsXtXacaScvoegKIdqKqoofTP+m26TkfzgYg6Sk8KdIs9AszDh
	3N/3/fDy/PxhQ2LDnm1zGTXKLZIsTii/4WGwAGjhtZpnx0jbdHe0WbrX72Mk0j7DequJAJ62VbZ
	BW8/V1Id7GznWV1m9X3q1RqdmU2ha9a3twdwFG0AE88I3rgSRItqSVUivXHIm8F+aJY10ePve6w
	7AKRm3JJWRH8XrMcvW815iUyKtpbPJeK7SyNNM9hKpFkKjFjf659ga/IM8YrLUiQQclLQ4NoyYY
	4RRELWVNaEiRUFOkBbDIMG70uPWgYDY8MKDR3kgcNYYNWkb2ypQiACfr+DEE4drMShGWYeXkcVu
	1WqNe1NLu3MQNE8nzuytEBF4mFQgQ6V/6/BOGNt12HF2GLvOVSK2zbglbYf558E58Wxsfkvm9V0
	NcK1JkDjR9ogWRU2ddKtcRv/KxS5Mabxm3ROqMuPK9wK/kghogv50/oRynjDgFWpZjxqSZd0OR2
	LY=
X-Received: by 2002:a05:6402:1453:b0:658:776:5737 with SMTP id 4fb4d7f45d1cf-658de5ab8a4mr2496473a12.17.1769792187453;
        Fri, 30 Jan 2026 08:56:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:2fe3:a5d9:2677:8837? ([2001:8b0:aba:5f3c:2fe3:a5d9:2677:8837])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691d15sm4295710a12.19.2026.01.30.08.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:56:26 -0800 (PST)
Message-ID: <8d6d05baeee00bfe96dfa816be9affe2ff0e421f.camel@linuxfoundation.org>
Subject: Re: [Openembedded-architecture] Running Large Language Models
 Locally -- Contribute meta-ollama to Yocto
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: hongxu.jia@windriver.com, Michael Halstead
 <mhalstead@linuxfoundation.org>, 	yocto-patches@lists.yoctoproject.org,
 Khem Raj <raj.khem@gmail.com>,  Alexander Kanavin <alex.kanavin@gmail.com>,
 openembedded-architecture	
 <openembedded-architecture@lists.openembedded.org>
Cc: "Yang, Zhangle (Eric)" <Zhangle.Yang@windriver.com>, Robert Yang	
 <liezhi.yang@windriver.com>, Randy MacLeod <Randy.MacLeod@windriver.com>, 
 Mark Asselstine <mark.asselstine@windriver.com>, "Holmberg, Tomas"
 <Tomas.Holmberg@windriver.com>, "Chen, Qi"	 <Qi.Chen@windriver.com>
Date: Fri, 30 Jan 2026 16:56:24 +0000
In-Reply-To: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
References: <34111501-e543-417a-b933-e3830a3cdf64@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 30 Jan 2026 16:56:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3152

Hi Hongxu,

On Fri, 2026-01-30 at 13:20 +0800, hongxu via lists.openembedded.org wrote:
> Would you please approve to add this layer to=20
> https://git.yoctoproject.org/, I will maintain
> meta-ollama for recipe uprev and bug fix

Thanks for sharing this, it looks really interesting and I like the
idea of it a lot.=C2=A0

Also, thanks for volunteering to maintain it, that does help alleviate
various concerns.

Approval for this rests with the Yocto Project TSC so I have asked them
about it. We should have a decision after our next meeting.

Cheers,

Richard

