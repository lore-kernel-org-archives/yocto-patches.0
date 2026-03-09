Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC1FEFCD9E
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 11:50:55 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12361.1773057051293174468
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 04:50:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=kMhioglH;
 spf=pass (domain: mvista.com, ip: 74.125.82.175, mailfrom: hprajapati@mvista.com)
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be4781d2baso6702714eec.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1773057050; x=1773661850; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRuc+ueKZxHv3kGXB/3trH9VrkbNOxDEb+vw1MAmGvE=;
        b=kMhioglHh0MvDtsChtPvWdLzI2dM8JP8aoTisHcOLFgUDN7JhWgPd8m2VIJqJoVboU
         d6/7U4iSDbN0FJZSijnhie6C0PKAz7tPI+S4mULkaDBrwqLstmTE4uVkAMHSCDIdh9Jr
         ssCyV6kgAWLXOaEdKRmt7YAbOOVrvJe2Sbvzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773057050; x=1773661850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRuc+ueKZxHv3kGXB/3trH9VrkbNOxDEb+vw1MAmGvE=;
        b=d3m88pE0SOgYjX3eVnzD4FFDH5iLgjg69o5rWCHXofeVMjT261eRp4rQ1Ks9C99oc3
         06KEx0j+XBEX2pG0/gqlzDPAO9g7bz5EkP1GX0vkieBe62TXQ4Zk+5//agHL5m4R/jgM
         a1wMTpmrxGeaNtp3Jts9IV7aQcbqtPnsj3n/v19iJO0f0BDhnINKVJC6ErO9Jj4uurTi
         AqfMUpvGqWMNLMQo+2UouAAdFHnMHXeSx5p1YOYGiIhXwlGIboMQN6oEmr2tiKTzdFQE
         MMhMR6w3ditCylWvF9FKMg5dqeeCUX8WFPq+LY5qvIIq9Gi8QbLOufzLtEZhkicy4zfR
         2q8g==
X-Gm-Message-State: AOJu0Yw24NZmdsjpRawW+kfGxugOBjLGH8J2izNY+0D6bs6Wm9dM0Zlb
	+YopNINOH4gF/GDrhpSFHzjIxMj6NMRH3ZGYRxMuzDVzGX5DdV6wQ7efRF4MU+Oc2iaPMhBio7q
	ic13pPLQ=
X-Gm-Gg: ATEYQzxKZQM82wBOtH4PNYh2XusaiK/9atUeGgotVaBOwSR2gdrIiEuQkI8DKDaDoXh
	H2PU5scBkQ3Zx0WVEznPLbRSECrfzXW8sgcKquW+VGfgiBx8Sq4dJX5PP63vz+FOKDLvRNV1Ef0
	fuvFaEzo/MHaphEg/IItgtfoM+Zkk0Vaj2KPqI92S3+5lurAkC4NnpUJ1lgSjcdh1u5ctJ1PrpH
	sO2iz5fqN5d364VrH0OjppEYrQ2DC6E5f7Byx+XcFdH2OLIEawW1lwBXDd8PxafCYWWpi6qaQwG
	KZwxLTHVgt0DX/U3jDT84uCJYXLvDrsrkcRYezYEe0poGgagR0uIH62FDXYg3srx8r2XPq1ZIYQ
	NWEwiGXmeZrKuZsTLeaYIPWyp5oJ+KnV/5AMUmmbCiO4sZKOAZtm8kZOLpD76jYV/71+IUrnDy2
	5vc7RKasQY2BlQ5J4fC5EPP2Cq6TEHHY3rlPTNFVNfgmeccxXFV3WZ81papcYibNNI9gPednRkQ
	A==
X-Received: by 2002:a05:7300:dc91:b0:2be:2b5f:2baa with SMTP id 5a478bee46e88-2be4e0adfd9mr3578435eec.38.1773057050225;
        Mon, 09 Mar 2026 04:50:50 -0700 (PDT)
