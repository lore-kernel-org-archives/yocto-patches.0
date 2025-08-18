Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B6CCA0EE9
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (NAM11-DM6-obe.outbound.protection.outlook.com [40.107.223.81])
 by mx.groups.io with SMTP id smtpd.web11.2750.1755554589031245097
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=Bb8MZK/X;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.223.81, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdEVuWt7gmIQG6oyJxUlYRclW+FdULOSE4BUoiwPE+1vLOUCI+3LamWp/q8EEpV2Kg+wvJYvI4rV0eYQpwBTGIBz2kbfHhRpPYW5DzWUzyUAFFKgcwKufJtosp6NP/Sj6GNuLXf2XboESg5Nu1hAxgQPHMyi+HUpz/Xsq32hz98uTajabPMuZa59+uXnaBMgyWWasJkl1ZbaMwI9R7hqATf3kjXifaYhVp/3E4PXYH6zfsEMMoOHVrOO2Ndb/H1cg+pevErAzqs3IBSGnRA60QpdRr2CQUOzPd5P30rBQHuDd5rmV/DZXA11jm/+1iIWwcNUeFIAGz6JAiJLbRZkhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=YmtsGY0W65TLUl0f7uHYYDMCRr8cfV+2KBDP9E6ZuwQSIMqgAyRUo8rW5LC0u7QRd56y63mQTLjbt3ljr4+qR0DNRE/MhMY4alRFTLtSYTrBN39s9IcqlEbvJXNU5YJHGrTOqnVcp6YCZMQuh96xVTy+B9fehpjSjrOG9I4FIHKNaezKD4nIgqg4qACSkX4MAb/+Ir5qHKPcC1mMhRpLXRx7nBkHWimb3T+s5Kk47a7SszMOZh27mXdxSzbUIPYWJI1VsnVX0ET4CNumP3IfwTKoH+2wxGkje8hAOtkBOXrACspEByClPYo2zx0/LWH5yP2xMV+XRYjqKVqNFyh+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oaw6CdFD5cVJRWO5o57yStVa5vvl2soKkyXSLYpSZD0=;
 b=Bb8MZK/X481nzrcHaaNUEYFjuxVvohtZfCwXMPC/r/NsJIE1DkT0Xm13/xNuO0Q9++Vg7mno5U59ACf4aptOOqeRE26yP4k3EXcjtyl6VWp5TffFsV5bSwWVWftCEf9+lIQIsCibEBsFopUNjWGhUhQa14QH2Hw8+PXXN4gfcbk=
Received: from BYAPR07CA0077.namprd07.prod.outlook.com (2603:10b6:a03:12b::18)
 by CH1PPF9C964DBFE.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 22:03:06 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:12b:cafe::f2) by BYAPR07CA0077.outlook.office365.com
 (2603:10b6:a03:12b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 22:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Mon, 18 Aug 2025 22:03:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:04 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:04 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 1/11] zephyr-sdk: Add new inc file and update to 0.16.9 version
