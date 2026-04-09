Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16904E9DE6F
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 09:08:44 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.128134.1775725719273834683
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 02:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=HEKh/dgx;
 spf=pass (domain: ericsson.com, ip: 40.107.162.34, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikSMD5raXZEWh/QueORjskmMsiKmKBzE3wSkJhgQ3XcM/iwEWGEWS7a7NuvzsF0GJ7A3b1RCw6jyxlAbxDTkxouAp594s3RPPA3Dd6TZDa5i1SXZxsAl8VP8UouSA/dyp7voFXVlGIIA5E9io/N2ywTAffxpISTvijc5pPj/jLoEs9ATJPjx37V0vZ13tefxU3g68y/n83b+69DUeczMS8600/xuslIJwmCVwY3IgDD4XjOltiA3xSdYDF5PbDIEVRZ1TegX174iolDrfU+T9E4Xm+4ABiZgZnYhqgkvKhlVQqLNDxHP7Zg4Srq6IW3Li9nmXx/wLgn6yc7EsMIypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsE/LHuMeh1a+YnTnFGhlxB/AXZeD/TvmfyHVpjAGZo=;
 b=jz0/fDN1NB4n4uSg02HlgUYaK4q0IlSy/JwWkpWVWd6JT19BHRFVPmiJkulnkMDU2riik9X8Htp+qaWYAvf0umd4TdtbnINWxsKyOfhDri0+FdEIleUe4uq6fy6FOps+IYGJa0ZLe+8bvfzzx3J0k6guBN60i9bM8q245GEnqKV8hGeHu2ghLwcyo+HMlphEvMDqQnJQceH1GN8bhBdceUsZIJlEr26PIQ9kUVvcGkZ7jQ2TEYMbwza0eTmeTr72dVlr95h+q8cM5cvFoLNzgxYnNo7qLMjrdkQwFTS5zvWNHN2frx5n57TuyP/aPQxGUjzjGuep+66wdvau28Yabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsE/LHuMeh1a+YnTnFGhlxB/AXZeD/TvmfyHVpjAGZo=;
 b=HEKh/dgxP7SD9EfK+nc40pwyIlt0ethU+ouyrd7aCR9+Dl6/Gq0l+0ICL011ntyc1+DdwRjnRhH1ODo441oqQn70AZDT1aVZTUF3jJQ97YVBt6Tg8tmz2uh8rAuF9L2cAtVWBXBtjxWELJURWc+iymuuWaorqhN2juE9wkNfMDpGRVJEuTyZ1DfkZL3GuP3YMyF3bxcy0yMPT5Y+s9SyjPnob+mQg6MCw505X5jeJA8qP2+5JN9e6oPGnz99c4erVaqfmFP8QXLD/OgEMMhfVV37YrvXD9+MZHppqEjUbHkcYYqRgmubV/z6CVmEMGQvHFLJ95YDgN2JJcaXWcANHw==
Received: from AS4P192CA0020.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::6)
 by AMBPR07MB11807.eurprd07.prod.outlook.com (2603:10a6:20b:72e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 09:08:30 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::6e) by AS4P192CA0020.outlook.office365.com
 (2603:10a6:20b:5e1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 09:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:08:30 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 11:08:28 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 2A6464020A9F;
	Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 14ECE700DB94; Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>
Subject: [AUH] PATCH 3/6] upgrade-helper.py: add changelog flag
Date: Thu, 9 Apr 2026 11:08:12 +0200
Message-ID: <20260409090815.1731294-4-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409090815.1731294-1-daniel.turull@ericsson.com>
References: <20260409090815.1731294-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|AMBPR07MB11807:EE_
X-MS-Office365-Filtering-Correlation-Id: db7691ff-fde3-4985-84ea-08de961791df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	kXqBxcQSnIbhUjqUJZwbJx884v+WXHb0jZXbq1MI9TVRChP9x9rm4oIxEMcZFqg9eY7guneM+i+R7AqHtZbDbGvTTOJ8nADsk9LkHYWU0PwNoNqHDiNbTrC8Ffuecq9QTQKEMbb2c01YwiBII/5DwOC4XT0OYQKhbvDnG7ZuRtI/4GdUubOn6iIaN/cAF6Sil8urAmV/6hE0e8Q8gypS+mJSCeRQNVqrVuW72dB8ZXRf/ooNqFFznAtopJ5P4JojOHALWQkNZDYXtHhH061+gqGSWVjWyqE4abLwJ6n/0yAJv8wfDOJmuVehlp49x0xET06Aivmu8RwsVgKRjkH0ObgpXOOlGIoVateVwO1kcRu2F11TiiTjCy71xRtMgmLAcjrwfZNHLHOrwXGsPlu1AVq4kgwryRssAxR8wV/KnbmlMCasNr9wa8T+wwma2Y6ikZkTGnzRlZLNIkDGrVoZ1eYeGuT3enR1SRKdQIf/FMAP/b66Bcs4CFvrAlpkyAM7tCiH6La+LgGbx9ZUOOoRnQxxYBhxJWVJi01e3ZMWpygV5q0LRjkaoQ+qOqyrpTKvgIPXMoyBbWk5C1dILa+mMyL/JDrVwJMg/FjjRDXJkOG9QQ1N8FInS3z7R0cmgYwcO7HGLau9UnJxzYVrW9Ze84Zyu5JyzL+rWio8tlY37YQWvNrScETcqKLdcGRh1MLFo0MOcFC3KoqcNQRn7Dn9oYo/6V/c2EBM47uB+RdE697XKYiOZZC0OsyNCK9MUp5K2CJCr1eNX0+71ve2jeupxA==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	YJGVyZrNxPLapXB3fkgYG4Wa+xFT+4cM9HEX7Lu4UnZ2UZ+we3KIeCt+ybgrX7PlOtXnzEj9DYFO82iiCs7VrcC/pqtbILHrtt/wPqJRkgQ3EMaJfd/sEmQxof6qnC1UdZoE+gnteki2B6C/cZTdhGEAlQ+Tbq1EbgOXk0obxNrVy3Xsm9oy7IStMAGFTZM48CWR9KXa/K3CXdHw0CQNlfN/Q1UTgPxUSnvsLptFTHwI9NC3q9BXehKVu/z4yi3PK68z46hHUG8JKLChToKvBGYnXSEve3+4z3U4wDrTj1Vu/Yf9kL8gqUNyMCOM9b4HBkfT0/k5Irh2b3bvh2FixxrGNO4hekJyTe1wc1pth3hWVRxNhQ7KOXG6nYFdHi/anJQBqBQ+lMM89zs9e8drwPpVEu7OQEx8jcSVoEJZROKCRUwnxuEVgAS+EyUPvk2p
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:08:30.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7691ff-fde3-4985-84ea-08de961791df
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11807
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 09:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3673

