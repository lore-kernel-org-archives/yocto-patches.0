Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D0DC3ABAC
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 11:10:34 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.73693.1746529828229748589
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 06 May 2025 04:10:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7221054752=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545L8saU032469;
	Tue, 6 May 2025 11:10:27 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46d8c1321p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 06 May 2025 11:10:27 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 6 May 2025 04:10:25 -0700
Received: from pek-cli10-d2.wrs.com (128.224.34.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 6 May 2025 04:10:25 -0700
From: <changqing.li@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <richard.purdie@linuxfoundation.org>
Subject: [error-report-web][PATCH 0/1] settings.py/settings.py.docker: stop using already removed settings
Date: Tue, 6 May 2025 19:10:23 +0800
Message-ID: <20250506111024.1597505-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=NIjV+16g c=1 sm=1 tr=0 ts=6819ee23 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=dt9VzEwgFbYA:10 a=t7CeM3EgAAAA:8 a=lN_q4-FkxNDjc-oY0wAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Rzt_fPV11wVqbwf7-wak37503t1TPtg2
X-Proofpoint-ORIG-GUID: Rzt_fPV11wVqbwf7-wak37503t1TPtg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEwNiBTYWx0ZWRfX+I/20ofpWc9b Tr2hElYfVu+MAcPlW1QisgTiWy9B0RTpZfn9Qcq903b55AddqrsgTdNZxhMViHGTI3jsJPxDojm vL3F6VXJvAJBAXynaxAecWJUrVk7j4eVYabHhel8Bvc4hyOSMjhD2uuALCDbT6nyvyJzy6XQOtb
 IR2dbGDG5hCcbfdXlR/dCulIMRkjKv5e4WwoyO3bpEXXNgtq+FXwiv4OdCMYpu4WUy7aTFtbdFb cfTtVyTefueUrbrpTQNl9ge3Yp/cUPO3vm3gKsGEFi/9ioEb1naqFgQdFieaMEfPg6jSeTeCRlh Blzh9A3g4/MH+JhFrPcx/plAyY4Pihy9UHEb69slIkKZBKjL9n3xq3V/YlXh7f3BA/HAsd0kquW
 yNAddMpCtaHvnRjX4Ih75Af1hC5Su/5KxcxY4mNCkwjpheT+P5z/uKz3JaKmhD6xXZ4XgGBB
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=671 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505060106
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 06 May 2025 11:10:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1519

From: Changqing Li <changqing.li@windriver.com>

Hi,
This commit is based on the following changes on master-next of error-report-web:

f360c90 Dockerizing error-report-web
69217a6 Update to compatible with python3.10 and django5.0.3

Changqing Li (1):
  settings.py/settings.py.docker: stop using already removed settings

 project/settings.py        | 8 --------
 project/settings.py.docker | 8 --------
 2 files changed, 16 deletions(-)

-- 
2.34.1


