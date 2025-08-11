Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC704CA0EDC
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 19:47:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.60])
 by mx.groups.io with SMTP id smtpd.web10.57322.1754941619937901368
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 12:47:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=FNji6Rfi;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.60, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzw8oqqlJ6tkayYCxCPVwRu1dw98ZA52FWxy7Uv6OYEvCUFcrb8bQFBdH4PkAz8T/K4adDWFlsnA7KhsEXQwRt4iABeWO5m8Y+JKBF25A0AyDsgDPwJ/jgTPwqyFIVgVjcxCAKHHqlGvuclXWhYqTzmD8TcAv656yUIXfVk/Nn68bA3Bw3B+srqUKb0C1CPsxW4uQA/VrPKxp+93unrC6ZoBP0kZLNNE8mJ5hGlhFiVGfpN1Nt7IrB4x3cemXGpW5geK8JSpGzEb9UXkqgQujimducybNTx2N4HtnR+u0/g+O31A/ufADwYEGPy8Lc7YFgVJgJetAf0pCfapBHjSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ow8E5obRKYC4wBzHdGz3sOZZcV8JmzEvAwOctX0166E=;
 b=LUs10amY8/6UhOJX7m2I4kDyOqfvEyy9MBFbYa9NHw0dPsLbPJaNo6Mlm++KUqozXQpPxQNY9ah/MA8wgnpLZdTjlWk3X6pN/QrWjljrzLZXsA339tZ8EXaF1O4h/+4wVJq80WIF6xetgNd04j8W5sRQ5YaQ52j12KWBLK61xkER4jU94pldvBOFkahdievZ4GUxYFVBZvTWcYoGThnhvUPEolzP/04fNIFeKknGLsQXzV5y7/Stoype4ICQK268WapcCiC0kDUYKnhMiN5tpiBFtGCJE87xCNVu6XnPYZmgfVpoLALlV38PVM/NiDzd1LQJ3yI2YKfDUnHfShsvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ow8E5obRKYC4wBzHdGz3sOZZcV8JmzEvAwOctX0166E=;
 b=FNji6RfiMlISNQj/LpNW84GGCQQzvuTSRNupNtaOtbLkvNZgptboFEY0/swRvFZie0W50V8j6pPJJ0NOS00joX+GUdH9e8rUHBiLEgzlsadJn7mrKpF2qk/rPTgDNXD8Hlm0o8uoHskOT4qpmE47cY8VPdAS7qEq3vE+C70DChE=
Received: from SJ0PR03CA0091.namprd03.prod.outlook.com (2603:10b6:a03:333::6)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 19:46:54 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::b8) by SJ0PR03CA0091.outlook.office365.com
 (2603:10b6:a03:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Mon,
 11 Aug 2025 19:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 19:46:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 14:46:50 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Aug 2025 14:46:50 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v4 10/13] zephyr-kernel: Use relative path
