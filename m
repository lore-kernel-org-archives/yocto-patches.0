Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A3D4A5FE
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 05:05:23 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.169.1768539915029113934
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 15 Jan 2026 21:05:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=RPGLIiag;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=54767f529f=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60G4BGvR3796726;
	Fri, 16 Jan 2026 05:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=tC1o3udf4
	gGJBvj7neiVF2GnoO1hRdvrPsnnW7iJFG4=; b=RPGLIiagM2bg3EtU5UiLHcM3n
	RPy3xtBkl1JekRcbzoY3GAXMAI7aOoytVg1wOc47SPInvLL7XcCyogyQStsF6yYp
	hqhw47zACbV46sxRhjMDkWfLyKDBdbZQbgYUthbcO72Jhdi/OC2ol9dlLt/hP52V
	ND0zDoBFlSMCkk5IU08QkDmu+2bKuW1YNRSGPGJSgEJf+v9dJMAZuyRpC0hpt/Bu
	QXNgHkaOCX0wZ/rN8bnQgcPxZyUeV5d4S1d5theY+FZjSaqfcQD8zzgAOyCtVbe+
	S98CQDIUn35SF/EJ7IetlFebVd9t+AlM2tOTnPg83OY2LzOG3dy5rv6v243lg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bqd7y82bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Jan 2026 05:05:13 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 15 Jan 2026 21:05:12 -0800
Received: from oak-lpgbuild14.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 15 Jan 2026 21:05:12 -0800
From: <Qi.Chen@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <jpewhacker@gmail.com>
Subject: [meta-mingw][PATCH] mingw_sdk_handle_symlink.bbclass: avoid using non-posix -d option for read
Date: Fri, 16 Jan 2026 05:05:12 +0000
Message-ID: <20260116050512.3751871-1-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: V6GZFobGVLFow4qYi39zATsx-VLMXER3
X-Authority-Analysis: v=2.4 cv=FPcWBuos c=1 sm=1 tr=0 ts=6969c709 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=ZAnmOsV7Th_jmlSXHOEA:9 a=zZCYzV9kfG8A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: V6GZFobGVLFow4qYi39zATsx-VLMXER3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAzOCBTYWx0ZWRfX8Xz7Np+c+OJ+
 iU3xAUP8I38b4oFgIkO60CDUZksNucrjCc351VF9kyK40YZgqj2GbwCYAnaEMETSKKntHwmSNVG
 ZkeUgdbfiZPCajg7FILsO+TfGG/rVpi44QLmg7RlzB2N2NFxZfqXf5h+Goe9AHwtxxI4xTkq22H
 FP6fV6tp1mB7k+obkA6XKUCek1oI51afIY22lBcQKdQ3BD1gohFwLXET8GlmhGQix6rikKuEtt4
 d3o+98t94xiCWXd3s7cvDC4c9fxQFZvwM6HBoTwS7mGRI21Vo7l8FgGOHJvj7LVUSgb9o7FqXUq
 OQHMhDvG5P82S4kNM2wb8JnTxPilPtcQVgFmwJ80cSNKSR5Ga01LsnrbHapD5RBzBaVyZlOi3yf
 q8xjqvfTf2KNgLNEwYBzxYH7uYhVgd50u7VMZz4aKyqky6DO+YXhVmCtWJDTK+enV47CoBB0mXp
 aNLnmk2LxqQMt38vGdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601160038
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 16 Jan 2026 05:05:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2996

From: Chen Qi <Qi.Chen@windriver.com>

The '-d' option for read is bash specific extension. We need to
avoid using it.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 classes/mingw_sdk_handle_symlink.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_sdk_handle_symlink.bbclass
index 2f6dbe6..e158d14 100644
--- a/classes/mingw_sdk_handle_symlink.bbclass
+++ b/classes/mingw_sdk_handle_symlink.bbclass
@@ -3,7 +3,7 @@ WINSDK_NO_SYMLINK ?= "0"
 archive_sdk:prepend:sdkmingw32 () {
 	if [ "${WINSDK_NO_SYMLINK}" = "1" ]; then
 		for parse_type in "file" "directory"; do
-			find "${SDK_OUTPUT}/${SDKPATH}" -type l -print0 | while IFS= read -r -d '' symlink; do
+			find "${SDK_OUTPUT}/${SDKPATH}" -type l -print | while read -r symlink; do
 				target=$(readlink -f "$symlink" || echo "NOTVALID")
 				if [ "$target" = "NOTVALID" ]; then
 					continue
-- 
2.43.0


