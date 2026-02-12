Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D219EB4913
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 11:59:54 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43461.1770897593459187607
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 03:59:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=ed4GJW/8;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=i24XTWZI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CAo41R3145664
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 11:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=zU/qAcGYlW31Bcia2Ao81XICyhCPSu8IMU7
	D7j3HiCI=; b=ed4GJW/8jTjFvKf1q1aU6uM1Bzo1PoDso3/LsK4iSqAYXTUv6Zo
	NVlofUPwqwQKzwR+b9dICs2aM7XuNMgxkSCqq/eIepGioP1fOg2mCvLpznmaRGUh
	EvBLhFNVZ2oMtXA2D4GnTWAJg7QtMU1wl2KXkswDlHHvhWjTTfkbhSaBHWBq6+8X
	OkFdnT4zKu6c8eYvCGLb1L0ZjCbkRxenOVrUiYeYaje9IPdUTfcnQNz4FjHey7Sd
	f4FbQ3X9fouStArYAh8SMbmRT1T815qMNasJvHGO8NaaJGp3WapERKFLGvZZ5gS1
	tTWboKiZVVNqU5ODBeaUPE+NDc/ufDUWf9A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8ukt3qy1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 11:59:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so793379a12.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 03:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770897592; x=1771502392; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zU/qAcGYlW31Bcia2Ao81XICyhCPSu8IMU7D7j3HiCI=;
        b=i24XTWZIxmr7GTmxsbiHWH7H77wRbCIY6eF17DYIyuz5FtoiV6khT+Mnd1+e1gts5B
         ji/HB+8+wAtnZCTJakYrGIlS45K3UmNdpN/RfWU0XMAal+QDodJv1rQtnj494cEDbdeb
         Y8H03NPYHzbfi2w7dzeLClit5zS0JLfqcQItnjUuk92yV+DlwdRobtaJGDCpDOLwTyuK
         ipO6hvBTOErGLmfChPwuEjpSLgLj6OXJANDlHswjZIdcCa0RFCiCNMI1M/oFnWwh4c5Y
         xUjmOTx2mZYSbbeL1jGNf7bWZ9c3Qgbq6jobGAHl9yzX79cW5PwJKPhC8hYRKosPj0Rq
         /9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770897592; x=1771502392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zU/qAcGYlW31Bcia2Ao81XICyhCPSu8IMU7D7j3HiCI=;
        b=HpRttfdajKEO2IXRdJXZKSBufR2sMYw6jUPdj8WsiDa5CuAOuv7JmzuzXHhFd/PghI
         XvVZYze7Yxgp5slwZvL6BgsGrtM5WEst/PRhp378S+fkwZqFzSo3mNhI3oX2+zKwrnsc
         ZjgzeLzm1MSbEX/S59P3xOERHqFJaslcOwVMSgeJyFVKUGiJv5yvvWweP6Z5Bh1wZahz
         nLjnttQTn0wp4uDFMDsiFjis5B8VgUQpKFEAm2bjNjwplemB1BUd16QejEXzOQ94O1YB
         fS5VPfvQsmARpw3OxrnkHNHhlNVhhjy+d2dIRCWUtb3MihCR6GuUOouqJszt6JYvC02U
         wVAQ==
X-Gm-Message-State: AOJu0Ywzx1/KH0RCt56hfNJOQVePUmS5WQIPtf6Ht6Uba3L8W7RlHWJs
	FIpk3dDdS2oBBUcTYLL/Gjao3LP6Fv0xbcMARDG7HtATuogkurwCAxc4sGV/PsLnGrAiRM3Uubn
	yzGwJmwLqo3Sxzw+GJ9CVufbCEhAM782enB0QrcK3K57+eQ4lX03+VbM7v6YXvtuLFUM2ZjtKUN
	w25QHBSduuD00B
