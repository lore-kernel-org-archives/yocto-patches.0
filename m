Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0164A103A987
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:38 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13687.1774405052632934250
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=T4XcL7YL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P2DEJv3459919
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=Te0UtcvBmFmzUVxZya2vr410/XNSR7hHfsdgqH3vdt8=; b=T4XcL7YLOgqU
	ElqnF7I6iQJoe3mrQ22N7WeE1hU7cYa6NHzsqOE1jKb31yUMPwxMo7fn84RGGWDB
	1+Xj+yqtsA9YLkHQJ7ZjkK14FZhyvuilKOHc+5x+WnTW5RlC2/XdhUvPL24ne7m9
	/H38XJFTGu8w9Rl4mWzao+6q4X7WkB4dvJsYTcX6HD2f1kv3YcupQXMn5lkEAAbC
	dFCWwULku8WFma7kZAzXLxL2F4KRKEplMAHr+PDhqmQCkECeqIZsmL4EbbZhTXsB
	No3XGGuwq3YpPp3IJBcs94vpQuBNkRvqdrzJfbYOkVFq1k/81tAm+AOqPJ+FqjHn
	ccZiFl8P0Q==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84dur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:31 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:30 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:29 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 10/14] Switch tf-keras to python3-keras 3.13.2
Date: Wed, 25 Mar 2026 10:17:15 +0800
Message-ID: <20260325021719.1526525-11-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AowBUJoRAwiovBqkApuqFw9S7IMWalox
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX5IHBJkFSJbV6
 mc4LkLVwYXBXM1oGOeqM1Gp+INqIWME4RX+k3N1ge8rJJ16J6xzus9uoZRriNtAKYv9NN+0Cp/v
 bBKDVxNzZOJlqCRFZ8OthyQyKLaRwXnzBi2y1ICa9LSHO6W6KFq3wwbDl2fXc0+dOA5TTWUScp7
 RHRN0nUSbBmMXlWAuLIugXn9fQPPF7unMbiteFw0+8i3jMk4jKjDn6xXE00XOfYikE+lz80cIW9
 xL5JMBJciN3z4LEjnUFkOcxvz2++l5OGphH6MO9+bI55G21JZRsJ/P0MQdSxHNYYFLzRZsBVQFP
 FTS8xuFMPfnwj7E/My/tfZhj73pAxK2diac44qmtzR0trAXbXTW64EZCgrIcrrk9B59xQEr2BEH
 bE6c7KxXvik3Y0SG5ZtPzX6UGfcOKeMbjtfSl2keKSXZbw3L1zn686vl7n8eBhQxic2u6CVMgVD
 zkJc9bG5jhiO1ZSxYEQ==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345bb cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=C6wcXyHOAAAA:20 a=mV9VRH-2AAAA:8 a=NEAV23lmAAAA:8
 a=CckQENj0AAAA:8 a=t7CeM3EgAAAA:8 a=HiJ0BAECEzt7ZTLwU58A:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: AowBUJoRAwiovBqkApuqFw9S7IMWalox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3546

Add LICENSE from https://github.com/keras-team/keras/blob/master/LICENSE

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 recipes-devtools/python/python3-keras/LICENSE | 201 ++++++++++++++++++
 .../python/python3-keras_3.13.2.bb            |  41 ++++
 .../tf-keras/0001-customize-for-yocto.patch   |  28 ---
 .../tf-keras/0001-skip-pip-file-check.patch   |  37 ----
 .../tensorflow/tf-keras_2.19.0.bb             |  63 ------
 5 files changed, 242 insertions(+), 128 deletions(-)
 create mode 100644 recipes-devtools/python/python3-keras/LICENSE
 create mode 100644 recipes-devtools/python/python3-keras_3.13.2.bb
 delete mode 100644 recipes-framework/tensorflow/tf-keras/0001-customize-for-yocto.patch
 delete mode 100644 recipes-framework/tensorflow/tf-keras/0001-skip-pip-file-check.patch
 delete mode 100644 recipes-framework/tensorflow/tf-keras_2.19.0.bb

