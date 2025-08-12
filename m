Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF494CA0EEA
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.59])
 by mx.groups.io with SMTP id smtpd.web11.80887.1755020522795686043
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:42:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=gcdo8Rak;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.59, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fvm9/1xl/o+fdcPrqwbTSaYAO9m2VaEKkoj+ORjbeC7iPWfde7YgA8pRjwcURk+SnOC9xvaJatnH/f2SnCGdKGh6+fL89iPsiqWLIOi2pgZHhoqDz27L4I/GD3JEFhNndXlB2qeVX/DiZCguRO1hcEJTnSzQ6emhVbF1J1dqoQDhko2PDg2POnL0Bfz7NVBQ2QPJiaG36S9un5D2P8McvnweAdFNntoqYjtPKe3AqHJcxGH7SBPuYIXK6qjtfhO0Pp4GnSk2IKkjVLZSVo1Yx012nZV6I7djOt0rOw4fJuHI+4zn0O4XasA3AG4YpEzgqPEaLDCYSPReEOqCJJduLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AjUxczb+QlNl9El3k3t4lxY78l+yzDIYGk1Hme7d4Q=;
 b=P5YHofDCfStSfF9LUwQtAGwr3HpEavUfTt/gHZIjm2v8FyuMWmAWoXi0qs88263rlTmUEvC80k5Ld8/o8m8V40/MdgPS0z+tnXUM7lr6diOMM7II1VZljoRr/nmr9ugMnNlz4fIqRZvIyQfBUcIUna/xiafsJC1aWi0dCaLF+OTVhs86W1G+bfzP1eJrGSXmeKh8IGrEO4HRggI6yqvckSvLkmWenkEAZOerit972LJPMUUFUUzvAyICnbgrO7TTifGMg95gXtXTrztTClFS1zvGmRvqcZGouAywNNwfnBGaI+jpBvNFBUCRfJ65xmerDSut9GP966xTz7SmH8rdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AjUxczb+QlNl9El3k3t4lxY78l+yzDIYGk1Hme7d4Q=;
 b=gcdo8Rakyr4pbQ9yW+AIwAIEfiTtIxN6hlmw1XUV6PMkCFq9HtEH3fBFz3Z346cXM25IPQTginRyeGD1mD2YYLBerik6c+Bg7m/rcqNLG69CytNma8ylYJqxBt6Ut+yW2B8yHu2XG3dtopALKm+eqUx7wzKeT0O9gt+/iPGYzgo=
Received: from CH0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:610:75::23)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 12 Aug
 2025 17:41:56 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::f5) by CH0PR04CA0108.outlook.office365.com
 (2603:10b6:610:75::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 17:41:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:53 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 3/12] zephyr-kernel-src: Remove PREFERRED_VERSION_zephyr-kernel
