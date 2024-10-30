Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B5D6B6AF
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:38:00 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web10.19846.1730306275009981008
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Oct 2024 09:37:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gCkjz4nG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316cce103dso97555e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730306273; x=1730911073; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kqdmN4sjWaUIlCnfCyDrO2NWz0Q0srL2cbEhhnzuEMQ=;
        b=gCkjz4nGt5twA3AvagExpZUNqaqELDGlgmUNxvgCzRlbe6L+QkhgXaZs3cn1nIn7II
         IW/8BM8Id0iX1j16CB1emq5VNKwRSDijpHnMSgFZvugXj3tKN1ijZMpJsb88FSsTr0R+
         fAvq7f5iOQvqxomAxx0EBe/YoG5nlve1M77Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306273; x=1730911073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqdmN4sjWaUIlCnfCyDrO2NWz0Q0srL2cbEhhnzuEMQ=;
        b=Kg54Xf0BmKbCBhNfFIcPTLehRee9/HhkKrPiAZEypTPaCk/dq/QKVKhixv4LY3AkzQ
         z0OybrBBdRnp7I4JBPj3dDmC1c7elWm/+OjBt/UzrIs3YdGW28poiTELEKZSfD31eoOn
         A96fQdImkn11LvLvgMowsLxpijkvsuEYzHnNdxaJ9cvuWpNCfhr3+BjOU3QryJrlF4Go
         3hNYUPazNc9hDFsd8beAwy+YlrIMVr4XgpM8+y/yebvcZpZzCtE5fbVjkRiXDR9CFWSj
         R/HifcNhRIxLsSzXqx0jNfJIdhVuX6/UBdoYNGXnuL6f1Rv3T3IAHeTGoSr0BL74w+SQ
         mYDQ==
X-Gm-Message-State: AOJu0YwhrFlxnGEodkRFSfW1Tq47fX2W2j+FyH8EIyRCq8vFP8oGrKjw
	XPT1tRW1OWGpCIMaVnhkD9DTZb1BLTEqExMoW4lQ1EVIRAH40/d3Pnbl1lAfth9Uyt+wcCujqtS
	NS3E=
X-Google-Smtp-Source: AGHT+IEUW5eYZxau222A1clsDf/U9FOvFrEPmyRMUmoo93W16GvbKFTs4QPU4Rnqbn1ayQDfphMjGQ==
X-Received: by 2002:a05:600c:354e:b0:42c:bae0:f05f with SMTP id 5b1f17b1804b1-4319ac9bc3cmr181602455e9.13.1730306273070;
        Wed, 30 Oct 2024 09:37:53 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:65f1:8463:55dd:142d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bb793e51sm32568945e9.1.2024.10.30.09.37.52
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:37:52 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH] [styhead] config.json: Drop meta-ti from check-layer
Date: Wed, 30 Oct 2024 16:37:51 +0000
Message-ID: <20241030163752.437395-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Oct 2024 16:38:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/778

meta-ti doesn't support styhead, remove it from the check-layer target. The
main build target was already removed

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/config.json b/config.json
index 25b0817..83a81e7 100644
--- a/config.json
+++ b/config.json
@@ -1228,7 +1228,7 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["poky", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein"],
+            "NEEDREPOS" : ["poky", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein"],
             "step1" : {
                 "shortname" : "Test meta-arm YP Compatibility",
                 "MACHINE" : "qemuarm64",
@@ -1243,22 +1243,18 @@
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-intel --no-auto-dependency"]
             },
             "step4" : {
-                "shortname" : "Test meta-ti YP Compatibility",
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-ti/meta-ti-bsp ../meta-ti/meta-ti-extras --dependency ../meta-arm --no-auto-dependency"]
-            },
-            "step5" : {
                 "shortname" : "Test meta-oe YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-openembedded --no-auto-dependency"]
             },
-            "step6" : {
+            "step5" : {
                 "shortname" : "Test meta-virtualization YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-virtualization --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python ../meta-openembedded/meta-filesystems --no-auto-dependency"]
             },
-            "step7" : {
+            "step6" : {
                 "shortname" : "Test meta-clang YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-clang --no-auto-dependency"]
             },
-            "step8" : {
+            "step7" : {
                 "shortname" : "Test meta-exein YP Compatibility",
                 "extravars" : [
                     "HOSTTOOLS:remove = 'clang llvm-strip'"

