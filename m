Return-Path: <vanusuri@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D68CA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 13:01:20 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.38608.1756990875813939901
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 06:01:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=BFwedYjq;
 spf=pass (domain: mvista.com, ip: 209.85.210.172, mailfrom: vanusuri@mvista.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7724df82cabso1257867b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1756990875; x=1757595675; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOFqw91QsjOmjhlq6oaFlCZ7TUagEHrBzeGYktawLOY=;
        b=BFwedYjqR7dZGlvqUH20G5iPxqyzAlXjkCaNOu3tv1LjGB9MoHLVX6ZCHDTXixm3xa
         XLXJXPco6JyvEDyxbGUD7d+VPoU3Um1ezLTKJFxoxjcE3i/0zP3E/rwM3ZvsrMO/gag8
         v5kCY8yq7kRFtnrFJc1PVMRvf8GmHLTl5UHG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756990875; x=1757595675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOFqw91QsjOmjhlq6oaFlCZ7TUagEHrBzeGYktawLOY=;
        b=apxAZyRNRAiC/3Xj054BqWUIC/0R7wJZbymEzQFwk7Y/N+V8p5XNTdkQ4bOdZqyWw6
         LxAOUkWChJbKd14svv5m0D3HKjCRJI6sch4TZTTTbCxddc0rgqUa3nX8jbPDKt/SdN/2
         rOs259+5z+CKbMLFOL2lzLqXIsWSyrdvf/1qP8pAEIxZogfnQFhJuaBSmpwgAyvUXnom
         pF8bBGZKcDT8bGNcTOJ9zubRw9ddDvtjtinnu3ZZCuAb0Jns5Xb9WTH3IfM+jOpWLutg
         To0woMB4wGBMUJufnljLOQes7nlwrUQ+WhYUERQNS6BfkqPwcVqBSCz83bMnjGtXuoHe
         jWnA==
X-Gm-Message-State: AOJu0YwUBv8gUS6f7HVksQJXX9G3qZT2hZfRVq24p5khG8i3WVFjHEc0
	G/OIGDLuW0yHw8uwdjDel5a6+OQ1gHFR3kWvc0WN8dzrvKKSKCLu0wkMbT6u7P1bm41RYGCMWrk
	W/D/kwGc=
X-Gm-Gg: ASbGncsavIYaPF7Wj0o/9+/Gn7mCU3BcDMxx9YqC5Hlo80KNu/WnZEUPviLLX/b+CeU
	m5cSIZletzUMqfWkZYiqTwAcjYSj1SLxsj0QLl74VzBIVxvpBwUfkYf0YIu+8ADvDHAPktxL9Ru
	o7gpwOcTk6d8ReIFuWSBQuzrOSoU3u5z68Hsg7efyRiMjVqJvS3xHF40P36jA69jVQhGFikoBT8
	Ct3DVW2RgI+PEKHws+dt59UNMe4/O1WYu2hCi3Xmj4ErR6xFh6Gc+0Z7EG2o5LGpkO6jyd+oMYL
	4vv//YFgk01LBge8cxJfQy1AmhC5sITExMielmKEcxhurX9fDRIJaVYv9mY1QH2gMnSo6KskIBd
	o8RUuGJD85IOzpyEGK6S3d6vVf1s5WuQkFg==
X-Google-Smtp-Source: AGHT+IGdjLQK2oXyReGqlLWitbGfVKeT4lF4PhJxl5jg1Y6oE9AatQY0JprQSIwR/u9cvteRr3w3tw==
X-Received: by 2002:a17:903:2450:b0:24c:7862:41e2 with SMTP id d9443c01a7336-24c7862441bmr125216595ad.31.1756990873056;
        Thu, 04 Sep 2025 06:01:13 -0700 (PDT)
Received: from MVIN00020.mvista.com ([49.207.215.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ce9dd9373sm355285ad.85.2025.09.04.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:01:12 -0700 (PDT)
From: vanusuri@mvista.com
To: yocto-patches@lists.yoctoproject.org
Cc: Vijay Anusuri <vanusuri@mvista.com>
Subject: [yocto-patches][meta-cgl][PATCH 2/2] recipes: WORKDIR -> UNPACKDIR transition
Date: Thu,  4 Sep 2025 18:30:52 +0530
Message-Id: <20250904130052.32436-2-vanusuri@mvista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250904130052.32436-1-vanusuri@mvista.com>
References: <20250904130052.32436-1-vanusuri@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 13:01:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2125

From: Vijay Anusuri <vanusuri@mvista.com>

Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
---
 .../recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb          | 5 ++---
 .../cluster-resource-agents/resource-agents_4.5.0.bb         | 2 --
 meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb             | 1 -
 meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb     | 2 +-
 meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb | 2 --
 meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb     | 4 +---
 meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb     | 5 ++---
 meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb  | 2 +-
 meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb    | 2 +-
 meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb   | 4 ++--
 meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb        | 2 +-
 11 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb b/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
index aed8be6..6ca7556 100644
--- a/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
+++ b/meta-cgl-common/recipes-cgl/cluster-glue/cluster-glue_1.0.12.bb
@@ -32,7 +32,6 @@ SYSTEMD_AUTO_ENABLE = "disable"
 HA_USER = "hacluster"
 HA_GROUP = "haclient"
 
-S = "${WORKDIR}/git"
 PV = "1.0.12+git${SRCPV}"
 
 PACKAGECONFIG ??= "${@bb.utils.filter('DISTRO_FEATURES', 'systemd', d)}"
@@ -44,8 +43,8 @@ EXTRA_OECONF = "--with-daemon-user=${HA_USER} \
                 --with-ocf-root=${libdir}/ocf \
                "
 
-CACHED_CONFIGUREVARS="ac_cv_path_XML2CONFIG=0 \
-                      ac_cv_path_SSH=ssh \
+CACHED_CONFIGUREVARS = "ac_cv_path_XML2CONFIG=0 \
+                        ac_cv_path_SSH=ssh \
 "
 
 USERADD_PACKAGES = "${PN}"
diff --git a/meta-cgl-common/recipes-cgl/cluster-resource-agents/resource-agents_4.5.0.bb b/meta-cgl-common/recipes-cgl/cluster-resource-agents/resource-agents_4.5.0.bb
index a1b6624..3c72275 100644
--- a/meta-cgl-common/recipes-cgl/cluster-resource-agents/resource-agents_4.5.0.bb
+++ b/meta-cgl-common/recipes-cgl/cluster-resource-agents/resource-agents_4.5.0.bb
@@ -28,8 +28,6 @@ SRCREV = "fee181320547365d7f8c88cca2b32801412b933d"
 
 UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"
 
-S="${WORKDIR}/git"
-
 LIC_FILES_CHKSUM = "file://COPYING;md5=751419260aa954499f7abaabaa882bbe \
                     file://COPYING.LGPL;md5=4fbd65380cdd255951079008b364516c \
                     file://COPYING.GPLv3;md5=d32239bcb673463ab874e80d47fae504"
diff --git a/meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb b/meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb
index 8f319b5..065f9f0 100644
--- a/meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb
+++ b/meta-cgl-common/recipes-cgl/crmsh/crmsh_4.3.1.bb
@@ -12,7 +12,6 @@ DEPENDS = "asciidoc-native \
            "
 RDEPENDS:${PN} = "pacemaker python3-lxml python3-parallax gawk bash python3-doctest"
 
-S = "${WORKDIR}/git"
 SRC_URI = "git://github.com/ClusterLabs/${BPN}.git;branch=master;protocol=https \
            file://tweaks_for_build.patch \
            file://0001-orderedset.py-fix-deprecation-on-collections.Mutable.patch \
diff --git a/meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb b/meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb
index 27497f8..d841f5f 100644
--- a/meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb
+++ b/meta-cgl-common/recipes-cgl/heartbeat/heartbeat_3.0.6.bb
@@ -38,7 +38,7 @@ SRC_URI = " \
 "
 SRC_URI[md5sum] = "101c8f507b1f407468d5ef15ae6719da"
 SRC_URI[sha256sum] = "851d2add2c129fef9fede764fec80229e1f6e7295e0e979950d10258648b462c"
-S = "${WORKDIR}/Heartbeat-3-0-958e11be8686"
+S = "${UNPACKDIR}/Heartbeat-3-0-958e11be8686"
 DEPENDS = "cluster-glue corosync gnutls libxslt-native xmlto-native docbook-xml-dtd4-native docbook-xsl-stylesheets-native intltool"
 RDEPENDS:${PN} += "python"
 inherit autotools-brokensep pkgconfig useradd
diff --git a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
index 8cce259..fd7e8ef 100644
--- a/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
+++ b/meta-cgl-common/recipes-cgl/ocfs2-tools/ocfs2-tools_1.8.6.bb
@@ -25,8 +25,6 @@ SRCREV = "4d76ceb4aa7aaa1fd595368089e99575d708f719"
 
 UPSTREAM_CHECK_GITTAGREGEX = "ocfs2-tools-(?P<pver>\d+(\.\d+)+)"
 
-S = "${WORKDIR}/git"
-
 inherit autotools-brokensep pkgconfig systemd
 
 DEPENDS = "corosync pacemaker \
diff --git a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
index 4f0f563..ff90030 100644
--- a/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
+++ b/meta-cgl-common/recipes-cgl/pacemaker/pacemaker_2.0.5.bb
@@ -21,15 +21,13 @@ SRC_URI = "git://github.com/ClusterLabs/${BPN}.git;branch=main;protocol=https \
           "
 
 CFLAGS += "-I${STAGING_INCDIR}/heartbeat"
-CPPFLAGS +="-I${STAGING_INCDIR}/heartbeat"
+CPPFLAGS += "-I${STAGING_INCDIR}/heartbeat"
 SRC_URI:append:libc-musl = "file://0001-pacemaker-fix-compile-error-of-musl-libc.patch"
 
 SRCREV = "ba59be71228fed04f78ab374dfac748d314d0e89"
 
 inherit autotools-brokensep pkgconfig systemd python3native python3-dir useradd
 
-S = "${WORKDIR}/git"
-
 UPSTREAM_CHECK_GITTAGREGEX = "Pacemaker-(?P<pver>\d+(\.\d+)+)"
 
 CLEANBROKEN = "1"
diff --git a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
index d0daa91..211b911 100644
--- a/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
+++ b/meta-cgl-common/recipes-cgl/racoon2/racoon2_202003018.bb
@@ -32,8 +32,7 @@ SRC_URI = "git://github.com/zoulasc/racoon2;branch=master;protocol=https \
            file://spmd.service \
           "
 
-SRCREV="7b68950328454b0e91ba24698c10c4a790705cc1"
-S= "${WORKDIR}/git" 
+SRCREV = "7b68950328454b0e91ba24698c10c4a790705cc1"
 SRC_URI[md5sum] = "2fa33abff1ccd6fc22876a23db77aaa8"
 SRC_URI[sha256sum] = "f23773e4d97cec823ec634085b5e60a7884a13467ff1bffc17daac14d02f9caa"
 
@@ -85,7 +84,7 @@ INITSCRIPT_PARAMS:${PN} = "remove"
 INITSCRIPT_NAME:${PN}-iked = "iked"
 INITSCRIPT_PARAMS:${PN}-iked = "remove"
 INITSCRIPT_NAME:${PN}-kinkd = "kinkd"
-INITSCRIPT_PARAMS:${PN}-kinkd= "remove"
+INITSCRIPT_PARAMS:${PN}-kinkd = "remove"
 
 SYSTEMD_PACKAGES = "${PN}"
 SYSTEMD_SERVICE:${PN} = "spmd.service iked.service"
diff --git a/meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb b/meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb
index 4c67582..c1707fd 100644
--- a/meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb
+++ b/meta-cgl-common/recipes-perl/perl/libmailtools-perl_2.21.bb
@@ -20,6 +20,6 @@ PR = "r2"
 SRC_URI = "http://search.cpan.org/CPAN/authors/id/M/MA/MARKOV/MailTools-${PV}.tar.gz"
 SRC_URI[sha256sum] = "4ad9bd6826b6f03a2727332466b1b7d29890c8d99a32b4b3b0a8d926ee1a44cb"
 
-S = "${WORKDIR}/MailTools-${PV}"
+S = "${UNPACKDIR}/MailTools-${PV}"
 
 inherit cpan
diff --git a/meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb b/meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb
index a01620c..b2d4838 100644
--- a/meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb
+++ b/meta-cgl-common/recipes-perl/perl/libsocket6-perl_0.29.bb
@@ -15,7 +15,7 @@ SRC_URI = "https://cpan.metacpan.org/authors/id/U/UM/UMEMOTO/Socket6-${PV}.tar.g
 "
 SRC_URI[socket6-perl-0.29.sha256sum] = "468915fa3a04dcf6574fc957eff495915e24569434970c91ee8e4e1459fc9114"
 
-S = "${WORKDIR}/Socket6-${PV}"
+S = "${UNPACKDIR}/Socket6-${PV}"
 
 do_configure:prepend () {
 	mkdir -p m4
diff --git a/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb b/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
index 968c628..04bd8b9 100644
--- a/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
+++ b/meta-cgl-common/recipes-perl/perl/libtest-pod-perl_1.52.bb
@@ -11,9 +11,9 @@ RDEPENDS:${PN} += " perl-module-test-more \
                     "
 PR = "r2"
 
-SRC_URI ="http://search.cpan.org/CPAN/authors/id/E/ET/ETHER/Test-Pod-${PV}.tar.gz;name=test-pod-perl-${PV}"
+SRC_URI = "http://search.cpan.org/CPAN/authors/id/E/ET/ETHER/Test-Pod-${PV}.tar.gz;name=test-pod-perl-${PV}"
 SRC_URI[test-pod-perl-1.52.md5sum] = "472dda77746d48e6465bf62e47aeca81"
 SRC_URI[test-pod-perl-1.52.sha256sum] = "60a8dbcc60168bf1daa5cc2350236df9343e9878f4ab9830970a5dde6fe8e5fc"
-S = "${WORKDIR}/Test-Pod-${PV}"
+S = "${UNPACKDIR}/Test-Pod-${PV}"
 
 inherit cpan
diff --git a/meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb b/meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb
index 5a4f55c..ea7f44f 100644
--- a/meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb
+++ b/meta-cgl-common/recipes-perl/perl/libwww-perl_6.43.bb
@@ -18,6 +18,6 @@ PR = "r2"
 SRC_URI = "https://cpan.metacpan.org/authors/id/O/OA/OALDERS/libwww-perl-${PV}.tar.gz;name=libwww-perl-${PV}"
 SRC_URI[libwww-perl-6.43.sha256sum] = "e9849d7ee6fd0e89cc999e63d7612c951afd6aeea6bc721b767870d9df4ac40d"
 
-S = "${WORKDIR}/libwww-perl-${PV}"
+S = "${UNPACKDIR}/libwww-perl-${PV}"
 
 inherit cpan
-- 
2.25.1


