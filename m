Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153EC36014
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 08:48:11 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web11.14391.1743497285690191218
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 01 Apr 2025 01:48:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=XU0Tud7M;
 spf=pass (domain: mvista.com, ip: 209.85.214.169, mailfrom: hprajapati@mvista.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22401f4d35aso103329795ad.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 01 Apr 2025 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1743497285; x=1744102085; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RmAYeoaY9i77h1rLHU9daCA9iUfUg0VbEZzbVU2hxU4=;
        b=XU0Tud7MS7ZYPAI7ZeE272s46oGJ9HLR/EibrrTpoTOMnC3y1CPrKgYwTn1UvicNuD
         NNhQdQlZvKd4L9kSpt1jG+0gKyXYVnWf7dVhtTR65KMSDHOeRiTEjcmhsuibr84bcj+s
         vMQMUbwqcEZQEMN22wyavuRb6zexwUodA4tQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743497285; x=1744102085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmAYeoaY9i77h1rLHU9daCA9iUfUg0VbEZzbVU2hxU4=;
        b=V2vNm9mjKwedMH3tQgfRcTaHDN1Raov+9Xokedv5F2TBqsZK9is/RzarsHwBpXiA/H
         Xlvaq1c4t8zkAO2XyyIbsC7h5EvKgCNjLB3wMlV+LIo/XVh+nu98i11rITLAS1SildzG
         FIj/GLrOL2hEcFT+QUlncABnZRNqq3yZx1YfSA1UVlofM9CdpR9/GYc/ZY9h3WgITx/J
         KJNgKeWzAK2GWApROs6Na7zJ1xX+KTDTux/GTOJrmXG4MHXJGZBk2S54N6gXlmW1Z+uc
         sgYgxa9bqwDLYXTtcypmCMnFy7y/5XBEAHAtKwXui0YUcXtlpwCBiqfz5unPE82F2tow
         7sKw==
X-Gm-Message-State: AOJu0YwKQrw3+l1xbmFlpmdFzpkt8HRENCbcr3uh65LEdqf0a3rWsgju
	2a/iqyHba/47mAPQE2btY1YB2YAosVLaBSeuWoPvdFUv2QEBCJDgurbAZZSgJj8h9lCJ/lupFzs
	H
X-Gm-Gg: ASbGncsacfv3AyrtCYeNjq+suLKS0jAiVSX9tjOr0Hbto0wqreDRH+VaVXCNOYNEijH
	CxOqGfUJqbn37cnqlSH8hKHZQziU4LGEkSudoD1nu4VEHj2zocW28dImv6VL39KdgzaRrmMZL2m
	dR/WRijUvbV9ML+Hf3179LHoqXj8FCsB47RyhKmbqFOoIJ7uKbdV33ngEbrhOs4K2FQK7b05xTe
	Qxmc9e9LUSzAln1viPy1KeT6Bhiq+aIpmUKOGrhjJIo8r5RsoULxYJcWOjttY33oqFh6zqY4gd0
	LmV2zzEATS6ghslhkFwLoEbnFjj1hqbVFRDsSfUG1JXWfAGi3Rag5VvF+k8=
X-Google-Smtp-Source: AGHT+IGHguZ+B2jSGPXZTN3XXtwLwnxyvYX+KoGLbmcT5Zp2IElQGOqZKT8vv658zyg3X8OCGS7naw==
X-Received: by 2002:a17:903:1c7:b0:224:78e:4ebe with SMTP id d9443c01a7336-2292f9e62cbmr173592275ad.33.1743497284768;
        Tue, 01 Apr 2025 01:48:04 -0700 (PDT)
Received: from MVIN00016.mvista.com ([150.129.170.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1deeaasm82753195ad.177.2025.04.01.01.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:48:04 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] suricata: Fix CVE-2024-55605
Date: Tue,  1 Apr 2025 14:17:43 +0530
Message-Id: <20250401084743.77141-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 01 Apr 2025 08:48:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1273

Upstream-Status: Backport from https://github.com/OISF/suricata/commit/f80ebd5a30b02db5915f749f0c067c7adefbbe76 && https://github.com/OISF/suricata/commit/c3a6abf60134c2993ee3802ee52206e9fdbf55ba

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
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
2.25.1


