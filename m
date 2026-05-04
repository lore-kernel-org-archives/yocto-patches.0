Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B9ECD342F
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:36:33 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9183.1777876590142260986
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 03 May 2026 23:36:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=WQYAcmyG;
 spf=pass (domain: ericsson.com, ip: 40.107.159.61, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmvOND6EoMLiqWoNHGE41vWtdwhc5zZpVtZWVbABQe/V/5cpZEUs7MpSrVIVrChTGZ748tBwoQ+JfFkawAXTIIyhjBpB+qd3vq0E/EqSAUVRmhoIFnklog1OraqfJau/P7HI0WCgUPP4N159+98yH5dQeQsOhdJJWUO9oNAp4yvqOikLCWhLT+C/yt+Ym2W7uHv8j6oZ3bry20R8B9XfuLi4hy7/I8++hnC31TAsZAvIZzUo6kPwhs+zdVxnzomRu0PgdB1cJZxyii9moKmYAQbNR9IEynTeYyzfTHWlYcTF6zM/tjARbiJY+b1NQOYqLnLtqIe4GZ1QSJn3vkixrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpFmFRCFsHuQ3E+OmRNAXJn59TPAnX3kFgdq+CDw6oE=;
 b=WxMY56zdZ6Lb5HHjt2HawFBvmW4RuhJZ+QK9JP8v5wKvTOaFhGyXOYce/0O6AlRPHq4WZ5cqd0nYYqxRqmEacCGgeqpq1uz8wiU6LoGy73Z9q1EbXqA7IMdYfS/1GNeCzvfmM4PgjKW65XmI9J4sl201WggGrNhPCpJwMOGJiwL0GDEQRQ8m4NCfh8NdheguQFrLO8bWME+siTYB350+lUZsatZ8CacZcQYLgYg7RFJ0qc5L9DA/XNvfehKvKPbcQVh41Bi6EzW9/7DgGJnAM3PRhfeBEIfKYsiasagSGhaqN1vFolMGckzBSzTYcp196uAsTmPlfbSB+C3NGQhdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpFmFRCFsHuQ3E+OmRNAXJn59TPAnX3kFgdq+CDw6oE=;
 b=WQYAcmyGrgGo8bTAjEFoxMNXnjbDUVag2q0WEfvX5ezZLXbVLZvc+UisWol4ddDX7FP2vKPIp5dMw6pFm6/m0+6Lp/T5TmSIGp2Vmr6M0O8Pz/Pa7P6gCm0H58P+Zs6fKsaYQW3sD8dKh38gQzdUPWC8H8J070NyhKQfEgW72+Mrb3Tat6F6rpVrneHK0IiSSsMWO9ecWpzg4bSyIiTIY4sLN9zgA8/5Bw6eXaeM62HrriM3EKjyvx0TeW63wYFINze8/G8qghRnjRrRAdib75e0wguPgz+JN6S/02pAKa+DB9uatixsQeuqcUezu2GVAp3Z55tTzDT0DTWyUWtmaw==
Received: from CWLP123CA0228.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::20)
 by DB9PR07MB11090.eurprd07.prod.outlook.com (2603:10a6:10:5fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 06:36:23 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::27) by CWLP123CA0228.outlook.office365.com
 (2603:10a6:400:19f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 06:36:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 06:36:23 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 4 May 2026 08:36:23 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id C9A594020B7B;
	Mon,  4 May 2026 08:36:22 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id B467A700DB94; Mon,  4 May 2026 08:36:22 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>
Subject: [AUH][PATCH v3 3/4] upgrade-helper.py: Add stable option for patch-only upgrades
Date: Mon, 4 May 2026 08:36:11 +0200
Message-ID: <20260504063614.3831203-4-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504063614.3831203-1-daniel.turull@ericsson.com>
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|DB9PR07MB11090:EE_
X-MS-Office365-Filtering-Correlation-Id: 97777bdb-fc19-47c3-7bdb-08dea9a775f3
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	C0WN0UXKkPUAM+IfUEv4/WjmtRnrUHCOQXyuyKnbNwzpcnwgcEcO0RGQXu9uxwqSxFUdp6srgvS23Mo3mAAdbc6vO97jgyHioS3QwMG2TiCbJ1yGB6IFd9rrzfD3Hf7JxaoukDz84Rj3lQBO4BAa6wSXqGJv5dBLt5wnKf3OMFShbO+ayOJhwe9iqoMM5KPXtXuP2TW2/ZqjUzyqgN7VG72afHEi4hPBr1B2U9NWuikBu+4bNnCAkuuW8YTmqeCBXB+DfACttFXY48ZGbyUIWyPTfgQbiS86S1GhqbOPltOiWetjpvJNfh0Llf3ZxLy2mTIgo0P7hhCgQvt5Dr68IVVYpi5oGj517QBUTrht+QZY3BWGKzd6g00BNaXTsSNNW9vvyvy01dtBbbf/HPH7L+AmjqQHk+PPbXd8i+wmKfhSxEwWfp18sZCnM0+a1EqMZ6054u84jDD2rb19+irkGkWjUhEZDK8IijhovnWjFfi/IsBYes56nnrGaTh2SVmtPbNQUfmkXeOQk5jzLpMJxjY+YVAJjIJMy1hRo3t8crAx1BbT1la0XwIYt/3SLFqzzsfPBMS/DB3yHSIE0fAGr5TWj+QkMosX6U3KdeniZZ5BV2wTc3cnuE1YTg8lUUtc6AGTEdmolzS6W9hzfvBnhqCD7x4aS5+udJuERWaaMlJkzv/Dj9DY+3kmMuklB3BjMFT36x/mfrMPzDHPy8z8F8OeKJs9VykQFBI/lkSpHOg=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	XN9mVv5b4YqlcMPCrdzfawO/Fc5abXb4sDPliuMr405okmFN7/VsX+Wd6S+BE+sCqiuh6YpKflZXpxKCIiPJ2f4p8lSv9TfQRu0XJS9XaOejYaLaYmDA3ZPq4swBHMr0asp0hTrAFAaY7HWtWuKdmJQVr3am616vGsgIKrqUE0Pzs4sdXXku8siISRxGbzWk3GAKylYgHiSTOYOeOup7tuuj4bBoED8jBFgJ3izcR5/xex4VvJTd7tlA6Sje/u6NdaAxcIksNCIec4qrgjrNFucsTpROpsC3keRULflPZA/0mqmQkCLwfc5XvqP5dWwiHquIs37UuRXHo8iw482KloWI0vbkKEPrnyPFMDEGR4VvEeY5FdOKHy0MOzhapfNjyMQEk4trI1t6g8C0jKpNJSV8429vLgQruXxTFHDGV43yBbEaV6nG+T7UhFI4erPC
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 06:36:23.6112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97777bdb-fc19-47c3-7bdb-08dea9a775f3
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11090
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 06:36:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3899

From: Daniel Turull <daniel.turull@ericsson.com>

Add --stable flag to restrict upgrades to the next patch version within
the current stable branch (e.g. 1.2.3 -> 1.2.4). When the latest
upstream version is a major/minor bump, AUH queries all available
versions and picks the best patch-level update.

Per-recipe policy can be overridden via AUH_UPGRADE_POLICY (read from
tinfoil), supporting 'patch' (default), 'minor', and 'none' values.

Quick-path optimization: recipes where next_ver is already a patch
update are accepted without opening tinfoil. Tinfoil is only opened
for recipes that need policy lookup or version scanning.

Assisted-by: kiro:claude-opus-4.6
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/utils/version.py | 185 +++++++++++++++++++++++++++++++++++++++
 upgrade-helper.py        | 104 ++++++++++++++++++++++
 2 files changed, 289 insertions(+)
 create mode 100644 modules/utils/version.py

diff --git a/modules/utils/version.py b/modules/utils/version.py
new file mode 100644
index 0000000..4417bd5
--- /dev/null
+++ b/modules/utils/version.py
@@ -0,0 +1,185 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Version utilities for --stable patch-only upgrades.
+#
+# get_all_upstream_versions() collects *all* available upstream versions s=
o
+# that we can pick the highest patch-level release within the current stab=
le
+# branch.  The existing bitbake/oe-core APIs (latest_versionstring,
+# get_recipe_upstream_version) only return the single highest version, so =
we
+# must re-implement the inner loops here.
+#
+# The HTTP path mirrors bb.fetch2.wget.Wget._check_latest_version() and th=
e
+# git path mirrors bb.fetch2.git.Git.latest_versionstring(), both from
+# bitbake scarthgap.  We cannot modify oe-core on a stable release, hence
+# the duplication.
+#
+# Requires: beautifulsoup4 (python3-beautifulsoup4 in oe-core)
+
+import functools
+import re
+from logging import warning as W
+
+import bb.utils
+import bb.fetch2
+from bs4 import BeautifulSoup, SoupStrainer
+
+
+def _split_version(ver):
+    # Split on '.', '-', '_' and letter-digit boundaries (e.g. 10.0p2 -> [=
10, 0, p, 2])
+    parts =3D re.split(r'[\.\-_]', ver)
+    result =3D []
+    for p in parts:
+        result.extend(re.split(r'(?<=3D[a-zA-Z])(?=3D\d)|(?<=3D\d)(?=3D[a-=
zA-Z])', p))
+    return result
+
+
+def is_patch_update(current_ver, candidate_ver):
+    """Check if candidate is a patch-level update.
+
+    A patch update changes only the last version component while keeping
+    all preceding components identical. Also accepts sub-patch extensions
+    (e.g. 1.2.3 -> 1.2.3.1).
+    """
+    cur =3D _split_version(current_ver)
+    cand =3D _split_version(candidate_ver)
+    if len(cur) < 2 or len(cand) < 2:
+        return False
+    if bb.utils.vercmp_string(candidate_ver, current_ver) <=3D 0:
+        return False
+    # All but the last component of the current version must match
+    # the corresponding prefix of the candidate
+    if len(cand) < len(cur):
+        return False
+    return cur[:-1] =3D=3D cand[:len(cur) - 1]
+
+
+def is_minor_update(current_ver, candidate_ver):
+    """Check if candidate is a newer release within the same major version=
."""
+    cur =3D _split_version(current_ver)
+    cand =3D _split_version(candidate_ver)
+    if len(cur) < 2 or len(cand) < 2:
+        return False
+    if cur[0] !=3D cand[0]:
+        return False
+    return bb.utils.vercmp_string(candidate_ver, current_ver) > 0
+
+
+def _find_best_version(current_ver, all_versions, filter_fn):
+    candidates =3D [v for v in all_versions if filter_fn(current_ver, v)]
+    if not candidates:
+        return None
+    candidates.sort(
+        key=3Dfunctools.cmp_to_key(bb.utils.vercmp_string), reverse=3DTrue
+    )
+    return candidates[0]
+
+
+def find_patch_version(current_ver, all_versions):
+    return _find_best_version(current_ver, all_versions, is_patch_update)
+
+
+def find_minor_version(current_ver, all_versions):
+    return _find_best_version(current_ver, all_versions, is_minor_update)
+
+
+def get_all_upstream_versions(rd):
+    """Get all upstream versions using the fetcher infrastructure.
+
+    Unlike ud.method.latest_versionstring() which returns only the highest
+    version, this collects every version so the caller can filter for
+    patch-only updates.
+    """
+    src_uris =3D rd.getVar('SRC_URI')
+    if not src_uris:
+        return []
+
+    src_uri =3D src_uris.split()[0]
+    fetch =3D bb.fetch2.Fetch([src_uri], rd)
+    ud =3D fetch.ud[fetch.urls[0]]
+
+    if ud.type =3D=3D 'git':
+        return _get_git_versions(ud, rd)
+    return _get_http_versions(ud, rd)
+
+
+def _get_http_versions(ud, rd):
+    """Collect all upstream versions from an HTTP index page.
+
+    Adapted from bb.fetch2.wget.Wget._check_latest_version() and
+    ._init_regexes().  The upstream code only keeps the highest version;
+    we collect them all.  Uses BeautifulSoup to parse <a> tags, matching
+    the upstream behaviour.
+    """
+    try:
+        package =3D ud.path.split("/")[-1]
+
+        regex_uri =3D rd.getVar('UPSTREAM_CHECK_URI')
+        if not regex_uri:
+            path =3D ud.path.split(package)[0]
+            regex_uri =3D bb.fetch2.encodeurl([ud.type, ud.host, path,
+                                            ud.user, ud.pswd, {}])
+
+        page =3D ud.method._fetch_index(regex_uri, ud, rd)
+        if not page:
+            return []
+
+        regex =3D rd.getVar('UPSTREAM_CHECK_REGEX')
+        if regex:
+            regex =3D re.compile(regex)
+        else:
+            regex =3D ud.method._init_regexes(package, ud, rd)
+        if not regex:
+            return []
+
+        # Parse HTML links, same as Wget._check_latest_version()
+        soup =3D BeautifulSoup(page, "html.parser",
+                             parse_only=3DSoupStrainer("a"))
+        if not soup:
+            return []
+
+        versions =3D set()
+        for link in soup.find_all('a', href=3DTrue):
+            for text in (link['href'], str(link)):
+                m =3D regex.search(text)
+                if m and 'pver' in m.groupdict() and m.group('pver'):
+                    versions.add(re.sub('_', '.', m.group('pver')))
+                    break
+        return list(versions)
+    except Exception as e:
+        W(" Failed to get HTTP versions: %s" % e)
+        return []
+
+
+def _get_git_versions(ud, rd):
+    """Collect all tagged versions from a git remote.
+
+    Adapted from bb.fetch2.git.Git.latest_versionstring().  The upstream
+    code only keeps the highest version; we collect them all.
+    """
+    try:
+        output =3D ud.method._lsremote(ud, rd, "refs/tags/*")
+    except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess, OSError) as e:
+        W(" Failed to list remote tags: %s" % e)
+        return []
+
+    rev_tag_re =3D re.compile(r"([0-9a-f]{40})\s+refs/tags/(.*)")
+    pver_re =3D re.compile(
+        rd.getVar('UPSTREAM_CHECK_GITTAGREGEX')
+        or r"(?P<pver>([0-9][\.|_]?)+)"
+    )
+    nonrel_re =3D re.compile(r"(alpha|beta|rc|final)+")
+
+    versions =3D set()
+    for line in output.split("\n"):
+        if not line:
+            continue
+        m =3D rev_tag_re.match(line)
+        if not m:
+            continue
+        tag =3D m.group(2)
+        if nonrel_re.search(tag):
+            continue
+        m =3D pver_re.search(tag)
+        if m:
+            versions.add(m.group('pver').replace("_", "."))
+    return list(versions)
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 9954a66..aecb207 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -59,6 +59,9 @@ from utils.emailhandler import Email
 from statistics import Statistics
 from steps import upgrade_steps
 from testimage import TestImage
