Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B11CA0ED1
	for <webhook@archiver.kernel.org>; Fri, 15 Aug 2025 03:55:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.79])
 by mx.groups.io with SMTP id smtpd.web10.4394.1755230098297280547
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 14 Aug 2025 20:54:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=gYDVFCcr;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.243.79, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpkBh4QkLJpVP446+6YYT/XUo0ytrGDYUgeDlypC+i7KNJhL35bj02oRmLNTHeYXXsCb+pQgP0qMhgsubjtLLieYzMTHeBfI1DemwZbm3YiavocVGnK0mxXEiN3nzqfIyoNHqoFIenxZkf/NsNB/QoNldgn0oZ58GEWimXM84kycHwlqvD5AxqgWoxbHbLcFuhrXM2p7cd79lqZl7+PMDjJiRPRVz78rTjg5BGutDEv38HojmuMJyiwTc0ljWKe/5Z0IZ+h88pxuaDHKw/u8745lM1Bt8YG2yM/YtYcDwdQwcI2TkY5yB4zieKQn2qRXBidkstSU4bOqPk3GlcGUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75Z2RMrg2nMfoMKDngb7mj4MkrJC81eXpsc3Ns7ALiE=;
 b=W0vkcNeXK1L0FrDJmtB+/0COAhcAXVH6PgHMA4rO4BAXIqai8jtkKWPTLGeNz7pvdbuVWJDyRvIo2UehXWx0TDUUKHio1zGC2zvBIeUxa62/aP7jCHLG97XxWjTF2qkVdYtW4tkGWqv9KymWLkfN4H5VGVMRJaqhBHhhgvzhq1FJrKfr8OkqxtUpMtPhh9RRZwfd8xO1nPuHLZhd0Jbs6i0DMN56UoMwfWqe/f5BPpjzumHGCqF05vzcmC/2wzzKg22vN18WNIGi0x1eVsKs/RRqMFaf2XTostnP6ZIdOO3K2mDaBy+JmHGlCBXO0Wta3+oKacBXU9Nd8U4oE+64Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75Z2RMrg2nMfoMKDngb7mj4MkrJC81eXpsc3Ns7ALiE=;
 b=gYDVFCcr6oBxZ7FhJCd1fKWZtw3kegEU/LMMvtuc8coD08ohV2zD4nUF5vPjiDkAUq308VR8HbGYKh7364CB5XnPGYZC9yTZgTzs0acctsVGq7DlSSnP8Lw4xYgE88AwDMV3+FVAqrvCeaf8odhw3lD3rMlVxlopYWB1bZiQ8lo=
Received: from SJ0PR03CA0362.namprd03.prod.outlook.com (2603:10b6:a03:3a1::7)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 03:54:55 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::3d) by SJ0PR03CA0362.outlook.office365.com
 (2603:10b6:a03:3a1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 03:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 03:54:54 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 22:54:51 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Aug 2025 22:54:51 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH 05/12] zephyr-image: Add image artifacts to output files
