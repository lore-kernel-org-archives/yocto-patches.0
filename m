Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A09F54AD2
	for <webhook@archiver.kernel.org>; Tue, 24 Mar 2026 15:47:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7840.1773814285309219994
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 23:11:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=b5oEij9U;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=UXidL7cP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: viswanath.kraleti@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I2wOOt1370762
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 06:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jm6EnesH9v03rKP59wKu/A1TvJEAurD1BeP
	k3SXQFxo=; b=b5oEij9ULpy+j9L8xunGRPtpBeJjFVG0AfE2v1B2Hy9aAiV6f/z
	UsJkBoMaig1fstEPKTESWVXxSZKqynNyfn1uJ3dzHwAIbPZKVT1jNL0VTpLphHQs
	OY4v44eDMRjZh91J0Jv7Ecx3343oBZ9wvXYFp4FSqXk4j2PF0o42xop3mm0YwdUY
	GnntiryhZhM6E6CzIqhI3cPlS1z1ljzquxl52CqRYduFZogLtqhw/Lj6JCKvG2mA
	/ws4ZCFJdZ3XiL8fNK6BUC108/GsMjlfRybmFmHLBPimQcmZyy+reUOsf5A3qXen
	FOhqZT1GixUt9NzBMSEF8JqvcM3rReG0+uQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy7he3h2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Mar 2026 06:11:24 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b05d170cadso31872265ad.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 23:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773814283; x=1774419083; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jm6EnesH9v03rKP59wKu/A1TvJEAurD1BePk3SXQFxo=;
        b=UXidL7cPu495m32uE60M1t5+iuotVkyv3GlJHm2MEDFLe+6lwduhbrhDnBTZUieDTl
         9b734b2ECG5iPoTPyvAODDmVtNMJJIqU7ahv6bDn3lbbzriZaya00QRqnaPuRx3tWFDO
         iCNkWNy9HRwLW1Ei/u1GER0KIuNyzw9C3P0QIjUAeLmFXS+dNRaxwzPAZZaBt1TmfV5j
         lhkk+PE5x+UpGBFhRPUtqKZgeZIN8x2rpuYXRvHNio12rLWgvVRI8saMi6ny3IBJpnJI
         aT4Nx4ct7y+ZpbLV7r/psN1MPX9gEaWRrVi0OJ95GTxWKSMLzhLcVgwc/dGcnMibd1GS
         pqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773814283; x=1774419083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm6EnesH9v03rKP59wKu/A1TvJEAurD1BePk3SXQFxo=;
        b=sQJ2zOGKOKXK/+KNSEH9LhVSbIwN5OCsOgeZZiLiIllA15fHy6Vj1rs+tQUl7d8pqH
         OWEOCYf3+Bwf40KZyMT1i4KJ/erLOefmmDYQRzeua/7aNQcftBmHZOeUydLjf/H0wn+J
         G6b/5Q263q+onOCit3ryJM7puTXxZ0gV/ExradxYqAuaspSy9D0RrmIWcHF5zIwfIea4
         7uazW+lSWvI+z0JOQyhATphUIwZOBppn7Jix7HYFwfoVELMP2vNb61VId2G5zP1uieiW
         EMAEquztVo/AG+j/Plkb9NruCiPf8q1yCbOlmmSaLYLCwxlNOyHhskEiNlweTTN8nxBZ
         vfLQ==
X-Gm-Message-State: AOJu0Yx8WkhL79xCBe2RdquO6sDEoi6atq1G5W8EcAmbNjsrMcJLs9M4
	P62Gy5gYQlyBCDlitvGKuKCbkJrYjtN8jS+Xuw5YE8+Nl+uE+v1bAvF4MNwv7VP18ZT5Jto8hdT
	Uo+FazYOiP+SD2NtL+ZLluo2pQXWFbhNKCdiTvTR/PEaIjw4WGP8WA/OVN9Sbsb4ublW3XEFEFr
	Xdc9rzzZJEWg==
