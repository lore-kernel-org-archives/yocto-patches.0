Return-Path: <paul@pbarker.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7782B108B90A
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 12:01:29 +0000 (UTC)
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10934.1774008080953221979
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 20 Mar 2026 05:01:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm3 header.b=fHBfI/Gn;
 dkim=pass header.i=@messagingengine.com header.s=fm1 header.b=n09Q1V/4;
 spf=pass (domain: pbarker.dev, ip: 202.12.124.149, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 201631D001A7;
	Fri, 20 Mar 2026 08:01:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 08:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1774008079; x=1774094479; bh=/u
	YAus+gQti4HdaW613QUbR17HVS2URAK1Qj5/rbSCU=; b=fHBfI/Gn/hyL9xe3eB
	RlkhEO1BVzxEqPdjMlmo0LJiVDZVPbL2yEEGrpnicH3nVo7QJa0owWOMyj7KtPuG
	bs2JbtJ9jBOwxEw39tLC5Nc0/GPigKKowFEPSEi0/ieN5yTQV9V9wYhFTeRJ4XPY
	Kx9tEvaQPGWYAvNm/J3xXdnmSE3ndB68LExXzNC/kvLnhpFdU1PSWcIaO6uO8qVO
	Ja5BAN+ri/VG/EFhonDHfs/eEZE56+zdeG662gJtDaJU++dUCJZAY1iePtGBtztG
	MBwG1R39Bvq+IGSrL0VwfPwKeaUJBKFH9FWCh1jdws4IcetVZo/UvXjiPKuQH7MP
	4hMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774008079; x=1774094479; bh=/uYAus+gQti4HdaW613QUbR17HVS
	2URAK1Qj5/rbSCU=; b=n09Q1V/49QQbPY/ZsJGWswKmx5+WETE7Q/Th0eAOYUUr
	F9nEmc4x7Y30IkGDVkeLWFOskZESE3RideN3L1RFo66gC75VXda5XbKMo0Q+Gpiw
	w8ix3utb2f8dBzb8JRMPoG0+6GdskhOpV+9SAAVgmBljHMsp6gKxHOFwAjBoCAuV
	GrIrTHN5VWD73rYpY9sP+6mSZWXtS6SRjQ2SYow147WPCiexCu4ye+2wHI/8MRh/
	+aAYIgOzLYf6Ra4VfuJvX2pWqILGOnOdoezG5DX3Qf+TPxDknTm6VYyO9Zfl1Ehz
	r5w8eLXElC4CiRje1cz2lxczdCWreO+I1jt6uG6d5w==
X-ME-Sender: <xms:Dze9aVkCxGgJtJyyF3arDRdI_6DrsYR1rG3KZ_jeK3GGZnuDV6ehzg>
    <xme:Dze9aW2VMOZC7h2Kxt72NttPx9aMKNMb8-dLx6oSRurrjgGZNat1FCd6jLFm64E_X
    YD7sRL3mNk8WtAf3XqDjfNOm1UXOfpFitxzyKXaxRzXqaq679brx5A>
X-ME-Received: <xmr:Dze9aZSDtCOuMx_hbZQy334yeIjq9xFF4Gx-78Hnx3HSmLFpPZCS-XopFvpwWqQKtdO4xLioVt0OBhFbgbTO3oUSJ6B4-OY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgruhhluceurghrkhgvrhcuoehprghulhesphgsrghrkhgvrhdr
    uggvvheqnecuggftrfgrthhtvghrnhepjeduueevffdtudejgeeiffduhfefgfdvheehtd
    duiefgjeelleelvddtkeeuhfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphgruhhlsehpsggrrhhkvghrrdguvghvpdhnsggprhgtphhtth
    hopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhesphgsrghrkhgv
    rhdruggvvhdprhgtphhtthhopeihohgtthhoqdhprghttghhvghssehlihhsthhsrdihoh
    gtthhophhrohhjvggtthdrohhrgh
X-ME-Proxy: <xmx:Dze9aQtHXS6jkvv_MZHKwHU3qqeg9k5fY99n9KSGIgNuaJBnfIPhlg>
    <xmx:Dze9aWafdX26-znG8t4KcVZyQnsyRPPoPNSnmjQz_Mz9sS7r53iGXQ>
    <xmx:Dze9adtt6htUDg5cbjvBAYY7wLdpHmYTKA9NL_voGYdStmx0JXdjcw>
    <xmx:Dze9aQE7_IwypPmrLhuY7o2k4GOu7wrxfAvGcvx5SJybmFgzdThpbQ>
    <xmx:Dze9abKSPZcSv23KsSN3mAbG7kSnI7RQyIw2Z5xxMrAM5oNeWoZLTL8V>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 08:01:18 -0400 (EDT)
From: Paul Barker <paul@pbarker.dev>
Subject: [PATCH pseudo 0/3] Memory management fixes and b4 config
Date: Fri, 20 Mar 2026 12:01:05 +0000
Message-Id: <20260320-some-fixes-v1-0-f5ca33dbf180@pbarker.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAE3vWkC/x2LOwqAMBAFryJbG4gRv1cRC2OeuoVGsihC8O4Gy
 2FmIgkCQ6jPIgXcLOyPBEWe0bxNxwrFLjEZbWpdGq3E71ALPxDl2kZ3zewsbEVpOAN+kfqBTsH
 lPI3v+wHIOCCfZAAAAA==
X-Change-ID: 20260320-some-fixes-d87097cdbeb5
To: yocto-patches@lists.yoctoproject.org
Cc: Paul Barker <paul@pbarker.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=549; i=paul@pbarker.dev;
 h=from:subject:message-id; bh=tnLlp9hJ+OT61V+ag2bjPH3/j2nopMDVhPI1BKWrOc8=;
 b=owGbwMvMwCW2OjnkzdxdX/IYT6slMWTuNecreVGy5da1OWX3bHO3h56bxJqjfbyp9Xe5cL9iQ
 0HVlqX1HaUsDGJcDLJiiiybe77ef9rryJsRcksBZg4rE8gQBi5OAZjIfQZGht122078OHqKv/vd
 ZZmm2fP5HP92xVz59dD9mLjR8e3FF98yMrwSvnk8f3LJ2T11q3d/eMmdadjAc3oL7/5XwklewgX
 lPSwA
X-Developer-Key: i=paul@pbarker.dev; a=openpgp;
 fpr=98B2AAC100AC3F82BB5D546774975C81B7E66BAC
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 20 Mar 2026 12:01:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3524

Fix memory management issues found by Claude Opus 4.6, and add
configuration for b4 to simplify sending patches.

---
Paul Barker (3):
      pseudo_setupenvp: Allocate space for new env vars if needed
      pseudo_setupenvp: Handle malloc failure safely
      Add b4 configuration

 .b4-config    |  4 ++++
 pseudo_util.c | 18 ++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)
---
base-commit: 56e1f8df4761da60e41812fc32b1de797d1765e9
change-id: 20260320-some-fixes-d87097cdbeb5

Best regards,
-- 
Paul Barker


