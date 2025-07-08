Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CEEC71130
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 07:24:52 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.13204.1751959481841214298
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Jul 2025 00:24:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OtYd72JD;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d54214adso28050255e9.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 00:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751959480; x=1752564280; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYD0CvGp3drIedA5ONueaZanua/CcgtcsqLMzU696x0=;
        b=OtYd72JDUOwuMwF72iAJ8LfMKI4WhdaWZaS3/M8EW6LSZf/xc9d5dpfi/+dxlfbNKh
         AsY42WO1VU92Ymjk4elzrAA+zINXmwWrU1dGMKoNU+e7q95d+Nui3LG98/3itoJLZ02Z
         B1g9c6LakcL693uCUoIR3UvjCVvrxJrVvwO2F2dTegtS2V1xYXwXRcICCHr25/r++dwW
         6w8oUQNn5YFO2OuHLsW+RFuQeD0Lk9XEOAVbEVzal5DGWf6aNfddvQ0QECaHs2y+MTdU
         3qGovY/tqjSugdcMIQlqbpe2aeAJ4+qlt4USX2CFRk1ra9JpJb938gNwRKRf6z/bafYI
         jKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751959480; x=1752564280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYD0CvGp3drIedA5ONueaZanua/CcgtcsqLMzU696x0=;
        b=lTuQBmWEcl5a4iADvU/e6MkdwJCLUJJee8dWMu4dqv1Kt531IZryRyIxBFcbccEbt1
         hAjF3LOx5p463LA8wQzbRIdonyjvyEu1fvAXjRen+227yfk49ktaexiAjmXd1Syb0NyJ
         CpWubJS/4Xvil6tlMN6gQxe5pLAVwHjKKpwxJq3AFXsjHF4Fo6P1SQ2dmCUtu8Q0uDMF
         yqQq1JNZYimxFu0BMCoRSQhOBjtsyYrTvNatzeO8Q6nSGwOALboLJoE709BQdgy8RGIu
         8oXQO6HYkME4Ebc6xZJM85x2b/zxKxQU2nBpRAKewYp3Sbw/F/iJUCvWpSHtwJAGoB4T
         pK7Q==
X-Gm-Message-State: AOJu0YxoT38K1un4xuIny0NKaU4+ReU9swnQKodi6Y+wm6Fg31iguwAd
	XElJ6o/g/vO3xcOi/RpHa5PCvD7JJjjFsbjdJE4geutKb0gpZW4lhZvzf76x6A==
X-Gm-Gg: ASbGncvuiNSIcTa0Hn9n1fCAykPZKxW+TwonRZI8XRAMseRCbVXuthxDHI4KNE+ESm9
	eenA79QLb7rV3F+YLdy067xgdY8oYZQ57Q0QKqN5RK8p4pU/1OwIkV/7O3NhdWyqgCyzx5VrwYp
	cXjXxnoQY0jUC92Vr+R9qbateeUtb4Yejo3qa/av/mDHAsWspFlpyubWrD7O7r08bHnkHH6jxP0
	EyWAp8GsMqXe2hDNhvdVu0Bsw8LqBFS7ZhIZ5Wpn3+WnCkbwuPmIOQ+vEGU10Cu9yMlgmzyH5pG
	T1CvITOBxLZtIaw8FDUOPHnThhl2d8Eby8YH/cO+lfSa5YPjb2jp5k5zdlewNugI
X-Google-Smtp-Source: AGHT+IFqaGX+9+iVpv12e7HM89DWc+juHHRG9M9hCsY0tHV7AOQC2f6PkGM64Y+6Z9GRYjcqweOV5g==
X-Received: by 2002:a05:600c:1c89:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-454cd4bb500mr17149785e9.13.1751959480036;
        Tue, 08 Jul 2025 00:24:40 -0700 (PDT)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454cd4938d9sm13149045e9.23.2025.07.08.00.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:24:39 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin2.jansa@lgepartner.com>
Subject: [meta-tensorflow][PATCH 1/3] recipes: adapt to UNPACKDIR changes
Date: Tue,  8 Jul 2025 09:24:34 +0200
Message-ID: <20250708072436.24522-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Jul 2025 07:24:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1781

From: Martin Jansa <martin2.jansa@lgepartner.com>

Please see
https://git.yoctoproject.org/poky/commit/?id=4dd321f8b83afecd962393101b2a6861275b5265
for what changes are needed, and sed commands that can be used to make them en masse.

Based on migration guide from:
https://lists.yoctoproject.org/g/docs/message/7195

with added .bbappend as we have couple S assignments in .bbappends as well

sed -i "/^S = \"\${WORKDIR}\/git\"/d" `find . -name \*.bb -o -name \*.inc -o -name \*.bbclass -o -name \*.bbappend` &&
sed -i "s/^S = \"\${WORKDIR}\//S = \"\${UNPACKDIR}\//g" `find . -name \*.bb -o -name \*.inc -o -name \*.bbclass -o -name \*.bbappend` &&
sed -i -z -E 's/([ \t\f\v\r]*\n){3,}/\n\n/g' `find . -name \*.bb -o -name \*.inc -o -name \*.bbappend`

