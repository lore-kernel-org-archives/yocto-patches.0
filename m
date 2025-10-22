Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE15CCD1AB
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 14:31:56 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
 by mx.groups.io with SMTP id smtpd.web11.11056.1761143510355910383
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Oct 2025 07:31:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Vk4jR479;
 spf=pass (domain: gmail.com, ip: 209.85.166.178, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-430e182727dso13039305ab.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 07:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761143509; x=1761748309; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gUEmRsWiHmaNr5a4QTBTIxXT2+vhhGUETdCiKlp8+8=;
        b=Vk4jR479TrNCUfl/3/zOt5Orb/4yzn2S+UJDxlboZPBq7PHXu+FYFWfiQHnunFIMBz
         V5uIutxYuKtcu5sxSz73DI89GWPbEOv8tParUtz8EGzIeHVPmNg5k1bPE2Nr5o+W3CC1
         BUVb+JJcJWaJWpX+x/DkP1D4wQ8zGaTvlKycDyudhy1zK9UJlYdfzs4JT7easriuiK+a
         M2DgORtj3Gd4LWp1yToOr8lhCxt/YbL/e5TJISQxpIy04wZnYHKLavef/78PSvuQdi/8
         9XuGEDW0YtwWk5hJhiRC/7RIHJ4qhbiwM48bmh94psQYkKWKtT5erGQAyU/FHiPLwoZY
         2qZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761143509; x=1761748309;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7gUEmRsWiHmaNr5a4QTBTIxXT2+vhhGUETdCiKlp8+8=;
        b=pDttK4q1qyUxckTpEtKnTZk+/IDxsHHuqijw2JEiPkzPdp/SjJ6H1iso61TdKTOFBR
         mTV2hFf3eRfY7dYjYOsK6MrhXK/G8vY4OP/37qFMxJsXqiT3RAXisekjQ+jOQJL9w0dQ
         TSHapH+Y+ei+Ydm59gLivShYZezf7nGtkSpRCUdWCyhSej571IDlt6L+42hr9a0YZ8pq
         wosreZGtYvhbGOHMZhkSdkZxAZQUncwVstEXjK8pmWND4rWSZ1S5ZnXVGHAbG1lJ5VWz
         qJSBdf3nFsf616h6+xInBUcdPa4IgOuSok813YXd1IGZ3ACttH8c2XdM0NBYXZSIj3Ro
         OEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXeC3Ofk45bBC8iF+u0GifLGhcUk97eKxF90jN+lQKw6Ekz7JTU5tC4MfTu4GhbhjpAz1nyqN6d4JADmR1@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YwPzdSCxUu1ZuI0KzsscwGdU+AztWOye1uxcVf8PKyrs86qwXkI
	XjFtEL7LltUDbOGwnY9AR6vey4NxltxUpPyNc5sMgX2fpPuCPQZOiSbN
X-Gm-Gg: ASbGncuqSi4b3S1DhlJnG/neozWrkTn1smVh65RBQpS/4q8hASuBC4HZn2DA6FZJuvq
	I4JWUKGDUp+gFz2eztib0BykB0y6QfLYbeHOtHkBXMN1Y8GpxtcCop/Zf3zix1mLHFHqfRUfEvT
	RGuX+3c8yk5SP/UmezZJPxjBI3qWz8h9Nu01nxIur0XsQd/Ja0u2R8TkT8HsCThmdCxKJzVhg49
	nuf2f9x5AekzAbL9qmKYhHNgGuVw6hD0LCvUXkZhngLOGWQq5zSNYhg0llS4Hyh4OrtAMC4g0k6
	U4zoeHMZThtjFAhWSywjoyeWKOxONiZeWmdnLmMyBOeETL9M2DKslTFdSCKr+yUZ/wTT4VaiYtI
	8ofKura3G7W+C7+DZDhUfxHG3zuNn07enlkLqL+fO4+cx3eguWziZ2sdyhgjC0oaJEKbMQJJNGP
	/ytPqeo6cMrSZgQnqnqt5mtJcxXo9Ph4ndzl3sZa9tozOUvrFB5upzGQ==
X-Google-Smtp-Source: AGHT+IGgfvPZaEuDtPDOHivNZdNcT0mF2k/wqSkMthR1tV/50qng5S6XUD26Ug/NDeYzYrQvsXkmrg==
X-Received: by 2002:a05:6e02:440a:20b0:430:c534:e189 with SMTP id e9e14a558f8ab-430c534e1c6mr252423905ab.28.1761143509230;
        Wed, 22 Oct 2025 07:31:49 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9797c36sm4970304173.56.2025.10.22.07.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 07:31:48 -0700 (PDT)
Message-ID: <5f688205-ae84-4a9d-87ec-291846f2c032@gmail.com>
Date: Wed, 22 Oct 2025 08:31:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: ssh - allow sshd_t
 userdomain:key search
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Oct 2025 14:31:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2382

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-ssh-allow-sshd_t-userdomain-.patch | 80 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0074-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch

diff --git a/recipes-security/refpolicy/refpolicy/0074-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch b/recipes-security/refpolicy/refpolicy/0074-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch
new file mode 100644
index 0000000..43434c4
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0074-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch
@@ -0,0 +1,80 @@
+From 965e1c66c8c3bd5087a5f8d276a57974d0378855 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 7 Jul 2025 16:38:49 -0600
+Subject: [PATCH] ssh: allow sshd_t userdomain:key search
+
+~# grep key /etc/pam.d/sshd
+session    optional     pam_keyinit.so force revoke
+
+--
+
+type=PROCTITLE proctitle=sshd: user123 [priv]
+
+type=SYSCALL arch=armeb syscall=keyctl per=PER_LINUX success=no
+exit=ENOKEY(Required key not available) a0=0x8 a1=0xfffffffc
+a2=0xfffffffd a3=0x3e8 items=0 ppid=1 pid=557 auid=unset uid=user123
+gid=user123 euid=root suid=root fsuid=root egid=root sgid=root fsgid=root
+tty=(none) ses=unset comm=sshd exe=/usr/sbin/sshd
+subj=system_u:system_r:sshd_t:s0 key=(null)
+
+type=AVC avc:  denied  { search } for  pid=557 comm=sshd
+scontext=system_u:system_r:sshd_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0 tclass=key
+
+--
+
+Fedora:
+$ sesearch -A --source sshd_t --target unconfined_t --class key --perm search
+allow domain domain:key { link search };
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/c4a2989845ef3fedc4036041ed1fa61c28594842]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/ssh.if      |  1 +
+ policy/modules/system/userdomain.if | 18 ++++++++++++++++++
+ 2 files changed, 19 insertions(+)
+
+diff --git a/policy/modules/services/ssh.if b/policy/modules/services/ssh.if
+index b3394bd92..4935d2e9d 100644
+--- a/policy/modules/services/ssh.if
++++ b/policy/modules/services/ssh.if
+@@ -254,6 +254,7 @@ template(`ssh_server_template', `
+ 
+ 	miscfiles_read_localization($1_t)
+ 
++	userdom_search_all_users_keys($1_t)
+ 	userdom_create_all_users_keys($1_t)
+ 	userdom_dontaudit_relabelfrom_user_ptys($1_t)
+ 	userdom_search_user_home_dirs($1_t)
+diff --git a/policy/modules/system/userdomain.if b/policy/modules/system/userdomain.if
+index ea7a90a5d..3775ee8b5 100644
+--- a/policy/modules/system/userdomain.if
++++ b/policy/modules/system/userdomain.if
+@@ -4915,6 +4915,24 @@ interface(`userdom_sigchld_all_users',`
+ 	allow $1 userdomain:process sigchld;
+ ')
+ 
++########################################
++## <summary>
++##	Search keys for all user domains.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`userdom_search_all_users_keys',`
++	gen_require(`
++		attribute userdomain;
++	')
++
++	allow $1 userdomain:key search;
++')
++
+ ########################################
+ ## <summary>
+ ##	Read keys for all user domains.
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index e730cb3..1478721 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -89,6 +89,7 @@ SRC_URI += " \
         file://0071-policy-modules-system-unconfined-allow-firewalld_t-u.patch \
         file://0072-policy-modules-services-chronyd-allow-chronyd_t-kern.patch \
         file://0073-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch \
+        file://0074-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

