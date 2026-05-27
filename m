Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC3FCD5BD0
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 18:40:00 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27653.1779907193142643359
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 27 May 2026 11:39:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=nmwpt67S;
 spf=pass (domain: ericsson.com, ip: 40.107.159.53, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3oOUknNLEDJkwEDGsqWZWHKYSu2NJOUe+y+QmwWcWMx5+aF4ujmbv4YakRNHQKtF99bVh06SMSecKTke+L1qhoJ0zHUehcxr02P8+GarcGJJtakltzGYwmrPL3tNm/VK+p752fEPCdiHREqc/NLJqPKjrd4DmhatGu1NdRKYmD04hRRNSpKvwjrBpA9r6cc87JjqQJhPRZitjYHS5Iv6ZfrbmFWjNZCzKlNtbhxWevXCw1LTCY0pKYskJHiHkR0o0I/9bRbf+9+w5Hf/SIRhsN8WWfbtIqhCnNGjQaY3wRZ8QveTC6O9vaW3QPpUkl/Y3s/tPDzIk+uWTgQWUrmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS8HMLcWNekUDdMO7ELwCtlnUe7XiIWDrRTv7wpan8Y=;
 b=b9itHBnQxqCAwQOklNGh8V3HJXsz14yGMMJOVfwGnJWc+P2+MUfTxRaQYqc7PFubRPOLepH1R21nocARGH5o4sAxt4+7yRiJQuI6jBjnuxcW6Fg4P9wPVoM8Br3WXect+jtal+IHYvY/5qvOJHlhfTNLxg3Fyk1UFcL4Wutb6dzHndanJ4na9waNAOmShVodyPxatQnSfl+HCLLmAEtdPZcdd/VyT53e5GVd+UByFjPbieOD37K0dnFRnTv9UIrS0CellogQhr8d1/+Yr62zFuyAFks5QEOhllqG6isEvXcTSb92YfNvHuwiSNxz1khvMDckPJ46GtJt036fwteCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS8HMLcWNekUDdMO7ELwCtlnUe7XiIWDrRTv7wpan8Y=;
 b=nmwpt67SNfgbepygevPzi0+HqLPaVXUsqoKUVmjTqogn6HZ8qjH5kGJ4JGyvxxZjc3w0RN1LdO2TlumkErwRXJtB9wzIbRKbWe0ILHcX+/LxSBA7tWh+Cnrcs2jwhol5tiYD4lOeMcReNvqgApH5uMnfX98VrDysffARUZKXp+yVGOtt8chQu2RtUgMouFmGFz04Sd5yiY8qolFSVJfZJSmsvMPjErLXwq0gNShqp45L3DSqjduMiKbHOIit72b7uK1hv7rFsCm9LJOTeWCsstdM7DoXs1RoMeyAE0zET3EIcQO6amwspFKkI5rUarIVqoekKs3+osyurlgQWgsKVw==
Received: from DU2PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:10:3b::33)
 by BESPR07MB10609.eurprd07.prod.outlook.com (2603:10a6:b10:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 18:39:48 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::8d) by DU2PR04CA0028.outlook.office365.com
 (2603:10a6:10:3b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 18:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 27 May 2026 18:39:47 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.69) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 27 May 2026 20:39:47 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 60E66427CC6C;
	Wed, 27 May 2026 14:48:30 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 43D7A7003739; Wed, 27 May 2026 14:48:30 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <Qi.Chen@windriver.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [AUH] [PATCH v3 1/2] git: use temp file for commit message to avoid shell escaping issues
