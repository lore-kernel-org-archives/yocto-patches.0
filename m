Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEC1CD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 11:20:54 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13909.1779708052903285092
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 04:20:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=GGPAmZZx;
 spf=pass (domain: ericsson.com, ip: 52.101.70.48, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGp3/FF2RJqCjf6NyDfiN0NYa43nFvdu9MA7j856wQBoLn6kIrOSfW6ORe7I8SxLsIOrTHqsR5obzUhr/ixVNYVCcRVybpcE2jfl9LxP0exezqbdtZYPVIr5L20Nhf5m41hWMeJOipOXAj9LGFCXMnGyvoNZFyHfA6Sp9Fw+Aj1FbMTmxeywKB5zlgZeUcG+zdazC5zSgQcWTuugEV7Pnbtm4USAoeAatebeFdcrQ3ccOWOk0hdCJX+1Rw3RXTeAJIRy550uHuWCKeTT0/NJqMKvSVQ9iI1qW/xTaneBOWRHhV3XRG9ORCb6sC/LXcs0KG3x6e9tBYJ0F9uOD0GoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS8HMLcWNekUDdMO7ELwCtlnUe7XiIWDrRTv7wpan8Y=;
 b=QLTRM1vul+Dvzz2WjSNBzK1JQaxhASdtH0k9zbybMMo//JnyZ1DZT9RZyPlckL7NUZ5RvClIGWzzKsKTPt5u+HqHKNlBKYtDcfn3I0jN4RTvauP/iJcG8svFX8DRtRH1Sc9ebdoWGTL8/cmiU/hTAvZQqprrRzLkvWh2nHGlJC6zMhrRTQ/l/6+oL/avAoGzmyg/8ZCxR30CsRw8DcyxFGpWINFzUMzTSKLEkI3BfEeYL+mhdfSN/2XKCMEs9tz2HgItjRZyzDJOVzNJrPTQtTI1KqfB1H8gNbhT9ifvdjkMJtvrbylfMgiZSlSfzFy5tMinYSetP8ziytde93WhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS8HMLcWNekUDdMO7ELwCtlnUe7XiIWDrRTv7wpan8Y=;
 b=GGPAmZZxqsUQ1Vute7D5ycMvbeQK8y9kIhBxcC/uh2289nVm6w+r+85WUbBh2ZHZCHAGD30UAodaG62Mhydxdgy4pCq1fdxKj26LowE1FGYW9QsRtRQaeoualh24nUDORbKNMurI3ORxm2oomXlZ/Pp0jd1LFNsLhZ0p8uGlHb14DyhIsfkpu2QxFfvTaHuMG8rBxo9qhXVU0Jn0TpZbGPYRZfY/zON2XgxBVYmS0jEm8d9eLq2N7BQ/KO8m+XJ3LmfSx1zCWdeYVjN2hZGNywh37c463EhT8dOYeYClnFvNR8qkY4zYKDk/XItcoZbIRnmMLthEIqmKAs0L/QXuKQ==
Received: from DU2PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:10:234::35)
 by MRWPR07MB10272.eurprd07.prod.outlook.com (2603:10a6:501:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 11:19:44 +0000
Received: from DU6PEPF0000B620.eurprd02.prod.outlook.com
 (2603:10a6:10:234:cafe::85) by DU2PR04CA0060.outlook.office365.com
 (2603:10a6:10:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 11:19:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000B620.mail.protection.outlook.com (10.167.8.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:19:43 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 25 May 2026 13:19:42 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 7EC844040F39;
	Mon, 25 May 2026 13:19:09 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 67D697003739; Mon, 25 May 2026 13:19:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <Qi.Chen@windriver.com>,
	<richard.purdie@linuxfoundation.org>
Subject: [AUH] [PATCH v2 1/2] git: use temp file for commit message to avoid shell escaping issues
Date: Mon, 25 May 2026 13:18:44 +0200
Message-ID: <20260525111845.1018725-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B620:EE_|MRWPR07MB10272:EE_
X-MS-Office365-Filtering-Correlation-Id: 5962f3b4-1b5c-487b-4fa0-08deba4f8591
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	OLCti7a51D3IZf8KOeical32VW1kuBF4OcPyjFFRGMw/omliaTupGmFoIPTrxHTj75/0fMq8biy+UW/wXXN1WahjTlTCHzzU5jkR/syd1ua/K0xE7adVEJzy20waBkHCN4IEkbFL0zxdbgUkolLJPPdxQ7yMo5mK3F8AsAAjgTWDN/wvSAdJ3bdqLxh6eoW27ZBNlVboCrpcrdIOVzH/0Hdg01SxyBeSEXlOBxwf5XaH9yN8UUCvkQ0+MO/lfEFB6vzSo5gVyLbspoAzMTCK7hEmm977n/en0LqLpQObmqndtrTQqwBCzQOA77Bo7LnJN9mUB+QLbPkFqrutfZNGduwwpnVtw2lhwn+Sx0pDB016MLry+V+94+SngegLvGzsmwfPGbJEEr3JnQARr93bwXJr96EF7TLd4zflkNiS5nGRzC0hA2fPPiQpybew8XXUSwY6TpkEQQnHQPR98xTQLBoDthmbYrIZpW3OTO/6QT4IkKv1STorUkxI78mtIkwssbqIHnNLEAc68SPY+Bbj8wtuotN2ea99HlOPMoJStOti0iAY6CB6dAv8JJntZWjK7x1FO76k9kzIc6l1ST1N3wDk4ZrSvHWHTXFNflwGTXmZ4ekuFeR4VEOVFVIKk5w5U47ywMTrhxNsKQAsUtYUYcfC42Dhbfd37b4rY2cIIEEiMgxMpw5RFZaWJbqX5kmDDQif8DMXulCzvtAACaj9ae6VqiPAs5tgdZZjpBnPJmQ=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	d09dkQNbVeD5xntQlsfKLLE0GUf3mMpSWjYHD9ctsJbDIYOZAN+2xOlGtKfl5N1iPzGmzBG+6oNcoS3YMDnL86Qsl1kakwmK2u/et7IUPXvbzl8b5gKgfAI9yE4GHDFnSQpw+S2iC7m+G6qROSIfhMD0kX8DsPYrjkARjPpUjMWOps8rOIalA89bk8FWLZOLt+gh05DocbNiRl5rEQGnkD9JFWUFHb0IkDXnuuDIat7BydjNUybgCzy3wkBskgFiFqdsFF4Azwzf7n/1yYNFVZithgx3V16Y59wQq207om9HOvaldPR49eQ+y1Z1RTC31B+W1YtvKkJud4W4OZz6fVYdkRcB1KirlMudxYArrsqLT7nePK9pEoZFU+T5mcOFRLoZ9wCVDfUNj+9aC0wze6j0O2JLdbZu+UCOWGPtG1po9bt/1t6ZaGqfjE5fehHz
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:19:43.7955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5962f3b4-1b5c-487b-4fa0-08deba4f8591
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000B620.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB10272
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 11:20:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4041

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


