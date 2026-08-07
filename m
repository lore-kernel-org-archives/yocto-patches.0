Return-Path: <wangmy@fujitsu.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43106C5AC7C
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 07:24:16 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37687.1786087452456799820
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Aug 2026 00:24:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fujitsu.com header.s=fj2 header.b=g5WxcEqn;
 spf=pass (domain: fujitsu.com, ip: 139.138.36.223, mailfrom: wangmy@fujitsu.com)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1786087452; x=1817623452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NfBW945pdCV3/Nf1pUJHw0wTggMZRWJW+8l83FqCl8k=;
  b=g5WxcEqnznw4IiZ2qeSD4tj+fXU6akCB2fN5AH15sC4oBjyQuabyneq5
   Vh8LN7cBdpDc513pqYA0X80Q4GVBJqm3P4U/2ps5xdtu/NIkIY6FXoFWc
   AhFS4nXXQyQfeN1wnLMDcsudWzN4Kelv+dwRoerMNa+bTpUpfBozVn/VB
   U+EZ2fuwTHNoBgCLftKJvCw9urpLhy2pYHqS4o/9dl6nLxr2eWSD8aA40
   R9z9F8mw/hyTovVqAubkR84NLp02k+U9lOW+ifOWKSdQj2E4y3rzwg3+L
   svvhT9k5P/AKLCtb6Vi+qpH2eRsE7BEv2kd/MBRbTLE8qKCr3UHwdlDLK
   A==;
