Return-Path: <ranjitsinh.rathod@kpit.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA6D1625E
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 12:44:06 +0000 (UTC)
Received: from PNYPR01CU001.outbound.protection.outlook.com (PNYPR01CU001.outbound.protection.outlook.com [52.101.225.116])
 by mx.groups.io with SMTP id smtpd.web10.54099.1728909839833402677
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 14 Oct 2024 05:44:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kpit.com header.s=selector1 header.b=StkwJUOr;
 spf=pass (domain: kpit.com, ip: 52.101.225.116, mailfrom: ranjitsinh.rathod@kpit.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjD4AyUlABwErxquH1yIb5e5xQ1VXOT8ChTqqnaOGwDYAHAouaQYor6/+6qA2wuV31BggfjRabOX93l4uXwP8ig39LeCMYZmX2IpdT5MtxXmQczsxTJkqUMs8CUm8EiqZoLfdNrvT+h0S21M+TcgWL1kGo8fiFghSUH8hy44JzflXBKKdMR8wzeSeogEDs3z6THnycj/QrnudRIgdvMgyIhVHs1b34QgXXcjgUGoEQ0UHPi+P8fFBqemx0YjMwvYK9hw7zkeV5gyqYxN/SJBlkWBYvOH5tCi7meoW5J6YKItn6hxRZRaGUp4EDMZvKNDGZvq/jb25R+FQZ6ZUp/7Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMW7hKYXverMf1PTd+mKv/lD9MEGw8rh1LS5QD8qxfY=;
 b=XOnd249Sm9V+01rAYvwyZuo1y5Aw7YIuEJrE4mGOO5Y5C4X7xwE9muEoLXiCkA9S8n68RE4ag2Uu8yWPstYFaKa3YYaXn4mIimVqUT2ocnAVvfKOKAIarGUiYlatrfwKzh9WLk3dz6q2DgHOMxs+ZRKRTL3jXFRTiOjmkG2SpCGoxEPtFa5KuAHviGClnupVaCogDtJodkjXJmi9DPE42fcTmizhj8zy7LRhpqU5cnx1ilCQO/Tj1cmMZxS3h318Fk2Mr40VMumegBjq5bF5NtHui9dhnVhFRZDdo7zi4dj1AC4tqHW46sNb87HeTwKCdy4WOulsbKGP1y0slJaMag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 103.243.227.16) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=kpit.com; dmarc=fail (p=reject sp=none pct=100) action=oreject
 header.from=kpit.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kpit.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMW7hKYXverMf1PTd+mKv/lD9MEGw8rh1LS5QD8qxfY=;
 b=StkwJUOrnH1MSpdET81h/dPclQ8xc+t/i+1RK6Fwr0Sv1nsy9/Dz+OoQAHmNVXgs3FRi30uzHqNGG7OJqcq36sGo1AHdgui5GEP9tpYQdIh29E+fnrukf6PABIVb2fHG18Grikc5pue4vsPXWgzpCX9VgTEpNesmWUfGsdkP+GY=
Received: from SI1PR02CA0060.apcprd02.prod.outlook.com (2603:1096:4:1f5::17)
 by PN0PR01MB9301.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 12:43:50 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:1f5:cafe::38) by SI1PR02CA0060.outlook.office365.com
 (2603:1096:4:1f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Mon, 14 Oct 2024 12:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 103.243.227.16)
 smtp.mailfrom=kpit.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=kpit.com;
Received-SPF: Fail (protection.outlook.com: domain of kpit.com does not
 designate 103.243.227.16 as permitted sender)
 receiver=protection.outlook.com; client-ip=103.243.227.16;
 helo=mail.kpit.com;
