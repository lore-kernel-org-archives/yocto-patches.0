Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18839.1793107879225737328
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Oct 2026 06:31:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=B+UzwGsj;
 spf=pass (domain: ericsson.com, ip: 52.101.69.7, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXhph3Iip7mRiVedC+wph7R5ARmiHKa7TjvFUd8t//stCd7VDqiH1g/A/m/tVBATbCTRTQw5t9NnzA75xOqviDnF7JnBuZ5fSA6e9TE3U4cFrj4RDZyBLnIMX3Dcg3Pv+esXMDGK701Q15ZTkjIKFGqBbiPGpqFZNYK9YE5sBv0vM8fbWLtNq0mHwuLtr7DGfmb/xrGJCwmDGw5crYmErTcsHNYMI4Uw1IjyYhbE67uqWH13yARTX9PcB+vZa4nE1TQ7HUsTPnzj8nscJj1WcC8kq7PnjIThO8BGGv/PSYZXj0t4F+m+6r46qiULH0DXlhnaJ+R+PCIlnivtTZD7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gfSKTsfDr2yYVtw/LpQCOS/+0517BTc/SRmDrOmQIM=;
 b=vqY/AyfH3/j/rVTrLiG/Iulg3dqZ5MlBtuNy7EfvEceKVUPL37ndmkYMKWpCu4olIl5iMnXlNJJUFJpWxR4r3xdFn60EdkrmF3TV69QhOGRv8UKBMw4YA0WbHXZ+m60QFU2Tx6ldKFx4ZostZyoFxNaXMMFwQqod/R0moNDy0g6/BOYrdJrrxhwnlIDVW2r7NgXEYDYN1xOYoKwCVAneLzYakNJ0gEFWNlXIjLbjQpBg4sp/ru0IwsS7D+mvw+pP4sURumgZTAETAcNiAskvPZ4EXCBsLNLzaNW3XqvMjx6na9V266t9Du0HuqpznCt4k3EpkOSspGdd96sC0Dmfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gfSKTsfDr2yYVtw/LpQCOS/+0517BTc/SRmDrOmQIM=;
 b=B+UzwGsj5CFORcYYQ0SugG9tY1VzlmL/SUNizkhY710t8rDq5IZWBQ7m6J/7lD0oUgYTTDB7ROhr2pYOpdWjsbuTKhlyyvus89TFjyIrBb9mQWs8HWjRU2rBOyyA9V/qIfOyEqAdkaBDXFUujYnCsVf96tyo0iWy8dc3H/rI2FZboRFs8uYUbKKFn895iM5sQ1EbA3+GxSsv7q8CkXSdSvvPHaZ2rwQofH4x15NHfdD5Fd0Zx3oPFrZeoZXqmD2uN3C8GVnxdAKSHCWkh1Dmjcg0tBdezD4C5jBM0E6KZyy48Qb/cVAMMCLPlvG+2cEGRImiIONB0VKr02OiAnUuaw==
Received: from DB8PR06CA0042.eurprd06.prod.outlook.com (2603:10a6:10:120::16)
 by DU4PR07MB10230.eurprd07.prod.outlook.com (2603:10a6:10:587::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:31:10 +0000
Received: from MAD0EPF000008BF.eurprd04.prod.outlook.com
 (2603:10a6:10:120:cafe::a3) by DB8PR06CA0042.outlook.office365.com
 (2603:10a6:10:120::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 13:31:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74) smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008BF.mail.protection.outlook.com (10.167.241.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 13:31:10 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 27 Oct 2026 14:30:49 +0100
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 4C7AA4020C1E;
	Tue, 27 Oct 2026 14:30:49 +0100 (CET)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 0EC9B707231C; Tue, 27 Oct 2026 14:30:49 +0100 (CET)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v4 1/2] steps: read changelog through devtool's metadata file
Date: Tue, 27 Oct 2026 14:30:42 +0100
Message-ID: <20261027133046.300849-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008BF:EE_|DU4PR07MB10230:EE_
X-MS-Office365-Filtering-Correlation-Id: 50aac36f-cd15-45cd-7e7e-08df342e9073
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261026140227099003|56012099006|11063799006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|18002099003|261026121527099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 2gSTDvgxSRbZhrvwXZpoA/4VhbGushdUYYSNbesZ30t9h0A62hBhdeJsC0OaOMOQwwOS62LCxcyWkxfzGEGNCNfynfuqLJtJHMBdigfVxhMU64conbPqGfNwChdYgd8QiFZE0oxgdrMr9UpN/xnRir59s5Z57ePYGvTlyQnblJ53OMgNXlPthY4Rev6JLoR3SA9IeaWzkOsUxIDaGD3mAwmDrtrVHE/OB5MbAG+uPs1UdpPylJ1G66+euM7rgv7LLNrZlm0k6zLCsIDq5yRddzPXj2UjNKhLxgow63msYOWJQ/EC4x/0grdRkCOw9BhOus2wocQTZbBjtBt7NHqsaX1UaElDowOs9PiKQ/ub0/9sxis+coVUg5Shj8Nz3WljH5HhbXeV3k9NIU1q8tfI3+WM1/KUfEcnTwYbDuvJZvlk7VeHGJg2ACieolaxwsj34KOLhKZ05gYxG0YhS6F5XzvdhEbY9TXZpDWGeVyStepmYEz8Mz9hNZG+1ZBshr9qVUhpyGJZZfXymabzK/bdfNpLYWkCOpxtns2Jjk6/9XQ2PBB3ol4i9Tsiu1ia0aGKDIK1R0HGwm+ffJLeb19VTo3NSCmcBejz/V6NF1heFQHxSU+Lo+eA6LkvSaYIoYK3Wm88IO3BIDIad9dLV2Gkzn/MREHUxKM3EDwJDwC24K7grCWOckEk8CYsy9U0teIRYaxvZ+oZLOk3VBkb+z+bPQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261026140227099003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(18002099003)(261026121527099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zoU0YqSNjQN1M8HaJAz7xy5zhKtoAI6QktemKn4P6eOCRTkq9LvIfCt2MK0qK3aoXS9qxZIPzgKC3ib/ZQQt776K+h2QD7fmw5HblMYLSNQVnZ8tj2KGoNrHkD0+y6W39WgESEv6WV8ujCWeaVHEWpZawBVN/VGgYpwR81EFtBxmaT0IZwVtpvLsgIqHouRESWttSf5eQedfO7kgDV7EK2X6R5FMHnEzZIoL8bNRPtzNAMjTjMoIQjHy/qE14yil8KKv2Uq4FLZ69kDl9j5aTTg68Dlls/gQnV1P/B9xUN6qKB1Aw8KFQhFWFURtz/SG9XPqcJmRNCX4vyS1O0lJ8Zr9qXXLOnAFF1yOSMjtFuC/4wVXSyM/xYVKUpfTCstyGYy15yy3ttmhkHvaVdIkM0qCm+NeUxu9FAULTsLf518YNlSQIx2PRahnQbmktWsc
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:31:10.5344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aac36f-cd15-45cd-7e7e-08df342e9073
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BF.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10230
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Oct 2026 13:31:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5162

From: Daniel Turull <daniel.turull@ericsson.com>

devtool upgrade describes the changelog it extracted in
workspace/changelogs/<pn>.json, including the name of the changelog
file. Load that once per recipe and expose its fields in pkg_ctx with a
devtool_ prefix, so AUH relies on what devtool reports instead of
guessing the changelog file name, and the rest of the metadata is
available without reading it again.

Assisted-by: kiro:claude-sonnet-5.5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
Changes in v4:
- Load <pn>.json once, expose its fields in pkg_ctx with a devtool_
  prefix and get the changelog through the changelog_file field
Changes in v3:
- New patch: refactor split out of "steps: skip changelog in commit
  message when devtool flags it"
---
 modules/steps.py | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index e678a4b..a68dec4 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -19,6 +19,7 @@
 # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130=
1, USA.
 #
=20
+import json
 import os
 import shutil
 import re
@@ -80,20 +81,31 @@ def _make_commit_msg(group):
     versions =3D list(dict.fromkeys(_get_version(p) for p in group['pkgs']=
))
     return "{}: upgrade {}".format(pn, ",".join(versions))
=20
-def _get_changelog(pn, workdir):
-    """Read the changelog generated by devtool upgrade and copy it to work=
dir.
-    Returns the changelog text or None."""
-    changelog_path =3D os.path.join(os.environ.get('BUILDDIR', ''),
-                                  'workspace', 'changelogs', '{}.txt'.form=
at(pn))
-    if os.path.isfile(changelog_path):
-        try:
-            with open(changelog_path, 'r', encoding=3D'utf-8', errors=3D'r=
eplace') as f:
-                text =3D f.read()
-            shutil.copy2(changelog_path, os.path.join(workdir, '{}-changel=
og.txt'.format(pn)))
-            return text
-        except OSError as e:
-            W('Failed to copy changelog for {}: {}'.format(pn, e))
-    return None
+def _get_changelog(pkg_ctx, workdir):
+    """Load the changelog and its metadata written by devtool upgrade into
+    pkg_ctx and copy the changelog to workdir."""
+    pn =3D pkg_ctx['PN']
+    changelog_dir =3D os.path.join(os.environ.get('BUILDDIR', ''),
+                                 'workspace', 'changelogs')
+    metadata_path =3D os.path.join(changelog_dir, '{}.json'.format(pn))
+    try:
+        with open(metadata_path, 'r', encoding=3D'utf-8') as f:
+            metadata =3D json.load(f)
+    except (OSError, ValueError):
+        # devtool writes no metadata when there is no changelog
+        return
+    for key, value in metadata.items():
+        pkg_ctx['devtool_' + key] =3D value
+    changelog_path =3D os.path.join(changelog_dir, metadata['changelog_fil=
e'])
+    try:
+        with open(changelog_path, 'r', encoding=3D'utf-8', errors=3D'repla=
ce') as f:
+            text =3D f.read()
+        shutil.copy2(changelog_path, os.path.join(workdir, '{}-changelog.t=
xt'.format(pn)))
+    except OSError as e:
+        W('Failed to copy changelog for {}: {}'.format(pn, e))
+        return
+    if text:
+        pkg_ctx['changelog_text'] =3D text
=20
=20
 def _append_changelog_to_commit_msg(group, opts):
@@ -119,9 +131,7 @@ def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx, w=
orkdir):
         devtool_output =3D devtool.upgrade(pkg_ctx['PN'], pkg_ctx['NPV'], =
pkg_ctx['NSRCREV'])
         D(" 'devtool upgrade' printed:\n%s" %(devtool_output))
         # Copy changelog before checking for conflicts =E2=80=94 it's usef=
ul even on failure
-        changelog_text =3D _get_changelog(pkg_ctx['PN'], workdir)
-        if changelog_text:
-            pkg_ctx['changelog_text'] =3D changelog_text
+        _get_changelog(pkg_ctx, workdir)
         # If devtool failed to rebase patches, it does not fail, but we sh=
ould
         if 'conflict' in devtool_output:
             raise DevtoolError("Running 'devtool upgrade' for recipe %s fa=
iled." %(pkg_ctx['PN']), devtool_output)
