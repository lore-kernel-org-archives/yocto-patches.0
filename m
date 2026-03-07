Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D0FC9ECD
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:08 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com (BL0PR03CU003.outbound.protection.outlook.com [52.101.53.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3317.1772858644526786577
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:44:04 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=x6UT4fmN;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.53.30, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBgLy1n6cZaFDpb8QVsJ+cRQVUvrimEBwX8qqHEPdNbGUUlmTwXxdWSBJI6PhjNln6MOIedWGO7Vb8r4YjdOX+Yj1hUDCbfH/W4HPqZdOanqyOvzl2OnH4lAStd3eoz2KIImLVzsdOOGi1uQQrruJE7hB5mHGS0s4fsSniqaobzxnE8oWjUWQS3O4yiDqhplux3samrT4w4M1vtJRo8QrHQTE+tTgberYt/uShSXJsA44UEym4H5YNuZ3JLqCphpjXNzmC4uRdVenBQuFWth4KWZgBwsWmjzcbJJrQrBZyJUbCOhBGmvCbStj147WUMPMX8QbhE/IFv0LMJ96Eshyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMXwfSX/0429idSRG0XBYTzo7Jpy11MTaI4cqkdMCcM=;
 b=qvnu2lE4BbF25NPTtwJXi49TmDCo/wNDKmFSJ9ApBBmi2SdQ5HNIYPrFGXSS2eOLff/t3dclMk+RU5VC6ypSXV+/1Ews01G59Kvwlzwit6HxLVaBQGT4pZJe0buEqGE6jinF0nB7IGqTz9zhX1aW5pjXOmkLfmTyh8Ge48B98MtIJPyuX0WRrIxuG1JxRSHpIJyGbOrCZtQMlUUMNyMw8IFiRSnQmBYGEDRpmB2fatFcb0H66MD7wBMyODn3OqwowryvcYoWELdO4sJm5nwE4VKpV5FGzaOFhwoFfZeAnplIIA013FT+Rr4gHVoeTWC8isG7yGy8LOkcJSJR6cT89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMXwfSX/0429idSRG0XBYTzo7Jpy11MTaI4cqkdMCcM=;
 b=x6UT4fmNEiKpJN9ZpJr7rmusvamsy4ohXOq4Irn5/9QmAdFWtDy1v2fvqFpcg5plfuVS4bP6w/dQ/WpOLRBoZl2mHlP1jD/6CsfoXdo689MloROV0E6KXdFPXEgUa1FPYCive0v/USTgldgFR17EOp91Z16DPv0achn8G0Wmv5o=
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 04:44:00 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::96) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sat,
 7 Mar 2026 04:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:55 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:55 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 7/9] zephyr-kernel: Move patch out of zephyr-kernel-src*.inc file