Signed-off-by: Martin Jansa <martin2.jansa@lgepartner.com>
---
 recipes-devtools/openjdk/openjdk-11-native_11.0.15.bb       | 2 +-
 recipes-devtools/python/python3-mldtypes_0.5.1.bb           | 2 +-
 recipes-devtools/python/python3-opt-einsum_3.3.0.bb         | 2 +-
 recipes-framework/tensorflow/keras_2.19.0.bb                | 1 -
 recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb | 1 -
 recipes-framework/tensorflow/tensorflow.inc                 | 2 --
 6 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/recipes-devtools/openjdk/openjdk-11-native_11.0.15.bb b/recipes-devtools/openjdk/openjdk-11-native_11.0.15.bb
index e982af6..cec79b2 100644
--- a/recipes-devtools/openjdk/openjdk-11-native_11.0.15.bb
+++ b/recipes-devtools/openjdk/openjdk-11-native_11.0.15.bb
@@ -9,7 +9,7 @@ SRC_URI = " \
     https://github.com/ojdkbuild/contrib_jdk11u-ci/releases/download/jdk-11.0.15%2B10/jdk-11.0.15-ojdkbuild-linux-x64.zip \
 "
 
-S = "${WORKDIR}/jdk-11.0.15-ojdkbuild-linux-x64"
+S = "${UNPACKDIR}/jdk-11.0.15-ojdkbuild-linux-x64"
 
 do_patch[noexec] = "1"
 do_configure[noexec] = "1"
diff --git a/recipes-devtools/python/python3-mldtypes_0.5.1.bb b/recipes-devtools/python/python3-mldtypes_0.5.1.bb
index 1755226..b3f8b98 100644
--- a/recipes-devtools/python/python3-mldtypes_0.5.1.bb
+++ b/recipes-devtools/python/python3-mldtypes_0.5.1.bb
@@ -11,7 +11,7 @@ inherit pypi python_setuptools_build_meta
 SRCNAME ?= "ml_dtypes"
 PYPI_SRC_URI = "https://files.pythonhosted.org/packages/32/49/6e67c334872d2c114df3020e579f3718c333198f8312290e09ec0216703a/${SRCNAME}-${PV}.tar.gz"
 SRC_URI += "file://0001-fix-setuptools-missing.patch"
-S = "${WORKDIR}/${SRCNAME}-${PV}"
+S = "${UNPACKDIR}/${SRCNAME}-${PV}"
 
 DEPENDS = " \
     python3-pybind11-native \
diff --git a/recipes-devtools/python/python3-opt-einsum_3.3.0.bb b/recipes-devtools/python/python3-opt-einsum_3.3.0.bb
index ce9d220..4aecbba 100644
--- a/recipes-devtools/python/python3-opt-einsum_3.3.0.bb
+++ b/recipes-devtools/python/python3-opt-einsum_3.3.0.bb
@@ -14,6 +14,6 @@ PYPI_SRC_URI = "https://files.pythonhosted.org/packages/source/o/${PYPI_PACKAGE}
 SRC_URI += " \
     file://0001-Use-ConfigParser-instead-of-SafeConfigParser.patch \
 "
-S = "${WORKDIR}/${SRCNAME}-${PV}"
+S = "${UNPACKDIR}/${SRCNAME}-${PV}"
 
 BBCLASSEXTEND = "native"
diff --git a/recipes-framework/tensorflow/keras_2.19.0.bb b/recipes-framework/tensorflow/keras_2.19.0.bb
index 3030f04..f6bcb03 100644
--- a/recipes-framework/tensorflow/keras_2.19.0.bb
+++ b/recipes-framework/tensorflow/keras_2.19.0.bb
@@ -9,7 +9,6 @@ SRC_URI = "git://github.com/keras-team/tf-keras.git;branch=r2.19;protocol=https
           "
 
 SRCREV = "a697e6a2238224a89e5cf53fb86fd4808b1b9133"
-S = "${WORKDIR}/git"
 
 inherit python3native bazel
 
diff --git a/recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb b/recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb
index 012ecc8..e9aee35 100644
--- a/recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-estimator_2.15.0.bb
@@ -7,7 +7,6 @@ SRC_URI = "git://github.com/tensorflow/estimator.git;branch=r2.15;protocol=https
            file://0001-customize-for-yocto.patch \
           "
 SRCREV = "b5f91f8e4113396f0a5f090d6a52d676271caf48"
-S = "${WORKDIR}/git"
 
 inherit python3native bazel
 
diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framework/tensorflow/tensorflow.inc
index be1ed11..8287032 100644
--- a/recipes-framework/tensorflow/tensorflow.inc
+++ b/recipes-framework/tensorflow/tensorflow.inc
@@ -27,8 +27,6 @@ SRC_URI = "git://github.com/tensorflow/tensorflow.git;branch=r2.19;protocol=http
     file://0001-do-not-patch-.so-files-for-linux.patch \
 "
 
-S = "${WORKDIR}/git"
-
 DEPENDS += " \
     python3 \
     python3-requests-native \

