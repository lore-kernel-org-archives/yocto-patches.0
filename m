Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899C1CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 21:51:42 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.2424.1755553894581626295
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 14:51:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=OhQ/O95R;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-256628-20250818215130e34b6b364afe616d1d-hrlm8_@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250818215130e34b6b364afe616d1d
        for <yocto-patches@lists.yoctoproject.org>;
        Mon, 18 Aug 2025 23:51:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3+uOnZdBKANEuIvP1k+UkSaPsfu/ztHCB6LfPW3ydzg=;
 b=OhQ/O95RazqQogpSHAs9kjIue437/su2KuoX6w/QJRM1+0Ts33665h+eEcCosG/5Wbwtjr
 diYC2bg00DCn/qiHrTscT75kPTcWloI063nZ4k7+pk1jE3oytoY6rKpCX6nw7VopsHHLTogX
 HwJENkQyprFQ7ziLloAoA9rou6jr0OTfYrw+TZLEbs4ezc4VbymCmwvKbtNoupIamOmCazcc
 Wmr8yr3xZIYQdB5UqN0b2j/gujW19w0czyxzYje+RqalR6EuNZrUV0APFDa+yULMBV5F2dEN
 K91jTgl2c8tfg/SKXMOcBtwy4gcXWP7L+0ZpFFzRflXacuWXd9lZn3YA==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: jose.quaresma@foundries.io,
	peter.marko@siemens.com
Subject: [meta-lts-mixins][kirkstone/go][PATCH 1/2] go-cross-canadian: fix binaries install and GOARCH
Date: Mon, 18 Aug 2025 23:50:44 +0200
Message-Id: <20250818215045.2461230-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 21:51:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2036

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
index 460034b..adf76b5 100644
--- a/recipes-devtools/go/go-cross-canadian.inc
+++ b/recipes-devtools/go/go-cross-canadian.inc
@@ -5,6 +5,8 @@ DEPENDS = "go-native virtual/${HOST_PREFIX}go-crosssdk virtual/nativesdk-${HOST_
            virtual/nativesdk-${HOST_PREFIX}compilerlibs"
 PN = "go-cross-canadian-${TRANSLATED_TARGET_ARCH}"
 
+GOARCH = "${HOST_GOARCH}"
+
 # it uses gcc on build machine during go-cross-canadian bootstrap, but
 # the gcc version may be old and not support option '-fmacro-prefix-map'
 # which is one of default values of DEBUG_PREFIX_MAP
@@ -52,7 +54,7 @@ do_install() {
 	install -d ${D}${libdir}/go/pkg/tool
 	cp --preserve=mode,timestamps -R ${B}/pkg/tool/${HOST_GOTUPLE} ${D}${libdir}/go/pkg/tool/
 	install -d ${D}${bindir} ${D}${libdir}/go/bin
-	for f in ${B}/${GO_BUILD_BINDIR}/*
+	for f in $(find ${B}/${GO_BUILD_BINDIR} -type f)
 	do
 		base=`basename $f`
 		install -m755 $f ${D}${libdir}/go/bin

