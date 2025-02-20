Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F38CC021B3
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:17:37 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.2478.1740071855180514964
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 09:17:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=j0NK/Nj+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-256628-2025022017173395315c75b56eaf2fe6-a2xzdo@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2025022017173395315c75b56eaf2fe6
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 20 Feb 2025 18:17:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=PngTq9QmKgUzDuIVcz5zNYIxo+o0RfZ+a1Ne1Jaw1HA=;
 b=j0NK/Nj+qZa0OjnFycHM6jxWooKJLQXMRy745xJM4yVum+wPiT1FX2w0WwJ8FmtJYOCagl
 ayid+kRu+1iuDzmPjsOeeKpLZfysc9eaFzafJXzpLTL4bSlpCgIdjq4x/XBmGoDFLQ/pTYMq
 bdyay/83D8VJZqQ2qzLqfiY7tVRKoCi92Ichp3xub6MBC8K1tkSMA1dB7fL28fMMwgj0swAD
 FkNW5ho+gCixgwVoUYNcp0y7Kw4D/tYVSWX5ks72pArxSG92nuabnI4FN5EGQn9t32ZQ5I6T
 9RpWebIF4Rv6qS0CF6dJhRzlmLjxAbicP5U9blziUvC6fqY5NSyLUl2w==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-autobuilder-helper][scarthgap][PATCH] config.json: add commercial recipes to cve-check
Date: Thu, 20 Feb 2025 18:16:46 +0100
Message-Id: <20250220171646.163032-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 17:17:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1104

From: Peter Marko <peter.marko@siemens.com>

Currently there is a mismatch in weekly email cve-metric reports and
reports on https://valkyrie.yocto.io/pub/non-release/patchmetrics/
on kirkstone branch in ffmpeg which requires this.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index c4a7352..181d394 100644
--- a/config.json
+++ b/config.json
@@ -1290,6 +1290,7 @@
                 "CVE_CHECK_SHOW_WARNINGS = '0'",
                 "CVE_DB_UPDATE_INTERVAL = '21600'",
                 "CVE_DB_INCR_UPDATE_AGE_THRES = '21600'",
+                "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "BB_SERVER_TIMEOUT = '0'"
             ],
             "step1" : {

