Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7CF108B910
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 12:01:29 +0000 (UTC)
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10937.1774008083711401325
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Mar 2026 05:01:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=h7Q7QxW8;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=2kNGCKo7;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D9A91D001A6;
	Fri, 20 Mar 2026 08:01:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 08:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774008083;
	 x=1774094483; bh=akHPv8e0JALNFBebyjsnywAATX/3T3YQ0OWx1DZiyZU=; b=
	h7Q7QxW8YIZudg3g1C3C3sEn20qT7gCtUVMIS9TH2JPOkZSuZyzJaBbY18A9Kcly
	Fhi6ss/fQhkNhY75lS13pl7PRZ2wAE++FeLrDiIoiVUgB8xKqLkgRLxAsXxGJMm0
	iXgNhBF2Y5/iHSbQUXuL/AXlJbYHJqlNUMZiNpSVihePnUSjwAiG2iQTbj1GH+2H
	mIQTAa7R3+s+S9JAhqCH8yNTkFRik/3GEeUmco0JF/AVqw+cxR25SegTEJ+SzgM+
	FDXqTG1loV/gqeLLq2QkfoQZYkURSVUowbJCYxMgCJXxgkxoEAaWetjPkD1yYE3A
	7j8Xf3JS7N/ftfou4KzEIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774008083; x=
	1774094483; bh=akHPv8e0JALNFBebyjsnywAATX/3T3YQ0OWx1DZiyZU=; b=2
	kNGCKo7H/MfJSTvTaGcS7In0TcJVRlPH04tsLYZztSrZnvy9hRYCR7XRCMWI93t+
	TJZHFU9bCRHzclvxKqOImyAur7hm8N5J5snw+Q2U2yfVE2el28IopsT5RTvTvY2h
	gnMvcMgBbFI/kAvLnXtMDeATZiyTrxEl/EY7RkMJgl/TCNOul4EPjxMqAh8K57/R
	DN9zxzafv8xhDPHCLbCgozaj4fOkcL/I5MMVME5GbaTjeVIx+AG/hYbv8uwaWvSR
	vSaKyfdYzXdRW5rF0mgGku281MoUl42lDMjZTr4W5Uo6s+Wt9JrrfO4i5EN9iVZq
	Ao8X7ajNU5B2i3wfHDnMw==
X-ME-Sender: <xms:Eze9abHqY7mUQO8cA9Q250KzL7oj27jX87TONivNnhmFULLWdqnKnw>
    <xme:Eze9aeWSJWZ3Dc_bn976LTWbyEvPrtLfN7ADcAgqoZYqkfXA3yAFtlU-OPDXb2QG2
    OgJKHRWbPw3-QLFQ7oUdBnkKsCTuW7Qp7LZ_ec7RR9pTc186qklDH8>
X-ME-Received: <xmr:Eze9aaw_XnU4vQCsbyuuYfoiuwNCGX4IzaiW4BB877_8chjOhExWmGQsRlSzyqxh6sDjPcJAUYUvefAm8i4_0EqeAXJjsZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgv
    rhdruggvvheqnecuggftrfgrthhtvghrnheptdffvdffjeevhfelieegudfgieefleefue
    efffelvdehfeeviedtieeukefhleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtph
    htthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhesphgsrghr
    khgvrhdruggvvhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrd
    ihohgtthhophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:Eze9aUPtv6iKIWDrCPCnRridlUWgHrxdquVvMHZlkZNfNkYA-SE4RQ>
    <xmx:Eze9aT61bAYWZ0KguCEiwJs2XW5NkHYLpfXf9Vx4WePU6P1wC39TxA>
    <xmx:Eze9adPK3t3iCqghTB2h9iYd2NtXbz7LoGZYU_zUIspK9GXNWFOiOQ>
    <xmx:Eze9aZmgLnIpnti-yyzBfCIxhxi7Ge7BOtI4fuGrbF4Mmz-cv6-8cA>
    <xmx:Eze9aYp0bJLSqgslrJrpBdDzBFr-nvR3qsGNNIGZFt83jLvVwV4MmnOJ>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:01:22 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Date: Fri, 20 Mar 2026 12:01:08 +0000
Subject: [PATCH pseudo 3/3] Add b4 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-some-fixes-v1-3-f5ca33dbf180@pbarker.dev>
References: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
In-Reply-To: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=573; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=c0uFsMCw8vx3AUj5xR+MNGWjcTep+8DZxcb6V37TSCI=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWTuNedbr/4z1m/m5Lq3YhFXDgY/X2bt1WRd1s91UK/zm
 HOQ0sSPHaUsDGJcDLJiiiybe77ef9rryJsRcksBZg4rE8gQBi5OAZgIwzuG/xHBvz6I8HFqPLmv
 FnnKqZrzIYfW5Ucsgqm/ntsJvk+RLWT4K7BUp1Va7UMY88XDx9KeVU+efnlmhmX6tcXX5/w9a7P
 TngkA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 12:01:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3527

Make contribution easier by including a .b4-config file, pointing at the
correct mailing list and prepending [pseudo] to patches.

Signed-off-by: Paul Barker <paul@pbarker.dev>
---
 .b4-config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 000000000000..92f549d8b44e
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,4 @@
+[b4]
+  send-series-to = yocto-patches@lists.yoctoproject.org
+  prep-pre-flight-checks = disable-needs-auto-to-cc, disable-needs-checking
+  send-prefixes = pseudo

-- 
2.43.0


