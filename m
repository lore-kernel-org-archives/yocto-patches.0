Return-Path: <jaihindy@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9D0CD5BD0
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 11:46:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18602.1779882357257585300
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 04:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=pdg2bzl+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: jaihindy@qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mQG7871133
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 11:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ADCP0omxsIM0KaUhWiO3Te/LkRltAky6vBv
	4dIbtV30=; b=pdg2bzl+LidTrt+bsSUt8Y5iynyy1iKLwWgCddJ9cRz8T6arLUM
	kVnv6V6swj7jw46DHO1Z45fzsETNZGMfuBg0bM9T6MkihZSkY5X4IBOElhuwCy8S
	YFvxDTPOQfm++IBDk6wOWSZbGlS+pY3bFCePSBgcCzMfXlriIbG3/RyFIew67Mj7
	zrvz+s6tmn4uhclpfg6Y0pFWRulrsltSYx7OVNWo33RrafVRvq9YtbGKAi+Qukmr
	1HyI4cj3EUbNrxQSe4I59YEvqUhJeW48LJKvHouBfqQrUxtQncZNL4uXlWwhuwL1
	N7QDh3cfXt0zFCuusdxuAHebV62Rn98Iyvg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eduru928d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 11:45:55 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RBjqX7010161;
	Wed, 27 May 2026 11:45:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajm09a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 11:45:52 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64RBjpL8010156
	for <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 11:45:51 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-jaihindy-hyd.qualcomm.com [10.213.102.234])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64RBjpuM010155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 11:45:51 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 448081)
	id E93942195E; Wed, 27 May 2026 17:15:50 +0530 (+0530)
From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jaihind Yadav <jaihindy@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] refpolicy: allow seatd to use unallocated TTYs
Date: Wed, 27 May 2026 17:15:49 +0530
Message-ID: <20260527114549.1010287-1-jaihindy@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=VY3H+lp9 c=1 sm=1 tr=0 ts=6a16d974 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=FKyT-rSJxFxOsl4oL50A:9
X-Proofpoint-ORIG-GUID: NPKqY-NxHgZVz8CKAmsguNs4TYPZ5LHz
X-Proofpoint-GUID: NPKqY-NxHgZVz8CKAmsguNs4TYPZ5LHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDExNCBTYWx0ZWRfXyS604rm3UJsj
 fqEcOrhj4mHa0nRvXnYYvlJQaQ0Vb1jUipqvn8A/ExwemVYhPLsQDuJYKXApwG2bkQS9tIFhWym
 rBduzKiSsID9PBSAqHsQ316M9dT7F1nU+VxkcMpydA1P39UF/rGod+ZWQxD/lqwh5WjwjjZWqwH
 toAR/bDfxv768FMFWJKJ7Uh5637uKPsYzcYJIe2xn2d07kktAQOWbyKkS1JDZJm1wOq5TjSXDeQ
 dnAplHWSNICkmObW9t3/bFiImDf469zXv1/X0C4p3bXuiC40Y6KXG19GndmAcM8BptzT3S4/Viq
 BctvhyDi2BqklsZX4KUXReXgxs+FUyP2qTIQmakpgZ7GOPq+bGJ1yagAOFk0EmuIscYHsddPKBL
 jOeNcohZPozYCAfkHDIxn7zticvOVjsE7FMOYs7VSIB53xn4g6QT5+WjreJSHAy80j5iUAL+SM7
 A+gXgqpPxPoCvesWUgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270114
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 11:46:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4073

seatd requires access to unallocated TTY devices such as /dev/tty0
to manage seat activation and VT handling for Wayland compositors.

Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1114]

Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
---
 ...ervices-seatd-to-use-unallocated_tty.patch | 27 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0060-policy-modules-services-seatd-to-use-unallocated_tty.patch

diff --git a/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-seatd-to-use-unallocated_tty.patch b/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-seatd-to-use-unallocated_tty.patch
new file mode 100644
index 0000000..b5bc03b
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0060-policy-modules-services-seatd-to-use-unallocated_tty.patch
@@ -0,0 +1,27 @@
+From 9b060b28f151316c38dd16068644cbd04969e93d Mon Sep 17 00:00:00 2001
+From: Jaihind Yadav <jaihindy@qti.qualcomm.com>
+Date: Tue, 12 May 2026 11:23:17 +0530
+Subject: [PATCH] refpolicy: allow seatd to use unallocated TTYs
+
+seatd requires access to unallocated TTY devices such as /dev/tty0
+to manage seat activation and VT handling for Wayland compositors.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/pull/1114]
+
+Signed-off-by: Jaihind Yadav <jaihindy@qti.qualcomm.com>
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
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 6f528d5..9e3b672 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -75,6 +75,7 @@ SRC_URI += " \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0059-policy-modules-system-init-allow-ModemManager-to-sen.patch \
+        file://0060-policy-modules-services-seatd-to-use-unallocated_tty.patch \ 
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0


