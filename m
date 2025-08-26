Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CBDCA0FE7
	for <webhook@archiver.kernel.org>; Tue, 26 Aug 2025 19:06:58 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.74149.1756235213359181001
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 Aug 2025 12:06:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=Di3L9hmZ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-2025082619064800e7ff905900020722-6tl6am@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2025082619064800e7ff905900020722
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 26 Aug 2025 21:06:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=uP1IHmkSQ16nkSiMh7JCs5U2QzjXJ00rlWKk0OwBbZk=;
 b=Di3L9hmZOYBokNlwcvQIqXC+O+dJEtDl5p4xYgafGuOJ66NQ92KSvm6g3VDYkeS+LGtpr0
 5PZAcJ3LidCAvxdcD16prsh/+LtKb+WQengOdHeORO6gsM+eRxJ/BTxCqeIbtyh/U7Wml4Kl
 VCWU/wxB7XF5lIxkAigV9P/AMt7YrJcVt3I9e7YKmh8USWNwM2dU2c1CWjeTMmSzI5gca3D7
 //0HaUOTsSyo/Z1WecafGi/HIw34yW1OUGR9daURprpBs2p++Gi9Xsm0O+ixSu7dsURA0TwC
 Vyo29zcmwIqk4K1bhQYpmG8ZC3BZ4OVNQmgs50MRnkg0sYUb/c83iBBA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [yocto-autobuilder-helper][PATCH] scripts/collect-results: add cve-update logs for metrics
Date: Tue, 26 Aug 2025 21:06:00 +0200
Message-Id: <20250826190600.20606-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 Aug 2025 19:06:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2083

From: Peter Marko <peter.marko@siemens.com>

CVE update is currently not working properly on autobuilder.
Add db update logs to build results for problem analysis.

The globs are necessary as:
* there can be different host archs
* there are different db sources (nvd/fkie and nvd2)
* db update version is irrelevant and glob is future proof
* ther are multiple bitbake runs (metrics for core and oe)

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 scripts/collect-results | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/collect-results b/scripts/collect-results
index d29916b..b6cfe87 100755
--- a/scripts/collect-results
+++ b/scripts/collect-results
@@ -28,6 +28,14 @@ if [ -e $WORKDIR/buildhistory ]; then
     fi
 fi
 
+case "$target" in
+    "metrics")
+        mkdir -p $DEST/$target/db-update
+        # there are multiple logs (for core and oe bitbake runs)
+        cp -f $WORKDIR/tmp/work/*/cve-update-*-native/*/temp/log.do_fetch.* $DEST/$target/db-update/ || true
+        ;;
+esac
+
 HSFILE=$WORKDIR/tmp/buildstats/*/host_stats*
 d="intermittent_failure_host_data"
 