Date: Wed, 27 May 2026 14:48:24 +0200
Message-ID: <20260527124827.2486471-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|BESPR07MB10609:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e72f6ab-4892-406b-3b94-08debc1f547a
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	k4vInM+aQjEFfNVyLD0QSXeRY7whlMN/qgMO591Ecrq64qNCt3kLGhSiAUThYzuezE6Vm1boOwzgYuIqwUHeQeUOHpVqDBLrRLYfpRewIve2yi8jUG0wtbFHj9IKEajuJFkLt1McQhC4zOmd4qRA56n9QRQ2NxoOhQ3/cNG4eiyke3Sn5IniyitwNNM/Ljk4sg7g8hPORNLjdMIK1C8zE3ZHPHGPGJdHr44FClu+PlOGc3Z8Oe50+YQLNJMlV929ETFdfvwA+qSMPt/QNUM1VGYxVgBl36PpHf9QmwgniPEkxKVuUuoJFiOVPK8Qbx+bYflVWvS9wFicv0tiHYw4hs+Eq166d3HHwBYoqBVjAEo//eN5AJYIXWibDOM51q24fm5tcy5h2izy66wL8Ty0kfDGzGeMPxwQnZzNa+GrULTl1uBAVuy7NGR1FsbsE/Nb2+A2yKS9/pMcY/fuBNURwhkI1aUda68pSQWgunbRTB2OClutaDP1hANejGlpyYr0k90PmTCMnqM9IiwG17WK+J9iQ5Tt1QN25d5K7nWVJD0Zj4rqLq++BCtNiYY3ruI1gsUOEn1tRgzlxR+6MaqHbYtHrNTGWmgJO0i1Osc3dvgzn8axf14WHCmIM5ncxhHTO65rZzYIzouye91hZRRdYCGkcovLptY0xkqI8ESuQPg9R1p3O+zBMKoswPNayeE/bFLFiETSByoNrkO9YE3SpEgdee3pQpbt3XxBpG22aJo=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	tIeyHU80cYNXDSAjJQr+XNEeQEkz9ap9JzMJ3RtAMC4JXfgyndguaJhn8sI3ufDRhvmaB1jzzzsKaBKfeWtDhzG2hGMa0OqKTBRZQK5MqWHXWxbZNK4hkRMs5mKPFwzTW2MVnalkYA59B5DVTWqGvQ//rb+5gmq7yzhFcdF/lqkaLJGNs7qVaJxZYAa/ZyC59iu0kPOlZG24sQeq82qj0qc6u0sbG2h69Pku5f0TnKxwxyCa4AU6Ba86sd+unqOaSeT5FpX2VCklarWNg131ijTyxOaV0q7XDnFdZf9XZ9uX4+E4d3d33sUMyrBvBzBMhv9IGp9jUCJwUV++iHSnXlV+wUA+f2DzU1OxbGJIVpmtAtBetIddac7qJ5yEKb93mnxBgv1X3Mr+ayP4IPTDSsZ8rmqr100/97ANQOCxbn7sciue+zsP1i9jFTIArNh6
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 18:39:47.9738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e72f6ab-4892-406b-3b94-08debc1f547a
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB10609
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 27 May 2026 18:40:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4077

From: Daniel Turull <daniel.turull@ericsson.com>

Passing the commit message via -m "..." interpolates it directly into
a shell command, causing a syntax error when the message contains special
characters such as backticks, double quotes, or shell metacharacters.

Use a temporary file with -F instead, which bypasses shell interpretation
entirely.

AI-Generated: kiro with claude-opus-4.6 model
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
v2: simplify generation of temporal file
---
 modules/utils/git.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index b383049..f86c141 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -24,6 +24,7 @@
 #
=20
 import os
+import tempfile
=20
 from utils.bitbake import bb
 from errors import Error
@@ -54,10 +55,13 @@ class Git(object):
         return self._cmd("add " + src)
=20
     def commit(self, commit_message, author=3DNone):
-        if author is None:
-            return self._cmd("commit -a -s -m \"" + commit_message + "\"")
-        else:
-            return self._cmd("commit -a --author=3D\"" + author + "\" -m \=
"" + commit_message + "\"")
+        with tempfile.NamedTemporaryFile(mode=3D'w', suffix=3D'.txt') as f=
:
+            f.write(commit_message)
+            f.flush()
+            if author is None:
+                return self._cmd("commit -a -s -F " + f.name)
+            else:
+                return self._cmd("commit -a --author=3D\"" + author + "\" =
-F " + f.name)
=20
     def revert(self, commit):
         return self._cmd("revert --no-edit " + commit)
--=20
2.34.1


