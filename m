Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7200EC9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 19:35:23 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3682.1790192113914659390
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 12:35:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=c+BiNX4u;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=XLqUSNwk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGTqHj3082027
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tHaZNaDP4C7
	1k1qfIoyz1JUrtQA5VeiBjEyNiaH6Jtg=; b=c+BiNX4uIPy/Sc98W3QeC102gm1
	Li1Keb4+cJ9h8HnOZUHHQUOI693XmG+Ubd0CR209OspPugv5FT71P78EHxrsaKP3
	0WTJnPmsh3lCcACuSnfzj8vMlXQGhudYeq9vFw3UayeblcbLCIMKUNON6rc7ZDyu
	/06RXc0vTR4Ad/mLl5Hl18kJjZYxoUoPvl1aFC63+wDw21SkodgrN3PaFqnJlAu9
	fit4DystsJ2obVrpdfbkRV1+aH4OLmXiOXRnfIUtDb8t6+v9HadZd5jbq5vn0INp
	+9BdTIeSb2ifZFl7WZZxqWXndZLxWeJct1Osl097uuDR+FSW7UmpGNDSPJw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbx7jn5c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:13 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7915a83539fso1177678137.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790192112; x=1790796912; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tHaZNaDP4C71k1qfIoyz1JUrtQA5VeiBjEyNiaH6Jtg=;
        b=XLqUSNwkDoRIPNO8ZkVqULT2V+wDt1fBq1DR/lvUW7fl7qUM7POzhv2aPEaM+IXnSz
         Eb7DViShvVhJklCrBWQqv/dmvEeYDZM6oB84EGBeJ0XcGLoR0fWZA/c/nmn8EIL7BAWK
         YTavNcw2gTB8KfbUkyCRd9W+dCshCLsHUQL6JaX57yJusTXv4+mc+Gx0n+RSfJP41SrS
         ne2AjzrFRD3DZK/iiKSchCXCeb7wt4ta5SKQs9Gbfk//deTLaJhnEzyJSNXH1CQf7lfI
         T0Y8kB5ftDmEBhWpn0SbLbuWPAPmM4/85av+z4SmJCJP0nILjY0MrqCDczACw1kPcDun
         j2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192112; x=1790796912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tHaZNaDP4C71k1qfIoyz1JUrtQA5VeiBjEyNiaH6Jtg=;
        b=Z6oVQVSTAASfA6+raO0HF3lFVaBZNuzf5qXdieauJkgi+d2JABZ8L3pkApls8+E4rp
         yMqsm1baK9mmLkTOHGE38CR1HjT51gQMYeSpas/BA9CWyJ9u/PHtcrZAmw0TdY1KAjcU
         2kSZ+CEGSVUWo4951OkQzw1ZQ7MWJArwkwtU6hKmFYV6A4tUwCN6p4X0Y0addtrm1klH
         obb6OgtWwroOsUzMTtsttxUfQW+NBS6Flcw5AOgbWgPLsUOLAM8o7xDn7IvLooBIGfKV
         0Q/k880F7sLnL7l9k7n0Plo+VPHfQm2JEwy15IJJ4pDRNoHzi/iiVlptZE/jHGwr3sLM
         veaQ==
X-Gm-Message-State: AFuF++kvHh4PoR3jPOroLtmOeF/5pzPMZz3lu0iRVSm1Tun0d/LXTDq0
	DXc5ltkH9HALiv8VQ0URqK/no9vwBvbcnmGHlmRbU16g/pVFdacK22lGmAyoO7Nlq1Q8DctAAHr
	87imwBsL0zELT9ML+Y5vyeA3258jZsDxQkDBF8wPAPm6vpyNgmIXXQbnxpi6PQoY4Otoh50vsGn
	JFX60DjE/fNTKv
X-Gm-Gg: AYBFou3igPb1AMYkfwzDLZEsmQrIWpzFH05cyOcfKhqVCKY77286b1dCSL8k6whaRKx
	qUlwpdC0CUcJctewycFtusv1mJ0wDfa9GA2CDig5aXJlijpyq+9FZTgFAvvJtFgcDyrgYeKkk22
	DmakxoYMdsN2mltydOzlIpnm6UOc8lbJ129oJqn5FQAZN0ZYX02IVOI6V9gKBVCQMO+Qo+X/tG8
	hE8nB3EtLoZkROzam+MaXTW02ogck4pLJPcQb2pcCGUBcww1yOtWWa9fwE6JgTRuiPiL5YKB4VL
	w4ixPM/XQWTamyXJq4Tnj5TuQF4jwIlw/5f2U2H1ApgZf35LUfPABC+9EYsxuAfkEhTN9aI0f+b
	X9Fr+GtUC7CKXoCKdJYJaA4Xm