Date: Fri, 6 Mar 2026 21:43:51 -0700
Message-ID: <20260307044353.1936182-8-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c50dcf-bab6-47b9-5611-08de7c04260b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	Rj+BPcYn1IEPKtG+6LzxWccsFG5sNYznBphi6aNtsqkyzyqyPgUe6+OuTWDkGLQcnA39A/QbgVGBlZwQdeyNPyJRQJ6vPj6qYtTyq0pYQ9H8zCQT27sb4lSl4Q8it102eaYm80Wg63DIuNol3TXWFXXSdwC7oqhnLcsiwv5Ht0/g/XBPnxWx29gTQTIM7GLIAVgZ5tWnXA3ffTExYPdf0dMJ9Z2hOg7ir3yUJ12LEbWB1MZ8SOjll/HAxgmgYruwjKdq2fnQJic5s04TDAHZCUVLCHL1uonPGri/Jo2Gm5foxyHvtk5dB4GkpMurW5bZ1olkYls6KuIE12hZo9AoSioSHPTnHeuc6gQM//rT++7HO7/iSevqZiE0WHwF5HkVc6hUWMFY2Xw3mXVm5OSTKN9xZysKsjyu8a77Adz371V32xYyT0TjGsKOB9urXctrUlyqwOoqRaw9B3Y15apEDWJ9990sF0EHoDrXC32IKSpFH078z9AE+qPvg/Q0b3O/LXajqy60Vp0GrWVW5mHbSYsWLZjVj4Fj0iJIMs3bcRbCPooCVZn2FY34dtooOO05r+gYj691Bo1G8fA0Vvk20YpdznUpnAfJqTRc3tt+V6f5ij/rqEPKOYLvVC7x8HXL22ITEs4rbvCXRiwzhOZNB4mzyKEMXa9mUxbqXJne0fGcuHC+tDMUogOj4FJbnzBy9Hq4TnRk34x6lc6vu5X781FDADspkRN98/qRc9YvrcaH1t3ajbjW7xg5HqZV1rnmQE0qgiv/y/uNLtHoNsakfQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	mbzDo3om+SZyHCjIFITjAtO6/p48UlnUcDqOicGEKs6522f/reP1+M35Ns92alDiNnUg39aGwbYGYCPTwvRSlCvgMl7pTwDkN4kHZcMdSDy1mqrhVA3DZyewFudqwbsE/xIqW5m62qPE2VXwtC6FjndAztlH0GIQYV3ZhqxtLgGyftULMSLECKh+vqjRbQvQIq5OuVuhY5ifYB8UDvfRtxoLerYsPFWQKcoa9HBbqCTg4rnq3l9KVUNKlMntrz5eKNTYFHI5NAVJlq2ktLkM6vFGsqGc2rx0y8aZsgG4yvJJRMZi37HV2dMvAQgraafhqr/M6lhGnaVJo59pBOt/0r32VQQCuOMEoMa75/WfgnEHq4izDB5lQaqxS5mPmuA9YGcJV6ApdAJDzu5Tyd+tO8MbvHyJjaCfiw/msDWRvFyvqtQUFQt5gocNxWopJA2q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:59.1841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c50dcf-bab6-47b9-5611-08de7c04260b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3361

zephyr-kernel-src-4.2.0.inc is an auto generated file and it shouldn't
be edited by hand. So move 0001-fix-unable-find-gen_kobject_list.py.patch
from zephyr-kernel-src-4.2.0.inc to zephyr-kernel-src.inc file and make
this being applied conditionally based on PREFERRED_VERSION_zephyr-kernel
only.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-kernel/zephyr-kernel-src-4.2.0.inc             | 1 -
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc    | 8 ++++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c-4.2.0.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-s=
rc-4.2.0.inc
index 9ec8c88..40bfb6c 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0=
.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src-4.2.0=
.inc
@@ -146,7 +146,6 @@ SRC_URI_ZEPHYR_ZCBOR ?=3D "git://github.com/zephyrproje=
ct-rtos/zcbor;protocol=3Dhttp
=20
 SRC_URI_PATCHES ?=3D "\
     file://0001-v4.2.0-x86-fix-efi-binary-generation-issue-in-cross-compil=
a.patch;patchdir=3Dzephyr \
-    file://0001-fix-unable-find-gen_kobject_list.py.patch;patchdir=3Dzephy=
r \
 "
=20
 SRC_URI =3D "\
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
index a1ee973..d89610f 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
@@ -12,6 +12,14 @@ FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
=20
 require recipes-kernel/zephyr-kernel/zephyr-kernel-src-${PREFERRED_VERSION=
_zephyr-kernel}.inc
=20
+# The patch to fix the issue of gen_kobject_list.py not being found is req=
uired
+# for Zephyr 4.2.0 and above, but it doesn't apply to Zephyr 4.1.0 and bel=
ow version,
+# so we conditionally add it to the SRC_URI based on the version of zephyr=
-kernel
+# being built.
+SRC_URI:append =3D "\
+    ${@'file://0001-fix-unable-find-gen_kobject_list.py.patch;patchdir=3Dz=
ephyr' if bb.utils.vercmp_string(d.getVar('PREFERRED_VERSION_zephyr-kernel'=
), '4.2.0') >=3D 0 else ''} \
+"
+
 # python3-jsonschema-native is required starting from Zephyr 4.3.0
 DEPENDS +=3D "\
     ${@'python3-jsonschema-native' if bb.utils.vercmp_string(d.getVar('PRE=
FERRED_VERSION_zephyr-kernel'), '4.3.0') >=3D 0 else ''} \
--=20
2.34.1


