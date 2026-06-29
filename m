Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EF0C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 08:31:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33253.1782721895979383320
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Jun 2026 01:31:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=KlbRsR1V;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=B3s3IZFw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6sNWe2143179
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 08:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=A3QLQerFjWE+7HKSyPuWH+FTPwaIadLPOxE
	JDS6Wht4=; b=KlbRsR1VC6IuvxeqmwdPVZpXDFTcqvFWa6lTiZTIy5KPOTOpON8
	eKow2e/cik61L5EZZR7vN5qhPA1dpRCAAeds2pwizqgCOoWDbvNWjskrgZdmDj/K
	qLJy54RRHFGyyEXxrpIbAXdNMGbxX3ngFQsbiqEf//qNEAimRVvBZ6wUMs/zaLn2
	RvKCzKNxhuukMfmLEHNmWNKNcpzvDX9iAP39SXtPrxXuPehb5UIrkt6En57+PQwN
	iGABi7zwLGXv4hvJaStc1dEwXgo4NiLa3h7Y4Tg+I5yHT0xXB8FhgOZoj3hZN5TU
	YwbJ7/3sCz6pJxx07kkE+VEzZu6IGQoBiyA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8njfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 08:31:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e55f0613cso66095385a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 01:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782721892; x=1783326692; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A3QLQerFjWE+7HKSyPuWH+FTPwaIadLPOxEJDS6Wht4=;
        b=B3s3IZFwE1OlG/GmHVHQROf1XqHDR4Zyss1OR3/6yphCCBPxXhALcR/V+PFe2aqTrq
         h4jXA9CTQUBS4HrBi7AnKW+4z3e0SpFdZ+e2t6Z5iHczECGt3iwdETNf3913BnLU4AnF
         eSVMq6rz0Gn2H24qy+URSkAgUhTQSO2DcO/llJifLZRLymcejPEvQwSU8GPW46u4aFT4
         sFtABaqTI4WRoutvd7aZaIdjS54WXEKLVZsjXycQA9eknirP56tNBx6beIPskn+ViXAa
         gf+Pbs/h0VNuGnuYQOV+Y6byX7e9ekYkA4CHUL+k1+cdRr71mllLUnu+xjePcnSgpNDm
         yvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782721892; x=1783326692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3QLQerFjWE+7HKSyPuWH+FTPwaIadLPOxEJDS6Wht4=;
        b=tTVATbseTUp+UmWpZSpoqDMQjOMec9wyqc6Aecs3D5uXuaxFu2YgaKc4/zZMzvR1Oh
         4/TWx7lrwamaB6ntnDyV1+RyDsUmJ9bOgVhhvqRi8jb66743NrFDh64aDchdO6EKfyz1
         ORdKE3W0cY03GeszXdc2dZ8h3dww02a6VfwrMrxT+/DykBmzNyxdKYtiOGukiHmOrBjS
         4apY3TIUWsUg+KO6D29Fy6DrV0jxnXXqcAhiR+niilAmLwpxRqZRuaNY6cOheShv+X8r
         /MSteKyg9t77AsaFGX+mKcrOsybAD+3U29tEYb8jU30BQ2Jy3Gh2bd1/rrOnaWnEV9cu
         puEw==
X-Gm-Message-State: AOJu0YxeOTXq3vxdP2pyp8iNIDvCd+tRyeBAwaMiBbEQjZSd2rGQMUW0
	vkvZi8S4R8JPZU7oR+Y6aOUyairj/2sZEbxyHhKhlDsPW7RSvC56YS612IZjE3mGAQKgMqX6qvc
	ROmQk7g0pQbbnwhqTWQkaWNzd96xtDPUukf3Gt6SJoUX3q5im0szK0jfKozVeP86gQxVhwn1lj4
	6pK3LM0gaRcg==
X-Gm-Gg: AfdE7cmBenIUW8e3Vvuf5eWTr6lXb/wCWeiaSmnDIAp7eozTeFSn8UbLycQFEgcrmRD
	yqwAuUuyXLQi80PXGLAdDgF+FvlJ7SFUjVo35ITkiq9c1nXAkpe8hbJLPhMPPNGE00iJ7jSMUP0
	OgD2mgHgR0yZowmrZfwqU3FCVd9kr05j9c/5Mh9CXYvGszCo1eCEIqSrzFqfhNkReWV34m9mYOA
	nSLPvc+6c5X0X6i0N2zCtkknmn+EotNwOOnWq4N9EqBgpZiDxI2xrci1ZhYbsqnRpfuYwf91a9c
	/b5HNM5/Mo19jB34GZho/wHMfjv9pAL1F9qtLHgZqasuIXe7r2KMUtfblWy1raHeyQz+l9+9jGv
	r3k/oUezqjmWsRpgitqRtvpM3RA==
X-Received: by 2002:a05:620a:45aa:b0:92e:4e45:dea2 with SMTP id af79cd13be357-92e4e45e500mr407555585a.6.1782721891812;
        Mon, 29 Jun 2026 01:31:31 -0700 (PDT)
X-Received: by 2002:a05:620a:45aa:b0:92e:4e45:dea2 with SMTP id af79cd13be357-92e4e45e500mr407549285a.6.1782721890811;
        Mon, 29 Jun 2026 01:31:30 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4927038578bsm237657275e9.4.2026.06.29.01.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:31:30 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Vivek Puar <vpuar@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        Ross Burton <ross.burton@arm.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH] linux-firmware: upgrade 20260519 -> 20260622
Date: Mon, 29 Jun 2026 09:31:23 +0100
Message-ID: <20260629083124.1800-1-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfX1ENdVJ3Y0+ej
 uRctS3KSakLqWr2bXDNVafy8j/LVGD/FzcfX6YH8FRFpaup+h2pRThH0YX6ztRT8JCYwR3QoGKj
 flknRmVQNeT0Ue+W6a5P/cNqVbAYLWg=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a422d66 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=7CQSdrXTAAAA:8 a=ag1SF4gXAAAA:8
 a=VwQbUJbxAAAA:8 a=GUfcH2x15s3fsK8gnFAA:9 a=IoWCM6iH3mJn3m4BftBB:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: LEvIBes3jvVNWO9TSn2NfHp8aAnVCR3G
X-Proofpoint-ORIG-GUID: LEvIBes3jvVNWO9TSn2NfHp8aAnVCR3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA2NyBTYWx0ZWRfXwABrxQozdkfX
 IrW5Rj9V4hfjDKa9Cq9t1XU9UEz6ht0WXrr6WcURA9n7Bzsy39hT02hrwp+N1y9F/olSSddgY//
 i3S3/6Sxm/BsyUDjZ7KHuIV2zrBNAqgHgOuhrJ2kq1tHmy8PrIeqZ8aCyRwUvMDH21uSHHaYUJD
 DawH4TsQdUed3UbpajGp64+qWWUc3JMjQSKxVDvZceZ2CClPUUW/anpvEB0Omv3DT847md/5I05
 Nzrkyp/upj7C4OsGksXq/v1KJdjS6591PhiaoIb5oeVIMtH/+gSqEDbrQW/xrdO3nKaFt2VeoXk
 JGD7xn/CSzy/Z07YZpSXstPjNV0CZBLCK0ascm8x1PXlWQBB/H3XEa+FePnB5W38CpaK505XlTZ
 GY6BbGRRRH0jvvpWChNwS8hJM3l5X0Efbsfc1CrTjRtLHlUJYHXj63CkJSG12xPjI8M+SWplSSv
 RRFL+iP3K/tJ67zEPPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290067
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jun 2026 08:31:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4318

From: Vivek Puar <vpuar@qti.qualcomm.com>

Upgrade the firmware package to latest release. Add RCA firmware for
tas257x, add firmware for NXP IW61x SDIO WiFi device, bluetooth firmware
for NFA725B (QCA2066), add BCS calibration firmware for QCC2072. Add gpu,
audio and modem packages for QCOM shikra board.

Firmware licenses and few that are not at the top level (qca/NOTICE.txt,
qcom/NOTICE.txt, wfx/LICENCE.wf200) are moved to a LICENSES directory as
per the REUSE specification. Update LIC_FILES_CHKSUM, NO_GENERIC_LICENSE
and do_install accordingly. Remove REMOVE_UNLICENSED entries for firmware
files that were deleted upstream.

Signed-off-by: Vivek Puar <vpuar@qti.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 ...20260519.bb => linux-firmware_20260622.bb} | 574 +++++++++---------
 1 file changed, 286 insertions(+), 288 deletions(-)
 rename recipes-kernel/linux-firmware/{linux-firmware_20260519.bb => linux-firmware_20260622.bb} (87%)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb b/recipes-kernel/linux-firmware/linux-firmware_20260622.bb
similarity index 87%
rename from recipes-kernel/linux-firmware/linux-firmware_20260519.bb
rename to recipes-kernel/linux-firmware/linux-firmware_20260622.bb
index f2cd873..c5ad041 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260519.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260622.bb
@@ -7,54 +7,18 @@ SECTION = "kernel"
 
 REMOVE_UNLICENSED = ""
 
-# For acenic - Alteon AceNIC Gigabit Ethernet card
-REMOVE_UNLICENSED += "acenic/tg1.bin acenic/tg2.bin"
-
-# For emi62 - EMI 6|2m USB Audio interface
-REMOVE_UNLICENSED += "emi62/bitstream.fw emi62/loader.fw emi62/midi.fw emi62/spdif.fw"
-
-# For snd-maestro3 - ESS Allegro Maestro3 audio device
-REMOVE_UNLICENSED += "ess/maestro3_assp_kernel.fw ess/maestro3_assp_minisrc.fw"
-
 # For s2255drv
 REMOVE_UNLICENSED += "f2255usb.bin"
 
-# For snd-korg1212 - Korg 1212 IO audio device
-REMOVE_UNLICENSED += "korg/k1212.dsp"
-
-# For lgs8gxx - Legend Silicon GB20600 demodulator driver
-REMOVE_UNLICENSED += "lgs8g75.fw"
-
 # For ti_usb_3410_5052 - Multi-Tech USB cell modems
