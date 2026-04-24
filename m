Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0871FE5214
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:24 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19334.1777031177712176426
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=nobyEmAV;
 spf=pass (domain: ericsson.com, ip: 52.101.83.68, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lyz6cdcHcteD1bL8HCvXFgiqZJpNUxhA2FGywePHUWwSILAW9g26hm/C1enIEAyfLw2foTFiNuATgM6Kh858e276syRMUvBneBXEKHr/ja0/K0hP1tA6AGdkOJ3IebgxvgjnLWMbjQik32c5SX28vK8mdMToydb7moiRqv7H+dVDWdM/emzhzCgNWTAuE+Zi1u05mreGe/x0c+cV1+jMXMTgAQ4mFcxUCgLcG2MFsKSIScBa+UWij74iJH5hWlk8mVeFj/AMduzhpY3QBqCkp99nVRjWstpLff8FbOhEO7XNx8cHWp0NsJZAJ+f6VUypW2SiiHcbQvJNXOaRxXhcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOelNwgqd2IQGlaTJJ62kmFACCk5CW5XwaCagwSPHiY=;
 b=LC0NJUIT8qzNrE1PHg+SFiWvPBjxdZQHkKihyYbiZvVOzWVxHDmjv8kv5BCcMZsUvIByALJflOVp58YznaBk0H1tdBVXWbAJNessRwTKv0Tm+TRBee9FXaYM5QiKTLbtste632nScSGKu/ckpM/SMCSkiwzEfk2BYFnlWnPN3bS8dpZEe1a58p5+/450GrkRMx96s3OZs7Zqs6zwiK3TlVBnijTLHYf9vAyFlnnoPxuQTowgVfBoU25zEuiBloQQpNYDZYv7JSTJE0xx2sSNAg2j9JTpiAJfHTOxw6Fj2TcA3X+I+kMlTkiqMZG3iFrj+mhmUeyXZmHjygZNJIV5Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOelNwgqd2IQGlaTJJ62kmFACCk5CW5XwaCagwSPHiY=;
 b=nobyEmAVZ0HHbIrlnYby7Neq4qNA5ZfUk3B5a5jzcMS7z1vbHAtxwq+b8m0BGhZeCEjKJ27GZKOixq/SqvA8UYhv4UsNi2IEOVopTYqfi50ivbHYcjunb+eSP0OrXgyT9KKteXa6ZndKkFDE+V5Kgcb5//ashFIykO86M9YiX3KF48Epd+qyWW8galjHShYan5/ZHn4T9y9XIQ/QBxr3JZWETVRVIaMVJPlniAeaQDmMQbUTu+0P/fGhH9Oi9UX/fg11nR9Y6b6m0suXGi1HF7TKhp4GFzOVkGnmks1Ydy6RURO+hBz3gWYBMAX7d+EQua2/4QEcJLZm6sPPAwrHtQ==
Received: from CWLP265CA0440.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b7::21)
 by DBBPR07MB7612.eurprd07.prod.outlook.com (2603:10a6:10:1e3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 11:46:11 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:400:1b7:cafe::96) by CWLP265CA0440.outlook.office365.com
 (2603:10a6:400:1b7::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 11:46:11 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 3BC544020410;
	Fri, 24 Apr 2026 13:46:10 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id E5CE5700DBAF; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 5/9] upgrade-helper.py: Add stable option for patch-only upgrades