Date: Mon, 18 Aug 2025 16:02:54 -0600
Message-ID: <20250818220304.2300436-2-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CH1PPF9C964DBFE:EE_
X-MS-Office365-Filtering-Correlation-Id: e079a5bc-36d5-4d2e-f3e4-08dddea3021c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PHSvD0WLC72pCv2C6fPE37ZbY45O9lls5Xp681nhAuwBFI5qDPDaqNcRbur3?=
 =?us-ascii?Q?vUtVFRPmr86UVBY0v4r8Hq2cY9ma8djFlMAWwY4zSL60OVbbMzSZ5YBuAvWy?=
 =?us-ascii?Q?FwNxKeGxxuf0gGtkibuzAgS6BxFHxoUzgzxfevzeaHR+h1N+MS1Akw3zNyGk?=
 =?us-ascii?Q?whnUVrTqRRYhntkFp6NjdWPn/ud7o+GtBkO/se7id1AWsnzGbEjxshpse9Qw?=
 =?us-ascii?Q?q1KAtVD2agDLoVTOnF8YXLcqF2f2Hcbi0j7tTFKcF5wCdyraJ6ybWdU0ze6J?=
 =?us-ascii?Q?+3sxdLwtTZUII6RLMyJb1IQZCb6Vy8oE1TF6nrH+HA0ghCH2Fsp6nwzs5S/s?=
 =?us-ascii?Q?lQ7s9zI0zrqFJnxvppxn4HsAwPLDCiXmRa8ERdUAi8Pnkd2oCpSlIZwFH4Bd?=
 =?us-ascii?Q?m1RvJIcG3qrsdWPMHCcyOLwT8ffWQftuQvrcNyLpgtYe6xxr/d6qHNE05yNe?=
 =?us-ascii?Q?f7g5+fCGtXJgSnNaIBayzEX2CUFfMZ90xXDHQldsxu5whOWIa1UFM+uTMy1p?=
 =?us-ascii?Q?Un8pfgfQR9BUyS1KW1AsrdQ6J3eXpvB2J43obzjHvZFJBwg/q23FmV8boUUB?=
 =?us-ascii?Q?SY5Yox5co2DXVP+E+vhTs5hgg7AeRwkS9oUh6dEY/DWMnOhW1/RRwpkZErd2?=
 =?us-ascii?Q?E+MiKCv6e6CU4lMXUp2JhukhIz2eEBuLrlNgVfK74LlVMrzzKrDCPfZxFPcr?=
 =?us-ascii?Q?Qq1HFxNI7X7Y6zdw+E6It+sm9EVUc8dOhjUksZzj9/gaWUZunHYfb+DiWVVu?=
 =?us-ascii?Q?bSA3OZ247lU+m0U3/eY5TE8awxq6YitWPDO9IKR7MlvdFkFnpW+sqj19oedH?=
 =?us-ascii?Q?34P9K8R7rkjWartcUcgj2sLvUWyQr7CzKGHJX5MRjl25RdZwNqbhqWZkj0vI?=
 =?us-ascii?Q?LdCCX2Iou1kii6FFmcSORKungBopKoqpAGcgPMw93rv66he6zlPzcEAT93HI?=
 =?us-ascii?Q?ajEyRXWGW4LN1k0nypHr+khsQEJTiLY5z3Y+UYacFeDHgYwsfOBkNwURuqVD?=
 =?us-ascii?Q?JLuc7qIvKB4TCw+Ts5ZubIj/XBsHPe89c7enW8Nw8+QgCsPizTQ9NGe2/E2x?=
 =?us-ascii?Q?nnYVlLF5qhCG9eTLsPifMKrv2WkCT1nW4gpuTX/Yk1/sqT0XPDQGHMCzYnne?=
 =?us-ascii?Q?8fVn6wSaX/oko0TYKbm5G0/r1D6I//vnr0FsmvKSKhWukhhfn49RHUSz/nvo?=
 =?us-ascii?Q?+UlTve1td3Qv5sqbQMXEgvi6/gcGyMP+qU9ufuhaVJVLlQ7XcjJUna+LS92g?=
 =?us-ascii?Q?bw4X4EHv4ihTdB8XqCIbFlst4fKO6L/ZO/yGl32JycDTioKUCQ7JqtEywewN?=
 =?us-ascii?Q?oW83Nk/wMHLpNtcaP1hNBgVnJGMr5hDfR5Q4HxARbEFRb7VaKQ1sGxlVjS1i?=
 =?us-ascii?Q?QphNy/oukDbde/1D0Glki3T+MUx2zOkmZOYRK7UN4A7FkbjVj0NRVoJdKgrP?=
 =?us-ascii?Q?hSonr7ybQ+S41hjEPGJUmGwwLCxQy5iwNHbf9o7YkTrBapkot0leDw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:05.1630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e079a5bc-36d5-4d2e-f3e4-08dddea3021c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF9C964DBFE
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2038

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


