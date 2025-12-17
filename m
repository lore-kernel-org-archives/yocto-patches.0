Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBFAD64072
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 04:10:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6432.1765944594183965730
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 16 Dec 2025 20:09:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=f3JOkn95;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Y/QOqM7L;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH3FLgc1323877
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 04:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mS2K8/KObcFbB2OlyP4TjJWjWxTVAWuDx2n
	+KWYR2es=; b=f3JOkn95YuaCXrydL2zSIfzksDPaNblfoSlsL8jFxBRdn92qkK0
	WA+54/Sf69zg4TT39mKI3ZqREnfQDjDMfdzteh3iG6Lix7UDp5tsi+WqNOYGMUr/
	g1TGxXeONtVK/DkPvCJB16Z0Iz7r7TvcvEHPNotoABMWoJRWF7Mc7KvlfwQRM3Wn
	n/BQFJytPq4F2bzulph+C70jkb+NrAglrquKtT5IOFEgzPUdYnxtNcntciY84pma
	Rj9VIJpWVBI+Fn3AdguqTaUz6LQpJCoJaZHrudcTnc2tJQjRTx7xj4GWFbCZv34A
	R05c1uTJFJUoT6cBQeB5OFTzrUI67iiYwnw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3fh18unc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 04:09:53 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b89ee2c1a4so9348995b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 16 Dec 2025 20:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765944593; x=1766549393; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mS2K8/KObcFbB2OlyP4TjJWjWxTVAWuDx2n+KWYR2es=;
        b=Y/QOqM7LkugY+nepYAJj2NVy4skmDFSbfeWi8gn9GfyvIKfJFNWdMj8nOIyu28SKZp
         xaRDYjEQnGpSb/KKwEj2j5g5KCub9C5u9SrJLGcHx08qWbnyKoTM7iT4cGkoLB/skF4j
         0kVJJcPZvP4EcX73vKCmvom24sIZ982CaTAFbV7JK1YixZbj4225IowWSaggXwNrML5g
         kWVD2WXqzahyczTDXkYY4SrC4FGHgdfrf5uGqcDEXPiri9w4/skN3z6lFyJmJN1NR71R
         SAQh87hAVmWvN01O30lNEb57cNKTxw0c11CyH2oB1Tz3nQTU4xIOKEnnFtxdhUdOwQ72
         S2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765944593; x=1766549393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mS2K8/KObcFbB2OlyP4TjJWjWxTVAWuDx2n+KWYR2es=;
        b=uaRcd5lE8B325x9RTzr5TdZkCrs6sYe6Lstg3ngEFh7ITJPpalzunEH7Melc0YObxP
         ND8T1kSSzYC6HyJ6oaSlJo/Bmwm7OICuav7dp3o8mK+haH3vNjs9KXjeid0CejnOiMcJ
         elAskRDcb8sbrNH7/nbrnVeAWzLzjqXXaOqW7GaOUW0YPwoG1s/x4ugkN6vVTYKQmMHC
         Si3vNqBdyMrWCnMsuk1N2jgbHiABrov7jFzp1xpcLyu1kBtAJrUVlNEYVgk8LJnyM1Sa
         yS5x412G759QrGL1zw+x1k3yoHgWywxhAZQINVsaPG+B/7diZExoaisRL7IQTmwSrLSB
         hqSw==
X-Gm-Message-State: AOJu0YwojhQjumPUz0863lK8UuhdsAqNcL0MCBwVNjSv0hVc2QOdi+b0
	L9D8HJaYE62CU0xoyPhqtDrxehGiHK8mqmurGgvMW2l/HEAVtDgab80G68GA8vnhcgLy9Zz9pen
	UCA7BSHcSuZbHe98fHXhqownyt5GE4sDKs5xrtXHeJYeTszHsUVxTSZIu5k+28DaybXZaYuGe+A
	v60iwYaYebdY9H
X-Gm-Gg: AY/fxX6QmCbHKBBG+ghxiu7hOGiPDXRlBEfsvAux8dq0WIQZ2TIS6n4g5ydMgELUNUQ
	vMMRQx0mxi8DcXz9dYPpSkEsygP2qjZkV/5zV9NAyQn9G8xzVeDqjDR4BkTG3PhFpnmCeqMLOCH
	5DSGlVLB7s/54uCOuOWcMFsKkO/k71nuEOMYhSlOvlNhqQx7UdCjK1TLKP1T+cPVAw9430Z42Vx
	X8nPWGy4n8j7Z/NJFC201J/Gf+nf0+TTYZtIFWAG3gHbRVBH4w+HV4QLEGBUxLK57gZd6wjquGa
	3Mz7po8++9aM46jL1vlzWWxEdxlKGlZkycvF9qBO1b2mEdUSp4g97b47/PcX5rZ6KHa4YWf3zsw
	HOwikAHR+NCSaQzcQVvYsElczwAea00p4XMkr8nqJ
