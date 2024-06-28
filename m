Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE00C2BBCA
	for <webhook@archiver.kernel.org>; Fri, 28 Jun 2024 05:43:33 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
 by mx.groups.io with SMTP id smtpd.web10.10704.1719553404116254903
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 27 Jun 2024 22:43:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=U7QP+tJp;
 spf=pass (domain: mvista.com, ip: 209.85.219.173, mailfrom: hprajapati@mvista.com)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e036105251eso13359276.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 27 Jun 2024 22:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1719553403; x=1720158203; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YjWSwir7IkovKpXausDyMsTShinJyt4v8lr9Q+8rVEM=;
        b=U7QP+tJpPhI/Cw0nkGpT2n6mAdWVvDCoXnqTxFdDFxreLUHmNMa9ufo6FF3R47BMy0
         V3wtvJX/jpPiqyqBQviFTf6q2LBcwDn5J0svI2mv9WhPooLOA5ND0UcmZUGMq+NxptK6
         WrNfndrmQtI4uVxLEADRH+rm3n88CoM7wDrWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719553403; x=1720158203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjWSwir7IkovKpXausDyMsTShinJyt4v8lr9Q+8rVEM=;
        b=AjCYeYdGIw1PPr64MOUP2cG8HzvNtdi7TqeX8Gb3upDtVhuP9uc5QC4xdxFVsP4mIL
         vuvVlUkfk64vUTsfcj5+v8F9+9g6aeaMUXc6adWsKaEqNr+2IsWpWhBf/1rNkeQMAv7V
         lRUGGEj5VV6rFDiCZHOpa61ShUltep/VKsv45RNoz27UCqmOTsPzCWsZKKxsF1d+rIjZ
         v8rhIZMd7q10zxwiHR8OhymBMyRgYVHqFqguSAlW/vp75elbD4wssXhdAa6hAFR//U2P
         YPNszOeoFrj/fUDfYncTMQi7spFVSZV7dlnwGXpWyCSU6z+/pe2JP1J/ux9AC6PKAqsK
         nhfw==
X-Gm-Message-State: AOJu0YytJeslI5lJ7INsgqkf3retqH7327yXrlufP3ncRUC+uzrkAg1x
	gm4SsNq7kr2MiYy6l5Jwi3tFy0/pDQ96PtcWPVDXPDIZ5PXBmnsIg+8Ki4ZNilwG4ETFC7vDSa3
	E
X-Google-Smtp-Source: AGHT+IHUH2eUnQhlMSGKG9D72o9bCrXpuGG1/GlUwaLywUTKp7AhdpQrISdnQ+KVzdhEgHM2zOHcPw==
X-Received: by 2002:a25:d384:0:b0:e03:46bf:b2da with SMTP id 3f1490d57ef6-e0346bfbf12mr4091789276.10.1719553403137;
        Thu, 27 Jun 2024 22:43:23 -0700 (PDT)
Received: from MVIN00016.mvista.com ([150.129.170.164])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0353d5835csm222243276.8.2024.06.27.22.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 22:43:22 -0700 (PDT)
From: Hitendra Prajapati <hprajapati@mvista.com>
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com,
	Hitendra Prajapati <hprajapati@mvista.com>
Subject: [meta-security][PATCH] sssd: Fix CVE-2023-3758
Date: Fri, 28 Jun 2024 11:13:14 +0530
Message-Id: <20240628054314.50608-1-hprajapati@mvista.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 28 Jun 2024 05:43:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/391

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


