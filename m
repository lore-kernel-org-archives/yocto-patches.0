Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4205CCD98F6
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 05:45:08 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36871.1782107099662198797
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 21 Jun 2026 22:44:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=BiqHS8wN;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3535588b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 21 Jun 2026 22:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782107099; x=1782711899; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgBAnvrBYMA4b8DVpT5EE/54WyuVY/ppy6NqPjhicoM=;
        b=BiqHS8wNWAltGifAvW9bi5ZNPasofVuuA7TP1w6lT0dLsfvUxHZA3OikTf1P9mfsSS
         PrPEgG7APSKj9ISNIkDWzJ1guCXqhsLcxJihkw6zuNAqK5Xzjo0qgTOsDYmD0sDpoG/Y
         D48b8dncoDkVY+doJHynqag+cqVZ5OCRC3t9/fVGcRH/zseJC/3RfB2adC+ZiX0UCsx+
         3/v8FhpkBzhNlLWZYujHk6gfzFIiTRrSmXR54raESIUWNdejbLfHQKDs3kn4JZh6unpz
         jmSP8hNBcNnqWiIjdJpOi1KODe5v+lmYPm2833JzEId8sXUSAEhodLERgTwIsJAkWHt+
         VUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782107099; x=1782711899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgBAnvrBYMA4b8DVpT5EE/54WyuVY/ppy6NqPjhicoM=;
        b=LzkwqSZ0L/uVD0mYuUNLhRuRGrKKX0ueVb0OFXWCnoQmyiaz3tBsfQ9nsVw7FzfgKp
         wos85aZpBds3oq/IGWyrCptvA83HWvKVOvxib+90lRJc01NREi4LejVbZjDXB8uAnSV1
         dTP5K71Q50f8ibZ2WiBOtNmedXygQ56RvxgMf/r8s7hr9lKQP5Khpkj/ZaxDHlWxEvR4
         12v6PfJPinb+2ECf2Uyr2S50R8LOOVdCT/ltcXGFkTeg27hMl5AJUBafRAxrUJPudyVN
         fIdha2EjznWbGAXEXBbQEGwI29jG+dPRYsMmS8i0gUiikMRFWegIsEgFmwADzMF/rZkM
         ApUg==
X-Gm-Message-State: AOJu0YyTtnZxc/y0S5PWHkDbnRhbpFoylE6gsyj17AiZuz4o2Fi9McZg
	tXLZNBzdv0Uhh1BdT2MTeyoYToKbRgoAFFsPGGW4Mz0jYo7NeUOXyNF6A4EPvA==
X-Gm-Gg: AfdE7cnBUZ6U2Ab0VzQC4yd9DDHqJkXvLU2kGBvOgUNi/eM73tjTYVZbXz380WaZ9Wd
	kThvPIh2MUBl+Xfcl6SWYaFVGy5/4yQ/wm0hTZ8jnIF9Hl+QkJYmNQn3ULUua5nncZ02qDyRQl4
	sUElynHUU/3lKOYK52RTXoaHOZVlZ2SLXVT2yAcSsYAi204ugZ3R0YUCxGtqyJut6+pgh28NMdU
	aMS8DJr/j0RqIp4ulyKnNQvYHr7H0I87tU8X/C7rCpTD/vItcbgDZPZ8LGrpMISL0Ysk7i5NN+g
	kF/37SAlmsWayocrCqZpWsB1gBkGaTAhtQMg3sjztDCmaLACUS6Vwd7TCF/cUppDJzwisDjRBqs
	s9gBsRkDPWttroRS0HgH/0BiG2LbkCOaGrjLZunkeeZzP8YJbeS1uvsk3D2qq//62LuMdLG+wmI
	Z3OL2kmMkytDW0rPC4
X-Received: by 2002:a05:6a00:908e:b0:842:614e:cc94 with SMTP id d2e1a72fcca58-8455086655bmr13929302b3a.26.1782107098447;
        Sun, 21 Jun 2026 22:44:58 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.129.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ef4c09sm6776525b3a.61.2026.06.21.22.44.56
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:44:57 -0700 (PDT)
From: Jackson James <jackson.james9803@gmail.com>
X-Google-Original-From: Jackson James <jacksonj2@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-collab][kirkstone][PATCH] expat: Fix CVEs
Date: Mon, 22 Jun 2026 11:14:25 +0530
Message-Id: <20260622054426.225089-1-jacksonj2@kpit.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 05:45:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4255

Fix the following CVEs-
CVE-2026-32776 CVE-2026-32777 CVE-2026-32778

Signed-off-by: Jackson James <jacksonj2@kpit.com>
---
 .../expat/expat/CVE-2026-32776.patch          | 51 +++++++++++
 .../expat/expat/CVE-2026-32777.patch          | 48 ++++++++++
 .../expat/expat/CVE-2026-32778.patch          | 91 +++++++++++++++++++
 meta-core/recipes-core/expat/expat_%.bbappend |  7 ++
 4 files changed, 197 insertions(+)
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2026-32776.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2026-32777.patch
 create mode 100644 meta-core/recipes-core/expat/expat/CVE-2026-32778.patch
 create mode 100644 meta-core/recipes-core/expat/expat_%.bbappend

