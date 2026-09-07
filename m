Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09FC79F89
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 13:15:01 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34728.1788786898559531228
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 06:14:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=KHZCmXhY;
 spf=pass (domain: ericsson.com, ip: 52.101.65.39, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc1ovV00hrIDtBxj+SlcA3vfkUEx6rzAm9mL81tM19YWZ0OVwc5L/HBazYh/3wq+dBq/nMxP1GLhLHBg1bhfeGYJSbIigjc06I36pd8bwVCF29SLaIEzTBvIgxqhYFKeVBvJV9P+40CL87ka/p6qQVRE9x1YZ5JSVuDIxmONvZtoJBXoJCjuV/J7NOm+9UWZtY8AWAVFI6MSBuoi/vGmA+LjTkmqOtOKQX4LZdD9HBjpx2p3+R2/AL1xf54qmDPwOvq1v4Vh80EIZgYrxIWImT64kFNrgkHkDlnNaDT8uHmPzeDrtpm5A15sdIcPTubTkk7Pcc5ZY/eM8oVBbCK/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zzI/eaFpT5nJDzVWnme5MqUz7K6s80Zwoe5qknlLAU=;
 b=kn3MC1pNtSvX0oLW75m3RuNcA2R1p/unA6LKMLK4W08wlLwGV8hQlxT4XRBsdfXfBOxJGDc4rcIVngYpPsMPziTjV7ZBogPR0lN3ILjfU3Ir7JBsLFgslddI4cMI2/o08D24/2mSCbCj628am7lPmq2fn5bE+fXMJD0UxzhB+gmDgdZcgp39Mt0UyfTBbGH5es3JMdGY2ep5/Vew8GBRSh1/9iDMrp79UWyNqPjaKwBwOANIQWhZ8UujEr4hpIyihfAJAAAUaQO56Bgs+kl/diTz/dzFhO/V2FPGg8KKIoxUnC8okCLA1SmV/LaCUYI77FwoOe1YbQr6Mb6y3TCL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zzI/eaFpT5nJDzVWnme5MqUz7K6s80Zwoe5qknlLAU=;
 b=KHZCmXhY/69C7bZA9yM/WUSBH+fO9PwOFS8A8JqWAof6InLjiimg3d7MNmFKkEUsIV/vpNfOnkOGV0aRgyWkR3h2GNiq+tUdqfXOUc7m0fBFnrA6cTmLPmEiPOyHnxvqfbCUALMSPpJGC4In+XLjSRU73I2Utt2U28WiTDMw4tAPYJAfW84e+2KvD/kVbr9flUba7UeYL255DF8b00iIELIZ76jcuL1Q+xT1+1vP2O6xfTtbSLc1r5kMuA3Z7GzuIY7ytbQrXaz4wmBXFQ4on0OMxfNyxkC77oetess6jQ3OJPrZju9JX1tZCHvVR/CkZFijKCLcPY+nSV9lteancg==
Received: from DU7P194CA0025.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::20)
 by AS4PR07MB8755.eurprd07.prod.outlook.com (2603:10a6:20b:4f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Mon, 7 Sep 2026
 13:14:43 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::73) by DU7P194CA0025.outlook.office365.com
 (2603:10a6:10:553::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Mon, 7
 Sep 2026 13:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 7 Sep 2026 13:14:41 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 7 Sep 2026 15:14:40 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id 2FE824020B40;
	Mon,  7 Sep 2026 15:14:40 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 0022D707AAD5; Mon,  7 Sep 2026 15:14:39 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [auh][PATCH] steps: ignore source in commit msg
Date: Mon, 7 Sep 2026 15:12:52 +0200
Message-ID: <20260907131252.2810926-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|AS4PR07MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b52a3fb-74ab-458c-3911-08df0ce1fa66
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	2QKIZ7nezZNNH2dzBe4iNJ9IpUdYvfqf9eDLZJerg0sa4yI1E7XcDqwKUZQO4vwxFiyJ2usjocFQ/Nx6/sFP/FAaep7ezc6lPzGA8Qt8McWj8xNBcxic3gV9yY74V2mzMclx44nsE13ra1J7CFZMES7Y6lngANhamTBKgsy3HOR2JX1xhqLfzr+onwJK9r6MMI7W8wZf/ZsAWA1wi/faUA10gjXmV0kxPhFHY+WOaismgxEFnHwR8dIKL5IQQ7Ky3CpCEyv879UoltVhzOaygpBWoornQTPxYXQaZYE7e/mPgNaVybyIJ+kW5iClkgkna7ZNst8qRghU7v8ZkpF7lH0vk/RJ9ktOQ5wwUqhHu8ABXpZESdLybGjxdhcqeRAYY//CEO9UKR9up7D0/W5m7pWi4QBUpIDbjkF1o7e0M/RCuoNxlsiEKdKPFFJ1GFerSgLDtq/0+JxSesnlbECzuJZxkInehknMJvZOP8Dns7JObnmSgykmO7cCwAByYs3yM7WxxQ7FOq9J303uH0myTyMXL+Qy1JZiWhrPqL0ZadZVVH9XDzDVLfL8a7RaYQBydTXMHOOivAI+MkYRtcENc8632NJOfOxgPK10UpYrGaVMzdEmvAVYsx5lcR/swRFq1ycn5xGcZ+3k9hBkrH0IvbbGV7w1L9zIuguUi6cqllMKzyV8gkrM0qpvBaXUonuxj/pFwLvJsgYWSEDtPb+jNw==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	tm3YVzsolbrlA4NGAd6Nxkb6uQzo0/zsi7TYhCYnC4w53QSqDteVT8qwn1HIVtwQ+1tN14cNhFUZAM+H5tZMObe5I584ZamdIN9iwmMv+zumiIw2q4BzzN4OQgy55b+zRu0RoTaNLumDVQ5wrbC665eMlRk2X2DDqRJu3vti7cr458jZiwoYKGZwEAU07DmZEUrieEXDhFQ5qqolAXZuqnajiwVGtmCmm1pNBVSZG8P4FsHclwNp4lp2FEJQnlk8lhCBGTbwFR/QgGTo65u3Utvgbo/SsOZEeaoGj/bPeEIZfH2Y5E2FfYt48PAswO9HVnltQKpAmKttzBxy2N9Rs+60hmTpyaTBs8NfjgycNdHaMuNPP+W0eiKGtIExgoJkB7S7C5NqzKY7i8NVt0JpQfHTNlyQ38OLSvRUM3KmzcC3GcWFTuKHluqYjFGeCDCM
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 13:14:41.7229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b52a3fb-74ab-458c-3911-08df0ce1fa66
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8755
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 13:15:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4748

From: Daniel Turull <daniel.turull@ericsson.com>

The source is useful for identifying where the changelog comes from,
but it does not need to be included in the commit message.

Keep it only if it is a URL.

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/modules/steps.py b/modules/steps.py
index a88e666..4adb23f 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -103,6 +103,8 @@ def _append_changelog_to_commit_msg(group, opts):
         text =3D p['changelog_text'].strip()
         if text.startswith('Changelog for '):
             text =3D text[text.index('\n') + 1:].strip()
+        if text.startswith('Source: ') and not text.startswith('Source: ht=
tp'):
+            text =3D text[text.index('\n') + 1:].strip()
         if len(text) > max_len:
             text =3D (text[:max_len] + "\n\n[Changelog truncated as it exc=
eeds {} characters; \n"
                     "the full changelog can be found in an attachment to t=
he AUH email]".format(max_len))

