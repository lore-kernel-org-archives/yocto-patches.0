Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.520.1793465154236010743
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 09:45:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Hh28Wjfa;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=jtAhFuBX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VGUXWO1555042
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=7xRlfr5DRknwj+w41JCef5kd5iwas1C7lq0
	zGvHKz7I=; b=Hh28WjfaE4qUQVyqCNAiEsxwvKrJfAEUW10rHV5doZfEJXgnap8
	DDkkvYMNUOpYJcn15a3/DE29RpAX9OHPGkdZXAH4y4a69yMLrIkJr61wiw9E/7Um
	k90//xAqlvV3MTCTCP2uCXxflAsG7ldtAODpxObDXj6sOHeYTtq1ARb7fqFznUrh
	ILD6wkNcgBax8/NFr+uWNVo3a5/i51N9jXRvR0vzkF0oCYhRJ5+iid+L2zi4tZIn
	eMtYYtcwS2R/8yvKfOPRCc3wSYxKYH7DGeAY/Q5XNjgvD9rUoRgdK9GOF46PJGq5
	PESg12IRkD8TQTcru0xHBBN+D9pq8VxJROQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7shdc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb6391e89so363694785a.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793465152; x=1794069952; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xRlfr5DRknwj+w41JCef5kd5iwas1C7lq0zGvHKz7I=;
        b=jtAhFuBXam7r6ez/Ltld8D0jpSw/7nngL1/CPvMdmEQ/avtT6QBplsGfkyfpTs/AgR
         oKPVOHNJhOl3ibC3MmbrkIIxJECZfUvYGravVE6rXVCW8msreIvxYllymNyUsSwZZeDY
         S0i7EGC3xHVjEQz4BspKDjF22IeZGkLbAJ+xh0gVSeOF6OufWlmIp+EJS17HzraDMFuP
         vVz+8tINmeL4i0GlH4YahkPHku6BLREDWZ2VdO9th3/RRm8fLzgFMUbzIOKFGpQTnp3t
         UswXpzfMi2l0LM8Rh8GcNmNOoR2cdQG2+pdiZym34bYge9sR0CRRQNiYvKl59m/pG83v
         +JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465152; x=1794069952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xRlfr5DRknwj+w41JCef5kd5iwas1C7lq0zGvHKz7I=;
        b=rl5yTtevH1B1yyDEIhY+eTyxMYfHpTacPYcOolkiGbGXu4IaHwyc8vzK5ZBIFHOLiC
         dE6DS/kZbR2T+5WyM77l2iNhPnTlpZBMPGCILE1lxf9JZTdK0QrvT6GnrK/KzncV8jwu
         Yv8XJOF0Hd/KIum2xcOUg0d1mfRXsiyP7sg9ib6UkDZ3fUTm9yzFiWW3pQ2DTNtpemaa
         +HUKFbwwPS93jGmnwbLbSnXHTIuWF8okbzpZPx8OUp4PRx4AYhMaA4uIiDBIbUcsd6N4
         DZv3G+qEPmf8funkYFOOjT6Ra5JUxa40ORg+w0H0F1K3vtB596CTSEurIsE6I3GB/ddW
         765w==
X-Gm-Message-State: AFq9FYJRb2B1CEI+kNp5C2RQmOPPNeNwmKdfEAy5uJisKTj/P16MvUKa
	xx38jjtYRvyNxx6I+4H0H1/d2XReogMS360gn6G3BXSFBOA+dHTbKvwUxeEtRut+D/PslezeUMI
	w1ktzYdJsuWABoQA4bEbZI52NGyU52qD6NaD67QiY178LbwpQGQ99ERxPKhJcL5yYCkyevs1OdM
	gJHxemhT4o2Q==
X-Gm-Gg: AYBFou3Y8yEKqqYwDd4gj2XHw1ZFNQfnNhbrWA5q7z9yzvXKnJ8csjG6FO9vn4yUoIy
	yiFqXCDd5SAJ7kQPEDy3+yjq/JjVUmbyoftmnD3CPO11UL28gq9OGvt71I3Xbengar0ayT3CGCE
	2r9ZnHR0qHvWgRrd8/kopwDot48m/F1jpBm6vKpIWGSL5pm7Eyg7qFNA+o+7Ny+T8+z2TXOozmE
	E+SM07lgGx4BtRXSkHGmR9lMWDh3ju5dejNM1l/RlmQlZ2iHzF8936/aq1t3ioIMn4lBsrMzb+Y
	Fos5D0EXsQO7kNxOnyNtXXa2fQ8p4qvjozHeqLFQUU8GYo65nBbAVUtiRWhJF5qjEK02kFc3EW3
	PdhY8iuU5MrO6GGNKJK0t0er1147n3zQlBkWzGL5FOQB9HuonGknYM3wsZ8PQXW0=