-REMOVE_UNLICENSED += "mts_cdma.fw mts_gsm.fw mts_edge.fw mts_mt9234mu.fw mts_mt9234zba.fw"
-
-# For myri_sbus - MyriCOM Gigabit Ethernet
-REMOVE_UNLICENSED += "myricom/lanai.bin"
-
-# For qlogicpti - PTI Qlogic, ISP Driver
-REMOVE_UNLICENSED += "qlogic/isp1000.bin"
-
-# For cassini - Sun Cassini
-REMOVE_UNLICENSED += "sun/cassini.bin"
-
-# For dvb-ttusb-budget - Technotrend/Hauppauge Nova-USB devices
-REMOVE_UNLICENSED += "ttusb-budget/dspbootcode.bin"
+REMOVE_UNLICENSED += "mts_cdma.fw mts_gsm.fw mts_edge.fw"
 
 # For ueagle-atm - Driver for USB ADSL Modems based on Eagle I,II,III
 REMOVE_UNLICENSED += "ueagle-atm/930-fpga.bin ueagle-atm/CMVeiWO.bin ueagle-atm/CMVepFR10.bin ueagle-atm/DSP9p.bin ueagle-atm/eagleIII.fw ueagle-atm/adi930.fw ueagle-atm/CMVep.bin ueagle-atm/CMVepFR.bin ueagle-atm/DSPei.bin ueagle-atm/CMV9i.bin ueagle-atm/CMVepES03.bin ueagle-atm/CMVepIT.bin ueagle-atm/DSPep.bin ueagle-atm/CMV9p.bin ueagle-atm/CMVepES.bin ueagle-atm/CMVepWO.bin ueagle-atm/eagleI.fw ueagle-atm/CMVei.bin ueagle-atm/CMVepFR04.bin ueagle-atm/DSP9i.bin ueagle-atm/eagleII.fw"
 
-# For vicam - USB 3com HomeConnect (aka vicam)
-REMOVE_UNLICENSED += "vicam/firmware.fw"
-
-# For yam - YAM driver for AX.25
-REMOVE_UNLICENSED += "yam/1200.bin yam/9600.bin"
-
 # For snd-wavefront - ISA WaveFront sound card
 REMOVE_UNLICENSED += "yamaha/yss225_registers.bin"
 
-# For snd-ymfpci - Yamaha YMF724/740/744/754 audio devices
-REMOVE_UNLICENSED += "yamaha/ds1_ctrl.fw yamaha/ds1_dsp.fw yamaha/ds1e_ctrl.fw"
-
 
 LICENSE = "\
     Firmware-Abilis \
@@ -188,257 +152,257 @@ LICENSE = "\
     & MIT \
 "
 
