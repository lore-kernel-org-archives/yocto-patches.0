Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9604ACD6E7D
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 16:02:27 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11572.1780675346753259457
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Jun 2026 09:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YZUiLgre;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-becfa735b9aso296644866b.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780675345; x=1781280145; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fF3Japg9zkeylgBXTQ5W+2yJr7C6Ayl1n0BUxrFqbqQ=;
        b=YZUiLgre1L/dYa1UlOfkBO/Xo+sj8b+iA0U7P2X4xw5mp5VnaNBi2UT6a0rb4l3HMy
         mT3uAANJ5RWOOSv7MKd7N1JnCmcFwt5M4LevDuv5RK24NrGgVO3CNQfFG+O7FNVKkOIl
         kiLwWuSG5cYLqElYPcPehbAqizUdvCjpKH53s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675345; x=1781280145;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fF3Japg9zkeylgBXTQ5W+2yJr7C6Ayl1n0BUxrFqbqQ=;
        b=JWytFH18OSBKF0Jfb+a8zJ2bNBjPq8a1+md79q6mm9mpHXM7lnFyn59tesSa8znvp4
         FDZ17Z0pTIuKAGFcU1/hDxOVMJz28zDchBZaKNT3nQqxXCy2YBRyOcawOyIFjezMXWJS
         ZTYOrsilQxWmUatQgGimhqT6vhB31bDXGIcOn7Ctc9cARIy6e9rX7KnleICp7R19wZ6t
         rpb+q6cEu7Vrct4VUxseUE3hesZwj6PlKHXFXxtRF2SdTqA8T9SCrOvZlZ5KE43oZ7Gn
         PHKY4LG1yvaphbxA5VPRQ1gFmJ9sc6Sil1cHLzdcLnvG6CsAsOvI24LDDuIrKWBNsuID
         Gw8A==
X-Gm-Message-State: AOJu0Yxj1yPzR0P4Jkiede9EVdPEXwlu95XBFYzYK+ds0K+uZ+tZixJQ
	sEIy709ulJPTJmKAAzcJWgiPjqh7ieoHeQxRbIjOY5vxTklXymgFbRRFGaBSQXVw9EOSqbccDEy
	5LlFz
X-Gm-Gg: Acq92OH77mkEjmqT3PbdNlWpc6WafvykRQY8m51usdW2vgav8dw8htda+evy33Ar+y7
	lbfTvB3Bm1T2SLWENUGQa3jNfGHgmpacuppTTZkBharzr7Eo62Ci48S+RQBX4eoYrDuQRTOn6qh
	y00UDZJUf0KRfpAkSwC0M6grGHhf1EkIhiW9+e0i+P5yFczdPNm1y1rqnN9Q/w/HpQ6HYp1n6Ln
	iFANaHEx7jCDyskrwK/yzr0eVgxS88wZPBEJNGzexi5lOqZn5gTUbvFLZd+Zn2XzWncBXkKIhe+
	WoVPMKxmZwJXpMzSAgTJz8MVYa07B4p2753WrtojMn27HaxIKXY+OH3TXATVBq40spr2vLgE+2U
	RhVnSzFG+21wAE4ZLR6p38hKhcW9rJLSjn1UJj1HhHW6mFkNKiessQoCXaPhbMjggYgkSnyB62X
	+Zc9tIQgYLn9OXUfxJAEA4dJudk1hCKROm47QTTa/kEUnJo8+tV9N0iCAJ9vxmEp2pUj4d9G8WZ
	/scUOUrfYJOUI0huoI9VUbNR1U=
X-Received: by 2002:a17:907:160f:b0:bed:2a8b:3e73 with SMTP id a640c23a62f3a-bf3739f9bc3mr256705566b.41.1780675344686;
        Fri, 05 Jun 2026 09:02:24 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:176b:6db2:d527:85f4? ([2001:8b0:aba:5f3c:176b:6db2:d527:85f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm44836642f8f.29.2026.06.05.09.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:02:23 -0700 (PDT)
Message-ID: <302c406db158cfeb89b44ba879e1a2407f42a9a2.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH v2 05/10]
 scripts: add vcontainer-tarball setup, integration, and publishing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Tim Orling
 <tim.orling@konsulko.com>
Date: Fri, 05 Jun 2026 17:02:22 +0100
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
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Jun 2026 16:02:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4151

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
> diff --git a/scripts/publish-artefacts b/scripts/publish-artefacts
> index e56e131..0e820e9 100755
> --- a/scripts/publish-artefacts
> +++ b/scripts/publish-artefacts
> @@ -146,5 +146,10 @@ case "$target" in
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256sums $TMPDIR/deplo=
y/images/qemux86-64
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp -R --no-dereference -=
-preserve=3Dlinks $TMPDIR/deploy/images/qemux86-64/*qemux86* $DEST/patchtes=
t
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> +=C2=A0=C2=A0=C2=A0 "vcontainer-tarball")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir -p $DEST/vcontainer-tar=
ball
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sha256sums $TMPDIR/deploy/sdk
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp -R --no-dereference --pres=
erve=3Dlinks $TMPDIR/deploy/sdk/*vcontainer* $DEST/vcontainer-tarball
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
> =C2=A0esac
> =C2=A0
> diff --git a/scripts/run-config b/scripts/run-config
> index e896234..0f5a26a 100755
> --- a/scripts/run-config
> +++ b/scripts/run-config
> @@ -153,6 +153,25 @@ else:
> =C2=A0=C2=A0=C2=A0=C2=A0 if args.phase =3D=3D "init" and args.stepname =
=3D=3D "buildtools":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sys.exit(0)
> =C2=A0
> +if jcfg:
> +=C2=A0=C2=A0=C2=A0 vcontainer =3D utils.setup_vcontainer_tarball(ourconf=
ig, args.workername, None, checkonly=3DTrue)
> +=C2=A0=C2=A0=C2=A0 if vcontainer:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addentry("vcontainer", "Setup=
 vcontainer tarball", "init")
> +else:
> +=C2=A0=C2=A0=C2=A0 # If we're executing a specific step, check whether v=
container is disabled for it
> +=C2=A0=C2=A0=C2=A0 vcontainer =3D True
> +=C2=A0=C2=A0=C2=A0 if args.stepname in ("build-targets", "cmds", "test-t=
argets", "plain-cmds"):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vcont=
ainer =3D not utils.getconfigvar("NOVCONTAINER", ourconfig, args.target, in=
t(args.phase))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except ValueError:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Not=
 an integer step phase
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass

I suspect this logic also needs to be in the if jcfg block above, else
it will add the task to all jobs on the autobuilder, then just do
nothing in the task. If there isn't anything to do, we may as well just
not add it all?

Cheers,

Richard

