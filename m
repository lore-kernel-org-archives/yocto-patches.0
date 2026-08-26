Return-Path: <wenwfu@qti.qualcomm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA06C5DF97
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 04:55:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5707.1787720150473861820
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Aug 2026 21:55:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=hM7Nok7K;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: qualcomm.com, ip: 205.220.168.131, mailfrom: wenwfu@qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q3HJXb3275855;
	Wed, 26 Aug 2026 04:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5ZSckl+bf5ioXCHAzA0sfxLio0Y59mBPUak
	7QnAIrHg=; b=hM7Nok7KH9aHpINze/tNnCXdhVdWzzomOz8GbfgS1+3/xMAuSbd
	uCXjfJCikk6+o8pZkXoZYkvnefpbAkrX5Y3mMBhRB/Wwbe2pHin/kCpIOREZqhbc
	cA1V43lmup1NMTWvxcf09mkpZK2podhP8SXIEZpu7O+TIcS+FyNxhNKlgvNiLING
	awwtDz87OoinBcRovejtuRnYKAGkGkbfX/3MWEJllSWWqJGb/rF1aXcLGmGPSswl
	VZbvyEiXvfG5fO0MO4JiEVa/jxuXzxxkMT53mxsvtkwk0ubNbnekND3NC0uJZNn7
	N8jg6e6uIsfdr596z+U6+EnokZJvzjlZDbg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fjn22f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 04:55:49 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q4tlPn008614;
	Wed, 26 Aug 2026 04:55:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4g74ujb80u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 04:55:47 +0000 (GMT)
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67Q4tlHY008608;
	Wed, 26 Aug 2026 04:55:47 GMT
Received: from perf-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 67Q4tkZG008604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 04:55:47 +0000 (GMT)
Received: by perf-sh02-lnx.ap.qualcomm.com (Postfix, from userid 3975139)
	id 03A43AB9; Wed, 26 Aug 2026 12:55:46 +0800 (CST)
From: Wenwen Fu <wenwfu@qti.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: joe.macdonald@siemens.com, yi.zhao@windriver.com,
        Wenwen Fu <wenwfu@qti.qualcomm.com>
Subject: [meta-selinux][PATCH] refpolicy: allow configuring policy booleans
Date: Wed, 26 Aug 2026 12:55:40 +0800
Message-ID: <20260826045540.1390035-1-wenwfu@qti.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: jb1Z5FH-r-6hr5JWslCtjxtikosCklMU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDAzOCBTYWx0ZWRfXw4gv8tqyaoMY
 Eu8dn2h8O6m+s1BiBuoJfyTthOY9Kh1vZEB3J4MOhm8AVlljAsL94rH2N/D6UEyHeqwnYYOsNNL
 3e7rP4wX6Gj/fpC9TxYJbsuPyRGZJFQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDAzOCBTYWx0ZWRfXzGK/7tzXse4k
 ZBsxLlmGYDKel+D7OBigpBbqslnFmPwW880zOkaBXfvbJYoqdgwjWQWRDLFcvmT5F7Q2jcY7m05
 HNH2eDjQU2OMtQSBUJeTvnK6PDxr9Udf3EXo17W+YTyY6Yzoq6JMXPOECUXAb/bQmy5Mu0ybwjn
 ZidNKegtR0rdnfMv8v+JTQcdkTwjt26YfTKgBwoyc6jh6lgMQ8gOh/dQGcM+g8y3XBTybumLPAH
 kAeWNceI2hUqYmtz7lmXESfIRI2u9k4uMwF/QExpbsRuXxOWPGs2jBiqUp+mAoHeAiT5NkH5sHN
 2c8bA5+QPfNbo167htzZjd4kIrwKnhcKrAGiUPXmg95uoZqrPTqxwY2LCSmtqfa6nmGYtkd1V8n
 7rPvBaVUyeDHSNEoJSVX0cGpdtDdsoCISqoYMOZUmZ+5wklKILZM/T2FxcY4PoWDavVSaDsLlVD
 2cc+A2b5fysk+Z4FZIw==
