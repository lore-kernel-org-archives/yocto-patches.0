Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84787C982D1
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 21:59:01 +0000 (UTC)
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26479.1789595933419636977
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 14:58:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=N/G1NHtA;
 spf=pass (domain: konsulko.com, ip: 74.125.230.235, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910cc46c4so9145285a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 14:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789595932; x=1790200732; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ptDp+IPMbHsDWvEgdNYm2qpEtn0LxtXR//RVN6YnWY=;
        b=N/G1NHtAFQM2m4s3wCIuYkqPwG3qCh37hZ6itUreQ8Goeedz0HqxmnqAc3oOfndyOj
         kNA2Z/1Pj7+MNyKiD4/pLisERRx147PpCncuxBHIBt2+VuMQDXi5ZKHv3KM70OY2k8ZL
         pnsXmELD7Af3Ahyb1GG3WQgXVJ60J64QaKuJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789595932; x=1790200732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6ptDp+IPMbHsDWvEgdNYm2qpEtn0LxtXR//RVN6YnWY=;
        b=XFd7qhu+SJPRIcvIwWRXzfuQuLE2JEumBvf3sfaDlJqAH01cAf5R9bDHCw1RyYPJGD
         nwOtA1sd+HElQAbMpriCcFLJtol1FhNZ71nFyh/xZ/j70BHCIB175UOjmyRww2KuUG8Q
         Sy2JHeJ37NmQJY9drHnUYvi/0vsQwn0B8DnyyvZ6Hkwpx4SmjI1qdyd868OouCfKVS/X
         SOUnXHV5r88bU34RXFX7Zhfqjzy64p7jOt3CqXgMsxVdiNP+u1GVYlxlH/akWjZhh1+v
         oCv2me9FqMRkM6Ogh43p7x5y6H8Lv/5SF9oFcMQhxO/AqTjx5vSjqhXiLv199XO/OlGl
         xpOA==
X-Gm-Message-State: AFuF++m7EughFDFTtK5U227nhVaV56w4Heej+aL+cgn/s3ezKs1cr6gE
	tP0+weTKf0lCabVMJqJU/iQ35BpNh+9onVDiwyO3+nJnUEq1TeZSvev+9+1hJ/fGQbMA4bG7ZcO
	CbeeR
X-Gm-Gg: AYBFou08Q/Y47UXS2TwVQDvg9NC7ZFKLs90AcJ7w1VyvEZGQT0pk5JS3YFP4C3b3YaD
	Khc21h/ys3FzWOQz4/Qy1Ge39Huc55dMOdpVpZ/4m8I3utCb7mcO0pUjgcYAosuqgTprg6A95q2
	Ge6mLdV59Zjjn5GbKTOGvipngTIqXDS3XtU0cQhir64GgOYFrISzPN6W/D+HBKaQ4G7LGvbodKP
	FL0XXweYW0vowhUu3qbW4z19YoOM3g3IwoAmcEk3kaRLZmuuPlmSMCCPZb7Ol2XYNNDxnetIPYO
	/0b8bkwOdczMZoifUtUYkdeWkDoLLURJYPo42dqX9lQluwFk7unq7MjvmtbQ4MuYc3hoZ4LY6ZU
	4fpFS9JTZ5QBUNmkvS6NtpJsUU5Ssm5lbFyOuBlIS8MjV8nMPJvur05M5q9lMPjBZ4k5HHE5u6K
	6HqRozgp7DhagkffwLU3dnrNenN69Q2nkGWoOkQMz3/Ca02fP3Ly9b0EkraT7D2Yo9DZMv7RTao
	Sy/1Y+Y9nFVEBPBYllU9EJk6YBl3xXsje743/qAH03Gs9cB2ZpFmnZwoSo9xAXgvtL1KnHaSetH
	JBZemFQujYkeUjqf1yqdcIi2Ebq2zSddVnlo
X-Received: by 2002:a05:620a:6290:b0:939:6dea:374c with SMTP id af79cd13be357-93bb794834emr665057485a.48.1789595932073;
        Wed, 16 Sep 2026 14:58:52 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781def43sm323293085a.16.2026.09.16.14.58.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:58:51 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 16/19] aide: upgrade 0.19.3 -> 0.19.4
