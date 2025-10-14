Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA16CCD184
	for <webhook@archiver.kernel.org>; Tue, 14 Oct 2025 18:37:08 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
 by mx.groups.io with SMTP id smtpd.web10.3813.1760467024133196762
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 Oct 2025 11:37:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D97mIFY5;
 spf=pass (domain: gmail.com, ip: 209.85.166.171, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-430a4bf6b6dso971305ab.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760467023; x=1761071823; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDgiU91yC8kPrYg7tihtCA/eGdp6bWW4icgORgl+pus=;
        b=D97mIFY5ku47ko5HdkuM42kai5pUJJTVcU/tfdl7BZUELoELVO37zWTCOjhEYWyQZ4
         oOnuiEs6rG4qKQezJ/slzzvhXYN/2NB27ILGor5nv6OSGXMra7LpUE0otFLzFgdmCEgw
         I3wMDYlCa+pe6j5UdGdgZFvltkE40O11z5awGQK1vYJJhU1H6u/qx/lXLjSuWUGAJ7QO
         XlBtrAzkUdrOu1VItv8OfVck0oeUX6LRc+wYJ6NrWmMKLDGaXNSkVDa5RJUVWBrFOv+b
         OKc7Mmo1c81pgCe3aM9kFSAOSCh6rv+naGWMno92/f0rVPBFCkG0t5WA4Xb3M69PNiE+
         TUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760467023; x=1761071823;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tDgiU91yC8kPrYg7tihtCA/eGdp6bWW4icgORgl+pus=;
        b=lkWeFZMbAMbmlEcr/sdjtFpbw3UplbD38/LFz/MlYQatPWQgE7YWbvZE3+xEg+vCIw
         xB3IlAvEEYwddwXXmbflWqB/tsVJRmYPfgT8K1ZpSEYmBLKh0Zu3mXWpJGX5ac8Lsu3G
         bweYI+QRlu5HiH6vlktopAqYxAUII9ATeylOwc2m8yLoVbLw8hiO/aHWye8mtvWO9/vI
         XRqjLhdtzwiAtWonoR1j7ijbngRNMv4pu7MYSNI9ayVVHwQhLC5wdlhaWe3X1bS3pWPP
         GjFKxEJ+gM8yInPr7kte/tOQ/sdBx+sJOftvRVLLgQd60cZeFWIU/axo3pZX603zbHMK
         tyQw==
X-Forwarded-Encrypted: i=1; AJvYcCWCmiioCxPnCPEFqu5RvPGJc8ARsFZJCpN9HxbjkyD3C5TuUm1aeBR3n9N/SUmU/2DMxQCyCUS+KG5lMWdm@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwZXNs8iOq4fyhnDytP3F+gz3347skNvVqffghhWl0VJ8oNLYOq
	0topgWe6xaqkbu5D0IKtn8XJe2ZNSuPhPjrMyurf+ShIwvGBCShSUlVB
X-Gm-Gg: ASbGncu4kuj8Mz6tKmfFk8s2qoF0B580P2+/wblyp2O7ipL8QTooxV3TtMhjzPhqT8A
	/D92MNdLkzhAp1ClbtCeVE/Wo9d5RdSurnKpUeyjDK7ZZFmuD6GBkGBwbhOx2+CNW8IGYXzmsrW
	3S1GEtK3OHDigoIgd509yAVJTZzPYZdkFrWI1mSnNCliSD39xyAdg079BJjbj5QADcvhVKZzJqF
	LmIBZeiL4SktZ6KU5mrz1fGcDPVvBV3Ld2f3CaLXqfPJvWtj2a8Sdp1ErmH29Kq6sY+4z8CIwsx
	qP6igWydf/Uv0RvMutdqtT/veCbpSCMeu1UM8NbUhf6yqe401eo+px177+MvrZ4eczHt8ukjsLO
	p0tJcKS4LwbYUVDa7hnuI+NOtHxw0wFxmyOdIAGLwsleHascPTGSed2FG4HZYk6Nv/XmFXKe9FI
	oJOOk0aWVz0y4mLJ1VYdcROAMdsT7K+dYQmWbx3nsC
X-Google-Smtp-Source: AGHT+IE41EAbeGkfaoeNJfZ8rmenOGNQpCetBTtNpfm7X4arIQ7jM7RU6Q1aUa6vh6/RPh3qAw9S6Q==
X-Received: by 2002:a05:6e02:164d:b0:42f:a49d:dfbf with SMTP id e9e14a558f8ab-42fa49de15fmr172697175ab.2.1760467023170;
        Tue, 14 Oct 2025 11:37:03 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-59043f842bfsm4606022173.62.2025.10.14.11.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 11:37:02 -0700 (PDT)
Message-ID: <652bbe69-5c77-4546-9aae-7ed5fbb67ea8@gmail.com>
Date: Tue, 14 Oct 2025 12:37:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][walnascar][PATCH] refpolicy: unconfined - allow
 firewalld_t unconfined_t:dbus send_msg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 Oct 2025 18:37:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2304

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-unconfined-allow-firewalld_t-u.patch | 55 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0060-policy-modules-system-unconfined-allow-firewalld_t-u.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-policy-modules-system-unconfined-allow-firewalld_t-u.patch b/recipes-security/refpolicy/refpolicy/0060-policy-modules-system-unconfined-allow-firewalld_t-u.patch
new file mode 100644
index 0000000..b7f9093
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-policy-modules-system-unconfined-allow-firewalld_t-u.patch
@@ -0,0 +1,55 @@
+From 37ef996e862c940ca7662400bea72bb7f5aad7a4 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 26 May 2025 18:35:20 -0600
+Subject: [PATCH] unconfined: allow firewalld_t unconfined_t:dbus send_msg
+
+~# firewall-cmd --state
+ERROR:dbus.proxies:Introspect error on
+:1.3:/org/fedoraproject/FirewallD1: dbus.exceptions.DBusException:
+org.freedesktop.DBus.Error.NoReply: Did not receive a reply. Possible
+causes include: the remote application did not send a reply, the
+message bus security policy blocked the reply, the reply timeout
+expired, or the network connection was broken.
+
+--
+
+type=USER_AVC pid=178 uid=messagebus auid=unset ses=unset
+subj=system_u:system_r:system_dbusd_t:s0
+msg='avc:  denied  { send_msg } for msgtype=method_return dest=:1.8
+spid=228 tpid=525 scontext=system_u:system_r:firewalld_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
+tclass=dbus exe=/usr/bin/dbus-daemon sauid=messagebus hostname=? addr=?
+terminal=?'
+
+--
+
+Fedora:
+
+$ sesearch -A --source firewalld_t --target unconfined_t --class dbus
+allow nsswitch_domain dbusd_unconfined:dbus send_msg;
+allow system_bus_type dbusd_unconfined:dbus send_msg;
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/182ec344461e8e7f0c8cf9002688bffd35ae80f5]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/unconfined.te | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/policy/modules/system/unconfined.te b/policy/modules/system/unconfined.te
+index a2f898551..b2db9f3ee 100644
+--- a/policy/modules/system/unconfined.te
++++ b/policy/modules/system/unconfined.te
+@@ -108,6 +108,10 @@ optional_policy(`
+ 	dpkg_run(unconfined_t, unconfined_r)
+ ')
+ 
++optional_policy(`
++	firewalld_dbus_chat(unconfined_t)
++')
++
+ optional_policy(`
+ 	firstboot_run(unconfined_t, unconfined_r)
+ ')
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 32234b0..bc277a9 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -75,6 +75,7 @@ SRC_URI += " \
         file://0057-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0058-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         file://0059-policy-modules-system-systemd-allow-systemd_generato.patch \
+        file://0060-policy-modules-system-unconfined-allow-firewalld_t-u.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

