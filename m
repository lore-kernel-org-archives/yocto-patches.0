Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133D5EB4914
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 12:00:04 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43800.1770897595883108532
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 12 Feb 2026 03:59:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=QPpPqEXk;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=dD4Ymk3+;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CBh2uu483214
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 11:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s3czNVDt7gX
	WHCnJwHi5aokDb/C68aUoCsjmxG3kGZE=; b=QPpPqEXkyNqvjGmMbtaFCfp93Jt
	jzv1yr9U5z9hrQBnI2e7cWLNBTtOgg1ImvI7DMZ3bUmYfS0otQASFo1DHEIS31l4
	t7cm5ZbeVAQTiNp6dj5gWamXLLhsvCnR1TqqLBtM5nZ8IwglPYNgWm5GYZqSCbha
	gxi6BQDQb/9eD2smbweuFvZ00bf8w1risI7UtrRLK5beyk2w0vhY1FW+RLh9CWjb
	8byxBcrbp8Q18FnVMxyBRy05i8I+ElyUkqKZVjc3v/JhSYP3EHBGYu2srXLOqXfV
	wEWQqyuSxDXhXUMEvWUgVa48tOt8PvERP5ZdBOW8PjE9b48VIkoD6jKlIBA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c8y9btu6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 11:59:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a75ed2f89dso70142605ad.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770897593; x=1771502393; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3czNVDt7gXWHCnJwHi5aokDb/C68aUoCsjmxG3kGZE=;
        b=dD4Ymk3+PBhoPpkhdFWwodeBNod6tjqFAHUVOw+QouJwlZXG9q9Yryp/xGD6k3GdLI
         nb9DCjU8LRS0ftgQ7rheuU6Q+bwR439ZpN3OcqIZuhsDbWxEkammOKhNa8Qa7aA6tcv7
         mfFNxBTsSl56rfKJ4R5c+tHYYCHZogp9bzuU0RKkxmtVDpOoWOD1SdQkQBA/S4pZDlfI
         Zgu51BPfyDN42NbnYj/Ic8WXLsGqjNionPw3CTCDBf8FCMgMxjdg7aC1R0sOCV69vCeo
         GsBPa1vzoGmGFhl6qfsOmTl76VMKiLRSvbwkb6u7SUJTbAnugppnvQeGQTR2Xogn4qfI
         o/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770897593; x=1771502393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s3czNVDt7gXWHCnJwHi5aokDb/C68aUoCsjmxG3kGZE=;
        b=RYKIal8lDieLb55hp+UPv6YZWaxGTWJWC+pNdtYVdpRBHiL9oahSKQDp00p5TULZa/
         HomNjUKzp6ueUR4i4t9vMvAzX5FnCgai6PdpWVJhohq1uBjhOAjv7slis+Zyn7GS0csq
         RYp8B+blKebR+L+MxBDOBbeR4q+Q0c941p8yeLt4JtqeAMD0bFb2n1JKOCsoqf9WzQsh
         FVC0sAtwthsikXDY4OrXEOt3mpgwALY8S81kYLM9D3osoK1YAHA8HDega/BYQwLkP1bU
         z11m+LjeLo4YHBuTGx2mQxCuxR+Z6hBr79oQrfU4z4ES4SrEvKJC/7gOWxPrhlDmzqaL
         XnfQ==
X-Gm-Message-State: AOJu0YxhQrh0IfArDk8z4nYR2V9AyGPGwV2qpFiEmu4gk4MiQ/MoU/wA
	lfBPkCNsIz1mO1KExw/d3lwQSEnWqdx2z18Li+85wLRSqIRVNBF/PiqbUp6Cqq+2VlRUyTHZ6Qk
	T0Kqx+mt11PtoHqN+Xnztv25starqB6FrMpmcK8RTiqqRK0x3T6H3InFMGr5T0pxkzJbquGe12F
	5B8x5OW1Lp2wDG
