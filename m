Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E667C5CFC1
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 10:49:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10286.1786704595105219019
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Aug 2026 03:49:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=bUiDoJO5;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Z5Bxwg1K;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAb8ra1494587
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5bU4nzC6n0u
	kBI+AY3VLgTY94Y7YYZdNi2aLvCUMV68=; b=bUiDoJO5Hhj4yOaAjdxry6rldNq
	QktQoUgu/AMEn5I+3mM65YfWA2ug4wja3HlBJgzFptuVB5CtQNxMQb3XULurPI3n
	3dcX41jpLPiRO0sio8mhGB+x0v1r4fM6WoZIsNAGM1NN3z6KpMHbFnG9H/Ssi4If
	ebYMf7Fu+m/kJj/xr3vJo241xvqYQEh17J3DZtHgF5aN2D0xFm6VvawJuHXDtKMx
	/FzSNqk92CySEev9HQKUrfbgyCfIUqtycBceQcG70qj6mxMNMU9Urfs+tYfglxGW
	NcWvXmYYun95Y3q/Kg0Y8v3PALOIQzd7O6598uBiainLxZvdNZQU3x6igtA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g20gn89gj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-529ae8e96e8so11615651cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786704593; x=1787309393; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bU4nzC6n0ukBI+AY3VLgTY94Y7YYZdNi2aLvCUMV68=;
        b=Z5Bxwg1Kq2JEzHIyRcoYXEAnqqGtXpOzsPaVf9GlDQedBYaETfQ3yOqlpJO9F8+gT8
         DC9ZJfwaX7Q/fiLaRPS7U2uOSE8ErihrkR8Yv2DigF+sGivLM/r9hSbxFMOxPmyjaBa3
         9A0cDctVVLs2jBUWtj6EAWoeVi1dSTWy2kHwl3eQY0yGXMB9zLC4fmic+T+8T20udN0R
         sVOrVowtMiUkb5u+gQsylR2NMkw4QuQKKOVfPZQqE9h0BWHtz31JPT+dG2LDfkBipZZ5
         FTOeIZz4PRv3RYzL9lqjK5Wi2Cglj+IJ5YS5E7jO7VBXEl8oGOBAjc4e1qwL+l2Qw0fQ
         0SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704593; x=1787309393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bU4nzC6n0ukBI+AY3VLgTY94Y7YYZdNi2aLvCUMV68=;
        b=lM4gUNrn0Hir6rMDElq7oA0P4HYJF2Kl+1kCBe8Xef6Ing1eTBXHlO1WfpoOS67aT6
         snhyl7kqIw/aLvjFewXruIS4wR1BYGmv4oq4nhd+9sGrHMg1p9TmTYZwrZhbWJQY3eag
         je+r8Jo9m7Mjn3J7Rd78QBIYhSBfTqZlYP9F3RL0xFz12IqbtGrGpBIPbRBnbqwuHxd9
         hp5FxhAOG3U9QxzOy/eIJKOvLdgJAusAQmUynIbm2OQ6ewY6aj0fzp+DkO8rD4plCfQU
         luwgvisYJzildGvZ9nx83yFHQl3glZACARdp2vB7zb8ON904FN9vzHn6BgMdmXok8d3G
         ReMA==
X-Gm-Message-State: AOJu0YzFRpHzFlVot0kVYycl/JaUkKXxMirNw/ajUKaxplLXEnojepSx
	97WrnH0PJ12MqWz2eW+ABI2S5u+NC3V5t/hP6xlfJfmeVoUpS0mHuP/g2k4MSJ8iOfc7Rk28CDq
	ICA+Q9olhbPqVx+k9M+8l4SwjzgzEoHxcGOSkGUjugt/WGsBreJL4JuG83gh4DNBpMS37nOAG2c
	/8QXrb2tFXXQ==
