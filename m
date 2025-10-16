Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC794CCD185
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 03:43:48 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.313.1760586221209594517
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 15 Oct 2025 20:43:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=pkH2hO51;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=238448c8df=changqing.li@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59G2ogLV2768727;
	Wed, 15 Oct 2025 20:43:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=IK/vXtEU9
	CnHkD+JWTcg0UhzbKX4hydpTmNnbtHOC0c=; b=pkH2hO51LVgcnm8iAs6Iw1TnZ
	e7GrWo4EbZ946vWux4QsKdos3eDnPWh9AbGgPswWDq38hEBdIx2UYh2Yq+TFU36+
	FP9iYpo6nsAYJj14TeMjgnnkzZHsFgvKWWm9l1WUQ8dhYJ2Y9Iw0G3o7yudZ6FsM
	7lK2MDQCvfTasZMAuuQx3HCCxXxeo8r78yuVVHKs9KqAmNbgaFwEm5a9oqn5rgO8
	RgEn+B1xSHBojO6PKfsahx+Gxmu7Orz0vedYgPE0JZ0mfgkJQB/HZUPj1dQm2mO8
	HYYIxjEULWRvLHhWOTkqg5jHrxKfTYjeWuTddJD88DmknL5eMzcXVF/9kt8JA==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49qprdwf2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Oct 2025 20:43:38 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Wed, 15 Oct 2025 20:43:38 -0700
Received: from pek-lpg-core6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Wed, 15 Oct 2025 20:43:37 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <jpewhacker@gmail.com>
Subject: [meta-mingw][PATCH] mingw-libgnurx: use -std=gnu17 for compilation
Date: Thu, 16 Oct 2025 11:43:36 +0800
Message-ID: <20251016034336.115357-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAyNyBTYWx0ZWRfX7BPhe3FYLF4/
 68KbbmKsQFdQMm09dapIy5kQLSEMCxJ7RJ2syHBb/2cbbNHpeiVG7+4uL7ZDGoKl9XAVC23Ufr7
 os5QgWZn/QIJfXwt6hE7VlnOrazainj2OJXxbDNqfPl1jQfVfZHOWe9bqz0Vh/1cSz5Ci45uM75
 0ZsclJjtg8KyPr5X5VxrJTGl0kNN7q1Y3ljAUKm43UM6swpohUqkKi/WfOB/Jbc9gxvOCdyV3cy
 wBAzFQgmEvfQ3o9qYF6txy6uiqAfl2HtwADnwGxfW/V+iBDmwIOFuOWVE+FjbivlJsr2IWIPU33
 UXmJiyf/LPQZHiwnXdXh9Xxvix+aUDWK7umd4JpCUQYfOhr0w3ejdeYZCCqNP8l0mxIO2xxg8Ll
 J/6qB4ruRanYGhqQoVihg+UO3tFUdA==
X-Proofpoint-GUID: XnGL0B--ktADC7Zn5hZRPkGg7MEh1fjZ
X-Authority-Analysis: v=2.4 cv=JaKxbEKV c=1 sm=1 tr=0 ts=68f069eb cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=mDV3o1hIAAAA:8 a=t7CeM3EgAAAA:8
 a=NSbZ1nDFmR-drwC9fdAA:9 a=f0gDK3h1-Z0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: XnGL0B--ktADC7Zn5hZRPkGg7MEh1fjZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 clxscore=1011
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510160027
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 03:43:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2309

From: Changqing Li <changqing.li@windriver.com>

mingw-libgnurx does not build under -std=gnu23 which is the default of
gcc15. Forcing -std=gnu17 fixes these build errors:
    In file included from ../sources/mingw-libgnurx-2.5.1/regex.c:61:
../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:16: error: cannot use keyword 'false' as enumeration constant
   49 | typedef enum { false, true } bool;
      |                ^~~~~
../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:16: note: 'false' is a keyword with '-std=c23' onwards
../sources/mingw-libgnurx-2.5.1/regex_internal.h:49:30: error: expected ';', identifier or '(' before 'bool'
   49 | typedef enum { false, true } bool;
      |                              ^~~~

[1] https://gcc.gnu.org/gcc-15/changes.html

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
index 4547298..03a61a7 100644
--- a/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
+++ b/recipes-support/mingw-libgnurx/mingw-libgnurx_2.5.1.bb
@@ -11,6 +11,8 @@ SRC_URI[sha256sum] = "7147b7f806ec3d007843b38e19f42a5b7c65894a57ffc297a76b0dcd5f
 
 inherit autotools
 
+CFLAGS += "-std=gnu17"
+
 # Specify any options you want to pass to the configure script using EXTRA_OECONF:
 EXTRA_OECONF = ""
 
-- 
2.34.1


