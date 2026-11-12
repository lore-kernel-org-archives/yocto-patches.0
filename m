Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5843.1794453589810098745
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 19:19:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=U4dcIszA;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: wenwfu@qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2Zdrk3607712
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 03:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dW/Z5hrv0C9
	GtmDYPTc9tZadicKzqDV1aaTPcl42Mrc=; b=U4dcIszA1Lx1SuUkTUB4j3jx0Y9
	F2QI6ZgbPgymA/yMyIf6GMt6Geg8Pu+A94K9J3TCAbqI297UQb6Ogl+i7KRaoa2f
	mQ+OcOId0bXS7uFT3ZQhgjZqzf85mWeozKUGkHoBScseYh9gHXE/f0bXRz2mfd7R
	0+rOYQLqHq82w40nReR3EetvGnVDvq97j4pT0Gs98Bi9ZcmuYLQHfZENMut81C1v
	0IkxlZytj73nj0/WCU+tPiS+3gNBesF2oUBreiybEIOOM2aDs4tWqByLD5XwzlOg
	UNEYiw4m46tARHMdbmp9p+1Y5jyY1l+HX0CxlxayK+JZRtcQbjdeSyjqPAw==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawn6qm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 03:19:48 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC3JkQw3748533;
	Thu, 12 Nov 2026 03:19:46 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AC3Jkpw3748523
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 03:19:46 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id A22F8AC9; Thu, 12 Nov 2026 11:19:45 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [meta-selinux][PATCH v2] refpolicy: backport perf event access for unconfined domains
Date: Thu, 12 Nov 2026 11:19:44 +0800
Message-ID: <4a8dcdf93c4a51793e95ba1e2ffa9ef1f12a37c4.1794453367.git.wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112024415.624864-1-wenwfu@qti.qualcomm.com>
References: <20261112024415.624864-1-wenwfu@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfX0LYugpkB/XMJ
 2huodtyjNU4ANSjpp5FvxIoYdb4BHboRTgbL5/Is+uvi92EEi+NneDXamRmf0rHJEg5LLRA1obo
 Ndf+URs7NGCvy6GSVimGO2RQSqu3z6c=
X-Proofpoint-ORIG-GUID: JHOS5Yc371HCzpfYc-ck3-1XASCjaRT5
X-Proofpoint-GUID: JHOS5Yc371HCzpfYc-ck3-1XASCjaRT5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMyBTYWx0ZWRfX1FmtynX8xFAh
 X5kb4J0iJECROkUvvt6JRApVm7REisWQ7rpzGOqp5Q+Wggy9T/qxI00CZWOI7UW/VR+b9rF0Ngx
 KbhbauEDN3x1BMvVh2gHx+rB0cafyKb9cOhLFAoFCmImbyqaTqcgBR+QMK/GnpbD85V0uYvROLv
 DRxwbJrj2kxPlE5rElO6vRnB3M7hMLE96iaYYW+UALoFCyCw3/QpWVIuBts7nOAmfaBCFVfqDLP
 tfJF7aQwv2LWPskCM++J3Ia6gt00cXn4RmfN8WK0V9xn1cRhehmDZ04gV8anGESHCUoszGJZCwr
 OG/HlGg8Jrx+xO2Zfdaql2RexDYQW2RLST2HDfk8p0WpVhkNj9CEqirZyANUWLNmyQM4HE/zpwR
 /8vabr8/2X1FdEfeaGfpCUDws5hTR9wLKrqsnnaWDH/2zzB3pES5JnpU/2jjN9fy0gKeTwQncuF
 fgvYfoKYv+bqNr+/6Cw==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af53054 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=oTP_Z-EQWkD7tdjTyAEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120013
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 03:19:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5312
Content-Type: text/plain; charset="utf-8"

Unconfined domains lack the perf_event permissions needed by perf to
collect performance counters and tracepoints with SELinux enforcing.

Backport refpolicy commit 6072cfa851a3 ("unconfined: allow perf event
access for unconfined domains") to refpolicy-targeted to allow access
to their own perf events.

Assisted-by: Codex:GPT-6
Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
Changes in v2:
- Add the meta-selinux subject prefix.
- Add backport to the subject and clarify the commit message.

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

