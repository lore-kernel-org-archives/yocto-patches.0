Return-Path: <dmitry.baryshkov@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F79CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 19:21:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3072.1781724090124960212
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jun 2026 12:21:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=TVGC7eaF;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Anhy2ddv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HJGH4l3722228
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T+nxdYGB9rdDr2fdEt61SP16afZ7/4GBahacZROTnDg=; b=TVGC7eaFJUqqocjO
	YPoMq4AXVU7W1SFbfodL3MpuTNMnCaBVmw5hyN5HQHbIjCu4jyFDVwadfUwiKNmS
	RUuY1EaypL21SV0D9h13qfqYvzHkpu4QU6Yj5sb/E+J0sphYKxbnOZWBKrFERlkx
	4Z0YEMh7SL+QZUOKWM/8QLW5JKutCoixvQrEqsmB1khe6n3y92+sIw3ALece25BT
	Ei+rLZ7rNy3mTwTsphRY4c2N0kZCDyAoVb8xmp04SD+obhrYMA+6zy/TFtk0i/f5
	C6+Fy2PWQxTs+dUo46nhdcr0Jgq+BTqK221RqJTZ0ub3B0a+Eit0hnPMvW7fxNrf
	6V/Oqg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2js7wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9159c4b210aso23393985a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781724088; x=1782328888; darn=lists.yoctoproject.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+nxdYGB9rdDr2fdEt61SP16afZ7/4GBahacZROTnDg=;
        b=Anhy2ddvRpWglgHzPU5adDkpWR0hgZ0ogs+6+JzaJAGuFIzdb7WfY0d3i848uo4lse
         Bs/lSBUzrqMtT/s3xgiY14B3sqPdUEVWWY6Q4M9hX6iW+Q52+kE6yDQzafVb2qJszLO0
         0o2KqUM8SOdvFXJqcjF8Dm1Z8YXTGzzuyvUgKAro+f3ZyK1XhUx4Y5Zld5qRMY4NvvO3
         LejiIpZqp0gMO+b8yHa1XzSYBAOt4QiEDvbmEY/sfsC5T+K5kpKDdZBtraYB0TRsDRfv
         vFXbCL7kJHGg4j/zkeKRax3kMsujgEhsvE1fMye3pRfhi9huZE6Sgi4nCC6XYWrmxRGh
         p4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724088; x=1782328888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+nxdYGB9rdDr2fdEt61SP16afZ7/4GBahacZROTnDg=;
        b=f5e2eMbjK766Dmpb3nEtgwPhmu1LJ0g+QlUO6JxQlwlfPcAhBIziy6uPzqWj6ExZhD
         y5G/uStNcCcETQ4CwBi2Dq+dxYbXRTVAEug20hkhZI10dXgHP+RlmWkGyOQ/ZY9wXhl2
         U90TfCaOg0QCuimfLl2SEuSy43aZserOeQq5euX3qu4zmVlOIGo5vl8G2+D4rVTu5JiR
         Xp3NOQRXvoXXh2/HoI2plmxwKO9fyD94C93kEkRUTmBiLW8TgCi0EzHdC3CS+2r7+qxp
         3vYY2/5gtrdmhB+/dlLFm1aEEFNPF4+sjv9hqEKnz2G0EioxUt/ac8Ekw+RsSzlDs1rv
         YDXQ==
X-Gm-Message-State: AOJu0Yx6N6tyfkPqTCAvsxbDVJ0ZmMm2iwIcB7VyyXORMOLc/GabTBN4
	JJw7xrmu96rVbp/SdqTUu1EZe3Be0pYWNR7prOdiNeoYnBNsNPePOIa0wFR8jH6y3ttxL6qa9jt
	mMTTf3EQUArI64BriCmCE8A8RcSsU8+bozzGlx1Z+KZ9EOHvxvjuWvnknDpmQCl+cEVy/f6zy/c
	jKxI+3jBQkTw==
X-Gm-Gg: Acq92OEJ67nTZqiqqdkURZpU2dNCXWKoCdWTYdkk9U1fZneN5Fh3JQJyjjuZa9s/WAn
	ZvM9nkxWsi8xmnlC4TLkOcxLu0D8OAwpSE2A9zQtP2Kis/U8zw4Kb5XILoNnEyeVWY7j8ESZZgF
	RmmqxuttP82yPpN/0ltsX0ZkrjhQz7C6eREMhMgaXdaAjlAK2SBkEpnugWcmrjMjRNAleJdQP/x
	WEGOLJO7ivCtj661ieMglSvEDFOEzsEpX8tWvTwKe/Ztaji09jfWfygcVLs9tmkVQ9EGBh+Uqi1
	NEp7bIo1owsWG6PMAWLD6Yv1mPmbx9FaJJYOx8tsIKyxiPtJQN/M6SKeggW3U7TpddNN+418m3q
	/BMrSVDUxsjyRkH9f5wkUXS5krfmWwgDLO2J3sBZZoEM1sEEzHhN5ns4lgl6cAdPb4U4gSV3WEP
	U+Uix3BnimREHYBsza34VY+FUM
