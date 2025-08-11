Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DBDC87FDB
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 15:00:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.57])
 by mx.groups.io with SMTP id smtpd.web10.50425.1754924393870858019
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=aTW+ueZ3;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.57, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTnip4q8Ed1ALe4g0JzcHe77vySzwkcfYvJ0maczTqWBqGmhY6NrHwYJzn+1JzATqhNuBrwhVIgQWDuqDhu49o/gGvYY2uYpTrtQgCHATuivIa18N8uDr2K7fujCdgVW9gNU9p7sND4Ny5z33humc0x+QfB8IxU53P6Wfe/Atu1NuKDfII1l+hn8B4KLKtg9hNJTkzVl2eXDUHQ7GLsY7Cyj9q8xI9fs/I+pGkp+4GOzqDk8RIalJ/fpB2xu9lZXYpHwyKpNCMulO3LtWqhPKPP+8sUpHjQ0YjFpDMeaJAsBw0Ln1ZE8pEquWnIUL36fYGkelG5dtbhShJBugT6wcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=sjEhzgu97gt9SEq5biCEru1fpV1eybjX2345NGCX+tov+WYQoO3WJ8UR4WqEknOHGYhbUr8rrNhNaGUpl9nOIA+CFwBkt6xn5dX+rC5DUQ9HtvpxhpdXIvjztAGp9wA8Cl2TTTJoDjKIj5f83mJ/YJ8Mg66sJNjvewMIr2KO84yh0ccjRRVdwahQCc0MO/Emt5VTvekFl2drhKyJwG8QW5nilrkqylo5xCFTktnt84BuQSS3IfsDQU8L12wzbZIhS9BEzoYbpvvdsvq4mH4zmHgtwFpf0adnLynaXuoEiuspaIawVQbqh8wdBbjFwn8uRKC1BBvkZbJKPOiugP3xtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=aTW+ueZ3hAFMQ+/KHB5WgYMo0mJ8PbN6DyhiwM6/YymjAlUxMamCH3ThiXgltGtvBJdW5RJlTWa423+Loqci+sMDqNlgJiJ/lK14N1TrGKov7qhn6zmV3sPhxqBRkAOjtqopkm0JYggZ4pzxAZ4fgNgpEjLVPi+XtOoRYb+W9Mo=
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:49 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::9f) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 14:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:48 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:48 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 7/13] zephyr-qemuboot: Use image artifact file in qemuimage
Date: Mon, 11 Aug 2025 08:59:35 -0600
Message-ID: <20250811145941.2553838-8-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
References: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: e0a7116c-7f0f-47c6-d057-08ddd8e7b823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sDUT0gG5Wr2AXOokb1c49V/ob2W25RX6pcpO1Ci2KzwPYAh3OXDitBcGtikh?=
 =?us-ascii?Q?U9cl9T+yfJhgmHMa8M9tdS7X5yw2zYnUtxwei2LoFEryr4miesSI6yC4ZUH2?=
 =?us-ascii?Q?sbdVjqGTDFj2m2BlaGvm/u5XMo2YUHj6qIv4KCjT5Y5YUZ8wnx4NoDAbMQfX?=
 =?us-ascii?Q?h4NpVnKJqLtvwP+7HFOfMCyivguPF56n6WCSa+s1vdakz2wP18I+3SQytSZa?=
 =?us-ascii?Q?TcAVJYwENyleN8mDIe5KKTtwNpUTdiIlPxo/vV48BDRHe2msgIr17MpR+qv4?=
 =?us-ascii?Q?WSjU0O/C7nMtnD8FetAiRS5TsER3REWPNOK0rQiChVjnDf9r/7s+neiQ5VUU?=
 =?us-ascii?Q?7BLe8JSQcHxWhX7fkde5qcCGU9VmR1hW3N2d2TddWKKH1Fp6XnkLGYQ+5y8y?=
 =?us-ascii?Q?hR8b1dFP1cp9ICtKZWD/VhZn5Y3ilM1FBOZbrp8ktHsFxSQxlyE7Y1nmgcGf?=
 =?us-ascii?Q?yn+vcg5VbMONk5gh+whS/A0c9qApmFzNgMKbWcslGteq+nCq8VxHmyy8C54S?=
 =?us-ascii?Q?uGqIWBvIgjDqXEU1w4D36HTo4AB2j4/+2TEzuIGFjV0EIwmwQJGBlGK9u/rp?=
 =?us-ascii?Q?UDFfMWVBxThrJt96DiLUx6U5IraBB0TTsoJ5lTkp4bbRv/Au/37nL+t3rg8a?=
 =?us-ascii?Q?1GVPp7ntk0ntZVMQgNgUQHzUBbinLk9idEQ80LGyPUC6AuSKwP8ZEzpdC5Z6?=
 =?us-ascii?Q?HxPVSnXZDsQXo+MvO4oFk3l5qiyEXej6RDrxgkoZk4l+31iD9ytpUH3ImN64?=
 =?us-ascii?Q?J9H8zMV3xgSOFW/lS/odI2nBvikOs38dG3nz+Qstt0KesQu3fvEPs2nWyHxZ?=
 =?us-ascii?Q?U3ysGzAUUB2nnqT4rU8lNySfGbtQ1ulUYc/PCXAyMlD5qaOpvgsTR7MiwlVS?=
 =?us-ascii?Q?pXXa/BjgKUiPbN0K7kObO+urm0yPz6LMG/uipq5c0ws0InVJYZ5ae10OPd9w?=
 =?us-ascii?Q?yQt48+Sdcq73j3k0bob+CORk1k/tzovvvjT2GzB9vhxllomCBxREHXSUDWXX?=
 =?us-ascii?Q?AjLoRiH+j6V6pMIdDOZjSgx3oBSMuoI4MjaIQJgxoP+jAX9/1AqIcYwX0ov9?=
 =?us-ascii?Q?d8bZ+puM5brsW46PKbrEse/zRxzstkkVX4Pb9DT6eTqIMpm+MooPNfZQlqsZ?=
 =?us-ascii?Q?vCEJK6imEdL1lQsga8V9rBtq6apNNzmKefY3A7BpbvYQEPU76AyM0rDPf7n1?=
 =?us-ascii?Q?uYBjKyTVMSMABG7QK+JtOQ6rLnU8K4f7PEr7hN3YoILciQL3Etrlw2F5ib+u?=
 =?us-ascii?Q?sD/i4T1gQZIRiwsrxqM/pXQUnBGo2cgc2Dx0C2qfw3CSsCJZtND7r1PwbjbV?=
 =?us-ascii?Q?9Nv/koACnFftRCILfDx6SAqBlVPVl190x1XCzOnMprM7cQk22kPpN8+xc7kM?=
 =?us-ascii?Q?152rFdahLhVIU1m0VYaqdDXME6j/mhJh8GH7YJC9Xu9fCkC3GwVsvWNGm00Z?=
 =?us-ascii?Q?T9/ARYxqU/iHb3mpuiZpgiUhIv0VUn5/18d7w45L4sG3eos3DJZ9y190CYAg?=
 =?us-ascii?Q?UJLYJowGiEwOUKJ+MzN738baBr9MGBv1fyPn?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:49.4421
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a7116c-7f0f-47c6-d057-08ddd8e7b823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 15:00:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1933

