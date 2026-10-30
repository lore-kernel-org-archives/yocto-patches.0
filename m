Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8646.1793356795433428774
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 30 Oct 2026 03:39:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=U35A2yZA;
 spf=pass (domain: ericsson.com, ip: 52.101.65.59, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJJm+szixS4hy7ynz/rReVm3Li/nwrY4BGjZBtwU92mzKneIYXjkmtBqJVEPKNAyK84A7K9RjYFSKi980B7xw2XsVmxcmjIPy1tmdIjvGrPl92AxztHWzNyWoM1N0H/1D0j8R5aXztTGtk2CNlM2ecSwRJRRLe4qJl1FB5X21YqeeiI9JwM2QPapS5hX9afvOF1U9n6UNCGHrfDXJ/SC61y24p1KEua9MfysHUJZOFDxSHGlTJKOFb81cyeuvbCxblQuKNulJtUBDp1MC01wE7kxFNetj5oyQMs1/Adtp+cIU6dozg6pjKCpXJDfFsPAwqvV9m/sv3eH5Z1WXxfGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5O2bweAxY7SQfzBskyAtAemmm78lMuwL1fRfPjY+ro=;
 b=JBVUAEJNlg+CgIrrMAC2COvx2QnOt+x2KxWTfgEfiXsRmi/e6N4RTqvZfutIu+GgLJMNRMDDKYW/HK8LDBBK9it8Jsp3tB8FVyObG2/Cnsop+bM0iDhe0SRlxvlaEC4UFQwfDBdOUYMDyQsviGS2IiKni5XFRtez1SYqQy5seXyqfI7O/t6mHb0yaWdMOcP6s4sH1zJOYl5qEwAhUYI7/tkR+96Gv7V1ymY/KzIGHOIqiL9M0IKqyrLYsCHAY6dkZVcojPlS3CIOKCXSpl6ADszIeVwMpWUfcHNPD2EEtl669AipJOuhXsSgyAw2ZvQVLC58ykJVyJIZ52JnRvArMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=est.tech smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5O2bweAxY7SQfzBskyAtAemmm78lMuwL1fRfPjY+ro=;
 b=U35A2yZAioWm+QWMUBHptg2p05L2QoyTUbcF7e04+rAbgUgv1zICYCD4LMtttU8j0BFUAvA6+6s7LipDwr8V50GTyTBHdaaDkmhKtt9Ya8Z5aqfJeJsaKKuOq508O8Y33LTTNbOCkVDkKPDLa30a7HU62gFg7YwDAhmHPnySdfXbThkQAFVI1O39vVZYcWGjOG+4NSBautXjNg9fOQwFr45cy+U2vnLIxOIY1m8cc4PICRPXdTOsAy5/tbVtPHLYiExUREpO1sMp/fsQvOXxqzbnpIaF5UzXK0tW3HbYteSTnT0PbsVzn3Bj2LsJATZskgJjYl1B63y1AovmU60QxA==
Received: from DU7PR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::9) by AS2PR07MB8954.eurprd07.prod.outlook.com
 (2603:10a6:20b:551::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 10:39:50 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::15) by DU7PR01CA0034.outlook.office365.com
 (2603:10a6:10:50e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 10:39:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74) smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 30 Oct 2026 10:39:50 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 11:39:49 +0100
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 399504020B42;
	Fri, 30 Oct 2026 11:39:49 +0100 (CET)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 0D7CD707231E; Fri, 30 Oct 2026 11:39:49 +0100 (CET)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <jaipaul.cheernam@est.tech>, Daniel Turull
	<daniel.turull@ericsson.com>
