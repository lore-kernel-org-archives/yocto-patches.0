Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B1DCCA470
	for <webhook@archiver.kernel.org>; Wed,  1 Oct 2025 14:26:58 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.19436.1759328815007332531
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Oct 2025 07:26:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dydagWsG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso5882028f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 07:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759328813; x=1759933613; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsgDC926ArnKqNZezbJ1QZCDHLtbLB216D5w+TYmaKs=;
        b=dydagWsGgLxf4TNveL9Q0mY09EEr5zz78Cxn4fBvYDHUmyr01XpitYmHaSv/AYvz+u
         XZRoMxj/PotcHqUgO+bfhfdreWonQsfA62/i5K68C3JZg9stAQaXSV//493J5tn9pLKI
         auF+1mndvNfk3Bknhh6QQNBx5iJK45ysnd2cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328813; x=1759933613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsgDC926ArnKqNZezbJ1QZCDHLtbLB216D5w+TYmaKs=;
        b=ZW+xLn4ZWzJW0XcZ3PWHNqRZD4qVrrxVwulb8EGs/Rv/07CD7J6Tc64xix1rWW2n25
         GGlPGiwBre/gFzMOM/vE1URMNx97+OVyJm6EssDP9LhZuuB+2Livug9K+3EYaNv/EupS
         ocutUSGocoYpIASvUXKgXwA/YgSlYW8tMO7QlP8q6I9WjvaYa+84vRjFS8lVtLyQE6ue
         FQiXJfsMo5ztZCcQ1i12f520CaW/slTU1yfFs29mIGF3tlPX8rjLgViOjIBFBHGp2CBZ
         rHmj7TeSrZccN6GMH/1ueF/vUpRCRruDEouvFeNgG3enaqJq9Emuvaou4fmV/IaU9YIG
         1AJg==
X-Gm-Message-State: AOJu0YwMinuZ2DuzASnXHdU7jooKVWKEQHHPrh7Yy0mD5A/puEZYEsTn
	v13/obFZ3wJIXk9+BF/7aVi0I8rmvf8++Bot+MuvK90h6npF5vJNpsdt2vdIZ+loy2u6MGhZUQx
	QnSWf
X-Gm-Gg: ASbGncv/5okocTo/G6zQVLDSmzQrNxIl3iVV8WsgOFXthTSBTOGGWd7G5Vg7JCQS9qs
	OwPXWroV+y8H89qMyc8I+1v/7B3ePjn11m5uFfcIGZk+ypWJWv2ekBQlKjJrCF5dyTflrNbKb4U
	X8gwcjh43FNtkuG5wdW8lVfd63e2FfP8muiqZSAQYf+ThbashDFoPDALQkzdXTtJ7oopVJ9y200
	YU5aGIglHIz4hpIYEtJzW4QVsplhHQF5IR1q/yIdEuQUkRNAgThe1IYzrk21tJ1q4tpI0TWcvDV
	hTlanAxyvpzzdVmnY/32///PAMASj72Lkn1nOoz3XSp5AVeWcYs/LnlHq7XFYeGQuWSUyka0amz
	Xpt643Lb09uoVlzazFyzpb5Cq47V9C9i2zIhWYBnIXxl1k/uO0IAT4o86ZHUsXhGJpa+3Y880qQ
	g=
X-Google-Smtp-Source: AGHT+IECjhq/6Khm59ZKuLqBFeaKd1sBsjbhcxnZa3No4AdquKA/2A7wHoqrfUotyl58uiWb6j5ggw==
X-Received: by 2002:a05:6000:184e:b0:3d3:1ad0:e8b7 with SMTP id ffacd0b85a97d-425577edc61mr2672289f8f.12.1759328812161;
        Wed, 01 Oct 2025 07:26:52 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:d53b:59af:db6b:d4f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm29173915f8f.0.2025.10.01.07.26.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:26:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config.py: add oecore, meta-poky and yocto-docs as default repos
Date: Wed,  1 Oct 2025 15:26:50 +0100
Message-ID: <20251001142650.270094-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Oct 2025 14:26:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2268

