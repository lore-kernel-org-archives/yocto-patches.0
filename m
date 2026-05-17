Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6FCCD4F25
	for <webhook@archiver.kernel.org>; Sun, 17 May 2026 08:34:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20319.1779006881366443209
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 17 May 2026 01:34:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=PY/JALcZ;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=aMF8OiEN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H4vFO21230623
	for <yocto-patches@lists.yoctoproject.org>; Sun, 17 May 2026 08:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QvhV8ogHe1nD8nNDgSZ5gApeKWdYG0x6WcD
	GSgTEryM=; b=PY/JALcZER7uaWFiKeHrtBCjN5ZQyLPuCg5C55Zr28Txqd0/fln
	mkXiZia0ia5VQajXpxXWS0C2RJAFnT1QZznEvlNyqhIO7bGZuR4EfKdcZ1retEmz
	XuuhPTW4O3TmNLm2SPpUZpCjmwBVInhyVwpZ9JFROVgGU3daUE4r5x5sCv0n71GV
	S0dayAcMLT50N3EHBI4WjnGrE9FQwTbbpMO/2pIpxNhnOCRBEJSid1ONpM2/O4t+
	lMM7I8jyCGAb8iZj+vjEQ+8LAygNivHeDsB3YiyAAmRxTli/i+Z25sdzZZYebY7v
	AYqP543qcEIh/2YtSTy28FVB38OwSTvPG3g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gwmahap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 17 May 2026 08:34:40 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-369166fe5e3so1009924a91.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 17 May 2026 01:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779006879; x=1779611679; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvhV8ogHe1nD8nNDgSZ5gApeKWdYG0x6WcDGSgTEryM=;
        b=aMF8OiENwgnhRkxtODEbuJ52Vv3dec1+G7vqh/lGzeys+yXTE9s1MYfmIECNSeY5HK
         VYNIqNDdCAbNLAgkn8onxfbK+M1HeUFUB+rSLMYbaoNxisKsNaugPlvnEbBMtWVwR15F
         Dmqv3jAsJjnSN2b/++1160A36n4rnSqvJjx5VbATHOZmkRr9nnGs3HZUiwsSMO4Jsa4O
         89ybprH+7OJAWIrxkdEQtmkHUJG8C6+cKc2ymfos1HnmnRHKNZKevYx/DXz+aJgnXzUu
         LOA6A5vfnVxG28tHXKcNovUHfQx/hhCdozrbqOYonAbHTSLNBYIAy0bDjkASV5tlC3Ci
         G+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779006879; x=1779611679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvhV8ogHe1nD8nNDgSZ5gApeKWdYG0x6WcDGSgTEryM=;
        b=B9m/3wLD9iNk68CpUecGxaN5yeCzpY+PWIdVAsLPGXs9vQlsVEWIjDk19i1IyD8M+P
         XSUFwJMLA1cSuBTA2FiTCdvwVw0aPLIqYVSmR+j4jnD5nV9FfwJA+llhq5ya4Nq70Zqy
         5PO09sZsrxi2LZkUDiILb58wuhFy81HESWRU9W/3MQ/drgdCM/pK4Yc8XtFZwvjL19+/
         /gTwNByTe8kgPMzH7m1DuhFlshLw9LpbgqEJIub/f5BbBH0qEsQATIUm787ga8C5pGeY
         8K+sNIJa+nHfZvwYI82xgSML5UBHLwRgaY5zudGjAvMZTTuFWbKsBWb7f01APKZfsAQG
         CTlg==
X-Gm-Message-State: AOJu0YxWaweAE60FC+rf0UR3n97KJyBGZqFnwd2Q0BiGxViSVsiCOaJD
	oPNbdx71JfYLXt/CTjj80ooy3EZOp2DoEnA9JUgsShriELgsDLS68rxj3wJRPTNFGFaYDj2JEAQ
	yqo5mDXl3j/KmXexnKx2A8LAgqCye1elf5xRLrIP7VfDIao4DZPsuvK7CD7WeuJ4JogHa3iIzs2
	SknoRoCVtDlcNmR3g=
