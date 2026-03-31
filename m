Return-Path: <mingli.yu@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215361061B2D
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 02:38:19 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11848.1774924694905882241
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 30 Mar 2026 19:38:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=K7OWW/I8;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8550ec322d=mingli.yu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UNPE8A2004745
	for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 19:38:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS06212021; bh=6zoSNvUU5RybVQMQlv0n
	/+ChCH2JVS9Bp8hZ6uW9rKc=; b=K7OWW/I8gE8C1D08upXNwBV/vjSZKX839EAy
	b4dTNcuGpuNK2Y9O3EcVD2uZW00rHQmZnW6mue4QZqHJqaJtnPixxiTgHxAOPaBU
	AmwwN17jiWRJVcEtcJq7S5XUnuPxvdFyk3l+FrvqTkCrL9BjONfSlTiJk+Ydmjr0
	b6TS1XtIcL7XRsb3XXS4GgW/iJLvkTAckdOoIarKa6F1X3dHW9RkyQkFtLgmHYbk
	w0Tie43RwIg4U5MGIJejNEXtipz4k4E4SAPWN1sysIhO5+D2uFHBun+RexIgVWhm
	86zq1QYIBXdd61oZlB3N66sCH0CyMsalrDZYhN27O9dweCsjQw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d6a8vasgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <yocto-patches@lists.yoctoproject.org>; Mon, 30 Mar 2026 19:38:14 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 30 Mar 2026 19:38:14 -0700
Received: from pek-lpg-core4.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 30 Mar 2026 19:38:13 -0700
From: <mingli.yu@windriver.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH] scap-security-guide: Replace pkg_resources.Requirement
Date: Tue, 31 Mar 2026 10:38:12 +0800
Message-ID: <20260331023812.3353409-1-mingli.yu@windriver.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Kge7K25UsVLrIoxY5q8cGyVzDJDr2W1S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAyMyBTYWx0ZWRfX150qiiU+A5yr
 UvjCSOsf/3+vc7i/88ayHHCojIQJXv9YMfmnZg98md8s5arn7xB4KQtLCABBS/djiV1QQM+nRUl
 fjxvDtX06yxKT6KtmgHbvuDOtHJA0RLTjxjJIRy4YpHlaDwTfRVkFMx9ZgYtFN/34TaB/MNhtpA
 mvJ2pxubd8GjTSg/89ObPzghy5qUjzsK9PXllpH7t/H0AJ10vJyRpiTPaUX48VsbzrY3k3e6gJA
 +s1yrvkGug5N/2KeB8tpXNJ/9LVNMqy+A1ZEluyvfRA4Ex5xSZVhbwQZ4joM9YXyXxOBxsDb3YV
 iTa4nAaM4ewtDA2lZ34M8WaqL9E74eSMi4xrkR9+mNj6KXTcZ4MVF6qoDTauNzbJHak8SlY6sY+
 XhlxccbLOIpZ+mJuoIHSXJ9Ew52wod/WZAjnbDVuNNomsJBmvFYpawYGyMzXHT9Y31xl44EspyH
 midBV4pmcSWHrOlyXwQ==
X-Proofpoint-ORIG-GUID: Kge7K25UsVLrIoxY5q8cGyVzDJDr2W1S
X-Authority-Analysis: v=2.4 cv=ZKHaWH7b c=1 sm=1 tr=0 ts=69cb3396 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8
 a=aT1eW8wU1ieatFMXG7oA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310023
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 31 Mar 2026 02:38:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3588

From: Mingli Yu <mingli.yu@windriver.com>

Backport a patch [1] to fix below build error.
 | ModuleNotFoundError: No module named 'pkg_resources'

[1] https://github.com/ComplianceAsCode/content/commit/12f2503

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 ...01-Replace-pkg_resources.Requirement.patch | 127 ++++++++++++++++++
 .../scap-security-guide_0.1.78.bb             |   1 +
 2 files changed, 128 insertions(+)
 create mode 100644 recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch

