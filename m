Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E9DD6AB03
	for <webhook@archiver.kernel.org>; Thu,  2 Apr 2026 19:51:21 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (SJ2PR03CU001.outbound.protection.outlook.com [52.101.43.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4876.1775159479092048306
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 Apr 2026 12:51:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=SiGnPSLe;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.43.66, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC0Grmly53QBT+ZSPJX/+zKXK7AWYYfCtQ/1Sob9rKHh1Snmh67rbgrW9FWHGm55AXnPoekM1P7B4er32Qh61KKzp3JPFKeSxQ5+W4zNpa+40nSNsShA+tuENAh0j/+7P/yQ4Kgr09iJIT5pzpNBLMLed6mp0kH8V62nZipv5wBEYxQvnf0yfnnVcyefF8K746Np4IXLhLMf1N5nwP6VE2MX2o/7iS4q0asuJpb7ALJk6HOObvFtpEG4wLQYgLkjVwEdVZnqj4JQVQNZqHJKpL45VkrPWBLSn0MeWMsvbDZD2Za4BA/5mKrzKxKpncj3OioH4PtWQQaRiTBgJmR3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onewwh3wQDG4jSqwuT24kif/EHPB2U8a/6T44GUXflg=;
 b=mTVJ6bYOKSZNnC3aT7WIaX4wJCQKuQjJPxXXHl4wujm1Sz4q2vCGXiMdxNE9LAnMZMmb90ogexf3iZ8eE3xEifbqlgnTe2JMUHy36qt/Dqm+6d21oSKsPBqgXuXjhczzB3Bgc05bZ+MTnZq1SazyBuI6z6ebGFRn0R956k/UQWaR3ZSEFCLP5V62c1br/w/zuAa7EpJT5LakYHcMI+SiYUhDKhPdAYN6dImAll0juHjlRGxs8LD7rpNGpXmtlH34ufur0zT0CcEqHU6L8UPatHKDmoeryEillmOvGWQ7bNcLH7cByZF6W9HpeB8tw97yMHmTEEmRejKEkKdsJn/nCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onewwh3wQDG4jSqwuT24kif/EHPB2U8a/6T44GUXflg=;
 b=SiGnPSLeMN/lNK0wViumwi/5Q16H+sU4t6Gfq6EyC0dAn06f7lZM9smtWd5eORIeu5msz17EJj2G99otcpX+2iG098PUGEwPbwbiJd6K6CbPaeuEYY4a0IwxTav35MsShfbh90WO2aFRXR8jTsSzozWCDAZ+2w+W3m1Z7tjaIjk=
Received: from SJ0PR13CA0234.namprd13.prod.outlook.com (2603:10b6:a03:2c1::29)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 19:51:13 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::b2) by SJ0PR13CA0234.outlook.office365.com
 (2603:10b6:a03:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 19:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 2 Apr 2026 19:51:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:51:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:51:12 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 14:51:12 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH 0/4] Add app dir support
Date: Thu, 2 Apr 2026 13:51:08 -0600
Message-ID: <20260402195112.1369295-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: 374fe707-5651-40b3-f417-08de90f131cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	56GrwNZs1/dXiIDPLjM2IhIkKyoVgMjCTlzy2AwbDKpxacux+KVa5yu0dcBoqDGUbHJbrTWW9rMyc/M2pedPlAEgA07aMbaoed18zJmbm3IeI8bA8xtntTDUnAxJoRFDBKPcHnMMxMfh+KghMJc6t1p4ZCtpXx+J10+RY8Qt4dbvvDFr5i3cY2+DKdY1tto/W/mOeEhSDsNsZG5Nt9RMmZyfcC+sk6Eh9kxYdwlNhM62gZHtjSeHMlg3AhSWWbsmqYhw+VFEILc+deZZzbXD/0gmUgcW861ayTtDCzCJaOWOz/YFedrNAHFssrQzp7TlEMMVQ+pwvZ7IiUESk1DRfI0Cgwb8ulM/YMsjvY8ou4u8dkgBOHc8gQjigYEFnzhb/HyFB4HuW8iuMdyIl4gMMEWwFrHYx6krzb5FU8XjdKGzyTSwcYZuRlq+w2K4Mtj/ebELfKLJ2UbB2yY+0Xp4zdJy7ErXdm/zoGOesevyEaAqxv4YN8/PeM+RrKw1BxbVc83cB//3+ehQQzWv0gSJbkZPcVr1kJDxYd2u47wtlXKjLoJbdl7Nxk2tSO959tLiT3LieQ7JBpAP17AgLyajxlipXGlvYd/xFBPTkJMMZfk/qNBVkUexdprlEJ1CtDXKFdzyJUMZ/Ctn9SqscHJ6or8zw3t1x5iqkSLK/l0p3DKH6RGwTRwmYM3RkHJagdQhi7bQFhoKNqpsLL7VzHsk9LSQlP/nTNcEMWRz0dX8xKPw0GimohmY2NorK4TKo0U+uCK6fKoiLGFV0bSgBEDSOg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	a5I8PuBLt/WJsFFgLVmpCbrVfonxN/rCgxtcgI1j/dCO8rbR1QJaQT/3l1WPjfTFXAgbsRxx+p8+C7cg/eDHwf7mM4bEsllcOFoOC7bBpTGo4G5pcWSfTJDT70w/BjI/4j/7wzzVEtOjjcCE90PF2J6vJ8YDwAJmcYYEDBlftM9m63U/XG16uANeEjlKZNtuurvQ4auMJgAED9DiAYUfCo7xOsaPjN/zdRP958C9MDBS6FJ1ALOH4p03DUHFhE1JPhpPAPXqOncL6R6Swif5aMq5O6JV6viTi0ZSw6D8CxN0qaNC2UQTy7VsUt3e4c50BQJoieSKPII0U/Fg+abWqJtVN4QsYSlVn5hXEkaTau2A7tFGx3GQw+bRYhRz5bQMuD8pm1d+V4WRLo6jZvR1UTqB+omdLeBC7s4weTiQBpZMPZJTSHUgt2BfX0JsLIVX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:51:12.8904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374fe707-5651-40b3-f417-08de90f131cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 Apr 2026 19:51:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3618

Description of change:
1. Add app dir support for configurable container as default
   installed directory is /opt.
2. Use yoctoproject.org for HTTPS check google.com may be blocked or
   considered unsafe on some Linux host environments, while
   yoctoproject.org is a more appropriate and reliable choice for a
   Yocto/OE layer index deployment.
3. Replace deprecated libmariadb-* package in README.devel.
4. Document --app-dir option usage with dockersetup script.

Sandeep Gundlupet Raju (4):
  layerindex: Add app dir support for configurable container
  connectivity_check.sh: Use yoctoproject.org for HTTPS check
  README.devel: Replace deprecated libmariadb package
  README: Document --app-dir option usage

 Dockerfile                   | 24 ++++++-----
 README                       | 39 ++++++++++++++----
 README.devel                 |  2 +-
 docker/connectivity_check.sh |  2 +-
 docker/migrate.sh            |  2 +-
 docker/refreshlayers.sh      |  2 +-
 docker/updatelayers.sh       |  2 +-
 dockersetup.py               | 79 +++++++++++++++++++++++++++++-------
 8 files changed, 113 insertions(+), 39 deletions(-)

--=20
2.43.0


