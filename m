Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DFDC369DC
	for <webhook@archiver.kernel.org>; Wed, 30 Apr 2025 01:07:46 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.6569.1745975259318862546
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Apr 2025 18:07:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fqeHDedD;
 spf=pass (domain: gmail.com, ip: 209.85.166.44, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85ea482e3adso14578939f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 18:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745975258; x=1746580058; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb5/kCa5+ixZq7NFL3SxsWNuhzWRYop5GXf4R9i1Zqg=;
        b=fqeHDedD1lPtL04yqm6/mWF1JuOYQN/QtsV0Mmcei5v4I1Dg1BdyBhkWQT90lhQ6kT
         Ursbo2cp2yw1DrP8z/QbiN3xRTCq+yJVsobeEvFKAqx9SdBHg0vNE1SO9ph6zkvSRFPX
         GAUQ1IJM4Jm61Axmz0fpPU3t4r8Y5Qpuph+4r0N/mphuwWHcT2woFo4dSQLdedSZmpft
         WT+u5qcVqjxxINrnSWQC8Wu2Tu8MVt7vK4oZdA80htYv78IhrDfjPMsnQDrXHvZrIjtS
         pIYNoOfZckBSp7c0+QVEBXzFi8JztLOBgc43Ndthar16XJcxE/u5uLW/cvYYAaNT5qXH
         C97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745975258; x=1746580058;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lb5/kCa5+ixZq7NFL3SxsWNuhzWRYop5GXf4R9i1Zqg=;
        b=Z4o+3WdVyWl+SgCfY4h7KtdeVAjDE/0mqjuX5fS/W+Ciao2qP6kA50limMnN+tqy87
         yK7QKTiSCklvrb1/23zyDqw2Iwng1emsEqbio/vK5ZXBsh/ongswQB7c7kp4vM1TXpqJ
         ODWzHWNl6qswX2mPhFARJnrEiYXRRwpqZMml++7PKsGdzVUbAmPuxv9navR7ABeeuQEE
         KiKtorfYkqCqNUxaty+5FsRnkJe6aJGXCAX6sgNwaWc4vEDAPIdje35lykvi2TXVbiPn
         sntn1/zazH6LSEag6Ps4D6tl+5vKkaz1q2y/5FIfDyTJqq5z38UXSUXWKP/efDcRw/6z
         OjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUEqHwgZTrgxhtOaUGMG6qCSBZwZC5E35/W0Zag7luDGEZZwHbz8/TJ9CjSprt+8PWKrIHiP2p363tZAHm@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzOD/ABbkhZuBisl0Q7MEzvtFe8FAFzoPnhBdreIlYkraQQ/slS
	kiJNTGEEQnfLv/4TH/pLQeCKuH0ld9gB9AecycUWv4Ji971MieSH
X-Gm-Gg: ASbGncvo/8qx6MgxMDX9eJxDReDFUILJDS2UsAdICdtH/J8M5lwOS1Ot/WFPWjMN15a
	/02LQq+Ny0ceaWKUoU6LqnP7DzvVPRVlI56bLNm8pWZMoEGa16Np3tNeSM3l4iQWsoBNxIggacT
	8fFU64utdAFI6ham6i9eolGargmdveVlGFSfQPvW73KlmtQfCuiYDK4qwoRqzh5O2m7Z93Uhwww
	H4GZI0T6qhr2ytxv8rNgD160+tzV4uCNkLx87Ff0CR4J/4tRjCSCLMCPxQsz5mYQUHXLUmAhyLH
	JIlMDqZhc7oWctSIFfNn4Hf0n6bm1h5T2o015fTO3JIJy4dv51DAlG0Sw/3eU5++qJcxhqfTIPW
	lP7BEvQ721AB8qpSnXQ==
X-Google-Smtp-Source: AGHT+IGHZkfsqB4XJcd5te2NrUy8NjdecXh0AL/eilnXENFhFa1w4wmx8eaKa/lioeSaOZa04h9WJg==
X-Received: by 2002:a05:6e02:de6:b0:3d2:af0b:6e2a with SMTP id e9e14a558f8ab-3d96792b52cmr8581615ab.5.1745975258332;
        Tue, 29 Apr 2025 18:07:38 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f2b37a2sm5699885ab.19.2025.04.29.18.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 18:07:38 -0700 (PDT)
Message-ID: <43198444-37c2-4960-8fb2-a7aa53f7be71@gmail.com>
Date: Tue, 29 Apr 2025 19:07:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: locallogin - allow
 sulogin_t user_tty_device_t rw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Apr 2025 01:07:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1422

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-locallogin-allow-sulogin_t-use.patch | 79 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch

diff --git a/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch b/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch
new file mode 100644
index 0000000..e77ca44
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch
@@ -0,0 +1,79 @@
+From ec85df6dceaa0dbdad76b9e3174482518d9aa980 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Tue, 1 Apr 2025 12:18:56 -0600
+Subject: [PATCH] locallogin: allow sulogin_t user_tty_device_t rw
+
+type=PROCTITLE proctitle=/usr/sbin/sulogin
+
+type=SYSCALL arch=armeb syscall=openat per=PER_LINUX success=yes exit=3
+a0=AT_FDCWD a1=0x4e77d0 a2=O_RDWR|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW a3=0x0
+items=0 ppid=432 pid=433 auid=unset uid=root gid=root euid=root
+suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyAMA0
+ses=unset comm=sulogin exe=/usr/sbin/sulogin.util-linux
+subj=system_u:system_r:sulogin_t:s0 key=(null)
+
+type=AVC avc:  denied  { open } for  pid=433 comm=sulogin
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=system_u:system_r:sulogin_t:s0
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+
+type=AVC avc:  denied  { read write } for  pid=433 comm=sulogin
+name=ttyAMA0 dev="devtmpfs" ino=2
+scontext=system_u:system_r:sulogin_t:s0
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+----
+type=PROCTITLE proctitle=/usr/sbin/sulogin
+
+type=SYSCALL arch=armeb syscall=ioctl per=PER_LINUX success=yes exit=0
+a0=0x3 a1=0x5457 a2=0xbe8cba90 a3=0xbe8cba40 items=0 ppid=432 pid=433
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=ttyAMA0 ses=unset comm=sulogin
+exe=/usr/sbin/sulogin.util-linux subj=system_u:system_r:sulogin_t:s0
+key=(null)
+
+type=AVC avc:  denied  { ioctl } for  pid=433 comm=sulogin
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2 ioctlcmd=0x5457
+scontext=system_u:system_r:sulogin_t:s0
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+----
+type=PROCTITLE proctitle=/usr/sbin/sulogin
+
+type=SYSCALL arch=armeb syscall=statx per=PER_LINUX success=yes exit=0
+a0=0x0 a1=0xb6f046ac a2=0x1800 a3=0x7ff items=0 ppid=432 pid=433
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=ttyAMA0 ses=unset comm=sulogin
+exe=/usr/sbin/sulogin.util-linux subj=system_u:system_r:sulogin_t:s0
+key=(null)
+
+type=AVC avc:  denied  { getattr } for  pid=433 comm=sulogin
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=system_u:system_r:sulogin_t:s0
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+
+--
+
+Fedora:
+https://github.com/fedora-selinux/selinux-policy/blob/v41.35/policy/modules/system/locallogin.te#L266
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/2240e1a89ea61096b64a172c45fa9db73553ac6d]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/locallogin.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
+index fcec23010..c370caf2b 100644
+--- a/policy/modules/system/locallogin.te
++++ b/policy/modules/system/locallogin.te
+@@ -276,7 +276,7 @@ seutil_read_default_contexts(sulogin_t)
+ userdom_use_unpriv_users_fds(sulogin_t)
+ 
+ userdom_search_user_home_dirs(sulogin_t)
+-userdom_use_user_ptys(sulogin_t)
++userdom_use_user_terminals(sulogin_t)
+ 
+ sysadm_shell_domtrans(sulogin_t)
+ 
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index c5b41ee..7b6822d 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -80,6 +80,7 @@ SRC_URI += " \
         file://0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch \
         file://0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch \
         file://0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch \
+        file://0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

