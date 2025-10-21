Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BFDCCD19F
	for <webhook@archiver.kernel.org>; Tue, 21 Oct 2025 03:35:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web11.3150.1761017720011688299
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 20:35:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=aPYjaumQ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL13wT031269
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PQ3ULNgMPTG9qKUSN9IDtJ9pUItTMH7ll6A
	BtTMvmHc=; b=aPYjaumQHwT63EZBCg/03dTDrWOB5uxjMzc2gBuK7lUODXkPAQK
	QngCaz//IhUpaUEKbTwDl3/C6HdM9AV7mL5oFejWhO9Kl+ioD5DBGqEuN6vLz9+9
	5HwmreGLWGsPNVHya9nhSeWIXuZ9RLBTeSFaCTAqeMZNkP+NHoqIsho9QifTBups
	J9mjEI4rPtEpKszl+ehzwh4yR6hblAgOwDPlRzvQ+kNSyGUd9i7ZKt1LDh8Kk+yf
	j3VULjjjcUONN1LM0Je+yOQHFZRFuEk4dowtbdAbCXyfywdCNmT18xEcMaMisIkS
	0kXFIsBR7qpTMmlRWoQAbM68vFUjd/NmqoA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k6v37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:35:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L3SwTc029111
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:35:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49v3ym29w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:35:14 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59L3ZEPt002147
	for <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:35:14 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59L3ZDGn002146
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 03:35:14 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id E7AFF577; Tue, 21 Oct 2025 09:05:12 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v4] refpolicy: Remove build path reference from file_contexts.homedirs
Date: Tue, 21 Oct 2025 09:05:11 +0530
Message-Id: <20251021033511.1791045-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UOGZkrGVzqKbo7qEBGYjDE1oKtJJRlX-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX4Dd+puSFJUIR
 f5QCHOvTDoojj/wA0aaotQJ0p4SeWlr7ztiI59jfaf5ZSu8xh37QxyIqHUI3qmOd4Ee6pyBGWJ8
 ey1ZriunP3xPZlvxpVLzozcMbDyWqxysDYM8NP6iSefIXab7FXGUATkgrFb3ywZtb27kqMBosgZ
 3hiI90hySAbZIOf6UeeYYAOMA3y8my27dMPidzmG/P+ErYlawNef6t58eRcu1RaKaUS9M/56fiw
 Zg+ej4ANk71eB62MrdMzaLTGg/1aUPXatgF+Czm3PLVG+fS8voKr7SklAxcDHyQY3bwDyAOlFnZ
 4vhFtWxQUz7Zt2rrOSG7uXCtNtbO7oUay+tONxV8X2cO0N8kGG1bsXmes79XupeJE3hK3ebBtoj
 Ls41W3R1rwe0tgUSMQGMBVDpvh7URA==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f6ff77 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=owfOQfebTelCMGAwzRwA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UOGZkrGVzqKbo7qEBGYjDE1oKtJJRlX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 21 Oct 2025 03:35:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2374

filecontexts.homedirs is getting populated with reference to TMPDIR
path and yocto's QA check is flagging it.

To avoid this, removing the line that contains TMPDIR path from
filecontexts.homedirs.

Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 recipes-security/refpolicy/refpolicy_common.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index cf32723..964906b 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -260,6 +260,8 @@ do_install() {
 do_install:append() {
     # While building policies on target, Makefile will be searched from SELINUX_DEVEL_PATH
     echo "SELINUX_DEVEL_PATH=${datadir}/selinux/${POLICY_NAME}/include" > ${D}${sysconfdir}/selinux/sepolgen.conf
+
+    sed -i -e 's|${D}||' ${D}${sysconfdir}/selinux/${POLICY_NAME}/contexts/files/file_contexts.homedirs
 }
 
 sysroot_stage_all:append() {
-- 
2.34.1