X-Received: by 2002:a05:6a00:3311:b0:7f0:8031:70b8 with SMTP id d2e1a72fcca58-7f669a8e789mr15128448b3a.51.1765944592778;
        Tue, 16 Dec 2025 20:09:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQr1/rbLFjYXMfCHBqWgKPVr2BoJdhvzL75vYc1XooavA1wK0Bz+jUCpX6ylwCLg+9OzS3dw==
X-Received: by 2002:a05:6a00:3311:b0:7f0:8031:70b8 with SMTP id d2e1a72fcca58-7f669a8e789mr15128424b3a.51.1765944592106;
        Tue, 16 Dec 2025 20:09:52 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fd230634a9sm400283b3a.41.2025.12.16.20.09.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 20:09:51 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder2][PATCH] config.py: include meta-qcom in a-full
Date: Wed, 17 Dec 2025 09:39:43 +0530
Message-ID: <20251217040943.3332713-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YQBxke1YC2fAeVvunZ1g6u_Yykl9VHG4
X-Authority-Analysis: v=2.4 cv=CYoFJbrl c=1 sm=1 tr=0 ts=69422d11 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=EHajDWp7DbHxipkwTlsA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDAzMCBTYWx0ZWRfX4Q2Hw9UK+a3s
 HtXNvhlvO/glmPs7VNPkx2Ds9EjK2Y4wt+1Aq8luPTyemlU/3bjWPu1ZN6BM+35oKcOYyWRNYqk
 ZYcDQNdUJiFQtEeHzGO+LwO+HQNTO5dGBNmNQYK8S1wlsYMXXLaQaaOF8bgYiI4Lhw09EEXrlBq
 NPHRaHm41apE4HjfcQuWpHsUuKnMYd0RTkZhT4MRAjMPgYLHZRte/KdTXdLzcdDVxbxRx7GfUbH
 YeOQ5jRvsOTq8+G8h++z6TJA2aWEuxOeB3KA4mdtu4Snnt7dtM+ZpbrsSbIKU9PzOcclaqbNxkt
 nFn5KtJy9bOlGMrW3yjxSPeA1y5n3YKm/ilAigJ+hjtwdctBk82Q7CwWH5i3WJ9htbT6kklNhNu
 urBCK82fgVG9c9uSq4QooQO3ljzuxw==
X-Proofpoint-ORIG-GUID: YQBxke1YC2fAeVvunZ1g6u_Yykl9VHG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1031 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170030
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Dec 2025 04:10:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2807

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Now that we've tested meta-qcom build individually, allow it to be
triggered when using a-full as well.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 config.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/config.py b/config.py
index 50710bc..cdefeae 100644
--- a/config.py
+++ b/config.py
@@ -8,7 +8,7 @@ baserepos = ["bitbake", "oecore", "meta-yocto", "yocto-docs", "poky"]
 # Repositories used by each builder
 buildertorepos = {
     "a-quick": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2"],
-    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang"],
+    "a-full": baserepos + ["meta-intel", "meta-mingw", "meta-gplv2", "meta-arm", "meta-aws", "meta-agl", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-qcom"],
     "non-gpl3": baserepos + ["meta-gplv2"],
     "meta-mingw": baserepos + ["meta-mingw"],
     "meta-oe": baserepos + ["meta-openembedded"],
@@ -101,7 +101,8 @@ trigger_builders_wait_full = trigger_builders_wait_shared + [
     "qemux86-world-alt",
     "oe-selftest-debian", "oe-selftest-fedora",
     "qemux86-64-ptest", "qemux86-64-ltp", "qemuarm64-ptest", "qemuarm64-ltp",
-    "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", "qemuarmv5",
+    "meta-intel", "meta-arm", "meta-aws", "meta-agl-core", "meta-virt", "meta-qcom",
+    "qemuarmv5",
     "qemuarm-tc", "qemuarm64-tc", "qemux86-tc", "qemux86-64-tc"
 ]
 
-- 
2.52.0