X-Received: by 2002:a05:620a:2805:b0:93b:d79a:c463 with SMTP id af79cd13be357-944216db682mr903389385a.59.1793465151811;
        Sat, 31 Oct 2026 09:45:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2805:b0:93b:d79a:c463 with SMTP id af79cd13be357-944216db682mr903386385a.59.1793465151209;
        Sat, 31 Oct 2026 09:45:51 -0700 (PDT)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm103398055e9.0.2026.10.31.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:45:50 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Vivek Puar <vpuar@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Antonin Godard <antonin.godard@bootlin.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 01/10]  linux-firmware: upgrade 20260910 -> 20260916
Date: Sat, 31 Oct 2026 16:45:34 +0000
Message-ID: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bjEeiIV2JJNt1GLeSwZY6m_FOvIVuAV7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX2nsyV0Nu4KGy
 jUb1OkDHmeJVVJ0vuVD5418YjzXu2WiTtpV0IPeP+AgD8zEh4Rv1DEkAtOp4rNm2zRCN6mJWwAE
 8BiIsH3ljw0YCd/UNyIjLwM6FN2R4Qc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfXw2eYBiZVU9Th
 9Zi+5A4OyB3U0T14SpM1GA+3gM8nC69zupZyTVQX2a+L1P3sBsPrkNgtJj8LXsTsr3RAV92tkaB
 aJkpsZaUcJCEkr+jUzg6WBkAik4RRQ3Ck7RvIMM5BZhITI8D1iRsOuG5ZqwClMgKp0sUic+emDL
 cXDHxkjQuRYC05lEVFzAqNLcyh16LoCL1XWIiUW5TwC7Q5FE5PiyZRqHOK585SCv6DdunnrLg4O
 Q0QvejNiPQ2b64uG4vdtuUpCdx7a6jFM+9K2Py6gOPeBmulD6vU6qxNA77zdoGTQ4Q4mohdw4Ar
 IMCvViul7uhuHgSqgENbSvA+EW70ZjtZqEY+a4Q5F+RJVSZtEp0psig4Xutf9UcjZ6clSqn8+W6
 8YsUXo4yD6dEgZ7nbTOiEM9iG0UR+t7cq8Z+1L0wby+3m7lp72iz1noyNCflq29aTbvW7olwixv
 Z/Zh9Jdvf1Gtqc3+Xnw==
X-Proofpoint-GUID: bjEeiIV2JJNt1GLeSwZY6m_FOvIVuAV7
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae61b40 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=Ii1caJqkCqkA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
 a=A7mtM95H-gnKJ28VzyQA:9 a=NFOGd7dJGGMPyQGDc5-O:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5194
Content-Type: text/plain; charset="utf-8"

From: Vivek Puar <vpuar@qti.qualcomm.com>

Upgrade the firmware package to latest release. Add firmware
for RTL8261d. Add ADSP firmware for Qualcomm Maili platform.
Add SHIFT6mq modem and WLAN firmware packages, which reuse
files already available in linux-firmware through symlinks.

Signed-off-by: Vivek Puar <vpuar@qti.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 ...20260910.bb => linux-firmware_20260916.bb} | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux-firmware/{linux-firmware_20260910.bb => linux-firmware_20260916.bb} (99%)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260910.bb b/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
similarity index 99%
rename from recipes-kernel/linux-firmware/linux-firmware_20260910.bb
rename to recipes-kernel/linux-firmware/linux-firmware_20260916.bb
index 5c26eb0..d09de7f 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
@@ -277,7 +277,7 @@ LIC_FILES_CHKSUM = "file://LICENSES/LICENCE.Abilis;md5=b5ee3f410780e56711ad48ead
                     "
 # WHENCE checksum is defined separately to ease overriding it if
 # class-devupstream is selected.
-WHENCE_CHKSUM  = "fe7960bbe2eb0922168c3434c8d125d0"
+WHENCE_CHKSUM  = "286b10e604dec1e5d49c4ac688f65a2e"
 
 # These are not common licenses, set NO_GENERIC_LICENSE for them
 # so that the license files will be copied from fetched source
@@ -416,7 +416,7 @@ SRC_URI:class-devupstream = "git://git.kernel.org/pub/scm/linux/kernel/git/firmw
 # Pin this to the 20220509 release, override this in local.conf
 SRCREV:class-devupstream ?= "b19cbdca78ab2adfd210c91be15a22568e8b8cae"
 
