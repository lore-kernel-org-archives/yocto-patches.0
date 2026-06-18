Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D444CD98F2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 16:00:15 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22840.1781798407494915479
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Jun 2026 09:00:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=XA7bi06x;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Bp2NXQuN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFFaWK2113751
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+cjocNLZ4635OTGQjJXcWRMXg/3MZScDcTQ
	Wc/X6UZc=; b=XA7bi06xOe1CR6UN8oPHzwYZbBH0FLu8hhQ04D7Ns4fExhOeCo1
	Pujv3SIiDGUQaQ1VgbYvJu0yDTUrtL8hdp/wOsWQfTs2XICLRspL59gDoGgVbvmv
	qc5pACys3oYZ+BwdCAu9vl9ZtkddkQtOCd90d8VQtixblhlUcQlDpMTmsJ7vrO/L
	Sjm6BtWecc0mfnpbauUqRNZiyEqoUsJLuwhn+UTpJ3eHC0mjMYmEUhaLjgBZp4oI
	sckT+eIOgnebchTuljmK4QdeCF6+qqvmPHOrpAoFz4JJ7ycA1H75eH/rjHVtHCw6
	TxV2OUbBGR8fFNMuawf+3wZesgHnPZObafQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev12km8bh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:06 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6ee0bfb5681so1342341137.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781798405; x=1782403205; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+cjocNLZ4635OTGQjJXcWRMXg/3MZScDcTQWc/X6UZc=;
        b=Bp2NXQuNGcY/00V6t4Q9FUZvoDnltJyo9mfXWx2//RaBOh+IA8rVvwGdF+nZ/U3qsd
         bgqHqKpHtiy97Il6jWz99YViAibMwhsVLDWZtLRp7AfWcO+jvZKo/xZPbLylLz68ki8P
         VL8OA7BVj8fdvCdLtJCm/8VyCn9jCxXdNy85E9tbTr8vLGSRswXceg75nk018mqvD8dp
         PnIevAgAuWraRR4HRqqX3dfbZdwdKrAF1xW2jx5EKyITcxaZrGeMr9QPXr/LMeRGGt6i
         /lY7c38EkP03CbhZkd17I9/PCmVfaiLSTY/5n4wLmhhj89HRGNmDoTmpw6RwtFx//MnV
         GXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798405; x=1782403205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cjocNLZ4635OTGQjJXcWRMXg/3MZScDcTQWc/X6UZc=;
        b=rrug6T4laTbxygyYpl4St7TQ64RoBsirVzoE7FPHEtVXgK/DkyhYL22/oPFxgaoLiZ
         tOKxIVEwx4ecE2I/rHwjOwShJt+DB33yI0wFcmNoUZkttHM03wtsm/QdK8LrJv5c+8sy
         JqjrfoopGOhy2d4nd1n7CvX4AnM76H186nCBS/Iq3nPU+qBAcbA5EGP1vkzNC8vT9zSM
         b+GIDNHZMiIETPkVP4nGetQ2fT7/Cbe4enoch/6faEVK21L9EpVhDFwnLxVZ92HMSzvg
         Ag2Sl3G9aX8ma5Gcft6EDFXIwtQyGVF2vsr9g0NwtjSIrnnNkW4fFzKhEGLoYYI06WRF
         hXYQ==
X-Gm-Message-State: AOJu0YzEyk9y5oCCBrTN/aguszhJz9nZmEz+XC9wiu0qeEkbmLLut7Jn
	Pz8R1yqcVA6d20WAC1qbzMr3PE730RjmoE5JwfzvWZbNyglXuJQj7xpI5jxctom5fXZI/WTB7At
	CGMl2kbQZQ2ddfffUO1EPxfrbomeA7MiS8oTP5xJgPZF/WvSZW+CFeRUjjpdweotN3/s5fSiEIb
	JpWx+ySOn2kg==
