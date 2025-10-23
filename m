Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA21CCD1BC
	for <webhook@archiver.kernel.org>; Thu, 23 Oct 2025 14:04:03 +0000 (UTC)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
 by mx.groups.io with SMTP id smtpd.web10.21934.1761228237270630036
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Oct 2025 07:03:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FDa0RF6b;
 spf=pass (domain: gmail.com, ip: 209.85.166.177, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430c180d829so4520845ab.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Oct 2025 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761228236; x=1761833036; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/68+CBavPCG139LLCbI5o3o2Tc6s8uxNB3qjidIBIbA=;
        b=FDa0RF6bpQG0UsMiX5H9rFxEG92ImzXhPeWUjmYvY3lNoVVCtUZeitwnzlI+OPbbmI
         8e5+UJfi6la+BdV12IwtlVGAdg7sTO4OjgVJo0GqAS+arJosoFG/M1VdU1uxfKCpBylb
         u7F3cPBESmwQaodAVAFVsJjk6cZYbUsx573ES6lVzjxM6KZnbvJGL1rPVa1gKaMkowTd
         MLyAjR3m9GvJscILBAaBCqtMDrkrvPR7+UXDaXvzvp1C1g/778gPaLAdwvgsEU2+ciVc
         luEo7c+tnVYd/E8Q/yyYVPrLAG53lKmLNckVOyTYdAdE6xWfa5EioDCDrYNvRvdbKqy4
         wK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761228236; x=1761833036;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/68+CBavPCG139LLCbI5o3o2Tc6s8uxNB3qjidIBIbA=;
        b=BO9Qmzwo/zxRDsNvkSx2Nou+dWoOP6dgGfK6caT7bstmk3gg/C67Y2R2/Al0wmOE86
         bgCNyDYZr69fjA8cr/SKSEu554hjYc2AHiM73OyeF6E//Gr5VCviF7qI+2Pe2lpL+VPr
         jjMDw656YZ8FoW1+fuYQbjJr6wzy7G0aNLyquyJUYcihSG5y7e4o9A//Ke8qygl3h3Lw
         7h5uPscwSbvCuCdZPKiwtbiVT29BftxcJHRf6i2dGpgFl/dD0abf6fvd2j7KmEIumP9D
         9p48sCW08QLxWyBtf/0B93ifICQtkHuFd9G7StNGO72JXmme2TeN6HaEAJCYM62NAbHY
         drUA==
X-Forwarded-Encrypted: i=1; AJvYcCWa5pdUPVodZ+4N3+05i/GcghG3H4u3SCLQ6UKKx6KeETILXwmPK/uYSNvan0tn/+Egsp5xnwTmuqgiahK8@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxmVEf0J0csAmM5Iq8Y6wdCwrb9iAw5la//Qd9TPOnlogaT4Y1q
	o/BRw+KMYrR9yZWomXFx2W+HiiUPEJWdASHqTQzwjFSZ/4pkiDGw5TyF
X-Gm-Gg: ASbGncsueUt1Ck6hlSauHNYoCRB57usWFTbsm0yLw6JLBl2OGZboUH4nz23NdGZJIVc
	SE4xATTWjSdsZhq5JWtsR8VuCaN4t3koGyvOk4wCp0qr42bSgJw/yRTL2zL9oRNLu5KO98W/Ea8
	tK6Mb6syospwc5y4v/mZC0nmmwcaLMQdAZgFFIt9DY7FWQc72FeDOWk/MSdnPgvzbqHyt/CzUXh
	f3uPFN3P98MHkkKo+EH+N8bR4ggC2OBlZ+iW9ltDRVJIp/494IT/ugdQUoiP2a6wC0wUSCCS8l0
	jU4KGPlw4Qhmu0wXVx8f4/b4Ko3QwXNSuRbXh4gach3VKpK9hHdUnz390qYG87vGM2CGiqx9cC0
	Tf98kGeVlFEbNFeZLpMlyjwQ+3undk+S6NyontdhX30MpQLYI/yZsLDMGTwuLQ/CsB610QljJq1
	1P7sVGuZHFOr0rJGdpdPsvHX+hbAV5oHkoitwEjc25chjYluhuQjPw9aV5HQ/9tpMZdE4bkjvVl
	xo=
X-Google-Smtp-Source: AGHT+IGz07AeZXZMnOPPCv35GlPu5XByFdDa1cSH95IKquCWWsPoM9SOq6mTD8R5L9u4EQsPEwmcFw==
X-Received: by 2002:a05:6e02:74a:b0:431:d9d9:de29 with SMTP id e9e14a558f8ab-431d9d9e122mr58639765ab.7.1761228236021;
        Thu, 23 Oct 2025 07:03:56 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431dbc22188sm9492185ab.4.2025.10.23.07.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:03:55 -0700 (PDT)
Message-ID: <80f7dcf4-c79e-4584-80e1-c207164ae280@gmail.com>
Date: Thu, 23 Oct 2025 08:03:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: yi.zhao@windriver.com, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: systemd - allow
 systemd_logind_t unconfined_t:fd use
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Oct 2025 14:04:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2386

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-systemd-allow-systemd_logind_t.patch | 56 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0076-policy-modules-system-systemd-allow-systemd_logind_t.patch

diff --git a/recipes-security/refpolicy/refpolicy/0076-policy-modules-system-systemd-allow-systemd_logind_t.patch b/recipes-security/refpolicy/refpolicy/0076-policy-modules-system-systemd-allow-systemd_logind_t.patch
new file mode 100644
index 0000000..5300a24
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0076-policy-modules-system-systemd-allow-systemd_logind_t.patch
@@ -0,0 +1,56 @@
+From 4425ec31bc654f1b9bccea9e95fe18c532458200 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Tue, 8 Jul 2025 17:06:19 -0600
+Subject: [PATCH] systemd: allow systemd_logind_t unconfined_t:fd use
+
+"sudo su -"
+
+--
+
+type=PROCTITLE proctitle=/usr/lib/systemd/systemd-logind
+
+type=SYSCALL arch=armeb syscall=recvmsg per=PER_LINUX success=yes
+exit=24 a0=0xe a1=0xbee507e4 a2=MSG_DONTWAIT|MSG_CMSG_CLOEXEC a3=0x1
+items=0 ppid=1 pid=186 auid=unset uid=root gid=root euid=root suid=root
+fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset
+comm=systemd-logind exe=/usr/lib/systemd/systemd-logind
+subj=system_u:system_r:systemd_logind_t:s0 key=(null)
+
+type=AVC avc:  denied  { use } for  pid=186 comm=systemd-logind
+path=anon_inode:[pidfd] dev="pidfs" ino=311
+scontext=system_u:system_r:systemd_logind_t:s0
+tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=fd
+
+--
+
+Fedora:
+
+$ sesearch -A --source systemd_logind_t --target unconfined_t --class fd --perm use
+allow daemon initrc_transition_domain:fd use;
+allow domain domain:fd use; [ domain_fd_use ]:True
+allow domain unconfined_t:fd use;
+
+$ getsebool domain_fd_use
+domain_fd_use --> on
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/a742066011070c6696eda00442a46d1e9970a614]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/systemd.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/system/systemd.te b/policy/modules/system/systemd.te
+index bbcded640..757976594 100644
+--- a/policy/modules/system/systemd.te
++++ b/policy/modules/system/systemd.te
+@@ -1114,6 +1114,7 @@ optional_policy(`
+ 
+ optional_policy(`
+ 	unconfined_dbus_send(systemd_logind_t)
++	unconfined_use_fds(systemd_logind_t)
+ ')
+ 
+ #########################################
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 5da4c48..5554ef9 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -91,6 +91,7 @@ SRC_URI += " \
         file://0073-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch \
         file://0074-policy-modules-services-ssh-allow-sshd_t-userdomain-.patch \
         file://0075-policy-modules-services-dbus-allow-system_dbusd_t-un.patch \
+        file://0076-policy-modules-system-systemd-allow-systemd_logind_t.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

