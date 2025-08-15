Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFFCA0EEB
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (NAM04-DM6-obe.outbound.protection.outlook.com [40.107.102.61])
 by mx.groups.io with SMTP id smtpd.web10.4397.1755230100590706480
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:55:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=JbyOx22C;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.102.61, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU9AnWpCApX43YQA7+5vh/Zr9uWZFqdeUNptwW1WuEmSiO8W7WlLXadv+ZnlzNQgL5gtjCRicNYUix6J5JTPoceeskBqdY7fvJGKYcehgC0LSp5b+Aq3BSR9gnZc4f9DncHcZ0k/NGXNcYAk6cNMRG4mUXSnxlcRVKp8l59NdvDbhTi6lNCTMm05Mh4DmWD/CTHQ6NXosurPaDwK5aUElb41lv/kkBjIs3UKlUat3wxLiLY8/AGo8ncjpF/aW5EWX1NdQPob5pIy1IO7Pbz//DqdTERC8CUE+K/LxvDIvAWhbAw9/lo8BzEKq3k0dumFMGSVgYzPnMKEj1l4+T54bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0v1+7PrV5cYc4kqLLRPw9UGIAYS6zsfBaOL0CoePJg=;
 b=puHqeGsBELA29nbR6UNbujXk7YysTuTy9JMETjKkiRxx0Zcz78BcMpWqbmbUWdkYL+KDjif7/UQScav/FwDozlyzo4yOcfhbORoC99GO4eMgdcTkFoh2m+n0p74Gl4I9jzEj/WTXZDTwvuJh+DyiWPA879r0mTATCRgBETp8QfsfiByfUTYufDHpvnim/bXLviUnhuc3vpjt9vt/5NpLXTEOptk1RGr+r6o8vbQXxCTYzTgK01yfUuJz02ueRwRD9pC5WYRwM5wZF1ai/c/RwaKuDBHBWjgGWctAAOsc6wZlxV1mhoFbknOMkXb9jdR6/SMTYvMsv1FIDElQu1jAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0v1+7PrV5cYc4kqLLRPw9UGIAYS6zsfBaOL0CoePJg=;
 b=JbyOx22CWxbjbkA9Aoro2okj4J01qQLQRZxevSGeg5zha0PjCHJ9GQchDbOssoExINTFrfHhBhCqizUC6mLGrxPukt+GrYsNWeVoyVwDa/d2q+HfC8GoVChR5maD2DM05qt8vrHmdDxHkUrMH2yNwDicBUwBNm+SabIj0p0FVXI=
Received: from SJ0PR03CA0375.namprd03.prod.outlook.com (2603:10b6:a03:3a1::20)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 03:54:57 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6e) by SJ0PR03CA0375.outlook.office365.com
 (2603:10b6:a03:3a1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 20:54:53 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 11/12] zephyr-kernel: Add rpmsg multi services recipe
