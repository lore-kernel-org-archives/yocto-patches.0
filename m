Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4BFCFD2F6
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:43 +0000 (UTC)
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5043.1763941534115887875
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=h3SE9K2K;
 spf=pass (domain: konsulko.com, ip: 209.85.222.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b2dec4d115so378818785a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941533; x=1764546333; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEBT2Q1pXVhJBASg4K4wMWq31Pgk/8wzBRCs1mP/xEY=;
        b=h3SE9K2KoA6AY7K25CFMiq/gv2WoLzoX5bbrFhjL/vWVk4BYSRWevoteHIY1NNO96u
         YiQ18u13rTWMaVIFZDeM6OU/+A9CP+38IWpc//GFrJw30yDpR6bW/6euMukhA9kzuwlO
         eO0QFoXjScCihwl59So3A/NdiEwd8KRUEcB68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941533; x=1764546333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eEBT2Q1pXVhJBASg4K4wMWq31Pgk/8wzBRCs1mP/xEY=;
        b=TCW9QkloMtdFv7QbNCMhP24KQ/s2dhMaipkzauT5AeNv0HsuyT8vX2xUxyIhg/FHlX
         RfaBk1gq0F0a3rSUeMRpSF9zEefx1dHPefXFWtn2VTUNYv3ghky49ff859voNgSVlzzI
         spd6pSBCoa3gO+uM2FhbWH/iCsWUg4FENk/h5IjaItC3/pHjwflW2yv+PmLtCeCtQrJG
         sn4Ky3mlwnKoAGW4RakeDihHEpWBevFRpOa5EOytq+pFkHwilBxvvyY6Du+AP2ORURQ7
         G7I3AFzxkTZNAUZ1L5xt7dSestcBozF7fXMHksWPSJBFB1wDsqjkD2s+B6QkprZK//b8
         5Wkg==
X-Gm-Message-State: AOJu0YwAPb34oVaLiwMaNp0g5+7/st9jN7mWsb2RH7QaT0N5tRSsi3Lk
	bFnwbSliix4itUA7Ey9wcECDt08nbp2HwwykoeZX92WTRucTw6iysBD8/RHAVwhRnlT1MqDsZ82
	Jz3Ni
X-Gm-Gg: ASbGncvIeHgMH3TJPozJgs8TvSk6bIYA+WkiapTQHYbMZGm82NcuOSXT+4rQO2WHLI8
	oP9t0gIer2PcX/BGi4lyVKzHDbBRZpue9/Wc5C4m4tl/KlPtpgkwbzFUkpbJKgv3JCYpZOlSURw
	PUIMeaABXWlpGhz3xW7+3ymT1pzpk1+Ckdu2IW0UduekvMGaoFQaevEnnwUTt/fmpM8NljqptE0
	ICHkNnK+4FecfvUJcRQvGwMH2zdrzp0leSrVDb+KRvsHcIo9rEY2EsNuf9PpkNKGCiIkjXs+d5Z
	6YdRT+ojqTx/m/UfJk/yH3JwDUm1wdKiR4k+mg9Kuxp5c7OiMU22uXi5H2co06ZZT8plqsZCaXa
	NKbUTtvlL+zSzljHdtpQN2HFs3O6rhaRiqloC+P29W4XUq8zgTIJET2Dtb8xiOEENzVpmZGPUJ0
	9snNuZktUSiNz2NhBAE3z5ijSfx+t7gntX7LYRxC3T90G1icGAKLsRfskWqqVDyWY=
X-Google-Smtp-Source: AGHT+IFB+W9wDn7hi0EuvafAh6OpsHFfUZ1XGFKS2qpMOOs1bFJqgeuK48GrdGn9DNyL7GzHzK10uQ==
X-Received: by 2002:a05:620a:1a25:b0:8b1:f2cd:76ad with SMTP id af79cd13be357-8b33d5ffadamr1370962385a.89.1763941532720;
        Sun, 23 Nov 2025 15:45:32 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.31
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:32 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 16/32] suricata: Fix CVE-2024-55605
Date: Sun, 23 Nov 2025 18:44:56 -0500
Message-ID: <8477af51d60170ce783cc6db3c0040c29468e65f.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2674

From: Hitendra Prajapati <hprajapati@mvista.com>

Upstream-Status: Backport from https://github.com/OISF/suricata/commit/f80ebd5a30b02db5915f749f0c067c7adefbbe76 && https://github.com/OISF/suricata/commit/c3a6abf60134c2993ee3802ee52206e9fdbf55ba

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../suricata/files/CVE-2024-55605.patch       | 205 ++++++++++++++++++
 recipes-ids/suricata/suricata_7.0.0.bb        |   1 +
 2 files changed, 206 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2024-55605.patch

