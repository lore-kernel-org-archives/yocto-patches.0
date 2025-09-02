Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA128CA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 20:57:10 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.web10.88793.1756846622567823924
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 13:57:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gNdalQWM;
 spf=pass (domain: konsulko.com, ip: 209.85.219.49, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70fa0e941a9so2961316d6.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1756846621; x=1757451421; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aeANM4R8ME87A74RlX/ScGevfilSNo+oK935+4hfUks=;
        b=gNdalQWM2O+DinlmZMntHBMwcGrg4cnu7KJtE0OawrWiyHZx0CRZuKaiBSnOLnUio0
         fz/UusaANcsolPek8DpCwIY3hL5iOdpeE1luDvDk8KFtm56XmtljiuSSQkeH1EV4FASo
         0Dd4bO9B8/aceb2Vthu/UrMc8SwR/hhPdQp8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756846621; x=1757451421;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeANM4R8ME87A74RlX/ScGevfilSNo+oK935+4hfUks=;
        b=Yq4sfosZem//NITf27AcffoM06riiAwe+PTfGk9eJV9Y9eJ2GzSjjJKIBX5EhcXJTP
         AliWZN4kyYMlz9ijlBIwtr+VQ5Jo2VcL1A3fI1IFEDOzJzhLTtKMc3tWHkD384juNEgA
         TfN73TtBvVy+9HU9ZgbB7F8U6oFAU2r2q7KaEhdkwMjszhPfTbfdUnpTPeXDBNYkklfW
         tSxpMsnNKyzVFLRu4H9sBXa5m/zvqjRrM0Q0K3bL/rA6FnzgIzm41S8CR9klOUyYJssW
         0yifnLt04ifAvfQeHj6UC0Bq6Kh2OyQE1EIoBJ/X8uj5FBtdrr4WoMtAttW9gLE9J0AP
         /+tg==
X-Gm-Message-State: AOJu0YxFYFiohkdmyc6vNjd2xkdKH3sYpSTmbSzpzt25XcU2PNV/3CyX
	Cmpzl9Psmor7EtUVNECqAOTZPnUzbjBPWlf0g/Hm0T8RLAcLWU1u74N8jTrs3fCcv4Y=
X-Gm-Gg: ASbGnctJnk4HgGitABcq8MHTxInQL0xSaX7R5ooMfw3PFGU04aBtTah2u4h+fqwSesr
	sMrgnOTDDKAKUuXc4Qkj2menhKlUJLnfDwlA/8DKKYPBAC/TaIdfdwbbPU0ORSvBabnh3GQmiv/
	MEcWS6LOWZ80O6oNa+sVg+WpBdW34vFRFs+wEsc4E2zIutJQVy7ED+E3H5GCUewHoRg6Syf3ceo
	9NqE/vK7xvyCGRDbqeOz2YuZ2oQQzSaL+hxLZopZifk98GFGLIsCBpZWNeCRFmGb/HRXUJ60YPR
	GgTwK01lA/DgXynOWqQ2ORrKqrfBVKH0gphZOpMfXmTI+mNOLptEdmMyk3negkwC8l8bJF3TLE1
	Ap1kkjQHLtZaRsiWb98mUq6vaWyUm53Af30eld73rBm8WB7ha1ZKu+YWgwWPNQapOFRZo
X-Google-Smtp-Source: AGHT+IG4p/cPVXKnETdrKvlOozSs0gra0HvnNNBs9jYPqXG07lvSUa1nxsZ/uqkoEOD50BkKNvI4qQ==
X-Received: by 2002:a05:6214:4104:b0:70d:ff3a:f986 with SMTP id 6a1803df08f44-70fac7c7254mr155247116d6.13.1756846621203;
        Tue, 02 Sep 2025 13:57:01 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4665f44sm17966866d6.36.2025.09.02.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 13:57:00 -0700 (PDT)
Date: Tue, 2 Sep 2025 16:56:53 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: "Sambu, Soumya" <Soumya.Sambu@windriver.com>
cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>, 
    "MacLeod, Randy" <Randy.MacLeod@windriver.com>
Subject: Re: Insights from Integrating mixins rust into kirkstone-based
In-Reply-To: <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
Message-ID: <3f3df632-63bd-652b-dba6-4a4a3a6a0f93@konsulko.com>
References: <CY8PR11MB7921AAF6CFDC45DD76C7B40B813BA@CY8PR11MB7921.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-458830420-1756846620=:4221"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 20:57:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2118

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-458830420-1756846620=:4221
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 8BIT

On Thu, 28 Aug 2025, Sambu, Soumya wrote:

> Hi Scott and meta-lts-mixins/kirkstone/rust folks,
>
> We (Randy and I and others at Wind River) wanted to share our
> experience with integrating 'meta-lts-mixins/kirkstone/rust' into our
> kirkstone-based setup to enable support for the latest Chromium version.
>
> While the initial integration showed promise, we encountered several
> build issues that led us to reconsider. Most of the challenges stemmed
> from the major upgrade of python3-setuptools and the Rust toolchain,
> which introduced incompatibilities with several packages in our
> environment.
>
> Here�s a summary of the key issues we faced:
>
> Setuptools-related failures:
> - python3-strict-rfc3339 0.7-r0 � do_compile failure: ERROR: python3 setup.py bdist_wheel' execution failed
> - systemtap � do_configure failure due to autoconf-related QA errors
> - python3-grpcio � do_compile failure: distutils.errors.CompileError
> - python3-awscrt � do_compile failure: unsafe include path /usr/include/python3.10 for cross-compilation
> - python3-azure-iot-device � do_compile failure: invalid specifier '!=3.3*'

I don't believe you ever replied to my question about whether these
failures are all that result from a world build with e.g. meta-python,
meta-aws, etc.  If that is the case, to be honest, the fallout of the
setuptools backport doesn't seem that bad to me, and IMO worst case you
could always chose to handle them in a WR mixin layer for your customers.
I did forget to go back and look at systemtap, that's definitely on me,
and I'll take a poke at it this week.

> Rust-related failures:
> - Internal BSP: libstd-rs do_compile failure � Error loading target
> specification: 'softfp' is not a valid value for llvm-floatabi
> - mozjs78 and mozjs-91 � do_compile failures
>
> Thanks to a variety of commits and your work, these issues were
> resolved. However, we remain concerned about potential customer
> regressions from introducing higher version packages into our
> kirkstone-based setup. So, we�ve decided to hold off on using
> 'meta-lts-mixins/kirkstone/rust' for now to avoid impacting our
> customers.
>
> We appreciate the effort that�s gone into maintaining the mixins and
> hope this feedback helps others in the community. We�ll continue to
> monitor developments and may make use of this work in customer-specific
> projects.
>
> Thanks again for your work and support.

Thanks, I guess?  I know you've a desire for me to slap your workarounds
for mozjs and the like into dynamic-layers, but as I reported previously
I can't reproduce the failures you're seeing with e.g. python3-grpcio,
and your tweaks for mozjs seem obsoleted by the last couple of Rust
updates.  As others have mentioned, we're about 8 months away from
kirkstone EOL, so it's impossible for me to justify investing more of
my time into trying to hack up a frankenstein setuptools-rust that avoids
needing the setuptools backport.  That said, I would merge a reasonable
looking implementation of that if WR is for some reason motivated to
invest in it, and am also willing to discuss handing over maintainership
of the kirkstone/rust mixin if WR plans to support kirkstone for its
customers past Q2 2026.

Scott
---1463811583-458830420-1756846620=:4221--

