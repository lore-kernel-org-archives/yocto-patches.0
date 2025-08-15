Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56CFCA0EE0
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:54:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.79])
 by mx.groups.io with SMTP id smtpd.web10.4393.1755230097031441507
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:54:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=KgsgOvVo;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.79, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B24Zvyf3QusjrVqJxGdOZssGkfv9aDdsRFwQglkqc9Fx0sYS/eiqPUXNPXGwcdj1QjWld2mpbUgDFYuTSnPHrZ1m3marspaDkJVLXGx55kvh46CfkYWyTUmrElIE8xhPU9EWvBCMJAv6pIGAN9hbSds+ow1B/9OnzJl+VJwSTYOLtHwS5hlF1o/zsV88qzr8Q0BQxvWHlP+mAIOigwLX1cS+45YAVR/RCLr8wlRPo1JayUGqbCJra+ik9PSdiJSqUse4UO/iu8zHHKIx9p+DMwod+J9h4b8w4RBDXnzCFsU0erNglwZVaqLezrsk7aiU6My6meboOJbS1P/ZZPwUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrUqEzFIlg04/i3koZOVR97gWt2xccXiierBYBPsdMI=;
 b=EjV6Jumb5JGwWBj0VP+RPI42Zgrus5Vxy68jlqY3z5Tgw+wvuNtIWUbJ09EpKnYzSqmvrK/RO+vvj7tLvVMQZJQaX3u/AfBHSTV96M8vMrmpI1xZn6r4o3HTZXmSEXSym1MDEAJRlNilpATQTGSMI4lpoRwlbAG/cmUnsmrNQM8pE2yC6Yz2iX/qT6U03waZpnP3JDvxbdoX12wzNi5ApVSn9RIz5oyslbymjwFnipE33pC78xzoTE25/QgJvG+Ojn2WgwL+4oayiHhXMeLyg59X7HUolwDDmJIoKHHFg4o6Zy8jej/wcewKj+NtK7z6ge3PGJ6X4IJP/ql34OSzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrUqEzFIlg04/i3koZOVR97gWt2xccXiierBYBPsdMI=;
 b=KgsgOvVoNoKAd0iRb/WZ557O/eDrdEQtp1vmwUpfrHxp5yXLEz9MhuLBOd++2VXKtDQNajwCGYb4hneFqNLn+9anuDwt2Yk48GHmVQwQKU7MqrdSr8vycVSm2a2aU2fxtyuNsWkwMEJBGA0YwNqgPsThmX6A3PMH6IrpGzpE6q0=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by CH2PR12MB9518.namprd12.prod.outlook.com (2603:10b6:610:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 03:54:54 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::27) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:51 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:51 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 04/12] zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Date: Thu, 14 Aug 2025 21:54:41 -0600
