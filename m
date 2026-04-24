Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7530FB44D8
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:26 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19331.1777031176998279875
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=ghx+rQkV;
 spf=pass (domain: ericsson.com, ip: 40.107.162.63, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8ZR+L0eOngi7AlWVwcZM7LL2Tt7nFjNxQYG+gUNhQkBPI6CRzZXXIqJrLYwoZuxmSsI+ps/0Gz9WkO2AatZFkHMrVUwC8toABwavJ47H4ddeLhrDrzN065kzxc/UfCBbbHGsc1Q+kyHqfHLpRGddebi5wyhMPABHPT9swtlTDQj6bHEldmY/IBvPBbhBq2YPaNgWpP5xnhsWrIQc+SQRYDG9zpn7Qx+1WJSqePUYCepS4367LEihkXxKrUo50/TDmdVLogonEACymfu1vlBev0ZCSkqmqAzXpw461IY2dWU15hedY/MV1lmACUkZNph9EkfMQdvuoF1aifgHJavjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPFCL+AY5LMQmFN8t3HXt/qkKIXv5L8+AXkNwrmO5l0=;
 b=QKoANRUv31SDKFlvZuJ0HLWaEuZmg1AXbRoB+gyE3wbNzjWWLO0MJm0z+J88PgF67FM9Ho1g6mXRP4zNg7KOEHo9gRchTaF11IAdms9psauOM4E1IETaIgcq/6SZJFq5gdNr4s9ECivvvR7LNqVqORTyMomcMEw7UiN5Quh51XADG/45xkY7SE2EEDD7K1eXTXLQKZ1ViKMMV6Si5gW4dFzO2/col8K26K5lOCUOmfI9/pt+0ff21/mEPnIym4dHZQy6Uhn6aKlmfrE2k7ZnF91e304X3fxWVlqJu3QJ+IuunqgLmPq73EPpuQf+2l75P7/SEFE6+x65LeVWHHOr9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPFCL+AY5LMQmFN8t3HXt/qkKIXv5L8+AXkNwrmO5l0=;
 b=ghx+rQkVITZeAHHX6yRSOwJCMUhLO3lX4j6zzWFNSOlp4/2aOSU1kxFlLRfrKxSPEO6hDXd0nuZrD4nNJT2a+TE1vn4jAHj65nrTcMFWbVf6NfxZ19kq8sc6nQhtBg0NUVJWOLRTtd3vHmwhTAAsZEmntqtCE36VaFvm00C4KnEzupNRWLe7ElaFTivGpxsfsDznNhUQJw5KY3uAYwLXZa15FszzRUyu9SUMapBoJ1MDrkNTjBaRRqWMhxlYQm4HfFxTIgLorIzEnwD5EvFFy0ACRveepqS8kFW7oQkuD8h5ya8TTKCSYpwwrT2cfC+od1XyqMBdAPy0P/Kn/jFPqw==
Received: from DUZPR01CA0162.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::10) by DBBPR07MB7547.eurprd07.prod.outlook.com
 (2603:10a6:10:1e9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 11:46:11 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::43) by DUZPR01CA0162.outlook.office365.com
 (2603:10a6:10:4bd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Fri, 24 Apr 2026 11:46:11 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 069524020840;
	Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id E0E8A700DB95; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 4/9] upgrade-helper.py: add changelog flag
