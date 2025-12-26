Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25502E7AD7E
	for <webhook@archiver.kernel.org>; Fri, 26 Dec 2025 03:14:05 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.148400.1766718842261436962
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Dec 2025 19:14:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=F+vpFBAn;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=NeEUDbeY;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BPMNAsF3382207
	for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 03:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xo02eiE3ToY
	iMMjHXw9wxjEv20M1fTIYgRFE0XRNzmo=; b=F+vpFBAnM7VPAtyxDUym509tXvk
	Wn0bpSRqUcDsU0OZmTc8+uivsrhni7J4y0x9XJZnOtgjpvYKHwFZMd2Mz3WZaGKN
	/sUPNlLlaoGDlUs0JBHJhu/YYxUW1ovucly5yILC12x+zokmZ80iASXYqd6QS/P/
	VuwBByoOW/eXd6NPWwGwZsiHTJdk7h4BSgtmGkKfgRS9X2gjoJ/7lhe9pB7314LZ
	tPhmKr7Tv7jl1wmtyN+9ByO0wljMoM51UIDNoXXWvmWaJvFYzABAU/VBwstafqH8
	7iha3hRn0ycNkSOwYTaPEQW7w4vD2AcGLKEQ/vOKQvsa2fzV531d1T61Lcg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8v9y21qt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 03:14:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0a8c465c1so52857185ad.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Dec 2025 19:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766718840; x=1767323640; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xo02eiE3ToYiMMjHXw9wxjEv20M1fTIYgRFE0XRNzmo=;
        b=NeEUDbeYp+ucBDLcRn7sQi/jh0QZrNEx5JHTDPFDOEvTwZ4wApg4+pOeCubtDJmlg8
         liJq1VQpXkyTuPPqFoG0M57HdU1y2RY6dMTYhVV1E/DYvaHBzTKC6zIjAkwU65QEj9n5
         vaTJdi0Evy5GJ6fHT87B56KtUSIwb1tgq8YvaT9bCHZKmxzaA+rS3JFi1GEuZfG1WPw9
         vQa+pvFUk+9532Cl9DGXYTMuM/cbQtaLZFMLkkbUSPITSi4kZ79hViPc/S8y/epVrQnS
         TGJA9hHC5VE+JkUsJsityfFwsf072G3cOl0c2YjaXnewmtCZlEhCeJARrNawjGQQ15By
         kpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766718840; x=1767323640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xo02eiE3ToYiMMjHXw9wxjEv20M1fTIYgRFE0XRNzmo=;
        b=szccl9pNHab3gld4BsDVsDG18LsH3CuwP4guIbvRcWIQS0dLU6z7LbUlJIrh/mosJp
         3OeCtG8jzE9VsDxpwPpTeM0xlWKyrnPzs/XGA7EB3gDSt2GL4uL2gYjis5uMs3h70MuD
         9YTUNp8n4V2PeA5P7guOX35W6jm8e9w0B02UtdBFpT7ud7iD5+fgoj8kWZeIFlKefVMD
         QYQRC82KEC3X0+3ieXJvDOyfcfIkV7bVpNnS+M33EDVD56I9+SSuNrABTfwx0Dbn3vFt
         j/s1r6VyMlr936TAWGWPh/CzOtPbDQK+6DybmBdLnmGTwen83xgKTXbQ2ZxmuBLm7YyZ
         srlw==
X-Gm-Message-State: AOJu0Ywkm8Par4tqRMIcegPLLYiCeU0tEo3QsKggTgEGPuM1TYmkTKa8
	LMHm9pLZIbkptL5NemnTXjSGNAB61+XGsKB3knmmyGXdumjPguXscY1Noibh6KrFDPxUjJx4EAV
	COgNQ3qUa9v37SOrR8ujzZKh1XZMW5fXmBPAfjZYCc8m2js6PMwmb+ZOtpXloLD15GSQWZvOPNw
	tBL/UKfMGAtc+G
X-Gm-Gg: AY/fxX73K633jU2e1iWICt+io2kct8GjFZwxZaMgSQoeowaS3PY+0cY3qWuzF4ViYT5
	7ouF8h1+c8q3obbdKJ58LiCw0uZRqBekS0ecl0vDma8B80DEO0Ktk/U4LiRbYb+uRDVsttiUINV
	q439Nnarvu96W4bO3dIVUG+9V83AnPbFFvYl+qq+eW2GKJ74yJMvmhPp0XtejbprHcz2puAik9U
	3JIDsfT3pbYr1gujHCa2tSGNoLheOPCRHOyp+Yo9/ZVmC+I9PzmTw1E7MgRipNwltm6GptusuOI
	AuObDZNTlLMhObYKGKu9xKLPo5YQVqStNrrdhN6vTR3ZqfFxC5riZx0lCJngr41/LXRZC5O69rY
	Uf7CKmr3ctYFPHYnoqMu56exyMR1IgiC9NdpO03rr
