Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680D5CD5BC0
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 08:05:48 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11559.1779696339451973335
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 01:05:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=OPCpf8Dv;
 spf=pass (domain: ericsson.com, ip: 40.107.130.23, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4bDx4RyaVcIDE6giBppTbxofpujQV7H21J/1EW62JPfcRVHRRQIFCYvDe1mqNOrHU+E6J0MSAYsQYczM3ry+2JZaB1uLaHC/wam1o8lnHKh/NEtwvF622cnNjsrq89ECnuqg6+QfLHa/3KQPHj1SehgrOYW/yysuqRWeNyKbPChgJ/UgtRe7xKtShWXPs1nDLjQKTDNq9h2TZoX1sEG6slyWaXbP6JXE7UXB2RqDsh1tQ+gPbBmmr5SrTt1AoglSCuaP4Q1LSQKgm0nYwcPkkrgZ45Lz7J5XDs2yADCZSsppIysLR+pkTl5uBs7Eox9SWxxxLJ5QXtciPCxO2SnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UoImDsRLoN7ySQ5oNiFWbi1yt7jnM1D1cFWP0t3p7A=;
 b=eYN1H+sKFrG8OisLYpvKu4UXM/Q1wf2a5P+p0H5ABY/Xxa9Z+m1i5Cqy8enx4kEOqDRGYtY5ZaOZfQXcBBS4feqRubJHylBCN3ChEqSFGyidk/4yBiYOwhIX6tCH8VoEGCgt2qUO7EsJ793BWj2ZidlNFSZanfz1dqxmlBQ0XmRPieMSqYR6J+mUMnUM8V/Ax7UmbaftSfa9ud+pgd1kXUi0rP5fbaTV+kbEZyLafoLM5+2lROz1lk/3p7cqgDvwSZ1ZK2Ly9ct3cenkofqztkj3U0i1kZbHK1JW54M2tIw+eVslDO9X2YtQPbLX+fVueyaCloMfoikcMfOS+3uBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UoImDsRLoN7ySQ5oNiFWbi1yt7jnM1D1cFWP0t3p7A=;
 b=OPCpf8Dv80PRKUNKaxVZguag1S96p6PhwLql2kbEk9yo9KjsvtyG33AHBK8ze8CaQpJuR+3PmFapXL88ZaZL7MbBSH0ALho5gGzj/7GtNRYC9u6D88+Nu9JJTBxyQF2AjtKWgq5PUzqsqug+X0qgkLbrwOHqJFNs2v9ppksdbaeJ3jRjan/0C99GrP7VAdReez7DSb0SbGl++7Pf9huIAavWfMyPnQlWeg6XPTKZ1gDP90wXKSR4XLZ2djcmhx1a1NUfqYSEx2hsbUi8qE5p6bFZdQWnr2uRndMs1ehNNiW80x88sHyVXu8aBtSgm8ggWjIrHnJihskZqiS/0WUkHQ==
Received: from PA7P264CA0406.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::16)
 by DB9PR07MB7690.eurprd07.prod.outlook.com (2603:10a6:10:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:05:34 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:39b:cafe::49) by PA7P264CA0406.outlook.office365.com
 (2603:10a6:102:39b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 08:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 25 May 2026 08:05:33 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 25 May 2026 10:05:31 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 4DB6A4021795;
	Mon, 25 May 2026 10:05:08 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 369C67003739; Mon, 25 May 2026 10:05:08 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <Qi.Chen@windriver.com>
Subject: [AUH] [PATCH 2/2] steps: include devtool changelog in upgrade report
Date: Mon, 25 May 2026 10:04:15 +0200
Message-ID: <20260525080418.942183-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525080418.942183-1-daniel.turull@ericsson.com>
References: <20260525080418.942183-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|DB9PR07MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b91b937-e9e4-41a2-8916-08deba3465a0
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ky15+3oKWCrrBwLf6y+WllH2xXi5CC1ts5qmt3ZATamzhRIlwVwO5a5z1A1lQcuARZZLh1JLgPxFAAMWpaLxSDjUkEyW7I8UworKUvyuguUlEaNZlDKohLAdQCjoOHnV620eJY8T1isZXDKP1SzPekFA701DawBgBiFXAPVXNd/hwiJ1mfOac1n0tP2SfOIUP3LRotp+qM9Ivx/UdhC3bptXPUmgTss6DlBuCCuOkVn699s1FGtTYk3rvouKMMfkuk1wkStYHyO5fxJ2Emr/PCRwbsL60y1H4PNqW85D884DXidAA1w+sh1HS3jwsUJ3t0NssBFLtE7AEcelXqbdvJB9JOZHyXbmtjvWeY8POCVioT8OPqMeMZTK5fhORtRMrAWplG1rjYotV8eYkeOiQneTWtlg2E48c4PKh9M7fOjz6+E/sUtpwqTRMC1Kf4QjPpG1SZSehSR11Vn1p6Nuhjixj+DVY0zElV6UXl5b8o2EOAEAx2jom9SVwdWTTDsx40vEohzjEU+1AicjBcVK3q3RagjSr6rm0Y4WWbR2o03wf/ukRvbdfSNtuNAYvG0NhjOSYOeDSb3NCUVswm1MsoINZWH493l+6PW/GmQMzamC0BHwoX6CXvcL1z+VpFQuPxi2z8VmE8xqwK8KiPxq4BrgNU1/tt1eMpSP8wrkDASWRbBqu2FWEqsj02skfwcPuzAwCBFbOJ1O00gEyRORyj/XEIbwyl81wcmRnVZ9ig8=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	04iaZB5kdPzmORAqVfIKwtNGFE0RS0HP+MqAWqK1hx7MiQYJFGblCXHWWFpagMNJrJdQFH+XoFVYjIuBs5aYNhin6mQIj7uSm289yn2Y0x3ipgQjwvwaVj2/OSvoCRkmcC1UxQD7tXlnMG+2uUQ2i8WWcTcJOxqrBpGOcAg8wC3TCZfWM70YvWAoPPcJjMsQenmkO3axDnynRhPCNqxj8gzG1ceoX2uoLdtSAQsFlAolPJwexfSsk7/V8KRqm8ztjmVurgMqTheEAE+cbg2+tIBPkz+9NDgpKL4AIl2ZN6MvLxA6l2BvoZ/VxPBNnI8tUESvJmp3PBEJTDELmwe6foWZ3Bqw2QDf2+nG81+JHYnSS0Ud9LQd7Ev5mmfzVvU3hGwt/1iDNArqm6z0xoVxtGLVxYGmsZyVIC4syQp0CyBgjvc+Ygtiwop8HkFGwg22
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 08:05:33.8702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b91b937-e9e4-41a2-8916-08deba3465a0
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7690
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 08:05:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4037

From: Daniel Turull <daniel.turull@ericsson.com>

Copy the changelog file generated by 'devtool upgrade' into the
package workdir so it is included as an email attachment in the
upgrade report. This gives maintainers immediate visibility into
what changed upstream without needing to look it up manually.

Also fix a pre-existing bug in _devtool_upgrade where the license
diff file was written using pkg_ctx['workdir'], which is never set,
causing a KeyError whenever a license change was detected. Now uses
the workdir parameter consistently.

This patch depends on "devtool: upgrade: extract changelog between versions=
"
Otherwise the output does not change

AI-Generated: kiro with claude-opus-4.6 model
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py    | 41 ++++++++++++++++++++++++++++++++++++++---
 upgrade-helper.conf |  5 +++++
 upgrade-helper.py   |  1 +
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index b3ec61c..a8856c2 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -79,10 +79,43 @@ def _make_commit_msg(group):
     pn =3D group['name']
     return "{}: upgrade {}".format(pn, ",".join([_get_version(p) for p in =
group['pkgs']]))
=20
-def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx):
+def _get_changelog(pn, workdir):
+    """Read the changelog generated by devtool upgrade and copy it to work=
dir.
+    Returns the changelog text or None."""
+    changelog_path =3D os.path.join(os.environ.get('BUILDDIR', ''),
+                                  'workspace', 'changelogs', '{}.txt'.form=
at(pn))
+    if os.path.isfile(changelog_path):
+        try:
+            with open(changelog_path, 'r', encoding=3D'utf-8', errors=3D'r=
eplace') as f:
+                text =3D f.read()
+            shutil.copy2(changelog_path, os.path.join(workdir, '{}-changel=
og.txt'.format(pn)))
+            return text
+        except OSError as e:
+            W('Failed to copy changelog for {}: {}'.format(pn, e))
+    return None
+
+
+def _append_changelog_to_commit_msg(group, opts):
+    max_len =3D int(opts['changelog_max_len'])
+    for p in group['pkgs']:
+        if 'changelog_text' not in p:
+            continue
+        text =3D p['changelog_text'].strip()
+        if text.startswith('Changelog for '):
+            text =3D text[text.index('\n') + 1:].strip()
+        if len(text) > max_len:
+            text =3D text[:max_len] + "\n\n[... changelog truncated ...]"
+        group['commit_msg'] +=3D "\n\n" + text
+
+
+def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx, workdir):
     try:
         devtool_output =3D devtool.upgrade(pkg_ctx['PN'], pkg_ctx['NPV'], =
pkg_ctx['NSRCREV'])
         D(" 'devtool upgrade' printed:\n%s" %(devtool_output))
+        # Copy changelog before checking for conflicts =E2=80=94 it's usef=
ul even on failure
+        changelog_text =3D _get_changelog(pkg_ctx['PN'], workdir)
+        if changelog_text:
+            pkg_ctx['changelog_text'] =3D changelog_text
         # If devtool failed to rebase patches, it does not fail, but we sh=
ould
         if 'conflict' in devtool_output:
             raise DevtoolError("Running 'devtool upgrade' for recipe %s fa=
iled." %(pkg_ctx['PN']), devtool_output)
@@ -96,13 +129,15 @@ def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx):
     license_diff_info =3D _extract_license_diff(devtool_output)
     if len(license_diff_info) > 0:
         pkg_ctx['license_diff_fn'] =3D "license-diff-{}.txt".format(pkg_ct=
x['PV'])
-        with open(os.path.join(pkg_ctx['workdir'], pkg_ctx['license_diff_f=
n']), 'wb') as f:
+        with open(os.path.join(workdir, pkg_ctx['license_diff_fn']), 'wb')=
 as f:
             f.write(b"".join(license_diff_info))
=20
=20
 def devtool_upgrade(devtool, bb, git, opts, group):
     for p in group['pkgs']:
-        _devtool_upgrade(devtool, bb, git, opts, p)
+        _devtool_upgrade(devtool, bb, git, opts, p, group['workdir'])
+    _append_changelog_to_commit_msg(group, opts)
+
=20
 def _compile(bb, pkg, machine, workdir):
         try:
diff --git a/upgrade-helper.conf b/upgrade-helper.conf
index 269bde3..d363c50 100644
--- a/upgrade-helper.conf
+++ b/upgrade-helper.conf
@@ -121,3 +121,8 @@
 #layer_mode=3Dno
 #layer_name=3Dmeta-intel
 #layer_dir=3DDIR/meta-intel
+
+# Maximum number of characters from the changelog to include in the
+# commit message. Longer changelogs are truncated. The full changelog
+# is always available as an attachment.
+#changelog_max_len=3D3000
diff --git a/upgrade-helper.py b/upgrade-helper.py
index 40f31c4..f7a63c0 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -195,6 +195,7 @@ class Updater(object):
         self.opts['skip_compilation'] =3D self.args.skip_compilation
         self.opts['buildhistory'] =3D self._buildhistory_is_enabled()
         self.opts['testimage'] =3D self._testimage_is_enabled()
+        self.opts['changelog_max_len'] =3D settings.get('changelog_max_len=
', '3000')
=20
     def _make_dirs(self, build_dir):
         self.uh_dir =3D os.path.join(build_dir, "upgrade-helper")

