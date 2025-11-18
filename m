Return-Path: <anuj.mittal@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F0CEDD86
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 13:09:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12082.1763471351022578966
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Nov 2025 05:09:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=ljPDz3oo;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Jcjou8ZM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI8VT5g2250184
	for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Nov 2025 13:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jq+BZzINcdT
	wBNg/3NCqSwA9yK1a7EywscWcJBX06DA=; b=ljPDz3oogH+6NGDIU5oRV/AhUOr
	MOD/mw2htcqlVQRmcp3qAFc/lv7mCNpuEDLV1xTnWRsDTiRosZqiIMjsGHU1/39/
	ZJHKxFyMnABMs6WyXXr6lR1EPF4ptpoV5uCSgXkBRqXKonYHgmYDSR5w1PEDgFso
	NVPMxnf8xoxGfxzNyz9GrpqU45THiGGcySoYN996AxspwieqbAcC2jJvSzE2YJqo
	Sxb9WQYHJgTtI14BD62aT94SdOJNKW9sd5Wvk2xjH6lWmC95A/e2D3jRt2RGqB2k
	om5ohWislKMs47he77WNG4L6FpzMbAhQZEY29qnYJ17FJSsx6FdGyczQ0OA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4agnc5gs7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Nov 2025 13:09:10 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b96038aa68so5971568b3a.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 18 Nov 2025 05:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763471350; x=1764076150; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jq+BZzINcdTwBNg/3NCqSwA9yK1a7EywscWcJBX06DA=;
        b=Jcjou8ZMcbQ0FOxI39uJ5JcC1B5lK2YCt+YqnaRo7LtsUW7bSP0BWMrbVXOIiKSnHj
         Fbz26iimDYPlPCwGnufPJ4PsC1bjiW5uMf+NvAtIfVhiX9ENOsOsYo8Ty5uCP00pjdRC
         IFX+LSgwRT0Vvtn+aAPmpSffdUzBLBRvCCKZZinLUgrPhdfiVBqCC3M+hKKRp92QWA0Z
         mEMez3DuEIe1xfCafHNSqKH1U7+OmNJVLc+CarMCvnGT385Z5jM1QSqTqFQ5s03cs60c
         bx6T1n/KC7+cQ1Z2/pxqb5NukmnDGPtAa07dzqWec+R5fLodYJZ71ZUlMiV6HJVBH09p
         ZIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763471350; x=1764076150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jq+BZzINcdTwBNg/3NCqSwA9yK1a7EywscWcJBX06DA=;
        b=hbOx+kU6LGaHlffYSYAuLyFqtHUNW8Yzjljwrh8sO9KhtNi98YFtbrT/p9SMMLSwY0
         fr5tLXSi7by6LvSUwEwADKPd0aT67hhqqP/h1bKb+F5Oe/KVmnvL6jqfcIQZa7GXnEKe
         AQBVfPd2I+e2AI3+By9n/0rdVdVCU/jiHGNT7Sahxp5/bFEmue1I4kd+6iKswX1zaQXI
         Yz3f/twwiNrwgbbjJFnSaojINQ1Uge6gpSUYiI+63iHQcI1MJ6uuq20wN9UUrofo/xkN
         kCa7aMxJzp8exP3q1jpRq+tB7y1O6Q4rzjHfvIWWQ2OSZbEs5snaJCXaIukolR5kfOoi
         Z4jw==
X-Gm-Message-State: AOJu0Yz/cN9En2YW7OnKk/Gt1mM+Ikhc8e0CMkj885OvapmtXn7uzwsB
	kJ+PVIpGB0gUkKJj5UC+BZrvSpQLwKkb1WpoRvj/K5y9GT3z5rsFxSdZ5KP/HmOyjtviB98eJ+a
	Ca0vrU3RTfwUJXK5eti2EyjbBrbnDPTLXaaVD2JIXggYcwAwyVZIN9ggAUqDBZ3O/F/PYEXkVal
	1K7flYa9hZ+UXy
X-Gm-Gg: ASbGnctBUPdxSTxJ1Tc73aYhuOPwQG3sOxj8Pcn3J7nRIkaefYY5r+HY2zr7wMP7XZA
	iopQR17AeHZL0ffJYbpd8FeVcpXDzGlb3ALO8dfU+70ikmyum+6uGgkPlyCaZKMjKHURyXseWwN
	xu+EiVWg44JlI5O/4RE0SrOSQADHuUs67ECpLeycdvmzcEBWV2Pzt5zD+QvDpgt+d61Zv+MTdIN
	M2+wywfLYV9hDvRW4riUXT10WCd7VnFq60Ja5phApOY+fTLIUu95YdB7CYSUIuy5Y9LoLSXq0WV
	8gQgZAglcRcTxmtizezHwBovuqupsDK8S4oRxrZuftpTmdc/nknuFfV9CrGaoZTq5XouZvMUv6/
	99D4fdlGmLTiTmopBfzN3w+w59GXERnJPvf/Qddgy
