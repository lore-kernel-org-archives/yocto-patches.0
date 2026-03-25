Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86673103A982
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:39 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13685.1774405050569911014
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=o+mUHcqu;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ONaji81449120
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=ZXjHVksuCMLGuNpA4J/0LaZODGlg3xiSZ47qmGyZeJw=; b=o+mUHcquFXBf
	CUhL64hg7/0eOtS4SvYlQ6wzOOddHJxPQM6c866yGE3GfcDzW2WELIk1Zglgi+Ds
	2Y0O3l/Lr3U9NdcqKg8IFbFElwMFYqI106EukE2VtDurYBTF/ZAORe/DpSPyo/h2
	+iU4RuHwaKuuMJpWu1EPHomgeh2XsrTpq58rq+k7l/Bt0RhCcnJWi0tcpBZSxctO
	G/W12bqZCauKApUh8BFwBFghVJdYGjU4g6qWJTevXEe4hlo4WhZ6vGPm3PMlaKq0
	6irKauxn5d2+Y+ASrnZh+GQdZbKIu9Qr7FBw7FqetzuRNU0LRXh56STjZqGX5A3N
	mxZiK11nrA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6vcp9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:29 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:28 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:27 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 8/14] Upgrade openjdk-11 to openjdk-21
Date: Wed, 25 Mar 2026 10:17:13 +0800
Message-ID: <20260325021719.1526525-9-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX0ifHr4HKtNDl
 I7rPPKJ82PPI8QT56rmQc2ZWEDKDnZYc4F/TKch4QnNSTKyCuAon34CsqW/OsN6ZFUhqTNyjGKI
 SHbA/RxtjYmpccokUHtef+NvrGGNk3192w8J/ooVVVqff/svDKCI3x/G4TNjQd1Ed90jEyYWQQ0
 5E6cvvjAv5hAFRXc3vJS/TvDiUAQXZikBt2rY1OtFl2OkOEFdcdHHDCloAmwmEj+SJanQAO3zWr
 Yw4ZK1AgaKOyd1PXq5j79fkDRiSZ5Dd6HEvUFtPFfsR673b9kOMzZvLUOupMpq8iJhFTwIlf/uI
 Q5q+UM3vf8N6BTTSlxopK9lZt8T+ErnMGpMarBVujp5UcXlQVDx9s3eyknz/g7mOXTJVMR3OGzN
 /beFLHJTO9fcLe2Zbk5Pqg0KbQ6GxeMGEZu4d65Th+hsqghDIbI2K19csDDa91jvHoo7ftMr/jw
 odaa4TQykZz0SJTqwyA==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c345b9 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=NEAV23lmAAAA:8 a=C5o_0LqhAAAA:20 a=COfzQ7OkAAAA:8
 a=t7CeM3EgAAAA:8 a=putVztTT-FBrqHVYsDYA:9 a=s_5acmNmT8OQC95tMvyY:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: sOuWVpeFyK22uACOWx7UHLuIv1PoEjsv
X-Proofpoint-GUID: sOuWVpeFyK22uACOWx7UHLuIv1PoEjsv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3544

The bazel 7.7.0 requires JDK 21 [1], upgrade openjdk-11 to openjdk-21

[1] https://github.com/bazelbuild/bazel/commit/7a5c1fafac4971f9dc8e9a14dd3f5fee545e3877

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 classes/bazel-base.bbclass                          |  2 +-
 classes/bazel.bbclass                               |  2 +-
 recipes-devtools/bazel/bazel-native_7.7.0.bb        |  2 +-
 ...ative_11.0.15.bb => openjdk-21-native_21.0.2.bb} | 13 ++++++-------
 4 files changed, 9 insertions(+), 10 deletions(-)
 rename recipes-devtools/openjdk/{openjdk-11-native_11.0.15.bb => openjdk-21-native_21.0.2.bb} (59%)

diff --git a/classes/bazel-base.bbclass b/classes/bazel-base.bbclass
index 4741f4e..6a5c7a5 100644
--- a/classes/bazel-base.bbclass
+++ b/classes/bazel-base.bbclass
@@ -1,4 +1,4 @@
-export JAVA_HOME = "${STAGING_LIBDIR_NATIVE}/jvm/openjdk-11-native"
+export JAVA_HOME = "${STAGING_LIBDIR_NATIVE}/jvm/openjdk-21-native"
 
 # %25 of total number of local CPU cores
 BAZEL_JOBS ??= "HOST_CPUS*.25"
