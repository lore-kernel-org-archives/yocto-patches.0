Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153FB103A995
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:39 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13684.1774405050070744457
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=jYLI9aBE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ONaji71449120
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=K18ioAgY1oBknhrKZWGCIwVXLyMxeQy4g80EPXC5oms=; b=jYLI9aBE+Wkd
	x0A8g52ZpnpQf6HmQhhy/fsRTTroKvRYQZ0gflNTgHxmedXcGzHiNgc+7VN7wrrv
	29ZXaEpkFHYbUD/KHW0dAWaOBsNbjNHxAhxo3rZsCSW8iyeWj9xUj26zyXATn/XD
	Hh4Cb7qYD9yexgEBBPukVOMa+446CgDhPLS0ZqiJmAadD4ffvUKeHIpR2c3KjAMA
	N5dC5iEplQwLwk66UX0sTyUoOkRAacvymwEqXK1I+94FYKamIbmSXqPbrreMybej
	rgFpYu1jNkOzmduBY30MC3fF9rOFfZqIp4ezgG9h77ZrSpXlvBZadKFdfues/Y22
	uaddcFTrxw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6vcp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:28 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:27 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:26 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][PATCH 7/14] bazel-native: upgrade 6.0.0 -> 7.7.0
Date: Wed, 25 Mar 2026 10:17:12 +0800
Message-ID: <20260325021719.1526525-8-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325021719.1526525-1-hongxu.jia@windriver.com>
References: <20260325021719.1526525-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX9G5uEvWw5qe5
 wUAVp9kbUCQhu/i7NErHhKATlW37E2h8pqfruYoYbEELybEdw8WgOm/FRWhN4CjVnDwXAAvcw2c
 qrN8jONfYs68Ux2ixYcCwDAgYHan2YG6elYmght3T+V0IMdAl3J4hENCd9XOkk75KL6vFuGDA1E
 O32xgW48J+iHDvFPqmYNRsZrxyfJeNfI9JSq1Wany6jBakhFazG/PYQjxpc/nLnqMGzCQm2i0r5
 2/789u+ux76xRtjH3UW50K3iH+/rEf+olWTp9fmw5oVpA7COjy3CH3pss60UuewepsjElyrlV7G
 CZJietUfDQ6AOn1UJENBkpeoySjw9JHSD0Lz07nCob990qyi/rptvhax/DGFSOhT9WU51ptdXHM
 sccZPA+HaPmmcnbxOh+jOvwAh97VpkKx9WYJiwjgaoleLoU/RxCM5eQwMYcSSn1ss2myHGuJ9/y
 DW4ORuNB6sKbgtoSk1w==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c345b8 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=NZXD4gRhAAAA:20 a=01C68wJfAAAA:8 a=NEAV23lmAAAA:8
 a=P8pRC1z1AAAA:20 a=t7CeM3EgAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8
 a=s4fsyQzKVBOp-Aiomv8A:9 a=DY59otl68eHIR0tbHspE:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: tKbWSdI9By-0eSvA34-kH0s1ccgUU4XW
X-Proofpoint-GUID: tKbWSdI9By-0eSvA34-kH0s1ccgUU4XW
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
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3543

Tensorflow 2.21 requires bazel 7.7.0

Drop obsolete patches:
- 0001-fix-compile-failure-on-gcc-13.patch
- 1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch
- include_stdint.patch

Refresh patches to 7.7.0
- 0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch
- 0001-cutsomize-native-toolchains-for-Yocto.patch
- 0001-fix-unzip-command-not-found.patch

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 ...-native_6.0.0.bb => bazel-native_7.7.0.bb} |  6 +-
 ...-sysroot-dir-to-the-default-Bazel-to.patch | 16 ++---
 ...utsomize-native-toolchains-for-Yocto.patch | 16 ++---
 .../0001-fix-compile-failure-on-gcc-13.patch  | 71 -------------------
 .../0001-fix-unzip-command-not-found.patch    | 16 ++---
 ...3ed4ac717b814d02a0d125f160ddabe78003.patch | 57 ---------------
 .../bazel/files/include_stdint.patch          | 28 --------
 7 files changed, 25 insertions(+), 185 deletions(-)
 rename recipes-devtools/bazel/{bazel-native_6.0.0.bb => bazel-native_7.7.0.bb} (83%)
 delete mode 100644 recipes-devtools/bazel/files/0001-fix-compile-failure-on-gcc-13.patch
 delete mode 100644 recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch
 delete mode 100644 recipes-devtools/bazel/files/include_stdint.patch