X-Received: by 2002:a05:6102:3f46:b0:7a7:19aa:8a88 with SMTP id ada2fe7eead31-7af1f2fda6cmr205050137.35.1790192112175;
        Wed, 23 Sep 2026 12:35:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3f46:b0:7a7:19aa:8a88 with SMTP id ada2fe7eead31-7af1f2fda6cmr205031137.35.1790192111650;
        Wed, 23 Sep 2026 12:35:11 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm8706964f8f.6.2026.09.23.12.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:35:10 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Vivek Puar <vpuar@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 3/6] linux-firmware: upgrade 20260810 -> 20260910
Date: Wed, 23 Sep 2026 20:34:54 +0100
Message-ID: <20260923193457.1759294-3-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
References: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eYQpdsfmY-YJH3C2VbFzKKqE_fbSVh5X
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ab429f1 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=jpfudPgQk0bfl78LqagA:9
 a=gYDTvv6II1OnSo0itH1n:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfXzRWM8mAqhbHZ
 VM7GZ+825Z8jqUt1la7EJkZGq7bO2xrEjedS8g7spvggGTLD92/nFpuhnOxvZbNRY07PCci5Abp
 IARtU2KYbVtHemSGhijPeKeY8COfwRuYX7nVJ+KaHfcphzCRCzBSYsdZimA6Yccv3zkkTunBCam
 9pLEi9kQNaW0+HdlyE30UNfZwBPWs8WVfFJfZLCv/tjDIWovTNxhIajgHjUMZiudMGTALYTLpBa
 shbCihEV7ht0Ef5v5MFVDWHMlW5VXUUG0AtCEsREnEF6xm6PAhrgZHGoUATH7D50GIr1p8qEFs7
 Pf469bWnjjvjUMkcZyZ5+36gZX8H+Ihesh/XbstS1pULP+YbGJRXd7WjlyIE3rR3Zw4OOZ0Kp/l
 3zybjNLHzH0eDgdppFeo1vphxc99eTNtFoIBJ6udQLx9smnFnFkTHvfCWhwbprcVS7xU0EBryo7
 VZlLVAWM7eXubm15WMg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfXysZ1OdRz39bK
 j4KcHEA+0WtcDmlO00f/9u4QAVxIyOdW9B526az2iqHabqwKpqitp5nkhsgrxctedgg65oHH/ZN
 2ywvFciu7iAvoTKVWjjhsA8QWy/7O5w=
X-Proofpoint-GUID: eYQpdsfmY-YJH3C2VbFzKKqE_fbSVh5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4945

From: Vivek Puar <vpuar@qti.qualcomm.com>

Upgrade the firmware package to latest release. Add firmware
for tas2573 stereo, add Bluetooth firmware for WCN7850, add CS42L45
SDCA codec firmware for Samsung laptops. Add audio, compute and qupv3
firmware for Qualcomm Nord Platform, add compute firmware for Qualcomm
Eliza Platform. Add ADSP firmware for Radxa Dragon Q8B and add GPU
firmware for SHIFT6mq. Add 'primer' files to cirrus CS42L45 as they
are common to all SKUs.

Signed-off-by: Vivek Puar <vpuar@qti.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 ...20260810.bb => linux-firmware_20260910.bb} | 36 ++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux-firmware/{linux-firmware_20260810.bb => linux-firmware_20260910.bb} (98%)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260810.bb b/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
similarity index 98%
rename from recipes-kernel/linux-firmware/linux-firmware_20260810.bb
rename to recipes-kernel/linux-firmware/linux-firmware_20260910.bb
index ddf6627..cb3bde4 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
@@ -277,7 +277,7 @@ LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48ead
                     "
 # WHENCE checksum is defined separately to ease overriding it if
 # class-devupstream is selected.
