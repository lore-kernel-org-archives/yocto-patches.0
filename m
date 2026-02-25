Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE3F55437
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 01:32:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36323.1771983177256065791
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Feb 2026 17:32:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=CQ8Epu4+;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=iKd2DmUn;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIKtif2006494
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Feb 2026 01:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Y6k2AMYfaOl3xUzXpXAeslXvT0h0a+YcVp7
	a+YhysQ0=; b=CQ8Epu4+yoFewc6rY/SxZdIFbCxJeMKJKfCeWWdO69ilufY3v/h
	SCioOlBmJWQwldx7xwBkHOD7vj5kS47xeTW1S3HXLWIkHPjKl3sbjw4b9Ans8d3y
	Yks6GaiCyeDgZ9lnflMNGCr+epuKfW3NcBpAwZ7XgQt4coaCVJ70RZQ7/nW6XLXX
	m1XJ1ycNBHCO6cwb4NYwVNOtFOsMz1yF2IW9yZhICV3+ZrGwX3ony3RHBqZBfJsX
	/RB5HdZZw5h/V1roBX3X9Zrr+yfM7y6QXVhmJwwL6Bs04oodVh2dj7o1yHKTGsDl
	7BFokQD2GXa6SnlV43vRqK/+32OTd20DFUg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch456bujd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Feb 2026 01:32:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a784b2234dso178604655ad.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Feb 2026 17:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771983175; x=1772587975; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6k2AMYfaOl3xUzXpXAeslXvT0h0a+YcVp7a+YhysQ0=;
        b=iKd2DmUnD86Dvh1dvUeOBrSNxekVWSzs4srwqIkbblgF2/6Fhr9pmj8tzQLLnVbMoq
         xK6SDzUrslzi3fZ+lGrEI17qH0IchfFCw0vgW4PPW7YhQ9rkWJLjM8PAbCGsz+lC8tm1
         I2tl3FgiSvNKFA3JwYjTVAZFVNdn1i0/n8tYBt9XWP0sfrAqICzrZePW47reup/wXefm
         XsPg1aZ6iwHY/V8bINwLiiu7z05zNfvwZjlqzK1/m0sbAe/xZcwdeNynE62hgXE5sxRH
         wJVLlk61WbL8mPkq09Q57RIveenFftx8P0PMpp9nxbOGLwJvk5J5fmI5skwmet0adH/T
         BNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771983175; x=1772587975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6k2AMYfaOl3xUzXpXAeslXvT0h0a+YcVp7a+YhysQ0=;
        b=pwcJLBui05TRH12E840giDZocsZrgRnlj6wRabVIDyOF9wTjH0QwuBw1fIM9tPrJwI
         n9G/tnn242i4OAizfCwQmvj+/ogaglmiLXbNzrC75m4qMy+5ZzaCzxLXaD4FogbN0Afb
         RMQ2PQ2v8SHNKwIp6P1qYAVp/tJuFvwASJDBONt4kqvqD+VWNkbVmws5GdwCRL3haIjP
         TYGZzWiDl4TUKj6vCy7N/zQA1e6cPjbyaHewzrKGprQdnrCD5+Addcu+5unN3hT5/okm
         XnNG0BUX5/mqjEpjU2RhswF0NF06qeXeEQevhNEk9PlEUkUP3OHIsei1OuQE4qGkWFjr
         l59Q==
X-Gm-Message-State: AOJu0YwWg8FI0j14ys17bBI5m8O8/L/vt/s1l5nqCndJmf5rCqJo2zVe
	XPpoHsRpRHt8W0q0qcj4BWU39LCnRcrpktddMZ3UIXyAegFcNGEeQBSgtCbwh8s86fEaKbh5NPw
	AOMniQoMIqBzfdJnL/FrW8Sf5anCIUNY7brRL1CdycBiybJH+TKaWOTMmeUaVFR38t+ME42lYe8
	hvHrJq1AlrPUPI
X-Gm-Gg: ATEYQzyle/ffc0whvnHs68g8Nv7K/DqwABpOGYTGPnLVnTioEc0h9tcsjJembilX/e/
	18tcwAiZzbKKmbO9yKo817R/1zmBdex66Y79PEfepehHQZK+mYn0/X21rly12t6pq9g4jZyhhaC
	I003mLU6RUz8ohspvpDlWTLpn2WfR2vaQ+Z2gLCAZP8y3WZnlsfiMuXhZk/s+G1CRTV5Rpf8diB
	jqjKV2NLmcn+pFUHN7bKGFJq26AKi9jVDXSRiHkj+SWs+MEJuDO2QTKgYXmfM/YIq0qJvH2nbCU
	vG4/K+H/Uvv7ZrkAVX2Xhb1xT2G3d0HUcfvZcxYuNp4x3AQZhC6CNwTk3l917QoSi+4QZB9LWJM
	XSCRqs/7MLmvC4eoPlojzoNjlXhKpYDGQdIIkAyv6YZRIWkcfsFMY
