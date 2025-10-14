Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95842CCD193
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 18:13:08 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.web11.3196.1760465585180761903
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 11:13:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gwxp/Kyd;
 spf=pass (domain: gmail.com, ip: 209.85.166.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430ab5ee3e7so816995ab.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760465584; x=1761070384; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unjI+1w+JkyIigVAG+ISEltfOplds5toVP9TKyd67Hk=;
        b=gwxp/KydQixVEiZcJE5WwD5HcfZ3liXwP8T6D576S8h9zYaBdTONL0628khWa9ewWn
         E2Oaf3eDCGjzoMA0NtuMvQsfPW3ieLJe4bSfFOxrlgaS9MG1TyZwccvoznkUIlfheVT6
         ALrJZeIHPgui0RfVtanzmBLTRZjtsKofIbyPA5divO2O107yN0oHn7SSDgge78FkR0fn
         jodAgw4As7JK/uX8gRuIqNMgAtYUCu9x4hN+Nm+liz4EfsCBm1149iadfNZMK3ewt3xu
         WtULogeMje//n9pfSzrRAtA9C4qfKXXdUoU62UKiOYCGY00XdJRKAYHvihEby94OZX33
         Ey1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760465584; x=1761070384;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=unjI+1w+JkyIigVAG+ISEltfOplds5toVP9TKyd67Hk=;
        b=Ous3xRu8RYm0jCc3M3QVhoPtTHjPZAwrE4bWVKqcdXMhmsMra4VM5goEE55UAKeGUc
         SqZTxmpZ4PFSJhlg1qDyfYM9NiDKnJkqWOCxtemmTLsCfs2B33WsaAZjge0h2hHxSAlW
         4k/qJmEDapf3HckkZktmtOimVcgqA/vQLyvrM6I1lhGKgUE49QPvVg5jqNNz7+3tps2o
         0UM3aXd9hf57vn6X2mnmVNVWThCf1T0lnVf0+64ANAb1FcfoYPVtZTyiyiI+N67nl3Oa
         p+1Ao1ZyOfYWxn+8PrtVftPGM5wpvmOkNklOn93AEIHaqbGXydRzVpnS43yF/N7D3U9b
         ugFw==
X-Forwarded-Encrypted: i=1; AJvYcCX6pUzLDIVyTIBqvA/iFZNl7QeL+N1Kw1wfnS7V1ryeaHLWc/A2EE80lyWlhqT+YrLdQ/08JGLDv8GC+yaT@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxOa8i6ZJJA7DpS/J2AYvgn4t89y2QTHa7kHC/4PYHkZPrOEwbu
	CWJkO2t1eSgksiPJgBtljSE63vVO+74O9DvUDbcpForbmrgPdQx7VnnQ
X-Gm-Gg: ASbGncu1K6F6VxLxbwvpl2CqXypBnUAye/J7ffCvAGOagg0rJSV3qyd9+K5IZ3pWU59
	8om0WLlZ+AUAAQE/qlMMk/zqsbw2iCB1I08OhMgvUH5FTbLpIoU0sEHXqfuUff6QHjfhjAv55nx
	jyIttWI1GXCEGC6NdzOhOUDQSUr2xKkqBrHyvwUgtgtS2u1JZrtmT4xeKf8wZDCYoxoX80HjDK9
	KiQcF08SKeP6tdHwHiMC4P7qYFw21Jj3i+s2qoKVrGoOKw+rw3qnGBF9L8i34FCbuYfSvjIwNeP
	ScFwoyeQMBzqHHFehhsmf6bdV/cn3GgQXCFCAqfA8pp4G8thM66H1fM0bH0IBc6KVCot4YNzwAQ
	pyI+v4L/CHFm02gJ1dfnas8qK77GWizd/EEnRoBKzg2cUm1WpaI4qwtMfKrVQmaPVs5nykB20xl
	dDnWVezp04M40Qhcn2dkVqBK9xiq0MnA==
X-Google-Smtp-Source: AGHT+IGpcGzsVRo2WRAMWycyaymGmCKuoT+YC4VYGhqXZmqTmyI7DtQDAfM+VUGYepO2D4HkadNjbg==
X-Received: by 2002:a92:c26e:0:b0:42d:86fb:d871 with SMTP id e9e14a558f8ab-42f873ed35amr227390635ab.21.1760465584141;
        Tue, 14 Oct 2025 11:13:04 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430a312b81csm8640935ab.20.2025.10.14.11.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 11:13:03 -0700 (PDT)
Message-ID: <6671e998-3d09-41d2-b7c9-adf1a305cfc9@gmail.com>
Date: Tue, 14 Oct 2025 12:13:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: systemd - allow
 systemd_generator_t use user ttys
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 18:13:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2303

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-systemd-allow-systemd_generato.patch | 77 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 78 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0070-policy-modules-system-systemd-allow-systemd_generato.patch

diff --git a/recipes-security/refpolicy/refpolicy/0070-policy-modules-system-systemd-allow-systemd_generato.patch b/recipes-security/refpolicy/refpolicy/0070-policy-modules-system-systemd-allow-systemd_generato.patch
new file mode 100644
index 0000000..b635b79
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0070-policy-modules-system-systemd-allow-systemd_generato.patch
@@ -0,0 +1,77 @@
+From 853593e232e1ec568482c42e8d27052990d08e91 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 5 May 2025 11:15:14 -0600
+Subject: [PATCH] systemd: allow systemd_generator_t use user ttys
+
+type=PROCTITLE
+proctitle=/usr/lib/systemd/system-generators/systemd-getty-generator
+/run/systemd/generator /run/systemd/generator.early /run/systemd/gene
+
+type=SYSCALL arch=armeb syscall=openat per=PER_LINUX success=yes exit=4
+a0=AT_FDCWD a1=0xbea41b28
+a2=O_RDWR|O_NOCTTY|O_NONBLOCK|O_NOFOLLOW|O_CLOEXEC a3=0x0 items=0
+ppid=1106 pid=1109 auid=unset uid=root gid=root euid=root suid=root
+fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset
+comm=systemd-getty-g
+exe=/usr/lib/systemd/system-generators/systemd-getty-generator
+subj=system_u:system_r:systemd_generator_t:s0 key=(null)
+
+type=AVC avc:  denied  { open } for  pid=1109 comm=systemd-getty-g
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=system_u:system_r:systemd_generator_t:s0
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+
+type=AVC avc:  denied  { read write } for  pid=1109 comm=systemd-getty-g
+name=ttyAMA0 dev="devtmpfs" ino=2
+scontext=system_u:system_r:systemd_generator_t:s0
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+----
+type=PROCTITLE
+proctitle=/usr/lib/systemd/system-generators/systemd-getty-generator
+/run/systemd/generator /run/systemd/generator.early /run/systemd/gene
+
+type=SYSCALL arch=armeb syscall=ioctl per=PER_LINUX success=yes exit=0
+a0=0x4 a1=TCGETS a2=0xbea41ab0 a3=0xbea41ae4 items=0 ppid=1106 pid=1109
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=(none) ses=unset comm=systemd-getty-g
+exe=/usr/lib/systemd/system-generators/systemd-getty-generator
+subj=system_u:system_r:systemd_generator_t:s0 key=(null)
+
+type=AVC avc:  denied  { ioctl } for  pid=1109 comm=systemd-getty-g
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2 ioctlcmd=TCGETS
+scontext=system_u:system_r:systemd_generator_t:s0
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+
+--
+
+Fedora:
+
+matchpathcon /usr/lib/systemd/system-generators/systemd-getty-generator
+
+system_u:object_r:systemd_getty_generator_exec_t:s0
+
+https://github.com/fedora-selinux/selinux-policy/commit/6adfc23f83c3b9078c0245c66095eb78f411bedd#diff-20413b38529167819e3ef86a39929b3638ea684202dc692282e633cd05065969R1322
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/930e04f861ab3e753ca831b0c3a1fe51f4b423f9]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/systemd.te | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index 5823fd543..bbcded640 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -595,6 +595,9 @@ udev_read_runtime_files(systemd_generator_t)
+ mls_file_read_to_clearance(systemd_generator_t)
+ mls_file_write_to_clearance(systemd_generator_t)
+ 
++# for systemd-getty-generator
++userdom_use_user_ttys(systemd_generator_t)
++
+ ifdef(`distro_gentoo',`
+ 	corecmd_shell_entry_type(systemd_generator_t)
+ ')
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index e768e22..71ebeea 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -85,6 +85,7 @@ SRC_URI += " \
         file://0067-fixdep-dbus.patch \
         file://0068-fix-building-when-dbus-module-is-not-enabled.patch \
         file://0069-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
+        file://0070-policy-modules-system-systemd-allow-systemd_generato.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

