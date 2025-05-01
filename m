Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901F5C369DC
	for <webhook@archiver.kernel.org>; Thu,  1 May 2025 20:08:51 +0000 (UTC)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
 by mx.groups.io with SMTP id smtpd.web11.3929.1746130125582936893
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 01 May 2025 13:08:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AlKcMGqn;
 spf=pass (domain: gmail.com, ip: 209.85.166.46, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85e73562577so139459139f.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746130125; x=1746734925; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWq2b+32A7TzdSh2d/b6qvR7vAKuqYYrqRhtwMotwiY=;
        b=AlKcMGqnbzRB5sD0CuvG3s/nC+RQkU4/zINxzvEw9bMja/QGPG2F0bFcTyXr/Yst1g
         KumsgJydH30ejMVof2zgx8AlUCzs8hqzEBOVzLHyx/u6QOAW5M450473i38B39XawdzG
         ZXZW41MbARUA2SsitlPU3IHdIXO5lnKp9j3GcXInEEu5O1ASjQHYUNv9SD1beHhepvJi
         Tz3WdLQevr7zhj4pdCwLYBNohyb/X1mjMu6bBawi4WDJiZq3Y/Noqp3UihToveVXEdKF
         j4oJHcGzWRNfMlJ5BqzVNJuJYCyrMhcCiGtQaAuXhV/fmGxwEPqIzJZEOa1t074SPgiF
         Jmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746130125; x=1746734925;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hWq2b+32A7TzdSh2d/b6qvR7vAKuqYYrqRhtwMotwiY=;
        b=CF6Q8YSi0N/k61bMPbM6XIrOZEUThGHtOU0UUP5R/ZkUbdJ3f13RZuBrq6NVfdIVBF
         Hcqzv1WoeI4XV/MkFKtwcvN0iKDYObvX4khHbRKJf2K4X12wSIy3F+iCc47ftsQ8I5WP
         NESwaHJTUaLy7VoiDzPw0oizszZINSVdJS7/lvj/2JHMIy/tv6UtuxSYsE6LMbHSZ48o
         xktx41CHU/dVu3kF7B2TaZ93TfkhDEmMx5QS2wJyYrpw67dIWZJ2PNOYET1hC7wP8UrZ
         iKr6ih+R+4LtF3eONSMChD7gfvJBspCGDULi/KUcPJwby/b3oHcF+noiwZLzly44VYy2
         sMTg==
X-Forwarded-Encrypted: i=1; AJvYcCUI0nbD3lYY1QzF26iBlno/kVK2JFlTjYSIFfYu5xs0VU10hBvbFRJi9fyrYGb3asGkczhgXqcyaD5N/QOb@lists.yoctoproject.org
X-Gm-Message-State: AOJu0Yxbl28cxfHGVMdtwIw/kvv+VvEF1VAnvfw/KF3bbAuuiqUEkYbQ
	CBqAUefdMn8oE+E3+qGstPkteC0VZuufibJ0rIurf6mv9DI+EMHX
X-Gm-Gg: ASbGncvgopfaLN9ZFyjpvsPm0PxEkC8lu/6mynndm8hWp6fCKHiH4woqQnJ3Lg11YNk
	dQ4eGWyVE6iuVJcQlbfoQGu9AiHGCjag+5MShTBYOjNzWzY+igzlbaNksYb9kETe6FaF7v8cL7k
	wuTswg5X2cuTzs50GCEYkjHjb0i/dyaqwWZLOPdUedKgWpZ+ubH9DOESakGIogAgDjYgS551daZ
	hY7Jo+vpr9hL/Bp61ZmFLYJIBjZv2sR7iZQznAhTMOFvayJ/vSyC3m/3u7d0QDfKXYoE24NrbF1
	SdJgM+XIMDwVHCbSLjC7lR8pqS0/X11XAIiV4BUFMgFx23+Kn/+4dVWBf8X34iresVAtk2LEpjl
	/zSsk682kLX/F9uVm7g==
X-Google-Smtp-Source: AGHT+IGVxPHjHU6Ax2A2ukqw2jegLSb6HbLAkelbCvWwkgKVbCswli8MYF3GfOcUHIzUmWAV4EkBPA==
X-Received: by 2002:a05:6602:4007:b0:864:4862:91a2 with SMTP id ca18e2360f4ac-866ab63b472mr66685439f.10.1746130124752;
        Thu, 01 May 2025 13:08:44 -0700 (PDT)
Received: from [172.26.252.3] (174-29-216-122.hlrn.qwest.net. [174.29.216.122])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa2eb68esm23419439f.16.2025.05.01.13.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 13:08:44 -0700 (PDT)
Message-ID: <b834e5c5-7ab7-4d7a-9b8b-0671171834cf@gmail.com>
Date: Thu, 1 May 2025 14:08:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: joe.macdonald@siemens.com, yi.zhao@windriver.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: oddjob - allow
 oddjob_mkhomedir_t privfd:fd use
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 May 2025 20:08:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1426

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-oddjob-allow-oddjob_mkhomedi.patch | 62 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch

diff --git a/recipes-security/refpolicy/refpolicy/0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch b/recipes-security/refpolicy/refpolicy/0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch
new file mode 100644
index 0000000..b210be0
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch
@@ -0,0 +1,62 @@
+From ad8e85e918b0312ebe1266d92b2ee862db28b767 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Wed, 9 Apr 2025 17:34:10 -0600
+Subject: [PATCH] oddjob: allow oddjob_mkhomedir_t privfd:fd use
+
+type=PROCTITLE proctitle=mkhomedir_helper user123 0077
+
+type=EXECVE argc=3 a0=mkhomedir_helper a1=user123 a2=0077
+
+type=SYSCALL arch=armeb syscall=execve per=PER_LINUX success=yes exit=0
+a0=0x5b79d8 a1=0x5a64d0 a2=0x5b0f10 a3=0x0 items=0 ppid=429 pid=1369
+auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root
+sgid=root fsgid=root tty=ttyAMA0 ses=unset comm=mkhomedir_helpe
+exe=/usr/sbin/mkhomedir_helper
+subj=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+key=(null)
+
+type=AVC avc:  denied  { use } for  pid=1369 comm=mkhomedir_helpe
+path=/dev/ttyAMA0 dev="devtmpfs" ino=2
+scontext=unconfined_u:unconfined_r:oddjob_mkhomedir_t:s0-s0:c0.c1023
+tcontext=system_u:system_r:getty_t:s0 tclass=fd
+
+--
+
+Ref:
+https://github.com/SELinuxProject/refpolicy/blob/RELEASE_2_20250213/policy/modules/system/getty.te#L12
+
+https://danwalsh.livejournal.com/77728.html
+https://github.com/SELinuxProject/selinux-notebook/blob/20240430/src/type_statements.md#typeattribute
+
+--
+
+Fedora:
+$ sesearch -A --source oddjob_mkhomedir_t --target getty_t --class fd
+allow application_domain_type privfd:fd use;
+allow domain domain:fd use; [ domain_fd_use ]:True
+
+$ getsebool domain_fd_use
+domain_fd_use --> on
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/a3a6b17045412be07f63581f6e10310175e82ddf]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/oddjob.te | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/policy/modules/services/oddjob.te b/policy/modules/services/oddjob.te
+index 6ea785851..299077739 100644
+--- a/policy/modules/services/oddjob.te
++++ b/policy/modules/services/oddjob.te
+@@ -79,6 +79,8 @@ kernel_read_system_state(oddjob_mkhomedir_t)
+ 
+ auth_use_nsswitch(oddjob_mkhomedir_t)
+ 
++domain_use_interactive_fds(oddjob_mkhomedir_t)
++
+ logging_send_syslog_msg(oddjob_mkhomedir_t)
+ 
+ miscfiles_read_localization(oddjob_mkhomedir_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 282fb6a..5cb44a8 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -81,6 +81,7 @@ SRC_URI += " \
         file://0063-policy-modules-system-locallogin-dontaudit-sulogin_t.patch \
         file://0064-policy-modules-system-locallogin-allow-sulogin_t-unc.patch \
         file://0065-policy-modules-system-locallogin-allow-sulogin_t-use.patch \
+        file://0066-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