Date: Thu, 14 Aug 2025 21:54:42 -0600
Message-ID: <20250815035449.2816001-6-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
References: <20250815035449.2816001-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cc243c-d5d6-483f-f34f-08dddbaf7ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+Ta5oRzCIBTvgoccGYNEffTybqsfAAIgVRoWdfO7Y9u03IWg1N/5BBCjJiU3?=
 =?us-ascii?Q?jOb7nb5PO5xlMkshDV6Awt+O4gAXxpO+nb38gac+FyefQ/XHJ5ptQvgFcGHj?=
 =?us-ascii?Q?vjnS+oHkYv6kt/OxyXO+Swu/Zh8MPrPROfXkctXm+x35sKaIWE9jH1z7plaz?=
 =?us-ascii?Q?eEwssrtnNDChzLDH8N7ocwnpTgJP6g5fMgB46OHK3ZeVsO/4CGaJ7lInHqB2?=
 =?us-ascii?Q?nVN6FZXuCDi3L54EH7DOyBXX0jJq2AgtqzV1ghVJNV+EfO2ATaCUb3Ziauva?=
 =?us-ascii?Q?g44aCm29DrJewz8eQBx6zrReAe2W9vRB4EBbmDoc2eg6DYXb8CDiX/cLEJU7?=
 =?us-ascii?Q?TMmNE0pBJPWpA9nnMs8bGug2b5ne2kbmrHXtuoCxb360ffGhhOeXmSqWjc/E?=
 =?us-ascii?Q?sQjU+jC0OedHtT6PFLQnfyZdBbdV2GstG93TiOx1eRlmTFG0v2py52rqdpMh?=
 =?us-ascii?Q?+UBpOtXp18xYDQMXI3SHmZ6hJGj0LlIRcvSwMkqGweIO//OiSgPJeheYyShu?=
 =?us-ascii?Q?xcD/gOdUP/mY9/N6Unftfo3Kf8iwO5EimiTvZdhfLjm2s/y2aRsI2lPBcTKr?=
 =?us-ascii?Q?nG7VGASL9w+yuKHTcILQjw24yX2YMj0ijdrDH8N0uvaTvaEFRyRD/jcy7534?=
 =?us-ascii?Q?kEbnOLzq7BwET6jALAIqWzsIsQAulTalsIH/AT8onG1jb8N3H1cPCSVk+3Wl?=
 =?us-ascii?Q?K8aEq9J43M2A/xa5RXUNlE0v1qlW7XswReKQk+g08Zi78+5pweXSR9zTY/+c?=
 =?us-ascii?Q?TtId51wWRcKoiRVXJQx/adlUQNrHDC3zuMmfmCPzEpvViqTbqoyyCeNizMoC?=
 =?us-ascii?Q?GYQbLDtjMovaz8SvSC99QgWZi/Tz68og5XmM9t4sQUmDXjXGlQZgA78ujT1L?=
 =?us-ascii?Q?nlPKuoCUKb+I6dHSU/eJRUJLMwoZsyLSZO9hKJEac5E2vr1r+V0tAEMXRhtm?=
 =?us-ascii?Q?8SXqQJr+hVXXSrnMf/Ym4YG5hSqPqF7ZxgBd7KdqdZqjkg+AwKM/TcK5H9U0?=
 =?us-ascii?Q?jEIq4pMxuIy6X8L7rnRSIrG4ZOozxkR+A53sVyM9qLVy73oZqKU7zl8wMvyv?=
 =?us-ascii?Q?0xVVyAP8QsoGga2/ExmyAd4vojWl/nuKM3LP3UkGrRkgSnB5+2BOmkViRUe6?=
 =?us-ascii?Q?e1MWOy5XgwbrYm89KRsAmNzROE4f6ummgKH0ldaJN19F9QHQuAoJpFtF0tSK?=
 =?us-ascii?Q?YjF3D3DXxfgKoJ4z9xivVvyA+dHtqMQMQWBFn4ONJMcIc5Rt88Af6UOUkMP6?=
 =?us-ascii?Q?rCUAX1QMzwYGdAdvVw24j1CRJWTtrdlKqYG/zVNOBjnBLLB5r50oApJeB1kd?=
 =?us-ascii?Q?g02tVFOVtuVJu2W0HVuKaJq6nDqYIv8OWbZlWWWvDXp6WrTWOXnnU1eiUm4f?=
 =?us-ascii?Q?MPazsbaQw+a4gntWWWGNu221K2EIWA1CEqQaMA6wPkawGKmR4SThIk3K3Pb+?=
 =?us-ascii?Q?m7Q5s5uPtiQ0wrOcRqq2ED9RdfOECf763se8Sn0/aNmdc2tA8wBjw2KY6fYn?=
 =?us-ascii?Q?ykigcsRJ413SMtBn4AP5QHVfRr4d3VtVj4oY?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:54:54.5831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cc243c-d5d6-483f-f34f-08dddbaf7ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Aug 2025 03:55:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1991

Inherit image-artifact-names bbclass in zephyr-image.inc and add
image artifacts to output generated files.

Before:
zephyr-helloworld.elf

After:
zephyr-helloworld-{MACHINE}-{DATETIME}.elf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-kernel/zephyr-image.inc              | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc=
 b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
index f02270a..61ad90c 100644
--- a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-image.inc
@@ -1,16 +1,19 @@
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
     for output in ${ZEPHYR_MAKE_OUTPUT}; do
         if [ -f ${B}/zephyr/${output} ];
         then
-          output_img=3D$(echo ${output} | sed -e "s/zephyr/${PN}/g")
+          output_img=3D$(echo ${output} | sed -e "s/zephyr/${ZEPHYR_IMAGE_=
BASE_NAME}/g")
           install -D ${B}/zephyr/${output} ${D}/firmware/${output_img}
         fi
     done
@@ -20,6 +23,14 @@ INSANE_SKIP +=3D "ldflags buildpaths"
 SYSROOT_DIRS +=3D "/firmware"
=20
 do_deploy() {
-    cp ${D}/firmware/* ${DEPLOYDIR}/
+    for output in ${ZEPHYR_MAKE_OUTPUT}; do
+        if [ -f ${B}/zephyr/${output} ];
+        then
+          output_img=3D$(echo ${output} | sed -e "s/zephyr/${ZEPHYR_IMAGE_=
BASE_NAME}/g")
+          output_img_link=3D$(echo ${output} | sed -e "s/zephyr/${ZEPHYR_I=
MAGE_LINK_NAME}/g")
+          cp ${B}/zephyr/${output} ${DEPLOYDIR}/${output_img}
+          ln -sf ${output_img} ${DEPLOYDIR}/${output_img_link}
+        fi
+    done
 }
 addtask deploy after do_install
--=20
2.34.1