-LIC_FILES_CHKSUM = "file://LICENCE.Abilis;md5=b5ee3f410780e56711ad48eadc22b8bc \
-                    file://LICENCE.adsp_sst;md5=615c45b91a5a4a9fe046d6ab9a2df728 \
-                    file://LICENCE.advansys;md5=bca735476602a7bcb187c7f8bf4a31d5 \
-                    file://LICENSE.aeonsemi;md5=521c00bae0077c90d6ffb9ccf66905ae \
-                    file://LICENCE.agere;md5=af0133de6b4a9b2522defd5f188afd31 \
-                    file://LICENSE.airoha;md5=fa3dedb960e2673aea51aa509f7b537d \
-                    file://LICENCE.alacritech;md5=75dabc07cc2fb59d929baa6bd6aae48a \
-                    file://LICENSE.amdgpu;md5=1433dfea38c97a2e563a248a863dcb94 \
-                    file://LICENSE.amdisp;md5=f040a36bf52c9643edb7c009d6f1b141 \
-                    file://LICENSE.amdnpu;md5=ea42c0f38f2d42aad08bd50c822460dc \
-                    file://LICENSE.amd_pmf;md5=a2589a05ea5b6bd2b7f4f623c7e7a649 \
-                    file://LICENSE.amd-sev;md5=e750538791a8be0b7249c579edefb035 \
-                    file://LICENSE.amd-ucode;md5=450f217aadc787514165e9568652d700 \
-                    file://LICENSE.amlogic;md5=80e4e3f27def8bc4b232009c3a587c07 \
-                    file://LICENSE.amlogic_vdec;md5=dc44f59bf64a81643e500ad3f39a468a \
-                    file://LICENSE.amphion_vpu;md5=2bcdc00527b2d0542bd92b52aaec2b60 \
-                    file://LICENCE.atheros_firmware;md5=30a14c7823beedac9fa39c64fdd01a13 \
-                    file://LICENSE.atmel;md5=aa74ac0c60595dee4d4e239107ea77a3 \
-                    file://LICENSE.bfa;md5=ff822aa5edf56d0159acfe5a49a5be2c \
-                    file://LICENSE.bmi260;md5=0008c039ec4281e382bd0cb41b66866c \
-                    file://LICENCE.bnx2;md5=d156fb810e162c4b0065ec8316efcd38 \
-                    file://LICENCE.bnx2x;md5=9494ec1462e461dec5322d1a1f0adf81 \
-                    file://LICENCE.broadcom_bcm43xx;md5=3160c14df7228891b868060e1951dfbc \
-                    file://LICENCE.ca0132;md5=209b33e66ee5be0461f13d31da392198 \
-                    file://LICENCE.cadence;md5=009f46816f6956cfb75ede13d3e1cee0 \
-                    file://LICENCE.cavium;md5=c37aaffb1ebe5939b2580d073a95daea \
-                    file://LICENCE.chelsio_firmware;md5=819aa8c3fa453f1b258ed8d168a9d903 \
-                    file://LICENSE.cirrus;md5=662ea2c1a8888f7d79ed7f27c27472e1 \
-                    file://LICENCE.cnm;md5=df3992006621b797e36de43f36336e36 \
-                    file://LICENSE.conexant;md5=768b10e3fc2bbc0725174a7d9e164c26 \
-                    file://LICENCE.cw1200;md5=f0f770864e7a8444a5c5aa9d12a3a7ed \
-                    file://LICENCE.cw1200-sdd;md5=7e99e5e15c3668e96504a82ebd532ee4 \
-                    file://LICENCE.cxgb3;md5=1cf82d9e2a4b301e20c7936e61cd0e45 \
-                    file://LICENCE.cypress;md5=48cd9436c763bf873961f9ed7b5c147b \
-                    file://LICENCE.dabusb;md5=fd785fc5f935c950a3423e4b1b996657 \
-                    file://LICENSE.dell;md5=032c317c0483dd3364f478d2bf9d9818 \
-                    file://LICENSE.dib0700;md5=f7411825c8a555a1a3e5eab9ca773431 \
-                    file://LICENSE.drxk;md5=87a325e2e9740837036af3f04efa0d0f \
-                    file://LICENCE.e100;md5=ec0f84136766df159a3ae6d02acdf5a8 \
-                    file://LICENCE.emi26;md5=2d1cd6e732b81824fe2f0fbf595b1413 \
-                    file://LICENCE.ene_firmware;md5=ed67f0f62f8f798130c296720b7d3921 \
-                    file://LICENCE.fw_sst_0f28;md5=6353931c988ad52818ae733ac61cd293 \
-                    file://LICENCE.go7007;md5=c0bb9f6aaaba55b0529ee9b30aa66beb \
-                    file://LICENSE.hfi1_firmware;md5=5e7b6e586ce7339d12689e49931ad444 \
-                    file://LICENCE.HP;md5=3506ce9cd4bedeaa4afb2d8fe24e0688 \
-                    file://LICENSE.i915;md5=2b0b2e0d20984affd4490ba2cba02570 \
-                    file://LICENSE.ib_qib;md5=b909c90fca84c507766601ecb6f3b9d9 \
-                    file://LICENCE.ibt_firmware;md5=fdbee1ddfe0fb7ab0b2fcd6b454a366b \
-                    file://LICENSE.ice;md5=742ab4850f2670792940e6d15c974b2f \
-                    file://LICENSE.ice_enhanced;md5=f305cfc31b64f95f774f9edd9df0224d \
-                    file://LICENCE.inside-secure;md5=71f2eb7c1d10ccbd198e2459adef6afa \
-                    file://LICENCE.IntcSST2;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
-                    file://LICENSE.intel;md5=5c22a4ab607349c89ffcbb1595e493f8 \
-                    file://LICENSE.intel_vpu;md5=1e231b7287d5a5018740041c352eb58e \
-                    file://LICENSE.ipu3_firmware;md5=38fe8238c06bf7dcfd0eedbebf452c3b \
-                    file://LICENCE.it913x;md5=1fbf727bfb6a949810c4dbfa7e6ce4f8 \
-                    file://LICENSE.ivsc;md5=4f1f696a12c18dd058d3cc51006c640d \
-                    file://LICENCE.iwlwifi_firmware;md5=2ce6786e0fc11ac6e36b54bb9b799f1b \
-                    file://LICENSE.ixp4xx;md5=ddc5cd6cbc6745343926fe7ecc2cdeb2 \
-                    file://LICENCE.kaweth;md5=b1d876e562f4b3b8d391ad8395dfe03f \
-                    file://LICENCE.keyspan;md5=676af26017c45772c972ce4a75d467d9 \
-                    file://LICENCE.lenovo;md5=7f25420b5c27211f7bf33bebb3042ce4 \
-                    file://LICENCE.linaro;md5=936d91e71cf9cd30e733db4bf11661cc \
-                    file://LICENSE.Lontium;md5=4ec8dc582ff7295f39e2ca6a7b0be2b6 \
-                    file://LICENCE.mali_csffw;md5=e064aaec4d21ef856e1b76a6f5dc435f \
-                    file://LICENCE.Marvell;md5=28b6ed8bd04ba105af6e4dcd6e997772 \
-                    file://LICENCE.mediatek;md5=7c1976b63217d76ce47d0a11d8a79cf2 \
-                    file://LICENSE.mellanox;md5=646741eee66a7925edc538650895b80c \
-                    file://LICENSE.mga;md5=6191fc1ff8183b00515c36351ec24150 \
-                    file://LICENCE.microchip;md5=db753b00305675dfbf120e3f24a47277 \
-                    file://LICENSE.montage;md5=12a9f2b351f60fc9374da61c8b2f11ed \
-                    file://LICENCE.moxa;md5=1086614767d8ccf744a923289d3d4261 \
-                    file://LICENCE.myri10ge_firmware;md5=42e32fb89f6b959ca222e25ac8df8fed \
-                    file://LICENCE.Netronome;md5=4add08f2577086d44447996503cddf5f \
-                    file://LICENCE.nvidia;md5=4428a922ed3ba2ceec95f076a488ce07 \
-                    file://LICENCE.NXP;md5=58bb8ba632cd729b9ba6183bc6aed36f \
-                    file://LICENSE.nxp;md5=cca321ca1524d6a1e4fed87486cd82dc \
-                    file://LICENSE.nxp_mc_firmware;md5=9dc97e4b279b3858cae8879ae2fe5dd7 \
-                    file://LICENCE.OLPC;md5=5b917f9d8c061991be4f6f5f108719cd \
-                    file://LICENCE.open-ath9k-htc-firmware;md5=1b33c9f4d17bc4d457bdb23727046837 \
-                    file://LICENCE.phanfw;md5=954dcec0e051f9409812b561ea743bfa \
-                    file://LICENSE.powervr;md5=83045ed2a2cda15b4eaff682c98c9533 \
-                    file://LICENCE.qat_firmware;md5=72de83dfd9b87be7685ed099a39fbea4 \
-                    file://LICENSE.qcom;md5=164e3362a538eb11d3ac51e8e134294b \
-                    file://LICENSE.qcom-2;md5=165287851294f2fb8ac8cbc5e24b02b0 \
-                    file://LICENSE.qcom_yamato;md5=d0de0eeccaf1843a850bf7a6777eec5c \
-                    file://LICENSE.qed;md5=939ee0945e6efa0ce21f6d8a21c6564c \
-                    file://LICENCE.qla1280;md5=d6895732e622d950609093223a2c4f5d \
-                    file://LICENCE.qla2xxx;md5=505855e921b75f1be4a437ad9b79dff0 \
-                    file://LICENSE.QualcommAtheros_ar3k;md5=b5fe244fb2b532311de1472a3bc06da5 \
-                    file://LICENSE.QualcommAtheros_ath10k;md5=cb42b686ee5f5cb890275e4321db60a8 \
-                    file://LICENSE.r8169;md5=a9909160e6bd81b8770711918b418ef2 \
-                    file://LICENCE.r8a779x_usb3;md5=4c1671656153025d7076105a5da7e498 \
-                    file://LICENSE.radeon;md5=68ec28bacb3613200bca44f404c69b16 \
-                    file://LICENCE.ralink_a_mediatek_company_firmware;md5=728f1a85fd53fd67fa8d7afb080bc435 \
-                    file://LICENCE.ralink-firmware.txt;md5=ab2c269277c45476fb449673911a2dfd \
-                    file://LICENCE.rockchip;md5=5fd70190c5ed39734baceada8ecced26 \
-                    file://LICENCE.r8a779g_pcie_phy;md5=0b20e76a9a004b83c4a1c87e2153bbad \
-                    file://LICENSE.rp2;md5=de5109226a643a1cdf706a633e993514 \
-                    file://LICENSE.rsi;md5=a560f4b285f0733de1a3986ae847675d \
-                    file://LICENSE.rt1320;md5=b44dab4314655e8f015009548dc4f962 \
-                    file://LICENCE.rtlwifi_firmware.txt;md5=00d06cfd3eddd5a2698948ead2ad54a5 \
-                    file://LICENSE.s5p-mfc;md5=5bdad20069b5c0268245609045374639 \
-                    file://LICENSE.sdma_firmware;md5=51e8c19ecc2270f4b8ea30341ad63ce9 \
-                    file://LICENCE.sensoray;md5=2273a7fed8223f6d3ef3e65f508f22eb \
-                    file://LICENCE.siano;md5=4556c1bf830067f12ca151ad953ec2a5 \
-                    file://LICENSE.tehuti;md5=2b0ebf8cdc4a1c4a49b8ad18c7cb2492 \
-                    file://LICENCE.ti-connectivity;md5=3b1e9cf54aba8146dad4b735777d406f \
-                    file://LICENCE.ti-keystone;md5=3a86335d32864b0bef996bee26cc0f2c \
-                    file://LICENCE.ti-tspa;md5=d1a0eb27d0020752040190b9d51ad9be \
-                    file://LICENCE.tigon;md5=49d104a32337f4a4c89478a86ce9ae4f \
-                    file://LICENSE.tlg2300;md5=4b23ec9ced919a0bf2f7c56dac31b2b7 \
-                    file://LICENCE.typhoon;md5=43b30243a6bda91f54c8e00600c4add5 \
-                    file://LICENCE.ueagle-atm4-firmware;md5=4ed7ea6b507ccc583b9d594417714118 \
-                    file://LICENCE.via_vt6656;md5=e4159694cba42d4377a912e78a6e850f \
-                    file://LICENSE.vxge;md5=91e196370d9927bdf7f566e47ea2c558 \
-                    file://LICENCE.wl1251;md5=ad3f81922bb9e197014bb187289d3b5b \
-                    file://LICENCE.xc4000;md5=0ff51d2dc49fce04814c9155081092f0 \
-                    file://LICENCE.xc5000;md5=1e170c13175323c32c7f4d0998d53f66 \
-                    file://LICENCE.xc5000c;md5=12b02efa3049db65d524aeb418dd87ca \
-                    file://LICENSE.xe;md5=c674d38774242bc0c528214721488118 \
-                    file://wfx/LICENCE.wf200;md5=4d1beff00d902c05c9c7e95a5d8eb52d \
+LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48eadc22b8bc \
+                    file://LICENSES/LICENCE.adsp_sst;md5=615c45b91a5a4a9fe046d6ab9a2df728 \
+                    file://LICENSES/LICENCE.advansys;md5=bca735476602a7bcb187c7f8bf4a31d5 \
+                    file://LICENSES/LICENSE.aeonsemi;md5=521c00bae0077c90d6ffb9ccf66905ae \
+                    file://LICENSES/LICENCE.agere;md5=af0133de6b4a9b2522defd5f188afd31 \
+                    file://LICENSES/LICENSE.airoha;md5=fa3dedb960e2673aea51aa509f7b537d \
+                    file://LICENSES/LICENCE.alacritech;md5=75dabc07cc2fb59d929baa6bd6aae48a \
+                    file://LICENSES/LICENSE.amdgpu;md5=1433dfea38c97a2e563a248a863dcb94 \
+                    file://LICENSES/LICENSE.amdisp;md5=f040a36bf52c9643edb7c009d6f1b141 \
+                    file://LICENSES/LICENSE.amdnpu;md5=ea42c0f38f2d42aad08bd50c822460dc \
+                    file://LICENSES/LICENSE.amd_pmf;md5=a2589a05ea5b6bd2b7f4f623c7e7a649 \
+                    file://LICENSES/LICENSE.amd-sev;md5=e750538791a8be0b7249c579edefb035 \
+                    file://LICENSES/LICENSE.amd-ucode;md5=450f217aadc787514165e9568652d700 \
+                    file://LICENSES/LICENSE.amlogic;md5=80e4e3f27def8bc4b232009c3a587c07 \
+                    file://LICENSES/LICENSE.amlogic_vdec;md5=dc44f59bf64a81643e500ad3f39a468a \
+                    file://LICENSES/LICENSE.amphion_vpu;md5=2bcdc00527b2d0542bd92b52aaec2b60 \
+                    file://LICENSES/LICENCE.atheros_firmware;md5=30a14c7823beedac9fa39c64fdd01a13 \
+                    file://LICENSES/LICENSE.atmel;md5=aa74ac0c60595dee4d4e239107ea77a3 \
+                    file://LICENSES/LICENSE.bfa;md5=ff822aa5edf56d0159acfe5a49a5be2c \
+                    file://LICENSES/LICENSE.bmi260;md5=0008c039ec4281e382bd0cb41b66866c \
+                    file://LICENSES/LICENCE.bnx2;md5=d156fb810e162c4b0065ec8316efcd38 \
+                    file://LICENSES/LICENCE.bnx2x;md5=9494ec1462e461dec5322d1a1f0adf81 \
+                    file://LICENSES/LICENCE.broadcom_bcm43xx;md5=3160c14df7228891b868060e1951dfbc \
+                    file://LICENSES/LICENCE.ca0132;md5=209b33e66ee5be0461f13d31da392198 \
+                    file://LICENSES/LICENCE.cadence;md5=009f46816f6956cfb75ede13d3e1cee0 \
+                    file://LICENSES/LICENCE.cavium;md5=c37aaffb1ebe5939b2580d073a95daea \
+                    file://LICENSES/LICENCE.chelsio_firmware;md5=819aa8c3fa453f1b258ed8d168a9d903 \
+                    file://LICENSES/LICENSE.cirrus;md5=662ea2c1a8888f7d79ed7f27c27472e1 \
+                    file://LICENSES/LICENCE.cnm;md5=df3992006621b797e36de43f36336e36 \
+                    file://LICENSES/LICENSE.conexant;md5=768b10e3fc2bbc0725174a7d9e164c26 \
+                    file://LICENSES/LICENCE.cw1200;md5=f0f770864e7a8444a5c5aa9d12a3a7ed \
+                    file://LICENSES/LICENCE.cw1200-sdd;md5=7e99e5e15c3668e96504a82ebd532ee4 \
+                    file://LICENSES/LICENCE.cxgb3;md5=1cf82d9e2a4b301e20c7936e61cd0e45 \
+                    file://LICENSES/LICENCE.cypress;md5=48cd9436c763bf873961f9ed7b5c147b \
+                    file://LICENSES/LICENCE.dabusb;md5=fd785fc5f935c950a3423e4b1b996657 \
+                    file://LICENSES/LICENSE.dell;md5=032c317c0483dd3364f478d2bf9d9818 \
+                    file://LICENSES/LICENSE.dib0700;md5=f7411825c8a555a1a3e5eab9ca773431 \
+                    file://LICENSES/LICENSE.drxk;md5=87a325e2e9740837036af3f04efa0d0f \
+                    file://LICENSES/LICENCE.e100;md5=ec0f84136766df159a3ae6d02acdf5a8 \
+                    file://LICENSES/LICENCE.emi26;md5=2d1cd6e732b81824fe2f0fbf595b1413 \
+                    file://LICENSES/LICENCE.ene_firmware;md5=ed67f0f62f8f798130c296720b7d3921 \
+                    file://LICENSES/LICENCE.fw_sst_0f28;md5=6353931c988ad52818ae733ac61cd293 \
+                    file://LICENSES/LICENCE.go7007;md5=c0bb9f6aaaba55b0529ee9b30aa66beb \
+                    file://LICENSES/LICENSE.hfi1_firmware;md5=5e7b6e586ce7339d12689e49931ad444 \
+                    file://LICENSES/LICENCE.HP;md5=3506ce9cd4bedeaa4afb2d8fe24e0688 \
+                    file://LICENSES/LICENSE.i915;md5=2b0b2e0d20984affd4490ba2cba02570 \
+                    file://LICENSES/LICENSE.ib_qib;md5=b909c90fca84c507766601ecb6f3b9d9 \
+                    file://LICENSES/LICENCE.ibt_firmware;md5=fdbee1ddfe0fb7ab0b2fcd6b454a366b \
+                    file://LICENSES/LICENSE.ice;md5=742ab4850f2670792940e6d15c974b2f \
+                    file://LICENSES/LICENSE.ice_enhanced;md5=f305cfc31b64f95f774f9edd9df0224d \
+                    file://LICENSES/LICENCE.inside-secure;md5=71f2eb7c1d10ccbd198e2459adef6afa \
+                    file://LICENSES/LICENCE.IntcSST2;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
+                    file://LICENSES/LICENSE.intel;md5=5c22a4ab607349c89ffcbb1595e493f8 \
+                    file://LICENSES/LICENSE.intel_vpu;md5=1e231b7287d5a5018740041c352eb58e \
+                    file://LICENSES/LICENSE.ipu3_firmware;md5=38fe8238c06bf7dcfd0eedbebf452c3b \
+                    file://LICENSES/LICENCE.it913x;md5=1fbf727bfb6a949810c4dbfa7e6ce4f8 \
+                    file://LICENSES/LICENSE.ivsc;md5=4f1f696a12c18dd058d3cc51006c640d \
+                    file://LICENSES/LICENCE.iwlwifi_firmware;md5=2ce6786e0fc11ac6e36b54bb9b799f1b \
+                    file://LICENSES/LICENSE.ixp4xx;md5=ddc5cd6cbc6745343926fe7ecc2cdeb2 \
+                    file://LICENSES/LICENCE.kaweth;md5=b1d876e562f4b3b8d391ad8395dfe03f \
+                    file://LICENSES/LICENCE.keyspan;md5=676af26017c45772c972ce4a75d467d9 \
+                    file://LICENSES/LICENCE.lenovo;md5=7f25420b5c27211f7bf33bebb3042ce4 \
+                    file://LICENSES/LICENCE.linaro;md5=936d91e71cf9cd30e733db4bf11661cc \
+                    file://LICENSES/LICENSE.Lontium;md5=4ec8dc582ff7295f39e2ca6a7b0be2b6 \
+                    file://LICENSES/LICENCE.mali_csffw;md5=e064aaec4d21ef856e1b76a6f5dc435f \
+                    file://LICENSES/LICENCE.Marvell;md5=28b6ed8bd04ba105af6e4dcd6e997772 \
+                    file://LICENSES/LICENCE.mediatek;md5=7c1976b63217d76ce47d0a11d8a79cf2 \
+                    file://LICENSES/LICENSE.mellanox;md5=646741eee66a7925edc538650895b80c \
+                    file://LICENSES/LICENSE.mga;md5=6191fc1ff8183b00515c36351ec24150 \
+                    file://LICENSES/LICENCE.microchip;md5=db753b00305675dfbf120e3f24a47277 \
+                    file://LICENSES/LICENSE.montage;md5=12a9f2b351f60fc9374da61c8b2f11ed \
+                    file://LICENSES/LICENCE.moxa;md5=1086614767d8ccf744a923289d3d4261 \
+                    file://LICENSES/LICENCE.myri10ge_firmware;md5=42e32fb89f6b959ca222e25ac8df8fed \
+                    file://LICENSES/LICENCE.Netronome;md5=4add08f2577086d44447996503cddf5f \
+                    file://LICENSES/LICENCE.nvidia;md5=4428a922ed3ba2ceec95f076a488ce07 \
+                    file://LICENSES/LICENCE.NXP;md5=58bb8ba632cd729b9ba6183bc6aed36f \
+                    file://LICENSES/LICENSE.nxp;md5=cca321ca1524d6a1e4fed87486cd82dc \
+                    file://LICENSES/LICENSE.nxp_mc_firmware;md5=9dc97e4b279b3858cae8879ae2fe5dd7 \
+                    file://LICENSES/LICENCE.OLPC;md5=5b917f9d8c061991be4f6f5f108719cd \
+                    file://LICENSES/LICENCE.open-ath9k-htc-firmware;md5=1b33c9f4d17bc4d457bdb23727046837 \
+                    file://LICENSES/LICENCE.phanfw;md5=954dcec0e051f9409812b561ea743bfa \
+                    file://LICENSES/LICENSE.powervr;md5=83045ed2a2cda15b4eaff682c98c9533 \
+                    file://LICENSES/LICENCE.qat_firmware;md5=72de83dfd9b87be7685ed099a39fbea4 \
+                    file://LICENSES/LICENSE.qcom;md5=164e3362a538eb11d3ac51e8e134294b \
+                    file://LICENSES/LICENSE.qcom-2;md5=165287851294f2fb8ac8cbc5e24b02b0 \
+                    file://LICENSES/LICENSE.qcom_yamato;md5=d0de0eeccaf1843a850bf7a6777eec5c \
+                    file://LICENSES/LICENSE.qed;md5=939ee0945e6efa0ce21f6d8a21c6564c \
+                    file://LICENSES/LICENCE.qla1280;md5=d6895732e622d950609093223a2c4f5d \
+                    file://LICENSES/LICENCE.qla2xxx;md5=505855e921b75f1be4a437ad9b79dff0 \
+                    file://LICENSES/LICENSE.QualcommAtheros_ar3k;md5=b5fe244fb2b532311de1472a3bc06da5 \
+                    file://LICENSES/LICENSE.QualcommAtheros_ath10k;md5=cb42b686ee5f5cb890275e4321db60a8 \
+                    file://LICENSES/LICENSE.r8169;md5=a9909160e6bd81b8770711918b418ef2 \
+                    file://LICENSES/LICENCE.r8a779x_usb3;md5=4c1671656153025d7076105a5da7e498 \
+                    file://LICENSES/LICENSE.radeon;md5=68ec28bacb3613200bca44f404c69b16 \
+                    file://LICENSES/LICENCE.ralink_a_mediatek_company_firmware;md5=728f1a85fd53fd67fa8d7afb080bc435 \
+                    file://LICENSES/LICENCE.ralink-firmware.txt;md5=ab2c269277c45476fb449673911a2dfd \
+                    file://LICENSES/LICENCE.rockchip;md5=5fd70190c5ed39734baceada8ecced26 \
+                    file://LICENSES/LICENCE.r8a779g_pcie_phy;md5=0b20e76a9a004b83c4a1c87e2153bbad \
+                    file://LICENSES/LICENSE.rp2;md5=de5109226a643a1cdf706a633e993514 \
+                    file://LICENSES/LICENSE.rsi;md5=a560f4b285f0733de1a3986ae847675d \
+                    file://LICENSES/LICENSE.rt1320;md5=b44dab4314655e8f015009548dc4f962 \
+                    file://LICENSES/LICENCE.rtlwifi_firmware.txt;md5=00d06cfd3eddd5a2698948ead2ad54a5 \
+                    file://LICENSES/LICENSE.s5p-mfc;md5=5bdad20069b5c0268245609045374639 \
+                    file://LICENSES/LICENSE.sdma_firmware;md5=51e8c19ecc2270f4b8ea30341ad63ce9 \
+                    file://LICENSES/LICENCE.sensoray;md5=2273a7fed8223f6d3ef3e65f508f22eb \
+                    file://LICENSES/LICENCE.siano;md5=4556c1bf830067f12ca151ad953ec2a5 \
+                    file://LICENSES/LICENSE.tehuti;md5=2b0ebf8cdc4a1c4a49b8ad18c7cb2492 \
+                    file://LICENSES/LICENCE.ti-connectivity;md5=3b1e9cf54aba8146dad4b735777d406f \
+                    file://LICENSES/LICENCE.ti-keystone;md5=3a86335d32864b0bef996bee26cc0f2c \
+                    file://LICENSES/LICENCE.ti-tspa;md5=d1a0eb27d0020752040190b9d51ad9be \
+                    file://LICENSES/LICENCE.tigon;md5=49d104a32337f4a4c89478a86ce9ae4f \
+                    file://LICENSES/LICENSE.tlg2300;md5=4b23ec9ced919a0bf2f7c56dac31b2b7 \
+                    file://LICENSES/LICENCE.typhoon;md5=43b30243a6bda91f54c8e00600c4add5 \
+                    file://LICENSES/LICENCE.ueagle-atm4-firmware;md5=4ed7ea6b507ccc583b9d594417714118 \
+                    file://LICENSES/LICENCE.via_vt6656;md5=e4159694cba42d4377a912e78a6e850f \
+                    file://LICENSES/LICENSE.vxge;md5=91e196370d9927bdf7f566e47ea2c558 \
+                    file://LICENSES/LICENCE.wl1251;md5=ad3f81922bb9e197014bb187289d3b5b \
+                    file://LICENSES/LICENCE.xc4000;md5=0ff51d2dc49fce04814c9155081092f0 \
+                    file://LICENSES/LICENCE.xc5000;md5=1e170c13175323c32c7f4d0998d53f66 \
+                    file://LICENSES/LICENCE.xc5000c;md5=12b02efa3049db65d524aeb418dd87ca \
+                    file://LICENSES/LICENSE.xe;md5=c674d38774242bc0c528214721488118 \
+                    file://LICENSES/LICENCE.wf200;md5=4d1beff00d902c05c9c7e95a5d8eb52d \
                     file://WHENCE;md5=${WHENCE_CHKSUM} \
                     "
 # WHENCE checksum is defined separately to ease overriding it if
 # class-devupstream is selected.
