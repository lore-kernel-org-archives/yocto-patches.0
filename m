Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DB2C9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 19:35:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3620.1790192111315017987
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 12:35:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=VtRHeKPx;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=TCO+VCEt;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGThUR2470173
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=drQBAFmLgjDMnGHbrir0Fzh42NZqgj+jwuE
	HzNAQeE4=; b=VtRHeKPxpnVfOIoc13K5Jd/eyZf4nbab5HtXqbKDpNZGv2wBDmI
	RtyEwwQft7R1X5DYwg5ICo6wyd91LrEXN67uExriKp/kF2GjA8gvAvagaGQD3XtF
	1w9Q5Nr92aa4gQTwvhSgLqKFNHeb4D6Anj0n6dEJg6IGJvJwp7Ap7px5ohu7D9VK
	K8dUwTfdOc7yHRwRy5zW+sSchGGqeuxMAIsvmLV32v4hYkhPgMuwz0HGOODg6yMt
	KmPbp0GbHjn/s66Yu/aPYZgN6o2jWADg33mdcXT8eUAFgwZhqwpz5IpJT8icjTDs
	hysKaSk9JKlYfGKgI1AfzseniHlSs5mVjwQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv1nm9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:10 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7a9378b844dso453757137.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 12:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790192109; x=1790796909; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=drQBAFmLgjDMnGHbrir0Fzh42NZqgj+jwuEHzNAQeE4=;
        b=TCO+VCEtzD78VrAk7dybP37S515aGVc4ccWrQwxaG65cg9uGVy8LJTz8KG+S2PoKSR
         k0uHMeziziBV3DGuu6hUiF0LQRtQKRNdWq85GAaZobHLUf8wzecExr+UjiKWUcQwk/us
         HDLDgPgP1h5orAUIC0zxqQgywc7HLGoQXShzGMG2uLwCYo1sjcQIZBTheDBwgOTDyEQF
         Ls88qe0zQM/Rz3IKCmzZczRLUeXMnOXYOG7Che/WjCEzOJCMiFsukaePyNfOcjJGvg/j
         o2n0HJzL5kb4RUPVipfPcQXPLZXqFJYIL3q1JfIODNTIi5fP+8H5VKiZffNLiYscbYGU
         zlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192109; x=1790796909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drQBAFmLgjDMnGHbrir0Fzh42NZqgj+jwuEHzNAQeE4=;
        b=nr0RH+WMp3N9P2HRlA9UwxSAi5kCDeE6VLpW0S16ME5quii7awUHYM1b8K3eVt3XT+
         cIJoXgrPuM/Km5DohkZp+dTf16xfMXfSV9PzI8GycMEhiIvEhOLUAqOGcb6CKRA2n419
         /nMkajIvgfLc71u34Vhy4tiYuH0saSIgWFEqVBJrC3GWpRm7/rSEEOrhK+B7QeZFl0+U
         VoFwPayMSKjM6eGvXggwxVm9w2AOR+6rRrWcGMR50Oi6mKxVcM3O39FwHB61sOB9uvCY
         S9IsLgyKKWmIHseAy0rsgxgwzjg/6I9ApljvQnu1uWsPyd2dgzk0Wjdbh4FMWwqACm64
         pcJg==
X-Gm-Message-State: AFuF++noi69n0+sdgbNdpTruMFKPJ1K1Orq4weSn6iZwEwd6b71MeyPu
	wamgeecd9594N8nH+xl3AblA9NqycM2Y2fcQo19zJ0PxLjaFEib7rrk9nI9D0LKUFwi2Z8ue8J8
	W905Oq02hkVu/bsqglEy8MgY/WPk/ynsm0LM15ZFlJt/kHGGBQV8gZEOlfxZ5zCHTyDHEJuR1Ws
	/Ojwpq4FQJFRxy
X-Gm-Gg: AYBFou0LvObudw7ZM4zjNK0tZD/kwQZkTHGidzJcB9ciGwaYuRrP74cod0j1Dp5N6pH
	FergwHGTlzbhT+yQ1etr7E853mMIAd2ToFGfnWVdyoevObk/d4Afnti3OTfenXNS+SyruGSo3S5
	MpliJUR0WSPDcyNkSJH7xRXSr0iXnOWijD6XblzpzF0VBpkTkSmcP9KZbcj2aNeSacKjqWh4JdC
	PH5LRk9RoyG+hHaiHCLudd6jovpBGok72V5lkYEZ97DbZl0ZicdlEjMeoevC79BzG7a78Jx71f7
	AkB5sk+N+Rd3eLHqN8Th4LeByVDtiBQvwzwCbFt27fWUPkXRwRFqYJnmehQL01KkeFSVO9dWpMn
	bQKD1ydNURpbptw==
X-Received: by 2002:a05:6102:f88:b0:798:8ca:3452 with SMTP id ada2fe7eead31-7af1c58fa3emr253902137.1.1790192109148;
        Wed, 23 Sep 2026 12:35:09 -0700 (PDT)
X-Received: by 2002:a05:6102:f88:b0:798:8ca:3452 with SMTP id ada2fe7eead31-7af1c58fa3emr253880137.1.1790192108622;
        Wed, 23 Sep 2026 12:35:08 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm8706964f8f.6.2026.09.23.12.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:35:07 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Thorsten Schmelzer <t.schmelzer@phytec.de>,
        Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 1/6] linux-firmware: split out iwlwifi 5000-5 firmware
