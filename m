Return-Path: <wenjia.zhang@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA3FCD4F5E
	for <webhook@archiver.kernel.org>; Wed, 20 May 2026 06:25:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6157.1779258332505934035
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 May 2026 23:25:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=GeeB7fn+;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=cMnryKYa;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: wenjia.zhang@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JMmFJu341539
	for <yocto-patches@lists.yoctoproject.org>; Wed, 20 May 2026 06:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5rTRhXWs6Nch3PaJvCriUXePBD+w2CVA+Dc
	lst2dvYI=; b=GeeB7fn+3oBBzuH0BzT6EnufOKCaL+Q1josVRv5rs7zpDfYGGey
	CyRByPYGqNPO23YAEu5NuiR5QqXo2HAzXzt5J8pLYLZJFzPBDC53GcNkaVoBlkQG
	+2vpJZfJC4dranJovPIOoNCTceI6YeZBfYk5yevK2ZmQdKOa4j4uvFBYq2BVF9gN
	pRaKP7TgKqpMjS8a5hc9C/gHVH3t0uH5igZDqsb/b7XAIv0jYs5dkvT3ovSwZbnZ
	4WZmuKieg0cC05GCHDO9W0IlRxzDWRXN0w6rS2DnSBBN04Jql6TQ+qvf5lf4sj8+
	qt7Ye5Mm/fZuMbER1hhny90BIcQTU0g+QFg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3vb8wv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 20 May 2026 06:25:31 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36781927b4dso4747852a91.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 19 May 2026 23:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779258330; x=1779863130; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rTRhXWs6Nch3PaJvCriUXePBD+w2CVA+Dclst2dvYI=;
        b=cMnryKYadv2SMMhskz9XTGvAGlJqoL6BVm7LGB+MNqhTP4/8ec3RNOUKaVd4HrIDX1
         +yl3WvC61RIPKhEIqSDupTPBdF/PQgXMMAoW8aKsBghat+EmqE0tfh1pX9o/3A3PdJ3f
         sFqi3eCUFVKVbyaHeWVV9zbhhZ8lcTCeb+Dkz9B+fWZnGrHMojjP7CmeeIQYVs219/hT
         R68wHId5Sm/+f15oHVgmdn7SXxVIwnC+mYaPr3s0/Gb6Y8kYhwBrsRGsXM59bf+t5phM
         q1nJVO9DHO5r57kUN7pz/gulDVEY/lsVpaCC1i4Qhs8lBEfXXRGxrlt29XOhHO0TC8t2
         NswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779258330; x=1779863130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5rTRhXWs6Nch3PaJvCriUXePBD+w2CVA+Dclst2dvYI=;
        b=hG5KiO9RjpRUotJfG6z9ONDJy/ONjEFpuryqml8l94WjulE6L7aweVmD2PBuQs3QDz
         ZEW6MvBMY/SF3WJcBkEytcW8/81CnF54OS7Y66YURE/31a9M+rSWOxRV7ZN+4mgfD3WC
         qoQlX6HHFqVDNKyJQFTgru5bIoD2+YpRI0SBUw4RGWJ/V7uWpxRC2f1mAj7dEgRmiK+V
         JXDgw35smQxsyVmONieV9lLwyCXconx0GFO/maA2qzGkfSkfe7JbZ7XsIdhesLuIy98y
         xgT3jEDToLKas3Y8S7GqRkwdlQcPXIAsEbmDK90bsqoyuV6d1+UI5RMKnMnm+r/YpVPO
         BA0A==
X-Gm-Message-State: AOJu0YzIG40Jr1bHnZWljJgMuL/XigyjoiL8gNU9kXet90iDjHux3ogx
	CZzhRTaM0EMIRKoCeG0rbHGHgJPpgw5j3ay+n4CWn1PEQcL0+CIkqU7Z7PkNK5n1o5+eyIyfERt
	WEj7sTUNVSETae30yVO6iYET9xGd1dXjkdSPT5Y3q50MBRUvDZgNckJRplgMnihSVmZ/mib06fq
	eZHUeXHPF/VLmQ
