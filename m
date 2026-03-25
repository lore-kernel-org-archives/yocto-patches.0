Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942E0103A982
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:27 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13923.1774405045163474840
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=Ju3bB+jZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P2DEJr3459919
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=WmcaBkimzVb7mdQE/pWVDhzW4HP+ruSDGUuXmYV78+M=; b=Ju3bB+jZx8s7
	mjvO8+Hhsha4moNqLpp3lZvIc8QrWatzblV+aBmaW2fjxVagFw9fQ/g/Ywmeyknn
	CurLFZaOQCvROhFVXB7r6cnDRMZNZdqwJDQXjunuxes+9MFs7rKxZXLzV/0yZSqJ
	gL8hQQW9+bwUp41TXKOOzSA5RsP4OQI5SAYwxTzL3kOdAE7iw4K2wOJOUotCUftA
	hHTV7ASyY5McgTp5DgyK5xdIPWb0rXiXwV4qaaeeJHy4glI4YcDd7+CjRI+2r6gu
	A5rlJCHvLv5ZvDibelUtKeVswkdHubkbOPQgZQoQEWlF3y65Gh7ZR2Uw8CbrW8RB
	akPGvyeoyw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84du8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:23 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:21 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:21 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 1/14] Revert "Add python3 3.13.11 back"
Date: Wed, 25 Mar 2026 10:17:06 +0800
Message-ID: <20260325021719.1526525-2-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: nDzMmNCWx9qhJp2hjyP2F5pl2y4tyyoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX50BKsCjkdRnX
 H1iupE1vPEV5783KJwkJeohqxoyNKj4Nm495um/24WTKWv7OfjUV3G/JeRurIY/iROl6iuw1aAu
 1tZplo5wVLY/lyOp7jPD7tPhgw41sDnBhehpTUE1BRbS7kl/cwjvblEuLVM/ajM4fJKthO0sjJX
 e6e/tuaUoLcsRJ+h19W+o4wl2eGprFJu3n0CveUPI0vIzG26lsuqOJ6xKU7F8SQoELvK6qoYO/f
 Cgt+45uJ+f0nhU5+a7DE+TRYuH9tAD+7ZWyNslDAw+DeVjdeULwLc9Rp2jeqsS/Iyzv7Sum9Ivb
 4sjmjyVG8cEi8e3opEKW3HuJcsSMqOEFAshT6rwuliAihsnls5vOsoJrholKb6nYWxVOsGCzbwd
 RLRqCaBEPwWkrd2GOifgdoj85HAdECbS01q92+spbt7iMpD1QTtHVxr5A5PTy8TOFQLkVsepDh9
 lABb/PpBTRpYixjUHuA==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345b3 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=NEAV23lmAAAA:8
 a=8AHkEIZyAAAA:8 a=1NWNoF9oAAAA:8 a=pGLkceISAAAA:8 a=a_U1oVfrAAAA:8
 a=IpJZQVW2AAAA:8 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=zjtiufAZAAAA:8
 a=ag1SF4gXAAAA:8 a=0DMlDUsRAAAA:8 a=7CQSdrXTAAAA:8 a=v8kc11KlAAAA:8
 a=RMsEDIMSAAAA:8 a=AsX8vSL5_HAPG3SCKhwA:9 a=Idv6sG65pPGjcnOY:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=97APRTa-CG6DvPMFVxHL:22 a=IawgGOuG5U0WyFbmm1f5:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=2tRhtM0yMehlNRDZlsEQ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=168rQcPrDVj8xHztDHWJ:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=2ZAnuyRqvZoA89f6Nz92:22 a=hc8-Yac5eCz8OqhrGAMs:22
X-Proofpoint-GUID: nDzMmNCWx9qhJp2hjyP2F5pl2y4tyyoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250015
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 62P2DEJr3459919
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3539

This reverts commit 3fa809419857160ffa23762adbee2f20f9f9fbce.
---
 ...shebang-overflow-on-python-config.py.patch |   30 -
 ...r-OpenSSL-3.4-and-add-it-to-multissl.patch | 1452 -----------------
 ...e-stdin-I-O-errors-same-way-as-maste.patch |   46 -
 ...-use-prefix-value-from-build-configu.patch |   31 -
 ...-qemu-wrapper-when-gathering-profile.patch |   33 -
 ...sts-due-to-load-variability-on-YP-AB.patch |   72 -
 ...est_sysconfig-for-posix_user-purelib.patch |   36 -
 ..._fileno-test-due-to-load-variability.patch |   29 -
 ...g.py-use-platlibdir-also-for-purelib.patch |   27 -
 ...ctive_children-skip-problematic-test.patch |   27 -
 ...pes.test_find-skip-without-tools-sdk.patch |   33 -
 ...-test_deadlock-skip-problematic-test.patch |   27 -
 ...le.py-correct-the-test-output-format.patch |   45 -
 ...t_readline-skip-limited-history-test.patch |   46 -
 ...-test_shutdown-skip-problematic-test.patch |   43 -
 ...orlines-skip-due-to-load-variability.patch |   29 -
 .../python3/check_build_completeness.py       |   17 -
 .../python/python3/create_manifest3.py        |  444 -----
 .../python/python3/get_module_deps3.py        |  174 --
 .../python/python3/makerace.patch             |   31 -
 .../python/python3/python3-manifest.json      | 1215 --------------
 .../python/python3/reformat_sysconfig.py      |   21 -
 recipes-devtools/python/python3/run-ptest     |    3 -
 .../python/python3/valid-dists.patch          |  164 --
 recipes-devtools/python/python3_3.13.11.bb    |  490 ------
 25 files changed, 4565 deletions(-)
 delete mode 100644 recipes-devtools/python/python3/0001-Avoid-shebang-ov=
erflow-on-python-config.py.patch
 delete mode 100644 recipes-devtools/python/python3/0001-Generate-data-fo=
r-OpenSSL-3.4-and-add-it-to-multissl.patch
 delete mode 100644 recipes-devtools/python/python3/0001-Lib-pty.py-handl=
e-stdin-I-O-errors-same-way-as-maste.patch
 delete mode 100644 recipes-devtools/python/python3/0001-Lib-sysconfig.py=
-use-prefix-value-from-build-configu.patch
 delete mode 100644 recipes-devtools/python/python3/0001-Makefile.pre-use=
-qemu-wrapper-when-gathering-profile.patch
 delete mode 100644 recipes-devtools/python/python3/0001-Skip-failing-tes=
ts-due-to-load-variability-on-YP-AB.patch
 delete mode 100644 recipes-devtools/python/python3/0001-Update-test_sysc=
onfig-for-posix_user-purelib.patch
 delete mode 100644 recipes-devtools/python/python3/0001-skip-no_stdout_f=
ileno-test-due-to-load-variability.patch
 delete mode 100644 recipes-devtools/python/python3/0001-sysconfig.py-use=
-platlibdir-also-for-purelib.patch
 delete mode 100644 recipes-devtools/python/python3/0001-test_active_chil=
dren-skip-problematic-test.patch
 delete mode 100644 recipes-devtools/python/python3/0001-test_ctypes.test=
_find-skip-without-tools-sdk.patch
 delete mode 100644 recipes-devtools/python/python3/0001-test_deadlock-sk=
ip-problematic-test.patch
 delete mode 100644 recipes-devtools/python/python3/0001-test_locale.py-c=
orrect-the-test-output-format.patch
 delete mode 100644 recipes-devtools/python/python3/0001-test_readline-sk=
ip-limited-history-test.patch
 delete mode 100644 recipes-devtools/python/python3/0001-test_shutdown-sk=
ip-problematic-test.patch
 delete mode 100644 recipes-devtools/python/python3/0001-test_storlines-s=
kip-due-to-load-variability.patch
 delete mode 100755 recipes-devtools/python/python3/check_build_completen=
ess.py
 delete mode 100644 recipes-devtools/python/python3/create_manifest3.py
 delete mode 100644 recipes-devtools/python/python3/get_module_deps3.py
 delete mode 100644 recipes-devtools/python/python3/makerace.patch
 delete mode 100644 recipes-devtools/python/python3/python3-manifest.json
 delete mode 100644 recipes-devtools/python/python3/reformat_sysconfig.py
 delete mode 100644 recipes-devtools/python/python3/run-ptest
 delete mode 100644 recipes-devtools/python/python3/valid-dists.patch
 delete mode 100644 recipes-devtools/python/python3_3.13.11.bb

