Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F10F0181D
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 09:56:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.62290.1772768855520868897
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 19:47:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=WrO8onBw;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=AqBmuaV6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: wenjia.zhang@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625Kmavh3726033
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 03:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cjviL1AjmE1qhbTHP+ix3KMf8pLtm9q8OQc
	7qEQXs+s=; b=WrO8onBwxyGFlsNAWtRT8iW/eS9T+kZVrmi6SDx96hrLOtKc80p
	GraWlg6GjIBveFKif+fI4aMY1K8k7lOYkeaoO30268Fokc5oHJ71rYaUSh9OnYXw
	ZFtdQtECVm+tAhQnCEQfxFxl0/Fi17qiKqHVEanJ3m7ddCTEXYidH9eXyeHTIkp4
	LGOP53s14bGdbKqeHJkTjej195czyAh1Bke6qjYFwyjQCeiU1EhNM/pv3pjkgK6+
	vUoAVYcKafIEuH8CyCU5anoaBrW3LPeRQE0H0WXbL90TVg9rvO3xI4ygEJpyELua
	g7GXJudMj2PWAAaKYlQN8s9bTiHZzKOdmWQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq85dk3cb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 03:47:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3598c05c806so5062925a91.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 19:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772768853; x=1773373653; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjviL1AjmE1qhbTHP+ix3KMf8pLtm9q8OQc7qEQXs+s=;
        b=AqBmuaV6c2yb1gQRIQLfQ63d1k/QXrGwYpm6it7J94AkSE5VU4oq+eKywArV/Lj5EF
         0FyA3U4tT5TLBUkXms95PZGQpW3DaCat+3bNpSX/u4vpfr0X6SFXLj0GO0sw7tO7b//0
         TBZLZKO/eR+zAutFmQG/2WdHLgZLbkCaSClrZHw8+oY8YXMG9XJBXFWWF7dk3bCArZ5d
         xwnK2Z97ypWkXo51fQmyhPYK/035FszuzQnUTwK/PLlyDdsFlkyUC+Ud47OxtyhTH/BP
         x3MWzZL8Pup62Ls7sDK28YuyDof7B40o0RGef8NUed+toAjcqX96bbCbLSgixyUG2WwV
         kf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772768853; x=1773373653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjviL1AjmE1qhbTHP+ix3KMf8pLtm9q8OQc7qEQXs+s=;
        b=vmUi7xf8XL3YJZroZYrP02twu9YgoK6FXYv0yDFeADgjtTcKwllO0UO1b1Qx72QnYR
         6Gxh3zdBFNopOXvLUcTKAZXBaBkKMvjlmvZ6Th9dv6gsiU0dpvS9cMYwNiXKT9EEMIF/
         8uOwhCVyJ1Huww1rZpvURkJHOoiTM8SETTLEs+uNvOYeAQbfYFxfqp8o5KDT9sUMaDSa
         lOwWwv/DcOLvxW8C+f5BZfegVHhoBgIM6VuB/CB1eLH4eV57UvOaGLdCjPE92OHb+afJ
         Rr5a4p09X+ude8LlowxtPk9gVBS+IIqFOC9/wfM/aAgD8eIkWZIIZefShmQ1nqa9Z6e6
         iVFA==
X-Gm-Message-State: AOJu0Yz4NszgJqu0uzk9GHZ2gWCwgDTKcXlD09zREHwNwR5rqQZJIr+x
	rbPxU3nJYgUkHP5L44hg1v4xZLglZpjOgnZiG3xuW7meWkp2b+zTxlWuPMlo03DQeQQ8cIFbtNx
	BfburxYBj+cHT0G7loORpD1NWauBhwoW7JL+Uo/DVTlZIhsJsECu6EehQQvSkpkHc60TSDlm5+f
	ELEnwTZFSQ78HU
