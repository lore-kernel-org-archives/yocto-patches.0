Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B3C88CB9
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 14:59:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.73])
 by mx.groups.io with SMTP id smtpd.web11.49944.1754924390842086166
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 07:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=gmAXQYXX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.73, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pecGLBqj65W/GFapzSewWXapuiZHB0kEgHapP9cIy9mEjXbVWk7wg/eNEnRkb3on6Hp6Ur3IrEfPL8KeGfEydfHl8QK3bm13533zie7sABbn1Z41u6nGvGTXVMsEOoKmJrCgYinTKrECZFlQyH0NYJwwtTw4kMPYlH72qvmU/h6QrLXQHyTpPGlv5HCyq4NWCy1CTnNC3E+lM2CDUb3tDc3B2OpU296qcZ3Omfv6NlLcNgH+tGdo4zFjH10tockPzeytZ8urOYVf3fX+h6C54ihwkXg10IEn+8pdW9XWbX8bZtv+MI0bN/52F1/ve2f+J3AJEipXeFyTX2Iv+5c6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=DTFpB5XcQa/BXu9tjPS2QmpY1LjKkNVSlIIeO4Tx/uUL4agVZ0m2na7Y4VqqPIGGtQF+lmpsTWA9lo3d7YIfPsGzNtU5BLrrgWZEUzkppykB12wzrcK7lZrHjlZL65hdCZjvOTmZZfdltlWsxi7r4XrwV/PKMgxeHRNfuHZAUydgDEjRjl3Gdcg0iRVjSyvC47S8P9pFAkDN8idiBkUbwHLGcJruDh0oPiwqDK65US0EpXGGPFJX7j/Yb1BfLgBjZjglz4REHJu6Fqahu3HBzcQ7UFikC2b9NXWoICqRFbFePqXIuabjJL1kt31dXtw7ouoNwFfqbdrSwnM9Csc7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=gmAXQYXXuRh1diAVCklISpSA2JEnOMRNU32d4jeOFY0f2jDdwjd9BCoCw+0kn90FRVXWxFCkc6Ultt+owHJG2ZAl88HO5nkcJgGEhbJx82FhRDm93c6EDKwoP4wd/8H9i0O4DFas0VeYdQieIRMwxknzyCKuck/5K2f8KXrAhlk=
Received: from BLAPR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:36e::13)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 14:59:48 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::40) by BLAPR05CA0018.outlook.office365.com
 (2603:10b6:208:36e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:47 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:46 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 2/13] zephyr-sdk: Add new inc file and update to 0.16.9 version
