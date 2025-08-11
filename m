Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6108CA0EDC
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.79])
 by mx.groups.io with SMTP id smtpd.web11.57127.1754941616431553355
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=y4DJeH+3;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.79, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd+eL9fsKnCgmmbsm/nIQjBKjZyk8FpPmO7I7uEg2tN94YVy1fFGo5vxZaA2joi3bwhwcpXguoO0Jp/aTptlBRUrzeoLgpyN6FKs7Fy9okeSUB+7ZbXRxVi7MyZgYWevDrqTTsgx5/z0MnEM3g5p4g554a2YK54MgwIOwnODYtoPupZWLPDjjplsyNrX9sKOwKje1e6id8yrj/Qkn0EIn0wPjNzvpxyyWQNXefYWoqbMClTsVX1rbntAQZ97Pqj/uDipwJpFjHwfeQu5V5ikb4DyCUGeQGYJQDZ7IponT7QQTke/AoE7o6u7EtuKIC8GehdjKqbpECqpxGwXVpDGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=T7DUJ/asmhRh2cKcTs9ydZrGepVLamp4pgy+4bvOXlUQcfZ2T6mpbGe9cuHBJ5kJYARn/MQ/nwVE2ABwty8ZuRr6kvLsGmryZ5yaMi5s6PgsqkUvZG44W8DtNYTvt+15+Y6W7msxiiPj3Q7dSSieAlaraijFWXbmvJT4nO3YV73+f3mDYYPqX3QnhAT74ZWEVz9yN5SbzsZo2ExkHgmzfcaQ5sjReRyOeZYb2nwcnqfKMcG7Ms4M7T6hzhpjdoLqNGTV6qUWBAsLkEnnCIeeHXQwBdov2R5Z+R1G6FR0jS1GOJzlQ4Y6mB8FjVPiFSydyWWAwEwzUcOG4YBR58+p9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=y4DJeH+3Waub1q/0vriUGL1l1ywT2qS0ro48bEL/9Vgb4cV1LAEUgrQgE6gN+DUWunidF3Wmy/hcaLr9P0aNgs4+S7uKyZfgr50rXeyhbTgAAVV1jjgPw8JmpWxT1hzJb/fPaypElJ+v9Iqeuk717lpWW3rJg6zIpVkjmd2Kxow=
Received: from BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:46:53 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::fb) by BY3PR05CA0013.outlook.office365.com
 (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 19:46:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:49 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:49 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 7/13] zephyr-qemuboot: Use image artifact file in qemuimage
Date: Mon, 11 Aug 2025 13:46:40 -0600
Message-ID: <20250811194646.3408854-8-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: ef203b45-3ea5-4e4e-31e6-08ddd90fd20c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?N+/rM0M9Z60wrKpr+/50JSAp1M757YBhGrSReTMwNxW8nB6nHxH6kS8CxVmo?=
 =?us-ascii?Q?lEY+XGIkbhHm0oJsVMZoH+cdILMGfqUzfWKbBp1BfAbuI8oL5s/fYV49TOD9?=
 =?us-ascii?Q?ConLuS/JNAaVa7PlJneoiLGXRPSQ5aT67L3VzFtvePn50gooUTIIhZk1suAd?=
 =?us-ascii?Q?vfVFHaI036/NHacbS+I6xbi2URaLsjgXfEOWfZuz9QW/HmYFMMlAy96RUgQU?=
 =?us-ascii?Q?xgTv3JxA8Mdzd5lxsvnCV0N0+3ygeQ7by1ClIRGcef4GnP6gGWUnorPxG80Q?=
 =?us-ascii?Q?8vnf3CE4nUmvMhdaPXopeEbCHArHUlQ/pRDGLKD12KY12JgH/vlYZgB6ng0m?=
 =?us-ascii?Q?y111fT7kb3wvkSFRQsAYizQkAlw6d3lAMTMkPPuouCRyKDVoejj7pejLuOMy?=
 =?us-ascii?Q?y9qiu5mz9jT93NkwPkwTfMZMTqRklPNoZ1lTH0dXlB2it+ChPFtYxeYXB1oz?=
 =?us-ascii?Q?5Gj2qFh5ZlbLZpq3D31uizsg4TTiebqBmkJSd7RwP8A554glszVmF+RfvGEr?=
 =?us-ascii?Q?uXYE90UFiEHXRsIudVSDX5rud4jQOFnpctVN3A54XSoieFyFJqwkRGZedoqg?=
 =?us-ascii?Q?TIj8qOGPy4DSe50Ht2YtO07QuGSqjEhallBpCoMOhIq88T8w8EGaK3sfUmKB?=
 =?us-ascii?Q?hqfbpGDc/O8T40Srxrh8P7QvSwZ2MdDFbS1xooXvlijlVNxhEd/sBLMfGrRn?=
 =?us-ascii?Q?a0BxKkz0e8ITK0dsbJhGCQCmH7uQ11qP9pTqeBdONo1XAoUQaHY68UJMhK4q?=
 =?us-ascii?Q?nN05car1NpamlmhKLTaPbR22S/dPGBjGVSbCNtuYCoaksI/5PUF0NVAYBfZo?=
 =?us-ascii?Q?shCarDBTAaE8v9wMU/o6jGDXNp2xuXvotdXwYd+lgBGCP56Hs8sEuW6jsZAB?=
 =?us-ascii?Q?6oXqcsNGjR/m4nJBde3UQWzLMDlxJG4QpS2RFWJujYeX6cX9eqH88Ao+7HgV?=
 =?us-ascii?Q?zRwLLvJUI+7HrJgsP1Yhf0sEqbElboBdHl342S4tJ9NFcOthOGwQ5QouubzT?=
 =?us-ascii?Q?oZTYm9qO8XafsVOJ82HWIf617/smVnSpqvtYQGThnDRpsP4IK7JDcgln/Ze6?=
 =?us-ascii?Q?LPN/bq1hTt/ZS6i+FrW9PQmqpDOk5c4BJ3YMgD6Gy/ifpqcs8nyzBz/RqfdI?=
 =?us-ascii?Q?KqEc3ieGdRFQAIS/luxS81a+fuzcXMu8NOo8VopUjyzGEA2Oqqdudr56+CBQ?=
 =?us-ascii?Q?4ZssHeU3zpUyFUQAEWx39nn6TX7p0defq+DEOZ00CNaNWwMaBBo/MLQvCNmY?=
 =?us-ascii?Q?Ydis4ZOEMHGAbweBpDSnH1OX2W0k+m1H8TjbxT8K2QskmH7ztoUKzgyt9mKd?=
 =?us-ascii?Q?qjtGv22nzWIZxQyg4PDouj79M7SXoVsKCmMEP9ZWWTz9KP4788e0I6qkT/PM?=
 =?us-ascii?Q?vQgo/cw0sP6IMGm0kuXBFYT01PmFgOguHEX8ljVMuO6HZlIlEEwJQ/N1DvXW?=
 =?us-ascii?Q?CtN1/EH+PDeXkICU35MUyXxaMnr0mNecwtV6zuNMQ0CmKpmmltR3PBI0hZ/C?=
 =?us-ascii?Q?2M90fLfsHlDFfjQvF8Ywi21n4QtuVUquh3ue?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:52.6883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef203b45-3ea5-4e4e-31e6-08ddd90fd20c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1951

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


