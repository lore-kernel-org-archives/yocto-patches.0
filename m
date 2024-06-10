Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D5C27C65
	for <webhook@archiver.kernel.org>; Mon, 10 Jun 2024 14:33:11 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.21029.1718029987667878308
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 10 Jun 2024 07:33:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=KglGejxS;
 spf=pass (domain: snapchat.com, ip: 209.85.208.52, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c83100bd6so1316879a12.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 07:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718029985; x=1718634785; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZjwdaSG1RgiCy3YdVv9az5l/LSGbMYOfEUSqqs8FB0=;
        b=KglGejxSkBaHDX4wTGzqZ+VdfWsjFFeBlYsVe2pVzEaFqVuXXTRVqZ8lnZ8EYqk5vf
         jy7u52iozMkzpc9FF9sEs1gdJcos5Md6ki+ZV3v24nKmB2u+MQ6LqEUxSwYSQAz5EnG5
         UNFdpzS6PDQ+iRsrWuU8PxJ9LQne90MHBc0Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029985; x=1718634785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZjwdaSG1RgiCy3YdVv9az5l/LSGbMYOfEUSqqs8FB0=;
        b=s2Y001v2zFwpdLuLY9nIz+O2pOYYiKPr/O7YMLb8uT8ZWdyRzjScDpNQX9l7/DuVlW
         QhixS5wVoFT4PkO/zzLsZGuzuVyNR3c5hUGHHRaOUQe8HgocxW8jDCPRpHN3PPSGiw32
         eDLhJQtM1KmrT4sUmCNIB5F9iOl5vS2Q4yuC2ymx/2tVNqpDsShmIxgsKfnEKgPuw8Je
         YASgMhQdBRJpCvMo9AzGKSbPb+C4C7uXkrUmY+XJQ0CxuO8u2ZahANeo9X8igULWEowJ
         1OG7Ydn2qOySoUbLuFTwwGAOn5HBqmA+0S0SggG00XLKcKMlLAlligV71lFuR9h9xnjK
         YjKg==
X-Gm-Message-State: AOJu0YyCu87qf0K3UsME4EP/2zuup0uvYWUGTHmk6vKuX3eLN7SBUhI6
	+2fBGuMkhqX4ppZUGNfVU4xp1OyvG8YS+mIL7mAlalI4/1UXdqIROMjV2VOrzo9DfAfDi2WfRUS
	iJdA=
X-Google-Smtp-Source: AGHT+IHa3Gmyufg1udrgbGRA6RfgFMveWkuJ3cuG5S1wHFLGGABzvkM8RxsKStSgTgaPoWqfLxcaxA==
X-Received: by 2002:a50:9fab:0:b0:57c:6b49:af5 with SMTP id 4fb4d7f45d1cf-57c6b49126amr4235555a12.29.1718029985317;
        Mon, 10 Jun 2024 07:33:05 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae237408sm7504233a12.93.2024.06.10.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:33:05 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-darwin][PATCH 11/11] zlib: update to scarthgap
Date: Mon, 10 Jun 2024 16:32:14 +0200
Message-Id: <20240610143214.2376414-11-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240610143214.2376414-1-ecordonnier@snap.com>
References: <20240610143214.2376414-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 10 Jun 2024 14:33:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/293

From: Etienne Cordonnier <ecordonnier@snap.com>

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 .../files/0001-fix-wrong-libtool-path.patch   | 42 ++++++++++---------
 .../{zlib_1.2.%.bbappend => zlib_%.bbappend}  |  4 +-
 2 files changed, 25 insertions(+), 21 deletions(-)
 rename recipes-core/zlib/{zlib_1.2.%.bbappend => zlib_%.bbappend} (54%)

