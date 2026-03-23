Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914E8F483F5
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 20:14:08 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com (DM5PR21CU001.outbound.protection.outlook.com [52.101.62.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4313.1774296847558078651
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Mar 2026 13:14:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=VYEcPirB;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.62.28, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIT1PfnnML3yB8RfhU/GBbQMSgUbL1Z+vkklcZzOIASyzaGPGIxga1ya/j0nSIqqww8tbbrKndzs35SJdlnyYcgA8WqX/fvP988K0hpeyLESXoCOtLqCktGH+LqtzUDj1eGBBl1FsQrIY08R1qUyMQ2OVTVreJX26Xe8E+EwIbfnqcw472ysfmWeSsl8lYnKXNXaMZKfc+jhezt9FeWzmI99hHab8/hG+VDWlwblkU8/ixAk9MJnhCC6cZm7WsWH7Rg3y+0gRSuOzSv9sule+o1r9a/+FNXseJmEh0CZTPh2jWdF6s5qhw0AMOX0eDC8LlRTbvOFiYawMXhVFs2DHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjtYWsk7OJ9p1GMPylDEy1mq0vm8xYavwYHYEFV/Cu4=;
 b=CRJpiAKAzf556LlOwZ95e6SQjBOyMvWVa0QbavR7n/6kT+jhqA6/Emvv+Ksd2rWrl4t7gUJlKQRGR9VZ6VqKKlxUnH3ccHb5Pbhpy2kxIZ38fStDBUEn/vBfoizuMHvT7LUXcYx1Q/39vPpJv/KyPzAfnEUWPm23OwbxqxauUmzBC/7uLdtAEA9a3nmkOBq4BaxUpJjQ97d+JSnKcHIQru7aKedxvAgiu637q9PLlSqNMROD5EdAHL9dQ0JOumIlLJ/VfL51By+jENplbk6WZmBNChgUFgtDcqTsKVWFvpf+WgqoR+joPwRfA5MviaG3twEDtQa6QKXg5+3iBh0VXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjtYWsk7OJ9p1GMPylDEy1mq0vm8xYavwYHYEFV/Cu4=;
 b=VYEcPirBgwbW+0UnDU1EvZRMWGyZ70MiZA7TaLyCT+lQZ6K9ZEVFClRoulUl5YByntA0ni2XV6VteBWV77d5Cl9Gom6L6sbW7b3UJxQQ8Rl9v+C9/UjIbWpXp4lWRIEDezruEv3QsXQGvSTKzEvX+s3y5tKG3uh/Mq/C7nNpsKc=
Received: from BL1PR13CA0071.namprd13.prod.outlook.com (2603:10b6:208:2b8::16)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 20:14:03 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::9e) by BL1PR13CA0071.outlook.office365.com
 (2603:10b6:208:2b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:14:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 15:14:03 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 13:14:03 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 15:14:02 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 1/1] layer.conf: Update to wrynose
Date: Mon, 23 Mar 2026 14:13:57 -0600
Message-ID: <20260323201357.1085876-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: df6ce466-43b0-41c0-2a3e-08de8918ba9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	vRy8lubgHCeZEhF09yWyLdf3ZXF+3RfbISXL3klmg0alxZ5P9f0vESht4j/exz8jZ1lzCkcyYMTPTCRbAXyYAemXcQPGc9MaXdnSvwLbZb8rt8H2d4JVatP5qJYKgrtYAEzfGw1KHcVjqpK+7gFeLrRIqFhIiKYLNjb5+yMQu5ZpbxKSXP0TyNO4goNH3D9YSeVARwp5dkzq+xwJKu9qGkFFglP/QozvNNcC3CnxJXnTJsoMMzfO8KjSa9sUHTdsBihEMZ+l0ymzZfpCh+7XPT7/k6kNbyjIVmavj55Rt0ETxa/eQJCrI1d0XlKHjiRYcndGI0//FJUSk9ER4v5GyyINzoomkwIp5k6NpgX96eumpM5BBZdpO7vG6tFXUuTMJgx1i/sec9VzUIyU0YApAMESDYvAKQ4W2uG6/wJMOUT7SbR7Mwl4/XkU+eeHgwlhZhdHqANcrAg3+4qWMdWXfJnoamJSVshHmt6ycnkcegaMD6sMLtcF/E8VWoZ0aktqdv/XJrKxf2WxufN8CrQDDcxtaOWdJgmLpNEixf/b32C084UchKvMCVKktAYj1DTbVlFi4XlQa+9SBNrXa+v8imvtd//sFlRm31JQFCAgclGzfyv3VEavfV/nVaBcwYKPSWa5H4HsQrqBrSLC7sJRPmIZUVwIEdsHFXAVWsLPF/nzmyx39XDxDHl4WVEo0RbTIeWf8sGYtDYjTj5Rom4Ha3vEDgWoxZ24hk2x2ZXes0UNzVfIRBkd1rnELMO7rDRTrhiKqwt6ZzXXaLX9wCuqPg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	UGpkTsct2nRmvk6XmWfHNeesqjcx6DRXkrUHYwtJ+kumI6A7nNukstTCyFreWfkfBF0WgdXz1Tm8l7sakQkYgbw2Od2W24+Adry7swGHrvX/TIMK22A9nTAaHIrLavGRKgboyZEO0ykdZr6u0WX6Z8i7pp2D/YMbkN/l3kJhRREl4Dyk1qvqGIzdwCQng2827XwLvg7mnOwPF5XpGnsK+/4Bjzi4JtF7G1NtBuj6zF+Uudn4hR1TRK/qqqREkQqe1envBdKyI+IkwAYKOvizmZ9PXDAUndsfpJE9uO4pEf9Mm46ox+9/gAY97rmPFHSKh+qhil3M9aNyxKtZhS0wbamPRtQq3TIHGqDaEZZtv/tgIHmd4lB30ewPmdqqUJpJ0JCza8gyE/s9jLuprNm2YZnwfnIbbglus60V+2Dr2dU/bkqzF1fhL/uxlrs3v5vA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:14:03.5973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df6ce466-43b0-41c0-2a3e-08de8918ba9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Mar 2026 20:14:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3534

Prepare for the next release and update to the new wrynose release
series.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-bsp/conf/layer.conf  | 2 +-
 meta-zephyr-core/conf/layer.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-bsp/conf/layer.conf b/meta-zephyr-bsp/conf/layer.c=
onf
index 6c16722..a00d3f1 100644
--- a/meta-zephyr-bsp/conf/layer.conf
+++ b/meta-zephyr-bsp/conf/layer.conf
@@ -15,4 +15,4 @@ LAYERVERSION_zephyrbsp =3D "1"
=20
 LAYERDEPENDS_zephyrbsp =3D "zephyrcore core meta-python"
=20
-LAYERSERIES_COMPAT_zephyrbsp =3D "whinlatter"
+LAYERSERIES_COMPAT_zephyrbsp =3D "wrynose"
diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index 48a0066..29bc671 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -15,7 +15,7 @@ LAYERVERSION_zephyrcore =3D "1"
=20
 LAYERDEPENDS_zephyrcore =3D "core meta-python"
=20
-LAYERSERIES_COMPAT_zephyrcore =3D "whinlatter"
+LAYERSERIES_COMPAT_zephyrcore =3D "wrynose"
=20
 PYTHON3_NATIVE_SITEPACKAGES_DIR =3D "${libdir_native}/${PYTHON3_DIR}/site-=
packages"
=20
--=20
2.34.1