diff --git a/recipes-devtools/bazel/bazel-native_6.0.0.bb b/recipes-devtools/bazel/bazel-native_7.7.0.bb
similarity index 83%
rename from recipes-devtools/bazel/bazel-native_6.0.0.bb
rename to recipes-devtools/bazel/bazel-native_7.7.0.bb
index 12351ff..a02844d 100644
--- a/recipes-devtools/bazel/bazel-native_6.0.0.bb
+++ b/recipes-devtools/bazel/bazel-native_7.7.0.bb
@@ -2,17 +2,13 @@ DESCRIPTION = "Bazel build and test tool"
 LICENSE = "Apache-2.0"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
 
-SRC_URI[md5sum] = "f79f57d82795b591e95f9f7fa0f9a8da"
-SRC_URI[sha256sum] = "7bc0c5145c19a56d82a08fce6908c5e1a0e75e4fbfb3b6f12b4deae7f4b38cbc"
+SRC_URI[sha256sum] = "277946818c77fff70be442864cecc41faac862b6f2d0d37033e2da0b1fee7e0f"
 
 SRC_URI = "https://github.com/bazelbuild/bazel/releases/download/${PV}/bazel-${PV}-dist.zip \
            file://0001-HttpDownloader-save-download-tarball-to-distdir.patch \
            file://0001-fix-unzip-command-not-found.patch \
            file://0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch \
            file://0001-cutsomize-native-toolchains-for-Yocto.patch \
-           file://0001-fix-compile-failure-on-gcc-13.patch \
-           file://1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch \
-           file://include_stdint.patch \
 "
 
 UPSTREAM_CHECK_URI = "https://github.com/bazelbuild/bazel/releases/"
diff --git a/recipes-devtools/bazel/files/0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch b/recipes-devtools/bazel/files/0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch
index 7d73eb7..bd8d969 100644
--- a/recipes-devtools/bazel/files/0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch
+++ b/recipes-devtools/bazel/files/0001-add-Yocto-native-sysroot-dir-to-the-default-Bazel-to.patch
@@ -1,6 +1,6 @@
-From 34c4dc1a10140addf75d3503d4b9f427303fe212 Mon Sep 17 00:00:00 2001
+From 3459b53f52abe448158954adf1370c2485085450 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Mon, 14 Dec 2020 16:45:31 +0800
+Date: Wed, 11 Mar 2026 01:44:26 -0700
 Subject: [PATCH] add Yocto native sysroot dir to the default Bazel toolchain
 
 While using the default Bazel C++ toolchain to build Yocto native tools
@@ -14,19 +14,19 @@ If not set YOCTO_NATIVE_SYSROOT, use NOT_SET_YOCTO_NATIVE_SYSROOT
 to replace as a warning
 
 Upstream-Status: Inappropriate [oe specific]
-
+Rebase tot 7.7.0
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
  tools/cpp/unix_cc_configure.bzl | 3 +++
  1 file changed, 3 insertions(+)
 
 diff --git a/tools/cpp/unix_cc_configure.bzl b/tools/cpp/unix_cc_configure.bzl
-index d48485b..0d297bf 100755
+index bbbba7e50d..69bea13b3a 100644
 --- a/tools/cpp/unix_cc_configure.bzl
 +++ b/tools/cpp/unix_cc_configure.bzl
-@@ -443,6 +443,9 @@ def configure_unix_toolchain(repository_ctx, cpu_value, overriden_tools):
-             paths["@bazel_tools//tools/cpp:generate_system_module_map.sh"],
-         ))
+@@ -573,6 +573,9 @@ def configure_unix_toolchain(repository_ctx, cpu_value, overriden_tools):
+         if "-fno-cxx-modules" not in result.stderr:
+             extra_flags_per_feature["use_module_maps"] = ["-Xclang", "-fno-cxx-modules"]
  
 +    # Customize for Yocto
 +    builtin_include_directories.append(get_env_var(repository_ctx,"YOCTO_NATIVE_SYSROOT", "NOT_SET_YOCTO_NATIVE_SYSROOT"))
