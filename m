Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B8B10987B8
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 02:17:26 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13677.1774405043190869181
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Mar 2026 19:17:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=NJ6qAEXg;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7544e4345f=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P1T34v3384636
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=/AflOLxnZnUwsHUlD1tr
	vM0g+/X1sYXUZe6gs2M2zNc=; b=NJ6qAEXgLdfOj1PEqYalz1mVRGpQxa/8cTMX
	ToBTUacG0TjVHTJJeCNXEv9DPnmzDVJtkyZ9geS8+xSceZunYYsBy2q3zd4lteum
	+9RJq6W87iRY3BsKf7yLRJ2S1EyDuVdGHN+B9IsO08uqyTJFK0Z92xEHO0CWqiIB
	wxxp0HP8yeaMK67PmCfOPeVvzFie34EAGb7zOjwbhEu+i2ZXmiECE8EEUgvhs5PE
	+z8jjh3+kfU2lWI1lttBGUoaPPoJPQdOsrvZQW+jkTBQ9eYD8oXEpRl7J0dxBy29
	sdfagIsMFPukQaH+BKWHV3TLmxq5MxfT+Z6sQ4aw8IhmaHO+mQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj84du6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:21 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 24 Mar 2026 19:17:20 -0700
Received: from pek-lpg-core5.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 24 Mar 2026 19:17:20 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-tensorflow][master][0/14] Upgrade tensorflow from 2.19.0 to 2.21.0
Date: Wed, 25 Mar 2026 10:17:05 +0800
Message-ID: <20260325021719.1526525-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UuuZW7gMSEDSPHcVVEs6L1h7HUQx7xp5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX35CcHftTWISU
 QHKcx3XqP8mfqDUmMk3uNO44LrHu+d3BEph7T2ZNhQWbaSqKQj5nGu2Kbxq9xv19JXxVFKG0uhR
 +KZFmYURfSsHGB9j2gFcdg6D5uwRhLGMKVpANFMiuZyOQ3OllyWDlOOhxcB7H7ms/WLECbOUqy1
 npm7hgUQHJBdIgWV8nhxFxNIeQxsxjEJ67aEK3fi/wmm1qDWX01GZ6fx+uk03eiN3nXgZ95gkBU
 +L0qo2ykCQjOYkQyG9DPRm1M3nXrxxOWW5Cgm85y1Fh4bZVb4btnUJ+UzZMQBn92fOcfZOM1Fou
 tWoge9DgePPuUPhTsylrhiGMP1jWVzUkIMa7B2wbSWqOCgQ2/eKc6pnOSLOnJL/I/3p9H65hN3N
 fnL++dGIK6sHDf9H8+SGwVp82VZbXCiVpR54GY1Ho9NlpIDnxMq1wmpYLuh6zri1tieGRcqEUZe
 Npw2WQRN+3lEUF6ehXg==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c345b2 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=01C68wJfAAAA:8 a=NEAV23lmAAAA:8 a=C6wcXyHOAAAA:20
 a=t7CeM3EgAAAA:8 a=LVmFSfuHPSMqEmlTONcA:9 a=DY59otl68eHIR0tbHspE:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: UuuZW7gMSEDSPHcVVEs6L1h7HUQx7xp5
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
 <yocto-patches@lists.yoctoproject.org>; Wed, 25 Mar 2026 02:17:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3536

Summary: Upgrade meta-tensorflow from 2.19.0 to 2.21.0

