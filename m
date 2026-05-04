Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6067ACD3436
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:36:33 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9182.1777876589952577506
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 03 May 2026 23:36:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=t0D6qjLx;
 spf=pass (domain: ericsson.com, ip: 40.107.159.40, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBWCHnCcwUXkLMZ98PWpMVqWkstuUgYYSnlVRdJog54t6mwRCqF/ZCvsxqEVRhgoil7ahmHf0rR1EUNv5be0aQ4K2ZlQfX5Y5W31v3xNbQSPDE4J8fTr49XlCDSK/SPEB5knpsJ5kV6UUlWD47kdUWcKM3LiZz+I1RsfU3bTVt2sMZugiYStxIMRqFaiMD5ojMV5sEHRzFkdcKBq3Dxwh4egJ/FPnI8ou85PWzAm4FUwlheHAFKBdtc7CkYwGcDcY3wRjOBSvQOsMLVQFKbct19gnmR67KdhQOB4CaxsgMcSMVGAFuuKIl3HwnTdgjf6wci7JwVNg7mpjDUKUXHhAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU5Md78VTt7spqNceUUA7shWNsWLtZs7j9duyWE7ZVM=;
 b=XRTpZQxNVWqSrAB1oy7FNbugE8b2BgoyZA6sa/s3y9TncfO9YhM9J+fMROTc56EJwt9HT6jwJfM7W8kqsgJx/CUPDdvzG/ARhpP3Qnh3aA5WcW4xz29GxIvp7bpLizF3/AIN2fkSKTRmwnn4o2cJeA73UMwPDQf4DykMbQgpR6cVx7vbTEJRUD7Pm7ihlRHqI7zAjnayiMxVs7Ju3W7In2P0lhAJC8sOycwo7qQMt7DD5807l1BLZ7UIQnHjNF/1wJfeaxiPoqQZEeMe1IIhF1F8FWFas7Ki5AQw9cFPCqefaFivskufpY+zj7X0SUMVkR30j0k4H4qnt/j3kqnbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU5Md78VTt7spqNceUUA7shWNsWLtZs7j9duyWE7ZVM=;
 b=t0D6qjLx3En/Io/9Njrcy2lvJ/zrnOhhmnKg1ZIR+hsAnDRlRRgevBdacW2fGxGbFJZ+xXOtBfbuQ26zB9w9gxjGoDt18MOnt83OKmBqBCfjCv3bL9J/T7E2RtB4db+xV9IRC3M4WkuMPo5VX3EpbRL3EDM+D8CcdtKFAEH13/phslAlf0DtuFnO5/F3kjwERVxWHNPPT6Gw4mmZ7n6nXtGnpAIcw6b6AxZGlld6Kiu8Cy0nevWPCnk1SiGTekX0xAxgF9Z3uzXMdOoiESyxRNYybjKgdy2blRKni1F9k4edlaEqv9gZRdCST5aMSDmEwcEnBmECPf14+a40ezJ4Xg==
Received: from DUZPR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::27) by AMBPR07MB11787.eurprd07.prod.outlook.com
 (2603:10a6:20b:72f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 06:36:26 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::4) by DUZPR01CA0115.outlook.office365.com
 (2603:10a6:10:4bc::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 06:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 06:36:26 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 4 May 2026 08:36:23 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id BF2844020673;
	Mon,  4 May 2026 08:36:22 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id AB4A5700DB92; Mon,  4 May 2026 08:36:22 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>
Subject: [AUH][PATCH v3 1/4] steps.py: resolve symlinks in recipe_dir
Date: Mon, 4 May 2026 08:36:09 +0200
Message-ID: <20260504063614.3831203-2-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504063614.3831203-1-daniel.turull@ericsson.com>
References: <20260504063614.3831203-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|AMBPR07MB11787:EE_
X-MS-Office365-Filtering-Correlation-Id: cc916e98-4f24-42af-6be0-08dea9a77779
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	thDpfofB3kjpqdlAiTOxkzkB1bweX4+5qAJ0GgVAiYf7lU3DZwSr1cyMPT6upKez8TdA/cRAaifFppNrSiiB98GM0CSYJ0D0aaxB1h2cs0aPY9ZthL5yc7C9q8PyZ1W2XBV1gqkE7d+e9GFdrRx8/DCY/5nxmb6jwrsNKrETknNo/bXPsCl/hBsoP7f6VtLk1SuojEX92hAglDTAcKaD2Zg3lqcWpFvtVtia03/PEn3ttddAzOAI5BAuI2iKqcqAPqgc+LkFzS3zpBgUGWudB7iLaToTfSBM7349mTeDWF2/Z/t3dKjGcMCvGZfhhtzYFhvMGikmtqsC+dkh6AWhkIR22fGH1hMKj0i2/MwSj4l0QmIgYa3XsMq/jwwbjy1EUi5Jq4uAv1WnhOZAmIdsj8gISgSltp2jiZduKiZ/06igvw9QjV8HhSLKOgwKPzLEDcJ+PO6hc4cGpEQwJxe2z/KafYoezm6ZmlDxffPOOr7puA4o+5ezL3K34WlqYI5oKAoEVOTHlNmvJApDM5yyRurawO7RhyOWcz0WaP234CvxNWDe7j9FifBtVVgqJHnYe5jkC/nI+8Tc7jLClNjGftmTuLSW9Muw//1jjZpEutE/5APMGbBUm/nr1IU7Qh/9ViiSVHb2ZeAseiQ5zP5h2GgpS8VTQfMsUSg4hu9/rlmc57IdhI4sO6A183/p4kbF/IFeaMOu4NUCRonxbyQHGjgiBHA/9OYzxVBFOXzqxrg=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9xr1Gd6Qjg5VBgVyHAqUhhUEt/WomZcBLuREZhSY7IlCuklhnSgWN6/3o0FYj76rMmYLG/t7mm1APLcdBjg+jpFaMuzKtJBpg4aXbY2HXFqcwHd50fgKrzmoiN/3MDCBRxQslaQD7YnLJnO5uY2YWcbvVs3rvwKEDnAwvsPVS5B6yiE15fee6D2AhoqtxhEPK/Os6xRvQk45DTBj0VaiqSTBdB5laanHYxMhWFe2eNgH1w+ZQ2GDYaCHs9Q5Idola7cTxNp9RWZzflK4l+kVqeyIjs0sWwF2rzj3R+bVy8Okw9A0ymrimOA4rMTQpCoTxAIYJchzeQH5NPs6kzKTNwR+SzkniiDTLbqSa2C2yZcuXymt8PaxFI1dpyyTYU81+wx5SruinjVurn4Z/rMGY+PmwjxSyfvOYQSkPDEYZT3N2VC/tVY5tUqgYH5ZR3JP
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 06:36:26.1483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc916e98-4f24-42af-6be0-08dea9a77779
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11787
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 06:36:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3898

From: Daniel Turull <daniel.turull@ericsson.com>

Use os.path.realpath() on recipe_dir so that git operations work
when bblayers.conf references layers through symlinks (e.g.
meta -> openembedded-core/meta). Without this, git add fails
because the symlinked path is outside the git repo.

Assisted-by: kiro:claude-opus-4.6
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules/steps.py b/modules/steps.py
index a6ec341..b3ec61c 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -36,7 +36,7 @@ def load_env(devtool, bb, git, opts, group):
     os.mkdir(group['workdir'])
     for pkg_ctx in group['pkgs']:
         pkg_ctx['env'] =3D bb.env(pkg_ctx['PN'])
-        pkg_ctx['recipe_dir'] =3D os.path.dirname(pkg_ctx['env']['FILE'])
+        pkg_ctx['recipe_dir'] =3D os.path.realpath(os.path.dirname(pkg_ctx=
['env']['FILE']))
=20
 def buildhistory_init(devtool, bb, git, opts, group):
     if not opts['buildhistory']:
--=20
2.34.1


