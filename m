Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0B0EDA6B8
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 17:15:02 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23770.1772558092570835978
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 03 Mar 2026 09:14:52 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@axis.com header.s=selector1 header.b=YzpJrd/o;
 spf=pass (domain: axis.com, ip: 52.101.84.61, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVwbvMmIwr/yOR4scivrFfiSe1zMTw1gQKixb52z7/1y6kUuCat7NALI7oP4NEai7hXNVGm2Ms0W9LUZtifGd96W8CCWmScG/UlpOjPbNZPr87FpBLo0UcMR6zeBrqdI6M5yQbyuPHcZDz0iZtoWe0VuH1oDV4Nj/82tpTXR75NUc5pHAv8VJEfO8MZlpGTpLOjyzqTAJbd346g4sd79rOIOAOHxMX15RVcuBrPrr3lRKz9BC6IhdTgBQgGELKyAzSZBe1hCKSiICg9q8UuJu+DHrvlDUIYBtkZTT35+9K/3rLDbLKWj0yf3v1t2Kyo26FfMAn7UIBptPPeDSqrm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETwZkwkXb0rtWfWOzsbxz70Tg56+uzORRMuoXILdx6g=;
 b=S7R4Dh7G6iRRMmj1Clqh9wOo9J4nFto8uYCdLlHY61NixQByCsO7mOEsAjbRXGDlfQbZ6cMgRGPShLErtXseP+Fc0PP72voD2SLNGYoVEhfAGxBnvxpdqWndd8Im094DHAm3fjqzKzcG7Ckl+/mE07wEnvddWh1R386cxp8xcKxJ1Y27pDdmVbDPM5woYrAEiGYIG0L8PE0Aj4iMuX27x9Q/+MhapfWRIBdXRljRVa+xp7cwlOCvuxrK916C/NELmi4/39NSI8uunJo4u51JfJTmK3orVY/a8R1XqWJirkJEcU8XyVOdEf+rD76Avkp2wkVRv6bYR03/C6qmVf6geQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=axis.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=axis.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETwZkwkXb0rtWfWOzsbxz70Tg56+uzORRMuoXILdx6g=;
 b=YzpJrd/o8Lk3FJGBahq/5mkMZU/+SQtvQdooTE4GVVGxHHwsXe4UqfuOI62cONNXU5ecycSbpRQDKjjHveErz8aKL+NfQiXKNeRWsamR+Skrmh0Nw+gE25KeUW4hQJoduoCYPxjbLkSJBT98WuBoi7cnI+2BEVa1wacZoOoMa00=
Received: from AM0PR02CA0180.eurprd02.prod.outlook.com (2603:10a6:20b:28e::17)
 by GVXPR02MB11133.eurprd02.prod.outlook.com (2603:10a6:150:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:14:46 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:28e:cafe::2b) by AM0PR02CA0180.outlook.office365.com
 (2603:10a6:20b:28e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Tue,
 3 Mar 2026 17:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 17:14:46 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Tue, 3 Mar
 2026 18:14:45 +0100
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Tue, 3 Mar
 2026 18:14:45 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Tue, 3 Mar 2026 18:14:45 +0100
Received: from pc56063-2339.se.axis.com (pc56063-2339.se.axis.com [10.92.3.2])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id D26DF2AFD
	for <yocto-patches@lists.yoctoproject.org>; Tue,  3 Mar 2026 18:14:45 +0100 (CET)
Received: by pc56063-2339.se.axis.com (Postfix, from userid 14323)
	id BE05F12065E; Tue,  3 Mar 2026 18:14:45 +0100 (CET)
From: Peter Kjellerstedt <pkj@axis.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-security][PATCH 3/3] fscryptctl: Use ${prefix} rather than /usr
Date: Tue, 3 Mar 2026 18:14:42 +0100
Message-ID: <20260303171443.2736418-3-pkj@axis.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303171443.2736418-1-pkj@axis.com>
References: <20260303171443.2736418-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|GVXPR02MB11133:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4095ff-184f-4bcb-ef04-08de79485e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	IKGIYOgz/WVkzS9zaSnV3KbtEUtRHIGtSCkWS3CbFIDZxnUVKFt6GAPRod5ySi7AtZ6RDxA0baFWgueKk0A4QxwIdwJYu5twcztokX8dOWBDcyx8o0chzTm5xhm0UhOpeVpyvpVdmnaLXfI+L/nC04GRiBJei6mHdh3zawNM2wesHjViUPxGQyfvorztnENwKUEtFNY4LwHlBKte/iJy4C9O7xpmWiHNuK9IH5hGEkn5xmehL/rv1QC2Segskr89Z8HNBPGWZ6i5bqc3Lz8GyAF+w5kouYpPhSiZLxVQM8LGcNoZ2DAj+MmcYs//+OIP+4Jl8bYTW+itGfxhcUqdv1JiFT3XSBWz1CK+7MRvurcw1FQhndj3LXN2o0UzE1OszzO9onCUGgq/QgKvqOvkX+ZYL0j0iACWNiJE/rCtQr9A6pSftgvWoHbRNXwU9ykoA+l+qiHNB1VVhK3Y5aVWgsbaPIHdix0An9TANSfvfaODJiRlF6Y83hi5A6qN9nuz6yfChm7iWaNgY7NNwzv485Zg/QL4rer6L1C4wMXW85w46BGnCx3rctV/EvWIrAOmyacOj50N3iC7PV/GK7ZRP8xU7gkYVva6WisjV60x3e/CEa1nDygRW3FLrFOO9f+0uIXTyBb/Z0xKfx/pHN4a8mNQbVR87t+L3we/CZRJ+oEfZ0+ifw0SsUectk8nFT/3sWrApC1HXXAiuzMzfbJurKzIkmxIuRLTRGJ7Qbm3HmMd2/wDNX8b9QObs0j3rolI8w6/mEZeK0PwIyctcZjOn8/QVmfweF6PxTLRP4HjOftHe35ZZHBgmKVttJFUehqZSNQYdsUw8TsCUX65y6Zpag==
X-Forefront-Antispam-Report: 
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	y6XYf/LrWObUkAHhvGOFvERQrv6Hl9DK+xj37dICZB+B+lxt80rYEwq2BKrXYIQoYuQnp5qQ4cyWGb6OwyweZUvcDzyj5QtonKiplLWWjOccUv6/LEiz+WTeYBz8MheZGAa5cCkdqJQYbZIWmKLFwcqElGVH0wp+6sIwZsHcu4pFaAqrQi3W4gpkAqAB1MrnLO8f+sGpzvSl/XGlVdFZPayMrHVAI9QuT1nfYYfpJu3qUqbUc0AyMsdCmVsid14wZleg9uWO/dB/bmoHn6o/qabqMyeWjIh32kEikaN3flEv0/BExAGeZwoBW+gA3N+FKjk/y1/Da6aw1vyJVgttySxSdZqoFk00tUGIYS7i088q9BsgMvfCIHrE0B3rNcrDHcdxZMNNWK687wO5ygkWAUad4sXp/B55m2DWKtdZCRp6VsHkkWHV8Yo+xouSPL4i
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:14:46.2589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4095ff-184f-4bcb-ef04-08de79485e7b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11133
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 03 Mar 2026 17:15:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3320

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 recipes-security/fscryptctl/fscryptctl_1.1.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb b/recipes-secu=
rity/fscryptctl/fscryptctl_1.1.0.bb
index 918e747..4c9b99a 100644
--- a/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
+++ b/recipes-security/fscryptctl/fscryptctl_1.1.0.bb
@@ -18,7 +18,7 @@ do_compile:prepend() {
 }
=20
 do_install() {
-    oe_runmake DESTDIR=3D${D} PREFIX=3D/usr install
+    oe_runmake DESTDIR=3D${D} PREFIX=3D${prefix} install
 }
=20
 RRECOMMENDS:${PN} +=3D "\

