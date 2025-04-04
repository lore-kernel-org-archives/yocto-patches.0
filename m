Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7DDC36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 14:22:24 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
 by mx.groups.io with SMTP id smtpd.web11.12477.1743776539591312017
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Apr 2025 07:22:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MeRiCHEo;
 spf=pass (domain: gmail.com, ip: 209.85.166.48, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b58d26336so152713739f.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Apr 2025 07:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743776539; x=1744381339; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+kw5Pa0H6/Fer5lM322jmR87/cmFGink3neqeWL/KA=;
        b=MeRiCHEoE+zP3oMzQxrr716rlMDA4y4x9CYnV2+s1ToU4rlHdY3bBMixsErApz05J6
         DEGVNRzgKhZpWF0swFXTyNC4EE4J1Gval7U1yYVdfL/nNiJtgpemq/LAiSCO4Mmk1iiL
         P/GltfDCS6YVjdV6Iw3w1R6vn3U4NdBiPs5aPUjITc7vF2vSN3FMJ5DIkRN9J4bcERUF
         FGdmmNAfliVyyT0dylPfu35Wr66JZBCYyC/dFHY6DL/jhxbE+0roN+T4vLtixtHCXZZo
         fYDoktfMqZ40wFu0Q63F0BX9tESoUV+XzTAlQbbD9D3ie0YSFS++SAE3MCHFyQUFi5Qd
         WkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743776539; x=1744381339;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V+kw5Pa0H6/Fer5lM322jmR87/cmFGink3neqeWL/KA=;
        b=vb4bO8pqTfE13c2BHhGweA2wxH2NW904yshGyci7vv5+q0+Zm0Gck7S6xZGJxqhmez
         6V0i+EJ8UYTHLTXpINcQXC/REaayon8l2MOsSiEj0LlzfjiMec2wEAY7zWKtCxxxoi5U
         6yyvnB1boSTFpUoDwZrYB1f40JobEqYR3Xy8OOTDlIQHGRy8mdE5sKkPiaBPDs9mta0c
         gA9Nync1EZvMkARuyfVqYTNrsTAOgesiyPC+NlgaI/9J+kKLrkNjYPq9XIozJ11QdD5U
         KaivIkQ4648ZislVbALs9q1/XW41dBHNnLhibKaA6bGRrOOF7xA5ADDmbbDGy0caxGIW
         +pKg==
X-Forwarded-Encrypted: i=1; AJvYcCVH+eE6cVfhgzEHjkmyGYpf4J35fqVhWTghK71r8Ip4o1ZxNcGACkZmHSdQpkSRzGoIKRZ7M3EtQKHlkXQZ@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwS1XEkpQD5FGO7SVm9wIFfRX3Bxa+Zo5zBQ6KuluriCtSjvoTS
	QNxMBUq27MA/EmJSjygbyAtTVoPJl6PNmEjFRA6rY5kGq+pQMIls
X-Gm-Gg: ASbGncuUNNctWVetpQ5rxFejeGPVR+B6xXzquCMFkyM2+efPjUn5VUM8PX2eNWbUjgL
	wP3rJsHlD31LTaUx3uaUwt9H/rclKc5WVAySG0trb4lhw+o7zKdlFlmv9MvUHkRuunSWQmYCOIt
	eOH2CpoMkOuWw4BIdcwRCO1AUroxsmUqFfboNZ/YvsZvGYHKxf1xXfWvBUV3DfvEwZuQRsJ3+h8
	6lF3jjbH3P7NAEK3NhSlGXC1vA4pmWu5TCi+vrBW7xtjaTS0enO2oHJdrL++biiORVsAU1Is9Iz
	6+Hfyp0na5fE8WntkJbVyX4ftqpz12c/zzjpaxzDG2ilxlAP4vl1y+6/vt2K2rqLM9wr0SWKuCV
	Sb83bw2EvOhQAfCVo79HN/g==
X-Google-Smtp-Source: AGHT+IEd5AyvNHhUQDZL6kkFIdu5LshV501Ovnk7IyVMxeNXY0nBWQ1ozSmBluCMz42IZD2iwCsltA==
X-Received: by 2002:a05:6602:4801:b0:85b:35ef:b1fb with SMTP id ca18e2360f4ac-8611b3d4ad3mr422332439f.2.1743776538715;
        Fri, 04 Apr 2025 07:22:18 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8611128b355sm65525439f.17.2025.04.04.07.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:22:18 -0700 (PDT)
Message-ID: <f594248c-32d6-4ccb-8249-f052e6543229@gmail.com>
Date: Fri, 4 Apr 2025 08:22:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: firewalld - fix lib_t
 Python cache denial auditing
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Apr 2025 14:22:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1281

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-firewalld-fix-lib_t-python_c.patch | 122 ++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch b/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch
new file mode 100644
index 0000000..3e7621b
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch
@@ -0,0 +1,122 @@
+From bd6e0886f4acfd9f704886bfefde2f270c9619fe Mon Sep 17 00:00:00 2001
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
index bf9895f..f037c0c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -75,6 +75,7 @@ SRC_URI += " \
         file://0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch \
         file://0058-policy-modules-services-chronyd-allow_dac_read_searc.patch \
         file://0059-policy-modules-system-unconfined-fix-oddjob-security.patch \
+        file://0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

