Return-Path: <sasikuma@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7004CD5BD5
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 06:36:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5139.1779950207258339242
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 23:36:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Z4ZCYZaL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKmn321638523
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 06:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rykALFJh6mUrTqZrloZ/cCGvvCaj4uzi0lp
	Cegjb1Ks=; b=Z4ZCYZaL6Zt8zJaSEvSb/t5wg5++7rsRzMEMEYc1k0Rd2PSmvsE
	+9EnNv/XUHZ8y62qGffi2gMbhlCjrR5RhfIrvHTFVx9jRyjhCfflFIhK4EGU39Po
	HgrhHY2NIwLT2yoiPRBoMGuYc/0y0kBZUd1HT4XEsk3zBZsk1CKnfNpIb+MXPGUS
	EYknOTgqEKKEfDYPm4SWuF+c7Of/MM6iTMGYxgAui8XTGiq3Z/8WfGj5Ob3xmtB2
	pY8+e49ucUNaNRTIRCOinnOZjvqk9PSyCFW+vnNylQ/f24Ry1W43tPaQ/tv+lLxp
	Q5n0ji92p5BoG8UCthH9kr7la33tQDHZoGQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynhmev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 06:36:43 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 64S6aeAV010682;
	Thu, 28 May 2026 06:36:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4eb5ajxa5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 06:36:40 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 64S6addY010674
	for <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 06:36:39 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com ([10.213.102.143])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 64S6ad7V010673
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 06:36:39 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4060212)
	id F22AE21C4E; Thu, 28 May 2026 12:06:38 +0530 (+0530)
From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] dmesg: allow dmesg_t access to init script stream sockets
Date: Thu, 28 May 2026 12:06:37 +0530
Message-ID: <20260528063637.2357741-1-sasikuma@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA2NCBTYWx0ZWRfXz3pFFSFq2eR4
 z1vk+cBjuHavKaYLD8y71yjy8FcE0PBJOICVp3tcW116pdREWO8/XH/GNuYI+ARHy88iIs9rKcH
 Q2lqvT1uNLFsBB3Re87XY00ZAvuvp3mmCx/25Kpzp5aM/T2yXFqVU44OMQqCK9oqodkgBt2wLrT
 BrKaAKRZvPamt+/ZqMgW7C/UgSN5QYwmo5SRaQKpHNT7D4jR7VERHehuD1QC+tnp+2hH0oGSMGS
 7fxNXus0trfOy/i++8Wlwt2fQn+CnMRKND6pmyYMU6OWLN+rZmUBBlcWGkygjmrd//K6cRXrCZ3
 0l0xoqj/XpJWTKUsyypOP36TFrnrnw3I7ICgCPH9zL8zofyKcWpZcIk7q/Pad+BFXl47e+PQoBY
 NwzfqrYUE0+l8QuOn8xXm4ABtWOBlw5eFQMJ5I1S6EQAWdhdiRVhvI0JRMIY72yfiYiJt9hRd66
 q/I9h9zEMMUC8Rt3PhQ==
X-Proofpoint-ORIG-GUID: u9QVhnYVuQKw_98ksTFxHC9kiKhAgkpk
X-Proofpoint-GUID: u9QVhnYVuQKw_98ksTFxHC9kiKhAgkpk
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a17e27e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=wcS9r9NA_vUF9XQxnmUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280064
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 06:36:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4079

dmesg was generating AVC denials when interacting with an init-script-owned
UNIX stream socket for operations such as read, write, ioctl, and getattr on
performing `adb shell dmesg`.

Denials:
type=AVC msg=audit(1773565011.851:411): avc: denied { ioctl } for pid=4782
comm="dmesg" path="socket:[764973]" dev="sockfs" ino=764973 ioctlcmd=0x542a
scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:initrc_t:s0
tclass=unix_stream_socket permissive=1

type=AVC msg=audit(1773565011.851:412): avc: denied { getattr } for pid=4782
comm="dmesg" path="socket:[764973]" dev="sockfs" ino=764973
scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:initrc_t:s0
tclass=unix_stream_socket permissive=1

