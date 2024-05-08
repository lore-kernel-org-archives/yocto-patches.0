Return-Path: <mingli.yu@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ECAC04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 07:04:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.6188.1715151855524250338
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 00:04:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Pd5yV6vD;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=5858e7204a=mingli.yu@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44870Fgm000906
	for <yocto-patches@lists.yoctoproject.org>; Wed, 8 May 2024 07:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=F4pYM
	F6RoWgDBkqrrLQm8VgTmK20tGgeKYeawjgqiDE=; b=Pd5yV6vDSSHLphaR4Ab5d
	5VOrctTqTCMY5WaNhxutuV58qNiJgnZdSIsUMyZ5BB9DXuSOlONqa+FW4fCuiuvv
	HH6CUNGPY5s2Vy94Sir6meLjuhsiFYmGKqqsdiJIpDmoZrRSjujEKgKZ6JaLDFXr
	CxxWe5MlQjeP0epnA0cz1J84F2wsAr0X4rizER0kpIxkontINQTeoumYEcA1YttH
	8BMcOLwO4LXYPoHDiS2WjHXoZi0oNWY4W6Fq/DSoP3cOFSBFR867YG5K26vnX0fz
	BDml4xoyWxZ/XVaf6aAdHfYh3iGZbkhYca9aeoeBblmzPVqowxVBT8Yuedy/h3Vk
	Q==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xysn50gcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 07:04:14 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Wed, 8 May 2024 00:04:13 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.37 via Frontend Transport; Wed, 8 May 2024 00:04:12 -0700
From: <mingli.yu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [yocto-kernel-cache][PATCH] preempt-rt: add bfp configs by default
Date: Wed, 8 May 2024 15:04:12 +0800
Message-ID: <20240508070412.2939015-1-mingli.yu@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tPHcV1WwJT7bNI819136mz5oyLusHS1k
X-Proofpoint-GUID: tPHcV1WwJT7bNI819136mz5oyLusHS1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_02,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxlogscore=646
 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405010000
 definitions=main-2405080050
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 07:04:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/89

From: Mingli Yu <mingli.yu@windriver.com>

Userspace functionality that requires BPF is becoming more common,
so enable it by default [1].

[1] https://lore.kernel.org/all/20200224140131.461979697@linutronix.de/

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 ktypes/preempt-rt/preempt-rt.scc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ktypes/preempt-rt/preempt-rt.scc b/ktypes/preempt-rt/preempt-rt.scc
index 7ff7c0a8..a5e345f9 100644
--- a/ktypes/preempt-rt/preempt-rt.scc
+++ b/ktypes/preempt-rt/preempt-rt.scc
@@ -39,3 +39,4 @@ include backports/backports.scc
 include features/rt/rt.scc
 
 kconf non-hardware preempt-rt.cfg
+include features/bpf/bpf.scc
-- 
2.25.1


