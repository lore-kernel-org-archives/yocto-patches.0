Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4A5C44508
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 20:03:27 +0000 (UTC)
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2900.1784145802920761755
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Jul 2026 13:03:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=cLvJiujm;
 dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=KP+Yhtw4;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.146, mailfrom: paul@pbarker.dev)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E76641D0007A;
	Wed, 15 Jul 2026 16:03:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 16:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1784145801; x=1784232201; bh=nuqfgsrIy/
	AxBUUDg4WozzX/ZhMw6yCShv+KlTzBYAA=; b=cLvJiujm6TLOOg5z2NAUqI3qvF
	JjeMZqacNCMqwh+piyuSL5kYOrw2KmDZrgwtU7g/vhWC2mgUipHOjjjD8AZsbSKV
	XtvgbNXpbq08Wv6KNHnndklZOIOnzAnjDKVhuA1Lf35B1UXqkIe2Wal1wKzwgGJz
	68SgMYB17AseSGgO3TbHkTiv81hRg923jjNm7JC9mH4fuFbcRYwAkK5EWwBPyMPU
	iYKVes85D8zmxSdrcAdCKqB8ddknPLvhj70aIaUYaSQbgkGiekW+T0CTzg6cU6PX
	bH9R3xY3UmekkgQ9K7uZPbAbV7GiR4im7PO+vhzXlaU4EDcC98/T9WH1qzaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784145801; x=1784232201; bh=nuqfgsrIy/AxBUUDg4WozzX/ZhMw6yCShv+
	KlTzBYAA=; b=KP+Yhtw4cYwsDSHoarkqek2rnJTzoh7kEpSMmY3ibMsPskfbZFo
	EGkTy8LgQn18Q1ZFhGoGOR5a3Ov9CfvSWXgsrVTVMr7/s8zBisZ1yMnYA7zsklfz
	QZaWtLhJcJ35EGBFJoHKPJzrkCuKXe9GMh5iRw30YCy1iF5C6oUxK5USgySNiKDM
	OoZKc03kxZLgYbYnO/uv/f0p9EPW11kmfrhnI6SZ7ZEbLCIhy3x01EZXFl7NUJul
	srkseMpGqZCGRosVC/kSQl7Cm9GI7Vyp/kcbEAm4fWxfCyeXqqXjpFpnGxkQObzm
	xjkempXJRffWT0nGo5K5O9dctdPsmRzX76w==
X-ME-Sender: <xms:iOdXaqwJbTepQUBa71EU4GqTP9jHI1SW5T5DQfCFrpn3ul7pQ109wg>
    <xme:iOdXap_nHpoSrVr5OjetzxJsmHPkcz7QxdmhWD0Sgz-8fsweSs56oGoxkwcbBMpnt
    4F-XKR0tYlTfWEP1-3cRzkkfJLTuUQyST8K7qOJw1GM7dsCd-j3fv4>
X-ME-Received: <xmr:iOdXamLTmBTdB6DaC-TnchcT08W144798X5ODeyfO0mTu5VPLr37oaIKERUHespupHCZ2KQ4N-tMNFSWOPNYpkoMyKsgs3AyQ4zaCKXg2zj8>
X-ME-Proxy-Cause: dmFkZTFi0u7nH/6n7tTeOhLoP3UFgsbAnXzsVx1YvwRwETEf2VuMqmLavgRj53pwkO90UE
    J2WQcVxzZFSeFJHUyQVfBnaZe2ACZARAQ2T/pkZCTnr5DFg/Q1TR6c2L1MxHgGxmzt7f7j
    7FtqeoHdZaqb5jWCkDo0dUUoNW7MFjQFZfX3wONXfLW/TiU9Pw7seVwsnwllLeRf1muTbW
    s0zB/ehzOaKiFceDQfE4xZEnNSkciXyadBHldCXeV82u9p8wcd3mP0b8mAArq3UdaQ5HaM
    mq7lXIobHM76Z2Qcj2QIDncV1g5kklEIiOVj3xDk/8MzYp9+Wdpn7776Azo30xBi+ie0gV
    ANWFaRHdnD8bkaU9XAHFAvhJsPj6iQ5SeeO5EYbkw7EtINbEzpq3xeWVNdycxqK81MXBfE
    ehLX4CqsQ8m0zfFv9ehNW7OJgQH7muWeSRACo2JLh+OW0xtViSj7f4lwuWM+kl3zlCwPY6
    bNhBvtdkZVCgFe6M0D9wt52/YAVUQWI3stFVwJQbGI0cowmPU9uhKjnZb3K2WtrwrOwIB1
    28+FGFmhI5amVdLzpKlPHiZ9v93Jj8DrVqHmyeIgMMU6ZRtLC1VT28ZoCmM22zUM1yIasG
    WIMXZoAEoZs5S2De4vwz5Xig51NJOWPpPHSJ+8VicALcOeqS4T2nxO3DGqwA
