Return-Path: <ranjitsinh.rathod@kpit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F25C3DA4A
	for <webhook@archiver.kernel.org>; Thu,  1 Aug 2024 05:45:24 +0000 (UTC)
Received: from PNYPR01CU001.outbound.protection.outlook.com (PNYPR01CU001.outbound.protection.outlook.com [52.101.225.74])
 by mx.groups.io with SMTP id smtpd.web10.61598.1722491122183180711
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 31 Jul 2024 22:45:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kpit.com header.s=selector1 header.b=DNjMFNZ+;
 spf=pass (domain: kpit.com, ip: 52.101.225.74, mailfrom: ranjitsinh.rathod@kpit.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmsTti4Tw7f5mZNE871QMmXUq90cwSk5t2L0qeYcLXxEMNL2Vj+dji0+609q0eVgaJRk200w0JQaPmxh6NwdGSfzYRT4iPndcqwuUOZURxOEcMFATf/+BTUterkH5Pvq30xK8U+0+ZV2kRk4Jyfx8KEhInDNyVw/45lu32uvwoJPV/QJFVMCyWS1xqS3dRiazGqvDVw65ZU90jg4Sin0kfIMnLOV2WJMvuG2fvQsq679ic4IRjLmKrNy9XJKn/0mm/c7UYmrfWh3RojbXU3AXW5ZvUxCKeLPC+sC7LOkqu4dV/vXVN+uMRKkR9JuswgsvBgZwgv2Rh9Cfx+L08hWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQNiVD/DQ6MMl1+qYzuQarvDg88dYbWvoVJJEfV0ZZg=;
 b=VzWTV/LS0xYmHLFG7RsA97mmfYb+il0Qce3bM2Ow5piiFYdhC5juRg571ldQ/QRWIPMw4dkiRKae6SMnb9JSfk8zPdIWukOihGemS2YBz9P/91wQ64HlzQ/xX/f6BqgYnCnHfWxcI0NoNPIX3/L6DtontWi4egrF7o6A/bW+cMe3TPq8x1f0KZwCVJU+ETC5ltKTg9YlwJD+PvPvAysZUfyEmfhY7OB8YSzZP4Iy9U0BnoThrwEDwHHqdSsNINioArtsOGtMzbgKoed37fKyjpQXVwzR/ssdx+s9D8+RTfDPWOWoUKuriblRjg0VcELdeoyFogU5ICXSKksR5J5gKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 103.243.227.16) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=kpit.com; dmarc=fail (p=reject sp=none pct=100) action=oreject
 header.from=kpit.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kpit.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQNiVD/DQ6MMl1+qYzuQarvDg88dYbWvoVJJEfV0ZZg=;
 b=DNjMFNZ+xEYzUQrs5FSQI2Oa+8uPrFY670i5t0UvqHuTAha8KiKGOOqL6tEbvTqMSPjcrQ0BxBn5qybkIzvdQR8bdL/KS00UHcO5Lrajpg79DD+fUU8qABL6GvD5ZcAaymkWZh6crUBmrzui11QnxHik74x98Q7VHA0ejYZ2RRo=
Received: from PS2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::23) by MA0PR01MB9159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:119::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 05:45:11 +0000
Received: from HK2PEPF00006FB3.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::7d) by PS2PR01CA0035.outlook.office365.com
 (2603:1096:300:58::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 05:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 103.243.227.16)
 smtp.mailfrom=kpit.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=kpit.com;
Received-SPF: Fail (protection.outlook.com: domain of kpit.com does not
 designate 103.243.227.16 as permitted sender)
 receiver=protection.outlook.com; client-ip=103.243.227.16;
 helo=mail.kpit.com;
Received: from mail.kpit.com (103.243.227.16) by
 HK2PEPF00006FB3.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 05:45:09 +0000
