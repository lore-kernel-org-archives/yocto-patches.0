Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670BDCCD183
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 16:26:08 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web10.1911.1760631965643683045
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 09:26:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=P3/5AO2N;
 spf=pass (domain: gmail.com, ip: 209.85.166.42, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-91122373653so45898639f.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760631965; x=1761236765; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBcpuChLdPKnBG8B8LMPcxc2siUvlbqfxqgr1WqzQF8=;
        b=P3/5AO2NJ5iyZ4RLFqQv3FzeeWgaZBB/rMn5rTDWDI55ZBfiySkH4Mg75NdeRdy03N
         PAOCnbNW4wYSvTmcvK3gykhWcPJ/Fx7CcXrIHBBBOlnhZyfOiPLwU6fe726+GEPoh6my
         Dq4kPHIFTmb5oR5CdR4e608RqyA5J0iTTazt5LTwUBwmrTwHBcKWBomBI5LS4RnuzrDw
         kf6H8H8mtXoTLxfAjgl16fWMU4Fv+wTDtvHvq5EBmyRH93eweFGbcp/H/OdB1lhoPlX5
         ftdul1AUTq0FRhFewzHBBO3h84ILBdAI6AVFFi7wBOTtae+F2c3x/Le36uk4AoiG5RNG
         0yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631965; x=1761236765;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBcpuChLdPKnBG8B8LMPcxc2siUvlbqfxqgr1WqzQF8=;
        b=upYySepum0IqeFaiy/OlssukDcqhCNk3Sf/xRbE8QVLFJ6WUabQX9ZxYRMzUw0INUU
         g6Rym2zudFTTtGkoe+DNRbDCWIo4JkdMAqvzVvTWafP0kI1d81ez/1xdrf00f//UpgDt
         FIzm7crSdyy4dY9ctQWhEsmhkbfl0YwCpBrnXYopZTE5DPjasmJkfkzAVNKOaqirEfJe
         s96fJ5T8f+JrhwLfZBiNrMZsUch3JnjZ9NQtTTmffJV9NLG9J9R/wePXhqHVUWeP6WpT
         kKQ+Qt+sRz6/7QaS8zRpRzZckD3r+9U3DqyBBP+CEiVPcwza5FXG7yAESOrPAYRO2CZU
         YJJg==
X-Forwarded-Encrypted: i=1; AJvYcCWBxvqAK0ZHeoI0fT0a8q71azCXXIkVOfJQKKZKgbAkYyho9j2jpbqSl1Vd3s1VTzyAhFLngl3ofxGdJqZH@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwJogRwrmIkydh79kVSBM/kY1F1ElOFDQil0GFUI359wCzQUyGF
	7tUc/FF4Jw3lZb+/K2SvBFT+oh+WsjwTndPAamiLYu0Zm1Get0/w8xVa/3Cf3Q==
X-Gm-Gg: ASbGncvfA1sLuz7HfF3kamoETY1Nf5hHP1DSnkeG9EyCRnpgeDQsOUgl3O3HUhSPUlk
	Gs2t62V087/nbd9JnooyngAnjFgbcJV9wEqiJxv8KYEyvPMqYYr5wkcR7ZZGCBXZkbbSxz167Z9
	bmGEmxkLhEA4LksRL8UpdGGcXys1IQEw1fdLpP35rHdF6CGpxaSQi5myn9mSMJk4SyAraw//cAT
	rtziPCI3x09zpP+wFtAmYmNDvCiwhMQYO6EE6d0Sq6da2N9zfO5RaZrBtxg6tpGSbW/zVL71+/K
	aLORal/1Ludt2gNwmadRGg5tqoGScdF3snIIMwztitxL7kiKioG542J1t8Xd+ACdr+FWY59lrBo
	m5S9pd2+/rmjjfXpA++pqphAxRPWXEjdWzg4sB2KMZDNdF3iO0d5wdWxPPdHCY2VWQ4apN5aWCU
	6Gb7g3KhjDvfw7S6ClF4+IlrSGC+mGeGsapx/0AlmZ7Cl8ff1MKCBfHA==
X-Google-Smtp-Source: AGHT+IHBq+NeJP9irxJlplVyNt4gHgFJSjI/pVdI8ptxxprJZbslQkEcdavpvMCK1gZWOSrw0MX0nQ==
X-Received: by 2002:a05:6e02:b43:b0:42e:72ee:4164 with SMTP id e9e14a558f8ab-430c528d9b2mr11600035ab.23.1760631964467;
        Thu, 16 Oct 2025 09:26:04 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430b50b6945sm12600465ab.7.2025.10.16.09.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 09:26:03 -0700 (PDT)
Message-ID: <e610b1f7-9f33-4ec6-9021-5cd0322df158@gmail.com>
Date: Thu, 16 Oct 2025 10:26:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: unconfined - allow
 firewalld_t unconfined_t:dbus send_msg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 16:26:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2323

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-unconfined-allow-firewalld_t-u.patch | 55 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0071-policy-modules-system-unconfined-allow-firewalld_t-u.patch

diff --git a/recipes-security/refpolicy/refpolicy/0071-policy-modules-system-unconfined-allow-firewalld_t-u.patch b/recipes-security/refpolicy/refpolicy/0071-policy-modules-system-unconfined-allow-firewalld_t-u.patch
new file mode 100644
index 0000000..2636f42
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0071-policy-modules-system-unconfined-allow-firewalld_t-u.patch
@@ -0,0 +1,55 @@
+From a0b77eed40994a02d577062025a0834fa4097a3b Mon Sep 17 00:00:00 2001
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
index 71ebeea..fd3073c 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -86,6 +86,7 @@ SRC_URI += " \
         file://0068-fix-building-when-dbus-module-is-not-enabled.patch \
         file://0069-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         file://0070-policy-modules-system-systemd-allow-systemd_generato.patch \
+        file://0071-policy-modules-system-unconfined-allow-firewalld_t-u.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

