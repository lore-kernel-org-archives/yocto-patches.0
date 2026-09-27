Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFBCC9832F
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 18:02:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40951.1790532139758596071
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 27 Sep 2026 11:02:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=gBkK3vcc;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=O1WUbNrh;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RHjvDs879191
	for <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 18:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fptVmZDqff9ipK+gnOuXSfjHg8dykLaehl5
	9n8UciDw=; b=gBkK3vcc3GLIF1BzUyHODX2gfMq8q+tTh0+oZRzztMc10M7fvK+
	BaHmhoNbFOFlb3GXqXwEBBuL0SxGttcWz66Lcjz1y0V6XjZBA6MSjzwrBJbAOkA9
	Vr66s/ZDJRmJ7Xggylxec9TmXmWkxKR6AN2tZa7XP61IPI+zrnS/Z8kTm86JUBs2
	lVFDyk3ciwIJF/sJGPtZBwTkAfeqn6JQPvajY+sVuVRJfwDpk9OBQb1Yjsg3JjgA
	yD9XfSBNF4uBrDxDsEqHhk0aAvwqLIYLLnEgeusLsfC6nEfs+eQrSF4WB9DZe0x5
	gvzM0bBG+ZXS3atr+1zoUuoLUBvu+zi45iQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwbfgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 18:02:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8710450f731so1517849b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790532137; x=1791136937; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fptVmZDqff9ipK+gnOuXSfjHg8dykLaehl59n8UciDw=;
        b=O1WUbNrh3Tqv03VQEdWOUha2G9yfn7gx+0X2TZiaNAGfBMr6heEkSHR65iSLECHjcO
         rZRRXyo4/NElua5V4dYyfAvQ8L6dUa8mrtP308j7DUHepm6L8xQvGM2H3Y7KzufZhcMP
         ReLeZZz6p7VUjI/rEFeTZcp9VqY43JRPgDLh83AlY8/pWLvj0qrCR0KBGoJbxE8Y0HT7
         PliGvwcSVNadlmtVw+ppN50IcU1CQP6Z8jJQEXE5t2JvCvlJE9s3+ojkMMU6okRjNHTj
         ugRtLvBf8gGlaGBKqomZ3DvQdJ4JEIiCyLHDnsDpVAvEz6QGjLEn60ETludfR7oVojC/
         WgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790532137; x=1791136937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fptVmZDqff9ipK+gnOuXSfjHg8dykLaehl59n8UciDw=;
        b=lcAHQrw/pLWFj4iUTLHJc8lU7TOLO/k5KK6lnW7VgYWcWYIUvuBFMHwK1w3602i1Pp
         GtcmkWBqLIiAuxhl+7DbawueDf5N/I1qz40LMLA9jRqu3D5kp0pgGsNtk2h1emZR8AoA
         Ba3XcU8hPDeAe5uqxPTWdXTJeW6I4kbtuWan7+bPYRtYoIFmLrL/bnsgzGDJ01xXfHDe
         CaOsVpAS+wG1EA8oSTzTGZ16Jtp+ErxGCA2sufL0UfZIdaq/wtfIdbnCUsj7HLVdCSSm
         unJS+1EmNRkv868mdS9u+8aPUwIgkKm5LsYXOsCc3kY+pmmfPhc9c2rr4erIFIp5FWVB
         O7Uw==
X-Gm-Message-State: AFuF++krL44KcnlYLl0hcu0sZotxK36d5X5rz9X8yizU6Xv8MNBEi2/r
	vb9rwPVjbK+hkTI9MPRjRhTKG6kQADsagBSibHbbKQzlwfsKmi/BDqIPNbXrkomUbMrhZ/1oLYK
	dYHUtWjNxTNw1Q0Avklfh6VfhyINEGs62KRXsQgdCOrrmCD2Tb4jkdNexWQbE7PdNWss/7BaKrw
	9f/2aCTF2/Dw==
