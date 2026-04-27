Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94241FF885E
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 13:06:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44446.1777295182095628782
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 06:06:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=jUlGTVbM;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=BdU5fmWf;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TAql2793094
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=k9FwshEeqNU
	RbCYrHFRk9WlDkRCgfZpI3AWOioJLMe4=; b=jUlGTVbMa+jP5nFltZ9WCX6c1ge
	s2ND/cufOUtwtbrYakR+YzL02QRbfAXkSR07LVEGRIpLyBWLiAkhOMlvVAVOFo3h
	D5Y6+N/5Ub1P14YlT4SAevVQIXRY/E+hNIFpDEAQiw+Ya5Z4Yc7pxytkx/T0yzro
	Q/QVlGQ1oAPfUOemAbimWZOmEHfKUUkyxtEPd/0UWvB1GYIHe4BwOi30oH6UTLIM
	7AV4KvrhFWTs51+em7TpxJn4UCVjUMPctVZ/Ff8fIInk14Cq464byOfGdWxzqf2z
	Aopw8zlF8sgf566o5dKDIa6r6SQ2hV7dhCgaLGCnWQEklVp5i4+r6czMbwA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsa4uv9vc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:06:21 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so12327977b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777295181; x=1777899981; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9FwshEeqNURbCYrHFRk9WlDkRCgfZpI3AWOioJLMe4=;
        b=BdU5fmWfYYjsthE6FZyLakl7szlLnyj5iGZAQEJ54P0Ju+kVLkYrd6lH4gawRRwcgd
         5V0+mYtTQoEC9lM4PuN26c9vw0QBpxvtbiA3oIEtrNUHaxXJjvTtDLef0uVonNjmF8Sj
         +XUglMHgHSX0L2U3m6OTYiIaJxVBJyj+86XKjSrrbGkP1r0EFNPAfwW+wQKWeYNrrCdl
         lNjxBC+F1rTZFf9y96JSjhyp7IYzuN2tAlrrqf/s9+Y2MhHuXfr2optv7/RwBYX+3KNn
         WFiiObW0LRCQw6IH8GHcpRIhXSFDcppAzL043vUO1e6UlNWsv21X3yFKS6oyOOSRl0Ds
         v9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295181; x=1777899981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k9FwshEeqNURbCYrHFRk9WlDkRCgfZpI3AWOioJLMe4=;
        b=kO3/OGwix+9OghgcpC2EwZoDRrEyvaCRSB3eTl279UbX0xjG3pCE7EhqQtucEl/OKh
         BLnBj8me22aHhDI9PU5HBfqEhi5u8NgnR/DEPKHXSx0X2EFG5v9OzUQ63rRrQqhRgQtr
         XyeKw433JWbE1HopQGimnF9BLeRGG7cVilZz7NWTer03ZwgZXokjgVdNRfclftEa7TAi
         F27KhRwyFC0+A6Wtc+RjemzjQw7q/f1JRw5JWsYl+1nvQ5thIC+XoE9eVw3541igIqP2
         1v/DRHwz1mxnmdvPMPen+J1gCMIIDlMwWlVI9WEq7W8UA425Ubg+iYALM8W9ZTluaGul
         qjrw==
X-Gm-Message-State: AOJu0YySFs1deHXMj+QMe+sy7n43/Nc/k3os2QscvE+SReepg/GDxpzA
	MVeF7wUYoVwADjb+qcAutD1n88lvk66B8fJgx2K+Z72i9A43S6GFFRJ1WWNknhtyBocmUFji0JT
	gtTOp6neUxXMfVWM/5k6/dqOSQO36hFCvDIOMkR6WZ3jdt6zvpA1GLQOvaPE4lU4GU/o8I8rLyi
	DZkO5W8jz2mh2I
X-Gm-Gg: AeBDieva0iu9yPeCqPKx4vYAGC8Ytt7xDwhpS9ud2jytltAA5xlAdgNF65wpmDF8sgS
	y8EQkNjXAKovUSSADQviA3R/I6U3nSBHZrv5T5+uURRjXlo2DXzI9ycEG3iQz/VbgBl5dmg/vkt
	+tC608Lo2l6v1V4DwPJHxrNUqsIxaTY3yWVU4/3q73xGC5p/n6FIeHQdH4zON6cPn4g1c8ZL3iE
	2AzvgWfzUqP7zW080KKuqn/+OPGN6C4kou0BGivJSAzAUPTIRFKoXhRAts8MXdH7muky0/D6lKO
	HfEyN4TgbRkRGezbTj14qie69GAQsqtD/cR6LcspqfIt0OlE4LTeaioXIS1BZfpbEPjcdsrm4FT
	vPBz2dwoudIw7p/AVZGloJIla28HmvNVSMUhIHA==
