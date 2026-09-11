Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519F9C88E61
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:05 +0000 (UTC)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48455.1789157638070844360
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mBtSiP7D;
 spf=pass (domain: konsulko.com, ip: 74.125.230.140, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0bso4429766d6.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157637; x=1789762437; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oRX9ojoeHeBjqX8OO8q25t4zNUdegdatJ1nB9KNgIo0=;
        b=mBtSiP7DsIcksD5hwgNc/p2WUvvI3Bob9up4960UtHic8Z6ttORgenE0AhTcyTp9S2
         K8ywY3sa35mYh8TYAXDdTmaKnfoYNGPqE7GVOym/FR8iKZcSKtTakYjUro297rfxJswv
         J0tcOOOZPzv7riCUVdD56dArAHjd/ccuPe5bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157637; x=1789762437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oRX9ojoeHeBjqX8OO8q25t4zNUdegdatJ1nB9KNgIo0=;
        b=h0HIPPDgOSTNaNdt2Mn5IIp3HeBGIFLppBVzWAmkqEK8c8RI3WP1diQcv8fRXqlV4G
         jngIBy7rThFaNu9pi5VTmy0Jf5RQ471YfQcAA4+TldoFJcSSIiqR6G6KQumm5JF+S3dX
         frYiD4SmlEK/uyi8NB22K6A+Ued8l0ujoyuN5Cvohl+02g6G/Y1dubEz5vDyrkt/AZFA
         DxHnltLy/4jR8pH5ptPE/Tvfzx1BhSIzzLAsUvAgfyT+tOg2iuNV49ccqBykVPEx4SqM
         QqnIOv3Hw//AT1RQ4advyYPNMxHDUKZ1jFnPcP4WFkIXCcdng+C6AiummFzFzrf7T7mY
         k7mA==
X-Gm-Message-State: AFuF++mZtknvvOuVY+a9MjlcxIEwMpLXX0gnSZ3pWlg8Gs2BWthl7O2I
	kSh4nqEaCKFzNvjEkSO4ffpPoqgm9xpq7qVyVEybK9SU0huJFlS4L5AfYCs2dyH1hxL7Ds1fn7b
	OKBMp
X-Gm-Gg: AYBFou07712Q+3LvGo8hvC2tTrZ8CJpnmLshpEzb7N1/s4q4OWvVM9h+Y0L3TycLZoN
	dPsT2ZkctXnZ8VwE6y1y8z0984kjln5a0g9wHD2yvXnLE4jkbxcHT90AIj9PFtdBgouZzIvfOtc
	0RflpcIjIy0vrto6eevxqk3RqhVP5gJNzc9P8r6lAW0cgc1JJdaaq3ciISfjXVOLpJdX3KGzKkF
	4zwJ7aUmNazuOXwEsmA07Drl7pkJca8LY4fDneEm75++bKL5UQAETtNvC9nHD8Qfo7J50TMCAmO
	D0le65ptSEHs3e4rRL41LtFlZFY+x02f/rLSkNmrptZP45rLWN3QwZdBnlOId762FMbcOclqsim
	j0SoKFCgrIZs7z8j87OC3zEu5wsUeOM45MEYtjDi/shdmPHx/5eyCCurRXJPrt4+8rC3Ynbvg/7
	nkxefG4i2zCCQnL6GPcuLEI0SWQ0JK+JRcuLsJJN89JTFFfUpXUqsVPES3PUE1Xebtp5et8RcWz
	1b1pkJBuFzSwxw7hGMEOhJ5junCrtbBcKmPAmS9ba4G5jbi0LQsg7jyXJttwWE7plYWAaKzk/el
	cX3AHlB1L9TeqZbfYB9tidUnEVXcW8DSTgg=
X-Received: by 2002:a05:622a:a6d2:b0:530:d429:c70a with SMTP id d75a77b69052e-530d429d7e6mr56516041cf.26.1789157636838;
        Fri, 11 Sep 2026 13:13:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:56 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 19/37] classes/cargo: move general assignments to cargo_common.bbclass
