Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3056C88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:05 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48456.1789157639289190732
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hhJXKU7s;
 spf=pass (domain: konsulko.com, ip: 209.85.160.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-530d8021e97so11264311cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157638; x=1789762438; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fiGTFVQ1+/wEjk26ulNllD5/dz2yQMbBgHJJTctSQ/w=;
        b=hhJXKU7sVEdVs6MCAsEikU7AATsAA2Iinzsw+gARFCGbuuGKmxanG/HzRZSiqqPQw9
         thLCY4dBvqC7lfxm90uikPx+ibiOz2F4M73yTlaYASTNOXp1a/ltwxizD7EWWip/SuZj
         +X2N/Lmn74cn1+3Us/5+XhUPRTgFAdBn1/Ooc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157638; x=1789762438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fiGTFVQ1+/wEjk26ulNllD5/dz2yQMbBgHJJTctSQ/w=;
        b=OKlGMUkHi8m0o+aBJR+qrQkaod+ZvSzDnt/bvU7hY/oAkh8ilTTip1vGAXLiZUyovo
         8xUdhUBLrhjdqkZK4EK/pgajB/DZYKuEHr9d9bAztFnLSK3SAmawDqIpsEGDqyGzwRbO
         9K1KJm5JaAZ07ImYXycRt36StCKCy5/tNeRzuPbL7enwvPPVb5q6HCFHLQrsq64p/1la
         B/xUcWuPlKBv6GLriP9r7n8Dx/VPntAmbQ2/JfyU24DsCSsfxgZvZJJLOP6ubj7NH+6C
         kdwetENW7TPCbTnbPLfrW/QkfCeCBW9q1kfHIkfu8kHW4Xt0SNIkS6q4ulK61XP8OGHA
         X0sg==
X-Gm-Message-State: AFuF++lADlqjTEIrNAWs5XOUdDb5Y53/64ixDpFCrzjE26BHg0sLIpvh
	x+zauyGr/+d627AHXHIdx131DjsoHfbRfFLl/GlqPt5U/iIHobby+V96C8cXOKMMAhLL6t3eJu4
	WSWwp
X-Gm-Gg: AYBFou0MdnGsyCzx+LEZ4jofhp2MCh3fGYuRIILeurAT7Lz+5gA/IQ5ef+n5pokweA4
	rOTrogs4Ufv6U9OKqP/r9PwA6tKChsSzEx7P82ANVzRNHQB6gjgF4kTBRDsJXVT6bkfmlIiqltF
	synuAw1GV0NvtqujjSXuQzs5/YBb9o7ejV/xKXybh+Ovmv1Vl/m5F/xBB0RUHuAh8PzM/7z23u6
	VE7tio/3JuvsHcSehauQy8B+x9GtcWsxQM5ESkw/0adAOtY4NX23J72BPmwuwgkvoSWB/RErYR1
	5N1ZtWnrogoWiQQc+2kY0U4jkk3JH9KeKvKFnhSz98K5YHyWacJJjnPZn6QGcNnm2V743XEDqxG
	iuHi4L2thmKB/WeidR3j21kzcY7ux0HpbiUJE/iA8Y4h2Wnfob1mvpZG7eDoS3ZQIi8UcH8grJl
	SuM98W3AHyE845eHY0a26J2rXCGXIhIZ2jl/BOaJWkLOtoe5U922tFTjZlTk2ul6VPSmq1af/iL
	DLMPfvzd8LePw+C/A9+d62nlDX4YAh2l+hbMEe0cVmgvgaKRPoYC241DeGa9RqR4VViEdgqAjYS
	JyNfsUivW1keO/KBpZAt6j37+rgQbxu+iNQ=
X-Received: by 2002:a05:622a:6203:b0:530:b2e1:2f43 with SMTP id d75a77b69052e-530c87810a6mr86959851cf.58.1789157637916;
        Fri, 11 Sep 2026 13:13:57 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.57
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:57 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 20/37] classes/cargo: consolidate dependencies
Date: Fri, 11 Sep 2026 16:13:06 -0400
Message-ID: <02d3284c65d879f0bad2de56d9b61ad0eb199288.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4786

From: Ross Burton <ross.burton@arm.com>

Move the dependencies from cargo to cargo_common: if cargo is being used
in any way then you need to depend on cargo-native.

Inherit rust instead of rust-common or rust-target-config: rust inherits
rust-common that inherits rust-target-config, and rust.bbclass simply
adds the dependency on rust-native. This means we can drop the explicit
rust dependencies to avoid duplication.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit d539873ea3480d39a0d5d14a8403ed979f62be48)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo.bbclass        | 9 ---------
 classes-recipe/cargo_common.bbclass | 4 +++-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/classes-recipe/cargo.bbclass b/classes-recipe/cargo.bbclass
index 31e6556..628dbc9 100644
--- a/classes-recipe/cargo.bbclass
+++ b/classes-recipe/cargo.bbclass
@@ -10,19 +10,10 @@
 ## Cargo.
 
 inherit cargo_common
-inherit rust-target-config
 
 # the binary we will use
 CARGO = "cargo"
 
-# We need cargo to compile for the target
-BASEDEPENDS:append = " cargo-native"
-
-# Ensure we get the right rust variant
-DEPENDS:append:class-target = " rust-native ${RUSTLIB_DEP}"
-DEPENDS:append:class-nativesdk = " rust-native ${RUSTLIB_DEP}"
-DEPENDS:append:class-native = " rust-native"
-
 # Enable build separation
 B = "${WORKDIR}/build"
 
diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
index 6022fda..5bf9dc5 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -15,7 +15,9 @@
 ##
 
 # add crate fetch support
-inherit rust-common
+inherit rust
+
+BASEDEPENDS:append = " cargo-native"
 
 # In case something fails in the build process, give a bit more feedback on
 # where the issue occured
-- 
2.55.0