Date: Wed, 23 Sep 2026 20:34:52 +0100
Message-ID: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfXyrEGaBFBaGlq
 2NIUXCaA/totkr25XT/LavFxfajsHmAMvxjnICbktCXdGCGvNcLjYTG5pe+LB4L/Vz8A+fsZQlm
 SweIHXK3vU2uCVi6FXp8vJ7UD1bNVbnMpVFw4Z+QX5oKACTF3taCBkNj3nduB1FT70uozSzBqdu
 wXUlkRI6mifnfjDm8ajn/L2Rxi+wo5iRatb139tD7NCQnVmSCcz/RWA2v12Cjk6vYHqEV/pFT9O
 yc6fz33+VC96IVGCSdmhZ5azg5nWSlGNZO+Ych882SPvQDCCxpSI1BLdfcmvb+RSHZt5pdH8WFO
 H2mCR7JBeY0m6HKL4ohV4UdOg//sZpt8PC72XhRPPx+TWscBlW8ZW5uWLu3rjRp+Jh9532wD7h2
 SR9kwlDWgEuobIL7A2dKC3zAqtzyI3n5J3tuKZvfpECZy+Nx2yMnJGBvgOHounEzhLTBf63LzNF
 fJdoJQtidr6zQEWiKFA==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab429ee cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8 a=Exvh-QDO5tLFjIuUGQMA:9
 a=ODZdjJIeia2B_SHc_B0f:22 a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-GUID: uIU_LexBKz5lmkwQ_WWDqBvg5L7tpoOO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfX906MjFc/8Gej
 26QKTkBb/aq1TcXmoo446o3yo0IvRF1XRCSFeuAu1uPfZhxzV9+QoOK1PSZhPggSkIF887h/nbb
 lU21c8Gjv4qS0CfyYUWo4Cod6KYN/5s=
X-Proofpoint-ORIG-GUID: uIU_LexBKz5lmkwQ_WWDqBvg5L7tpoOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4943

From: Thorsten Schmelzer <t.schmelzer@phytec.de>

The firmware currently resides in the iwlwifi-misc package, which is
238 MB large. This is a lot of space, if you only need a specific
firmware.

Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 recipes-kernel/linux-firmware/linux-firmware_20260810.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260810.bb b/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
index afaaff7..ddf6627 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260810.bb
@@ -631,6 +631,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-iwlwifi-3160-7 ${PN}-iwlwifi-3160-8 ${PN}-iwlwifi-3160-9 \
              ${PN}-iwlwifi-3160-10 ${PN}-iwlwifi-3160-12 ${PN}-iwlwifi-3160-13 \
              ${PN}-iwlwifi-3160-16 ${PN}-iwlwifi-3160-17 \
+             ${PN}-iwlwifi-5000-5 \
              ${PN}-iwlwifi-6000-4 ${PN}-iwlwifi-6000g2a-5 ${PN}-iwlwifi-6000g2a-6 \
              ${PN}-iwlwifi-6000g2b-5 ${PN}-iwlwifi-6000g2b-6 \
              ${PN}-iwlwifi-6050-4 ${PN}-iwlwifi-6050-5 \
@@ -2165,6 +2166,7 @@ LICENSE:${PN}-iwlwifi-3160-12   = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-3160-13   = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-3160-16   = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-3160-17   = "LicenseRef-Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-5000-5    = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-6000-4    = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-6000g2a-5 = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-6000g2a-6 = "LicenseRef-Firmware-iwlwifi-firmware"
@@ -2192,6 +2194,7 @@ FILES:${PN}-iwlwifi-3160-12 = "${firmwaredir}/iwlwifi-3160-12.ucode* ${firmwared
 FILES:${PN}-iwlwifi-3160-13 = "${firmwaredir}/iwlwifi-3160-13.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-3160-13.ucode*"
 FILES:${PN}-iwlwifi-3160-16 = "${firmwaredir}/iwlwifi-3160-16.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-3160-16.ucode*"
 FILES:${PN}-iwlwifi-3160-17 = "${firmwaredir}/iwlwifi-3160-17.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-3160-17.ucode*"
+FILES:${PN}-iwlwifi-5000-5 = "${firmwaredir}/iwlwifi-5000-5.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-5000-5.ucode*"
 FILES:${PN}-iwlwifi-6000-4 = "${firmwaredir}/iwlwifi-6000-4.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-6000-4.ucode*"
 FILES:${PN}-iwlwifi-6000g2a-5 = "${firmwaredir}/iwlwifi-6000g2a-5.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-6000g2a-5.ucode*"
 FILES:${PN}-iwlwifi-6000g2a-6 = "${firmwaredir}/iwlwifi-6000g2a-6.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-6000g2a-6.ucode*"
@@ -2220,6 +2223,7 @@ RDEPENDS:${PN}-iwlwifi-3160-12   = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-3160-13   = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-3160-16   = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-3160-17   = "${PN}-iwlwifi-license"
+RDEPENDS:${PN}-iwlwifi-5000-5    = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-6000-4    = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-6000g2a-5 = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-6000g2a-6 = "${PN}-iwlwifi-license"
-- 
2.55.0


