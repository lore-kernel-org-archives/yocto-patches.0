Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359CDC982DB
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:58:51 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26470.1789595925526293400
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=WL2Tu1+c;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93a2a8c29c4so13721085a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595924; x=1790200724; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CTTQ7TrsZUL/H94AgBRMU669AsoxJXSN11AidVtvlMo=;
        b=WL2Tu1+c6tFz89s23ct6NmeokKBLrzE74mYosWE7WIH53F61KN8bLm56OvJTTDMN+c
         5DPIvfYjRff32xhZA+HH5SndAowbf1ZTsffr4LUU3b5uOn0Km5orwHAFnQdWk3ZZR4Dy
         e+D4UtLfnnLYeRXluM5Y52Dh8k6ymZgc7Abds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595924; x=1790200724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CTTQ7TrsZUL/H94AgBRMU669AsoxJXSN11AidVtvlMo=;
        b=R58gDzT1VCGQmubZMbPSWICReFSwwbCeZUdBYaXyb3o7e8kf8knjM+fD7v0mzcOTzS
         KUDItoozn5mRk56NG1q+CchfRlXIvB/WZEbyRwYrjeGxozkQM/Qj9ZQQl6+MCqzxU47S
         1/6gfIjWJIWHiDd2rViqEV9m79wVaNypAEcVd7wVt6r9eIuOYSlVYXcrGCxeAO5yJ6QO
         d8r04igQahisFk03hn8CUOoELP6Vj6dx/Mq370g0ti6qya87pU5/6BcPKlAEOvJfq030
         7aWf6YLFRQ8+X7e3JxxYPos7qzcT0lP3eDfCAQ87EEKy33EWn/9n9BS/doo5xwu66qlg
         uvkQ==
X-Gm-Message-State: AFuF++nB0eTnOM+ADqix4ENCpM39y8o+9B9rrRvCU7koC9hjIlTirUuR
	5McNnmN+tU0moRCmFvgDRAkev4tpTI52iIJe91unV0wgkzQ726zzCTJNVz3SzKJ5hoTolaoC4N2
	husbV
X-Gm-Gg: AYBFou08oKcEyYWCBQ0sZFh6edOu7diAWJUtb/TstSf9WxTcDbG4tEH5JsV3zeMyCJ4
	v7F9x4+tazqJiPwS+BPiTAxpadGW68rNrAyeb8KoRLbmva4gOPTozTN+SJxCOt6pIsS3lTClA+w
	09lS6dxWSU6mHp1ewNCx1ZadGf7z988Ab4Yg7XmlZZWvOhoLoHKbBs8doAW2T71JRoFR1biBSQU
	nSG1M5C72lQ4rDDG012rcvYH5DMxLjf1DP2gHXhjhubsDE1zKTXR9fe6YQbD/VeyOxGCZtzIyqF
	lD2+ShwzbSjFu3go8C0o71ayI2GU88XIFHaWjIFoBhYQswIbcv+FyVuWAWeZ7JUKUNNG+lOUvDM
	0xenrqL3Dro3+5aU1PbwwCldjiteVyi5F0U30schMrf3fUcxZ3fxN0Xh/XCT3sEdZmEGxvRGRnO
	QSnotIjjD16FMVyq6FeXoLR1opCWBCornhxA+K3AyxpuDwlRvJVJt4MTPaNnVeTis0zJXmDNlTw
	5AeUUeFhevRFLxys/K+8mJdRkbBN/Hz8Xp0aw/y/a5/cxEf0cG9MJkZNGo3brzpMKzoHhvpq3eJ
	Csci189ADYVZ2W+PosZXCRD7aLx/7ADPlKQ=
X-Received: by 2002:a05:620a:2846:b0:939:72ae:e536 with SMTP id af79cd13be357-93bb7771730mr750682685a.13.1789595924337;
        Wed, 16 Sep 2026 14:58:44 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 07/19] clamav: upgrade 1.4.4 -> 1.4.6
Date: Wed, 16 Sep 2026 17:58:07 -0400
Message-ID: <3a2fcde2c57c5eb0b876971543ae3e3d71f0f24d.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:58:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4862

Upgrade to 1.4.6 and apply an outstanding upstream PR that adds
OpenSSL 4.0 support.

Release notes:
https://github.com/Cisco-Talos/clamav/releases/tag/clamav-1.4.5
https://github.com/Cisco-Talos/clamav/releases/tag/clamav-1.4.6

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../{clamav_1.4.4.bb => clamav_1.4.6.bb}      |   3 +-
 ...ed-OpenSSL-accessors-for-ASN1_STRING.patch | 122 ++++++++++++++++++
 2 files changed, 124 insertions(+), 1 deletion(-)
 rename recipes-scanners/clamav/{clamav_1.4.4.bb => clamav_1.4.6.bb} (98%)
 create mode 100644 recipes-scanners/clamav/files/0001-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch

diff --git a/recipes-scanners/clamav/clamav_1.4.4.bb b/recipes-scanners/clamav/clamav_1.4.6.bb
similarity index 98%
rename from recipes-scanners/clamav/clamav_1.4.4.bb
rename to recipes-scanners/clamav/clamav_1.4.6.bb
index b3f14cd..01eaf2b 100644
--- a/recipes-scanners/clamav/clamav_1.4.4.bb
+++ b/recipes-scanners/clamav/clamav_1.4.6.bb
@@ -16,13 +16,14 @@ LIC_FILES_CHKSUM = "file://COPYING.txt;md5=2c0b5770a62017a3121c69bb9f680b0c \
 DEPENDS = "glibc llvm libtool db openssl zlib curl libxml2 bison pcre2 json-c libcheck rust-native cargo-native"
 
 SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/1.4;protocol=https \
