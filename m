Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8112.1793701719361391434
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Nov 2026 02:28:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=jS04elge;
 spf=pass (domain: gmail.com, ip: 209.85.219.43, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-917a64f28d0so6389126d6.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701718; x=1794306518; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jC8KEXQUy39n/l0HK66FeK5k2lYPbAJ6ihrGWr9CGNA=;
        b=jS04elgeBdN1BJT/aTZLOBMHPC9oi3pXlE+QbtA1FcYPM/M+a05SRvqwW/Y37OtuJ2
         ekVv7SJ0APi0oAsBAv0z2Wb10SHboFOEH27qQ80CxuQbb/DpsQlHxh9w1N+GtRJn4qJY
         KcsGbt7uPUh/N9cERygviGyEFUcJLcE+dOrpXAwR3ZauaHCjO2wY1ARTWXVwtAztg0Ym
         tYOrOCp19u6fBInDDAJMZN2Emlag0Z00C4lr5zuYyovJAE5LeJdhmQ/mABItzRitW/g6
         zko4Ch/rvG6fWDC6sokKz4KPJofsW3CwfhgG6rsydHdVFtkaQYkghCBWeWKPl3NSEWMd
         F2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701718; x=1794306518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jC8KEXQUy39n/l0HK66FeK5k2lYPbAJ6ihrGWr9CGNA=;
        b=k+mGKOL5rUV9bP6x1qNz0qvqelRMAD346rsWNl6hgeOFN6qmb+WTOrVi9/5ATUxHwn
         T9ehkF5djN3JVm7ekMKtcOc9o/AaLuO71NO4SVb+PkujfS/7Sqzlcqm7G9u0qGy5xViD
         shSjsiVBIQA9Qz9GoxVWgxuUsvGsQOdRL8GTKSYXy03Ol7RNMSWWIgbslqnmP8bPEdNe
         6jEc+03JEheIjB78QUGGVY/ul3pbM0plxxzNE+WLK7PSW89eSth4kT2NQB2e8pOURJwP
         lgA34smyg3LbMo/y3oLDY30dsd03L/tUJRbDpflVcxvsK1keJQyjKMu86BuUMU9ngsLp
         vFoQ==
X-Gm-Message-State: APuU4Z9FKcwky7WP6ud+wts381Hzk7bFm5pUe/1yJqVk/zB1ChR8i04Z
	SAdfBq9fL1OA0Fv+/Zk9U4rrrLWCeZIvXa/vJT1rhuOjJHFUPhjJkt4psPg8Ww==
X-Gm-Gg: AYBFou3fMGEFoZRQAATMuN9rciMTSCA/PME49YHiw+V8ecRE+U0RYvuDDnmmj3A5m2I
	Z2a60Trim3QXpHmwZVvV4E2IbpH6Q9gCRWmAZFVcUdDf1heh7pmGP8R0HJtB5X+iSOvzQ946G8P
	MBQK9UbHlspe5jPy2m15VGbBKzKDqTYe87wIrb/r/uvI4hierR1FbFYemSwvE+2IJgVO/DTUzLq
	poJPLC5ww5ZHMxyQtlJkpvyy2p683HJmzlBovf3v28S1lccIt9xv8u9TJRKbEJDC0AUbnZnnDY9
	vR06yip1t73WOBAXutVmppQxHe6OWda2eNOYkb4tmMcQgWYm5hACcq8Kq3vhSKLNWD9BNNHtClt
	Rvgae61IXqMIYQtRa3EidHxdvdsId7WEeKsNcdI+ESPxa44askOcchw09DIKquydtE7PruMzDuh
	lecrUB3b4Ao3YccwuB1jG19YCNezkSSXTR+UKGmu3bE3R/MrG65bYKqhbnt35dY7EUY32x2osZv
	h4NoygORW56ilvJDRqzphw9SJ8nVZToSGwvVbg2XPchMFcvaUF8BbloIo1R+h9oI9LHxnLVjh5t
	Pq99R11wkHoSyS6mpQQCKKA0/px1wgl4LPRGWgEsScls6/ZF8habjW3ZE/gwavxOPMSXPq/VYIr
	bxSb9M2CLTms0gygRzbc5xOiMnIwaE7WKcc5CTKftLoj/zWm6BivJ
X-Received: by 2002:a05:6214:4e82:b0:91c:c4ea:6b9f with SMTP id 6a1803df08f44-91cc4eac03bmr74594766d6.28.1793701717972;
        Tue, 03 Nov 2026 02:28:37 -0800 (PST)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91cd064ca1asm20022926d6.42.2026.11.03.02.28.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:28:37 -0800 (PST)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v4] kernel: add config fragment for lttng-modules prerequisites
