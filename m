Return-Path: <ayoub.zaki@embetrix.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B44F99357
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 09:11:19 +0000 (UTC)
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15515.1776935467264948898
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Apr 2026 02:11:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@embetrix.com header.s=rsa2 header.b=FJC71Vap;
 dkim=pass header.i=@embetrix.com header.s=ed2 header.b=BXP8zP+A;
 spf=none, err=permanent DNS error (domain: embetrix.com, ip: 46.30.212.3, mailfrom: ayoub.zaki@embetrix.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1776935464; x=1777540264;
	d=embetrix.com; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=wARMW9RcUSGzi5WyvphG6uUL+fD7DfAkASkntlzFM/8=;
	b=FJC71VapFcH1gZzeb1rDkjeF3hF4/sKK1QeosBaJDwbHiZHDamII0jhhcdpd+8Yg9WeIkwgvi/VC6
	 0Qqrls+L0bwPKukvy6u1V+h4OL2WFdnF8/XBxE2kK9brkWIwow+rFh/jusjCOEy3nkiSSrRprXXPo6
	 mKr7zEz0qS/I5FPRbfwhC0+XvMYyK0tDvWtEvk8IUR2yOfTP8+hDN7SldcdZsd4JR1/ZjYAukOTV33
	 tStXAreUANwiQT7TB7DD2mFf8MZ+gjlckTBF1ReFIgDfiJSbBIGmzfGZkzLGV7FilhmU8Ws+/V/64N
	 sO5mPfhDbjXZW+ZaZINPjJTzzQstw7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1776935464; x=1777540264;
	d=embetrix.com; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=wARMW9RcUSGzi5WyvphG6uUL+fD7DfAkASkntlzFM/8=;
	b=BXP8zP+AQtuzgH/NRXRbTMkwvOJ+8Bo2LO/UCTc4w4obW7GU6bGYO2+uVH2+6NJGon/SP6y61pYhi
	 p/ALVBdCg==
X-HalOne-ID: 59ad1710-3ef4-11f1-839b-f3c0f7fef5ee
Received: from xps-13.fritz.box (dynamic-2a02-3102-8c10-1ae0-a909-1220-fcba-3163.310.pool.telefonica.de [2a02:3102:8c10:1ae0:a909:1220:fcba:3163])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 59ad1710-3ef4-11f1-839b-f3c0f7fef5ee;
	Thu, 23 Apr 2026 09:11:03 +0000 (UTC)
From: Ayoub Zaki <ayoub.zaki@embetrix.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ayoub Zaki <ayoub.zaki@embetrix.com>
Subject: [meta-security][PATCH v2] dm-verity: add PKCS#7 root hash signature support
Date: Thu, 23 Apr 2026 11:11:02 +0200
Message-ID: <20260423091102.26875-1-ayoub.zaki@embetrix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 09:11:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3773

The dm-verity root hash stored in the initramfs is vulnerable to TOCTOU
attacks. Mitigate this by signing the root hash at build time and
verifying it from the kernel via CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG.
The signature is deployed into the initramfs while the signing certificate
is embedded in the kernel's built-in trusted keyring.

- dm-verity-img.bbclass: sign root hash with openssl smime when DM_VERITY_SIGN=1
- kernel-trusted-keys.bbclass: new shared class to collect PEM certs
  into trusted_keys.pem via KERNEL_TRUSTED_CERTS variable
- linux-yocto_security.inc: add kernel config fragments and append
  signing cert via KERNEL_TRUSTED_CERTS
- dm-verity-image-initramfs.bb: deploy .p7s signature
- dmverity initrd script: pass --root-hash-signature to veritysetup
- linux_ima.inc: use KERNEL_TRUSTED_CERTS instead of absolute path in
  CONFIG_SYSTEM_TRUSTED_KEYS, fixing buildpaths QA
- Add documentation

Signing is not enabled by default for backward compatibility but is
strongly recommended for production deployments.

Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
---
 classes/dm-verity-img.bbclass                 |  46 +++++++-
 classes/kernel-trusted-keys.bbclass           |  34 ++++++
 docs/dm-verity.txt                            | 110 ++++++++++++++++++
 .../recipes-kernel/linux/linux_ima.inc        |   9 +-
 .../images/dm-verity-image-initramfs.bb       |   6 +
 .../initramfs-framework-dm/dmverity           |   7 ++
 .../linux/files/dm-verity-verify.cfg          |  10 ++
 .../linux/files/dm-verity-verify.scc          |   5 +
 recipes-kernel/linux/linux-yocto_security.inc |  10 ++
 9 files changed, 231 insertions(+), 6 deletions(-)
 create mode 100644 classes/kernel-trusted-keys.bbclass
 create mode 100644 recipes-kernel/linux/files/dm-verity-verify.cfg
 create mode 100644 recipes-kernel/linux/files/dm-verity-verify.scc

diff --git a/classes/dm-verity-img.bbclass b/classes/dm-verity-img.bbclass
index 48557e9..4eec085 100644
--- a/classes/dm-verity-img.bbclass
+++ b/classes/dm-verity-img.bbclass
@@ -3,6 +3,12 @@
 # Copyright (C) 2020 BayLibre SAS
 # Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
 #
+# Copyright (C) 2026 Embetrix Embedded Systems Solutions <ayoub.zaki@embetrix.com>
+# - Added PKCS#7 root hash signature support to mitigate TOCTOU attacks.
+#   The root hash is signed at build time and verified by the kernel at boot
+#   via CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG, removing the need to trust
+#   the initramfs as the sole root hash storage.
+#
 # This bbclass allows creating of dm-verity protected partition images. It
 # generates a device image file with dm-verity hash data appended at the end
 # plus the corresponding .env file containing additional information needed
@@ -49,6 +55,21 @@ DM_VERITY_SEPARATE_HASH ?= "0"
 # Additional arguments for veritysetup
 DM_VERITY_SETUP_ARGS ?= ""
 
+# Root hash signing: set to "1" to generate a PKCS#7 signature of the root
+# hash that the kernel verifies via CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG.
+DM_VERITY_SIGN ?= "0"
+
+# No default! Either this or DM_VERITY_SIGN_KEY/DM_VERITY_SIGN_CERT have
+# to be set explicitly in a local.conf before enabling DM_VERITY_SIGN.
+DM_VERITY_SIGN_KEY_DIR ?= "DM_VERITY_SIGN_KEY_DIR_NOT_SET"
+
+# Private key (PEM) used to sign the root hash.
+DM_VERITY_SIGN_KEY ?= "${DM_VERITY_SIGN_KEY_DIR}/privkey_verity.pem"
+
+# X.509 certificate (PEM) corresponding to the signing key. This cert must
+# also be embedded in the kernel via CONFIG_SYSTEM_TRUSTED_KEYS.
+DM_VERITY_SIGN_CERT ?= "${DM_VERITY_SIGN_KEY_DIR}/x509_verity.crt"
+
 # These are arch specific.  We could probably intelligently auto-assign these?
 # Take x86-64 values as defaults. No impact on functionality currently.
 # See SD_GPT_ROOT_X86_64 and SD_GPT_ROOT_X86_64_VERITY in the spec.
@@ -56,7 +77,7 @@ DM_VERITY_SETUP_ARGS ?= ""
 DM_VERITY_ROOT_GUID ?= "4f68bce3-e8cd-4db1-96e7-fbcaf984b709"
 DM_VERITY_RHASH_GUID ?= "2c7357ed-ebd2-46d9-aec1-23d437ec2bf5"
 
-DEPENDS += "bc-native"
+DEPENDS += "bc-native ${@bb.utils.contains('DM_VERITY_SIGN', '1', 'openssl-native', '', d)}"
 
 # Process the output from veritysetup and generate the corresponding .env
 # file. The output from veritysetup is not very machine-friendly so we need to
@@ -160,6 +181,29 @@ verity_setup() {
     # Let's drop the first line of output (doesn't contain any useful info)
     # and feed the rest to another function.
     veritysetup $SETUP_ARGS | tail -n +2 | process_verity
+
+    if [ ${DM_VERITY_SIGN} -eq 1 ]; then
+        if [ ! -f "${DM_VERITY_SIGN_KEY}" ]; then
+            bbfatal "DM_VERITY_SIGN_KEY not found: ${DM_VERITY_SIGN_KEY}"
+        fi
+        if [ ! -f "${DM_VERITY_SIGN_CERT}" ]; then
+            bbfatal "DM_VERITY_SIGN_CERT not found: ${DM_VERITY_SIGN_CERT}"
+        fi
+
+        local ENV="${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.$TYPE.verity.env"
+        local SIG="${ENV}.p7s"
+        local ROOTHASH=$(cat $ENV | grep ^ROOT_HASH | sed 's/ROOT_HASH=//')
+        local HASH_HEX=$(mktemp)
+
+        echo -n "$ROOTHASH" > $HASH_HEX
+
+        openssl smime -sign -nocerts -noattr -binary \
+            -in $HASH_HEX \
+            -inkey ${DM_VERITY_SIGN_KEY} -signer ${DM_VERITY_SIGN_CERT} \
+            -outform der -out $SIG
+
+        rm -f $HASH_HEX
+    fi
 }
 
 # make "dateless" symlink for the hash so the wks can find it.
diff --git a/classes/kernel-trusted-keys.bbclass b/classes/kernel-trusted-keys.bbclass
new file mode 100644
index 0000000..3f30e68
--- /dev/null
+++ b/classes/kernel-trusted-keys.bbclass
@@ -0,0 +1,34 @@
+#
+# Copyright (C) 2026 Embetrix Embedded Systems Solutions <ayoub.zaki@embetrix.com>
+#
+# Collect PEM certificates into a shared trusted_keys.pem bundle
+# for CONFIG_SYSTEM_TRUSTED_KEYS. Multiple features (IMA, dm-verity
+# signing, etc.) can append their certs to KERNEL_TRUSTED_CERTS.
+#
+# Usage from other classes or .inc files:
+#   KERNEL_TRUSTED_CERTS:append = " ${MY_CERT_PATH}"
+#   inherit kernel-trusted-keys
+
+KERNEL_TRUSTED_CERTS ?= ""
+
+do_configure:append() {
+    if [ -f .config ]; then
+        for cert in ${KERNEL_TRUSTED_CERTS}; do
+            if [ -f "$cert" ]; then
+                if ! grep -q "BEGIN CERTIFICATE" "$cert"; then
+                    bbfatal "$cert is not in PEM format"
+                fi
+                cat "$cert" >> "${B}/trusted_keys.pem"
+            fi
+        done
+        if [ -f "${B}/trusted_keys.pem" ]; then
+            echo 'CONFIG_SYSTEM_TRUSTED_KEYS="trusted_keys.pem"' >> .config
+        fi
+    fi
+}
+
+do_shared_workdir:append() {
+    if [ -f trusted_keys.pem ]; then
+        cp trusted_keys.pem $kerneldir/
+    fi
+}
diff --git a/docs/dm-verity.txt b/docs/dm-verity.txt
index a538fa2..75bb801 100644
--- a/docs/dm-verity.txt
+++ b/docs/dm-verity.txt
@@ -121,3 +121,113 @@ INFO: The image(s) were created using OE kickstart file:
 The "direct" image contains the partition table, bootloader, and dm-verity
 enabled ext4 image all in one -- ready to write to a raw device, such as a
 u-SD card in the case of the beaglebone.
+
+Root Hash Signature Verification
+--------------------------------
+By default, dm-verity stores the root hash as plain text in the initramfs
+at /usr/share/misc/dm-verity.env. Even when the initramfs is verified at
+an earlier boot stage (e.g. bundled with the kernel or part of a signed
+FIT image), there is a window between that verification and the actual use
+of the root hash during which memory contents can potentially be modified
+using hardware-based techniques. This creates a TOCTOU (time-of-check to
+time-of-use) vulnerability that can defeat dm-verity.
+
+To mitigate this, the root hash can be cryptographically signed at build
+time using PKCS#7. The signature is deployed into the initramfs and passed
+to veritysetup via --root-hash-signature. The kernel then verifies the
+signature against certificates embedded in its built-in trusted keyring
+(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG). No certificate is stored in the
+initramfs and the trust anchor is the kernel binary itself.
+
+This feature requires a secure boot chain to protect the kernel image.
+
+Signing Setup
+~~~~~~~~~~~~~
+1. Generate a signing key pair (do this once, keep the private key safe):
+
+   openssl req -new -x509 -newkey rsa:4096 -nodes \
+       -keyout privkey_verity.pem -out x509_verity.crt \
+       -days 3650 -subj "/CN=dm-verity signing key"
+
+2. Add the following to your conf/local.conf or distro config:
+
+   DM_VERITY_SIGN = "1"
+   DM_VERITY_SIGN_KEY_DIR = "/path/to/keys"
+
+   The key directory should contain privkey_verity.pem (private key) and
+   x509_verity.crt (X.509 certificate). The certificate serves a dual
+   purpose:
+   - It is used by openssl at build time to create the PKCS#7 signature
+   - It is embedded into the kernel via CONFIG_SYSTEM_TRUSTED_KEYS so the
+     kernel can verify the signature at boot
+
+   Alternatively, set DM_VERITY_SIGN_KEY and DM_VERITY_SIGN_CERT
+   individually to override the default filenames.
+
+3. The build will automatically:
+   - Enable CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG in the kernel
+   - Embed the signing certificate in the kernel's trusted keyring
+   - Sign the root hash and produce a .p7s signature file
+   - Deploy the signature into the initramfs
+
+4. At boot, the initramfs dmverity script passes the signature to
+   veritysetup, which forwards it to the kernel. The kernel verifies
+   the root hash against its built-in trusted keys before activating
+   the dm-verity target. If verification fails, the device will not
+   be created and the boot will fail.
+
+Hardening
+~~~~~~~~~
+By default CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG only verifies the
+signature when one is provided. A dm-verity target created without a
+signature will still be accepted. To enforce that ALL dm-verity targets
+must have a valid root hash signature, add the following to the kernel
+command line:
+
+   dm_verity.require_signatures=1
+
+With this parameter set, any attempt to create a dm-verity device
+without a valid PKCS#7 signature will be rejected by the kernel. This
+is strongly recommended for production deployments.
+
+Note on trusted_keys.pem
+~~~~~~~~~~~~~~~~~~~~~~~~
+The kernel-trusted-keys.bbclass aggregates certificates into a file called
+trusted_keys.pem in the kernel build directory and in work-shared. Despite
+the name (inherited from the kernel's CONFIG_SYSTEM_TRUSTED_KEYS), this
+file contains only X.509 certificates (public keys). No private key
+material is handled by the kernel's built-in trusted keyring.
+
+Vendor Kernel Integration
+~~~~~~~~~~~~~~~~~~~~~~~~~
+Since meta-security only bbappends linux-yocto, integrating root hash
+signature verification with a vendor kernel requires adding the following
+kernel configuration options:
+
+   CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
+   CONFIG_KEYS=y
+   CONFIG_ASYMMETRIC_KEY_TYPE=y
+   CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
+   CONFIG_X509_CERTIFICATE_PARSER=y
+   CONFIG_PKCS7_MESSAGE_PARSER=y
+   CONFIG_SYSTEM_TRUSTED_KEYRING=y
+   CONFIG_SYSTEM_TRUSTED_KEYS="trusted_keys.pem"
+   CONFIG_CRYPTO_RSA=y
+   CONFIG_CRYPTO_SHA256=y
+
+These can be applied as a fragment or via your kernel's
+configuration mechanism.
+
+Additionally, ensure your kernel recipe inherits kernel-trusted-keys and
+points the signing certificate via KERNEL_TRUSTED_CERTS:
+
+   KERNEL_TRUSTED_CERTS:append = "${DM_VERITY_SIGN_CERT}"
+   inherit kernel-trusted-keys
+
+Compatibility Notes
+~~~~~~~~~~~~~~~~~~~
+- Signing is optional but strongly recommended. It is backward compatible;
+  when DM_VERITY_SIGN is "0" (the default) the behavior is unchanged.
+- Both appended hash and separate hash partition modes support signing.
+- The signing certificate can coexist with other certificates already set
+  in CONFIG_SYSTEM_TRUSTED_KEYS (e.g. for IMA/EVM).
diff --git a/meta-integrity/recipes-kernel/linux/linux_ima.inc b/meta-integrity/recipes-kernel/linux/linux_ima.inc
index 415476a..fbedaf9 100644
--- a/meta-integrity/recipes-kernel/linux/linux_ima.inc
+++ b/meta-integrity/recipes-kernel/linux/linux_ima.inc
@@ -1,9 +1,8 @@
+IMA_EVM_KEY_DIR ?= "IMA_EVM_KEY_DIR_NOT_SET"
+IMA_EVM_ROOT_CA ?= "${IMA_EVM_KEY_DIR}/ima-local-ca.pem"
 
-do_configure:append() {
-    if [ "${@bb.utils.contains('DISTRO_FEATURES', 'ima', 'yes', '', d)}" = "yes" ] && [ -f .config ] ; then
-        sed -i "s|^CONFIG_SYSTEM_TRUSTED_KEYS=.*|CONFIG_SYSTEM_TRUSTED_KEYS=\"${IMA_EVM_ROOT_CA}\"|" .config
-    fi
-}
+KERNEL_TRUSTED_CERTS:append = " ${@d.getVar('IMA_EVM_ROOT_CA') if bb.utils.contains('DISTRO_FEATURES', 'ima', True, False, d) else ''}"
+inherit kernel-trusted-keys
 
 KERNEL_FEATURES:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'modsign', ' features/ima/modsign.scc', '', d)}"
 KERNEL_FEATURES:append = " ${@bb.utils.contains('DISTRO_FEATURES', 'ima', ' features/ima/ima.scc', '', d)}"