X-Gm-Gg: AZuq6aKYWN1DFDexqexGVtEMqJm/PN6ksKPhBGGe2Gv5j9sA2KqECh8wcFDJ92/IH0E
	RHZQBL3jqbbrb7OCAd829nmbANXh7sa8QAPUkfj1aSxQx9tmhzbhAEZ0UwCH+2M2ozuNWLN41Fm
	RZzyLJKr/hMSbrL03PPvtuwfgBj5S7fID2gY6CngsJ71VQoaj9xsEzvrc9U4TtjUuiDX0WIVFxl
	nia0cV3fIS/UWnRUN+Kcy4gvvdga+tDsLwHc/4u/cKu+cKzPxVP/sR3mcjNeN+8vZoNSD/+0uLn
	zXx7KYqoDaG73FvBEIv7NzYlXoV4e12ht5phbiSpJcjucDD5Olx85xtDG83nj6QlCf34FNoP6a3
	w7wdjma1qw7G2U+TecRB77UNys9VyDs7i9yzlbiyTk1B/HAhZTmdE
X-Received: by 2002:a05:6a21:689:b0:38d:ee68:2c60 with SMTP id adf61e73a8af0-394488200a6mr2383083637.52.1770897593531;
        Thu, 12 Feb 2026 03:59:53 -0800 (PST)
X-Received: by 2002:a05:6a21:689:b0:38d:ee68:2c60 with SMTP id adf61e73a8af0-394488200a6mr2383067637.52.1770897593052;
        Thu, 12 Feb 2026 03:59:53 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e9dff38sm4963843a91.7.2026.02.12.03.59.51
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 03:59:52 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH 2/2] config.json: add qcom-armv8a machine for meta-qcom
Date: Thu, 12 Feb 2026 17:29:19 +0530
Message-ID: <20260212115919.3172900-2-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212115919.3172900-1-anuj.mittal@oss.qualcomm.com>
References: <20260212115919.3172900-1-anuj.mittal@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BbPVE7t2 c=1 sm=1 tr=0 ts=698dc0ba cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=Ymj8PgAyxlDX0LMrlmIA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 7QwRwHWjdzdnQMvYaYAtmsKF4sqy3lEk
X-Proofpoint-ORIG-GUID: 7QwRwHWjdzdnQMvYaYAtmsKF4sqy3lEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDA4OSBTYWx0ZWRfX5osLG7UvqAOs
 +84QDmglSOV4bazw5qbbWcslab4UKFz6PiGfGnEMo7jcdqz9aMFH806/48TNkxNgWwa4TYFtT6+
 DIlmvG9ksTS74kSn/yYy7qCZc10x/F2K38EQjyB9kMR2OdZjU+y11OSLhXWyUZSgGIlYHB6T30k
 HoQCAODEQ1J7wmKL1HGG92yAL4h4UvOXDvudNz0Wbu4ARs3bu/W6vQb0JLGcbPoFxd6781e7OlL
 MlUqeadgCMjcC9E1OcHxEsrOkWSQFDYLjmQBtlKCwivPa/I+m4kAppZQThOL5CeM6+7pJz26tok
 B0VjTsABVMLkhvQFBSIxT6GvMkj+q1u1AEuPSPz0uI+MEwF5Xrf4iVRvLgkRxJD0w/IL4GyCGf9
 39BLlBPsDZm33sd663hZTnB71TDD41HAwD9wpcvmU2dhmY7jOumozaTPkXrzNzf7epNP5QYxWVU
 1fQqTKgxGzw1ZTyNQ/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1031 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120089
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 12 Feb 2026 12:00:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3228

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 config.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/config.json b/config.json
index 8c94291..c2fd1c1 100644
--- a/config.json
+++ b/config.json
@@ -668,6 +668,12 @@
                 "DISTRO": "poky-altcfg",
                 "MACHINE": "rb3gen2-core-kit",
                 "BBTARGETS": "core-image-base core-image-weston"
+            },
+            "step2": {
+                "shortname": "Build for qcom-armv8a",
+                "DISTRO": "poky-altcfg",
+                "MACHINE": "qcom-armv8a",
+                "BBTARGETS": "core-image-base"
             }
         },
         "meta-agl-core" : {
-- 
2.52.0


