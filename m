Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9240.1794472815976732027
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Nov 2026 00:40:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=flvdmstY;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: wenwfu@qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZQ9h4092474
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 08:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nGQKT7k2EsQ
	SbPj1ejGpcQhqP1WoTykK/sPRl/xBZbQ=; b=flvdmstYW0Gh3DYSanMkvG9SiNj
	9hJAkyjz9SbrCbe8f4u3veQTC3twxaUpu8/IaVfPXyjnbfFn2xuKcnuOAzYZU3Wf
	y9prlReR11/d5vDzPDte6F51lLqgQU1mFRzXcNOJFMgyudohn2vDAD8wSFoIiy4J
	W6eQe4KsV+QG4eme/W28PKX/DdDM7bXYzASr58I1LbJIcFPRujKLdLKapMsTcr0t
	u7Dc4p8dGlkNHXAYVKRv+PmDHxRUU/Qn9Tjh8aHOVxZWWMhIwEm5PW4jp0f/XCFw
	nyERWNVTCMTRShhQ/fK+L7h4DWvq+/PALL5PUeJfX2af76hUi1yOept0GaQ==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw0m8j083-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 08:40:15 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8eDRW4142907;
	Thu, 12 Nov 2026 08:40:13 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AC8eDM24142893
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 08:40:13 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id 37AD3AC6; Thu, 12 Nov 2026 16:40:12 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [meta-selinux][wrynose][PATCH v2] refpolicy: backport perf event access for unconfined domains
Date: Thu, 12 Nov 2026 16:40:10 +0800
Message-ID: <f5bcd8a79a7056170c9c66855b032d44116490ee.1794472623.git.wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112055125.704676-1-wenwfu@qti.qualcomm.com>
References: <20261112055125.704676-1-wenwfu@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNCBTYWx0ZWRfX5h0vc7UYS25/
 r+yznKPljxAk6aLoG+L1SptvF9dKFMb0zkzo+gTxfOoWRTVo+PQAf1vybccdQCznqk6worY9r8Q
 i0Ft03hIE57oAH2E6yoCAjGg3WlI1y4=
X-Proofpoint-GUID: QdLIYzVbR9e5XCs-NLWNSLPUusfUkLK-
X-Proofpoint-ORIG-GUID: QdLIYzVbR9e5XCs-NLWNSLPUusfUkLK-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNCBTYWx0ZWRfXzsKo2dD4vuql
 MsftOkwhyGRuN7SDBBpFS2c8nnErFqzavI4HlVxee1WL6kVJr2oQafedOcVbS0yUehAwTYZYxmK
 xIuzbYj1ZQz5eNbn6xC02aUHTKGe/CWaFEP9Yj9jGqmxwFPK9yRQVnSYOQCfGn/oHn4n+jCZuPC
 8EthRuMX0RU/jAjlIQRwoxcseck9al6LityBvuchAr+riJB+vCwb02/6nP7bGldUfBy9/s1zCq2
 HcGSYkrad+0X1RL90jkGNl30kYmCihx11YfmJFt3x1WsmY+KJYHy0sGUE1ok16iP8ThWA5Y7JWr
 5FNEXx8waBKD8+dAllhDSUTlLp3jPfDt2WBM871OtpbJTfsbhFvnUOYzVsn3uumVxWYbbKyc1C3
 2ipYvgeb55D9vvX8kZxh7H3L2zkraU7eLPiz8MGiPVTfklhRWlrVcJuGgfhe0fr0DfBeMcie3MB
 abim4WLQ31RIDvqDv6Q==
X-Authority-Analysis: v=2.4 cv=Q9dHcI2a c=1 sm=1 tr=0 ts=6af57b6f cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=fqrYdtU1U6kGs9OrIBwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120034
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 08:40:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5322
Content-Type: text/plain; charset="utf-8"

Unconfined domains lack the perf_event permissions needed by perf to
collect performance counters and tracepoints with SELinux enforcing.

Backport refpolicy commit 6072cfa851a3 ("unconfined: allow perf event
access for unconfined domains") to allow unconfined domains to access
their own perf events.

Apply the patch in refpolicy_common.inc because all refpolicy variants
use the unconfined module.

Assisted-by: Codex:GPT-6
Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
Changes in v2:
- Apply the patch in refpolicy_common.inc for all refpolicy variants,
  as suggested by Chen Qi.
- Renumber the patch to 0059 and truncate its filename to 63 characters
  to follow the shared patch naming convention.
- Update the commit message to describe the shared scope.

 ...-perf-event-access-for-unconfined-do.patch | 35 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 36 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-unconfined-allow-perf-event-access-for-unconfined-do.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-unconfined-allow-perf-event-access-for-unconfined-do.patch b/recipes-security/refpolicy/refpolicy/0059-unconfined-allow-perf-event-access-for-unconfined-do.patch
new file mode 100644
index 0000000..a356218
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-unconfined-allow-perf-event-access-for-unconfined-do.patch
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
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..d896d88 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0059-unconfined-allow-perf-event-access-for-unconfined-do.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0