X-Gm-Gg: ATEYQzy7jrkfz8fFJsOH0HciJddsYPMQ6UnOFg1D+klK7/OIP0mMA+cSu8plD0gXLTP
	d9B6Fzu3Gs+cqCu9UAO0Po2rdoEuwiyFABizKjv//yZ46usQexHtx2MyaOw3PbudQbDAdfCQ2jx
	JRjSDYzrDxT6SshRK/1sDRPMwvIRjplgXSUzChuRx8xQhYxkGu389dYF2HcYFSUFGReoGhuDGD2
	hrl5PndKTtz1Jtj2t4SfSJbyUesySvb7SSfQl5FP0+MOdhPzI3mWBEalAEfXKDtpQocGM3wa3hh
	FkVmU+lMH4gIfqrAdCJmhis2sJ9B/OjFgOyy1YAL6dsdeOc93SCb2tT0/+ay4EXDnY2qDMqXVxi
	JH9fSZuxt+6fazDDp6IHKsjiG/Slmmv7OPhUH6r0iykjr8PGRdZk=
X-Received: by 2002:a17:90b:2685:b0:359:9016:1e72 with SMTP id 98e67ed59e1d1-359be2f0424mr687819a91.19.1772768852789;
        Thu, 05 Mar 2026 19:47:32 -0800 (PST)
X-Received: by 2002:a17:90b:2685:b0:359:9016:1e72 with SMTP id 98e67ed59e1d1-359be2f0424mr687777a91.19.1772768851924;
        Thu, 05 Mar 2026 19:47:31 -0800 (PST)
Received: from hu-jiaxli-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c017adacsm194142a91.14.2026.03.05.19.47.30
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 19:47:31 -0800 (PST)
From: "Wenjia Zhang" <wenjia.zhang@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] Introduce a new SELinux domain for the Qualcomm tee_supplicant to ensure proper labeling, isolation and access control under the target refpolicy.
Date: Fri,  6 Mar 2026 09:17:19 +0530
Message-Id: <20260306034719.1998371-1-wenjia.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: KUH5-xrygsAFlx2mXtOfhTbuPivpFMJ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDAzMyBTYWx0ZWRfXyfwIdqWwoS8a
 nT+b/mydmp+zOrVkCJA5BaoRCi5S6nBkOW1tcEXEAMF9FzdnrhscWSlVBIgWHM2kzT3cPnhdfzU
 QciuTAe211n3Zp+XwPRLsIrBmKP/cFJKUIlg8+tTxjm6FO109lC56yz/b8seCLntbZUObCLoS+E
 WnobmhkradQI5RKmboyqaU2bZAYX5RHRW83G2GysB1i2HQYmtaL54h5FkWFMLxueIb0sW1/B4Hg
 fIdSpnQKu2zIz51fmxuJir88Ipb/zB+YS9IicubU4uZRNgel6QVNhLf1oWMd+AOg3rHk3HcmMs1
 P2xERia6afEZTg91tY24mluOHPlZybGOYdOAclcconNtDhXEbprksjMAQRh6/0HQqF1Kd3k/rQH
 JlyUfL3AoOzU4pE7Ki5zuTpsDJXw4vIB/vMAhQWCJDZdzsR8YMJ/icb3Vhp/89L+8IJLNkmOegs
 2YPINkhm1T0V2pkKOGQ==
X-Authority-Analysis: v=2.4 cv=aOb9aL9m c=1 sm=1 tr=0 ts=69aa4e56 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=uZKo6Mtd0XcEDfeS:21 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=49L4cLvq_xSvqz98S1oA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: KUH5-xrygsAFlx2mXtOfhTbuPivpFMJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603060033
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 09:56:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3342

Signed-off-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
---
 ...ntroduce-SELinux-domain-for-tee_supp.patch | 105 ++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |   1 +
 2 files changed, 106 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch b/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch
