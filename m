Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB22C5DF67
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 10:50:06 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10288.1786704599323094533
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Aug 2026 03:49:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=kxJPkU5S;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=P8vk7jIG;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAb5AG1467159
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+1dw0RR3Pss
	MbkIzmrN3I09P2FLKko1v9UDVYNfIvn4=; b=kxJPkU5S1/No6OYc66+BkoKZ0XT
	2Hqfi3mFkkkjPIf6dquiZSE0aKwB2yQCQr7R/3JSbYTqspB0C1631G+yVoX4B7U0
	AD1v8y/LxUha7FgtcZF7ue+YdDJyUBmXPGgaQPwcPYFhN3Wz91e/+An6ZT47KUIv
	375sAmn3wd+POM3JlBdZIVUycrNNR1sGc/nXv4BcOLvbR3LozMUG0/ZA4Qdz/ydg
	FVnVUy278hmTiWN9pGggYj89iMjRgMUyJccLo83n4m8d1Z59pfA3GZtRbdTAGfrN
	b6mfME/yj0qeIvz8vQ1n432noHIFO2K66An1NE9Xdqn621Eqrw1PuN1jyOw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1xexgtmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bf321d786so13718871cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786704598; x=1787309398; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+1dw0RR3PssMbkIzmrN3I09P2FLKko1v9UDVYNfIvn4=;
        b=P8vk7jIG6r0TQbg0vGjd1oHpjhmafGyFMNfvpg/cj3aFqIb5geSjZ36S04ynMJYLH7
         PrdxzLujRk6I8WR1245ybZXwBTx3LIhGNUi/mA3bi8iHeztICgS3L5LXl13x9R5ezsqY
         ecmCL+6xktYJbIYsPZsQgvW+6oqWV2YM5mEjjfJEiRuRsdQTJNFW+nAjf3nrRJor4cYG
         YfP3YFRP+w/m6+kGLPmhloSCbfalm3pgGnCnQJTJRs/CBAe27IF0nQL4QsxTHm6FvKUw
         ubEXj0/3yOuL9XgiIyhUL9ImXIvYEI9sXT2elJDhrk7CNHAz2jTJmJO5CHtFzKjMYp38
         xw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704598; x=1787309398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+1dw0RR3PssMbkIzmrN3I09P2FLKko1v9UDVYNfIvn4=;
        b=eLKxpFjGT4A27q6uyOA8ZG2GPBmvw1yQVpvjQn6Xw6+U2HgP4piS7z1rHRWkNuNztu
         Q8eOgUQ3xmUkFEujfQ2ulmVf6Tv6dKufoV2obz+4OdR0iWJY1cCxyc5YM3wPG6Eu/Fn9
         X6uTt6+FPvfyIUXUFZRp7LUqKlfd3niErQTQMM9leQlX7SElg2FiYiYNqAyREpjug/PC
         KhpKIm516XVIVeWbCpLW5pne8GBX4rd10MLvtKY9Lo38drG+kiHI5P/qNQPrsjXAx2oA
         atHIyi//9cwmGS44/Ac1do5gFC5p0FZP7Vl/AWlJ7D4hfrHTMAjCTw8D6/iQyMxvRzBl
         rfHg==
X-Gm-Message-State: AOJu0Yz7ZSTUM5pHLo2WYEA+z+8K890vLNfC6bYaT1V22BmFF+vcQ+R/
	ajzkCNSrCcR6EaFUXUWsnQLRwqUjovci1JV3S9MJCilt/ohCTl3ZepcbP913tazdalgXSs7w24h
	CKRzBMg/EkByY4cDFSilXfDch0RSbB0zLhUNqUapvvvTGwLp2hjSeOHAHD+Ds6SHH8XfxsblmFE
	LkiGt+Hk5n8A==
X-Gm-Gg: AR+sD11QtELomXEIikG+n22/PyzBGytcEkrrBnJnud/xa0XS8PVd/ysIbMZeLwcTzq4
	OZN1KoB4vbfthTF7CPdavpsvF9iSHUOX9mWUK31i2X4PqpdN8G6EO5UrBp3N0wNS3qHxUbpoK3N
	HLSHnGwZr41PdKEz0im7H3Vgizzti4FoWnjXvShbrCMYmk+CGLHhpxgligRClZYaacwb8rjySeh
	tcvuBpbQMP/JV++/kWRpV97WUhWiDqE3SAjOnvHvrxLR3LgyhZNeLUSsLl2pf6yNsof0IbfnP0w
	G5o+dyZPz/IWlRS+9x7L0p7VyP/5GAHtyPdTSHhsNfwFeiRlsl+cSb/xHSStWqf1GGG9O+LESYe
	a2UTc3ysPdUA+v44=
X-Received: by 2002:a05:622a:4d9a:b0:51c:2340:bbdb with SMTP id d75a77b69052e-52d85430e9emr53087821cf.26.1786704595981;
        Fri, 14 Aug 2026 03:49:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4d9a:b0:51c:2340:bbdb with SMTP id d75a77b69052e-52d85430e9emr53086201cf.26.1786704594053;
        Fri, 14 Aug 2026 03:49:54 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm7064102f8f.32.2026.08.14.03.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:49:52 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 4/5] linux-firmware: fix license syntax
Date: Fri, 14 Aug 2026 11:49:42 +0100
Message-ID: <20260814104943.3261-4-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814104943.3261-1-jose.quaresma@oss.qualcomm.com>
References: <20260814104943.3261-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MiBTYWx0ZWRfX+LQGZ2eDOKE9
 6RMyLdlX+wdOEGvRNRntJNLuVL2YNRG0IpC6T7GhLA0FHf2pAjGVFdhuBGaRA31eZKevnoAfk6T
 DhDlh8Bpz7ykNsC+M8A2KXW+RN2Bxyc=
X-Proofpoint-GUID: RqgDGw5HZQF0GETqCPzg7CP8hjYhXca7
X-Authority-Analysis: v=2.4 cv=eO4jSnp1 c=1 sm=1 tr=0 ts=6a7ef2d6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=9xgHY9PyQrZUASkbXSIA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MiBTYWx0ZWRfXwXgQ6V59MLul
 vF628c6WsUsuGPHI621UhLRr4PAW5cJd9oPNveLxH8b22lzhLhrkOMhAcK1BsBEuVaZjC2zes8g
 tOP8BxATUCDRg80a9I5YFUEoOSyKsX+PT/f6Pnltuzufybca20wZ/dGztDlGwyKDO5P0+/KGYV1
 22uJbc8trxWXJndYckMwebuj1xKWLOAejHb61rfbT1S3kUednA6+ajdRwkxzkGduAnaNZZK6PY/
 hVrVs9hBug61INTQVAzXRTxeqDAj3KcpO3XpktTtL2fHDayCIVe/IeBh9ocUa8bH4wxbLXheORj
 d/HIBKpZFiG50baGkaaZ8GRGSEj/ljzHwfnEz5HM6qSg9UsbdLzHhYhEWo3BniYeUJmdDD+50rt
 bUBIsU2m1PFO+15cG7G6M6bIDgVa6qEK9lnPMq9TKi3/RThfThafcXjJxfZRh/SOIlVyx/UfUxP
 tL77Mb0O91h02gCkNYA==
X-Proofpoint-ORIG-GUID: RqgDGw5HZQF0GETqCPzg7CP8hjYhXca7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140082
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:50:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4663

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 .../linux-firmware/linux-firmware_20260810.bb | 1620 ++++++++---------
 1 file changed, 810 insertions(+), 810 deletions(-)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260810.bb b/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
index afaaff7..5462412 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
@@ -18,136 +18,136 @@ REMOVE_UNLICENSED += "yamaha/yss225_registers.bin"
 
 
 LICENSE = "\
-    LicenseRef-Firmware-Abilis \
-    AND LicenseRef-Firmware-adsp-sst \
-    AND LicenseRef-Firmware-advansys \
-    AND LicenseRef-Firmware-aeonsemi \
-    AND LicenseRef-Firmware-agere \
-    AND LicenseRef-Firmware-airoha \
-    AND LicenseRef-Firmware-alacritech \
-    AND LicenseRef-Firmware-amdgpu \
-    AND LicenseRef-Firmware-amdisp \
-    AND LicenseRef-Firmware-amdnpu \
-    AND LicenseRef-Firmware-amd-pmf \
-    AND LicenseRef-Firmware-amd-sev \
-    AND LicenseRef-Firmware-amd-ucode \
-    AND LicenseRef-Firmware-amlogic \
-    AND LicenseRef-Firmware-amlogic-vdec \
-    AND LicenseRef-Firmware-amphion-vpu \
-    AND LicenseRef-Firmware-atheros-firmware \
-    AND LicenseRef-Firmware-atmel \
-    AND LicenseRef-Firmware-bfa \
-    AND LicenseRef-Firmware-bmi260 \
-    AND LicenseRef-Firmware-bnx2 \
-    AND LicenseRef-Firmware-bnx2x \
-    AND LicenseRef-Firmware-broadcom-bcm43xx \
-    AND LicenseRef-Firmware-ca0132 \
-    AND LicenseRef-Firmware-cadence \
-    AND LicenseRef-Firmware-cavium \
-    AND LicenseRef-Firmware-chelsio-firmware \
-    AND LicenseRef-Firmware-cirrus \
-    AND LicenseRef-Firmware-cnm \
-    AND LicenseRef-Firmware-conexant \
-    AND LicenseRef-Firmware-cw1200 \
-    AND LicenseRef-Firmware-cw1200-sdd \
-    AND LicenseRef-Firmware-cxgb3 \
-    AND LicenseRef-Firmware-cypress \
-    AND LicenseRef-Firmware-dabusb \
-    AND LicenseRef-Firmware-dell \
-    AND LicenseRef-Firmware-dib0700 \
-    AND LicenseRef-Firmware-drxk \
-    AND LicenseRef-Firmware-e100 \
-    AND LicenseRef-Firmware-emi26 \
-    AND LicenseRef-Firmware-ene-firmware \
-    AND LicenseRef-Firmware-fw-sst-0f28 \
-    AND LicenseRef-Firmware-go7007 \
-    AND LicenseRef-Firmware-hfi1-firmware \
-    AND LicenseRef-Firmware-HP \
-    AND LicenseRef-Firmware-i915 \
-    AND LicenseRef-Firmware-ib-qib \
-    AND LicenseRef-Firmware-ibt-firmware \
-    AND LicenseRef-Firmware-ice \
-    AND LicenseRef-Firmware-ice-enhanced \
-    AND LicenseRef-Firmware-inside-secure \
-    AND LicenseRef-Firmware-intel \
-    AND LicenseRef-Firmware-intel-vpu \
-    AND LicenseRef-Firmware-ipu3-firmware \
-    AND LicenseRef-Firmware-it913x \
-    AND LicenseRef-Firmware-ivsc \
-    AND LicenseRef-Firmware-iwlwifi-firmware \
-    AND LicenseRef-Firmware-ixp4xx \
-    AND LicenseRef-Firmware-IntcSST2 \
-    AND LicenseRef-Firmware-kaweth \
-    AND LicenseRef-Firmware-keyspan \
-    AND LicenseRef-Firmware-lenovo \
-    AND LicenseRef-Firmware-linaro \
-    AND LicenseRef-Firmware-Lontium \
-    AND LicenseRef-Firmware-mali-csffw \
-    AND LicenseRef-Firmware-Marvell \
-    AND LicenseRef-Firmware-mediatek \
-    AND LicenseRef-Firmware-mellanox \
-    AND LicenseRef-Firmware-mga \
-    AND LicenseRef-Firmware-microchip \
-    AND LicenseRef-Firmware-montage \
-    AND LicenseRef-Firmware-morsemicro \
-    AND LicenseRef-Firmware-moxa \
-    AND LicenseRef-Firmware-myri10ge-firmware \
-    AND LicenseRef-Firmware-netronome \
-    AND LicenseRef-Firmware-nvidia \
-    AND LicenseRef-Firmware-nxp \
-    AND LicenseRef-Firmware-nxp-mc-firmware \
-    AND LicenseRef-Firmware-OLPC \
-    AND LicenseRef-Firmware-ath9k-htc \
-    AND LicenseRef-Firmware-phanfw \
-    AND LicenseRef-Firmware-powervr \
-    AND LicenseRef-Firmware-qat \
-    AND LicenseRef-Firmware-qcom \
-    AND LicenseRef-Firmware-qcom-2 \
-    AND LicenseRef-Firmware-qcom-yamato \
-    AND LicenseRef-Firmware-qed \
-    AND LicenseRef-Firmware-qla1280 \
-    AND LicenseRef-Firmware-qla2xxx \
-    AND LicenseRef-Firmware-qualcommAthos-ar3k \
-    AND LicenseRef-Firmware-qualcommAthos-ath10k \
-    AND LicenseRef-Firmware-r8169 \
-    AND LicenseRef-Firmware-r8a779x-usb3 \
-    AND LicenseRef-Firmware-radeon \
-    AND LicenseRef-Firmware-ralink-a-mediatek-company-firmware \
-    AND LicenseRef-Firmware-ralink-firmware \
-    AND LicenseRef-Firmware-r8a779g-pcie-phy \
-    AND LicenseRef-Firmware-rockchip \
-    AND LicenseRef-Firmware-rp2 \
-    AND LicenseRef-Firmware-rsi \
-    AND LicenseRef-Firmware-rt1320 \
-    AND LicenseRef-Firmware-rtlwifi-firmware \
-    AND LicenseRef-Firmware-imx-sdma-firmware \
-    AND LicenseRef-Firmware-s5p-mfc \
-    AND LicenseRef-Firmware-sensoray \
-    AND LicenseRef-Firmware-siano \
-    AND LicenseRef-Firmware-tehuti \
-    AND LicenseRef-Firmware-ti-connectivity \
-    AND LicenseRef-Firmware-ti-keystone \
-    AND LicenseRef-Firmware-ti-tspa \
-    AND LicenseRef-Firmware-tigon \
-    AND LicenseRef-Firmware-tlg2300 \
-    AND LicenseRef-Firmware-typhoon \
-    AND LicenseRef-Firmware-ueagle-atm4-firmware \
-    AND LicenseRef-Firmware-via-vt6656 \
-    AND LicenseRef-Firmware-vxge \
-    AND LicenseRef-Firmware-wfx \
-    AND LicenseRef-Firmware-wl1251 \
-    AND LicenseRef-Firmware-xc4000 \
-    AND LicenseRef-Firmware-xc5000 \
-    AND LicenseRef-Firmware-xc5000c \
-    AND LicenseRef-Firmware-xe \
-    AND LicenseRef-Firmware-WHENCE \
-    AND GPL-1.0-only \
-    AND GPL-2.0-or-later \
-    AND GPL-2.0-only \
-    AND GPL-3.0-only \
-    AND MPL-1.1 \
-    AND Apache-2.0 \
-    AND MIT \
+    Firmware-Abilis \
+    & Firmware-adsp-sst \
+    & Firmware-advansys \
+    & Firmware-aeonsemi \
+    & Firmware-agere \
+    & Firmware-airoha \
+    & Firmware-alacritech \
+    & Firmware-amdgpu \
+    & Firmware-amdisp \
+    & Firmware-amdnpu \
+    & Firmware-amd-pmf \
+    & Firmware-amd-sev \
+    & Firmware-amd-ucode \
+    & Firmware-amlogic \
+    & Firmware-amlogic-vdec \
+    & Firmware-amphion-vpu \
+    & Firmware-atheros-firmware \
+    & Firmware-atmel \
+    & Firmware-bfa \
+    & Firmware-bmi260 \
+    & Firmware-bnx2 \
+    & Firmware-bnx2x \
+    & Firmware-broadcom-bcm43xx \
+    & Firmware-ca0132 \
+    & Firmware-cadence \
+    & Firmware-cavium \
+    & Firmware-chelsio-firmware \
+    & Firmware-cirrus \
+    & Firmware-cnm \
+    & Firmware-conexant \
+    & Firmware-cw1200 \
+    & Firmware-cw1200-sdd \
+    & Firmware-cxgb3 \
+    & Firmware-cypress \
+    & Firmware-dabusb \
+    & Firmware-dell \
+    & Firmware-dib0700 \
+    & Firmware-drxk \
+    & Firmware-e100 \
+    & Firmware-emi26 \
+    & Firmware-ene-firmware \
+    & Firmware-fw-sst-0f28 \
+    & Firmware-go7007 \
+    & Firmware-hfi1-firmware \
+    & Firmware-HP \
+    & Firmware-i915 \
+    & Firmware-ib-qib \
+    & Firmware-ibt-firmware \
+    & Firmware-ice \
+    & Firmware-ice-enhanced \
+    & Firmware-inside-secure \
+    & Firmware-intel \
+    & Firmware-intel-vpu \
+    & Firmware-ipu3-firmware \
+    & Firmware-it913x \
+    & Firmware-ivsc \
+    & Firmware-iwlwifi-firmware \
+    & Firmware-ixp4xx \
+    & Firmware-IntcSST2 \
+    & Firmware-kaweth \
+    & Firmware-keyspan \
+    & Firmware-lenovo \
+    & Firmware-linaro \
+    & Firmware-Lontium \
+    & Firmware-mali-csffw \
+    & Firmware-Marvell \
+    & Firmware-mediatek \
+    & Firmware-mellanox \
+    & Firmware-mga \
+    & Firmware-microchip \
+    & Firmware-montage \
+    & Firmware-morsemicro \
+    & Firmware-moxa \
+    & Firmware-myri10ge-firmware \
+    & Firmware-netronome \
+    & Firmware-nvidia \
+    & Firmware-nxp \
+    & Firmware-nxp-mc-firmware \
+    & Firmware-OLPC \
+    & Firmware-ath9k-htc \
+    & Firmware-phanfw \
+    & Firmware-powervr \
+    & Firmware-qat \
+    & Firmware-qcom \
+    & Firmware-qcom-2 \
+    & Firmware-qcom-yamato \
+    & Firmware-qed \
+    & Firmware-qla1280 \
+    & Firmware-qla2xxx \
+    & Firmware-qualcommAthos-ar3k \
+    & Firmware-qualcommAthos-ath10k \
+    & Firmware-r8169 \
+    & Firmware-r8a779x-usb3 \
+    & Firmware-radeon \
+    & Firmware-ralink-a-mediatek-company-firmware \
+    & Firmware-ralink-firmware \
+    & Firmware-r8a779g-pcie-phy \
+    & Firmware-rockchip \
+    & Firmware-rp2 \
+    & Firmware-rsi \
+    & Firmware-rt1320 \
+    & Firmware-rtlwifi-firmware \
+    & Firmware-imx-sdma-firmware \
+    & Firmware-s5p-mfc \
+    & Firmware-sensoray \
+    & Firmware-siano \
+    & Firmware-tehuti \
+    & Firmware-ti-connectivity \
+    & Firmware-ti-keystone \
+    & Firmware-ti-tspa \
+    & Firmware-tigon \
+    & Firmware-tlg2300 \
+    & Firmware-typhoon \
+    & Firmware-ueagle-atm4-firmware \
+    & Firmware-via-vt6656 \
+    & Firmware-vxge \
+    & Firmware-wfx \
+    & Firmware-wl1251 \
+    & Firmware-xc4000 \
+    & Firmware-xc5000 \
+    & Firmware-xc5000c \
+    & Firmware-xe \
+    & Firmware-WHENCE \
+    & GPL-1.0-only \
+    & GPL-2.0-or-later \
+    & GPL-2.0-only \
+    & GPL-3.0-only \
+    & MPL-1.1 \
+    & Apache-2.0 \
+    & MIT \
 "
 
 LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48eadc22b8bc \