X-Gm-Gg: AR+sD12fZ42Z3/uE6WKd0/MfXg5nmKNewbi5aKPLfBD39sw9JTD5RK5F9bOP1PSbAcd
	gzwcZo1GXZzMptXq6NPJa2vCwuh+SJl9svgpc+dbgGxYvGgq+NnS6oTFMqEuPei5oyq+yblEYhu
	w1OqjXSRh+BmHpLscetLgBW9scOz7AcVNz8sF/9wTTGpTMqbpsq4fmifZ1Ct/II3I8vSgVLUcwv
	/rJg0Iyr3cqRZZEDBLeNMJR6iE4o+BgpAqG6abXyqfl14pZmGW/6DkCojTZEsbrRLTLzZB2CJwe
	p/ylL3xdVoxJgOmjJVUgGkPuC42O+kPdXlQ3M0Bxcb0iKZGzkCEulpY8h4+bZZbk/qIY6JD9zYU
	R/A8Y9U+lNq7KIOA=
X-Received: by 2002:a05:622a:58cf:b0:51c:a7e:4cc2 with SMTP id d75a77b69052e-52d854c5a22mr52726281cf.20.1786704592798;
        Fri, 14 Aug 2026 03:49:52 -0700 (PDT)
X-Received: by 2002:a05:622a:58cf:b0:51c:a7e:4cc2 with SMTP id d75a77b69052e-52d854c5a22mr52726001cf.20.1786704592302;
        Fri, 14 Aug 2026 03:49:52 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm7064102f8f.32.2026.08.14.03.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:49:51 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>,
        Vivek Puar <vpuar@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 3/5] linux-firmware: upgrade 20260622 -> 20260810
Date: Fri, 14 Aug 2026 11:49:41 +0100
Message-ID: <20260814104943.3261-3-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814104943.3261-1-jose.quaresma@oss.qualcomm.com>
References: <20260814104943.3261-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MiBTYWx0ZWRfX0yJPXAPbasHy
 /RkZwxAuEbN/CocdWOJoAPTsfjbQuhmszmGpZwtdNn0CUO5Xr/YKy9lpx3lx+U4kfSNArZ9OYyg
 rtGCx9aLotQHQhAB87AKHsgCdEM5+ObsyGJOk3WsBtgh8AXH/Q6kNijPhkbDANKGliILTmanaag
 YqHOxfBGvckna2ZGuWYz2gHJ/thycD5eiy54zea0XTYA4dn6FvLd124KlfgrZz6GUti1jlQh9wX
 ISn3sOqU//OoDszjRIKNK0+6KwsgTBtg1gdyXhE+YOveFYuE+PI2S26grq7OpqxXp/r9qhPE+Es
 BEpRSuoJHfSJhw1qPFa69FCMLFGq5F0ZsTpBJVguRuBemyiOvSgsL22YSGB7RjnluO2s8cdmVpP
 /YQWloMYtsKSrH7Fll3CmGWP7KJj4rcyT82+3/oOkzpfISvE6gBqJp5tN9/HIrH3fuIZquBnjAv
 vDzvvZfy6Axwd1ha3Yw==
X-Authority-Analysis: v=2.4 cv=DdMnbPtW c=1 sm=1 tr=0 ts=6a7ef2d1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=mcZphG0SpgHcQD3UQ1wA:9
 a=dawVfQjAaf238kedN5IG:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MiBTYWx0ZWRfXyj5AvNYL5Pcv
 2y7rSLsNu2ZmmHxQRm4gOfpQ6qUkYGb+aQqCYPufyDMCnUyGOX0aE0F1OHRJQbWg/DqlImR681L
 3u3JxahqG0S44ysvkW5i+ZG5ZcQOfZA=
X-Proofpoint-GUID: sXOctAkSPsojj9ie1a1M2ZE1m5efqtcI
X-Proofpoint-ORIG-GUID: sXOctAkSPsojj9ie1a1M2ZE1m5efqtcI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140082
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4661

From: Vivek Puar <vpuar@qti.qualcomm.com>

