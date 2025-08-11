Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C4CA0ED3
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:47:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.76])
 by mx.groups.io with SMTP id smtpd.web10.57321.1754941619178281784
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=aFK5xtiM;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.236.76, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGqPDDlkcwkg7oJjGIK4kKYQwactFkvhlFkY3KoNZvKbgK6ZhiMk95/jdrznvof3/9OZ7Bw8rU+tv9ZpURVMjujcq/uyvgkwksgyV66NAMxyLnJyR7sk6wUDtopK3bqOg3Us/PZ51BrwObAHTer8V9yRmI6gD5CFc6JHqcjH9fF6RQfd3PehS/P0AYXcn6o079b6SnzfvUjcAoRc89GdBO8+zceAROGZ9VWL8UMc/+xgaSij0LW5RzMk25l1XT/+t17NOdODj3iWakOqPfAPjticQV0nTThgsxNbdBajf1BhPAb/zKYQbFkEKXS3G9EDecKJOAH/Jy1q4mxzwj18qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttZPjY2QYdbxen/nKIcWWy1DZ4lTaVhCg02ikXd6z8s=;
 b=MR6L+/0U9jo8vZG1g1lvkFmqFOwsx1jrxfBiyGViu1WTl3gnzZnxnz3TU76hBrj98eqry8CT6QCFOoeinf/Dn6KUwzDDCsqbYaJP3mLWvhW0xeA+2jbQinaV1mnYfxffRS7iWpqJk0LOQ8THBJsh8/QCYf+2FPWy0DeoxFgZqJmPgOvp9V8/nXYu2iOYaTJMDoYd/QHNvSu2xAkaAAbbY1XG1abOJ4beVYHFzvFr7jbDcbUINscLRQUq2s3wWmMZp6OSs0xIZLPbAA6P+dnhneoN9DL5+5Na2D1M1ZUYq1hsENA1eZO/6AnrzKSSpF1QdqHNcM9qKp8kPBTx00y5Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttZPjY2QYdbxen/nKIcWWy1DZ4lTaVhCg02ikXd6z8s=;
 b=aFK5xtiMoplJ9E6Ky/C/nnngMDBWX9rzIl5cy1C+K6nhyrXgNmM4Z0kMsIF7DGsGb3ukMSiuFRCogmKw1NTinisrR+zMV3l7Fqb8nqBWFo4fXNEzifTfupWWrgKOdfT8zvVE9ADOoucxZ44eLIxjjjfptTe2ZRvcH9yzEPbt4dA=
Received: from BY3PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:254::20)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Mon, 11 Aug 2025 19:46:55 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::1f) by BY3PR05CA0015.outlook.office365.com
 (2603:10b6:a03:254::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 19:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:51 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:51 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 12/13] zephyr-kernel: Add rpmsg multi services recipe
Date: Mon, 11 Aug 2025 13:46:45 -0600
Message-ID: <20250811194646.3408854-13-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e96faf-5c9f-443d-0885-08ddd90fd31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WngAtP7OLJl+20eH5haPHb/0Kws0YyycNOPKKvIm0P0OqzTTbbTGlrB4JuNd?=
 =?us-ascii?Q?xF/Rlu39t1P/wH77cVUVMOyGwOfOfOSXFWmEv5ggbpjpUi4UvP+aHtLu3R0Q?=
 =?us-ascii?Q?wflXz/KNgiOpZS1eW/DshW1KPVXTcdeTpdpTa40TT+Od6nHw99JXXgX7ax9W?=
 =?us-ascii?Q?eYXij2gZf0uEJo33re5/xquC/j/WmysQaT9cLjmTTa3iF0PqmF0a8bvWcAFj?=
 =?us-ascii?Q?aifSu/dN2MBBFLntT+fwEscje7KGSK5NvnUxmoJj5Q6MpKqY1AEQyEXMYBNK?=
 =?us-ascii?Q?+1BVIR3YSUxjlEdaZ/l508R0tOhwAJgqSpyU1lnhP3zxSjR63ifkERirIUgn?=
 =?us-ascii?Q?aLH723BbIBcFxI9Qz3tA8HhpjCdal40nC3BrZuk//5I10OW4Jbxhr5x0ICrP?=
 =?us-ascii?Q?sDn/VWR6Zh83C+pbxMlvmsDaJWI096PA6aj9e6SUPSu0TjqCbMxSXpn9H87O?=
 =?us-ascii?Q?ODUmuTrgOvF/7NyNJEnvlY+kuN2f/V3KQ7IeQVmnZWhosvtTyk4QOQ3AC6Tz?=
 =?us-ascii?Q?bfkY2Hi9ti6f7TVm5nZfiYvh66okHLxuzsRqHDdrqeBSbTauPApRJ74bRV1R?=
 =?us-ascii?Q?9U1cIFAhwTvkuiPco8XYKBThQshKqEglrm90MaeTMRjqt/QlgZFk2GbEl7nl?=
 =?us-ascii?Q?XQB0cs6Ea6BYTD+77EGmqqbapkeb6TTlxTR2NtvYxf8wlPMB+frtbb1swQ+K?=
 =?us-ascii?Q?xBl7RcRSgv10CA/d8/cugA8oqdI8YH97JN7GXW7D/cLNONLa45xlZAtc5XIp?=
 =?us-ascii?Q?RUxhN94BlZPDIV8kONebfTr2xjAKHdhePKN5lFXnghhgBUVFIUMZfobkN+Cp?=
 =?us-ascii?Q?PbygTk8lasLylfW8BccvboPovyXhTXZtThP/bnYOQttoF6kuGgLQam9D++MP?=
 =?us-ascii?Q?IeOlR7BzVkqNP7hCjPtlPWTnrfFEQ4td5H22h54Wz4e4JIrurjBKgnAzKJCW?=
 =?us-ascii?Q?X0GklbqG4wCBfFNgkzP+75QCfv+YBhQXbrVRAhMoFtn9xm6I40A+gHTnce5q?=
 =?us-ascii?Q?MCPnB9C99XVyJUPglWQwT6kbJ155mkQMW5KrKk2l9Tf514c64oyUxOYUtNsD?=
 =?us-ascii?Q?N40LEFcrtI9PKMyA/HV+5PweV2ZidJguejUSrUa37t9wvnxUugCclqg9gOs8?=
 =?us-ascii?Q?ckzG9NmfUgkJfYtsfuPAe9M1EuzxEn7fGK4MnLsg8FPlxYHbBsrrFHHv7Vl8?=
 =?us-ascii?Q?ff1cS/XsOBcVTv+bD8QspuiZkB0ZRIL04ZlgzeNO/hwlZbVuJZCf/YB/2036?=
 =?us-ascii?Q?sLUh0ebCGqaCD93M/8yVa/08Ym9Vo+KEDukNwFbZE/RoBM9Rd/lhUIqAYWTx?=
 =?us-ascii?Q?eg57w/O4Gi03aWptFJ6lzelDK/H1W1+wYQHOEdJPqKWrtCdhPELPg9uozBU0?=
 =?us-ascii?Q?L2ClNpTlTH+OpuVlF38DnOsukZMTYxUiAkdbnO8l6oxBuxFa9rEgEOLWTCEo?=
 =?us-ascii?Q?niwXkg5JX/EObseBriCZ7J1g/SsuiXLwccBGLnVFtNMIby343vLNZZNNWOSu?=
 =?us-ascii?Q?M2w0CtPnnMWbNDyV9dUO0V05QVlAHyMYHy1Q?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:54.4825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e96faf-5c9f-443d-0885-08ddd90fd31e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:47:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1954

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


