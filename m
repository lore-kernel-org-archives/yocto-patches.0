Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC2CD6AB05
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 19:51:41 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4917.1775159489027304067
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 12:51:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=vc2fMOYi;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.53.62, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bM0yKTP380BeaSDrsGGFSUVdD8oyh1zRZEndGnc5ehJ3M1AwKOEmvr2cj69db12p6cNR63zS9EsDvrtDHdc5coY1skVvVTzi4Pb0gfSthBKB4b3iLQL7jUHBoOAtWJPC8HeTn/pE44wShezbud/XNAJLQb1vMzwN0x6DMXJjFtEU7/+0aDDxa+Vy3LI2megnVkyCk6k53/CHdSZWnHlHJCKqtV/rLV9KIv8dW6FdgmpLomId8srmspvaPXUKH8yxuyt7Lk16eLjq1ElR3/00JzbRbw/Wg05rChMkvuv3HImyLnNMXck9tiCFPnoocmD3KOiZ9bXJjWjmRZOb2PLBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFw0FQscymf7MOR2UdasgOgSvcyMXv06v6zH6ZSyrxs=;
 b=qMKnb08EvLH4bcQJEOU0+qxnNn88NSc2cAB8fHIXuc+311+GB9KTllOJi8/T5nJB0YAHDnT+MDawDkH+UHgbuV3raVjUGsAgkdw+ixaTp4Sw6+bog+yHHu0eYalq1fnjkOOnARQXuAMua5lkDbJnU0J1X11JFGBDuCJxozHXlHp6H7OuCPPsd8wOhM1yC7dUBph+d+YIUV6wNCXzXrXUzvX0qWKJQfWFZEKaiazlBvBu9AMOaT4eUC1YxCDdYtPUE8WxwWEzIcqY8F7XNtWqpWAbrqUeM4Bc0o02onYXDODVJpdfuIhfquTPjSHbwnLxsK93Atapgen2Ab4d5i+pbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFw0FQscymf7MOR2UdasgOgSvcyMXv06v6zH6ZSyrxs=;
 b=vc2fMOYiu+yn4bF1d+j/Eo/o2hSXlgO5Nnak08S047VU/LHly7ocULMFUlM1n2evXrRdeCG93atBE2zZZbzicQXigVvO8TelEOsPwpo8pQSdE+syzejCnkqsRbbTfyzF/zURiL7NDKueYgWF2zytPB4znLU3T2M791PVmtRAs6I=
Received: from PH7P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::9)
 by MN0PR12MB6368.namprd12.prod.outlook.com (2603:10b6:208:3d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.14; Thu, 2 Apr
 2026 19:51:16 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::53) by PH7P220CA0058.outlook.office365.com
 (2603:10b6:510:32b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.34 via Frontend Transport; Thu,
 2 Apr 2026 19:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:51:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:51:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:51:13 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 14:51:13 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH 3/4] README.devel: Replace deprecated libmariadb package
Date: Thu, 2 Apr 2026 13:51:11 -0600
Message-ID: <20260402195112.1369295-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
References: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MN0PR12MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: b117cb96-3b67-4e39-fdf7-08de90f1338d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	U1EYpFlWrcYxfRWOirbWkgbdGFVqCK+IvaPJpYTMqbJ1lQNLr9XLiZh0PSRNI6zlN8M5HvMFfL3oZL+o6jEkyd6HPpWu8bYDdMjMD9sGfytpASoIzHKLaDSchwaYoxImUJy10M+EhFJvyE2sGCHwr8CUppr/ZdKWGsaHXFmR+WXeBu/aVTzW1GWaVrJ5Ww9y/Yfkt+BWQvoKAHLNUhN2K2nBMcbWDN4jT+TzWA9YPupwDiVdH4g/CBLu5I5YTB4jToVxeyBqHheSP7jKu6y3I58aJoFCtYbBeEp9SVtRLE8mALj2VHHFDgGT58sjPxw4xGEmfCG5vpXKt5VAmakyqBmcCWc9lN1dJWbZrPRWTLVa3uFosnOFy3B2LV7/hMmb+AkDMk1q52X91PGSnK9CEcUROVBLMshmU0Y3NshkBhwNkETUUXxsmKsZfWZrBmSkMCfHZLKN5ZeBLzebtGYzTrG2CNkzFLJ+NChGBO/fNKkGHU4yUwLsHUQAeZKKjaH+WTHcGneeuu8hfPyK+/uiEfRBLQABhXj7K4SNGGivuoiPnTWtuVq3P2JfKXKwWqhc1hJ7suOkZMRQ21fgckRJMK+1465+Jx6NASxEqqfpbDSctVduRg3JEtiZxFzdx7zuv+RhydUo8wdxrtE04t0FsueRIh3A+HoB3zWK9KFQWsIKZSXOPB5KYqdPpqZkjIn6ytXU2wXcp/tsbsDTTe5bYUT9qt/nP2LlcxIQKV52MYUg96zBCBG6KykI+5FyZ81n7mFOvrzme/LI7cdXTfhixQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	L9gXCJU2k7VVrJR8zXL9X1enLuRBQIilgW+GD9Mz2mPHMnrAg5uFzWrqCpvJWr7GenyNxHD1FpMtzGYd49k8lrfiVIN56DwyOUq/G4+jt2qvI3QpozWdkvdF7ARUnR3eaVr7senfQy27D2j7fMZlYMHt6uVyZI4HGIRhbuO/3OxBkgbTEyfyoj2AmxV9TiiNcy0RYLKEcTDzahEoliDiubPoIzPVNpOOrftn/P9ASoxS/ovd07QCvrmoaODc/4MparSahPnBZ7fE+sHofWxriTAn5Q7Jeoq0O4T44PXy3xxLPqeGZ/sOLkBMdINp4CruZy+A/P06CU0nYmnPBwip10PRgKxYqmrjBAhzpr8lXjAcw6KpOzGtXzbt66uLSmoaKjQiJF/fsiRX/BFX7pYhDR2vrf8xVBCiw29qzC9UoNOs3wQBRYQyglMFjv8mGwz/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:51:15.8763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b117cb96-3b67-4e39-fdf7-08de90f1338d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6368
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 19:51:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3621

Replace deprecated libmariadb-client-lgpl-dev with libmariadb-dev
package in README.devel instructions.

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 README.devel | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README.devel b/README.devel
index 78fbfbb..de370e5 100644
--- a/README.devel
+++ b/README.devel
@@ -40,7 +40,7 @@ distros).
    the database backend):
=20
    sudo apt-get update
-   sudo apt-get install python3-venv libmariadb-client-lgpl-dev build-esse=
ntial python3-dev libjpeg-dev libz-dev libfreetype6-dev libssl-dev mariadb-=
server rabbitmq-server
+   sudo apt-get install python3-venv libmariadb-dev build-essential python=
3-dev libjpeg-dev libz-dev libfreetype6-dev libssl-dev mariadb-server rabbi=
tmq-server
=20
 2. Work around path issues (you may not need this):
=20
--=20
2.43.0


