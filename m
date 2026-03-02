Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E077FEB3629
	for <webhook@archiver.kernel.org>; Mon,  2 Mar 2026 17:45:26 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.166696.1772473518882137721
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Mar 2026 09:45:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=jqtFRCG3;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso42971055e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 02 Mar 2026 09:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1772473517; x=1773078317; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uklgIcLOE4iou+o+2DZ/BuLgD8VEp+6hwv+zsJGpT3w=;
        b=jqtFRCG3ZnqDaWJmkb9JIt6kY3Bvxb/cVw9wtZKjQ5b584TdaHNFhiuhaeEG1tsjny
         0omP9E7yP/tEwHY+JTpaNuypsU0s1FxZcRnkRVsu8075Q6HeJI2OnyfDIzPom3ixVB8p
         Qv82Z5ueuqK0q/bFsVgg9nF/9NuGwlwsKeJAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772473517; x=1773078317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uklgIcLOE4iou+o+2DZ/BuLgD8VEp+6hwv+zsJGpT3w=;
        b=pmg6sxqczBgXOaHYBrt/jrZ1iP2Wn8r/Clk8h8PQEgBIniK6R15K3aPSeGZqLqD5fo
         SwhbsVHnIgiCElDS6v10oSS6xk/un/jE8/hTpebiFDmyy4w2Ag1J1VhKh1w9W358ovFr
         82Vle0P05GqB2nETmEENZvPAfp2Pbvs8jaDTXPfy4j/pXblxvRf1B5hin2YIdl42URSW
         qHGQ4bUwhdvmM0p0NVBuacb+h1kRCpta5ROpcunIp9aLPp1MzSdWDG54iEZ9pD2KNnw0
         XXifae05yNTt9G5SZOUbuVZp6z4RQBVHNBMHjIOHYQV3hGduF4KsyMMMahVKk4vfPtST
         f5Xg==
X-Gm-Message-State: AOJu0Ywn3bT/NKvBuIOkngnmdMT00sFEwvS46b8UowVTAjr5Pf9edimJ
	3g2hK8XyRWKtDaHT3CsFF/1WlGrRaIrGdJ+SWey1tfWrhMJ0Ai9v7CJ8Y5oFVj60TTUxEIUFGos
	quXa2
X-Gm-Gg: ATEYQzyGhie7rGkOt+f06GuXqVudE8xB5DiDcXTLiCJQDxy3aOt8QvSkqgIC7oKklyB
	WDUlI70a8fRuCo6W5oddf+yNLQQ59iWLcSabrqlTN5cLbQLSgYLTDlEamDaAfuVo27y1X9hB6hE
	vOWxIvYtIsIFSZBFF6baFfZ6c+jjdjqWhEEOzaGjWqANKuMUl7VUzUc6BLPDz8p+5e5r+m8mUXK
	58mKhdYv5olUehJAZbT26wYEQTriYai3TlWgnDIh6lz/UEj1pRQPZkzSSSzHJF82ntuTjtN3u6K
	GfFrHPCk+xDxTLDuyHqb+alGHQVB5H1HcI13RHB4UTmWSi810j+n7nMK9H9/hO+d3oKFPlp585b
	rY1MvvqoQj0HzpmIFmlch8V9arH5hjo9o4QmxoX4FGRpwkGzAMHYYI1ufQWoS8ErWvBYs8Cf0Br
	yNIbwDmp3lMRrvHUCyu2pBphdFTsl+i0WKUWN2YHydsA3xmf9W76LroF2afEZnRqKEwQaGYciTa
	YZtsheeJn/zEdDfsgmqc9b7fWhZ
X-Received: by 2002:a05:600c:3b22:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-483c9c2d29amr211906515e9.30.1772473516931;
        Mon, 02 Mar 2026 09:45:16 -0800 (PST)
Received: from localhost.localdomain (2a02-8440-750d-091c-368b-8fe8-5e44-2549.rev.sfr.net. [2a02:8440:750d:91c:368b:8fe8:5e44:2549])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c35910f1sm251707875e9.2.2026.03.02.09.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 09:45:16 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Cc: anibal@limonsoftware.com,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [ptest-runner][PATCH 1/2] ptest-runner-collect-system-data: add info to logs
Date: Mon,  2 Mar 2026 18:44:59 +0100
Message-ID: <20260302174500.357368-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Mar 2026 17:45:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3313

From: Yoann Congal <yoann.congal@smile.fr>

Print a banner to make it more clear what is happening when reading the
logs.

Add used commands to stdout by using shell's "set -x" (which prints used
commands to stderr, so, also redirect stderr to stdout).

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 ptest-runner-collect-system-data | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ptest-runner-collect-system-data b/ptest-runner-collect-system-data
index ba335da..15205f1 100755
--- a/ptest-runner-collect-system-data
+++ b/ptest-runner-collect-system-data
@@ -1,5 +1,9 @@
 #!/bin/sh
 # Other ideas on what to do when a ptest gets stuck welcome.
+
+echo "Collected system state:"
+exec 2>&1
+set -x
 dmesg
 pstree -a -l
 df

