Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E2CD98F5
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 16:00:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23098.1781798408421002985
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 09:00:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=O5GBV6Mr;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=CNEBA+xH;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFDtq61559263
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Dgw0X3ChIgU
	jbp+w404bMIe7IfoJ8wM5Hl/2v3zrKgg=; b=O5GBV6Mr/5rAmMMwmxpSNg0z98t
	34C0el+L3FEJYg/Gipmk7nNb1ElSqmsdx/OLpkbdyzJaLNmDc0dhXae3TARjV1eY
	HRjTdopV35cRwyLR8g8+9YUoc4unF3dW//ArMLWZQsclzdhOeSWcaDUAGul0aBLq
	igsyIeIYwVJw2bLV79clFY9aYJb/AOew785N9/Tg30OI3cRNsAEBQBAB04RISOtO
	56TqIpWSW/W6WB+rHW9DvFu6fDwJVEmXhxYNFyNIOWh3y1mLXZYj3iot+U26lXbW
	5xdPTHduxnT5TXuYjudEnuH7XjtYDaVNg9tLD+eL3GFmEU4z+YJOXXI8E0g==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn41h4s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:07 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-966d5052f68so861010241.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781798407; x=1782403207; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgw0X3ChIgUjbp+w404bMIe7IfoJ8wM5Hl/2v3zrKgg=;
        b=CNEBA+xH1t0mWivdnqbp4UKmVjDWbezT7DK20Sb2kzLJm0AubDCfE82KwiWZCzW5Ft
         GsPa79zlybYP35X6gsIrcRDBmWWn3IwObgstOWbcvCcrpDOO5tFaGzcNqwB2mzdQ+AdY
         jZe2kc/va8sYiYXcvU9Ecz9BuqNE8uM2ar1dQyc7e6MAT5Mxx1tsXLtM1p81WlXZQLt/
         wCWk1W+9z4MOD1VQFTYZmD7XnVIDUTX33a9kM6qwjlcs+6vdvOxFuRgjzFKTIR7A1w1K
         beNl/n0onYRsNQJWmCi5ZNEwsbT4xwBLxzXDFokufsRPIQG9ZVDwG8enfZlAgggLfNii
         wZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798407; x=1782403207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dgw0X3ChIgUjbp+w404bMIe7IfoJ8wM5Hl/2v3zrKgg=;
        b=XMvp4q4nt3sx55QM4AxFogIBwj3LZxZZ4j4DL/GQ6zpKr7ZI5h+VqNmk1N3rrWlRmQ
         boRHwfOTtzUBB5QFAYQLhbeORoLOpkBTini3vCc5i2h1h8HMy7WrbfMVvIp8Lm2MgXSc
         W7osZREXji/E3eYumMMDDrsiD6jsW46V4yMEltUE/NIjJ10b6LFeHihUpp1H1SZYtbwX
         hHkLVZlkrA4L2Krqd/0EOpIi5FRkw05tDbFdI0pT/AXzDwiR3HrgeA+t/CNYRgSd7CxD
         QxSIHKcBU/3LwpNMZEo2cZJbLLgRCgsGUhWMy19VylyTpXwg3Fa5W281EF3g9Ha7djxf
         Q0Jg==
X-Gm-Message-State: AOJu0YyswL46PUPquxQYOkASIIcpD4EZTuYWqH5JI6MTxO7koMwbf7pw
	8Wsd0DPUuKEvO/cE31FzAL8T2o0HWi7gBunDhvMyoJD3JpyxO1C6UU+BWx4wOoDRPC9pCX89B8X
	r7k5+BtI3dr0jtUsJoKuzdCg/RYtZsFfefVNZzP1vn5k4zqdEEP8MRx6blCnTnSs1ex9LIfn8nJ
	G9zLa3kmDZLQ==
