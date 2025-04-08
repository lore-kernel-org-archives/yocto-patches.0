Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9147EC369A2
	for <webhook@archiver.kernel.org>; Tue,  8 Apr 2025 14:00:30 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web11.75475.1744120821201731625
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Apr 2025 07:00:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=d/8piF3K;
 spf=pass (domain: gmail.com, ip: 209.85.166.47, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b41281b50so145127839f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744120820; x=1744725620; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crx+XITyvUvE1dXRZV4vKwc9HqKE6Ka+PzX8X68i9u8=;
        b=d/8piF3KUr/jkWOD9f+ayYIOIIiee4rlDMTn5JV9tg/D8CvDvyHXPAAK3vBzy3SZl+
         9wUTO1U0sCCrxLXrQFJuut2HrX2nQZyr0EAqM/imlya0SHLih/kwCPv9GHni5iBMQPls
         0gYR0wybebdRH7AMh7araUqkULKu0oVbrVke9FVkz0hbreVzT9GY8hPM3l819GLds42l
         eDniiJ9g9TVKzsqlNkX8T/J1u8x2Nx2KOe2HzsJ3iIKDPzRxVwWzRMuw5+gaXep4FG1G
         tqDdzSGpvqj8lJzZFwOAF8c15oSNxbkz6UVWQfsuVGL9Wxb6Q7qDDeKv2yzfjIx2/Ddc
         rCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120820; x=1744725620;
        h=content-transfer-encoding:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Crx+XITyvUvE1dXRZV4vKwc9HqKE6Ka+PzX8X68i9u8=;
        b=kU+a+z9Af8xBblhnOn3P/Hr8O/QyXOHuE9tjhv+ocK5YTHMRn5rItfRg3f4zVUgjsC
         4a8QC7TrfRW3Pi66OSL7nRpKGbGxtvCOSVCygcW8hxlypIAmu/ij7NemWKsIxTRTx8St
         dUTWhEV/kllTipaUfHyFMIsY3J9WoPmK3J6FcwUm/T9CR1gIsid1W4/tDMTkoFSZq8y5
         tXGmrhmMqI/1uxuRovo2oq10XEDj6zinLBR0efBvG6PuCWDVOlQDEWnFahpZ079eyPYO
         yacDKPtW2XQbsmj1+T9GZxd4ztX3ldgL7m+ProJssI8f7unduhspTY4UCLSKeWohUUdG
         eq9g==
X-Forwarded-Encrypted: i=1; AJvYcCU90knyWfjyIVoO8EcExM/XCHJFQaIJzTefawJ39tF/kiwhm1xvZSQ4YpXas2gOv/On7WhK9LoFqCdv/DKo@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YzRG8myu7XvtnDbT3tnKsGwFCscHu5YRRePuoVmJ8j249UnmkNs
	aM7eGi07fJKZoBgYIXEe0mTDlU3tZZB2AXP3Azl3dIXjb9vwY/qE
X-Gm-Gg: ASbGncuEfYJu0FQ8xglbdqeo7fYidVvOPXMw6x9y3mkNjNMsM5j2g77f8FhM/G544ii
	0Ijb/3siqnULtqLynrJj+TWra4frsGraAN4w7Ewz9WirRPjP2cYhJNgiyg6bC5LYdDqsWOI/PPf
	qs1/Zt3VuW9G8VWRyg4Iw877ZoSDYAq0qxoYcV+4qQzsmuPNXnttxXokmTIJojlZrNbd0pwcQvv
	LijpVOGahE6/LSTVQyguTwwe6ukxNtNm+uB+FikE3Z98b5eNqLNvddgy6rsWhj4yA1SUkurIJpG
	fs30mv4tdhtkhph9xIjMskzpvuPdXw2sGolfeqxaskeEyt5dWI8Jjq4Ef2JAv66PQfeipOvz/Hx
	dZBpulkj9Uz/sz3EmwjRmYA==
X-Google-Smtp-Source: AGHT+IF+KKfxL8YnwUNI1I1D7TVI47z5vRRb3gNlFWlK7V+8Tc5hJQ1a6Ifjj5tlhQXyo22Tjn0n/A==
X-Received: by 2002:a05:6e02:2602:b0:3d3:fa0a:7242 with SMTP id e9e14a558f8ab-3d6e53473acmr162612775ab.9.1744120820143;
        Tue, 08 Apr 2025 07:00:20 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4f45087f8sm491644173.140.2025.04.08.07.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 07:00:19 -0700 (PDT)
Message-ID: <c8ad8f69-0ef1-478c-8ff5-3919d0c3cb95@gmail.com>
Date: Tue, 8 Apr 2025 08:00:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: locallogin - dontaudit
 sulogin_t checkpoint_restore
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Apr 2025 14:00:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1332

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-locallogin-dontaudit-sulogin_t.patch | 53 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch

diff --git a/recipes-security/refpolicy/refpolicy/0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch b/recipes-security/refpolicy/refpolicy/0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch
new file mode 100644
index 0000000..252da0d
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch
@@ -0,0 +1,53 @@
+From cd5a50cb4ef1957cddc90d8ac2fd3bd5fbcde8d5 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Mon, 17 Mar 2025 20:09:55 -0600
+Subject: [PATCH] locallogin: dontaudit sulogin_t checkpoint_restore
+
+type=PROCTITLE proctitle=/usr/sbin/sulogin
+
+type=SYSCALL arch=armeb syscall=ioctl per=PER_LINUX success=yes exit=0
+a0=0x3 a1=0x5457 a2=0xbec20a90 a3=0xbec20a40 items=0 ppid=277 pid=278
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=ttyS0 ses=unset comm=sulogin
+exe=/usr/sbin/sulogin.util-linux subj=system_u:system_r:sulogin_t:s0
+key=(null)
+
+type=AVC avc:  denied  { checkpoint_restore } for  pid=278 comm=sulogin
+capability=checkpoint_restore  scontext=system_u:system_r:sulogin_t:s0
+tcontext=system_u:system_r:sulogin_t:s0 tclass=capability2
+
+--
+
+Ref: https://criu.org/Main_Page
+
+--
+
+Fedora:
+
+$ sesearch --dontaudit --source sulogin_t --target sulogin_t --class capability2
+dontaudit sulogin_t sulogin_t:capability2 checkpoint_restore;
+
+https://github.com/fedora-selinux/selinux-policy/commit/853dc2b6436ca5f2d7cb984bde3b000358829109
+https://bugzilla.redhat.com/show_bug.cgi?id=2265391
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/79dda56d3191b09b9f0cbafd4d1bd7056fd3975e]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/locallogin.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/system/locallogin.te b/policy/modules/system/locallogin.te
+index 4ba131d29..02c7ff56d 100644
+--- a/policy/modules/system/locallogin.te
++++ b/policy/modules/system/locallogin.te
+@@ -234,6 +234,7 @@ optional_policy(`
+ 
+ allow sulogin_t self:capability { dac_read_search sys_admin sys_tty_config };
+ dontaudit sulogin_t self:capability dac_override;
++dontaudit sulogin_t self:capability2 checkpoint_restore;
+ allow sulogin_t self:process setexec;
+ allow sulogin_t self:fd use;
+ allow sulogin_t self:fifo_file rw_fifo_file_perms;
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index c40d6e7..6a3e9eb 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -78,6 +78,7 @@ SRC_URI += " \
         file://0060-policy-modules-services-firewalld-fix-lib_t-python_c.patch \
         file://0061-policy-modules-services-firewalld-fix-firewalld_t-fi.patch \
         file://0062-policy-modules-multiple-filetrans-run_machine_id-etc.patch \
+        file://0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

