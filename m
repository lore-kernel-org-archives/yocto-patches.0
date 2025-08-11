Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F5C88CB9
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 15:00:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.83])
 by mx.groups.io with SMTP id smtpd.web10.50432.1754924398205155934
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 08:00:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=nJwsQhLR;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.237.83, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD8i9e6mBwjW6oirOXLKzjBn+cCW43Y8J54wStiulW03amjd8hQz3KvTCp+PH8fn7PCtrWMjF/BQ+rJqny79L2y+Ps10iC3R3/Gl8SF986ECaGl0/RUJEAAzeX4/wQHuHtBNIs4QCQzIS605/t/weQ3pv668FMLxoLi30dwBwcsEgGFkqFcOt+lkmcr8Y4Y9OUQ0e0llDPiaAU+Nv3iD+t9ErFmBwGFAVrbkaJq8wcw2WOTf7U/0nX0HVdob5O02YGdmuzL6pE3xxBg8afWO4NzzFeuNdSjeMoBjQxJLBzHWm0ITXeMd4dNPxZskAZ8Fu0qBd4v80vJZcN71cjKJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=Byhqd3cl2n/KJjJTvObpJxTN6VcOat3XhZL7pymF4L3OLhCS2ojaRPuipAM4iGRQDxSNWziMZNChFf8+rcasXybb7TPWlIjCoKOztL4K1JtRDdRjjmtT1sx4xdlAlO400hXH8Is3E7i5++xiTEhfR1rbfnXaQU3+drxhqb7Ey81OTVJb2jfG4DN5Bynz1sja24Y1bX5AhaVQLMuBmWAiJKBHXYgYEC6BwTJUzkweqoWBY0er+MGudZBC8xij/+Sl2SwCbQCrQGCSxDo+REF4iDHludmObQusGqHOWvvxpsUyQTam3EwiPRTt5Ba0I9oHx8jMo8xYCjhpqw4iQraq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=nJwsQhLRz5fkEcj7XF0REFpzq9khwHDJS8sMA1faLI89DmHUZAfqMwfww8CDtaVJDavln5yHLru+TfE0/0BEUS0K5QJ8iQadbvji4OUoDmOTHkVRwxWofHepb5WSy2BzeLxvg0a1OvtrEoNecydP/mGUTnjPj4ZCj9cAHn5tXbE=
Received: from BL1PR13CA0250.namprd13.prod.outlook.com (2603:10b6:208:2ba::15)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 11 Aug
 2025 14:59:52 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::7c) by BL1PR13CA0250.outlook.office365.com
 (2603:10b6:208:2ba::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Mon,
 11 Aug 2025 14:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 14:59:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 09:59:48 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 09:59:48 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v3 6/13] classes: Move classes to match bbclass scope functionality
