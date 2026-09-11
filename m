Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E401C88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:03 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48458.1789157641471679963
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qo5KHlsx;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef19aso2897031cf.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157640; x=1789762440; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gx2QO2WtMzegYv6Y9xdSkwdjoxIjKdEJ6WHtXu/2LF4=;
        b=qo5KHlsxZ/oVLv7q/jFJFfnNJm6VxKK/EPUobtDAuDguEs5lvxbD8r3IWpgjO8KV73
         H4qrY4DF21PPB9/PkLH7PdzHvXFkGrJNYV1IibR3iAe6x9y7hAzmIbPrwQSuFQpRSIB8
         vkQIU/iuT14SCWuy+dq2eMhRWfBmJB+IZY2Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157640; x=1789762440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Gx2QO2WtMzegYv6Y9xdSkwdjoxIjKdEJ6WHtXu/2LF4=;
        b=WRxpz9mWiLumWo85uEvq31uh29+Syoj4LerZLwCAIFQbmje5uxDthc7uPM/r8hESSn
         nhAcPjJm0O4Vx6N50Jb1dp6PkD5JJq8EuuU6NMAg7N0SmZGf3R3KcHQg6yUJ5xXW1fIc
         tOivM5DS62dwSUNmgdbBsFYbT/ZHG71M8IAd395hH/b46BLINHs8Y3LmUbopJ4F+3C19
         KSpzIzvdmHRU5u104BkvWOOdWhT3TUPrXt7/0UTB8ozmnY12vyKLpl00qB7NqwUon+i6
         03n8C+IQzZNfww+GZxsMpmpn2f6PuM9i5QqxrFnPsWgXg4qR/5EnHsTIql7ighfGFoB5
         kdHA==
X-Gm-Message-State: AFuF++kZTToLEywzWfZz6qrwLYLOE1P3Extf1iUkidKQKaw2Ef8hrzM3
	03MNFuCsoVjhfHqx34vPkFqakLf1JL0ALLDyNT7aV9kt+vAPa5x9cEaZRtS35emUtGZ0NHUdW5/
	K6V/Q
X-Gm-Gg: AYBFou0naKuGjUvvSP7p5H6pKHepVXlFlo/MQq6bqs4L7dS/iSbwLPZtiLN11GtaQrr
	H86mKqq0Wp6uVoPdhU/OGzmmOa6Ts+3MGrQhBlx0CvQJpbwf3zLnaFpa8X+xWI8hYRSKnvkinnW
	RoE0tQtzNeA/B5+2UbKyFpqozrfVMB0Aj0bcqHC3zayhixXAC2RGOWhpQTjXuSojzOXXbqaiCQV
	14Up6dNcrM5hvANZgLHOY29ZeEocQVdsc1e57fDMXM7gf4JLjcJ6cbiPdd7CYHZYHtquAUwgvPA
	Ps2mDAwbJB4dswHZ3+blSMV5UkelpW4b1qSPdGFvNGMB46HB3jXUDYn9jS7lG/zR1DuO9E1GHJN
	Vqip89m41JA9pLuIWrBaSsAJjcwqsX7Cj0T3Nbq2pEoNxqe5jaai+Vsj77Sw24qDaNrHMba7YbL
	QryJzUEXxJh4slRjbqtbndXQZ5f0hREE0XMvHjLypv/Ju5/YioVw0/J0yvllWYvQk0pDTraETuZ
	XR7gJ6/xD0gX+yNg1Xsd630x9dkgx5WiGnsvzBrtZxd+p/MkOxYfSZY15NxT5lq76KGPkE5fjIU
	lEouwU+ARKYEDdXo02gia3oFvsNsI5KHAVNGxqv/X24WpLo=
X-Received: by 2002:ac8:7e84:0:b0:530:35dd:d6e with SMTP id d75a77b69052e-530c8525cc9mr89013131cf.7.1789157640250;
        Fri, 11 Sep 2026 13:14:00 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.59
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:59 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 23/37] classes/cargo-c: remove CARGO_C_BUILD/CARGO_C_INSTALL variables
Date: Fri, 11 Sep 2026 16:13:09 -0400
Message-ID: <56402e77fde9534bca5572890c6d4f32bc2eb0bb.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4789

From: Ross Burton <ross.burton@arm.com>

There's no point in having variables to control what cargo-c binaries
are executed as there are no alternatives.

The cargo class does this because it is used when bootstrapping cargo.
This isn't needed to build cargo-c, but the pattern was copied into this
class.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 89e986af905d72ebd408aeb4b05e8cb965579e1e)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_c.bbclass | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/classes-recipe/cargo_c.bbclass b/classes-recipe/cargo_c.bbclass
index 18574b7..e68ac93 100644
--- a/classes-recipe/cargo_c.bbclass
+++ b/classes-recipe/cargo_c.bbclass
@@ -11,10 +11,6 @@
 
 inherit cargo_common pkgconfig
 
-# the binaries we will use
-CARGO_C_BUILD = "cargo-cbuild"
-CARGO_C_INSTALL = "cargo-cinstall"
-
 # We need cargo-c to compile for the target
 BASEDEPENDS:append = " cargo-c-native"
 
@@ -25,16 +21,13 @@ cargo_c_do_compile() {
     oe_cargo_fix_env
     export RUSTFLAGS="${RUSTFLAGS}"
     bbnote "Using rust targets from ${RUST_TARGET_PATH}"
-    bbnote "cargo-cbuild = $(which ${CARGO_C_BUILD})"
-    bbnote "${CARGO_C_BUILD} cbuild ${CARGO_BUILD_FLAGS}"
-    "${CARGO_C_BUILD}" cbuild ${CARGO_BUILD_FLAGS}
+    cargo-cbuild cbuild ${CARGO_BUILD_FLAGS}
 }
 
 cargo_c_do_install() {
     oe_cargo_fix_env
     export RUSTFLAGS="${RUSTFLAGS}"
-    bbnote "cargo-cinstall = $(which ${CARGO_C_INSTALL})"
-    "${CARGO_C_INSTALL}" cinstall ${CARGO_BUILD_FLAGS} \
+    cargo-cinstall cinstall ${CARGO_BUILD_FLAGS} \
         --destdir ${D} \
         --prefix ${prefix} \
         --libdir ${libdir} \
-- 
2.55.0


