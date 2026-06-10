Return-Path: <mail2szahir@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13706CD8CB9
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 09:16:22 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16125.1781082974604375407
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 10 Jun 2026 02:16:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TZDYSDlN;
 spf=pass (domain: gmail.com, ip: 209.85.216.49, mailfrom: mail2szahir@gmail.com)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36d6bb38b44so4277210a91.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082974; x=1781687774; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuLY2KqJ9M+wGi/VDewz79XVesqeef8rZDVRjnaJMtI=;
        b=TZDYSDlNsIeYuw04xqD8VhyRwErjGBnTThHWSiUtnd6Pfu7JPl4q2mfm8rxFmqNhB4
         Qhr6aCXh4DcqeOwYvqUMYqckoRbwwjmkgfiK+0fLZm8SI0Jdnv4z+PzUzvEG//QeNjuh
         PKKsYHOkD56K6DMlqKSB/IvOcMWzW+J/S/qprRyRNPju9qe0hDyWPDpkKaYf2oWLBp37
         wDnvdOayRb1GDT4f7BjfQyyta2+OpTpjWQK6ORzdTNWnpeIRtANREE9Z82Xp1IdCM6rN
         0j1Y6MRartjji2esV9dlJcBrMkBsCdwU2agJlE2b2rlxvXSggtKGxp/59+0TvxWTU1Ag
         8e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082974; x=1781687774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuLY2KqJ9M+wGi/VDewz79XVesqeef8rZDVRjnaJMtI=;
        b=bQTDFm2qF3z0zqKaH30nYTkdDVZ7jiYUdv79cG1UbQYqLBRca3aS7/fvOq8CnutMjT
         lE1XbDFDKBgbZoRPii0eRCw5RTZd+IVM8lR/3irqci39jvC2tR3f19u/yDGlysXlsTvm
         aajXDorwVwp9z7JDKP9ndjuxUDe9ClO7Uklgttm8hoqu4YtwSu0hK0dLKqOl1I2/Vs41
         tIsEHBgzFI7v055+cS9GEmaasCNboFLOSaPuhvtNuudjPo74ckYKRW8i8MGa+KVfViUn
         EWhS9+amNLUNHpZ85D3VrSlnEmAtqRDXJCKhYEKiV7+qmsAralX4daRXb7nQOVPSMOOb
         rhbw==
X-Gm-Message-State: AOJu0YztouDprBK0Y4D5ZmgILnazlDiVIWtKwBWa/G14dUtCgOtfKMvI
	4XtWZSw3a4gQWrxTsJr5TyxfGpRKzVN6wlueeSHhgNM/Q15JsuS01JNFF2tYzg==
X-Gm-Gg: Acq92OF1A1WyWafIDmN7jpg2JN+AO0hjiXjv3c928XP8DSKIGnWXXcdfRBM1ef0Gk9U
	FgN3z/HKZPwuhmDFDsCSitdkQSp9tKfjCNP4piw6n3AJY9cO77WId8phdPvYXzDAWgDs/GqeEmQ
	/ZoCr3X7dLlUbX0wQIc1IAC3Ni72uy2Tr/KuWFUxOqFxkctz7KU9FNdSq7ylEGYZ2hiyK2KF7Rg
	UU5oiDUjGUlTUmAGUMH/56rcneke/AepYBa0ahiR0z3EpCPZwqMrQBwm3SX1lb3rFnYHHrBK0K9
	hZSKBs0D54xzyAkzpFDfIHBzFwMgLiIcwzhnF3x3RdNjiI+HlBxPGpRVkIggGINECHLmebYFwyN
	EL9eFXgeG3nNprWk95ExDR0sF+ICcVMiXURcxIVNRgn2pdIbdysYoqhG+mXeYLkHH+417KUjH5S
	JD3gPwTyKJwM5eCeGYFLz2RzMaCg8W/0HANpTdnWcV
X-Received: by 2002:a17:90a:d44f:b0:369:69f8:ad6b with SMTP id 98e67ed59e1d1-370ec3d60cemr27547441a91.0.1781082972678;
        Wed, 10 Jun 2026 02:16:12 -0700 (PDT)
