Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA03CC83F09
	for <webhook@archiver.kernel.org>; Thu, 10 Jul 2025 05:58:51 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.1690.1752127122910266754
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Jul 2025 22:58:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=DCoyHFdl;
 spf=pass (domain: mvista.com, ip: 209.85.215.170, mailfrom: hprajapati@mvista.com)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b271f3ae786so595771a12.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Jul 2025 22:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1752127122; x=1752731922; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SBNhHjXji+/LQZovXY1wzkT3nI7ALkfi5YFKdXdb19s=;
        b=DCoyHFdldG/JqFUEgme85oLdN8QWiS/Zbkv9fhHmjSi5egg1PZ7v9cFRmg8NsGB7pM
         5M4OmvZ+2p5sim/8uDPwm+NPVeMQkcyxhFeGSb57Y56+WIYdfQHmQMCnnP2NL/DrKL64
         5k1POeRjqGkwS+SikqXN0r809Y77buOSY8FpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127122; x=1752731922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBNhHjXji+/LQZovXY1wzkT3nI7ALkfi5YFKdXdb19s=;
        b=srjOJ46KxjFgJ0dXLlC+0FAW68CHTXIWMMZgg+qF6P/QOlrCGlxmI7FY4OFN7ITlz2
         uY/CYDjzVxZUKDTlYPWPiRkIKKSQNb50fOPzFuTeUAOQ96v6Ll6Idw+fanCdM91WFfSk
         feUGxbiZZi0hLGehr9gAGgjG2BenQP6Omd8rGhf/u3c7a+B4Y4bGIK+3de1X55MlF8aX
         YH+XmYzZhRbK8r94BKdBEbA9OfRU2CTpdhQcF+qFJHK71UWF6vQQfHNsW5L0i4bmgbtF
         5QOTWt5rB5C/T9qiNWtfUvxVal+feqJ0e2W2XrVgg033G6H/mt8xnHMQ7/qBzzsYJGD6
         knpw==
X-Gm-Message-State: AOJu0YxQfUqLu+XwKOU3POfIHw1UfxfrZtfFFSo2cQwkYvA5/QYjhVtT
	3qPe6wlUb/GV6XTuM9eA9jxqrLTw9FmnnkUYeXFq951kRko0aVuMmLA5Rd4xuKYcIPqR7D2L/eD
	yZLzn
X-Gm-Gg: ASbGncsBt/gA9zR+ftFVU1labF+1erGP19TIGMqHre/kV5Z/rYP+pHAlhyboZIizhmi
	dtpPcCG0+zfi6jPdTe5VTIuwjAi5QH8hBCdOshZXGIWl1tTXxxnzO1TQ8qLET9kljp+lRJWxlaD
	FVtuAwOGq9ofAGp5h/hpWglDyjaSlbU/NbtPhoYPNvaNmXspEA4YcKh+IiqLrgBJrDv8WOuUa+e
	JBkM/xdNyC2UDVOMY4Nm1fd0zd9++irWa4dGkLFXIsqBkZn7s8U1WNMz3oKQ3Bg+Ah9ypKhPUbq
	yip5TU4xylOQ78kXPZ/2LU1pz/6pXDpjy5ypRew5JbPnw1yvubnMYsV6Cujrs0MfwpWaNqRekgH
	7
X-Google-Smtp-Source: AGHT+IH8weroybgSEgdtWIXmCoMJ/lQ9tyOUq7Csjn0HTBC15odjEhXWA2UAVBo3ZYO4K9Qj1yM35A==
X-Received: by 2002:a05:6a21:695:b0:1f5:8678:1820 with SMTP id adf61e73a8af0-22cd5cf5c4emr8929858637.12.1752127121727;
        Wed, 09 Jul 2025 22:58:41 -0700 (PDT)
