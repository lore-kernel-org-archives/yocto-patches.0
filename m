Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930EBC55160
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 12:04:16 +0000 (UTC)
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9943.1785413049872581728
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 30 Jul 2026 05:04:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm1 header.b=ER2PjaLE;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=NZIqEtFY;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.156, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 357517A009B
	for <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jul 2026 08:04:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 08:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785413049; x=1785499449; bh=o8cv/uYFRN
	kCVwfiMrqXvT8bRIO9cjUTnPnctRpXBx4=; b=ER2PjaLEQiiGogkFe1E5tHWlyZ
	pLcTEIg/4RBGkinIUdYhwt+qlsHUFhDXQGkFrrX7h6Ufvj9Ta9w5DjUvQ4aY7a6g
	QiORlwquJ6DlAdv06MKOfqKYq0DXOztMcbIbQa/FepBKbViF5nEWZsY0Ph+TZftt
	ag+P0Wj5cf/RViqJPTnx7I1WulryPABQGIbmxVQCaQ5OPJFJxo1Ph/NRKF0HWCc2
	fuhTJqCcoTeykTYZn2BufMPNXZs5monpZmnIVECQG80WgICDbp7CTIAW3y99krWj
	6A0b8X0GYs+ctKVHLZ78+e7ev/bpUPT3g0PfH2NVsKpW9MMalkSl8Nyyd9wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785413049; x=1785499449; bh=o8cv/uYFRNkCVwfiMrqXvT8bRIO9cjUTnPn
	ctRpXBx4=; b=NZIqEtFY5AwdUbe2yJnD2HIBtT91eSY/4+DED96uk6b1kMV7bxQ
	3RsFhChdVAMLv3ioShVQE/6HpS7/Er9hmSbzmBL9O4GZn93IAjq5HjHogK2MFBRb
	ihpyGUUVZGZ4S9eUUMKoj5jF3dVIh+8k2wkrOTsv0JkU+tZLm9CymoLMfSoezDT1
	sxx1Z2F59MoPQ+prQaQ5tSCu4Zo+Tn6ch9lBZWSzEBMJCtEtjhZj0b++FHVL41rg
	x3WpoJeBSUtEExlGoEukUM29kC35jrR45CEHAA+zlo+NcZtkmheQzr+L2qGqesCB
	SkKmZ7doeaFzIiG+HztzB/KltjqwfEAGYqA==
X-ME-Sender: <xms:uD1rauXYyo7Z1HoFhHPLrYpTjPtsAINxCqIABh_Bjo3dw6-RGJCzAA>
    <xme:uD1rahgs-Do2zIhRWcNyjgo1tVIGS4yA0ZOManXbkais61IWsyXJ4l_q23Xx8t1O1
    COe0isKoVypugLTPCfWIQZxyduAQ_NfO_EH1lpiKQAkeoBTT7_HgIE>
X-ME-Received: <xmr:uD1raoDBigWBU2yLJcLyi_cJwnD3HcpkU67FwQPCiP48xLWpeCrMEdfIlpG8fudGTPlP3CQiYEkjsBr9b7cAEnYdb2s-9ZZPHdWjuF0ryEG1>
X-ME-Proxy-Cause: dmFkZTFAZI/eRb7Pb8tZHMVx7wcGkXHWDIKSkrAM7JWFpFe8JlLyKHDbAucjtZjUcI0SIB
    ZjJvWGibX9n2d5xf3jnmxyldC+okFZ0KPAND2pucMepvW9FZTRgyzcTSbBaUwPZAg8vFPW
    8byyXGaU/nbh2RMtNOh/6vnJfxeDDvJFWfXn7uKT67mPdEC1gntukghBsQWbkNA/WyHuYX
    mhofwVfp6jMNGjgJqOrCMPS5uxR8ZR1g8QKIIgvUwXYaiGzxOEd8zVdWlNlcxn6rHpKdxg
    Pto1dhZ4fMRKRSJfVdgZkI1i7tqUj4n9KioBoY/yH9w/fAPuqtD9u0c19qmXnACKBO4VJP
    siX7LNXCISIN9VWpAeazHpBMNA266STvyblEIEsFVyrYc1PHpD4RbVgTsAgNqr/zn2bCm0
    k2pPcM1Cd1KnuIMDR41pXISPS8fnlfevGC5g9roLe64Dk1SRAV+TI4CIibPuv88YobGv8K
    F+S9TlTNJ2txsgY/gaQiV2O+KhcooV/wrlZs0ohKrggivVJeT18pVm9fSRodxjSXY2YrGd
    kQkQ841586HsGOYkaL3+29Wlwf3MUm1Uoliytr24A0UPJys158YOLWLbLGjV7k06u08L3q
    yIBdRTvblLGP+yxTbs3fzNOZ2Ijbhy1WGGvbrAeKX01zW9V723RfGM6S0yVA
