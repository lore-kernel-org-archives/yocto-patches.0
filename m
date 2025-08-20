Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAF8CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 14:20:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.53])
 by mx.groups.io with SMTP id smtpd.web11.21056.1755699600867161282
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 07:20:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=irdduuWQ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.92.53, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AILgefgXzaG9PXwP+J3Qnd5jV3AjjiEk0LmU0CplLFkenrEUTzq6p0ADocL40uNNGkFTGTL3DdWr/CS05KKaw5FbuoW+NyTgkvFYGa7Ly/ueIvJbhWq7qWFuNOw/IYRltQRhJt75uuft771sTVFjv+YbLg9RxHE+I/JBrX/w41FSZiZIx0BYKT/fbNFzfhyxuUhOZXABQ4Na4XzrTmeoHczBYaIlq5nrP5dK8OPftXxE5nqATJjJYCioUarGI7MfkU85OVcAlkPKdDjmZapGfA2qjqA77VSaKdbAxa5Vi0Zv6trcGxIiqCr+zP6cR1895A4ypfm5BDnFq1YZhl0kBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv8E/JBjClBsbjweDd3WBtCkVdcvCGU5EO0w16iLZ5I=;
 b=BhOUkltJZ2t1tirU0cBxEoJjBWtBTOYe0palw6lka7ORdPJ3BuLfQMg4OL88iO0SJ/htIzVwbeJETLvdy59eAMzNIDhznvaGcnNoLNbTrWe7rCQd5ERCuw6W/f2ILsIqG2mvHNbbfKNNuO1apHhWcMdR6V/i0vrhpQDRqFDbZ2QkIfiBXF/5SNiCFM7E/wkKIcswiWWiZgWC37oE8hS2ZzwvO6+5T5G3lQe2rWwYxNJIuUOXIbQ1ZZZYUmbegDvvPf3lj+F78txK0iTFrpvZaG+4OEPp2ZoB3mASlhROu/86bhOypNw/u9oXdHTdAOje1742RC+8j/5qJnvrew9kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv8E/JBjClBsbjweDd3WBtCkVdcvCGU5EO0w16iLZ5I=;
 b=irdduuWQ+YsmuFNhiwspNufdes7cSxN07dGJ2JwiBfuu/ZixuFAlGFK+MCag11DY7bNPiy4UYQhYjNRGlXf5Z/CcIr0Z2XaK57zMRWvZNRRmE7DrxG64n/GlYMmI/ukT0y4M3HAh+TwFNA9897KMChACXZ1G2l8fPr4aslhNk+A=
Received: from BN6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:405:75::15)
 by MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 14:19:58 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::f7) by BN6PR17CA0026.outlook.office365.com
 (2603:10b6:405:75::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 14:19:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 14:19:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:19:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:19:57 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Aug 2025 09:19:57 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v7 10/11] zephyr-kernel: Add rpmsg multi services recipe
