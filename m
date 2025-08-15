Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC00CA0EF1
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.74])
 by mx.groups.io with SMTP id smtpd.web11.4400.1755230099023299741
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:54:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=zc4ypb9x;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.74, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dES/2bJFld8vXz8PczQYSedKhKmjSbUy0CzZMB/hRTqOSUJG/qelDsY1bdt4TX6FCTrnqZYS6kHmNaWPcRuMmi8Mn9oo3AfrCwD4bi+XxmQcBWLCCi7dJ3bX9/ycDyv4OroE5X0AmtOX694ihkV/BT59Tan0fjeo9Uy0YEy4fsb6jUmKHubhyfsi6zQEeGQTKefKgK4V19reLxpR14EddkrdHawZES+9BGzcimhrW9pKT5sNzL7wt0bSx3hOo31B5H1ylJOH6ZGaLL7L+IRPM1Bp2r2SiDfM4YQvbstOdNBfGJ1BDmO56dmjcQI0P3P3UcLlFV9EQCycIZ/CCi/EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P53fQNEa56yJamL2j3eHhlYkckrqRvqOvCoLWPhMpp8=;
 b=K8IcCkNXGvoA3Q7wn8icSqE41s4WNBixBPkp2L3pAGei2NbroKIcNv/XWZjzwvDjAv5ZMCu7Y/BkvcogvTrAp0UWUJC2EJYnvgkmvLGpwuF2cTiS8e1hkfycBh048RBSTXbaj34mulDCp3+Db7Q7KXjDoYce30i7whQpLir9glHew1e4IvzSahefQV+0e1jPvsHYYzR7QT62LyMM/YUqHwNT5MC3i67O2CgxdzQiA5b1Z2jC4uxx1ijYmN/PES6cWsujSEjsM9wZGzbimrWD6jdny/nYj5q47yqRZXaowXyD53oWOIBoOO1hP8GSQPY7i3QSEkAaCS22xmQ6S0Y/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P53fQNEa56yJamL2j3eHhlYkckrqRvqOvCoLWPhMpp8=;
 b=zc4ypb9xgsGQN1G1eB3pk0bS5zTygDlqxWcreCxnSXYYh2OvjGAu+EB6let9Cy+zbvXzmyr5qK3cguCDV/F6Y4pVExSzkbPpg1HlK359sa9lkji5OTHFF1xgtzfUfKD+zV5uAVqot9yGdqiubpnf7CHtjjm16hghljRkUMMynbo=
Received: from MW3PR06CA0020.namprd06.prod.outlook.com (2603:10b6:303:2a::25)
 by BL4PR12MB9535.namprd12.prod.outlook.com (2603:10b6:208:591::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 03:54:54 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::61) by MW3PR06CA0020.outlook.office365.com
 (2603:10b6:303:2a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 20:54:50 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:50 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 01/12] zephyr-kernel-src.inc.jinja: Update script to generate srcrev
