Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A81CFAD419
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 05:47:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13471.1776923269385090526
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 22:47:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=AimLOgdo;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=jLo+yxwZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N3Ma7W1587773
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=faMGT/x8gOn
	m2Ue+PKpro3lhhToqO/Vt7IOyKUqIhI0=; b=AimLOgdoq121GKBsS1hom0NwuLA
	Pk4HYv5gFkG5knS9n3cUDWsrL9LrUMzSI5CXBZ1PUQtNr4bRe7JOKBFp3MfihIoR
	5uTrHiW7w1L076lJEWCX1yf1R8v7TOpO6Toye0u7edHk9gn7Hjp+3b5nV8hn/br7
	rmsDD2e+ub07ueJjef5Gj050gzjW4HDiTGqifE73/wiMrFMOGYlQMk9ceQhM0vNX
	1gyDY6EeAMu2DhbJ9jVcDS5cem0EaqMEsLlqLfhz6fgg4ukk+JrAsmA5GIpsHGdL
	Ub08Ax83L+F2i7oR5IKb5DL4yKDfI9RxLtYjeRI1jANE2g6TyxEYbbvYMwA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq2axk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c79281bd14cso2520234a12.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776923267; x=1777528067; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faMGT/x8gOnm2Ue+PKpro3lhhToqO/Vt7IOyKUqIhI0=;
        b=jLo+yxwZdVUByXUQ10lrNON2gZLb04PNYODUizYsfCCjqUDH1dKGG8v2oPbdx3xr1r
         HBXelMeW89boJyt2YwQOtjy/9a8T0VAAsxlee5jIYxrlfZ2dlzezrbO58B3UCjZVUILu
         nIt7A8wTUVfpzUYum5DWz++16rOiIaosch0mNKtxHc4YlAQXlCu9x1nUYU3DBGSa4oGc
         4dnxzzC9z0+w/fApXWT2H5t1HLcISQUQrJMjVbSR2spKkBp3OAu858Mart1RRIc5z55D
         a5yu96L/EdS5pdCX2/37VaGxNw2X9L3Y6HaUX6YarT3jb2Fqz2W6rhDhOGv3dLGefsNM
         b8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776923267; x=1777528067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=faMGT/x8gOnm2Ue+PKpro3lhhToqO/Vt7IOyKUqIhI0=;
        b=Pu34vRiPJpcxCVTPRsTDRIbBXgLMqhlul0h2YT+ILaX/Dcz8nwpYiROMeP2x33CvMT
         /aepw2tZns2P5SkttLArYDSZIZ9lykb91F0IgSrVmnODUkZ5s/CJf9qammAQDeaKjr+z
         RIafAEIgIbRI3stEr9DTa7Se/pqig+5uvNlcvfRXc+4PMN3GK7sY0UxDfT+7AKkpXA5q
         3ndmGTXZXD1+97A5DLPvN6Vy5sIp7WaXYmvyMqFQWcas8TFoHyPaPUREpd6R4b1hHLrD
         tVrSGJERpZhE5pjHtAzZA6MTg3wNfBUbmgwuDut39ka3ppupQ1ziV+EMndlnwXvL9lnk
         dtaw==
X-Gm-Message-State: AOJu0YwPkodsofpeTiRTBF0QWQCNv41uRK3U/9DZtSaGJztPK1mPjXo9
	qyros4aHHvGAXF6SBNSu6of+5LuIyXukOyLvPVKc9NVGNnayFM+h896owyxiMRl6Is73JnpANwg
	LUzEL1CexXCD1TajMBqXqsmg511Iaw7bEGzWOo195hRNldQHr2q4eBeiHZJ1jt5JYHkXU7xdpiw
	+gJCUo9o44PXlL
X-Gm-Gg: AeBDiesrU/83JqHE7NoU/wGarTMgBykrPf+5FwpMc9jm6UayS77g5Ez/h5gazgZyKWJ
	jg5NaSeS62daQZQbSRJAY+hiYofVsBO0oekotTehaflRqUkleR1+8QI8nZHKM8/zO8DLgD6e54j
	j+sfpuh8cHqv2mB+EOE33WwL7mvtcj7twS2uk9CaO25S9qTYdWJcloWuBkS5Q+Yufb8sNLlYKuG
	YIGagdegHPzgh3nBE4uD+2BWlqlO7JswhjxoK+yZon8YTeS8AlSUC2MMAKPm04mU1OnU6ktIKU+
	UeURMNlHMKJQ8oVRuIK9AoFlT9w0xUdQanhnOmYVQpSBH1U1QOW+cDc0GPj52jyAKH1IkeUXL+c
	G3pDkuwfiGlObIMGSKbJXjmMQY3bxEDKB8uRpQQ==