diff --git a/recipes-devtools/python/python3/0001-Avoid-shebang-overflow-=
on-python-config.py.patch b/recipes-devtools/python/python3/0001-Avoid-sh=
ebang-overflow-on-python-config.py.patch
deleted file mode 100644
index eaf5ea5..0000000
--- a/recipes-devtools/python/python3/0001-Avoid-shebang-overflow-on-pyth=
on-config.py.patch
+++ /dev/null
@@ -1,30 +0,0 @@
-From 6b111a328c1c57b1580d63894b2b5d337316f6d4 Mon Sep 17 00:00:00 2001
-From: Paulo Neves <ptsneves@gmail.com>
-Date: Tue, 7 Jun 2022 16:16:41 +0200
-Subject: [PATCH] Avoid shebang overflow on python-config.py
-
-The whole native path may be too big, leading to shebang
-overflow. Let's just use the env shebang.
-
-Denial reason: [1]
-
-Upstream-Status: Denied [distribution]
-
-[1] https://github.com/python/cpython/pull/93760#pullrequestreview-10053=
65737
----
- Makefile.pre.in | 2 ++
- 1 file changed, 2 insertions(+)
-
-diff --git a/Makefile.pre.in b/Makefile.pre.in
-index 9ec3a71..f7d5382 100644
---- a/Makefile.pre.in
-+++ b/Makefile.pre.in
-@@ -2585,6 +2585,8 @@ python-config: $(srcdir)/Misc/python-config.in Mis=
c/python-config.sh
- 	@ # Substitution happens here, as the completely-expanded BINDIR
- 	@ # is not available in configure
- 	sed -e "s,@EXENAME@,$(EXENAME)," < $(srcdir)/Misc/python-config.in >py=
thon-config.py
-+	@ # Otherwise we might get huge shebangs with native paths
-+	sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' python-config.py
- 	@ # Replace makefile compat. variable references with shell script com=
pat. ones; $(VAR) -> ${VAR}
- 	LC_ALL=3DC sed -e 's,\$$(\([A-Za-z0-9_]*\)),\$$\{\1\},g' < Misc/python=
-config.sh >python-config
- 	@ # On Darwin, always use the python version of the script, the shell
diff --git a/recipes-devtools/python/python3/0001-Generate-data-for-OpenS=
SL-3.4-and-add-it-to-multissl.patch b/recipes-devtools/python/python3/000=
1-Generate-data-for-OpenSSL-3.4-and-add-it-to-multissl.patch
deleted file mode 100644
index 327124e..0000000
--- a/recipes-devtools/python/python3/0001-Generate-data-for-OpenSSL-3.4-=
and-add-it-to-multissl.patch
+++ /dev/null
@@ -1,1452 +0,0 @@
-From db5c5763f3e3172f1dd011355b41469770dafc0f Mon Sep 17 00:00:00 2001
-From: Petr Viktorin <encukou@gmail.com>
-Date: Thu, 28 Nov 2024 13:29:27 +0100
-Subject: [PATCH] gh-127330: Update for OpenSSL 3.4 & document+improve th=
e
- update process (GH-127331)
-
-- Add `git describe` output to headers generated by `make_ssl_data.py`
-
-  This info is more important than the date when the file was generated.
-  It does mean that the tool now requires a Git checkout of OpenSSL,
-  not for example a release tarball.
-
-- Regenerate the older file to add the info.
-  To the other older file, add a note about manual edits.
-
-- Add notes on how to add a new OpenSSL version
-
-- Add 3.4 error messages and multissl tests
-
-Upstream-Status: Submitted [https://github.com/python/cpython/commit/db5=
c5763f3e3172f1dd011355b41469770dafc0f]
-Signed-off-by: Peter Marko <peter.marko@siemens.com>
----
- Modules/_ssl.c                             |   2 +-
- Modules/_ssl_data_111.h                    |   4 +-
- Modules/_ssl_data_300.h                    |   5 +-
- Modules/{_ssl_data_31.h =3D> _ssl_data_34.h} | 674 ++++++++++++++++++++=
-
- Tools/c-analyzer/cpython/_parser.py        |   4 +-
- Tools/ssl/make_ssl_data.py                 |  34 +-
- Tools/ssl/multissltests.py                 |   1 +
- 7 files changed, 714 insertions(+), 10 deletions(-)
- rename Modules/{_ssl_data_31.h =3D> _ssl_data_34.h} (92%)
-
-diff --git a/Modules/_ssl.c b/Modules/_ssl.c
-index b6b5ebf094c..e5b8bf21002 100644
---- a/Modules/_ssl.c
-+++ b/Modules/_ssl.c
-@@ -121,7 +121,7 @@ static void _PySSLFixErrno(void) {
-=20
- /* Include generated data (error codes) */
- #if (OPENSSL_VERSION_NUMBER >=3D 0x30100000L)
--#include "_ssl_data_31.h"
-+#include "_ssl_data_34.h"
- #elif (OPENSSL_VERSION_NUMBER >=3D 0x30000000L)
- #include "_ssl_data_300.h"
- #elif (OPENSSL_VERSION_NUMBER >=3D 0x10101000L)
-diff --git a/Modules/_ssl_data_111.h b/Modules/_ssl_data_111.h
-index 093c786e6a2..061fac2bd58 100644
---- a/Modules/_ssl_data_111.h
-+++ b/Modules/_ssl_data_111.h
-@@ -1,4 +1,6 @@
--/* File generated by Tools/ssl/make_ssl_data.py *//* Generated on 2023-=
06-01T02:58:04.081473 */
-+/* File generated by Tools/ssl/make_ssl_data.py */
-+/* Generated on 2024-11-27T12:48:46.194048+00:00 */
-+/* Generated from Git commit OpenSSL_1_1_1w-0-ge04bd3433f */
- static struct py_ssl_library_code library_codes[] =3D {
- #ifdef ERR_LIB_ASN1
-     {"ASN1", ERR_LIB_ASN1},
-diff --git a/Modules/_ssl_data_300.h b/Modules/_ssl_data_300.h
-index dc66731f6b6..b687ce43c77 100644
---- a/Modules/_ssl_data_300.h
-+++ b/Modules/_ssl_data_300.h
-@@ -1,4 +1,7 @@
--/* File generated by Tools/ssl/make_ssl_data.py *//* Generated on 2023-=
06-01T03:03:52.163218 */
-+/* File generated by Tools/ssl/make_ssl_data.py */
-+/* Generated on 2023-06-01T03:03:52.163218 */
-+/* Manually edited to add definitions from 1.1.1 (GH-105174) */
-+
- static struct py_ssl_library_code library_codes[] =3D {
- #ifdef ERR_LIB_ASN1
-     {"ASN1", ERR_LIB_ASN1},
-diff --git a/Modules/_ssl_data_31.h b/Modules/_ssl_data_34.h
-similarity index 92%
-rename from Modules/_ssl_data_31.h
-rename to Modules/_ssl_data_34.h
-index c589c501f4e..d4af3e1c1fa 100644
---- a/Modules/_ssl_data_31.h
-+++ b/Modules/_ssl_data_34.h
-@@ -1,4 +1,6 @@
--/* File generated by Tools/ssl/make_ssl_data.py *//* Generated on 2023-=
06-01T03:04:00.275280 */
-+/* File generated by Tools/ssl/make_ssl_data.py */
-+/* Generated on 2024-11-27T12:35:52.276767+00:00 */
-+/* Generated from Git commit openssl-3.4.0-0-g98acb6b028 */
- static struct py_ssl_library_code library_codes[] =3D {
- #ifdef ERR_LIB_ASN1
-     {"ASN1", ERR_LIB_ASN1},
-@@ -300,6 +302,11 @@ static struct py_ssl_error_code error_codes[] =3D {
-   #else
-     {"FIRST_NUM_TOO_LARGE", 13, 122},
-   #endif
-+  #ifdef ASN1_R_GENERALIZEDTIME_IS_TOO_SHORT
-+    {"GENERALIZEDTIME_IS_TOO_SHORT", ERR_LIB_ASN1, ASN1_R_GENERALIZEDTI=
ME_IS_TOO_SHORT},
-+  #else
-+    {"GENERALIZEDTIME_IS_TOO_SHORT", 13, 232},
-+  #endif
-   #ifdef ASN1_R_HEADER_TOO_LONG
-     {"HEADER_TOO_LONG", ERR_LIB_ASN1, ASN1_R_HEADER_TOO_LONG},
-   #else
-@@ -730,6 +737,11 @@ static struct py_ssl_error_code error_codes[] =3D {
-   #else
-     {"UNSUPPORTED_TYPE", 13, 196},
-   #endif
-+  #ifdef ASN1_R_UTCTIME_IS_TOO_SHORT
-+    {"UTCTIME_IS_TOO_SHORT", ERR_LIB_ASN1, ASN1_R_UTCTIME_IS_TOO_SHORT}=
,
-+  #else
-+    {"UTCTIME_IS_TOO_SHORT", 13, 233},
-+  #endif
-   #ifdef ASN1_R_WRONG_INTEGER_TYPE
-     {"WRONG_INTEGER_TYPE", ERR_LIB_ASN1, ASN1_R_WRONG_INTEGER_TYPE},
-   #else
-@@ -845,6 +857,11 @@ static struct py_ssl_error_code error_codes[] =3D {
-   #else
-     {"LISTEN_V6_ONLY", 32, 136},
-   #endif
-+  #ifdef BIO_R_LOCAL_ADDR_NOT_AVAILABLE
-+    {"LOCAL_ADDR_NOT_AVAILABLE", ERR_LIB_BIO, BIO_R_LOCAL_ADDR_NOT_AVAI=
LABLE},
-+  #else
-+    {"LOCAL_ADDR_NOT_AVAILABLE", 32, 111},
-+  #endif
-   #ifdef BIO_R_LOOKUP_RETURNED_NOTHING
-     {"LOOKUP_RETURNED_NOTHING", ERR_LIB_BIO, BIO_R_LOOKUP_RETURNED_NOTH=
ING},
-   #else
-@@ -860,6 +877,11 @@ static struct py_ssl_error_code error_codes[] =3D {
-   #else
-     {"NBIO_CONNECT_ERROR", 32, 110},
-   #endif
-+  #ifdef BIO_R_NON_FATAL
-+    {"NON_FATAL", ERR_LIB_BIO, BIO_R_NON_FATAL},
-+  #else
-+    {"NON_FATAL", 32, 112},
-+  #endif
-   #ifdef BIO_R_NO_ACCEPT_ADDR_OR_SERVICE_SPECIFIED
-     {"NO_ACCEPT_ADDR_OR_SERVICE_SPECIFIED", ERR_LIB_BIO, BIO_R_NO_ACCEP=
T_ADDR_OR_SERVICE_SPECIFIED},
-   #else
-@@ -880,6 +902,26 @@ static struct py_ssl_error_code error_codes[] =3D {
-   #else
-     {"NO_SUCH_FILE", 32, 128},
-   #endif
-+  #ifdef BIO_R_PEER_ADDR_NOT_AVAILABLE
-+    {"PEER_ADDR_NOT_AVAILABLE", ERR_LIB_BIO, BIO_R_PEER_ADDR_NOT_AVAILA=
BLE},
-+  #else
-+    {"PEER_ADDR_NOT_AVAILABLE", 32, 114},
-+  #endif
-+  #ifdef BIO_R_PORT_MISMATCH
-+    {"PORT_MISMATCH", ERR_LIB_BIO, BIO_R_PORT_MISMATCH},
-+  #else
-+    {"PORT_MISMATCH", 32, 150},
-+  #endif
-+  #ifdef BIO_R_TFO_DISABLED
-+    {"TFO_DISABLED", ERR_LIB_BIO, BIO_R_TFO_DISABLED},
-+  #else
-+    {"TFO_DISABLED", 32, 106},
-+  #endif
-+  #ifdef BIO_R_TFO_NO_KERNEL_SUPPORT
-+    {"TFO_NO_KERNEL_SUPPORT", ERR_LIB_BIO, BIO_R_TFO_NO_KERNEL_SUPPORT}=
,
-+  #else
-+    {"TFO_NO_KERNEL_SUPPORT", 32, 108},
-+  #endif
-   #ifdef BIO_R_TRANSFER_ERROR
-     {"TRANSFER_ERROR", ERR_LIB_BIO, BIO_R_TRANSFER_ERROR},
-   #else
-@@ -920,6 +962,11 @@ static struct py_ssl_error_code error_codes[] =3D {
-   #else
-     {"UNABLE_TO_REUSEADDR", 32, 139},
-   #endif
-+  #ifdef BIO_R_UNABLE_TO_TFO
-+    {"UNABLE_TO_TFO", ERR_LIB_BIO, BIO_R_UNABLE_TO_TFO},
-+  #else
-+    {"UNABLE_TO_TFO", 32, 109},
-+  #endif
-   #ifdef BIO_R_UNAVAILABLE_IP_FAMILY
-     {"UNAVAILABLE_IP_FAMILY", ERR_LIB_BIO, BIO_R_UNAVAILABLE_IP_FAMILY}=
,
-   #else
-@@ -1230,6 +1277,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"ERROR_VALIDATING_SIGNATURE", 58, 171},
-   #endif
-+  #ifdef CMP_R_EXPECTED_POLLREQ
-+    {"EXPECTED_POLLREQ", ERR_LIB_CMP, CMP_R_EXPECTED_POLLREQ},
-+  #else
-+    {"EXPECTED_POLLREQ", 58, 104},
-+  #endif
-   #ifdef CMP_R_FAILED_BUILDING_OWN_CHAIN
-     {"FAILED_BUILDING_OWN_CHAIN", ERR_LIB_CMP, CMP_R_FAILED_BUILDING_OW=
N_CHAIN},
-   #else
-@@ -1250,16 +1302,51 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"FAIL_INFO_OUT_OF_RANGE", 58, 129},
-   #endif
-+  #ifdef CMP_R_GENERATE_CERTREQTEMPLATE
-+    {"GENERATE_CERTREQTEMPLATE", ERR_LIB_CMP, CMP_R_GENERATE_CERTREQTEM=
PLATE},
-+  #else
-+    {"GENERATE_CERTREQTEMPLATE", 58, 197},
-+  #endif
-+  #ifdef CMP_R_GENERATE_CRLSTATUS
-+    {"GENERATE_CRLSTATUS", ERR_LIB_CMP, CMP_R_GENERATE_CRLSTATUS},
-+  #else
-+    {"GENERATE_CRLSTATUS", 58, 198},
-+  #endif
-+  #ifdef CMP_R_GETTING_GENP
-+    {"GETTING_GENP", ERR_LIB_CMP, CMP_R_GETTING_GENP},
-+  #else
-+    {"GETTING_GENP", 58, 192},
-+  #endif
-+  #ifdef CMP_R_GET_ITAV
-+    {"GET_ITAV", ERR_LIB_CMP, CMP_R_GET_ITAV},
-+  #else
-+    {"GET_ITAV", 58, 199},
-+  #endif
-   #ifdef CMP_R_INVALID_ARGS
-     {"INVALID_ARGS", ERR_LIB_CMP, CMP_R_INVALID_ARGS},
-   #else
-     {"INVALID_ARGS", 58, 100},
-   #endif
-+  #ifdef CMP_R_INVALID_GENP
-+    {"INVALID_GENP", ERR_LIB_CMP, CMP_R_INVALID_GENP},
-+  #else
-+    {"INVALID_GENP", 58, 193},
-+  #endif
-+  #ifdef CMP_R_INVALID_KEYSPEC
-+    {"INVALID_KEYSPEC", ERR_LIB_CMP, CMP_R_INVALID_KEYSPEC},
-+  #else
-+    {"INVALID_KEYSPEC", 58, 202},
-+  #endif
-   #ifdef CMP_R_INVALID_OPTION
-     {"INVALID_OPTION", ERR_LIB_CMP, CMP_R_INVALID_OPTION},
-   #else
-     {"INVALID_OPTION", 58, 174},
-   #endif
-+  #ifdef CMP_R_INVALID_ROOTCAKEYUPDATE
-+    {"INVALID_ROOTCAKEYUPDATE", ERR_LIB_CMP, CMP_R_INVALID_ROOTCAKEYUPD=
ATE},
-+  #else
-+    {"INVALID_ROOTCAKEYUPDATE", 58, 195},
-+  #endif
-   #ifdef CMP_R_MISSING_CERTID
-     {"MISSING_CERTID", ERR_LIB_CMP, CMP_R_MISSING_CERTID},
-   #else
-@@ -1425,6 +1512,21 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TRANSFER_ERROR", 58, 159},
-   #endif
-+  #ifdef CMP_R_UNCLEAN_CTX
-+    {"UNCLEAN_CTX", ERR_LIB_CMP, CMP_R_UNCLEAN_CTX},
-+  #else
-+    {"UNCLEAN_CTX", 58, 191},
-+  #endif
-+  #ifdef CMP_R_UNEXPECTED_CERTPROFILE
-+    {"UNEXPECTED_CERTPROFILE", ERR_LIB_CMP, CMP_R_UNEXPECTED_CERTPROFIL=
E},
-+  #else
-+    {"UNEXPECTED_CERTPROFILE", 58, 196},
-+  #endif
-+  #ifdef CMP_R_UNEXPECTED_CRLSTATUSLIST
-+    {"UNEXPECTED_CRLSTATUSLIST", ERR_LIB_CMP, CMP_R_UNEXPECTED_CRLSTATU=
SLIST},
-+  #else
-+    {"UNEXPECTED_CRLSTATUSLIST", 58, 201},
-+  #endif
-   #ifdef CMP_R_UNEXPECTED_PKIBODY
-     {"UNEXPECTED_PKIBODY", ERR_LIB_CMP, CMP_R_UNEXPECTED_PKIBODY},
-   #else
-@@ -1435,11 +1537,21 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNEXPECTED_PKISTATUS", 58, 185},
-   #endif
-+  #ifdef CMP_R_UNEXPECTED_POLLREQ
-+    {"UNEXPECTED_POLLREQ", ERR_LIB_CMP, CMP_R_UNEXPECTED_POLLREQ},
-+  #else
-+    {"UNEXPECTED_POLLREQ", 58, 105},
-+  #endif
-   #ifdef CMP_R_UNEXPECTED_PVNO
-     {"UNEXPECTED_PVNO", ERR_LIB_CMP, CMP_R_UNEXPECTED_PVNO},
-   #else
-     {"UNEXPECTED_PVNO", 58, 153},
-   #endif
-+  #ifdef CMP_R_UNEXPECTED_SENDER
-+    {"UNEXPECTED_SENDER", ERR_LIB_CMP, CMP_R_UNEXPECTED_SENDER},
-+  #else
-+    {"UNEXPECTED_SENDER", 58, 106},
-+  #endif
-   #ifdef CMP_R_UNKNOWN_ALGORITHM_ID
-     {"UNKNOWN_ALGORITHM_ID", ERR_LIB_CMP, CMP_R_UNKNOWN_ALGORITHM_ID},
-   #else
-@@ -1450,6 +1562,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNKNOWN_CERT_TYPE", 58, 135},
-   #endif
-+  #ifdef CMP_R_UNKNOWN_CRL_ISSUER
-+    {"UNKNOWN_CRL_ISSUER", ERR_LIB_CMP, CMP_R_UNKNOWN_CRL_ISSUER},
-+  #else
-+    {"UNKNOWN_CRL_ISSUER", 58, 200},
-+  #endif
-   #ifdef CMP_R_UNKNOWN_PKISTATUS
-     {"UNKNOWN_PKISTATUS", ERR_LIB_CMP, CMP_R_UNKNOWN_PKISTATUS},
-   #else
-@@ -1465,6 +1582,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNSUPPORTED_KEY_TYPE", 58, 137},
-   #endif
-+  #ifdef CMP_R_UNSUPPORTED_PKIBODY
-+    {"UNSUPPORTED_PKIBODY", ERR_LIB_CMP, CMP_R_UNSUPPORTED_PKIBODY},
-+  #else
-+    {"UNSUPPORTED_PKIBODY", 58, 101},
-+  #endif
-   #ifdef CMP_R_UNSUPPORTED_PROTECTION_ALG_DHBASEDMAC
-     {"UNSUPPORTED_PROTECTION_ALG_DHBASEDMAC", ERR_LIB_CMP, CMP_R_UNSUPP=
ORTED_PROTECTION_ALG_DHBASEDMAC},
-   #else
-@@ -1825,6 +1947,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"NO_SIGNERS", 46, 135},
-   #endif
-+  #ifdef CMS_R_OPERATION_UNSUPPORTED
-+    {"OPERATION_UNSUPPORTED", ERR_LIB_CMS, CMS_R_OPERATION_UNSUPPORTED}=
,
-+  #else
-+    {"OPERATION_UNSUPPORTED", 46, 182},
-+  #endif
-   #ifdef CMS_R_PEER_KEY_ERROR
-     {"PEER_KEY_ERROR", ERR_LIB_CMS, CMS_R_PEER_KEY_ERROR},
-   #else
-@@ -1960,6 +2087,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNSUPPORTED_RECIPIENT_TYPE", 46, 154},
-   #endif
-+  #ifdef CMS_R_UNSUPPORTED_SIGNATURE_ALGORITHM
-+    {"UNSUPPORTED_SIGNATURE_ALGORITHM", ERR_LIB_CMS, CMS_R_UNSUPPORTED_=
SIGNATURE_ALGORITHM},
-+  #else
-+    {"UNSUPPORTED_SIGNATURE_ALGORITHM", 46, 195},
-+  #endif
-   #ifdef CMS_R_UNSUPPORTED_TYPE
-     {"UNSUPPORTED_TYPE", ERR_LIB_CMS, CMS_R_UNSUPPORTED_TYPE},
-   #else
-@@ -1985,6 +2117,31 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"WRAP_ERROR", 46, 159},
-   #endif
-+  #ifdef COMP_R_BROTLI_DECODE_ERROR
-+    {"BROTLI_DECODE_ERROR", ERR_LIB_COMP, COMP_R_BROTLI_DECODE_ERROR},
-+  #else
-+    {"BROTLI_DECODE_ERROR", 41, 102},
-+  #endif
-+  #ifdef COMP_R_BROTLI_DEFLATE_ERROR
-+    {"BROTLI_DEFLATE_ERROR", ERR_LIB_COMP, COMP_R_BROTLI_DEFLATE_ERROR}=
,
-+  #else
-+    {"BROTLI_DEFLATE_ERROR", 41, 103},
-+  #endif
-+  #ifdef COMP_R_BROTLI_ENCODE_ERROR
-+    {"BROTLI_ENCODE_ERROR", ERR_LIB_COMP, COMP_R_BROTLI_ENCODE_ERROR},
-+  #else
-+    {"BROTLI_ENCODE_ERROR", 41, 106},
-+  #endif
-+  #ifdef COMP_R_BROTLI_INFLATE_ERROR
-+    {"BROTLI_INFLATE_ERROR", ERR_LIB_COMP, COMP_R_BROTLI_INFLATE_ERROR}=
,
-+  #else
-+    {"BROTLI_INFLATE_ERROR", 41, 104},
-+  #endif
-+  #ifdef COMP_R_BROTLI_NOT_SUPPORTED
-+    {"BROTLI_NOT_SUPPORTED", ERR_LIB_COMP, COMP_R_BROTLI_NOT_SUPPORTED}=
,
-+  #else
-+    {"BROTLI_NOT_SUPPORTED", 41, 105},
-+  #endif
-   #ifdef COMP_R_ZLIB_DEFLATE_ERROR
-     {"ZLIB_DEFLATE_ERROR", ERR_LIB_COMP, COMP_R_ZLIB_DEFLATE_ERROR},
-   #else
-@@ -2000,6 +2157,26 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"ZLIB_NOT_SUPPORTED", 41, 101},
-   #endif
-+  #ifdef COMP_R_ZSTD_COMPRESS_ERROR
-+    {"ZSTD_COMPRESS_ERROR", ERR_LIB_COMP, COMP_R_ZSTD_COMPRESS_ERROR},
-+  #else
-+    {"ZSTD_COMPRESS_ERROR", 41, 107},
-+  #endif
-+  #ifdef COMP_R_ZSTD_DECODE_ERROR
-+    {"ZSTD_DECODE_ERROR", ERR_LIB_COMP, COMP_R_ZSTD_DECODE_ERROR},
-+  #else
-+    {"ZSTD_DECODE_ERROR", 41, 108},
-+  #endif
-+  #ifdef COMP_R_ZSTD_DECOMPRESS_ERROR
-+    {"ZSTD_DECOMPRESS_ERROR", ERR_LIB_COMP, COMP_R_ZSTD_DECOMPRESS_ERRO=
R},
-+  #else
-+    {"ZSTD_DECOMPRESS_ERROR", 41, 109},
-+  #endif
-+  #ifdef COMP_R_ZSTD_NOT_SUPPORTED
-+    {"ZSTD_NOT_SUPPORTED", ERR_LIB_COMP, COMP_R_ZSTD_NOT_SUPPORTED},
-+  #else
-+    {"ZSTD_NOT_SUPPORTED", 41, 110},
-+  #endif
-   #ifdef CONF_R_ERROR_LOADING_DSO
-     {"ERROR_LOADING_DSO", ERR_LIB_CONF, CONF_R_ERROR_LOADING_DSO},
-   #else
-@@ -2085,6 +2262,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"RECURSIVE_DIRECTORY_INCLUDE", 14, 111},
-   #endif
-+  #ifdef CONF_R_RECURSIVE_SECTION_REFERENCE
-+    {"RECURSIVE_SECTION_REFERENCE", ERR_LIB_CONF, CONF_R_RECURSIVE_SECT=
ION_REFERENCE},
-+  #else
-+    {"RECURSIVE_SECTION_REFERENCE", 14, 126},
-+  #endif
-   #ifdef CONF_R_RELATIVE_PATH
-     {"RELATIVE_PATH", ERR_LIB_CONF, CONF_R_RELATIVE_PATH},
-   #else
-@@ -2370,6 +2552,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TOO_MANY_BYTES", 15, 113},
-   #endif
-+  #ifdef CRYPTO_R_TOO_MANY_NAMES
-+    {"TOO_MANY_NAMES", ERR_LIB_CRYPTO, CRYPTO_R_TOO_MANY_NAMES},
-+  #else
-+    {"TOO_MANY_NAMES", 15, 132},
-+  #endif
-   #ifdef CRYPTO_R_TOO_MANY_RECORDS
-     {"TOO_MANY_RECORDS", ERR_LIB_CRYPTO, CRYPTO_R_TOO_MANY_RECORDS},
-   #else
-@@ -2560,6 +2747,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INVALID_SECRET", 5, 128},
-   #endif
-+  #ifdef DH_R_INVALID_SIZE
-+    {"INVALID_SIZE", ERR_LIB_DH, DH_R_INVALID_SIZE},
-+  #else
-+    {"INVALID_SIZE", 5, 129},
-+  #endif
-   #ifdef DH_R_KDF_PARAMETER_ERROR
-     {"KDF_PARAMETER_ERROR", ERR_LIB_DH, DH_R_KDF_PARAMETER_ERROR},
-   #else
-@@ -2610,6 +2802,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"PEER_KEY_ERROR", 5, 111},
-   #endif
-+  #ifdef DH_R_Q_TOO_LARGE
-+    {"Q_TOO_LARGE", ERR_LIB_DH, DH_R_Q_TOO_LARGE},
-+  #else
-+    {"Q_TOO_LARGE", 5, 130},
-+  #endif
-   #ifdef DH_R_SHARED_INFO_ERROR
-     {"SHARED_INFO_ERROR", ERR_LIB_DH, DH_R_SHARED_INFO_ERROR},
-   #else
-@@ -3545,6 +3742,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"GENERATE_ERROR", 6, 214},
-   #endif
-+  #ifdef EVP_R_GETTING_ALGORITHMIDENTIFIER_NOT_SUPPORTED
-+    {"GETTING_ALGORITHMIDENTIFIER_NOT_SUPPORTED", ERR_LIB_EVP, EVP_R_GE=
TTING_ALGORITHMIDENTIFIER_NOT_SUPPORTED},
-+  #else
-+    {"GETTING_ALGORITHMIDENTIFIER_NOT_SUPPORTED", 6, 229},
-+  #endif
-   #ifdef EVP_R_GET_RAW_KEY_FAILED
-     {"GET_RAW_KEY_FAILED", ERR_LIB_EVP, EVP_R_GET_RAW_KEY_FAILED},
-   #else
-@@ -3745,6 +3947,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE", 6, 150},
-   #endif
-+  #ifdef EVP_R_OPERATION_NOT_SUPPORTED_FOR_THIS_SIGNATURE_TYPE
-+    {"OPERATION_NOT_SUPPORTED_FOR_THIS_SIGNATURE_TYPE", ERR_LIB_EVP, EV=
P_R_OPERATION_NOT_SUPPORTED_FOR_THIS_SIGNATURE_TYPE},
-+  #else
-+    {"OPERATION_NOT_SUPPORTED_FOR_THIS_SIGNATURE_TYPE", 6, 226},
-+  #endif
-   #ifdef EVP_R_OUTPUT_WOULD_OVERFLOW
-     {"OUTPUT_WOULD_OVERFLOW", ERR_LIB_EVP, EVP_R_OUTPUT_WOULD_OVERFLOW}=
,
-   #else
-@@ -3795,6 +4002,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"SET_DEFAULT_PROPERTY_FAILURE", 6, 209},
-   #endif
-+  #ifdef EVP_R_SIGNATURE_TYPE_AND_KEY_TYPE_INCOMPATIBLE
-+    {"SIGNATURE_TYPE_AND_KEY_TYPE_INCOMPATIBLE", ERR_LIB_EVP, EVP_R_SIG=
NATURE_TYPE_AND_KEY_TYPE_INCOMPATIBLE},
-+  #else
-+    {"SIGNATURE_TYPE_AND_KEY_TYPE_INCOMPATIBLE", 6, 228},
-+  #endif
-   #ifdef EVP_R_TOO_MANY_RECORDS
-     {"TOO_MANY_RECORDS", ERR_LIB_EVP, EVP_R_TOO_MANY_RECORDS},
-   #else
-@@ -3825,6 +4037,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNABLE_TO_SET_CALLBACKS", 6, 217},
-   #endif
-+  #ifdef EVP_R_UNKNOWN_BITS
-+    {"UNKNOWN_BITS", ERR_LIB_EVP, EVP_R_UNKNOWN_BITS},
-+  #else
-+    {"UNKNOWN_BITS", 6, 166},
-+  #endif
-   #ifdef EVP_R_UNKNOWN_CIPHER
-     {"UNKNOWN_CIPHER", ERR_LIB_EVP, EVP_R_UNKNOWN_CIPHER},
-   #else
-@@ -3840,6 +4057,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNKNOWN_KEY_TYPE", 6, 207},
-   #endif
-+  #ifdef EVP_R_UNKNOWN_MAX_SIZE
-+    {"UNKNOWN_MAX_SIZE", ERR_LIB_EVP, EVP_R_UNKNOWN_MAX_SIZE},
-+  #else
-+    {"UNKNOWN_MAX_SIZE", 6, 167},
-+  #endif
-   #ifdef EVP_R_UNKNOWN_OPTION
-     {"UNKNOWN_OPTION", ERR_LIB_EVP, EVP_R_UNKNOWN_OPTION},
-   #else
-@@ -3850,6 +4072,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNKNOWN_PBE_ALGORITHM", 6, 121},
-   #endif
-+  #ifdef EVP_R_UNKNOWN_SECURITY_BITS
-+    {"UNKNOWN_SECURITY_BITS", ERR_LIB_EVP, EVP_R_UNKNOWN_SECURITY_BITS}=
,
-+  #else
-+    {"UNKNOWN_SECURITY_BITS", 6, 168},
-+  #endif
-   #ifdef EVP_R_UNSUPPORTED_ALGORITHM
-     {"UNSUPPORTED_ALGORITHM", ERR_LIB_EVP, EVP_R_UNSUPPORTED_ALGORITHM}=
,
-   #else
-@@ -4040,6 +4267,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"RESPONSE_PARSE_ERROR", 61, 104},
-   #endif
-+  #ifdef HTTP_R_RESPONSE_TOO_MANY_HDRLINES
-+    {"RESPONSE_TOO_MANY_HDRLINES", ERR_LIB_HTTP, HTTP_R_RESPONSE_TOO_MA=
NY_HDRLINES},
-+  #else
-+    {"RESPONSE_TOO_MANY_HDRLINES", 61, 130},
-+  #endif
-   #ifdef HTTP_R_RETRY_TIMEOUT
-     {"RETRY_TIMEOUT", ERR_LIB_HTTP, HTTP_R_RETRY_TIMEOUT},
-   #else
-@@ -4530,6 +4762,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNSUPPORTED_PUBLIC_KEY_TYPE", 9, 110},
-   #endif
-+  #ifdef PKCS12_R_CALLBACK_FAILED
-+    {"CALLBACK_FAILED", ERR_LIB_PKCS12, PKCS12_R_CALLBACK_FAILED},
-+  #else
-+    {"CALLBACK_FAILED", 35, 115},
-+  #endif
-   #ifdef PKCS12_R_CANT_PACK_STRUCTURE
-     {"CANT_PACK_STRUCTURE", ERR_LIB_PKCS12, PKCS12_R_CANT_PACK_STRUCTUR=
E},
-   #else
-@@ -4920,6 +5157,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"CIPHER_OPERATION_FAILED", 57, 102},
-   #endif
-+  #ifdef PROV_R_COFACTOR_REQUIRED
-+    {"COFACTOR_REQUIRED", ERR_LIB_PROV, PROV_R_COFACTOR_REQUIRED},
-+  #else
-+    {"COFACTOR_REQUIRED", 57, 236},
-+  #endif
-   #ifdef PROV_R_DERIVATION_FUNCTION_INIT_FAILED
-     {"DERIVATION_FUNCTION_INIT_FAILED", ERR_LIB_PROV, PROV_R_DERIVATION=
_FUNCTION_INIT_FAILED},
-   #else
-@@ -4935,6 +5177,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"EMS_NOT_ENABLED", 57, 233},
-   #endif
-+  #ifdef PROV_R_ENTROPY_SOURCE_FAILED_CONTINUOUS_TESTS
-+    {"ENTROPY_SOURCE_FAILED_CONTINUOUS_TESTS", ERR_LIB_PROV, PROV_R_ENT=
ROPY_SOURCE_FAILED_CONTINUOUS_TESTS},
-+  #else
-+    {"ENTROPY_SOURCE_FAILED_CONTINUOUS_TESTS", 57, 244},
-+  #endif
-   #ifdef PROV_R_ENTROPY_SOURCE_STRENGTH_TOO_WEAK
-     {"ENTROPY_SOURCE_STRENGTH_TOO_WEAK", ERR_LIB_PROV, PROV_R_ENTROPY_S=
OURCE_STRENGTH_TOO_WEAK},
-   #else
-@@ -4990,6 +5237,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"FAILED_TO_SIGN", 57, 175},
-   #endif
-+  #ifdef PROV_R_FINAL_CALL_OUT_OF_ORDER
-+    {"FINAL_CALL_OUT_OF_ORDER", ERR_LIB_PROV, PROV_R_FINAL_CALL_OUT_OF_=
ORDER},
-+  #else
-+    {"FINAL_CALL_OUT_OF_ORDER", 57, 237},
-+  #endif
-   #ifdef PROV_R_FIPS_MODULE_CONDITIONAL_ERROR
-     {"FIPS_MODULE_CONDITIONAL_ERROR", ERR_LIB_PROV, PROV_R_FIPS_MODULE_=
CONDITIONAL_ERROR},
-   #else
-@@ -5020,6 +5272,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INDICATOR_INTEGRITY_FAILURE", 57, 210},
-   #endif
-+  #ifdef PROV_R_INIT_CALL_OUT_OF_ORDER
-+    {"INIT_CALL_OUT_OF_ORDER", ERR_LIB_PROV, PROV_R_INIT_CALL_OUT_OF_OR=
DER},
-+  #else
-+    {"INIT_CALL_OUT_OF_ORDER", 57, 238},
-+  #endif
-   #ifdef PROV_R_INSUFFICIENT_DRBG_STRENGTH
-     {"INSUFFICIENT_DRBG_STRENGTH", ERR_LIB_PROV, PROV_R_INSUFFICIENT_DR=
BG_STRENGTH},
-   #else
-@@ -5030,6 +5287,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INVALID_AAD", 57, 108},
-   #endif
-+  #ifdef PROV_R_INVALID_AEAD
-+    {"INVALID_AEAD", ERR_LIB_PROV, PROV_R_INVALID_AEAD},
-+  #else
-+    {"INVALID_AEAD", 57, 231},
-+  #endif
-   #ifdef PROV_R_INVALID_CONFIG_DATA
-     {"INVALID_CONFIG_DATA", ERR_LIB_PROV, PROV_R_INVALID_CONFIG_DATA},
-   #else
-@@ -5070,6 +5332,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INVALID_DIGEST_SIZE", 57, 218},
-   #endif
-+  #ifdef PROV_R_INVALID_EDDSA_INSTANCE_FOR_ATTEMPTED_OPERATION
-+    {"INVALID_EDDSA_INSTANCE_FOR_ATTEMPTED_OPERATION", ERR_LIB_PROV, PR=
OV_R_INVALID_EDDSA_INSTANCE_FOR_ATTEMPTED_OPERATION},
-+  #else
-+    {"INVALID_EDDSA_INSTANCE_FOR_ATTEMPTED_OPERATION", 57, 243},
-+  #endif
-   #ifdef PROV_R_INVALID_INPUT_LENGTH
-     {"INVALID_INPUT_LENGTH", ERR_LIB_PROV, PROV_R_INVALID_INPUT_LENGTH}=
,
-   #else
-@@ -5085,6 +5352,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INVALID_IV_LENGTH", 57, 109},
-   #endif
-+  #ifdef PROV_R_INVALID_KDF
-+    {"INVALID_KDF", ERR_LIB_PROV, PROV_R_INVALID_KDF},
-+  #else
-+    {"INVALID_KDF", 57, 232},
-+  #endif
-   #ifdef PROV_R_INVALID_KEY
-     {"INVALID_KEY", ERR_LIB_PROV, PROV_R_INVALID_KEY},
-   #else
-@@ -5100,6 +5372,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INVALID_MAC", 57, 151},
-   #endif
-+  #ifdef PROV_R_INVALID_MEMORY_SIZE
-+    {"INVALID_MEMORY_SIZE", ERR_LIB_PROV, PROV_R_INVALID_MEMORY_SIZE},
-+  #else
-+    {"INVALID_MEMORY_SIZE", 57, 235},
-+  #endif
-   #ifdef PROV_R_INVALID_MGF1_MD
-     {"INVALID_MGF1_MD", ERR_LIB_PROV, PROV_R_INVALID_MGF1_MD},
-   #else
-@@ -5120,6 +5397,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INVALID_PADDING_MODE", 57, 168},
-   #endif
-+  #ifdef PROV_R_INVALID_PREHASHED_DIGEST_LENGTH
-+    {"INVALID_PREHASHED_DIGEST_LENGTH", ERR_LIB_PROV, PROV_R_INVALID_PR=
EHASHED_DIGEST_LENGTH},
-+  #else
-+    {"INVALID_PREHASHED_DIGEST_LENGTH", 57, 241},
-+  #endif
-   #ifdef PROV_R_INVALID_PUBINFO
-     {"INVALID_PUBINFO", ERR_LIB_PROV, PROV_R_INVALID_PUBINFO},
-   #else
-@@ -5155,6 +5437,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INVALID_TAG_LENGTH", 57, 118},
-   #endif
-+  #ifdef PROV_R_INVALID_THREAD_POOL_SIZE
-+    {"INVALID_THREAD_POOL_SIZE", ERR_LIB_PROV, PROV_R_INVALID_THREAD_PO=
OL_SIZE},
-+  #else
-+    {"INVALID_THREAD_POOL_SIZE", 57, 234},
-+  #endif
-   #ifdef PROV_R_INVALID_UKM_LENGTH
-     {"INVALID_UKM_LENGTH", ERR_LIB_PROV, PROV_R_INVALID_UKM_LENGTH},
-   #else
-@@ -5300,6 +5587,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"NOT_XOF_OR_INVALID_LENGTH", 57, 113},
-   #endif
-+  #ifdef PROV_R_NO_INSTANCE_ALLOWED
-+    {"NO_INSTANCE_ALLOWED", ERR_LIB_PROV, PROV_R_NO_INSTANCE_ALLOWED},
-+  #else
-+    {"NO_INSTANCE_ALLOWED", 57, 242},
-+  #endif
-   #ifdef PROV_R_NO_KEY_SET
-     {"NO_KEY_SET", ERR_LIB_PROV, PROV_R_NO_KEY_SET},
-   #else
-@@ -5310,6 +5602,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"NO_PARAMETERS_SET", 57, 177},
-   #endif
-+  #ifdef PROV_R_ONESHOT_CALL_OUT_OF_ORDER
-+    {"ONESHOT_CALL_OUT_OF_ORDER", ERR_LIB_PROV, PROV_R_ONESHOT_CALL_OUT=
_OF_ORDER},
-+  #else
-+    {"ONESHOT_CALL_OUT_OF_ORDER", 57, 239},
-+  #endif
-   #ifdef PROV_R_OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE
-     {"OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE", ERR_LIB_PROV, PROV_R_O=
PERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE},
-   #else
-@@ -5460,6 +5757,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNSUPPORTED_NUMBER_OF_ROUNDS", 57, 152},
-   #endif
-+  #ifdef PROV_R_UPDATE_CALL_OUT_OF_ORDER
-+    {"UPDATE_CALL_OUT_OF_ORDER", ERR_LIB_PROV, PROV_R_UPDATE_CALL_OUT_O=
F_ORDER},
-+  #else
-+    {"UPDATE_CALL_OUT_OF_ORDER", 57, 240},
-+  #endif
-   #ifdef PROV_R_URI_AUTHORITY_UNSUPPORTED
-     {"URI_AUTHORITY_UNSUPPORTED", ERR_LIB_PROV, PROV_R_URI_AUTHORITY_UN=
SUPPORTED},
-   #else
-@@ -5595,6 +5897,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INTERNAL_ERROR", 36, 113},
-   #endif
-+  #ifdef RAND_R_INVALID_PROPERTY_QUERY
-+    {"INVALID_PROPERTY_QUERY", ERR_LIB_RAND, RAND_R_INVALID_PROPERTY_QU=
ERY},
-+  #else
-+    {"INVALID_PROPERTY_QUERY", 36, 137},
-+  #endif
-   #ifdef RAND_R_IN_ERROR_STATE
-     {"IN_ERROR_STATE", ERR_LIB_RAND, RAND_R_IN_ERROR_STATE},
-   #else
-@@ -6210,6 +6517,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"AT_LEAST_TLS_1_2_NEEDED_IN_SUITEB_MODE", 20, 158},
-   #endif
-+  #ifdef SSL_R_BAD_CERTIFICATE
-+    {"BAD_CERTIFICATE", ERR_LIB_SSL, SSL_R_BAD_CERTIFICATE},
-+  #else
-+    {"BAD_CERTIFICATE", 20, 348},
-+  #endif
-   #ifdef SSL_R_BAD_CHANGE_CIPHER_SPEC
-     {"BAD_CHANGE_CIPHER_SPEC", ERR_LIB_SSL, SSL_R_BAD_CHANGE_CIPHER_SPE=
C},
-   #else
-@@ -6220,6 +6532,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"BAD_CIPHER", 20, 186},
-   #endif
-+  #ifdef SSL_R_BAD_COMPRESSION_ALGORITHM
-+    {"BAD_COMPRESSION_ALGORITHM", ERR_LIB_SSL, SSL_R_BAD_COMPRESSION_AL=
GORITHM},
-+  #else
-+    {"BAD_COMPRESSION_ALGORITHM", 20, 326},
-+  #endif
-   #ifdef SSL_R_BAD_DATA
-     {"BAD_DATA", ERR_LIB_SSL, SSL_R_BAD_DATA},
-   #else
-@@ -6495,6 +6812,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"CONNECTION_TYPE_NOT_SET", 20, 144},
-   #endif
-+  #ifdef SSL_R_CONN_USE_ONLY
-+    {"CONN_USE_ONLY", ERR_LIB_SSL, SSL_R_CONN_USE_ONLY},
-+  #else
-+    {"CONN_USE_ONLY", 20, 356},
-+  #endif
-   #ifdef SSL_R_CONTEXT_NOT_DANE_ENABLED
-     {"CONTEXT_NOT_DANE_ENABLED", ERR_LIB_SSL, SSL_R_CONTEXT_NOT_DANE_EN=
ABLED},
-   #else
-@@ -6635,6 +6957,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"EE_KEY_TOO_SMALL", 20, 399},
-   #endif
-+  #ifdef SSL_R_EMPTY_RAW_PUBLIC_KEY
-+    {"EMPTY_RAW_PUBLIC_KEY", ERR_LIB_SSL, SSL_R_EMPTY_RAW_PUBLIC_KEY},
-+  #else
-+    {"EMPTY_RAW_PUBLIC_KEY", 20, 349},
-+  #endif
-   #ifdef SSL_R_EMPTY_SRTP_PROTECTION_PROFILE_LIST
-     {"EMPTY_SRTP_PROTECTION_PROFILE_LIST", ERR_LIB_SSL, SSL_R_EMPTY_SRT=
P_PROTECTION_PROFILE_LIST},
-   #else
-@@ -6650,6 +6977,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"ERROR_IN_RECEIVED_CIPHER_LIST", 20, 151},
-   #endif
-+  #ifdef SSL_R_ERROR_IN_SYSTEM_DEFAULT_CONFIG
-+    {"ERROR_IN_SYSTEM_DEFAULT_CONFIG", ERR_LIB_SSL, SSL_R_ERROR_IN_SYST=
EM_DEFAULT_CONFIG},
-+  #else
-+    {"ERROR_IN_SYSTEM_DEFAULT_CONFIG", 20, 419},
-+  #endif
-   #ifdef SSL_R_ERROR_SETTING_TLSA_BASE_DOMAIN
-     {"ERROR_SETTING_TLSA_BASE_DOMAIN", ERR_LIB_SSL, SSL_R_ERROR_SETTING=
_TLSA_BASE_DOMAIN},
-   #else
-@@ -6680,11 +7012,26 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"EXT_LENGTH_MISMATCH", 20, 163},
-   #endif
-+  #ifdef SSL_R_FAILED_TO_GET_PARAMETER
-+    {"FAILED_TO_GET_PARAMETER", ERR_LIB_SSL, SSL_R_FAILED_TO_GET_PARAME=
TER},
-+  #else
-+    {"FAILED_TO_GET_PARAMETER", 20, 316},
-+  #endif
-   #ifdef SSL_R_FAILED_TO_INIT_ASYNC
-     {"FAILED_TO_INIT_ASYNC", ERR_LIB_SSL, SSL_R_FAILED_TO_INIT_ASYNC},
-   #else
-     {"FAILED_TO_INIT_ASYNC", 20, 405},
-   #endif
-+  #ifdef SSL_R_FEATURE_NEGOTIATION_NOT_COMPLETE
-+    {"FEATURE_NEGOTIATION_NOT_COMPLETE", ERR_LIB_SSL, SSL_R_FEATURE_NEG=
OTIATION_NOT_COMPLETE},
-+  #else
-+    {"FEATURE_NEGOTIATION_NOT_COMPLETE", 20, 417},
-+  #endif
-+  #ifdef SSL_R_FEATURE_NOT_RENEGOTIABLE
-+    {"FEATURE_NOT_RENEGOTIABLE", ERR_LIB_SSL, SSL_R_FEATURE_NOT_RENEGOT=
IABLE},
-+  #else
-+    {"FEATURE_NOT_RENEGOTIABLE", 20, 413},
-+  #endif
-   #ifdef SSL_R_FRAGMENTED_CLIENT_HELLO
-     {"FRAGMENTED_CLIENT_HELLO", ERR_LIB_SSL, SSL_R_FRAGMENTED_CLIENT_HE=
LLO},
-   #else
-@@ -6805,6 +7152,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"INVALID_NULL_CMD_NAME", 20, 385},
-   #endif
-+  #ifdef SSL_R_INVALID_RAW_PUBLIC_KEY
-+    {"INVALID_RAW_PUBLIC_KEY", ERR_LIB_SSL, SSL_R_INVALID_RAW_PUBLIC_KE=
Y},
-+  #else
-+    {"INVALID_RAW_PUBLIC_KEY", 20, 350},
-+  #endif
-+  #ifdef SSL_R_INVALID_RECORD
-+    {"INVALID_RECORD", ERR_LIB_SSL, SSL_R_INVALID_RECORD},
-+  #else
-+    {"INVALID_RECORD", 20, 317},
-+  #endif
-   #ifdef SSL_R_INVALID_SEQUENCE_NUMBER
-     {"INVALID_SEQUENCE_NUMBER", ERR_LIB_SSL, SSL_R_INVALID_SEQUENCE_NUM=
BER},
-   #else
-@@ -6865,6 +7222,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"LIBRARY_HAS_NO_CIPHERS", 20, 161},
-   #endif
-+  #ifdef SSL_R_MAXIMUM_ENCRYPTED_PKTS_REACHED
-+    {"MAXIMUM_ENCRYPTED_PKTS_REACHED", ERR_LIB_SSL, SSL_R_MAXIMUM_ENCRY=
PTED_PKTS_REACHED},
-+  #else
-+    {"MAXIMUM_ENCRYPTED_PKTS_REACHED", 20, 395},
-+  #endif
-   #ifdef SSL_R_MISSING_DSA_SIGNING_CERT
-     {"MISSING_DSA_SIGNING_CERT", ERR_LIB_SSL, SSL_R_MISSING_DSA_SIGNING=
_CERT},
-   #else
-@@ -6925,6 +7287,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"MISSING_SUPPORTED_GROUPS_EXTENSION", 20, 209},
-   #endif
-+  #ifdef SSL_R_MISSING_SUPPORTED_VERSIONS_EXTENSION
-+    {"MISSING_SUPPORTED_VERSIONS_EXTENSION", ERR_LIB_SSL, SSL_R_MISSING=
_SUPPORTED_VERSIONS_EXTENSION},
-+  #else
-+    {"MISSING_SUPPORTED_VERSIONS_EXTENSION", 20, 420},
-+  #endif
-   #ifdef SSL_R_MISSING_TMP_DH_KEY
-     {"MISSING_TMP_DH_KEY", ERR_LIB_SSL, SSL_R_MISSING_TMP_DH_KEY},
-   #else
-@@ -7065,6 +7432,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"NO_SRTP_PROFILES", 20, 359},
-   #endif
-+  #ifdef SSL_R_NO_STREAM
-+    {"NO_STREAM", ERR_LIB_SSL, SSL_R_NO_STREAM},
-+  #else
-+    {"NO_STREAM", 20, 355},
-+  #endif
-   #ifdef SSL_R_NO_SUITABLE_DIGEST_ALGORITHM
-     {"NO_SUITABLE_DIGEST_ALGORITHM", ERR_LIB_SSL, SSL_R_NO_SUITABLE_DIG=
EST_ALGORITHM},
-   #else
-@@ -7080,6 +7452,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"NO_SUITABLE_KEY_SHARE", 20, 101},
-   #endif
-+  #ifdef SSL_R_NO_SUITABLE_RECORD_LAYER
-+    {"NO_SUITABLE_RECORD_LAYER", ERR_LIB_SSL, SSL_R_NO_SUITABLE_RECORD_=
LAYER},
-+  #else
-+    {"NO_SUITABLE_RECORD_LAYER", 20, 322},
-+  #endif
-   #ifdef SSL_R_NO_SUITABLE_SIGNATURE_ALGORITHM
-     {"NO_SUITABLE_SIGNATURE_ALGORITHM", ERR_LIB_SSL, SSL_R_NO_SUITABLE_=
SIGNATURE_ALGORITHM},
-   #else
-@@ -7160,6 +7537,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"PIPELINE_FAILURE", 20, 406},
-   #endif
-+  #ifdef SSL_R_POLL_REQUEST_NOT_SUPPORTED
-+    {"POLL_REQUEST_NOT_SUPPORTED", ERR_LIB_SSL, SSL_R_POLL_REQUEST_NOT_=
SUPPORTED},
-+  #else
-+    {"POLL_REQUEST_NOT_SUPPORTED", 20, 418},
-+  #endif
-   #ifdef SSL_R_POST_HANDSHAKE_AUTH_ENCODING_ERR
-     {"POST_HANDSHAKE_AUTH_ENCODING_ERR", ERR_LIB_SSL, SSL_R_POST_HANDSH=
AKE_AUTH_ENCODING_ERR},
-   #else
-@@ -7190,6 +7572,21 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"PSK_NO_SERVER_CB", 20, 225},
-   #endif
-+  #ifdef SSL_R_QUIC_HANDSHAKE_LAYER_ERROR
-+    {"QUIC_HANDSHAKE_LAYER_ERROR", ERR_LIB_SSL, SSL_R_QUIC_HANDSHAKE_LA=
YER_ERROR},
-+  #else
-+    {"QUIC_HANDSHAKE_LAYER_ERROR", 20, 393},
-+  #endif
-+  #ifdef SSL_R_QUIC_NETWORK_ERROR
-+    {"QUIC_NETWORK_ERROR", ERR_LIB_SSL, SSL_R_QUIC_NETWORK_ERROR},
-+  #else
-+    {"QUIC_NETWORK_ERROR", 20, 387},
-+  #endif
-+  #ifdef SSL_R_QUIC_PROTOCOL_ERROR
-+    {"QUIC_PROTOCOL_ERROR", ERR_LIB_SSL, SSL_R_QUIC_PROTOCOL_ERROR},
-+  #else
-+    {"QUIC_PROTOCOL_ERROR", 20, 382},
-+  #endif
-   #ifdef SSL_R_READ_BIO_NOT_SET
-     {"READ_BIO_NOT_SET", ERR_LIB_SSL, SSL_R_READ_BIO_NOT_SET},
-   #else
-@@ -7200,6 +7597,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"READ_TIMEOUT_EXPIRED", 20, 312},
-   #endif
-+  #ifdef SSL_R_RECORDS_NOT_RELEASED
-+    {"RECORDS_NOT_RELEASED", ERR_LIB_SSL, SSL_R_RECORDS_NOT_RELEASED},
-+  #else
-+    {"RECORDS_NOT_RELEASED", 20, 321},
-+  #endif
-+  #ifdef SSL_R_RECORD_LAYER_FAILURE
-+    {"RECORD_LAYER_FAILURE", ERR_LIB_SSL, SSL_R_RECORD_LAYER_FAILURE},
-+  #else
-+    {"RECORD_LAYER_FAILURE", 20, 313},
-+  #endif
-   #ifdef SSL_R_RECORD_LENGTH_MISMATCH
-     {"RECORD_LENGTH_MISMATCH", ERR_LIB_SSL, SSL_R_RECORD_LENGTH_MISMATC=
H},
-   #else
-@@ -7210,6 +7617,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"RECORD_TOO_SMALL", 20, 298},
-   #endif
-+  #ifdef SSL_R_REMOTE_PEER_ADDRESS_NOT_SET
-+    {"REMOTE_PEER_ADDRESS_NOT_SET", ERR_LIB_SSL, SSL_R_REMOTE_PEER_ADDR=
ESS_NOT_SET},
-+  #else
-+    {"REMOTE_PEER_ADDRESS_NOT_SET", 20, 346},
-+  #endif
-   #ifdef SSL_R_RENEGOTIATE_EXT_TOO_LONG
-     {"RENEGOTIATE_EXT_TOO_LONG", ERR_LIB_SSL, SSL_R_RENEGOTIATE_EXT_TOO=
_LONG},
-   #else
-@@ -7255,6 +7667,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"SCT_VERIFICATION_FAILED", 20, 208},
-   #endif
-+  #ifdef SSL_R_SEQUENCE_CTR_WRAPPED
-+    {"SEQUENCE_CTR_WRAPPED", ERR_LIB_SSL, SSL_R_SEQUENCE_CTR_WRAPPED},
-+  #else
-+    {"SEQUENCE_CTR_WRAPPED", 20, 327},
-+  #endif
-   #ifdef SSL_R_SERVERHELLO_TLSEXT
-     {"SERVERHELLO_TLSEXT", ERR_LIB_SSL, SSL_R_SERVERHELLO_TLSEXT},
-   #else
-@@ -7325,6 +7742,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"SSLV3_ALERT_BAD_CERTIFICATE", 20, 1042},
-   #endif
-+  #ifdef SSL_R_SSLV3_ALERT_BAD_CERTIFICATE
-+    {"SSLV3_ALERT_BAD_CERTIFICATE", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_BAD_=
CERTIFICATE},
-+  #else
-+    {"SSLV3_ALERT_BAD_CERTIFICATE", 20, 1042},
-+  #endif
-+  #ifdef SSL_R_SSLV3_ALERT_BAD_RECORD_MAC
-+    {"SSLV3_ALERT_BAD_RECORD_MAC", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_BAD_R=
ECORD_MAC},
-+  #else
-+    {"SSLV3_ALERT_BAD_RECORD_MAC", 20, 1020},
-+  #endif
-   #ifdef SSL_R_SSLV3_ALERT_BAD_RECORD_MAC
-     {"SSLV3_ALERT_BAD_RECORD_MAC", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_BAD_R=
ECORD_MAC},
-   #else
-@@ -7335,11 +7762,26 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"SSLV3_ALERT_CERTIFICATE_EXPIRED", 20, 1045},
-   #endif
-+  #ifdef SSL_R_SSLV3_ALERT_CERTIFICATE_EXPIRED
-+    {"SSLV3_ALERT_CERTIFICATE_EXPIRED", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_=
CERTIFICATE_EXPIRED},
-+  #else
-+    {"SSLV3_ALERT_CERTIFICATE_EXPIRED", 20, 1045},
-+  #endif
-   #ifdef SSL_R_SSLV3_ALERT_CERTIFICATE_REVOKED
-     {"SSLV3_ALERT_CERTIFICATE_REVOKED", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_=
CERTIFICATE_REVOKED},
-   #else
-     {"SSLV3_ALERT_CERTIFICATE_REVOKED", 20, 1044},
-   #endif
-+  #ifdef SSL_R_SSLV3_ALERT_CERTIFICATE_REVOKED
-+    {"SSLV3_ALERT_CERTIFICATE_REVOKED", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_=
CERTIFICATE_REVOKED},
-+  #else
-+    {"SSLV3_ALERT_CERTIFICATE_REVOKED", 20, 1044},
-+  #endif
-+  #ifdef SSL_R_SSLV3_ALERT_CERTIFICATE_UNKNOWN
-+    {"SSLV3_ALERT_CERTIFICATE_UNKNOWN", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_=
CERTIFICATE_UNKNOWN},
-+  #else
-+    {"SSLV3_ALERT_CERTIFICATE_UNKNOWN", 20, 1046},
-+  #endif
-   #ifdef SSL_R_SSLV3_ALERT_CERTIFICATE_UNKNOWN
-     {"SSLV3_ALERT_CERTIFICATE_UNKNOWN", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_=
CERTIFICATE_UNKNOWN},
-   #else
-@@ -7350,6 +7792,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"SSLV3_ALERT_DECOMPRESSION_FAILURE", 20, 1030},
-   #endif
-+  #ifdef SSL_R_SSLV3_ALERT_DECOMPRESSION_FAILURE
-+    {"SSLV3_ALERT_DECOMPRESSION_FAILURE", ERR_LIB_SSL, SSL_R_SSLV3_ALER=
T_DECOMPRESSION_FAILURE},
-+  #else
-+    {"SSLV3_ALERT_DECOMPRESSION_FAILURE", 20, 1030},
-+  #endif
-+  #ifdef SSL_R_SSLV3_ALERT_HANDSHAKE_FAILURE
-+    {"SSLV3_ALERT_HANDSHAKE_FAILURE", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_HA=
NDSHAKE_FAILURE},
-+  #else
-+    {"SSLV3_ALERT_HANDSHAKE_FAILURE", 20, 1040},
-+  #endif
-   #ifdef SSL_R_SSLV3_ALERT_HANDSHAKE_FAILURE
-     {"SSLV3_ALERT_HANDSHAKE_FAILURE", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_HA=
NDSHAKE_FAILURE},
-   #else
-@@ -7360,11 +7812,26 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"SSLV3_ALERT_ILLEGAL_PARAMETER", 20, 1047},
-   #endif
-+  #ifdef SSL_R_SSLV3_ALERT_ILLEGAL_PARAMETER
-+    {"SSLV3_ALERT_ILLEGAL_PARAMETER", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_IL=
LEGAL_PARAMETER},
-+  #else
-+    {"SSLV3_ALERT_ILLEGAL_PARAMETER", 20, 1047},
-+  #endif
-   #ifdef SSL_R_SSLV3_ALERT_NO_CERTIFICATE
-     {"SSLV3_ALERT_NO_CERTIFICATE", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_NO_CE=
RTIFICATE},
-   #else
-     {"SSLV3_ALERT_NO_CERTIFICATE", 20, 1041},
-   #endif
-+  #ifdef SSL_R_SSLV3_ALERT_NO_CERTIFICATE
-+    {"SSLV3_ALERT_NO_CERTIFICATE", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_NO_CE=
RTIFICATE},
-+  #else
-+    {"SSLV3_ALERT_NO_CERTIFICATE", 20, 1041},
-+  #endif
-+  #ifdef SSL_R_SSLV3_ALERT_UNEXPECTED_MESSAGE
-+    {"SSLV3_ALERT_UNEXPECTED_MESSAGE", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_U=
NEXPECTED_MESSAGE},
-+  #else
-+    {"SSLV3_ALERT_UNEXPECTED_MESSAGE", 20, 1010},
-+  #endif
-   #ifdef SSL_R_SSLV3_ALERT_UNEXPECTED_MESSAGE
-     {"SSLV3_ALERT_UNEXPECTED_MESSAGE", ERR_LIB_SSL, SSL_R_SSLV3_ALERT_U=
NEXPECTED_MESSAGE},
-   #else
-@@ -7375,6 +7842,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"SSLV3_ALERT_UNSUPPORTED_CERTIFICATE", 20, 1043},
-   #endif
-+  #ifdef SSL_R_SSLV3_ALERT_UNSUPPORTED_CERTIFICATE
-+    {"SSLV3_ALERT_UNSUPPORTED_CERTIFICATE", ERR_LIB_SSL, SSL_R_SSLV3_AL=
ERT_UNSUPPORTED_CERTIFICATE},
-+  #else
-+    {"SSLV3_ALERT_UNSUPPORTED_CERTIFICATE", 20, 1043},
-+  #endif
-   #ifdef SSL_R_SSL_COMMAND_SECTION_EMPTY
-     {"SSL_COMMAND_SECTION_EMPTY", ERR_LIB_SSL, SSL_R_SSL_COMMAND_SECTIO=
N_EMPTY},
-   #else
-@@ -7450,6 +7922,36 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"STILL_IN_INIT", 20, 121},
-   #endif
-+  #ifdef SSL_R_STREAM_COUNT_LIMITED
-+    {"STREAM_COUNT_LIMITED", ERR_LIB_SSL, SSL_R_STREAM_COUNT_LIMITED},
-+  #else
-+    {"STREAM_COUNT_LIMITED", 20, 411},
-+  #endif
-+  #ifdef SSL_R_STREAM_FINISHED
-+    {"STREAM_FINISHED", ERR_LIB_SSL, SSL_R_STREAM_FINISHED},
-+  #else
-+    {"STREAM_FINISHED", 20, 365},
-+  #endif
-+  #ifdef SSL_R_STREAM_RECV_ONLY
-+    {"STREAM_RECV_ONLY", ERR_LIB_SSL, SSL_R_STREAM_RECV_ONLY},
-+  #else
-+    {"STREAM_RECV_ONLY", 20, 366},
-+  #endif
-+  #ifdef SSL_R_STREAM_RESET
-+    {"STREAM_RESET", ERR_LIB_SSL, SSL_R_STREAM_RESET},
-+  #else
-+    {"STREAM_RESET", 20, 375},
-+  #endif
-+  #ifdef SSL_R_STREAM_SEND_ONLY
-+    {"STREAM_SEND_ONLY", ERR_LIB_SSL, SSL_R_STREAM_SEND_ONLY},
-+  #else
-+    {"STREAM_SEND_ONLY", 20, 379},
-+  #endif
-+  #ifdef SSL_R_TLSV13_ALERT_CERTIFICATE_REQUIRED
-+    {"TLSV13_ALERT_CERTIFICATE_REQUIRED", ERR_LIB_SSL, SSL_R_TLSV13_ALE=
RT_CERTIFICATE_REQUIRED},
-+  #else
-+    {"TLSV13_ALERT_CERTIFICATE_REQUIRED", 20, 1116},
-+  #endif
-   #ifdef SSL_R_TLSV13_ALERT_CERTIFICATE_REQUIRED
-     {"TLSV13_ALERT_CERTIFICATE_REQUIRED", ERR_LIB_SSL, SSL_R_TLSV13_ALE=
RT_CERTIFICATE_REQUIRED},
-   #else
-@@ -7460,6 +7962,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TLSV13_ALERT_MISSING_EXTENSION", 20, 1109},
-   #endif
-+  #ifdef SSL_R_TLSV13_ALERT_MISSING_EXTENSION
-+    {"TLSV13_ALERT_MISSING_EXTENSION", ERR_LIB_SSL, SSL_R_TLSV13_ALERT_=
MISSING_EXTENSION},
-+  #else
-+    {"TLSV13_ALERT_MISSING_EXTENSION", 20, 1109},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_ACCESS_DENIED
-+    {"TLSV1_ALERT_ACCESS_DENIED", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_ACCESS=
_DENIED},
-+  #else
-+    {"TLSV1_ALERT_ACCESS_DENIED", 20, 1049},
-+  #endif
-   #ifdef SSL_R_TLSV1_ALERT_ACCESS_DENIED
-     {"TLSV1_ALERT_ACCESS_DENIED", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_ACCESS=
_DENIED},
-   #else
-@@ -7470,6 +7982,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TLSV1_ALERT_DECODE_ERROR", 20, 1050},
-   #endif
-+  #ifdef SSL_R_TLSV1_ALERT_DECODE_ERROR
-+    {"TLSV1_ALERT_DECODE_ERROR", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_DECODE_=
ERROR},
-+  #else
-+    {"TLSV1_ALERT_DECODE_ERROR", 20, 1050},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_DECRYPTION_FAILED
-+    {"TLSV1_ALERT_DECRYPTION_FAILED", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_DE=
CRYPTION_FAILED},
-+  #else
-+    {"TLSV1_ALERT_DECRYPTION_FAILED", 20, 1021},
-+  #endif
-   #ifdef SSL_R_TLSV1_ALERT_DECRYPTION_FAILED
-     {"TLSV1_ALERT_DECRYPTION_FAILED", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_DE=
CRYPTION_FAILED},
-   #else
-@@ -7480,6 +8002,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TLSV1_ALERT_DECRYPT_ERROR", 20, 1051},
-   #endif
-+  #ifdef SSL_R_TLSV1_ALERT_DECRYPT_ERROR
-+    {"TLSV1_ALERT_DECRYPT_ERROR", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_DECRYP=
T_ERROR},
-+  #else
-+    {"TLSV1_ALERT_DECRYPT_ERROR", 20, 1051},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_EXPORT_RESTRICTION
-+    {"TLSV1_ALERT_EXPORT_RESTRICTION", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_E=
XPORT_RESTRICTION},
-+  #else
-+    {"TLSV1_ALERT_EXPORT_RESTRICTION", 20, 1060},
-+  #endif
-   #ifdef SSL_R_TLSV1_ALERT_EXPORT_RESTRICTION
-     {"TLSV1_ALERT_EXPORT_RESTRICTION", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_E=
XPORT_RESTRICTION},
-   #else
-@@ -7490,6 +8022,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TLSV1_ALERT_INAPPROPRIATE_FALLBACK", 20, 1086},
-   #endif
-+  #ifdef SSL_R_TLSV1_ALERT_INAPPROPRIATE_FALLBACK
-+    {"TLSV1_ALERT_INAPPROPRIATE_FALLBACK", ERR_LIB_SSL, SSL_R_TLSV1_ALE=
RT_INAPPROPRIATE_FALLBACK},
-+  #else
-+    {"TLSV1_ALERT_INAPPROPRIATE_FALLBACK", 20, 1086},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_INSUFFICIENT_SECURITY
-+    {"TLSV1_ALERT_INSUFFICIENT_SECURITY", ERR_LIB_SSL, SSL_R_TLSV1_ALER=
T_INSUFFICIENT_SECURITY},
-+  #else
-+    {"TLSV1_ALERT_INSUFFICIENT_SECURITY", 20, 1071},
-+  #endif
-   #ifdef SSL_R_TLSV1_ALERT_INSUFFICIENT_SECURITY
-     {"TLSV1_ALERT_INSUFFICIENT_SECURITY", ERR_LIB_SSL, SSL_R_TLSV1_ALER=
T_INSUFFICIENT_SECURITY},
-   #else
-@@ -7500,6 +8042,26 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TLSV1_ALERT_INTERNAL_ERROR", 20, 1080},
-   #endif
-+  #ifdef SSL_R_TLSV1_ALERT_INTERNAL_ERROR
-+    {"TLSV1_ALERT_INTERNAL_ERROR", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_INTER=
NAL_ERROR},
-+  #else
-+    {"TLSV1_ALERT_INTERNAL_ERROR", 20, 1080},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_NO_APPLICATION_PROTOCOL
-+    {"TLSV1_ALERT_NO_APPLICATION_PROTOCOL", ERR_LIB_SSL, SSL_R_TLSV1_AL=
ERT_NO_APPLICATION_PROTOCOL},
-+  #else
-+    {"TLSV1_ALERT_NO_APPLICATION_PROTOCOL", 20, 1120},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_NO_APPLICATION_PROTOCOL
-+    {"TLSV1_ALERT_NO_APPLICATION_PROTOCOL", ERR_LIB_SSL, SSL_R_TLSV1_AL=
ERT_NO_APPLICATION_PROTOCOL},
-+  #else
-+    {"TLSV1_ALERT_NO_APPLICATION_PROTOCOL", 20, 1120},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_NO_RENEGOTIATION
-+    {"TLSV1_ALERT_NO_RENEGOTIATION", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_NO_=
RENEGOTIATION},
-+  #else
-+    {"TLSV1_ALERT_NO_RENEGOTIATION", 20, 1100},
-+  #endif
-   #ifdef SSL_R_TLSV1_ALERT_NO_RENEGOTIATION
-     {"TLSV1_ALERT_NO_RENEGOTIATION", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_NO_=
RENEGOTIATION},
-   #else
-@@ -7510,21 +8072,56 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TLSV1_ALERT_PROTOCOL_VERSION", 20, 1070},
-   #endif
-+  #ifdef SSL_R_TLSV1_ALERT_PROTOCOL_VERSION
-+    {"TLSV1_ALERT_PROTOCOL_VERSION", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_PRO=
TOCOL_VERSION},
-+  #else
-+    {"TLSV1_ALERT_PROTOCOL_VERSION", 20, 1070},
-+  #endif
-   #ifdef SSL_R_TLSV1_ALERT_RECORD_OVERFLOW
-     {"TLSV1_ALERT_RECORD_OVERFLOW", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_RECO=
RD_OVERFLOW},
-   #else
-     {"TLSV1_ALERT_RECORD_OVERFLOW", 20, 1022},
-   #endif
-+  #ifdef SSL_R_TLSV1_ALERT_RECORD_OVERFLOW
-+    {"TLSV1_ALERT_RECORD_OVERFLOW", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_RECO=
RD_OVERFLOW},
-+  #else
-+    {"TLSV1_ALERT_RECORD_OVERFLOW", 20, 1022},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_UNKNOWN_CA
-+    {"TLSV1_ALERT_UNKNOWN_CA", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_UNKNOWN_C=
A},
-+  #else
-+    {"TLSV1_ALERT_UNKNOWN_CA", 20, 1048},
-+  #endif
-   #ifdef SSL_R_TLSV1_ALERT_UNKNOWN_CA
-     {"TLSV1_ALERT_UNKNOWN_CA", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_UNKNOWN_C=
A},
-   #else
-     {"TLSV1_ALERT_UNKNOWN_CA", 20, 1048},
-   #endif
-+  #ifdef SSL_R_TLSV1_ALERT_UNKNOWN_PSK_IDENTITY
-+    {"TLSV1_ALERT_UNKNOWN_PSK_IDENTITY", ERR_LIB_SSL, SSL_R_TLSV1_ALERT=
_UNKNOWN_PSK_IDENTITY},
-+  #else
-+    {"TLSV1_ALERT_UNKNOWN_PSK_IDENTITY", 20, 1115},
-+  #endif
-+  #ifdef SSL_R_TLSV1_ALERT_UNKNOWN_PSK_IDENTITY
-+    {"TLSV1_ALERT_UNKNOWN_PSK_IDENTITY", ERR_LIB_SSL, SSL_R_TLSV1_ALERT=
_UNKNOWN_PSK_IDENTITY},
-+  #else
-+    {"TLSV1_ALERT_UNKNOWN_PSK_IDENTITY", 20, 1115},
-+  #endif
-   #ifdef SSL_R_TLSV1_ALERT_USER_CANCELLED
-     {"TLSV1_ALERT_USER_CANCELLED", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_USER_=
CANCELLED},
-   #else
-     {"TLSV1_ALERT_USER_CANCELLED", 20, 1090},
-   #endif
-+  #ifdef SSL_R_TLSV1_ALERT_USER_CANCELLED
-+    {"TLSV1_ALERT_USER_CANCELLED", ERR_LIB_SSL, SSL_R_TLSV1_ALERT_USER_=
CANCELLED},
-+  #else
-+    {"TLSV1_ALERT_USER_CANCELLED", 20, 1090},
-+  #endif
-+  #ifdef SSL_R_TLSV1_BAD_CERTIFICATE_HASH_VALUE
-+    {"TLSV1_BAD_CERTIFICATE_HASH_VALUE", ERR_LIB_SSL, SSL_R_TLSV1_BAD_C=
ERTIFICATE_HASH_VALUE},
-+  #else
-+    {"TLSV1_BAD_CERTIFICATE_HASH_VALUE", 20, 1114},
-+  #endif
-   #ifdef SSL_R_TLSV1_BAD_CERTIFICATE_HASH_VALUE
-     {"TLSV1_BAD_CERTIFICATE_HASH_VALUE", ERR_LIB_SSL, SSL_R_TLSV1_BAD_C=
ERTIFICATE_HASH_VALUE},
-   #else
-@@ -7535,6 +8132,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TLSV1_BAD_CERTIFICATE_STATUS_RESPONSE", 20, 1113},
-   #endif
-+  #ifdef SSL_R_TLSV1_BAD_CERTIFICATE_STATUS_RESPONSE
-+    {"TLSV1_BAD_CERTIFICATE_STATUS_RESPONSE", ERR_LIB_SSL, SSL_R_TLSV1_=
BAD_CERTIFICATE_STATUS_RESPONSE},
-+  #else
-+    {"TLSV1_BAD_CERTIFICATE_STATUS_RESPONSE", 20, 1113},
-+  #endif
-+  #ifdef SSL_R_TLSV1_CERTIFICATE_UNOBTAINABLE
-+    {"TLSV1_CERTIFICATE_UNOBTAINABLE", ERR_LIB_SSL, SSL_R_TLSV1_CERTIFI=
CATE_UNOBTAINABLE},
-+  #else
-+    {"TLSV1_CERTIFICATE_UNOBTAINABLE", 20, 1111},
-+  #endif
-   #ifdef SSL_R_TLSV1_CERTIFICATE_UNOBTAINABLE
-     {"TLSV1_CERTIFICATE_UNOBTAINABLE", ERR_LIB_SSL, SSL_R_TLSV1_CERTIFI=
CATE_UNOBTAINABLE},
-   #else
-@@ -7545,6 +8152,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"TLSV1_UNRECOGNIZED_NAME", 20, 1112},
-   #endif
-+  #ifdef SSL_R_TLSV1_UNRECOGNIZED_NAME
-+    {"TLSV1_UNRECOGNIZED_NAME", ERR_LIB_SSL, SSL_R_TLSV1_UNRECOGNIZED_N=
AME},
-+  #else
-+    {"TLSV1_UNRECOGNIZED_NAME", 20, 1112},
-+  #endif
-+  #ifdef SSL_R_TLSV1_UNSUPPORTED_EXTENSION
-+    {"TLSV1_UNSUPPORTED_EXTENSION", ERR_LIB_SSL, SSL_R_TLSV1_UNSUPPORTE=
D_EXTENSION},
-+  #else
-+    {"TLSV1_UNSUPPORTED_EXTENSION", 20, 1110},
-+  #endif
-   #ifdef SSL_R_TLSV1_UNSUPPORTED_EXTENSION
-     {"TLSV1_UNSUPPORTED_EXTENSION", ERR_LIB_SSL, SSL_R_TLSV1_UNSUPPORTE=
D_EXTENSION},
-   #else
-@@ -7665,6 +8282,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNKNOWN_KEY_EXCHANGE_TYPE", 20, 250},
-   #endif
-+  #ifdef SSL_R_UNKNOWN_MANDATORY_PARAMETER
-+    {"UNKNOWN_MANDATORY_PARAMETER", ERR_LIB_SSL, SSL_R_UNKNOWN_MANDATOR=
Y_PARAMETER},
-+  #else
-+    {"UNKNOWN_MANDATORY_PARAMETER", 20, 323},
-+  #endif
-   #ifdef SSL_R_UNKNOWN_PKEY_TYPE
-     {"UNKNOWN_PKEY_TYPE", ERR_LIB_SSL, SSL_R_UNKNOWN_PKEY_TYPE},
-   #else
-@@ -7700,6 +8322,21 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNSUPPORTED_COMPRESSION_ALGORITHM", 20, 257},
-   #endif
-+  #ifdef SSL_R_UNSUPPORTED_CONFIG_VALUE
-+    {"UNSUPPORTED_CONFIG_VALUE", ERR_LIB_SSL, SSL_R_UNSUPPORTED_CONFIG_=
VALUE},
-+  #else
-+    {"UNSUPPORTED_CONFIG_VALUE", 20, 414},
-+  #endif
-+  #ifdef SSL_R_UNSUPPORTED_CONFIG_VALUE_CLASS
-+    {"UNSUPPORTED_CONFIG_VALUE_CLASS", ERR_LIB_SSL, SSL_R_UNSUPPORTED_C=
ONFIG_VALUE_CLASS},
-+  #else
-+    {"UNSUPPORTED_CONFIG_VALUE_CLASS", 20, 415},
-+  #endif
-+  #ifdef SSL_R_UNSUPPORTED_CONFIG_VALUE_OP
-+    {"UNSUPPORTED_CONFIG_VALUE_OP", ERR_LIB_SSL, SSL_R_UNSUPPORTED_CONF=
IG_VALUE_OP},
-+  #else
-+    {"UNSUPPORTED_CONFIG_VALUE_OP", 20, 416},
-+  #endif
-   #ifdef SSL_R_UNSUPPORTED_ELLIPTIC_CURVE
-     {"UNSUPPORTED_ELLIPTIC_CURVE", ERR_LIB_SSL, SSL_R_UNSUPPORTED_ELLIP=
TIC_CURVE},
-   #else
-@@ -7720,6 +8357,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNSUPPORTED_STATUS_TYPE", 20, 329},
-   #endif
-+  #ifdef SSL_R_UNSUPPORTED_WRITE_FLAG
-+    {"UNSUPPORTED_WRITE_FLAG", ERR_LIB_SSL, SSL_R_UNSUPPORTED_WRITE_FLA=
G},
-+  #else
-+    {"UNSUPPORTED_WRITE_FLAG", 20, 412},
-+  #endif
-   #ifdef SSL_R_USE_SRTP_NOT_NEGOTIATED
-     {"USE_SRTP_NOT_NEGOTIATED", ERR_LIB_SSL, SSL_R_USE_SRTP_NOT_NEGOTIA=
TED},
-   #else
-@@ -7750,6 +8392,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"WRONG_CURVE", 20, 378},
-   #endif
-+  #ifdef SSL_R_WRONG_RPK_TYPE
-+    {"WRONG_RPK_TYPE", ERR_LIB_SSL, SSL_R_WRONG_RPK_TYPE},
-+  #else
-+    {"WRONG_RPK_TYPE", 20, 351},
-+  #endif
-   #ifdef SSL_R_WRONG_SIGNATURE_LENGTH
-     {"WRONG_SIGNATURE_LENGTH", ERR_LIB_SSL, SSL_R_WRONG_SIGNATURE_LENGT=
H},
-   #else
-@@ -8055,6 +8702,16 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"BAD_OBJECT", 34, 119},
-   #endif
-+  #ifdef X509V3_R_BAD_OPTION
-+    {"BAD_OPTION", ERR_LIB_X509V3, X509V3_R_BAD_OPTION},
-+  #else
-+    {"BAD_OPTION", 34, 170},
-+  #endif
-+  #ifdef X509V3_R_BAD_VALUE
-+    {"BAD_VALUE", ERR_LIB_X509V3, X509V3_R_BAD_VALUE},
-+  #else
-+    {"BAD_VALUE", 34, 171},
-+  #endif
-   #ifdef X509V3_R_BN_DEC2BN_ERROR
-     {"BN_DEC2BN_ERROR", ERR_LIB_X509V3, X509V3_R_BN_DEC2BN_ERROR},
-   #else
-@@ -8370,6 +9027,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNKNOWN_OPTION", 34, 120},
-   #endif
-+  #ifdef X509V3_R_UNKNOWN_VALUE
-+    {"UNKNOWN_VALUE", ERR_LIB_X509V3, X509V3_R_UNKNOWN_VALUE},
-+  #else
-+    {"UNKNOWN_VALUE", 34, 172},
-+  #endif
-   #ifdef X509V3_R_UNSUPPORTED_OPTION
-     {"UNSUPPORTED_OPTION", ERR_LIB_X509V3, X509V3_R_UNSUPPORTED_OPTION}=
,
-   #else
-@@ -8430,6 +9092,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"CRL_VERIFY_FAILURE", 11, 131},
-   #endif
-+  #ifdef X509_R_DUPLICATE_ATTRIBUTE
-+    {"DUPLICATE_ATTRIBUTE", ERR_LIB_X509, X509_R_DUPLICATE_ATTRIBUTE},
-+  #else
-+    {"DUPLICATE_ATTRIBUTE", 11, 140},
-+  #endif
-   #ifdef X509_R_ERROR_GETTING_MD_BY_NID
-     {"ERROR_GETTING_MD_BY_NID", ERR_LIB_X509, X509_R_ERROR_GETTING_MD_B=
Y_NID},
-   #else
-@@ -8590,6 +9257,11 @@ static struct py_ssl_error_code error_codes[] =3D=
 {
-   #else
-     {"UNSUPPORTED_ALGORITHM", 11, 111},
-   #endif
-+  #ifdef X509_R_UNSUPPORTED_VERSION
-+    {"UNSUPPORTED_VERSION", ERR_LIB_X509, X509_R_UNSUPPORTED_VERSION},
-+  #else
-+    {"UNSUPPORTED_VERSION", 11, 145},
-+  #endif
-   #ifdef X509_R_WRONG_LOOKUP_TYPE
-     {"WRONG_LOOKUP_TYPE", ERR_LIB_X509, X509_R_WRONG_LOOKUP_TYPE},
-   #else
-diff --git a/Tools/c-analyzer/cpython/_parser.py b/Tools/c-analyzer/cpyt=
hon/_parser.py
-index 21be53e7884..a08b32fa45d 100644
---- a/Tools/c-analyzer/cpython/_parser.py
-+++ b/Tools/c-analyzer/cpython/_parser.py
-@@ -70,9 +70,7 @@ Python/thread_pthread.h
- Python/thread_pthread_stubs.h
-=20
- # only huge constants (safe but parsing is slow)
--Modules/_ssl_data_31.h
--Modules/_ssl_data_300.h
--Modules/_ssl_data_111.h
-+Modules/_ssl_data_*.h
- Modules/cjkcodecs/mappings_*.h
- Modules/unicodedata_db.h
- Modules/unicodename_db.h
-diff --git a/Tools/ssl/make_ssl_data.py b/Tools/ssl/make_ssl_data.py
-index 9860871..0cd05c7 100755
---- a/Tools/ssl/make_ssl_data.py
-+++ b/Tools/ssl/make_ssl_data.py
-@@ -5,9 +5,28 @@ This script should be called *manually* when we want to=
 upgrade SSLError
- `library` and `reason` mnemonics to a more recent OpenSSL version.
-=20
- It takes two arguments:
--- the path to the OpenSSL source tree (e.g. git checkout)
-+- the path to the OpenSSL git checkout
- - the path to the header file to be generated Modules/_ssl_data_{versio=
n}.h
- - error codes are version specific
-+
-+The OpenSSL git checkout should be at a specific tag, using commands li=
ke:
-+    git tag --list 'openssl-*'
-+    git switch --detach openssl-3.4.0
-+
-+
-+After generating the definitions, compare the result with newest pre-ex=
isting file.
-+You can use a command like:
-+
-+    git diff --no-index Modules/_ssl_data_31.h Modules/_ssl_data_34.h
-+
-+- If the new version *only* adds new definitions, remove the pre-existi=
ng file
-+  and adjust the #include in _ssl.c to point to the new version.
-+- If the new version removes or renumbers some definitions, keep both f=
iles and
-+  add a new #include in _ssl.c.
-+
-+A newly supported OpenSSL version should also be added to:
-+- Tools/ssl/multissltests.py
-+- .github/workflows/build.yml
- """
-=20
- import argparse
-@@ -16,6 +35,7 @@ import operator
- import os
- import re
- import sys
-+import subprocess
-=20
-=20
- parser =3D argparse.ArgumentParser(
-@@ -118,9 +138,17 @@ def main():
-     # sort by libname, numeric error code
-     args.reasons =3D sorted(reasons, key=3Doperator.itemgetter(0, 3))
-=20
-+    git_describe =3D subprocess.run(
-+        ['git', 'describe', '--long', '--dirty'],
-+        cwd=3Dargs.srcdir,
-+        capture_output=3DTrue,
-+        encoding=3D'utf-8',
-+        check=3DTrue,
-+        )
-     lines =3D [
--        "/* File generated by Tools/ssl/make_ssl_data.py */"
--        f"/* Generated on {datetime.datetime.utcnow().isoformat()} */"
-+        "/* File generated by Tools/ssl/make_ssl_data.py */",
-+        f"/* Generated on {datetime.datetime.now(datetime.UTC).isoforma=
t()} */",
-+        f"/* Generated from Git commit {git_describe.stdout.strip()} */=
",
-     ]
-     lines.extend(gen_library_codes(args))
-     lines.append("")
-diff --git a/Tools/ssl/multissltests.py b/Tools/ssl/multissltests.py
-index eae0e0c..fb06f63 100755
---- a/Tools/ssl/multissltests.py
-+++ b/Tools/ssl/multissltests.py
-@@ -51,6 +51,7 @@ OPENSSL_RECENT_VERSIONS =3D [
-     "3.1.7",
-     "3.2.6",
-     "3.3.5",
-+    "3.4.0",
- ]
-=20
- LIBRESSL_OLD_VERSIONS =3D [
---=20
-2.30.2
-
diff --git a/recipes-devtools/python/python3/0001-Lib-pty.py-handle-stdin=
-I-O-errors-same-way-as-maste.patch b/recipes-devtools/python/python3/000=
1-Lib-pty.py-handle-stdin-I-O-errors-same-way-as-maste.patch
deleted file mode 100644
index 84ad2ab..0000000
--- a/recipes-devtools/python/python3/0001-Lib-pty.py-handle-stdin-I-O-er=
rors-same-way-as-maste.patch
+++ /dev/null
@@ -1,46 +0,0 @@
-From 129ee75863081d9e3418acca3df1e47667f671ad Mon Sep 17 00:00:00 2001
-From: Alexander Kanavin <alex@linutronix.de>
-Date: Thu, 16 Sep 2021 16:35:37 +0200
-Subject: [PATCH] Lib/pty.py: handle stdin I/O errors same way as master =
I/O
- errors
-
-reading stdin can throw the same I/O errors as reading from master fd do=
es,
-e.g. when running under Yocto's test harness:
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-ERROR: test_spawn_doesnt_hang (test.test_pty.PtyTest)
-----------------------------------------------------------------------
-Traceback (most recent call last):
-  File "/usr/lib/python3.10/test/test_pty.py", line 316, in test_spawn_d=
oesnt_hang
-    pty.spawn([sys.executable, '-c', 'print("hi there")'])
-  File "/usr/lib/python3.10/pty.py", line 181, in spawn
-    _copy(master_fd, master_read, stdin_read)
-  File "/usr/lib/python3.10/pty.py", line 157, in _copy
-    data =3D stdin_read(STDIN_FILENO)
-  File "/usr/lib/python3.10/pty.py", line 132, in _read
-    return os.read(fd, 1024)
-OSError: [Errno 5] Input/output error
-
-So let's treat both channels the same.
-
-Upstream-Status: Submitted [https://github.com/python/cpython/pull/28388=
]
-Signed-off-by: Alexander Kanavin <alex@linutronix.de>
----
- Lib/pty.py | 5 ++++-
- 1 file changed, 4 insertions(+), 1 deletion(-)
-
-diff --git a/Lib/pty.py b/Lib/pty.py
-index 1d97994..fa8821b 100644
---- a/Lib/pty.py
-+++ b/Lib/pty.py
-@@ -178,7 +178,10 @@ def _copy(master_fd, master_read=3D_read, stdin_rea=
d=3D_read):
-             i_buf =3D i_buf[n:]
-=20
-         if stdin_avail and STDIN_FILENO in rfds:
--            data =3D stdin_read(STDIN_FILENO)
-+            try:
-+                data =3D stdin_read(STDIN_FILENO)
-+            except OSError:
-+                data =3D b""
-             if not data:
-                 stdin_avail =3D False
-             else:
diff --git a/recipes-devtools/python/python3/0001-Lib-sysconfig.py-use-pr=
efix-value-from-build-configu.patch b/recipes-devtools/python/python3/000=
1-Lib-sysconfig.py-use-prefix-value-from-build-configu.patch
deleted file mode 100644
index ffdf9af..0000000
--- a/recipes-devtools/python/python3/0001-Lib-sysconfig.py-use-prefix-va=
lue-from-build-configu.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From 3f4f3e917950e286d5729ea949ca342995eb3c3e Mon Sep 17 00:00:00 2001
-From: Alexander Kanavin <alex@linutronix.de>
-Date: Fri, 17 Nov 2023 14:26:32 +0100
-Subject: [PATCH] Lib/sysconfig.py: use prefix value from build configura=
tion
- file
-
-This allows correctly substituting them for target installs using
-native python.
-
-Upstream-Status: Inappropriate [oe-core cross builds]
-Signed-off-by: Alexander Kanavin <alex@linutronix.de>
----
- Lib/sysconfig/__init__.py | 5 +++++
- 1 file changed, 5 insertions(+)
-
-diff --git a/Lib/sysconfig/__init__.py b/Lib/sysconfig/__init__.py
-index f8e1c7d..0882526 100644
---- a/Lib/sysconfig/__init__.py
-+++ b/Lib/sysconfig/__init__.py
-@@ -501,6 +501,11 @@ def _init_config_vars():
-         _CONFIG_VARS['VPATH'] =3D sys._vpath
-     if os.name =3D=3D 'posix':
-         _init_posix(_CONFIG_VARS)
-+    _CONFIG_VARS['installed_base'] =3D _CONFIG_VARS['prefix']
-+    _CONFIG_VARS['base'] =3D _CONFIG_VARS['prefix']
-+    _CONFIG_VARS['installed_platbase'] =3D _CONFIG_VARS['prefix']
-+    _CONFIG_VARS['platbase'] =3D _CONFIG_VARS['prefix']
-+    _CONFIG_VARS['platlibdir'] =3D _CONFIG_VARS['PLATLIBDIR']
-     if _HAS_USER_BASE:
-         # Setting 'userbase' is done below the call to the
-         # init function to enable using 'get_config_var' in
diff --git a/recipes-devtools/python/python3/0001-Makefile.pre-use-qemu-w=
rapper-when-gathering-profile.patch b/recipes-devtools/python/python3/000=
1-Makefile.pre-use-qemu-wrapper-when-gathering-profile.patch
deleted file mode 100644
index 39b62f6..0000000
--- a/recipes-devtools/python/python3/0001-Makefile.pre-use-qemu-wrapper-=
when-gathering-profile.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-From e7a8a7385f561f214054cf95f0a22bfa064eee0b Mon Sep 17 00:00:00 2001
-From: Alexander Kanavin <alex.kanavin@gmail.com>
-Date: Wed, 30 Jan 2019 12:41:04 +0100
-Subject: [PATCH] Makefile.pre: use qemu wrapper when gathering profile d=
ata
-
-Upstream-Status: Inappropriate [oe-core specific]
-Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
-
-Update to remove test_types from the test list, since that fails under
-qemu now.
-
-Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
----
- Makefile.pre.in | 3 +--
- 1 file changed, 1 insertion(+), 2 deletions(-)
-
-diff --git a/Makefile.pre.in b/Makefile.pre.in
-index 3bd4495f95b..8e8fc60bc76 100644
---- a/Makefile.pre.in
-+++ b/Makefile.pre.in
-@@ -751,8 +751,7 @@ profile-run-stamp:
- 	# enabled.
- 	$(MAKE) profile-gen-stamp
- 	# Next, run the profile task to generate the profile information.
--	@ # FIXME: can't run for a cross build
--	$(LLVM_PROF_FILE) $(RUNSHARED) ./$(BUILDPYTHON) $(PROFILE_TASK)
-+	./pgo-wrapper ./python -m test.regrtest --pgo test_grammar test_opcode=
s test_dict
- 	$(LLVM_PROF_MERGER)
- 	# Remove profile generation binary since we are done with it.
- 	$(MAKE) clean-retain-profile
---=20
-2.39.5
-
diff --git a/recipes-devtools/python/python3/0001-Skip-failing-tests-due-=
to-load-variability-on-YP-AB.patch b/recipes-devtools/python/python3/0001=
-Skip-failing-tests-due-to-load-variability-on-YP-AB.patch
deleted file mode 100644
index 8fa794b..0000000
--- a/recipes-devtools/python/python3/0001-Skip-failing-tests-due-to-load=
-variability-on-YP-AB.patch
+++ /dev/null
@@ -1,72 +0,0 @@
-From 8828a52ebace98199569404f01174398bcc64a00 Mon Sep 17 00:00:00 2001
-From: Yi Fan Yu <yifan.yu@windriver.com>
-Date: Thu, 1 Apr 2021 13:08:37 -0700
-Subject: [PATCH] Skip failing tests due to load variability on YP AB
-
-Skip these tests until AB-INT is solved.
-
-[YOCTO #14296]
-
-Upstream-Status: Inappropriate [OE-Specific]
-
-Signed-off-by: Yi Fan Yu <yifan.yu@windriver.com>
-
-Skip two additional tests due to suspected load variability failures.
-
-[YOCTO #15131]
-[YOCTO #15177]
-
-Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
----
- Lib/test/_test_multiprocessing.py | 3 +++
- Lib/test/test_time.py             | 2 ++
- 2 files changed, 5 insertions(+)
-
-diff --git a/Lib/test/_test_multiprocessing.py b/Lib/test/_test_multipro=
cessing.py
-index 5dae370..23eb971 100644
---- a/Lib/test/_test_multiprocessing.py
-+++ b/Lib/test/_test_multiprocessing.py
-@@ -701,6 +701,7 @@ class _TestProcess(BaseTestCase):
-         close_queue(q)
-=20
-     @support.requires_resource('walltime')
-+    @unittest.skip('timing related test, dependent on load')
-     def test_many_processes(self):
-         if self.TYPE =3D=3D 'threads':
-             self.skipTest('test not appropriate for {}'.format(self.TYP=
E))
-@@ -2232,6 +2233,7 @@ class _TestBarrier(BaseTestCase):
-         except threading.BrokenBarrierError:
-             results.append(True)
-=20
-+    @unittest.skip('timing related test, dependent on load')
-     def test_timeout(self):
-         """
-         Test wait(timeout)
-@@ -5320,6 +5322,7 @@ class TestWait(unittest.TestCase):
-         time.sleep(period)
-=20
-     @support.requires_resource('walltime')
-+    @unittest.skip('timing related test, dependent on load')
-     def test_wait_integer(self):
-         from multiprocessing.connection import wait
-=20
-diff --git a/Lib/test/test_time.py b/Lib/test/test_time.py
-index 293799f..1dbb623 100644
---- a/Lib/test/test_time.py
-+++ b/Lib/test/test_time.py
-@@ -548,6 +548,7 @@ class TimeTestCase(unittest.TestCase):
-     @unittest.skipIf(
-         support.is_wasi, "process_time not available on WASI"
-     )
-+    @unittest.skip('timing related test, dependent on load')
-     def test_process_time(self):
-         # process_time() should not include time spend during a sleep
-         start =3D time.process_time()
-@@ -561,6 +562,7 @@ class TimeTestCase(unittest.TestCase):
-         self.assertTrue(info.monotonic)
-         self.assertFalse(info.adjustable)
-=20
-+    @unittest.skip('timing related test, dependent on load')
-     def test_thread_time(self):
-         if not hasattr(time, 'thread_time'):
-             if sys.platform.startswith(('linux', 'android', 'win')):
diff --git a/recipes-devtools/python/python3/0001-Update-test_sysconfig-f=
or-posix_user-purelib.patch b/recipes-devtools/python/python3/0001-Update=
-test_sysconfig-for-posix_user-purelib.patch
deleted file mode 100644
index adaca4f..0000000
--- a/recipes-devtools/python/python3/0001-Update-test_sysconfig-for-posi=
x_user-purelib.patch
+++ /dev/null
@@ -1,36 +0,0 @@
-From 5bf5aa6eae1fa3eed66893e51a1858ab481426b4 Mon Sep 17 00:00:00 2001
-From: Wentao Zhang <wentao.zhang@windriver.com>
-Date: Mon, 20 Mar 2023 13:39:52 +0800
-Subject: [PATCH] Update test_sysconfig for posix_user purelib
-
-Steps to trigger the failed test:
-Edit local.conf to add something as follows:
-    BASELIB =3D "lib64"
-    IMAGE_INSTALL:append =3D " python3-tests".
-bitbake core-image-sato
-runqemu qemux86-64 nographic slirp
-Reproducer:
-    $python3 -m test test_sysconfig
-
-Update test_sysconfig.test_user_similar() for the posix_user scheme:
-"purelib" doesn't use sys.platlibdir.
-
-Upstream-Status: Inappropriate [oe-core specific]
-Signed-off-by: Wentao Zhang <wentao.zhang@windriver.com>
----
- Lib/test/test_sysconfig.py | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/Lib/test/test_sysconfig.py b/Lib/test/test_sysconfig.py
-index 1ade492..4e94889 100644
---- a/Lib/test/test_sysconfig.py
-+++ b/Lib/test/test_sysconfig.py
-@@ -430,7 +430,7 @@ class TestSysConfig(unittest.TestCase):
-                 expected =3D os.path.normpath(global_path.replace(base,=
 user, 1))
-                 # bpo-44860: platlib of posix_user doesn't use sys.plat=
libdir,
-                 # whereas posix_prefix does.
--                if name =3D=3D 'platlib':
-+                if name =3D=3D 'platlib' or name =3D=3D 'purelib':
-                     # Replace "/lib64/python3.11/site-packages" suffix
-                     # with "/lib/python3.11/site-packages".
-                     py_version_abi =3D sysconfig._get_python_version_ab=
i()
diff --git a/recipes-devtools/python/python3/0001-skip-no_stdout_fileno-t=
est-due-to-load-variability.patch b/recipes-devtools/python/python3/0001-=
skip-no_stdout_fileno-test-due-to-load-variability.patch
deleted file mode 100644
index 9bc8b09..0000000
--- a/recipes-devtools/python/python3/0001-skip-no_stdout_fileno-test-due=
-to-load-variability.patch
+++ /dev/null
@@ -1,29 +0,0 @@
-From c5bdd39f8ebc4e6c58a47d7e424eac028eddb4ff Mon Sep 17 00:00:00 2001
-From: Trevor Gamblin <tgamblin@baylibre.com>
-Date: Fri, 15 Sep 2023 08:48:33 -0400
-Subject: [PATCH] skip no_stdout_fileno test due to load variability
-
-Skip test_input_no_stdout_fileno so that it doesn't fail on systems
-under heavy load.
-
-Upstream-Status: Inappropriate [OE-Specific]
-
-[YOCTO #15210]
-
-Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
----
- Lib/test/test_builtin.py | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/Lib/test/test_builtin.py b/Lib/test/test_builtin.py
-index c5394de..ed17fb6 100644
---- a/Lib/test/test_builtin.py
-+++ b/Lib/test/test_builtin.py
-@@ -2474,6 +2474,7 @@ class PtyTests(unittest.TestCase):
-                          "byte 0xe9 in position 4: ordinal not in "
-                          "range(128)")
-=20
-+    @unittest.skip("Test may fail under heavy load")
-     def test_input_no_stdout_fileno(self):
-         # Issue #24402: If stdin is the original terminal but stdout.fi=
leno()
-         # fails, do not use the original stdout file descriptor
diff --git a/recipes-devtools/python/python3/0001-sysconfig.py-use-platli=
bdir-also-for-purelib.patch b/recipes-devtools/python/python3/0001-syscon=
fig.py-use-platlibdir-also-for-purelib.patch
deleted file mode 100644
index b9c68a9..0000000
--- a/recipes-devtools/python/python3/0001-sysconfig.py-use-platlibdir-al=
so-for-purelib.patch
+++ /dev/null
@@ -1,27 +0,0 @@
-From bbcb17dc1ed283f41c8cd94d39f70898f0c45583 Mon Sep 17 00:00:00 2001
-From: Alexander Kanavin <alex@linutronix.de>
-Date: Sun, 12 Sep 2021 21:44:36 +0200
-Subject: [PATCH] sysconfig.py: use platlibdir also for purelib
-
-This is needed in multilib configurations where hardcoding 'lib'
-is not correct.
-
-Upstream-Status: Inappropriate [oe-core specific]
-Signed-off-by: Alexander Kanavin <alex@linutronix.de>
----
- Lib/sysconfig/__init__.py | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/Lib/sysconfig/__init__.py b/Lib/sysconfig/__init__.py
-index 80aef34..f8e1c7d 100644
---- a/Lib/sysconfig/__init__.py
-+++ b/Lib/sysconfig/__init__.py
-@@ -29,7 +29,7 @@ _INSTALL_SCHEMES =3D {
-     'posix_prefix': {
-         'stdlib': '{installed_base}/{platlibdir}/{implementation_lower}=
{py_version_short}{abi_thread}',
-         'platstdlib': '{platbase}/{platlibdir}/{implementation_lower}{p=
y_version_short}{abi_thread}',
--        'purelib': '{base}/lib/{implementation_lower}{py_version_short}=
{abi_thread}/site-packages',
-+        'purelib': '{base}/{platlibdir}/{implementation_lower}{py_versi=
on_short}{abi_thread}/site-packages',
-         'platlib': '{platbase}/{platlibdir}/{implementation_lower}{py_v=
ersion_short}{abi_thread}/site-packages',
-         'include':
-             '{installed_base}/include/{implementation_lower}{py_version=
_short}{abiflags}',
diff --git a/recipes-devtools/python/python3/0001-test_active_children-sk=
ip-problematic-test.patch b/recipes-devtools/python/python3/0001-test_act=
ive_children-skip-problematic-test.patch
deleted file mode 100644
index 08ac586..0000000
--- a/recipes-devtools/python/python3/0001-test_active_children-skip-prob=
lematic-test.patch
+++ /dev/null
@@ -1,27 +0,0 @@
-From 540765b148d942a2339affa6c0d11445e9d0f26c Mon Sep 17 00:00:00 2001
-From: Trevor Gamblin <tgamblin@baylibre.com>
-Date: Thu, 13 Jun 2024 10:54:31 -0400
-Subject: [PATCH] test_active_children: skip problematic test
-
-This test is failing in some tests on the Autobuilder. Since it's of a
-similar nature to other failing/hanging tests, disable it for now.
-
-Upstream-Status: Inappropriate [OE-Specific]
-
-Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
----
- Lib/test/_test_multiprocessing.py | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/Lib/test/_test_multiprocessing.py b/Lib/test/_test_multipro=
cessing.py
-index 23eb971..b1295b2 100644
---- a/Lib/test/_test_multiprocessing.py
-+++ b/Lib/test/_test_multiprocessing.py
-@@ -594,6 +594,7 @@ class _TestProcess(BaseTestCase):
-         self.assertTrue(type(cpus) is int)
-         self.assertTrue(cpus >=3D 1)
-=20
-+    @unittest.skip("skipping problematic test")
-     def test_active_children(self):
-         self.assertEqual(type(self.active_children()), list)
-=20
diff --git a/recipes-devtools/python/python3/0001-test_ctypes.test_find-s=
kip-without-tools-sdk.patch b/recipes-devtools/python/python3/0001-test_c=
types.test_find-skip-without-tools-sdk.patch
deleted file mode 100644
index 68e277d..0000000
--- a/recipes-devtools/python/python3/0001-test_ctypes.test_find-skip-wit=
hout-tools-sdk.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-From 0e9d0c58e77ef540d9601ce84a1aa79d9ce6ee9b Mon Sep 17 00:00:00 2001
-From: Tim Orling <timothy.t.orling@intel.com>
-Date: Fri, 18 Jun 2021 11:56:50 -0700
-Subject: [PATCH] test_ctypes.test_find: skip without tools-sdk
-
-These tests need full packagegroup-core-buildessential, the
-easiest way to dynamically check for that is looking for
-'tools-sdk' in IMAGE_FEATURES.
-
-Upstream-Status: Inappropriate [oe-specific]
-
-Signed-off-by: Tim Orling <timothy.t.orling@intel.com>
----
- Lib/test/test_ctypes/test_find.py | 2 ++
- 1 file changed, 2 insertions(+)
-
-diff --git a/Lib/test/test_ctypes/test_find.py b/Lib/test/test_ctypes/te=
st_find.py
-index 85b2861..b033203 100644
---- a/Lib/test/test_ctypes/test_find.py
-+++ b/Lib/test/test_ctypes/test_find.py
-@@ -116,10 +116,12 @@ class FindLibraryLinux(unittest.TestCase):
-                 # LD_LIBRARY_PATH)
-                 self.assertEqual(find_library(libname), 'lib%s.so' % li=
bname)
-=20
-+    @unittest.skip("Needs IMAGE_FEATURE +=3D \"tools-sdk\"")
-     def test_find_library_with_gcc(self):
-         with unittest.mock.patch("ctypes.util._findSoname_ldconfig", la=
mbda *args: None):
-             self.assertNotEqual(find_library('c'), None)
-=20
-+    @unittest.skip("Needs IMAGE_FEATURE +=3D \"tools-sdk\"")
-     def test_find_library_with_ld(self):
-         with unittest.mock.patch("ctypes.util._findSoname_ldconfig", la=
mbda *args: None), \
-              unittest.mock.patch("ctypes.util._findLib_gcc", lambda *ar=
gs: None):
diff --git a/recipes-devtools/python/python3/0001-test_deadlock-skip-prob=
lematic-test.patch b/recipes-devtools/python/python3/0001-test_deadlock-s=
kip-problematic-test.patch
deleted file mode 100644
index 3336e29..0000000
--- a/recipes-devtools/python/python3/0001-test_deadlock-skip-problematic=
-test.patch
+++ /dev/null
@@ -1,27 +0,0 @@
-From 5a44f74549b32395109342e9299510c32db71068 Mon Sep 17 00:00:00 2001
-From: Trevor Gamblin <tgamblin@baylibre.com>
-Date: Wed, 12 Jun 2024 10:29:03 -0400
-Subject: [PATCH] test_deadlock: skip problematic test
-
-This test hangs frequently when run on the Autobuilder. Disable it in
-testing until the cause can be determined.
-
-Upstream-Status: Inappropriate [OE-Specific]
-
-Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
----
- Lib/test/test_concurrent_futures/test_deadlock.py | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/Lib/test/test_concurrent_futures/test_deadlock.py b/Lib/tes=
t/test_concurrent_futures/test_deadlock.py
-index 3c30c45..008d6c0 100644
---- a/Lib/test/test_concurrent_futures/test_deadlock.py
-+++ b/Lib/test/test_concurrent_futures/test_deadlock.py
-@@ -90,6 +90,7 @@ class ErrorAtUnpickle(object):
-         return _raise_error_ignore_stderr, (UnpicklingError, )
-=20
-=20
-+@unittest.skip("skipping problematic test")
- class ExecutorDeadlockTest:
-     TIMEOUT =3D support.LONG_TIMEOUT
-=20
diff --git a/recipes-devtools/python/python3/0001-test_locale.py-correct-=
the-test-output-format.patch b/recipes-devtools/python/python3/0001-test_=
locale.py-correct-the-test-output-format.patch
deleted file mode 100644
index 1892469..0000000
--- a/recipes-devtools/python/python3/0001-test_locale.py-correct-the-tes=
t-output-format.patch
+++ /dev/null
@@ -1,45 +0,0 @@
-From c1f3cf625c0f011060ddaa2a4096f6aa13dd1ee6 Mon Sep 17 00:00:00 2001
-From: Mingli Yu <mingli.yu@windriver.com>
-Date: Mon, 5 Aug 2019 15:57:39 +0800
-Subject: [PATCH] test_locale.py: correct the test output format
-
-Before this patch:
- # python3 -m test -v test_locale
- [snip]
- test_getsetlocale_issue1813 (test.test_locale.TestMiscellaneous) ... te=
sting with ('tr_TR', 'ISO8859-9') ok
- [snip]
-
- After this patch:
- # python3 -m test -v test_locale
- [snip]
- test_getsetlocale_issue1813 (test.test_locale.TestMiscellaneous) ... te=
sting with ('tr_TR', 'ISO8859-9')... ok
- [snip]
-
- Make the test ended with "... ok" is common in python
- unittest world, we should make it keep consistent
- with other test cases in case it may be ignored to
- record in the report if we use the common filter
- "... ok".
-
-Upstream-Status: Submitted [https://github.com/python/cpython/pull/15132=
]
-
-Rebased for 3.9.4, still not accepted upstream Signed-off-by: Alejandro =
Hernandez <alejandro@enedino.org>
-
-Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
----
- Lib/test/test_locale.py | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/Lib/test/test_locale.py b/Lib/test/test_locale.py
-index da4bd79..fd9e67d 100644
---- a/Lib/test/test_locale.py
-+++ b/Lib/test/test_locale.py
-@@ -501,7 +501,7 @@ class TestRealLocales(unittest.TestCase):
-             self.skipTest('test needs Turkish locale')
-         loc =3D locale.getlocale(locale.LC_CTYPE)
-         if verbose:
--            print('testing with %a' % (loc,), end=3D' ', flush=3DTrue)
-+            print('testing with %a...' % (loc,), end=3D' ', flush=3DTru=
e)
-         try:
-             locale.setlocale(locale.LC_CTYPE, loc)
-         except locale.Error as exc:
diff --git a/recipes-devtools/python/python3/0001-test_readline-skip-limi=
ted-history-test.patch b/recipes-devtools/python/python3/0001-test_readli=
ne-skip-limited-history-test.patch
deleted file mode 100644
index a619d51..0000000
--- a/recipes-devtools/python/python3/0001-test_readline-skip-limited-his=
tory-test.patch
+++ /dev/null
@@ -1,46 +0,0 @@
-From 1a0a145261ba4f97aaff3c0c656ac2e0ad9695a8 Mon Sep 17 00:00:00 2001
-From: Trevor Gamblin <tgamblin@baylibre.com>
-Date: Tue, 13 Aug 2024 11:07:05 -0400
-Subject: [PATCH] test_readline: skip limited history test
-
-This test was added recently and is failing on the ptest image when
-using the default PACKAGECONFIG settings (i.e. with editline instead of
-readline).. Disable it until the proper fix is determined.
-
-A bug has been opened upstream: https://github.com/python/cpython/issues=
/123018
-
-Upstream-Status: Inappropriate [OE-specific]
-
-Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
----
- Lib/test/test_readline.py | 3 +++
- 1 file changed, 3 insertions(+)
-
-diff --git a/Lib/test/test_readline.py b/Lib/test/test_readline.py
-index 537a9fb..ddf0323 100644
---- a/Lib/test/test_readline.py
-+++ b/Lib/test/test_readline.py
-@@ -71,6 +71,7 @@ class TestHistoryManipulation (unittest.TestCase):
-=20
-     @unittest.skipUnless(hasattr(readline, "append_history_file"),
-                          "append_history not available")
-+    @unittest.skip("Skipping problematic test")
-     def test_write_read_append(self):
-         hfile =3D tempfile.NamedTemporaryFile(delete=3DFalse)
-         hfile.close()
-@@ -142,6 +143,7 @@ class TestHistoryManipulation (unittest.TestCase):
-         self.assertEqual(readline.get_history_item(1), "entr=C3=A9e 1")
-         self.assertEqual(readline.get_history_item(2), "entr=C3=A9e 22"=
)
-=20
-+    @unittest.skip("Skipping problematic test")
-     def test_write_read_limited_history(self):
-         previous_length =3D readline.get_history_length()
-         self.addCleanup(readline.set_history_length, previous_length)
-@@ -390,6 +392,7 @@ readline.write_history_file(history_file)
-         self.assertIn(b"done", output)
-=20
-=20
-+    @unittest.skip("Skipping problematic test")
-     def test_write_read_limited_history(self):
-         previous_length =3D readline.get_history_length()
-         self.addCleanup(readline.set_history_length, previous_length)
diff --git a/recipes-devtools/python/python3/0001-test_shutdown-skip-prob=
lematic-test.patch b/recipes-devtools/python/python3/0001-test_shutdown-s=
kip-problematic-test.patch
deleted file mode 100644
index 4e284de..0000000
--- a/recipes-devtools/python/python3/0001-test_shutdown-skip-problematic=
-test.patch
+++ /dev/null
@@ -1,43 +0,0 @@
-From b678363156b5d40e09c1d138840180e3ddc7d20b Mon Sep 17 00:00:00 2001
-From: Trevor Gamblin <tgamblin@baylibre.com>
-Date: Wed, 8 May 2024 11:58:09 -0400
-Subject: [PATCH] test_shutdown: skip problematic test
-
-This test hangs frequently when run on the Autobuilder. Disable it in
-testing until the cause can be determined.
-
-Upstream-Status: Inappropriate [OE-Specific]
-
-Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
----
- Lib/test/test_concurrent_futures/test_shutdown.py | 3 +++
- 1 file changed, 3 insertions(+)
-
-diff --git a/Lib/test/test_concurrent_futures/test_shutdown.py b/Lib/tes=
t/test_concurrent_futures/test_shutdown.py
-index 7a4065a..6b878a4 100644
---- a/Lib/test/test_concurrent_futures/test_shutdown.py
-+++ b/Lib/test/test_concurrent_futures/test_shutdown.py
-@@ -20,6 +20,7 @@ def sleep_and_print(t, msg):
-     sys.stdout.flush()
-=20
-=20
-+@unittest.skip("skipping problematic test")
- class ExecutorShutdownTest:
-     def test_run_after_shutdown(self):
-         self.executor.shutdown()
-@@ -156,6 +157,7 @@ class ExecutorShutdownTest:
-             signal.signal(signal.SIGALRM, old_handler)
-=20
-=20
-+@unittest.skip("skipping problematic test")
- class ThreadPoolShutdownTest(ThreadPoolMixin, ExecutorShutdownTest, Bas=
eTestCase):
-     def test_threads_terminate(self):
-         def acquire_lock(lock):
-@@ -252,6 +254,7 @@ class ThreadPoolShutdownTest(ThreadPoolMixin, Execut=
orShutdownTest, BaseTestCase
-         self.assertIn(out.strip(), [b"apple", b""])
-=20
-=20
-+@unittest.skip("skipping problematic test")
- class ProcessPoolShutdownTest(ExecutorShutdownTest):
-     def test_processes_terminate(self):
-         def acquire_lock(lock):
diff --git a/recipes-devtools/python/python3/0001-test_storlines-skip-due=
-to-load-variability.patch b/recipes-devtools/python/python3/0001-test_st=
orlines-skip-due-to-load-variability.patch
deleted file mode 100644
index b452c65..0000000
--- a/recipes-devtools/python/python3/0001-test_storlines-skip-due-to-loa=
d-variability.patch
+++ /dev/null
@@ -1,29 +0,0 @@
-From 9f252a691cd335341938489da32d6e2d4620d8ca Mon Sep 17 00:00:00 2001
-From: Trevor Gamblin <tgamblin@baylibre.com>
-Date: Fri, 6 Oct 2023 10:59:44 -0400
-Subject: [PATCH] test_storlines: skip due to load variability
-
-This is yet another test that intermittently fails on the Yocto AB when
-a worker is under heavy load, so skip it during testing.
-
-Upstream-Status: Inappropriate [OE-Specific]
-
-[YOCTO #14933]
-
-Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
----
- Lib/test/test_ftplib.py | 1 +
- 1 file changed, 1 insertion(+)
-
-diff --git a/Lib/test/test_ftplib.py b/Lib/test/test_ftplib.py
-index bed0e6d..36602be 100644
---- a/Lib/test/test_ftplib.py
-+++ b/Lib/test/test_ftplib.py
-@@ -630,6 +630,7 @@ class TestFTPClass(TestCase):
-             self.client.storbinary('stor', f, rest=3Dr)
-             self.assertEqual(self.server.handler_instance.rest, str(r))
-=20
-+    @unittest.skip('timing related test, dependent on load')
-     def test_storlines(self):
-         data =3D RETR_DATA.replace('\r\n', '\n').encode(self.client.enc=
oding)
-         f =3D io.BytesIO(data)
diff --git a/recipes-devtools/python/python3/check_build_completeness.py =
b/recipes-devtools/python/python3/check_build_completeness.py
deleted file mode 100755
index a1eace3..0000000
--- a/recipes-devtools/python/python3/check_build_completeness.py
+++ /dev/null
@@ -1,17 +0,0 @@
-#!/usr/bin/env python3
-import sys
-logfile =3D open(sys.argv[1]).read()
-
-necessary_bits =3D logfile.find("The necessary bits to build these optio=
nal modules were not found")
-to_find_bits =3D logfile.find("To find the necessary bits, look in setup=
.py in detect_modules() for the module's name.")
-if necessary_bits !=3D -1:
-    print("%s" %(logfile[necessary_bits:to_find_bits]))
-
-failed_to_build =3D logfile.find("Failed to build these modules:")
-if failed_to_build !=3D -1:
-    failed_to_build_end =3D logfile.find("\n\n", failed_to_build)
-    print("%s" %(logfile[failed_to_build:failed_to_build_end]))
-
-if necessary_bits !=3D -1 or failed_to_build !=3D -1:
-    sys.exit(1)
-
diff --git a/recipes-devtools/python/python3/create_manifest3.py b/recipe=
s-devtools/python/python3/create_manifest3.py
deleted file mode 100644
index 288d5ed..0000000
--- a/recipes-devtools/python/python3/create_manifest3.py
+++ /dev/null
@@ -1,444 +0,0 @@
-# This script is used as a bitbake task to create a new python manifest
-# $ bitbake python -c create_manifest
-#
-# Our goal is to keep python-core as small as possible and add other pyt=
hon
-# packages only when the user needs them, hence why we split upstream py=
thon
-# into several packages.
-#
-# In a very simplistic way what this does is:=20
-# Launch python and see specifically what is required for it to run at a=
 minimum
-#
-# Go through the python-manifest file and launch a separate task for eve=
ry single
-# one of the files on each package, this task will check what was requir=
ed for that
-# specific module to run, these modules will be called dependencies.
-# The output of such task will be a list of the modules or dependencies =
that were
-# found for that file.
-#
-# Such output will be parsed by this script, we will look for each depen=
dency on the
-# manifest and if we find that another package already includes it, then=
 we will add
-# that package as an RDEPENDS to the package we are currently checking; =
in case we dont
-# find the current dependency on any other package we will add it to the=
 current package
-# as part of FILES.
-#
-#
-# This way we will create a new manifest from the data structure that wa=
s built during
-# this process, on this new manifest each package will contain specifica=
lly only
-# what it needs to run.
-#
-# There are some caveats which we try to deal with, such as repeated fil=
es on different
-# packages, packages that include folders, wildcards, and special packag=
es.
-# Its also important to note that this method only works for python file=
s, and shared
-# libraries. Static libraries, header files and binaries need to be deal=
t with manually.
-#
-# This script differs from its python2 version mostly on how shared libr=
aries are handled
-# The manifest file for python3 has an extra field which contains the ca=
ched files for
-# each package.
-# Tha method to handle cached files does not work when a module includes=
 a folder which
-# itself contains the pycache folder, gladly this is almost never the ca=
se.
-#
-# Author: Alejandro Enedino Hernandez Samaniego <alejandro at enedino do=
t org>
-
-
-import sys
-import subprocess
-import json
-import os
-import collections
-
-if '-d' in sys.argv:
-    debugFlag =3D '-d'
-else:
-    debugFlag =3D ''
-
-# Get python version from ${PYTHON_MAJMIN}
-pyversion =3D str(sys.argv[1])
-
-# Hack to get native python search path (for folders), not fond of it bu=
t it works for now
-pivot =3D 'recipe-sysroot-native'
-for p in sys.path:
-    if pivot in p:
-        nativelibfolder =3D p[:p.find(pivot)+len(pivot)]
-
-# Empty dict to hold the whole manifest
-new_manifest =3D collections.OrderedDict()
-
-# Check for repeated files, folders and wildcards
-allfiles =3D []
-repeated =3D []
-wildcards =3D []
-
-hasfolders =3D []
-allfolders =3D []
-
-def isFolder(value):
-    value =3D value.replace('${PYTHON_MAJMIN}',pyversion)
-    if os.path.isdir(value.replace('${libdir}',nativelibfolder+'/usr/lib=
')) or os.path.isdir(value.replace('${libdir}',nativelibfolder+'/usr/lib6=
4')) or os.path.isdir(value.replace('${libdir}',nativelibfolder+'/usr/lib=
32')):
-        return True
-    else:
-        return False
-
-def isCached(item):
-    if '__pycache__' in item:
-        return True
-    else:
-        return False
-
-def prepend_comments(comments, json_manifest):
-    with open(json_manifest, 'r+') as manifest:
-        json_contents =3D manifest.read()
-        manifest.seek(0, 0)
-        manifest.write(comments + json_contents)
-
-def print_indent(msg, offset):
-    for l in msg.splitlines():
-        msg =3D ' ' * offset + l
-        print(msg)
-
-
-# Read existing JSON manifest
-with open('python3-manifest.json') as manifest:
-    # The JSON format doesn't allow comments so we hack the call to keep=
 the comments using a marker
-    manifest_str =3D  manifest.read()
-    json_start =3D manifest_str.find('# EOC') + 6 # EOC + \n
-    manifest.seek(0)
-    comments =3D manifest.read(json_start)
-    manifest_str =3D manifest.read()
-    old_manifest =3D json.loads(manifest_str, object_pairs_hook=3Dcollec=
tions.OrderedDict)
-
-#
-# First pass to get core-package functionality, because we base everythi=
ng on the fact that core is actually working
-# Not exactly the same so it should not be a function
-#
-
-print_indent('Getting dependencies for package: core', 0)
-
-
-# This special call gets the core dependencies and
-# appends to the old manifest so it doesnt hurt what it
-# currently holds.
-# This way when other packages check for dependencies
-# on the new core package, they will still find them
-# even when checking the old_manifest
-
-output =3D subprocess.check_output([sys.executable, 'get_module_deps3.py=
', 'python-core-package', '%s' % debugFlag]).decode('utf8')
-for coredep in output.split():
-    coredep =3D coredep.replace(pyversion,'${PYTHON_MAJMIN}')
-    if isCached(coredep):
-        if coredep not in old_manifest['core']['cached']:
-            old_manifest['core']['cached'].append(coredep)
-    else:
-        if coredep not in old_manifest['core']['files']:
-            old_manifest['core']['files'].append(coredep)
-
-
-# The second step is to loop through the existing files contained in the=
 core package
-# according to the old manifest, identify if they are  modules, or some =
other type=20
-# of file that we cant import (directories, binaries, configs) in which =
case we
-# can only assume they were added correctly (manually) so we ignore thos=
e and=20
-# pass them to the manifest directly.
-
-for filedep in old_manifest['core']['files']:
-    if isFolder(filedep):
-        if isCached(filedep):
-            if filedep not in old_manifest['core']['cached']:
-                old_manifest['core']['cached'].append(filedep)
-        else:
-            if filedep not in old_manifest['core']['files']:
-                old_manifest['core']['files'].append(filedep)
-        continue
-    if '${bindir}' in filedep:
-        if filedep not in old_manifest['core']['files']:
-            old_manifest['core']['files'].append(filedep)
-        continue
-    if filedep =3D=3D '':
-        continue
-    if '${includedir}' in filedep:
-        if filedep not in old_manifest['core']['files']:
-            old_manifest['core']['files'].append(filedep)
-        continue
-
-    # Get actual module name , shouldnt be affected by libdir/bindir, et=
c.
-    pymodule =3D os.path.splitext(os.path.basename(os.path.normpath(file=
dep)))[0]
-
-    # We now know that were dealing with a python module, so we can impo=
rt it
-    # and check what its dependencies are.
-    # We launch a separate task for each module for deterministic behavi=
or.
-    # Each module will only import what is necessary for it to work in s=
pecific.
-    # The output of each task will contain each module's dependencies
-
-    print_indent('Getting dependencies for module: %s' % pymodule, 2)
-    output =3D subprocess.check_output([sys.executable, 'get_module_deps=
3.py', '%s' % pymodule, '%s' % debugFlag]).decode('utf8')
-    print_indent('The following dependencies were found for module %s:\n=
' % pymodule, 4)
-    print_indent(output, 6)
-
-
-    for pymodule_dep in output.split():
-        pymodule_dep =3D pymodule_dep.replace(pyversion,'${PYTHON_MAJMIN=
}')
-
-        if isCached(pymodule_dep):
-            if pymodule_dep not in old_manifest['core']['cached']:
-                old_manifest['core']['cached'].append(pymodule_dep)
-        else:
-            if pymodule_dep not in old_manifest['core']['files']:
-                old_manifest['core']['files'].append(pymodule_dep)
-
-
-# At this point we are done with the core package.
-# The old_manifest dictionary is updated only for the core package becau=
se
-# all others will use this a base.
-
-
-print('\n\nChecking for directories...\n')
-# To improve the script speed, we check which packages contain directori=
es
-# since we will be looping through (only) those later.
-for pypkg in old_manifest:
-    for filedep in old_manifest[pypkg]['files']:
-        if isFolder(filedep):
-            print_indent('%s is a directory' % filedep, 2)
-            if pypkg not in hasfolders:
-                hasfolders.append(pypkg)
-            if filedep not in allfolders:
-                allfolders.append(filedep)
-
-
-
-# This is the main loop that will handle each package.
-# It works in a similar fashion than the step before, but
-# we will now be updating a new dictionary that will eventually
-# become the new manifest.
-#
-# The following loops though all packages in the manifest,
-# through all files on each of them, and checks whether or not
-# they are modules and can be imported.
-# If they can be imported, then it checks for dependencies for
-# each of them by launching a separate task.
-# The output of that task is then parsed and the manifest is updated
-# accordingly, wether it should add the module on FILES for the current =
package
-# or if that module already belongs to another package then the current =
one=20
-# will RDEPEND on it
-
-for pypkg in old_manifest:
-    # Use an empty dict as data structure to hold data for each package =
and fill it up
-    new_manifest[pypkg] =3D collections.OrderedDict()
-    new_manifest[pypkg]['summary'] =3D old_manifest[pypkg]['summary']
-    new_manifest[pypkg]['rdepends'] =3D []
-    new_manifest[pypkg]['files'] =3D []
-    new_manifest[pypkg]['cached'] =3D old_manifest[pypkg]['cached']
-
-    # All packages should depend on core
-    if pypkg !=3D 'core':
-        new_manifest[pypkg]['rdepends'].append('core')
-        new_manifest[pypkg]['cached'] =3D []
-
-    print('\n')
-    print('--------------------------')
-    print('Handling package %s' % pypkg)
-    print('--------------------------')
-
-    # Handle special cases, we assume that when they were manually added=
=20
-    # to the manifest we knew what we were doing.
-    special_packages =3D ['misc', 'modules', 'dev', 'tests']
-    if pypkg in special_packages or 'staticdev' in pypkg:
-        print_indent('Passing %s package directly' % pypkg, 2)
-        new_manifest[pypkg] =3D old_manifest[pypkg]
-        continue
-
-    for filedep in old_manifest[pypkg]['files']:
-        # We already handled core on the first pass, we can ignore it no=
w
-        if pypkg =3D=3D 'core':
-            if filedep not in new_manifest[pypkg]['files']:
-                new_manifest[pypkg]['files'].append(filedep)
-            continue
-
-        # Handle/ignore what we cant import
-        if isFolder(filedep):
-            new_manifest[pypkg]['files'].append(filedep)
-            # Asyncio (and others) are both the package and the folder n=
ame, we should not skip those...
-            path,mod =3D os.path.split(filedep)
-            if mod !=3D pypkg:
-                continue
-        if '${bindir}' in filedep:
-            if filedep not in new_manifest[pypkg]['files']:
-                new_manifest[pypkg]['files'].append(filedep)
-            continue
-        if filedep =3D=3D '':
-            continue
-        if '${includedir}' in filedep:
-            if filedep not in new_manifest[pypkg]['files']:
-                new_manifest[pypkg]['files'].append(filedep)
-            continue
-
-        # Get actual module name , shouldnt be affected by libdir/bindir=
, etc.
-        # We need to check if the imported module comes from another (e.=
g. sqlite3.dump)
-        path, pymodule =3D os.path.split(filedep)
-        path =3D os.path.basename(path)
-        pymodule =3D os.path.splitext(os.path.basename(pymodule))[0]
-
-        # If this condition is met, it means we need to import it from a=
nother module
-        # or its the folder itself (e.g. unittest)
-        if path =3D=3D pypkg:
-            if pymodule:
-                pymodule =3D path + '.' + pymodule
-            else:
-                pymodule =3D path
-
-
-
-        # We now know that were dealing with a python module, so we can =
import it
-        # and check what its dependencies are.
-        # We launch a separate task for each module for deterministic be=
havior.
-        # Each module will only import what is necessary for it to work =
in specific.
-        # The output of each task will contain each module's dependencie=
s
-
-        print_indent('\nGetting dependencies for module: %s' % pymodule,=
 2)
-        output =3D subprocess.check_output([sys.executable, 'get_module_=
deps3.py', '%s' % pymodule, '%s' % debugFlag]).decode('utf8')
-        print_indent('The following dependencies were found for module %=
s:\n' % pymodule, 4)
-        print_indent(output, 6)
-
-        reportFILES =3D []
-        reportRDEPS =3D []
-
-        for pymodule_dep in output.split():
-
-            # Warning: This first part is ugly
-            # One of the dependencies that was found, could be inside of=
 one of the folders included by another package
-            # We need to check if this happens so we can add the package=
 containing the folder as an rdependency
-            # e.g. Folder encodings contained in codecs
-            # This would be solved if no packages included any folders
-
-            # This can be done in two ways:
-            # 1 - We assume that if we take out the filename from the pa=
th we would get
-            #   the folder string, then we would check if folder string =
is in the list of folders
-            #   This would not work if a package contains a folder which=
 contains another folder
-            #   e.g. path/folder1/folder2/filename  folder_string=3D pat=
h/folder1/folder2
-            #   folder_string would not match any value contained in the=
 list of folders
-            #
-            # 2 - We do it the other way around, checking if the folder =
is contained in the path
-            #   e.g. path/folder1/folder2/filename  folder_string=3D pat=
h/folder1/folder2
-            #   is folder_string inside path/folder1/folder2/filename?,=20
-            #   Yes, it works, but we waste a couple of milliseconds.
-
-            pymodule_dep =3D pymodule_dep.replace(pyversion,'${PYTHON_MA=
JMIN}')
-            inFolders =3D False
-            for folder in allfolders:
-                # The module could have a directory named after it, e.g.=
 xml, if we take out the filename from the path
-                # we'll end up with ${libdir}, and we want ${libdir}/xml
-                if isFolder(pymodule_dep):
-                    check_path =3D pymodule_dep
-                else:
-                    check_path =3D os.path.dirname(pymodule_dep)
-                if folder in check_path :
-                    inFolders =3D True # Did we find a folder?
-                    folderFound =3D False # Second flag to break inner f=
or
-                    # Loop only through packages which contain folders
-                    for pypkg_with_folder in hasfolders:
-                        if (folderFound =3D=3D False):
-                            # print('Checking folder %s on package %s' %=
 (pymodule_dep,pypkg_with_folder))
-                            for folder_dep in old_manifest[pypkg_with_fo=
lder]['files'] or folder_dep in old_manifest[pypkg_with_folder]['cached']=
:
-                                if folder_dep =3D=3D folder:
-                                    print ('%s directory found in %s' % =
(folder, pypkg_with_folder))
-                                    folderFound =3D True
-                                    if pypkg_with_folder not in new_mani=
fest[pypkg]['rdepends'] and pypkg_with_folder !=3D pypkg:
-                                        new_manifest[pypkg]['rdepends'].=
append(pypkg_with_folder)
-                        else:
-                            break
-
-            # A folder was found so we're done with this item, we can go=
 on
-            if inFolders:
-                continue
-
-
-
-            # No directories beyond this point
-            # We might already have this module on the dictionary since =
it could depend on a (previously checked) module
-            if pymodule_dep not in new_manifest[pypkg]['files'] and pymo=
dule_dep not in new_manifest[pypkg]['cached']:
-                # Handle core as a special package, we already did it so=
 we pass it to NEW data structure directly
-                if pypkg =3D=3D 'core':
-                    print('Adding %s to %s FILES' % (pymodule_dep, pypkg=
))
-                    if pymodule_dep.endswith('*'):
-                        wildcards.append(pymodule_dep)
-                    if isCached(pymodule_dep):
-                        new_manifest[pypkg]['cached'].append(pymodule_de=
p)
-                    else:
-                        new_manifest[pypkg]['files'].append(pymodule_dep=
)
-
-                    # Check for repeated files
-                    if pymodule_dep not in allfiles:
-                        allfiles.append(pymodule_dep)
-                    else:
-                        if pymodule_dep not in repeated:
-                            repeated.append(pymodule_dep)
-                else:
-
-
-                    # Last step: Figure out if we this belongs to FILES =
or RDEPENDS
-                    # We check if this module is already contained on an=
other package, so we add that one
-                    # as an RDEPENDS, or if its not, it means it should =
be contained on the current
-                    # package, and we should add it to FILES
-                    for possible_rdep in old_manifest:
-                        # Debug
-                        # print('Checking %s ' % pymodule_dep + ' in %s'=
 % possible_rdep)
-                        if pymodule_dep in old_manifest[possible_rdep]['=
files'] or pymodule_dep in old_manifest[possible_rdep]['cached']:
-                            # Since were nesting, we need to check its n=
ot the same pypkg
-                            if(possible_rdep !=3D pypkg):
-                                if possible_rdep not in new_manifest[pyp=
kg]['rdepends']:
-                                    # Add it to the new manifest data st=
ruct as RDEPENDS since it contains something this module needs
-                                    reportRDEPS.append('Adding %s to %s =
RDEPENDS, because it contains %s\n' % (possible_rdep, pypkg, pymodule_dep=
))
-                                    new_manifest[pypkg]['rdepends'].appe=
nd(possible_rdep)
-                                break
-                    else:
-
-                      # Since this module wasnt found on another package=
, it is not an RDEP,
-                      # so we add it to FILES for this package.
-                      # A module shouldn't contain itself (${libdir}/pyt=
hon3/sqlite3 shouldnt be on sqlite3 files)
-                      if os.path.basename(pymodule_dep) !=3D pypkg:
-                        reportFILES.append(('Adding %s to %s FILES\n' % =
(pymodule_dep, pypkg)))
-                        if isCached(pymodule_dep):
-                            new_manifest[pypkg]['cached'].append(pymodul=
e_dep)
-                        else:
-                            new_manifest[pypkg]['files'].append(pymodule=
_dep)
-                        if pymodule_dep.endswith('*'):
-                            wildcards.append(pymodule_dep)
-                        if pymodule_dep not in allfiles:
-                            allfiles.append(pymodule_dep)
-                        else:
-                            if pymodule_dep not in repeated:
-                                repeated.append(pymodule_dep)
-
-        print('\n')
-        print('#################################')
-        print('Summary for module %s' % pymodule)
-        print('FILES found for module %s:' % pymodule)
-        print(''.join(reportFILES))
-        print('RDEPENDS found for module %s:' % pymodule)
-        print(''.join(reportRDEPS))
-        print('#################################')
-
-print('The following FILES contain wildcards, please check if they are n=
ecessary')
-print(wildcards)
-print('The following FILES contain folders, please check if they are nec=
essary')
-print(hasfolders)
-
-
-# Sort it just so it looks nicer
-for pypkg in new_manifest:
-    new_manifest[pypkg]['files'].sort()
-    new_manifest[pypkg]['cached'].sort()
-    new_manifest[pypkg]['rdepends'].sort()
-
-# Create the manifest from the data structure that was built
-with open('python3-manifest.json.new','w') as outfile:
-    json.dump(new_manifest,outfile, indent=3D4)
-    outfile.write('\n')
-
-prepend_comments(comments,'python3-manifest.json.new')
-
-if (repeated):
-    error_msg =3D '\n\nERROR:\n'
-    error_msg +=3D 'The following files were found in more than one pack=
age),\n'
-    error_msg +=3D 'this is likely to happen when new files are introduc=
ed after an upgrade,\n'
-    error_msg +=3D 'please check which package should get it,\n modify t=
he manifest accordingly and re-run the create_manifest task:\n'
-    error_msg +=3D '\n'.join(repeated)
-    error_msg +=3D '\n'
-    sys.exit(error_msg)
-
diff --git a/recipes-devtools/python/python3/get_module_deps3.py b/recipe=
s-devtools/python/python3/get_module_deps3.py
deleted file mode 100644
index 8e432b4..0000000
--- a/recipes-devtools/python/python3/get_module_deps3.py
+++ /dev/null
@@ -1,174 +0,0 @@
-# This script is launched on separate task for each python module
-# It checks for dependencies for that specific module and prints=20
-# them out, the output of this execution will have all dependencies
-# for a specific module, which will be parsed an dealt on create_manifes=
t.py
-#
-# Author: Alejandro Enedino Hernandez Samaniego <alejandro at enedino do=
t org>
-
-
-import sys
-import os
-
-# We can get a log per module, for all the dependencies that were found,=
 but its messy.
-if '-d' in sys.argv:
-    debug =3D True
-else:
-    debug =3D False
-
-# We can get a list of the modules which are currently required to run p=
ython
-# so we run python-core and get its modules, we then import what we need
-# and check what modules are currently running, if we substract them fro=
m the
-# modules we had initially, we get the dependencies for the module we im=
ported.
-
-# We use importlib to achieve this, so we also need to know what modules=
 importlib needs
-import importlib
-
-core_deps =3D set(sys.modules)
-
-def fix_path(dep_path):
-    import os
-    # We DONT want the path on our HOST system
-    pivot =3D 'recipe-sysroot-native'
-    dep_path =3D dep_path[dep_path.find(pivot)+len(pivot):]
-
-    if '/usr/bin' in dep_path:
-        dep_path =3D dep_path.replace('/usr/bin','${bindir}')
-
-    # Handle multilib, is there a better way?
-    if '/usr/lib32' in dep_path:
-        dep_path =3D dep_path.replace('/usr/lib32','${libdir}')
-    if '/usr/lib64' in dep_path:
-        dep_path =3D dep_path.replace('/usr/lib64','${libdir}')
-    if '/usr/lib' in dep_path:
-        dep_path =3D dep_path.replace('/usr/lib','${libdir}')
-    if '/usr/include' in dep_path:
-        dep_path =3D dep_path.replace('/usr/include','${includedir}')
-    if '__init__.' in dep_path:
-        dep_path =3D  os.path.split(dep_path)[0]
-    return dep_path
-
-
-# Module to import was passed as an argument
-current_module =3D  str(sys.argv[1]).rstrip()
-if debug =3D=3D True:
-    log =3D open('temp/log_%s' % current_module.strip('.*'),'w')
-    log.write('Module %s generated the following dependencies:\n' % curr=
ent_module)
-try:
-    m =3D importlib.import_module(current_module)
-    # handle python packages which may not include all modules in the __=
init__
-    if hasattr(m, '__file__') and os.path.basename(m.__file__) =3D=3D "_=
_init__.py":
-        modulepath =3D os.path.dirname(m.__file__)
-        for i in os.listdir(modulepath):
-            if i.startswith("_") or not(i.endswith(".py")):
-                continue
-            submodule =3D "{}.{}".format(current_module, i[:-3])
-            try:
-                importlib.import_module(submodule)
-            except:
-                pass # ignore all import or other exceptions raised duri=
ng import
-except ImportError as e:
-    if debug =3D=3D True:
-        log.write('Module was not found\n')
-    pass
-
-
-# Get current module dependencies, dif will contain a list of specific d=
eps for this module
-module_deps =3D set(sys.modules)
-
-# We handle the core package (1st pass on create_manifest.py) as a speci=
al case
-if current_module =3D=3D 'python-core-package':
-    dif =3D core_deps
-else:
-    # We know this is not the core package, so there must be a differenc=
e.
-    dif =3D module_deps-core_deps
-
-
-# Check where each dependency came from
-for item in dif:
-    # Main module returns script filename, __main matches mp_main__ as w=
ell
-    if 'main__' in item:
-        continue
-
-    dep_path =3D ''
-    try:
-        if debug =3D=3D True:
-            log.write('\nCalling: sys.modules[' + '%s' % item + '].__fil=
e__\n')
-        dep_path =3D sys.modules['%s' % item].__file__
-    except AttributeError as e:
-        # Deals with thread (builtin module) not having __file__ attribu=
te
-        if debug =3D=3D True:
-            log.write(item + ' ')
-            log.write(str(e))
-            log.write('\n')
-        pass
-    except NameError as e:
-        # Deals with NameError: name 'dep_path' is not defined
-        # because module is not found (wasn't compiled?), e.g. bddsm
-        if debug =3D=3D True:
-            log.write(item+' ')=20
-            log.write(str(e))                                           =
  =20
-        pass
-
-    if dep_path =3D=3D '':
-        continue
-    if debug =3D=3D True:
-        log.write('Dependency path found:\n%s\n' % dep_path)
-
-    # Site-customize is a special case since we (OpenEmbedded) put it th=
ere manually
-    if 'sitecustomize' in dep_path:
-        dep_path =3D '${libdir}/python${PYTHON_MAJMIN}/sitecustomize.py'
-        # Prints out result, which is what will be used by create_manife=
st
-        print (dep_path)
-        continue
-
-    dep_path =3D fix_path(dep_path)
-
-    import sysconfig
-    soabi =3D sysconfig.get_config_var('SOABI')
-    # Check if its a shared library and deconstruct it
-    if soabi in dep_path:
-        if debug =3D=3D True:
-            log.write('Shared library found in %s\n' % dep_path)
-        dep_path =3D dep_path.replace(soabi,'*')
-        print (dep_path)
-        continue
-    if "_sysconfigdata" in dep_path:
-        dep_path =3D dep_path.replace(sysconfig._get_sysconfigdata_name(=
), "_sysconfigdata*")
-
-    if debug =3D=3D True:
-        log.write(dep_path+'\n')
-    # Prints out result, which is what will be used by create_manifest
-    print (dep_path)
-
-
-    cpython_tag =3D sys.implementation.cache_tag
-    cached =3D ''
-    # Theres no naive way to find *.pyc files on python3
-    try:
-        if debug =3D=3D True:
-            log.write('\nCalling: sys.modules[' + '%s' % item + '].__cac=
hed__\n')
-        cached =3D sys.modules['%s' % item].__cached__
-    except AttributeError as e:
-        # Deals with thread (builtin module) not having __cached__ attri=
bute
-        if debug =3D=3D True:
-            log.write(item + ' ')
-            log.write(str(e))
-            log.write('\n')
-        pass
-    except NameError as e:
-        # Deals with NameError: name 'cached' is not defined
-        if debug =3D=3D True:
-            log.write(item+' ')=20
-            log.write(str(e))                                           =
  =20
-        pass
-    if cached is not None:
-        if debug =3D=3D True:
-            log.write(cached + '\n')
-        cached =3D fix_path(cached)
-        cached =3D cached.replace(cpython_tag,'*')
-        if "_sysconfigdata" in cached:
-            cached =3D cached.replace(sysconfig._get_sysconfigdata_name(=
), "_sysconfigdata*")
-        print (cached)
-
-if debug =3D=3D True:
-    log.close()
diff --git a/recipes-devtools/python/python3/makerace.patch b/recipes-dev=
tools/python/python3/makerace.patch
deleted file mode 100644
index bf73135..0000000
--- a/recipes-devtools/python/python3/makerace.patch
+++ /dev/null
@@ -1,31 +0,0 @@
-From 2b458b4e1bcd57e3f135d3f0e715f64b98b27906 Mon Sep 17 00:00:00 2001
-From: Richard Purdie <richard.purdie@linuxfoundation.org>
-Date: Tue, 13 Jul 2021 23:19:29 +0100
-Subject: [PATCH] python3: Fix make race
-
-libainstall installs python-config.py but the .pyc cache files are gener=
ated
-by the libinstall target. This means some builds may not generate the py=
c files
-for python-config.py depending on the order things happen in. This means=
 builds
-are not always reproducible.
-
-Add a dependency to avoid the race.
-
-Upstream-Status: Pending
-Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
----
- Makefile.pre.in | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/Makefile.pre.in b/Makefile.pre.in
-index be1b9ea..9ec3a71 100644
---- a/Makefile.pre.in
-+++ b/Makefile.pre.in
-@@ -2492,7 +2492,7 @@ COMPILEALL_OPTS=3D-j0
- TEST_MODULES=3D@TEST_MODULES@
-=20
- .PHONY: libinstall
--libinstall:	all $(srcdir)/Modules/xxmodule.c
-+libinstall:	all $(srcdir)/Modules/xxmodule.c libainstall
- 	@for i in $(SCRIPTDIR) $(LIBDEST); \
- 	do \
- 		if test ! -d $(DESTDIR)$$i; then \
diff --git a/recipes-devtools/python/python3/python3-manifest.json b/reci=
pes-devtools/python/python3/python3-manifest.json
deleted file mode 100644
index 4418308..0000000
--- a/recipes-devtools/python/python3/python3-manifest.json
+++ /dev/null
@@ -1,1215 +0,0 @@
-# DO NOT (entirely) modify this file manually, please read.
-#
-# IMPORTANT NOTE:
-# Please keep in mind that the create_manifest task relies on the fact t=
hat the
-# target and native Python packages are the same, and it also needs to b=
e executed
-# with a fully working native package (with all the PACKAGECONFIGs enabl=
ed and all
-# and all the modules should be working, check log.do_compile), otherwis=
e the script
-# will fail to find dependencies correctly, this note is valid either if=
 you are
-# upgrading to a new Python version or adding a new package.
-#
-#
-# If you are adding a new package please follow the next steps:
-#     How to add a new package:
-#     - If a user wants to add a new package all that has to be done is:
-#     Modify the python3-manifest.json file, and add the required file(s=
) to the FILES list,
-#     fill up the SUMMARY section as well, the script should handle all =
the rest.
-#
-#     Real example:
-#     We want to add a web browser package, including the file webbrowse=
r.py
-#     which at the moment is on python3-misc.
-#     "webbrowser": {
-#         "files": ["${libdir}/python${PYTHON_MAJMIN}/lib-dynload/webbro=
wser.py"],
-#         "rdepends": [],
-#         "summary": "Python Web Browser support"}
-#
-#     * Note that the rdepends field was left empty
-#
-#     We run $ bitbake python3 -c create_manifest and the resulting mani=
fest
-#     should be completed after a few seconds, showing something like:
-#     "webbrowser": {
-#         "files": ["${libdir}/python${PYTHON_MAJMIN}/webbrowser.py"],
-#         "rdepends": ["core","fcntl","io","pickle","shell","subprocess"=
],
-#         "summary": "Python Web Browser support"}
-#
-#
-# If you are upgrading Python to a new version please follow the next st=
eps:
-#     After each Python upgrade, the create_manifest task should be exec=
uted, because we
-#     don't control what changes on upstream Python, so, some module dep=
endency
-#     might have changed without us realizing it, a certain module can e=
ither have
-#     more or less dependencies, or could be depending on a new file tha=
t was just
-#     created on the new release and for obvious reasons we wouldn't hav=
e it on our
-#     old manifest, all of these issues would cause runtime errors on ou=
r system.
-#
-#     - Upgrade both the native and target Python packages to a new vers=
ion
-#     - Run the create_manifest task for the target Python package as it=
s shown below:
-#
-#     $ bitbake python3 -c create_manifest
-#
-#     This will automatically replace your manifest file located under t=
he Python directory
-#     with an new one, which contains the new dependencies (if any).
-#
-#     Several things could have gone wrong here, I will try to explain a=
 few:
-#
-#     a) A new file was introduced on this release, e.g. sha3*.so:
-#        The task will check what its needed to import every module, mor=
e than one module would
-#        would probably depend on sha3*.so, although only one module sho=
uld contain it.
-#
-#        After running the task, the new manifest will have the sha3*.so=
 file on more than one
-#        module, you need to manually decide which one of them should ge=
t it and delete it from
-#        the others, for example sha3*.so should likely be on ${PN}-cryp=
t.
-#        Once you have deleted from the others you need to run the creat=
e_manifest task again,
-#        this will populate the other module's rdepends fields, with ${P=
N}-crypt and you should be
-#        good to go.
-#
-#     b) The native package wasn't built correctly and its missing a cer=
tain module:
-#        As mentioned before, you need to make sure the native package w=
as built with all the modules
-#        because it is used as base to build the manifest file, you need=
 to manually check log.do_compile
-#        since it won't error out the compile function if its only missi=
ng a couple of modules.
-#
-#        e.g. missing the _uuid module, log.do_compile would show the fo=
llowing:
-#        Python build finished successfully!
-#        The necessary bits to build these optional modules were not fou=
nd:
-#        _uuid
-#
-#        What will happen here is that the new manifest would not be awa=
re that the _uuid module exists, so
-#        not only we won't know of any dependencies to it, but also, the=
 _uuid* files will be packaged on
-#        the misc package (which is where any file that doesn't belong a=
nywhere else ends up).
-#
-#        This will eventually cause runtime errors on our system if we d=
on't include the misc package on
-#        on our image, because the _uuid files will be missing.
-#        If we build the _uuid module correctly and run the create_manif=
est task the _uuid files will be
-#        detected correctly along with its dependencies, and we will get=
 a working manifest.
-#
-#        This is the reason why it is important to make sure we have a f=
ully working native build,
-#        so we can avoid these errors.
-#
-#
-#
-# DO NOT MODIFY THE NEXT LINE!, IT IS USED AS A MARKER FOR THE ACTUAL JS=
ON MANIFEST
-# EOC
-{
-    "tests": {
-        "summary": "Python test suite",
-        "rdepends": [
-            "core",
-            "modules"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/*/test",
-            "${libdir}/python${PYTHON_MAJMIN}/*/tests",
-            "${libdir}/python${PYTHON_MAJMIN}/idlelib/idle_test/",
-            "${libdir}/python${PYTHON_MAJMIN}/test"
-        ],
-        "cached": []
-    },
-    "asyncio": {
-        "summary": "Python Asynchronous I/O",
-        "rdepends": [
-            "core",
-            "io",
-            "logging",
-            "netclient",
-            "numbers",
-            "stringold"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/asyncio",
-            "${libdir}/python${PYTHON_MAJMIN}/concurrent",
-            "${libdir}/python${PYTHON_MAJMIN}/concurrent/futures",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_asyncio.*.so"
-        ],
-        "cached": []
-    },
-    "audio": {
-        "summary": "Python Audio Handling",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/wave.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/wave.*.pyc"
-        ]
-    },
-    "codecs": {
-        "summary": "Python codec",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_multibytecode=
c.*.so"
-        ],
-        "cached": []
-    },
-    "compile": {
-        "summary": "Python bytecode compilation support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/compileall.py",
-            "${libdir}/python${PYTHON_MAJMIN}/filecmp.py",
-            "${libdir}/python${PYTHON_MAJMIN}/py_compile.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/compileall.*.p=
yc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/filecmp.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/py_compile.*.p=
yc"
-        ]
-    },
-    "compression": {
-        "summary": "Python high-level compression support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/gzip.py",
-            "${libdir}/python${PYTHON_MAJMIN}/tarfile.py",
-            "${libdir}/python${PYTHON_MAJMIN}/zipfile",
-            "${libdir}/python${PYTHON_MAJMIN}/zipfile/_path"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/gzip.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/tarfile.*.pyc"
-        ]
-    },
-    "core": {
-        "summary": "Python interpreter and core modules",
-        "rdepends": ["compression"],
-        "files": [
-            "${bindir}/python${PYTHON_MAJMIN}",
-            "${bindir}/python${PYTHON_MAJMIN}.real",
-            "${bindir}/python3",
-            "${includedir}/python${PYTHON_MAJMIN}/pyconfig*.h",
-            "${libdir}/python${PYTHON_MAJMIN}/UserDict.py",
-            "${libdir}/python${PYTHON_MAJMIN}/UserList.py",
-            "${libdir}/python${PYTHON_MAJMIN}/UserString.py",
-            "${libdir}/python${PYTHON_MAJMIN}/__future__.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_abcoll.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_bootlocale.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_collections_abc.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_colorize.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_compression.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_markupbase.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_opcode_metadata.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_pyrepl",
-            "${libdir}/python${PYTHON_MAJMIN}/_pyrepl/pager.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_sitebuiltins.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_sysconfigdata*.py",
-            "${libdir}/python${PYTHON_MAJMIN}/_weakrefset.py",
-            "${libdir}/python${PYTHON_MAJMIN}/abc.py",
-            "${libdir}/python${PYTHON_MAJMIN}/argparse.py",
-            "${libdir}/python${PYTHON_MAJMIN}/ast.py",
-            "${libdir}/python${PYTHON_MAJMIN}/bisect.py",
-            "${libdir}/python${PYTHON_MAJMIN}/bz2.py",
-            "${libdir}/python${PYTHON_MAJMIN}/code.py",
-            "${libdir}/python${PYTHON_MAJMIN}/codecs.py",
-            "${libdir}/python${PYTHON_MAJMIN}/codeop.py",
-            "${libdir}/python${PYTHON_MAJMIN}/collections",
-            "${libdir}/python${PYTHON_MAJMIN}/collections/abc.py",
-            "${libdir}/python${PYTHON_MAJMIN}/configparser.py",
-            "${libdir}/python${PYTHON_MAJMIN}/contextlib.py",
-            "${libdir}/python${PYTHON_MAJMIN}/copy.py",
-            "${libdir}/python${PYTHON_MAJMIN}/copyreg.py",
-            "${libdir}/python${PYTHON_MAJMIN}/csv.py",
-            "${libdir}/python${PYTHON_MAJMIN}/dataclasses.py",
-            "${libdir}/python${PYTHON_MAJMIN}/dis.py",
-            "${libdir}/python${PYTHON_MAJMIN}/encodings",
-            "${libdir}/python${PYTHON_MAJMIN}/encodings/aliases.py",
-            "${libdir}/python${PYTHON_MAJMIN}/encodings/latin_1.py",
-            "${libdir}/python${PYTHON_MAJMIN}/encodings/utf_8.py",
-            "${libdir}/python${PYTHON_MAJMIN}/enum.py",
-            "${libdir}/python${PYTHON_MAJMIN}/fnmatch.py",
-            "${libdir}/python${PYTHON_MAJMIN}/functools.py",
-            "${libdir}/python${PYTHON_MAJMIN}/genericpath.py",
-            "${libdir}/python${PYTHON_MAJMIN}/getopt.py",
-            "${libdir}/python${PYTHON_MAJMIN}/gettext.py",
-            "${libdir}/python${PYTHON_MAJMIN}/glob.py",
-            "${libdir}/python${PYTHON_MAJMIN}/heapq.py",
-            "${libdir}/python${PYTHON_MAJMIN}/imp.py",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/_abc.py",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/_bootstrap.py",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/_bootstrap_exter=
nal.py",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/abc.py",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/machinery.py",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/util.py",
-            "${libdir}/python${PYTHON_MAJMIN}/inspect.py",
-            "${libdir}/python${PYTHON_MAJMIN}/io.py",
-            "${libdir}/python${PYTHON_MAJMIN}/ipaddress.py",
-            "${libdir}/python${PYTHON_MAJMIN}/keyword.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/__pycache__/_s=
truct.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/__pycache__/bi=
nascii.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/__pycache__/ti=
me.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/__pycache__/xr=
eadlines.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_bisect.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_bz2.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_csv.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_heapq.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_lzma.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_opcode.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_posixsubproce=
ss.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_struct.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_typing.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/array.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/binascii.*.so"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/fcntl.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/grp.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/math.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/parser.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/readline.*.so"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/select.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/time.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/unicodedata.*.=
so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/xreadlines.*.s=
o",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/zlib.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/linecache.py",
-            "${libdir}/python${PYTHON_MAJMIN}/locale.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lzma.py",
-            "${libdir}/python${PYTHON_MAJMIN}/new.py",
-            "${libdir}/python${PYTHON_MAJMIN}/ntpath.py",
-            "${libdir}/python${PYTHON_MAJMIN}/opcode.py",
-            "${libdir}/python${PYTHON_MAJMIN}/operator.py",
-            "${libdir}/python${PYTHON_MAJMIN}/optparse.py",
-            "${libdir}/python${PYTHON_MAJMIN}/os.py",
-            "${libdir}/python${PYTHON_MAJMIN}/pathlib",
-            "${libdir}/python${PYTHON_MAJMIN}/pathlib.py",
-            "${libdir}/python${PYTHON_MAJMIN}/pathlib/_abc.py",
-            "${libdir}/python${PYTHON_MAJMIN}/pathlib/_local.py",
-            "${libdir}/python${PYTHON_MAJMIN}/pkgutil.py",
-            "${libdir}/python${PYTHON_MAJMIN}/platform.py",
-            "${libdir}/python${PYTHON_MAJMIN}/posixpath.py",
-            "${libdir}/python${PYTHON_MAJMIN}/re",
-            "${libdir}/python${PYTHON_MAJMIN}/re/_casefix.py",
-            "${libdir}/python${PYTHON_MAJMIN}/re/_compiler.py",
-            "${libdir}/python${PYTHON_MAJMIN}/re/_constants.py",
-            "${libdir}/python${PYTHON_MAJMIN}/re/_parser.py",
-            "${libdir}/python${PYTHON_MAJMIN}/reprlib.py",
-            "${libdir}/python${PYTHON_MAJMIN}/rlcompleter.py",
-            "${libdir}/python${PYTHON_MAJMIN}/runpy.py",
-            "${libdir}/python${PYTHON_MAJMIN}/selectors.py",
-            "${libdir}/python${PYTHON_MAJMIN}/shutil.py",
-            "${libdir}/python${PYTHON_MAJMIN}/signal.py",
-            "${libdir}/python${PYTHON_MAJMIN}/site.py",
-            "${libdir}/python${PYTHON_MAJMIN}/sitecustomize.py",
-            "${libdir}/python${PYTHON_MAJMIN}/sre_compile.py",
-            "${libdir}/python${PYTHON_MAJMIN}/sre_constants.py",
-            "${libdir}/python${PYTHON_MAJMIN}/sre_parse.py",
-            "${libdir}/python${PYTHON_MAJMIN}/stat.py",
-            "${libdir}/python${PYTHON_MAJMIN}/stringprep.py",
-            "${libdir}/python${PYTHON_MAJMIN}/struct.py",
-            "${libdir}/python${PYTHON_MAJMIN}/subprocess.py",
-            "${libdir}/python${PYTHON_MAJMIN}/symbol.py",
-            "${libdir}/python${PYTHON_MAJMIN}/sysconfig",
-            "${libdir}/python${PYTHON_MAJMIN}/sysconfig.py",
-            "${libdir}/python${PYTHON_MAJMIN}/textwrap.py",
-            "${libdir}/python${PYTHON_MAJMIN}/threading.py",
-            "${libdir}/python${PYTHON_MAJMIN}/token.py",
-            "${libdir}/python${PYTHON_MAJMIN}/tokenize.py",
-            "${libdir}/python${PYTHON_MAJMIN}/traceback.py",
-            "${libdir}/python${PYTHON_MAJMIN}/types.py",
-            "${libdir}/python${PYTHON_MAJMIN}/typing.py",
-            "${libdir}/python${PYTHON_MAJMIN}/urllib",
-            "${libdir}/python${PYTHON_MAJMIN}/urllib/parse.py",
-            "${libdir}/python${PYTHON_MAJMIN}/warnings.py",
-            "${libdir}/python${PYTHON_MAJMIN}/weakref.py",
-            "${libdir}/python${PYTHON_MAJMIN}/zipimport.py",
-            "${prefix}/lib/python${PYTHON_MAJMIN}/config*/*[!.a]"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/__future__.*.p=
yc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_bootlocale.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_collections_a=
bc.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_colorize.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_compression.*=
.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_markupbase.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_opcode_metada=
ta.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_sitebuiltins.=
*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_sysconfigdata=
*.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_weakrefset.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/abc.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/argparse.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/ast.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/bisect.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/bz2.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/code.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/codecs.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/codeop.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/configparser.*=
.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/contextlib.*.p=
yc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/copy.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/copyreg.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/csv.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/dataclasses.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/dis.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/enum.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/fnmatch.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/functools.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/genericpath.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/getopt.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/gettext.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/glob.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/heapq.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/imp.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/inspect.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/io.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/ipaddress.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/keyword.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/linecache.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/locale.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/lzma.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/ntpath.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/opcode.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/operator.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/optparse.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/os.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pathlib.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pkgutil.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/platform.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/posixpath.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/re.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/reprlib.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/rlcompleter.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/runpy.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/selectors.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/shutil.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/signal.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/site.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/sre_compile.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/sre_constants.=
*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/sre_parse.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/stat.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/stringprep.*.p=
yc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/struct.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/subprocess.*.p=
yc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/symbol.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/sysconfig.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/textwrap.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/threading.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/token.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/tokenize.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/traceback.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/types.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/typing.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/warnings.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/weakref.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/_pyrepl/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/_pyrepl/__pycache__/pager.=
*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/collections/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/collections/__pycache__/ab=
c.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/encodings/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/encodings/__pycache__/alia=
ses.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/encodings/__pycache__/lati=
n_1.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/encodings/__pycache__/utf_=
8.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/__pycache__/_abc=
.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/__pycache__/abc.=
*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/__pycache__/mach=
inery.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/importlib/__pycache__/util=
.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/pathlib/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/pathlib/__pycache__/_abc.*=
.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/pathlib/__pycache__/_local=
.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/re/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/re/__pycache__/_casefix.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/re/__pycache__/_compiler.*=
.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/re/__pycache__/_constants.=
*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/re/__pycache__/_parser.*.p=
yc",
-            "${libdir}/python${PYTHON_MAJMIN}/sysconfig/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/urllib/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/urllib/__pycache__/parse.*=
.pyc"
-        ]
-    },
-    "crypt": {
-        "summary": "Python basic cryptographic and hashing support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/hashlib.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_blake2.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_hashlib.*.so"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_md5.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_sha1.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_sha2.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_sha3.*.so"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/hashlib.*.pyc"
-        ]
-    },
-    "ctypes": {
-        "summary": "Python C types support",
-        "rdepends": [
-            "core",
-            "io",
-            "math"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/ctypes",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_ctypes.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_ctypes_test.*=
.so"
-        ],
-        "cached": []
-    },
-    "curses": {
-        "summary": "Python curses support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/curses",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_curses.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_curses_panel.=
*.so"
-        ],
-        "cached": []
-    },
-    "datetime": {
-        "summary": "Python calendar and time support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/_strptime.py",
-            "${libdir}/python${PYTHON_MAJMIN}/calendar.py",
-            "${libdir}/python${PYTHON_MAJMIN}/datetime.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_datetime.*.so=
"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_strptime.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/calendar.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/datetime.*.pyc=
"
-        ]
-    },
-    "db": {
-        "summary": "Python file-based database support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/dbm",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_dbm.*.so"
-        ],
-        "cached": []
-    },
-    "debugger": {
-        "summary": "Python debugger",
-        "rdepends": [
-            "core",
-            "pprint",
-            "shell",
-            "stringold"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/bdb.py",
-            "${libdir}/python${PYTHON_MAJMIN}/pdb.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/bdb.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pdb.*.pyc"
-        ]
-    },
-    "dev": {
-        "cached": [],
-        "files": [
-            "${base_libdir}/*.a",
-            "${base_libdir}/*.o",
-            "${bindir}/python*-config*",
-            "${datadir}/aclocal",
-            "${datadir}/pkgconfig",
-            "${includedir}",
-            "${libdir}/*.a",
-            "${libdir}/*.la",
-            "${libdir}/*.o",
-            "${libdir}/lib*${SOLIBSDEV}",
-            "${libdir}/pkgconfig"
-        ],
-        "rdepends": [
-            "core"
-        ],
-        "summary": "Python development package"
-    },
-    "difflib": {
-        "summary": "Python helpers for computing deltas between objects"=
,
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/difflib.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/difflib.*.pyc"
-        ]
-    },
-    "doctest": {
-        "summary": "Python framework for running examples in docstrings"=
,
-        "rdepends": [
-            "core",
-            "debugger",
-            "difflib",
-            "pprint",
-            "shell",
-            "stringold",
-            "unittest"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/doctest.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/doctest.*.pyc"
-        ]
-    },
-    "email": {
-        "summary": "Python email support",
-        "rdepends": [
-            "core",
-            "datetime",
-            "io",
-            "math",
-            "mime",
-            "netclient",
-            "stringold"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/email",
-            "${libdir}/python${PYTHON_MAJMIN}/imaplib.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/imaplib.*.pyc"
-        ]
-    },
-    "ensurepip": {
-        "summary": "Support for bootstrapping the pip installer",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/ensurepip/"
-        ],
-        "cached": []
-    },
-    "fcntl": {
-        "summary": "Python's fcntl interface",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/fcntl.*.so"
-        ],
-        "cached": []
-    },
-    "gdbm": {
-        "summary": "Python GNU database support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_gdbm.*.so"
-        ],
-        "cached": []
-    },
-    "html": {
-        "summary": "Python HTML processing support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/html"
-        ],
-        "cached": []
-    },
-    "idle": {
-        "summary": "Python Integrated Development Environment",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${bindir}/idle*",
-            "${libdir}/python${PYTHON_MAJMIN}/idlelib"
-        ],
-        "cached": []
-    },
-    "image": {
-        "summary": "Python graphical image handling",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/colorsys.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/colorsys.*.pyc=
"
-        ]
-    },
-    "io": {
-        "summary": "Python low-level I/O",
-        "rdepends": [
-            "core",
-            "math",
-            "netclient"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/_pyio.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_socket.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_ssl.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/termios.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/socket.py",
-            "${libdir}/python${PYTHON_MAJMIN}/ssl.py",
-            "${libdir}/python${PYTHON_MAJMIN}/tempfile.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_pyio.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/socket.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/ssl.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/tempfile.*.pyc=
"
-        ]
-    },
-    "json": {
-        "summary": "Python JSON support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/json",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_json.*.so"
-        ],
-        "cached": []
-    },
-    "logging": {
-        "summary": "Python logging support",
-        "rdepends": [
-            "core",
-            "io",
-            "netserver",
-            "pickle",
-            "stringold",
-            "threading"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/logging"
-        ],
-        "cached": []
-    },
-    "mailbox": {
-        "summary": "Python mailbox format support",
-        "rdepends": [
-            "core",
-            "datetime",
-            "email",
-            "io",
-            "math",
-            "mime",
-            "netclient",
-            "stringold"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/mailbox.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/mailbox.*.pyc"
-        ]
-    },
-    "math": {
-        "summary": "Python math support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_random.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/cmath.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/random.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/random.*.pyc"
-        ]
-    },
-    "mime": {
-        "summary": "Python MIME handling APIs",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/quopri.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/quopri.*.pyc"
-        ]
-    },
-    "mmap": {
-        "summary": "Python memory-mapped file support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/mmap.*.so"
-        ],
-        "cached": []
-    },
-    "modules": {
-        "cached": [],
-        "files": [],
-        "rdepends": [
-            "asyncio",
-            "audio",
-            "codecs",
-            "compile",
-            "compression",
-            "core",
-            "crypt",
-            "ctypes",
-            "curses",
-            "datetime",
-            "db",
-            "debugger",
-            "difflib",
-            "doctest",
-            "email",
-            "ensurepip",
-            "fcntl",
-            "html",
-            "idle",
-            "image",
-            "io",
-            "json",
-            "logging",
-            "mailbox",
-            "math",
-            "mime",
-            "mmap",
-            "multiprocessing",
-            "netclient",
-            "netserver",
-            "numbers",
-            "pickle",
-            "pkgutil",
-            "plistlib",
-            "pprint",
-            "profile",
-            "pydoc",
-            "resource",
-            "shell",
-            "sqlite3",
-            "statistics",
-            "stringold",
-            "syslog",
-            "terminal",
-            "threading",
-            "tkinter",
-            "tomllib",
-            "unittest",
-            "unixadmin",
-            "venv",
-            "xml",
-            "xmlrpc",
-            "zoneinfo"
-        ],
-        "summary": "All Python modules"
-    },
-    "multiprocessing": {
-        "summary": "Python multiprocessing support",
-        "rdepends": [
-            "core",
-            "crypt",
-            "ctypes",
-            "io",
-            "math",
-            "mmap",
-            "netclient",
-            "pickle",
-            "threading"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_multiprocessi=
ng.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_posixshmem.*.=
so",
-            "${libdir}/python${PYTHON_MAJMIN}/multiprocessing"
-        ],
-        "cached": []
-    },
-    "netclient": {
-        "summary": "Python Internet Protocol clients",
-        "rdepends": [
-            "core",
-            "crypt",
-            "datetime",
-            "email",
-            "io",
-            "math",
-            "mime",
-            "stringold"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/base64.py",
-            "${libdir}/python${PYTHON_MAJMIN}/ftplib.py",
-            "${libdir}/python${PYTHON_MAJMIN}/hmac.py",
-            "${libdir}/python${PYTHON_MAJMIN}/http",
-            "${libdir}/python${PYTHON_MAJMIN}/http/__pycache__",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_uuid.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/mimetypes.py",
-            "${libdir}/python${PYTHON_MAJMIN}/poplib.py",
-            "${libdir}/python${PYTHON_MAJMIN}/secrets.py",
-            "${libdir}/python${PYTHON_MAJMIN}/smtplib.py",
-            "${libdir}/python${PYTHON_MAJMIN}/urllib",
-            "${libdir}/python${PYTHON_MAJMIN}/uuid.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/base64.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/ftplib.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/hmac.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/mimetypes.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/poplib.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/secrets.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/smtplib.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/uuid.*.pyc"
-        ]
-    },
-    "netserver": {
-        "summary": "Python Internet Protocol servers",
-        "rdepends": [
-            "core",
-            "io"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/socketserver.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/socketserver.*=
.pyc"
-        ]
-    },
-    "numbers": {
-        "summary": "Python number APIs",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/_pydecimal.py",
-            "${libdir}/python${PYTHON_MAJMIN}/contextvars.py",
-            "${libdir}/python${PYTHON_MAJMIN}/decimal.py",
-            "${libdir}/python${PYTHON_MAJMIN}/fractions.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_contextvars.*=
.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_decimal.*.so"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/numbers.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_pydecimal.*.p=
yc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/contextvars.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/decimal.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/fractions.*.py=
c",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/numbers.*.pyc"
-        ]
-    },
-    "pickle": {
-        "summary": "Python serialisation/persistence support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/_compat_pickle.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_pickle.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/pickle.py",
-            "${libdir}/python${PYTHON_MAJMIN}/pickletools.py",
-            "${libdir}/python${PYTHON_MAJMIN}/shelve.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_compat_pickle=
.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pickle.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pickletools.*.=
pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/shelve.*.pyc"
-        ]
-    },
-    "pkgutil": {
-        "summary": "Python package extension utility support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [],
-        "cached": []
-    },
-    "plistlib": {
-        "summary": "Generate and parse Mac OS X .plist files",
-        "rdepends": [
-            "core",
-            "datetime",
-            "xml"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/plistlib.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/plistlib.*.pyc=
"
-        ]
-    },
-    "pprint": {
-        "summary": "Python pretty-print support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/pprint.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pprint.*.pyc"
-        ]
-    },
-    "profile": {
-        "summary": "Python basic performance profiling support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/cProfile.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_lsprof.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/profile.py",
-            "${libdir}/python${PYTHON_MAJMIN}/pstats.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/cProfile.*.pyc=
",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/profile.*.pyc"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pstats.*.pyc"
-        ]
-    },
-    "pydoc": {
-        "summary": "Python interactive help support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${bindir}/pydoc*",
-            "${libdir}/python${PYTHON_MAJMIN}/pydoc.py",
-            "${libdir}/python${PYTHON_MAJMIN}/pydoc_data"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pydoc.*.pyc"
-        ]
-    },
-    "resource": {
-        "summary": "Python resource control interface",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/resource.*.so"
-        ],
-        "cached": []
-    },
-    "shell": {
-        "summary": "Python shell-like functionality",
-        "rdepends": [
-            "core",
-            "stringold"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/cmd.py",
-            "${libdir}/python${PYTHON_MAJMIN}/shlex.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/cmd.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/shlex.*.pyc"
-        ]
-    },
-    "sqlite3": {
-        "summary": "Python Sqlite3 database support",
-        "rdepends": [
-            "core",
-            "datetime"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_sqlite3.*.so"=
,
-            "${libdir}/python${PYTHON_MAJMIN}/sqlite3"
-        ],
-        "cached": []
-    },
-    "statistics": {
-        "summary": "Basic statistics module",
-        "rdepends": [
-            "core",
-            "math",
-            "numbers"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_statistics.*.=
so",
-            "${libdir}/python${PYTHON_MAJMIN}/statistics.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/statistics.*.p=
yc"
-        ]
-    },
-    "stringold": {
-        "summary": "Common string operations",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/string.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/string.*.pyc"
-        ]
-    },
-    "syslog": {
-        "summary": "Python syslog interface",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/syslog.*.so"
-        ],
-        "cached": []
-    },
-    "terminal": {
-        "summary": "Python terminal controlling support",
-        "rdepends": [
-            "core",
-            "io"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/pty.py",
-            "${libdir}/python${PYTHON_MAJMIN}/tty.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/pty.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/tty.*.pyc"
-        ]
-    },
-    "threading": {
-        "summary": "Python threading & synchronization support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/_threading_local.py",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_queue.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/queue.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/_threading_loc=
al.*.pyc",
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/queue.*.pyc"
-        ]
-    },
-    "tkinter": {
-        "summary": "Python Tcl/Tk bindings",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/tkinter"
-        ],
-        "cached": []
-    },
-    "tomllib": {
-        "summary": "Provides an interface for parsing TOML",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/tomllib/"
-        ],
-        "cached": []
-    },
-    "unittest": {
-        "summary": "Python unit testing framework",
-        "rdepends": [
-            "asyncio",
-            "core",
-            "difflib",
-            "io",
-            "logging",
-            "netclient",
-            "numbers",
-            "pprint",
-            "stringold"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/unittest",
-            "${libdir}/python${PYTHON_MAJMIN}/unittest/",
-            "${libdir}/python${PYTHON_MAJMIN}/unittest/__pycache__"
-        ],
-        "cached": []
-    },
-    "unixadmin": {
-        "summary": "Python Unix administration support",
-        "rdepends": [
-            "core",
-            "io"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/getpass.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/getpass.*.pyc"
-        ]
-    },
-    "venv": {
-        "summary": "Provides support for creating lightweight virtual en=
vironments with their own site directories, optionally isolated from syst=
em site directories.",
-        "rdepends": [
-            "core",
-            "logging",
-            "stringold"
-        ],
-        "files": [
-            "${bindir}/pyvenv*",
-            "${libdir}/python${PYTHON_MAJMIN}/venv"
-        ],
-        "cached": []
-    },
-    "xml": {
-        "summary": "Python basic XML support",
-        "rdepends": [
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_elementtree.*=
.so",
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/pyexpat.*.so",
-            "${libdir}/python${PYTHON_MAJMIN}/xml"
-        ],
-        "cached": []
-    },
-    "xmlrpc": {
-        "summary": "Python XML-RPC support",
-        "rdepends": [
-            "compression",
-            "core",
-            "datetime",
-            "email",
-            "html",
-            "io",
-            "mime",
-            "netclient",
-            "netserver",
-            "numbers",
-            "pydoc",
-            "stringold",
-            "xml"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/xmlrpc",
-            "${libdir}/python${PYTHON_MAJMIN}/xmlrpc/__pycache__"
-        ],
-        "cached": []
-    },
-    "zipapp": {
-        "summary": "Tools to manage the creation of zip files containing=
 Python code",
-        "rdepends": [
-            "compression",
-            "core"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/zipapp.py"
-        ],
-        "cached": [
-            "${libdir}/python${PYTHON_MAJMIN}/__pycache__/zipapp.*.pyc"
-        ]
-    },
-    "zoneinfo": {
-        "summary": "IANA time zone support",
-        "rdepends": [
-            "core",
-            "datetime"
-        ],
-        "files": [
-            "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_zoneinfo.*.so=
",
-            "${libdir}/python${PYTHON_MAJMIN}/zoneinfo"
-        ],
-        "cached": []
-    }
-}
diff --git a/recipes-devtools/python/python3/reformat_sysconfig.py b/reci=
pes-devtools/python/python3/reformat_sysconfig.py
deleted file mode 100644
index 5e2b128..0000000
--- a/recipes-devtools/python/python3/reformat_sysconfig.py
+++ /dev/null
@@ -1,21 +0,0 @@
-#! /usr/bin/env python3
-#
-# SPDX-License-Identifier: MIT
-#
-# Copyright 2019 by Garmin Ltd. or its subsidiaries
-#
-# A script to reformat python sysconfig
-
-import sys
-import pprint
-l =3D {}
-g =3D {}
-with open(sys.argv[1], 'r') as f:
-    exec(f.read(), g, l)
-
-with open(sys.argv[1], 'w') as f:
-    for k in sorted(l.keys()):
-        f.write('%s =3D ' % k)
-        pprint.pprint(l[k], stream=3Df, width=3D1)
-        f.write('\n')
-
diff --git a/recipes-devtools/python/python3/run-ptest b/recipes-devtools=
/python/python3/run-ptest
deleted file mode 100644
index d1c26c1..0000000
--- a/recipes-devtools/python/python3/run-ptest
+++ /dev/null
@@ -1,3 +0,0 @@
-#!/bin/sh
-SKIPPED_TESTS=3D
-{ SETUPTOOLS_USE_DISTUTILS=3Dnonlocal python3 -m test $SKIPPED_TESTS -v =
-j 4 || echo "FAIL: python3" ; } | sed -u -e '/\.\.\. ok/ s/^/PASS: /g' -=
r -e '/\.\.\. (ERROR|FAIL)/ s/^/FAIL: /g' -e '/\.\.\. skipped/ s/^/SKIP: =
/g' -e 's/ \.\.\. ok//g' -e 's/ \.\.\. ERROR//g' -e 's/ \.\.\. FAIL//g' -=
e 's/ \.\.\. skipped//g'
diff --git a/recipes-devtools/python/python3/valid-dists.patch b/recipes-=
devtools/python/python3/valid-dists.patch
deleted file mode 100644
index 38b6ebc..0000000
--- a/recipes-devtools/python/python3/valid-dists.patch
+++ /dev/null
@@ -1,164 +0,0 @@
-From a65c29adc027b3615154cab73aaedd58a6aa23da Mon Sep 17 00:00:00 2001
-From: "Jason R. Coombs" <jaraco@jaraco.com>
-Date: Tue, 23 Jul 2024 08:36:16 -0400
-Subject: [PATCH] Prioritize valid dists to invalid dists when retrieving=
 by