@@ -35,5 +35,5 @@ index d48485b..0d297bf 100755
      repository_ctx.template(
          "BUILD",
 -- 
-2.18.2
+2.49.0
 
diff --git a/recipes-devtools/bazel/files/0001-cutsomize-native-toolchains-for-Yocto.patch b/recipes-devtools/bazel/files/0001-cutsomize-native-toolchains-for-Yocto.patch
index 5758b5e..5de56dd 100644
--- a/recipes-devtools/bazel/files/0001-cutsomize-native-toolchains-for-Yocto.patch
+++ b/recipes-devtools/bazel/files/0001-cutsomize-native-toolchains-for-Yocto.patch
@@ -1,26 +1,26 @@
-From 81c9eae49a10fa8d5ede088e90632db0103e2168 Mon Sep 17 00:00:00 2001
+From f0c6f3420acdbfd22e06603ca3bbeae3e7d98fc2 Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Thu, 19 May 2022 01:11:05 -0700
+Date: Wed, 11 Mar 2026 01:48:31 -0700
 Subject: [PATCH] cutsomize native toolchains for Yocto
 
 Yocto use environment HOSTTOOLS_DIR to provide native toolchains,
 explicitly set it rather than detect
 
 Upstream-Status: Inappropriate [Yocto specific]
-
+Rebase to 7.7.0
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
  tools/cpp/unix_cc_configure.bzl | 6 ++++++
  1 file changed, 6 insertions(+)
 
 diff --git a/tools/cpp/unix_cc_configure.bzl b/tools/cpp/unix_cc_configure.bzl
-index 1b6aeb2..4a36685 100755
+index 69bea13b3a..e7e34a1e45 100644
 --- a/tools/cpp/unix_cc_configure.bzl
 +++ b/tools/cpp/unix_cc_configure.bzl
-@@ -373,6 +373,12 @@ def configure_unix_toolchain(repository_ctx, cpu_value, overriden_tools):
+@@ -387,6 +387,12 @@ def configure_unix_toolchain(repository_ctx, cpu_value, overriden_tools):
      if darwin:
          overriden_tools["gcc"] = "cc_wrapper.sh"
-         overriden_tools["ar"] = "/usr/bin/libtool"
+         overriden_tools["ar"] = _find_generic(repository_ctx, "libtool", "LIBTOOL", overriden_tools)
 +
 +    hosttools_dir = get_env_var(repository_ctx,"HOSTTOOLS_DIR", False)
 +    if hosttools_dir:
@@ -29,7 +29,7 @@ index 1b6aeb2..4a36685 100755
 +
      auto_configure_warning_maybe(repository_ctx, "CC used: " + str(cc))
      tool_paths = _get_tool_paths(repository_ctx, overriden_tools)
-     cc_toolchain_identifier = escape_string(get_env_var(
+ 
 -- 
-2.36.0
+2.49.0
 
diff --git a/recipes-devtools/bazel/files/0001-fix-compile-failure-on-gcc-13.patch b/recipes-devtools/bazel/files/0001-fix-compile-failure-on-gcc-13.patch
deleted file mode 100644
index 2fce1dc..0000000
--- a/recipes-devtools/bazel/files/0001-fix-compile-failure-on-gcc-13.patch
+++ /dev/null
@@ -1,71 +0,0 @@
-From 02fcd86787da1ebb2afad1909cb70839cdac24dc Mon Sep 17 00:00:00 2001
-From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Wed, 13 Sep 2023 10:56:02 +0800
-Subject: [PATCH] fix compile failure on gcc 13
-
-external/com_google_absl/absl/strings/internal/str_format/extension.h:34:33: error: found ':' in nested-name-specifier, expected '::'
-   34 | enum class FormatConversionChar : uint8_t;
-
-Upstream-Status: Pending
-
-Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
----
- distdir_deps.bzl                              |  4 +++
- .../0001-fix-compile-failure-on-gcc-13.patch  | 30 +++++++++++++++++++
- 2 files changed, 34 insertions(+)
- create mode 100644 third_party/com_google_absl/0001-fix-compile-failure-on-gcc-13.patch
-
-diff --git a/distdir_deps.bzl b/distdir_deps.bzl
-index 2ca988e..c460025 100755
---- a/distdir_deps.bzl
-+++ b/distdir_deps.bzl
-@@ -163,6 +163,10 @@ DIST_DEPS = {
-     },
-     "com_google_absl": {
-         "archive": "20211102.0.tar.gz",
-+        "patch_args": ["-p1"],
-+        "patches": [
-+            "//third_party:com_google_absl/0001-fix-compile-failure-on-gcc-13.patch",
-+        ],
-         "sha256": "dcf71b9cba8dc0ca9940c4b316a0c796be8fab42b070bb6b7cab62b48f0e66c4",
-         "urls": [
-             "https://mirror.bazel.build/github.com/abseil/abseil-cpp/archive/refs/tags/20211102.0.tar.gz",
-diff --git a/third_party/com_google_absl/0001-fix-compile-failure-on-gcc-13.patch b/third_party/com_google_absl/0001-fix-compile-failure-on-gcc-13.patch
-new file mode 100644
-index 0000000..257e887
---- /dev/null
-+++ b/third_party/com_google_absl/0001-fix-compile-failure-on-gcc-13.patch
-@@ -0,0 +1,30 @@
-+From 4cb33b2e98fd0b2f201e765a5a0d9c1d4277041e Mon Sep 17 00:00:00 2001
-+From: Hongxu Jia <hongxu.jia@windriver.com>
-+Date: Wed, 13 Sep 2023 11:17:34 +0800
-+Subject: [PATCH] fix compile failure on gcc 13
-+
-+external/com_google_absl/absl/strings/internal/str_format/extension.h:34:33: error: found ':' in nested-name-specifier, expected '::'
-+   34 | enum class FormatConversionChar : uint8_t;
-+
-+Upstream-Status: Pending
-+
-+Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
-+---
-+ absl/strings/internal/str_format/extension.h | 1 +
-+ 1 file changed, 1 insertion(+)
-+
-+diff --git a/absl/strings/internal/str_format/extension.h b/absl/strings/internal/str_format/extension.h
-+index 55cbb56..67d4cc8 100644
-+--- a/absl/strings/internal/str_format/extension.h
-++++ b/absl/strings/internal/str_format/extension.h
-+@@ -21,6 +21,7 @@
-+ #include <cstddef>
-+ #include <cstring>
-+ #include <ostream>
-++#include <cstdint>
-+ 
-+ #include "absl/base/config.h"
-+ #include "absl/base/port.h"
-+-- 
-+2.17.1
-+
--- 
-2.27.0
-
diff --git a/recipes-devtools/bazel/files/0001-fix-unzip-command-not-found.patch b/recipes-devtools/bazel/files/0001-fix-unzip-command-not-found.patch
index eccc34a..5e0ac97 100644
--- a/recipes-devtools/bazel/files/0001-fix-unzip-command-not-found.patch
+++ b/recipes-devtools/bazel/files/0001-fix-unzip-command-not-found.patch
@@ -1,6 +1,6 @@
-From 23e2aff67a03127572641c7286e306c2a20990e2 Mon Sep 17 00:00:00 2001
+From c79e5132e313335dbeafe650c1c4e43e52a5508c Mon Sep 17 00:00:00 2001
 From: Hongxu Jia <hongxu.jia@windriver.com>
-Date: Tue, 8 Dec 2020 11:05:13 +0800
+Date: Wed, 11 Mar 2026 01:41:58 -0700
 Subject: [PATCH] fix unzip: command not found
 
 If host does not provide unzip, build bazel will fail even though
@@ -11,19 +11,19 @@ The reason is var-PATH was not passed to bazel build in some cases.
 Remove hardcoded /bin and /usr/bin from PATH
 
 Upstream-Status: Inappropriate [wr-installer specific]
-
+Rebase to 7.7.0
 Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
 ---
  .../devtools/build/lib/bazel/rules/BazelRuleClassProvider.java  | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/src/main/java/com/google/devtools/build/lib/bazel/rules/BazelRuleClassProvider.java b/src/main/java/com/google/devtools/build/lib/bazel/rules/BazelRuleClassProvider.java
-index 16252df..e7cd609 100755
+index c039229731..287d71695a 100644
 --- a/src/main/java/com/google/devtools/build/lib/bazel/rules/BazelRuleClassProvider.java
 +++ b/src/main/java/com/google/devtools/build/lib/bazel/rules/BazelRuleClassProvider.java
-@@ -469,7 +469,7 @@ public class BazelRuleClassProvider {
-       // Note that --action_env does not propagate to the host config, so it is not a viable
-       // workaround when a genrule is itself built in the host config (e.g. nested genrules). See
+@@ -568,7 +568,7 @@ public class BazelRuleClassProvider {
+       // Note that --action_env does not propagate to the exec config, so it is not a viable
+       // workaround when a genrule is itself built in the exec config (e.g. nested genrules). See
        // #8536.
 -      return "/bin:/usr/bin:/usr/local/bin";
 +      return System.getenv("PATH");
@@ -31,5 +31,5 @@ index 16252df..e7cd609 100755
  
      String newPath = "";
 -- 
-2.18.2
+2.49.0
 
diff --git a/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch b/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch
deleted file mode 100644
index 0d20e66..0000000
--- a/recipes-devtools/bazel/files/1f2b3ed4ac717b814d02a0d125f160ddabe78003.patch
+++ /dev/null
@@ -1,57 +0,0 @@
-From 1f2b3ed4ac717b814d02a0d125f160ddabe78003 Mon Sep 17 00:00:00 2001
-From: Yun Peng <pcloudy@google.com>
-Date: Wed, 5 Apr 2023 15:13:26 +0200
-Subject: [PATCH] Patch zlib to fix compatibility with latest Xcode
-
-Fixes https://github.com/bazelbuild/bazel/issues/17956
-
-Partial commit for third_party/*, see #17987.
-
-Closes #17987
-
-Signed-off-by: Yun Peng <pcloudy@google.com>
-
-Upstream-Status: Backport [https://github.com/bazelbuild/bazel/commit/1f2b3ed4ac717b814d02a0d125f160ddabe78003]
-Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
----
- third_party/zlib/gzguts.h   |  4 ++++
- third_party/zlib/zlib.patch | 15 +++++++++++++++
- 2 files changed, 19 insertions(+)
- create mode 100644 third_party/zlib/zlib.patch
-
-diff --git a/third_party/zlib/gzguts.h b/third_party/zlib/gzguts.h
-index 57faf37165a354..54f668fcb20536 100644
---- a/third_party/zlib/gzguts.h
-+++ b/third_party/zlib/gzguts.h
-@@ -3,6 +3,10 @@
-  * For conditions of distribution and use, see copyright notice in zlib.h
-  */
-
-+#ifndef _WIN32
-+  #include <unistd.h>
-+#endif
-+
- #ifdef _LARGEFILE64_SOURCE
- #  ifndef _LARGEFILE_SOURCE
- #    define _LARGEFILE_SOURCE 1
-diff --git a/third_party/zlib/zlib.patch b/third_party/zlib/zlib.patch
-new file mode 100644
-index 00000000000000..7181d44aa9f9b1
---- /dev/null
-+++ b/third_party/zlib/zlib.patch
-@@ -0,0 +1,15 @@
-+diff --git a/third_party/zlib/gzguts.h b/third_party/zlib/gzguts.h
-+index 57faf37165..54f668fcb2 100644
-+--- a/third_party/zlib/gzguts.h
-++++ b/third_party/zlib/gzguts.h
-+@@ -3,6 +3,10 @@
-+  * For conditions of distribution and use, see copyright notice in zlib.h
-+  */
-+
-++#ifndef _WIN32
-++  #include <unistd.h>
-++#endif
-++
-+ #ifdef _LARGEFILE64_SOURCE
-+ #  ifndef _LARGEFILE_SOURCE
-+ #    define _LARGEFILE_SOURCE 1
diff --git a/recipes-devtools/bazel/files/include_stdint.patch b/recipes-devtools/bazel/files/include_stdint.patch
deleted file mode 100644
index 35c57c2..0000000
--- a/recipes-devtools/bazel/files/include_stdint.patch
+++ /dev/null
@@ -1,28 +0,0 @@
-https://github.com/lihaohong6/COPR/blob/bf48c5450a909cf8358e3cbd81cdde26df426e12/bazel7/include_stdint.patch
-
-Upstream-Status: Submitted [https://github.com/bazelbuild/bazel/issues/25514]
-
-diff --git a/src/main/cpp/archive_utils.h b/src/main/cpp/archive_utils.h
-index 18856ab..5298a36 100644
---- a/src/main/cpp/archive_utils.h
-+++ b/src/main/cpp/archive_utils.h
-@@ -15,6 +15,7 @@
- #ifndef BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
- #define BAZEL_SRC_MAIN_CPP_ARCHIVE_UTILS_H_
-
-+#include <cstdint>
- #include <string>
- #include <vector>
-
-diff --git a/src/main/cpp/util/logging.h b/src/main/cpp/util/logging.h
-index b2cd459..7bf5a00 100644
---- a/src/main/cpp/util/logging.h
-+++ b/src/main/cpp/util/logging.h
-@@ -14,6 +14,7 @@
- #ifndef BAZEL_SRC_MAIN_CPP_LOGGING_H_
- #define BAZEL_SRC_MAIN_CPP_LOGGING_H_
-
-+#include <cstdint>
- #include <memory>
- #include <sstream>
- #include <string>
-- 
2.34.1