diff --git a/recipes-core/zlib/files/0001-fix-wrong-libtool-path.patch b/recipes-core/zlib/files/0001-fix-wrong-libtool-path.patch
index 528b46b..32171fb 100644
--- a/recipes-core/zlib/files/0001-fix-wrong-libtool-path.patch
+++ b/recipes-core/zlib/files/0001-fix-wrong-libtool-path.patch
@@ -1,33 +1,35 @@
-From 3b7dfa06c12eb605ae244bbdf37a5c502f63a035 Mon Sep 17 00:00:00 2001
-From: Dominik Schnitzer <dominik@snap.com> 
-Date: Fri, 12 May 2023 10:11:56 +0000
+From 98c5fa349ca64fb6e6a4c29a32f8e3ced6fb81b5 Mon Sep 17 00:00:00 2001
+From: Etienne Cordonnier <ecordonnier@snap.com>
+Date: Fri, 7 Jun 2024 00:06:42 +0200
 Subject: [PATCH] fix wrong libtool path
 
 Upstream-Status: Inappropriate [OE specific]
 Signed-off-by: Dominik Schnitzer <dominik@snap.com>
 ---
- configure | 8 +-------
- 1 file changed, 1 insertion(+), 7 deletions(-)
+ configure | 10 +---------
+ 1 file changed, 1 insertion(+), 9 deletions(-)
 
 diff --git a/configure b/configure
-index 69dfa3f..dcd0e75 100755
+index a7c6d72..c2c1d6a 100755
 --- a/configure
 +++ b/configure
-@@ -240,13 +240,7 @@ if test "$gcc" -eq 1 && ($cc -c $test.c) >> configure.log 2>&1; then
-              SHAREDLIB=libz$shared_ext
-              SHAREDLIBV=libz.$VER$shared_ext
-              SHAREDLIBM=libz.$VER1$shared_ext
--             LDSHARED=${LDSHARED-"$cc -dynamiclib -install_name $libdir/$SHAREDLIBM -compatibility_version $VER1 -current_version $VER3"}
--             if libtool -V 2>&1 | grep Apple > /dev/null; then
--                 AR="libtool"
--             else
--                 AR="/usr/bin/libtool"
--             fi
--             ARFLAGS="-o" ;;
-+             LDSHARED=${LDSHARED-"$cc -dynamiclib -install_name $libdir/$SHAREDLIBM -compatibility_version $VER1 -current_version $VER3"} ;;
-   *)             LDSHARED=${LDSHARED-"$cc -shared"} ;;
+@@ -264,15 +264,7 @@ if test "$gcc" -eq 1 && ($cc -c $test.c) >> configure.log 2>&1; then
+         SHAREDLIB=libz$shared_ext
+         SHAREDLIBV=libz.$VER$shared_ext
+         SHAREDLIBM=libz.$VER1$shared_ext
+-        LDSHARED=${LDSHARED-"$cc -dynamiclib -install_name $libdir/$SHAREDLIBM -compatibility_version $VER1 -current_version $VER3"}
+-        if "${CROSS_PREFIX}libtool" -V 2>&1 | grep Apple > /dev/null; then
+-            AR="${CROSS_PREFIX}libtool"
+-        elif libtool -V 2>&1 | grep Apple > /dev/null; then
+-            AR="libtool"
+-        else
+-            AR="/usr/bin/libtool"
+-        fi
+-        ARFLAGS="-o" ;;
++        LDSHARED=${LDSHARED-"$cc -dynamiclib -install_name $libdir/$SHAREDLIBM -compatibility_version $VER1 -current_version $VER3"} ;;
+   *)
+         LDSHARED=${LDSHARED-"$cc -shared"} ;;
    esac
- else
 -- 
 2.36.1.vfs.0.0
 
diff --git a/recipes-core/zlib/zlib_1.2.%.bbappend b/recipes-core/zlib/zlib_%.bbappend
similarity index 54%
rename from recipes-core/zlib/zlib_1.2.%.bbappend
rename to recipes-core/zlib/zlib_%.bbappend
index 8738b98..fd3155e 100644
--- a/recipes-core/zlib/zlib_1.2.%.bbappend
+++ b/recipes-core/zlib/zlib_%.bbappend
@@ -1,8 +1,10 @@
 FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
+DEPENDS += "libtool"
+
 SRC_URI += "\
     file://0001-fix-wrong-libtool-path.patch \
 "
 do_configure:darwin21 () {
-    uname=darwin ./configure --prefix=${prefix} --shared --libdir=${libdir}
+    LDCONFIG=true ${S}/configure --prefix=${prefix} --shared --libdir=${libdir} --uname=darwin
 }
-- 
2.36.1.vfs.0.0


