Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.526.1793465163496813298
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 31 Oct 2026 09:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=Di5jQHmU;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=JmPF3/9L;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VGU77t2279430
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=nl39jKNLvU8
	CJDCqHm9Mt0JFtccAQWAuOcIC1qI9To8=; b=Di5jQHmUeVC8OC31/B/qbJxbTWI
	fxaMQKEEm6GvC/VNzuK5xOw1+hIIo3X9UiZmjcZpM8gEtfL4EuBftcog6AwuN0o1
	Fq7YYBjLFK3antrbO25F6JjwJPMYb0S2mu8yFcCQXzKOwB3Krr3HEWjonEH0yrMt
	zsBiOQwCRlnMwY6xkAG4ZSdvUGprYBWRvceZD65dQ16tb1ZvBS+KRyxgS1ZL/YLO
	2jbuqsAGZQgCHkPNHUh1IRnuvzJ4GWXr8S5cIysscSFV/6dBg6ApCJegDREt3R7v
	VAydN8haTZ/b3bTCs3hS3D2JXDqjIq4wjRPi45kseomcyI2+ha9ERb+8Elw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nfsp04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93909014c85so368542685a.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793465162; x=1794069962; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nl39jKNLvU8CJDCqHm9Mt0JFtccAQWAuOcIC1qI9To8=;
        b=JmPF3/9LegSd/YJ+YIOZkeFFwD6Z84VPibHLHQxqIg5m6j+DHlRzrBZ9mbYJzjlcMd
         TLf3F2QVdO7md30lwXFpCrMy3J9SUKmy6zwb/kvmP1sODEIvX0PlIgOVIb1kNJ7W4KCy
         l7k1xd03fQkCC6MCZdAJNC88kTJa4XonFldpC1jOTbGHFRdsyLjWmAJYl+luHQtZDbpT
         SRj1RHZP5Ng9EijcdG/lAwifDRVXdJ2i7RP9oAam9X7ZGI0pI4SPz20XEXP2VXIvVaX+
         zPoVoWq0DU8SZxMnFJQuScSyrbrkjhj3tZmkGhLuVk/XBL1hbaNnf3cxoWUeQp83fNoW
         hGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465162; x=1794069962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nl39jKNLvU8CJDCqHm9Mt0JFtccAQWAuOcIC1qI9To8=;
        b=dxQRkKalvcUYOFqehRTIsvAhruZkzUFn7zHLljCf+QEx/rrAQ5qNPWexxOPj8LIfC2
         4xzJHV1MVbCSzNza/d+UltyX9xXzQKgqQ7fZpfeQNSfxYsrxN0n/mZA0TeKDgarpBGoy
         jmuQVoAU2if8oOZPueC6IDqJFKxKNsRIZj9/W3PtCWuXvsRXA0xLP6eJykgZCjjUKtmU
         jQs4OoyNrWYLsyePJI9XYzga84ZNvH8i7UlbPeutE9Kp2sYZeovQ6A6QI8ZClHfuANNf
         EF1o3S0BvoyOu/iijI+gCi0aRaOCWID1hiq6gz5O9kYrRH5XUwZ6kpZUeDdOj69xlRnA
         130Q==
X-Gm-Message-State: AFq9FYIhufLIL97mEsHw77ewOJmqKcp+qTbrBgE6s7peH92toUq/bbVm
	PS7CKFtmB0Lsfik2wnxcHtz3AmaNX42FABsnHL4W4GM0ud0Rn5ooMkmk1oPxpl2e3TbxIlc9pdc
	fXbJGYuLBMyAtX2jVnr6En5HCbV9mcFlzFZEAXLiXYS8HBd5MlNlSaE4MiikJJ+J3hrq5vkxjya
	uvIKDyqdaihQ==
X-Gm-Gg: AYBFou0zgTGXh2b92tQJtRuRE6WuWOWwuf8juz3MmhK1pUfkVQjs7AnyQezynILz8TK
	GO1L2p8peyaqaSmDvUdL33lOCCMwzxtv8jfGUM4ucjUxqgXQwgPzKHE8XzK60Cu5gqPLeBOZc1P
	yNM4pQqozCNmGNS0FHFmXNSdzvLECauDMn6ouVPK+nqeOOQzprZTumgNDEpoJqOJxwiiFGSJ0rD
	6RXq6vJjbgS2zT15RmBZvvmEjBXVYPgT7f4o9+emsDxik7liczJDHQtfAHyJj21agGrFIbQuggU
	2VuYZv5V2ygcx7N85FQ/Jnu1G2/C5jkj3IK99Z86HxSc/JDsqgvpuWUz+Ji05+Dfj1eAZRlHgp1
	l+UwN3Cdp16H70QToX4f9KfZgGxgVUNgYSm1khwG8Qbwx1HdkSkjrcOuOtcmc3uA=
