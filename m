Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5898ACCD1BB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 15:26:26 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
 by mx.groups.io with SMTP id smtpd.web10.12452.1761146780559568567
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Oct 2025 08:26:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=L9/4HwPY;
 spf=pass (domain: gmail.com, ip: 209.85.166.179, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430ca464785so50891635ab.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761146780; x=1761751580; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qtv7p6GnNIxrcDBjHAIm02aRnf/KS3PQlQZ1BU0a1lQ=;
        b=L9/4HwPYg1Tnz7CeiFvavQ69Smt3FABGQj8hnldvaOqftHtTMTVQE2Jvu1FWUMWW/n
         I8t9s08Ra0VDO0I4e9HLAQjJH9iMSvmaTgRSqhHZOumaK1xj4gQ5J3o6E8NVXJs2eP04
         1BivddsKylpSEjANzfLmnHAfowO0GOBVkX3COiycezovlUQyqITer94s3eUDehY1KUkP
         Vr4UPETCYl74C+WpvE6vNtYzZPS0QZoXC005g6qwlhZxNSFEer3YYhif4Oc5tC/cN1Ks
         BGpx7SgBJjQhwH6VHkguHziBIY7HYEyO51s48aiBF8FBMexSeipuwF7z0xqUpteDvnaF
         3GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146780; x=1761751580;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qtv7p6GnNIxrcDBjHAIm02aRnf/KS3PQlQZ1BU0a1lQ=;
        b=OfeArQezgryCt3ZCI0xMXfiCTx9pxfxMjFi1pTaKF4E9uvEM1lO0gd841UjbOgywLy
         igACuLPk2vs2BFPvYaSX1w0dvuNp6F3Qml71BztYAARauyoZ2/ZNxYt1yoxqhfrlTfZE
         koMRv2pHKjcS0U/07NAQCPnrXefzCRu1HuIXVDG2G30/loqwtmQ5KYGnynEU61mGI9za
         AUCGMoCjf/Qb/KlPWK2GKzWOc5as3F5pofYZo8+kgNYWavjrFEWJs/zlWFCRfqyVmfr+
         B/9ITBs9P1WiYvlwMymEBtQ4qFEGozMVRfMiblvrbCgYuL69q6n1RmzLkQQnMEAZcDAQ
         8Rtw==
X-Forwarded-Encrypted: i=1; AJvYcCUw9cFYz6o9eTQuJuGyZsTGT2S7xiFTpp/PmM2/Uvy+9tSpqj3Ke309LrTEdlE7YxfjlQGTEvT+8l6cb26M@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxO7a3XM1QBr2LqDqHtbbEAboorkdy0nSUXD75Gu60QxaX9/gQO
	flarEOKDe0uYRKZYNl6tnX17mUaPDeKQKMzK1vzvI+b2D04WuNRD6JlS
X-Gm-Gg: ASbGnctCl7cGOxYjKpc2sLBxQoETOeuGiFGCDF1K97C4Fysf0OPEgem+aJfQTvKO/2A
	Ipx6X7vp53G+t178bded+NKv87WxyYCarejaxP6jcSpsFTi9KLqSJcrVgPx7roApdlHZsq2Mh58
	Y+rwp0yjSmSWnGnYjqNTHYS7QAfSKEKDs+e06O5uJgZ9ijY+wPvwtATSp9JXo1hWy/nxU+lobE9
	QLuaDeiT0LlS8V9rt2PzuOQIp25zcpfRJOwI5RviyI5aVwV6Lr2r2FmjxlAQjl0Gd8Y9Sk7xW4b
	kFNitofw/sgWot3EdwQSDt4LbXKz2tCnqtuUJBSzr4tnHmqc+N+wXl6g6i+te7QyZr+V2H6ychh
	kiFFmhxjomKfqE28e2c+Ultr/TrIhoTodWBWY9buwLwyuZi3jz2pzdi23n/iXMGYhsKRci5VCvG
	ietNdOWtCdqhvoM5n35cZRAz/mXJ5G13sR9wxJHLd8XiJjY/5+UM0SFCcGWZzYGaX7
X-Google-Smtp-Source: AGHT+IFCf+297LP/ERvNmoOZyKOugztoC6suRUqDit1xookMha37NLYlsamP9txnJQS7MhOzmNLbYA==
X-Received: by 2002:a05:6e02:23c5:b0:431:d763:193a with SMTP id e9e14a558f8ab-431d7631991mr20252555ab.21.1761146779648;
        Wed, 22 Oct 2025 08:26:19 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9630a45sm5257745173.20.2025.10.22.08.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:26:19 -0700 (PDT)
Message-ID: <699748f2-1d3b-42be-9c42-9bb8039f3534@gmail.com>
Date: Wed, 22 Oct 2025 09:26:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: dbus - allow
 system_dbusd_t unconfined_t:fd use
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 15:26:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2383

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-dbus-allow-system_dbusd_t-un.patch | 59 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0064-policy-modules-services-dbus-allow-system_dbusd_t-un.patch

diff --git a/recipes-security/refpolicy/refpolicy/0064-policy-modules-services-dbus-allow-system_dbusd_t-un.patch b/recipes-security/refpolicy/refpolicy/0064-policy-modules-services-dbus-allow-system_dbusd_t-un.patch
new file mode 100644
index 0000000..6279c0c
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0064-policy-modules-services-dbus-allow-system_dbusd_t-un.patch
@@ -0,0 +1,59 @@
+From bd85d4340b7af107749d65f673df781978214c3a Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Tue, 8 Jul 2025 16:58:05 -0600
+Subject: [PATCH] dbus: allow system_dbusd_t unconfined_t:fd use
+
+"sudo su -"
+
+--
+
+type=PROCTITLE proctitle=/usr/bin/dbus-daemon --system
+--address=systemd: --nofork --nopidfile --systemd-activation
+--syslog-only
+
+type=SYSCALL arch=armeb syscall=recvmsg per=PER_LINUX success=yes
+exit=312 a0=0x12 a1=0xbef207c8 a2=MSG_CMSG_CLOEXEC a3=0x1 items=0
+ppid=1 pid=184 auid=unset uid=messagebus gid=messagebus euid=messagebus
+suid=messagebus fsuid=messagebus egid=messagebus sgid=messagebus
+fsgid=messagebus tty=(none) ses=unset comm=dbus-daemon
+exe=/usr/bin/dbus-daemon subj=system_u:system_r:system_dbusd_t:s0
+key=(null)
+
+type=AVC avc:  denied  { use } for  pid=184 comm=dbus-daemon
+path=anon_inode:[pidfd] dev="pidfs" ino=303
+scontext=system_u:system_r:system_dbusd_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=fd
+
+--
+
+Fedora:
+
+$ sesearch -A --source system_dbusd_t --target unconfined_t --class fd --perm use
+allow domain domain:fd use; [ domain_fd_use ]:True
+allow domain unconfined_t:fd use;
+allow systemprocess initrc_transition_domain:fd use;
+
+$ getsebool domain_fd_use
+domain_fd_use --> on
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/c0848ca7b7469436ae1ec3190c808ea5a92e6bc6]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/dbus.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/services/dbus.te b/policy/modules/services/dbus.te
+index 4e2e32ec0..1420ede29 100644
+--- a/policy/modules/services/dbus.te
++++ b/policy/modules/services/dbus.te
+@@ -285,6 +285,7 @@ optional_policy(`
+ 
+ optional_policy(`
+ 	unconfined_dbus_send(system_dbusd_t)
++	unconfined_use_fds(system_dbusd_t)
+ ')
+ 
+ optional_policy(`
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 8782dbe..9d729df 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -79,6 +79,7 @@ SRC_URI += " \
         file://0061-policy-modules-services-chronyd-allow-chronyd_t-kern.patch \
         file://0062-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch \
         file://0063-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch \
+        file://0064-policy-modules-services-dbus-allow-system_dbusd_t-un.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

