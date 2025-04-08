Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89CAC369A4
	for <webhook@archiver.kernel.org>; Tue,  8 Apr 2025 14:34:10 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web11.76679.1744122844651212155
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Apr 2025 07:34:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WeFkPXcK;
 spf=pass (domain: gmail.com, ip: 209.85.167.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3fec2899574so3597620b6e.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122844; x=1744727644; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGDeOwZaEQf8OwUdm0hGAtK3vuG/bWRCfeNSoSLNEpc=;
        b=WeFkPXcK0drrTFkWJZwJ4vcgDeax4bZZo1rQGGQbMjhuLX82c/h6ub/+Wvy6LXKXyt
         6tMTeY2kSQvRI9VpOhnTooKmnPta5C7S199KDJKWcMPIYKRc3btgnvUDP/vdMzc3zTYF
         lM0strzpSIpg3DaEY58bYh0/Gbm4WZDdq8Tgwsi6gDDG+KZqTHn+Z5Hw939IcixRvYeZ
         L9tuvVbEDQlN/Z9LtbVxTMXpi7Lm0OVGKkxf+SL4RrUW9CLQhbAsk0V+DLZ6HTOT2mU0
         NgTeYn68Kdvu5sJN3oQy/3UL8w2HoV/blqQoWrxhP0eO/qm4vHIgIuA49lC2FIoDykii
         MLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122844; x=1744727644;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bGDeOwZaEQf8OwUdm0hGAtK3vuG/bWRCfeNSoSLNEpc=;
        b=ZoXnJSgarMYtqKk8lzAPlIC+i/Ni+h/smhmyosoG56dURI6KDn67XRRICCv4mNEd4/
         JtQDjEWD1HaLrTnUDt4UL6e2MGfrS1AKkiEbcDXk4SgyUWxieXpU2gnjYzSDL3b2VUvs
         HIrguJd3d78fnUtDE6C1UreS0lKdnsjLYTWzqNGuH+2qg8o6Zh7vJHEQKxqflLFlXY3L
         MSaP99SoBONMeXQ3StWi+OAAEKLXNmtu7SHoPRYkEiG9vuG3TnfyRQtPOnhtMQv73ygu
         VqEjzfQm0dMpxbXdXP1h8fP9W6bSJBq45a8vCqAsMdamgrafb6UsUurV/ygKNpZrEU9O
         hqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPxhZvtwXPhFiauBhX/mA43auv86YcgMFFGUxxTrpxNF634weVTI6iENWxA3E6mhnPZGwz1yaPQ0dZjzlU@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yz8k35kemwNAeig/GBeVoYSIktmDYvDf5GKezGI/eHhzxi2v7yZ
	PvTaSSoTxssMRtJzfv+eD0QkKL47PlzAyYGgHxODqujDNvLBTBlu
X-Gm-Gg: ASbGncs1U7EWSxhR+ub//7ScJv6dvy+jSdhP12iUjCbNYDJsMgZg9Bp661OSL9SynIQ
	HkPtGRw+XQ95ZbzOkLaeec/YZe97tYWmTNAsnIdgi4IrBis7dXt9xtgoxs5fCC4tZX/yePFJOkw
	Ix33r/X1ztu1HK96f0fFiaLI8Kh85FXdVHXT9/kqmL77ggalYK2wVK2uDuwmIdknJnrL4RmM5nH
	+biST4iccuciMzyTtNQFFACEC58CWdIcUuKMqmI7Ivf4Q7pPndU2aeExudIrUmV2eRP94/CURkm
	0Qrhh0MNrQYHHmfUhGu+uKsZESS2ddUakq0HaY7GQkxU7f6S3KLjtgAo4gjPkiCqBMPxlpCa2b0
	xkN+Vi2kmJlekEhvsB4rheA==
X-Google-Smtp-Source: AGHT+IFdmKhHYtgsHPTl6CyKVjdv7Wx0RMJtivMRQpM2Nr4iC8LeoKdP5BxwOeKgvyZmEsgfRTyhag==
X-Received: by 2002:a05:6808:1827:b0:3f9:1fee:8030 with SMTP id 5614622812f47-4004d97e5dcmr6903664b6e.9.1744122843843;
        Tue, 08 Apr 2025 07:34:03 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6044f4a8bbcsm481114eaf.14.2025.04.08.07.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 07:34:03 -0700 (PDT)
Message-ID: <330afc35-662c-41da-af44-2087ee0e1fee@gmail.com>
Date: Tue, 8 Apr 2025 08:34:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: locallogin - allow
 sulogin_t unconfined domtrans
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 14:34:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1334

Signed-off-by: Clayton Casciato <majortomtosourecontrol@gmail.com>
---
 ...ystem-locallogin-allow-sulogin_t-unc.patch | 81 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch

diff --git a/recipes-security/refpolicy/refpolicy/0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch b/recipes-security/refpolicy/refpolicy/0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch
new file mode 100644
index 0000000..935f3d5
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch
@@ -0,0 +1,81 @@
+From 43dcc59a402353f79acfd9247daafe3e9fa0d13f Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Tue, 18 Mar 2025 12:49:43 -0600
+Subject: [PATCH] locallogin: allow sulogin_t unconfined domtrans
+
+type=PROCTITLE proctitle=/usr/sbin/sulogin
+
+type=PATH item=0 name=/usr/lib/ld-linux-armhf.so.3 inode=1956 dev=b3:32
+mode=file,755 ouid=root ogid=root rdev=00:00
+obj=system_u:object_r:ld_so_t:s0 nametype=NORMAL cap_fp=none cap_fi=none
+cap_fe=0 cap_fver=0 cap_frootid=0
+
+type=CWD cwd=/root
+
+type=EXECVE argc=1 a0=sh
+
+type=SYSCALL arch=armeb syscall=execve per=PER_LINUX success=yes exit=0
+a0=0x43032e a1=0xbec21aa8 a2=0x431760 a3=0xb6f61df0 items=1 ppid=352
+pid=353 auid=unset uid=root gid=root euid=root suid=root fsuid=root
+egid=root sgid=root fsgid=root tty=ttyS0 ses=unset comm=sh
+exe=/usr/bin/bash.bash subj=unconfined_u:unconfined_r:unconfined_t:s0
+key=(null)
+
+type=AVC avc:  denied  { siginh } for  pid=353 comm=sh
+scontext=system_u:system_r:sulogin_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process
+
+type=AVC avc:  denied  { rlimitinh } for  pid=353 comm=sh
+scontext=system_u:system_r:sulogin_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process
+
+type=AVC avc:  denied  { noatsecure } for  pid=353 comm=sulogin
+scontext=system_u:system_r:sulogin_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process
+
+type=AVC avc:  denied  { transition } for  pid=353 comm=sulogin
+path=/usr/bin/bash.bash dev="mmcblk0p2" ino=689
+scontext=system_u:system_r:sulogin_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=process
+
+--
+
+Similar policy:
+
+https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20250213/policy/modules/services/cockpit.te#L222
+
+--
+
+Fedora:
+
+$ sesearch -A --source sulogin_t --target unconfined_t --class process
+allow domain unconfined_t:process sigchld;
+allow unconfined_login_domain unconfined_t:process transition;
+[ unconfined_login ]:True
+
+$ getsebool -a | grep unconfined_login
+unconfined_login --> on
+
+https://github.com/fedora-selinux/selinux-policy/blob/v41.34/policy/modules/system/locallogin.te#L277
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/ec2b2befdd9f3760b6afcc4ec45a4c07e78e2932]
+
+Signed-off-by: Clayton Casciato <majortomtosourecontrol@gmail.com>
+---
+ policy/modules/system/locallogin.te | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
+index 02c7ff56d..fcec23010 100644
+--- a/policy/modules/system/locallogin.te
++++ b/policy/modules/system/locallogin.te
+@@ -298,3 +298,7 @@ optional_policy(`
+ optional_policy(`
+ 	nscd_use(sulogin_t)
+ ')
++
++optional_policy(`
++	unconfined_domtrans(sulogin_t)
++')
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 21bfbb8..c5b41ee 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -79,6 +79,7 @@ SRC_URI += " \
         file://0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch \
         file://0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch \
         file://0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch \
+        file://0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

