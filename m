Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C67DD3C54D
	for <webhook@archiver.kernel.org>; Fri, 18 Oct 2024 05:31:46 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.15735.1729229495438007085
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 17 Oct 2024 22:31:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=LZd6jE8P;
 spf=pass (domain: mvista.com, ip: 209.85.214.169, mailfrom: hprajapati@mvista.com)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cceb8d8b4so10865925ad.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 17 Oct 2024 22:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1729229495; x=1729834295; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ij5mo3nwebidCs7fqx78TinFTzUxX75Q3VygGxvZvsM=;
        b=LZd6jE8P6LzAp85qf4dJmzRfQ5hkk2tMxq5jv0YwkCjHSlQwdrjxJ4HF4OGpyv9WLb
         /TA4I4fYtS5fZsnUHby/WrEOw2zRSAzV26THHaqoduYI0+Zmfd9F9ihgloPmHdd77s66
         aIZnauFtP6Ak7XfKPjiqvEbJunWFeEn9jNy6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729229495; x=1729834295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ij5mo3nwebidCs7fqx78TinFTzUxX75Q3VygGxvZvsM=;
        b=pYFnpWPdBv5BITZtUfi5i/rWed5DxQ9SRCvgXR3QGVoW+oRRjlURRTsh00ZhjB67Pe
         gAAfx3n8qzc5FB43r6gW2E6teCM7p50mn4nVzqGOaysOFfgfPmyEq4GYmu6Y8cq6qmjL
         IJ1EQHBG9Qmho4NQpkGEWCSsaiCFa9I54T7lGm4z95xnwMO/27wJ8uDEF2hmXcBxBHuY
         YDqtuBj3550/BODA5dNwa4jWrLEz/H920K42AzLCE75oga9oQCgBMIwhiQCzbCcfCFZ8
         bBw6ldf/1PPMpH9poUAgsFWrFX+ubA6VaDyoTTb3tmmD+ok9xh4ug03O8ynsn4wYgiqq
         0oLg==
X-Gm-Message-State: AOJu0Ywywej74TtKrUsrOqy8rjKKNthpArvz7wWCXJxxEMMOok3Mug76
	XZOpuAQqM0pvs5yHIXOV/ZHCW8TfMQtn0H0qKfhkFVWsGDMHC1RNAaPUAHkyxYUXof3u4XFbQWm
	j
X-Google-Smtp-Source: AGHT+IHh5pLp9C6wVus1JaA0HBw9iI8c1Pa84Ec4rUAMpNdcTZ7Dpjj2nE0GlWN4fYOH+CyljKNzGA==
X-Received: by 2002:a17:902:d2cd:b0:20c:72e8:4eb7 with SMTP id d9443c01a7336-20d47990054mr82061935ad.25.1729229494497;
        Thu, 17 Oct 2024 22:31:34 -0700 (PDT)
