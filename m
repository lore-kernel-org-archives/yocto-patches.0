Return-Path: <hongxu.jia@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F269AFF8868
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 12:06:13 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11464.1777377966611467451
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 28 Apr 2026 05:06:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=r16drhqe;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=95787c334d=hongxu.jia@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA2d9q1620944;
	Tue, 28 Apr 2026 12:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=rM+KjlNP0
	wYfWOffCfaSIp5jNEFezTuTLjOdCVjD59s=; b=r16drhqevKbSdB4T9zwaVdZkE
	7Di/K/a3pIqBnsHL96cq8Y6LLsfVXRoCtzwrRwHz/VZQVYpyNCLzfZbS8rdGUwUi
	F+nTgbjWlO292xfeWtTTGr5sfriKSiP01TiXvSXSKcJ1fI0A8ZzaOBMqzChJ1bQj
	tzxHgLgEixyv/NYs1xLJG1SOHF14UdIosFylge+oz92FhkG9vb8t2ytanVkeF/BQ
	WTbXFCbMw/lQyL7hqRWweqUXpf88RbNGHciDFoertOeZq202wveJZyZjpyq2hfU/
	TWoJwNhctiWOdmeCiwHMJGumoXj8h/xYN810K673uCfwDMii3lOcANis4j1bw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4drju0beh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 28 Apr 2026 12:06:04 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 28 Apr 2026 05:06:03 -0700
Received: from ala-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 28 Apr 2026 05:06:03 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <twoerner@gmail.com>
Subject: [wic][PATCH] Fix bb and oe module confliction
Date: Tue, 28 Apr 2026 05:06:02 -0700
Message-ID: <20260428120602.2881446-1-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=69f0a2ac cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=mMTV-WFRPUd6FRNxQjIA:9 a=O8hF6Hzn-FEA:10 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 5VouYZRRvk7Tm-OW-93VfPTN8HWLganu
X-Proofpoint-ORIG-GUID: 5VouYZRRvk7Tm-OW-93VfPTN8HWLganu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExMSBTYWx0ZWRfX1EgGbiHppN4n
 /ohE28RVw/5+YR+/BEODoQdL5TnUgC3htieE/9yB3WIfXsilKTSO9YRzPSMUYm7V9rN/z61WUV5
 J2aI501xn8subMqNSqcEEcZvOBA10WvuUhKZeN41w8cg4iCTGFSs2PfrdgnT8CDzSK9kw+gtJeG
 OjTFk8fAmbpSVBBvqmetcnYkCUjzNv6ZkgpjONo0PfmO3Qq4zJcsCzMkbmPrzptbSmzNXnaVHhV
 ZsA/gc4iUZsI70yE0k6FTjo6h+ECRmDtKJ2cICMtIVIbgXPyHD5++ufwWxQIBTg45geK57lGX1p
 f8PNOVVOhbszJJw5FGwp7QM8DBC8QBT0OA9rMxI6CnycvDTsRHjgIHbkRfdKjt+MzY8zH/zI3es
 tqgOtEra/SwyVl/NtX0Ivm/jyVM32piorSfThxlT8l09X3XpbqGioVeDfy6AL9gWec37iOPWHjR
 8368+ZfDCeSP0k5RBKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 clxscore=1011 priorityscore=1501 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280111
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Apr 2026 12:06:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3870

While adding nativesdk-wic to buildtools-extended-tarball and using
it for bitbake build, it triggered failure
[snip]
$ which wic
path-to/buildtools.buildtools-extended-standalone-10.26.17.0/sysroots/x86_64-wrlinuxsdk-linux/usr/bin/wic

$ bitbake core-image-minimal
ERROR: Unable to parse Var <METADATA_BRANCH[:=]>
Traceback (most recent call last):
  File "oe-core/bitbake/lib/bb/data_smart.py", line 465, in expandWithRefs
    s = __expand_python_regexp__.sub(varparse.python_sub, s)
  File "oe-core/bitbake/lib/bb/data_smart.py", line 154, in python_sub
    value = utils.better_eval(codeobj, DataContext(self.d), {'d' : self.d})
  File "oe-core/bitbake/lib/bb/utils.py", line 489, in better_eval
    return eval(source, ctx, locals)
  File "Var <METADATA_BRANCH[:=]>", line 1, in <module>
AttributeError: module 'oe' has no attribute 'buildcfg'
[snip]

In order to avoid confliction with oe module in oe-core and
bb module in bitbake, move src/bb -> src/wic/bb, src/oe -> src/wic/oe,
rename oe to wic.oe, bb to wic.bb

After apply the patch to wic recipe locally, run oe-selftest wic case
$ oe-selftest -r wic
...
2026-04-28 20:00:03,230 - oe-selftest - INFO - SUMMARY:
2026-04-28 20:00:03,230 - oe-selftest - INFO - oe-selftest () - Ran 95 tests in 7853.682s
2026-04-28 20:00:03,230 - oe-selftest - INFO - oe-selftest - FAIL - Required tests failed (successes=87, skipped=1, failures=0, errors=7)

