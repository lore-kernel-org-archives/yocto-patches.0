Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.167338.1712756520259338536
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Apr 2024 06:42:00 -0700
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so63538011fa.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Apr 2024 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712756518; x=1713361318; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X1S8rB6DtK48yqEsxuvUa5w7MITXKWdQSls2NZ5kreQ=;
        b=N6FQRgC0uY4skA1blU1Fzw3vNCyWxsXjNWflDf04df/BO5poj17KJDPLwavHQvuOdX
         mBMEF0ew0J5oz8kmTycAEjGtqdSNhg4BqNeGoJVQlSakBed6HDJ8tkytUyJRyZfP+cAy
         4TXqltWm5EAyEd7CZ7Dsa/k4EQUSvEh4kLQV4=
Return-Path: <richard.purdie@linuxfoundation.org>
Message-ID: <c1d708d4217c9a400c1ebf8a6978d9a76f553c77.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [PATCH 1/2] README: Switch to yocto-patches mailing list
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
Date: Wed, 10 Apr 2024 14:41:56 +0100
In-Reply-To: <1044c9e2-409e-4c6d-b0d5-95fbf27289dc@theobroma-systems.com>
References: <20240410092948.1989389-1-richard.purdie@linuxfoundation.org>
	 <1044c9e2-409e-4c6d-b0d5-95fbf27289dc@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: yocto-patches@lists.yoctoproject.org
Cc: openembedded-core@lists.openembedded.org, seebs@seebs.net, mark.hatle@kernel.crashing.org
List-ID: <yocto-patches.lists.yoctoproject.org>

On Wed, 2024-04-10 at 14:30 +0200, Quentin Schulz via lists.yoctoproject.or=
g wrote:
> Hi Richard,
>=20
> On 4/10/24 11:29, Richard Purdie via lists.yoctoproject.org wrote:
> > We're trying to align the various components so tweak pseudo to match o=
ur
> > other projects a little more and use the yocto-patches mailing list for
> > submissions.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> > =C2=A0 README | 17 ++++-------------
> > =C2=A0 1 file changed, 4 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/README b/README
> > index 468cf66..425ee6e 100644
> > --- a/README
> > +++ b/README
> > @@ -1,17 +1,9 @@
> > =C2=A0 pseudo -- an analogue to sudo
> > =C2=A0=20
> > -IMPORTANT NOTE:
> > +The official home for pseudo's git repository is:
> > =C2=A0=20
> > -As of this writing, the official home for pseudo's git repository has
> > -changed to:
> > =C2=A0=C2=A0	git://git.yoctoproject.org/pseudo
> > =C2=A0=20
>=20
> Maybe we could use https here?
>=20
> https://git.yoctoproject.org/pseudo
>
> for example?

We could, yes.

> > -The old site at:
> > -	https://github.com/wrpseudo/pseudo
> > -
> > -is no longer the "real" master, although I'll probably try to keep it =
in
> > -sync.
> > -
> > =C2=A0 OVERVIEW:
> > =C2=A0=20
> > =C2=A0 The pseudo utility offers a way to run commands in a virtualized=
 "root"
> > @@ -88,7 +80,6 @@ available for other people to look at.
> > =C2=A0=20
> > =C2=A0 CONTACT:
> > =C2=A0=20
> > -Discussions and patches should be directed at the openembedded-core ma=
iling
> > -list at openembedded-core at lists.openembedded.org. More information =
at
> > -https://www.openembedded.org/wiki/Mailing_lists. Bugs should be filed =
with
> > -the Yocto project at https://bugzilla.yoctoproject.org/.
> > +Patches should be directed at the yocto-patches mailing list at yocto-=
patches
> > +at lists.yoctoproject.org.=C2=A0 Bugs should be filed with the Yocto p=
roject
> > +at https://bugzilla.yoctoproject.org/.
>=20
> Maybe we want to add a prefix here too so we can identify easily for=20
> which project this is for?

It is implied, but yes, we should mention that specifically, agreed.

Cheers,

Richard



