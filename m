Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18844.1793107896998884837
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 27 Oct 2026 06:31:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=MxBaP/Yo;
 spf=pass (domain: ericsson.com, ip: 52.101.72.64, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jyte5O207L3crYrlgh+t5tTLc56FBFBa8l2nHEsc16RfOuy58Ywa5VMcHtgMGa5S5EG4ssgtlEuHTozARGt60EJVsmea3TTno2C8PmMCZognSSmJ8kvNVCU5RDlxtbTDeczxom3Le5hbeIG4bK/pdH324G2unnJZzm4btTJFXj7GBMPPbHfq1rCe+QznFIeJoYaiMYW90W4BCTGSvoREeN7km2mqtcI5ZspzaBSPYBvJTHMdxg9OiOfCy6tBafcaPONwZjZVnSi/mqeDDWw3S2DTrPd41nt2HbylIhni8Kwj4Q2u3FREv8Vu0b0wQx1CW564dc81Ed3lhunu2AX7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z6wJXZ8wSx+ItgYiRBWeFHLKrTX+IOXh/ISeEf5jNM=;
 b=hc82Om31iL9vhtC1g+iV6jNYnoVTP/PQ6v2xhgE/+qwfRMVgu9rofnMbGdmwhlzz0DEsMZ3zM0SK9De3gyLbUuJg5HLDUIbT1s/Y018CWvDBeB/lWYvsWwb5gYFvV3qGYiAVtj9LyXNn7F05TUrj1e4OcrQ5tMtjmWus36k/l5dB6GfBqZtmnMZ9KFuki5MLwTTm5ipbIj+d45QqpZPsPGzlZVlEtoy9htKq6YzUGH1t/vPya8Iw7ZMCbiB0VkfmWwHR52yBm+CfrfqD6ZQciOghYdl/9aZzL7BlRpZBjObvRI0No/7UKPF3V5wTKcB4uLyVOKnOFZgK4oZlLIfsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z6wJXZ8wSx+ItgYiRBWeFHLKrTX+IOXh/ISeEf5jNM=;
 b=MxBaP/YoMLUnHadRQ8tzUxfFlzwRHreWcjo/CgjuNdxXgCer0Eh5Wrepbr+wGwIbxstJ8+k8x28cPeXevSrza5k4MeV0s000SxgcNge64BVlnkU7SpA+X7EUY66a3utHsWoN1BSPclg/4iluoV08jDBFaeivaX9XDZbU5lwhPHMCuXtntfxQ+Qv0btYbrdvn/RGFSR9a23NkHLpBis4FnM27bF8FDUy9t23F3BzBTfz75u69wPJksPLA4i5GqwyLLZiSBaigQnysDKKg/G3n4rHs3WWr8i4KEEYmu7yOFjgC28VT2856XonXVRU9W2Usi7smzZgL03rjBVA0I+ypBQ==
Received: from VIUP296CA0126.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:350::7)
 by PAWPR07MB9276.eurprd07.prod.outlook.com (2603:10a6:102:2f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:31:31 +0000
Received: from MI3PEPF00008485.eurprd02.prod.outlook.com
 (2603:10a6:800:350:cafe::68) by VIUP296CA0126.outlook.office365.com
 (2603:10a6:800:350::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 13:31:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74) smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MI3PEPF00008485.mail.protection.outlook.com (10.167.240.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 13:31:31 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 27 Oct 2026 14:30:56 +0100
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 48511957C0;
	Tue, 27 Oct 2026 14:30:49 +0100 (CET)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 11179707231E; Tue, 27 Oct 2026 14:30:49 +0100 (CET)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v4 2/2] steps: skip changelog in commit message when devtool flags it
Date: Tue, 27 Oct 2026 14:30:43 +0100
Message-ID: <20261027133046.300849-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027133046.300849-1-daniel.turull@ericsson.com>
References: <20261027133046.300849-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: edaturu@ericsson.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008485:EE_|PAWPR07MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 255b7beb-1fb1-41fa-68f0-08df342e9cfa
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261021121427099003|261022075727099003|261022105027099003|10067099003|56012099006|261026140227099003|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: BSjL6Zzr15nQ6b+amrNJRNspcfkyyGKHa1bkgvgjCcy76vCfFaUYB4ssITtBAbJhis01+ugh+/oDKG3CZ6fo4wSwgHoGpPpJnBNmfbTBClMkf3lKG8fDr9cbYtTC0S7aQHwMA4okl0NoFEZlBvmHKR911P/swr51+JxDKcCykascXaS5mhgFusIZfS7QjSfHojSYbcmRqiJ6dSeGUfEVvklaVKs+kJDXkyyiLN5WLCisbfRNgsNMo2hVq11K22ijj3Qi43FUNuxV5eF90sHetDEybyfPmVUGUn3Q+EBzvQF3rEp54b3ubFMTnNzXWr7wCLxikP0CwhDbNt6wuhOrhkQanQVqNuYOI0ryCiEf3jjBjERgSHBqYUse7EezBw91T64r45V8+5huw9Am9dGZCd1ylJ6BDsOZiTPsjUjN/43nJQ+Cn4fgurSTdf4Aqh6SS7ycoX4rkq3yTmvsdWqx722lCXlMO1Wz+6tvXabRZk0DeshqXT7QHWmeDdeeF8tli6dMGVF2wdYsaH3fbX6hKT0rZ/r99br+cNEOxXcn0QLwGN30tXwP4tMmdu9e4f3sTDNZAUksKsphYoS3fP343kk2Cv0PUtM8FNflyk4TEejLNOUVfbWezD0vmozImii22DtpCX2L7l8/3B/HkrBREBe23nCae8HdH5Wp5WpxcCkZ6xSjDIGwK249Pi4hTNJupC0wgQ4SvRfboe+HvSyheQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hoe8KOcFB+tRDBRTMse3ZAC2WXHwVwhoHgS1DXhkEVNr0IOl1C5vXBSQNYA3Oua8rRgqWoNRfEhWQLOrIkg8c43px8vmxUj4KwS3TfwCS7cOON1TevLLGYtQ6GmCkb82mvidwWs/ai6NYDG4efY+9pDd4N3Z44C9u3682AxlfjIS6VmJN8psNA1xQRgudIFVpQGCwuycb1CnZGLsO4dfOvJKHyS5gXTpC3UNNDswpTqXvsQTTaO0tczXqTGQcT8b2+/VJLM4lxx3X1kM8EFtclxmAK7QBpIkXiS/xg5goNnGEV3yH45tFJilxiwJX0OgWITBP3vy0giDV3kAyIR9yFbz+Ssb1cX/rgMjdKan7EtgLnkEq+7/wmV6OEZBkBEI/wi6jm3MBvJBdBCl6lY4AJe3/+1d9kuNL52c1XB5dw+UIZGUtZyJD/ZJUEKNVUft
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:31:31.5809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255b7beb-1fb1-41fa-68f0-08df342e9cfa
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008485.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9276
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 27 Oct 2026 13:31:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5163
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
index a68dec4..a24674b 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -114,6 +114,10 @@ def _append_changelog_to_commit_msg(group, opts):
     for p in group['pkgs']:
         if 'changelog_text' not in p:
             continue
+        # Changelog stays attached to the email, only the commit message s=
kips it
+        if p.get('devtool_changelog_skip'):
+            I(" %s: changelog not added to commit message (RECIPE_UPGRADE_=
CHANGELOG_SKIP)" % p['PN'])
+            continue
         text =3D p['changelog_text'].strip()
         # Group recipes may share a source and produce identical changelog=
s
         # (e.g. mesa, mesa-native); skip proven duplicates, keep the rest.
