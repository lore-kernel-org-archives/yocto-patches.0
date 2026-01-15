Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CC5D3CCB0
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 22:46:58 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.690.1768517214824433613
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 14:46:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=f378gLUJ;
 spf=pass (domain: konsulko.com, ip: 209.85.222.180, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c5265d06c3so241969585a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 14:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768517214; x=1769122014; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNcd9iwZoMzCWgHxeBAhfjAdyaFoSNZ7KeL31k5lk/k=;
        b=f378gLUJ5bkV6F/SGnqMajXQJ/djr3+f8pJh+FOFsXrT5W+r6NAu93h7yXnkbKXgRZ
         orK8bYKYGf1GCVgxzmb60ZPzE8INogbhWqc0bZ4bv7reh2t4BoWuuo//wl9aVnxaBTdO
         7GR2a4/SSWOVvvlBac3uerENT+qJZ2WLcCTo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768517214; x=1769122014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HNcd9iwZoMzCWgHxeBAhfjAdyaFoSNZ7KeL31k5lk/k=;
        b=NuG6DbF5Qrb/gldRCxnCJy5B7ZSZ2KuvPHNo+rR9umdyBATV47YHESrnQbRrTWODTD
         Dh0RcaJwaOKG1qdYmbTkpVwiNJw4PL4cpkjRIiYfg1Bwn3VOBxKWWsliARoj2qI1e5Hz
         JUREkXtpopYogNynbsGXRxVAc7tYIqxmFNM45WjzEztGWj/u6uBamsvbiUMhMahDjuxy
         Nrrq4+N636VI+6KU7lUZ3oB0bpgb1dl/Jt/WXf1MJNE8k1fnCo8cV2BTI3L2gBo311DQ
         /oS3uyM/ZEKVcJ82Xaj62dPzg6TLqtJZ5w4N1FAEMRoidfXTfS2Ce5NwM9RJdqxe2hhB
         r61g==
X-Gm-Message-State: AOJu0YwkezJiq/1odRxSHul3ZSCmW+NOyA3epplS9Wi2a42Zb7PknvNe
	W6cV8L3OmFiktdju5T8W4/+lIE/eRdL98MHd9pSdcTJqRS1MgR/OGSk15Pt7skrLT/DqtTjxgJM
	SpWVu
X-Gm-Gg: AY/fxX6q2ZMHxxQ1SbersO9rp46KNQcvVoK9qLLlt7Zq7emV4UFtAgX9SCwzhn4d4QA
	xtdM83nmd2cYhz+/R8XIH0H1LFG6NYmEi6/oiE6lzWNN7j2yGYD3L7f83rBa1BmYVjgdOGu1yM0
	GEwzdB4s9H2lIg1uXh0pbDOTCtsa98xxb0mIvoe1wQ++mVQGH9BfDL/fXto8Z0JYRbtmvNHnjMm
	mkB3g+2AeCx+/THoe81kxbocdSsqeEw8AdNpblIcB94u6vhZQSfOPVy2X3ZqqOIUTMRYQDAn7r6
	xqbI9pFyN5I7aM4qwRQ3mrwg0LSt1cZrCPDFVS6zPKnyn1F/MgUQZez+ga6PqkJ+lntWKkTHiuq
	lgZkVuhhF5QqmXnTxGJoxlDYUCSZCcufSVz800hcoYSECVaPzrZj+rAljuwzgf/uNJ4i6ni9M+a
	E74foot6dlVzytHRx7QbwjU6PMs1uo7QkSTHGdq0wZoQ5JgMvlR63D3rO3kRs9vjXpF8KvN6esl
	fM3VWx3DDGdYl2VxwRMH+lk/VlSgnJ68BI06MHPolYkBeYts3bZ
X-Received: by 2002:a05:6214:401a:b0:890:7f85:81d1 with SMTP id 6a1803df08f44-89389fa20f5mr71472296d6.13.1768517213636;
        Thu, 15 Jan 2026 14:46:53 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm7921436d6.21.2026.01.15.14.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:46:53 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][kirkstone][PATCH 3/9] kas: update configuration
Date: Thu, 15 Jan 2026 17:46:24 -0500
Message-ID: <85c681c0d4163dacdad219e1e17b995b33cbdd51.1768515491.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1768515491.git.scott.murray@konsulko.com>
References: <cover.1768515491.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 15 Jan 2026 22:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2968

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Update based on latest master configuration.

Changes:
- switch to kirkstone
- add required usrmerge feature to kas-security-alt configuration
- add whitespaces around assignement
- add common dldir/sstate
- don't build apparmor in musl configs
- only enable ptest for the test image
- Update the kas configuration file versions to 19 to match kas 4.8.x.
- Change refspec to branch to remove deprecation warnings.
- Add quoting around URLs to match upstream examples.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 kas/kas-security-alt.yml    |  4 ++--
 kas/kas-security-base.yml   | 21 +++++++++++++--------
 kas/kas-security-dm.yml     |  2 +-
 kas/kas-security-parsec.yml |  4 ++--
 kas/qemuarm64-musl.yml      |  1 +
 kas/qemux86-musl.yml        |  1 +
 kas/qemux86-test.yml        |  4 ++++
 7 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/kas/kas-security-alt.yml b/kas/kas-security-alt.yml
