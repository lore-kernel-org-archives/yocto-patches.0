Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB21049519
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 09:38:15 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17239.1773221890211423983
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 02:38:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bMWdot4/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48538c5956bso7916775e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 02:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773221888; x=1773826688; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0uv3U0kX/zz1FHnYuG2qxEiWhIlePkZzIVEcx8y5HEk=;
        b=bMWdot4/eB0tpfTV6bU/S/CqD+EQ9tmqMiQO7GBt53jidGNVbA8CipKoYtI08jbmwY
         5OG4YN8hDM5CX0iQF/+N0nEGvqAd6CfhZStEsSJgcKCQXExf0tsN7ZLLMeRSWeX4UDMQ
         71318ok4zqX0HM08dRq98L/zYVUUPWo7y4jh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773221888; x=1773826688;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uv3U0kX/zz1FHnYuG2qxEiWhIlePkZzIVEcx8y5HEk=;
        b=d3wb5cmbiQ4QeuL7isPF9xKG5ig3GUSU78dAELGn2iLG3DnAQN2hMYY8hyRVeR1NBf
         JrXjcD0SSYhwPr/Gdnh/i37P6lNrmfFe4RDqtcvAdZTFyyCPS4wmpt6JY41ckiwytLE3
         Kw4HMv5iDzwnlqYKEQEw7hsK3B3w8B1IJBT6vV/BNAT4LFoIL3C16+E9XLey/SM5Ajhf
         oGb/NR+u9RTecGZc/bal4+mYDUmaZ/c/seDXLnBTLSCs5beWLI6/QQxadPSvdPVjhm9i
         I0tM0DwqcT57rPOgP7rO0ebbqqBljLl/IYoErIHO7pUjzb+dbWwHYlcA8dZLcBk7c+fr
         9MMw==
X-Gm-Message-State: AOJu0YyIfBMbLAk82+Yad+1BuRH1qnR0btFjz84TgMg9TuAeypUCDKye
	obN5s3J5ErpsIIeJ32cH2mZ9EMeE3waYnEFIvw0dj0zM/JXWGSVIt7YFgrWt385H+Lg=
X-Gm-Gg: ATEYQzyQ3a5LmHMLmruPhPT75OBaVuH3a0bgMM+UOCujTKgzGoof3dN1LwlvZlhcZ9k
	c1WYqIVa3jUZDX/vvwKGYXdNThcV9rdXpwUdI6Dv73BQkXe/lae86zLh0Yqk3QUPxePxI+fdynA
	4n6VBtA3U0NSQ85mJG/4hSpAYi3JAo5gkJkVMhM3JdHAjF+CkmOunUvHj7QdqjUcRZOntd5/C3l
	TQvb9CYJTwz6ONUriYnXgJIOl1lgEbjYuOex8t2NjOjJQkQR9y8zh7TG8pwa8GAMviY4gwsKK9r
	dnFnQ/X7EhW8Qb/HuNCBH7jVSiOAg8qhAqmMtw6C733fVIxlJ9tp9l4XfJf1obDxKnqdR2pZI5C
	gvzVtB/rFsGiTglno5CU3ChCKeAPW7vu42pkj3TtY99J4MM+arKlFv8pxCT/aQj+ZkfKDDmudr+
	p8s8Zs7RmeOUGpVjIl0/0yLHp3sdQB5hkVtFI42ApQJ9PDlGBwFLwFT0hvB7kS70OUJkiTwgxDk
	hRUgJ+a84fbYkc=
X-Received: by 2002:a05:600c:8b72:b0:485:33b7:573d with SMTP id 5b1f17b1804b1-4854b239d6cmr27442895e9.1.1773221888238;
        Wed, 11 Mar 2026 02:38:08 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b? ([2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81f19dbsm5896078f8f.22.2026.03.11.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:38:07 -0700 (PDT)
Message-ID: <e45a10f651fc6160f008e3e2ed60496fdf2aba1d.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper] [PATCH 1/2]
 config.json: Drop vnc usage
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org, Michael Halstead
	 <mhalstead@linuxfoundation.org>
Date: Wed, 11 Mar 2026 09:38:05 +0000
In-Reply-To: <CANNYZj_Cu0sdFN02WjbNrKNH2pdcNfMqT0dYEV4y9BFTk_uSPg@mail.gmail.com>
References: <189B9F01010B1521.2412760@lists.yoctoproject.org>
	 <b8f3d35149f5b2a8e144da24fa6d1b4e777c6419.camel@linuxfoundation.org>
	 <CANNYZj_Cu0sdFN02WjbNrKNH2pdcNfMqT0dYEV4y9BFTk_uSPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 09:38:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3429

On Wed, 2026-03-11 at 10:27 +0100, Alexander Kanavin wrote:
> On Wed, 11 Mar 2026 at 08:30, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>=20
> > I just wanted to document/highlight that there is one case where this
> > change causes a test regression which is the runtime_test
> > test_testimage_virgl_gtk_sdl.
> >=20
> > In most cases we can redirect to the vnc socket and have equivalent
> > functionality but that test uses/tests gl as well as the sdl and gtk+
> > backends and that needs either a DISPLAY.
> >=20
> > Michael has a way to enable an X DISPLAY on the new systems RHEL 10
> > derived systems but I'm still keen to drop the DISPLAY requirements
> > where we can (and we can't view it any more).
> >=20
> > The best way forward may be to find a different way to tell this single
> > test to use DISPLAY=3D:1 through some new variable we can set in the
> > configuration.
> >=20
> > Does anyone see an issue with that?
>=20
> I agree, except one thing.
>=20
> I would take this opportunity to drop x11 usage on the host/naitve
> side altogether, and migrate the test to use some kind of host-side
> wayland compositor rather, that can be found via WAYLAND_DISPLAY
> variable. I can experiment/propose needed patches to the selftest and
> oe-core metadata, but I don't yet have a clear proposal for the
> wayland setup on hosts.

Michael is already ahead of us there in a way, he was setting this up
as below using Xwayland which is halfway there in that you could likely
do something similar just with wayland alone. Doing this on other
distros will of course have its own challenges and we have tried hard
to avoid making the systems hard to setup.

There is one other use we have for DISPLAY, here:

https://git.yoctoproject.org/yocto-autobuilder-helper/tree/config.json?h=3D=
master-next#n279

where we us an xterm to get a proper interactive tty to test under.
That shouldn't be hard to convert to use wayland either, it is just
another thing we need to tweak.

I'm not against moving over to wayland, the question is how/when and
also how to retain compatibility with the other releases we have to
test on these systems. My proposed approach already has one issue which
is how to ensure the existing vnc server is started on the older
systems. We lose kirkstone soon which helps but scarthgap will be
around for a while yet.

I'll send out my proposed patch to the test which would keep it working
for now, then we can iterate on top of that?

Cheers,

Richard


Notes from Michael:

sudo dnf install -y xorg-x11-server-Xwayland xwayland-run

sudo vim /etc/systemd/system/xwfb.service
# /etc/systemd/system/xwfb.service
[Unit]
Description=3DHeadless Xwayland display on :1
After=3Dnetwork.target

[Service]
Type=3Dsimple
User=3Dpokybuild
ExecStart=3D/usr/bin/xwfb-run --server-num 1 -s \\-ac -- sleep infinity
Restart=3Don-failure

[Install]
WantedBy=3Dmulti-user.target

sudo systemctl daemon-reload
sudo systemctl enable --now xwfb.service


