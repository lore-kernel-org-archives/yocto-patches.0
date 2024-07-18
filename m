Return-Path: <hprajapati@mvista.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997C7C3DA49
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 08:20:19 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.web11.10406.1721290815166676129
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jul 2024 01:20:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista.com header.s=google header.b=XeQCjOGF;
 spf=pass (domain: mvista.com, ip: 209.85.128.180, mailfrom: hprajapati@mvista.com)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-662dc911cf2so5155237b3.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jul 2024 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1721290814; x=1721895614; darn=lists.yoctoproject.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+g8cs95cEqUGiHUXf5Bna88NERZ6i/37V7kg15r93E=;
        b=XeQCjOGFYPihEQoYLicDonoRXoW8bJ3wKU2lvipxCd35nHkTHRfXP0BqeoMgGBSgw9
         MehuJvVCoSuWmniacI3qovrv2VYv40LoHUqTP4L9PwoU4IFKqyzrWwreR/AevOLZBntz
         184aiJ6+JFJgKqMIu6QTHA1NkgbeId28YOhbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290814; x=1721895614;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+g8cs95cEqUGiHUXf5Bna88NERZ6i/37V7kg15r93E=;
        b=OXZBVzZvg+TTFQ9gtzvYPBIXeqKsb6Jaff9SyQ+CfP+5WHsiqwExZ1ka1OBd6/6Baw
         KsTDWzFjh3BsAftePtIxJQSGm8V/8BOa1j6naMcnmx2VKW5E9TnbbbUusScUHxifYgn+
         G19mwsb2YVWGd2hbpezofdZeScdSF4UNXOCoLI7/kFtcXZBeOrhl1xwSs8aVC8GoG0OV
         V/GTHtSlRSvDNFpF8gw3ZXd/ywL8h882GzdXB63Xdqhp7wuD4SFQzsYulSiGpZkt/PZr
         2Hjlp3yu62d6OPq4IjRr56CYOrI190VaXiOUgQySUsiBi+OOwDgWA+aJmKKkNhzyFnMN
         218Q==
X-Gm-Message-State: AOJu0YzfUOVDOamhF4Hhw11nj01HGfBEzcl1xysG+Aog4CQHgl8dcn3h
	wOcv1Cncg6weRA/8MNVWu215qjVVYlg8Yq/R7eLhV7r8jq5dVGCck/nyiXp1ampnC38959kZJSP
	e
X-Google-Smtp-Source: AGHT+IGHhenv+2IH4E8XTE/JFEu3MzqdZv9heuasRYNaa3B2NyYSsD4urn2Uv1XFb6OolodjqpMNMQ==
X-Received: by 2002:a0d:ea93:0:b0:64a:e7ec:f45 with SMTP id 00721157ae682-66603af3eefmr20116977b3.40.1721290813742;
        Thu, 18 Jul 2024 01:20:13 -0700 (PDT)
