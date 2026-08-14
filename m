Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EC5C5DF6A
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 10:49:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10403.1786704593238812114
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Aug 2026 03:49:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=ZqfzfqHQ;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=LpeRwZPh;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAbcVW1100422
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6uiWMJGg8lH
	a6kyJwJWvtudpg9sTm6wN0Vb2fQltz0E=; b=ZqfzfqHQwbSj/Qam4vMz2QXskIk
	0ZlChoj3LToQqH8ucY+RyVYUwrSBoQUquCU71mAKUpSKp3KpR0ZqqOfT7SnL2kbE
	q8g0P3w9k++cV/VWQguC3TgywB66kbZ4l+7FozqrsxMbxG1A/huRdNbf+sMqfuqE
	TItqhYKkHpz3Fdaz5R2oiem0zgyUgSwBmFJBD4DG9EW8ubHCT/lhpU+cJktFwuPR
	C6ebKcMoKPZpYT/JFH2u/2za9txRdytUd4z3h+EzZZ/dQ91Wb5QUlD0ov/XvDiTD
	ZKfi8+memkl2k6EgLKfF89w+/eT5QjUWap4tpfG+2dNnqUV53+uqn8fAv5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g20tr06hn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a8b0a08d2so7545641cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 03:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786704591; x=1787309391; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6uiWMJGg8lHa6kyJwJWvtudpg9sTm6wN0Vb2fQltz0E=;
        b=LpeRwZPhL+lRqU7BRrvm5CiUhRYOCm/TJzOqIV4d3vBybzxzo3q6qD4QJvVNZ4q/5Q
         bwFQfkM0EYCTbUc2jZIehmBxnv8p32uSEv8eqqfE145jy/4MoyUOx4cOL0gIMSgVyA2T
         InQoam9/fCSKkmVDSkMBQyKxsshyqz4fvLaPSdw8yS49+uZKUKOLWJ67MXytpxMsQzxX
         ial3WQBgvtnpkkhUmHoAVL/a5mjyD9zNpPc8jPItP+REWB6oeLTZmMdIFJOG/y/Jvj5j
         VB4DuQqrh8CD10QomXmLfNgDEVYMVp1uNy5ghRwKxeZP3606dPHKDMyBsatR93cOxZrp
         8ggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704591; x=1787309391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6uiWMJGg8lHa6kyJwJWvtudpg9sTm6wN0Vb2fQltz0E=;
        b=ZWLeE1Zy4f3UbxZ439jRZyZiXmMXxUj58i+qDuea1/1bfxb/eOrCaO3UfmyxNakK0J
         ayHDbYQEOQF/nT3yOwyNPcejcM1StNVLXSEWqEQus/9rRB3/6589c3PirHtCNTtwNFDY
         IGOYNO88KQmeT3AsSUJKHRgqszDULnN8ScoXd9JF2p6XeombJ+18NmPNfZ8aSYgti4cB
         YyzFKh+pjXEMzDCQwhK3nyCeibUC3rI4HdNRFyLUMniDLJ7KHXymufHbuCj81zc0tqfQ
         xrL82TF4B02Pb55NYuCB5j6Me7Rkgj+aImO2dxn4ttb722N6cXR2VaTQIdL43DBIurnG
         0aoA==
X-Gm-Message-State: AOJu0YyHuaGq65DQpVs44BdWSyHQoKTNhZ2KpdKhPAgEXVuc/0fbTFua
	b/P77FDj5sU4qXdVY3IBQPAz3+DRZsH6gxOSjCLZEV0KHdrNJKiqJelvDjxnjvp88Pzwou/mZ23
	A4/9/ou6nxCuXVAk2c/sQfNuyt/jNeaRWz+8/ru9WMSpwXu/HX4SdnRPDItDam1xiETpMtAjg8w
	7+zMZMQr0yBQ==
X-Gm-Gg: AR+sD12bSjQfytZnGERk/DWnJEiYw/TzM0DEF9va3oc3VCi7pgxt1AYm8lxsZ4lV3+Y
	tiJZQ6lActec70MShojJ8J6lr2QkjsA+vCu7bixokJoBD/Pc6TCFiUJtiRef9wPk3LQofqaUC9S
	UAN/un4yGMlnD2kWizemtdRHRRyW/F3uTW4qzvs65YV5hicc1XED6XgDxH+daT0I+EdAgOROy+v
	YPavAv1U9MCRRXyfzM0ZDmyzFb0mjAE+HApWtvraAlCdqhLx320mo9FgorGB3ln+NIhJ0/mhBDm
	3j0XyKaIOQjSvBeGVf2AdPAORqyP16FuViRfWIb4SlYRk5p77Oy5tDTtN6XUD/vaKZ7Vf0r3COD
	Jm88g8tqVMjneLVM=
X-Received: by 2002:ac8:7fd4:0:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-52d85538e0emr52617001cf.37.1786704591202;
        Fri, 14 Aug 2026 03:49:51 -0700 (PDT)
X-Received: by 2002:ac8:7fd4:0:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-52d85538e0emr52616581cf.37.1786704590679;
        Fri, 14 Aug 2026 03:49:50 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm7064102f8f.32.2026.08.14.03.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:49:49 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>,
        Martin Jansa <martin.jansa@gmail.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 2/5] linux-firmware: fix typo Firwmare/Firmware in one of the LICENSEs
