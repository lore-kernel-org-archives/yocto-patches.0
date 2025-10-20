Return-Path: <quic_sasikuma@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500ECCCD193
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 10:21:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web11.14969.1760955712342745175
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 03:21:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=eAi8H7al;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: sasikuma@qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNsgrv015370
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 10:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FFtveXUn8afaOriJI7hdTQjAAnzW+ub23tQ
	VCAAlEyY=; b=eAi8H7al0X5lBdfRbG6P2+rn4E/qDTcFM8gpVDpvvSpeQRqDgKO
	P6GQXdb6D7v0hkeELs1iftUBx3huKRReWeTnQbON57NxkDBWYJ2vKdFREK5FhK7V
	YTR2iBlYWrVk/eMt046FRY7MLHHX10GKs3oDaP0UoZzahx4Ne++uhLhnGEvm2Wh3
	XCOJgdepjmwW4CL4wb+VU2/gWdIAdy2Q2fDsHxSG+mHNFLQ6zH9N1PcNq9UWhtQ0
	3WinBMmz0tml+LT0JeaFu0psCccSPUDwukPVOSVVZd7Q6Z9iGc67bd/d3Wgb5cxq
	GlW6cpOVvm6QHchUP/QDxzG0I3+cft2j5LA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469cbf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 10:21:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KALmdE008878
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 10:21:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 49v3ykuh2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 10:21:48 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59KALmqT008873
	for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 10:21:48 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sasikuma-hyd.qualcomm.com [10.147.243.253])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 59KALmMN008871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 10:21:48 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4060212)
	id 3B6B15C8; Mon, 20 Oct 2025 15:51:47 +0530 (+0530)
From: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
Subject: [meta-selinux][PATCH/v2] refpolicy: Remove build path reference from file_contexts.homedirs
Date: Mon, 20 Oct 2025 15:51:45 +0530
Message-Id: <20251020102145.1363270-1-quic_sasikuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SfP-ncRqsaEV0orCiAk7_YRJGqRwMmAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX5zDSVqD3E5vp
 NNCB0gREuszI4ehcWisOXIiJgIr8d0fLhoUDIsLhSfHMdoiHgkNLyq23sY8TK66F2mFF9L0Sae/
 NZ1yYALIqq2LQUsHPRafqsr8ODkpgsdue2KY11HEHzp95tyig5/NTBPdXuSsk1UGNWksPb8eojS
 UMRrB0P0Amwrust9Yr/lT3+IYMFjdV9i8dBHTf7eueBp+8iEAt0z1uVhOmPQQbzEKvMD/mjYJEp
 4/ZFyQfjN19+C5jZClBOh0tc3UpmvIyetxX+2BMjhq5BKIVtHeRzA1sb0KcUWV4x8VepJQ5RX1A
 ZBbKJTPRhwrmHEF6RC87dm0DXnvMryl00ecdcjcwq/dUtEAOVAw6sUPI4ojNIx7S24KbKCSzkn0
 NpDQR2ddLKoz5tgBDtbzRogCIBXB+g==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f60d3f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8
 a=KBILEq-dR_ycPv6JiZsA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: SfP-ncRqsaEV0orCiAk7_YRJGqRwMmAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 10:21:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2361

filecontexts.homedirs is getting populated with reference to
TMPDIR path and yocto's QA check is flagging it.

To avoid this, removing the line that contains TMPDIR path
from filecontexts.homedirs.

base-commit: 7368431e9c31a8d0ef73ddcafc9d8e3594de4d08

Change-Id: I842cfd8d2f6ca5f92da37dc96c1e896386401c24
Signed-off-by: Sasi Kumar Maddineni <quic_sasikuma@quicinc.com>
---
 recipes-security/refpolicy/refpolicy_common.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index cf32723..e09f73e 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -260,6 +260,7 @@ do_install() {
 do_install:append() {
     # While building policies on target, Makefile will be searched from SELINUX_DEVEL_PATH
     echo "SELINUX_DEVEL_PATH=${datadir}/selinux/${POLICY_NAME}/include" > ${D}${sysconfdir}/selinux/sepolgen.conf
+    sed -i -e 's|${D}||' ${D}${sysconfdir}/selinux/${POLICY_NAME}/contexts/files/file_contexts.homedirs
 }
 
 sysroot_stage_all:append() {
-- 
2.34.1


