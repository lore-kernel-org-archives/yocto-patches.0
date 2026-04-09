Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E49F31E58
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 15:58:07 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.132065.1775740277088843007
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 06:11:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm2 header.b=NqlC5aaX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-256628-20260409131113597ef5eca300020795-eh_6v6@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260409131113597ef5eca300020795
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 09 Apr 2026 15:11:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=O8cwQTACLkdrIw+ApMuIPzvBkhr4XvS5n8lbKxBWSHk=;
 b=NqlC5aaXfYJDdJtYP96OYQGjZGG2clbsoX5edpPz4asMiy/WiRKW+2wQRYout/Nrhio/cj
 3q+fKeEA97oN3j/OLbDxRwA1P/z/g0SWYvEUkWSbkTZeCWx1TLWq+mBYjukJGZLFRG4NgGOH
 vhlrKh0vceMim31yrU/tnaP3zT4jor4gJIsin3rcRA3mpN+GsgLzQnfU1zZZD0Coq3UCvxOF
 2KWUzB2rIYulquhR2k2EG41KgzUuVi65ekz3AoPvT/x52vnMuY7Tta0Ua3Wmknb8K2Z4y3nd
 /AHCjoSFHyxmfNO4VOo8MUX8Tp5opxPYE6njHZ9rd6PCrOJ7KN6N+ipw==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Peter Marko <peter.marko@siemens.com>
Subject: [meta-security][PATCH] tpm2-pkcs11: fix build failure
Date: Thu,  9 Apr 2026 15:10:32 +0200
Message-ID: <20260409131032.1093128-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 15:58:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3679

From: Peter Marko <peter.marko@siemens.com>

Use patch submitted upstream to fix build error:
| src/lib/tpm.c: In function ‘tpm_unseal’:
| src/lib/tpm.c:1040:16: error: incompatible types when returning type ‘_Bool’ but ‘twist’ {aka ‘const char *’} was expected
|  1040 |         return false;
|       |                ^~~~~

Signed-off-by: Peter Marko <peter.marko@siemens.com>
---
 ...eturn-NULL-for-twist-on-auth-failure.patch | 28 +++++++++++++++++++
 .../tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb          |  1 +
 2 files changed, 29 insertions(+)
 create mode 100644 meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch

diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch b/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
new file mode 100644
index 0000000..2992b11
--- /dev/null
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/files/0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch
@@ -0,0 +1,28 @@
+From 0db779aecaae93633be963ffb8fdb097c85cc166 Mon Sep 17 00:00:00 2001
+From: Peter Marko <peter.marko@siemens.com>
+Date: Thu, 9 Apr 2026 00:00:00 +0000
+Subject: [PATCH] src/lib/tpm: return NULL for twist on auth failure
+
+`tpm_unseal` returns `twist` (a const char pointer alias). Returning
+`false` in the error path is a type mismatch that fails with stricter
+compiler settings. Return `NULL` instead.
+
+Upstream-Status: Submitted [https://github.com/tpm2-software/tpm2-pkcs11/pull/923]
+Signed-off-by: Peter Marko <peter.marko@siemens.com>
+---
+ src/lib/tpm.c | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/src/lib/tpm.c b/src/lib/tpm.c
+index 5fff5d5..c51d984 100644
+--- a/src/lib/tpm.c
++++ b/src/lib/tpm.c
+@@ -1037,7 +1037,7 @@ twist tpm_unseal(tpm_ctx *ctx, uint32_t handle, twist objauth) {
+ 
+     bool result = set_esys_auth(ctx->esys_ctx, handle, objauth);
+     if (!result) {
+-        return false;
++        return NULL;
+     }
+ 
+     TPM2B_SENSITIVE_DATA *unsealed_data = NULL;
diff --git a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
index 331dc4f..762b82f 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pkcs11/tpm2-pkcs11_1.9.1.bb
@@ -7,6 +7,7 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=0fc19f620a102768d6dbd1e7166e78ab"
 DEPENDS = "autoconf-archive pkgconfig sqlite3 openssl libtss2-dev tpm2-tools libyaml p11-kit python3-setuptools-native"
 
 SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz"
+SRC_URI += "file://0001-src-lib-tpm-return-NULL-for-twist-on-auth-failure.patch"
 
 SRC_URI[sha256sum] = "ce24aa5ec2471545576e892b6f64fd873a424371bbf9be4ca3a0e689ea11c9b7"
 

