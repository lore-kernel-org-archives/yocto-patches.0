Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDEC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 16:47:02 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web10.52917.1744044412461839737
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 09:46:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=SrKIbeHJ;
 spf=pass (domain: gmail.com, ip: 209.85.166.175, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d5bb2ae4d3so15238065ab.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744044412; x=1744649212; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yu096giGqg1MGsoHTAVQI9e/V6pcZmOsYTloEcDTMwg=;
        b=SrKIbeHJgHn4E9uKy3foAsd27FvUaSbUQ6xRc+Oxdv6o8fPnTwPw2oA2/JMl0l9Raw
         /Zaz0zgiDXfO90rwI+4ZL26Zh96ARmhbkF1z4eyGfuJoev0EHhyfqrBD4NwEygQGm8rz
         jiMA2GF5i2kgnKXVANzq3bASquKe1kZnx+iNPMtvc0zWaSSbxnXsOkik7FEwPeDDyotg
         DYGOvZZ/7lN3oNFVVu7bUTCq9hAIAHdiQVA7GwEF+zYEJmoNLIKEHAKf0Gf3tCpc8DcJ
         bFg4iO9Q41mWL5rUWNKasSA7mVTRZ/+JvcpiVz3uqTmSf9WFtYnkYkmBMfkck7tvaqF9
         72cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044412; x=1744649212;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yu096giGqg1MGsoHTAVQI9e/V6pcZmOsYTloEcDTMwg=;
        b=Fa+m9dNNh9xi7+/taPup+XjufvTV83BYtCQvQI0bYGfd90CaAIQFSqUWCfDy45opkc
         q2Ld8OsITzGGNmJdYJSOprAlojV6RJvvs7sjltgfyDB9DQJqFhmYlukmQb3rRP3wdHYl
         SP4762Dm+/agHUFFPBfCG+uxzOMrqcMOFdPINIdabBDdtb+9rdIIN4WEbhPzftPJXU6a
         2ibWg6ydl02sG0SyW671EO399Ne3BmMYvRCKXbFw0xsmITsCVKslDPqU+uxNjXlGIpXC
         r7piR2rx7VkoBklwRraPRqWeKNy1XKP4LJlVj8R/ikDlAGFQWpOsH/7V/3xi7RJrFF4g
         06ow==
X-Forwarded-Encrypted: i=1; AJvYcCUNwhTFoFRBOCfmi95aa/jqQu7U9xKL35f49AuWMza/ITABuywbYPARZV+YegVfFIw8qYr3i9HNNKi6Of/y@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyEXwXJ+5T0bksL7vI/vTVJNAoNPIKOPXpIr3COOlysxF1Q2K/J
	BRrtppSbrDldOFWhqyADr+jHcB67jGTN8vxDTqiLC8BBe8QsL2OP
X-Gm-Gg: ASbGncvTGB1uNg8JXxgYSCswXgDec481qNaQdrLIpJlvIeLw2JKRCR5h5q3U16z+4so
	K0vQEFf4hLiUmqykT/zW/yPo9JojiSdVMdxT8KLn+Dss69d+1kK2b2BbQASjqEE/NF7GsIk/Wy9
	3P3KT3XT7CXkAqu1Ixz0vx0Qqbl3lPCQeZakiz6RfMuiPRs5tktROz14LIx9kum2VjCoEusUQs3
	X+Dy/pfbdbSUbrBubMoy7HIefpumy50F+S07AVLKS/dP/4Uv5bqBX0NztXFMUzHGFq+Vgz+rbd0
	RoeRrESAkUq1kpNrvaGu0+hYTtzgDx62O2/mB8ARIW0fcFEvoYhrPQ5QGdTbxysa1EXm0t5fI0F
	/YpH7gFDoXUxMPGjSCpDoDg==
X-Google-Smtp-Source: AGHT+IEaX1Cgc96X+L0Lnjb9xhJUF5I+J9iU72hC2gkDTjU7ZNyUqnwSAbYQmcuKM9HQIhETfoxkKA==
X-Received: by 2002:a05:6e02:1a49:b0:3d4:276:9a1b with SMTP id e9e14a558f8ab-3d6e3f755b1mr114916745ab.16.1744044411539;
        Mon, 07 Apr 2025 09:46:51 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d6de7b9da6sm25705955ab.22.2025.04.07.09.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 09:46:51 -0700 (PDT)
Message-ID: <c969c32f-49ba-4b71-a1a2-62297a573a9a@gmail.com>
Date: Mon, 7 Apr 2025 10:46:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: locallogin - dontaudit
 sulogin_t checkpoint_restore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 16:47:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1294

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-locallogin-dontaudit-sulogin_t.patch | 53 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch

diff --git a/recipes-security/refpolicy/refpolicy/0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch b/recipes-security/refpolicy/refpolicy/0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch
new file mode 100644
index 0000000..7b086f4
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch
@@ -0,0 +1,53 @@
+From bff80ff5bd0d1a007c9eb0dd1fb51831be504069 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 17 Mar 2025 20:09:55 -0600
+Subject: [PATCH] locallogin: dontaudit sulogin_t checkpoint_restore
+
+type=PROCTITLE proctitle=/usr/sbin/sulogin
+
+type=SYSCALL arch=armeb syscall=ioctl per=PER_LINUX success=yes exit=0
+a0=0x3 a1=0x5457 a2=0xbec20a90 a3=0xbec20a40 items=0 ppid=277 pid=278
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=ttyS0 ses=unset comm=sulogin
+exe=/usr/sbin/sulogin.util-linux subj=system_u:system_r:sulogin_t:s0
+key=(null)
+
+type=AVC avc:  denied  { checkpoint_restore } for  pid=278 comm=sulogin
+capability=checkpoint_restore  scontext=system_u:system_r:sulogin_t:s0
+tcontext=system_u:system_r:sulogin_t:s0 tclass=capability2
+
+--
+
+Ref: https://criu.org/Main_Page
+
+--
+
+Fedora:
+
+$ sesearch --dontaudit --source sulogin_t --target sulogin_t --class capability2
+dontaudit sulogin_t sulogin_t:capability2 checkpoint_restore;
+
+https://github.com/fedora-selinux/selinux-policy/commit/853dc2b6436ca5f2d7cb984bde3b000358829109
+https://bugzilla.redhat.com/show_bug.cgi?id=2265391
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/79dda56d3191b09b9f0cbafd4d1bd7056fd3975e]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/locallogin.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
+index 4ba131d29..02c7ff56d 100644
+--- a/policy/modules/system/locallogin.te
++++ b/policy/modules/system/locallogin.te
+@@ -234,6 +234,7 @@ optional_policy(`
+ 
+ allow sulogin_t self:capability { dac_read_search sys_admin sys_tty_config };
+ dontaudit sulogin_t self:capability dac_override;
++dontaudit sulogin_t self:capability2 checkpoint_restore;
+ allow sulogin_t self:process setexec;
+ allow sulogin_t self:fd use;
+ allow sulogin_t self:fifo_file rw_fifo_file_perms;
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 7701023..21bfbb8 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -78,6 +78,7 @@ SRC_URI += " \
         file://0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch \
         file://0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch \
         file://0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch \
+        file://0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

