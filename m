Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.563.1792680381863223461
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 22 Oct 2026 07:46:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=gMwcP3Q+;
 spf=pass (domain: ericsson.com, ip: 52.101.65.54, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnFEeZpqfYUjicOyJPHkHEtSkwQ+M1drufpyn7Kx/c8EFu1RWRyPKNsKmTW54WHPh9uylEv2hQ2uFpCdzDKtwBEr1fxb9OaGIsx3YCKpbLBrQcYOfz1/rupzLG4h4j+thyhqGjHCq9Hi8yOp29wvXOH8EINL4t+lgbuSHJWN8STeMdWHBwq1X8a55u4vfondxDf9SgzRfX/P1P3ThVgIG4K1a/2YJUZwj4VbqZwfVdltMM2zaHloOewse/nMTesFQVxy0WDPLER4EPjIpbi1MKZlKCEdKBwegGUYxLWKJr/GAzqsTrgw1+z0gUkQgr4QyIGva+PZE+oDVs+ErOTjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jb3oxl0KentkCc0UEdULqlYd78UyVcoaP/5244Fni00=;
 b=v66u+umhQJ+SBWCcByrWYHLqJgMUV6+4j7RoHJCX3qOZ4C+1+TgDaAQm7DI6PJjzvdfFV1k/Gmk6G1JAO1DdVCLVrRvt74YSKx7DY7i0rXpYuKYC9lJg0GF+C+Mi77C6Mrahqh+6uV1EILUgJeZf/m8a1kBrTR2B1PGMVk6D4OkEOG3jNiHkmqEVJQKOyvr48IyjCNsyNIbeXH6c1jPHgoYcRZnflCh1wKdlTiPK7nwS8iRSYaDAj6j6O7gph5mTEqkKMbY7z2RYT6v9jwghDM7xDCho+PIebn+rzaE6a5n5jrfUMhAvMyQouM5Or7PfEZPFt8HtnmHIffNmwckiLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb3oxl0KentkCc0UEdULqlYd78UyVcoaP/5244Fni00=;
 b=gMwcP3Q+/s9tIGzOuvdCtNqu9a8SctTHIu8M16wkkvDWTCr/bKabRHzSCodgZiUGx4L4XFcmJfsRCNE0ZGYsSZbX0rEVljIha4zGROe1vf05HwVCvEIBm8HwgqZMfRaM30/ubUdOwexGH0b2VvdU8JvIagr20avsOGrTPUzwLXsefX+WrYFfxKanJT6pi/qABOL7PZqq/GfmKrdbKS7jbnphSWRCRKhyMh27EVHwtoOsSXiQb7G6VVKaY4LDEakOMTHxjeEtCeOSE62Bna1Hyg7980zePbOPTdMMBffVGJjXg8p2XbWkIqE1BVpPRZaxJetds4sHwxX5uwvzMf+xtQ==
Received: from PA7P264CA0063.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2de::18)
 by BESPR07MB10784.eurprd07.prod.outlook.com (2603:10a6:b10:ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 22 Oct
 2026 14:46:16 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:102:2de:cafe::45) by PA7P264CA0063.outlook.office365.com
 (2603:10a6:102:2de::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 14:46:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74) smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 14:46:16 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 22 Oct 2026 16:46:16 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id B93A84020B44;
	Thu, 22 Oct 2026 16:45:46 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 7B12170722D0; Thu, 22 Oct 2026 16:45:46 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2] steps: skip changelog in commit message when devtool flags it