@@ -838,8 +838,8 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              "
 
 # For Amphion VPU
-LICENSE:${PN}-amphion-vpu = "LicenseRef-Firmware-amphion-vpu"
-LICENSE:${PN}-amphion-vpu-license = "LicenseRef-Firmware-amphion-vpu"
+LICENSE:${PN}-amphion-vpu = "Firmware-amphion-vpu"
+LICENSE:${PN}-amphion-vpu-license = "Firmware-amphion-vpu"
 
 FILES:${PN}-amphion-vpu = "${firmwaredir}/amphion/*"
 FILES:${PN}-amphion-vpu-license = " \
@@ -848,8 +848,8 @@ FILES:${PN}-amphion-vpu-license = " \
 RDEPENDS:${PN}-amphion-vpu += "${PN}-amphion-vpu-license"
 
 # For cw1200
-LICENSE:${PN}-cw1200 = "LicenseRef-Firmware-cw1200"
-LICENSE:${PN}-cw1200-license = "LicenseRef-Firmware-cw1200"
+LICENSE:${PN}-cw1200 = "Firmware-cw1200"
+LICENSE:${PN}-cw1200-license = "Firmware-cw1200"
 
 FILES:${PN}-cw1200 = " \
     ${firmwaredir}/sdd_sagrad_1091_1098.bin* \
@@ -860,12 +860,12 @@ FILES:${PN}-cw1200-license = "${firmwaredir}/LICENCE.cw1200"
 RDEPENDS:${PN}-cw1200 += "${PN}-cw1200-license"
 
 # For atheros
-LICENSE:${PN}-ar5523 = "LicenseRef-Firmware-atheros-firmware"
-LICENSE:${PN}-ar9170 = "LicenseRef-Firmware-atheros-firmware"
-LICENSE:${PN}-ath3k = "LicenseRef-Firmware-atheros-firmware"
-LICENSE:${PN}-ath6k = "LicenseRef-Firmware-atheros-firmware"
-LICENSE:${PN}-ath9k = "LicenseRef-Firmware-atheros-firmware"
-LICENSE:${PN}-atheros-license = "LicenseRef-Firmware-atheros-firmware"
+LICENSE:${PN}-ar5523 = "Firmware-atheros-firmware"
+LICENSE:${PN}-ar9170 = "Firmware-atheros-firmware"
+LICENSE:${PN}-ath3k = "Firmware-atheros-firmware"
+LICENSE:${PN}-ath6k = "Firmware-atheros-firmware"
+LICENSE:${PN}-ath9k = "Firmware-atheros-firmware"
+LICENSE:${PN}-atheros-license = "Firmware-atheros-firmware"
 
 FILES:${PN}-atheros-license = "${firmwaredir}/LICENCE.atheros_firmware"
 FILES:${PN}-ar5523 = " \
@@ -902,46 +902,46 @@ FILES:${PN}-carl9170 = " \
 LICENSE:${PN}-carl9170 = "GPL-2.0-or-later"
 
 # For QualCommAthos
-LICENSE:${PN}-ar3k = "LicenseRef-Firmware-qualcommAthos-ar3k AND LicenseRef-Firmware-atheros-firmware"
-LICENSE:${PN}-ar3k-license = "LicenseRef-Firmware-qualcommAthos-ar3k"
-LICENSE:${PN}-ath10k = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-qca4019 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-qca6174 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-qca9377 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-qca9887 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-qca9888 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-qca988x = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-qca9984 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-qca99x0 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-wcn3990 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath10k-license = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-ipq5018 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-ipq6018 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-ipq8074 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-qca2066 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-qca6390 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-qca6698aq = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-qcn9074 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-wcn6750 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath11k-wcn6855 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath12k = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath12k-ipq5424 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath12k-qcc2072 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath12k-qcn9274 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-ath12k-wcn7850 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-qca2066 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-qca61x4-serial = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-qca61x4-usb = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-qca6390 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-qca6698 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-qcc2072 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-wcn3950 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qca-wcn3988 = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qca-wcn399x = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-wcn6750 = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-wcn685x = "LicenseRef-Firmware-qualcommAthos-ath10k"
-LICENSE:${PN}-qca-wcn7850 = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-ar3k = "Firmware-qualcommAthos-ar3k & Firmware-atheros-firmware"
+LICENSE:${PN}-ar3k-license = "Firmware-qualcommAthos-ar3k"
+LICENSE:${PN}-ath10k = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-qca4019 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-qca6174 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-qca9377 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-qca9887 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-qca9888 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-qca988x = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-qca9984 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-qca99x0 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-wcn3990 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath10k-license = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-ipq5018 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-ipq6018 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-ipq8074 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-qca2066 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-qca6390 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-qca6698aq = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-qcn9074 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-wcn6750 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath11k-wcn6855 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath12k = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath12k-ipq5424 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath12k-qcc2072 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath12k-qcn9274 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-ath12k-wcn7850 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-qca2066 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-qca61x4-serial = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-qca61x4-usb = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-qca6390 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-qca6698 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-qcc2072 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-wcn3950 = "Firmware-qcom"
+LICENSE:${PN}-qca-wcn3988 = "Firmware-qcom"
+LICENSE:${PN}-qca-wcn399x = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-wcn6750 = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-wcn685x = "Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-qca-wcn7850 = "Firmware-qcom"
 
 FILES:${PN}-ar3k-license = "${firmwaredir}/LICENSE.QualcommAtheros_ar3k"
 FILES:${PN}-ar3k = " \
@@ -1125,8 +1125,8 @@ RDEPENDS:${PN}-qca-wcn6750 += "${PN}-ath10k-license"
 RDEPENDS:${PN}-qca-wcn685x += "${PN}-ath10k-license"
 RDEPENDS:${PN}-qca-wcn7850 += "${PN}-qcom-license"
 # For ralink
-LICENSE:${PN}-ralink = "LicenseRef-Firmware-ralink-firmware"
-LICENSE:${PN}-ralink-license = "LicenseRef-Firmware-ralink-firmware"
+LICENSE:${PN}-ralink = "Firmware-ralink-firmware"
+LICENSE:${PN}-ralink-license = "Firmware-ralink-firmware"
 
 FILES:${PN}-ralink-license = "${firmwaredir}/LICENCE.ralink-firmware.txt"
 FILES:${PN}-ralink = " \
@@ -1136,10 +1136,10 @@ FILES:${PN}-ralink = " \
 RDEPENDS:${PN}-ralink += "${PN}-ralink-license"
 
 # For mediatek MT7601U
-LICENSE:${PN}-mt76x-license = "LicenseRef-Firmware-ralink-a-mediatek-company-firmware"
+LICENSE:${PN}-mt76x-license = "Firmware-ralink-a-mediatek-company-firmware"
 FILES:${PN}-mt76x-license = "${firmwaredir}/LICENCE.ralink_a_mediatek_company_firmware"
 
-LICENSE:${PN}-mt7601u = "LicenseRef-Firmware-ralink-a-mediatek-company-firmware"
+LICENSE:${PN}-mt7601u = "Firmware-ralink-a-mediatek-company-firmware"
 
 FILES:${PN}-mt7601u = " \
   ${firmwaredir}/mediatek/mt7601u.bin* \
@@ -1148,7 +1148,7 @@ FILES:${PN}-mt7601u = " \
 RDEPENDS:${PN}-mt7601u += "${PN}-mt76x-license"
 
 # For MediaTek Bluetooth USB driver 7650
-LICENSE:${PN}-mt7650 = "LicenseRef-Firmware-ralink-a-mediatek-company-firmware"
+LICENSE:${PN}-mt7650 = "Firmware-ralink-a-mediatek-company-firmware"
 
 FILES:${PN}-mt7650 = " \
   ${firmwaredir}/mediatek/mt7650.bin* \
@@ -1157,7 +1157,7 @@ FILES:${PN}-mt7650 = " \
 RDEPENDS:${PN}-mt7650 += "${PN}-mt76x-license"
 
 # For MediaTek MT76x2 Wireless MACs
-LICENSE:${PN}-mt76x2 = "LicenseRef-Firmware-ralink-a-mediatek-company-firmware"
+LICENSE:${PN}-mt76x2 = "Firmware-ralink-a-mediatek-company-firmware"
 
 FILES:${PN}-mt76x2 = " \
   ${firmwaredir}/mediatek/mt7662.bin* \
@@ -1168,7 +1168,7 @@ FILES:${PN}-mt76x2 = " \
 RDEPENDS:${PN}-mt76x2 += "${PN}-mt76x-license"
 
 # MediaTek MT7996/MT7992/MT7990 (mt7996e.ko)
-LICENSE:${PN}-mt7996 = "LicenseRef-Firmware-mediatek"
+LICENSE:${PN}-mt7996 = "Firmware-mediatek"
 
 FILES:${PN}-mt7996 = " \
   ${firmwaredir}/mediatek/mt7996 \
@@ -1176,8 +1176,8 @@ FILES:${PN}-mt7996 = " \
 RDEPENDS:${PN}-mt7996 += "${PN}-mediatek-license"
 
 # For MediaTek
-LICENSE:${PN}-mediatek = "LicenseRef-Firmware-mediatek"
-LICENSE:${PN}-mediatek-license = "LicenseRef-Firmware-mediatek"
+LICENSE:${PN}-mediatek = "Firmware-mediatek"
+LICENSE:${PN}-mediatek-license = "Firmware-mediatek"
 
 FILES:${PN}-mediatek = " \
   ${firmwaredir}/mediatek/* \
@@ -1190,8 +1190,8 @@ FILES:${PN}-mediatek-license = " \
 RDEPENDS:${PN}-mediatek += "${PN}-mediatek-license"
 
 # For Microchip
-LICENSE:${PN}-microchip = "LicenseRef-Firmware-microchip"
-LICENSE:${PN}-microchip-license = "LicenseRef-Firmware-microchip"
+LICENSE:${PN}-microchip = "Firmware-microchip"
+LICENSE:${PN}-microchip-license = "Firmware-microchip"
 
 FILES:${PN}-microchip = "${firmwaredir}/microchip/*"
 FILES:${PN}-microchip-license = " \
@@ -1200,8 +1200,8 @@ FILES:${PN}-microchip-license = " \
 RDEPENDS:${PN}-microchip += "${PN}-microchip-license"
 
 # For MOXA
-LICENSE:${PN}-moxa = "LicenseRef-Firmware-moxa"
-LICENSE:${PN}-moxa-license = "LicenseRef-Firmware-moxa"
+LICENSE:${PN}-moxa = "Firmware-moxa"
+LICENSE:${PN}-moxa-license = "Firmware-moxa"
 
 FILES:${PN}-moxa = "${firmwaredir}/moxa"
 FILES:${PN}-moxa-license = "${firmwaredir}/LICENCE.moxa"
@@ -1210,8 +1210,8 @@ RDEPENDS:${PN}-moxa += "${PN}-moxa-license"
 
 # For radeon
 
-LICENSE:${PN}-radeon = "LicenseRef-Firmware-radeon"
-LICENSE:${PN}-radeon-license = "LicenseRef-Firmware-radeon"
+LICENSE:${PN}-radeon = "Firmware-radeon"
+LICENSE:${PN}-radeon-license = "Firmware-radeon"
 
 FILES:${PN}-radeon-license = "${firmwaredir}/LICENSE.radeon"
 FILES:${PN}-radeon = " \
@@ -1221,34 +1221,34 @@ FILES:${PN}-radeon = " \
 RDEPENDS:${PN}-radeon += "${PN}-radeon-license"
 
 # For amdgpu
-LICENSE:${PN}-amdgpu = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-license = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-aldebaran = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-carrizo = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-cezanne = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-fiji = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-hawaii = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-navi10 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-navi14 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-navi21 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-navi22 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-navi23 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-navi24 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-navi31 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-navi32 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-oland = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-polaris10 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-polaris11 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-polaris12 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-raven = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-rembrandt = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-renoir = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-stoney = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-tonga = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-topaz = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-vega10 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-vega12 = "LicenseRef-Firmware-amdgpu"
-LICENSE:${PN}-amdgpu-misc = "LicenseRef-Firmware-amdgpu"
+LICENSE:${PN}-amdgpu = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-license = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-aldebaran = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-carrizo = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-cezanne = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-fiji = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-hawaii = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-navi10 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-navi14 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-navi21 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-navi22 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-navi23 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-navi24 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-navi31 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-navi32 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-oland = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-polaris10 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-polaris11 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-polaris12 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-raven = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-rembrandt = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-renoir = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-stoney = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-tonga = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-topaz = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-vega10 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-vega12 = "Firmware-amdgpu"
+LICENSE:${PN}-amdgpu-misc = "Firmware-amdgpu"
 
 FILES:${PN}-amdgpu-license = "${firmwaredir}/LICENSE.amdgpu"
 FILES:${PN}-amdgpu-aldebaran = "${firmwaredir}/amdgpu/aldebaran_*.bin*"
@@ -1326,10 +1326,10 @@ RDEPENDS:${PN}-amdgpu-vega12 += "${PN}-amdgpu-license"
 RDEPENDS:${PN}-amdgpu-misc += "${PN}-amdgpu-license"
 
 # For lontium
-LICENSE:${PN}-lt7911exc = "LicenseRef-Firmware-Lontium"
-LICENSE:${PN}-lt8713sx = "LicenseRef-Firmware-Lontium"
-LICENSE:${PN}-lt9611c = "LicenseRef-Firmware-Lontium"
-LICENSE:${PN}-lt9611uxc = "LicenseRef-Firmware-Lontium"
+LICENSE:${PN}-lt7911exc = "Firmware-Lontium"
+LICENSE:${PN}-lt8713sx = "Firmware-Lontium"
+LICENSE:${PN}-lt9611c = "Firmware-Lontium"
+LICENSE:${PN}-lt9611uxc = "Firmware-Lontium"
 
 FILES:${PN}-lontium-license = "${firmwaredir}/LICENSE.Lontium"
 FILES:${PN}-lt7911exc = "${firmwaredir}/Lontium/lt7911exc_fw.bin*"
@@ -1340,60 +1340,60 @@ FILES:${PN}-lt9611uxc = "${firmwaredir}/lt9611uxc_fw.bin* ${firmwaredir}/Lontium
 # For Arm Mali
 FILES:${PN}-mali-csffw-license = "${firmwaredir}/LICENCE.mali_csffw"
 
-LICENSE:${PN}-mali-csffw-arch108 = "LicenseRef-Firmware-mali-csffw"
+LICENSE:${PN}-mali-csffw-arch108 = "Firmware-mali-csffw"
 FILES:${PN}-mali-csffw-arch108 = "${firmwaredir}/arm/mali/arch10.8/mali_csffw.bin*"
 RDEPENDS:${PN}-mali-csffw-arch108 += "${PN}-mali-csffw-license"
 
-LICENSE:${PN}-mali-csffw-arch1010 = "LicenseRef-Firmware-mali-csffw"
+LICENSE:${PN}-mali-csffw-arch1010 = "Firmware-mali-csffw"
 FILES:${PN}-mali-csffw-arch1010 = "${firmwaredir}/arm/mali/arch10.10/mali_csffw.bin*"
 RDEPENDS:${PN}-mali-csffw-arch1010 += "${PN}-mali-csffw-license"
 
-LICENSE:${PN}-mali-csffw-arch1012 = "LicenseRef-Firmware-mali-csffw"
+LICENSE:${PN}-mali-csffw-arch1012 = "Firmware-mali-csffw"
 FILES:${PN}-mali-csffw-arch1012 = "${firmwaredir}/arm/mali/arch10.12/mali_csffw.bin*"
 RDEPENDS:${PN}-mali-csffw-arch1012 += "${PN}-mali-csffw-license"
 
-LICENSE:${PN}-mali-csffw-arch118 = "LicenseRef-Firmware-mali-csffw"
+LICENSE:${PN}-mali-csffw-arch118 = "Firmware-mali-csffw"
 FILES:${PN}-mali-csffw-arch118 = "${firmwaredir}/arm/mali/arch11.8/mali_csffw.bin*"
 RDEPENDS:${PN}-mali-csffw-arch118 += "${PN}-mali-csffw-license"
 