-WHENCE_CHKSUM  = "6048e3ea8acf04b4c415db8a9e35a912"
+WHENCE_CHKSUM  = "991f6e7ad5cc20508ae8923edc342c8e"
 
 # These are not common licenses, set NO_GENERIC_LICENSE for them
 # so that the license files will be copied from fetched source
-NO_GENERIC_LICENSE[Firmware-Abilis] = "LICENCE.Abilis"
-NO_GENERIC_LICENSE[Firmware-adsp_sst] = "LICENCE.adsp_sst"
-NO_GENERIC_LICENSE[Firmware-advansys] = "LICENCE.advansys"
-NO_GENERIC_LICENSE[Firmware-aeonsemi] = "LICENSE.aeonsemi"
-NO_GENERIC_LICENSE[Firmware-agere] = "LICENCE.agere"
-NO_GENERIC_LICENSE[Firmware-airoha] = "LICENSE.airoha"
-NO_GENERIC_LICENSE[Firmware-alacritech] = "LICENCE.alacritech"
-NO_GENERIC_LICENSE[Firmware-amdgpu] = "LICENSE.amdgpu"
-NO_GENERIC_LICENSE[Firmware-amdisp] = "LICENSE.amdisp"
-NO_GENERIC_LICENSE[Firmware-amdnpu] = "LICENSE.amdnpu"
-NO_GENERIC_LICENSE[Firmware-amd_pmf] = "LICENSE.amd_pmf"
-NO_GENERIC_LICENSE[Firmware-amd-sev] = "LICENSE.amd-sev"
-NO_GENERIC_LICENSE[Firmware-amd-ucode] = "LICENSE.amd-ucode"
-NO_GENERIC_LICENSE[Firmware-amlogic] = "LICENSE.amlogic"
-NO_GENERIC_LICENSE[Firmware-amlogic_vdec] = "LICENSE.amlogic_vdec"
-NO_GENERIC_LICENSE[Firmware-amphion_vpu] = "LICENSE.amphion_vpu"
-NO_GENERIC_LICENSE[Firmware-atheros_firmware] = "LICENCE.atheros_firmware"
-NO_GENERIC_LICENSE[Firmware-atmel] = "LICENSE.atmel"
-NO_GENERIC_LICENSE[Firmware-bfa] = "LICENSE.bfa"
-NO_GENERIC_LICENSE[Firmware-bmi260] = "LICENSE.bmi260"
-NO_GENERIC_LICENSE[Firmware-bnx2] = "LICENCE.bnx2"
-NO_GENERIC_LICENSE[Firmware-bnx2x] = "LICENCE.bnx2x"
-NO_GENERIC_LICENSE[Firmware-broadcom_bcm43xx] = "LICENCE.broadcom_bcm43xx"
-NO_GENERIC_LICENSE[Firmware-ca0132] = "LICENCE.ca0132"
-NO_GENERIC_LICENSE[Firmware-cadence] = "LICENCE.cadence"
-NO_GENERIC_LICENSE[Firmware-cavium] = "LICENCE.cavium"
-NO_GENERIC_LICENSE[Firmware-chelsio_firmware] = "LICENCE.chelsio_firmware"
-NO_GENERIC_LICENSE[Firmware-cirrus] = "LICENSE.cirrus"
-NO_GENERIC_LICENSE[Firmware-cnm] = "LICENCE.cnm"
-NO_GENERIC_LICENSE[Firmware-conexant] = "LICENSE.conexant"
-NO_GENERIC_LICENSE[Firmware-cw1200] = "LICENCE.cw1200"
-NO_GENERIC_LICENSE[Firmware-cw1200-sdd] = "LICENCE.cw1200-sdd"
-NO_GENERIC_LICENSE[Firmware-cxgb3] = "LICENCE.cxgb3"
-NO_GENERIC_LICENSE[Firmware-cypress] = "LICENCE.cypress"
-NO_GENERIC_LICENSE[Firmware-dabusb] = "LICENCE.dabusb"
-NO_GENERIC_LICENSE[Firmware-dell] = "LICENSE.dell"
-NO_GENERIC_LICENSE[Firmware-dib0700] = "LICENSE.dib0700"
-NO_GENERIC_LICENSE[Firmware-drxk] = "LICENSE.drxk"
-NO_GENERIC_LICENSE[Firmware-e100] = "LICENCE.e100"
-NO_GENERIC_LICENSE[Firmware-emi26] = "LICENCE.emi26"
-NO_GENERIC_LICENSE[Firmware-ene_firmware] = "LICENCE.ene_firmware"
-NO_GENERIC_LICENSE[Firmware-fw_sst_0f28] = "LICENCE.fw_sst_0f28"
-NO_GENERIC_LICENSE[Firmware-go7007] = "LICENCE.go7007"
-NO_GENERIC_LICENSE[Firmware-hfi1_firmware] = "LICENSE.hfi1_firmware"
-NO_GENERIC_LICENSE[Firmware-HP] = "LICENCE.HP"
-NO_GENERIC_LICENSE[Firmware-i915] = "LICENSE.i915"
-NO_GENERIC_LICENSE[Firmware-ib_qib] = "LICENSE.ib_qib"
-NO_GENERIC_LICENSE[Firmware-ibt_firmware] = "LICENCE.ibt_firmware"
-NO_GENERIC_LICENSE[Firmware-ice] = "LICENSE.ice"
-NO_GENERIC_LICENSE[Firmware-ice_enhanced] = "LICENSE.ice_enhanced"
-NO_GENERIC_LICENSE[Firmware-inside-secure] = "LICENCE.inside-secure"
-NO_GENERIC_LICENSE[Firmware-IntcSST2] = "LICENCE.IntcSST2"
-NO_GENERIC_LICENSE[Firmware-intel] = "LICENSE.intel"
-NO_GENERIC_LICENSE[Firmware-intel_vpu] = "LICENSE.intel_vpu"
-NO_GENERIC_LICENSE[Firmware-ipu3_firmware] = "LICENSE.ipu3_firmware"
-NO_GENERIC_LICENSE[Firmware-it913x] = "LICENCE.it913x"
-NO_GENERIC_LICENSE[Firmware-ivsc] = "LICENSE.ivsc"
-NO_GENERIC_LICENSE[Firmware-iwlwifi_firmware] = "LICENCE.iwlwifi_firmware"
-NO_GENERIC_LICENSE[Firmware-ixp4xx] = "LICENSE.ixp4xx"
-NO_GENERIC_LICENSE[Firmware-kaweth] = "LICENCE.kaweth"
-NO_GENERIC_LICENSE[Firmware-keyspan] = "LICENCE.keyspan"
-NO_GENERIC_LICENSE[Firmware-lenovo] = "LICENCE.lenovo"
-NO_GENERIC_LICENSE[Firmware-linaro] = "LICENCE.linaro"
-NO_GENERIC_LICENSE[Firmware-Lontium] = "LICENSE.Lontium"
-NO_GENERIC_LICENSE[Firmware-mali_csffw] = "LICENCE.mali_csffw"
-NO_GENERIC_LICENSE[Firmware-Marvell] = "LICENCE.Marvell"
-NO_GENERIC_LICENSE[Firmware-mediatek] = "LICENCE.mediatek"
-NO_GENERIC_LICENSE[Firmware-mellanox] = "LICENSE.mellanox"
-NO_GENERIC_LICENSE[Firmware-mga] = "LICENSE.mga"
-NO_GENERIC_LICENSE[Firmware-microchip] = "LICENCE.microchip"
-NO_GENERIC_LICENSE[Firmware-montage] = "LICENSE.montage"
-NO_GENERIC_LICENSE[Firmware-moxa] = "LICENCE.moxa"
-NO_GENERIC_LICENSE[Firmware-myri10ge_firmware] = "LICENCE.myri10ge_firmware"
-NO_GENERIC_LICENSE[Firmware-netronome] = "LICENCE.Netronome"
-NO_GENERIC_LICENSE[Firmware-nvidia] = "LICENCE.nvidia"
-NO_GENERIC_LICENSE[Firmware-nxp] = "LICENSE.nxp"
-NO_GENERIC_LICENSE[Firmware-nxp_mc_firmware] = "LICENSE.nxp_mc_firmware"
-NO_GENERIC_LICENSE[Firmware-OLPC] = "LICENCE.OLPC"
-NO_GENERIC_LICENSE[Firmware-ath9k-htc] = "LICENCE.open-ath9k-htc-firmware"
-NO_GENERIC_LICENSE[Firmware-phanfw] = "LICENCE.phanfw"
-NO_GENERIC_LICENSE[Firmware-powervr] = "LICENSE.powervr"
-NO_GENERIC_LICENSE[Firmware-qat] = "LICENCE.qat_firmware"
-NO_GENERIC_LICENSE[Firmware-qcom] = "LICENSE.qcom"
-NO_GENERIC_LICENSE[Firmware-qcom-2] = "LICENSE.qcom-2"
-NO_GENERIC_LICENSE[Firmware-qcom-yamato] = "LICENSE.qcom_yamato"
-NO_GENERIC_LICENSE[Firmware-qed] = "LICENSE.qed"
-NO_GENERIC_LICENSE[Firmware-qla1280] = "LICENCE.qla1280"
-NO_GENERIC_LICENSE[Firmware-qla2xxx] = "LICENCE.qla2xxx"
-NO_GENERIC_LICENSE[Firmware-qualcommAthos_ar3k] = "LICENSE.QualcommAtheros_ar3k"
-NO_GENERIC_LICENSE[Firmware-qualcommAthos_ath10k] = "LICENSE.QualcommAtheros_ath10k"
-NO_GENERIC_LICENSE[Firmware-r8169] = "LICENSE.r8169"
-NO_GENERIC_LICENSE[Firmware-r8a779x_usb3] = "LICENCE.r8a779x_usb3"
-NO_GENERIC_LICENSE[Firmware-radeon] = "LICENSE.radeon"
-NO_GENERIC_LICENSE[Firmware-ralink_a_mediatek_company_firmware] = "LICENCE.ralink_a_mediatek_company_firmware"
-NO_GENERIC_LICENSE[Firmware-ralink-firmware] = "LICENCE.ralink-firmware.txt"
-NO_GENERIC_LICENSE[Firmware-r8a779g_pcie_phy] = "LICENCE.r8a779g_pcie_phy"
-NO_GENERIC_LICENSE[Firmware-rockchip] = "LICENCE.rockchip"
-NO_GENERIC_LICENSE[Firmware-rp2] = "LICENSE.rp2"
-NO_GENERIC_LICENSE[Firmware-rsi] = "LICENSE.rsi"
-NO_GENERIC_LICENSE[Firmware-rt1320] = "LICENSE.rt1320"
-NO_GENERIC_LICENSE[Firmware-rtlwifi_firmware] = "LICENCE.rtlwifi_firmware.txt"
-NO_GENERIC_LICENSE[Firmware-s5p-mfc] = "LICENSE.s5p-mfc"
-NO_GENERIC_LICENSE[Firmware-sensoray] = "LICENCE.sensoray"
-NO_GENERIC_LICENSE[Firmware-siano] = "LICENCE.siano"
-NO_GENERIC_LICENSE[Firmware-imx-sdma_firmware] = "LICENSE.sdma_firmware"
-NO_GENERIC_LICENSE[Firmware-tehuti] = "LICENSE.tehuti"
-NO_GENERIC_LICENSE[Firmware-ti-connectivity] = "LICENCE.ti-connectivity"
-NO_GENERIC_LICENSE[Firmware-ti-keystone] = "LICENCE.ti-keystone"
-NO_GENERIC_LICENSE[Firmware-ti-tspa] = "LICENCE.ti-tspa"
-NO_GENERIC_LICENSE[Firmware-tigon] = "LICENCE.tigon"
-NO_GENERIC_LICENSE[Firmware-tlg2300] = "LICENSE.tlg2300"
-NO_GENERIC_LICENSE[Firmware-typhoon] = "LICENCE.typhoon"
-NO_GENERIC_LICENSE[Firmware-ueagle-atm4-firmware] = "LICENCE.ueagle-atm4-firmware"
-NO_GENERIC_LICENSE[Firmware-via_vt6656] = "LICENCE.via_vt6656"
-NO_GENERIC_LICENSE[Firmware-vxge] = "LICENSE.vxge"
-NO_GENERIC_LICENSE[Firmware-wfx] = "wfx/LICENCE.wf200"
-NO_GENERIC_LICENSE[Firmware-wl1251] = "LICENCE.wl1251"
-NO_GENERIC_LICENSE[Firmware-xc4000] = "LICENCE.xc4000"
-NO_GENERIC_LICENSE[Firmware-xc5000] = "LICENCE.xc5000"
-NO_GENERIC_LICENSE[Firmware-xc5000c] = "LICENCE.xc5000c"
-NO_GENERIC_LICENSE[Firmware-xe] = "LICENSE.xe"
+NO_GENERIC_LICENSE[Firmware-Abilis] = "LICENSES/LICENCE.Abilis"
+NO_GENERIC_LICENSE[Firmware-adsp_sst] = "LICENSES/LICENCE.adsp_sst"
+NO_GENERIC_LICENSE[Firmware-advansys] = "LICENSES/LICENCE.advansys"
+NO_GENERIC_LICENSE[Firmware-aeonsemi] = "LICENSES/LICENSE.aeonsemi"
+NO_GENERIC_LICENSE[Firmware-agere] = "LICENSES/LICENCE.agere"
+NO_GENERIC_LICENSE[Firmware-airoha] = "LICENSES/LICENSE.airoha"
+NO_GENERIC_LICENSE[Firmware-alacritech] = "LICENSES/LICENCE.alacritech"
+NO_GENERIC_LICENSE[Firmware-amdgpu] = "LICENSES/LICENSE.amdgpu"
+NO_GENERIC_LICENSE[Firmware-amdisp] = "LICENSES/LICENSE.amdisp"
+NO_GENERIC_LICENSE[Firmware-amdnpu] = "LICENSES/LICENSE.amdnpu"
+NO_GENERIC_LICENSE[Firmware-amd_pmf] = "LICENSES/LICENSE.amd_pmf"
+NO_GENERIC_LICENSE[Firmware-amd-sev] = "LICENSES/LICENSE.amd-sev"
+NO_GENERIC_LICENSE[Firmware-amd-ucode] = "LICENSES/LICENSE.amd-ucode"
+NO_GENERIC_LICENSE[Firmware-amlogic] = "LICENSES/LICENSE.amlogic"
+NO_GENERIC_LICENSE[Firmware-amlogic_vdec] = "LICENSES/LICENSE.amlogic_vdec"
+NO_GENERIC_LICENSE[Firmware-amphion_vpu] = "LICENSES/LICENSE.amphion_vpu"
+NO_GENERIC_LICENSE[Firmware-atheros_firmware] = "LICENSES/LICENCE.atheros_firmware"
+NO_GENERIC_LICENSE[Firmware-atmel] = "LICENSES/LICENSE.atmel"
+NO_GENERIC_LICENSE[Firmware-bfa] = "LICENSES/LICENSE.bfa"
+NO_GENERIC_LICENSE[Firmware-bmi260] = "LICENSES/LICENSE.bmi260"
+NO_GENERIC_LICENSE[Firmware-bnx2] = "LICENSES/LICENCE.bnx2"
+NO_GENERIC_LICENSE[Firmware-bnx2x] = "LICENSES/LICENCE.bnx2x"
+NO_GENERIC_LICENSE[Firmware-broadcom_bcm43xx] = "LICENSES/LICENCE.broadcom_bcm43xx"
+NO_GENERIC_LICENSE[Firmware-ca0132] = "LICENSES/LICENCE.ca0132"
+NO_GENERIC_LICENSE[Firmware-cadence] = "LICENSES/LICENCE.cadence"
+NO_GENERIC_LICENSE[Firmware-cavium] = "LICENSES/LICENCE.cavium"
+NO_GENERIC_LICENSE[Firmware-chelsio_firmware] = "LICENSES/LICENCE.chelsio_firmware"
+NO_GENERIC_LICENSE[Firmware-cirrus] = "LICENSES/LICENSE.cirrus"
+NO_GENERIC_LICENSE[Firmware-cnm] = "LICENSES/LICENCE.cnm"
+NO_GENERIC_LICENSE[Firmware-conexant] = "LICENSES/LICENSE.conexant"
+NO_GENERIC_LICENSE[Firmware-cw1200] = "LICENSES/LICENCE.cw1200"
+NO_GENERIC_LICENSE[Firmware-cw1200-sdd] = "LICENSES/LICENCE.cw1200-sdd"
+NO_GENERIC_LICENSE[Firmware-cxgb3] = "LICENSES/LICENCE.cxgb3"
+NO_GENERIC_LICENSE[Firmware-cypress] = "LICENSES/LICENCE.cypress"
+NO_GENERIC_LICENSE[Firmware-dabusb] = "LICENSES/LICENCE.dabusb"
+NO_GENERIC_LICENSE[Firmware-dell] = "LICENSES/LICENSE.dell"
+NO_GENERIC_LICENSE[Firmware-dib0700] = "LICENSES/LICENSE.dib0700"
+NO_GENERIC_LICENSE[Firmware-drxk] = "LICENSES/LICENSE.drxk"
+NO_GENERIC_LICENSE[Firmware-e100] = "LICENSES/LICENCE.e100"
+NO_GENERIC_LICENSE[Firmware-emi26] = "LICENSES/LICENCE.emi26"
+NO_GENERIC_LICENSE[Firmware-ene_firmware] = "LICENSES/LICENCE.ene_firmware"
+NO_GENERIC_LICENSE[Firmware-fw_sst_0f28] = "LICENSES/LICENCE.fw_sst_0f28"
+NO_GENERIC_LICENSE[Firmware-go7007] = "LICENSES/LICENCE.go7007"
+NO_GENERIC_LICENSE[Firmware-hfi1_firmware] = "LICENSES/LICENSE.hfi1_firmware"
+NO_GENERIC_LICENSE[Firmware-HP] = "LICENSES/LICENCE.HP"
+NO_GENERIC_LICENSE[Firmware-i915] = "LICENSES/LICENSE.i915"
+NO_GENERIC_LICENSE[Firmware-ib_qib] = "LICENSES/LICENSE.ib_qib"
+NO_GENERIC_LICENSE[Firmware-ibt_firmware] = "LICENSES/LICENCE.ibt_firmware"
+NO_GENERIC_LICENSE[Firmware-ice] = "LICENSES/LICENSE.ice"
+NO_GENERIC_LICENSE[Firmware-ice_enhanced] = "LICENSES/LICENSE.ice_enhanced"
+NO_GENERIC_LICENSE[Firmware-inside-secure] = "LICENSES/LICENCE.inside-secure"
+NO_GENERIC_LICENSE[Firmware-IntcSST2] = "LICENSES/LICENCE.IntcSST2"
+NO_GENERIC_LICENSE[Firmware-intel] = "LICENSES/LICENSE.intel"
+NO_GENERIC_LICENSE[Firmware-intel_vpu] = "LICENSES/LICENSE.intel_vpu"
+NO_GENERIC_LICENSE[Firmware-ipu3_firmware] = "LICENSES/LICENSE.ipu3_firmware"
+NO_GENERIC_LICENSE[Firmware-it913x] = "LICENSES/LICENCE.it913x"
+NO_GENERIC_LICENSE[Firmware-ivsc] = "LICENSES/LICENSE.ivsc"
+NO_GENERIC_LICENSE[Firmware-iwlwifi_firmware] = "LICENSES/LICENCE.iwlwifi_firmware"
+NO_GENERIC_LICENSE[Firmware-ixp4xx] = "LICENSES/LICENSE.ixp4xx"
+NO_GENERIC_LICENSE[Firmware-kaweth] = "LICENSES/LICENCE.kaweth"
+NO_GENERIC_LICENSE[Firmware-keyspan] = "LICENSES/LICENCE.keyspan"
+NO_GENERIC_LICENSE[Firmware-lenovo] = "LICENSES/LICENCE.lenovo"
+NO_GENERIC_LICENSE[Firmware-linaro] = "LICENSES/LICENCE.linaro"
+NO_GENERIC_LICENSE[Firmware-Lontium] = "LICENSES/LICENSE.Lontium"
+NO_GENERIC_LICENSE[Firmware-mali_csffw] = "LICENSES/LICENCE.mali_csffw"
+NO_GENERIC_LICENSE[Firmware-Marvell] = "LICENSES/LICENCE.Marvell"
+NO_GENERIC_LICENSE[Firmware-mediatek] = "LICENSES/LICENCE.mediatek"
+NO_GENERIC_LICENSE[Firmware-mellanox] = "LICENSES/LICENSE.mellanox"
+NO_GENERIC_LICENSE[Firmware-mga] = "LICENSES/LICENSE.mga"
+NO_GENERIC_LICENSE[Firmware-microchip] = "LICENSES/LICENCE.microchip"
+NO_GENERIC_LICENSE[Firmware-montage] = "LICENSES/LICENSE.montage"
+NO_GENERIC_LICENSE[Firmware-moxa] = "LICENSES/LICENCE.moxa"
+NO_GENERIC_LICENSE[Firmware-myri10ge_firmware] = "LICENSES/LICENCE.myri10ge_firmware"
+NO_GENERIC_LICENSE[Firmware-netronome] = "LICENSES/LICENCE.Netronome"
+NO_GENERIC_LICENSE[Firmware-nvidia] = "LICENSES/LICENCE.nvidia"
+NO_GENERIC_LICENSE[Firmware-nxp] = "LICENSES/LICENSE.nxp"
+NO_GENERIC_LICENSE[Firmware-nxp_mc_firmware] = "LICENSES/LICENSE.nxp_mc_firmware"
+NO_GENERIC_LICENSE[Firmware-OLPC] = "LICENSES/LICENCE.OLPC"
+NO_GENERIC_LICENSE[Firmware-ath9k-htc] = "LICENSES/LICENCE.open-ath9k-htc-firmware"
+NO_GENERIC_LICENSE[Firmware-phanfw] = "LICENSES/LICENCE.phanfw"
+NO_GENERIC_LICENSE[Firmware-powervr] = "LICENSES/LICENSE.powervr"
+NO_GENERIC_LICENSE[Firmware-qat] = "LICENSES/LICENCE.qat_firmware"
+NO_GENERIC_LICENSE[Firmware-qcom] = "LICENSES/LICENSE.qcom"
+NO_GENERIC_LICENSE[Firmware-qcom-2] = "LICENSES/LICENSE.qcom-2"
+NO_GENERIC_LICENSE[Firmware-qcom-yamato] = "LICENSES/LICENSE.qcom_yamato"
+NO_GENERIC_LICENSE[Firmware-qed] = "LICENSES/LICENSE.qed"
+NO_GENERIC_LICENSE[Firmware-qla1280] = "LICENSES/LICENCE.qla1280"
+NO_GENERIC_LICENSE[Firmware-qla2xxx] = "LICENSES/LICENCE.qla2xxx"
+NO_GENERIC_LICENSE[Firmware-qualcommAthos_ar3k] = "LICENSES/LICENSE.QualcommAtheros_ar3k"
+NO_GENERIC_LICENSE[Firmware-qualcommAthos_ath10k] = "LICENSES/LICENSE.QualcommAtheros_ath10k"
+NO_GENERIC_LICENSE[Firmware-r8169] = "LICENSES/LICENSE.r8169"
+NO_GENERIC_LICENSE[Firmware-r8a779x_usb3] = "LICENSES/LICENCE.r8a779x_usb3"
+NO_GENERIC_LICENSE[Firmware-radeon] = "LICENSES/LICENSE.radeon"
+NO_GENERIC_LICENSE[Firmware-ralink_a_mediatek_company_firmware] = "LICENSES/LICENCE.ralink_a_mediatek_company_firmware"
+NO_GENERIC_LICENSE[Firmware-ralink-firmware] = "LICENSES/LICENCE.ralink-firmware.txt"
+NO_GENERIC_LICENSE[Firmware-r8a779g_pcie_phy] = "LICENSES/LICENCE.r8a779g_pcie_phy"
+NO_GENERIC_LICENSE[Firmware-rockchip] = "LICENSES/LICENCE.rockchip"
+NO_GENERIC_LICENSE[Firmware-rp2] = "LICENSES/LICENSE.rp2"
+NO_GENERIC_LICENSE[Firmware-rsi] = "LICENSES/LICENSE.rsi"
+NO_GENERIC_LICENSE[Firmware-rt1320] = "LICENSES/LICENSE.rt1320"
+NO_GENERIC_LICENSE[Firmware-rtlwifi_firmware] = "LICENSES/LICENCE.rtlwifi_firmware.txt"
+NO_GENERIC_LICENSE[Firmware-s5p-mfc] = "LICENSES/LICENSE.s5p-mfc"
+NO_GENERIC_LICENSE[Firmware-sensoray] = "LICENSES/LICENCE.sensoray"
+NO_GENERIC_LICENSE[Firmware-siano] = "LICENSES/LICENCE.siano"
+NO_GENERIC_LICENSE[Firmware-imx-sdma_firmware] = "LICENSES/LICENSE.sdma_firmware"
+NO_GENERIC_LICENSE[Firmware-tehuti] = "LICENSES/LICENSE.tehuti"
+NO_GENERIC_LICENSE[Firmware-ti-connectivity] = "LICENSES/LICENCE.ti-connectivity"
+NO_GENERIC_LICENSE[Firmware-ti-keystone] = "LICENSES/LICENCE.ti-keystone"
+NO_GENERIC_LICENSE[Firmware-ti-tspa] = "LICENSES/LICENCE.ti-tspa"
+NO_GENERIC_LICENSE[Firmware-tigon] = "LICENSES/LICENCE.tigon"
+NO_GENERIC_LICENSE[Firmware-tlg2300] = "LICENSES/LICENSE.tlg2300"
+NO_GENERIC_LICENSE[Firmware-typhoon] = "LICENSES/LICENCE.typhoon"
+NO_GENERIC_LICENSE[Firmware-ueagle-atm4-firmware] = "LICENSES/LICENCE.ueagle-atm4-firmware"
+NO_GENERIC_LICENSE[Firmware-via_vt6656] = "LICENSES/LICENCE.via_vt6656"
+NO_GENERIC_LICENSE[Firmware-vxge] = "LICENSES/LICENSE.vxge"
+NO_GENERIC_LICENSE[Firmware-wfx] = "LICENSES/LICENCE.wf200"
+NO_GENERIC_LICENSE[Firmware-wl1251] = "LICENSES/LICENCE.wl1251"
+NO_GENERIC_LICENSE[Firmware-xc4000] = "LICENSES/LICENCE.xc4000"
+NO_GENERIC_LICENSE[Firmware-xc5000] = "LICENSES/LICENCE.xc5000"
+NO_GENERIC_LICENSE[Firmware-xc5000c] = "LICENSES/LICENCE.xc5000c"
+NO_GENERIC_LICENSE[Firmware-xe] = "LICENSES/LICENSE.xe"
 NO_GENERIC_LICENSE[WHENCE] = "WHENCE"
 
 PE = "1"
