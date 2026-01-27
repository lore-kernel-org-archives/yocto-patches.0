Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B71D2D8F5
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 10:46:38 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7974.1769510790575701140
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Jan 2026 02:46:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Mln/WKNl;
 spf=pass (domain: smile.fr, ip: 209.85.221.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso3381889f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 02:46:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769510789; cv=none;
        d=google.com; s=arc-20240605;
        b=Po8KxlNg/8XJ6ZCB/Aj6pHg1w6vvRMNQ9E2I37zv2fL8cHnwuOQprAL31jBlM+J81U
         PuS3FwEUkRH+VdiEBOki6JAFMNKXpwlMrz1XzALUzAy2uOiXidn6evp077gqugthm0Ai
         2Z7jyUT0RaG/yfc2HYRpvLntCkU4HwV4dmE76czLQHdqIaq3Q8qluuIt80iOVZkYb6XI
         ty4NXE2qodU/fxNzwNrX2ixibkAGPVdG42azS5L5UygYCR9oa0SHACeezYbiAt71B2ck
         8SAAmRARbM7KFItr2fzy+5TKA+S6zJ/qw2No4BPxOIGmpbEUkPJRQu1rTpw5JSHLku1t
         xuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+YaPYQSFjyc8CaZWVtyqciLsFd6yy01wTd/YEDbbod0=;
        fh=G2FF0qTK6PgfO3whISghi4ipu10huCXGE0j+uqU1bmg=;
        b=RceVuGcFNwK/ShWeGAIIADHT/A3OIJanrBX7aoxcotethxXwaW/DqvGrpfR0jlwaaF
         Qi73cA4U/lgJ4HltKtyzDvFjkIlVl3Namfpw2Kce5VsrLuuZp9AMyvSvzb32N9FPMxeM
         SljHIWWDP4qLxRyMUvHVtYMAi5LVJjk8VYh+w0QbbtxONol494whLpu1P9H2SobDGGx3
         HIUUfwiSZV9LFT8IbRdMufjFe8kgs3+sWwTiA6Z8xPTOkjnPcn/n+rJ3ElvMO83wEObk
         SqIk1iNRJ2J65DF1S+sQB2swdHNCl4uTk3N+gkIJNUNTh4wUVjrs4U+8FrxH5oa7xMnK
         /R6Q==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769510789; x=1770115589; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+YaPYQSFjyc8CaZWVtyqciLsFd6yy01wTd/YEDbbod0=;
        b=Mln/WKNlKWqAeB79KN5cz4eaOozWKRQW3vqW+6NN20AQLX3mmfbLRGtHc/LRgva04u
         Y/AbkOFJwbd8MqkSgH+UzmLOnY6zHPzzXsvLy5k5QG5sB+jkSNes8pPLgLXYGoi8+fNg
         URgAtqdsbq3hsQemcADdeIhwpTHESqtQTlbCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769510789; x=1770115589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YaPYQSFjyc8CaZWVtyqciLsFd6yy01wTd/YEDbbod0=;
        b=NcbrRvV9LGnPrA5BpIn4xtBwLE6vrjUD5eS71DS8DUDYnl7s5ofOZtuTBxsczXnuXb
         /1V71xVQ7BlvZ8txR+7BsCcoOJd+x06ulcW/Zb643V0vdk9uHM8EOKkvxJWC1Ddgld7P
         YJlgnIad5MhuHUkKBe60S85orz0ZcUTW089EM4yMNb0AvOkBn7fNZiiPebhIZZRlMlS+
         384mq6+fUsntXGL6yf12iCVANWjuNT1pGX/pqF5OOJZIdtPUG/VMtP28p0FoMSMr34dj
         ikdzSwmUghmiebTCDFXqEJ2EnCnD4Y8cZV2dRPK0p1p6A0SVW4ePTTlnUhqDuMjUgngW
         OjGw==
X-Gm-Message-State: AOJu0YysGA/FYxhGhLcc/CBL6VQD1Yd4qCJcu3f7gzKYTW/qTXuu3q/6
	uvfvCDYvNvtJCOQGwrZn3SQSqKP4YL5+pz8VTBzvxbz58+mZqvVlrbiDVHVXB0nZUAYkkFarsEx
	msAz6HCBrnk1jl/Y2vx2t3MIw9O4SKR8Vr0GlRE9iQQ==
X-Gm-Gg: AZuq6aJJ4YIUijQmmCNkcvVSOTyKhvFuWjXq8refzxkaekXns1r8dVYxPAQkwBO4xzz
	GMBhXXl2EwLDLVgfYe/w8ySVRbnp2j+shXhaFjgYe6ApN9cpB1S8I5oIy96jzculkb6pWsuuOYI
	zrYtBFyArQO6dFXEMETlw1Wu2sUwejGfPmRXNtvwejWvCitBW/L7Syi8fEBfNRP36qLXt9udocN
	+MP7HdD25qSe9LI/wNn7QguXZVuTHmMvFKNldbiJrUw4wPaCfByhiU70Y5sXU5Xf72yTjqY0v19
	PGd9a+sOtthp1QE7QhUTPx1qVebH
X-Received: by 2002:a05:6000:1a89:b0:431:3ba:1188 with SMTP id
 ffacd0b85a97d-435dd02e21bmr1856456f8f.3.1769510788877; Tue, 27 Jan 2026
 02:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20260126085252.178615-2-yoann.congal@smile.fr>
 <aXcy6iZSrBkErjvm@nuoska> <CAMSfU+7Tm8W9ZBej-L7S9tJVUo6wJx6tQmiUBWavY9XpHdJ+8Q@mail.gmail.com>
 <CAMSfU+5Kx7GNqRgymCn0WzKGZZfz7E7Pt5tZNLi+U1bn5aTjYA@mail.gmail.com> <aXiJLd11pS_eKmRS@nuoska>
In-Reply-To: <aXiJLd11pS_eKmRS@nuoska>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Tue, 27 Jan 2026 11:46:03 +0100
X-Gm-Features: AZwV_QgK6xF5p5d0DHvBWfDa1hJl00bVs7deqLeCZWu2CHNdfNolmyx5mhjjE_U
Message-ID: <CAMSfU+4+F9ahjCA1oh-KeR3SUsuF3wKFca3rYQDOPqocwM2MJg@mail.gmail.com>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] send_qa_email:
 add git-describe output if possible
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000ff5e0f06495c558b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 27 Jan 2026 10:46:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3116

