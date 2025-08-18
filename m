Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CB5CA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.68])
 by mx.groups.io with SMTP id smtpd.web10.2787.1755554591336126682
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=rIxb2wco;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.68, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUoxoDLkEml3SQbinX/YI+s5dYYIAaExFHNYnLxwWO/nvj6xZGIQU/euT933TlhrypzPrWL0YzRaXtwFr0nrj8VA9WZnEhSBJ3ZbgDsXih57LInECoRZea96tZQc+4tQ7isT4WYXuvETLIEXNdxHdDzBM9iunTUpYjqC55dXAisgfQ0HWBtCFN9/4eGeFX/c4A8SFf1onckmw1oc3I6shYaVRc2r3IezlHHrFM5akrwEw48Xv6ZoTrMQXiIaBccOt81+I1x2npeq1TnkPk3OchvuuASi81maQq+aaWURH8EkaZu+1L5XMS3T0P2Ymkh0NjUj3cIANd7u1Z8seEnvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR9pj7cigNr/qZGbPUp7Bzn1aD6Dmt5eJwLwILqqrzk=;
 b=uuOHvSbHwm3exyBbuQa+rSjOgLmZMEdnyVAcBnMktzG6ssO7wSxPPt0HJnoLZqlo7kIzEVGkMe9EZHguV5rS6Ap9Jgyxf+yi1VX9/GwZd4xhHyrr+AFtwF658zEvvXdAr0mRJA7FvDPyujoX/SkKOWzuBecApljV0/d3CkV1NiI/ayi9kFuhW4THp4QdHiXhpRr6aBBzRgghLeImQFPAzVSnN7s9FizRRZuomHVuI0F4s72vujF5KlkLnOUNoaBAMrj4Os8tgG8wg4b957o25qBaFnJwII/PRmYO6WXRUz6EP93W8I80gBF0F+qhWJdg4mVB4VXuTC5mY9QLqpFOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR9pj7cigNr/qZGbPUp7Bzn1aD6Dmt5eJwLwILqqrzk=;
 b=rIxb2wcouQBblz1WVeNKx4uk9iSfK1arxb+2fnE/gvTQHdD1wmoqMobHT1Utlx66+QBrmrjtxLZXafMUVXGyTnEpWfX9GYkneBExxudEnodHDZUo6TGrP+nszTlaMIKnWI/PINNc/1AXNZam7v8o0M+OfX+W/FiHWNRIlOn8ous=
Received: from BY5PR17CA0053.namprd17.prod.outlook.com (2603:10b6:a03:167::30)
 by DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 22:03:09 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:167:cafe::93) by BY5PR17CA0053.outlook.office365.com
 (2603:10b6:a03:167::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 22:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Mon, 18 Aug 2025 22:03:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:08 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:08 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 11/11] zephyr-kernel-common: Add Board extension support
