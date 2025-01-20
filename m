Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4590C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 22:54:28 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.3642.1737413658957330616
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 14:54:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ihzf+gK1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43634b570c1so35958055e9.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 14:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737413657; x=1738018457; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=56d9frMpJS11OPdkj+Ql/husm7u6IcGqRYpX47A2Km0=;
        b=ihzf+gK1OefvfKYO89DZc+Ry22ZZZrZ4U+QwmIw/HrQde7DtxWA798uHqvB7GNzN9t
         +AIm1OOflE1nN90UR7vE6GpPz3AZK8Su9YZJNHz6wHg+kXIphFT6teFeWYZZMCTQCFUR
         PAAYGxUnmoqsV3X13ygavkc6pxYkVqB3DqPlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737413657; x=1738018457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56d9frMpJS11OPdkj+Ql/husm7u6IcGqRYpX47A2Km0=;
        b=SD6LSS0FwU/8UidfRZ3hf6ujnHxahBmElMFGJT7lEV7eB+svSn+d91Xa8L4fnMAyvG
         UG/41TtN8upK/ddrc2IhDHKkOpnWU7GT0T4/BvmKsNlHEXGaFMBs5nftU/tHe6CRB64q
         PFgGskyKtdVV5XgriR6CnNKuD8urgl8FxenMcdQMXJx05jSnAK2ZF0DqctrbyAecgcxf
         u1YtU3u9qiszkqoTngQF6WhOX0AZ2Km8O7WJjo1rCnUq0wV41i761xG2kzjdDX4p8dGp
         3WaF/n1hNJKNaMKTmfsa9yhbvbxNhrob9p12fcfBUtSmyrpDTizFgees3FBLSj4HMgqv
         ItNw==
X-Gm-Message-State: AOJu0YwQz0HIQXqRFYoqxwZ/pZaLszaVCKwzf2pdgiCvKFh+kgOqFWxR
	35LPLZ9RZatU7V8SgH0PiCoI1JOQgD5IgZpk4hn5kg2hwX3xupvzC8NYxyVdxlqnMDs4rOKeV8L
	iEdg=
X-Gm-Gg: ASbGncsBTSh1PHV92lxGUUiDDrETCzXkk9gaoszFhWXxwuszgmQmaaIwyGlCWlEanft
	BoHW9Og4HarfVnPf3hvC/O2QjMIHWq33pUKGgblc5/y2vdoSZ/4Ug/n3AxF3Q4kdz5u5d4PwR5f
	LeA4iXU5BUlVCc/PHJSHLsHeEdMeEx/Hq3BRXrAjyvb/PxXzMnAZzsnCAPPDjPBiJEYkj/8qjk5
	YwSyXjxAFjmOfF5uzbMUNE9ni+crhgIpHfvq8YNvQu6QJLYcr0RP8f/iW6BU31lY3ZN7fEp6dOQ
	EOeMSWPOHi41+BY2OnrEIr3Ffoq3zNSgqgOaeIfggXVm7uVr9i/E8pGUFQQ=
X-Google-Smtp-Source: AGHT+IHBGi/B3qqYkidm/BincZZGVk35hNakhA1XXzKHoFxS2sbiJbxM5OZ78pjBI52Xo/uXp5Imbw==
X-Received: by 2002:a05:600c:524c:b0:435:306:e5dd with SMTP id 5b1f17b1804b1-4389143a66dmr128535405e9.22.1737413656528;
        Mon, 20 Jan 2025 14:54:16 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1c9c:1142:86e8:37c3? ([2001:8b0:aba:5f3c:1c9c:1142:86e8:37c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904625e5sm157145045e9.32.2025.01.20.14.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 14:54:15 -0800 (PST)
Message-ID: <648e69b6898d3f95bea785d1ee56e2ce500ae579.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH]
 classes: rename to classes-recipes/
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Enrico Scholz
	 <enrico.scholz@sigma-chemnitz.de>
Cc: openembedded-core@lists.openembedded.org, "antonin.godard"
	 <antonin.godard@bootlin.com>
Date: Mon, 20 Jan 2025 22:54:14 +0000
In-Reply-To: <a5630788-8f4a-faa2-7d6b-8dc87dd1642c@konsulko.com>
References: <20250120165117.737681-1-enrico.scholz@sigma-chemnitz.de>
	 <1f6cdeb4-c868-e32c-4372-123371eb4b12@konsulko.com>
	 <lybjw1ffw0.fsf@ensc-pc.intern.sigma-chemnitz.de>
	 <a5630788-8f4a-faa2-7d6b-8dc87dd1642c@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 22:54:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/997

On Mon, 2025-01-20 at 16:32 -0500, Scott Murray via lists.yoctoproject.org =
wrote:
> On Mon, 20 Jan 2025, Enrico Scholz wrote:
>=20
> > Scott Murray <scott.murray@konsulko.com> writes:
> >=20
> > > > bitbake looks first in 'classes-recipes/' and then in
> > > > 'classes/'.
> > > > Hence, content had no effect and was just ignored.
> > > >=20
> > > > Rename folder so that it overrides the OE-core classes.
> > > >=20
> > > > Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> > > [snip]
> > >=20
> > > I'm pretty sure this is incorrect.
> >=20
> > Logic is in [1]
> >=20
> > --> first iterate (using $BBPATH) in 'recipes-%', then in 'recipes'
>=20
> Hmm, the code I looked at was in lib/bblayers/query.py, and its logic is
> different AFAICT.=C2=A0 Can you confirm that "bitbake-layers show-overlay=
ed"
> shows it as being overlayed for you as it does for me?=C2=A0 That it does
> would seem to indicate a bblayers bug, and there is perhaps some missing
> documentation of this behavior (change) (e.g. I don't see any mention of
> classes-global vs classes-recipe vs classes and how their prioritization
> works wrt layers in the docs).=C2=A0 I'm CC'ing oe-core just in case I'm
> really missing something here...

I think bblayers needs fixing and we need to sort the docs too...

Copying Antonin as we probably want a bug to track that.

Cheers,

Richard