X-Received: by 2002:a17:903:228e:b0:296:547a:4bf2 with SMTP id d9443c01a7336-2a2f0d5d63emr191567105ad.27.1766718840076;
        Thu, 25 Dec 2025 19:14:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWr/8Q/gMEGzFCs5FvFQiEfLQ2OaILVRwrxWbB1DUaurri/75PhEUDNouhVbv2CaVEWRw4kw==
X-Received: by 2002:a17:903:228e:b0:296:547a:4bf2 with SMTP id d9443c01a7336-2a2f0d5d63emr191566915ad.27.1766718839576;
        Thu, 25 Dec 2025 19:13:59 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77451sm193383085ad.96.2025.12.25.19.13.58
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 19:13:59 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [scarthgap][meta-dpdk][PATCH 2/2] dpdk: upgrade 22.11.7 -> 22.11.11
Date: Fri, 26 Dec 2025 08:43:51 +0530
Message-ID: <20251226031351.1828500-2-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226031351.1828500-1-anuj.mittal@oss.qualcomm.com>
References: <20251226031351.1828500-1-anuj.mittal@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tLB7bNkSmI_1NZ8qDAPsGzlJGHZjXWrN
X-Proofpoint-ORIG-GUID: tLB7bNkSmI_1NZ8qDAPsGzlJGHZjXWrN
X-Authority-Analysis: v=2.4 cv=Uolu9uwB c=1 sm=1 tr=0 ts=694dfd79 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=UK9CRoBp1CoiqNknoRoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI2MDAyOCBTYWx0ZWRfX9PCbALqUPkjd
 /qPKRnkP7h4nyK/NQlQC7cp73Nsq6nfR4RddFvV0OEsEdVwzYrEk6WC4PP+j4omV45N7zir5OSw
 TZAWHSZyaO83lLE521dPmdIL24/szdQZvlbx5gqmzhBtT/b2MvvaCdL0HNmfzxFAx1rdzofccgn
 ZkY6MDgK8FFrhDwepixrWNaQ2HhaTpSn36xGrHWS6IZmlg7yQTS6wuwm/WlqKtMaIiUWsh5DE7T
 o7dCEre/uIeRbz1deirZewVlBn0ShvVHmGp8E80MCl4S6aJeFVsNsueO2e1PGj9z54urrMOeSHY
 xrrXrrk+sjwo5uYdZd999L3sZec/UR5o1QSoKn11WOB6qLXFldoznvNen4SK2xhnay1DTP/407t
 YUm6wB1OCrxUM2J99R/gw4bBjFQAYpMguFIC/W3YM2freB4YOgH6/HlB4aJRqjtxFrhWa1f2zlx
 IuRKq6p8h3g2crgflNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-26_01,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512260028
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 26 Dec 2025 03:14:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2874

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Upgrade to latest version for 22.11 LTS.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-extended/dpdk/{dpdk_22.11.7.bb => dpdk_22.11.11.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-extended/dpdk/{dpdk_22.11.7.bb => dpdk_22.11.11.bb} (97%)

diff --git a/recipes-extended/dpdk/dpdk_22.11.7.bb b/recipes-extended/dpdk/dpdk_22.11.11.bb
similarity index 97%
rename from recipes-extended/dpdk/dpdk_22.11.7.bb
rename to recipes-extended/dpdk/dpdk_22.11.11.bb
index 32e6a18..f2db074 100644
--- a/recipes-extended/dpdk/dpdk_22.11.7.bb
+++ b/recipes-extended/dpdk/dpdk_22.11.11.bb
@@ -6,7 +6,7 @@ SRC_URI += " \
 
 STABLE = "-stable"
 BRANCH = "22.11"
-SRCREV = "077a7044cc5b2533410f691c8db6fb4f6667b1ca"
+SRCREV = "ff0626010952913655a6df4c4e12fc386bea7fe4"
 S = "${WORKDIR}/git"
 
 # CVE-2021-3839 has been fixed by commit 4c40d30d2b in 21.11.1
-- 
2.52.0


