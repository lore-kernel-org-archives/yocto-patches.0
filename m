Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30993CCD1AB
	for <webhook@archiver.kernel.org>; Thu, 23 Oct 2025 03:40:19 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web10.12064.1761190818633802945
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Oct 2025 20:40:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jk9zXy4g;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c2917b92bcso312559a34.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 20:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761190818; x=1761795618; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7vFqKg++aU8ciY8PZwXuQDoWCZbLq9b/fiU5sg1Ah0=;
        b=jk9zXy4gPYufI+14c/WJBDXe6HeGt7IhgyNbe9Oje0cXo7dmtqYXA4Yr48E4QSj0hG
         N74zzS1PaSu2cO4N7ae3kLEuU9DkI9GNp0PoiCuT/u5VZszZdKy4VBhxYDhuMI/gZZiV
         bSwygK0T4J70uKFDBxL/afQ2MzilRC4/2ecG38eeJnwjjupXBGpth6c5DOSa12R9UKvO
         vIxkuvNAx3zoNXHlo+nG9dKxsI6+FiH3sP57NZGGOY8e73D53EqB9lV7NnMKltOVcfiA
         +i8q7fH+zYTewk7b2q1YimqTIzkud97Lp9EvfIB+d3f8p1yDSNQz+wPETE8gO+lnRunV
         wkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761190818; x=1761795618;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7vFqKg++aU8ciY8PZwXuQDoWCZbLq9b/fiU5sg1Ah0=;
        b=NSOi33c3/0PQZXgLTYz/FJ7ZOm1y+p2NXX05lP4cDrsVqK0u37kPcA8it3/1euKMwQ
         DINpcXNho9jVaUhTI3G2kPwpZ5XDQmN7GVDm0thoAktzt+Ved/AiZGm2oM8pWV3uU3J/
         /nHq/UD4RpucE8zjLhi+l/kJLzMH367/JiYgRuOyFZXyaveozriktF+43xhyPoH6NZ+t
         otvV6g0fYTt1vvLuqM2j0iGU8PkGQWJaLKck5O/yJglaUZZqjrrPLqWwFw9OXdvp5zqG
         rzKiq8zi5/TfmzLRIfWvQGl5VTlQHz51yRBFmxY6kjlLtOBr2PRV0TZHTIvsjE1Wk9AF
         +A3A==
X-Forwarded-Encrypted: i=1; AJvYcCUAvcY7iYwni8pGuOkXTsDPYjVsY0YzDwqPzmPukjA77t0kY3RD4Z+FKTRd9KGuWnS8d6KclLnm1bkeNT6G@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxywwhUIXi6HzYeAtQWFh+uw3fIAtoZNwRyl/LtXU3zoolPmZI0
	8fP7tD38PnucrSmlvwQeA9Gq1H901qy0v0y3OVmRvNzxSU85nIKe5oNo
X-Gm-Gg: ASbGnctr+HlfAjXrfxcvys1GKup2f/95tVP6vjnl9wIG1gC7WisjlVkccWVpwyk+uxU
	1KTv5pfk+Up1PWpv1shNn25QMWRXpVx3ynRDXfPa0jHWbW70LHKUX53DUlsj9VGOXJ1x5IQbwcZ
	LOdyWLERDv2X5E9v2ICIayh2xgHbTjAWLWb4zLuVuhws0yPZ6j3DgTzFbAG69iJz6hKJg2/xwV1
	+vuRmzzaCMdEHWX8hIVP8WXJ0hXVLVnyQw/3scaPUtH7V7iM3JLeVRVR5X6IinLfkbkErpjyLKW
	DFgXpYSEkMnP9DBADIHuLCGeklGOBcvWaLme5b7E1678pX63PbkIkpqIloo2r0vTm75YsPL2LMd
	4aOUmYjS0koJMVQAQjG40xIG+l5HZ957TZB/tvctkGi+S4pDBhxgvF72A08nv/RSTCzBQVs5zxa
	CFwVs2MOEimNWkYv6vymzBipMwySQ5e1Q8qrNdMKFAU/9jnurWux/0MqnrvjU2LOKJI4I88kKUU
	sk=
X-Google-Smtp-Source: AGHT+IHu7ltkGqObt04sGoXP3K/byX3+osAaU8UN9Vq/nS9blBZ2jiU32uiCNQdXjR8RIvuNrj2bjg==
X-Received: by 2002:a05:6830:6213:b0:745:9fe2:de36 with SMTP id 46e09a7af769-7c3e51f7023mr2392282a34.0.1761190817733;
        Wed, 22 Oct 2025 20:40:17 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c51118aa27sm303415a34.14.2025.10.22.20.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 20:40:17 -0700 (PDT)
Message-ID: <d068e283-3bba-40a1-99ad-9bef42cdd23a@gmail.com>
Date: Wed, 22 Oct 2025 21:40:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: dbus - allow
 system_dbusd_t unconfined_t:fd use
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Oct 2025 03:40:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2384

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-dbus-allow-system_dbusd_t-un.patch | 59 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 60 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0075-policy-modules-services-dbus-allow-system_dbusd_t-un.patch

diff --git a/recipes-security/refpolicy/refpolicy/0075-policy-modules-services-dbus-allow-system_dbusd_t-un.patch b/recipes-security/refpolicy/refpolicy/0075-policy-modules-services-dbus-allow-system_dbusd_t-un.patch
new file mode 100644
index 0000000..4ad0981
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0075-policy-modules-services-dbus-allow-system_dbusd_t-un.patch
@@ -0,0 +1,59 @@
+From b3928a226cc6a197e4a27e11104b3df418db0536 Mon Sep 17 00:00:00 2001
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
+index 672aeddf4..14f1ee35a 100644
+--- a/policy/modules/services/dbus.te
++++ b/policy/modules/services/dbus.te
+@@ -282,6 +282,7 @@ optional_policy(`
+ 
+ optional_policy(`
+ 	unconfined_dbus_send(system_dbusd_t)
++	unconfined_use_fds(system_dbusd_t)
+ ')
+ 
+ optional_policy(`
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 1478721..5da4c48 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -90,6 +90,7 @@ SRC_URI += " \
         file://0072-policy-modules-services-chronyd-allow-chronyd_t-kern.patch \
         file://0073-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch \
         file://0074-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch \
+        file://0075-policy-modules-services-dbus-allow-system_dbusd_t-un.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

