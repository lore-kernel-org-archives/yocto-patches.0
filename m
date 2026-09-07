Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF562C79F8C
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 02:23:05 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25957.1788747778085562918
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 06 Sep 2026 19:22:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=kLafgl0E;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: raj.khem@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d91ded8174so22990795ad.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 06 Sep 2026 19:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788747777; x=1789352577; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9MV9k0xTXN29hRTf1Dy4BD2sR5QvBlPu/TpVF6oeF4c=;
        b=kLafgl0EnOgOfiMJLzQyIM77rkpeloaaPUVfANkLTmSU96NvGDnO/BccO4bWpdX8VY
         rdT5dC++oMOrhfiCswJgv301UebHxW8VblUjC6/9VUElsB8IfAekrgCsAc4uk285B09A
         gi4yVCcqswKPhmMOQNlyn0mGshRESWSPpKaZBNJnfo4C54pjMipqZhBn0c1Q7SK3e3Zp
         QgEVir/uR0zyb81sTw/pdYj5zkMzPu97TtnuzHgoi0pyWJ+xcb6ECSj7zbyLTOBGQNpw
         W7BsIsLx5/Zmhc63THLP7hH7M3RPUBvTEVyyKlC8gPq0pm7txosVqz4dZuQgj5vbLjOv
         1TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788747777; x=1789352577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9MV9k0xTXN29hRTf1Dy4BD2sR5QvBlPu/TpVF6oeF4c=;
        b=ois6Hgg+Y2IoFVU73mL3Q58IFY4mLm02OVWJ/AeavoNOfeil00nIRqa7Kkdj2ZmnSg
         QtM6slhP+HfLwl0UqqTY8/Dg8jnknkCG8traacB28CFXsYWyxifUh7KzOY0VUSdKLHMD
         cZEU8ajVvGWSxxl3F34lBTInaZ/URGMGcJSs5v8XA23zogQY+PiZezAxBs+W+p5wQBOl
         g5h9L8NVolNoiRVGn77GvRfovn9QJYTtwvDmC9Oyzo8fcYmmqD9hcRykkIwDftP6NX7G
         F22JD48Ivk7QxoroEwpswebeBczyEwaLnftRzqaVTZht4AGOsaXGnIP0zqiUvVZpkja0
         aFiA==
X-Gm-Message-State: AFuF++kiZb79qpScMawZRSA6OvLLhPpQRlmayAGwBwIeiZt3RdbgeUlI
	32NNUd0Pi9Tnh9iHBKfx6FB1jlCdzQ9O19Fq7mJEGi1SXPZk8DGmwuNGXlEZrw==
X-Gm-Gg: AYBFou2+9JfqOxSvVpYST2rCnRdzLNtHfIHZw5TSCYHnlGFn31GqN/FoBhKxbfiQbUT
	+mjJIGP0uiOJHN44myJsuYn1j6n1quOGZ3iFz1WeNQ409W+uP0twlQ3Kv+UiC6u+GWkwnqTb9vd
	dz0MdevLptaHDOprSJPPD64z/1Th2F1umL7pZ0q9aO1YcQTt7R5XeQxufGN31oYfR0YTebGFSta
	hKGU5X7eOcnipbXsxUy6s0HKSHEJ81hLB2ThiiJzRpuzhgW2EqfABUuSC84Hzq5qwsYTA6g7KNI
	3p3+V6PL3bDOLTu+L9JjdMhJ5VSK0T+Frwv8Bef9u1A1h3cX2WyaxEmOwwWtH+/lM7sjGnP91hl
	ZC19D9sikgs2U2rK2e1JqOcZ94o0Em+DQ8BIuGPReVval7FwTIk/sH9sfregPxeNKRbp8W/prsW
	4luYrWoJHsiCtec/gDngQfon/shWjIdzpSa3D3VYcSbx4lgKzVKqaoF5+bfG2jRHO1+NutEpbr6
	DYBzBq3SNRZjNVtipGoJYsJybM2lIovuhkI3Elc0Y9lLLfjhIH4AA5VJNzsaL+RuA5imJImkVKq
	pUdMLcNRSS4YYWuX1fsvsRLd5Cds1I/gcNoQVxtkKEajfeNG46veB1Z+qxe8WKqN8Pue/AmCWJF
	EcrQgwhSvkOTJKnrHo0CuSwg1WDAUlicWMw3ClZiIYo0bgNRaH92zTfAC
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id d9443c01a7336-2db1235721dmr275530035ad.4.1788747777312;
        Sun, 06 Sep 2026 19:22:57 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm16532173eec.23.2026.09.06.19.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 19:22:56 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH] tpm2-tools: Upgrade 5.7 -> 5.8
Date: Sun,  6 Sep 2026 19:22:53 -0700
Message-ID: <20260907022253.1376185-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 02:23:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4736

Release notes:
https://github.com/tpm2-software/tpm2-tools/blob/5.8/docs/CHANGELOG.md

Fixes GHSA-v7w4-4gc9-qcgv, GHSA-gwfg-w3jr-xh66 and GHSA-qp88-8f4j-wv7q,
including a heap buffer overflow in tpm2_getekcertificate.

Also brings OpenSSL 4.0 compatible macros, so the tools build and link
cleanly against openssl 4.x (verified against 4.0.2 with no deprecation
warnings; tpm2 links libcrypto.so.4).

Add autoconf-archive-native to DEPENDS: the 5.8 release tarball no longer
bundles the autoconf-archive ax_*.m4 macros under m4/ the way 5.7 did, so
the autoreconf done by autotools.bbclass leaves AX_CHECK_COMPILE_FLAG,
AX_CHECK_LINK_FLAG, AX_CHECK_PREPROC_FLAG, AX_ADD_FORTIFY_SOURCE,
AX_CODE_COVERAGE and AX_IS_RELEASE undefined. m4 then strips a quoting
level off their unexpanded arguments and the bare AC_MSG_ERROR leaks into
configure, failing autoconf's m4_pattern_forbid check with:

  configure.ac:40: error: undefined or overquoted macro: AC_MSG_ERROR

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
---
 .../tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb}    | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)
 rename meta-tpm/recipes-tpm2/tpm2-tools/{tpm2-tools_5.7.bb => tpm2-tools_5.8.bb} (66%)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
similarity index 66%
rename from meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
rename to meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
index 7c5d156..63be0da 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.8.bb
@@ -5,11 +5,14 @@ LICENSE = "BSD-3-Clause"
 LIC_FILES_CHKSUM = "file://docs/LICENSE;md5=a846608d090aa64494c45fc147cc12e3"
 SECTION = "tpm"
 
-DEPENDS = "tpm2-tss openssl curl"
+# 5.8 no longer ships the autoconf-archive ax_*.m4 macros in m4/, which the
+# release tarball used to bundle. autoreconf needs them for AX_CHECK_*_FLAG,
+# AX_ADD_FORTIFY_SOURCE, AX_CODE_COVERAGE, AX_IS_RELEASE etc.
+DEPENDS = "tpm2-tss openssl curl autoconf-archive-native"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
 
-SRC_URI[sha256sum] = "3810d36b5079256f4f2f7ce552e22213d43b1031c131538df8a2dbc3c570983a"
+SRC_URI[sha256sum] = "1cb73185cae814b4e15c7c2d0b22642d640faf48775f4156a1fd92edf84bef73"
 
 UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"
 

