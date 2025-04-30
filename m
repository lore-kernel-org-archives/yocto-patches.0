Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA4C369D9
	for <webhook@archiver.kernel.org>; Wed, 30 Apr 2025 17:22:14 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.web10.604.1746033728949498758
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Apr 2025 10:22:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XGfQUHpr;
 spf=pass (domain: gmail.com, ip: 209.85.166.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d46ef71b6cso464575ab.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Apr 2025 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746033728; x=1746638528; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4igk4W2sd1cP8ENUDVazat2FtyiRm+YG3j7we3ebqU=;
        b=XGfQUHprESiI6GWzoyxsxT87oOhF7SCQLxjbcmDlwE9MFYpoVVGJgSxod2W1iv62yA
         LMLA8Sk53CnRhh7QgxgfZTPGKk88m+lK5+dlcsP5K7/6SR5W5vObWRfsiY3WXMwMvVWu
         KZIR7LvjJ5DiOBCi+Pwgz87kwnWaV+OxfzpAxRSRFxu24namjpSd+A151XH3Sxtc8PMW
         j7lVsWJd0LIyRzVgQfQvzqwQh1WpegWBg0DH4FOqzD5C33vG1l1YIbbzCBUOMdRnzJMm
         gQMx7EfN6ibyk33JfiCo/eFPJBiRuidYI29dMuapsELNnJ5EBESVEKdXCI+QaEZGBi48
         Kpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746033728; x=1746638528;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H4igk4W2sd1cP8ENUDVazat2FtyiRm+YG3j7we3ebqU=;
        b=sW5W5t0LQIucfydRNFcicatmfjwVxt2fagPsUq0wcwjsd98FPryAncoUrabiuaxYva
         H1YEnwLv53g7S1oRDpQRkIDlV7tNGaufBB1eq01bO+5e94rhO5uWwIMiyynU+TimUFbG
         L1gYn3LtmuI2w8C5U0t/4inMdUunUS7oLNY6T5LNeMkWUeJAi0XGIKb/3jwAKqkRtLAN
         Hlx8yoohDU/pKK+ivx6uSdAXHpjmDmG4TslOpduPOPrZVXdRkOlcn1WTBmbbqXjUQdGA
         xrLRi9iB+N2uBGYMR/JZee5bSlPdgijti34O41QGJYv3BNEmB64P6/adndYIZDDtnHKE
         9eqA==
X-Forwarded-Encrypted: i=1; AJvYcCVtPrnJ3+wYjHgGQ4BTc8/YzDusSSgNPBvjpqr6/dMwHqPEU8F7y5Xp46kCsugObZ0VI7v0NujqTbxGeozZ@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyGFZBSBvSEIfFoBM0SHsn4rMZhc23Q46hUc5Zsre8DmdiyGVGX
	ZKuGIpJGtzBVqiLoeVEhScwG3065XXa0o3jEyrUNAGZjjtH/WcIE
X-Gm-Gg: ASbGnctcgI0HbBZcO+odPwd9/kvkYOUi4eeWYRTRRlm04NIesaxqKeud8MEJy0WblMf
	k5Ylp83TsfTOaiurCEXvOnJ70F6Ot0ISP9MXF3j4fMk2gL65coO2h+Q4h0VmFcy4CRCMIpgKPwc
	3DeCjDXluZoG3hlsyWSTipmLI9X4vBAPb3+ZXRN9WecEp+PdSMUtfDRSfdycemr6HvkwSAQGqMt
	8a5MF/qjuplt11fSINcrn4/yEKqi/3mRlNXl/heO1Y/7wX5I6M6iN52+urdUte2vxD2edEOuWhl
	3zApUvl5VP5gpJaJzhTILPBL8cBcBEUma6a03fGUe72KvD7jfR9a6cPUcUKMeliPb7s9AngilJC
	RTcAozmEmaoipaJK/1A==
X-Google-Smtp-Source: AGHT+IHjM7u3U+ubF85NSOEQ/v8DLgZUGkqKoOaIHzQONQ3pesN7PFDfxrMGKpQBL+m8qV/Ouzh/JA==
X-Received: by 2002:a05:6e02:1a2a:b0:3d4:2306:6d6 with SMTP id e9e14a558f8ab-3d96772ab5emr50930835ab.21.1746033725375;
        Wed, 30 Apr 2025 10:22:05 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f2d8accsm9042635ab.38.2025.04.30.10.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 10:22:05 -0700 (PDT)
Message-ID: <f321d264-eb73-4b2d-8a93-8badc9097f57@gmail.com>
Date: Wed, 30 Apr 2025 11:22:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: oddjob - allow
 oddjob_mkhomedir_t privfd:fd use
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Apr 2025 17:22:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1425

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-oddjob-allow-oddjob_mkhomedi.patch | 62 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch

diff --git a/recipes-security/refpolicy/refpolicy/0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch b/recipes-security/refpolicy/refpolicy/0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch
new file mode 100644
index 0000000..bb25790
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch
@@ -0,0 +1,62 @@
+From a80bd03836c75b0a9b4d0d342a0000ef20c5cd2d Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Wed, 9 Apr 2025 17:34:10 -0600
+Subject: [PATCH] oddjob: allow oddjob_mkhomedir_t privfd:fd use
+
+type=PROCTITLE proctitle=mkhomedir_helper user123 0077
+
+type=EXECVE argc=3 a0=mkhomedir_helper a1=user123 a2=0077
+
+type=SYSCALL arch=armeb syscall=execve per=PER_LINUX success=yes exit=0
+a0=0x5b79d8 a1=0x5a64d0 a2=0x5b0f10 a3=0x0 items=0 ppid=429 pid=1369
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=ttyAMA0 ses=unset comm=mkhomedir_helpe
+exe=/usr/sbin/mkhomedir_helper
+subj=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+key=(null)
+
+type=AVC avc:  denied  { use } for  pid=1369 comm=mkhomedir_helpe
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+tcontext=system_u:system_r:getty_t:s0 tclass=fd
+
+--
+
+Ref:
+https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20250213/policy/modules/system/getty.te#L12
+
+https://danwalsh.livejournal.com/77728.html
+https://github.com/SELinuxProject/selinux-notebook/blob/20240430/src/type_statements.md#typeattribute
+
+--
+
+Fedora:
+$ sesearch -A --source oddjob_mkhomedir_t --target getty_t --class fd
+allow application_domain_type privfd:fd use;
+allow domain domain:fd use; [ domain_fd_use ]:True
+
+$ getsebool domain_fd_use
+domain_fd_use --> on
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/a3a6b17045412be07f63581f6e10310175e82ddf]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/oddjob.te | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/policy/modules/services/oddjob.te b/policy/modules/services/oddjob.te
+index 6ea785851..299077739 100644
+--- a/policy/modules/services/oddjob.te
++++ b/policy/modules/services/oddjob.te
+@@ -79,6 +79,8 @@ kernel_read_system_state(oddjob_mkhomedir_t)
+ 
+ auth_use_nsswitch(oddjob_mkhomedir_t)
+ 
++domain_use_interactive_fds(oddjob_mkhomedir_t)
++
+ logging_send_syslog_msg(oddjob_mkhomedir_t)
+ 
+ miscfiles_read_localization(oddjob_mkhomedir_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 7b6822d..2eadeb7 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -81,6 +81,7 @@ SRC_URI += " \
         file://0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch \
         file://0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch \
         file://0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch \
+        file://0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

