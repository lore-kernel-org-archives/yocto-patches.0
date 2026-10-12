Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD18CA9ED0
	for <webhook@archiver.kernel.org>; Mon, 12 Oct 2026 18:10:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.952.1791828639244638359
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 12 Oct 2026 11:10:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=nroqZv8E;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=U7m+Dmiq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CHv2p03573435
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Oct 2026 18:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=GKGiSnqEnGxYIUSECYTHiynsGAO4Zu5VWxN
	yzUmEwns=; b=nroqZv8EX3WHCipEQcQxzctRN2WD2e/2TH4+GOr8tpCvTMvpRXb
	PgWw7Zia62/MgYC6rtWaw+Lg5ccWN8M+O5b69A93/+BSS1DkS9mPslW7IMEC9Pr8
	AvpzbX6Q5bpaXiT/2/6IlHlq1lPXW9PX9kZa/6cWZhVkpl1AhVMGLmdexP1El3N9
	nwPfHtRSaY0L34+qgJcDGFTI1jrYJ/Whq5KJWkHph5RbBgGsTZQCr2TmsAlmTXYS
	zB7r4CbIlVCD5JICcBFJ7BxsZbeV1Tp5AN84EHM8dWMV2bYJT+iVDKJ+xHxxBdqI
	y5PCTQUjZT6KS7e7qIh97IaWLvlCUECMHlQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffj4se-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Oct 2026 18:10:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a8041a532eso1449958a91.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 12 Oct 2026 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791828637; x=1792433437; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GKGiSnqEnGxYIUSECYTHiynsGAO4Zu5VWxNyzUmEwns=;
        b=U7m+Dmiqlu42qHkK1SwdkA0wlgxlvIUpmrFHBp09PabuJPY3DdIYGBLo+kVAzR4QQk
         mNCW1SoC+hKfMob5ufwCLD81vVvVKuExPjmpeXpnKUI0UafKtlVQNpKmoZaQsA6d+70Z
         gL1lPvgenXNHOJMEhqoCE+ZI+RnyS0Fqw+pAEX4tSs+HsoptJb2dIXoOTQWNMttMbE+N
         wZgA+pEbs+/zoji8S2fGFvp3fxjDYO4lBjFJve7dmnYgiCfL7LA+nUKPOkqc38EVijP9
         WhTnuVCrVY9ZB6S5SOyIJ1wx273x6VKGeamIvi/eMGrvM37JJZdsebxk3sNHn0KXFM3z
         y74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791828637; x=1792433437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GKGiSnqEnGxYIUSECYTHiynsGAO4Zu5VWxNyzUmEwns=;
        b=uxULKwxHSBm5n6kqHerQ1/lP2MqvqePQGA/xCS0IFAtwlEDyYrlKTcPTsrSYm6XGNP
         IjUgKlKHe4mXpZ25NFW9S3OOXlOoNs9svDqXGOd6T/yYoXCghDgcNrQpVTQFKt5Unewk
         fBBrk+IsXws6A7Z/0StBWY+z+76sYSjCWjESslO4M7S2/hE5cTxgd4xf0PiybctqGe4A
         h3wei8nhIEtzU5dbbg9psmwP3jdebvC1tGeiUEszCMMH+DkymU6q4oZoVganZYN5pUb3
         ZkkMDDcMD5GvYX3PWgKAKJOJOMLmFMV3ZsiPocRIBoFi22VBOjys3HfK24f/eKXnl2mB
         xumQ==
X-Gm-Message-State: AFq9FYK1ihWyQc9aK5oLgixRnkI7Q7VWgRTc59psnuZixrCcyYMfXv9C
	CnYsdtemZJ0q9lXyAkJMpgd095271TEFyfx+kYGZiNu+V4y7kQ2Xr9rLYcM4wcYLtlKU4nIPoPq
	Yl48FGMGSmCGkY/ZYIdZSyHIZ6h81xUfvYOqe0SseXq/74fsgyhsbLbSBGx1oDi7H+fnB+XC6QZ
	WdliepXK5aiGLr/OI=
