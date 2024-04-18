Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.12205.1713445478627812182
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 06:04:38 -0700
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I7xJbH028597
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 13:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=PPS06212021; bh=2cq8HpT4blHYbK19mS
	jacYDFtxnq0V2En2R33l3il/k=; b=OWPTTXzFiloF4HCJmTBcbUsL1gYnQwVOFb
	ADr5B2C/6IETheewGaoaOtZ2rabingcT1nuj0GHzr3jGRPidreOQOO+D9l4gHQVk
	pr0dhn85yNR3B6yif7nIMOG/BZxaySR0hX6Yak2o2U71fRtQm0EKER4qmq2v8tFJ
	GfBpJnLoRnmNN7Yu1zWo3ISgu+D5mODMmTZWBFQKuedG/Mn4YRgaGdbTPWnBBPD0
	FR/w3W90BQCZxGIxv0VzfIl2YVbZIikDNER1//TCt0BhYixxojRynP0QUnRLhtkG
	CxbiRMeK0UUNLtW4QbgXvQ7SPAIMKULoYcssVc6PAvybyTbDv9uA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xfh16n0dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 13:04:37 +0000 (GMT)
From: "Yi Zhao" <yi.zhao@eng.windriver.com>
Subject: [meta-security][PATCH] ibmtpm2tss: upgrade 1661 -> 2.2.0
Date: Thu, 18 Apr 2024 21:04:26 +0800
Message-Id: <20240418130426.2030252-1-yi.zhao@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

* Refresh patch
* Fix UPSTREAM_CHECK_GITTAGREGEX

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...efile.am-expand-wildcards-in-prereqs.patch | 32 +++++++++++--------
 ...ibmtpm2tss_1661.bb => ibmtpm2tss_2.2.0.bb} |  8 ++---
 2 files changed, 21 insertions(+), 19 deletions(-)
 rename meta-tpm/recipes-tpm2/ibmtpm2tss/{ibmtpm2tss_1661.bb => ibmtpm2tss_2.2.0.bb} (84%)

diff --git a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss/0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss/0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch
index cfda80f..46af137 100644
--- a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss/0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch
+++ b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss/0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch
@@ -1,4 +1,4 @@
-From 26091b7830d84a12308442b238652ee9475d407b Mon Sep 17 00:00:00 2001
+From 68fafb3516b6004d27f882273f934bda3f4714b4 Mon Sep 17 00:00:00 2001
 From: Jens Rehsack <sno@netbsd.org>
 Date: Fri, 11 Sep 2020 07:46:41 +0200
 Subject: [PATCH] utils{,12}/Makefile.am: expand wildcards in prereqs
@@ -15,15 +15,17 @@ Signed-off-by: Jens Rehsack <sno@netbsd.org>
  utils12/Makefile.am |  8 ++++-
  2 files changed, 79 insertions(+), 4 deletions(-)
 
