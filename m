Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2F8103A989
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:38 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13688.1774405053122798951
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=TTf60Okm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P2DEJw3459919
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=Rrse4gOLdvwF4O7l08/2D4dmBg9ZTgqbbTjJv1o7kVg=; b=TTf60OkmlhvF
	7rneqgw3iQUdIZCEG/4Faolg6qmxhBHJSPqP5xhfK2P8VMKNMpNiQFatUcIL6W2z
	DWYorl33JmbYYiviZobPw+FtwIhwSbykgPpJptp9SSyL3q26nSy1PPNT93hJ5HnD
	Dzzu/gjCI7nOyQSqCJFgHT4QB8Sz5phINwkihkj+foJ8UDi13sL9MfAaSpodG5QS
	83pw03+cBqBDfi8GHgTTaJLFHoBmVztvgoqMq93ndfd4eaL8Z+RLm7RNWk/m4Vcp
	6aJdiaLRJvvgJQW+VAcSwh7jH1tMghmIhX1mkEzNbku5Mjpa1nHoi0pGV+N7B5lJ
	rLDh3Yg3hg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84dur-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:32 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:31 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:30 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 11/14] classes/unsupportarch.bbclass: update CPUs
Date: Wed, 25 Mar 2026 10:17:16 +0800
Message-ID: <20260325021719.1526525-12-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Sce4ySz07BkTf4nXMniNAqX6UKWWqM_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX1rqrdSYUlsEQ
 5V07iRV1nQgmbgazW218yZt7gH+L5cBwK30A//uxGzRcAP1BR4FHfltBCUhQO6zVT71htiT5TOP
 IWjcXwJyj5bk/+1sJ0Q3+PahNTgIoKKF5KEgW5HMUM0QF468nfYuwhdpl9VhOhH9+Z11WLozbwS
 JpoQ9nQnELyd0S8bnaj57YwSNWYohqStWLu3Q+TUnIOudmVLER2sSloLGY1s/NUDmiYM9BapTEB
 zfDWchxCXy68MxMBqEoCrzGOa2xqhTJnxkLPAiarvRk0W3dvLVcOUEvfP3RmnHQJiQk0Xx2IvsL
 tzh6OaLkU2ch91JUrvOn42408cBttdGiL1Pg6kZT+ltzd7JG0lPgwdlg39796gNGRZ7wFT4lDGQ
 4scf+fBegsyft41VjRSMm28FhA5ySpdRP2EPKi6TkD4giA3XmQpe46KuMRysO04eLBH4H11L4T4
 ijQpi7reZLj9jHtyjCg==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345bc cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=yed-XLamZOV1dzPkC0kA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Sce4ySz07BkTf4nXMniNAqX6UKWWqM_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3547

Do not support 32bit arm and x86

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 classes/unsupportarch.bbclass | 2 --
 1 file changed, 2 deletions(-)

diff --git a/classes/unsupportarch.bbclass b/classes/unsupportarch.bbclass
index 3b8a6b1..1299743 100644
--- a/classes/unsupportarch.bbclass
+++ b/classes/unsupportarch.bbclass
@@ -1,7 +1,5 @@
 BAZEL_TARGET_CPU ??= ""
-BAZEL_TARGET_CPU:x86 = "x86"
 BAZEL_TARGET_CPU:x86-64 = "k8"
-BAZEL_TARGET_CPU:arm = "arm"
 BAZEL_TARGET_CPU:aarch64 = "aarch64"
 
 python __anonymous() {
-- 
2.34.1


