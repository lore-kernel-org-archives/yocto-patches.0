Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4CACA0EE0
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (NAM12-MW2-obe.outbound.protection.outlook.com [40.107.244.50])
 by mx.groups.io with SMTP id smtpd.web10.81596.1755020522852231666
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=HJrkaMNu;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.244.50, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwD6DYDmbfSQMRrtWwu9IZZ1InSVzFuVaBiASWXMVY+i8xSoTM+eAFvh1JCzMBVo8+txs3qXf9hccUqWkQSKktoKrgBzWPNeip5evBZ8cHjwlWzEi8fMLmlw5DVWzYLfJakt/fvZDSJ7YCyyN/v4lRys/Y1ZSnkU763scgBb1ckqkT5b9QJzFXWYY9xoTuoM6DdREEqfy2fChCDhWF3IXPpad8pflfAHJtPE5dQYFvwudtMSKsM2bQmtdGGdIxalQZiYsVTDInqfhwgbmuo6nQQfZwD/iAWpuVMH37X5XGJXC+7/e0f0dnq8Gka1Uwrh7UaxFAnLTzFP4GK7dU8+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow8E5obRKYC4wBzHdGz3sOZZcV8JmzEvAwOctX0166E=;
 b=nU/BaEJ1mo1gGC280tlllBSZ1+CkiSjNCyEUAaIl5XjSrVKLA3fmYZ3IErU0ktvviU9L1h7PNhauBMxomzG0qFZ73mizjUOgk+1pXfOXdqg0hj4snflJRZtjCqFpUjfpw4FBCDoXQ2fGMCABr2Wbs8LpubtSzKl5zAy8r8lz2TOVJttcs6/CRO8dytmQLMgRyo0us5ZCSqK/ta1m6gRj1NxgsFQok4nonQUM/QkR0VvASZSCt8+2Pzc0rurKSsVX4SWd9kKbWCfuyZLc3FxSz++MsAKrY7ZFMk8JMRIT4uJco9pdilwq95Nm+TIt3cmeunlEh7Wt2na/u3loFDUZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow8E5obRKYC4wBzHdGz3sOZZcV8JmzEvAwOctX0166E=;
 b=HJrkaMNu7mYaFGaREtpCYFPc5SbzEVb34doZiNuR1NsfOYbC44/Uq/WI6KFng9gFt+G62mavA8kHwsDwDuP4ohO1Pw6RaoOgLh5qGwApZNtOO2BqPUyJ9T3zTuNxu1BguPX6yYPf2l8txlSV/QhKGMOcPBBJa6FZDTLeUHFNGh4=
Received: from CH0PR03CA0256.namprd03.prod.outlook.com (2603:10b6:610:e5::21)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 17:41:59 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::d1) by CH0PR03CA0256.outlook.office365.com
 (2603:10b6:610:e5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 17:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:55 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:55 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 9/12] zephyr-kernel: Use relative path
