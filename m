Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8459C103A985
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:37 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13686.1774405051154415629
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=cKvQoWhJ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ONajiA1449120
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=AzM04MdmqT1pTBNkBB4VcjlicIsRDPrjg+J4MuzvzH4=; b=cKvQoWhJCgSY
	v+o7uEHI+qHQpCEuNi2zV7YouAmDajXRhKURl3dD6keVH/TlqDs5eAeB7KCI5/4j
	maa2FIhBPt+x2slu/YtguiybG8QzmOgsCHNW9MBh5Eo9o/3blpzFsJM2OB2BbzPJ
	D0keXE0TTaUQfsMI8gqhtLyNND9iLstWPJt/huchStrMtJypHXy9nDJdfkFnapSu
	x9o/rqdBK3x0fatHKRfzH6BAbL5Mo44MLf6qYRRwyhYrmfxb/FkcCp6OLXnV3gL/
	MJ2C0/ER8+snLigqn4ZsTRj5mynT9l0/hVT3iryyBJ9gfekoqp0+QAHP2e1ecVPU
	dkG6y+ZAiw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6vcp9-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:30 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:29 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:28 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 9/14] bazel-native: fix compile failure
Date: Wed, 25 Mar 2026 10:17:14 +0800
Message-ID: <20260325021719.1526525-10-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX1hPfEuuwfmFr
 GN2ReS3OHiMGdFvNvIUHTbZ0X3xPQp5C2yYV9lfA5F3B6A5qiONC1wxyo4Cz36KddJ9K6jy7Ihc
 9bV0N1jYxHf4nVFCvLFgjtE6MM3xdw7lBEx8Bz4NCsrC47Ue50fO/y4a9WYF9SDufWWbGaVu511
 AN7rYxU/XOlHOrLW/rOnZUTkXNEFn1j7rVrSKJsPRy2qkgKOqlfLQGswKXCaSPDBkeoWU3s3WSW
 xRwnSYtKdvKuw3050SuX7c+CeadReH7QheqZKhpn+QWKVTC9oJk/zwZdr1UDcX+cmwqEXzoT6kv
 XhCX4cYxDBohIKFvRlR8Kmz6Rk3hxi+dIgXojN9elg1dF3LfxLZQZcgXIAwAwgqanwnn0gMwBFu
 kizI3nZSTVBqHLbl7I6MnbXhPmQHYDUFU3BJapFhj5aXQ/1UmfFwbJQNiAGuZ7/J5Qzp6i+q/KN
 nQC62ZeVF9hSmN3VR/g==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c345ba cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=fetnOxJR8nzJ4WZ79usA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: W7BhjHlW8-mQbWIKj56R2SU2rwuTQ5AF
X-Proofpoint-GUID: W7BhjHlW8-mQbWIKj56R2SU2rwuTQ5AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3545

According to [1][2], fix compile bazel failed

[1] https://github.com/bazelbuild/bazel/issues/27349
[2] https://github.com/bazelbuild/bazel/issues/26162

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 recipes-devtools/bazel/bazel-native_7.7.0.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/bazel/bazel-native_7.7.0.bb b/recipes-devtools/bazel/bazel-native_7.7.0.bb
index 400e169..76c3983 100644
--- a/recipes-devtools/bazel/bazel-native_7.7.0.bb
+++ b/recipes-devtools/bazel/bazel-native_7.7.0.bb
@@ -30,7 +30,7 @@ S = "${UNPACKDIR}"
 inherit bazel-base
 
 EXTRA_BAZEL_ARGS = " \
-    --host_javabase=@local_jdk//:jdk \
+    --tool_java_runtime_version=local_jdk \
     --python_path=python3 \
     --distdir=${TS_DL_DIR} \
     ${@oe.utils.conditional("BAZEL_JOBS", "", "", "--jobs=${BAZEL_JOBS}", d )} \
@@ -40,6 +40,7 @@ EXTRA_BAZEL_ARGS = " \
 
 do_compile[network] = "1"
 do_compile () {
+    BAZEL_DEV_VERSION_OVERRIDE="7.7.0" \
     TMPDIR="${TMPDIR}/bazel" \
     VERBOSE=yes \
     EXTRA_BAZEL_ARGS="${EXTRA_BAZEL_ARGS}" \
-- 
2.34.1


