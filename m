Return-Path: <wenjia.zhang@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5786DCD98C7
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 08:36:11 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40867.1781166968666133474
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jun 2026 01:36:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=lVjjkboi;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=ictVqXac;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: wenjia.zhang@oss.qualcomm.com)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GUDQ3846408
	for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 08:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/XPbYEa0aS2ERBnOrxvRCxxJPEaxgv0hHxq
	aMtBkaTo=; b=lVjjkboiboH76OBDOny9F77iZgNaH3kXdWMwqnrMrSuI7OJW1Ml
	/KWFf2Z2zcUbJiswy6rLiRLhayifqqGU74u7F76Ww/N2Smc9UbG/nZazYKJl7zD7
	Xhnio7B5SdlSAN/APkShKt8iF+5ShJvj7DnXG6C5u7IpZvU83s3qquNBG7I4404Y
	iz8UM0u2hvEGyRViNCIgrXvfIz7pUiXnXNjN62XLc0Coyvvg8H4tYVHpPuEsXRq9
	VRfrjX+njRQSa0PZmLg+Px+a1KbKDXgCtRwLD6Dn+hd4BcGNhrnGoeR/y0bhIhU/
	KeCXqufoi3f77YNl4p1kwEcmQzNQ6QrH8Mw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u2fu5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 08:36:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8423970cb30so5155718b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781166966; x=1781771766; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/XPbYEa0aS2ERBnOrxvRCxxJPEaxgv0hHxqaMtBkaTo=;
        b=ictVqXacIr9NJv8+JEvmqbo/rbQRv1sWkApbtKFOmsjSOhDgVGjNuxoxXI4FBqNNja
         3HEPR2X8NhSAFwTc1MsAHy0QZR2hHa0+0PuhPx4vtp/xjNsi2zLGQTBCLAG95eawcbry
         +js8F7lSxRiDR+n5Kptlg+trjC+VnKRgVE/JDxCA8bPZucpreCcn632CL/twow3eQQHO
         lMQk+rNb1tTKSId3g0HuQ/sf+hKlFP8kCu2QcoJOO+zxzmRiHSBBU2i4PZ9yhSfxqrP7
         y5Kt2dDTQL3LaOZ3pOrRWej+vRUD+BL82CkPHxC108S4O/ox69llVdqK90CaLQ8GFmgs
         uNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166966; x=1781771766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XPbYEa0aS2ERBnOrxvRCxxJPEaxgv0hHxqaMtBkaTo=;
        b=gnFBnxTaH6fUaWmrhbedwr2fwuJD2KdCCTFzvdG1vhmLWtTLtaiSKFEE1WNI5lcLBd
         fTcLY61dttBtwsUcteCOU6xlzPaaUTfL8gWYqAJawheBjZ36EXSf1KhMqFLXKlkzkV+7
         H4udOu4DfcJGccJuIhKXC1ZilG14bP51dDNje57jVP4oZDyAmku49EAcL/kOWMbl4ppD
         QSqVz1n9yPTm3yspverRMVcSOq1sTJuFS00Ewxie15DighDZ+mXGnJpRAlvpoNj7kuUr
         iSxH+v42ZJVRyaA8kmkyz+pbNjPyWqjIyzfB8l/7sLafPopWifD+l6lC0FmCt7F8D4Ou
         WscA==
X-Gm-Message-State: AOJu0YyhEEWWzqMJUt7Gini9HOXssl3IFO3ADJiMUfYRMtlDvdonmR3F
	EO2keaiCTmbKywhoyb+eCFGEOvnfYMowk386z0tUxbIgGMTPFLPKidJuXUuJ2acFcwoVA2rJsDe
	YPkDhES8HZTOK2/sklVgGMvjDDh8AadkxIXcRWjwhosHYpd9RoYVk7tdk2UWCNZHsCKJdBZAD/o
	9kXebnsAwx1Q==
X-Gm-Gg: Acq92OHtE6K1V/JdjQoDbVES5K/LCxn9tltMYh8SxSEKLVl6XtJrWWg00SZi5/F4I41
	j/4EgHOY04D5EJ4S0PupCzI/HfnOIMrWuBDIH7+CqUVetVwcxKME39bOj7gvfDCEfPnyIV8MWQ8
	9GhoJVl1EksjCciEVv3vttTsNt3qEmtm0+5ucVNPMyRAGzrIhsmrQYFTXzzCZYnjlRBu4VoK/PA
	lvo68ghZN3QQDUAiZiOgxJFFGjBYpZoRYSIH9jtfJ1oZTGDbk+VzMg97l7ws1wJdoZqREs7SLik
	Ng4+wkSycAdzQ3A+aBoJV8xUhPmKBWNNtA7jKOcK0SiRngyv416msqfMiqEBBqCLOjBjXxTI9oA
	JoqE8Mf83RfFHJc/syjgdvTWlweKj1tx2Usf6xTUx0BDhcc+6nBFOdpBkgzLACg==
