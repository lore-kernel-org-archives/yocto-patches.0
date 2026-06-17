Return-Path: <dmitry.baryshkov@oss.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E8DCD98F2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 19:21:40 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3073.1781724091756419485
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 17 Jun 2026 12:21:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=HMXJ/nmX;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=jVAxQppf;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.180.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HJ7YYR3703444
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rABCGKAiLV87h3fBERlwJjkhRPK41+KkhZBKWQ9Gqlw=; b=HMXJ/nmXvaggLxq3
	z31bhBo2d25VsIJTsCvu0nzbzN0jLaKzbWcZ94coY3ZsJq/AVqCt04sd9EALh8aQ
	pp3Xt24+eRodXsntn9Hh6IjxK4A9wngPY5Wlsp7NVz4QJlXeJyJO3K6yGOnxgfS+
	lEpTZxZYYrj8Qya0YFHlqrsaTqUAzG6+rkXLazpeIraUjSXqC0ht+Cu9+v2/sAKT
	0dMp/50odONi5mX+YYkdpn2L7z27AOE/5cmesiqsd2czUFYxiugxf8b2sLS8xCXT
	XYtQGgYO03k48VZgWV+SmFWth3asiR0tQba9MwP0PlLsKnZMm7Y0QOrziTSbUYx2
	66SAKg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eux2js7wd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:30 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963b07e2003so169821241.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781724090; x=1782328890; darn=lists.yoctoproject.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rABCGKAiLV87h3fBERlwJjkhRPK41+KkhZBKWQ9Gqlw=;
        b=jVAxQppf1Okk4cGjBivUas81Tfswl/df7ZXc0U3wjx6bwFsxnb/FsU5p6Byiirwgjx
         C8zqNL/OwX8Xr7PEMdo0l8d94d+pLIboYa2xRmJgafQy6Sisz1j4xC+5vtmF/j/8UfIW
         LbJdZx182l9EFJ0RKqxfrQIoL6SlI2N4DaLm0xRTy85kdMwJKdfwS4AZ+AreH4BAhTq+
         F1Out7yksTh9rjCaEyzJ1Ncu6UP3DFGQNlxewxX4Y/2TI+eNVe+TK6Ljg7GdIrAMdhC4
         w7bWBT8UOsVQRtZ71JUrNzqXsr5tQ5V6YUgDsLbsJ9QrlfmV5S5/vGTM0rOukbJ4mYpA
         5FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781724090; x=1782328890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rABCGKAiLV87h3fBERlwJjkhRPK41+KkhZBKWQ9Gqlw=;
        b=BVq60rFaADeU62HJ/7QY9n61mKwalLY1p97gh+xfTwTowAlT8gwm/QpGFxgh+gJILI
         P0jary7AM9SdL/m33zlLEQMgsiKCm9VRFoS7OO85DYsCYAtqND+eCRZsdco2mYdxxGPZ
         vTxy71gDFit7cS6Kr+FTyCalkqe/9mZOP/a0dY3FgFgjVpavoNQby3nLnam34VLuXnEQ
         387eWDhEHsWKXh3GQqtbDPNyP2V1Z/znd/6AeRP/lAsWQWoZhI+cG76JsSWsev51Un4W
         WWbIQNRikftO8wQML8Ig4Jojou4Xr/sobFwCRU7PRBoxEds4zo1bcdyy47NrXwj/jZFv
         i8Pw==
X-Gm-Message-State: AOJu0Yx4bnx2nPEBMaCcIWlIOci0sFpvFmFksXAr22iXd/yfQsFj+4ph
	NY7PQxabwlW0lNAKgWXvVXfHHS6BtC5tS4CJDxcaS2X4LFgo2GBlaEU45Ipr7OSzDbgRi6Vghog
	6TkCuD8Z6fWjSxlh2hQQC3xZOC95K6NW6TYvSOu5bGec9P/bMsCQ0V+2cRN85q+bP4LnVyZ9XtU
	CNMggs0R7fag==
X-Gm-Gg: AfdE7cl5cnq0BmK85t3kh5+qtmelI4e3t5eXIWfn4IQAJfrlBeN6hmUzh1sTh7HGYF+
	MVNyl3Bl7S1ng8oAWbw3Ug2mZSGYvkD7qtZbALkdtGCUZNNK3MIG8u0cqsC5gixaR1Ua1mtIZLq
	v8+MVxjf+P3xGPTCKpxBCenvuO7sxz8y65pRaJ/YjWOC4Jt/5+D8cC6V1IdHTu3Gl/+TYDLqIIM
	lwO7dsp7DfEbaVyqtGTRrMfXfJ3jpuZNqs/yUVrTxIaeaI8oEby7UmYc3VQel5d3WfTUb6H0aPz
	VkXjn9FJ+EbbrsLp4YrvnDy1UKcGoNQmIUwLbOOW7wwKGAnHztKxe+RMbQmjkLnU9Nj1J4jdNGq
	oPJpjEHC27Q87yUl9pbnB1LdFF30vyG0xUVbx2KOJWgtVlawjT9HDcILH8oZRmCPQUHJXBYS+kv
	tV0t+8zwKxt+msMIHhdVPBY6VE
X-Received: by 2002:a05:6102:5e84:b0:6c4:5bdb:5e34 with SMTP id ada2fe7eead31-727b5c76b19mr805132137.0.1781724089932;
        Wed, 17 Jun 2026 12:21:29 -0700 (PDT)
