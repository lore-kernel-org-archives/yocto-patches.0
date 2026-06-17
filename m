Return-Path: <dmitry.baryshkov@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29809CD98F2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 19:21:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3069.1781724087377005496
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jun 2026 12:21:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=l3EX1bs7;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=G2C9XvK6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HIsuoP3591698
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZgzZFJlTS41APXptvyv6EWsqyhl9CUFJCj8mzXu3m08=; b=l3EX1bs7MSROrMA/
	YwZKVO4gbJvVW5swSZuLafTXFOGO6590AXFW+Du6eptt0wCclIUGriztNP5+ocxV
	hZ1nNRSIOJ8MtwmkMCJkxTSTYg7eYiWwthyTbOYTfuMG05tzK7ewkUkhBH1lvepl
	24PlCkZSAFX7LUJL5+bg545fIHwCqnzhdvadh1lATnBWIU5LQiMPJz038UJaogHE
	AfJEhhj/nQJhI+sz8GCnWfSFWosQ6nDBpXHh9iOf+7+hJ8prEM9+len17OMKgorT
	2HCamwnKcqtFlsbs59p7OdrkMrmIhWqPg5yiMo6BTus8T7K+u7BnImePZSLiIsc4
	U4aeaA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev19a0374-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:26 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9646997241cso32201241.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781724085; x=1782328885; darn=lists.yoctoproject.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgzZFJlTS41APXptvyv6EWsqyhl9CUFJCj8mzXu3m08=;
        b=G2C9XvK6zLtHmSfQkLByqQS+r5JpzAsfJ/gtNb3b/naLKFbkmxaidBRYbIOyJTad4L
         vQ9LSz9X7Dt9DhjvNkkzO58C0BaajeqG60550lX5cnQTp5JEetphcMD+8jlWwNsF7U5C
         P1q5U5oz0zuLn/zvVThDYvonJYD6O7EQ3M1XFsfQH12Th3vl+kkh+ShFEuVSrwdVen36
         0P8jzys96xDjKBhY/wyChjp2FLDsEXEScWjmEFFDJG1R2CQHpc2D0MY1ueeErjIK+nUy
         A5giYo0TXmQt5VcN8xFMtNY7KC7Ibe0zVVjScDENp4jGz1wXZP61SSfl5ctn5Eumx9h9
         2rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724085; x=1782328885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZgzZFJlTS41APXptvyv6EWsqyhl9CUFJCj8mzXu3m08=;
        b=dc1i+99fVsTX0Y/rFJosphYYiUt/oeEsphqcLZ8mSIUYA5f1QwYUg69GEZiLOEqimD
         ZmCcCsq90EUgccH+kMsvJ4Q06ZST7w+1Bv/Fpe4FcwgUXTWQdSRjnVGPXUlk1/t1Z7LH
         M9xES4LRhBa4rOkRcwv+w4CYrwc9kV3fQftDnlDuIC44fZNttuXnT6e4tBTCRzg8+unm
         5/LDAFzw6JXvs+tq3q4rs1414h8C52Q3UZEXrvtSB2I8G3jsGwVjufqrqHKmRf/huqRC
         LS9BiJB9gKCPs4JK2J2XLn4yV0UN3ppFBy1m+oXuRrXCewJ0QRLH1wu+y6/iogncGK/q
         PRwA==
X-Gm-Message-State: AOJu0YyD3B0Ep8zFUOZvZkSIbrvleqTSatf14hx/r2LO6KcPuOgLSIq+
	XqRUDdfZ2nBigb5oz9QjEdd6HFNU5cpfvz0C34RvZM1x57rQ1kq0I12/iIjywGNmS0S7xOlKDOP
	SmV4PnAbX0TL3xab1gqWtIH4w20+idNzAi7FCFQDE5Gja5IOjK648vm+InSswQZw9QG0dk1RkQL
	E2DK5WMDW/IA==
X-Gm-Gg: AfdE7cmoKEdyijMFlORVPFt5Ds9d4v6Ws+AxA/tYnvW7UI7Hr74lKqW6JGQ4sZkuFlx
	xKD9Khd9CTV4wHj6daQjhILq7FPXnOaBYh5Q7/XTae/JKKT6KOhwTswL6GwbI/nHL4fwP/rFaCr
	whjUFb+3VRCHQcrisectCvZDLg1N4UcJKS3JztUX+OPuRF7iFIomlKwpTlOsJ8F0U/mbDJJmoe5
	8Zto7vPAs+uWoUgchJJGKkOFVhrbrM05WiS46KjPu3gg/LOhNa69mN0iiIapK7ssPPvPpmz0oyv
	C1qMn47eHrJBMa6ErrugJlm2armS9ddu8+uYDo74QQhKd86smi0hnfFJvtwt0sIGFcu+nOK5t08
	ifUgmwMSqAqfbSBpx5IxRpHwFk3ZkSzNFSPD92dfJEwJ6yKQBJxAbcFNL2LIQ5yNr3oVdj/9i1q
	UhEG+J1Z89F34TJF6zPwRsCPr9