diff --git a/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch b/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch
new file mode 100644
index 0000000..604e099
--- /dev/null
+++ b/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch
@@ -0,0 +1,127 @@
+From 12f2503c51484005f29dad75c80395352ac8b668 Mon Sep 17 00:00:00 2001
+From: Matthew Burket <mburket@redhat.com>
+Date: Tue, 18 Nov 2025 18:32:45 -0600
+Subject: [PATCH] Replace pkg_resources.Requirement
+
+Replaced pkg_resources with a custom RequirementParser.
+It implements just enough of pkg_resources.Requirement to work for our
+project.
+
+Fixes: #13902
+
+Upstream-Status: Backport [https://github.com/ComplianceAsCode/content/commit/12f2503]
+
+Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
+---
+ ssg/requirement_specs.py                      | 51 ++++++++++++++-----
+ .../unit/ssg-module/test_requirement_specs.py | 11 ++++
+ 2 files changed, 49 insertions(+), 13 deletions(-)
+
+diff --git a/ssg/requirement_specs.py b/ssg/requirement_specs.py
+index 10e6a6f35d..16637ddff8 100644
+--- a/ssg/requirement_specs.py
++++ b/ssg/requirement_specs.py
+@@ -1,18 +1,43 @@
+ """
+ Common functions for processing Requirements Specs in SSG
+ """
+-
+-import pkg_resources
+ import re
++from typing import Tuple, List
+ 
+ from ssg import utils
+ 
+-# Monkey-patch pkg_resources.safe_name function to keep underscores intact
+-# Setuptools recognize the issue: https://github.com/pypa/setuptools/issues/2522
+-pkg_resources.safe_name = lambda name: re.sub('[^A-Za-z0-9_.]+', '-', name)
+-# Monkey-patch pkg_resources.safe_extras function to keep dashes intact
+-# Setuptools recognize the issue: https://github.com/pypa/setuptools/pull/732
+-pkg_resources.safe_extra = lambda extra: re.sub('[^A-Za-z0-9.-]+', '_', extra).lower()
++
++class RequirementParser:
++    name: str
++    operation: str
++    version: str
++    extra: str
++
++    def __init__(self, target_v):
++        match = re.match(r'^(?P<name>[a-zA-Z0-9\-_.]+)\[?(?P<extra>[a-zA-Z0-9\-_]+)?]?\s*(?P<operation>[><!~=]*)?\s*(?P<version>.*)?$',
++                         target_v)
++        if match:
++            self.name = match.groupdict().get('name', '')
++            self.operation = match.groupdict().get('operation', '')
++            self.version = match.groupdict().get('version', '')
++            self.extra = match.groupdict().get('extra', '')
++
++    @property
++    def specs(self) -> List[Tuple[str, str]]:
++        if self.operation and self.version:
++            return [(self.operation, self.version)]
++        else:
++            return []
++
++    @property
++    def project_name(self) -> str:
++        return self.name
++
++    @property
++    def extras(self) -> List[str]:
++        if self.extra:
++            return [self.extra.lower()]
++        return []
+ 
+ 
+ def _parse_version_into_evr(version):
+@@ -62,11 +87,11 @@ class Requirement:
+     A class to represent a package requirement with version specifications.
+ 
+     Attributes:
+-        _req (pkg_resources.Requirement): The parsed requirement object.
++        _req (RequirementParser): The parsed requirement object.
+         _specs (utils.VersionSpecifierSet): The set of version specifiers for the requirement.
+     """
+-    def __init__(self, obj):
+-        self._req = pkg_resources.Requirement.parse(obj)
++    def __init__(self, obj: str):
++        self._req = RequirementParser(obj)
+         self._specs = utils.VersionSpecifierSet(
+             [_spec_to_version_specifier(spec) for spec in self._req.specs]
+         )
+@@ -131,7 +156,7 @@ class Requirement:
+             bool: True if the package requirement is parametrized (includes extras),
+                   False otherwise.
+         """
+-        return bool(pkg_resources.Requirement.parse(name).extras)
++        return bool(RequirementParser(name).extras)
+ 
+     @staticmethod
+     def get_base_for_parametrized(name):
+@@ -144,4 +169,4 @@ class Requirement:
+         Returns:
+             str: The base project name of the package.
+         """
+-        return pkg_resources.Requirement.parse(name).project_name
++        return RequirementParser(name).project_name
+diff --git a/tests/unit/ssg-module/test_requirement_specs.py b/tests/unit/ssg-module/test_requirement_specs.py
+index 13c3292b5f..ae078e9a8f 100644
+--- a/tests/unit/ssg-module/test_requirement_specs.py
++++ b/tests/unit/ssg-module/test_requirement_specs.py
+@@ -33,3 +33,14 @@ def test_parse_version_into_evr():
+         v = requirement_specs._parse_version_into_evr(':')
+     with pytest.raises(ValueError):
+         v = requirement_specs._parse_version_into_evr('-')
++
++def test_requirement_parse():
++    req = requirement_specs.RequirementParser("package[NetworkManager]>=8.7")
++    assert req.project_name == 'package'
++    assert req.operation == '>='
++    assert req.version == '8.7'
++    assert req.extras == ['networkmanager']
++    assert req.specs == [('>=', '8.7')]
++
++    req = requirement_specs.RequirementParser('linux_os')
++    assert req.project_name == 'linux_os'
+-- 
+2.34.1
+
diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
index 919a09c..e42b054 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
@@ -8,6 +8,7 @@ LICENSE = "BSD-3-Clause"
 
 SRCREV = "f7d794851971087db77d4be8eeb716944a1aae21"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;protocol=https;branch=stable \
+           file://0001-Replace-pkg_resources.Requirement.patch \
            file://run_eval.sh \
            "
 
-- 
2.34.1