X-Received: by 2002:a05:6102:5e84:b0:6c4:5bdb:5e34 with SMTP id ada2fe7eead31-727b5c76b19mr805120137.0.1781724089385;
        Wed, 17 Jun 2026 12:21:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e161f2fsm4774356e87.11.2026.06.17.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:21:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 22:21:18 +0300
Subject: [meta-lts-mixins][wrynose/linux-firmware][PATCH 3/3] SECURITY.md:
 describe security policy and pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-fix-check-layers-v1-3-d1b60c899440@oss.qualcomm.com>
References: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
In-Reply-To: <20260617-fix-check-layers-v1-0-d1b60c899440@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Jose Quaresma <jose.quaresma@oss.qualcomm.com>,
        Viswanath Kraleti <viswanath.kraleti@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mmFax3qy3NaXAXgA97B+92HWyyI4jPDnZBGVPQAkweg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqMvOwNvgBheAUuNUJUqWW85t92AIpMkBJuJFCL
 0Xcf77YviOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCajLzsAAKCRCLPIo+Aiko
 1Y+HB/0aZf9UTjDym96hCeOsbmd/eslAlFt1Cu33zHLEGNfGvqcJ1ZJUiQHYrvs+xn8uXwNoMbM
 2ASO0CYvDD+t9dxDTG3AnKVk/hNqwpmi2UxfjaHUbn01ydeIE3bDqrixBAIOfLaZ/CzqWvZkixT
 mZXOpQscFuba3mQ4KRXq2DwVnlU3SgV/W6vDfWM2RzOVtXyOzeMYQRDN/oBYREgxHBtcz0e1CA1
 GbjXBYq1o26K4mUw54rTai2RmhJF2oDF65dOY7+Dm9rRVf9vHFR7PxDs4i6xyMvNroDC+qg5BZ5
 gA65vgdj2GN/WMa+jf/F3t/a3fFBGj0MOzFT7ta4dtxDp7v7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4NyBTYWx0ZWRfX9b+DzSXAhtzq
 kp8rNTJFsGxPJw2gB/IORLKCYI1jRGlLeJ0XZQmF8p+6VmulV0afvsAB/B5lLyk1gNVwAHlXJxf
 B9PX+/kGLIBD5XwAXkrQR5Z29viRn1odFyiGwqp5URclNWitsbg3Og0WkXeQ8b7N5lmcEJdfX6a
 iR7jbsli/my3R+lEE7gbFJJ+fO0RywEt2MkWgho3mZDxWn3SqQC5IJFYhIUuCh4oqH51eipwz2n
 aEBvfiINF57pvxTX4bqYdw7O8XFcaI1sR9iFOe1Y2C5ZkMbaVMfHHpRBigkIaiJv0vWOMbbFsoW
 9rS1zvrpWV/X9BlVAhGmuUq1MvFGgr+jn8iYRX+eCjaC4fS3mejyflV44Op2j5We4xF7rAVBHLC
 3Zp9bM0DCvg5UQsrnTX8x8kes7iSOUHktq16VTV1mz+snrytYgBa55KfqQRAyyFzEp59fg2KvPd
 9dnukDwfYMtrRx/MUEg==
X-Authority-Analysis: v=2.4 cv=Fsg1OWrq c=1 sm=1 tr=0 ts=6a32f3ba cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=Ii1caJqkCqkA:10
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=iGHA9ds3AAAA:8 a=EUspDBNiAAAA:8 a=IpMVS3Z-WKdEWwjl_OYA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=nM-MV4yxpKKO9kiQg6Ot:22
X-Proofpoint-ORIG-GUID: -TYVLkWCr3m5i8HTuttQUGnko_VjjBAF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4NyBTYWx0ZWRfX4zzuZtfeVB6E
 FmE3Y5RfVPDp9sCOsF1rlZ/4tFoKIQ9FVJkgiKzUEZKLIKfcD8HcsPVeep1s9ufzkqZbWq09aEU
 gQoLUyOwPXZ/CUNEhD6GLQtB/HO8KCk=
X-Proofpoint-GUID: -TYVLkWCr3m5i8HTuttQUGnko_VjjBAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170187
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 17 Jun 2026 19:21:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4236

Add secutity policy (based on the one from OE-Core) as required by
yocto-check-layers for Yocto Project Compliance.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 SECURITY.md | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 000000000000..0aeff07e48da
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,23 @@
+How to Report a Potential Vulnerability
+=======================================
+
+If you would like to report a public issue (for example, one with a released
+CVE number), please report it using the mailing list as described in README.md
+If you have a patch ready, submit it following the same procedure as any other
+patch as described in README.md.
+
+If you are dealing with a not-yet released or urgent issue, please send a
+message to the layer maintainers, including as many details as
+possible: the software module affected, the recipe and its version,
+and any example code, if available.
+
+Branches maintained with security fixes
+---------------------------------------
+
+See [Stable release and LTS](https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS)
+for detailed info regarding the policies and maintenance of Stable branches.
+
+The [Release page](https://wiki.yoctoproject.org/wiki/Releases) contains
+a list of all releases of the Yocto Project. Versions in grey are no longer
+actively maintained with security patches, but well-tested patches may still
+be accepted for them for significant issues.

-- 
2.47.3


