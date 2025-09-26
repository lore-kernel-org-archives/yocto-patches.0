Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEE1CAC5B8
	for <webhook@archiver.kernel.org>; Fri, 26 Sep 2025 16:53:36 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.263.1758905610643417288
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 26 Sep 2025 09:53:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UfOCJUhP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e29d65728so16340425e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758905608; x=1759510408; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIG2SVkeSdsQfERkSIKA6LMaXnA5Q0JI3vNOEM4VCWE=;
        b=UfOCJUhPLh2+evcHix+ThXVVe9GJUOHeJwHSlpa62G9AYYRASsXMxcGEGTw9P5KMw8
         qbyDjm0d+hQwwY9nSSyPIP006LDgd1QvB44S+a4Rmbbh6FvmGONSJfVgElh8aYlQvAKN
         G48u/YkI73mqVZwmjFL+Rdki1ugtnkCqtZONo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905608; x=1759510408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIG2SVkeSdsQfERkSIKA6LMaXnA5Q0JI3vNOEM4VCWE=;
        b=bSYN8GNjxkSabPlTqDVffmbvNSmhV9Liwth79Yan9MCh2blM9H4UHCMQ5Z5WCoJsxX
         o91lQ89AFYWF7P78Dcawy0UQiR9ZkLRO79BNEml14YsWOitC3l4IZxcV/DX326zFcez0
         mpnsLlr+SYE+NwjO0GgUK0CscX7917Nr3FIr2PGG46WJT29RZnlFfX3ob/oqyvldhuP6
         l2AoYfk3adRgxPgs17/PmYzTegDiBXTBdus6CClrcx5Nmqqs9V78X4tcUXP0Kk+iEdzW
         5Je/sabn9A58eWJozFg0/S01maS+x3qpCPSNbn8SDbsDoR4mEmxazvGcJsG9Q3zeLRar
         8PEQ==
X-Gm-Message-State: AOJu0YxvylvCdGXkoUq1vS9LiLLGtmvuO92zMD61ROAV4iKCX15987iT
	OxXY/nEJNBnneHuVKE5HLfpqTENQ2gBiHxZaDcTvwhrcYTuoGnjOF/Mv+F2e3gt95ISJyr7cEkH
	rc14T
X-Gm-Gg: ASbGncvzzcGEd9GCaOWHgEnqzwpCJ2+AL8FN1WIFyAJg5aAuSV/Xai8jC27V3MPbi/K
	KMpoHchpcR7R1/z3F74buao2nW/meeTNw3ZgjB6o7xrHTwEjgNbWyBldUD6BdH78JvXhVzvuuD6
	7q1Ym5L2M0H0vAj7S5PL81uE7ZSKxa9S0Uq9VL4X7RZTw/uT33b9sjmXtoKoRsoGHBBpf3pi8kX
	tCsfFhUnVmAgJfDcp/yEZHlwDSr0+jyUrefyk4EE8wgtd65nov1itxK1P7fNsV4EZI33t8nEVfR
	uRl0ZhsnkPknAfnnPNsKuJbzyxPpFNj0BSIty1m+eO8tAWzq4GOi4Gjx3Ll5mRC/Q/I66PFzvMZ
	tMVSYMdFdyaXlFIQQOh6wUI+qCZEEq72Zen/zkbFhvTWTl15EyrE=
X-Google-Smtp-Source: AGHT+IG6HMa9Ha5jNEJSVGXPpfbHz4z/hYy8FeNy+fNO4OgmLAQ7BEvnmxmPxg3trod4TVgHTLzRQw==
X-Received: by 2002:a05:600c:34c4:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46e3dc2ed43mr23306615e9.27.1758905608351;
        Fri, 26 Sep 2025 09:53:28 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8a7a:1fb6:e6df:2fa7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb71esm7603106f8f.1.2025.09.26.09.53.27
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:53:27 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2] [PATCH] config.py: Add bitbake repo alongside poky
Date: Fri, 26 Sep 2025 17:53:26 +0100
Message-ID: <20250926165326.30733-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Sep 2025 16:53:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2240

To allow builds with bitbake-setup to replace poky, we need the bitbake in cases
where we currently have poky. Therefore add this.

Workarounds have need added to the helper branches to allow existing builds
to filter this new repo out.

