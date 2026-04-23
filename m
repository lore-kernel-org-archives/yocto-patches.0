Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E19FAD41B
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 05:47:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13333.1776923270142672381
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 22:47:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=LzjxEf5/;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=OhS7uAeL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N2SGkY1230127
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s0WvG4cOfGv
	J2Zfl0UZndwS2h/3zGt6IWGDevOBuNJM=; b=LzjxEf5/zmUko5D4T8KC919MciK
	5h3zQdcVZJDuv8riETra1BGk9gjsgJhfyVhiLtvQC3atmhnOeV3gEc0q2s7l7Gx5
	uQwvVHpEnehHIHnw+IK7U5snkxF5GgPga2iZx+9kK5okQi1wDQ5ZmFFuW+O5RAql
	lZ7fAYBJfNmwCXS61DPrhscZPmq9tYj7Hs0hz9SkvBt/GOiJrFei1Mu+XX9SBEcd
	QlTOzoTsq45rBjFCEgbe6MzD2jjlivZOqgpUBa3b/FuykERCNzYE08YPhIhYPUT3
	KYiJmfRJsEvyc63Erem3NX2k5b5MGM554zX0dO0blje0dRyCg5kuD5LwL6g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h6ac8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f0e12d375so3767126b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776923269; x=1777528069; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0WvG4cOfGvJ2Zfl0UZndwS2h/3zGt6IWGDevOBuNJM=;
        b=OhS7uAeLwodvJIEa1CP19aDASnbfEVwDnREyyu9DWd6wkMSG9rY9VEDmVkIZzQdPjU
         g2AaoiV56rod6dyTly3huxSS4ymlUeM9WxB2JgtRLzcbxfNylqqzEOQ+Q0qBhRvOYFG1
         J/Zu6MfScFyFFJwZElhRRev3LSSukoXUWSU0C06+0voYffTnqsMeWqJsW1C1dQ9G2pbi
         C995b9Fj1Ef9sXgyhKrSYlscydRJ9+c0mSIsJlcJ3jJTn9hsD9LninFm4VJISL2m6GXb
         rV0KLcjMqs1IcI8tAhKTLd//n7LUvjQo96zUC+Nrx86Dgm9GikVJy8yGOZbJmy9s0Q2K
         9zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776923269; x=1777528069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s0WvG4cOfGvJ2Zfl0UZndwS2h/3zGt6IWGDevOBuNJM=;
        b=N3GpRR5GQPNph1mqqPLz3sdUFS17DtlxDixsT3U0kVl69KQyxd9hcIj7HLuPH9KY/A
         yfGKviWnpDVYkxcvNS8pGb4EDvS7OcP8e8W+tAMfSWNeZHDvPwii7L+SxPComQs4ZdpJ
         GU5PzXub+RAR5BUs18m5mciQBvOj2BHQiMBEs28X5/T7yYxY+KrQ+2fmglZJ1MNDilnD
         iJKGETG0qDg0I5/p4NKzLRHpcTTl2yTOQ5QwAtJkg8W6GCgouWVIhf62+4hBolbv/50H
         iH9CpYR6PKz/1qTZK2kuyHlOI+IxLSs8H2pCmyxtFkoGt3iIOIO5dVmCAZoqRRY/RraD
         SHdA==
X-Gm-Message-State: AOJu0YwH4+DXyPyzAbByYWHA6GZ6wDQHjPiZIXbR9Z62gDcPkB2dTx+F
	mG7yx69IQq5gebnVTMI56TMcmKYOydqsLzbLImFOQQW06u8W8233A7rI+Ol4y0zxjgdLRx6gcbp
	Xly7FyAH18UgFm6GRpW2BrKo77tp5HS6XYGhX5IqbUCmHgFvbIP3eQK2JDJopILDpm13cx08vF/
	Hew0ISKONpdHLl
X-Gm-Gg: AeBDievBLI9WqPKynNxilp37Mbgo5qQBluAkXdiqyD0uz+Z1wHexYg1YxWoNckGpf1R
	7vafv1apGn0jJpYNrcN0wqnVF3r6oXVAY98fuHxmuI1eULSXvgpAF2elZor4Ns4Ym2JCNzh9NGu
	mmeRlaBoz49X/CRYmshXxAd5IwwtnHMHgrWGF9A+0kHKaAxL4tqOec6zftv+DMnUjC5i1Y4AiCU
	jHIU9jZrZ36eyAGEDgVSdzKJda82fB2YioGQKgv6nv+P4xrSNijnWBdCCR2CL3SIf6S8ubrk8St
	Dyh4U5xOnzWnLhZ9x0FNucJfm7iv+QOg9zJX5Jmb8MQ6njeqDSM/uNoGxL78Ohz0CuC2g5tJLPX
	inM3vHfKk6AClA59DWYbzkueFHnTFlyb+a+PxRg==
