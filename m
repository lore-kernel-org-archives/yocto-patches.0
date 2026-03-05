Return-Path: <majortomtosourcecontrol@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136B0F33A8F
	for <webhook@archiver.kernel.org>; Thu,  5 Mar 2026 15:24:35 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.46750.1772724271309359818
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 07:24:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hiK2XrsZ;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: majortomtosourcecontrol@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c4b494fcso5029070a34.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 07:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772724270; x=1773329070; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1zEkydG/KF1JPn4EcLHdigbXcp60AaQUtEuTo8tC+U=;
        b=hiK2XrsZu63kjpfozvSuYgUturHu+bXzYkQDkgMoDxjP5VeF5XusLljCIwiokNQocD
         LHj3/Pim/UZtNYdPy3l+pPC4o+SKCm3r0f0DUCoAxffev7TjUiJWicb1T8DbCs5Ogch9
         ZfHm3CmdDQpt1fDF/jQ/IPPp7aFhVvgO+69/EJOJejeYoay5GsZN+M0LT3UZ47OPFdYx
         Nof57SPIzztXmdAwh4k9cdKSXfElOxriz093W4MfHuXheL/WEu0cGyOkhU5nOJuelGgg
         uYdPq7B/o47mqgUtCH4F6HMbWRN/Do6FLSOgx/kav3W1LebY4Bhoo6JxngLZXlrJR+K3
         vehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772724270; x=1773329070;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1zEkydG/KF1JPn4EcLHdigbXcp60AaQUtEuTo8tC+U=;
        b=FNHqEXZYL/Pp1wy9LCHpe3UfpSl7U6+zcr9sEGqz6O/yLaoMkNcaKmvaj5SmJ06er4
         SvjzCYrQSEF6aID7q4LhQOkMfso8h6NljfbkUnZ+Z+g6tQOmpTNumi/xuM5WqS2R9ioI
         z97cEhNuDrKPXBW0UBmioBzmxrT8r02INz7y023IqWXL6FuoB/qB1LwP6Xc83uX9y10h
         ZXZqoqkidaoeHccyvTnJNxq+NBWaHDqC6W0Z8akwOZ+ALGrVac9KukCs/i/1WlVGBkld
         v7DUMinLe45ufOnOZTJupkSn/SIucj/m9w57J0AR0PEsS1p/DW2hEPW2H9q9wEtCp8Dp
         ui3w==
X-Forwarded-Encrypted: i=1; AJvYcCXLerxfqtYrLY4f1TMuZPb1Zy7tHg7hDDMeqb1KYe8ugTbDPMXYSj/xq3hGt3VEY+XuYrDK1j6smoW1SeNr@lists.yoctoproject.org
X-Gm-Message-State: AOJu0YymarplNGYZN0KuNGnFpqecd7ysxQGY32FvXmIJ62JWXoTohemW
	LT7pJj8bw0tFNr2VSL5M6OjYkjW6wwy6Frv1YjdRfN+JEPHkHKaOdSph
X-Gm-Gg: ATEYQzy+FP55B6IhYGixMzvV6XoUX6dFemW2wzsYtstNzdHcdka9PwRcVyMwR+11kVE
	innq27Qct+/iUbcNI7nf9TaM+d8uF11NsmRNfHWd4Rh4J8NM66apBTNjuEmsdAqbReCO0Cdk/2s
	7oRTDrpuYgO5XccmYYZZsz+SeysYeDIKdJ0oR6iaxdk2Zlp9tLhlsqWrc34acoXJAfEetASp51A
	L3AD15Eqba2DpFOFuVkX9KVsNM8bHU+E3uLnoOKkv0v/OAaenfHQjZz+PJvMS5TroBGLEOZPuir
	bFpKGRR9Fiqv+IIlq4jnfMGPHsbE5uwEAb/bkvhnnd7HPZm1lvgCkWzKAnKQi7gvDQWhhCvDMwf
	BFq3RYX9I1H64JVELz1C7Zy5h4/B8OWZKr62BPTeeNIo4NtX1Z5aP09dbC/1DSnNaI8jVHTkrn4
	9CbELZ48TAQV/NIKiZJw39qVqiHt8UJwepZvpnarusxy1FxzIPDCln9lWzT/2bHpVGEPJI46qI8
	1gr
