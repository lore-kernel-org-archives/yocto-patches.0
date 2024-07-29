Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C5C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 05:10:14 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.50166.1722229799006621345
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jul 2024 22:09:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=gjSQ8R4V;
 spf=pass (domain: mvista.com, ip: 209.85.214.172, mailfrom: hprajapati@mvista.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc491f9b55so17624695ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 22:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1722229798; x=1722834598; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YjWSwir7IkovKpXausDyMsTShinJyt4v8lr9Q+8rVEM=;
        b=gjSQ8R4Va+YQqJGHyUKNL6v1oyxFQSmQCtn2SpLvXv2+p5wlLZZZxPZHgtKL2eQdIE
         qoO5EVjnfzU670KUaKj6GhWnZcgUjCgNcEgoDpLuvfHYc0h/Lu3mWTKVy2rgK/d/mzKG
         uzJht0dnu3Sovy4n+3fL7Mz5KuD0ZXCPE/5vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722229798; x=1722834598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjWSwir7IkovKpXausDyMsTShinJyt4v8lr9Q+8rVEM=;
        b=stzNpv4tCBO9ylSbdp5fsXW9KmNMhDmZbnE+1cPQp2Om8mJ17Hv37cMO5L3ujzPgsz
         3ESeUJPTG5YZVco/wAiwX6t/XC8URskg4S0LK1BZ7a/GIRlAibHl/zjHxH0T7u7LVeZL
         sZlxEgZ7R3Y4Vyj0aFuOVTwb8p2RR2tkehRCzRH2YJqPFXTiFsTyHcWLPjrJXpBaqqnm
         rTWTBcI9VMRHi5wXX86WVDffpQZpNMB7z46phDQhmd3d9aTY3FsdUcZoGYwO66uv0oDz
         VM536/7TivigsrDMCWmez0oTcOoi45wA0epX7Ds3SDYMLYhU0/Z3ceaXg/xhxmfAZUFp
         9sgw==
X-Gm-Message-State: AOJu0YyfTkN8rFjUTX595sLmP+7uTBrVOp+lE1iXVlOFltUcrsoNxgEa
	pd/UOBqF1pFtQKrjOHY/7c2cTbpA272QGNFvOIzuiE9mkNNS+6FD1KfslcB+f962vj6i7iXM7a+
	I
X-Google-Smtp-Source: AGHT+IE/uZ2hx4XcvxNYxVBUNhaTWtTzLdikLpMaaWZ6jtL4OVcCRiClfxGZSjO8Ru69j3HoFWyJSg==
X-Received: by 2002:a17:902:d50b:b0:1fb:74b3:53d5 with SMTP id d9443c01a7336-1ff0484c4a8mr42680345ad.35.1722229798182;
        Sun, 28 Jul 2024 22:09:58 -0700 (PDT)
Received: from MVIN00016.mvista.com ([43.249.234.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa0dsm72928215ad.187.2024.07.28.22.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 22:09:57 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Hitendra Prajapati <hprajapati@mvista.com>
Subject: [yocto-patches][meta-security][scarthgap][PATCH] sssd: Fix CVE-2023-3758
Date: Mon, 29 Jul 2024 10:39:47 +0530
Message-Id: <20240729050947.5906-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 05:10:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/487

A race condition flaw was found in sssd where the GPO policy is
not consistently applied for authenticated users. This may lead
to improper authorization issues, granting or denying access to
resources inappropriately.

References:
https://nvd.nist.gov/vuln/detail/CVE-2023-3758

Upstream-Status: Backport from https://github.com/SSSD/sssd/commit/e1bfbc2493c4194988acc3b2413df3dde0735ae3

Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
---
 .../sssd/files/CVE-2023-3758.patch            | 222 ++++++++++++++++++
 .../recipes-security/sssd/sssd_2.9.2.bb       |   1 +
 2 files changed, 223 insertions(+)
 create mode 100644 dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2023-3758.patch

diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2023-3758.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2023-3758.patch
new file mode 100644
index 0000000..15d8d7e
--- /dev/null
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2023-3758.patch
@@ -0,0 +1,222 @@
+From e1bfbc2493c4194988acc3b2413df3dde0735ae3 Mon Sep 17 00:00:00 2001
+From: Sumit Bose <sbose@redhat.com>
+Date: Wed, 8 Nov 2023 14:50:24 +0100
+Subject: [PATCH] ad-gpo: use hash to store intermediate results
+MIME-Version: 1.0
+Content-Type: text/plain; charset=UTF-8
+Content-Transfer-Encoding: 8bit
+
+Currently after the evaluation of a single GPO file the intermediate
+results are stored in the cache and this cache entry is updated until
+all applicable GPO files are evaluated. Finally the data in the cache is
+used to make the decision of access is granted or rejected.
+
+If there are two or more access-control request running in parallel one
+request might overwrite the cache object with intermediate data while
+another request reads the cached data for the access decision and as a
+result will do this decision based on intermediate data.
+
+To avoid this the intermediate results are not stored in the cache
+anymore but in hash tables which are specific to the request. Only the
+final result is written to the cache to have it available for offline
+authentication.
+
+Reviewed-by: Alexey Tikhonov <atikhono@redhat.com>
+Reviewed-by: Tomáš Halman <thalman@redhat.com>
+(cherry picked from commit d7db7971682da2dbf7642ac94940d6b0577ec35a)
+
+Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/e1bfbc2493c4194988acc3b2413df3dde0735ae3]
+CVE: CVE-2023-3758
+Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
+---
+ src/providers/ad/ad_gpo.c | 116 +++++++++++++++++++++++++++++++++-----
+ 1 file changed, 102 insertions(+), 14 deletions(-)
+
+diff --git a/src/providers/ad/ad_gpo.c b/src/providers/ad/ad_gpo.c
+index 44e9cbb..cec0cb4 100644
+--- a/src/providers/ad/ad_gpo.c
++++ b/src/providers/ad/ad_gpo.c
+@@ -1317,6 +1317,33 @@ ad_gpo_extract_policy_setting(TALLOC_CTX *mem_ctx,
+     return ret;
+ }
+ 
++static errno_t
++add_result_to_hash(hash_table_t *hash, const char *key, char *value)
++{
++    int hret;
++    hash_key_t k;
++    hash_value_t v;
++
++    if (hash == NULL || key == NULL || value == NULL) {
++        return EINVAL;
++    }
++
++    k.type = HASH_KEY_CONST_STRING;
++    k.c_str = key;
++
++    v.type = HASH_VALUE_PTR;
++    v.ptr = value;
++
++    hret = hash_enter(hash, &k, &v);
++    if (hret != HASH_SUCCESS) {
++        DEBUG(SSSDBG_OP_FAILURE, "Failed to add [%s][%s] to hash: [%s].\n",
++                                 key, value, hash_error_string(hret));
++        return EIO;
++    }
++
++    return EOK;
++}
++
+ /*
+  * This function parses the cse-specific (GP_EXT_GUID_SECURITY) filename,
+  * and stores the allow_key and deny_key of all of the gpo_map_types present
+@@ -1324,6 +1351,7 @@ ad_gpo_extract_policy_setting(TALLOC_CTX *mem_ctx,
+  */
+ static errno_t
+ ad_gpo_store_policy_settings(struct sss_domain_info *domain,
++                             hash_table_t *allow_maps, hash_table_t *deny_maps,
+                              const char *filename)
+ {
+     struct ini_cfgfile *file_ctx = NULL;
+@@ -1457,14 +1485,14 @@ ad_gpo_store_policy_settings(struct sss_domain_info *domain,
+                 goto done;
+             } else if (ret != ENOENT) {
+                 const char *value = allow_value ? allow_value : empty_val;
+-                ret = sysdb_gpo_store_gpo_result_setting(domain,
+-                                                         allow_key,
+-                                                         value);
++                ret = add_result_to_hash(allow_maps, allow_key,
++                                         talloc_strdup(allow_maps, value));
+                 if (ret != EOK) {
+-                    DEBUG(SSSDBG_CRIT_FAILURE,
+-                          "sysdb_gpo_store_gpo_result_setting failed for key:"
+-                          "'%s' value:'%s' [%d][%s]\n", allow_key, allow_value,
+-                          ret, sss_strerror(ret));
++                    DEBUG(SSSDBG_CRIT_FAILURE, "Failed to add key: [%s] "
++                                               "value: [%s] to allow maps "
++                                               "[%d][%s].\n",
++                                               allow_key, value, ret,
++                                               sss_strerror(ret));
+                     goto done;
+                 }
+             }
+@@ -1484,14 +1512,14 @@ ad_gpo_store_policy_settings(struct sss_domain_info *domain,
+                 goto done;
+             } else if (ret != ENOENT) {
+                 const char *value = deny_value ? deny_value : empty_val;
+-                ret = sysdb_gpo_store_gpo_result_setting(domain,
+-                                                         deny_key,
+-                                                         value);
++                ret = add_result_to_hash(deny_maps, deny_key,
++                                         talloc_strdup(deny_maps, value));
+                 if (ret != EOK) {
+-                    DEBUG(SSSDBG_CRIT_FAILURE,
+-                          "sysdb_gpo_store_gpo_result_setting failed for key:"
+-                          "'%s' value:'%s' [%d][%s]\n", deny_key, deny_value,
+-                          ret, sss_strerror(ret));
++                    DEBUG(SSSDBG_CRIT_FAILURE, "Failed to add key: [%s] "
++                                               "value: [%s] to deny maps "
++                                               "[%d][%s].\n",
++                                               deny_key, value, ret,
++                                               sss_strerror(ret));
+                     goto done;
+                 }
+             }
+@@ -1784,6 +1812,8 @@ struct ad_gpo_access_state {
+     int num_cse_filtered_gpos;
+     int cse_gpo_index;
+     const char *ad_domain;
++    hash_table_t *allow_maps;
++    hash_table_t *deny_maps;
+ };
+ 
+ static void ad_gpo_connect_done(struct tevent_req *subreq);
+@@ -1906,6 +1936,19 @@ ad_gpo_access_send(TALLOC_CTX *mem_ctx,
+         goto immediately;
+     }
+ 
++    ret = sss_hash_create(state, 0, &state->allow_maps);
++    if (ret != EOK) {
++        DEBUG(SSSDBG_FATAL_FAILURE, "Could not create allow maps "
++              "hash table [%d]: %s\n", ret, sss_strerror(ret));
++        goto immediately;
++    }
++
++    ret = sss_hash_create(state, 0, &state->deny_maps);
++    if (ret != EOK) {
++        DEBUG(SSSDBG_FATAL_FAILURE, "Could not create deny maps "
++              "hash table [%d]: %s\n", ret, sss_strerror(ret));
++        goto immediately;
++    }
+ 
+     subreq = sdap_id_op_connect_send(state->sdap_op, state, &ret);
+     if (subreq == NULL) {
+@@ -2725,6 +2768,43 @@ ad_gpo_cse_step(struct tevent_req *req)
+     return EAGAIN;
+ }
+ 
++static errno_t
++store_hash_maps_in_cache(struct sss_domain_info *domain,
++                         hash_table_t *allow_maps, hash_table_t *deny_maps)
++{
++    int ret;
++    struct hash_iter_context_t *iter;
++    hash_entry_t *entry;
++    size_t c;
++    hash_table_t *hash_list[] = { allow_maps, deny_maps, NULL};
++
++
++    for (c = 0; hash_list[c] != NULL; c++) {
++        iter = new_hash_iter_context(hash_list[c]);
++        if (iter == NULL) {
++            DEBUG(SSSDBG_OP_FAILURE, "Failed to create hash iterator.\n");
++            return EINVAL;
++        }
++
++        while ((entry = iter->next(iter)) != NULL) {
++            ret = sysdb_gpo_store_gpo_result_setting(domain,
++                                                     entry->key.c_str,
++                                                     entry->value.ptr);
++            if (ret != EOK) {
++                free(iter);
++                DEBUG(SSSDBG_OP_FAILURE,
++                      "sysdb_gpo_store_gpo_result_setting failed for key:"
++                      "[%s] value:[%s] [%d][%s]\n", entry->key.c_str,
++                      (char *) entry->value.ptr, ret, sss_strerror(ret));
++                return ret;
++            }
++        }
++        talloc_free(iter);
++    }
++
++    return EOK;
++}
++
+ /*
+  * This cse-specific function (GP_EXT_GUID_SECURITY) increments the
+  * cse_gpo_index until the policy settings for all applicable GPOs have been
+@@ -2766,6 +2846,7 @@ ad_gpo_cse_done(struct tevent_req *subreq)
+      * (as part of the GPO Result object in the sysdb cache).
+      */
+     ret = ad_gpo_store_policy_settings(state->host_domain,
++                                       state->allow_maps, state->deny_maps,
+                                        cse_filtered_gpo->policy_filename);
+     if (ret != EOK && ret != ENOENT) {
+         DEBUG(SSSDBG_OP_FAILURE,
+@@ -2779,6 +2860,13 @@ ad_gpo_cse_done(struct tevent_req *subreq)
+ 
+     if (ret == EOK) {
+         /* ret is EOK only after all GPO policy files have been downloaded */
++        ret = store_hash_maps_in_cache(state->host_domain,
++                                       state->allow_maps, state->deny_maps);
++        if (ret != EOK) {
++            DEBUG(SSSDBG_OP_FAILURE, "Failed to store evaluated GPO maps "
++                                     "[%d][%s].\n", ret, sss_strerror(ret));
++            goto done;
++        }
+         ret = ad_gpo_perform_hbac_processing(state,
+                                              state->gpo_mode,
+                                              state->gpo_map_type,
+-- 
+2.25.1
+
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index d61471c..3e05858 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -25,6 +25,7 @@ SRC_URI = "https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://fix-ldblibdir.patch \
            file://musl_fixup.patch \
            file://0001-sssctl-add-error-analyzer.patch \
+           file://CVE-2023-3758.patch \
            "
 SRC_URI[sha256sum] = "827bc65d64132410e6dd3df003f04829d60387ec30e72b2d4e22d93bb6f762ba"
 
-- 
2.25.1


