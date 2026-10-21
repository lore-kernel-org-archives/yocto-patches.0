Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8958.1792580765701148846
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 21 Oct 2026 04:06:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eSoS1LoD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1f68a9855so3618535e9.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792580763; x=1793185563; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dEc4ko/j951+bRSzpvrWDfhRXxI0n9LtUCdvLE71+mk=;
        b=eSoS1LoDVOM6aOgwSAbW3vPwORz2qKlqm1ZgTcW6P7ge8pLcojV5M8F2GH6DaajIg8
         G4xaTeyXDAu9iio0dulJVuNQd8452FMHxpnE5ErmHYtWCys/uYO0U/5dPcuj4cLBTxrI
         fEc/f/3WU1FwvfNMH6H11y78nCqTlIocrYjR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580763; x=1793185563;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEc4ko/j951+bRSzpvrWDfhRXxI0n9LtUCdvLE71+mk=;
        b=S9qxBXRfdPdJF7x0k47LzB5OsGMqAdOoIsRLVIq3U8ZGtKtyoI637cl5xMy+1H13mD
         M9SOklAZbRUTs/XW2zowcNXNU8qg4OJPvFdHKub1uBLajaZhMJOQwJNwyJHhlF5+opKe
         RjGb8o+aTXygWt8dOIltmq/Vg3J81xnwlOLXqHDrKBZZOeWNDrrtxRte+xhmZRfxN2OF
         krzMacgB1uU1viAkXliElJvSIxd9lPfpJpXncU1CYAFAictvlEOtK4qfx8FVquNXXjBi
         SPuhUQyMSOii1CnXkPbPUWeYz1+b07Ku7pFp1rfRBC8+E3OfjMD3sGCPn2Pw7zS2aG8b
         HQLQ==
X-Gm-Message-State: AFq9FYLNl5r/tDgLfjqZsKkLd/TkBL+l/86u4uH+uvvtL4iC7gahR70u
	8ERW+17FZYr3FmY8kiSwP30zWMKECBbX5F26lwIWEjZY9AW6r4H6rbFPXlqmka9azQjlBL8maWE
	giA3FAUU=
X-Gm-Gg: AYBFou2kmWK/vHgN8HUxE4f4Oc71jU0Y1y+Fzdo3JsjUoRvfcwqU6+MwDT41fs6oE2y
	lUJGcMLIZ3GrgAX/VFnVT8Ox1YO0OVWqf22PPWHIMpoNSMiDXD3jtRgRk5xayLp5exCW/WUBs3r
	elZjTIEqiNQoXTW5ucXV39y1EbPx5oE1TSIbACWkRqmfOT9bF9ARxAvZObx1YtsF9z9eOg1Gs+e
	lgJksU6A/yywXflAhaScawTGeBy3UwKe7NFRJ0Cu7KZA3dnaTCfjF3K/IRn3CkiKGguBXEXA1PU
	cn+irt0HX949Y6+TvBlXu9vaduecMxK2ryC/POWScNX80K/1VqAiIqW7yej5p4x0JUcc69iKWxD
	UI+BU8FWRXKYWEtD+sBrLKauw3SuqMLA/5PnB51pvl+WSOfQHXAdoEYZNziBNYZ7Y8HDatjSB8X
	pfZf8eQDJ5v6Dm2/gy96WZ9yc81KOWYqLpPkdLLk3tvS8O4VRz3lTq9gPI+TbEz+f4CS7KZIzgs
	9hmFQBDUjx2IKTuq3amBEfPXr+KLhicAZJL/BRvy2Sbi1C/7clt50WpWec727EkK4rWIRuZ8ls5
	t0DYM/CDLQLImIplnmIgHqJwpRFimG5n/LRnrGeusQ==
X-Received: by 2002:a05:600c:19ce:b0:4a0:c02:938c with SMTP id 5b1f17b1804b1-4a1fdb1c4e8mr33454795e9.25.1792580763568;
        Wed, 21 Oct 2026 04:06:03 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:aca:5725:8818:30bf? ([2001:8b0:aba:5f3c:aca:5725:8818:30bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828ca3sm4761115f8f.25.2026.10.21.04.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:06:02 -0700 (PDT)
Message-ID: <b3d1b28dec5c150330528ff579d20009845e8e38.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH] auh-config:
 skip changelog in commit message for noisy recipes
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Daniel Turull
	 <daniel.turull@ericsson.com>
Date: Wed, 21 Oct 2026 12:06:01 +0100
In-Reply-To: <CANNYZj8n_Xy2jNwttzuaLRg0Hbh70mTFbSQddhXpNA71aTeo5Q@mail.gmail.com>
References: <20261020090917.3132154-1-daniel.turull@ericsson.com>
	 <CANNYZj9P-15TVaO5fb3AD9Xa1mrMpt9aP7GApTDGombuGNe6oA@mail.gmail.com>
	 <f3a03e28b28b60530cc801b66001a3c9e6b11543.camel@ericsson.com>
	 <CANNYZj8n_Xy2jNwttzuaLRg0Hbh70mTFbSQddhXpNA71aTeo5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 21 Oct 2026 11:06:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5123

On Wed, 2026-10-21 at 13:03 +0200, Alexander Kanavin via
lists.yoctoproject.org wrote:
> On Wed, 21 Oct 2026 at 12:48, Daniel Turull
> <daniel.turull@ericsson.com> wrote:
> > Ok, I wanted to avoid extra logic and keep it simpler. How one
> > detects
> > programmatically badly formed changelogs? but I see your point.=C2=A0
> >=20
> > I just followed the same way was as blacklist is done. It is also
> > manually
> > maintained.=C2=A0
> >=20
>=20
>=20
> Blacklist hasn't changed in years (we should rename it by the way to
> something that does not have 'black' in it), and is superseded by
> RECIPE_NO_UPDATE_REASON variable in recipes. This list is likely to
> be more fluid.
>=20
> I think a better approach is to put a hint variable for devtool
> directly into recipes, as this is a devtool upgrade setting really,
> not an AUH setting. Devtool would indicate to AUH via json that the
> changelog it produced is likely 'badly formed', and then AUH can
> handle that further. Then recipe maintainers can handle appropriate
> settings directly through recipe patches to oe-core.

Even just setting the list in a variable set in maintainers.inc might
be a good compromise...

Will make it visible and updatable to anyone changing OE-Core and
customisable from other layers too.

Cheers,

Richard
