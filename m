Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E0C021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:16:57 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.2459.1740071809675963814
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 09:16:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=MpoUTRjZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-256628-20250220171647f4bc2570aabf30b3f8-7zvsjt@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250220171647f4bc2570aabf30b3f8
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 20 Feb 2025 18:16:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=hbTLZnwKA6RBOlIjUG7FK4SNEVXbyL1BBUU5VJSW/ks=;
 b=MpoUTRjZgFAtfOghM62I/17Z+CcgQ2b66z0ZP2Yax0lNiEW/zp5Ws1csH0GtUKUHjVXeJM
 NZjzFu2RIZWce5VsDi88voTKrEwMURiD6rg2DeLexbchVPEOZm/QByk1/qADeen1XgicsWJN
 lXMxHSp+OXEBe7Bp8b3eB9NFvxaEIMscntPzpgusEtruCJqMJM/7CwopZaWx6OMTaqqc4WdR
 qpReQcwKMuvWrNbRSV+m7vOkMJYGxpdP7T3gimWePFc6EM3H95NK8d3/hVUnrDJbNp1aafzq
 ULr363AAHdRd/MA1XdP0Q/9+PaSNQqLt4/mOtVWJwKCOXJdIrECNd/NQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-autobuilder-helper][styhead][PATCH] config.json: add commercial recipes to cve-check
Date: Thu, 20 Feb 2025 18:15:58 +0100
Message-Id: <20250220171558.162981-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 17:16:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1103

From: Peter Marko <peter.marko@siemens.com>

Currently there is a mismatch in weekly email cve-metric reports and
reports on https://valkyrie.yocto.io/pub/non-release/patchmetrics/
on kirkstone branch in ffmpeg which requires this.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index 83a81e7..db4191e 100644
--- a/config.json
+++ b/config.json
@@ -1271,6 +1271,7 @@
                 "CVE_CHECK_SHOW_WARNINGS = '0'",
                 "CVE_DB_UPDATE_INTERVAL = '21600'",
                 "CVE_DB_INCR_UPDATE_AGE_THRES = '21600'",
+                "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "BB_SERVER_TIMEOUT = '0'"
             ],
             "step1" : {

