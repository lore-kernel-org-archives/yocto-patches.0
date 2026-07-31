Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5F2C5516F
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 11:33:55 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4482.1785497629196468803
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 04:33:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YJdNHsIO;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92f0b5ed131so63856285a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 04:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1785497628; x=1786102428; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mvE3v3unKGT9ewq1yXhLtZcZgznCcW+eSiMfpuN6klU=;
        b=YJdNHsIOpMcV6qCQOLOYOeyMTAoBOLsk0zM9ztjq/dYUT4RKP2LdtH+PR0ngbkYQ1S
         KqWy4mnJQW+PsJHjrR0Ih5pv54kMe20SsO/d3fuMjutXGxpYlfVjw5i7tsfeihM/y08m
         FhG1mwlWL6usIId+BgNZRh7l6pTGc4b5v3VKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497628; x=1786102428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mvE3v3unKGT9ewq1yXhLtZcZgznCcW+eSiMfpuN6klU=;
        b=en8WjW+d59Uyce0iJ2NqToY5DcWeVRT9yckYojd8kyOufOf49EgTFT+LDN3iOM6CFk
         7h+mQoDvLb1FKQ+nmorks3cEJQFUgnm8bsUtKWcwXtNQxdzHr9Nf8sqZnOjpVhtSpzp0
         qgr6PbEjzah2lI7dmRcl+Y2O0gs8yp/nv8x2Iv6UBmKzSsowM71joN/2vfvbrfNIi9Hm
         wtrTXEUZswXf3HOKeip9NWyAmZstGtCQGtnJND0ZhcB1ih3iae70TKGIeKAObiuoX2bf
         RVqzKHV9+ej5S/ObImaHBmIc5g/WLfLtVf56SJufmIbcHoATnhlqr4yKXT2jsyDqN0fL
         cEMQ==
X-Gm-Message-State: AOJu0YzHaeZXngB9JCMexxn/ZqWycAah7SLvuB16asovJVJIlmO/T/Q9
	ERdIbs9u1uD3KEQm9HMdjlK4yJ3Fg5q/2w8A98AEFAUns9fVG6fUQKjmSzbrjwlBsh4lxd/YXyd
	Uwelv
X-Gm-Gg: AR+sD105dtxVkUkZOceGW0PGw4YG64gngbnkVoNbUSm1gfCxCmpMtZCA1FMzKkrNDMz
	1x2Y7AwXeWgjja2L9Na/FHOWR/UCjCfSKCTVq3d5FxM2CgWP8ZGFWnDgln4Dbzw67GwbZAzOQPW
	aUboKVkKwLcA6kyMpyfHtOXivYlRStTCQVhNrC6yIy6TMZ33SKHKCBcyZMQxs+l/ToywEtH8sIA
	Xc1LNimBzYXs+Ch2RIPyNowOt8qjwbqWPbhwCJ2/r+oVsXrRclqiL6nRUJ9lHBgrmQnHeiEB/Tq
	4mVXs7D33uYBSpFi2D6sxYf9JuJ9aDecf5OHiHWxKWfGrc4Ls7Ah/nMF2gLiaTTybwY1qpBvROD
	/TWCa5dQ4yEJOGSLM6J+WT/fH2iM8oXQHVgp7ohHWKE9+LhvVYumjyCEOUvrO7PS5w8fuywQALT
	xUSs6v0XL/Zlbe8NZw5bhJfSdOW6fPp/92d5BKDcSpInkMH+xk8xTEteSeq/yQ+H+vM9+IR01Mo
	lmCAAKwLXsA94JbGfKWBmws8SNyPCXDKDxmnYYneKWVSFNBT1XFdu/VJHWubzjKo/CJaE17G1zC
	hcQjCrkZ7tPACSI+GjkyaoPGbA==
X-Received: by 2002:a05:620a:440a:b0:92e:fc45:3472 with SMTP id af79cd13be357-9349ab4837dmr148362085a.29.1785497627908;
        Fri, 31 Jul 2026 04:33:47 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1c1d0esm35560585a.33.2026.07.31.04.33.46
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:33:47 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 35/35] classes/cargo: remove BUILD_MODE, replace with CARGO_PROFILE
Date: Fri, 31 Jul 2026 07:33:05 -0400
Message-ID: <9987a76095ee751864e55e418539f42b9c3b8a6b.1785496469.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785496469.git.scott.murray@konsulko.com>
References: <cover.1785496469.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 11:33:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4611

From: Ross Burton <ross.burton@arm.com>

The BUILD_MODE variable appears to be a way to select the Cargo build profile
that is used, but it can't be assigned because it and other pieces of
code base their logic on the value of DEBUG_BUILD.

Instead of a BUILD_MODE variable that is "--release" or "" depending on
the value of DEBUG_BUILD, replace it with a clear CARGO_PROFILE variable
that selects the profile to use. The default has the same behaviour as before:
either "release" or "dev" based on DEBUG_BUILD.

This profile is then passed to cargo, and used to construct paths in the
build tree (with the caveat that the "dev" profile puts files in "debug").

[1] https://doc.rust-lang.org/cargo/reference/profiles.html

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d4de7d0256aca47cdb1df48640c37221deaa09d4)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index 8e05a82..b34f3ce 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -31,18 +31,28 @@ B = "${WORKDIR}/build"
 export RUST_BACKTRACE = "1"
 
 RUSTFLAGS ??= ""
-BUILD_MODE = "${@['--release', ''][d.getVar('DEBUG_BUILD') == '1']}"
+
+# The cargo profile to use. Defaults to release or dev based on DEBUG_BUILD, but
+# can be set to any valid profile.
+# https://doc.rust-lang.org/cargo/reference/profiles.html
+CARGO_PROFILE ?= "${@oe.utils.vartrue('DEBUG_BUILD', 'dev', 'release', d)}"
+
 # --frozen flag will prevent network access (which is required since only
 # the do_fetch step is authorized to access network)
 # and will require an up to date Cargo.lock file.
 # This force the package being built to already ship a Cargo.lock, in the end
 # this is what we want, at least, for reproducibility of the build.
-CARGO_BUILD_FLAGS = "-v --frozen --target ${RUST_HOST_SYS} ${BUILD_MODE} --manifest-path=${CARGO_MANIFEST_PATH}"
+CARGO_BUILD_FLAGS = "-v --frozen --target ${RUST_HOST_SYS} --profile=${CARGO_PROFILE} --manifest-path=${CARGO_MANIFEST_PATH}"
+
+# The build directory is named after the profile, apart from the dev profile
+# which uses 'debug'.
+def cargo_build_directory(d):
+    profile = d.getVar("CARGO_PROFILE")
+    return "debug" if profile == "dev" else profile
+BUILD_DIR = "${@cargo_build_directory(d)}"
 
-# This is based on the content of CARGO_BUILD_FLAGS and generally will need to
-# change if CARGO_BUILD_FLAGS changes.
-BUILD_DIR = "${@['release', 'debug'][d.getVar('DEBUG_BUILD') == '1']}"
 CARGO_TARGET_SUBDIR = "${RUST_HOST_SYS}/${BUILD_DIR}"
+
 oe_cargo_build () {
 	export RUSTFLAGS="${RUSTFLAGS}"
 	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
-- 
2.55.0