-WHENCE_CHKSUM  = "de47d58e10797eae2ccc753ab8d69bd7"
+WHENCE_CHKSUM  = "fe7960bbe2eb0922168c3434c8d125d0"
 
 # These are not common licenses, set NO_GENERIC_LICENSE for them
 # so that the license files will be copied from fetched source
@@ -416,7 +416,7 @@ SRC_URI:class-devupstream = "git://git.kernel.org/pub/scm/linux/kernel/git/firmw
 # Pin this to the 20220509 release, override this in local.conf
 SRCREV:class-devupstream ?= "b19cbdca78ab2adfd210c91be15a22568e8b8cae"
 
-SRC_URI[sha256sum] = "ac17c34fe73756926a961fbafadf8d8f07a3bd2dd2f4ea31a0fb5d50c714a49a"
+SRC_URI[sha256sum] = "f3937ca282ba256242e2b6dbe523df8a80007d29ffd61f56d270190865492ea8"
 
 inherit allarch
 
@@ -693,11 +693,12 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-qcom-adreno-g800 ${PN}-qcom-adreno-g801 ${PN}-qcom-adreno-g802 \
              ${PN}-qcom-apq8016-modem ${PN}-qcom-apq8016-wifi \
              ${PN}-qcom-apq8096-adreno ${PN}-qcom-apq8096-audio ${PN}-qcom-apq8096-modem \
-             ${PN}-qcom-eliza-adreno \
+             ${PN}-qcom-eliza-adreno ${PN}-qcom-eliza-compute \
              ${PN}-qcom-glymur-adreno ${PN}-qcom-glymur-audio ${PN}-qcom-glymur-compute \
              ${PN}-qcom-hawi-audio \
              ${PN}-qcom-kaanapali-adreno ${PN}-qcom-kaanapali-audio \
              ${PN}-qcom-kaanapali-compute ${PN}-qcom-kaanapali-soccp \
+             ${PN}-qcom-nord-audio ${PN}-qcom-nord-compute ${PN}-qcom-nord-qupv3fw \
              ${PN}-qcom-qcm2290-adreno ${PN}-qcom-qcm2290-audio ${PN}-qcom-qcm2290-modem \
              ${PN}-qcom-qcm6490-adreno ${PN}-qcom-qcm6490-audio ${PN}-qcom-qcm6490-compute \
              ${PN}-qcom-qcm6490-ipa ${PN}-qcom-qcm6490-wifi ${PN}-qcom-qcm6490-qupv3fw \
@@ -717,8 +718,9 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-qcom-sc8280xp-lenovo-x13s-compute \
              ${PN}-qcom-sc8280xp-lenovo-x13s-sensors \
              ${PN}-qcom-sc8280xp-lenovo-x13s-vpu \
