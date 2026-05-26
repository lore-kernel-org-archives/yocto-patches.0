Return-Path: <gouravsingh@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3537ECD5BD0
	for <webhook@archiver.kernel.org>; Tue, 26 May 2026 09:32:17 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33379.1779787929461838334
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 26 May 2026 02:32:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm1 header.b=VIVnbDlb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1333022-2026052609320540d682263900020786-xrk8va@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026052609320540d682263900020786
        for <yocto-patches@lists.yoctoproject.org>;
        Tue, 26 May 2026 11:32:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qZpqnLLDjbEUIUdZVWerFm42coCSHoMAn7mm3tGIBm0=;
 b=VIVnbDlbrXPinYzkz6qPzbHtq4RKQxABom0Gd7Z+n2AkDkqrvKK90UJWGJKyHWKQRGzluK
 jI2z+thXeoI3NxSOLa8pb60zUwyolszhPoywZeC9i0LKz/cag2z74eqwiYgyPQF/S9qzLQtU
 /nEZWdN8IW3lbB/nzuHnPnFuwQ/8mI6RGuJWCWRREOlgma9DkSbMzwtaAiQBu09Yvhe5Tom9
 QPQPpCfoq6ew6C/4WaGRxL7ufQ8J3RBPfwuh6GhsxwYqGBUJyUvvMU7vjbkLXVJNM0ljCVqq
 YA72QEpYRRh572i6RwCMc5cvc4LkJzLNjUTTstFyOdNQvTaRge4nC3ig==;
From: Gourav Singh <gouravsingh@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	Gourav Singh <gouravsingh@siemens.com>,
	Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: [wic][PATCH v2] wic/plugins: gate root= with rootdev check for efi, pcbios and partition
Date: Tue, 26 May 2026 15:01:32 +0530
Message-Id: <20260526093132.1956645-1-gouravsingh@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 26 May 2026 09:32:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4053

Checks for creator.rootdev (or cr.rootdev) being None were missing
and would cause the kernel command line to contain "root=None". When
using the Discoverable Partitions Specification, no root= parameter
should appear on the kernel command line, as root=None is not valid.

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 src/wic/plugins/source/bootimg_efi.py       |  5 +++--
 src/wic/plugins/source/bootimg_partition.py | 11 +++++++++--
 src/wic/plugins/source/bootimg_pcbios.py    | 10 ++++++++--
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/source/bootimg_efi.py
index 69aa38b..fe6c222 100644
--- a/src/wic/plugins/source/bootimg_efi.py
+++ b/src/wic/plugins/source/bootimg_efi.py
@@ -97,7 +97,7 @@ class BootimgEFIPlugin(SourcePlugin):
                         (get_bitbake_var("KERNEL_IMAGETYPE"), get_bitbake_var("INITRAMFS_LINK_NAME"))

             label = source_params.get('label')
-            label_conf = "root=%s" % creator.rootdev
+            label_conf = "root=%s" % creator.rootdev if creator.rootdev else ""
             if label:
                 label_conf = "LABEL=%s" % label

@@ -186,7 +186,8 @@ class BootimgEFIPlugin(SourcePlugin):
             boot_conf += "linux /%s\n" % kernel

             label = source_params.get('label')
-            label_conf = "LABEL=Boot root=%s" % creator.rootdev
+            label_conf = "LABEL=Boot"
+            label_conf += (" root=%s" % creator.rootdev) if creator.rootdev else ""
             if label:
                 label_conf = "LABEL=%s" % label

diff --git a/src/wic/plugins/source/bootimg_partition.py b/src/wic/plugins/source/bootimg_partition.py
index 96f5e14..2e89b6c 100644
--- a/src/wic/plugins/source/bootimg_partition.py
+++ b/src/wic/plugins/source/bootimg_partition.py
@@ -118,8 +118,15 @@ class BootimgPartitionPlugin(SourcePlugin):
             if has_dtb:
                 extlinux_conf += "   fdtdir %s\n" % fdt_dir
             bootloader = cr.ks.bootloader
-            extlinux_conf += "append root=%s rootwait %s\n" \
-                             % (cr.rootdev, bootloader.append if bootloader.append else '')
+
+            # Check if rootdev exists
+            parts = ["rootwait"]
+            if cr.rootdev:
+                parts.insert(0, "root=%s" % cr.rootdev)
+            if bootloader.append:
+                parts.append(bootloader.append)
+
+            extlinux_conf += "append %s\n" % " ".join(parts)

         install_cmd = "install -d %s/extlinux/" % hdddir
         exec_cmd(install_cmd)
diff --git a/src/wic/plugins/source/bootimg_pcbios.py b/src/wic/plugins/source/bootimg_pcbios.py
index 1e5ec3a..2ae4eb1 100644
--- a/src/wic/plugins/source/bootimg_pcbios.py
+++ b/src/wic/plugins/source/bootimg_pcbios.py
@@ -231,8 +231,14 @@ class BootimgPcbiosPlugin(SourcePlugin):
             kernel = "/" + get_bitbake_var("KERNEL_IMAGETYPE")
             syslinux_conf += "KERNEL " + kernel + "\n"

-            syslinux_conf += "APPEND label=boot root=%s %s\n" % \
-                             (creator.rootdev, bootloader.append)
+            # Check if rootdev exists
+            parts = ["label=boot"]
+            if creator.rootdev:
+                parts.append("root=%s" % creator.rootdev)
+            if bootloader.append:
+                parts.append(bootloader.append)
+
+            syslinux_conf += "APPEND %s\n" % " ".join(parts)

         logger.debug("Writing syslinux config %s/syslinux.cfg", hdddir)
         cfg = open("%s/hdd/boot/syslinux.cfg" % cr_workdir, "w")
--
2.39.5


