Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8583AC98312
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 19:35:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3683.1790192115609912348
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 12:35:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=avv5eNJ1;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=LEMhB75W;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGU38p3106210
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jXxTsmF+0Iw
	5fVx/k24qxUqNQMnSOoziB9ahXaoqAxA=; b=avv5eNJ1cOfl6lt9OzX5HeTWtu3
	Ml6ufFz911gwjeCEJ+mgqV0r8pAbE7Zvti85AG+eG/qshEPyAaPHH1S2xxtyFP9z
	ttZkRdp3ZhsZoVLIemPnWUc9L3x3fL9Pb9OZFz4aTGa/Fd6ZzZNCbCHXo6db54Y0
	AF0hwUQGUELZqHeamOMBbiffkn9iDMRxneQUeubZ1h7Lq+KfdxSSQAnjWmSsHIu6
	n4hLJmKstW6eesLj3nJ8GJzFM2PO9Mz6l6lqr5+3RcvtBiQBQzisJlA+go6e/64w
	MC1dQJyguj3ijs8NRd6nMP8TsrOrEPX4WqPZb347LryHchgwbqvmbvi74lw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwhkw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:14 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-983310b2d52so339618241.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790192114; x=1790796914; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jXxTsmF+0Iw5fVx/k24qxUqNQMnSOoziB9ahXaoqAxA=;
        b=LEMhB75WbXLMqXknng7TBeOYPWW0rPvCdKclIYp1i3nsgy2peIxTIYFZOcU/qecTbH
         HKXVRwuPraMp0iZ6F4ARQKKXDCCz8ZRP2oiVFcym7ZgLWpTqZzH6rNBACihqxpxdkgVt
         loaeBuvhy9wnjNfxYMl4EcvX00SkGyFiQNjcJLBojmNEELSKJ5T8jqr3D/kFIUmeAlHb
         UeIUR9+wiJ+ZG2PoKc1kQX8CqU2QPdxhUAExmD8rnBFIPLbnZOzV56Ic0vkJj7LGgNl3
         MM9QBNa5d2t3/kvXFXjs2cRcocyKTREgtZi+NDc2rAWDiYKhf3fGVtcijZr4yNz152Wd
         5+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192114; x=1790796914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jXxTsmF+0Iw5fVx/k24qxUqNQMnSOoziB9ahXaoqAxA=;
        b=PBbxkGT+lot9ce5nVYOrclN1+7xiJtADF5l7TjEEPdehuWkbaP/2EyZuVsOGgMzmSB
         BA1jp2teU8G8mu7dhbNbMDEUpaNZ9Cpnza3hroUz4Xek2+2E9uwA6iyip15k5gkEcyS/
         ldtHr8g/eC1yVKcJY4tGZAYI6Qwc4uN6sbmXDaXXIQBP/xqqfDyUtCHlnVvEikLu6Ls7
         kGA9/8heTNWhUAsR7D+YAmhgZuqCZV29vEmmrQh5842hhc6jYomf3llWBzLGtjUzYN0W
         ozyF+Vb/DlnrgPL6hEO8xs0iwH+lcR4SobTq4gRwpLs7QTxoW+xgDpnYTEwrViq2wnGJ
         Z3bg==
X-Gm-Message-State: AFuF++nrNqUT1SShUM80PxyN9NDNuB4g70bGO47O4HtJKOXBAWxiuqoX
	UJ9dIqyOv9DXemy16w5vhrm8+D4LLp/Scvh7JZ7mt6IXJdS15oHFdnwH1h8nVNds4KPEYS8A2yQ
	Dj6h817e/2on90Ze0CXcPAIaNblPtl/NDWNhofEiHgoco3R6J01dpSiESK7vr1us/8GUHIVA2tK
	O3cR6scnanJCxN
X-Gm-Gg: AYBFou1ydnJvAqeJddS62R2W9/ykVC3W8MhUhrvPQNTlU56YuyMKvz338Tz6rFPVYim
	AEtEc2IyYQsrgVZQZd8M+Ayyt+azIheqfJSjEfI5yZe26V5szAt6+wcLRYSIeV7zfvDIIlKuFTf
	LvTjz2/cWOKjvuPsIWfNyouhujT4ymWZGAo15Qr8ZsKuUjtsAPbfQjJDyjy+3CSyFebdYNHJvJZ
	16+FzGkPsub27wNGCmaQmd3hC5/os7VY0VoZxmOxf6gl6yigCMiRcmnlaYPiXMxggXI48N/hCne
	5gmxKUxEFcJXEyxiXcMUy0tVS1nhKCoRDGP87WsePQ7/BLJHZrcKXfIVDzX6ZcO0WvCxpfiOcq1
	QMxMsSZanYunUEA==
