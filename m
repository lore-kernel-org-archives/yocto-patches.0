Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B4FCA0ED1
	for <webhook@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:22 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.68])
 by mx.groups.io with SMTP id smtpd.web11.2753.1755554592508744699
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 18 Aug 2025 15:03:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=TQhxrPHH;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.68, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HiAopGgBo0LSRCUqbVTpw10g2qvomBzsAPrwk99c1pPerjrqdew5ch8QB+34sFcekXEoTH0zdCrnpoSKP4DWKLIWazOvhFiNezpb994FJskdO8WTCGUrcYJwCW0n7cw8xvxuTWbAg/CwaUUH4J+vf7UczgrZoF0CDhHmKifEZ71vXBr4l0P+fp84k7CsqMEMeq53JcW+0Yb2VrvkrVYV4mPY+0iI1nyHoO9uCGQ7eEHpiIsph8xC9XVXEh27p0oR9a61DrbLUV+dGj50abaXuIAaEnu74AUEsqFSgCxGSRsrWgQU7zScoapYpJfyr3/ViJn0ck3tuFB/gMTDm9P3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0v1+7PrV5cYc4kqLLRPw9UGIAYS6zsfBaOL0CoePJg=;
 b=oTtb4ZqhL/rQDR+slDGXi1wuA/CNVo1qRCDT9I0cAWxb9jrCio6Wc7SEbT/B4lxIOsFT355Bxs8qMIJLoTI0/xMityfYfgHwSa2tTYehnE06b0OUq3C5ucZWklt7ARDTcQDrSBznVGZsLm4H+KdSHEah2JufTHsliJCVm4JUrCh3UJxvl6CJopLtCHEDqe/bkjU/IJQwZTOLoTzRRuTBBLXCrWwQQfmFZioepKlWJcQc/Ut2WqEOncOd7EAhK6yTnqdXdI/OxXO9Cx/q01Xv1nyT8wVD4ui7mqNf90nNQC4HIyrG744WwhwZXdkeYx+dtgi0A4eo/Yy3PI25ppgPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0v1+7PrV5cYc4kqLLRPw9UGIAYS6zsfBaOL0CoePJg=;
 b=TQhxrPHHK2Opu1dRuW3hx4jmDTi9biIHDt29//KJofUAw9MKIlYbTabkko+eNBkPoJmQJ49OgpZVK0Yo7w7yZ13YG8q6p/I49cmFcuOGxdF4v8ZjYQB33nFCklIeHQyqa41G1bEMBJHPcvorcn5rUUFqGAP0w1NSqIXix3juWhc=
Received: from BL1PR13CA0356.namprd13.prod.outlook.com (2603:10b6:208:2c6::31)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Mon, 18 Aug
 2025 22:03:09 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::61) by BL1PR13CA0356.outlook.office365.com
 (2603:10b6:208:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.12 via Frontend Transport; Mon,
 18 Aug 2025 22:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 22:03:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 17:03:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 15:03:07 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 17:03:07 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v6 10/11] zephyr-kernel: Add rpmsg multi services recipe