Date: Fri, 11 Sep 2026 16:13:05 -0400
Message-ID: <1da98ac98da17c621ae76d32a95d9158964346b2.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4785

From: Ross Burton <ross.burton@arm.com>

The cargo integration is split into two classes so that recipes can
inherit cargo_common if they can't use cargo directly to build, for
example when using meson+cargo or building rust itself.

However, a number of variables where in cargo.bbclass when they should
really be in cargo_common.bbclass: move the assignments so that the
cargo.bbclass simply inherits cargo_common, sets B, and implements the
compile/install tasks.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit f654865f70fd535d1125819e825b8d627a949948)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass        | 27 ---------------------------
 classes-recipe/cargo_common.bbclass | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index b34f3ce..31e6556 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -26,33 +26,6 @@ DEPENDS:append:class-native = " rust-native"
 # Enable build separation
 B = "${WORKDIR}/build"
 
-# In case something fails in the build process, give a bit more feedback on
-# where the issue occured
-export RUST_BACKTRACE = "1"
-
-RUSTFLAGS ??= ""
-
-# The cargo profile to use. Defaults to release or dev based on DEBUG_BUILD, but
-# can be set to any valid profile.
-# https://doc.rust-lang.org/cargo/reference/profiles.html
-CARGO_PROFILE ?= "${@oe.utils.vartrue('DEBUG_BUILD', 'dev', 'release', d)}"
-
-# --frozen flag will prevent network access (which is required since only
-# the do_fetch step is authorized to access network)
-# and will require an up to date Cargo.lock file.
-# This force the package being built to already ship a Cargo.lock, in the end
-# this is what we want, at least, for reproducibility of the build.
-CARGO_BUILD_FLAGS = "-v --frozen --target ${RUST_HOST_SYS} --profile=${CARGO_PROFILE} --manifest-path=${CARGO_MANIFEST_PATH}"
-
-# The build directory is named after the profile, apart from the dev profile
-# which uses 'debug'.
-def cargo_build_directory(d):
-    profile = d.getVar("CARGO_PROFILE")
-    return "debug" if profile == "dev" else profile
-BUILD_DIR = "${@cargo_build_directory(d)}"
-
-CARGO_TARGET_SUBDIR = "${RUST_HOST_SYS}/${BUILD_DIR}"
-
 oe_cargo_build () {
 	export RUSTFLAGS="${RUSTFLAGS}"
 	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
index 998c6cb..6022fda 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -17,6 +17,35 @@
 # add crate fetch support
 inherit rust-common
 
+# In case something fails in the build process, give a bit more feedback on
+# where the issue occured
+export RUST_BACKTRACE = "1"
+
+# Flags passed to all invocations of rustc
+# https://doc.rust-lang.org/cargo/reference/config.html#buildrustflags
+RUSTFLAGS ??= ""
+
+# The cargo profile to use. Defaults to release or dev based on DEBUG_BUILD, but
+# can be set to any valid profile.
+# https://doc.rust-lang.org/cargo/reference/profiles.html
+CARGO_PROFILE ?= "${@oe.utils.vartrue('DEBUG_BUILD', 'dev', 'release', d)}"
+
+# --frozen flag will prevent network access (which is required since only
+# the do_fetch step is authorized to access network)
+# and will require an up to date Cargo.lock file.
+# This force the package being built to already ship a Cargo.lock, in the end
+# this is what we want, at least, for reproducibility of the build.
+CARGO_BUILD_FLAGS = "-v --frozen --target ${RUST_HOST_SYS} --profile=${CARGO_PROFILE} --manifest-path=${CARGO_MANIFEST_PATH}"
+
+# The build directory is named after the profile, apart from the dev profile
+# which uses 'debug'.
+def cargo_build_directory(d):
+    profile = d.getVar("CARGO_PROFILE")
+    return "debug" if profile == "dev" else profile
+BUILD_DIR = "${@cargo_build_directory(d)}"
+
+CARGO_TARGET_SUBDIR = "${RUST_HOST_SYS}/${BUILD_DIR}"
+
 # Where we download our registry and dependencies to
 export CARGO_HOME = "${WORKDIR}/cargo_home"
 
-- 
2.55.0