Date: Mon, 11 Aug 2025 08:59:34 -0600
Message-ID: <20250811145941.2553838-7-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: 622ff85e-dfa9-4d69-a5e2-08ddd8e7b986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vZn+9AyLaMGzFNmqsMcji4h1MFjg69XMGmD8B5E/ASfq/DKO5gKk0qGB0gUz?=
 =?us-ascii?Q?HRbukMA25Ozd9jpCyE7sSfKAmN63BzyXuMfR5MxE4qCD+XBJgoK3Ly1M+jDm?=
 =?us-ascii?Q?PW006d5QXN/2MHqW+hNjrHTHnzlrXyWW4nXwGQl9dWNNl6qO5lZhKr6DYqdB?=
 =?us-ascii?Q?8047KSeh0caHLY4SuPWMkgpzUtmQ8MmsfvV2aTokNJUhxALit+3JowpN3gnY?=
 =?us-ascii?Q?zVHtgI1BGMHX5lk46KW53Ugp56jDdh6wgJgx17ZEK4s35PhZN9NAeVOtJHz0?=
 =?us-ascii?Q?SZmjmX/Tu87LbXAYAzCgGrZKwvX7V2o8PtYv5DJ6iSyi1n1B/CEW8lXvsivG?=
 =?us-ascii?Q?QFTQd7/9gd201JaJTohKpdZn5xz/kLmUHG/7xereGhx6U3sp1jTRH+zJSmmL?=
 =?us-ascii?Q?NwB88I2tjVRESgkzpQy/qX9ppZamZH+51aXuzdrDnQbli93pVTcmpCZEjngn?=
 =?us-ascii?Q?D4xRABpKCfJeApbY15fKLyI7oNbDGvuDycRbv+gaLJ4Rt3Z/EJIXgWMxzYKJ?=
 =?us-ascii?Q?pWJfQ2wGY6BSIlz+uAPtp4NHG7vVfJ66AGRHaZyChx1z1K0MZ4+0prk5bZjZ?=
 =?us-ascii?Q?W3MbZ6Q3x4SceQ6pyZ1yT5B4eB5IuuF2+NAkLE2BILKEBIkkHI7+5NtAxf4Y?=
 =?us-ascii?Q?rFEa1CD0RGHjRNk6SI+PiTM7oqJBrbqWsR41A1ZPA0p8zvDP57FiUuRwEggL?=
 =?us-ascii?Q?CKykfnnmUKn+ZMU52FwIqYCGPOt8TZGlhQK7tow6lMElimKro73udpCTs9qv?=
 =?us-ascii?Q?yQy3YsZVm+bULHNl3oH7pUIWW997oMiK4iKgwUkrA15LZwxP6mFDCWG8s7UL?=
 =?us-ascii?Q?yiLZ/5wIk82fjX+CHQbIvTaS3QRjZRRVoT9pjcbIh5OflQ/EsxXbYzbDSrxL?=
 =?us-ascii?Q?8nmzbe4v2QJA8KeNfWkNMJkBAO5B7nEVfgkB8m69V28k+vVBWJ4Vk4i63DNK?=
 =?us-ascii?Q?3NOyybUJiDp9coW0vlhvezLRc0ovFbUEUg+bHX/JpyQYiJvjG4DYyjc5iUKp?=
 =?us-ascii?Q?9RPbjhpiHsB8jk1uI0kdDLwolp5ltnsc9aKpeWcf/aXmQdeLnKcORNGuJC+r?=
 =?us-ascii?Q?L8mqg7VXwhs7M/41IKOWaOKEYofSyjr9amMKK/J0WZxxIg3TyY3t/fqW5IRS?=
 =?us-ascii?Q?EpKgSN4fjVHFLmSShpkQReqalc1c9yT2uHRUeysk6drXjxcUYAc3/72Nd8ET?=
 =?us-ascii?Q?6EF3u6IqIzrCvi1oL0ChqrYQsbYbW03pi+cwGXKNVA5r/XF93e0iDQ0KI5G9?=
 =?us-ascii?Q?qdbTrfvo++jLFa2dSBCu3G5iPBma5kxMQWNHSy3MBAez7yeYSfzY10E+aBGA?=
 =?us-ascii?Q?Wl4nlFr/rde05dnb8SjZEqCGNqn1iae5+YnreJsGwWD59OtcuaG518949Seg?=
 =?us-ascii?Q?wHwGpeCYyFRK3XwM5Kh0YbBMI4O6YGxtfZft9QttMpYp2uAtPaKlTyHT1KwD?=
 =?us-ascii?Q?/QqkxP6+i79UuJH9lIKH0lV4Uz1RX/XVCzrPOIQY/4Fj6kfa9rOk3p7KGsJJ?=
 =?us-ascii?Q?I4hI1RDwUA8mDlo7j8Y9LHeHfTpmRXpPvYrv?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 14:59:51.7686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622ff85e-dfa9-4d69-a5e2-08ddd8e7b986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 15:00:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1942

Move classes to classes-recipe as appropriate to match bbclass
scope functionality.

zephyr.bbclass, zephyr-qemuboot.bbclass, zephyrtest.bbclass are
inherited by recipes hence move to classes-recipe.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../{classes =3D> classes-recipe}/zephyr-qemuboot.bbclass           | 0
 meta-zephyr-core/{classes =3D> classes-recipe}/zephyr.bbclass       | 0
 meta-zephyr-core/{classes =3D> classes-recipe}/zephyrtest.bbclass   | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyr-qemuboot.bbcl=
ass (100%)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyr.bbclass (100%=
)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyrtest.bbclass (=
100%)

diff --git a/meta-zephyr-core/classes/zephyr-qemuboot.bbclass b/meta-zephyr=
-core/classes-recipe/zephyr-qemuboot.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyr-qemuboot.bbclass
rename to meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
diff --git a/meta-zephyr-core/classes/zephyr.bbclass b/meta-zephyr-core/cla=
sses-recipe/zephyr.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyr.bbclass
rename to meta-zephyr-core/classes-recipe/zephyr.bbclass
diff --git a/meta-zephyr-core/classes/zephyrtest.bbclass b/meta-zephyr-core=
/classes-recipe/zephyrtest.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyrtest.bbclass
rename to meta-zephyr-core/classes-recipe/zephyrtest.bbclass
--=20
2.34.1


