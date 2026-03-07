Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4108FC9ECF
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:08 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com (MW6PR02CU001.outbound.protection.outlook.com [52.101.48.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3302.1772858638645409486
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:43:58 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=QBKW4zNh;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.48.46, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swjyGODPlA1IevEBtbCYCXOeMzQiSmDSNXAjz5m7st7DIeXt/W7IyoGmQfgwUgZhyylU5PqpCwbGhVudN8ygxu2G92sUy1jpAgowZq7cbrpsKYNXohBbHGT0J1wqOaL8dNOI1ExTNFWEI/uzWxzvF4aBTutsTh9SM7c214xXe6N3Is2IuQwLr8RG7LBVjihjTOmlFYqZsh/QOuP6gZPENQzgdGnin1gfA5wqLl9uW1vj78tN8673iSg3eBpFZwdYwj7i1uslkeiUXTSAWp51b76mbJDgHl3bP4n8EPlvSe+QMj2T3mBC1fntV5erdOq/ul95y21T22kuUCKRRpN+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWiFMSC+fHqgezocxr/jOcebx+xAENdPwia0OzSJAXk=;
 b=E3lsmv5Qi/jwyRgF4wUGjUyKRTOxIP9bpNbYqjlsqyzOvWyrwEgRTH3pQRFmSQ2kgpLBSoJG8FUh3g+N+WKObxa6VjFPkMDHP/ptADeMwHkmCXkw9raZfiIr/q7SmATv+wC+M9ZFZSEb6Obp5WyMP01tDyu8C9U+VgTN4vIBpqYT5uP9rj3BZKqHtHOeLLFIjsClYkhTRXhTpGKZQNZPgODTSsawbOXTtKvfEXAJ2jqTkrOFwfAfy+SOJ1hqyOXQEehpdfm+hiXOuCkTUtgHb0O+DuYJatYgaHVAVqBn8R2Ymk1Xkcy2bdVBYOnIH9sCv/n8cQNqhLmxo8idJzIErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWiFMSC+fHqgezocxr/jOcebx+xAENdPwia0OzSJAXk=;
 b=QBKW4zNhr3l4i7QDfSDErxc5q0Q/6dFLpLw7GE2Ehi5F9uPjyC4R5cGXO2xjTllT6OTf33PQ3cvBEr96EVUQZ3hIQYklzQVHDssAX2wrGDr0e8mDsDOcrr2+mTJiMwwlQ4SjwG69+QbG+bXNgZ2+aMembeHKzxHTLxk0JFfgpCc=
Received: from SA1PR02CA0010.namprd02.prod.outlook.com (2603:10b6:806:2cf::16)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Sat, 7 Mar
 2026 04:43:55 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::41) by SA1PR02CA0010.outlook.office365.com
 (2603:10b6:806:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sat,
 7 Mar 2026 04:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:53 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:53 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 1/9] zephyr: Remove duplicate uninative configuration
Date: Fri, 6 Mar 2026 21:43:45 -0700
Message-ID: <20260307044353.1936182-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d2b2b0-a3af-48be-98dd-08de7c0423aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	CeHLNnwG0iMwOH8qxKdhnP7j83VvWeTWibqb1TbP30U0rbbhgNlH4sQ7TohMEaf44RXkuohWWEdWUiHsZpxORX13FRdeFGm8eakHMv5J7FjEwgNqY3xjuwnvXNp2K8xgWlgOZ0vQw15NTFDayWHdIIymiySBNfJ4g75hPfmYSg0giw9LeIYzOottQDG22v7i1fNURRGSOKIiHMDYVxmd47PwGmli1VAdzRx49NB6daW+4V27pkVVWugI5HWSd84xNFvLi54i+H83k0xtnx8ht+WO0DL+DG+G/k4Kk1AE/P7aeBa/e06TSMlcQZyq+C2PiYeGfM7zROTyVIKhfOHjkEhWPODgw856JIGIwvY+NpXnmefRKH2xXTKbGRCSNy4gy5pxwE5iiOdmngwfx2a7Fbls7DLexnFWGs6vZ6qiiI2mYeD5f2UtkmjYgN3R+4i/isaieFA3Qpy1w6vI+c4AoVVXAj0/E9nNG8S8M0DPmgWa/V6w5pMcJp97DhGngQXd1OQgCn5aDGCprMGdk1p5qdX3bRgwuOneXTV/mQJYIh8JbOin0gfyKZTQdRHKbSbEGSVBpt03R5qFfZDUnnzTUQfgtAsPOcQ22uI7YkWtcnRotNiPvgH9oaXzFgBNzd7pJTdO1MxPjneievmKi6alr9mj62VAIqNfwCyFlRH7wSQ0O224f8AvqAeXMn0XEr8SGpcur8yXW33WxAmM610Kbf4qi4fMbIuCObvHI0NfKbCGzqtFV9gRATjTKH+aglm6vCmXy/c/BKVT2m1Te5nOOg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	xVjrgnHb5GenlUwR/RDmq0quhOpoOV3vnZFqlhlM6Fez1rLVvQPpxAwlhD3UZvB9GHfY4o0NgMhx9FiSwnx7M1emDbsyNu6HAVqvvz3Ob9OFk+2vAvV4dw8YZFTI7RUoq+I7WIhiPIpnTZG3pAhJjhU+cCO/2hQA9lZIJ+i2af7M7mLH8mclXwtwLl33LsYspS+OuJDCL7qgCsT89ZzlPu4OenNUGL/AsqDqpkRiUsrdTBKzJm+5p4IE1DEkhgOTX5BtgyxTMDSn3SwlXXyHFkwtsGnfKRKJRTgdHDmkjVWPj68PDDjlMW+5LmyvgsJ4zaU/KcpKCru2ycbiRr81UjzLB0vG7N8WppzBqWWYh/xKv9KNJp8UFyKrhY61yclWiWz1iblJiwQcBNwTIJkcUSYBxb1vwUcadv7MMgHoJAEY3Qd1VvT9jiGSeXCGzlFQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:55.2665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d2b2b0-a3af-48be-98dd-08de7c0423aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3353

Remove INHERIT of uninative and yocto-uninative.inc inclusion from
zephyr.conf as these are now provided by defaultsetup.conf which is
included by bitbake.conf by default.

This fixes the duplicate inclusion warning:
WARNING: Duplicate inclusion for /scratch/yocto/yp-master/sources/openembed=
ded-core/meta/conf/distro/include/yocto-uninative.inc in /scratch/yocto/yp-=
master/sources/openembedded-core/meta/conf/distro/defaultsetup.conf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/distro/zephyr.conf | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/meta-zephyr-core/conf/distro/zephyr.conf b/meta-zephyr-core/co=
nf/distro/zephyr.conf
index bdf1821..8921ec5 100644
--- a/meta-zephyr-core/conf/distro/zephyr.conf
+++ b/meta-zephyr-core/conf/distro/zephyr.conf
@@ -10,6 +10,3 @@ TEST_TARGET =3D "QemuTargetZephyr"
 TEST_SUITES =3D "zephyr"
=20
 INHERIT +=3D "siteinfo-zephyr"
-
-INHERIT +=3D "uninative"
-require conf/distro/include/yocto-uninative.inc
--=20
2.34.1


