Return-Path: <ricardo.salveti@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB20C9832F
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 18:07:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41968.1790532466215825292
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 27 Sep 2026 11:07:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=AVorunnG;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=e7sFF4il;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: ricardo.salveti@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RGmlbT500266
	for <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 18:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ObiJn2FB5u8FOk8BmrnhPS8wMeASm8v0814
	IDQKLWQM=; b=AVorunnG/64DBy9c1/SPL26ifh8DF61uQAHrtVrrGaVgFm+yWj/
	ncC7RYqm5YSlTg4AbvPcF+rlHACWoXA40PP32E9XaLj+QrQaadPaPstwqX6YVkDK
	TCG0ffYt1G5+lglFf5JjTMI8okoEqklFwsBK9LQUzM+veU35KduVpVRp81KC34Lb
	1/er4F0K4J2/ktGI1MGVbPnOulwxK1OYkrcxpMv3fWmoOnK1+ewSXU49MmMcEt7M
	Fyhfo+G6YLslWddHakf/xB9nMVcqiAKnmMRn0GKwMdd/HLa3fpO46axMcI2iqYEF
	/F9YuTWm7PUEu+r3cHM6Hff0oT0olOXGMuQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx64uum5t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 18:07:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so2573874a91.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790532464; x=1791137264; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ObiJn2FB5u8FOk8BmrnhPS8wMeASm8v0814IDQKLWQM=;
        b=e7sFF4il+e54XL3lvtEDlaHxfgGeKmDC4dy0qBb78u5BtcHa2aybdC232KAeM2Rvur
         qqB5GnEyOdPBzSOPnxkaE9WlxtdMg1/M+xDlBPqWztHs/jqIqOhijymHqHZViJP4Abho
         /+Jg5X4d6QlgvzdOYwJu8M2C1ybJSWvrUiIAyU0OTk6iQOQp7Ifa37j5fO9tnPXjhusw
         mlApSkgr6u7Uy/8OfvH6xRhtD8RFlk/bR7dTGy0MDEc3xhB3gPXM7IL/z8iy2AQG+hxz
         R6VcEZlbssyS3no3FAEopm4x7ll1KJYtbHCGPcN4t2XAxhBccySMb7Tm/CJ5wZQt4Chv
         spSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790532464; x=1791137264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ObiJn2FB5u8FOk8BmrnhPS8wMeASm8v0814IDQKLWQM=;
        b=tqWRXRIs1FJ7A961amPH4WvQty1i5YwbhiaFFHArn3+b4SH9LNebt4jJu1ACqS/tqd
         vU8z/UrciHTtNoVwdY1SZbBm58F1z/+HxmZyxmAztSn4SnICllmcTmydYFwWcMak0PKo
         h5Ge2kKnM8cCsTGCBW8V8MroB4NQK994mqOH41qHzQff/Ht5pbD8jSOHhn5hLIPalIci
         Tyd1kSlaYS+rtSadiGa7AMc1WSMHHCziOXMHoLYNNkHuMS3bSJ0vUi6a6HZ0hVyrbDog
         QSAWmk6TkoCKpqxE5KU6oBHhImuJ3ZqL0mR6dRP6nsDjsJxIIH8Vopz0Ym6YY6d3m0tZ
         t94A==
X-Gm-Message-State: AFq9FYLxuAXJNJml6GfmIkMd5vH/XpfgEzWKYkaymo6hdQOKvcGLgKHW
	ZFZnL8vx2ERTKguyT3EWFk94NjBWdoVr4T5lRjpMZrJgivFORwWUZirq1lz6Ga8Ec1C53jTgUz0
	RrB+sK3nnJHb2tVWgKJCLBZYk7sRdACiHAtFaYr9JqS/LaNvKrC9blhNwA1mp2wQ1wFoBjDKBhp
	vjPgYR6MeBDtYK
