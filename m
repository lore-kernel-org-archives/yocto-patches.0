Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFFDCAC5B5
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 04:50:22 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.46694.1759121417916861092
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Sep 2025 21:50:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=DF/evUYM;
 spf=pass (domain: mvista.com, ip: 209.85.215.172, mailfrom: vanusuri@mvista.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so661099a12.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Sep 2025 21:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1759121416; x=1759726216; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rt09C+88Tt18JP+XBL/MAgzvrwL6r15iZhAfDZ33tGs=;
        b=DF/evUYMT5QBvBOZRASxkq8Uca+Wn3+XNCMZe25l5zQmJ5Xesu/X269fiqbbG3DMiU
         JiNQ94oGfdQVHAI9SkNfm5W2b2897wVMYACi74o2syY5NubHPwjZrEYlpIp8Yd3rT16k
         wL4ap+Uosls2zRyjhkkMqsK6d1dmUFnxn22MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759121417; x=1759726217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt09C+88Tt18JP+XBL/MAgzvrwL6r15iZhAfDZ33tGs=;
        b=ADPcjm7jedJ0GtSrcojn0JMEheNRnHlioLnKnclPAEuhwTuaWdWbgVJpKj7MIOFEnl
         5bYAO86w5lof/Rng7BLQPpzbcOf4iupFdBd2fns4PnrJ/UAussyYRu0LVJhq7miTuVmj
         wUN2/ZBAuFkpIHiH8J/Uat5ScZPiBtgkxOdvFfI+UCHMf1vnodSkDSjvjBeNs9ktTPai
         ZG7RZyRkHsAnj25TN5K5XJ5AQErEUXzKDbatuZxOXeSqnRz8T/brgvjrn5x1Io4hVFz6
         z5eCQNb9y9r91FypZ256kmDwaRk0vt1FK2LLFdBy5i8k/fOS75qW/0rzgoJugbcM8s8t
         o1ew==
X-Gm-Message-State: AOJu0YwJjDVgNpeY9fqUbY9S94SI+A+bEePfesnA18NRzNwHZ0O6sOJ+
	nl3hPZWJ867W1PYCZnkGwPlPqycO0MVIIMCvjDW5euSvkfL6i16UZdSSl6kwZGIh/3KItDlUn42
	fCbQQ/vc=
X-Gm-Gg: ASbGnctQagX6F1afsZ/woLuSSN5ALM0g7hpZsRYsaeq+G4tANcI+Ql/T/eXbJixQTxr
	eCHGKUgZYPzyvFDSxazw78mNUWTfbxiLGpN7ajlcyOX23V5rlzsAOndeRsIZ84tAzUh2HCPPVg/
	0MmsdC//keCYoW/kiU791NzMJhCVETS9CdTDj9ArrT0sKyq8o7ebaaqEJ5UOwMLGhRh6Uby5Uy3
	pGYK4G3XotnvBYlGBeZiNxE+4AJWTKF7dTVYogiuzgLLv4DUkzWQdHqE18CfO8CwLvF2kc4xXrN
	LMDGmaMRGhsYjkg8jNPcQG7tCAIDDSRCGO8msDIOLLfZMRV5X8XYfv2A+GoZvmwYVqZmnBn3YEc
	TtpLY34UM+LlmJcG3EXdqj+4k+t4DNCSkVMa+KRVxtj9r4MHz
X-Google-Smtp-Source: AGHT+IE4fHweyjRmvXKrLOJkscIFwMX4aLFBHmS+hVkPahy0hk2PE6KU3pCh2lcoXE0vEJ3ZnS/rlg==
X-Received: by 2002:a17:903:3884:b0:282:ee0e:5991 with SMTP id d9443c01a7336-282ee1da05amr53416855ad.30.1759121416643;
        Sun, 28 Sep 2025 21:50:16 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8fcc:87df:9a55:2ec0:d047:5e02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69a9668sm114277635ad.112.2025.09.28.21.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 21:50:16 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH 1/3] recipes: Fix whitespace warnings
