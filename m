Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43281.1793022870284719610
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Oct 2026 06:54:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=oLMOTL7x;
 spf=pass (domain: ericsson.com, ip: 40.107.162.41, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLltQFFrAq6GaVVBJSfljf3vI0Y1edkfAidqqsYialiuSSiWim2Hx+zlgL0UXncTTYNuJWtM8F/zlRHYREDN84f0AvTQj8CKO/PLpyszHYpUV4xQ9FCJRjV5TzP+382X+I3Zf6a6UCQtoUNEbP7CZFu0/wJOXm4LEbDgm9Ppb0EREwPGuTjyZgWM8gyUX7yY32fi7PKLgo1WRbU2ttT9rh/r0Crkk+s7wu/ys1cy4hNTbAEtULZeJLBdygjm7yGoXCXvsSJeuhIIYGrgITAkf2pCnmdw2EtIb4r/xu7FtDQa1K7BI8VENRSOgB+DmZsPdTyKyzN/wfTxqFDLYm/L5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCsGB51bKZhE1Kl1RcDXtzH0aXbWayu+JjF9uiabVGQ=;
 b=STotp0VnQHtiS+AyDenOMFYBjrdwOT4hserYYOl+IN/ICI6ChZu0eJXlbnvCNaU/mammib1rVLsw64IWM2dZxj/VD5iX5EGuxX9BnmMkbVqgmhAfIVttTIZNc4JXp65EIec/5Mqwn8DWHjeoyRg5PVLx5bnwCDEA84Pt2LvA3doOWzVzo/qe3d+nhrAjtcEdrYs5OpIfe3dqBPCcKu8ZjsnVag10XASDgsNiHzKs51PIXfkS76cIPYnOx+/AR8tt47RGl3bG8UopQsQZiG8FyqlH7kjQUVBK0wep5ZD95wZL2jxjEZYpRkNqVGnNFcBqfIMnHIwSUUUIObcGI9VVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCsGB51bKZhE1Kl1RcDXtzH0aXbWayu+JjF9uiabVGQ=;
 b=oLMOTL7xRgJKTyvcEaCCq1NrorFtD7VmPIATBKfgNZd3e40+B9eHA0Dd5W0/IM6uvMUJe3M9Kyn9wIBAwAzA1EdFMLBCI7hN7zJP7IR2bglMjqCL61mGoB16V9uViKzqgF4BQvzk03MX556uFsYyNUSINyxqR9lfbkxozoMricmJxVbDKt+Cm02tXGNcUWSe4YqzUrNqxBf/1+gpH3Q31SRc2dyJjSTQKBFxvmzjFgTzSgJAR9itwOshW4k3kduyYoIzlCc5EPReo3RMpNBdQLvTXn1/EZlnIS4xNpXJWBipzzTpEkT17Rm91ma/PgeAOV1MjsVXdPFEHT9QrsQHsA==
Received: from ZRAP278CA0016.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::26)
 by AS8PR07MB8374.eurprd07.prod.outlook.com (2603:10a6:20b:445::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:54:23 +0000
Received: from ZR1PEPF0000E6B2.eurprd05.prod.outlook.com
 (2603:10a6:910:10:cafe::73) by ZRAP278CA0016.outlook.office365.com
 (2603:10a6:910:10::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 ZR1PEPF0000E6B2.mail.protection.outlook.com (10.167.241.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:54:22 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 26 Oct 2026 14:54:21 +0100
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 81D5395805;
	Mon, 26 Oct 2026 14:54:21 +0100 (CET)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 51ADE7072401; Mon, 26 Oct 2026 14:54:21 +0100 (CET)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v3 1/2] steps: refactor _get_changelog to update pkg_ctx
Date: Mon, 26 Oct 2026 14:54:11 +0100
Message-ID: <20261026135414.3796371-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B2:EE_|AS8PR07MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 182eb4b9-93fe-4255-29a2-08df3368a39b
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261021121427099003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 0OVcIA0EfN9Ve1cE/VMrcRisZd+2pE8OQYoousD30GQ73u/c9874FXEKoAd/PezxSCCfgNbdJWGyfKg+hKAumHw1Rs2DJpTTrboq+xOJytAlDuiOYsq0xzCdPuWBYUxjg4ChjpUy407lcp7dnlIQ4uzt9EneS/uGErvGpxXcuMreG3+Yy4B+kXB36n8o3jHg7mbdXHOp2NBRRjPUP2o7bv0SpCWvVZZkn2XMMPAP5EUYN6wruCiD9IAhu19FcxxpA8K8o71NOnxV5tXj60nB3//9fkXS5IEJBsox9lL3FfxY57MZSG/rMvxZc4jzeRNncIymsemvWyDpI62EsprXQ75SnVEAlxxJct22nEnYlCfpGQaztbLQj54ke+Vs7PYRaHKi35l4UkIZwB6ws/St3Ve1ZxYkWksXUIuQY/IIkS4D+E0sirxNhtlE65SgSsJgchQ68dPoznKd+waKDUQjyJoPcBgS7m9LE9qjMF0MrNKuKPLNGe5G9OY2ICHoBY8Zyipx5DybitH+9CahvYH5XqSkQZeXSoopDTLoSYg7NC9QVz/EzJ3VBY7YLjdYI3W3xJCiKi/IKm6fcqP6r0QyuMiIUqnRJoLSc1Q/ZfqO9ZqWTRQt+bXPF7C2dW2nDl+ca8BHp77jdzFoxR5yzDCmfH0p/ab/Q5rAN2hYrCAIiJtmBBfMngrabOGwRzMw38hJ5rX/GehX2hNZZOhgJ0ADmg==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261021121427099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DlZiynhM814PO2hLG8sD6Pyx4J/aZj3LA0HIzpONzrGQWcEErpY2KRX8K8CWUwzwcXhMPsxdLV1kW90sO17zGfy4Ywtr2Sedd6PsWv0qASSrW7E6lA3zpcDOJC6Ukq1Xf9ZpErtZpELIKbqKD3HkTpoFn/e9byRMjDjMKcwYGcCq0NvpJS6tv5W61Jht9RL17AcalGxW3w5Ajo45V4Uz3VV/G7gUxeG7Vprgg2/x4et7DiKmJHdJS2vXTdgFl7gYoVlEsYDuqPA6XUgaRnsUDQE/GOFFNcugRQN3xs2ibXd8Ekzcc4d4Nju29Np77GD+JwO12GsLi5yQ66OEQpAZNy019OBk/Xl/C1bOxKJxnJdVEfj9f+5k3I46crmNKGZHtTNMYjnTnsbyYWRbXvJteIX2G/JQ0Dy58H66NRAxZU2rSlfpE7fg4IJE6DY7frh+
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:54:22.3660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182eb4b9-93fe-4255-29a2-08df3368a39b
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8374
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Oct 2026 13:54:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5158

From: Daniel Turull <daniel.turull@ericsson.com>

Keep the handling of devtool's changelog output in one place instead
of splitting it between _get_changelog() and its caller.

No functional change.

Assisted-by: kiro:claude-sonnet-5.5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
Changes in v3:
- New patch: refactor split out of "steps: skip changelog in commit
  message when devtool flags it"
---
 modules/steps.py | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index e678a4b..0dc365c 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -80,20 +80,23 @@ def _make_commit_msg(group):
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
+def _get_changelog(pkg_ctx, workdir):
+    """Copy the changelog generated by devtool upgrade to workdir and
+    store the changelog data in pkg_ctx."""
+    pn =3D pkg_ctx['PN']
+    base_path =3D os.path.join(os.environ.get('BUILDDIR', ''),
+                             'workspace', 'changelogs', pn)
+    changelog_path =3D base_path + '.txt'
     if os.path.isfile(changelog_path):
         try:
             with open(changelog_path, 'r', encoding=3D'utf-8', errors=3D'r=
eplace') as f:
                 text =3D f.read()
             shutil.copy2(changelog_path, os.path.join(workdir, '{}-changel=
og.txt'.format(pn)))
-            return text
         except OSError as e:
             W('Failed to copy changelog for {}: {}'.format(pn, e))
-    return None
+            return
+        if text:
+            pkg_ctx['changelog_text'] =3D text
=20
=20
 def _append_changelog_to_commit_msg(group, opts):
@@ -119,9 +122,7 @@ def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx, w=
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
