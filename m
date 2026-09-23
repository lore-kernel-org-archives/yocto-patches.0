Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A311C98304
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 19:35:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3685.1790192116883001630
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 12:35:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=iUEjqmzf;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=a8xrpmYW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NJEhEf4023001
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Mjd6R1WYA2e
	84gjlnvfJxibE1JZk1IylRMn2HdgFRLY=; b=iUEjqmzf13WDkZac9i3BYjDv/8h
	pBOgTDcZY2rF0eAPW1e9Op+iIVCoNR0WX8FbBd+Hv7BgJn2heep3CvwscajT5tgw
	c9HijFlGagnPnDTBjVLiS0Q7fiBmPNBoUtuMY7dzKEDwAkL7aTjWI65yHdhNL4/z
	Zcv+wEJFMW+bnFG+uxRVHxF6e3fAyijjW2JR5QjQOrk9d/awRAE/4Ztsw91ss9kW
	JU3I8mZE3OJTVuYxI6vZ688DRjN0QwrzedKNtBD2qZdd97lOoqFJ458ncWnNlg3B
	VGfJ/aPEg2LTRJA2cU6n88W67HjJEzUetFJ/YF4vVusn8/4HCPRccKX3DBQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvmrr82hx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:15 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-97e9e1dd7fbso1057638241.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790192115; x=1790796915; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mjd6R1WYA2e84gjlnvfJxibE1JZk1IylRMn2HdgFRLY=;
        b=a8xrpmYWVTbxigK+yxr2FQy2IW7GZzR9CxYeVn4hgen2NT1p2hQYSSR8Eb7UxF0gaU
         vaxZdgwVJzM3C1cfBLiTDfFzzUnlmfSflFDFt4CBwkHgY6hZjXq96egObQrV0JTv5LcS
         ytURFHdH6PkwTDmtC2b/oZaltavnLw1F1MSfF07oCWQSpYqdoGRByFgzgqojWeEdUZi7
         kRmDaWqfxuU0mJzhcx+dOHHanIYMajv+bNf+lbcAV2AGJXw/W4/8cbrDxXVfTtbZLTCk
         oqoPLfT2HboV6OCKaCUOuTTZw06uLKtnY4HzwNkF1HcTb/YwcS1yJNatYlOi/4xEw5Tq
         AyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192115; x=1790796915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mjd6R1WYA2e84gjlnvfJxibE1JZk1IylRMn2HdgFRLY=;
        b=wgdjmwCIKX91Akn6/hEUx153f/39rAL3edOOTFs+kUd00lnXDZBcdUUg/PjAZJ/yag
         tNYENYKeWY2zvIeYwiuwJccoxxOQUg7zNgw78ex8VlD5YT0Rln4C+0d45Mf1iz+iKob1
         ZA2Q9RwFw1ydoL/BJfVP39oaQCdu/dx8mqzhRcT0rVOz6hkx0Ko1HrrmUlB75AOicTlk
         FzyGc0bRzT6JWc1tuOOwJbuXO+pcxsidmd1acd39PmvZNiojliVsPk/3OAKPD8MZr3k7
         6zb0C1QzI3WuPQHAF3SQ18YSpbfqljMUxNBb052UgTpN2IS9/3bo8JqcE5mApDjXqCc/
         /nrg==
X-Gm-Message-State: AFuF++ku8OID2aOVXdMbXSeKiMyKbUKoL9pK5KzRVl++n5Yl61HG3JNF
	Bcmi3cGVEq0TZM7QyWQRteg3HWQiy4KrMXGdWZerGUn3zomNsmCA3r26IonfEAhj8QmTPFNSgQX
	DgnjENdqSuQZ55WM0t4PlyUDbU4DyaOFO1RxsvT++R4ZcD89ry5rVVuIxIvVAwjUVcuRGGvDvLd
	TMc7zjPDBBX/mw
X-Gm-Gg: AYBFou0LTk/xG2QfUJQ5wFNsUAve9Zv17rv6SVJST6CBZtMjCgQX9uyAhSDfsgeaWAK
	+2BtUM07qNLfFY1OodfaJGiG6BKg7ucQl/ln3u4fawsElqtWGHf4eSVwPaH/gY9bd10ssTN1+Ni
	8geoDwfjfvgQPl26ZJctjcz+S40ZY/Xt69gLXuDD47CeO7skBuhBq5UIONAm8rJunlEChf9Ua/t
	KJUwUyV9+7GyUjz6CbOWoaQ7B1hRbB1cI0r4vFXTPbsiq3GOCpEvCaugQY5p8qJEcmCDhRkjpuw
	6ET/655+UIWh3M4TqUTHha02DkKTZyAs5q8KOJa7buR4IlX9goqL0U53A/EbXFljViZhCJughdU
	ueEa50ldYg1iAD0Rwruuhjg83
X-Received: by 2002:a05:6102:5693:b0:7a7:198a:c2b4 with SMTP id ada2fe7eead31-7af1dddb48emr213618137.28.1790192114943;
        Wed, 23 Sep 2026 12:35:14 -0700 (PDT)
X-Received: by 2002:a05:6102:5693:b0:7a7:198a:c2b4 with SMTP id ada2fe7eead31-7af1dddb48emr213598137.28.1790192114493;
        Wed, 23 Sep 2026 12:35:14 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm8706964f8f.6.2026.09.23.12.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:35:13 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Aksh Garg <a-garg7@ti.com>, Antonin Godard <antonin.godard@bootlin.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 5/6] linux-firmware: split out iwlwifi-ty firmware into separate package