-SRC_URI[sha256sum] = "f3937ca282ba256242e2b6dbe523df8a80007d29ffd61f56d270190865492ea8"
+SRC_URI[sha256sum] = "f80dcb757a623deda62200c08e0e1a88c76fb6b54964f31b35fa74da1c90ccc5"
 
 inherit allarch
 
@@ -533,7 +533,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-vt6656-license ${PN}-vt6656 \
              ${PN}-rs9113 ${PN}-rs9116 ${PN}-rsi-91x \
              ${PN}-rtl-license ${PN}-rtl8188 ${PN}-rtl8192cu ${PN}-rtl8192ce ${PN}-rtl8192su \
-             ${PN}-rtl8261c ${PN}-rtl8723 ${PN}-rtl8821 \
+             ${PN}-rtl8261c ${PN}-rtl8261d ${PN}-rtl8723 ${PN}-rtl8821 \
              ${PN}-rtl8761 \
              ${PN}-rtl8168 \
              ${PN}-rtl8822 \
@@ -699,6 +699,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-qcom-hawi-audio \
              ${PN}-qcom-kaanapali-adreno ${PN}-qcom-kaanapali-audio \
              ${PN}-qcom-kaanapali-compute ${PN}-qcom-kaanapali-soccp \
+             ${PN}-qcom-maili-audio \
              ${PN}-qcom-nord-audio ${PN}-qcom-nord-compute ${PN}-qcom-nord-qupv3fw \
              ${PN}-qcom-qcm2290-adreno ${PN}-qcom-qcm2290-audio ${PN}-qcom-qcm2290-modem \
              ${PN}-qcom-qcm6490-adreno ${PN}-qcom-qcm6490-audio ${PN}-qcom-qcm6490-compute \
