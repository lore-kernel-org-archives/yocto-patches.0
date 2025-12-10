Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5FFD3C525
	for <webhook@archiver.kernel.org>; Wed, 10 Dec 2025 02:44:59 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5222.1765334698621911437
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Dec 2025 18:44:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=b94tj2u5;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=c6YgjNsP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA2Y9xK1994731
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 02:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=L8JAbb5pij94LadmWE2ufJVUiGyr0BEQ5Of
	8/8d3OaE=; b=b94tj2u50aOyZ5Jl7L14SeXWAujLHxVJ3i89PgNiHiHV/vh2rKm
	exiV543IAmzvKozhEJsVj50KiJY594026o7ylonjcVYpPRrjPRQijsoAgJQk9X7z
	tNs4Be4P/rvF+iSgF3QOdCv1Va4PtFaeH7xmSB7k0KmHPY3zzAfHwBnATfHSEuqv
	HoEhBB/2VbsFnhl0fLligLiZeltStYdFz6QMLBJuOSbBxoj0CNSmMSUfzcuTSInW
	X2Dx2rFZSOdYAYsJv5vQ9j7wfdYfLdcHByyCgr5wr8Til1kmEn2sB8zvVAt1bxTK
	oFxpIjS9uG+PBBco87+zaZDnk3fJ5w4IXlg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axqu59n58-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 02:44:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297df52c960so125347995ad.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 18:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765334696; x=1765939496; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8JAbb5pij94LadmWE2ufJVUiGyr0BEQ5Of8/8d3OaE=;
        b=c6YgjNsPpofUtQnEz3/s0gNMxhobqvDftOESsqHAD+9Me+rjRRKqH4C8ivMB/pihoO
         +XoUojwJqGhjISRO9TMi3+LKRquKS5w2xL2aD2PM0oSu/ApfxVi6omA4HLO+mSKKAg5D
         DwO3b68/vGllINSqhLubS4qY6N9Dij681Vnz4TdIGzfAoaVE411SOvzeaxcsyTjekZdC
         u26z1fe35Ra8mnp/+vnYiUQ2ZIwZnWlL7J3NBRav5iLaE+fv1Xyl36LkrRGsskUZLGCG
         0ovE6Ltv7SvJSvi3l8EoRNyo+8Ie1OyzNSYz3SyrXkesPjGeN23tkmy7Jb2LHBiMZ8z3
         XjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765334696; x=1765939496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8JAbb5pij94LadmWE2ufJVUiGyr0BEQ5Of8/8d3OaE=;
        b=d9Vp63Oej+UMqalDZ/mO//BjmBzQiMtnMS653xxLaKjZ91t4B5YE/T0asw/Xtssw9j
         TNqrjtxEB2/tTWL1DdjJOMqsg5RBXiUb+1pEGvGeVKl65Z5MREYRk9jVVU1lUVBBp3QZ
         38lzR9P6FX2GrH9W/zznGqluRkI6NcEit6M1w3MaAAbn4vbd73+5QSwTOAcxxuZJ8A61
         IAmCSO8pQClp0yDrhv1sCK6dF1LrxImoa6ndUHsEyVaiQoqfj6gOmdNehc7/2Ovn6mJi
         lt9kOtqpVTxR27L9lfpBmZYecGPc9UYp9VDoUPy+OKMCGNEIuUvaufuyyawolPD/AvM8
         /HpA==
X-Gm-Message-State: AOJu0YzGSUh9UKkYVi/kK3UXwSm/xUaniKHlZN4Q1qKbrVy+RBxdh4ol
	BMsqBrrdyhVG1CzYNWmU+kfiZPe8TeExfpN45azJxgosSVwV05PP7E65YLlXfqgjGyNpp7KReqV
	boZIJ9xzTCU/GIA0Xe8NxTlx8Mgym11+feu+m8Jay9INNLUM775tQiAyVb1ib9Lc0dAi55ByMQ9
	r6cjbmSOfvMvSH