Upgrade the firmware package to latest release. Add Bluetooth firmware
for WCN685x and add firmware for tas2783A projects. Add firmware files
for the mm8108 chipset. Add ADSP topologies for several Qualcomm boards.
Add ADSP firmware for Qualcomm hawi and GPU firmware for Qualcomm Eliza
boards. Add README.md which documents the versions of the AMD SEV firmware.
Remove REMOVE_UNLICENSED entries for ueagle-atm as it is dropped upstream.

Signed-off-by: Vivek Puar <vpuar@qti.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 ...20260622.bb => linux-firmware_20260810.bb} | 47 +++++++++++++++----
 1 file changed, 39 insertions(+), 8 deletions(-)
 rename recipes-kernel/linux-firmware/{linux-firmware_20260622.bb => linux-firmware_20260810.bb} (98%)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260622.bb b/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
similarity index 98%
rename from recipes-kernel/linux-firmware/linux-firmware_20260622.bb
rename to recipes-kernel/linux-firmware/linux-firmware_20260810.bb
index 32cae7a..afaaff7 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260622.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
@@ -13,9 +13,6 @@ REMOVE_UNLICENSED += "f2255usb.bin"
 # For ti_usb_3410_5052 - Multi-Tech USB cell modems
 REMOVE_UNLICENSED += "mts_cdma.fw mts_gsm.fw mts_edge.fw"
 
-# For ueagle-atm - Driver for USB ADSL Modems based on Eagle I,II,III
-REMOVE_UNLICENSED += "ueagle-atm/930-fpga.bin ueagle-atm/CMVeiWO.bin ueagle-atm/CMVepFR10.bin ueagle-atm/DSP9p.bin ueagle-atm/eagleIII.fw ueagle-atm/adi930.fw ueagle-atm/CMVep.bin ueagle-atm/CMVepFR.bin ueagle-atm/DSPei.bin ueagle-atm/CMV9i.bin ueagle-atm/CMVepES03.bin ueagle-atm/CMVepIT.bin ueagle-atm/DSPep.bin ueagle-atm/CMV9p.bin ueagle-atm/CMVepES.bin ueagle-atm/CMVepWO.bin ueagle-atm/eagleI.fw ueagle-atm/CMVei.bin ueagle-atm/CMVepFR04.bin ueagle-atm/DSP9i.bin ueagle-atm/eagleII.fw"
-
 # For snd-wavefront - ISA WaveFront sound card
 REMOVE_UNLICENSED += "yamaha/yss225_registers.bin"
 
@@ -92,6 +89,7 @@ LICENSE = "\
     AND LicenseRef-Firmware-mga \
     AND LicenseRef-Firmware-microchip \
     AND LicenseRef-Firmware-montage \
+    AND LicenseRef-Firmware-morsemicro \
     AND LicenseRef-Firmware-moxa \
     AND LicenseRef-Firmware-myri10ge-firmware \
     AND LicenseRef-Firmware-netronome \
@@ -223,6 +221,7 @@ LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48ead
                     file://LICENSES/LICENSE.mga;md5=6191fc1ff8183b00515c36351ec24150 \
                     file://LICENSES/LICENCE.microchip;md5=db753b00305675dfbf120e3f24a47277 \
                     file://LICENSES/LICENSE.montage;md5=12a9f2b351f60fc9374da61c8b2f11ed \
+                    file://LICENSES/LICENCE.morsemicro;md5=ecb9056f2447ae40173dd1b9be950a70 \
                     file://LICENSES/LICENCE.moxa;md5=1086614767d8ccf744a923289d3d4261 \
                     file://LICENSES/LICENCE.myri10ge_firmware;md5=42e32fb89f6b959ca222e25ac8df8fed \
                     file://LICENSES/LICENCE.Netronome;md5=4add08f2577086d44447996503cddf5f \
@@ -278,7 +277,7 @@ LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48ead
                     "
 # WHENCE checksum is defined separately to ease overriding it if
 # class-devupstream is selected.
