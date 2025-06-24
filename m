Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F6AC7EE2A
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 07:57:36 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.3305.1750751850867359396
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Jun 2025 00:57:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=kdPeGG8n;
 spf=pass (domain: mvista.com, ip: 209.85.210.177, mailfrom: hprajapati@mvista.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c7a52e97so148826b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Jun 2025 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1750751850; x=1751356650; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCUYLCqWQ2Ob7sQnAPknmGDNVOug6W8KZQ2nZ0xWvLE=;
        b=kdPeGG8n4nydH0wNUijrZwCSgo2BmABlsou61dcdnjx8mk17hADtkUatPqB0O4ntvP
         vLSW7ZWiFaSOHu2G9A+OiT3l0+rjnBWbVPYsaXTjrzhPYrqQoqMrazIBGf0WcXyd1RTd
         Y+qiBZ3zPLZpevnfX15dKer5UILvGRv+yJNlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750751850; x=1751356650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCUYLCqWQ2Ob7sQnAPknmGDNVOug6W8KZQ2nZ0xWvLE=;
        b=FfNPsZYXTW9Ip8Ljme/fMy7NB4c5t/MwS7qg8W9yzbbcL2bt9iBuS08wv9xCjD2rxt
         RgMLD1QwzvD9AwX/4kydYYs05XnqegvZ4A/xA8NQTXDnrxzGD5JQPF9WRn5XyyCjkAW/
         i7G7CR3EvYg/CyAI8QOD9u3zSCK/Xfg2l/f5GgvwwDyogvUUfWuwEI99urveAtHOvNbh
         Nhbiz9NcnR16aAU3gdtws+kxadfCEjOn7EvpKa7c725heN1oA+5Q6dccUkkmJJTRc8lA
         Cboao6KJGAiMIvCKcaXsVoQSfhmPGcwovBsUVsLLjGvgLIkCYd8xtSa5L9i3aHScnk8s
         i4Xw==
X-Gm-Message-State: AOJu0YwJW0uWo6DENqh5Ew9sps65CubGzaCPShD9D4BZYvcQg+98kV0W
	daPTChT4icJ2WAYisi9y1qQI4q/YxioX3aP2yWn8WI01+6pQ3cr51aLQe9uX6Y+XqFrIXlJpW53
	cESvr
X-Gm-Gg: ASbGncs4PYG+DwSN1qV6XHGxuJ+KhkPntNZknsTF40cMpccaFpYkSF+AgpZVhvegVLs
	BH6XKwq15nPaQ2XkaY5qKTqG/eSVipcx419cXgsTQhZbg1IcmjLCEwlEwnQ64+lKLeTtzhbrafn
	sl1tyksb+bCFPeTi/gmj+XeyjT5DSfsXbxu/tQFFELEB9vIDH+GwwFU7dW5XQuF/58vEuOuZzOJ
	8xOq29Z7CGweJle8L1585IRyBhqdcFJLnzNqdMruhUIDqJp9S54cbJTS1Oudv/0BTV5lFb5GU7f
	qFwwI3AFAjt2HdxWYPlorkIi6K2bIuBeYNUodmV8zfOXJEpQ4r2oagH0PlEObBpqnlIIe/tbkw=
	=
X-Google-Smtp-Source: AGHT+IH5FC4zD9NHn8dJDV7K4U/ZHdqALDgBrEkCfBy17s/K5GpLxY2jB0FvDPGGLbFmD8zAtYg0Ww==
X-Received: by 2002:a05:6a00:928c:b0:748:fcfa:8bd5 with SMTP id d2e1a72fcca58-7490d74e2c9mr25155382b3a.3.1750751849980;
        Tue, 24 Jun 2025 00:57:29 -0700 (PDT)
Received: from MVIN00016.mvista.com ([27.121.101.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e08e47sm1158783b3a.11.2025.06.24.00.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 00:57:29 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] clamav: fix CVE-2025-20260
Date: Tue, 24 Jun 2025 13:27:05 +0530
Message-ID: <20250624075705.75694-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 24 Jun 2025 07:57:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1681

Upstream-Status: Backport https://github.com/Cisco-Talos/clamav/commit/7fe290b573db66ffcf590902977b2b6043b30834

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 recipes-scanners/clamav/clamav_0.104.4.bb     |   1 +
 .../clamav/files/CVE-2025-20260.patch         | 366 ++++++++++++++++++
 2 files changed, 367 insertions(+)
 create mode 100644 recipes-scanners/clamav/files/CVE-2025-20260.patch

diff --git a/recipes-scanners/clamav/clamav_0.104.4.bb b/recipes-scanners/clamav/clamav_0.104.4.bb
index d7beade..0bd776c 100644
--- a/recipes-scanners/clamav/clamav_0.104.4.bb
+++ b/recipes-scanners/clamav/clamav_0.104.4.bb
@@ -22,6 +22,7 @@ SRC_URI = "git://github.com/Cisco-Talos/clamav;branch=rel/0.104;protocol=https \
     file://oe_cmake_fixup.patch \
     file://CVE-2024-20505.patch \
     file://CVE-2024-20506.patch \
+    file://CVE-2025-20260.patch \
 "
 S = "${WORKDIR}/git"
 
diff --git a/recipes-scanners/clamav/files/CVE-2025-20260.patch b/recipes-scanners/clamav/files/CVE-2025-20260.patch
new file mode 100644
index 0000000..6177d4b
--- /dev/null
+++ b/recipes-scanners/clamav/files/CVE-2025-20260.patch
@@ -0,0 +1,366 @@
+From 7fe290b573db66ffcf590902977b2b6043b30834 Mon Sep 17 00:00:00 2001
+From: John Humlick <15677335+jhumlick@users.noreply.github.com>
+Date: Mon, 21 Apr 2025 16:18:07 -0700
+Subject: [PATCH] Fix integer overflow in PDF parser
+
+The ascii85decode function calculates the amount of memory to reserve as
+a function of (4 * bytes) + 1. Since the result is stored in a uint32_t,
+we need to make sure that this calculation will not overflow. If we
+detect that an overflow would occur, return CL_EFORMAT and do not
+proceed.
+
+Also check additional potential overflow conditions.
+Other areas were identified that could potentially overflow.
+This commit adds additional checks to prevent said overflows.
+
+Thank you Greg Walkup at Sandia National Labs for reporting this issue.
+
+CLAM-2752
+CLAM-2757
+CLAM-2759
+
+Upstream-Status: Backport [https://github.com/Cisco-Talos/clamav/commit/7fe290b573db66ffcf590902977b2b6043b30834]
+CVE: CVE-2025-20260
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ libclamav/pdf.c       | 42 +++++++++++------------
+ libclamav/pdf.h       | 16 ++++-----
+ libclamav/pdfdecode.c | 80 +++++++++++++++++++++++++++++++------------
+ 3 files changed, 87 insertions(+), 51 deletions(-)
+
+diff --git a/libclamav/pdf.c b/libclamav/pdf.c
+index 40eea19eb..a305b1701 100644
+--- a/libclamav/pdf.c
++++ b/libclamav/pdf.c
+@@ -441,7 +441,7 @@ int pdf_findobj_in_objstm(struct pdf_struct *pdf, struct objstm_struct *objstm,
+ 
+         if (CL_SUCCESS != cli_strntol_wrap(index, bytes_remaining, 0, 10, &temp_long)) {
+             /* Failed to find obj offset for next obj */
+-            cli_dbgmsg("pdf_findobj_in_objstm: Failed to find next obj offset for obj in object stream though there should be {%u} more.\n", objstm->n - objstm->nobjs_found);
++            cli_dbgmsg("pdf_findobj_in_objstm: Failed to find next obj offset for obj in object stream though there should be {%zu} more.\n", objstm->n - objstm->nobjs_found);
+             status = CL_EPARSE;
+             goto done;
+         } else if (temp_long < 0) {
+@@ -1551,18 +1551,18 @@ cl_error_t pdf_extract_obj(struct pdf_struct *pdf, struct pdf_obj *obj, uint32_t
+                 }
+             }
+ 
+-            cli_dbgmsg("pdf_extract_obj: calculated length %lld\n", (long long)length);
++            cli_dbgmsg("pdf_extract_obj: calculated length %zu\n", length);
+         } else {
+             if (obj->stream_size > (size_t)length + 2) {
+                 cli_dbgmsg("cli_pdf: calculated length %zu < %zu\n",
+-                           (size_t)length, obj->stream_size);
++                           length, obj->stream_size);
+                 length = obj->stream_size;
+             }
+         }
+ 
+-        if ((0 != orig_length) && (obj->stream_size > (size_t)orig_length + 20)) {
+-            cli_dbgmsg("pdf_extract_obj: orig length: %lld, length: %lld, size: %zu\n",
+-                       (long long)orig_length, (long long)length, obj->stream_size);
++        if ((0 != orig_length) && (obj->stream_size > orig_length + 20)) {
++            cli_dbgmsg("pdf_extract_obj: orig length: %zu, length: %zu, size: %zu\n",
++                       orig_length, length, obj->stream_size);
+             pdfobj_flag(pdf, obj, BAD_STREAMLEN);
+         }
+ 
+@@ -1613,18 +1613,18 @@ cl_error_t pdf_extract_obj(struct pdf_struct *pdf, struct pdf_obj *obj, uint32_t
+          */
+         dict_len = obj->stream - start;
+         if (NULL != (pstr = pdf_getdict(start, &dict_len, "/Type/ObjStm"))) {
+-            int32_t objstm_first  = -1;
+-            int32_t objstm_length = -1;
+-            int32_t objstm_n      = -1;
++            int objstm_first  = -1;
++            int objstm_length = -1;
++            int objstm_n      = -1;
+ 
+             cli_dbgmsg("pdf_extract_obj: Found /Type/ObjStm\n");
+ 
+             dict_len = obj->stream - start;
+-            if ((-1 == (objstm_first = pdf_readint(start, dict_len, "/First")))) {
++            if (-1 == (objstm_first = pdf_readint(start, dict_len, "/First"))) {
+                 cli_warnmsg("pdf_extract_obj: Failed to find offset of first object in object stream\n");
+-            } else if ((-1 == (objstm_length = pdf_readint(start, dict_len, "/Length")))) {
++            } else if (-1 == (objstm_length = pdf_readint(start, dict_len, "/Length"))) {
+                 cli_warnmsg("pdf_extract_obj: Failed to find length of object stream\n");
+-            } else if ((-1 == (objstm_n = pdf_readint(start, dict_len, "/N")))) {
++            } else if (-1 == (objstm_n = pdf_readint(start, dict_len, "/N"))) {
+                 cli_warnmsg("pdf_extract_obj: Failed to find num objects in object stream\n");
+             } else {
+                 /* Add objstm to pdf struct, so it can be freed eventually */
+@@ -1646,19 +1646,19 @@ cl_error_t pdf_extract_obj(struct pdf_struct *pdf, struct pdf_obj *obj, uint32_t
+ 
+                 memset(objstm, 0, sizeof(*objstm));
+ 
+-                objstm->first        = (uint32_t)objstm_first;
+-                objstm->current      = (uint32_t)objstm_first;
++                objstm->first        = (size_t)objstm_first;
++                objstm->current      = (size_t)objstm_first;
+                 objstm->current_pair = 0;
+-                objstm->length       = (uint32_t)objstm_length;
+-                objstm->n            = (uint32_t)objstm_n;
++                objstm->length       = (size_t)objstm_length;
++                objstm->n            = (size_t)objstm_n;
+ 
+-                cli_dbgmsg("pdf_extract_obj: ObjStm first obj at offset %d\n", objstm->first);
+-                cli_dbgmsg("pdf_extract_obj: ObjStm length is %d bytes\n", objstm->length);
+-                cli_dbgmsg("pdf_extract_obj: ObjStm should contain %d objects\n", objstm->n);
++                cli_dbgmsg("pdf_extract_obj: ObjStm first obj at offset %zu\n", objstm->first);
++                cli_dbgmsg("pdf_extract_obj: ObjStm length is %zu bytes\n", objstm->length);
++                cli_dbgmsg("pdf_extract_obj: ObjStm should contain %zu objects\n", objstm->n);
+             }
+         }
+ 
+-        sum = pdf_decodestream(pdf, obj, dparams, obj->stream, (uint32_t)length, xref, fout, &rc, objstm);
++        sum = pdf_decodestream(pdf, obj, dparams, obj->stream, length, xref, fout, &rc, objstm);
+         if ((CL_SUCCESS != rc) && (CL_VIRUS != rc)) {
+             cli_dbgmsg("Error decoding stream! Error code: %d\n", rc);
+ 
+@@ -3341,7 +3341,7 @@ cl_error_t pdf_find_and_parse_objs_in_objstm(struct pdf_struct *pdf, struct objs
+         retval = pdf_findobj_in_objstm(pdf, objstm, &obj);
+         if (retval != CL_SUCCESS) {
+             if (retval != CL_BREAK) {
+-                cli_dbgmsg("pdf_find_and_parse_objs_in_objstm: Fewer objects in stream than expected: %u found, %u expected.\n",
++                cli_dbgmsg("pdf_find_and_parse_objs_in_objstm: Fewer objects in stream than expected: %zu found, %zu expected.\n",
+                            objstm->nobjs_found, objstm->n);
+                 badobjects++;
+                 pdf->stats.ninvalidobjs++;
+diff --git a/libclamav/pdf.h b/libclamav/pdf.h
+index 3a03f19f1..b5b69cec7 100644
+--- a/libclamav/pdf.h
++++ b/libclamav/pdf.h
+@@ -25,14 +25,14 @@
+ #define PDF_FILTERLIST_MAX 64
+ 
+ struct objstm_struct {
+-    uint32_t first;        // offset of first obj
+-    uint32_t current;      // offset of current obj
+-    uint32_t current_pair; // offset of current pair describing id, location of object
+-    uint32_t length;       // total length of all objects (starting at first)
+-    uint32_t n;            // number of objects that should be found in the object stream
+-    uint32_t nobjs_found;  // number of objects actually found in the object stream
+-    char *streambuf;       // address of stream buffer, beginning with first obj pair
+-    size_t streambuf_len;  // length of stream buffer, includes pairs followed by actual objects
++    size_t first;         // offset of first obj
++    size_t current;       // offset of current obj
++    size_t current_pair;  // offset of current pair describing id, location of object
++    size_t length;        // total length of all objects (starting at first)
++    size_t n;             // number of objects that should be found in the object stream
++    size_t nobjs_found;   // number of objects actually found in the object stream
++    char *streambuf;      // address of stream buffer, beginning with first obj pair
++    size_t streambuf_len; // length of stream buffer, includes pairs followed by actual objects
+ };
+ 
+ struct pdf_obj {
+diff --git a/libclamav/pdfdecode.c b/libclamav/pdfdecode.c
+index 473cfcd43..92ba52d50 100644
+--- a/libclamav/pdfdecode.c
++++ b/libclamav/pdfdecode.c
+@@ -73,7 +73,7 @@
+ struct pdf_token {
+     uint32_t flags;   /* tracking flags */
+     uint32_t success; /* successfully decoded filters */
+-    uint32_t length;  /* length of current content; TODO: transition to size_t */
++    size_t length;    /* length of current content; TODO: transition to size_t */
+     uint8_t *content; /* content stream */
+ };
+ 
+@@ -461,10 +461,16 @@ static cl_error_t filter_ascii85decode(struct pdf_struct *pdf, struct pdf_obj *o
+     uint32_t declen = 0;
+ 
+     const uint8_t *ptr = (uint8_t *)token->content;
+-    uint32_t remaining = token->length;
++    size_t remaining   = token->length;
+     int quintet = 0, rc = CL_SUCCESS;
+     uint64_t sum = 0;
+ 
++    /* Check for overflow */
++    if (remaining > (SIZE_MAX / 4)) {
++        cli_dbgmsg("cli_pdf: ascii85decode: overflow detected\n");
++        return CL_EFORMAT;
++    }
++
+     /* 5:4 decoding ratio, with 1:4 expansion sequences => (4*length)+1 */
+     if (!(dptr = decoded = (uint8_t *)cli_malloc((4 * remaining) + 1))) {
+         cli_errmsg("cli_pdf: cannot allocate memory for decoded output\n");
+@@ -851,8 +857,8 @@ static cl_error_t filter_asciihexdecode(struct pdf_struct *pdf, struct pdf_obj *
+     uint8_t *decoded;
+ 
+     const uint8_t *content = (uint8_t *)token->content;
+-    uint32_t length        = token->length;
+-    uint32_t i, j;
++    size_t length          = token->length;
++    size_t i, j;
+     cl_error_t rc = CL_SUCCESS;
+ 
+     if (!(decoded = (uint8_t *)cli_calloc(length / 2 + 1, sizeof(uint8_t)))) {
+@@ -882,8 +888,8 @@ static cl_error_t filter_asciihexdecode(struct pdf_struct *pdf, struct pdf_obj *
+     if (rc == CL_SUCCESS) {
+         free(token->content);
+ 
+-        cli_dbgmsg("cli_pdf: deflated %lu bytes from %lu total bytes\n",
+-                   (unsigned long)j, (unsigned long)(token->length));
++        cli_dbgmsg("cli_pdf: deflated %zu bytes from %zu total bytes\n",
++                   j, token->length);
+ 
+         token->content = decoded;
+         token->length  = j;
+@@ -891,8 +897,8 @@ static cl_error_t filter_asciihexdecode(struct pdf_struct *pdf, struct pdf_obj *
+         if (!(obj->flags & ((1 << OBJ_IMAGE) | (1 << OBJ_TRUNCATED))))
+             pdfobj_flag(pdf, obj, BAD_ASCIIDECODE);
+ 
+-        cli_dbgmsg("cli_pdf: error occurred parsing byte %lu of %lu\n",
+-                   (unsigned long)i, (unsigned long)(token->length));
++        cli_dbgmsg("cli_pdf: error occurred parsing byte %zu of %zu\n",
++                   i, token->length);
+         free(decoded);
+     }
+     return rc;
+@@ -933,27 +939,29 @@ static cl_error_t filter_decrypt(struct pdf_struct *pdf, struct pdf_obj *obj, st
+         return CL_EPARSE; /* TODO: what should this value be? CL_SUCCESS would mirror previous behavior */
+     }
+ 
+-    cli_dbgmsg("cli_pdf: decrypted %zu bytes from %u total bytes\n",
++    cli_dbgmsg("cli_pdf: decrypted %zu bytes from %zu total bytes\n",
+                length, token->length);
+ 
+     free(token->content);
+     token->content = (uint8_t *)decrypted;
+-    token->length  = (uint32_t)length; /* this may truncate unfortunately, TODO: use 64-bit values internally? */
++    token->length  = length;
+     return CL_SUCCESS;
+ }
+ 
+ static cl_error_t filter_lzwdecode(struct pdf_struct *pdf, struct pdf_obj *obj, struct pdf_dict *params, struct pdf_token *token)
+ {
+     uint8_t *decoded, *temp;
+-    uint32_t declen = 0, capacity = 0;
++    size_t declen = 0, capacity = 0;
+ 
+     uint8_t *content = (uint8_t *)token->content;
+     uint32_t length  = token->length;
+     lzw_stream stream;
+     int echg = 1, lzwstat, rc = CL_SUCCESS;
+ 
+-    if (pdf->ctx && !(pdf->ctx->dconf->other & OTHER_CONF_LZW))
+-        return CL_BREAK;
++    if (pdf->ctx && !(pdf->ctx->dconf->other & OTHER_CONF_LZW)) {
++        rc = CL_BREAK;
++        goto done;
++    }
+ 
+     if (params) {
+         struct pdf_dict_node *node = params->nodes;
+@@ -984,15 +992,18 @@ static cl_error_t filter_lzwdecode(struct pdf_struct *pdf, struct pdf_obj *obj,
+          * Sample 0015315109, it has \r followed by zlib header.
+          * Flag pdf as suspicious, and attempt to extract by skipping the \r.
+          */
+-        if (!length)
+-            return CL_SUCCESS;
++        if (!length) {
++            rc = CL_SUCCESS;
++            goto done;
++        }
+     }
+ 
+     capacity = INFLATE_CHUNK_SIZE;
+ 
+     if (!(decoded = (uint8_t *)cli_malloc(capacity))) {
+         cli_errmsg("cli_pdf: cannot allocate memory for decoded output\n");
+-        return CL_EMEM;
++        rc = CL_EMEM;
++        goto done;
+     }
+ 
+     memset(&stream, 0, sizeof(stream));
+@@ -1007,7 +1018,8 @@ static cl_error_t filter_lzwdecode(struct pdf_struct *pdf, struct pdf_obj *obj,
+     if (lzwstat != Z_OK) {
+         cli_warnmsg("cli_pdf: lzwInit failed\n");
+         free(decoded);
+-        return CL_EMEM;
++        rc = CL_EMEM;
++        goto done;
+     }
+ 
+     /* initial inflate */
+@@ -1022,16 +1034,23 @@ static cl_error_t filter_lzwdecode(struct pdf_struct *pdf, struct pdf_obj *obj,
+             length -= q - content;
+             content = q;
+ 
+-            stream.next_in   = (Bytef *)content;
+-            stream.avail_in  = length;
+-            stream.next_out  = (Bytef *)decoded;
++            stream.next_in  = (Bytef *)content;
++            stream.avail_in = length;
++            stream.next_out = (Bytef *)decoded;
++            /* Make sure we don't overflow during type conversion */
++            if (capacity > UINT_MAX) {
++                cli_dbgmsg("cli_pdf: lzwdecode: overflow detected\n");
++                rc = CL_EFORMAT;
++                goto done;
++            }
+             stream.avail_out = capacity;
+ 
+             lzwstat = lzwInit(&stream);
+             if (lzwstat != Z_OK) {
+                 cli_warnmsg("cli_pdf: lzwInit failed\n");
+                 free(decoded);
+-                return CL_EMEM;
++                rc = CL_EMEM;
++                goto done;
+             }
+ 
+             pdfobj_flag(pdf, obj, BAD_FLATESTART);
+@@ -1044,7 +1063,7 @@ static cl_error_t filter_lzwdecode(struct pdf_struct *pdf, struct pdf_obj *obj,
+         /* extend output capacity if needed,*/
+         if (stream.avail_out == 0) {
+             if ((rc = cli_checklimits("pdf", pdf->ctx, capacity + INFLATE_CHUNK_SIZE, 0, 0)) != CL_SUCCESS) {
+-                cli_dbgmsg("cli_pdf: required buffer size to inflate compressed filter exceeds maximum: %u\n", capacity + INFLATE_CHUNK_SIZE);
++                cli_dbgmsg("cli_pdf: required buffer size to inflate compressed filter exceeds maximum: %zu\n", capacity + INFLATE_CHUNK_SIZE);
+                 break;
+             }
+ 
+@@ -1056,7 +1075,17 @@ static cl_error_t filter_lzwdecode(struct pdf_struct *pdf, struct pdf_obj *obj,
+             decoded          = temp;
+             stream.next_out  = decoded + capacity;
+             stream.avail_out = INFLATE_CHUNK_SIZE;
++            if (declen > (SIZE_MAX - INFLATE_CHUNK_SIZE)) {
++                cli_dbgmsg("cli_pdf: lzwdecode: overflow detected\n");
++                rc = CL_EFORMAT;
++                goto done;
++            }
+             declen += INFLATE_CHUNK_SIZE;
++            if (capacity > (SIZE_MAX - INFLATE_CHUNK_SIZE)) {
++                cli_dbgmsg("cli_pdf: lzwdecode: overflow detected\n");
++                rc = CL_EFORMAT;
++                goto done;
++            }
+             capacity += INFLATE_CHUNK_SIZE;
+         }
+ 
+@@ -1064,6 +1093,12 @@ static cl_error_t filter_lzwdecode(struct pdf_struct *pdf, struct pdf_obj *obj,
+         lzwstat = lzwInflate(&stream);
+     }
+ 
++    if (declen > (UINT32_MAX - (INFLATE_CHUNK_SIZE - stream.avail_out))) {
++        cli_dbgmsg("cli_pdf: lzwdecode: overflow detected\n");
++        rc = CL_EFORMAT;
++        goto done;
++    }
++
+     /* add stream end fragment to decoded length */
+     declen += (INFLATE_CHUNK_SIZE - stream.avail_out);
+ 
+@@ -1104,6 +1139,7 @@ static cl_error_t filter_lzwdecode(struct pdf_struct *pdf, struct pdf_obj *obj,
+ 
+     (void)lzwInflateEnd(&stream);
+ 
++done:
+     if (rc == CL_SUCCESS) {
+         if (declen == 0) {
+             cli_dbgmsg("cli_pdf: empty stream after inflation completed.\n");
+-- 
+2.49.0
+
-- 
2.49.0