diff --git a/classes/bazel.bbclass b/classes/bazel.bbclass
index 556739f..3d5e7b3 100644
--- a/classes/bazel.bbclass
+++ b/classes/bazel.bbclass
@@ -1,5 +1,5 @@
 DEPENDS += "bazel-native \
-           openjdk-11-native \
+           openjdk-21-native \
           "
 DEPENDS:append:class-target = " python3"
 
diff --git a/recipes-devtools/bazel/bazel-native_7.7.0.bb b/recipes-devtools/bazel/bazel-native_7.7.0.bb
index a02844d..400e169 100644
--- a/recipes-devtools/bazel/bazel-native_7.7.0.bb
+++ b/recipes-devtools/bazel/bazel-native_7.7.0.bb
@@ -22,7 +22,7 @@ CCACHE_DISABLE = "1"
 
 DEPENDS = "coreutils-native \
            zip-native \
-           openjdk-11-native \
+           openjdk-21-native \
           "
 
 S = "${UNPACKDIR}"
diff --git a/recipes-devtools/openjdk/openjdk-11-native_11.0.15.bb b/recipes-devtools/openjdk/openjdk-21-native_21.0.2.bb
similarity index 59%
rename from recipes-devtools/openjdk/openjdk-11-native_11.0.15.bb
rename to recipes-devtools/openjdk/openjdk-21-native_21.0.2.bb
index cec79b2..9b4949e 100644
--- a/recipes-devtools/openjdk/openjdk-11-native_11.0.15.bb
+++ b/recipes-devtools/openjdk/openjdk-21-native_21.0.2.bb
@@ -3,21 +3,20 @@ builds using source code from OpenJDK project"
 LICENSE = "GPL-2.0-with-classpath-exception"
 LIC_FILES_CHKSUM = "file://legal/java.base/LICENSE;md5=3e0b59f8fac05c3c03d4a26bbda13f8f"
 
-SRC_URI[md5sum] = "7a1d931c0454981d85ed0d2949a91b7f"
-SRC_URI[sha256sum] = "78e4e52c31600a99bb8050e94017123e447c6683d0f9d7a6c5b0d49c0da6f29a"
+SRC_URI[sha256sum] = "a2def047a73941e01a73739f92755f86b895811afb1f91243db214cff5bdac3f"
 SRC_URI = " \
-    https://github.com/ojdkbuild/contrib_jdk11u-ci/releases/download/jdk-11.0.15%2B10/jdk-11.0.15-ojdkbuild-linux-x64.zip \
+    https://download.java.net/java/GA/jdk21.0.2/f2283984656d49d69e91c558476027ac/13/GPL/openjdk-21.0.2_linux-x64_bin.tar.gz \
 "
 
-S = "${UNPACKDIR}/jdk-11.0.15-ojdkbuild-linux-x64"
+S = "${UNPACKDIR}/jdk-21.0.2"
 
 do_patch[noexec] = "1"
 do_configure[noexec] = "1"
 do_compile[noexec] = "1"
 
 do_install () {
-	install -d ${D}${libdir}/jvm/openjdk-11-native
-	cp -rf ${S}/* ${D}${libdir}/jvm/openjdk-11-native
+	install -d ${D}${libdir}/jvm/openjdk-21-native
+	cp -rf ${S}/* ${D}${libdir}/jvm/openjdk-21-native
 }
 
 inherit native
@@ -25,7 +24,7 @@ INHIBIT_SYSROOT_STRIP = "1"
 
 python __anonymous() {
     if d.getVar("BUILD_ARCH") != "x86_64":
-        msg =  "\nThe pre-build openjdk-11-native does not support %s host," % d.getVar("BUILD_ARCH")
+        msg =  "\nThe pre-build openjdk-21-native does not support %s host," % d.getVar("BUILD_ARCH")
         msg += "\nplease use the one in meta-java to replace,"
         msg += "\nadd meta-java to BBLAYERS in conf/bblayers.conf"
         raise bb.parse.SkipPackage(msg)
-- 
2.34.1


