Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6855DC36010
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 14:38:14 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web11.12878.1743777493702345499
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Apr 2025 07:38:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PnIMpRy3;
 spf=pass (domain: gmail.com, ip: 209.85.166.47, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85e15dc8035so59679039f.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Apr 2025 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743777493; x=1744382293; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyaYGdbd4y8YWyvMqKi27J01cvJ+P7XYj4Ki19qdrTU=;
        b=PnIMpRy3eYzMLrs+1R957o3K027Km/aj4lTtyQaDQLUPgutY7PpMmbh8Lb/bRqwi1c
         Eh+iSY9HqnaY6DkeRK0XIRtJkLz0ozghQK+Z/7PoXIvAxe9F5VjeUqPBq/zyNpEFwOf+
         wFsNiVtcaxvQrEArynHU8Hn/Hr85rpbcc6lcrPoPaySCCKEiuuezv181WaJraeP8enrj
         qhEZ/03SneWocVONFpQRzZ6i7UMbbjZPutwZCFZoKUN7UJkXTRga3BlXBpRJXlRiJGIl
         lvU4HV1e6eEsFWEG5c69I2kZ2WNuXMGfCyQgtK7kMx73Ib39tVby67eOyOoXmNz+8+a3
         SMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743777493; x=1744382293;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vyaYGdbd4y8YWyvMqKi27J01cvJ+P7XYj4Ki19qdrTU=;
        b=MotCyXUgTQh6KlwkXs/wjBZ76DECXTEGq6MzKKBk9osTd+dMj7U7/rz7EqHIBxZfII
         +MjHkD+pa/PMSxm0NkLxSBQk8ZNQqMgfRiGve0rZvg+2sdziamHTojS1C8KUP2OYY58/
         SH8fqkrBs0FB+APW0m0pJYlO3gIau/mwFoCmnZo4GM2DWw/0ouERN2CyrT5sCT02M2Aa
         W582d+1k+MJ8kvRE72tAwOHZzxm3WeeFMDuLv/n2LTw/wfkH68e5jhUU4ArMAzGCzWDC
         7l3q8erBHsch7rhY9I8ogf4ERBGEVSCnzr1eHP61BIiDUVMmIkHe/vlbJvSjPr7XwE0L
         Zz2g==
X-Forwarded-Encrypted: i=1; AJvYcCX9YB++iXZqVP2hjvjeh/1QLM+9O3dT1pDCjdqe4Ybzo6RdTef1z8zQhNggTnnYpmwpHRPinlZCbGgyvTIh@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxdjpAqobzqr7+IyglrJCzGr66Ge/t9kYWzhdNzLopv7F4nqvNn
	YWHWYFIbSW0PairAqbN6gzwxmBu+pJ0tzC0gLIHmhWqaTmw5Zzp5
X-Gm-Gg: ASbGncs9o1WJdZf5kXC8HAvY1rbmthHjjjM9yeP+/r63F0mj66ZF0Z91uHt6Cv7rbd5
	7eDn2RRF8gLaf40jGCH8sDRg4kGG6dFdf23T6DoBIyWdSCdDEWta7cSYZf9FUdym/fbCqxpBJXy
	r5Vlj09mxlAsMz3PFH8yNNbomW8pYrt65Yr4MSuisGIxrCeURF7ROfNRG9SQSV1OMq56JFpLaD0
	U9iZQSgdugduYSvQG31Nh/YvPNCLy6X3euZVciSlbJmRhxLeal7hIq7u+fbRW9sv/Z5HT4Led3X
	LMfrssHX2Nunc5QSI5Gz/wtsQA3rIB5AuJGter070tOXiA2vDBll5csY4OD/SxVTbrA3CLQ6Gwm
	ZfJP6bLhhXF1uRVjfizkMk8Zs7oLioOmn
X-Google-Smtp-Source: AGHT+IFj3vomGb1nj8F3ksai/KK/LsGBPz11XdghHWUHQfgFwhJHl+cvGuqigUnZsalq9vRyvdfySQ==
X-Received: by 2002:a05:6e02:1a49:b0:3d4:276:9a1b with SMTP id e9e14a558f8ab-3d6e3f755b1mr32649915ab.16.1743777492725;
        Fri, 04 Apr 2025 07:38:12 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5c69a8bsm827262173.73.2025.04.04.07.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:38:12 -0700 (PDT)
Message-ID: <f4d054ae-5f3e-4a78-b7c9-5e0b2627d142@gmail.com>
Date: Fri, 4 Apr 2025 08:38:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: unconfined - fix oddjob
 security_compute_sid
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Apr 2025 14:38:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1282

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-unconfined-fix-oddjob-security.patch | 58 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-policy-modules-system-unconfined-fix-oddjob-security.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-unconfined-fix-oddjob-security.patch b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-unconfined-fix-oddjob-security.patch
new file mode 100644
index 0000000..d7b644f
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-unconfined-fix-oddjob-security.patch
@@ -0,0 +1,58 @@
+From b876446d03eb31178c0cb0d1b082baabdea14793 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 3 Mar 2025 10:40:41 -0700
+Subject: [PATCH] unconfined: fix oddjob security_compute_sid
+
+type=PROCTITLE proctitle=mkhomedir_helper user123 0077
+
+type=SYSCALL syscall=socket per=PER_LINUX success=yes exit=3 a0=local
+a1=SOCK_STREAM a2=ip a3=0xbee9d8a8 items=0 ppid=404 pid=1386 auid=unset
+uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
+fsgid=root tty=ttyAMA0 ses=unset comm=mkhomedir_helpe
+exe=/usr/sbin/mkhomedir_helper
+subj=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+key=(null)
+
+type=SELINUX_ERR op=security_compute_sid
+invalid_context=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+scontext=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+tcontext=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+tclass=unix_stream_socket
+
+--
+
+Similar problem and resolution:
+https://github.com/SELinuxProject/refpolicy/pull/171
+
+--
+
+Fedora:
+https://github.com/fedora-selinux/selinux-policy/blob/v41.33/policy/modules/roles/unconfineduser.te#L365
+
+--
+
+Reference:
+https://github.com/SELinuxProject/selinux-notebook/blob/main/src/auditing.md#general-selinux-audit-events
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/bcb8e1d4dbff48477a9a8a7d215e32370c6e779b]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/unconfined.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
+index d54fe2fd4..a2f898551 100644
+--- a/policy/modules/system/unconfined.te
++++ b/policy/modules/system/unconfined.te
+@@ -157,7 +157,7 @@ optional_policy(`
+ ')
+ 
+ optional_policy(`
+-	oddjob_domtrans_mkhomedir(unconfined_t)
++	oddjob_run_mkhomedir(unconfined_t, unconfined_r)
+ ')
+ 
+ optional_policy(`
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 9f536bb..f952fd4 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch \
         file://0058-policy-modules-services-chronyd-allow_dac_read_searc.patch \
+        file://0059-policy-modules-system-unconfined-fix-oddjob-security.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

