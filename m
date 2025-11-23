Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E71BCFD31E
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:43 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5047.1763941538786677810
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=SjfhTfI8;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b2da83f721so421196985a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941538; x=1764546338; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eypY4NuEDKS3LzRUmDzTHvNBKZaSx9hdUYfcT0BqKCA=;
        b=SjfhTfI8yLqahF8fzvgkpiEYhXk49MyjT0y0f2hSktYixUpHT4VoGzhxrLAwz0E1ug
         tztfkgIwzNVCaWjGae5qv5ay9xZnX4IB7dS7ZjlyejmWYRJvv4d3mQQ6CJTQO0LoS6J8
         +qFyiNlEJMeIsNZjD4AbQjeRt3AuHTiThNXTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941538; x=1764546338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eypY4NuEDKS3LzRUmDzTHvNBKZaSx9hdUYfcT0BqKCA=;
        b=lLYwf+/vNddcGVhVSop+SdDO6ttaoNcvlL9ry6IncIBZTVP4QNzLuYmHIofSd4kMf+
         SRfq1QwtpGhhnIR72sbHaNxS9BIQtPAEIHvk9Cq+UZWUlVQEsdOo5zFbugIoOD49fwpp
         7yksoGeX+o73hvrk7c1pvmY3R9C7p/XrIkADHewqP9U1zd6GDhDCsDpv2WPD3sMJa85n
         C1+55uMMQhMCawZTYcLZFwPh3oJz+DnlD3pFv72SoBJddF6RhINTRj7VIXn7ekReCN6K
         JqVu/6z7yBIoMraRxpgxu7oawlw7RnyjdIfsw+Cxof+nlHyTqbfEMI/spinAU5arJhl4
         dyLQ==
X-Gm-Message-State: AOJu0YzGrXlpV4ie0eoEAqTlXcZkRCaIAikO1B9W409BaLeBPczwSAjz
	AIBcIMsOlembtYsbriePymDVCxkKz4xGNDH8eOgpGbYHF9Nu465lJchvllvS/j6zpAIpb7a/TgG
	qmxUV
X-Gm-Gg: ASbGncs3bCViYELkEAi0SpyEuJnqkNte0aJZgeEVPkwbqQLJfnhmFY0Pgw+4fQe5a5M
	EPS6c+ju7aSFlae7CiKGUf3TL/tKCRXa5XVOA4pIcngHm3ORXnmreZtMGn7SDbJhxqXjqeelgVg
	ygSf0oRzxMGoM0BwRYEl44TgCQMURCBybTZbFFqRXTC139y5XEUGMPN3laOiaT3nHQo21NNHZ2a
	LyyfShnBw/47Ii6sdjGtebS83TKb73a37vdDNo0g8qpG98nbM34lbjTWdhcAAi/Du5L9q3w4bnK
	xRYa/9Sz0MQHg1EoyNojFiRmoDTdHfa9zKbg62rXKKjdQ5WINJjmzKSrQlP0O56Mb3lzUO9CcFo
	yHbH68RgMhZU/nCKuPsWODzAvA/40F+fvJY94Qf7mB8iNyRINYF0yRya2CJTi7T3y6ze0EA+NP+
	Ru6yiMJSkcD5T0/MYBrKwGzocxo69V4kfB9Ai7sdethXdz/ZskHMaZgGqoml1/5hk=
X-Google-Smtp-Source: AGHT+IGI6o8JRL+MufuxxHPCtdRWyM9VNTe8ggW1v40n/pDPaV+l7aVCyCZZwnpxH8OGC34dDXT7sw==
X-Received: by 2002:a05:620a:448b:b0:8a6:1a5d:7ae8 with SMTP id af79cd13be357-8b33bde9a79mr1488557885a.28.1763941537492;
        Sun, 23 Nov 2025 15:45:37 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:36 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 20/32] libhtp: fix CVE-2025-53537
Date: Sun, 23 Nov 2025 18:45:00 -0500
Message-ID: <94f04a4dc279e7f2d5a8dcad2e64a7b3b6aa9d60.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2678

From: Hitendra Prajapati <hprajapati@mvista.com>

Upstream-Status: Backport from
https://github.com/OISF/libhtp/commit/226580d502ae98c148aaecc4846f78694b5e253c && https://github.com/OISF/libhtp/commit/9037ea35110a0d97be5cedf8d31fb4cd9a38c7a7

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../suricata/files/CVE-2025-53537-001.patch   | 79 +++++++++++++++++++
 .../suricata/files/CVE-2025-53537-002.patch   | 31 ++++++++
 recipes-ids/suricata/libhtp_0.5.45.bb         |  2 +
 3 files changed, 112 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2025-53537-001.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2025-53537-002.patch

