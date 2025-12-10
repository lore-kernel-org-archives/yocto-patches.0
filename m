Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3123BD3C521
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 02:42:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5342.1765334524203847746
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Dec 2025 18:42:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=V6VV1Udv;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=VjvGegBp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA2Y9tm1490152
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 02:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KfZawLuD/QXnGeTnOzr2UthfIXCLoXk/VBQ
	xzGJytsg=; b=V6VV1UdvU/XwfuP6fYSmHnMB34PmtHLlN7WCMuZJKZULANt9htz
	/6dWD/ZTL5JHGdIOzxZXR3aB75usDjkOSLSb06UZwtaI/pUq1CFg0rhjU+LA1AOq
	KJRswqIwKCUcWMeKrNSW7LMBLiHrfO1OMzA5MPZf9AMn51F0CcuiK4dPaDNnVBrv
	hHUownKEK2hacag4U0JEtq+rSmw5t0I/KCQOsVWCsLCi86DRhAUOjAUggR7XKSdS
	swE59tbfLeukvokGQdvngt21/A+08FHe/ygl6UiEAmT45xfNAFkZ5QbB2d/BjYK/
	tLCx9+Z/5XhuhOtl2i53xqt46TVpmqulA0g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axp5p22j6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 02:42:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7c240728e2aso11567884b3a.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 18:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765334522; x=1765939322; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfZawLuD/QXnGeTnOzr2UthfIXCLoXk/VBQxzGJytsg=;
        b=VjvGegBpUFjCE7svNxWH00iOVD7rFLNJ52JmEeUHI1lZeqTV5mL4lptFK5A0mgora7
         ZDn7/5iCZYT7tXvrr8OQdLy8iuLo/1UKDQZ2rsHAq5KxE785qemEc2xeBthWy10JaQKb
         2SrWoBdVpK7AiUAuxG1fyfYwmocfguDfW6kZG9bfLkdLe/LV9OydICcUbYPdqC+TJZLR
         kLyq1NdW7o9LMe4feJUtJ/9w70KBxfodEpy0neoRwrn4DxnNpV+WoIfmAyaZqA+K5hrd
         086oVCNDTkwPP5j4v3VpgDmo6N2w64oRYCteq5GH7O4RP27cBw5QAYDvaCRr+tp2+W1t
         juGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765334522; x=1765939322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfZawLuD/QXnGeTnOzr2UthfIXCLoXk/VBQxzGJytsg=;
        b=kGxkXPZCx3AoxnuartftlS9pnrpa3+C34prMAkZkApli81bmE516/5QgUTpJXNzRCK
         5bF//q3OwGfHsXpxE15fFvka777LF221K9ZfXYP0SQI0ZI55VmiunOEZpFVa1RhjMGME
         gd+kKX4/cLoGdHe4lAcjllgfkUHgwD6M1HG4rBcXvV/XV+E8VAET/2SO6NGgvv6o9ycF
         jqjX1csIeWyEETrQW5rrjUIx+HmboMlKwVh+1Dk/lnIJse99dEDS4gFjwnHif/UsEXF+
         5xEHoyFEw4QDbs3pECTtFd7Ni2Z+CrMidZy32GS4KGsTdjR7pbAe05GXKDN2jlvvFdWz
         NA6g==
X-Gm-Message-State: AOJu0YzsksLBGUJiZ5uWICc95SVRhW4BpwPgVLD8qpdV3j0IqADvmtdP
	X8C9BeZHdXx/KD4HMkJv34xm/zvcuV9RsWJlireF6+qlGoi8cgYIhKU/kO1aGe4WShelT3QsjKo
	pnsa1uSSKKi7dAVpeDIW96eQeKddzhF6MYEizxnmRZjk0cQDwigIes+GyG4BCtfOXAxat68EgT0
	AWE3h14v/HEFaA
X-Gm-Gg: ASbGncvn0HANGxzVss3Ee78ri+uNnUvkN3TxanqR7Tc9ESfkMV1q1BiKAOX0u1XTwoI
	6uG1pIhJA46BWYp5H4zQu+EPfq+lbqLMlTeT9SsIxLPdKemV4tBmFjxlORbQxxKSl/yePr5kwjo
	vRB+GwlL6Ag4C/qbVAdjn2nxgvTl142rW/vCWc5/zqC+YKdNO6aHYf4Hw539LWq1NMof8uDt7Zs
	mtL5fyshZPH53t2Norbi2FU/QeHcTSubUYrs8Zm2ew/FUXMiSYwX2VcPbjJun/sjuonvezvw9Qr
	z1IlVhVU60wj2z3NgTyf5OXXzhJMexOPMr+zWQuD8SkygJ+yAreOj8CBFnCuUJVh3N5hEYsnH2k
	+3+TWOcVW9j2JICPAvk5eGRCQ/P+pTzWNyZoV5i4s
