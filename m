Return-Path: <quic_jaihindy@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF6BC79FA9
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 07:05:56 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.85087.1767683151017479829
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Jan 2026 23:05:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=hihYy+4n;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.168.131, mailfrom: quic_jaihindy@quicinc.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6063RRIV2432438
	for <yocto-patches@lists.yoctoproject.org>; Tue, 6 Jan 2026 07:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hiS3deWXArQx67EemXsFdtt4c+vb8DGp18L
	2mY58baA=; b=hihYy+4nnFcsgDB5Ho0jfd2udXT/UiRp5tBMYa1ZfOAPflYQeuT
	J6uN+5KjBchNlQ2E2nEnFzgWbn9OsXemA5NLurda8xvtlwpbp0tWiOClMGU7YyNf
	jcoJfW/xRO5BpIqQIYqnbpSzzmbDaaqgmc+am9M2Tt6D44kA9UE3Jo8K1fEz4EAM
	BxwxoXehVhjvb1ELo6NyfFur4qLKY5nIiRcmf8wSlRpikiZs7xNL6EkGQr7LH1KX
	FJtWuUeDFTxnImUfvvzM1PBeEx3zCp99VnuX2oz+QQSqw8Y0/cbi58Gb/Sr0N5wm
	pqIKAGUoME3lCWjTQG5suyikIIEpkLTtzPQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgr738wk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 07:05:50 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60675lud024066
	for <yocto-patches@lists.yoctoproject.org>; Tue, 6 Jan 2026 07:05:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4bev6met5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 07:05:47 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60675k2X024060
	for <yocto-patches@lists.yoctoproject.org>; Tue, 6 Jan 2026 07:05:46 GMT
Received: from quicinc.com (hu-jaihindy-hyd.qualcomm.com [10.213.102.234])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 60675kEo024059;
	Tue, 06 Jan 2026 07:05:46 +0000
From: quic_jaihindy@quicinc.com
To: yocto-patches@lists.yoctoproject.org
Cc: Jaihind Yadav <quic_jaihindy@quicinc.com>
Subject: [meta-selinux,PATCH/V1] systemd: remove creation of backlight directory during build
Date: Tue,  6 Jan 2026 12:35:44 +0530
Message-ID: <20260106070544.3668128-1-quic_jaihindy@quicinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=QrxTHFyd c=1 sm=1 tr=0 ts=695cb44e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8
 a=zQuSKEV-cOmjfPzb2cEA:9 a=tOIqXpxfQm4A:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: UiLr3GX6LvstxQeH7Nhnx9qQP9v4uDtx
X-Proofpoint-GUID: UiLr3GX6LvstxQeH7Nhnx9qQP9v4uDtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA1OCBTYWx0ZWRfXxpcavVa9zhQc
 IMDPfCCtlNwloGF7PKgUz9QcaaelW7W7mghgj4WoF1Im1fzPD1WsFdXCo/UFn/Q2BSnKl+z5e0/
 FdWUDTDfgx45n+h1pJYesaP+zLVk+Csf63P3TFKuLCIDGJUUNqBQekIr5aprrb5EjFxb9e4FqcP
 rAn+iRsJXNaFqinOIh4Y98bp9lkvM0BobV1CMMSOlfpEs2bVgYFwMBy+r/vnlofvcXgqPiWh7gd
 uDLDZxRRFMqk2T6dWjU7OBoWJ7G90mnKH35Et2iyednj4OxH4JmzSym5Snk9z0TKYuVR+bLKpoP
 RV2bWhv16E1xmkoLdI7Na3r7EslpiwkLnv/9+xjdFVyUOtOqHfc4Yweo5MQHL49aV3geQObR8mD
 k8m8D/ApNMW+8bTYUQpDD+xZZTuc/au7gwb9mnQlKD1vR7hVP7LW3WOgUC2bhxrG4N2UZXQELLt
 O1VYK2Podl+TwxVY01A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060058
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 Jan 2026 07:05:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2901

From: Jaihind Yadav <quic_jaihindy@quicinc.com>

The recipe previously created ${localstatedir}/lib/systemd/backlight at
build time when PACKAGECONFIG included 'backlight'.I Tested it on myboard
and can see directory is correctly labeled by SELinux at runtime and the backlight
service starts successfully without this step. Removing it simplifies
the install process.

Example SELinux labeling:
ls -laZ /var/lib/systemd/
drwxr-xr-x.  2 root root system_u:object_r:systemd_backlight_var_lib_t:s0 backlight

Reference:
Previous discussion and initial change:
https://docs.yoctoproject.org/pipermail/yocto/2018-April/040854.html

Signed-off-by: Jaihind Yadav <quic_jaihindy@quicinc.com>
---
 recipes-core/systemd/systemd_selinux.inc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/recipes-core/systemd/systemd_selinux.inc b/recipes-core/systemd/systemd_selinux.inc
index 7d466ee..35411b2 100644
--- a/recipes-core/systemd/systemd_selinux.inc
+++ b/recipes-core/systemd/systemd_selinux.inc
@@ -1,7 +1 @@
 inherit enable-selinux enable-audit
-
-do_install:append() {
-	if ${@bb.utils.contains('PACKAGECONFIG', 'backlight', 'true', 'false', d)}; then
-		install -d ${D}${localstatedir}/lib/systemd/backlight
-	fi
-}

