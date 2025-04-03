Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02811C3601A
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 03:54:38 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web11.5445.1743652477587868339
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 02 Apr 2025 20:54:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AnYGn3ZP;
 spf=pass (domain: gmail.com, ip: 209.85.166.169, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d5ebc2459fso4114815ab.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 02 Apr 2025 20:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743652477; x=1744257277; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrpQ2vtU3Nqj/BpRBNMURVgOC1ZziCAYyL9DfECUK6A=;
        b=AnYGn3ZPvNfZGLKFYJ4dR/mp67n0pH3aGSdkoP8pIEF948Obtky83gLWOLKJuJy36D
         nZakkzgN5+lWdDZN61UlOFYS7/l0p/03i+ZLM0qmecr2c5+39vCKmYrXYO0WOmYXnj3T
         VBxQz+Hb1NtTtqlTkEdQ0TCD4SfPAgpKmCR9N+QfJjNQrcPusyWM84vlda2h86bxYQ49
         Zv8YmOHxJwNrAlof/7DOg0LpD1OSILzOw+LFV29WTAqONuy57K+A7hl/UnQfUEhOl82p
         Uw2gsPpnvT2WJocslukJk3WEk1eybC8ElDu4oVmFUiK3K6XIXG4dmnysRRIxMBwJU8Te
         6MAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743652477; x=1744257277;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IrpQ2vtU3Nqj/BpRBNMURVgOC1ZziCAYyL9DfECUK6A=;
        b=VN+2t/LZExL+PH2wpOzIfoqr2TGoU3shMvZBLzZ+YHdkf9RE3xPBb9+0L1c6oWyUn3
         AFz0VIJgUpZCKRc91uF3smPJMFGO0xaX2kKd6Lsa/wEFxax3X0IjMiRnGMcKphZ0UDKO
         jrGoS9QNcPrHxH4OAZmNP7oHKwjTwt4H7LSDEp4Uz5K4gpOIVZZ3y8s1nBtjNN0nc0aE
         VRD9UMHDNPh/AgAGomTpRGCMYue3Xwft3m3E66tk64ii8H6iMJljn93jDjP8FKUctDPl
         /EEM+uukJZQ4HpSuN3MdSD05J8LbxqOEq3+9b2nOCcp2tujzAcmH0iQYcxysnUA76/Nh
         KV1A==
X-Forwarded-Encrypted: i=1; AJvYcCXDcLcDftgRjs6C9okBxnnaSVcBfOQGFmPPyJ+Bp9HYlDbfYzdazL567yCOym6r44Nk+A3i1yoyjMYHT8rY@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxGmc7hTO47gN9xhpfRWT+kxLnQJBwwY4cycw5x6K6HiGqIUZjG
	8ZEuYIQr1aDeRg77T5WfC2muKKHps9ORZWykyqqNXiyZYA7qeG4X
X-Gm-Gg: ASbGnctI271lTzIoyu1JNWHkztgiEpEPBsBkuZ6YsPZXDmzT7inLcfCLxY6hPA2ZouL
	kgPPRw/Jz5IKLX0shAKSpujegzpE8v+4TDCf7xJ6Q18oaoqkVfIldNO5S2DuOKM/OjdJ2+kNfsq
	8yA+LXJYj5GzfLciRvRy+P0n30I2d1wG7iMD2bC0k6TfxVCPvHjzUrVBqk7kn81/lsv/NPHEyzq
	fS/WoYBK44aj1wD5pQSm3x9OWcaPsCruPnZIX7PtMcIs6DZUTJi4T+u4xLWUflx1ggPTwPjqAN2
	fo81u5/kk73t0TvIcAgcxmbMxz4HP18+Oo8IIKORdfVJ5IMP17cYaen8Dz8aHNMVeLX4/2oGORQ
	R8C6e2FAfOaTGfWBakGF/+Q==
X-Google-Smtp-Source: AGHT+IF6aBZgqerPqNIqa1D8iUyc6Ii+HaamL4uPNmz1T292eHUhnHcUK610+1nTSsJDwsRK3XUw6A==
X-Received: by 2002:a05:6e02:250e:b0:3d6:cc9e:6686 with SMTP id e9e14a558f8ab-3d6dd80a6c4mr15262725ab.17.1743652476755;
        Wed, 02 Apr 2025 20:54:36 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d6de79f156sm1076875ab.15.2025.04.02.20.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 20:54:36 -0700 (PDT)
Message-ID: <0f977f66-e6a1-4d6f-a45d-3c90f49f06eb@gmail.com>
Date: Wed, 2 Apr 2025 21:54:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][styhead][PATCH] refpolicy: chronyd - fix
 dac_read_search denials
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Apr 2025 03:54:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1277

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-chronyd-allow_dac_read_searc.patch | 58 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-allow_dac_read_searc.patch

diff --git a/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-allow_dac_read_searc.patch b/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-allow_dac_read_searc.patch
new file mode 100644
index 0000000..2d4849f
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-allow_dac_read_searc.patch
@@ -0,0 +1,58 @@
+From 1f96ee01c7325f30aa4fcf833f4c63338e214dc1 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Thu, 27 Feb 2025 15:53:30 -0700
+Subject: [PATCH] chronyd: fix dac_read_search denials
+
+avc:  denied  { dac_read_search }
+comm=chronyd
+capability=dac_read_search
+scontext=system_u:system_r:chronyd_t:s0
+tcontext=system_u:system_r:chronyd_t:s0
+tclass=capability
+
+--
+
+Fedora
+
+chronyd_t
+https://github.com/fedora-selinux/selinux-policy/blob/281599ec3a5f0cc0d423b98bb76c71c1a5d76870/policy/modules/contrib/chronyd.te#L55
+
+chronyc_t
+https://github.com/fedora-selinux/selinux-policy/blob/281599ec3a5f0cc0d423b98bb76c71c1a5d76870/policy/modules/contrib/chronyd.te#L257
+
+--
+
+Reference:
+https://danwalsh.livejournal.com/77140.html
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/231960371da6ed49fdde1891dee3cf607791c76f]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/chronyd.te | 4 ++--
+ 1 file changed, 2 insertions(+), 2 deletions(-)
+
+diff --git a/policy/modules/services/chronyd.te b/policy/modules/services/chronyd.te
+index 9e6ba5bf1..3d4007a57 100644
+--- a/policy/modules/services/chronyd.te
++++ b/policy/modules/services/chronyd.te
+@@ -54,7 +54,7 @@ logging_log_file(chronyd_var_log_t)
+ # chronyd local policy
+ #
+ 
+-allow chronyd_t self:capability { chown dac_override ipc_lock setgid setuid sys_resource sys_time };
++allow chronyd_t self:capability { chown dac_override dac_read_search ipc_lock setgid setuid sys_resource sys_time };
+ allow chronyd_t self:process { getcap setcap setrlimit signal };
+ allow chronyd_t self:shm create_shm_perms;
+ allow chronyd_t self:fifo_file rw_fifo_file_perms;
+@@ -134,7 +134,7 @@ optional_policy(`
+ # chronyc local policy
+ #
+ 
+-allow chronyc_t self:capability { dac_override };
++allow chronyc_t self:capability { dac_override dac_read_search };
+ allow chronyc_t self:process { signal };
+ allow chronyc_t self:udp_socket create_socket_perms;
+ allow chronyc_t self:netlink_route_socket create_netlink_socket_perms;
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 0c3966d..cd04ef5 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -73,6 +73,7 @@ SRC_URI += " \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch \
+        file://0058-policy-modules-services-chronyd-allow_dac_read_searc.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

