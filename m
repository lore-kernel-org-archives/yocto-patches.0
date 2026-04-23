Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C951FAD416
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 05:47:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13472.1776923272254118565
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 22:47:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Ym0fhzeL;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=EXuWyqEd;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N2vuoQ872752
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pQrlq1KAS0Q
	9CbJBIJBuJlwV2ibFP4HwwQzi57pTprg=; b=Ym0fhzeLvrhwqVb2sBrssRcn3Gs
	40HBYSUhuTCeSaIUxXgW7BX22KRtJUw6mVRBHYFuXlBnZOi1MZue0NWJ8tgxBLoB
	ZNGAfqFzbhD1DVHkXuRFApHfbFEnqKBzexAYExSKhZ7Nq4GEz+W3KJlgd4g03qJC
	ITrgudLU1tUfG2cc82UJqbA1U+L1UBvpo/duuR2gSFlUU0FS5QUf2WiSn0i4WuZX
	dIZZckPE8n7tSnlYORmdTtoW7rj3mWnYI/1mafur/1o6JuVC7d5KydVq3HisxymL
	PIRN9DgwKbkWtzo8uRNrUtPOww2OV+2AGj7E/2OjOJa5YGIuTuedki7FpEg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh2cas-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso56492635ad.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 22:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776923270; x=1777528070; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQrlq1KAS0Q9CbJBIJBuJlwV2ibFP4HwwQzi57pTprg=;
        b=EXuWyqEdOzM32Mm5OFnLXspNPRbkhaR2ntClkTqQ6SuRFo/61HAC0YCVuGxKOIvmJA
         Kp1exboNLTk06HryXTC4a0u3bkhrmocLUXduzGHcqDDJIz4/X6TyXe2kKrNXRKte76Ny
         WCKgKCnDe9+ixyHp2vaLWW8lCYpnewuCOVI4K0eIWJhDFe15r4Q6wdpc0SdnrQ1LdnzJ
         Qn1WxuAYAihvzJIdW090BUx89xWAxT/FN3p4RDV2Z8YIZaZVsmxQhBZFFzoXkV2tLSAc
         Orno/qgS8l2N9X7TeMVo6SF+UdjB3+dr0jAi1vpoSSxax3Pk+9bFWuK7vxH7jSNQCQE0
         UwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776923270; x=1777528070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pQrlq1KAS0Q9CbJBIJBuJlwV2ibFP4HwwQzi57pTprg=;
        b=IUT7xnZBE4nAsabpzB8nPUBFOZeXcnWSliy9PJf+GkgLJN5FP/VckZiwCLZdZ1XhQP
         b2BGbjpVrx6vRkMM1/IyIbbE80bAKYKX7CKthA3IcARYzx6XJtPkVISHw9fmVECiVmfX
         MeX5sXdO3lmu6HL/Y6KUNtrQ6C+Y/Jsb7ilj5YkJFB5ZWmT9qBLJnQuaPyRL/ZmRNxtO
         6iC+TuCjXdKioRyRcocac4iBB3QJgEfAKOVrDeXFrHV1Vi33XaZovKW6/Bp8LFqa8GJT
         tUTr8upOZvx3Dh72gEj0zk8rrPANYmPRY+EFP5ELog64rFsg42aR3oFkL9q5SVaO1v7l
         /Fvw==
X-Gm-Message-State: AOJu0Yx3YqgouH2JoZZjHynNa0YjsYDzwSJoE69RHtfGJikPjboPu1qS
	Neoqfj7eE1k0dDohGpYG5RDvKLco4edg7N/5r+X3JD/MrHLD3CSSPfpjR4lZhGLwmBpJbNBCiIH
	FMeaBkgiNhOe2gRe21vmtWgcdR16XKs8HsjyrAVsJkRs+O5MlFXCWEkVFSK4ufCr4v6449+U+PA
	ZnuS35qVODmkcG