Date: Wed, 16 Sep 2026 17:58:16 -0400
Message-ID: <bb7ac2179a808e0e1122d999ed6fb564205513c1.1789595456.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789595456.git.scott.murray@konsulko.com>
References: <cover.1789595456.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 21:59:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4872

Release notes:
https://github.com/aide/aide/releases/tag/v0.19.4

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0002-Support-build-with-nettle-4.patch    | 53 -------------------
 .../aide/{aide_0.19.3.bb => aide_0.19.4.bb}   |  3 +-
 2 files changed, 1 insertion(+), 55 deletions(-)
 delete mode 100644 recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch
 rename recipes-ids/aide/{aide_0.19.3.bb => aide_0.19.4.bb} (94%)

diff --git a/recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch b/recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch
deleted file mode 100644
index d9c6fad..0000000
--- a/recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch
+++ /dev/null
@@ -1,53 +0,0 @@
-From 84936cec8ddb7151327563800d752d1d20e39224 Mon Sep 17 00:00:00 2001
-From: Hannes von Haugwitz <hannes@vonhaugwitz.com>
-Date: Tue, 26 May 2026 21:41:52 +0200
-Subject: [PATCH] Support build with nettle 4
-
-* closes: #218
-
-Upstream-Status: Backport [https://github.com/aide/aide/commit/61130addb02a58d7de95d6b8f344ab9b6151d6aa]
-Signed-off-by: Scott Murray <scott.murray@konsulko.com>
----
- ChangeLog | 3 +++
- src/md.c  | 6 ++++++
- 2 files changed, 9 insertions(+)
-
-diff --git a/ChangeLog b/ChangeLog
-index 89905e3..5b3963e 100644
---- a/ChangeLog
-+++ b/ChangeLog
-@@ -1,3 +1,6 @@
-+2026-05-26 Hannes von Haugwitz <hannes@vonhaugwitz.com>
-+	* Support build with nettle 4 (closes: #218)
-+
- 2026-01-31 Hannes von Haugwitz <hannes@vonhaugwitz.com>
- 	* Release aide 0.19.3
- 
-diff --git a/src/md.c b/src/md.c
-index e4e66ad..1aec9d9 100644
---- a/src/md.c
-+++ b/src/md.c
-@@ -47,6 +47,8 @@
- #include <nettle/gosthash94.h>
- #include <nettle/streebog.h>
- 
-+#include <nettle/version.h>
-+
- typedef struct {
-   nettle_hash_init_func *init;
-   nettle_hash_update_func *update;
-@@ -166,7 +168,11 @@ int close_md(struct md_container* md, md_hashsums * hs, const char *filename, co
-         for (HASHSUM i = 0 ; i < num_hashes ; ++i) {
-             DB_ATTR_TYPE h = ATTR(hashsums[i].attribute);
-             if (h&md->calc_attr) {
-+#if NETTLE_VERSION_MAJOR < 4
-                 nettle_functions[i].digest(&md->ctx[i].md5, hashsums[i].length, hs->hashsums[i]);
-+#else
-+                nettle_functions[i].digest(&md->ctx[i].md5, hs->hashsums[i]);
-+#endif
-             }
-         }
- #endif
--- 
-2.47.3
-
diff --git a/recipes-ids/aide/aide_0.19.3.bb b/recipes-ids/aide/aide_0.19.4.bb
similarity index 94%
rename from recipes-ids/aide/aide_0.19.3.bb
rename to recipes-ids/aide/aide_0.19.4.bb
index c352583..9cdd601 100644
--- a/recipes-ids/aide/aide_0.19.3.bb
+++ b/recipes-ids/aide/aide_0.19.4.bb
@@ -7,11 +7,10 @@ DEPENDS = "bison-native libpcre2"
 
 SRC_URI = "https://github.com/aide/aide/releases/download/v${PV}/${BPN}-${PV}.tar.gz \
            file://0001-Fixes-build-issues.patch \
-           file://0002-Support-build-with-nettle-4.patch \
            file://aide.conf \
 "
 
-SRC_URI[sha256sum] = "6513170bb5b8c22802dd1b72f02d8aa9f432aef2b4470522db03e755212a3f47"
+SRC_URI[sha256sum] = "47ab7c696f0745911479a41f90d7ad99d26536e186d66c4aad093bc72d20ff5f"
 
 UPSTREAM_CHECK_URI = "https://github.com/${BPN}/${BPN}/releases"
 
-- 
2.55.0


