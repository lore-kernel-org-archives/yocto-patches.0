Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F5FF8862
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 13:06:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44445.1777295181307760286
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 06:06:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=S2sEOlLr;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=GiWUU+bj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RB7ZCO1238182
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lmzb2c73Sj7GFITTYizQFpZvra6eAqBzzC0
	SnMBPN04=; b=S2sEOlLrnH3wH5BaqjEhZshSy0UHPlwHCzDZVrAiqs93n0jqpqB
	e1QWQG5broE3DYrPwwfRVzy1LGOrPrmVH1a3oGYJa1uwQXJ5g7wcN2L6prUroEXu
	rZPaiq5q9h0GR0STmYqkXbMlvaVtk6Ncaud3Fj+6oB9RVsSCcRoKiCyqRcHfePMv
	/GqOHHAp4ir2dg4t5XqyOUEqZsBWGGmbyPtVNbaVyoWwfha+hf9LMqJZT2q0h8Bl
	cS/2UMdcsjS4LtKDY0YkYLMzn+bNKpeX7z5Zjp2ddpv8KKURtLOWk1hOalv9xIhe
	hkAap5D2t/ZkDF1llhTgUrrNvwQW68ONnqw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt6n4gcjm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:06:20 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so13687317b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777295179; x=1777899979; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmzb2c73Sj7GFITTYizQFpZvra6eAqBzzC0SnMBPN04=;
        b=GiWUU+bjMGyN3WOfGKKviXo/e1eMG4mulIcu8W2OpcFksAJpQ9Z37dHqy+7JInjVvb
         RNFb957E/Poth+N8zBZv2o5INqrveGfXBLpRUtOjdff4t9s2BjZVgpuybiLQAUpMjSOb
         FER1Tg3T8+97j5G8jKkK5U+nntcPFnfy2nNXBb4LVOIx+5p0+tbeG8faXMbVmuEDQB/V
         PP/h6w2cLmlU2bk1h7Conwys2XGsOhdMJjU7bgzcyGuoA9/3VhWRFxIbS5csaFCVND81
         iYb7BxKHt11WdLipaReMbAEW+fx1w2syMHaYptW3Id2bLvyquoLk2va+d8vNRfBKWhe5
         esCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295179; x=1777899979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmzb2c73Sj7GFITTYizQFpZvra6eAqBzzC0SnMBPN04=;
        b=da9rPY5HWRpZEWoKYkoKyQg/jITxUj8VkM4L66IuwePrF7rg9jOkhCvxUd4rZyECzI
         CHdOrR4lAQNaysStJGHaMivEJ8kwaEm0o29To2icX8yuvJalhYHGekZYMu9E/SuBAAT8
         FIB15yw9gZfOpq9vgJgc7d4IGNjIbn5WTrjogHeHGxUzihEFIjji9qySU7lewp5qchX2
         8BO2LCig/3Cr8PBBJL3jNkmDNbcdMI0RgnWPEC/717/IQ7XM1jfG27FivxRwMLQtA5PI
         KTasXwbWVrZ778ZK3rutrO3haDraHW1+nxrcgw8R1YYg+gElNjHRx9JK+Uuom9nin4AU
         mUsA==
X-Gm-Message-State: AOJu0Yy7c52uNSBhM6URdbg83hPfvppByKccIasZU2HSCTDQXqs0gKD0
	KAvcGpC2zFSGTvgJQco4/XkrbECBiR8132G3dbSxRWDx3YXzcrgdrFwW1qzz/1Cqj8e+K9tXJ7J
	XDzdCkmL9n73tcvTAaHzj8b8A17tDeRJ+OGC4RgxGobMN4UFQZfyCSKNdCC3nebLEp10Kmao+Uf
	gSn2sZmKSvvlmd
X-Gm-Gg: AeBDieuRm5N/MqaHeAg6hoBFoTMeqOjQMB39NpXSmAukwXSCd+7lS1EK3V4cfftw+p4
	V5fnlrcXvHTk0Cgbov/Lrmmgl8Qz2TbYMqnCX2dn7s8xuMxf74VkovujTShQZHuymqH/xATv1JE
	Uim+O/20vWjIkJS4WdtheZ1Bmnq/xxwDVKDmoUpb9T1PeH69RT47b0miyIJoAaeMyVG45d0hzlg
	nGjIqZy3lnpfAAEA9ePYZaoOaoJFuUTHLuu61dF3GO29dWEVT7HmghE2SKZhQ2WWFpvwG1ew2zq
	oANDY/1VNY4QRacuJBBfyINYx6bCwpzu66ymjlfa45tGY1jIAlfWFas62fi1aZnkxd11npGilN3
	v0k+HM+9Ucd0f0XGVVfMDvQHJG57BoNUGnzVhgg==
