Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85404103A98D
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:38 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13930.1774405055154114060
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=CLSa4R8r;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P1tN8A3429809
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=b2pHc+UYrVShokif+NMlDs6U2PuCmsGjwJNEWm00Tsc=; b=CLSa4R8ra8BK
	Vgv4zTlD+0lSM9PGFxRxgCvaU1yZ5552hZVphHTKY83YDrdcyolInkGETO2HSo0v
	CLuDRCt6M1D4KfLQMzvRgtqkKAFiOnWEDDaOtntQ70qd20P5mkUp3UJr4yMU5ZGq
	uBXlLvskGKuSu9uRQEZh6hmAJMtnIZVrapxidE2S5od36FCNJTnMYaYeLtJDHcDr
	7Ew9wnGmSAtMNjQu20BnAU/+vWjTX0lM950xmSg53n7rtM2lir3ounLZ8hoUmC0Y
	7HDUBeQKBjTVwEHDX5fJ6atuOl8CYnv78d6CBeCLnMDjMitSsk/WyWCSqf0lPEcN
	UI4Nmx5Zvg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84duv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:34 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:33 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:32 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 13/14] tensorflow: refresh patches for 2.21.0
Date: Wed, 25 Mar 2026 10:17:18 +0800
Message-ID: <20260325021719.1526525-14-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: F_D22d-LTTwDh3XyVQRXWdojA2L0m--b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX1qyUP0j5AwuF
 b4AHhiHPaI1kKigzUAelHwd3lMbL2UCnbMNjanpkDaD9Xmyn0AtcfIf/PfJqb9NNFOlAfXkQAm0
 xSPkSIaNMv4iYZDouEk+3Rm4PFIEF16reBwj5w25cPPaJ/30ZTm+Kz5pg3GY0HjU+znj87Qo/j3
 BXcqcaJwn97tdOvOMIu1ThbNQmziupvVaSQEkWb8TfzHrwHA3bqjQmk+mtlXh15q7gfLnlIkSZI
 5G5HsFVQhoyUmW3I6PRptOynIU9N+bQSBjybFGCiObXc47GvEcTga+40OoBztceJ5RfmILbAobv
 APjUz4VN79kDXeuCCr0IcrpYb5+YWyLRZK6Ib2ft9a6p7Vg6ZZyNi0dL95pjCbhb8PXkPfY7zcN
 Inrj3OVOEzU/NtQ2f876Brfl/9+dEQY7mTaYqkbuxChSfl2OkBUbIBy1d3yzfd/EZuhJydzSgzT
 R7t5TBYRIX4Fu3c2qHQ==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345be cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=NZXD4gRhAAAA:20 a=t7CeM3EgAAAA:8
 a=U8pmOUT1MJXh8Hpi-nEA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: F_D22d-LTTwDh3XyVQRXWdojA2L0m--b
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3549

- 0001-third_party-tf_runtime-fix-compile-failure.patch
- 0008-make-hermetic-python3-support-offline-build.patch
- 0012-add-yocto-toolchain-to-support-cross-compiling.patch

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 ...party-tf_runtime-fix-compile-failure.patch | 14 +--
 ...rmetic-python3-support-offline-build.patch | 99 +++++++++----------
 ...toolchain-to-support-cross-compiling.patch | 42 ++++----
 3 files changed, 75 insertions(+), 80 deletions(-)

diff --git a/recipes-framework/tensorflow/files/0001-third_party-tf_runtime-fix-compile-failure.patch b/recipes-framework/tensorflow/files/0001-third_party-tf_runtime-fix-compile-failure.patch
index 1eb19b8..de62026 100644
--- a/recipes-framework/tensorflow/files/0001-third_party-tf_runtime-fix-compile-failure.patch
+++ b/recipes-framework/tensorflow/files/0001-third_party-tf_runtime-fix-compile-failure.patch
@@ -1,6 +1,6 @@
-From d8b929a5a9d0aa63e709a78af38d7bdaa58a016e Mon Sep 17 00:00:00 2001
+From f9f5feee6779c1a9841d4a3b744fc7eff3802178 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Mon, 14 Jul 2025 16:13:33 +0800
+Date: Thu, 5 Mar 2026 23:40:00 -0800
 Subject: [PATCH] third_party/tf_runtime: fix compile failure
 
 ...