Date: Tue,  3 Nov 2026 05:28:34 -0500
Message-ID: <20261103102834.1507595-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 03 Nov 2026 10:28:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5218
Content-Type: text/plain; charset="utf-8"

The machines in this layer have no BSP description in yocto-kernel-cache
and build from an in-tree defconfig via KBUILD_DEFCONFIG, so the
standard kernel type's configuration never reaches them. Neither the arm
nor the arm64 defconfig enables what lttng-modules needs: kprobes is a
hard compile failure, and without the tracing infrastructure the build
silently produces no modules at all.

Ship the missing subset as a fragment in the layer's own kmeta, so it
resolves for any recipe here rather than only for ones that fetch the
kernel cache.

AI-Generated: codex/claude-opus 5 (xhigh)
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
changes in v4:
- reword the fragment comment so no line opens with a CONFIG_ symbol
  name; kconf_check reads such a line as a malformed "is not set" entry
  and reports the fragment as badly formatted on every build

changes in v3:
- move the fragment into the layer's own kmeta and reference it from
  KERNEL_FEATURES, rather than adding a bare .cfg to SRC_URI, so it sits
  with the layer's other kernel metadata and can be named
- enable CONFIG_FTRACE_SYSCALLS, and justify the symbol set by what
  ktypes/standard already gives a cache-described BSP (features/kprobes,
  features/ftrace) rather than deriving it from first principles
- leave CONFIG_KALLSYMS_ALL unset: ktypes/base sets it to n, so the
  lttng writeback probe is dropped everywhere and this layer should not
  diverge
- considered yocto-cfg-fragments (as meta-virtualization does) and
  CONFIG_ENABLE_DEFAULT_TRACERS as a lighter route to tracepoints; both
  were dropped in favour of matching the standard kernel type, which
  every other linux-yocto BSP already gets
---
 recipes-kernel/linux/linux-rockchip.inc          |  1 +
 .../rockchip-kmeta/bsp/rockchip/lttng.cfg        | 16 ++++++++++++++++
 .../rockchip-kmeta/bsp/rockchip/lttng.scc        |  1 +
 3 files changed, 18 insertions(+)
 create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.cfg
 create mode 100644 recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.scc

diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
index 6c62e849834c..b87cb7a14bf8 100644
--- a/recipes-kernel/linux/linux-rockchip.inc
+++ b/recipes-kernel/linux/linux-rockchip.inc
@@ -34,5 +34,6 @@ COMPATIBLE_MACHINE:soquartz = "soquartz"
 SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
 SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
 
+KERNEL_FEATURES:append:rockchip = " bsp/rockchip/lttng.scc"
 KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
 KERNEL_FEATURES:append:rockchip:aarch64 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.cfg b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.cfg
new file mode 100644
index 000000000000..cde4bfcece67
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.cfg
@@ -0,0 +1,16 @@
+# Prerequisites for building lttng-modules.
+#
+# These symbols are what ktypes/standard gives every BSP that has a
+# yocto-kernel-cache description, via features/kprobes and
+# features/ftrace, trimmed to what lttng-modules uses: kprobes is a hard
+# compile requirement (src/wrapper/kallsyms.c), and the tracing
+# infrastructure is what it traces with - without it the build produces
+# no modules at all rather than failing.
+#
+# KALLSYMS_ALL is deliberately absent: ktypes/base sets it to n, so the
+# lttng "writeback" probe is dropped on every linux-yocto BSP and this
+# layer has no reason to diverge.
+CONFIG_KPROBES=y
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_FTRACE_SYSCALLS=y
diff --git a/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.scc b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.scc
new file mode 100644
index 000000000000..2d0412541c81
--- /dev/null
+++ b/recipes-kernel/linux/linux-rockchip/rockchip-kmeta/bsp/rockchip/lttng.scc
@@ -0,0 +1 @@
+kconf non-hardware lttng.cfg
-- 
2.50.0.173.g8b6f19ccfc3a