X-Gm-Gg: AYBFou3ySY5yDEWOOmHD/ebyau77945jG2N4tZquzy/Zx87+M5MiEOuyf58+Za1l+v9
	V8HJSRCM3luGyFV8qgdsga4BzL8KG4gPxCiZ+zEDyNjRq0hua0h0jJ9tlY0LOWO3P+SNotNofoj
	cZuCsREbvci4CwvVnoRSsk0rrrbcGfXCj9XKrCcp5V1S3uZQawHt50rrb78ETTtZ/5eIUL55Rox
	ly3qlDcHPHqPEAXRH/IGO/3Pd5gtntDsAcEiU2XPPuMGF6L6NzLjDuGOoIiz11SRtUK6vANMagq
	LobE0uO6bEwcdVq4atGsn33JIv0I+UTJIoz6+59ytevd4HPV/dxeXbxO2mCA5jeuwdTEt0ZtGdO
	DDNXDHQtW4uGQ9JmCO24aG/JsoA7LUkap1hce4GTv9pCyg796LPetqWVjIwnf+kKgUtW1Fg6rQq
	02nwWhKtp/L3CeFdGyP6uzQTGgR60cY0ZI/KosGQ==
X-Received: by 2002:a17:90a:bc9:b0:3a0:a515:c477 with SMTP id 98e67ed59e1d1-3a0a515c8a1mr5016794a91.16.1790532463646;
        Sun, 27 Sep 2026 11:07:43 -0700 (PDT)
X-Received: by 2002:a17:90a:bc9:b0:3a0:a515:c477 with SMTP id 98e67ed59e1d1-3a0a515c8a1mr5016785a91.16.1790532462873;
        Sun, 27 Sep 2026 11:07:42 -0700 (PDT)
Received: from ip-172-31-25-255.us-west-2.compute.internal (ec2-35-83-207-173.us-west-2.compute.amazonaws.com. [35.83.207.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b499a772sm5544811a91.0.2026.09.27.11.07.42
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:07:42 -0700 (PDT)
From: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] layer.conf: update to blacksail release series
Date: Sun, 27 Sep 2026 18:07:37 +0000
Message-ID: <20260927180737.1320993-1-ricardo.salveti@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MiBTYWx0ZWRfXw8r8ALlx+DJo
 1py/oG7atnLWuaIHoA3NozEdMjAF6qJiYS1mlAD6zc6zaDE4sYGCd9/u39L5n6PySkoDuKVzWPE
 0Ky2+K0uqj+wI6pBdLIIeU/3AX/4bCs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MiBTYWx0ZWRfX6FFtN7t8L781
 FPSoryf+jplxgo2p62SI7eBBH/435XMWESUINBtGoQ67LfzvPL0fVUAtU4wZLnHyTMIVwTniZgP
 vFmMV/9lSq9c0ei7yeyJc3BR5RvoJPk2gkCeDGMHKrWMNQ+bWYTUR2XscY7Jc14UBhfYdXKF3Rs
 4oWF8crVVoppCve5pKoTynXRld+AfK++dzZMh2kktF4GpLl9py4NrfOA/gFwyHCPGQWOH3EeSli
 c2gCSkLIOHIPyMDAil4fCohJsMAp7C26/XHWAbmOf1+3Ra4IV+PDzACCoHYudJ53NbMitw+ZlxS
 oV9mI3VALZqXNoM+/pTUYRhTewIiBYNiVwJvLootDVQ4/xyutngOf7aHXtF6g4NaKLEMaPt7DUz
 GhWA6xfDpwedr+nsjdPgofozn1qt56CIPxtLVMkxO8vAnhPPmwZHz71924a+fjebAy4qEDEQaRY
 URSBQC+3//9QEg7Az9Q==
X-Proofpoint-ORIG-GUID: YchWL6TZKCoQ8x2FqKboKkHiG1c9DfPL
X-Authority-Analysis: v=2.4 cv=E6xYNqdl c=1 sm=1 tr=0 ts=6ab95b70 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=P2/bgbqRawb6I1+7fxbs5g==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=PsMgmWhz61i2SWVp4PoA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: YchWL6TZKCoQ8x2FqKboKkHiG1c9DfPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270072
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 27 Sep 2026 18:07:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4959

OE-core has switched to using blacksail release name. Adjust
LAYERSERIES_COMPAT accordingly.

Signed-off-by: Ricardo Salveti <ricardo.salveti@oss.qualcomm.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 245b4ef..3069dc6 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -17,7 +17,7 @@ BBFILE_PRIORITY_selinux = "5"
 # cause compatibility issues with other layers
 LAYERVERSION_selinux = "1"
 
-LAYERSERIES_COMPAT_selinux = "wrynose"
+LAYERSERIES_COMPAT_selinux = "blacksail"
 
 LAYERDEPENDS_selinux = " \
     core \
-- 
2.43.0


