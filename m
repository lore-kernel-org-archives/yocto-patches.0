Return-Path: <ranjitsinh.rathod@kpit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F7D1625F
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 12:44:06 +0000 (UTC)
Received: from PNYPR01CU001.outbound.protection.outlook.com (PNYPR01CU001.outbound.protection.outlook.com [52.101.225.114])
 by mx.groups.io with SMTP id smtpd.web10.54102.1728909845043964609
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Oct 2024 05:44:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kpit.com header.s=selector1 header.b=Rr5smC1b;
 spf=pass (domain: kpit.com, ip: 52.101.225.114, mailfrom: ranjitsinh.rathod@kpit.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JepgapV5c2oYGazbMs1Z3+5uH6Pc0rlkhcp6jw7saix0G1cv/GaLJUCLplafA2qQATAwKw1i2y+JJ2SVZdgq42ivWnIfmt+476/ZiEHRDTQCp/f6z0p0RT7Rqw/IlpVddOqSZWP+6mQGk3g1dxRGAk5UmF5pT3yvCP12fL3SHBoHeDzzEPeXuYsuxIhwoPpVD0C6bacbNWvrEw04MxnoERGFO4nJA7e03nI7zeMjRDXwN8doAkmKtOhFLuRlchECqKwt3VR+KSVJYHG1P8RUc8aOp+tMawihi74KW0LtUbauGZE9KDS7NIU/z+EWeOYqU6RYOKT5kJGuZareVkClTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAOHLiO0Q583IRmqVjQznzV7hbdO5+iHX/xDzCAntYo=;
 b=eoTKK4OctDwRxqm7rYxNkIgY6nRkxaNBHHDbDLN6hGyLkXcWW+bXBDEZ4V1c9GXy+98NlShSvirNOMzsPu1qZZtz2mdAMMAA2KK6kotPvVYvbqW0RaMIgqhsZdGBgtL4I0RtRv7zwREKRqOxDRo7HW5b/7EQWkmNJhxIT9JMkjDdyRRTqXfrTk8SsGN4nWgH/1CRYhMW0ZtfNcDZ4heBrOF0+/xpvCoquQ0euXu3/fYVvzblFQDzkr8pWMlCKA3ZwDSwecayPZTx6Q+4YpXp08F9Lp+SH0qFmq1QGQCMv/wrW6W7QjiifAlrCPRBcGOrzBdYjqVFY6FDsWSE8k9MUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 103.243.227.16) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=kpit.com; dmarc=fail (p=reject sp=none pct=100) action=oreject
 header.from=kpit.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kpit.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAOHLiO0Q583IRmqVjQznzV7hbdO5+iHX/xDzCAntYo=;
 b=Rr5smC1b7tddqpiKjRII29E9GSQlrivNoTJQp8ZNLAKOVZD7L662j5i5TLZhXBgQx2t321o5ghKoM9RkxkOC/8TAaeS1mbqLVRIqxdSTvu3NAek4kd3XbQWYpjpQ2lKEbJUSIQ4BY2ximhUKxH/Kvf3J3JbXEKc0tXyQpSWCVXI=
Received: from PU1PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::15) by MA0PR01MB8771.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ca::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 12:43:59 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:15:cafe::97) by PU1PR01CA0003.outlook.office365.com
 (2603:1096:803:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 12:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 103.243.227.16)
 smtp.mailfrom=kpit.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=kpit.com;
Received-SPF: Fail (protection.outlook.com: domain of kpit.com does not
 designate 103.243.227.16 as permitted sender)
 receiver=protection.outlook.com; client-ip=103.243.227.16;
 helo=mail.kpit.com;