@@ -15,7 +15,7 @@ external/tf_runtime/include/tfrt/support/forward_decls.h:28:1: note: 'int64_t' i
 ...
 
 Upstream-Status: Pending
-
+Rebase to 2.21
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
  .../tf_runtime/0001-fix-compile-failure.patch | 36 +++++++++++++++++++
@@ -66,12 +66,12 @@ index 00000000000..c05ea5b41e7
 +2.34.1
 +
 diff --git a/third_party/tf_runtime/workspace.bzl b/third_party/tf_runtime/workspace.bzl
-index 69fc0f81f6f..460641dde06 100644
+index 5c8ec13c6f4..3a9a88d3acc 100644
 --- a/third_party/tf_runtime/workspace.bzl
 +++ b/third_party/tf_runtime/workspace.bzl
 @@ -18,7 +18,7 @@ def repo():
-             "@tsl": "@local_tsl",
-             "@xla": "@local_xla",
+             "@tsl": "@tsl",
+             "@xla": "@xla",
          },
 -        # A patch file can be provided for atomic commits to both TF and TFRT.
 -        # The job that bumps the TFRT_COMMIT also resets patch_file to 'None'.
@@ -81,5 +81,5 @@ index 69fc0f81f6f..460641dde06 100644
 +        ],
      )
 -- 
-2.34.1
+2.49.0
 
diff --git a/recipes-framework/tensorflow/files/0008-make-hermetic-python3-support-offline-build.patch b/recipes-framework/tensorflow/files/0008-make-hermetic-python3-support-offline-build.patch
index 21a9cd4..0908887 100644
--- a/recipes-framework/tensorflow/files/0008-make-hermetic-python3-support-offline-build.patch
+++ b/recipes-framework/tensorflow/files/0008-make-hermetic-python3-support-offline-build.patch
@@ -1,7 +1,7 @@
-From 919814dff64170b58084e20fc55cebcb8226a3d1 Mon Sep 17 00:00:00 2001
+From 0ed4abe820951d9f2cbc72a5c49fee85798c0b01 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Fri, 14 Mar 2025 21:17:31 -0700
-Subject: [PATCH 08/21] make hermetic python3 support offline build
+Date: Thu, 5 Mar 2026 23:04:37 -0800
+Subject: [PATCH] make hermetic python3 support offline build
 
 If environment TS_DL_DIR is set, download python whl from local archive other then
 python index
@@ -10,23 +10,33 @@ If environment TS_DL_DIR is set, save python whl to local dir
 
 Upstream-Status: Inappropriate [Yocto specific]
 
-Rebase to 2.19
+Rebase to 2.21
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
- third_party/0001-support-offline-build.patch  | 51 +++++++++++++++++++
- third_party/py/python_init_rules.bzl          |  2 +-
- .../xla/third_party/py/python_init_rules.bzl  |  2 +-
- .../tsl/third_party/py/python_init_rules.bzl  |  2 +-
- 4 files changed, 54 insertions(+), 3 deletions(-)
- create mode 100644 third_party/0001-support-offline-build.patch
+ third_party/py/python_init_rules.bzl          |  1 +
+ .../py/0001-support-offline-build.patch       | 58 +++++++++++++++++++
+ .../xla/third_party/py/python_init_rules.bzl  |  1 +
+ 3 files changed, 60 insertions(+)
+ create mode 100644 third_party/xla/third_party/py/0001-support-offline-build.patch
 