* Git logs
[meta-tensorflow]
commit a4878fbdbaf0b0519b74e33b39c50763c7f4cdc0
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Tue Mar 24 17:54:08 2026 +0800

    tensorflow: remove obsolete patches
    
    They are not required any more
    - 0001-fix-compile-XNNPACK-failed-for-aarch64.patch
    - 0001-fix-compile-failed.patch
    - 0001-tensorflow-BUILD-fix-build-failure-for-aarch64.patch
    - 0001-third_party-ducc-fix-ambiguous-failure.patch
    - 0002-third_party-eigen_archive-workaround-ice-failure-whi.patch
    - 0004-drop-v2-config.patch
    - 0006-fix-build-failure.patch
    - 0007-support-hermetic-Python.patch
    - 0009-Fix-build-with-gcc-12.patch
    - 0012-disable-avxvnni-and-avx512fp16-for-x86.patch
    - 0013-fix-build-tensorflow-lite-examples-label_image-label.patch
    - 0016-CheckFeatureOrDie-use-warning-to-avoid-die.patch
    - 0017-support-32-bit-x64-and-arm-for-yocto.patch
    - 0019-fix-build-failure-for-2.19.patch
    - 0020-tensorflow-compiler-mlir-lite-fix-tensorflow_lite_qu.patch
    - 0001-Add-hermetic-PYTHON-3.13-requirements-lock-file-in-T.patch
    - 0001-support-gcc-15.patch
    - 0001-support-python-3.33.patch
    - 0010-fix-patchelf-not-found.patch
    - 0011-fix-llvm-project-timeout-occasionally.patch
    - 0021-build_pip_package_with_bazel.sh-correct-version.patch
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit b6d6729635d9d41695e85a468e4bc3c986b4a202
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Tue Mar 24 17:58:36 2026 +0800

    tensorflow: refresh patches for 2.21.0
    
    - 0001-third_party-tf_runtime-fix-compile-failure.patch
    - 0008-make-hermetic-python3-support-offline-build.patch
    - 0012-add-yocto-toolchain-to-support-cross-compiling.patch
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit 4c1a1a2e3dbf488e7f766bf0a3352d020008b274
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Wed Mar 11 15:28:02 2026 +0800

    tensorflow/tensorflow-native/tensorflow-lite: upgrade 2.19.0 -> 2.21.0
    
    1. Support python 3.14
    - 0001-Add-support-for-Python-3.14-to-TensorFlow-build-conf.patch
    - 0001-Update-grpcio-to-1.78.0-for-Python-3.14.patch
    - 0001-correct-h5py-version-for-python-3.14.patch
    - 0001-fix-pypi_keras-is-not-defined.patch
    
    2. Swith toolchain to clang
    - BUILD.yocto_compiler
    - cc_config.bzl.tpl
    - Clean up gcc specific CFALGS and patches
    
    3. Migrating to Platforms [1]
    - 0001-set-x83_64-to-arch-of-whl.patch
    - 0001-support-cross-compile-for-target-aarch64.patch
    - BUILD.in
    
    [1] https://bazel.build/concepts/platforms
    
    4. Remove TF_ENABLE_XLA=0 otherwise `import tensorflow' failed
    [snip]
    $ python3 -c "import tensorflow"
    ...
    |    from tensorflow.python.platform import _pywrap_cpu_feature_guard
    |ImportError: .venv/lib/python3.13/site-packages/tensorflow/python/
    platform/../lib_pywrap_tensorflow_common.so: undefined symbol: _ZN4mlir3sdy18TensorShardingAttr13getClosedLikeES1_
    [snip]
    
    5. According to [2], revert to use external Yocto toolchains
    - 0001-use-external-toolchains.patch
    
    [2] https://github.com/tensorflow/tensorflow/commit/ac56b0e840919cea88ed847f364468c8332b5333
    
    6. Fix tensorflow-lite compile failed
    - 0001-do-not-use-pywrap-rules.patch
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit 5da554a2858b5d8d98456cb3ba2dc3876f846696
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Tue Mar 24 12:14:27 2026 +0800

    classes/unsupportarch.bbclass: update CPUs
    
    Do not support 32bit arm and x86
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit ab69230eec15d948f9de502286ba1e0cd12db78c
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Thu Mar 12 19:15:12 2026 +0800

    Switch tf-keras to python3-keras 3.13.2
    
    Add LICENSE from https://github.com/keras-team/keras/blob/master/LICENSE
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit 98bd429302d29c0b489ded70666a84f4ce3d02e9
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Thu Mar 12 12:54:48 2026 +0800

    bazel-native: fix compile failure
    
    According to [1][2], fix compile bazel failed
    
    [1] https://github.com/bazelbuild/bazel/issues/27349
    [2] https://github.com/bazelbuild/bazel/issues/26162
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit bc22a52f34d5e72d8cf3ea52ce75c7db39ac55dd
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Thu Mar 12 12:11:56 2026 +0800

    Upgrade openjdk-11 to openjdk-21
    
    The bazel 7.7.0 requires JDK 21 [1], upgrade openjdk-11 to openjdk-21
    
    [1] https://github.com/bazelbuild/bazel/commit/7a5c1fafac4971f9dc8e9a14dd3f5fee545e3877
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit eae659814fec9b43b62a1a1284f316ee702ad1fc
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Wed Mar 11 16:58:20 2026 +0800

    bazel-native: upgrade 6.0.0 -> 7.7.0
    
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

commit b6215d27018de635930bb890bab581ac1032df16
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Tue Mar 24 15:53:04 2026 +0800

    python3-opt-einsum: 3.3.0 -> 3.4.0
    
    Swtich to python_hatchling
    
    Remove obsolete patch
    - 0001-Use-ConfigParser-instead-of-SafeConfigParser.patch
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit a57d71ff251297e4549cb91ac7ff3a36d9ffd5c3
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Tue Mar 24 15:40:55 2026 +0800

    python3-mldtypes: 0.5.1 -> 0.5.4
    
    Remove obsolete patch
    - 0001-fix-setuptools-missing.patch
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit de859d2fabcdc5e68f60a313c5335282f80f8935
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Tue Mar 24 13:13:06 2026 +0800

    python3-optree: add recipe 0.19.0
    
    It is required by tensorflow and keras
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit 5a8e06ae0ac9233c79d274fc28ad04852b2e17e8
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Wed Mar 18 10:30:12 2026 +0800

    classes/bazel.bbclass: multiple fixes
    
    - Make run `rm -rf ${BAZEL_DIR}' could work
    
    - Remove znoexecstack
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit a6bb8260c0cbea533492bb45ba51b35dd29ef7db
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Tue Mar 17 16:09:32 2026 +0800

    tensorflow-estimator: remove recipe
    
    Due to commit [1], remove Estimator from Tensorflow.
    
    [1] https://github.com/tensorflow/tensorflow/commit/aa35dc27617676322972f2fd482ed43a7a7e1d16
    
    Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>

commit 32c443afe8f81273b89d0df97ce5f3a4d78a9b69
Author: Hongxu Jia <hongxu.jia@windriver.com>
Date:   Wed Mar 11 15:44:05 2026 +0800

    Revert "Add python3 3.13.11 back"
    
    This reverts commit 3fa809419857160ffa23762adbee2f20f9f9fbce.



