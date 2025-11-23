Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B2CFD313
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:23 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4856.1763941520518892193
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=e8yaIRPD;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b220ddc189so448802485a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941519; x=1764546319; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jng7qDD82KyMPs+W1S8oGQxE+ROJY7qz8hKhVkA1+FE=;
        b=e8yaIRPDf1Yb6mLti/VnViuiLVN1q0Ibj+2sW6Mj3c/N3J8NbhMeMBPBTa9J8PSEhY
         2MuXCBTxbdj6pm8PqkoJ1sqZ/2b39vepNAODs3sjHbSsrCW2KlSV7N5mEiYTT2/HJN6M
         +zCmL8WSwd33M70WH+AFhhlGIsjtVigCnUy/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941519; x=1764546319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jng7qDD82KyMPs+W1S8oGQxE+ROJY7qz8hKhVkA1+FE=;
        b=RcU8BKWqIVlYoA4+vdODh09v6aC/R26/ZdUy1lThUfhegz9l8OkqQkyaCOkcE7uO9u
         tUQMd8+NF2Ui02VIFeg3XDfywh2X+5WqjHZfFpZIcPpE3JEvLGhiw8vVD55Opj0Tr8G6
         jjYIGSUITJbTIRkjTzQyFcQQYcGpUOmodO2DUszMjlQqde/wF3e1o2xh8uf1R11KX3uh
         ryKF0C6aOdt+94vaO+/LGsFaa5NypOMA+BefuxjTVYiqYGPTApBnzr9eIssN2zH9K6N5
         isxf7Ob76wagC2rRX/w2LmDz5fhpaZ41hHD4JoeU3K/f80bpXEJ4ntbAD3XGumQ8jN2t
         FeOA==
X-Gm-Message-State: AOJu0Yw6FPDjj4eSDht4xhydnPjG5bZtYYZmuY1YVVGULMb1dHE5FZo6
	FBZVzBZvUqtX4/kKFYZHDQmK6bsnTfg1p/POI0QqZ0JIHtZLvjfhX0EcG7syjMKwhPgHSpdevoW
	mFEJv
X-Gm-Gg: ASbGnctkDmD1hxqUcjZPdETzb/saSBfHzykzv7hSg0MFQTmTdXjqJ7Ix55GDaN/86r2
	Vh1wvBBPBp2QKmpmHN9v1byIAzASmtvBeAybqzpIc/h7uzlidi8/dU1txS1q06xsUSJ1l/+BUNS
	+1bBQ7FOG8+E36E4/tKP3HmAXgt0QL908xdH9muPa6clWj6VYmWydM4F34kcHKWlNz69DBP2mNi
	XCU9nvuPkkMd6Vz1f6q3UrhRvDZ3Hf/LMdTEbR5/PIHUVE8rkJSwN5ni2QdCXe3YTcjC2/quJ9r
	Pf6wSULELmS5w0pwzGnIbjgthx2xIJOxrxzqefouKzT4pgld66txUvS+unMfff3lhttJ0lzuTjj
	CHx4UyGiX9P2rDWyVzsVEWzEv8lZhXhrLk/h7yqQgT2H5iRteackccxWo9yCfKKc3ErHbf8ZQOL
	sUoIK0BVWJjbzjTGs/axyLrC2DQWCskE92JFedCzD7DgdxLE26anYyZJuuM/fpkwU=
X-Google-Smtp-Source: AGHT+IFt8ldvUBPxAluGRQ5TL3MPf3ClTCRcXMZ9go9lfwmr/MVswyq0OrO2hF8CJ/TVdCoLNOxBtA==
X-Received: by 2002:a05:620a:4404:b0:8b1:7194:b926 with SMTP id af79cd13be357-8b33d477402mr1185533285a.55.1763941519065;
        Sun, 23 Nov 2025 15:45:19 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.18
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:18 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 03/32] kas: update configuration
Date: Sun, 23 Nov 2025 18:44:43 -0500
Message-ID: <da3b5d09cd542a84aff9838a4b33e4d8814226a8.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2661

From: Marta Rybczynska <marta.rybczynska@ygreky.com>