X-Gm-Gg: Acq92OEGYHSQXcu36UR9HL1Z/x2wSrjl0Q6FwcsHyNLVAIxoUoGLYIKhNP14zuPGGwX
	Qvhxfs4o3P3isT0/0+0QSoQz1Cm3wMP6dRYN7R8SlGDfPwhpSvKicGd+f9AXrd9imQPtAkmB+RM
	SXH6K0dVa+I8EjMd4zm8OUkibZbhHvvqifLU3ezVQxEo86QkBfSQCSpG2VjUXd+SSnGCPrAe+eD
	vy9ywkdv4ldg1ABKVUVp4IzdvImNUeVq8SumwxmJKRAtn6RJjNybBnbWHM8Z+jPzO5+S/LwmeLB
	aDqcExVyDnPfczIvb1P3Xs97+O66lgKiJ/pZV7qfUYTp2L7o9uTg7oOdsT1vNrN/MYlf08Z+/2t
	5Nxvh9s+11s9CZ98MwmUCkalYUaq1V7sb18KWpIJuFMNTQJlQNm0=
X-Received: by 2002:a17:90b:534e:b0:369:bddb:79b5 with SMTP id 98e67ed59e1d1-369bddb84b8mr11879639a91.2.1779258330080;
        Tue, 19 May 2026 23:25:30 -0700 (PDT)
X-Received: by 2002:a17:90b:534e:b0:369:bddb:79b5 with SMTP id 98e67ed59e1d1-369bddb84b8mr11879610a91.2.1779258329374;
        Tue, 19 May 2026 23:25:29 -0700 (PDT)
Received: from hu-jiaxli-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695652466dsm8156448a91.0.2026.05.19.23.25.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:25:28 -0700 (PDT)
From: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH/V2] Added the necessary policy for domain tee_supplicant_t.
Date: Wed, 20 May 2026 11:55:26 +0530
Message-Id: <20260520062526.3851830-1-wenjia.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qsg-Hj6HYbn-wJWmALLyBi1KsH0UxQPu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA1OCBTYWx0ZWRfXynPzTQ16sy9P
 I5RY41NxIxGoKGXdnQDJqLdUT3rfetK/8SGBXXvNw/V3mCehxe3ggup+xkxKsGPOt1iM43pMsM9
 8c2R/qz1jhGFnHzpr90kt2xhqGQ4YpAZvsQoVs0v79iYysmUqAi4BiBfIdCQHeeYvyBNamd8Vvb
 Ggv/RoDBHHazfYKQ2RNdwIjozFQWBF0b2YhpIoMMulZtMbfPLLJC7WSd/ATfUybXOgAzEsVfARf
 qImFJsi9s57gKNGLeAWOE+m8Z/RJSyJWLGwLF6z3W2wn5aLeFj+ky/aAfYTYShI8hk05P6Xgn/g
 a/1oX0we5LjJQNUjfc76RfgSgE6FCaUKcTVHO7Nn7ofEbndL/TsSnyjvEWHfEjhSlw1u4qHuIuM
 gK6x31j1ho0e4InnrvON0KD4Kk5j12S8z8EXlhP3gsQu5TUzhOQtEx1sskUHXhi49uj3mBK9o/G
 As/CcW3RGIav4jKdRHg==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0d53db cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=wnEXS8_1iZlmcswqAMYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: qsg-Hj6HYbn-wJWmALLyBi1KsH0UxQPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200058
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 May 2026 06:25:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4002

Signed-off-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
---
 ...dd-necessary-SELinux-policy-for-qtee.patch | 236 ++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |   1 +
 2 files changed, 237 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Add-necessary-SELinux-policy-for-qtee.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Add-necessary-SELinux-policy-for-qtee.patch b/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Add-necessary-SELinux-policy-for-qtee.patch
