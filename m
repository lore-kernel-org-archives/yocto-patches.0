Return-Path: <sasikuma@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6392CD5BD5
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 08:05:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6007.1779955528744480206
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 May 2026 01:05:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=amJacg/A;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S6Tdsi3011298
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 08:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=t91hTZMZVG7ZX2bENeU7OqbAustthH8sDxp
	McToN5Hc=; b=amJacg/AfdQZQB+60bZ7XEDLZhgopq8MjbG3fGw4zwKpgPpjaBF
	2bBNBdoRi0nDB+LKC0sp9jFcvRQCH1fA/KQQQE/M0L5sop8QmAcIMkT/5pdcpai+
	5F/50AVee8I8kaYglbWpXfOxHmi5ixw/tB93APzCGf7PULmXCnZi9pp0mReKhqRb
	c5hf8XFIaZvgkSKCkV8/o53a2I/7NsgjFNCAXLkV71mzx+8+8B5Nfmc85hPvXWXT
	C1BGAfuaovW0+YoP3KgyZuG8pAOKLKHcJJru14ktjqXKReHBtgApvUSRTosvs/j3
	+fxPjmSG9xKz7pBaW5vwhWNC1/DvjhLf08w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yrhwkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 08:05:27 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64S85NCf022050;
	Thu, 28 May 2026 08:05:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajy39b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 08:05:23 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64S85NdJ022044
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 08:05:23 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64S85N4B022043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 08:05:23 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id D05BA21C20; Thu, 28 May 2026 13:35:22 +0530 (+0530)
From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
Subject: [meta-selinux][PATCH/V2] refpolicy_targeted: Add op-tee based tee supplicant policy
Date: Thu, 28 May 2026 13:35:21 +0530
Message-ID: <20260528080521.2436277-1-sasikuma@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA4MCBTYWx0ZWRfX03lkOnKppgeH
 cUUe4ySyAdgyiYWcJz1HI6+V357HCzMCUnTj/j78gYNr7G69PPh5zUqFLWIh+xgCKGkID4cIIQ9
 RHbJ2u1hIinA32A/+YIKJErgiINmO17h3BtkYxz2rvao4s7wq4iEkTEcV9vnH8BGASXa80tsgf3
 +b/Ks1reAd0LGhBKID/ovKKEAudj9D6i/qxd5uFqHXbV4X/k/p0T2MY1zvlCcbu7+ZV95lmk3JD
 ain5s5Tv0fWfJx7RLBQ5ssF2O04C80ZOOqOMLb682UuI0jyOHX87dVZJzV4slf7J2zOfeuWrMe6
 rX13eHU6O/bW0sLwj0Ev8eCWOZqE4rWFn7w7gJ3JqYVA31XHucIrvgxPEj+ucSHcDcNphM/cYZ0
 W2EVhUb4Gx3AEl4ikZPCDUfAyMZxLLXoK0lm5qeAPUVwfTnOyuoX1PioFfJHa2qvb7w5SmqOa3r
 oj8Xqc5+9qeBCm5aosA==
X-Authority-Analysis: v=2.4 cv=PLo/P/qC c=1 sm=1 tr=0 ts=6a17f748 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=yMhMjlubAAAA:8
 a=beBsfdukaq1lzfkYcVoA:9
X-Proofpoint-GUID: ZiAllX4fDfAkM_gjbyD8VtQtIIj-UWV7
X-Proofpoint-ORIG-GUID: ZiAllX4fDfAkM_gjbyD8VtQtIIj-UWV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280080
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 08:05:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4081

Some of the op-tee required policies are missing.

Added required policies for op-tee.

Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1103]

Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
---
 ...d-op-tee-based-tee-supplicant-policy.patch | 83 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 84 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0064-Add-op-tee-based-tee-supplicant-policy.patch

