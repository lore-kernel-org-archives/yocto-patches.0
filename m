Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED7EFB7F2
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 19:03:35 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52918.1772046212555196153
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Feb 2026 11:03:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZBh46n0q;
 spf=pass (domain: gmail.com, ip: 209.85.210.51, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d18d0e6d71so5038493a34.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Feb 2026 11:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772046212; x=1772651012; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HECP2NSJAtvaMyPCj+kDWt1k0Lb1CUUsxXViLAY7uA=;
        b=ZBh46n0qobeCK7zc/NqAm9ppxzG0NVw7f+u60ETmUnTSgewtGJUiOoFGPm/sU3EIKf
         iMpo4c9bl/66t51fuvn5UVlryPdHPjRH9J7z29H9jVvFCBIqOBMpTwKnDoGLQO2Pm92z
         0ngphSzdn88ui035DLfcD9qM5F3GyJ9xMbsq/jIAWLiyi2HmiZqAK8xGjeleAy4cFFjB
         e75EYPL7q4mzM6/KIhii5B2lCkNpw46ZZAkYIJ51RNiSVSvMK0DwOy1LM8jY3xb3LtPD
         dE3fjECcUd8jk1oO5RL09xchuD/Cfko+HMLSELDAawScTotbPmMzYZ090ReBc/+CmFBA
         M2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772046212; x=1772651012;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HECP2NSJAtvaMyPCj+kDWt1k0Lb1CUUsxXViLAY7uA=;
        b=aUxNgedEzJk7ohoErAQHukxvPItoMON1UMSBqULir+z997YuiPUnHWmJAevKxoFCgU
         JXd8P2/BrRJoHavuZSpdluPFT/LL/KdZG3VZgeAUAoZM5+D9E77ZIgvFzNS2jwpBae3M
         EhAhC7vOv0sFCBNjv3LnZxYnyJOjmD1frrXUQddkfvf/ZZO7ehApheyKIBI5WkN1aEAF
         EScA8EZXcY4Ju5mx4L+cq2tRevEq5S7gMpJzRqiX4lRBZN/3FUTC9iSd3gUHT/I2HSOn
         4TK8exVpcMSbZFHnCpLMPjM8C5WAcjH1q8jD+Y+4hRklPX83NctxrJFSk6m//rhrHmX3
         Cdqg==
X-Forwarded-Encrypted: i=1; AJvYcCX0UQbKZZMQLF01IMb3bCvqCNNdAHG1iCYakd8fCLpDIJ6RIRVAz5aVpBbyIVK0ckqqr1h/icfgu/Cy65N2@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yyc2YzuY9w2bI5OQb4hk+CPSWSD2faifGC5jHwYVWEAhizt3SzY
	TDGM+6ewMtgDDzpR8jA+28Vl4HhlBeIawCiCrQGgSm3AOPRUYEJdEczL
X-Gm-Gg: ATEYQzyzFWqeKC0w8i71Vb8eUXrjjld0+QxsclO8dF26RVRqrQHMYE3r/Pa24sxnA4m
	QeoOW8HqUuobTB6dgciqKBwQPV6MFU7dDbEviTiBcW270LOZmtO7GHFQL+5s001jbr4dUgoQlOd
	Wpe7PQMZcDrJmJCsg76kdI1C5AHWrySjSHwnDcXEjK2uPlDHPmkgqbX2ZVMkBexiRx6Ua8YYKsi
	rc34w3Q1X4ZNOcMayDwJ1TwWCoojDQ+g2GDNeSa6rV38FnIWYtW8OfLLyqquzIVC2emfqMy1Lqp
	wT59z2d8YehjM/Zpi/THOIGcE9uEVEFYLX9SBa36S2VDGcKtMtPpL9mK5byj/FFa/zOmXxK9Nzs
	/w+FlE5bCOIlPwgCbadGxm2QP7ARdkbQsoiXOd+rsE8BcrUJSF6ijBnlqfCAItcOeB2zcdBKFA7
	XEAxa8lE0csiD9IsOdgSMx5ZwvGHYjHRWhn0bYSwiCTab5r5BswxycAH2J/6Z7+VOud0DvXc2uc
	es6
X-Received: by 2002:a05:6830:6d09:b0:7d1:9217:94e with SMTP id 46e09a7af769-7d582a8a148mr753103a34.26.1772046211803;
        Wed, 25 Feb 2026 11:03:31 -0800 (PST)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d04de97sm12587924a34.21.2026.02.25.11.03.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 11:03:31 -0800 (PST)
Message-ID: <27ab84e9-7adb-4322-a251-afcdd234eda9@gmail.com>
Date: Wed, 25 Feb 2026 12:03:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][whinlatter][PATCH] refpolicy: logging - allow
 syslogd_t syslog_tls_port_t name_connect
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Feb 2026 19:03:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3279

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-logging-allow-syslogd_t-syslog.patch | 55 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-allow-syslogd_t-syslog.patch

