Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404B4E909DA
	for <webhook@archiver.kernel.org>; Tue, 17 Feb 2026 16:44:38 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16459.1771346670162859999
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Feb 2026 08:44:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VD4p+Ubo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-436e8758b91so3655919f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 08:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771346668; x=1771951468; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xGmB/QTaTmJ3h+yElR3lULpCsJ8nZlGKp/zaRO/PGGM=;
        b=VD4p+UboELJB9DKixUT88PozZPvNscYFcdBB+VjN5KUklMAWxVvRk3G0V/KVxEz94H
         RKnXjdqRu9FuLKXzby18yoGikpzD/kgT+k8IN2H3yMeSRLSQUo7z6DC5xBMQnRzFDRMB
         flchvmy4prRw9XY5CWQ3SzsHZCvq7HnvXPsqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346668; x=1771951468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGmB/QTaTmJ3h+yElR3lULpCsJ8nZlGKp/zaRO/PGGM=;
        b=k4DA9C5K5guuZNC09duAhdeXnc3Yk8PJi/RAVcOim+ifuIA4vp/4MUWnPxCYx0A59e
         6ePdrdKfLKIvPfhtZzXRxbpE7qw8NLgTWSVCtdLBks0gmECxtGkVKCFPs6c6Tri6D4Z/
         pbSFcC9ZIxxPnhujbK12+tX9PIH19FV9JrxkrQtmK4+kI4/qJoCfnZhbjrsG4Pn6JPd+
         /W63Pg+Nj18EsUXjUdb/D/tFBq7hmCl3PM3J5K20h5cU3p+pbzA/FOYVWZymr9R8iaXr
         /NqukKiKcZzyigSjdqewH+h2wk1UudFCpfMyFTLzdnzxxuyLa6LqyFb1cu8NzHsR8ngb
         YdWA==
X-Gm-Message-State: AOJu0YxWEMxPkIZkxuQXAyN08BwYBXW5a4Ez53l1vSQtOm78BohHnCpd
	MIAINF/P7Ulpqv6pj5eI5BZZio+j5N6IKJhGNOkeTZrAdF3Q9tAsGQ42e7sagBCnB2Y43xqv232
	JjqhsQyE=
X-Gm-Gg: AZuq6aKtWa6AL3DzVmba1mCzGckCoNGwNbluMJwAqZG/YpJUW1DSg5v8azuJygc7Dpc
	9A3QFKxagHtqVxxkJt8QjAdpL9joe2V6eswRSLttDQhb55AWID0PdSBL22tee9RhxNXvDMKa6Zw
	h8kEChLqW6xg26i3CIiid6x+C66SfLWX7nGiJECTKk5l7YFX4hHBQJvwCCrgY6z8gcrLO2yG7mW
	BwQjQdo4WFhwtssnk9OncCeGLRX3kPSIjHzMT3b4yr9N1ew9tpyy2bLNVgumvek435yTCeE0GnZ
	j6Brzr6GfBzklCci3RzFVz4kaEoZ8b9fy1Zzf4vCqvHM/CJ5qz+uUnx968JWs5BFHjgpToCwfkQ
	2cp3Tj+bijLrJmVmNZkaHUS5+z36l2KpIl7oLBTEheDGWip4HlLXu2tven55jyhjDABkLRadsSO
	ySOGRe77Zjzl2m8EE0tuKer9ZjRSqrT28lBOC/BF6Tx1Mv7QrzUxJdqw834xJIys6VYsTzt0Hy7
	NEiCzrlVRbXLJY=
X-Received: by 2002:a05:6000:40ca:b0:436:1a2e:9f1c with SMTP id ffacd0b85a97d-4379db35a92mr23269380f8f.19.1771346667978;
        Tue, 17 Feb 2026 08:44:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:f0dd:6d04:6647:fd3d? ([2001:8b0:aba:5f3c:f0dd:6d04:6647:fd3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm36629045f8f.32.2026.02.17.08.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:44:27 -0800 (PST)
Message-ID: <59b56ed7ba399f476c72c1375dc3f84d14b10220.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] ports/linux: define
 __NR_openat2 if missing
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 17 Feb 2026 16:44:26 +0000
In-Reply-To: <CAMKF1soOjJDt_UaK4e2wjn6anusCAaa0NnNXzEpkBESnsDVEuw@mail.gmail.com>
References: <20260217154814.483670-1-yoann.congal@smile.fr>
	 <CAMKF1soOjJDt_UaK4e2wjn6anusCAaa0NnNXzEpkBESnsDVEuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Feb 2026 16:44:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3250

On Tue, 2026-02-17 at 08:38 -0800, Khem Raj via lists.yoctoproject.org
wrote:
>=20
>=20
> On Tue, Feb 17, 2026 at 7:48=E2=80=AFAM Yoann Congal via
> lists.yoctoproject.org <yoann.congal=3Dsmile.fr@lists.yoctoproject.org>
> wrote:
> > From: Yoann Congal <yoann.congal@smile.fr>
> >=20
> > On kernel <5.6, __NR_openat2 is not defined. To support build on
> > these
> > older kernel, define __NR_openat2 at the value it has on every
> > kernel
> > since 5.6: 437 [0].
> >=20
> > [0]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
> >=20
> > Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> > ---
> > =C2=A0ports/linux/portdefs.h | 10 +++++++++-
> > =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/ports/linux/portdefs.h b/ports/linux/portdefs.h
> > index a8b2be6..32b95ba 100644
> > --- a/ports/linux/portdefs.h
> > +++ b/ports/linux/portdefs.h
> > @@ -54,7 +54,15 @@ GLIBC_COMPAT_SYMBOL(memcpy,2.0);
> > =C2=A0#endif
> > =C2=A0#endif
> >=20
> > -/* Debian 11 and Opensuse 15.5 need this */
> > +/* Ubuntu 20.04, Debian 11 and Opensuse 15.5 need this */
> > =C2=A0#ifndef SYS_openat2
> > +
> > +/* On kernel <5.6, __NR_openat2 is not defined. Import the
> > definition from=20
> > + *
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dfddb5d430ad9fa91b49b1d34d0202ffe2fa0e179
> > + */
> > +#ifndef __NR_openat2
> > +#define __NR_openat2 437
> > +#endif
> >=20
>=20
>=20
> it will fix compile time problems but I wonder if it will run okay on
> kernels < 5.6 ?

It will be fine. The code should simply never get called and even if it
did, it is just returns an error code so it wouldn't make any
difference to the standard behaviour.

Cheers,

Richard

