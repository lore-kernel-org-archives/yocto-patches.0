Return-Path: <sputnik@on-the-web.ch>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF8F55806
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 10:15:05 +0000 (UTC)
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch [109.224.244.120])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16071.1776680094873481928
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 03:14:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@on-the-web.ch header.s=protonmail header.b=QfyA8+SH;
 spf=pass (domain: on-the-web.ch, ip: 109.224.244.120, mailfrom: sputnik@on-the-web.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
	s=protonmail; t=1776680092; x=1776939292;
	bh=w3wqeu2PXHEABPdzOA1XAjEe84qaYoKGbu91E0cwm7w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=QfyA8+SH8oZpeYCwnUiNBXC9/4BB1/3TQm9/WitrPp7fLopeRj/KHmqQ+/cFjkona
	 BY9AkYhA17Nau8SGTK68/OmZSrrFXHsILURWx7nOuwSUC0emBoG337NQ0zzTnpzrNT
	 aga2dYxJH5y/fK32le6bv7q+XLEKTIwCuiAKP8ODBKLHp6uEDpuO0ihMFKfGt33lO5
	 FRKm0nlib5HJJRontdnREKv/4iecRYBXWCdBa99DmVXVJPxIxL9eKwqVrIOQFCQpn2
	 56GzwRXofscYndDiAxs21k4/V7O0scLrIdcuFxJwl3J2NCM+TihBi7uUNuzuVF7rKo
	 Ff2T/xq0YE7OQ==
Date: Mon, 20 Apr 2026 10:14:50 +0000
To: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Martin Herren <sputnik@on-the-web.ch>, Trevor Woerner <twoerner@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [meta-rockchip] Backport patches to Whinlatter
Message-ID: <5bj70loXmt_k9cZvIDWvVux-3no88K7lhbMDcRw9jh3ylLLz-YDZhyOr6fM8PeXSnC88wg6wk34A9A3uz8ljvNTE_nEurXpatMj2VxFsw8c=@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: da9314f88a12ad05e661c9a8a45b30d4c0dea1c7
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------1dfabd61cf13a79d85342a2e47954026905250d8bbb93cd7debabc8928842165"; charset=utf-8
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 10:15:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3734

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------1dfabd61cf13a79d85342a2e47954026905250d8bbb93cd7debabc8928842165
Content-Type: multipart/mixed;boundary=---------------------252983c62aa6642a3088e943e95c76eb

-----------------------252983c62aa6642a3088e943e95c76eb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Dear maintainers,

May I suggest the following 2 patches from meta-rockchip master to be back=
 ported to the Whinlatter branch ?

fitimage rework: fe7cfa748bb132cfbe322c1c6d586f09557dbeb2

bsp: rkbin: fix build since S =3D "${WORKDIR}/git" is implied by OE-Core: =
e59f6fcb66091ea5efe33f3f3d8be09b1f65bbfb

I understand Whinlatter to soon enter EOL, it would make sense to have it =
enter EOL in a buildable state.

I successfully built and booted a Radxa Rock 5b by applying those 2 patche=
s without any modification to my whinlatter branch.

Best regards,

Martin
-----------------------252983c62aa6642a3088e943e95c76eb--

--------1dfabd61cf13a79d85342a2e47954026905250d8bbb93cd7debabc8928842165
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmnl/IkJEIiu+thqKlAPRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcBfXe4IdpTSmroneQpDVCtA5urvUIB3wWyxxuG
6jIeFBYhBCYHlZbYUMXC4ILtW4iu+thqKlAPAAB7SAEAzeiKBJD4PeIOF/VI
7SvYWjZnCw/L45WjMl5NKXCNYZ0BANjioyGlC52szQZhMEtMJdB50lqQI9QW
eIseS54ltvgF
=jeTl
-----END PGP SIGNATURE-----


--------1dfabd61cf13a79d85342a2e47954026905250d8bbb93cd7debabc8928842165--