-LICENSE:${PN}-mali-csffw-arch128 = "LicenseRef-Firmware-mali-csffw"
+LICENSE:${PN}-mali-csffw-arch128 = "Firmware-mali-csffw"
 FILES:${PN}-mali-csffw-arch128 = "${firmwaredir}/arm/mali/arch12.8/mali_csffw.bin*"
 RDEPENDS:${PN}-mali-csffw-arch128 += "${PN}-mali-csffw-license"
 
-LICENSE:${PN}-mali-csffw-arch138 = "LicenseRef-Firmware-mali-csffw"
+LICENSE:${PN}-mali-csffw-arch138 = "Firmware-mali-csffw"
 FILES:${PN}-mali-csffw-arch138 = "${firmwaredir}/arm/mali/arch13.8/mali_csffw.bin*"
 RDEPENDS:${PN}-mali-csffw-arch138 += "${PN}-mali-csffw-license"
 
 # For marvell
-LICENSE:${PN}-pcie8897 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-pcie8997 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8686 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8688 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8787 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8797 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8801 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8887 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8897 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8997 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-usb8997 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-cf8381 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-cf8385 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-gspi8682 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-gspi8686 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-gspi8688 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8385 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8682 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-usb8388 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-usb8682 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-sd8977 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-usb8766 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-usb8797 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-usb8801 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-usb8897 = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-rvu-cptpf = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-mwl8k = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-mwlwifi = "LicenseRef-Firmware-Marvell"
-LICENSE:${PN}-marvell-license = "LicenseRef-Firmware-Marvell"
+LICENSE:${PN}-pcie8897 = "Firmware-Marvell"
+LICENSE:${PN}-pcie8997 = "Firmware-Marvell"
+LICENSE:${PN}-sd8686 = "Firmware-Marvell"
+LICENSE:${PN}-sd8688 = "Firmware-Marvell"
+LICENSE:${PN}-sd8787 = "Firmware-Marvell"
+LICENSE:${PN}-sd8797 = "Firmware-Marvell"
+LICENSE:${PN}-sd8801 = "Firmware-Marvell"
+LICENSE:${PN}-sd8887 = "Firmware-Marvell"
+LICENSE:${PN}-sd8897 = "Firmware-Marvell"
+LICENSE:${PN}-sd8997 = "Firmware-Marvell"
+LICENSE:${PN}-usb8997 = "Firmware-Marvell"
+LICENSE:${PN}-cf8381 = "Firmware-Marvell"
+LICENSE:${PN}-cf8385 = "Firmware-Marvell"
+LICENSE:${PN}-gspi8682 = "Firmware-Marvell"
+LICENSE:${PN}-gspi8686 = "Firmware-Marvell"
+LICENSE:${PN}-gspi8688 = "Firmware-Marvell"
+LICENSE:${PN}-sd8385 = "Firmware-Marvell"
+LICENSE:${PN}-sd8682 = "Firmware-Marvell"
+LICENSE:${PN}-usb8388 = "Firmware-Marvell"
+LICENSE:${PN}-usb8682 = "Firmware-Marvell"
+LICENSE:${PN}-sd8977 = "Firmware-Marvell"
+LICENSE:${PN}-usb8766 = "Firmware-Marvell"
+LICENSE:${PN}-usb8797 = "Firmware-Marvell"
+LICENSE:${PN}-usb8801 = "Firmware-Marvell"
+LICENSE:${PN}-usb8897 = "Firmware-Marvell"
+LICENSE:${PN}-rvu-cptpf = "Firmware-Marvell"
+LICENSE:${PN}-mwl8k = "Firmware-Marvell"
+LICENSE:${PN}-mwlwifi = "Firmware-Marvell"
+LICENSE:${PN}-marvell-license = "Firmware-Marvell"
 
 FILES:${PN}-marvell-license = "${firmwaredir}/LICENCE.Marvell"
 FILES:${PN}-pcie8897 = " \
@@ -1484,7 +1484,7 @@ RDEPENDS:${PN}-mwl8k += "${PN}-marvell-license"
 RDEPENDS:${PN}-mwlwifi += "${PN}-marvell-license"
 
 # For netronome
-LICENSE:${PN}-netronome = "LicenseRef-Firmware-netronome"
+LICENSE:${PN}-netronome = "Firmware-netronome"
 
 FILES:${PN}-netronome-license = " \
   ${firmwaredir}/LICENCE.Netronome \
@@ -1506,18 +1506,18 @@ FILES:${PN}-netronome = " \
 RDEPENDS:${PN}-netronome += "${PN}-netronome-license"
 
 # For NXP
-LICENSE:${PN}-nxp8987-sdio = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxp8997-common = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxp8997-pcie = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxp8997-sdio = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxp9098-common = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxp9098-pcie = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxp9098-sdio = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxpiw416-sdio = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxpiw612-sdio = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxpiw61x-sdio = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxp-sr1xx = "LicenseRef-Firmware-nxp"
-LICENSE:${PN}-nxp-license = "LicenseRef-Firmware-nxp"
+LICENSE:${PN}-nxp8987-sdio = "Firmware-nxp"
+LICENSE:${PN}-nxp8997-common = "Firmware-nxp"
+LICENSE:${PN}-nxp8997-pcie = "Firmware-nxp"
+LICENSE:${PN}-nxp8997-sdio = "Firmware-nxp"
+LICENSE:${PN}-nxp9098-common = "Firmware-nxp"
+LICENSE:${PN}-nxp9098-pcie = "Firmware-nxp"
+LICENSE:${PN}-nxp9098-sdio = "Firmware-nxp"
+LICENSE:${PN}-nxpiw416-sdio = "Firmware-nxp"
+LICENSE:${PN}-nxpiw612-sdio = "Firmware-nxp"
+LICENSE:${PN}-nxpiw61x-sdio = "Firmware-nxp"
+LICENSE:${PN}-nxp-sr1xx = "Firmware-nxp"
+LICENSE:${PN}-nxp-license = "Firmware-nxp"
 
 FILES:${PN}-nxp8987-sdio = "${firmwaredir}/nxp/*8987*"
 FILES:${PN}-nxp8997-common = " \
@@ -1548,8 +1548,8 @@ RDEPENDS:${PN}-nxpiw61x-sdio += "${PN}-nxp-license"
 RDEPENDS:${PN}-nxp-sr1xx += "${PN}-nxp-license"
 
 # For nxp-mc
-LICENSE:${PN}-nxp-mc = "LicenseRef-Firmware-nxp-mc-firmware"
-LICENSE:${PN}-nxp-mc-license = "LicenseRef-Firmware-nxp-mc-firmware"
+LICENSE:${PN}-nxp-mc = "Firmware-nxp-mc-firmware"
+LICENSE:${PN}-nxp-mc-license = "Firmware-nxp-mc-firmware"
 
 FILES:${PN}-nxp-mc = "${firmwaredir}/dpaa2/mc/*"
 FILES:${PN}-nxp-mc-license = " \
@@ -1558,10 +1558,10 @@ FILES:${PN}-nxp-mc-license = " \
 RDEPENDS:${PN}-nxp-mc += "${PN}-nxp-mc-license"
 
 # For Nvidia
-LICENSE:${PN}-nvidia-gpu = "LicenseRef-Firmware-nvidia"
-LICENSE:${PN}-nvidia-tegra = "LicenseRef-Firmware-nvidia"
-LICENSE:${PN}-nvidia-tegra-k1 = "LicenseRef-Firmware-nvidia"
-LICENSE:${PN}-nvidia-license = "LicenseRef-Firmware-nvidia"
+LICENSE:${PN}-nvidia-gpu = "Firmware-nvidia"
+LICENSE:${PN}-nvidia-tegra = "Firmware-nvidia"
+LICENSE:${PN}-nvidia-tegra-k1 = "Firmware-nvidia"
+LICENSE:${PN}-nvidia-license = "Firmware-nvidia"
 
 FILES:${PN}-nvidia-gpu = "${firmwaredir}/nvidia"
 FILES:${PN}-nvidia-tegra = " \
@@ -1580,8 +1580,8 @@ RDEPENDS:${PN}-nvidia-tegra += "${PN}-nvidia-license"
 RDEPENDS:${PN}-nvidia-tegra-k1 += "${PN}-nvidia-license"
 
 # For OLPC
-LICENSE:${PN}-olpc = "LicenseRef-Firmware-OLPC"
-LICENSE:${PN}-olpc-license = "LicenseRef-Firmware-OLPC"
+LICENSE:${PN}-olpc = "Firmware-OLPC"
+LICENSE:${PN}-olpc-license = "Firmware-OLPC"
 
 FILES:${PN}-olpc = " \
   ${firmwaredir}/libertas/lbtf_sdio.bin*	\
@@ -1593,8 +1593,8 @@ FILES:${PN}-olpc-license = "${firmwaredir}/LICENCE.OLPC"
 RDEPENDS:${PN}-olpc += "${PN}-olpc-license"
 
 # For phanfw
-LICENSE:${PN}-phanfw = "LicenseRef-Firmware-phanfw"
-LICENSE:${PN}-phanfw-license = "LicenseRef-Firmware-phanfw"
+LICENSE:${PN}-phanfw = "Firmware-phanfw"
+LICENSE:${PN}-phanfw-license = "Firmware-phanfw"
 
 FILES:${PN}-phanfw = "${firmwaredir}/phanfw.bin*"
 FILES:${PN}-phanfw-license = "${firmwaredir}/LICENCE.phanfw"
@@ -1602,8 +1602,8 @@ FILES:${PN}-phanfw-license = "${firmwaredir}/LICENCE.phanfw"
 RDEPENDS:${PN}-phanfw += "${PN}-phanfw-license"
 
 # For PowerVR
-LICENSE:${PN}-powervr = "LicenseRef-Firmware-powervr"
-LICENSE:${PN}-powervr-license = "LicenseRef-Firmware-powervr"
+LICENSE:${PN}-powervr = "Firmware-powervr"
+LICENSE:${PN}-powervr-license = "Firmware-powervr"
 
 FILES:${PN}-powervr = "${firmwaredir}/powervr"
 FILES:${PN}-powervr-license = "${firmwaredir}/LICENSE.powervr"
@@ -1611,8 +1611,8 @@ FILES:${PN}-powervr-license = "${firmwaredir}/LICENSE.powervr"
 RDEPENDS:${PN}-powervr += "${PN}-powervr-license"
 
 # For qla2xxx
-LICENSE:${PN}-qla2xxx = "LicenseRef-Firmware-qla2xxx"
-LICENSE:${PN}-qla2xxx-license = "LicenseRef-Firmware-qla2xxx"
+LICENSE:${PN}-qla2xxx = "Firmware-qla2xxx"
+LICENSE:${PN}-qla2xxx-license = "Firmware-qla2xxx"
 
 FILES:${PN}-qla2xxx = "${firmwaredir}/ql2*"
 FILES:${PN}-qla2xxx-license = "${firmwaredir}/LICENCE.qla2xxx"
@@ -1620,9 +1620,9 @@ FILES:${PN}-qla2xxx-license = "${firmwaredir}/LICENCE.qla2xxx"
 RDEPENDS:${PN}-qla2xxx += "${PN}-qla2xxx-license"
 
 # For RSI RS911x WiFi
-LICENSE:${PN}-rs9113 = "LicenseRef-Firmware-WHENCE"
-LICENSE:${PN}-rs9116 = "LicenseRef-Firmware-WHENCE"
-LICENSE:${PN}-rsi-91x = "LicenseRef-Firmware-WHENCE"
+LICENSE:${PN}-rs9113 = "Firmware-WHENCE"
+LICENSE:${PN}-rs9116 = "Firmware-WHENCE"
+LICENSE:${PN}-rsi-91x = "Firmware-WHENCE"
 
 FILES:${PN}-rs9113 = " ${firmwaredir}/rsi/rs9113*.rps* "
 FILES:${PN}-rs9116 = " ${firmwaredir}/rsi/rs9116*.rps* "
@@ -1633,26 +1633,26 @@ RDEPENDS:${PN}-rs9116 += "${PN}-whence-license"
 RDEPENDS:${PN}-rsi-91x += "${PN}-whence-license"
 
 # For rtl
-LICENSE:${PN}-rtl8188 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8192cu = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8192ce = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8192su = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8261c = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8723 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8761 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8821 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8822 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8192 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8710 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8812 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8851 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8852 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8922 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8703 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8814 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl-license = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl-nic = "LicenseRef-Firmware-WHENCE"
-LICENSE:${PN}-rtl8168 = "LicenseRef-Firmware-WHENCE"
+LICENSE:${PN}-rtl8188 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8192cu = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8192ce = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8192su = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8261c = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8723 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8761 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8821 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8822 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8192 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8710 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8812 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8851 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8852 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8922 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8703 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8814 = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl-license = "Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl-nic = "Firmware-WHENCE"
+LICENSE:${PN}-rtl8168 = "Firmware-WHENCE"
 
 FILES:${PN}-rtl-license = " \
   ${firmwaredir}/LICENCE.rtlwifi_firmware.txt \
@@ -1743,8 +1743,8 @@ RDEPENDS:${PN}-rtl8168 += "${PN}-whence-license"
 RDEPENDS:${PN}-rtl-nic += "${PN}-whence-license"
 
 # For Silabs
-LICENSE:${PN}-wfx = "LicenseRef-Firmware-wfx"
-LICENSE:${PN}-wfx-license = "LicenseRef-Firmware-wfx"
+LICENSE:${PN}-wfx = "Firmware-wfx"
+LICENSE:${PN}-wfx-license = "Firmware-wfx"
 
 FILES:${PN}-wfx = " \
   ${firmwaredir}/wfx/*.pds*        \
@@ -1755,8 +1755,8 @@ FILES:${PN}-wfx-license = "${firmwaredir}/LICENCE.wf200"
 RDEPENDS:${PN}-wfx += "${PN}-wfx-license"
 
 # For TI wl1251
-LICENSE:${PN}-wl1251 = "LicenseRef-Firmware-wl1251"
-LICENSE:${PN}-wl1251-license = "LicenseRef-Firmware-wl1251"
+LICENSE:${PN}-wl1251 = "Firmware-wl1251"
+LICENSE:${PN}-wl1251-license = "Firmware-wl1251"
 
 FILES:${PN}-wl1251 = " \
   ${firmwaredir}/ti-connectivity/wl1251-fw.bin*         \
@@ -1767,11 +1767,11 @@ FILES:${PN}-wl1251-license = "${firmwaredir}/LICENCE.wl1251"
 RDEPENDS:${PN}-wl1251 += "${PN}-wl1251-license"
 
 # For ti-connectivity
-LICENSE:${PN}-wlcommon = "LicenseRef-Firmware-ti-connectivity"
-LICENSE:${PN}-wl12xx = "LicenseRef-Firmware-ti-connectivity"
-LICENSE:${PN}-wl18xx = "LicenseRef-Firmware-ti-connectivity"
-LICENSE:${PN}-cc33xx = "LicenseRef-Firmware-ti-connectivity"
-LICENSE:${PN}-ti-connectivity-license = "LicenseRef-Firmware-ti-connectivity"
+LICENSE:${PN}-wlcommon = "Firmware-ti-connectivity"
+LICENSE:${PN}-wl12xx = "Firmware-ti-connectivity"
+LICENSE:${PN}-wl18xx = "Firmware-ti-connectivity"
+LICENSE:${PN}-cc33xx = "Firmware-ti-connectivity"
+LICENSE:${PN}-ti-connectivity-license = "Firmware-ti-connectivity"
 
 FILES:${PN}-ti-connectivity-license = "${firmwaredir}/LICENCE.ti-connectivity"
 # wl18xx optionally needs wl1271-nvs.bin (which itself is a symlink to
@@ -1802,8 +1802,8 @@ RDEPENDS:${PN}-wl18xx = "${PN}-ti-connectivity-license ${PN}-wlcommon"
 RDEPENDS:${PN}-cc33xx = "${PN}-ti-connectivity-license"
 
 # For ti-keystone
-LICENSE:${PN}-ti-keystone = "LicenseRef-Firmware-ti-keystone"
-LICENSE:${PN}-ti-keystone-license = "LicenseRef-Firmware-ti-keystone"
+LICENSE:${PN}-ti-keystone = "Firmware-ti-keystone"
+LICENSE:${PN}-ti-keystone-license = "Firmware-ti-keystone"
 
 FILES:${PN}-ti-keystone = "${firmwaredir}/ti-keystone/*"
 FILES:${PN}-ti-keystone-license = " \
@@ -1812,11 +1812,11 @@ FILES:${PN}-ti-keystone-license = " \
 RDEPENDS:${PN}-ti-keystone += "${PN}-ti-keystone-license"
 
 # For ti-tspa-license
-LICENSE:${PN}-ti-tspa-license = "LicenseRef-Firmware-ti-tspa"
+LICENSE:${PN}-ti-tspa-license = "Firmware-ti-tspa"
 FILES:${PN}-ti-tspa-license = "${firmwaredir}/LICENCE.ti-tspa"
 
 # For ti-tas2563 - tas2563 firmware
-LICENSE:${PN}-ti-tas2563 = "LicenseRef-Firmware-ti-tspa"
+LICENSE:${PN}-ti-tas2563 = "Firmware-ti-tspa"
 FILES:${PN}-ti-tas2563 = "\
     ${firmwaredir}/INT8866RCA2.bin* \
     ${firmwaredir}/TAS2XXX3870.bin* \
@@ -1825,7 +1825,7 @@ FILES:${PN}-ti-tas2563 = "\
 RDEPENDS:${PN}-ti-tas2563 = "${PN}-ti-tspa-license"
 
 # For ti-tas257x - tas257x firmware