Date: Wed, 20 Aug 2025 08:19:56 -0600
Message-ID: <20250820141956.3197642-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW3PR12MB4409:EE_
X-MS-Office365-Filtering-Correlation-Id: e2838381-4bc2-4fa5-71ef-08dddff4a471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WWTo0uKwJZFhb29HYrR7fPg+1eAFEcgheuV6OAy61XEWQEboeFmJFUNxANdA?=
 =?us-ascii?Q?HcDHkCVKYuCD+yZBGncUlpaS+V/l67+z8aYfYumKooA0kb9j3JUfyPWYdnnd?=
 =?us-ascii?Q?3DKaVoMDHjES1vsjU+Z5xy2q5fIpu9qR9bL4HJrTzd+K7FzzPOFEpUtrUiGj?=
 =?us-ascii?Q?9vI2ZWRJjdh9JHo++eMTv477eklZuFG5tq6kmZEDhUeAajf3Qhdwzpse5SwQ?=
 =?us-ascii?Q?+km80OCzCM10qUsZGgXpTJJxXv/aLrfTycd96PDn3t0bJ1/4mChqA1dwp0FA?=
 =?us-ascii?Q?hBlP1RaA3sqZqW01VD+2vxSS2mD0k/7WT/XkATaC+/u8GjoK1JhBxrGe0+zD?=
 =?us-ascii?Q?9PWVJVqONfv71oFWJ0pwiXoCay2OhZAelabOJ8UgAmAFxKvxzsBlktfrm0Pf?=
 =?us-ascii?Q?lnUYMBo+asAJctr+YUTY1iZgTQ9H3h6ceSKIeDpDBjyZi1zrbnBA1zGdgVLb?=
 =?us-ascii?Q?KNYBjdIlMYcg1Xs93DBlY5HrYuNkH+esCo/J6d3g326vq0QqQOTbhG1XRKE+?=
 =?us-ascii?Q?xd9Ms4a8HAp6fBDo/z9Imgx4lsNhfoJaLxZp/cS4a0RrFh/54E9QN2iNjzAw?=
 =?us-ascii?Q?jptHDCQGGhSz7n8aYl0+GCYUpyDhGdZ42vVAB8i8LaZasfTeM5leBHaqhXHS?=
 =?us-ascii?Q?JcNWikMpLLMmcaSbCOiULZY/LUq0vL3j8gGBvSvbYs4f2vo3jtnwRTl6vc0H?=
 =?us-ascii?Q?FPVL1/s5blk4X7iolmpZ7qOVsJ9LxZZMQIzdw0LcoGdasep6gcGWvOCeaIfC?=
 =?us-ascii?Q?EMvCPAobmZcqkUstW9GN4Jod4IIMAOBXKhbr8/k2ot6gN+IobuCo8gg9QaHw?=
 =?us-ascii?Q?URtg3xmlZ4UBd1mthiFUFcnzGLyv08wPDEPGO8axap+yb/EGVJ9Tg48mKtld?=
 =?us-ascii?Q?9Jpzgj/vigUQdCUIZIRgCBw+LiEEwBYxrL4ulnkhiblzAVWE1DHBk2UUoCLG?=
 =?us-ascii?Q?19oEZ85+7m8vUAzdZCXOu0BqYowV5C46mIl7SraXFQceRWLTrbjN/m+di7Co?=
 =?us-ascii?Q?5Cunjz9mkERV2L8DimWryq7UrKpm8x6cqePljXZajzovGaPJmpGnocsQI2T4?=
 =?us-ascii?Q?QeeszDbfqHBBkuD7ZBNtzrx2U4VNReyAH6Ks7sdNZ0Hbyzk3yEq7cUx7n3Od?=
 =?us-ascii?Q?pGmaebAVCYT1SRKMfdL+RK+aGr8LGNR1FN6lL6zP7ACl0y1CMjHdn3L0pSUK?=
 =?us-ascii?Q?V3OmzUoVt7KnBZwPqx3JuV8+lMVxndVYG5uq7IoYQcFr8mgqxoOf6MUG8O+l?=
 =?us-ascii?Q?5nWN+mQcEUSk1TXin1Bb1GqwhwGjvYvXw3VW1+HmXQrS2OuB9mBbRwwT4Vfr?=
 =?us-ascii?Q?OZM9KsQEm8FYGdPTTNNimOyLuOT9w0b9gN7qHPauCx1kSvYfxvR0CRPi+BMq?=
 =?us-ascii?Q?aNlmFIZ/4LblxgxuHLAm2Mb+6Nf4edxbu1Ta7WJaXcbk0whWcW70tnQKwj70?=
 =?us-ascii?Q?++fhfUZRC59zZvCXxLG01FkNUIaPFcmd8290r4ujqyuWv1mWsUi63TXon0n1?=
 =?us-ascii?Q?MfW58cmrxImJPwrWJko6Fi8iuICDX2ODg6Xy?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:19:57.9954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2838381-4bc2-4fa5-71ef-08dddff4a471
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 14:20:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2071

Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
openamp-system-reference example applications.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
Changes in v7:
   - Add machine compatible for qemu-cortex-r5 and stm32mp157c-dk2
     machines only.

Testing:

$ MACHINE=3Dqemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
$ MACHINE=3Dstm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv
---
 .../zephyr-openamp-rpmsg-multi-srv.bb         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-r=
pmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb
new file mode 100644
index 0000000..4e50a09
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-mu=
lti-srv.bb
@@ -0,0 +1,25 @@
+SUMMARY =3D "Open AMP rpmsg multi services"
+DESCRIPTION =3D "Open AMP rpmsg multi services"
+
+inherit zephyr-sample
+
+SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=3D "git://github.com/OpenAMP/openamp-sys=
tem-reference;protocol=3Dhttps"
+
+BRANCH ?=3D "v2024.05"
+BRANCHARG =3D "${@['nobranch=3D1', 'branch=3D${BRANCH}'][d.getVar('BRANCH'=
, True) !=3D '']}"
+
+SRC_URI:append =3D " \
+    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=3Dopen-amp-sys-ref;${BRANCHARG=
};destsuffix=3Dgit/open-amp-sys-ref \
+    "
+
+SRCREV_open-amp-sys-ref =3D "d78315763fbacba8a74552d0ad570bd01c42ccf9"
+
+COMPATIBLE_MACHINE =3D "(qemu-cortex-r5|stm32mp157c-dk2)"
+
+ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/../open-amp-sys-ref/examples/zephyr/rpm=
sg_multi_services"
+
+ZEPHYR_MAKE_OUTPUT =3D "rpmsg_multi_services.elf"
+
+EXTRA_OECMAKE +=3D " \
+    -DCONF_FILE=3D"prj.conf" \
+    "
--=20
2.34.1


