Return-Path: <samuli.piippo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F30CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 09:54:07 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web10.73322.1756806846139496407
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 02:54:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bAvx6mni;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: samuli.piippo@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f646b1db8so4868573e87.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756806844; x=1757411644; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwYyCqIVck1DjzqxHtECjm8JozvkpAfVpMXHVuRyAmI=;
        b=bAvx6mnivIh8+F3hD/cvtHVL2uuFeKG0PMgOyioQyMoaffFu7BLgDVXiMXIRNKv9Fb
         Gdar2fvh9E1xgjHrPmOt6jtrHGAH3homFfj0iffpLCP2c/4hl/8vnnB8oz1DU7M4DtRf
         0AdArwi9sLakxtal9gaeGDcwlQnGhCHhZBDJ2WqVOG6pSmEEJqh2aCJoGNGiOUG7DizO
         CJdxZuJN5eG1GIP/72WCXFQ8A/bpy+z9UjvNoB2oYHmf7puLoSFQpWNqFj6q0ntApPiO
         EH3Xv8xeON+rXhfkM62tfEuWNUQKPBHWlm6kXKkGu+vgWDnZ1KINjihJ6nXDpuA+XzaY
         0fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806844; x=1757411644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwYyCqIVck1DjzqxHtECjm8JozvkpAfVpMXHVuRyAmI=;
        b=XvDEJhpdYe7KSr56FWu1/5+03XXFMiTKCF5Dr5QKfG0VT5nYX430q+TLUYJ1i2YRZN
         k0REAByGv2Qifm+4kVPSlLVNAYrCaU7HYjVT8Zpyveo633l7vc7uo+R3ccNJYmMRFqXl
         HIo/uRUYdwDEfBgeUR2rqN6SYU/S3aR/dLex4rbDpghV9uNwYD3iFns0tfuD6xEVvXzC
         LXwptbvOLOVRMt+FWA4sye5DGVPGP3o62b2X856AaqdfjCb1WGVaBSrqN8QTqEr/o/8J
         jPTO/l4b3TPqhzMbQaUOjiXHu058uWPhwkccKDBU0f3nOa0sSLvEfNl17/v9oZ6luDUA
         Q1aQ==
X-Gm-Message-State: AOJu0Yy8zHGfsklknsmpWXi1L9U2vcotfG9YLa28T0GYdbOjL+uNPhDl
	LMcDyEd+km7MBRgtbvVM4FEjcoEiE9z6gS/bT1PVU7cK6kD0QfmM+5hcWVztgw==
X-Gm-Gg: ASbGnct3P4AKYbejM/+lobBM01GYwqxr6sScIGs71u6wm8rgvLE1eK+M7w3e/Omm8ex
	XiJrCckIiuBtFHCIwh70lLf1Wss1nETUoS5Z4xvFYpx+XKXoXVGjbcgAakzadVw4F2WHS7jzve+
	B5NSlztMNd5ELD7KWglwFKWoRZUWZO7CGmECEFV7+NpoNfEfTEHTQrXH1gjd02FdBxhurvzNGuV
	gnLvK6/x7V/Cc7oMJq95/m85r8FhKDVEN78bI43s8ZUmCx8INPJWBRGWyTJ8HXTeTmI/htsmZbH
	TcOH3OQzHVuJgkoTSwIaYV28MPyZCU/Fr4ci8voSroX4uHm9QBhgqrY3H40a6LEUyV4X+TOGR0Y
	BeyoI+8NyonHCKipwhSYuBazKK+VfBYZush4hDNEaKw==
X-Google-Smtp-Source: AGHT+IGfj8jq88nYRE9wgq3SAlrYZQI9l280GzIFzU/veUeJLABzr+QwR91E+yaaR+9cmz5c6f6sTA==
X-Received: by 2002:a05:6512:2522:b0:55f:6cd0:296b with SMTP id 2adb3069b0e04-55f70983a12mr3612052e87.49.1756806843406;
        Tue, 02 Sep 2025 02:54:03 -0700 (PDT)
Received: from dcbuildsrv.ci.qt.io ([192.89.120.62])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560826d1092sm583680e87.7.2025.09.02.02.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:54:02 -0700 (PDT)
From: Samuli Piippo <samuli.piippo@gmail.com>
X-Google-Original-From: Samuli Piippo <samuli.piippo@qt.io>
To: yocto-patches@lists.yoctoproject.org
Cc: jpewhacker@gmail.com
Subject: [meta-mingw] [PATCH] mingw-w64: Upgrade to 13.0.0 release
Date: Tue,  2 Sep 2025 09:53:24 +0000
Message-ID: <20250902095324.4049720-1-samuli.piippo@qt.io>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 09:54:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2106

Signed-off-by: Samuli Piippo <samuli.piippo@qt.io>
---
 recipes-devtools/mingw-w64/mingw-w64.inc                        | 2 +-
 ...-headers_12.0.0.bb => nativesdk-mingw-w64-headers_13.0.0.bb} | 0
 ...-runtime_12.0.0.bb => nativesdk-mingw-w64-runtime_13.0.0.bb} | 0
 ...eads_12.0.0.bb => nativesdk-mingw-w64-winpthreads_13.0.0.bb} | 0
 4 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-headers_12.0.0.bb => nativesdk-mingw-w64-headers_13.0.0.bb} (100%)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-runtime_12.0.0.bb => nativesdk-mingw-w64-runtime_13.0.0.bb} (100%)
 rename recipes-devtools/mingw-w64/{nativesdk-mingw-w64-winpthreads_12.0.0.bb => nativesdk-mingw-w64-winpthreads_13.0.0.bb} (100%)

diff --git a/recipes-devtools/mingw-w64/mingw-w64.inc b/recipes-devtools/mingw-w64/mingw-w64.inc
index 97315f4..1162966 100644
--- a/recipes-devtools/mingw-w64/mingw-w64.inc
+++ b/recipes-devtools/mingw-w64/mingw-w64.inc
@@ -4,7 +4,7 @@ LIC_FILES_CHKSUM = "file://${WORKDIR}/mingw-w64-v${PV}/COPYING;md5=bb936f0e04d8f
 COMPATIBLE_HOST = ".*-mingw.*"
 
 SRC_URI = "${SOURCEFORGE_MIRROR}/project/mingw-w64/mingw-w64/mingw-w64-release/mingw-w64-v${PV}.tar.bz2"
-SRC_URI[sha256sum] = "cc41898aac4b6e8dd5cffd7331b9d9515b912df4420a3a612b5ea2955bbeed2f"
+SRC_URI[sha256sum] = "5afe822af5c4edbf67daaf45eec61d538f49eef6b19524de64897c6b95828caf"
 
 UPSTREAM_CHECK_URI = "http://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/"
 UPSTREAM_CHECK_REGEX = "mingw-w64-v(?P<pver>(\d+[\.\-_]*)+)\.tar"
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_12.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_13.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_12.0.0.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-headers_13.0.0.bb
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_13.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_12.0.0.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-runtime_13.0.0.bb
diff --git a/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb b/recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_13.0.0.bb
similarity index 100%
rename from recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_12.0.0.bb
rename to recipes-devtools/mingw-w64/nativesdk-mingw-w64-winpthreads_13.0.0.bb
-- 
2.43.0


