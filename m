Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF47CCD18D
	for <webhook@archiver.kernel.org>; Mon, 13 Oct 2025 15:28:10 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.46863.1760369280193663570
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 13 Oct 2025 08:28:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hsejw3SD;
 spf=pass (domain: gmail.com, ip: 209.85.166.42, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-93bd394fab0so106916139f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760369279; x=1760974079; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNnrZB1sf+BPeerrQDONaaFOuX1wVBsoZwladMp3aDE=;
        b=Hsejw3SDGYVyFH2Wn4xqjxsbYHUHr6Y6Y1lhNxqm4jV6uaGYg9JKHRliK4qJ3mkcVR
         ivasUYAZAxTw/kfmnX2BmJRmHyEJKMV9tq/3RkJwTbmuH5fe/ElehRHC3OdNhkuAeoRN
         gljxAEIQ4+03w0w4NIuO0ndp3zlh8iPGcVkXRdCNBhbdCnfa5COfeVNiYwm3Js2cWEDi
         a0djA/i+Kb+2zh9KQnzzLDXyTuj6DpSCb37SRtEj/QCxnhYK3nbTaRvtcjo1q4cAq47g
         E/rs5XpzYUzgvX34mJfPj39ZNpicLW/FeR/zJ5yMISZsG6WlNZJo/OrBFwVf9mKVKR5h
         igjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369279; x=1760974079;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YNnrZB1sf+BPeerrQDONaaFOuX1wVBsoZwladMp3aDE=;
        b=MXuoXaxLl965TSXpxI9CDXk7n6bwgu6eoJ3Drdxk9MUZ47WtYKx4SEhgNtyuidGB3u
         n+juy30p/vGacevuf6oeOgdWK/TNeZWX90XbCyD35+vuf8H5D2O+O91++YmkkpOkcC+X
         qOTUMvpSkcJwWYIgTMUhvIYqAfNZpL571fbS9ABdQmmFJ4FWNnwggCd/aSPnUmE/CMIe
         yyYFf2HLWX7P+2gozIy8paPVV+xQs/0yq7jAF6JHgL1ildfONZCheNuWDYOD/lCoS6MX
         tFEVmMwgZ0qRAAAcoTpbX9Ri7zTDk8yE5shK1Sst150oH6T8rIYRnV2t8nzTJf7fQov1
         +7vw==
X-Forwarded-Encrypted: i=1; AJvYcCUfVG9GD2CfnA+DvFhRmN1XNsovDodTcTg9WLWrOvHKh/CxsO8+aNoUochv3O5WZP99KONDcqhaoSxfshgx@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yy3LG1WzKYN7rQlPoT6pYuply215dkUKCvCN1UprJzEoqrsc5sz
	kMvrwGaU+nglr1YULm5j+eNzktAn6ikqAGdIacuARQsIpxW11mGsRp9h
X-Gm-Gg: ASbGncsC9gubv+mypHeyIta9hwA9MSnyTHfpNnZmrNyXJNAi2D5LVQ823eqtpZgU1zJ
	Yfb94/4fYGPtpQqdaZrwGqRMRTnUF1jCqkNXOXxxRx1HoXNHT8ZSuz6OpnjhxUNDbaHzmgsqbxL
	N9AhcD+jJZ6Cs/hDP23+bizrLQgAheldDyAQRLWhQkQWaV/L/ek2weq30ziwyc0QUSY0a4HvyAY
	HWOmpzHw7FajMphl0rOo9LDCCKH1tWllKnf8iv5JD6v/LpmApJKJU0S2zQ+PbbJmEAbKO/IOy2r
	dp8BRymgojU5HtapzxjJkTt/7Sa0QBDXMVR3/f9+BqVRUno7Jhc7SzKEl1lE2HnlpgUxczV3hru
	Kssfl7aupqiEcNO6tNFgWDmGU1dnvs2dxx3wd/WBnTsHYG+hjmImePuwKhP1b/v0buT9QssI+l3
	IzWR7qkbgWpWNiNpRe+wY=
X-Google-Smtp-Source: AGHT+IEP0SJhr+ZYE4LITvP5+hWAacsqtqy+/w3c1m66kuZ3RL83cU/TQ9OIXpOWoum7+5uutp4AEA==
X-Received: by 2002:a05:6602:29d4:b0:93b:a3c3:1b09 with SMTP id ca18e2360f4ac-93bd17928e4mr2769771439f.6.1760369279251;
        Mon, 13 Oct 2025 08:27:59 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e2594a907sm377954939f.8.2025.10.13.08.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 08:27:58 -0700 (PDT)
Message-ID: <89c5902b-7202-4081-98a9-8f2a56b8bcc1@gmail.com>
Date: Mon, 13 Oct 2025 09:27:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: oddjob - allow
 oddjob_mkhomedir_t user_terminals
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 13 Oct 2025 15:28:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2296

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-oddjob-allow-oddjob_mkhomedi.patch | 54 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0069-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch

diff --git a/recipes-security/refpolicy/refpolicy/0069-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch b/recipes-security/refpolicy/refpolicy/0069-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch
new file mode 100644
index 0000000..4f74ea8
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0069-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch
@@ -0,0 +1,54 @@
+From d382b824f4976935ccd81ef68d547cb30289a068 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Wed, 16 Apr 2025 16:45:56 -0600
+Subject: [PATCH] oddjob: allow oddjob_mkhomedir_t user_terminals
+
+type=EXECVE argc=3 a0=mkhomedir_helper a1=user123 a2=0077
+
+type=SYSCALL arch=armeb syscall=execve per=PER_LINUX success=yes exit=0
+a0=0x5685f8 a1=0x577518 a2=0x572f10 a3=0x0 items=0 ppid=427 pid=1367
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=ttyAMA0 ses=unset comm=mkhomedir_helpe
+exe=/usr/sbin/mkhomedir_helper
+subj=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+key=(null)
+
+type=AVC avc:  denied  { append } for  pid=1367 comm=mkhomedir_helpe
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+
+type=AVC avc:  denied  { read write } for  pid=1367 comm=mkhomedir_helpe
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+tcontext=unconfined_u:object_r:user_tty_device_t:s0 tclass=chr_file
+
+--
+
+https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20250213/policy/modules/system/userdomain.if#L4340
+https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20250213/policy/support/obj_perm_sets.spt#L272
+
+--
+
+Fedora:
+https://github.com/fedora-selinux/selinux-policy/commit/c03dfdc29340d93008b9ff2edc6d6b55b1f2d2a0
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/e9a7c96ba0bca21d455bcc80cbe96caaebf32a33]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/oddjob.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/services/oddjob.te b/policy/modules/services/oddjob.te
+index 299077739..814d48460 100644
+--- a/policy/modules/services/oddjob.te
++++ b/policy/modules/services/oddjob.te
+@@ -100,4 +100,5 @@ userdom_home_filetrans_user_home_dir(oddjob_mkhomedir_t)
+ userdom_manage_user_home_content_dirs(oddjob_mkhomedir_t)
+ userdom_manage_user_home_content_files(oddjob_mkhomedir_t)
+ userdom_manage_user_home_dirs(oddjob_mkhomedir_t)
++userdom_use_inherited_user_terminals(oddjob_mkhomedir_t)
+ userdom_user_home_dir_filetrans_user_home_content(oddjob_mkhomedir_t, notdevfile_class_set)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index d1a6214..e768e22 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -84,6 +84,7 @@ SRC_URI += " \
         file://0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         file://0067-fixdep-dbus.patch \
         file://0068-fix-building-when-dbus-module-is-not-enabled.patch \
+        file://0069-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