Date: Thu, 14 Aug 2025 21:54:38 -0600
Message-ID: <20250815035449.2816001-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|BL4PR12MB9535:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f58713b-a955-4534-5779-08dddbaf7dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7ih7Ex7NoZQTMTg9Or5BtppZOtssn6JVa/o2u6apa4dsnPSVORI2BxgJRprD?=
 =?us-ascii?Q?cWdj4OD16vL1BNe8LKh38ZOOWCJt2tq4hXk9K86X2+Mlx6+BU0I2sA+B6ROJ?=
 =?us-ascii?Q?PuvTt/1F1/JQKmCi9bGGLl5ZXsE1AN7PMYF8Br+M2Es4kKmf5vw/BzTXivkr?=
 =?us-ascii?Q?dbbVBk4O0wNtMbwORtPizO4zRCmY0rFPrp3L+LeQS8DUn/xAN2NwpU5iI7uE?=
 =?us-ascii?Q?6+SqTvFjTPA8LxOrsebmMXl/QycLbTGTOvQi8K48+XlnMm/u5Vbw0wYxOTCi?=
 =?us-ascii?Q?IuR0PYVwHrwEuKn5rpi1MvvNMizDMyZNwC5LK9dVcaTu4K9rSbiXpfIee8b6?=
 =?us-ascii?Q?BAYZC85+eMbZjLQ7tgtUlBLGrHNEnjz2Yakwlxub9OgXeDrb4t/5vb3Py59Y?=
 =?us-ascii?Q?Y8Wvo/OHe150f4qXQgNfngLaJxk+aqWriTcCZIenPR+JCm4lv9IVKmwBxvy+?=
 =?us-ascii?Q?izDXrVqqES7CUEgvL+nf/+GL5moxxRKjfV9rnylwhcOnEvZvKFwVHQyMl+cS?=
 =?us-ascii?Q?Fhuz9WxzrShyIM9AdqOV5j8N9rp0kzLRs6gXwcLMpZ1vdfhZJZpcHqulAuvt?=
 =?us-ascii?Q?uPKTjqXlV3Xmc2QKs7lfNnBQnFkTTVUkvYPYM4E2KNkCvBkNbO28LJTRDHwC?=
 =?us-ascii?Q?SnzGdiRXgiMMCm8Z3ZlWu+Kzk0f7u6MfDIZJjdSiUf+IQ6otMz+i/+x7jQdM?=
 =?us-ascii?Q?bL+NhqRkQUWCFbjT7JVbQO0laA86AZB7qk1noFWt7N8l46K1TUqyL7M5OKZ/?=
 =?us-ascii?Q?2wrAQf4nekaWWq2pwO9avZh8jJ3jAye8IR41iLPBXdqXFj2OTJbGhxmKBm8E?=
 =?us-ascii?Q?wCqXGjrBFD420kuai7tFWdcQi41ysRF5IE92Mu24mKH2mgXgLF6YBTJK3Q70?=
 =?us-ascii?Q?l9k4w+A4jkeKO8jPm3CrShqa7ctenBWk2F39yUeAO3VyTQdiR+oFRHGDxg4G?=
 =?us-ascii?Q?KqvdOi0APosGW7engbnG/+xFMCd6jhFg3UjSdfD0pz9itzjVDZh8I9FrdgRw?=
 =?us-ascii?Q?B0+tsmXzak/+Ff6SXusXab4sUyGfXuki0zRGk8OkVCD+D5maF59zNv8q7aiD?=
 =?us-ascii?Q?LvPYl+Gl28m2ZmvHFWPkYYDM+USNPMfyt+YSt4w9+64xUF9QxOmnsFAnVz0k?=
 =?us-ascii?Q?/XJm7FnqSMCnD69l4SmBY4zbBCLgfXpaiukQZ/h4SzvIHcxRwTDDP/L5Bq6H?=
 =?us-ascii?Q?xgCkZpUDr+ivYWNPvlFE5Vh8KzuyaZIvfxscMF1ii5gd59b692G/1Twwyn6o?=
 =?us-ascii?Q?eMlcIv6yvjQhEt7JYfBkrVagzOv9sL4bWafO2NJTfy694M6X+hzqexZpiHoJ?=
 =?us-ascii?Q?gj0aizpIvtQzDyW9t/MG4NgKDFc0m8UxkJWIUJ3laXev/XCVjICGBQ5cn96T?=
 =?us-ascii?Q?ofWKqGBBGy7hKb7/2vpy0v7wxOeTA5URkYdccPsqv8hzBQGGqCU6VK1NlIqb?=
 =?us-ascii?Q?O3H6e8gzSEj71VjdoluZArufSf006FUytVuDT2hOZkxXyTuvbpS5e4+s+sPd?=
 =?us-ascii?Q?e3eBJcrqWoBZErz7NQer3PlSqf2ATCE2rVWJ?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:53.1438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f58713b-a955-4534-5779-08dddbaf7dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9535
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1993

Update script to generate correct SRCREV and other info to match
poky variable updates.

Also use "version" instead of "short_version" for SRC_URI_PATCHES.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/scripts/zephyr-kernel-src.inc.jinja | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meta-zephyr-core/scripts/zephyr-kernel-src.inc.jinja b/meta-ze=
phyr-core/scripts/zephyr-kernel-src.inc.jinja
index 2a3faeb..ed23944 100644
--- a/meta-zephyr-core/scripts/zephyr-kernel-src.inc.jinja
+++ b/meta-zephyr-core/scripts/zephyr-kernel-src.inc.jinja
@@ -13,13 +13,13 @@ SRC_URI_ZEPHYR_{{ project.name | bitbake_var }} ?=3D "{=
{ project.url | git_url_to_
 {%- endfor %}
=20
 SRC_URI_PATCHES ?=3D "\
-    file://0001-{{ short_version }}-x86-fix-efi-binary-generation-issue-in=
-cross-compila.patch;patchdir=3Dzephyr \
+    file://0001-v{{ version }}-x86-fix-efi-binary-generation-issue-in-cros=
s-compila.patch;patchdir=3Dzephyr \
 "
=20
 SRC_URI =3D "\
-    ${SRC_URI_ZEPHYR};branch=3D${ZEPHYR_BRANCH};name=3Ddefault;destsuffix=
=3Dgit/zephyr \
+    ${SRC_URI_ZEPHYR};branch=3D${ZEPHYR_BRANCH};name=3Ddefault;destsuffix=
=3D${P}/zephyr \
 {%- for project in projects %}
-    ${SRC_URI_ZEPHYR_{{ project.name | bitbake_var }}};name=3D{{ project.n=
ame }};nobranch=3D1;destsuffix=3Dgit/{{ project.path }} \
+    ${SRC_URI_ZEPHYR_{{ project.name | bitbake_var }}};name=3D{{ project.n=
ame }};nobranch=3D1;destsuffix=3D${P}/{{ project.path }} \
 {%- endfor %}
     ${SRC_URI_PATCHES} \
 "
--=20
2.34.1