-diff --git a/third_party/0001-support-offline-build.patch b/third_party/0001-support-offline-build.patch
+diff --git a/third_party/py/python_init_rules.bzl b/third_party/py/python_init_rules.bzl
+index 84370d1dffe..8f27c46dbe5 100644
+--- a/third_party/py/python_init_rules.bzl
++++ b/third_party/py/python_init_rules.bzl
+@@ -41,5 +41,6 @@ def python_init_rules(extra_patches = []):
+             "@xla//third_party/py:rules_python_pip_version.patch",
+             "@xla//third_party/py:rules_python_freethreaded.patch",
+             "@xla//third_party/py:rules_python_versions.patch",
++            "@xla//third_party/py:third_party:0001-support-offline-build.patch",
+         ] + extra_patches,
+     )
+diff --git a/third_party/xla/third_party/py/0001-support-offline-build.patch b/third_party/xla/third_party/py/0001-support-offline-build.patch
 new file mode 100644
-index 00000000000..f30e9a453a6
+index 00000000000..57ad06b001b
 --- /dev/null
-+++ b/third_party/0001-support-offline-build.patch
-@@ -0,0 +1,51 @@
-+From 7cb07f8c690ab460ccf8a12acb52ff6e174cf480 Mon Sep 17 00:00:00 2001
++++ b/third_party/xla/third_party/py/0001-support-offline-build.patch
+@@ -0,0 +1,58 @@
++From e90bf48d67fe91d4881106c16d6229725c75b0fd Mon Sep 17 00:00:00 2001
 +From: Hongxu Jia <hongxu.jia@windriver.com>
 +Date: Fri, 14 Mar 2025 21:13:10 -0700
 +Subject: [PATCH] make hermetic python3 support offline build
@@ -36,19 +46,26 @@ index 00000000000..f30e9a453a6
 +
 +If environment TS_DL_DIR is set, save python whl to local dir
 +
++Configure cache dir of pip
++
 +Upstream-Status: Inappropriate [Yocto specific]
 +
-+Rebase to 2.19
++Rebase to 2.21
 +Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 +---
-+ python/private/pypi/whl_installer/wheel_installer.py | 12 ++++++++++++
-+ 1 file changed, 12 insertions(+)
++ .../private/pypi/whl_installer/wheel_installer.py  | 14 +++++++++++++-
++ 1 file changed, 13 insertions(+), 1 deletion(-)
 +
 +diff --git a/python/private/pypi/whl_installer/wheel_installer.py b/python/private/pypi/whl_installer/wheel_installer.py
-+index ef8181c..d886266 100644
++index a6a9dd0..0e233fd 100644
 +--- a/python/private/pypi/whl_installer/wheel_installer.py
 ++++ b/python/private/pypi/whl_installer/wheel_installer.py
-+@@ -173,6 +173,11 @@ def main() -> None:
++@@ -147,10 +147,15 @@ def main() -> None:
++         [sys.executable, "-m", "pip"]
++         + (["--isolated"] if args.isolated else [])
++         + (["download", "--only-binary=:all:"] if args.download_only else ["wheel"])
++-        + ["--no-deps"]
+++        + ["--no-deps", "--cache-dir=${PIP_CACHE_DIR}"]
 +         + deserialized_args["extra_pip_args"]
 +     )
 + 
@@ -60,7 +77,7 @@ index 00000000000..f30e9a453a6
 +     requirement_file = NamedTemporaryFile(mode="wb", delete=False)
 +     try:
 +         requirement_file.write(args.requirement.encode("utf-8"))
-+@@ -195,6 +200,13 @@ def main() -> None:
++@@ -173,6 +178,13 @@ def main() -> None:
 +             if e.errno != errno.ENOENT:
 +                 raise
 + 
@@ -75,41 +92,19 @@ index 00000000000..f30e9a453a6
 + 
 +     with open("whl_file.json", "w") as f:
 +-- 
-+2.25.1
++2.34.1
 +
