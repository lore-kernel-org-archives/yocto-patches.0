Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A54C369A2
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 23:27:46 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web10.22183.1744241264543256519
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Apr 2025 16:27:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XdDeHGSQ;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72bbc03d436so140676a34.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 16:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744241263; x=1744846063; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sBdOLJYd+P30OKnXBR/SwsrHktylX78rvUx8B5SrKo=;
        b=XdDeHGSQh7DW6IlaDYoPRe07nccZOaqJChVm15jiBmjdMHrWieFOqD86VTywITdO4t
         iqlndGJQAVaCIv+anpft0UQ9w9grdNcWE1jBYfuGzmRCRJp8jHkZD372PSTaAuV+RtHu
         cIFn29YUgon9P6A9BnVVX9kzoI337UG5LBnjXYVijadGJxqe7mYzZTfci9q/vpYjwrMW
         LqUIsfZQ8sbTzyvSsU1wI2NAlx2jXHJsbm1oOkOZ+28iZd/hnA4mPACb46Q2RcjRZ8wG
         K+2Nn3i96bVdfGe9dFQNUnfswFHtJ7VIx0Sl05nhMQw4NCbDSOgn9hpWDB5rda4RaWmK
         tXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744241263; x=1744846063;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1sBdOLJYd+P30OKnXBR/SwsrHktylX78rvUx8B5SrKo=;
        b=nB7v8YZ0EuEZoT60HSTs13Bnv73V/RiOt278kZoVf4GZUAOHWfvRIVdfgeYkjFrxmf
         pOGfXUVyf5Zs98YHAypBoSgOm8uLlM3zxf/s0ykGwy3lzSbGOLMX+GA+zoO6mHCjCMml
         oMmsn6gkrngPYmIKD0CubbAXj2Dp1yhkd2i0M7As72GgD4VdqqeDr/yeEbkEnIrXBcZ7
         C6idqtIe43QsmGRxyBXDNagkQOa3eTRAGzy0NMf1AT1tqzI8i1vW25vJhOKLfreSgndS
         DCdwnpUUUDm6l/EGhF8Kr5Z9+Y5Y4ok2SpAve75qiO522JSmwYlltBzOEOmOCWH0/nSn
         tHGg==
X-Forwarded-Encrypted: i=1; AJvYcCUYp6HGh2O4MX6xKMbswaEZdjUUuSfuZIWAtZm315aocD1JUcW6OoyEBJVnbiWaRZvV+QzgNo3N/W7gNk0q@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwV60zgO4z/zmK3E58KcqAS5iKpgDvjyd2+9o6NXb7SGgtK2LZk
	S79cC7zFCQ6thmhxRq0T+Sxp6UrOO2G49yhm1BQ7v4INyVKEkvTajX9f+A==
X-Gm-Gg: ASbGncs0NGRaGlsJ1e8X5snEiBIatvIsXneVJQhQsogpagezDYruSu+n9ksTp4fRQOL
	vWyW0nDstgX18Mf/rDz34rg+eC2Y4q/dFpa6KM5r/Uu3V+8miBQtBGHQg1pt4wCjKEC6Wt4NAga
	I7LIaa/Jjp4x1uPxliuTcMsuSss8rT41nyCzIiKRIceF+WbJyG/AriAsTCEB3p4mWKUBimvUNbA
	78TMH4Quu5UWlmduEIxvi9jfpsojZE3EuJgr6gCIq48hcpZCPX5hM4w9BI2HhkUyh0sAiRs02lZ
	l6z53Gwaeyla/1pEgtChdnCezGP+zyltaJEOQ7GbufJvCUZg0RJu3YgRlGm+mFuywFnSmv5F1dY
	tLojwZk2KN56sowN/Vw==
X-Google-Smtp-Source: AGHT+IEQ4j7+zsDZ5Gu0j1ACTweL332wsiXnLWB6x//BWPpjgjmrjWsiseNpxh2jUHy9B2qxqdejbg==
X-Received: by 2002:a05:6808:2289:b0:3f3:e01e:f7eb with SMTP id 5614622812f47-4007bc7ff1emr507773b6e.7.1744241263594;
        Wed, 09 Apr 2025 16:27:43 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4007639daf5sm341955b6e.40.2025.04.09.16.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 16:27:43 -0700 (PDT)
Message-ID: <1f0dc3e3-d7b6-49ff-bb07-17c22db0c515@gmail.com>
Date: Wed, 9 Apr 2025 17:27:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][PATCH] refpolicy: locallogin - allow sulogin_t
 user_tty_device_t rw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 23:27:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1344

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-locallogin-allow-sulogin_t-use.patch | 79 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0058-policy-modules-system-locallogin-allow-sulogin_t-use.patch

diff --git a/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-locallogin-allow-sulogin_t-use.patch b/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-locallogin-allow-sulogin_t-use.patch
new file mode 100644
index 0000000..fb58cf2
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-locallogin-allow-sulogin_t-use.patch
@@ -0,0 +1,79 @@
+From ea62c7fbabb2eeccf309c79fb03435194bcc3053 Mon Sep 17 00:00:00 2001
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
+index 547fc1ded..59bcc78c8 100644
+--- a/policy/modules/system/locallogin.te
++++ b/policy/modules/system/locallogin.te
+@@ -278,7 +278,7 @@ seutil_read_default_contexts(sulogin_t)
+ userdom_use_unpriv_users_fds(sulogin_t)
+ 
+ userdom_search_user_home_dirs(sulogin_t)
+-userdom_use_user_ptys(sulogin_t)
++userdom_use_user_terminals(sulogin_t)
+ 
+ sysadm_shell_domtrans(sulogin_t)
+ 
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 0661e6c..17937f7 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -73,6 +73,7 @@ SRC_URI += " \
         file://0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0058-policy-modules-system-locallogin-allow-sulogin_t-use.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

