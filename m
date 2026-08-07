Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D16C2A09B
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 13:15:54 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42447.1786108550278089920
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Aug 2026 06:15:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=lVe7LaiW;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so39185195e9.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108548; x=1786713348; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+l+QhK4VRk4ACjtS2PZnl1YIEr2T4//y3tTT+F6lLTk=;
        b=lVe7LaiWpa2AE7PJD7mlKwPZ5VBzAUKvHR01+2uD9TkIwbNSVEvYFZEPe+AIzBNURV
         PxEkHbV3IGmuNOjK6Nu6xM+xbHc9VkPjzp/VuFhN1dITy/IQ+Uy26h7+t7ZPBhfBRDot
         Js87r+AK2pMMGUbKBoMfk7GyGCQK+nfRIyFITdsE7wAsji1rmF/72jNcPLRE6IPn7mYi
         dADf+2JqVVqujI1ct4HPUCY8AJQWoSwpnRmleJC2H77kr+X0+GBMMb0Uc6q76A5upd3O
         R2lqy2b5wr7iK2vMQcM5FNwskUzTMGSfbmfN5umIjno8j2rLLnnQ3Sq7CNn0n8vdwjxF
         GIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108548; x=1786713348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+l+QhK4VRk4ACjtS2PZnl1YIEr2T4//y3tTT+F6lLTk=;
        b=JbFDnrBGegRcG2fAvHAufKBe1n0v3Ig7zyGuV4LoVf63Brt6fC6qpLaPfJ1aBPU8h7
         xWvaMrd38BA+f6OWJHKMo7HSgNm8TpeaEu56td5xlwAcWpD2Hjb7230jadRjvJMCw7K9
         r5+rGAH0tNKRlrujudGplsA4LB5boxxrvbbSpIp2J1YRbv2Vgi4DhQW+aKqFgtm1g77E
         V3IPFSY4HycPBna5ib3jB7i8mrRq6jgcuaasl7juiOim/wEp9+djPkU4vTQRhtEOi7L4
         twEvX6GBBpdtX5tsTT6FoNdUyKZK3nhC0X5PJivQLTtqaVcC78eTnLWPJ4wXP7w71JmC
         PhbA==
X-Gm-Message-State: AOJu0Yx6jH8tqjQZZbs7dbrod/4EKK35VUdunjibrF+kNRBT5kH9GoHv
	RtLF0gvk9K8Kykq5eX7+3XhEZ8eACC+UNTmSLCRdWQZIYwQmYoo7a0m6gD9zYg==
X-Gm-Gg: AR+sD12kClVkjvbvuk38OrURL9TAuwNRfZcLZoDaBYse/43ismtC1vafUqP48jve2Mr
	GrZi6537BXMAqEC1YRjk59w1pJWOwIp4FlVDXyUYQrF0awBcvGX55ugoZZXOHM+Lx4VDhcEsRfQ
	kRNqdDDKR/hRL1WAWlMMGAMmPA6Btwzj0bo1WNOqYaBFapcSk0SL1tyBqf71+wmEzVOqUZCS2eT
	ztUilJOSAIQsJgA2/QVc8kwyJM23pq+UmQjhLYmBrnkAxiAh1MmBHcgnLuI+0S/17vOCB57ZNNf
	nfDOFBkXjyIYVau02ODGkyhVh/X2pGmAu+hPpv3YDT1OvShrm3vzARDmRLQ+ei9NlSSc6QNAnwl
	ifr55Ng3v0xSXPE5qCWwHoP4qe8I1Gh3xBeRcMfOEYi4V6G+m6j/rctXLjbqFPHjnsPk9LidzIR
	s4YegEVJbAGGXBSYQCcnLH4L0TzIaHZ/VFBMsGMNGS9CwNoJomGtMt2BtlTMuapLxSPn6KR1kST
	Dn+/WeuGc2t5GWnZE51hMKOo/JSCa1px48VOruBLvWAy1Y64Bbn7ENuocsS/r9vjI7L2fWuL5Wr
	lP+L2zog4PxhccOK/fKbxg==
X-Received: by 2002:a05:600c:8b75:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4994e70a6eamr362106215e9.1.1786108548418;
        Fri, 07 Aug 2026 06:15:48 -0700 (PDT)
