Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19510C982C4
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 15:00:50 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com (CY3PR05CU001.outbound.protection.outlook.com [40.93.201.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16991.1789570845510925347
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 08:00:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Uyjd8nac;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.201.64, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/vocieUTv4eES3IwDxe1JH8TLbFQH5v9hCaKim4jGTirR+ETFkX0J5wo/HQXBonJaGcVT9xGwwvR4YpHGyHTxi1bgLcR4S24X9Oo6ijsRATb1W6+gquYPOV4WzeKPmkqDWuFlo7WqGsQI5F9SwnMSVQoNd+v95EAiXf/+ud/XCRDjnUkWfHyEI1VFUM3KublmCFx4q/ukz3bsR5UperMft+RM+jrUbOnLX5EhG0lNer8S4Fqh08mkbCSYmGk3Ah80bvAnggWndilGQMPgy87HViR+Z3wMOQizBIraBhD4cwz3LjF6HNdACY57Bom1u74lQKsSQC2yhOXC2O73PXXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnhcuxuA+UTGzjDxT3nK8Q0bwLcOPO0wQrWFhIro3Mk=;
 b=p9fi9Hj21jwsl8BXFs9gajQbDqXe6n8sy4PPRqaw5zGfd0Pw44j9ZcNWWT/c+JPUi9Rt8vtPegqMH+opoVS6w4Qma7qFdFqXfXwR2FhIGWdPxA8ohNo17gGySQJZ5BJTRqq71enwVRT8OdBxKxB10OpViXAPGsuUUt4JYih+jn262PWCqYkuTyi4pVY3jDJQA16dceKnXESODoUVs0g596tj4l9+lzlALwSShZvNgE+Ldm/S9Nsu3s2TyMl+W2XRvHxoclKa+OdSdBlmc95Qs8FlnZKy46ytSYbnlK1DRguN12Wc4bjL0Esn3NqJIevNGIgnAL+NjkvC615UW676bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnhcuxuA+UTGzjDxT3nK8Q0bwLcOPO0wQrWFhIro3Mk=;
 b=Uyjd8nac+2Zg7TZXnz4AZc7CU18KFcxUQi/zflNH1ecld+g7FXQvoUvVOFRv7eO2JOt1dBo3b3tNAUsDS5Z5P48y7v0tEw4KWXhwknmtlW6B+8TAI7JULjSv5MrbqFOJ9zSr/f9lAbedjzSTQINQdHaq7dpiQElSCeyMNBDgDSI=
Received: from SA1P222CA0056.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::8)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 15:00:37 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::2b) by SA1P222CA0056.outlook.office365.com
 (2603:10b6:806:2c1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 15:00:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 15:00:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 10:00:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 10:00:36 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 10:00:36 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][blacksail][wrynose][PATCH]  zephyr-toolchain-zephyr: Unexport Yocto toolchain variables
