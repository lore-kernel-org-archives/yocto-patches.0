Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D256CD5BD5
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 14:34:28 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.29])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21820.1779892467252627193
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 07:34:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=q6tZO7JM;
 spf=pass (domain: ericsson.com, ip: 40.107.159.29, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUCN9tqBza+wS4x7upR4qJqfYnNo5CgaxbrgDo1MkDPM230Deop/OlAb5t7Qq3jdpA9/6ifnxCTQ2qtCoBQi/LcTSm17MjTKltURrB4NIAmCzZscvvRg4EV7ePzsci9EUd+Tdh/OPIAh/AsblwXgx2b5lQ3OA9T1t+92ua6ILAE//T35EUQUCKKwLqfKYizWGSBahbYMvm8SVz7RodreaykFcIJxEylfemKS3P9HP9PIx1T7luLolN6hDe83DfUQgufeUUEWawTl1nQLpYNU+ZvVd8PBuDAqGkVSifJjDfIt3gFwPuCCGsi/eb/eB2q3zngKCtCl5rQz3VZHqg6JRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sEysX4RGf6bF/BiZoeahnPVeTbhjigSzw0+/D1yJFM=;
 b=A/i6kzGn+v9CChbiSewtTK0h71tnywYACj+MgWv6TTrMHivIM6h6h9eKWRn2PgGT9UX5LRhWTVBo0e4j/Ee6AXa+zSBJHOKMRzxrp8tl5oRBdnGRQIBK5aT9hHg3gbXhtlysNoEVCgUwswb0nl/GiR/x4bSt2BOy9fZ57OVshIpXSKR14TWvrmr380lXnRoCp9SZMGjHiZsArTmhC4G3jDpQ7AmJ9AAbnXbW8UasoPpKuV7FCWafchRtrZcJyR7cy4yl5RGQWk0GUH3nprMn/+JwQ7dIcb0AUGz0d/SKqlo2KCCXvxNOqz1Yifn06tvD2txRNU7T5VfPWQ60Cp2qZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sEysX4RGf6bF/BiZoeahnPVeTbhjigSzw0+/D1yJFM=;
 b=q6tZO7JMZoi4N2d8HjRqH6x0XgasU0mKVFPV8XDcDTNYMRytSdMFzVxt/8EbAkiGut98pWC7tHv7pA/nrE62oflgoDw8mZoQ5NvdiV09meW2yEcGQ8w+Nbnnyh8EcRUAj27MmLLAOOuxY/sM8VKYSr/eTQPIEN3cgJRT0BdaW5p3bfquJ61TilFSakPZjs7WHlAOZdbLdgR49mM+0gZ7CcC9XrOwc1giwffTfvgDxGUZZ+eIu7e/sfK7H99F15LZ9dq0m1nyFwQifEgKamlQmbbpIKR6XucKpiV00/xZzwEnwQwZoC95hD6zJ1IlKoWaw46jSfgMcZRNLOYg7CJMkA==
Received: from AS9PR06CA0329.eurprd06.prod.outlook.com (2603:10a6:20b:45b::35)
 by AM9PR07MB7139.eurprd07.prod.outlook.com (2603:10a6:20b:2d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 14:34:22 +0000
Received: from AMS1EPF00000093.eurprd05.prod.outlook.com
 (2603:10a6:20b:45b:cafe::8f) by AS9PR06CA0329.outlook.office365.com
 (2603:10a6:20b:45b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 14:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AMS1EPF00000093.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 14:34:22 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 27 May 2026 16:34:22 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 55876130540;
	Wed, 27 May 2026 14:48:33 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 43AAB7003739; Wed, 27 May 2026 14:48:33 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <Qi.Chen@windriver.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [AUH] [PATCH v3 2/2] steps: include devtool changelog in upgrade report
Date: Wed, 27 May 2026 14:48:25 +0200
Message-ID: <20260527124827.2486471-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527124827.2486471-1-daniel.turull@ericsson.com>
References: <20260527124827.2486471-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000093:EE_|AM9PR07MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c155e7-4a38-46f6-55a4-08debbfd0ba8
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	McG3l87DUJD6sOFLyvl7JtHobioRxEI21QdLTTl+dzUJ+Qeh/ggPa8XOTe80ihrPZtquejIJNUFeUZvyJp3yebp/KuoHEtLmtZxZbQVffkYfV4Qw7MGIVvw0U4MlXZ0VWB0MmoArTPGYhYYYZ10Kxyf1Fapoq+7WfUFQv7WyDY0EJ+sPx9RxqAnMXSR/5MwhMA/POmxoqSn1eSwmTDXjUXFAWqIaaYEaEyadOlyZkbKsfxuwg1jvdyFdAQC3AmeBOnWapiY5CBMG4LZVyKFrZzbZXpZyRP6mYKdnc4o8Fsslm4ntYFFDyPhv9hA3t+iJGskxBVtCwIuXmF+VnofDU6gygZePpiDR+l2z1FSemnfBL73tCBGncKEUYr/qATd+jaLwFKrwbdqwoXOX5+CcOg/GGsQKwdkLfHas1PG0E1fP/5bDJZEw2PSxeOz/NipHSp62/jNPJ3kxWH3B+t3pICv5cLVnKBBy92RkmTWxePmMBRtsNfiuqCgNbVFOsAxUOwI0TDZ3ZOEw7rKGkLSEthmUuGDbRToAdtOcjbQSlVncb3aI0yDSJINLXt3/s7DF9sKVB7fijpwUbIeRsrtiUlTma0qcpBu27JuGR55z379Lt8rI6jtyGamd4vdBprtc0ScyHLkXp3FhA2JZZfVLHWOHQe43J/ffBr2V1aHcwKHApa9yhdBfHl+uSWXzY/mUheVhDeL7oaF4TlHp+sxz6NT+36VildUERo9MJL+r/Sk=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	K24rNAHVBWjyTM7c/ir+bLCsfy80WAEQaLwUP8PT4syQGXcvXGxEQ2IO9DsjVHbKoM9JdOoAMYUCoUJGPTpk0DhVSTMyODF1mGJ6vfTYdVZUKdHFxDFCCxzZknYmOVK0cgkY+ZMb3i3CFD/o26bTBHAR+oGkPRH15meEbTg9+tm/OaHLwZLLOlTQYPTZnw6YjeOzR6K1UV6EGH02RkapG0GmJsmwCLH8hwcpVbrhmk689vzkaPkFIDeaixKbb9in1vIPhQRacTLYg45resYEDV2lURktHwDoBKM3nA4DQUrMNedIblTLR5ViMt5H7wIT19hYchZ9fjy6OJ5YvuZvBMcyTZQ02jpAKo1mDxosy1olhK2ro/Yz5PoY2bH96mtoFCaLQYJ1jDHdSUiTRgyxk4X1J18Op/hAR83CZ44Mx9NDrVcWvjf9HMkstSgVTkHT
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 14:34:22.9305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c155e7-4a38-46f6-55a4-08debbfd0ba8
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000093.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7139
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 14:34:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4075

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
v3: fix truncate message as requested by Alex
---
 modules/steps.py    | 42 +++++++++++++++++++++++++++++++++++++++---
 upgrade-helper.conf |  5 +++++
 upgrade-helper.py   |  1 +
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index b3ec61c..a88e666 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -79,10 +79,44 @@ def _make_commit_msg(group):
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
+            text =3D (text[:max_len] + "\n\n[Changelog truncated as it exc=
eeds {} characters; \n"
+                    "the full changelog can be found in an attachment to t=
he AUH email]".format(max_len))
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
@@ -96,13 +130,15 @@ def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx):
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


