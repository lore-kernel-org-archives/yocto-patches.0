Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA81FC0340
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 14:53:47 +0000 (UTC)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21837.1776956022335437651
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 07:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=fMfkx5mD;
 spf=pass (domain: 0leil.net, ip: 185.125.25.15, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g1fH80hCTzF9t;
	Thu, 23 Apr 2026 16:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1776956019;
	bh=0EgLRSag3Y+zmdATBemuNQ74A/EssESP4GCgfTuk76g=;
	h=From:Subject:Date:To:Cc:From;
	b=fMfkx5mDiZzGpAIIjt4q5MUzOQKGs9dUlI/elBu8gW4AG/mJErZQ1sp33zYQJlv/X
	 Wq0D6QHS1523Kxm1gv6Q6tohGdOk7opsmlwBmVLwd+10TvDQTG77muY/nqL+KSbVgf
	 rtDoUbIDtXjcqlmvYuQuZobpMxdrhaUsaDzUxRbmDBUuk2BeOpIZ04kYNeKCd8qxMT
	 lnGbZ/786QCHB4pC0870lNnLhjsPat/em6qfs9P9rwkj5m+ziLwItxThhww00jM6+Z
	 F5Z4YJSc8d6CYpTBzySCBQasB7Q4XktNIN7etW4L1mU0vdxlj8RAHRRSL57YwPIr/X
	 A+xgHtxFzEWhw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4g1fH74khtzk0S;
	Thu, 23 Apr 2026 16:53:39 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH meta-tensorflow 0/3] remove tensorflow DISTRO_FEATURES and
 Python version check
Date: Thu, 23 Apr 2026 16:53:32 +0200
Message-Id: <20260423-python3-14-tflite-v1-0-68bca178a550@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBAAf6Xs2YU0jQX9FfGQxo1dqUnJbn1Q+
 u9GPQ7MzApChUng2KxQ6MHCOVVodw2E0acrIV8qgzW2N852OL91zKnD1qHGiZXwMPh974w3wVm
 o3Vwo8uv3PMGd1KNSklzilJ9w/guyDDcK+j3Dtn0AVTcpm4YAAAA=
X-Change-ID: 20260423-python3-14-tflite-9ba5640a0c42
To: yocto-patches@lists.yoctoproject.org
Cc: Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 14:53:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3779

tflite used to not be able to compile on Python 3.14 that is in OE-Core
and required to use the backported 3.13 Python recipe. Since, tflite has
been updated and now supports 3.14 therefore the work-around isn't
needed anymore. Some cleanup was done but not entirely, this cleans up
the remaining parts.

Add b4 config file so contribution is easy with b4.

Fix mailing list address in MAINTAINERS.md.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      add basic b4 config file
      MAINTAINERS.md: fix mailing list address
      fully remove unneeded python3 work-around for tflite

 .b4-config                     |  3 +++
 BUILD.md                       |  3 ---
 MAINTAINERS.md                 |  2 +-
 classes/tensorflow_ver.bbclass | 20 --------------------
 4 files changed, 4 insertions(+), 24 deletions(-)
---
base-commit: 078ed7b791faa38553ecf8e93048bd463f6edc8f
change-id: 20260423-python3-14-tflite-9ba5640a0c42

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