-LICENSE:${PN}-ti-tas257x = "LicenseRef-Firmware-ti-tspa"
+LICENSE:${PN}-ti-tas257x = "Firmware-ti-tspa"
 FILES:${PN}-ti-tas257x = "\
     ${firmwaredir}/tas257x-1amp-reg.bin*\
     ${firmwaredir}/tas2572-1-1amp-reg.bin* \
@@ -1837,14 +1837,14 @@ FILES:${PN}-ti-tas257x = "\
 RDEPENDS:${PN}-ti-tas257x = "${PN}-ti-tspa-license"
 
 # For ti-pcm6240 - pcm6240 firmware
-LICENSE:${PN}-ti-pcm6240 = "LicenseRef-Firmware-ti-tspa"
+LICENSE:${PN}-ti-pcm6240 = "Firmware-ti-tspa"
 FILES:${PN}-ti-pcm6240 = "\
     ${firmwaredir}/ti/pcm6240/pcm6240-i2c-1-2dev.bin* \
 "
 RDEPENDS:${PN}-ti-pcm6240 = "${PN}-ti-tspa-license"
 
 # For ti-tas2781 - tas2781 firmware
-LICENSE:${PN}-ti-tas2781 = "LicenseRef-Firmware-ti-tspa"
+LICENSE:${PN}-ti-tas2781 = "Firmware-ti-tspa"
 FILES:${PN}-ti-tas2781 = "\
     ${firmwaredir}/TAS2XXX*.bin* \
     ${firmwaredir}/TIAS2781*.bin* \
@@ -1854,7 +1854,7 @@ FILES:${PN}-ti-tas2781 = "\
 RDEPENDS:${PN}-ti-tas2781 = "${PN}-ti-tspa-license"
 
 # For ti-tas2783 - tas2783 firmware
-LICENSE:${PN}-ti-tas2783 = "LicenseRef-Firmware-ti-tspa"
+LICENSE:${PN}-ti-tas2783 = "Firmware-ti-tspa"
 FILES:${PN}-ti-tas2783 = "\
     ${firmwaredir}/1534-2-*.bin* \
     ${firmwaredir}/15E2-?-0x*.bin* \
@@ -1877,7 +1877,7 @@ FILES:${PN}-ti-tas2783 = "\
 RDEPENDS:${PN}-ti-tas2781 = "${PN}-ti-tspa-license"
 
 # For ti-vpe - Texas Instruments V4L2 driver for Video Processing Engine
-LICENSE:${PN}-ti-vpe = "LicenseRef-Firmware-ti-tspa"
+LICENSE:${PN}-ti-vpe = "Firmware-ti-tspa"
 FILES:${PN}-ti-vpe = "${firmwaredir}/ti/vpdma-1b8.bin*"
 RDEPENDS:${PN}-ti-vpe = "${PN}-ti-tspa-license"
 
@@ -1889,8 +1889,8 @@ FILES:${PN}-ti-usb-3410-5052 = "\
 "
 
 # For vt6656
-LICENSE:${PN}-vt6656 = "LicenseRef-Firmware-via-vt6656"
-LICENSE:${PN}-vt6656-license = "LicenseRef-Firmware-via-vt6656"
+LICENSE:${PN}-vt6656 = "Firmware-via-vt6656"
+LICENSE:${PN}-vt6656-license = "Firmware-via-vt6656"
 
 FILES:${PN}-vt6656-license = "${firmwaredir}/LICENCE.via_vt6656"
 FILES:${PN}-vt6656 = " \
@@ -1900,8 +1900,8 @@ FILES:${PN}-vt6656 = " \
 RDEPENDS:${PN}-vt6656 = "${PN}-vt6656-license"
 
 # For xc4000
-LICENSE:${PN}-xc4000 = "LicenseRef-Firmware-xc4000"
-LICENSE:${PN}-xc4000-license = "LicenseRef-Firmware-xc4000"
+LICENSE:${PN}-xc4000 = "Firmware-xc4000"
+LICENSE:${PN}-xc4000-license = "Firmware-xc4000"
 
 FILES:${PN}-xc4000 = "${firmwaredir}/dvb-fe-xc4000-1.4.1.fw*"
 FILES:${PN}-xc4000-license = "${firmwaredir}/LICENCE.xc4000"
@@ -1909,8 +1909,8 @@ FILES:${PN}-xc4000-license = "${firmwaredir}/LICENCE.xc4000"
 RDEPENDS:${PN}-xc4000 += "${PN}-xc4000-license"
 
 # For xc5000
-LICENSE:${PN}-xc5000 = "LicenseRef-Firmware-xc5000"
-LICENSE:${PN}-xc5000-license = "LicenseRef-Firmware-xc5000"
+LICENSE:${PN}-xc5000 = "Firmware-xc5000"
+LICENSE:${PN}-xc5000-license = "Firmware-xc5000"
 
 FILES:${PN}-xc5000 = "${firmwaredir}/dvb-fe-xc5000-1.6.114.fw*"
 FILES:${PN}-xc5000-license = "${firmwaredir}/LICENCE.xc5000"
@@ -1918,8 +1918,8 @@ FILES:${PN}-xc5000-license = "${firmwaredir}/LICENCE.xc5000"
 RDEPENDS:${PN}-xc5000 += "${PN}-xc5000-license"
 
 # For xc5000c
-LICENSE:${PN}-xc5000c = "LicenseRef-Firmware-xc5000c"
-LICENSE:${PN}-xc5000c-license = "LicenseRef-Firmware-xc5000c"
+LICENSE:${PN}-xc5000c = "Firmware-xc5000c"
+LICENSE:${PN}-xc5000c-license = "Firmware-xc5000c"
 
 FILES:${PN}-xc5000c = " \
   ${firmwaredir}/dvb-fe-xc5000c-4.1.30.7.fw* \
@@ -1932,7 +1932,7 @@ RDEPENDS:${PN}-xc5000c += "${PN}-xc5000c-license"
 
 # for i in `grep brcm WHENCE  | grep ^File | sed 's/File: brcm.//g'`; do pkg=`echo $i | sed 's/-[sp40].*//g; s/\.bin//g; s/brcmfmac/bcm/g; s/_hdr/-hdr/g; s/BCM/bcm-0bb4-0306/g'`; echo -e "             \${PN}-$pkg \\"; done  | sort -u
 
-LICENSE:${PN}-broadcom-license = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-broadcom-license = "Firmware-broadcom-bcm43xx"
 FILES:${PN}-broadcom-license = "${firmwaredir}/LICENCE.broadcom_bcm43xx"
 
 # for i in `grep brcm WHENCE  | grep ^File | sed 's/File: brcm.//g'`; do pkg=`echo $i | sed 's/-[sp40].*//g; s/\.bin//g; s/brcmfmac/bcm/g; s/_hdr/-hdr/g; s/BCM/bcm-0bb4-0306/g'`; echo "$i - $pkg"; echo -e "FILES:\${PN}-$pkg = \"\${firmwaredir}/brcm/$i\""; done | grep ^FILES
@@ -1986,66 +1986,66 @@ FILES:${PN}-bcm54591 = "${firmwaredir}/brcm/brcmfmac54591-pcie.* \
 # for i in `grep brcm WHENCE  | grep ^File | sed 's/File: brcm.//g'`; do pkg=`echo $i | sed 's/-[sp40].*//g; s/\.bin//g; s/brcmfmac/bcm/g; s/_hdr/-hdr/g; s/BCM/bcm-0bb4-0306/g'`; echo -e "LICENSE:\${PN}-$pkg = \"Firmware-broadcom-bcm43xx\"\nRDEPENDS_\${PN}-$pkg += \"\${PN}-broadcom-license\""; done
 # Currently 1st one and last 6 have cypress LICENSE
 
-LICENSE:${PN}-bcm43xx = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43xx = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43xx += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43xx-hdr = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43xx-hdr = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43xx-hdr += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4329-fullmac = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4329-fullmac = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4329-fullmac += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43236b = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43236b = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43236b += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4329 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4329 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4329 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4330 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4330 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4330 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4334 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4334 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4334 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4335 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4335 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4335 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4339 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4339 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4339 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43241b0 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43241b0 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43241b0 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43241b4 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43241b4 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43241b4 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43241b5 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43241b5 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43241b5 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43242a = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43242a = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43242a += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43012 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43012 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43012 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43143 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43143 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43143 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43430a0 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43430a0 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43430a0 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43455 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43455 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43455 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4350c2 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4350c2 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4350c2 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4350 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4350 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4350 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4356 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4356 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4356 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43569 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43569 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43569 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43570 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43570 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43570 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4358 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4358 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4358 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm43602 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm43602 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm43602 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4366b = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4366b = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4366b += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4366c = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4366c = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4366c += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm4371 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm4371 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm4371 += "${PN}-broadcom-license"
-LICENSE:${PN}-bcm54591 = "LicenseRef-Firmware-broadcom-bcm43xx"
+LICENSE:${PN}-bcm54591 = "Firmware-broadcom-bcm43xx"
 RDEPENDS:${PN}-bcm54591 += "${PN}-broadcom-license"
 
 # For broadcom cypress
 
-LICENSE:${PN}-cypress-license = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-cypress-license = "Firmware-cypress"
 FILES:${PN}-cypress-license = "${firmwaredir}/LICENCE.cypress"
 
 FILES:${PN}-bcm-0bb4-0306 = "${firmwaredir}/brcm/BCM-0bb4-0306.hcd*"
@@ -2069,21 +2069,21 @@ FILES:${PN}-bcm4373 = "${firmwaredir}/brcm/brcmfmac4373-sdio.bin* \
   ${firmwaredir}/cypress/cyfmac4373-sdio.clm_blob* \
 "
 
-LICENSE:${PN}-bcm-0bb4-0306 = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-bcm-0bb4-0306 = "Firmware-cypress"
 RDEPENDS:${PN}-bcm-0bb4-0306 += "${PN}-cypress-license"
-LICENSE:${PN}-bcm-0a5c-6410 = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-bcm-0a5c-6410 = "Firmware-cypress"
 RDEPENDS:${PN}-bcm-0a5c-6410 += "${PN}-bcm-0bb4-0306"
-LICENSE:${PN}-bcm43340 = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-bcm43340 = "Firmware-cypress"
 RDEPENDS:${PN}-bcm43340 += "${PN}-cypress-license"
-LICENSE:${PN}-bcm43362 = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-bcm43362 = "Firmware-cypress"
 RDEPENDS:${PN}-bcm43362 += "${PN}-cypress-license"
-LICENSE:${PN}-bcm43430 = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-bcm43430 = "Firmware-cypress"
 RDEPENDS:${PN}-bcm43430 += "${PN}-cypress-license"
-LICENSE:${PN}-bcm4354 = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-bcm4354 = "Firmware-cypress"
 RDEPENDS:${PN}-bcm4354 += "${PN}-cypress-license"
-LICENSE:${PN}-bcm4356-pcie = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-bcm4356-pcie = "Firmware-cypress"
 RDEPENDS:${PN}-bcm4356-pcie += "${PN}-cypress-license"
-LICENSE:${PN}-bcm4373 = "LicenseRef-Firmware-cypress"
+LICENSE:${PN}-bcm4373 = "Firmware-cypress"
 RDEPENDS:${PN}-bcm4373 += "${PN}-cypress-license"
 
 # For Broadcom bnx2
@@ -2091,8 +2091,8 @@ RDEPENDS:${PN}-bcm4373 += "${PN}-cypress-license"
 # which is a separate case to the other Broadcom firmwares since its
 # license is contained in the shared WHENCE file.
 
-LICENSE:${PN}-bnx2 = "LicenseRef-Firmware-WHENCE"
-LICENSE:${PN}-whence-license = "LicenseRef-Firmware-WHENCE"
+LICENSE:${PN}-bnx2 = "Firmware-WHENCE"
+LICENSE:${PN}-whence-license = "Firmware-WHENCE"
 
 FILES:${PN}-bnx2 = " \
     ${firmwaredir}/bnx2/bnx2-mips*.fw* \
@@ -2103,16 +2103,16 @@ FILES:${PN}-whence-license = "${firmwaredir}/WHENCE"
 RDEPENDS:${PN}-bnx2 += "${PN}-whence-license"
 RPROVIDES:${PN}-bnx2 = "${PN}-bnx2-mips"
 
-LICENSE:${PN}-bnx2x = "LicenseRef-Firmware-WHENCE"
+LICENSE:${PN}-bnx2x = "Firmware-WHENCE"
 
 FILES:${PN}-bnx2x = "${firmwaredir}/bnx2x/bnx2x*.fw*"
 
 RDEPENDS:${PN}-bnx2x += "${PN}-whence-license"
 
 # For cirrus
-LICENSE:${PN}-cirrus = "LicenseRef-Firmware-cirrus"
-LICENSE:${PN}-cirrus-cs42l45 = "LicenseRef-Firmware-cirrus"
-LICENSE:${PN}-cirrus-license = "LicenseRef-Firmware-cirrus"
+LICENSE:${PN}-cirrus = "Firmware-cirrus"
+LICENSE:${PN}-cirrus-cs42l45 = "Firmware-cirrus"
+LICENSE:${PN}-cirrus-license = "Firmware-cirrus"
 
 FILES:${PN}-cirrus = " \
     ${firmwaredir}/cs42l43.bin* \
@@ -2128,8 +2128,8 @@ RDEPENDS:${PN}-cirrus += "${PN}-cirrus-license"
 RDEPENDS:${PN}-cirrus-cs42l45 += "${PN}-cirrus-license"
 
 # For cnm
-LICENSE:${PN}-cnm = "LicenseRef-Firmware-cnm"
-LICENSE:${PN}-cnm-license = "LicenseRef-Firmware-cnm"
+LICENSE:${PN}-cnm = "Firmware-cnm"
+LICENSE:${PN}-cnm-license = "Firmware-cnm"
 
 FILES:${PN}-cnm = "${firmwaredir}/cnm/*"
 FILES:${PN}-cnm-license = "${firmwaredir}/LICENCE.cnm"
@@ -2137,9 +2137,9 @@ FILES:${PN}-cnm-license = "${firmwaredir}/LICENCE.cnm"
 RDEPENDS:${PN}-cnm += "${PN}-cnm-license"
 
 # For imx-sdma
-LICENSE:${PN}-imx-sdma-imx6q       = "LicenseRef-Firmware-imx-sdma-firmware"
-LICENSE:${PN}-imx-sdma-imx7d       = "LicenseRef-Firmware-imx-sdma-firmware"
-LICENSE:${PN}-imx-sdma-license       = "LicenseRef-Firmware-imx-sdma-firmware"
+LICENSE:${PN}-imx-sdma-imx6q       = "Firmware-imx-sdma-firmware"
+LICENSE:${PN}-imx-sdma-imx7d       = "Firmware-imx-sdma-firmware"
+LICENSE:${PN}-imx-sdma-license       = "Firmware-imx-sdma-firmware"
 
 FILES:${PN}-imx-sdma-imx6q = "${firmwaredir}/imx/sdma/sdma-imx6q.bin*"
 
@@ -2155,32 +2155,32 @@ RDEPENDS:${PN}-imx-sdma-imx6q += "${PN}-imx-sdma-license"
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
+LICENSE:${PN}-iwlwifi-misc      = "Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-license   = "Firmware-iwlwifi-firmware"
 
 FILES:${PN}-iwlwifi-license = "${firmwaredir}/LICENCE.iwlwifi_firmware"
 FILES:${PN}-iwlwifi-135-6 = "${firmwaredir}/iwlwifi-135-6.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-135-6.ucode*"
@@ -2254,15 +2254,15 @@ RREPLACES:${PN}-iwlwifi-7260 = "${PN}-iwlwifi-7260-7 ${PN}-iwlwifi-7260-8 ${PN}-
 RCONFLICTS:${PN}-iwlwifi-7260 = "${PN}-iwlwifi-7260-7 ${PN}-iwlwifi-7260-8 ${PN}-iwlwifi-7260-9"
 
 # For ibt
-LICENSE:${PN}-ibt-license = "LicenseRef-Firmware-ibt-firmware"
-LICENSE:${PN}-ibt-hw-37-7 = "LicenseRef-Firmware-ibt-firmware"
-LICENSE:${PN}-ibt-hw-37-8 = "LicenseRef-Firmware-ibt-firmware"
-LICENSE:${PN}-ibt-11-5    = "LicenseRef-Firmware-ibt-firmware"
-LICENSE:${PN}-ibt-12-16   = "LicenseRef-Firmware-ibt-firmware"
-LICENSE:${PN}-ibt-17 = "LicenseRef-Firmware-ibt-firmware"
-LICENSE:${PN}-ibt-18    = "LicenseRef-Firmware-ibt-firmware"
-LICENSE:${PN}-ibt-20 = "LicenseRef-Firmware-ibt-firmware"
-LICENSE:${PN}-ibt-misc    = "LicenseRef-Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-license = "Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-hw-37-7 = "Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-hw-37-8 = "Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-11-5    = "Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-12-16   = "Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-17 = "Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-18    = "Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-20 = "Firmware-ibt-firmware"
+LICENSE:${PN}-ibt-misc    = "Firmware-ibt-firmware"
 
 FILES:${PN}-ibt-license = "${firmwaredir}/LICENCE.ibt_firmware"
 FILES:${PN}-ibt-hw-37-7 = "${firmwaredir}/intel/ibt-hw-37.7*.bseq*"
@@ -2286,15 +2286,15 @@ RDEPENDS:${PN}-ibt-misc    = "${PN}-ibt-license"
 ALLOW_EMPTY:${PN}-ibt = "1"
 ALLOW_EMPTY:${PN}-ibt-misc = "1"
 
-LICENSE:${PN}-i915       = "LicenseRef-Firmware-i915"
-LICENSE:${PN}-i915-license = "LicenseRef-Firmware-i915"
+LICENSE:${PN}-i915       = "Firmware-i915"
+LICENSE:${PN}-i915-license = "Firmware-i915"
 FILES:${PN}-i915-license = "${firmwaredir}/LICENSE.i915"
 FILES:${PN}-i915         = "${firmwaredir}/i915"
 RDEPENDS:${PN}-i915      = "${PN}-i915-license"
 
 # For ice-enhanced