X-Received: by 2002:a17:902:f64d:b0:2ad:d187:cddf with SMTP id d9443c01a7336-2add187e1d3mr5414965ad.25.1771983175055;
        Tue, 24 Feb 2026 17:32:55 -0800 (PST)
X-Received: by 2002:a17:902:f64d:b0:2ad:d187:cddf with SMTP id d9443c01a7336-2add187e1d3mr5414745ad.25.1771983174494;
        Tue, 24 Feb 2026 17:32:54 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad750275basm147142715ad.65.2026.02.24.17.32.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 17:32:54 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [whinlatter][yocto-autobuilder-helper][PATCH] config.json: remove check-layer test for meta-qcom
Date: Wed, 25 Feb 2026 07:02:49 +0530
Message-ID: <20260225013249.2823595-1-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wkoU-V5YnmPRY12_gXZoSaMZrORRAuFz
X-Proofpoint-ORIG-GUID: wkoU-V5YnmPRY12_gXZoSaMZrORRAuFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDAxMSBTYWx0ZWRfXyqw0NdupQsFK
 eiQm/bl6HBsb4JjMjheiwPQRfT1RrBIFt8CkdhHVAZaEGSxyS8362NykIbI8J6Qk5Exv7BeBMLW
 zf6V+q5jSXR3CmLn2rFtH2Wq7cvPMyTRubemfPc1PdyXlh44RC+YHmdQvWZ3APoIjgb7EWwhDLQ
 wq41nrZ+A23gd8q835/LyujqB5+CfRY1q+Q1MHX5gKnLqFU3G9iruvqB5e0cQgM0cYIgTLmZFNb
 E6ResqKin8J5PRGbO4XOXDJaobiBIfCt9/m+vfLGjinM/ygux93oPNWnXBSMARFM8xorz5RPQBX
 ngyqhKyi4NTPJ3IQTuhlouBQe9+FRecaVMH4NZwVBS/TzO9Z/JuHq8o1NgfF0+VoTlJnhyykKVP
 SIBOvIrGKtakYKsU9XL5K6JNda+6ZCRDUn1MInsB3MKhbdPbulbJclmx/AxV3JCm6ITIqUIULKT
 ScnkF/B7AR928ek9IXA==
X-Authority-Analysis: v=2.4 cv=J8enLQnS c=1 sm=1 tr=0 ts=699e5148 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=XlexzXQUpu4A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Ha7uvrPBrUTVl2omnNsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602250011
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Feb 2026 01:32:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3275

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

meta-qcom does not support whinlatter. Remove the nightly layer check
only for that branch.

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 config.json | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/config.json b/config.json
index 24caba7..edeb7ae 100644
--- a/config.json
+++ b/config.json
@@ -1264,7 +1264,7 @@
             }
         },
         "check-layer-nightly" : {
-            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein", "meta-qcom"],
+            "NEEDREPOS" : ["bitbake", "meta-agl", "meta-arm", "meta-aws", "meta-intel", "meta-ti", "meta-openembedded", "meta-virtualization", "meta-clang", "meta-exein"],
             "step1" : {
                 "shortname" : "Test meta-agl YP Compatibility",
                 "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-agl/meta-agl-core ../meta-agl/meta-netboot --dependency ../meta-openembedded/meta-oe ../meta-openembedded/meta-networking ../meta-openembedded/meta-python --no-auto-dependency"]
@@ -1304,10 +1304,6 @@
                     "HOSTTOOLS:remove = 'clang llvm-strip'"
                 ],
                 "EXTRACMDS" : ["export PATH=$PATH:${SCRIPTSDIR}/exein-path-intercepts; yocto-check-layer-wrapper ../meta-exein --dependency ../meta-openembedded/meta-oe --no-auto-dependency"]
-            },
-            "step10" : {
-                "shortname" : "Test meta-qcom YP Compatibility",
-                "EXTRACMDS" : ["yocto-check-layer-wrapper ../meta-qcom --no-auto-dependency"]
             }
         },
         "metrics" : {
-- 
2.53.0