-WHENCE_CHKSUM  = "991f6e7ad5cc20508ae8923edc342c8e"
+WHENCE_CHKSUM  = "de47d58e10797eae2ccc753ab8d69bd7"
 
 # These are not common licenses, set NO_GENERIC_LICENSE for them
 # so that the license files will be copied from fetched source
@@ -353,6 +352,7 @@ NO_GENERIC_LICENSE[Firmware-mellanox] = "LICENSES/LICENSE.mellanox"
 NO_GENERIC_LICENSE[Firmware-mga] = "LICENSES/LICENSE.mga"
 NO_GENERIC_LICENSE[Firmware-microchip] = "LICENSES/LICENCE.microchip"
 NO_GENERIC_LICENSE[Firmware-montage] = "LICENSES/LICENSE.montage"
+NO_GENERIC_LICENSE[Firmware-morsemicro] = "LICENSES/LICENCE.morsemicro"
 NO_GENERIC_LICENSE[Firmware-moxa] = "LICENSES/LICENCE.moxa"
 NO_GENERIC_LICENSE[Firmware-myri10ge-firmware] = "LICENSES/LICENCE.myri10ge_firmware"
 NO_GENERIC_LICENSE[Firmware-netronome] = "LICENSES/LICENCE.Netronome"
@@ -416,7 +416,7 @@ SRC_URI:class-devupstream = "git://git.kernel.org/pub/scm/linux/kernel/git/firmw
 # Pin this to the 20220509 release, override this in local.conf
 SRCREV:class-devupstream ?= "b19cbdca78ab2adfd210c91be15a22568e8b8cae"
 
-SRC_URI[sha256sum] = "2b9d8a358e76eb766588609135e53fa548b902c551daae33ee32f26f25e60dbb"
+SRC_URI[sha256sum] = "ac17c34fe73756926a961fbafadf8d8f07a3bd2dd2f4ea31a0fb5d50c714a49a"
 
 inherit allarch
 
@@ -656,6 +656,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-linaro-license \
              ${PN}-mali-csffw-arch108 ${PN}-mali-csffw-arch1010 ${PN}-mali-csffw-arch1012 ${PN}-mali-csffw-arch118 ${PN}-mali-csffw-arch128 ${PN}-mali-csffw-arch138 ${PN}-mali-csffw-license \
              ${PN}-mellanox \
+             ${PN}-mm8108 \
              ${PN}-nvidia-license \
              ${PN}-nvidia-tegra-k1 ${PN}-nvidia-tegra \
              ${PN}-nvidia-gpu \
@@ -687,11 +688,13 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-qcom-adreno-a612 ${PN}-qcom-adreno-a623 ${PN}-qcom-adreno-a630 ${PN}-qcom-adreno-a640 \
              ${PN}-qcom-adreno-a650 ${PN}-qcom-adreno-a660 ${PN}-qcom-adreno-a663 \
              ${PN}-qcom-adreno-a702 ${PN}-qcom-adreno-a730 ${PN}-qcom-adreno-a740 \
-             ${PN}-qcom-adreno-g705 ${PN}-qcom-adreno-g709 ${PN}-qcom-adreno-g715 \
+             ${PN}-qcom-adreno-g705 ${PN}-qcom-adreno-g709 ${PN}-qcom-adreno-g715  ${PN}-qcom-adreno-g717 \
              ${PN}-qcom-adreno-g800 ${PN}-qcom-adreno-g801 ${PN}-qcom-adreno-g802 \
              ${PN}-qcom-apq8016-modem ${PN}-qcom-apq8016-wifi \
              ${PN}-qcom-apq8096-adreno ${PN}-qcom-apq8096-audio ${PN}-qcom-apq8096-modem \
+             ${PN}-qcom-eliza-adreno \
              ${PN}-qcom-glymur-adreno ${PN}-qcom-glymur-audio ${PN}-qcom-glymur-compute \
