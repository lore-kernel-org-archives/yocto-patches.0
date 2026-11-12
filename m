Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8081.1794465410603903072
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Nov 2026 22:36:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=nZqFYjm0;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: wenwfu@qualcomm.com)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC5nnUI442056
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 06:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3KapgxHLj7O
	D+vlJ0uOsngiplTrbXcWuhRIuzewGZ20=; b=nZqFYjm02nCIZmuXEMU0phIjtSi
	MHHA8NE1Ykvl72FUamBBJ2Wg69gN4ZQl9I2ht1EI9qDTyUgL2D83rIa8hEoFwtHw
	BedJBlAAJz8XHdtWnabGG3HO5oZgbNGmSXbOsjK/SWYm0lHVruVo69gD/cbHcEdH
	PnybfacQNAOUE5TzKtBr52JFMZnaHHdSI4x+bwxK47lgTBSi22H6hBc34+UkKwXe
	iJhGJXzCp9N3lo0uBjhxhdz3LuBABjrZEKrfWXlxs/q7PJB5IQkGCnJM2eX2Y6QF
	lQddip2w5++mnbQi2/QdWJ/9+pJTviCnNFOAI7e+mkr5ryHfFy85LJThL8A==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw7nc052q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 06:36:49 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC6al4J3991025;
	Thu, 12 Nov 2026 06:36:47 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AC6ak4D3991016
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 06:36:47 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id 15CC4AC6; Thu, 12 Nov 2026 14:36:46 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [meta-selinux][PATCH v4] refpolicy: update to latest git rev
Date: Thu, 12 Nov 2026 14:36:42 +0800
Message-ID: <20261112063642.728190-1-wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <19810872a41f8dd6ac59dae1aa8e722866cea603.1794462087.git.wenwfu@qti.qualcomm.com>
References: <19810872a41f8dd6ac59dae1aa8e722866cea603.1794462087.git.wenwfu@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: bW-uS2BaoVXhFzImLF8ju997a0e_YTQ6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAyNSBTYWx0ZWRfX4e+ZD195PZOr
 ha2U2yKTna6yjtFNaawCZ0jS1kIq/ex/cjcJYXp9vtZlcsx35YhPZRPWG9bDJZuE26CiI4ohdfC
 vJyA5/LV1tAOLxgDl/YZWNUaTCRcHe4=
X-Proofpoint-GUID: bW-uS2BaoVXhFzImLF8ju997a0e_YTQ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAyNSBTYWx0ZWRfXysW+lDnXzbEf
 VkGIfnm/o7yqKzen8iH6lP0GvGKSaH9Ly3zG9+HKzK4tYRfrOjFinu73cUwz3eXZvVryK4FN6Lx
 STyGheCFNsNbGS/frstDVOsP6UUhsz1u7mooU8Gydjh9ZMUtZODf0tyim9w7QUv9yPbmjN1f6vN
 nuXXUtTES5uKeg5APucUOD3TcF3N0Djoyhu0F/HvTw61k9a0cxmaNha7RnGv899vUnwq6sIM1iP
 XDs6MgIx2CpYaJhxtShTUgsf16TJTvEiYFRn8y5IhNRgx0xevoUUK6J0IBiUGX35J1+6vrY/ZtV
 +8CR7Qr0ZolliSxEDz6iuN7eY2GYZd5PWbRZZJD24UTmwy0U48rhPCBlQ/peDqIw9SuQdlFC2g9
 BQNnd+IfAAVQ3RirvkNuw8JFbMDKCKacAnOUuLatJKFf2epBMQkzOmnYvWK9OiOS95HdATb3N47
 v0JpLNNaJQziLFVkz9w==
X-Authority-Analysis: v=2.4 cv=A8b5rKWG c=1 sm=1 tr=0 ts=6af55e81 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=JDKqbpYzA1WO7QUIf98A:9 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120025
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Nov 2026 06:36:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5317
Content-Type: text/plain; charset="utf-8"

* 6072cfa851a3 unconfined: allow perf event access for
  unconfined domains

Assisted-by: Codex:GPT-6
Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
 recipes-security/refpolicy/refpolicy_git.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/refpolicy/refpolicy_git.inc b/recipes-security/refpolicy/refpolicy_git.inc
index dbc8cc8..67a727b 100644
--- a/recipes-security/refpolicy/refpolicy_git.inc
+++ b/recipes-security/refpolicy/refpolicy_git.inc
@@ -2,7 +2,7 @@ PV = "2.20260922+git"
 
 SRC_URI = "git://github.com/SELinuxProject/refpolicy.git;protocol=https;branch=main;name=refpolicy;destsuffix=refpolicy"
 
-SRCREV_refpolicy = "acf41c52116fef3a9dcd8f1f39b133e0372fce7c"
+SRCREV_refpolicy = "8f247dafb92bd12cbfb53a11ff58be17a88df86a"
 
 UPSTREAM_CHECK_GITTAGREGEX = "RELEASE_(?P<pver>\d+_\d+)"
 
-- 
2.43.0

