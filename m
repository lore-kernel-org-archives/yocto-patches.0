Return-Path: <akash.hadke27@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD25E77197
	for <webhook@archiver.kernel.org>; Thu,  9 Jan 2025 10:49:08 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.45381.1736419747327675612
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Jan 2025 02:49:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CkVGXm2q;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: akash.hadke27@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2efded08c79so1071367a91.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jan 2025 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736419746; x=1737024546; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y/HAhMOHhIE0KEZOK1Jz0C6JW7RB5yBQIx0bhA433w=;
        b=CkVGXm2qZNmVIFXe67GzmWXtglt2gEsbMMm/b18hFQIujw0bFjiLyFAsAXLdfGyd36
         VoNkAet9Yd3lcg8bpL+Pkg4sX4qAPmXgo705gpxYoztDPfy3g2tQss+/HXjCv3+sNHMp
         ljPHtRshK7eUuu9F9h18ePpmRmmuRdmU1eHyzL6ga/wj+dBi0ryGg2xpt1RF6vxcHPQD
         J/CkixEF6+Gr3E5R+U3sbKMOFVfP3igIw5qcM7D2GKJa2PMilXUoVmhefuLnj+yivknN
         mgHVlELCCnZO57AyizTjggD7pqysGlrsdj0VyRmN8cmcWAkrQa1gdKrXR6HLUHQ19r3e
         vxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736419746; x=1737024546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y/HAhMOHhIE0KEZOK1Jz0C6JW7RB5yBQIx0bhA433w=;
        b=TUtlKmgVIdMMSx82M+3sujNy0o9rodzMIER/c9YkAhnRBXXFNKANv9ioEVenjFVB4u
         VOWHMtcCif7OvnH0ZnNXA26LcyWNKBrl0DLglbWRyoYql3NSpLCRRqy3+Fy6G8S94HBI
         UxjB1NhShhmZGFJPjmePs1VtIGE/3JBVm9gl7Qu6KrvoCPbzLzyqiks0EBxS63mtyaLV
         ItSsYhX6a5n69m7s6M8VI9g/0YN0ddY8Knp284jvwZsB5/xn97R3qa7xpS/EleRIxZhK
         1Cg4v/d9fWdzpuG+SmpwuCd+3dT5zGOQMuY2kFQiFa4+n7SO6tB4oTrhDkm+93VnvVxg
         vr5Q==
X-Gm-Message-State: AOJu0YySjaaVCINb9u0SUbCNEBJHyuN6LBTbLRZ96qJga+lImGF48WtA
	4Sfq28w2hnoGomEDOM9VQc+NT7orV5jcG7OoGTJS5xtIiviqHZTfREHYGh07
X-Gm-Gg: ASbGncuVyO6cn3fk/a9dQoq5OC751crR5t7h99r+G4oiupgQG57FSnC1xEn8RuOAOKT
	uM46OdkRkMaH99RlCe1QqT6gzgDsUygdlfNcZmyMrNjEjpZlEIlK6elWbwymr9oSsPaxFCgxjqn
	DfCE8mECbKCXdtdtOeElfqe8nGe215DrveBt0tWOl9ouRmoyEmwIPMW0+4nMJOsfGjzp344E+Td
	VvPxkk0QRQKyRWLADTMPg8H4MK6FnFOV0B89vX1ldduuuq6gPiS84YR+Ll02MhK
X-Google-Smtp-Source: AGHT+IGoVsMdocfxr//9+f/HUxz96Irlga2Wu13jypN18E4d7NhVQGR74fsX8f2Ah1hYpd9kk2ggJA==
X-Received: by 2002:a17:90a:d648:b0:2f4:9e8b:6aad with SMTP id 98e67ed59e1d1-2f548da4606mr10562624a91.0.1736419746123;
        Thu, 09 Jan 2025 02:49:06 -0800 (PST)
