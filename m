Return-Path: <quic_jaihindy@quicinc.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2223D2502F
	for <webhook@archiver.kernel.org>; Mon, 12 Jan 2026 05:33:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27256.1768195985649089892
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 11 Jan 2026 21:33:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@quicinc.com header.s=qcppdkim1 header.b=A06d2pyp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: quicinc.com, ip: 205.220.168.131, mailfrom: quic_jaihindy@quicinc.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNmeHP3306524
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 05:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SUJuHX19N+bovBz9s5MV6Erxqt3CsG1CUCi
	hEDsFUGM=; b=A06d2pypYsWr7RdUzTPqucRk8rlo5rBZVRJeqzhvwd21iC4OaT1
	Xic6yXhAK0zqZCotp5oQRJ/X7WxBXqvqjFAIcc2Vf+s95u/GP/GNC4wmwCk8lmEE
	Zb+QQtHgAP8RX6YxQEvPWkA85jtIqgqeJ3VdJkOJ3XoFITunCheWbmRzNOU6GGb1
	M84dSJnLkFB5BUWXhIsMBTKX5JjYIextMYpM0BWkGFuY8U0uMfJbvm9nCW6c18o5
	BbdIwLxTgrRVK6yGOkMYl+d04/oUkfq5uaTnSJqIIMogBgWCB+UZu/jOxjawsdFb
	P1GP4PviFfp2/CAl9jfNkCPt2Z/YNlGYMjg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkntuk1kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 05:33:05 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C5X1hZ002345
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 05:33:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4bkfukvd96-1
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 05:33:01 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60C5X1au002340
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 05:33:01 GMT
Received: from quicinc.com (hu-jaihindy-hyd.qualcomm.com [10.213.102.234])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 60C5X1P7002335;
	Mon, 12 Jan 2026 05:33:01 +0000
From: quic_jaihindy@quicinc.com
To: yocto-patches@lists.yoctoproject.org
Cc: Jaihind Yadav <quic_jaihindy@quicinc.com>
Subject: [meta-selinux,PATCH/V2] systemd: remove creation of backlight directory during build
Date: Mon, 12 Jan 2026 11:02:58 +0530
Message-ID: <20260112053258.3630191-1-quic_jaihindy@quicinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA0MiBTYWx0ZWRfX6rRhF/fYiPoU
 SBd+K5IBsHqK+DywvKylQgcDmTZYEnV0xoJqtAq17CTMAoJsN304e2+qNX3+CCfuNjy8lQQbXqa
 As2eqh25gjjgsQmVIDMLPaA8+ymMSkXrbbA/AC7ACKf8swayjziB27MtxTiJcit/592w0U6Ml/g
 mYftrL486bnedsUGsmpVptrVwDPTsQMOCYQx3gyulXKce+wUJUZireclV0muylQiIK873ViPXZw
 LqCaHCWVgSDtYxS6ba76QcbKFnnojbgHyu1mqr7lTcNajU+l+tuTg0+b7Jl/hxkm0JFsWOKSHph
 IUbq0GwXNLIPZDqqvv/5Xrfmn96scSGEgMAg0DIe9nSMUH/3rhxq634YuQi0HuUW0fyWwnArFHv
 57gRKLcezIxYbnV8N/KNZ4izIbFtFearwU3sL88fKnRgsFzYKr9nT7v+MX/YsG764geAy8RnGh0
 ws0bLO5kHWZpuHckPWw==
X-Authority-Analysis: v=2.4 cv=R6AO2NRX c=1 sm=1 tr=0 ts=69648791 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=COk6AnOGAAAA:8
 a=zQuSKEV-cOmjfPzb2cEA:9 a=tOIqXpxfQm4A:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Z8Aw1Kwwj4PWnXdsB5DGqZobvN4sI8Zx
X-Proofpoint-GUID: Z8Aw1Kwwj4PWnXdsB5DGqZobvN4sI8Zx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120042
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 Jan 2026 05:33:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2942

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
 recipes-core/systemd/systemd_%.bbappend  | 2 +-
 recipes-core/systemd/systemd_selinux.inc | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)
 delete mode 100644 recipes-core/systemd/systemd_selinux.inc

diff --git a/recipes-core/systemd/systemd_%.bbappend b/recipes-core/systemd/systemd_%.bbappend
index 7719d3b..7c3a686 100644
--- a/recipes-core/systemd/systemd_%.bbappend
+++ b/recipes-core/systemd/systemd_%.bbappend
@@ -1 +1 @@
-require ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', '${BPN}_selinux.inc', '', d)}
+inherit ${@bb.utils.contains('DISTRO_FEATURES', 'selinux', 'enable-selinux enable-audit', '', d)}
diff --git a/recipes-core/systemd/systemd_selinux.inc b/recipes-core/systemd/systemd_selinux.inc
deleted file mode 100644
index 7d466ee..0000000
--- a/recipes-core/systemd/systemd_selinux.inc
+++ /dev/null
@@ -1,7 +0,0 @@
-inherit enable-selinux enable-audit
-
-do_install:append() {
-	if ${@bb.utils.contains('PACKAGECONFIG', 'backlight', 'true', 'false', d)}; then
-		install -d ${D}${localstatedir}/lib/systemd/backlight
-	fi
-}