+             ${PN}-qcom-hawi-audio \
              ${PN}-qcom-kaanapali-adreno ${PN}-qcom-kaanapali-audio \
              ${PN}-qcom-kaanapali-compute ${PN}-qcom-kaanapali-soccp \
              ${PN}-qcom-qcm2290-adreno ${PN}-qcom-qcm2290-audio ${PN}-qcom-qcm2290-modem \
@@ -1068,7 +1071,9 @@ FILES:${PN}-qca-wcn6750 = " \
   ${firmwaredir}/qca/msnv11.b09* \
 "
 FILES:${PN}-qca-wcn685x = " \
+  ${firmwaredir}/qca/wcnhpbtfw10.tlv* \
   ${firmwaredir}/qca/wcnhpbtfw21.tlv* \
+  ${firmwaredir}/qca/wcnhpnv10.b* \
   ${firmwaredir}/qca/wcnhpnv21.b* \
   ${firmwaredir}/qca/wcnhpnv21g.b* \
 "
@@ -1852,16 +1857,21 @@ RDEPENDS:${PN}-ti-tas2781 = "${PN}-ti-tspa-license"
 LICENSE:${PN}-ti-tas2783 = "LicenseRef-Firmware-ti-tspa"
 FILES:${PN}-ti-tas2783 = "\
     ${firmwaredir}/1534-2-*.bin* \
+    ${firmwaredir}/15E2-?-0x*.bin* \
     ${firmwaredir}/16F4-1-*.bin* \
     ${firmwaredir}/1714-1-*.bin* \
     ${firmwaredir}/19[569]4-?-?-*.bin* \
     ${firmwaredir}/1A[CD]4-?-?-*.bin* \
     ${firmwaredir}/1B[09]4-?-?-*.bin* \
+    ${firmwaredir}/1C64-?-?-0x*.bin* \
     ${firmwaredir}/3??1-?-0x*.bin* \
     ${firmwaredir}/8E??-?-0x*.bin* \
     ${firmwaredir}/8E??-?-?-0x*.bin* \
     ${firmwaredir}/8F??-?-0x*.bin* \
     ${firmwaredir}/8F??-?-?-0x*.bin* \
+    ${firmwaredir}/900[1-9]-?-0x*.bin* \
+    ${firmwaredir}/90[12][0-9]-?-0x*.bin* \
+    ${firmwaredir}/90[12][0-9]-?-?-0x*.bin* \
     ${firmwaredir}/ti/audio/tas2783/* \
 "
 RDEPENDS:${PN}-ti-tas2781 = "${PN}-ti-tspa-license"
@@ -2360,6 +2370,7 @@ LICENSE:${PN}-qcom-adreno-a740 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g705 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g709 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g715 = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g717 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g800 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g801 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g802 = "LicenseRef-Firmware-qcom"
@@ -2368,9 +2379,11 @@ LICENSE:${PN}-qcom-apq8016-wifi = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8096-audio = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8096-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8096-modem = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-eliza-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-glymur-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-glymur-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
 LICENSE:${PN}-qcom-glymur-compute = "LicenseRef-Firmware-qcom-2"
+LICENSE:${PN}-qcom-hawi-audio = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-kaanapali-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-kaanapali-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
 LICENSE:${PN}-qcom-kaanapali-compute = "LicenseRef-Firmware-qcom-2"
@@ -2496,6 +2509,7 @@ FILES:${PN}-qcom-adreno-a740 = "${firmwaredir}/qcom/a740_sqe*.* ${firmwaredir}/q
 FILES:${PN}-qcom-adreno-g705 = "${firmwaredir}/qcom/gen70500_*.*"
 FILES:${PN}-qcom-adreno-g709 = "${firmwaredir}/qcom/gen70900_*.* ${firmwaredir}/qcom/gmu_gen70900.*"
 FILES:${PN}-qcom-adreno-g715 = "${firmwaredir}/qcom/gen71500_*.*"