Date: Mon, 11 Aug 2025 08:59:30 -0600
Message-ID: <20250811145941.2553838-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
References: <20250811145941.2553838-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 4691ba05-dc7b-42a0-ecfe-08ddd8e7b74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0tygdldOoQ5xXNe900JZB2T7reepN235uu2hShd6yu0DCrSqf4aNe384qAZ7?=
 =?us-ascii?Q?LbXvSHdOR1U2j9pJ4qZCAZYq5XOPSf6KeoCAFfNKrjuA9nB+3eqVMWrRxXkR?=
 =?us-ascii?Q?NS9TVe+boVROwTq2sXovgo6KSLqr4Loj1OEH/B07x2wPU/6yS+9GJb8gbpzw?=
 =?us-ascii?Q?MTCHL6x4iR0bhS1ttsoO0ywvTXxca/dJATx2KbUQnhG75TwBHUpjBAGul/nS?=
 =?us-ascii?Q?C3lLeydwWDKMJQjKXKdqWTv6JCnq97UHTKvUCndpejqrvcsn2FYjAOtktMcA?=
 =?us-ascii?Q?iXacQDWEGHmmOdcgPJno55wFqXV3RRHklj9GCivnxOoQvQXnpaIVm3eQbASU?=
 =?us-ascii?Q?35e8nFXfvOCDcF5QxHtqliCWk4SU5gZdkoslApBGwNTTub5Z5i2xxEtI0A8d?=
 =?us-ascii?Q?y9jyrNwg1DCVIYQS4xqIW2DM0chocHjgsmwOy5FEcz4Rj3I+++rEBFMA5OVi?=
 =?us-ascii?Q?y6sCI4KioqqB35Sf4yXXa/nazWn8IAC+vC1XXfell16fQndT8Hby7bluj1ZD?=
 =?us-ascii?Q?9PFTdLIyQYvw8jbiBkBiZMwmVS0i0BB9Xih5qeSqbu+7T1x56nK+OvXIOhjg?=
 =?us-ascii?Q?m07h3djZUTZSoKmBScTDP7U+x222Y4vxB9hmZqG+AtKSSHV2rOuq46Yb5I8K?=
 =?us-ascii?Q?D/I1wBQHUgY9beShhiWOrGWCb795al5Rju/RvM7fQ4Dklddq7zWZogOu4cGC?=
 =?us-ascii?Q?/yKj/4Yl6kGVFtsEwEcReVqbrOSD81tnfNXRGljuhQ0+cUszV31kBOGJ6xki?=
 =?us-ascii?Q?cvNxuBoa/nW0Mog+EeKGtNzvuV3j82ikzf9po91fULUUSELlclcMCwoxcaH6?=
 =?us-ascii?Q?tmBd4dUWctUKe4pjagu+lBKlp5ogVxk6aGFdRe1rhgFwoeqohcUYuxx3XiV5?=
 =?us-ascii?Q?tgpogBHyGlwKZPTZvLDvuoavI9g7n5pTwgJCbfbLMYZly0rH3PEf8tKLK44x?=
 =?us-ascii?Q?xLFEsv86bahZGjPN/PGlIlpdwG2lITo68SWbyNRAqxmSDcMTtsWVB+TtVe4R?=
 =?us-ascii?Q?wn6paqH/TEXwe4hMNthuMRdt/opVzMoxxuiPIAFw4LC7w9xEJFZjxlChusXY?=
 =?us-ascii?Q?Rmy0xK2Cw+q+iEeNgD/wA1Gajj8uw5pg/TR/CI3S/UVM2QO14E5kd6JuiRCC?=
 =?us-ascii?Q?TADFG2U3NKmeX0dZBpu1XW4CC3OdP6DhX7Hdh55tsjgrWe7vuZGHFhoKe6R5?=
 =?us-ascii?Q?lkx5MlzM4MIrG/e4mqBnlSmk9F8UVaCdnRzKjew8CNJZ5wCKdxJ+WWzbFC39?=
 =?us-ascii?Q?Uc5BGxwmZ6UZiVT2AMyWf+rxzh/6ZCc1USEIVVKO2KQeN4Vi8sUFX30NebZB?=
 =?us-ascii?Q?Kpyfu/KgGi74UWHAnuLkzbr2FYht1IQ3NX4qy8eL8/qurEaneEsnvsbRf2Ja?=
 =?us-ascii?Q?eNB5AFsPc5p/wlq34KvFuGTl0SfQC8lB0sFer3qQIelGRtyzXsQYcUzLbohd?=
 =?us-ascii?Q?bgeyLIVrDJIc2SKO4t+zldL3FO/07yvaqQ3tKnLk/rnwkgzitDY3FZEsKu1P?=
 =?us-ascii?Q?/Gw3Hqt/w13z1B1VdK5YFrKId6USSuqEEOVU?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:48.0356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4691ba05-dc7b-42a0-ecfe-08ddd8e7b74c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 14:59:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1930

Add zephyr-sdk.inc file and move all the common sdk implementation
zephyr-sdk.inc file to support multiple version of sdk.

Also update sdk to 0.16.9 version.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-sdk/{zephyr-sdk_0.16.5-1.bb =3D> zephyr-sdk.inc}     | 3 ---
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb          | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)
 rename meta-zephyr-core/recipes-devtools/zephyr-sdk/{zephyr-sdk_0.16.5-1.b=
b =3D> zephyr-sdk.inc} (83%)
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk=
_0.16.9.bb

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5=
-1.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
similarity index 83%
rename from meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-=
1.bb
rename to meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
index 0b608bc..ee2e63b 100644
--- a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.5-1.bb
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk.inc
@@ -14,9 +14,6 @@ SDK_ARCHIVE =3D "zephyr-sdk-${PV}_linux-${BUILD_ARCH}.tar=
.xz"
 SDK_NAME =3D "${BUILD_ARCH}"
 SRC_URI =3D "https://github.com/zephyrproject-rtos/sdk-ng/releases/downloa=
d/v${PV}/${SDK_ARCHIVE};subdir=3D${S};name=3D${SDK_NAME}"
=20
-SRC_URI[x86_64.sha256sum] =3D "01f942146d2fc6d6afd5afe6f4b5c315525d2c937c7=
e613d3312b0992b33bc68"
-SRC_URI[aarch64.sha256sum] =3D "1749b6891a6a6e70b013d8b31ff067c5a94891f651=
985a6da9a20367b2deb6c7"
-
 do_configure[noexec] =3D "1"
 do_compile[noexec] =3D "1"
=20
diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9=
.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
new file mode 100644
index 0000000..ba20341
--- /dev/null
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
@@ -0,0 +1,4 @@
+require zephyr-sdk.inc
+
+SRC_URI[x86_64.sha256sum] =3D "9b4b96f8df594801a84fce1aa112a84cdfcd430efc2=
a74229907b6421fb859a8"
+SRC_URI[aarch64.sha256sum] =3D "a8c1731ad602553304e539a7ade9cdb34caabc1850=
d581585cbba0372a7493b2"
--=20
2.34.1