X-Received: by 2002:aa7:938d:0:b0:7a1:6124:c470 with SMTP id d2e1a72fcca58-7c12f64f901mr2594595b3a.8.1763471349948;
        Tue, 18 Nov 2025 05:09:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkaDKxk7EoC/JsL5dn04x6C0CCKIMlXx6Duxz3AeNpSeIXTKAD12ilgjVUu6sp9pDNcyJpOw==
X-Received: by 2002:aa7:938d:0:b0:7a1:6124:c470 with SMTP id d2e1a72fcca58-7c12f64f901mr2594565b3a.8.1763471349243;
        Tue, 18 Nov 2025 05:09:09 -0800 (PST)
Received: from hu-anujmitt-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d24b9sm16516514b3a.17.2025.11.18.05.09.08
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 05:09:08 -0800 (PST)
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH 2/2] policycoreutils: remove reference to obsolete code
Date: Tue, 18 Nov 2025 18:38:59 +0530
Message-ID: <20251118130859.946532-2-anuj.mittal@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118130859.946532-1-anuj.mittal@oss.qualcomm.com>
References: <20251118130859.946532-1-anuj.mittal@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ubeH9ch3gIEIPVWrzhICeTxXteVNyIyh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDEwNSBTYWx0ZWRfXz/RzxdyGu8qm
 N4/Qz24Oy5c90QKZXWbVNeaNU/R9+c3IQpiGrGVCohFRkyJhdBvKqK3uDMj7gr8QNVY9908m6rf
 ToVA4zxAuFLKj5G4KNPIAJoihH/3lhVei/o7k0HNIH1U3bO4FNmz8duECJVzUV02anfJe9XuMSM
 7fkWlnJc/1DjN/1sq8h9IplKyqkbdk+ue5sqshy3UaRVjFcFppSZcWx2hEgL/ehV6UXiGo/OMMT
 83AJAfmd+s4OSDhBbVeQ6LXdnTJmEFPkpGJ43MlLQWWOm1W9DhURX7PJx8/76pc7z4zg9Erigvy
 /N1oLkaPtxjCDv86t39c9xnZ/3nDAgvWYA0L9z2wAJiKCxsbS48Nry1jObg6jTwQLe1RE4VjIfS
 AByEgiDh/IzstYNzajCGFeR9VMaZhw==
X-Authority-Analysis: v=2.4 cv=BYTVE7t2 c=1 sm=1 tr=0 ts=691c6ff6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=6YGyEImX2DtimxmLrGkA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: ubeH9ch3gIEIPVWrzhICeTxXteVNyIyh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180105
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Nov 2025 13:09:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2581

From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>

The code referenced no longer exists [1]. It was refactored later to
change the way modules are loaded [2].

Remove reference to the code, comment and creation of directory as it
can be set to something else as well.

[1] https://github.com/SELinuxProject/selinux/commit/565ea9832e841075e362db4d188cc7ebb0d4c35e
[2] https://github.com/SELinuxProject/selinux/commit/2ff279e21e4715ac49e094b5fae8bc8e84b9e417

Signed-off-by: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
---
 recipes-security/selinux/policycoreutils_3.9.bb | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/recipes-security/selinux/policycoreutils_3.9.bb b/recipes-security/selinux/policycoreutils_3.9.bb
index 443e18b..c2a3871 100644
--- a/recipes-security/selinux/policycoreutils_3.9.bb
+++ b/recipes-security/selinux/policycoreutils_3.9.bb
@@ -171,10 +171,4 @@ do_install:append:class-target() {
         install -d ${D}${sysconfdir}/pam.d/
         install -m 0644 ${UNPACKDIR}/pam.d/* ${D}${sysconfdir}/pam.d/
     fi
-
-    # /var/lib/selinux is involved by seobject.py:
-    #   + dirname = "/var/lib/selinux"
-    # and it's required for running command:
-    #   $ semanage permissive [OPTS]
-    install -d ${D}${localstatedir}/lib/selinux
 }
-- 
2.51.2


