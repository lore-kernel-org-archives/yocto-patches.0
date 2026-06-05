Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9986ECD6E7C
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 16:11:07 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11639.1780675863327369776
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 09:11:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KlRTcLsl;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b7866869so25165605e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780675862; x=1781280662; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxWJQ1B/TYAKMN+15y3bPvrmhTuNk/EcjU8c/1tKMEs=;
        b=KlRTcLslsYu6gpidMmP4Us9NF75XHZij5kGGH4UkZaEJwbzmdPh2UrsDezlE9NvyIb
         opJAR6nIIYltvg1F5TC/3lS+BpFZnUDufwnvl0+xckOJfm7W1GH5WptJ4mmhdOofIxPw
         K003V41nbQ5hfsZ/RqOoonACqUEknFSAUrlEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675862; x=1781280662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxWJQ1B/TYAKMN+15y3bPvrmhTuNk/EcjU8c/1tKMEs=;
        b=onDRDDRITSWOdg8jK9A5G1bSep6wxrEcb7ZlNsHui1/btX/PNRyNPqYi7eAKlSmzOh
         O8esorK5JdsZIkTtXxrUlnlUR5PklWP95yaUVribpJMq6n8Ys56qb5v4J1smlTcTf7XW
         FHHskQ52gEnW+H4ECKOFhqMb38noMO7bznpghKvA72cJIDQxhYdhlObGeEyt1chp9xXM
         btdAX3gKEYfkBqDHG1pNaxKoNHjti5Gqv0Be05CYo/ZaKWa8fifUmai46qUBWNRxN0gj
         2HdsuBqJzQS6ar2gi13qMX8IpFrYR8kJTx1M7bZdWOu+52l/smAnURlZMruyXdJ+MhpY
         fqvg==
X-Gm-Message-State: AOJu0YzuzpqdEqd+vM5E1upzuw5TjQoFL8WPZMTGk9ZvcLcg35edG8Wb
	bjxigApAIADRhjikdakQYZ49umcct437iowRcjet3jd4iAGhr1JOTVi3F0LBZwPW9u/xCmfhkVy
	kXew0
X-Gm-Gg: Acq92OHXoIrAD7x9vVIpgZ6mTgE+ZFNy64xBt+qdXEnDtp+6z3zqVGulejAGViwKyaf
	bdivgggkpXfNwm4ba3EEnnJ06O0O25+H5QkS6kELPA7AQoLcnNwjAF8ILgtKujz/goG1diRLv+B
	IPogXtbylds9aOzensiSGHHerfKVyvdK4h60eSAM2KAiYDrmIzREjsqKE8xSs/PydvtcNdeZaw3
	mhU53KzMkHFAAyWVDPLt42uY7WbC7dJzKTisjkQ1Lw6NP9g9vMBKBe7yR50kvIPxQGeMEWJay0S
	BDOsBTvBYb3S3IYJZBNgZQSkHyGOX9kQ9BYB8jqzrjPoeyWqtczfunIXcNE0wAhSVvD6NmDAn16
	jm2Cra1xa4BhbbYcrw1M7kQglVI532HE2tr41QO4E36YCJGpPh+xCOPqonl/QbEi3+BwxklQOzF
	EQS36Km6ASI6g3dgmzJFkytA+dT90ukdrX0ZhmpHLltowAA0MgSGZmMV384y8MSb1h7Vv7+7g7t
	cio0pq7FjrTzPvl8VRYZ9vKNYw=
X-Received: by 2002:a05:600c:6389:b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-490c26233abmr74227675e9.20.1780675861543;
        Fri, 05 Jun 2026 09:11:01 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:176b:6db2:d527:85f4? ([2001:8b0:aba:5f3c:176b:6db2:d527:85f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm29557926f8f.5.2026.06.05.09.11.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:11:00 -0700 (PDT)
Message-ID: <ca446c8a5f4a9281fcabf9728efc6ee9f9bb6610.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 08/10]
 scripts: add container registry push, auth, tagging, runtime selection
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Date: Fri, 05 Jun 2026 17:10:59 +0100
In-Reply-To: <31f010d5e7dbc1e2307dfb00f06a9b6380a19c5c.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
	 <31f010d5e7dbc1e2307dfb00f06a9b6380a19c5c.1780354513.git.tim.orling@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 16:11:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4152

On Mon, 2026-06-01 at 16:18 -0700, Tim Orling via lists.yoctoproject.org wr=
ote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Add the push-containers infrastructure that drives the
> post-build steps for the 'containers-library' job. After
> each build step the runtime container store is harvested
> and pushed to one or more registries with derived per-step
> tags.
>=20
> * config.json: add CONTAINER_REGISTRIES, CONTAINER_AUTH_CONFIG,
> =C2=A0 CONTAINER_RUNTIME, CONTAINER_TAG_CMDS, CONTAINER_VERSION_RECIPE
> =C2=A0 and CONTAINER_IMAGE_MAP configuration knobs.
> * scripts/run-config: drive push-containers as a post-step
> =C2=A0 action. Tags are generated from recipe and distro metadata
> =C2=A0 (yocto- tag uses major.minor on snapshots and full PV on
> =C2=A0 releases) with CONTAINER_VERSION_RECIPE allowing a step to
> =C2=A0 source PV from a different recipe than the image itself.
> * Registry auth is staged via .../config.json or podman
> =C2=A0 .../auth.json using CONTAINER_AUTH_CONFIG, replacing an
> =C2=A0 interactive login that could hang. CONTAINER_RUNTIME picks
> =C2=A0 between vdkr (Docker-compatible) and vpdmn (Podman) runtimes.
> * Robustness: skip gracefully when no registries are configured,
> =C2=A0 fix the OCI directory path, handle memres already running,
> =C2=A0 and avoid hanging when memres has not yet come up.
>=20
> AI-Generated: Claude Cowork Opus 4.7
> Signed-off-by: Tim Orling <tim.orling@konsulko.com>
> ---
> =C2=A0config.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 5 ++
> =C2=A0scripts/run-config | 129 ++++++++++++++++++++++++++++++++++++++++++=
+++
> =C2=A02 files changed, 134 insertions(+)

This is adding way too much code for a specific use case to run-config.
This needs to be in a separate script (in the same way docs builds or
other things are).

Cheers,

Richard

