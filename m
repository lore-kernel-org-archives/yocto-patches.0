Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB775F46C72
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:30:09 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com (CY3PR05CU001.outbound.protection.outlook.com [40.93.201.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.60412.1775496601821742478
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Apr 2026 10:30:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=C+FqY3r7;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.201.69, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcvpZWsqvPYLiNzsgAzussT5Rg5LPO4xZ2Ht7A39egPq4H9iehcGlii/3/+4/YBwAtu4jKhOYX3XQ6+f2h5286bj+Nk8CyyTvMSEHk0cKOYakvKSxJkvOkUcM+8MuT1jvBeey0YA4QnWXRB++w/sbI4GydtgUKSfXMaFqsniZB0W42WEBI0t8RbYJezJCer0IeK0JMymysxSY+gVkg/BiwvdcaeAPoBYi2LxhSTr+O4z+hj7Kt2NMeipoksMcESIsplnYLUrzOLygGKZt07Phl9K02A1d8O8CHz0rzlquzXXhDka8pD+lVAorIF2EsBlvFAAeeOPAQptXvDa4XqZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsFlnmBNAk9iGitCzinPS6oQTr8lVQ7UITjgFmsNrO0=;
 b=bBQ6pC660zyZS98Ygq6g9YwmXReFZJGXRXFOdM8VFem9g5gDSTJYTGbOQwd9e9N9lWD2TRC/9FJRoA9a9UpfmyS7VgDVKtYAJ+bGoZ9sXmKEb1+DVUrCq2RZJGOJe0BCmSjQ1lf6UPHq6vGDdqDMN02kVDZxOB6xJjVYlQj9nNtHDM9TY1fTA0rs2OLZjjsJB+ZXKQ5nqvl8uGn1dHq0OxQ+H3d3Zt61yCL0v34YGun90HtpFw4cFF1Kw76xIY+gs5djSXZFfGERM8Ozkirak2oujZp1nrtNylrK8npHCOcbA/Md20yoWI8u03ULEKBsgTkjgRWD2gDcJp0Fi8nLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsFlnmBNAk9iGitCzinPS6oQTr8lVQ7UITjgFmsNrO0=;
 b=C+FqY3r7+EI5lGoGbpEPxlCwWw3HUUXkAdaQb3v4ZGLZjoat0lQMZCwv/fijWVv5nKXAq2AOcGj2/JRNBcKpKD4eChn8n5lysQ6PWg1skxnnYNyPIYX0BNpHUxXucrqvLyOgcbP9IzfV30JGMCDsoVXObUFgKeo+rFSzLNYU3qk=
Received: from PH8P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::34)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 17:29:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::d0) by PH8P223CA0015.outlook.office365.com
 (2603:10b6:510:2db::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 17:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 17:29:53 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 12:29:53 -0500
Received: from xcosantraju40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 6 Apr 2026 12:29:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <tim.orling@konsulko.com>, <mark.hatle@kernel.crashing.org>
Subject: [layerindex-web][PATCH v2 0/4] Add app dir support
Date: Mon, 6 Apr 2026 11:30:06 -0600
Message-ID: <20260406173010.1366742-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 7466a2f1-0686-4bac-ffc9-08de94021d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	txyi9M48wqTQaIwVmJoqKEPSeWtqYUDq2etrRlkMCd5EmIBoAwtOCBWhCZH8inGyBZRwH4nea7/XSijZett52yDBfoMUpOwf7XYdCm6XgXN2dBWJaL4fPRDxg12GSjYyVq9AbGRvp/7q11TsARvqBQWod/xmgG76ucNJbPvAAMafS0He+eGNo8iq5ZBlWuWCsjAHj/DdqcTaNJOJW5wwZ2EzsqQ2RJBV9u/j0yW9yrb9+e86JH1BJI9bqVB/8JYjFIprH31BfNUU1XovD2POKyRJ4eGBfFTT1f3c7WIgN+staTgQvwJcFg2hRJ4QR59snhm9JJlc6unOVxN9hcpGLn0HUmB1DpzkooKVW16Ii2iwHoWS/gZ7FLrw0t2pv9ft1zWJnt6/xLIRmW7OuhbFk6xeV/6QXLb7bN2oLEImcERkaN3Et9fSA5l1Q14DyEXDXZdI5ULmpPu9B22tkitMVkaTQWxd/k1QId5nFYr82bVUxyJfezFqlBQXyHKQGzXKXwWpGBHXT7XWYcqhW+c0BLuqmiSKUbXHkTQzREGKEPgdqV5DI1fX3u5u1Gjtnv8aIDSRsZRuznfqaYDaWrPcA7sEATZSjHMEjFiPRIpC/HvyEwIZdQUbkhOqZBJXobC6JKwlglOzVtUL7Vn1Q+jCrW2GE7v58V1C2EEASEoohSiAJ0MDX2AV0CwcqO7N3ZKVoN3ykZnHRpyeBs/0K7iDLfKbr3fKeDOvvbFcH1vJf70ogvQfU9EuNaC8Aomj67W/VUNyy8fvbM6Rb3A0BNW0Jg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JKqzlaWpapZEE0gMlZoZm53QiO29ZzI96A7ThlsEYS2G6bi9vM+USvjNFQuR1KDAJP4h+wgMqoASiCtXOpQm4DQRWuTNU92n3mUgV+YTVXgWaHZ+ArrDYgAI8a86LIU9IYJAZNIpNV6r2kw7Bl0dENqyTumLkF4ttHw1Ig8npvUdVKVWF2Kjms3SJ1dvdo/gRKWeSV0eMw4ANgbkcz4FfOM+Fsi1jLAnPsQohCUrRWKn6Adf5sDXg6Kkt+ZgZzg/jMlPMGsTmD8cyt/re2jrdBjutSLjDX+nNCXy56rDO+en+5T6xGI5FPd6JcxMHxAQB8JAc+1QGDFbMzrM9ru2qQPf92aiW7dgffWJnJfPS6Ah2Nc3h5+sJQOatKRZVJrrChMdIAcjjeA76wgaYW/v122RfD5XP6GKlKzxJehZT/hZdwh/4Vv1TM4HVVuzYzns
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 17:29:53.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7466a2f1-0686-4bac-ffc9-08de94021d76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Apr 2026 17:30:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3646

Changes in v2:
   - In "[PATCH v2 1/4] layerindex: Add app dir support for configurable co=
ntainer":
     Pass app_dir to edit_settings_py() and replace the hardcoded
     LAYER_FETCH_DIR =3D "/opt/workdir" with app_dir + "/workdir", so
     the fetch directory respects the --app-dir option.

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

 Dockerfile                   | 24 +++++-----
 README                       | 39 ++++++++++++----
 README.devel                 |  2 +-
 docker/connectivity_check.sh |  2 +-
 docker/migrate.sh            |  2 +-
 docker/refreshlayers.sh      |  2 +-
 docker/updatelayers.sh       |  2 +-
 dockersetup.py               | 86 +++++++++++++++++++++++++++++-------
 8 files changed, 118 insertions(+), 41 deletions(-)

--=20
2.43.0