Received: from MVIN00016.mvista.com ([150.129.170.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7134sm1116060b3a.19.2025.07.09.22.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 22:58:41 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][scarthgap][PATCH] suricata: fix multiple CVEs
Date: Thu, 10 Jul 2025 11:27:49 +0530
Message-ID: <20250710055749.98223-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Jul 2025 05:58:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1797

Backport fixes for:

* CVE-2025-29916 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/2f432c99a9734ea3a75c9218f35060e11a7a39ad && https://github.com/OISF/suricata/commit/e28c8c655a324a18932655a2c2b8f0d5aa1c55d7 && https://github.com/OISF/suricata/commit/d86c5f9f0c75736d4fce93e27c0773fcb27e1047
* CVE-2025-29917 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/bab716776ba3561cfbfd1a57fc18ff1f6859f019
* CVE-2025-29918 - Upstream-Status: Backport from https://github.com/OISF/suricata/commit/f6c9490e1f7b0b375c286d5313ebf3bc81a95eb6

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 .../suricata/files/CVE-2025-29916-01.patch    | 124 +++++++++++
 .../suricata/files/CVE-2025-29916-02.patch    | 197 ++++++++++++++++++
 .../suricata/files/CVE-2025-29916-03.patch    |  55 +++++
 .../suricata/files/CVE-2025-29917.patch       | 115 ++++++++++
 .../suricata/files/CVE-2025-29918.patch       |  49 +++++
 recipes-ids/suricata/suricata_7.0.0.bb        |   5 +
 6 files changed, 545 insertions(+)
 create mode 100644 recipes-ids/suricata/files/CVE-2025-29916-01.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2025-29916-02.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2025-29916-03.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2025-29917.patch
 create mode 100644 recipes-ids/suricata/files/CVE-2025-29918.patch

diff --git a/recipes-ids/suricata/files/CVE-2025-29916-01.patch b/recipes-ids/suricata/files/CVE-2025-29916-01.patch
new file mode 100644
index 0000000..ae020e2
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-29916-01.patch
@@ -0,0 +1,124 @@
+From 2f432c99a9734ea3a75c9218f35060e11a7a39ad Mon Sep 17 00:00:00 2001
+From: Victor Julien <vjulien@oisf.net>
+Date: Tue, 18 Mar 2025 10:55:39 +0100
+Subject: [PATCH] datasets: improve default hashsize handling
+
+Make hashsize default local to dataset code, instead of relying on the
+thash code.
+
+Use the same default value as before.
+
+(cherry picked from commit d32a39ca4b53d7f659f4f0a2a5c162ef97dc4797)
+
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/2f432c99a9734ea3a75c9218f35060e11a7a39ad]
+CVE: CVE-2025-29916
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/datasets.c | 37 +++++++++++++++++++++++--------------
+ 1 file changed, 23 insertions(+), 14 deletions(-)
+
+diff --git a/src/datasets.c b/src/datasets.c
+index 32bcf6e..89e7899 100644
+--- a/src/datasets.c
++++ b/src/datasets.c
+@@ -677,6 +677,11 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
+         }
+     }
+ 
++    GetDefaultMemcap(&default_memcap, &default_hashsize);
++    if (hashsize == 0) {
++        hashsize = default_hashsize;
++    }
++
+     set = DatasetAlloc(name);
+     if (set == NULL) {
+         goto out_err;
+@@ -696,12 +701,11 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
+     char cnf_name[128];
+     snprintf(cnf_name, sizeof(cnf_name), "datasets.%s.hash", name);
+ 
+-    GetDefaultMemcap(&default_memcap, &default_hashsize);
+     switch (type) {
+         case DATASET_TYPE_MD5:
+             set->hash = THashInit(cnf_name, sizeof(Md5Type), Md5StrSet, Md5StrFree, Md5StrHash,
+                     Md5StrCompare, load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap,
+-                    hashsize > 0 ? hashsize : default_hashsize);
++                    hashsize);
+             if (set->hash == NULL)
+                 goto out_err;
+             if (DatasetLoadMd5(set) < 0)
+@@ -710,7 +714,7 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
+         case DATASET_TYPE_STRING:
+             set->hash = THashInit(cnf_name, sizeof(StringType), StringSet, StringFree, StringHash,
+                     StringCompare, load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap,
+-                    hashsize > 0 ? hashsize : default_hashsize);
++                    hashsize);
+             if (set->hash == NULL)
+                 goto out_err;
+             if (DatasetLoadString(set) < 0)
+@@ -719,26 +723,25 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
+         case DATASET_TYPE_SHA256:
+             set->hash = THashInit(cnf_name, sizeof(Sha256Type), Sha256StrSet, Sha256StrFree,
+                     Sha256StrHash, Sha256StrCompare, load != NULL ? 1 : 0,
+-                    memcap > 0 ? memcap : default_memcap,
+-                    hashsize > 0 ? hashsize : default_hashsize);
++                    memcap > 0 ? memcap : default_memcap, hashsize);
+             if (set->hash == NULL)
+                 goto out_err;
+             if (DatasetLoadSha256(set) < 0)
+                 goto out_err;
+             break;
+         case DATASET_TYPE_IPV4:
+-            set->hash = THashInit(cnf_name, sizeof(IPv4Type), IPv4Set, IPv4Free, IPv4Hash,
+-                    IPv4Compare, load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap,
+-                    hashsize > 0 ? hashsize : default_hashsize);
++            set->hash =
++                    THashInit(cnf_name, sizeof(IPv4Type), IPv4Set, IPv4Free, IPv4Hash, IPv4Compare,
++                            load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap, hashsize);
+             if (set->hash == NULL)
+                 goto out_err;
+             if (DatasetLoadIPv4(set) < 0)
+                 goto out_err;
+             break;
+         case DATASET_TYPE_IPV6:
+-            set->hash = THashInit(cnf_name, sizeof(IPv6Type), IPv6Set, IPv6Free, IPv6Hash,
+-                    IPv6Compare, load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap,
+-                    hashsize > 0 ? hashsize : default_hashsize);
++            set->hash =
++                    THashInit(cnf_name, sizeof(IPv6Type), IPv6Set, IPv6Free, IPv6Hash, IPv6Compare,
++                            load != NULL ? 1 : 0, memcap > 0 ? memcap : default_memcap, hashsize);
+             if (set->hash == NULL)
+                 goto out_err;
+             if (DatasetLoadIPv6(set) < 0)
+@@ -825,6 +828,10 @@ void DatasetPostReloadCleanup(void)
+     SCMutexUnlock(&sets_lock);
+ }
+ 
++/* Value reflects THASH_DEFAULT_HASHSIZE which is what the default was earlier,
++ * despite 2048 commented out in the default yaml. */
++#define DATASETS_HASHSIZE_DEFAULT 4096
++
+ static void GetDefaultMemcap(uint64_t *memcap, uint32_t *hashsize)
+ {
+     const char *str = NULL;
+@@ -836,12 +843,14 @@ static void GetDefaultMemcap(uint64_t *memcap, uint32_t *hashsize)
+             *memcap = 0;
+         }
+     }
++
++    *hashsize = (uint32_t)DATASETS_HASHSIZE_DEFAULT;
+     if (ConfGet("datasets.defaults.hashsize", &str) == 1) {
+         if (ParseSizeStringU32(str, hashsize) < 0) {
++            *hashsize = (uint32_t)DATASETS_HASHSIZE_DEFAULT;
+             SCLogWarning("hashsize value cannot be deduced: %s,"
+-                         " resetting to default",
+-                    str);
+-            *hashsize = 0;
++                         " resetting to default: %u",
++                    str, *hashsize);
+         }
+     }
+ }
+-- 
+2.49.0
+
diff --git a/recipes-ids/suricata/files/CVE-2025-29916-02.patch b/recipes-ids/suricata/files/CVE-2025-29916-02.patch
new file mode 100644
index 0000000..fbaaabc
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-29916-02.patch
@@ -0,0 +1,197 @@
+From e28c8c655a324a18932655a2c2b8f0d5aa1c55d7 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Tue, 18 Mar 2025 10:55:39 +0100
+Subject: [PATCH] detect: add configurable limits for datasets
+
+Ticket: 7615
+
+Avoids signatures setting extreme hash sizes, which would lead to very
+high memory use.
+
+Default to allowing:
+- 65536 per dataset
+- 16777216 total
+
+To override these built-in defaults:
+
+```yaml
+datasets:
+  # Limits for per rule dataset instances to avoid rules using too many
+  # resources.
+  limits:
+    # Max value for per dataset `hashsize` setting
+    #single-hashsize: 65536
+    # Max combined hashsize values for all datasets.
+    #total-hashsizes: 16777216
+```
+
+(cherry picked from commit a7713db709b8a0be5fc5e5809ab58e9b14a16e85)
+
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/e28c8c655a324a18932655a2c2b8f0d5aa1c55d7]
+CVE: CVE-2025-29916
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/datasets.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
+ src/util-thash.c |  5 ----
+ suricata.yaml.in |  8 ++++++
+ 3 files changed, 73 insertions(+), 5 deletions(-)
+
+diff --git a/src/datasets.c b/src/datasets.c
+index 89e7899..0729894 100644
+--- a/src/datasets.c
++++ b/src/datasets.c
+@@ -39,11 +39,16 @@
+ #include "util-misc.h"
+ #include "util-path.h"
+ #include "util-debug.h"
++#include "util-validate.h"
+ 
+ SCMutex sets_lock = SCMUTEX_INITIALIZER;
+ static Dataset *sets = NULL;
+ static uint32_t set_ids = 0;
+ 
++uint32_t dataset_max_one_hashsize = 65536;
++uint32_t dataset_max_total_hashsize = 16777216;
++uint32_t dataset_used_hashsize = 0;
++
+ static int DatasetAddwRep(Dataset *set, const uint8_t *data, const uint32_t data_len,
+         DataRepType *rep);
+ 
+@@ -629,6 +634,34 @@ Dataset *DatasetFind(const char *name, enum DatasetTypes type)
+     return set;
+ }
+ 
++static bool DatasetCheckHashsize(const char *name, uint32_t hash_size)
++{
++    if (dataset_max_one_hashsize > 0 && hash_size > dataset_max_one_hashsize) {
++        SCLogError("hashsize %u in dataset '%s' exceeds configured 'single-hashsize' limit (%u)",
++                hash_size, name, dataset_max_one_hashsize);
++        return false;
++    }
++    // we cannot underflow as we know from conf loading that
++    // dataset_max_total_hashsize >= dataset_max_one_hashsize if dataset_max_total_hashsize > 0
++    if (dataset_max_total_hashsize > 0 &&
++            dataset_max_total_hashsize - hash_size < dataset_used_hashsize) {
++        SCLogError("hashsize %u in dataset '%s' exceeds configured 'total-hashsizes' limit (%u, in "
++                   "use %u)",
++                hash_size, name, dataset_max_total_hashsize, dataset_used_hashsize);
++        return false;
++    }
++
++    return true;
++}
++
++static void DatasetUpdateHashsize(const char *name, uint32_t hash_size)
++{
++    if (dataset_max_total_hashsize > 0) {
++        dataset_used_hashsize += hash_size;
++        SCLogDebug("set %s adding with hash_size %u", name, hash_size);
++    }
++}
++
+ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save, const char *load,
+         uint64_t memcap, uint32_t hashsize)
+ {
+@@ -682,6 +715,10 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
+         hashsize = default_hashsize;
+     }
+ 
++    if (!DatasetCheckHashsize(name, hashsize)) {
++        goto out_err;
++    }
++
+     set = DatasetAlloc(name);
+     if (set == NULL) {
+         goto out_err;
+@@ -755,6 +792,10 @@ Dataset *DatasetGet(const char *name, enum DatasetTypes type, const char *save,
+     set->next = sets;
+     sets = set;
+ 
++    /* hash size accounting */
++    DEBUG_VALIDATE_BUG_ON(set->hash->config.hash_size != hashsize);
++    DatasetUpdateHashsize(set->name, set->hash->config.hash_size);
++
+     SCMutexUnlock(&sets_lock);
+     return set;
+ out_err:
+@@ -796,6 +837,9 @@ void DatasetReload(void)
+             continue;
+         }
+         set->hidden = true;
++        if (dataset_max_total_hashsize > 0) {
++            dataset_used_hashsize -= set->hash->config.hash_size;
++        }
+         SCLogDebug("Set %s at %p hidden successfully", set->name, set);
+         set = set->next;
+     }
+@@ -863,6 +907,27 @@ int DatasetsInit(void)
+     uint32_t default_hashsize = 0;
+     GetDefaultMemcap(&default_memcap, &default_hashsize);
+     if (datasets != NULL) {
++        const char *str = NULL;
++        if (ConfGet("datasets.limits.total-hashsizes", &str) == 1) {
++            if (ParseSizeStringU32(str, &dataset_max_total_hashsize) < 0) {
++                FatalError("failed to parse datasets.limits.total-hashsizes value: %s", str);
++            }
++        }
++        if (ConfGet("datasets.limits.single-hashsize", &str) == 1) {
++            if (ParseSizeStringU32(str, &dataset_max_one_hashsize) < 0) {
++                FatalError("failed to parse datasets.limits.single-hashsize value: %s", str);
++            }
++        }
++        if (dataset_max_total_hashsize > 0 &&
++                dataset_max_total_hashsize < dataset_max_one_hashsize) {
++            FatalError("total-hashsizes (%u) cannot be smaller than single-hashsize (%u)",
++                    dataset_max_total_hashsize, dataset_max_one_hashsize);
++        }
++        if (dataset_max_total_hashsize > 0 && dataset_max_one_hashsize == 0) {
++            // the total limit also applies for single limit
++            dataset_max_one_hashsize = dataset_max_total_hashsize;
++        }
++
+         int list_pos = 0;
+         ConfNode *iter = NULL;
+         TAILQ_FOREACH(iter, &datasets->head, next) {
+diff --git a/src/util-thash.c b/src/util-thash.c
+index 6443990..3fba3ef 100644
+--- a/src/util-thash.c
++++ b/src/util-thash.c
+@@ -310,16 +310,11 @@ THashTableContext *THashInit(const char *cnf_prefix, size_t data_size,
+     ctx->config.hash_size = hashsize > 0 ? hashsize : THASH_DEFAULT_HASHSIZE;
+     /* Reset memcap in case of loading from file to the highest possible value
+      unless defined by the rule keyword */
+-#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+-    // limit memcap size to default when fuzzing
+-    ctx->config.memcap = THASH_DEFAULT_MEMCAP;
+-#else
+     if (memcap > 0) {
+         ctx->config.memcap = memcap;
+     } else {
+         ctx->config.memcap = reset_memcap ? UINT64_MAX : THASH_DEFAULT_MEMCAP;
+     }
+-#endif
+     ctx->config.prealloc = THASH_DEFAULT_PREALLOC;
+ 
+     SC_ATOMIC_INIT(ctx->counter);
+diff --git a/suricata.yaml.in b/suricata.yaml.in
+index 6303991..b218515 100644
+--- a/suricata.yaml.in
++++ b/suricata.yaml.in
+@@ -1167,6 +1167,14 @@ datasets:
+     #memcap: 100mb
+     #hashsize: 2048
+ 
++  # Limits for per rule dataset instances to avoid rules using too many
++  # resources.
++  limits:
++    # Max value for per dataset `hashsize` setting
++    #single-hashsize: 65536
++    # Max combined hashsize values for all datasets.
++    #total-hashsizes: 16777216
++
+   rules:
+     # Set to true to allow absolute filenames and filenames that use
+     # ".." components to reference parent directories in rules that specify
+-- 
+2.49.0
+
diff --git a/recipes-ids/suricata/files/CVE-2025-29916-03.patch b/recipes-ids/suricata/files/CVE-2025-29916-03.patch
new file mode 100644
index 0000000..73e66a2
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-29916-03.patch
@@ -0,0 +1,55 @@
+From d86c5f9f0c75736d4fce93e27c0773fcb27e1047 Mon Sep 17 00:00:00 2001
+From: Victor Julien <vjulien@oisf.net>
+Date: Mon, 17 Mar 2025 21:19:13 +0100
+Subject: [PATCH] datasets: set higher hashsize limits
+
+To avoid possible upgrade issues, allow higher defaults than in the
+master branch. Add some upgrade guidance and a note that defaults will
+probably be further reduced.
+
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/d86c5f9f0c75736d4fce93e27c0773fcb27e1047]
+CVE: CVE-2025-29916
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/datasets.c   | 5 +++--
+ suricata.yaml.in | 5 +++--
+ 2 files changed, 6 insertions(+), 4 deletions(-)
+
+diff --git a/src/datasets.c b/src/datasets.c
+index 0729894..f99f63c 100644
+--- a/src/datasets.c
++++ b/src/datasets.c
+@@ -45,8 +45,9 @@ SCMutex sets_lock = SCMUTEX_INITIALIZER;
+ static Dataset *sets = NULL;
+ static uint32_t set_ids = 0;
+ 
+-uint32_t dataset_max_one_hashsize = 65536;
+-uint32_t dataset_max_total_hashsize = 16777216;
++/* 4x what we set in master to allow a smoother upgrade path */
++uint32_t dataset_max_one_hashsize = 262144;
++uint32_t dataset_max_total_hashsize = 67108864;
+ uint32_t dataset_used_hashsize = 0;
+ 
+ static int DatasetAddwRep(Dataset *set, const uint8_t *data, const uint32_t data_len,
+diff --git a/suricata.yaml.in b/suricata.yaml.in
+index b218515..59db9ef 100644
+--- a/suricata.yaml.in
++++ b/suricata.yaml.in
+@@ -1169,11 +1169,12 @@ datasets:
+ 
+   # Limits for per rule dataset instances to avoid rules using too many
+   # resources.
++  # Note: in Suricata 8 the built-in default will be set to lower values.
+   limits:
+     # Max value for per dataset `hashsize` setting
+-    #single-hashsize: 65536
++    #single-hashsize: 262144
+     # Max combined hashsize values for all datasets.
+-    #total-hashsizes: 16777216
++    #total-hashsizes: 67108864
+ 
+   rules:
+     # Set to true to allow absolute filenames and filenames that use
+-- 
+2.49.0
+
diff --git a/recipes-ids/suricata/files/CVE-2025-29917.patch b/recipes-ids/suricata/files/CVE-2025-29917.patch
new file mode 100644
index 0000000..8b30dbf
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-29917.patch
@@ -0,0 +1,115 @@
+From bab716776ba3561cfbfd1a57fc18ff1f6859f019 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Tue, 17 Dec 2024 15:06:25 +0100
+Subject: [PATCH] detect: limit base64_decode `bytes` to 64KiB
+
+Ticket: 7613
+
+Avoids potential large per-thread memory allocation. A buffer with the
+size of the largest decode_base64 buffer size setting would be allocated
+per thread. As this was a u32, it could mean a per-thread 4GiB memory
+allocation.
+
+64KiB was already the built-in default for cases where bytes size wasn't
+specified.
+
+(cherry picked from commit 32d0bd2bbb4d486623dec85a94952fde2515f2f0)
+
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/bab716776ba3561cfbfd1a57fc18ff1f6859f019]
+CVE: CVE-2025-29917
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ doc/userguide/rules/base64-keywords.rst |  1 +
+ src/detect-base64-decode.c              | 15 ++++++---------
+ src/detect.h                            |  2 +-
+ 3 files changed, 8 insertions(+), 10 deletions(-)
+
+diff --git a/doc/userguide/rules/base64-keywords.rst b/doc/userguide/rules/base64-keywords.rst
+index 7daf0c2..cf4e679 100644
+--- a/doc/userguide/rules/base64-keywords.rst
++++ b/doc/userguide/rules/base64-keywords.rst
+@@ -15,6 +15,7 @@ Syntax::
+     base64_decode:bytes <value>, offset <value>, relative;
+ 
+ The ``bytes`` option specifies how many bytes Suricata should decode and make available for base64_data.
++This number is limited to 64KiB.
+ The decoding will stop at the end of the buffer.
+ 
+ The ``offset`` option specifies how many bytes Suricata should skip before decoding.
+diff --git a/src/detect-base64-decode.c b/src/detect-base64-decode.c
+index 25fdf10..5ae38c5 100644
+--- a/src/detect-base64-decode.c
++++ b/src/detect-base64-decode.c
+@@ -28,7 +28,7 @@
+ #define BASE64_DECODE_MAX 65535
+ 
+ typedef struct DetectBase64Decode_ {
+-    uint32_t bytes;
++    uint16_t bytes;
+     uint32_t offset;
+     uint8_t relative;
+ } DetectBase64Decode;
+@@ -111,8 +111,8 @@ int DetectBase64DecodeDoMatch(DetectEngineThreadCtx *det_ctx, const Signature *s
+     return det_ctx->base64_decoded_len > 0;
+ }
+ 
+-static int DetectBase64DecodeParse(const char *str, uint32_t *bytes,
+-    uint32_t *offset, uint8_t *relative)
++static int DetectBase64DecodeParse(
++        const char *str, uint16_t *bytes, uint32_t *offset, uint8_t *relative)
+ {
+     const char *bytes_str = NULL;
+     const char *offset_str = NULL;
+@@ -132,7 +132,7 @@ static int DetectBase64DecodeParse(const char *str, uint32_t *bytes,
+ 
+     if (pcre_rc >= 3) {
+         if (pcre2_substring_get_bynumber(match, 2, (PCRE2_UCHAR8 **)&bytes_str, &pcre2_len) == 0) {
+-            if (StringParseUint32(bytes, 10, 0, bytes_str) <= 0) {
++            if (StringParseUint16(bytes, 10, 0, bytes_str) <= 0) {
+                 SCLogError("Bad value for bytes: \"%s\"", bytes_str);
+                 goto error;
+             }
+@@ -186,7 +186,7 @@ error:
+ static int DetectBase64DecodeSetup(DetectEngineCtx *de_ctx, Signature *s,
+     const char *str)
+ {
+-    uint32_t bytes = 0;
++    uint16_t bytes = 0;
+     uint32_t offset = 0;
+     uint8_t relative = 0;
+     DetectBase64Decode *data = NULL;
+@@ -238,9 +238,6 @@ static int DetectBase64DecodeSetup(DetectEngineCtx *de_ctx, Signature *s,
+         data->bytes = BASE64_DECODE_MAX;
+     }
+     if (data->bytes > de_ctx->base64_decode_max_len) {
+-#ifdef FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION
+-        data->bytes = BASE64_DECODE_MAX;
+-#endif
+         de_ctx->base64_decode_max_len = data->bytes;
+     }
+ 
+@@ -272,7 +269,7 @@ static int g_http_header_buffer_id = 0;
+ static int DetectBase64TestDecodeParse(void)
+ {
+     int retval = 0;
+-    uint32_t bytes = 0;
++    uint16_t bytes = 0;
+     uint32_t offset = 0;
+     uint8_t relative = 0;
+ 
+diff --git a/src/detect.h b/src/detect.h
+index 2760dda..fd938a1 100644
+--- a/src/detect.h
++++ b/src/detect.h
+@@ -910,7 +910,7 @@ typedef struct DetectEngineCtx_ {
+     struct SigGroupHead_ *decoder_event_sgh;
+ 
+     /* Maximum size of the buffer for decoded base64 data. */
+-    uint32_t base64_decode_max_len;
++    uint16_t base64_decode_max_len;
+ 
+     /** Store rule file and line so that parsers can use them in errors. */
+     int rule_line;
+-- 
+2.49.0
+
diff --git a/recipes-ids/suricata/files/CVE-2025-29918.patch b/recipes-ids/suricata/files/CVE-2025-29918.patch
new file mode 100644
index 0000000..da9d680
--- /dev/null
+++ b/recipes-ids/suricata/files/CVE-2025-29918.patch
@@ -0,0 +1,49 @@
+From f6c9490e1f7b0b375c286d5313ebf3bc81a95eb6 Mon Sep 17 00:00:00 2001
+From: Philippe Antoine <pantoine@oisf.net>
+Date: Tue, 28 Jan 2025 15:02:45 +0100
+Subject: [PATCH] detect/pcre: avoid infinite loop after negated pcre
+
+Ticket: 7526
+
+The usage of negated pcre, followed by other relative payload
+content keywords could lead to an infinite loop.
+
+This is because regular (not negated) pcre can test multiple
+occurences, but negated pcre should be tried only once.
+
+(cherry picked from commit b14c67cbdf25fa6c7ffe0d04ddf3ebe67b12b50b)
+
+Upstream-Status: Backport [https://github.com/OISF/suricata/commit/f6c9490e1f7b0b375c286d5313ebf3bc81a95eb6]
+CVE: CVE-2025-29918
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/detect-engine-content-inspection.c | 6 +++++-
+ 1 file changed, 5 insertions(+), 1 deletion(-)
+
+diff --git a/src/detect-engine-content-inspection.c b/src/detect-engine-content-inspection.c
+index 77ebb3f..2a789c9 100644
+--- a/src/detect-engine-content-inspection.c
++++ b/src/detect-engine-content-inspection.c
+@@ -450,7 +450,6 @@ uint8_t DetectEngineContentInspection(DetectEngineCtx *de_ctx, DetectEngineThrea
+             if (r == 0) {
+                 goto no_match;
+             }
+-
+             if (!(pe->flags & DETECT_PCRE_RELATIVE_NEXT)) {
+                 SCLogDebug("no relative match coming up, so this is a match");
+                 goto match;
+@@ -473,6 +472,11 @@ uint8_t DetectEngineContentInspection(DetectEngineCtx *de_ctx, DetectEngineThrea
+             if (det_ctx->discontinue_matching)
+                 goto no_match;
+ 
++            if (prev_offset == 0) {
++                // This happens for negated PCRE
++                // We do not search for another occurrence of this pcre
++                SCReturnInt(0);
++            }
+             det_ctx->buffer_offset = prev_buffer_offset;
+             det_ctx->pcre_match_start_offset = prev_offset;
+         } while (1);
+-- 
+2.49.0
+
diff --git a/recipes-ids/suricata/suricata_7.0.0.bb b/recipes-ids/suricata/suricata_7.0.0.bb
index 1cb02f4..9618c45 100644
--- a/recipes-ids/suricata/suricata_7.0.0.bb
+++ b/recipes-ids/suricata/suricata_7.0.0.bb
@@ -19,6 +19,11 @@ SRC_URI += " \
     file://CVE-2024-45795.patch \
     file://CVE-2024-45796.patch \
     file://CVE-2024-55605.patch \
+    file://CVE-2025-29916-01.patch \
+    file://CVE-2025-29916-02.patch \
+    file://CVE-2025-29916-03.patch \
+    file://CVE-2025-29917.patch \
+    file://CVE-2025-29918.patch \
     "
 
 inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
-- 
2.49.0


