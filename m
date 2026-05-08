Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5380CD3427
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 02:00:53 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4655.1778205653439823037
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 07 May 2026 19:00:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=BWbBsNiE;
 spf=pass (domain: konsulko.com, ip: 209.85.214.179, mailfrom: tim.orling@konsulko.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bab2548e8bso7122575ad.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 07 May 2026 19:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1778205653; x=1778810453; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGpJGGdx2pP961hlODhNEoWrZCG6FZrq0blRiEQh8qQ=;
        b=BWbBsNiEW2o+wMMkCrwZrSn4niubmb5FI5ryIEYDvKz8wszfQQbRsckyXCWHRmGJqr
         ox1B9eTtlOaWi79kPcjHhiXKgsTdw9+F3rd/OYCRlayMVhVze6zHZAP3DdO/u3dSjAE1
         x87c24Rg0XvDoWTBZG9ipJL6R7yP1P8yO0rsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205653; x=1778810453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dGpJGGdx2pP961hlODhNEoWrZCG6FZrq0blRiEQh8qQ=;
        b=msoITmaqfpTF2YP3epIEhoK7BzivtHXSUimFq4tAKPlLRoN9q0KNxO07tpdigS2tvr
         JUoKMcUyhuzKBYansfjYiJZCn3bj8sKtpl+LMY0r9f+qYiCF9szmIT0pAi/xFb/NYgwE
         acEuhE1kmbhl0S4hGngkKP5OTzPxv0W135+HOeaJeT44xUO4sOX1JL5og7+o83CtMC9l
         XTY5x32l1OFpY/I1nmeyHBxjOdTUdxPn4x24S2lqefsezXDaDDzvwGyO0H4aUxJNuYzt
         YSzMAeJj/sMz0PRLAf3uGtGM1Dj5GDsTGNDNL6pqXBo2Yj4u4qCGEXn+AY0WYZM6ebMC
         4JqQ==
X-Gm-Message-State: AOJu0Yzi/K6RWB6wotdhRZ0+gdm+In8a5L0uJUNY09QjffoN+Ul7mEHX
	inJfv9du4N502Jdhg/RophYymGWYzzFYtYIea/b1EOTzJY6pdGT/XfKTisV5sYlgsIn+zNgmtue
	njsdm
X-Gm-Gg: Acq92OFyU/rdCXFBeC+JNV+7dG73e3YPZOVeMqQonEJ1JTNdHzT4WHSjU+/rgOVNLo+
	nSLQFvB7duXyiILrO24tnhB0WTFPwy2qY85fFUA/PYblhrG+yLHrV6QVxnogMCqc2Q1IpBk/iAa
	QzoZa2/MWk3kPkQSy+2qLuGc9HJg7T+KUHUo8zmqBD6FkuqG+LJRnJ2QrzUnsKXBsESpkTEbSfU
	dUqfKzB4gkMotaAFYYS4HhyZ/mL4mfpLhmpWGohRK4c4nymGOll1TQRrUHC1GSM+sHPGQCKdhxk
	wA8gGRd7qtQ/a6jTGV0OI6bxH823ntAY7ukBVODNjThDmtpNLlXIh5jv7LsD+4+0hUojt1Oox85
	2npR+woJHzI9RlK7QOu6UB9PUmfl1Wc1oFWxWYDASbQI8M1BB9dGREHHKVzEjt9dwSYHECDG6M1
	8+Brzs/lxNPHGqHXBBUGKzGEjByS6yTAuGSX9hBt1TT9/q0Uydj+hd13oPZnor9D+uaByabu9YA
	w==
X-Received: by 2002:a17:903:48f:b0:2ba:4f37:d3a7 with SMTP id d9443c01a7336-2ba794c4db4mr82636975ad.27.1778205652537;
        Thu, 07 May 2026 19:00:52 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27083sm1910185ad.13.2026.05.07.19.00.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:00:52 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 03/11] config.json: add sha256sum for BUILDTOOLS URLs
Date: Thu,  7 May 2026 19:00:26 -0700
Message-ID: <2ca072fcdf500ca956d45749f302518e17f7d3b8.1778202125.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778202125.git.tim.orling@konsulko.com>
References: <cover.1778202125.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 08 May 2026 02:00:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3942

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
index f0e220e..8d42bbe 100644
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


