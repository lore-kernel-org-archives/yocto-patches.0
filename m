Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839E8C369D9
	for <webhook@archiver.kernel.org>; Wed, 30 Apr 2025 17:00:54 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.146.1746032444871540926
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Apr 2025 10:00:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kk4SECzJ;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85dac9729c3so3241139f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Apr 2025 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746032444; x=1746637244; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4MNX1trKXqrr+8HQIETrJD4iZKrzn7+DlRUL17gJ80=;
        b=kk4SECzJrkNLRn9JXzIs6Pxfq8dY/ac+Jb9G/+YEatrBB7ZS137ItO7XxDs4ltsaco
         qjhCU/LwoWl9jf7e0GJnOlbFvv8YboP+8qTTpzsLjaIXf4QrFfn9vVZ5JPvAqloZRRf/
         f4clnS1a9enq7hN8FTTVPtCUt8ulc9PnLken9Zbj341jjsYEZ/qjaJUC8tz+rKLGKQvM
         0smWHqtnKNMK4+xgsKNRF9xvLwsVJlQydYQeElgV8Hz4o4GSY3FFDDk+DAGNR6KV3+2l
         oKKC/zTvpPhE1e+YHhO1fXroyIh5NBF3qzT+bF44xewaIbLMxK9LsAZz/nl0Rct9K7wN
         JhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746032444; x=1746637244;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+4MNX1trKXqrr+8HQIETrJD4iZKrzn7+DlRUL17gJ80=;
        b=TAIlStm1S8f65dcs5T7Y+890slEKPnud0kO6LTiU5gUL/7LkDN6kPS0LOIsrRmf5Nd
         Jz/Dhgnp8eBYK78F+x/vOhO/tclDHgBzpaf5rTr2pPTDhcSeQmHjQ06iRRI8RcPTOeED
         xe1Bf2xRJpZVwxCLbfcxqqG5PFEDvoY+Bj+9SWdItubXkmnTlBjTxKTOCSZyxGZr9opw
         ek/ZHTA/lMM3LTCuvO+W44U6uQEyr66rU+ot/6UN754td+aD+gGAWLD2dLAHrzggSHES
         lrBf9Q+cXbNDvcI032Ej5Zsjz9U9NioJ3W6l6TFfKxhIfZL8zYti753frfzqSxHCyPir
         a8VA==
X-Forwarded-Encrypted: i=1; AJvYcCVRwdrrsA5UHVBB705CoGjlyM11piGOCVBys4v1kVUWhm4iENm7dzBeH/3aWj8SL+9Oz2a6hFptAWxJbJjk@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxKfV8c5GZ1VquvwhpIOmwFlRlLajOriyv33+24Jtf5MJ1fYvRm
	dUw6AqiDlzqFTXj5JRnFr/qaGHl3MCxoq2b5FLsWN7IYf2MSlKys
X-Gm-Gg: ASbGnctCfmD4wfcfmroOwT9KRj4dBJ8+oxUYENJujxDxIM/HQvlsj5l7Omvx+i4xhRA
	JOM9n8rdNrKKp1L5DE4vyyyKSEbSmK+cH94yYLtxKShuOBkGfSaFmOx8bthhMLGe3G3V14PIFh4
	Q/p7As9x/kgSuKt/X2ofKZllIF0313QvuHtoPxZSK/7muANBWE671VKO/lMlMX083j5yC7URPDc
	VsyMwAQ0aPJqgvutWO8c+UUhIN/nGO2znaw0gaWCoEpyKwvuoX7jthkHenvI4K0s7unNJFs8/bv
	VZ7rqkWhBdGDfjADGYeuueh6Li069kLYqTW69/Cbm85Sg00wbgcZtUa1nz3ZElUPXnpm0pbfxhQ
	55RzycYrNKXDgxmVG/Q==
X-Google-Smtp-Source: AGHT+IFveeIVYlE8d/WuIUtDJaXuXnpDyNrMLOLbgPvKV2jAKIDJ1+rFEcpgqBbHwVkCO0PUvsIo0A==
X-Received: by 2002:a05:6e02:1446:b0:3d2:b72d:a502 with SMTP id e9e14a558f8ab-3d96772b4a0mr45266085ab.22.1746032443372;
        Wed, 30 Apr 2025 10:00:43 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f862e0bc4esm822962173.1.2025.04.30.10.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 10:00:43 -0700 (PDT)
Message-ID: <15878557-5f24-46fa-b8aa-e38889eec56a@gmail.com>
Date: Wed, 30 Apr 2025 11:00:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: locallogin - allow
 sulogin_t user_tty_device_t rw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Apr 2025 17:00:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1424

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-locallogin-allow-sulogin_t-use.patch | 79 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 80 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch

diff --git a/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch b/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch
new file mode 100644
index 0000000..8340da7
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch
@@ -0,0 +1,79 @@
+From 4887bfe28a279c7495e23403c401c46bb95d4a41 Mon Sep 17 00:00:00 2001
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
index 0bd55c2..282fb6a 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -80,6 +80,7 @@ SRC_URI += " \
         file://0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch \
         file://0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch \
         file://0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch \
+        file://0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

