Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D687CD5BBF
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 08:05:18 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.34])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11473.1779696316370247504
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 01:05:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=ZpBmQy7f;
 spf=pass (domain: ericsson.com, ip: 52.101.70.34, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFNK7dlL+7wgynCT0/qWy3xZRZZiEMHb56OIFz7foVkcTLz1e4QxFZt4aJYdRn/4vtBq16YQehu1DYuba9FekNmQ549GTnQY2/IJySCSuv1l3i5Yk0co3YIEvIx3rSODTE/r0Ua++iAPcgZNMAyh4XUjP/dfJnHsppqowP7ZbKHssRawjWiYvjJTEQ9c/xCmPkrab2Dyh0YkGGTkwAqGF6BIxonGnTMmUSJ0kJySeovpf5vNk7hBu6Toz9Use8Koh0SM2BeElnk2thAmP3h80/dnpp/vud1pfSSgWZPFn1HMtnvBsEGNY7ayMdoyYc1ASRKWncZGdyJMH4watXBp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cMz2zREPT54Ey8Ktc+2cd6aru8UEIUSwns5twWLyTA=;
 b=cvOXFs3B3TpUmlyxqR1qRh3QzHS3Aa2VNR633f0v0sy8ioWRLo+S/cIJadqyWsFljhwOCVvYiQwsqXlk0h4gjVk1Dibgmp1WFuxVlaRtqeMWwYQmc4xOM1ms66Q7rSbYe1HxN0YW1CHIrLQqfaJMxSk/71x0UmcTUGrY1CpkWcmjAVN7287ZEsGAC5OZmvUuwSujaqzoZ9kSVQ69LE+CBtDo3drPAcBfx9wtZDpudJOEik5WGG1IAhCvcbwh1A1zdHs3SojoUUC8v2xx3DlO9MMe4mytxStQmA6eWdyK97ca11uCceQHf5B5NsGYDVoScNMO2QSJpWBQy403K5QIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cMz2zREPT54Ey8Ktc+2cd6aru8UEIUSwns5twWLyTA=;
 b=ZpBmQy7fVvvreZBxsjaBDiLSd6BHeTJYJYoLAkH+2BDfIwGpOsYO45VjUwKy5ZLiFb1roF6vUn3EKJXmENTvMYr1HIX4vEKFGTXwTHOvTyrE3SjnHO3LjMWHzL3x9FbE0rpGJ//2Dh7Dc7cCJ+dYh0hRPXeQRhP/ANeddq/NcKuaFUqmMQNGh0qW4xAewvwdvWY4EIvFZMoZ4j9gviHVR2LqhwnzksXAFWGG7qfowKGlOfEGoDNTUq2nlkB1LRH3sTFyV7NtctepFYSIfUiICyFkce7zI3UwcbY8Yk8cQzCUyQHx8pql/dOCx1OSqPGwO4lXF8kyRZKKsj4+asC8Tg==
Received: from PA7P264CA0163.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36c::15)
 by AS8PR07MB7317.eurprd07.prod.outlook.com (2603:10a6:20b:258::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 08:05:10 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:102:36c:cafe::95) by PA7P264CA0163.outlook.office365.com
 (2603:10a6:102:36c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 08:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 25 May 2026 08:05:10 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 25 May 2026 10:05:09 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id 093104024D84;
	Mon, 25 May 2026 10:05:02 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id DF6527003739; Mon, 25 May 2026 10:05:02 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <Qi.Chen@windriver.com>
Subject: [AUH] [PATCH 1/2] git: use temp file for commit message to avoid shell escaping issues
Date: Mon, 25 May 2026 10:04:14 +0200
Message-ID: <20260525080418.942183-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|AS8PR07MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: c69b4ff8-d123-4967-e3b8-08deba34577a
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	wp6Mo9OlIoQ399TeOmzB5hvibehkBtUhf7V7Wz86TFMk0xjY0WZeTRN5tppN8tZb+23YktO9kbluNNQWjY7UiimUarTmL7EjVvPpQAimu/9ZgiWfi+tqypmLTnDgeWi8xP/6JtrspaGXuYHHrqxpkhmfEgBoqPijfBQCQ/AQorzbuhMrMRjAw5tNcxRM4XcTv/Mf7nGUh6rT6aoEqppaITK6ayPklfM31t3wV2gtLbZq5LfRMiYKXo9NPMb5jJI9RHmPWQW2mVtoERrBZoD1zFiGJo20Ksnb3zA9IYB92Uk0ytOkUYwv8kmTeCFeBT5sRRR274+WikAGPPtYNUr+U5iJk86a3MNDj9rUaSQITLE8+Ku3B9kanonvLyo+yPy8wIIzA5OJQiXOtgKDxjND7e5pESs/lQ9IrkcKPt7LYsItRW1GFwFQPR/VUbNR9vLwxa4Z7unalSseChns+EZrGDv8HsnIhVak+JpLUO4XvI+hTEoClSiBhPpFGnnAqtWjP+Q6qmOoRszk9c5LGWbR8hfm+g4MV1+UIDe30UZOM5EPdxPKjBgB8Y+LKXBYeKrH4+8juNHophJ+5FqEgkEPOZuXUwh0RjK50j5Uy2PDxKucUzMiV+2TP8hBMTatDkq6wXEVTsNfsLnqLrHs5/DonBTwSLh5HrW0Y8S22tjaOk8hp4Jfvhm6jDHt1/S8H1vWQR41F7Un1le//gWEK17dMSrmczJPsIUsZ3b5NfMrqRw=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	3GJLgGLFgediBcSvza7D/sA5GFaJDNS/ppJRgUUgVv81zUJCK5rEfIAEqI1/8qtqW9MuujMUePCgLIL1rqJnYktsXx9HZJ4JZBTvRL9DMr8+1R7PgIjj3f2Z2phd5Vt2c7wYZahPgq3Q5FuvGmbCj6tgOfgQV24IIHJ76o34CtVXYOjw0sbdGALkC89EjPz5FqA4YvMB+McKLk6nOx1WMBpBLJ+QJxTGG6pU51Bx/TGFfEsPzWwVMRzzVjgGUwL6H/UJrBxlGM8AIrq8JYaXbaopiYY6SuWPBfajTtS2vjnka1HcTpbG3IHzbLRbCE+wMnZu86OXbFEXPslPBa8BzE+iI2wALmQvt8TqPdB29YZxgcZD8ne6p+aZZovFoE7n9aRZb1mNDnba3Ntu74SipkUnhKihwHG0YnuF+7lsWdLSmkjeiNB2u2Vgl740cG4P
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 08:05:10.1371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69b4ff8-d123-4967-e3b8-08deba34577a
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7317
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 08:05:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4036

From: Daniel Turull <daniel.turull@ericsson.com>

Passing the commit message via -m "..." interpolates it directly into
a shell command, causing a syntax error when the message contains special
characters such as backticks, double quotes, or shell metacharacters.

Use a temporary file with -F instead, which bypasses shell interpretation
entirely.

AI-Generated: kiro with claude-opus-4.6 model
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/utils/git.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/modules/utils/git.py b/modules/utils/git.py
index b383049..b732cdb 100644
--- a/modules/utils/git.py
+++ b/modules/utils/git.py
@@ -54,10 +54,17 @@ class Git(object):
         return self._cmd("add " + src)
=20
     def commit(self, commit_message, author=3DNone):
-        if author is None:
-            return self._cmd("commit -a -s -m \"" + commit_message + "\"")
-        else:
-            return self._cmd("commit -a --author=3D\"" + author + "\" -m \=
"" + commit_message + "\"")
+        import tempfile
+        with tempfile.NamedTemporaryFile(mode=3D'w', suffix=3D'.txt', dele=
te=3DFalse) as f:
+            f.write(commit_message)
+            tmp =3D f.name
+        try:
+            if author is None:
+                return self._cmd("commit -a -s -F " + tmp)
+            else:
+                return self._cmd("commit -a --author=3D\"" + author + "\" =
-F " + tmp)
+        finally:
+            os.unlink(tmp)
=20
     def revert(self, commit):
         return self._cmd("revert --no-edit " + commit)

