Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2C7C9830E
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 19:35:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3687.1790192118484658520
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 12:35:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Sad6aFuQ;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=kZoYJd8Q;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGTvOu064051
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bGelFqd188V
	mPDbC5fOpWFbiLHP1fOVhr7FbXMgGZqU=; b=Sad6aFuQxZFNouI++5bHqdGgqUg
	fYeXgwV1rVD/ssw9S786Y3AAjyYX1mQpdaF1rmd4KX2AStOianSyXhBx69pCa8Bu
	I98qEXnQw5azVG9SYPAz6dsp6WgYFyozSCrBl91u01wATnrwkaMH2VyRVwLRcU+o
	nRQ2hjXOqUQCaJvBzBQ8tI1RXE3+2Sqf2B58+BYDl+mKRqRvXdLhndnlIBByGXCD
	yvwwo13ANBusrMK2VNVb6m4cjNSW9zdrY8JR5wHfUccdqW8+HhUbd49prE1HAgkw
	V607kojKqdm0wtjcSEU5qyJ3GVnRzEulMjHgFD+Mdq693Hb5ZDbTDyHpR8w==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfkbhkve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:17 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97e8d95121cso388194241.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790192116; x=1790796916; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGelFqd188VmPDbC5fOpWFbiLHP1fOVhr7FbXMgGZqU=;
        b=kZoYJd8QRDzQBC6GpFK2ezKTp2SPfPWTO9q7ACLYoGQQUEHeUlrvoyz1ANkR//5aT4
         S8+PD3h6etFj9grvCtE67pni+eSUeTtrJd/QMUetZ/sIkkENFDbPnZnSQaXi+g9HwRX2
         NpvnSjO5XY1vsjBgZys91qvYfBHK/0FYeCE6Sf5hVtEQ9jOEmi1zyNnDn7Ez7sUEwRRB
         ZSybRIPP/8AlHTwYF2TV7pV4LgQlxYlLWWWk4sf8PtD0VQsCthvYvr+GxJ/hteHyqM7z
         qDlCg9jvZb6PeWqBVrTu4N6dP93+cABX3iujD8X5JL01VY/Rifl8OSHi7o0vTB6BO/7i
         unTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192116; x=1790796916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGelFqd188VmPDbC5fOpWFbiLHP1fOVhr7FbXMgGZqU=;
        b=xe2ZtYvuOulEqS4vUKgHjMRdTo8j+en/UUa2mU+7CxnIAvNev24hQxABw4ggwvLXhz
         OvKBDPaYh9Bka7Mx2nKduVVffDGlbSxkQlXSsOJinwK5EXUu/EJE2F4sxmTa/53ZwkCp
         eEVidaFcgwsIL2WBBBMNlIafA8bPK+qktiDsyAzVDSkN4LTHzdrQJj8pSevJx/7wsLRE
         5SLbdD7IG1tGMaTK1KIAzHxTo8/GNJn+YC+mj5RY6f6i2rfXlcT05vIeDl0tc1XljovQ
         MvbUTVvdEe6Cm8nDewjbz9ICgNyQkdZPNlsF+UlVdoDwhsvMeWudpAZ9/qnOYUUDq7cX
         Q0Iw==
X-Gm-Message-State: AFuF++lfJAhFWaU7zf4hobS892OgZxjshpgNeB5hZnH62Eb7PutWAXkJ
	rgu+q7sCYLTrq44qoq5XpDdgMSqxT8zZUN12ZlZ5v7qBsPHTbba1b+0rU7QCaRJTM5WNJEhnAH9
	BuZFOG9lDHalhUaOpuMUTKScuxTJ4UPZpjwYtwdFqk6g+zS20jCdPGsUsPe6OBtCw91X3H58oki
	mzAYCzLDAh+mTV
X-Gm-Gg: AYBFou2BPcixlgG1C9nY7Ea8ewLQ+A6HQ4OcL3+uI07CncezuEPANaO3AFZe9Q0Yv1Q
	eZ38f1oyF8jv2qNx4sNpUC3Q9HzikzV0UBA8/9MrwgxiXD6dwW8z2EzYm2JS61NQcoJKGPzwmf2
	e6OxABReu55Zg1QwnyACVahJOkSfX987G2YK81bZLvuao9tdkwkaeUJrpKUnqRky8KZm6mPnBfO
	dnXxm4WNAvVNj5yp35R12041g3MKMS2m9U6+ulS5zByqKs+IDlv3c+lASYP+oacGM0O0F93dknl
	uuMh24NvPfM7DKB/SQswVf2HxdKyxz2/T5GJCripvOhQvIdNABHOz9hEWzehddSO1D7xalvex6M
	we9044GdEOMJR9O0xd6coB6zw