Message-ID: <20250815035449.2816001-5-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH2PR12MB9518:EE_
X-MS-Office365-Filtering-Correlation-Id: c823adfc-75a9-4a9c-dfd8-08dddbaf7e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/bscsK+Z1jPs3RNOgn0FoL9l43/4GwgZUukdwlIeYmWLXkfgKFVSWk3T3rAY?=
 =?us-ascii?Q?T0nlpMxIi75lAjyFpCOZjwbwJnbztfTwEIKxbbfWh/Xs9VyI0n5Axlk2+2VC?=
 =?us-ascii?Q?ch1EcGJVlKIBuq+syb5ac3mWLRJ3gBR5mTwiiEHIpHZHsnwzbWaN4AtXlZZq?=
 =?us-ascii?Q?qD+WFIfo5/EpQ0THOyKi/rbtXcYZiR+2oHCfj8i/ZRZiXqKWHK8hq3/f8xBM?=
 =?us-ascii?Q?+XYYtwmPQdgccKrQToNlRhYaKWCcyI9PbI6kfbbKs8MxGMZVdVuNht+xoH1J?=
 =?us-ascii?Q?LdOe2Aeneo27Giyb1zr2R4S7G3nUyHc3kmUD/iJ6E6fWq4v+aJUW7PqGh6Kg?=
 =?us-ascii?Q?LwPhH/boIp0huJznYBzq8wwKlHZB6O76FtrQzIdEnd54LmnycgDEqQI19UMb?=
 =?us-ascii?Q?DE7FrCZf1XHoBhgFmWTGvK89Qkg0YYQgvf2Vsfer8UR4K9cxFLpUbOdO9RKO?=
 =?us-ascii?Q?CXiGFImW6f/xLNKjYO08ra13Au8suDY72VAMEOqxOeU7gEf6MDAXwP08Qjbp?=
 =?us-ascii?Q?bDgS0Cl5i4BWIWDp/KX/79f8vT2IHmDftkAD5Jrpzj4z9i3H2dGjPF1fyIcp?=
 =?us-ascii?Q?o2E1A30te//PbROYIwruDAs3TtkmldG6npRfriuKkZtrxDh9AlDKaf8rJ97G?=
 =?us-ascii?Q?S6ifW6qA7Ya03gntxnWUjij++q+Pmfvx+w6Wtqdr0dnqCWwt+ua1NjsjhoP7?=
 =?us-ascii?Q?GEN755p5Zvho0tN5S+7pWrhhhtTgzkFXdfZ1NN7HNj7trDMQno3zDYu39OS7?=
 =?us-ascii?Q?FBYyltOThdPhYbJ2pOAkDKt7gVabO0jDiywC2Cn46OO0cr9EZtfnCN8oHnbP?=
 =?us-ascii?Q?EjPa+mpxP7o4IXdZHKPsfdMWqMZrf6zzLBKgDqJPo1hfV5m0cDpUvew6EgQK?=
 =?us-ascii?Q?GuoDQ6UCudcT7ZDgpt4iBrNSAVIdM7DQm0bZ+6tzwl+0Vpnb4v1PEEbO8xVo?=
 =?us-ascii?Q?VmbrlFipvAHtvji+ZVjHm4gUOR+w22BJ70NDRvIMOFoY923USNcMaGtayXYo?=
 =?us-ascii?Q?RSntN006ZprXCUy7uABh7x2gUPQkB9Bs+ie6/CeRlXvNCftmjKyDfBR6ZkXT?=
 =?us-ascii?Q?kY5qUpZxAI1xFTxs+T+jniaXFxJfJNTUsS6WE9XjErlDGkx8HC9Shj87dIOX?=
 =?us-ascii?Q?GbfUf68y6Hw13qT0f5GkD9iDSqYk8JoertBv15SGu2D6MqssGfxQ2pQOH3jW?=
 =?us-ascii?Q?FNKSPk0Icv52ouqCRB4q7awvSOJ8zr0JcpUAhr455n2KU6J9BvaeTsFoNAC8?=
 =?us-ascii?Q?pyH8rkYxXk749x7R74DaoXd0AL5c8zqCO4epGTyr3UfGI03/m9ceu+s9FprK?=
 =?us-ascii?Q?AGuKNytdc43AafPQRw5dvmt6I+wEMhqMvj1wCovgWfO2dnq3jFRYlnvewg0J?=
 =?us-ascii?Q?ODInQvGiyMAgF1mrN8svPEHi77sS3EAX4gqlVUwAWkhJyiwwNjuuTlM4KyQ7?=
 =?us-ascii?Q?TtJSizVMaDUi1qkeBj9Mi348hzMec5HHARp/+uHAOGtgGtMu+sW7oG25VOlJ?=
 =?us-ascii?Q?4HmT/+KF7YwT5oCObj4Lf+u3TwC5oQGtOY0P?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:53.8486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c823adfc-75a9-4a9c-dfd8-08dddbaf7e37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9518
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:54:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1990

Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src.inc
as this variable should be in global configuration file and override
from local.conf file.

Set default stable PREFERRED_VERSION for kernel and sdk in layer.conf
file.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/layer.conf                               | 3 +++
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc         | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index 5afec0f..c04088f 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -20,3 +20,6 @@ LAYERSERIES_COMPAT_zephyrcore =3D "whinlatter"
 PYTHON3_NATIVE_SITEPACKAGES_DIR =3D "${libdir_native}/${PYTHON3_DIR}/site-=
packages"
=20
 addpylib ${LAYERDIR}/lib oeqa
+
+PREFERRED_VERSION_zephyr-kernel ??=3D "4.1.0"
+PREFERRED_VERSION_zephyr-sdk ??=3D "0.16.9"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
index cf1b593..34b2cbe 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
@@ -10,6 +10,4 @@ inherit cmake
 # find the patch(es) in SRC_URI.
 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
=20
-# Default to a stable version
-PREFERRED_VERSION_zephyr-kernel ??=3D "4.1.0"
 require recipes-kernel/zephyr-kernel/zephyr-kernel-src-${PREFERRED_VERSION=
_zephyr-kernel}.inc
--=20
2.34.1


