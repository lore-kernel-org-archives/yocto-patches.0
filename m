Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30574.1792963013587268937
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 25 Oct 2026 14:16:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=QQYz3ufc;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: twoerner@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53381e53b80so26178801cf.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 14:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792963012; x=1793567812; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TtJKC4y98p3nJufYGi2adWTCwwba3pzsjOpFc0D3WwI=;
        b=QQYz3ufcIMK46yg0zOjh9zSiRI70vdEPzKV+UqUflE42XVkNYGCLaEcxe/UCBsv2vo
         zjwlu5DiXYYL3pt9nc6KzTtgDW25B5pAZVZHwjzCLEEWFoBVnyHVOTdzbfwwttwQGN7O
         otjhDhtLPhsZ1x1Z4rf6GDO9THph2zod35D3UbZpMO/SbY1x8Dci//IPb365662LZcsR
         vnvqPxf+IUSydFN8/GIIi4YfXKZ6y0VTVAa2m/enl23ItHNg7VY9JnhCZA5k18Ykoh0/
         PMZAterostx6tpElpn5pT6YN42TgC3AWooCXc5h1EbzFsvdP2EJxhNMbIu518xFetolH
         GUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792963012; x=1793567812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TtJKC4y98p3nJufYGi2adWTCwwba3pzsjOpFc0D3WwI=;
        b=HHw3k+uMQ7GBHIy1EX7uU73BGNst+uwIAskxuxLbOGq59utXH+JZDKrhAKK4sISOkb
         yflExMX0MxwQDAMb8FlYG+LMq0MNFThv0WLGW+1Xa2MtQMV+TmEuFQfhZEZiLJFm8txH
         eE7rNSdgo8vlkIlmZtpc9tLbGL29AM3HXOUWUaCXlgSQje64BGLsGAhFKsvpaR5AYsih
         NjyKEBIl11J2hSDgh9ripgiF3zy0tk56fPg7JvakaD70NPLDblnJEbY2UeMeQ/XWJAMe
         TMqGKhfnSlOMktDKHT5o1BoKthyTxQ9JBoIoJNwC1DGJR7VDPK6vzpcHKtn2mX+HVSWe
         ecjQ==
X-Gm-Message-State: AFq9FYKbSarwmtX+0HJEaCzs9IWyywl7XKwF876ddNeXDLbqJlDFTchp
	V1B7fSV9e4zGwNCsJDaYFYgCPUi3HjuHF/eo2QRJdGYbEhb/SkjEZWfrcINW1A==
X-Gm-Gg: AYBFou1erFAilBDMMffarOZRHD2wnpq6aEE3gsBD+2d0aY0nIMCfuu4xcPQxNcpYoYX
	6/VVtrm25bWPSLOFQj5iwG9lWrKpnzEOLktbWQq9Oiunqv284gxcE+cJxzWMSfNyNrfr9HtHNi7
	LqlHQZwKM9vvJVJF/glcAXwvNCKrA6EV6jHsG2j4hMAhcDBOGfMWWWT4rXHSATQgy3jLBe45Cr+
	ZbCu8pfi2hNxBE/sacO1i59gwGgpM7iF6fOPt5OLtgoGIqdToVQzvVraRWd2letTJD4p17bA/53
	j1Pu/s/o8PiQQFmobebrHfGqH9Q5+Kb9QhPSDFMEEdlLE04WNYcDDOZyVkRKDWlIPd4joYoZtPE
	P3/E7+RfTN9vmA2cX2nRkdkK6iwSykm15+N8DcHihHJ4I5tyDgP+84RM/ELSLZiJudTzlK2huyC
	0CSLqQIOmfUIsBC2JwLPSBIPyM6ilKflFa0WdnhCL0hBD7Dw5piIBxVDCzXzmQohSouvFAeGANG
	Vuk80Ghtqmt6tfZO2X95M7vvpwJFfoZhI6iyAwi+c4gZDH2hpS8V8CkbsuxZV+PX+/84gJaVEEt
	YEE+ofdpyu12UI847frDDA==
X-Received: by 2002:ac8:5d11:0:b0:536:3d09:99a7 with SMTP id d75a77b69052e-5383b73743bmr74704661cf.64.1792963012376;
        Sun, 25 Oct 2026 14:16:52 -0700 (PDT)
Return-Path: <twoerner@gmail.com>
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c6158e404sm9379366d6.10.2026.10.25.14.16.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:16:51 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-rockchip][PATCH v3] kernel: add config fragment for lttng-modules prerequisites
Date: Sun, 25 Oct 2026 17:16:48 -0400
Message-ID: <20261025211648.2608396-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sun, 25 Oct 2026 21:17:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5154
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
index 000000000000..c92c62be2b8b
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
+# CONFIG_KALLSYMS_ALL is deliberately absent: ktypes/base sets it to n,
+# so the lttng "writeback" probe is dropped on every linux-yocto BSP and
+# this layer has no reason to diverge.
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

