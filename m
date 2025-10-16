Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B787CCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 16:37:48 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web11.2186.1760632659351469253
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 09:37:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mr1P+KxX;
 spf=pass (domain: gmail.com, ip: 209.85.166.169, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-4242bb22132so8016795ab.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760632658; x=1761237458; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il1+i2zXkbP4ykFM4kHfIK3GldHJtY7GwVNQXqItxFk=;
        b=mr1P+KxXnTYwWCUD18QZynwB6goBSCU+qlXdM0aSoH1kqVNbcirJ3t9PVfyBhH7Nl3
         QVodoGdpoxgY0MqQH70VAqQatbM26WsbYN3i2RL/k/nnirPwOjBvJ1XYtWCC3BYcvTgG
         ackH5JVQ3wYWjs96oB6WS7erDhExwe/FI6+O6eBER+TskNY0fZ/Jg4ZwLTc/pMrsjMDN
         6+llLswjupukZaTcMOymf3mW4iZniflMv7xB7Ysv8jkz60nRqkM1mwB8hhUHuw32U4DG
         6RtunvKtxsQRirNeYrB1HCz6r+n2/n63Gc2OGIhejNW4AyiqliBfxgP8KuTxSnFX3GCb
         Dkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632658; x=1761237458;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=il1+i2zXkbP4ykFM4kHfIK3GldHJtY7GwVNQXqItxFk=;
        b=a8zyw7uA6albvLNCmDXCnMlowTxO4kgEKqpGDWtBfa353vCcU0fjZKbyxMv0uuz9y2
         U5xDVdYw1v9+DKhdXPDcN1WH8tqrKlOQxUKU1L8itC3jITDV09LxFwocNmi2AjRbVsRt
         DpDDuBIODwZMHeH/73mkfaI1WB5bs3dIw2VkMloxsQvMNxl42vNc1X37y2C/ZKrsEW6c
         qoD8ri3t35+5OW0PQXhRMUniGiTrsdJFmYpLZ+gLXtjjfsrr2sTnxBKOLmuRK3d4DNRi
         KJISRv6Id+3fJHwZ38G8lqeAbeF4JoA03lmGI0owqnFTTZ/lLjek3Oy+CK9mzwGJsoqo
         ZiAw==
X-Forwarded-Encrypted: i=1; AJvYcCU2QKRPe8tylApCKFDtDqmPOGPM/WcA5oOsGrR51CxetchLBuMFoMSpG/ZZqNlEkLcCfZenMZJ4+5qwTXBq@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YykmI+0YYBvBxYr+e5WOWafZewnwFfHyp0FARzwB8bgdP/FUSAY
	wloyM7iwHTPMzQUWIYYE3+Hfet9ucuvHfBuLAiwvEladmIUmFxMSvzO2
X-Gm-Gg: ASbGnctds1G24xJoPoGt8LErV5glypE52vZouTYGdKViQRRxn6O3L2d1VKcgn3M0J1i
	6rp+Appt4JzGEY4+UNf/pKbmGjcnZp98lqmVhHKOmLwnUjSGe1cf7GAW/Q/BC0WRl3wE+fuX/Hw
	f4arBPgrieP2wvY0xNU5cr4Qylfe2sfQY2q0YagEuAofz88ZpFvxZjH0AUDAO8d7nzDiud/4bdR
	TS6AY3OpsyODiT/TjaxJ2TpkFhTh6vJEMZycX0lqM9mkvHt1I+S1TD/uKG9frU81eMBCvUGisIM
	LC5InRRFpeyLDxmCASSkrpbnSa5Qfgf0ShvjzFRIDGLFqSM+sUur4yBMv9d2HsnytUbB4SQrgHj
	j/it4yQCE9gpKeNz5rf8DAA/T0fqbyMQ7UGgD4lcX87AbojT1uw40HuPfpDagylRWq4S6rOmWpz
	KFVzH1Ag9K9xBEDTIzGqGi25yQHXb85DzFrKAMESk5xZo2H7aDcCiNrg==
X-Google-Smtp-Source: AGHT+IETI6NVu9RqrZ7DfTz/YLVFqIQyg1kHhUcbP8P11ABT3xI5RCaHMbb1QpJVtjl6hVEpJX0seA==
X-Received: by 2002:a05:6e02:441a:20b0:430:c602:5fde with SMTP id e9e14a558f8ab-430c6026011mr8803585ab.32.1760632658503;
        Thu, 16 Oct 2025 09:37:38 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f729d2d4csm6906517173.59.2025.10.16.09.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 09:37:38 -0700 (PDT)
Message-ID: <5a6d780a-99da-48dc-a9a4-6b2c1a5cd9d5@gmail.com>
Date: Thu, 16 Oct 2025 10:37:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: chronyd - allow chronyd_t
 kernel_t:system module_request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 16:37:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2324

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-chronyd-allow-chronyd_t-kern.patch | 53 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0061-policy-modules-services-chronyd-allow-chronyd_t-kern.patch

diff --git a/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-chronyd-allow-chronyd_t-kern.patch b/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-chronyd-allow-chronyd_t-kern.patch
new file mode 100644
index 0000000..1464b31
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0061-policy-modules-services-chronyd-allow-chronyd_t-kern.patch
@@ -0,0 +1,53 @@
+From a0493c5d152bb03a9b8bb15823fbc3116f856e1a Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Tue, 10 Jun 2025 21:30:13 -0600
+Subject: [PATCH] chronyd: allow chronyd_t kernel_t:system module_request
+
+type=PROCTITLE proctitle=/usr/sbin/chronyd
+
+type=SYSCALL arch=armeb syscall=socket per=PER_LINUX success=no
+exit=EAFNOSUPPORT(Address family not supported by protocol) a0=inet6
+a1=SOCK_DGRAM a2=ip a3=0x80800 items=0 ppid=1 pid=1308 auid=unset
+uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
+fsgid=root tty=(none) ses=unset comm=chronyd exe=/usr/sbin/chronyd
+subj=system_u:system_r:chronyd_t:s0 key=(null)
+
+type=AVC avc:  denied  { module_request } for  pid=1308 comm=chronyd
+kmod="net-pf-10" scontext=system_u:system_r:chronyd_t:s0
+tcontext=system_u:system_r:kernel_t:s0 tclass=system
+
+--
+
+Issue background: https://access.redhat.com/solutions/6768131
+
+--
+
+Fedora:
+
+https://github.com/fedora-selinux/selinux-policy/commit/d5acb7734d02012c54bee0064155c477b96f0bdd
+
+$ sesearch -A --source chronyd_t --target kernel_t --class system --perm module_request
+allow chronyd_t kernel_t:system module_request;
+allow domain kernel_t:system module_request; [ domain_kernel_load_modules ]:True
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/2836207462b68c54cf21ad21f7f6befffbb1aef0]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/chronyd.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/services/chronyd.te b/policy/modules/services/chronyd.te
+index 3d4007a57..0cac72e13 100644
+--- a/policy/modules/services/chronyd.te
++++ b/policy/modules/services/chronyd.te
+@@ -83,6 +83,7 @@ files_runtime_filetrans(chronyd_t, chronyd_runtime_t, { dir file sock_file })
+ 
+ kernel_read_system_state(chronyd_t)
+ kernel_read_network_state(chronyd_t)
++kernel_request_load_module(chronyd_t)
+ 
+ corenet_all_recvfrom_netlabel(chronyd_t)
+ corenet_udp_sendrecv_generic_if(chronyd_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index bc277a9..7bcb03b 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -76,6 +76,7 @@ SRC_URI += " \
         file://0058-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         file://0059-policy-modules-system-systemd-allow-systemd_generato.patch \
         file://0060-policy-modules-system-unconfined-allow-firewalld_t-u.patch \
+        file://0061-policy-modules-services-chronyd-allow-chronyd_t-kern.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