@@ -721,7 +722,8 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-qcom-sc8280xp-lenovo-x13s-vpu \
              ${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio \
              ${PN}-qcom-sdm845-adreno ${PN}-qcom-sdm845-audio ${PN}-qcom-sdm845-compute \
-             ${PN}-qcom-sdm845-shift6mq-adreno ${PN}-qcom-sdm845-thundercomm-db845c-sensors \
+             ${PN}-qcom-sdm845-shift6mq-adreno ${PN}-qcom-sdm845-shift6mq-modem ${PN}-qcom-sdm845-shift6mq-wifi \
+             ${PN}-qcom-sdm845-thundercomm-db845c-sensors \
              ${PN}-qcom-sdx35-foxconn-firehose ${PN}-qcom-sdx61-foxconn-firehose \
              ${PN}-qcom-shikra-adreno ${PN}-qcom-shikra-compute ${PN}-qcom-shikra-audio \
              ${PN}-qcom-shikra-modem ${PN}-qcom-shikra-qupv3fw \
@@ -1647,6 +1649,7 @@ LICENSE:${PN}-rtl8192cu = "LicenseRef-Firmware-rtlwifi-firmware"
 LICENSE:${PN}-rtl8192ce = "LicenseRef-Firmware-rtlwifi-firmware"
 LICENSE:${PN}-rtl8192su = "LicenseRef-Firmware-rtlwifi-firmware"
 LICENSE:${PN}-rtl8261c = "LicenseRef-Firmware-rtlwifi-firmware"
+LICENSE:${PN}-rtl8261d = "LicenseRef-Firmware-rtlwifi-firmware"
 LICENSE:${PN}-rtl8723 = "LicenseRef-Firmware-rtlwifi-firmware"
 LICENSE:${PN}-rtl8761 = "LicenseRef-Firmware-rtlwifi-firmware"
 LICENSE:${PN}-rtl8821 = "LicenseRef-Firmware-rtlwifi-firmware"
@@ -1681,6 +1684,9 @@ FILES:${PN}-rtl8192su = " \
 FILES:${PN}-rtl8261c = " \
   ${firmwaredir}/rtl_nic/rtl8261c.bin* \
 "
+FILES:${PN}-rtl8261d = " \
+  ${firmwaredir}/rtl_nic/rtl8261d.bin* \
+"
 FILES:${PN}-rtl8723 = " \
   ${firmwaredir}/rtlwifi/rtl8723*.bin* \
   ${firmwaredir}/rtw88/rtw8723*.bin* \
@@ -1736,6 +1742,7 @@ RDEPENDS:${PN}-rtl8192ce += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8192cu += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8192su = "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8261c = "${PN}-rtl-license"
+RDEPENDS:${PN}-rtl8261d = "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8723 += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8821 += "${PN}-rtl-license"
 RDEPENDS:${PN}-rtl8761 += "${PN}-rtl-license"
@@ -2410,6 +2417,7 @@ LICENSE:${PN}-qcom-kaanapali-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-kaanapali-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
 LICENSE:${PN}-qcom-kaanapali-compute = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-kaanapali-soccp = "LicenseRef-Firmware-qcom-2"
+LICENSE:${PN}-qcom-maili-audio = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-nord-audio = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-nord-compute = "LicenseRef-Firmware-qcom-2"
 LICENSE:${PN}-qcom-nord-qupv3fw = "LicenseRef-Firmware-qcom"
@@ -2456,6 +2464,8 @@ LICENSE:${PN}-qcom-sdm845-adreno = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-compute = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-modem = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-shift6mq-adreno = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-shift6mq-modem = "LicenseRef-Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-shift6mq-wifi = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdx35-foxconn-firehose = "LicenseRef-Firmware-qcom"
 LICENSE:${PN}-qcom-sdx61-foxconn-firehose = "LicenseRef-Firmware-qcom"
@@ -2561,6 +2571,7 @@ FILES:${PN}-qcom-kaanapali-audio = " \
 "
 FILES:${PN}-qcom-kaanapali-compute = "${firmwaredir}/qcom/kaanapali/cdsp*.*"
 FILES:${PN}-qcom-kaanapali-soccp = "${firmwaredir}/qcom/kaanapali/soccp*.*"
+FILES:${PN}-qcom-maili-audio = "${firmwaredir}/qcom/maili/adsp*.*"
 FILES:${PN}-qcom-nord-audio = "${firmwaredir}/qcom/nord/adsp*.*"
 FILES:${PN}-qcom-nord-compute = "${firmwaredir}/qcom/nord/cdsp*.*"
 FILES:${PN}-qcom-nord-qupv3fw = "${firmwaredir}/qcom/nord/qupv3fw.elf*"
@@ -2633,6 +2644,8 @@ FILES:${PN}-qcom-sdm845-compute = "${firmwaredir}/qcom/sdm845/cdsp*.*"
 FILES:${PN}-qcom-sdm845-modem = "${firmwaredir}/qcom/sdm845/mba.mbn* ${firmwaredir}/qcom/sdm845/modem*.* ${firmwaredir}/qcom/sdm845/wlanmdsp.mbn* ${firmwaredir}/qcom/sdm845/notice.txt_wlanmdsp* \
                                  ${firmwaredir}/ath10k/WCN3990/hw1.0/wlanmdsp.mbn* ${firmwaredir}/ath10k/WCN3990/hw1.0/notice.txt_wlanmdsp"
 FILES:${PN}-qcom-sdm845-shift6mq-adreno = "${firmwaredir}/qcom/sdm845/SHIFT/axolotl/a630_zap.mbn*"
+FILES:${PN}-qcom-sdm845-shift6mq-modem = "${firmwaredir}/qcom/sdm845/SHIFT/axolotl/mba.mbn*"
+FILES:${PN}-qcom-sdm845-shift6mq-wifi = "${firmwaredir}/qcom/sdm845/SHIFT/axolotl/wlanmdsp.mbn*"
 FILES:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "${firmwaredir}/qcom/sdm845/Thundercomm/db845c/slpi*.*"
 FILES:${PN}-qcom-sdx35-foxconn-firehose = "${firmwaredir}/qcom/sdx35/foxconn/xbl_s_devprg_ns.melf*"
 FILES:${PN}-qcom-sdx61-foxconn-firehose = "${firmwaredir}/qcom/sdx61/foxconn/prog_firehose_lite.elf*"
@@ -2759,6 +2772,7 @@ RDEPENDS:${PN}-qcom-kaanapali-adreno = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-kaanapali-audio = "${PN}-qcom-2-license ${PN}-linaro-license"
 RDEPENDS:${PN}-qcom-kaanapali-compute = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-kaanapali-soccp = "${PN}-qcom-2-license"
+RDEPENDS:${PN}-qcom-maili-audio = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-nord-audio = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-nord-compute = "${PN}-qcom-2-license"
 RDEPENDS:${PN}-qcom-nord-qupv3fw = "${PN}-qcom-license"
@@ -2811,6 +2825,8 @@ RDEPENDS:${PN}-qcom-sdm845-audio = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-compute = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-modem = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdm845-shift6mq-adreno = "${PN}-qcom-license"
+RDEPENDS:${PN}-qcom-sdm845-shift6mq-modem = "${PN}-qcom-license ${PN}-qcom-sdm845-modem"
+RDEPENDS:${PN}-qcom-sdm845-shift6mq-wifi = "${PN}-qcom-license ${PN}-qcom-sdm845-modem"
 RDEPENDS:${PN}-qcom-sdm845-thundercomm-db845c-sensors = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdx35-foxconn-firehose = "${PN}-qcom-license"
 RDEPENDS:${PN}-qcom-sdx61-foxconn-firehose = "${PN}-qcom-license"
-- 
2.56.0

