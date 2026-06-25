Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6132ECDE002
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 08:27:36 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4984.1782364701431041231
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Jun 2026 22:18:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=df1PkQZt;
 spf=none, err=permanent DNS error (domain: oak-lpgbuild12.wrs.com, ip: 205.220.178.238, mailfrom: prvs=0636eea621=sj10@oak-lpgbuild12.wrs.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3gfhX335686
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 05:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=e604lg8p9
	8WscC72cdPoBQhVWO3G4jVXDGFNhV1UzdA=; b=df1PkQZtlzaqwStgeep+TE2Rk
	RiNobcjnoBq9fvsN96dTJpbH3BVdf2YYNexkwAlAjRpbFYit5SYlLx+TERrnthuz
	8kwJ3jxWctZ1xnRyQ3WOmpEOER0kLJkbFiJyUafxrsASe2OLCu3hY3AFipqKc09E
	HcHaThgk7/P3I9c32RK1/bjRzvUFlt1zoaxk280DGj0xtHXIZco0jH42CZK19o4p
	iT3vegK52gtdgkfFG1sviD8Ls0Tk6D1xj+RlHE8oH3tfvJO24/6vMpxEnnvTosox
	H//LzAAVCe2qxT1Sqao74U9BhCPOV/EfFA6idbVcCxxvCID7F4yTW+35pLgug==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f0t5dg6f6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 05:18:20 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 22:18:16 -0700
Received: from oak-lpgbuild12.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 22:18:16 -0700
Received: by oak-lpgbuild12.wrs.com (Postfix, from userid 1762445396)
	id ADAEF39001A5; Thu, 25 Jun 2026 05:18:16 +0000 (UTC)
From: "Sandeep J" <Sandeep.J@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <Shiva.Komati@windriver.com>, <Randy.MacLeod@windriver.com>,
        Sandeep J
	<Sandeep.J@windriver.com>
Subject: [meta-security][PATCH 0/1] Fix broken URLs in meta-integrity and ccs-tools
Date: Thu, 25 Jun 2026 05:18:15 +0000
Message-ID: <20260625051816.1844262-1-Sandeep.J@windriver.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0MyBTYWx0ZWRfX0FOhcrJ6zO1O
 /4FQEpBoR9Na8h2yZ/1AsrdOVhsUxTJYW4F0sbHrrEFrAeCVq1gtjIRRVFx8xw4epuoa9s8+WWx
 bNqYNbKQrdm75onmRgpUQi6bM5S+l4tETN2K3HM7uypf8IIn6VLT
X-Authority-Analysis: v=2.4 cv=HOvz0Itv c=1 sm=1 tr=0 ts=6a3cba1c cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=TSbVqHtbAAAA:8 a=H6WxVz_VAAAA:8
 a=VsT5YW_RUjPDzBQFJcQA:9 a=NJcUIoPEKLAEIzHnl83t:22 a=ejRDv7XJuw7nbi7PrmUL:22
X-Proofpoint-GUID: LTwbn8ki4Hb0m3WmyN2A53523k09fTKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0MyBTYWx0ZWRfX08vIsyttCHqQ
 FbP06wIzRAVtY42yxh5B2GLuyOpxJUBj2WlG0zCXSYedG/cLADE1wrKDAgpihuax5M8m7LcRK92
 4/fH1NEQ6SpwOGUPFONHQowFmoajYLS1+7w4r/KvtOUzecNuEc9OVi/8MTXNrzBQNinKOZhPCwc
 YDtW9jSq+thTZAwOSpGhYo7e/hs713qAuNsKWKYpm2g8/uUlX5RziwwyppFM/pJBudp2HYGK91x
 g64895AYCLrINo44cxJEoCUuTGrQ+AIxXbK71MlRHKfCRGAqbaw+vpB1okk9Y0r1ml3EWv0akgk
 /j8V8282dNT4abCRKucjxaC963ViCBwElm6otbC3PX2w6tCweTOrzL5/6pQdS86CAWaFMcqu/Jz
 sQO02e0mEvg3v1DN0hcZaBc6Tx/yUEBpMb+ltpbu9PASaDMpcyq2cCvvo2YPEGRIk2XaQ2jxkDw
 QtPP3F1VuiWO8DUVW5A==
X-Proofpoint-ORIG-GUID: LTwbn8ki4Hb0m3WmyN2A53523k09fTKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250043
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Jun 2026 08:27:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4302

The gmane.org service is no longer available and lists.tizen.org is
also down. The Wayback Machine archives are the only remaining source
for this content (thread: "[Dev] IMA/EVM", Patrick Ohly, May 2015).

If there are better replacement links available, I'd be happy to
resend with updated URLs.

Sandeep J (1):
  README: fix broken URLs in meta-integrity and ccs-tools

 meta-integrity/README.md     | 4 ++--
 recipes-mac/ccs-tools/README | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)\