X-Received: by 2002:a05:6830:410b:b0:7c7:5770:d2bd with SMTP id 46e09a7af769-7d6d1255297mr4629124a34.12.1772724270469;
        Thu, 05 Mar 2026 07:24:30 -0800 (PST)
Received: from [172.26.252.3] (97-118-253-141.hlrn.qwest.net. [97.118.253.141])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866701cdsm17856309a34.29.2026.03.05.07.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:24:30 -0800 (PST)
Message-ID: <22d9a4e9-073c-4359-a6bd-a81a74e525b2@gmail.com>
Date: Thu, 5 Mar 2026 08:24:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yi Zhao <yi.zhao@windriver.com>, joe.macdonald@siemens.com,
 yocto-patches@lists.yoctoproject.org
From: Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [meta-selinux][whinlatter][PATCH] refpolicy: logging - allow
 miscfiles_read_generic_certs(syslogd_t)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 15:24:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3338

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 ...ystem-logging-allow-miscfiles_read_g.patch | 58 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-allow-miscfiles_read_g.patch

diff --git a/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-allow-miscfiles_read_g.patch b/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-allow-miscfiles_read_g.patch
new file mode 100644
index 0000000..42e53d2
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0058-policy-modules-system-logging-allow-miscfiles_read_g.patch
@@ -0,0 +1,58 @@
+From 889a18a54c568fb6ca2eb7238e85eb464ac21416 Mon Sep 17 00:00:00 2001
+From: Clayton Casciato <ccasciato@21sw.us>
+Date: Fri, 12 Dec 2025 11:56:45 -0700
+Subject: [PATCH] logging: allow miscfiles_read_generic_certs(syslogd_t)
+
+rsyslog needs to be able to access certificates to validate encrypted
+communications.
+
+https://docs.redhat.com/de/documentation/red_hat_enterprise_linux/10/html/risk_reduction_and_recovery_operations/configuring-a-remote-logging-solution#configuring-tls-encrypted-remote-logging
+
+--
+
+rsyslogd: error: defaultnetstreamdrivercafile file
+'/etc/pki/ca-trust/source/anchors/ca-cert.pem' could not be accessed:
+Permission denied [v8.2402.0 try https://www.rsyslog.com/e/2039 ]
+
+--
+
+type=PROCTITLE proctitle=/usr/sbin/rsyslogd -n -iNONE
+
+type=SYSCALL arch=aarch64 syscall=openat success=no
+exit=EACCES(Permission denied) a0=AT_FDCWD a1=0x5555d6951ce0
+a2=O_RDONLY|O_CLOEXEC a3=0x0 items=0 ppid=1 pid=258 auid=unset uid=root
+gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root
+tty=(none) ses=unset comm=rs:main Q:Reg exe=/usr/sbin/rsyslogd
+subj=system_u:system_r:syslogd_t:s0 key=(null)
+
+type=AVC avc:  denied  { search } for  pid=258 comm=rs:main Q:Reg
+name=pki dev="vda" ino=234 scontext=system_u:system_r:syslogd_t:s0
+tcontext=system_u:object_r:cert_t:s0 tclass=dir permissive=0
+
+--
+
+Fedora:
+
+https://github.com/fedora-selinux/selinux-policy/commit/66742ce1af1d752fbefe8a512f16c9165634d07f
+
+Signed-off-by: Clayton Casciato <ccasciato@21sw.us>
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/5cd787409c9c3add25da61ea7ad8edf51490df26]
+
+Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
+---
+ policy/modules/system/logging.te | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/policy/modules/system/logging.te b/policy/modules/system/logging.te
+index 121468ef6..87b4779ff 100644
+--- a/policy/modules/system/logging.te
++++ b/policy/modules/system/logging.te
+@@ -520,6 +520,7 @@ auth_use_nsswitch(syslogd_t)
+ 
+ init_use_fds(syslogd_t)
+ 
++miscfiles_read_generic_certs(syslogd_t)
+ miscfiles_read_localization(syslogd_t)
+ 
+ seutil_read_config(syslogd_t)
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index dc700f0..8486203 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -73,6 +73,7 @@ SRC_URI += " \
         file://0055-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0056-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0057-policy-modules-system-logging-allow-syslogd_t-syslog.patch \
+        file://0058-policy-modules-system-logging-allow-miscfiles_read_g.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"