X-Gm-Gg: AY/fxX7NqHQoh7LZkWPZPSvMZmdQWiqPzudstzd0UBDGTqM2DxNj8J49C67Xjnc4t8l
	ikfeiD3KofHf2xaSMMRuMxjpFvBwUFkNVyoS6c+vmzpGwDVx6ptp85gR1Uwf53jWOZLPCZ3eNwc
	jIYdfz74FatmCJME9omfePbSehi4Zbbs2TPjozQ0vAvnGySz6Yz/yeKKXbhkTRY91iC/J65/ork
	MmyLQnoNvd+JTzGD4X+N6vc1O0z3L4guFekvmmiNWvw7ymQ8apRt6PNLQiq6LlJery7UM8KqYnv
	g/I5XMs3or9YAL04jfPXec1JFpBZpFCsMQwu+tID8U2kw7/EJW2MlhIFLvtnkA134f+gloxrvWO
	LqSUl6sOIkeH8yINFFv/ABSq40Cxew+MFlOsdcXfX
X-Received: by 2002:a17:903:2348:b0:290:9332:eebd with SMTP id d9443c01a7336-29ec22cabf3mr8223065ad.10.1765334696374;
        Tue, 09 Dec 2025 18:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEPNH+fGhgYTQCINxobVVQG8qKmdS2RdLm1rZ0eqaYnYtzgt0/ZXxZ7uZlsnxdPdj8iR820A==
X-Received: by 2002:a17:903:2348:b0:290:9332:eebd with SMTP id d9443c01a7336-29ec22cabf3mr8222955ad.10.1765334695905;
        Tue, 09 Dec 2025 18:44:55 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99f052sm165387875ad.47.2025.12.09.18.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 18:44:55 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nicolas.dechesne@oss.qualcomm.com
Subject: [yocto-autobuilder-helper][PATCH] config.json: build base image with meta-qcom
Date: Wed, 10 Dec 2025 08:14:43 +0530
Message-ID: <20251210024443.379933-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VDKZOsWvEPuu5XSlTaqgs0Y2enoHUbI3
X-Authority-Analysis: v=2.4 cv=Y7/1cxeN c=1 sm=1 tr=0 ts=6938dea9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=if-WSjLYOZ_juT1mGrIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: VDKZOsWvEPuu5XSlTaqgs0Y2enoHUbI3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAyMCBTYWx0ZWRfX0VvVXQm+uwl7
 XKgDNDC+JakB9FnmTSUWP58oPGeYYfDIH6+6kS8mvnYUI7JGfePopVJHWaAR2gyy5auMSBO9Vs9
 8NOLhMVxaqIdrTBy++7RAJLzyCIlyKbvNDr0ovdvwbWRDOPwg0Qn+8m1JGvPr/wqshUbqCahKo7
 49ndLpuy8SsL8GtGu2dos+EacfV2ZtXRlPkgf7Ue3zXSR7XnnsnlrtfQUekCnRR2pHInFuQu+6T
 wQHoI2pIjL6igV7o5spk5ZA9FuOGIawlKP+0JYLIP5fa92k1tK1tjbrOL4wZLA+Nkv2zwTYFgKS
 NuAj3PHYveXa4JPBFdvS4UMj3LEOVYFO/8tdWr1881+f0Mexi2LqaWeRBHGESE/ytqTxaqsEyIL
 CdR/TEA71USEvVyqzsh6aPWLAKkWZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1031 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100020
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 10 Dec 2025 02:44:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2759

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Include a build for core-image-base with meta-qcom in addition to
nightly layer check we already have.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 config.json | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/config.json b/config.json
index 53481cc..30d0d67 100644
--- a/config.json
+++ b/config.json
@@ -658,6 +658,18 @@
                 "SANITYTARGETS" : "core-image-minimal:do_testimage core-image-sato:do_testimage core-image-weston:do_testimage"
             }
         },
+        "meta-qcom" : {
+            "NEEDREPOS" : ["bitbake", "meta-qcom"],
+            "ADDLAYER" : [
+                "${BUILDDIR}/../meta-qcom"
+            ],
+            "step1": {
+                "shortname": "Build for rb3gen2-core-kit",
+                "DISTRO": "poky-altcfg",
+                "MACHINE": "rb3gen2-core-kit",
+                "BBTARGETS": "core-image-base"
+            }
+        },
         "meta-agl-core" : {
             "NEEDREPOS" : ["bitbake", "meta-agl"],
             "ADDLAYER" : [
-- 
2.52.0