Date: Tue, 12 Aug 2025 11:41:44 -0600
Message-ID: <20250812174147.130972-10-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: aa7c6c32-da60-4daf-3610-08ddd9c789ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2t+JOexnwtxKI4lkUi6Hr08Qx2xypHu2RKHfi/jExDWMnr31T9Cn9PZVzYY2?=
 =?us-ascii?Q?SHd+9P9Llm5wh6ew8Bvq8+qIysFT4ZWydiLuyskoNStdA+DfnuJ8EqasP05X?=
 =?us-ascii?Q?qG9B/QvAHKWRrInQaPMe6g8EVjnr8uHaD0ukn3Vu/DIOe3ZJFKz45oyNVoKD?=
 =?us-ascii?Q?M3yCe+Xe0f81OMnQ5IoCjFnX0iMzaQbmzIgs+2MSz5CdaXQpXZPVYqAnaHBi?=
 =?us-ascii?Q?V0zNf2kDzz2lmwU79SV554GKi7vRF7Kn65Y7KCgF/dTgd8YMLcTF89aL3Puy?=
 =?us-ascii?Q?iu0yld56Mt5gl/PM3L3Zcewd/hD4qBI2Wp+P/jLhaRtf8OabKhAznZUOrdj/?=
 =?us-ascii?Q?q+uySWZPQQOdF3kVer+dlm8ygeT7wetsOWN5+IB4DKmMgDNQxmP6PS85JPEx?=
 =?us-ascii?Q?4LWD4NC8LdS1EYeYSA6noMJXfr9gyFAIQNFA0VY8PbrPQQQbFin8CRFZj0Yb?=
 =?us-ascii?Q?+ktlvk+xW2Xqq+qJafUBD7JzDFOMatCrSh6amo1uAT3Dreq/hrg2JcmbhU75?=
 =?us-ascii?Q?8K5fU65ORFyhKwxKXK8BhvTbniQFWZwZq84NB5TpqVvzsJiReh9TTDNtKBrX?=
 =?us-ascii?Q?8GGEZCzX9aXjvIRomb99ddowG5NyYrIT/PkNQUWgxQ21c/5cxPt72wXh6eym?=
 =?us-ascii?Q?Ah92d5OlP940ajbIf6uc6lckHLOCc1ROtfH6QIZreLkQH1bja/dUxTkxsRRC?=
 =?us-ascii?Q?Oq9asv0ACqJ6xxikiRPQwFuZqLu0HQkh7WSWbw5CU/hVVHCxwLgo7W9iWS4u?=
 =?us-ascii?Q?yn6xRTmELZVwSyMmBvJaegNzUR2rQPxjhNRuM0sF1Xf2k5Edpu1kV8kKhfy2?=
 =?us-ascii?Q?NTlb53L2nME2iyp9Sk6zXJ6atrSZWb6vW5x0a8a51h/YOlOWoL7Wfxk7gMS1?=
 =?us-ascii?Q?zMLdyPgDrCE1UVaHeYJL+gJ08eEZmFyeZGJQA5i/97KT8hWdSZLUnocFJEr0?=
 =?us-ascii?Q?+FcNT5zPhgnIxzOoRXgKVfZf54g6yOmYK8ac0MW6td4OIxdFJI0wDJpvQvOB?=
 =?us-ascii?Q?dOsEFkkXR4wjzOghOSAIypv8Lx5GZNek7cVf1v9w89mDAT9MVrPswSUMuvxC?=
 =?us-ascii?Q?zMnG8lj8D4mFJWOuSrqxlPnV/IoKliXWwRfJsxDcHNTI7hSgqQKKi64Xb1n4?=
 =?us-ascii?Q?0+fprplH7gkvt5B94pyJfiAPQ9itQ4T6U4wBtFLBWRPJf5ygeYE8BGbW7m/f?=
 =?us-ascii?Q?4Azxf4xMyZxmnSRJayqc5cQLM1vxfW8ST55WTVoWfsMzaT+zvkgxrvXAi92J?=
 =?us-ascii?Q?juFnIrCUnsbiuvJgdXpkqEQvVu/kZfmdY2w8HYrIuO2Ea15vQDB3FtkWiD2c?=
 =?us-ascii?Q?MnOKB8UetvBP/foZpQER/EszQLATHEf268/IvPxI0906yfh/GeCg1YdK9Iz7?=
 =?us-ascii?Q?u7eUSMF8zFzMRU2uYug9Y/IyZgtgX8qJMxoVQOCsTQ4TUjBzPyhhxsdmeFv0?=
 =?us-ascii?Q?eB82CZytD7kPHgOxJ9ufaYYibOxMwxUkrK9Xf+Jn1shoa0GjmCZeWq8HTPCu?=
 =?us-ascii?Q?eFmlaTnTECa7dghzNNbQG0+ljCj72M/QuobR?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:58.8338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7c6c32-da60-4daf-3610-08ddd9c789ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1970

Use relative path for all the include files to avoid overlaying the
include files.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-image.inc             | 4 ++--
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc     | 2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.bb    | 2 +-
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index 93d36b1..ca728b9 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -1,5 +1,5 @@
-require zephyr-kernel-src.inc
-require zephyr-kernel-common.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-common.inc
 inherit deploy image-artifact-names
=20
 OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-co=
mmon.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-comm=
on.inc
index ba70a29..5191b9a 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-common.in=
c
@@ -8,7 +8,7 @@ inherit ${ZEPHYR_INHERIT_CLASSES}
 IMAGE_NO_MANIFEST =3D "1"
=20
 ZEPHYR_TOOLCHAIN_VARIANT ?=3D "cross-compile"
-require zephyr-toolchain-${ZEPHYR_TOOLCHAIN_VARIANT}.inc
+require recipes-kernel/zephyr-kernel/zephyr-toolchain-${ZEPHYR_TOOLCHAIN_V=
ARIANT}.inc
=20
 ZEPHYR_MAKE_OUTPUT =3D "zephyr.elf"
 ZEPHYR_MAKE_BIN_OUTPUT =3D "zephyr.bin"
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-te=
st-all.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-tes=
t-all.bb
index 85efd24..d9dbb40 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.=
bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test-all.=
bb
@@ -1,7 +1,7 @@
 LICENSE =3D "Apache-2.0"
 INHIBIT_DEFAULT_DEPS =3D "1"
=20
-require zephyr-kernel-test.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
=20
 addtask testimage
 deltask compile
diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-te=
st.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
index 2918d2d..75b1757 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-test.bb
@@ -1,4 +1,4 @@
-require zephyr-image.inc
-require zephyr-kernel-test.inc
+require recipes-kernel/zephyr-kernel/zephyr-image.inc
+require recipes-kernel/zephyr-kernel/zephyr-kernel-test.inc
=20
 BBCLASSEXTEND =3D '${@" ".join(["zephyrtest:" + x for x in d.getVar("ZEPHY=
RTESTS", True).split()])}'
--=20
2.34.1


