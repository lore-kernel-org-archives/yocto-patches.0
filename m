Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5467.1794451464799556020
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 18:44:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=nBCToQlS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: wenwfu@qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZoHx597550
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 02:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sL7KiXzvl8JajzbeQLjbWbguqs6DJ03IlhF
	VIcumbLY=; b=nBCToQlS4vCRmyzCakccdsgpdfyZESjvQGLHcc6NV9TaWIZwC7H
	I9Ch9ayLsG+DJralhYNQpj8Q7fUv/sMLHOBMy3jXJCxM6DaEVNbDqKrp2DxirA+w
	+Y+FlfelA0VcCrtnrBYj2MLp86APD1nRj7wRy/E2YtS1NLIy/DClkvbAV3WnNOkr
	UpeRCbt/iE4LFdQFFl9Wa3eTWWulz62QgFcDCVd4/QzmcanHMjce2V52V+z+bSM3
	7BCpjHbQicvFSEc7wXlQT5PcuxWhE/0YguXLBEntr1YdAT4ntJwSfNBf1aieDn5d
	uVL1mEmaHjoIv1+8I1AMhWBWv9BwKNUaYWg==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt152p2v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 02:44:23 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2hl0R3702463
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 02:44:20 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AC2iJ443702823
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 02:44:20 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id 567CBAC6; Thu, 12 Nov 2026 10:44:17 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [PATCH] refpolicy: backport perf event access for unconfined domains
Date: Thu, 12 Nov 2026 10:44:15 +0800
Message-ID: <20261112024415.624864-1-wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMCBTYWx0ZWRfX4Wuq0Je/sPpt
 DgaiUc2RXM6UgOVE//d11e/IzINYjTkt6mVoqu1kKNOZDwvqmzqI8lt2qtmdT5J7LN+QzeGPC1S
 He2eMNqOUTKPMAdl23EnBgFQ7MEFYos=
X-Authority-Analysis: v=2.4 cv=Yrya1IYX c=1 sm=1 tr=0 ts=6af52807 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=oTP_Z-EQWkD7tdjTyAEA:9
X-Proofpoint-GUID: qEGviED5dJmXU7CLaKlNRtzG4rPe6lEv
X-Proofpoint-ORIG-GUID: qEGviED5dJmXU7CLaKlNRtzG4rPe6lEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMCBTYWx0ZWRfX3hW33USXyIM+
 TOokmnS2zrm/q1E28QxRPhJFYbgXwl5Dyb3JFrFUJOe5CvfBhRxDranKLo879ICcYKmgwD0oPcS
 NbLXt6ZzEMcA5kG8CTkLVeUmHKP4FSM/Fgg7QaYX0Q6ksAtx2P1Gwl+i8lwZoJRQh8wHweb+dSC
 eDG4nwAjkMYE0c6IWCYkQTPei53lhcHryjoAtPRTlhODxKgxSnmFLyWk8ySw/lL85DKh2hoYcs7
 S57hFi1EbcuQR6hi3gZ4/sNPQzmjx9jr/Pz45mrXpqNvGrulX6UPbrdCx2R0t6ldp7NyTHk++0U
 HtU8eqiYqmCmj1lS4bp7Z9a/C7rwP0/kwoR4LzL1julWIPMp7OpZffmToHitOHOdvUdAjB9+Ys0
 6pyo/3+hHQWQZtZBXEXPqt9cXAMsIXodW3WdQlIFLrtZn6uNxxKzi9/q6X8U0l+D7wG5f28c/fx
 wHb0N5pAkQlYONx5SgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120010
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 02:44:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5311
Content-Type: text/plain; charset="utf-8"

The refpolicy snapshot used by meta-selinux lacks upstream commit
6072cfa851a3, so perf cannot collect performance counters and
tracepoints from unconfined domains when SELinux is enforcing.

Backport the upstream change until a refpolicy upgrade includes it.

Assisted-by: Codex:GPT-5
Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
 .../refpolicy/refpolicy-targeted_git.bb       |  1 +
 ...-event-access-for-unconfined-domains.patch | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch

diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
index b4bec46..981f772 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -14,4 +14,5 @@ include refpolicy_${PV}.inc
 SRC_URI += " \
         file://0001-refpolicy-targeted-Revert-users-Move-unconfined_u-definition-to-unconfi.patch \
         file://0002-refpolicy-targeted-make-unconfined_u-the-default-sel.patch \
+        file://0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch \
         "
diff --git a/recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch b/recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch
new file mode 100644
index 0000000..a356218
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch
@@ -0,0 +1,35 @@
+From 6072cfa851a3598bfa86622dff9c680c2e662901 Mon Sep 17 00:00:00 2001
+From: Wenwen Fu <wenwfu@qti.qualcomm.com>
+Date: Thu, 5 Nov 2026 10:02:03 +0800
+Subject: [PATCH] unconfined: allow perf event access for unconfined domains
+
+Unconfined domains have the perfmon capability but lack complete
+perf_event permissions. This prevents perf from collecting performance
+counters and tracepoints with SELinux enforcing.
+
+Allow unconfined domains to open, read and control their own perf
+events, including CPU, kernel and tracepoint collection. Add the rule
+to unconfined_domain_noaudit() alongside the other self access rules.
+
+Upstream-Status: Backport [https://github.com/SELinuxProject/refpolicy/commit/6072cfa851a3598bfa86622dff9c680c2e662901]
+
+Assisted-by: Codex:GPT-6
+Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
+---
+ policy/modules/system/unconfined.if | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/policy/modules/system/unconfined.if b/policy/modules/system/unconfined.if
+index 6c48561238..c627d38dcf 100644
+--- a/policy/modules/system/unconfined.if
++++ b/policy/modules/system/unconfined.if
+@@ -59,6 +59,9 @@ interface(`unconfined_domain_noaudit',`
+ 	# for io_uring
+ 	allow $1 self:anon_inode { create map read write };
+ 
++	# Access own perf events
++	allow $1 self:perf_event { open cpu kernel tracepoint read write };
++
+ 	# Userland object managers
+ 	allow $1 self:nscd { admin getgrp gethost getpwd getserv getstat shmemgrp shmemhost shmempwd shmemserv };
+ 	allow $1 self:dbus { acquire_svc send_msg };
-- 
2.43.0