diff --git a/recipes-ids/suricata/files/CVE-2025-53537-001.patch b/recipes-ids/suricata/files/CVE-2025-53537-001.patch
new file mode 100644
index 0000000..e16a59a
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-53537-001.patch
@@ -0,0 +1,79 @@
+From 226580d502ae98c148aaecc4846f78694b5e253c Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <contact@catenacyber.fr>
+Date: Tue, 11 Mar 2025 16:45:35 +0100
+Subject: [PATCH] decompressors: do not take data after end
+
+
+CVE: CVE-2025-53537
+Upstream-Status: Backport [https://github.com/OISF/libhtp/commit/226580d502ae98c148aaecc4846f78694b5e253c]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ htp/htp_core.h          |  5 ++++-
+ htp/htp_decompressors.c | 21 ++++++++++++---------
+ 2 files changed, 16 insertions(+), 10 deletions(-)
+
+diff --git a/htp/htp_core.h b/htp/htp_core.h
+index 7c23212..fb142c9 100644
+--- a/htp/htp_core.h
++++ b/htp/htp_core.h
+@@ -161,7 +161,10 @@ enum htp_content_encoding_t {
+     HTP_COMPRESSION_DEFLATE = 3,
+ 
+     /** LZMA compression. */
+-    HTP_COMPRESSION_LZMA = 4
++    HTP_COMPRESSION_LZMA = 4,
++
++    /** No more data. */
++    HTP_COMPRESSION_OVER = 5
+ };
+ 
+ /**
+diff --git a/htp/htp_decompressors.c b/htp/htp_decompressors.c
+index 19950df..0d94c30 100644
+--- a/htp/htp_decompressors.c
++++ b/htp/htp_decompressors.c
+@@ -203,6 +203,8 @@ htp_status_t htp_gzip_decompressor_decompress(htp_decompressor_t *drec1, htp_tx_
+         }
+ 
+         return HTP_OK;
++    } else if (drec->zlib_initialized == HTP_COMPRESSION_OVER) {
++        return HTP_ERROR;
+     }
+ 
+     if (d->data == NULL) {
+@@ -316,15 +318,9 @@ restart:
+             // no initialization means previous error on stream
+             return HTP_ERROR;
+         }
+-        if (GZIP_BUF_SIZE > drec->stream.avail_out) {
+-            if (rc == Z_DATA_ERROR) {
+-                // There is data even if there is an error
+-                // So use this data and log a warning
+-                htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
+-                rc = Z_STREAM_END;
+-            }
+-        }
+-        if (rc == Z_STREAM_END) {
++
++	int error_after_data = (rc == Z_DATA_ERROR && drec->restart == 0 && GZIP_BUF_SIZE > drec->stream.avail_out);
++        if (rc == Z_STREAM_END || error_after_data) {
+             // How many bytes do we have?
+             size_t len = GZIP_BUF_SIZE - drec->stream.avail_out;
+ 
+@@ -351,6 +347,13 @@ restart:
+             drec->stream.next_out = drec->buffer;
+             // TODO Handle trailer.
+ 
++            if (error_after_data) {
++                // There is data even if there is an error
++                // So use this data and log a warning
++                htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
++                drec->zlib_initialized = HTP_COMPRESSION_OVER;
++                return HTP_ERROR;
++            }
+             return HTP_OK;
+         }
+         else if (rc != Z_OK) {
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/files/CVE-2025-53537-002.patch b/recipes-ids/suricata/files/CVE-2025-53537-002.patch
new file mode 100644
index 0000000..ff4f1a0
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-53537-002.patch
@@ -0,0 +1,31 @@
+From 9037ea35110a0d97be5cedf8d31fb4cd9a38c7a7 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <contact@catenacyber.fr>
+Date: Tue, 17 Jun 2025 10:12:47 +0200
+Subject: [PATCH] decompressors: fix leak in lzma error case
+
+Ticket: 7766
+
+CVE: CVE-2025-53537
+Upstream-Status: Backport [https://github.com/OISF/libhtp/commit/9037ea35110a0d97be5cedf8d31fb4cd9a38c7a7]
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ htp/htp_decompressors.c | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/htp/htp_decompressors.c b/htp/htp_decompressors.c
+index 0d94c30..ce6cfe1 100644
+--- a/htp/htp_decompressors.c
++++ b/htp/htp_decompressors.c
+@@ -351,6 +351,9 @@ restart:
+                 // There is data even if there is an error
+                 // So use this data and log a warning
+                 htp_log(d->tx->connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "GZip decompressor: inflate failed with %d", rc);
++                if (drec->zlib_initialized == HTP_COMPRESSION_LZMA) {
++                    LzmaDec_Free(&drec->state, &lzma_Alloc);
++                }
+                 drec->zlib_initialized = HTP_COMPRESSION_OVER;
+                 return HTP_ERROR;
+             }
+-- 
+2.50.1
+
diff --git a/recipes-ids/suricata/libhtp_0.5.45.bb b/recipes-ids/suricata/libhtp_0.5.45.bb
index 604a0ca..b87db35 100644
--- a/recipes-ids/suricata/libhtp_0.5.45.bb
+++ b/recipes-ids/suricata/libhtp_0.5.45.bb
@@ -6,6 +6,8 @@ LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=596ab7963a1a0e5198e
 
 SRC_URI = "git://github.com/OISF/libhtp.git;protocol=https;branch=0.5.x \
            file://CVE-2024-45797.patch \
+           file://CVE-2025-53537-001.patch \
+           file://CVE-2025-53537-002.patch \
           "
 SRCREV = "8bdfe7b9d04e5e948c8fbaa7472e14d884cc00af"
 
-- 
2.47.3