-diff --git a/third_party/py/python_init_rules.bzl b/third_party/py/python_init_rules.bzl
-index 796ae3d92d9..bfb750ac72d 100644
---- a/third_party/py/python_init_rules.bzl
-+++ b/third_party/py/python_init_rules.bzl
-@@ -9,5 +9,5 @@ def python_init_rules():
-         strip_prefix = "rules_python-0.39.0",
-         url = "https://github.com/bazelbuild/rules_python/releases/download/0.39.0/rules_python-0.39.0.tar.gz",
-         patch_args = ["-p1"],
--        patches = [Label("//third_party/py:rules_python.patch")],
-+        patches = ["//third_party/py:rules_python.patch", "//third_party:0001-support-offline-build.patch"],
-     )
 diff --git a/third_party/xla/third_party/py/python_init_rules.bzl b/third_party/xla/third_party/py/python_init_rules.bzl
-index 796ae3d92d9..bfb750ac72d 100644
+index 84370d1dffe..2fc861b5af7 100644
 --- a/third_party/xla/third_party/py/python_init_rules.bzl
 +++ b/third_party/xla/third_party/py/python_init_rules.bzl
-@@ -9,5 +9,5 @@ def python_init_rules():
-         strip_prefix = "rules_python-0.39.0",
-         url = "https://github.com/bazelbuild/rules_python/releases/download/0.39.0/rules_python-0.39.0.tar.gz",
-         patch_args = ["-p1"],
--        patches = [Label("//third_party/py:rules_python.patch")],
-+        patches = ["//third_party/py:rules_python.patch", "//third_party:0001-support-offline-build.patch"],
-     )
-diff --git a/third_party/xla/third_party/tsl/third_party/py/python_init_rules.bzl b/third_party/xla/third_party/tsl/third_party/py/python_init_rules.bzl
-index 796ae3d92d9..bfb750ac72d 100644
---- a/third_party/xla/third_party/tsl/third_party/py/python_init_rules.bzl
-+++ b/third_party/xla/third_party/tsl/third_party/py/python_init_rules.bzl
-@@ -9,5 +9,5 @@ def python_init_rules():
-         strip_prefix = "rules_python-0.39.0",
-         url = "https://github.com/bazelbuild/rules_python/releases/download/0.39.0/rules_python-0.39.0.tar.gz",
-         patch_args = ["-p1"],
--        patches = [Label("//third_party/py:rules_python.patch")],
-+        patches = ["//third_party/py:rules_python.patch", "//third_party:0001-support-offline-build.patch"],
+@@ -41,5 +41,6 @@ def python_init_rules(extra_patches = []):
+             "@xla//third_party/py:rules_python_pip_version.patch",
+             "@xla//third_party/py:rules_python_freethreaded.patch",
+             "@xla//third_party/py:rules_python_versions.patch",
++            "@xla//third_party/py:0001-support-offline-build.patch",
+         ] + extra_patches,
      )
 -- 
-2.25.1
+2.49.0
 
diff --git a/recipes-framework/tensorflow/files/0012-add-yocto-toolchain-to-support-cross-compiling.patch b/recipes-framework/tensorflow/files/0012-add-yocto-toolchain-to-support-cross-compiling.patch
index 8f5eda7..2fddbcb 100644
--- a/recipes-framework/tensorflow/files/0012-add-yocto-toolchain-to-support-cross-compiling.patch
+++ b/recipes-framework/tensorflow/files/0012-add-yocto-toolchain-to-support-cross-compiling.patch
@@ -1,11 +1,11 @@
-From a8439d8d6dc9877d6196eec2065fffab1b74af86 Mon Sep 17 00:00:00 2001
+From 28eb8559b29424eb10dde0fcdec9da1aba26b52c Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Fri, 14 Mar 2025 21:27:41 -0700
-Subject: [PATCH 12/21] add yocto toolchain to support cross compiling
+Date: Tue, 10 Mar 2026 23:54:19 -0700
+Subject: [PATCH] add yocto toolchain to support cross compiling
 
 Upstream-Status: Inappropriate [oe specific]
 
-Rebase to 2.19
+Rebase to 2.21
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
  WORKSPACE                 | 7 +++++++
