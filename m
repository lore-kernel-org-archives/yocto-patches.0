Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58AFC88E62
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:06 +0000 (UTC)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48460.1789157643511021411
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ENFrLRkg;
 spf=pass (domain: konsulko.com, ip: 74.125.230.140, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db09so4148316d6.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157642; x=1789762442; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1UkpiKxr7ZszTbINOZ8e5oxFSIGoxFxdn8niq7G26eo=;
        b=ENFrLRkgWFdp3kEKkfNzG44bicQXmGzxJLuUoRarUlG9+P/rgbyyqmL9tuj80/VGVD
         2HAXyerBP+xH1Cec0nQyUGKGsFrPoirx6ZNko+p0oMbEHFSWL4l22t/19J3FJY8foIS1
         FTkjlwwjOA2TJ3DxyMtpKMlwkZhISZxGUoelQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157642; x=1789762442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1UkpiKxr7ZszTbINOZ8e5oxFSIGoxFxdn8niq7G26eo=;
        b=VsJWLoOFERouizUUiqZ5ZexOhmT31SW60pkG+64JzCChBMpg1G+QWocJ8I+otsVJn0
         /FleP3mwSVUvCjFdCCyQCe8sH3uzAAEm20y3Qv1pWF5LI6bfWOyAZJMBbao371B8HzAT
         uPuTATzO7BffEpqrOhNgaUV6NpORFHga7E15vidcLwnWVYMjKPRM9CZEFAlEWdIzNCdg
         PJ5CJ5hmW9Ty/fA5Qt7u/VP9wt4oCIG3IkjJYA1g1PMlYSKQnFMrihrUYMXLfU98FsJc
         THXyzTHYYHGRM7WST09Um0bDd8qfJpGmUJmKxGwjyNxjV/RF8Zy8tWxhTKSn0tF9hq3e
         Cm2g==
X-Gm-Message-State: AFuF++kSCMQBaIx4TexjHtLK9nFS4aY3xGsor5LUHfIJt+JFXc+sG6Wh
	+eFbinhtzV6b5UEEIXff1UBDC2e41o449Z/UJJnUr5civ+k0KQBCrYBMIXcfGvEpoKrIilFosnz
	KG88p
X-Gm-Gg: AYBFou0Acp2LNJTNF10+L20bxJSvhIyDmnZIZDsDlkH7gz/ebTsEZvDAM7PAJoQoAvp
	Jk4FAkDpz6kk+OzzktACPtQWXR8uaX0REMvMrp0SXOn2m6eTTLVufPrDSpZsZh2/TSkO+We7+C7
	qwlGgtbGXi9aQOq0/k8RWZgrPbZf3YW06rf5zl8Ynx2ZfnLc9hXXtrfjc3Sq5U22LbVkcw3C+cO
	SZohj5j574T2BiD/vtx7o9UEtTocPLBGfwtfFcm0kT//x7yM1E1tjqXjPaM6E7u4k3pBidS9HsS
	88EyE2vnCqHTMqcosfbQAR6PnD68cp75GIuoh+TcCjPXFkVnV185C7BTbeuEJky8s3CfGgStAt7
	OuqOpC4qQFKXGG/avfHv84Q3O6qBy5MvOA1mw8xAHJljQ1nuLFbVmRkLfNvOjrzTnnthP3Nkw48
	JuHT/2bjGIyPcoo7PaLPsdufC2chIZ8i2CSPhpmTl1ZdeGRxrHMEuc6oAcxbAkmGbPrxGLAcgE/
	CP5h82GJ6tygr5FEZefRbKyJt2G8qVjNzxqts5rl9dFldbVjDJh4Y1Cn/FUXhdiHrDfbOTvJGPi
	sUVTssyWbDzVDqciQ98jc7g3vWquQKjLkC4=
X-Received: by 2002:a05:622a:190e:b0:530:de1c:bf23 with SMTP id d75a77b69052e-530de1cc445mr49266111cf.39.1789157642267;
        Fri, 11 Sep 2026 13:14:02 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:01 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 25/37] classes/cargo: merge oe_cargo_build into cargo_do_compile
Date: Fri, 11 Sep 2026 16:13:11 -0400
Message-ID: <4c195f6dd000231e5c7797cf0d9202b6339f861d.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4791

From: Ross Burton <ross.burton@arm.com>

A layer of indirection between cargo_do_compile() and actually calling
cargo isn't needed, so merge oe_cargo_build into cargo_do_compile.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit a64ac03a6146555f1847cdf43e3f86d14f6e506d)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index 628dbc9..5860719 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -17,7 +17,8 @@ CARGO = "cargo"
 # Enable build separation
 B = "${WORKDIR}/build"
 
-oe_cargo_build () {
+do_compile[progress] = "outof:\s+(\d+)/(\d+)"
+cargo_do_compile () {
 	export RUSTFLAGS="${RUSTFLAGS}"
 	bbnote "Using rust targets from ${RUST_TARGET_PATH}"
 	bbnote "cargo = $(which ${CARGO})"
@@ -25,11 +26,6 @@ oe_cargo_build () {
 	"${CARGO}" build ${CARGO_BUILD_FLAGS} ${PACKAGECONFIG_CONFARGS} "$@"
 }
 
-do_compile[progress] = "outof:\s+(\d+)/(\d+)"
-cargo_do_compile () {
-	oe_cargo_build
-}
-
 cargo_do_install () {
 	local have_installed=false
 	for tgt in "${B}/target/${CARGO_TARGET_SUBDIR}/"*; do
-- 
2.55.0


