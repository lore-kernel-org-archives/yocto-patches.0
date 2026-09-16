Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEC8C982D8
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:51 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26469.1789595924748322855
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=mHOIbQys;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafddso11129785a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595924; x=1790200724; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m6KHqiH7H3m6mHC0k8P48P1yPxwknFV3eHAQ6P7Id0I=;
        b=mHOIbQysHKLFYqJvjMgTyjj/jkH7+rvl16QBJ8ojFGn7XHjzX6GU/H+8c70KLy0qb2
         DhpcI0JW6EMaP5THVNnNDKxumFxD5q6I2mpzrHVkN/c3gx1RnIgkC3j/gl62pPozG4Ha
         exqR3xXSOwomj1+uY/5DNkyB5d1M1PonPj3KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595924; x=1790200724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m6KHqiH7H3m6mHC0k8P48P1yPxwknFV3eHAQ6P7Id0I=;
        b=v6m5EM+ZRMmv1amHE+DaS8uQYADLrfTieKbolCSNz8RKRGg8jvoUb/cILMWXOxppxm
         ChOFhj/v1EqoLY2/vU+hNR946tQ8+w+jNZvN83sLb01jjp9cVytJGUWaz/sb1A4me2Yv
         ybJUkZCWhy7OfBWiFJiID/PAUJU2yM+rbQToYUosH2Eb1MO4vdYP/MtOaOq4EO5IgQnK
         Pn83nxDC1qeu3WpHlI7W5xA1CBLTbDgeREGKDP4u1NjHHohCZXumuAg2RMoolDVFNuOq
         MBeF7DcIkYkrw7M1kqBxWe4sRpQnQ686DmP1ACLLXMR+0rnqOnt/wuyYrseXVGiVNA4A
         KA4Q==
X-Gm-Message-State: AFuF++nGD8470YvAfkQB1wkywxVsnz8i4vIG+OMZWtYqLB9o9/2lFy6k
	FZ0WiZqHtqgAdRoVE0AXfN4f1J08HrLWqr35eIgALMUN3MrHrVrTM7CwJfT/PgoypFjRmWh9kdz
	6c0F0
X-Gm-Gg: AYBFou0fSdqjdmVM5Q1xxb3yWaC2oC7Jbf4PnUcEP0m1wdZB0vCx5DfVXcLyXjIueYm
	B2UvJA+O4DTDTYFn7tRonyI9p1wlBbyDGXU+p0SXDEDAG94PmABx2mJlqz/vGjdbfbojFByQMwE
	HFcslD7tWGYr66HN9uvk4DZiydjHXiAimACAfCFQnqA5LhrkQj0OAMa6p+2mEXtH2J7N8WRxNoe
	n6JZ4dYvTHg2567Hm7d1OIzoG82OLf+nNLMdELENzyY++24JUgsf4j9JGRnBTkYbvD3AlXGn3Wi
	jfrxpjV23w7LP43Gt7/ybzCeKtuIjfv3hA125ugCX0Zux7A2M+4sM7TAz2Dbf5uHZr8gqonThcV
	iseNjV29QHZ5DzbOBmczRjBAdX8W2BcVg/0GXAncIL951dvSqLB8nBwHW669FVvABaQxSN4bBRO
	qMQPpySaw9NrSElS1uLQ+W8K3mRAiQ8NiVtjATvDtpXqKHfBUhhdUxEmZBx6AZgzFJoJVnJlNH0
	7MD6VFXUilS/xtJzW6b6aq9wcJvvJXMYvwsIC0m60z4iX4cJvoPqs7ROwzaNh6hrnvAxNz/rEU2
	ea0WZZLaJsFMkPcCqk0qay93Ss/j4WK6rbw=
X-Received: by 2002:a05:620a:4495:b0:939:191c:cac7 with SMTP id af79cd13be357-93bb7739b43mr744595785a.13.1789595923329;
        Wed, 16 Sep 2026 14:58:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:42 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 06/19] ossec-hids: upgrade 3.7.0 -> 4.3.0
Date: Wed, 16 Sep 2026 17:58:06 -0400
Message-ID: <2b8124189c5e73fab06a6f5c0f820a9950ae2922.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4861

Upgrade to 4.3.0 and add a patch to fix building with OpenSSL 4.0.