Date: Fri, 24 Apr 2026 13:45:59 +0200
Message-ID: <20260424114603.2444938-6-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|DBBPR07MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8a4609-5b5c-448b-9283-08dea1f7152b
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	THjcDqXGEKdZUIMeDliFzX8nRdyMPKfl4Du1CjcaLbtR8GGy4a8Xbjc8sWO4xnoDNtWybP1crgEJXP9VfmAxLTH9hgVQk5plv5mM2K7vew118/h3uJPxE4ZTfGnIjJyD/uHC3T3/yeaTyk2ZMukGXSJnpnwuLgKVp7X1kiqzYFIvCMep6Er5cN7vHaR78+ohQpEpO1md2gVywRcfQQzKGCIed+oXoEQIFpelttvy9qVAPOPoWX2I9A5hHZpZmDNDpA88eekIMyo1CWejHJTgTl89azpx1nYj10pUp3usUFi1Cnza8tHl0lpVWKZZ1ezBov8i0iXGp2Wh6W99FPeYf5u3dwabfYRDNULBAplATw5JtqBf7ZGk+qZHC5dOaV91eO7ym/do1kY823IZxwopRlUGPie/6AZC8ZbOdPSbMvLtWMebAM9c0WbVqwR7bYVA3n64IGx+a7lwtpJaiNggamJk1qBAvHcz6PaWMMNri1l+yAGPluYx+/4R1bWlbRbNUNFja33546nDpsTzILUGdExGn9h7qvRe+Y8qdLfaznIFbGL763FL9kXPxqc/r7J1jasN/3dryV2wXsMPZ7tSLs4e3yZgyGfgAsN6rAkQX1HtrbysZURhmO4u2zNdmvhKPnAB08J6JfQfOcwgdfRiYULrK9mh/8lUIn3ekFR62uqZKQMBv14yVLIfyGgINCpRtkWkxIsD1RmQxJ0Kfu8AT7sVlxuYKTRKxOPanz9+YFHiu+XfZ5sYQ9nFSDu/vLfMRjemOQwmDRavt7BzmzZjRw==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ZSXkJUTq5NObvv8wldvY3Vw3/vhhVap9GoSwvCzMMVvjMTRk7JdnZfp6gJC0sIOFica+s/YJ9b+g6CdXXuD3iDywOX/1YKrIKJsIMDlLDDpFsOvCWMtQeHmfcERlQ0yrkuuNRkQkvMAxABYIKVI4vDX8SVtnESIwxz7i7I7+e9bwyztLdqJxM4r6/uG6vZBI2WM47+8f2RzfEmMsv/Fp+zRMP3o5sDqK8g7VUlVpUx+XMtBoVuWDNGEnPlJP3A0dwEezn9J8Mp3Ju6fjqWfhPyIWSTux+uGUJMZfd/ypfx/yrS50+Ia5C04DRk+9KwxITrKEWncR6v4M0ezFfTAxcs7TGBAXeU88ZonjyeMZzGviEqRiIZRx5IhnsqC7+aAGPEzzUwE6NvaR322ZxLJlRsYmi/dI5gbtGm5MIVIhKuW1UTgSztFI6sMDK4GxSyDF
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:11.6713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8a4609-5b5c-448b-9283-08dea1f7152b
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7612
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3799

From: Daniel Turull <daniel.turull@ericsson.com>

Add --stable flag to restrict upgrades to the next patch version within
the current stable branch (e.g. 1.2.3 -> 1.2.4). When the latest
upstream version is a major/minor bump, AUH queries all available
versions and picks the best patch-level update.

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Assisted-by: Claude, Anthropic
---
 modules/utils/version.py | 160 +++++++++++++++++++++++++++++++++++++++
 upgrade-helper.py        |  51 +++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 modules/utils/version.py