Received: from ERL0724PF3HPJ22.global.ul.com (p200300f847017a0099d583c1a3d62c58.dip0.t-ipconnect.de. [2003:f8:4701:7a00:99d5:83c1:a3d6:2c58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm59053565e9.4.2026.08.07.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:15:48 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
Subject: [meta-selinux][wrynose][PATCH] package-labeling: Add postinst command for labeling
Date: Fri,  7 Aug 2026 15:15:29 +0200
Message-ID: <20260807131529.422685-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 13:15:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4651

Files inside packages are not labeled if you are adding SELinux
to the DISTRO_FEATURES.

If SELinux is enabled and further packages are installed on the
target, these files don't have an SELinux label.
For labeling the files after installation each package gets
a postinst script which labels the files after installation
using restorecon. restorecon accesses the current loaded
policy's file context.

For adding the postinst instructions, an additional task is
appended to each recipe which holds "class-target" in its
OVERRIDES variable.

Signed-off-by: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
---
 README                                   |  4 ++
 classes/selinux-package-labeling.bbclass | 76 ++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 classes/selinux-package-labeling.bbclass

diff --git a/README b/README
index ae011f3..232da2b 100644
--- a/README
+++ b/README
@@ -46,6 +46,10 @@ to be tailored for your environment.
 * Enable the refpolicy-mls:
 e.g. PREFERRED_PROVIDER_virtual/refpolicy ?= "refpolicy-mls"
 
+In order to activate the labeling mechanism for packages you have to add
+'selinux-package-labeling' to the INHERIT variable in your local.conf.
+e.g. INHERIT += "selinux-package-labeling"
+
 
 Using different init manager
 ----------------------------
diff --git a/classes/selinux-package-labeling.bbclass b/classes/selinux-package-labeling.bbclass
new file mode 100644
index 0000000..0edc284
--- /dev/null
+++ b/classes/selinux-package-labeling.bbclass
@@ -0,0 +1,76 @@
+def get_installed_folders_and_files(folder):
+    folders_and_files = []
+    if folder[-1] == "/":
+        # remove trailing slash, so it won't be removed later
+        folder = folder[:-1]
+    for walkroot, _, _files in os.walk(folder):
+        if walkroot == folder:
+            # The root folder should never be labeled when installing a package
+            continue
+        folders_and_files.append(walkroot.replace(folder, ""))
+        for file in _files:
+            folders_and_files.append(os.path.join(walkroot, file).replace(folder, ""))
+
+    return folders_and_files
+
+
+def get_installed_items(d, pkg):
+    pkgdest = d.getVar('PKGDEST')
+    pkg_folder = os.path.join(pkgdest, pkg)
+    retval = get_installed_folders_and_files(pkg_folder)
+
+    return retval
+
+
+python do_add_labels_in_postinst() {
+    packages = d.getVar('PACKAGES')
+    for pkg in packages.split():
+        # get the files inside the package
+        items = get_installed_items(d, pkg)
+
+        if not items:
+            continue
+
+        postinst = d.getVar('pkg_postinst:%s' % pkg)
+
+        # Circular dependencies in postscript happen, if two recipes depends on
+        # each other and both have a postinst script. As we label the newly installed files
+        # in the postinst script, we can ignore these circular dependencies if only one
+        # of the pkg have a postinst script. The check takes place in
+        # rootfs.py:_get_delayed_postinsts_common
+        if d.getVar("IGNORE_POSTINST_CIRCULAR_DEPENDENCY_{}".format(pkg)) and postinst:
+             bb.fatal("Circular dependency shall be ignored, but postinst script is given")
+
+        # Create the postinst script, which uses restorecon (busybox-util) for labeling
+        # add an empty line so that we don't append on a existing line.
+        relabel_command = d.getVar("PKG_RESTORECON")
+        postinst_labeling_command = "\t\t\techo -e \"{}\" | " \
+            "{}\n".format("\n".join(sorted(items)), relabel_command)
+
+        if not postinst:
+            postinst = '#!/bin/sh'
+        postinst += "\nif [ x\"$D\" = \"x\" ]; then\n"
+        postinst += "\tif command -v selinuxenabled > /dev/null 2>&1; then\n"
+        postinst += "\t\tif selinuxenabled; then\n"
+        postinst += postinst_labeling_command
+        postinst += "\t\tfi\n"
+        postinst += "\tfi\n"
+        postinst += "fi\n"
+
+        d.setVar('pkg_postinst:' + pkg, postinst)
+}
+
+# The restorecon binary gets the paths via stdin
+PKG_RESTORECON ?= "/sbin/restorecon -i -f -"
+
+python () {
+    if not bb.utils.contains('DISTRO_FEATURES', 'selinux', True, False, d):
+        # Only add the postinst label command if selinux is enabled
+        return
+
+    if bb.data.inherits_class('packagegroup', d):
+        return
+
+    if "class-target" in d.getVar("OVERRIDES").split(":"):
+        d.appendVar("PACKAGE_POSTPROCESS_FUNCS", "do_add_labels_in_postinst")
+}
-- 
2.43.0