Received: from L-17367L.kpit.com ([49.47.218.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37621b3e10bsm2055324a91.8.2026.06.10.02.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:16:12 -0700 (PDT)
From: Zahir Hussain <mail2szahir@gmail.com>
X-Google-Original-From: Zahir Hussain <zahir.basha@kpit.com>
To: yocto-patches@lists.yoctoproject.org,
	zahir.basha@kpit.com
Cc: mail2szahir@gmail.com
Subject: [meta-lts-collab][kirkstone][PATCH] expat: fix CVE-2025-59735
Date: Wed, 10 Jun 2026 14:44:31 +0530
Message-Id: <20260610091431.2270358-1-zahir.basha@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Jun 2026 09:16:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4191

Backport upstream commits:
https://github.com/libexpat/libexpat/commit/0872c189db6e457084fca335662a9cb49e8ec4c7
https://github.com/libexpat/libexpat/commit/8768dadae479d9f2e984b747fb2ba79bb78de94f
https://github.com/libexpat/libexpat/commit/4fc6f1ee9f2b282cfe446bf645c992e37f8c3e15
https://github.com/libexpat/libexpat/commit/51487ad9d760faa4809b0f8e189d2f666317e41a
https://github.com/libexpat/libexpat/commit/4e7a5d03daf672f20c73d40dc8970385c18b30d3
https://github.com/libexpat/libexpat/commit/53a3eda0ae2e0317afd071b72b41976053d82732
https://github.com/libexpat/libexpat/commit/b3f0bda5f5e979781469532f7c304f7e223568d5
https://github.com/libexpat/libexpat/commit/1270e5bc0836d296ac4970fc9e1cf53d83972083
https://github.com/libexpat/libexpat/commit/cfce28e171676fe6f70d17b97ed8a59eaeb83f15
https://github.com/libexpat/libexpat/commit/7e35240dc97e9fd4f609e31f27c27b659535e436
https://github.com/libexpat/libexpat/commit/ae4086198d710a62a0a1560007b81307dba72909
https://github.com/libexpat/libexpat/commit/96c7467281c72028aada525c1d3822512758b266
https://github.com/libexpat/libexpat/commit/78366891a586f293aeff60a14a55e4afe1169586
https://github.com/libexpat/libexpat/commit/31f9053c3c46741f4daf2ea2bdea75f40f720d42
https://github.com/libexpat/libexpat/commit/a6a2a49367f03f5d8a73c9027b45b59953ca27d8
https://github.com/libexpat/libexpat/commit/d6246c31a1238d065b4d9690d3bac740326f6485
https://github.com/libexpat/libexpat/commit/87321ac84a0d6cb42ee64a591adc79c1ec37fb5b

Follow-up changes:
https://github.com/libexpat/libexpat/commit/16412a8e99455bc7a3dc53a053e5f3ab351a92c8

These changes fix the following issue in Expat;
libexpat in Expat before 2.7.2 allows attackers to trigger large dynamic
memory allocations via a small document that is submitted for parsing.

All the patches are refershed according to expat 2.5.0 code base.

Below patches are not taken as it is not part the code base and useless to CVE fix
https://github.com/libexpat/libexpat/commit/20b4c2ee4554e3f261c2fe93fe5759a7e66c17a4
https://github.com/libexpat/libexpat/commit/5ae51be57ed0ca1e87582881d07ea9c29c4f7c05
https://github.com/libexpat/libexpat/commit/a21a3a8299e1ee0b0ae5ae2886a0746d088cf135

Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
---
 .../expat/expat/CVE-2025-59375-01.patch       |  49 ++
 .../expat/expat/CVE-2025-59375-02.patch       | 110 ++++
 .../expat/expat/CVE-2025-59375-03.patch       | 128 +++++
 .../expat/expat/CVE-2025-59375-04.patch       |  63 +++
 .../expat/expat/CVE-2025-59375-05.patch       |  53 ++
 .../expat/expat/CVE-2025-59375-06.patch       |  69 +++
 .../expat/expat/CVE-2025-59375-07.patch       |  65 +++
 .../expat/expat/CVE-2025-59375-08.patch       |  44 ++
 .../expat/expat/CVE-2025-59375-09.patch       | 510 ++++++++++++++++++
 .../expat/expat/CVE-2025-59375-10.patch       |  59 ++
 .../expat/expat/CVE-2025-59375-11.patch       |  67 +++
 .../expat/expat/CVE-2025-59375-12.patch       |  55 ++
 .../expat/expat/CVE-2025-59375-13.patch       | 121 +++++
 .../expat/expat/CVE-2025-59375-14.patch       |  71 +++
 .../expat/expat/CVE-2025-59375-15.patch       |  29 +
 .../expat/expat/CVE-2025-59375-16.patch       | 146 +++++
 .../expat/expat/CVE-2025-59375-17.patch       |  34 ++
 .../expat/expat/CVE-2025-59375-18.patch       | 156 ++++++
 .../expat/expat/CVE-2025-59375-19.patch       |  51 ++
 meta-core/recipes-core/expat/expat_%.bbappend |  24 +
 20 files changed, 1904 insertions(+)
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-01.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-02.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-03.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-04.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-05.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-06.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-07.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-08.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-09.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-10.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-11.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-12.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-13.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-14.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-15.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-16.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-17.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-18.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2025-59375-19.patch
 create mode 100644 meta-core/recipes-core/expat/expat_%.bbappend

diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-01.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-01.patch
new file mode 100644
index 0000000..bc0ef49
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-01.patch
@@ -0,0 +1,49 @@
+From 0872c189db6e457084fca335662a9cb49e8ec4c7 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Mon, 1 Sep 2025 18:06:59 +0200
+Subject: [PATCH] lib: Make function dtdCreate use macro MALLOC
+
+.. and give its body access to the parser for upcoming changes
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/0872c189db6e457084fca335662a9cb49e8ec4c7]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 25f786ec8..b9d6eed17 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -555,7 +555,7 @@ static XML_Bool setContext(XML_Parser parser, const XML_Char *context);
+ 
+ static void FASTCALL normalizePublicId(XML_Char *s);
+ 
+-static DTD *dtdCreate(const XML_Memory_Handling_Suite *ms);
++static DTD *dtdCreate(XML_Parser parser);
+ /* do not call if m_parentParser != NULL */
+ static void dtdReset(DTD *p, const XML_Memory_Handling_Suite *ms);
+ static void dtdDestroy(DTD *p, XML_Bool isDocEntity,
+@@ -1170,7 +1170,7 @@ parserCreate(const XML_Char *encodingName,
+   if (dtd)
+     parser->m_dtd = dtd;
+   else {
+-    parser->m_dtd = dtdCreate(&parser->m_mem);
++    parser->m_dtd = dtdCreate(parser);
+     if (parser->m_dtd == NULL) {
+       FREE(parser, parser->m_dataBuf);
+       FREE(parser, parser->m_atts);
+@@ -7128,8 +7128,9 @@ normalizePublicId(XML_Char *publicId) {
+ }
+ 
+ static DTD *
+-dtdCreate(const XML_Memory_Handling_Suite *ms) {
+-  DTD *p = ms->malloc_fcn(sizeof(DTD));
++dtdCreate(XML_Parser parser) {
++  const XML_Memory_Handling_Suite *const ms = &parser->m_mem;
++  DTD *p = MALLOC(parser, sizeof(DTD));
+   if (p == NULL)
+     return p;
+   poolInit(&(p->pool), ms);
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-02.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-02.patch
new file mode 100644
index 0000000..7cd8772
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-02.patch
@@ -0,0 +1,110 @@
+From 8768dadae479d9f2e984b747fb2ba79bb78de94f Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Mon, 1 Sep 2025 18:10:26 +0200
+Subject: [PATCH] lib: Make string pools use macros MALLOC, FREE, REALLOC
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/8768dadae479d9f2e984b747fb2ba79bb78de94f]
+
+CVE: CVE-2025-59375
+
+comment: refresh the patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index b9d6eed17..a56c71eaa 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -357,7 +357,7 @@ typedef struct {
+   const XML_Char *end;
+   XML_Char *ptr;
+   XML_Char *start;
+-  const XML_Memory_Handling_Suite *mem;
++  XML_Parser parser;
+ } STRING_POOL;
+ 
+ /* The XML_Char before the name is used to determine whether
+@@ -541,8 +541,7 @@ static void FASTCALL hashTableDestroy(HA
+ static void FASTCALL hashTableIterInit(HASH_TABLE_ITER *, const HASH_TABLE *);
+ static NAMED *FASTCALL hashTableIterNext(HASH_TABLE_ITER *);
+ 
+-static void FASTCALL poolInit(STRING_POOL *,
+-                              const XML_Memory_Handling_Suite *ms);
++static void FASTCALL poolInit(STRING_POOL *pool, XML_Parser parser);
+ static void FASTCALL poolClear(STRING_POOL *);
+ static void FASTCALL poolDestroy(STRING_POOL *);
+ static XML_Char *poolAppend(STRING_POOL *pool, const ENCODING *enc,
+@@ -1123,8 +1384,8 @@ parserCreate(const XML_Char *encodingName,
+
+   parser->m_protocolEncodingName = NULL;
+
+-  poolInit(&parser->m_tempPool, &(parser->m_mem));
+-  poolInit(&parser->m_temp2Pool, &(parser->m_mem));
++  poolInit(&parser->m_tempPool, parser);
++  poolInit(&parser->m_temp2Pool, parser);
+   parserInit(parser, encodingName);
+
+   if (encodingName && ! parser->m_protocolEncodingName) {
+@@ -7133,8 +7132,8 @@ dtdCreate(XML_Parser parser) {
+   DTD *p = MALLOC(parser, sizeof(DTD));
+   if (p == NULL)
+     return p;
+-  poolInit(&(p->pool), ms);
+-  poolInit(&(p->entityValuePool), ms);
++  poolInit(&(p->pool), parser);
++  poolInit(&(p->entityValuePool), parser);
+   hashTableInit(&(p->generalEntities), ms);
+   hashTableInit(&(p->elementTypes), ms);
+   hashTableInit(&(p->attributeIds), ms);
+@@ -7598,13 +7597,13 @@ hashTableIterNext(HASH_TABLE_ITER *iter) {
+ }
+ 
+ static void FASTCALL
+-poolInit(STRING_POOL *pool, const XML_Memory_Handling_Suite *ms) {
++poolInit(STRING_POOL *pool, XML_Parser parser) {
+   pool->blocks = NULL;
+   pool->freeBlocks = NULL;
+   pool->start = NULL;
+   pool->ptr = NULL;
+   pool->end = NULL;
+-  pool->mem = ms;
++  pool->parser = parser;
+ }
+ 
+ static void FASTCALL
+@@ -7631,13 +7630,13 @@ poolDestroy(STRING_POOL *pool) {
+   BLOCK *p = pool->blocks;
+   while (p) {
+     BLOCK *tem = p->next;
+-    pool->mem->free_fcn(p);
++    FREE(pool->parser, p);
+     p = tem;
+   }
+   p = pool->freeBlocks;
+   while (p) {
+     BLOCK *tem = p->next;
+-    pool->mem->free_fcn(p);
++    FREE(pool->parser, p);
+     p = tem;
+   }
+ }
+@@ -7792,8 +7791,8 @@ poolGrow(STRING_POOL *pool) {
+     if (bytesToAllocate == 0)
+       return XML_FALSE;
+ 
+-    temp = (BLOCK *)pool->mem->realloc_fcn(pool->blocks,
+-                                           (unsigned)bytesToAllocate);
++    temp = (BLOCK *)REALLOC(pool->parser, pool->blocks,
++                            (unsigned)bytesToAllocate);
+     if (temp == NULL)
+       return XML_FALSE;
+     pool->blocks = temp;
+@@ -7833,7 +7832,7 @@ poolGrow(STRING_POOL *pool) {
+     if (bytesToAllocate == 0)
+       return XML_FALSE;
+ 
+-    tem = pool->mem->malloc_fcn(bytesToAllocate);
++    tem = MALLOC(pool->parser, bytesToAllocate);
+     if (! tem)
+       return XML_FALSE;
+     tem->size = blockSize;
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-03.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-03.patch
new file mode 100644
index 0000000..3b217ea
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-03.patch
@@ -0,0 +1,128 @@
+From 4fc6f1ee9f2b282cfe446bf645c992e37f8c3e15 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Mon, 1 Sep 2025 18:14:09 +0200
+Subject: [PATCH] lib: Make function hash tables use macros MALLOC and FREE
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/4fc6f1ee9f2b282cfe446bf645c992e37f8c3e15]
+
+CVE: CVE-2025-59375
+
+comment: refresh the patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index a56c71eaa..a65b02651 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -234,7 +234,7 @@ typedef struct {
+   unsigned char power;
+   size_t size;
+   size_t used;
+-  const XML_Memory_Handling_Suite *mem;
++  XML_Parser parser;
+ } HASH_TABLE;
+ 
+ static size_t keylen(KEY s);
+@@ -534,8 +534,7 @@ static int copyEntityTable(XML_Parser ol
+                            const HASH_TABLE *);
+ static NAMED *lookup(XML_Parser parser, HASH_TABLE *table, KEY name,
+                      size_t createSize);
+-static void FASTCALL hashTableInit(HASH_TABLE *,
+-                                   const XML_Memory_Handling_Suite *ms);
++static void FASTCALL hashTableInit(HASH_TABLE *table, XML_Parser parser);
+ static void FASTCALL hashTableClear(HASH_TABLE *);
+ static void FASTCALL hashTableDestroy(HASH_TABLE *);
+ static void FASTCALL hashTableIterInit(HASH_TABLE_ITER *, const HASH_TABLE *);
+@@ -7128,19 +7127,18 @@ normalizePublicId(XML_Char *publicId) {
+ 
+ static DTD *
+ dtdCreate(XML_Parser parser) {
+-  const XML_Memory_Handling_Suite *const ms = &parser->m_mem;
+   DTD *p = MALLOC(parser, sizeof(DTD));
+   if (p == NULL)
+     return p;
+   poolInit(&(p->pool), parser);
+   poolInit(&(p->entityValuePool), parser);
+-  hashTableInit(&(p->generalEntities), ms);
+-  hashTableInit(&(p->elementTypes), ms);
+-  hashTableInit(&(p->attributeIds), ms);
+-  hashTableInit(&(p->prefixes), ms);
++  hashTableInit(&(p->generalEntities), parser);
++  hashTableInit(&(p->elementTypes), parser);
++  hashTableInit(&(p->attributeIds), parser);
++  hashTableInit(&(p->prefixes), parser);
+ #ifdef XML_DTD
+   p->paramEntityRead = XML_FALSE;
+-  hashTableInit(&(p->paramEntities), ms);
++  hashTableInit(&(p->paramEntities), parser);
+ #endif /* XML_DTD */
+   p->defaultPrefix.name = NULL;
+   p->defaultPrefix.binding = NULL;
+@@ -7475,7 +7473,7 @@ lookup(XML_Parser parser, HASH_TABLE *table, KEY name, size_t createSize) {
+     /* table->size is a power of 2 */
+     table->size = (size_t)1 << INIT_POWER;
+     tsize = table->size * sizeof(NAMED *);
+-    table->v = table->mem->malloc_fcn(tsize);
++    table->v = MALLOC(table->parser, tsize);
+     if (! table->v) {
+       table->size = 0;
+       return NULL;
+@@ -7515,7 +7513,7 @@ lookup(XML_Parser parser, HASH_TABLE *table, KEY name, size_t createSize) {
+       }
+ 
+       size_t tsize = newSize * sizeof(NAMED *);
+-      NAMED **newV = table->mem->malloc_fcn(tsize);
++      NAMED **newV = MALLOC(table->parser, tsize);
+       if (! newV)
+         return NULL;
+       memset(newV, 0, tsize);
+@@ -7531,7 +7529,7 @@ lookup(XML_Parser parser, HASH_TABLE *table, KEY name, size_t createSize) {
+           }
+           newV[j] = table->v[i];
+         }
+-      table->mem->free_fcn(table->v);
++      FREE(table->parser, table->v);
+       table->v = newV;
+       table->power = newPower;
+       table->size = newSize;
+@@ -7544,7 +7542,7 @@ lookup(XML_Parser parser, HASH_TABLE *table, KEY name, size_t createSize) {
+       }
+     }
+   }
+-  table->v[i] = table->mem->malloc_fcn(createSize);
++  table->v[i] = MALLOC(table->parser, createSize);
+   if (! table->v[i])
+     return NULL;
+   memset(table->v[i], 0, createSize);
+@@ -7557,7 +7555,7 @@ static void FASTCALL
+ hashTableClear(HASH_TABLE *table) {
+   size_t i;
+   for (i = 0; i < table->size; i++) {
+-    table->mem->free_fcn(table->v[i]);
++    FREE(table->parser, table->v[i]);
+     table->v[i] = NULL;
+   }
+   table->used = 0;
+@@ -7567,17 +7565,17 @@ static void FASTCALL
+ hashTableDestroy(HASH_TABLE *table) {
+   size_t i;
+   for (i = 0; i < table->size; i++)
+-    table->mem->free_fcn(table->v[i]);
+-  table->mem->free_fcn(table->v);
++    FREE(table->parser, table->v[i]);
++  FREE(table->parser, table->v);
+ }
+ 
+ static void FASTCALL
+-hashTableInit(HASH_TABLE *p, const XML_Memory_Handling_Suite *ms) {
++hashTableInit(HASH_TABLE *p, XML_Parser parser) {
+   p->power = 0;
+   p->size = 0;
+   p->used = 0;
+   p->v = NULL;
+-  p->mem = ms;
++  p->parser = parser;
+ }
+ 
+ static void FASTCALL
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-04.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-04.patch
new file mode 100644
index 0000000..c7111fb
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-04.patch
@@ -0,0 +1,63 @@
+From 51487ad9d760faa4809b0f8e189d2f666317e41a Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Mon, 1 Sep 2025 17:45:50 +0200
+Subject: [PATCH] lib: Make function copyString use macro MALLOC
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/51487ad9d760faa4809b0f8e189d2f666317e41a]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index a65b02651..c0576abd7 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -593,8 +593,7 @@ static XML_Content *build_model(XML_Parser parser);
+ static ELEMENT_TYPE *getElementType(XML_Parser parser, const ENCODING *enc,
+                                     const char *ptr, const char *end);
+ 
+-static XML_Char *copyString(const XML_Char *s,
+-                            const XML_Memory_Handling_Suite *memsuite);
++static XML_Char *copyString(const XML_Char *s, XML_Parser parser);
+ 
+ static unsigned long generate_hash_secret_salt(XML_Parser parser);
+ static XML_Bool startParsing(XML_Parser parser);
+@@ -1235,7 +1234,7 @@ parserInit(XML_Parser parser, const XML_Char *encodingName) {
+   parser->m_processor = prologInitProcessor;
+   XmlPrologStateInit(&parser->m_prologState);
+   if (encodingName != NULL) {
+-    parser->m_protocolEncodingName = copyString(encodingName, &(parser->m_mem));
++    parser->m_protocolEncodingName = copyString(encodingName, parser);
+   }
+   parser->m_curBase = NULL;
+   XmlInitEncoding(&parser->m_initEncoding, &parser->m_encoding, 0);
+@@ -1423,7 +1422,7 @@ XML_SetEncoding(XML_Parser parser, const XML_Char *encodingName) {
+     parser->m_protocolEncodingName = NULL;
+   else {
+     /* Copy the new encoding name into allocated memory */
+-    parser->m_protocolEncodingName = copyString(encodingName, &(parser->m_mem));
++    parser->m_protocolEncodingName = copyString(encodingName, parser);
+     if (! parser->m_protocolEncodingName)
+       return XML_STATUS_ERROR;
+   }
+@@ -8071,7 +8070,7 @@ getElementType(XML_Parser parser, const ENCODING *enc, const char *ptr,
+ }
+ 
+ static XML_Char *
+-copyString(const XML_Char *s, const XML_Memory_Handling_Suite *memsuite) {
++copyString(const XML_Char *s, XML_Parser parser) {
+   size_t charsRequired = 0;
+   XML_Char *result;
+ 
+@@ -8083,7 +8082,7 @@ copyString(const XML_Char *s, const XML_Memory_Handling_Suite *memsuite) {
+   charsRequired++;
+ 
+   /* Now allocate space for the copy */
+-  result = memsuite->malloc_fcn(charsRequired * sizeof(XML_Char));
++  result = MALLOC(parser, charsRequired * sizeof(XML_Char));
+   if (result == NULL)
+     return NULL;
+   /* Copy the original into place */
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-05.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-05.patch
new file mode 100644
index 0000000..5573bab
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-05.patch
@@ -0,0 +1,53 @@
+From 4e7a5d03daf672f20c73d40dc8970385c18b30d3 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Mon, 1 Sep 2025 17:52:58 +0200
+Subject: [PATCH] lib: Make function dtdCopy use macro MALLOC
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/4e7a5d03daf672f20c73d40dc8970385c18b30d3]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index e7df97dae..9f0a8b3ee 100644
+--- a//lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -529,7 +529,7 @@ static void dtdReset(DTD *p, const XML_M
+ static void dtdDestroy(DTD *p, XML_Bool isDocEntity,
+                        const XML_Memory_Handling_Suite *ms);
+ static int dtdCopy(XML_Parser oldParser, DTD *newDtd, const DTD *oldDtd,
+-                   const XML_Memory_Handling_Suite *ms);
++                   XML_Parser parser);
+ static int copyEntityTable(XML_Parser oldParser, HASH_TABLE *, STRING_POOL *,
+                            const HASH_TABLE *);
+ static NAMED *lookup(XML_Parser parser, HASH_TABLE *table, KEY name,
+@@ -1576,7 +1576,7 @@ XML_ExternalEntityParserCreate(XML_Parser oldParser, const XML_Char *context,
+   parser->m_prologState.inEntityValue = oldInEntityValue;
+   if (context) {
+ #endif /* XML_DTD */
+-    if (! dtdCopy(oldParser, parser->m_dtd, oldDtd, &parser->m_mem)
++    if (! dtdCopy(oldParser, parser->m_dtd, oldDtd, parser)
+         || ! setContext(parser, context)) {
+       XML_ParserFree(parser);
+       return NULL;
+@@ -7227,7 +7227,7 @@ dtdDestroy(DTD *p, XML_Bool isDocEntity, XML_Parser parser) {
+ */
+ static int
+ dtdCopy(XML_Parser oldParser, DTD *newDtd, const DTD *oldDtd,
+-        const XML_Memory_Handling_Suite *ms) {
++        XML_Parser parser) {
+   HASH_TABLE_ITER iter;
+ 
+   /* Copy the prefix table. */
+@@ -7308,7 +7308,7 @@ dtdCopy(XML_Parser oldParser, DTD *newDtd, const DTD *oldDtd,
+       }
+ #endif
+       newE->defaultAtts
+-          = ms->malloc_fcn(oldE->nDefaultAtts * sizeof(DEFAULT_ATTRIBUTE));
++          = MALLOC(parser, oldE->nDefaultAtts * sizeof(DEFAULT_ATTRIBUTE));
+       if (! newE->defaultAtts) {
+         return 0;
+       }
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-06.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-06.patch
new file mode 100644
index 0000000..d4cfd69
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-06.patch
@@ -0,0 +1,69 @@
+From 53a3eda0ae2e0317afd071b72b41976053d82732 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Mon, 1 Sep 2025 17:50:59 +0200
+Subject: [PATCH] lib: Make function dtdDestroy use macro FREE
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/53a3eda0ae2e0317afd071b72b41976053d82732]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 65fcce301..e7df97dae 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -526,8 +526,7 @@ static void FASTCALL normalizePublicId(X
+ static DTD *dtdCreate(XML_Parser parser);
+ /* do not call if m_parentParser != NULL */
+ static void dtdReset(DTD *p, const XML_Memory_Handling_Suite *ms);
+-static void dtdDestroy(DTD *p, XML_Bool isDocEntity,
+-                       const XML_Memory_Handling_Suite *ms);
++static void dtdDestroy(DTD *p, XML_Bool isDocEntity, XML_Parser parser);
+ static int dtdCopy(XML_Parser oldParser, DTD *newDtd, const DTD *oldDtd,
+                    XML_Parser parser);
+ static int copyEntityTable(XML_Parser oldParser, HASH_TABLE *, STRING_POOL *,
+@@ -1689,8 +1688,7 @@ XML_ParserFree(XML_Parser parser) {
+ #else
+   if (parser->m_dtd)
+ #endif /* XML_DTD */
+-    dtdDestroy(parser->m_dtd, (XML_Bool)! parser->m_parentParser,
+-               &parser->m_mem);
++    dtdDestroy(parser->m_dtd, (XML_Bool)! parser->m_parentParser, parser);
+   FREE(parser, (void *)parser->m_atts);
+ #ifdef XML_ATTR_INFO
+   FREE(parser, (void *)parser->m_attInfo);
+@@ -7198,7 +7196,7 @@ dtdReset(DTD *p, XML_Parser parser) {
+ }
+ 
+ static void
+-dtdDestroy(DTD *p, XML_Bool isDocEntity, const XML_Memory_Handling_Suite *ms) {
++dtdDestroy(DTD *p, XML_Bool isDocEntity, XML_Parser parser) {
+   HASH_TABLE_ITER iter;
+   hashTableIterInit(&iter, &(p->elementTypes));
+   for (;;) {
+@@ -7206,7 +7204,7 @@ dtdDestroy(DTD *p, XML_Bool isDocEntity, const XML_Memory_Handling_Suite *ms) {
+     if (! e)
+       break;
+     if (e->allocDefaultAtts != 0)
+-      ms->free_fcn(e->defaultAtts);
++      FREE(parser, e->defaultAtts);
+   }
+   hashTableDestroy(&(p->generalEntities));
+ #ifdef XML_DTD
+@@ -7218,10 +7216,10 @@ dtdDestroy(DTD *p, XML_Bool isDocEntity, const XML_Memory_Handling_Suite *ms) {
+   poolDestroy(&(p->pool));
+   poolDestroy(&(p->entityValuePool));
+   if (isDocEntity) {
+-    ms->free_fcn(p->scaffIndex);
+-    ms->free_fcn(p->scaffold);
++    FREE(parser, p->scaffIndex);
++    FREE(parser, p->scaffold);
+   }
+-  ms->free_fcn(p);
++  FREE(parser, p);
+ }
+ 
+ /* Do a deep copy of the DTD. Return 0 for out of memory, non-zero otherwise.
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-07.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-07.patch
new file mode 100644
index 0000000..40b5735
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-07.patch
@@ -0,0 +1,65 @@
+From b3f0bda5f5e979781469532f7c304f7e223568d5 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Mon, 1 Sep 2025 17:48:02 +0200
+Subject: [PATCH] lib: Make function dtdReset use macro FREE
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/b3f0bda5f5e979781469532f7c304f7e223568d5]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index c0576abd7..65fcce301 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -534,7 +534,7 @@ static void FASTCALL normalizePublicId(X
+ 
+ static DTD *dtdCreate(XML_Parser parser);
+ /* do not call if m_parentParser != NULL */
+-static void dtdReset(DTD *p, const XML_Memory_Handling_Suite *ms);
++static void dtdReset(DTD *p, XML_Parser parser);
+ static void dtdDestroy(DTD *p, XML_Bool isDocEntity, XML_Parser parser);
+ static int dtdCopy(XML_Parser oldParser, DTD *newDtd, const DTD *oldDtd,
+                    XML_Parser parser);
+@@ -1386,7 +1386,7 @@ XML_ParserReset(XML_Parser parser, const XML_Char *encodingName) {
+   FREE(parser, (void *)parser->m_protocolEncodingName);
+   parser->m_protocolEncodingName = NULL;
+   parserInit(parser, encodingName);
+-  dtdReset(parser->m_dtd, &parser->m_mem);
++  dtdReset(parser->m_dtd, parser);
+   return XML_TRUE;
+ }
+ 
+@@ -7157,7 +7157,7 @@ dtdCreate(XML_Parser parser) {
+ }
+ 
+ static void
+-dtdReset(DTD *p, const XML_Memory_Handling_Suite *ms) {
++dtdReset(DTD *p, XML_Parser parser) {
+   HASH_TABLE_ITER iter;
+   hashTableIterInit(&iter, &(p->elementTypes));
+   for (;;) {
+@@ -7165,7 +7165,7 @@ dtdReset(DTD *p, const XML_Memory_Handling_Suite *ms) {
+     if (! e)
+       break;
+     if (e->allocDefaultAtts != 0)
+-      ms->free_fcn(e->defaultAtts);
++      FREE(parser, e->defaultAtts);
+   }
+   hashTableClear(&(p->generalEntities));
+ #ifdef XML_DTD
+@@ -7182,9 +7182,9 @@ dtdReset(DTD *p, const XML_Memory_Handling_Suite *ms) {
+ 
+   p->in_eldecl = XML_FALSE;
+ 
+-  ms->free_fcn(p->scaffIndex);
++  FREE(parser, p->scaffIndex);
+   p->scaffIndex = NULL;
+-  ms->free_fcn(p->scaffold);
++  FREE(parser, p->scaffold);
+   p->scaffold = NULL;
+ 
+   p->scaffLevel = 0;
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-08.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-08.patch
new file mode 100644
index 0000000..5d1f2da
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-08.patch
@@ -0,0 +1,44 @@
+From 1270e5bc0836d296ac4970fc9e1cf53d83972083 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Sun, 7 Sep 2025 12:18:08 +0200
+Subject: [PATCH] lib: Make XML_MemFree and XML_FreeContentModel match their
+ siblings
+
+.. XML_MemMalloc and XML_MemRealloc in structure, prior to upcoming changes
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/1270e5bc0836d296ac4970fc9e1cf53d83972083]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index fcf1cfddf..5d27cd451 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -2778,8 +2778,9 @@ XML_GetCurrentColumnNumber(XML_Parser parser) {
+ 
+ void XMLCALL
+ XML_FreeContentModel(XML_Parser parser, XML_Content *model) {
+-  if (parser != NULL)
+-    FREE(parser, model);
++  if (parser == NULL)
++    return;
++  FREE(parser, model);
+ }
+ 
+ void *XMLCALL
+@@ -2798,8 +2799,9 @@ XML_MemRealloc(XML_Parser parser, void *ptr, size_t size) {
+ 
+ void XMLCALL
+ XML_MemFree(XML_Parser parser, void *ptr) {
+-  if (parser != NULL)
+-    FREE(parser, ptr);
++  if (parser == NULL)
++    return;
++  FREE(parser, ptr);
+ }
+ 
+ void XMLCALL
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-09.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-09.patch
new file mode 100644
index 0000000..13c5d7e
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-09.patch
@@ -0,0 +1,510 @@
+From cfce28e171676fe6f70d17b97ed8a59eaeb83f15 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Mon, 1 Sep 2025 17:34:58 +0200
+Subject: [PATCH] lib: Implement tracking of dynamic memory allocations
+
+**PLEASE NOTE** that distributors intending to backport (or cherry-pick)
+this fix need to copy 99% of the related pull request, not just this
+commit, to not end up with a state that literally does both too much and
+too little at the same time. Appending ".diff" to the pull request URL
+could be of help.
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/cfce28e171676fe6f70d17b97ed8a59eaeb83f15]
+
+CVE: CVE-2025-59375
+
+comment: refreshed the patch to match the source code and removed the 
+test folder (not present in our source). I also moved the changes for
+xmlwf.c and xmlwf_helpgen.py into a separate patch, as they were incompatible
+with the Expat 2.5.0 codebase.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/expat.h b/lib/expat.h
+index 610e1ddc0..66a253c15 100644
+--- a/lib/expat.h
++++ b/lib/expat.h
+@@ -1032,7 +1032,10 @@ enum XML_FeatureEnum {
+   XML_FEATURE_BILLION_LAUGHS_ATTACK_PROTECTION_MAXIMUM_AMPLIFICATION_DEFAULT,
+   XML_FEATURE_BILLION_LAUGHS_ATTACK_PROTECTION_ACTIVATION_THRESHOLD_DEFAULT,
+   /* Added in Expat 2.6.0. */
+-  XML_FEATURE_GE
++  XML_FEATURE_GE,
++  /* Added in Expat 2.7.2. */
++  XML_FEATURE_ALLOC_TRACKER_MAXIMUM_AMPLIFICATION_DEFAULT,
++  XML_FEATURE_ALLOC_TRACKER_ACTIVATION_THRESHOLD_DEFAULT,
+   /* Additional features must be added to the end of this enum. */
+ };
+
+@@ -1057,6 +1057,16 @@ XML_SetBillionLaughsAttackProtectionMaxi
+ XMLPARSEAPI(XML_Bool)
+ XML_SetBillionLaughsAttackProtectionActivationThreshold(
+     XML_Parser parser, unsigned long long activationThresholdBytes);
++
++/* Added in Expat 2.7.2. */
++XMLPARSEAPI(XML_Bool)
++XML_SetAllocTrackerMaximumAmplification(XML_Parser parser,
++                                        float maximumAmplificationFactor);
++
++/* Added in Expat 2.7.2. */
++XMLPARSEAPI(XML_Bool)
++XML_SetAllocTrackerActivationThreshold(
++    XML_Parser parser, unsigned long long activationThresholdBytes);
+ #endif
+
+ /* Expat follows the semantic versioning convention.
+diff --git a/lib/internal.h b/lib/internal.h
+index 6bde6ae6b..eb67cf50c 100644
+--- a/lib/internal.h
++++ b/lib/internal.h
+@@ -148,6 +148,11 @@
+   100.0f
+ #define EXPAT_BILLION_LAUGHS_ATTACK_PROTECTION_ACTIVATION_THRESHOLD_DEFAULT    \
+   8388608 // 8 MiB, 2^23
++
++#define EXPAT_ALLOC_TRACKER_MAXIMUM_AMPLIFICATION_DEFAULT 100.0f
++#define EXPAT_ALLOC_TRACKER_ACTIVATION_THRESHOLD_DEFAULT                       \
++  67108864 // 64 MiB, 2^26
++
+ /* NOTE END */
+ 
+ #include "expat.h" // so we can use type XML_Parser below
+diff --git a/lib/libexpat.def.cmake b/lib/libexpat.def.cmake
+index 10ee9cd6f..7a3a7ec0d 100644
+--- a/lib/libexpat.def.cmake
++++ b/lib/libexpat.def.cmake
+@@ -79,1 +79,4 @@ EXPORTS
+ @_EXPAT_COMMENT_DTD_OR_GE@ XML_SetBillionLaughsAttackProtectionMaximumAmplification @70
++; added with version 2.7.2
++@_EXPAT_COMMENT_DTD_OR_GE@ XML_SetAllocTrackerMaximumAmplification @72
++@_EXPAT_COMMENT_DTD_OR_GE@ XML_SetAllocTrackerActivationThreshold @73
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 9f0a8b3ee..fcf1cfddf 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -452,6 +452,14 @@ typedef struct accounting {
+   unsigned long long activationThresholdBytes;
+ } ACCOUNTING;
+ 
++typedef struct MALLOC_TRACKER {
++  XmlBigCount bytesAllocated;
++  XmlBigCount peakBytesAllocated; // updated live only for debug level >=2
++  unsigned long debugLevel;
++  float maximumAmplificationFactor; // >=1.0
++  XmlBigCount activationThresholdBytes;
++} MALLOC_TRACKER;
++
+ typedef struct entity_stats {
+   unsigned int countEverOpened;
+   unsigned int currentDepth;
+@@ -599,7 +607,8 @@ static XML_Bool startParsing(XML_Parser parser);
+ 
+ static XML_Parser parserCreate(const XML_Char *encodingName,
+                                const XML_Memory_Handling_Suite *memsuite,
+-                               const XML_Char *nameSep, DTD *dtd);
++                               const XML_Char *nameSep, DTD *dtd,
++                               XML_Parser parentParser);
+ 
+ static void parserInit(XML_Parser parser, const XML_Char *encodingName);
+
+@@ -722,13 +722,219 @@ struct XML_ParserStruct {
+   unsigned long m_hash_secret_salt;
+ #if XML_GE == 1
+   ACCOUNTING m_accounting;
++  MALLOC_TRACKER m_alloc_tracker;
+   ENTITY_STATS m_entity_stats;
+ #endif
+ };
+ 
+-#define MALLOC(parser, s) (parser->m_mem.malloc_fcn((s)))
+-#define REALLOC(parser, p, s) (parser->m_mem.realloc_fcn((p), (s)))
+-#define FREE(parser, p) (parser->m_mem.free_fcn((p)))
++#if XML_GE == 1
++#  define MALLOC(parser, s) (expat_malloc((parser), (s), __LINE__))
++#  define REALLOC(parser, p, s) (expat_realloc((parser), (p), (s), __LINE__))
++#  define FREE(parser, p) (expat_free((parser), (p), __LINE__))
++#else
++#  define MALLOC(parser, s) (parser->m_mem.malloc_fcn((s)))
++#  define REALLOC(parser, p, s) (parser->m_mem.realloc_fcn((p), (s)))
++#  define FREE(parser, p) (parser->m_mem.free_fcn((p)))
++#endif
++
++#if XML_GE == 1
++static void
++expat_heap_stat(XML_Parser rootParser, char operator, XmlBigCount absDiff,
++                XmlBigCount newTotal, XmlBigCount peakTotal, int sourceLine) {
++  // NOTE: This can be +infinity or -nan
++  const float amplification
++      = (float)newTotal / (float)rootParser->m_accounting.countBytesDirect;
++  fprintf(
++      stderr,
++      "expat: Allocations(%p): Direct " EXPAT_FMT_ULL("10") ", allocated %c" EXPAT_FMT_ULL(
++          "10") " to " EXPAT_FMT_ULL("10") " (" EXPAT_FMT_ULL("10") " peak), amplification %8.2f (xmlparse.c:%d)\n",
++      (void *)rootParser, rootParser->m_accounting.countBytesDirect, operator,
++      absDiff, newTotal, peakTotal, (double)amplification, sourceLine);
++}
++
++static bool
++expat_heap_increase_tolerable(XML_Parser rootParser, XmlBigCount increase,
++                              int sourceLine) {
++  assert(rootParser != NULL);
++  assert(increase > 0);
++
++  XmlBigCount newTotal = 0;
++  bool tolerable = true;
++
++  // Detect integer overflow
++  if ((XmlBigCount)-1 - rootParser->m_alloc_tracker.bytesAllocated < increase) {
++    tolerable = false;
++  } else {
++    newTotal = rootParser->m_alloc_tracker.bytesAllocated + increase;
++
++    if (newTotal >= rootParser->m_alloc_tracker.activationThresholdBytes) {
++      assert(newTotal > 0);
++      // NOTE: This can be +infinity when dividing by zero but not -nan
++      const float amplification
++          = (float)newTotal / (float)rootParser->m_accounting.countBytesDirect;
++      if (amplification
++          > rootParser->m_alloc_tracker.maximumAmplificationFactor) {
++        tolerable = false;
++      }
++    }
++  }
++
++  if (! tolerable && (rootParser->m_alloc_tracker.debugLevel >= 1)) {
++    expat_heap_stat(rootParser, '+', increase, newTotal, newTotal, sourceLine);
++  }
++
++  return tolerable;
++}
++
++static void *
++expat_malloc(XML_Parser parser, size_t size, int sourceLine) {
++  // Detect integer overflow
++  if (SIZE_MAX - size < sizeof(size_t)) {
++    return NULL;
++  }
++
++  const XML_Parser rootParser = getRootParserOf(parser, NULL);
++  assert(rootParser->m_parentParser == NULL);
++
++  const size_t bytesToAllocate = sizeof(size_t) + size;
++
++  if ((XmlBigCount)-1 - rootParser->m_alloc_tracker.bytesAllocated
++      < bytesToAllocate) {
++    return NULL; // i.e. signal integer overflow as out-of-memory
++  }
++
++  if (! expat_heap_increase_tolerable(rootParser, bytesToAllocate,
++                                      sourceLine)) {
++    return NULL; // i.e. signal violation as out-of-memory
++  }
++
++  // Actually allocate
++  void *const mallocedPtr = parser->m_mem.malloc_fcn(bytesToAllocate);
++
++  if (mallocedPtr == NULL) {
++    return NULL;
++  }
++
++  // Update in-block recorded size
++  *(size_t *)mallocedPtr = size;
++
++  // Update accounting
++  rootParser->m_alloc_tracker.bytesAllocated += bytesToAllocate;
++
++  // Report as needed
++  if (rootParser->m_alloc_tracker.debugLevel >= 2) {
++    if (rootParser->m_alloc_tracker.bytesAllocated
++        > rootParser->m_alloc_tracker.peakBytesAllocated) {
++      rootParser->m_alloc_tracker.peakBytesAllocated
++          = rootParser->m_alloc_tracker.bytesAllocated;
++    }
++    expat_heap_stat(rootParser, '+', bytesToAllocate,
++                    rootParser->m_alloc_tracker.bytesAllocated,
++                    rootParser->m_alloc_tracker.peakBytesAllocated, sourceLine);
++  }
++
++  return (char *)mallocedPtr + sizeof(size_t);
++}
++
++static void
++expat_free(XML_Parser parser, void *ptr, int sourceLine) {
++  assert(parser != NULL);
++
++  if (ptr == NULL) {
++    return;
++  }
++
++  const XML_Parser rootParser = getRootParserOf(parser, NULL);
++  assert(rootParser->m_parentParser == NULL);
++
++  // Extract size (to the eyes of malloc_fcn/realloc_fcn) and
++  // the original pointer returned by malloc/realloc
++  void *const mallocedPtr = (char *)ptr - sizeof(size_t);
++  const size_t bytesAllocated = sizeof(size_t) + *(size_t *)mallocedPtr;
++
++  // Update accounting
++  assert(rootParser->m_alloc_tracker.bytesAllocated >= bytesAllocated);
++  rootParser->m_alloc_tracker.bytesAllocated -= bytesAllocated;
++
++  // Report as needed
++  if (rootParser->m_alloc_tracker.debugLevel >= 2) {
++    expat_heap_stat(rootParser, '-', bytesAllocated,
++                    rootParser->m_alloc_tracker.bytesAllocated,
++                    rootParser->m_alloc_tracker.peakBytesAllocated, sourceLine);
++  }
++
++  // NOTE: This may be freeing rootParser, so freeing has to come last
++  parser->m_mem.free_fcn(mallocedPtr);
++}
++
++static void *
++expat_realloc(XML_Parser parser, void *ptr, size_t size, int sourceLine) {
++  assert(parser != NULL);
++
++  if (ptr == NULL) {
++    return expat_malloc(parser, size, sourceLine);
++  }
++
++  if (size == 0) {
++    expat_free(parser, ptr, sourceLine);
++    return NULL;
++  }
++
++  const XML_Parser rootParser = getRootParserOf(parser, NULL);
++  assert(rootParser->m_parentParser == NULL);
++
++  // Extract original size (to the eyes of the caller) and the original
++  // pointer returned by malloc/realloc
++  void *mallocedPtr = (char *)ptr - sizeof(size_t);
++  const size_t prevSize = *(size_t *)mallocedPtr;
++
++  // Classify upcoming change
++  const bool isIncrease = (size > prevSize);
++  const size_t absDiff
++      = (size > prevSize) ? (size - prevSize) : (prevSize - size);
++
++  // Ask for permission from accounting
++  if (isIncrease) {
++    if (! expat_heap_increase_tolerable(rootParser, absDiff, sourceLine)) {
++      return NULL; // i.e. signal violation as out-of-memory
++    }
++  }
++
++  // Actually allocate
++  mallocedPtr = parser->m_mem.realloc_fcn(mallocedPtr, sizeof(size_t) + size);
++
++  if (mallocedPtr == NULL) {
++    return NULL;
++  }
++
++  // Update accounting
++  if (isIncrease) {
++    assert((XmlBigCount)-1 - rootParser->m_alloc_tracker.bytesAllocated
++           >= absDiff);
++    rootParser->m_alloc_tracker.bytesAllocated += absDiff;
++  } else { // i.e. decrease
++    assert(rootParser->m_alloc_tracker.bytesAllocated >= absDiff);
++    rootParser->m_alloc_tracker.bytesAllocated -= absDiff;
++  }
++
++  // Report as needed
++  if (rootParser->m_alloc_tracker.debugLevel >= 2) {
++    if (rootParser->m_alloc_tracker.bytesAllocated
++        > rootParser->m_alloc_tracker.peakBytesAllocated) {
++      rootParser->m_alloc_tracker.peakBytesAllocated
++          = rootParser->m_alloc_tracker.bytesAllocated;
++    }
++    expat_heap_stat(rootParser, isIncrease ? '+' : '-', absDiff,
++                    rootParser->m_alloc_tracker.bytesAllocated,
++                    rootParser->m_alloc_tracker.peakBytesAllocated, sourceLine);
++  }
++
++  // Update in-block recorded size
++  *(size_t *)mallocedPtr = size;
++
++  return (char *)mallocedPtr + sizeof(size_t);
++}
++#endif // XML_GE == 1
+ 
+ XML_Parser XMLCALL
+ XML_ParserCreate(const XML_Char *encodingName) {
+@@ -1100,19 +1315,40 @@ XML_Parser XMLCALL
+ XML_ParserCreate_MM(const XML_Char *encodingName,
+                     const XML_Memory_Handling_Suite *memsuite,
+                     const XML_Char *nameSep) {
+-  return parserCreate(encodingName, memsuite, nameSep, NULL);
++  return parserCreate(encodingName, memsuite, nameSep, NULL, NULL);
+ }
+ 
+ static XML_Parser
+ parserCreate(const XML_Char *encodingName,
+              const XML_Memory_Handling_Suite *memsuite, const XML_Char *nameSep,
+-             DTD *dtd) {
+-  XML_Parser parser;
++             DTD *dtd, XML_Parser parentParser) {
++  XML_Parser parser = NULL;
++
++#if XML_GE == 1
++  const size_t increase = sizeof(size_t) + sizeof(struct XML_ParserStruct);
++
++  if (parentParser != NULL) {
++    const XML_Parser rootParser = getRootParserOf(parentParser, NULL);
++    if (! expat_heap_increase_tolerable(rootParser, increase, __LINE__)) {
++      return NULL;
++    }
++  }
++#else
++  UNUSED_P(parentParser);
++#endif
+ 
+   if (memsuite) {
+     XML_Memory_Handling_Suite *mtemp;
++#if XML_GE == 1
++    void *const sizeAndParser = memsuite->malloc_fcn(
++        sizeof(size_t) + sizeof(struct XML_ParserStruct));
++    if (sizeAndParser != NULL) {
++      *(size_t *)sizeAndParser = sizeof(struct XML_ParserStruct);
++      parser = (XML_Parser)((char *)sizeAndParser + sizeof(size_t));
++#else
+     parser = memsuite->malloc_fcn(sizeof(struct XML_ParserStruct));
+     if (parser != NULL) {
++#endif
+       mtemp = (XML_Memory_Handling_Suite *)&(parser->m_mem);
+       mtemp->malloc_fcn = memsuite->malloc_fcn;
+       mtemp->realloc_fcn = memsuite->realloc_fcn;
+@@ -1120,18 +1356,67 @@ parserCreate(const XML_Char *encodingName,
+     }
+   } else {
+     XML_Memory_Handling_Suite *mtemp;
++#if XML_GE == 1
++    void *const sizeAndParser
++        = (XML_Parser)malloc(sizeof(size_t) + sizeof(struct XML_ParserStruct));
++    if (sizeAndParser != NULL) {
++      *(size_t *)sizeAndParser = sizeof(struct XML_ParserStruct);
++      parser = (XML_Parser)((char *)sizeAndParser + sizeof(size_t));
++#else
+     parser = (XML_Parser)malloc(sizeof(struct XML_ParserStruct));
+     if (parser != NULL) {
++#endif
+       mtemp = (XML_Memory_Handling_Suite *)&(parser->m_mem);
+       mtemp->malloc_fcn = malloc;
+       mtemp->realloc_fcn = realloc;
+       mtemp->free_fcn = free;
+     }
+-  }
++  } // cppcheck-suppress[memleak symbolName=sizeAndParser] // Cppcheck >=2.18.0
+ 
+   if (! parser)
+     return parser;
+ 
++#if XML_GE == 1
++  // Initialize .m_alloc_tracker
++  memset(&parser->m_alloc_tracker, 0, sizeof(MALLOC_TRACKER));
++  if (parentParser == NULL) {
++    parser->m_alloc_tracker.debugLevel
++        = getDebugLevel("EXPAT_MALLOC_DEBUG", 0u);
++    parser->m_alloc_tracker.maximumAmplificationFactor
++        = EXPAT_ALLOC_TRACKER_MAXIMUM_AMPLIFICATION_DEFAULT;
++    parser->m_alloc_tracker.activationThresholdBytes
++        = EXPAT_ALLOC_TRACKER_ACTIVATION_THRESHOLD_DEFAULT;
++
++    // NOTE: This initialization needs to come this early because these fields
++    //       are read by allocation tracking code
++    parser->m_parentParser = NULL;
++    parser->m_accounting.countBytesDirect = 0;
++  } else {
++    parser->m_parentParser = parentParser;
++  }
++
++  // Record XML_ParserStruct allocation we did a few lines up before
++  const XML_Parser rootParser = getRootParserOf(parser, NULL);
++  assert(rootParser->m_parentParser == NULL);
++  assert(SIZE_MAX - rootParser->m_alloc_tracker.bytesAllocated >= increase);
++  rootParser->m_alloc_tracker.bytesAllocated += increase;
++
++  // Report on allocation
++  if (rootParser->m_alloc_tracker.debugLevel >= 2) {
++    if (rootParser->m_alloc_tracker.bytesAllocated
++        > rootParser->m_alloc_tracker.peakBytesAllocated) {
++      rootParser->m_alloc_tracker.peakBytesAllocated
++          = rootParser->m_alloc_tracker.bytesAllocated;
++    }
++
++    expat_heap_stat(rootParser, '+', increase,
++                    rootParser->m_alloc_tracker.bytesAllocated,
++                    rootParser->m_alloc_tracker.peakBytesAllocated, __LINE__);
++  }
++#else
++  parser->m_parentParser = NULL;
++#endif // XML_GE == 1
++
+   parser->m_buffer = NULL;
+   parser->m_bufferLim = NULL;
+ 
+@@ -1171,7 +1377,6 @@ parserInit(XML_Parser parser, const XML_
+   parser->m_unknownEncodingMem = NULL;
+   parser->m_unknownEncodingRelease = NULL;
+   parser->m_unknownEncodingData = NULL;
+-  parser->m_parentParser = NULL;
+   parser->m_parsingStatus.parsing = XML_INITIALIZED;
+ #ifdef XML_DTD
+   parser->m_isParamEntity = XML_FALSE;
+@@ -1530,9 +1814,10 @@ XML_ExternalEntityParserCreate(XML_Parser oldParser, const XML_Char *context,
+   */
+   if (parser->m_ns) {
+     XML_Char tmp[2] = {parser->m_namespaceSeparator, 0};
+-    parser = parserCreate(encodingName, &parser->m_mem, tmp, newDtd);
++    parser = parserCreate(encodingName, &parser->m_mem, tmp, newDtd, oldParser);
+   } else {
+-    parser = parserCreate(encodingName, &parser->m_mem, NULL, newDtd);
++    parser
++        = parserCreate(encodingName, &parser->m_mem, NULL, newDtd, oldParser);
+   }
+ 
+   if (! parser)
+@@ -2570,6 +2775,13 @@ XML_GetFeatureList(void) {
+        EXPAT_BILLION_LAUGHS_ATTACK_PROTECTION_ACTIVATION_THRESHOLD_DEFAULT},
+       /* Added in Expat 2.6.0. */
+     {XML_FEATURE_GE, XML_L("XML_GE"), 0},
++    /* Added in Expat 2.7.2. */
++    {XML_FEATURE_ALLOC_TRACKER_MAXIMUM_AMPLIFICATION_DEFAULT,
++     XML_L("XML_AT_MAX_AMP"),
++      (long int)EXPAT_ALLOC_TRACKER_MAXIMUM_AMPLIFICATION_DEFAULT},
++    {XML_FEATURE_ALLOC_TRACKER_ACTIVATION_THRESHOLD_DEFAULT,
++     XML_L("XML_AT_ACT_THRES"),
++      (long int)EXPAT_ALLOC_TRACKER_ACTIVATION_THRESHOLD_DEFAULT},
+ #endif
+       {XML_FEATURE_END, NULL, 0}};
+ 
+@@ -2598,6 +2810,29 @@ XML_SetBillionLaughsAttackProtectionActi
+   parser->m_accounting.activationThresholdBytes = activationThresholdBytes;
+   return XML_TRUE;
+ }
++
++XML_Bool XMLCALL
++XML_SetAllocTrackerMaximumAmplification(XML_Parser parser,
++                                        float maximumAmplificationFactor) {
++  if ((parser == NULL) || (parser->m_parentParser != NULL)
++      || isnan(maximumAmplificationFactor)
++      || (maximumAmplificationFactor < 1.0f)) {
++    return XML_FALSE;
++  }
++  parser->m_alloc_tracker.maximumAmplificationFactor
++      = maximumAmplificationFactor;
++  return XML_TRUE;
++}
++
++XML_Bool XMLCALL
++XML_SetAllocTrackerActivationThreshold(
++    XML_Parser parser, unsigned long long activationThresholdBytes) {
++  if ((parser == NULL) || (parser->m_parentParser != NULL)) {
++    return XML_FALSE;
++  }
++  parser->m_alloc_tracker.activationThresholdBytes = activationThresholdBytes;
++  return XML_TRUE;
++}
+ #endif /* XML_GE == 1 */
+ 
+ /* Initially tag->rawName always points into the parse buffer;
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-10.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-10.patch
new file mode 100644
index 0000000..c4a04ef
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-10.patch
@@ -0,0 +1,59 @@
+From 7e35240dc97e9fd4f609e31f27c27b659535e436 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Thu, 11 Sep 2025 00:27:05 +0200
+Subject: [PATCH] lib: Exclude the content model from allocation tracking
+
+.. so that applications that are not using XML_FreeContentModel
+but plain free(..) or .free_fcn() to free the content model's
+memory are safe
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/7e35240dc97e9fd4f609e31f27c27b659535e436]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 00139b947..d0b6e0cde 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -2791,7 +2791,10 @@ void XMLCALL
+ XML_FreeContentModel(XML_Parser parser, XML_Content *model) {
+   if (parser == NULL)
+     return;
+-  FREE(parser, model);
++
++  // NOTE: We are avoiding FREE(..) here because the content model
++  //       has been created using plain .malloc_fcn(..) rather than MALLOC(..).
++  parser->m_mem.free_fcn(model);
+ }
+ 
+ void *XMLCALL
+@@ -6069,8 +6072,12 @@ doProlog(XML_Parser parser, const ENCODING *enc, const char *s, const char *end,
+     case XML_ROLE_CONTENT_EMPTY:
+       if (dtd->in_eldecl) {
+         if (parser->m_elementDeclHandler) {
++          // NOTE: We are avoiding MALLOC(..) here to so that
++          //       applications that are not using XML_FreeContentModel but
++          //       plain free(..) or .free_fcn() to free the content model's
++          //       memory are safe.
+           XML_Content *content
+-              = (XML_Content *)MALLOC(parser, sizeof(XML_Content));
++              = (XML_Content *)parser->m_mem.malloc_fcn(sizeof(XML_Content));
+           if (! content)
+             return XML_ERROR_NO_MEMORY;
+           content->quant = XML_CQUANT_NONE;
+@@ -8285,7 +8292,10 @@ build_model(XML_Parser parser) {
+   const size_t allocsize = (dtd->scaffCount * sizeof(XML_Content)
+                             + (dtd->contentStringLen * sizeof(XML_Char)));
+ 
+-  ret = (XML_Content *)MALLOC(parser, allocsize);
++  // NOTE: We are avoiding MALLOC(..) here to so that
++  //       applications that are not using XML_FreeContentModel but plain
++  //       free(..) or .free_fcn() to free the content model's memory are safe.
++  ret = (XML_Content *)parser->m_mem.malloc_fcn(allocsize);
+   if (! ret)
+     return NULL;
+ 
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-11.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-11.patch
new file mode 100644
index 0000000..0592653
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-11.patch
@@ -0,0 +1,67 @@
+From ae4086198d710a62a0a1560007b81307dba72909 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Tue, 9 Sep 2025 21:34:28 +0200
+Subject: [PATCH] lib: Exclude the main input buffer from allocation tracking
+
+.. so that control of the input buffer size remains with the
+application using Expat
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/ae4086198d710a62a0a1560007b81307dba72909]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 8145a049d..00139b947 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -1979,7 +1979,10 @@ XML_ParserFree(XML_Parser parser) {
+   FREE(parser, (void *)parser->m_attInfo);
+ #endif
+   FREE(parser, parser->m_groupConnector);
+-  FREE(parser, parser->m_buffer);
++  // NOTE: We are avoiding FREE(..) here because parser->m_buffer
++  //       is not being allocated with MALLOC(..) but with plain
++  //       .malloc_fcn(..).
++  parser->m_mem.free_fcn(parser->m_buffer);
+   FREE(parser, parser->m_dataBuf);
+   FREE(parser, parser->m_nsAtts);
+   FREE(parser, parser->m_unknownEncodingMem);
+@@ -2573,7 +2576,9 @@ XML_GetBuffer(XML_Parser parser, int len) {
+         parser->m_errorCode = XML_ERROR_NO_MEMORY;
+         return NULL;
+       }
+-      newBuf = (char *)MALLOC(parser, bufferSize);
++      // NOTE: We are avoiding MALLOC(..) here to leave limiting
++      //       the input size to the application using Expat.
++      newBuf = (char *)parser->m_mem.malloc_fcn(bufferSize);
+       if (newBuf == 0) {
+         parser->m_errorCode = XML_ERROR_NO_MEMORY;
+         return NULL;
+@@ -2584,7 +2589,10 @@ XML_GetBuffer(XML_Parser parser, int len) {
+         memcpy(newBuf, &parser->m_bufferPtr[-keep],
+                EXPAT_SAFE_PTR_DIFF(parser->m_bufferEnd, parser->m_bufferPtr)
+                    + keep);
+-        FREE(parser, parser->m_buffer);
++        // NOTE: We are avoiding FREE(..) here because parser->m_buffer
++        //       is not being allocated with MALLOC(..) but with plain
++        //       .malloc_fcn(..).
++        parser->m_mem.free_fcn(parser->m_buffer);
+         parser->m_buffer = newBuf;
+         parser->m_bufferEnd
+             = parser->m_buffer
+@@ -2600,7 +2608,10 @@ XML_GetBuffer(XML_Parser parser, int len) {
+       if (parser->m_bufferPtr) {
+         memcpy(newBuf, parser->m_bufferPtr,
+                EXPAT_SAFE_PTR_DIFF(parser->m_bufferEnd, parser->m_bufferPtr));
+-        FREE(parser, parser->m_buffer);
++        // NOTE: We are avoiding FREE(..) here because parser->m_buffer
++        //       is not being allocated with MALLOC(..) but with plain
++        //       .malloc_fcn(..).
++        parser->m_mem.free_fcn(parser->m_buffer);
+         parser->m_bufferEnd
+             = newBuf
+               + EXPAT_SAFE_PTR_DIFF(parser->m_bufferEnd, parser->m_bufferPtr);
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-12.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-12.patch
new file mode 100644
index 0000000..f8b978f
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-12.patch
@@ -0,0 +1,55 @@
+From 96c7467281c72028aada525c1d3822512758b266 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Sun, 7 Sep 2025 12:06:43 +0200
+Subject: [PATCH] lib: Exclude XML_Mem* functions from allocation tracking
+
+.. so that allocations by the user application
+are not being limited.
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/96c7467281c72028aada525c1d3822512758b266]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 5d27cd451..8145a049d 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -2787,21 +2787,31 @@ void *XMLCALL
+ XML_MemMalloc(XML_Parser parser, size_t size) {
+   if (parser == NULL)
+     return NULL;
+-  return MALLOC(parser, size);
++
++  // NOTE: We are avoiding MALLOC(..) here to not include
++  //       user allocations with allocation tracking and limiting.
++  return parser->m_mem.malloc_fcn(size);
+ }
+ 
+ void *XMLCALL
+ XML_MemRealloc(XML_Parser parser, void *ptr, size_t size) {
+   if (parser == NULL)
+     return NULL;
+-  return REALLOC(parser, ptr, size);
++
++  // NOTE: We are avoiding REALLOC(..) here to not include
++  //       user allocations with allocation tracking and limiting.
++  return parser->m_mem.realloc_fcn(ptr, size);
+ }
+ 
+ void XMLCALL
+ XML_MemFree(XML_Parser parser, void *ptr) {
+   if (parser == NULL)
+     return;
+-  FREE(parser, ptr);
++
++  // NOTE: We are avoiding FREE(..) here because XML_MemMalloc and
++  //       XML_MemRealloc are not using MALLOC(..) and REALLOC(..)
++  //       but plain .malloc_fcn(..) and .realloc_fcn(..), internally.
++  parser->m_mem.free_fcn(ptr);
+ }
+ 
+ void XMLCALL
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-13.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-13.patch
new file mode 100644
index 0000000..7ff3b1b
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-13.patch
@@ -0,0 +1,121 @@
+From 78366891a586f293aeff60a14a55e4afe1169586 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Tue, 2 Sep 2025 16:44:00 +0200
+Subject: [PATCH] xmlwf: Wire allocation tracker config to existing arguments
+ -a and -b
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/78366891a586f293aeff60a14a55e4afe1169586]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/doc/xmlwf.xml b/doc/xmlwf.xml
+index 17e9cf51c..65d8ae9b2 100644
+--- a/doc/xmlwf.xml
++++ b/doc/xmlwf.xml
+@@ -158,19 +158,31 @@ supports both.
+         <listitem>
+           <para>
+             Sets the maximum tolerated amplification factor
+-            for protection against billion laughs attacks (default: 100.0).
++            for protection against amplification attacks
++            like the billion laughs attack
++            (default: 100.0
++            for the sum of direct and indirect output and also
++            for allocations of dynamic memory).
+             The amplification factor is calculated as ..
+           </para>
+           <literallayout>
+             amplification := (direct + indirect) / direct
+           </literallayout>
+           <para>
+-            .. while parsing, whereas
++            .. with regard to use of entities and ..
++          </para>
++          <literallayout>
++            amplification := allocated / direct
++          </literallayout>
++          <para>
++            .. with regard to dynamic memory while parsing.
+             &lt;direct&gt; is the number of bytes read
+-              from the primary document in parsing and
++              from the primary document in parsing,
+             &lt;indirect&gt; is the number of bytes
+               added by expanding entities and reading of external DTD files,
+-              combined.
++              combined, and
++            &lt;allocated&gt; is the total number of bytes of dynamic memory
++              allocated (and not freed) per hierarchy of parsers.
+           </para>
+           <para>
+             <emphasis>NOTE</emphasis>:
+@@ -185,8 +197,10 @@ supports both.
+         <listitem>
+           <para>
+             Sets the number of output bytes (including amplification)
+-            needed to activate protection against billion laughs attacks
+-            (default: 8 MiB).
++            needed to activate protection against amplification attacks
++            like billion laughs
++            (default: 8 MiB for the sum of direct and indirect output,
++            and 64 MiB for allocations of dynamic memory).
+             This can be thought of as an &quot;activation threshold&quot;.
+           </para>
+           <para>
+diff --git a/xmlwf/xmlwf.c b/xmlwf/xmlwf.c
+index b9d0a7fca..14206d9e5 100644
+--- a/xmlwf/xmlwf.c
++++ b/xmlwf/xmlwf.c
+@@ -908,11 +908,11 @@ usage(const XML_Char *prog, int rc) {
+       T("  -t            write no XML output for [t]iming of plain parsing\n")
+       T("  -N            enable adding doctype and [n]otation declarations\n")
+       T("\n")
+-      T("billion laughs attack protection:\n")
++      T("amplification attack protection (e.g. billion laughs):\n")
+       T("  NOTE: If you ever need to increase these values for non-attack payload, please file a bug report.\n")
+       T("\n")
+       T("  -a FACTOR     set maximum tolerated [a]mplification factor (default: 100.0)\n")
+-      T("  -b BYTES      set number of output [b]ytes needed to activate (default: 8 MiB)\n")
++      T("  -b BYTES      set number of output [b]ytes needed to activate (default: 8 MiB/64 MiB)\n")
+       T("\n")
+       T("info arguments:\n")
+       T("  -h            show this [h]elp message and exit\n")
+@@ -1181,12 +1181,15 @@ tmain(int argc, XML_Char **argv) {
+ #if XML_GE == 1
+       XML_SetBillionLaughsAttackProtectionMaximumAmplification(
+           parser, attackMaximumAmplification);
++      XML_SetAllocTrackerMaximumAmplification(parser,
++                                              attackMaximumAmplification);
+ #endif
+     }
+     if (attackThresholdGiven) {
+ #if XML_GE == 1
+       XML_SetBillionLaughsAttackProtectionActivationThreshold(
+           parser, attackThresholdBytes);
++      XML_SetAllocTrackerActivationThreshold(parser, attackThresholdBytes);
+ #else
+       (void)attackThresholdBytes; // silence -Wunused-but-set-variable
+ #endif
+diff --git a/xmlwf/xmlwf_helpgen.py b/xmlwf/xmlwf_helpgen.py
+index 2360820d3..e91c285ce 100755
+--- a/xmlwf/xmlwf_helpgen.py
++++ b/xmlwf/xmlwf_helpgen.py
+@@ -77,13 +77,13 @@ output_mode.add_argument('-m', action='s
+ output_mode.add_argument('-t', action='store_true', help='write no XML output for [t]iming of plain parsing')
+ output_related.add_argument('-N', action='store_true', help='enable adding doctype and [n]otation declarations')
+
+-billion_laughs = parser.add_argument_group('billion laughs attack protection',
++billion_laughs = parser.add_argument_group('amplification attack protection (e.g. billion laughs)',
+                                            description='NOTE: '
+                                                        'If you ever need to increase these values '
+                                                        'for non-attack payload, please file a bug report.')
+ billion_laughs.add_argument('-a', metavar='FACTOR',
+                             help='set maximum tolerated [a]mplification factor (default: 100.0)')
+-billion_laughs.add_argument('-b', metavar='BYTES', help='set number of output [b]ytes needed to activate (default: 8 MiB)')
++billion_laughs.add_argument('-b', metavar='BYTES', help='set number of output [b]ytes needed to activate (default: 8 MiB/64 MiB)')
+
+ parser.add_argument('files', metavar='FILE', nargs='*', help='file to process (default: STDIN)')
+ 
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-14.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-14.patch
new file mode 100644
index 0000000..45aef83
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-14.patch
@@ -0,0 +1,71 @@
+From 31f9053c3c46741f4daf2ea2bdea75f40f720d42 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Tue, 2 Sep 2025 22:36:49 +0200
+Subject: [PATCH] tests: Cover allocation tracking and limiting with tests
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/31f9053c3c46741f4daf2ea2bdea75f40f720d42]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to expat 2.5.0 code base and
+removes the tests/alloc_tests.c changes as it is not available.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/internal.h b/lib/internal.h
+index eb67cf50c..6e087858e 100644
+--- a/lib/internal.h
++++ b/lib/internal.h
+@@ -165,6 +165,12 @@ unsigned long long testingAccountingGetC
+ const char *unsignedCharToPrintable(unsigned char c);
+ #endif
+
++#if defined(XML_TESTING)
++void *expat_malloc(XML_Parser parser, size_t size, int sourceLine);
++void expat_free(XML_Parser parser, void *ptr, int sourceLine);
++void *expat_realloc(XML_Parser parser, void *ptr, size_t size, int sourceLine);
++#endif
++
+ #ifdef __cplusplus
+ }
+ #endif
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index d0b6e0cde..6e9c6fb24 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -843,7 +843,11 @@ expat_heap_increase_tolerable(XML_Parser rootParser, XmlBigCount increase,
+   return tolerable;
+ }
+ 
++#  if defined(XML_TESTING)
++void *
++#  else
+ static void *
++#  endif
+ expat_malloc(XML_Parser parser, size_t size, int sourceLine) {
+   // Detect integer overflow
+   if (SIZE_MAX - size < sizeof(size_t)) {
+@@ -893,7 +897,11 @@ expat_malloc(XML_Parser parser, size_t size, int sourceLine) {
+   return (char *)mallocedPtr + sizeof(size_t);
+ }
+ 
++#  if defined(XML_TESTING)
++void
++#  else
+ static void
++#  endif
+ expat_free(XML_Parser parser, void *ptr, int sourceLine) {
+   assert(parser != NULL);
+ 
+@@ -924,7 +932,11 @@ expat_free(XML_Parser parser, void *ptr, int sourceLine) {
+   parser->m_mem.free_fcn(mallocedPtr);
+ }
+ 
++#  if defined(XML_TESTING)
++void *
++#  else
+ static void *
++#  endif
+ expat_realloc(XML_Parser parser, void *ptr, size_t size, int sourceLine) {
+   assert(parser != NULL);
+ 
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-15.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-15.patch
new file mode 100644
index 0000000..f203305
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-15.patch
@@ -0,0 +1,29 @@
+From a6a2a49367f03f5d8a73c9027b45b59953ca27d8 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Wed, 10 Sep 2025 19:52:39 +0200
+Subject: [PATCH] docs: Promote the contract to call XML_FreeContentModel
+
+.. when registering a custom element declaration handler
+(via a call to function XML_SetElementDeclHandler)
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/a6a2a49367f03f5d8a73c9027b45b59953ca27d8]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/doc/reference.html b/doc/reference.html
+index 81da4e6c6..564fc1b23 100644
+--- a/doc/reference.html
++++ b/doc/reference.html
+@@ -1907,7 +1907,7 @@ <h4 id="XML_SetElementDeclHandler">XML_SetElementDeclHandler</h4>
+ <p>Sets a handler for element declarations in a DTD. The handler gets
+ called with the name of the element in the declaration and a pointer
+ to a structure that contains the element model. It's the user code's 
+-responsibility to free model when finished with it. See <code>
++responsibility to free model when finished with via a call to <code>
+ <a href="#XML_FreeContentModel">XML_FreeContentModel</a></code>.
+ There is no need to free the model from the handler, it can be kept
+ around and freed at a later stage.</p>
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-16.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-16.patch
new file mode 100644
index 0000000..98821e1
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-16.patch
@@ -0,0 +1,146 @@
+From d6246c31a1238d065b4d9690d3bac740326f6485 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Wed, 3 Sep 2025 01:28:03 +0200
+Subject: [PATCH] docs: Document the two allocation tracking API functions
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/d6246c31a1238d065b4d9690d3bac740326f6485]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/doc/reference.html b/doc/reference.html
+index 894767101..81da4e6c6 100644
+--- a/doc/reference.html
++++ b/doc/reference.html
+@@ -155,6 +155,8 @@ interface.</p>
+       <ul>
+         <li><a href="#XML_SetBillionLaughsAttackProtectionMaximumAmplification">XML_SetBillionLaughsAttackProtectionMaximumAmplification</a></li>
+         <li><a href="#XML_SetBillionLaughsAttackProtectionActivationThreshold">XML_SetBillionLaughsAttackProtectionActivationThreshold</a></li>
++        <li><a href="#XML_SetAllocTrackerMaximumAmplification">XML_SetAllocTrackerMaximumAmplification</a></li>
++        <li><a href="#XML_SetAllocTrackerActivationThreshold">XML_SetAllocTrackerActivationThreshold</a></li>
+       </ul>
+     </li>
+     <li><a href="#miscellaneous">Miscellaneous Functions</a>
+
+
+@@ -2187,6 +2189,120 @@ XML_SetBillionLaughsAttackProtectionMaxi
+   </p>
+ </div>
+
++<h4 id="XML_SetAllocTrackerMaximumAmplification">XML_SetAllocTrackerMaximumAmplification</h4>
++<pre class="fcndec">
++/* Added in Expat 2.7.2. */
++XML_Bool
++XML_SetAllocTrackerMaximumAmplification(XML_Parser p,
++                                        float maximumAmplificationFactor);
++</pre>
++<div class="fcndef">
++  <p>
++    Sets the maximum tolerated amplification factor
++    between direct input and bytes of dynamic memory allocated
++    (default: <code>100.0</code>)
++    of parser <code>p</code> to <code>maximumAmplificationFactor</code>, and
++    returns <code>XML_TRUE</code> upon success and <code>XML_FALSE</code> upon error.
++  </p>
++
++  <p>
++    <strong>Note:</strong>
++    There are three types of allocations that intentionally bypass tracking and limiting:
++  </p>
++  <ul>
++    <li>
++      application calls to functions
++      <code><a href="#XML_MemMalloc">XML_MemMalloc</a></code>
++      and
++      <code><a href="#XML_MemRealloc">XML_MemRealloc</a></code>
++      &mdash;
++      <em>healthy</em> use of these two functions continues to be a responsibility
++      of the application using Expat
++      &mdash;,
++    </li>
++    <li>
++      the main character buffer used by functions
++      <code><a href="#XML_GetBuffer">XML_GetBuffer</a></code>
++      and
++      <code><a href="#XML_ParseBuffer">XML_ParseBuffer</a></code>
++      (and thus also by plain
++      <code><a href="#XML_Parse">XML_Parse</a></code>), and
++    </li>
++    <li>
++      the <a href="#XML_SetElementDeclHandler">content model memory</a>
++      (that is passed to the
++      <a href="#XML_SetElementDeclHandler">element declaration handler</a>
++      and freed by a call to
++      <code><a href="#XML_FreeContentModel">XML_FreeContentModel</a></code>).
++    </li>
++  </ul>
++
++  <p>The amplification factor is calculated as ..</p>
++  <pre>amplification := allocated / direct</pre>
++  <p>
++    .. while parsing, whereas
++    <code>direct</code> is the number of bytes read from the primary document in parsing and
++    <code>allocated</code> is the number of bytes of dynamic memory allocated in the parser hierarchy.
++  </p>
++
++  <p>For a call to <code>XML_SetAllocTrackerMaximumAmplification</code> to succeed:</p>
++  <ul>
++    <li>parser <code>p</code> must be a non-<code>NULL</code> root parser (without any parent parsers) and</li>
++    <li><code>maximumAmplificationFactor</code> must be non-<code>NaN</code> and greater than or equal to <code>1.0</code>.</li>
++  </ul>
++
++  <p>
++    <strong>Note:</strong>
++    If you ever need to increase this value for non-attack payload,
++    please <a href="https://github.com/libexpat/libexpat/issues">file a bug report</a>.
++  </p>
++
++  <p>
++    <strong>Note:</strong>
++    Amplifications factors greater than 100 can been observed near the start of parsing
++    even with benign files in practice.
++
++    So if you do reduce the maximum allowed amplification,
++    please make sure that the activation threshold is still big enough
++    to not end up with undesired false positives (i.e. benign files being rejected).
++  </p>
++</div>
++
++<h4 id="XML_SetAllocTrackerActivationThreshold">XML_SetAllocTrackerActivationThreshold</h4>
++<pre class="fcndec">
++/* Added in Expat 2.7.2. */
++XML_Bool
++XML_SetAllocTrackerActivationThreshold(XML_Parser p,
++                                       unsigned long long activationThresholdBytes);
++</pre>
++<div class="fcndef">
++  <p>
++    Sets number of allocated bytes of dynamic memory
++    needed to activate protection against disproportionate use of RAM
++    (default: <code>64 MiB</code>)
++    of parser <code>p</code> to <code>activationThresholdBytes</code>, and
++    returns <code>XML_TRUE</code> upon success and <code>XML_FALSE</code> upon error.
++  </p>
++
++  <p>
++    <strong>Note:</strong>
++    For types of allocations that intentionally bypass tracking and limiting, please see
++    <code><a href="#XML_SetAllocTrackerMaximumAmplification">XML_SetAllocTrackerMaximumAmplification</a></code>
++    above.
++  </p>
++
++  <p>For a call to <code>XML_SetAllocTrackerActivationThreshold</code> to succeed:</p>
++  <ul>
++    <li>parser <code>p</code> must be a non-<code>NULL</code> root parser (without any parent parsers).</li>
++  </ul>
++
++  <p>
++    <strong>Note:</strong>
++    If you ever need to increase this value for non-attack payload,
++    please <a href="https://github.com/libexpat/libexpat/issues">file a bug report</a>.
++  </p>
++</div>
++
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-17.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-17.patch
new file mode 100644
index 0000000..b6d3863
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-17.patch
@@ -0,0 +1,34 @@
+From bacb4df7641617463b9f3be97760eb1a4975d0ba Mon Sep 17 00:00:00 2001
+From: Zahir Hussain <zahir.basha@kpit.com>
+Date: Wed, 29 Apr 2026 14:33:06 +0530
+Subject: [PATCH] expat: fix build error
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/9cdf9b8d77d5c2c2a27d15fb68dd3f83cafb45a1]
+
+comment: To resolve the below issue adding stdbool.h header file in xmlparse.c
+
+| /home/zahir/Desktop/loc_asz/upstream/poky/build/tmp/work/core2-64-poky-linux/expat/2.5.0-r0/expat-2.5.0/lib/xmlparse.c:766:17: note: 'false' is defined in header '<stdbool.h>'; did you forget to '#include <stdbool.h>'?
+| /home/zahir/Desktop/loc_asz/upstream/poky/build/tmp/work/core2-64-poky-linux/expat/2.5.0-r0/expat-2.5.0/lib/xmlparse.c: In function 'expat_realloc':
+| /home/zahir/Desktop/loc_asz/upstream/poky/build/tmp/work/core2-64-poky-linux/expat/2.5.0-r0/expat-2.5.0/lib/xmlparse.c:905:9: error: unknown type name 'bool'
+|   905 |   const bool isIncrease = (size > prevSize);
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+ lib/xmlparse.c | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index a881140..3271ed9 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -81,6 +81,7 @@
+ #  endif
+ #endif
+
++#include <stdbool.h>
+ #include <stddef.h>
+ #include <string.h> /* memset(), memcpy() */
+ #include <assert.h>
+-- 
+2.34.1
+
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-18.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-18.patch
new file mode 100644
index 0000000..4134271
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-18.patch
@@ -0,0 +1,156 @@
+From 16412a8e99455bc7a3dc53a053e5f3ab351a92c8 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Fri, 19 Sep 2025 23:32:46 +0200
+Subject: [PATCH] lib: Fix alignment of internal allocations for 32bit
+ architectures
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/16412a8e99455bc7a3dc53a053e5f3ab351a92c8]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code and removes
+tests/alloc_tests.c file as it is not available in source code base.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/lib/internal.h b/lib/internal.h
+index 6e087858e..d59da99eb 100644
+--- a/lib/internal.h
++++ b/lib/internal.h
+@@ -106,6 +106,7 @@
+ #endif
+
+ #include <limits.h> // ULONG_MAX
++#include <stddef.h> // size_t
+
+ #if defined(_WIN32)                                                            \
+     && (! defined(__USE_MINGW_ANSI_STDIO)                                      \
+@@ -148,6 +149,11 @@
+ #define EXPAT_ALLOC_TRACKER_ACTIVATION_THRESHOLD_DEFAULT                       \
+   67108864 // 64 MiB, 2^26
+
++// NOTE: If function expat_alloc was user facing, EXPAT_MALLOC_ALIGNMENT would
++//       have to take sizeof(long double) into account
++#define EXPAT_MALLOC_ALIGNMENT sizeof(long long) // largest parser (sub)member
++#define EXPAT_MALLOC_PADDING ((EXPAT_MALLOC_ALIGNMENT) - sizeof(size_t))
++
+ /* NOTE END */
+
+ #include "expat.h" // so we can use type XML_Parser below
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 24fd7b97a..ce29ab6ff 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -794,14 +794,14 @@ static void *
+ #  endif
+ expat_malloc(XML_Parser parser, size_t size, int sourceLine) {
+   // Detect integer overflow
+-  if (SIZE_MAX - size < sizeof(size_t)) {
++  if (SIZE_MAX - size < sizeof(size_t) + EXPAT_MALLOC_PADDING) {
+     return NULL;
+   }
+ 
+   const XML_Parser rootParser = getRootParserOf(parser, NULL);
+   assert(rootParser->m_parentParser == NULL);
+ 
+-  const size_t bytesToAllocate = sizeof(size_t) + size;
++  const size_t bytesToAllocate = sizeof(size_t) + EXPAT_MALLOC_PADDING + size;
+ 
+   if ((XmlBigCount)-1 - rootParser->m_alloc_tracker.bytesAllocated
+       < bytesToAllocate) {
+@@ -838,7 +838,7 @@ expat_malloc(XML_Parser parser, size_t s
+                     rootParser->m_alloc_tracker.peakBytesAllocated, sourceLine);
+   }
+ 
+-  return (char *)mallocedPtr + sizeof(size_t);
++  return (char *)mallocedPtr + sizeof(size_t) + EXPAT_MALLOC_PADDING;
+ }
+ 
+ #  if defined(XML_TESTING)
+@@ -858,8 +858,9 @@ expat_free(XML_Parser parser, void *ptr,
+ 
+   // Extract size (to the eyes of malloc_fcn/realloc_fcn) and
+   // the original pointer returned by malloc/realloc
+-  void *const mallocedPtr = (char *)ptr - sizeof(size_t);
+-  const size_t bytesAllocated = sizeof(size_t) + *(size_t *)mallocedPtr;
++  void *const mallocedPtr = (char *)ptr - EXPAT_MALLOC_PADDING - sizeof(size_t);
++  const size_t bytesAllocated
++      = sizeof(size_t) + EXPAT_MALLOC_PADDING + *(size_t *)mallocedPtr;
+ 
+   // Update accounting
+   assert(rootParser->m_alloc_tracker.bytesAllocated >= bytesAllocated);
+@@ -898,7 +899,7 @@ expat_realloc(XML_Parser parser, void *p
+ 
+   // Extract original size (to the eyes of the caller) and the original
+   // pointer returned by malloc/realloc
+-  void *mallocedPtr = (char *)ptr - sizeof(size_t);
++  void *mallocedPtr = (char *)ptr - EXPAT_MALLOC_PADDING - sizeof(size_t);
+   const size_t prevSize = *(size_t *)mallocedPtr;
+ 
+   // Classify upcoming change
+@@ -913,8 +914,13 @@ expat_realloc(XML_Parser parser, void *p
+     }
+   }
+ 
++  // NOTE: Integer overflow detection has already been done for us
++  //       by expat_heap_increase_tolerable(..) above
++  assert(SIZE_MAX - sizeof(size_t) - EXPAT_MALLOC_PADDING >= size);
++  
+   // Actually allocate
+-  mallocedPtr = parser->m_mem.realloc_fcn(mallocedPtr, sizeof(size_t) + size);
++  mallocedPtr = parser->m_mem.realloc_fcn(
++      mallocedPtr, sizeof(size_t) + EXPAT_MALLOC_PADDING + size);
+ 
+   if (mallocedPtr == NULL) {
+     return NULL;
+@@ -945,7 +951,7 @@ expat_realloc(XML_Parser parser, void *p
+   // Update in-block recorded size
+   *(size_t *)mallocedPtr = size;
+ 
+-  return (char *)mallocedPtr + sizeof(size_t);
++  return (char *)mallocedPtr + sizeof(size_t) + EXPAT_MALLOC_PADDING;
+ }
+ #endif // XML_GE == 1
+ 
+@@ -1212,7 +1218,8 @@ parserCreate(const XML_Char *encodingNam
+   XML_Parser parser = NULL;
+ 
+ #if XML_GE == 1
+-  const size_t increase = sizeof(size_t) + sizeof(struct XML_ParserStruct);
++  const size_t increase
++      = sizeof(size_t) + EXPAT_MALLOC_PADDING + sizeof(struct XML_ParserStruct);
+ 
+   if (parentParser != NULL) {
+     const XML_Parser rootParser = getRootParserOf(parentParser, NULL);
+@@ -1227,11 +1234,12 @@ parserCreate(const XML_Char *encodingNam
+   if (memsuite) {
+     XML_Memory_Handling_Suite *mtemp;
+ #if XML_GE == 1
+-    void *const sizeAndParser = memsuite->malloc_fcn(
+-        sizeof(size_t) + sizeof(struct XML_ParserStruct));
++    void *const sizeAndParser = malloc(sizeof(size_t) + EXPAT_MALLOC_PADDING
++                                       + sizeof(struct XML_ParserStruct));
+     if (sizeAndParser != NULL) {
+       *(size_t *)sizeAndParser = sizeof(struct XML_ParserStruct);
+-      parser = (XML_Parser)((char *)sizeAndParser + sizeof(size_t));
++      parser = (XML_Parser)((char *)sizeAndParser + sizeof(size_t)
++                            + EXPAT_MALLOC_PADDING);
+ #else
+     parser = memsuite->malloc_fcn(sizeof(struct XML_ParserStruct));
+     if (parser != NULL) {
+@@ -1244,11 +1252,12 @@ parserCreate(const XML_Char *encodingNam
+   } else {
+     XML_Memory_Handling_Suite *mtemp;
+ #if XML_GE == 1
+-    void *const sizeAndParser
+-        = (XML_Parser)malloc(sizeof(size_t) + sizeof(struct XML_ParserStruct));
++    void *const sizeAndParser = malloc(sizeof(size_t) + EXPAT_MALLOC_PADDING
++                                       + sizeof(struct XML_ParserStruct));
+     if (sizeAndParser != NULL) {
+       *(size_t *)sizeAndParser = sizeof(struct XML_ParserStruct);
+-      parser = (XML_Parser)((char *)sizeAndParser + sizeof(size_t));
++      parser = (XML_Parser)((char *)sizeAndParser + sizeof(size_t)
++                             + EXPAT_MALLOC_PADDING);
+ #else
+     parser = (XML_Parser)malloc(sizeof(struct XML_ParserStruct));
+     if (parser != NULL) {
diff --git a/meta-core/recipes-core/expat/expat/CVE-2025-59375-19.patch b/meta-core/recipes-core/expat/expat/CVE-2025-59375-19.patch
new file mode 100644
index 0000000..d16d935
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2025-59375-19.patch
@@ -0,0 +1,51 @@
+From 87321ac84a0d6cb42ee64a591adc79c1ec37fb5b Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Tue, 2 Sep 2025 20:52:29 +0200
+Subject: [PATCH] xmlwf: Mention supported environment variables in --help
+ output
+
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/87321ac84a0d6cb42ee64a591adc79c1ec37fb5b]
+
+CVE: CVE-2025-59375
+
+comment: refresh this patch according to source code.
+
+Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
+---
+diff --git a/xmlwf/xmlwf.c b/xmlwf/xmlwf.c
+index ec7e51c9a0..8cfc73caf0 100644
+--- a/xmlwf/xmlwf.c
++++ b/xmlwf/xmlwf.c
+@@ -918,6 +918,14 @@ usage(const XML_Char *prog, int rc) {
+       T("  -h            show this [h]elp message and exit\n")
+       T("  -v            show program's [v]ersion number and exit\n")
+       T("\n")
++      T("environment variables:\n")
++      T("  EXPAT_ACCOUNTING_DEBUG=(0|1|2|3)\n")
++      T("                 Control verbosity of accounting debugging (default: 0)\n")
++      T("  EXPAT_ENTITY_DEBUG=(0|1)\n")
++      T("                 Control verbosity of entity debugging (default: 0)\n")
++      T("  EXPAT_ENTROPY_DEBUG=(0|1)\n")
++      T("                 Control verbosity of entropy debugging (default: 0)\n")
++      T("\n")
+       T("exit status:\n")
+       T("  0             the input files are well-formed and the output (if requested) was written successfully\n")
+       T("  1             could not allocate data structures, signals a serious problem with execution environment\n")
+diff --git a/xmlwf/xmlwf_helpgen.py b/xmlwf/xmlwf_helpgen.py
+index c3257f0e7e..39a3dc13b8 100755
+--- a/xmlwf/xmlwf_helpgen.py
++++ b/xmlwf/xmlwf_helpgen.py
+@@ -32,6 +32,13 @@
+ import argparse
+
+ epilog = """
++environment variables:
++  EXPAT_ACCOUNTING_DEBUG=(0|1|2|3)
++                 Control verbosity of accounting debugging (default: 0)
++  EXPAT_ENTITY_DEBUG=(0|1)
++                 Control verbosity of entity debugging (default: 0)
++  EXPAT_ENTROPY_DEBUG=(0|1)
++                 Control verbosity of entropy debugging (default: 0)
+ exit status:
+   0             the input files are well-formed and the output (if requested) was written successfully
+   1             could not allocate data structures, signals a serious problem with execution environment
diff --git a/meta-core/recipes-core/expat/expat_%.bbappend b/meta-core/recipes-core/expat/expat_%.bbappend
new file mode 100644
index 0000000..4dbbc9f
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat_%.bbappend
@@ -0,0 +1,24 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
+
+SRC_URI:append = " \
+           file://CVE-2025-59375-01.patch \
+           file://CVE-2025-59375-02.patch \
+           file://CVE-2025-59375-03.patch \
+           file://CVE-2025-59375-04.patch \
+           file://CVE-2025-59375-05.patch \
+           file://CVE-2025-59375-06.patch \
+           file://CVE-2025-59375-07.patch \
+           file://CVE-2025-59375-08.patch \
+           file://CVE-2025-59375-09.patch \
+           file://CVE-2025-59375-10.patch \
+           file://CVE-2025-59375-11.patch \
+           file://CVE-2025-59375-12.patch \
+           file://CVE-2025-59375-13.patch \
+           file://CVE-2025-59375-14.patch \
+           file://CVE-2025-59375-15.patch \
+           file://CVE-2025-59375-16.patch \
+           file://CVE-2025-59375-17.patch \
+           file://CVE-2025-59375-18.patch \
+           file://CVE-2025-59375-19.patch \
+"
+
-- 
2.34.1


