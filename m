Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418BDC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 03:58:26 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.38677.1743998299290497235
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 06 Apr 2025 20:58:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hM6x8qzt;
 spf=pass (domain: gmail.com, ip: 209.85.166.44, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso125079639f.2
        for <yocto-patches@lists.yoctoproject.org>; Sun, 06 Apr 2025 20:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743998298; x=1744603098; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWDpEeyQ+HT+gDKkNqLFbJIAWRwR2eW70GxQLAJGPg4=;
        b=hM6x8qztCtK44zr51Fa/RFUPsBAModYYM8JmGOqMTTn7RQql/3NMEhbhx8/To7EJJl
         RoaNirqJ4h0o1BHh1HXNPyMJROUcBLue/KbPNDWIDL7Cn9slM5TaPQ/cev9U+RjVls8D
         WKx8+iuYy3oTRQzCcILu4MSPdbVUaLkbUkO/88BHLjZHN65UOVsAOebx6GHOD+fJE/MW
         0jreIf2+frLNRc/4JCKni9z+KTRiLIPddHWvylfaNzyJbHLgcuLTZ8U/3f4DYo4kpREy
         PXyYIxove3j0caJkttH8O7oJHL623AzS7JjA2AZzoVG6UNj/6oMXKIwBNz0LTEpOk2gI
         TIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743998298; x=1744603098;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWDpEeyQ+HT+gDKkNqLFbJIAWRwR2eW70GxQLAJGPg4=;
        b=F9W6nHjSojaGSV2blRitxIpB7U7HIzI+6hAvwr9S8KuTTTGY4jnnfXQuMASLAoAf0y
         M0/57Bo0jscJjPlns2vZGPkNfRocXT12wRdF/GKbrSX3zYYoppt2QKII2IZemIh3xvwZ
         MU2tNY01rXxZsyrgrDN/v1gPZrywPIRdMh46cuigPmFBoGSsHMe+zAgmyg6bexWHR+wC
         Xjolj9EYHpkTpWXErS7BV/VJ3lVuMF2eTsv780vDtNTtkb+e1Vahl43VyhuRDm1gOAJ1
         wHUzCRXZ+5RdzkcD504UXcbTZxBdOIVJX5ftXwlV5SV9JQf7bvdeKp7ofILQu3oyDoji
         1TWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcfsfKjiJnpynluv5RP+9Qg/PFmUkIRqFCc0cZgf2mg+se58RZ5SC6fm48fRiomxwx2z+juWg6QkgnrQCF@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxYuCG23ZDIUDx2QTEC+Gy5VPEyvJRCtUkDYMDoD9gNS7ChJJmw
	+/IP1UdGrEPvqp809cm6dIpV6XgjnWGAl2ExDILNpJcBFHlUVmlS
X-Gm-Gg: ASbGncvNjIigJQIp7LgeqkYJlCSKA6raHMzldD9Wz44OjlXhKGGk4J7DwhBSR/9om70
	eCCtJMIl79qLIx72POJLHNLVWv8xU7sQYazO/uTqVFkqNOOsWOxYnBs9BHAFBRCItsXl0R5qjVN
	MMsvOOe34OAjuy0p/yo5ElPvGufpQwXe8bxgBQ9gTtNaSH2nVi6frSEfcLI/bo+MqM2IO1YWfAj
	a2oAGk+jreeNyZrC69KoJ2yYi/YV+VeFvgaKR+E5k4onuhLXFfVmDqjOm7lfvSh/BBS0UQsYaga
	UtEnbcZdaPlx9D9nVKjGBmsxbkDBCuS1UCUPBjan/j9ebbDJh/mBDs3JrVozd0nt3AmKLtRjeVn
	gKO4V6wdiluTvHiKwo0JuJQ==
X-Google-Smtp-Source: AGHT+IEECv5iL2Dk2YVEYFnJDtkD99Z8SgEZjr/S6NKvn2FlpKCa5Uiusq/xDpzaIfLjL2Ov78kI9A==
X-Received: by 2002:a05:6602:480c:b0:85b:4d28:2aa9 with SMTP id ca18e2360f4ac-8611c2cf7fdmr1286991039f.4.1743998298341;
        Sun, 06 Apr 2025 20:58:18 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861112890dfsm172677739f.16.2025.04.06.20.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 20:58:17 -0700 (PDT)
Message-ID: <b9270a4d-2007-4ae8-a3c7-83667fed644e@gmail.com>
Date: Sun, 6 Apr 2025 21:58:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: files, init - filetrans
 /run/machine-id etc_runtime_t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 03:58:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1288

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ultiple-filetrans-run_machine_id-etc.patch | 109 ++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |   1 +
 2 files changed, 110 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch

diff --git a/recipes-security/refpolicy/refpolicy/0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch b/recipes-security/refpolicy/refpolicy/0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch
new file mode 100644
index 0000000..dde14e6
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch
@@ -0,0 +1,109 @@
+From 799cea7a4f7d604c065897346ae3a2e59df678cd Mon Sep 17 00:00:00 2001
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
+index 00146fc23..e0089254e 100644
+--- a/policy/modules/kernel/files.if
++++ b/policy/modules/kernel/files.if
+@@ -3776,6 +3776,25 @@ interface(`files_dontaudit_setattr_etc_runtime_files',`
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
index b433a1e..7701023 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -77,6 +77,7 @@ SRC_URI += " \
         file://0059-policy-modules-system-unconfined-fix-oddjob-security.patch \
         file://0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch \
         file://0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch \
+        file://0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