Date: Fri, 24 Apr 2026 13:45:58 +0200
Message-ID: <20260424114603.2444938-5-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424114603.2444938-1-daniel.turull@ericsson.com>
References: <20260424114603.2444938-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EC:EE_|DBBPR07MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 76388c9a-7fae-4455-03a5-08dea1f714db
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	HFM/lQ3xNFRwFTsY4lkXshl+Acq4rG24/Myt8tvnKz8xfTK32FkOqrmo/tMfWWOs8X592cDcvqWwbUdoBU9DLsA2IINvRR4lA9rmfi+eBZ8+6mQA3XWozCidHC4habwziw0M1xt+NE184LwEzwlZjBAaby30TDBgmyjBiUjBMwMV4528X6juoHRfFzQHOYjt3Kor7YDDbYlrSyMy1diyzKgNX1glvZPWniv1HrL6gq5Zx1iFsdWkMgizCmUngDm7JIVrvKwKGdU89TQYLToKBMQmOzERNOUz3inqdtZKIHDExxSDsI9lO7Xj4GfYTR9L9lycf6BiRZ7yxB7nfo65xMevEyP/wwGJqsMwCTs1SLDfXBjdAVl6bYpm1OKz8Y3S1jj/+ihINCtuRv2fdgVBmaTWwkF5LDFBjTwXMOv0YUwYq7yUj4C/nbgkUEbzWVD6lI+CkCcrbiPmtlXvkafJCqMk4U42f7qDtAAaXUtMJ8etpW8+mHJ7l3pgqbfpkkAk3/r3ygqVEKuRiZYw4hctGfvW9OdaO/CbI2uc3Z+5MASTdAS6FNU5u+9R7UTvoWnwDi/elEGbkqLx9EyyF4GtGT6pxnJa+63Ga3yIPRR+IYWLc7Iac3jJowWVrf5w1kVIvhFocSiJaDMHuL7wOW5N/wNYXyQgIxuAttdCKSRAmoMNb9X6+f2ersu3bsJ1erXmusoLQYbt4/fWrhsZZlFJctBOZiGTBvm53DbnNWT/DC0i9MIQQlq9sP8+ZHPPSIDF5qon1kymLgCsXyEUZacRTw==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	KhuC5VbSbgOh276Tye9e2O3HLkdROomfoP08nFD+s3Q1ZM0w2SG4Gn+BzcdsUyBQE2TY1jfdRJ+esOMiLc7NLg7YKpaNi4HtSrsjHS/WYLYypXNzQi7y2sWjSnmk4oJIrGpDKmGc15ljTkbQmVrUFzmE4tqclX4N7oGcv4JZ1Q5mLyzBWKcnjf6HTQhmdt19zFS9piwe7mgRUH1pUlqhVDxuIy5vpXr2HDkoxkIYajJXgWXclfhDl/r5MEQLUc9IZbybeGrvY/X4XXozPl5wu8H4ejGdizlSoiJ/yYtmtxorPJqsh/TnF2m8UsDY75j4NzSZfcaBDcxpVbHsCdbuJymZtDe30WwUOCuIG5k2UGMZreLDfrhT3h+f9TdUrJ962fME1XVl9WtleHIkNOFwk8Hf/HXOicQ64vHyj6OpxeMbgU/NMR8wcM2MgU96J0DA
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:11.1274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76388c9a-7fae-4455-03a5-08dea1f714db
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7547
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3797

From: Daniel Turull <daniel.turull@ericsson.com>

Add --changelog option to extract git log between old and new versions,
highlighting CVE references. The changelog summary is appended to the
commit message and included in the email notification.

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
Assisted-by: Claude, Anthropic
---
 modules/changelog.py | 256 +++++++++++++++++++++++++++++++++++++++++++
 modules/steps.py     |  20 ++++
 upgrade-helper.py    |  16 +++
 3 files changed, 292 insertions(+)
 create mode 100644 modules/changelog.py

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
diff --git a/upgrade-helper.py b/upgrade-helper.py
index df927d1..327bb6d 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -95,6 +95,8 @@ def parse_cmdline():
=20
     parser.add_argument("-t", "--to_version",
                         help=3D"version to upgrade the recipe to")
+    parser.add_argument("--changelog", action=3D"store_true", default=3DFa=
lse,
+                        help=3D"extract changelog between old and new vers=
ions, highlighting CVEs")
=20
     parser.add_argument("-d", "--debug-level", type=3Dint, default=3D4, ch=
oices=3Drange(1, 6),
                         help=3D"set the debug level: CRITICAL=3D1, ERROR=
=3D2, WARNING=3D3, INFO=3D4, DEBUG=3D5")
@@ -198,6 +200,7 @@ class Updater(object):
         self.opts['skip_compilation'] =3D self.args.skip_compilation
         self.opts['buildhistory'] =3D self._buildhistory_is_enabled()
         self.opts['testimage'] =3D self._testimage_is_enabled()
+        self.opts['changelog'] =3D self.args.changelog
=20
     def _make_dirs(self, build_dir):
         self.uh_dir =3D os.path.join(build_dir, "upgrade-helper")
@@ -358,6 +361,19 @@ class Updater(object):
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
--=20
2.34.1


