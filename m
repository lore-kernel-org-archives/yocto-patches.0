Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF571C982CD
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:52 +0000 (UTC)
Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.27099.1789597850009062801
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=d6b6L5h2;
 spf=pass (domain: konsulko.com, ip: 74.125.230.205, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910a0cb7cso12955085a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597849; x=1790202649; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YpuASZxVpQBRb99NvzrvxGm9ABXKbYJDMu75tzSQ2Lo=;
        b=d6b6L5h2rOmz3nBrfMnbbyfkMJV+IoeoySWiFk1Y1LGEN0hBTN/J9Mu9ZWfIrm2U4e
         78/32F31vaydGmVxThdho4aaVgU94zk+NEQhDIGtHQE7zQbySMq2pFEcfqHw7ndkkYGe
         9vZ0zriu1SOhUx9zPvqxxfst1o6QWAzWz/RtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597849; x=1790202649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YpuASZxVpQBRb99NvzrvxGm9ABXKbYJDMu75tzSQ2Lo=;
        b=K5N9umGwBiwteT8194nKHQYCkQsz7krZEFhiHVFupZaTxpqg/wAvST0I7ezASSlupi
         PmfSKmKTOOpeyhefkyHsqQqhzuOs5GN2kdj7AvzI4ZxsuAO2pB7x68qDarsC7PgaTFh1
         gE16K2ptoRgYLNJnd3qY4DjibkI/C09yoN/BaHi8a7exzOzKZLQdd+P5OcN2+4xrLD1c
         YVbEkEURJteMOYDwaeDX5tpksIDehq3MXrfuK3YSLGpksd+j5P0er6+NuAXEMGxYfk8M
         FQznkPWUI7hWZcOvBmy8FlYLn7IiwM65F0wLmyMoN2ZU6pc0BZVK9HukLKdVYUHd0a7w
         CMGA==
X-Gm-Message-State: AFuF++mZGhnDl8tHutnXCXIxkmsw06fAt7wtqUH4qY5QqiPjVcA1/QOl
	3n0YX2o1ejurhUag37tXolRVbsD4lquOgYs7u+tmTXWKOHKayzGz3UfCS1kc5IkvAVrdRHLS4j0
	RzG0t
X-Gm-Gg: AYBFou0MJPtePr78FHeF8j44TaVfWLXXtt2OtvMKHsCv51wFJo4iLYbGXmlkewaTIo+
	ol85lzpc0zQW6UDRYo2gGHx6vWXJtOfTHBPIph5qn+XpFSR7IuhVgb4ES58K6mHAPQUXh0IypgW
	eqHM+ZIMEbSemwxofDbd8DteGnS6rdOa3/CfMTQYvEAJFMPDJDUjsulY8OEuroUHtvGGyFlWwDn
	/Cvz/cemx2anRr8tx2VPRZSd8zHaK+tfrwASSuqa5QjROSCXG/xXmEtk8VSBStv2yWD13ydAIb4
	SyRHSfvr8Bm9cCvszBmzdh7Rk4RxMhBgwtQpExD2aiiwix7bIiTihCfmFInn/xNMoHw4NQRRHrZ
	8df65vsO6yC2vN/GkvjhI6qfvDTtCJ2s4CpVxYeLiGr81q2crycNn2AL1xyiRw1aNtvxFA+Kcs3
	Q6CEEeMN4Vbxy0zA17ZfWJJb5DIxrV86JkN/5BNfSPgsTS0KbIdqn+QUN+5Nc6g4qUu6TvJbWke
	NFPCFCQNx4jeQVDvJMp3vVUBMJ3sjl5FG/jCtP5yGlTMujV+yPtUIg2q4dVLW7gqrdxRcnLFYaf
	xT/QAwwjKFKOF8BT2Z8A3AkPcy2kz//op4I=
X-Received: by 2002:a05:620a:2904:b0:939:8ecf:6025 with SMTP id af79cd13be357-93bb77a133fmr754953085a.20.1789597848743;
        Wed, 16 Sep 2026 15:30:48 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:48 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 19/24] tpm2-tools: Upgrade 5.7 -> 5.8
Date: Wed, 16 Sep 2026 18:30:13 -0400
Message-ID: <b289c5040c62fa46895017449b942bbf64ca1787.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4895

From: Khem Raj <raj.khem@gmail.com>

Release notes:
https://github.com/tpm2-software/tpm2-tools/blob/5.8/docs/CHANGELOG.md

Fixes GHSA-v7w4-4gc9-qcgv, GHSA-gwfg-w3jr-xh66 and GHSA-qp88-8f4j-wv7q,
including a heap buffer overflow in tpm2_getekcertificate.

Also brings OpenSSL 4.0 compatible macros, so the tools build and link
cleanly against openssl 4.x (verified against 4.0.2 with no deprecation
warnings; tpm2 links libcrypto.so.4).

Add autoconf-archive-native to DEPENDS: the 5.8 release tarball no longer
bundles the autoconf-archive ax_*.m4 macros under m4/ the way 5.7 did, so
the autoreconf done by autotools.bbclass leaves AX_CHECK_COMPILE_FLAG,
AX_CHECK_LINK_FLAG, AX_CHECK_PREPROC_FLAG, AX_ADD_FORTIFY_SOURCE,
AX_CODE_COVERAGE and AX_IS_RELEASE undefined. m4 then strips a quoting
level off their unexpanded arguments and the bare AC_MSG_ERROR leaks into
configure, failing autoconf's m4_pattern_forbid check with:

  configure.ac:40: error: undefined or overquoted macro: AC_MSG_ERROR

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb}       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb} (83%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
similarity index 83%
rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
index 7c5d156..4edd283 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
@@ -5,11 +5,11 @@ LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://docs/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
 SECTION = "tpm"
 
-DEPENDS = "tpm2-tss openssl curl"
+DEPENDS = "tpm2-tss openssl curl autoconf-archive-native"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
+SRC_URI[sha256sum] = "1cb73185cae814b4e15c7c2d0b22642d640faf48775f4156a1fd92edf84bef73"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 
-- 
2.55.0


