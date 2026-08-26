Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A1C61DC6
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:53 +0000 (UTC)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22624.1787777925570356585
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Aug 2026 13:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Jbr6wrs6;
 spf=pass (domain: konsulko.com, ip: 209.85.219.47, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so8649596d6.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1787777924; x=1788382724; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r/WtVM/JK/oVq31hslkMIBTM/smJnS9JZn7b3/qPMiA=;
        b=Jbr6wrs6LEqZxwA6YR0hxMOcyo5y8Q7arWuzeQl3PCgmyEzaMwWubkW3wGVO7qOWzT
         vjR2xFqni8v4fiYLKZvWoiDtR6g/a3xJoeGyv6w6645O7KPTCHtZT5bSOA/0VMxFD2jt
         7P3GO7UCsZmGHDyNpy8lJdw9GdrwFd5By2xug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787777924; x=1788382724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r/WtVM/JK/oVq31hslkMIBTM/smJnS9JZn7b3/qPMiA=;
        b=eqj+8gmuCbgYCRXAKhtmbq7jvYwD07oHqXDe6fuD1nHhnhbr3XyKlYTVP3rP6MqBCo
         EhrTZimvMZQKTfVxxMtIT4jxZXMilS9/msSPMb9A/2XIpu2RFbpQK+iAxBxM12qaCjqZ
         4Jzc4FkEM9+gUlYZLm9RFom9J5h8E8oAwv3PCi6Ink6oENnWHIGHClUjh3+XkMWmocgR
         xfIG+6hVW/L9Biygr0bSn1hwS91QBMlbDVGTAIokJVJerMXDak2AkCOQCT//PJqE0R+W
         thnzc1Xq/+GU7e1FUPEj3J9I/k2qECsuIXrWjCIYYp5MNcUwzzGhHxWOHIxIu/Cn3KnL
         jnkg==
X-Gm-Message-State: AFuF++nKdM6gRKsU0EH4bFCAI2KpnYAuTLyB5E40PrWZ49yYte34/5tL
	aSVIcDnxnEf3IjcXsSeEhxHypjpTmDMidyitUyVbMwNPjtML4nKWJa1R4Y1H5yfEgHDcF3KM0eN
	Xd/PX
X-Gm-Gg: AR+sD11YC8lG2kH+JH/G9QEZBduPPB0pZSd+pMxm6jqgBMS/Pvrb8+Q+1xmUH727q+L
	NuqCn5iXFxlmUhnuh6LBlwuAy0xgIBmt66MzYis1vRm9fKc6DzMF7bEEylvbm9dt+iubGc8Auxf
	1794XYSXAaKERQmsQBHYua9tMMQTt7If2wRNqPdANqMS8iQgUZxiqBicUhJTna+b866eqG1Dkb8
	T5ACT4rSl8KiK0VrILH5wZCSfFV+VprEO/uAoW05OmB6Pz8A4pCfDzZZloe5NMMmU9JVAKh5L4U
	qqKU3sw7WcdSEgmkUi5AtKaJ8wIY6PtDmYlXJbHMUWm2a/cEV6TahYIrLbRmOIcIzKItk5E7zF8
	EDCI+dU6iN0XHFHNsvP6+DVVKu7kec7loTnpItRnEj59KjnV4XC89GYKQF3H1/OnfH9pUs3AIBK
	8G4sqdTwBGPY7X0W7rVC3olYGaTssXggR6sQfqj28r7W5nST5WpWusM3bpnl1hWmyeONfFWmDum
	oXC2lGfdtEE6ZHYExOwcW+3czsqgl9Dd01AOGqK02XESsrhIDn94+ZdRd/g1y/Axs/jf7mWdxDs
	FZuLV404jthxpPlnnK85hiZMcg==
X-Received: by 2002:ad4:5f0c:0:b0:90c:5a71:f857 with SMTP id 6a1803df08f44-90cc79af7ecmr106082636d6.14.1787777924182;
        Wed, 26 Aug 2026 13:58:44 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093d5sm35135856d6.26.2026.08.26.13.58.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:58:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 01/15] aide: Fix compilation with nettle 4.x