@@ -14,13 +14,13 @@ Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
  3 files changed, 24 insertions(+)
 
 diff --git a/WORKSPACE b/WORKSPACE
-index 0171c60db38..d6872677ce9 100644
+index 4813611b836..a1fd88befe9 100644
 --- a/WORKSPACE
 +++ b/WORKSPACE
-@@ -117,3 +117,10 @@ load(
+@@ -193,3 +193,10 @@ load(
+ nvshmem_redist_init_repository(
+     nvshmem_redistributions = NVSHMEM_REDISTRIBUTIONS,
  )
- 
- nccl_configure(name = "local_config_nccl")
 +
 +new_local_repository(
 +    name = "yocto_compiler",
@@ -29,10 +29,10 @@ index 0171c60db38..d6872677ce9 100644
 +)
 +
 diff --git a/tensorflow/BUILD b/tensorflow/BUILD
-index 94c9a9721ac..c7d4410cbbd 100644
+index da5ba2a8093..b2b6e6081de 100644
 --- a/tensorflow/BUILD
 +++ b/tensorflow/BUILD
-@@ -356,6 +356,15 @@ config_setting(
+@@ -390,6 +390,15 @@ config_setting(
      visibility = ["//visibility:public"],
  )
  
@@ -47,20 +47,20 @@ index 94c9a9721ac..c7d4410cbbd 100644
 +
  config_setting(
      name = "android_arm",
-     constraint_values = if_google(
+     constraint_values =
 diff --git a/tensorflow/workspace2.bzl b/tensorflow/workspace2.bzl
-index 146e7353c3e..48b5b385211 100644
+index 5e634efe5e1..57575f83125 100644
 --- a/tensorflow/workspace2.bzl
 +++ b/tensorflow/workspace2.bzl
-@@ -12,6 +12,7 @@ load("//tensorflow/tools/def_file_filter:def_file_filter_configure.bzl", "def_fi
- load("//tensorflow/tools/toolchains:cpus/aarch64/aarch64_compiler_configure.bzl", "aarch64_compiler_configure")
- load("//tensorflow/tools/toolchains:cpus/arm/arm_compiler_configure.bzl", "arm_compiler_configure")
- load("//tensorflow/tools/toolchains/clang6:repo.bzl", "clang6_configure")
+@@ -44,6 +44,7 @@ load("@xla//tools/def_file_filter:def_file_filter_configure.bzl", "def_file_filt
+ load("@xla//tools/toolchains:cpus/aarch64/aarch64_compiler_configure.bzl", "aarch64_compiler_configure")
+ load("@xla//tools/toolchains:cpus/arm/arm_compiler_configure.bzl", "arm_compiler_configure")
+ load("@xla//tools/toolchains/clang6:repo.bzl", "clang6_configure")
 +load("//third_party/toolchains/yocto:yocto_compiler_configure.bzl", "yocto_compiler_configure")
- load("//tensorflow/tools/toolchains/embedded/arm-linux:arm_linux_toolchain_configure.bzl", "arm_linux_toolchain_configure")
- load("//tensorflow/tools/toolchains/remote:configure.bzl", "remote_execution_configure")
- load("//tensorflow/tools/toolchains/remote_config:configs.bzl", "initialize_rbe_configs")
-@@ -131,6 +132,13 @@ def _tf_toolchains():
+ load("@xla//tools/toolchains/embedded/arm-linux:arm_linux_toolchain_configure.bzl", "arm_linux_toolchain_configure")
+ load("@xla//tools/toolchains/remote:configure.bzl", "remote_execution_configure")
+ load("@xla//tools/toolchains/remote_config:configs.bzl", "initialize_rbe_configs")
+@@ -153,6 +154,13 @@ def _tf_toolchains():
      # Load aarch64 toolchain
      aarch64_compiler_configure()
  
@@ -75,5 +75,5 @@ index 146e7353c3e..48b5b385211 100644
      arm_linux_toolchain_configure(
          name = "local_config_embedded_arm",
 -- 
-2.25.1
+2.49.0
 
-- 
2.34.1


