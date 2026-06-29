Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99518C43638
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 07:36:11 +0000 (UTC)
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.87100.1782718561453761159
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jun 2026 00:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=F0b86IEL;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=Zvf35Gsr;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.159, mailfrom: paul@pbarker.dev)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 740827A0090;
	Mon, 29 Jun 2026 03:36:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 03:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1782718560; x=1782804960; bh=ft
	XY1hzUt5rdLax2kEFwHyUIYhe+n9GyVG9aJU3XQ7w=; b=F0b86IELau9JwxgjUN
	vWyAbru0wyrNfVmQYPjO0irNw3HKDeeYSPGZwZcN2YvCohno5Urkr2CAhhKzx/+q
	pvBSX/cKTyYSxt9+BRsd6YcMwUEMss5mpa1raLPBxXlE7pKBTK13P3PzGHXmv89N
	chnOkMjn+slu//QSxPxzaqQc2B9y2TlKkjaf9EhGzSQ0D0ACwrStlkN3H6IEMLt+
	xL2/KwUOaBhSsQOhbq0m5lJOu6Ys2BvYiQzzFDvT1a7L7sChVJs6C4fh6/rlBHoW
	lHbYW2DXtV6TkbAgo5F3SIzZOFV1Pyu6gcg+Ry6in2u1cbkGe5pY7EHxJbok3F3T
	EElg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782718560; x=1782804960; bh=ftXY1hzUt5rdLax2kEFwHyUIYhe+
	n9GyVG9aJU3XQ7w=; b=Zvf35GsrIft4torDsU3XZMzSyOjCNLOLk0goGahtIfAK
	OBbSI7hZAhwwgoHN90OP/obx22iUDDTcdkqdpBTAMCmKV6DDMRA0Iqw4RkrDVrhO
	7TGOJPDVzy4V043CmpH0Dtza+szt+HJGNx6oCfOeR28gL6/mtdbxUygty7JDzxP+
	7zCM95w51PLHPYwNYT6yXZrY4Kt2gGlSy27Ni5DDHy+JC5Z6gaQD+Zhw0yr/nef8
	uNmffUQEnoDQNVqeL3ntuiw9uZIuPc6yRz1eQlj9JmzsEjl0C8XdOX4DgFX04hV5
	6/IXPEuThW0HLNwyIASKXx3dbt4NO0BlzVngTBPEjQ==
X-ME-Sender: <xms:YCBCao8kUW7LQVSU4HParEO0TGq-OfnTLl98Ke156F_SsiJMjHgmOw>
    <xme:YCBCamuqzG3VpUB9hucquw-_7iMS22osQkaIpUgvVgbJJD1IxNrTyg-pV1GfG6N1F
    5k6T4fFmax9whCXq3N_-Yztrt0Buf9kQzSyYRZzjkQil7DRQjy1lK8>
X-ME-Received: <xmr:YCBCarqnLboEIhsdSsmOgBCiS6qgGKAujiAQSSq2Ysuf9rT_LSBm10DEoTtoHn0GuBxXZl2GOeddE150p7QDkS8rhun-bS8>
X-ME-Proxy-Cause: dmFkZTGBUGRB/wEMoiG/O4VWo0/0I2ZqPTLfdn+LF6If4p1f3udrfmpOZf392vRleFc5Ys
    lh9SzrQJUUHwbfFnHpvcaHrZtsnLsTrpINx/Fz/FErkOYxkMho0J2libQR7x1TdkTrLHYG
    1qbrDuz++HSPuY766oblDvn+wWkE1jD5Lgg3YPYjApQhMgXhLl4hxVWuHJYfgcjAcubF78
    74QO281OD9lTtHqA6OLkcFQ5dToCa+YCJPY6j++JfFN4ow+qD+YYZLAPjSNU1VbPreqyDh
    1NbrzSDOKLq9LUIfbaFJYUlwGYHj7SNPTjl4znYWwKft23h+ooI9P0pdgExh7OcR2hqnc6
    STm34Iz3DXrsxzR7PNw3fbSPpAauwr22q8uke9Ljnt3K3GhNRBoz0evZ9rxyHzTVl4TI76
    Ap4aK1hYTp1I0g86cS0ek6R/AnrzvsMd/sMFk3BqBus1YvJoRA4ERpremTYt+8NzTyrVjE
    AQ+DayVt/XLQM79x1YWqHFXy4popDweiwZ9Cu0ib0rsdwnn5HtUd3WXwJTqULYINZV+dF+
    NYtgQvFqcZHrZFsAFN5dZH6qm9HERk8qnnY7Q3LpQ8fJusO40ECmbc2olXZUyG0eWAsOZb
    doWSbEDmn+sfx8STpczxsimaJjTIslWHJZZKjaKMv0nZX3Guzi3DF5PduKGQ
X-ME-Proxy: <xmx:YCBCajnPc10jadqeZ82yo6PKFrlN6g8kLOV9GBi0nhjBWjuQxMOO0A>
    <xmx:YCBCavzuzjb1fhCLpmGBFHX1aIKpRlo4ETST6b5NUK50aly8bbonmA>
    <xmx:YCBCarkUurZyra_b00Aa4VZzEzp39ckaYBsICBqYUqppUDsciDoO3Q>
    <xmx:YCBCaoe7-V8y_MG-t5EYI_OXNLw0oHqfVH-pOs2KfRQcimaRdqKOZQ>
    <xmx:YCBCakhlVAH627q_nZGAcFV89Qn5XOxosZxf8GAu8wL2NRcvtdtismon>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:35:59 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Subject: [PATCH yocto-autobuilder2 0/2] Branch selector updates for
 master/wrynose
Date: Mon, 29 Jun 2026 08:35:44 +0100
Message-Id: <20260629-branches-v1-0-1ab28b1ee5e8@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFAgQmoC/yXMTQrCMBBA4auUWRuIUxrQq4iL/EztiCQyk4hSe
 ndjXT74eCsoCZPCeVhB6MXKJfc4HgaIi883Mpx6A1p01iGaID7HhdRgGu3oZk8nnKDzp9DM731
 1gU+JtRjfagmNH4kE4fo32sKdYv09Ydu+J4E+bIAAAAA=
X-Change-ID: 20260622-branches-2d3036fae925
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=550; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=PpJE09Uy8Z7+gVN8AwKdWuEJ1UVgjG1C5GVv4Dp1nF0=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWQ5KUTu1Lu7JTZ7D5fSPdsXtr0pGbJHFJvu2Dy+laX1g
 0dswdsvHaUsDGJcDLJiiiybe77ef9rryJsRcksBZg4rE8gQBi5OAZiIXzEjw82pPLO3//h2zvn8
 bdG/0zrnGS890vFTNWvpi5jZfZuuOvQy/DOqyVi6Q1+dszmxPSBi/SSvooKW0xHfyy57/mNVFTl
 6nBkA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 07:36:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4314

These patches apply on top of Mathieu's patch to add the wrynose branch
selector for meta-openembedded [1].

[1]: https://lore.kernel.org/yocto-patches/20260623-mathieu-meta-oe-wrynose-v1-1-cdfca42191d3@bootlin.com

---
Paul Barker (2):
      schedulers: Add missing master branches
      schedulers: Update wrnose branches

 schedulers.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
---
base-commit: c22326b41a6b0ca2ebb9ec49e9531ae4133f5c28
change-id: 20260622-branches-2d3036fae925

Best regards,
--  
Paul Barker