diff --git a/recipes-security/refpolicy/refpolicy/0064-Add-op-tee-based-tee-supplicant-policy.patch b/recipes-security/refpolicy/refpolicy/0064-Add-op-tee-based-tee-supplicant-policy.patch
new file mode 100644
index 0000000..71f2eed
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0064-Add-op-tee-based-tee-supplicant-policy.patch
@@ -0,0 +1,83 @@
+From 0e76a2a30d459e9c8416225dc51280927d0f27b1 Mon Sep 17 00:00:00 2001
+From: Daniel Burgener <Daniel.Burgener@microsoft.com>
+Date: Wed, 8 Apr 2026 20:43:43 +0000
+Subject: [PATCH] Add op-tee based tee supplicant policy
+
+Some of the op-tee required policies are missing.
+
+Added required policies for op-tee.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1103]
+
+Signed-off-by: Daniel Burgener <Daniel.Burgener@microsoft.com>
+Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
+---
+ policy/modules/kernel/devices.if          | 18 ++++++++++++++++++
+ policy/modules/services/tee_supplicant.fc |  1 +
+ policy/modules/services/tee_supplicant.te | 12 +++++++++++-
+ 3 files changed, 30 insertions(+), 1 deletion(-)
+
+diff --git a/policy/modules/kernel/devices.if b/policy/modules/kernel/devices.if
+index a7ebcc922..1e4ec76e5 100644
+--- a/policy/modules/kernel/devices.if
++++ b/policy/modules/kernel/devices.if
+@@ -5050,6 +5050,24 @@ interface(`dev_rw_tee',`
+ 	rw_chr_files_pattern($1, device_t, tee_device_t)
+ ')
+ 
++########################################
++## <summary>
++##	Read and write the privileged trusted execution environment devices.
++## </summary>
++## <param name="domain">
++##	<summary>
++##	Domain allowed access.
++##	</summary>
++## </param>
++#
++interface(`dev_rw_tee_priv',`
++	gen_require(`
++		type device_t, tee_priv_device_t;
++	')
++
++	rw_chr_files_pattern($1, device_t, tee_priv_device_t)
++')
++
+ ########################################
+ ## <summary>
+ ##	Read and write the TPM device.
+diff --git a/policy/modules/services/tee_supplicant.fc b/policy/modules/services/tee_supplicant.fc
+index 9c6e77836..41b654268 100644
+--- a/policy/modules/services/tee_supplicant.fc
++++ b/policy/modules/services/tee_supplicant.fc
+@@ -1 +1,2 @@
+ /usr/bin/qtee_supplicant      --      gen_context(system_u:object_r:tee_supplicant_exec_t,s0)
++/usr/sbin/tee-supplicant      --      gen_context(system_u:object_r:tee_supplicant_exec_t,s0)
+diff --git a/policy/modules/services/tee_supplicant.te b/policy/modules/services/tee_supplicant.te
+index 2d5905318..0e0b67bc2 100644
+--- a/policy/modules/services/tee_supplicant.te
++++ b/policy/modules/services/tee_supplicant.te
+@@ -9,9 +9,19 @@ type tee_supplicant_t;
+ type tee_supplicant_exec_t;
+ init_daemon_domain(tee_supplicant_t, tee_supplicant_exec_t)
+ 
+-########################################
++type tee_supplicant_var_lib_t;
++files_type(tee_supplicant_var_lib_t)
++
++#########################################
+ #
+ # Local policy
+ #
+ 
++manage_files_pattern(tee_supplicant_t, tee_supplicant_var_lib_t, tee_supplicant_var_lib_t)
++manage_dirs_pattern(tee_supplicant_t, tee_supplicant_var_lib_t, tee_supplicant_var_lib_t)
++files_var_lib_filetrans(tee_supplicant_t, tee_supplicant_var_lib_t, { file dir })
++
+ dev_rw_tee(tee_supplicant_t)
++dev_rw_tee_priv(tee_supplicant_t)
++
++kernel_read_vm_overcommit_sysctl(tee_supplicant_t)
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 51ac1d4..e25ce7e 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -76,6 +76,7 @@ SRC_URI += " \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0062-selinux-allow-seatd-to-use-unallocated-TTYs.patch \
         file://0063-dmesg-allow-dmesg_t-access-to-init-script-stream-soc.patch \
+        file://0064-Add-op-tee-based-tee-supplicant-policy.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0