X-Gm-Gg: Acq92OHzFTY9vhCJj1HOyspDfemvFVk06Ed90GqmAOe78qJ0fel71z03+ZqA9RXXbvs
	VtPyRHYG3zEnt13bunIsN5eo/4wilYT8iZsEV5qJFnZXlAVkeEB5s+yv2lnYHPCCiY1sdO0E4HV
	JTSwS3DyEAGF3jz/stCDVTh2DIJO51gPA6utH490tSdLJlLSdw39wDzU9waBWDP28pqPFIM88rY
	stGT22GEILu6EpNEPHtnRb1UInEjUqgH8lPfQG1v6SbVXgJ3Z4ySX2UV4hUeDvAxYM7cwibOOSg
	TCn1FbXCQghyJGnJuzFiSWyMe050QUV2i+AC4yeHNSTsEssjm+fiOArHOK4Eir2TfkwBhfNHkjJ
	cp6Nbs+2fbheUcA8J7LgRnA3OLsTMNGM49MY0LsbOGwCn+2Qq5KDP
X-Received: by 2002:a17:902:868e:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2bd7e88f4b6mr76638785ad.26.1779006879120;
        Sun, 17 May 2026 01:34:39 -0700 (PDT)
X-Received: by 2002:a17:902:868e:b0:2bd:606d:b342 with SMTP id d9443c01a7336-2bd7e88f4b6mr76638655ad.26.1779006878622;
        Sun, 17 May 2026 01:34:38 -0700 (PDT)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb35sm111276595ad.12.2026.05.17.01.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 01:34:38 -0700 (PDT)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: raj.khem@gmail.com
Subject: [yocto-autobuilder-helper][PATCH] config.json: build meta-oe for qemuarm64
Date: Sun, 17 May 2026 14:03:56 +0530
Message-ID: <20260517083357.3390355-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4XuuRq7dW1_-BjwW9XslzKjhorMba5bX
X-Proofpoint-GUID: 4XuuRq7dW1_-BjwW9XslzKjhorMba5bX
X-Authority-Analysis: v=2.4 cv=W/AIkxWk c=1 sm=1 tr=0 ts=6a097da0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=OzT6_xn_Z4sDkZu9aZAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDA4OSBTYWx0ZWRfX81h75ETo3gEL
 qiGmjl8etgURijDYBpE70KGmysahatObmL/o2TJ303xf4dUWfUsN1f5D5MTqQ3INaOj2Lxmeblb
 KaV5bntYO73/cxwtVM0kJmNxA3TRBaHQWBX9wld9NfuvBFqJsS3bx5mHMSOd+eO89NF9L3Zvuqt
 wCN9gEM6zP17GK+bsEGF0CJpQQ7/XkorFiOK2dOL9TigINtwsc4AipYpfoon59dEzZiVYRkwAg2
 KufHYmHJHs5oiS+srUKf8KUUS5QPv6JvcLbCuPsd72l1TMPZAc1X/Arw8A9q/r7m473Nh4AbiYh
 p2+gAEZL8Stfu9rckI6F9LpcYejWoZ47IB9vB3L9t4rx4frCyH7P5JHtTnC9NmwddbTYqNJ0lqQ
 JXPxRbNkPiYacS0qeO44dnIu3BVTSYP9DeAv6awIdTXKr+16MG+aV3xxpOtD2vwU+vVWQJZgMgi
 oo7DnSqIv9YYlP0ZMkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1031
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170089
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 17 May 2026 08:34:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3996

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

Extend meta-oe builds for qemuarm64 as well to have better coverage.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 config.json | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/config.json b/config.json
index f0e220e..30dc1c2 100644
--- a/config.json
+++ b/config.json
@@ -1467,6 +1467,16 @@
                     "${BUILDDIR}/../meta-openembedded/meta-filesystems"
                 ],
                 "BBTARGETS" : "world -k"
+            },
+            "step3" : {
+                "ADDLAYER" : [
+                    "${BUILDDIR}/../meta-openembedded/meta-oe",
+                    "${BUILDDIR}/../meta-openembedded/meta-python",
+                    "${BUILDDIR}/../meta-openembedded/meta-networking",
+                    "${BUILDDIR}/../meta-openembedded/meta-filesystems"
+                ],
+                "MACHINE" : "qemuarm64",
+                "BBTARGETS" : "world -k"
             }
         },
         "meta-virt" : {
-- 
2.53.0