diff --git a/recipes-devtools/python/python3-keras/LICENSE b/recipes-devtools/python/python3-keras/LICENSE
new file mode 100644
index 0000000..f49a4e1
--- /dev/null
+++ b/recipes-devtools/python/python3-keras/LICENSE
@@ -0,0 +1,201 @@
+                                 Apache License
+                           Version 2.0, January 2004
+                        http://www.apache.org/licenses/
+
+   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
+
+   1. Definitions.
+
+      "License" shall mean the terms and conditions for use, reproduction,
+      and distribution as defined by Sections 1 through 9 of this document.
+
+      "Licensor" shall mean the copyright owner or entity authorized by
+      the copyright owner that is granting the License.
+
+      "Legal Entity" shall mean the union of the acting entity and all
+      other entities that control, are controlled by, or are under common
+      control with that entity. For the purposes of this definition,
+      "control" means (i) the power, direct or indirect, to cause the
+      direction or management of such entity, whether by contract or
+      otherwise, or (ii) ownership of fifty percent (50%) or more of the
+      outstanding shares, or (iii) beneficial ownership of such entity.
+
+      "You" (or "Your") shall mean an individual or Legal Entity
+      exercising permissions granted by this License.
+
+      "Source" form shall mean the preferred form for making modifications,
+      including but not limited to software source code, documentation
+      source, and configuration files.
+
+      "Object" form shall mean any form resulting from mechanical
+      transformation or translation of a Source form, including but
+      not limited to compiled object code, generated documentation,
+      and conversions to other media types.
+
+      "Work" shall mean the work of authorship, whether in Source or
+      Object form, made available under the License, as indicated by a
+      copyright notice that is included in or attached to the work
+      (an example is provided in the Appendix below).
+
+      "Derivative Works" shall mean any work, whether in Source or Object
+      form, that is based on (or derived from) the Work and for which the
+      editorial revisions, annotations, elaborations, or other modifications
+      represent, as a whole, an original work of authorship. For the purposes
+      of this License, Derivative Works shall not include works that remain
+      separable from, or merely link (or bind by name) to the interfaces of,
+      the Work and Derivative Works thereof.
+
+      "Contribution" shall mean any work of authorship, including
+      the original version of the Work and any modifications or additions
+      to that Work or Derivative Works thereof, that is intentionally
+      submitted to Licensor for inclusion in the Work by the copyright owner
+      or by an individual or Legal Entity authorized to submit on behalf of
+      the copyright owner. For the purposes of this definition, "submitted"
+      means any form of electronic, verbal, or written communication sent
+      to the Licensor or its representatives, including but not limited to
+      communication on electronic mailing lists, source code control systems,
+      and issue tracking systems that are managed by, or on behalf of, the
+      Licensor for the purpose of discussing and improving the Work, but
+      excluding communication that is conspicuously marked or otherwise
+      designated in writing by the copyright owner as "Not a Contribution."
+
+      "Contributor" shall mean Licensor and any individual or Legal Entity
+      on behalf of whom a Contribution has been received by Licensor and
+      subsequently incorporated within the Work.
+
+   2. Grant of Copyright License. Subject to the terms and conditions of
+      this License, each Contributor hereby grants to You a perpetual,
+      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
+      copyright license to reproduce, prepare Derivative Works of,
+      publicly display, publicly perform, sublicense, and distribute the
+      Work and such Derivative Works in Source or Object form.
+
+   3. Grant of Patent License. Subject to the terms and conditions of
+      this License, each Contributor hereby grants to You a perpetual,
+      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
+      (except as stated in this section) patent license to make, have made,
+      use, offer to sell, sell, import, and otherwise transfer the Work,
+      where such license applies only to those patent claims licensable
+      by such Contributor that are necessarily infringed by their
+      Contribution(s) alone or by combination of their Contribution(s)
+      with the Work to which such Contribution(s) was submitted. If You
+      institute patent litigation against any entity (including a
+      cross-claim or counterclaim in a lawsuit) alleging that the Work
+      or a Contribution incorporated within the Work constitutes direct
+      or contributory patent infringement, then any patent licenses
+      granted to You under this License for that Work shall terminate
+      as of the date such litigation is filed.
+
+   4. Redistribution. You may reproduce and distribute copies of the
+      Work or Derivative Works thereof in any medium, with or without
+      modifications, and in Source or Object form, provided that You
+      meet the following conditions:
+
+      (a) You must give any other recipients of the Work or
+          Derivative Works a copy of this License; and
+
+      (b) You must cause any modified files to carry prominent notices
+          stating that You changed the files; and
+
+      (c) You must retain, in the Source form of any Derivative Works
+          that You distribute, all copyright, patent, trademark, and
+          attribution notices from the Source form of the Work,
+          excluding those notices that do not pertain to any part of
+          the Derivative Works; and
+
+      (d) If the Work includes a "NOTICE" text file as part of its
+          distribution, then any Derivative Works that You distribute must
+          include a readable copy of the attribution notices contained
+          within such NOTICE file, excluding those notices that do not
+          pertain to any part of the Derivative Works, in at least one
+          of the following places: within a NOTICE text file distributed
+          as part of the Derivative Works; within the Source form or
+          documentation, if provided along with the Derivative Works; or,
+          within a display generated by the Derivative Works, if and
+          wherever such third-party notices normally appear. The contents
+          of the NOTICE file are for informational purposes only and
+          do not modify the License. You may add Your own attribution
+          notices within Derivative Works that You distribute, alongside
+          or as an addendum to the NOTICE text from the Work, provided
+          that such additional attribution notices cannot be construed
+          as modifying the License.
+
+      You may add Your own copyright statement to Your modifications and
+      may provide additional or different license terms and conditions
+      for use, reproduction, or distribution of Your modifications, or
+      for any such Derivative Works as a whole, provided Your use,
+      reproduction, and distribution of the Work otherwise complies with
+      the conditions stated in this License.
+
+   5. Submission of Contributions. Unless You explicitly state otherwise,
+      any Contribution intentionally submitted for inclusion in the Work
+      by You to the Licensor shall be under the terms and conditions of
+      this License, without any additional terms or conditions.
+      Notwithstanding the above, nothing herein shall supersede or modify
+      the terms of any separate license agreement you may have executed
+      with Licensor regarding such Contributions.
+
+   6. Trademarks. This License does not grant permission to use the trade
+      names, trademarks, service marks, or product names of the Licensor,
+      except as required for reasonable and customary use in describing the
+      origin of the Work and reproducing the content of the NOTICE file.
+
+   7. Disclaimer of Warranty. Unless required by applicable law or
+      agreed to in writing, Licensor provides the Work (and each
+      Contributor provides its Contributions) on an "AS IS" BASIS,
+      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
+      implied, including, without limitation, any warranties or conditions
+      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
+      PARTICULAR PURPOSE. You are solely responsible for determining the
+      appropriateness of using or redistributing the Work and assume any
+      risks associated with Your exercise of permissions under this License.
+
+   8. Limitation of Liability. In no event and under no legal theory,
+      whether in tort (including negligence), contract, or otherwise,
+      unless required by applicable law (such as deliberate and grossly
+      negligent acts) or agreed to in writing, shall any Contributor be
+      liable to You for damages, including any direct, indirect, special,
+      incidental, or consequential damages of any character arising as a
+      result of this License or out of the use or inability to use the
+      Work (including but not limited to damages for loss of goodwill,
+      work stoppage, computer failure or malfunction, or any and all
+      other commercial damages or losses), even if such Contributor
+      has been advised of the possibility of such damages.
+
+   9. Accepting Warranty or Additional Liability. While redistributing
+      the Work or Derivative Works thereof, You may choose to offer,
+      and charge a fee for, acceptance of support, warranty, indemnity,
+      or other liability obligations and/or rights consistent with this
+      License. However, in accepting such obligations, You may act only
+      on Your own behalf and on Your sole responsibility, not on behalf
+      of any other Contributor, and only if You agree to indemnify,
+      defend, and hold each Contributor harmless for any liability
+      incurred by, or claims asserted against, such Contributor by reason
+      of your accepting any such warranty or additional liability.
+
+   END OF TERMS AND CONDITIONS
+
+   APPENDIX: How to apply the Apache License to your work.
+
+      To apply the Apache License to your work, attach the following
+      boilerplate notice, with the fields enclosed by brackets "[]"
+      replaced with your own identifying information. (Don't include
+      the brackets!)  The text should be enclosed in the appropriate
+      comment syntax for the file format. We also recommend that a
+      file or class name and description of purpose be included on the
+      same "printed page" as the copyright notice for easier
+      identification within third-party archives.
+
+   Copyright [yyyy] [name of copyright owner]
+
+   Licensed under the Apache License, Version 2.0 (the "License");
+   you may not use this file except in compliance with the License.
+   You may obtain a copy of the License at
+
+       http://www.apache.org/licenses/LICENSE-2.0
+
+   Unless required by applicable law or agreed to in writing, software
+   distributed under the License is distributed on an "AS IS" BASIS,
+   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+   See the License for the specific language governing permissions and
+   limitations under the License.
\ No newline at end of file
diff --git a/recipes-devtools/python/python3-keras_3.13.2.bb b/recipes-devtools/python/python3-keras_3.13.2.bb
new file mode 100644
index 0000000..b5b9338
--- /dev/null
+++ b/recipes-devtools/python/python3-keras_3.13.2.bb
@@ -0,0 +1,41 @@
+SUMMARY = "Keras 3: Deep Learning for Humans"
+HOMEPAGE = "https://github.com/keras-team/keras"
+SECTION = "devel/python"
+LICENSE = "Apache-2.0"
+LIC_FILES_CHKSUM = "file://${UNPACKDIR}/LICENSE;md5=2b42edef8fa55315f34f2370b4715ca9"
+
+SRC_URI[sha256sum] = "62f0123488ac87c929c988617e14f293f7bc993811837d08bb37eff77adc85a9"
+
+inherit pypi python_setuptools_build_meta
+
+SRCNAME ?= "keras"
+
+SRC_URI += " \
+    file://LICENSE \
+"
+S = "${UNPACKDIR}/${SRCNAME}-${PV}"
+
+UPSTREAM_CHECK_PYPI_PACKAGE = "keras"
+UPSTREAM_CHECK_URI = "https://pypi.org/simple/${UPSTREAM_CHECK_PYPI_PACKAGE}/"
+
+DEPENDS += " \
+    python3-absl-native \
+    python3-numpy-native \
+    python3-rich-native \
+    python3-h5py \
+    python3-mldtypes-native \
+    python3-packaging \
+"
+
+DEPENDS = " \
+    python3-pybind11-native \
+"
+
+RDEPENDS:${PN} = " \
+    python3-pybind11 \
+    python3-numpy \
+"
+
+CCACHE_DISABLE = "1"
+
+BBCLASSEXTEND = "native"
diff --git a/recipes-framework/tensorflow/tf-keras/0001-customize-for-yocto.patch b/recipes-framework/tensorflow/tf-keras/0001-customize-for-yocto.patch
deleted file mode 100644
index 1aa6a77..0000000
--- a/recipes-framework/tensorflow/tf-keras/0001-customize-for-yocto.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-From 375582ae1bf40a66300630b325d8739668e22ffc Mon Sep 17 00:00:00 2001
-From: Hongxu Jia <hongxu.jia@eng.windriver.com>
-Date: Wed, 13 Mar 2024 06:10:17 -0700
-Subject: [PATCH] customize for yocto
-
-Upstream-Status: Inappropriate [oe specific]
-
-Signed-off-by: Hongxu Jia <hongxu.jia@eng.windriver.com>
----
- tf_keras/tools/pip_package/build_pip_package.sh | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/tf_keras/tools/pip_package/build_pip_package.sh b/tf_keras/tools/pip_package/build_pip_package.sh
-index 8695fceee..43c3546b2 100755
---- a/tf_keras/tools/pip_package/build_pip_package.sh
-+++ b/tf_keras/tools/pip_package/build_pip_package.sh
-@@ -39,7 +39,7 @@ function prepare_src() {
- 
-   # Verifies all expected files are in pip.
-   # Creates init files in all directory in pip.
--  python tf_keras/tools/pip_package/create_pip_helper.py --pip-root "${TMPDIR}/tf_keras/" --bazel-root "./tf_keras"
-+  nativepython3 tf_keras/tools/pip_package/create_pip_helper.py --pip-root "${TMPDIR}/tf_keras/" --bazel-root "./tf_keras"
- }
- 
- function build_wheel() {
--- 
-2.42.0
-
diff --git a/recipes-framework/tensorflow/tf-keras/0001-skip-pip-file-check.patch b/recipes-framework/tensorflow/tf-keras/0001-skip-pip-file-check.patch
deleted file mode 100644
index 18196f9..0000000
--- a/recipes-framework/tensorflow/tf-keras/0001-skip-pip-file-check.patch
+++ /dev/null
@@ -1,37 +0,0 @@
-From c01d71e8750d5f8e73c8fed5bb96645751c3e364 Mon Sep 17 00:00:00 2001
-From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Wed, 13 Mar 2024 21:44:51 +0800
-Subject: [PATCH] skip pip file check
-
-|PipPackagingError: Pip package missing the file ./tf_keras/layers/experimental/dynamic_embedding.py.
-If this is expected, add it to PIP_EXCLUDED_FILES in create_pip_helper.py.
-Otherwise, make sure it is a build dependency of the pip package
-
-Upstream-Status: Inappropriate [Yocto specific]
-
-Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
----
- tf_keras/tools/pip_package/create_pip_helper.py | 7 +++++++
- 1 file changed, 7 insertions(+)
-
-diff --git a/tf_keras/tools/pip_package/create_pip_helper.py b/tf_keras/tools/pip_package/create_pip_helper.py
-index 65401cfa9..b677f6017 100644
---- a/tf_keras/tools/pip_package/create_pip_helper.py
-+++ b/tf_keras/tools/pip_package/create_pip_helper.py
-@@ -31,6 +31,13 @@ PIP_EXCLUDED_FILES = frozenset(
-         "tf_keras/saving/legacy/saved_model/create_test_saved_model.py",
-         "tf_keras/tools/pip_package/setup.py",
-         "tf_keras/tools/pip_package/create_pip_helper.py",
-+        "tf_keras/layers/experimental/dynamic_embedding_distributed_test.py",
-+        "tf_keras/layers/experimental/dynamic_lookup_distributed_test.py",
-+        "tf_keras/layers/experimental/__init__.py",
-+        "tf_keras/layers/experimental/dynamic_embedding.py",
-+        "tf_keras/layers/experimental/dynamic_lookup.py",
-+        "tf_keras/layers/experimental/dynamic_embedding_test.py",
-+        "tf_keras/layers/experimental/dynamic_lookup_test.py",
-     ]
- )
- 
--- 
-2.27.0
-
diff --git a/recipes-framework/tensorflow/tf-keras_2.19.0.bb b/recipes-framework/tensorflow/tf-keras_2.19.0.bb
deleted file mode 100644
index 0cc71d5..0000000
--- a/recipes-framework/tensorflow/tf-keras_2.19.0.bb
+++ /dev/null
@@ -1,63 +0,0 @@
-DESCRIPTION = "TensorFlow Keras is an implementation of the Keras API that\
- uses TensorFlow as a backend."
-LICENSE = "Apache-2.0"
-LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"
-
-SRC_URI = "git://github.com/keras-team/tf-keras.git;branch=r2.19;protocol=https \
-           file://0001-customize-for-yocto.patch \
-           file://0001-skip-pip-file-check.patch \
-          "
-
-SRCREV = "a697e6a2238224a89e5cf53fb86fd4808b1b9133"
-
-inherit python3native bazel tensorflow_ver
-
-DEPENDS += " \
-    python3-pip-native \
-    python3-wheel-native \
-    python3-absl-native \
-    python3-wrapt-native \
-    python3-opt-einsum-native \
-    python3-gast-native \
-    python3-astunparse-native \
-    python3-termcolor-native \
-    python3-typing-extensions-native \
-    python3-flatbuffers-native \
-    python3-mldtypes-native \
-    python3-pybind11-native \
-    python3-protobuf-native \
-    tensorflow-native \
-"
-
-do_compile () {
-    unset CC
-    export TMPDIR="${WORKDIR}"
-    export PYTHON_BIN_PATH="${PYTHON}"
-
-    ${BAZEL} build \
-        --subcommands --explain=${T}/explain.log \
-        --verbose_explanations --verbose_failures \
-        --verbose_failures \
-        --python_path="${PYTHON}" \
-        //tf_keras/tools/pip_package:build_pip_package
-
-    ${S}/bazel-bin/tf_keras/tools/pip_package/build_pip_package \
-        ${WORKDIR}/tf_keras_pip
-}
-
-do_install () {
-    echo "Installing pip package"
-    install -d ${D}${PYTHON_SITEPACKAGES_DIR}
-    ${STAGING_BINDIR_NATIVE}/pip3 install --disable-pip-version-check -v --no-deps \
-        -t ${D}/${PYTHON_SITEPACKAGES_DIR} --no-cache-dir ${WORKDIR}/tf_keras_pip/*.whl
-
-    rm -rf ${D}/${PYTHON_SITEPACKAGES_DIR}/tf_keras-${PV}.dist-info
-
-    # Provides module keras as usual
-    ln -snrf ${D}/${PYTHON_SITEPACKAGES_DIR}/tf_keras ${D}/${PYTHON_SITEPACKAGES_DIR}/keras
-
-}
-
-FILES:${PN} += "${libdir}/*"
-
-BBCLASSEXTEND = "native"
-- 
2.34.1


