Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F7BCCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 16:36:04 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.1825.1760978161846646292
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 09:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RnRGgTDh;
 spf=pass (domain: gmail.com, ip: 209.85.166.51, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-92790f12293so226253339f.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760978161; x=1761582961; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS1Pf/McLgQKiG+N7aL4ggkLy+BBzyf/iqHhiuh48W0=;
        b=RnRGgTDhjeZBLntWy/y2ToQP8aKDRXkhmTwGPKDLG3+FZBHo0ysyspqbEqF2zr0UpK
         z+ojKfwCcS37Blc6tBpnPHCiigsmTN85oPAc7Hn+B69R5ZVISVE29A35ieKZUKKLSb3v
         w73/Po3tsh8hFbhJcZ9BmJtJjQnwse2ENCPjkNM+P3uu8jK+F3wPPo1K3MsHO9DcDrQH
         nLPRA0xHCzSnEYyVcnxWQr+qWLaFrVJSLrOXvHzfsbLg/twKztWgDiWOwzqB1MCvJMZg
         Jbk+npLIXBB7r2Wo53FDIIloBdz9KLUUYRYappGy1tnCXuLXC2GbCTGD695IXx4nREo0
         6dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760978161; x=1761582961;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IS1Pf/McLgQKiG+N7aL4ggkLy+BBzyf/iqHhiuh48W0=;
        b=KDXCDoQtfO8wojQ+2zgnwPsrBwuHrm097TYqixpWvpyEN3VBiIAKmPhw2M5mt/I8DS
         Pwt7yYjw5S+RkuXH1hvvEN40bMXNHQA/BeKLz53/lNvZXuBAwAOChQiWvywYh/549T2Y
         mLI/RQdFxHHjg5lKoFtWvpS/FGSlOidGwO3r8hVyeAIKGGsNwbih+tAZWKlDHHXX2Kn5
         aiJPadeAtEEzpaL+VCLdfpBH4guFvZzfCdCQiWXBNPvIBSqmGfQlMsr3nOnp2QaPTaT2
         A3w0xuBAJPkEvlcX4IdHy30I6T1tHSGNS9C4DwI+OjMLyd6ULzNb1zTVdGzolK4gOaK6
         Tl0A==
X-Forwarded-Encrypted: i=1; AJvYcCXI+fgzKrZ3XosO/lVOQkDgS4olXa21+Go5XVWAiRaGgnGgNdedWU+A28muTEJSWuGl6u/ddgnqmS4Mu3f2@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxcMFqDudbt4CUNGNO+LRnbOnmoHocpKXIux2BikwZjNbU/Qd/F
	vlNk7GT2r1spHD4tUZnTvDV0D2ih0DJ3M6wRRpKb9tByMLfIJHPeuusS
X-Gm-Gg: ASbGncvftpRRXlAl3kF9axxqLglj8XS7L0kZ79mtbFzy74pw1Pu2WFdknEmX6jtSrjk
	xyWKzWpj+jOIaQU824ttk8toEFejZMTyCc1Liw0Fw6ortgt/YgW7ZL9OG++96KslsKIaG5Mltkw
	xjTCFQ6VduCuM1bF4mljZVin7RJz72XJrmIqLkBOImAbmVFhm3wOz2WbuHNUElXymw8B7sCV0pW
	X21YgFha+DkiY7zZHN0Xuuefcgz+3e190VlnlrK4tLi8jowNEOJ0ehAKNBoSCcnM+y/O/bJO6xs
	BgNBxd3i2mhvfBq7BAFL37YF5TO1a5Y8JAoKNGOeNX63jheIdSPL7noSHiqQfSLv9yLIL6BsfxB
	2pK99c2rEsSH+UgoZzlJH5Xc2zfI9hoaq7i4+lggxFIP29jR6LcXyTJ8G7yFVPYcZvrfCPpdm11
	Q3RfkuwJLfl1DHZTSRFuSfET9fpQxxHUkQwo5xY4bHWJLrN7JaijInO0kf+rg2mccB6PSDKz25g
	5s=
X-Google-Smtp-Source: AGHT+IEyBDBAIzo4bEkbqgRjiDq9pjhxpCZrJoaQ+PkTEqx/bK8Mxs2EWUuMuktB7dl29Bezvq+zQQ==
X-Received: by 2002:a05:6e02:1686:b0:430:b616:485e with SMTP id e9e14a558f8ab-430c514b670mr212209835ab.0.1760978160895;
        Mon, 20 Oct 2025 09:36:00 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9797c36sm2983444173.56.2025.10.20.09.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 09:36:00 -0700 (PDT)
Message-ID: <46292791-91d0-4eb7-a616-e2ef7fab8b4c@gmail.com>
Date: Mon, 20 Oct 2025 10:36:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: chronyd - allow chronyd_t
 kernel_t:system module_request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 16:36:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2367

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-chronyd-allow-chronyd_t-kern.patch | 53 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0072-policy-modules-services-chronyd-allow-chronyd_t-kern.patch

diff --git a/recipes-security/refpolicy/refpolicy/0072-policy-modules-services-chronyd-allow-chronyd_t-kern.patch b/recipes-security/refpolicy/refpolicy/0072-policy-modules-services-chronyd-allow-chronyd_t-kern.patch
new file mode 100644
index 0000000..bbc4b10
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0072-policy-modules-services-chronyd-allow-chronyd_t-kern.patch
@@ -0,0 +1,53 @@
+From 0586fd29500c3d9d2b37dd0a1498f19184676610 Mon Sep 17 00:00:00 2001
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
index fd3073c..3e19f89 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -87,6 +87,7 @@ SRC_URI += " \
         file://0069-policy-modules-services-oddjob-allow-oddjob_mkhomedi.patch \
         file://0070-policy-modules-system-systemd-allow-systemd_generato.patch \
         file://0071-policy-modules-system-unconfined-allow-firewalld_t-u.patch \
+        file://0072-policy-modules-services-chronyd-allow-chronyd_t-kern.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

