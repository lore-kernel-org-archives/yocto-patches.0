Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06EACA0EEE
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.85])
 by mx.groups.io with SMTP id smtpd.web11.4403.1755230101973740498
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:55:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=TGrF6kpp;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.85, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1YaiYKDNCxNK832fLjWmOSE5sHJgn7oi5+lBDbCNyR/RWGsuRzwlpEYtcSBogJyslyuM4H2rzsuTWjIXJ3KhNm3f5vrhRXM7HMY/Dwl/muc7lrI5ZFesw8tOJUtK/nJecoxyJAv2/nL6JwtOHBSuJH9+nAnWFiRd4oziYiuFcPZTXXNjjdO/6aAUvCOfGv2JlIzGKjgFopw4taOceQCpe0SPJGr5oFzmIXetSH09w1tpjnCBJtmPK6ny7/3WE3MiWRYFYvYKeSbbLWSyoCxEjDeH301prb5pQFnq8FiLUqYO2yaIRoMHJMyoyr3niUnNT4DG4vDy5PoYxvZvA/aSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=iaxHzy5AQCOUx0Xz6lXJWO7pYkm0Z0i4ZRl/9/xa1vYjHCywIqlZxdVrujKdppNbjWbW3jiE0alBzLxiQh1Z+Iw9GDAIbaBD6QUNl0stWvQxnNz4zu1XN8oiesUOVYjRH0PI2ujbCV6hWNIVUSgmg6lTtwLcrUSz/roBCQOq/zCRjP2wvEDk6vjOU2WyUu3YX7m+pd0OLhmv47XRDBajPmKjjcf1FwX2MAHgBYzvwSXBKK/LDjOo0UlD/oWI1yejHEPQNGWFTIONRhEyRikcuaE9ki7tN7pDUgqcNoOQKX+zdTvvYLHvUnpzjsBa/yi4gpBDmQ64rnqWm9LECLfm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=TGrF6kppry0QqS5NLeGo2ZgXdnBHQ0rsV4sekyiymCQwiQkfATeGpDwYFQfSsn9OCpcDV5i0ifY9MMHFj+u+B1bm76Gyqs/wLf3ykGnI6mQkH6I4e+puhlb6DaDhc/U42Qn2pDBANmYdsTVhK54lU6K0mRjsGnOWkkxwMM40y4g=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 03:54:57 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::86) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 14 Aug
 2025 20:54:52 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:52 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 06/12] classes: Move classes to match bbclass scope functionality
Date: Thu, 14 Aug 2025 21:54:43 -0600
Message-ID: <20250815035449.2816001-7-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1488e4-bf80-4aae-fadf-08dddbaf8028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PkOxLtg6OuCXrZB3I33tPDX+oPKyNMOfQCqa0WRkdgo0iQUUtO7mV3VMJyy8?=
 =?us-ascii?Q?KABHAW6nE3MTVpeF8HZC2JQAQNzZw6uL3tlj6vkO5FSb6IUMktE0lzzuzMqz?=
 =?us-ascii?Q?CgF2Oc37UzGT7rxa+1Iqih8jXjDlFh2pkoG43qkr80n7PIXlZfLUQjvTe0rh?=
 =?us-ascii?Q?+hMff1ymWpdQ/m/lucMxbMPDkNygW/cannmv5hC1ZKOsdkkDs9Msjwxh7mL/?=
 =?us-ascii?Q?h1eZiazxucNKhfAAtKDWFWl9GhYw+KyTtlhgVz+5EE5XjgT2EX6WyImdnyU9?=
 =?us-ascii?Q?vM2NXk51p9Bga1tbo5GxX0ggF4MWIK4xM5MDZcujUuAqKminK/EI3nhGKAfy?=
 =?us-ascii?Q?xtBX3v41o707C5V7qiDR4Zfw+FGOz5i9diYHc63XK4N6++mJfRcsi/4Tkv3N?=
 =?us-ascii?Q?onYMSHKIFxDr9/NqcbQB4SbEKkPhW6FEmM9InjkzepQTitckyBlWraU9lFjR?=
 =?us-ascii?Q?fHumO0W12cTaemKzAb5Obk0P1FIYgW10AmC/PlBqJTtGDiaaUDQZLfhuDVdv?=
 =?us-ascii?Q?cN710c0PGs2hnKuBxWmvodK8KcUQGDtXAKcza6RBdiYI9/DpKfE0ifzSqdYR?=
 =?us-ascii?Q?9Xb4sdpCSX874taV7r7bs2rUg3sS7Bh+VP9QkCtE+apYepzEoCj2UaLKwgVh?=
 =?us-ascii?Q?cmjHU+J9Wq8kjRlXntXF2o4vAJ+12SpIBc1Dr3iK2CanRu6/UUi1QE/jRzMM?=
 =?us-ascii?Q?U1Nw5cGYG+LBGLRjcBpFrddefKOZkMtcCL+mlh2UzkZLeDw26fw7HeRT77tu?=
 =?us-ascii?Q?/k8VUdplmuUKFOLCibR76apSj9qcWHa6M8Gi4tLasONIahwlXgt+Jgn7iwo/?=
 =?us-ascii?Q?l1CFwXGks42Gw9G2DRaIC1GkFD9evbO9jzlrBmlgqmwwQCgFLXIeBJr2IpKB?=
 =?us-ascii?Q?SD1Pf5zwNNe6mtTNL120txfcoG8RAtI5F3eIfMZOSLKhREe2bFDn4hExvYjx?=
 =?us-ascii?Q?MUP4OgAjRcy6+IbjJ2o4zZsL6YXXc/wDP6ajjSiw8cr6e8KxCowGtKe9bcU+?=
 =?us-ascii?Q?1t+AtfvpmuKP+nUlbNsGrP6PzgiBSOJtb63b+6PyBrSu8QlC9Tl2AG8hsoZi?=
 =?us-ascii?Q?AykEhBQPmgBalpH1lxHS53uSp9F814CDNhmcK1/E0U57jEjm054I1hACmn4s?=
 =?us-ascii?Q?m/1MJ4zAcqVE8OeBtpnPQPnMdZY8UYg8UbomfBxpKdkRQpYgQA9tJRIRX5sI?=
 =?us-ascii?Q?Rhas58wR1kqy5i7HI4xCPTf2Xaq+cn8MIzk0vN+fasKn7w5h8C8dfCG6Utg0?=
 =?us-ascii?Q?jcn9xb6GonzMhva7iM96r/AmZWEYPQx/KadiblrQRLrqqAhInzkpIFweV/J7?=
 =?us-ascii?Q?DJ01jnmn+7nMs7neL5VGzDdUXpT9uVS7qdixZtp5XeG2zHXr7mh7Oa2I/xcn?=
 =?us-ascii?Q?Opw4o2fzEaYbL6ww0aWCo1QOP91XTSuAb6J9XqkGG+U4m65ZNfqmcGgenOnG?=
 =?us-ascii?Q?/0ud5JhfnzhlQtU7ECqgSjk55SwJsAVlVUoS+eLxHQt657B4zNgWPdHFVxl0?=
 =?us-ascii?Q?6F9IY1KJPVr9h5/V59+9LT81Mk/SxPUCr2kv?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:57.1526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1488e4-bf80-4aae-fadf-08dddbaf8028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1998

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


