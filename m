Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DDBC36002
	for <webhook@archiver.kernel.org>; Wed,  9 Apr 2025 22:07:06 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
 by mx.groups.io with SMTP id smtpd.web11.20995.1744236423195865067
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 09 Apr 2025 15:07:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NTnileSg;
 spf=pass (domain: gmail.com, ip: 209.85.166.53, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85e15dc801aso15296839f.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744236422; x=1744841222; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Fou0akzrdV7GNo8Px5/weIeBND1N10julyBMDBVJt4=;
        b=NTnileSgl78V5kaSSh61avD67goDbrme0gRO6k5VUstPQxHwYcHCLpe0ezXyvqzu5A
         1rRskcpQgppSAJMQceZSBHhsUa25J6ofg7JX2+MiJ0qk9sCRnppO4r78UrzyExXqvFlk
         kLJ6v1p+TgWp0BYBCCWjxL3TucgpikQ/qaTRq7M9RDUKTs7QSkhZhUV2WHghAOhHKm9x
         Zz4MXPbsIlkcuO7WCjdaK6cmqGYKfb/grBeIY9l+ySSY4z7CVJaACwAEDsMXdpOwIgky
         cKUvZVUM+IxNyCTsILotGcYc8DRlKyyUxJ4AV/aa2x+uLUe9uwCEi92b0Hn+cyRPg1js
         wmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744236422; x=1744841222;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Fou0akzrdV7GNo8Px5/weIeBND1N10julyBMDBVJt4=;
        b=ok0NWWch6DaL1R3z7Ve29YdKmqdG2ibl+3pmxZvoevY2FTNOcIY5UJAGzOR5BFHg20
         YaiCil5gMsVNcksJCEYdSm9XSdjdO3/8j+5lhUG8qe87TGciF2s+eQDcPs5nehDORTID
         XhLc5ve8QViQ9lKeBjDh0EeF4J/fRbQtEPemEs+qHtyrNXppweNhWSpeQBr8eC7pk0Oc
         l+UrQgAtDNUF8rtwbadVy7XklrQkaUya0D4mqXTjfmUgyiRlJ8zw7RLLrgVQMjZjRklH
         riNIrrAD3TrCzdl+YRn2KXA+QGkd9aDmvFwf62htVO07SWzaPgfpofB7GEb6X0tJCqGM
         LM8A==
X-Forwarded-Encrypted: i=1; AJvYcCWp8d2cLgw/Owbk2dN2lekI4Phq4daDmAe8EfZzUQamMnHqctMdPCn4l35zrkRAJt0L4qRsRPStORIl23FT@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzxyXBZrFDzpxeB/Ttk0EuI8mN6T6Tq9MukJW9q/dxzzfWxxgTm
	RUuxH966f31hQa5WgU1yTpK3TTewgqR1ixUoRwoQb8i+8MfD4BrM
X-Gm-Gg: ASbGncurUqakf2pbLIuSEya08sduzlz4aIOTAAbgtGw9wpWDKbuYy1h5LwGitskaHZ9
	LO0pyjISlDm/5hhH9YwBL4ir2ONswXf0gxMJraBMil4xzbY4loKjJw7/PqP0UUrnfX2tBcfyHCN
	xDZvCD1GHbLpaTivrNCHnlMN1UkN2aMtmJngppbP0MlOd7O3pZOEbas3FC9Cian950dbryeQdP5
	RqKSoWN9fPuSESVlHxrg0QIJQu/X72QCRirsJDOLZy/qbumv3gZR1zocvHnlOYS+KJGI1+eupWW
	X0GPBkZm3qVtyAIdzCZQTAU7GJJk7s0voeAOAtl4t9x+jgMkqcXUYWTHPM+aW9MeMBpCkr2LJfm
	JBx4KosrNumY43nIMeMe9F6J9ytpu
X-Google-Smtp-Source: AGHT+IGyYIb6oDAZV4GYAHVUoJZGkeKGsllzoIqNxK9y5zjzQutoSlHKW3EouBI81/Hy8ntcAjwB2A==
X-Received: by 2002:a05:6e02:1d84:b0:3d4:3db1:77ae with SMTP id e9e14a558f8ab-3d7e475c861mr8000255ab.18.1744236422223;
        Wed, 09 Apr 2025 15:07:02 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7dba648c6sm4538985ab.5.2025.04.09.15.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 15:07:01 -0700 (PDT)
Message-ID: <3d7fd2ad-5e83-499c-bc1a-f44e5aea6e56@gmail.com>
Date: Wed, 9 Apr 2025 16:07:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: locallogin - allow
 sulogin_t unconfined domtrans
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 09 Apr 2025 22:07:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1343

Signed-off-by: Clayton Casciato <majortomtosourecontrol@gmail.com>
---
 ...ystem-locallogin-allow-sulogin_t-unc.patch | 81 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch

diff --git a/recipes-security/refpolicy/refpolicy/0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch b/recipes-security/refpolicy/refpolicy/0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch
new file mode 100644
index 0000000..4081e08
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch
@@ -0,0 +1,81 @@
+From 606150f50b42da405266ae55d27ef01f70804329 Mon Sep 17 00:00:00 2001
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
index 6a3e9eb..0bd55c2 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -79,6 +79,7 @@ SRC_URI += " \
         file://0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch \
         file://0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch \
         file://0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch \
+        file://0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

