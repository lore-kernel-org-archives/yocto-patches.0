Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17445C79F82
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 17:31:49 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.869.1788888708056836079
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 08 Sep 2026 10:31:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=jrDS0vj8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.46.50, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUCVdACF8Kcu3abJcKDh2bGxuzi+jttoRnRxam0cVVj3pqOXd0Szzr5rAw5p03FBN5dCLCq6ypgZ0FHC3/lTGp0Apz26iL4VEoTIEH+96it3QWEzLmatY+ZQy+CahrR30bCMaiXtCCM0NZdlSV/n7sqPdIHgzC/zs70BE+Nl9twT5mZV4lNmQrMNPKdU+CpHTsJLU2Fw+A5qnFpfK0Dvb0jG1rjiYtF75VJQtaeQIKeroRfrmP91TFqLAaufDnYV/0a+do9y/medtY9q0zS6460fsq+M6vupauQEORWE8SXCTLvL1R9Lpms9ngh6hGxcaqqep0n5ZX7sMELje1ooHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJyzEhAJOkRZPpfMglh3guUvq/giijEyR+C3FYLub1s=;
 b=ebmexNpFzMLxZYynfstU5V/idiMwrJPSTZDilmacZ80R2oDIzVK/WUXtzEk7XyaHvsU4+YIs0lZUC8Qo2akJVAC5DQZp95OQNaILlARUtgySskdys4XWrfjuV16Q3/g68RCgZ8mltOjm8s0COZ2TjMnzsnivkj2bGNCZ4GWo4VvWvvXCqutePx5ePOFokad9tBWoFzAATjiwnl82V+brzgBck50gc20Wv0u1r7OoGgGNOJ4/RAon6ZLUHTYB5f0uW/SToHDLU5N1TPEkCQ8KWNA95E9JLCWoyN79BGgIsw4O59q3CLwWJx9nxxmcLnBwV8+X1TPGpSTW8bbgJBIkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJyzEhAJOkRZPpfMglh3guUvq/giijEyR+C3FYLub1s=;
 b=jrDS0vj8Yautn+10fw8e4eT/lBrhhtb4EZcI6HWdekTH8t/nJBQCGS0ufL7rN3k6f/gaLlne5VwSpTDIKc8M/leput34RhQkFjUz8o9TMxg3WulefS0pNALtA8sfULM2iszC5o9TUcSKKsFGtuOLK1Bc6T0mhansIcPZ7lGT24I=
Received: from BLAPR03CA0107.namprd03.prod.outlook.com (2603:10b6:208:32a::22)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 17:31:40 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::9c) by BLAPR03CA0107.outlook.office365.com
 (2603:10b6:208:32a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 17:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 17:31:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 12:31:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 12:31:06 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 12:31:06 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master, wrynose][PATCH] meta-zephyr: Add SECURITY.md file
Date: Tue, 8 Sep 2026 11:31:05 -0600
Message-ID: <20260908173105.3926377-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908173105.3926377-1-sandeep.gundlupet-raju@amd.com>
References: <20260908173105.3926377-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 1819af3d-11b2-4aed-b709-08df0dcf0ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|30052699003|36860700016|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ABSGdsVEhYuwpoUz7Vv7zXXTw/U9s/zzgLEtTivKoqMNVf0Ny+c4OXyWXi7PB+wa25D5SUuvo2TpewVEckDfWcUAv8GeeNAFcLhT7Tr7TY1P0sPBKFiCddhieZ3owTv7qId9nI5/yKflfWoLftIItiYVXOmnKf8GGLSfLzyqzJ8rInUp35O5tPJZboqibJ01AYO/z2wCRg8jHxWIPD/maoT+MRXLUcQPeGVisTD8+Cb6OWnoVNm1jpNGwVhrguprheCs3oxvNeNsq6bMvs+H9FUg+jhnUqIQW+eCWt96iXuRPIFLUdVX7wGcfDEOZ90A1D3CcKV8/quxmwe+V9zvzjjGDaLggSh1pSi3RMQSic1htdabNE9DI4VKdWGxlU8nq8iyvsYjWNn1HrXq9uK1dMZbnLu57uLIxm0fXVxEDNq6mFFHrak8A+okFTdTCnzCQKx6qpfiAe5A6iDVNvvpeovVxc5u6S0AbyBgoFGyiEMI4QB1s/U2f4K8lANMg0UcXhuZJdtPqZM3lKCj+NKyOa/eqYGs3AN3UPAgw4eObvIgMmCRJ7saF2zt7lHz2iu7zTF8f3PNOVoE+hEBr/pHcth9s5dUbTrW0tJJkTAWwo6fwno0YlG+zjHjaxXWrCl4g+vuiqw3DV+NqAjNY772YQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	oKtiLCEchVI3s7twbcSmlAnx5X7lsPY0MQC1GwB4VdQN1jqqpVmEVKIFXCg9p5lZ0W4YZwF91XsXNZx8Vsxo8EfCjW22tvZFK+OalPtumbc43vQa0L4rv1iu+B1s7QaJtAve1rtHQkiov9RzlOr9cxobvRNmtaXm/zOVPtS4hzB5CqO6Skc1oy8fOteVB11wqqfqkI7xDc76ZAUxkCd2ccN92zj5GOsWnNTc9mriHQm24UmUaGqs/ENWw7+kbYBbMpe55mPXAjgzNr+yzg4Bu1nFTVrGQIJ89caQgr3qSIBqvIPHrivf00s9bAjMOt5udQC/08x2lN/PGdJkksuA9psA089Ui9uzEiGOIfJjRX4Ih3Dttn7TUGO0Qh+7fyHPB+Pu/o/wZ1QeWakdc+UHhwpugfhLXSCNRJB7tMU1mD7s4h4/JrFVf+fzF6YCce0a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:31:40.1359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1819af3d-11b2-4aed-b709-08df0dcf0ae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 08 Sep 2026 17:31:49 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4752

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


