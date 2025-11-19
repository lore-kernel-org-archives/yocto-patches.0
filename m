Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538C6CF3953
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:58 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9156.1763564757365188092
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=EoDUBhJB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-202511191505558b2ef9bb3c00020749-0ecfqw@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202511191505558b2ef9bb3c00020749
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AGI8F6yXhUcW0sfq7OAntne7OdPodNK/v6Yig0UQYJ8=;
 b=EoDUBhJBdBKaWv03AabKGjwoVWU24N+23dkELfCfLBe9V3wMiBCIz+6XTuqQmfS2Wa7zCe
 BB0YeJ6jDBG3no6HvtPW0e+OJ1XR4PCIIR3xJKYz4rDzyoK/PLdHAM06mi8INUu5OdM4BLH3
 ldzsEbpSN5lktEZWIDLES0vFDXp05cCyVaWV70Z+wNQEXC3oXScLKY6nNrdOKsuYvnnlsgJj
 C0nzfwfX83CxaQhe5+1j6QMfNbTMNTxJkGEAAftwT3fhT1eI5IK5M6BZEok72a4EjAtfnoAL
 0Sd03gNOggtnh47pnggqF8mjxiNMoXzLrS4VUx1cU5dG5iLXSwv1//AA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 26/35] go-cross-canadian: fix binaries install and GOARCH
Date: Wed, 19 Nov 2025 16:05:13 +0100
Message-Id: <20251119150522.15477-27-peter.marko@siemens.com>
In-Reply-To: <20251119150522.15477-1-peter.marko@siemens.com>
References: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2606

From: Osama Abdelkader <osama.abdelkader@gmail.com>

set GOARCH to HOST_GOARCH which is set from SDKMACHINE,
since GOARCH defaults to TARGET_GOARCH, which is set from MACHINE (wrong arch).

Also fix do_install to correctly install all binaries from
${GO_BUILD_BINDIR} by using 'find -type f' to avoid issues when the
directory contains subdirectories (e.g. "linux_arm").

(From OE-Core rev: 31e3bd61c7986bc044e547aa5cb9caba7b32bf22)

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-cross-canadian.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/go/go-cross-canadian.inc b/recipes-devtools/go/go-cross-canadian.inc
index 101a208..9ebcf9c 100644
--- a/recipes-devtools/go/go-cross-canadian.inc
+++ b/recipes-devtools/go/go-cross-canadian.inc
@@ -5,6 +5,8 @@ DEPENDS = "go-native virtual/${HOST_PREFIX}go virtual/nativesdk-${HOST_PREFIX}go
            virtual/nativesdk-${HOST_PREFIX}compilerlibs"
 PN = "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"
 
+GOARCH = "${HOST_GOARCH}"
+
 # it uses gcc on build machine during go-cross-canadian bootstrap, but
 # the gcc version may be old and not support option '-fmacro-prefix-map'
 # which is one of default values of DEBUG_PREFIX_MAP
@@ -51,7 +53,7 @@ do_install() {
 	install -d ${D}${libdir}/go/pkg/tool
 	cp --preserve=mode,timestamps -R ${B}/pkg/tool/${HOST_GOTUPLE} ${D}${libdir}/go/pkg/tool/
 	install -d ${D}${bindir} ${D}${libdir}/go/bin
-	for f in ${B}/${GO_BUILD_BINDIR}/*
+	for f in $(find ${B}/${GO_BUILD_BINDIR} -type f)
 	do
 		base=`basename $f`
 		install -m755 $f ${D}${libdir}/go/bin