From: Daniel Turull <daniel.turull@ericsson.com>

It extracts changelog entries between the old and new versions from the
 upstream source tree, highlighting any CVEs.

New module changelog.py provides extract_changelog() with three strategies:
1. Parse standard changelog files (ChangeLog, NEWS, etc.), resolving
   RST .. include:: directives and stripping license/copyright blocks
2. Find per-version files (e.g. doc/changelog/changelog-9.18.46.rst)
   for projects like bind that use RST includes
3. Git log between version tags

The changelog text is appended to the git commit message and included
in upgrade notification emails. Extraction runs after devtool_upgrade
using the workspace source tree.

Disabled by default, use with --changelog

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/changelog.py     | 256 +++++++++++++++++++++++++++++++++++++++
 modules/steps.py         |  20 +++
 modules/utils/version.py | 160 ++++++++++++++++++++++++
 upgrade-helper.py        |  67 ++++++++++
 4 files changed, 503 insertions(+)
 create mode 100644 modules/changelog.py
 create mode 100644 modules/utils/version.py

diff --git a/modules/changelog.py b/modules/changelog.py
new file mode 100644
index 0000000..c1cc14b
--- /dev/null
+++ b/modules/changelog.py
@@ -0,0 +1,256 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import re
+import glob
+import functools
+import subprocess
+
+from logging import info as I
+from logging import debug as D
+
+import bb.utils
+
+CHANGELOG_FILENAMES =3D [
+    'ChangeLog', 'CHANGELOG', 'CHANGELOG.md', 'CHANGELOG.txt',
+    'Changes', 'CHANGES', 'NEWS', 'NEWS.md', 'NEWS.txt',
+    'RELEASE_NOTES', 'RELEASE_NOTES.md', 'RELEASE-NOTES',
+    'HISTORY', 'HISTORY.md',
+    'debian/changelog',
+]
+
+CVE_PATTERN =3D re.compile(r'(CVE-\d{4}-\d{4,})', re.IGNORECASE)
+
+
+def _find_changelog_files(srcdir):
+    found =3D []
+    for name in CHANGELOG_FILENAMES:
+        for f in glob.glob(os.path.join(srcdir, '**', name), recursive=3DT=
rue):
+            if os.path.isfile(f) and f not in found:
+                found.append(f)
+    return found
+
+
+RST_INCLUDE_RE =3D re.compile(r'^\.\.\s+include::\s+(.+)$')
+RST_COMMENT_RE =3D re.compile(r'^\.\.\s*$|^\.\.\s')
+
+
+def _strip_rst_comments(text):
+    """Remove RST comment blocks (license headers etc.)."""
+    lines =3D text.split('\n')
+    result =3D []
+    in_comment =3D False
+    for line in lines:
+        if RST_COMMENT_RE.match(line):
+            in_comment =3D True
+            continue
+        if in_comment:
+            if line.startswith('   ') or line.strip() =3D=3D '':
+                continue
+            in_comment =3D False
+        result.append(line)
+    return '\n'.join(result)
+
+
+def _resolve_rst_includes(content, base_dir, srcdir):
+    """Inline RST .. include:: directives."""
+    lines =3D content.split('\n')
+    result =3D []
+    for line in lines:
+        m =3D RST_INCLUDE_RE.match(line.strip())
+        if m:
+            inc_rel =3D m.group(1).strip()
+            inc_path =3D os.path.normpath(os.path.join(base_dir, inc_rel))
+            if not os.path.isfile(inc_path):
+                # Search for the filename within the source tree
+                fname =3D os.path.basename(inc_rel)
+                for f in glob.glob(os.path.join(srcdir, '**', fname),
+                                   recursive=3DTrue):
+                    if os.path.isfile(f):
+                        inc_path =3D f
+                        break
+            if os.path.isfile(inc_path):
+                try:
+                    with open(inc_path, 'r', encoding=3D'utf-8',
+                              errors=3D'replace') as f:
+                        result.append(f.read())
+                    continue
+                except OSError:
+                    pass
+        result.append(line)
+    return '\n'.join(result)
+
+
+GIT_LOG_RE =3D re.compile(r'^commit [0-9a-f]{7,}', re.MULTILINE)
+
+
+def _condense_git_log(text):
+    """Condense git-log-style content to subject lines only."""
+    if not GIT_LOG_RE.search(text):
+        return text
+    lines =3D text.split('\n')
+    subjects =3D []
+    i =3D 0
+    while i < len(lines):
+        if GIT_LOG_RE.match(lines[i]):
+            short =3D lines[i].split()[1][:12]
+            # Skip Author/Date, blank line, then grab subject
+            i +=3D 1
+            while i < len(lines) and (lines[i].startswith('Author:') or
+                    lines[i].startswith('Date:') or not lines[i].strip()):
+                i +=3D 1
+            if i < len(lines):
+                subjects.append('%s %s' % (short, lines[i].strip()))
+            continue
+        i +=3D 1
+    return '\n'.join(subjects) if subjects else text
+
+
+def _extract_entries_between_versions(content, old_ver, new_ver):
+    lines =3D content.split('\n')
+    new_pattern =3D re.compile(re.escape(new_ver))
+    old_pattern =3D re.compile(re.escape(old_ver))
+
+    start_idx =3D None
+    end_idx =3D None
+
+    for i, line in enumerate(lines):
+        if start_idx is None and new_pattern.search(line):
+            start_idx =3D i
+        elif start_idx is not None and old_pattern.search(line):
+            end_idx =3D i
+            break
+
+    if start_idx is not None:
+        return '\n'.join(lines[start_idx:end_idx])
+    return None
+
+
+def _find_per_version_files(srcdir, old_ver, new_ver):
+    """Find individual per-version changelog files (e.g. changelog-1.2.3.r=
st)."""
+    ver_file_re =3D re.compile(
+        r'(?:changelog|changes|news|release|relnotes)[-_./\\]?'
+        r'v?(?P<pver>(\d+[\.\-_])*\d+)\.\w+$',
+        re.IGNORECASE)
+
+    candidates =3D {}
+    for f in glob.glob(os.path.join(srcdir, '**', '*'), recursive=3DTrue):
+        if not os.path.isfile(f):
+            continue
+        # Match against last two path components (e.g. RelNotes/v1.47.4.tx=
t)
+        tail =3D os.sep.join(f.rsplit(os.sep, 2)[-2:])
+        m =3D ver_file_re.search(tail)
+        if m:
+            ver =3D m.group('pver').replace('_', '.').replace('-', '.')
+            candidates[ver] =3D f
+
+    # Select versions > old_ver and <=3D new_ver
+    selected =3D []
+    for ver, path in candidates.items():
+        if bb.utils.vercmp_string(ver, old_ver) > 0 and \
+           bb.utils.vercmp_string(ver, new_ver) <=3D 0:
+            selected.append((ver, path))
+
+    selected.sort(key=3Dlambda x: functools.cmp_to_key(
+        bb.utils.vercmp_string)(x[0]))
+    return [path for _, path in selected]
+
+
+def extract_changelog(srcdir, pn, old_ver, new_ver, workdir):
+    if not srcdir or not os.path.isdir(srcdir):
+        D(" %s: source directory %s not available" % (pn, srcdir))
+        return None
+
+    entries =3D []
+    cves =3D []
+
+    # Strategy 1: extract sections between version markers in changelog fi=
les
+    changelog_files =3D _find_changelog_files(srcdir)
+    for fpath in changelog_files:
+        try:
+            with open(fpath, 'r', encoding=3D'utf-8', errors=3D'replace') =
as f:
+                content =3D f.read()
+        except OSError:
+            continue
+        content =3D _resolve_rst_includes(content, os.path.dirname(fpath),=
 srcdir)
