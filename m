Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.522.1793465157676747834
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 09:45:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Q1ty03Cm;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=RGf1WOxw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VGUMtJ2279682
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6MzDULewmP0
	uybDlNerkEqKlBmxTU0GHXtqkmYapV10=; b=Q1ty03CmeGNlha1Uum2utY0J0QY
	rVK8KtGNjjBlTu7qRgeEH4zj9lkJo0lFUgT9QQn2d5pvONkx8rfFgTc8Tj3FLfT9
	RnH1mdE1UDmVzbRoUHt8cjNRnkgZITR9t0aaDofRKDFXsyjfDVsQYKT1G8S18Pv1
	EF3pXGGCbUwIDsY1yjmwzHKSta6Pg5unoCw3m24M+6ZKVUIwT/si3UihWC/L5Meh
	IAChxBSZsrtEIfUyQH/qN6qnTdSR2vJp6IpG38dXqTRmn2HWaWNGJ3Da95C8afsy
	GVs9nUmYw6kRP7V8tkFzRLmewWkSMzzVcgDrsWR0TKqdg2aoh7HAbjmfHaQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfsnyr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e92aad34aso349005185a.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793465155; x=1794069955; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MzDULewmP0uybDlNerkEqKlBmxTU0GHXtqkmYapV10=;
        b=RGf1WOxwzkTDK58sJIHC3ErJ2F7XlbLjXBaugTgjkclrP4AS9dxNlcHQsmjjMG61Wo
         hqWFRw/na3rnFwT4SlFLzjMeeq5Z4v4w7MUMNOvFQx0hHU2Id79EmFjBXJMMU1AHBvUx
         0tF2cBADTv5VmSUThJU+tE4KHDCioDQnxJDJ4RWpVHDbteF5eLkaX0BvYTZDJQxNBBTd
         yd4NwHdvVlzY4CFWnK3m+/zoKRwF22HnEijmLg1AuFJB9OXJCjfMXVRoGn9kcA8tKT7h
         GLkSALs4hf33R+Kce+ZVclhKOsNgr/HJYcC2W/YpmmLUogNC3J7jFLSjD1hjE3oYfb1L
         ++pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465155; x=1794069955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6MzDULewmP0uybDlNerkEqKlBmxTU0GHXtqkmYapV10=;
        b=nZAQ9qGopR4bbZuL/lRuI4OtaY7NbbCFfdVmKaa3pOrNWBzJr8n6uK9UpX9kk3Q91G
         yLBwOXoFq6FlQ9KuFOHfZjZkxuT8YC2/7IMCBN0HVojFCybwevORA0aqCzpH4W/zbJRR
         zmCnod0AytgXh0w2S2aHaKNoInqoHk1v5bZQx1wWkLqQhVxLbD7N9Ntr8Cia+Of4Lwi2
         5B8xeZyiNgcF5JRD/K/CSHihR2ZS6RlF9mIWdmf5ZpIF4vl/UsnAZo7fTB/ZNeGROlJs
         pvYDyVFEj3DJX/MmztfBIjXibhC7FzEQ/RYj0Sch/b6zofzN8BCdiNqYMYwxGxAEI6wx
         m6hQ==
X-Gm-Message-State: AFq9FYLf8EE/+kICc9JhIlxHSpNGrPqg8NgIpdZcdHXtHlwKi7p9Qtpc
	/5+EYEPo1i8INx27HMd7JaRyfeSZBBjhtdv4wy76X4itK1MKGvzPl7BDixdlgYIY/KB1Nk/5cwQ
	FMOlTzF1N+zNIgQ63aPyB2F3SWlRLBtl2CPN00T4V1EN4kX0S6oy5pv1dgjvkCoYjSiPyQ/gjd5
	WwRYTGgUWopQ==
X-Gm-Gg: AYBFou3DzrbeynhsP0ioTQzZA6IEDyoXKFlf0u8bBGpqf051omh8ju+LCVq+uct2ZT3
	MrJDQC158iU2CM96gAgwkhyTublqKnF0E9xxWg5nVdZVVoZFk3effL5R/n76eUU4Hbs4Urfxv9A
	A5IJ2WN9inL8uVTdglkZ8PVUECPVsYGsUNVx4+TbhM6rCNc27DS8QKRrxw/3DSKXXpc+KR9lmba
	2m61BkcQCrP/nvjP+tfNc18DxNosIXy30rLN38p4ID9BCE0jgdoGtGUxXq11BBgG4k2mjV0VxWn
	wZ3J2/O5J6E8IttH8D5Yi8Dlf/ug2sLTyCmCUsNgO2IxNMY0ez5ftaIIfpPaaquVS1sxx5nUe6w
	MGHtxNQGjvVRSn5fDGDXLm0lHrxktKo/5545ih3PoaAzGuWh9Ac5J1dZP67fOnqk=
