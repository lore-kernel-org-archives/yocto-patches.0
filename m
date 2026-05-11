Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA88CD37B9
	for <webhook@archiver.kernel.org>; Mon, 11 May 2026 08:52:45 +0000 (UTC)
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46067.1778489560315264926
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 May 2026 01:52:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=MMmLWn4x;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=r2bvAMhW;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.151, mailfrom: paul@pbarker.dev)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 8AEF51D000CC;
	Mon, 11 May 2026 04:52:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 11 May 2026 04:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1778489559; x=1778575959; bh=XhOsd5p/J7
	PItXKEeidXFb3pERnEsvn4WPARA/EyI5U=; b=MMmLWn4xDqCmfiEnaObRNUM4Rq
	4ERn/zoj2aOpjO07F2VI3tANxRXYpjaM008S9MLPQnbk+4525iUJ53vKbNgdWxiQ
	gQQrieCfJ4qSe6l0wswifxzk8ff59T4oS4FsIVeGCwqBeg6/xEYqOppyUua6J5K6
	OQD/NDvYhX7ocv44aZFU0o8lE5GriIv4y7R96nafTIx3EuQ/GxYJVCYNk2iooWh/
	U3oGJXL2hnPyjgpxxOzVMLlU8RV1OAAwbVtqINW4rSTkLv23vswiRD3MNXJOL3ur
	9ArqoCBo/1H6d7tmLSJ3Z3EzfwTD7aBfgVhb5ImYvyTXeqzAtaa+5STGxQog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778489559; x=1778575959; bh=XhOsd5p/J7PItXKEeidXFb3pERnEsvn4WPA
	RA/EyI5U=; b=r2bvAMhWLlw9tI2x15GsWLLkhGgiq205vQtiKczrgrsf7GXOaLN
	LE4N5ggfm/XUSTq8udu1uE7KUQoFdMGGNsAu9DLbFntl9VGm/uhTd3LSGOZOZdbz
	S6ijwWzkHzG0aAsatGsJW5Q6qUQV9sr3vYB8EClMQnQK/D4T1VK/V7AyNCH49UT9
	RW/Z7XjOI90WtvcAr+Q6Dj81xsHyI0i8rage2YIJc7VMryKiHFt+qHENTNnLspUh
	WNl5uSZoVcEL7kbdpQ3/hQYj0s7AaiFE3nR84PivbjeCnqKotqmyNJBAXK3lShzv
	Y6hRCxI2yEQDiuWqsnFN9qaBy5ZMiX+0Oeg==
X-ME-Sender: <xms:15gBapUFbFR1e-gOrNUIvIK20Lja65hGUz4_JuD3Tvk_jFmviZQj9A>
    <xme:15gBahXCKEMlzFgVJPRt7qasDSukX9AHomwq3msxXTB8KIPZZFZ1uaAE8Wpe51CSO
    0Yz-GupRT9Z3fIFYT5Uf61PbOkczVWBJ8lSr6b6wIQHOQZ4j11HKWA>
X-ME-Received: <xmr:15gBaof8dsKdIdzDfL6u1kevJlRtEUpQJE5itXRWqR0--IiLXQZg8ymisUrgCNNM1IHW-vkSKQX83p6H6SiiTz_WZw9OjToiSrXffRAESpjS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefkuffhvfffjghftggfggesghdtreertd
    erjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhephefggfduueeuieelhffhhffgiedugeffkedvhe
    ffleevfeeuffehueejveehkeelnecuffhomhgrihhnpeguohgtkhgvrhdrihhopdihohgt
    thhophhrohhjvggtthdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehprghulhesphgsrghrkhgvrhdruggvvhdpnhgspghrtghpthht
    ohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhimhdrohhrlhhinhhgse
    hkohhnshhulhhkohdrtghomhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehl
    ihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopeihohgtthhose
    hlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:15gBaqVQkJxKox1zUDA1Tj1ucZV_3GXh-JiGRGmoE1MdxOIIu9NcRg>
    <xmx:15gBahee1S04aB8Z3T3jF5WkX1lYOO1EQcG78S5qXNzNaTG9DLe97g>
    <xmx:15gBamO6X4I9XwyT3VBAicZr3NjsDJuUXUc48B3FryL2z8HR7UVotA>
    <xmx:15gBavhbZZ-h8c2ziBT5fqSNvRd7SBmcKiTvfbmbibn7W9u8LolNiQ>
    <xmx:15gBaqVasrE5ye5CYjHXdWt_ZD2RxOrnNFAnJmAE4MqJafZUg9SsO3nF>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 04:52:38 -0400 (EDT)
Message-ID: <dcfc99d7b81e1083ef3607adde6055f4a81d3534.camel@pbarker.dev>
Subject: Re: [yocto-autobuilder-helper][PATCH 07/11] config.json: add
 'containers-' build jobs
From: Paul Barker <paul@pbarker.dev>
To: tim.orling@konsulko.com, yocto-patches@lists.yoctoproject.org, 
	yocto@lists.yoctoproject.org
Date: Mon, 11 May 2026 09:52:35 +0100
In-Reply-To: <1c444ecb2272a384e77a786f7ca32767f791ce34.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
	 <1c444ecb2272a384e77a786f7ca32767f791ce34.1778202125.git.tim.orling@konsulko.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-iJ1lmmcKHAUq1vawPR7W"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 May 2026 08:52:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3965


--=-iJ1lmmcKHAUq1vawPR7W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-05-07 at 18:25 -0700, tim.orling@konsulko.com wrote:
> From: Tim Orling <tim.orling@konsulko.com>
>=20
> Add 'containers-' build jobs that build container images on top
> of the vcontainer-tarball SDK:
>=20
>   * containers-meta-virt: the original app-container-* images that
>     ship in meta-virtualization itself (e.g. app-container-curl).
>   * containers-library: a layer for additional images modelled
>     after docker.io/library/*, sourced from meta-yocto-containers-demo

I think we should combine these into one build job.

What's the plan for meta-yocto-containers-demo? Should we host that on
git.yoctoproject.org, or will the contents eventually be merged into
meta-virtualization?

Best regards,

--=20
Paul Barker


--=-iJ1lmmcKHAUq1vawPR7W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCagGY0xEccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bjGwAP9jTVp3FtVYjN3ctLIqNMdKe4+Jo9eFxoUR
cXdAL3T+gwEAvve0WZUXcOJkmqJg0wSsORya9fv46S1VGMV14IHLagU=
=xDvc
-----END PGP SIGNATURE-----

--=-iJ1lmmcKHAUq1vawPR7W--