new file mode 100644
index 0000000..c00c597
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Add-necessary-SELinux-policy-for-qtee.patch
@@ -0,0 +1,236 @@
+From dbe6da2881241745b8cc6286e74cb801c3945ae3 Mon Sep 17 00:00:00 2001
+From: Wenjia Zhang <wenjz@qti.qualcomm.com>
+Date: Thu, 16 Apr 2026 11:38:59 +0800
+Subject: [PATCH] tee_supplicant: Add necessary SELinux policy for
+ qtee_supplicant
+
+This change is adding some interfaces for qtee_supplicant which requires
+more permissions than OPTEE's tee_supplicant.
+
+Overall, some necessary permissions for qtee_supplicant to accessing
+system resources have been added.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1105]
+
+Signed-off-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
+---
+ policy/modules/kernel/storage.if          | 60 +++++++++++++++++++++++
+ policy/modules/services/tee_supplicant.fc |  2 +
+ policy/modules/services/tee_supplicant.if | 22 ++++++++-
+ policy/modules/services/tee_supplicant.te | 39 +++++++++++++++
+ policy/modules/system/init.te             |  4 ++
+ testing/sechecker.ini                     |  1 +
+ 6 files changed, 127 insertions(+), 1 deletion(-)
+
+diff --git a/policy/modules/kernel/storage.if b/policy/modules/kernel/storage.if
+index 81a4d1a61..19f0b2ab1 100644
+--- a/policy/modules/kernel/storage.if
++++ b/policy/modules/kernel/storage.if
+@@ -547,6 +547,36 @@ interface(`storage_read_scsi_generic',`
+ 	typeattribute $1 scsi_generic_read;
+ ')
+ 
++########################################
++## <summary>
++##      Allow the caller to directly read, in a
++##      generic fashion, from any SCSI device
++##      if a tunable is set.
++## </summary>
++## <param name="domain">
++##      <summary>
++##      Domain allowed access.
++##      </summary>
++## </param>
++## <param name="tunable">
++##      <summary>
++##      Tunable to depend on
++##      </summary>
++## </param>
++#
++interface(`storage_read_scsi_generic_cond',`
++        gen_require(`
++                attribute scsi_generic_read;
++                type scsi_generic_device_t;
++        ')
++
++        typeattribute $1 scsi_generic_read;
++        tunable_policy(`$2',`
++                dev_list_all_dev_nodes($1)
++                allow $1 scsi_generic_device_t:chr_file read_chr_file_perms;
++        ')
++')
++
+ ########################################
+ ## <summary>
+ ##	Allow the caller to directly write, in a
+@@ -572,6 +602,36 @@ interface(`storage_write_scsi_generic',`
+ 	typeattribute $1 scsi_generic_write;
+ ')
+ 
++########################################
++## <summary>
++##      Allow the caller to directly write, in a
++##      generic fashion, from any SCSI device
++##      if a tunable is set.
++## </summary>
++## <param name="domain">
++##      <summary>
++##      Domain allowed access.
++##      </summary>
++## </param>
++## <param name="tunable">
++##      <summary>
++##      Tunable to depend on
++##      </summary>
++## </param>
++#
++interface(`storage_write_scsi_generic_cond',`
++        gen_require(`
++                attribute scsi_generic_write;
++                type scsi_generic_device_t;
++        ')
++
++        typeattribute $1 scsi_generic_write;
++        tunable_policy(`$2',`
++                dev_list_all_dev_nodes($1)
++                allow $1 scsi_generic_device_t:chr_file write_chr_file_perms;
++        ')
++')
++
+ ########################################
+ ## <summary>
+ ##	Allow the caller to delete the generic
+diff --git a/policy/modules/services/tee_supplicant.fc b/policy/modules/services/tee_supplicant.fc
+index 41b654268..73c5022c4 100644
+--- a/policy/modules/services/tee_supplicant.fc
++++ b/policy/modules/services/tee_supplicant.fc
+@@ -1,2 +1,4 @@
+ /usr/bin/qtee_supplicant      --      gen_context(system_u:object_r:tee_supplicant_exec_t,s0)
+ /usr/sbin/tee-supplicant      --      gen_context(system_u:object_r:tee_supplicant_exec_t,s0)
++
++/var/lib/tee(/.*)?                    gen_context(system_u:object_r:tee_supplicant_var_lib_t,s0)
+diff --git a/policy/modules/services/tee_supplicant.if b/policy/modules/services/tee_supplicant.if
+index e22a531f5..5274d1e2c 100644
+--- a/policy/modules/services/tee_supplicant.if
++++ b/policy/modules/services/tee_supplicant.if
+@@ -1,5 +1,5 @@
+ ## <summary>tee_supplicant</summary>
+-#
++##
+ ## <desc>
+ ## qtee_supplicant is a userspace supplicant daemon that
+ ## services callback requests from QTEE via the Linux TEE subsystem.
+@@ -8,3 +8,23 @@
+ ##
+ ## https://github.com/qualcomm/minkipc/tree/main/qtee_supplicant
+ ## </desc>
++
++#####################
++## <summary>
++##  Allow the specified domain to create
++##  objects in /var/lib with an automatic
++##  transition to the tee_supplicant var lib type.
++## </summary>
++## <param name="domain">
++##  <summary>
++##  Domain allowed access.
++##  </summary>
++## </param>
++#
++interface(`tee_supplicant_var_lib_filetrans',`
++       gen_require(`
++               type tee_supplicant_var_lib_t;
++       ')
++
++       files_var_lib_filetrans($1, tee_supplicant_var_lib_t, dir, "qtee_supplicant")
++')
+diff --git a/policy/modules/services/tee_supplicant.te b/policy/modules/services/tee_supplicant.te
+index 0e0b67bc2..ab0cc2e8c 100644
+--- a/policy/modules/services/tee_supplicant.te
++++ b/policy/modules/services/tee_supplicant.te
+@@ -5,12 +5,20 @@ policy_module(tee_supplicant)
+ # Declarations
+ #
+ 
++## <desc>
++##  <p>
++##  Enable rules specific to qtee_supplicant.
++##  </p>
++## </desc>
++gen_tunable(tee_supplicant_qtee, true)
++
+ type tee_supplicant_t;
+ type tee_supplicant_exec_t;
+ init_daemon_domain(tee_supplicant_t, tee_supplicant_exec_t)
+ 
+ type tee_supplicant_var_lib_t;
+ files_type(tee_supplicant_var_lib_t)
++files_mountpoint(tee_supplicant_var_lib_t)
+ 
+ #########################################
+ #
+@@ -25,3 +33,34 @@ dev_rw_tee(tee_supplicant_t)
+ dev_rw_tee_priv(tee_supplicant_t)
+ 
+ kernel_read_vm_overcommit_sysctl(tee_supplicant_t)
++
++# Access qtee_supplicant to access UFS BSG device
++storage_read_scsi_generic_cond(tee_supplicant_t,tee_supplicant_qtee)
++storage_write_scsi_generic_cond(tee_supplicant_t,tee_supplicant_qtee)
++
++tunable_policy(`tee_supplicant_qtee',`
++
++        # Access qtee_supplicant to request sys_rawio capability
++        allow tee_supplicant_t self:capability sys_rawio;
++
++        # Allow qtee_supplicant to block system suspend by wake_lock
++        allow tee_supplicant_t self:capability2 block_suspend;
++
++        # Access qtee_supplicant to open/read /sys/firmware/devicetree/base/compatible
++        dev_read_sysfs(tee_supplicant_t)
++
++        # Access qtee_supplicant to write /sys/power/wake_lock
++        dev_write_sysfs(tee_supplicant_t)
++
++        # Access tee_supplicant to read /var
++        files_list_var(tee_supplicant_t)
++
++        # Access qtee_supplicant to visit /var/lib
++        files_list_var_lib(tee_supplicant_t)
++
++        # Access qtee_supplicant to access /proc/cmdline
++        kernel_read_system_state(tee_supplicant_t)
++
++        # Access qtee_supplicant to send logs to systemd journal
++        logging_send_syslog_msg(tee_supplicant_t)
++')
+diff --git a/policy/modules/system/init.te b/policy/modules/system/init.te
+index cb9c3d97a..141095ac8 100644
+--- a/policy/modules/system/init.te
++++ b/policy/modules/system/init.te
+@@ -1523,6 +1523,10 @@ optional_policy(`
+ 	sysnet_read_dhcpc_state(initrc_t)
+ ')
+ 
++optional_policy(`
++	tee_supplicant_var_lib_filetrans(initrc_t)
++')
++
+ optional_policy(`
+ 	udev_manage_runtime_files(initrc_t)
+ 	udev_manage_runtime_dirs(initrc_t)
+diff --git a/testing/sechecker.ini b/testing/sechecker.ini
+index 865a3cf8b..ab62696f2 100644
+--- a/testing/sechecker.ini
++++ b/testing/sechecker.ini
+@@ -221,6 +221,7 @@ exempt_source = abrt_t              # Conditional access (allow_raw_memory_acces
+                 sosreport_t         # Conditional access (allow_raw_memory_access)
+                 spc_t
+                 sysadm_t            # System admin role
++                tee_supplicant_t    # Access qtee_supplicant to request sys_rawio capability
+                 udev_t
+                 vbetool_t           # Conditional access (allow_raw_memory_access)
+                 vmware_t
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..6154211 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0059-tee_supplicant-Add-necessary-SELinux-policy-for-qtee.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.34.1