X-Gm-Gg: AZuq6aLYour3xLAhs6y3UU83Rqu3UVJFGEGuiJOntFWkilRZPTmXNKjuJI/Hv3FnWRn
	BeBmVlfrIyHVTO4Vr4bYbzGJPIeSbZa24EVFO+AvmudhY68saQDqYrUvB5bkgOAM83N5zVoLGbX
	wYF9SaIKsAf6o1Kn+U4E813KUApjHxgdyQemfTBLN5RxtlZVZTPmAbS2wo6L20AYg2UrGty3mBZ
	d22Q6urKwaldWdYXomZLfxoYNSIvOK6w4kRk57vs7G2YeejL8z4194fZHJcToqosB67PwxHG4iZ
	zUjyiU3GDsSmoAzqUvXpXcJfj/fo3y1e944Kkw1PNCOEWtNqTDecsycoSzMC9xqsfVDUBlsPof1
	8ot1jWafKQ80XenYo1pTGJTeG38tgwgiZAKPNuRkjVmWRFYxe+J4N
X-Received: by 2002:a05:6a21:1191:b0:366:14b0:4b16 with SMTP id adf61e73a8af0-3944a70557dmr2194267637.33.1770897592139;
        Thu, 12 Feb 2026 03:59:52 -0800 (PST)
X-Received: by 2002:a05:6a21:1191:b0:366:14b0:4b16 with SMTP id adf61e73a8af0-3944a70557dmr2194247637.33.1770897591524;
        Thu, 12 Feb 2026 03:59:51 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e9dff38sm4963843a91.7.2026.02.12.03.59.50
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:59:51 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 1/2] config.json: extend meta-qcom build
Date: Thu, 12 Feb 2026 17:29:18 +0530
Message-ID: <20260212115919.3172900-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA4OSBTYWx0ZWRfX6LscDroUtb8A
 jEV3Q5NEJbnVjyeMGPO80CpIFPcHG/Ueou3EUYIdhjmpHfoeO6xACCFr0h5PCV84Oi1mytDoD5S
 S7FcTy6ueDCBE9iWvuYo/rmbjah4QZi1X4EauAa/sOszYBEuDQ/hIvljakMCt3wrf4OzmkWjJPN
 ezO4Gxq9Vj1+CPTVVpnn/ranJn0TD9nrJdpTx2kUhOL77NtFQMR0BxVVVoogM7g1mHsCKmv9GB3
 3qyXw7OVRlfFXm7StNg8N9FL3F/zjNGe4mvSspRucxdFpSA1wb789Huu5CuUkSC9bi9k+8iqXgo
 XlVLYEw8OneQcyF5MHcp9rX66LQ61nX/j6oG4YXmMYhXG2fzYSM+GoBCeR9jnZW3sZ8YVE1tDAC
 6qhjfX4SND+pbN5BJ9STTCyeDorzy8qfW8aLP+LvNhLV4+ozR3Z0rdyXVyo/egnfvZvCDcbNxa3
 KuaBWMQ7/HeDxyWZzWA==
X-Proofpoint-ORIG-GUID: -vzVzNw8vvYEyIyuzKcEatGO0vuDbP1_
X-Authority-Analysis: v=2.4 cv=INIPywvG c=1 sm=1 tr=0 ts=698dc0b8 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=tDZilc7mOFhGon2WdAsA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: -vzVzNw8vvYEyIyuzKcEatGO0vuDbP1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1031 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120089
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 11:59:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3227

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Extend the build to generate weston images as well.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index 407d245..8c94291 100644
--- a/config.json
+++ b/config.json
@@ -667,7 +667,7 @@
                 "shortname": "Build for rb3gen2-core-kit",
                 "DISTRO": "poky-altcfg",
                 "MACHINE": "rb3gen2-core-kit",
-                "BBTARGETS": "core-image-base"
+                "BBTARGETS": "core-image-base core-image-weston"
             }
         },
         "meta-agl-core" : {
-- 
2.52.0


