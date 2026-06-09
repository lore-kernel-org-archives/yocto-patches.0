Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1BDCD98C8
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 16:40:24 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (SN4PR0501CU005.outbound.protection.outlook.com [40.93.194.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50.1781023223872731779
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 09:40:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=5lR7GTmZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.194.23, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJEGzVWvk9SEz8+X8iiw8ckJeaXJXQgX621fQk36IfoPKt/zgVakUMCgjT4NOylylqc/m5uy+4lv1TCl2pI8WiY9NsHA2zJUX9o+k/vMgDZlu6UAfmek4DSJxqjt9sgnYcVxO2DaUZkhxFoQBLFBzT8mKhK3N2P7nRAJyFhikJ68YiQb1MRT724o+c/yEQugXECAz3E5lLaZsVHqWz8xqc0wQqft0GhicGelV9xnPE/RlK6LE1UJzPX1rVqnkr6D419sXvUlBPhfqnA8P11WGDfVLMpcyKW8E8wwu56Pz3jBKxqiHGIGY/cTXonJ1CVzu/9jduia2RF76MPNUlvGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFw0FQscymf7MOR2UdasgOgSvcyMXv06v6zH6ZSyrxs=;
 b=F6rKm39A5KnPISUh8oVqM2+0NqrCyPsvXwjZS7HtBVfebZbOmly9FDtvbXMH81B+PoR7iM2/3HqWf5PqmHGlac0wEQ7g/M+JcpwktAqif2WzedcYYVv6+5Bo7RW8HjoVVDJxtQk02VxKpx4D9QkeVek0SEww9Udmp7tbJXzShgoXoFt3drQ+bJpIUupF8mc0yRRkPeAM+B2tuyOOFB3eF23atH0dWVzdN9RLW4W9mM0HTgG94fE0j2+pKEC2XYeJ+/4C0hSr7rXOplBlFByMcfxx/1UqfxaEBTULC6gel2Cjy+Y413wC2nB/FuwO7ZA6t8DNMvlcfbMnKiG2U/LSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFw0FQscymf7MOR2UdasgOgSvcyMXv06v6zH6ZSyrxs=;
 b=5lR7GTmZ1ViS9WKZtI7R0HnwSy8uJ/5BToJB4bekTzRdlNQEafw/bzGnitWjE4QuuNvqVP3Ru5/mf4gRqFUbpxD1FLkIB8BhOFOSuIqlxzgo5/4cagcYzqdn1W5y+ZLGS/+Bpm3Ph49urHdgBjcfu8egpG7+fKG2eHU0eMci6Ks=
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 16:40:20 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::87) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 16:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 16:40:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:40:19 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 11:40:19 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <tim.orling@konsulko.com>
CC: <mark.hatle@kernel.crashing.org>, <piotr@qbee.io>
Subject: [yocto-patches] [layerindex-web][PATCH v3 3/4] README.devel: Replace deprecated libmariadb package
Date: Tue, 9 Jun 2026 10:40:31 -0600
Message-ID: <20260609164032.1415124-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
References: <20260609164032.1415124-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 8958cc57-c063-4e95-2324-08dec645cb7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 
	pFKDWoDj9NR2eWzURp4wg0yhjQC/q+C3tL/e6WPKIPtOkFZmf6CNKYXDsWA9rmZ856S5Fx0Ow+cS42tM0o8IBi+A7B91ddUq7cDOEWazVcpUNKTE+k8LOxSByyaT3AcDrQudwyoGV5hp5YZsiIDAx1OxTBb7XTq55TjHvfADS/ycItjSS3TfLkv+7aNn0KfRntfsjP8RyczYfYWr4x1TGGGnYOopwj/Xzzt4VsJWkf5DwsDTIkJhw69lROhNndDkApZ2htaH/lb6izEYW/QQNQfXcxNNvt6WeCxDdj0+PkSDjxyBcRdUJKByx2XN+0CJxDWD07ycI9xV7al9qgsxdMrabkUTABzztBmtC3nAJQlNYzgBeRBM7eF0PB+vs+hUoA8qyPTS6zbgGy2usRvw+FYCehzs7QwEmwQAVmVLJaWdg4gIzE1lqk8jp09Hopp4wWPO1on1kJ0L4WoX3kUtK3kBQpfI0SwSp9nBF+LhyGgzgP/VYYzADDi7TibWhkRVHr5wwtN4bgluDvtUOsI39qnvu/DnNlryaLG9rOIKvwVDhYBwukG7PlfKVnAGXa5S9LRiBt7gMOaIVZF5w8ME9dUS7Kqao5zjDQ0d57v4Vj9MCgUkteiLl+nl59w1OyJenhPYtxIbSYo9DIJh+nx0a083fAPrlS2maRXyZm9fsTLXl3xC1xy7xmMhBqG7GEFh0EZtCVfagM2qXCiScpS7XYZuzNe6n/9eywizKmLsiSg=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	IdtBZU1llF7m+cwKC+XKqhprlT8NE0cd628Sk8cyAHXTSBeOkgYDyEOJkYSWdi8Mx08x2i1UykgWP7bKwnX94LOaFe7MY1UNJrjF3+jclY1pD+ZSa+z5YPVcK/9bCjzldApWyWCQa0PQb8itASg/9htTZSCSD0QYDAag/2Jf/eIwSCmkaXVzOOFlOk4supty6WTUdvrLDxtdwx/t6rlvCJ/ei+6sFxKOgep+ojmKMHbyQXL58lTG5wHK+rr0oYz84MT/T1mTJe0iDMOZoKyAH62n5LUmAQWnVGCQmQH5Ed+D6WqzB2ALTkTVIOXuTPKapK5hKgmo6Ss7L0LCSbgQ+pekcP74FgHuB7/qD81ep30HSiLZ31YSVkaMwsPxPtw9+e+nRPn1ZzjCyVrjBDJuWx2Y9Jqrhjy+BSQlx3QfL070n7crEdViYZTqglWgiugw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:40:20.1048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8958cc57-c063-4e95-2324-08dec645cb7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 16:40:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4188

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


