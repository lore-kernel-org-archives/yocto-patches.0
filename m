Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB58EF88090
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 07:07:54 +0000 (UTC)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7877.1776323267928662806
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Apr 2026 00:07:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=U6SrvBFb;
 spf=pass (domain: smile.fr, ip: 209.85.221.67, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso2059835f8f.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 00:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776323266; x=1776928066; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ucdc8WZwzlWJQphez2xKUvaPBsr4EGqDWiYicPHE508=;
        b=U6SrvBFbTr3mOPDiKvpxyfr3CS9J6t95ImgLaTjMjVITbjGzajhbgH5knTh46yD95Q
         BVDl+VtK00TPMtxvESa04w89Nnb2c3vwA4ReVQCSN0Xm9CJr6csEvco4fdn+Bk+cOay2
         iSP8zFdQ54r1R6gUvgl7blxsLLVpMXg/9+5ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776323266; x=1776928066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ucdc8WZwzlWJQphez2xKUvaPBsr4EGqDWiYicPHE508=;
        b=NkuoZO1o7t1BLc8/PGQ6cMCLvZsb1ZkRZr+jFR875ycJGjcYfpPhRC7w0AHoRiDxpX
         2H0PrEoxpP4O6SRCEyvtnT91vJG29H/GdN/7oiy40ZJQ20yHdILLVAtRynyr0eXmMXXR
         vk0ll7DGcc8tUiTNfDDu4wHQSazuuO5twtQqs8xn6rTymeyQB4IuqcvZhDCKgFghFC91
         mI9NA81xP542KCuZ83AdYYHr+pKOq0opvl8M+QydeKx9/OeFrIsDzG7xiqUEPxOrmuRW
         h5SXbxTrq+BGJivGDy9R/JQGIWaxvixrn8hb/uZF4xbmsSL9ysJlQq3GXWaK1EPaZ5YU
         BKuw==
X-Gm-Message-State: AOJu0Yzod1t7eObjByL5/6PqDb3iXpisn+o5AW3RbikEONy6VkWtng6j
	LDwiNRn/aQuEWngnrmrUXiWSlsimlUAQQj7crXQVaG6HJnMLdOcxGgLizDEgB6giZ2Ze9rdocEW
	/ao0/AvpgnmjP
X-Gm-Gg: AeBDievZqtGeU748Vm2MlcWCNUMbZ2rmFZstPQHDISK10jFjdiam+Yk14nZNWMZwohw
	w++xehNqive+WhuJGB6szI3jp9BWRY3ph5EZou4X3NB6/2mKT0EFawCGXFrBaUD+dryHwMoaNry
	v1LrN+MQ7gagYKH2y+PGl9mLVRhCKTQFGr6N80Pm0v7AhOrySgmS3w7IxPG86etcFWjGYJfd1Cb
	47zfZYIdqunSeQ+/Izwlri0F20ScXfzVhz6ey7xDH+w6EgafvCJJ/OY0y6icROh5f65CkZ6Jvl0
	qsEiUPqiuw79pk7QFN8IAnQ7ZIm4UiQZpka1MV2SPufSZ9uZaMJ74WBSE6tOpJgg/fhXIdIN9OT
	wYcMnTWIkPkle0aNpacaVSrcz5eyeNNWiJ4YsF1PA+uE9JejYyVFFdpgWSExWBO7XXeoWVnovnv
	KXuY//wh2oZy6CKhq8kkO+vkw24SqqdJYp/UwofYVXewEreHW1vSKmrffn/9u/gDb0Vzi/KD4gN
	Vo37ABX/T3b9ASQ7R188mDvLLuGO0EkSfMh+Q==
X-Received: by 2002:a05:6000:2c06:b0:43c:f1da:4880 with SMTP id ffacd0b85a97d-43d64286b9cmr37749207f8f.22.1776323265843;
        Thu, 16 Apr 2026 00:07:45 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5f06sm11602449f8f.17.2026.04.16.00.07.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 00:07:45 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][whinlatter 2/5] config.json: Set SSTATE_DIR unconditionally