index 3ee9808..2a449c5 100644
--- a/kas/kas-security-alt.yml
+++ b/kas/kas-security-alt.yml
@@ -1,8 +1,8 @@
 header:
-    version: 9
+    version: 19
     includes: 
         - kas-security-base.yml
 
 local_conf_header:
   alt: |
-      DISTRO_FEATURES:append = " systemd"
+      INIT_MANAGER = "systemd"
diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index 3bf46db..78c0b04 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -1,5 +1,5 @@
 header:
-  version: 9
+  version: 19
 
 distro: poky
 
@@ -13,16 +13,16 @@ repos:
       meta-hardening:
 
   poky:
-    url: https://git.yoctoproject.org/git/poky
-    refspec: master
+    url: "https://git.yoctoproject.org/git/poky"
+    branch: kirkstone
     layers:
       meta:
       meta-poky:
       meta-yocto-bsp:
-
+ 
   meta-openembedded:
-    url: http://git.openembedded.org/meta-openembedded
-    refspec: master
+    url: "http://git.openembedded.org/meta-openembedded"
+    branch: kirkstone
     layers:
       meta-oe:
       meta-perl:
@@ -41,8 +41,8 @@ local_conf_header:
     INHERIT += "report-error"
     INHERIT += "testimage"
     INHERIT += "rm_work"
-    BB_NUMBER_THREADS="24"
-    BB_NUMBER_PARSE_THREADS="12"
+    BB_NUMBER_THREADS = "24"
+    BB_NUMBER_PARSE_THREADS = "12"
     BB_TASK_NICE_LEVEL = '5'
     BB_TASK_NICE_LEVEL_task-testimage = '0'
     BB_TASK_IONICE_LEVEL = '2.7'
@@ -52,6 +52,7 @@ local_conf_header:
     PACKAGE_CLASSES = "package_ipk"
 
     DISTRO_FEATURES:append = " security pam apparmor smack ima tpm tpm2"
+    DISTRO_FEATURES:remove = "ptest"
     MACHINE_FEATURES:append = " tpm tpm2"
 
   diskmon: |
@@ -65,6 +66,10 @@ local_conf_header:
     ABORT,${SSTATE_DIR},100M,1K \
     ABORT,/tmp,10M,1K"
 
+  dlsstate: |
+    DL_DIR = "/home/gitlab-runner/build/downloads"
+    SSTATE_DIR = "/home/gitlab-runner/build/sstate-cache"
+
 bblayers_conf_header:
   base: |
     BBPATH = "${TOPDIR}"
diff --git a/kas/kas-security-dm.yml b/kas/kas-security-dm.yml
index c03b336..fe74d25 100644
--- a/kas/kas-security-dm.yml
+++ b/kas/kas-security-dm.yml
@@ -1,5 +1,5 @@
 header:
-    version: 9
+    version: 19
     includes: 
         - kas-security-base.yml
 
diff --git a/kas/kas-security-parsec.yml b/kas/kas-security-parsec.yml
index 9a009be..cb59fba 100644
--- a/kas/kas-security-parsec.yml
+++ b/kas/kas-security-parsec.yml
@@ -1,5 +1,5 @@
 header:
-    version: 9
+    version: 19
     includes:
         - kas-security-base.yml
 
@@ -10,7 +10,7 @@ repos:
 
   meta-clang:
     url: https://github.com/kraj/meta-clang.git
-    refspec: master
+    branch: kirkstone
 
 local_conf_header:
   meta-parsec: |
diff --git a/kas/qemuarm64-musl.yml b/kas/qemuarm64-musl.yml
index b353eb4..f01f759 100644
--- a/kas/qemuarm64-musl.yml
+++ b/kas/qemuarm64-musl.yml
@@ -6,5 +6,6 @@ header:
 local_conf_header:
     musl: |
         TCLIBC = "musl"
+        DISTRO_FEATURES:remove = "apparmor"
 
 machine: qemuarm64
diff --git a/kas/qemux86-musl.yml b/kas/qemux86-musl.yml
index 61d9572..aa6572c 100644
--- a/kas/qemux86-musl.yml
+++ b/kas/qemux86-musl.yml
@@ -6,5 +6,6 @@ header:
 local_conf_header:
     musl: |
         TCLIBC = "musl"
+        DISTRO_FEATURES:remove = "apparmor"
 
 machine: qemux86
diff --git a/kas/qemux86-test.yml b/kas/qemux86-test.yml
index 83a5353..98f1e7f 100644
--- a/kas/qemux86-test.yml
+++ b/kas/qemux86-test.yml
@@ -3,4 +3,8 @@ header:
   includes:
     - kas-security-base.yml
 
+local_conf_header:
+  ptest: |
+      DISTRO_FEATURES:append = " ptest"
+
 machine: qemux86
-- 
2.51.0


