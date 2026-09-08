Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43286C79F82
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 17:31:19 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.11])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.894.1788888675219640489
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Sep 2026 10:31:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=00sFoNec;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.200.11, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2GsUSy5dnrWigTX8ZuximJWcZMqw0890uH92njyChLoM5CozzhAYK7a2thO92fJHKHdHLPzWkKTYfLJOmMgrgPMJxWm6leMQpx6nLHt2j9O2rohLGjDId2udr9YKpRvsmKKytXuEWQtaMJjjhgn55bNLJDFa6SBbqGenTl7g5iYBTTes4F5MVXjRDEE74F65NbsDyoJo+wvCm0ZjOIBX2jOQmQeLPVrEOp/tvGAoPhkvUPfo7Tp1oY1XiA7/5UhhBnZa1RdPn1aEkPhOa/j8sBinUgQ6k6zoc1M1MfI8sT7sPYqvmsQRlFShBJMVMqjZBV2Ds777abgO3TbIA+ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJyzEhAJOkRZPpfMglh3guUvq/giijEyR+C3FYLub1s=;
 b=rzU0ecO+Sr2PdOz+LqH8kwY05u627r2ekXvPnBZxVyEBd9BhyPtelybmqnUgGEg2RWrwVzxMvxQpcMrpJ7lKKzONyFF/GbhSOfnNdL2Gzg/Yc+TZgVY1DMIfk3Pu+WUW11ZCg8ly+KZ3vaJm/8pzGqvZayeUNDmDmmaNDLSeagrkt26GVMuQYA42wIFII8BGQXB/iwIORP6s9QeJYn3MYntjNhTUWQv/SYSgVHgDJAqndfcPFz6ofd0QXo9xnTwrPEV3hvNDd5BLbB9H9z/MrFWlSap1Rjrmt6W/EhhjHL/Ijmf+pDi0PIqt2B3K3dEMKK30Dj2q+AYEaAFOadBrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJyzEhAJOkRZPpfMglh3guUvq/giijEyR+C3FYLub1s=;
 b=00sFoNeclij5Y5sFHO9EOsmx9O19MkDMx32KYOIVfk5Qnt8lnjG4/FyFQ8qY2C5akUNoUvj6IOxO6T8ZDYr+aE8j0uBHDURFQX0vHimYspg4XioHlldqxJNs7ZwbmdkVuGg0RYkJgGsaPP/JUXtntcKPI8MxliAYmjqyUcI30ho=
Received: from BN0PR04CA0189.namprd04.prod.outlook.com (2603:10b6:408:e9::14)
 by DSWPR12MB999129.namprd12.prod.outlook.com (2603:10b6:8:36d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 17:31:09 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::93) by BN0PR04CA0189.outlook.office365.com
 (2603:10b6:408:e9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 17:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 17:31:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 12:31:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 12:31:05 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 12:31:05 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master, wrynose][PATCH] meta-zephyr: Add SECURITY.md file
Date: Tue, 8 Sep 2026 11:31:04 -0600
Message-ID: <20260908173105.3926377-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DSWPR12MB999129:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4213bb-ddbe-44f3-f48d-08df0dcef813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ocuZ1whiwH3hHyi942EJbR5caRwZ4v/AaH/FWzspaM2L8J8525FM9UGDroaUohYWU19i7V5r4SnhbyEhLcPjWBQMhApaMxsyTycptdtlgamomB8Mhjp05gepsJSUl97/Vc8k5FX8EzJGvGln4hNj7osDFRpucTWqrxEmwpu8Mahn2/VohT1bdLRWyJhr10mvQcMwvlHUuJbmLJYQjlk+FsdrCW8KylkQqRNW1k7OVhqFGCh6jDwEwwALnjMv/M7mhWJMvdtgUS8CbPK0XKRmjgwSW5K/YuxiYDmWxFNqH4whxN+dSc3VieQ4lQtXFysVZsJ57tCVMmW773PYBQZwsnbTMxHpI0PVAO8bZQkxEkG89PDWwvL/4zcedq/thgUHGXy1fhQr8dPjVH7IA0dSjS0hWtNdouJ2FePtJTJ+9kNo9EdGV6n0cQsi5N0e1E8ZJZHOlR4wPVuAwRjqv4ODdd/WsmGnRaPKvwy0u2ZhI7N+nilGeY0OfkYpZt/Q4+dJ4WuxlBlftgFIfvjLjFYcDlqe8nEjtwa4zrq8/yZGjE/nKVsNm3fWFSf/j2YEQjE1UolRu3Nh/jOgrxdmavuCWLh90rZATwN40Xq+R4yUjuAYQ2GLJlowWFgPiAA36Wgf0+eXt6v2P/v8vd2LJCBFyg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	S7dJ67CbVKzmWYJ1jRRCtO8foJegUp8RR1VhCH8YWzslH38FQRyeKbXW7T7mIYJFsv8Jof0wkWAd3eTz9O1RfBuMlBCDDbC/k11kQotGXqvxaTXUVf0xILFMQQIoFrRVwCEHYwby+7gIS5aFM2D3M3aAHzzTlIhXyXRO54j4kVVv0auT1fSYWQwWeaeCRoac0CIrDy+rURQqYaWwtlRVt+D8GdnuFWkk0AC7OJo7wpzz/RDSAaSE36OmPh7DiJBOvbgM6XsScgRWVAG7nTcc4OP62sMuLwcT0g+QvugBEYK/WTOuKCwtXEBiWuCM/mDrEflt4vszLVeKYcEm8A9lpwKCceuvhuN4ynfx4A0yZQ5Uitupt/m+qc2ElCZJVXfDImvh29eIcbcu3+s5uS1jW8qVEcPis0/agkDK8TU65jwBnN5n1LcYGdxXUu7uE1ot
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:31:08.5977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4213bb-ddbe-44f3-f48d-08df0dcef813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999129
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Sep 2026 17:31:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4751

To be compliant with the recent yocto project security
processes, add a SECURITY.md for this layer.

The file describes how to report public and embargoed security
vulnerabilities, and points to Yocto stable/LTS and release
maintenance information.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 SECURITY.md | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 0000000..320263c
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,22 @@
+# How to Report a Potential Vulnerability
+
+If you would like to report a public issue (for example, one with a releas=
ed
+CVE number), please report it using the mailing list as described in READM=
E.md
+If you have a patch ready, submit it following the same procedure as any o=
ther
+patch as described in the same file.
+
+If you are dealing with a not-yet released or urgent issue, please send a
+message to the layer maintainers, including as many details as possible:
+  - the layer or software module affected
+  - the recipe and its version
+  - any example code, if available
+
+## Branches maintained with security fixes
+
+See [https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS Stable rele=
ase and LTS]
+for detailed info regarding the policies and maintenance of Stable branche=
s.
+
+The [https://wiki.yoctoproject.org/wiki/Releases Release page] contains a =
list of all
+releases of the Yocto Project. Versions in grey are no longer actively mai=
ntained with
+security patches, but well-tested patches may still be accepted for them f=
or
+significant issues.
--=20
2.34.1


