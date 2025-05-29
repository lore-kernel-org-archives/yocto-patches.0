Return-Path: <tim.orling@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED4C3ABB2
	for <webhook@archiver.kernel.org>; Thu, 29 May 2025 02:42:13 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.12283.1748486523348809998
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 May 2025 19:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pb2m8jF9;
 spf=pass (domain: konsulko.com, ip: 209.85.215.179, mailfrom: tim.orling@konsulko.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so482405a12.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 May 2025 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1748486522; x=1749091322; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBdsr0FDhMHV95agD75dqMgxG1h7FDlVgHQmn6FsZpc=;
        b=pb2m8jF9r4YZQNMONhBzJ0iRQ4Rpw1+bkbd72XpIFCWFvMZO7sEWypTqtEO+pkfnUB
         ZltF8IN/ZlNwt10A/vgGasVGCpGhWZ0WB3GnjvbZTTTG4h3ta+fch/zMOHQt/ImGIk+h
         ma8AvgefZKSAyf5sUlIJVx26DMN+Cm/GVs1hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748486522; x=1749091322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBdsr0FDhMHV95agD75dqMgxG1h7FDlVgHQmn6FsZpc=;
        b=B9pEEFeow+cm2KYAuQZAIZBGfzet5G0oki1Yz9ewVzZQZSXC6aEvoW18djM1rMWa1x
         NOUBRtfk68ZjNAJAxSDegt2P/GjFcCmJeY3zqEzvkulrDlvt/bRHy9XyEgPQwwZu17lJ
         Cf4PsBWdHAeNDcRAtq+xs365n6sRuzHpGWmsR/vKT3AJHdlK9hTCgIBIOS5RcaLzfsHb
         ONEm8a2Awf/TVcmmrNke+47CXtHQsODR/kSHDDjlIjmQUfCaUNB6SxuzpeLKsQO0jwjj
         ZR1Hb1bzcZW6lLHWoZ8kfcxD5vm91EDGyhh9AKJ0Ka1atWkR0Z6xt6kWrlG8S6HP5dDa
         Z1DA==
X-Gm-Message-State: AOJu0YzCv2UFAwkPZnXCw10si0htjFMqot/MG13j3oaXbNzR01qorRSF
	SN0Yrv1azNdJuHMRgmyzACqkQdUgUGUziCxQmQ9E/XfOfbV7iS0hXWRjXR5uZ/AT5NqFZFovxsS
	Xe02E9+p0eQ==
X-Gm-Gg: ASbGncslJwzhttWuskL7G9LdGBMKF1pDaoUmvfEkYtTtoWNrdigQY7aCe4a5y0iVH1i
	3knK0dZ8VtL+QhzZedVejhFf9tcZFS3Pzw4b8pRcmaFzDBSq2uKH9k6r+poeqwcfS0kjXbfyAGW
	bO3POc/P/S5ZBayUZ/vM4+/9IrhH7dbIa6hVKxcEwt4sCjiWo5jiezpCN4kaN+Kh00e9/n/4LV4
	2LiMcvYv8CjsdbiGvEHpgEMrdqnFGMZ3NU1R76CMjGDApfxIdmc3lKb5n7o/NGsYb0njufZe3RV
	5DkETHGcA1yET5X5p5HVYStRs0tqqU/grzcLkwKWLZSP51UrmPdZfkUKwMN8w7M8CgdiEy4GDLL
	Vk2YdFxvQb8r7qkE=
X-Google-Smtp-Source: AGHT+IEG+ZuW7YLWGb2iMa/MtQNyfqe4Yu1HdTsId+xgXCIExgwu3NrZTXV+g3mqzw83ZacRRWtkcA==
X-Received: by 2002:a17:90b:5205:b0:311:e9ac:f5ce with SMTP id 98e67ed59e1d1-311e9acf940mr5272283a91.21.1748486521730;
        Wed, 28 May 2025 19:42:01 -0700 (PDT)
Received: from localhost (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3121b6fb2a4sm350003a91.9.2025.05.28.19.42.00
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:42:01 -0700 (PDT)
From: tim.orling@konsulko.com
To: yocto-patches@lists.yoctoproject.org
Subject: [PATCH 03/11] u-boot.inc: Refactor do_* steps into functions that can be overridden
Date: Wed, 28 May 2025 19:41:30 -0700
Message-ID: <667fcf6da43756f373210fffd42b99dcd264677c.1748486276.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748486276.git.tim.orling@konsulko.com>
References: <cover.1748486276.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 29 May 2025 02:42:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1587

From: Ryan Eatmon <reatmon@ti.com>

The looping logic for handling (and not handling) UBOOT_CONFIG has led
to the various do_* functions to be large and unwieldy.  In order to
modify one of the functional blocks inside of a loop (or in the else
condition) means you either have to replace the function entirely, or
append the function and undo something it did and then do what you need
for your change.

This refactor breaks out all of the inner loops and else clauses into
new functions that themselves can be overridden without needing to
worry about the bulk of the looping logic.

It should not break any existing recipes doing prepends, appends, or
overrides.  None of the functional blocks were changed, just refactored
out into new functions.

(From OE-Core rev: 937bcc229502fcc154cc676b4fcc93c561873def)

Signed-off-by: Ryan Eatmon <reatmon@ti.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 recipes-bsp/u-boot/u-boot-configure.inc |  36 ++-
 recipes-bsp/u-boot/u-boot.inc           | 281 ++++++++++++++++--------
 2 files changed, 208 insertions(+), 109 deletions(-)

diff --git a/recipes-bsp/u-boot/u-boot-configure.inc b/recipes-bsp/u-boot/u-boot-configure.inc
index 235623d..fc74646 100644
--- a/recipes-bsp/u-boot/u-boot-configure.inc
+++ b/recipes-bsp/u-boot/u-boot-configure.inc
@@ -16,23 +16,35 @@ do_configure () {
             for type in ${UBOOT_CONFIG}; do
                 j=$(expr $j + 1);
                 if [ $j -eq $i ]; then
-                    oe_runmake -C ${S} O=${B}/${config} ${config}
-                    if [ -n "${@' '.join(find_cfgs(d))}" ]; then
-                        merge_config.sh -m -O ${B}/${config} ${B}/${config}/.config ${@" ".join(find_cfgs(d))}
-                        oe_runmake -C ${S} O=${B}/${config} oldconfig
-                    fi
+                    uboot_configure_config $config $type
                 fi
             done
             unset j
         done
         unset i
     else
-        if [ -n "${UBOOT_MACHINE}" ]; then
-            oe_runmake -C ${S} O=${B} ${UBOOT_MACHINE}
-        else
-            oe_runmake -C ${S} O=${B} oldconfig
-        fi
-        merge_config.sh -m .config ${@" ".join(find_cfgs(d))}
-        cml1_do_configure
+        uboot_configure
     fi
 }
+
+uboot_configure_config () {
+    config=$1
+    type=$2
+
+    oe_runmake -C ${S} O=${B}/${config} ${config}
+    if [ -n "${@' '.join(find_cfgs(d))}" ]; then
+        merge_config.sh -m -O ${B}/${config} ${B}/${config}/.config ${@" ".join(find_cfgs(d))}
+        oe_runmake -C ${S} O=${B}/${config} oldconfig
+    fi
+}
+
+uboot_configure () {
+    if [ -n "${UBOOT_MACHINE}" ]; then
+        oe_runmake -C ${S} O=${B} ${UBOOT_MACHINE}
+    else
+        oe_runmake -C ${S} O=${B} oldconfig
+    fi
+    merge_config.sh -m .config ${@" ".join(find_cfgs(d))}
+    cml1_do_configure
+}
+
diff --git a/recipes-bsp/u-boot/u-boot.inc b/recipes-bsp/u-boot/u-boot.inc
index 608d621..6f1170f 100644
--- a/recipes-bsp/u-boot/u-boot.inc
+++ b/recipes-bsp/u-boot/u-boot.inc
@@ -54,40 +54,21 @@ do_compile () {
 
     if [ -n "${UBOOT_CONFIG}" -o -n "${UBOOT_DELTA_CONFIG}" ]
     then
-        unset i j k
+        unset i j
         for config in ${UBOOT_MACHINE}; do
             i=$(expr $i + 1);
             for type in ${UBOOT_CONFIG}; do
                 j=$(expr $j + 1);
                 if [ $j -eq $i ]
                 then
-                    oe_runmake -C ${S} O=${B}/${config} ${UBOOT_MAKE_TARGET}
-                    for binary in ${UBOOT_BINARIES}; do
-                        k=$(expr $k + 1);
-                        if [ $k -eq $i ]; then
-                            cp ${B}/${config}/${binary} ${B}/${config}/${UBOOT_BINARYNAME}-${type}.${UBOOT_SUFFIX}
-                        fi
-                    done
-
-                    # Generate the uboot-initial-env
-                    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
-                        oe_runmake -C ${S} O=${B}/${config} u-boot-initial-env
-                        cp ${B}/${config}/u-boot-initial-env ${B}/${config}/u-boot-initial-env-${type}
-                    fi
-
-                    unset k
+                    uboot_compile_config $i $config $type
                 fi
             done
             unset j
         done
         unset i
     else
-        oe_runmake -C ${S} O=${B} ${UBOOT_MAKE_TARGET}
-
-        # Generate the uboot-initial-env
-        if [ -n "${UBOOT_INITIAL_ENV}" ]; then
-            oe_runmake -C ${S} O=${B} u-boot-initial-env
-        fi
+        uboot_compile
     fi
 
     if [ -n "${UBOOT_ENV}" ] && [ "${UBOOT_ENV_SUFFIX}" = "scr" ]
@@ -96,6 +77,46 @@ do_compile () {
     fi
 }
 
+uboot_compile_config () {
+    i=$1
+    config=$2
+    type=$3
+
+    oe_runmake -C ${S} O=${B}/${config} ${UBOOT_MAKE_TARGET}
+
+    unset k
+    for binary in ${UBOOT_BINARIES}; do
+        k=$(expr $k + 1);
+        if [ $k -eq $i ]; then
+            uboot_compile_config_copy_binary $config $type $binary
+        fi
+    done
+    unset k
+
+    # Generate the uboot-initial-env
+    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
+        oe_runmake -C ${S} O=${B}/${config} u-boot-initial-env
+        cp ${B}/${config}/u-boot-initial-env ${B}/${config}/u-boot-initial-env-${type}
+    fi
+}
+
+uboot_compile_config_copy_binary () {
+    config=$1
+    type=$2
+    binary=$3
+
+    cp ${B}/${config}/${binary} ${B}/${config}/${UBOOT_BINARYNAME}-${type}.${UBOOT_SUFFIX}
+}
+
+uboot_compile () {
+    oe_runmake -C ${S} O=${B} ${UBOOT_MAKE_TARGET}
+
+    # Generate the uboot-initial-env
+    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
+        oe_runmake -C ${S} O=${B} u-boot-initial-env
+    fi
+}
+
 do_install () {
     if [ -n "${UBOOT_CONFIG}" ]
     then
@@ -105,32 +126,14 @@ do_install () {
                 j=$(expr $j + 1);
                 if [ $j -eq $i ]
                 then
-                    install -D -m 644 ${B}/${config}/${UBOOT_BINARYNAME}-${type}.${UBOOT_SUFFIX} ${D}/boot/${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX}
-                    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${D}/boot/${UBOOT_BINARY}-${type}
-                    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${D}/boot/${UBOOT_BINARY}
-
-                    # Install the uboot-initial-env
-                    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
-                        install -D -m 644 ${B}/${config}/u-boot-initial-env-${type} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR}
-                        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}
-                        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${type}
-                        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}
-                    fi
+                    uboot_install_config $config $type
                 fi
             done
             unset j
         done
         unset i
     else
-        install -D -m 644 ${B}/${UBOOT_BINARY} ${D}/boot/${UBOOT_IMAGE}
-        ln -sf ${UBOOT_IMAGE} ${D}/boot/${UBOOT_BINARY}
-
-        # Install the uboot-initial-env
-        if [ -n "${UBOOT_INITIAL_ENV}" ]; then
-            install -D -m 644 ${B}/u-boot-initial-env ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR}
-            ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}
-            ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}
-        fi
+        uboot_install
     fi
 
     if [ -n "${UBOOT_ELF}" ]
