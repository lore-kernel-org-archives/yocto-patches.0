Return-Path: <can.wong@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A524C61DB2
	for <webhook@archiver.kernel.org>; Tue, 10 Jun 2025 19:59:50 +0000 (UTC)
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com [148.163.142.35])
 by mx.groups.io with SMTP id smtpd.web10.97083.1749585583164504557
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Jun 2025 12:59:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emerson.com header.s=email header.b=r7Wg/38h;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: emerson.com, ip: 148.163.142.35, mailfrom: prvs=525646e39f=can.wong@emerson.com)
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGwu8b039055
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Jun 2025 19:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=vP+GKxdxgrm7j/JKREjqsAdCDU
	khAHzDjg8YSl78iNY=; b=r7Wg/38hKNRSlm421Wkj8kX9tG9Cr5rlBiwxH6e5ji
	Tknfxo8a/M6wnKTJT9TYSNETdsk8nDlOj/qAI/rEu7QuM7cp5ns2ccT8tuuHdO4D
	XbimvArR5nEoQUu0dz89/DF49Uha0JrAG4cHkaTHWLfd5QxXFyMiRWiACQ25oHB7
	jeBwX4ugfY0Jmiog/hwDPoVsrb7cl1RQLSw+QmVnKuaSm0Js4UA2DqV0N1wn3juL
	9ljTHySEf/gSeJPwx5CyT6or7keknFImffmmjCzCi4Sxmqsd6EEdnG/2hP7GiOAL
	Cb+DCUblU6CYMXTVaSs6/riTGzree8emQcwKUWQCGUjA==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 476rpuupyv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Jun 2025 19:59:42 +0000 (GMT)
Received: from us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 10 Jun 2025 14:59:40 -0500
Received: from cawong-linux.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 10 Jun 2025 14:59:40
 -0500
From: Can Wong <can.wong@emerson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Can Wong <can.wong@emerson.com>
Subject: [PATCH v2] smack: Convert CVE_CHECK_IGNORE to CVE_STATUS
Date: Tue, 10 Jun 2025 14:58:01 -0500
Message-ID: <20250610195801.325222-1-can.wong@emerson.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MuNS63ae c=1 sm=1 tr=0 ts=68488eae cx=c_pps a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17 a=6IFa9wvqVegA:10 a=geDs06hvAAAA:8 a=opRPBEcDM4smz6OtnVQA:9 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2MiBTYWx0ZWRfXzeWSsq5O4jVX mtK+k4uIWdtUerflbMpNQbijbU9pp11vTtAnoSH55lgHdRJSxBWpm38hVVIDbrD3wXBLz6lpUZa pcsL5FVJw0t93H6tqSxoltJYxOM7hnHd3NWPnMYDRpWnV5+horN6e3OrIpvMz9NTI19IuL959cA
 2JmzXzsSI+5cjFWfX14v1So8EeMRIkd82g/dkbD7eFHW7Oazu0uoo85CK7uQG9ESq7UMo5lzJEm vxYKFkxUMNhb56HrGfI8VZydRPs8aH6WfAu0aR2sTzJWLlkdhkSh9uzZwsZ/MvwwFnNsVw51jFv +SFzMXaW8Z3danxUXdkTB0iYhzJWfMKzKM5CmL21VHdM51oqh1R5302MFwEpF2XzfgpFE32J+UH
 D7Wo3AGiwl18aSQgC71M2W+h3mejcayxRh1ACn61k3Qe/N6q7opUUOYRRm0jkOtIJKNHM+un
X-Proofpoint-ORIG-GUID: Ypi4b2JSBit5juzPemcDPUNTUzA2eibB
X-Proofpoint-GUID: Ypi4b2JSBit5juzPemcDPUNTUzA2eibB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=748 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100162
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Jun 2025 19:59:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1629

Signed-off-by: Can Wong <can.wong@emerson.com>
---
changes in v2:
- Added spaces after :

 recipes-mac/smack/smack_1.3.1.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3.1.bb
index 6c52392..6a26466 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -13,10 +13,9 @@ SRC_URI = " \

 PV = "1.3.1"

-# CVE-2014-0363, CVE-2014-0364, CVE-2016-10027 is valnerble for other product.
-CVE_CHECK_IGNORE += "CVE-2014-0363"
-CVE_CHECK_IGNORE += "CVE-2014-0364"
-CVE_CHECK_IGNORE += "CVE-2016-10027"
+CVE_STATUS[CVE-2014-0363] = "not-applicable-config: CVE not for smack of smack-team, but other project."
+CVE_STATUS[CVE-2014-0364] = "not-applicable-config: CVE not for smack of smack-team, but other project."
+CVE_STATUS[CVE-2016-10027] = "not-applicable-config: CVE not for smack of smack-team, but other project"

 inherit autotools update-rc.d pkgconfig ptest
 inherit ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','systemd','', d)}
--
2.43.0


