Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274DECD6E57
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 23:18:29 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12711.1780355908591917515
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Jun 2026 16:18:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JgsDifeJ;
 spf=pass (domain: konsulko.com, ip: 209.85.215.178, mailfrom: tim.orling@konsulko.com)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8585ecdd71so953532a12.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1780355908; x=1780960708; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehfwuZgaXhLcgzLPWhIEpy0u++Bs/zTf491pbLjBbNM=;
        b=JgsDifeJ9WrhlnHBUPP4lQPgVfp3eGoiXFbRrz/K0kbh9g5eDXdoVNqh3TwZ/gckBJ
         mB5dghsJgsus9S/ydg9agnssdZe46HSHHSzIXVaDG152pftbxKhRnVqUIjYRv5TscUuf
         GXyHg2aPYePU+6gvkRdjdOY62vEcE4aBKK2lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355908; x=1780960708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ehfwuZgaXhLcgzLPWhIEpy0u++Bs/zTf491pbLjBbNM=;
        b=Jpwp0IRtAsrQzSg7ld5qlaVcaLdU2punsZpxxBQXzAXe0jCXeR1MN3YztFxXPU/y0a
         rsCFiH1HQFVrJaQX8p5D33b7krWC3HkBiJbD+HWYb/7CX+fbUey4wgcP6HMAwsH3RwRv
         3VjTvLCYsm+cxonH3pHg5Mmz9W25gZNeGLEdPswDXaHfMpQjG1IrTyWfHqlv05EZIKsx
         O4ZUys0h+xy4CR7U4tksT4SPdaarjuFY5usBzBrvBDauVNuTMqajgcDg9QIOx1M6toYE
         ZNzRVYUpMhV6KUt5BTpACDcPFAYmn3cmNldo3KbK7jL49U+QF6ZFiLAORgWHxeOXD/ex
         eG1Q==
X-Gm-Message-State: AOJu0YymqG04emMT6XXOBXIbRBUCuthbFu7vdkTK0UYGAhroeKC8mwMm
	585yrIqX/tT7Apiho6dwOIS+q76nmeENI3v2JwjtysRe1iQaQvnyUdw3j65ZDVdFsc+3aKQJyVs
	wJ75d
X-Gm-Gg: Acq92OHShK8zHrysPjBmwTxkfP2SSN2pFBVSPAWSUPY8Lq3Shg1aCsX8nj624L6JODL
	Iog+om8f+5N5Wl12UlXSwEOo8Zh1hwL58KUngVLCxbln7zJM6f3+NP//a+nM2jaKZRre7o3PUem
	JsIpHzb1ZqPByjlfpbxKqjhtaq526SgAa0WE09iymuamJiKIzKqt0bBSQPfGo5viNonJItpvmbV
	eT1glYUNcRSbnFHjpCxkKupqIptQTosdzwB2Py8osIPCBX6GSnctgG06/2HVoxQYnr/TTbRa9eW
	i8GvUGcHuH/3XBBX/LJ8Vl5p4Ym3goI3kJBXrWpizH4PyrhQqUY0762/NQLUDIT1jKZ/4QR2+ZJ
	C5LFNEkmiPHtjTcTX2HmYrZpuldxh92ubwwzyCZ4GKrh6YDnLHnQijFIzA379kdEiTxsRyyTlGq
	AQXVmVOQLehm6XYxeJLLNmT0EdLmKTV816QuOSZmEkl69ykuT+Y+C3U5Q1VxMtOWjXKcWUPpLev
	Q==
X-Received: by 2002:a05:6a21:6f8b:b0:34f:14d6:15f5 with SMTP id adf61e73a8af0-3b427f2fa22mr14659566637.29.1780355908018;
        Mon, 01 Jun 2026 16:18:28 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772993c9sm12550525a12.15.2026.06.01.16.18.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:18:27 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v2 03/10] config.json: add sha256sum for BUILDTOOLS URLs
Date: Mon,  1 Jun 2026 16:18:02 -0700
Message-ID: <5fc50caa59790443a710534af53b206af8be8edb.1780354513.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780354513.git.tim.orling@konsulko.com>
References: <cover.1780354513.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Jun 2026 23:18:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4100

From: Tim Orling <tim.orling@konsulko.com>

setup_tools_tarball() now checks the sha256sum of cached tools tarballs
to determine if an update is available and needs to be re-downloaded.

To prevent unnecessary downloads, add ;sha256= to the BUILDTOOLS URLs.

extratools/EXTRATOOLS_URL uses the same utils.setup_tools_tarball(), so
it also needs the ;sha256=.

Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 config.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/config.json b/config.json
index b27fee9..7df4271 100644
--- a/config.json
+++ b/config.json
@@ -7,10 +7,10 @@
     "BUILD_HISTORY_REPO" : "ssh://git@push.yoctoproject.org/poky-buildhistory",
     "BUILD_HISTORY_FORKPUSH" : {"openembedded-core-contrib:ross/mut" : "openembedded-core:master", "openembedded-core-contrib:abelloni/master-next": "openembedded-core:master", "openembedded-core:master-next" : "openembedded-core:master"},
 
-    "BUILDTOOLS_URL" : "https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-5.2_M2/buildtools/x86_64-buildtools-extended-nativesdk-standalone-5.1.sh",
-    "BUILDTOOLS_ARM_URL" : "https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-5.2_M2/buildtools/aarch64-buildtools-extended-nativesdk-standalone-5.1.sh",
-    "BUILDTOOLS_MAKE_URL" : "https://downloads.yoctoproject.org/releases/yocto/yocto-5.0.4/buildtools/x86_64-buildtools-make-nativesdk-standalone-5.0.4.sh",
-    "EXTRATOOLS_URL" : "https://downloads.yoctoproject.org/tools/buildtools/x86_64-buildtools-imagemagick-nativesdk-standalone-4.3+snapshot-5f2ba20f203114db9a3b11264467f8c23a05041d.sh",
+    "BUILDTOOLS_URL" : "https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-5.2_M2/buildtools/x86_64-buildtools-extended-nativesdk-standalone-5.1.sh;sha256=5af9d92898af17fcc2fca4d07607a59f41b1c39a0a4ff058f64d834b98ec7fd5",
+    "BUILDTOOLS_ARM_URL" : "https://downloads.yoctoproject.org/releases/yocto/milestones/yocto-5.2_M2/buildtools/aarch64-buildtools-extended-nativesdk-standalone-5.1.sh;sha256=8074d582a60a5135fd5606b8326e749185d26f51aca27570447831310bcac187",
+    "BUILDTOOLS_MAKE_URL" : "https://downloads.yoctoproject.org/releases/yocto/yocto-5.0.4/buildtools/x86_64-buildtools-make-nativesdk-standalone-5.0.4.sh;sha256=2eb7a6c013113f4fdb87e800167606dc13af1bd8bbc1c9e2443b7be37fefd124",
+    "EXTRATOOLS_URL" : "https://downloads.yoctoproject.org/tools/buildtools/x86_64-buildtools-imagemagick-nativesdk-standalone-4.3+snapshot-5f2ba20f203114db9a3b11264467f8c23a05041d.sh;sha256=9cbff3a7cf524bdfa7779dce8afaf3453114d8017918d2927f723ea38a36ebdc",
 
     "REPO_STASH_DIR" : "${BASE_HOMEDIR}/git/mirror",
     "TRASH_DIR" : "${BASE_HOMEDIR}/git/trash",
-- 
2.43.0