diff --git a/recipes-ids/suricata/files/CVE-2024-55605.patch b/recipes-ids/suricata/files/CVE-2024-55605.patch
new file mode 100644
index 0000000..c8bfead
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-55605.patch
@@ -0,0 +1,205 @@
+From f80ebd5a30b02db5915f749f0c067c7adefbbe76 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Thu, 7 Nov 2024 17:49:45 +0100
+Subject: [PATCH] detect/transforms: write directly in inspect buffer
+
+instead of writing to a temporary buffer and then copying,
+to save the cost of copying.
+
+Ticket: 7229
+
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/f80ebd5a30b02db5915f749f0c067c7adefbbe76 && https://github.com/OISF/suricata/commit/c3a6abf60134c2993ee3802ee52206e9fdbf55ba]
+CVE: CVE-2024-55605
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/detect-engine.c                        | 23 ++++++++++++++++++++--
+ src/detect-engine.h                        |  3 ++-
+ src/detect-transform-compress-whitespace.c |  8 ++++++--
+ src/detect-transform-dotprefix.c           | 10 +++++++---
+ src/detect-transform-strip-whitespace.c    |  8 ++++++--
+ src/detect-transform-urldecode.c           |  8 ++++++--
+ src/detect-transform-xor.c                 |  7 +++++--
+ 7 files changed, 53 insertions(+), 14 deletions(-)
+
+diff --git a/src/detect-engine.c b/src/detect-engine.c
+index 141b48a..cdb24d8 100644
+--- a/src/detect-engine.c
++++ b/src/detect-engine.c
+@@ -1647,11 +1647,13 @@ void InspectionBufferFree(InspectionBuffer *buffer)
+ /**
+  * \brief make sure that the buffer has at least 'min_size' bytes
+  * Expand the buffer if necessary
++ *
++ * \retval pointer to inner buffer to use, or NULL if realloc failed
+  */
+-void InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size)
++uint8_t *InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size)
+ {
+     if (likely(buffer->size >= min_size))
+-        return;
++        return buffer->buf;
+ 
+     uint32_t new_size = (buffer->size == 0) ? 4096 : buffer->size;
+     while (new_size < min_size) {
+@@ -1662,7 +1664,24 @@ void InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size)
+     if (ptr != NULL) {
+         buffer->buf = ptr;
+         buffer->size = new_size;
++    } else {
++        return NULL;
+     }
++    return buffer->buf;
++}
++
++/**
++ * \brief set inspect length of inspect buffer
++ * The inspect buffer may have been overallocated (by strip_whitespace for example)
++ * so, this sets the final length
++ */
++void InspectionBufferTruncate(InspectionBuffer *buffer, uint32_t buf_len)
++{
++    DEBUG_VALIDATE_BUG_ON(buffer->buf == NULL);
++    DEBUG_VALIDATE_BUG_ON(buf_len > buffer->size);
++    buffer->inspect = buffer->buf;
++    buffer->inspect_len = buf_len;
++    buffer->initialized = true;
+ }
+ 
+ void InspectionBufferCopy(InspectionBuffer *buffer, uint8_t *buf, uint32_t buf_len)
+diff --git a/src/detect-engine.h b/src/detect-engine.h
+index 7617e66..04713a7 100644
+--- a/src/detect-engine.h
++++ b/src/detect-engine.h
+@@ -31,7 +31,8 @@ void InspectionBufferInit(InspectionBuffer *buffer, uint32_t initial_size);
+ void InspectionBufferSetup(DetectEngineThreadCtx *det_ctx, const int list_id,
+         InspectionBuffer *buffer, const uint8_t *data, const uint32_t data_len);
+ void InspectionBufferFree(InspectionBuffer *buffer);
+-void InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size);
++uint8_t *InspectionBufferCheckAndExpand(InspectionBuffer *buffer, uint32_t min_size);
++void InspectionBufferTruncate(InspectionBuffer *buffer, uint32_t buf_len);
+ void InspectionBufferCopy(InspectionBuffer *buffer, uint8_t *buf, uint32_t buf_len);
+ void InspectionBufferApplyTransforms(InspectionBuffer *buffer,
+         const DetectEngineTransforms *transforms);
+diff --git a/src/detect-transform-compress-whitespace.c b/src/detect-transform-compress-whitespace.c
+index 5cbf0fd..cc78c7e 100644
+--- a/src/detect-transform-compress-whitespace.c
++++ b/src/detect-transform-compress-whitespace.c
+@@ -111,7 +111,11 @@ static void TransformCompressWhitespace(InspectionBuffer *buffer, void *options)
+         return;
+     }
+ 
+-    uint8_t output[input_len]; // we can only shrink
++    // we can only shrink
++    uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len);
++    if (output == NULL) {
++        return;
++    }
+     uint8_t *oi = output, *os = output;
+ 
+     //PrintRawDataFp(stdout, input, input_len);
+@@ -132,7 +136,7 @@ static void TransformCompressWhitespace(InspectionBuffer *buffer, void *options)
+     uint32_t output_size = oi - os;
+     //PrintRawDataFp(stdout, output, output_size);
+ 
+-    InspectionBufferCopy(buffer, os, output_size);
++    InspectionBufferTruncate(buffer, output_size);
+ }
+ 
+ #ifdef UNITTESTS
+diff --git a/src/detect-transform-dotprefix.c b/src/detect-transform-dotprefix.c
+index 52a2633..d58e1d4 100644
+--- a/src/detect-transform-dotprefix.c
++++ b/src/detect-transform-dotprefix.c
+@@ -110,11 +110,15 @@ static void TransformDotPrefix(InspectionBuffer *buffer, void *options)
+     const size_t input_len = buffer->inspect_len;
+ 
+     if (input_len) {
+-        uint8_t output[input_len + 1]; // For the leading '.'
++        // For the leading '.'
++        uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len + 1);
++        if (output == NULL) {
++            return;
++        }
+ 
++        memmove(&output[1], buffer->inspect, input_len);
+         output[0] = '.';
+-        memcpy(&output[1], buffer->inspect, input_len);
+-        InspectionBufferCopy(buffer, output, input_len + 1);
++        InspectionBufferTruncate(buffer, input_len + 1);
+     }
+ }
+ 
+diff --git a/src/detect-transform-strip-whitespace.c b/src/detect-transform-strip-whitespace.c
+index 32fb96f..6040592 100644
+--- a/src/detect-transform-strip-whitespace.c
++++ b/src/detect-transform-strip-whitespace.c
+@@ -106,7 +106,11 @@ static void TransformStripWhitespace(InspectionBuffer *buffer, void *options)
+     if (input_len == 0) {
+         return;
+     }
+-    uint8_t output[input_len]; // we can only shrink
++    // we can only shrink
++    uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len);
++    if (output == NULL) {
++        return;
++    }
+     uint8_t *oi = output, *os = output;
+ 
+     //PrintRawDataFp(stdout, input, input_len);
+@@ -119,7 +123,7 @@ static void TransformStripWhitespace(InspectionBuffer *buffer, void *options)
+     uint32_t output_size = oi - os;
+     //PrintRawDataFp(stdout, output, output_size);
+ 
+-    InspectionBufferCopy(buffer, os, output_size);
++    InspectionBufferTruncate(buffer, output_size);
+ }
+ 
+ #ifdef UNITTESTS
+diff --git a/src/detect-transform-urldecode.c b/src/detect-transform-urldecode.c
+index 13ef033..a4e9655 100644
+--- a/src/detect-transform-urldecode.c
++++ b/src/detect-transform-urldecode.c
+@@ -125,12 +125,16 @@ static void TransformUrlDecode(InspectionBuffer *buffer, void *options)
+     if (input_len == 0) {
+         return;
+     }
+-    uint8_t output[input_len]; // we can only shrink
++    // we can only shrink
++    uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len);
++    if (output == NULL) {
++        return;
++    }
+ 
+     changed = BufferUrlDecode(input, input_len, output, &output_size);
+ 
+     if (changed) {
+-        InspectionBufferCopy(buffer, output, output_size);
++        InspectionBufferTruncate(buffer, output_size);
+     }
+ }
+ 
+diff --git a/src/detect-transform-xor.c b/src/detect-transform-xor.c
+index e42700f..18f96df 100644
+--- a/src/detect-transform-xor.c
++++ b/src/detect-transform-xor.c
+@@ -133,12 +133,15 @@ static void DetectTransformXor(InspectionBuffer *buffer, void *options)
+     if (input_len == 0) {
+         return;
+     }
+-    uint8_t output[input_len];
++    uint8_t *output = InspectionBufferCheckAndExpand(buffer, input_len);
++    if (output == NULL) {
++        return;
++    }
+ 
+     for (uint32_t i = 0; i < input_len; i++) {
+         output[i] = input[i] ^ pxd->key[i % pxd->length];
+     }
+-    InspectionBufferCopy(buffer, output, input_len);
++    InspectionBufferTruncate(buffer, input_len);
+ }
+ 
+ #ifdef UNITTESTS
+-- 
+2.25.1
+
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index e5d6ed1..1cb02f4 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -18,6 +18,7 @@ SRC_URI += " \
     file://fixup.patch \
     file://CVE-2024-45795.patch \
     file://CVE-2024-45796.patch \
+    file://CVE-2024-55605.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
-- 
2.47.3