X-Received: by 2002:a05:6102:4bcd:b0:722:a46b:2f2c with SMTP id ada2fe7eead31-7246c9abeaemr3285622137.15.1781724085421;
        Wed, 17 Jun 2026 12:21:25 -0700 (PDT)
X-Received: by 2002:a05:6102:4bcd:b0:722:a46b:2f2c with SMTP id ada2fe7eead31-7246c9abeaemr3285594137.15.1781724084885;
        Wed, 17 Jun 2026 12:21:24 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f2fsm4774356e87.11.2026.06.17.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:21:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 22:21:16 +0300
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 1/3] layer.conf:
 use the same priority as OE-Core
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-fix-check-layers-v1-1-d1b60c899440@oss.qualcomm.com>
References: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
In-Reply-To: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3n67RDqypI7z0DYRLGhWC3oe/2bm5iDUHBYBG+HE7rQ=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5bR5w3f10eqc78w9BJ6bMmQd+iieOb1xe5nmX1lOGqP7
 7y1RHB2J6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmEmXL/t+z73j5MasZy4Te
 TNG7It9oLWWw2NUuKJc/5p7T6opVPSdfqe7dzOXw5U3C7tlpXD84yrn3iO0IZDe4Ub2pu9/g+OO
 y3D9VkdKbdlZVlnKmfLJz+SjdrhX0NznHZ867iUlvuVhNFHsfvujakrYiV1VCa2rmPKUfDY94O0
 +brfrjW8C73TfBrJtN7apZ8I8ZHltv+tm43PzXFjzvyGRPqbIZIScehe09KKu+6k7D84CfH40ZV
 VSPSa1znf0s2jvA/NmbOicO/9qEbNZe/zfrbilMf2no7FasYHz4DvNhv+e1F3/FRJTG1M536Nr+
 0u/aYgERJg6hw6npujn6557Lu+n51AbZsqepBro/+3gKAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YbmNIQRf c=1 sm=1 tr=0 ts=6a32f3b6 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=Ii1caJqkCqkA:10
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=AN_xG2Jx4Jhh9WknBpwA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4NyBTYWx0ZWRfX6Dnssmh2X0nH
 ERSEXb+oFWEd/evJTM6xbsCL8JqjyZ6z4NcSEIEni7g3vUb6f5JEgBVI9iQdlyaO/IOPhgD8YVb
 cZfGnUwiyXNje/yCLv6NFaVvuNJ5NvU=
X-Proofpoint-GUID: 6N7jckvNTlV8vNyHi2TESrdMPKWd5-wg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4NyBTYWx0ZWRfX9JBeJbKLXtjS
 rHFQ6jDz5NnluWB1X1jBvmu3ldQqUgLynqLKW66FjG7b+g56NqI5lSIVGoUvXxjRytY44U/MGPd
 ZhNtlMvEwO2VK250AGmzApwH3SKoOuv8PVEme0fPwB9maZuIOHoWF5h9NjNVwtHYoAC6nrrk6vV
 nd33Vrq+JbqfnUvLyhxiYS0lzu6o57kdMReX/3Kzq7hC/F5K2nTsi1SX44jc/FdY7o4THmbPaCt
 85CKlMsiRDnklKxFMqlUDzLhiojjpwTPhGiILAUW2c09LqWdW4SNHVDXzbYHB2mIlK21LGceF2W
 i9kdy8+0FsGtvd7HQXLWAj1PHfCDWTDmBrNNkTS5fyGlL896mmWFc566O6oBS5oTwlsAN8H9qHw
 S4usNryhnrqMsFkOhgDWaJuKzRObJXJkqfX8SPk874OL+LtbaQzzjwOei5z/cqP5dsFzr9mVMeG
 /B052ILdvWHYzPorWpg==
X-Proofpoint-ORIG-GUID: 6N7jckvNTlV8vNyHi2TESrdMPKWd5-wg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170187
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4234

In order to make this layer Yocto Project Compatible, the layer should
not provide new versions of packages by default. This can be achieved
by setting DEFAULT_PREFERENCE to "-1". But for that to work, the layer
should have the same priority as the one normally providing those
recipes. Drop BBFILE_PRIORITY to "5", the same one as used by OE Core.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 conf/layer.conf | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index a9d664e55df0..5e1f7f223cc7 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -6,7 +6,8 @@ BBFILES += "${LAYERDIR}/recipes-*/*/*.bb ${LAYERDIR}/recipes-*/*/*.bbappend"
 
 BBFILE_COLLECTIONS += "lts-linux-firmware-mixin"
 BBFILE_PATTERN_lts-linux-firmware-mixin = "^${LAYERDIR}/"
-BBFILE_PRIORITY_lts-linux-firmware-mixin = "6"
+# Use the same priority as OE-Core so that DEFAULT_PREFERENCE works
+BBFILE_PRIORITY_lts-linux-firmware-mixin = "5"
 
 LAYERSERIES_COMPAT_lts-linux-firmware-mixin = "wrynose"
 

-- 
2.47.3