+             ${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio \
              ${PN}-qcom-sdm845-adreno ${PN}-qcom-sdm845-audio ${PN}-qcom-sdm845-compute \
-             ${PN}-qcom-sdm845-thundercomm-db845c-sensors \
+             ${PN}-qcom-sdm845-shift6mq-adreno ${PN}-qcom-sdm845-thundercomm-db845c-sensors \
              ${PN}-qcom-sdx35-foxconn-firehose ${PN}-qcom-sdx61-foxconn-firehose \
              ${PN}-qcom-shikra-adreno ${PN}-qcom-shikra-compute ${PN}-qcom-shikra-audio \
              ${PN}-qcom-shikra-modem ${PN}-qcom-shikra-qupv3fw \
@@ -1039,8 +1041,11 @@ FILES:${PN}-qca-qca6698 = " \
   ${firmwaredir}/qca/QCA6698/hpnv21.bin* \
 "
 FILES:${PN}-qca-qcc2072 = " \
+  ${firmwaredir}/qca/ornbcscal10.bin* \
   ${firmwaredir}/qca/ornbcscal11.bin* \
+  ${firmwaredir}/qca/ornbtfw10.tlv* \
   ${firmwaredir}/qca/ornbtfw11.tlv* \
+  ${firmwaredir}/qca/ornnv10.bin* \
   ${firmwaredir}/qca/ornnv11.bin* \
 "
 FILES:${PN}-qca-wcn3950 = " \
@@ -1082,6 +1087,8 @@ FILES:${PN}-qca-wcn7850 = " \
   ${firmwaredir}/qca/hmtbtfw20.tlv* \
   ${firmwaredir}/qca/hmtnv20.b10f* \
   ${firmwaredir}/qca/hmtnv20.b112* \
+  ${firmwaredir}/qca/hmtnv20.b201* \
+  ${firmwaredir}/qca/hmtnv20.b202* \
   ${firmwaredir}/qca/hmtnv20.bin* \
 "
 ALLOW_EMPTY:${PN}-qca = "1"
@@ -1833,6 +1840,7 @@ FILES:${PN}-ti-tas257x = "\
     ${firmwaredir}/tas2572-2-1amp-reg.bin* \
     ${firmwaredir}/tas2572-3amp-reg.bin* \
     ${firmwaredir}/tas2572-3-1amp-reg.bin* \
+    ${firmwaredir}/tas2573-2amp-reg.bin* \
     ${firmwaredir}/ti/audio/tas257x/* \
 "
 RDEPENDS:${PN}-ti-tas257x = "${PN}-ti-tspa-license"
@@ -2120,7 +2128,9 @@ FILES:${PN}-cirrus = " \
     ${firmwaredir}/cirrus/* \
 "
 FILES:${PN}-cirrus-cs42l45 = " \
+    ${firmwaredir}/sdca/1fa/cs42l45_primer*.bin* \
     ${firmwaredir}/sdca/1fa/1028/* \
+    ${firmwaredir}/sdca/1fa/144d/* \
     ${firmwaredir}/sdca/1fa/17aa/* \
 "
 FILES:${PN}-cirrus-license = "${firmwaredir}/LICENSE.cirrus"
@@ -2384,6 +2394,7 @@ LICENSE:${PN}-qcom-apq8096-audio = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8096-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8096-modem = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-eliza-adreno = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-eliza-compute = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-glymur-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-glymur-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
 LICENSE:${PN}-qcom-glymur-compute = "LicenseRef-Firmware-qcom-2"
@@ -2392,6 +2403,9 @@ LICENSE:${PN}-qcom-kaanapali-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-kaanapali-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
 LICENSE:${PN}-qcom-kaanapali-compute = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-kaanapali-soccp = "LicenseRef-Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-audio = "LicenseRef-Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-compute = "LicenseRef-Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-qupv3fw = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-qcm2290-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-qcm2290-audio = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-qcm2290-modem = "LicenseRef-Firmware-qcom"
@@ -2429,10 +2443,12 @@ LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-compute = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-sensors = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sc8280xp-lenovo-x13s-vpu = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-audio = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-compute = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-modem = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-shift6mq-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdx35-foxconn-firehose = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdx61-foxconn-firehose = "LicenseRef-Firmware-qcom"
@@ -2523,6 +2539,7 @@ FILES:${PN}-qcom-apq8096-adreno = "${firmwaredir}/qcom/apq8096/a530_zap.mbn* ${f
 FILES:${PN}-qcom-apq8096-audio = "${firmwaredir}/qcom/apq8096/adsp*.*"
 FILES:${PN}-qcom-apq8096-modem = "${firmwaredir}/qcom/apq8096/mba.mbn* ${firmwaredir}/qcom/apq8096/modem*.* ${firmwaredir}/qcom/apq8096/wlanmdsp.mbn*"
 FILES:${PN}-qcom-eliza-adreno = "${firmwaredir}/qcom/eliza/gen71700_zap.mbn*"
+FILES:${PN}-qcom-eliza-compute = "${firmwaredir}/qcom/eliza/cdsp*.*"
 FILES:${PN}-qcom-glymur-adreno = "${firmwaredir}/qcom/glymur/gen80100_zap.mbn*"
 FILES:${PN}-qcom-glymur-audio = " \
     ${firmwaredir}/qcom/glymur/adsp*.* \
@@ -2537,6 +2554,9 @@ FILES:${PN}-qcom-kaanapali-audio = " \
 "
 FILES:${PN}-qcom-kaanapali-compute = "${firmwaredir}/qcom/kaanapali/cdsp*.*"
 FILES:${PN}-qcom-kaanapali-soccp = "${firmwaredir}/qcom/kaanapali/soccp*.*"
+FILES:${PN}-qcom-nord-audio = "${firmwaredir}/qcom/nord/adsp*.*"
+FILES:${PN}-qcom-nord-compute = "${firmwaredir}/qcom/nord/cdsp*.*"
+FILES:${PN}-qcom-nord-qupv3fw = "${firmwaredir}/qcom/nord/qupv3fw.elf*"
 FILES:${PN}-qcom-qcm2290-adreno = "${firmwaredir}/qcom/qcm2290/a702_zap.mbn*"
 FILES:${PN}-qcom-qcm2290-audio = "${firmwaredir}/qcom/qcm2290/adsp*.*"
 FILES:${PN}-qcom-qcm2290-modem = "${firmwaredir}/qcom/qcm2290/modem*.*"
@@ -2599,11 +2619,13 @@ FILES:${PN}-qcom-sc8280xp-lenovo-x13s-adreno = "${firmwaredir}/qcom/sc8280xp/LEN
 FILES:${PN}-qcom-sc8280xp-lenovo-x13s-compute = "${firmwaredir}/qcom/sc8280xp/LENOVO/21BX/*cdsp*.*"
 FILES:${PN}-qcom-sc8280xp-lenovo-x13s-sensors = "${firmwaredir}/qcom/sc8280xp/LENOVO/21BX/*slpi*.*"
 FILES:${PN}-qcom-sc8280xp-lenovo-x13s-vpu = "${firmwaredir}/qcom/sc8280xp/LENOVO/21BX/qcvss8280.mbn*"
+FILES:${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio = "${firmwaredir}/qcom/sc8280xp/radxa/dragon-q8b/qcadsp8280.mbn*"
 FILES:${PN}-qcom-sdm845-adreno = "${firmwaredir}/qcom/sdm845/a630*.*"
 FILES:${PN}-qcom-sdm845-audio = "${firmwaredir}/qcom/sdm845/adsp*.*"
 FILES:${PN}-qcom-sdm845-compute = "${firmwaredir}/qcom/sdm845/cdsp*.*"
 FILES:${PN}-qcom-sdm845-modem = "${firmwaredir}/qcom/sdm845/mba.mbn* ${firmwaredir}/qcom/sdm845/modem*.* ${firmwaredir}/qcom/sdm845/wlanmdsp.mbn* ${firmwaredir}/qcom/sdm845/notice.txt_wlanmdsp* \
                                  ${firmwaredir}/ath10k/WCN3990/hw1.0/wlanmdsp.mbn* ${firmwaredir}/ath10k/WCN3990/hw1.0/notice.txt_wlanmdsp"
+FILES:${PN}-qcom-sdm845-shift6mq-adreno = "${firmwaredir}/qcom/sdm845/SHIFT/axolotl/a630_zap.mbn*"
 FILES:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "${firmwaredir}/qcom/sdm845/Thundercomm/db845c/slpi*.*"
 FILES:${PN}-qcom-sdx35-foxconn-firehose = "${firmwaredir}/qcom/sdx35/foxconn/xbl_s_devprg_ns.melf*"
 FILES:${PN}-qcom-sdx61-foxconn-firehose = "${firmwaredir}/qcom/sdx61/foxconn/prog_firehose_lite.elf*"
@@ -2721,6 +2743,7 @@ RDEPENDS:${PN}-qcom-apq8096-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8096-audio = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8096-modem = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-eliza-adreno = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-eliza-compute = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-glymur-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-glymur-audio = "${PN}-qcom-2-license ${PN}-linaro-license"
 RDEPENDS:${PN}-qcom-glymur-compute = "${PN}-qcom-2-license"
@@ -2729,6 +2752,9 @@ RDEPENDS:${PN}-qcom-kaanapali-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-kaanapali-audio = "${PN}-qcom-2-license ${PN}-linaro-license"
 RDEPENDS:${PN}-qcom-kaanapali-compute = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-kaanapali-soccp = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-nord-audio = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-nord-compute = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-nord-qupv3fw = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-qcm2290-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-qcm2290-audio = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-qcm2290-modem = "${PN}-qcom-license"
@@ -2772,10 +2798,12 @@ RDEPENDS:${PN}-qcom-sc8280xp-lenovo-x13s-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sc8280xp-lenovo-x13s-compute = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sc8280xp-lenovo-x13s-sensors = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sc8280xp-lenovo-x13s-vpu = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-audio = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-compute = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-modem = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-sdm845-shift6mq-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdx35-foxconn-firehose = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdx61-foxconn-firehose = "${PN}-qcom-license"
-- 
2.55.0


