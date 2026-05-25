Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A27CD5BD0
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 11:19:54 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13990.1779707989499604992
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 04:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=F6FaDJE6;
 spf=pass (domain: ericsson.com, ip: 52.101.69.11, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crjB3l45DI0Af2QuUj56RvajdNaUpyRDKYU3elINuxq6YdSFVEg8JoPjj4z0gjmHJFZrYq35zyBpEtXvRVO4N4gIRjECPAaT87CdQF4GpdvAHPgHf2gCT5VRSl1ljn7Hv/i2a6r9Vcm46Drk24Uia9t209l1WPZhup6Vk+XQTqI/GME8AvKy571qjhkfwSL4mSKo5Qr4YRZwsSohWYjvYeifzicldK2hhmQSHEkB2DhF6IjJql45HcY59xmtF92SmpiubsVKPk2L4zV55tNQj7/O4DVxcRDmTHo6UPqJSm/jDwr04l/TFh+RDw1PkBlI3T3iZpfAGLPw61rLgmh2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZPbuNENwHyB6PuXKb6CFSBFB8suuno2CPjjTuNVajg=;
 b=jVwNZrwNUfl4nwr4nFlchW0c/9gnQGuEIBEJFvFDJoSsFCcBTo9pyzTEE3KSqpqUZ/DZYuj4JuJX5hAAxML+NjOHR3SwBcNf8kfVUw6c+EJG+fAe37+oT+apSz/mKQ1bYCpjqqXSTI6pUiooby2p7V1Yo8SrgCPgGiaVeb44brH6o1YUbFPUXYJlY/wm1gRMrGDsjjBKEGEKUm5BBgkHCt97q0OG0FMLFSo6ycSXdk6IVnAMheXYGvhx42XgxHbtrPvv76p75580lGEk8p6XZYjdATqAO141ZBCUKLrR+JktWaVAJrV36XBhS2NuSc6bOw+SZhRMgZMhfbJbQDdg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZPbuNENwHyB6PuXKb6CFSBFB8suuno2CPjjTuNVajg=;
 b=F6FaDJE6jjqb8d02hgEVuABmi1iNl8VnzvfFQKRTxIrpkiwp5JdM6NepsjtlvLTXPXiYFIsCwSfDeDR8YINXgRU0OJ1G3k6HPnjJ59Nz7EjLdmPt3/fI+lNAKF8akJo9tCZoJ2wHlTMpXh7YMivdYyDRRmVHjtTe3T6H4DbGWymzfFd/DYIpPlRv9/Dy+yWCTeK2GXO9EaTFrrjjgsjOR2Ny9tryIWJKzeBPaNM+Q75Mf1rJvu0nLRG8ijsV1/M+QQQii28zK9C9s+8ZvMfoWAffmaRXwENYO39V9CE9WPO6rGC8zhAz5pwBfjiCJRK27/tS9rVSjaLTZfRX9yKasg==
Received: from DU2P251CA0020.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::29)
 by PAWPR07MB11170.eurprd07.prod.outlook.com (2603:10a6:102:50f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:19:43 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::7) by DU2P251CA0020.outlook.office365.com
 (2603:10a6:10:230::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 11:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 25 May 2026 11:19:43 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 25 May 2026 13:19:42 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 2BE884020F85;
	Mon, 25 May 2026 13:19:10 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 13AC47003739; Mon, 25 May 2026 13:19:10 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <Qi.Chen@windriver.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [AUH] [PATCH v2 2/2] steps: include devtool changelog in upgrade report
Date: Mon, 25 May 2026 13:18:45 +0200
Message-ID: <20260525111845.1018725-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525111845.1018725-1-daniel.turull@ericsson.com>
References: <20260525111845.1018725-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|PAWPR07MB11170:EE_
X-MS-Office365-Filtering-Correlation-Id: e9320c24-b966-41b8-ff0b-08deba4f8573
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|11063799006|3023799007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	mmX/WdANribiaT+/6Ux1hT3MXL/bd8+k9ZApM2m4dlM+fM3NqQuFrTBRv5QmBWSIcQpFBbcBgFIT8rHKNARGKOiD27Zd/mt42zSS7VcfcY//4aoOwpUkGzQ/p/nrfSKeW9qoTK31/gVWSaZ0ncnQYpQeXb0k/cvOph+fjez/TPLP/vc9Igoqsell1AAMSy4Q0+aCdXCf1BVt6BNrqczRH/M8lwOf3tRE0c5kqf66Jytg/Z/CB2a81rSvk8yvce4iuSz8TVXnKZWVBcWEY+hE/YRIZVMTiEhh3vyjqWSS56/n0t9NAQX3rhId+F1MS4lUUIHGJAxE1yDzyPhHbMl5Ypveh8W3sDu8un2DYeOdABDfhNbKyL16RSGJ/KkYbAlfjlkVof6XTTEJEM8m323D2f/AdHsbFWTY+TB0M1UZbGd+fNxOOUOzPMjTIb6ulgpSrVkzeTCEtMNvGUJ0wYE462ysOGQReM0qlOkLhPLq5PLmniofoXNA7HHQd8fm/4g6E/bJkOWkuXSyOS5djLwA2j/coDLmXGjzDaYtAmM+32nQJ5Q2Wl7O1eL5Bg+MZabfKm0NuvUtgDKoAVT60ltEMXywIxIFEcb8L/vIr9k1FeWmuDP+aL0cLly0rZTZ42EKaB8whcNOPAIm4678GSJCXQ647t1j4SAFHNB6UL4IBeOi3mtBYQ8B+nnNECt688ZGSy/6NoS2bxpTEcqXOecY5rqjNzJU7OH/5K9x8KJdgQU=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(3023799007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	LSG4YrzbxPI45Ca2W5vnnDmwQlxUv+Aq3XW/EL8Pc2Vu51/KJu8V++6iRTjZnSI8ryPIj/Ha7bBooBfh9lKAURJDy973UBYcOb8GiuV5zAPC4ue7yx+6IDnoVNN/LkgLx0XQUWPsbeabrNNpBuI809IzNQ4N/ShmR0VP7oEfbdtikWQiZZO0X1jvt5f/T7piZno+r0pE3WyLROuVWhc97PVO9O6lMrR+THYm7lzALkcltYsfCVxyqt2s6cssPW8Ht0wtX7f651ygACtLPd6wRl9H7stZu1BeklYxeKOa3/H6vsryK0cmny76zEHVEHje2qWlHpZqtUJR8QgVhf23EMkk0oE1RL3NQxqEZUcgGeQUNQEh1LziuQXuArTYcFZUyO8wi1xQrLmkyVbWQNvIRcAVIlrEdFqoSA3qsN0hekAIaUFxvg5jBdsjtites21K
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:19:43.6217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9320c24-b966-41b8-ff0b-08deba4f8573
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB11170
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 11:19:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4040

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
--=20
2.34.1