Date: Mon, 11 Aug 2025 13:46:43 -0600
Message-ID: <20250811194646.3408854-11-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
References: <20250811194646.3408854-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: b02ee590-1270-47d1-5fb0-08ddd90fd313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VPYZxHbuXuzxvNvvSVsz70XxdTZPY0Jh7gPWUVP7/jKVzXxYJVIuIfEqCYvt?=
 =?us-ascii?Q?uzAV9SmyCSjiOVaIhYmBJQqsfe2JSoLkSgpIWkyv0mBVVIpnRFNty9fEkP1V?=
 =?us-ascii?Q?TeAE/5v962kuHEibaSYoOKB1fzfxfuWH1ND7GTWCdbZrblSyB/91mpWklrDN?=
 =?us-ascii?Q?kjp2m4VN/by0TJntXkwEM/v28LBiFEl/qLpF+Q4XlJQM20D0c99VRmP9QGav?=
 =?us-ascii?Q?9OvvdgffJJ2G3SxtCQJKTnzbjr2OJd0hQJ9l16rBdeMrp3Ar9TzcKaaFaEBs?=
 =?us-ascii?Q?lNb/ahWj7lngpRk8E3ZZo8wNdfaJYf2q9r/wkenJQo9anyc43tPWAbyhX1mQ?=
 =?us-ascii?Q?JUShxI4obAQM5fztiHm94QBtR7RbMvykrua9mx3XSpIL+TUilfqlFMKCIM+n?=
 =?us-ascii?Q?HKV18LuDUHsZs4f/BdvHubN0GnFeeGMBnGJDb4NAFkjO9z+xD6rNKGcz0nNS?=
 =?us-ascii?Q?593kDlChlwpIgFvsEVCF02mqrJBTQLcB6MQCd5bTsLNf2qFGrNLaR1ukP79p?=
 =?us-ascii?Q?1RRTULsQq5/ksEeX4BIMmlegLnvIH3st4tW4hm6vwa+CnxQOVujlrvqMZ+sl?=
 =?us-ascii?Q?e6pk92g1OacSe+GiJBzn0aXJ1no9tW2THwssdhT4fhZS/puChmlQhHqo2H7i?=
 =?us-ascii?Q?jzXwNWkEoZdRxd9d2jloYfTUfgoZprdI3x8VwJrF/SQt3MU+9dTmhdiUJyqc?=
 =?us-ascii?Q?wRlaX0bS5XDQHyDnamxpn5CH0F057VXPEIab6VRzbk6ozTuB4boV+E4kt1HV?=
 =?us-ascii?Q?ba95y5OBd61ZQ/lQBi6uj9uMjtOhSc5WaJD8zTaEtgE0WEjRBDNBkK+cyAdz?=
 =?us-ascii?Q?3FAQWpI1UsIUlBR9s8mG76OJOq+iRi0hQtQRuEuDlKT7ukMlTrV/KIkPOT4n?=
 =?us-ascii?Q?UZrgjnahoagZdwd6E/7WIo5P3lHrvrKGxUTea7+dvz/dw2Svbd4k5/JGgDTV?=
 =?us-ascii?Q?Ce0t7IOgFBimdzz3w7lunr/WkLePp7JeYrX5EQ+sgQIomFuYjBH1VRweAJeR?=
 =?us-ascii?Q?lBVvCpaRUXyZC6a2b78924lGBYZ6Foy3s2ZpDSN139MKPwqYsRqPSeEqRD/B?=
 =?us-ascii?Q?doh6zprLCm9bMz3q367xOgmuZmO/qp7YkQjRqjvDXC5Lvh01h7RviGyLy41w?=
 =?us-ascii?Q?6Kp896p8iczHb97exs5BPmNX3jaryoQh4HflAiFhOfnMPMf2cnNp5F1TglO1?=
 =?us-ascii?Q?kwmjlKcfmH93y7MTBWVV0YPkc2BhqudeM6G/T2LX76I+E5EQnOs+wjK0KdCF?=
 =?us-ascii?Q?1laYJLW3+IEVckHAhhxoFdADeI+nZq35DYwjkzQGX0OR/TRsSBjqtQD3QCYT?=
 =?us-ascii?Q?UeDdoPLPjHohiPekGM5mITaSBKJLAJzGsAnrGRG72KAvhcVUgNpYdw6VM1HB?=
 =?us-ascii?Q?Bpl97SU9qHBZWytLgQYr0EPnWwFr0cOcPlxiW3Lxi34iff8E8i6V+SpCsp1o?=
 =?us-ascii?Q?tVEfz32C8kF2d81Bzrr3D+m7RebzV1APu3ywzEzW1f96WFc06/lW7PTIcxQO?=
 =?us-ascii?Q?JFglYUE1nXALwTK7TeGcgd9OT4XyppAPDiat?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 19:46:54.4141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02ee590-1270-47d1-5fb0-08ddd90fd313
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 19:47:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1955

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


