Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDD2C36017
	for <webhook@archiver.kernel.org>; Wed,  2 Apr 2025 16:00:21 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web11.12739.1743609617365199145
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Apr 2025 09:00:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=F+88Yo+E;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: martin.jansa@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abec8b750ebso1061516666b.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 02 Apr 2025 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743609616; x=1744214416; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oM4Oj7lsPWApPv4suiiapt7k2OrNkef5RisbUuXkHx0=;
        b=F+88Yo+EQiW1oMSh3MmIUfnmrTM9tgYlJFo3T7ECF23BDxcbit4Vd/HuCaiUP2RIC3
         GnXnc9SRN9BhTZyBLNbrxrrKR4pPGx4nx/F/ofkrF+yz3UC70CmoCPjsVxT5SLlrNdX3
         8jlD0tdDPfb810KqpI41UkZ8lYnw5Uoewa0krNAY6pdiwS99TvrE7RNSQtaZihldBp/V
         hUakN41Fwin98aTIXz4YJfRHILSCBRRTkc25U0Wy32mTm/2HoZ8c4A0g22cUbF1/wPnp
         prd+DczUV35GaLQKjrQQZFX3AK0CPxOjiWUsjGe6oApvvmImR1y6NdNY3Smql09Ck8rL
         dIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743609616; x=1744214416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM4Oj7lsPWApPv4suiiapt7k2OrNkef5RisbUuXkHx0=;
        b=k6AUZ0Tm1YOs5PRe7ymTKfjMB5j9ren1EIAX1TvH6dd8nnvxde/mGHPcuimsjh12D3
         C1PISUTwY91JOvP8cCXkgnsUW8vCCS9Ylw0hLRekVd+xMWWgIu5E+qpLQRCXKPcl/TMe
         V+BLVmXhYGGKaOQLoyeccxBjksfEPjy6efvGYOdCflShQDo85JIQU3X8bhJlwwsv0/kG
         yZqneBjfl4RVqJQdQq02iE2TdutGrm5po/0UhEXE64kHf0qKCAzwSrZcrAK/dSccr6Wp
         4sWy/rASJu8LvnZkWSIyLam8XuhOc2/jGgFOfY53VlQzWvP5AklvNR8Dc/TJSP0pTbOZ
         acCQ==
X-Gm-Message-State: AOJu0Yx8qlWXdBrbdchLy4qWL6he0Pi7fe++gJpemJKvI/PndgauVn8x
	kA7N5V+SQh7QPk9P5Bnp6jW7qmErpDBot+rR6E+kq7hyULrKiJiviOWR3cYZ
X-Gm-Gg: ASbGncsK+IwBx6mSb7hafxheZVsNMC/bhpm8HEyF2rPjDmvQ/KbIhxECu4W3xafQbj5
	Gvccd0SKb5G9DO1+UEnSdh3439G0I1wJEQ5MetkwsK3oogRtFwiv2++ns1kgM3CdlUJDrQh1xF7
	GVeNSIwZzDMuEA4lcA+B7vKFigudoHCiJlv3ehodwenK15Zc0H5BUATbhLVJ6vAz+a5XencDTx7
	SBBAyvI/oxghYeKHFV2J5Ax3dKszDziHCcX9iJ3l14XWeVtpeBVPOZHoys0eusLQESfyxzSZf3H
	0UC+qw24SHgJXfvRZP8ZzqL8Ar1kaYXM7I7mfVREyfByxZE=
X-Google-Smtp-Source: AGHT+IG5/ML4Dg9UOK3oS11HbkA4lcNi8N7Y2hQlKfhMnUT+bVUOWyDmwIPS0z7hcPqhIymXJplVxw==
X-Received: by 2002:a17:907:868d:b0:ac3:2d47:f6af with SMTP id a640c23a62f3a-ac7a16c131fmr257116466b.20.1743609615596;
        Wed, 02 Apr 2025 09:00:15 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac7196dd9b0sm917673466b.169.2025.04.02.09.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 09:00:15 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][PATCH] bazel: add whitespace around assignments