-LICENSE:${PN}-ice-enhanced         = "LicenseRef-Firmware-ice-enhanced"
-LICENSE:${PN}-ice-enhanced-license = "LicenseRef-Firmware-ice-enhanced"
+LICENSE:${PN}-ice-enhanced         = "Firmware-ice-enhanced"
+LICENSE:${PN}-ice-enhanced-license = "Firmware-ice-enhanced"
 
 FILES:${PN}-ice-enhanced           = " \
   ${firmwaredir}/intel/ice/ddp-comms/* \
@@ -2305,8 +2305,8 @@ FILES:${PN}-ice-enhanced-license   = " \
 "
 RDEPENDS:${PN}-ice-enhanced        = "${PN}-ice-enhanced-license"
 
-LICENSE:${PN}-ice       = "LicenseRef-Firmware-ice"
-LICENSE:${PN}-ice-license = "LicenseRef-Firmware-ice"
+LICENSE:${PN}-ice       = "Firmware-ice"
+LICENSE:${PN}-ice-license = "Firmware-ice"
 FILES:${PN}-ice-license = "${firmwaredir}/LICENSE.ice"
 FILES:${PN}-ice         = " \
   ${firmwaredir}/intel/ice/ddp/* \
@@ -2315,8 +2315,8 @@ FILES:${PN}-ice         = " \
 RDEPENDS:${PN}-ice      = "${PN}-ice-license"
 
 FILES:${PN}-adsp-sst-license      = "${firmwaredir}/LICENCE.adsp_sst"
-LICENSE:${PN}-adsp-sst            = "LicenseRef-Firmware-adsp-sst"
-LICENSE:${PN}-adsp-sst-license    = "LicenseRef-Firmware-adsp-sst"
+LICENSE:${PN}-adsp-sst            = "Firmware-adsp-sst"
+LICENSE:${PN}-adsp-sst-license    = "Firmware-adsp-sst"
 FILES:${PN}-adsp-sst              = "\
     ${firmwaredir}/intel/dsp_fw* \
     ${firmwaredir}/intel/avs/*/dsp_basefw.bin \
@@ -2329,151 +2329,151 @@ LICENSE:${PN}-snd-soc-avs = "Apache-2.0"
 FILES:${PN}-snd-soc-avs = "${firmwaredir}/intel/avs/*"
 
 # For QAT
-LICENSE:${PN}-qat         = "LicenseRef-Firmware-qat"
-LICENSE:${PN}-qat-license = "LicenseRef-Firmware-qat"
+LICENSE:${PN}-qat         = "Firmware-qat"
+LICENSE:${PN}-qat-license = "Firmware-qat"
 FILES:${PN}-qat-license   = "${firmwaredir}/LICENCE.qat_firmware"
 FILES:${PN}-qat           = "${firmwaredir}/qat*.bin* ${firmwaredir}/intel/qat/qat*.bin*"
 RDEPENDS:${PN}-qat        = "${PN}-qat-license"
 
-LICENSE:${PN}-qed         = "LicenseRef-Firmware-WHENCE"
+LICENSE:${PN}-qed         = "Firmware-WHENCE"
 FILES:${PN}-qed           = "${firmwaredir}/qed/*"
 
-LICENSE:${PN}-linaro-license = "LicenseRef-Firmware-linaro"
+LICENSE:${PN}-linaro-license = "Firmware-linaro"
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
-LICENSE:${PN}-qcom-glymur-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-glymur-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-glymur-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-hawi-audio = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-kaanapali-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-kaanapali-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-kaanapali-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-kaanapali-soccp = "LicenseRef-Firmware-qcom-2"
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
-LICENSE:${PN}-qcom-sdm845-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-modem = "LicenseRef-Firmware-qcom"
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
+LICENSE:${PN}-qcom-glymur-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-glymur-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-glymur-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-hawi-audio = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-kaanapali-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-kaanapali-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-kaanapali-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-kaanapali-soccp = "Firmware-qcom-2"
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
+LICENSE:${PN}-qcom-sdm845-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-modem = "Firmware-qcom"
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
@@ -2823,58 +2823,58 @@ RRECOMMENDS:${PN}-qcom-sc8280xp-lenovo-x13s-compute = "${PN}-qcom-sc8280xp-lenov
 RRECOMMENDS:${PN}-qcom-sc8280xp-lenovo-x13s-sensors = "${PN}-qcom-sc8280xp-lenovo-x13s-compat"
 RRECOMMENDS:${PN}-qcom-sc8280xp-lenovo-x13s-vpu = "${PN}-qcom-sc8280xp-lenovo-x13s-compat"
 
-LICENSE:${PN}-liquidui = "LicenseRef-Firmware-cavium-liquidio"
+LICENSE:${PN}-liquidui = "Firmware-cavium-liquidio"
 FILES:${PN}-liquidio = "${firmwaredir}/liquidio"
 
-LICENSE:${PN}-mellanox = "LicenseRef-Firmware-WHENCE"
+LICENSE:${PN}-mellanox = "Firmware-WHENCE"
 FILES:${PN}-mellanox = "${firmwaredir}/mellanox"
 
-LICENSE:${PN}-mm8108 = "LicenseRef-Firmware-morsemicro"
+LICENSE:${PN}-mm8108 = "Firmware-morsemicro"
 FILES:${PN}-mm8108 = "${firmwaredir}/morsemicro/mm81x/v56/*"
 
-LICENSE:${PN}-prestera = "LicenseRef-Firmware-Marvell"
+LICENSE:${PN}-prestera = "Firmware-Marvell"
 FILES:${PN}-prestera = "${firmwaredir}/mrvl/prestera"
 RDEPENDS:${PN}-prestera = "${PN}-marvell-license"
 
 # For Rockchip
-LICENSE:${PN}-rockchip-dptx = "LicenseRef-Firmware-rockchip"
+LICENSE:${PN}-rockchip-dptx = "Firmware-rockchip"
 FILES:${PN}-rockchip-license = "${firmwaredir}/LICENCE.rockchip"
 FILES:${PN}-rockchip-dptx = "${firmwaredir}/rockchip/dptx.bin*"
 RDEPENDS:${PN}-rockchip-dptx = "${PN}-rockchip-license"
 
 # For Amlogic VDEC
-LICENSE:${PN}-amlogic-vdec = "LicenseRef-Firmware-amlogic-vdec"
+LICENSE:${PN}-amlogic-vdec = "Firmware-amlogic-vdec"
 FILES:${PN}-amlogic-vdec-license = "${firmwaredir}/LICENSE.amlogic_vdec"
 FILES:${PN}-amlogic-vdec = "${firmwaredir}/meson/vdec/*"
 RDEPENDS:${PN}-amlogic-vdec = "${PN}-amlogic-vdec-license"
 
 # For 3com typhoon
-LICENSE:${PN}-typhoon-license = "LicenseRef-Firmware-typhoon"
-LICENSE:${PN}-typhoon = "LicenseRef-Firmware-typhoon"
+LICENSE:${PN}-typhoon-license = "Firmware-typhoon"
+LICENSE:${PN}-typhoon = "Firmware-typhoon"
 FILES:${PN}-typhoon-license = "${firmwaredir}/LICENCE.typhoon"
 FILES:${PN}-typhoon = "${firmwaredir}/3com/typhoon.bin*"
 RDEPENDS:${PN}-typhoon = "${PN}-typhoon-license"
 
 # For ish - Intel Integrated Sensor Hub
-LICENSE:${PN}-intel-license = "LicenseRef-Firmware-intel"
+LICENSE:${PN}-intel-license = "Firmware-intel"
 FILES:${PN}-intel-license = "${firmwaredir}/LICENSE.intel"
 
-LICENSE:${PN}-ish-lnlm = "LicenseRef-Firmware-intel"
+LICENSE:${PN}-ish-lnlm = "Firmware-intel"
 FILES:${PN}-ish-lnlm = "${firmwaredir}/intel/ish/ish_lnlm.bin*"
 RDEPENDS:${PN}-ish-lnlm = "${PN}-intel-license"
 
 # For Dell ish - Intel Integrated Sensor Hub
-LICENSE:${PN}-dell-license = "LicenseRef-Firmware-dell"
+LICENSE:${PN}-dell-license = "Firmware-dell"
 FILES:${PN}-dell-license = "${firmwaredir}/LICENSE.dell"
 
-LICENSE:${PN}-ish-lnlm-39ceeaf8 = "LicenseRef-Firmware-dell"
+LICENSE:${PN}-ish-lnlm-39ceeaf8 = "Firmware-dell"
 FILES:${PN}-ish-lnlm-39ceeaf8 =  "\
     ${firmwaredir}/intel/ish/ish_lnlm_39ceeaf8.bin* \
     ${firmwaredir}/dell/ish/ish_lnlm_39ceeaf8_*.bin* \
 "
 RDEPENDS:${PN}-ish-lnlm-39ceeaf8 = "${PN}-dell-license"
 
-LICENSE:${PN}-ish-ptl-39ceeaf8 = "LicenseRef-Firmware-dell"
+LICENSE:${PN}-ish-ptl-39ceeaf8 = "Firmware-dell"
 FILES:${PN}-ish-ptl-39ceeaf8 =  "\
     ${firmwaredir}/intel/ish/ish_ptl_39ceeaf8.bin* \
     ${firmwaredir}/dell/ish/ish_ptl_39ceeaf8_*.bin* \
@@ -2882,27 +2882,27 @@ FILES:${PN}-ish-ptl-39ceeaf8 =  "\
 RDEPENDS:${PN}-ish-ptl-39ceeaf8 = "${PN}-dell-license"
 
 # For HP ish - Intel Integrated Sensor Hub
-LICENSE:${PN}-hp-license = "LicenseRef-Firmware-HP"
+LICENSE:${PN}-hp-license = "Firmware-HP"
 FILES:${PN}-hp-license = "${firmwaredir}/LICENSE.HP"
 
-LICENSE:${PN}-ish-lnlm-12128606 = "LicenseRef-Firmware-HP"
+LICENSE:${PN}-ish-lnlm-12128606 = "Firmware-HP"
 FILES:${PN}-ish-lnlm-12128606 = " \
     ${firmwaredir}/intel/ish/ish_lnlm_12128606_*.bin* \
     ${firmwaredir}/HP/ish/ish_lnlm_12128606_*.bin* \
 "
 RDEPENDS:${PN}-ish-lnlm-12128606 = "${PN}-hp-license"
 
-LICENSE:${PN}-ish-ptl-12128606 = "LicenseRef-Firmware-HP"
+LICENSE:${PN}-ish-ptl-12128606 = "Firmware-HP"
 FILES:${PN}-ish-ptl-12128606 = " \
     ${firmwaredir}/HP/ish/ish_ptl_12128606_*.bin* \
 "
 RDEPENDS:${PN}-ish-ptl-12128606 = "${PN}-hp-license"
 
 # For LENOVO ish - Intel Integrated Sensor Hub
-LICENSE:${PN}-lenovo-license = "LicenseRef-Firmware-lenovo"
+LICENSE:${PN}-lenovo-license = "Firmware-lenovo"
 FILES:${PN}-lenovo-license = "${firmwaredir}/LICENCE.lenovo"
 
-LICENSE:${PN}-ish-lnlm-53c4ffad = "LicenseRef-Firmware-lenovo"
+LICENSE:${PN}-ish-lnlm-53c4ffad = "Firmware-lenovo"
 FILES:${PN}-ish-lnlm-53c4ffad = "\
     ${firmwaredir}/intel/ish/ish_lnlm_53c4ffad_*.bin* \
     ${firmwaredir}/LENOVO/ish/ish_lnlm_lenovo_X1_2025_5.8.4.7720.bin* \
@@ -2911,59 +2911,59 @@ FILES:${PN}-ish-lnlm-53c4ffad = "\
 "
 RDEPENDS:${PN}-ish-lnlm-53c4ffad = "${PN}-lenovo-license"
 
-LICENSE:${PN}-ish-ptl = "LicenseRef-Firmware-intel"
+LICENSE:${PN}-ish-ptl = "Firmware-intel"
 FILES:${PN}-ish-ptl = "${firmwaredir}/intel/ish/ish_ptl.bin*"
 RDEPENDS:${PN}-ish-ptl = "${PN}-intel-license"
 
-LICENSE:${PN}-ish-ptl-53c4ffad = "LicenseRef-Firmware-lenovo"
+LICENSE:${PN}-ish-ptl-53c4ffad = "Firmware-lenovo"
 FILES:${PN}-ish-ptl-53c4ffad = "\
     ${firmwaredir}/intel/ish/ish_ptl_53c4ffad_*.bin* \
     ${firmwaredir}/LENOVO/ish/ish_ptl_lenovo_X1_2026_5.8.1.7782.bin* \
 "
 RDEPENDS:${PN}-ish-ptl-53c4ffad = "${PN}-lenovo-license"
 
-LICENSE:${PN}-ish-wcl = "LicenseRef-Firmware-intel"
+LICENSE:${PN}-ish-wcl = "Firmware-intel"
 FILES:${PN}-ish-wcl = "${firmwaredir}/intel/ish/ish_wcl.bin*"
 RDEPENDS:${PN}-ish-wcl = "${PN}-intel-license"
 
 # For advansys - AdvanSys SCSI
-LICENSE:${PN}-advansys-license = "LicenseRef-Firmware-advansys"
+LICENSE:${PN}-advansys-license = "Firmware-advansys"
 FILES:${PN}-advansys-license = "${firmwaredir}/LICENCE.advansys"
 
-LICENSE:${PN}-advansys = "LicenseRef-Firmware-advansys"
+LICENSE:${PN}-advansys = "Firmware-advansys"
 FILES:${PN}-advansys = "${firmwaredir}/advansys/*"
 RDEPENDS:${PN}-advansys = "${PN}-advansys-license"
 
 # For as21xxx
-LICENSE:${PN}-aeonsemi-license = "LicenseRef-Firmware-aeonsemi"
+LICENSE:${PN}-aeonsemi-license = "Firmware-aeonsemi"
 FILES:${PN}-aeonsemi-license = "${firmwaredir}/LICENSE.aeonsemi"
 
-LICENSE:${PN}-as21xxx = "LicenseRef-Firmware-aeonsemi"
+LICENSE:${PN}-as21xxx = "Firmware-aeonsemi"
 FILES:${PN}-as21xxx = "${firmwaredir}/aeonsemi/*"
 RDEPENDS:${PN}-as21xxx = "${PN}-aeonsemi-license"
 
 # For orinoco - Agere/Prism/Symbol Orinoco support
-LICENSE:${PN}-agere-license = "LicenseRef-Firmware-agere"
+LICENSE:${PN}-agere-license = "Firmware-agere"
 FILES:${PN}-agere-license = "${firmwaredir}/LICENCE.agere"
 
-LICENSE:${PN}-orinoco = "LicenseRef-Firmware-agere"
+LICENSE:${PN}-orinoco = "Firmware-agere"
 FILES:${PN}-orinoco = "${firmwaredir}/agere_*"
 RDEPENDS:${PN}-orinoco = "${PN}-agere-license"
 
 # For en8811h - Airoha 2.5G Ethernet Phy
-LICENSE:${PN}-airoha-license = "LicenseRef-Firmware-airoha"
+LICENSE:${PN}-airoha-license = "Firmware-airoha"
 FILES:${PN}-airoha-license = "${firmwaredir}/LICENSE.airoha"
 
-LICENSE:${PN}-an8811hb = "LicenseRef-Firmware-airoha"
+LICENSE:${PN}-an8811hb = "Firmware-airoha"
 FILES:${PN}-an8811hb = "${firmwaredir}/airoha/an8811hb/EthMD32*"
 RDEPENDS:${PN}-an8811hb = "${PN}-airoha-license"
 
-LICENSE:${PN}-en8811h = "LicenseRef-Firmware-airoha"
+LICENSE:${PN}-en8811h = "Firmware-airoha"
 FILES:${PN}-en8811h = "${firmwaredir}/airoha/EthMD32*"
 RDEPENDS:${PN}-en8811h = "${PN}-airoha-license"
 
 # For airoha-npu - Airoha Network Processor Unit driver
-LICENSE:${PN}-airoha-npu = "LicenseRef-Firmware-airoha"
+LICENSE:${PN}-airoha-npu = "Firmware-airoha"
 FILES:${PN}-airoha-npu = " \
     ${firmwaredir}/airoha/an7583_npu* \
     ${firmwaredir}/airoha/en7581_npu* \
@@ -2972,10 +2972,10 @@ FILES:${PN}-airoha-npu = " \
 RDEPENDS:${PN}-airoha-npu = "${PN}-airoha-license"
 
 # For ccp - Platform Security Processor (PSP) device
-LICENSE:${PN}-amd-sev-license = "LicenseRef-Firmware-amd-sev"
+LICENSE:${PN}-amd-sev-license = "Firmware-amd-sev"
 FILES:${PN}-amd-sev-license = "${firmwaredir}/LICENSE.amd-sev"
 
-LICENSE:${PN}-ccp = "LicenseRef-Firmware-amd-sev"
+LICENSE:${PN}-ccp = "Firmware-amd-sev"
 FILES:${PN}-ccp = " \
     ${firmwaredir}/amd/amd_sev* \
     ${firmwaredir}/amd/README* \
@@ -2983,34 +2983,34 @@ FILES:${PN}-ccp = " \
 RDEPENDS:${PN}-ccp = "${PN}-amd-sev-license"
 
 # For amdxdna - AMD Inference processor
-LICENSE:${PN}-amdnpu-license = "LicenseRef-Firmware-amdnpu"
+LICENSE:${PN}-amdnpu-license = "Firmware-amdnpu"
 FILES:${PN}-amdnpu-license = "${firmwaredir}/LICENSE.amdnpu"
 