We can't just replace poky with bitbake, we need to add the other repo information
so we can correclty pass layer override information from the autobuilder layer config.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 56 +++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/config.py b/config.py
index ac8ab2cf..72095027 100644
--- a/config.py
+++ b/config.py
@@ -2,39 +2,39 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+baserepos = ["bitbake", "oecore", "meta-poky", "yocto-docs", "poky"]
+
 # ## Build configuration, tied to config.json in yocto-autobuilder-helpers
 # Repositories used by each builder
 buildertorepos = {
-    "a-quick": ["poky", "meta-intel", "oecore", "bitbake",
-                "meta-mingw", "meta-gplv2"],
-    "a-full": ["poky", "meta-intel", "oecore", "bitbake",
-                "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang"],
-    "non-gpl3": ["bitbake", "poky", "meta-gplv2"],
-    "meta-mingw": ["bitbake", "poky", "meta-mingw"],
-    "qa-extras": ["bitbake", "poky", "meta-mingw"],
-    "meta-oe": ["bitbake", "poky", "meta-openembedded"],
-    "meta-virt": ["bitbake", "poky", "meta-openembedded", "meta-virtualization"],
-    "meta-intel": ["bitbake", "poky", "meta-intel"],
-    "meta-exein": ["bitbake", "poky", "meta-exein", "meta-openembedded"],
-    "meta-arm": ["bitbake", "poky", "meta-arm"],
-    "meta-agl-core": ["bitbake", "poky", "meta-agl"],
-    "meta-aws": ["bitbake", "poky", "meta-aws", "meta-openembedded"],
-    "meta-clang": ["bitbake", "poky", "meta-clang"],
-    "buildtools-docs": ["bitbake", "poky", "meta-openembedded"],
+    "a-quick": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2"],
+    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang"],
+    "non-gpl3": baserepos + ["meta-gplv2"],
+    "meta-mingw": baserepos + ["meta-mingw"],
+    "qa-extras": baserepos + ["meta-mingw"],
+    "meta-oe": baserepos + ["meta-openembedded"],
+    "meta-virt": baserepos + ["meta-openembedded", "meta-virtualization"],
+    "meta-intel": baserepos + ["meta-intel"],
+    "meta-exein": baserepos + ["meta-exein", "meta-openembedded"],
+    "meta-arm": baserepos + ["meta-arm"],
+    "meta-agl-core": baserepos + ["meta-agl"],
+    "meta-aws": baserepos + ["meta-aws", "meta-openembedded"],
+    "meta-clang": baserepos + ["meta-clang"],
+    "buildtools-docs": baserepos + ["meta-openembedded"],
     "qemuarm-oecore": ["oecore", "bitbake"],
-    "checkuri": ["bitbake", "poky"],
-    "check-layer": ["bitbake", "poky", "meta-mingw", "meta-gplv2"],
-    "check-layer-nightly": ["bitbake", "poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom"],
+    "checkuri": baserepos,
+    "check-layer": baserepos + ["meta-mingw", "meta-gplv2"],
+    "check-layer-nightly": baserepos + ["meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom"],
     "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
-    "reproducible-meta-oe": ["bitbake", "poky", "meta-openembedded"],
-    "patchtest": ["bitbake", "poky", "meta-patchtest", "meta-openembedded"],
-    "meta-oe-mirror":  ["bitbake", "poky", "meta-openembedded"],
-    "auh":  ["bitbake", "poky", "auto-upgrade-helper"],
-    "auh-meta-oe":  ["bitbake", "poky", "meta-openembedded", "auto-upgrade-helper"],
-    "metrics":  ["bitbake", "poky", "meta-openembedded"],
-    "metrics-gitstats":  ["bitbake", "poky", "oecore", "bitbake", "meta-openembedded", "yocto-docs"],
-    "meta-webosose":  ["bitbake", "poky", "meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
-    "default": ["bitbake", "poky"]
+    "reproducible-meta-oe": baserepos + ["meta-openembedded"],
+    "patchtest": baserepos + ["meta-patchtest", "meta-openembedded"],
+    "meta-oe-mirror":  baserepos + ["meta-openembedded"],
+    "auh":  baserepos + ["auto-upgrade-helper"],
+    "auh-meta-oe":  baserepos + ["meta-openembedded", "auto-upgrade-helper"],
+    "metrics":  baserepos + ["meta-openembedded"],
+    "metrics-gitstats":  baserepos + ["oecore", "bitbake", "meta-openembedded", "yocto-docs"],
+    "meta-webosose":  baserepos + ["meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
+    "default": baserepos
 }
 
 # Repositories used that the scripts need to know about and should be buildbot

