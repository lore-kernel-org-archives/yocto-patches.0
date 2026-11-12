Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7636.1794462691881766929
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 21:51:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=PBviwpFD;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.180.131, mailfrom: wenwfu@qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2aVZF1475380
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 05:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b3FS4vet2AdxHbi1ul8mvRhfGCq7lLkfpFx
	Z9TRRKkE=; b=PBviwpFDWF1P6bLlsW8Xq/uI2Pdzh934bkB7hw0RagX2wewMkcs
	zGhoU9kNhGxIZV+1BjCEkF/diWM/r8UOdrfYNkx/ELkGk9opUKAifJRPsPRCADD2
	Ag37R2koP14tTt3itZ7VHPXvcEwalwxJQfQQ++z+rlXBYsRFiGLmFvwNC8Fkn6Rg
	Fb0Mn1Nd23dwmU6mFhkcxmWRAmxH2iwLDLM/hOmhbF+oJTCqB7F81yMiETvwALF7
	G39/q44cqInxcuv/9VJZ0GptfuWgmLKStXs/IRBslB5UGIAZSb1uG3drM/oYbdHG
	4V791JQMRHO8PtozM3YbAcnjxhYL1lONZyg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymtunx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 05:51:30 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC5pRad3935732;
	Thu, 12 Nov 2026 05:51:27 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AC5pRnQ3935724
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 05:51:27 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id 9AB9BAC9; Thu, 12 Nov 2026 13:51:26 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [meta-selinux][wrynose][PATCH] refpolicy: backport perf event access for unconfined domains
Date: Thu, 12 Nov 2026 13:51:25 +0800
Message-ID: <20261112055125.704676-1-wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: xc7AxqYC4QxPdhLLfD-ivPN_8VvdQKBs
X-Proofpoint-ORIG-GUID: xc7AxqYC4QxPdhLLfD-ivPN_8VvdQKBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyMyBTYWx0ZWRfXxN4Q0GfLRvbk
 w4TD3fOqtpTsmcLaJN5TKpQBgOVW/2EdVsJBqnbwto7P5wFQv5h3Hb0P81OoCqwfp7a72dTl70s
 /JqapRBflBRTwLwD9CLYsT5SjsGLPEx5z73vbkoT6E/DVkoLl0T0/rq6oXbFisFfiXKGokSMxJF
 T6FLqLKIKaMGkUDSDe8ZIokYany6i2ebYR6B+qguf75vWaSXTj/Bx8OxIw5fMwR6ueHAow/lShX
 lM63taqymXJfF3K5X1DDarkhmkfkNMsPyDjQZc6n4lhchN8+OQB+SZVMw4YjGB4QRM5vK5SP6Ag
 NljQFb8zJCwZh8CByXzw1QaT9Prar5byyOw3NUXAEQnkbrwrCqCJuNDE+VrlIiD+E+7wkDyIwBX
 asdcvoYJgP2zKb40Jnu+vNFdBrwYManPxc3708FNPo9cUgUsYiu/za8hkaNwPZDiiwjDl29M5GN
 ehV2r6m+dYOEyVsuzRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyMyBTYWx0ZWRfX9+lsth/uJzeX
 MTlbTF7SUkPxCAk3MO4kp4sSytRmVNy4FCVqcANHHUnr6TR+9ELnvoivzh+icCavttL2J5NmFYF
 nVazYvWT8xX4AAlPR/ui6jTH/QI1BeE=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af553e2 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=oTP_Z-EQWkD7tdjTyAEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120023
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 05:51:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5315
Content-Type: text/plain; charset="utf-8"

Unconfined domains lack the perf_event permissions needed by perf to
collect performance counters and tracepoints with SELinux enforcing.

Backport refpolicy commit 6072cfa851a3 ("unconfined: allow perf event
access for unconfined domains") to refpolicy-targeted to allow access
to their own perf events.

Assisted-by: Codex:GPT-6
Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
 .../refpolicy/refpolicy-targeted_git.bb       |  1 +
 ...-event-access-for-unconfined-domains.patch | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0003-unconfined-allow-perf-event-access-for-unconfined-domains.patch

diff --git a/recipes-security/refpolicy/refpolicy-targeted_git.bb b/recipes-security/refpolicy/refpolicy-targeted_git.bb
index 321407d..a416854 100644
--- a/recipes-security/refpolicy/refpolicy-targeted_git.bb
+++ b/recipes-security/refpolicy/refpolicy-targeted_git.bb
@@ -15,4 +15,5 @@ include refpolicy_${PV}.inc
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