Date: Thu, 14 Aug 2025 21:54:48 -0600
Message-ID: <20250815035449.2816001-12-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f1a3be-61d4-46da-989d-08dddbaf8006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NJ4Ygc+tsXt3NVNdu7C25mCUJrmNsdkCCUZiMKQIc0pP6yPmSQzvhx0wI7Gk?=
 =?us-ascii?Q?VI72hZ3kvFkJfnS2RCcmyX10A0ysTE2lBXlvRTUwLCrXdwB2YizHSh/FKElB?=
 =?us-ascii?Q?gpy8moMtCB4fdtT/FzBXQuNt5O87qTewjbmvIpqtF5Pt+p4zMUdiEYOx6/42?=
 =?us-ascii?Q?zXJBtSeqBWtqj/E4u8H0la+7iq9/UEqC1+OUGpzsL9JOg7TAdnpOkw6NXuny?=
 =?us-ascii?Q?EvE41dvvmNzRZZ9+mrKjHeP+lvEHFqskLIFvCvSEcDt68jVhXj5OBJgV9+xE?=
 =?us-ascii?Q?9RpEIuzH+spnKr/sNkXuWeuDhWmD1c30H0JjO6pCUM+ZDwFf/YNZvgWniR4i?=
 =?us-ascii?Q?zFhpWJozmG+EX1TijiwXhv6hvo0BjpYsWmngWjlk9Lmjc+ftHShvaBfEK0zz?=
 =?us-ascii?Q?B5rgEoZY5OTQaKfsAIPyCXGExp3txMQtNCs6AECACwphBBa8Dx0NG+DIODjc?=
 =?us-ascii?Q?KsEEbh9TPtXstXXxGQZbYlV570wBi+3RzHO7kt6VSqXFpfeM3WXZaFu13KaC?=
 =?us-ascii?Q?UHR+zLbq3TB4YvQ38UuBS9BHLncOrNNWttGVZAncEk0FFpTx0vmY03BR4+pv?=
 =?us-ascii?Q?9PNAy8WAcRK/Fl6SE7BBqvL00oCyi04Q7P1VPmvkEMMDzFlozuUgA8vTP/cA?=
 =?us-ascii?Q?KeOec/Z5Z12NMxqKa+Qh9DC9Z6Ul8InC4xlusse0xq8tx49CD7+vyPq7N3nM?=
 =?us-ascii?Q?l3FCZdwnES/zD1+gQueD33NW2s0nCSaFUCs5PC99BP/DKp2L+yqDqUhk1l2e?=
 =?us-ascii?Q?/7qt6TRt3gV4mcf4yvP5URRve/9+MoMZghimft7F5QdZ+mNqXbrudl5wSUbq?=
 =?us-ascii?Q?Hnmak4Gjbp7JB/8FKLpK94sieO4Jr/G1PcVQH/brzHC3gqAnE02xWw+/jGKt?=
 =?us-ascii?Q?4Fii5roNDHowc2ZUORs6wx9BlM1FWjI2poa+L/yuq+JY00KuNidWA+hcq1Er?=
 =?us-ascii?Q?ysWZMf6/0e6yFVQZO5j4as2ISNg+tKdxFpE61iZ84pp8W9UorKdFswPn60H/?=
 =?us-ascii?Q?F0In9AMyCPe+ZGJzvhj3TwUWgdk+Qvyugp3hhWO+KTtAmXXI28k4A+tCQ/hE?=
 =?us-ascii?Q?t/ytIeceYhOO8kKOMvmeMdI3c4+ATBZ9k6UfdneaEssheFKZENkVOvEUeiIl?=
 =?us-ascii?Q?5vAIuRYuNtSWdfh6IzM/EGkb/rpbrxPwtreASNReksJ/4KQDbWcI9wkWHeXG?=
 =?us-ascii?Q?bVOB256DH+I3UGsnHKw+ujMcaozU1/xQApym78ISDUGl+ubWZ0msiYfWd88f?=
 =?us-ascii?Q?T5Sw5sg08ooUF+ZfZ8xFOH7eoq99852KUpJXj1X77o+LJmql02q0SHBcDjjX?=
 =?us-ascii?Q?QkhNk9a+u/jzZgXEjQUM320stQLt6cqTaLcLxTnDl6FddU5XYIHW3THlUN6w?=
 =?us-ascii?Q?vjLYhKZud3WMBOZh3jRL5ZnQ6uVhqjfLxWbWsuqU3vA6uYz3nD+Y53915J5V?=
 =?us-ascii?Q?Y4p4+LauA4nWbKWTncDi0vKbCOfMzQWQrkFKC8Qz0oeVs8Ap1uIubVdouZrq?=
 =?us-ascii?Q?PJO6OnTG84QNOdHNvOHklBUQD0zb8OSYM22j?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:56.8642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f1a3be-61d4-46da-989d-08dddbaf8006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1997

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
index 0000000..222ed2b
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-mu=
lti-srv.bb
@@ -0,0 +1,23 @@
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