X-Received: by 2002:a05:6a00:c8a:b0:82f:4428:f2f with SMTP id d2e1a72fcca58-82f8c8f907emr42918909b3a.38.1777295180629;
        Mon, 27 Apr 2026 06:06:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:c8a:b0:82f:4428:f2f with SMTP id d2e1a72fcca58-82f8c8f907emr42918872b3a.38.1777295180135;
        Mon, 27 Apr 2026 06:06:20 -0700 (PDT)
Received: from fedora ([2001:f40:970:6089:46ff:e946:5748:5ddc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981d00sm31912823b3a.5.2026.04.27.06.06.19
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:06:19 -0700 (PDT)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH 2/2] dpdk: fix builds for ARM machines
Date: Mon, 27 Apr 2026 21:06:03 +0800
Message-ID: <20260427130603.2142929-2-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427130603.2142929-1-anuj.mittal@oss.qualcomm.com>
References: <20260427130603.2142929-1-anuj.mittal@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VWLMBfExUtsFr4L_5fro7TdZRq6s2O3-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzOSBTYWx0ZWRfX6dU1P9/cEry3
 hSFZPSpZZwTiZ3VFNGMZdO7NQQdVrpk8pU5NH7hdIJNHGCodMj9DBlB+YUWHeSwazJjFANuoTFT
 sQB2RmuNydIW4vJ7mVlXv/6776gPkFVsvM2buag/n94J5Cgw8zSPRc6Zrmb8WG67HdVzdAFPK2/
 DrVWk7sLImcsa935Q2EMDx3bobSx6wjV/2zXlG7OnQvs8/P3HoZ/U0wsqCb4ZL9vlRB2qnvVhET
 GMF5GWRVg6AIziRKIiNO5JpPlCEDe1UTP4zc1pWM2NS4GeECNrFoqlMm8l19J4AJAfZ7zSuga12
 hzdcFnny6XAdXZsGBbjF1K1D1efwgpsT4NS1f3wsB8+2o99ws5vjM/VbwnzOd9LNhMmihuM0NfY
 8Du4ck4Nszda+o+CS4qtbvBPgDHqxopQxJ83N5lVSwUwVhKEPL0KCt4rmCW/cyqggtyqRrPPvF8
 yZ0JBqRNYZmZqmmdEsA==
X-Proofpoint-ORIG-GUID: VWLMBfExUtsFr4L_5fro7TdZRq6s2O3-
X-Authority-Analysis: v=2.4 cv=J/GaKgnS c=1 sm=1 tr=0 ts=69ef5f4d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=TBWujI5UlwArnwUfSjAA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270139
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 13:06:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3845

cpu_instruction_set variable is neither recommended nor effective for
ARM builds. DPDK recommends setting the platform to SoC to properly
tailor the build instead.

Ensure that we set the platform value for aarch64 and
cpu_instruction_set for all others.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-extended/dpdk/dpdk.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-extended/dpdk/dpdk.inc b/recipes-extended/dpdk/dpdk.inc
index 63f8191..6c76a1d 100644
--- a/recipes-extended/dpdk/dpdk.inc
+++ b/recipes-extended/dpdk/dpdk.inc
@@ -18,7 +18,7 @@ def get_cpu_instruction_set(bb, d):
         return "core2"
 
 EXTRA_OEMESON = " -Dcpu_instruction_set=${@get_cpu_instruction_set(bb, d)}"
-EXTRA_OEMESON:append:class-target = " --cross-file ${WORKDIR}/dpdk.cross"
+EXTRA_OEMESON:aarch64 = " --cross-file ${WORKDIR}/dpdk.cross"
 
 COMPATIBLE_HOST:libc-musl:class-target = "null"
 COMPATIBLE_HOST:linux-gnux32 = "null"
-- 
2.53.0


