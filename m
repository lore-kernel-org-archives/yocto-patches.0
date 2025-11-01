Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6CACCFA00
	for <webhook@archiver.kernel.org>; Sat,  1 Nov 2025 14:27:24 +0000 (UTC)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6439.1762007235762718057
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 01 Nov 2025 07:27:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=LkfTfODd;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=sIRenCrn;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9806B7A0056;
	Sat,  1 Nov 2025 10:27:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 01 Nov 2025 10:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1762007234; x=1762093634; bh=Ksmx0b6ZfH
	lPmCq5Se9xYOEp+cUG6kkyQdWgeR8mZsc=; b=LkfTfODdpAb98q077Dx5ypvVM2
	ZmjWvsr84inDq2i244+jJTTxKF1mnfN4DKfF8cc7rZiLPXSPbMSNkHjoCFnp7sqL
	o4lyxjhgKlEZreDbf1GSFQ3N5PvpfHEq7V1g1zDqKuwvrEBXzgv8zHws7XzHcGxy
	i6664PfncS6QvbKmFjRPAIOf2CfvgdT83jeGg9BOlJ5XYhks2HQhmT1VV5gLkDWG
	tBFwQiAz1I0G8zQbb7UIXDBsamaFm3EACE7jKZF6y4DQB3EgLsuqeHqBxlxs5CYs
	ZC0BXLTxs7YhXCTzIB5twp9Bj5XjnEceA6vhzktu2RdRYjwxKuPvcXw1qLXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762007234; x=1762093634; bh=Ksmx0b6ZfHlPmCq5Se9xYOEp+cUG6kkyQdW
	geR8mZsc=; b=sIRenCrnbb6DBq0jBvbzp2aerExp2DvcmyQA2tpVMlsPIf2z8AS
	wz9CVr9yOsfsSQ/3vPVFCLFV7eH81uIB4lcKQ6Oc2gEq9Yz/Phwo/Ce8qstwIaFN
	NdrAVMG8G6TvqJJB62DB6FbKbHduWyoWEFjPkkT7ISPq+w64N46KIRMIk+4eDyEL
	n5EUwVR5qwuH3D2E0xy0PdGKfH0NZLyN81teoRadAfX3E8gH8T9cvDqLIqjnH0qv
	VdqVLOvw5khLVaKGzInuGVaiKyqAcKDCF6LptJlWozg3xOATlRPP32wjs6DGIomq
	OMajFW6OBm6GHfGtxUzoYZarm70kGdQ91rg==
X-ME-Sender: <xms:wRgGaRLN6-vEXORFyxyMKuvQjPFuQqYC3IhW1_EJtUCYWpGe4_d8EQ>
    <xme:wRgGaUl0DqjtUX-KuWccmznUXInja5jLHePGXyrroepTJZ2UsfxQKZ4g4XgAwNjNM
    qJ1diqiNiylo0K99eaJBYETHpT5DGNkYqMwnmDm_Q4mK4xYqqQx2Aw>
X-ME-Received: <xmr:wRgGaXEha0DtdGr7kgUwlfz3sWUFH_P_5kmotHpDMUiEQu69G8DSeVoouKn0efCyI4DuIbAhbERsZfRjghaxCjXGOtrKNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfevffgjfhgtfgggsehgtderre
    dtreejnecuhfhrohhmpefrrghulhcuuegrrhhkvghruceophgruhhlsehpsggrrhhkvghr
    rdguvghvqeenucggtffrrghtthgvrhhnpeefffdvfeegveekudfhteeuhefhieekvdeiue
    efveeiffeukedtledutdfggeevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdpnhgspghrtghpth
    htohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhhirdgthhgvnhesfihi
    nhgurhhivhgvrhdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlih
    hsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopehjphgvfihhrggt
    khgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wRgGacFGn2iFpmNwowVMOsYLM_Kpmb0-hGK9v9TX7esuQu2p-UIfsg>
    <xmx:wRgGacMBsKeofnMMR5Q14jFxcdRfvhav_X4z-xsrvGnMG5LPLlCFOw>
    <xmx:wRgGaTFz20sztU6ghlKOQeBRLfAlSDLYac7H0Uaw3FmN-STeP6JbXA>
    <xmx:wRgGabMb7ZJY6hnO5LYXK8rOfqEHPMVs5Uk5dtBhkluI32RbL1dcQg>
    <xmx:whgGafOQCW4_CRoW2MP9QIN0JMHKoEeiGxaFLAylqQMGfhdKoA1wYaQM>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 10:27:13 -0400 (EDT)
Message-ID: <f61d5e8fdb8bfe0e01824520c3dfbd3221c84e6f.camel@pbarker.dev>
Subject: Re: [meta-mingw][PATCH] meta-mingw: support generating Windows SDK
 with no symlink
From: Paul Barker <paul@pbarker.dev>
To: Qi.Chen@windriver.com, yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Date: Sat, 01 Nov 2025 14:27:04 +0000
In-Reply-To: <20251031080447.2751414-1-Qi.Chen@windriver.com>
References: <20251031080447.2751414-1-Qi.Chen@windriver.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 ep0k17xg==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-FDvTh3XEIsAQBWYMLFHu"
User-Agent: Evolution 3.56.1-1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 01 Nov 2025 14:27:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2407


--=-FDvTh3XEIsAQBWYMLFHu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-31 at 16:04 +0800, Qi.Chen@windriver.com wrote:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> On some Windows systems, symlinks are now allowed due to IT policy.

Do you mean "not allowed" here?

Thanks,

--=20
Paul Barker

--=-FDvTh3XEIsAQBWYMLFHu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCaQYYuBEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bsHoAQDZiHkvLEVn+9tk1WnaIVJYo+8TlGefqv8x
TUYccT0kvAEAqQEdOmy+uBoV97XoROfoK7rugpCueB08p8vtKsOuqAA=
=8jRM
-----END PGP SIGNATURE-----

--=-FDvTh3XEIsAQBWYMLFHu--