diff --git a/recipes-core/images/dm-verity-image-initramfs.bb b/recipes-core/images/dm-verity-image-initramfs.bb
index 7ed83dc..41fa53a 100644
--- a/recipes-core/images/dm-verity-image-initramfs.bb
+++ b/recipes-core/images/dm-verity-image-initramfs.bb
@@ -39,5 +39,11 @@ deploy_verity_hash() {
     install -D -m 0644 \
         ${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.${DM_VERITY_IMAGE_TYPE}.verity.env \
         ${IMAGE_ROOTFS}${datadir}/misc/dm-verity.env
+
+    local SIG="${STAGING_VERITY_DIR}/${DM_VERITY_IMAGE}.${DM_VERITY_IMAGE_TYPE}.verity.env.p7s"
+    if [ -f "$SIG" ]; then
+        install -D -m 0644 "$SIG" \
+            ${IMAGE_ROOTFS}${datadir}/misc/dm-verity.sig
+    fi
 }
 IMAGE_PREPROCESS_COMMAND += "deploy_verity_hash;"
diff --git a/recipes-core/initrdscripts/initramfs-framework-dm/dmverity b/recipes-core/initrdscripts/initramfs-framework-dm/dmverity
index 1923490..20b06f2 100644
--- a/recipes-core/initrdscripts/initramfs-framework-dm/dmverity
+++ b/recipes-core/initrdscripts/initramfs-framework-dm/dmverity
@@ -12,6 +12,11 @@ dmverity_run() {
 
     . /usr/share/misc/dm-verity.env
 
+    ROOTHASH_SIG_ARG=""
+    if [ -f /usr/share/misc/dm-verity.sig ]; then
+        ROOTHASH_SIG_ARG="--root-hash-signature=/usr/share/misc/dm-verity.sig"
+    fi
+
     C=0
     delay=${bootparam_rootdelay:-1}
     timeout=${bootparam_roottimeout:-5}
@@ -30,6 +35,7 @@ dmverity_run() {
 
         veritysetup \
             --data-block-size=${DATA_BLOCK_SIZE} \
+            ${ROOTHASH_SIG_ARG} \
             create rootfs \
             /dev/disk/by-partuuid/${ROOT_UUID} \
             /dev/disk/by-partuuid/${RHASH_UUID} \
@@ -81,6 +87,7 @@ dmverity_run() {
     veritysetup \
         --data-block-size=${DATA_BLOCK_SIZE} \
         --hash-offset=${DATA_SIZE} \
+        ${ROOTHASH_SIG_ARG} \
         create rootfs \
         ${RDEV} \
         ${RDEV} \
diff --git a/recipes-kernel/linux/files/dm-verity-verify.cfg b/recipes-kernel/linux/files/dm-verity-verify.cfg
new file mode 100644
index 0000000..aba6a67
--- /dev/null
+++ b/recipes-kernel/linux/files/dm-verity-verify.cfg
@@ -0,0 +1,10 @@
+CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y
+CONFIG_KEYS=y
+CONFIG_ASYMMETRIC_KEY_TYPE=y
+CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
+CONFIG_X509_CERTIFICATE_PARSER=y
+CONFIG_PKCS7_MESSAGE_PARSER=y
+CONFIG_SYSTEM_TRUSTED_KEYRING=y
+CONFIG_SYSTEM_TRUSTED_KEYS="trusted_keys.pem"
+CONFIG_CRYPTO_RSA=y
+CONFIG_CRYPTO_SHA256=y
diff --git a/recipes-kernel/linux/files/dm-verity-verify.scc b/recipes-kernel/linux/files/dm-verity-verify.scc
new file mode 100644
index 0000000..2af676a
--- /dev/null
+++ b/recipes-kernel/linux/files/dm-verity-verify.scc
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: MIT
+define KFEATURE_DESCRIPTION "Enable dm-verity root hash signature verification"
+define KFEATURE_COMPATIBILITY board
+
+kconf hardware dm-verity-verify.cfg
diff --git a/recipes-kernel/linux/linux-yocto_security.inc b/recipes-kernel/linux/linux-yocto_security.inc
index 3a2ff96..505f0db 100644
--- a/recipes-kernel/linux/linux-yocto_security.inc
+++ b/recipes-kernel/linux/linux-yocto_security.inc
@@ -5,3 +5,13 @@ KERNEL_FEATURES:append = " ${@bb.utils.contains("DISTRO_FEATURES", "smack", " fe
 KERNEL_FEATURES:append = " ${@bb.utils.contains("IMAGE_CLASSES", "dm-verity-img", " features/device-mapper/dm-verity.scc", "" ,d)}"
 KERNEL_FEATURES:append = " features/ecryptfs/ecryptfs.scc"
 SRC_URI += " ${@bb.utils.contains("DISTRO_FEATURES", "lkrg", "file://lkrg.scc", "" ,d)}"
+
+DM_VERITY_SIGN ?= "0"
+DM_VERITY_SIGN_KEY_DIR ?= "DM_VERITY_SIGN_KEY_DIR_NOT_SET"
+DM_VERITY_SIGN_CERT ?= "${DM_VERITY_SIGN_KEY_DIR}/x509_verity.crt"
+
+SRC_URI += " ${@bb.utils.contains("DM_VERITY_SIGN", "1", "file://dm-verity-verify.scc file://dm-verity-verify.cfg", "" ,d)}"
+KERNEL_FEATURES:append = " ${@bb.utils.contains("DM_VERITY_SIGN", "1", " dm-verity-verify.scc", "" ,d)}"
+
+KERNEL_TRUSTED_CERTS:append = " ${@d.getVar('DM_VERITY_SIGN_CERT') if d.getVar('DM_VERITY_SIGN') == '1' else ''}"
+inherit kernel-trusted-keys
-- 
2.43.0


