Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DCCCCA472
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 12:00:02 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.15481.1759319995608234381
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Oct 2025 04:59:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=R3rKUNQt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so3624817f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759319993; x=1759924793; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9UbTc4IuF67VqC9eK2qf/bDGpEfqp/Z+8u4buyJbXw=;
        b=R3rKUNQtY6VJdS0JgiuwyN0rTsaUJIcRwki+d1pLyioeVdjNxKNP4gvZ8AWC+u7y9b
         SqgvJ/9CCe/cTdHbNg4lG5LCU3bXlTmKcX51iKY55K3USOqGdSO9XWiHhE2xgmJimFXM
         cAfj/jGo7roTkNu1c7NRPR2g5bauA1iw+Jl/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319993; x=1759924793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9UbTc4IuF67VqC9eK2qf/bDGpEfqp/Z+8u4buyJbXw=;
        b=pxJpkCazRKihW22bzzNkbp+9Td7EoFp1m62EhmjziFHKB7o89+FN0FeI1YMWb3Rjdc
         IOsbqxE1pETrivtZ3yk9GGEiq3fvC+IbeCjreVzTWJk7W2lpYXCeD0+eXRHAwrdQUZJv
         x+npKsXspQdxjC0zv0ckRoWslMYfsxRUWVJOv5qVMwr20NVz85AULd3l5eLX8heicTZX
         VDqYniy2L+gpKqhg+J1TkBCGvdJQcKbZg+UXJbzhSZKAJPqsLQKZzv+AQPb08nFQtZDF
         RNN35N/0TJh6koZlxamRJGXODeIP5KbPB3cFC16oxFEGpmCumMkLlN/whk7v4wxWEN5e
         EknQ==
X-Gm-Message-State: AOJu0Yxq2Nxt9m6c0myhDbP8Uhjv25208U+1mVJw+J0FEfvdhKqLdjEB
	FzoJfX9H+r3i+M1IDAWIwFds6oNvTtDaiWa6wDfUS4D3Fr2P3OE/i4+iRmCV2Leq/Y+jnQdl+8F
	2fwHs
X-Gm-Gg: ASbGncshJflBNGBX/SqAq0E4GiKOwwRyPdPl36nSqu50PSsebFm5rYNJejNG2wgUxB3
	h1jdw1S8DL13bkLcFzjgRMljCxwYKwbWYqsXKOytL/e9ubyb/x9+O6PAwr6rERUWhJWEjdq8oRE
	OslHehD2Ullv9iwMCDLJbXtXeBxTFlpo3Z5i7/bZtHQtKP1ZAvFxUt7xuZjOjN5iv3eSAc/dp0/
	EUdjWC/LTcYpXEN94NY53Odawdrntv+VfplDsF1+gWJq2wIbwjZ+owlF+vgMfcIpJhlQUMgw0Qn
	g067TH9HK+5N1j34E7nmROdYgQuta8lYtAkP/JixU8ZCzY5BB+7+34YhiEvtVZdIUSfw3HSNI8a
	Rz72sPOE4a+brCaPw5GRWAYqaQ5oxLmpwbQspjYyovm9PVAF0qd7oV+BFzJLgXtJi2kTnPEHzRt
	Y=
X-Google-Smtp-Source: AGHT+IFTeqRvQhew5yvRIAG7kbfHpTXQYnj/BR4sAq0GFVmLk3EPW0NwxDp3g8CG2OFD4blkQV8rnA==
X-Received: by 2002:a05:6000:2401:b0:3d9:7021:fff0 with SMTP id ffacd0b85a97d-4255780b3f7mr2354425f8f.37.1759319993293;
        Wed, 01 Oct 2025 04:59:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d53b:59af:db6b:d4f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a16e13sm37505535e9.15.2025.10.01.04.59.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:59:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH 1/3] config.py: ubuntu24010 was replaced with ubuntu2504
Date: Wed,  1 Oct 2025 12:59:49 +0100
Message-ID: <20251001115951.253600-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 12:00:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2264

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/config.py b/config.py
index 16a25cfb..5f4a7f6d 100644
--- a/config.py
+++ b/config.py
@@ -162,7 +162,7 @@ publish_dest = "/srv/autobuilder/autobuilder.yocto.io/pub"
 web_port = 8010
 
 # List of workers in the cluster
-workers_ubuntu = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"]
+workers_ubuntu = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
 workers_centos = ["alma8-vk-1", "alma8-vk-2", "rocky8-vk-1", "alma9-vk-1", "alma9-vk-2", "stream9-vk-1", "rocky9-vk-1", "rocky9-vk-2", "rocky9-vk-3"]
 workers_fedora = ["fedora39-vk-1", "fedora39-vk-2", "fedora40-vk-1", "fedora40-vk-2", "fedora40-vk-3", "fedora40-vk-4", "fedora41-vk-1"]
 workers_debian = ["debian11-vk-1", "debian11-vk-2", "debian11-vk-3", "debian12-vk-1", "debian12-vk-2", "debian12-vk-3", "debian12-vk-4", "debian12-vk-5", "debian12-vk-6", "debian12-vk-7", "debian12-vk-8", "debian12-vk-9"]
@@ -172,13 +172,13 @@ workers = workers_ubuntu + workers_centos + workers_fedora + workers_debian + wo
 
 workers_bringup = []
 # workers with wine on them for meta-mingw
-workers_wine = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"]
-workers_arm = ["ubuntu2004-vk-arm1", "ubuntu2004-vk-arm2", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2410-vk-arm1"]
+workers_wine = ["ubuntu2004-vk-1", "ubuntu2004-vk-2", "ubuntu2004-vk-3", "ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
+workers_arm = ["ubuntu2004-vk-arm1", "ubuntu2004-vk-arm2", "ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"]
 workers_buildperf = ["perf-debian12-vk", "perf-alma8-vk"]
 # workers which don't need buildtools for AUH and are able to send email to mailing lists
 workers_auh = ["alma8-vk-2"]
 #workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2"]
-workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"]
+workers_toaster = ["ubuntu2204-vk-1", "ubuntu2204-vk-2", "ubuntu2204-vk-3", "ubuntu2204-vk-4", "ubuntu2404-vk-1", "ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"]
 
 all_workers = workers + workers_bringup + workers_buildperf + workers_arm
 
@@ -212,7 +212,7 @@ builder_to_workers = {
     "oe-selftest-ubuntu": workers_ubuntu,
     "oe-selftest-opensuse": workers_opensuse,
     "oe-selftest-centos": workers_centos,
-    "oe-selftest-armhost": ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2410-vk-arm1"],
+    "oe-selftest-armhost": ["ubuntu2204-vk-arm1", "ubuntu2204-vk-arm2", "ubuntu2404-vk-arm1", "ubuntu2404-vk-arm2", "ubuntu2504-vk-arm1"],
     "meta-mingw": workers_wine,
     "buildperf-debian11": ["perf-debian12-vk"],
     "buildperf-alma8": ["perf-alma8-vk"],
@@ -226,7 +226,7 @@ builder_to_workers = {
     "auh-meta-oe" : workers_auh,
     "metrics": workers_centos + workers_debian + workers_opensuse,
      # Have gitstats and gnuplot
-    "metrics-gitstats": ["ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2410-vk-1"],
+    "metrics-gitstats": ["ubuntu2404-vk-2", "ubuntu2404-vk-3", "ubuntu2504-vk-1"],
     "toaster": workers_toaster,
     "default": workers
 }

