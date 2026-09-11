Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D84C88E5D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:15:31 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48496.1789157729161824213
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:15:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=HBrRZAsA;
 spf=pass (domain: konsulko.com, ip: 209.85.219.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90ce08834feso18350336d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157728; x=1789762528; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MxdHrXBKiFoYxGxfCaHVWbsM6CZDed2CmN+pSNMM26U=;
        b=HBrRZAsAHy975SjTiJMWCCWDXS9urCYd9XaWCZ4CS34Eavq6euyYOkujt5nJ9ToOBq
         HjlLn2IzWV3JShIccE3I7WIpTxsrOMndojicy7kQhJ7n0Y9A7DChZ1yEIiE2TTUTf36Q
         3J+ZprGm2SBWouICee81Hy1MvVkQKGC+BLNmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157728; x=1789762528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MxdHrXBKiFoYxGxfCaHVWbsM6CZDed2CmN+pSNMM26U=;
        b=Yk4fqB1lVruUg92yNKh8P1sa6Kdfd+3oguLohduyymzBnXBe/ZR/jrGMXfZwggkHpJ
         Xp44hBOrvD6KM8Xs+QvQNHKJGxpXeNNlGFbmJp60ieofIDv+jJNCDJszMYbjvqTRLeG1
         RD/6QfgkqsnNIsrPP9Q1633H35RwR//7t1EAsZK1ZDqWCWrtylAMl/QVT5pT4xM9Eava
         3vsd623+ULgIN9w6/NZnQeum22Nslw+lA3aerG7119PD7/2rz3scH7yVgY8CS/Qj42ZG
         3mGGFnRq+biLtn0R1IzdYCZaYMryJhk6Wh4wJcTmcyOFQqhcMcfmM0zJ3L+ZMI8EXqLR
         XMHw==
X-Gm-Message-State: AFuF++lvqd45QK1NNNG7ryH9deqOdoS+7nNKEloHmoDB7d2rh2o/7hE7
	rhLy40RjLVWePJpOJ5XOYScvp9ofRrN7sIjZIHRnkKWEVpaOvfZDJWbLNvWi8Vw9QRJ1spkrtjD
	gBW5J
X-Gm-Gg: AYBFou1VPe/sn7Jq8HghSsay6Sv53ZFk+nD0dOa8lSzAmUjzz7RsCZayc6UlICI07pK
	8EU7F/iFltoGtujt8upkh7NqcJzPZ0wdY+dqu/ywPJockMf9X6YOBdRLkh/tTlZ3SkLyxJcje8d
	dSHUfpbxJMHKT4/UxGYRmBmk/8XsK508vwp7aWJDIGyJ7HkLzfQiIkNMrzLS4/v9BJfZspolkiF
	uC4wOudJ/Ep8dAn+ag3wslFbhG9H2gdfqcIQsncpj42MPqhG91iQdZcxeYc+u5TiSfl+aMBiEhg
	+CPFb8oS/v2BBjkxfxaxdBivOrAaaFA8P8tSCk7RvyvJ7EwCxplljCHa0SbRt4GcGP714WzRmI/
	wuSyRdKHfpcff5NN86CAYx0zYwGjGHIxAqSw+7skZm8uPmVZgh/q2iLI+Qj8qYLN4jIt9xLAbJ/
	4HDWGxsKBIQYXzXF/DtvEXfwFKEFLzDIfBJH988maBmdO0FPhS1oTMKWQQO8SQ2/po5RMx4yY6Y
	8m5TMpIsQuhAq57NVhO0fuCS43CSY/3fwvsm/uwh5PAx4Gq8Xufc3/bB7TIkSaXz72wojj9cO0I
	rDsNJQrnLe3uNCFhSXuXSQT2IcnCCIti8Zk=
X-Received: by 2002:a05:6214:5c46:b0:910:4dce:6a0d with SMTP id 6a1803df08f44-912120e5205mr82650096d6.18.1789157726699;
        Fri, 11 Sep 2026 13:15:26 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4b699bsm28930706d6.37.2026.09.11.13.15.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:15:25 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 05/11] libgit2: upgrade 1.9.6 -> 1.9.7
Date: Fri, 11 Sep 2026 16:15:09 -0400
Message-ID: <47cf9dee797637a332f7ee0e6f2943c2c80e1222.1789155804.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789155804.git.scott.murray@konsulko.com>
References: <cover.1789155804.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:15:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4809

From: Richard Purdie <richard.purdie@linuxfoundation.org>

v1.9.7
------

This is an security release with one change.

* Escape remote repository paths in libssh2

  In v1.9.2, we started escaping repository paths in the OpenSSH-based
  exec ssh transport. Bring the same escaping to the libssh2 transport
  to avoid any potential command injection.

In addition, changes have been ported from the main branch to update
CI builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit b66353353a0e1a26f8060931b3d571134a27768b)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...cmake-mark-system-libraries-are-private-link-librari.patch | 4 +---
 .../libgit2/{libgit2_1.9.6.bb => libgit2_1.9.7.bb}            | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)
 rename recipes-support/libgit2/{libgit2_1.9.6.bb => libgit2_1.9.7.bb} (92%)

diff --git a/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch b/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
index 267770a..93f1f3a 100644
--- a/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
+++ b/recipes-support/libgit2/files/0001-cmake-mark-system-libraries-are-private-link-librari.patch
@@ -1,4 +1,4 @@
-From 5670d3eed82f0d64766158809bf3d0c7c631b0ea Mon Sep 17 00:00:00 2001
+From 41048806aec8a4b71f3ccf11fdedbec88080a675 Mon Sep 17 00:00:00 2001
 From: Ross Burton <ross.burton@arm.com>
 Date: Thu, 23 Jul 2026 17:35:23 +0100
 Subject: [PATCH] cmake: mark system libraries are private link libraries
@@ -38,5 +38,3 @@ index 8045ddef9..fafdb09ec 100644
  target_include_directories(libgit2package SYSTEM PRIVATE ${LIBGIT2_INCLUDES})
  target_include_directories(libgit2package INTERFACE $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
  
--- 
-2.43.0
diff --git a/recipes-support/libgit2/libgit2_1.9.6.bb b/recipes-support/libgit2/libgit2_1.9.7.bb
similarity index 92%
rename from recipes-support/libgit2/libgit2_1.9.6.bb
rename to recipes-support/libgit2/libgit2_1.9.7.bb
index aa2a5f4..df85239 100644
--- a/recipes-support/libgit2/libgit2_1.9.6.bb
+++ b/recipes-support/libgit2/libgit2_1.9.7.bb
@@ -8,7 +8,7 @@ DEPENDS = "curl openssl zlib libssh2 libgcrypt libpcre2"
 SRC_URI = "git://github.com/libgit2/libgit2.git;branch=maint/v1.9;protocol=https;tag=v${PV} \
            file://0001-cmake-mark-system-libraries-are-private-link-librari.patch"
 
-SRCREV = "26055f5af74ab1cf636d272e8a34315496d3f06f"
+SRCREV = "49e408b3208bc3093757a1c2db938d3590f3f412"
 
 inherit cmake
 
-- 
2.55.0