X-Received: by 2002:a05:6102:4191:b0:7a7:198a:c2c1 with SMTP id ada2fe7eead31-7af1eaf6a68mr189857137.31.1790192113484;
        Wed, 23 Sep 2026 12:35:13 -0700 (PDT)
X-Received: by 2002:a05:6102:4191:b0:7a7:198a:c2c1 with SMTP id ada2fe7eead31-7af1eaf6a68mr189833137.31.1790192112887;
        Wed, 23 Sep 2026 12:35:12 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm8706964f8f.6.2026.09.23.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:35:12 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 4/6] linux-firmware: fix license syntax
Date: Wed, 23 Sep 2026 20:34:55 +0100
Message-ID: <20260923193457.1759294-4-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
References: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfX5A0DXR/3/Fkr
 anmLrVzh9nLCnpdsgYff3IqEtv0ycNpiIgIEr8k1T6X1ysITwyuLX7zxme1ZOHVYwi7hoEcLhyv
 k1iZRDO+w/9Da9TMpldPT9vZapotezX3sny1hcnrbwDR1MbUVj4VZs9sHHwnfdyoTdHyw30sbl4
 19yDzQYth/s/v+v+8YmTF5FW2fyLKxeNBGWzFp/zWGpSpu2gUXJF3fHr/cliI8JvItKxhn10YD8
 yDyO+QCv9Vh24goVPNVNT/yxHcKXqkt3DHOuoCw7Ohu9oniQ7AI0Y6rH/9ZBBovBIKuAfq//V8C
 74pvVhdUkC8FPQjE2RyBgDjZDAPWisy8DUEuWtl7c/e02+fNpn3biEKLyzKAjtzdr8XfQEl3bPc
 SSQCjWBOj1AZGkfnsPYqwL52ohiA5r1eTTDZDkz+VIymC3DEQmkT2H/xrIonmGVvze1aJRmK1Gq
 9Zh/lf6+sO/H3yYAzkg==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab429f2 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=cYh-jj9vyKDQvv6mR78A:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfXz0ZA+wILod2f
 k1K1ZDOdFuuDx5xT9A2s8AUnKbu2BX8PxnhWzkfivmb1NYZQrBEavwJbs68uXCagKCYKOJt37Y6
 23TWmwXbSO2beRHWUaxyqF/mYP7vTxQ=
X-Proofpoint-ORIG-GUID: NW85_6fDHJtaTjl7JvvvqLKQyQK4Xq-7
X-Proofpoint-GUID: NW85_6fDHJtaTjl7JvvvqLKQyQK4Xq-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4946

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 .../linux-firmware/linux-firmware_20260910.bb | 276 +++++++++---------
 1 file changed, 138 insertions(+), 138 deletions(-)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260910.bb b/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
index 24cd4a1..e3fbf21 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
@@ -2355,144 +2355,144 @@ LICENSE:${PN}-linaro-license = "Firmware-linaro"
 FILES:${PN}-linaro-license   = "${firmwaredir}/LICENCE.linaro"
 
 # For QCOM VPU/GPU and SDM845
