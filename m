Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71032CCD183
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 15:52:10 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.web11.47538.1760370720990432784
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Oct 2025 08:52:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VMt1l64A;
 spf=pass (domain: gmail.com, ip: 209.85.166.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42f3acb1744so19741265ab.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760370720; x=1760975520; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc0XsfQJfC6pIWWyctD4hWgYiG81y+Ljd4QDkviNewA=;
        b=VMt1l64A1S1+OXYvc0aOOA7HB4qSHLXpT+l3ecvdBIVjkRbU9Jf/4KDk6iwyigmI1w
         WnaM8v/XDQzck1F4a8AghsqpuU42bYjGIvKz5XQORuNekvEH/EaPnjxNK2eJQll+phG6
         j5jv67066j7wcFYvNiwEz4ydjD860tkrMgC37RVflUtyxpVmLqIWrNVjeITcrXgEuM65
         EN87+QrLA6VwwQ1nt8yI/f/ZED0bBIen9IBmwKuo44DD7OmyEyefV0NV8k9KlghVGxDH
         2LFmn9o0Lw1yEX52AQKRqn5hXZcDRnUt3fFaf9Z3Q8UyTXEzZAHPI3P7CQ6qnXW0rnmm
         TQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370720; x=1760975520;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fc0XsfQJfC6pIWWyctD4hWgYiG81y+Ljd4QDkviNewA=;
        b=R3a6E53/Ekf373odqXyOQW2GhJrhAu1/+WCnvqBUE2RnbGkMCpFhrg/4yP6bqNmUhc
         xsxEZa3dt6bkOqWCqcggYgsHoUKuW2MIr8OoojB9EjHn1CFZHMnES4Qsk0BR/ibcd1ZH
         W4KGKVQuDUo8K2pi3b5W/KzjR5hlZX18JFh6wBgHBVc1zq0MlpuRuogdjV6CappuiTPV
         bFAbFohha8plttzlJPi0nOfUOgcX7nPhwntkqa9/D1f8h7MulKY8VzNo/F03pWPkFGTt
         CytqgouUtSbudAtM7xOAthzKa4+XEVxrZTF13d6NGpm2WM9QJUTf0Aqiiq/ICTDcZt9B
         /c/w==
X-Forwarded-Encrypted: i=1; AJvYcCU8ksOLiM6zKKvDdnQrVjUrJQNZWesIGDfuJ4hioeosZAztBeMbJvf56N3ay+Jfl6EPh317IUdyn79Z2KWO@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yx3jrdDslXBjUsOMa9qSk4ZvLbjbwWNTux9dMhf8mtswEsTW3Lk
	EdQsxFDnkY+mbat3jx5ZLcsC0ZBahb/5PsOBfYlcnv8vJXHwn3gnYKfO
X-Gm-Gg: ASbGncsNhO5qfnjlwbur3OCF7zz/9n9NkEnCFfz0KtOsARFHKPMvnVqNdhYhWPa2lEm
	GflyVMe4Ui7dlRf2vin+P7ZRlX8g0LqDj2KGk4rpK309gPDydBf5WbaTm9Awdt6T7LhT1XzDXwo
	zaknsRNzSM6vQkWyljv4SDuHRM0G6kLAoVq0KLZsqq7tNwpQTFynU+bj236nnbocr62YiuQTcxY
	b0Qr8z5EQfSphaEBF+qUWVX05JM5EAPFEj8JMbnKJeypcLJFLaI4faVcgxZhdG6RpGmgHpG5WO+
	OfABbPb9gs4+V26jRQjQvjfVhKuJ8bJSNSEu6K9Pncydh8nMfwCdnKM79R+d9DdBOIq7MxYKZgX
	0dHW7OXh3ISLFaxOsOBmz+7HrFCt1QxDsFHvmRtVCK/V/IWk6CwXAkUdh0URbbUmDQ64r62uZga
	nDxPEf9xwUU2wTsXprlPi+2+cx5rxyQw==
X-Google-Smtp-Source: AGHT+IEDOppVA/eEvnihL3CSEoc3yOF2Ab6qqzZJJxFRuCoxXIk0DWSMYIV20Of2rbMIA3DAZd7qpw==
X-Received: by 2002:a05:6e02:1a68:b0:42e:6e3a:3075 with SMTP id e9e14a558f8ab-42f873df5a5mr180235385ab.21.1760370720053;
        Mon, 13 Oct 2025 08:52:00 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f7200b261sm3735833173.34.2025.10.13.08.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:51:59 -0700 (PDT)
Message-ID: <60dd3c10-61ea-43e5-9140-bd58fa6bd1e5@gmail.com>
Date: Mon, 13 Oct 2025 09:51:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: systemd - allow
 systemd_generator_t use user ttys
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 15:52:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2297

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-systemd-allow-systemd_generato.patch | 77 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 78 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-policy-modules-system-systemd-allow-systemd_generato.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-systemd-allow-systemd_generato.patch b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-systemd-allow-systemd_generato.patch
new file mode 100644
index 0000000..f64c115
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-systemd-allow-systemd_generato.patch
@@ -0,0 +1,77 @@
+From 00907f0de29c87ca007bbb5889ff02b66cdfe700 Mon Sep 17 00:00:00 2001
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
+index 3e612d0b5..514ead9a8 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -622,6 +622,9 @@ udev_read_runtime_files(systemd_generator_t)
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
index d29d50c..32234b0 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0058-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
+        file://0059-policy-modules-system-systemd-allow-systemd_generato.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