-LICENSE:${PN}-amdxdna = "LicenseRef-Firmware-amdnpu"
+LICENSE:${PN}-amdxdna = "Firmware-amdnpu"
 FILES:${PN}-amdxdna = "${firmwaredir}/amdnpu/*"
 RDEPENDS:${PN}-amdxdna = "${PN}-amdnpu-license"
 
 # For amd_pmf - AMD Platform Management Framework TA
-LICENSE:${PN}-amd-pmf-license = "LicenseRef-Firmware-amd-pmf"
+LICENSE:${PN}-amd-pmf-license = "Firmware-amd-pmf"
 FILES:${PN}-amd-pmf-license = "${firmwaredir}/LICENSE.amd_pmf"
 
-LICENSE:${PN}-amd-pmf = "LicenseRef-Firmware-amd-pmf"
+LICENSE:${PN}-amd-pmf = "Firmware-amd-pmf"
 FILES:${PN}-amd-pmf = "${firmwaredir}/amdtee/*"
 RDEPENDS:${PN}-amd-pmf = "${PN}-amd-pmf-license"
 
 # For microcode_amd - AMD CPU Microcode Update Driver for Linux
-LICENSE:${PN}-amd-ucode-license = "LicenseRef-Firmware-amd-ucode"
+LICENSE:${PN}-amd-ucode-license = "Firmware-amd-ucode"
 FILES:${PN}-amd-ucode-license = "${firmwaredir}/LICENSE.amd-ucode"
 
-LICENSE:${PN}-microcode-amd = "LicenseRef-Firmware-amd-ucode"
+LICENSE:${PN}-microcode-amd = "Firmware-amd-ucode"
 FILES:${PN}-microcode-amd = "${firmwaredir}/amd-ucode/*"
 RDEPENDS:${PN}-microcode-amd = "${PN}-amd-ucode-license"
 
 # For amlogic - Amlogic SoC Firmware
-LICENSE:${PN}-amlogic-license = "LicenseRef-Firmware-amlogic"
+LICENSE:${PN}-amlogic-license = "Firmware-amlogic"
 FILES:${PN}-amlogic-license = "${firmwaredir}/LICENSE.amlogic"
 
-LICENSE:${PN}-amlogic = "LicenseRef-Firmware-amlogic"
+LICENSE:${PN}-amlogic = "Firmware-amlogic"
 FILES:${PN}-amlogic = "${firmwaredir}/amlogic/aml_*"
 RDEPENDS:${PN}-amlogic = "${PN}-amlogic-license"
 
@@ -3019,22 +3019,22 @@ LICENSE:${PN}-starfire = "GPL-2.0-only"
 FILES:${PN}-starfire = "${firmwaredir}/adaptec/starfire*"
 
 # For as102 - Abilis Systems Single DVB-T Receiver
-LICENSE:${PN}-abilis-license = "LicenseRef-Firmware-Abilis"
+LICENSE:${PN}-abilis-license = "Firmware-Abilis"
 FILES:${PN}-abilis-license = "${firmwaredir}/LICENCE.Abilis"
 
-LICENSE:${PN}-as102 = "LicenseRef-Firmware-Abilis"
+LICENSE:${PN}-as102 = "Firmware-Abilis"
 FILES:${PN}-as102 = "${firmwaredir}/as102_data*_st.hex*"
 RDEPENDS:${PN}-as102 = "${PN}-abilis-license"
 
 # For wilc1000 - Atmel 802.11n WLAN driver for WILC1000 & WILC3000
-LICENSE:${PN}-atmel-license = "LicenseRef-Firmware-atmel"
+LICENSE:${PN}-atmel-license = "Firmware-atmel"
 FILES:${PN}-atmel-license = "${firmwaredir}/LICENSE.atmel"
 
-LICENSE:${PN}-wilc1000 = "LicenseRef-Firmware-atmel"
+LICENSE:${PN}-wilc1000 = "Firmware-atmel"
 FILES:${PN}-wilc1000 = "${firmwaredir}/atmel/wilc1000*"
 RDEPENDS:${PN}-wilc1000 = "${PN}-atmel-license"
 
-LICENSE:${PN}-wilc3000 = "LicenseRef-Firmware-atmel"
+LICENSE:${PN}-wilc3000 = "Firmware-atmel"
 FILES:${PN}-wilc3000 = "${firmwaredir}/atmel/wilc3000*"
 RDEPENDS:${PN}-wilc3000 = "${PN}-atmel-license"
 
@@ -3047,42 +3047,42 @@ FILES:${PN}-dvb-ttpci = "${firmwaredir}/av7110/*"
 LICENSE:${PN}-dvb-ttpci = "GPL-2.0-or-later"
 
 # For bmi260 - Bosch BMI260 IMU configuration data
-LICENSE:${PN}-bmi260-license = "LicenseRef-Firmware-bmi260"
+LICENSE:${PN}-bmi260-license = "Firmware-bmi260"
 FILES:${PN}-bmi260-license = "${firmwaredir}/LICENSE.bmi260"
 
-LICENSE:${PN}-bmi260 = "LicenseRef-Firmware-bmi260"
+LICENSE:${PN}-bmi260 = "Firmware-bmi260"
 FILES:${PN}-bmi260 = "${firmwaredir}/bmi260-init-data.fw*"
 RDEPENDS:${PN}-bmi260 = "${PN}-bmi260-license"
 
 # For cdns-mhdp - Cadence MHDP8546 DP bridge
-LICENSE:${PN}-cadence-license = "LicenseRef-Firmware-cadence"
+LICENSE:${PN}-cadence-license = "Firmware-cadence"
 FILES:${PN}-cadence-license = "${firmwaredir}/LICENCE.cadence"
 
-LICENSE:${PN}-mhdp8546 = "LicenseRef-Firmware-cadence"
+LICENSE:${PN}-mhdp8546 = "Firmware-cadence"
 FILES:${PN}-mhdp8546 = "${firmwaredir}/cadence/mhdp8546.bin*"
 RDEPENDS:${PN}-mhdp8546 = "${PN}-cadence-license"
 
 # For nitrox - Cavium CNN55XX crypto driver
-LICENSE:${PN}-cavium-license = "LicenseRef-Firmware-cavium"
+LICENSE:${PN}-cavium-license = "Firmware-cavium"
 FILES:${PN}-cavium-license = "${firmwaredir}/LICENCE.cavium"
 
-LICENSE:${PN}-cnn55xx = "LicenseRef-Firmware-cavium"
+LICENSE:${PN}-cnn55xx = "Firmware-cavium"
 FILES:${PN}-cnn55xx = "${firmwaredir}/cavium/cnn55xx*"
 RDEPENDS:${PN}-cnn55xx = "${PN}-cavium-license"
 
 # For BFA/BNA - QLogic BR-series Adapter FC/FCOE drivers
-LICENSE:${PN}-bfa-license = "LicenseRef-Firmware-bfa"
+LICENSE:${PN}-bfa-license = "Firmware-bfa"
 FILES:${PN}-bfa-license = "${firmwaredir}/LICENSE.bfa"
 
-LICENSE:${PN}-cbfw = "LicenseRef-Firmware-bfa"
+LICENSE:${PN}-cbfw = "Firmware-bfa"
 FILES:${PN}-cbfw = "${firmwaredir}/cbfw-3.2.5.1.bin*"
 RDEPENDS:${PN}-cbfw = "${PN}-bfa-license"
 
-LICENSE:${PN}-ctfw = "LicenseRef-Firmware-bfa"
+LICENSE:${PN}-ctfw = "Firmware-bfa"
 FILES:${PN}-ctfw = "${firmwaredir}/ctfw-3.2.5.1.bin*"
 RDEPENDS:${PN}-ctfw = "${PN}-bfa-license"
 
-LICENSE:${PN}-ct2fw = "LicenseRef-Firmware-bfa"
+LICENSE:${PN}-ct2fw = "Firmware-bfa"
 FILES:${PN}-ct2fw = "${firmwaredir}/ct2fw-3.2.5.1.bin*"
 RDEPENDS:${PN}-ct2fw = "${PN}-bfa-license"
 
@@ -3096,15 +3096,15 @@ FILES:${PN}-pcnet-cs = " \
     ${firmwaredir}/cis/PE-200.cis* \
     ${firmwaredir}/cis/PE520.cis* \
 "
-LICENSE:${PN}-pcnet-cs = "GPL-2.0-only AND MPL-1.1"
+LICENSE:${PN}-pcnet-cs = "GPL-2.0-only & MPL-1.1"
 
 # For 3c589_cs - 3Com PCMCIA adapter
 FILES:${PN}-3c589-cs = "${firmwaredir}/cis/3CXEM556.cis*"
-LICENSE:${PN}-3c589-cs = "GPL-2.0-only AND MPL-1.1"
+LICENSE:${PN}-3c589-cs = "GPL-2.0-only & MPL-1.1"
 
 # For 3c574-cs - 3Com PCMCIA adapter
 FILES:${PN}-3c574-cs = "${firmwaredir}/cis/3CCFEM556.cis*"
-LICENSE:${PN}-3c574-cs = "GPL-2.0-only AND MPL-1.1"
+LICENSE:${PN}-3c574-cs = "GPL-2.0-only & MPL-1.1"
 
 # For serial_cs - Serial PCMCIA adapter (pcmcia-cs project)
 FILES:${PN}-serial-cs = " \
@@ -3113,7 +3113,7 @@ FILES:${PN}-serial-cs = " \
     ${firmwaredir}/cis/COMpad2.cis* \
     ${firmwaredir}/cis/COMpad4.cis* \
 "
-LICENSE:${PN}-serial-cs = "GPL-2.0-only AND MPL-1.1"
+LICENSE:${PN}-serial-cs = "GPL-2.0-only & MPL-1.1"
 
 # For Sierra Wireless serial_cs - Serial PCMCIA adapter
 FILES:${PN}-sw-serial = " \
@@ -3124,10 +3124,10 @@ FILES:${PN}-sw-serial = " \
 LICENSE:${PN}-sw-serial = "GPL-3.0-only"
 
 # For smsmdtv - Siano MDTV Core module
-LICENSE:${PN}-siano-license = "LicenseRef-Firmware-siano"
+LICENSE:${PN}-siano-license = "Firmware-siano"
 FILES:${PN}-siano-license = "${firmwaredir}/LICENCE.siano"
 
