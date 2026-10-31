Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.428.1793465167249429465
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 09:46:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=I+uCRlQS;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=LH7RotI2;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VGU2G53196994
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=EFWkCr3zEBn
	BEPdEVkz0f2S4V/RP3/ymBq4aIx55sOc=; b=I+uCRlQS8/Vx5NeDnP5801CoM5V
	pTC4IZQviKc3NmGf7+QiQOP60uGLIxzIll0iRsH8lRE1+wsAICnj2vY2tLRJMDTj
	Xi4l0Zxge/0U/LJqAPH34NiLIYmMJ9H5TY7DyBMOcYhxrR3/H/YB8glVu0jMMZQI
	q3QjXVMLlOMYAHzTZlrPOdo1jBYSHnzuPno1JeNc5pMO1X2PzAT2/3F/WdMo3CUA
	mGB+flTyIzbSbeEpzwf3IOpoqcV80NbKGeHNRw5QjiSJF087M6zyJu1r46FBxX5d
	Yg/IuB7IsYEA+JmE2MvTWkw6UZJgPcYlMCYh/Mkyh48YVmOCrt+k6ADWNSQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6hq26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f6f4fe531so285594885a.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793465165; x=1794069965; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EFWkCr3zEBnBEPdEVkz0f2S4V/RP3/ymBq4aIx55sOc=;
        b=LH7RotI2xJoxxhhqYRUgTppoF1tvNJ0ZlqhMkUgaL3iyy+XElXO/DLjEsXv5XPk8Rl
         aUWkL/sqCAqoYbm2ELfXfBrSohigqv5thyKKlP/U4E2h0WqAE4Z7DDuIzMrCljSaHtM/
         eKrvpI2aAAaMLysSpt/bvxdReM2k77g8UEz4jvUZldpdyDlwUQnTiBXO1SdHNhe3W1/d
         7lJCoIiPErluEf1U3mo18BaQxUvgpLU4y6+wcnyuN1BX6I+04DnJce2oC0/xmvhSw2hy
         yPTnek0pc5pudj2oU90NhKHcdLSo0yXtZYVAczw3NSSeeO3M0sFH09zI0YRxGedCVxuJ
         te5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465165; x=1794069965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EFWkCr3zEBnBEPdEVkz0f2S4V/RP3/ymBq4aIx55sOc=;
        b=YSM+xD176ofqd/K0sg7fMwPNr7KJRk+CGisIp5B2qvFNwHJVXZZsVqmfd2khTBSmAj
         O4+UG0MFaG0JFrYvHcKnvitifI6mREauy/Y03yl7gGw2XbmXunh3wW+dWi+GlX6uZqz8
         2yk/SKufDsZO9oJxY31TfRfzkBE0+4i8JDjoKjRw6r+VOJnZxB6u1n46qPI83h2WY5wZ
         1tVBamc8FwWtjhLDlYGEriPAX//sTZ9VX7LufP62lD3/HiCMBou5sAG0/+Gvtu7/QkkZ
         3rz8Sa8n7tjx2lvsS/O5GhTeTEiCmtIc5QjlI6bgMBusf7ZqSpZtWbEjHv1m1z6Zg9PE
         TUaw==
X-Gm-Message-State: AFq9FYLr4OMa1Od+MLttpewqAU+PvjRW6iw4I0DMefo2uCVrHwu0YHa8
	r7NuQYwr4tuGzP77DR1njl+o/fJnTD9jnw/CkYNrOGI2GnBt0Lnc4RjVl8upRzvxeiFTdb+5szJ
	M7eXURDAUyApKtW9AeyZAkvO9se7iWBZaSJrFWyS5Rhd+yw9bknJ3ZAveLNo/V1SZrlNEtCCmnT
	gpsa7psiY75A==
X-Gm-Gg: AYBFou0noWr+6RCLSKwjmRLUkXGdtyOElX8xZsPrFF33UadA8f5EW1g3lll87XvnIHS
	OQfMDBwWAU19VB7rz/t3c8uDP24lfaAhtzWVNNCDm6EYz0+KdqXavABEH2hKo+G0rmacGwFvBuT
	yntMh1pPbmmG+nPL9LgAjDGVIMjX140t/HVYcc3qSfxesAOR/XZX0dJ+7nDOno9cbK1V9Qv9eir
	4d8XQcVaI9AVOcP4lFmw1jA3aBZCJBrX8WxYrYJr3HJXqNRuWqdw0Wi5iwS9NwP5pK54rdpiASl
	lfbsq9PA4gCG5YfcgbuzS0wotyKWkjino2Y6QGn4VwJuxHQzSX6SNSFU8LS+4zJM59TGLiJkkog
	uDn+dBXWgzqRXz27ic5G9gFY8Qk/o4GfMg3fYcGJr2D7U2qdWebRJYc6pgm4RO5s=