Date: Tue, 12 Aug 2025 11:41:38 -0600
Message-ID: <20250812174147.130972-4-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7bf701-fa9a-410d-f327-08ddd9c78751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Qu65yStkzJgFjDd+cOtPlt69emkV33tIhfmD9jz6XpMc9LVBI6bgvHZzQN4Z?=
 =?us-ascii?Q?kBGZPgcBoQiz1gucJlwSGyAM3eqUpfMjEVStzxs5uirnXtxwbqg+NVdOuh6+?=
 =?us-ascii?Q?sNyD5jXUd8JO9RZk/NradyCDTlJEjfePL7S6OBRq4nuPoIFv+3HZcHySNJtn?=
 =?us-ascii?Q?FTzcAe4yLPws9jtpHJCQuhncNiuxl6qsY9RbvwIrcs8APxZJI640e31a2YpE?=
 =?us-ascii?Q?BYHhIR6QjD7kuPLMUR6X7U4cTKuRJpQLqIUkAUjz33qvRsUM9VLQ/K6fIBzG?=
 =?us-ascii?Q?54G/fse/UlDdmV8mp/yj0IoCeKDVS76tQ6YHd5hAmmm+OI201le8TT77CjHJ?=
 =?us-ascii?Q?160CclFuSRJ63fHTCVjXajFRx2+d89XQYiKAtCesIuXczxfQAz3durfGemei?=
 =?us-ascii?Q?frRqN1Ro1muxSsmJve0y2ThJsU2evJYvpphzMdR+TYLjMlsRRDR8wYJq4+r5?=
 =?us-ascii?Q?FN7Af++tWtFcB+xacfxY0BBSsuxTDA/u/brb4kEfaAuDgAcFcUJYdimsHtIU?=
 =?us-ascii?Q?u2qdpdGT2E/iZL9/0P+5vwIwHIFs2m5i1Cclp4X8gr9mxv9qm9IfiBgTfhqW?=
 =?us-ascii?Q?acgETXjlGIJD+Uce27MTxJTly1Y8XXmzkLYthFSygw4rOfLZfT/hTCMvVsHv?=
 =?us-ascii?Q?T1/EdRDnOp++Qpk+wgG4let0dG7yw+9rBeoG++5UG/ljsfalrYLrJuHvJmvo?=
 =?us-ascii?Q?7CG3FBpWUN0Hqc81gl4B7niZgTZYCQseSfR1G3y8guCyEYLu0o4EfvHILWnr?=
 =?us-ascii?Q?aGzqAh/1izVKFaf1918MzLIvM5LSlx6NJZ2ihn6ro8xds5ueGJoy75nD9zKW?=
 =?us-ascii?Q?/LBjmfn4u43xewU5WCg9BrtVDHThDSavqn7zjPd1WAciJtcfMfhbPx4ZnGE5?=
 =?us-ascii?Q?vRUivIbVJski+/0xLjJjplKWmjKChuzLpRUhxWeBpyfadIXLQ1tRftFa31PY?=
 =?us-ascii?Q?UfSK6Gtn1czdA8aRSVnEVVFb2ylrJIEzTJkmAWqudgn6ID8MAFPzfelQvGxV?=
 =?us-ascii?Q?PrA9g2fhUCORoHou0KqsN03M74VmusyQ/JGM5DIdBKazdaOYz+5/aYj9C5Ss?=
 =?us-ascii?Q?kmDni12y0hIkHILuad7Phnv6nTYUnAzUizGXa4QOt9WmzxwFqtSS3VLRvBn0?=
 =?us-ascii?Q?LhPh+VQ6qI48AcMUMFCyrIepTB6Smt5rmutPLkV1XvcvsrF2C8N7torn6y5o?=
 =?us-ascii?Q?Lq3KTzr2eo0gB/lX2Ki9gXknKIqz72KuNELvEgIbv4VmspvK4E2WLPNtaYJP?=
 =?us-ascii?Q?xyG/xer42pkhXlfzrqaxoH2wN7PVShevuAl8f6ZS60yGxhueVtFs1fw/VC7h?=
 =?us-ascii?Q?rfIcwHIhZ2rGnBu2eyyVZgVavZwB+Gp2gB0bPW+GcqvxmDDAYGfhfxKdMjx9?=
 =?us-ascii?Q?PuhuVeIZ8KfCsU1j5oVeCjzshMecBM5gdiWNoRv/YSCnczlKUbwwQxsvzshE?=
 =?us-ascii?Q?pM0L8ZKFMHsLcbNAmQLsI8Un5CGsugDDwN6PZSjz4NlnEf3fO1HRSVwR+B5R?=
 =?us-ascii?Q?/P6eq6e12OrsGdjJpPD5JfW+2M6AztrRrNdQ?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:54.7918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7bf701-fa9a-410d-f327-08ddd9c78751
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1969

Remove PREFERRED_VERSION_zephyr-kernel from zephyr-kernel-src.inc
as this variable should be in global configuration file and override
from local.conf file.

Set default stable PREFERRED_VERSION for kernel and sdk in layer.conf
file.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/conf/layer.conf                              | 4 ++++
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc        | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-core/conf/layer.conf b/meta-zephyr-core/conf/layer=
.conf
index e1bb263..e355b3f 100644
--- a/meta-zephyr-core/conf/layer.conf
+++ b/meta-zephyr-core/conf/layer.conf
@@ -20,3 +20,7 @@ LAYERSERIES_COMPAT_zephyrcore =3D "kirkstone scarthgap"
 PYTHON3_NATIVE_SITEPACKAGES_DIR =3D "${libdir_native}/${PYTHON3_DIR}/site-=
packages"
=20
 addpylib ${LAYERDIR}/lib oeqa
+
+# Default to a stable version
+PREFERRED_VERSION_zephyr-kernel ??=3D "3.6.0"
+PREFERRED_VERSION_zephyr-sdk ??=3D "0.16.9"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
index 0b9baac..6b2b697 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
@@ -11,6 +11,4 @@ inherit cmake
 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
 S =3D "${WORKDIR}/git"
=20
-# Default to a stable version
-PREFERRED_VERSION_zephyr-kernel ??=3D "3.6.0"
 require recipes-kernel/zephyr-kernel/zephyr-kernel-src-${PREFERRED_VERSION=
_zephyr-kernel}.inc
--=20
2.34.1