Received: from mail.kpit.com (103.243.227.16) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 14 Oct 2024 12:43:58 +0000
Received: from LL-1259L.kpit.com (10.52.130.22) by PH3EXCH01.kpit.com
 (10.52.16.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 18:13:56 +0530
From: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 2/2] rust: Use CVE_CHECK_IGNORE instead CVE_STATUS for kirkstone
Date: Mon, 14 Oct 2024 18:13:30 +0530
Message-ID: <20241014124330.155888-2-ranjitsinh.rathod@kpit.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241014124330.155888-1-ranjitsinh.rathod@kpit.com>
References: <20241014124330.155888-1-ranjitsinh.rathod@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.52.130.22]
X-ClientProxiedBy: PH3ExchFE01.kpit.com (10.52.16.111) To PH3EXCH01.kpit.com
 (10.52.16.25)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|MA0PR01MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d4794cd-002a-4e79-899a-08dcec4ddf51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?eepqpFWG+Xd/kykOF/fLCG7Sq3IF5jTyIF4h9UsK57X20YmJH4C29ZM/3ssh?=
 =?us-ascii?Q?/XFN4M7XJmsC6pigQiTD+la8wIEYDeohAo5Cmdj1Z3Gzd22CpQPPhxx9G3gC?=
 =?us-ascii?Q?rGf97vjiyun7bv66R1rHaQg4gLumaE9RUhCoFKa9akgOf1KSns0bmczlR3rK?=
 =?us-ascii?Q?LnE55+2VFbR03IIIKMPVm5M6Rukbdw8fRHzBx2nm8nnMF1hqGOToFkKKrnOs?=
 =?us-ascii?Q?U1uqqRvFQj7/fx1sfurMiHSIwMOsN97GCCdUTkx1QNhQKNCPMWlTnjSPSaAc?=
 =?us-ascii?Q?yyyxx5mMfG9+pwPJYN9DJbqfQI9OkXxaGQ9xD3PGbdZ3FVjt3c5mwfX9AQWS?=
 =?us-ascii?Q?OVRxqr++oKV0MWJbjOGAgwx+MHnr7QhyLWOuwcrGij6JCBJO9dlhqtv/o0UC?=
 =?us-ascii?Q?MtPafiinsuqQLxUg8FIeVAPS+qjhVkFnM6m9Afb9iUc+QihaRYjnUH8KzeSX?=
 =?us-ascii?Q?HX1aaFocv3Et88UaR8cK4H6zPEcgErAITkGgz23hB6xmxtviEs6mXqJANhEP?=
 =?us-ascii?Q?VUviEXfbl85f5wwjCmJ2ErWWkkpxTKqzvC7Tw59dEcuUmu1numbSG3WWon7d?=
 =?us-ascii?Q?umI3CQIvmC26kKTQ0JEhmNraSTTOJcovqzK2DdQDIFob5iyo3qxpURmLB3+i?=
 =?us-ascii?Q?j7gqks+We1z7VMDNNRWrpg5eZZUd9QE+ZNIDHnYSQI0TBSGzDbJQYZEV93N2?=
 =?us-ascii?Q?C6pKQwc/wx4G8sgwllRe0IojmJ+OEevXgIfPYWFqSp+zUHpQg3uOigsAnqYp?=
 =?us-ascii?Q?+aYdLEpBHIMcfEq16H3xBQytMYoFbwbk7Q12Gym3ONv/bKunxLvjbysDi2bu?=
 =?us-ascii?Q?QC+Y6kmyfHjjShicgl4VSzdXAYJyiKVSplq9J913Q3jrjUc9hC02HvBe4ag1?=
 =?us-ascii?Q?D7jrKme0WvcGFu8aBBOCA/odgyR3t/WycAJZjWFzDPQnh+v7fBbI2SZ1+Inc?=
 =?us-ascii?Q?YJt0nsazLA1xO9ESSUSCu7y1WL6KnevvIhrMgLdySgGzEPL/l3q9gWOcfLCc?=
 =?us-ascii?Q?4pX0BSwuannnwqqJQzs5mg0kI8JczyM+i5l1L0/z+gsO2iUPVaQ3sAW7Gwtk?=
 =?us-ascii?Q?YIMDyuWsBiwn39HVzUDBqFUw0PSqTCKsL8Hr5qrvwf7MI40VOPun/tOeDsLs?=
 =?us-ascii?Q?O9EjB8qjj8VpYnmSNPoujr0BmNOhOirWn3Ke5VDl0xB1bc6L0eT33A/Kqnf9?=
 =?us-ascii?Q?rYIW5po+mC1U4jH6aDMIhjdXpfiUSKpC3N5212qbnNog8A1JXG8Nh7DVrU8a?=
 =?us-ascii?Q?Df9nqEfV9RyhYRdwwb9jJq6O3puKcNM+DLkZ73MM5q2pqlwwt5GisZsIwFws?=
 =?us-ascii?Q?CojPPepLdMH36ZCZEGcRyCep?=
X-Forefront-Antispam-Report: 
	CIP:103.243.227.16;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.kpit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: kpit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 12:43:58.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4794cd-002a-4e79-899a-08dcec4ddf51
X-MS-Exchange-CrossTenant-Id: 3539451e-b46e-4a26-a242-ff61502855c7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3539451e-b46e-4a26-a242-ff61502855c7;Ip=[103.243.227.16];Helo=[mail.kpit.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8771
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Oct 2024 12:44:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/704

As kirkstone uses CVE_CHECK_IGNORE variable, we need to use it instead
of CVE_STATUS to successful ignore

Signed-off-by: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>
---
 recipes-devtools/rust/rust-source.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index cb405b7..7a2bbf1 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -18,5 +18,5 @@ RUSTSRC =3D "${WORKDIR}/rustc-${RUST_VERSION}-src"
 UPSTREAM_CHECK_URI =3D "https://forge.rust-lang.org/infra/other-installati=
on-methods.html"
 UPSTREAM_CHECK_REGEX =3D "rustc-(?P<pver>\d+(\.\d+)+)-src"

-CVE_STATUS[CVE-2024-24576] =3D "not-applicable-platform: Issue only applie=
s on Windows"
-CVE_STATUS[CVE-2024-43402] =3D "not-applicable-platform: Issue only applie=
s on Windows"
+# These CVEs are specific to Microsoft Windows
+CVE_CHECK_IGNORE +=3D "CVE-2024-24576 CVE-2024-43402"
--
2.25.1

This message contains information that may be privileged or confidential an=
d is the property of the KPIT Technologies Ltd. It is intended only for the=
 person to whom it is addressed. If you are not the intended recipient, you=
 are not authorized to read, print, retain copy, disseminate, distribute, o=
r use this message or any part thereof. If you receive this message in erro=
r, please notify the sender immediately and delete all copies of this messa=
ge. KPIT Technologies Ltd. does not accept any liability for virus infected=
 mails.

