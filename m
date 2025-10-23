Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22819CCD1BC
	for <webhook@archiver.kernel.org>; Thu, 23 Oct 2025 03:49:09 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web11.12269.1761191342217093085
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Oct 2025 20:49:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eXHDuUTv;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93eab530884so29538139f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 20:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761191341; x=1761796141; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUBF+J58MAfsPysksMlyheU82r+rg6J3+hcP0qPnkis=;
        b=eXHDuUTvu9erYrkxGFP+U+k3jlVSksvRJZzztBS9e9Ek+RS8YKMlXtuaZ+wNNgYLvD
         X6OOLPHkwjJ4KF8x+GCa4JdAgn7Ju8qe18iYAGZGawv88iOUN9RjpPL4Q90BSsMn2KIX
         qckiOx7/L644RyTlojge8B+2os5XQoLrkzrQ/sUO2Sr9nJ/Mwr6C/+9GmyGgOTlb6Ewm
         bPh2OfSAs+u/7iLRvdLXM+T8xewoDzRJkrwokIS7KZgWVj048PMJqUpLtwj5Uok2Hr06
         4BtT/zEworp9WgNuCuFrHkQtpkBGUxoI2Hq9MVM0hdZdP5ChqXranVXaTn/nlPidKqZW
         2jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761191341; x=1761796141;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wUBF+J58MAfsPysksMlyheU82r+rg6J3+hcP0qPnkis=;
        b=NTZ8eyRwUd73UmemJEvf9n0/Lw1xFNZ1Su6RDgdQLPFOFEtGfj8Ua/MmXmSblFZJOf
         NugCnPi7hSHaL4inM4UVqTxH+ot/fnl3j9qPdh7Qly3w2ai+KsXJAitHxSE30B4IWMy8
         eBxLGGzkW2Bo7dHGB5eqIo5RMc0fOCA9PA9x6bygNAID1blSsYcHlWBlaova9xVt7Nyo
         u1ugCPF6HN/xgWobtkwOyHrBhsBWisrrgf9EDWWJVTjHJ8PcvwR6lCIL9zUKBCC8yWc9
         6h6cN2RqohhmecUkGpnVqN/E6IvPIRKjwhLU42I5KGsUmSvZlzZ60pb7g5fPRHL/u5FC
         MJ6w==
X-Forwarded-Encrypted: i=1; AJvYcCUuwpRAElMA2LSo6WgCSfifq8nM4fACnVSjMtLMEz07+LVpFVnC0oe+oygJph1K0XPKXfAwO/o7oPI/0C/T@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzhAMdVZ4ZdvjMm/GAFCBsHmBGD73mvlu5tCbFIaBX1PgZzIJky
	/yFulRz5vCcy72UlLQXf2z16FNCczZkRJfdL77ICy2wbfNjODSiqjqex
X-Gm-Gg: ASbGnctzGdY9/2ZgCi/gdqnpA1rriYYLoPxulClH6ZzAt9m3JubDpRZEl/Yz75aEmZ1
	VVHEyOvh6ZvOFWml8+pvuCz6xHZpDJe5QNk55W8irizjgfQQpZe1xcc3SzMVMLisVWol4ZGQgJn
	DUlhWD7stC8mgfjylJVNcwnflnobW+etXSsu/FWygCOdhzM9RJuIjhH5/RYOrPdnp28bD5yB/Bk
	owKbzDDkeMyXOOcyaXthxVNS5joHXJwddKCaQx3sDZ+ZUR6c9OxSWkAemtRiE4NVGizFe/XQAee
	jOrNBlQYoZe2HZRCzycwA/h/6mc/as82sC+9Yhd8/lRelINJmX++NM2AaTTTIUDWwL/c847YJGq
	20Xw5gwxDXn6+HCX9+LUW9+R0me0hrwPhIYIcC6asSsqScw14AQ4wB1+Hi9i9fnBehOif28MF3W
	EHFYMtBKvKukU9rfSVwbdL0bbGIkiuovueRVguIDAyhB0i7Ga+xsLE8bZd5/wG2frz
X-Google-Smtp-Source: AGHT+IE9pEDDgp6cgT8riCE8mAyComP4lftFPajwVewAk90hvUJE/bRGuPEyFhzYyW+AeYaqDuTqeg==
X-Received: by 2002:a05:6e02:1445:b0:430:b6a3:53b4 with SMTP id e9e14a558f8ab-430c52343f1mr365988705ab.3.1761191341354;
        Wed, 22 Oct 2025 20:49:01 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb8eae82bsm402579173.58.2025.10.22.20.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 20:49:01 -0700 (PDT)
Message-ID: <68da0833-dd04-4bf7-8c65-ebf0a8d213d2@gmail.com>
Date: Wed, 22 Oct 2025 21:49:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: systemd - allow
 systemd_logind_t unconfined_t:fd use
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Oct 2025 03:49:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2385

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-systemd-allow-systemd_logind_t.patch | 56 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0065-policy-modules-system-systemd-allow-systemd_logind_t.patch

diff --git a/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-systemd-allow-systemd_logind_t.patch b/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-systemd-allow-systemd_logind_t.patch
new file mode 100644
index 0000000..be1cddc
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0065-policy-modules-system-systemd-allow-systemd_logind_t.patch
@@ -0,0 +1,56 @@
+From f76099508c56db31fdc331e844d4e5b574b3206b Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Tue, 8 Jul 2025 17:06:19 -0600
+Subject: [PATCH] systemd: allow systemd_logind_t unconfined_t:fd use
+
+"sudo su -"
+
+--
+
+type=PROCTITLE proctitle=/usr/lib/systemd/systemd-logind
+
+type=SYSCALL arch=armeb syscall=recvmsg per=PER_LINUX success=yes
+exit=24 a0=0xe a1=0xbee507e4 a2=MSG_DONTWAIT|MSG_CMSG_CLOEXEC a3=0x1
+items=0 ppid=1 pid=186 auid=unset uid=root gid=root euid=root suid=root
+fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset
+comm=systemd-logind exe=/usr/lib/systemd/systemd-logind
+subj=system_u:system_r:systemd_logind_t:s0 key=(null)
+
+type=AVC avc:  denied  { use } for  pid=186 comm=systemd-logind
+path=anon_inode:[pidfd] dev="pidfs" ino=311
+scontext=system_u:system_r:systemd_logind_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=fd
+
+--
+
+Fedora:
+
+$ sesearch -A --source systemd_logind_t --target unconfined_t --class fd --perm use
+allow daemon initrc_transition_domain:fd use;
+allow domain domain:fd use; [ domain_fd_use ]:True
+allow domain unconfined_t:fd use;
+
+$ getsebool domain_fd_use
+domain_fd_use --> on
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/a742066011070c6696eda00442a46d1e9970a614]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/systemd.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index 514ead9a8..2b2f43f36 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -1172,6 +1172,7 @@ optional_policy(`
+ 
+ optional_policy(`
+ 	unconfined_dbus_send(systemd_logind_t)
++	unconfined_use_fds(systemd_logind_t)
+ ')
+ 
+ #########################################
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 9d729df..33c3f32 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -80,6 +80,7 @@ SRC_URI += " \
         file://0062-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch \
         file://0063-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch \
         file://0064-policy-modules-services-dbus-allow-system_dbusd_t-un.patch \
+        file://0065-policy-modules-system-systemd-allow-systemd_logind_t.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

