Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238C2C88E5F
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:05 +0000 (UTC)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48525.1789157637271427726
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:13:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hwgSvY67;
 spf=pass (domain: konsulko.com, ip: 74.125.230.140, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso4363406d6.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157636; x=1789762436; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p47NjeBCqM9/cj7La+zUQrZlr+A3/8iE4r3Aizn5Qd0=;
        b=hwgSvY67J06bMOaPFnWWcKd01qem79rqpo8t81f1VwvtxkKbca4OxgtKepXnPlHogY
         TQKn85iaS/K+nclnleDPlKMorLRnsI+k8FiPq+x3IRbThex7ObI88AMO7d/FjSPkobwX
         ctUdFXj3s1uHv0nQcdNYuoGEbd9YcSDkZoppM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157636; x=1789762436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p47NjeBCqM9/cj7La+zUQrZlr+A3/8iE4r3Aizn5Qd0=;
        b=UqpU/qtIC7T9YW03Y1VRo2FTfgUI3bdUBKEacv7PUTFVI0UNGw2miEFabImfuWEEFz
         08VOfBMtur3e2bXlbNE4xnY3NFiXd9k56MJdvcReI5yY+vXye/VgUIKMBOUyNpnuWE/e
         3FOLJJWodrrH+tMrBZXXqT+4mHrXYpMbwC3mn9YVZRBCGBBdSRUIiSTIO5/o5iTpp5co
         K1IPdxBdxx/V/2RlEod4FmXcJQurdvKCLDycDXLp1YVFNyyV5wxUCWptej264+ucJaH9
         DNMaGIanrtJf3eWj9CtWGNKAwNFrwLzQWVNti/DyFBmXVsT1WFDcPoAtOQcoEGJxTrpu
         A78A==
X-Gm-Message-State: AFuF++ls/LksDBtLjpWo5p0rN06/RnxmMu3c9m2fA5j8lOF+dobBN3kt
	Ux/YN7nhgt+mmLjHoKCAA7qqUpPYVC8ie3gas+yZb5NCpXOhAF75cEQsytf1CnySNCTdz8ZMUic
	q20LX
X-Gm-Gg: AYBFou05G4UIWAux3tjHgDYr1vV7eZcz64RQKpTxTaxDmgkhkCpD3L36cG1f082rFRr
	93pC0MkJmwC0xy0il0F5K0vWRuu7CCSj58tNpKapaSB4fsmOQQd4fkhDSSqEtBZXYM8Xv+YwamW
	ZqVNI/4Gviolc/oP8yt3zFlvutW3sRvxAyjSAcxew9QNymtjoHGx0YaLbWBWWM9W8WKHO96qeaV
	OrugscfPgOA41qZ9d4qTTKDZ1jZJjhrdGF1n1naOmMeTN0/prlkdSGZevyNgh1IbPxJ7x9LPX5A
	UArp5lWpcIO79sEhmCg6M0v/Ek+7fiXpDEJP0nL72D9DaxQFwhvdDQqGih8falOrn8HEzhcF2e7
	n3d6DWJxAyL0qvpUd1RjCFD6c+yiDDJ685RqMUig42Ec96Nrhah+1yqV2U5pg+sHqvlUk+vuH2B
	pb7dydeXs9WmHC19zITlDghiuh7lG6iRxjbaZRbmf78jQgcs8+NPYZMIKeM5HVBV5BfR8fLfQxt
	awQimhqy65wpSAM3/8bs4hl2o7Lk33KhK7DwYmipJx2VFXKLBMP0AWfck00j8VCxVAeQpgE/BPR
	8aGkL92ImwhisPSkfkFV2kfR5yEnSQlAKt4=
X-Received: by 2002:ac8:5f09:0:b0:530:e40d:3b42 with SMTP id d75a77b69052e-530e40d43edmr16441561cf.7.1789157636056;
        Fri, 11 Sep 2026 13:13:56 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.13.55
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:13:55 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 18/37] classes/rust: remove unused variables
Date: Fri, 11 Sep 2026 16:13:04 -0400
Message-ID: <e8706f519b88341119f9b945cf286109b4cec0ed.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4784

From: Ross Burton <ross.burton@arm.com>

RUSTC_ARCHFLAGS is never passed anywhere, remove it.

RUSTC_BUILD_LDFLAGS is commented out, remove it.

HOST_CFLAGS et al are assigned to the CFLAGS for convenience, but are
not used anywhere and the same values are exported in cargo_common's
oe_cargo_fix_env().

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 6a5a31690508483498e09eb286ca7147130e5852)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/rust.bbclass | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/classes-recipe/rust.bbclass b/classes-recipe/rust.bbclass
index e727601..6407c10 100644
--- a/classes-recipe/rust.bbclass
+++ b/classes-recipe/rust.bbclass
@@ -8,8 +8,6 @@ inherit rust-common
 
 RUSTC = "rustc"
 
-RUSTC_ARCHFLAGS += "--target=${RUST_HOST_SYS} ${RUSTFLAGS}"
-
 def rust_base_dep(d):
     # Taken from meta/classes/base.bbclass `base_dep_prepend` and modified to
     # use rust instead of gcc
@@ -23,26 +21,6 @@ def rust_base_dep(d):
 
 DEPENDS:append = " ${@rust_base_dep(d)}"
 
-# BUILD_LDFLAGS
-# 	${STAGING_LIBDIR_NATIVE}
-# 	${STAGING_BASE_LIBDIR_NATIVE}
-# BUILDSDK_LDFLAGS
-# 	${STAGING_LIBDIR}
-# 	#{STAGING_DIR_HOST}
-# TARGET_LDFLAGS ?????
-#RUSTC_BUILD_LDFLAGS = "\
-#	--sysroot ${STAGING_DIR_NATIVE} \
-#	-L${STAGING_LIBDIR_NATIVE}	\
-#	-L${STAGING_BASE_LIBDIR_NATIVE}	\
-#"
-
-# XXX: for some reason bitbake sets BUILD_* & TARGET_* but uses the bare
-# variables for HOST. Alias things to make it easier for us.
-HOST_LDFLAGS  ?= "${LDFLAGS}"
-HOST_CFLAGS   ?= "${CFLAGS}"
-HOST_CXXFLAGS ?= "${CXXFLAGS}"
-HOST_CPPFLAGS ?= "${CPPFLAGS}"
-
 rustlib_suffix = "${TUNE_ARCH}${TARGET_VENDOR}-${TARGET_OS}/rustlib/${RUST_HOST_SYS}/lib"
 # Native sysroot standard library path
 rustlib_src = "${prefix}/lib/${rustlib_suffix}"
-- 
2.55.0


