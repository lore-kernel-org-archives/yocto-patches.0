Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF5CA0EF4
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.89])
 by mx.groups.io with SMTP id smtpd.web10.2784.1755554590492194979
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=nlPQhULl;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.92.89, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJQNS6dtrguGFe7FoQY6g225rfB2+sLVkxVFf+jOQ5vo9XD9iY9S1+wxGwvTf/4mFI1nGvTbHksZSYQ5TDq1/CXxzwHbkdm+d0P4fctC/OJIeUU2vTnVKLahdwAcqcn3rBN0wRMxBGhOYM8KPg6FqFjqXBA0FrkeiYnvm0Jl0It87JcUEbqeRgn+NMFpTInrrXMtkoZDYnDFLaPO5HiDUpEszWqrNC2uiZpH3xmyc5MNaak/gsiK2dV/mwQvbUmsdsFvKIO0PEPR8W77U3L43+TS9WjhJ9f2r5D4FAn8tQIjnIntWXtmzaczoBVI5x7G+B+xnRcm0giy/F4zmdpgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=ab7jmNsJ8XAeqniHvR3Zi3SZ0HAEmk2wSmp7SbFbygJtTLLEjd/c6Y03ANu/ncNd9ms9J5zgo9Wz9CmSzeRfdBZN8HUFatdc7kyE9VyepG1ztJBveIJXWLTFK1H6YIdzTPliAZXkLjYlPIvIFvAUzwLx79x2pn//vt4Wp1vn52HGo5VXkl5MCvOMPtJPlTalN50crQJB7ryy+8/t3wwZBXwibf0vEhbvIIs8dkFQ/2077T6pf16gmId41Exd2e0Mw+312GxFHLAR4kvehwY8iJEwfI3BQP0AFpGEnLOTms6XBpGObySMNUpYrKNkj+wWBLnXCN7dXFxrMPp/4M13qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBjCUjK6nZT5h/0AN9PNqd4oGkWuobN6m5FuQcEh9MM=;
 b=nlPQhULlmYZX2uhmC1u5IsjS9uC5y15BtoYy/HAWWw4EKlmwOaQYItpfYQPbTgSZun1DzhLOPDEAprEp8+zu8XUFT85ko3Kw8vAiwxJwE/3uGoyrb96WVpdwjAMee0FSKAwiFXOS5hO03sNqCERzEIO4Xy5Xnmhmj/pg9yXGZfk=
Received: from SJ0PR03CA0194.namprd03.prod.outlook.com (2603:10b6:a03:2ef::19)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Mon, 18 Aug
 2025 22:03:06 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::cd) by SJ0PR03CA0194.outlook.office365.com
 (2603:10b6:a03:2ef::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 22:03:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Mon, 18 Aug 2025 22:03:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 15:03:06 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:05 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 5/11] zephyr-qemuboot: Use image artifact file in qemuimage
