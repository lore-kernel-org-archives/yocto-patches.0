Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A56CA0EC0
	for <webhook@archiver.kernel.org>; Sun, 10 Aug 2025 23:39:32 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (NAM04-MW2-obe.outbound.protection.outlook.com [40.107.101.43])
 by mx.groups.io with SMTP id smtpd.web10.36650.1754869171415630255
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 10 Aug 2025 16:39:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=lOhAi8VQ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.101.43, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfJ73rqhxTr6U4EmZGV95DZhEK9XIZbnTxcclUyLguspfNZO0oDu02jTu5m4DUqAsjmwdY4fFJBktsZJvBOydPiXQ7UL+zDOVLewE4m8aaI5gZ5HZRF+FeoXA+6wRy27Bpp+B/p23EK8ONilYI8PI0xsG/c2hZRnHBlCCk9XudVqYszhPzGimUA50/Du776Nhip3+OdRxuuJNsV0MxZZfwD4uyLxlsfxYNSkhRMdfzWE0+VLqYTyBgexollJzxRqp8Sl9ifwXN5oSllork0E6EKXCXCJNYfF03Vvfq+OeiPrSxDIJqwc0+pYhlQv4buUUYa3NLDeTEJPmT8NgfD5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttZPjY2QYdbxen/nKIcWWy1DZ4lTaVhCg02ikXd6z8s=;
 b=sQR4aAhMiuT/epC3bKEckQJjjJkrOS0QBsoYt+SiX0SGUxBXqLmz+Uq6/GdPiQSshePxo30Y88/8kxqllOtYUB4AbtEmvzDFkBP/3LwZTIxNHRx6ag1X5lApBfM/dY7GIL2Y2xH8QfPWqcmv68GCwPQ+RIx2mqxcPuKeFhrsywvxLvKYZnzZNQodYTFgjVhlM7N2EGrvbrjwmQxfYp3dpBhvnCLlM+TsgKHNlT++knkm95iNV2dPC8xfNfgpthiCCDvYi8lIxuERRVQt7PVq3sKw1bIPjPEoa4bpu83T1bmQxyA71osIcGuH2caYhmiNwsvmhFHCkFn9Vx/QIBy+Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttZPjY2QYdbxen/nKIcWWy1DZ4lTaVhCg02ikXd6z8s=;
 b=lOhAi8VQA24ZeezLy2M6zmyn9qU/Tu4+P6Tlyl42xftDW5sEzeHO4iMeewIaO9cSVIXMT/Q3u2tMhPHmLKexEzKTEvLqtro8eiv/mbY9u4jA8nCjjvSyy0J7TkL/Tv/SbNa39DuXQzftYJPB8Ya9B/ZJj9BV/ly7tYvxpduB9fA=
Received: from BY5PR13CA0019.namprd13.prod.outlook.com (2603:10b6:a03:180::32)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 23:39:25 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::9d) by BY5PR13CA0019.outlook.office365.com
 (2603:10b6:a03:180::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Sun,
 10 Aug 2025 23:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Sun, 10 Aug 2025 23:39:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 10 Aug
 2025 18:39:20 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 10 Aug 2025 18:39:20 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v2 12/12] zephyr-kernel: Add rpmsg multi services recipe
