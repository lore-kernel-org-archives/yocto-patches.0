Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D5CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 22:03:33 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22526.1792361008109185806
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 18 Oct 2026 15:03:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=KqAGieK0;
 spf=pass (domain: gmail.com, ip: 209.85.215.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so948435a12.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361007; x=1792965807; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N/Wd0sUtZ5vEXmAs4eUsVbsURaOfVuqz8kl2+U/SYI0=;
        b=KqAGieK0Tzc7FnieJlYCLs4l7STlFUgt9mEm3ao1d1koDykrLOwCdvqFzbWt9BBoA3
         U0yt05NzJxyLekEAnGhhBLKx/kYjQ7Dco8Rjf9D4DhCa6HUMBuxAAt/uFyxGI9hkfeqU
         CIb6dXZPTVh0GgOVgQEXaGh/3u0L0uKQdLVbO3QLsxzVzVNAoWwxQhOPLErOFb8QLlPs
         XfLLGPhswGjp+YyYKUgudXOgMACc16OhzUaOxSkuV8hVW1myOV9M0M2FGCymXgLY0XR9
         0OFe50E5FZEm37TQdzldwLWAnw+a5y/U41VF5uhzXCIR2dJx60oUAT0MgBArwLSPwqVA
         iivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361007; x=1792965807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N/Wd0sUtZ5vEXmAs4eUsVbsURaOfVuqz8kl2+U/SYI0=;
        b=ynVCtMhFBDdvDUyEA6eDaIx2Ajtv0YPFYweFDHnRxW6b1CroalMaxP7qyATcq2/Fr6
         Polz/kP5yTEo4rON82QeN70+TJj8dbaq/KHeLS7MGAP8lKjA8A/gW42uUGS7aa2cJiB3
         6bcJpG+Q9fLPeGCLNhMRQ24L45jHeOnGKThYbO0RKpkEdeAY9zKvg2UWp7votgWN1oKq
         XjoAJmm/gzp32HEKlE/305whP3817jNXGjUNjtvfrxGV3GrBHS9keB/h9e+dJEXoRflk
         Wn2nunLwb0UCg9OaYwuzOU60V6RnKEXsM+P3T4eIyBgidGShAxANlQZoGzH6nxvGVwgp
         +mhA==
X-Gm-Message-State: AFq9FYK8GgI3IX7+nyBCXHvc1Ef3+GfshNMWFFRHEvlW4lushtQ/oVOK
	K9POmEhZClMPJskZODiU7VB88YgTtJmIm+Ye+mNg9eX8i7m54ok/nImx/nPFBw==
X-Gm-Gg: AYBFou07NO0M8K5mxG/7yltWvIDkyqFfCVgQePUAQRO+Bf8KqGqFJVcNdgX+5zDMmmz
	OraP4YTIbNEYi/7j8zEcZtdr9pJoIXg7ty0lA6Nsbo4JgiaOxJXJPEhdEEsxFQXkFTudu12c/KB
	pdVum/9A6HFtOLrBcYjwegNO4rQ8LVsW6SNmML7xpJV2sW2zm282LpwWShf3PN/FGKhMGUh+h37
	KKvr+RESCw/PzzdgokCS5jw1rhjZ+e+Is5sLHqVg19q0DYCO8LbIPPrI1gFwxPhlSmzkU56Wrq1
	AcCNbBMfABndmY2aNOx4560l/e4gnpNaX6yZJpSFDsPwCS5LDBORp210U9SZqb/g8nn75QonGAS
	8W4JGrLMiLSUR46DE1KPjGJ7IbOIBPOX/yIwY93zzjveXl1rGvWa2IVTPWcSGHKbPkFcDxkwSfR
	ObI4Rpuwr4vnyFczQvJF7WsBnV+Ef9V+SC04HLfYRLx7EgHCTzRrWsHDaZPD2PZc110GBvE1RiN
	egxu4qHoN/e3imPCE4sRss6p1vuOgw=
X-Received: by 2002:a17:90b:1dc4:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3aceec67eb5mr4792777a91.36.1792361007365;
        Sun, 18 Oct 2026 15:03:27 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm17714440a91.5.2026.10.18.15.03.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 15:03:26 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH 06/10] Update references to the renamed README files
