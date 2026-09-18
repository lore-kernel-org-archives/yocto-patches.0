Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDB0C982DA
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 12:04:01 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9531.1789733034790786066
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Sep 2026 05:03:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=Uot0iXQK;
 spf=pass (domain: ericsson.com, ip: 52.101.83.58, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/G/q7f1QNPEWklUMRvGQK/TFS43oDgoRIhHl+lmSTnkRwDsckM0VPN+mCoMgk46cj150Uf+SYVQDwt+tBPwnDnC0FrQfUZxAHzcEoTIRWlAnhdslsgFjn3d2Ur65kPSDvqOp5M/LJsKwD3IW8ZnIwi9aSgKV7BBr7a3pqhoxmuPZRTlk6TIKwUT8/zlwgfiTX5Tpc8Bu5ZXJ1t8tVfTyeMm1mgVYwWk6aoFkE3dcqMeOzHUch7b302BVcITYRqikawcs3ps4v/5+XCEAp/bTAvHu2XCOOB4kJ9tp6Uw2WW8ykqpcsroAg9Glb8YZoapFxtfjDZTHcLEfbijXEVjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIQ9NtFiRqzwftiJC47+oUzioO2A+TGl8QszoJa/7S8=;
 b=J/BdJndP6TMQ609mQbbNe1gahQJcr/ehzwzVweJKQGb8CPf3z3BR3yI0A7imH2WP0I764hf7KhyV308fdcb1tXgde7FflnCiFLO5LZZXQqAEcg/nSFBF4EBTMjIIAAEJ6BbPOcUDro2M2MVur8V6jXX3hZ3lfKLA5UyaxN8PsyP41w65e3qi7qhI/qgxR0wRFg1NOv5hNekrMlA4YSiZdGR4icI8ndTkBXfxZZsLXIiGYmrGiwNk290OtQlRVuQy/u6ZTd6/AhRtHUH6Spzu2cdM/q/gsIy12rhu75WJMoZiPhlpfw/dcwRgMbotrXVPPbK3yKtLtj4L+maXnE36Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIQ9NtFiRqzwftiJC47+oUzioO2A+TGl8QszoJa/7S8=;
 b=Uot0iXQKb2DEXakZW10n7a8d+nRPYYd7S8P0lFLDh4E2b5YVq4UYjwbepGdn069ldpYvuLWHxCxiOEJXOD+sxRNzRLyxPcK05K0Xji5IquFxPgyCKCRCeafDkiOZ3XR8FIxjcSv/oCL+SYoUB9Xm3tZLmxc2TJ2xQxY5sqVBnyN0QFGYGltZNjDymfSSXrmWKJsgNvzSw6b18vpxeWAbKGTnuK+FVP0gnsAeCNHzAg8ge5UcQRJOYWnJjWuQ6d+o9BShoXgHvrelcgwSpuH94lnhOojhdcHbwW0arDHYsKL5Dew6mATwW7mbUqvp8L3RaA8ZmEsdd2QyqjLFjwKJiQ==
Received: from DU7P250CA0013.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::27)
 by VI1PR0701MB6927.eurprd07.prod.outlook.com (2603:10a6:800:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 12:03:49 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:54f:cafe::7) by DU7P250CA0013.outlook.office365.com
 (2603:10a6:10:54f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 12:03:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Fri, 18 Sep 2026 12:03:49 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 18 Sep 2026 14:03:48 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id C68F74020AAE;
	Fri, 18 Sep 2026 14:03:47 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 91D86700CF27; Fri, 18 Sep 2026 14:03:47 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [auh][PATCH 2/4] steps: skip duplicate changelog for shared-source variants
Date: Fri, 18 Sep 2026 14:03:34 +0200
Message-ID: <20260918120342.772566-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918120342.772566-1-daniel.turull@ericsson.com>
References: <20260918120342.772566-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|VI1PR0701MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0783558b-ce7a-4fca-68a1-08df157ce632
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|56012099006|11063799006|3023799007|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	mFbol26p+Ozq0uxdQATlKrNNQBs9YUivKusGe9Re1veD6zEqB0xVl2oritgD/GGtwu/SeUiHJTGDL2r/lTlgejB0wIAo0rA/N2blPCIAaUEa2+3pEplV6pUJbc+CElR3OW7LU6zQplhKalGXUbkCBK3FE5JhEj00jL7PPwqZ/oMs/osVxFZd1qUY8fAl+tIePqn1PaLnsDlq+eMbjCrVuZijENvKhCyOCLmcbpszZ1SyjLny7pGqCtRiqONvH3bJSrrhuBbJ41H3UIRSPV/tl8G9JmzxfHFCq39oDd9c6/mIvvoJfXvfsWqxrTQc+SWT9hwr5FxWP0r05WYURS30QAf/pC7q8hZQCnixBuq8WKevTrQ8G8UX+5vGeBMTa5wSHuvV6SDJd+lqEILR5DgECex3TVBYi1I5unwreLmHe0gai3wf/K5+wPs9ehLKwgiGiYHwzIibK4Ej5LVMxYjgIy1Xuaz8yKG5DElNxAVbE/OU81707yr48HP3PY1hygwFcFN3GItYPWz4uEBxAGrtVr/a8FJhR8uS+C0JOicOqoPbptrrukvipbEaXOBUaS9EQxUB7nQH0RtgNBOPt0piBHN9v3eILE4jIUXOt3xU4t1qhvRa3vanQz9Y0nPU4otfslaFrQd/wcRgcjnCUnDZiibXNJ11BKGaxbV5i4kfWxgGamPj9hhDoJoflYMz95RMUaDRdyfNSAKPDqFt0wEESQ==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	VVae+Y5X4mVJdi4yA7Fdnu5llX0XUyCiLAMS88DlSYy/eYVIG99pMlRAlm6rrHoPd/QHL2HKo5PaVozeRqO5svm7OHI6jskByCDaj6ojGhaghXxMyHrGYg20mSSlWd9EH5qcdODombF/B+bFfBpDhRlnD/P/aIPvuRcQUeMbF+rblEkgBNYyfU2TIyjd3nGqY7pwdUJiWqyy1NblwqXNL7iV0+qF2T9aGIpMl+1Yr/Nj5xIO+LhXeotPaflxUbFbwyJ8IaCcfqCLu57opvLSNgpqv+f3J/NZ3hOmCng4PPv+KxgoGgfRN+l+KvOYHHJQP689gZf2fhdA1MdB6NkYea10nMnotUZWolkcFYGx/A+fxc1iFsqUOB6AdX1W+GHN/dBPFFB9/uKTbHLJU3Ib4fg3XHmqhiD8PW6MNNTGgt6hOfdu8y0cMZas8Fmv0ACi
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 12:03:49.1223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0783558b-ce7a-4fca-68a1-08df157ce632
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6927
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Sep 2026 12:04:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4905

From: Daniel Turull <daniel.turull@ericsson.com>

- Recipe groups sharing one upstream source (e.g. mesa, mesa-native,
  mesa-tools-native) ran 'devtool upgrade' once per variant, each
  re-extracting the same changelog and appending it to the group
  commit message, duplicating it once per variant.
- Only fetch/attach the changelog for the first pkg in the group;
  -native/-tools-native variants still get upgraded but no longer
  duplicate the changelog text.

Assisted-by: kiro:claude-sonnet-5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index 20a213a..b95472d 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -110,14 +110,18 @@ def _append_changelog_to_commit_msg(group, opts):
         group['commit_msg'] +=3D "\n\n" + text
=20
=20
-def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx, workdir):
+def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx, workdir, want_change=
log):
     try:
         devtool_output =3D devtool.upgrade(pkg_ctx['PN'], pkg_ctx['NPV'], =
pkg_ctx['NSRCREV'])
         D(" 'devtool upgrade' printed:\n%s" %(devtool_output))