Use image artifacts output file in qemuimage link.

Before:
zephyr-helloworld-image-{MACHINE}.elf -> zephyr-helloworld.elf

After:
zephyr-helloworld-image-{MACHINE}.elf -> zephyr-helloworld-{MACHINE}-{DATET=
IME}.elf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass b/meta=
-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
index b45e6f6..ab0a281 100644
--- a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
+++ b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
@@ -1,6 +1,8 @@
 inherit qemuboot
=20
-KERNEL_IMAGETYPE =3D "${PN}.elf"
+ZEPHYR_IMAGE_BASE_NAME ?=3D "${PN}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
+
+KERNEL_IMAGETYPE =3D "${ZEPHYR_IMAGE_BASE_NAME}.elf"
 QB_DEFAULT_FSTYPE =3D "elf"
 QB_NETWORK_DEVICE =3D "none"
 QB_NET =3D "none"
@@ -27,7 +29,7 @@ python bootconf_clean() {
 python do_bootconf_write() {
     bb.build.exec_func("do_write_qemuboot_conf", d)
=20
-    qemuimage =3D "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.get=
Var('PN', True))
+    qemuimage =3D "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.get=
Var('ZEPHYR_IMAGE_BASE_NAME', True))
     qemuimage_link =3D d.getVar('QEMU_IMAGE_LINK', True)
     if os.path.lexists(qemuimage_link):
         os.remove(qemuimage_link)
--=20
2.34.1