+from utils.version import (is_patch_update, find_patch_version,
+                           is_minor_update, find_minor_version,
+                           get_all_upstream_versions)
=20
 if not os.getenv('BUILDDIR', False):
     E(" You must source oe-init-build-env before running this script!\n")
@@ -74,6 +77,7 @@ scriptpath.add_bitbake_lib_path()
 scriptpath.add_oe_lib_path()
=20
 import oe.recipeutils
+import bb.tinfoil
=20
 help_text =3D """Usage examples:
 * To upgrade xmodmap recipe to the latest available version:
@@ -96,6 +100,9 @@ def parse_cmdline():
     parser.add_argument("-t", "--to_version",
                         help=3D"version to upgrade the recipe to")
=20
+    parser.add_argument("--stable", action=3D"store_true", default=3DFalse=
,
+                        help=3D"only upgrade to the next patch version wit=
hin the stable branch (e.g. 1.2.3 -> 1.2.4)")
+
     parser.add_argument("-d", "--debug-level", type=3Dint, default=3D4, ch=
oices=3Drange(1, 6),
                         help=3D"set the debug level: CRITICAL=3D1, ERROR=
=3D2, WARNING=3D3, INFO=3D4, DEBUG=3D5")
     parser.add_argument("-e", "--send-emails", action=3D"store_true", defa=
ult=3DFalse,
@@ -679,6 +686,67 @@ class UniverseUpdater(Updater):
=20
     def _get_packagegroups_to_upgrade(self, packages=3DNone):
=20
+        def _resolve_stable_version(pn, cur_ver, next_ver, tinfoil):
+            """Find the best version within the policy allowed by AUH_UPGR=
ADE_POLICY.
+
+            Only called when --stable is active. --stable enables version
+            filtering globally; AUH_UPGRADE_POLICY overrides the policy
+            per-recipe within that filtering.
+
+            AUH_UPGRADE_POLICY can be set per-recipe in local.conf or in t=
he
+            recipe itself:
+              "patch" (default) - only patch-level updates (e.g. 1.2.3 -> =
1.2.4)
+              "minor"           - same-major updates (e.g. 1.2.3 -> 1.3.0)
+              "none"            - skip this recipe entirely
+            """
+            # Quick path: if next_ver is already a patch update, accept it
+            # without parsing the recipe (covers the common case).
+            if is_patch_update(cur_ver, next_ver):
+                return next_ver, None
+
+            try:
+                rd =3D tinfoil.parse_recipe(pn)
+            except Exception:
+                rd =3D None
+            if not rd:
+                I(" %s: could not parse recipe, skipping" % pn)
+                return None, None
+
+            policy =3D (rd.getVar('AUH_UPGRADE_POLICY') or 'patch').strip(=
).lower()
+            if policy not in ('patch', 'minor', 'none'):
+                W(" %s: unrecognized AUH_UPGRADE_POLICY '%s',"
+                  " defaulting to 'patch'" % (pn, policy))
+                policy =3D 'patch'
+            if policy =3D=3D 'none':
+                I(" %s: AUH_UPGRADE_POLICY=3Dnone, skipping" % pn)
+                return None, None
+
+            if policy =3D=3D 'minor':
+                check_fn =3D is_minor_update
+                find_fn =3D find_minor_version
+            else:
+                check_fn =3D is_patch_update
+                find_fn =3D find_patch_version
+
+            if check_fn(cur_ver, next_ver):
+                return next_ver, None
+
+            I(" %s: latest version %s is not a %s update from %s,"
+              " searching for versions..." %
+              (pn, next_ver, policy, cur_ver))
+            try:
+                all_versions =3D get_all_upstream_versions(rd)
+                ver =3D find_fn(cur_ver, all_versions)
+                if ver:
+                    I(" %s: found version %s" % (pn, ver))
+                    return ver, "N/A"
+                else:
+                    I(" %s: no suitable version available, skipping" % pn)
+                    return None, None
+            except Exception as e:
+                I(" %s: failed to search for versions: %s" % (pn, e))
+                return None, None
+
         # Prepare a single pkg dict data (or None is not upgradable) from =
recipeutils.get_recipe_upgrade_status data.
         def _get_pkg_to_upgrade(self, layer_name, pn, status, cur_ver, nex=
t_ver, maintainer, revision, no_upgrade_reason):
             pkg_to_upgrade =3D None
@@ -736,6 +804,42 @@ class UniverseUpdater(Updater):
                         upgrade_group.append(pkg_to_upgrade)
                 if upgrade_group:
                     upgrade_pkggroups.append(upgrade_group)
+
+        if self.args.stable and upgrade_pkggroups:
+            # Quick-path: accept packages where next_ver is already a patc=
h
+            # update without opening tinfoil.  For the rest, tinfoil must
+            # remain open because bb.fetch2.Fetch needs a live rd object.
+            needs_tinfoil =3D []
+            for group in upgrade_pkggroups:
+                quick_group =3D []
+                slow_pkgs =3D []
+                for pkg in group:
+                    if is_patch_update(pkg['cur_ver'], pkg['next_ver']):
+                        quick_group.append(pkg)
+                    else:
+                        slow_pkgs.append(pkg)
+                if quick_group or slow_pkgs:
+                    needs_tinfoil.append((quick_group, slow_pkgs))
+
+            if any(slow for _, slow in needs_tinfoil):
+                stable_tinfoil =3D bb.tinfoil.Tinfoil()
+                stable_tinfoil.prepare(config_only=3DFalse)
+                try:
+                    for quick_group, slow_pkgs in needs_tinfoil:
+                        for pkg in slow_pkgs:
+                            ver, rev =3D _resolve_stable_version(
+                                pkg['pn'], pkg['cur_ver'],
+                                pkg['next_ver'], stable_tinfoil)
+                            if ver is not None:
+                                pkg['next_ver'] =3D ver
+                                if rev is not None:
+                                    pkg['revision'] =3D rev
+                                quick_group.append(pkg)
+                finally:
+                    stable_tinfoil.shutdown()
+
+            upgrade_pkggroups =3D [g for g, _ in needs_tinfoil if g]
+
         return upgrade_pkggroups
=20
     def pkg_upgrade_handler(self, pkg_ctx):
--=20
2.34.1


