Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2745.1795806465230054130
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Nov 2026 11:07:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre.com header.s=google header.b=PLoZfL6G;
 spf=pass (domain: baylibre.com, ip: 209.85.221.41, mailfrom: ddrake@baylibre.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4ad6219f7d8so7619072f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 11:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795806463; x=1796411263; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GYtfUfYULAJcqMSwfW0WMWtGxzMeuePyEbFlmg3aF3A=;
        b=PLoZfL6GS+m3z0T/iJqTbKKnzPv1gc/Wsh4RSqy5qLMGMokP9se6IeHaQXo29jlw7d
         +kekydWsGCTXiSMLP/Tsw7kgLn0KXx53TRIyEK7mK6JaJYQGSp068+3XgIKrSe5E9z6a
         EoNEbTxSJyPCNIjj4JXiLJAL7tlYkwk054ryKXoxY0UWnUjeJHLihNcemOvOYkXeW85O
         PzjS5j5qyTw2Eh+RzVP8AHW+VypQpjBFCFBmwgpNNxHPmVR3O0ITNcW2L46aM5Zk3omh
         bDsl0rqtpyuLDnDnMOl8hkraSU4Nr0DMWPQsNZwaiwM1ChOOmJ1k4917QtyMfm8EMpDB
         ZJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806463; x=1796411263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GYtfUfYULAJcqMSwfW0WMWtGxzMeuePyEbFlmg3aF3A=;
        b=CLSABE8pANAqq8ngvgOrmtaqAUo+eo/z0AFPpgOpUuE0Zuc1BXCKf7I3+qGcVs8rC+
         +4sX+1/xg8m3JYoLnzT0dNUjILtQyz0lveY5AG81B1dnlcWOy8DFfwm/MK9denxKL7gQ
         ZW+bz2TR33ab7tU/3wjwwh+0Xn+K2+/P3fQn+iY8EvuiqY2/LqYFpvlcIYB5bjhHehaw
         wv1KfGQygFqUvNmJ9AAbR6X/r1J38AdIeyScp7287WcH2MvDDgBBfw8oNrJIqqgCR4tM
         wpGJw6KA8Ze9nyYuHKGY6H++4AoAbS5EJLXi7Is9k5XwWArXjVgFJtwsP081aR/cbrVY
         qnTQ==
X-Gm-Message-State: APuU4Z/ogAq7Lwr290nmMmwPKU0SIgOX6CcFg2+myGsxnj5p9j4CNZRm
	b0LrJhfvS2w7VkzMKG0NTPB67gclE8OrRJZmz1uJw4zYacfFTk/EDk1PbfsdAdJ5O48T6HA+wOZ
	3JfI7sVo=
X-Gm-Gg: AZFdTZfZzgiScW/98K31nIyFN5iI5a5nnqGSWLFejGI5s/jZdisuwYDOP5doMWfe0mw
	kCPlIJWhs14zk2btkefcdfuNWM8h2+6byUe48hkvQKapCGleK7yZIy9qiSScGM1MAF328xKyDJA
	qOINDMic3MHG1IY5E2RtcEyCgrQppRwyNwIMTOJGtiZdNDc23o9ca90MIOR7GuWxZ09u2QOIn1Q
	ZqYiznspty4PBwFeMVe8TVo241rXgjd8mLaXxIz/WYUhxK5CBBW15S0gf3QQJJXNawLpmSKhmow
	ueB2D2uSj+N5TCIFqxH3QGSBeDdWJaM2c6HIXwtZ64TmpdB3eAuubZz6Tj+8FsqVANGcp10bGzn
	k8y9Rju3JMpg3qlNb5lYywiRuaduR8hBU4h+lZuLEq1QfzFVVtCVAbOULhjZuqbbY0QjNVfRNT4
	mMf6tmLwJ3gCUcTN0Npbu+LcBkOxEcxY1E9VRfrXbtOtUnbeYtsVzM5dawLoyEPbHsJTit3d8kS
	mkenpCL6MqhqBPWZ6PIJgWYUy1fw8mzpiWziZCFMMYmHebUeGB4wMzSp18ol3DdLgBEQZmOGTYX
	0mtACRhyl/5ABtxsnoZMATvkFZ0=
X-Received: by 2002:a05:6000:4705:b0:48f:c4fb:6bb6 with SMTP id ffacd0b85a97d-4abb400bb83mr49298319f8f.12.1795806463422;
        Fri, 27 Nov 2026 11:07:43 -0800 (PST)
Return-Path: <ddrake@baylibre.com>
Received: from numbers ([2001:8a0:d6cd:9000:86f4:4e71:9fc8:3183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb989eesm48619067f8f.50.2026.11.27.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:07:42 -0800 (PST)
From: Daniel Drake <ddrake@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jiahongxujia@163.com,
	hongxujia83@gmail.com,
	Daniel Drake <ddrake@baylibre.com>
Subject: [meta-tensorflow][PATCH] tensorflow-lite: pass TF_PYTHON_VERSION to the pip package build
Date: Fri, 27 Nov 2026 19:07:11 +0000
Message-ID: <20261127190711.316659-1-ddrake@baylibre.com>
X-Mailer: git-send-email 2.56.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 19:07:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5554
Content-Type: text/plain; charset="utf-8"

Since openembedded-core moved to Python 3.15, do_compile fails in the
second Bazel run, started by build_pip_package_with_bazel.sh:

  HERMETIC_PYTHON_VERSION variable was not set correctly, using default version.
  Python 3.15 will be used.
  ...
  Error in fail:
  Could not find requirements_lock.txt file matching specified Python version.
  Specified python version: 3.15
  Python versions with available requirement_lock.txt files: 3.10, 3.11, 3.12, 3.13, 3.14

The first Bazel run already sets TF_PYTHON_VERSION=3.14 but the 2nd run
(pip package build) falls back to the python3-native version.

Use ${CUSTOM_BAZEL_FLAGS} to consistently specify Bazel's own Python
3.14 for both runs.

Signed-off-by: Daniel Drake <ddrake@baylibre.com>
---
 recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb b/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
index 4951fbc..8e31f16 100644
--- a/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
+++ b/recipes-framework/tensorflow/tensorflow-lite_2.21.0.bb
@@ -63,6 +63,7 @@ export CUSTOM_BAZEL_FLAGS = " \
     --crosstool_top=@local_config_yocto_compiler//:toolchain \
     --host_crosstool_top=@bazel_tools//tools/cpp:toolchain \
     --platforms=@local_config_yocto_compiler//:linux_${BAZEL_TARGET_CPU} \
+    --repo_env=TF_PYTHON_VERSION=3.14 \
 "
 
 do_compile () {
@@ -72,7 +73,6 @@ do_compile () {
     ${BAZEL} build \
         ${CUSTOM_BAZEL_FLAGS} \
         --copt -DTF_LITE_DISABLE_X86_NEON --copt -DMESA_EGL_NO_X11_HEADERS \
-        --repo_env=TF_PYTHON_VERSION=3.14 \
         --define tflite_with_xnnpack=false \
         tensorflow/lite:libtensorflowlite.so \
         tensorflow/lite/tools/benchmark:benchmark_model \
-- 
2.56.1