+FILES:${PN}-qcom-adreno-g717 = "${firmwaredir}/qcom/gen71700_*.*"
 FILES:${PN}-qcom-adreno-g800 = "${firmwaredir}/qcom/gen80000_*.*"
 FILES:${PN}-qcom-adreno-g801 = "${firmwaredir}/qcom/gen80100_*.*"
 FILES:${PN}-qcom-adreno-g802 = "${firmwaredir}/qcom/gen80200_*.*"
@@ -2504,12 +2518,14 @@ FILES:${PN}-qcom-apq8016-wifi = "${firmwaredir}/qcom/apq8016/wcnss.mbn* ${firmwa
 FILES:${PN}-qcom-apq8096-adreno = "${firmwaredir}/qcom/apq8096/a530_zap.mbn* ${firmwaredir}/qcom/a530_zap.mdt*"
 FILES:${PN}-qcom-apq8096-audio = "${firmwaredir}/qcom/apq8096/adsp*.*"
 FILES:${PN}-qcom-apq8096-modem = "${firmwaredir}/qcom/apq8096/mba.mbn* ${firmwaredir}/qcom/apq8096/modem*.* ${firmwaredir}/qcom/apq8096/wlanmdsp.mbn*"
+FILES:${PN}-qcom-eliza-adreno = "${firmwaredir}/qcom/eliza/gen71700_zap.mbn*"
 FILES:${PN}-qcom-glymur-adreno = "${firmwaredir}/qcom/glymur/gen80100_zap.mbn*"
 FILES:${PN}-qcom-glymur-audio = " \
     ${firmwaredir}/qcom/glymur/adsp*.* \
     ${firmwaredir}/qcom/glymur/GLYMUR-CRD-tplg.bin* \
 "
 FILES:${PN}-qcom-glymur-compute = "${firmwaredir}/qcom/glymur/cdsp*.*"
+FILES:${PN}-qcom-hawi-audio = "${firmwaredir}/qcom/hawi/adsp*.*"
 FILES:${PN}-qcom-kaanapali-adreno = "${firmwaredir}/qcom/kaanapali/gen80200_zap.mbn*"
 FILES:${PN}-qcom-kaanapali-audio = " \
     ${firmwaredir}/qcom/kaanapali/adsp*.* \
@@ -2526,6 +2542,7 @@ FILES:${PN}-qcom-qcm6490-audio = " \
     ${firmwaredir}/qcom/qc[ms]6490/adsp*.* \
     ${firmwaredir}/qcom/qc[ms]6490/battmgr.jsn \
     ${firmwaredir}/qcom/qcm6490/QCM6490-IDP-tplg.bin* \
+    ${firmwaredir}/qcom/qcs6490/QCS6490-RB3Gen2-Industrial-Mezz-tplg.bin* \
     ${firmwaredir}/qcom/qcs6490/QCS6490-RB3Gen2-tplg.bin* \
 "
 FILES:${PN}-qcom-qcm6490-compute = "${firmwaredir}/qcom/qc[ms]6490/cdsp*.*"
@@ -2602,7 +2619,10 @@ FILES:${PN}-qcom-sm8450-audio-tplg = "${firmwaredir}/qcom/sm8450/*tplg.bin*"
 FILES:${PN}-qcom-sm8550-adreno = "${firmwaredir}/qcom/sm8550/a740_zap.mbn*"
 FILES:${PN}-qcom-sm8550-audio-tplg = "${firmwaredir}/qcom/sm8550/*tplg.bin*"
 FILES:${PN}-qcom-sm8650-adreno = "${firmwaredir}/qcom/sm8650/gen70900_zap.mbn*"
-FILES:${PN}-qcom-sm8650-audio-tplg = "${firmwaredir}/qcom/sm8650/*tplg.bin*"
+FILES:${PN}-qcom-sm8650-audio-tplg = " \
+    ${firmwaredir}/qcom/sm8650/*tplg.bin* \
+    ${firmwaredir}/qcom/sm8650/ayaneo/ps2/SM8650-APS2-tplg.bin* \
+"
 FILES:${PN}-qcom-sm8750-adreno = "${firmwaredir}/qcom/sm8750/gen80000_zap.mbn*"
 FILES:${PN}-qcom-sm8750-audio = "${firmwaredir}/qcom/sm8750/adsp*.* ${firmwaredir}/qcom/sm8750/*tplg.bin*"
 FILES:${PN}-qcom-sm8750-compute = "${firmwaredir}/qcom/sm8750/cdsp*.*"
