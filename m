Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C67C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 04:10:47 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web10.7162.1741839042965659934
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 21:10:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e/gFBMSK;
 spf=pass (domain: gmail.com, ip: 209.85.166.42, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85b43b60b6bso21874639f.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 21:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741839042; x=1742443842; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIAGZfFByHhcoq0G7d58ucFCzh+ANxKxoRqRUOilAIU=;
        b=e/gFBMSKq9A4RI/fw+LXXhgauLPJfiscsGyGjSqzlti57IiF/2YC9k1qhJu7p+FmZV
         brgjfYVyQLgCEE0MCz0n8c/CxchCv1q7r497rYSF2yNYA1Ol4oTJpNvfgp6Mk51PJB2A
         cn4r9irCQtofPtjCwpvP12YmI+gz66dr55sPyFNon4z5zGebkA/aGk2ki9reCQSqyZ2i
         UE1vQHh4MNYwyWLSOUlArctJ2TvjK+q2Ha3Kmp9kjkWcrviu5vG9pAfJt1i6a04ieMhN
         PJyKaEMfg8RU1NVQ2T8JioN61AtWHIpIeguVgEXhWlgEtOzQEqOsyu5XJJaOgsal+cmM
         a6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741839042; x=1742443842;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uIAGZfFByHhcoq0G7d58ucFCzh+ANxKxoRqRUOilAIU=;
        b=OJCW2sKilfYzWvxvfn0kvx5jXNEpC8zVuxfCNyW/QP4oZPYrQSQpyu0iy3GzVgiRVK
         AnNhyEx3um0hvcTa5QRp7VfjUhJnWah+s7Te4g0Vu6+xIPcVXJpVR0CpFXID8qvuUYob
         6MjGkR55k0BsEv+GzebGpjcIlLaSUUW2Gos5vRoIeZCezGOwraWpuFm7emT7j7Kg8lfQ
         26TI5hdRydyreDCmW62XC+k9UbU45qEYYrt1KAyvFfozDroo92J6ivB3ACt/p/AzXHvu
         iJuv3ducECMwuBBVnVttbXspfebEDvMZk+H9aN9XC5V6Kmjhf30ZJFtKBziAgOaaBEHa
         jTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL1aC+itcN4NSEV49iqe5D75G6KNpveMXDfPXOPnZv0JIAkEyPRd3qVq10V0aLuPERd2ppquCb0qYxWN4h@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwR/Z4JqjmXFGt9cVe5SiLcqbN46SLyX78Ysq05GNERbWj+KIWD
	poDu7CXBk6jN5f6NCQu+PtqKFlil+uOuUDw4BJAU1U6Ojg7IgsWJ
X-Gm-Gg: ASbGncuV6xG1ySGM+DETMtalrKdP5sl42HcH9RIshiCOtpIFumzHlh2I2y2ZXHxRUsZ
	xkslHQ8iX4EurIEcuGzVn9BFPSJkADumvxdat5qMsAnVxBQ6k6VYZ/z/o39m4iH6zRblej4oDHI
	ui8ycIvOlp3JffpuRGUOJ6BwwZMKOk1GXHaJkqLAEe13xnfyO2rBvrHAOCe5qzx7vjyuP4OTrOT
	SLRGi5o85baGfmgItGELQ9KmWXS+e+MDsV0jGzufCC/Cor6ER9GpgWMnJOBw9+zjvN1hIODLOZ4
	9XuLVNH1Gf2WQzKfxj1/Cr3zoRCryG9vDBGR6lMClSbTQPBAUZz8mqp9L/aUuF72xvFBzJyElpN
	/rOA+1253zNVU1fwcV0LnRw==
X-Google-Smtp-Source: AGHT+IH34A5WG0Znx0twOEXbAiTRsV3c4n54OMtCVpDBl75JQiW3emjkGVQrAJOxU4Tz4o2FVW1LCw==
X-Received: by 2002:a6b:dc08:0:b0:858:7b72:ec89 with SMTP id ca18e2360f4ac-85db85f8991mr93085639f.5.1741839042039;
        Wed, 12 Mar 2025 21:10:42 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637faa42sm131612173.81.2025.03.12.21.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 21:10:41 -0700 (PDT)
Message-ID: <4a60bdcb-450c-460e-828d-ade3b6790921@gmail.com>
Date: Wed, 12 Mar 2025 22:10:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][PATCH] refpolicy: fix chronyd dac_read_search denials
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Mar 2025 04:10:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1198

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-chronyd-fix-dac_read_search-.patch | 58 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-fix-dac_read_search-.patch

diff --git a/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-fix-dac_read_search-.patch b/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-fix-dac_read_search-.patch
new file mode 100644
index 0000000..7d1743c
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0058-policy-modules-services-chronyd-fix-dac_read_search-.patch
@@ -0,0 +1,58 @@
+From f892f5e254e26418213556f00badaf69d14ec16f Mon Sep 17 00:00:00 2001
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
index 0661e6c..fca7034 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -73,6 +73,7 @@ SRC_URI += " \
         file://0055-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0056-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0058-policy-modules-services-chronyd-fix-dac_read_search-.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

