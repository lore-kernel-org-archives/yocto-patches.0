Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B357C36002
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 03:40:06 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.web11.38458.1743997204205323675
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 06 Apr 2025 20:40:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QO70/rFQ;
 spf=pass (domain: gmail.com, ip: 209.85.166.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d5ebc2b725so10429285ab.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 06 Apr 2025 20:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743997203; x=1744602003; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pjVDO06TAyaoIApoyDW0WCITuRqiyipTjmo7j4Esrg=;
        b=QO70/rFQ3rfHXRcgBmTUuKaxXSFLeIBxTKJmwmSeveWAk+uVNISvFwK3ahF/ZtHDWI
         DIauo52wSUG/KtlHbTO3yM3Kh4jTuemwVAkIDG/o0f3t6b9MwOBISQ7Ug9rPNgHgsJIV
         csNVJaDcmeYqXOJWXJbI6/WvUzmntkXej4EN9G9Cm3M3095bx5/JC6yDfzmQKtGALrOt
         hnF0WojD4MBmq6LFFOU3s0eYr4fnKfsByVOlT8AGxI2G25bD8+VrMSqXsNq6KHC6oFsC
         cTnm/qq5krfnEkhmzg14fNbBiD7bxUVpTUE4XfF0I8qwArhqKcp4WLx1EDu1jkAppsRm
         abEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743997203; x=1744602003;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7pjVDO06TAyaoIApoyDW0WCITuRqiyipTjmo7j4Esrg=;
        b=s66MluIbn9gI0HNY1Z5W2u1RcMcOjVeoJCZ5qb5PJzC3U1M55PtaJIc9nXaJnTo1tQ
         Pj5Vo14icUrVF+0UBm7BwhlBf950/PnPcYZE/JLbL66q6dlcshybfSgsftLTi9zAbZqf
         JXWXMsgJ4et0lc6DjvvNjuUnvlrEUUo0+UkfSa5CW8AZ2PRzp/iSWywlIw5pOrzH7DDd
         Qmp38l8DmylPrb/3P+1R1CT1l3ogLz6wKUAryIlwi+Ntp7FzqKFaqw8+Fg4NbSNK6K6S
         pxMDmK39/R0IdWgQEZ5aQTho8HHYmKesHJMXftbzX/C6wn1HR1eCzF1Lp7ZoPBnsisJ0
         qbAA==
X-Forwarded-Encrypted: i=1; AJvYcCUnt1ySUaXxEiFHaTW/5OjII3Ir/4A0vdqmltbUFWM+Djl9AcB/LjZ2JAlHK+SZy65ZFS3zEAWS2lL0kRGx@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzuJHrCiY3rIVGO43asofCv1qnR3+n8awrzqqRJWiGLPA+gcuPK
	gfwvE0EBPR0nVJTI3ojUoWtRaO0yx3aP9Op29B53yUgcjScRXXaU
X-Gm-Gg: ASbGncvmxqWcAsM2GTKK2CANKrf9SCaChiuoS121aM2A7l3i39pSvusKjICqHS4P/U/
	6DsclJDOWonqyAkvKdg88T7YVFRWlxLdWT/Ihl3LZmD9TG5eS6kpg/vWo67T86dxasPExrwKbRl
	/glRJ+jngh568D+YyGoyTjXtNN/Y+oxJVIEPkF6vTqDSNky8Y541FrZ6RKFOeQ0TND7Cxpym+jV
	WTUXlsnh/VC6JzR87srSw89+yUQ+/iSGa/X8tn5jvZaE+RJWlWymFHDDRtp/3s6oMGnJyg1wgZs
	2CDkuEC2JYmM5dssn2yqf+DXy4xFCvy9az2UxxM19Z8GsG0PpRuVgnuDSRLrNoAXlRMDEv+2v8I
	9sndk2qsmiJn6yjv+73BdTQ==
X-Google-Smtp-Source: AGHT+IEdWJ2xLS2GLHbKPFGlf6DFR0zr/dYFXfSmnMy1HBmh005Jw/kCQ09Nr2GrOlgGaFmCbV49uQ==
X-Received: by 2002:a05:6e02:2186:b0:3d0:21aa:a752 with SMTP id e9e14a558f8ab-3d6e52c595bmr116028785ab.2.1743997203257;
        Sun, 06 Apr 2025 20:40:03 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d6de7b9b60sm22019825ab.29.2025.04.06.20.40.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Apr 2025 20:40:02 -0700 (PDT)
Message-ID: <72d90af7-d3c0-4f8c-a376-a66a26523749@gmail.com>
Date: Sun, 6 Apr 2025 21:40:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: firewalld - fix
 firewalld_t firewalld_tmpfs_t exec
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 03:40:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1287

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-firewalld-fix-firewalld_t-fi.patch | 49 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch

diff --git a/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch b/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch
new file mode 100644
index 0000000..c8f9ec9
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch
@@ -0,0 +1,49 @@
+From 05da7b33197569f1a2c650cea77c53c6a143f2f0 Mon Sep 17 00:00:00 2001
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
index c848039..71b143b 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -76,6 +76,7 @@ SRC_URI += " \
         file://0058-policy-modules-services-chronyd-allow_dac_read_searc.patch \
         file://0059-policy-modules-system-unconfined-fix-oddjob-security.patch \
         file://0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch \
+        file://0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