@@ -143,17 +146,14 @@ do_install () {
                     j=$(expr $j + 1);
                     if [ $j -eq $i ]
                     then
-                        install -m 644 ${B}/${config}/${UBOOT_ELF} ${D}/boot/u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX}
-                        ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${D}/boot/${UBOOT_BINARY}-${type}
-                        ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${D}/boot/${UBOOT_BINARY}
+                        uboot_install_elf_config $config $type
                     fi
                 done
                 unset j
             done
             unset i
         else
-            install -m 644 ${B}/${UBOOT_ELF} ${D}/boot/${UBOOT_ELF_IMAGE}
-            ln -sf ${UBOOT_ELF_IMAGE} ${D}/boot/${UBOOT_ELF_BINARY}
+            uboot_install_elf
         fi
     fi
 
@@ -172,17 +172,14 @@ do_install () {
                     j=$(expr $j + 1);
                     if [ $j -eq $i ]
                     then
-                         install -m 644 ${B}/${config}/${SPL_BINARY} ${D}/boot/${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX}
-                         ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${D}/boot/${SPL_BINARYFILE}-${type}
-                         ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${D}/boot/${SPL_BINARYFILE}
+                        uboot_install_spl_config $config $type
                     fi
                 done
                 unset j
             done
             unset i
         else
-            install -m 644 ${B}/${SPL_BINARY} ${D}/boot/${SPL_IMAGE}
-            ln -sf ${SPL_IMAGE} ${D}/boot/${SPL_BINARYFILE}
+            uboot_install_spl
         fi
     fi
 
@@ -198,6 +195,63 @@ do_install () {
     fi
 }
 
+uboot_install_config () {
+    config=$1
+    type=$2
+
+    install -D -m 644 ${B}/${config}/${UBOOT_BINARYNAME}-${type}.${UBOOT_SUFFIX} ${D}/boot/${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX}
+    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${D}/boot/${UBOOT_BINARY}-${type}
+    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${D}/boot/${UBOOT_BINARY}
+
+    # Install the uboot-initial-env
+    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
+        install -D -m 644 ${B}/${config}/u-boot-initial-env-${type} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${type}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}
+    fi
+}
+
+uboot_install () {
+    install -D -m 644 ${B}/${UBOOT_BINARY} ${D}/boot/${UBOOT_IMAGE}
+    ln -sf ${UBOOT_IMAGE} ${D}/boot/${UBOOT_BINARY}
+
+    # Install the uboot-initial-env
+    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
+        install -D -m 644 ${B}/u-boot-initial-env ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}-${MACHINE}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${D}/${sysconfdir}/${UBOOT_INITIAL_ENV}
+    fi
+}
+
+uboot_install_elf_config () {
+    config=$1
+    type=$2
+
+    install -m 644 ${B}/${config}/${UBOOT_ELF} ${D}/boot/u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX}
+    ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${D}/boot/${UBOOT_BINARY}-${type}
+    ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${D}/boot/${UBOOT_BINARY}
+}
+
+uboot_install_elf () {
+    install -m 644 ${B}/${UBOOT_ELF} ${D}/boot/${UBOOT_ELF_IMAGE}
+    ln -sf ${UBOOT_ELF_IMAGE} ${D}/boot/${UBOOT_ELF_BINARY}
+}
+
+uboot_install_spl_config () {
+    config=$1
+    type=$2
+
+    install -m 644 ${B}/${config}/${SPL_BINARY} ${D}/boot/${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX}
+    ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${D}/boot/${SPL_BINARYFILE}-${type}
+    ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${D}/boot/${SPL_BINARYFILE}
+}
+
+uboot_install_spl () {
+    install -m 644 ${B}/${SPL_BINARY} ${D}/boot/${SPL_IMAGE}
+    ln -sf ${SPL_IMAGE} ${D}/boot/${SPL_BINARYFILE}
+}
+
 PACKAGE_BEFORE_PN += "${PN}-env ${PN}-extlinux"
 
 RPROVIDES:${PN}-env += "u-boot-default-env"
