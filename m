Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A6ACA0EE5
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (NAM02-DM3-obe.outbound.protection.outlook.com [40.107.95.89])
 by mx.groups.io with SMTP id smtpd.web11.80883.1755020519967252143
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:42:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=wHX5V6Wc;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.95.89, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEfd7vJUNfg0mi05k3GVIMBIqbhavkGg00Mj0sCY00tYN8jKyRRl62kc6AWctLmKtw5zlO2DG6ExqYZJskdoYHsyHAQv+us1vHcnQ81MmybkEo/UTUkQZGe9orSGFtkYO5WawKaNOtBPPj2TOEGmGuzPEIytH/RUjyjrLRnbsP1NqwplohMQ6OKl15IiSU6WpeVByAfXAyDdKnr2PG1wyRPzHAk50NuHzaCu2ABbBz6PDOD70Fn+M97wGEOZDWTCbnz2xXlGFFCqwP7zE85beG1YIKr8dmLWfKBfERnpqWpuww4W2+otD04UAdkTiNXQHR6FvQdDNpuAs11kMAcszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=Vw83bHj+niSFN5NbVDanjKA3FZDTXuhh0CrDdXI/o/YmNjJRPAnWNtHPLl4MZsNOGgyplt0P3tUwLqZOkIJ0/4fgXqZ09HThG2IyPNBIIgvPdgTKK0XMLpdp6IH49MBipZ3P9w5KgFdi8Gh6utQ1gXuh3uLoURMsaDFMm0jvmTCiZYeF0ur6S0EWcNUPfC9mQkOB6FzgE3Cz11S8UmfJCItY3PIuW4MHCTlqp87d/YnRMFkQtiQYvmx1VR6bmD+qGPrqtqLCH/q/WEpLHGh77p1IOMCivjFhHI8RZONZvuwDFrr4o5N7xP69VBBJg2FYkn3bbB+N9hgJhwg2jzrefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=libHPKrEdGkJD/iLYxKCQC1M2iEgtoZDf4BbATkOwjo=;
 b=wHX5V6WcBjVKGXK4mcaEFVhgxj7F3iZhSs7ETJ82bsRlnaW8LFZoj0g9u6akwbMZJhs2PU/lDFH3uKAtymogmjyCGMJZmtyMhMnCnyC0Nqy5V2ZaCPLYpVRc3HgLT/vvUJ3zY6I2pSIarDqjaoFPbkdhXiT95xQOcQns2gXMmEQ=
Received: from CH0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:610:75::12)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 17:41:57 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::12) by CH0PR04CA0097.outlook.office365.com
 (2603:10b6:610:75::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Tue,
 12 Aug 2025 17:41:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:54 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:53 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 4/12] zephyr-image: Add image artifacts to output files
Date: Tue, 12 Aug 2025 11:41:39 -0600
Message-ID: <20250812174147.130972-5-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c63b32-d83f-4536-5747-08ddd9c788c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4Hjvp6Qe4SAR81arO6Db/URq/D+wDVxe7paZZIPbOEd9R7yTqRT9z9u5pjtQ?=
 =?us-ascii?Q?CHPBBgG9QTWjg0017v788n74glbiwm91Ifxw/2QRVup58oejLlEO44ymvOj5?=
 =?us-ascii?Q?AErT/JMyrTNyqAyaFMPp0mHpedTCRoqAe6m9SCngyAFyHmCweJckBWebdKq9?=
 =?us-ascii?Q?vuY3D1+1o7fba4WdXPV3GPZq7NOAP3+f0Lx4T+p2luPJup846UTghLcxCv3m?=
 =?us-ascii?Q?TMjfpOLk1J9ZppP+CjS7PO7DSzW+pzv1jbghYL59YyC+jdRbu2WxXWxNxOtG?=
 =?us-ascii?Q?vxGQaCYUIiKXvS1gFoAZlsdQWZvNN6ZodZvqOfKwtGdi4xy3XzJdbG248S0o?=
 =?us-ascii?Q?UbgzNp7O6qGgXLIbsZKOPb/9rQ1nm70RhVEACYS8HirZ/tVORezkQEw3YUKZ?=
 =?us-ascii?Q?BHoymzcGwlIHjGXOJQYVIKYeq9MyaruDZZ74aOvzn9CbYEOLisS9UMrWf173?=
 =?us-ascii?Q?1LZ7Zosfamisvv7npF+kvZJgHk0BiT8rAWWD7K5Bj5uTC+3KHjB7cqo9Gsl0?=
 =?us-ascii?Q?Zlx72RlUkHKj2NXg4e5m0PxbQ+/CKv7p9LPhD3nBiUwy9NYWOXTfDjN2wohS?=
 =?us-ascii?Q?yZVNeUP9IlES/mf+J3jfqT+Fzt8Fi21nMKvhu2mFihH/8paMBMYKVtWqaYik?=
 =?us-ascii?Q?rdgEH8TmVZlO72fdHK3rNkLbpQ48nNRkKczQyZbjkhCKoRHe1Ciq5pOVIxZO?=
 =?us-ascii?Q?smPxTNoBldFvGCOj314qNZ4GJjWDxTUd21+YjEQd23WHUM5jf/mO30gV7ByO?=
 =?us-ascii?Q?95JMZQS5f66td9miHNuSOkq89zF2j+5Gprt9Hjntd8XhR3vgZ8Ymqf0B575Y?=
 =?us-ascii?Q?vfPXIi6VDHOo1o9cBXXD4lqPz/m10RR0fVUZhqEVPNxHy6kxFhlyo/pJQNA/?=
 =?us-ascii?Q?1FeCWO5Ty1Hnn+b08C2yXoGYqmusmNVDiXFXDhGm8PWv/pvHbq58WUpl1Hz6?=
 =?us-ascii?Q?ecqnim5kIMG4odj6dWM+INY5SI3AlvjT/wM1En/FpiKaHj9oYlrxeSYKmOTn?=
 =?us-ascii?Q?ftUEWAe6LmZlaqIMrevC3g7/Sga8pN9FioQp4BpQaN8ymPADXxCSGary3SsA?=
 =?us-ascii?Q?F+Loy1z/w1dJwbTckpngOkKgW9YdpaCigQrVkff+Ez+tx6sM9tyg2hwui5Ts?=
 =?us-ascii?Q?CVABL2zkHqRgrRmVIhOM+b7y3hzb0YUyCWXaA89BUFfAoP+FrEu6mnaZrNhC?=
 =?us-ascii?Q?GeZogJEjunVuvzyB40FZYQqj6O667fMopx6FCR4Z0H3XjNYo5oLn125xNvNa?=
 =?us-ascii?Q?TTI4GRnQ1Zym9vYKnTb5jrsJK3HcEwHvmo1SA67mX6aihK72lbzMJU5AWYJ4?=
 =?us-ascii?Q?4jCKoembk6Ti2q6Vq9nz8x3PrLw3XJb7KgvK/BgcAxrHbiCz9ON+sSGddcp3?=
 =?us-ascii?Q?1pae/taedrKQUwRRf3ajDfUdKhCS/l+lJEYwO3U8ilKHeQqZfm0bgWz6mTes?=
 =?us-ascii?Q?ADEF2XOEvbkKeXpEwdmixQ8If9Hzw1W4sBmy2BhktkO/98ksddiYFKaa8tUM?=
 =?us-ascii?Q?6Tra8p+uPJSofXfGSHImAAnCw+Q6JuP63pU2?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:57.2356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c63b32-d83f-4536-5747-08ddd9c788c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1966

