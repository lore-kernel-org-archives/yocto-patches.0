Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4585DFF885C
	for <webhook@archiver.kernel.org>; Sat, 25 Apr 2026 08:33:14 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2433.1777105989384944570
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 25 Apr 2026 01:33:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V0ohI92A;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d43e09de5so4810384f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 25 Apr 2026 01:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777105988; x=1777710788; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmZBXsQstnx8mcSF9pk2+G+rUl7yNPrv7ZTWhX/HxAA=;
        b=V0ohI92ApjOsuQLBtHr+4suLd5E8w11KIVfyMlg8E5WYPsu6zlXTmNgWCZWMkov7FY
         AVyUVeJdRddfUtcPOozDeVLq0gK2Bz2uKwjMXZvx/DlmgN7fnJhJ/aZzN+IbJl3O18PX
         AkRUN5awnaqtXTkznfB0pDOXaA/50nOEhHFgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777105988; x=1777710788;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gmZBXsQstnx8mcSF9pk2+G+rUl7yNPrv7ZTWhX/HxAA=;
        b=Doaa+nXQiO4XN/Rphk2+yxXsKgEmP/woZLGJNS4uYQ1TW5BXf8KoFegcSLn0P/By4p
         Px+BG8m1dPJQmCPLGhRRtEQxA6hpj0fWbgDHZ+uvJXy8BBmXdkLvFn1JYSXw+8/bFGLw
         RdS8qt29Ijhz5OlQpJA0Bcdqn/OaVxL/jILO4KTycuoDnx2oXU5QIR6MyZpbaoBMJt0n
         JwCDLQez8MDvXs5GYEn3kiLgyadpt7r0hUUqvoIL4/czE2sAU3US87WuxUN6pMZblANk
         xEHnIj4rJSDrjciHCCRnsRULmMvPar/I2pbjwGQW4n6GnSMR/J6+H3DoVVWC2EsSJTgR
         Prog==
X-Forwarded-Encrypted: i=1; AFNElJ+OMhrxnYRFC+pM/xD+fHGA1mXpb8NBzYxbkR7VBn12kGjnji4BnIOc27zgrF52Sh2N0Jt3WCFY9E98nOsK@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxemGkVE6rQkdJkB4wQ/Pq8ZhUthaC7etXomtPoJ7lnRfR3koeS
	v6pvtnnBoneYzyivlX5I2RWA/sj78FRBO5DMix8/uoyN1Dqw9EHFIZ17zxY5kvy6Lx8=
X-Gm-Gg: AeBDievhCY9bD3sRn9cELI7S4cE2DJ656R6R8zHHzVoDQeTB20CqDakXTVcw2LYqgKN
	V07MDEsmv5jnNWHP/Oe09q9111vglyiA3m/yZGRSY6tY2NIP7nMQN8NWfvYL6/eZTpYGT3tKaI6
	vxNaMPGe1pSDtQCLYX35nzmSt3R8c1wtJ0zPw72VVNZllsNRDx3aL2zIusySqe++rEJOPqP3SAX
	AS8tt2vXqELSvUH43km84vH+3zgTO2MG+n/mTcoy+Xl15S8ImGaqQ0QNl4YtBaIk+dA5e9B85YD
	LIY8xFUUR2MVi4BOhaNNHZMBqjg2nsFYFjkAV33YeNuNHt6WBBrjAVICFWoahUu8ZDeq/b/7Mg/
	IbRnG4FBi7PjseBvz7hYx4HDaeaIXp34mS1ZpyRF96aCFzqIjBt8YpbkrS3cAMe/Eu/mJ/PVUn1
	aB/6pIPX5Tjrm8jfO+2Aanh2LaOWRfJ5nwjkgkstQE9c3WTPeeou8UlfIPU+i+WcM3FsjFEmMWJ
	dFBYlIKBC5sT7/xsCLOC3Eh7ic=
X-Received: by 2002:a5d:64e7:0:b0:43e:a69b:d814 with SMTP id ffacd0b85a97d-43fe3e07245mr57693802f8f.28.1777105987685;
        Sat, 25 Apr 2026 01:33:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:fc2e:49a9:508d:b834? ([2001:8b0:aba:5f3c:fc2e:49a9:508d:b834])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a166sm64330349f8f.19.2026.04.25.01.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 01:33:07 -0700 (PDT)
Message-ID: <1b52f7e43a249407ce8b569fab60b3e4173351b7.camel@linuxfoundation.org>
Subject: Re: [yocto-patches][pseudo][PATCH 0/3] Add pending patches to master
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mark Hatle <mark.hatle@kernel.crashing.org>, 
	yocto-patches@lists.yoctoproject.org
Cc: dburgener@linux.microsoft.com, peter.kjellerstedt@axis.com
Date: Sat, 25 Apr 2026 09:33:06 +0100
In-Reply-To: <1777071733-25858-1-git-send-email-mark.hatle@kernel.crashing.org>
References: 
	<1777071733-25858-1-git-send-email-mark.hatle@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 25 Apr 2026 08:33:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3817

On Fri, 2026-04-24 at 18:02 -0500, Mark Hatle wrote:
> This includes the two pending patches to pseduo and a test case for Peter=
's
> issue so hopefully it doesn't happen again in the future.
>=20
> These changes are currently applied to 'master-next'.=C2=A0 Assuming nobo=
dy finds
> issues with these, I'll merge to master and bump the version (1.9.6) on
> Monday.
>=20
> (RP if you think the build needs it before Monday, go ahead!=C2=A0 I've t=
ested
> everything and it looks safe to me.)

Thanks Mark.

6.0 rc1 is now built and ready for QA so I'm planning these for 6.0.1,
therefore no rush from that perspective.

Cheers,

Richard

