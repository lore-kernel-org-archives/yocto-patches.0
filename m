Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE6CA0EC1
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 15:00:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.80])
 by mx.groups.io with SMTP id smtpd.web10.50429.1754924397330447766
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=OEt85dlJ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.80, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSolHPdXkqnikcJVnAvSoo3mcmLEl9eTTK/RYyWpNVgYwW/rtp0MItYQTssZbFwBwzdiMBziBlR8rvkqXXL2XJcQzGqIaDCse+M1QGA6uqZbXSv47YiQEnbeoolYKrc1NRHplEhwcXY0EnzVeRIZ4VbZHzSSMlANxog/EuZ/p3HzYX8HqrRRnsCwEUtsjL9E8NIYGpCtdqpBOlGjzE1rjkN3nNubFryTlEgEzSOw3C4O0Alk7+JOBN39ejPQSws6d/I0o10fLwmIcK5GlhxOwTCVTkRfbtKadHrzTY2aSCTG6EGmoFldrRqesj9f1zOhTR7BVlUhZXsbNiNi0OW5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttZPjY2QYdbxen/nKIcWWy1DZ4lTaVhCg02ikXd6z8s=;
 b=WLaF1fbjGPO8ljXpfumXHsqB+92cYV8K+ZqdZEamXCCpVEGgI91YB9jUQHQJAJBevGmSuG3bID8OwtEJzIfe10R6uleEbFhBVfFAJYuDaEM/6gq+GqGSIPM6Ji7+TFZs97/Sv5EIhK3+n2kHooHSF63AUlrYrnMiwpfFpg0whZ/RgTilgfQALqZuMWumM0EnUsrGYIFLmzgvY7YdQ2lojEn7SWcaWlOrtJJXepDrfkHYuHILQ9E20GhhrkY9na4VBRDg1zB0e7zZ0aYavfanXdVEBaGQPwhemkUaxzB8adxybPNTELfIDzUgZ0n+Mei4y4Ick5kIwpfujFL4vNnUYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttZPjY2QYdbxen/nKIcWWy1DZ4lTaVhCg02ikXd6z8s=;
 b=OEt85dlJ7+XGgaurysLP2FJK6uCGh0tMjfKaUO6qxIxbA+U9XuOiyFLNELVyCvNqGXEWMkiqkOnb+j/zkpFM71n5dUrOPTOygOdP0b+LL8VgS4XIz+x8Vp/9KPnTwsfLj0Jt5MMJy4YnXJYXWhiLp1/Q9A423mei+THKYantPPQ=
Received: from BLAPR05CA0007.namprd05.prod.outlook.com (2603:10b6:208:36e::7)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:53 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::8b) by BLAPR05CA0007.outlook.office365.com
 (2603:10b6:208:36e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:50 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:50 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 12/13] zephyr-kernel: Add rpmsg multi services recipe