Release notes:
https://github.com/ossec/ossec-hids/releases/tag/3.8.0
https://github.com/ossec/ossec-hids/releases/tag/4.0.0
https://github.com/ossec/ossec-hids/releases/tag/4.1.0
https://github.com/ossec/ossec-hids/releases/tag/4.2.0
https://github.com/ossec/ossec-hids/releases/tag/4.3.0

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...Makefile-drop-running-scrips-install.patch |   7 +-
 .../0002-Makefile-don-t-set-uid-gid.patch     |   7 +-
 .../files/0003-Add-OpenSSL-4.0-support.patch  | 167 ++++++++++++++++++
 ...ssec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} |   5 +-
 4 files changed, 174 insertions(+), 12 deletions(-)
 create mode 100644 recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-support.patch
 rename recipes-ids/ossec/{ossec-hids_3.7.0.bb => ossec-hids_4.3.0.bb} (98%)

diff --git a/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-install.patch b/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-install.patch
index 08e018f..7b1600c 100644
--- a/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-install.patch
+++ b/recipes-ids/ossec/files/0001-Makefile-drop-running-scrips-install.patch
@@ -1,7 +1,7 @@
-From b948d36a8ca8e04794381f0f6eba29daf7e3fd01 Mon Sep 17 00:00:00 2001
+From 1035c4363148a831d2659bd88ac9d299cd6bd38e Mon Sep 17 00:00:00 2001
 From: Armin Kuster <akuster808@gmail.com>
 Date: Wed, 21 Apr 2021 00:56:53 +0000
-Subject: [PATCH 1/2] Makefile: drop running scrips @ install
+Subject: [PATCH] Makefile: drop running scrips @ install
 
 Upstream-Status: Inappropriate [embedded specific]
 
@@ -32,6 +32,3 @@ index 06a7094c..dfb8cb58 100644
  
  install-server-generic: install-common
  	$(call INSTALL_CMD,0660,${OSSEC_USER},${OSSEC_GROUP}) /dev/null ${PREFIX}/logs/active-responses.log
--- 
-2.25.1
-
diff --git a/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch b/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch
index d5e3403..fdbe49f 100644
--- a/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch
+++ b/recipes-ids/ossec/files/0002-Makefile-don-t-set-uid-gid.patch
@@ -1,7 +1,7 @@
-From d9ec907881b72d42b4918f7cfb46516ce8e77772 Mon Sep 17 00:00:00 2001
+From 9572062689514907fb613e0bad2cab2489141f92 Mon Sep 17 00:00:00 2001
 From: Armin Kuster <akuster808@gmail.com>
 Date: Sat, 24 Apr 2021 23:07:29 +0000
-Subject: [PATCH 2/2] Makefile: don't set uid/gid
+Subject: [PATCH] Makefile: don't set uid/gid
 
 Upstream-Status: Inappropriate [embedded specific]
 
@@ -246,6 +246,3 @@ index dfb8cb58..a4d69ef6 100644
  
  	rm -f ${PREFIX}/etc/shared/merged.mg
  