Date: Wed, 16 Sep 2026 09:00:36 -0600
Message-ID: <20260916150036.1839867-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d481211-6c33-4f70-c030-08df14034430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|5023799004|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	0r/d416OnDJ2HPe4YR4vE92Bzssa/UiiMTTUdt/etl2XzqgM+bE12x7GO6bHW+Uq0snHlUJkcRY+t7rZJnK7wd9i53OqHlSkGu+KtAb6Y93cwqrK35geoZcqKYiXPkYB7Sbt6yuq7Ce2kb8s0ILX4xqoIVvKEucbMc65sPh99nZQNYEs6+1mAsBUUl+p66hzsIBDNQwHnLRQg3LfAwZwTEUOmeF4hrkf27nUfeTNQT/LNHPs4kUTz3SHcGjk/ZHIzH0eJtrv6WXlkrP3ZzpcvDgClKohnHS9vitFIaLw8+CiY6XI65tpARDtrFAZbW7fQYYh3wx8xedjUR214uLjPI6kq9B9uuaCWNq1SfDi5u4XwbFWm1vYxkN1z7TbyvwKrAlHUqd6Qkc9PJrxm4TaaotGGAEqyEeK/LLzsJbnoa+bXtSVWtktmkVb/I8uvxy0q0XRu/fnG1EU7L1NsXqQ8sleW2l181A4M8DOZOpnZBY7I8FmUrlFVsI/HiA5wNye8aOyyVVceGD0IvIYpK1D489NdvzjryaJX496Xte57YkSFO9blnA/Ihl7g7YEcHkOnBhGhEidKONZob+QEUrl37O8T/a7HuNywvotgu2fr25zfeB4SWzNuDmvmjcF63crChU3Fmx0nsFrMeBAsJMOOubSxJRWaooYijQx1MqK7BVJ/WqAK70JoGMTO8p9dE27hytb5nXVP9MpnEa6k4eJ/g==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	l2UuS4Xr7vQeYZ19kVGFqVZDXsVd38w890WCrqyAO1NTlPDSU+QZXaojmg/VSS4vD34smS5LJHbZM9QPmaNGRph2bMeRsM1D9BaLBBUS6lAlmyPudvaO40tw26orozXAQjAKUJAQpJftced4KCNE3G4BZ6ATa0Bs2YT6X3gXzaERui8XzFrzPtdnv22c/eiRJSKrc2CXFDp2B8himyd4LtgnI6hpVK/OCrBVUhPnp32cbsHbDDEedYFkEKU5dZBDLKlCiQHsfdm0kNUhd+3KtoWO0jCr38Y/X54Y01ubRD/Hc1CAluKKsXu5LD0N1T4x2zasLvjNA+PJLLSRIPFypl/OJhzVly0xZrRBdVsieXB0cFAHlO/uzWGW7mmqKokIy2T3mjtWBhOEDA9thGCmVU+Jkty6KT9u9Rp1d/ZwhgpidSbz4rhWXJtT6UOWsQkL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:00:37.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d481211-6c33-4f70-c030-08df14034430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:00:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4855

When ZEPHYR_TOOLCHAIN_VARIANT is "zephyr", INHIBIT_DEFAULT_DEPS is set
and no Yocto cross toolchain is built for the recipe. BitBake still
exports CC, LD, AR and friends into the task environment, where they
reference aarch64-yocto-elf-* binaries that do not exist.

Zephyr ignores these and uses the SDK, but external module build systems
invoked from the Zephyr build do not. Trusted Firmware-A is built by its
own Makefile, which prefers CC/LD/AR from the environment over the
CROSS_COMPILE value pointing at the Zephyr SDK. Its tool detection then
fails and expands a multi-line warning macro into the tool identifier
variable, leaving embedded newlines that break a later conditional:

  lib/libfdt/libfdt.mk:16: *** invalid syntax in conditional.  Stop.

Set the unexport flag on the toolchain variables so they are unset in
the task environment and TF-A falls back to CROSS_COMPILE.

AI-Generated: GitHub Copilot (Claude Opus 5)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-kernel/zephyr-toolchain-zephyr.inc       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain=
-zephyr.inc b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchai=
n-zephyr.inc
index e265883..8fa3e09 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr=
.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-toolchain-zephyr=
.inc
@@ -18,5 +18,18 @@ EXTRA_OECMAKE:append =3D " -DUSER_CACHE_DIR=3D${ZEPHYR_U=
SER_CACHE_DIR}"
 INHIBIT_PACKAGE_DEBUG_SPLIT =3D "1"
 INHIBIT_PACKAGE_STRIP =3D "1"
=20
+# INHIBIT_DEFAULT_DEPS means no Yocto cross toolchain is built for this re=
cipe,
+# so the exported CC/LD/AR/... point at binaries which do not exist. Zephy=
r
+# itself ignores them and uses the SDK, but external module build systems
+# invoked by Zephyr (for example Trusted Firmware-A, which is built with i=
ts own
+# Makefile) honour them and fail instead of using the SDK passed through
+# CROSS_COMPILE. Keep them out of the task environment.
+ZEPHYR_UNEXPORT_TOOLS =3D "AR AS CC CPP CXX LD NM OBJCOPY OBJDUMP RANLIB S=
TRIP"
+
+python () {
+    for tool in d.getVar("ZEPHYR_UNEXPORT_TOOLS").split():
+        d.setVarFlag(tool, "unexport", "1")
+}
+
 # Set Zephyr work directory to describe toolchain accurately
 MULTIMACH_TARGET_SYS =3D "${ZEPHYR_BOARD}-zephyr"
--=20
2.34.1


