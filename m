Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.521.1793465155952020179
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 09:45:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=SMPZlDtt;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Ju9X2TR0;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VGUToQ1554850
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=anCp512Ahp/
	LNssOdBkSDDiN8B0cAI1E47Jjv/pHhNI=; b=SMPZlDttF/izRzdHp6j0a8YIBDU
	OEti3GKp2Leqda/rGYPNMtuXq3KzSZ4jEgFqQGrntn1wx4+BCGtkZFSpL6MpLjZB
	C7PjsJCeR2peA/80aqjKzWMjgtgrUKUicS5QnFIKvOSshXCky2JTjI4m6+BfE1/V
	MwgpGVj6X/qUJ5TCUTaNuHwrOcY5Ijuce/w1uEpLXtxEDUsZnrrqbE5b0Gs9xmoz
	9QogIgT/0aI+aveUzWNWbIbpOj1yltg49axWDuAztGbOuLVYYz/2Ex3A9jb8QvmI
	ROK7Hl7Hmjom9yJZaq86jg2gyKhS9ebPUeuohHcrbhEGRD5UDWqEO4NqGaQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7shdd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb6391e89so363696785a.1
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793465154; x=1794069954; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anCp512Ahp/LNssOdBkSDDiN8B0cAI1E47Jjv/pHhNI=;
        b=Ju9X2TR0jxrc2bfxTGx81dKEiataf/f0lvEehtlGHFfj3tMYUdTMZYMpqFI51mN3A4
         TG1jUI33/M/7GycqLAOavdXWputAkiEOqwjMUoCxZ1x8fyw540/i/x3wlvdKSBMYqMJx
         BZ/un0QAgVHHXTEFM2PQHCMklzP3ijNsG68lBkO+i3Rn8VWh4A8DxTy3esvYP34VfjMs
         YUEPKDaXCDxEsiaotTGuRAcrMflk3fwYay5Pym8ew5L0ELqvknlRxhcYxd63lXxr6IvK
         AqdU/I5/cVsEWA3kZOYRf5Y4L8zQVUJ5RdhYk6AILEa8PFICqqgdzefOtsgTijhQuSii
         LANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465154; x=1794069954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=anCp512Ahp/LNssOdBkSDDiN8B0cAI1E47Jjv/pHhNI=;
        b=gb+beTH9YP/VjCEaqV8sRpUS18RxQ3fQsb1C2XpFGTNv2nIWsnbbttNd+X1x8zKolO
         /JSG+yYK0MRe7qRYlQqbzovZcxWfzCzmKcwXgASVkAKCRpE4qss3I8LI+JTmH85ThQK2
         fSMmh62U6dN8tD3KFJBfmNaETKuFFVqAqQS2qbZuTpsbVsPC3hdf44DpTthDEV2X+V1L
         6DBFhUJ1iXgIxp9aB8T6CfpYMeowUDCXJVZmicrvQ4ENIHw7VfUKnABattA98A0cK14s
         FLefZ8yuPS9/fQfKM6FAUFn0nlUn/FB0uxVnfkklxNPxbtn3N/2P1wTJ/e7Yy6SJhx91
         QUNA==
X-Gm-Message-State: AFq9FYIowSHZPlGjG6wr9mhjMOcWtUJ4wNxe1JWAG9dRbkXNyZ4lFq8I
	avbc0DPjWaNI2bZUXsMTWgemz/Kgu4WAo0jdvYPQUMaI+lns3h3sFUwIxrEmWugiQTz7I7OoMT/
	AFMKHbfMnB7R45N+c1BSoK++3J8Y1g1PsNioQLDOmwz9ofVyj3fx+nKNU97PgvUnD9qfrg8b7mW
	7qFxECReIi5w==
X-Gm-Gg: AYBFou2pDgc9vYW/mDhPnihrZgeGHEPJiALeTUuPmGlDxP2U8KzBD9h9172NDtP7Uls
	W2+cb46hiN9AzoGpezWTWZd7U0/U0JGLifr6pANPkvI+ixyotx//TBdzm662SWzAWLm7BCpMOex
	dpQ0wxndpsq6y0oSV/BQNqjHMhMoEoI8TbzfigtsgagmVwsY8bhd61+sHdq9E3ZyZ8+6ASY8hOZ
	nbPMdgwOZkox6foNK6xsjSj+56py/bthX2lujha+Duwo1cXcAQEOL2XBu95YHKGI/RnC5q5Q5qQ
	ACTIzd/c8TWoszzrU1dGdAsc/HHLzb57IIMtoOO/7FtdxE4mSJmhj55/CwttpjEycWxvG/xWuoV
	+npbra4OitVePKzbIsSsy0mvvd+z/jbm7FPNsuol6cX6jsmRD9rlB9iqo1VlMAuo=
