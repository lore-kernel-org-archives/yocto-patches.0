Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C24CCA470
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 17:01:36 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web11.660.1759251689219192208
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Sep 2025 10:01:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Zo+uKzOF;
 spf=pass (domain: gmail.com, ip: 209.85.166.175, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4248b34fc8eso61464095ab.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759251688; x=1759856488; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn1rMQyG2rjFSq4m+ZMMALP+QpQue1xW6EeRgbt4e4A=;
        b=Zo+uKzOF8ectwZdi0RLt0V1VLdHAlLOmgXQq54fGtPBxvljNOOPNTpUeBDkjIi7UDY
         EstH2HNDXLBcv3P7vd4NOMn3JOMrVH9qwpFnUP0Us3ccI5wE8FVTxXRuM6l4c+KiXvBA
         YBn05vdUPfNC0FF1ONEEwFhugAMMTaRDVA+iBFeycLnMJpAlNfJNyoT1/JV0/KkFGkO3
         b8WaWq6Mx/pgvLG26SijnW013iYXPjgS7XHMjPfR6punuccMpeVEiNB6mLy2wdTim4MI
         tXIcmBbaTNJxVXKHFHvtUbuX09GZTwaJlsdhfEaW5t+DbWYaYkuL4llp9altDM0bj4m6
         lI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251688; x=1759856488;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tn1rMQyG2rjFSq4m+ZMMALP+QpQue1xW6EeRgbt4e4A=;
        b=k3ki1+Uqn9Hv4r9WGTBa7kO8vsz9iZa8l2WFWJXE5n1NvqND4QeUA1EsLWfIw1fgCO
         25UZx2vGSk5XbJPj9KJF60AaY55Yt2Dji+Y5m/Lue5zaSk9djHB+INTAC2MzLCpH503T
         VrxrYfVAO++ContimzsfDV6oOAc0OMSnCb818XpZZXPlfwAv8T7iSzKJ6c9htqexMn0Q
         Jg57BOUo7dDIvTcEriGL4b7KZczmkUY8PiQgjyo2wxE+9YVLUtbYXQFvLdX6O5S/4XIx
         YADVCagmf6bxEnHamZe42QqB5mqZ8l+6rmRl2OKh/tnGwlNAlFlwVHj88g3L7QgfL9IX
         PGNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAHXoBgTxVkS/Hj+YCMtC3t/I7hYgUV81M2u6B/Rr8TZzjY/gd5BrbenlXhqArYVQd8omfD/FCmC2V/UGN@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwRNVmgGL0V5pxOiMim8Ddep1xt49+3xsYKHBMKz3xeeZZH13ZD
	253WSqznZ+YXBlBybyFcdAuwvTBh+f+0fyXlkYXgxdIe6dMr4d7GuxYD
X-Gm-Gg: ASbGncuWyS1LveRfuwaTuXHDS4NZnUMuMg9zhxbpU8ajhtVLRhOXmEFoPZmX645kHLx
	FVrERv+PHc3qxbh7o0v29EMAPUy5TsGFvK/0NTUehQBfMxZ6Gtv1SDp9sFGT8E5AziLTUMxHuTF
	MFAIKJMbD59R03FGnAJEEhvGSdsN9Qz1b905PaEEWD1R9z2fDJWddHePSLKRynX+YeUeHkZOsZl
	UZ/JeF4dQPz0SvN0gFYlX+bK6/21acKMXih5GTxQSWfqtv9oHPPmbcMdGUw2GnZbO5VoHMTu2EX
	Ba+JlENUEcnnEGlkapmi9nKzw7914WiW1F/jfU2wcTXo7kMUw+A/fhIEui/r5GgSuDDCEg39jxp
	af9xOnYPJ9srrxpWx2xvKkYC4K7ISguefX4zdjrXWv/cqBplO6yk7DoaFgb+Zs93pjWO22p8oQn
	nxg5Y9ODgIgX+PvuDfV9rm0d+GK1NL5oMN
X-Google-Smtp-Source: AGHT+IFznxpS2hpXJV7vBhaJxf5StlpcXd05/M4+0UHFnQ0bfG7eYS438Wll6i+QxEQxG7eWD0uL0Q==
X-Received: by 2002:a92:c269:0:b0:42d:1902:8d24 with SMTP id e9e14a558f8ab-42d8162cc3fmr9951025ab.30.1759251687833;
        Tue, 30 Sep 2025 10:01:27 -0700 (PDT)
Received: from [172.26.252.3] (174-16-207-42.hlrn.qwest.net. [174.16.207.42])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425c0546cb0sm69063905ab.42.2025.09.30.10.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:01:27 -0700 (PDT)
Message-ID: <ef5510b4-6ee3-46ba-bf08-854f0b2d96be@gmail.com>
Date: Tue, 30 Sep 2025 11:01:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: oddjob - allow
 oddjob_mkhomedir_t user_terminals
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 17:01:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2263

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-oddjob-allow-oddjob_mkhomedi.patch | 54 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0058-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch

diff --git a/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch b/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch
new file mode 100644
index 0000000..79ed6a9
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch
@@ -0,0 +1,54 @@
+From 01a7c6f1878ae113f256024ccffd83906eaccb4a Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Wed, 16 Apr 2025 16:45:56 -0600
+Subject: [PATCH] oddjob: allow oddjob_mkhomedir_t user_terminals
+
+type=EXECVE argc=3 a0=mkhomedir_helper a1=user123 a2=0077
+
+type=SYSCALL arch=armeb syscall=execve per=PER_LINUX success=yes exit=0
+a0=0x5685f8 a1=0x577518 a2=0x572f10 a3=0x0 items=0 ppid=427 pid=1367
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=ttyAMA0 ses=unset comm=mkhomedir_helpe
+exe=/usr/sbin/mkhomedir_helper
+subj=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+key=(null)
+
+type=AVC avc:  denied  { append } for  pid=1367 comm=mkhomedir_helpe
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+
+type=AVC avc:  denied  { read write } for  pid=1367 comm=mkhomedir_helpe
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+
+--
+
+https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20250213/policy/modules/system/userdomain.if#L4340
+https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20250213/policy/support/obj_perm_sets.spt#L272
+
+--
+
+Fedora:
+https://github.com/fedora-selinux/selinux-policy/commit/c03dfdc29340d93008b9ff2edc6d6b55b1f2d2a0
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/e9a7c96ba0bca21d455bcc80cbe96caaebf32a33]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/oddjob.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/services/oddjob.te b/policy/modules/services/oddjob.te
+index 299077739..814d48460 100644
+--- a/policy/modules/services/oddjob.te
++++ b/policy/modules/services/oddjob.te
+@@ -100,4 +100,5 @@ userdom_home_filetrans_user_home_dir(oddjob_mkhomedir_t)
+ userdom_manage_user_home_content_dirs(oddjob_mkhomedir_t)
+ userdom_manage_user_home_content_files(oddjob_mkhomedir_t)
+ userdom_manage_user_home_dirs(oddjob_mkhomedir_t)
++userdom_use_inherited_user_terminals(oddjob_mkhomedir_t)
+ userdom_user_home_dir_filetrans_user_home_content(oddjob_mkhomedir_t, notdevfile_class_set)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 0661e6c..d29d50c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -73,6 +73,7 @@ SRC_URI += " \
         file://0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0058-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