- name.
-
-Closes python/importlib_metadata#489
-
-Upstream-Status: Backport [https://github.com/python/importlib_metadata/=
commit/a65c29adc027b3615154cab73aaedd58a6aa23da]
-Signed-off-by: Ross Burton <ross.burton@arm.com>
----
- Lib/importlib/metadata/__init__.py   | 14 +++-
- Lib/importlib/metadata/_itertools.py | 98 ++++++++++++++++++++++++++++
- 2 files changed, 110 insertions(+), 2 deletions(-)
-
-diff --git a/Lib/importlib/metadata/__init__.py b/Lib/importlib/metadata=
/__init__.py
-index 8ce62dd..085378c 100644
---- a/Lib/importlib/metadata/__init__.py
-+++ b/Lib/importlib/metadata/__init__.py
-@@ -21,7 +21,7 @@ import collections
- from . import _meta
- from ._collections import FreezableDefaultDict, Pair
- from ._functools import method_cache, pass_none
--from ._itertools import always_iterable, unique_everseen
-+from ._itertools import always_iterable, bucket, unique_everseen
- from ._meta import PackageMetadata, SimplePath
-=20
- from contextlib import suppress
-@@ -404,7 +404,7 @@ class Distribution(DeprecatedNonAbstract):
-         if not name:
-             raise ValueError("A distribution name is required.")
-         try:
--            return next(iter(cls.discover(name=3Dname)))
-+            return next(iter(cls._prefer_valid(cls.discover(name=3Dname=
))))
-         except StopIteration:
-             raise PackageNotFoundError(name)
-=20
-@@ -428,6 +428,16 @@ class Distribution(DeprecatedNonAbstract):
-             resolver(context) for resolver in cls._discover_resolvers()
-         )
-=20
-+    @staticmethod
-+    def _prefer_valid(dists: Iterable[Distribution]) -> Iterable[Distri=
bution]:
-+        """
-+        Prefer (move to the front) distributions that have metadata.
-+
-+        Ref python/importlib_resources#489.
-+        """
-+        buckets =3D bucket(dists, lambda dist: bool(dist.metadata))
-+        return itertools.chain(buckets[True], buckets[False])
-+
-     @staticmethod
-     def at(path: str | os.PathLike[str]) -> Distribution:
-         """Return a Distribution for the indicated metadata path.
-diff --git a/Lib/importlib/metadata/_itertools.py b/Lib/importlib/metada=
ta/_itertools.py
-index d4ca9b9..79d3719 100644
---- a/Lib/importlib/metadata/_itertools.py
-+++ b/Lib/importlib/metadata/_itertools.py
-@@ -1,3 +1,4 @@
-+from collections import defaultdict, deque
- from itertools import filterfalse
-=20
-=20
-@@ -71,3 +72,100 @@ def always_iterable(obj, base_type=3D(str, bytes)):
-         return iter(obj)
-     except TypeError:
-         return iter((obj,))
-+
-+
-+# Copied from more_itertools 10.3
-+class bucket:
-+    """Wrap *iterable* and return an object that buckets the iterable i=
nto
-+    child iterables based on a *key* function.
-+
-+        >>> iterable =3D ['a1', 'b1', 'c1', 'a2', 'b2', 'c2', 'b3']
-+        >>> s =3D bucket(iterable, key=3Dlambda x: x[0])  # Bucket by 1=
st character
-+        >>> sorted(list(s))  # Get the keys
-+        ['a', 'b', 'c']
-+        >>> a_iterable =3D s['a']
-+        >>> next(a_iterable)
-+        'a1'
-+        >>> next(a_iterable)
-+        'a2'
-+        >>> list(s['b'])
-+        ['b1', 'b2', 'b3']
-+
-+    The original iterable will be advanced and its items will be cached=
 until