Date: Mon, 18 Aug 2025 16:03:04 -0600
Message-ID: <20250818220304.2300436-12-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS5PPF922753E5F:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d1aee5-6fae-48c6-a4a7-08dddea30420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?x3D7eq46yXhIZmIPreSF/YN1CKzoeJOJQ0WKK99+vQM/0DucibrumXVaSW+k?=
 =?us-ascii?Q?GIM1X8Py2DILgSiSaryj2AIR8Fqcjku7HkimpMI/mS/6ek0Y2M1AmTB/gyf0?=
 =?us-ascii?Q?DlOM8BIpABAdy3ahSfcZuIyUyciLLiv2Efx6HrAtIB2fgdpLvHkngVQI6oRe?=
 =?us-ascii?Q?vuNB6pRFnWxmn5bi/dTLR7ThX5M7+f/hg050iLVuCVf/QECGZxglCyo+RRip?=
 =?us-ascii?Q?1M0apx0cajTLRTo2EpLNNUKsjdOoLXeDcnMAn9IgOH365M3DISCzy1pqtsEt?=
 =?us-ascii?Q?xfKyFlxgMrmWR/iaEiu8nvdg1IHawHODbkWn7B4yt2odoM4qRQWYRtuSqH7v?=
 =?us-ascii?Q?UIfasPmt6Apq+eAJuLuqXQ1792lc1mkLhYJzesCKvgBAyX48unt6qC+LuLi2?=
 =?us-ascii?Q?tvO1N1M0dIc8WyK3dQfPPLrlITX0Rg577LUclCTlBZqd9PT2QLR+LBsdbQKv?=
 =?us-ascii?Q?ZSIqcfCIntDuRMbjxXhkSQrXXMSBfqMKPr6yUQ73ruj7oHTDEeeeZJh1KXt2?=
 =?us-ascii?Q?Lw1/XcnZNVMFHqErdwFv56fqvy8kFVn75JF/4ndx/Ujwn88pwNgCYUKpHgJi?=
 =?us-ascii?Q?t9o25Gkqlx+O1rFLPa1orOeJR/YjlMk9sYiWU+8X4cIfIr4rTr7+FhnugHRY?=
 =?us-ascii?Q?/2Pa1LS01Ie0IwOyB46uUqAl7ReJevBB92U0M0h7v0rXWe28Via0uG7sWQZ3?=
 =?us-ascii?Q?n0VM/dVJAFle4mb8m8vtXQhbDepOqnalrmE7hQfZAGbcJt6W5C7MqOVVX5fU?=
 =?us-ascii?Q?bPXvTMgArsUkbqvmxiJ08/EpS4z2qy+maeOsBhIJ24GbsbcMEuLadNriJ9IR?=
 =?us-ascii?Q?CX59Lkw1miZ0cjTPuJU9osTzVC7ScQ8jACWNogKkq6EQTbIUxhiywLbUEbqW?=
 =?us-ascii?Q?QAzWMKCfitkflwftOiK2FtmqRR4rGQfvaf7GsdCtRZRYbC7mSjNi5YjTMEUr?=
 =?us-ascii?Q?zD5HkyhTiZwLT8UWMeN5PnglVUhrqqm7FSqiPyLad1NAm/n0sLkht02oAxUf?=
 =?us-ascii?Q?f2+JRyJ8OuCmAbSRhDJDcYhG7YrWMvNo+q0Lj13SwagZS4BiJYt7MMABsx1H?=
 =?us-ascii?Q?YE6nRJSE8ggUfCuItbG4yBCM2bgWEMbC0sNiPS3YN8qzVkit/JEW6xKcCk2Z?=
 =?us-ascii?Q?oS0fTDJtNBBum9zfbIACZ0zM2XBisJuwP2J1ctNTwcnKtgPRQjj/7hhqVM7s?=
 =?us-ascii?Q?kaMYtGyFHs+IdqeZJRbw0s2IoMcZfFvMHEhOIJYV0at45qTI1IBgN7xK7enE?=
 =?us-ascii?Q?z/BZEzEJFhpHAa0WR5aoON+QGd/UeB7pL3JFprIRDWMZ2aRP23vlYq/bRGzP?=
 =?us-ascii?Q?x4acpvi+bU0Vxxwo8X6S/ZLnwtVq1kQISjb+FEP8qkWeI1DT81JSGOwntq0u?=
 =?us-ascii?Q?sAtuikQCuLiT60K9AE3Pg6H9yBAVkKvSLxGRvgpHWxEBAnA8139yfQq/XP+P?=
 =?us-ascii?Q?6NrFNl/nm/nOQOA2Jadbc6G5R7IdJW74/wnJEgaQEMGQHEIdmtaIZEAfV89N?=
 =?us-ascii?Q?iLTHmQ4cs7rTHlV+vHMaLUVnbZPnz4mN3VxT?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:08.5408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d1aee5-6fae-48c6-a4a7-08dddea30420
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2045

Add board extension support variables where user can specify the
BOARD_ROOT variable for out-of-tree custom boards.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc    | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-co=
mmon.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-comm=
on.inc
index 5191b9a..579fd6c 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
@@ -18,6 +18,11 @@ EXTRA_OECMAKE =3D "\
     -DZEPHYR_BASE=3D${ZEPHYR_BASE} \
     -DBOARD=3D${BOARD} \
     -DARCH=3D${ARCH} \
+    -DBOARD_DIR=3D${BOARD_DIR} \
+    -DARCH_DIR=3D${ARCH_DIR} \
+    -DBOARD_ROOT=3D${BOARD_ROOT} \
+    -DBOARD_EXTENSION_DIRS=3D${BOARD_EXTENSION_DIRS} \
+    -DSOC_ROOT=3D${SOC_ROOT} \
     -DZEPHYR_TOOLCHAIN_VARIANT=3D${ZEPHYR_TOOLCHAIN_VARIANT} \
     -DZEPHYR_MODULES=3D${ZEPHYR_MODULES} \
     "
--=20
2.34.1