X-Received: by 2002:a05:620a:170c:b0:915:8e2b:e5de with SMTP id af79cd13be357-91f07a26a76mr136696285a.7.1781724088238;
        Wed, 17 Jun 2026 12:21:28 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:915:8e2b:e5de with SMTP id af79cd13be357-91f07a26a76mr136691785a.7.1781724087770;
        Wed, 17 Jun 2026 12:21:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f2fsm4774356e87.11.2026.06.17.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:21:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 22:21:17 +0300
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 2/3]
 linux-firmware: set DEFAULT_PREFERENCE to "-1"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-fix-check-layers-v1-2-d1b60c899440@oss.qualcomm.com>
References: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
In-Reply-To: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=935;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EGQSLnEtk5EHSl1oleXFku2+wMiv2hSYfNwHpAy/+FU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqMvOwLPuRNG25wGaiFrmRF10yzybMllCFZsbe+
 NWlgzmG1NqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCajLzsAAKCRCLPIo+Aiko
 1SRtB/0TeNpGjSQGqmEEt/i/l0nEGejrdjAoP3Uyds2iR0BjIVR4tau0tw0eCqbS6EcaVANPPSn
 1/enErt4hwU+FbOAD4WWj2xIi4xOEyphpXSOrOcvSU4h6CVSN93ncOOlBbYp2hLeJDGJ7/aUW1E
 ECHOlgkSkqo46RYS3hS93tss0o5jJ7Iyi3SGS3E3u97jF/dj1fGG9xh030GNJmWZmncvp0378UU
 yrzPV+DkpPAtoHv//ze4tOpiekZiSBs0Y+YOQm8xSV1JwN+HMgcm13zwpPD58gYLbqmQSzDnCTH
 KU36RpXJIznuiLRG7BNPY63GNZCC4TRsQ3obumB0gqe9W+cM
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4NyBTYWx0ZWRfX697MFENUBBnU
 FguC+vhSQ3oTV6H73dQkNm/T2SIcdpIPaVyvBEnM73gDAHdJdZqF+uY3hRxrTvgFQCmwVXFlkiY
 hns7po6+em8aUoJ90gRxI3g8emyFVjwhVnPmiXxrHZV0tEWgzZnpNATowFZY8kIzGA+BvjjsQ7+
 xegQbMvq4G1/jAhVnyKzemhw5iy6M+G1Y9ZWktm6/Y6CuoJ0VVxDPcBEPh5rP9fO+e0sJ4ZkXb/
 Qy/WezW2m4Cip54m603oFktl3c26jpBfR7sv3YVgSwXqoB6gc+SdnhTNvRDg/xyx1p0dN+fJlF4
 OMPMTzknK8m1ZnHVzVExXmyceBcEAHpT3mFHOoKUFMpvUO9aW04PsFEV0k68dt0weSonMQbYAbg
 7l4P7HmwVfLCIsDdYEkcdjmcuiwJGfygx5XYrNu8rwDcw9JAeXwPd0vjA637nHC8SpDU70L8gVa
 KTvdL7Tlaxt5FRg541w==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a32f3b8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=Ii1caJqkCqkA:10
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=2OJQN-GEI0M8honRu58A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: wA1bZgM4S4nvmAm9PwPE1b9xkI0bDAJI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4NyBTYWx0ZWRfX+v7FH2skQ7ov
 bckWcTR4H0b9B+lNOWvB3kK/0P09zzyKe2dLSYd6QrM9mxRnd/Be2zhtp+nakYupV60UkRLfr7N
 ZOC+k3bvyVcH2dQ7eytSpleKfBFIYKI=
X-Proofpoint-GUID: wA1bZgM4S4nvmAm9PwPE1b9xkI0bDAJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170187
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4235

In order to make this layer Yocto Project Compatible, the layer should
not provide new versions of packages by default. The easiest way to
achieve it is to set DEFAULT_PREFERENCE to "-1" for the new versions of
the recipes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 recipes-kernel/linux-firmware/linux-firmware_20260519.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
index 7eb9bf35fbe3..f2cd8737f253 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
@@ -3692,3 +3692,6 @@ INSANE_SKIP:${PN} = "already-stripped"
 
 # No need to put firmware into the sysroot
 SYSROOT_DIRS_IGNORE += "${firmwaredir}"
+
+# Don't prefer it by default
+DEFAULT_PREFERENCE = "-1"

-- 
2.47.3