+        section =3D _extract_entries_between_versions(content, old_ver, ne=
w_ver)
+        if section:
+            section =3D _condense_git_log(section)
+            entries.append(section)
+            cves.extend(CVE_PATTERN.findall(section))
+            break
+
+    # Strategy 2: concatenate per-version files (e.g. changelog-9.18.42.rs=
t)
+    if not entries:
+        ver_files =3D _find_per_version_files(srcdir, old_ver, new_ver)
+        for fpath in ver_files:
+            try:
+                with open(fpath, 'r', encoding=3D'utf-8', errors=3D'replac=
e') as f:
+                    content =3D f.read()
+            except OSError:
+                continue
+            entries.append(content)
+            cves.extend(CVE_PATTERN.findall(content))
+
+    # Strategy 3: git log between version tags
+    if not entries and os.path.isdir(os.path.join(srcdir, '.git')):
+        tag_prefixes =3D ['v', '', pn + '-']
+        old_tag =3D new_tag =3D None
+        for prefix in tag_prefixes:
+            try:
+                subprocess.check_output(
+                    ['git', 'rev-parse', prefix + old_ver],
+                    cwd=3Dsrcdir, stderr=3Dsubprocess.DEVNULL)
+                subprocess.check_output(
+                    ['git', 'rev-parse', prefix + new_ver],
+                    cwd=3Dsrcdir, stderr=3Dsubprocess.DEVNULL)
+                old_tag, new_tag =3D prefix + old_ver, prefix + new_ver
+                break
+            except (subprocess.CalledProcessError, OSError):
+                continue
+        if old_tag and new_tag:
+            try:
+                out =3D subprocess.check_output(
+                    ['git', 'log', '--oneline', '%s..%s' % (old_tag, new_t=
ag)],
+                    cwd=3Dsrcdir, stderr=3Dsubprocess.DEVNULL).decode('utf=
-8', errors=3D'replace')
+                if out.strip():
+                    entries.append(out.strip())
+                    cves.extend(CVE_PATTERN.findall(out))
+            except (subprocess.CalledProcessError, OSError):
+                pass
+
+    if not entries:
+        D(" %s: no changelog entries found" % pn)
+        return None
+
+    I(" %s: found %d changelog entries" % (pn, len(entries)))
+
+    cves =3D sorted(set(cves))
+    text =3D "Changelog for %s: %s -> %s\n" % (pn, old_ver, new_ver)
+    text +=3D "=3D" * 60 + "\n\n"
+    if cves:
+        text +=3D "SECURITY FIXES / CVEs FOUND:\n"
+        for cve in cves:
+            text +=3D "  - %s\n" % cve
+        text +=3D "\n" + "-" * 60 + "\n\n"
+    text +=3D CVE_PATTERN.sub(r'*** \1 ***', _strip_rst_comments('\n\n'.jo=
in(entries)))
+
+    # Collapse multiple blank lines into one
+    text =3D re.sub(r'\n{3,}', '\n\n', text)
+
+    changelog_path =3D os.path.join(workdir, "changelog-%s.txt" % pn)
+    with open(changelog_path, 'w', encoding=3D'utf-8') as f:
+        f.write(text)
+
+    I(" %s: changelog saved to %s" % (pn, os.path.basename(changelog_path)=
))
+    if cves:
+        I(" %s: CVEs found: %s" % (pn, ', '.join(cves)))
+
+    commit_text =3D text
+    if len(commit_text) > 3000:
+        commit_text =3D commit_text[:3000] + "\n\n[... changelog truncated=
 ...]\n"
+    # Sanitize for shell-safe git commit -m "..."
+    for ch in '"', '`', '$', '\\':
+        commit_text =3D commit_text.replace(ch, '')
+
+    return {'text': text, 'commit_text': commit_text, 'cves': cves, 'file'=
: changelog_path}
diff --git a/modules/steps.py b/modules/steps.py
index b3ec61c..78fcbbe 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -29,6 +29,7 @@ from logging import warning as W
=20
 from errors import Error, DevtoolError, CompilationError
 from buildhistory import BuildHistory
+from changelog import extract_changelog
=20
 def load_env(devtool, bb, git, opts, group):
     group['workdir'] =3D os.path.join(group['base_dir'], group['name'])
@@ -150,10 +151,29 @@ def devtool_finish(devtool, bb, git, opts, group):
             pass
         raise e1
=20
+def changelog_extract(devtool, bb, git, opts, group):
+    if not opts.get('changelog'):
+        return
+    for p in group['pkgs']:
+        # After devtool_upgrade, source is in workspace/sources/<pn>/
+        srcdir =3D os.path.join(os.environ.get('BUILDDIR', ''),
+                              'workspace', 'sources', p['PN'])
+        if not os.path.isdir(srcdir):
+            # Fallback: derive from env S, replacing old version
+            srcdir =3D p['env'].get('S', '')
+            if p['PV'] in srcdir:
+                srcdir =3D srcdir.replace(p['PV'], p['NPV'])
+        result =3D extract_changelog(srcdir, p['PN'], p['PV'],
+                                   p['NPV'], group['workdir'])
+        if result:
+            p['changelog'] =3D result
+            group['commit_msg'] +=3D "\n\n" + result['commit_text']
+
 upgrade_steps =3D [
     (load_env, "Loading environment ..."),
     (buildhistory_init, None),
     (devtool_upgrade, "Running 'devtool upgrade' ..."),
+    (changelog_extract, "Extracting changelog ..."),
     (devtool_finish, "Running 'devtool finish' ..."),
     (compile, None),
 ]
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
index 67ca54b..d023559 100755
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
@@ -95,6 +97,10 @@ def parse_cmdline():
=20
     parser.add_argument("-t", "--to_version",
                         help=3D"version to upgrade the recipe to")
+    parser.add_argument("--changelog", action=3D"store_true", default=3DFa=
lse,
+                        help=3D"extract changelog between old and new vers=
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
@@ -198,6 +204,7 @@ class Updater(object):
         self.opts['skip_compilation'] =3D self.args.skip_compilation
         self.opts['buildhistory'] =3D self._buildhistory_is_enabled()
         self.opts['testimage'] =3D self._testimage_is_enabled()
+        self.opts['changelog'] =3D self.args.changelog
=20
     def _make_dirs(self, build_dir):
         self.uh_dir =3D os.path.join(build_dir, "upgrade-helper")
@@ -358,6 +365,19 @@ class Updater(object):
         if 'patch_file' in g and g['patch_file'] is not None:
             msg_body +=3D next_steps_info % (os.path.basename(g['patch_fil=
e']))
=20
+        # Add changelog summary if available
+        for pkg_ctx in g['pkgs']:
+            if 'changelog' in pkg_ctx:
+                cl =3D pkg_ctx['changelog']
+                msg_body +=3D ("\n--- Changelog Summary for %s ---\n"
+                             % pkg_ctx['PN'])
+                if cl['cves']:
+                    msg_body +=3D "\nSECURITY FIXES / CVEs:\n"
+                    for cve in cl['cves']:
+                        msg_body +=3D "  - %s\n" % cve
+                    msg_body +=3D "\n"
+                msg_body +=3D cl['text'] + "\n"
+
         msg_body +=3D mail_footer
=20
         # Add possible attachments to email
@@ -682,6 +702,30 @@ class UniverseUpdater(Updater):
=20
     def _get_packagegroups_to_upgrade(self, packages=3DNone):
=20
+        def _resolve_stable_version(pn, cur_ver, next_ver, tinfoil):
+            """Find the latest patch version within the current stable bra=
nch."""
+            if is_patch_update(cur_ver, next_ver):
+                return next_ver, None
+            I(" %s: latest version %s is not a patch update from %s,"
+              " searching for patch versions..." %
+              (pn, next_ver, cur_ver))
+            try:
+                rd =3D tinfoil.parse_recipe(pn)
+                if not rd:
+                    I(" %s: could not parse recipe, skipping" % pn)
+                    return None, None
+                all_versions =3D get_all_upstream_versions(rd)
+                ver =3D find_patch_version(cur_ver, all_versions)
+                if ver:
+                    I(" %s: found patch version %s" % (pn, ver))
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
@@ -746,6 +790,29 @@ class UniverseUpdater(Updater):
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