-        # Copy changelog before checking for conflicts =E2=80=94 it's usef=
ul even on failure
-        changelog_text =3D _get_changelog(pkg_ctx['PN'], workdir)
-        if changelog_text:
-            pkg_ctx['changelog_text'] =3D changelog_text
+        # Copy changelog before checking for conflicts =E2=80=94 it's usef=
ul even on failure.
+        # Only for the first pkg in the group: -native/-tools-native varia=
nts share
+        # the same upstream source, so their changelog is identical and wo=
uld
+        # otherwise be duplicated into the commit message once per variant=
.
+        if want_changelog:
+            changelog_text =3D _get_changelog(pkg_ctx['PN'], workdir)
+            if changelog_text:
+                pkg_ctx['changelog_text'] =3D changelog_text
         # If devtool failed to rebase patches, it does not fail, but we sh=
ould
         if 'conflict' in devtool_output:
             raise DevtoolError("Running 'devtool upgrade' for recipe %s fa=
iled." %(pkg_ctx['PN']), devtool_output)
@@ -136,8 +140,8 @@ def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx, w=
orkdir):
=20
=20
 def devtool_upgrade(devtool, bb, git, opts, group):
-    for p in group['pkgs']:
-        _devtool_upgrade(devtool, bb, git, opts, p, group['workdir'])
+    for i, p in enumerate(group['pkgs']):
+        _devtool_upgrade(devtool, bb, git, opts, p, group['workdir'], i =
=3D=3D 0)
     _append_changelog_to_commit_msg(group, opts)
=20
=20

