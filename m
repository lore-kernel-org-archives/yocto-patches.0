Return-Path: <can.wong@emerson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0CEC677C4
	for <webhook@archiver.kernel.org>; Tue, 10 Jun 2025 18:47:19 +0000 (UTC)
Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
 by mx.groups.io with SMTP id smtpd.web11.94522.1749581235012658554
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Jun 2025 11:47:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@emerson.com header.s=email header.b=0jvq4vmi;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: emerson.com, ip: 148.163.146.64, mailfrom: prvs=525646e39f=can.wong@emerson.com)
Received: from pps.filterd (m0359308.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGd7RA023709
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Jun 2025 18:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=email; bh=U4L85uHVtOM6mdcUZsxpMYBmfE
	2Edfw8rpSzU6Lv7TY=; b=0jvq4vmi44d4WSJGo1Id0wLaS9W1YnHtwCgHcx9jFS
	RikRecVj6IKOptIWYJneZ0vXizu4ObwHaT2lYO627o25RkWES6YE6K7HXprKEbqH
	dFpSCL19i1ZWEYVxFUHpTshrpYWxHaHXhXE3D0gotLdZ/q/gRaVl50T6sNixXUS1
	nPHiXsgrQsXj+FnKdgKRrLfFQ7pi91HzNIEehhTAr7JiAZy3gMZatGek/7eyIKnJ
	E1sBKGZyeK5MQ0/wXon1ilu6xlfe9Hp0AtTgF9DfeoqJB7vmWX94t05T7JqEJ4k+
	1GCZxQuMTWhmiaDgbT7X1wnyzMJ9Vkyhh0e/u5UN3X0g==
Received: from us-aus-excas-p1.ni.corp.natinst.com ([130.164.94.73])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 476rdf335t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Jun 2025 18:47:14 +0000 (GMT)
Received: from us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) by
 us-aus-excas-p1.ni.corp.natinst.com (130.164.68.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 10 Jun 2025 13:46:48 -0500
Received: from cawong-linux.ni.corp.natinst.com (172.18.68.32) by
 us-aus-excas-p2.ni.corp.natinst.com (130.164.68.18) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Tue, 10 Jun 2025 13:46:48
 -0500
From: Can Wong <can.wong@emerson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: Can Wong <can.wong@emerson.com>
Subject: [meta-security][PATCH] smack: Convert CVE_CHECK_IGNORE to CVE_STATUS
Date: Tue, 10 Jun 2025 13:46:46 -0500
Message-ID: <20250610184646.322255-1-can.wong@emerson.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=fIk53Yae c=1 sm=1 tr=0 ts=68487db2 cx=c_pps a=cVKeW2pxJVqlUTLH3Z+MUA==:117 a=cVKeW2pxJVqlUTLH3Z+MUA==:17 a=6IFa9wvqVegA:10 a=geDs06hvAAAA:8 a=opRPBEcDM4smz6OtnVQA:9 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE1MyBTYWx0ZWRfX2KE3A//aGhad IhQqdEu5MFrNz0j6NVYRNejPgifEV9Ds/T0eyeQ+fyAREMe9YwC8fz0s/TOsWDvBK37do7xR8uF g6QdhxLVMq7Htfylld8eEIq9uR1At5fdo13f9z03J9nZ+Y6StHfw2eKsIILntwJyNvmBME0I6Wt
 swudswERdb6B7JMn8b2ckjxeCYmVG7g/Tl7cbecjLMGKbRCW5FlivN7JgDpujapzEz1r3bnY7U6 uh7NshF0rvvRbdXwOniaQdjrLPlbxAMymhIUHLnX0MqI5ynZ1yrbKeI82pCvnqDHmy1xkyc5voi Bq2jbH1H0iHtozIMUb24jWrYqoq+N4HeO7PPCxZuolz09kf6MumKlFYYpSodgDoNykl2ZCb0Mu/
 UIbVlbwRSj0mN0KqVX3j0ZDZZjf/1uH5g1YOMP2vavFmFn55p1e64dz6TqSbqWPg9JTLwH4l
X-Proofpoint-GUID: Y3U9nVaFeRjS-OeyGuCRWuz7y6Fq98h6
X-Proofpoint-ORIG-GUID: Y3U9nVaFeRjS-OeyGuCRWuz7y6Fq98h6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_09,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=747 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100153
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Jun 2025 18:47:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1628

Signed-off-by: Can Wong <can.wong@emerson.com>
---
 recipes-mac/smack/smack_1.3.1.bb | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/recipes-mac/smack/smack_1.3.1.bb b/recipes-mac/smack/smack_1.3.1.bb
index 6c52392..1cd699b 100644
--- a/recipes-mac/smack/smack_1.3.1.bb
+++ b/recipes-mac/smack/smack_1.3.1.bb
@@ -13,10 +13,9 @@ SRC_URI = " \
 
 PV = "1.3.1"
 
-# CVE-2014-0363, CVE-2014-0364, CVE-2016-10027 is valnerble for other product.
-CVE_CHECK_IGNORE += "CVE-2014-0363"
-CVE_CHECK_IGNORE += "CVE-2014-0364"
-CVE_CHECK_IGNORE += "CVE-2016-10027"
+CVE_STATUS[CVE-2014-0363] = "not-applicable-config:CVE not for smack of smack-team, but other project."
+CVE_STATUS[CVE-2014-0364] = "not-applicable-config:CVE not for smack of smack-team, but other project."
+CVE_STATUS[CVE-2016-10027] = "not-applicable-config:CVE not for smack of smack-team, but other project"
 
 inherit autotools update-rc.d pkgconfig ptest
 inherit ${@bb.utils.contains('VIRTUAL-RUNTIME_init_manager','systemd','systemd','', d)}
-- 
2.43.0