X-ME-Proxy: <xmx:uD1raqfkYtC3xkI4j0eJv6MQN8qCNgjSnt6sR2BKxb9v8VzCwh8tPA>
    <xmx:uD1raodaotCQO-MyWENPOt7VZlmORb8IToTLaz9twFxoWECb9t303Q>
    <xmx:uD1ramjClPqWNxPu5OEQaJzK5i2LgqtrlyAe_5d1LJ4DgxxC-Bu16A>
    <xmx:uD1rasQ_387AYnOXQFVzDhgFG7norL_JYcbnTqxwDOULsGfEYc2mnw>
    <xmx:uT1ram11dcSyOZb6vwlzm2YoJPH15KCVvi27-mhnpNh9RBFQZIWZlZPo>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <yocto-patches@lists.yoctoproject.org>; Thu,
 30 Jul 2026 08:04:08 -0400 (EDT)
Message-ID: <0db1bbae64602548db4132db0d1397254daf8949.camel@pbarker.dev>
Subject: Re: [yocto-patches] [wic][PATCH v2 0/4] oe/path: three fixes plus
 unit coverage
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Date: Thu, 30 Jul 2026 13:04:05 +0100
In-Reply-To: <ams7pWxsG4ZjkuyN@localhost.localdomain>
References: <20260724115020.38079-1-twoerner@gmail.com>
	 <243b9b065b08ae79eb0c2f7dd2ac9b8d18ba54f8.camel@pbarker.dev>
	 <ams7pWxsG4ZjkuyN@localhost.localdomain>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tJlN8uO4mj0XukorzSaG"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 30 Jul 2026 12:04:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4574


--=-tJlN8uO4mj0XukorzSaG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-07-30 at 07:55 -0400, Trevor Woerner via
lists.yoctoproject.org wrote:
> On Fri 2026-07-24 @ 04:04:55 PM, Paul Barker via lists.yoctoproject.org w=
rote:
> > On Fri, 2026-07-24 at 07:50 -0400, Trevor Woerner via
> > lists.yoctoproject.org wrote:
> > > This series continues the standalone unit-test work, this time over
> > > oe/path.py. It follows the same shape the suite settled on: each
> > > source fix is its own standalone commit, and the green test module
> > > lands last, so the suite passes at every commit.
> >=20
> > LGTM, assuming these are direct copies of what was added to OE-core.
>=20
> Almost. The 3 "fix" patches are identical, but the unit test patch is
> different because wic uses pytest and oe-core uses unittest. The test
> coverage and what is tested are the same between them, just expressed
> differently depending on the test framework.

Thanks for clarifying. wic doesn't need to be limited to using unittest,
so this makes sense to me :)

Reviewed-by: Paul Barker <paul@pbarker.dev>

Best regards,

--=20
Paul Barker


--=-tJlN8uO4mj0XukorzSaG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCams9tREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bsefAQDYrdKEcXMSAfS5tqhNuS0KUGiph8rQ1rCO
m254GhC8LAEAu+524zVxvYYq5gC2jOrXiQ3xhLc0rCoj32yDU23tkAE=
=iZ21
-----END PGP SIGNATURE-----

--=-tJlN8uO4mj0XukorzSaG--