Received: from mail.kpit.com (103.243.227.16) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 14 Oct 2024 12:43:48 +0000
Received: from LL-1259L.kpit.com (10.52.130.22) by PH3EXCH01.kpit.com
 (10.52.16.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Oct
 2024 18:13:47 +0530
From: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 1/2] rust: set CVE_STATUS for CVE-2024-43402
Date: Mon, 14 Oct 2024 18:13:29 +0530
Message-ID: <20241014124330.155888-1-ranjitsinh.rathod@kpit.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.52.130.22]
X-ClientProxiedBy: PH3ExchFE01.kpit.com (10.52.16.111) To PH3EXCH01.kpit.com
 (10.52.16.25)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|PN0PR01MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: f627190d-1684-4680-8497-08dcec4dd9ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rVwU2V34e2qBOOZtXrOTpSR5dtJ52sniYuyE2660UV1apCwFveQS7FH2BryJ?=
 =?us-ascii?Q?a/zofP5yvMSXDMYx9ut5tcuq9tasHSNQqegDBCZXyR79TUNCNKuKE4kOd0V9?=
 =?us-ascii?Q?cpQCulOXbk4soA4rwleEy3x26xdUcn/5WJQr+O3zyh9k2CXUY52iDBw3Af0a?=
 =?us-ascii?Q?Z5dwmkBScYK9ekyxbtXoKNlCoUw9WEKU6awIsj6nedERdyMnlUDT6mGIDB9S?=
 =?us-ascii?Q?TBordpy5PAIelZ3B/8nQcSHwcCwgox0ggZ741xI3I7oDNFGwVvriWFalk25/?=
 =?us-ascii?Q?S/y1Sh6qY4lZZPd6QB5LtbMtut8yTbeA1k7FjqobLO2o3i444QKh13y0xsYz?=
 =?us-ascii?Q?zpf81Pm+BnQ4v2Z5xV+K6u2gaFEKyUnyUvtktitykHQcgEHy1GcokmLLzeq6?=
 =?us-ascii?Q?UpZhz80QnMIzTHKoKtXlWzPLNUf9COY/FYbomp/BR4dIsDwK6reqGghK4F5g?=
 =?us-ascii?Q?qD5zkarTnS20hAb98YbTtklwYVGOwc5Xij5XHXmcYS8nigR6CoeD6nln9Rqd?=
 =?us-ascii?Q?lYvpukAFRK7zgw9Jg7mxiorlGnxXhcmtpPrdBYABCoAMmrtA3Tqu+8ug63Q+?=
 =?us-ascii?Q?LreVRldz4zlTJSrxVpaTgb82+ZHL1LBdaCVpFUjzlYr1oV5GZS/rWZyOUsTe?=
 =?us-ascii?Q?OKOXeSnXueT/a6TZGxuTEEsIL3iGVpsxitvahbbEpuci86P6SQnCcLxFEEB0?=
 =?us-ascii?Q?IzOnCEpkQHq5HlBM0mFv3rRn3dhrtbRD5k+5TxwZJUgDhpKb7caf9LnoMTNO?=
 =?us-ascii?Q?ZRaRv5NAzCPUQGGif1Hnt25o9k5iFlh4QlW9Bk+KbcTGDErKoeVOWuv0xi5B?=
 =?us-ascii?Q?IVzFupydPwkz4rmV20bbOsj8cFBNWMwyBmrAUPDUhrLAyYkcfZZVHzLAqcuY?=
 =?us-ascii?Q?agkY1UWD8eMnorb++jJDeILH6MlGt0ezUxY140bVpdvpLe9B+P8VHx/MfuHC?=
 =?us-ascii?Q?OW3Shv5q5SGu5nqM6t0rAmLt2UDJnXKgmtQ4qTd+/AwNZ5RhzvztrP/UeQsj?=
 =?us-ascii?Q?mcV6tqbKJLeNIVpimiX+7dyVcyKVufb61SJV03G9FxY9htcXkhIi2AidqBNP?=
 =?us-ascii?Q?bWRDz6bLS6L78hQ+Yib7BMwaw59UB4YdE1fbyVK/OkRGz+2M0XeB6knVM321?=
 =?us-ascii?Q?O2o+VGWQfA7OcCyuZdu9fdcHVErxia5KpS0BuiBU3sFYOy3TZNDJGtLpQJm0?=
 =?us-ascii?Q?28u42dDgnMleDt+15ORM3zGKTnDR1Y0eWuhh42WF3YVb+eO+4EUjCKbLnjzq?=
 =?us-ascii?Q?2JFGTw3YCQh7tNyn0qfXedt5WpC8fzCHh3t4r4RSBte3RA1Wet3K5Y8sbyVW?=
 =?us-ascii?Q?mr+MONS826735EEYQixDzlrH?=
X-Forefront-Antispam-Report: 
	CIP:103.243.227.16;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.kpit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: kpit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 12:43:48.8457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f627190d-1684-4680-8497-08dcec4dd9ca
X-MS-Exchange-CrossTenant-Id: 3539451e-b46e-4a26-a242-ff61502855c7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3539451e-b46e-4a26-a242-ff61502855c7;Ip=[103.243.227.16];Helo=[mail.kpit.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9301
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 14 Oct 2024 12:44:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/703

As per NVD, this CVE only affects to Windows platform
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-43402

Signed-off-by: Ranjitsinh Rathod <ranjitsinh.rathod@kpit.com>
---
 recipes-devtools/rust/rust-source.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/=
rust-source.inc
index d0bc899..cb405b7 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -19,3 +19,4 @@ UPSTREAM_CHECK_URI =3D "https://forge.rust-lang.org/infra=
/other-installation-metho
 UPSTREAM_CHECK_REGEX =3D "rustc-(?P<pver>\d+(\.\d+)+)-src"

 CVE_STATUS[CVE-2024-24576] =3D "not-applicable-platform: Issue only applie=
s on Windows"
+CVE_STATUS[CVE-2024-43402] =3D "not-applicable-platform: Issue only applie=
s on Windows"
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