X-Received: by 2002:a05:620a:400e:b0:93f:1823:308f with SMTP id af79cd13be357-9442186c3b6mr961144085a.81.1793465161327;
        Sat, 31 Oct 2026 09:46:01 -0700 (PDT)
X-Received: by 2002:a05:620a:400e:b0:93f:1823:308f with SMTP id af79cd13be357-9442186c3b6mr961140685a.81.1793465160649;
        Sat, 31 Oct 2026 09:46:00 -0700 (PDT)
Received: from toster.lan ([185.228.162.222])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abe885d91esm103398055e9.0.2026.10.31.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 09:45:59 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 07/10] README: add more backport instructions
Date: Sat, 31 Oct 2026 16:45:40 +0000
Message-ID: <20261031164543.1668-7-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
References: <20261031164543.1668-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfXyskRxwMEXX2D
 ve7AxJJw/bks4qtxRLxgQ9zFvfcqfWrUz9FNiQIz2py7C/1PIa0bd56fWImoeItkBolXGpOG71u
 RkMS50FaX1B6ekK+D4Vj9BcIGL4eQp0=
X-Proofpoint-GUID: AGUGVYLId40w5iZEF29kp4defhJTfL_F
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae61b4a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=qOKIifoFPMYe9XV0Ag7/Dg==:17
 a=Ii1caJqkCqkA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jRHCzXpzfMjM0gmHbHsA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: AGUGVYLId40w5iZEF29kp4defhJTfL_F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NiBTYWx0ZWRfX8lCYE7zOYML5
 w+jffzrJgyge76ajSj3B30IbnIuflK3BSBaGfjbKM3Gn/lMRqDdMvbJqwZEm4TKWVaKvrddf7Yd
 J2i8blwJA1u6kuas6j+2oe3Doo/qBuqAN7vG+HES/sX/s3OGeCD78UTARpzecSM/EAbKYZ2L9SW
 DKZOtpZW4qqlvlTVoc4u8CHSVzbgCqFBpdEmbPdstzZJU5yYPHcPAQBch9OtEf3NmEgkDRl8izN
 sh8Z58nKt0u2/1F8hIjFuWWfCZVfj82iWDNg4jg5V0c8leZDDDJbYw7OiiEW5hG9Sn3UTMHkZS8
 v3S0Fnea1U3GmsBO5HABRvvEdZHDtcGY/2m12z6SjL9duJ16YTrYivGgUoDi/DmidqZdIDI4RsK
 +mZEgj1l5iENIFVC2toIF+pu3kJiXDt/sicQ4Zmljus9I4mdsxFMQAGoD0kHL1kG9iqPmO3TKQy
 5dRfbgOAWYBCsyCnEpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310066
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Sat, 31 Oct 2026 16:46:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5200
Content-Type: text/plain; charset="utf-8"

Create an auxiliary wrynose/linux-firmware-master branch that follows
oe-core without modifications. The final branch will be a merge of this
one with the necessary license fixes.

Signed-off-by: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
---
 README.md | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index 81eb6bf..57d0770 100644
--- a/README.md
+++ b/README.md
@@ -30,20 +30,31 @@ This layer depends on:
 Backporting
 -----------
 
-The patches can be backported from openembedded-core with:
+There are breaking changes in master in the license syntax.
+Because of this we carry a local backport branch
+that follows oe-core/master without any local changes.
 
+The patches can be backported from openembedded-core in two steps:
+
+First the patch is backported on the backport branch
 ```
+ git checkout wrynose/linux-firmware-master
  git -C ../openembedded-core format-patch --stdout -1 \
    origin/master meta/recipes-kernel/linux-firmware | \
   git am --signoff -p4 --directory=recipes-kernel/linux-firmware
 ```
 
-There are breaking changes in master in the license syntax,
-they can be can fixed with:
-
+Second we merge the backport branch and fix the license syntax
 ```
+ git checkout wrynose/linux-firmware
+ git merge --signoff --no-edit -X theirs wrynose/linux-firmware-master
  sed -i -e 's/AND /\& /g' -e 's/LicenseRef-//g' */*/*.bb && \
-  git commit -s -m "linux-firmware: fix license syntax" -a
+  git commit --signoff -m "linux-firmware: fix license syntax" -a
+```
+
+So see the full diff of last merge:
+```
+  git diff HEAD~2
 ```
 
 Contributing
-- 
2.56.0

