Return-Path: <mingli.yu@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB3CF3182
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 09:18:25 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2804.1763543902502799923
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 01:18:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=S3GNbOUc;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3418d22515=mingli.yu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJ7sjNg1457104
	for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 01:18:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=UK3cD1Xlozv9i++N0xgB
	1zZ7ASLiY+mduQCQ32adGNs=; b=S3GNbOUcDSkctWHo7hkTwUb9op6Y4kOhH07X
	y9Gfx3cHP8fw5uF+TwP9yYeWp7VGYWdI1i1BcCsbE6hpBT+fe/POEfuYS+TjcXR5
	UABwaZoHB1P5RpTdi3h388sQgdEBnKknYV+UETQnx7ci/Pi2fPmcyFFJzWjnHG5z
	1ZkR+XF3eCo2bj/U+xE7KGdoY+cSb90a8sMDQd5oD0eT848cuMM95ojGOLBGatLs
	UN5tgM/pq46o7bCvGuR2tEja9UzWnpVd7cIx2rGVB8u7D1ukr1I8upsig90uUn20
	o8/MjkzZKWcaNv4WW+zvGMC+mB0ixbCkuh83tmOcY240sCILUA==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aeswjckr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 01:18:18 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 19 Nov 2025 01:18:17 -0800
Received: from pek-lpg-core4.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 19 Nov 2025 01:18:17 -0800
From: <mingli.yu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-yocto][PATCH] bblayers.conf.sample: Correct the layer path
Date: Wed, 19 Nov 2025 17:18:16 +0800
Message-ID: <20251119091816.971110-1-mingli.yu@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BqiQAIX5 c=1 sm=1 tr=0 ts=691d8b5a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8
 a=t7CeM3EgAAAA:8 a=_L_8L3imjwLatImfotoA:9 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: HFYS97jgp3LkhMlY_6ykfYKTgnDxTgoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDA3MiBTYWx0ZWRfX+dXodHemAWUf
 WwTd6KRT0l7wL5LNc4wPcTfqZwkOxR66ney4+i3SCLMiU4cZ5sa1h/Y2aBOvmPZQlcHHE6fp3+3
 x+8r5IO1+Ix8FXA5kBO8ZgfIhVm+pacDU+4XSFTqylBpBHQQ12v3Sl/E07vnpVB5JbDU9B2cvx/
 nVML7R88DExL9C7dZlfg2icuvRyJurMoUGm7uzcXbve8UtLqMrxyI3czvANwR6f/sbA7ooqRTZ+
 Dus/xhTAtPg/EEiZU2scMofEr1NbXjaeh6SkWJABMQzjxTk09CHaMiXjIE6nSapWZX8CFqaafAT
 78hYBUjJku8LpDYkrLgL2boNoXfWuI0k7E5lv6MZHZw8h8wai9jUK/zKFX7C69WHa3yfWsbiZ+s
 eYOll/twv8yYm58fRLxq10XyR88KeQ==
X-Proofpoint-ORIG-GUID: HFYS97jgp3LkhMlY_6ykfYKTgnDxTgoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190072
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 09:18:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2583

From: Mingli Yu <mingli.yu@windriver.com>

Fixes:
   $ cd $prj
   $ mkdir layers/
   $ git clone  https://git.openembedded.org/bitbake ./layers/bitbake
   $ git clone  https://git.openembedded.org/openembedded-core ./layers/openembedded-core
   $ git clone https://git.yoctoproject.org/meta-yocto ./layers/meta-yocto

   $ TEMPLATECONF=$PWD/layers/meta-yocto/meta-poky/conf/templates/default source ./layers/openembedded-core/oe-init-build-env

   $ bitbake core-image-full-cmdline
   ERROR: The following layer directories do not exist:
   ERROR:    $prj/layers/openembedded-core/meta-poky
   ERROR:    $prj/layers/openembedded-core/meta-yocto-bsp
   ERROR: Please check BBLAYERS in $prj/build/conf/bblayers.conf

   [YOCTO #16070]

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 meta-poky/conf/templates/default/bblayers.conf.sample | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-poky/conf/templates/default/bblayers.conf.sample b/meta-poky/conf/templates/default/bblayers.conf.sample
index 8b1cbdf..d34b552 100644
--- a/meta-poky/conf/templates/default/bblayers.conf.sample
+++ b/meta-poky/conf/templates/default/bblayers.conf.sample
@@ -7,6 +7,6 @@ BBFILES ?= ""
 
 BBLAYERS ?= " \
   ##OEROOT##/meta \
-  ##OEROOT##/meta-poky \
-  ##OEROOT##/meta-yocto-bsp \
+  ##OEROOT##/../meta-yocto/meta-poky \
+  ##OEROOT##/../meta-yocto/meta-yocto-bsp \
   "
-- 
2.34.1