X-Gm-Gg: AYBFou3tbF+8FSrAePNVVn1YgJTBaCJibGBcAsBHdwlTh5kJrOFQM1SJrz5NjlM0GFm
	DXiZTMBLKGbPkweZqWCizouDMR0jXPol+MWF/uaXoGC1pZ/1jyNw4uA4AfgxYTPzTl0WZ/rGlA0
	d1RqD0JtbT1AMoZQu+BSiaueMPs9uuvYWgshnWpo5iNWZR5cqHMsjLO4prKJ30r781vPPSD34rG
	chNbhaRMSF7TfpaBLOJ9eYaQMu40U1wfKzUkZA9Kq78uhd8xGxo3Jwvi2O8V6DAy1AR6ZmZxnRj
	S1Zj1JlvQJ3BX1ShX80tbX6VobPYf27qAdCL9Y+yqrQlNdKJI1shHWsmKPGa963oiF9j3SF8Jdp
	RQVv4KkOkLwlQm+pDVAzEbRe599vokwLUdW8QYwcXnH5wWCGSOJ9uggD3HDFk3iKTsOjxx87BQB
	+ZukXWhR4Igmcurai421+aZrkRdCG+yPdO3tsGfQ==
X-Received: by 2002:a17:90a:d605:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ac38a827f0mr377117a91.25.1791828636690;
        Mon, 12 Oct 2026 11:10:36 -0700 (PDT)
X-Received: by 2002:a17:90a:d605:b0:3a0:a912:e759 with SMTP id 98e67ed59e1d1-3ac38a827f0mr377087a91.25.1791828635704;
        Mon, 12 Oct 2026 11:10:35 -0700 (PDT)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32d5a429sm9785529a91.0.2026.10.12.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:10:35 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
Subject: [meta-security][PATCH] python3-tpm2-pytss: update for PYPI_PACKAGE change
Date: Mon, 12 Oct 2026 18:08:54 +0000
Message-ID: <20261012180854.972904-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX/tYQtY0BLI1u
 8qCTv1zA+7++gtHJhqwCmpzToEmQfGqcvhYXnZ9gYY8COz7n3KqypMjnboK+iDwK1gTckr7vqk3
 Ff7mUo9bejDUK9gdn8mrL6OxxpaV0qks4Gg2131VvEtLwy9o6FbMIe25SVusfc/4IbOXClVnNZy
 0sNuQFTR4eSLJoU774OFI8paz/9gDzPBl75gGGgPhr1tucH56TL/Jrf/LnCNGF6p+HigJ64xHNn
 HhxZzw6wwVT6tiqWOqYxAekUpN5YTmOLDX/8+Kg3QNFNFtw67L5Z2iGBuJdH7T6B3oHrQhksPMB
 ClItVKi/FTw4+CdYPk/YTZJoezAAWbCo4OW/XHRK8SbOOCaeEUdskTLfe01xAc8kUYfxsMH4Liv
 mlonB7isFKCCxWXm9orWtcVVyg1kVc2bvZKwbaES8LJibk84ilZLdwpjKxd2kl6BMdk6B7k9RkV
 00bL2LM8y/DGXANLc+g==
X-Proofpoint-GUID: NPXe2z7B4wZwlMUbQFeJae1ki-RDRKKM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX3dd8YTnsl0cX
 RAM4m0UCNGm64Ire3pCMLofBYYWr6tWlRm7Q108xG7kT2MSwPG+pop0CeJEwAfR9yuHgwg8Z9xC
 CuTgzKK4FhUjftPf6OiocEWerqN3yjQ=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acd229d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=faVVFRX8WP77rv_F88wA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: NPXe2z7B4wZwlMUbQFeJae1ki-RDRKKM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120072
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 12 Oct 2026 18:10:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5002

The pypi class has slightly changed the semantics of the PYPI_PACKAGE
variable[1], now PYPI_PACKAGE is the normalised package name and the new
variable PYPI_PACKAGE_SDIST is used when the source tarball doesn't match.

The 2.3.0 sdist on PyPI is still named tpm2-pytss-2.3.0, not the
tpm2_pytss-2.3.0 the class now expects by default, so replace the
now-redundant PYPI_PACKAGE assignment with PYPI_PACKAGE_SDIST, otherwise
do_fetch fails.

[1] oe-core 98049bf86b6 ("classes/pypi: change PYPI_PACKAGE to be normalised")

Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index 44c6ed2..60de4a6 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -4,7 +4,7 @@ HOMEPAGE = "https://github.com/tpm2-software/tpm2-pytss"
 LICENSE = "BSD-2-Clause"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=500b2e742befc3da00684d8a1d5fd9da"
 
-PYPI_PACKAGE = "tpm2-pytss"
+PYPI_PACKAGE_SDIST = "tpm2-pytss"
 
 SRC_URI[sha256sum] = "20071129379656f5f3c3bc16d364612672b147d81191fb4eb9f9ff9fbee48410"
 
-- 
2.43.0


