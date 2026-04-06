Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29139F46C6D
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:30:09 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com (DM1PR04CU001.outbound.protection.outlook.com [52.101.61.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60413.1775496602278929673
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Apr 2026 10:30:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=qEkhuCJo;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.61.23, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKkyG6iAauv51gSo+ZzkIu55FrKJIF5Kpp/S3IF4qFqHof131bTQH/tD79X+isY81Fh777mYkGEs0c3jF4IfWqddCLpRU+RYApnGI8NtdTeaBSgJThVO9S56UlzIazZCjAH/QZNi9mGUM/GSDjvSiMNIdQi6ZO3WZzLniqzzt5bHVGD7FM7sHkPNEIexIqt0GiI+TZky2ZYyjosPvoiWRYcMRj743XHy5pUZkHhMr/TtfvX2U+t+QvmcbCHUcWOL4lKJ5i7V94ShuMWeiu+mgeNp8moCknIkoYeu2CbwdB8xFlNRs2YgkWh9Dbjp38ZmZ2HPKioTl7hr8/Kyt74xfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATWjgJPs+rFibSnR9zQ91iuBqbxJPAxmFmWBDxy84lc=;
 b=TsytTYqQoQjDZoAgbx/hDScHOHb91IX0F5VXAAos+U2xSV3sPrWigWGCf4w+HpsOnWgyU5N24/dTeosEfELuh+cwLddjMT10XC+rIO9cWqSgM0wvoRjQU2+4nBlrqsAu8YzcYX3RJVXFeWvP9j4CInOqepTxB2MF5Btr4JK5x+2rMM0tj3BQF7VH6C+evjc5kRTGpsoa5tn1JcXfzkLHaxY++oYYgizXMvLl80yGtM/weThnLkP1yzujRTyzkO0TqkBSE7krHs949xGotWvfM5bQKHpnEeswD25fzEQLFSh8zZ4LCzwTjHRYDAHKgC3Q76A0ac9hIW3DKl8CLNn8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATWjgJPs+rFibSnR9zQ91iuBqbxJPAxmFmWBDxy84lc=;
 b=qEkhuCJovIZFRo6wfy5RRjyETiHXX8dcCz9j/hJKWEhA2xqGL6R5kyUN5SWulD6QuaDhSkrFIfIBeMaRBtANd5uXBOkDhAy8fHXeO+XWEFDh3J5XelLlvbZZIs2IQm13pXCa80NJzlN7eYyS9gTOuZPtIbPzl8LCf7yDRRPZeq0=
Received: from PH8P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::29)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 17:29:59 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::be) by PH8P223CA0004.outlook.office365.com
 (2603:10b6:510:2db::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 17:29:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 17:29:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Apr
 2026 12:29:54 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Apr
 2026 12:29:54 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 12:29:54 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH v2 3/4] README.devel: Replace deprecated libmariadb package
Date: Mon, 6 Apr 2026 11:30:09 -0600
Message-ID: <20260406173010.1366742-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
References: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2cb95f-afb9-47c2-03ae-08de94022060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	qxHRNe31IRwAKodkAZCWnpt50MR4h9xMi2wm5JjLKqwqG9eAhAp+NZ1fn2V+NKd7W8yopKQdyYZKnYul/YozjJxLsBwAFe0gKz8PKnAWA5+KVn8vpHz2sCfrUxizb8q8SUtmjqCAnuq6WOwM7yU0C4xdjsh9cbOki/nwqIfid2kVc+FCiGfMyTAaQ1vKCHFLXhYZ/Sb7tn79D1UWFPplWkKGql8Kuvq9CTf3MeYfGtb4IvqO4FkO8T5V4HW1c3Ny0i3M9/kf/X0je3e930VSnBp98mwhNog1kIEtApUEcPRlUDy7uSaoxEqJIwIrr2fnrqYQ61NeYBNQ590uv2h1+WTWBwGiZl6myNRi5PQH+bn4AdvitJFMKQ7oaD64akgMI61ibvmAr3mtkTqiFNAP1tZbl4hYz9LUl4jnmvgaMFlNV6A0MzaXP/gb3EQFfflMZYEKJPjhG8KrOEok3l16NxcRRDMAaCNX0Og4N3eAVMwMJX5qga16mlms1mystotQG5YhKhLJWo5C+WIiO2BIBP2I28HOuC2R4MBIM9tMES67p8WCC8iOq/25RsFbWzIrHJwIz6ID6Jb/58UYtbL/HX6kdxFOdisIiqRO6wTYXdddOjwmOYyXMfxb+Hg4eApjo0MKVg9r3orpEReLNSKBQn8cd0k+p2joBk+pLh3Aq6RKb/NjkqpsvoDijT/jIyG801hsUBhzX536LCB9JGeILCRp3FRDfSbdY0pLDel3eEndIA3oxTSewRrPSkB1wF3xgrFCY98XzG7IrmuJNTYK7A==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	GWoyoWu59K9wmRCeHHhXKU8hh3BaUPNWg+hWBHierQwLhFcPYx4u1vJhPoCkTdA5l3DaqCIfkrMxM78Eha3RCS4Cy/2ef18tnyeH+YR4zdWRis3Q5rXlUy0Si7amdtdGe2EYlFIGTTS2/lMaLBW4sjQqoNBpSy2eRda9s6iGNxbZpt0CW1PsK7b+gmnvVxJxopHq+g5bSNHAvPWsaHUc/Mu3XluUyvm4dbYszg/O8/fTWmyxk4fqFCl1bZyWxbwkACS3Itzq0fFVPf4f9sYZp4xUIsxnk8VFo+ezzL1PgpIcsPV+JaS68MmMFArGDEdtJXq5n2lC/muhq4Xd8NOGuOhUdf7vy57rX4MO8beBiHrZlhcC9wbHgI56tet3ifbobJpyQoggU5MU6B9b+mDUhB00dTgkDCJpwCyqIuH448TD70asKEgMa/Jdg7fUJvi/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:29:58.6584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2cb95f-afb9-47c2-03ae-08de94022060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Apr 2026 17:30:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3647

Replace deprecated libmariadb-client-lgpl-dev with libmariadb-dev
package in README.devel instructions.

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
Changes in v2:
   - None
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