diff --git a/modules/utils/version.py b/modules/utils/version.py
new file mode 100644
index 0000000..b40eb1c
--- /dev/null
+++ b/modules/utils/version.py
@@ -0,0 +1,160 @@
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
+    cur =3D _split_version(current_ver)
+    cand =3D _split_version(candidate_ver)
+    if len(cur) !=3D len(cand) or len(cur) < 3:
+        return False
+    if cur[:-1] !=3D cand[:-1]:
+        return False
+    try:
+        return int(cand[-1]) > int(cur[-1])
+    except ValueError:
+        return bb.utils.vercmp_string(candidate_ver, current_ver) > 0
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
+    ud =3D bb.fetch2.FetchData(src_uri, rd)
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
+            regex_uri =3D bb.fetch.encodeurl([ud.type, ud.host, path,
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
+        W(" Failed to get HTTP versions: %s" % str(e))
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
+        W(" Failed to list remote tags: %s" % str(e))
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
+            break
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
index 327bb6d..b7b8ddf 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -59,6 +59,7 @@ from utils.emailhandler import Email
 from statistics import Statistics
 from steps import upgrade_steps
 from testimage import TestImage
+from utils.version import is_patch_update, find_patch_version, get_all_ups=
tream_versions
=20
 if not os.getenv('BUILDDIR', False):
     E(" You must source oe-init-build-env before running this script!\n")
@@ -74,6 +75,7 @@ scriptpath.add_bitbake_lib_path()
 scriptpath.add_oe_lib_path()
=20
 import oe.recipeutils
+import bb.tinfoil
=20
 help_text =3D """Usage examples:
 * To upgrade xmodmap recipe to the latest available version:
@@ -97,6 +99,8 @@ def parse_cmdline():
                         help=3D"version to upgrade the recipe to")
     parser.add_argument("--changelog", action=3D"store_true", default=3DFa=
lse,
                         help=3D"extract changelog between old and new vers=
ions, highlighting CVEs")
+    parser.add_argument("--stable", action=3D"store_true", default=3DFalse=
,
+                        help=3D"only upgrade to the next patch version wit=
hin the stable branch (e.g. 1.2.3 -> 1.2.4)")
=20
     parser.add_argument("-d", "--debug-level", type=3Dint, default=3D4, ch=
oices=3Drange(1, 6),
                         help=3D"set the debug level: CRITICAL=3D1, ERROR=
=3D2, WARNING=3D3, INFO=3D4, DEBUG=3D5")
@@ -698,6 +702,30 @@ class UniverseUpdater(Updater):
=20
     def _get_packagegroups_to_upgrade(self, packages=3DNone):
=20
+        def _resolve_stable_version(pn, cur_ver, next_ver, tinfoil):
+            """Find the latest patch version within the current stable bra=
nch."""
+            if is_patch_update(cur_ver, next_ver):
+                return next_ver, None
+            I(" %s: latest version %s is not a patch update from %s,"
+              " searching for versions..." %
+              (pn, next_ver, cur_ver))
+            try:
+                rd =3D tinfoil.parse_recipe(pn)
+                if not rd:
+                    I(" %s: could not parse recipe, skipping" % pn)
+                    return None, None
+                all_versions =3D get_all_upstream_versions(rd)
+                ver =3D find_patch_version(cur_ver, all_versions)
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
@@ -763,6 +791,29 @@ class UniverseUpdater(Updater):
                         upgrade_group.append(pkg_to_upgrade)
                 if upgrade_group:
                     upgrade_pkggroups.append(upgrade_group)
+
+        if self.args.stable and upgrade_pkggroups:
+            stable_tinfoil =3D bb.tinfoil.Tinfoil()
+            stable_tinfoil.prepare(config_only=3DFalse)
+            try:
+                filtered =3D []
+                for group in upgrade_pkggroups:
+                    filtered_group =3D []
+                    for pkg in group:
+                        stable_ver, stable_rev =3D _resolve_stable_version=
(
+                            pkg['pn'], pkg['cur_ver'], pkg['next_ver'],
+                            stable_tinfoil)
+                        if stable_ver is not None:
+                            pkg['next_ver'] =3D stable_ver
+                            if stable_rev is not None:
+                                pkg['revision'] =3D stable_rev
+                            filtered_group.append(pkg)
+                    if filtered_group:
+                        filtered.append(filtered_group)
+                upgrade_pkggroups =3D filtered
+            finally:
+                stable_tinfoil.shutdown()
+
         return upgrade_pkggroups
=20
     def pkg_upgrade_handler(self, pkg_ctx):
--=20
2.34.1


