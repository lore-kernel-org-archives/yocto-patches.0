Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F4ACA0EDC
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.41])
 by mx.groups.io with SMTP id smtpd.web10.81597.1755020522887762492
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:42:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=YEdKTefe;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.41, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QezZbMRR2zJXSle+/bR+UZSZabD9clMtdNQN5MNLLl1sALa+6kJQRiqFxskvRwoWM9rQ5d0HfJ0JvaAaggXixXs1jycD+Ga7vvJgxIfe6VbWvg2F8BoxmpQxYtxLpYdTPGEpHpSSNfiXwtL+6/ewx3PDcsd6eSrDNhdDvCKl4ehPY8ed4DqcwRu8jZd7mNeYPvVGQ1Y7txxUwMb7yAL12h6RfVmmbGg31XudPryazQv3TmFcUx1fB4r2tO3A0H7gtncN1mKaPHJstVP94FzlTEC+HaNG9vhnb0Oy0g+mmKt04tmbN43XOz52YPPGT6QJ+vR8xi4FCh3ggaYocC2drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=bNqgIyak2NDGD3bb+du1slGXEhrLPcQtTRxVTpTiivcs7Ohjx6K6ZbX5gSvDzh07Cdk7eCg1+aAtM1r/kH6IiY7tPfkG+TzlKZf6Xgw39RXpLKpgOsgYsatYxyMvRNO0D5okEF0j+vWzFTmu1828eNUP3yp9mn8Fmw/nellBK4ocjSxEyUwAWHpYexOi5vT3t/DsCPFKzrj6HmLoBCQkGMeoAMH2VryPBDeYw93pYl88gRFPQ3EoCcAOBxQg5KcWG1M69uFQfHUh8stHXkQkGd93OF0YfS6UbLEs8CBVbgNHB1uiNKiU42PcKaXMizjBUc9oATLjWSsmwvWoDv9BSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSrrUwwZtPcjARKqu9O7gN5MoPF5xw6FJeRM92CQQFc=;
 b=YEdKTefetfHqEtI/5uGx2YI2C7PoFSQHn8VcVL39qZenZuUhyJ4JIsPD7OSWKPQxeGjT2o4eQO2QOq2WQgXWgCUpttZh7YG04g5cqsSFPrPtArk5yRIqxA2LNAZlT6OYIvQnQzWW7DvdrDXPYRCWApPsa/sqCjDcWE76kRWfasU=