-LICENSE:${PN}-qcom-license = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-2-license = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-yamato-license = "LicenseRef-Firmware-qcom-yamato"
-LICENSE:${PN}-qcom-aic100 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qdu100 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-venus-1.8 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-venus-4.2 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-venus-5.2 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-venus-5.4 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-venus-6.0 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-vpu = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a2xx = "LicenseRef-Firmware-qcom AND LicenseRef-Firmware-qcom-yamato"
-LICENSE:${PN}-qcom-adreno-a3xx = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a4xx = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a530 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a612 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a623 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a630 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a640 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a650 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a660 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a663 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a702 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a730 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-a740 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-g705 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-g709 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-g715 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-g717 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-g800 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-g801 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-adreno-g802 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-apq8016-modem = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-apq8016-wifi = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-apq8096-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-apq8096-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-apq8096-modem = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-eliza-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-eliza-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-glymur-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-glymur-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-glymur-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-hawi-audio = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-kaanapali-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-kaanapali-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-kaanapali-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-kaanapali-soccp = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-nord-audio = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-nord-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-nord-qupv3fw = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm2290-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm2290-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm2290-modem = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm2290-wifi = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm6490-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm6490-audio = "LicenseRef-Firmware-qcom AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-qcm6490-compute  = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm6490-ipa  = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm6490-wifi  = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcm6490-qupv3fw = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcs615-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcs615-audio = "LicenseRef-Firmware-qcom AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-qcs615-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcs615-qupv3fw = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcs6490-radxa-dragon-q6a-audio = "LicenseRef-Firmware-qcom AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-qcs6490-radxa-dragon-q6a-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcs6490-thundercomm-rubikpi3-audio = "LicenseRef-Firmware-qcom AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-qcs8300-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qcs8300-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-qcs8300-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-qcs8300-generalpurpose = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-qcs8300-qupv3fw = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qrb4210-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qrb4210-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qrb4210-compute  = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qrb4210-modem = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-qrb4210-wifi = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sa8775p-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sa8775p-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-sa8775p-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-sa8775p-generalpurpose = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-sa8775p-qupv3fw = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-audio = "LicenseRef-Firmware-qcom AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-sensors = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-vpu = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-modem = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-shift6mq-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdx35-foxconn-firehose = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdx61-foxconn-firehose = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-shikra-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-shikra-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-shikra-audio = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-shikra-modem = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-shikra-qupv3fw = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8150-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8250-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8250-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8250-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8250-thundercomm-rb5-sensors = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8350-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8450-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8450-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-sm8550-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8550-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-sm8650-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8650-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-sm8750-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sm8750-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-sm8750-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-x1e80100-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1e80100-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1e80100-asus-vivobook-16-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-asus-vivobook-s15-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-asus-zenbook-a14-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-dell-inspiron-14-plus-7441-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-dell-latitude-7455-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-dell-xps13-9345-adreno = "LicenseRef-Firmware-dell"
-LICENSE:${PN}-qcom-x1e80100-dell-xps13-9345-audio = "LicenseRef-Firmware-dell AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-dell-xps13-9345-compute = "LicenseRef-Firmware-dell"
-LICENSE:${PN}-qcom-x1e80100-hp-omnibook-x14-audio-tplg = "LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-lenovo-t14s-g6-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1e80100-lenovo-t14s-g6-audio = "LicenseRef-Firmware-qcom AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-lenovo-t14s-g6-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1e80100-lenovo-t14s-g6-vpu = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1e80100-lenovo-yoga-slim7x-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1e80100-lenovo-yoga-slim7x-audio = "LicenseRef-Firmware-qcom AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-x1e80100-lenovo-yoga-slim7x-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1e80100-lenovo-yoga-slim7x-vpu = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1e80100-qupv3fw = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-x1p42100-adreno = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-license = "Firmware-qcom"
+LICENSE:${PN}-qcom-2-license = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-yamato-license = "Firmware-qcom-yamato"
+LICENSE:${PN}-qcom-aic100 = "Firmware-qcom"
+LICENSE:${PN}-qcom-qdu100 = "Firmware-qcom"
+LICENSE:${PN}-qcom-venus-1.8 = "Firmware-qcom"
+LICENSE:${PN}-qcom-venus-4.2 = "Firmware-qcom"
+LICENSE:${PN}-qcom-venus-5.2 = "Firmware-qcom"
+LICENSE:${PN}-qcom-venus-5.4 = "Firmware-qcom"
+LICENSE:${PN}-qcom-venus-6.0 = "Firmware-qcom"
+LICENSE:${PN}-qcom-vpu = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a2xx = "Firmware-qcom & Firmware-qcom-yamato"
+LICENSE:${PN}-qcom-adreno-a3xx = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a4xx = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a530 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a612 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a623 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a630 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a640 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a650 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a660 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a663 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a702 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a730 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-a740 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g705 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g709 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g715 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g717 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g800 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g801 = "Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g802 = "Firmware-qcom"
+LICENSE:${PN}-qcom-apq8016-modem = "Firmware-qcom"
+LICENSE:${PN}-qcom-apq8016-wifi = "Firmware-qcom"
+LICENSE:${PN}-qcom-apq8096-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-apq8096-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-apq8096-modem = "Firmware-qcom"
+LICENSE:${PN}-qcom-eliza-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-eliza-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-glymur-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-glymur-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-glymur-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-hawi-audio = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-kaanapali-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-kaanapali-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-kaanapali-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-kaanapali-soccp = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-audio = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-qupv3fw = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm2290-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm2290-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm2290-modem = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm2290-wifi = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm6490-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm6490-audio = "Firmware-qcom & Firmware-linaro"
+LICENSE:${PN}-qcom-qcm6490-compute  = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm6490-ipa  = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm6490-wifi  = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcm6490-qupv3fw = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcs615-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcs615-audio = "Firmware-qcom & Firmware-linaro"
+LICENSE:${PN}-qcom-qcs615-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcs615-qupv3fw = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcs6490-radxa-dragon-q6a-audio = "Firmware-qcom & Firmware-linaro"
+LICENSE:${PN}-qcom-qcs6490-radxa-dragon-q6a-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcs6490-thundercomm-rubikpi3-audio = "Firmware-qcom & Firmware-linaro"
+LICENSE:${PN}-qcom-qcs8300-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-qcs8300-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-qcs8300-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-qcs8300-generalpurpose = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-qcs8300-qupv3fw = "Firmware-qcom"
+LICENSE:${PN}-qcom-qrb4210-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-qrb4210-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-qrb4210-compute  = "Firmware-qcom"
+LICENSE:${PN}-qcom-qrb4210-modem = "Firmware-qcom"
+LICENSE:${PN}-qcom-qrb4210-wifi = "Firmware-qcom"
+LICENSE:${PN}-qcom-sa8775p-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sa8775p-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-sa8775p-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-sa8775p-generalpurpose = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-sa8775p-qupv3fw = "Firmware-qcom"
+LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-audio = "Firmware-qcom & Firmware-linaro"
+LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-sensors = "Firmware-qcom"
+LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-vpu = "Firmware-qcom"
+LICENSE:${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-modem = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-shift6mq-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdx35-foxconn-firehose = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdx61-foxconn-firehose = "Firmware-qcom"
+LICENSE:${PN}-qcom-shikra-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-shikra-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-shikra-audio = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-shikra-modem = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-shikra-qupv3fw = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8150-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8250-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8250-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8250-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8250-thundercomm-rb5-sensors = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8350-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8450-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8450-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-sm8550-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8550-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-sm8650-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8650-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-sm8750-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sm8750-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-sm8750-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-x1e80100-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1e80100-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1e80100-asus-vivobook-16-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-asus-vivobook-s15-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-asus-zenbook-a14-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-dell-inspiron-14-plus-7441-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-dell-latitude-7455-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-dell-xps13-9345-adreno = "Firmware-dell"
+LICENSE:${PN}-qcom-x1e80100-dell-xps13-9345-audio = "Firmware-dell & Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-dell-xps13-9345-compute = "Firmware-dell"
+LICENSE:${PN}-qcom-x1e80100-hp-omnibook-x14-audio-tplg = "Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-lenovo-t14s-g6-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1e80100-lenovo-t14s-g6-audio = "Firmware-qcom & Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-lenovo-t14s-g6-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1e80100-lenovo-t14s-g6-vpu = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1e80100-lenovo-yoga-slim7x-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1e80100-lenovo-yoga-slim7x-audio = "Firmware-qcom & Firmware-linaro"
+LICENSE:${PN}-qcom-x1e80100-lenovo-yoga-slim7x-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1e80100-lenovo-yoga-slim7x-vpu = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1e80100-qupv3fw = "Firmware-qcom"
+LICENSE:${PN}-qcom-x1p42100-adreno = "Firmware-qcom"
 
 FILES:${PN}-qcom-license   = "${firmwaredir}/LICENSE.qcom ${firmwaredir}/qcom/NOTICE.txt"
 FILES:${PN}-qcom-2-license   = "${firmwaredir}/LICENSE.qcom-2"
-- 
2.55.0