Date: Mon, 11 Aug 2025 08:59:40 -0600
Message-ID: <20250811145941.2553838-13-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
References: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ed1eb1-7b12-4dcd-4ff7-08ddd8e7ba30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s7IAmekip4LDReIb+8Iz748ZBmE4NaCLw+4P7Ycvv8WNtXjkdY6X0dytxItl?=
 =?us-ascii?Q?al4rBj6pnY6O5EUJo5AuN1X+1M936po+oRKT3yfzb+ZrEBA9Gxz2GVMz/yN/?=
 =?us-ascii?Q?+7Uah/EjCbKdZ3gJZHm53ASei0cXi2CwrHYRSoIOpIrQstnvyWfbonxHv29J?=
 =?us-ascii?Q?ek9VH2fxHYAajFElEpBSrCJthbPJVKRkv4mZDg6AvoHKpAkMkdJo5DBN3z6w?=
 =?us-ascii?Q?L/Ez5zkT7X/Op5U/qYFuuJywIPCV+2psMvAhYBmRamYICK4MHmuRgIfCLL4L?=
 =?us-ascii?Q?0DL59yRj4FSpyRK1kP+XOFBIC8mrKe0Qj3z/ne/R4xFJOnACAXJs12vnfuT8?=
 =?us-ascii?Q?L365QXrUVv+BE9SXw2GEyLgf4F77w19k1P1NwQS7bGmbC13RNBNGAfY+SrrD?=
 =?us-ascii?Q?2KqAXnGeUca70MPgBJ2uAgXoHOpyQk2W5JQb/fwKeGsVQsILAE6dP6XUifJy?=
 =?us-ascii?Q?taBrU3ApBVO32i9V4besKu5HrUHGI1ufy64gW/iNBZjTJv3KfDP7dddPqWaV?=
 =?us-ascii?Q?EwEgqqkZHFR4h+lLWtZgBNbrn4os/xkFHc39ShueuqBfMF8hzJgiI0VODlm/?=
 =?us-ascii?Q?pQ4JCHNRDCqowwWAJ7uKzlZdZP73Cimr3nitEHR4soUdx6e4VvHjOdLyJMQ2?=
 =?us-ascii?Q?6tF8rAWeYAx6AcmRqM8j6l9lGxNEfaTAwwS8Gr7977SwpWOiWmWP7r40CA1j?=
 =?us-ascii?Q?/2O9Q0N/YMAUHjlh00U3xkxxiwN7ELKzaDWVPujm7JgTa0CFEz5t6bfh10MM?=
 =?us-ascii?Q?LjOzQy1uEqmWu/UNXisr7QOceZEWu+ALUNIjdHSNPvRK8GO5XQDSwHhjArAO?=
 =?us-ascii?Q?iru2ylvXHQpJqjcQOqBj6bWqRuvdmJ2ZiQ/ub0Zgs10au/zYn6DfE4Q244AS?=
 =?us-ascii?Q?EUbHKRBDDhnibkmynjPOSN22DpaI991Yg/43kcg2k5pkctJ0xgZa3g26SfV5?=
 =?us-ascii?Q?oQHeqbL2Kbx14Bysb6CVaRxyQsWPch5xBDPyl1QckQ4r42axRFEZ1pVyvFxE?=
 =?us-ascii?Q?VRewXyqeMzlJOvkqqNjInWtsA6d8BRLVueK+sbEtQ7uSwiLnR1QUQjy6HD3C?=
 =?us-ascii?Q?GOqBwoWwTW57lqUmxB/OoAbdWNuAse+XlApCZEq9Hc/IwyUYzqlzELYjJmov?=
 =?us-ascii?Q?I9zKqFWLq7lCfPvBOsEa/vRDg371VjrY96f3S1v0IyNWQ7JvhS5KkoLdnthd?=
 =?us-ascii?Q?GLsil1mFFryVrpAee1WYdR1tLbgHhVP4cypKENIGCQmmx6QCHG7lQY57wl64?=
 =?us-ascii?Q?fqX0f4be88UvAHulSAPwp2/p8gLnF7jMck++Ok6WUJvxl4pN98J8sSiBCi+h?=
 =?us-ascii?Q?EMUePD+qVvFf/qcqMRyzm8EtH8w9LdX3rbSWXSX03ecOcqagswbQIBiJe//E?=
 =?us-ascii?Q?cQiywdJr/2/FhDNmTy2cV++OvtHPZMqa385AhCoYZDHEv9oKyECOnFRCyksk?=
 =?us-ascii?Q?jh2tQdu8xsO9QLVTYdj2ycj4Yplz1ZuWSjrIbhhN+t9cfO44x6RrCe5DmTQA?=
 =?us-ascii?Q?QyoIYHbvfRb9JGfWB9iUITcdUovtLX7rqLvU?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:52.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ed1eb1-7b12-4dcd-4ff7-08ddd8e7ba30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 15:00:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1940

Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
openamp-system-reference example applications.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-r=
pmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb
new file mode 100644
index 0000000..51152e5
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-mu=
lti-srv.bb
@@ -0,0 +1,23 @@
+SUMMARY =3D "Open AMP rpmsg mulit services"
+DESCRIPTION =3D "Open AMP rpmsg mulit services"
+
+inherit zephyr-sample
+
+SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=3D "git:///github.com/OpenAMP/openamp-sy=
stem-reference;protocol=3Dhttps"
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