Date: Mon, 29 Sep 2025 10:20:05 +0530
Message-Id: <20250929045007.12623-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 04:50:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2246

From: Vijay Anusuri <vanusuri@mvista.com>

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb           | 4 ++--
 meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb      | 2 +-
 meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb      | 4 ++--
 meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb b/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
index 0184e7d..6ca7556 100644
--- a/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
+++ b/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
@@ -43,8 +43,8 @@ EXTRA_OECONF = "--with-daemon-user=${HA_USER} \
                 --with-ocf-root=${libdir}/ocf \
                "
 
-CACHED_CONFIGUREVARS="ac_cv_path_XML2CONFIG=0 \
-                      ac_cv_path_SSH=ssh \
+CACHED_CONFIGUREVARS = "ac_cv_path_XML2CONFIG=0 \
+                        ac_cv_path_SSH=ssh \
 "
 
 USERADD_PACKAGES = "${PN}"
diff --git a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
index 04bb62f..ff90030 100644
--- a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
+++ b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
@@ -21,7 +21,7 @@ SRC_URI = "git://github.com/ClusterLabs/${BPN}.git;branch=main;protocol=https \
           "
 
 CFLAGS += "-I${STAGING_INCDIR}/heartbeat"
-CPPFLAGS +="-I${STAGING_INCDIR}/heartbeat"
+CPPFLAGS += "-I${STAGING_INCDIR}/heartbeat"
 SRC_URI:append:libc-musl = "file://0001-pacemaker-fix-compile-error-of-musl-libc.patch"
 
 SRCREV = "ba59be71228fed04f78ab374dfac748d314d0e89"
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
index 0a04bf5..211b911 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
@@ -32,7 +32,7 @@ SRC_URI = "git://github.com/zoulasc/racoon2;branch=master;protocol=https \
            file://spmd.service \
           "
 
-SRCREV="7b68950328454b0e91ba24698c10c4a790705cc1"
+SRCREV = "7b68950328454b0e91ba24698c10c4a790705cc1"
 SRC_URI[md5sum] = "2fa33abff1ccd6fc22876a23db77aaa8"
 SRC_URI[sha256sum] = "f23773e4d97cec823ec634085b5e60a7884a13467ff1bffc17daac14d02f9caa"
 
@@ -84,7 +84,7 @@ INITSCRIPT_PARAMS:${PN} = "remove"
 INITSCRIPT_NAME:${PN}-iked = "iked"
 INITSCRIPT_PARAMS:${PN}-iked = "remove"
 INITSCRIPT_NAME:${PN}-kinkd = "kinkd"
-INITSCRIPT_PARAMS:${PN}-kinkd= "remove"
+INITSCRIPT_PARAMS:${PN}-kinkd = "remove"
 
 SYSTEMD_PACKAGES = "${PN}"
 SYSTEMD_SERVICE:${PN} = "spmd.service iked.service"
diff --git a/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb b/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
index f72dbd3..04bd8b9 100644
--- a/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
+++ b/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
@@ -11,7 +11,7 @@ RDEPENDS:${PN} += " perl-module-test-more \
                     "
 PR = "r2"
 
-SRC_URI ="http://search.cpan.org/CPAN/authors/id/E/ET/ETHER/Test-Pod-${PV}.tar.gz;name=test-pod-perl-${PV}"
+SRC_URI = "http://search.cpan.org/CPAN/authors/id/E/ET/ETHER/Test-Pod-${PV}.tar.gz;name=test-pod-perl-${PV}"
 SRC_URI[test-pod-perl-1.52.md5sum] = "472dda77746d48e6465bf62e47aeca81"
 SRC_URI[test-pod-perl-1.52.sha256sum] = "60a8dbcc60168bf1daa5cc2350236df9343e9878f4ab9830970a5dde6fe8e5fc"
 S = "${UNPACKDIR}/Test-Pod-${PV}"
-- 
2.25.1