@@ -452,7 +416,7 @@ SRC_URI:class-devupstream = "git://git.kernel.org/pub/scm/linux/kernel/git/firmw
 # Pin this to the 20220509 release, override this in local.conf
 SRCREV:class-devupstream ?= "b19cbdca78ab2adfd210c91be15a22568e8b8cae"
 
-SRC_URI[sha256sum] = "b14e7197a290a7e5569f5ef790cde289bddc47e32126f2eb262a8e677fc39727"
+SRC_URI[sha256sum] = "2b9d8a358e76eb766588609135e53fa548b902c551daae33ee32f26f25e60dbb"
 
 inherit allarch
 
@@ -494,8 +458,7 @@ do_install() {
         if [ "${@bb.utils.contains('PACKAGECONFIG', 'deduplicate', '1', '0', d)}" = "1" ]; then
                 oe_runmake 'DESTDIR=${D}' 'FIRMWAREDIR=${firmwaredir}' dedup
         fi
-        cp LICEN[CS]E.* WHENCE ${D}${firmwaredir}/
-        cp wfx/LICEN[CS]E.* ${D}${firmwaredir}/wfx/
+        cp LICENSES/LICEN[CS]E.* WHENCE ${D}${firmwaredir}/
 
         # Remove all unlicensed firmware
         for file in ${REMOVE_UNLICENSED}; do
@@ -564,11 +527,13 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-mwl8k ${PN}-mwlwifi\
              ${PN}-ti-connectivity-license ${PN}-wl1251-license ${PN}-wlcommon ${PN}-wl1251 ${PN}-wl12xx ${PN}-wl18xx ${PN}-cc33xx \
              ${PN}-ti-keystone-license ${PN}-ti-keystone \
-             ${PN}-ti-tspa-license ${PN}-ti-pcm6240 ${PN}-ti-tas2563 ${PN}-ti-tas2781 ${PN}-ti-tas2783 ${PN}-ti-vpe \
+             ${PN}-ti-tspa-license ${PN}-ti-pcm6240 \
+             ${PN}-ti-tas2563 ${PN}-ti-tas257x ${PN}-ti-tas2781 ${PN}-ti-tas2783 ${PN}-ti-vpe \
              ${PN}-ti-usb-3410-5052 \
              ${PN}-vt6656-license ${PN}-vt6656 \
              ${PN}-rs9113 ${PN}-rs9116 ${PN}-rsi-91x \
-             ${PN}-rtl-license ${PN}-rtl8188 ${PN}-rtl8192cu ${PN}-rtl8192ce ${PN}-rtl8192su ${PN}-rtl8723 ${PN}-rtl8821 \
+             ${PN}-rtl-license ${PN}-rtl8188 ${PN}-rtl8192cu ${PN}-rtl8192ce ${PN}-rtl8192su \
+             ${PN}-rtl8261c ${PN}-rtl8723 ${PN}-rtl8821 \
              ${PN}-rtl8761 \
              ${PN}-rtl8168 \
              ${PN}-rtl8822 \
@@ -704,6 +669,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-nxp9098-sdio \
              ${PN}-nxpiw416-sdio \
              ${PN}-nxpiw612-sdio \
+             ${PN}-nxpiw61x-sdio \
              ${PN}-nxp-sr1xx \
              ${PN}-nxp-mc-license ${PN}-nxp-mc \
              ${PN}-netronome-license ${PN}-netronome \
@@ -750,7 +716,8 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-qcom-sdm845-adreno ${PN}-qcom-sdm845-audio ${PN}-qcom-sdm845-compute \
              ${PN}-qcom-sdm845-thundercomm-db845c-sensors \
              ${PN}-qcom-sdx35-foxconn-firehose ${PN}-qcom-sdx61-foxconn-firehose \
-             ${PN}-qcom-shikra-compute ${PN}-qcom-shikra-qupv3fw \
+             ${PN}-qcom-shikra-adreno ${PN}-qcom-shikra-compute ${PN}-qcom-shikra-audio \
+             ${PN}-qcom-shikra-modem ${PN}-qcom-shikra-qupv3fw \
              ${PN}-qcom-sm8150-adreno \
              ${PN}-qcom-sm8250-adreno ${PN}-qcom-sm8250-audio ${PN}-qcom-sm8250-compute \
              ${PN}-qcom-sm8250-thundercomm-rb5-sensors \
@@ -1022,6 +989,7 @@ FILES:${PN}-qca-qca2066 = " \
   ${firmwaredir}/qca/hpnv21g.309* \
   ${firmwaredir}/qca/hpnv21.30a* \
   ${firmwaredir}/qca/hpnv21g.30a* \
+  ${firmwaredir}/qca/hpnv21g.30c* \
   ${firmwaredir}/qca/hpnv21.b8c* \
   ${firmwaredir}/qca/hpnv21.b9f* \
   ${firmwaredir}/qca/hpnv21.ba0* \
@@ -1067,6 +1035,7 @@ FILES:${PN}-qca-qca6698 = " \
   ${firmwaredir}/qca/QCA6698/hpnv21.bin* \
 "
 FILES:${PN}-qca-qcc2072 = " \
+  ${firmwaredir}/qca/ornbcscal11.bin* \
   ${firmwaredir}/qca/ornbtfw11.tlv* \
   ${firmwaredir}/qca/ornnv11.bin* \
 "
@@ -1541,6 +1510,7 @@ LICENSE:${PN}-nxp9098-pcie = "Firmware-nxp"
 LICENSE:${PN}-nxp9098-sdio = "Firmware-nxp"
 LICENSE:${PN}-nxpiw416-sdio = "Firmware-nxp"
 LICENSE:${PN}-nxpiw612-sdio = "Firmware-nxp"
+LICENSE:${PN}-nxpiw61x-sdio = "Firmware-nxp"
 LICENSE:${PN}-nxp-sr1xx = "Firmware-nxp"
 LICENSE:${PN}-nxp-license = "Firmware-nxp"
 
@@ -1556,6 +1526,7 @@ ALLOW_EMPTY:${PN}-nxp9098-pcie = "1"
 ALLOW_EMPTY:${PN}-nxp9098-sdio = "1"
 FILES:${PN}-nxpiw416-sdio = "${firmwaredir}/nxp/*iw416*"
 FILES:${PN}-nxpiw612-sdio = "${firmwaredir}/nxp/uartspi_n61x_v1.bin.se*"
+FILES:${PN}-nxpiw61x-sdio = "${firmwaredir}/nxp/sd_w61x_v1.bin.se*"
 FILES:${PN}-nxp-sr1xx = "${firmwaredir}/nxp/sr150_fw.bin*"
 FILES:${PN}-nxp-license = "${firmwaredir}/LICENSE.nxp"
 
@@ -1568,6 +1539,7 @@ RDEPENDS:${PN}-nxp9098-pcie += "${PN}-nxp9098-common"
 RDEPENDS:${PN}-nxp9098-sdio += "${PN}-nxp9098-common"
 RDEPENDS:${PN}-nxpiw416-sdio += "${PN}-nxp-license"
 RDEPENDS:${PN}-nxpiw612-sdio += "${PN}-nxp-license"
+RDEPENDS:${PN}-nxpiw61x-sdio += "${PN}-nxp-license"
 RDEPENDS:${PN}-nxp-sr1xx += "${PN}-nxp-license"
 
 # For nxp-mc
@@ -1660,6 +1632,7 @@ LICENSE:${PN}-rtl8188 = "Firmware-rtlwifi_firmware"
 LICENSE:${PN}-rtl8192cu = "Firmware-rtlwifi_firmware"
 LICENSE:${PN}-rtl8192ce = "Firmware-rtlwifi_firmware"
 LICENSE:${PN}-rtl8192su = "Firmware-rtlwifi_firmware"
+LICENSE:${PN}-rtl8261c = "Firmware-rtlwifi_firmware"
 LICENSE:${PN}-rtl8723 = "Firmware-rtlwifi_firmware"
 LICENSE:${PN}-rtl8761 = "Firmware-rtlwifi_firmware"
 LICENSE:${PN}-rtl8821 = "Firmware-rtlwifi_firmware"
@@ -1691,6 +1664,9 @@ FILES:${PN}-rtl8192ce = " \
 FILES:${PN}-rtl8192su = " \
   ${firmwaredir}/rtlwifi/rtl8712u.bin* \
 "
+FILES:${PN}-rtl8261c = " \
+  ${firmwaredir}/rtl_nic/rtl8261c.bin* \
+"
 FILES:${PN}-rtl8723 = " \
   ${firmwaredir}/rtlwifi/rtl8723*.bin* \
   ${firmwaredir}/rtw88/rtw8723*.bin* \
@@ -1745,6 +1721,7 @@ RDEPENDS:${PN}-rtl8188 += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8192ce += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8192cu += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8192su = "${PN}-rtl-license"
+RDEPENDS:${PN}-rtl8261c = "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8723 += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8821 += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8761 += "${PN}-rtl-license"
@@ -1768,7 +1745,7 @@ FILES:${PN}-wfx = " \
   ${firmwaredir}/wfx/*.pds*        \
   ${firmwaredir}/wfx/*.sec*        \
 "
-FILES:${PN}-wfx-license = "${firmwaredir}/wfx/LICENCE.wf200"
+FILES:${PN}-wfx-license = "${firmwaredir}/LICENCE.wf200"
 
 RDEPENDS:${PN}-wfx += "${PN}-wfx-license"
 
@@ -1842,6 +1819,18 @@ FILES:${PN}-ti-tas2563 = "\
 "
 RDEPENDS:${PN}-ti-tas2563 = "${PN}-ti-tspa-license"
 
+# For ti-tas257x - tas257x firmware
+LICENSE:${PN}-ti-tas257x = "Firmware-ti-tspa"
+FILES:${PN}-ti-tas257x = "\
+    ${firmwaredir}/tas257x-1amp-reg.bin*\
+    ${firmwaredir}/tas2572-1-1amp-reg.bin* \
+    ${firmwaredir}/tas2572-2-1amp-reg.bin* \
+    ${firmwaredir}/tas2572-3amp-reg.bin* \
+    ${firmwaredir}/tas2572-3-1amp-reg.bin* \
+    ${firmwaredir}/ti/audio/tas257x/* \
+"
+RDEPENDS:${PN}-ti-tas257x = "${PN}-ti-tspa-license"
+
 # For ti-pcm6240 - pcm6240 firmware
 LICENSE:${PN}-ti-pcm6240 = "Firmware-ti-tspa"
 FILES:${PN}-ti-pcm6240 = "\
@@ -2430,7 +2419,10 @@ LICENSE:${PN}-qcom-sdm845-modem = "Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "Firmware-qcom"
 LICENSE:${PN}-qcom-sdx35-foxconn-firehose = "Firmware-qcom"
 LICENSE:${PN}-qcom-sdx61-foxconn-firehose = "Firmware-qcom"
+LICENSE:${PN}-qcom-shikra-adreno = "Firmware-qcom"
 LICENSE:${PN}-qcom-shikra-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-shikra-audio = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-shikra-modem = "Firmware-qcom-2"
 LICENSE:${PN}-qcom-shikra-qupv3fw = "Firmware-qcom"
 LICENSE:${PN}-qcom-sm8150-adreno = "Firmware-qcom"
 LICENSE:${PN}-qcom-sm8250-adreno = "Firmware-qcom"
@@ -2594,7 +2586,10 @@ FILES:${PN}-qcom-sdm845-modem = "${firmwaredir}/qcom/sdm845/mba.mbn* ${firmwared
 FILES:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "${firmwaredir}/qcom/sdm845/Thundercomm/db845c/slpi*.*"
 FILES:${PN}-qcom-sdx35-foxconn-firehose = "${firmwaredir}/qcom/sdx35/foxconn/xbl_s_devprg_ns.melf*"
 FILES:${PN}-qcom-sdx61-foxconn-firehose = "${firmwaredir}/qcom/sdx61/foxconn/prog_firehose_lite.elf*"
+FILES:${PN}-qcom-shikra-adreno = "${nonarch_base_libdir}/firmware/qcom/shikra/a704_zap.mbn*"
 FILES:${PN}-qcom-shikra-compute = "${firmwaredir}/qcom/shikra/cdsp*.*"
+FILES:${PN}-qcom-shikra-audio = "${nonarch_base_libdir}/firmware/qcom/shikra/lpaicp*.*"
+FILES:${PN}-qcom-shikra-modem = "${nonarch_base_libdir}/firmware/qcom/shikra/cqs/qdsp6sw.mbn*"
 FILES:${PN}-qcom-shikra-qupv3fw = "${firmwaredir}/qcom/shikra/qupv3fw.elf*"
 FILES:${PN}-qcom-sm8150-adreno = "${firmwaredir}/qcom/sm8150/a640*.*"
 FILES:${PN}-qcom-sm8250-adreno = "${firmwaredir}/qcom/sm8250/a650*.*"
@@ -2756,7 +2751,10 @@ RDEPENDS:${PN}-qcom-sdm845-modem = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdx35-foxconn-firehose = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdx61-foxconn-firehose = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-shikra-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-shikra-compute = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-shikra-audio = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-shikra-modem = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-shikra-qupv3fw = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sm8150-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sm8250-adreno = "${PN}-qcom-license"
-- 
2.54.0


