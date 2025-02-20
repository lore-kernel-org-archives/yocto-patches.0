Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058FC021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:18:27 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.2500.1740071901255983547
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 09:18:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=D//4d30z;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-2025022017181915ef291697c8efe564-w8smmm@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025022017181915ef291697c8efe564
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 20 Feb 2025 18:18:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ouvoNxXm4bGEgtqZ6hSd05ARZETTSryAuGM+cbo/J8I=;
 b=D//4d30zDBxGr4ARc24pqeX1KZ2sk2Iv1MzWWNIYzg4w+Cj11NtZJTL39Qjd8NO94uoUmJ
 tvfYZpWJcoe+gmxItGhDUb8ZyN/2/KMoC2g0NM9/oMmbh1QZBbH+apqCex4V5n6UH2C+n8HZ
 Df1JI5Aw1MN6oR3C0orSjGnuleZDXWzJ8V/6FKiDsH6NAIYsaBBHr6BrKsRC/lIXvFkug85G
 tglfBjxW3BMMsVpsU0FMlLQWMMHGjL5naDnYsoIrJAflbFtFv1jOWMHZvRHWQ+TBw9RyPa5k
 wjJzcTiLeNQI88OHFR4L8yu1q/InH76b8bmcwCli0EowAkfVHDyVMJPA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-autobuilder-helper][kirkstone][PATCH] config.json: add commercial recipes to cve-check
Date: Thu, 20 Feb 2025 18:17:33 +0100
Message-Id: <20250220171733.163089-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 17:18:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1105

Currently there is a mismatch in weekly email cve-metric reports and
reports on https://valkyrie.yocto.io/pub/non-release/patchmetrics/
on kirkstone branch in ffmpeg which requires this.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index 58be042..64a848f 100644
--- a/config.json
+++ b/config.json
@@ -918,6 +918,7 @@
                 "CVE_CHECK_FORMAT_JSON = '1'",
                 "CVE_CHECK_SHOW_WARNINGS = '0'",
                 "CVE_DB_UPDATE_INTERVAL = '21600'",
+                "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "BB_SERVER_TIMEOUT = '0'"
             ],
             "step1" : {

