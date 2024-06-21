Return-Path: <alexis.lothore@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB47C2BB85
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 15:57:41 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.77004.1718985455736724918
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Jun 2024 08:57:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=IfwZEbQx;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexis.lothore@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A1FCA1C0002;
	Fri, 21 Jun 2024 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718985454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7DMYfIeNJ0uFOZJmT1DD131rQ+TzUp8t5DNHTlHLWSE=;
	b=IfwZEbQxpQ2jvkj+RBCIuQa/m3oRRtBkhPlNLKFH2ZM2w7Ya6n3ozFxjFyXRTIVHpWMiK7
	EGty4kBwJJ/PQyf1KdtIBDXfQZLT4CIg5ivnDUrAIIhZeq6X0IYy5CDFuOdwu1MrPZL/em
	LkpiFq8MaTdwUm0AzOrwbOhSKT/rK+TnoPQxfOP8Qxs+QxBvYkr4vXWlxGxxYhA33IJxlA
	4j4yMe9ilFpPA0NZv+Ye8xz2oyCqmMZwSUErPK1FXoXD2m0lxVnmmZBdrUcMusPAPmLApw
	DL+PYWzSGYDb04hAIG6e8wjFvdA6H7Xeo3UWSjazRdvCSOX6Tpqm6phdN4FncQ==
From: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [yocto-autobuilder-helper][PATCH 0/3] scripts: send_qa_email: skip regression report when missing base or target
Date: Fri, 21 Jun 2024 16:57:20 +0100
Message-ID: <20240621155723.33600-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 15:57:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/365

Hello,
this series is a follow-up to the issue encountered in the autobuilder
during the send_qa_email step. The corresponding bugzilla can be found in
[1].

To be honest, I am not sure why the issue triggers only now, after
inspecting the code, I would have expected this issue to start appearing a
few months ago on any build not being a release (ie testing branches). My
best guesses are either about a python update which changed subprocess
behavior, or, more likely, some features of send_qa_email that have finally
reached new branches (I am not sure when and how the
yocto-autobuilder-helper branch is updated in the autobuilder).

The first commits are small fixes about issues I have encountered while
sorting back my testing environment, the main fix is in the last commit.

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=15503

Alexis Lothoré (3):
  scripts: send_qa_email: fix invalid regex syntax warning
  scripts: test_send_qa_email: fix broken tests
  scripts: send_qa_email: do not try to generate a regression report
    when missing base and/or target

 scripts/send_qa_email.py      | 11 +++++++----
 scripts/test_send_qa_email.py | 13 ++++++++++---
 2 files changed, 17 insertions(+), 7 deletions(-)

-- 
2.45.2


