Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1869.1792707515524379802
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 15:18:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=H1Hx6hMf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-202610222218331502878137000207e7-fkdtak@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202610222218331502878137000207e7
        for <yocto-patches@lists.yoctoproject.org>;
        Fri, 23 Oct 2026 00:18:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=eGiJClfu7hFo/p+kLaAZqHq28Wt6uoUoaTHAADQh14U=;
 b=H1Hx6hMfqcGrUH4zH8twWtaUaWDgv78/fCeHRHgbTIdSgmz687hbTd8SJPkU1f/YLWo1Gl
 8+Mc85eiTs5jC48kjnfAlMEocyg5Z01xJ6WdjlEbTlJPl7PcjEnSAYVnJxHQcLieksAKnr27
 b55GceebBCiiGKqU0gDLK40QMicHGuodkMCUqIcHHLmjbmDNR52IFjG+r6PAAO59uycEMDwV
 raUP4TmW+P3oGYdAOq0F/iYrqK0Z3tM3fcrxcwP9IZ+uuPbyWSEpjB3f55/5t9Rb7VvFzbnH
 0M5YCp1TRrBq13U4MdNJ48vJVJF3CfW3OlcnAjlh6hAoyoExZrJeS33A==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH 1/3] go: skip internal/cgrouptest when cpu.max is not available
Date: Fri, 23 Oct 2026 00:17:56 +0200
Message-ID: <20261022221758.3539336-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 22:18:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5137
Content-Type: text/plain; charset="utf-8"

From: Khem Raj <raj.khem@gmail.com>

The internal/cgrouptest ptest fails on qemux86-64:

  Erroring setting cpu.max: open /sys/fs/cgroup/go-cgrouptestNNN/cpu.max: permission denied

cpu.max is only present in cgroup v2 when the kernel is built with
CONFIG_CFS_BANDWIDTH, which the linux-yocto qemu configuration does not
enable, even though the cpu controller is available. Writing the missing
file makes cgroupfs return EACCES.

Add a patch so that InCgroupV2 skips the test when the new cgroup has no
cpu.max, consistent with its other best-effort checks.

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(From OE-Core rev: 7b925b30e4753bd3698792b83f18e0848a85ba3f)
Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 recipes-devtools/go/go-1.27.1.inc             |  1 +
 ...est-skip-when-cpu.max-is-not-availab.patch | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch

diff --git a/recipes-devtools/go/go-1.27.1.inc b/recipes-devtools/go/go-1.27.1.inc
index 61df455..d7ba03b 100644
--- a/recipes-devtools/go/go-1.27.1.inc
+++ b/recipes-devtools/go/go-1.27.1.inc
@@ -15,5 +15,6 @@ SRC_URI += "\
     file://0008-src-cmd-dist-buildgo.go-do-not-hardcode-host-compile.patch \
     file://0009-go-Filter-build-paths-on-staticly-linked-arches.patch \
     file://0010-cmd-go-clear-GOROOT-for-func-ldShared-when-trimpath-.patch \
+    file://0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch \
 "
 SRC_URI[main.sha256sum] = "4e408abae126d916b6164627193f2c54f0e3ca1312d693b86db45f862ab238b1"
diff --git a/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch b/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch
new file mode 100644
index 0000000..f13cf78
--- /dev/null
+++ b/recipes-devtools/go/go/0011-internal-cgrouptest-skip-when-cpu.max-is-not-availab.patch
@@ -0,0 +1,39 @@
+From 3335a08288a68ebce5f3e99745186ded36c564c9 Mon Sep 17 00:00:00 2001
+From: Khem Raj <khem.raj@oss.qualcomm.com>
+Date: Thu, 24 Sep 2026 10:22:23 -0700
+Subject: [PATCH] internal/cgrouptest: skip when cpu.max is not available
+
+The cpu.max interface file is only present in cgroup v2 when the kernel
+is built with CONFIG_CFS_BANDWIDTH, even if the cpu controller is enabled
+in the parent's cgroup.subtree_control. Without it, SetCPUMax tries to
+create the file, which cgroupfs rejects with EACCES, and TestInCgroupV2
+fails with:
+
+  Erroring setting cpu.max: open /sys/fs/cgroup/go-cgrouptestNNN/cpu.max: permission denied
+
+Skip, like the other best-effort checks in InCgroupV2, when the new
+cgroup does not have cpu.max.
+
+Upstream-Status: Submitted [https://github.com/golang/go/pull/81745]
+Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
+---
+ src/internal/cgrouptest/cgrouptest_linux.go | 6 ++++++
+ 1 file changed, 6 insertions(+)
+
+diff --git a/src/internal/cgrouptest/cgrouptest_linux.go b/src/internal/cgrouptest/cgrouptest_linux.go
+index ad9599c..a4b9b52 100644
+--- a/src/internal/cgrouptest/cgrouptest_linux.go
++++ b/src/internal/cgrouptest/cgrouptest_linux.go
+@@ -82,6 +82,12 @@ func InCgroupV2(t *testing.T, fn func(*CgroupV2)) {
+ 		}
+ 	}()
+
++	// cpu.max only exists when the kernel supports CPU bandwidth control
++	// (CONFIG_CFS_BANDWIDTH), even if the cpu controller is enabled.
++	if _, err := os.Stat(filepath.Join(path, "cpu.max")); err != nil {
++		t.Skipf("cgroup %s does not support cpu.max: %v", path, err)
++	}
++
+ 	migrateTo(t, path)
+ 	defer migrateTo(t, orig)
+