PS: the FAIL cases are about qemu related about `Permission denied on tap'

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 pyproject.toml                              | 4 ++--
 src/{ => wic}/bb/__init__.py                | 0
 src/{ => wic}/bb/utils.py                   | 0
 src/{ => wic}/oe/__init__.py                | 0
 src/{ => wic}/oe/bootfiles.py               | 0
 src/{ => wic}/oe/path.py                    | 2 +-
 src/wic/plugins/imager/direct.py            | 2 +-
 src/wic/plugins/source/bootimg_partition.py | 2 +-
 src/wic/plugins/source/rootfs.py            | 2 +-
 9 files changed, 6 insertions(+), 6 deletions(-)
 rename src/{ => wic}/bb/__init__.py (100%)
 rename src/{ => wic}/bb/utils.py (100%)
 rename src/{ => wic}/oe/__init__.py (100%)
 rename src/{ => wic}/oe/bootfiles.py (100%)
 rename src/{ => wic}/oe/path.py (99%)

diff --git a/pyproject.toml b/pyproject.toml
index 6ef2946..fdc1ce0 100644
--- a/pyproject.toml
+++ b/pyproject.toml
@@ -25,10 +25,10 @@ Repository = "https://git.yoctoproject.org/wic"
 wic = "wic.cli:main"
 
 [tool.hatch.build]
-packages = ["src/wic", "src/oe", "src/bb"]
+packages = ["src/wic"]
 
 [tool.hatch.build.targets.wheel]
-packages = ["src/wic", "src/oe", "src/bb"]
+packages = ["src/wic"]
 
 [build-system]
 requires = ["hatchling>=1.21"]
diff --git a/src/bb/__init__.py b/src/wic/bb/__init__.py
similarity index 100%
rename from src/bb/__init__.py
rename to src/wic/bb/__init__.py
diff --git a/src/bb/utils.py b/src/wic/bb/utils.py
similarity index 100%
rename from src/bb/utils.py
rename to src/wic/bb/utils.py
diff --git a/src/oe/__init__.py b/src/wic/oe/__init__.py
similarity index 100%
rename from src/oe/__init__.py
rename to src/wic/oe/__init__.py
diff --git a/src/oe/bootfiles.py b/src/wic/oe/bootfiles.py
similarity index 100%
rename from src/oe/bootfiles.py
rename to src/wic/oe/bootfiles.py
diff --git a/src/oe/path.py b/src/wic/oe/path.py
similarity index 99%
rename from src/oe/path.py
rename to src/wic/oe/path.py
index 47b0c13..3e95ea0 100644
--- a/src/oe/path.py
+++ b/src/wic/oe/path.py
@@ -10,7 +10,7 @@ import shutil
 import subprocess
 import os.path
 
-import bb
+import wic.bb as bb
 
 def join(*paths):
     """Like os.path.join but doesn't treat absolute RHS specially"""
diff --git a/src/wic/plugins/imager/direct.py b/src/wic/plugins/imager/direct.py
index 832d0e6..3a4f067 100644
--- a/src/wic/plugins/imager/direct.py
+++ b/src/wic/plugins/imager/direct.py
@@ -19,13 +19,13 @@ import uuid
 
 from time import strftime
 
-from oe.path import copyhardlinktree
 
 from wic import WicError
 from wic.filemap import sparse_copy
 from wic.ksparser import KickStart, KickStartError
 from wic.pluginbase import PluginMgr, ImagerPlugin
 from wic.misc import get_bitbake_var, exec_cmd, exec_native_cmd
+from wic.oe.path import copyhardlinktree
 
 logger = logging.getLogger('wic')
 
diff --git a/src/wic/plugins/source/bootimg_partition.py b/src/wic/plugins/source/bootimg_partition.py
index cc121a7..96f5e14 100644
--- a/src/wic/plugins/source/bootimg_partition.py
+++ b/src/wic/plugins/source/bootimg_partition.py
@@ -16,12 +16,12 @@ import logging
 import os
 import re
 
-from oe.bootfiles import get_boot_files
 
 from wic import WicError
 from wic.engine import get_custom_config
 from wic.pluginbase import SourcePlugin
 from wic.misc import exec_cmd, get_bitbake_var
+from wic.oe.bootfiles import get_boot_files
 
 logger = logging.getLogger('wic')
 
diff --git a/src/wic/plugins/source/rootfs.py b/src/wic/plugins/source/rootfs.py
index 06fce06..dca4106 100644
--- a/src/wic/plugins/source/rootfs.py
+++ b/src/wic/plugins/source/rootfs.py
@@ -16,12 +16,12 @@ import os
 import shutil
 import sys
 
-from oe.path import copyhardlinktree
 from pathlib import Path
 
 from wic import WicError
 from wic.pluginbase import SourcePlugin
 from wic.misc import get_bitbake_var, exec_native_cmd
+from wic.oe.path import copyhardlinktree
 
 logger = logging.getLogger('wic')
 
-- 
2.49.0