X-Received: by 2002:a05:6a00:451c:b0:842:5b63:6119 with SMTP id d2e1a72fcca58-843367db568mr2014965b3a.1.1781166966285;
        Thu, 11 Jun 2026 01:36:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:451c:b0:842:5b63:6119 with SMTP id d2e1a72fcca58-843367db568mr2014930b3a.1.1781166965675;
        Thu, 11 Jun 2026 01:36:05 -0700 (PDT)
Received: from hu-jiaxli-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-843380c9307sm1160217b3a.29.2026.06.11.01.36.04
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:36:05 -0700 (PDT)
From: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-selinux][PATCH] Enable the tunable flag tee_supplicant_qtee
Date: Thu, 11 Jun 2026 14:06:02 +0530
Message-Id: <20260611083602.2961474-1-wenjia.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a2a7377 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=9vOXjssFF-Wj4FHfM3IA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: dZoTsbop8P5fJ7Tboi2ympHBERGrxSyK
X-Proofpoint-GUID: dZoTsbop8P5fJ7Tboi2ympHBERGrxSyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA4NCBTYWx0ZWRfX+nF7yrhhi/DI
 yngz1JYTDvFmuaCI2OpwgWvz+KqsX5ZCFJNOz1btQ1RNxijthKXwr1tjdHtYrWUEzqrEQKM2T1j
 U0I5yp5RKwEVEK2AfInq6r2XkbLKq+6/9i96xePts/iVOPyDOifdcWYqSrbrtbttKD9OLI4aNLF
 wrkhHJW96sFyH1n6nKluy2QtI+TTK2GSRnQ/OpE/UhjV/sbDbS5TKC1fAZdkvaxuccujjxOLhkR
 bHeGidLYPBgC78OpgJdcPf4N7k5oA4/e3kLr6ycpP7AANJKMGjtA7RLfoZW4MGzMs06CwZSndRq
 i2LNpa8TsbsljtRxitmr54uApCaCcraRIi2t+sCM+balIOvhwNzW68b9OU6xy/BBBsSVCAlyRpn
 vML/glYEnvkqHtC3bmlc5gdIJsLZmxiUlILQh1+7AEr/Ujsh7jhWCKGFoxxbwIqYWVTIP8r/t/z
 99I9MO0a100MmtMiSkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA4NCBTYWx0ZWRfXyiqQ/rcar0fJ
 lKn6bh0Y4tD1E0lXUX1NYwdZZh8Q+9Gle4cXwGR8spZfeXyPRDhxXmtD6dKcKFY7uGYMk2C3Bzh
 rNQG572HmqzbxDnPSz/oETq7CCpDclc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110084
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 08:36:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4209

Set the status of tunable flag tee_supplicant_qtee to true.

Signed-off-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
---
 ...the-tunable-flag-tee_supplicant_qtee.patch | 30 +++++++++++++++++++
 .../refpolicy/refpolicy_common.inc            |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 recipes-security/refpolicy/refpolicy/0059-Enable-the-tunable-flag-tee_supplicant_qtee.patch

diff --git a/recipes-security/refpolicy/refpolicy/0059-Enable-the-tunable-flag-tee_supplicant_qtee.patch b/recipes-security/refpolicy/refpolicy/0059-Enable-the-tunable-flag-tee_supplicant_qtee.patch
new file mode 100644
index 0000000..ae0e4be
--- /dev/null
+++ b/recipes-security/refpolicy/refpolicy/0059-Enable-the-tunable-flag-tee_supplicant_qtee.patch
@@ -0,0 +1,30 @@
+From 3ac2d2334ebf9e225f457c93100e4686d97f1fc4 Mon Sep 17 00:00:00 2001
+From: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
+Date: Thu, 11 Jun 2026 14:29:58 +0800
+Subject: [PATCH] Enable the tunable flag tee_supplicant_qtee
+
+Set the status of tunable flag tee_supplicant_qtee to true.
+
+Upstream-Status: Inappropriate [Embedded specific]
+
+Signed-off-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
+---
+ policy/modules/services/tee_supplicant.te | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/policy/modules/services/tee_supplicant.te b/policy/modules/services/tee_supplicant.te
+index ab0cc2e8c..c3710e13e 100644
+--- a/policy/modules/services/tee_supplicant.te
++++ b/policy/modules/services/tee_supplicant.te
+@@ -10,7 +10,7 @@ policy_module(tee_supplicant)
+ ##  Enable rules specific to qtee_supplicant.
+ ##  </p>
+ ## </desc>
+-gen_tunable(tee_supplicant_qtee, false)
++gen_tunable(tee_supplicant_qtee, true)
+ 
+ type tee_supplicant_t;
+ type tee_supplicant_exec_t;
+-- 
+2.43.0
+
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index 014714c..59699c0 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -74,6 +74,7 @@ SRC_URI += " \
         file://0056-policy-modules-system-setrans-allow-setrans_t-use-fd.patch \
         file://0057-policy-modules-system-systemd-make-_systemd_t-MLS-tr.patch \
         file://0058-policy-modules-system-logging-make-syslogd_runtime_t.patch \
+        file://0059-Enable-the-tunable-flag-tee_supplicant_qtee.patch \
         "
 
 S = "${UNPACKDIR}/refpolicy"
-- 
2.34.1