new file mode 100644
index 0000000..f921e16
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch
@@ -0,0 +1,105 @@
+From b2f7220034bd340574d14222e88cb762f56bafa5 Mon Sep 17 00:00:00 2001
+From: Wenjia Zhang <wenjz@qti.qualcomm.com>
+Date: Thu, 5 Feb 2026 13:48:10 +0800
+Subject: [PATCH] tee_supplicant: Introduce SELinux domain for tee_supplicant
+
+Define a dedicated domain (`tee_supplicant_t`)
+to confine tee_supplicant service, ensuring it operates in
+a restricted environment isolated from other init processes.
+
+Define a inferface of /dev/tee[0-9].
+
+Grant the read and write permission to tee_supplicant for resolving
+AVC denials in enforcing mode.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1082]
+
+Signed-off-by: wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
+---
+ policy/modules/kernel/devices.if          | 18 ++++++++++++++++++
+ policy/modules/services/tee_supplicant.fc |  1 +
+ policy/modules/services/tee_supplicant.if | 10 ++++++++++
+ policy/modules/services/tee_supplicant.te | 17 +++++++++++++++++
+ 4 files changed, 46 insertions(+)
+ create mode 100644 policy/modules/services/tee_supplicant.fc
+ create mode 100644 policy/modules/services/tee_supplicant.if
+ create mode 100644 policy/modules/services/tee_supplicant.te
+
+diff --git a/policy/modules/kernel/devices.if b/policy/modules/kernel/devices.if
+index dd8072f37..bbdb45b98 100644
+--- a/policy/modules/kernel/devices.if
++++ b/policy/modules/kernel/devices.if
+@@ -5032,6 +5032,24 @@ interface(`dev_setattr_all_sysfs',`
+     allow $1 sysfs_types:lnk_file { read_lnk_file_perms setattr };
+ ')
+ 
++##########################################
++## <summary>
++##	Read and write the tee device.
++## </summary>
++## <param name="domain">
++##      <summary>
++##      Domain allowed access.
++##      </summary>
++## </param>
++#
++interface(`dev_rw_tee',`
++	gen_require(`
++		type device_t, tee_device_t;
++	')
++
++	rw_chr_files_pattern($1, device_t, tee_device_t)
++')
++
+ ########################################
+ ## <summary>
+ ##	Read and write the TPM device.
+diff --git a/policy/modules/services/tee_supplicant.fc b/policy/modules/services/tee_supplicant.fc
+new file mode 100644
+index 000000000..9c6e77836
+--- /dev/null
++++ b/policy/modules/services/tee_supplicant.fc
+@@ -0,0 +1 @@
++/usr/bin/qtee_supplicant      --      gen_context(system_u:object_r:tee_supplicant_exec_t,s0)
+diff --git a/policy/modules/services/tee_supplicant.if b/policy/modules/services/tee_supplicant.if
+new file mode 100644
+index 000000000..e22a531f5
+--- /dev/null
++++ b/policy/modules/services/tee_supplicant.if
+@@ -0,0 +1,10 @@
++## <summary>tee_supplicant</summary>
++#
++## <desc>
++## qtee_supplicant is a userspace supplicant daemon that
++## services callback requests from QTEE via the Linux TEE subsystem.
++## It communicates with QTEE through /dev/tee0 and provides normal-world 
++## services required by trusted applications running in QTEE.
++##
++## https://github.com/qualcomm/minkipc/tree/main/qtee_supplicant
++## </desc>
+diff --git a/policy/modules/services/tee_supplicant.te b/policy/modules/services/tee_supplicant.te
+new file mode 100644
+index 000000000..2d5905318
+--- /dev/null
++++ b/policy/modules/services/tee_supplicant.te
+@@ -0,0 +1,17 @@
++policy_module(tee_supplicant)
++
++########################################
++#
++# Declarations
++#
++
++type tee_supplicant_t;
++type tee_supplicant_exec_t;
++init_daemon_domain(tee_supplicant_t, tee_supplicant_exec_t)
++
++########################################
++#
++# Local policy
++#
++
++dev_rw_tee(tee_supplicant_t)
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 2e1a929..e3d38ee 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+		file://0059-tee_supplicant-Introduce-SELinux-domain-for-tee_supp.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.34.1


