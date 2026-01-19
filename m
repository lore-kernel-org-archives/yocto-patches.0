Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D409CCF2CD
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 08:55:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31541.1768812945018430578
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 00:55:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=njC8vuWG;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=54795483eb=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J6PA3o1307973;
	Mon, 19 Jan 2026 00:55:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/8XraS3K82vYMFqGlGwFW1vxjfHjl8fsEwfQ56ZRhFs=; b=
	njC8vuWGut7CSMP3xq1kt9EhdaN7fUfatfWZAQnpD+p8n82Lao+O9OJ3x0np50PS
	+I77FIF+QCdiMrq2QOmQvSQkvDvK7+2RjzRHAAPbAZxK36biuNZSRc00DTsGIUfn
	/KjmyC6H09rSUUcRsZZ+knS4DkbNZdz9J9MpExboiNWVfUAhvrv2Mj4QOO/T2ZLX
	v4UgbuKhfO/kRlmCqt5njH8Jvmk+1/zGNJTndFTAokTli1cpiEjJFrAUlcY7n18I
	N0rogxg7n9l364j/15E6+PzZf6YeuZ8Szmf7WyN37RFmgcjZDtXgRIoStMBO1ae+
	/OPb/KZNvU/mLN0cWc0F6g==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bratgs99e-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 19 Jan 2026 00:55:43 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 19 Jan 2026 00:55:43 -0800
Received: from oak-lpgbuild14.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 19 Jan 2026 00:55:43 -0800
From: <Qi.Chen@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <jpewhacker@gmail.com>
Subject: [meta-mingw][PATCH 2/2] mingw_sdk_handle_symlink.bbclass: ensure no symlink
Date: Mon, 19 Jan 2026 08:55:42 +0000
Message-ID: <20260119085542.173678-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119085542.173678-1-Qi.Chen@windriver.com>
References: <20260119085542.173678-1-Qi.Chen@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kws-JCJgCBDl7a_bMnqU0YjAkjcnllfA
X-Proofpoint-ORIG-GUID: kws-JCJgCBDl7a_bMnqU0YjAkjcnllfA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA3MiBTYWx0ZWRfX4ITpQO5AJQBf
 x64yQfBsNPXYUY35tUj50znr9RH+ZzaTH2j5R4ieBdDOYduGEuvIHYciJwI7aNl0ugg6otdnWQd
 PXa+jMQ3+HIF303i65NLqHxSSMZjuJvZEKUEIrpHMCsxNLat5oHYHcTxSlXPLUnfjBMeeurwbfd
 rURK3t7iC3hPZKYapHvdFrqeml5GsWLNDs8w5GhGKXylbcSg008px5/xcodw6jnXWWm6IhqSIAB
 opGe4JfMRb+u01uz9+ggnahtWtStosQuCCrGQ7yufPpjLBxFuVT6VCjflTNbd4PfpMwv1uUUNzd
 pjj1S5Zuj4H1+l1GI35EbAPehG++BEXvpsypjIVTYImUTbW1hAu3zZJ8fNAImEAGIn6trWg9K8q
 N8UzStMnGu4RngDd8XaaQmV+CUCcDatgptO3EbR+gUMWdkcjJxEBWSc9XYYuZ4UnATq3tap/GsH
 zl9gYW0+aysl1eU5U6g==
X-Authority-Analysis: v=2.4 cv=DY4aa/tW c=1 sm=1 tr=0 ts=696df18f cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8
 a=ZXI_tkCQFL9tNNBlX2oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190072
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 08:55:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3010

From: Chen Qi <Qi.Chen@windriver.com>

Previously, I deliberately left these dead links as they were.
The purpose was to give users more information. However, this
is not correct. Because on Windows, extracting the SDK will
give users error about these symlinks.

This patch fixes the above error by:
1. Remove original invalid/dead symlinks.
2. Remove newly generated symlinks.
   This might be a little confusing. Normally, there will be no
   such newly generated symlinks. But in case of multilib, there
   will be something like xxx/64/32/64. The last 64 is a dead
   symlink and it's useless.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 classes/mingw_sdk_handle_symlink.bbclass | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/classes/mingw_sdk_handle_symlink.bbclass b/classes/mingw_sdk_handle_symlink.bbclass
index e158d14..c009509 100644
--- a/classes/mingw_sdk_handle_symlink.bbclass
+++ b/classes/mingw_sdk_handle_symlink.bbclass
@@ -6,10 +6,13 @@ archive_sdk:prepend:sdkmingw32 () {
 			find "${SDK_OUTPUT}/${SDKPATH}" -type l -print | while read -r symlink; do
 				target=$(readlink -f "$symlink" || echo "NOTVALID")
 				if [ "$target" = "NOTVALID" ]; then
+					bbnote "Deleting invalid symlink: $symlink"
+					rm -f $symlink
 					continue
 				fi
 				if [ ! -e "$target" ]; then
-					continue
+					bbnote "Deleting dead symlink: $symlink"
+					rm -f $symlink
 				elif [ -d "$target" ]; then
 					if [ "$parse_type" = "directory" ]; then
 						rm "$symlink" && cp -r "$target" "$symlink"
@@ -21,5 +24,12 @@ archive_sdk:prepend:sdkmingw32 () {
 				fi
 			done
 		done
+		# With the above symlink handling, we've copied correct contents.
+		# But we still face possible newly generated symlinks in the above process.
+		# For example, in case of multilib, there will be links like below:
+		#   x86-64-v3-poky-linux/lib64/x86_64-poky-linux/15.2.0/32/64/32
+		# This xxx/32/64/32 is a useless dead link and we can just remove it.
+		# Anyway, all these newly generated symlinks can be deleted!
+		find "${SDK_OUTPUT}/${SDKPATH}" -type l -delete
 	fi
 }
-- 
2.43.0