type=AVC msg=audit(1773565011.851:410): avc: denied { read write } for pid=4782
comm="dmesg" path="socket:[764973]" dev="sockfs" ino=764973
scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:initrc_t:s0
tclass=unix_stream_socket permissive=1

type=AVC msg=audit(1773565011.851:411): avc: denied { ioctl } for pid=4782
comm="dmesg" path="socket:[764973]" dev="sockfs" ino=764973 ioctlcmd=0x542a
scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:initrc_t:s0
tclass=unix_stream_socket permissive=1

Grant the expected socket access for dmesg_t resolving the AVC denials.

Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
---
 ...g_t-access-to-init-script-stream-soc.patch | 55 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0063-dmesg-allow-dmesg_t-access-to-init-script-stream-soc.patch

diff --git a/recipes-security/refpolicy/refpolicy/0063-dmesg-allow-dmesg_t-access-to-init-script-stream-soc.patch b/recipes-security/refpolicy/refpolicy/0063-dmesg-allow-dmesg_t-access-to-init-script-stream-soc.patch
new file mode 100644
index 0000000..de7a5d7
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0063-dmesg-allow-dmesg_t-access-to-init-script-stream-soc.patch
@@ -0,0 +1,55 @@
+From 8a5020228bdae40fdf57d5d5987a1f3f4910a540 Mon Sep 17 00:00:00 2001
+From: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
+Date: Thu, 28 May 2026 10:20:36 +0530
+Subject: [PATCH] dmesg: allow dmesg_t access to init script stream sockets
+
+dmesg was generating AVC denials when interacting with an init-script-owned
+UNIX stream socket for operations such as read, write, ioctl, and getattr on
+performing `adb shell dmesg`.
+
+Denials:
+type=AVC msg=audit(1773565011.851:411): avc: denied { ioctl } for pid=4782
+comm="dmesg" path="socket:[764973]" dev="sockfs" ino=764973 ioctlcmd=0x542a
+scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:initrc_t:s0
+tclass=unix_stream_socket permissive=1
+
+type=AVC msg=audit(1773565011.851:412): avc: denied { getattr } for pid=4782
+comm="dmesg" path="socket:[764973]" dev="sockfs" ino=764973
+scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:initrc_t:s0
+tclass=unix_stream_socket permissive=1
+
+type=AVC msg=audit(1773565011.851:410): avc: denied { read write } for pid=4782
+comm="dmesg" path="socket:[764973]" dev="sockfs" ino=764973
+scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:initrc_t:s0
+tclass=unix_stream_socket permissive=1
+
+type=AVC msg=audit(1773565011.851:411): avc: denied { ioctl } for pid=4782
+comm="dmesg" path="socket:[764973]" dev="sockfs" ino=764973 ioctlcmd=0x542a
+scontext=system_u:system_r:dmesg_t:s0 tcontext=system_u:system_r:initrc_t:s0
+tclass=unix_stream_socket permissive=1
+
+Grant the expected socket access for dmesg_t resolving the AVC denials.
+
+Upstream-Status: Pending [https://github.com/SELinuxProject/refpolicy/pull/1137]
+
+Signed-off-by: Sasi Kumar Maddineni <sasikuma@qti.qualcomm.com>
+---
+ policy/modules/admin/dmesg.te | 2 ++
+ 1 file changed, 2 insertions(+)
+
+diff --git a/policy/modules/admin/dmesg.te b/policy/modules/admin/dmesg.te
+index 89478c38e..0d14dd227 100644
+--- a/policy/modules/admin/dmesg.te
++++ b/policy/modules/admin/dmesg.te
+@@ -54,6 +54,8 @@ userdom_use_user_terminals(dmesg_t)
+ 
+ mls_file_read_to_clearance(dmesg_t)
+ 
++init_rw_script_stream_sockets(dmesg_t)
++
+ optional_policy(`
+ 	seutil_sigchld_newrole(dmesg_t)
+ ')
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 87c9e39..51ac1d4 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -75,6 +75,7 @@ SRC_URI += " \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
         file://0062-selinux-allow-seatd-to-use-unallocated-TTYs.patch \
+        file://0063-dmesg-allow-dmesg_t-access-to-init-script-stream-soc.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.43.0