Date: Fri, 14 Aug 2026 11:49:40 +0100
Message-ID: <20260814104943.3261-2-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814104943.3261-1-jose.quaresma@oss.qualcomm.com>
References: <20260814104943.3261-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -BaE7t5V1LI4RiyGyZmI0QQbICmIpQMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MiBTYWx0ZWRfX5VXFkS4Duehf
 ZL9rVMB0Tsv4Av5X69c/82U00Y/b4CKsa64nA973OHFefKOZ7dMOR0AQ5YbLVTVb2UKVqOnm6yQ
 TXjC0sZUz+3C4o0wp1DY4d5dMgvr2LsjnO6b4vme5wVaJGWgD+FmaaI2qpx94MztUqX9e9Z+4TA
 KcKz5Pw6y4R2P4jRq6I1DjjVAcSYcBpcrnO8rvDm/JVzgmBA3fAOHuz6dscpWq6wLLYP7ytY/HB
 3GCP5ygif/Gd2TLv1/zAKEMqlUBlFYZnr++il+L6xnjGLaGfpt45aHS41aqP92WQh0VtcInNK4/
 FVKqDFMD1iAe+z4mqSDA1qFxXTvIPci2PXReBB8yykAZFz1cY9kV4jX3X65mWYNsp6GFGKVHzvY
 ItOmG9ZYr90aly4eW61MvUttIBGVndb5SWltE/WfsUyr+FO1l2EEn559cgFjbzlmVh87WIAEc3g
 ym8mElMe2F7b4T3AKpg==
X-Authority-Analysis: v=2.4 cv=UrdT8ewB c=1 sm=1 tr=0 ts=6a7ef2cf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=pGLkceISAAAA:8 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8 a=Cw2yZeb9EotIFGSfvoQA:9
 a=dawVfQjAaf238kedN5IG:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: -BaE7t5V1LI4RiyGyZmI0QQbICmIpQMq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MiBTYWx0ZWRfXxjIVkdLLsdw9
 r226fcOde97szBzgzbc3H7SVO8n8DdzEE+O0E/JTNchoC35XyXelqV1hUZNnNmyBZkjhbpcT6zQ
 DZsIx27oRgMrYFOLVei+UICqB+HzAUg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140082
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:56 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4659

From: Martin Jansa <martin.jansa@gmail.com>

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 .../linux-firmware/linux-firmware_20260622.bb          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260622.bb b/recipes-kernel/linux-firmware/linux-firmware_20260622.bb
index bb49588..32cae7a 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260622.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260622.bb
@@ -73,7 +73,7 @@ LICENSE = "\
     AND LicenseRef-Firmware-ice-enhanced \
     AND LicenseRef-Firmware-inside-secure \
     AND LicenseRef-Firmware-intel \
-    AND LicenseRef-Firwmare-intel-vpu \
+    AND LicenseRef-Firmware-intel-vpu \
     AND LicenseRef-Firmware-ipu3-firmware \
     AND LicenseRef-Firmware-it913x \
     AND LicenseRef-Firmware-ivsc \
@@ -335,7 +335,7 @@ NO_GENERIC_LICENSE[Firmware-ice-enhanced] = "LICENSES/LICENSE.ice_enhanced"
 NO_GENERIC_LICENSE[Firmware-inside-secure] = "LICENSES/LICENCE.inside-secure"
 NO_GENERIC_LICENSE[Firmware-IntcSST2] = "LICENSES/LICENCE.IntcSST2"
 NO_GENERIC_LICENSE[Firmware-intel] = "LICENSES/LICENSE.intel"
-NO_GENERIC_LICENSE[Firwmare-intel-vpu] = "LICENSES/LICENSE.intel_vpu"
+NO_GENERIC_LICENSE[Firmware-intel-vpu] = "LICENSES/LICENSE.intel_vpu"
 NO_GENERIC_LICENSE[Firmware-ipu3-firmware] = "LICENSES/LICENSE.ipu3_firmware"
 NO_GENERIC_LICENSE[Firmware-it913x] = "LICENSES/LICENCE.it913x"
 NO_GENERIC_LICENSE[Firmware-ivsc] = "LICENSES/LICENSE.ivsc"
@@ -3304,10 +3304,10 @@ FILES:${PN}-intel-ipu7-isys = "${firmwaredir}/intel/ipu/ipu7*"
 RDEPENDS:${PN}-intel-ipu7-isys = "${PN}-intel-license"
 
 # For intel_vpu - Intel NPU driver
-LICENSE:${PN}-intel-vpu-license = "LicenseRef-Firwmare-intel-vpu"
+LICENSE:${PN}-intel-vpu-license = "LicenseRef-Firmware-intel-vpu"
 FILES:${PN}-intel-vpu-license = "${firmwaredir}/LICENSE.intel_vpu"
 
-LICENSE:${PN}-intel-vpu = "LicenseRef-Firwmare-intel-vpu"
+LICENSE:${PN}-intel-vpu = "LicenseRef-Firmware-intel-vpu"
 FILES:${PN}-intel-vpu = "${firmwaredir}/intel/vpu/*"
 RDEPENDS:${PN}-intel-vpu = "${PN}-intel-vpu-license"
 
@@ -3580,7 +3580,7 @@ LICENSE:${PN} = "\
     AND LicenseRef-Firmware-ibt-firmware \
     AND LicenseRef-Firmware-inside-secure \
     AND LicenseRef-Firmware-intel \
-    AND LicenseRef-Firwmare-intel-vpu \
+    AND LicenseRef-Firmware-intel-vpu \
     AND LicenseRef-Firmware-ipu3-firmware \
     AND LicenseRef-Firmware-it913x \
     AND LicenseRef-Firmware-ivsc \
-- 
2.55.0


