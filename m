Return-Path: <sasikuma@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588F5CD6E45
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 04:10:17 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3936.1779941407880990607
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 21:10:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=IhwlHcu/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKnJSG3010208
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 04:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TNjNbvjmT21MCcdBB80/kja5JuxKgDxIYML
	0Bjlf/L4=; b=IhwlHcu/BLxRdDEG4uU9Yz8cC9f7YalRmiHeLf8ZabpFeZZQpbl
	y5NS3sHZtxrO5kMfWZhOfugVFCc3b3SrbZdNNAmoL9B1zGt37jJtpkIysK2NyG4Q
	F8au1bqDZcowTRnWEbNgRI7MfyX5VHncYv5RRuCTvBnAMCcvH9/qUhWmcmwpDPCr
	YJq68tSimLplwdbHvFfFVZleZSE+LD7JeUH7y+sxdHaiRS7CTUZYy8M3bdc9ofn+
	1RbSyFeUnZLJmGbdjZ7+3ha8VOb3QkcXIKonZkTJa7cM1ZVpjeXDQOk7vpeI0ZBR
	BdKUmyxn8682j3drfFEKQ8kiguScrp9JqkQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yrh9b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 04:10:07 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64S4A2mN026257;
	Thu, 28 May 2026 04:10:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajw10x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 04:10:02 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64S4A2CA026236
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 04:10:02 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64S4A2g1026211
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 04:10:02 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id A89DC21C1C; Thu, 28 May 2026 09:40:01 +0530 (+0530)
From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>,
        Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] seatd: allow seatd to use unallocated TTYs
Date: Thu, 28 May 2026 09:39:57 +0530
Message-ID: <20260528040958.2201296-1-sasikuma@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAzNyBTYWx0ZWRfX1euL7U1dBnq+
 SAww62tJzczn6ihwUy5FGYHm19/MU/4o+mIBEYR4wo1JaDVWAS0wlZp+L0DT1r1lUKoEfx9yXxG
 BFtSMiXSdwcvfFqDkoFC0aFsTG/4uuV/TiuvNC+bUEEVckyMHf3ALrfrBC7N413wPNduRryVXoH
 3nUYbCKqg+ezsijpC5+zLGCsWxrf32ro1I17PeCZ0KQfuffb74XlhdvZo8saGbfzYW4hg6O1lxd
 TTsxcEYt14J7wh2MQT4pUfU1rOwlDjjX7qqm63JjrVC6uhuyKbkG9e7qO2jxUF2n0J74jjPXi2r
 RCiUHLtLRBDUhoSow8rHB3DDF91KWNifhuxB9lTaW3XF+4frPwKc2zblULPJD/c4+iK4a5Fdr/C
 IVy24fO2HDweIgDHzmtn2p9gnVLIyiyPYTLxD+zWiLwh40uhfu/2f27EBLKgbdp6B7l6t/0Awv2
 Bdjlf28spthXw4YxtMQ==
X-Authority-Analysis: v=2.4 cv=PLo/P/qC c=1 sm=1 tr=0 ts=6a17c01f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=FKyT-rSJxFxOsl4oL50A:9
X-Proofpoint-GUID: EoTsSDKigoi4eSU0W80cr4_0GUVmy4ik
X-Proofpoint-ORIG-GUID: EoTsSDKigoi4eSU0W80cr4_0GUVmy4ik
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280037
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 04:10:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4078

seatd requires access to unallocated TTY devices such as /dev/tty0
to manage seat activation and VT handling for Wayland compositors.

Added policies to allow seatd to access unallocated TTY devices.

Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
---
 ...-allow-seatd-to-use-unallocated-TTYs.patch | 33 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 34 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0062-selinux-allow-seatd-to-use-unallocated-TTYs.patch

diff --git a/recipes-security/refpolicy/refpolicy/0062-selinux-allow-seatd-to-use-unallocated-TTYs.patch b/recipes-security/refpolicy/refpolicy/0062-selinux-allow-seatd-to-use-unallocated-TTYs.patch
new file mode 100644
index 0000000..3554295
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0062-selinux-allow-seatd-to-use-unallocated-TTYs.patch
@@ -0,0 +1,33 @@
+From ebafd639e8d3847d0c8c2313c71994c4ea5e1501 Mon Sep 17 00:00:00 2001
+From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+Date: Tue, 12 May 2026 11:23:17 +0530
+Subject: [PATCH] selinux: allow seatd to use unallocated TTYs
+
+seatd requires access to unallocated TTY devices such as /dev/tty0
+to manage seat activation and VT handling for Wayland compositors.
+
+Added policies to allow seatd to access unallocated TTY devices.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1114]
+
+Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
+---
+ policy/modules/services/seatd.te | 4 ++++
+ 1 file changed, 4 insertions(+)
+
+diff --git a/policy/modules/services/seatd.te b/policy/modules/services/seatd.te
+index 44ba85ee7..d539dc446 100644
+--- a/policy/modules/services/seatd.te
++++ b/policy/modules/services/seatd.te
+@@ -32,3 +32,7 @@ auth_use_nsswitch(seatd_t)
+ 
+ dev_rw_dri(seatd_t)
+ dev_rw_input_dev(seatd_t)
++
++# seatd requires access to unallocated TTYs (e.g. /dev/tty0) to manage
++# seat activation and VT handling for Wayland compositors.
++term_use_unallocated_ttys(seatd_t)
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..87c9e39 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0062-selinux-allow-seatd-to-use-unallocated-TTYs.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0