Received: from CH0PR04CA0099.namprd04.prod.outlook.com (2603:10b6:610:75::14)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Tue, 12 Aug
 2025 17:41:58 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::d4) by CH0PR04CA0099.outlook.office365.com
 (2603:10b6:610:75::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 17:41:58 +0000
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
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:54 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:54 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 5/12] classes: Move classes to match bbclass scope functionality
Date: Tue, 12 Aug 2025 11:41:40 -0600
Message-ID: <20250812174147.130972-6-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 95aabe86-ac52-4fde-70eb-08ddd9c78938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0bsonUGYW7PnuS8G9LjZ5YRbECEUIkc6Y0XsgfDl/AgTHWtpxPNp5TQVEIfy?=
 =?us-ascii?Q?7hPR4TkxIpGBzh89uuORG9C4r5RMlIDr2EmH5NX0Zgu72Mf8VmlZn4YNtPGV?=
 =?us-ascii?Q?XzXZNl7i3dgCns5FK5VYk3pKb0/QSppk0/8YQm0Ataik1nN6ScsZNlT0z8xt?=
 =?us-ascii?Q?zRCak79ZnZbtGm+Gylr3yiTASxFKaeOKJKVrCnwokVZAPFdp7p1G5y49+2/p?=
 =?us-ascii?Q?SHqWm1R4fWdHuneP60Q8MFcyIK653v3B4Cfr6ka7QPR16bYFIWUpHWLBK5AK?=
 =?us-ascii?Q?hScU0yzu9BEWLGRo67pixK6Vbf6MvKDaH1EABbnZNyk9yLJ///snvLexORy9?=
 =?us-ascii?Q?VPQm6P0kFkRf33H9Ppv/t6v4VLtGuKMQqMLhf/0jo7rB5ASrbfO09enZeq4n?=
 =?us-ascii?Q?g608AS/QNSgQsOUaCZQTWRx0c1W33wD5NyzX4cHQ/adxmz81vMcoZtqFFPoY?=
 =?us-ascii?Q?4v/IR3PHcHUrm2UyeJnR+WChjTiILxYFs/NRruJPBenJcxR1FDTaXHpm9Bvg?=
 =?us-ascii?Q?1TzaZm6eFqeumATW0PwZC8v2JuDWuMsbuN8WEvLXXZg74Nnq/9zeHAnXloP7?=
 =?us-ascii?Q?C/DzdQQi6qNgx84sXW6Hdnowex/1h9IC1/ru6zOmk6PHG505fYfZkRfDPJmg?=
 =?us-ascii?Q?Di8Y+rNi2mbHviOFQSrLJLryH0GdpKDivogt8NvgmtW9UiwMqDnug93z7buh?=
 =?us-ascii?Q?IgzVNNkrHT2AJ8vntzvMghSl4u1MD+UIniypocphuoW1Q5IzcrwqIXFbt7c+?=
 =?us-ascii?Q?s+t4pxxMWOJu7xy5mMR7ylzrA0GSUGIT/o/nC+ikE4dPgKAYkKQzp1C9CBpv?=
 =?us-ascii?Q?r4PZXT5TtIPgIYqKWNuBgE/pRRopDsU310jREuVSxRjmoCxssLB8t3ARKD9O?=
 =?us-ascii?Q?elsujZaOff+blUGk2eLMoAal/Ny15+jQ4yskWwCLw7aHykzxNR2mLXhCAafo?=
 =?us-ascii?Q?6a2XJUHtz27WFrjyCMRl3OqQtvt6M0xOE2AvXatkNke3hi20SadKovx+xKIu?=
 =?us-ascii?Q?7/iw5XBLr+gD8SWStoWMxA6I2Uz6tIDkC5TC3aQq8HRUEEZ4Up9uo+VNhf+l?=
 =?us-ascii?Q?dSL+6+tJtdLPd8rhFnwbIlO1aYCIlL4wAfE9chQqs1rpTsBiNmQ6dFXCZvL/?=
 =?us-ascii?Q?Cn3d3DbJTsxZFpmaPA/jsbgoxj+Sjm4Y6Nz5aNlxEjOifufzLURT5pnMt0T7?=
 =?us-ascii?Q?7JK2FYo9dvw4RwVNwwkaWQX2+vme69VtehccysmYT+HHPk8Dki5n/qzUxGpi?=
 =?us-ascii?Q?v4FUpEB5qCmSPoNNqvFVapLQ32maLK6cE6skwOkFc8uS8Qvz4IcX1TRfxiWn?=
 =?us-ascii?Q?1xKnibMFbNTMIvBG8G5ybaorQJoIOvgoJcV7q1aykSwJR6F5tF5i35rAMRKZ?=
 =?us-ascii?Q?4UIMM256yVG2SV98qGwvnMRPVuaScUuecjYD+FWiPOfY9mcReVYeCv0c49/1?=
 =?us-ascii?Q?ZN68pB6JzUc3qlmaaxqrXCxVDRHPCoaZD19C7+5t2prxrr2B5ypybfQ7G9zF?=
 =?us-ascii?Q?Jokg1LcTNXXZgGAvzJ7iArdAb9m23hZy40ZA?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:57.9831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95aabe86-ac52-4fde-70eb-08ddd9c78938
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1971

Move classes to classes-recipe as appropriate to match bbclass
scope functionality.

zephyr.bbclass, zephyr-qemuboot.bbclass, zephyrtest.bbclass are
inherited by recipes hence move to classes-recipe.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../{classes =3D> classes-recipe}/zephyr-qemuboot.bbclass           | 0
 meta-zephyr-core/{classes =3D> classes-recipe}/zephyr.bbclass       | 0
 meta-zephyr-core/{classes =3D> classes-recipe}/zephyrtest.bbclass   | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyr-qemuboot.bbcl=
ass (100%)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyr.bbclass (100%=
)
 rename meta-zephyr-core/{classes =3D> classes-recipe}/zephyrtest.bbclass (=
100%)

diff --git a/meta-zephyr-core/classes/zephyr-qemuboot.bbclass b/meta-zephyr=
-core/classes-recipe/zephyr-qemuboot.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyr-qemuboot.bbclass
rename to meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
diff --git a/meta-zephyr-core/classes/zephyr.bbclass b/meta-zephyr-core/cla=
sses-recipe/zephyr.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyr.bbclass
rename to meta-zephyr-core/classes-recipe/zephyr.bbclass
diff --git a/meta-zephyr-core/classes/zephyrtest.bbclass b/meta-zephyr-core=
/classes-recipe/zephyrtest.bbclass
similarity index 100%
rename from meta-zephyr-core/classes/zephyrtest.bbclass
rename to meta-zephyr-core/classes-recipe/zephyrtest.bbclass
--=20
2.34.1


