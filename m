Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B25CD6E7C
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 16:26:17 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12085.1780676769462557961
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 09:26:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GE2KxOq7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eedc94d37so1148692f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 09:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780676768; x=1781281568; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WP2BBea86fsWoY2jpeHRDX2pS8dYgpW9/tyUKJGkGKs=;
        b=GE2KxOq7OawmBCP7B4w6To5W+xrWjBymLABeQqRERmPiOvIEOBE2PhU0Q2usPhUANX
         cn3oCD7tU6CPILMJv5BCK3FJ2LH5JSWs/zvwvK48AAUQxtpRkv0P/BrvrIIWe8jv3lYn
         0Xx2GVazFnufmhIsJFUYUSDmTsEhc2bq/0x0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676768; x=1781281568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WP2BBea86fsWoY2jpeHRDX2pS8dYgpW9/tyUKJGkGKs=;
        b=EIP7ayhLUHw9IL8fr7eu11K5hh3uin6vbvUCvfe8H76JpSUJ5Thvxyz8Xs7HbGT8uN
         5DSprp1Mnz9wkGp3NbRBgtuwzB0SUiXpS2TXXpydJihjQ8Wlh6moMaAxBLyFMG/v7y6j
         ywlnQu2Il1wzR/HGZ+YyTahyx4JnrJ+R5jguq6klFWsU4e+CiOtNWjQksuloKYELTotP
         hFZGLju4gLEpqgWnn7DBnV97mdRJ6lGoZoZWUr5OM2tM6u5igk+pBMMu1l18jw8WqZVF
         WRV0kgKJcBum8n5NCL+1L+VwCr+IO1hB+lqAECqVvP++wwCQlE2PvDEuqaNZgagBsGY/
         9x8Q==
X-Gm-Message-State: AOJu0YyT+LZ1jaRsq8OMqc966YO24l/wJHlLXhDyIK/w08Nty5fny/QU
	D55EisqpF/EjC9JZInf9xTEWDJnKPpAgy/uzcNm8+C9ckSrmK99hvByvFK/uDb7brMLLO4aOO+t
	mCN5c
X-Gm-Gg: Acq92OEU66ZZN/UgH+KxclEEc9x8c0v3zObbpjl9uWZY9mNa3wAaIn1ITa8dSq+e2Ap
	UGT7rruMXnuj+nRjKFewirnYSxcHJX/g4ffcuR7zfHXV34PU+jVdi/4s/LIJ87M/Sm8Vqosn1Db
	1TXmJD0ztxxwUVLioOYjAR1RlZ51vpISVST0jMoLKPSh2bP9vXT4tO4/K30z4WkU8MzgTQdvhj4
	gtVtb+qe9nY5gORBe2GUYLPLYhAFP1b8F4OwUhMlmzPFcCx/RdJvpbcSfGplDmi1WrC/TGYXB57
	CUdAjAVPM6eu7Wcc7T+DjM/7ANJZYP90DhqZxxJyxbsrebjXDLKS006P0JZlIMWFoDU0yr2N9VU
	u02xgRqACUvjPsNhJEhCK6STYZfxj35mFAHJ8sSLTQaVkVJNqm82WTbj3gXh8b2RB+6zb+O0IiU
	e+q6jdj4fIuIYXsUz+DE50NpUKD6yAX/m3d/Ls22yZNDd1cOEKscZkoy6UrX6AUNGzhvbZWYtS+
	FosOVdiB0lVaVZiIDanhJjvJVM=
X-Received: by 2002:a5d:58f8:0:b0:460:2d57:ea1f with SMTP id ffacd0b85a97d-460305122f0mr5559374f8f.15.1780676767534;
        Fri, 05 Jun 2026 09:26:07 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:176b:6db2:d527:85f4? ([2001:8b0:aba:5f3c:176b:6db2:d527:85f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm26595717f8f.25.2026.06.05.09.26.06
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:26:06 -0700 (PDT)
Message-ID: <83eab955b09ab5c2bc61fd2a7c0c229f1aea6fd9.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 05/10]
 scripts: add vcontainer-tarball setup, integration, and publishing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Fri, 05 Jun 2026 17:26:05 +0100
In-Reply-To: <2cf468a3da7c7db15ee42c14404a71aaacab0f28.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
	 <2cf468a3da7c7db15ee42c14404a71aaacab0f28.1780354513.git.tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 16:26:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4153

On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org wr=
ote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Introduce the vcontainer-tarball SDK plumbing used by container build
> jobs. The vcontainer-tarball is a meta-virtualization-derived SDK
> (modelled after buildtools-tarball) that ships the container build
> toolchain so worker jobs do not need to rebuild it for every step.
>=20
> =C2=A0 * scripts/utils.py: add setup_vcontainer_tarball(), and add an
> =C2=A0=C2=A0=C2=A0 env_glob keyword argument to setup_tools_tarball() and
> =C2=A0=C2=A0=C2=A0 enable_tools_tarball() so the vcontainer-tarball can s=
ource its
> =C2=A0=C2=A0=C2=A0 specific environment-setup-ci file rather than the uni=
versal
> =C2=A0=C2=A0=C2=A0 glob.
> =C2=A0 * scripts/run-config: source the vcontainer-tarball environment
> =C2=A0=C2=A0=C2=A0 for build-targets / cmds / test-targets / plain-cmds s=
teps,
> =C2=A0=C2=A0=C2=A0 gated by a new NOVCONTAINER step variable so individua=
l steps
> =C2=A0=C2=A0=C2=A0 (such as the dashboard indexing step) can opt out inde=
pendently
> =C2=A0=C2=A0=C2=A0 of NOBUILDTOOLS.
> =C2=A0 * scripts/shared-repo-unpack: invoke setup_vcontainer_tarball so
> =C2=A0=C2=A0=C2=A0 workers extract the SDK during unpack.
> =C2=A0 * scripts/publish-artefacts: publish the vcontainer-tarball
> =C2=A0=C2=A0=C2=A0 artefact so downstream test jobs can fetch a stable SD=
K.
>=20
> AI-Generated: Claude Cowork Opus 4.7
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
> =C2=A0config.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0scripts/publish-artefacts=C2=A0 |=C2=A0 5 +++++
> =C2=A0scripts/run-config=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 19 +++++++++++++++++++
> =C2=A0scripts/shared-repo-unpack |=C2=A0 1 +
> =C2=A0scripts/utils.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 22 ++++++++++++++++++----
> =C2=A05 files changed, 44 insertions(+), 4 deletions(-)
>=20
> diff --git a/config.json b/config.json
> index 7df4271..16d8a04 100644
> --- a/config.json
> +++ b/config.json
> @@ -1433,6 +1433,7 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
"step3" : {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "shortname" : "Populate/update dashboard site",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "NOBUILDTOOLS" : true,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "NOVCONTAINER" : true,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "EXTRACMDS" : ["${SCRIPTSDIR}/run-dashboard-index =
${HELPERBUILDDIR}/../"]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },

Why is this step needing to opt out of a vcontainer? vcontainers are
only enabled for specific steps and off by default?

I looked further and realised you're basically using a vcontainer
everywhere as far as I can tell? Why do we want to have the overhead of
doing that outside of the vcontainer builds?

For buildtools, it makes sense we need it everywhere except where we
configure otherwise but I think for vcontainer, you want to opposite,
you only use it in jobs where we actually need/use it?

Cheers,

Richard

