Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3C0CCF2C1
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 08:55:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31540.1768812944942027226
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 00:55:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=UyawzwsV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=54795483eb=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J6PA3n1307973;
	Mon, 19 Jan 2026 00:55:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=xHlQIO9l/
	l1yRvgC5LxYP+wE5US7etWeKQLvuqv+Bv4=; b=UyawzwsV6qOqJT3j+BksNUv0v
	nLhWAeHZKhm1UOSXYZmOrqTjzhTMde1PK5ORPKk4ke/W89mUXey0Nnyrp1yS9gQ5
	UmZ/S0eVqsqc8iwOf2c0ZqriPePPyca0gks2/ucnxswSgqUZc2clrcyGuJD5HOQc
	XU1UkFMkP62cD0tOpau5U1fV5+4EJROu/lY6Gsq+A2iDpSpXAhlwo0QLD5WJxW14
	IYItnOkxsFWy9Py7CHYG4azBhP3EBQkx5ViNu8ZQGTXjb9dL68/T2Lq94WjXQEgA
	38Aom+ZQEEAd+6tsoufZ48TBfDtY6KJ/BjUZlUtr2f6VTXZifR4oq0/FXWLpQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bratgs99e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 19 Jan 2026 00:55:43 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 19 Jan 2026 00:55:42 -0800
Received: from oak-lpgbuild14.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 19 Jan 2026 00:55:42 -0800
From: <Qi.Chen@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <jpewhacker@gmail.com>
Subject: [meta-mingw][PATCH 1/2] .gitignore: add more items to .gitignore
Date: Mon, 19 Jan 2026 08:55:41 +0000
Message-ID: <20260119085542.173678-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qQl2DtK6Gytww-pxpHExN41lQ8aCLgRK
X-Proofpoint-ORIG-GUID: qQl2DtK6Gytww-pxpHExN41lQ8aCLgRK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA3MiBTYWx0ZWRfX3csUEq29SQPs
 rmfEiZWmJAvWS9fxLUPGCp/rc8M0+K4kQ9+JTJxg/buQY2ek+gkp5n2uMTfuH5k03eED79swFl5
 OQUsEbunPPLetRV7Ld9WoqYRzfl/JmX+SkQoz2mp9bXBN0dF28mTSe/a4qx4T2esbf3dz0OMLfs
 IpoEHhUj1nb7EOlChe+SpDH+yJfT2xx0shr7HnBDFQoWuzBsNy+3Yjd/oztIV1tB3WqTeZLqtkq
 w7Yd+YBaFvu595feM+oF8SvXzkflyOeeziqUEQHSRTyEf8Houhj1KctZAv+PXCl5704hSfbPWg6
 BrMrPeaFI872bL8+A8g0hHtARcO+STSlqBdAI1EZ+eUgxrbNdcYp2zjHgdOaD/V1uKaKjI2TRuS
 dXJMlWUB2m7NXXkcRyA14Y6gYWqo6rje8WW7iIWYvaEMtmIVwZTyQtU7FXIV/O/OKxYEAsYIqUy
 tmloMJySj0Jl2dfMfew==
X-Authority-Analysis: v=2.4 cv=DY4aa/tW c=1 sm=1 tr=0 ts=696df18f cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=YHWljS73xwdwSZElqecA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190072
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 08:55:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3009

From: Chen Qi <Qi.Chen@windriver.com>

The change references meta-openembedded/.gitignore.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 .gitignore | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index 5da7ef5..c01df45 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,7 @@
 *.pyc
 *.pyo
-
+/*.patch
+*.swp
+*.orig
+*.rej
+*~
-- 
2.43.0