--000000000000ff5e0f06495c558b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 janv. 2026 =C3=A0 10:45, Mikko Rapeli <mikko.rapeli@linaro.org> =
a
=C3=A9crit :

> Hi,
>
> On Tue, Jan 27, 2026 at 10:40:10AM +0100, Yoann Congal wrote:
> > Le lun. 26 janv. 2026 =C3=A0 15:19, Yoann Congal <yoann.congal@smile.fr=
> a
> > =C3=A9crit :
> >
> > >
> > >
> > > Le lun. 26 janv. 2026 =C3=A0 10:25, Mikko Rapeli <mikko.rapeli@linaro=
.org>
> a
> > > =C3=A9crit :
> > >
> > >> Hi,
> > >>
> > >> On Mon, Jan 26, 2026 at 09:52:53AM +0100, Yoann Congal via
> > >> lists.yoctoproject.org wrote:
> > >> > From: Yoann Congal <yoann.congal@smile.fr>
> > >> >
> > >> > This would allow to quickly identify commits that are not on the
> right
> > >> > branch.
> > >> >
> > >> > Partial example of output on my whinlatter-nut branch:
> > >> >   bitbake: 74f8a927ca6a20342072e5579182aea917b6dc30
> > >> (yocto-5.3-3-g74f8a927c)
> > >> >   meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a5bf54c07
> > >> (yocto-5.3-1-g6973ca6)
> > >> >   openembedded-core: b4e7819b99d9c1a8995eba87e6f466fd8c77e14a
> > >> (yocto-5.3-73-gb4e7819b99)
> > >> > (It shows that every commits are correctly after yocto-5.3)
> > >>
> > >> The output may or may not work, and may actually confuse users:
> > >>
> > >> bitbake$ git describe --match yocto-* origin/master
> > >> yocto-5.3-52-gcdd79c1768ac
> > >> core$ git describe --match yocto-* origin/master
> > >> yocto-5.1-4541-g6c31c2a73185
> > >> meta-yocto$ git describe --match yocto-* origin/master
> > >> yocto-5.0.10-40-gc23c19e0b300
> > >>
> > >> and I don't seem to be able to find out in a few minutes which branc=
h
> > >> of bitbake is used with core and meta-yocto whinlatter branches
> > >> since the branch is not called "whinlatter" but bitbake version.
> > >> Oh bitbake
> > >> default-registry/configurations/oe-nodistro-whinlatter.conf.json
> > >> has it as "2.16" but openembedded-core doesn't seem to know which
> bitbake
> > >> version is correct for whinlatter.
> > >>
> > >> I hope this works for "whinlatter" and other releases in the future
> > >> but the tags are a bit messy stil.
> > >>
> > >
> > > Yes, agreed. That works well only for stable branches after the first
> > > release.
> > > Maybe we can only take this patch for those branches?
> > >
> >
> > This is something I can check locally before greenlighting a build for
> QA,
> > just tried it for 4.0.33-rc3.
> > =3D> We can drop this patch.
>
> Is there any possibility to fix this for yocto 6.0, for example that
> yocto-6.x.y tags
> would be aligned on master branches too?
>

I guess not : the releases/tags are usually done after the stable branch
separates from master =3D> the 6.0 tag will most likely *not* be on master.
(Or have I misunderstood your question?)


> Cheers,
>
> -Mikko
>


--=20
Yoann Congal
Smile ECS

