Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF84CCD199
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:20:23 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.8261.1760620820404317812
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 06:20:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2zYDHhNP;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A73A71A142E
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D8736062C
	for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D85A102F22EF;
	Thu, 16 Oct 2025 15:20:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760620818; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=3tuunwQkun7hWYKZD8JXVQAuhOujgadJ/Y0ahbAnUag=;
	b=2zYDHhNPZV6S3XUfw+XGos8l/k6FoyqkXB0VvXLSWDumfIeueNqcepqXovayCPKO73miP3
	2TfZrxIk466xBQ6h2OY+3F9b8562AVrLNZ2gaqWQRWJCd1VIjs/d5eZD41doH7qf3izJSL
	5weMS5c7Mq9ENGleCwLAymJnV4AqGyxqkMNAlfUotN/rma8oeOBTLrx9NvA2B4bDZbYaHV
	zyaB0IyzCfILfZnQG3j+i9GdPCuL5qHvJFWa59/UeiDiFZLMHMuDM86lpRJGfC0jxiA+ET
	qbNZsxh26PWph8upBryOb4pyYJPzR88F48XbWSJ9LdNxJFSoGxb7Pz9QvhFEhg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH yocto-autobuilder2 v2 0/6] Fix links with bitbake setup and
 general improvements
Date: Thu, 16 Oct 2025 15:20:11 +0200
Message-Id: <20251016-contrib-mathieu-bb-setup-links-v2-0-095908455e0b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAvx8GgC/42OzQ6CMBCEX8Xs2TVtjUE8+R6GA20X2Qgs6Q+RE
 N7dhifwODNfZmaDSIEpwuO0QaCFI8tUhDmfwPXt9CZkXzQYZW5aqQqdTCmwxbFNPVNGazFSyjM
 OPH0imtZXZIxy2nsoJXOgjr/HwAtWcUmwzUls5sFTMNAUpueYJKzHh0Uf5L9zi0ZVPO2r2txrd
 +2eViSV7OJkhGbf9x+t+tV14gAAAA==
X-Change-ID: 20251007-contrib-mathieu-bb-setup-links-2ad7e220c1dd
To: yocto-patches@lists.yoctoproject.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760620815; l=1765;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=2b0Xwmb23I0m7VQlNPrHN7q8IvRXg2fM/r5SIjDhMak=;
 b=2LEoXYhrPD8RblnsvpqgAd4q0N8xh6ZLxsrGx0nFM3TEhZF+0OUovcoHyt2Qz6uzn5Rh0LHOh
 8fdtasB2mmmBhBSXrNKUMu4HD4kSi8do+0JbA4GFp2HCi6SJ/qPtPFg
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 13:20:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2313

This is kind of a Frankenstein's monster series with a lot of various
things. Patches in there have a few interdependencies that makes it hard
to create separate series.

Richard, feel free to cherry-pick only some of these commits if you feel
more work is needed for the others.

It contains:
- Fixing console view links on the autobuilder. The "Error" link will
  need more changes in error-report-web to work as expected.
- Adding build properties for poky-ci-archive tag and part of the
  bitbake configuration. Imported from my previous series and modified
  to account for recent changes.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Changes in v2:
- Allow to link commits in alternate repos.
- Link to v1: https://lore.kernel.org/r/20251007-contrib-mathieu-bb-setup-links-v1-0-bb1d79289c3f@bootlin.com

---
Mathieu Dubois-Briand (6):
      builders: Fix disk space error message
      yocto_console_view: fix commit links
      yocto_console_view: fix error link
      builders: Add poky-ci-archive tag in build properties
      builders: provide builder name to getproperties.py
      yocto_console_view: Allow to link commits in alternate repos

 builders.py                                        | 20 +++++--
 ...builders-Do-not-create-tags-during-builds.patch | 28 +++++++--
 .../src/views/ConsoleView/ConsoleView.tsx          | 70 ++++++++++++++++++++--
 .../src/views/ConsoleView/YoctoChangeDetails.tsx   | 44 ++++++++++----
 4 files changed, 135 insertions(+), 27 deletions(-)
---
base-commit: 4397ebf3066b4369d6f6cfbb9e43ec924dba8de8
change-id: 20251007-contrib-mathieu-bb-setup-links-2ad7e220c1dd

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