X-ME-Proxy: <xmx:iOdXand8QdEgJC8FxOJfoYWbXpSuWgEKV0CLltdjK3ZUs5c831t7vw>
    <xmx:iOdXat-33kRXgWi6cvp0kMiv6iJc46E9cwab_5Rhe4gExQkKwfO-bw>
    <xmx:iOdXasrCyt4Yq8id6JNKmpwj1U4OPb6V1ADaf4dE8X8f90smhPvUCw>
    <xmx:iOdXaqDiltPpF4APW4cwWOMyKE2_BzuL74Wgo3u_mbgjAbKJ4eO_5g>
    <xmx:iedXat05ll8MbTESKWR8FCMZI1maUSE0r7KROVqybyBlDKolZ-AVEimF>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 16:03:19 -0400 (EDT)
Message-ID: <1756daaa19952f4a3210700ba4ecfde8aa3724a4.camel@pbarker.dev>
Subject: Re: [yocto-patches] [pseudo] [PATCH 2/2] tests: Add close_range()
 test
From: Paul Barker <paul@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Mark Hatle
 <mark.hatle@amd.com>, Randy MacLeod <randy.macleod@windriver.com>, Vincent
 Haupert <mail@vincent-haupert.de>, Babanpreet Singh
 <bbnpreetsingh@gmail.com>
Date: Wed, 15 Jul 2026 21:03:17 +0100
In-Reply-To: <20260715054142.7-3-bbnpreetsingh@gmail.com>
References: <20260715054142.7-1-bbnpreetsingh@gmail.com>
	 <20260715054142.7-3-bbnpreetsingh@gmail.com>
Autocrypt: addr=paul@pbarker.dev; prefer-encrypt=mutual;
 keydata=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
 LUewj8JVy0aJsGTwI4invl
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-gP/lHipdJl7vD9oGCcZf"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 15 Jul 2026 20:03:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4483


--=-gP/lHipdJl7vD9oGCcZf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-15 at 05:41 +0000, Baban via lists.yoctoproject.org
wrote:
> Covers the ENOSYS regression itself, that the wrapper agrees with the
> kernel about bad arguments, and the part that actually needs the care:
> pseudo keeps its own descriptors in the range, including the connection
> to its server, and has to come out of a close_range(3, ~0U, 0) still
> tracking ownership.
>=20
> close_range() needs a 5.9 kernel, so the shell wrapper probes for it
> with PSEUDO_DISABLED=3D1 before running anything. Asking with pseudo out
> of the way keeps a wrapper which has gone back to returning ENOSYS from
> passing itself off as an old kernel and quietly skipping the test it is
> supposed to fail.
>=20
> [YOCTO #16339]
>=20
> AI-Generated: Uses Claude (claude-opus-4-8)
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Hi,

Thanks for including a test case! I have a couple of bits of feedback.

The close_range() syscall was added in Linux 5.9, the
CLOSE_RANGE_CLOEXEC flag was added in Linux 5.11. So on Linux 5.9/5.10,
the probe will succeed but the test will fail.

There is also no test coverage for CLOSE_RANGE_UNSHARED.

Otherwise this looks pretty good, please send a v2.

Best regards,

--=20
Paul Barker


--=-gP/lHipdJl7vD9oGCcZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iIcEABYKAC8WIQSzjPXf5Y1BDWhU2iCrY1Tsnbr0bgUCalfnhREccGF1bEBwYmFy
a2VyLmRldgAKCRCrY1Tsnbr0bu5OAQC8HUjwdCv6qYYx5lf2u9TmcmglfVqvTFu2
TD+VLWaAKAD+Iy3DyznZFw9/YQoklB2/ezTT8aC4aqOpiO9Ddk/ZHg4=
=Fo0L
-----END PGP SIGNATURE-----

--=-gP/lHipdJl7vD9oGCcZf--

