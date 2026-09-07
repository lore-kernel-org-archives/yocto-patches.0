Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B596CC79F8C
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 02:25:55 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25985.1788747950092747171
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 06 Sep 2026 19:25:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=D7D8dPV5;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: raj.khem@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d7195706f1so32373165ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 06 Sep 2026 19:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788747949; x=1789352749; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JaRmSi0na/iUAtJ3QVpMCtfboiH77jiYjwXEkBt47j8=;
        b=D7D8dPV5GbNCuvOj31wXpYYQ6TFONC0jq0tNZM5ZIf4+rOyWK7I+bSlgCDe8FDXHEJ
         GXpXSJoLpsctkz6A7wHDOqd2Z0HMm3zKhIpWNRCxpczIpriQIwEye42xyF7eAvci9TK5
         igQeZKqjVwZi5i0GuOjwoSsG/vM1+tZdNmlaASJkSoD8NZk0SF6FvyCRWwk+D6SRYBh2
         ZDx46G2R34qEWTNWncZkueaZlkxvhCI3oI3W6Iiv6qF6vwgFtl4rIcFF+EC7rbUKK4pR
         OxttEXFnzHP5zlF5y5/j3OzdqSuspb8WaEAVWRJngEloV7TdfgAxoSBvWmVbmHv82W9F
         8iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788747949; x=1789352749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JaRmSi0na/iUAtJ3QVpMCtfboiH77jiYjwXEkBt47j8=;
        b=LrC5seHZbk3w/TUXKRtyaVy4G89w4cNI2XNu7XE7FaUsHQQ5SNMDOr5n+3oUKiXjXr
         wyluekXwGwPSu9XkAz5ImEEZnOTPV7GlveehE7jMDsEojkyOULelSNz1mE22KUSHHPGP
         dYvAtg+J7e9oKJkzCzXY9BJzmzvHJtm+g1LOm3AcwchGZjJGtXtXmT0m4zgwqtHHuUIr
         vg0Gsj56jeXWWMkSgzMHQrOdS3QP/hIYHPNPXn3OuA7Nw3k6uouoWZQA/H9gUoBXojd/
         cWJgYXOOuEf/l2UIiAlCox+qHr3dltVVZsj1OyTPCNYmvxOUpVH1Gm+DXvEbkhF3UJ0S
         0/lw==
X-Gm-Message-State: AFuF++ldCrgWaI75z2a+/a/WWp40QwiiyuNsyg7eASR/Zc2vFRKkgBVv
	2OjskYr8PHpfwFWxRHoK/WMbUcHS870LDlffi/6O6lYb6CPZ/hQj+ZNa/9b5nA==
X-Gm-Gg: AYBFou0hyvJQmVZTyNo+bzosk5pxDWVi5OLXZrZpDluOgsZMh2cx30lBl8A4dWeMV43
	Hp8sHM24/vqcTcCzKMZU4tF4F1sfj/6X0DoLMh0W284I6P8m9V+DZ0Kk2313GsFJE1XVtDga+4d
	H64sLEVey9vXFdSvc2ujOkuysya+y7qOts1OZUieSX/uo7BmIeQjlJNm4lukFBeHw+AjPSLJGnf
	plXkmpWBIK6+EneXlcjFgCOeFZ8GbbJpZ3rZMqqi9HWxI7YpqUbOcgDtBqBZiXLilh7D29+U+9O
	m5+k2+7WoCnW0XSULbImTEKjeG8tHbTwNhX4O0hZV0dc11XjetSawLcr4XMonLVq0kWwIv54Obf
	RF78rPbK7wDi4a+X4Rgp/D8tabDsYvvaXBLAkhTVa3fmxgTLR5aWaxqjQ6zaS0WNti9mods8rnL
	dn0ombF1+GkJs9dm3fophTrzwaA0Ui+33e+hrNGioC42J5UanbIxwAQBSh/HYnsR/BNS/ncEeo1
	W4zoChmX3xtSy9QX+2CIkcYKODlk0PNZe73/xZQ3f8aViE8iqAWtKgIm9gYbPfo0isiD2MHUkbl
	KPpPoXJMAkQQNVlDjH+Jb6ZHTtnNYuJtclZ8Iz+dhXyV5DoxwngJnlifa5lrdBO/Cvl+17sIftf
	+fe7iUrMU5l0jvem8/TrlcZCcpf7oXLjQqr0zqPaMGjnBHg4=
X-Received: by 2002:a17:90b:4a48:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39b260d2d58mr29311143a91.6.1788747949229;
        Sun, 06 Sep 2026 19:25:49 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa37dbdsm19982238eec.11.2026.09.06.19.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 19:25:48 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH v2] tpm2-tools: Upgrade 5.7 -> 5.8
Date: Sun,  6 Sep 2026 19:25:45 -0700
Message-ID: <20260907022545.1432955-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 02:25:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4737

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
 

