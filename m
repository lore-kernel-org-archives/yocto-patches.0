Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEA7CCD1AF
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 17:52:36 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web10.19607.1761069148360244605
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 21 Oct 2025 10:52:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Q/sqgn3k;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e871dbe94so353085739f.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761069147; x=1761673947; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGn3XitywOOygGNVWHR22hq6UxBG3BZy4mpEH4ETtyY=;
        b=Q/sqgn3koW1gN0qFxHsqdCXK+zgdsBo++5IxU3CTO5hzyI3RwKH2ozXUVNnDqs83dE
         7EJWpaWGs5+R4cVZI4BT4WArL1hBzCm6JTA3DlVQHZ6ffyjGLbNDg9mpLxK1aq1thRY8
         2+yEym4QNOWIOI4RYJzIrYko+VgCwd/RhhCH2FendnKl6i7SOlSRAjvaTEQrVKzLPvI2
         IxyQzjek6QhXJckshqHwoUlnMjsPzUcaCSvDJikg1b9VKatZsfGaCmD1FgusRlcQMc68
         nBUiL+MB58v7OF50OdVzQuSqlkxIqFwlEhWSd4DK2qSycU8jmwNFs+P2BITl/Bi2Lb+J
         jojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069147; x=1761673947;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QGn3XitywOOygGNVWHR22hq6UxBG3BZy4mpEH4ETtyY=;
        b=tGWUyw3cUepS+/zQdnVmh36e/qcOPWDAnm+VdDrb+RmPwGLagOalGIz6GA6CBacpXa
         KYeYAVbs9fth9k3PfPA4o4zqX99oWdtm+psWwI51SgDCkZ2Obn280jtTUu99jHm61DRY
         psrg3A0vTAC1dNAmEJvVWkY2kbn8HsVhSlqCaUxSmcU+wDCLx8aJClkvN06w9S7ka44k
         nt7cq/pCFYV3Oir0chukoo7vzhnQfs098JP9/pqUde5+NanJAFVGPmLln1wMFPQO+I8J
         UseT/OTbzRtETjpu8ezdHR+Ov8qeAWsIcsvO0PJsotgZwmg7gGb+3B/V61uyAFSjgU8w
         CPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPFsw7nDJ+fJpYvj0jaU9E4EMugWfdMweZLSVqqnoEymIBOXBkI1NR6XlR2NBkF7PG291/JAmTehU+ysW/@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YxHWa+ZomeodnIPlbBqOvv54HJJAi8OW7f6tUt+aCzIcUu+SEFc
	lwMROHBTpaCfL2Dxhz1rbLLJvYDuT2l6RN48TeW17mfaibYAfSf2YrbP+ZwCnA==
X-Gm-Gg: ASbGncvv7Wx9vzdZmWAcw80is/tiMJfa/jAdqPi1RqPnvpX1C9CYBOiX/VgNcxeTgMS
	oCNNSOMvEnLoK/0cAwvNueIPvUCTW8Ym29dJ6GJRDWJuVXf+g/HRnLx4+qvNUPdbtki+bZeXAsU
	vMXWUtqmZMuNF2kA6/T7It1JqZBOicu9b1fd1oSaJAxnJMI+HwO9lPUO7EcX6+FGAN6hA5GTqJD
	jD5tuJgd7rl4J9N6fh3z+P7eNnaiIEQIShblpj9IjAUknn/LoTXYrITVQOmxFDSa0rIcOO36uFa
	TIgqdJUKXlYLHAHHBcx0xe9A7RdTQpyd01ovoPtergKUcnpD8GF/B7zuXji/vZA1ylRzBovzZzu
	Uf9BwWIHgM/Q8hSwXznWOYI0hWxAgmuAOawptNWSmTtYhTgLTFyuKPt5QrigQHOKNNjLmqc3Sj/
	IIC+5hkiMy/Y06Swqt6IYrC/C9msWq80oN9huE/SDmdtsgPBIjmLY4ow==
