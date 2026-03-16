Return-Path: <hfranco@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B20AFB5E88
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 23:23:33 +0000 (UTC)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.64610.1773703403581777357
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Mar 2026 16:23:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=wYtUaKFs;
 spf=pass (domain: baylibre.com, ip: 74.125.82.42, mailfrom: hfranco@baylibre.com)
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12713e56abdso209373c88.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773703403; x=1774308203; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p6wJyigSwZNpCWteK6HQ3zig8RAAVMi6rpVjMhXUOg=;
        b=wYtUaKFs+4BlvEVusMEVGuNrujCI/5KBbFr9JXLgzGzgAxeGFGEXB2EFds2xWnjEV8
         Vtoy+MWZnqQvrwiii/DIJVQdjNmvn7qMs1cnRctLEqaQOyVLnbMYCVa+GJ6wtNBEWlcO
         1gFztXCAUTm+DE6CM9d6gOh/MsbUGnT1RdjuONS2PFUyYU9gJ+rPL/e2WnTg6UVjr+0q
         dwNjxbAChJDlHJFaTvtQmINL2IsCVhaw3zNQGjgMfOz6jn+lkuX7qrHI79JgPtn1j3pH
         cfmzUZLHx+aqSQpjgfpq3EBL3tw46zN2emM+0pakKgf0yDnI2a6ae0HXG5lFiNrQS5ib
         xJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773703403; x=1774308203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4p6wJyigSwZNpCWteK6HQ3zig8RAAVMi6rpVjMhXUOg=;
        b=kkDnlVXzI1YEULpusOJiA/JQ6V9glASv8g1AVSK6WFkSPhhYmlRPDxcaDgaxoU1X8e
         /f8TNXCN33El+QOjp1v3b5hUsu66pn83MelTWxxHHdwvRTl+ehdaAHfEhBf3MPKYB0Ap
         we1X9X+zr2tT8u6guNuMLGb4i35V91XxljljWJBPZwJ+uu8Bhw+GaCx8I0TKG3IWgauX
         NRjTBU/XATPJQ2tYV5phamXUhhBSVxswEUNcfWvPsAZvUZ5ucIgr0VPZivYoBabmlJVl
         F3ZvAIVhzB7ZyZjxluSbsXGv8gZqdw6d7rCUtWlb1vBFsy3eEP5bzIOaysekpRkDwUTx
         lF+A==
X-Gm-Message-State: AOJu0YzK3m53KRw3gKQl9v18VJMr1s6DxyDYS5YQlC1WONpa42rJpmfr
	Pt+5tA/BYSklfux3TPJWcLaDWRUcrzvRmlG2fdPZ8ykCr67pwoDXeaE10hlclwZ0gewFgAkgZY0
	KZpwpI40=
X-Gm-Gg: ATEYQzzZBwVXd2/0PHJNzbSS53otMiuxhcOvTxN5NIFUuvx4G0U11cAUGPmctwNKYX6
	mXEGwgeS5T5m/n/oIO2q8aHFJfB51+4Ija6PW2/lAbNL5iE0YNI1+xV4Zz98G/Peh7wUtAusxQG
	fZ1pMXGShXIMosYn5QxvdY/t0b6T0WjtOQZ3CllCR9sGiquACY2ba+/vO33mdNyzOyZXBD3D9Tv
	/MkXuTviXm8r2arUZQ1k+bjnaRemBL9K8MfUfHARLXof16Sb0mqHd3+fgSmWMZPlvgBAM4IrPjc
	3owyGnGn98S0CDL5Ww7TEZNoWL7on3xEExUFhlODCj/VYtR4up6JrwQitJ5zIqTh3HPgx/JDtES
	OyJcQCetwmF63b+nuQqF2xE4AY6ZFZRNH5rXE39YRw1kAi4Nf3Q1PirsXiFdrxevwMIzxvDhvPX
	kCkyqlBHOGhpApTDJd6TOReCRi7G05ZgcYS68ERhLWubsQDmw2495ATnv13T9dP5KsNrlxsFmGX
	LdpdwT8Z7SMQbuvAV5kIN6Qk1jJObc=
X-Received: by 2002:a05:7022:1609:b0:123:331f:978f with SMTP id a92af1059eb24-1291721758amr564984c88.7.1773703402589;
        Mon, 16 Mar 2026 16:23:22 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a7c0:c4f1:ec8d:3c3c:583d:3ed])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6384e7asm13492586c88.11.2026.03.16.16.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 16:23:22 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>,
	Yi Zhao <yi.zhao@windriver.com>
Subject: [meta-selinux][scarthgap][PATCH 2/2] refpolicy: Add support to configure policy store root
Date: Mon, 16 Mar 2026 20:21:58 -0300
Message-ID: <20260316232253.937832-3-hfranco@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316232253.937832-1-hfranco@baylibre.com>
References: <20260316232253.937832-1-hfranco@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 16 Mar 2026 23:23:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3481

From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>

By default, policy modules(*.pp) are stored in /var directory.
Features like: ostree remove files in folders like /var
variable data directory while build time.