X-Authority-Analysis: v=2.4 cv=ccziaHDM c=1 sm=1 tr=0 ts=6a8e71d5 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=qWK6lUww1F3doyr-U_wA:9
X-Proofpoint-ORIG-GUID: jb1Z5FH-r-6hr5JWslCtjxtikosCklMU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260038
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Aug 2026 04:55:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4687

Changing boolean or tunable defaults currently requires layers to patch
refpolicy sources. This does not scale when a distribution maintains
several policy-specific settings.

Add POLICY_BOOLEANS as a space-separated list of name=value settings.
Apply the settings after generating booleans.conf and fail the build for
invalid entries or names not provided by the selected policy.

Document the new variable in the layer README.

Signed-off-by: Wenwen Fu <wenwfu@qti.qualcomm.com>
---
 README                                        | 12 ++++++
 .../refpolicy/refpolicy_common.inc            | 37 +++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/README b/README
index ae011f3..4a13669 100644
--- a/README
+++ b/README
@@ -47,6 +47,18 @@ to be tailored for your environment.
 e.g. PREFERRED_PROVIDER_virtual/refpolicy ?= "refpolicy-mls"
 
 
+Configuring policy booleans and tunables
+----------------------------------------
+Policy boolean and tunable defaults can be changed at build time with the
+POLICY_BOOLEANS variable.  Entries use a space-separated name=value format,
+and values must be either true or false.  For example:
+
+POLICY_BOOLEANS = "secure_mode=true allow_execmem=false"
+
+The refpolicy build fails if an entry has an invalid format or names a boolean
+or tunable that is not provided by the selected policy.
+
+
 Using different init manager
 ----------------------------
 By default selinux enabled images coming up with "sysvinit" as init manager,
diff --git a/recipes-security/refpolicy/refpolicy_common.inc b/recipes-security/refpolicy/refpolicy_common.inc
index d241343..f9a55bc 100644
--- a/recipes-security/refpolicy/refpolicy_common.inc
+++ b/recipes-security/refpolicy/refpolicy_common.inc
@@ -117,6 +117,10 @@ POLICY_MLS_SENS ?= "16"
 POLICY_MLS_CATS ?= "1024"
 POLICY_MCS_CATS ?= "1024"
 
+# Space-separated policy boolean/tunable settings in name=value format.
+# Values must be either true or false.
+POLICY_BOOLEANS ?= ""
+
 EXTRA_OEMAKE = "NAME=${POLICY_NAME} \
     TYPE=${POLICY_TYPE} \
     DISTRO=${POLICY_DISTRO} \
@@ -153,11 +157,44 @@ disable_policy_modules() {
     done
 }
 
+set_policy_booleans() {
+    for setting in ${POLICY_BOOLEANS}; do
+        name="${setting%%=*}"
+        value="${setting#*=}"
+
+        if [ "${name}" = "${setting}" ]; then
+            bbfatal "Invalid POLICY_BOOLEANS entry: ${setting}"
+        fi
+
+        case "${name}" in
+            ""|*[!A-Za-z0-9_]*)
+                bbfatal "Invalid policy boolean name: ${name}"
+                ;;
+        esac
+
+        case "${value}" in
+            true|false) ;;
+            *)
+                bbfatal "Invalid value for ${name}: ${value}"
+                ;;
+        esac
+
+        if ! grep -q "^${name}[[:space:]]*=" \
+                "${S}/policy/booleans.conf"; then
+            bbfatal "Unknown policy boolean or tunable: ${name}"
+        fi
+
+        sed -i "s/^\(${name}[[:space:]]*=[[:space:]]*\).*/\1${value}/" \
+            "${S}/policy/booleans.conf"
+    done
+}
+
 do_compile() {
     if [ -f "${WORKDIR}/modules.conf" ] ; then
         cp -f ${WORKDIR}/modules.conf ${S}/policy/modules.conf
     fi
     oe_runmake conf
+    set_policy_booleans
     disable_policy_modules
     oe_runmake policy
 }
-- 
2.43.0


