Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D15CA0EE4
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:46:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.53])
 by mx.groups.io with SMTP id smtpd.web11.57124.1754941611749061991
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:46:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=URUTs/G/;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.93.53, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUumi065g5yzZ0VxfqExvUVU+IyGWK9U3FlXFnbUqar66NOV2YceR0uGZO3H89kCLYBwIXsddBMVpwjnFcjZ4L0WuzAkwlXohXyP7D57BMLNLvDDIhJH2XKsSEiXweSmIwlyCU66h6xpaaaIVlNMxxOGtDoUeTvlZIw77L5G/SHerZRtSVjSrjHXbA15v+twXtF0qeGhD6ePst5akDIeNOVZGn1WUcF8aSukKpYPZoMAASFvZkhPAkhAtfk7TQVdYesOgxk+UWZ7NpJmsvtZTvLY0eqBVOqcgdXJDnusdqSPUCVtZ1tBLsD95oZ+Ol90fuymg0mVOkxROBWjKdyxVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=nrXYPhukwRl7IPtAuLzKUKPSNFYylzU65lvCv/tNvRYCMfojCKZBeTBjlGQr6lFFpKex8mKMsGZ8EtnfBqLjQrTFhADwYNR+4RFUMqwJXo6jo8Xi+sknbJ91EEC/e2J4U3D9PNVezj3rQ+u2yTinaP+g+PBEbivhEcfLMSBpvNlYGJ3IjerhXvdCad7wOJBEvH4paQlQUWkeSqu9sl8K3HHBTd9Ed0JtLnCStM11WdKPyUe425oYRsCg3z8+peDpEPVDUxITBjJVzUttIdyH/XArIG+kwjXrYzMwOot998XljuRu8UmZqXOySFh3YCzbCV8ePQsi7LrvB1xzyxyFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=URUTs/G/hpaYqyGWUVY+3kbigt2Wr7dL04/qkD5bJZygldPoAcEApyfqf3qVSw7tV5JlG9xW+8US7wHL73DI+/a/gh3/gJcOkCVpz1/89pI4nQZHtDxY8KOuLinacDfgD3Rs3weNuSaTGpxcAoF0S2av/aTUg0LT2pFuDzqQ4sE=
Received: from CH2PR17CA0005.namprd17.prod.outlook.com (2603:10b6:610:53::15)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 19:46:49 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::6a) by CH2PR17CA0005.outlook.office365.com
 (2603:10b6:610:53::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 19:46:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:48 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:47 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:47 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 2/13] zephyr-sdk: Add new inc file and update to 0.16.9 version
Date: Mon, 11 Aug 2025 13:46:35 -0600
Message-ID: <20250811194646.3408854-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: b652d069-fbcd-4945-5dbb-08ddd90fcfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FrUmFFTlflK2wKRv2tiGeuGCv7lgqHGg74bzT70/METhTQ7PRlpdK1SwNCgJ?=
 =?us-ascii?Q?jQdPq/8JV0NuhlLya3pBObTHG2gN+rUXTF+xzHLZFgFAIpiNw818iyr/7VfI?=
 =?us-ascii?Q?ToaDHbCb85B4jJirEqItxBXJgN/f9X4ef2A9FVebHXZj1q7bHYqtxFQt58/V?=
 =?us-ascii?Q?yOzV8ALNunJcIv+RcfLxHB1AYBg/jEZPuQdQcmngonzBLo8RyxJIYFW2LY7+?=
 =?us-ascii?Q?7W0vsdO8tdrM9OursnuFipUEoFbt/QwY+dXwMW4EJJmJnMHmXzxZG50/JxQM?=
 =?us-ascii?Q?s1ZEV1SvQmwUVwLEjMyLOYBpyTFeziLajJTPWMF9+78DhJXj8b7UlQ5NThjN?=
 =?us-ascii?Q?GBcjS9OklZsa5M2jaGREJyxO/zvtowPT7n9PqY4PLJ1FlGnIjb2miefdIFMV?=
 =?us-ascii?Q?aB12Wi/ZB/Z+X4v+w6zOrs9U4yXCi3hk084BL/F/wxbdZ9w5hrPxXtJajnU1?=
 =?us-ascii?Q?wPFeZCRKdqyQW+/RZc7BE2VyhgDbZQYv5IY3FivGL3CAwumMJTY+v+e/LHJP?=
 =?us-ascii?Q?3ufYfz6u8raZz9mwPZzAdUze+hJKC9wkX6iyuUSZbqyRzxSc4PX4zET9xMn7?=
 =?us-ascii?Q?4LmmJHlajcv9mbpFSf9xt3UG+/a8RvWIoxlYoDYl00etecor02TabVO23FAn?=
 =?us-ascii?Q?vkeS2TOpaTYO5LqIh4RJYiKQAWt5VaCSiF6ZD3B/Z//WuvEb8yA9gHhK+m2t?=
 =?us-ascii?Q?tA4wl5w62lcrVgaX6I8Bh4Uf/DeqF8N8ZgSMyLfs7TEN+1lg/zyn5hqzfncg?=
 =?us-ascii?Q?6rYN7H0zmtCLxra5W3MqS4e6GMlBhJFCgb4Mbk33HQyw9oJOEpN8/h7IzQb1?=
 =?us-ascii?Q?9nDmTN+ZiymZ6XgFTwhnz8L8yawZ1mv1hAkLe8E/ichHg2tZnR3olldOEQla?=
 =?us-ascii?Q?ReG3JZNpTLbpoGQO/no0UCa42uh5LvXMny44u1CauPyR8pqNPqAzhnrwjL5t?=
 =?us-ascii?Q?1tjOYj6UapXRnYjN6P095j3sTYqokaPZWP7lyEkGA3PYYQxl7fpHNBA0P8uN?=
 =?us-ascii?Q?WA7SGZ8Wwmi04eOtiMyS5YY0RDL/wKdHeerKsJAhMjIKxB5nw46wwGDheF/V?=
 =?us-ascii?Q?Ok1n2Z6lfQWHJnmWb1rTBDdhO7+78186ntlEe4cshbLKz3EEESvZR75wdz5R?=
 =?us-ascii?Q?Tyu2hgyQHND6s3Glbahft+Ak5nD4SD0r+Q/nX9WvmTPGQz1GBvzy5Kie+tSc?=
 =?us-ascii?Q?N7f0d/D/vFYwo04yse4HCkFYw1WyQqOoVp304Cd5EYeRt+0UxUi2NE8YVpqc?=
 =?us-ascii?Q?xl6I62QHUwNfHTXJUkhAOqC3t4mOkIZ9+widaJBDuqq3nc5CVJazsLzf1wJi?=
 =?us-ascii?Q?763CQ+AFacEN3XqTKtY6gxqXvcBY1tAoanzRwiDGdrKLnywcAT61X40sHXyw?=
 =?us-ascii?Q?bENGDnQHwMcqpCy9DVUj5gbfsZPkZiLckqFe0Oo/5DMx0zYQhVMCvfhEY13J?=
 =?us-ascii?Q?oMTQ/Pbrnjb2nauEkqGr87iiWkiCarj/0nItl5CfcZm28pWFVvtrXJizAugr?=
 =?us-ascii?Q?ZAFQ28rGgPqj/AJgocyeXCOHzkjk9VSwy3SI?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:48.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b652d069-fbcd-4945-5dbb-08ddd90fcfbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:46:58 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1945

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


