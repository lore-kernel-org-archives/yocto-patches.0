Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A54C87FCB
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 08:50:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.30614.1753865414883004402
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 30 Jul 2025 01:50:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0306305b98=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 56U8SXT82903763
	for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Jul 2025 01:50:14 -0700
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 487fwtg0ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 30 Jul 2025 01:50:14 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Wed, 30 Jul 2025 01:50:13 -0700
Received: from ala-lpggp7.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Wed, 30 Jul 2025 01:50:13 -0700
From: <liezhi.yang@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] ecryptfs-utils: Add CVE tag for ecryptfs-utils-CVE-2016-6224.patch
Date: Wed, 30 Jul 2025 01:50:17 -0700
Message-ID: <20250730085017.785790-1-liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA2MSBTYWx0ZWRfX2wh/D5LD0bkf
 Obr6rl5f7J6ilKEfgaqTi8p5H0zJGxVEeTx07HUavEo/Ucl1ZZxACXlx3pvAganYHw7NU86IVeW
 3auiHhxkfwhjOtYzeXI3ShFBdTqBYxqgZfK8mFbqg77lYMxqdnNPkbaz7xK/UhRckoSPgWGBpV+
 kVyf9qIYqb7aQNefDX2RyJutWpcazXJOz66ZSvQFtgHjZ3nmLr1QOJ1zD+RsJVsyiXsYR6tTKvQ
 vuzT7GW1T/PxIcljHKrINJCnyZTKh2BfA9+xR0WGNWUN+FRH6ffSlNCXCeHsSxXaNqF75bzCzCj
 Nox6ddn6FBUzgTJ6wIE1kmAxcOQk6nXM+VtRsUATwbiPaaJ1bKDJ3ueoVHZob9r19W/xjeW2hLq
 qqE6CcNn
X-Authority-Analysis: v=2.4 cv=MbVsu4/f c=1 sm=1 tr=0 ts=6889dcc6 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Wb1JkmetP80A:10 a=PYnjg3YJAAAA:8 a=danhDmx_AAAA:8 a=t7CeM3EgAAAA:8
 a=NELBC_J_JFTSqUUxlFgA:9 a=ZXulRonScM0A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: rLkdE6xfuisNGBeV0aHAswXe3-5QTY1P
X-Proofpoint-ORIG-GUID: rLkdE6xfuisNGBeV0aHAswXe3-5QTY1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507300059
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 30 Jul 2025 08:50:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1876

From: Hongxu Jia <hongxu.jia@windriver.com>

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
2.49.0