Received: from MVIN00013.mvista.com (103-216-234-140.swc13.starlings.in. [103.216.234.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be6df8a348sm2781405eec.30.2026.03.09.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:50:49 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: scott.murray@konsulko.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] suricata: Fix CVE-2026-22262
Date: Mon,  9 Mar 2026 17:20:38 +0530
Message-ID: <20260309115038.329072-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 11:50:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3383

Pick patch mentioned in NVD report [1]

[1] https://nvd.nist.gov/vuln/detail/CVE-2026-22262

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 .../suricata/files/CVE-2026-22262-01.patch    | 42 ++++++++++++
 .../suricata/files/CVE-2026-22262-02.patch    | 66 +++++++++++++++++++
 recipes-ids/suricata/suricata_7.0.13.bb       |  2 +
 3 files changed, 110 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2026-22262-01.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2026-22262-02.patch

diff --git a/recipes-ids/suricata/files/CVE-2026-22262-01.patch b/recipes-ids/suricata/files/CVE-2026-22262-01.patch
new file mode 100644
index 0000000..de54c28
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2026-22262-01.patch
@@ -0,0 +1,42 @@
+From 32609e6896f9079c175665a94005417cec7637eb Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Mon, 17 Nov 2025 13:27:54 +0100
+Subject: [PATCH] datasets: explicitly errors on too long string
+
+Also avoids stack allocation
+
+Ticket: 8110
+(cherry picked from commit 0eff24213763c2aa2bb0957901d5dc1e18414dbf)
+
+CVE: CVE-2026-22262
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/32609e6896f9079c175665a94005417cec7637eb]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/datasets-string.c | 9 +++++----
+ 1 file changed, 5 insertions(+), 4 deletions(-)
+
+diff --git a/src/datasets-string.c b/src/datasets-string.c
+index 0a8f499..524a60a 100644
+--- a/src/datasets-string.c
++++ b/src/datasets-string.c
+@@ -49,12 +49,13 @@ int StringAsBase64(const void *s, char *out, size_t out_size)
+     const StringType *str = s;
+ 
+     unsigned long len = Base64EncodeBufferSize(str->len);
+-    uint8_t encoded_data[len];
+-    if (Base64Encode((unsigned char *)str->ptr, str->len,
+-        encoded_data, &len) != SC_BASE64_OK)
++    if (len + 2 > out_size) {
++        // linefeed and final zero
++        return 0;
++    }
++    if (Base64Encode((unsigned char *)str->ptr, str->len, (uint8_t *)out, &len) != SC_BASE64_OK)
+         return 0;
+ 
+-    strlcpy(out, (const char *)encoded_data, out_size);
+     strlcat(out, "\n", out_size);
+     return strlen(out);
+ }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2026-22262-02.patch b/recipes-ids/suricata/files/CVE-2026-22262-02.patch
new file mode 100644
index 0000000..93e6546
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2026-22262-02.patch
@@ -0,0 +1,66 @@
+From 27a2180bceaa3477419c78c54fce364398d011f1 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Tue, 25 Nov 2025 14:43:18 +0100
+Subject: [PATCH] datasets: allocates on the heap if string base64 is long
+
+Ticket: 8110
+(cherry picked from commit d6bc718e303ecbec5999066b8bc88eeeca743658)
+
+CVE: CVE-2026-22262
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/32609e6896f9079c175665a94005417cec7637eb]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/datasets-string.c |  4 ++--
+ src/util-thash.c      | 21 ++++++++++++++++++++-
+ 2 files changed, 22 insertions(+), 3 deletions(-)
+
+diff --git a/src/datasets-string.c b/src/datasets-string.c
+index 524a60a..53a179a 100644
+--- a/src/datasets-string.c
++++ b/src/datasets-string.c
+@@ -50,8 +50,8 @@ int StringAsBase64(const void *s, char *out, size_t out_size)
+ 
+     unsigned long len = Base64EncodeBufferSize(str->len);
+     if (len + 2 > out_size) {
+-        // linefeed and final zero
+-        return 0;
++        // linefeed and final zero : signal we need more space
++        return len + 2;
+     }
+     if (Base64Encode((unsigned char *)str->ptr, str->len, (uint8_t *)out, &len) != SC_BASE64_OK)
+         return 0;
+diff --git a/src/util-thash.c b/src/util-thash.c
+index 5486379..c6df02c 100644
+--- a/src/util-thash.c
++++ b/src/util-thash.c
+@@ -390,7 +390,26 @@ int THashWalk(THashTableContext *ctx, THashFormatFunc FormatterFunc, THashOutput
+             char output_string[1024] = "";
+             int size = FormatterFunc(h->data, output_string, sizeof(output_string));
+             if (size > 0) {
+-                if (OutputterFunc(output_ctx, (const uint8_t *)output_string, size) < 0) {
++                if (size > 1024) {
++                    // we did not provide enough space on the stack, let's allocate on the heap
++                    char *out_alloc = SCCalloc(1, size);
++                    if (out_alloc == NULL) {
++                        err = true;
++                        break;
++                    }
++                    size = FormatterFunc(h->data, out_alloc, size);
++                    if (size == 0) {
++                        err = true;
++                        SCFree(out_alloc);
++                        break;
++                    }
++                    if (OutputterFunc(output_ctx, (const uint8_t *)out_alloc, size) < 0) {
++                        err = true;
++                        SCFree(out_alloc);
++                        break;
++                    }
++                    SCFree(out_alloc);
++                } else if (OutputterFunc(output_ctx, (const uint8_t *)output_string, size) < 0) {
+                     err = true;
+                     break;
+                 }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
index 75e523e..728c7f1 100644
--- a/recipes-ids/suricata/suricata_7.0.13.bb
+++ b/recipes-ids/suricata/suricata_7.0.13.bb
@@ -16,6 +16,8 @@ SRC_URI += " \
     file://suricata.service \
     file://run-ptest \
     file://0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch \
+    file://CVE-2026-22262-01.patch \
+    file://CVE-2026-22262-02.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
-- 
2.50.1