Date: Wed, 23 Sep 2026 20:34:56 +0100
Message-ID: <20260923193457.1759294-5-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
References: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfX/o2RL+um6dNv
 2ztWwnpkZ74FjQWlIpzdQMTewKlccIzfQDgVzubGaGskmGz1/Kr34IwuCR6mJsiErUlZm/CZqf4
 B+57JH/bxAvKfVisPeZPLhKH6pvLWQ+1T1H4Yl07L9Trqn0vv2SGKyT/AcvNd0GhH36twQtwwk5
 mrse97L5FYfBTX3MJGO6maLsGbGU9z6eXaUEx7zNBKZaLb+0/ENBhhlDexfchV2blrpuqnYO+x5
 Q/WsLZ0d0HuBRUToMZbC8BQzvtDBxLkee2a3kXzM1d7B+0C1004Y1lt//4eyl1VtJc5HDQT4ym3
 rivLHke4eFpWbKZcH3ZlCBSOqGZM+Navj9DbxYojiNpwYFcJzO9GGX4NfFcIgHegFhzQDHJa6yN
 TXp/cfu/RtNLUA1aKjGbYjjBJusW6iJWZFyN4S26URNzkU6EgJEmUqInpleIQo6hplTZB83RMPQ
 4NQczSFSkgwSU6Mg1HA==
X-Authority-Analysis: v=2.4 cv=TYwDJhQh c=1 sm=1 tr=0 ts=6ab429f3 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8 a=EUspDBNiAAAA:8
 a=XA_g0ObE-_0JEKNszAsA:9 a=1WsBpfsz9X-RYQiigVTh:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfX7JgCKRMWGtlr
 3/xNnJon0Fv2iCq2vG+OIzegjpsDiFH1fWwTuvkIGPP1zz2vaufotggB1MN+Vcs2wyKoKHbPuLc
 biaeYxUK3jfXfxZHa78CwkI4FD2MOgA=
X-Proofpoint-GUID: -7jrI-oVndvezw0rwHdhOwk1oER9N4eK
X-Proofpoint-ORIG-GUID: -7jrI-oVndvezw0rwHdhOwk1oER9N4eK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4947

From: Aksh Garg <a-garg7@ti.com>

Add a dedicated iwlwifi-ty package to allow users to install this
specific firmware variant without pulling in the entire iwlwifi-misc
package.

Signed-off-by: Aksh Garg <a-garg7@ti.com>
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 recipes-kernel/linux-firmware/linux-firmware_20260910.bb | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/recipes-kernel/linux-firmware/linux-firmware_20260910.bb b/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
index cb3bde4..5c26eb0 100644
--- a/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
+++ b/recipes-kernel/linux-firmware/linux-firmware_20260910.bb
@@ -640,6 +640,7 @@ PACKAGES =+ "${PN}-amphion-vpu-license ${PN}-amphion-vpu \
              ${PN}-iwlwifi-7265d ${PN}-iwlwifi-8000c ${PN}-iwlwifi-8265 \
              ${PN}-iwlwifi-9000 \
              ${PN}-iwlwifi-9260 \
+             ${PN}-iwlwifi-ty \
              ${PN}-iwlwifi-misc \
              ${PN}-ibt-license ${PN}-ibt \
              ${PN}-ibt-11-5 ${PN}-ibt-12-16 ${PN}-ibt-hw-37-7 ${PN}-ibt-hw-37-8 \
@@ -2191,6 +2192,7 @@ LICENSE:${PN}-iwlwifi-8000c     = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-8265      = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-9000      = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-9260      = "LicenseRef-Firmware-iwlwifi-firmware"
+LICENSE:${PN}-iwlwifi-ty        = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-misc      = "LicenseRef-Firmware-iwlwifi-firmware"
 LICENSE:${PN}-iwlwifi-license   = "LicenseRef-Firmware-iwlwifi-firmware"
 
@@ -2219,6 +2221,10 @@ FILES:${PN}-iwlwifi-8000c   = "${firmwaredir}/iwlwifi-8000C-*.ucode* ${firmwared
 FILES:${PN}-iwlwifi-8265   = "${firmwaredir}/iwlwifi-8265-*.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-8265-*.ucode*"
 FILES:${PN}-iwlwifi-9000   = "${firmwaredir}/iwlwifi-9000-*.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-9000-*.ucode*"
 FILES:${PN}-iwlwifi-9260   = "${firmwaredir}/iwlwifi-9260-*.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-9260-*.ucode*"
+FILES:${PN}-iwlwifi-ty     = " \
+    ${firmwaredir}/iwlwifi-ty-*.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-ty-*.ucode* \
+    ${firmwaredir}/iwlwifi-ty-*.pnvm* ${firmwaredir}/intel/iwlwifi/iwlwifi-ty-*.pnvm* \
+"
 FILES:${PN}-iwlwifi-misc   = " \
     ${firmwaredir}/iwlwifi-*.ucode* ${firmwaredir}/intel/iwlwifi/iwlwifi-*.ucode* \
     ${firmwaredir}/iwlwifi-*.pnvm* ${firmwaredir}/intel/iwlwifi/iwlwifi-*.pnvm* \
@@ -2248,6 +2254,7 @@ RDEPENDS:${PN}-iwlwifi-8000c     = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-8265      = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-9000      = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-9260      = "${PN}-iwlwifi-license"
+RDEPENDS:${PN}-iwlwifi-ty        = "${PN}-iwlwifi-license"
 RDEPENDS:${PN}-iwlwifi-misc      = "${PN}-iwlwifi-license"
 
 # -iwlwifi-misc is a "catch all" package that includes all the iwlwifi
-- 
2.55.0


