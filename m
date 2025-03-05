Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B91BC19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:12 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.10282.1741170310379690693
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Wp2XBQjR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so4259855e9.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170308; x=1741775108; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rqir7oypro0ZxON4qQ/HeQQkabZqapmVcR5zAD8kvuM=;
        b=Wp2XBQjRpO8v0b4g08S4hZUywpUusIpEEGeV12IRcjT3htZsafh3l2/YpvXBNKHFwn
         0perF3k33NLeMHDN0/EV+fSN3f50/A9YEPnxmJAeOyoK+w77YcpDKjQLeSrkWGWzKhOP
         H18vXSlhHjGEjCN7OJB+8jQQxtBHQA3CL/B+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170308; x=1741775108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqir7oypro0ZxON4qQ/HeQQkabZqapmVcR5zAD8kvuM=;
        b=A9vt8XyBuDsrYfHBHSXOhy4dHJOnq1LN6uhnZUNfQ93f+F6y6ovD1IQ6aroa3OIhqY
         Qs67fQvxXATbQzKw8N/2hIPVtjj5Yw7fjYU93c8PJS6oBFVMAelbYr9RcDNVqpilQGgn
         zQtlLOo5nP7ycwSOL7hlIvLjd+pamQXLAL7wok/A1WGRjgujLyv2CyFIDBFXyjghMeb0
         dUkwbmy368/TZNLzQzT1FXjaCzP+52lm4tp+iQw7ruaGjl407d1WSMlMlCcQLtQ/BrjG
         +gTvygJfaq4Y7rfBDGpdILYbh5PchkM3CLZJuJAoxzApCw+iNpNR2H6hTeCJy/apIyz3
         fTYQ==
X-Gm-Message-State: AOJu0YzVDBLVImqa9IhZ2YD7MMMVO6NFrrIwtFRxl/r8Yo9vd8H2SFU/
	YkHPGWAdAqry0e3DjArTf+ptL6Fa1j4Y6+RquObQ3T5/9N7fL+YgeAwHz1aYW1kqyAFRIEoXSwq
	2
X-Gm-Gg: ASbGnctGhpcQTLtNPCtB4SH+wdwbt66i2hWkuWtBA+6be1Guha56ogBnI/1ahay+CyU
	YOxneGZK8uTAZnBxixCTkyi1eKy3geNZ6hyDs4aXD/tTdPUaCzYFl7yLl08NXbLKF0ShRpdhDk7
	N4QcqFRcLbxWn3jqBzRqP9p4FyhvHrd892q+QNcUm0pB0f1TP2t9mepTgEaCenR0nouADrBcwUy
	Fhmi1eMV2Z+pibDT8dytlmSlMG9Y5od6TPYqxtq8P5+KuhTJJJwrECgNDuqRt4JviOEe0CCK47T
	6ir9wHUra2SlRsaJg9X13tOAngfD2VvGn9jaBdSmy3pR7/ki8iltKKFj3CAf0m8BoCFFhBH8gQ=
	=
X-Google-Smtp-Source: AGHT+IFqCcsIUwLecdT1qk/F7K9Rw76lwQ9SYzbekUdrwrjv8AcvGE3cLQc2VzwIovArZPe6yVUw1A==
X-Received: by 2002:a05:600c:19c7:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-43bd21021famr18778995e9.12.1741170308134;
        Wed, 05 Mar 2025 02:25:08 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 01/11] scripts/run-dashboard-index: Add basic index page for new dashboard site
Date: Wed,  5 Mar 2025 10:24:56 +0000
Message-ID: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1145

Add a basic index page for the dashboard site and tag onto the indexing job

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json                  |  4 ++++
 scripts/dashboard/index.html | 41 ++++++++++++++++++++++++++++++++++++
 scripts/run-dashboard-index  | 11 ++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 scripts/dashboard/index.html
 create mode 100755 scripts/run-dashboard-index

diff --git a/config.json b/config.json
index d24da94..c5d3913 100644
--- a/config.json
+++ b/config.json
@@ -1373,6 +1373,10 @@
             "step2" : {
                 "shortname" : "Extract ptest logs",
                 "EXTRACMDS" : ["${SCRIPTSDIR}/generate-ptest-logs.py ${BASE_SHAREDDIR}/pub/non-release/"]
+            },
+            "step3" : {
+                "shortname" : "Populate/update dashboard site",
+                "EXTRACMDS" : ["${SCRIPTSDIR}/run-dashboard-index ${BUILDDIR}/../"]
             }
         },
         "meta-mingw" : {
diff --git a/scripts/dashboard/index.html b/scripts/dashboard/index.html
new file mode 100644
index 0000000..972bbc9
--- /dev/null
+++ b/scripts/dashboard/index.html
@@ -0,0 +1,41 @@
+<!DOCTYPE html>
+<html>
+<head>
+<title>Yocto Project: Valkyrie Build Cluster</title>
+<style>
+html { color-scheme: light dark; }
+body { width: 35em; margin: 0 auto;
+font-family: Tahoma, Verdana, Arial, sans-serif; }
+</style>
+</head>
+<body>
+<h1>Yocto Project: Valkyrie Autobuilder</h1>
+<p>Please choose from the most frequently used links</p>
+
+<p>Cluster Buildbot Controller:
+<a href="https://valkyrie.yoctoproject.org/">valkyrie.yoctoproject.org</a>
+<br/>
+<br/>
+Unreleased Artefacts:
+<a href="https://valkyrie.yocto.io/pub/">valkyrie.yocto.io/pub</a>
+<br/>
+<br/>
+Build Performance and Autobuilder Test Result Index: 
+<a href="https://valkyrie.yocto.io/pub/non-release/">valkyrie.yocto.io/pub/non-release</a>
+<br/>
+<br/>
+OpenEmbedded-Core CVE Status and Patch Metrics:
+<a href="https://valkyrie.yocto.io/pub/non-release/patchmetrics/">valkyrie.yocto.io/pub/non-release/patchmetrics</a>
+<br/>
+<br/>
+Meta-OpenEmbedded CVE Status and Patch Metrics:
+<a href="https://valkyrie.yocto.io/pub/non-release/patchmetrics-meta-oe/">valkyrie.yocto.io/pub/non-release/patchmetrics-meta-oe</a>
+<br/>
+<br/>
+Auobuilder Intermittent Issue Summary:
+<a href="https://valkyrie.yocto.io/pub/non-release/abint/">
+    https://valkyrie.yocto.io/pub/non-release/abint/</a>
+</p>
+<p><em></em></p>
+</body>
+</html>
diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
new file mode 100755
index 0000000..6644ee7
--- /dev/null
+++ b/scripts/run-dashboard-index
@@ -0,0 +1,11 @@
+#!/bin/bash
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Called with $1 as the build directory
+
+builddir=$(realpath "$1")
+scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
+
+rsync -irlp --checksum --ignore-times $scriptdir/dashboard/index.html docs@docs.yoctoproject.org:dashboard/
+

