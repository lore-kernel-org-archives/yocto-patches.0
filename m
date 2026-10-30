Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8580.1793356795363984055
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 Oct 2026 03:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=AnBK1sRN;
 spf=pass (domain: ericsson.com, ip: 52.101.69.71, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3bknnbbyyFnJhSTceEmhnJWl8kM1t6FlP+BDEySiTFpQc7qVhjddnlRtyF/q7pdtIaItS9yDgPspmPlx2qEXarUnlzvoUC/mNJa2C0SpWcWCD57/YDOXr/gZXBHGs2LI6AWCUBEdudZcjg6z3ijOsfH7cqwA53QpiXE7tfms9Wu2cK/JQx+2nKjuiQWLPLko5+/i2R6cRQycBqQUFaGxF4EU8+a+7LWBrRKyuk63tXt0fvp1Y+czpLXuFhH+lY86xjijP3MpmnYLA5BObTJPMFLNYA5511sLXSq93ave0igmMgAEFDCma+5HaNypVlZVPhOsDz9/mpsn+0Lqynh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM+Xt6u2+RJ24nNePpQlduEpA7978M00lIf5TfwGxYM=;
 b=pyHf86JfrvSh2Vgx1wqvk34l9UdPOOtSx82Ffmddwi7OmS7b/7R/vcAVXpyu7eScJjANArkBj0fmfkfPC7v+ABNXWQH8m0m9/9pxw4c789XYQH77xeR0tGD7AuZTaYzpxhuXMiUMY39NjI0g4xNaQT3RqwcAiddBNkVMCId8ceB6ojRtG/K7z5sTK+Pz+iwyb+yScH6P/MbUNzFzjnIfnW90eQyFT71R4yyXJNQQpYbKecPTiq+2vgeXk+/NCK6mogk0VRiIQohI4ikSmyYoycOucv+GfXvZI5rTvgZyFs4kKJiPtmUKMyzfyWd2wjo/KANce6Z0OqpN/BhsZ11o9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=est.tech smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM+Xt6u2+RJ24nNePpQlduEpA7978M00lIf5TfwGxYM=;
 b=AnBK1sRNdBsY4z7wJGvwgrEPlD/DvISBbTju01VlDaglsf53C1DuGSEh6s3Az9Ng2WTwlYwUt8NF4o65xa/wCdmdotvyRIFgQrthO7aQBx9NRrDC2ujm2TRpIIFx9XnoAB5q2PD3ZQNo+FPOWXPBkpGTv3bkMa9OaTC0uED1mXGS+Szrd1lmS5FW41QsQxGzUD/m9dJkTEgKE5DxXw3KB9Atk8RXH7043MMy5LRTMHVh182PIUNC8IoV/5/HSG6+k4z2XKl6rA231XtvQ0xjQkW3TvUY/HH6m8SW/iWl0nH2Eg6CknkfqYcbmdMCcYS58Ftxh2KhZThrZMFzkOoC8A==
Received: from AS8PR04CA0023.eurprd04.prod.outlook.com (2603:10a6:20b:310::28)
 by DB9PR07MB8428.eurprd07.prod.outlook.com (2603:10a6:10:36f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 10:39:50 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:20b:310:cafe::7d) by AS8PR04CA0023.outlook.office365.com
 (2603:10a6:20b:310::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 10:39:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74) smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 10:39:50 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 11:39:49 +0100
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 385E74020B44;
	Fri, 30 Oct 2026 11:39:49 +0100 (CET)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 0AAC2707231C; Fri, 30 Oct 2026 11:39:49 +0100 (CET)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <jaipaul.cheernam@est.tech>, Daniel Turull
	<daniel.turull@ericsson.com>
Subject: [AUH][PATCH v5 1/2] steps: read changelog through devtool's metadata file
Date: Fri, 30 Oct 2026 11:39:40 +0100
Message-ID: <20261030103942.2373161-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000094:EE_|DB9PR07MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: c066b565-613c-408a-436e-08df3672201e
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|3023799007|6133799003|18002099003|56012099006|11063799006|261026121527099003|261028144727099003|261022105027099003|261022075727099003|10067099003|261026140227099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: tr8aXARJcoha/20mU00aqlMOO5/sZboD7Kh6IXT/YaVRlpIr3+fc3Q//oNf6aKXNE3pxpv6uHCI1DuSIurcsQhqq22eDoa7vwzaNFjiS1iKbGOQukLgvXXKtNA4KvHJuv9i299hjfA+I6+Bv/Dzh/CGBimpquz3Ui5jaaihihHagjDiPgW0jIaPootC/pfJerAalbngdH3EDAw7F0x3kTlE8N/2G6GXLs0GdZPpd0hjAb+NoFMDsN/YhkhKN9bZKTab4oJdlN5jzJmDLNBebBUrmThjBrklFSJeQXNlk/X9VOEaXSh6U478krGdcJB5MLh3OEXuFwIMvfXua2zGKy91M14RaHVMDKHOvbMFa8SJ7a39LblGZPDBdU4sRdNs5QJ6GFMTtauCU3B4Dfr2IQofYRjYuuTn+8+1lhZ6/HKnOQ+dLepW1dsH/COfp7KAMr3972JT0FN7ST7tfLgd4v3DdS2l8D8ymZVQGYCnGJud2IXRAgIFwHVr4y6AC9lh1YGjjpBpEKKBAauTg3BqI/02chcud1W6OyrUsg1/4X2iqEszfGPu2DuAnMNfWsSUTodNmalsiL6G+ZjwM4z3In8ZpfQxmm/STOEUOZBH0xqL5NXJD8wGZBP2taYlhXaIt0t6Iq+5mmemwZObwjh5LrwPiFouSWQ/PftlvXd5Xt6w47xr+izKMbCNPpy+WY6nS2rjRObMZHa2d7KFFvFwEtg==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(3023799007)(6133799003)(18002099003)(56012099006)(11063799006)(261026121527099003)(261028144727099003)(261022105027099003)(261022075727099003)(10067099003)(261026140227099003)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mm7R/3O/yISbkKbNoTa6TBL3CGSH3PLVZGO99IeL+2m452kXZzIsm+pwx2MgDOLa8GfZpLEWuBySOhpCCAWkBJJTpXIaV7w/+NALDOJKemj7HG4do1TTLV1nOVD2mIGMC1WRHlBkNf7s3vYb2wBqXBYr0p25gvvxBiwa24ERm1ZdJRFDxLSHY6v+pmCAVLwN6d8pUJugADnh/Hnz605E4d+l9tzlRVgDhf8Zh6mJ8hOXDlYLiNlzk+W1jvbkQVmnJiVJiK50OWT4cgxiuz3kQi06gYVdlB4wpId+Z6SnnlZezqsKWxAVAM05IVj7zar4X0G42XXMJl3zyv/nAOa/xd5BStTlqTeDXqSFqbMwTnrm/ZGrdrfLuMvmysihYl1UqWXluFMDt2tsxL8C6UTgPxCoMklrao6MUGS5bvmRhheCFTMCnIHV+DB2LggsNH9h
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:39:50.2317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c066b565-613c-408a-436e-08df3672201e
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8428
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Oct 2026 10:39:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5190

From: Daniel Turull <daniel.turull@ericsson.com>

devtool upgrade describes the changelog it extracted in
workspace/changelogs/<pn>.json, including the name of the changelog
file. Load that once per recipe into pkg_ctx and get the changelog text
through it, so AUH relies on what devtool reports instead of guessing
the changelog file name.

A missing metadata file means no changelog, as with releases whose
devtool does not extract changelogs. Any other failure to read the
metadata or the changelog it points to is an error.

Assisted-by: kiro:claude-sonnet-5.5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
Changes in v5:
- Store the metadata in pkg_ctx['devtool_upgrade_metadata'] via
  _get_devtool_json() and read the text with _get_changelog_text()
  (Alexander)
- Read the metadata and the changelog only once per recipe
- Only a missing metadata file is tolerated; other errors are no longer
  suppressed (Alexander)
Changes in v4:
- Load <pn>.json once, expose its fields in pkg_ctx with a devtool_
  prefix and get the changelog through the changelog_file field
Changes in v3:
- New patch: refactor split out of "steps: skip changelog in commit
  message when devtool flags it"
---
 modules/steps.py | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index e678a4b..3da8984 100644
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
@@ -80,20 +81,23 @@ def _make_commit_msg(group):
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
+def _get_devtool_json(pn):
+    """Return the metadata devtool upgrade wrote for pn, or None if there
+    is none (no changelog found, or devtool without changelog support)."""
+    path =3D os.path.join(os.environ.get('BUILDDIR', ''),
+                        'workspace', 'changelogs', '{}.json'.format(pn))
+    if not os.path.exists(path):
+        return None
+    with open(path, 'r', encoding=3D'utf-8') as f:
+        return json.load(f)
+
+
+def _get_changelog_text(metadata):
+    """Return the changelog text described by devtool upgrade metadata."""
+    path =3D os.path.join(os.environ.get('BUILDDIR', ''),
+                        'workspace', 'changelogs', metadata['changelog_fil=
e'])
+    with open(path, 'r', encoding=3D'utf-8', errors=3D'replace') as f:
+        return f.read()
=20
=20
 def _append_changelog_to_commit_msg(group, opts):
@@ -119,9 +123,12 @@ def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx, =
workdir):
         devtool_output =3D devtool.upgrade(pkg_ctx['PN'], pkg_ctx['NPV'], =
pkg_ctx['NSRCREV'])
         D(" 'devtool upgrade' printed:\n%s" %(devtool_output))
         # Copy changelog before checking for conflicts =E2=80=94 it's usef=
ul even on failure
-        changelog_text =3D _get_changelog(pkg_ctx['PN'], workdir)
-        if changelog_text:
-            pkg_ctx['changelog_text'] =3D changelog_text
+        pkg_ctx['devtool_upgrade_metadata'] =3D _get_devtool_json(pkg_ctx[=
'PN'])
+        if pkg_ctx['devtool_upgrade_metadata']:
+            pkg_ctx['changelog_text'] =3D _get_changelog_text(pkg_ctx['dev=
tool_upgrade_metadata'])
+            with open(os.path.join(workdir, '{}-changelog.txt'.format(pkg_=
ctx['PN'])),
+                      'w', encoding=3D'utf-8') as f:
+                f.write(pkg_ctx['changelog_text'])
         # If devtool failed to rebase patches, it does not fail, but we sh=
ould
         if 'conflict' in devtool_output:
             raise DevtoolError("Running 'devtool upgrade' for recipe %s fa=
iled." %(pkg_ctx['PN']), devtool_output)