X-Received: by 2002:a05:620a:6009:b0:93f:1936:b1fc with SMTP id af79cd13be357-9442172adb8mr886690685a.78.1793465155276;
        Sat, 31 Oct 2026 09:45:55 -0700 (PDT)
X-Received: by 2002:a05:620a:6009:b0:93f:1936:b1fc with SMTP id af79cd13be357-9442172adb8mr886686785a.78.1793465154532;
        Sat, 31 Oct 2026 09:45:54 -0700 (PDT)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm103398055e9.0.2026.10.31.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:45:53 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>,
        Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 03/10]  linux-firmware: package qcom-shikra-wifi firmware
Date: Sat, 31 Oct 2026 16:45:36 +0000
Message-ID: <20261031164543.1668-3-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
References: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX1eG4AG/Mh1sK
 LsnUvr2o4N8zgwh+ihQzdP3iI1PNtqczLObllQ8Wg+8De2hl/xrqpRqgT2p85s/kCdyi4KLsfGJ
 PKd2iPQbdk0zXJbtqrs792yKduRlJe0=
X-Proofpoint-GUID: D88Ev5ut1ZSupdK9c9q5zmh5d4_3t_oT
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae61b44 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=Ii1caJqkCqkA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8
 a=2WMO_5KSFBI97C4CKOIA:9 a=PEH46H7Ffwr30OY-TuGO:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: D88Ev5ut1ZSupdK9c9q5zmh5d4_3t_oT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfXwXSVTB1a9Gq0
 Bf/IztexApkJ/QmGl/Oi4V9KOprIQA08a1Iy2KfTVEm/5B9/5g6OniwoEDwKDzYzk2eZDDKp/Nr
 MIpO+V9Jrm5MQsZaL7qlJnrdRr/evky/G1Fpd1GzFLG1iXfrc9PSnx2/hqAudcXJNXJH30I1oH/
 hLM1zYn5xHTF5P7EnRCvyvXevKZFKMrod1rnnOJkW9XTWDmMM7SEE/6OzFZkzq/O1xgTs9p5p2l
 vTaJeOdisITU9OhgVsAD/29bn7Zlk4hMDbU1bVEELsBLe0bOY3l63OwR5hjzk5yENFbS8LMcKJY
 KjMugnhKpe5iRQdlHcYT6mkJuPpBw/RMQqMAC+dQstAfeuReMCgV4VbYKDwL9L5R6EWsA9K6kv+
 R0LZ700sJ0SDLYRw7QU5a03vZjXtPj9MdImT/hw3NeJrIeSG8lJbJr6kAFYPcE0/p2NWdNgRblc
 IT8VdWYHedh3lNX647g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5196
Content-Type: text/plain; charset="utf-8"

From: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>

Split the Shikra-specific ath10k WCN3990 hw1.0 WiFi firmware out
of the generic linux-firmware-ath10k-wcn3990 package into its own
linux-firmware-qcom-shikra-wifi package, matching the existing
per-board split already done for QCM2290/QRB4210.

