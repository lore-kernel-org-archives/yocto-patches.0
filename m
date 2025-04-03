Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AEEC3600C
	for <webhook@archiver.kernel.org>; Thu,  3 Apr 2025 13:27:11 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
 by mx.groups.io with SMTP id smtpd.web11.13175.1743686827019116324
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Apr 2025 06:27:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lnwbPH2v;
 spf=pass (domain: gmail.com, ip: 209.85.166.176, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d43c972616so2834335ab.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Apr 2025 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743686826; x=1744291626; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9TS7mKlq69KAz2JBGEv+ip0mlLCaywKnTKq7LIC1UM0=;
        b=lnwbPH2vGXEsuAKGN9UTZNSoqK8mMRPRvNtxNKRr1b75R2cw/ZA8O2WpTSeopGf171
         ndRDhgwi6csDB9iEl/OeTFKEoeYkph5/GHXszrPIKbQyncZzjRV+lZ7UN3hTgpwccAE8
         YwLELNhMsij6Z+h3d98htf1xwQbumcMsQK9jN0iDpFyBBco9XRfbTdTrutTexDrfZ02G
         z/emPgls83U2/0yuCyXGBRF6+NHMnOtFt9yHJhpCl6d+JPzrvtlaDEV0g47mu+qjZNFw
         MF5G63cJCfrGWZyhhTbOmheM2+4P+CGeDSRl+EwZjUHG/H0XFv7ihXBK9rX21yp9HxDO
         wYnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743686826; x=1744291626;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9TS7mKlq69KAz2JBGEv+ip0mlLCaywKnTKq7LIC1UM0=;
        b=Key6qsyaiNjES8xZiVcWLYi+dfvmHx4FaP04WlYyPXuuR5gs8aOInEEnrjpqOvG1J+
         trp+tpuE84fwjPh1f/S9U/lKnjsm/CtZWhvXXgMEJ5NxfhNasm+1eCFs8W9YrxU9W+uv
         h8XFoZR1vWS5+G83exPXKP8Nap1Om87DUV5OJbHPUN8gOLcK0/YVHr9+s9X3Bz7chSlv
         brcM4TCQrDugx2pbG0b6gKaqif0CMMTrAESNjekjnf21KcKAlKwhy13uKlKN0YNsuOtR
         dgZT5DodsU6oKbl0irrQUB/v0SoEaDq6511UYzq3Q3C1O+qOUaXDn2Kn5D4YbbDR/DBK
         +Llg==
X-Forwarded-Encrypted: i=1; AJvYcCVIKVeD4UQUswP/hGp6fIF9cDinVDpr6utSlth+GBH0JgJ5GY2UVhw/thRNeW0frIsVW1cPAkD3LNA+6a4v@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzVjoZlWby104NZRbKaGPS9tWhG1ulztn5AShn1LjvdCw8W/4tD
	40xQtcmigADqLZKyELLQEfv+dkqg11/7+uoE0Xj4BEvM0Oo+AKdx
X-Gm-Gg: ASbGncs4KoBixYU4w3WUrkO8PruA2yn84ZmmMI/weOZi0OHalXJ5ALqWId8TCOHEEG+
	eD8ziKbYlNYYjK8JUmxQXJ5y25lleBRrNs/Xc92vFNnHfuRdgFUWkFCHxQT0P/3nYBbjI1vzmoC
	ZahWSq3BsD9QEoVHh6wTAKRknKszw8T+h+NZNrG0Z15UxUTJ3MuBq3dOFsE9HN9FEStmP+IlKis
	GZKHLK5hn3D98calDpFEoj+PCrSRzIWnI2En6gE7kMm/mS9GR0WV5TMcLWGcQJh7CHOODVN1JEQ
	54MTlROvywFlnacXEbhjV3RaDu9X1yQBYDMC9nhn9utHIGkq89zsqHinAttT6I5HdNk9/JdFw56
	9mQHTrujERLlJ55QDx5tfoA==
X-Google-Smtp-Source: AGHT+IHp4881p7jbCiovcdS0Zf35qtfhsP22b6v/GG3j2w/OyFyIs0xtdyZ1BjFdptG7z+1C9Qz60g==
X-Received: by 2002:a05:6e02:6c1:b0:3d4:346e:8d49 with SMTP id e9e14a558f8ab-3d6dcb9864fmr31933355ab.9.1743686826122;
        Thu, 03 Apr 2025 06:27:06 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5c4a566sm296900173.43.2025.04.03.06.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 06:27:05 -0700 (PDT)
Message-ID: <63cb7a33-6f46-4c7f-858c-db4cd0ec184c@gmail.com>
Date: Thu, 3 Apr 2025 07:27:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: chronyd - fix
 dac_read_search denials
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Apr 2025 13:27:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1278

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-chronyd-allow_dac_read_searc.patch | 58 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-allow_dac_read_searc.patch

diff --git a/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-allow_dac_read_searc.patch b/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-allow_dac_read_searc.patch
new file mode 100644
index 0000000..8916aa6
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-allow_dac_read_searc.patch
@@ -0,0 +1,58 @@
+From 385d7ea5347ecadacc97701aca0e859b3be09161 Mon Sep 17 00:00:00 2001
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
index c8a8ac2..9f536bb 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -73,6 +73,7 @@ SRC_URI += " \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0057-policy-modules-system-authlogin-chkpwd_t-dac_read_se.patch \
+        file://0058-policy-modules-services-chronyd-allow_dac_read_searc.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

