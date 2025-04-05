Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7720FC36010
	for <webhook@archiver.kernel.org>; Sat,  5 Apr 2025 14:10:24 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web10.6849.1743862220338221155
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 05 Apr 2025 07:10:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Se82+TRC;
 spf=pass (domain: gmail.com, ip: 209.85.166.43, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85517db52a2so48833739f.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 05 Apr 2025 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743862219; x=1744467019; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ITTLWLG1p2wd6t9tz4U9KCxCGAlt093+nIa7YQ1lzk=;
        b=Se82+TRC+ttDA34cF+s8GXYJyyOFBU7bhD1fQ/PCzEmK14uZj41BMnL7LJqu6hDgLB
         yUTpZVWbOg60rev4C3BUvL6MhbEj5RjmIWlimCxd7SAiegDKlKaJtbVgp1J4yOhZ5ncC
         1KYu5dHiw5MNSH9HUc58iiMXkBYRWxS1K/lsownGT3IE5CaluAcrrFvYpM1gev83KV2p
         tRdXNS+8sxbYg0xvclSUmZ9Xmtm8oHfS2oWQduaMUwgw+u1KxhVFtkh09Q2PC5BSe81g
         GG4zrSuhOGo1X0Pq1et5Af8Gb6qC2xtM3KEuTQeoxozlQKy96ehzK9ZRpirsxF295fTJ
         K4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743862219; x=1744467019;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7ITTLWLG1p2wd6t9tz4U9KCxCGAlt093+nIa7YQ1lzk=;
        b=eGkXnIRB8Ic1mkHEW4sL+iLxNKTa1BT9oT/wjP2ATBhgTxcONDJ5vnBNY8bktWUDHD
         b038jdKhJQ7MDc3hf1tLdKES0wz9K3aBJp2N2BFu5ChCEJ47wX5Qo09KZHsgHZomwlHG
         r0t0vaCjQ4jclPegFFive0udAZgYfCCAhg5TqLbSAm7cFEs+fSfOLN+Py4totd0JOBKJ
         1AqeHqQPV86z0mEKpJ7Q6mqczNx8oMYAWUaiyrAmQYGggPYDehZjhMp/lFUrEHK7c6C2
         oMbcWq6f1jD1w1jpqVO+fi9QBI/jA3w4D2ued9QIAbuLALq8dmH/cIRN8zrlhoQ9c2tR
         LHsg==
X-Forwarded-Encrypted: i=1; AJvYcCVW9mmZ4JPVh608E0D8Q1o8UEvMukQlurlSM1FIQ1fpd+ASxG72PN2MtK0EdJ4+FNUe3APIyO2UmgTsKpA9@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YyR5zswvK17rMURG70SHMgI9TinGGmrzD96OREfJod0wfpNBT9y
	RPPintznH0USOpYuQJl+7+3rrfeTIrL2lsqyESWKRfjqFIMI1+0+
X-Gm-Gg: ASbGnctLx+Bo+K87UW9ZZL9RqwfPN/uUvf6lOVKxdj1ZyJX3HsA9wowDYoi45mAZ9Zx
	Rz5Dr2hazezbu6E8aqn6Bo29daAzQIhVrzovn+8C5bIctm7KMEXQRoSrwdU254CSqL6B/kDXF4v
	1gHZgDH29ZKj26KK7OsNA+YKtEW+fjHgobpNalKjkT+xsIFr0vhr+LX5oye2lFXy2GP5X3RsKTO
	tctPihzd+NKglPn/zLyjEGVz8bPBbwmv27ZwkQbjVNUab3PWVIPNQrBZzmkP7H8RnJ64Brk3TQn
	qtfJ8cGdgFMg6bz4zGqyCkll2SdOFGlVDOejidBDx54S+gctCLeuOJJgC74XUOhpOgTBH6GLs8v
	Zdj6LID1Kl2Q4z1VP96PB8Q==
X-Google-Smtp-Source: AGHT+IF/FaJe2tVKh9edFRVCEDDDLrE89WNyS7JGGaM6hjzIaGbchpF9uTv6Zmi4zT4kdjmIDX3SHw==
X-Received: by 2002:a05:6602:3998:b0:85a:eecd:37b with SMTP id ca18e2360f4ac-8611b4e1feamr798597339f.11.1743862219465;
        Sat, 05 Apr 2025 07:10:19 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861112620d2sm110264039f.1.2025.04.05.07.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Apr 2025 07:10:19 -0700 (PDT)
Message-ID: <f8d4dc67-e084-45b4-95e7-4174916dfc07@gmail.com>
Date: Sat, 5 Apr 2025 08:10:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: firewalld - fix firewalld_t
 firewalld_tmpfs_t exec
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 05 Apr 2025 14:10:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1286

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-firewalld-fix-firewalld_t-fi.patch | 49 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch

diff --git a/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch b/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch
new file mode 100644
index 0000000..9d66889
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch
@@ -0,0 +1,49 @@
+From f1129180e809c74b41ea928167265730fd64ae4c Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 10 Mar 2025 14:15:39 -0600
+Subject: [PATCH] firewalld: fix firewalld_t firewalld_tmpfs_t exec
+
+type=PROCTITLE proctitle=/usr/bin/python3 /usr/sbin/firewalld --nofork
+--nopid
+type=MMAP fd=9 flags=MAP_SHARED
+type=SYSCALL arch=armeb syscall=mmap2 per=PER_LINUX success=yes
+exit=(null)(Unknown error 1238224896) a0=0x0 a1=0x1000 a2=0x5 a3=0x1
+items=0 ppid=1 pid=270 auid=unset uid=root gid=root euid=root suid=root
+fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset
+comm=firewalld exe=/usr/bin/python3.12
+subj=system_u:system_r:firewalld_t:s0 key=(null)
+type=AVC avc:  denied  { execute } for  pid=270 comm=firewalld
+path=/memfd:libffi (deleted) dev="tmpfs" ino=44
+scontext=system_u:system_r:firewalld_t:s0
+tcontext=system_u:object_r:firewalld_tmpfs_t:s0 tclass=file
+
+Fedora:
+$ sesearch -A --source firewalld_t --target firewalld_tmpfs_t --perm execute
+allow firewalld_t firewalld_tmpfs_t:file { append create execute getattr
+ioctl link lock map open read rename setattr unlink watch watch_reads
+write };
+
+https://github.com/fedora-selinux/selinux-policy/blob/v41.33/policy/modules/contrib/firewalld.te#L66
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/c5a76add70965ae8c988310f79c8cb750afc9bc4]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/firewalld.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/services/firewalld.te b/policy/modules/services/firewalld.te
+index f592cf4f6..7573f3cc0 100644
+--- a/policy/modules/services/firewalld.te
++++ b/policy/modules/services/firewalld.te
+@@ -62,7 +62,7 @@ files_runtime_filetrans(firewalld_t, firewalld_runtime_t, { dir file })
+ 
+ manage_dirs_pattern(firewalld_t, firewalld_tmpfs_t, firewalld_tmpfs_t)
+ manage_files_pattern(firewalld_t, firewalld_tmpfs_t, firewalld_tmpfs_t)
+-mmap_read_files_pattern(firewalld_t, firewalld_tmpfs_t, firewalld_tmpfs_t)
++mmap_exec_files_pattern(firewalld_t, firewalld_tmpfs_t, firewalld_tmpfs_t)
+ fs_tmpfs_filetrans(firewalld_t, firewalld_tmpfs_t, { dir file })
+ 
+ kernel_read_network_state(firewalld_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index f037c0c..b433a1e 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -76,6 +76,7 @@ SRC_URI += " \
         file://0058-policy-modules-services-chronyd-allow_dac_read_searc.patch \
         file://0059-policy-modules-system-unconfined-fix-oddjob-security.patch \
         file://0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch \
+        file://0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