-Index: git/utils/Makefile.am
-===================================================================
---- git.orig/utils/Makefile.am
-+++ git/utils/Makefile.am
-@@ -85,9 +85,78 @@ libibmtssutils_la_LIBADD = libibmtss.la
+diff --git a/utils/Makefile.am b/utils/Makefile.am
+index 7457269..14689c0 100755
+--- a/utils/Makefile.am
++++ b/utils/Makefile.am
+@@ -93,9 +93,78 @@ libibmtssutils_la_LIBADD = libibmtss.la $(LIBCRYPTO_LIBS) $(EFIBOOT_LIBS)
  
  noinst_HEADERS = CommandAttributes.h imalib.h tssdev.h ntc2lib.h tssntc.h Commands_fp.h objecttemplates.h tssproperties.h cryptoutils.h Platform.h tssauth.h tsssocket.h ekutils.h eventlib.h efilib.h tssccattributes.h
  # install every header in ibmtss
 -nobase_include_HEADERS = ibmtss/*.h
+-
+-notrans_man_MANS = man/man1/*.1
 +nobase_include_HEADERS = ibmtss/ActivateCredential_fp.h ibmtss/ActivateIdentity_fp.h ibmtss/BaseTypes.h \
 +	ibmtss/CertifyCreation_fp.h ibmtss/Certify_fp.h ibmtss/CertifyX509_fp.h ibmtss/ChangeEPS_fp.h \
 +	ibmtss/ChangePPS_fp.h ibmtss/ClearControl_fp.h ibmtss/Clear_fp.h ibmtss/ClockRateAdjust_fp.h \
@@ -63,8 +65,7 @@ Index: git/utils/Makefile.am
 +	ibmtss/tssmarshal.h ibmtss/tssprintcmd.h ibmtss/tssprint.h ibmtss/tssresponsecode.h ibmtss/tsstransmit.h \
 +	ibmtss/tssutils.h ibmtss/Unmarshal12_fp.h ibmtss/Unmarshal_fp.h ibmtss/Unseal_fp.h ibmtss/VerifySignature_fp.h \
 +	ibmtss/ZGen_2Phase_fp.h
- 
--notrans_man_MANS = man/man1/*.1
++
 +notrans_man_MANS = man/man1/tssactivatecredential.1 man/man1/tsscertify.1 man/man1/tsscertifycreation.1 \
 +	man/man1/tsscertifyx509.1 man/man1/tsschangeeps.1 man/man1/tsschangepps.1 man/man1/tssclear.1 \
 +	man/man1/tssclearcontrol.1 man/man1/tssclockrateadjust.1 man/man1/tssclockset.1 man/man1/tsscommit.1 \
@@ -100,11 +101,11 @@ Index: git/utils/Makefile.am
  
  if CONFIG_TPM20
  noinst_HEADERS += tss20.h tssauth20.h ibmtss/tssprintcmd.h
-Index: git/utils12/Makefile.am
-===================================================================
---- git.orig/utils12/Makefile.am
-+++ git/utils12/Makefile.am
-@@ -9,7 +9,13 @@ libibmtssutils12_la_CFLAGS = -I$(top_src
+diff --git a/utils12/Makefile.am b/utils12/Makefile.am
+index 031d0de..02f4e21 100644
+--- a/utils12/Makefile.am
++++ b/utils12/Makefile.am
+@@ -9,7 +9,13 @@ libibmtssutils12_la_CFLAGS = -I$(top_srcdir)/utils
  # result: [current-age].age.revision
  libibmtssutils12_la_LDFLAGS = -version-info @TSSLIB_VERSION_INFO@ ../utils/libibmtss.la
  
@@ -118,4 +119,7 @@ Index: git/utils12/Makefile.am
 +	man/man1/tss1sign.1 man/man1/tss1startup.1 man/man1/tss1takeownership.1 man/man1/tss1tpminit.1
  noinst_HEADERS = ekutils12.h
  
- bin_PROGRAMS = activateidentity createendorsementkeypair createwrapkey extend flushspecific getcapability loadkey2 makeidentity nvdefinespace nvreadvalueauth nvreadvalue nvwritevalueauth nvwritevalue oiap osap ownerreadinternalpub ownersetdisable pcrread quote2 sign startup takeownership tpminit createekcert makeekblob eventextend imaextend
+ if !CONFIG_TSS_NOPRINT
+-- 
+2.25.1
+
diff --git a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_1661.bb b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
similarity index 84%
rename from meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_1661.bb
rename to meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
index 2daca5a..8e941d1 100644
--- a/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_1661.bb
+++ b/meta-tpm/recipes-tpm2/ibmtpm2tss/ibmtpm2tss_2.2.0.bb
@@ -17,14 +17,12 @@ DEPENDS = "openssl ibmswtpm2"
 
 inherit autotools pkgconfig
 
-SRCREV = "c4e131e34ec0ed09411aa3bc76f76129ef881573"
 SRC_URI = "git://git.code.sf.net/p/ibmtpm20tss/tss;protocol=https;branch=master \
            file://0001-utils-12-Makefile.am-expand-wildcards-in-prereqs.patch \
-           "
+          "
+SRCREV = "0b9d77e304f68228b13b20ff0d72b0c16ffd2651"
 
-UPSTREAM_CHECK_COMMITS = "1"
-UPSTREAM_CHECK_URI = "https://git.code.sf.net/p/ibmswtpm2/tpm2"
-UPSTREAM_CHECK_GITTAGREGEX = "rev.*)"
+UPSTREAM_CHECK_GITTAGREGEX = "v(?P<pver>\d+(\.\d+)+)"
 
 EXTRA_OECONF = "--disable-tpm-1.2"
 
-- 
2.25.1