Received: from L-18010.kpit.com ([49.36.49.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f53eeee106sm2558829a91.1.2025.01.09.02.49.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 02:49:05 -0800 (PST)
From: Akash Hadke <akash.hadke27@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][kirkstone][PATCH] meta-security: Remove True option to getVar calls
Date: Thu,  9 Jan 2025 16:18:58 +0530
Message-Id: <20250109104858.61901-1-akash.hadke27@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Jan 2025 10:49:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/974

getVar() now defaults to expanding by default, thus remove the True
option from getVar() calls with a regex search and replace.

Signed-off-by: Akash Hadke <akash.hadke27@gmail.com>
---
 meta-integrity/classes/ima-evm-rootfs.bbclass |  2 +-
 .../parsec-service/parsec-service_1.0.0.bb    |  2 +-
 meta-security-isafw/classes/isafw.bbclass     | 52 +++++++++----------
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/meta-integrity/classes/ima-evm-rootfs.bbclass b/meta-integrity/classes/ima-evm-rootfs.bbclass
index 57de2f6..b994dfe 100644
--- a/meta-integrity/classes/ima-evm-rootfs.bbclass
+++ b/meta-integrity/classes/ima-evm-rootfs.bbclass
@@ -56,7 +56,7 @@ ima_evm_sign_rootfs () {
     #
     # Deduplicates iversion in case that this gets called more than once.
     if [ -f etc/fstab ]; then
-       perl -pi -e 's;(\S+)(\s+)(${@"|".join((d.getVar("IMA_EVM_ROOTFS_IVERSION", True) or "no-such-mount-point").split())})(\s+)(\S+)(\s+)(\S+);\1\2\3\4\5\6\7,iversion;; s/(,iversion)+/,iversion/;' etc/fstab
+       perl -pi -e 's;(\S+)(\s+)(${@"|".join((d.getVar("IMA_EVM_ROOTFS_IVERSION") or "no-such-mount-point").split())})(\s+)(\S+)(\s+)(\S+);\1\2\3\4\5\6\7,iversion;; s/(,iversion)+/,iversion/;' etc/fstab
     fi
 
     # Sign file with private IMA key. EVM not supported at the moment.
diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.0.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.0.0.bb
index ad7e560..a3b69c4 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.0.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.0.0.bb
@@ -22,7 +22,7 @@ PACKAGECONFIG[MBED-CRYPTO] = "mbed-crypto-provider,"
 PACKAGECONFIG[CRYPTOAUTHLIB] = "cryptoauthlib-provider,"
 PACKAGECONFIG[TS] = "trusted-service-provider,,libts,libts"
 
-PARSEC_FEATURES = "${@d.getVar('PACKAGECONFIG_CONFARGS',True).strip().replace(' ', ',')}"
+PARSEC_FEATURES = "${@d.getVar('PACKAGECONFIG_CONFARGS').strip().replace(' ', ',')}"
 CARGO_BUILD_FLAGS += " --features ${PARSEC_FEATURES}"
 
 export BINDGEN_EXTRA_CLANG_ARGS
diff --git a/meta-security-isafw/classes/isafw.bbclass b/meta-security-isafw/classes/isafw.bbclass
index 3854c0f..ccee2df 100644
--- a/meta-security-isafw/classes/isafw.bbclass
+++ b/meta-security-isafw/classes/isafw.bbclass
@@ -31,19 +31,19 @@ python do_analysesource() {
 
     imageSecurityAnalyser = isafw_init(isafw, d)
 
-    if not d.getVar('SRC_URI', True):
+    if not d.getVar('SRC_URI'):
         # Recipe didn't fetch any sources, nothing to do here I assume?
         return
 
     recipe = isafw.ISA_package()
-    recipe.name = d.getVar('BPN', True)
-    recipe.version = d.getVar('PV', True)
+    recipe.name = d.getVar('BPN')
+    recipe.version = d.getVar('PV')
     recipe.version = recipe.version.split('+git', 1)[0]
 
-    for p in d.getVar('PACKAGES', True).split():
-        license = str(d.getVar('LICENSE:' + p, True))
+    for p in d.getVar('PACKAGES').split():
+        license = str(d.getVar('LICENSE:' + p))
         if license == "None":
-            license = d.getVar('LICENSE', True)
+            license = d.getVar('LICENSE')
         license = license.replace("(", "")
         license = license.replace(")", "")
         licenses = license.split()
@@ -54,7 +54,7 @@ python do_analysesource() {
         for l in licenses:
             recipe.licenses.append(p + ":" + canonical_license(d, l))
 
-    aliases = d.getVar('DISTRO_PN_ALIAS', True)
+    aliases = d.getVar('DISTRO_PN_ALIAS')
     if aliases:
         recipe.aliases = aliases.split()
         faliases = []
@@ -72,7 +72,7 @@ python do_analysesource() {
         recipe.patch_files.append("None")
 
     # Pass the recipe object to the security framework
-    bb.debug(1, '%s: analyse sources' % (d.getVar('PN', True)))
+    bb.debug(1, '%s: analyse sources' % (d.getVar('PN')))
     imageSecurityAnalyser.process_package(recipe)
 
     return
@@ -96,7 +96,7 @@ python process_reports_handler() {
  
     dd.setVar("STAGING_DIR_NATIVE", native_sysroot)
     savedenv = os.environ.copy()
-    os.environ["PATH"] = dd.getVar("PATH", True)
+    os.environ["PATH"] = dd.getVar("PATH")
 
     imageSecurityAnalyser = isafw_init(isafw, dd)
     bb.debug(1, 'isafw: process reports')
@@ -145,11 +145,11 @@ fakeroot python do_analyse_image() {
     imageSecurityAnalyser = isafw_init(isafw, d)
 
     # Directory where the image's entire contents can be examined
-    rootfsdir = d.getVar('IMAGE_ROOTFS', True)
+    rootfsdir = d.getVar('IMAGE_ROOTFS')
 
-    imagebasename = d.getVar('IMAGE_BASENAME', True)
+    imagebasename = d.getVar('IMAGE_BASENAME')
 
-    kernelconf = d.getVar('STAGING_KERNEL_BUILDDIR', True) + "/.config"
+    kernelconf = d.getVar('STAGING_KERNEL_BUILDDIR') + "/.config"
     if os.path.exists(kernelconf):
         kernel = isafw.ISA_kernel()
         kernel.img_name = imagebasename
@@ -161,7 +161,7 @@ fakeroot python do_analyse_image() {
 
     pkglist = manifest2pkglist(d)
 
-    imagebasename = d.getVar('IMAGE_BASENAME', True)
+    imagebasename = d.getVar('IMAGE_BASENAME')
 
     if (pkglist):
         pkg_list = isafw.ISA_pkg_list()
@@ -198,9 +198,9 @@ def isafw_init(isafw, d):
 
     bb.utils.export_proxies(d)
 
-    isafw_config.machine = d.getVar('MACHINE', True)
-    isafw_config.timestamp = d.getVar('DATETIME', True)
-    isafw_config.reportdir = d.getVar('ISAFW_REPORTDIR', True) + "_" + isafw_config.timestamp
+    isafw_config.machine = d.getVar('MACHINE')
+    isafw_config.timestamp = d.getVar('DATETIME')
+    isafw_config.reportdir = d.getVar('ISAFW_REPORTDIR') + "_" + isafw_config.timestamp
     if not os.path.exists(os.path.dirname(isafw_config.reportdir + "/test")):
         try:
             os.makedirs(os.path.dirname(isafw_config.reportdir + "/test"))
@@ -208,22 +208,22 @@ def isafw_init(isafw, d):
             if exc.errno == errno.EEXIST and os.path.isdir(isafw_config.reportdir):
                 pass
             else: raise
-    isafw_config.logdir = d.getVar('ISAFW_LOGDIR', True)
+    isafw_config.logdir = d.getVar('ISAFW_LOGDIR')
     # Adding support for arm
     # TODO: Add support for other platforms
-    isafw_config.arch =  d.getVar('TARGET_ARCH', True)
+    isafw_config.arch =  d.getVar('TARGET_ARCH')
     if ( isafw_config.arch != "arm" ):
         isafw_config.arch = "x86"
 
-    whitelist = d.getVar('ISAFW_PLUGINS_WHITELIST', True)
-    blacklist = d.getVar('ISAFW_PLUGINS_BLACKLIST', True)
+    whitelist = d.getVar('ISAFW_PLUGINS_WHITELIST')
+    blacklist = d.getVar('ISAFW_PLUGINS_BLACKLIST')
     if whitelist:
         isafw_config.plugin_whitelist = re.split(r'[,\s]*', whitelist)
     if blacklist:
         isafw_config.plugin_blacklist = re.split(r'[,\s]*', blacklist)
 
-    la_image_whitelist = d.getVar('ISAFW_LA_PLUGIN_IMAGE_WHITELIST', True)
-    la_image_blacklist = d.getVar('ISAFW_LA_PLUGIN_IMAGE_BLACKLIST', True)
+    la_image_whitelist = d.getVar('ISAFW_LA_PLUGIN_IMAGE_WHITELIST')
+    la_image_blacklist = d.getVar('ISAFW_LA_PLUGIN_IMAGE_BLACKLIST')
     if la_image_whitelist:
         isafw_config.la_plugin_image_whitelist = re.split(r'[,\s]*', la_image_whitelist)
     if la_image_blacklist:
@@ -252,10 +252,10 @@ manifest2pkglist[vardepsexclude] = "DATETIME"
 def manifest2pkglist(d):
     import glob
 
-    manifest_file = d.getVar('IMAGE_MANIFEST', True)
-    imagebasename = d.getVar('IMAGE_BASENAME', True)
-    reportdir = d.getVar('ISAFW_REPORTDIR', True) + "_" + d.getVar('DATETIME', True)
-    pkgdata_dir = d.getVar("PKGDATA_DIR", True)
+    manifest_file = d.getVar('IMAGE_MANIFEST')
+    imagebasename = d.getVar('IMAGE_BASENAME')
+    reportdir = d.getVar('ISAFW_REPORTDIR') + "_" + d.getVar('DATETIME')
+    pkgdata_dir = d.getVar("PKGDATA_DIR")
     rr_dir = "%s/runtime-reverse/" % pkgdata_dir
     pkglist = reportdir + "/pkglist"
 
-- 
2.25.1