X-Gm-Gg: AYBFou3gkr/idLNu6MtIjPPMSRvr/Qk9UPXaMBBwSxMTpW7rSz7DCu3/0o/MUefI79g
	j1DbxNHca2CKYTba6t8nkBj2H1/smjv53cNZSLH0jchDL5PVIKAYhiB8/vEEqxweSIDkl6O9UoK
	C+WSYNeRZoobsQRA/3/keIW1agzrPuiAO9fO0uA5ohgc4HOlAolOrqGaorDWJU/X9var1wtshD8
	VTjzDYRmLbGD0xlbJMvkyhfFzVXA/Se2zuo3tpF11mjdTmgybo7wkFTROOO9xJ6ZJVEWFvN4kTa
	mqhiVlzxliUTdZ8HxU4Th4MWPfRP3vC3LxncLidQREKvhENtyPlKGCgKZri+0AV9/uaSCbhenoy
	lYFeHD+7zGkzD/mNLFskvbLamSgUNf2AjtY8WzcQ3hFttqBk6pQ+VTp9KjCVcLBksghpuUqUzB4
	bs+c26Nc24l6zNMSzRxgLuFg59HDJ7HbR17HFuIg==
X-Received: by 2002:a05:6a00:2e9e:b0:882:2195:5a72 with SMTP id d2e1a72fcca58-88221955f54mr2294089b3a.46.1790532137195;
        Sun, 27 Sep 2026 11:02:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9e:b0:882:2195:5a72 with SMTP id d2e1a72fcca58-88221955f54mr2294071b3a.46.1790532136502;
        Sun, 27 Sep 2026 11:02:16 -0700 (PDT)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87febb81d37sm3127238b3a.60.2026.09.27.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:02:16 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: anuj.mittal@oss.qualcomm.com
Subject: [meta-dpdk][PATCH] layer.conf: update to be compatible with blacksail
Date: Sun, 27 Sep 2026 18:01:55 +0000
Message-ID: <20260927180155.1320042-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KxIZnaV0iGq7y7SbqA4M5Ab_SzR2ukNn
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab95a2a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=PsMgmWhz61i2SWVp4PoA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: KxIZnaV0iGq7y7SbqA4M5Ab_SzR2ukNn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MSBTYWx0ZWRfX1gTYcp/pwLq/
 hDsjWs2HraSUKhurjhJNREegioFZClyRtBfS2AJkm7ZmdnX1a90QFEcpQ7XbU9j3yzL0yb40vFh
 Qs1PtPhWLye6duuL37MgS5F1Ag4W/ycSMmHsRCTp5BOC3PcSvDVfgmxX2oUbnF3TtzMF2bGVB2k
 rSnYDXaVFUABF+ETZl61FJOMXjcnyVm3o53iUuvw7jr/OM7t9cCFiF9aXQj6W9lE/taA/kVGVYP
 stMaFz3Nz9XwzbSdFnb7/IbrXu0fqIWHkYQH6kLi3Mkun5RVEn/dC8kdZuGdVZEChLfEM3kecUV
 Dou5RsxZYN9Jri6Sy9e3q2k5LsjpJz4HPZXLLhTE/5XPwn5IYTsDAG+5y+Oh4kRstOTD+l72LN2
 Euttrxt82C3xjQ3kpGZIZETQlcqSjPsVIWvboHWLWrvserbI5VsfYiP79cK3w8CpIfT7cJhwnIf
 XH8cLKORf/phM+0rNyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MSBTYWx0ZWRfXxFk4uQiY8v9s
 5H745FjVL0xudkt8fvEQfPzU6qE2paxNUevzDtkEKmmDsUb9ddKE6G6vw0ro4aBlGqiN8tRVjtm
 RcJymYjytSvT1AWddUcFI9WhiSGS38c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270071
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 18:02:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4958

OE-core has switched to using blacksail release name. Adjust
LAYERSERIES_COMPAT accordingly.

Drop whinlatter and wrynose: since xdp-tools moved to meta-oe master,
the afxdp PACKAGECONFIG has no provider on those releases, which use
their own meta-dpdk branches.

Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 776012d..3f5edfc 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -14,4 +14,4 @@ LAYERDEPENDS_dpdk = "core"
 # This should only be incremented on significant changes that will
 # cause compatibility issues with other layers
 LAYERVERSION_dpdk = "1"
-LAYERSERIES_COMPAT_dpdk = "whinlatter wrynose"
+LAYERSERIES_COMPAT_dpdk = "blacksail"
-- 
2.43.0