X-Gm-Gg: ATEYQzzLMZx+gaEgSjY6r9YWAO9LxjfXyfccgYN4oEpiDnExUxDTPEADppNqrAJGSUZ
	359h7LXeUNVD7H30zDe35F0J4WBVb8vTOQVkLfgf3B8RbuXNNwCVtxAyoWxZIq1olsyAhg+KteI
	M1GgWAclRsADE1UgldlkcOMFELV6B4iNvUeVI98lYaJnI9c33EINv3lUj8I8/J1bnOYhpVFWVbQ
	F2tGSAhqSkjeiWbeU4QFRVmfEtjQHCkoaf+MpCVJRbr39bqPs56BurTGSV1ewrL/c+GVAt4aKfm
	ktfkQqLvhGhqTQ3zneaOS109ncyKWMBcvyGXM+PB5hN5JiqOdj1cjuF+Lp7MLc1IIii/hboj4QZ
	QDY4E2BY70BVfDXsgXjFkSie2d1nihv7xt2pgNL1Z/RxRTCaJpFY+zQ9Tll7lYzSjFAEn0dUH+C
	nPH/ho/687qzlrTeaMVR0=
X-Received: by 2002:a17:902:ef4d:b0:2b0:5520:f49c with SMTP id d9443c01a7336-2b06e39a1dfmr28071775ad.25.1773814282877;
        Tue, 17 Mar 2026 23:11:22 -0700 (PDT)
X-Received: by 2002:a17:902:ef4d:b0:2b0:5520:f49c with SMTP id d9443c01a7336-2b06e39a1dfmr28071565ad.25.1773814282308;
        Tue, 17 Mar 2026 23:11:22 -0700 (PDT)
Received: from hyd-e160-a01-2-02.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e605108sm17771505ad.60.2026.03.17.23.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:11:21 -0700 (PDT)
From: "Viswanath Kraleti" <viswanath.kraleti@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
Subject: [meta-selinux][PATCH] layer.conf: Update LAYERSERIES_COMPAT to wrynose
Date: Wed, 18 Mar 2026 11:41:17 +0530
Message-Id: <20260318061117.2617519-1-viswanath.kraleti@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Proofpoint-GUID: uk5l6LTEr-m2HQQ5NY2KyLnix5SQAOI0
X-Proofpoint-ORIG-GUID: uk5l6LTEr-m2HQQ5NY2KyLnix5SQAOI0
X-Authority-Analysis: v=2.4 cv=QsVTHFyd c=1 sm=1 tr=0 ts=69ba420c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=hyRPZkD9zPOSxfmHBhkA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA1MCBTYWx0ZWRfX2kkaajxKfxHb
 Z7fc11w6Is/ncqYrSSeq6qPxrfr0GwYzqGE5THPli0NDRQ1PX4H59EeGFgun5XYEf4BQ0H0e0YV
 SNz4OPh9GmUX/lZdROwSN3RwJlaty2bfdAVj1iP+KymHJB6EAfFS3R1pRtyLY3ElC681RycDdFS
 cRzEPMCwX26qhKF6ahcKWq6lVZft3Pykr2TJNy1RFbPGQxV4AXYRciTk2XXBHrzp7UA9LG59Gjc
 pT7SIZE+wkXNoVAbnBa4BlEdGn/CJgtP3OcmFpWZemtwz8oexY533ifTKTl1qAWY6PxCNhfSyth
 77GLCs0Q6FD2C5zzp9YyzneLoUx8XIPsT/Z0qh7du/P6dKGMraG+wLezZXeySOjq6lgeAD9x6OR
 ELc2vflkK3omQr4IedG3v/Pa8Vfyx4A7aVJAMu5hHDjk+IYjg5xhErRGV8qStLIg5aX2Nea6iYt
 OsT2HHBUqzTGQHa3tjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180050
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 24 Mar 2026 15:47:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3535

OE-core has switched to using wrynose release name. Adjust
LAYERSERIES_COMPAT accordingly.

Signed-off-by: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 6ec4380..245b4ef 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "whinlatter"
+LAYERSERIES_COMPAT_selinux = "wrynose"
 
 LAYERDEPENDS_selinux = " \
     core \

