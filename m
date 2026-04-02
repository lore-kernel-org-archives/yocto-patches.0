Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A881D6AB00
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 19:51:21 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com (CY7PR03CU001.outbound.protection.outlook.com [40.93.198.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4875.1775159478794999956
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 12:51:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=2CJ1dku4;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.198.56, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ml9wilE561z1Q9bcgRE8MPMhge/jsa9pRkjfK2yK+DvpQc+0EIUIbJ2jC8fBVLmkehgnR+6MPhVSB1P06ghBw0eMp8CkfyxkOGZcoA/XusAkZuHIiTimCwKhsqLW7oggFJl23a3WJl5SQWbB7RHG3jSHsw+u5kMD5Dj6n9v9PhCP7ilqJrdycObEME7KP21G5z77C5u4oG6JuUxep1dIWtkdyP9irEakMu9fQWUI2CIm0wZklGM+lSL748yGM8A5i/JE2VG5LUTQD9FrBUK1yIx5Ybri2QU4q7lDePexQPXGhNCNvyNzEFyn4YiRGba0GCavCYUYYKf5n5oL/OKAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzsJbfp+iI8vNZWA4BV/x1WbeOqC9hLdJPBQrALd+8k=;
 b=ynd5tb+1PQbrLzZ4gfCjennhgONucPu3yrC/jSMrGUgUT5KXU9T4SK4l8GheY2n5QyAvOQtFuNqEozFX/nPExpXMdSWPHSTfbg+KgmfaCsQJtCXpC+71UgwUE82kfk1W5Ee8zMZYX71HM0pV9fTpm5V8TWHARVHSUKMhhXpXNtvGxVTH6/ay3KDLkSUbjmLDYh5qEWKLzLStXlbmCjWNmi0B9PHJVqzrecsc2Rg1U/CjMAVNRjCLM0Rh9r8ko7eH1hT8nlebAAMAsGRxWgXw51ZPqIbXd0WhCTWfeL9uwYGUk3TLW4m7MTyOzAKob5JIhVfOyQTLZ4Wz+vFeUpSrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzsJbfp+iI8vNZWA4BV/x1WbeOqC9hLdJPBQrALd+8k=;
 b=2CJ1dku4o/4FZ3jsJ/BtjQ1LD+hw3z8bqScR39EtHYMoWefB1OzrpbzTqYYx8vuo2Y8YuM0O1D5++GzJjZaI7oaIowP0FcnyltrcV6v1K3cm2uwv7DwwMNQBPeIeTsCbc0Mk77XB7qbjOAa/6UtqHR8pXDU2zkSB9n5Bx2JWOes=
Received: from PH7P220CA0051.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::13)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 19:51:15 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::52) by PH7P220CA0051.outlook.office365.com
 (2603:10b6:510:32b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 19:51:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:51:14 +0000
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
 Transport; Thu, 2 Apr 2026 14:51:12 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH 2/4] connectivity_check.sh: Use yoctoproject.org for HTTPS check
Date: Thu, 2 Apr 2026 13:51:10 -0600
Message-ID: <20260402195112.1369295-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
References: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: b704d759-11f0-4232-b413-08de90f132e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	/Vp5zvZRplrR6cyVgYQ3fN1Eo+yus58udDTZAkoHI+dn8cLc2/YJDX6bUu4HLb/rUv5bJrxfOzBVTUKg45Mk+Ld1R1P+m+9DbDDjB2I790zS25TJkzaZKr3kXG7Xx9oXRyIShNsowgKmpnCCEtEsOQDW7XGKlwtnb4IfkIL5hhF3qAfSVG1M2mhnhXWSgslKtForkfsFHnEbe1GV+FOd0Kji5XZNyKXrfTGoQxZL/KJbkSBIgSCKJ0X6Ie2GYbEf7CTicfAuo0TAFT3G6OIVNxnLepFdz7UcHwpRF/TZ9t0h3cpf08Jkwr94bIqKBEtr165hWnouTIy2gE70VGgWL13IP3G/lJRaNLHftXym29Nil4Lk0S+JyZims6j/ZLsxHaZxJMJZuh5Uqy3KyBeC++3000xa32FfmyA2iPeHf5SRRgEmFd/DrQ9Am22afbNv4OtNcDDBxHJtG2qd332pRh5kC1Z7YZHh8j6HVkv9kSuCl6jZtSbqqbVfJsApyYWXudl0oRZ7AJ/uI6OWYdkBNkzdq3mE3hHIW4wzuCKt/wTOp7eS9Aw/DCp4fNU/AZ4h+3eumdhrUCKVK9dlhVMDjKCrUojctHMx1ratzuVwo7shPQczpYGYqROkEDugELiKMxHoliRwsEFTWfS1APz07Nx6Y2we+DfMTgcqwcVRNm1JBIReMbei+1GVOcfbUIvQCk0qE7DtfW0jy+DTf7qMYg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JJ1c8VSg+S8zA4rzdze5q2vGXFa8yxKo4cd/7YGBl8fjOOlP6vX4GBjXbNzAQSYKLHPZRz4angwktr1PH/qnnHAnk35m8i264231XOg4MNjhaPr7ru89ByP5DpXB0SjA2V8secqKwvmKwW3q13esy35Kz/xc3XpAOh7Lv0h5figQeRvrdIZRsxz6+M1u3rvr6C0HLHCDXrNGy0Iwn6UC+FlE4BJ9gd+QyZ4KzKDZe8EYpyEv3lFZAFzvMkVm3m0FsWb0NCoIruGgVQbXh25kCK3eTnwibTan0eJAqOFl8p2fKNQYHpsoqv/NoI0snYO1snBvc16fXMg0dZlK0iQzSNMRUVOBFleAr+tXisa70m/8bwrlbeAS8CX7ajPe5v+2vZkX1i2K55EF/0MKOa6FGUm+sG668iP5Ku2UcihRPYTMdWtlvlTZOdlbcUjMCXb6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:51:14.7677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b704d759-11f0-4232-b413-08de90f132e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 19:51:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3617

Replace google.com with yoctoproject.org as the HTTPS test URL.
google.com may be blocked or considered unsafe on some Linux host
environments, while yoctoproject.org is a more appropriate and
reliable choice for a Yocto/OE layer index deployment.

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 docker/connectivity_check.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docker/connectivity_check.sh b/docker/connectivity_check.sh
index 59b26b8..89931b0 100755
--- a/docker/connectivity_check.sh
+++ b/docker/connectivity_check.sh
@@ -18,7 +18,7 @@ if ! wget -q $HTTP_TEST_URL ; then
     exit 1
 fi
=20
-HTTPS_TEST_URL=3D"https://google.com"
+HTTPS_TEST_URL=3D"https://yoctoproject.org"
 if ! wget -q $HTTPS_TEST_URL ; then
     echo "ERROR: failed to fetch $HTTPS_TEST_URL"
     cleanup_tmp
--=20
2.43.0