X-Received: by 2002:a05:6102:3f8f:b0:79c:2e36:a2e8 with SMTP id ada2fe7eead31-7af1c48febfmr231472137.5.1790192116335;
        Wed, 23 Sep 2026 12:35:16 -0700 (PDT)
X-Received: by 2002:a05:6102:3f8f:b0:79c:2e36:a2e8 with SMTP id ada2fe7eead31-7af1c48febfmr231443137.5.1790192115850;
        Wed, 23 Sep 2026 12:35:15 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm8706964f8f.6.2026.09.23.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:35:15 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 6/6] linux-firmware: fix license syntax
Date: Wed, 23 Sep 2026 20:34:57 +0100
Message-ID: <20260923193457.1759294-6-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
References: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfX9uoi9ewMZR08
 8731orE0Ux2aCLS+GU6KMX4DaSPAEMHy3Sl7IWli32hFjn4qMJ+2462O10CNPVbCHcTpBIA9W0g
 Eo3xp6nh4lOtWxIa3OXftA8OdSkO1Uw=
X-Proofpoint-GUID: gfzkLkvE1sHRl1iaPvNjPAJg4qvx1Y3W
X-Authority-Analysis: v=2.4 cv=RYMFmFtv c=1 sm=1 tr=0 ts=6ab429f5 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Go5Y0OM3KgJ4AkkWq84A:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfX20ysQrn5bEHZ
 WV/8q3exZx+BRNxZUh42s3lPdQW0k0ej0A5RYMvqT89vjgnLWSPSZrjRVLZ+w3qT41AQRMp1fU1
 sndZk8LDl1HKHxErlOugiDBe3vSkB/bSDPPGPFcYOEv4Lc8m1dlHs4l32PzjlOmqETWzoC1Seh2
 7n1nM2mOWKzafo6+7rTslS8Ur4iX1fnKTam0qla0qpTAcH+Jc9oNRkXDFtO8RJX4ROTzY2ISz4o
 4hm7mWXPqhUPmyKw9NpxZ0XxOhIGa5H0gtDInqbXmBk6CCGg1WGJs5NEW/MfgHVgOc4Ttgux5f1
 BdVGpyQqLxh7lGp2ynTjru9osY8ZOYDTShaqrHePhKovm6c7r0vdcfIXq76aRmpCz3LaqQHcpt4
 X1IIeCklOnwIJSYDVdC6+vn0dF5ZaVRcwkKsx0ekBmmouP+F2cdCv4xKTSkV6obsjDRY7Fen/aQ
 vXalFRcDVVqFUczQPxA==
X-Proofpoint-ORIG-GUID: gfzkLkvE1sHRl1iaPvNjPAJg4qvx1Y3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4948

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 .../linux-firmware/linux-firmware_20260910.bb | 56 +++++++++----------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260910.bb b/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
index f77c87d..4bb0884 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
@@ -2167,34 +2167,34 @@ RDEPENDS:${PN}-imx-sdma-imx6q += "${PN}-imx-sdma-license"
 RDEPENDS:${PN}-imx-sdma-imx7d += "${PN}-imx-sdma-license"
 
 # For iwlwifi
-LICENSE:${PN}-iwlwifi           = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-135-6     = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-3160-7    = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-3160-8    = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-3160-9    = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-3160-10   = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-3160-12   = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-3160-13   = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-3160-16   = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-3160-17   = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-5000-5    = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-6000-4    = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-6000g2a-5 = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-6000g2a-6 = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-6000g2b-5 = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-6000g2b-6 = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-6050-4    = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-6050-5    = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-7260      = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-7265      = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-7265d     = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-8000c     = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-8265      = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-9000      = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-9260      = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-ty        = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-misc      = "LicenseRef-Firmware-iwlwifi-firmware"
-LICENSE:${PN}-iwlwifi-license   = "LicenseRef-Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi           = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-135-6     = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-3160-7    = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-3160-8    = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-3160-9    = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-3160-10   = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-3160-12   = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-3160-13   = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-3160-16   = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-3160-17   = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-5000-5    = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-6000-4    = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-6000g2a-5 = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-6000g2a-6 = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-6000g2b-5 = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-6000g2b-6 = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-6050-4    = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-6050-5    = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-7260      = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-7265      = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-7265d     = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-8000c     = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-8265      = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-9000      = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-9260      = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-ty        = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-misc      = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-license   = "Firmware-iwlwifi-firmware"
 
 FILES:${PN}-iwlwifi-license = "${firmwaredir}/LICENCE.iwlwifi_firmware"
 FILES:${PN}-iwlwifi-135-6 = "${firmwaredir}/iwlwifi-135-6.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-135-6.ucode*"
-- 
2.55.0


