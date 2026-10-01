Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A8BCA5FD2
	for <webhook@archiver.kernel.org>; Thu,  1 Oct 2026 16:05:12 +0000 (UTC)
Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14794.1790870710068947206
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 Oct 2026 09:05:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EqmqxRa0;
 spf=pass (domain: gmail.com, ip: 74.125.230.232, mailfrom: twoerner@gmail.com)
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5ce9914dso594037985a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 Oct 2026 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790870709; x=1791475509; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=F2BXKMOzJMnWbAfWBesIItA9nk6sAyYYujfaAHSqGpg=;
        b=EqmqxRa0ZW54SNwogMl4f4RMj/MMCCHfFsP1WD7qj9IjVlTdwd5lRZvPM1fAo0+fTE
         e6+jCA2b5ReC9ieLRvYqDKaoraTeNXDsI6eDMqU/n3IEs8yIVS3nvpNFGreU6HNVYCkT
         uuLHryRetGDwUu9dVT6hUs/uzGCiG59ZVvQnQf7f4A5koxWm+W7RzP4hEcaJeu5q1j0s
         t11bG2SIzOfEzjdYzhT9z65Yn2xYAQ6AGEtcCzPDIJus1lL0j9XwxPxMOPsuyKoJs49D
         kYiBpmd2VXW0a3z4GZhiHVJ/ZQR3R6fsPBoKNM4Rd1O/CbtYigiR8X2pri5QqWlqzMMi
         Kyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790870709; x=1791475509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=F2BXKMOzJMnWbAfWBesIItA9nk6sAyYYujfaAHSqGpg=;
        b=vJ9QkC5xkHAGMquEq9KhSIz8nO4CqTTCmGDTsyMv3MhwBRXkEcVmOY3HiNtNBvIShH
         AhbdoAdxyEkQa8cXhfrj4AhLmkfbJY9GNGWp1mmw98oGXc6kP7y4o7b2BWg+WGVXP5fM
         tcJWwljwn+5bRtUMyTALHRQBweklCmK2kXzhRuYBAiOQMVhQhDUype6/L3SorQn4lvl1
         hKSsbGBHrHmvRrFH0E/T7S6T/YtglAhc6zTVIzbH6TliREcDZ5CHXwX6sShoblCNm9Gc
         hzdDXI/ruL5PqeRSGchOBM93OhzMAWTsy5dWti4cFC7XaYaNOlpGc88cSal6oafgW1cd
         u1dQ==
X-Gm-Message-State: AFuF++ml8Yt1IGpFabG9PebKYj/kf4mbB4phLsCqdmcUXuCf7h3MPRoM
	ZZWpmcLmc0SxJLlmKCfGipGgALUomDUcisxHJWLC/7WqUsBe9wfV67Li+wvMXg==
X-Gm-Gg: AYBFou0lwWLVGs/xtwm6lXq0TxAMA5PmNLrz7EB9ol835c0eWai0ywD2qo2jwtpFJrb
	zMTEEH0vPATtRQ8Ij6qU+JteX+tN1CSUKd+hyxB1r/w+84IeOaSglLH33+MCa7KDnKRvM24/bU4
	7dOVoYeekdnDwWTdtjfKwooCe3jmW+vwVAquMBdjZuvtLnc9eui82PSOzKFhIr9UAJjFe6C0wW+
	JAxrUStjuCcbVUlsaNrbH27RZvJFwQyEqDbqH6e1rcC7PjRMoRFFkXZy8PziQOKxEwnmnJyyn22
	bYEZ9A0g8g8/t5J7gge/F6E6GFgdobmOJrRrNcQVD69JYXJIoqbtWQpJCs3eJczlfceEX3hovhj
	qQLtyrNhTPR8KnRZuZv87a58mPDArhDrN9DdXS84sUkgiUxV88i2Izrbl8r/6twnzEnFz2+iXAB
	cS5tZosoQc4e8b+Xjcw6S0DZJ8gVxivSznvGIcz4Yb8waFFbYeesW7blZ3j0YaQ/gfjX+p1Ttng
	wsnToCImb7/Ag9akgq6PRUA0quODPSJ5stzaXOp7NTloDUmPVk=
X-Received: by 2002:a05:620a:370a:b0:93c:b47b:26f with SMTP id af79cd13be357-93cb47b0cd1mr689627485a.49.1790870708637;
        Thu, 01 Oct 2026 09:05:08 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cc7069299sm38299185a.33.2026.10.01.09.05.07
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:05:07 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v2] kernel: add config fragment for lttng-modules prerequisites
Date: Thu,  1 Oct 2026 12:04:57 -0400
Message-ID: <20261001160457.3405886-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Oct 2026 16:05:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4976

These machines build from an upstream defconfig via KBUILD_DEFCONFIG
rather than a yocto-kernel-cache BSP, so the standard kernel type's
configuration never applies and lttng-modules gets neither CONFIG_KPROBES
(a hard compile failure) nor CONFIG_TRACEPOINTS (builds no modules at
all). Ship the fragment in-layer so it works for any kernel recipe here,
not just ones that fetch the kernel cache.

AI-Generated: codex/claude-opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v2:
- drop the dependency on yocto-kernel-cache; v1 added
  features/kprobes/kprobes.scc to KERNEL_FEATURES, which only resolves
  for kernel recipes that fetch the cache. linux-yocto fetches it in
  linux-yocto_7.2.bb, not in linux-yocto.inc, so recipes that require
  only the .inc never get it.
- a KERNEL_FEATURES entry that is not found is a hard do_kernel_metadata
  failure, not a warning, so a shared .inc can only reference fragments
  the layer itself ships. Ship the config in-layer instead.
- widen from :rockchip:arm to :rockchip. CONFIG_KPROBES is absent on
  every machine in the layer; 32-bit merely fails loudly. arm64 also
  lacks CONFIG_TRACEPOINTS, so lttng-modules silently builds zero
  modules and ships an empty package.
- link to v1:
  https://lore.kernel.org/yocto-patches/20260326130653.478746-1-twoerner@gmail.com/
---
 recipes-kernel/linux/linux-rockchip.inc       |  1 +
 recipes-kernel/linux/linux-rockchip/lttng.cfg | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-rockchip/lttng.cfg

diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index 6c62e849834c..8e73c84a95ea 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -32,6 +32,7 @@ COMPATIBLE_MACHINE:rock64 = "rock64"
 COMPATIBLE_MACHINE:soquartz = "soquartz"
 
 SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
+SRC_URI:append:rockchip = " file://lttng.cfg"
 SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
 
 KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
diff --git a/recipes-kernel/linux/linux-rockchip/lttng.cfg b/recipes-kernel/linux/linux-rockchip/lttng.cfg
new file mode 100644
index 000000000000..17ba2a8116eb
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/lttng.cfg
@@ -0,0 +1,17 @@
+# Prerequisites for building lttng-modules.
+#
+# These machines have no BSP description in yocto-kernel-cache and build
+# from an upstream defconfig via KBUILD_DEFCONFIG, so the standard kernel
+# type's configuration is never applied and neither the arm nor the arm64
+# defconfig enables what lttng-modules needs.
+#
+# kprobes is required outright: src/wrapper/kallsyms.c fails to compile
+# without it on kernels >= 5.7.
+#
+# Tracepoints are what lttng-modules actually traces with, but that
+# symbol has no prompt and can only be selected, so enabling the function
+# tracer is what pulls it in. Without tracepoints lttng-modules builds no
+# modules at all rather than failing, leaving an empty package behind.
+CONFIG_KPROBES=y
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y
-- 
2.50.0.173.g8b6f19ccfc3a