X-Received: by 2002:a05:620a:1708:b0:939:de6c:cb45 with SMTP id af79cd13be357-94421759a6emr926688985a.47.1793465164973;
        Sat, 31 Oct 2026 09:46:04 -0700 (PDT)
X-Received: by 2002:a05:620a:1708:b0:939:de6c:cb45 with SMTP id af79cd13be357-94421759a6emr926684685a.47.1793465164245;
        Sat, 31 Oct 2026 09:46:04 -0700 (PDT)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm103398055e9.0.2026.10.31.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:46:03 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Vivek Puar <vpuar@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 09/10]  linux-firmware: upgrade 20260916 -> 20261019
Date: Sat, 31 Oct 2026 16:45:42 +0000
Message-ID: <20261031164543.1668-9-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
References: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zVJKB16ovzOXNZHwsuprursV5DZvZDVC
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae61b4d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=Ii1caJqkCqkA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8
 a=VwQbUJbxAAAA:8 a=6Yq5tBWijua1UeUfxeYA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: zVJKB16ovzOXNZHwsuprursV5DZvZDVC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX+Rs2r6y7Vw7m
 3DDv1OoM8Jxytwku1Zp7YxnzsaGGywPxAa4XC9nfL/0VKf+sE3aHiRirU0GOpvfzo0mQEp6tqNv
 DzvfRQArNCgH+mAfd0PlGkC69DeLAKo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfXz/cEf6KKop35
 8PfOKSirZDbSFrO0owXKVaAwe2odeiKRY9YOEWuCX/UTmVm/4K9M1WrqM1JfqCNIoXBUUz5xa4M
 Je0H/PRE+apwfE/9ajoCt6t/owPSmxhv9o1+NPbPOHfzXRKlfdZtLNzuNbn4fTIGTolRo3memIJ
 ClQchT0QvFwy79rfOXcRcv4a7ehsEnBnyri+kVyD+0CXXdgaH0Ld8P0dNqq6zRNS0KTpWbApQ10
 oOSR99niAPT+DIKhYT6VdI0OUGy1/Z9cP0q2/+8eHkV/9eOcR9OOLB+6nvjfKApRXfZrRkkkipF
 RjqJiUxULT15KDNoQnH+Uf3136UJ0WTlllXms+O+gaOrpNwjNUDdlQSvkYtpmlzuK0dAeYBnMxN
 /p8YHrBr1BB7f6Y3StIurVfUICY+7JHsgrD/iJWUipWM170Rav7nnsveSKxIo9rPVO1/hTBB4jk
 UnI3QcCOHUXHdCA7pDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5202
Content-Type: text/plain; charset="utf-8"

From: Vivek Puar <vpuar@qti.qualcomm.com>

Upgrade the firmware package to latest release. Add PCIe3 PHY
firmware for snps-pcie3, add AIC8800D80 BT and Wi-Fi firmware,
add IW416 firmware, add ISH firmware files for Intel Nova Lake-H/S
platforms, add firmware for Architecture 14.8 Arm Mali GPU, add
board_elm.bin for RTL8852CU, also add several new Qualcomm firmware
packages.

Signed-off-by: Vivek Puar <vpuar@qti.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 ...-WiFi-firmware-from-the-ath10k-subdi.patch | 28 -------
 ...20260916.bb => linux-firmware_20261019.bb} | 75 ++++++++++++++++---
 2 files changed, 65 insertions(+), 38 deletions(-)
 delete mode 100644 recipes-kernel/linux-firmware/linux-firmware/0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch
 rename recipes-kernel/linux-firmware/{linux-firmware_20260916.bb => linux-firmware_20261019.bb} (98%)

