Return-Path: <dmitry.baryshkov@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9ADC55184
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 11:48:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14498.1785844076736379198
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Aug 2026 04:47:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=hjazH6b3;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=LJiPrJTt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748CLda3217734
	for <yocto-patches@lists.yoctoproject.org>; Tue, 4 Aug 2026 11:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=YU6vjCAw1+Zy+vEWiFzXwwLSGHANPJN7t07
	/4x+8gPM=; b=hjazH6b3MxIA8nRWDONT3yQS9iL585q8ZHlA8dC0CgRdFIW07II
	hhGqaOQkd+qlNYJTqctr773NvsSxKmaop94+16GlQesoyfDC5/HIjPMIE00ebvvQ
	98z6r8k15RsuLL/mHcuA01h0Qe2X2e17wGgc15HHMMDxu+D33IP8iNcAM163uN5o
	sl2qNqYVI8812nubuw3PtRYZJs5Yi+F5cxUBPkEepaeR2L+btZrxtb6JG+4FZhFN
	OzCb6NC/bo4BY3liF2gTplEi6wQ91WBCn3BJkotD+Ix9TqSrMNpHhI9aVE0PA/+S
	ZMZx1FcnWWe9KAqjZThE5Y6HneCFyPfYUrg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty5sc0k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 11:47:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-529ae8e96e8so43035421cf.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785844072; x=1786448872; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YU6vjCAw1+Zy+vEWiFzXwwLSGHANPJN7t07/4x+8gPM=;
        b=LJiPrJTtveDM45CDPk5175WNJyHFcI4lhVlLoTFxNNdrnxDl0bRT8xgAMslWPx916X
         JfFUPRK395rj0eLOOcxp37Q6K/ZPKPBT4AsBH3h1YLNw4k0kowpxIeIAIDLC/xlsnRYG
         pWPTNpTc94/asXowMoiYd0wrkkYoP59rcsY+zAZ73xdGw8GWqlsbPUZBCemQFk8fgQ+Q
         l2+zzW8xeqfzTSYC4xoGLZqAFdbu8fduNIjtyP8G7zDsx2+mYb+OdpoSRDTcRft9nLcE
         G0MGUTKl6fNQdb9BsOMad2PSSHCPq3JDDUfQn+pKOalpUAy0p5t/lyzDrbBZ5g/xxwH4
         BWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785844072; x=1786448872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YU6vjCAw1+Zy+vEWiFzXwwLSGHANPJN7t07/4x+8gPM=;
        b=ga4ra/sTJ5ovKl6OAHkP1zTnBUCSPA9GSp738l5vCIfbigfMU4XwDQjgjkoNl36Wkt
         Mig9lDWajCGEgtLgSVHpjlqg9s36hX1RA9O6Lh7Bn/CZioFq+uQAfO5cShAycRxXrNVp
         LZJ7PvQYJwDfQmFnzGTGcJtvumUhEc9Q/9V8O8nKAShZyGRtwPG3sr3DP4rJVZsUtBw/
         m70sbcrDKKrKlK1JQPL6iEc8hNaJzvBAu4LqzPnppJw693hZfGhftJbl5Glim7yv1Pce
         JPjyGIf9Vk2RvVWGWMu9UanpobqcrnH4U1FzWfqzutI6eO1XhpM3UsHNuFbgaXkw6Upl
         O1uQ==
X-Gm-Message-State: AOJu0YxCfx4AhIA747wsFS4/48QRvhTex5Nti+3AHNH3mNl4iIz9IX51
	AmqyfnaYHk+xbIfzVCPD2WcNDlqzWxEHZ/8ghAfrkgoegFGsjFbgsS9E5VSea7l8qmo++qFB2aQ
	J0RxzvNeLaFpoobpkGhnys55BMy9VL/9GJVjX0XkVIQFcv9rEmYhMjZ87wwEB7/kQtiLAT7Znk4
	vvyAdJSfNLlw==
