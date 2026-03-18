Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4E610854CF
	for <webhook@archiver.kernel.org>; Wed, 18 Mar 2026 02:50:04 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5769.1773802196120175697
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 19:49:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HbvyztJS;
 spf=pass (domain: gmail.com, ip: 209.85.167.179, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-467161c4b89so4034723b6e.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 19:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773802195; x=1774406995; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgzW2Owhx03KAa+IUjYDMK3urqlVP4FWlO9I8I7T6ow=;
        b=HbvyztJSCJP5WWWjnvLWB2BoRtrxaPz3R5bNHayIR0/t8gLI1RX22uTucFwGkXoHXh
         jmSn1nUdNN4yHgqLGqnjTs6ZESYM+7h8HiZqhwmMUWtMfxP6VJrKv0ZdWR6vr6ItiwEX
         Wk2DWFk8LowidyrVlkA/3EFIVAUuYNAPectNxNYU2dpQrJQ6Fv3cRFLLKVrCN4EUow6H
         fn82EhnPbC9moSbRm7wBcBXI4P3032mvGSO8kblVPjCnav9BeiX5A1gewlDFj/FVgNir
         jwCFmzuGwbXNWF8MMk2WPOi0NyycbF/+m0ysmFOY+AQ1OZliX4oydqKgupY6rJTFa8Ps
         b0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773802195; x=1774406995;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgzW2Owhx03KAa+IUjYDMK3urqlVP4FWlO9I8I7T6ow=;
        b=AazQQeVGMinNjZ2rGSlBZTSEMqL5ww1OI6ZYEjyz3ZxAxGX0ZdLh0bmQGyqMnFvHLF
         gE8tLHxi7R2YqFGP3rH54RAgvAx60URAULQ+y8KgCbLtsBt7lNnOxgU+daPLJ10eDGdU
         bsC+hiYc4FrtDVslP1gvLloBfIksmvPBlIOVzVFUYqhgmIv1I+GtWQRdxFFZq5G58Duf
         jSrt4smFnO8comPl64wL9xkv2KFCjsN9cJ8XURz6ik0sZPmCpDqLFvAszwPAOsPwQMdb
         DPmbeyMquUEOnqjP2An9XlgVY4Ll2PNcMuZIkSOXVfy9/0em4YOePmX58o2ysUwGKp1z
         vTsg==
X-Forwarded-Encrypted: i=1; AJvYcCXt1X91q/a400fqd6CnCbLy3tzJqO7gve9SdADsQ6LkkmzNhwEvxXMlQt9BCQtFxJgrvaomeSEEDVtAg15S@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzbyIJFDk3Te5cGn/eRfnARlRJEWvAGuW7usiQTBKeNUXP1jidI
	DyUR/zLNY/doAVh3mwcK/BkAEpH8xk94D5EX9AilljeiUWDr2//BLF5F
X-Gm-Gg: ATEYQzzl7rgGPKosQKLvntSTj3iqhmefQQg2jCSyNa4KSLsa7peQas8kE31vLMDFGyE
	dRCZ2rE13Fuh4QJrdriWW5Wf3y11BL0/QF/3mg7zxxolLaa99tlT9vZIu+4uW71LFZap4h7NQSD
	DgCAyisyy71unUiWrK2rgQ1rgX4YQFlhIZTtu/uly1nUaqDltM/eD3x4jwBi4z+cUSS0HflFmyE
	SbAxvE2AO9gEsako4/kFO/0gMbyRj8uAz69AmYUQ1RdbSWu0wzh2PeRD54s8EU6vWf9fB7h7OK9
	3u8wYB80bSFoyCggtc0OkSHOfdGjVG0P7K2WUf9noTnQtKZthGfhZ58XgLbvde8HnMeWAoqK4dQ
	2zsmz1g8/dFXaiIC5s6kMnEzkJehZ1oVvfIVdDpmuoSnUi3IZYW4WZoUojZDzUBZreBCeqIx0Wg
	XF4S1bjEjpA/12YyS+2d+1yCHPlcgUGAjjOVyhYUG9vGgVEKVeFaqEr/k1yXkBb0L4MKb0P9gOc
	XZf
X-Received: by 2002:a05:6808:16a1:b0:467:db8:e46d with SMTP id 5614622812f47-467ba295fabmr1069680b6e.34.1773802195324;
        Tue, 17 Mar 2026 19:49:55 -0700 (PDT)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467bab02e3esm857350b6e.17.2026.03.17.19.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 19:49:54 -0700 (PDT)
Message-ID: <9d9aa8f3-dba3-488a-bffe-f19d100fc3ad@gmail.com>
Date: Tue, 17 Mar 2026 20:49:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][whinlatter][PATCH] refpolicy: authlogin - label
 /var/lib/lastlog (lastlog2)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 02:50:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3503

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-authlogin-label-var_lib_lastlo.patch | 29 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 30 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-policy-modules-system-authlogin-label-var_lib_lastlo.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-authlogin-label-var_lib_lastlo.patch b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-authlogin-label-var_lib_lastlo.patch
new file mode 100644
index 0000000..0868a1b
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-authlogin-label-var_lib_lastlo.patch
@@ -0,0 +1,29 @@
+From 8f80c6613191400ca0d9d926f4519fc6c264aa66 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Thu, 15 Jan 2026 16:20:29 -0700
+Subject: [PATCH] authlogin: label /var/lib/lastlog (lastlog2)
+
+https://github.com/fedora-selinux/selinux-policy/commit/bbbaa364c2b93795127a1ffbf0f90b244753d75a
+"Label /var/lib/lastlog with lastlog_t"
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/6aa166162302e2d06f62762d4be5c9054c2d13cd]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/authlogin.fc | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/system/authlogin.fc b/policy/modules/system/authlogin.fc
+index b3c2f56b4..6dbb7a499 100644
+--- a/policy/modules/system/authlogin.fc
++++ b/policy/modules/system/authlogin.fc
+@@ -51,6 +51,7 @@ ifdef(`distro_gentoo',`
+ /var/db/shadow.*	--	gen_context(system_u:object_r:shadow_t,s0)
+ 
+ /var/lib/abl(/.*)?		gen_context(system_u:object_r:var_auth_t,s0)
++/var/lib/lastlog(/.*)?		gen_context(system_u:object_r:lastlog_t,s0)
+ /var/lib/pam_ssh(/.*)?		gen_context(system_u:object_r:var_auth_t,s0)
+ /var/lib/wtmpdb(/.*)?		gen_context(system_u:object_r:faillog_t,s0)
+ 
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 8486203..e65edcf 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0057-policy-modules-system-logging-allow-syslogd_t-syslog.patch \
         file://0058-policy-modules-system-logging-allow-miscfiles_read_g.patch \
+        file://0059-policy-modules-system-authlogin-label-var_lib_lastlo.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"