--- 
-2.25.1
-
diff --git a/recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-support.patch b/recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-support.patch
new file mode 100644
index 0000000..e1f0d98
--- /dev/null
+++ b/recipes-ids/ossec/files/0003-Add-OpenSSL-4.0-support.patch
@@ -0,0 +1,167 @@
+From 7e1e68047ef990fbf85d769088479439e2538073 Mon Sep 17 00:00:00 2001
+From: Scott Murray <scott.murray@konsulko.com>
+Date: Sun, 13 Sep 2026 22:14:10 +0300
+Subject: [PATCH] Add OpenSSL 4.0 support
+
+Rework TLS setup and X509 certificate checking code to handle OpenSSL
+4.0 API changes.
+
+Upstream-Status: Pending
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ src/os_auth/check_cert.c | 42 +++++++++++++++-------------------------
+ src/os_auth/check_cert.h |  4 ++--
+ src/os_auth/ssl.c        |  9 +++++++++
+ 3 files changed, 27 insertions(+), 28 deletions(-)
+
+diff --git a/src/os_auth/check_cert.c b/src/os_auth/check_cert.c
+index 365eecee..94fc7660 100644
+--- a/src/os_auth/check_cert.c
++++ b/src/os_auth/check_cert.c
+@@ -106,13 +106,13 @@ int check_subject_alt_names(X509 *cert, const char *manager)
+  */
+ int check_subject_cn(X509 *cert, const char *manager)
+ {
+-    X509_NAME *name = NULL;
++    const X509_NAME *name = NULL;
+     int result = VERIFY_FALSE;
+     int i = 0;
+ 
+     if ((name = X509_get_subject_name(cert))) {
+         while ((i = X509_NAME_get_index_by_NID(name, NID_commonName, i)) >= 0 && result == VERIFY_FALSE) {
+-            X509_NAME_ENTRY *ne = X509_NAME_get_entry(name, i);
++            const X509_NAME_ENTRY *ne = X509_NAME_get_entry(name, i);
+             result = check_hostname(X509_NAME_ENTRY_get_data(ne), manager);
+         }
+     }
+@@ -127,7 +127,7 @@ int check_subject_cn(X509 *cert, const char *manager)
+  * and compared. Matching is case insensitive and basic wildcard matching
+  * is supported.
+  */
+-int check_hostname(ASN1_STRING *cert_astr, const char *manager)
++int check_hostname(const ASN1_STRING *cert_astr, const char *manager)
+ {
+     label c_labels[DNS_MAX_LABELS];
+     label m_labels[DNS_MAX_LABELS];
+@@ -135,7 +135,7 @@ int check_hostname(ASN1_STRING *cert_astr, const char *manager)
+     int m_label_num = 0;
+     int wildcard_cert = 0;
+     int i = 0;
+-    char *cert_cstr = NULL;
++    unsigned char *cert_cstr = NULL;
+ 
+     if (!(cert_cstr = asn1_to_cstr(cert_astr))) {
+         return VERIFY_FALSE;
+@@ -143,9 +143,9 @@ int check_hostname(ASN1_STRING *cert_astr, const char *manager)
+ 
+     /* Convert domain names to arrays of labels separated by '.'
+      */
+-    c_label_num = label_array(cert_cstr, c_labels);
++    c_label_num = label_array((char*) cert_cstr, c_labels);
+     m_label_num = label_array(manager, m_labels);
+-    free(cert_cstr);
++    OPENSSL_free(cert_cstr);
+ 
+     /* Check that we have an appropriate number of labels and that the name
+      * from the certificate and the name given on the command line have
+@@ -193,11 +193,11 @@ int check_ipaddr(const ASN1_STRING *cert_astr, const char *manager)
+     memset(&iptest6, 0, sizeof(iptest6));
+ 
+     if (inet_pton(AF_INET, manager, &iptest.sin_addr) == 1) {
+-        if (cert_astr->length == 4 && !memcmp(cert_astr->data, (const void *)&iptest.sin_addr, 4)) {
++        if (ASN1_STRING_length(cert_astr) == 4 && !memcmp(ASN1_STRING_get0_data(cert_astr), (const void *)&iptest.sin_addr, 4)) {
+             return VERIFY_TRUE;
+         }
+     } else if (inet_pton(AF_INET6, manager, &iptest6.sin6_addr) == 1) {
+-        if (cert_astr->length == 16 && !memcmp(cert_astr->data, (const void *)&iptest6.sin6_addr, 16)) {
++        if (ASN1_STRING_length(cert_astr) == 16 && !memcmp(ASN1_STRING_get0_data(cert_astr), (const void *)&iptest6.sin6_addr, 16)) {
+             return VERIFY_TRUE;
+         }
+     }
+@@ -291,35 +291,25 @@ int label_match(const label *label1, const label *label2)
+ 
+ /* Convert an ASN1 string which may not be null terminated into a
+  * standard null terminated string. Also check for embedded null
+- * characters.
++ * characters.  The returned string should be freed with
++ * OPENSSL_free.
+  */
+-char *asn1_to_cstr(ASN1_STRING *astr)
++unsigned char *asn1_to_cstr(const ASN1_STRING *astr)
+ {
+-    unsigned int astr_len = 0;
+-    char *tmp = NULL;
+-    char *cstr = NULL;
++    size_t astr_len = 0;
++    unsigned char *cstr = NULL;
+ 
+-    if (!(astr_len = (unsigned int) ASN1_STRING_length(astr))) {
+-        return NULL;
+-    }
+-
+-    if (!(tmp = (char *)ASN1_STRING_data(astr))) {
++    if ((astr_len = ASN1_STRING_to_UTF8(&cstr, astr)) <= 0) {
+         return NULL;
+     }
+ 
+     /* Verify that the string does not contain embedded null characters.
+      */
+-    if (memchr(tmp, '\0', astr_len)) {
++    if (memchr(cstr, '\0', astr_len)) {
++        OPENSSL_free(cstr);
+         return NULL;
+     }
+ 
+-    if ((cstr = (char *) malloc(astr_len + 1)) == NULL) {
+-        return NULL;
+-    }
+-
+-    memcpy(cstr, tmp, astr_len);
+-    cstr[astr_len] = '\0';
+-
+     return cstr;
+ }
+ 
+diff --git a/src/os_auth/check_cert.h b/src/os_auth/check_cert.h
+index ff244dd9..fc804653 100644
+--- a/src/os_auth/check_cert.h
++++ b/src/os_auth/check_cert.h
+@@ -46,12 +46,12 @@ label;
+ int check_x509_cert(const SSL *ssl, const char *manager);
+ int check_subject_alt_names(X509 *cert, const char *manager);
+ int check_subject_cn(X509 *cert, const char *manager);
+-int check_hostname(ASN1_STRING *cert_astr, const char *manager);
++int check_hostname(const ASN1_STRING *cert_astr, const char *manager);
+ int check_ipaddr(const ASN1_STRING *cert_astr, const char *manager);
+ int label_array(const char *domain_name, label result[DNS_MAX_LABELS]);
+ int label_valid(const label *label);
+ int label_match(const label *label1, const label *label2);
+-char *asn1_to_cstr(ASN1_STRING *astr);
++unsigned char *asn1_to_cstr(const ASN1_STRING *astr);
+ 
+ #endif /* LIBOPENSSL_ENABLED */
+ #endif /* _CHECK_CERT_H */
+diff --git a/src/os_auth/ssl.c b/src/os_auth/ssl.c
+index c9b017cc..ec579ef1 100644
+--- a/src/os_auth/ssl.c
++++ b/src/os_auth/ssl.c
+@@ -104,10 +104,19 @@ SSL_CTX *get_ssl_context(const char *ciphers)
+     OpenSSL_add_all_algorithms();
+ 
+     /* Create our context */
++#if(OPENSSL_VERSION_NUMBER < 0x40000000L)
+     sslmeth = TLSv1_2_method();
++#else
++    sslmeth = TLS_method();
++#endif
+     if (!(ctx = SSL_CTX_new(sslmeth))) {
+         goto CONTEXT_ERR;
+     }
++#if(OPENSSL_VERSION_NUMBER >= 0x40000000L)
++    if (!(SSL_CTX_set_min_proto_version(ctx, TLS1_2_VERSION))) {
++        goto CONTEXT_ERR;
++    }
++#endif
+ 
+     /* Explicitly set options and cipher list */
+     SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2);
diff --git a/recipes-ids/ossec/ossec-hids_3.7.0.bb b/recipes-ids/ossec/ossec-hids_4.3.0.bb
similarity index 98%
rename from recipes-ids/ossec/ossec-hids_3.7.0.bb
rename to recipes-ids/ossec/ossec-hids_4.3.0.bb
index f8ee993..2ec7174 100644
--- a/recipes-ids/ossec/ossec-hids_3.7.0.bb
+++ b/recipes-ids/ossec/ossec-hids_4.3.0.bb
@@ -5,9 +5,10 @@ LIC_FILES_CHKSUM = "file://LICENSE;md5=d625d1520b5e38faefb81cf9772badc9"
 
 DEPENDS = "openssl libpcre2 zlib libevent"
 SRC_URI = "git://github.com/ossec/ossec-hids;branch=master;protocol=https \
-           file://0001-Makefile-drop-running-scrips-install.patch  \
+           file://0001-Makefile-drop-running-scrips-install.patch \
            file://0002-Makefile-don-t-set-uid-gid.patch \
-           "
+           file://0003-Add-OpenSSL-4.0-support.patch \
+"
 
 SRCREV = "bf797c759994015274f3bc31fe2bed278cce67ee"
 
-- 
2.55.0