Date: Wed,  2 Apr 2025 18:00:08 +0200
Message-ID: <20250402160008.3586728-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 02 Apr 2025 16:00:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1276

From: Martin Jansa <martin.jansa@gmail.com>

With:
https://lists.openembedded.org/g/bitbake-devel/message/17508
there are many WARNINGs from this layer

Fixes:
WARNING: meta-tensorflow/classes/bazel.bbclass:10 has a lack of whitespace around the assignment: 'export USER="unused-bazel-user"'
WARNING: meta-tensorflow/classes/bazel.bbclass:15 has a lack of whitespace around the assignment: 'export BAZEL_STARTUP_OPTIONS="--output_user_root=${BAZEL_DIR}/user_root                    --output_base=${BAZEL_OUTPUTBASE_DIR}                    --bazelrc=${S}/bazelrc                    --batch                    "'
WARNING: meta-tensorflow/classes/bazel.bbclass:156 has a lack of whitespace around the assignment: 'export YOCTO_NATIVE_SYSROOT="${BAZEL_OUTPUTBASE_DIR}/external/yocto_compiler/recipe-sysroot-native"'
WARNING: meta-tensorflow/classes/bazel-base.bbclass:1 has a lack of whitespace around the assignment: 'export JAVA_HOME="${STAGING_LIBDIR_NATIVE}/jvm/openjdk-11-native"'
WARNING: meta-tensorflow/classes/bazel-base.bbclass:1 has a lack of whitespace around the assignment: 'export JAVA_HOME="${STAGING_LIBDIR_NATIVE}/jvm/openjdk-11-native"'

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 classes/bazel-base.bbclass | 2 +-
 classes/bazel.bbclass      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/classes/bazel-base.bbclass b/classes/bazel-base.bbclass
index 8d90e9b..4741f4e 100644
--- a/classes/bazel-base.bbclass
+++ b/classes/bazel-base.bbclass
@@ -1,4 +1,4 @@
-export JAVA_HOME="${STAGING_LIBDIR_NATIVE}/jvm/openjdk-11-native"
+export JAVA_HOME = "${STAGING_LIBDIR_NATIVE}/jvm/openjdk-11-native"
 
 # %25 of total number of local CPU cores
 BAZEL_JOBS ??= "HOST_CPUS*.25"
diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
index 160d50d..8fca205 100644
--- a/classes/bazel.bbclass
+++ b/classes/bazel.bbclass
@@ -7,8 +7,8 @@ inherit bazel-base
 
 BAZEL_DIR ?= "${WORKDIR}/bazel"
 BAZEL_OUTPUTBASE_DIR ?= "${BAZEL_DIR}/output_base"
-export USER="unused-bazel-user"
-export BAZEL_STARTUP_OPTIONS="--output_user_root=${BAZEL_DIR}/user_root \
+export USER = "unused-bazel-user"
+export BAZEL_STARTUP_OPTIONS = "--output_user_root=${BAZEL_DIR}/user_root \
                    --output_base=${BAZEL_OUTPUTBASE_DIR} \
                    --bazelrc=${S}/bazelrc \
                    --batch  \
@@ -153,7 +153,7 @@ PSEUDO_IGNORE_PATHS .= ",${WORKDIR}/bazel"
 
 inherit unsupportarch
 
-export YOCTO_NATIVE_SYSROOT="${BAZEL_OUTPUTBASE_DIR}/external/yocto_compiler/recipe-sysroot-native"
+export YOCTO_NATIVE_SYSROOT = "${BAZEL_OUTPUTBASE_DIR}/external/yocto_compiler/recipe-sysroot-native"
 
 do_rm_work[prefuncs] += "clean_bazel"
 do_clean[prefuncs] += "clean_bazel"