X-Received: by 2002:a05:6a00:3d54:b0:7e8:4398:b356 with SMTP id d2e1a72fcca58-7f22ee59af8mr778279b3a.41.1765334521689;
        Tue, 09 Dec 2025 18:42:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBbSoqsSosxFNOUVDvKHlJN0AsAE2sbW7yGKbLT9FmlOfPitOw9OvMPiCE/lIcv1chcuenpA==
X-Received: by 2002:a05:6a00:3d54:b0:7e8:4398:b356 with SMTP id d2e1a72fcca58-7f22ee59af8mr778260b3a.41.1765334521197;
        Tue, 09 Dec 2025 18:42:01 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2aeeaa340sm17373514b3a.54.2025.12.09.18.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 18:42:00 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nicolas.dechesne@oss.qualcomm.com
Subject: [yocto-autobuilder2][PATCH] config.py: add meta-qcom to layers to be built
Date: Wed, 10 Dec 2025 08:11:50 +0530
Message-ID: <20251210024150.379272-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mbvD7IWkWk6jYZ8eTTPGyjdAIl3-n-B6
X-Authority-Analysis: v=2.4 cv=ZZYQ98VA c=1 sm=1 tr=0 ts=6938ddfa cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=DxuOTVR5aMq1LcmqJncA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAyMCBTYWx0ZWRfX/+X4F9TiZ8ek
 JgLQmvQtqdSwl3TIIbwey3eyO6lhR7LSI6t5/so8W/KJyaUimnc5zEmMkfS811XLnzbTdXBZpR9
 DGI0x2K9wFa0iMp6p4l1WuWrc/xaTMXeQBIncHk0l0Xfd2bbskhBO/FHFezUqmXPBD8Su4ZfDoe
 1WUPqPPuXUqR9xjHPXmttfPS+oPMMfzG8OicVdOwcOVwasiE9d+bZ3ZPsAxfDaVTLZ12bgvRgyz
 ShTgZleieL8Kp4Bd0ty1kU4OpFvatNgQ2Uq7jRYNO0yWZsPFC4wTvqjskzfpG30SGpUoFqfLkxp
 pqJFG/fOUNyFCwqVDXdwOCz/XPDesTv2koXCc7YlG70q/JMfePPWE4EvpGXGY16M+HqGKeRvR9J
 YpZoEeLEtZUSXSTw7kqIcGSb9ku53g==
X-Proofpoint-GUID: mbvD7IWkWk6jYZ8eTTPGyjdAIl3-n-B6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1031
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100020
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 02:42:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2758

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Add builder for Qualcomm BSP layer meta-qcom and include it in a-full.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 config.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/config.py b/config.py
index 2408602..07cf403 100644
--- a/config.py
+++ b/config.py
@@ -8,7 +8,7 @@ baserepos = ["bitbake", "oecore", "meta-yocto", "yocto-docs", "poky"]
 # Repositories used by each builder
 buildertorepos = {
     "a-quick": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2"],
-    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang"],
+    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-qcom"],
     "non-gpl3": baserepos + ["meta-gplv2"],
     "meta-mingw": baserepos + ["meta-mingw"],
     "meta-oe": baserepos + ["meta-openembedded"],
@@ -18,6 +18,7 @@ buildertorepos = {
     "meta-arm": baserepos + ["meta-arm"],
     "meta-agl-core": baserepos + ["meta-agl"],
     "meta-aws": baserepos + ["meta-aws", "meta-openembedded"],
+    "meta-qcom": baserepos + ["meta-qcom"],
     "meta-clang": baserepos + ["meta-clang"],
     "buildtools-docs": baserepos + ["meta-openembedded"],
     "qemuarm-oecore": ["oecore", "bitbake"],
@@ -100,7 +101,7 @@ trigger_builders_wait_full = trigger_builders_wait_shared + [
     "oe-selftest-debian", "oe-selftest-fedora",
     "qemux86-64-ptest", "qemux86-64-ltp", "qemuarm64-ptest", "qemuarm64-ltp",
     "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", "qemuarmv5",
-    "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc"
+    "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc", "meta-qcom"
 ]
 
 trigger_builders_wait_quick_releases = {
@@ -147,7 +148,8 @@ builders_others = [
     "edgerouter", "edgerouter-alt",
     "oe-selftest-ubuntu", "oe-selftest-centos", "oe-selftest-opensuse",
     "non-gpl3",
-    "meta-webosose"
+    "meta-webosose",
+    "meta-qcom"
 ] + old_arch_full + riscv
 
 subbuilders = list(set(trigger_builders_wait_quick + trigger_builders_wait_full + trigger_builders_wait_perf + builders_others))
@@ -283,6 +285,7 @@ builder_tags = {
     "meta-aws": ["layers"],
     "meta-agl-core": ["layers"],
     "meta-virt": ["layers"],
+    "meta-qcom": ["layers"],
 
     "musl-qemux86": ["musl"],
     "musl-qemux86-64": ["musl"],
-- 
2.52.0