X-Google-Smtp-Source: AGHT+IGbL7hdvgL5UBZ/Gfr5eYz0/dQT+6eMsQZ1zNuy/YUI/85BqQtp3TNU3ORFAAYqkf0SHFWgeg==
X-Received: by 2002:a05:6602:3fd3:b0:93e:8bec:6a87 with SMTP id ca18e2360f4ac-93e8bec7596mr840171439f.1.1761069147387;
        Tue, 21 Oct 2025 10:52:27 -0700 (PDT)
Received: from [172.26.252.3] (174-29-210-254.hlrn.qwest.net. [174.29.210.254])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866e1e50sm412208539f.18.2025.10.21.10.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 10:52:27 -0700 (PDT)
Message-ID: <956f748a-3ade-4eb8-b906-f5e7cd7b58f9@gmail.com>
Date: Tue, 21 Oct 2025 11:52:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][scarthgap][PATCH] refpolicy: ssh - allow sshd_t
 kernel_t:system module_request
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 17:52:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2377

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ervices-ssh-allow-sshd_t-kernel_t-sy.patch | 53 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0073-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch

diff --git a/recipes-security/refpolicy/refpolicy/0073-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch b/recipes-security/refpolicy/refpolicy/0073-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch
new file mode 100644
index 0000000..6e6b975
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0073-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch
@@ -0,0 +1,53 @@
+From e74e846a65e33e922c893ad21417348ae5d46ba8 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Wed, 11 Jun 2025 07:51:24 -0600
+Subject: [PATCH] ssh: allow sshd_t kernel_t:system module_request
+
+type=PROCTITLE proctitle=sshd -G -f /etc/ssh/sshd_config
+
+type=SYSCALL arch=armeb syscall=socket per=PER_LINUX success=no
+exit=EAFNOSUPPORT(Address family not supported by protocol) a0=inet6
+a1=SOCK_DGRAM a2=ip a3=0x0 items=0 ppid=1333 pid=1334 auid=unset
+uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
+fsgid=root tty=(none) ses=unset comm=sshd exe=/usr/sbin/sshd
+subj=system_u:system_r:sshd_t:s0 key=(null)
+
+type=AVC avc:  denied  { module_request } for  pid=1334 comm=sshd
+kmod="net-pf-10" scontext=system_u:system_r:sshd_t:s0
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
+https://github.com/fedora-selinux/selinux-policy/blob/v41.43/policy/modules/services/ssh.if#L244
+
+$ sesearch -A --source sshd_t --target kernel_t --class system --perm module_request
+allow domain kernel_t:system module_request; [ domain_kernel_load_modules ]:True
+allow sshd_t kernel_t:system module_request;
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/e3d3cd244f048304af882f00c56f48c3820bfe8d]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/services/ssh.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/services/ssh.te b/policy/modules/services/ssh.te
+index 2d10ecb73..86fa0cf99 100644
+--- a/policy/modules/services/ssh.te
++++ b/policy/modules/services/ssh.te
+@@ -249,6 +249,7 @@ corecmd_exec_bin(sshd_t)
+ 
+ kernel_link_key(sshd_t)
+ kernel_search_key(sshd_t)
++kernel_request_load_module(sshd_t)
+ 
+ term_use_all_ptys(sshd_t)
+ term_setattr_all_ptys(sshd_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 3e19f89..e730cb3 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -88,6 +88,7 @@ SRC_URI += " \
         file://0070-policy-modules-system-systemd-allow-systemd_generato.patch \
         file://0071-policy-modules-system-unconfined-allow-firewalld_t-u.patch \
         file://0072-policy-modules-services-chronyd-allow-chronyd_t-kern.patch \
+        file://0073-policy-modules-services-ssh-allow-sshd_t-kernel_t-sy.patch \
         "
 
 S = "${WORKDIR}/refpolicy"

