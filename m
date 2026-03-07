Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26DBFC9ED1
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:08 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com (CY3PR05CU001.outbound.protection.outlook.com [40.93.201.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3307.1772858642673368169
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:44:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=W/9xQHlU;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.201.44, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6dVxkQwMAdWxQjzztXUj8fVlh+uHuu5NmUahUJ++MhZ+CyPh5I1zgjRCkLI2j1gz+e4NsGqnZiiiOiFfeSDs6AxmOyGOAoRGG1X56wKV4KpHbo2nu4K78h21e536JaxsghMTqdu2mv8D8TRcXEoFc0tPfsZ9FfRZMXrkGmsbJA5dyfyMMuptSg08PRdtpMvsD9ghPDI4ge6AD21NHE86dICZl/BjLBlF9Ihp5rhk3v7Dff9W+JkdT9GSw+d/355sUnDOoPS6rKejdSaYi8lusRlUBORb/V1piQ4UvCzhJ0y1DagiISDUgexRd9CBgmmZg6HH/se+nurDsZULTAR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcmOvgnON0OEdc+oPsVJPAzSYrn4Z/QYSLfoM9Cqevs=;
 b=XeLM3KGJ7FmJ8mJTQgyjRAClXmYRgD+kA2GTol155RpQ5aumSh41g4uKBqj8Q8K88O+EqlXC9WvvAVenakKgY1XGyhvMVSHFrohXvGj6bODkBtsUgVHBFfr95bLFYnps7FsG92iUyct2BsA7QJpIL3nKlURNf/q+AKrkJnK5NUWhwTghMc5OKYZMcWmRy9R9T5e8dNsaqLXIu38imw9Xtk5ITir7C39miPBzVjty+niKunFg9uSN3PlqBUz6Bsq9npBxy0Dp6pHVhl87xXezJWScRKT1LZuts8aG+dGvldFvKD2VJs22FdNDZaE9ebX5d1cPucbL7EFs+oQDkGsfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcmOvgnON0OEdc+oPsVJPAzSYrn4Z/QYSLfoM9Cqevs=;
 b=W/9xQHlU76bEhjqKQEQOwfIFESL+aXEbICAMxYqEENLfAYys8vaKMtV3RSBt5LwwQwcpbO4U3fE4CpE7vmpd1VXXzdXs6BjgoGMeb6NZw9btVXCJAOnq1o5vwVnb4yw4wKo7P9XTnLvnP/eL4FjXP2gnxHQpgFTpWRH/SCCvmcA=
Received: from SA1PR02CA0009.namprd02.prod.outlook.com (2603:10b6:806:2cf::14)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Sat, 7 Mar
 2026 04:43:57 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::24) by SA1PR02CA0009.outlook.office365.com
 (2603:10b6:806:2cf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sat,
 7 Mar 2026 04:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:55 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:55 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 6/9]  zephyr-kernel-src.inc: Conditionally add python3-jsonschema-native
Date: Fri, 6 Mar 2026 21:43:50 -0700
Message-ID: <20260307044353.1936182-7-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4f9daf-c193-4ba5-e648-08de7c0424b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014;
X-Microsoft-Antispam-Message-Info: 
	61lWtw/EKVTJo7HMolynifhNdCc5yfkS6IXA5JHecgLSn5XRtIJARF7Fgyt3I3M4+9ilPAwwr0fTq0OUV4CsqF0VhgfcIyKwjIcsO5Te1lhxXiW+435PMNCyD674JOAVe/osSzcn2Dg/9diO9nsyMvgk2MBMcYbhKTbAS7ZbOaPYtl26g5QwHrOs/SnwWGhteF0mb1vKdnam+8BFLXjq6VsWr7aAEE+TpDbKJR7XPzMKtq74GHyGucrlUlz0pIY7XBFjwD6DBPDkQWVqLAhGOGwGhyiuUbEKioPBTRp6nPPhqKqTTN3vhv1yuKe6nD8szfDhl360LPuD8vxbR/uiQIAsuXRkeeSw2UksfqHZBbxJX7xA+mHZxNw2BDAhGobmv02CVUscYbtApinjcidpzILzjKjelCBVYXhCfWGgGyByiKFOxbMUbhSEoEOAliPhaRotSQq5nFCgHpLomrwdtiemEbbbQoDGvAuIkckhFA9sgjMHACAouwWnaYbVogAZTomajXkx6ovIYHI/+m9i6zNP/XHXcNuM5wWfsA2+e/i/vlA4p0sk1ajd9TJ/EFziHsxze4VqMMSl4+wu1f2tvvb52fhGw97M+WbIdA8Fn9VxD4r6v0B+TjpAPA6IF6QvtP4luP1XC8CyHpIJDfjigsRQYWlUYH0RqgXC9V7F6VK5mXUjMYD/qGM2cQHXjByZ6ZTl68XU1DwfgocCfguphteTyKBiI13uzuNYLp0IRjzBob/WLN54hgJprNSoDoHqbt+CJQ/SW33SQv5E15+nKQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	sPsGb898lQURBhmTN/mq3GHXWENIpGCs5JqG6G/ciHULACN0RvMs372vOzkBU3R3OVIYLh6qgSQAoRwWVyAUks+nevD8iCz/VGiTc7ljcCiu0k1wugs54H/iC4r9d400HOVyYA8GsJJsdy0zjXx2ycpYyxmI/+r9NxnZxZmsn2byPy4wnVtJ+tSStbPRdRUWhbPkNRGFphtpzzqkta8n2tIKJ7xeZmf+1b0QUPIjpDeoLr55MdLO9las6ywLYltTBxJBqOzc0/Ls4P3ti4a+XqHqExfRm1ae4QomsP+2Y4ORX+E3YsVjT5d8oPfs9lhsZ42w3izKD6ZGsOc7PtH3dITW8Q+wvKCxwz8f6f3iKMZGqKWRVKXfsDihPwOppt6p2MbB+LyMT+X9emHA1kUkq+t6h3IQbyggTZdq3tIHocJAwQ+RVZ5WcGmaYadHS7w4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:57.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4f9daf-c193-4ba5-e648-08de7c0424b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3358

python3-jsonschema-native is only required for Zephyr 4.3.0 and later
to fix below errors.

| DEBUG: Python function extend_recipe_sysroot finished
| DEBUG: Executing shell function do_configure
| Loading Zephyr default modules (Zephyr base (cached)).
| -- Application: /scratch/sandeep/yocto/yp-master/build-zep/tmp/work/qemu-=
cortex-a9-zephyr/zephyr-helloworld/4.3.0+git/sources/zephyr-helloworld-4.3.=
0+git/zephyr/samples/hello_world
| -- CMake version: 4.2.3
| -- Found Python3: /scratch/sandeep/yocto/yp-master/build-zep/tmp/work/qem=
u-cortex-a9-zephyr/zephyr-helloworld/4.3.0+git/recipe-sysroot-native/usr/bi=
n/python3-native/python3 (found suitable version "3.14.3", minimum required=
 is "3.10") found components: Interpreter
| -- Cache files will be written to: /scratch/sandeep/yocto/yp-master/build=
-zep/tmp/work/qemu-cortex-a9-zephyr/zephyr-helloworld/4.3.0+git/build/.cach=
e
| -- Zephyr version: 4.3.0 (/scratch/sandeep/yocto/yp-master/build-zep/tmp/=
work/qemu-cortex-a9-zephyr/zephyr-helloworld/4.3.0+git/sources/zephyr-hello=
world-4.3.0+git/zephyr)
| CMake Error at /scratch/sandeep/yocto/yp-master/build-zep/tmp/work/qemu-c=
ortex-a9-zephyr/zephyr-helloworld/4.3.0+git/sources/zephyr-helloworld-4.3.0=
+git/zephyr/cmake/modules/boards.cmake:195 (message):
|   Error finding board: qemu_cortex_a9
|
|   Error message: Traceback (most recent call last):
|
|     File "/scratch/sandeep/yocto/yp-master/build-zep/tmp/work/qemu-cortex=
-a9-zephyr/zephyr-helloworld/4.3.0+git/sources/zephyr-helloworld-4.3.0+git/=
zephyr/scripts/list_boards.py", line 13, in <module>
|       import jsonschema
|
|   ModuleNotFoundError: No module named 'jsonschema'
|
| Call Stack (most recent call first):
|   /scratch/sandeep/yocto/yp-master/build-zep/tmp/work/qemu-cortex-a9-zeph=
yr/zephyr-helloworld/4.3.0+git/sources/zephyr-helloworld-4.3.0+git/zephyr/c=
make/modules/zephyr_default.cmake:131 (include)
|   /scratch/sandeep/yocto/yp-master/build-zep/tmp/work/qemu-cortex-a9-zeph=
yr/zephyr-helloworld/4.3.0+git/sources/zephyr-helloworld-4.3.0+git/zephyr/s=
hare/zephyr-package/cmake/ZephyrConfig.cmake:66 (include)
|   /scratch/sandeep/yocto/yp-master/build-zep/tmp/work/qemu-cortex-a9-zeph=
yr/zephyr-helloworld/4.3.0+git/sources/zephyr-helloworld-4.3.0+git/zephyr/s=
hare/zephyr-package/cmake/ZephyrConfig.cmake:97 (include_boilerplate)
|   CMakeLists.txt:5 (find_package)
|
|
| -- Configuring incomplete, errors occurred!

Use bb.utils.vercmp_string() to conditionally add it to DEPENDS based
on the configured PREFERRED_VERSION_zephyr-kernel.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-sr=
c.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
index 34b2cbe..a1ee973 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-kernel-src.inc
@@ -11,3 +11,8 @@ inherit cmake
 FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
=20
 require recipes-kernel/zephyr-kernel/zephyr-kernel-src-${PREFERRED_VERSION=
_zephyr-kernel}.inc
+
+# python3-jsonschema-native is required starting from Zephyr 4.3.0
+DEPENDS +=3D "\
+    ${@'python3-jsonschema-native' if bb.utils.vercmp_string(d.getVar('PRE=
FERRED_VERSION_zephyr-kernel'), '4.3.0') >=3D 0 else ''} \
+    "
--=20
2.34.1