Subject: [AUH][PATCH v5 2/2] steps: skip changelog in commit message when devtool flags it
Date: Fri, 30 Oct 2026 11:39:41 +0100
Message-ID: <20261030103942.2373161-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030103942.2373161-1-daniel.turull@ericsson.com>
References: <20261030103942.2373161-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|AS2PR07MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 158ed7b6-d9f6-42ef-9143-08df3672202b
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|22082099003|18002099003|56012099006|261022075727099003|10067099003|11063799006|261009223027099003|261021121427099003|261022105027099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: BOUfBab5Z3FPE249aIW4VBFY5+iBBVYTP5892LbxI3b1ge91vE00UxcaUHwJxWYU4c6VBH6Eb8avMY44OsDM9StavykA2p8MvDDuFZ6zIMTH5NVv02kWRnddws+uTKVsJdrK9FPHmMu3n4MxCd4Ig78tt9LCQjuSn+RdHS7R3dkv4bXSLAKoPNhZyE+fQwbBNVZjoZR5WaGn45YyGjivoQJbijfyy8EGrvFmQUWW4LNVsJgyFIOqNJ7bO1ptO1yDrfjyN26MTfEUZ4qmHmO+U65zYP2Fz1xa8AhGnOf1UzrabYsB7fP999iIP8bGint+p91IKvBBQtpIjqePSJ8T+FQqjtR3BgMh5wj7HNIt8aw9vgp6nZaBhIAUeMlduIVkgAJ8viwlm/rw2zrFwvZVe93hNOvWKjMqbNqAJydVAjLgx/4wdjpvh0Bl81ORRjqojFU3//i0ba73PjkrrtvnyS09snxiVExbUP2u8ViTqdyv/mVvWL/QqL7EnE/xGH9+riQAAFw6PY3J8V/n8l1DReYwIg6ADraMbctfk0kXQQpO1QWuEIt4ZShMGVtQ+lrCpktCfwLjyx+u7mo5NUI3QatVChd4vu+/pcXDTtjB3pIvWuigo1B4jAUpPAZKil86ayZvdDijibGRS9tX1AlaIRMSD8uhPy/Sz/7aNCDXgwIujy7Va0rNNhGFT14e3vJ6VHZoGmk0m7J7VsNlxDf+pw==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(261022075727099003)(10067099003)(11063799006)(261009223027099003)(261021121427099003)(261022105027099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: osLSQrnRZLMVaewSwe6DU9LPQLi8XV4tbuyAL4ep2sGTl61nQH9waXv0ot2DSPkGqSasBWaz5L03g4iJPeSdvW+0Y7I2iRoZND4EUexaBwsdr0dBX2jH8JlCFfCtGI9FcecsEspj/4RsatPFfYk4YW2zBMhNcABe7AwekPwd6sgVUdK1mlodBodmzuEE+QdguOZ+CF6xJ4Yec5kbTw6EIzD8wHnue4ZCs+jD2GIdQjCq+o9ib+70h7QxZuGbaczFKslCTlcTX2/TP15VL8B54sCkouYFPTRzgS+7wVMJD0BgaIOlqNHlk9mkov4FW6waRoa6yPatPATmNPicWLDfPLOcPK/uaEsg64I1+IKf7m0KjF7xB6kpgaJyebyq915S3vo2Ck2jh9y3HdR8iR42QR1YezAgGcBp2mI1QpaXmxpZDngIYqsKTKQABbdwNcZe
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 10:39:50.2958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158ed7b6-d9f6-42ef-9143-08df3672202b
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB8954
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 30 Oct 2026 10:39:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5189
Content-Type: text/plain; charset="utf-8"

From: Daniel Turull <daniel.turull@ericsson.com>

Some upstream changelogs are badly formed for a commit message (e.g.
mesa, gstreamer release notes, raw git log dumps) and make the upgrade
commits hard to read. 'devtool upgrade' now flags these, driven by
RECIPE_UPGRADE_CHANGELOG_SKIP in OE-Core, so honour that and leave them
out of the commit message. The changelog is still attached to the AUH
email, so the information is not lost.

This depends on the OE-Core patch "devtool: upgrade: flag badly
formed changelogs in metadata".

Assisted-by: kiro:claude-sonnet-5.5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
Changes in v5:
- Use pkg_ctx['devtool_upgrade_metadata'] from the previous patch
Changes in v4:
- Use the devtool_changelog_skip field exposed in pkg_ctx by the
  previous patch (Alexander)
Changes in v3:
- Parse the devtool metadata JSON once and keep it in
  pkg_ctx['changelog_metadata'] instead of reading it in a separate
  _changelog_skip() helper (Alexander)
- Split the _get_changelog() refactor into a separate patch
---
 modules/steps.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/modules/steps.py b/modules/steps.py
index 3da8984..9dc637f 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -106,6 +106,10 @@ def _append_changelog_to_commit_msg(group, opts):
     for p in group['pkgs']:
         if 'changelog_text' not in p:
             continue
+        # Changelog stays attached to the email, only the commit message s=
kips it
+        if p['devtool_upgrade_metadata'].get('changelog_skip'):
+            I(" %s: changelog not added to commit message (RECIPE_UPGRADE_=
CHANGELOG_SKIP)" % p['PN'])
+            continue
         text =3D p['changelog_text'].strip()
         # Group recipes may share a source and produce identical changelog=
s
         # (e.g. mesa, mesa-native); skip proven duplicates, keep the rest.
