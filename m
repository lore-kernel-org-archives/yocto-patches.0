Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32900C44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 10:57:48 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6480.1784545047788673551
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jul 2026 03:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=K5KpCCII;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49546c690ffso24118955e9.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784545046; x=1785149846; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2qC5k/gZSvPG3NFjZ7/HnhVQIFBAHMkU3k+V+hdQ/jo=;
        b=K5KpCCIInXGYuqFhEJ7OAfx1yOB34AVv2+Qzim1ETFz386+Nf23gFAfXl4J3ENw2/m
         NvFTCs/N0WMa2ObgabfunOfgAV+HlSJILq46RwZXMqXzUEZJ0XqxKVC1h46Fhz5eFPMQ
         +yRrcJtTgFZABXBPk8dCcOKdGraPBFKzndkQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784545046; x=1785149846;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2qC5k/gZSvPG3NFjZ7/HnhVQIFBAHMkU3k+V+hdQ/jo=;
        b=XIaxZcQLQNoDc0Ir/eCxkJbYpbnI7VAVEAT53fGpVa48BGYGsci9/Wx2pCUaAscblD
         P3LmbiqyquTUHQlKMU4MZWeekI/VxWapCAo2NWE39wKyujxKJnSpNkWZx670AhB4cplB
         jOOcPIErQSMM003IgWvAYc/oWdgbgjtgpNEvLNv2I6zs6elRErSIqqvvj7hWpT/V0lWH
         /BkeCJTiFdBG1JV/8R5q11W0CIc0HT8SSZn6pCgUWMOoaSsuclZP0sb3IztWZyOZunhQ
         KRTANXnjC9f+3NGVzZXC/1DEpXH0n4tzDnc4opPcFoaNm3oyiaPMFxZn5QKyfKeEpW9E
         Z66A==
X-Gm-Message-State: AOJu0YypSa8GhuQgd21PfBOMvvuyqkzRyZHPxfnSqJWl6RWiLn+9Kxo5
	POgpNW6eXSisAFv/CYv3UOrTJd1yPdxQsP2rmwPkxnnQk9RV9sxGlWECEgPjcX26jH6oPkSHGb2
	oJykdreg=
X-Gm-Gg: AfdE7cmJzpd59AomXcsiV7cEQRcSrOOrhItCQ7buPddLLlYXS36OMbJxYAsDymbyAEP
	QO/MDNLIKnMZUcxhM3SZhGIBrhZx8YmDNzYpFk1M7wswe+NLI2UvHHiVaeHqhBACdedIu2rHJqK
	pWB3FRpT9JQe75OxxRqc4Rt/4O7tmBOFot2KzRGmWCmFK92RWwG0zXR2juUhRXaUHVqXllgfan6
	5ACsqY+Mq/BrqrMjn14dSMYe/ROg4Qw3TooxNOtCEwSye7MUkqf4hj/BTJ2Jv+71o0NiGDrciuB
	RMcoOelueEQSIlPV3ne4kiGS2UlhnQjuAOU/9QS1q4WuBWWI8zVb53arsuYgaXSUUYG70WgQVJA
	CRm1KEUMMi7cPCMNakweEvD3ycMEXJWyoaXS17r48qwltIil58npYEMBQRl21JfpcEhk7/n0G1c
	c3fNxViU92CvAAYf49FI1OOXCQbSiP7QvT1/Led7ApnM1gSYay0TTyZLujDOa6kCEWOgg=
X-Received: by 2002:a05:600c:c84:b0:495:4689:1e98 with SMTP id 5b1f17b1804b1-4954a3ed426mr143273075e9.10.1784545045857;
        Mon, 20 Jul 2026 03:57:25 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:f231:f082:3d95:2084? ([2001:8b0:aba:5f3c:f231:f082:3d95:2084])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e0fcdbsm231314955e9.2.2026.07.20.03.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:57:25 -0700 (PDT)
Message-ID: <bfa91ba664b418978025bee76de5b95b347c9a4a.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] linkat: Fix AT_EMPTY_PATH
 handling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net, mark.hatle@kernel.crashing.org
Date: Mon, 20 Jul 2026 11:57:24 +0100
In-Reply-To: <44c06d871d07e71812c83752f6cfe6d6c52cbf0d.camel@pbarker.dev>
References: <20260717131943.3386262-1-richard.purdie@linuxfoundation.org>
	 <44c06d871d07e71812c83752f6cfe6d6c52cbf0d.camel@pbarker.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jul 2026 10:57:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4521

On Mon, 2026-07-20 at 11:37 +0100, Paul Barker via lists.yoctoproject.org w=
rote:
> On Fri, 2026-07-17 at 14:19 +0100, Richard Purdie via
> lists.yoctoproject.org wrote:
> > Currently we don't cover the case where AT_EMPTY_PATH is set for atlink=
.
>=20
> Typo: s/atlink/linkat/
>=20
> > Update the code to handle this case in a similar way to the /proc/self
> > case which is similar.
> >=20
> > This is used by some systemd tools which OE might run at rootfs time
> > such as hwdb generation.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0ports/unix/guts/linkat.c | 7 ++++++-
> > =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/ports/unix/guts/linkat.c b/ports/unix/guts/linkat.c
> > index 60fbf63..36ffc0f 100644
> > --- a/ports/unix/guts/linkat.c
> > +++ b/ports/unix/guts/linkat.c
> > @@ -35,13 +35,18 @@
> > =C2=A0	}
> > =C2=A0#endif
> > =C2=A0	oldpath =3D oldname;
> > -	if (pseudo_chroot_len && !strncmp(oldpath, pseudo_chroot, pseudo_chro=
ot_len) &&
> > +	if (oldpath && !*oldpath && pseudo_chroot_len && !strncmp(oldpath, ps=
eudo_chroot, pseudo_chroot_len) &&
>=20
> Should this be if (oldpath && *oldpath && ... ?
>=20
> i.e. if oldpath is non-NULL and has non-zero length.

Well spotted, I've sent a v2, thanks.

Cheers,

Richard

