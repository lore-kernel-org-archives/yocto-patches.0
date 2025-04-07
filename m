Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912ADC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 16:58:42 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.53189.1744045116656855407
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 09:58:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kJxONhK8;
 spf=pass (domain: gmail.com, ip: 209.85.166.51, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85e15dc801aso370073639f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744045116; x=1744649916; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvAzJcIBuUU61GuHOudKEthxr36CZfQPNSFv8tkTGH4=;
        b=kJxONhK82RW9PcXPPVLGV11N8a3FKDuC9LehSI9RSeOjQnfCUtxiJL9UtQhKIGYVa6
         zfNqMCkKG6wDuXSDibYqCH9Twp0xVR+OiautlhmOKQRnT+Ccp/EJ2FkDc0Ar7PqT0Tz+
         7FzdTh7Etx8EIbsADUfL6q3Xs4+PGhH/kLB6ZErn3kgb0R2+brHd8Gn7Y71BJX6lmZWx
         22m9kDKiSvU+gQ/wMM5RuPj8eIki0PIPy9A2XKZpLyT55a0nlwfg5kSshsQwWE2/GJNB
         u11yDmnZWxtxIyvJS6rqn1BYIbmk1a5nqGyjjxa8HHdmqPnUvFOhgxs1dyBEgL65zYI3
         8muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744045116; x=1744649916;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xvAzJcIBuUU61GuHOudKEthxr36CZfQPNSFv8tkTGH4=;
        b=Wr2XJAuMzP7eoUilI/6urLQOS1Te4U2REauDAl+56OGMC2wAm3Wxy0z8UBAJC/3e2g
         OU6FR10d60jNbFPUuq3mc1jftbmnRBzpU53hVkdFCsvUN3JmaLqGcfjpExsEDFdFQEkP
         LHKYzaTOmZj2ItODVvDcVdt7mJ/DA2SYX8m10Vj//AZu/gWEyoL+/3CcnTgW3O46oMz0
         LrCaIew5bfjtTKlmDBiOOO1De4UWt+uixqZqgftKAwjkATA+gwJp3DLk6Ct2LY39PgiI
         iRWhXEgQMOsCPWbqL2zhT4teLSPpd+lM7aLmlQAhQaonNx47zvyKVCutnT3mCFiy+lhZ
         te1A==
X-Forwarded-Encrypted: i=1; AJvYcCUn3j2knbre3BViVdM2LS/yyFervH766lvZuA1reUROZFSHqRILAA7TTHFTmL39GoSIsm7uyxquyMlUz/gI@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwIB1UOhJamGP7+c7YV0zSX31odRWpWjddvYpPnuIuo3mTp8umW
	Kzl5/16srQKiCpf76MUdE2Ly7dR9RyySBFF3YpxGPmheQQGdjBGs
X-Gm-Gg: ASbGncsy+2p3nawc04f+H7v626mrXYpHPXtzoxfhp/iBXLqco4QsDInqvn4ETNmqVW8
	sZU0WFywyqCaG25+X5lJ0dP22Utq3NX+YqjZqCCLjw7b79SXRIFGdRVBiC4itBnr8jvh8kR8YEp
	7bDSFb7pCLvEzwF79ibI8LXugz1fAubvkAu0868NbjgqvDEyvTG1Q4VyXZZOZSUnjD7vxc/LvFb
	tTHAlq804LkyuY2/TMDOkwuZzhaYSVUQSFPXIMetFr/Bl+9DZTwWs3lO+7P7gy9lY/a+Nd/9fGg
	IRnMt86b3vYID3ln/x2b2USF+gc6+RdDLj1E/0+a6gxPo01E13TN+q9O8lCe5cwHYFeHfhQoPDS
	geSFfS6EcEvlVydMV2WG3rA==
X-Google-Smtp-Source: AGHT+IE5eXeOTH8/Y6QKSO18S/ltdVLvvtx1aj/ZLkaBYSqAT8UTpE2esHk7OQPDllP60ErY8/xz4g==
X-Received: by 2002:a05:6602:358f:b0:85b:46d7:1899 with SMTP id ca18e2360f4ac-8611b4dfca5mr1506637839f.9.1744045115771;
        Mon, 07 Apr 2025 09:58:35 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f43d1337sm11380173.30.2025.04.07.09.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 09:58:35 -0700 (PDT)
Message-ID: <8c91cb7c-5db8-4cd4-b932-bca5fab2eec8@gmail.com>
Date: Mon, 7 Apr 2025 10:58:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: files, init - filetrans
 /run/machine-id etc_runtime_t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 16:58:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1295

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ultiple-filetrans-run_machine_id-etc.patch | 109 ++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |   1 +
 2 files changed, 110 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch

diff --git a/recipes-security/refpolicy/refpolicy/0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch b/recipes-security/refpolicy/refpolicy/0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch
new file mode 100644
index 0000000..8cab157
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch
@@ -0,0 +1,109 @@
+From befa4fcb91c883c9ff93f0080d12d3d5004dc8cc Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Fri, 14 Mar 2025 09:04:49 -0600
+Subject: [PATCH] files, init: filetrans /run/machine-id etc_runtime_t
+
+type=PROCTITLE proctitle=/usr/lib/systemd/systemd-logind
+
+type=SYSCALL arch=armeb syscall=openat per=PER_LINUX success=yes exit=21
+a0=AT_FDCWD a1=0xb6eb6c2c a2=O_RDONLY|O_NOCTTY|O_NOFOLLOW|O_CLOEXEC
+a3=0x0 items=0 ppid=1 pid=435 auid=unset uid=root gid=root euid=root
+suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset
+comm=systemd-logind exe=/usr/lib/systemd/systemd-logind
+subj=system_u:system_r:systemd_logind_t:s0 key=(null)
+
+type=AVC avc:  denied  { open } for  pid=435 comm=systemd-logind
+path=/etc/machine-id dev="tmpfs" ino=13
+scontext=system_u:system_r:systemd_logind_t:s0
+tcontext=system_u:object_r:init_runtime_t:s0 tclass=file
+
+type=AVC avc:  denied  { read } for  pid=435 comm=systemd-logind
+name=machine-id dev="tmpfs" ino=13
+scontext=system_u:system_r:systemd_logind_t:s0
+tcontext=system_u:object_r:init_runtime_t:s0 tclass=file
+
+--
+
+https://www.spinics.net/lists/systemd-devel/msg09631.html
+Reproduction and suggestion to use dedicated type (TODO)
+
+--
+
+Fedora:
+
+$ matchpathcon /run/machine-id
+/run/machine-id system_u:object_r:machineid_t:s0
+
+https://github.com/fedora-selinux/selinux-policy/blob/v41.33/policy/modules/system/init.fc#L67
+
+$ sesearch --type_transition --class file --source init_t
+--target var_run_t | grep machine
+type_transition init_t var_run_t:file machineid_t machine-id;
+
+https://github.com/fedora-selinux/selinux-policy/blob/v41.33/policy/modules/system/init.te#L241
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/e053fced8c911bc390a81ca5ee7f3baccecb70e1]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/kernel/files.fc |  1 +
+ policy/modules/kernel/files.if | 19 +++++++++++++++++++
+ policy/modules/system/init.te  |  1 +
+ 3 files changed, 21 insertions(+)
+
+diff --git a/policy/modules/kernel/files.fc b/policy/modules/kernel/files.fc
+index c5012e6b4..3cdfd2f80 100644
+--- a/policy/modules/kernel/files.fc
++++ b/policy/modules/kernel/files.fc
+@@ -154,6 +154,7 @@ HOME_ROOT/lost\+found/.*	<<none>>
+ /run			-l	gen_context(system_u:object_r:var_run_t,s0)
+ /run/shm		-l	gen_context(system_u:object_r:var_run_t,s0)
+ /run/.*				<<none>>
++/run/machine-id		--	gen_context(system_u:object_r:etc_runtime_t,s0)
+ 
+ #
+ # /selinux
+diff --git a/policy/modules/kernel/files.if b/policy/modules/kernel/files.if
+index f2c714579..9ade962a9 100644
+--- a/policy/modules/kernel/files.if
++++ b/policy/modules/kernel/files.if
+@@ -3734,6 +3734,25 @@ interface(`files_dontaudit_setattr_etc_runtime_files',`
+ 	dontaudit $1 etc_runtime_t:file setattr;
+ ')
+ 
++########################################
++## <summary>
++##	Create a machine-id file in
++##	the runtime directory
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`files_runtime_filetrans_machine_id',`
++	gen_require(`
++		type etc_runtime_t;
++	')
++
++	files_runtime_filetrans($1, etc_runtime_t, file, "machine-id")
++')
++
+ ########################################
+ ## <summary>
+ ##	Read files in /etc that are dynamically
+diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
+index 8af34aa7e..026f77c16 100644
+--- a/policy/modules/system/init.te
++++ b/policy/modules/system/init.te
+@@ -178,6 +178,7 @@ allow init_t init_linkable_keyring_type:key link;
+ # For /var/run/shutdown.pid.
+ allow init_t init_runtime_t:file manage_file_perms;
+ files_runtime_filetrans(init_t, init_runtime_t, file)
++files_runtime_filetrans_machine_id(init_t)
+ 
+ # for /run/initctl
+ allow init_t init_runtime_t:fifo_file manage_fifo_file_perms;
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 71b143b..c40d6e7 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,6 +77,7 @@ SRC_URI += " \
         file://0059-policy-modules-system-unconfined-fix-oddjob-security.patch \
         file://0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch \
         file://0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch \
+        file://0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