The current linux-firmware snapshot consumed by OE-Core also lacks
the qcom/shikra/wlanmdsp.mbn symlink expected by tqftpserv, which
loads WiFi firmware from the same directory as other DSP firmware.
Backport upstream commit 837ae0e5becc ("qcom/shikra: link WiFi
firmware from the ath10k subdir") so the packaged firmware can be
loaded from the expected location.

This patch can be dropped once the linux-firmware version used by
OE-Core includes commit 837ae0e5becc.

Signed-off-by: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 ...-WiFi-firmware-from-the-ath10k-subdi.patch | 28 +++++++++++++++++++
 .../linux-firmware/linux-firmware_20260916.bb |  7 ++++-
 2 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 recipes-kernel/linux-firmware/linux-firmware/0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch

diff --git a/recipes-kernel/linux-firmware/linux-firmware/0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch b/recipes-kernel/linux-firmware/linux-firmware/0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch
new file mode 100644
index 0000000..010121d
--- /dev/null
+++ b/recipes-kernel/linux-firmware/linux-firmware/0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch
@@ -0,0 +1,28 @@
+From 837ae0e5beccc2f1e974afba56c22c3cf981fc4e Mon Sep 17 00:00:00 2001
+From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+Date: Fri, 18 Sep 2026 17:52:15 +0300
+Subject: [PATCH] qcom/shikra: link WiFi firmware from the ath10k subdir
+
+On Qualcomm Shikra platform the WiFi firmware is loaded by the tqftpserv
+from the same location as the rest of the DSP firmware. Add symlink,
+pointing from the expected location to the actual WiFi firmware file.
+
+Fixes: f64d7db7d264 ("ath10k: WCN3990: hw1.0: add shikra firmware files")
+Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+Upstream-Status: Backport [https://gitlab.com/kernel-firmware/linux-firmware/-/commit/837ae0e5beccc2f1e974afba56c22c3cf981fc4e]
+---
+ WHENCE | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/WHENCE b/WHENCE
+index a712978b..053640a0 100644
+--- a/WHENCE
++++ b/WHENCE
+@@ -3825,6 +3825,7 @@ Version: WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1
+ File: ath10k/WCN3990/hw1.0/notice.txt_wlanmdsp
+ File: ath10k/WCN3990/hw1.0/shikra/firmware-5.bin
+ File: ath10k/WCN3990/hw1.0/shikra/wlanmdsp.mbn
++Link: qcom/shikra/wlanmdsp.mbn -> ../../ath10k/WCN3990/hw1.0/shikra/wlanmdsp.mbn
+ Version: WLAN.HL.3.3.7.c5-00093.2-QCAHLSWMTPL-1
+ File: ath10k/WCN3990/hw1.0/shikra/notice.txt_wlanmdsp
+ 
diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260916.bb b/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
index d09de7f..58bcebe 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
@@ -277,7 +277,7 @@ LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48ead
                     "
 # WHENCE checksum is defined separately to ease overriding it if
 # class-devupstream is selected.
-WHENCE_CHKSUM  = "286b10e604dec1e5d49c4ac688f65a2e"
+WHENCE_CHKSUM  = "376a71c7f18efcb6e6688a73c2a548c7"
 
 # These are not common licenses, set NO_GENERIC_LICENSE for them
 # so that the license files will be copied from fetched source
@@ -409,6 +409,7 @@ PE = "1"
 
 SRC_URI = "\
   ${KERNELORG_MIRROR}/linux/kernel/firmware/${BPN}-${PV}.tar.xz \
+  file://0001-qcom-shikra-link-WiFi-firmware-from-the-ath10k-subdi.patch \
 "
 
 BBCLASSEXTEND = "devupstream:target"
@@ -584,6 +585,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-atheros-license ${PN}-ar5523 ${PN}-ar9170 ${PN}-ath6k ${PN}-ath9k ${PN}-ath3k \
              ${PN}-carl9170 \
              ${PN}-qcom-qcm2290-wifi ${PN}-qcom-qrb4210-wifi ${PN}-qcom-sdm845-modem \
+             ${PN}-qcom-shikra-wifi \
              ${PN}-ar3k-license ${PN}-ar3k \
              ${PN}-ath10k-license ${PN}-ath10k \
              ${PN}-ath10k-qca4019 \
@@ -2474,6 +2476,7 @@ LICENSE:${PN}-qcom-shikra-compute = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-shikra-audio = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-shikra-modem = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-shikra-qupv3fw = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-shikra-wifi = "LicenseRef-Firmware-qualcommAthos-ath10k"
 LICENSE:${PN}-qcom-sm8150-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sm8250-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sm8250-audio = "LicenseRef-Firmware-qcom"
@@ -2654,6 +2657,7 @@ FILES:${PN}-qcom-shikra-compute = "${firmwaredir}/qcom/shikra/cdsp*.*"
 FILES:${PN}-qcom-shikra-audio = "${nonarch_base_libdir}/firmware/qcom/shikra/lpaicp*.*"
 FILES:${PN}-qcom-shikra-modem = "${nonarch_base_libdir}/firmware/qcom/shikra/cqs/qdsp6sw.mbn*"
 FILES:${PN}-qcom-shikra-qupv3fw = "${firmwaredir}/qcom/shikra/qupv3fw.elf*"
+FILES:${PN}-qcom-shikra-wifi = "${firmwaredir}/qcom/shikra/wlanmdsp.mbn* ${firmwaredir}/ath10k/WCN3990/hw1.0/shikra/*"
 FILES:${PN}-qcom-sm8150-adreno = "${firmwaredir}/qcom/sm8150/a640*.*"
 FILES:${PN}-qcom-sm8250-adreno = "${firmwaredir}/qcom/sm8250/a650*.*"
 FILES:${PN}-qcom-sm8250-audio = "${firmwaredir}/qcom/sm8250/adsp*.*"
@@ -2835,6 +2839,7 @@ RDEPENDS:${PN}-qcom-shikra-compute = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-shikra-audio = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-shikra-modem = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-shikra-qupv3fw = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-shikra-wifi = "${PN}-ath10k-license"
 RDEPENDS:${PN}-qcom-sm8150-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sm8250-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sm8250-audio = "${PN}-qcom-license"
-- 
2.56.0

