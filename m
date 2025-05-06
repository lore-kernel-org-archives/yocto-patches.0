Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C37C3ABAC
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 11:06:14 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.73208.1746529571764260112
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 May 2025 04:06:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7221054752=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545KZ3SC015791;
	Tue, 6 May 2025 11:06:08 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46d8c131x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 06 May 2025 11:06:08 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 6 May 2025 04:06:06 -0700
Received: from pek-cli10-d2.wrs.com (128.224.34.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 6 May 2025 04:06:05 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <thomas.perrot@bootlin.com>, <richard.purdie@linuxfoundation.org>
Subject: [error-report-web][PATCH] views.py: fix test failure
Date: Tue, 6 May 2025 19:06:04 +0800
Message-ID: <20250506110604.1596570-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NIjV+16g c=1 sm=1 tr=0 ts=6819ed20 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=s2mQxAE5ZXY17blSPIwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vpncBrmapJFjMYpbLt1kRDE5cI4Tsryn
X-Proofpoint-ORIG-GUID: vpncBrmapJFjMYpbLt1kRDE5cI4Tsryn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEwNiBTYWx0ZWRfX8ni5HNruVSI+ mQNfgC6OblZnmCJjc+wy5fqQgHhnM1iFRLwcRqHKY9ChRA8GooEOUQohsIFl0HOYpw/qg+VbuF2 uHmty3t4vHzUibce2EMptxfj6Kt3HeZkGvgJIuWRT0OI7qcCops4+rVhf9Nv8rK36kOuy2ZeMUi
 oti5XiabSmkoJRDVGU576V1QWfOqR9jsPRJCxre0/TWTTRX+oJihN2Sqs7XVGeKmJRvFAQFDC9s dMUEZbs0EDTwcOAWihEVzn43k1c1wuUOfLDtncK98tlx/gW8D7V/GWOUyLPCy/bJtolhCcx35PM nfp0H62FAa7Q7SqWOUm9jL/MqM7pgvzlGN7DC6nncT2ghKhRsKm8adBRPk3DGhInxevNYsIwIj0
 wafdvlIZXM8TgTUM8Z06Ijs9aDGr2y3iAOVQnHgZNlQt+y2LvKRUEvDpMSNch4RwKVNu025M
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=983 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505060106
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 May 2025 11:06:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1518

From: Changqing Li <changqing.li@windriver.com>

Fix following failure:
$python -Wa manage.py test
...
File "/path/to/error-report-web/Post/views.py", line 55, in addData
    version = re.search(r"send-error-report/(\d+\.\d+)", user_agent).group(1)
AttributeError: 'NoneType' object has no attribute 'group'

Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 Post/views.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Post/views.py b/Post/views.py
index f4e16df..c294afd 100644
--- a/Post/views.py
+++ b/Post/views.py
@@ -52,9 +52,13 @@ def addData(request, return_json=False):
     if request.method == 'POST':
         user_agent = request.META.get("HTTP_USER_AGENT", "")
 
-        version = re.search(r"send-error-report/(\d+\.\d+)", user_agent).group(1)
-        version_parts = [int(part) for part in version.split('.')]
-        if version_parts >= [0, 3]:
+        version = None
+        version_parts = None
+        m = re.search(r"send-error-report/(\d+\.\d+)", user_agent)
+        if m:
+            version = m.group(1)
+            version_parts = [int(part) for part in version.split('.')]
+        if version_parts and version_parts >= [0, 3]:
             data = request.body
         else:
             # Backward compatibility with send-error-report < 0.3
-- 
2.34.1