Inherit image-artifact-names bbclass in zephyr-image.inc and add
image artifacts to output generated files.

Before:
zephyr-helloworld.elf

After:
zephyr-helloworld-{MACHINE}-{DATETIME}.elf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-kernel/zephyr-image.inc            | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index d6ee21f..93d36b1 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -1,29 +1,47 @@
 require zephyr-kernel-src.inc
 require zephyr-kernel-common.inc
-inherit deploy
+inherit deploy image-artifact-names
=20
 OECMAKE_SOURCEPATH =3D "${ZEPHYR_SRC_DIR}"
=20
+ZEPHYR_IMAGE_LINK_NAME ?=3D "${PN}-${MACHINE}"
+ZEPHYR_IMAGE_BASE_NAME ?=3D "${PN}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
+
 do_install() {
     install -d ${D}/firmware
=20
-    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT} ${D}/firmware/${PN}.elf
+    install -D ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT} ${D}/firmware/${ZEPHYR_IM=
AGE_BASE_NAME}.elf
=20
     if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
     then
-      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ${D}/firmware/${PN}=
.bin
+      install -D ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ${D}/firmware/${ZEP=
HYR_IMAGE_BASE_NAME}.bin
     fi
=20
     if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
     then
-      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ${D}/firmware/${PN}=
.efi
+      install -D ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ${D}/firmware/${ZEP=
HYR_IMAGE_BASE_NAME}.efi
     fi
 }
+
 FILES:${PN} =3D "/firmware"
 INSANE_SKIP +=3D "ldflags buildpaths"
 SYSROOT_DIRS +=3D "/firmware"
=20
 do_deploy() {
-    cp ${D}/firmware/${PN}.* ${DEPLOYDIR}/
+    cp ${B}/zephyr/${ZEPHYR_MAKE_OUTPUT} ${DEPLOYDIR}/${ZEPHYR_IMAGE_BASE_=
NAME}.elf
+    ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.elf ${DEPLOYDIR}/${ZEPHYR_IMAGE_LINK_=
NAME}.elf
+
+    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ]
+    then
+       cp ${B}/zephyr/${ZEPHYR_MAKE_BIN_OUTPUT} ${DEPLOYDIR}/${ZEPHYR_IMAG=
E_BASE_NAME}.bin
+       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.bin ${DEPLOYDIR}/${ZEPHYR_IMAGE_LI=
NK_NAME}.bin
+    fi
+
+    if [ -f ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ]
+    then
+       cp ${B}/zephyr/${ZEPHYR_MAKE_EFI_OUTPUT} ${DEPLOYDIR}/${ZEPHYR_IMAG=
E_BASE_NAME}.efi
+       ln -sf ${ZEPHYR_IMAGE_BASE_NAME}.efi ${DEPLOYDIR}/${ZEPHYR_IMAGE_LI=
NK_NAME}.efi
+    fi
+
 }
 addtask deploy after do_install
--=20
2.34.1