Date: Thu, 22 Oct 2026 16:45:40 +0200
Message-ID: <20261022144540.1691265-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E461:EE_|BESPR07MB10784:EE_
X-MS-Office365-Filtering-Correlation-Id: f50205ac-c011-4c2d-17b1-08df304b3a3b
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|56012099006|11063799006|261009223027099003|261021121427099003|6133799003|18002099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: Qx8z/LCigW4pfL2y5DDZJqvJpEGd31dNSt3L9yTC81Jv/OwYwrJuPBmr0TFPU6uqUWOenoRwIvma7ryssQ3r50vyCnF3SW/ERbx4szuJ0qb6xw+kUntR/b+drA37QKdmul8OP266RC8iOtd0f/zLkWHvrIV2lU+uKc7xqMtIe5WFTe/MvL8a6XIO30ZB9hCOEpWHvoQGPFaJ8QSW0iYbVHbR3wSOsn16uvEXtw8GVEikICgB9GPUJle9ZP1AKq4eeZQtAk6kMKNB5uBl45fOSt5/yAsLIFhAeC7vJhiJGnwL946uKy+H6EV6q6dN1TRQrzNdh8/YaqS3jKPF8FmLG8SO/Kc9fCLGc5fTvki4HOzGYMMQRafkqRiLxVaMhx4upwAl7gJqiy/XIGkWZulMn+/PlVB0lhxGS+vIyQhMRxh0Dq3h0osRaJAsAEU41uTAWl3bov5CVzwOjjP55ocUVNqY97qDtwhYxWAcrIw0hTezduFRGe3oLKTHv4oySqJqQtGnFkshkyW1xesBMMCmXWMCQmvH1yuqo/Ath5PMwezVcBGSbdRmA90yExmLryRBXJvEboQM8OUyphgKtREr4Ltijqmpp5o76MR4f1dQAy/Ngld9BMbQOtIugfRV73BoLY0qMI9PLawygnTRO/1mnZ8tvIxdk3YIwAyz8w88bI1z/C44+hYkk3UpCfzx1JbleKO43sg97MVhPP0vEIOiaA==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(6133799003)(18002099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y9PwW/Zv187Z1ewsosDZ2dtIjcLWavpE4oT8TSBoWR3H1Ip+YOenAznKbkxBzh6Eg1AK/mfF4MyIAyFDLtk+MR0HSMhIZtFMwiqDSJkgFddXnSRJbqFpHGnMZOf/2xlZnlH65bB5aKQLeNKj08bIICWK7IEj8H1QHTy2jN6oiAcUIYbCFLi+d6A7PPwVUabvbAL7rouuZ/WOn2wf8KeBaczqMeQaJbRVnpr4N1Ye3JOMo3B4brRYswi7k1GxrVB2J/KESXKPHow5L8rybJvBUsbnAfKmufz0fPAicGFlwvryVH/OJb2EFkYNDyZkblFboRK0jlHRGsob33Ce69M9QPHaMTnT6+h1L7l2nAqbDtvlbGsVLc85U2psnhKa5Tob8yo5dcl3M7pru/yUiujP77/w4Xkfm/u9+xvA1UJyLcCW/RMxxiKVNR8u8vjXBtgI
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:46:16.6818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f50205ac-c011-4c2d-17b1-08df304b3a3b
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB10784
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 22 Oct 2026 14:46:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5135
Content-Type: text/plain; charset="utf-8"

From: Daniel Turull <daniel.turull@ericsson.com>

Some upstream changelogs are badly formed for a commit message (e.g.
mesa, gstreamer release notes, raw git log dumps). 'devtool upgrade'
now marks these with "changelog_skip": true in
workspace/changelogs/<pn>.json, driven by RECIPE_UPGRADE_CHANGELOG_SKIP
in OE-Core.

Read that flag and leave the changelog out of the commit message for
flagged recipes. The changelog is still attached to the AUH email.
A missing key or metadata file means no skip, so behaviour with older
devtool is unchanged.

This depends on the OE-Core patch "devtool: upgrade: flag badly
formed changelogs in metadata".

Assisted-by: kiro:claude-opus-5.5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/modules/steps.py b/modules/steps.py
index e678a4b..57953db 100644
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
@@ -96,12 +97,28 @@ def _get_changelog(pn, workdir):
     return None
=20
=20
+def _changelog_skip(pn):
+    """Return True if devtool flagged the changelog of pn as badly formed
+    for a commit message (RECIPE_UPGRADE_CHANGELOG_SKIP in oe-core)."""
+    metadata_path =3D os.path.join(os.environ.get('BUILDDIR', ''),
+                                 'workspace', 'changelogs', '{}.json'.form=
at(pn))
+    try:
+        with open(metadata_path, 'r', encoding=3D'utf-8') as f:
+            return bool(json.load(f).get('changelog_skip', False))
+    except (OSError, ValueError):
+        return False
+
+
 def _append_changelog_to_commit_msg(group, opts):
     max_len =3D int(opts['changelog_max_len'])
     seen =3D set()
     for p in group['pkgs']:
         if 'changelog_text' not in p:
             continue
+        # Changelog stays attached to the email, only the commit message s=
kips it
+        if p.get('changelog_skip'):
+            I(" %s: changelog not added to commit message (RECIPE_UPGRADE_=
CHANGELOG_SKIP)" % p['PN'])
+            continue
         text =3D p['changelog_text'].strip()
         # Group recipes may share a source and produce identical changelog=
s
         # (e.g. mesa, mesa-native); skip proven duplicates, keep the rest.
@@ -122,6 +139,7 @@ def _devtool_upgrade(devtool, bb, git, opts, pkg_ctx, w=
orkdir):
         changelog_text =3D _get_changelog(pkg_ctx['PN'], workdir)
         if changelog_text:
             pkg_ctx['changelog_text'] =3D changelog_text
+            pkg_ctx['changelog_skip'] =3D _changelog_skip(pkg_ctx['PN'])
         # If devtool failed to rebase patches, it does not fail, but we sh=
ould
         if 'conflict' in devtool_output:
             raise DevtoolError("Running 'devtool upgrade' for recipe %s fa=
iled." %(pkg_ctx['PN']), devtool_output)