-LICENSE:${PN}-smsmdtv = "LicenseRef-Firmware-siano"
+LICENSE:${PN}-smsmdtv = "Firmware-siano"
 FILES:${PN}-smsmdtv = " \
     ${firmwaredir}/cmmb_vega_12mhz.inp* \
     ${firmwaredir}/cmmb_venice_12mhz.inp* \
@@ -3150,10 +3150,10 @@ FILES:${PN}-cpia2 = "${firmwaredir}/cpia2/*"
 LICENSE:${PN}-cpia2 = "GPL-2.0-or-later"
 
 # For snd-hda-codec-ca0132 - Creative Sound Core3D codec
-LICENSE:${PN}-ca0132-license = "LicenseRef-Firmware-ca0132"
+LICENSE:${PN}-ca0132-license = "Firmware-ca0132"
 FILES:${PN}-ca0132-license = "${firmwaredir}/LICENCE.ca0132"
 
-LICENSE:${PN}-ca0132 = "LicenseRef-Firmware-ca0132"
+LICENSE:${PN}-ca0132 = "Firmware-ca0132"
 FILES:${PN}-ca0132 = " \
     ${firmwaredir}/ctefx.bin* \
     ${firmwaredir}/ctspeq.bin* \
@@ -3161,26 +3161,26 @@ FILES:${PN}-ca0132 = " \
 RDEPENDS:${PN}-ca0132 = "${PN}-ca0132-license"
 
 # For cxgb3 - Chelsio Terminator 3 1G/10G Ethernet adapter
-LICENSE:${PN}-cxgb3-license = "LicenseRef-Firmware-cxgb3"
+LICENSE:${PN}-cxgb3-license = "Firmware-cxgb3"
 FILES:${PN}-cxgb3-license = "${firmwaredir}/LICENCE.cxgb3"
 
-LICENSE:${PN}-cxgb3 = "LicenseRef-Firmware-cxgb3 AND GPL-2.0-only"
+LICENSE:${PN}-cxgb3 = "Firmware-cxgb3 & GPL-2.0-only"
 FILES:${PN}-cxgb3 = "${firmwaredir}/cxgb3/*"
 RDEPENDS:${PN}-cxgb3 = "${PN}-cxgb3-license"
 
 # For cxgb4 - Chelsio Terminator 4/5/6 1/10/25/40/100G Ethernet adapter
-LICENSE:${PN}-chelsio-firmware-license = "LicenseRef-Firmware-chelsio-firmware"
+LICENSE:${PN}-chelsio-firmware-license = "Firmware-chelsio-firmware"
 FILES:${PN}-chelsio-firmware-license = "${firmwaredir}/LICENCE.chelsio_firmware"
 
-LICENSE:${PN}-cxgb4 = "LicenseRef-Firmware-chelsio-firmware"
+LICENSE:${PN}-cxgb4 = "Firmware-chelsio-firmware"
 FILES:${PN}-cxgb4 = "${firmwaredir}/cxgb4/*"
 RDEPENDS:${PN}-cxgb4 = "${PN}-chelsio-firmware-license"
 
 # For dabusb - Digital Audio Broadcasting (DAB) Receiver for USB and Linux
-LICENSE:${PN}-dabusb-license = "LicenseRef-Firmware-dabusb"
+LICENSE:${PN}-dabusb-license = "Firmware-dabusb"
 FILES:${PN}-dabusb-license = "${firmwaredir}/LICENCE.dabusb"
 
-LICENSE:${PN}-dabusb = "LicenseRef-Firmware-dabusb"
+LICENSE:${PN}-dabusb = "Firmware-dabusb"
 FILES:${PN}-dabusb = "${firmwaredir}/dabusb/*"
 RDEPENDS:${PN}-dabusb = "${PN}-dabusb-license"
 
@@ -3189,34 +3189,34 @@ LICENSE:${PN}-dsp56k = "GPL-2.0-or-later"
 FILES:${PN}-dsp56k = "${firmwaredir}/dsp56k/*"
 
 # For dib0700 - DiBcom dib0700 USB DVB bridge driver
-LICENSE:${PN}-dib0700-license = "LicenseRef-Firmware-dib0700"
+LICENSE:${PN}-dib0700-license = "Firmware-dib0700"
 FILES:${PN}-dib0700-license = "${firmwaredir}/LICENSE.dib0700"
 
-LICENSE:${PN}-dib0700 = "LicenseRef-Firmware-dib0700"
+LICENSE:${PN}-dib0700 = "Firmware-dib0700"
 FILES:${PN}-dib0700 = "${firmwaredir}/dvb-usb-dib0700-1.20.fw*"
 RDEPENDS:${PN}-dib0700 = "${PN}-dib0700-license"
 
 # For it9135 - ITEtech IT913x DVB-T USB driver
-LICENSE:${PN}-it913x-license = "LicenseRef-Firmware-it913x"
+LICENSE:${PN}-it913x-license = "Firmware-it913x"
 FILES:${PN}-it913x-license = "${firmwaredir}/LICENCE.it913x"
 
-LICENSE:${PN}-it9135 = "LicenseRef-Firmware-it913x"
+LICENSE:${PN}-it9135 = "Firmware-it913x"
 FILES:${PN}-it9135 = "${firmwaredir}/dvb-usb-it9135*"
 RDEPENDS:${PN}-it9135 = "${PN}-it913x-license"
 
 # For drxk - Micronas DRX-K demodulator driver
-LICENSE:${PN}-drxk-license = "LicenseRef-Firmware-drxk"
+LICENSE:${PN}-drxk-license = "Firmware-drxk"
 FILES:${PN}-drxk-license = "${firmwaredir}/LICENSE.drxk"
 
-LICENSE:${PN}-drxk = "LicenseRef-Firmware-drxk"
+LICENSE:${PN}-drxk = "Firmware-drxk"
 FILES:${PN}-drxk = "${firmwaredir}/dvb-usb-terratec-h5-drxk.fw*"
 RDEPENDS:${PN}-drxk = "${PN}-drxk-license"
 
 # For e100 - Intel PRO/100 Ethernet NIC
-LICENSE:${PN}-e100-license = "LicenseRef-Firmware-e100"
+LICENSE:${PN}-e100-license = "Firmware-e100"
 FILES:${PN}-e100-license = "${firmwaredir}/LICENCE.e100"
 
-LICENSE:${PN}-e100 = "LicenseRef-Firmware-e100"
+LICENSE:${PN}-e100 = "Firmware-e100"
 FILES:${PN}-e100 = "${firmwaredir}/e100/*"
 RDEPENDS:${PN}-e100 = "${PN}-e100-license"
 
@@ -3229,26 +3229,26 @@ LICENSE:${PN}-io-edgeport = "GPL-2.0-or-later"
 FILES:${PN}-io-edgeport = "${firmwaredir}/edgeport/*"
 
 # For emi26 - EMI 2|6 USB Audio interface
-LICENSE:${PN}-emi26-license = "LicenseRef-Firmware-emi26"
+LICENSE:${PN}-emi26-license = "Firmware-emi26"
 FILES:${PN}-emi26-license = "${firmwaredir}/LICENCE.emi26"
 
-LICENSE:${PN}-emi26 = "LicenseRef-Firmware-emi26"
+LICENSE:${PN}-emi26 = "Firmware-emi26"
 FILES:${PN}-emi26 = "${firmwaredir}/emi26/*"
 RDEPENDS:${PN}-emi26 = "${PN}-drxk-license"
 
 # For ene-ub6250 - ENE UB6250 SD card reader driver
-LICENSE:${PN}-ene-firmware-license = "LicenseRef-Firmware-ene-firmware"
+LICENSE:${PN}-ene-firmware-license = "Firmware-ene-firmware"
 FILES:${PN}-ene-firmware-license = "${firmwaredir}/LICENCE.ene_firmware"
 
-LICENSE:${PN}-ene-ub6250 = "LicenseRef-Firmware-ene-firmware"
+LICENSE:${PN}-ene-ub6250 = "Firmware-ene-firmware"
 FILES:${PN}-ene-ub6250 = "${firmwaredir}/ene-ub6250/*"
 RDEPENDS:${PN}-ene-ub6250 = "${PN}-ene-firmware-license"
 
 # For go7007-s2250
-LICENSE:${PN}-sensoray-license = "LicenseRef-Firmware-sensoray"
+LICENSE:${PN}-sensoray-license = "Firmware-sensoray"
 FILES:${PN}-sensoray-license = "${firmwaredir}/LICENCE.sensoray"
 
-LICENSE:${PN}-go7007-s2250 = "LicenseRef-Firmware-sensoray"
+LICENSE:${PN}-go7007-s2250 = "Firmware-sensoray"
 FILES:${PN}-go7007-s2250 = " \
     ${firmwaredir}/go7007/s2250* \
     ${firmwaredir}/s2250* \
@@ -3256,34 +3256,34 @@ FILES:${PN}-go7007-s2250 = " \
 RDEPENDS:${PN}-go7007-s2250 = "${PN}-sensoray-license"
 
 # For go7007
-LICENSE:${PN}-go7007-license = "LicenseRef-Firmware-go7007"
+LICENSE:${PN}-go7007-license = "Firmware-go7007"
 FILES:${PN}-go7007-license = "${firmwaredir}/LICENCE.go7007"
 
-LICENSE:${PN}-go7007 = "LicenseRef-Firmware-go7007"
+LICENSE:${PN}-go7007 = "Firmware-go7007"
 FILES:${PN}-go7007 = "${firmwaredir}/go7007/*"
 RDEPENDS:${PN}-go7007 = "${PN}-go7007-license"
 
 # For hfi1 - Intel OPA Gen 1 adapter
-LICENSE:${PN}-hfi1-license = "LicenseRef-Firmware-hfi1-firmware"
+LICENSE:${PN}-hfi1-license = "Firmware-hfi1-firmware"
 FILES:${PN}-hfi1-license = "${firmwaredir}/LICENSE.hfi1_firmware"
 
-LICENSE:${PN}-hfi1 = "LicenseRef-Firmware-hfi1-firmware"
+LICENSE:${PN}-hfi1 = "Firmware-hfi1-firmware"
 FILES:${PN}-hfi1 = "${firmwaredir}/hfi1_*"
 RDEPENDS:${PN}-hfi1 = "${PN}-hfi1-license"
 
 # For inside-secure - Inside Secure EIP197 crypto driver
-LICENSE:${PN}-inside-secure-license = "LicenseRef-Firmware-inside-secure"
+LICENSE:${PN}-inside-secure-license = "Firmware-inside-secure"
 FILES:${PN}-inside-secure-license = "${firmwaredir}/LICENCE.inside-secure"
 
-LICENSE:${PN}-inside-secure = "LicenseRef-Firmware-inside-secure"
+LICENSE:${PN}-inside-secure = "Firmware-inside-secure"
 FILES:${PN}-inside-secure = "${firmwaredir}/inside-secure/*"
 RDEPENDS:${PN}-inside-secure = "${PN}-inside-secure-license"
 
 # For snd_soc_catpt - Intel AudioDSP driver for HSW/BDW platforms
-LICENSE:${PN}-intcsst2-license = "LicenseRef-Firmware-IntcSST2"
+LICENSE:${PN}-intcsst2-license = "Firmware-IntcSST2"
 FILES:${PN}-intcsst2-license = "${firmwaredir}/LICENCE.IntcSST2"
 
-LICENSE:${PN}-snd-soc-catpt = "LicenseRef-Firmware-IntcSST2"
+LICENSE:${PN}-snd-soc-catpt = "Firmware-IntcSST2"
 FILES:${PN}-snd-soc-catpt = " \
     ${firmwaredir}/intel/catpt/bdw/dsp_basefw.bin* \
     ${firmwaredir}/intel/IntcSST2.bin* \
@@ -3291,36 +3291,36 @@ FILES:${PN}-snd-soc-catpt = " \
 RDEPENDS:${PN}-snd-soc-catpt = "${PN}-intcsst2-license"
 
 # For snd_intel_sst_core
-LICENSE:${PN}-fw-sst-0f28-license = "LicenseRef-Firmware-fw-sst-0f28"
+LICENSE:${PN}-fw-sst-0f28-license = "Firmware-fw-sst-0f28"
 FILES:${PN}-fw-sst-0f28-license = "${firmwaredir}/LICENCE.fw_sst_0f28"
 
-LICENSE:${PN}-snd-intel-sst-core = "LicenseRef-Firmware-fw-sst-0f28"
+LICENSE:${PN}-snd-intel-sst-core = "Firmware-fw-sst-0f28"
 FILES:${PN}-snd-intel-sst-core = "${firmwaredir}/intel/fw_sst_*"
 RDEPENDS:${PN}-snd-intel-sst-core = "${PN}-fw-sst-0f28-license"
 
 # For atomisp - Intel IPU2 (Image Processing Unit 2) driver
-LICENSE:${PN}-ivsc-license = "LicenseRef-Firmware-ivsc"
+LICENSE:${PN}-ivsc-license = "Firmware-ivsc"
 FILES:${PN}-ivsc-license = "${firmwaredir}/LICENSE.ivsc"
 
-LICENSE:${PN}-atomisp = "LicenseRef-Firmware-ivsc"
+LICENSE:${PN}-atomisp = "Firmware-ivsc"
 FILES:${PN}-atomisp = "${firmwaredir}/intel/ipu/shisp_240*"
 RDEPENDS:${PN}-atomisp = "${PN}-ivsc-license"
 
 # For intel-ipu6-isys - Intel IPU6 (Image Processing Unit 6) driver
-LICENSE:${PN}-intel-ipu6-isys = "LicenseRef-Firmware-ivsc"
+LICENSE:${PN}-intel-ipu6-isys = "Firmware-ivsc"
 FILES:${PN}-intel-ipu6-isys = "${firmwaredir}/intel/ipu/ipu6*"
 RDEPENDS:${PN}-intel-ipu6-isys = "${PN}-ivsc-license"
 
 # For mei-vsc-hw - Intel Visual Sensing Controller
-LICENSE:${PN}-mei-vsc-hw = "LicenseRef-Firmware-ivsc"
+LICENSE:${PN}-mei-vsc-hw = "Firmware-ivsc"
 FILES:${PN}-mei-vsc-hw = "${firmwaredir}/intel/vsc/*"
 RDEPENDS:${PN}-mei-vsc-hw = "${PN}-ivsc-license"
 
 # For ipu3-imgu - Intel IPU3 (3rd Gen Image Processing Unit) driver
-LICENSE:${PN}-ipu3-firmware-license = "LicenseRef-Firmware-ipu3-firmware"
+LICENSE:${PN}-ipu3-firmware-license = "Firmware-ipu3-firmware"
 FILES:${PN}-ipu3-firmware-license = "${firmwaredir}/LICENSE.ipu3_firmware"
 
-LICENSE:${PN}-ipu3-imgu = "LicenseRef-Firmware-ipu3-firmware"
+LICENSE:${PN}-ipu3-imgu = "Firmware-ipu3-firmware"
 FILES:${PN}-ipu3-imgu = " \
     ${firmwaredir}/intel/ipu/irci_irci_ecr-master_20161208_0213_20170112_1500.bin* \
     ${firmwaredir}/intel/ipu3-fw.bin* \
@@ -3329,15 +3329,15 @@ FILES:${PN}-ipu3-imgu = " \
 RDEPENDS:${PN}-ipu3-imgu = "${PN}-ipu3-firmware-license"
 
 # For intel-ipu7-isys - Intel IPU7 (Image Processing Unit 7) driver
-LICENSE:${PN}-intel-ipu7-isys = "LicenseRef-Firmware-intel"
+LICENSE:${PN}-intel-ipu7-isys = "Firmware-intel"
 FILES:${PN}-intel-ipu7-isys = "${firmwaredir}/intel/ipu/ipu7*"
 RDEPENDS:${PN}-intel-ipu7-isys = "${PN}-intel-license"
 
 # For intel_vpu - Intel NPU driver
-LICENSE:${PN}-intel-vpu-license = "LicenseRef-Firmware-intel-vpu"
+LICENSE:${PN}-intel-vpu-license = "Firmware-intel-vpu"
 FILES:${PN}-intel-vpu-license = "${firmwaredir}/LICENSE.intel_vpu"
 
-LICENSE:${PN}-intel-vpu = "LicenseRef-Firmware-intel-vpu"
+LICENSE:${PN}-intel-vpu = "Firmware-intel-vpu"
 FILES:${PN}-intel-vpu = "${firmwaredir}/intel/vpu/*"
 RDEPENDS:${PN}-intel-vpu = "${PN}-intel-vpu-license"
 
@@ -3346,26 +3346,26 @@ LICENSE:${PN}-isci = "GPL-2.0-only"
 FILES:${PN}-isci = "${firmwaredir}/isci/*"
 
 # For ixp4xx-npe - Intel IXP4xx XScale Network Processing Engine (NPE) Firmware
-LICENSE:${PN}-ixp4xx-license = "LicenseRef-Firmware-ixp4xx"
+LICENSE:${PN}-ixp4xx-license = "Firmware-ixp4xx"
 FILES:${PN}-ixp4xx-license = "${firmwaredir}/LICENSE.ixp4xx"
 
-LICENSE:${PN}-ixp4xx-npe = "LicenseRef-Firmware-ixp4xx"
+LICENSE:${PN}-ixp4xx-npe = "Firmware-ixp4xx"
 FILES:${PN}-ixp4xx-npe = "${firmwaredir}/ixp4xx/*"
 RDEPENDS:${PN}-ixp4xx-npe = "${PN}-ixp4xx-license"
 
 # For kaweth - USB KLSI KL5USB101-based Ethernet device
-LICENSE:${PN}-kaweth-license = "LicenseRef-Firmware-kaweth"
+LICENSE:${PN}-kaweth-license = "Firmware-kaweth"
 FILES:${PN}-kaweth-license = "${firmwaredir}/LICENCE.kaweth"
 
-LICENSE:${PN}-kaweth = "LicenseRef-Firmware-kaweth"
+LICENSE:${PN}-kaweth = "Firmware-kaweth"
 FILES:${PN}-kaweth = "${firmwaredir}/kaweth/*"
 RDEPENDS:${PN}-kaweth = "${PN}-kaweth-license"
 
 # For keyspan - USB Keyspan USA-xxx serial device
-LICENSE:${PN}-keyspan-license = "LicenseRef-Firmware-keyspan"
+LICENSE:${PN}-keyspan-license = "Firmware-keyspan"
 FILES:${PN}-keyspan-license = "${firmwaredir}/LICENCE.keyspan"
 
-LICENSE:${PN}-keyspan = "LicenseRef-Firmware-keyspan"
+LICENSE:${PN}-keyspan = "Firmware-keyspan"
 FILES:${PN}-keyspan = "${firmwaredir}/keyspan/*"
 RDEPENDS:${PN}-keyspan = "${PN}-keyspan-license"
 
@@ -3374,18 +3374,18 @@ LICENSE:${PN}-keyspan-pda = "GPL-2.0-or-later"
 FILES:${PN}-keyspan-pda = "${firmwaredir}/keyspan_pda/*"
 
 # For mga - Matrox G200/G400/G550
-LICENSE:${PN}-mga-license = "LicenseRef-Firmware-mga"
+LICENSE:${PN}-mga-license = "Firmware-mga"
 FILES:${PN}-mga-license = "${firmwaredir}/LICENSE.mga"
 
-LICENSE:${PN}-mga = "LicenseRef-Firmware-mga"
+LICENSE:${PN}-mga = "Firmware-mga"
 FILES:${PN}-mga = "${firmwaredir}/matrox/*"
 RDEPENDS:${PN}-mga = "${PN}-mga-license"
 
 # For myri10ge - Myri10GE 10GbE NIC driver
-LICENSE:${PN}-myri10ge-firmware-license = "LicenseRef-Firmware-myri10ge-firmware"
+LICENSE:${PN}-myri10ge-firmware-license = "Firmware-myri10ge-firmware"
 FILES:${PN}-myri10ge-firmware-license = "${firmwaredir}/LICENCE.myri10ge_firmware"
 
-LICENSE:${PN}-myri10ge = "LicenseRef-Firmware-myri10ge-firmware"
+LICENSE:${PN}-myri10ge = "Firmware-myri10ge-firmware"
 FILES:${PN}-myri10ge = "${firmwaredir}/myri10ge_*"
 RDEPENDS:${PN}-myri10ge = "${PN}-myri10ge-firmware-license"
 
@@ -3394,10 +3394,10 @@ LICENSE:${PN}-smc91c92-cs = "GPL-1.0-only"
 FILES:${PN}-smc91c92-cs = "${firmwaredir}/ositech/Xilinx7OD.bin*"
 
 # For qla1280 - Qlogic QLA 1240/1x80/1x160 SCSI support
-LICENSE:${PN}-qla1280-license = "LicenseRef-Firmware-qla1280"
+LICENSE:${PN}-qla1280-license = "Firmware-qla1280"
 FILES:${PN}-qla1280-license = "${firmwaredir}/LICENCE.qla1280"
 
-LICENSE:${PN}-qla1280 = "LicenseRef-Firmware-qla1280"
+LICENSE:${PN}-qla1280 = "Firmware-qla1280"
 FILES:${PN}-qla1280 = " \
     ${firmwaredir}/qlogic/1040.bin* \
     ${firmwaredir}/qlogic/1280.bin* \
@@ -3406,26 +3406,26 @@ FILES:${PN}-qla1280 = " \
 RDEPENDS:${PN}-qla1280 = "${PN}-qla1280-license"
 
 # For ib_qib - QLogic Infiniband
-LICENSE:${PN}-ib-qib-license = "LicenseRef-Firmware-ib-qib"
+LICENSE:${PN}-ib-qib-license = "Firmware-ib-qib"
 FILES:${PN}-ib-qib-license = "${firmwaredir}/LICENSE.ib_qib"
 
-LICENSE:${PN}-ib-qib = "LicenseRef-Firmware-ib-qib"
+LICENSE:${PN}-ib-qib = "Firmware-ib-qib"
 FILES:${PN}-ib-qib = "${firmwaredir}/qlogic/sd7220.fw*"
 RDEPENDS:${PN}-ib-qib = "${PN}-ib-qib-license"
 
 # For xhci-rcar - Renesas R-Car Gen2/3 USB 3.0 host controller driver
-LICENSE:${PN}-r8a779x-usb3-license = "LicenseRef-Firmware-r8a779x-usb3"
+LICENSE:${PN}-r8a779x-usb3-license = "Firmware-r8a779x-usb3"
 FILES:${PN}-r8a779x-usb3-license = "${firmwaredir}/LICENCE.r8a779x_usb3"
 
-LICENSE:${PN}-xhci-rcar = "LicenseRef-Firmware-r8a779x-usb3"
+LICENSE:${PN}-xhci-rcar = "Firmware-r8a779x-usb3"
 FILES:${PN}-xhci-rcar = "${firmwaredir}/r8a779x_usb3_*"
 RDEPENDS:${PN}-xhci-rcar = "${PN}-r8a779x-usb3-license"
 
 # For pcie-rcar-gen4 - Renesas R-Car Gen4 PCIe driver
-LICENSE:${PN}-r8a779g-pcie-phy-license = "LicenseRef-Firmware-r8a779g-pcie-phy"
+LICENSE:${PN}-r8a779g-pcie-phy-license = "Firmware-r8a779g-pcie-phy"
 FILES:${PN}-r8a779g-pcie-phy-license = "${firmwaredir}/LICENCE.r8a779g_pcie_phy"
 
-LICENSE:${PN}-pcie-rcar = "LicenseRef-Firmware-r8a779g-pcie-phy"
+LICENSE:${PN}-pcie-rcar = "Firmware-r8a779g-pcie-phy"
 FILES:${PN}-pcie-rcar = "${firmwaredir}/rcar_gen4_pcie.bin*"
 RDEPENDS:${PN}-pcie-rcar = "${PN}-r8a779g-pcie-phy-license"
 
@@ -3434,26 +3434,26 @@ LICENSE:${PN}-r128 = "MIT"
 FILES:${PN}-r128 = "${firmwaredir}/r128/*"
 
 # For rt1320 - Realtek rt1320 ASoC audio driver.
-LICENSE:${PN}-rt1320-license = "LicenseRef-Firmware-rt1320"
+LICENSE:${PN}-rt1320-license = "Firmware-rt1320"
 FILES:${PN}-rt1320-license = "${firmwaredir}/LICENSE.rt1320"
 
-LICENSE:${PN}-rt1320 = "LicenseRef-Firmware-rt1320"
+LICENSE:${PN}-rt1320 = "Firmware-rt1320"
 FILES:${PN}-rt1320 = "${firmwaredir}/realtek/rt1320/*"
 RDEPENDS:${PN}-rt1320 = "${PN}-rt1320-license"
 
 # For rp2 - Comtrol RocketPort 2 serial driver
-LICENSE:${PN}-rp2-license = "LicenseRef-Firmware-rp2"
+LICENSE:${PN}-rp2-license = "Firmware-rp2"
 FILES:${PN}-rp2-license = "${firmwaredir}/LICENSE.rp2"
 
-LICENSE:${PN}-rp2 = "LicenseRef-Firmware-rp2"
+LICENSE:${PN}-rp2 = "Firmware-rp2"
 FILES:${PN}-rp2 = "${firmwaredir}/rp2.fw*"
 RDEPENDS:${PN}-rp2 = "${PN}-rp2-license"
 
 # For s5p-mfc - Samsung MFC video encoder/decoder driver
-LICENSE:${PN}-s5p-mfc-license = "LicenseRef-Firmware-s5p-mfc"
+LICENSE:${PN}-s5p-mfc-license = "Firmware-s5p-mfc"
 FILES:${PN}-s5p-mfc-license = "${firmwaredir}/LICENSE.s5p-mfc"
 
-LICENSE:${PN}-s5p-mfc = "LicenseRef-Firmware-s5p-mfc"
+LICENSE:${PN}-s5p-mfc = "Firmware-s5p-mfc"
 FILES:${PN}-s5p-mfc = "${firmwaredir}/s5p-mfc*"
 RDEPENDS:${PN}-s5p-mfc = "${PN}-s5p-mfc-license"
 
@@ -3462,54 +3462,54 @@ LICENSE:${PN}-snd-sb16-csp = "GPL-2.0-or-later"
 FILES:${PN}-snd-sb16-csp = "${firmwaredir}/sb16/*"
 
 # For slicoss - Alacritech IS-NIC products
-LICENSE:${PN}-alacritech-license = "LicenseRef-Firmware-alacritech"
+LICENSE:${PN}-alacritech-license = "Firmware-alacritech"
 FILES:${PN}-alacritech-license = "${firmwaredir}/LICENCE.alacritech"
 
-LICENSE:${PN}-slicoss = "LicenseRef-Firmware-alacritech"
+LICENSE:${PN}-slicoss = "Firmware-alacritech"
 FILES:${PN}-slicoss = "${firmwaredir}/slicoss/*"
 RDEPENDS:${PN}-slicoss = "${PN}-alacritech-license"
 
-LICENSE:${PN}-sxg = "LicenseRef-Firmware-alacritech"
+LICENSE:${PN}-sxg = "Firmware-alacritech"
 FILES:${PN}-sxg = "${firmwaredir}/sxg/*"
 RDEPENDS:${PN}-sxg = "${PN}-alacritech-license"
 
 # For tehuti - Tehuti Networks 10G Ethernet
-LICENSE:${PN}-tehuti-license = "LicenseRef-Firmware-tehuti"
+LICENSE:${PN}-tehuti-license = "Firmware-tehuti"
 FILES:${PN}-tehuti-license = "${firmwaredir}/LICENSE.tehuti"
 
-LICENSE:${PN}-tehuti = "LicenseRef-Firmware-tehuti"
+LICENSE:${PN}-tehuti = "Firmware-tehuti"
 FILES:${PN}-tehuti = "${firmwaredir}/tehuti/*"
 RDEPENDS:${PN}-tehuti = "${PN}-tehuti-license"
 
 # For tg3 - Broadcom Tigon3 based gigabit Ethernet cards
-LICENSE:${PN}-tigon-license = "LicenseRef-Firmware-tigon"
+LICENSE:${PN}-tigon-license = "Firmware-tigon"
 FILES:${PN}-tigon-license = "${firmwaredir}/LICENCE.tigon"
 
-LICENSE:${PN}-tg3 = "LicenseRef-Firmware-tigon"
+LICENSE:${PN}-tg3 = "Firmware-tigon"
 FILES:${PN}-tg3 = "${firmwaredir}/tigon/*"
 RDEPENDS:${PN}-tg3 = "${PN}-tigon-license"
 
 # For tlg2300 - Telgent 2300 V4L/DVB driver.
-LICENSE:${PN}-tlg2300-license = "LicenseRef-Firmware-tlg2300"
+LICENSE:${PN}-tlg2300-license = "Firmware-tlg2300"
 FILES:${PN}-tlg2300-license = "${firmwaredir}/LICENSE.tlg2300"
 
-LICENSE:${PN}-tlg2300 = "LicenseRef-Firmware-tlg2300"
+LICENSE:${PN}-tlg2300 = "Firmware-tlg2300"
 FILES:${PN}-tlg2300 = "${firmwaredir}/tlg2300*"
 RDEPENDS:${PN}-tlg2300 = "${PN}-tlg2300-license"
 
 # For Mont-TSSE - Mont-TSSE(TM) Crypto Algorithm Accelerator Driver
-LICENSE:${PN}-montage-license = "LicenseRef-Firmware-montage"
+LICENSE:${PN}-montage-license = "Firmware-montage"
 FILES:${PN}-montage-license = "${firmwaredir}/LICENSE.montage"
 
-LICENSE:${PN}-mont-tsse = "LicenseRef-Firmware-montage"
+LICENSE:${PN}-mont-tsse = "Firmware-montage"
 FILES:${PN}-mont-tsse = "${firmwaredir}/tsse_firmware.bin*"
 RDEPENDS:${PN}-mont-tsse = "${PN}-montage-license"
 
 # For ueagle-atm - Driver for USB ADSL Modems based on Eagle IV Chipset
-LICENSE:${PN}-ueagle-atm4-firmware-license = "LicenseRef-Firmware-ueagle-atm4-firmware"
+LICENSE:${PN}-ueagle-atm4-firmware-license = "Firmware-ueagle-atm4-firmware"
 FILES:${PN}-ueagle-atm4-firmware-license = "${firmwaredir}/LICENCE.ueagle-atm4-firmware"
 
-LICENSE:${PN}-ueagle-atm = "LicenseRef-Firmware-ueagle-atm4-firmware"
+LICENSE:${PN}-ueagle-atm = "Firmware-ueagle-atm4-firmware"
 FILES:${PN}-ueagle-atm = " \
     ${firmwaredir}/ueagle-atm/CMV4p.bin.v2* \
     ${firmwaredir}/ueagle-atm/DSP4p.bin* \
@@ -3522,30 +3522,30 @@ LICENSE:${PN}-usbdux = "GPL-2.0-or-later"
 FILES:${PN}-usbdux = "${firmwaredir}/usbdux*"
 
 # For cx231xx - Conexant Cx23100/101/102 USB broadcast A/V decoder
-LICENSE:${PN}-conexant-license = "LicenseRef-Firmware-conexant"
+LICENSE:${PN}-conexant-license = "Firmware-conexant"
 FILES:${PN}-conexant-license = "${firmwaredir}/LICENSE.conexant"
 
-LICENSE:${PN}-cx231xx = "LicenseRef-Firmware-conexant"
+LICENSE:${PN}-cx231xx = "Firmware-conexant"
 FILES:${PN}-cx231xx = "${firmwaredir}/v4l-cx231xx*"
 RDEPENDS:${PN}-cx231xx = "${PN}-conexant-license"
 
-LICENSE:${PN}-cx23418 = "LicenseRef-Firmware-conexant"
+LICENSE:${PN}-cx23418 = "Firmware-conexant"
 FILES:${PN}-cx23418 = "${firmwaredir}/v4l-cx23418*"
 RDEPENDS:${PN}-cx23418 = "${PN}-conexant-license"
 
-LICENSE:${PN}-cx23885 = "LicenseRef-Firmware-conexant"
+LICENSE:${PN}-cx23885 = "Firmware-conexant"
 FILES:${PN}-cx23885 = "${firmwaredir}/v4l-cx23885*"
 RDEPENDS:${PN}-cx23885 = "${PN}-conexant-license"
 
-LICENSE:${PN}-cx23840 = "LicenseRef-Firmware-conexant"
+LICENSE:${PN}-cx23840 = "Firmware-conexant"
 FILES:${PN}-cx23840 = "${firmwaredir}/v4l-cx25840*"
 RDEPENDS:${PN}-cx23840 = "${PN}-conexant-license"
 
 # For vxge - Exar X3100 Series 10GbE PCIe I/O Virtualized Server Adapter
-LICENSE:${PN}-vxge-license = "LicenseRef-Firmware-vxge"
+LICENSE:${PN}-vxge-license = "Firmware-vxge"
 FILES:${PN}-vxge-license = "${firmwaredir}/LICENSE.vxge"
 
-LICENSE:${PN}-vxge = "LicenseRef-Firmware-vxge"
+LICENSE:${PN}-vxge = "Firmware-vxge"
 FILES:${PN}-vxge = "${firmwaredir}/vxge/*"
 RDEPENDS:${PN}-vxge = "${PN}-vxge-license"
 
@@ -3553,115 +3553,115 @@ RDEPENDS:${PN}-vxge = "${PN}-vxge-license"
 LICENSE:${PN}-whiteheat = "GPL-2.0-only"
 FILES:${PN}-whiteheat = "${firmwaredir}/whiteheat*"
 
-LICENSE:${PN}-wil6210 = "LicenseRef-Firmware-qualcommAthos-ath10k"
+LICENSE:${PN}-wil6210 = "Firmware-qualcommAthos-ath10k"
 FILES:${PN}-wil6210 = "${firmwaredir}/wil6210*"
 RDEPENDS:${PN}-wil6210 = "${PN}-ath10k-license"
 
 # For xe - Intel Graphics driver
-LICENSE:${PN}-xe-license = "LicenseRef-Firmware-xe"
+LICENSE:${PN}-xe-license = "Firmware-xe"
 FILES:${PN}-xe-license = "${firmwaredir}/LICENSE.xe"
 
-LICENSE:${PN}-xe = "LicenseRef-Firmware-xe"
+LICENSE:${PN}-xe = "Firmware-xe"
 FILES:${PN}-xe = "${firmwaredir}/xe/*"
 RDEPENDS:${PN}-xe = "${PN}-xe-license"
 
 # For other firmwares
 # Maybe split out to separate packages when needed.
 LICENSE:${PN} = "\
-    LicenseRef-Firmware-Abilis \
-    AND LicenseRef-Firmware-aeonsemi \
-    AND LicenseRef-Firmware-agere \
-    AND LicenseRef-Firmware-airoha \
-    AND LicenseRef-Firmware-alacritech \
-    AND LicenseRef-Firmware-amdgpu \
-    AND LicenseRef-Firmware-amdisp \
-    AND LicenseRef-Firmware-amdnpu \
-    AND LicenseRef-Firmware-amd-pmf \
-    AND LicenseRef-Firmware-amd-sev \
-    AND LicenseRef-Firmware-amd-ucode \
-    AND LicenseRef-Firmware-amlogic \
-    AND LicenseRef-Firmware-amlogic-vdec \
-    AND LicenseRef-Firmware-atmel \
-    AND LicenseRef-Firmware-bfa \
-    AND LicenseRef-Firmware-bmi260 \
-    AND LicenseRef-Firmware-bnx2 \
-    AND LicenseRef-Firmware-bnx2x \
-    AND LicenseRef-Firmware-ca0132 \
-    AND LicenseRef-Firmware-cavium \
-    AND LicenseRef-Firmware-chelsio-firmware \
-    AND LicenseRef-Firmware-cirrus \
-    AND LicenseRef-Firmware-cnm \
-    AND LicenseRef-Firmware-conexant \
-    AND LicenseRef-Firmware-cw1200 \
-    AND LicenseRef-Firmware-cw1200-sdd \
-    AND LicenseRef-Firmware-cxgb3 \
-    AND LicenseRef-Firmware-dabusb \
-    AND LicenseRef-Firmware-dell \
-    AND LicenseRef-Firmware-dib0700 \
-    AND LicenseRef-Firmware-drxk \
-    AND LicenseRef-Firmware-e100 \
-    AND LicenseRef-Firmware-emi26 \
-    AND LicenseRef-Firmware-ene-firmware \
-    AND LicenseRef-Firmware-fw-sst-0f28 \
-    AND LicenseRef-Firmware-go7007 \
-    AND LicenseRef-Firmware-hfi1-firmware \
-    AND LicenseRef-Firmware-HP \
-    AND LicenseRef-Firmware-ib-qib \
-    AND LicenseRef-Firmware-ibt-firmware \
-    AND LicenseRef-Firmware-inside-secure \
-    AND LicenseRef-Firmware-intel \
-    AND LicenseRef-Firmware-intel-vpu \
-    AND LicenseRef-Firmware-ipu3-firmware \
-    AND LicenseRef-Firmware-it913x \
-    AND LicenseRef-Firmware-ivsc \
-    AND LicenseRef-Firmware-ixp4xx \
-    AND LicenseRef-Firmware-IntcSST2 \
-    AND LicenseRef-Firmware-kaweth \
-    AND LicenseRef-Firmware-keyspan \
-    AND LicenseRef-Firmware-lenovo \
-    AND LicenseRef-Firmware-mellanox \
-    AND LicenseRef-Firmware-mga \
-    AND LicenseRef-Firmware-montage \
-    AND LicenseRef-Firmware-morsemicro \
-    AND LicenseRef-Firmware-moxa \
-    AND LicenseRef-Firmware-myri10ge-firmware \
-    AND LicenseRef-Firmware-nvidia \
-    AND LicenseRef-Firmware-nxp \
-    AND LicenseRef-Firmware-OLPC \
-    AND LicenseRef-Firmware-ath9k-htc \
-    AND LicenseRef-Firmware-phanfw \
-    AND LicenseRef-Firmware-qat \
-    AND LicenseRef-Firmware-qcom \
-    AND LicenseRef-Firmware-qed \
-    AND LicenseRef-Firmware-qla1280 \
-    AND LicenseRef-Firmware-qla2xxx \
-    AND LicenseRef-Firmware-r8169 \
-    AND LicenseRef-Firmware-r8a779x-usb3 \
-    AND LicenseRef-Firmware-radeon \
-    AND LicenseRef-Firmware-ralink-a-mediatek-company-firmware \
-    AND LicenseRef-Firmware-ralink-firmware \
-    AND LicenseRef-Firmware-rp2 \
-    AND LicenseRef-Firmware-rsi \
-    AND LicenseRef-Firmware-rt1320 \
-    AND LicenseRef-Firmware-imx-sdma-firmware \
-    AND LicenseRef-Firmware-s5p-mfc \
-    AND LicenseRef-Firmware-sensoray \
-    AND LicenseRef-Firmware-siano \
-    AND LicenseRef-Firmware-tehuti \
-    AND LicenseRef-Firmware-ti-connectivity \
-    AND LicenseRef-Firmware-ti-keystone \
-    AND LicenseRef-Firmware-ti-tspa \
-    AND LicenseRef-Firmware-tigon \
-    AND LicenseRef-Firmware-tlg2300 \
-    AND LicenseRef-Firmware-typhoon \
-    AND LicenseRef-Firmware-ueagle-atm4-firmware \
-    AND LicenseRef-Firmware-vxge \
-    AND LicenseRef-Firmware-wl1251 \
-    AND LicenseRef-Firmware-xc4000 \
-    AND LicenseRef-Firmware-xc5000 \
-    AND LicenseRef-Firmware-xc5000c \
-    AND LicenseRef-Firmware-xe \
-    AND LicenseRef-Firmware-WHENCE \
+    Firmware-Abilis \
+    & Firmware-aeonsemi \
+    & Firmware-agere \
+    & Firmware-airoha \
+    & Firmware-alacritech \
+    & Firmware-amdgpu \
+    & Firmware-amdisp \
+    & Firmware-amdnpu \
+    & Firmware-amd-pmf \
+    & Firmware-amd-sev \
+    & Firmware-amd-ucode \
+    & Firmware-amlogic \
+    & Firmware-amlogic-vdec \
+    & Firmware-atmel \
+    & Firmware-bfa \
+    & Firmware-bmi260 \
+    & Firmware-bnx2 \
+    & Firmware-bnx2x \
+    & Firmware-ca0132 \
+    & Firmware-cavium \
+    & Firmware-chelsio-firmware \
+    & Firmware-cirrus \
+    & Firmware-cnm \
+    & Firmware-conexant \
+    & Firmware-cw1200 \
+    & Firmware-cw1200-sdd \
+    & Firmware-cxgb3 \
+    & Firmware-dabusb \
+    & Firmware-dell \
+    & Firmware-dib0700 \
+    & Firmware-drxk \
+    & Firmware-e100 \
+    & Firmware-emi26 \
+    & Firmware-ene-firmware \
+    & Firmware-fw-sst-0f28 \
+    & Firmware-go7007 \
+    & Firmware-hfi1-firmware \
+    & Firmware-HP \
+    & Firmware-ib-qib \
+    & Firmware-ibt-firmware \
+    & Firmware-inside-secure \
+    & Firmware-intel \
+    & Firmware-intel-vpu \
+    & Firmware-ipu3-firmware \
+    & Firmware-it913x \
+    & Firmware-ivsc \
+    & Firmware-ixp4xx \
+    & Firmware-IntcSST2 \
+    & Firmware-kaweth \
+    & Firmware-keyspan \
+    & Firmware-lenovo \
+    & Firmware-mellanox \
+    & Firmware-mga \
+    & Firmware-montage \
+    & Firmware-morsemicro \
+    & Firmware-moxa \
+    & Firmware-myri10ge-firmware \
+    & Firmware-nvidia \
+    & Firmware-nxp \
+    & Firmware-OLPC \
+    & Firmware-ath9k-htc \
+    & Firmware-phanfw \
+    & Firmware-qat \
+    & Firmware-qcom \
+    & Firmware-qed \
+    & Firmware-qla1280 \
+    & Firmware-qla2xxx \
+    & Firmware-r8169 \
+    & Firmware-r8a779x-usb3 \
+    & Firmware-radeon \
+    & Firmware-ralink-a-mediatek-company-firmware \
+    & Firmware-ralink-firmware \
+    & Firmware-rp2 \
+    & Firmware-rsi \
+    & Firmware-rt1320 \
+    & Firmware-imx-sdma-firmware \
+    & Firmware-s5p-mfc \
+    & Firmware-sensoray \
+    & Firmware-siano \
+    & Firmware-tehuti \
+    & Firmware-ti-connectivity \
+    & Firmware-ti-keystone \
+    & Firmware-ti-tspa \
+    & Firmware-tigon \
+    & Firmware-tlg2300 \
+    & Firmware-typhoon \
+    & Firmware-ueagle-atm4-firmware \
+    & Firmware-vxge \
+    & Firmware-wl1251 \
+    & Firmware-xc4000 \
+    & Firmware-xc5000 \
+    & Firmware-xc5000c \
+    & Firmware-xe \
+    & Firmware-WHENCE \
 "
 
 # The goal for this recipe is to creata bunch of breakout packages for the
-- 
2.55.0


