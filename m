Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD11C2A09B
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 13:37:55 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42624.1786109868951392986
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Aug 2026 06:37:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=A2qXeexa;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso2114473f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 06:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786109867; x=1786714667; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+l+QhK4VRk4ACjtS2PZnl1YIEr2T4//y3tTT+F6lLTk=;
        b=A2qXeexaBMO8BQky2WbPKraAokKaZr/eevsBq/P5LwcEmD2AM1utPk34/ifL8RbxTH
         sxFAa46H6qf9Jv8nEwnAYIDCKEOq1GOeEnNFEYE6kEEnJksHTk0nOUHk67Flu/jkoFAG
         RTzGMAhQeB56rh80H/XRoxAwTXoaL4bGGrkwstlMr59WtpARcS1VPdJSoO2hKE/I4/Uu
         JbGA7rSRxFPXqsPfXUjgS+uYoy4TJ+3I2N2PBprwLXdusOovv2TzY3u8QhP7Gg04Td/S
         h5+FlkJAhBM7N2diaIQGEAZWmfhwAmzCbPlyNwSb+kXP0A1oFqaCuQbxMohE1pIs+tmx
         7n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786109867; x=1786714667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+l+QhK4VRk4ACjtS2PZnl1YIEr2T4//y3tTT+F6lLTk=;
        b=FtltFM4UUmTDSJWDDqHb0sOBkmfpxINHzwnNf1AV4Qr1WEXEi30n01KZaJ50A+McO2
         p6Jw2UnjstdE2sulHgb6w/NcTBqRlpjOkMd+UdBXRLIfq1YhR8hrqMfO7YJyHCWrv+43
         0VS+jM1wlAFXadsjvHedbSG2DaLMwWCKiAauJI1jcc6B0ehba1odv8J9ZuMh2rrkVNPp
         cgWy0svNVNR2WstcERk7NViYz0z14e9WulpSKYdETbTgYvC+xVhQwHoFSzXhpuYpjAQY
         3BKwLBxlZqiLJWvNwT+zCTGHDwwIk0r8Tb2iR2RvHLMVvBKDuW49f4DFJoWXNJ+z85O1
         rMpA==
X-Gm-Message-State: AOJu0YxnEk7VlZyTMXosgSQ99CKiYvB5UWYJ836czIcYcrI040rncYL1
	IWmv7664m8N5+CVxhvD8namxeVbDwrPPLHQxprg0w3sYxnGY1yu+N0bcwOQdUA==
X-Gm-Gg: AR+sD13deK1gOj5UrHm7wcbiXw2J9YnGViW+LgY2BU9b1WhtAHcX79MtQL56CV3UBo9
	YqO1H+gyNKnE2zsw6BA9LKLUa+ihGBStgYtsZD4y07tGX/+KQIMzxh/BgbSeM/D5wopEzYFpApM
	AA1RrTG2JsBaA8KB/yBEtw3EKGhngK/DmMjDhVi5y3pDFdtjQV5J106VbkrfMc0mUblId4hf9Q2
	8qOboJNxipNOhqheatn36kE7WEtfmkUARoWHUYX2uV6I2S1yHffX67r3cu3C1IOXN/ToB5FtyAU
	veCzjTMHZEfLzowGhGUtlXMG+H2Jyih0a20Jb0rdhVfG1n44phmVyYqdf43LL89HMFbGrgMiGmT
	dcehYztYyoaXh7jnhcb5CY80pu4CaK6cGqrWoRzoFvTGXfR/odqCqECoxPe8pDnyAxfLP8X0ARn
	vapfS3kTMEx5rmbtzLyVzTnYu1porQczfkeqfbrHiCCiOOuj8bjdq20whFGktoQNXUiqNJlyVFX
	s+WZqSFNmNk2PR1caNXWp6Pp5GBtvr0D0dTUu/jPufxTTMAhm8vhRwMioI9YTByWBqGgMkO+Tff
	tKbd7WnLwA==
X-Received: by 2002:a05:6000:2485:b0:47f:25db:8161 with SMTP id ffacd0b85a97d-47fec64683bmr33144035f8f.28.1786109867159;
        Fri, 07 Aug 2026 06:37:47 -0700 (PDT)
Received: from ERL0724PF3HPJ22.global.ul.com (p200300f847017a0099d583c1a3d62c58.dip0.t-ipconnect.de. [2003:f8:4701:7a00:99d5:83c1:a3d6:2c58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800214557esm5981728f8f.2.2026.08.07.06.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:37:46 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
Subject: [meta-selinux][master][PATCH] package-labeling: Add postinst command for labeling
Date: Fri,  7 Aug 2026 15:37:32 +0200
Message-ID: <20260807133732.424852-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Aug 2026 13:37:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4654

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