X-Gm-Gg: AeBDietbpF/4te1rbU4fUTJpnOm1MIj2Un9NzRXDqmMt0Qyx9c6j2sEl/fu0/t04g13
	vzEqm2BTMqeCpm2j32mRK8WnQGaSsYNPUeYHcnpx2I4/BwxjiLXrr2+BHnrtg5+4rfYCBw8b2ns
	LW5U80DgOSpdMjqsgd2thTy9CPyaQ0QhmpLVWN2VKnCAbZmimvqDow6jXUgoIEPQ0/HT3AtZj84
	znMtWfTcd+sPcgvPakBz2/CQluULWiatoZJjI3qHGdP/bIo85tE470p08NxCqMfzMLO4rVgNbyh
	euQpCajGc0KiHji+PHDbCGnLiMdOv1dxRFS+YPMPRlKKiLBvtBlUxuBubcy54uUeSdkJVMRbFgM
	AMK+UPy6OdNl5jUe7S9IaGZxNs3aSNA+jpfCe4A==
X-Received: by 2002:a05:6300:68d0:10b0:398:787c:d2e4 with SMTP id adf61e73a8af0-3a08d740814mr16870043637.17.1776923270094;
        Wed, 22 Apr 2026 22:47:50 -0700 (PDT)
X-Received: by 2002:a05:6300:68d0:10b0:398:787c:d2e4 with SMTP id adf61e73a8af0-3a08d740814mr16870030637.17.1776923269582;
        Wed, 22 Apr 2026 22:47:49 -0700 (PDT)
Received: from fedora ([2001:f40:970:6089:46ff:e946:5748:5ddc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm20426925b3a.20.2026.04.22.22.47.48
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 22:47:49 -0700 (PDT)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH 4/4] dpdk/23.11: upgrade 23.11.5 -> 23.11.6
Date: Thu, 23 Apr 2026 13:47:31 +0800
Message-ID: <20260423054732.216696-4-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423054732.216696-1-anuj.mittal@oss.qualcomm.com>
References: <20260423054732.216696-1-anuj.mittal@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA1MiBTYWx0ZWRfXyQqql4zZ0sUC
 q7yXAfQ/zzK5x79ziKT+qcHzQc3HjP2ZbYKAP4gPJmKRcliZbl6Kf0v4lXQcqtHZTBe/S9FE615
 lmxqYqJsoyInJpjZ7mlw7hQekp5H7mhsYc8DRLpQxrsfkQZgwc9pyEd2/6bWClHK/+wpucD1A+j
 ovS6xlx2C+mZeUXGfKluC44Ldl6o9509xiR9gjKtyc6g/lWlprbykeCtI3ue/2jiWg9bOHT/9F8
 KoqrPIQ0+uJwIiOHmsGHJw94vitmKSZ4s2e+IHXkad7JqgyuZwZOwWMOsa4E9ahlN/Bu3IZjwtZ
 ApwnKV8Sb12SUI/6u5LUD+xh3o3JfiNefzojOeLcSyQjK+n/UBJ92Ec9zGuaaGg3/uOTeKvFrTd
 mb3/lzn16zxMCS8xlljmWExRnX89Z8062seFpSCxnWbroIFCNO7b2K4NZWeQSviCErQaV7vVbs7
 GerK2+nfdvzpm3Opo6Q==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69e9b287 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=gZPLTqnVJUvPzlStuNkA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 3pBqAVjyEwr1VMLt0_Deg3cAxESuReaA
X-Proofpoint-ORIG-GUID: 3pBqAVjyEwr1VMLt0_Deg3cAxESuReaA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230052
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3771

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-extended/dpdk/{dpdk_23.11.5.bb => dpdk_23.11.6.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-extended/dpdk/{dpdk_23.11.5.bb => dpdk_23.11.6.bb} (92%)

diff --git a/recipes-extended/dpdk/dpdk_23.11.5.bb b/recipes-extended/dpdk/dpdk_23.11.6.bb
similarity index 92%
rename from recipes-extended/dpdk/dpdk_23.11.5.bb
rename to recipes-extended/dpdk/dpdk_23.11.6.bb
index 4785e0c..617ad42 100644
--- a/recipes-extended/dpdk/dpdk_23.11.5.bb
+++ b/recipes-extended/dpdk/dpdk_23.11.6.bb
@@ -5,7 +5,7 @@ SRC_URI += " file://0001-config-meson-get-cpu_instruction_set-from-meson-opti.pa
 
 STABLE = "-stable"
 BRANCH = "23.11"
-SRCREV = "62f583c49bf67dd4d6733ece14e55fe6839e66d1"
+SRCREV = "484dba4a7efba97a9ce044f87e59c82f0f5aba0b"
 
 PACKAGES =+ "${PN}-examples ${PN}-tools"
 
-- 
2.53.0