--000000000000ff5e0f06495c558b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0mar. 27 janv=
. 2026 =C3=A0=C2=A010:45, Mikko Rapeli &lt;<a href=3D"mailto:mikko.rapeli@l=
inaro.org" target=3D"_blank">mikko.rapeli@linaro.org</a>&gt; a =C3=A9crit=
=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Jan 27, 2026 at 10:40:10AM +0100, Yoann Congal wrote:<br>
&gt; Le lun. 26 janv. 2026 =C3=A0 15:19, Yoann Congal &lt;<a href=3D"mailto=
:yoann.congal@smile.fr" target=3D"_blank">yoann.congal@smile.fr</a>&gt; a<b=
r>
&gt; =C3=A9crit :<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Le lun. 26 janv. 2026 =C3=A0 10:25, Mikko Rapeli &lt;<a href=3D"m=
ailto:mikko.rapeli@linaro.org" target=3D"_blank">mikko.rapeli@linaro.org</a=
>&gt; a<br>
&gt; &gt; =C3=A9crit :<br>
&gt; &gt;<br>
&gt; &gt;&gt; Hi,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Mon, Jan 26, 2026 at 09:52:53AM +0100, Yoann Congal via<br=
>
&gt; &gt;&gt; <a href=3D"http://lists.yoctoproject.org" rel=3D"noreferrer" =
target=3D"_blank">lists.yoctoproject.org</a> wrote:<br>
&gt; &gt;&gt; &gt; From: Yoann Congal &lt;<a href=3D"mailto:yoann.congal@sm=
ile.fr" target=3D"_blank">yoann.congal@smile.fr</a>&gt;<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; This would allow to quickly identify commits that are no=
t on the right<br>
&gt; &gt;&gt; &gt; branch.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; Partial example of output on my whinlatter-nut branch:<b=
r>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0bitbake: 74f8a927ca6a20342072e5579182aea917b=
6dc30<br>
&gt; &gt;&gt; (yocto-5.3-3-g74f8a927c)<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0meta-yocto: 6973ca663aaa9c3ab517ee960ab7985a=
5bf54c07<br>
&gt; &gt;&gt; (yocto-5.3-1-g6973ca6)<br>
&gt; &gt;&gt; &gt;=C2=A0 =C2=A0openembedded-core: b4e7819b99d9c1a8995eba87e=
6f466fd8c77e14a<br>
&gt; &gt;&gt; (yocto-5.3-73-gb4e7819b99)<br>
&gt; &gt;&gt; &gt; (It shows that every commits are correctly after yocto-5=
.3)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; The output may or may not work, and may actually confuse user=
s:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; bitbake$ git describe --match yocto-* origin/master<br>
&gt; &gt;&gt; yocto-5.3-52-gcdd79c1768ac<br>
&gt; &gt;&gt; core$ git describe --match yocto-* origin/master<br>
&gt; &gt;&gt; yocto-5.1-4541-g6c31c2a73185<br>
&gt; &gt;&gt; meta-yocto$ git describe --match yocto-* origin/master<br>
&gt; &gt;&gt; yocto-5.0.10-40-gc23c19e0b300<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; and I don&#39;t seem to be able to find out in a few minutes =
which branch<br>
&gt; &gt;&gt; of bitbake is used with core and meta-yocto whinlatter branch=
es<br>
&gt; &gt;&gt; since the branch is not called &quot;whinlatter&quot; but bit=
bake version.<br>
&gt; &gt;&gt; Oh bitbake<br>
&gt; &gt;&gt; default-registry/configurations/oe-nodistro-whinlatter.conf.j=
son<br>
&gt; &gt;&gt; has it as &quot;2.16&quot; but openembedded-core doesn&#39;t =
seem to know which bitbake<br>
&gt; &gt;&gt; version is correct for whinlatter.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I hope this works for &quot;whinlatter&quot; and other releas=
es in the future<br>
&gt; &gt;&gt; but the tags are a bit messy stil.<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Yes, agreed. That works well only for stable branches after the f=
irst<br>
&gt; &gt; release.<br>
&gt; &gt; Maybe we can only take this patch for those branches?<br>
&gt; &gt;<br>
&gt; <br>
&gt; This is something I can check locally before greenlighting a build for=
 QA,<br>
&gt; just tried it for 4.0.33-rc3.<br>
&gt; =3D&gt; We can drop this patch.<br>
<br>
Is there any possibility to fix this for yocto 6.0, for example that yocto-=
6.x.y tags<br>
would be aligned on master branches too?<br></blockquote><div><br></div><di=
v>I guess not : the releases/tags are usually done after the stable branch =
separates from master =3D&gt; the 6.0 tag will most likely <b>not</b> be on=
 master.</div><div>(Or have I misunderstood your question?)</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">

Cheers,<br>
<br>
-Mikko<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div><fon=
t face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>
</div>

--000000000000ff5e0f06495c558b--

