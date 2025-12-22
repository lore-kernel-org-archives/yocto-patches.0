Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5A2E67803
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 16:52:33 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.84031.1766422347546451986
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Dec 2025 08:52:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=TXaj35q4;
 spf=pass (domain: konsulko.com, ip: 209.85.219.42, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a37cb5afdso62538396d6.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 08:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1766422346; x=1767027146; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quBCsM1Ua7wrZ9Ud0MrYiaenGvPpdHcyeWtCCcpmT04=;
        b=TXaj35q4tUU1WiPpaR06gjmq/GN57nKjYb3OJ+v4wd0sFqpS91P5pBrszz2PvHfB5v
         7etVrpQQsMgeiT2ZyLlGDhN9U7ttOFzfl8BqO8IEkPqqV8IlJT2vRQMLfYHgb/s27I09
         W+864I5Wxt77qXW46/Fpqbe1CuchdXq4afZWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422346; x=1767027146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=quBCsM1Ua7wrZ9Ud0MrYiaenGvPpdHcyeWtCCcpmT04=;
        b=hYNvlK+UEmGlEjS2XVDT1z1UieRtcSBm7YqQKqq0FwF+bxpVpAMT4a5yvZBwkIVdku
         zhv+mTzUGputOPaPswVIkjlK0oYWdrxdISTDwj4zhbGEmOFR+RSDE+MFZX6vxoYFdSjC
         mb6ImJ7aO0vCswnSq9TqwjWvc3eD+zw45mBQKOOGWMjq/ADOCVrs6VQqaliTnHquMI5L
         mMBB/7twgHX05+Mdw5AnTIW2wLBaw0ETOf6V846LYADpb2uL9S/aUzB0m6GUgB52ay3D
         eKygfO+aZ4JEXG8I9gSMd97zttFt9unf+Tl6VF3TGKvnhNBc8LAxW4R4WPArcgtFjoZL
         urjg==
X-Gm-Message-State: AOJu0YwHvcZ3Pc1HWqrJvra1UGwmt0uBXiCd5srgc8hM21Ecb+TogMz7
	L51uvfQGZKNilnz0ZrykvAwM5hN6JDnennrh73s880Ews7sXQE+RSznfdc7L/RE0GHljuEq9Pvo
	wx1vP
X-Gm-Gg: AY/fxX6HsU4XQj0pHSFf2BH2gNEzJwL2SbAkscK6yE9vdQatQMj9T58oZ7EUVanDOHG
	jFhkOBsgJRJiFYnqwENQ722QzsCKjEk/oSdBFog+eTyMdBmoNzUFqRjE3gjwQ3sddBPbpwXqGCZ
	+8WNr405BnDV6NNTw+TjsA2aQxJpkcNAnX3AMnZ9wU8UX0WBtTiyZw/m1wqTQdYr04hJc/dfs+m
	ld8vCKq6cqNxWHVMBrvETGL+oExiLzuTx5i9u7QGk2WCPUXHmClkbyK+7I7aiXQGEqPcSGFkLos
	Dn3VxKD65KMCfev2ieNY37aaIpvi9Xs9OPHnFO7JKnzAYc5LYepi692aBL/C/xVGjGZhAqUxcT1
	nRumn9iI4r1XQk9aH5qrjJwN/v3q7Wp/4LNTrnVmgeKT+FG31tZkJN02GtqGcNt9qANSkLnT9+s
	z36TLn6F5BE+zmBoOaoOm4+jL+JWgyORY2ZMwAr4B4LB7iKLIUn4Soy77kkJXvzZUJBve0lU4x1
	kSBqggV/pj61UOmOpv0eNxwUh+xlMo7GrlcCFo+vxm8ic3mPmMf
X-Google-Smtp-Source: AGHT+IEFf0vBwv1ZHCXSPkGYoQPrnKQwx7L61LAG0Aey1T6O7Yqn/6i6EMssyVWDsFkCpomhVRC2gg==
X-Received: by 2002:a0c:ed27:0:b0:888:681b:4ee8 with SMTP id 6a1803df08f44-88d821386e8mr120170146d6.14.1766422346022;
        Mon, 22 Dec 2025 08:52:26 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9623fdfdsm87149726d6.5.2025.12.22.08.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:52:24 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: [meta-security][PATCH 7/8] openscap: switch to libpcre2
Date: Mon, 22 Dec 2025 11:51:55 -0500
Message-ID: <51cc72c2d7f4ee900d201217db4e356832aa768b.1766420960.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1766420960.git.scott.murray@konsulko.com>
References: <cover.1766420960.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Dec 2025 16:52:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2857

From: hongxu <hongxu.jia@windriver.com>

The openscap added PCRE2 library since 2023 [1]

[1] https://github.com/OpenSCAP/openscap/commit/cd1d4289581fa15527e516ddd07be814af7cba55

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 recipes-compliance/openscap/openscap_1.4.2.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-compliance/openscap/openscap_1.4.2.bb b/recipes-compliance/openscap/openscap_1.4.2.bb
index da1dbbb..7b3786e 100644
--- a/recipes-compliance/openscap/openscap_1.4.2.bb
+++ b/recipes-compliance/openscap/openscap_1.4.2.bb
@@ -6,8 +6,8 @@ HOME_URL = "https://www.open-scap.org/tools/openscap-base/"
 LIC_FILES_CHKSUM = "file://COPYING;md5=fbc093901857fcd118f065f900982c24"
 LICENSE = "LGPL-2.1-only"
 
-DEPENDS = "dbus acl bzip2 pkgconfig gconf procps curl libxml2 libxslt libcap swig libpcre  xmlsec1"
-DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native libxslt-native libcap-native libpcre-native xmlsec1-native"
+DEPENDS = "dbus acl bzip2 pkgconfig gconf procps curl libxml2 libxslt libcap swig libpcre2  xmlsec1"
+DEPENDS:class-native = "pkgconfig-native swig-native curl-native libxml2-native libxslt-native libcap-native libpcre2-native xmlsec1-native"
 
 SRC_URI = "git://github.com/OpenSCAP/openscap.git;branch=main;protocol=https \
            file://0001-CMakeLists.txt-fix-installation-directory-for-system.patch \
-- 
2.51.0


