Return-Path: <jose.quaresma@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D64C98304
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 19:35:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3681.1790192111948857778
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 12:35:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=hy7cBdFA;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=Kz3LoJdg;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: jose.quaresma@oss.qualcomm.com)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGUIIJ3281338
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=M1+XEKngVBz
	8z1DbTIpbIbsKJdlyeMRMcqrs7qYAMgA=; b=hy7cBdFA3R1o1QovTF/lZb2UV8Z
	liE1LefubJxPx35eA8rZRLTOIKZWc/Z8ZBw7JGToApgZcGkEYy4o1IagoBdzwuq1
	WY+UQpZ1mr77ScsQl6xfuDzL07wudNBaOB5ei2TrAT7Gbi8OmtDyhiGvKFfuF2Xe
	/mOYyNsyhpJKj/Q8l+dwnc3LyzxSJBGM16QZc2TDe43cA+SK8y2XhQc494qQ/BpM
	cl3inFuyuiTTP7UY8ghfgNYuMrRw1QNNQWKjJ9x2mDZYg/x3L/OS7Z6VF93kqiLT
	rkh1y+NexVJJC/2ixs822SRBtZ3QArfOa411RmtPTNp46bVaqxC2S3/ZTvw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqkdgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:11 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-78350646d7eso202207137.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 12:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790192110; x=1790796910; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1+XEKngVBz8z1DbTIpbIbsKJdlyeMRMcqrs7qYAMgA=;
        b=Kz3LoJdgiUg0hp968hNH8ydxg9+UA873nPbJ+YUQjImp1xN42X1IHlCVmei9YNRAVn
         5A8E4kWmjI6Mld+KWil+/bcEMagHtAzEcFCwWXjuCBK+7XoHJ2naiYcEA4nt855e2F+y
         UPPZ6mTDZz+fdoZRokaAw7RZyz/B5TWqJr8rdLEyFgrD+L9RhrJHsDn/nd1ZLYEglqmP
         llg6cXzJeaqsXBi443tPIRukHCTAbiwrcCaLy+qy5K41mSn/8N/OM/c/TLWeQUNygHZt
         3coqnVhkNY534zGubZt1TDpjt8eaOkfdoQ24BkMfUSsZLS2RHNYEZLXFUUFj6t+++8ua
         eTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192110; x=1790796910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1+XEKngVBz8z1DbTIpbIbsKJdlyeMRMcqrs7qYAMgA=;
        b=qHV7AcWl4z+JnLl/0j0K8Kz98ZEGTBUz6sVnU8Or/wX3oE+tm2TvsPjPKKH7DuO0kK
         EYmGpeiZq3Cassq99EnRdQjPdzPj9XfY9E40THG5kKTEq3vkzq3xUIXHybSrNj2RMC5F
         50XJV+jCOjpM3Zq4nO79Lc79ywZdE9Sj8i7/oNBa0lQ16ooux4cqstSDQhlR5fIBhQPh
         pbwQOxTnNfEDM///6GUbrS8Y3tc2VrmWhALjDaVnPkJTbBMAX/FHjcfiSbU4Sz2M/7Yi
         BIavVlhZQeJU9Z4V1y/wQMXBaTHvI6R5dd7YIDBDC8qzl3vcWbH6+bB7jhr1O81zWrjp
         sa5g==
X-Gm-Message-State: AFuF++kRuWjfo0hYWoMn/OqNx0htzNQX6D+2nkn24ohLnedEVjhavX8I
	lA23sc6M8zyhBgmSbn0VLx1LteChI9pG1gcJikyXK42rOeAIe/W3HMk7ejDUK2TAQy51OPzNkfS
	HWHhzZl9UoYpAS2QP5ryfCF1dEiOw0cae0lmhV8v/guw5DcRXVr5JN3b0ty6QRHlOvYxIZvNN1t
	wICxYt1qcYIzXJ
X-Gm-Gg: AYBFou0HdGdz/Yg5KWgoRRXksgPRTfZd1g10AaeMS28rzrO+evEJCdq0/Ez0Z/NE8Kj
	witJ887XmBrJAAZ42A9ZBlKz13xNWCaAGutsuaEOsPOJPxbyei/3C36ZGd5IUz9OLagAJfeElkC
	kXoLSU3HJjfoQi4QuR8JGxwBIqOeULDs+NlnhVSr1ebIATamRh0hxyWfL9DSh3SMWv9t6T3qnhw
	EbSnx5F/PjSzE7YzHdFyYc12POcBVNs4cghrtBf0wUPg/TYtJZto7sMlYSk6tSuQAZTsNuz7tpH
	4Yt7LLeqz8ZQp+GaGe3A98G3wyRCTu2iwF9Jaoo/TSsR5EeRGCIn2kxFi0HQ0BH++IuosjchN3f
	HDPNdLu/5cUwidg==
X-Received: by 2002:a67:ea0e:0:b0:7aa:b962:a4e7 with SMTP id ada2fe7eead31-7af1f617c94mr116348137.36.1790192110392;
        Wed, 23 Sep 2026 12:35:10 -0700 (PDT)
X-Received: by 2002:a67:ea0e:0:b0:7aa:b962:a4e7 with SMTP id ada2fe7eead31-7af1f617c94mr116340137.36.1790192109922;
        Wed, 23 Sep 2026 12:35:09 -0700 (PDT)
Received: from toster.lan ([185.228.162.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm8706964f8f.6.2026.09.23.12.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:35:09 -0700 (PDT)
From: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 2/6] README: add more backport instructions
Date: Wed, 23 Sep 2026 20:34:53 +0100
Message-ID: <20260923193457.1759294-2-jose.quaresma@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
References: <20260923193457.1759294-1-jose.quaresma@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L8-8Aez9IKQA6e06xnv0wDt_ucBjbeYQ
X-Proofpoint-ORIG-GUID: L8-8Aez9IKQA6e06xnv0wDt_ucBjbeYQ
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab429ef cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=YIx/k7VQn7/pPcQ+xNwIKQ==:17
 a=Ii1caJqkCqkA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=jRHCzXpzfMjM0gmHbHsA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfX5yht4rt1XG/c
 OWWY3CmoBIVWDEGKLwxeSLRdxK3gKhQIBDZ+ZW7AXwMpSXxL3J0GudjYZjMWEOOH4EUuO10rTg/
 9irnteMr1QsIwEvK8xgnrIWfEhBm6c4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3OCBTYWx0ZWRfX9EldLthelXDq
 XYnyIoo8LZMlrPcpBDtBRTqpj1zo8FJDjikHHEINFOkZXr74TWwOjLS45YI8qgRjEjfDZQxPSN7
 fs827mWCiS71YmHyKPb6XHOOMh9+rWqoKk00iudm8TX8nxlPxeN76yWgZ/uA7c1d9ck96E/Yhoq
 e1V2HhAyYn2W+0O6eeKnZVuuxnpEW1Yit8zTs8BPuxCMsrS95Pvf6rx57P5jYDKFfCDWJxHf40N
 0sjc6hvcJer9zBXz3pxi5NKSwdOI4cXuU0kXVF4dxQtpBvkJ+r2fkc+dsTkVhqSY37+jVEFbWC8
 BC3CVJab2dU3Kgon5UNshdXqe5/u5azFzZFKwh4lxTzuZy6QuvUdxDl3rggP2SvyuU0tceBzQsa
 ipxvE6i6ddDpnNRAyHDefz8zIKBAwy1AqM9lKBasYlafhY+SrpETIgEP3CUkRubYJIFBE18WAni
 v2ff3nkqUWQZdSV5mbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230078
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 19:35:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4944

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
2.55.0