Date: Wed, 26 Aug 2026 16:57:35 -0400
Message-ID: <c4c37c0074b7edf99adbce02c250b6140a6e71f0.1787777775.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787777775.git.scott.murray@konsulko.com>
References: <cover.1787777775.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 20:58:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4693

Backport unreleased change from upstream to handle building with nettle
4.x now that openembedded-core has upgraded to it.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../0002-Support-build-with-nettle-4.patch    | 53 +++++++++++++++++++
 recipes-ids/aide/aide_0.19.3.bb               |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch

diff --git a/recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch b/recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch
new file mode 100644
index 0000000..d9c6fad
--- /dev/null
+++ b/recipes-ids/aide/aide/0002-Support-build-with-nettle-4.patch
@@ -0,0 +1,53 @@
+From 84936cec8ddb7151327563800d752d1d20e39224 Mon Sep 17 00:00:00 2001
+From: Hannes von Haugwitz <hannes@vonhaugwitz.com>
+Date: Tue, 26 May 2026 21:41:52 +0200
+Subject: [PATCH] Support build with nettle 4
+
+* closes: #218
+
+Upstream-Status: Backport [https://github.com/aide/aide/commit/61130addb02a58d7de95d6b8f344ab9b6151d6aa]
+Signed-off-by: Scott Murray <scott.murray@konsulko.com>
+---
+ ChangeLog | 3 +++
+ src/md.c  | 6 ++++++
+ 2 files changed, 9 insertions(+)
+
+diff --git a/ChangeLog b/ChangeLog
+index 89905e3..5b3963e 100644
+--- a/ChangeLog
++++ b/ChangeLog
+@@ -1,3 +1,6 @@
++2026-05-26 Hannes von Haugwitz <hannes@vonhaugwitz.com>
++	* Support build with nettle 4 (closes: #218)
++
+ 2026-01-31 Hannes von Haugwitz <hannes@vonhaugwitz.com>
+ 	* Release aide 0.19.3
+ 
+diff --git a/src/md.c b/src/md.c
+index e4e66ad..1aec9d9 100644
+--- a/src/md.c
++++ b/src/md.c
+@@ -47,6 +47,8 @@
+ #include <nettle/gosthash94.h>
+ #include <nettle/streebog.h>
+ 
++#include <nettle/version.h>
++
+ typedef struct {
+   nettle_hash_init_func *init;
+   nettle_hash_update_func *update;
+@@ -166,7 +168,11 @@ int close_md(struct md_container* md, md_hashsums * hs, const char *filename, co
+         for (HASHSUM i = 0 ; i < num_hashes ; ++i) {
+             DB_ATTR_TYPE h = ATTR(hashsums[i].attribute);
+             if (h&md->calc_attr) {
++#if NETTLE_VERSION_MAJOR < 4
+                 nettle_functions[i].digest(&md->ctx[i].md5, hashsums[i].length, hs->hashsums[i]);
++#else
++                nettle_functions[i].digest(&md->ctx[i].md5, hs->hashsums[i]);
++#endif
+             }
+         }
+ #endif
+-- 
+2.47.3
+
diff --git a/recipes-ids/aide/aide_0.19.3.bb b/recipes-ids/aide/aide_0.19.3.bb
index 68e3bfa..8d4efbb 100644
--- a/recipes-ids/aide/aide_0.19.3.bb
+++ b/recipes-ids/aide/aide_0.19.3.bb
@@ -7,6 +7,7 @@ DEPENDS = "bison-native libpcre2"
 
 SRC_URI = "https://github.com/aide/aide/releases/download/v${PV}/${BPN}-${PV}.tar.gz \
            file://0001-Fixes-build-issues.patch \
+           file://0002-Support-build-with-nettle-4.patch \
            file://aide.conf \
 "
 
-- 
2.55.0