X-Received: by 2002:a05:620a:1a24:b0:93c:6534:d04d with SMTP id af79cd13be357-9442167725emr908068185a.35.1793465153566;
        Sat, 31 Oct 2026 09:45:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1a24:b0:93c:6534:d04d with SMTP id af79cd13be357-9442167725emr908063185a.35.1793465152758;
        Sat, 31 Oct 2026 09:45:52 -0700 (PDT)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm103398055e9.0.2026.10.31.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:45:51 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 02/10]  linux-firmware: fix license syntax
Date: Sat, 31 Oct 2026 16:45:35 +0000
Message-ID: <20261031164543.1668-2-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
References: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0Bog1kuJu2EJV0mo9VFaNHS4h3z66iNn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX9+rmcr6kshvL
 eQ2Lv1gcyyPcpQB6x/VR3W/h6D85pdQvCSMDyvm+NBt6PbBS74ztWIJGwss7T6zJhlSRNkfCGbW
 7VDdPgV8VDlSg0Ehjiv7+WHFLm6UjTM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfXw8RweunO4KdU
 shdfo4w067bSxWm129nkFzdRwMgZ0iE4q+4AxbEQ/zLB38YrHvPbmngPXZk8wicGqT6sfePLxu8
 Oy45AyfxrUReMPhumeaX7Mv0AFsVDtSWpVVqeEkOxlUar2IGsyVKiFplYPLKWOTOpR9Ed3+fEgE
 HgGA0dtzySqsS/AlozabI4RMlvv4YIIiVp9gO62Yws14FkyEJEVevqCAgtYKomPCz4lyUkWiKWq
 qzZYaPvvNa75a9fIl4VJnc5CSTqX42CXAxLEgCGaALErtXzW1nRH76ibD17gTnUzy0VjW8+MKco
 Ui5NyZ90GvEGlpnPQxuz1H0bBzgwSiqMV6InnZt7vvFe5whF8sHeWhPbXfzzXW0NPX/YubxHKxW
 nRo9HfFvRc9vqg6FPmkwgsqnoJQNDpOQI6asWU5CIlaoFDHE6Uzynun3g0hC6LyW8XLRe6D1yUl
 3bxGpeU9PZf3HyYmo2g==
X-Proofpoint-GUID: 0Bog1kuJu2EJV0mo9VFaNHS4h3z66iNn
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae61b42 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=Ii1caJqkCqkA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ttYbbYDM-Vukk9vDhpEA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:45:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5195
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 .../linux-firmware/linux-firmware_20260916.bb | 324 +++++++++---------
 1 file changed, 162 insertions(+), 162 deletions(-)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260916.bb b/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
index 2f7fc7d..c7f9bdf 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260916.bb
@@ -1644,27 +1644,27 @@ RDEPENDS:${PN}-rs9116 += "${PN}-whence-license"
 RDEPENDS:${PN}-rsi-91x += "${PN}-whence-license"
 
 # For rtl
-LICENSE:${PN}-rtl8188 = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8192cu = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8192ce = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8192su = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8261c = "LicenseRef-Firmware-rtlwifi-firmware"
-LICENSE:${PN}-rtl8261d = "LicenseRef-Firmware-rtlwifi-firmware"
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
+LICENSE:${PN}-rtl8261d = "Firmware-rtlwifi-firmware"
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
@@ -2370,147 +2370,147 @@ LICENSE:${PN}-linaro-license = "Firmware-linaro"
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
-LICENSE:${PN}-qcom-eliza-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-glymur-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-glymur-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-glymur-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-hawi-audio = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-kaanapali-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-kaanapali-audio = "LicenseRef-Firmware-qcom-2 AND LicenseRef-Firmware-linaro"
-LICENSE:${PN}-qcom-kaanapali-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-kaanapali-soccp = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-maili-audio = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-nord-audio = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-nord-compute = "LicenseRef-Firmware-qcom-2"
-LICENSE:${PN}-qcom-nord-qupv3fw = "LicenseRef-Firmware-qcom"
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
-LICENSE:${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-audio = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-compute = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-modem = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-shift6mq-adreno = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-shift6mq-modem = "LicenseRef-Firmware-qcom"
-LICENSE:${PN}-qcom-sdm845-shift6mq-wifi = "LicenseRef-Firmware-qcom"
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
+LICENSE:${PN}-qcom-eliza-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-glymur-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-glymur-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-glymur-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-hawi-audio = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-kaanapali-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-kaanapali-audio = "Firmware-qcom-2 & Firmware-linaro"
+LICENSE:${PN}-qcom-kaanapali-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-kaanapali-soccp = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-maili-audio = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-audio = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-compute = "Firmware-qcom-2"
+LICENSE:${PN}-qcom-nord-qupv3fw = "Firmware-qcom"
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
+LICENSE:${PN}-qcom-sc8280xp-radxa-dragon-q8b-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-audio = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-compute = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-modem = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-shift6mq-adreno = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-shift6mq-modem = "Firmware-qcom"
+LICENSE:${PN}-qcom-sdm845-shift6mq-wifi = "Firmware-qcom"
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
-- 
2.56.0