-+    they are used by the child iterables. This may require significant =
storage.
-+
-+    By default, attempting to select a bucket to which no items belong =
 will
-+    exhaust the iterable and cache all values.
-+    If you specify a *validator* function, selected buckets will instea=
d be
-+    checked against it.
-+
-+        >>> from itertools import count
-+        >>> it =3D count(1, 2)  # Infinite sequence of odd numbers
-+        >>> key =3D lambda x: x % 10  # Bucket by last digit
-+        >>> validator =3D lambda x: x in {1, 3, 5, 7, 9}  # Odd digits =
only
-+        >>> s =3D bucket(it, key=3Dkey, validator=3Dvalidator)
-+        >>> 2 in s
-+        False
-+        >>> list(s[2])
-+        []
-+
-+    """
-+
-+    def __init__(self, iterable, key, validator=3DNone):
-+        self._it =3D iter(iterable)
-+        self._key =3D key
-+        self._cache =3D defaultdict(deque)
-+        self._validator =3D validator or (lambda x: True)
-+
-+    def __contains__(self, value):
-+        if not self._validator(value):
-+            return False
-+
-+        try:
-+            item =3D next(self[value])
-+        except StopIteration:
-+            return False
-+        else:
-+            self._cache[value].appendleft(item)
-+
-+        return True
-+
-+    def _get_values(self, value):
-+        """
-+        Helper to yield items from the parent iterator that match *valu=
e*.
-+        Items that don't match are stored in the local cache as they
-+        are encountered.
-+        """
-+        while True:
-+            # If we've cached some items that match the target value, e=
mit
-+            # the first one and evict it from the cache.
-+            if self._cache[value]:
-+                yield self._cache[value].popleft()
-+            # Otherwise we need to advance the parent iterator to searc=
h for
-+            # a matching item, caching the rest.
-+            else:
-+                while True:
-+                    try:
-+                        item =3D next(self._it)
-+                    except StopIteration:
-+                        return
-+                    item_value =3D self._key(item)
-+                    if item_value =3D=3D value:
-+                        yield item
-+                        break
-+                    elif self._validator(item_value):
-+                        self._cache[item_value].append(item)
-+
-+    def __iter__(self):
-+        for item in self._it:
-+            item_value =3D self._key(item)
-+            if self._validator(item_value):
-+                self._cache[item_value].append(item)
-+
-+        yield from self._cache.keys()
-+
-+    def __getitem__(self, value):
-+        if not self._validator(value):
-+            return iter(())
-+
-+        return self._get_values(value)
diff --git a/recipes-devtools/python/python3_3.13.11.bb b/recipes-devtool=
s/python/python3_3.13.11.bb
deleted file mode 100644
index defd30c..0000000
--- a/recipes-devtools/python/python3_3.13.11.bb
+++ /dev/null
@@ -1,490 +0,0 @@
-SUMMARY =3D "The Python Programming Language"
-HOMEPAGE =3D "http://www.python.org"
-DESCRIPTION =3D "Python is a programming language that lets you work mor=
e quickly and integrate your systems more effectively."
-LICENSE =3D "PSF-2.0"
-SECTION =3D "devel/python"
-
-LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D3f64a4ff490f884d562feb77bf243=
5f1"
-
-SRC_URI =3D "http://www.python.org/ftp/python/${PV}/Python-${PV}.tar.xz =
\
-           file://run-ptest \
-           file://create_manifest3.py \
-           file://get_module_deps3.py \
-           file://python3-manifest.json \
-           file://check_build_completeness.py \
-           file://reformat_sysconfig.py \
-           file://0001-Makefile.pre-use-qemu-wrapper-when-gathering-prof=
ile.patch \
-           file://0001-test_locale.py-correct-the-test-output-format.pat=
ch \
-           file://0001-Skip-failing-tests-due-to-load-variability-on-YP-=
AB.patch \
-           file://0001-test_ctypes.test_find-skip-without-tools-sdk.patc=
h \
-           file://makerace.patch \
-           file://0001-sysconfig.py-use-platlibdir-also-for-purelib.patc=
h \
-           file://0001-Lib-pty.py-handle-stdin-I-O-errors-same-way-as-ma=
ste.patch \
-           file://valid-dists.patch \
-           file://0001-Avoid-shebang-overflow-on-python-config.py.patch =
\
-           file://0001-Update-test_sysconfig-for-posix_user-purelib.patc=
h \
-           file://0001-skip-no_stdout_fileno-test-due-to-load-variabilit=
y.patch \
-           file://0001-test_storlines-skip-due-to-load-variability.patch=
 \
-           file://0001-test_shutdown-skip-problematic-test.patch \
-           file://0001-test_deadlock-skip-problematic-test.patch \
-           file://0001-test_active_children-skip-problematic-test.patch =
\
-           file://0001-test_readline-skip-limited-history-test.patch \
-           file://0001-Generate-data-for-OpenSSL-3.4-and-add-it-to-multi=
ssl.patch \
-           "
-SRC_URI:append:class-native =3D " \
-           file://0001-Lib-sysconfig.py-use-prefix-value-from-build-conf=
igu.patch \
-           "
-
-SRC_URI[sha256sum] =3D "16ede7bb7cdbfa895d11b0642fa0e523f291e6487194d53c=
f6d3b338c3a17ea2"
-
-# exclude pre-releases for both python 2.x and 3.x
-UPSTREAM_CHECK_REGEX =3D "[Pp]ython-(?P<pver>\d+(\.\d+)+).tar"
-
-CVE_PRODUCT =3D "python:python python_software_foundation:python cpython=
"
-
-PYTHON_MAJMIN =3D "3.13"
-
-S =3D "${UNPACKDIR}/Python-${PV}"
-
-BBCLASSEXTEND =3D "native nativesdk"
-
-inherit autotools pkgconfig qemu ptest multilib_header update-alternativ=
es
-
-MULTILIB_SUFFIX =3D "${@d.getVar('base_libdir',1).split('/')[-1]}"
-
-ALTERNATIVE:${PN}-dev =3D "python3-config"
-ALTERNATIVE_LINK_NAME[python3-config] =3D "${bindir}/python${PYTHON_MAJM=
IN}-config"
-ALTERNATIVE_TARGET[python3-config] =3D "${bindir}/python${PYTHON_MAJMIN}=
-config-${MULTILIB_SUFFIX}"
-
-DEPENDS =3D "\
-    autoconf-archive-native \
-    bzip2 \
-    bzip2-replacement-native \
-    expat \
-    libffi \
-    ncurses \
-    openssl \
-    sqlite3 \
-    util-linux-libuuid \
-    virtual/crypt \
-    virtual/libintl \
-    xz \
-    zlib \
-"
-
-DEPENDS:append:class-target =3D " python3-native"
-DEPENDS:append:class-nativesdk =3D " python3-native"
-
-EXTRA_OECONF =3D " --without-ensurepip --enable-shared --with-platlibdir=
=3D${baselib} --with-system-expat"
-EXTRA_OECONF:append:class-native =3D " --bindir=3D${bindir}/${PN}"
-EXTRA_OECONF:append:class-target =3D " --with-build-python=3Dnativepytho=
n3 PLATFORM_TRIPLET=3D${HOST_ARCH}-${HOST_OS}"
-EXTRA_OECONF:append:class-nativesdk =3D " --with-build-python=3Dnativepy=
thon3"
-
-export CROSSPYTHONPATH =3D "${STAGING_LIBDIR_NATIVE}/python${PYTHON_MAJM=
IN}/lib-dynload/"
-
-EXTRANATIVEPATH +=3D "python3-native"
-
-# LTO will be enabled via packageconfig depending upong distro features
-LTO:class-target =3D ""
-
-CACHED_CONFIGUREVARS =3D " \
-                ac_cv_file__dev_ptmx=3Dyes \
-                ac_cv_file__dev_ptc=3Dno \
-                ac_cv_working_tzset=3Dyes \
-"
-CACHED_CONFIGUREVARS:append:class-target =3D " \
-                ac_cv_libatomic_needed=3Dyes \
-"
-
-# set thread stack size to 2MB on musl for interpreter and stdlib C exte=
nsions
-# so it does not run into stack limits due to musl's small thread stack
-# This is only needed to build interpreter and not the subsequent module=
s
-# Thats why CFLAGS_NODIST is modified instead of CFLAGS
-CACHED_CONFIGUREVARS:append:libc-musl =3D "\
-    CFLAGS_NODIST=3D'${CFLAGS} -DTHREAD_STACK_SIZE=3D0x200000' \
-"
-
-# PGO currently causes builds to not be reproducible so disable by defau=
lt, see YOCTO #13407
-PACKAGECONFIG ??=3D "editline gdbm ${@bb.utils.filter('DISTRO_FEATURES',=
 'lto', d)}"
-PACKAGECONFIG[readline] =3D "--with-readline=3Dreadline,,readline,,,edit=
line"
-PACKAGECONFIG[editline] =3D "--with-readline=3Deditline,,libedit,,,readl=
ine"
-# Use profile guided optimisation by running PyBench inside qemu-user
-PACKAGECONFIG[pgo] =3D "--enable-optimizations,,qemu-native"
-PACKAGECONFIG[tk] =3D ",,tk"
-PACKAGECONFIG[tcl] =3D ",,tcl"
-PACKAGECONFIG[gdbm] =3D ",,gdbm"
-PACKAGECONFIG[lto] =3D "--with-lto,--without-lto"
-PACKAGECONFIG[staticlibpython] =3D "--with-static-libpython,--without-st=
atic-libpython"
-
-do_configure:prepend () {
-    mkdir -p ${B}/Modules
-    cat > ${B}/Modules/Setup.local << EOF
-*disabled*
-${@bb.utils.contains('PACKAGECONFIG', 'gdbm', '', '_gdbm _dbm', d)}
-${@bb.utils.contains_any('PACKAGECONFIG', 'readline editline', '', 'read=
line', d)}
-${@bb.utils.contains('PACKAGECONFIG', 'tk', '', '_tkinter', d)}
-EOF
-}
-
-CPPFLAGS +=3D "-I${STAGING_INCDIR}/ncursesw -I${STAGING_INCDIR}/uuid"
-
-# COMPILEALL_OPTS=3D ensures that .pyc are not compiled in parallel
-# This was found to lock up builds, break reproducibility, and produce s=
trange file ownership
-# races.
-#
-# The upstream commit introducing the change was:
-# https://github.com/python/cpython/commit/1a2dd82f56bd813aacc570e172cef=
e55a8a41504
-#
-# The build lock up issue is reported here:
-# https://bugs.python.org/issue45945
-#
-# The repro failures are documented here:
-# https://autobuilder.yocto.io/pub/repro-fail/oe-reproducible-20211130-y=
r_o1a8d/packages/diff-html/
-
-EXTRA_OEMAKE =3D '\
-  STAGING_LIBDIR=3D${STAGING_LIBDIR} \
-  STAGING_INCDIR=3D${STAGING_INCDIR} \
-  LIB=3D${baselib} \
-  COMPILEALL_OPTS=3D \
-'
-
-# Generate a Profile Guided Optimisation wrapper script that uses qemu-u=
ser for
-# all cross builds.
-write_pgo_wrapper:class-native =3D ":"
-write_pgo_wrapper() {
-       if ${@bb.utils.contains('PACKAGECONFIG', 'pgo', 'true', 'false', =
d)}; then
-                cat >pgo-wrapper <<EOF
-#!/bin/sh
-cd ${B}
-${@qemu_wrapper_cmdline(d, '${STAGING_DIR_TARGET}', ['${B}', '${STAGING_=
DIR_TARGET}/${base_libdir}'])} "\$@"
-EOF
-                chmod +x pgo-wrapper
-        fi
-}
-
-do_compile:prepend() {
-        write_pgo_wrapper
-}
-
-do_install:prepend() {
-        ${UNPACKDIR}/check_build_completeness.py ${T}/log.do_compile
-}
-
-do_install:append:class-target() {
-        oe_multilib_header python${PYTHON_MAJMIN}/pyconfig.h
-}
-
-do_install:append:class-native() {
-        # Make sure we use /usr/bin/env python
-        for PYTHSCRIPT in `grep -rIl ${bindir}/${PN}/python ${D}${bindir=
}/${PN}`; do
-                sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' $PYTHSCRIPT
-        done
-        # Add a symlink to the native Python so that scripts can just in=
voke
-        # "nativepython" and get the right one without needing absolute =
paths
-        # (these often end up too long for the #! parser in the kernel a=
s the
-        # buffer is 128 bytes long).
-        ln -s python3-native/python3 ${D}${bindir}/nativepython3
-
-        # Remove the opt-1.pyc and opt-2.pyc files. There are over 3,000=
 of them
-        # and the overhead in each recipe-sysroot-native isn't worth it,=
 particularly
-        # when they're only used for python called with -O or -OO.
-        #find ${D} -name *opt-*.pyc -delete
-        # Remove all pyc files. There are a ton of them and it is probab=
ly faster to let
-        # python create the ones it wants at runtime rather than manage =
in the sstate
-        # tarballs and sysroot creation.
-        find ${D} -name *.pyc -delete
-
-        # Nothing should be looking into ${B} for python3-native
-        sed -i -e 's:${B}:/build/path/unavailable/:g' \
-                ${D}/${libdir}/python${PYTHON_MAJMIN}/config-${PYTHON_MA=
JMIN}${PYTHON_ABI}*/Makefile
-
-        # disable the lookup in user's site-packages globally
-        sed -i 's#ENABLE_USER_SITE =3D None#ENABLE_USER_SITE =3D False#'=
 ${D}${libdir}/python${PYTHON_MAJMIN}/site.py
-
-        # python3-config needs to be in /usr/bin and not in a subdir of =
it to work properly
-        mv ${D}/${bindir}/${PN}/python*config ${D}/${bindir}/
-}
-
-do_install:append() {
-        for c in ${D}/${libdir}/python${PYTHON_MAJMIN}/_sysconfigdata*.p=
y; do
-            python3 ${UNPACKDIR}/reformat_sysconfig.py $c
-        done
-        rm -f ${D}${libdir}/python${PYTHON_MAJMIN}/__pycache__/_sysconfi=
gdata*.cpython*
-
-        mkdir -p ${D}${libdir}/python-sysconfigdata
-        sysconfigfile=3D`find ${D} -name _sysconfig*.py`
-        sed -i  \
-                -e "s,^ 'LIBDIR'.*, 'LIBDIR': '${STAGING_LIBDIR}'\,,g" \
-                -e "s,^ 'INCLUDEDIR'.*, 'INCLUDEDIR': '${STAGING_INCDIR}=
'\,,g" \
-                -e "s,^ 'CONFINCLUDEDIR'.*, 'CONFINCLUDEDIR': '${STAGING=
_INCDIR}'\,,g" \
-                -e "s,^ 'INCLUDEPY'.*, 'INCLUDEPY': '${STAGING_INCDIR}/p=
ython${PYTHON_MAJMIN}'\,,g" \
-                -e "s,^ 'CONFINCLUDEPY'.*, 'CONFINCLUDEPY': '${STAGING_I=
NCDIR}/python${PYTHON_MAJMIN}'\,,g" \
-                -e "s,${B},/build/path/unavailable/,g" \
-                $sysconfigfile
-        cp $sysconfigfile ${D}${libdir}/python-sysconfigdata/_sysconfigd=
ata.py
-
-        # Remove the opt-1.pyc and opt-2.pyc files. They effectively was=
te space on embedded
-        # style targets as they're only used when python is called with =
the -O or -OO options
-        # which is rare.
-        find ${D} -name *opt-*.pyc -delete
-}
-
-do_install:append:class-nativesdk () {
-    # Make sure we use /usr/bin/env python
-    for PYTHSCRIPT in `grep -rIl ${bindir}/python ${D}${bindir}`; do
-         sed -i -e '1s|^#!.*|#!/usr/bin/env python3|' $PYTHSCRIPT
-    done
-    create_wrapper ${D}${bindir}/python${PYTHON_MAJMIN} TERMINFO_DIRS=3D=
'${sysconfdir}/terminfo:/etc/terminfo:/usr/share/terminfo:/usr/share/misc=
/terminfo:/lib/terminfo' PYTHONNOUSERSITE=3D'1'
-}
-
-do_install_ptest:append:class-target:libc-musl () {
-    sed -i -e 's|SKIPPED_TESTS=3D|SKIPPED_TESTS=3D"-x test__locale -x te=
st_c_locale_coercion -x test_locale -x test_os test_re -x test__xxsubinte=
rpreters -x test_threading --ignore test.test_strptime.StrptimeTests.test=
_date_locale2 --ignore test.test_ctypes.test_dlerror.TestNullDlsym.test_n=
ull_dlsym"|' ${D}${PTEST_PATH}/run-ptest
-}
-
-SYSROOT_PREPROCESS_FUNCS:append:class-target =3D " provide_target_config=
_script"
-SYSROOT_PREPROCESS_FUNCS:append:class-nativesdk =3D " provide_target_con=
fig_script"
-
-# This is installed into /usr/python-target-config/ and not /usr/bin
-# because adding target sysroot's /usr/bin/ to PATH has unwanted side ef=
fects
-# in components erroneously picking up other target executables from it
-provide_target_config_script() {
-        install -d ${SYSROOT_DESTDIR}${prefix}/python-target-config/
-        install ${D}/${bindir}/python3-config ${SYSROOT_DESTDIR}/${prefi=
x}/python-target-config/
-        install ${D}/${bindir}/python${PYTHON_MAJMIN}-config ${SYSROOT_D=
ESTDIR}/${prefix}/python-target-config/
-}
-SYSROOT_DIRS +=3D "${prefix}/python-target-config/"
-
-SSTATE_SCAN_FILES +=3D "Makefile _sysconfigdata.py"
-SSTATE_HASHEQUIV_FILEMAP =3D " \
-    populate_sysroot:*/lib*/python3*/_sysconfigdata*.py:${TMPDIR} \
-    populate_sysroot:*/lib*/python3*/_sysconfigdata*.py:${COREBASE} \
-    populate_sysroot:*/lib*/python3*/config-*/Makefile:${TMPDIR} \
-    populate_sysroot:*/lib*/python3*/config-*/Makefile:${COREBASE} \
-    populate_sysroot:*/lib*/python-sysconfigdata/_sysconfigdata.py:${TMP=
DIR} \
-    populate_sysroot:*/lib*/python-sysconfigdata/_sysconfigdata.py:${COR=
EBASE} \
-    "
-PACKAGE_PREPROCESS_FUNCS +=3D "py_package_preprocess"
-
-py_package_preprocess () {
-        # Remove references to buildmachine paths in target Makefile and=
 _sysconfigdata
-        sed -i -e 's:--sysroot=3D${STAGING_DIR_TARGET}::g' -e s:'--with-=
libtool-sysroot=3D${STAGING_DIR_TARGET}'::g \
-                -e 's|${DEBUG_PREFIX_MAP}||g' \
-                -e 's:${HOSTTOOLS_DIR}/::g' \
-                -e 's:${RECIPE_SYSROOT_NATIVE}::g' \
-                -e 's:${RECIPE_SYSROOT}::g' \
-                -e 's:${BASE_WORKDIR}/${MULTIMACH_TARGET_SYS}::g' \
-                ${PKGD}/${libdir}/python${PYTHON_MAJMIN}/config-${PYTHON=
_MAJMIN}${PYTHON_ABI}*/Makefile \
-                ${PKGD}/${libdir}/python${PYTHON_MAJMIN}/_sysconfigdata*=
.py \
-                ${PKGD}/${bindir}/python${PYTHON_MAJMIN}-config
-
-        # Reformat _sysconfigdata after modifying it so that it remains
-        # reproducible
-        for c in ${PKGD}/${libdir}/python${PYTHON_MAJMIN}/_sysconfigdata=
*.py; do
-            python3 ${UNPACKDIR}/reformat_sysconfig.py $c
-        done
-
-        # Recompile _sysconfigdata after modifying it
-        cd ${PKGD}
-        sysconfigfile=3D`find . -name _sysconfigdata_*.py`
-        ${STAGING_BINDIR_NATIVE}/python3-native/python3 \
-             -c "from py_compile import compile; compile('$sysconfigfile=
')"
-        ${STAGING_BINDIR_NATIVE}/python3-native/python3 \
-             -c "from py_compile import compile; compile('$sysconfigfile=
', optimize=3D1)"
-        ${STAGING_BINDIR_NATIVE}/python3-native/python3 \
-             -c "from py_compile import compile; compile('$sysconfigfile=
', optimize=3D2)"
-        cd -
-
-        mv ${PKGD}/${bindir}/python${PYTHON_MAJMIN}-config ${PKGD}/${bin=
dir}/python${PYTHON_MAJMIN}-config-${MULTILIB_SUFFIX}
-
-        #Remove the unneeded copy of target sysconfig data
-        rm -rf ${PKGD}/${libdir}/python-sysconfigdata
-}
-
-# We want bytecode precompiled .py files (.pyc's) by default
-# but the user may set it on their own conf
-INCLUDE_PYCS ?=3D "1"
-
-python(){
-    import collections, json
-
-    filename =3D os.path.join(d.getVar('THISDIR'), 'python3', 'python3-m=
anifest.json')
-    # This python changes the datastore based on the contents of a file,=
 so mark
-    # that dependency.
-    bb.parse.mark_dependency(d, filename)
-
-    with open(filename) as manifest_file:
-        manifest_str =3D  manifest_file.read()
-        json_start =3D manifest_str.find('# EOC') + 6
-        manifest_file.seek(json_start)
-        manifest_str =3D manifest_file.read()
-        python_manifest =3D json.loads(manifest_str, object_pairs_hook=3D=
collections.OrderedDict)
-
-    # First set RPROVIDES for -native case
-    # Hardcoded since it cant be python3-native-foo, should be python3-f=
oo-native
-    pn =3D 'python3'
-    rprovides =3D (d.getVar('RPROVIDES') or "").split()
-
-    # ${PN}-misc-native is not in the manifest
-    rprovides.append(pn + '-misc-native')
-
-    for key in python_manifest:
-        pypackage =3D pn + '-' + key + '-native'
-        if pypackage not in rprovides:
-              rprovides.append(pypackage)
-
-    d.setVar('RPROVIDES:class-native', ' '.join(rprovides))
-
-    # Then work on the target
-    include_pycs =3D d.getVar('INCLUDE_PYCS')
-
-    packages =3D d.getVar('PACKAGES').split()
-    pn =3D d.getVar('PN')
-
-    newpackages=3D[]
-    for key in python_manifest:
-        pypackage =3D pn + '-' + key
-
-        if pypackage not in packages:
-            # We need to prepend, otherwise python-misc gets everything
-            # so we use a new variable
-            newpackages.append(pypackage)
-
-        # "Build" python's manifest FILES, RDEPENDS and SUMMARY
-        for value in python_manifest[key]['files']:
-            d.appendVar('FILES:' + pypackage, ' ' + value)
-
-        # Add cached files
-        if include_pycs =3D=3D '1':
-            for value in python_manifest[key]['cached']:
-                    d.appendVar('FILES:' + pypackage, ' ' + value)
-
-        for value in python_manifest[key]['rdepends']:
-            # Make it work with or without $PN
-            if '${PN}' in value:
-                value=3Dvalue.split('-', 1)[1]
-            d.appendVar('RDEPENDS:' + pypackage, ' ' + pn + '-' + value)
-
-        for value in python_manifest[key].get('rrecommends', ()):
-            if '${PN}' in value:
-                value=3Dvalue.split('-', 1)[1]
-            d.appendVar('RRECOMMENDS:' + pypackage, ' ' + pn + '-' + val=
ue)
-
-        d.setVar('SUMMARY:' + pypackage, python_manifest[key]['summary']=
)
-
-    # Prepending so to avoid python-misc getting everything
-    packages =3D newpackages + packages
-    d.setVar('PACKAGES', ' '.join(packages))
-    d.setVar('ALLOW_EMPTY:${PN}-fcntl', '1')
-    d.setVar('ALLOW_EMPTY:${PN}-modules', '1')
-    d.setVar('ALLOW_EMPTY:${PN}-pkgutil', '1')
-
-    if "pgo" in d.getVar("PACKAGECONFIG").split() and not bb.utils.conta=
ins('MACHINE_FEATURES', 'qemu-usermode', True, False, d):
-        bb.fatal("pgo cannot be enabled as there is no qemu-usermode sup=
port for this architecture/machine")
-}
-
-# Files needed to create a new manifest
-
-do_create_manifest() {
-    # This task should be run with every new release of Python.
-    # We must ensure that PACKAGECONFIG enables everything when creating
-    # a new manifest, this is to base our new manifest on a complete
-    # native python build, containing all dependencies, otherwise the ta=
sk
-    # wont be able to find the required files.
-    # e.g. BerkeleyDB is an optional build dependency so it may or may n=
ot
-    # be present, we must ensure it is.
-
-    cp ${UNPACKDIR}/create_manifest3.py ${WORKDIR}
-    cp ${UNPACKDIR}/python3-manifest.json ${WORKDIR}
-    cp ${UNPACKDIR}/get_module_deps3.py ${WORKDIR}
-    cd ${WORKDIR}
-    # This needs to be executed by python-native and NOT by HOST's pytho=
n
-    nativepython3 create_manifest3.py ${PYTHON_MAJMIN}
-    cp python3-manifest.json.new ${THISDIR}/python3/python3-manifest.jso=
n
-}
-
-# bitbake python -c create_manifest
-# Make sure we have native python ready when we create a new manifest
-addtask do_create_manifest after do_patch do_prepare_recipe_sysroot
-
-# manual dependency additions
-RRECOMMENDS:${PN}-core:append:class-nativesdk =3D " nativesdk-python3-mo=
dules"
-RRECOMMENDS:${PN}-crypt:append:class-target =3D " ${MLPREFIX}openssl ${M=
LPREFIX}ca-certificates"
-RRECOMMENDS:${PN}-crypt:append:class-nativesdk =3D " ${MLPREFIX}openssl =
${MLPREFIX}ca-certificates"
-
-# For historical reasons PN is empty and provided by python3-modules
-FILES:${PN} =3D ""
-RPROVIDES:${PN}-modules =3D "${PN}"
-
-FILES:${PN}-pydoc +=3D "${bindir}/pydoc${PYTHON_MAJMIN} ${bindir}/pydoc3=
"
-FILES:${PN}-idle +=3D "${bindir}/idle3 ${bindir}/idle${PYTHON_MAJMIN}"
-FILES:${PN}-tkinter +=3D "${libdir}/python${PYTHON_MAJMIN}/lib-dynload/_=
tkinter.*.so"
-
-# provide python-pyvenv from python3-venv
-RPROVIDES:${PN}-venv +=3D "${MLPREFIX}python3-pyvenv"
-
-# package libpython3
-PACKAGES =3D+ "libpython3 libpython3-staticdev"
-FILES:libpython3 =3D "${libdir}/libpython*.so.*"
-FILES:libpython3-staticdev +=3D "${libdir}/python${PYTHON_MAJMIN}/config=
-${PYTHON_MAJMIN}-*/libpython${PYTHON_MAJMIN}.a"
-INSANE_SKIP:${PN}-dev +=3D "dev-elf"
-INSANE_SKIP:${PN}-ptest =3D "dev-deps"
-
-# catch all the rest (unsorted)
-PACKAGES +=3D "${PN}-misc"
-RDEPENDS:${PN}-misc +=3D "\
-    ${PN}-audio \
-    ${PN}-codecs \
-    ${PN}-core \
-    ${PN}-email \
-    ${PN}-numbers \
-    ${PN}-pickle \
-    ${PN}-pydoc \
-"
-RDEPENDS:${PN}-modules:append:class-target =3D " ${MLPREFIX}python3-misc=
"
-RDEPENDS:${PN}-modules:append:class-nativesdk =3D " ${MLPREFIX}python3-m=
isc"
-RDEPENDS:${PN}-modules:append:class-target =3D " ${@bb.utils.contains('P=
ACKAGECONFIG', 'gdbm', '${MLPREFIX}python3-gdbm', '', d)}"
-FILES:${PN}-misc =3D "${libdir}/python${PYTHON_MAJMIN} ${libdir}/python$=
{PYTHON_MAJMIN}/lib-dynload"
-
-# catch manpage
-PACKAGES +=3D "${PN}-man"
-FILES:${PN}-man =3D "${datadir}/man"
-
-# See https://bugs.python.org/issue18748 and https://bugs.python.org/iss=
ue37395
-RDEPENDS:libpython3:append:libc-glibc =3D " libgcc"
-RRECOMMENDS:${PN}-ctypes:append:libc-glibc =3D " ${MLPREFIX}ldconfig"
-RDEPENDS:${PN}-ptest =3D "\
-    ${PN}-dev \
-    ${PN}-modules \
-    ${PN}-tests \
-    ${PN}-zipapp \
-    binutils \
-    bzip2 \
-    coreutils \
-    gcc \
-    gcc-symlinks \
-    g++ \
-    libgcc \
-    locale-base-fr-fr \
-    locale-base-en-us \
-    locale-base-de-de \
-    sed \
-    tzdata \
-    unzip \
-"
-RDEPENDS:${PN}-ptest:append:libc-glibc =3D " locale-base-tr-tr"
-RDEPENDS:${PN}-tkinter +=3D "${@bb.utils.contains('PACKAGECONFIG', 'tk',=
 '${MLPREFIX}tk ${MLPREFIX}tk-lib', '', d)}"
-RDEPENDS:${PN}-idle +=3D "${@bb.utils.contains('PACKAGECONFIG', 'tk', '$=
{PN}-tkinter ${MLPREFIX}tcl', '', d)}"
-DEV_PKG_DEPENDENCY =3D ""
-RDEPENDS:${PN}-pydoc +=3D "${PN}-io"
-
-RDEPENDS:${PN}-tests:append:class-target =3D " ${MLPREFIX}bash"
-RDEPENDS:${PN}-tests:append:class-nativesdk =3D " ${MLPREFIX}bash"
-
-# Python's tests contain large numbers of files we don't need in the rec=
ipe sysroots
-SYSROOT_PREPROCESS_FUNCS +=3D " py3_sysroot_cleanup"
-py3_sysroot_cleanup () {
-	rm -rf ${SYSROOT_DESTDIR}${libdir}/python${PYTHON_MAJMIN}/test
-}
-
-inherit features_check
-REQUIRED_DISTRO_FEATURES =3D "tensorflow"
--=20
2.34.1