@@ -2613,6 +2633,7 @@ FILES:${PN}-qcom-x1e80100-audio = " \
     ${firmwaredir}/qcom/x1e80100/X1E001DE-DEVKIT-tplg.bin* \
     ${firmwaredir}/qcom/x1e80100/X1E80100-CRD-tplg.bin* \
     ${firmwaredir}/qcom/x1e80100/X1E80100-EVK-tplg.bin* \
+    ${firmwaredir}/qcom/x1e80100/X1P42100-Microsoft-Surface-Pro-12in-tplg.bin* \
     ${firmwaredir}/qcom/x1e80100/X1E80100-Romulus-tplg.bin* \
     ${firmwaredir}/qcom/x1e80100/X1E80100-TUXEDO-Elite-14-tplg.bin* \
 "
@@ -2686,6 +2707,7 @@ RDEPENDS:${PN}-qcom-adreno-a740 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g705 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g709 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g715 = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-adreno-g717 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g800 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g801 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g802 = "${PN}-qcom-license"
@@ -2694,9 +2716,11 @@ RDEPENDS:${PN}-qcom-apq8016-wifi = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8096-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8096-audio = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8096-modem = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-eliza-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-glymur-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-glymur-audio = "${PN}-qcom-2-license ${PN}-linaro-license"
 RDEPENDS:${PN}-qcom-glymur-compute = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-hawi-audio = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-kaanapali-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-kaanapali-audio = "${PN}-qcom-2-license ${PN}-linaro-license"
 RDEPENDS:${PN}-qcom-kaanapali-compute = "${PN}-qcom-2-license"
@@ -2805,6 +2829,9 @@ FILES:${PN}-liquidio = "${firmwaredir}/liquidio"
 LICENSE:${PN}-mellanox = "LicenseRef-Firmware-WHENCE"
 FILES:${PN}-mellanox = "${firmwaredir}/mellanox"
 
+LICENSE:${PN}-mm8108 = "LicenseRef-Firmware-morsemicro"
+FILES:${PN}-mm8108 = "${firmwaredir}/morsemicro/mm81x/v56/*"
+
 LICENSE:${PN}-prestera = "LicenseRef-Firmware-Marvell"
 FILES:${PN}-prestera = "${firmwaredir}/mrvl/prestera"
 RDEPENDS:${PN}-prestera = "${PN}-marvell-license"
@@ -2949,7 +2976,10 @@ LICENSE:${PN}-amd-sev-license = "LicenseRef-Firmware-amd-sev"
 FILES:${PN}-amd-sev-license = "${firmwaredir}/LICENSE.amd-sev"
 
 LICENSE:${PN}-ccp = "LicenseRef-Firmware-amd-sev"
-FILES:${PN}-ccp = "${firmwaredir}/amd/amd_sev*"
+FILES:${PN}-ccp = " \
+    ${firmwaredir}/amd/amd_sev* \
+    ${firmwaredir}/amd/README* \
+"
 RDEPENDS:${PN}-ccp = "${PN}-amd-sev-license"
 
 # For amdxdna - AMD Inference processor
@@ -3592,6 +3622,7 @@ LICENSE:${PN} = "\
     AND LicenseRef-Firmware-mellanox \
     AND LicenseRef-Firmware-mga \
     AND LicenseRef-Firmware-montage \
+    AND LicenseRef-Firmware-morsemicro \
     AND LicenseRef-Firmware-moxa \
     AND LicenseRef-Firmware-myri10ge-firmware \
     AND LicenseRef-Firmware-nvidia \
-- 
2.55.0