Received: from LL-1259L.kpit.com (10.52.130.22) by PH3EXCH02.kpit.com
 (10.52.16.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 11:15:05 +0530
From: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <scott.murray@konsulko.com>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH] rust: Add new varaible RUST_ENABLE_EXTRA_TOOLS
Date: Thu, 1 Aug 2024 11:14:52 +0530
Message-ID: <20240801054452.57965-1-ranjitsinh.rathod@kpit.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.52.130.22]
X-ClientProxiedBy: PH3ExchFE01.kpit.com (10.52.16.111) To PH3EXCH02.kpit.com
 (10.52.16.26)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB3:EE_|MA0PR01MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: c3aca79a-47b0-4b6a-322b-08dcb1ed1ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vvEGGROtjFqkSLc/1cWSwQTukbWolFQ3dOydDvRdja3BKFTnuJIvLssp+vTk?=
 =?us-ascii?Q?Nae6AvE3SpDxbz86Wnkc6NmxPfZ3o6RiXVW70dpy3Q82QDYPimvnm7+E8/wO?=
 =?us-ascii?Q?CnIAL/uLPN4Br/SZsCpX1NWYHo4ft8e4V8n6s4jPNytqwa7Yj8XU2AWKzb10?=
 =?us-ascii?Q?LhetLBq7iluRr6PMYIOh42x+kAcrHQePONvHNy6vSUfcMnGIRbNKNqhkm/m3?=
 =?us-ascii?Q?Q8cBEKco/cWsg2DqUwLlWY6+gu/Odn2Tz5qTL6pRbUc5VlbtGWFnppfVNnDa?=
 =?us-ascii?Q?qbIboWnCVbsVeZ/v57g5hhcWemuqaJjeGB5wbiukYfNrOXfpGRTGEOJReVYj?=
 =?us-ascii?Q?p5GCTtz5PaZ1gLy4ZyasqFoWW2H1LtpkqE4jLLL2ma9Pno+5REQbjxklwF9M?=
 =?us-ascii?Q?AO8Z+6vO3457W5wzu2p9dsgXOjs/eN7EtdUAw25xfU/p6JoCzVka0/KoaYkJ?=
 =?us-ascii?Q?02FtuTuaan+l+yTDVhtRqzZTWUhbOmoCzSjfhfXnL3TzATAyL1YpDPgMWIek?=
 =?us-ascii?Q?NIgPScccDM41q+QwGkkl340DhFVl71d5W9ZoC+v/i09l+xOSNXLm7jl8yWHh?=
 =?us-ascii?Q?oh+Mp6CMmwRdTpGGl4eEQTPDd0J2Z5Gb9s6AVyJ4IirHW8TQvby7QN4lz2m5?=
 =?us-ascii?Q?tQzPoGT9ToYFKuCWVaYI1egb53nS9IhwmaCtZBJkTF+GjSnC+2zKvJgRbxxt?=
 =?us-ascii?Q?nZHAIOlIXccfTbYr5fnfCx3a3PCOS9huov0l4fNHRQoiT8vBrFra/l+5eQll?=
 =?us-ascii?Q?CzzBK7IHLV2nHiZUkGttLPA7nctKWAcQNQ7hTYjzTNkySmofJcSvfAKbsP0j?=
 =?us-ascii?Q?oYu/8JoPLf24WtrTsmHjHBUkfmAljtMxkdVRI5JodlkWL+vYz6w2aPB9Jk/e?=
 =?us-ascii?Q?WvnfXRtHfGuidfzcDjNSVBtV2RsrTMgfYSJZ9iUcqwRBwCmXpnMJ3cETtf/2?=
 =?us-ascii?Q?NeZm/RdvxURMLZpX4cHgoXgrY+iKU0DJZ4dV0KBnPKphbESjnOWyq9wCLcGf?=
 =?us-ascii?Q?b+3VKoVDsSi0ZkKwyC0N7yK4zW9MjltQg+X4aBKzY8Kqr0vGmtaxb986wG7M?=
 =?us-ascii?Q?d1gQ8BwoVJ0c1Ouss3Wl13lLB2777+nWIiGJKPjP4amMhqjp/wTO10WVBTN5?=
 =?us-ascii?Q?zNYalE1TjIJt/QErYeGodKHXC79VueC6EID/FZo1ufouuYaeYf5I2884I5b9?=
 =?us-ascii?Q?tLwd4KpKa6JNAdvKg2z4MIraT5AQAd9422cs/bI+XfzhmDyIGJi/DGond6Jk?=
 =?us-ascii?Q?nmLHKK4YaYJg/nNiDOVTHphagefRd4ppZ6PoXWu9HEN4PTthNBMUrrTwMyJI?=
 =?us-ascii?Q?fkYLWUPkJgLqSyR1aImN94vdoxb6h1b/jSv3dJrReo/4RYTw2WS5L/UMjJxz?=
 =?us-ascii?Q?YzZScCJkabRU5+Df8U7R7p3QIvHFsj+tdQIAoe7tWxszMxZyC5FeeJe3PI2M?=
 =?us-ascii?Q?JNyEvbtGQ/cYxS46+NZpXxM248wEAEeF?=
X-Forefront-Antispam-Report: 
	CIP:103.243.227.16;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.kpit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: kpit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 05:45:09.2192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3aca79a-47b0-4b6a-322b-08dcb1ed1ac2
X-MS-Exchange-CrossTenant-Id: 3539451e-b46e-4a26-a242-ff61502855c7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3539451e-b46e-4a26-a242-ff61502855c7;Ip=[103.243.227.16];Helo=[mail.kpit.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HK2PEPF00006FB3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9159
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 01 Aug 2024 05:45:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/503

There is a need to enable some extra tools from the rust for the build
and so this new variable will help for that

This varaible then we can use during do_configure task to add overall
values as per json format in build -> tools

Signed-off-by: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>
---
 recipes-devtools/rust/rust_1.75.0.bb | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/recipes-devtools/rust/rust_1.75.0.bb b/recipes-devtools/rust/r=
ust_1.75.0.bb
index 76e1fe2..c33f31d 100644
--- a/recipes-devtools/rust/rust_1.75.0.bb
+++ b/recipes-devtools/rust/rust_1.75.0.bb
@@ -70,6 +70,10 @@ addtask do_test_compile after do_configure do_rust_gen_t=
argets
 do_rust_setup_snapshot[dirs] +=3D "${WORKDIR}/rust-snapshot"
 do_rust_setup_snapshot[vardepsexclude] +=3D "UNINATIVE_LOADER"

+# there is a need to enable some more rust tools for the project
+# We can extend a list of more tools via this variable
+RUST_ENABLE_EXTRA_TOOLS ?=3D "rust-demangler"
+
 python do_configure() {
     import json
     import configparser
@@ -141,7 +145,7 @@ python do_configure() {
     config.add_section("build")
     config.set("build", "submodules", e(False))
     config.set("build", "docs", e(False))
-    config.set("build", "tools", ["rust-demangler",])
+    config.set("build", "tools", e(d.getVar("RUST_ENABLE_EXTRA_TOOLS").spl=
it()))

     rustc =3D d.expand("${WORKDIR}/rust-snapshot/bin/rustc")
     config.set("build", "rustc", e(rustc))
--
2.25.1

This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print, retain copy, disseminate, distribute, o=
r use this message or any part thereof. If you receive this message in erro=
r, please notify the sender immediately and delete all copies of this messa=
ge. KPIT Technologies Ltd. does not accept any liability for virus infected=
 mails.