Received: from [192.168.1.100] ([150.129.170.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66601fb49c0sm2401047b3.33.2024.07.18.01.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:20:13 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------Gwdm7NUF023c5aUUY4pKaqnh"
Message-ID: <055209ba-4ef1-493c-81bc-9b936b8ec9f1@mvista.com>
Date: Thu, 18 Jul 2024 13:50:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-security][scarthgap][PATCH] sssd: Fix
 CVE-2023-3758
To: yocto-patches@lists.yoctoproject.org
Cc: akuster808@gmail.com
References: <20240628053817.50365-1-hprajapati@mvista.com>
 <17E1620C5E3A3E5E.21599@lists.yoctoproject.org>
Content-Language: en-US
From: Hitendra Prajapati <hprajapati@mvista.com>
In-Reply-To: <17E1620C5E3A3E5E.21599@lists.yoctoproject.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jul 2024 08:20:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/443

This is a multi-part message in MIME format.
--------------Gwdm7NUF023c5aUUY4pKaqnh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi ,

any update on this ??

Regards,

Hitendra

On 12/07/24 11:35 am, Hitendra Prajapati via lists.yoctoproject.org wrote:
>
> Hi Team,
>
> any update on this ??
>
> Regards,
>
> Hitendra
>
> On 28/06/24 11:08 am, Hitendra Prajapati wrote:
>> A race condition flaw was found in sssd where the GPO policy is
>> not consistently applied for authenticated users. This may lead
>> to improper authorization issues, granting or denying access to
>> resources inappropriately.
>>
>> References:
>> https://nvd.nist.gov/vuln/detail/CVE-2023-3758
>>
>> Upstream-Status: Backport fromhttps://github.com/SSSD/sssd/commit/e1bfbc2493c4194988acc3b2413df3dde0735ae3
>>
>> Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
>> ---
>>   .../sssd/files/CVE-2023-3758.patch            | 222 ++++++++++++++++++
>>   .../recipes-security/sssd/sssd_2.9.2.bb       |   1 +
>>   2 files changed, 223 insertions(+)
>>   create mode 100644 dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2023-3758.patch
>>
>> diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2023-3758.patch b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2023-3758.patch
>> new file mode 100644
>> index 0000000..15d8d7e
>> --- /dev/null
>> +++ b/dynamic-layers/networking-layer/recipes-security/sssd/files/CVE-2023-3758.patch
>> @@ -0,0 +1,222 @@
>> +From e1bfbc2493c4194988acc3b2413df3dde0735ae3 Mon Sep 17 00:00:00 2001
>> +From: Sumit Bose<sbose@redhat.com>
>> +Date: Wed, 8 Nov 2023 14:50:24 +0100
>> +Subject: [PATCH] ad-gpo: use hash to store intermediate results
>> +MIME-Version: 1.0
>> +Content-Type: text/plain; charset=UTF-8
>> +Content-Transfer-Encoding: 8bit
>> +
>> +Currently after the evaluation of a single GPO file the intermediate
>> +results are stored in the cache and this cache entry is updated until
>> +all applicable GPO files are evaluated. Finally the data in the cache is
>> +used to make the decision of access is granted or rejected.
>> +
>> +If there are two or more access-control request running in parallel one
>> +request might overwrite the cache object with intermediate data while
>> +another request reads the cached data for the access decision and as a
>> +result will do this decision based on intermediate data.
>> +
>> +To avoid this the intermediate results are not stored in the cache
>> +anymore but in hash tables which are specific to the request. Only the
>> +final result is written to the cache to have it available for offline
>> +authentication.
>> +
>> +Reviewed-by: Alexey Tikhonov<atikhono@redhat.com>
>> +Reviewed-by: Tomáš Halman<thalman@redhat.com>
>> +(cherry picked from commit d7db7971682da2dbf7642ac94940d6b0577ec35a)
>> +
>> +Upstream-Status: Backport [https://github.com/SSSD/sssd/commit/e1bfbc2493c4194988acc3b2413df3dde0735ae3]
>> +CVE: CVE-2023-3758
>> +Signed-off-by: Hitendra Prajapati<hprajapati@mvista.com>
>> +---
>> + src/providers/ad/ad_gpo.c | 116 +++++++++++++++++++++++++++++++++-----
>> + 1 file changed, 102 insertions(+), 14 deletions(-)
>> +
>> +diff --git a/src/providers/ad/ad_gpo.c b/src/providers/ad/ad_gpo.c
>> +index 44e9cbb..cec0cb4 100644
>> +--- a/src/providers/ad/ad_gpo.c
>> ++++ b/src/providers/ad/ad_gpo.c
>> +@@ -1317,6 +1317,33 @@ ad_gpo_extract_policy_setting(TALLOC_CTX *mem_ctx,
>> +     return ret;
>> + }
>> +
>> ++static errno_t
>> ++add_result_to_hash(hash_table_t *hash, const char *key, char *value)
>> ++{
>> ++    int hret;
>> ++    hash_key_t k;
>> ++    hash_value_t v;
>> ++
>> ++    if (hash == NULL || key == NULL || value == NULL) {
>> ++        return EINVAL;
>> ++    }
>> ++
>> ++    k.type = HASH_KEY_CONST_STRING;
>> ++    k.c_str = key;
>> ++
>> ++    v.type = HASH_VALUE_PTR;
>> ++    v.ptr = value;
>> ++
>> ++    hret = hash_enter(hash, &k, &v);
>> ++    if (hret != HASH_SUCCESS) {
>> ++        DEBUG(SSSDBG_OP_FAILURE, "Failed to add [%s][%s] to hash: [%s].\n",
>> ++                                 key, value, hash_error_string(hret));
>> ++        return EIO;
>> ++    }
>> ++
>> ++    return EOK;
>> ++}
>> ++
>> + /*
>> +  * This function parses the cse-specific (GP_EXT_GUID_SECURITY) filename,
>> +  * and stores the allow_key and deny_key of all of the gpo_map_types present
>> +@@ -1324,6 +1351,7 @@ ad_gpo_extract_policy_setting(TALLOC_CTX *mem_ctx,
>> +  */
>> + static errno_t
>> + ad_gpo_store_policy_settings(struct sss_domain_info *domain,
>> ++                             hash_table_t *allow_maps, hash_table_t *deny_maps,
>> +                              const char *filename)
>> + {
>> +     struct ini_cfgfile *file_ctx = NULL;
>> +@@ -1457,14 +1485,14 @@ ad_gpo_store_policy_settings(struct sss_domain_info *domain,
>> +                 goto done;
>> +             } else if (ret != ENOENT) {
>> +                 const char *value = allow_value ? allow_value : empty_val;
>> +-                ret = sysdb_gpo_store_gpo_result_setting(domain,
>> +-                                                         allow_key,
>> +-                                                         value);
>> ++                ret = add_result_to_hash(allow_maps, allow_key,
>> ++                                         talloc_strdup(allow_maps, value));
>> +                 if (ret != EOK) {
>> +-                    DEBUG(SSSDBG_CRIT_FAILURE,
>> +-                          "sysdb_gpo_store_gpo_result_setting failed for key:"
>> +-                          "'%s' value:'%s' [%d][%s]\n", allow_key, allow_value,
>> +-                          ret, sss_strerror(ret));
>> ++                    DEBUG(SSSDBG_CRIT_FAILURE, "Failed to add key: [%s] "
>> ++                                               "value: [%s] to allow maps "
>> ++                                               "[%d][%s].\n",
>> ++                                               allow_key, value, ret,
>> ++                                               sss_strerror(ret));
>> +                     goto done;
>> +                 }
>> +             }
>> +@@ -1484,14 +1512,14 @@ ad_gpo_store_policy_settings(struct sss_domain_info *domain,
>> +                 goto done;
>> +             } else if (ret != ENOENT) {
>> +                 const char *value = deny_value ? deny_value : empty_val;
>> +-                ret = sysdb_gpo_store_gpo_result_setting(domain,
>> +-                                                         deny_key,
>> +-                                                         value);
>> ++                ret = add_result_to_hash(deny_maps, deny_key,
>> ++                                         talloc_strdup(deny_maps, value));
>> +                 if (ret != EOK) {
>> +-                    DEBUG(SSSDBG_CRIT_FAILURE,
>> +-                          "sysdb_gpo_store_gpo_result_setting failed for key:"
>> +-                          "'%s' value:'%s' [%d][%s]\n", deny_key, deny_value,
>> +-                          ret, sss_strerror(ret));
>> ++                    DEBUG(SSSDBG_CRIT_FAILURE, "Failed to add key: [%s] "
>> ++                                               "value: [%s] to deny maps "
>> ++                                               "[%d][%s].\n",
>> ++                                               deny_key, value, ret,
>> ++                                               sss_strerror(ret));
>> +                     goto done;
>> +                 }
>> +             }
>> +@@ -1784,6 +1812,8 @@ struct ad_gpo_access_state {
>> +     int num_cse_filtered_gpos;
>> +     int cse_gpo_index;
>> +     const char *ad_domain;
>> ++    hash_table_t *allow_maps;
>> ++    hash_table_t *deny_maps;
>> + };
>> +
>> + static void ad_gpo_connect_done(struct tevent_req *subreq);
>> +@@ -1906,6 +1936,19 @@ ad_gpo_access_send(TALLOC_CTX *mem_ctx,
>> +         goto immediately;
>> +     }
>> +
>> ++    ret = sss_hash_create(state, 0, &state->allow_maps);
>> ++    if (ret != EOK) {
>> ++        DEBUG(SSSDBG_FATAL_FAILURE, "Could not create allow maps "
>> ++              "hash table [%d]: %s\n", ret, sss_strerror(ret));
>> ++        goto immediately;
>> ++    }
>> ++
>> ++    ret = sss_hash_create(state, 0, &state->deny_maps);
>> ++    if (ret != EOK) {
>> ++        DEBUG(SSSDBG_FATAL_FAILURE, "Could not create deny maps "
>> ++              "hash table [%d]: %s\n", ret, sss_strerror(ret));
>> ++        goto immediately;
>> ++    }
>> +
>> +     subreq = sdap_id_op_connect_send(state->sdap_op, state, &ret);
>> +     if (subreq == NULL) {
>> +@@ -2725,6 +2768,43 @@ ad_gpo_cse_step(struct tevent_req *req)
>> +     return EAGAIN;
>> + }
>> +
>> ++static errno_t
>> ++store_hash_maps_in_cache(struct sss_domain_info *domain,
>> ++                         hash_table_t *allow_maps, hash_table_t *deny_maps)
>> ++{
>> ++    int ret;
>> ++    struct hash_iter_context_t *iter;
>> ++    hash_entry_t *entry;
>> ++    size_t c;
>> ++    hash_table_t *hash_list[] = { allow_maps, deny_maps, NULL};
>> ++
>> ++
>> ++    for (c = 0; hash_list[c] != NULL; c++) {
>> ++        iter = new_hash_iter_context(hash_list[c]);
>> ++        if (iter == NULL) {
>> ++            DEBUG(SSSDBG_OP_FAILURE, "Failed to create hash iterator.\n");
>> ++            return EINVAL;
>> ++        }
>> ++
>> ++        while ((entry = iter->next(iter)) != NULL) {
>> ++            ret = sysdb_gpo_store_gpo_result_setting(domain,
>> ++                                                     entry->key.c_str,
>> ++                                                     entry->value.ptr);
>> ++            if (ret != EOK) {
>> ++                free(iter);
>> ++                DEBUG(SSSDBG_OP_FAILURE,
>> ++                      "sysdb_gpo_store_gpo_result_setting failed for key:"
>> ++                      "[%s] value:[%s] [%d][%s]\n", entry->key.c_str,
>> ++                      (char *) entry->value.ptr, ret, sss_strerror(ret));
>> ++                return ret;
>> ++            }
>> ++        }
>> ++        talloc_free(iter);
>> ++    }
>> ++
>> ++    return EOK;
>> ++}
>> ++
>> + /*
>> +  * This cse-specific function (GP_EXT_GUID_SECURITY) increments the
>> +  * cse_gpo_index until the policy settings for all applicable GPOs have been
>> +@@ -2766,6 +2846,7 @@ ad_gpo_cse_done(struct tevent_req *subreq)
>> +      * (as part of the GPO Result object in the sysdb cache).
>> +      */
>> +     ret = ad_gpo_store_policy_settings(state->host_domain,
>> ++                                       state->allow_maps, state->deny_maps,
>> +                                        cse_filtered_gpo->policy_filename);
>> +     if (ret != EOK && ret != ENOENT) {
>> +         DEBUG(SSSDBG_OP_FAILURE,
>> +@@ -2779,6 +2860,13 @@ ad_gpo_cse_done(struct tevent_req *subreq)
>> +
>> +     if (ret == EOK) {
>> +         /* ret is EOK only after all GPO policy files have been downloaded */
>> ++        ret = store_hash_maps_in_cache(state->host_domain,
>> ++                                       state->allow_maps, state->deny_maps);
>> ++        if (ret != EOK) {
>> ++            DEBUG(SSSDBG_OP_FAILURE, "Failed to store evaluated GPO maps "
>> ++                                     "[%d][%s].\n", ret, sss_strerror(ret));
>> ++            goto done;
>> ++        }
>> +         ret = ad_gpo_perform_hbac_processing(state,
>> +                                              state->gpo_mode,
>> +                                              state->gpo_map_type,
>> +--
>> +2.25.1
>> +
>> diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
>> index d61471c..3e05858 100644
>> --- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
>> +++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
>> @@ -25,6 +25,7 @@ SRC_URI ="https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \ 
>> file://fix-ldblibdir.patch \ file://musl_fixup.patch \ 
>> file://0001-sssctl-add-error-analyzer.patch \ + 
>> file://CVE-2023-3758.patch \ "
>>   SRC_URI[sha256sum] = "827bc65d64132410e6dd3df003f04829d60387ec30e72b2d4e22d93bb6f762ba"
>>   
> -- 
> Regards,
> Hitendra Prajapati
> MontaVista Software LLC
> Mo: +91 9998906483
> _._,_._,_
> ------------------------------------------------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#425) 
> <https://lists.yoctoproject.org/g/yocto-patches/message/425> | Reply 
> To Group 
> <mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5Bscarthgap%5D%5BPATCH%5D%20sssd%3A%20Fix%20CVE-2023-3758> 
> | Reply To Sender 
> <mailto:hprajapati@mvista.com?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5Bscarthgap%5D%5BPATCH%5D%20sssd%3A%20Fix%20CVE-2023-3758> 
> | Mute This Topic 
> <https://lists.yoctoproject.org/mt/106923444/6955432> | New Topic 
> <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription 
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/6955432> | 
> Contact Group Owner 
> <mailto:yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe 
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13410361/6955432/643796302/xyzzy> 
> [hprajapati@mvista.com]
>
> _._,_._,_
-- 
Regards,
Hitendra Prajapati
MontaVista Software LLC
Mo: +91 9998906483
--------------Gwdm7NUF023c5aUUY4pKaqnh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font size="2">Hi ,</font></p>
    <p><font size="2">any update on this ??</font></p>
    <p><font size="2">Regards,</font></p>
    <p><font size="2">Hitendra</font></p>
    <p></p>
    <div class="moz-cite-prefix">On 12/07/24 11:35 am, Hitendra
      Prajapati via lists.yoctoproject.org wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:17E1620C5E3A3E5E.21599@lists.yoctoproject.org">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><font size="2">Hi Team,</font></p>
      <p><font size="2">any update on this ??</font></p>
      <p><font size="2">Regards,</font></p>
      <p><font size="2">Hitendra<br>
        </font></p>
      <div class="moz-cite-prefix">On 28/06/24 11:08 am, Hitendra
        Prajapati wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:20240628053817.50365-1-hprajapati@mvista.com">
        <pre class="moz-quote-pre" wrap="">A race condition flaw was found in sssd where the GPO policy is
not consistently applied for authenticated users. This may lead
to improper authorization issues, granting or denying access to
resources inappropriately.

References:
<a class="moz-txt-link-freetext"
        href="https://nvd.nist.gov/vuln/detail/CVE-2023-3758"
        moz-do-not-send="true">https://nvd.nist.gov/vuln/detail/CVE-2023-3758</a>

Upstream-Status: Backport from <a class="moz-txt-link-freetext"
href="https://github.com/SSSD/sssd/commit/e1bfbc2493c4194988acc3b2413df3dde0735ae3"
        moz-do-not-send="true">https://github.com/SSSD/sssd/commit/e1bfbc2493c4194988acc3b2413df3dde0735ae3</a>

Signed-off-by: Hitendra Prajapati <a class="moz-txt-link-rfc2396E"
        href="mailto:hprajapati@mvista.com" moz-do-not-send="true">&lt;hprajapati@mvista.com&gt;</a>
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
+From: Sumit Bose <a class="moz-txt-link-rfc2396E"
        href="mailto:sbose@redhat.com" moz-do-not-send="true">&lt;sbose@redhat.com&gt;</a>
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
+Reviewed-by: Alexey Tikhonov <a class="moz-txt-link-rfc2396E"
        href="mailto:atikhono@redhat.com" moz-do-not-send="true">&lt;atikhono@redhat.com&gt;</a>
+Reviewed-by: Tomáš Halman <a class="moz-txt-link-rfc2396E"
        href="mailto:thalman@redhat.com" moz-do-not-send="true">&lt;thalman@redhat.com&gt;</a>
+(cherry picked from commit d7db7971682da2dbf7642ac94940d6b0577ec35a)
+
+Upstream-Status: Backport [<a class="moz-txt-link-freetext"
href="https://github.com/SSSD/sssd/commit/e1bfbc2493c4194988acc3b2413df3dde0735ae3"
        moz-do-not-send="true">https://github.com/SSSD/sssd/commit/e1bfbc2493c4194988acc3b2413df3dde0735ae3</a>]
+CVE: CVE-2023-3758
+Signed-off-by: Hitendra Prajapati <a class="moz-txt-link-rfc2396E"
        href="mailto:hprajapati@mvista.com" moz-do-not-send="true">&lt;hprajapati@mvista.com&gt;</a>
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
++    hret = hash_enter(hash, &amp;k, &amp;v);
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
++    ret = sss_hash_create(state, 0, &amp;state-&gt;allow_maps);
++    if (ret != EOK) {
++        DEBUG(SSSDBG_FATAL_FAILURE, "Could not create allow maps "
++              "hash table [%d]: %s\n", ret, sss_strerror(ret));
++        goto immediately;
++    }
++
++    ret = sss_hash_create(state, 0, &amp;state-&gt;deny_maps);
++    if (ret != EOK) {
++        DEBUG(SSSDBG_FATAL_FAILURE, "Could not create deny maps "
++              "hash table [%d]: %s\n", ret, sss_strerror(ret));
++        goto immediately;
++    }
+ 
+     subreq = sdap_id_op_connect_send(state-&gt;sdap_op, state, &amp;ret);
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
++        while ((entry = iter-&gt;next(iter)) != NULL) {
++            ret = sysdb_gpo_store_gpo_result_setting(domain,
++                                                     entry-&gt;key.c_str,
++                                                     entry-&gt;value.ptr);
++            if (ret != EOK) {
++                free(iter);
++                DEBUG(SSSDBG_OP_FAILURE,
++                      "sysdb_gpo_store_gpo_result_setting failed for key:"
++                      "[%s] value:[%s] [%d][%s]\n", entry-&gt;key.c_str,
++                      (char *) entry-&gt;value.ptr, ret, sss_strerror(ret));
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
+     ret = ad_gpo_store_policy_settings(state-&gt;host_domain,
++                                       state-&gt;allow_maps, state-&gt;deny_maps,
+                                        cse_filtered_gpo-&gt;policy_filename);
+     if (ret != EOK &amp;&amp; ret != ENOENT) {
+         DEBUG(SSSDBG_OP_FAILURE,
+@@ -2779,6 +2860,13 @@ ad_gpo_cse_done(struct tevent_req *subreq)
+ 
+     if (ret == EOK) {
+         /* ret is EOK only after all GPO policy files have been downloaded */
++        ret = store_hash_maps_in_cache(state-&gt;host_domain,
++                                       state-&gt;allow_maps, state-&gt;deny_maps);
++        if (ret != EOK) {
++            DEBUG(SSSDBG_OP_FAILURE, "Failed to store evaluated GPO maps "
++                                     "[%d][%s].\n", ret, sss_strerror(ret));
++            goto done;
++        }
+         ret = ad_gpo_perform_hbac_processing(state,
+                                              state-&gt;gpo_mode,
+                                              state-&gt;gpo_map_type,
+-- 
+2.25.1
+
diff --git a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
index d61471c..3e05858 100644
--- a/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
+++ b/dynamic-layers/networking-layer/recipes-security/sssd/sssd_2.9.2.bb
@@ -25,6 +25,7 @@ SRC_URI = <a class="moz-txt-link-rfc2396E"
href="https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz\file://fix-ldblibdir.patch\file://musl_fixup.patch\file://0001-sssctl-add-error-analyzer.patch\+file://CVE-2023-3758.patch\"
        moz-do-not-send="true">"https://github.com/SSSD/sssd/releases/download/${PV}/${BP}.tar.gz \
            file://fix-ldblibdir.patch \
            file://musl_fixup.patch \
            file://0001-sssctl-add-error-analyzer.patch \
+           file://CVE-2023-3758.patch \
            "</a>
 SRC_URI[sha256sum] = "827bc65d64132410e6dd3df003f04829d60387ec30e72b2d4e22d93bb6f762ba"
 
</pre>
      </blockquote>
      <div class="moz-signature">-- <br>
        <font color="#0000FF"> Regards,<br>
          Hitendra Prajapati<br>
          MontaVista Software LLC<br>
          Mo: +91 9998906483 <br>
        </font></div>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
      <hr>
      Links:
      <p> You receive all messages sent to this group. </p>
      <p>
        <a target="_blank"
href="https://lists.yoctoproject.org/g/yocto-patches/message/425"
          moz-do-not-send="true">View/Reply Online (#425)</a> | <a
          target="_blank"
href="mailto:yocto-patches@lists.yoctoproject.org?subject=Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5Bscarthgap%5D%5BPATCH%5D%20sssd%3A%20Fix%20CVE-2023-3758"
          moz-do-not-send="true">Reply To Group</a> | <a
          target="_blank"
href="mailto:hprajapati@mvista.com?subject=Private:%20Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bmeta-security%5D%5Bscarthgap%5D%5BPATCH%5D%20sssd%3A%20Fix%20CVE-2023-3758"
          moz-do-not-send="true">Reply To Sender</a> | <a
          target="_blank"
          href="https://lists.yoctoproject.org/mt/106923444/6955432"
          moz-do-not-send="true">Mute This Topic</a>
        | <a href="https://lists.yoctoproject.org/g/yocto-patches/post"
          moz-do-not-send="true">New Topic</a>
        <br>
        <a
href="https://lists.yoctoproject.org/g/yocto-patches/editsub/6955432"
          moz-do-not-send="true">Your Subscription</a> |
        <a href="mailto:yocto-patches+owner@lists.yoctoproject.org"
          moz-do-not-send="true">Contact Group Owner</a> |
        <a
href="https://lists.yoctoproject.org/g/yocto-patches/leave/13410361/6955432/643796302/xyzzy"
          moz-do-not-send="true">Unsubscribe</a> [<a class="moz-txt-link-abbreviated" href="mailto:hprajapati@mvista.com">hprajapati@mvista.com</a>]<br>
      </p>
      <div width="1" style="color:white;clear:both">_._,_._,_</div>
    </blockquote>
    <div class="moz-signature">-- <br>
      <font color="#0000FF">
        Regards,<br>
        Hitendra Prajapati<br>
        MontaVista Software LLC<br>
        Mo: +91 9998906483 <br>
      </font></div>
  </body>
</html>

--------------Gwdm7NUF023c5aUUY4pKaqnh--

