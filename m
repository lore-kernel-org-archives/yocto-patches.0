Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC1CCD1AB
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 22:19:58 +0000 (UTC)
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
 by mx.groups.io with SMTP id smtpd.web10.25950.1761085189320067299
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Oct 2025 15:19:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZtGosoZU;
 spf=pass (domain: gmail.com, ip: 209.85.166.175, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-430ca464785so43208315ab.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 15:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761085188; x=1761689988; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhWChNoAH/pJ1qYzOE73RPAeUXUvdVknxs7+aWC+COo=;
        b=ZtGosoZUjrOzKsXPiHFxJfg4cGLzUb3eKNIwFC6zYgiwSjmv5NAb+/Rj4OPMtbsx9J
         TcI4XGG5tLU5U0/8C5vPJyW+xdNxQvy4FBB1BHv7zDvDLNsp4C5zAFVIvwfsB7SjeIhz
         ZGrMXd4hLGgsiLkcbGMGG831PuO+ZDXsy+Mjv9L1iwIbEhIbo0eiSkTzteFIbsBaEJ03
         2D3dEl2X8USxDjQehZmfA1CplcNvrxk6NiJDGqo/PKo3IpD/fcjPltyPCPl+LyeXUtzc
         KD8vse2a75mFG5z13/3eY0HK5q0pxvfxtVGSYUzbBp1WiPJXZy6n41YW1uOtpUGRmRln
         hOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761085188; x=1761689988;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uhWChNoAH/pJ1qYzOE73RPAeUXUvdVknxs7+aWC+COo=;
        b=ZXF6pqaOU06ti3psmS+5a9JztW8iPF4Z07gGFaX6pzsZkX2h69c1hbVRpur0t7GWPm
         GZI50AwLPVihem6XakYBSsBh4wyFVifnN+TfHvdfeQfOg77hJL2AHMCNKMt3mnLNEJFB
         jFC3Z+r3GVhaUp1bkBwxnFrufR2e7ugKkt8pkbH9GF9hnQ1n18gc7hqUAcsUNY2wqD/i
         4zUZwaJuQQl0WZuC66lqkcY+uyafVaLzO/xjWpv9Qn3Vg8P79oeRSeqrGoK5/lr06EJy
         T3xsxwiAT2tlJTe+35ShrfGGTTq1C9ZZTysv2Aq6fx0kFTv/aumUrjjoxL90GXD+XMNz
         Ankw==
X-Forwarded-Encrypted: i=1; AJvYcCWZS0zQH4WAmhf7RvyN+4CtL6bZByWT3SAXd22lkyXXL23ZoPAH0S6G7VcQ8u8ombFnmS2zg5zUf15X1F//@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YycL0Wh5jLwIzidLnez8CmHBbIOb9eUQzSUSGgi42a4Pq1b+d5K
	fDPg3ZUyt9oL/7r/vwjNCYDLaD1gqja8qcX6EZag0xiHet3ywljxDA3c
X-Gm-Gg: ASbGncvjkCkzveFXcTpklPINHWsuHDjjqJMHmvRuiKbeC0bxXrB3zeh9xQUqX4xzeOB
	ey8KJepyA4iOliWEFmOW/w7HQ6bp9xhMzZe8uLKJomNtQoVI2tXaoKS+tbxbzXUrtn2fED3HzW2
	ItfxmFzsBslYGFaeTjWq06i02Atq8M8z60QVRWn8JuUyD9dznInazMKoK/jQ+Gx6RoLXycIjlBo
	A/sCwRO2HrR+oCk+/nKkmzP079uWBFShQieJYMXF0etrRLvtwOzPPmZry6YhU3OBdHXCWgJ5Mse
	ScG1s+mfbFVMvHoqV75OQ0/N+798V2AxVmk4ONtyFGyME5+tTb8pYbVDAQ+d/jk6Qi9NuETAIDL
	fQs+8MwNuaqm23CmLFQ1ZqkegSjEKS4KTleXxeODUKwBm4Pf2cTvDvNcPWUzZJgjCLEjlaHIk+g
	Kc3kwSfGMe/jcdyj0BpCd0L2F4gaQSnyXQFIFpMeTO/Aeajr2xXs1UGL7rTV3UYK5b
X-Google-Smtp-Source: AGHT+IFR4STviFwAuxah1F8XO7Ro+grEmYC/Ct5R6RG1yethI73QQ9b4WEksfAWxtVgiuABg1VBFYA==
X-Received: by 2002:a05:6e02:3e06:b0:430:ac4a:4dc7 with SMTP id e9e14a558f8ab-430c519b3acmr271009945ab.0.1761085188403;
        Tue, 21 Oct 2025 15:19:48 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a973f385sm4462258173.44.2025.10.21.15.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 15:19:48 -0700 (PDT)
Message-ID: <145d27ff-67bd-486d-816a-aba2f2574bf4@gmail.com>
Date: Tue, 21 Oct 2025 16:19:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: ssh - allow sshd_t
 userdomain:key search
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 22:19:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2378

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-ssh-allow-sshd_t-userdomain-.patch | 80 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0063-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch

diff --git a/recipes-security/refpolicy/refpolicy/0063-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch b/recipes-security/refpolicy/refpolicy/0063-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch
new file mode 100644
index 0000000..5374e2a
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0063-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch
@@ -0,0 +1,80 @@
+From 326523641b8051186ada1af32d511dd78d260024 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 7 Jul 2025 16:38:49 -0600
+Subject: [PATCH] ssh: allow sshd_t userdomain:key search
+
+~# grep key /etc/pam.d/sshd
+session    optional     pam_keyinit.so force revoke
+
+--
+
+type=PROCTITLE proctitle=sshd: user123 [priv]
+
+type=SYSCALL arch=armeb syscall=keyctl per=PER_LINUX success=no
+exit=ENOKEY(Required key not available) a0=0x8 a1=0xfffffffc
+a2=0xfffffffd a3=0x3e8 items=0 ppid=1 pid=557 auid=unset uid=user123
+gid=user123 euid=root suid=root fsuid=root egid=root sgid=root fsgid=root
+tty=(none) ses=unset comm=sshd exe=/usr/sbin/sshd
+subj=system_u:system_r:sshd_t:s0 key=(null)
+
+type=AVC avc:  denied  { search } for  pid=557 comm=sshd
+scontext=system_u:system_r:sshd_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=key
+
+--
+
+Fedora:
+$ sesearch -A --source sshd_t --target unconfined_t --class key --perm search
+allow domain domain:key { link search };
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/c4a2989845ef3fedc4036041ed1fa61c28594842]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/ssh.if      |  1 +
+ policy/modules/system/userdomain.if | 18 ++++++++++++++++++
+ 2 files changed, 19 insertions(+)
+
+diff --git a/policy/modules/services/ssh.if b/policy/modules/services/ssh.if
+index b3394bd92..4935d2e9d 100644
+--- a/policy/modules/services/ssh.if
++++ b/policy/modules/services/ssh.if
+@@ -254,6 +254,7 @@ template(`ssh_server_template', `
+ 
+ 	miscfiles_read_localization($1_t)
+ 
++	userdom_search_all_users_keys($1_t)
+ 	userdom_create_all_users_keys($1_t)
+ 	userdom_dontaudit_relabelfrom_user_ptys($1_t)
+ 	userdom_search_user_home_dirs($1_t)
+diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
+index 182cfc9db..46e4cf301 100644
+--- a/policy/modules/system/userdomain.if
++++ b/policy/modules/system/userdomain.if
+@@ -4978,6 +4978,24 @@ interface(`userdom_sigchld_all_users',`
+ 	allow $1 userdomain:process sigchld;
+ ')
+ 
++########################################
++## <summary>
++##	Search keys for all user domains.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`userdom_search_all_users_keys',`
++	gen_require(`
++		attribute userdomain;
++	')
++
++	allow $1 userdomain:key search;
++')
++
+ ########################################
+ ## <summary>
+ ##	Read keys for all user domains.
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 5cd8cd0..8782dbe 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -78,6 +78,7 @@ SRC_URI += " \
         file://0060-policy-modules-system-unconfined-allow-firewalld_t-u.patch \
         file://0061-policy-modules-services-chronyd-allow-chronyd_t-kern.patch \
         file://0062-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch \
+        file://0063-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

