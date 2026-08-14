Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BAEC5DF6A
	for <webhook@archiver.kernel.org>; Fri, 14 Aug 2026 10:50:06 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10287.1786704597443107114
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Aug 2026 03:49:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=YOnSNvNl;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=DEY2p45Z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAbLrf1125824
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Pll3uD58WqX
	90KZ+4eYEqfnEvpbUepyyEI+HO0s4/Xo=; b=YOnSNvNlH5gPfJLCeFBfNVRq9I2
	mPv0mmwGD6nwDei+ZyROyVJ4E059KdeOnAuKAt7dbHMpxVcmU0yAwId1ODcRn+TR
	hEnwthrf3JWEDIDqQxYLDOV2FosbeQ+TJSUZ81hgiupfEkrNkNmaAinmpbiqv6n5
	aty/NIv1BdEaWxzAdLLNH+Q/YhFMcfWzssiYOX+zj+7B0+qjBiotDdBPGWTRH+qc
	ISXSiWM9BTR9UjbsTInh8eP7eP2CNijOc9vaAqhtnoYolAb9rcRfSx8SEU1HMrxe
	eOXQ0Ul1ikYaHS1zSqJJ1qltt4UggpUZ0pdbmPtAtpjp7+BVviByByZ/E4A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2f3prm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:49:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52d8243f1bcso10707361cf.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786704596; x=1787309396; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pll3uD58WqX90KZ+4eYEqfnEvpbUepyyEI+HO0s4/Xo=;
        b=DEY2p45Z1k5eJ5BDAwJ5e6MgAK1trGiU01CK5MCfNmViB8J5tKqBxm/6EPB5X0XsJ7
         0g5ZFV7cM6MwZL9uNmYr/ySqstQocoRiU/XMw/a5/ZDrKPj4K8/QH97Og1Wjc3fQO2kv
         vwULxUUz7PZSBl8HPMEmovbrXrwgExyzQxNBnVa1W8W+qvZECrpIU39aM/L6jYcsb9Hr
         bsBoCKPYk2r5LOCuQc/RDQgEmf09a//28cvlFdeDKMDOnp0yW/kuW1VTMNnD88PiF5Xn
         1myQdtM0OZ/Cci0KW8NbuhIMhRqqAY82w6JBqADwV2ELKot7EUtdKPKKeWmuodpqSJ+j
         Wlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786704596; x=1787309396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pll3uD58WqX90KZ+4eYEqfnEvpbUepyyEI+HO0s4/Xo=;
        b=hZPLUX10/9Eduln5s2AoJNvOKuOEH4yBK8AAc9/sJiejl/lrPV+Zh3DbWNP/1ll0MR
         Jrvq2XVrxfY4rRc98WCNp4Zb9oA/zZhk7uWjbMKRYMFDCvZwgXZ0mAHnEDmroq76kp4M
         /r2DPvtCTCEr1BFnHyUTtRLq+vacbfVjvjw25IWKU2NSRPwTSeRSvaPPLMaQ8lS9LP3+
         5LgWMwvcc0wah+pqfx26W0+b9km8ayNTy1KLbLJcQoZCRQaYwO/gxwK31TKZBoKzAXdq
         +RYCE6S+bZqnu8LBMx6tlVVdUL8wlVg1rIsZS4ze0Ip0Km0oNiXyS1mve0JSBIPFlRIC
         xFVQ==
X-Gm-Message-State: AOJu0YxQeV1VIimHf6Oym8U9s66h35iAO3ER8cMePu9E1eolKoiwvxMD
	uZvLjp8njWrB9pAjenHx9SRyoNTh5fEfLyLlvJp9Yga3wSWlUPpe3BamKxdwoy3Qcgq9Hhsnprs
	DRTz+6X1CC3Tc9nS4/PLZ7cLMpLzpYlzVUWnQSamXEY2EHv7lMewRT684N0Z4qYO+Z5i7FPxJnW
	Ovk9Lg1wqgfg==
X-Gm-Gg: AR+sD11HOzRE0WSFEciUfXAXsA9P4niYX6UJm40wYtnWDDUBwrWKrD2BVnh2vrPqnN+
	Rr+b0K+/4qtli2r1nnVsa1n2yLEeqLYx0HC9WR6nHGpziueOfTlsadAY6j9XS9IQXeoH9rNqjSk
	hwE2+UmIBWbUsa0BmEobw1oFdT3DqSlY8gFurl8NUUyRWiriWBq9aew2nhgAfpibs7IiKaFSxLJ
	LeGrkAsi9DxzHIzxofAYvmlNF6yeXurSnymcI21oadLB6gJgFofJfcH0WQeY5fZqeAEnF7T4Abk
	Xu4I1QzvHANejxLb5ntr4UlANyuBqTlU00sZEOJRve87vgIKi2vHl3PAm/e/3kBrIowd530JBuV
	Ml+qoK6knWdhAkKc=