diff --git a/meta-core/recipes-core/expat/expat/CVE-2026-32776.patch b/meta-core/recipes-core/expat/expat/CVE-2026-32776.patch
new file mode 100644
index 0000000..0b96fbc
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2026-32776.patch
@@ -0,0 +1,51 @@
+From 5be25657583ea91b09025c858b4785834c20f59c Mon Sep 17 00:00:00 2001
+From: Francesco Bertolaccini <francesco.bertolaccini@trailofbits.com>
+Date: Tue, 3 Mar 2026 16:41:43 +0100
+Subject: [PATCH] Fix NULL function-pointer dereference for empty external
+ parameter entities
+
+When an external parameter entity with empty text is referenced inside
+an entity declaration value, the sub-parser created to handle it receives
+0 bytes of input.  Processing enters entityValueInitProcessor which calls
+storeEntityValue() with the parser's encoding; since no bytes were ever
+processed, encoding detection has not yet occurred and the encoding is
+still the initial probing encoding set up by XmlInitEncoding().  That
+encoding only populates scanners[] (for prolog and content), not
+literalScanners[].  XmlEntityValueTok() calls through
+literalScanners[XML_ENTITY_VALUE_LITERAL] which is NULL, causing a
+SEGV.
+
+Skip the tokenization loop entirely when entityTextPtr >= entityTextEnd,
+and initialize the `next` pointer before the early exit so that callers
+(callStoreEntityValue) receive a valid value through nextPtr.
+
+CVE: CVE-2026-32776
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/5be25657583ea91b09025c858b4785834c20f59c]
+
+Comment: Patch is refreshed as per codebase of 2.5.0
+Signed-off-by: Jackson James <jacksonj2@kpit.com>
+---
+ lib/xmlparse.c | 7 +++++++
+ 1 file changed, 7 insertions(+)
+
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 0883e2e..6a9ab7d 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -6194,6 +6194,13 @@ storeEntityValue(XML_Parser parser, const ENCODING *enc,
+   for (;;) {
+     const char *next
+         = entityTextPtr; /* XmlEntityValueTok doesn't always set the last arg */
++
++    /* Nothing to tokenize. */
++    if (entityTextPtr >= entityTextEnd) {
++        result = XML_ERROR_NONE;
++        goto endEntityValue;
++    }
++    
+     int tok = XmlEntityValueTok(enc, entityTextPtr, entityTextEnd, &next);
+ 
+     if (! accountingDiffTolerated(parser, tok, entityTextPtr, next, __LINE__,
+-- 
+2.34.1
+
diff --git a/meta-core/recipes-core/expat/expat/CVE-2026-32777.patch b/meta-core/recipes-core/expat/expat/CVE-2026-32777.patch
new file mode 100644
index 0000000..687e2e4
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2026-32777.patch
@@ -0,0 +1,48 @@
+From 55cda8c7125986e17d7e1825cba413bd94a35d02 Mon Sep 17 00:00:00 2001
+From: Sebastian Pipping <sebastian@pipping.org>
+Date: Sun, 1 Mar 2026 20:16:13 +0100
+Subject: [PATCH] lib: Reject XML_TOK_INSTANCE_START infinite loop in
+ entityValueProcessor
+
+.. that OSS-Fuzz/ClusterFuzz uncovered
+
+CVE: CVE-2026-32777
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/55cda8c7125986e17d7e1825cba413bd94a35d02]
+
+Comment: Patch is refreshed as per codebase of 2.5.0
+Signed-off-by: Jackson James <jacksonj2@kpit.com>
+---
+ lib/xmlparse.c | 10 +++++++++-
+ 1 file changed, 9 insertions(+), 1 deletion(-)
+
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index 6a9ab7d..c7e3665 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -4560,7 +4560,7 @@ entityValueInitProcessor(XML_Parser parser, const char *s, const char *end,
+     }
+     /* If we get this token, we have the start of what might be a
+        normal tag, but not a declaration (i.e. it doesn't begin with
+-       "<!").  In a DTD context, that isn't legal.
++       "<!" or "<?").  In a DTD context, that isn't legal.
+     */
+     else if (tok == XML_TOK_INSTANCE_START) {
+       *nextPtr = next;
+@@ -4649,6 +4649,14 @@ entityValueProcessor(XML_Parser parser, const char *s, const char *end,
+       /* found end of entity value - can store it now */
+       return storeEntityValue(parser, enc, s, end, XML_ACCOUNT_DIRECT);
+     }
++    /* If we get this token, we have the start of what might be a
++       normal tag, but not a declaration (i.e. it doesn't begin with
++       "<!" or "<?").  In a DTD context, that isn't legal.
++    */
++    else if (tok == XML_TOK_INSTANCE_START) {
++      *nextPtr = next;
++      return XML_ERROR_SYNTAX;
++    }
+     start = next;
+   }
+ }
+-- 
+2.34.1
+
diff --git a/meta-core/recipes-core/expat/expat/CVE-2026-32778.patch b/meta-core/recipes-core/expat/expat/CVE-2026-32778.patch
new file mode 100644
index 0000000..fb2d021
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat/CVE-2026-32778.patch
@@ -0,0 +1,91 @@
+From 576b61e42feeea704253cb7c7bedb2eeb3754387 Mon Sep 17 00:00:00 2001
+From: laserbear <10689391+Laserbear@users.noreply.github.com>
+Date: Sun, 8 Mar 2026 17:28:06 -0700
+Subject: [PATCH] copy prefix name to pool before lookup
+
+.. so that we cannot end up with a zombie PREFIX in the pool
+that has NULL for a name.
+
+Co-authored-by: Sebastian Pipping <sebastian@pipping.org>
+
+CVE: CVE-2026-32778
+Upstream-Status: Backport [https://github.com/libexpat/libexpat/commit/576b61e42feeea704253cb7c7bedb2eeb3754387]
+
+Comment: Patch is refreshed as per codebase of 2.5.0
+Signed-off-by: Jackson James <jacksonj2@kpit.com>
+---
+ lib/xmlparse.c | 42 ++++++++++++++++++++++++++++++++++--------
+ 1 file changed, 34 insertions(+), 8 deletions(-)
+
+diff --git a/lib/xmlparse.c b/lib/xmlparse.c
+index c7e3665..7579a1d 100644
+--- a/lib/xmlparse.c
++++ b/lib/xmlparse.c
+@@ -556,6 +556,8 @@ static XML_Char *poolStoreString(STRING_POOL *pool, const ENCODING *enc,
+ static XML_Bool FASTCALL poolGrow(STRING_POOL *pool);
+ static const XML_Char *FASTCALL poolCopyString(STRING_POOL *pool,
+                                                const XML_Char *s);
++static const XML_Char *FASTCALL poolCopyStringNoFinish(STRING_POOL *pool,
++                                                       const XML_Char *s);
+ static const XML_Char *poolCopyStringN(STRING_POOL *pool, const XML_Char *s,
+                                        int n);
+ static const XML_Char *FASTCALL poolAppendString(STRING_POOL *pool,
+@@ -6783,16 +6785,23 @@ setContext(XML_Parser parser, const XML_Char *context) {
+       else {
+         if (! poolAppendChar(&parser->m_tempPool, XML_T('\0')))
+           return XML_FALSE;
+-        prefix
+-            = (PREFIX *)lookup(parser, &dtd->prefixes,
+-                               poolStart(&parser->m_tempPool), sizeof(PREFIX));
+-        if (! prefix)
++        const XML_Char *const prefixName = poolCopyStringNoFinish(
++            &dtd->pool, poolStart(&parser->m_tempPool));
++        if (! prefixName) {
+           return XML_FALSE;
+-        if (prefix->name == poolStart(&parser->m_tempPool)) {
+-          prefix->name = poolCopyString(&dtd->pool, prefix->name);
+-          if (! prefix->name)
+-            return XML_FALSE;
+         }
++
++        prefix = (PREFIX *)lookup(parser, &dtd->prefixes, prefixName,
++                                  sizeof(PREFIX));
++
++        const bool prefixNameUsed = prefix && prefix->name == prefixName;
++        if (prefixNameUsed)
++          poolFinish(&dtd->pool);
++        else
++          poolDiscard(&dtd->pool);
++
++        if (! prefix)
++          return XML_FALSE;
+         poolDiscard(&parser->m_tempPool);
+       }
+       for (context = s + 1; *context != CONTEXT_SEP && *context != XML_T('\0');
+@@ -7381,6 +7390,23 @@ poolCopyString(STRING_POOL *pool, const XML_Char *s) {
+   return s;
+ }
+ 
++// A version of `poolCopyString` that does not call `poolFinish`
++// and reverts any partial advancement upon failure.
++static const XML_Char *FASTCALL
++poolCopyStringNoFinish(STRING_POOL *pool, const XML_Char *s) {
++  const XML_Char *const original = s;
++  do {
++    if (! poolAppendChar(pool, *s)) {
++      // Revert any previously successful advancement
++      const ptrdiff_t advancedBy = s - original;
++      if (advancedBy > 0)
++        pool->ptr -= advancedBy;
++      return NULL;
++    }
++  } while (*s++);
++  return pool->start;
++}
++
+ static const XML_Char *
+ poolCopyStringN(STRING_POOL *pool, const XML_Char *s, int n) {
+   if (! pool->ptr && ! poolGrow(pool)) {
+-- 
+2.34.1
+
diff --git a/meta-core/recipes-core/expat/expat_%.bbappend b/meta-core/recipes-core/expat/expat_%.bbappend
new file mode 100644
index 0000000..0a11912
--- /dev/null
+++ b/meta-core/recipes-core/expat/expat_%.bbappend
@@ -0,0 +1,7 @@
+FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
+
+SRC_URI:append = " \
+           file://CVE-2026-32776.patch \
+           file://CVE-2026-32777.patch \
+           file://CVE-2026-32778.patch \
+"
-- 
2.34.1


