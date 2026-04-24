Return-Path: <gouravsingh@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E92FE5204
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 10:28:14 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17938.1777026491478683094
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 03:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gouravsingh@siemens.com header.s=fm2 header.b=Ltsyytno;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1333022-20260424102807be2e6d3b37000207e0-xzzlga@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260424102807be2e6d3b37000207e0
        for <yocto-patches@lists.yoctoproject.org>;
        Fri, 24 Apr 2026 12:28:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=gouravsingh@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=t45p/aWvLp63c88KaUITPoFQxrEcTByo7zHrA+8KKX8=;
 b=LtsyytnouLlYLtjZtaoa7kibmnmfqgOy2dca5wjavZ3Z2/NtNaK+l6SusuOrGE9d7/UEMD
 +9a3gABB8SOGf+M3I7EkiC3e6WXOq23Pn8/Ds+Z83w8v0QzuoiP2EFef5aDEuJu34pn8TEjL
 KqhLC289GVOT0RrRrDlWrQCAhEj4iShk7ZAxa8oP4KGgICAV7M26x+SERY0GKFzD9Maas68X
 CaFhM6XpjMe8SL6JmXA8sannktbnMcqA6xL8t0/PJyaIueGkJ1zn25BMfTEyd6aJwOZoNDzj
 T0Q9u6lUoB0pD1QP5Ip77bt9V/BlMxrhlM9aBaNBKlwphtjUZ6LJHUmA==;
From: Gourav Singh <gouravsingh@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com,
	cedric.hombourger@siemens.com,
	Gourav Singh <gouravsingh@siemens.com>
Subject: [wic][PATCH] wic/plugins: gate root= with creator.rootdev for efi and pcbios
Date: Fri, 24 Apr 2026 15:57:42 +0530
Message-Id: <20260424102743.4182065-1-gouravsingh@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 10:28:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3789

Checks for creator.rootdev not being None were missing and would cause
the kernel command line to read "root=None". When using the Discoverable
Partitions Specification, we really want no root= parameter on the
kernel command line (and root=None is anyhow not a valid option).

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
---
 src/wic/plugins/source/bootimg_efi.py    | 5 +++--
 src/wic/plugins/source/bootimg_pcbios.py | 6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/wic/plugins/source/bootimg_efi.py b/src/wic/plugins/source/bootimg_efi.py
index 69aa38b..7d2175d 100644
--- a/src/wic/plugins/source/bootimg_efi.py
+++ b/src/wic/plugins/source/bootimg_efi.py
@@ -97,7 +97,7 @@ class BootimgEFIPlugin(SourcePlugin):
                         (get_bitbake_var("KERNEL_IMAGETYPE"), get_bitbake_var("INITRAMFS_LINK_NAME"))

             label = source_params.get('label')
-            label_conf = "root=%s" % creator.rootdev
+            label_conf = f"root={creator.rootdev}" if creator.rootdev else ""
             if label:
                 label_conf = "LABEL=%s" % label

@@ -186,7 +186,8 @@ class BootimgEFIPlugin(SourcePlugin):
             boot_conf += "linux /%s\n" % kernel

             label = source_params.get('label')
-            label_conf = "LABEL=Boot root=%s" % creator.rootdev
+            label_conf = "LABEL=Boot"
+            label_conf += f" root={creator.rootdev}" if creator.rootdev else ""
             if label:
                 label_conf = "LABEL=%s" % label

diff --git a/src/wic/plugins/source/bootimg_pcbios.py b/src/wic/plugins/source/bootimg_pcbios.py
index 1e5ec3a..b49d48d 100644
--- a/src/wic/plugins/source/bootimg_pcbios.py
+++ b/src/wic/plugins/source/bootimg_pcbios.py
@@ -231,8 +231,10 @@ class BootimgPcbiosPlugin(SourcePlugin):
             kernel = "/" + get_bitbake_var("KERNEL_IMAGETYPE")
             syslinux_conf += "KERNEL " + kernel + "\n"

-            syslinux_conf += "APPEND label=boot root=%s %s\n" % \
-                             (creator.rootdev, bootloader.append)
+            # Check if rootdev exists
+            root_param = f"root={creator.rootdev}" if creator.rootdev else ""
+
+            syslinux_conf += f"APPEND label=boot {root_param} {bootloader.append}\n"

         logger.debug("Writing syslinux config %s/syslinux.cfg", hdddir)
         cfg = open("%s/hdd/boot/syslinux.cfg" % cr_workdir, "w")
--
2.39.5