Date: Mon, 18 Aug 2025 16:02:58 -0600
Message-ID: <20250818220304.2300436-6-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c7f267-93a3-4a90-a607-08dddea302f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WcwowXxgKbOk7HkeWQjgrtNUGOCUBj/WLljT9YRF98nQzCbMUMPqfBjzyuNi?=
 =?us-ascii?Q?pgoi1YK/YxE7gYCm6EIb2odyYiJeDKubRKxualAL1P3kihG8YXRiSwBDrdrY?=
 =?us-ascii?Q?Pg3U+N4WcWGgg1FLNbDe11xUsOInnVo9QozlOjGppp0ju70I4krXGSHFNGh9?=
 =?us-ascii?Q?NL3FUhiMJbpXkHc7qv8PNg0yLSiCwP9bsQVMv6P5OvRdbhWn89DjjFtiO+51?=
 =?us-ascii?Q?lSk4/T+gaOH63uHD9NRwYBtCKJ5bSLelDrDXbHchRsCw7P1QhWavPr5s8ONk?=
 =?us-ascii?Q?wAtpyak911OSCV5wGy+kDaY0II5wkJMN2egEwL+gdmCnhh0vYN3rCLL2IxBB?=
 =?us-ascii?Q?ZxeK1hWVl+VjgYVeGE8X/6YfQdkq82yu4qd1qWBmkUvxhmoQplRfgUXHW4kq?=
 =?us-ascii?Q?n1BpWbtxqmN2rjMN1DaC2VzVY0ymC6ga4oqxwU9/sGWh7sFPZVtCW6yD5/9G?=
 =?us-ascii?Q?dd6pT+o7LC74s0MmVIizLjwhsmEwHvCWmYbYAOJiIM4VzZS0JePCZbqnN8ar?=
 =?us-ascii?Q?nOGReRglx6UcEb98tnuU88uAhFDeKqc2eVWqthRVgGaoO69YCygSc/1MnbUJ?=
 =?us-ascii?Q?4WcEUHk/52aQ2/YR6iXegbH5CX2zGRLVW1jwx8eiCL1S1aOa2bHlintg0kNf?=
 =?us-ascii?Q?D/3vbYremdynKluqbsNiW/B+MBdeXWfjC8QnIkPMIQvqLWN9oAvItlOteCaR?=
 =?us-ascii?Q?SdSaqCBnuQ+8G9bqTzQUXVAfjfQZXOHtfKOrhGjn//RZpnaHpGpBA5k2Uy+T?=
 =?us-ascii?Q?7Nt+l5VkcTDXmVLalvpSbvt1aKkfyv1ce0k3mwWiO3FQAYASH2q2hjBM7xWQ?=
 =?us-ascii?Q?tu7tDkvT2aJxfM7EADQB/jfmeAL4MwzNJP22AtCmp2e6sWV6OoboHWo51qZT?=
 =?us-ascii?Q?AKal1FrTNAs3u0F0VRPwIHqYGk+Gn6RhsSOZSH4IGCjUb8EbwhP8m2LJTir1?=
 =?us-ascii?Q?E8dEApWW0U2+W6A54f/nZq6rTXuvEbXLtE1uJYw8ZIzExdI9XqLOUnvBZn2g?=
 =?us-ascii?Q?kwuTiuPvL9Cm2rAIq3Y+x/z9HO+Q+rRD9t1Z3Us4RFT7oEhi6ImkMPDe9s1L?=
 =?us-ascii?Q?P95GQoBwlVRbfq2nThP7Hg0JL76VgNhWGj2b2bqjqz04HL+hqQLAGoLo3JgP?=
 =?us-ascii?Q?dwHgWZz6TLQJiTkJh0tiaaBrF16YW1QOgnemKA/me12WKtG6Gb6gY4+oqbi3?=
 =?us-ascii?Q?HsUy3WRygJkfraqJaJm7Ft/tk72pcrGMjFzLely1Y3GGyuj+D8N4khKF6SfN?=
 =?us-ascii?Q?ZQ9sLKdDPC2xDL/WIPHJcyPU3agOc06QdxpgEkb7FsvYQAG/mQK0NP0g0k8q?=
 =?us-ascii?Q?qKZcYgeNDft4gq1a+Mu7S2BwcV/9ZQgO5Mh4ByxkYX4r9NXV9o6XSkenZ6se?=
 =?us-ascii?Q?Md4ctNg/sJpkvBpWfF/GBJ1pUUjLzvEovyyF+FMY8pybkqd6/H6jI8JHDpih?=
 =?us-ascii?Q?Y0gTfSY1FLIkifPBDbCz4W0AfADpS0EPOhSyRwI9gyk+2fgISYc4W6eV8xWw?=
 =?us-ascii?Q?OsqLkEx0Pp3jnLferWkRHNrl5WdSVNzY0ITJ?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:06.5691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c7f267-93a3-4a90-a607-08dddea302f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2041

Use image artifacts output file in qemuimage link.

Before:
zephyr-helloworld-image-{MACHINE}.elf -> zephyr-helloworld.elf

After:
zephyr-helloworld-image-{MACHINE}.elf -> zephyr-helloworld-{MACHINE}-{DATET=
IME}.elf

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass b/meta=
-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
index b45e6f6..ab0a281 100644
--- a/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
+++ b/meta-zephyr-core/classes-recipe/zephyr-qemuboot.bbclass
@@ -1,6 +1,8 @@
 inherit qemuboot
=20
-KERNEL_IMAGETYPE =3D "${PN}.elf"
+ZEPHYR_IMAGE_BASE_NAME ?=3D "${PN}-${MACHINE}${IMAGE_VERSION_SUFFIX}"
+
+KERNEL_IMAGETYPE =3D "${ZEPHYR_IMAGE_BASE_NAME}.elf"
 QB_DEFAULT_FSTYPE =3D "elf"
 QB_NETWORK_DEVICE =3D "none"
 QB_NET =3D "none"
@@ -27,7 +29,7 @@ python bootconf_clean() {
 python do_bootconf_write() {
     bb.build.exec_func("do_write_qemuboot_conf", d)
=20
-    qemuimage =3D "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.get=
Var('PN', True))
+    qemuimage =3D "%s/%s.elf" % (d.getVar('DEPLOY_DIR_IMAGE', True), d.get=
Var('ZEPHYR_IMAGE_BASE_NAME', True))
     qemuimage_link =3D d.getVar('QEMU_IMAGE_LINK', True)
     if os.path.lexists(qemuimage_link):
         os.remove(qemuimage_link)
--=20
2.34.1