This also means the UI becomes slightly confusing with two different potential
repo configs. One is used, one isn't depending on the target of the build. This
was the least worse way to handle this I could find.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.py | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/config.py b/config.py
index 1b14538c..16a25cfb 100644
--- a/config.py
+++ b/config.py
@@ -9,32 +9,32 @@ buildertorepos = {
                 "meta-mingw", "meta-gplv2"],
     "a-full": ["poky", "meta-intel", "oecore", "bitbake",
                 "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang"],
-    "non-gpl3": ["poky", "meta-gplv2"],
-    "meta-mingw": ["poky", "meta-mingw"],
-    "qa-extras": ["poky", "meta-mingw"],
-    "meta-oe": ["poky", "meta-openembedded"],
-    "meta-virt": ["poky", "meta-openembedded", "meta-virtualization"],
-    "meta-intel": ["poky", "meta-intel"],
-    "meta-exein": ["poky", "meta-exein", "meta-openembedded"],
-    "meta-arm": ["poky", "meta-arm"],
-    "meta-agl-core": ["poky", "meta-agl"],
-    "meta-aws": ["poky", "meta-aws", "meta-openembedded"],
-    "meta-clang": ["poky", "meta-clang"],
-    "buildtools-docs": ["poky", "meta-openembedded"],
+    "non-gpl3": ["bitbake", "poky", "meta-gplv2"],
+    "meta-mingw": ["bitbake", "poky", "meta-mingw"],
+    "qa-extras": ["bitbake", "poky", "meta-mingw"],
+    "meta-oe": ["bitbake", "poky", "meta-openembedded"],
+    "meta-virt": ["bitbake", "poky", "meta-openembedded", "meta-virtualization"],
+    "meta-intel": ["bitbake", "poky", "meta-intel"],
+    "meta-exein": ["bitbake", "poky", "meta-exein", "meta-openembedded"],
+    "meta-arm": ["bitbake", "poky", "meta-arm"],
+    "meta-agl-core": ["bitbake", "poky", "meta-agl"],
+    "meta-aws": ["bitbake", "poky", "meta-aws", "meta-openembedded"],
+    "meta-clang": ["bitbake", "poky", "meta-clang"],
+    "buildtools-docs": ["bitbake", "poky", "meta-openembedded"],
     "qemuarm-oecore": ["oecore", "bitbake"],
-    "checkuri": ["poky"],
-    "check-layer": ["poky", "meta-mingw", "meta-gplv2"],
-    "check-layer-nightly": ["poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom"],
+    "checkuri": ["bitbake", "poky"],
+    "check-layer": ["bitbake", "poky", "meta-mingw", "meta-gplv2"],
+    "check-layer-nightly": ["bitbake", "poky", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-openembedded", "meta-virtualization", "meta-ti", "meta-security", "meta-clang", "meta-exein", "meta-qcom"],
     "docs": ["yocto-autobuilder-helper", "yocto-docs", "bitbake"],
-    "reproducible-meta-oe": ["poky", "meta-openembedded"],
-    "patchtest": ["poky", "meta-patchtest", "meta-openembedded"],
-    "meta-oe-mirror":  ["poky", "meta-openembedded"],
-    "auh":  ["poky", "auto-upgrade-helper"],
-    "auh-meta-oe":  ["poky", "meta-openembedded", "auto-upgrade-helper"],
-    "metrics":  ["poky", "meta-openembedded"],
-    "metrics-gitstats":  ["poky", "oecore", "bitbake", "meta-openembedded", "yocto-docs"],
-    "meta-webosose":  ["poky", "meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
-    "default": ["poky"]
+    "reproducible-meta-oe": ["bitbake", "poky", "meta-openembedded"],
+    "patchtest": ["bitbake", "poky", "meta-patchtest", "meta-openembedded"],
+    "meta-oe-mirror":  ["bitbake", "poky", "meta-openembedded"],
+    "auh":  ["bitbake", "poky", "auto-upgrade-helper"],
+    "auh-meta-oe":  ["bitbake", "poky", "meta-openembedded", "auto-upgrade-helper"],
+    "metrics":  ["bitbake", "poky", "meta-openembedded"],
+    "metrics-gitstats":  ["bitbake", "poky", "oecore", "bitbake", "meta-openembedded", "yocto-docs"],
+    "meta-webosose":  ["bitbake", "poky", "meta-clang", "meta-openembedded", "meta-qt6", "meta-webosose", "meta-security"],
+    "default": ["bitbake", "poky"]
 }
 
 # Repositories used that the scripts need to know about and should be buildbot