X-Gm-Gg: AfdE7clYuNDB0NYOSvTXEnZNywULG6LldFtJ4W4xkdd74ffauELCp5k41bmYB1Cs+7v
	6eTzQ8YTo6JD1DzK2vWH25tJycwSXS+Fl28lpsj71Ctw1OJST7ZfXZOBeJIB/ek//OlA4F3LGyf
	PZQiE8CHkU9cmTu9uRyIMNmpmelq9XIeyxT4n/InpdFvCLoRBSfXpgC6JXjfKKsGSJSGQl/jn5g
	fbm/FknxGmyAyuZkoBEHlPhoFMbxewVrGkZ0C7l7BCoML3myPAgVbcqcaXAGau8UD3Lmi499nsf
	7wecIVaXLd6nAgLVC8SurTmdDRlHUlQSm6Z+l+AL4YsGbkyncnHlwSFq/e5VE7gsmP2e8oW1qlP
	UxVhdkLNP1DixEBdzPJwpk3WKHw==
X-Received: by 2002:a05:6102:2920:b0:727:c54b:b420 with SMTP id ada2fe7eead31-72a0374c7famr213712137.17.1781798406790;
        Thu, 18 Jun 2026 09:00:06 -0700 (PDT)
X-Received: by 2002:a05:6102:2920:b0:727:c54b:b420 with SMTP id ada2fe7eead31-72a0374c7famr213673137.17.1781798406277;
        Thu, 18 Jun 2026 09:00:06 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fb3c7d9sm1023505e9.7.2026.06.18.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:00:05 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 2/3] linux-firmware: add LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
Date: Thu, 18 Jun 2026 17:00:00 +0100
Message-ID: <20260618160001.3634123-2-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618160001.3634123-1-jose.quaresma@oss.qualcomm.com>
References: <20260618160001.3634123-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0OCBTYWx0ZWRfX+zlWfiZjjCtP
 Qqp0un1hV4Nu7g0ITSMPAdFgqsG15uiw/D7dMoHYZnswYHaQvX2gi04jUdt/o9XsNw7hYoyjgBo
 EEmfSf0+AR2yXsIXwvbiC3Bd+8c5by9P5fqoYZ2zkmcIc6LtV0+sbGdgpYTqfZDxXKAwAHo+zvJ
 WjohbwSYLoETwQjZnJWgMjmguNJETxHoWtDmjG1XHYR8lQ3QgqHXOSqQoGqyyZOIRCqkd7jdeum
 ghH3AHqNcD9jIMTUaF2Xwtuq9bKwK54ZKDXMEm/SfxADzfn1Ek4ko7ELo1Pe4MEaL5pZmWjE7Fl
 fvSwbaQUR9CR3bg/Sjss+tdxuQXtKWJ+/05xM+KZ8wf6+1dWvi4ao8t+W9q89kLj31BIuJOCBh4
 iA26dqrpH9/P4l9b6/yRa+CkxqIAk1Qi5rLPGY+4Mc1JbmC0yBEpMTFkJu3cwUOmze7+kjULZW3
 6SMDXZemf3CZAEA1Ecg==
X-Proofpoint-ORIG-GUID: XmXwF4Ypus_q7POgFMH0-mUtM6e6adU5
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a341607 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VJDhfbJ9CoYbhzz39acA:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: XmXwF4Ypus_q7POgFMH0-mUtM6e6adU5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0OCBTYWx0ZWRfX5LJ2dps5v5kz
 qq73lhK8DBUDJlTNnKzbsmgXBMY/tfI9BL3vcWOzoqWWK1AQYfTMMkr2zELyfX23Ad/yLI9B+g7
 t2TNFGrlYbiZ2+mmM8GWrSJ0fu0vMHA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180148
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:14 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4248

In order to make this layer Yocto Project Compatible, the layer should not provide
new versions of packages by default. Because of this, the recipe provided in this
layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
variable is modified.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 recipes-kernel/linux-firmware/linux-firmware_20260519.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
index f2cd873..50df8e9 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
@@ -3694,4 +3694,4 @@ INSANE_SKIP:${PN} = "already-stripped"
 SYSROOT_DIRS_IGNORE += "${firmwaredir}"
 
 # Don't prefer it by default
-DEFAULT_PREFERENCE = "-1"
+DEFAULT_PREFERENCE = "${LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE}"
-- 
2.54.0