Received: from MVIN00016.mvista.com ([150.129.170.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8f9832sm5145615ad.230.2024.10.17.22.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:31:34 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] libhtp: fix CVE-2024-45797
Date: Fri, 18 Oct 2024 11:01:18 +0530
Message-Id: <20241018053118.27569-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Oct 2024 05:31:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/719

Upstream-Status: Backport from https://github.com/OISF/libhtp/commit/0d550de551b91d5e57ba23e2b1e2c6430fad6818

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 .../suricata/files/CVE-2024-45797.patch       | 148 ++++++++++++++++++
 recipes-ids/suricata/libhtp_0.5.45.bb         |   4 +-
 2 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 recipes-ids/suricata/files/CVE-2024-45797.patch

diff --git a/recipes-ids/suricata/files/CVE-2024-45797.patch b/recipes-ids/suricata/files/CVE-2024-45797.patch
new file mode 100644
index 0000000..3db4625
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2024-45797.patch
@@ -0,0 +1,148 @@
+From 0d550de551b91d5e57ba23e2b1e2c6430fad6818 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <contact@catenacyber.fr>
+Date: Mon, 12 Aug 2024 14:06:40 +0200
+Subject: [PATCH] headers: put a configurable limit on their numbers
+
+So as to avoid quadratic complexity
+
+Ticket: 7191
+
+Upstream-Status: Backport [https://github.com/OISF/libhtp/commit/0d550de551b91d5e57ba23e2b1e2c6430fad6818]
+CVE: CVE-2024-45797
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ htp/htp_config.c           |  8 ++++++++
+ htp/htp_config.h           |  8 ++++++++
+ htp/htp_config_private.h   |  6 ++++++
+ htp/htp_core.h             |  1 +
+ htp/htp_request_generic.c  | 11 +++++++++++
+ htp/htp_response_generic.c | 10 ++++++++++
+ 6 files changed, 44 insertions(+)
+
+diff --git a/htp/htp_config.c b/htp/htp_config.c
+index 767458f..9e0eee3 100644
+--- a/htp/htp_config.c
++++ b/htp/htp_config.c
+@@ -145,6 +145,8 @@ static unsigned char bestfit_1252[] = {
+     0xff, 0x5d, 0x7d, 0xff, 0x5e, 0x7e, 0x00, 0x00, 0x00
+ };
+ 
++#define HTP_HEADERS_LIMIT 1024
++
+ htp_cfg_t *htp_config_create(void) {
+     htp_cfg_t *cfg = calloc(1, sizeof (htp_cfg_t));
+     if (cfg == NULL) return NULL;
+@@ -163,6 +165,7 @@ htp_cfg_t *htp_config_create(void) {
+     cfg->response_lzma_layer_limit = 1; // default is only one layer
+     cfg->compression_bomb_limit = HTP_COMPRESSION_BOMB_LIMIT;
+     cfg->compression_time_limit = HTP_COMPRESSION_TIME_LIMIT_USEC;
++    cfg->number_headers_limit = HTP_HEADERS_LIMIT;
+     cfg->allow_space_uri = 0;
+ 
+     // Default settings for URL-encoded data.
+@@ -542,6 +545,11 @@ void htp_config_set_compression_time_limit(htp_cfg_t *cfg, size_t useclimit) {
+     }
+ }
+ 
++void htp_config_set_number_headers_limit(htp_cfg_t *cfg, uint32_t limit) {
++    if (cfg == NULL) return;
++    cfg->number_headers_limit = limit;
++}
++
+ void htp_config_set_log_level(htp_cfg_t *cfg, enum htp_log_level_t log_level) {
+     if (cfg == NULL) return;
+     cfg->log_level = log_level;
+diff --git a/htp/htp_config.h b/htp/htp_config.h
+index d1365dc..ed0eaeb 100644
+--- a/htp/htp_config.h
++++ b/htp/htp_config.h
+@@ -466,6 +466,14 @@ void htp_config_set_compression_time_limit(htp_cfg_t *cfg, size_t useclimit);
+  */
+ void htp_config_set_log_level(htp_cfg_t *cfg, enum htp_log_level_t log_level);
+ 
++/**
++ * Configures the maximum number of headers LibHTP will accept per request or response.
++ *
++ * @param[in] cfg
++ * @param[in] limit
++ */
++void htp_config_set_number_headers_limit(htp_cfg_t *cfg, uint32_t limit);
++
+ /**
+  * Configures how the server reacts to encoded NUL bytes. Some servers will stop at
+  * at NUL, while some will respond with 400 or 404. When the termination option is not
+diff --git a/htp/htp_config_private.h b/htp/htp_config_private.h
+index 5f1d60d..ecc8717 100644
+--- a/htp/htp_config_private.h
++++ b/htp/htp_config_private.h
+@@ -360,6 +360,12 @@ struct htp_cfg_t {
+ 
+     /** Whether to decompress compressed request bodies. */
+     int request_decompression_enabled;
++
++    /** Maximum number of transactions. */
++    uint32_t max_tx;
++
++    /** Maximum number of headers. */
++    uint32_t number_headers_limit;
+ };
+ 
+ #ifdef	__cplusplus
+diff --git a/htp/htp_core.h b/htp/htp_core.h
+index e4c933e..7c23212 100644
+--- a/htp/htp_core.h
++++ b/htp/htp_core.h
+@@ -235,6 +235,7 @@ enum htp_file_source_t {
+ #define HTP_REQUEST_INVALID                0x100000000ULL
+ #define HTP_REQUEST_INVALID_C_L            0x200000000ULL
+ #define HTP_AUTH_INVALID                   0x400000000ULL
++#define HTP_HEADERS_TOO_MANY               0x800000000ULL
+ 
+ #define HTP_MAX_HEADERS_REPETITIONS 64
+ 
+diff --git a/htp/htp_request_generic.c b/htp/htp_request_generic.c
+index 435cf0a..1350e57 100644
+--- a/htp/htp_request_generic.c
++++ b/htp/htp_request_generic.c
+@@ -120,6 +120,17 @@ htp_status_t htp_process_request_header_generic(htp_connp_t *connp, unsigned cha
+         bstr_free(h->value);
+         free(h);
+     } else {
++        if (htp_table_size(connp->in_tx->request_headers) > connp->cfg->number_headers_limit) {
++            if (!(connp->in_tx->flags & HTP_HEADERS_TOO_MANY)) {
++                connp->in_tx->flags |= HTP_HEADERS_TOO_MANY;
++                htp_log(connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "Too many request headers");
++            }
++            bstr_free(h->name);
++            bstr_free(h->value);
++            free(h);
++            // give up on what comes next
++            return HTP_ERROR;
++        }
+         // Add as a new header.
+         if (htp_table_add(connp->in_tx->request_headers, h->name, h) != HTP_OK) {
+             bstr_free(h->name);
+diff --git a/htp/htp_response_generic.c b/htp/htp_response_generic.c
+index f5fa59e..69da625 100644
+--- a/htp/htp_response_generic.c
++++ b/htp/htp_response_generic.c
+@@ -321,6 +321,16 @@ htp_status_t htp_process_response_header_generic(htp_connp_t *connp, unsigned ch
+         bstr_free(h->value);
+         free(h);       
+     } else {
++        if (htp_table_size(connp->out_tx->response_headers) > connp->cfg->number_headers_limit) {
++            if (!(connp->out_tx->flags & HTP_HEADERS_TOO_MANY)) {
++                connp->out_tx->flags |= HTP_HEADERS_TOO_MANY;
++                htp_log(connp, HTP_LOG_MARK, HTP_LOG_WARNING, 0, "Too many response headers");
++            }
++            bstr_free(h->name);
++            bstr_free(h->value);
++            free(h);
++            return HTP_ERROR;
++        }
+         // Add as a new header.
+         if (htp_table_add(connp->out_tx->response_headers, h->name, h) != HTP_OK) {
+             bstr_free(h->name);
+-- 
+2.25.1
+
diff --git a/recipes-ids/suricata/libhtp_0.5.45.bb b/recipes-ids/suricata/libhtp_0.5.45.bb
index cc8285c..604a0ca 100644
--- a/recipes-ids/suricata/libhtp_0.5.45.bb
+++ b/recipes-ids/suricata/libhtp_0.5.45.bb
@@ -4,7 +4,9 @@ require suricata.inc
 
 LIC_FILES_CHKSUM = "file://LICENSE;beginline=1;endline=2;md5=596ab7963a1a0e5198e5a1c4aa621843"
 
-SRC_URI = "git://github.com/OISF/libhtp.git;protocol=https;branch=0.5.x"
+SRC_URI = "git://github.com/OISF/libhtp.git;protocol=https;branch=0.5.x \
+           file://CVE-2024-45797.patch \
+          "
 SRCREV = "8bdfe7b9d04e5e948c8fbaa7472e14d884cc00af"
 
 DEPENDS = "zlib"
-- 
2.25.1