X-Received: by 2002:a05:6a00:6c87:b0:821:8ebc:2899 with SMTP id d2e1a72fcca58-82f8c7ee28bmr25961455b3a.7.1776923267319;
        Wed, 22 Apr 2026 22:47:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c87:b0:821:8ebc:2899 with SMTP id d2e1a72fcca58-82f8c7ee28bmr25961434b3a.7.1776923266804;
        Wed, 22 Apr 2026 22:47:46 -0700 (PDT)
Received: from fedora ([2001:f40:970:6089:46ff:e946:5748:5ddc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm20426925b3a.20.2026.04.22.22.47.45
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 22:47:46 -0700 (PDT)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-dpdk][PATCH 2/4] dpdk: add PACKAGECONFIG to build shared libraries
Date: Thu, 23 Apr 2026 13:47:29 +0800
Message-ID: <20260423054732.216696-2-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423054732.216696-1-anuj.mittal@oss.qualcomm.com>
References: <20260423054732.216696-1-anuj.mittal@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA1MiBTYWx0ZWRfX/2SJWFTXGBXa
 HwzUDR6Pjk+Mdn3J6ffhrVBx689/boqxj5DlRVOtauZD+zE7xe2Ff0hy9a4BzskYyjNcRdkzWdJ
 GgyPF5B8qpdJjtXc1+a7mjH0xP+e95Hn+xTXzx6YGPs72cAR/JvSER0MtT3QXFhIjLclcizxjnM
 qbl4OZT7veBVm4lLANhG/hg4R90emDUWmDm5jOdAagrtDQ6gq0NlWAd/Ot3IFam5X0kR7Lk009W
 rP27zlMydZ49IJdd6QWbmwMB1cnrvae57YkhTN0vYl/qt6jF7lwLGTpm8Xw+2UWCeIlbZMGvkEc
 Iv/MkROt3MFSrhUaCeggXuRq8daT6xYaRe7Pf0QlLR67/CcTL8pzQ8MXsvzOP1JlqhCzwdzsQHP
 z8k5422hvcvbbty219y3fTRR2wgHX8azz2EAoBDatoLPloLqxc37s7UDzbqZNdsJG+8yLBbKYby
 dbGcZWvD/7u3EGTTqBg==
X-Proofpoint-ORIG-GUID: uePACI1IcGQeS1iJ8UIZso8_F6XtZhYy
X-Proofpoint-GUID: uePACI1IcGQeS1iJ8UIZso8_F6XtZhYy
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69e9b284 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=yig7QDnRfxb5FTjfBbMA:9
 a=0lgtpPvCYYIA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230052
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 05:47:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3769

By default, DPDK performs static linking for applications and examples
[1]. This behaviour can cause the build directory to exceed 100 GiB.

Provide a PACKAGECONFIG to allow building with shared libraries only.

[1] dpdk commit 93b1f90ae174 ("build: change default library type to
static")

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-extended/dpdk/dpdk.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-extended/dpdk/dpdk.inc b/recipes-extended/dpdk/dpdk.inc
index 0a947fc..d59af8d 100644
--- a/recipes-extended/dpdk/dpdk.inc
+++ b/recipes-extended/dpdk/dpdk.inc
@@ -26,6 +26,7 @@ COMPATIBLE_HOST:linux-gnux32 = "null"
 PACKAGECONFIG ??= " "
 PACKAGECONFIG[afxdp] = ",,libbpf xdp-tools"
 PACKAGECONFIG[libvirt] = ",,libvirt"
+PACKAGECONFIG[shared]  = "--default-library=shared, --default-library=static,"
 
 RDEPENDS:${PN} += "pciutils python3-core"
 RDEPENDS:${PN}-examples += "bash"
-- 
2.53.0