X-Gm-Gg: AR+sD12iFzeYxUEhqaL1BCZe7vNTR5OMo7ViyqC17P+ugPYAbzesd/kvDEBjcgA7KLy
	JpDGyZmpmPBRdnqAdu2StkADBmW5gyNEaxaA3M89CcGOYtan0bdXZaW0YgOWOqFvWxUP9dRGxQC
	oF5I+f1xT63pwXSqRYo4TPxDx+BwOgIAhA9L/DBBJ0YPjyUAO++qpvJ5PNbgA090Xle2NFkGZjj
	5ATH4DXn9T6086myNL5vLJ8DR5/u8gngs7i8N+wncwqaM7UmXdS7VnO+ntAfG65fVREFJF0jXeq
	0lxGz+/p9qTOtYMwPjWlXyFn4onAiFMgxcROgAA1D7ndlT/PH+NIcW+qFXnUd73kOlB2KsxYpL8
	ILnkfZj2wSgcsiO8x5Y2/HYLL/77Nixi2PXbUgpC9Zy2DhQszZJ4jc2Bn6+KJTh743rlYzamB7i
	g7oyDJmJ41oBYbzA==
X-Received: by 2002:a05:622a:1801:b0:51b:9878:8242 with SMTP id d75a77b69052e-52b566f6f43mr233667091cf.6.1785844071747;
        Tue, 04 Aug 2026 04:47:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1801:b0:51b:9878:8242 with SMTP id d75a77b69052e-52b566f6f43mr233666561cf.6.1785844071077;
        Tue, 04 Aug 2026 04:47:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e2441eb7sm2636129e87.47.2026.08.04.04.47.49
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 04:47:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH 1/2] libsepol: enable nativesdk
Date: Tue,  4 Aug 2026 14:47:47 +0300
Message-ID: <20260804114749.625810-1-dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a71d16b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=9BtvCNnVe3B4G0kPcTsA:9
 a=ZXulRonScM0A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Oq1w_aqRz93Fqh0WhKN-iXHxCRIx7wMF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX6o8zpkWanQPC
 Lwh8EbNWT40RQtPLFWqO5bswVWpDDBnD8Pe1jCAkV105QIoSNrhXVZEZcupvJCbSLH51VQt9tGi
 cxNOzvDAL9e0txqnphHzhFz/WpiB7L2p/M3mUy+n5ea6p7dYHCNz4mlQ/l7R9gATrWO6Kn5G4dQ
 kAeC0dMaJPZvnYtjTBYaGJJ3FvQepnC8W8lQs9QvSn4dHl1N3u9TF5CzDXKeCvD0e0shAiCQiIR
 yb0ltFAjPyxa2Cox5Q/G0/GbcHr3dct3wWDjYDwY9vlx7cnp0OYQwnfAcjyz6b94+sLXT1pZA5p
 yuprYIb07zAyk5toNqPYtwreqEoLQZJgj1YgaFpH3ia/1MygwdwnB2Ojb9NrYmg4dNfQH+jnlJj
 qw3ixoJVeLr1qkoEU01XfmxD/LAiZnKMzjMCsmp1IEUfNz2UuDtFN7KhtDKzjs5UZN1pqAvm7SV
 mFWR9kYQPLlywT27BEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX9gJVDNXY1IFk
 1LOqLD/XeIc6T6MD0E7Ql2Ma4EEaJpv7ZrZ/KjfPQIDfLAqfheFCxv0MRst9+Q9RBa9g5iJu6pP
 dtG25g2FLHQH+XcLtrotqyEs76m8Po0=
X-Proofpoint-GUID: Oq1w_aqRz93Fqh0WhKN-iXHxCRIx7wMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040094
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Aug 2026 11:48:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4620

Enable nativesdk class extension, letting libsepol to satisfy
dependencies of nativesdk-rpm if SELinux is enabled by the distro.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 recipes-security/selinux/libsepol_3.10.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/selinux/libsepol_3.10.bb b/recipes-security/selinux/libsepol_3.10.bb
index 0a51aba28ee8..49cc9d256460 100644
--- a/recipes-security/selinux/libsepol_3.10.bb
+++ b/recipes-security/selinux/libsepol_3.10.bb
@@ -17,4 +17,4 @@ DEPENDS = "flex-native"
 # sections which are not affected by -ffile-prefix-map, causing buildpaths QA failure
 LTO = ""
 
-BBCLASSEXTEND = "native"
+BBCLASSEXTEND = "native nativesdk"
-- 
2.47.3