X-CSE-ConnectionGUID: z3Kv2vK1R/yQLIFlU1PCgw==
X-CSE-MsgGUID: 7yJw5ZN/QfC6YWgk3O94lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="237507742"
X-IronPort-AV: E=Sophos;i="6.25,210,1779116400"; 
   d="scan'208";a="237507742"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 16:24:10 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 869FE1C000F2
	for <yocto-patches@lists.yoctoproject.org>; Fri,  7 Aug 2026 07:24:10 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (unknown [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 3AC431801EA7
	for <yocto-patches@lists.yoctoproject.org>; Fri,  7 Aug 2026 07:24:10 +0000 (UTC)
Received: from G08FNSTD200057.g08.fujitsu.local (unknown [10.167.135.104])
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTP id 4E89F18051E0;
	Fri,  7 Aug 2026 07:24:08 +0000 (UTC)
From: Wang Mingyu < wangmy@fujitsu.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wang Mingyu <wangmy@fujitsu.com>
Subject: [yocto-patches] [meta-security] [PATCH] fix LICENSE variable syntax to suppress QA warning
Date: Fri,  7 Aug 2026 15:24:04 +0800
Message-ID: <20260807072404.1605-1-wangmy@fujitsu.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 07:24:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4648

From: Wang Mingyu <wangmy@fujitsu.com>

Signed-off-by: Wang Mingyu <wangmy@fujitsu.com>
---
 recipes-ids/crowdsec/crowdsec-licenses.inc    | 2 +-
 recipes-ids/crowdsec/crowdsec_1.7.7.bb        | 2 +-
 recipes-mac/AppArmor/apparmor_4.0.3.bb        | 2 +-
 recipes-perl/perl/lib-perl_0.63.bb            | 2 +-
 recipes-perl/perl/libwhisker2-perl_2.5.bb     | 2 +-
 recipes-scanners/clamav/clamav_1.4.4.bb       | 4 ++--
 recipes-security/libgssglue/libgssglue_0.9.bb | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/recipes-ids/crowdsec/crowdsec-licenses.inc b/recipes-ids/crowdsec/crowdsec-licenses.inc
index cb45b10..92f5dc6 100644
--- a/recipes-ids/crowdsec/crowdsec-licenses.inc
+++ b/recipes-ids/crowdsec/crowdsec-licenses.inc
@@ -4,7 +4,7 @@
 # Do not modify it by hand, as the contents will be replaced when
 # running the update-modules task.
 
-LICENSE += "& Apache-2.0 & BSD-2-Clause & BSD-3-Clause & ISC & MIT & MPL-2.0 & WTFPL"
+LICENSE += "AND Apache-2.0 AND BSD-2-Clause AND BSD-3-Clause AND ISC AND MIT AND MPL-2.0 AND WTFPL"
 
 LIC_FILES_CHKSUM += "\
     file://pkg/mod/ariga.io/atlas@v0.31.1-0.20250212144724-069be8033e83/LICENSE;md5=175792518e4ac015ab6696d16c4f607e;spdx=Apache-2.0 \
diff --git a/recipes-ids/crowdsec/crowdsec_1.7.7.bb b/recipes-ids/crowdsec/crowdsec_1.7.7.bb
index 0697022..356c227 100644
--- a/recipes-ids/crowdsec/crowdsec_1.7.7.bb
+++ b/recipes-ids/crowdsec/crowdsec_1.7.7.bb
@@ -1,7 +1,7 @@
 SUMMARY = "CrowdSec is a free, modern & collaborative behavior detection engine, coupled with a global IP reputation network."
 DESCRIPTION = "Open-source and participative security solution offering crowdsourced protection against malicious IPs and access to the most advanced real-world CTI."
 HOMEPAGE = "https://www.crowdsec.net"
-LICENSE = "MIT & CC0-1.0"
+LICENSE = "MIT AND CC0-1.0"
 LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=1e58fe4126ce0b50677f3aa6ba8e13c2 \
                     file://src/${GO_IMPORT}/build/windows/Chocolatey/crowdsec/tools/LICENSE.txt;md5=4d249f04094c9fb4d2b6fd2b1127e219 \
                     file://src/${GO_IMPORT}/test/lib/bats-assert/LICENSE;md5=7bae63a234e80ee7c6427dce9fdba6cc \
diff --git a/recipes-mac/AppArmor/apparmor_4.0.3.bb b/recipes-mac/AppArmor/apparmor_4.0.3.bb
index 9983157..76025bd 100644
--- a/recipes-mac/AppArmor/apparmor_4.0.3.bb
+++ b/recipes-mac/AppArmor/apparmor_4.0.3.bb
@@ -8,7 +8,7 @@ DESCRIPTION = "user-space parser utility for AppArmor \
 HOMEPAGE = "http://apparmor.net/"
 SECTION = "admin"
 
-LICENSE = "GPL-2.0-only & GPL-2.0-or-later & BSD-3-Clause & LGPL-2.1-or-later"
+LICENSE = "GPL-2.0-only AND GPL-2.0-or-later AND BSD-3-Clause AND LGPL-2.1-or-later"
 LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=fd57a4b0bc782d7b80fd431f10bbf9d0"
 
 DEPENDS = "bison-native apr autoconf-archive-native gettext-native coreutils-native swig-native"
diff --git a/recipes-perl/perl/lib-perl_0.63.bb b/recipes-perl/perl/lib-perl_0.63.bb
index f0d6832..c0fb43a 100644
--- a/recipes-perl/perl/lib-perl_0.63.bb
+++ b/recipes-perl/perl/lib-perl_0.63.bb
@@ -5,7 +5,7 @@ will find modules which are not located in the default search path."
 
 SECTION = "libs"
 HOMEPAGE = "https://metacpan.org/dist/lib"
-LICENSE = "Artistic-1.0 | GPL-1.0-or-later"
+LICENSE = "Artistic-1.0 OR GPL-1.0-or-later"
 PR = "r0"
 
 LIC_FILES_CHKSUM = "file://README;beginline=26;endline=30;md5=94b119f1a7b8d611efc89b5d562a1a50"
diff --git a/recipes-perl/perl/libwhisker2-perl_2.5.bb b/recipes-perl/perl/libwhisker2-perl_2.5.bb
index e16e5f2..94b2384 100644
--- a/recipes-perl/perl/libwhisker2-perl_2.5.bb
+++ b/recipes-perl/perl/libwhisker2-perl_2.5.bb
@@ -1,7 +1,7 @@
 DESCRIPTION = "Libwhisker is a Perl module geared specificly for HTTP testing."
 
 SECTION = "libs"
-LICENSE = "Artistic-1.0 | GPL-1.0-or-later"
+LICENSE = "Artistic-1.0 OR GPL-1.0-or-later"
 
 LIC_FILES_CHKSUM = "file://LICENSE;md5=254b8e29606fce6d1c1a4c9e32354573"
 
diff --git a/recipes-scanners/clamav/clamav_1.4.4.bb b/recipes-scanners/clamav/clamav_1.4.4.bb
index e9c2aca..b3f14cd 100644
--- a/recipes-scanners/clamav/clamav_1.4.4.bb
+++ b/recipes-scanners/clamav/clamav_1.4.4.bb
@@ -1,8 +1,8 @@
 SUMMARY = "ClamAV anti-virus utilities and scanner tools"
-DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats."
+DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware AND other malicious threats."
 HOMEPAGE = "http://www.clamav.net/index.html"
 SECTION = "security"
-LICENSE = "GPL-2.0-only & LGPL-2.1-only & BSD-2-Clause & Zlib & Apache-2.0-with-LLVM-exception"
+LICENSE = "GPL-2.0-only AND LGPL-2.1-only AND BSD-2-Clause AND Zlib AND Apache-2.0-with-LLVM-exception"
 LIC_FILES_CHKSUM = "file://COPYING.txt;md5=2c0b5770a62017a3121c69bb9f680b0c \
                     file://COPYING/COPYING.LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1 \
                     file://COPYING/COPYING.bzip2;md5=ae8d555c34b656ff864ea9437a10d3a0 \
diff --git a/recipes-security/libgssglue/libgssglue_0.9.bb b/recipes-security/libgssglue/libgssglue_0.9.bb
index 0952ed1..9b33ce9 100644
--- a/recipes-security/libgssglue/libgssglue_0.9.bb
+++ b/recipes-security/libgssglue/libgssglue_0.9.bb
@@ -8,7 +8,7 @@ depending on the mechanism. \
 HOMEPAGE = "https://gitlab.com/gsasl/libgssglue"
 SECTION = "libs"
 
-LICENSE = "BSD-3-Clause | HPND"
+LICENSE = "BSD-3-Clause OR HPND"
 
 #Copyright (c) 1996, by Sun Microsystems, Inc.                   HPND
 #Copyright (c) 2007 The Regents of the University of Michigan. BSD-3-Clause
-- 
2.43.0


