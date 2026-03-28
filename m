Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F9510F3DE2
	for <webhook@archiver.kernel.org>; Sat, 28 Mar 2026 10:02:51 +0000 (UTC)
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8387.1774692163148626255
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 28 Mar 2026 03:02:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=o4w/ucEA;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=kuu8Os5w;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.158, mailfrom: paul@pbarker.dev)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 546F31400162;
	Sat, 28 Mar 2026 06:02:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 28 Mar 2026 06:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1774692162; x=1774778562; bh=C6
	tpve/UQRCFKktpADj5vDrMfff5HaezqYV5FOTRSL4=; b=o4w/ucEA3OBnvKADbv
	jPtAap4D6Nk03iREj80cb8LTnljp85cfbC9yF0filpzYPuQYgfpCsYQo5l6HVHaw
	U1heC8SltqH5qPs5pvAHmduKgBimMNrIdmu6Fr7mZQ0OB75k+1P0Eefrbl+Ym9uB
	Nwbo8c0Fn60ijt1YMukeOJ3fMQ51hLejmC5/NplOtzlwWKaHvV6yZwB1W4iBxIQ8
	AyHndc4FzKLoJI4tRbYNQUYKOLtpZNfii13fH2NKArkqdi7q7SOzdatufm5OROzS
	qxmAgt+GBk3TTciP5kbYqubTa6shndhJCmH1YUVhUEiR7EEmVxNf1BwwEkeKqJPO
	m0BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774692162; x=1774778562; bh=C6tpve/UQRCFKktpADj5vDrMfff5
	HaezqYV5FOTRSL4=; b=kuu8Os5wRt9fs/JpKG+1maLXVIt+L+Z5C5CwxHIdX6FQ
	hHIDni4M37MhVxIOO4vrXosDita7IqY2FuMtSm2dXCOvwSHe3tVTxkcuL5AZYwDn
	z8FlwZ1HhwkdECK2G7+5YsByR8PqDjF0K5KMzyMvUWIB4xllby5qplJcirHlNd7e
	fyIThIqMCING/H8dap4iT2RsL1MfoOmb8NREE+T0D1Wf0VdHoUs90cLGMZK7HO7g
	vlaZrteT+kxMfVw8CZKYGpj4QE58ipU8/p+gvmZiSd0xBXPpCiUSUOzuKzfjzWKV
	GhbZzvMEsT+n8ToSlGt1aakCRZdg1p/MtzgjU4PB3A==
X-ME-Sender: <xms:QqfHaQ37Sy2BOeYMEdTUimOuqZmg2gumq12h5QrtF1t9vpzFRgVxJw>
    <xme:QqfHaREydxtcA0s9lT1sc-XQcHdv-KCruICN5j6UpGhIP0jt_riJp_UJk6dPNeFg1
    zexUo3sOmi_SuuS6fH0la_xEjgMoaWFN8DvjHe9T2S5gwfDWaUMqOk>
X-ME-Received: <xmr:QqfHaWiNsOJWpbM129jmxdFRySafN_wchwMn_Xr0k8IH8tRcI8a_MlCXiFGPMTnpZ9vUksW-_HwXo-FqK64mNj-CLI7M3-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedvkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepieeljefgleetudfgtddvteeifeevkeetudeghf
    fgvdejkeduffffffekgfehledvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehprghulhesph
    gsrghrkhgvrhdruggvvhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephihotghtohdqphgrthgthhgvsheslhhishhtshdrhihotghtohhprh
    hojhgvtghtrdhorhhgpdhrtghpthhtohepphgruhhlsehpsggrrhhkvghrrdguvghv
X-ME-Proxy: <xmx:QqfHaU_u8deFKPXemsRVRVpeqc6LFLxMMY3xw2DDrkeT8Hn9lgKDlw>
    <xmx:QqfHaVrvt2obVI1ilbiOLeNKTeYx02vEw-Q91D66opxWdShHewx8Ig>
    <xmx:QqfHab-w6wHj761xy2QvC3MnGgxWj0S8zLlbxG2uOGNYP-ZnhgEzdw>
    <xmx:QqfHaRWOzv_W95C6QPs4rPMSllt5-ahGvxl0ZKU7jc4gMwf-5GMXBw>
    <xmx:QqfHaabsyuDChW0C-IGpYoZ6xnYxOu_AXfC9Qyd02SGVC-hHgYeSCla->
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 06:02:41 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Subject: [PATCH yocto-autobuilder-helper 0/2] Extend and fix check-layer
 job
Date: Sat, 28 Mar 2026 10:02:23 +0000
Message-Id: <20260328-checklayer-v1-0-36bb1873751b@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC+nx2kC/yWMTQ6CMBQGr0Le2ia0ClGvYliU9sM+bSjpj5EQ7
 m7V5SQzs1FCZCS6NhtFvDhxmCvIQ0PG6fkOwbYyqVb17VGdhXEwT69XRNF1qp/sSU6QF6rBEjH
 x+ze70RpMDkKXHMbC3lbdwS+INPzNVMYHTP6+ad8/lVsjAogAAAA=
X-Change-ID: 20260328-checklayer-5526fd41fe19
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=Y8nj4usy9RbPnmiks6DxiaXSWA3Su9puWz++I+iqLGQ=;
 b=kA0DAAoWq2NU7J269G4ByyZiAGnHp0Gg7LyTBjoy/tmz5Zh5cX7kBq3SHen33mqVuqNe+7l5p
 oh1BAAWCgAdFiEEs4z13+WNQQ1oVNogq2NU7J269G4FAmnHp0EACgkQq2NU7J269G7TmwD/c9cA
 azslmQWw5apaQaEcRhJjU4o841eUYB8SgUQXQoMBAKAJ3l0qBywpFYED8C20CxGxe+arkQOdzCg
 rNAd4sEMN
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 28 Mar 2026 10:02:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3570

Extend the check-layer job to cover openembedded-core and to test all
supported MACHINEs. Also fix testing of meta-poky and meta-yocto-bsp.

This series should be applied after changes to openembedded-core [1],
[2], and meta-yocto [3], otherwise failures are expected.

[1]: https://lore.kernel.org/openembedded-core/20260328-default-features-v1-0-90790864d734@pbarker.dev/T/
[2]: https://lore.kernel.org/openembedded-core/20260328-fix-checklayer-3-v1-0-53da29ef5c35@pbarker.dev/T/
[3]: https://lore.kernel.org/poky/20260328-default-features-v1-0-549331ccfab0@pbarker.dev/T/

---
Paul Barker (2):
      config.json: check-layer: Fix testing of core layers
      config.json: check-layer: Test with supported machines from core layers

 config.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
---
base-commit: 7e475b822d164e02f03a60cf4e02f0db0c4d086e
change-id: 20260328-checklayer-5526fd41fe19

Best regards,
--  
Paul Barker


