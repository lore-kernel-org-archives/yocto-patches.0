Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7986.1794236453311898844
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Nov 2026 07:00:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=b3F4j3Nz;
 spf=pass (domain: konsulko.com, ip: 209.85.160.68, mailfrom: trini@konsulko.com)
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-46556b9e02cso630985fac.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Nov 2026 07:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794236452; x=1794841252; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=71HlENMf5or7yTYG4iBBp7gi8fbnmHAD7TJSLV+kUKw=;
        b=b3F4j3Nz4FSrrBeObbv5kpnsMPuuu1frW/0PLgtv7lj4y8Yljwse0UEiCjzynobOn+
         ekCf6VA4QaCXcRWQRJgP8djAIC4oOOX8cQN7AVYSfeZtJmw+9kCw+Dmj10o6owbbMFwo
         nAxH6L4QYcjDSk19DScuC084qHSj/zC1RH2EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794236452; x=1794841252;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=71HlENMf5or7yTYG4iBBp7gi8fbnmHAD7TJSLV+kUKw=;
        b=2su5h+tCvnLt2z6W9acF8Jzn3TrwZ5rTki1ICXLGYhC30qmR0lil5PQjdh5BiFMmCA
         sWm3lkDpbuo5FDFU7BAKQpkIy9reNnsfLV6qLSwhq8ZL7z/RzOf6ja89vLYyvK8hk47D
         QoFSPVTzR+xg7SJwjjyiG4L7SqEs+0ckQXiwU3xYKFbzHZljomnsmmXDmdyIeXxEwVoj
         IvHlLNzGs1OLW1kIU1Gn5Pa3p1PSNeTZ7hra+ptYrT7qIJsIhvD850vlUpSugPIO6U3b
         q8A8lLzzLw11JpedqfT8cg1HK+M/7+sxbuJfwIN7G/uTmi2QZhOoTQmQQCaF2ePdu6td
         K77w==
X-Gm-Message-State: APuU4Z8sti04MoETwjyo1vbgLaDxmZqhO+U40TjyzJ+zFxNGlPI4wD3o
	0r91COzK2QqYutQq+Zw8YLuzT1zxWXwy6jnXZCc7rBckEgVTF6QNdvAK1C7ir56AAXQ=
X-Gm-Gg: AYBFou1y4Fz4fk1FRDclI6BZ3qmHpHXG04gGo5IdHGmeMjXhA2PG9Cezzhoj8MRhAVq
	tTLCUfTv6qqDe3bnPU94CAClbTh4Ec0YqNH31PxSc62tmS6sWdQIqcmUOfi/VS1soL/bo+OQ+2P
	OS+3mx6oNjixAQD86NqNgBgzBSnPSXCxqBSNK+6FkX+ljAjfzGKmG3A1rEXYmQrNBaeWKXIxdek
	B7qeGU6K4wvcqgIPgNJ5QETznPN3HeSVjNFwGpvPjTlC0aWLYQzp5tBRXZG4wtiXjmFP2Uwe3Qn
	bc/GQ2fVlP/NAzELvl1fiMIAjwEZAbnKkJp0VQbiUVZufMJb7RKpZ00rl8cKDsrRD719KKHApjS
	YIY756qc+inLD8uWFumYZO/37dh3eqLN30xMhGszJebsmGMrdeuH4Y1jwilBLMApWgNlZpJLIn+
	Ee5wbP0IofRyXLE2Iz8kSFTU/e7rgRZOKltFtAOK2V5QZgX9io0KkwAO7DdTHXvYqDzat3oEXUo
	mIz22gr2FilcHK3RnXWTWMYClhM3iBcM8N7s9FazCnOfK1Qw/Sey3mMQyd2SeTsYB2VeN8lq6eB
	lu/UTn0HVC8gjnKQVXu1zSrSSGoff/zjwYLKquCgPl8h2LV7qKPsXcOJA25abQD+pbyWqornPoo
	edsoDAdRrqF9Xs4HJoRXRM+c1GEzovlQOW6Z0KnlrudpoykCqvrSPnAZbhD1aUqp2uYd/cSLM3G
	mNjWTc0aUKWmTbcvxT+qcNBELAT1Zi+Q==
X-Received: by 2002:a05:6870:c247:b0:493:c06d:7700 with SMTP id 586e51a60fabf-4adc1008bedmr3180120fac.25.1794236449708;
        Mon, 09 Nov 2026 07:00:49 -0800 (PST)
Return-Path: <trini@konsulko.com>
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ade68aa5c9sm6011297fac.3.2026.11.09.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:00:48 -0800 (PST)
Date: Mon, 9 Nov 2026 09:00:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrick Oetken <patrick.oetken@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org,
	Tim Orling <tim.orling@konsulko.com>
Subject: Re: [meta-lts-mixins][scarthgap/u-boot][PATCH] u-boot: backport fix
 for the bcm2712 non-removable check
Message-ID: <20261109150046.GL3741582@bill-the-cat>
References: <20261109135021.4184031-1-patrick.oetken@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y76g5ULFdR4r/DtQ"
Content-Disposition: inline
In-Reply-To: <20261109135021.4184031-1-patrick.oetken@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Nov 2026 15:01:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5254


--Y76g5ULFdR4r/DtQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 02:50:21PM +0100, Patrick Oetken wrote:

> sdhci_brcmstb_init_2712() tests host->mmc->host_caps, which is still zero
> when sdhci_bcmstb_probe() calls it; mmc_of_parse() has put the device-tree
> capabilities into plat->cfg.host_caps instead. Every BCM2712 SDHCI instan=
ce
> therefore takes the removable-card branch and programs SDIO_CFG_SD_PIN_SEL
> to SD mode, including the soldered eMMC on a Compute Module 5.
>=20
> That register survives into Linux and makes the first MMC_POWER_UP fail to
> latch POWER_ON. On a CM5 booting from eMMC through U-Boot 2025.04 this co=
st
> a fixed ~134 s inside "Waiting for root device /dev/mmcblk0pN..." on 6 of
> 9 boots; with this backport applied, 0 of 19 boots stalled and boot time
> went from 2 min 23 s to ~13 s.
>=20
> The bug is present from v2024.04 up to v2026.04 and is fixed upstream in
> v2026.07 by 8de24e226d74 ("mmc: bcmstb: Fix non-removable check in bcm2712
> init"), so oe-core master (2026.10) already has it. The patch applies to
> 2025.04 without fuzz. Only the bcm2712 init hook changes.
>=20
> Signed-off-by: Patrick Oetken <patrick.oetken@gmail.com>
[snip]
> +Upstream-Status: Backport [https://source.denx.de/u-boot/u-boot/-/commit=
/8de24e226d745c59972b1898df5cceacf0a7ad47]

My only feedback is that pointing at source.denx.de will bite you down
the line when it goes away at some point and you should just use
git.u-boot-project.org instead, which this automatically redirects to,
today. More importantly for the SRC_URI, really.

--=20
Tom

--Y76g5ULFdR4r/DtQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavHgGgAKCRAr4qD1Cr/k
CvLJAP9+4vqMl2Gnu1UsOb2rzHTr2RjgkGIuKyExbXpOd731NgEAn5PPdGp1ZGHM
2nC9wzO5S46he7t+7Ahh8jL8aokNRQY=
=NPt+
-----END PGP SIGNATURE-----

--Y76g5ULFdR4r/DtQ--
