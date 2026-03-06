Return-Path: <wenjia.zhang@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC99F51405
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 06:19:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.63989.1772777949351893760
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Mar 2026 22:19:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=hcDeRWhv;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=RbxA6vh+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: wenjia.zhang@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aVVp2483075
	for <yocto-patches@lists.yoctoproject.org>; Fri, 6 Mar 2026 06:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=cjviL1AjmE1qhbTHP+ix3KMf8pLtm9q8OQc
	7qEQXs+s=; b=hcDeRWhvgsUZGlsj1tQkERlgz/4ntRdH77gKnODNg0ZddABp6Gf
	05hn2JywjJIhcuSSs1HMDp1dU5aKcQc7YKiLz18O4B1GdSNNKJ0WViIXyIArObol
	izr8UApMEw60yehc/eIC/9u5Vt83d5iMgyRpaIQkVNVDkdQy5qMGMI9qiOQadp81
	lsntl6Hdeq6SkpXMhW7PfMhyf/Yw/5SNSaDGuPyyFY3UvIPi/+CrO/yN7u35gMLR
	f92GjKmW83YWQS9YivlQ9vN+Y8s44g0iUO2UhAGrAeqld0nH93HDYHQJ3/nIC3aC
	uAqUBAcQy56oT4OpKs/EhlfMqvT6u1FcNQQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq84wbfmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:19:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae66ee7354so31458355ad.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Mar 2026 22:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772777947; x=1773382747; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cjviL1AjmE1qhbTHP+ix3KMf8pLtm9q8OQc7qEQXs+s=;
        b=RbxA6vh+UgvzWWqabDx+PkriSU3LOeolzarL+Pe/iI7cHTlDytF9/HWgqShYECEeaz
         WMHrFnO+3QQnNpeELqRIfb6F2t5jNOVaYgWqB+P+VWGCE68+0mNGTN8ZVptZLsVDZMxQ
         SCqKYY9cXy/eKJCIWHJeiNBBrRTuGbVSOX0gwMTf0U1Jzn9t0Eezk7VoybGllWkdzPfk
         oHSNkPP+3jNpXHsJWKiShnsqd0Ii5miO0PEbVelarnYoy9XIbrtoO4QFbgb2eH7AclWy
         5s8YqqGUZglBctP5WW9WLjKDheLlzU3mRFl6taHN9sV1evvYxCMYyt60nWMI3aEydWGI
         BcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772777947; x=1773382747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjviL1AjmE1qhbTHP+ix3KMf8pLtm9q8OQc7qEQXs+s=;
        b=dAXQRYG+MHalHYx0nthGA+kPCAUX3M2JnprF1xSLrCUlbb/HITmdXgILoQk1VnNBE6
         T1DL6QvmavLQ/9cgzTZoMvWiJYqabAiNV3YdMKFbqVkjrax2qxVhjrvdTbbtS+DhyjxE
         JIfxTFRLpsi0jfygv1NM/2oWNCQzFX7CFkTeC7QcwHPiZLYE2jtsisOw94T17bZwZbaP
         kkZlr+rafFedN8coZUL6FweeBScwv1khMKAekYvYRcTXFTugo3avVYM/AgCpIsvBOB8s
         nyY65Yc4e1R+OsY5EfFI0xoizBJOJbrqjRFxe5cRdygKeLpZy6GWtNBPmCs1zonf5vt8
         QlMw==
X-Gm-Message-State: AOJu0YxRVp/7OdFUPn4TO0vSmPB8xH0rep/4CipSneZ2R3DzT7vKhz2p
	qGvXeUtCpAeU/ZXChOYFGez33dBt14brVIGDCBt+UtfCGYRRfl31EEMg/3DLF2H52CIjhNQOABc
	+Df2QnfKeoxqy06hY7xV0/Dm2Esi5eaQE/lbbukjLcANr63Nif9pmhOQNVC0hpxaKI8bzm24nBI
	sMqvuEsfmHe42k
X-Gm-Gg: ATEYQzxUerYlVYxOA8ezwjv1ry93elPfB++GHsnY2PUsLO1f9izHrXBd/zqFmIoMFuY
	CwIRJ2xaQK4v2grxOB8tcRgkzT26oiLV9AbkYz8tngVD9mlCuYy6P8c/RXwmxwkFptdekF6xQ4k
	0ijU8itXbl5xFAy9lgEcK93DIn6ueYAdBc/gVIMIGo5SBO/26uy+HqFi9LDXbPBHbqYFZ5rvTY4
	UCqfl3/Y/i2EKHGESNvfgzi0358ZA7eGbE175w1DZAh6sqQvQiPJYzgD2pTHO+2c/uN6rb6Uzdx
	0PMwEL33bY0wySP9cbrwiFPR3pBgJ+2iDE0gz4s1rbMaHdETRw30bPqilK1sTFqawgyJR15N9wb
	aBOiOEoFCRbBF/k9lDnDyje2uFiI00/EH+ThCuaLt/00aCUHC7L8=
X-Received: by 2002:a05:6a21:4584:b0:35d:58d3:2904 with SMTP id adf61e73a8af0-39859003297mr1160375637.31.1772777946697;
        Thu, 05 Mar 2026 22:19:06 -0800 (PST)
X-Received: by 2002:a05:6a21:4584:b0:35d:58d3:2904 with SMTP id adf61e73a8af0-39859003297mr1160354637.31.1772777946019;
        Thu, 05 Mar 2026 22:19:06 -0800 (PST)
Received: from hu-jiaxli-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48b437fsm595201b3a.52.2026.03.05.22.19.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 22:19:05 -0800 (PST)
From: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] Introduce a new SELinux domain for the Qualcomm tee_supplicant to ensure proper labeling, isolation and access control under the target refpolicy.
Date: Fri,  6 Mar 2026 11:49:03 +0530
Message-Id: <20260306061903.2080456-1-wenjia.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WKEnFC2rbwuY49b_WdzyrtVuBo50q4qV
X-Proofpoint-GUID: WKEnFC2rbwuY49b_WdzyrtVuBo50q4qV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA1OCBTYWx0ZWRfX0mJ8uiukaUBI
 FpWmQN8/t0MAQg1C7AnhCeIljvVyGAd2FkhkprCmoebclHXxCEA2jVCtSCNVkQMt5xxG7lIn9mD
 oFI9kal3wzjC/+Oj0wL9wt1oGC8CtYE/afRlGZcnRe5scHX3Yl7pmQt5FuWQS5P0NzN0POaiexO
 nuPf+HIZHjZb7l+5iD+FO629CTJnLaAyjZGNKspceIP9cYufTq9ZF25V+IBww1mN+uyD0kao2kn
 wWNx1wHUm+L4kkKWkMe4RtUb3kKhUZ8utsZv2DE2DxAYiBfDmKKc8xS9lPc65H3owPlnZQqZgt6
 6J+GdVkayZPr06nSdfOW8o6ssTLadfpCc9szkthIbz2D+W4kgzgHEdcWZhJFXf+gOohkXN6i1+e
 qM5KQEL+QTLXNsS7dmDWQof5HEm/wZxEk84Az7RPVBe1hkwsZvAl6ggtFqaLHeqsFtp0aTl5EQm
 /2yISw61wIYMF5uprww==
X-Authority-Analysis: v=2.4 cv=N64k1m9B c=1 sm=1 tr=0 ts=69aa71dc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=uZKo6Mtd0XcEDfeS:21 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=49L4cLvq_xSvqz98S1oA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060058
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Mar 2026 06:19:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3340

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