diff --git a/recipes-kernel/linux-firmware/linux-firmware/0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch b/recipes-kernel/linux-firmware/linux-firmware/0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch
deleted file mode 100644
index 010121d..0000000
--- a/recipes-kernel/linux-firmware/linux-firmware/0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From 837ae0e5beccc2f1e974afba56c22c3cf981fc4e Mon Sep 17 00:00:00 2001
-From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
-Date: Fri, 18 Sep 2026 17:52:15 +0300
-Subject: [PATCH] qcom/shikra: link WiFi firmware from the ath10k subdir
-
-On Qualcomm Shikra platform the WiFi firmware is loaded by the tqftpserv
-from the same location as the rest of the DSP firmware. Add symlink,
-pointing from the expected location to the actual WiFi firmware file.
-
-Fixes: f64d7db7d264 ("ath10k: WCN3990: hw1.0: add shikra firmware files")
-Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
-Upstream-Status: Backport [https://gitlab.com/kernel-firmware/linux-firmware/-/commit/837ae0e5beccc2f1e974afba56c22c3cf981fc4e]
----
- WHENCE | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/WHENCE b/WHENCE
-index a712978b..053640a0 100644
---- a/WHENCE
-+++ b/WHENCE
-@@ -3825,6 +3825,7 @@ Version: WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1
- File: ath10k/WCN3990/hw1.0/notice.txt_wlanmdsp
- File: ath10k/WCN3990/hw1.0/shikra/firmware-5.bin
- File: ath10k/WCN3990/hw1.0/shikra/wlanmdsp.mbn
-+Link: qcom/shikra/wlanmdsp.mbn -> ../../ath10k/WCN3990/hw1.0/shikra/wlanmdsp.mbn
- Version: WLAN.HL.3.3.7.c5-00093.2-QCAHLSWMTPL-1
- File: ath10k/WCN3990/hw1.0/shikra/notice.txt_wlanmdsp
- 
diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260916.bb b/recipes-kernel/linux-firmware/linux-firmware_20261019.bb
similarity index 98%
rename from recipes-kernel/linux-firmware/linux-firmware_20260916.bb
rename to recipes-kernel/linux-firmware/linux-firmware_20261019.bb
index 58bcebe..d9c8d68 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20261019.bb
@@ -23,6 +23,7 @@ LICENSE = "\
     AND LicenseRef-Firmware-advansys \
     AND LicenseRef-Firmware-aeonsemi \
     AND LicenseRef-Firmware-agere \
+    AND LicenseRef-Firmware-aic \
     AND LicenseRef-Firmware-airoha \
     AND LicenseRef-Firmware-alacritech \
     AND LicenseRef-Firmware-amdgpu \
@@ -155,6 +156,7 @@ LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48ead
                     file://LICENSES/LICENCE.advansys;md5=bca735476602a7bcb187c7f8bf4a31d5 \
                     file://LICENSES/LICENSE.aeonsemi;md5=521c00bae0077c90d6ffb9ccf66905ae \
                     file://LICENSES/LICENCE.agere;md5=af0133de6b4a9b2522defd5f188afd31 \
+                    file://LICENSES/LICENSE.aic;md5=6c7daaf69662d4c8c0ba954700b3a6e1 \
                     file://LICENSES/LICENSE.airoha;md5=fa3dedb960e2673aea51aa509f7b537d \
                     file://LICENSES/LICENCE.alacritech;md5=75dabc07cc2fb59d929baa6bd6aae48a \
                     file://LICENSES/LICENSE.amdgpu;md5=1433dfea38c97a2e563a248a863dcb94 \
@@ -277,7 +279,7 @@ LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48ead
                     "
 # WHENCE checksum is defined separately to ease overriding it if
 # class-devupstream is selected.
-WHENCE_CHKSUM  = "376a71c7f18efcb6e6688a73c2a548c7"
+WHENCE_CHKSUM  = "d1b892bc13f2bc5148ce27c732ec8339"
 
 # These are not common licenses, set NO_GENERIC_LICENSE for them
 # so that the license files will be copied from fetched source
@@ -286,6 +288,7 @@ NO_GENERIC_LICENSE[Firmware-adsp-sst] = "LICENSES/LICENCE.adsp_sst"
 NO_GENERIC_LICENSE[Firmware-advansys] = "LICENSES/LICENCE.advansys"
 NO_GENERIC_LICENSE[Firmware-aeonsemi] = "LICENSES/LICENSE.aeonsemi"
 NO_GENERIC_LICENSE[Firmware-agere] = "LICENSES/LICENCE.agere"
+NO_GENERIC_LICENSE[Firmware-aic] = "LICENSES/LICENSE.aic"
 NO_GENERIC_LICENSE[Firmware-airoha] = "LICENSES/LICENSE.airoha"
 NO_GENERIC_LICENSE[Firmware-alacritech] = "LICENSES/LICENCE.alacritech"
 NO_GENERIC_LICENSE[Firmware-amdgpu] = "LICENSES/LICENSE.amdgpu"
@@ -409,7 +412,6 @@ PE = "1"
 
 SRC_URI = "\
   ${KERNELORG_MIRROR}/linux/kernel/firmware/${BPN}-${PV}.tar.xz \
-  file://0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch \
 "
 
 BBCLASSEXTEND = "devupstream:target"
@@ -417,7 +419,7 @@ SRC_URI:class-devupstream = "git://git.kernel.org/pub/scm/linux/kernel/git/firmw
 # Pin this to the 20220509 release, override this in local.conf
 SRCREV:class-devupstream ?= "b19cbdca78ab2adfd210c91be15a22568e8b8cae"
 
-SRC_URI[sha256sum] = "f80dcb757a623deda62200c08e0e1a88c76fb6b54964f31b35fa74da1c90ccc5"
+SRC_URI[sha256sum] = "a10d1ab5baf2c74ba92e8c7cf313e691696c26bddfa6df00db795e48d70cd4ca"
 
 inherit allarch
 
@@ -523,7 +525,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-moxa-license ${PN}-moxa \
              ${PN}-sd8686 ${PN}-sd8688 ${PN}-sd8787 ${PN}-sd8797 ${PN}-sd8801 \
              ${PN}-sd8887 ${PN}-sd8897 ${PN}-sd8997 ${PN}-usb8997 \
-             ${PN}-cf8381 ${PN}-cf8385 ${PN}-gspi8682 ${PN}-gspi8686 ${PN}-gspi8688 ${PN}-sd8385 ${PN}-sd8682 \
+             ${PN}-cf8381 ${PN}-cf8385 ${PN}-gspi8682 ${PN}-gspi8686 ${PN}-gspi8688 ${PN}-sd416 ${PN}-sd8385 ${PN}-sd8682 \
              ${PN}-usb8388 ${PN}-usb8682 ${PN}-sd8977 ${PN}-usb8766 ${PN}-usb8797 ${PN}-usb8801 ${PN}-usb8897 ${PN}-rvu-cptpf \
              ${PN}-mwl8k ${PN}-mwlwifi\
              ${PN}-ti-connectivity-license ${PN}-wl1251-license ${PN}-wlcommon ${PN}-wl1251 ${PN}-wl12xx ${PN}-wl18xx ${PN}-cc33xx \
@@ -612,6 +614,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-ath12k-qcc2072 \
              ${PN}-ath12k-qcn9274 \
              ${PN}-ath12k-wcn7850 \
+             ${PN}-aic-aic8800d80 ${PN}-aic-license \
              ${PN}-qca \
              ${PN}-qca-qca2066 \
              ${PN}-qca-qca61x4-serial \
@@ -658,7 +661,9 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-bnx2x \
              ${PN}-liquidio \
              ${PN}-linaro-license \
-             ${PN}-mali-csffw-arch108 ${PN}-mali-csffw-arch1010 ${PN}-mali-csffw-arch1012 ${PN}-mali-csffw-arch118 ${PN}-mali-csffw-arch128 ${PN}-mali-csffw-arch138 ${PN}-mali-csffw-license \
+             ${PN}-mali-csffw-arch108 ${PN}-mali-csffw-arch1010 ${PN}-mali-csffw-arch1012 \
+             ${PN}-mali-csffw-arch118 ${PN}-mali-csffw-arch128 ${PN}-mali-csffw-arch138 \
+             ${PN}-mali-csffw-arch148 ${PN}-mali-csffw-license \
              ${PN}-mellanox \
              ${PN}-mm8108 \
              ${PN}-nvidia-license \
@@ -694,14 +699,15 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-qcom-adreno-a702 ${PN}-qcom-adreno-a730 ${PN}-qcom-adreno-a740 \
              ${PN}-qcom-adreno-g705 ${PN}-qcom-adreno-g709 ${PN}-qcom-adreno-g715  ${PN}-qcom-adreno-g717 \
              ${PN}-qcom-adreno-g800 ${PN}-qcom-adreno-g801 ${PN}-qcom-adreno-g802 \
+             ${PN}-qcom-adreno-g811 ${PN}-qcom-adreno-g814 \
              ${PN}-qcom-apq8016-modem ${PN}-qcom-apq8016-wifi \
              ${PN}-qcom-apq8096-adreno ${PN}-qcom-apq8096-audio ${PN}-qcom-apq8096-modem \
-             ${PN}-qcom-eliza-adreno ${PN}-qcom-eliza-compute \
+             ${PN}-qcom-eliza-adreno ${PN}-qcom-eliza-audio ${PN}-qcom-eliza-compute \
              ${PN}-qcom-glymur-adreno ${PN}-qcom-glymur-audio ${PN}-qcom-glymur-compute \
-             ${PN}-qcom-hawi-audio \
+             ${PN}-qcom-hawi-adreno ${PN}-qcom-hawi-audio ${PN}-qcom-hawi-compute \
              ${PN}-qcom-kaanapali-adreno ${PN}-qcom-kaanapali-audio \
              ${PN}-qcom-kaanapali-compute ${PN}-qcom-kaanapali-soccp \
-             ${PN}-qcom-maili-audio \
+             ${PN}-qcom-maili-adreno ${PN}-qcom-maili-audio \
              ${PN}-qcom-nord-audio ${PN}-qcom-nord-compute ${PN}-qcom-nord-qupv3fw \
              ${PN}-qcom-qcm2290-adreno ${PN}-qcom-qcm2290-audio ${PN}-qcom-qcm2290-modem \
              ${PN}-qcom-qcm6490-adreno ${PN}-qcom-qcm6490-audio ${PN}-qcom-qcm6490-compute \
@@ -754,7 +760,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-qcom-x1e80100-qupv3fw \
              ${PN}-qcom-x1p42100-adreno \
              ${PN}-qla2xxx ${PN}-qla2xxx-license \
-             ${PN}-rockchip-license ${PN}-rockchip-dptx \
+             ${PN}-rockchip-license ${PN}-rockchip-dptx ${PN}-rockchip-pcie \
              ${PN}-amlogic-vdec-license ${PN}-amlogic-vdec \
              ${PN}-lt7911exc ${PN}-lt8713sx ${PN}-lt9611c ${PN}-lt9611uxc ${PN}-lontium-license \
              ${PN}-wfx-license ${PN}-wfx \
@@ -763,7 +769,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-xc5000-license ${PN}-xc5000 \
              ${PN}-xc5000c-license ${PN}-xc5000c \
              ${PN}-typhoon-license ${PN}-typhoon \
-             ${PN}-intel-license ${PN}-ish-lnlm \
+             ${PN}-intel-license ${PN}-ish-lnlm ${PN}-ish-nvlh ${PN}-ish-nvls \
              ${PN}-dell-license ${PN}-ish-lnlm-39ceeaf8 ${PN}-ish-ptl-39ceeaf8 \
              ${PN}-hp-license ${PN}-ish-lnlm-12128606 ${PN}-ish-ptl-12128606 \
              ${PN}-lenovo-license ${PN}-ish-lnlm-53c4ffad ${PN}-ish-ptl-53c4ffad \
@@ -938,6 +944,10 @@ LICENSE:${PN}-ath12k-ipq5424 = "LicenseRef-Firmware-qualcommAthos-ath10k"
 LICENSE:${PN}-ath12k-qcc2072 = "LicenseRef-Firmware-qualcommAthos-ath10k"
 LICENSE:${PN}-ath12k-qcn9274 = "LicenseRef-Firmware-qualcommAthos-ath10k"
 LICENSE:${PN}-ath12k-wcn7850 = "LicenseRef-Firmware-qualcommAthos-ath10k"
+
+LICENSE:${PN}-aic-license = "LicenseRef-Firmware-aic"
+LICENSE:${PN}-aic-aic8800d80 = "LicenseRef-Firmware-aic"
+
 LICENSE:${PN}-qca-qca2066 = "LicenseRef-Firmware-qualcommAthos-ath10k"
 LICENSE:${PN}-qca-qca61x4-serial = "LicenseRef-Firmware-qualcommAthos-ath10k"
 LICENSE:${PN}-qca-qca61x4-usb = "LicenseRef-Firmware-qualcommAthos-ath10k"
@@ -988,6 +998,9 @@ FILES:${PN}-ath12k-wcn7850 = "${firmwaredir}/ath12k/WCN7850"
 # -ath12k is a virtual package that depends upon all ath12k packages.
 ALLOW_EMPTY:${PN}-ath12k = "1"
 
+FILES:${PN}-aic-license = "${firmwaredir}/LICENSE.aic"
+FILES:${PN}-aic-aic8800d80 = "${firmwaredir}/aic/aic8800d80/*"
+
 FILES:${PN}-qca-qca2066 = " \
   ${firmwaredir}/qca/hpbtfw21.tlv* \
   ${firmwaredir}/qca/hpnv21.bin* \
@@ -1124,6 +1137,9 @@ RDEPENDS:${PN}-ath12k-ipq5424 += "${PN}-ath10k-license"
 RDEPENDS:${PN}-ath12k-qcc2072 += "${PN}-ath10k-license"
 RDEPENDS:${PN}-ath12k-qcn9274 += "${PN}-ath10k-license"
 RDEPENDS:${PN}-ath12k-wcn7850 += "${PN}-ath10k-license"
+
+RDEPENDS:${PN}-aic-aic8800d80 += "${PN}-aic-license"
+
 RDEPENDS:${PN}-qca += "${PN}-ath10k-license ${PN}-qcom-license"
 RDEPENDS:${PN}-qca-qca2066 += "${PN}-ath10k-license"
 RDEPENDS:${PN}-qca-qca61x4-serial += "${PN}-ath10k-license"
@@ -1377,6 +1393,10 @@ LICENSE:${PN}-mali-csffw-arch138 = "LicenseRef-Firmware-mali-csffw"
 FILES:${PN}-mali-csffw-arch138 = "${firmwaredir}/arm/mali/arch13.8/mali_csffw.bin*"
 RDEPENDS:${PN}-mali-csffw-arch138 += "${PN}-mali-csffw-license"
 
+LICENSE:${PN}-mali-csffw-arch148 = "LicenseRef-Firmware-mali-csffw"
+FILES:${PN}-mali-csffw-arch148 = "${firmwaredir}/arm/mali/arch14.8/mali_csffw.bin*"
+RDEPENDS:${PN}-mali-csffw-arch148 += "${PN}-mali-csffw-license"
+
 # For marvell
 LICENSE:${PN}-pcie8897 = "LicenseRef-Firmware-Marvell"
 LICENSE:${PN}-pcie8997 = "LicenseRef-Firmware-Marvell"
@@ -1394,6 +1414,7 @@ LICENSE:${PN}-cf8385 = "LicenseRef-Firmware-Marvell"
 LICENSE:${PN}-gspi8682 = "LicenseRef-Firmware-Marvell"
 LICENSE:${PN}-gspi8686 = "LicenseRef-Firmware-Marvell"
 LICENSE:${PN}-gspi8688 = "LicenseRef-Firmware-Marvell"
+LICENSE:${PN}-sd416 = "LicenseRef-Firmware-Marvell"
 LICENSE:${PN}-sd8385 = "LicenseRef-Firmware-Marvell"
 LICENSE:${PN}-sd8682 = "LicenseRef-Firmware-Marvell"
 LICENSE:${PN}-usb8388 = "LicenseRef-Firmware-Marvell"
@@ -1456,6 +1477,7 @@ FILES:${PN}-cf8385 = "${firmwaredir}/libertas/cf8385*"
 FILES:${PN}-gspi8682 = "${firmwaredir}/libertas/gspi8682*"
 FILES:${PN}-gspi8686 = "${firmwaredir}/libertas/gspi8686*"
 FILES:${PN}-gspi8688 = "${firmwaredir}/libertas/gspi8688*"
+FILES:${PN}-sd416 = "${firmwaredir}/mrvl/sdiouartiw416*"
 FILES:${PN}-sd8385 = "${firmwaredir}/libertas/sd8385*"
 FILES:${PN}-sd8682 = "${firmwaredir}/libertas/sd8682*"
 FILES:${PN}-usb8388 = "${firmwaredir}/libertas/usb8388*"
@@ -1483,6 +1505,7 @@ RDEPENDS:${PN}-cf8385 += "${PN}-marvell-license"
 RDEPENDS:${PN}-gspi8682 += "${PN}-marvell-license"
 RDEPENDS:${PN}-gspi8686 += "${PN}-marvell-license"
 RDEPENDS:${PN}-gspi8688 += "${PN}-marvell-license"
+RDEPENDS:${PN}-sd416 += "${PN}-marvell-license"
 RDEPENDS:${PN}-sd8385 += "${PN}-marvell-license"
 RDEPENDS:${PN}-sd8682 += "${PN}-marvell-license"
 RDEPENDS:${PN}-usb8388 += "${PN}-marvell-license"
@@ -1730,6 +1753,7 @@ FILES:${PN}-rtl8851 = " \
 "
 FILES:${PN}-rtl8852 = " \
     ${firmwaredir}/rtl_bt/rtl8852* \
+    ${firmwaredir}/rtw89/board_elm.bin* \
     ${firmwaredir}/rtw89/rtw8852* \
 "
 FILES:${PN}-rtl8922 = " \
@@ -2404,21 +2428,27 @@ LICENSE:${PN}-qcom-adreno-g717 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g800 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g801 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-adreno-g802 = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g811 = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-adreno-g814 = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8016-modem = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8016-wifi = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8096-audio = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8096-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-apq8096-modem = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-eliza-adreno = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-eliza-audio = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-eliza-compute = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-glymur-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-glymur-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
 LICENSE:${PN}-qcom-glymur-compute = "LicenseRef-Firmware-qcom-2"
+LICENSE:${PN}-qcom-hawi-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-hawi-audio = "LicenseRef-Firmware-qcom-2"
+LICENSE:${PN}-qcom-hawi-compute = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-kaanapali-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-kaanapali-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
 LICENSE:${PN}-qcom-kaanapali-compute = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-kaanapali-soccp = "LicenseRef-Firmware-qcom-2"
+LICENSE:${PN}-qcom-maili-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-maili-audio = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-nord-audio = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-nord-compute = "LicenseRef-Firmware-qcom-2"
@@ -2553,12 +2583,15 @@ FILES:${PN}-qcom-adreno-g717 = "${firmwaredir}/qcom/gen71700_*.*"
 FILES:${PN}-qcom-adreno-g800 = "${firmwaredir}/qcom/gen80000_*.*"
 FILES:${PN}-qcom-adreno-g801 = "${firmwaredir}/qcom/gen80100_*.*"
 FILES:${PN}-qcom-adreno-g802 = "${firmwaredir}/qcom/gen80200_*.*"
+FILES:${PN}-qcom-adreno-g811 = "${firmwaredir}/qcom/gen81100_*.*"
+FILES:${PN}-qcom-adreno-g814 = "${firmwaredir}/qcom/gen81400_*.*"
 FILES:${PN}-qcom-apq8016-modem = "${firmwaredir}/qcom/apq8016/mba.mbn* ${firmwaredir}/qcom/apq8016/modem.mbn*"
 FILES:${PN}-qcom-apq8016-wifi = "${firmwaredir}/qcom/apq8016/wcnss.mbn* ${firmwaredir}/qcom/apq8016/WCNSS*"
 FILES:${PN}-qcom-apq8096-adreno = "${firmwaredir}/qcom/apq8096/a530_zap.mbn* ${firmwaredir}/qcom/a530_zap.mdt*"
 FILES:${PN}-qcom-apq8096-audio = "${firmwaredir}/qcom/apq8096/adsp*.*"
 FILES:${PN}-qcom-apq8096-modem = "${firmwaredir}/qcom/apq8096/mba.mbn* ${firmwaredir}/qcom/apq8096/modem*.* ${firmwaredir}/qcom/apq8096/wlanmdsp.mbn*"
 FILES:${PN}-qcom-eliza-adreno = "${firmwaredir}/qcom/eliza/gen71700_zap.mbn*"
+FILES:${PN}-qcom-eliza-audio = "${firmwaredir}/qcom/eliza/adsp*.*"
 FILES:${PN}-qcom-eliza-compute = "${firmwaredir}/qcom/eliza/cdsp*.*"
 FILES:${PN}-qcom-glymur-adreno = "${firmwaredir}/qcom/glymur/gen80100_zap.mbn*"
 FILES:${PN}-qcom-glymur-audio = " \
@@ -2566,7 +2599,9 @@ FILES:${PN}-qcom-glymur-audio = " \
     ${firmwaredir}/qcom/glymur/GLYMUR-CRD-tplg.bin* \
 "
 FILES:${PN}-qcom-glymur-compute = "${firmwaredir}/qcom/glymur/cdsp*.*"
+FILES:${PN}-qcom-hawi-adreno = "${firmwaredir}/qcom/hawi/gen81100_zap.mbn*"
 FILES:${PN}-qcom-hawi-audio = "${firmwaredir}/qcom/hawi/adsp*.*"
+FILES:${PN}-qcom-hawi-compute = "${firmwaredir}/qcom/hawi/cdsp*.*"
 FILES:${PN}-qcom-kaanapali-adreno = "${firmwaredir}/qcom/kaanapali/gen80200_zap.mbn*"
 FILES:${PN}-qcom-kaanapali-audio = " \
     ${firmwaredir}/qcom/kaanapali/adsp*.* \
@@ -2574,6 +2609,7 @@ FILES:${PN}-qcom-kaanapali-audio = " \
 "
 FILES:${PN}-qcom-kaanapali-compute = "${firmwaredir}/qcom/kaanapali/cdsp*.*"
 FILES:${PN}-qcom-kaanapali-soccp = "${firmwaredir}/qcom/kaanapali/soccp*.*"
+FILES:${PN}-qcom-maili-adreno = "${firmwaredir}/qcom/maili/gen81400_zap.mbn*"
 FILES:${PN}-qcom-maili-audio = "${firmwaredir}/qcom/maili/adsp*.*"
 FILES:${PN}-qcom-nord-audio = "${firmwaredir}/qcom/nord/adsp*.*"
 FILES:${PN}-qcom-nord-compute = "${firmwaredir}/qcom/nord/cdsp*.*"
@@ -2761,21 +2797,27 @@ RDEPENDS:${PN}-qcom-adreno-g717 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g800 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g801 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-adreno-g802 = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-adreno-g811 = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-adreno-g814 = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8016-modem = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8016-wifi = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8096-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8096-audio = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-apq8096-modem = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-eliza-adreno = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-eliza-audio = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-eliza-compute = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-glymur-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-glymur-audio = "${PN}-qcom-2-license ${PN}-linaro-license"
 RDEPENDS:${PN}-qcom-glymur-compute = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-hawi-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-hawi-audio = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-hawi-compute = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-kaanapali-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-kaanapali-audio = "${PN}-qcom-2-license ${PN}-linaro-license"
 RDEPENDS:${PN}-qcom-kaanapali-compute = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-kaanapali-soccp = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-maili-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-maili-audio = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-nord-audio = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-nord-compute = "${PN}-qcom-2-license"
@@ -2902,6 +2944,10 @@ FILES:${PN}-rockchip-license = "${firmwaredir}/LICENCE.rockchip"
 FILES:${PN}-rockchip-dptx = "${firmwaredir}/rockchip/dptx.bin*"
 RDEPENDS:${PN}-rockchip-dptx = "${PN}-rockchip-license"
 
+LICENSE:${PN}-rockchip-pcie = "LicenseRef-Firmware-rockchip"
+FILES:${PN}-rockchip-pcie = "${firmwaredir}/rockchip/pcie3-t22-c8g2-1.6.3-202a-p7.fw*"
+RDEPENDS:${PN}-rockchip-pcie = "${PN}-rockchip-license"
+
 # For Amlogic VDEC
 LICENSE:${PN}-amlogic-vdec = "LicenseRef-Firmware-amlogic-vdec"
 FILES:${PN}-amlogic-vdec-license = "${firmwaredir}/LICENSE.amlogic_vdec"
@@ -2923,6 +2969,14 @@ LICENSE:${PN}-ish-lnlm = "LicenseRef-Firmware-intel"
 FILES:${PN}-ish-lnlm = "${firmwaredir}/intel/ish/ish_lnlm.bin*"
 RDEPENDS:${PN}-ish-lnlm = "${PN}-intel-license"
 
+LICENSE:${PN}-ish-nvlh = "LicenseRef-Firmware-intel"
+FILES:${PN}-ish-nvlh = "${firmwaredir}/intel/ish/ish_nvlh.bin*"
+RDEPENDS:${PN}-ish-nvlh = "${PN}-intel-license"
+
+LICENSE:${PN}-ish-nvls = "LicenseRef-Firmware-intel"
+FILES:${PN}-ish-nvls = "${firmwaredir}/intel/ish/ish_nvls.bin*"
+RDEPENDS:${PN}-ish-nvls = "${PN}-intel-license"
+
 # For Dell ish - Intel Integrated Sensor Hub
 LICENSE:${PN}-dell-license = "LicenseRef-Firmware-dell"
 FILES:${PN}-dell-license = "${firmwaredir}/LICENSE.dell"
@@ -3631,6 +3685,7 @@ LICENSE:${PN} = "\
     LicenseRef-Firmware-Abilis \
     AND LicenseRef-Firmware-aeonsemi \
     AND LicenseRef-Firmware-agere \
+    AND LicenseRef-Firmware-aic \
     AND LicenseRef-Firmware-airoha \
     AND LicenseRef-Firmware-alacritech \
     AND LicenseRef-Firmware-amdgpu \
-- 
2.56.0