Date: Mon, 18 Aug 2025 16:03:03 -0600
Message-ID: <20250818220304.2300436-11-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
References: <20250818220304.2300436-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a63e8c2-8137-436f-8600-08dddea304a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9ZiybvZ5K1iorL+rWnq+7m9oobG/Omc7D7zvF/ICMLyVcgIM/XrEnCzw2tuR?=
 =?us-ascii?Q?EQxlg9px55oJ92oVNneeM8TpXxvx6S8E2xizpHaGE6uqn8KtNcuQn2wc9czh?=
 =?us-ascii?Q?OQBT7MQNOqGDJhFsTQxGH/2QpfSEU75AdYc0truluIFU9Rxh354Q26e/80xX?=
 =?us-ascii?Q?SadTl+kfPyLgd2i2rCnRRiRthYnhpcNP6BdAXgHwYYakubqSCLN/QVFQ85zW?=
 =?us-ascii?Q?5ksYnP7tx81ut8M2BSUEdRwb9wQF72o+oWBL/44E7ArhEb/SeEV44rrDP+cX?=
 =?us-ascii?Q?elWvWlHE4dCGdfwbv4RKIl/H/thIqlmdggcVXTrl+1AoLfZNkVREKAQilWjC?=
 =?us-ascii?Q?stpBlUpJSTGA11IiIRtrmOO6Svd1CY8F3kw3c8nhesJudsHDoVhNseCHvapV?=
 =?us-ascii?Q?1SDj/XfcGh3zRIMkMOpJJ4gEAdLCaxwJEXlHtjKFER3ZBsEfZ9eXmtqqjTnO?=
 =?us-ascii?Q?/zt/6ce50AxNpTDydpkc6TrkM9kr5jEbSmKinx7wrBwzsLKi/4HHDDtD+wl2?=
 =?us-ascii?Q?Qq4vas7ggx1SsQu3NqbSn2IbLDjqwMsU9MkSiYdxSxI6FnrYAWNi31TDOqY2?=
 =?us-ascii?Q?ekxk+lDReXnOVP350WJk+CCVBNwxiKz/ilJRth8KGxeeIIkjACIyu5lcFT+C?=
 =?us-ascii?Q?tYESvLmEsYJ/2R6w42oV2YRCnQwHjz5vSkhmrtJiXMk0c+njueRIWj1RXfuC?=
 =?us-ascii?Q?T1rBbEqdvueoTCeXeghYCBLLwFZwyyMOqlCEds7mvvhYfsaWbuUntGFNzVc5?=
 =?us-ascii?Q?KGnrks+r0WWiOJqe2r/LEH4uWTf/MdkbsMHEmHimlkvwPtjJRTDkdE5utXw9?=
 =?us-ascii?Q?ZSqvAnuPCQ2/Yji03cPqaHFKBxsUHHptIJ4oZnlGxN/S9tydNfvfj9iggM+v?=
 =?us-ascii?Q?uwLcGvrmaSveQ7Q8pYiy40wZf0VDXP25xMsHcmttQfjdx3O/4tOz7nZR1t5b?=
 =?us-ascii?Q?D+ugZD5TTT6sk0AE4nFHr/cUIaGAVrjxM/6TBUZZZhcHgrZ2lHpCfYHaFQQL?=
 =?us-ascii?Q?oB9WbJIw2+mpWe0GTrBa+Ys/azHyuEz+vOAO0tr3dR5rgZM+AEQwQ8G3J75Q?=
 =?us-ascii?Q?su0EISEHMedMmzmhvr1dUmHe2gj1dCJ18utZYpZDbgBjImOsmVQqXSKdb2hd?=
 =?us-ascii?Q?rXdTaZIxc437wvrOCCKkC5DaWG25Wj7MLysy+U2DMTXIvTdKT4jAikuttGeL?=
 =?us-ascii?Q?yl5UsouiLSLuIO6d6llNtjwJS7+BSlTKmC73z1BMW2y8u3+Gagu3ERVrsdC+?=
 =?us-ascii?Q?TOdQ/p8Sll5ggCk2yyvHqpGCB/j9DH2t9R7DCVP9OaEeKcScyDOmHqzn/3Ov?=
 =?us-ascii?Q?8ZhPZ6vfZjK6gVNYILa+w50eminLwrjzmoxOd38vLmiUHerHq3gzShcQOyeS?=
 =?us-ascii?Q?fY9gSNbiS51Xmr+uXR/ukvpF+16NqCHiyE6sXNAIc5qKhTD3tX4MwV8mmRld?=
 =?us-ascii?Q?p6hotgnDRgrrHT1BduS7ckbUsxax9zHEUYmeLMDou3G8PMHollVw0GQHYp60?=
 =?us-ascii?Q?OX8GUNzAgKh42yz2dHw2k6MyBYnG/rB7eBdG?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 22:03:09.5111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a63e8c2-8137-436f-8600-08dddea304a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 18 Aug 2025 22:03:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2047

Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
openamp-system-reference example applications.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-r=
pmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb
new file mode 100644
index 0000000..222ed2b
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-mu=
lti-srv.bb
@@ -0,0 +1,23 @@
+SUMMARY =3D "Open AMP rpmsg multi services"
+DESCRIPTION =3D "Open AMP rpmsg multi services"
+
+inherit zephyr-sample
+
+SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=3D "git://github.com/OpenAMP/openamp-sys=
tem-reference;protocol=3Dhttps"
+
+BRANCH ?=3D "v2024.05"
+BRANCHARG =3D "${@['nobranch=3D1', 'branch=3D${BRANCH}'][d.getVar('BRANCH'=
, True) !=3D '']}"
+
+SRC_URI:append =3D " \
+    ${SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF};name=3Dopen-amp-sys-ref;${BRANCHARG=
};destsuffix=3Dgit/open-amp-sys-ref \
+    "
+
+SRCREV_open-amp-sys-ref =3D "d78315763fbacba8a74552d0ad570bd01c42ccf9"
+
+ZEPHYR_SRC_DIR =3D "${ZEPHYR_BASE}/../open-amp-sys-ref/examples/zephyr/rpm=
sg_multi_services"
+
+ZEPHYR_MAKE_OUTPUT =3D "rpmsg_multi_services.elf"
+
+EXTRA_OECMAKE +=3D " \
+    -DCONF_FILE=3D"prj.conf" \
+    "
--=20
2.34.1