X-Received: by 2002:a05:622a:290:b0:528:38b1:b550 with SMTP id d75a77b69052e-52d74b6ae08mr121882421cf.16.1786704595748;
        Fri, 14 Aug 2026 03:49:55 -0700 (PDT)
X-Received: by 2002:a05:622a:290:b0:528:38b1:b550 with SMTP id d75a77b69052e-52d74b6ae08mr121882211cf.16.1786704595394;
        Fri, 14 Aug 2026 03:49:55 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm7064102f8f.32.2026.08.14.03.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 03:49:54 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>,
        Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 5/5] README: ajust formating and add note about fixing license syntax
Date: Fri, 14 Aug 2026 11:49:43 +0100
Message-ID: <20260814104943.3261-5-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814104943.3261-1-jose.quaresma@oss.qualcomm.com>
References: <20260814104943.3261-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FeMHAp+6 c=1 sm=1 tr=0 ts=6a7ef2d4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iGHA9ds3AAAA:8 a=jaglQURSS2jnMsCvYecA:9
 a=kacYvNCVWA4VmyqE58fU:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-GUID: NlnEIuvkRuEIFJoztRfYgIT6DrP50qVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MiBTYWx0ZWRfX4fJVDAT60Wpa
 I/O+PNehx9xCneXxXftogI25GV3gMJMgTeHtbzrnVplHcEY39IFC6whzeImkAkZhS9rkXcGewTQ
 J6U5+I9pOaNGri3lDJWBHoWYL1zFXIEgRPWNCWnQE4Kj+QWho7F+iXmxkiSJgD7FS9pW1fQdRMa
 2vYWrm3aOYIdsbUqBvgBW862EwmXL2q5iI9krJxXBE6m5L2zgW9+xFYHwWy9/2FyKXF0q4LheYV
 3bj/ltJYJ65EcrQuupCxxIONuDPFOYwicUc/80k93OWdGonSNXO3BkxRO7M3obUkCJh5TwCdX6b
 Vk3JQ2Zt0aaFtbu3crLIcoqj0Jx1BzvfAlIqXGRF2MJcak50Rygq3DKRLTd24sddY84QlrqJHR+
 ZvvCYPClHTE4THtMIq6dsfhPHrqJxDdIxOVB0ZWmxT/of4k/QVxIY1+60ij7PB/jJ2f2JUihAi4
 +jjQPFzW9qsPWiMNoTA==
X-Proofpoint-ORIG-GUID: NlnEIuvkRuEIFJoztRfYgIT6DrP50qVN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MiBTYWx0ZWRfXzVyUJJ37BOSr
 yTze8gpyAKDw9dEetCLPmnqDt40yu4li3Ja6FuudOEch76DSPkC5WQX/Y0qCOX9eOl058QVNvqE
 fHs0D2AlnqtlhE+zMPUClYO2vvH/yWg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140082
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Aug 2026 10:50:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4662

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 README.md | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index ef6f019..81eb6bf 100644
--- a/README.md
+++ b/README.md
@@ -1,5 +1,5 @@
 meta-lts-mixins - wrynose/linux-firmware
-================================
+========================================
 
 "Mixin" layer for adding latest Linux firmware into the Yocto Project LTS.
 
@@ -27,13 +27,27 @@ This layer depends on:
   layers: meta
     branch: wrynose
 
-Contributing
-------------
+Backporting
+-----------
 
 The patches can be backported from openembedded-core with:
 
- git -C ../openembedded-core format-patch --stdout -1 origin/master meta/recipes-kernel/linux-firmware | \
+```
+ git -C ../openembedded-core format-patch --stdout -1 \
+   origin/master meta/recipes-kernel/linux-firmware | \
   git am --signoff -p4 --directory=recipes-kernel/linux-firmware
+```
+
+There are breaking changes in master in the license syntax,
+they can be can fixed with:
+
+```
+ sed -i -e 's/AND /\& /g' -e 's/LicenseRef-//g' */*/*.bb && \
+  git commit -s -m "linux-firmware: fix license syntax" -a
+```
+
+Contributing
+------------
 
   The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is used
   for questions, comments and patch review. It is subscriber only, so please
@@ -43,7 +57,12 @@ The patches can be backported from openembedded-core with:
   '[meta-lts-mixins][wrynose/linux-firmware]' in the subject.
 
   When sending single patches, please use something like:
-  git send-email -M -1 --to=yocto-patches@lists.yoctoproject.org --subject-prefix='meta-lts-mixins][wrynose/linux-firmware][PATCH'
+
+```
+  git send-email -M origin/wrynose/linux-firmware \
+   --to=yocto-patches@lists.yoctoproject.org \
+   --subject-prefix='meta-lts-mixins][wrynose/linux-firmware][PATCH'
+```
 
 Maintenance
 -----------
-- 
2.55.0