@@ -224,40 +278,14 @@ do_deploy () {
                 j=$(expr $j + 1);
                 if [ $j -eq $i ]
                 then
-                    install -D -m 644 ${B}/${config}/${UBOOT_BINARYNAME}-${type}.${UBOOT_SUFFIX} ${DEPLOYDIR}/${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX}
-                    cd ${DEPLOYDIR}
-                    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${UBOOT_SYMLINK}-${type}
-                    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${UBOOT_SYMLINK}
-                    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${UBOOT_BINARY}-${type}
-                    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${UBOOT_BINARY}
-
-                    # Deploy the uboot-initial-env
-                    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
-                        install -D -m 644 ${B}/${config}/u-boot-initial-env-${type} ${DEPLOYDIR}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR}
-                        cd ${DEPLOYDIR}
-                        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}
-                        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${type}
-                    fi
+                    uboot_deploy_config $config $type
                 fi
             done
             unset j
         done
         unset i
     else
-        install -D -m 644 ${B}/${UBOOT_BINARY} ${DEPLOYDIR}/${UBOOT_IMAGE}
-
-        cd ${DEPLOYDIR}
-        rm -f ${UBOOT_BINARY} ${UBOOT_SYMLINK}
-        ln -sf ${UBOOT_IMAGE} ${UBOOT_SYMLINK}
-        ln -sf ${UBOOT_IMAGE} ${UBOOT_BINARY}
-
-        # Deploy the uboot-initial-env
-        if [ -n "${UBOOT_INITIAL_ENV}" ]; then
-            install -D -m 644 ${B}/u-boot-initial-env ${DEPLOYDIR}/${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR}
-            cd ${DEPLOYDIR}
-            ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${MACHINE}
-            ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${UBOOT_INITIAL_ENV}
-        fi
+        uboot_deploy
     fi
 
     if [ -e ${WORKDIR}/fw_env.config ] ; then
