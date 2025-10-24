Return-Path: <hongxu.jia@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF52ACCD1BF
	for <webhook@archiver.kernel.org>; Fri, 24 Oct 2025 02:56:26 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.1100.1761274577114165071
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 Oct 2025 19:56:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=R1c/glEv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=23920ed3f1=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59O0aENo2366956
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Oct 2025 02:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=wR9GGDYuh0qWsyykSx33
	vzHfDwo46bKeN9LaDe43cWk=; b=R1c/glEvSM8u22qH6Xsxy9GRGbgiPbyfh2kO
	JD5P8RU0Gr1LjnQe6+UVqWQHYHvkE5HCrM/9jPd9kNE30PeKuS3dZkQEsrhxRzwU
	4jJYDwBfZxZrbqzMdOy6G9MgG9BniX1TiKTRlBY3gJZmfbMDujNfwJr8xIc4jNh1
	0hVMxAGFNyPEfeetYgYOHGMostQNfATr79Iz4nVvOXblgZ4uDbjHzJ4bJusaZWZd
	1BCG5Qp5nJcSh0M6luSKCsG1xE2eF4jddr5+5by4cocZAlBmcRsp1YZh+qMfXmBD
	4cnFANRXp2mw77ge1uQdmafAPAjn5dsnHgDiiXmE4yZxDkUptg==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49y8atheua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Oct 2025 02:56:16 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Thu, 23 Oct 2025 19:56:14 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Thu, 23 Oct 2025 19:56:14 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] ecryptfs-utils: Add CVE tag for ecryptfs-utils-CVE-2016-6224.patch
Date: Fri, 24 Oct 2025 10:56:13 +0800
Message-ID: <20251024025613.941520-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=N9ck1m9B c=1 sm=1 tr=0 ts=68faead0 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=PYnjg3YJAAAA:8 a=danhDmx_AAAA:8
 a=t7CeM3EgAAAA:8 a=NELBC_J_JFTSqUUxlFgA:9 a=ZXulRonScM0A:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDAyNSBTYWx0ZWRfX/xk2m89IbQes
 MCykwnbJbt3FIw0Rt+fBzFZZNzcuG1remyjIamDWg0P6WbZlli9W3w7aL/S646VVH70dzWj/QZF
 RM1Y4tlrKnRYgFYxgVefmuEdA9yXt0dGr1GAFU7zeD9ArEAy0mE7oWAql5PBn7SqS1qupJxj3w/
 VslGkPUrCW9yLzUr99JUdlg3XooTy3GPTcu0OgCeK5+TqYGJvXBZ209AOTLr8auuwv59uLakldT
 pLq9D1i8Y+leV9H9ypAQ09mjbilEnwQ3mcod6gj2xnIE6XHcxDZQQLBHc3xcyMxPROcpKbXJDmh
 cSNiknxyPQVj0FpCSNJ3zUhjrty+uXy89TQhRrX6CaT2viY4eXl1uwNFx1XDWIouLY6W93Jo/Dr
 oI8EK0J3g+o5345u38P31OsgPIk2wQ==
X-Proofpoint-ORIG-GUID: -K9lkUMacVjYKQBOnQFK3I6YqPuGZbS9
X-Proofpoint-GUID: -K9lkUMacVjYKQBOnQFK3I6YqPuGZbS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510240025
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Oct 2025 02:56:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2389

Follow Yocto policy to add CVE tag to CVE patch

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 .../ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch b/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch
index a457d79..c0a86e9 100644
--- a/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch
+++ b/recipes-security/ecryptfs-utils/files/ecryptfs-utils-CVE-2016-6224.patch
@@ -14,6 +14,7 @@ the patch comes from:
 https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-6224
 https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/revision/882
 
+CVE: CVE-2016-6224
 Upstream-Status: Backport
 
 Signed-off-by: Li Zhou <li.zhou@windriver.com>
-- 
2.34.1