X-Gm-Gg: AfdE7clncuDiayXJ7mSxls6ln8X3meIyrcQgJT8rS38w0XJZBVlgKFn+PaqFCwxnNFd
	BGkTQegAGt9oqpwnkNzxUDPC91kkAuXIkNFujZUeXqpyHIM40YhKBJut1omtT78A1/LsiUk9PPm
	73iHr6zandEz0LG9V/MlOSxnozPO/kxjeHAinz8pbdF67RCMRO6DxQ3WJzHWBSpHAH5BCGYO71t
	WYiQ6nPuiY7yR2XHzk73uSlP/XDRWNYzMBjENawHqVHQSQLv4zd8x7Tlt4R+r/jlUMEGsR/p8/3
	lV8g6b5DxYvViPzGzepGhz+qbMlQApc5gQyBqzZnxHVtj/4D5dgWbflT/6ZlldMVkXQK/3AtHf8
	Sfnk7Amf9Z6LzRnvK5otv4uee6g==
X-Received: by 2002:a05:6102:41ab:b0:6cc:16d2:30f6 with SMTP id ada2fe7eead31-72a022d831bmr230211137.7.1781798405559;
        Thu, 18 Jun 2026 09:00:05 -0700 (PDT)
X-Received: by 2002:a05:6102:41ab:b0:6cc:16d2:30f6 with SMTP id ada2fe7eead31-72a022d831bmr230184137.7.1781798404969;
        Thu, 18 Jun 2026 09:00:04 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fb3c7d9sm1023505e9.7.2026.06.18.09.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 09:00:04 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 1/3] layer.conf: add LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
Date: Thu, 18 Jun 2026 16:59:59 +0100
Message-ID: <20260618160001.3634123-1-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0OCBTYWx0ZWRfX6Mvb/fpjfEN9
 ZKBMiHRbwvTZYLdva40CiDsfHnuWMGhJo3gZBG4fbxJnxOrXJ5sL0AJeu5v02FXcnWXE2bzHzn9
 Q2W7FGcf2YUDRdVkOjS/GPVQ0/1FSN4NxJQZjk6hJuRGFgcSaYG9N2b3p/E/P+IWj2TGXcLnRv2
 8fnwlCDytu6XhKm0jpM9zy5jOcNCxYJ1qfRJMM6nZa0xuklBThs2VdlNcfYaGItFheXOXTdk/3v
 1x7NQWrpV5cIVRve51W0eDd2D8su0YkIBt0H9JgWg2NPIeDTL22SMIpyyIWkM9D5pBFqkYavbBy
 hR7qPMNT50SH7H0AJnpPi7psMbdmDvYdgO+tatnPX1RIwT3te1dDxsnjn0niZNsZ9sLg7CeKU3Z
 Qy9EJmULMF8wWvszqmlX3ZEEx6OaIjK+zdX6pbwHFW/k4GEHxNzFuBIVw0pQ5k7goOE5TQUl0YO
 4Bw3xWYpGAPBUAd4PaA==
X-Proofpoint-GUID: YufhqJo-Pw-JEdivu9nJ475KEd1UmVk3
X-Authority-Analysis: v=2.4 cv=HpVG3UTS c=1 sm=1 tr=0 ts=6a341606 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Q4-j1AaZAAAA:8 a=EUspDBNiAAAA:8 a=SNjrxCsKT8W6lHro86oA:9
 a=ODZdjJIeia2B_SHc_B0f:22 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-ORIG-GUID: YufhqJo-Pw-JEdivu9nJ475KEd1UmVk3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0OCBTYWx0ZWRfXyMeFQaKI6Diy
 RQEOBvx3NKoV1SmDztvKJ0LRC35RulSmLweHQrh4sNQvG3s+cgzKiEqctterivz1wgLUb8KWcCW
 uu/YOGRH6Jr3R507g5K5SXBMt7EAfj0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180148
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 18 Jun 2026 16:00:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4247

In order to make this layer Yocto Project Compatible, the layer should not provide
new versions of packages by default. Because of this, the recipe provided in this
layer will not be used unless the LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE
variable is modified.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 conf/layer.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index 5e1f7f2..59b9e0c 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,3 +17,6 @@ LAYERDEPENDS_lts-linux-firmware-mixin = " \
 
 # https://git.openembedded.org/openembedded-core/commit/?id=2b75c7ba5e3aa6fc57d7b4afe59e2277b4d87de1
 firmwaredir = "${nonarch_base_libdir}/firmware"
+
+# DEFAULT_PREFERENCE for linux-firmware provided by the layer
+LTS_LINUX_FIRMWARE_MIXIN_DEFAULT_PREFERENCE ?= "-1"
-- 
2.54.0