Date: Sun, 18 Oct 2026 15:03:04 -0700
Message-ID: <20261018220308.72731-7-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018220308.72731-1-tim.orling@konsulko.com>
References: <20261018220308.72731-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 22:03:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5088

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 COPYING.MIT     | 2 +-
 Dockerfile      | 2 +-
 README.devel.md | 2 +-
 README.md       | 4 ++--
 README.rrs.md   | 4 ++--
 SECURITY.md     | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/COPYING.MIT b/COPYING.MIT
index 3de397c..ea19713 100644
--- a/COPYING.MIT
+++ b/COPYING.MIT
@@ -1,5 +1,5 @@
 Note: for details on which portions of this application are covered by this
-license, please see the README file. Other included components have LICENSE
+license, please see the README.md file. Other included components have LICENSE
 notices within (or in files adjacent to) the distributed files.
 
 Portions copyright (C) 2013-2019 Intel Corporation.
diff --git a/Dockerfile b/Dockerfile
index 8e6e508..4ba040e 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,4 +1,4 @@
-# See README for how to use this.
+# See README.md for how to use this.
 
 FROM ubuntu:jammy
 LABEL maintainer="Michael Halstead <mhalstead@linuxfoundation.org>"
diff --git a/README.devel.md b/README.devel.md
index 31460ef..ae41c8c 100644
--- a/README.devel.md
+++ b/README.devel.md
@@ -3,7 +3,7 @@ Standalone Setup
 
 NOTE: The standalone setup is most suitable for development and is not
 recommended for production; for production use the Docker-based setup
-covered in the main README.
+covered in the main README.md.
 
 In order to run this application standalone, you will need:
 
diff --git a/README.md b/README.md
index 49ce4d3..32572c5 100644
--- a/README.md
+++ b/README.md
@@ -9,7 +9,7 @@ There are two main methods of setting up this application - within
 a set of Docker containers, or standalone. The Docker-based setup
 is more suited for production whereas standalone is a bit easier
 for development. This document will consider only the Docker-based
-setup; for standalone please see README.devel.
+setup; for standalone please see README.devel.md.
 
 
 Docker Setup
@@ -102,7 +102,7 @@ Other settings the app and celery files can set:
 
   - DEBUG: 1, true or yes enables Django's debug mode; anything else, or
     leaving it unset, keeps it off. Never enable it on a public site.
-  - ENABLE_RRS: 1 enables the Recipe Reporting System (see README.rrs).
+  - ENABLE_RRS: 1 enables the Recipe Reporting System (see README.rrs.md).
   - DATABASE_PORT (default 3306) and STATIC_ROOT (default
     /usr/share/nginx/html/static/).
 
diff --git a/README.rrs.md b/README.rrs.md
index a311adf..b6e3724 100644
--- a/README.rrs.md
+++ b/README.rrs.md
@@ -15,7 +15,7 @@ This requirement may be removed in future.
 
 Setup procedure:
 
-1. Follow the layer index setup instructions in the README file first.
+1. Follow the layer index setup instructions in the README.md file first.
    The openembedded-core layer (or whatever replacement you have pointed
    CORE_LAYER_NAME to in settings.py) must be present in order to run the
    Recipe Reporting System database migrations.
@@ -24,7 +24,7 @@ Setup procedure:
 
    * Add 'rrs' to INSTALLED_APPS. In the Docker-based setup, set
      ENABLE_RRS=1 in the app and celery environment files instead (see
-     "Environment files" in README)
+     "Environment files" in README.md)
 
    * Configure TOOLS_LOG_DIR if you wish the logs to be written somewhere
      other than the current directory when the scripts are run
diff --git a/SECURITY.md b/SECURITY.md
index 20a28a9..7d2ce1f 100644
--- a/SECURITY.md
+++ b/SECURITY.md
@@ -5,7 +5,7 @@ If you would like to report a public issue (for example, one with a released
 CVE number), please report it using the
 [https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Security Security Bugzilla].
 If you have a patch ready, submit it following the same procedure as any other
-patch as described in README.
+patch as described in README.md.
 
 If you are dealing with a not-yet released or urgent issue, please send a
 message to security AT yoctoproject DOT org, including as many details as
-- 
2.56.0


