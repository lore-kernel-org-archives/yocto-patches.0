Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166BC98307
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 08:55:43 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2659.1790153741717837698
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Sep 2026 01:55:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=mdoyzikk;
 spf=pass (domain: ericsson.com, ip: 40.107.162.21, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1pujZW4FPZvwQXsWuSJ9gJnT/WVmMMLyG5huy60FvsyP9FphAq0/L7FLjzGcEEYFbY0i1X4JHR7vI0Jih9UaJW9yrTH5eHJHsTtgN8Na393PjpKEDbrFWqwCCfugMpjJotnJptv09khDJboA19TNgQrN0wnEWyF7VroONn/d2jjrlx+qh2m4zBh11Vd1LGexVEANfoFOPopmVJcMbWceOR3/jusnqZYxk080pBeDoqVmwFJPS1VNux/R9iLcFKIEF+tlIwT3l0V+VI7P92mzgdI/EPjdv2qJDiR6OUleZjcO6ieDLdALHq4ncrP4AU38PQJoDMR/DIXtT3rdtXlkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1Gs9Y1jukG0RDr7tjOIRiI74foYxnF7/b0AiAFwioU=;
 b=D+oviJ5ZjRkB6JJQybGRZYmAR7n44HUNydn3ESAm2nAAVl+U5EvcZwJbiiGhBD6rLINwPq2USDNnvNNEXyF/MwFdKBlIWflpgL2k/2pxm/fkNcvRQ+fl3eX7iLFC7vW8vHzGsexRn6I+H7nFz4CURluANdNLUvzWvG7KGEQZRBxJ3DIEdS4qruKetC4pg9xqSpNrbz2T0Gevd9F4MJ3Nb3JsFpCExmgHbwK+UP6lFO1IHiN/rjZBgJNpg3lfnl+tgScAPtHTG/0hFaf5Vh1CgZj/hxJGfX3H8ECMdUH2LWNWNYnF6bKOYjngM/rzx44LeDxgCD/SYvpxPD5svcx9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1Gs9Y1jukG0RDr7tjOIRiI74foYxnF7/b0AiAFwioU=;
 b=mdoyzikkLxWSze+7k0jEc4/DbNM+4Oht0sIMNVdclxuQDrbANrZX6s4Y6G7Q6rk1Cb6nTP/l5JbxWN/rPsuBg/uaWCxdIq/vRWn+Kicqmu8Uob9s1y/2QEohutS5Cf9Bg75kgHd5X9UZQ+XIdWnfRnWtHWvI04qoBf/9obrjCAr4uz3uDm33pswG0rj2Ez05pU9TSWkfYze2GDyZgNerwFvTtdKBq2bGgxLc9w9+/IKF3+uNd/gsHlSMcntmbnFJmRNU7zU2A6sJfUK9wtxkMwbvHL7wdUdpl8lvP59bfCDVY40FI4DRy59IMlChz8NkfcSTFwihLcwBQ9gpv9SpAw==
Received: from PR1P264CA0131.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2ce::16)
 by DU2PR07MB8222.eurprd07.prod.outlook.com (2603:10a6:10:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 08:55:34 +0000
Received: from MAD0EPF000008C3.eurprd05.prod.outlook.com
 (2603:10a6:102:2ce:cafe::a6) by PR1P264CA0131.outlook.office365.com
 (2603:10a6:102:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 08:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008C3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 08:55:34 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 23 Sep 2026 10:55:34 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 9359A4020B44;
	Wed, 23 Sep 2026 10:55:33 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 65ACC700CF25; Wed, 23 Sep 2026 10:55:33 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [auh][PATCH v2 1/2] steps: skip duplicate changelog for shared-source recipes
Date: Wed, 23 Sep 2026 10:55:27 +0200
Message-ID: <20260923085528.88881-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C3:EE_|DU2PR07MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 75910fe6-9805-4d53-451f-08df19506e46
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	3XnZEI8AQjFpViYtSE8LenQbdeGwuj9phtZ/BE27yUdLpSVj+Cn3VJeMpeKIkU548GFe6GcI+REtOPJCrz1eEHW3qLGBjhT5OmXIh/Ty3ZzfAdA84BKqinlk27+kthbA0CdWPb5CDcRNstY/7wzRbfZrQJtovXcKTnMQlWYJ6jc01y/X7SD8ShAzs+vG0V4Ui3nwwK4lZNyFXDUxZpOXXj80C+DUwnTlsXLhlF8N0skDb40hose3//kp2IWDqhNZj4WbtODHRrhCBBX3OmObetGJ1GdaQL3wg8QIbkhrnUFDx1CgJbNJMuZkQoznRpKWodgakJcxHyCHYWlfTCZPf2YjVZdiYkQu1pJtD/AtlXEFgg9e3wrsaWXONeyyL5ej5TUwmT8BEKvV/g88wp3RLb+vXKz0Xb9N9FdTfZYGlcax03AqBhwJZhiES5xT++neuXeQroRIbxs2rXGBQ7TpYvVz6o3igwD3kUB/y4J3u8+LhFhf0Apw1jioxBmG9DliP4Y8VgOWPUYY0XZXBHNgJBSqVhuYxAPCu8vWNRKoOF3Xx12yy/G+w3yfb35YiBxvA9WyF36e4vWpdRZIAUHdhIOLAd5bkLsdp+yTidc+ab5flrhiKlbHZmsz4ZjxkoQNT9iR/MunTVbavi66dtelQJbgZ6wwd9tjSOkKtXwSi46+Rdzu5n/XhI7HBoBfS6Y5g1xlUMKKx2DY6q7sONUt3g==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	pyMVEFczznHRo+vbIg5Y1pdhV2N2fc/9ehHucusPZUVoeTWSv/EfmzvNSFTDczl9jgPeleXF1e/xjygwfc8UV0RceN4xG5edCv74E4PJ1Bk8bDgzhgRIbMBA/GvnVDPt0kbo78alXU7zKtAne1OWuHKQkADt7903G2k0HRghPaFfIYNVPrggbX7Z9MeTL9ocLsxl/+redtyipqxYZxh6knc99HC1mlA4b0QKGWskrERjsIb7YM/cjLSmr2hxBXEO+HtqrbyHgpprmUjl/KBI6ix2MDceM+6EQwofdFuY21PK0qoeEtfquhoYbEIWrOESARRDF1UbJLDCww/BYzVSc+pbkSWV5j+bZsXzhT3mIfhiObl76n/bOdInKUjmr61gEs9Xgy5HFW5CvG+nCzSFpOOVbMydclOxRHeuR6C9Mg6tjnOVNgnKUcPk+lieORNP
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 08:55:34.6851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75910fe6-9805-4d53-451f-08df19506e46
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MAD0EPF000008C3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8222
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Sep 2026 08:55:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4937

From: Daniel Turull <daniel.turull@ericsson.com>

- Groups can mix recipes from different sources (e.g. gstreamer
  plugins), so fetch each recipe's changelog, not just the first.
- Recipes sharing a source (e.g. mesa, mesa-native) produce identical
  changelogs; only append proven duplicates once to the commit message.

Assisted-by: kiro:claude-sonnet-5
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>

---
v2: change logic to find duplicates and only add if the changelog is
not seen before
---
 modules/steps.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/modules/steps.py b/modules/steps.py
index 835cb60..e678a4b 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -98,10 +98,16 @@ def _get_changelog(pn, workdir):
=20
 def _append_changelog_to_commit_msg(group, opts):
     max_len =3D int(opts['changelog_max_len'])
+    seen =3D set()
     for p in group['pkgs']:
         if 'changelog_text' not in p:
             continue
         text =3D p['changelog_text'].strip()
+        # Group recipes may share a source and produce identical changelog=
s
+        # (e.g. mesa, mesa-native); skip proven duplicates, keep the rest.
+        if text in seen:
+            continue
+        seen.add(text)
         if len(text) > max_len:
             text =3D (text[:max_len] + "\n\n[Changelog truncated as it exc=
eeds {} characters; \n"
                     "the full changelog can be found in an attachment to t=
he AUH email]".format(max_len))