X-Received: by 2002:a05:6a00:178e:b0:82a:7893:e14b with SMTP id d2e1a72fcca58-82f8c94c606mr28055175b3a.38.1776923268692;
        Wed, 22 Apr 2026 22:47:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:178e:b0:82a:7893:e14b with SMTP id d2e1a72fcca58-82f8c94c606mr28055145b3a.38.1776923268177;
        Wed, 22 Apr 2026 22:47:48 -0700 (PDT)
Received: from fedora ([2001:f40:970:6089:46ff:e946:5748:5ddc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm20426925b3a.20.2026.04.22.22.47.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 22:47:47 -0700 (PDT)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH 3/4] dpdk/25.11: upgrade 25.11.0 -> 25.11.1
Date: Thu, 23 Apr 2026 13:47:30 +0800
Message-ID: <20260423054732.216696-3-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423054732.216696-1-anuj.mittal@oss.qualcomm.com>
References: <20260423054732.216696-1-anuj.mittal@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69e9b285 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=8rWy6zfcAAAA:8
 a=5Do82qrgmh-XoKD0A8QA:9 a=IoOABgeZipijB_acs4fv:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA1MiBTYWx0ZWRfXx8aD43LQ9ZJj
 M+BdI3MBoK2q//PS2gCwtM7SfKyRq5y5su+Ma0dW+ZMFi+1PqFbKc4NceS9w1L32JAsCo0wBXV9
 UTfE3O6y812BlmQ+ngjNKKPmUB9SALtwcRukTPzB3ag9Irs1URr41j3xHwkCidJSgqHQLsdeBjK
 mNhWD4eMIlpqXWViLleveC74ToxomqkBLK+n54oxWjhMLHd9olX//SQUscGtd6WlJUSD8c/U0fC
 SsLShPexqPHJNOrMY/IpG+wAOymrgqEy6dicwVVEP+xeBsWugCnOLcJk/tRpXXVNQr6+Ma2U/wV
 WrTtcpUYgCvzrbfSe/6C/JbbO62vo6zdW1QbSeU3fKg/3K7WA1T57XIBG3Tg+9rVM5RBsON6Ipc
 +0MjzNPvVAeo5hnB0QkIxOosN66s/8LHyG7iKYSN+s+MCiFOtjI9ucSJkuSIAO/h+jVMDjWt8bJ
 MTveYl4GSkO/QRC7ieQ==
X-Proofpoint-GUID: ueLy5wh_B8M5wTsFfxXpWJcDs77c6XnT
X-Proofpoint-ORIG-GUID: ueLy5wh_B8M5wTsFfxXpWJcDs77c6XnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230052
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3770

Remove the SRC_URI override with hardcoded tag value as the version
matches tag name exactly now.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-extended/dpdk/{dpdk_25.11.0.bb => dpdk_25.11.1.bb} | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
 rename recipes-extended/dpdk/{dpdk_25.11.0.bb => dpdk_25.11.1.bb} (79%)

diff --git a/recipes-extended/dpdk/dpdk_25.11.0.bb b/recipes-extended/dpdk/dpdk_25.11.1.bb
similarity index 79%
rename from recipes-extended/dpdk/dpdk_25.11.0.bb
rename to recipes-extended/dpdk/dpdk_25.11.1.bb
index d5de179..e629987 100644
--- a/recipes-extended/dpdk/dpdk_25.11.0.bb
+++ b/recipes-extended/dpdk/dpdk_25.11.1.bb
@@ -1,11 +1,10 @@
 include dpdk.inc
 
-SRC_URI = "git://dpdk.org/git/dpdk${STABLE};protocol=https;branch=${BRANCH};tag=v25.11"
 SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.patch"
 
 STABLE = "-stable"
 BRANCH = "25.11"
-SRCREV = "ed957165eadbe60a47d5ec223578cdd1c13d0bd9"
+SRCREV = "8f56626b51efca87ac312d04bcd90935020b1e7f"
 
 PACKAGES =+ "${PN}-examples ${PN}-tools"
 
-- 
2.53.0


