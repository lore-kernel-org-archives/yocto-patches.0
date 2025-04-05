Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3BBC36010
	for <webhook@archiver.kernel.org>; Sat,  5 Apr 2025 13:55:14 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web11.6470.1743861307616662179
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 05 Apr 2025 06:55:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LbEfyOR7;
 spf=pass (domain: gmail.com, ip: 209.85.166.46, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso70852139f.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 05 Apr 2025 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743861307; x=1744466107; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ik5bMVLLourqH7H7EQ+X9Gn/nL8yRNvHtguGs9+KrHY=;
        b=LbEfyOR7I+nGb/LhYINvVs5bLThF1RZ7xn4tEemPH0LbDbmRawx7iwnF0r/qT4/Z78
         uQq5p+57onBHU987Tm4Fky3PMQW7LSc2cE/7qo3L5qS+1KAlB4jINAw7K2YMOTv0109X
         c11qOtNl1Cxr18mGjNKGB9EPeTEseRs1awD5cIwC1eeBrTjuqUurO/qpaddSHzdTNJdI
         mu19jk++iKGqge0NmWLHqHBq8QsNsgUjz1sV5LcYZXyRxR9sPuXur+RepzFPYgFOAhqQ
         59G6PdQDWGT1Ws0blYkEb6z1psFIn0ie95R1rI3wGNBO2v9wmskAQiabm30Cd4M9d8uq
         O7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743861307; x=1744466107;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ik5bMVLLourqH7H7EQ+X9Gn/nL8yRNvHtguGs9+KrHY=;
        b=TP/nTV0tYGNl9B0aL6C3GhoAyYqgrG9MWQOWg268thF+X4nkm78uDH+Unx1jVBTD3v
         Mh492Bs+Sfa6GAeulZ7NgDJZSFFHMtb21MVEIHYoi2bCfjdLc1j+4K0f1TjSn+YOGZe/
         adtXDOwJKjzU7z9pGiYhjWom9lbqPtkM6UiWGkOKljTsaPUUkMpv7NiSLYSyWpHkpJqB
         pwk1MhDpY2pCUsFc75KuMqE7zQC0Q7YFq//PGqk/gPA6JrPUY4T3EfeI7r3O5tWjvLpi
         HbiEPsCCmcQDQBCgjBfrH9eKsVXF5KSjunRLULKh6/QiRbXCBAVByTQ0074BbJx7wtkF
         cEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX18Ej0ci2dGUZ0Z23mbquzU+2f9F5X2Jcdgwf8GnwTTy/pCDbZxdKsGulSvhdwiqUtgsP5lnjMGmwu0ygy@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwO6UTw6zGI5LT4u3VgaJGhE3Sb0mHu/bghKm8KDmf7u+BuyPa8
	YIsqBbezoBc6LhMfVmLnOqgrV/NGvxkBQI0YnQqZgT5zSmxqwV0L
X-Gm-Gg: ASbGncunoFnYRFWsLlw9fcCh5SBkYcDaj+4PomM+NIFu0V34qKEO/+NfGHmcsVOmo3/
	g2UHBZGrsNTexXBipNqlq9AGp4S0l8w+COvVLrwrrHASMFoN8NCAfH8xfJyctJZRZV9Vf6wwZ5P
	gadd934qskOsnfnkNTtifGlMRAHtEok5FYbrvCO+rem9/3CkayXcznMIFP0Vg8aI6dS9WJ/WnNi
	Z5YGaeii0wc13iQuHfGpIdGtq5ZnLWy4v1MI4s4VQjn8W+2o10xRVGioNvx0rXzbQh9SKEio1VI
	tTQML6vkQUpNGUiDNH61GwRTrHc6NnlY2wwoQVHcPtBf4CgX75cXwX4meYtGBN1RM87Oojv8oVE
	4Ha1EajKjBGFlA7tLn125MA==
X-Google-Smtp-Source: AGHT+IGrIEGUA+FUnDrcahCwYGSd5tTIy0vqY6q5viWlVgPdk0fH4+R0n5sju3Bgs/S7tWdE1BkCoA==
X-Received: by 2002:a05:6602:4c8c:b0:85e:2e83:52a5 with SMTP id ca18e2360f4ac-8612aa48cb3mr247298639f.4.1743861306720;
        Sat, 05 Apr 2025 06:55:06 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5c6919asm1317760173.64.2025.04.05.06.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 06:55:06 -0700 (PDT)
Message-ID: <2662ce7c-528c-4408-8b76-78a2537f5614@gmail.com>
Date: Sat, 5 Apr 2025 07:55:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: firewalld - fix lib_t
 Python cache denial auditing
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 05 Apr 2025 13:55:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1285

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-firewalld-fix-lib_t-python_c.patch | 122 ++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch b/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch
new file mode 100644
index 0000000..e2bc1d7
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch
@@ -0,0 +1,122 @@
+From f53e48c7a68c28b66d20416ebf81217e4892104f Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Tue, 4 Mar 2025 08:17:47 -0700
+Subject: [PATCH] firewalld: fix lib_t Python cache denial auditing
+
+type=PATH item=3 name=(null) inode=15343 dev=fe:00 mode=file,644
+ouid=root ogid=root rdev=00:00 obj=system_u:object_r:lib_t:s0
+nametype=CREATE cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
+cap_frootid=0
+type=PATH item=2 name=(null) inode=3055 dev=fe:00 mode=dir,755 ouid=root
+ogid=root rdev=00:00 obj=system_u:object_r:lib_t:s0 nametype=PARENT
+cap_fp=none cap_fi=none cap_fe=0 cap_fver=0 cap_frootid=0
+type=PATH item=1 name=(null) nametype=CREATE cap_fp=none cap_fi=none
+cap_fe=0 cap_fver=0 cap_frootid=0
+type=PATH item=0 name=(null) inode=3055 dev=fe:00 mode=dir,755
+ouid=root ogid=root rdev=00:00 obj=system_u:object_r:lib_t:s0
+nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
+cap_frootid=0
+type=CWD cwd=/
+type=SYSCALL arch=armeb syscall=openat per=PER_LINUX success=yes exit=3
+a0=AT_FDCWD a1=0xb6551ce8
+a2=O_WRONLY|O_CREAT|O_EXCL|O_NOFOLLOW|O_CLOEXEC a3=0x1a4 items=4 ppid=1
+pid=225 auid=unset uid=root gid=root euid=root suid=root fsuid=root
+egid=root sgid=root fsgid=root tty=(none) ses=unset comm=firewalld
+exe=/usr/bin/python3.12 subj=system_u:system_r:firewalld_t:s0 key=(null)
+type=AVC avc:  denied  { write } for  pid=225 comm=firewalld
+path=/usr/lib/python3.12/__pycache__/traceback.cpython-312.pyc.3059098912
+dev="vda" ino=15343 scontext=system_u:system_r:firewalld_t:s0
+tcontext=system_u:object_r:lib_t:s0 tclass=file
+type=AVC avc:  denied  { create } for  pid=225 comm=firewalld
+name=traceback.cpython-312.pyc.3059098912
+scontext=system_u:system_r:firewalld_t:s0
+tcontext=system_u:object_r:lib_t:s0 tclass=file
+type=AVC avc:  denied  { add_name } for  pid=225 comm=firewalld
+name=traceback.cpython-312.pyc.3059098912
+scontext=system_u:system_r:firewalld_t:s0
+tcontext=system_u:object_r:lib_t:s0 tclass=dir
+type=AVC avc:  denied  { write } for  pid=225 comm=firewalld
+name=__pycache__ dev="vda" ino=3055
+scontext=system_u:system_r:firewalld_t:s0
+tcontext=system_u:object_r:lib_t:s0 tclass=dir
+----
+type=PROCTITLE
+proctitle=/usr/bin/python3 /usr/sbin/firewalld --nofork --nopid
+type=PATH item=1 name=(null) inode=15343 dev=fe:00 mode=file,644
+ouid=root ogid=root rdev=00:00 obj=system_u:object_r:lib_t:s0
+nametype=CREATE cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
+cap_frootid=0
+type=PATH item=0 name=(null) inode=3055 dev=fe:00 mode=dir,755
+ouid=root ogid=root rdev=00:00 obj=system_u:object_r:lib_t:s0
+nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
+cap_frootid=0
+type=CWD cwd=/
+type=SYSCALL arch=armeb syscall=rename per=PER_LINUX success=yes
+exit=0 a0=0xb6551ce8 a1=0xb6562f80 a2=0x1 a3=0x0 items=2 ppid=1 pid=225
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=(none) ses=unset comm=firewalld
+exe=/usr/bin/python3.12 subj=system_u:system_r:firewalld_t:s0 key=(null)
+type=AVC avc:  denied  { rename } for  pid=225 comm=firewalld
+name=traceback.cpython-312.pyc.3059098912 dev="vda" ino=15343
+scontext=system_u:system_r:firewalld_t:s0
+tcontext=system_u:object_r:lib_t:s0 tclass=file
+type=AVC avc:  denied  { remove_name } for  pid=225 comm=firewalld
+name=traceback.cpython-312.pyc.3059098912 dev="vda" ino=15343
+scontext=system_u:system_r:firewalld_t:s0
+tcontext=system_u:object_r:lib_t:s0 tclass=dir
+----
+type=PROCTITLE
+proctitle=/usr/bin/python3 /usr/sbin/firewalld --nofork --nopid
+type=PATH item=1 name=(null) inode=15344 dev=fe:00 mode=dir,755
+ouid=root ogid=root rdev=00:00 obj=system_u:object_r:lib_t:s0
+nametype=CREATE cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
+cap_frootid=0
+type=PATH item=0 name=(null) inode=7795 dev=fe:00 mode=dir,755
+ouid=root ogid=root rdev=00:00 obj=system_u:object_r:lib_t:s0
+nametype=PARENT cap_fp=none cap_fi=none cap_fe=0 cap_fver=0
+cap_frootid=0
+type=CWD cwd=/
+type=SYSCALL arch=armeb syscall=mkdir per=PER_LINUX success=yes exit=0
+a0=0xb64a46f0 a1=0777 a2=0x1 a3=0x0 items=2 ppid=1 pid=225 auid=unset
+uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
+fsgid=root tty=(none) ses=unset comm=firewalld exe=/usr/bin/python3.12
+subj=system_u:system_r:firewalld_t:s0 key=(null)
+type=AVC avc:  denied  { create } for  pid=225 comm=firewalld
+name=__pycache__ scontext=system_u:system_r:firewalld_t:s0
+tcontext=system_u:object_r:lib_t:s0 tclass=dir
+
+--
+
+Fedora
+
+dontaudit firewalld_t lib_t:dir write;
+https://github.com/fedora-selinux/selinux-policy/commit/38c318fb0da5ffe99b6d1c599d8f0b9968efa640
+
+Other lib_t seems to be handled with:
+dontaudit firewalld_t filesystem_type:dir audit_access;
+dontaudit firewalld_t filesystem_type:file audit_access;
+
+https://github.com/fedora-selinux/selinux-policy/blob/1e6221cdad83095faff06774c600a308544d64b8/policy/modules/contrib/firewalld.te#L94
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/8a4043060d847630170acfc588551311bb072966]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/firewalld.te | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/policy/modules/services/firewalld.te b/policy/modules/services/firewalld.te
+index e686270b1..f592cf4f6 100644
+--- a/policy/modules/services/firewalld.te
++++ b/policy/modules/services/firewalld.te
+@@ -86,6 +86,8 @@ fs_getattr_xattr_fs(firewalld_t)
+ 
+ logging_send_syslog_msg(firewalld_t)
+ 
++libs_dontaudit_manage_lib_dirs(firewalld_t)
++libs_dontaudit_manage_lib_files(firewalld_t)
+ libs_watch_lib_dirs(firewalld_t)
+ 
+ miscfiles_read_generic_certs(firewalld_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index f952fd4..c848039 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -75,6 +75,7 @@ SRC_URI += " \
         file://0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch \
         file://0058-policy-modules-services-chronyd-allow_dac_read_searc.patch \
         file://0059-policy-modules-system-unconfined-fix-oddjob-security.patch \
+        file://0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

