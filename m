Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF07E9DE7C
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 09:08:44 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.127864.1775725713569419448
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 Apr 2026 02:08:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=DTXKlH/5;
 spf=pass (domain: ericsson.com, ip: 52.101.72.22, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFk8mIb5eKpKGGZHSRx1770mWzGXP2MQjYuR+YFWqjwcn9UVW757kM66ygmY2iOHLI4qDp/0AHS5ONQBS8DbJ7ibCLI3fmmgfZeW3hKueRBpnuZ26MvYbJiDnUay98+B7Zivb6T/izGEy3lnpTI/S77eQyq8Y2/0Gs6zYHMaJJbAvihYKWml5QXw3LlMxE9VGL/1t+mcF7HDl+sA8Q5uVAPUEqsCjEtvbBwxJTE7joLwvyTfl5+aO0TJ7srAUmqwM4Unht2SdHjfPK8b3aYawdguWwrTzoB/x2AyxrEj27D7bzWx2rYe54SD8HyRM9wUOxYdVl/0I5NEi4gfKGYoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUoG7FNUdNEaWKma5NKUBg8pvMW/W4yZfW6npQHVvuc=;
 b=APpVs9UvAis7i8Apq+FOtIU5d425jiidQPqTAZYb/HRKSU5iHpBKEZUFAhLiprBZ1TGD/dJpAul3ZKQOhrz1WeajmM5RF7nmyAFuH9gXUZR9T5+NRIfJFqSB/a7OBICRQOOlyRPxrhVAPnXe9+K0qHq6C0c423125Xs57jZtu09aI6x/cKJPbNXUL6idAntnC559mH1CVOaL//nGGD6oB7HGzsMOzQnE3f+A9HDmjliSF2y3OFVE+JGTePROnQaf5JZwn7ROe8LZZohVPBJPxqRiXdk0JEnhGB5HE5cqYuLNfrl1QAjB7RSbm7VYROwKf7kkd1cge0S+i7Qw4PL/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUoG7FNUdNEaWKma5NKUBg8pvMW/W4yZfW6npQHVvuc=;
 b=DTXKlH/5hBKwSUI5ry2Pnuv3MpjVLDDcz26Z9rT60iGZzwL1/L4PgdU8R0e9CmfUIKtqCTwKX3NitB4EGx5OxqqG3V4BrxF/0wpABxpJiAu58Fwarf2xhTh0xEd/kYp3OgHYBx4aAKgRKhcm56kyH9AGuYhxDwln6o+xWjfh257Bb1L4HI5SxKHeBN5UKxB+SaXW0bEov/Ov0LpMkS1aYQwcJuHiFK+akhMiCETZGHfTnAVnWZzr5q3aUhQxlCVXNlfNnf5x01GJ2DgB7PtxeHAqsKlV34wLeF0sRvqviEA//T7rXKBAkI5n4QBllzqE0JX1SoD9sKa8LztflMNOxg==
Received: from CWLP265CA0435.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1d7::8)
 by PR3PR07MB6491.eurprd07.prod.outlook.com (2603:10a6:102:67::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.24; Thu, 9 Apr
 2026 09:08:29 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:400:1d7:cafe::4) by CWLP265CA0435.outlook.office365.com
 (2603:10a6:400:1d7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Thu,
 9 Apr 2026 09:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:08:29 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Apr 2026 11:08:28 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id 2376A9569F;
	Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 1079B700DB93; Thu,  9 Apr 2026 11:08:28 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>
Subject: [AUH] PATCH 2/6] upgrade-helper.py: allow to set the git directory from layer-dir
Date: Thu, 9 Apr 2026 11:08:11 +0200
Message-ID: <20260409090815.1731294-3-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409090815.1731294-1-daniel.turull@ericsson.com>
References: <20260409090815.1731294-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A794:EE_|PR3PR07MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c62690-1509-4c50-f986-08de96179116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	VFHJK7eRWM1ST5kQV2IB/ZVLRHy+6bqNMfKzAAmvbsIjvj6nVHXAH7ER8/plDw/vWs199IpCHgsvbmelEnGYKA3Rjw4WkmDIp2MKyNC3Pn4nBfY+www3hXO4ZzHrcH3Ynp2EAcwtDG5M+qqkbWXC6n3Uugue+Skmo5yhmwJJR3un6N7ILYUvw1hD9D10ld7Wo72zXisqxEYLmTGhW54FGC8EDrjSofLgJGXLkEVHTCVHh/tFe55Q6G4AekXfygceExA3wcQTletOglhmNCLv5a0oggMMi9KE4Mbp7OYKlU7uBrklqPn1H+Gd0fcWqfegmWK0Tx7VKsXTLvyMyac09bCQeGwoJ0e9pevmLAT+Xtxuz+tixzWcHqtsy/TH/nukBSv38b56zwf7j/xDfpBgHHk/Ktr9yorRlxajMzXzbRlY7ZZtAOQBPmpegKOwtT49cXXB/7CrD4MMnhHiTkTNgDp6Wt70oxMc7WFHVJ/fGebKL8GnpT5EkD8EdCvjUTzrS7FaXhHCLdaczcF7LtQniTylfXRi8aAiSRDqQaIFpZqXvNZsT6d6WFoD817WM7G2y9DCzIfnNLEJc/5GrYkIISl+3bckEgAdT0QnPftTtEEh7gfwt1/k8DPDdfZcDAcE+CL+S0Wl/sANy2K/IVDQjcVeA0TqcQ/IYoSfPWHO2UW1IQSnnbFxAG/IbAAMEuGBsNAi+6WO+6fwrfFOtRrg26KEA0Z/qzOiGP6vsG9lwaKEmD3jVDpeFPNRgCnk1hxnNHOyeNjKvfKXGY3Cbk2UWA==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	AN4sbQK+oaV9bPkkG6oMVyum+TiAefi8+mFfTiQ3UHH2b1ZFl14V79wAu2rF0ZracIngE/V+b1aN0tmGn4caNvROtVUvoC2i9G61/tALw0V9iO+nxxhH9BDucah5qgKErg7aJPM3xhyXJ3VdgQKM4Sv0tCQ9FQSiTAuF4vcZGqiGnKhscnZfRkW21y1PMjuzhaSaaqXQ6yRHCzMK2fL2GJCM2kGwwgo4NXSqTdNhMl/XvmCId0FkrnGrYVywP4Y4QgoRjVz06WlG7/C3X3vopA4Bhcbm0BSBVqTildH5tzIRREfURcJkMI+RvWaVi6MPZ0VsgMkU0exi35wzP6bw79gZpVA+M+VX3J1B4UxLR/H9cgDjFp5rMzZ28ws9pNz4dxZzppJf/7zrMcwSw96L47IDocgyOlfZZMctwBx6Emr4hFNWuSk4wxtMxb2ARG++
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:08:29.5196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c62690-1509-4c50-f986-08de96179116
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6491
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 Apr 2026 09:08:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3667

From: Daniel Turull <daniel.turull@ericsson.com>

Replace the assumption that the poky directory is the first PATH entry
and reuse --layer-dir to setup directory for git repo.

This is useful when not using poky and each meta-layer is its own git.
Without this fix, commit_changes fails in non-poky layouts:

  git add .../openembedded-core/meta/recipes-support/gnupg
  fatal: '.../openembedded-core/meta/recipes-support/gnupg'
  is outside repository at '.../yocto-scarthgap'

Assisted-by: Claude, Anthropic
Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 upgrade-helper.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/upgrade-helper.py b/upgrade-helper.py
index 68f315b..67ca54b 100755
--- a/upgrade-helper.py
+++ b/upgrade-helper.py
@@ -184,6 +184,9 @@ class Updater(object):
                     _layer_settings_error(s)
=20
             self.git =3D Git(self.opts['layer_dir'])
+        elif settings.get('layer_dir'):
+            # allow to set the git repo directory without enabling layer_m=
ode
+            self.git =3D Git(settings.get('layer_dir'))
         else:
             # use scripts_path to get oe-core directory
             self.git =3D Git(os.path.dirname(scripts_path))

