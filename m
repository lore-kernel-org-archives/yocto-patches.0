Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C684CAC5B9
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 18:56:34 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
 by mx.groups.io with SMTP id smtpd.web11.6374.1759172187251346087
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 11:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WSBeoyqW;
 spf=pass (domain: gmail.com, ip: 74.125.224.48, mailfrom: raj.khem@gmail.com)
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-633b87e7b9fso3512459d50.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759172186; x=1759776986; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1aiYlDjm4EY0BfSJN09/MbQSJijExFwEpGvZAZWdDc=;
        b=WSBeoyqW1Xxjn/CfykC7ovcZDHXq4YlHjiK1JaEjIqKch9UIVU99rx2wCeZwskWyDT
         cp7RiitXI0dfaBjTA807Z1BD/4oRSB3ohU/tjahyMY8jNO1o3XNfQ45VxFq6Aq4VPJwb
         jcPNadYs/xEDIf81G456YLdKsA7CS/eawbx7htR8cm7Nl2YM7ZHNFfGOJBj/q69m6PrA
         Ze6RDS/kmPdmfJZ3h+PFBY26saZbOY1YvidvkKMlKP+L+cQHg+esm1ZWZfbSgqjHdHib
         MAiaV9697co3oLPSfM+HfhScGq3kIV64GZCtdPCiQJWlGJZ3IVb0lJjVBgOnTWmJ9Y2v
         mGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759172186; x=1759776986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1aiYlDjm4EY0BfSJN09/MbQSJijExFwEpGvZAZWdDc=;
        b=bs5UsrhKktmr1TWE+rT4QswZOPPmG+vbQzcGMnm/8cITOHVS6zEfd9xnAUB83nhCfK
         TPIg5GiA0MdyABPd5UutzeJJPV34MkqXX38K9yNZPYDMBP8XJ6ze6qzei7hnd3/NJ5/T
         Vi0qxt1q2/+Sodn7GL97oQd934JcgRbGS6Ox0sVFZ+LG3tP1QSIefN0u83ZSiWZucTiX
         bKBhrdRDv7Y6CFzW9JEV4ikACbmJJav46CPM8CzSknG/wcOmCJL0wUVRmn307TtyObts
         qYfEE4iVdOjeyxdwCBFCb7GJfJ/YNeNcd+csvdV5U2hk+vzd7ChfKIS6qwvzCs3ZQrLO
         V0yg==
X-Gm-Message-State: AOJu0Yym/WOMZYMy0IXCM7APd3Smn3EXxOoq1NG7j9VSfU2cSAaOpJ1O
	lOjWwZpHcNQL3gedrtfZcfdM4B6xv3eE5xf8ZWycmwD07KUUoczbowI185KGzvZAIaZfDrBsjuu
	DMDdEBWIG6eRXCiBQw5ItXbGFogXhfDE7imWk
X-Gm-Gg: ASbGncuCNE8ZvtX+xNyoWcB0x+iXVB+Ksj7n71sWglyXLmIqgU9DKYQgDxRa2Yb+X+L
	rY4ETpRNuWQZZUeOuz6xYpeqEEV2Bk2o/JloemxSPqu56qc3cx/UCI6gjVZqlu/wH5TwsxTuHDT
	EadshT5CLRlvIpdBMPQXIKHujFGblVg3N+VRgZVk5pG3FWcZY4EkvceMibRZ9yDyt4lfiQlBmr5
	VPOrsUGFsouYen9GQZZVSHIbPvpBNA5FUlAgr2pDUIITh0yIwCOBNeqkwJgqxSqvGt+Pgjkkx6S
	kvyM/7ysOSe1+jBiVtJ9wSeLHzepiur8P8lN0cd+zlDI+PBkkm9USXMoE7Go2SL5
X-Google-Smtp-Source: AGHT+IFZu3kQuUlbk0l8MGgPYSHnGFiGDbWdNqR+SSRCOIu0fFzfdU5Vi6ow+BCapwQJGfDZsEiwOlQyT89anapicZg=
X-Received: by 2002:a53:c202:0:b0:635:4ed0:5723 with SMTP id
 956f58d0204a3-6361a83517amr16127593d50.39.1759172186021; Mon, 29 Sep 2025
 11:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250929045007.12623-1-vanusuri@mvista.com> <20250929045007.12623-3-vanusuri@mvista.com>
In-Reply-To: <20250929045007.12623-3-vanusuri@mvista.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 29 Sep 2025 11:55:59 -0700
X-Gm-Features: AS18NWAOQr4VEUxTI8VN2OLwoHzoXNKtfOa64LC3xRNbk83rwRPaYt-jAhEu_Qk
Message-ID: <CAMKF1spJZ6Y1XxG-86ROPPwbGp2gzyb0xX6R1H0hG0y0DRq4tg@mail.gmail.com>
Subject: Re: [yocto-patches][meta-cgl][PATCH 3/3] ucarp: Fix the permissions
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 18:56:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2253

On Sun, Sep 28, 2025 at 9:50=E2=80=AFPM Vijay Anusuri via
lists.yoctoproject.org <vanusuri=3Dmvista.com@lists.yoctoproject.org>
wrote:
>
> From: Vijay Anusuri <vanusuri@mvista.com>
>
> Gave write permission to po
> List of Makefile.in.ins to update po/Makefile.in.in
>
> Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> ---
>  meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb b/meta-cgl-=
common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> index d221814..8a2737b 100644
> --- a/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> +++ b/meta-cgl-common/recipes-cgl/ucarp/ucarp_1.5.2.bb
> @@ -42,6 +42,10 @@ EXTRA_OECONF +=3D "--sysconfdir=3D${sysconfdir}/${BPN}=
"
>  # fix the perms for config.rpath
>  do_configure:prepend() {
>      chmod 755 ${S}/config.rpath
> +    # Make sure po directory is writable by current user

Why should it be writable ?

> +    if [ -d "${S}/po" ]; then
> +        chmod -R u+rw ${S}/po
> +    fi
>  }
>
>  do_install:append() {
> --
> 2.25.1
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#2248): https://lists.yoctoproject.org/g/yocto-patches=
/message/2248
> Mute This Topic: https://lists.yoctoproject.org/mt/115490482/1997914
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1334078=
6/1997914/645821814/xyzzy [raj.khem@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

