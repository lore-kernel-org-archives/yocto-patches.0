Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5976BC3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 23:11:40 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
 by mx.groups.io with SMTP id smtpd.web11.39.1743721899839469261
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Apr 2025 16:11:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fs6M4h1q;
 spf=pass (domain: gmail.com, ip: 209.85.166.52, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-855bd88ee2cso36888439f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Apr 2025 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743721899; x=1744326699; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76HphWsKY4FykH9j5tWYR9ryj/jkijoP/3pYZO9Dl00=;
        b=fs6M4h1qab9/g/l+oNJ4Zx9DHFOe9v0lmvgtb9iRstpyxkZkf/sXCNlhWj5Ea3a7Nm
         RlQ0Bt52nc1yNxbagArBnj0Y/TgxCEMQ6xEhRLKNEpA8FN7pDmPpGp1kX4+D6Q/xEWe8
         xLHAe9jgV7eCiXh4jU8zIPjNO2weuquCKP/JfXBFBm3thvEkbgAK0p0s67DeS38/utwk
         3Zj7c+qnh1yDF/msb9XjzI1HxsanyEsp/RPDQEpQogWIylUOT6odJ2irOjjmuW/irFVX
         igxAQ++t/6d7pX5DFeR8FHAYMdUvSwr4De9Y2jiFrdwkPRnr4hZrg9Tp/RgQVzw7WN4F
         GIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743721899; x=1744326699;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76HphWsKY4FykH9j5tWYR9ryj/jkijoP/3pYZO9Dl00=;
        b=Oav8NocRns0PvQ/gO9AVONtRNIOViQNnkSFUV1Dowuv2PzmKX14dYo7ec0PC7xQ+tJ
         tscijripFc3furmLDZJXA7/9p3bXVeypUGPmOjtoZhld/sj3y6dLdcVrgDx3l5ZbKITW
         SycWXzRJnTKoJnaIYQ8B5BhEmkYN1xcbtPAVQduE0NYOVZavmAKfHbIpOgpmp47Qt32Q
         /kl59jGCh4SJe8TuWwNTEnItEs4zO5/OCyl1hSdxnh1Gp2u5A+3f3aoB7WS+IAfRWWUH
         xsjr9kHy6zdP0n7GA5xMFnEld8RUYWEHmCZaWSqMKz8388Dl5OCsbHbfOWO0Z8dfmqmj
         RK8w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1bBD1+WW39dMKRmvDLksF37txY8xpRefTUFn7cOHIf1OQEqbVb4OyXIFa+eKwSGcdpJrsDCeA75oDCmN@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxsJ3CeA4r2YNi1qAOzW1xc++ZfK6kaRHv4eBLZS/NJq2Im4h3S
	xbgCObBNiZTiCOfD7Tt9eFqvkse24KqEqd0ZM5nQSoUM25dhzMFW
X-Gm-Gg: ASbGncuGcmq36hAWb3tLPRcWtv9YFOAxNx04zeiPt8d/C53A//XryNnwx0TKji0dmNx
	NPm7woh9TPKCXLsxp+mt466bvOSlN2Fs9kCqoO0CLnA1FjeQrjgh8RjYOeAK20vr3QKq40wdmO9
	lc1guKLbhijBCn0CRhm1YPETMHI6mNAE7IGmxWJpsMoZw3M9Z8DT75ApYNkXKFwQ6syYwOt/tgZ
	DCJf/Z7JSoMUQImFTxBuzedp1lgzS+IwDTUzyfxFn1TuOPzIKIOQC3E4psnHGLeUnhz1rKMx451
	jVuJlWeaICdmc+ACimAz31PHhnZ9L9EJ86gRo4iupVdXazorrO/W+4FYMa2oWt+ErWjWH71+y7K
	1QRlf5f5wNfYYM5TbB/5LskWzTWnu4xY2
X-Google-Smtp-Source: AGHT+IFoCgxTihRYYgOfr39+WPBSUHZ/uzX32YB0b6OqGCAFZQJiA2cWF5igLEJDXbij5Jq02ZzjeQ==
X-Received: by 2002:a05:6e02:1a66:b0:3d5:bdac:c927 with SMTP id e9e14a558f8ab-3d6e3f5f952mr19426645ab.18.1743721898774;
        Thu, 03 Apr 2025 16:11:38 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5c69ad7sm525512173.63.2025.04.03.16.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 16:11:38 -0700 (PDT)
Message-ID: <acfe2412-d087-44b7-a856-ae3dbf8d10fd@gmail.com>
Date: Thu, 3 Apr 2025 17:11:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: unconfined - fix oddjob
 security_compute_sid
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Apr 2025 23:11:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1279

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-unconfined-fix-oddjob-security.patch | 58 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-policy-modules-system-unconfined-fix-oddjob-security.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-unconfined-fix-oddjob-security.patch b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-unconfined-fix-oddjob-security.patch
new file mode 100644
index 0000000..33f5884
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-policy-modules-system-unconfined-fix-oddjob-security.patch
@@ -0,0 +1,58 @@
+From ccdb93b7566c4e2492da20ec7a0c19691206703f Mon Sep 17 00:00:00 2001
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
index cd04ef5..bf9895f 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch \
         file://0058-policy-modules-services-chronyd-allow_dac_read_searc.patch \
+        file://0059-policy-modules-system-unconfined-fix-oddjob-security.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