X-Received: by 2002:a05:6a00:4088:b0:829:86aa:e163 with SMTP id d2e1a72fcca58-82f8c8369f0mr43719131b3a.13.1777295179227;
        Mon, 27 Apr 2026 06:06:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:4088:b0:829:86aa:e163 with SMTP id d2e1a72fcca58-82f8c8369f0mr43719091b3a.13.1777295178545;
        Mon, 27 Apr 2026 06:06:18 -0700 (PDT)
Received: from fedora ([2001:f40:970:6089:46ff:e946:5748:5ddc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981d00sm31912823b3a.5.2026.04.27.06.06.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:06:18 -0700 (PDT)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH 1/2] dpdk: add a PACKAGECONFIG for examples
Date: Mon, 27 Apr 2026 21:06:02 +0800
Message-ID: <20260427130603.2142929-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ATmv9e65rTRI-FFgK6m_kClPLT5I6y3x
X-Authority-Analysis: v=2.4 cv=Xba5Co55 c=1 sm=1 tr=0 ts=69ef5f4c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=VWvBstAF5WgVe1gHbmoA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: ATmv9e65rTRI-FFgK6m_kClPLT5I6y3x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzOSBTYWx0ZWRfXwk6gm3cXyziV
 l+iqmLSz/hhfXIOYjKXX7SPgGgoJKdYa4MTFWlBAbKRe4KcCRe5lEMggB6FR8weRbKDzRI5fbBx
 jG4G1ZtdKe5LkNjeDpHXZRH7kIBvJRDYDxEUdmln/giFObIgHVIhRI/Kj+zqmMcRrukZh07iCTu
 U7GOBZjm81TJoOnn+qs7CTjTkrq7sUcrf7L1/ogCvUa3Ewn74W/y3sm0wID552W8lOtup6fp+pl
 g+u+fNNLMcQnyO+i1KVAk43eCszEnyc4wGwIeoDdYXEc7Xj9KuJWCqBhHLyuiieoCVTSSteyJG9
 /8/17EaLQDTwo9ISajX7HiOrhaSbFGqXrGH6A1gZRrxH33D8CxWZtrTEBpAR2REO+LvdEUblk41
 HUDFlxrBnq5VghE+p2TRh6mLLe8FKBmW/jFR9CN5bnIpcVnZFnI8R1LJuNSHB27onw+NdZI2hkw
 m4CKHxnlB6qBAq9NzhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270139
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:06:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3844

Building examples may not be always be required so allow their build to
be controlled via a PACKAGECONFIG.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-extended/dpdk/dpdk.inc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-extended/dpdk/dpdk.inc b/recipes-extended/dpdk/dpdk.inc
index d59af8d..63f8191 100644
--- a/recipes-extended/dpdk/dpdk.inc
+++ b/recipes-extended/dpdk/dpdk.inc
@@ -17,14 +17,15 @@ def get_cpu_instruction_set(bb, d):
     else:
         return "core2"
 
-EXTRA_OEMESON = " -Dexamples=all -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)}"
+EXTRA_OEMESON = " -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)}"
 EXTRA_OEMESON:append:class-target = " --cross-file ${WORKDIR}/dpdk.cross"
 
 COMPATIBLE_HOST:libc-musl:class-target = "null"
 COMPATIBLE_HOST:linux-gnux32 = "null"
 
-PACKAGECONFIG ??= " "
+PACKAGECONFIG ??= "examples"
 PACKAGECONFIG[afxdp] = ",,libbpf xdp-tools"
+PACKAGECONFIG[examples] = "-Dexamples=all, -Dexamples=,"
 PACKAGECONFIG[libvirt] = ",,libvirt"
 PACKAGECONFIG[shared]  = "--default-library=shared, --default-library=static,"
 
-- 
2.53.0