@@ -277,20 +305,14 @@ do_deploy () {
                     j=$(expr $j + 1);
                     if [ $j -eq $i ]
                     then
-                        install -m 644 ${B}/${config}/${UBOOT_ELF} ${DEPLOYDIR}/u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX}
-                        ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${DEPLOYDIR}/${UBOOT_ELF_BINARY}-${type}
-                        ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${DEPLOYDIR}/${UBOOT_ELF_BINARY}
-                        ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${DEPLOYDIR}/${UBOOT_ELF_SYMLINK}-${type}
-                        ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${DEPLOYDIR}/${UBOOT_ELF_SYMLINK}
+                        uboot_deploy_elf_config $config $type
                     fi
                 done
                 unset j
             done
             unset i
         else
-            install -m 644 ${B}/${UBOOT_ELF} ${DEPLOYDIR}/${UBOOT_ELF_IMAGE}
-            ln -sf ${UBOOT_ELF_IMAGE} ${DEPLOYDIR}/${UBOOT_ELF_BINARY}
-            ln -sf ${UBOOT_ELF_IMAGE} ${DEPLOYDIR}/${UBOOT_ELF_SYMLINK}
+            uboot_deploy_elf
         fi
     fi
 
@@ -305,21 +327,14 @@ do_deploy () {
                     j=$(expr $j + 1);
                     if [ $j -eq $i ]
                     then
-                        install -m 644 ${B}/${config}/${SPL_BINARY} ${DEPLOYDIR}/${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX}
-                        rm -f ${DEPLOYDIR}/${SPL_BINARYFILE} ${DEPLOYDIR}/${SPL_SYMLINK}
-                        ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${DEPLOYDIR}/${SPL_BINARYFILE}-${type}
-                        ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${DEPLOYDIR}/${SPL_BINARYFILE}
-                        ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${DEPLOYDIR}/${SPL_SYMLINK}-${type}
-                        ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${DEPLOYDIR}/${SPL_SYMLINK}
+                        uboot_deploy_spl_config $config $type
                     fi
                 done
                 unset j
             done
             unset i
         else
-            install -m 644 ${B}/${SPL_BINARY} ${DEPLOYDIR}/${SPL_IMAGE}
-            ln -sf ${SPL_IMAGE} ${DEPLOYDIR}/${SPL_BINARYNAME}
-            ln -sf ${SPL_IMAGE} ${DEPLOYDIR}/${SPL_SYMLINK}
+            uboot_deploy_spl
         fi
     fi
 
@@ -343,4 +358,76 @@ do_deploy () {
     fi
 }
 
+uboot_deploy_config () {
+    config=$1
+    type=$2
+
+    install -D -m 644 ${B}/${config}/${UBOOT_BINARYNAME}-${type}.${UBOOT_SUFFIX} ${DEPLOYDIR}/${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX}
+    cd ${DEPLOYDIR}
+    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${UBOOT_SYMLINK}-${type}
+    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${UBOOT_SYMLINK}
+    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${UBOOT_BINARY}-${type}
+    ln -sf ${UBOOT_BINARYNAME}-${type}-${PV}-${PR}.${UBOOT_SUFFIX} ${UBOOT_BINARY}
+
+    # Deploy the uboot-initial-env
+    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
+        install -D -m 644 ${B}/${config}/u-boot-initial-env-${type} ${DEPLOYDIR}/${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR}
+        cd ${DEPLOYDIR}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${type}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${type}
+    fi
+}
+
+uboot_deploy () {
+    install -D -m 644 ${B}/${UBOOT_BINARY} ${DEPLOYDIR}/${UBOOT_IMAGE}
+
+    cd ${DEPLOYDIR}
+    rm -f ${UBOOT_BINARY} ${UBOOT_SYMLINK}
+    ln -sf ${UBOOT_IMAGE} ${UBOOT_SYMLINK}
+    ln -sf ${UBOOT_IMAGE} ${UBOOT_BINARY}
+
+    # Deploy the uboot-initial-env
+    if [ -n "${UBOOT_INITIAL_ENV}" ]; then
+        install -D -m 644 ${B}/u-boot-initial-env ${DEPLOYDIR}/${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR}
+        cd ${DEPLOYDIR}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${UBOOT_INITIAL_ENV}-${MACHINE}
+        ln -sf ${UBOOT_INITIAL_ENV}-${MACHINE}-${PV}-${PR} ${UBOOT_INITIAL_ENV}
+    fi
+}
+
+uboot_deploy_elf_config () {
+    config=$1
+    type=$2
+
+    install -m 644 ${B}/${config}/${UBOOT_ELF} ${DEPLOYDIR}/u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX}
+    ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${DEPLOYDIR}/${UBOOT_ELF_BINARY}-${type}
+    ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${DEPLOYDIR}/${UBOOT_ELF_BINARY}
+    ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${DEPLOYDIR}/${UBOOT_ELF_SYMLINK}-${type}
+    ln -sf u-boot-${type}-${PV}-${PR}.${UBOOT_ELF_SUFFIX} ${DEPLOYDIR}/${UBOOT_ELF_SYMLINK}
+}
+
+uboot_deploy_elf () {
+    install -m 644 ${B}/${UBOOT_ELF} ${DEPLOYDIR}/${UBOOT_ELF_IMAGE}
+    ln -sf ${UBOOT_ELF_IMAGE} ${DEPLOYDIR}/${UBOOT_ELF_BINARY}
+    ln -sf ${UBOOT_ELF_IMAGE} ${DEPLOYDIR}/${UBOOT_ELF_SYMLINK}
+}
+
+uboot_deploy_spl_config () {
+    config=$1
+    type=$2
+
+    install -m 644 ${B}/${config}/${SPL_BINARY} ${DEPLOYDIR}/${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX}
+    rm -f ${DEPLOYDIR}/${SPL_BINARYFILE} ${DEPLOYDIR}/${SPL_SYMLINK}
+    ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${DEPLOYDIR}/${SPL_BINARYFILE}-${type}
+    ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${DEPLOYDIR}/${SPL_BINARYFILE}
+    ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${DEPLOYDIR}/${SPL_SYMLINK}-${type}
+    ln -sf ${SPL_BINARYNAME}-${type}-${PV}-${PR}${SPL_DELIMITER}${SPL_SUFFIX} ${DEPLOYDIR}/${SPL_SYMLINK}
+}
+
+uboot_deploy_spl () {
+    install -m 644 ${B}/${SPL_BINARY} ${DEPLOYDIR}/${SPL_IMAGE}
+    ln -sf ${SPL_IMAGE} ${DEPLOYDIR}/${SPL_BINARYNAME}
+    ln -sf ${SPL_IMAGE} ${DEPLOYDIR}/${SPL_SYMLINK}
+}
+
 addtask deploy before do_build after do_compile
-- 
2.43.0


