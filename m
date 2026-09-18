Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A26C982DA
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 12:04:11 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9531.1789733050891836920
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Sep 2026 05:04:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=GEHbgFCd;
 spf=pass (domain: ericsson.com, ip: 52.101.69.3, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZUZ7C61MAsyDqXWWf6MiDc0al3Eo9STjb6Akow6CPj0LiaibILPW78VsxgNltg61JX8OmQr6CyQirQf7OrrhzoTLHbjlOgFS/DK23ftOkG1i/ZK70rSUlSncqt0aNSRlbIe1rcsvJ7UA1TXDZ/mLqbK2CCSy8uyNL+ELHFf1JQxCS7cZkiDX5EvJPVz5PqvIZT4eDn1AhkLaNuWiX9VZB/iMKiA3iM+pHJVp9UHyY5K2C9cbk4pNuWj/uTbgQRp3v7P15N24g/RxVr182Xq53EOjADwYYQZdtNDhHIXnsLPbkrR19cibrlpH6deLN57PsKGPd/ZX8UoMzw7Uf30gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3phKf3lR3obeK1QV18TZfTsQAR4RzvNvHPtYb7xWKY=;
 b=BBdTEXC9D4GIGUzBiS4zldoXyNbPzLWKemagiH7EVtnX3+kMhSZfNnRL4UGHAy1zbVV5+KHxT049PEdCw/7TOU40e4VKVQ46KxeKJdAbcgKHi9LUCvO8BA8fzz2cA0uXaDoMyDJG7UPTwT/aga3BoUfs6Uk+Ft6Hh78aQ73DU8yzow9oyIuTLa/BN8IYT6ataLtfanwi/gzRxqd8oG3jUIg4s7ecXh0eXm1yn4doxEcwsjyAhgKbU2pmvdoWtFmTWQHdPsXhdMuVqqVCz4KVKgRds+JHtJdUINOPyeaYpza+S2bRhOg7v+WC+6jaQPmPukNm89P/MdzAkxqaqqoW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3phKf3lR3obeK1QV18TZfTsQAR4RzvNvHPtYb7xWKY=;
 b=GEHbgFCdL2KJ1KRisqrFufR0/zpFWFw2N5ueKgB1y//dva1mK37exuAVCbFX+OOCJz+/As2qapuz/inzXmGHsb7A10BYFXGU9btUVuPItN64Jl3HiV9ro5Q6BDgmc0HhptbQ/dZsXcJQHz+5Z+vudX9X0O5l4NxDdFG+rySPli02nDziThVG4ymsMgVEM0l37/6sqv81FT+dXKEl5o/kkZJXBLsSapKjbsMGTr66EcwUgwsZ/T93SKO9GchdEajUQ9utz42qN8qqdBzryDt299+fG1n6GaFQbsJiWr1Tvt3PL1rCoXR4BpIL+wLnGPN8VYOpGu85VoqyIF25ola2XQ==
Received: from DU7P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::12)
 by VI1PR0701MB6895.eurprd07.prod.outlook.com (2603:10a6:800:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 12:03:57 +0000
Received: from MAD0EPF000008BA.eurprd04.prod.outlook.com
 (2603:10a6:10:54d:cafe::21) by DU7P195CA0029.outlook.office365.com
 (2603:10a6:10:54d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 12:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008BA.mail.protection.outlook.com (10.167.241.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 12:03:53 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 18 Sep 2026 14:03:48 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id BF81F4020B48;
	Fri, 18 Sep 2026 14:03:47 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 8F620700CF25; Fri, 18 Sep 2026 14:03:47 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [auh][PATCH 1/4] steps: deduplicate same version in subject
Date: Fri, 18 Sep 2026 14:03:33 +0200
Message-ID: <20260918120342.772566-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008BA:EE_|VI1PR0701MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c3cd7b-5747-4cbc-9770-08df157ce8ba
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|18002099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	TN4c5drTocJsKohtslyN4G14YBRBxB68rw47Xvkp+DOr6G8Uk4WGqAoyRzqhz73X9yctfDtgLFAQt9sVcl2FIlHLnE1xS/qKw6/5k+pN0X9J9hfZpLPG4PGLX/5yU88anwMArNWt7CyBk8kRx6p+39ceFhY65nPkbx5zg7tWAdPogDHKop7HgIWrbhT5gJ3Zo79Q8fCIfmCz0Fq3CtLR6GSFmyG2DVJuj5mFTr3WZUieOt6x6+Teiw7rQKbImWragyTOrXCaetF8dO1ow2xs0Pyk465mzj+HI78viiGMsTYMA5ce1SnrHSbdQzUX8HOfzfu1pGekvgzNDwcr7ht7U9lhIc/MMQBqQ72b1yi7OFqbNvEXrSN/qnC6pCbuaWIjMnh9MUzBYEdI457QOM6m+gJ2lFKvFRc/Mjps68uhza4TxQjlKXalCTjYu6gg8FExSmVKE22yerL1OaMDp+OWhNLyRpSc2kPOkPASph6o4mNK1Xt9l9SFZdJXp3GjwxWwQgq/hW1uQ7PkP5g1aAwkA9OBEQiDchBb5aR1PcsofyxlVLSsAuenMXV8aHBy5UTDefy0RLiT7Jz48w7QLeQrZQZ39ipmwCAw4hc4JxeFd5Ix4uMlHl4e9Jq7+E2w2wAXZ5A0ZY8jEGiwwm2s6mtlepUC+svc1eZ6E1kKJpEpWKxeAzwk7vlLS/kC1ploj4ifnzNOjFLMBFNMc7sI7gt37w==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(18002099003)(56012099006)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	tWvL8z/vrVjKRqZyYyiyz1hCrGG8Zzn/woWSWDXhk34kUR2cjjKFPLyccsZA1bWCCSljt8phoflr+sOp8Q9n5eF4Lp5VhbT/HzJf6MvB4Q0f2tkVIv69GdG+K9eEdcMu8QIE6dO2A3r4OsMrz9wMV42HXfUL6uEqZhHxbnyrnXzqXT3CnhfmCC/802Cw/cyKkzVu3D6kN3rgBBu7zKnjZTw5gyJ+hCR+QU2YPKxwBQ+xVE2yVpEGJY47bhVVoGP/gZIJsokZ1pFEW5Pvbtbl1BJLNI3y7I5dZq1o8zA+IAdsA8wf+RwLZvbBmRjdqzvt5g1n9RVVVKw5Q3BzjYK2xbRv6DzZQpGMeZiBV6FXTww8eKFcV37dcDVNpOYGPQU6abJ4G5TAiXsJailqjVLQz1U/QuArdnIgsvbfP54jBA8IfILdEVlSfZkmAvXmsRaM
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 12:03:53.3445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c3cd7b-5747-4cbc-9770-08df157ce8ba
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MAD0EPF000008BA.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6895
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Sep 2026 12:04:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4906

From: Daniel Turull <daniel.turull@ericsson.com>

When multiple components are updated at the same time, we should have
one version if it is the same. Before the patch we had
duplicated version information in the subject.

Example:
Before: mesa-tools-native,mesa: upgrade 26.2.1 -> 26.2.2,26.2.1 -> 26.2.2
After: mesa-tools-native,mesa: upgrade 26.2.1 -> 26.2.2

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/modules/steps.py b/modules/steps.py
index a88e666..20a213a 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -77,7 +77,8 @@ def _make_commit_msg(group):
             return "{} -> {}".format(p['PV'], p['NPV'])
=20
     pn =3D group['name']
-    return "{}: upgrade {}".format(pn, ",".join([_get_version(p) for p in =
group['pkgs']]))
+    versions =3D list(dict.fromkeys(_get_version(p) for p in group['pkgs']=
))
+    return "{}: upgrade {}".format(pn, ",".join(versions))
=20
 def _get_changelog(pn, workdir):
     """Read the changelog generated by devtool upgrade and copy it to work=
dir.