diff --git a/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-allow-syslogd_t-syslog.patch b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-allow-syslogd_t-syslog.patch
new file mode 100644
index 0000000..e9b50e3
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0057-policy-modules-system-logging-allow-syslogd_t-syslog.patch
@@ -0,0 +1,55 @@
+From 2d837226bb685e837046e1be1d0d7d6b67957387 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Wed, 10 Dec 2025 18:32:41 -0700
+Subject: [PATCH] logging: allow syslogd_t syslog_tls_port_t name_connect
+
+rsyslogd[492]: cannot connect to example.home.arpa:6514: Permission
+denied [v8.2402.0 try https://www.rsyslog.com/e/2027 ]
+
+--
+
+type=PROCTITLE proctitle=/usr/sbin/rsyslogd -n -iNONE
+
+type=SOCKADDR saddr={ saddr_fam=inet laddr=1.2.3.4 lport=6514 }
+
+type=SYSCALL arch=aarch64 syscall=connect success=no
+exit=EACCES(Permission denied) a0=0x6 a1=0x7fff38060bc0 a2=0x10 a3=0x0
+items=0 ppid=1 pid=492 auid=unset uid=root gid=root euid=root suid=root
+fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset
+comm=rs:main Q:Reg exe=/usr/sbin/rsyslogd
+subj=system_u:system_r:syslogd_t:s0 key=(null)
+
+type=AVC avc:  denied  { name_connect } for  pid=492 comm=rs:main Q:Reg
+dest=6514 scontext=system_u:system_r:syslogd_t:s0
+tcontext=system_u:object_r:syslog_tls_port_t:s0 tclass=tcp_socket
+
+--
+
+Fedora:
+
+https://github.com/fedora-selinux/selinux-policy/commit/42504eb364b73234bd622fe674427bdfb68dc043
+
+$ sesearch -A --source syslogd_t --target syslog_tls_port_t --perm name_connect
+allow syslogd_t syslog_tls_port_t:tcp_socket { name_bind name_connect };
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/7c0a3dff6916b19b9842ace9f6a49123f6f1bbb4]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/logging.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
+index 4de798007..121468ef6 100644
+--- a/policy/modules/system/logging.te
++++ b/policy/modules/system/logging.te
+@@ -627,6 +627,7 @@ tunable_policy(`logging_syslog_can_network',`
+ 	corenet_tcp_connect_rsh_port(syslogd_t)
+ 	# Allow users to define additional syslog ports to connect to
+ 	corenet_tcp_bind_syslogd_port(syslogd_t)
++	corenet_tcp_connect_syslog_tls_port(syslogd_t)
+ 	corenet_tcp_connect_syslogd_port(syslogd_t)
+ 	corenet_tcp_connect_postgresql_port(syslogd_t)
+ 	corenet_tcp_connect_mysqld_port(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 964906b..dc700f0 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -72,6 +72,7 @@ SRC_URI += " \
         file://0054-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0057-policy-modules-system-logging-allow-syslogd_t-syslog.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"