Date: Sun, 10 Aug 2025 17:39:11 -0600
Message-ID: <20250810233911.1259884-13-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
References: <20250810233911.1259884-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f55f41c-680a-4fc9-b4c9-08ddd86723cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+LLWeBODTXsLaWqMc/tMClPy2wFYOc9r2HU9hklSh2kuVn3L7UoNfdYYtU7H?=
 =?us-ascii?Q?n1LrlzqKOpyYYs3fIKq9F/N7FtJXu9q29EkpnZLB73tusHLIGqb+l3oMMJn1?=
 =?us-ascii?Q?pyGWvGJ3mjfqsk8ZwAV3UqNf7oz0bpI2Hn6UnoThK/AZbdGebu3ZVZoDXeGN?=
 =?us-ascii?Q?0GEtpTLDROrjt5PyxjSg5+GPWAcWLIcosrGM5lsrZcu6ta7NzBxk0GxDvgin?=
 =?us-ascii?Q?1IZNwsNdRNIbQgvhejoikEG0jP/pfKzzSJCTjBhxnSp6YKcjvJOJayaXwYJg?=
 =?us-ascii?Q?q0IkTViJw27XslNZurd9oYNZ9h+Sn2shHMzJoX+t2rmZyZDMiB8MfGbKauzR?=
 =?us-ascii?Q?OP/F/GtWrNYhsP7Jcy0GaQgGcT8PCKTi/XKErgdCbHgatHN8e3orn45gkVcg?=
 =?us-ascii?Q?BwDEqdLkua8HpPeXJOextoWCTJxe/dogumztZnPpTS7JSjbLWythks4vmOvT?=
 =?us-ascii?Q?dHXB/u+BmcP5G2vU8MHic+LSTPcPSFkDhHlJiWZ/lW91xdoxz0hzfrfk1Aa7?=
 =?us-ascii?Q?HighLzLI4h5hVThlz87Wf8IKwJ7drC44zVAOb7ys3EsH26pWFPvOeL+kh0YO?=
 =?us-ascii?Q?OVREJSFqqvQO8xxhHtDdzTKzrrPCsJxg+r30a+UtzLJgGZH3okCwjzLGD/UK?=
 =?us-ascii?Q?uv+AnRMB5TTe7pnvX/fhgWI4Pfo/+JaaN06/vR+YycB93uZxANv9pB4xnY7T?=
 =?us-ascii?Q?Okgyc/hBLGiJ0sKPprj1ZcObxi17Xxq2l21nuDrjwSeABrM7kHydR3pBVnd8?=
 =?us-ascii?Q?/1ygRVhvZLnza9uSjYtRagQBpMIEM4D/DzCEGD4e1CqmjiIO+lX/g9IxagSx?=
 =?us-ascii?Q?Z9es3Dwre4dbK/0MoPAw1DlvZ4wehfOLOQPFbSiz2ImF7ZK8QQGZUmgdDZvb?=
 =?us-ascii?Q?voORfskWycAyLS6LapxAVC42a35xw+HtKfs8XMB8To9zf7IXXUlX3FCFRqpu?=
 =?us-ascii?Q?YgBXi+s2VJZxcJ2sgyKUeDpPkcwLQQdGVNjUngSASZGB1NX+LqvzpgDDXMDn?=
 =?us-ascii?Q?wluiTovFlER0ER7b605tB+T5UMPk3Nxr6rjDSxGnReTQFwW8qYXpwhGfCDjf?=
 =?us-ascii?Q?K3HS988yj2dxKqJiwCeYWZz1YJiERjh1xA1pa/VuejT0jOM0exD0i6UOaZBF?=
 =?us-ascii?Q?ijZdECsrrw7f+Bf0UUpEJYAUwF1y0nedMQcjoWWMytr4l81ae5Z4gzvl/gIi?=
 =?us-ascii?Q?WdgIJsPLI8K+IBkE+aULusWECrkvElMrDPz36lT45N0Cei7nCiHgQQV3OsLA?=
 =?us-ascii?Q?ewOX3+kEkAwKx22n9P6roGQzd3ZUFWYeJheJPnRMeznl8myfTMZc9OfthUKq?=
 =?us-ascii?Q?KFeUDqt0XgF93J30g+iHUA66JL7tytltiuc8WPDymYIdpn4+IGKhyF0Mpt4t?=
 =?us-ascii?Q?mR1oYPP/fj427ayhSjIO1hAfuc1ycnAe1MY1akjne9THHsmJrznRYt2pVxy4?=
 =?us-ascii?Q?F80JaRm004i6utUZgmtcGJgJ6BG9yGxYN66prHXtPmwu8gaMgCBLi/sUKh3a?=
 =?us-ascii?Q?KInVx7yKpnU2TgVsr0TU4bXksHfvzQeawXjw?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2025 23:39:24.9183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f55f41c-680a-4fc9-b4c9-08ddd86723cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 10 Aug 2025 23:39:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1920

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
index 0000000..51152e5
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-mu=
lti-srv.bb
@@ -0,0 +1,23 @@
+SUMMARY =3D "Open AMP rpmsg mulit services"
+DESCRIPTION =3D "Open AMP rpmsg mulit services"
+
+inherit zephyr-sample
+
+SRC_URI_ZEPHYR_OPEN_AMP_SYS_REF ?=3D "git:///github.com/OpenAMP/openamp-sy=
stem-reference;protocol=3Dhttps"
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