Added support for custom policy store. We can now configure
path to custom policy store to variable `POLICY_STORE_ROOT`.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
(cherry picked from commit 8572e130415dfa9fb48aec6ae1758e10dab7b1e7)
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 .../refpolicy/refpolicy-minimum_git.bb        |  2 +-
 .../refpolicy/refpolicy_common.inc            |  9 ++++++---
 recipes-security/selinux/libsemanage_3.7.bb   | 20 ++++++++++++++++---
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/recipes-security/refpolicy/refpolicy-minimum_git.bb b/recipes-security/refpolicy/refpolicy-minimum_git.bb
index 562ccac..b224b46 100644
--- a/recipes-security/refpolicy/refpolicy-minimum_git.bb
+++ b/recipes-security/refpolicy/refpolicy-minimum_git.bb
@@ -65,7 +65,7 @@ prepare_policy_store() {
     oe_runmake 'DESTDIR=${D}' 'prefix=${D}${prefix}' install
     POL_PRIORITY=100
     POL_SRC=${D}${datadir}/selinux/${POLICY_NAME}
-    POL_STORE=${D}${localstatedir}/lib/selinux/${POLICY_NAME}
+    POL_STORE=${D}${POLICY_STORE_ROOT}/${POLICY_NAME}
     POL_ACTIVE_MODS=${POL_STORE}/active/modules/${POL_PRIORITY}
 
     # Prepare to create policy store
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 9d4f68a..b1d2701 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -98,10 +98,12 @@ SRC_URI += " \
 S = "${WORKDIR}/refpolicy"
 
 CONFFILES:${PN} = "${sysconfdir}/selinux/config"
+
+POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux"
 FILES:${PN} += " \
     ${sysconfdir}/selinux/${POLICY_NAME}/ \
     ${datadir}/selinux/${POLICY_NAME}/*.pp \
-    ${localstatedir}/lib/selinux/${POLICY_NAME}/ \
+    ${POLICY_STORE_ROOT}/${POLICY_NAME}/ \
     "
 FILES:${PN}-dev =+ " \
     ${datadir}/selinux/${POLICY_NAME}/include/ \
@@ -184,7 +186,7 @@ prepare_policy_store() {
     oe_runmake 'DESTDIR=${D}' 'prefix=${D}${prefix}' install
     POL_PRIORITY=100
     POL_SRC=${D}${datadir}/selinux/${POLICY_NAME}
-    POL_STORE=${D}${localstatedir}/lib/selinux/${POLICY_NAME}
+    POL_STORE=${D}${POLICY_STORE_ROOT}/${POLICY_NAME}
     POL_ACTIVE_MODS=${POL_STORE}/active/modules/${POL_PRIORITY}
 
     # Prepare to create policy store
@@ -225,13 +227,14 @@ args = \$@
 [end]
 
 policy-version = 33
+store-root = "${POLICY_STORE_ROOT}"
 EOF
 
     # Create policy store and build the policy
     semodule -p ${D} -s ${POLICY_NAME} -n -B
     rm -f ${D}${sysconfdir}/selinux/semanage.conf
     # No need to leave final dir created by semanage laying around
-    rm -rf ${D}${localstatedir}/lib/selinux/final
+    rm -rf ${D}${POLICY_STORE_ROOT}/final
 }
 
 install_misc_files() {
diff --git a/recipes-security/selinux/libsemanage_3.7.bb b/recipes-security/selinux/libsemanage_3.7.bb
index 93eb870..67af26f 100644
--- a/recipes-security/selinux/libsemanage_3.7.bb
+++ b/recipes-security/selinux/libsemanage_3.7.bb
@@ -34,6 +34,8 @@ FILES:${PN}-python = "${PYTHON_SITEPACKAGES_DIR}/* \
 FILES:${PN}-dbg += "${PYTHON_SITEPACKAGES_DIR}/.debug/*"
 FILES:${PN} += "${libexecdir}"
 
+POLICY_STORE_ROOT ?= "${localstatedir}/lib/selinux"
+
 do_compile:append() {
     oe_runmake pywrap \
         PYLIBVER='python${PYTHON_BASEVERSION}' \
@@ -48,9 +50,21 @@ do_install:append() {
         PYLIBVER='python${PYTHON_BASEVERSION}' \
         PYTHONLIBDIR='${PYTHON_SITEPACKAGES_DIR}'
 
-    # Update "policy-version" for semanage.conf
-    sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 33/' \
-        ${D}/etc/selinux/semanage.conf
+    conf_file="${D}/etc/selinux/semanage.conf"
+
+    if [ -f "${conf_file}" ]; then
+        # Update "policy-version" for semanage.conf
+        sed -i 's/^#\s*\(policy-version\s*=\).*$/\1 33/' \
+            ${D}/etc/selinux/semanage.conf
+
+        # Update "store-root" for semanage.conf
+        if grep -q '^store-root=' "${conf_file}"; then
+            sed -i "s|^store-root=.*$|store-root=${POLICY_STORE_ROOT}|" "${conf_file}"
+        else
+            printf 'store-root=%s\n' "${POLICY_STORE_ROOT}" >> "${conf_file}"
+        fi
+    fi
+
 }
 
 BBCLASSEXTEND = "native"
-- 
2.47.3


