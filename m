Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268C4CD3426
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 09:40:56 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11133.1777887650980091721
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 May 2026 02:40:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=BQwKa9vj;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43eb05b1875so1973674f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 02:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1777887649; x=1778492449; darn=lists.yoctoproject.org;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DypM1K8n/lZwZgN8q421uQ9iIBnHTRkCiihTgzq4UDA=;
        b=BQwKa9vjpnGfdm5nfQYe2MWV7QDdHKY6TD2ovepi7nOfCPb3UlNqII9ZwIR5hDyNk9
         WPvjLz8Ni+cPhdQdvyMJYg9J05Z6mWBoG2eS1QizGfrq3qyhrNFVGQ4+em93o31tP9E5
         nbs57NDbr2rOwEzSIcDo8eBbRIyY8G2ob0zG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777887649; x=1778492449;
        h=in-reply-to:references:to:cc:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DypM1K8n/lZwZgN8q421uQ9iIBnHTRkCiihTgzq4UDA=;
        b=GBNpmHZNB7f96AAZu8w0axLkmv4jAmHNpOsQGtmZ2k7XaC4qDIsick55k2FGULoIFl
         zI2t6uqKJUrHbrZwQ8T5vHIKnXqgsZJtNtkJc8oeZm259JOvDJ+LSwbN9xI+W2miETsB
         TSjuIwtuWRf3KiW8wh3/22e1ePcWv3MknaCu1GbN27MOCZmuUNGU3bEyzYwQRLUzdWyA
         7h0xv11Boj6OU3d8wm+lr7+dPVQQlUrEbfWWULtbUh7a3fOF++HeoiEQMci72Vztt3Eh
         DoRJ++AXqJG2yLtdqXU+aHtT4St8arr03ViGTlbxZE+eQrS0gjtGp81xOgkoyo+dY0AB
         32xA==
X-Gm-Message-State: AOJu0YyTIa6wKr3KpTHKJQWHPoVuY9cFKvpYa2nYZNdKVohbuHmJJpNF
	zNTsTrRDDb1OpUsNRtKXe2T/OvaQf/iqJpBTHLTj0C68K/Qc+gsGOUJ8fSHZIVYGiBt/9E4iPld
	GFVmdBQk=
X-Gm-Gg: AeBDieva0lR+Z3Do+t1gkBm2COfKUi30gsDlsphEcohx9g6GO3GpcuuHj2f++8HpgdE
	FzvAzELYDni8Vnfr0019VAegug4K4/p1AZ31DbIJirdz1kkgDNUl+FxP7r7+m2mSiu7DbmJJZJ6
	yUDqHvApx9vDAnvCByMxku5+B6yHQVDW1pEES/PpTYX6W+/MdrFe6Ob1X+sr6eRo/eUyc+QxLwJ
	t54PZFL9P7PhesFRzFLTWfDsnjenTI+6ic7DHvj7vkAqR+oZpklc3IWMiE/E8ngUsuxQa5rMIDx
	+WH7CwEPo4hv/F1bDryr95QiNo6XGxbuwMPF70gXuOJ0joKl2O9XyDpa/ku/4Fh+FGyrBZzVDZ2
	onepTIh2KCzucJlz18vQmVsiAq7p+zYGaYA4UsUCMNlYzVbrMFMCToLZdg23ciP2xvWZ9yxO6+B
	3FKLYy93wQ6fwZ8pIRUOo40XyMAhr6IBpuU8zHAQn+IrKJrEKUpJg5KNIdLBfSy33Trtqc/D2rE
	GaPv0zlLQ4HCclS2kx9ow==
X-Received: by 2002:a05:6000:2f87:b0:43c:f8b4:e58 with SMTP id ffacd0b85a97d-44bb6ab1e87mr14200891f8f.41.1777887648966;
        Mon, 04 May 2026 02:40:48 -0700 (PDT)
Received: from localhost (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981dee7asm25553981f8f.21.2026.05.04.02.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:40:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 May 2026 11:40:48 +0200
Message-Id: <DI9SKM5J3YK7.1X7W209401F8W@smile.fr>
Subject: Re: [yocto-patches] [yocto-autobuilder-helper][PATCH]
 meta-oe-mirror: select systemd through INIT_MANAGER
From: "Yoann Congal" <yoann.congal@smile.fr>
Cc: "El Mehdi YOUNES" <elmehdi.younes@smile.fr>
To: <yocto-patches@lists.yoctoproject.org>
X-Mailer: aerc 0.20.0
References: <20260504093506.1434307-1-elmehdi.younes@smile.fr>
In-Reply-To: <20260504093506.1434307-1-elmehdi.younes@smile.fr>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 09:40:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3910

On Mon May 4, 2026 at 11:35 AM CEST, El Mehdi YOUNES via lists.yoctoproject=
.org wrote:
> The current configuration appends systemd and usrmerge directly to
> DISTRO_FEATURES. This leaves VIRTUAL-RUNTIME_init_manager set to
> sysvinit while systemd is also present in DISTRO_FEATURES.
> Init manager selection is expected to be done through INIT_MANAGER.
>
> see https://git.openembedded.org/openembedded-core/commit/?id=3D0b4061c5d=
50261f826d0edb4b478d2d305274b7c
>
> The current meta-oe-mirror configuration breaks the autobuilder with a
> large number of "Nothing PROVIDES" warnings/errors, as seen in build 717:
>
> see  https://autobuilder.yoctoproject.org/valkyrie/#/builders/82/builds/7=
17
>
> Signed-off-by: El Mehdi YOUNES <elmehdi.younes@smile.fr>

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>

> ---
>  config.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/config.json b/config.json
> index 3c067d2..beef339 100644
> --- a/config.json
> +++ b/config.json
> @@ -1813,7 +1813,8 @@
>              ],
>              "extravars" : [
>                  "LICENSE_FLAGS_ACCEPTED =3D 'commercial'",
> -                "DISTRO_FEATURES:append =3D ' pam systemd usrmerge openc=
l'",
> +                "INIT_MANAGER =3D 'systemd'",
> +                "DISTRO_FEATURES:append =3D ' pam opencl'",
>                  "FORTRAN:forcevariable =3D ',fortran'",
>                  "RUNTIMETARGET:append:pn-gcc-runtime =3D ' libquadmath'"
>              ],
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3909): https://lists.yoctoproject.org/g/yocto-patches=
/message/3909
> Mute This Topic: https://lists.yoctoproject.org/mt/119139901/4316185
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1317941=
0/4316185/929767106/xyzzy [yoann.congal@smile.fr]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--=20
Yoann Congal
Smile ECS