Changes:
- switch to scarthgap
- add required usrmerge feature to kas-security-alt configuration
- add whitespaces around assignement
- add common dldir/sstate
- don't build apparmor in musl configus
- only enable ptest for the test image

Signed-off-by: Marta Rybczynska <marta.rybczynska@ygreky.com>
(squashed and recent master changes backported)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 kas/kas-security-alt.yml    |  2 +-
 kas/kas-security-base.yml   | 13 +++++++++----
 kas/kas-security-parsec.yml |  2 +-
 kas/qemuarm64-musl.yml      |  1 +
 kas/qemux86-musl.yml        |  1 +
 kas/qemux86-test.yml        |  5 +++++
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/kas/kas-security-alt.yml b/kas/kas-security-alt.yml
index 3ee9808..8f754ac 100644
--- a/kas/kas-security-alt.yml
+++ b/kas/kas-security-alt.yml
@@ -5,4 +5,4 @@ header:
 
 local_conf_header:
   alt: |
-      DISTRO_FEATURES:append = " systemd"
+      INIT_MANAGER = "systemd"
diff --git a/kas/kas-security-base.yml b/kas/kas-security-base.yml
index fa7915c..ff66889 100644
--- a/kas/kas-security-base.yml
+++ b/kas/kas-security-base.yml
@@ -13,7 +13,7 @@ repos:
 
   poky:
     url: https://git.yoctoproject.org/git/poky
-    refspec: master
+    refspec: scarthgap
     layers:
       meta:
       meta-poky:
@@ -21,7 +21,7 @@ repos:
 
   meta-openembedded:
     url: http://git.openembedded.org/meta-openembedded
-    refspec: master
+    refspec: scarthgap
     layers:
       meta-oe:
       meta-perl:
@@ -36,8 +36,8 @@ local_conf_header:
     INHERIT += "buildstats buildstats-summary buildhistory"
     INHERIT += "report-error"
     IMAGE_CLASSES += "testimage"
-    BB_NUMBER_THREADS="24"
-    BB_NUMBER_PARSE_THREADS="12"
+    BB_NUMBER_THREADS = "24"
+    BB_NUMBER_PARSE_THREADS = "12"
     BB_TASK_NICE_LEVEL = '5'
     BB_TASK_NICE_LEVEL_task-testimage = '0'
     BB_TASK_IONICE_LEVEL = '2.7'
@@ -47,6 +47,7 @@ local_conf_header:
     PACKAGE_CLASSES = "package_ipk"
 
     DISTRO_FEATURES:append = " security pam apparmor smack ima tpm tpm2"
+    DISTRO_FEATURES:remove = "ptest"
     MACHINE_FEATURES:append = " tpm tpm2"
 
   diskmon: |
@@ -60,6 +61,10 @@ local_conf_header:
     HALT,${SSTATE_DIR},100M,1K \
     HALT,/tmp,10M,1K"
 
+  dlsstate: |
+    DL_DIR = "/home/gitlab-runner/build/downloads"
+    SSTATE_DIR = "/home/gitlab-runner/build/sstate-cache"
+
 bblayers_conf_header:
   base: |
     BBPATH = "${TOPDIR}"
diff --git a/kas/kas-security-parsec.yml b/kas/kas-security-parsec.yml
index 9a009be..cfaa660 100644
--- a/kas/kas-security-parsec.yml
+++ b/kas/kas-security-parsec.yml
@@ -10,7 +10,7 @@ repos:
 
   meta-clang:
     url: https://github.com/kraj/meta-clang.git
-    refspec: master
+    refspec: scarthgap
 
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
index 83a5353..c4609f9 100644
--- a/kas/qemux86-test.yml
+++ b/kas/qemux86-test.yml
@@ -3,4 +3,9 @@ header:
   includes:
     - kas-security-base.yml
 
+local_conf_header:
+  ptest: |
+      DISTRO_FEATURES:append = " ptest"
+      EXTRA_IMAGE_FEATURES:append = " allow-empty-password allow-root-login empty-root-password"
+
 machine: qemux86
-- 
2.47.3


