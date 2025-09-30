Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E90CAC5B8
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 03:49:47 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.17188.1759204186447645113
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 20:49:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=Fo/n8un8;
 spf=pass (domain: mvista.com, ip: 209.85.214.171, mailfrom: vanusuri@mvista.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d69771e3eso45270075ad.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1759204185; x=1759808985; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rt09C+88Tt18JP+XBL/MAgzvrwL6r15iZhAfDZ33tGs=;
        b=Fo/n8un81lr/9JhltSuXojHmlz1Bazsoa5AND0MlUROhlrzyV4Rc7p+45FIIbH1afy
         j8vZ/GqUZHZlU1r6AfPLzFAqTylI7kGHkqpJzX0LA+kRLkcDpNJeO312qJAgFhcd7ibX
         hy3iFl8T/E+6CenOVOYJXef9m3M/DBTFhKPMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759204185; x=1759808985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rt09C+88Tt18JP+XBL/MAgzvrwL6r15iZhAfDZ33tGs=;
        b=gmPy2eZG8wj6NSswoEPazKy22Xpk//Xd9Hab0p0IUSEneimtx9p7JPiIyaoGL5VY/9
         PuZiLTAS+4eaSmlOeMBLDAmVy6acagsNIZsGYW39K04to2ITcjNPYx/FvZcMCTgwJBZI
         uJ0vjz/0Sk+RMkD5ibyrV5E0RJgUKZcRjke4DXGKAts9Vuw4lzwUqaDBU7hcAjrNiNOA
         LFex2JLlrHCT18Pg+O4ZwOz2QH3BKx3++of2rqWyfKys7q7qbEk1fwORuMffaRPaths+
         SKAeV66A2J/FhSL4/a9K/ybHwfqYIaumyTOYMDieofZ+UklCaGps/RGZvtKDXVxo55L8
         Aidw==
X-Gm-Message-State: AOJu0YxKHKt8jb3Jc6wFw6JQTqZV2tKJEzHtzrCh1m74/ED0+/WzxRgE
	CRn3i7w4T2nW8GN01cz68A69Z/wOMOC6EVc2lIIOl4XvsPdhVBBtV0LdaHbh8iAdugPJYgidlBR
	Q7Zpdh2o=
X-Gm-Gg: ASbGncsarmMgsSlPrlW/IPKwf/6tFYkYUyanRgr/4eSLFtBwhLhiqc7PtVvET8o/ZnR
	vofe7AZLZgSPnH07xYjUwJ0KzKiCrhkEsflnTDZgYyDI5FO/zmJNVTf417wGGSJskjJfgWWek23
	iIGPRIqgJaUOvDtg2XEQtng8SlapWRsbthfQYN1mslJd+94Xb/KcqGUgofVOnYQEsneJ2+qe8Um
	WmXYAF9SSUaQIvs5smbU35spcE3vD1cFKIT13DONzWqRorRA+FYGZLzGPkGI3Xolh9BqSoy4P/D
	dKH4ZMXf09dRJh8DRzMk6C+A6ASQIAY6N1qb3gWlgxvKxCNs9x2ZSN+0YG0sPIy1rshsaUztXQl
	9HEb3sse8WaHFEbYwhFtWKHTGjPsIxN7j6fSkrFNBF00QPY+2D7SfpyUVnlwaJQZGr9aIt9OlUg
	==
X-Google-Smtp-Source: AGHT+IHHOab9SHmTyFfNYLObixVRKuaVYQO2aoT9HByaf3glZBsd1a4cse1pS732bCrmr2JvYJ7T0A==
X-Received: by 2002:a17:903:1a0d:b0:27e:d7a4:cd32 with SMTP id d9443c01a7336-27ed7a4cda3mr199039215ad.57.1759204185339;
        Mon, 29 Sep 2025 20:49:45 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:62d2:5a18:f11e:c6a0:64bc:a06c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b59671ce93fsm7176996a12.3.2025.09.29.20.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 20:49:44 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH v2 1/3] recipes: Fix whitespace warnings
Date: Tue, 30 Sep 2025 09:19:33 +0530
Message-Id: <20250930034935.89622-1-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 03:49:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2257

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


