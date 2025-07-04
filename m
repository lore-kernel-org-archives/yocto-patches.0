Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7779C8303D
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 21:34:29 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web10.5984.1751664866729303546
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Jul 2025 14:34:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Qz7HnJQw;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-454aaade1fbso13832815e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751664864; x=1752269664; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TnoeA625nI55hzLYtN/uZcm07tD7cQt2btc+2CkF5To=;
        b=Qz7HnJQwjr47T6JgWlBLlR/Jd4JS+22lZljKWgY3pOu4Vhshz7Qu2+1SNkNEzixqxj
         3bogdXPPDilyR3qsngoLqxtUQO5m+FrCkOo1Hbi6oNps1oJbCzBPxtKTM5ot+KBOoD+b
         PxKJU6dOITFxc9UHqOXuYrKKvEa1AjFOtSllw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751664864; x=1752269664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TnoeA625nI55hzLYtN/uZcm07tD7cQt2btc+2CkF5To=;
        b=wUBDWi65q04LafdlOcR5ItyFQWFFDj+wqzZGOTNFzoy8qI+prOiRwAfKRu398Jfx0t
         iJCQrsgYrYHN+4Sl8/Jae++VKZe0H5qgrd693zlbYLLMbEFzLKjmK6eYgpB4y1caoFSc
         eX+val+Crl3ynxaf20NztJQoSyFy6Q2BQQp3E5icewx4Qeg6KcwBHo5aJluTw4cmyeUk
         qmt/pWat8IyMdA8jmX/CBH367WNTG+h2TrpIWHZtrCk8yjipp2dBhmWJFuAf7IbojGZL
         oEAMIysL61sx+UG3iTxohGLU7bFBjg/7xJCNdnMOZ9JFOA9Jbbbfd4vTbTXq5ZZ/Jn3R
         2Afw==
X-Gm-Message-State: AOJu0Yx0Az4yxITdVlNRM6Ui5Lmn227RQTGLf4sabDevH4koLvwaOip2
	b/MTeQevAlVEo2eHhTLTDHmg2jrGXm3lH22Cr5+PiZ6FudSLiRb34rgdB7dZ5o1zShMa7dLkFkF
	rS+Et
X-Gm-Gg: ASbGncv6wLSIEIYsSOOaV0GQvCE9txXuwD2U4QfxReM29pyep3KT4cuAUyNk9ssim2W
	jYFz5MePr9SWQwYBvSdozSHszHCz/g+O2DuLVeaaxI3fsrk7n+u3h1CZOtxLwovXPyjRwbMdqFD
	foHmLsx3HyeTsPDRW6NLEeW4s+hXtNYCzWmA4A/TJPo017QpDS9ZutFoTV2VVz7SbvQZ18oF5fM
	Q0pu1DX42dEWtaZnk1+Qsk/r85EPwPNhUHxgBKAo+x1OYGOJKInTxBkeYDQ1oQwl2zw1z4bZPuu
	WyYpxfWEKEcLtGurRbQ/XLQ6+lQ034FjwzwfjEcA56XyhU2Vc+OL7GTb0SBAINdjNgqUD400/Ps
	NG7VxLczIeqPl6Q==
X-Google-Smtp-Source: AGHT+IFZVG7MBY9yk2NuUkQ0NYFabor44Waj9wZ1hObRDOJROq5mJ23GSqK3VLm9ZDtfUfV7oNzZ6g==
X-Received: by 2002:a05:600c:3b94:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-454bb2a32bbmr2354475e9.18.1751664864479;
        Fri, 04 Jul 2025 14:34:24 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f173:67fa:504:5b9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47030bd90sm3449791f8f.15.2025.07.04.14.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 14:34:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Nicolas Dechesne <nicolas.dechesne@oss.qualcomm.com>
Subject: [yocto-autobuilder2] [PATCH] config: Add meta-qcom
Date: Fri,  4 Jul 2025 22:34:21 +0100
Message-ID: <20250704213422.3862601-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Jul 2025 21:34:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1767

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.py b/config.py
index 1070fa8d..559ca99f 100644
--- a/config.py
+++ b/config.py
@@ -26,7 +26,7 @@ buildertorepos = {
     "qemuarm-oecore": ["oecore", "bitbake"],
     "checkuri": ["poky"],
     "check-layer": ["poky", "meta-mingw", "meta-gplv2"],
-    "check-layer-nightly": ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein"],
+    "check-layer-nightly": ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom"],
     "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
     "reproducible-meta-oe": ["poky", "meta-openembedded"],
     "patchtest": ["poky", "meta-patchtest", "meta-openembedded"],
@@ -72,6 +72,7 @@ repos = {
     "yocto-docs": ["ssh://git@push.yoctoproject.org/yocto-docs", "master"],
     "meta-clang": ["https://github.com/kraj/meta-clang.git", "master"],
     "meta-webosose": ["https://github.com/webosose/meta-webosose.git", "master"],
+    "meta-qcom": ["https://github.com/qualcomm-linux/meta-qcom", "master"],
 }
 
 trigger_builders_wait_shared = [

