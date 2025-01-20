Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020B1C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 20:14:38 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.179.1737404068657557390
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 12:14:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=Eaoouv7n;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20250120201426609ae19aadcb586971-kdwwrq@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250120201426609ae19aadcb586971
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 20 Jan 2025 21:14:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=8nO/3C9Gto2P1GBTyIaGmxZf/SjTaKAzG6JFmzZGWVE=;
 b=Eaoouv7np5ivWba6rLvhKsjx0tbiZ4FI4fc4zFLKk6P7spR0ZOUKfQzLL204sVy6P1tNf3
 hqiPKtMzxQYU0UE/ciw991/1J7AbB4vW64ttFmTwJJz1HWGgK9nzFIWWs50WuzmoOW12qBzv
 tOXLV2Ktq1POeePREcNpF6ENZ5qRpQkWvSh2abNEgWLgGNhOCXLWkfTJuDs2UtZXJS8rhHmw
 4PnZyP+EvmnR9fXwWFuW3Tqjs9oZFIviDwIPLBpge9DaHCy7Am/+dQQGkHwmOrsG7tRmXmE/
 scIVF20Qeq3xszj15Rz4qUfDsyKLRAPxaOAePyDndqwCrb2fqujh/tiA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-metrics-meta-oe][PATCH 3/3] releases: add nanbield, scarthgap, styhead
Date: Mon, 20 Jan 2025 21:13:22 +0100
Message-Id: <20250120201322.13262-3-peter.marko@siemens.com>
In-Reply-To: <20250120201322.13262-1-peter.marko@siemens.com>
References: <20250120201322.13262-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 20:14:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/995

From: Peter Marko <peter.marko@siemens.com>

Sync with what core shows.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 patch-status/releases.csv | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/patch-status/releases.csv b/patch-status/releases.csv
index cccb2651..af8e1925 100644
--- a/patch-status/releases.csv
+++ b/patch-status/releases.csv
@@ -1,4 +1,7 @@
 Name,Date
+4.1 (Styhead),2024-10-17
+5.0 (Scarthgap),2024-04-30
+4.3 (Nanbield),2023-11-14
 4.2 (Mickledore),2023-05-03
 4.1 (Langdale),2022-10-23
 4.0 (Kirkstone),2022-04-27
-- 
2.30.2