+           file://0001-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch \
            file://clamd.conf \
            file://freshclam.conf \
            file://volatiles.03_clamav \
            file://tmpfiles.clamav \
            "
 
-# ClamAV version 1.4.4
+# ClamAV version 1.4.6
 SRCREV = "f6d84be3c0048deb15c54d67e140dae062e5b82b"
 
 COMPATIBLE_HOST:libc-musl:class-target = "null"
diff --git a/recipes-scanners/clamav/files/0001-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch b/recipes-scanners/clamav/files/0001-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch
new file mode 100644
index 0000000..ca17e2c
--- /dev/null
+++ b/recipes-scanners/clamav/files/0001-Use-non-deprecated-OpenSSL-accessors-for-ASN1_STRING.patch
@@ -0,0 +1,122 @@
+From 13ff91836da6f85e16a6db0aa0517dccab76aa82 Mon Sep 17 00:00:00 2001
+From: Bob Beck <beck@openssl.org>
+Date: Fri, 5 Dec 2025 15:50:23 -0700
+Subject: [PATCH] Use non deprecated OpenSSL accessors for ASN1_STRING values.
+
+This changes your time conversion routine to use
+ASN1_STRING_get0_data() and ASN1_STRING_length() rather than
+directly using the values from the object.
+
+OpenSSL plans to make ASN1_STRING opaque soon:
+https://github.com/openssl/openssl/issues/29117
+
+The accessor in question is in OpenSSL 1.1 as well as
+BoringSSL and LibreSSL so should be widely available.
+
+As the returned value is const, and you are changing it
+to pass to strptime, I've made it make a copy to work with.
+
+Since I added another allocation I converted it to single
+return to ensure everything gets freed appropriately.
+
+Upstream-Status: Pending [https://github.com/Cisco-Talos/clamav/pull/1642]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ libclamav/crypto.c | 46 +++++++++++++++++++++++++++-------------------
+ 1 file changed, 27 insertions(+), 19 deletions(-)
+
+diff --git a/libclamav/crypto.c b/libclamav/crypto.c
+index 8b398e402..61c6d5434 100644
+--- a/libclamav/crypto.c
++++ b/libclamav/crypto.c
+@@ -1748,9 +1748,10 @@ X509 *cl_load_cert(const char *certpath)
+ 
+ struct tm *cl_ASN1_GetTimeT(ASN1_TIME *timeobj)
+ {
+-    struct tm *t;
+-    char *str;
+-    const char *fmt = NULL;
++    struct tm *ret = NULL;
++    struct tm *t   = NULL;
++    char *str      = NULL;
++    const char *data, *fmt = NULL;
+     time_t localt;
+ #ifdef _WIN32
+     struct tm localtm, *ltm;
+@@ -1758,18 +1759,21 @@ struct tm *cl_ASN1_GetTimeT(ASN1_TIME *timeobj)
+     struct tm localtm;
+ #endif
+ 
+-    if (!(timeobj) || !(timeobj->data))
+-        return NULL;
++    if (timeobj == NULL || (data = ASN1_STRING_get0_data(timeobj)) == NULL)
++        goto done;
++
++    str = CLI_STRNDUP(data, ASN1_STRING_length(timeobj));
++    if (NULL == str)
++        goto done;
+ 
+-    str = (char *)(timeobj->data);
+     if (strlen(str) < 12)
+-        return NULL;
++        goto done;
+ 
+     t = (struct tm *)calloc(1, sizeof(struct tm));
+     if (!(t))
+-        return NULL;
++        goto done;
+ 
+-    if (timeobj->type == V_ASN1_UTCTIME) {
++    if (ASN1_STRING_type(timeobj) == V_ASN1_UTCTIME) {
+         /* two digit year */
+         fmt = "%y%m%d%H%M%S";
+         if (str[3] == '0') {
+@@ -1778,7 +1782,7 @@ struct tm *cl_ASN1_GetTimeT(ASN1_TIME *timeobj)
+         } else {
+             str[3]--;
+         }
+-    } else if (timeobj->type == V_ASN1_GENERALIZEDTIME) {
++    } else if (ASN1_STRING_type(timeobj) == V_ASN1_GENERALIZEDTIME) {
+         /* four digit year */
+         fmt = "%Y%m%d%H%M%S";
+         if (str[5] == '0') {
+@@ -1789,15 +1793,11 @@ struct tm *cl_ASN1_GetTimeT(ASN1_TIME *timeobj)
+         }
+     }
+ 
+-    if (!(fmt)) {
+-        free(t);
+-        return NULL;
+-    }
++    if (!(fmt))
++        goto done;
+ 
+-    if (!strptime(str, fmt, t)) {
+-        free(t);
+-        return NULL;
+-    }
++    if (!strptime(str, fmt, t))
++        goto done;
+ 
+     /* Convert to local time */
+     localt = time(NULL);
+@@ -1808,7 +1808,15 @@ struct tm *cl_ASN1_GetTimeT(ASN1_TIME *timeobj)
+     localtime_r(&localt, &localtm);
+ #endif
+     t->tm_isdst = localtm.tm_isdst;
+-    return t;
++
++    ret = t;
++    t   = NULL;
++
++done:
++    free(t);
++    free(str);
++
++    return ret;
+ }
+ 
+ X509_CRL *cl_load_crl(const char *file)
+-- 
+2.47.3
+
-- 
2.55.0