Date: Thu, 16 Apr 2026 09:07:37 +0200
Message-ID: <6e1f018d6369e701c98fba9a992279792acc2fd7.1776323183.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1776323183.git.yoann.congal@smile.fr>
References: <cover.1776323183.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Apr 2026 07:07:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3718

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9e90929ca00921612b30aa218b89cbad23f9a189)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 config.json | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/config.json b/config.json
index 9d4f031..9cb8693 100644
--- a/config.json
+++ b/config.json
@@ -35,8 +35,8 @@
         "SDKMACHINE" : "x86_64",
         "PACKAGE_CLASSES" : "package_rpm package_deb package_ipk",
         "DLDIR" : "DL_DIR = '${BASE_SHAREDDIR}/current_sources'",
-        "SSTATEDIR" : ["SSTATE_DIR ?= '${BASE_SHAREDDIR}/pub/sstate'"],
-        "SSTATEDIR_RELEASE" : ["SSTATE_DIR ?= '${BASE_SHAREDDIR}/pub/sstate'"],
+        "SSTATEDIR" : ["SSTATE_DIR = '${BASE_SHAREDDIR}/pub/sstate'"],
+        "SSTATEDIR_RELEASE" : ["SSTATE_DIR = '${BASE_SHAREDDIR}/pub/sstate'"],
         "SDKEXTRAS" : ["SSTATE_MIRRORS += '\\", "file://.* http://sstate.yoctoproject.org/all/PATH;downloadfilename=PATH'", "BB_HASHSERVE = 'auto'", "BB_HASHSERVE_UPSTREAM = '${AUTOBUILDER_HASHSERV}'"],
         "BUILDINFO" : false,
         "BUILDHISTORY" : false,
@@ -191,7 +191,7 @@
         },
        "bringup" : {
             "BUILDINFO" : true,
-            "SSTATEDIR" : ["SSTATE_DIR ?= '${HELPERBUILDDIR}/sstate'"],
+            "SSTATEDIR" : ["SSTATE_DIR = '${HELPERBUILDDIR}/sstate'"],
             "MACHINE" : "qemuarm64",
              "step1" : {
                  "SDKMACHINE" : "x86_64",
@@ -230,8 +230,8 @@
         },
         "buildperf" : {
             "MACHINE" : "qemux86",
-            "SSTATEDIR" : ["SSTATE_DIR ?= '${HELPERBUILDDIR}/sstate'"],
-            "SSTATEDIR_RELEASE" : ["SSTATE_DIR ?= '${HELPERBUILDDIR}/sstate'"],
+            "SSTATEDIR" : ["SSTATE_DIR = '${HELPERBUILDDIR}/sstate'"],
+            "SSTATEDIR_RELEASE" : ["SSTATE_DIR = '${HELPERBUILDDIR}/sstate'"],
             "PACKAGE_CLASSES" : "package_rpm",
             "EXTRAPLAINCMDS" : [
                 "${SCRIPTSDIR}/build-perf-test-wrapper --results-dir ${BUILDPERF_RESULTSDIR} --email-addr yocto-perf@lists.yoctoproject.org --download-dir ${BUILDPERF_STATEDIR}/downloads --publish-dir ${HELPERRESULTSDIR}/${HELPERTARGET} --repo ${HELPERREPONAME} --branch ${HELPERBRANCHNAME} --push-remote git@push.yoctoproject.org:yocto-buildstats --build-dir ${HELPERBUILDDIR}"
@@ -677,7 +677,7 @@
             }
         },
        "bringup" : {
-            "SSTATEDIR" : ["SSTATE_DIR ?= '${HELPERBUILDDIR}/sstate'"],
+            "SSTATEDIR" : ["SSTATE_DIR = '${HELPERBUILDDIR}/sstate'"],
             "TEMPLATE" : "bringup"
         },
        "bringup-fast" : {

