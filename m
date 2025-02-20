Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92903C021B1
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 17:16:07 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.2432.1740071762166813701
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Feb 2025 09:16:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=YUPRVoyb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-256628-20250220171558c67e3d37bb644f961c-sot_jh@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250220171558c67e3d37bb644f961c
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 20 Feb 2025 18:15:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=whskEZl7vI9s1UFXf3XjANN/PimM975VVOE7BVHog4E=;
 b=YUPRVoybjQe2cAqRb+pNZEewaWvaFV4nB31GY1OkGPEYA2oUB8E9Kcoba2k90eKuaeoAq+
 qQPsWvMImP8g8neR9+2t40KyhhnOXeC74g78+2kUmYfMlAdDPvO2G3B3qWFJGmqMNOLb6UsZ
 2KpTUniAPghfXdkDbzjiXH2aFyRBFjODQsWFJu/+phBnrrocNGccW9iafXfC00bwizaiZDXb
 ZyppV+N0RWcovqDwoDo5gUDqMb8xdyNxdfKv9wZi6w+cJchEZM0XxerTUPtfDFAOCCO9CoiA
 cjWzmXGy5FkDbfbBSoEKHcN1EKK3C/x6uYOgFFAlQwibpuflG4ihyNzA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-autobuilder-helper][PATCH] config.json: add commercial recipes to cve-check
Date: Thu, 20 Feb 2025 18:15:05 +0100
Message-Id: <20250220171505.162924-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Feb 2025 17:16:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1102

From: Peter Marko <peter.marko@siemens.com>

Currently there is a mismatch in weekly email cve-metric reports and
reports on https://valkyrie.yocto.io/pub/non-release/patchmetrics/
on kirkstone branch in ffmpeg which requires this.

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 config.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.json b/config.json
index a6a4332..f2f4be5 100644
--- a/config.json
+++ b/config.json
@@ -1319,6 +1319,7 @@
                 "CVE_CHECK_SHOW_WARNINGS = '0'",
                 "CVE_DB_UPDATE_INTERVAL = '21600'",
                 "CVE_DB_INCR_UPDATE_AGE_THRES = '21600'",
+                "LICENSE_FLAGS_ACCEPTED = 'commercial'",
                 "BB_SERVER_TIMEOUT = '0'"
             ],
             "step1" : {

