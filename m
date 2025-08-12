Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04F6CA0EE6
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 17:42:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (NAM10-MW2-obe.outbound.protection.outlook.com [40.107.94.41])
 by mx.groups.io with SMTP id smtpd.web11.80884.1755020521479583969
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 12 Aug 2025 10:42:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=w5dhfkAb;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.94.41, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nx90oLHuMqWO3GpBBLrt11azgnhp4P6giA9CVKwoFV9hqQTjnJSV5epFK5b5bFokIoMkBkufrO+WW0nMKwX1AKnQ84kkSvi6e6XT+3nxHv4rxwte6UY/aidK8aCzJsNWlC50Z64TwaQSMXbb2WIYJWfvDL3HXTecbT01DUVnoiz8zrT1AOMcpwgtEKOsvTG0eW/hrvEl6HqBup4PPvJudDjScK4ZibD6XeGEFsrjT9knkDWxKcTptzlOMmF4PpScLo48dGqQ3/CHOUHnPA2RR9ukuyl4US3zY7YrQPiVVgn5GFyXLHtjoi/lAyEgLG9hieGrS3nQPs4R5FbiW/rbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0v1+7PrV5cYc4kqLLRPw9UGIAYS6zsfBaOL0CoePJg=;
 b=s3OCJzRWFhHNRZD9s12hexaMIXXhlvA7Gd9ag7IzliXzSN3AeDLZiZ1xAhBcTF5drk8Ect1VXJmi87wvq6eQc9ZhHeI/uYo7vHH8/CmcK3R823EjilyB0fE95K+AFPtu1nqwaJ5ywcz6lv4r4kcLMdISXpQNEdw8latjwbqCzeTnyzcwQPetOTLOH4gliNMJS68uljLVKkm0ol7pZy3W6APgp89Iw+XHwLUEb+qDpB2dhPUjDRY/PadGFoJS+4XknuXUPqA1uv1hp8afR6sTAC9gpfoecXCyOmM37tbqpS2kv9ICtW+qKZYht4GVb9G01oVWg2G9zZOmTeV03CnOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0v1+7PrV5cYc4kqLLRPw9UGIAYS6zsfBaOL0CoePJg=;
 b=w5dhfkAb1ZcVv5j0pU29EhNa39Domzv5iuv1SlY96SjgrEuIoUaoXSoCLXclFA+YvAE/gSfk4CqbMtXp1fvC3Dl3Hc6IihBAW66ziz8x9jN4wb9TQsoZbYdTQprnpMYDwWhFgUntL/eXPaaAPz0u/4u0Wgb5hiOGitcGh7kpKcY=
Received: from CH0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:610:75::23)
 by CH1PPF9C964DBFE.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 17:41:59 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::f5) by CH0PR04CA0108.outlook.office365.com
 (2603:10b6:610:75::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Tue,
 12 Aug 2025 17:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 17:41:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Aug
 2025 12:41:56 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Aug 2025 12:41:56 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][scarthgap][PATCH v5 11/12] zephyr-kernel: Add rpmsg multi services recipe
Date: Tue, 12 Aug 2025 11:41:46 -0600
Message-ID: <20250812174147.130972-12-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
References: <20250812174147.130972-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|CH1PPF9C964DBFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3347da-87e4-4772-8a75-08ddd9c78a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1ddBxtd9tb/Gc4udf+f8wgWOUicrWiSUSmgER0FeDlZXYVRQVGMihqwJ6pBw?=
 =?us-ascii?Q?ovy4UMpOe+45AGq5UwTcj+Ee2cVhvgR6rOWfNLB3Ydn6IU/uTUzPPrlef1YN?=
 =?us-ascii?Q?3YKjVI7rN07PBqi1S2StlQ+jxJ7Vj6Cu7Ds7fzMoZtu+gKoVgk2c5zvDzqzR?=
 =?us-ascii?Q?ChTX2K3iEVnMegcj8/vc88hDLw4Wtxv/651O43DAqHcCxg6TlTJ+vxWJj8/5?=
 =?us-ascii?Q?T49zMMjXDOR1+zjSOrKBhA9xcPYAyCLYgdedmDOvn0OuTLKT/D+4tUL4M8fs?=
 =?us-ascii?Q?zGIlK2vAJQViulHa8szOItg5cQhrnMUlpG1bIVqEZf700qGPPcEExoxdLceQ?=
 =?us-ascii?Q?4UudqO9A4okwpw1Wei3+Dmw3vEmipHdVa5ORGuWDhhbapGFzCw9xXvU+MYCR?=
 =?us-ascii?Q?2moTLYzThNJ5F4fJ4eaeDeX7yp1PS4v9quQ+5tmGt64F4B2klYwG8oiwKWMJ?=
 =?us-ascii?Q?tLvHsAXYWCwZKUWbfDAk+m/cok6izy4PR1jJ4NsdC9rKxhYHuD0GRndhh3wE?=
 =?us-ascii?Q?IArAOEJVj34DDXGYeCMtVZkUHNzEQkVtdGEwOGid3hWPZkaatT+tnlbA+Nim?=
 =?us-ascii?Q?+acXjYPy2thXZ0oLdNxZ6tUBM+3ewzWtGWVvWGyFYc5VLi/Wis52lzq7k5SI?=
 =?us-ascii?Q?hZbYGsfzEQWfwNx7ybUGq257ngCS3cyESguiUEo1OOd20TNDt8mHuq2rkh3J?=
 =?us-ascii?Q?UaIzD0mThC4pnPkN+NycBOd1U1TOp/cN143AvMjpFmBG/XVD+wWNP/VfDIIb?=
 =?us-ascii?Q?i93GFYx3h4wn8gAoRGT3aWEgkQsXnepYz45tj3EjJGrThGAfUtX/MqYRkbC5?=
 =?us-ascii?Q?cbbXEKrfGm9vGgwsPKbIES/793M+IySk1dwvKvPDObAZQStfGCH3fXdNwGQz?=
 =?us-ascii?Q?KHXeAvVUOeB7UaZcOUGBFXFP4izF+xbmttel84LUQYcoAwJrqE0Z58UGHXnI?=
 =?us-ascii?Q?fx9fvjnVjNOR8linWYOz9vQEmDQzXMe6dGzjATDcNYDRX+8n+7YGE4GrMsdH?=
 =?us-ascii?Q?rpxlOYbmAWvV0n2lszLy7HA8buRSaT7egO5X88Mi/0EZbaqr16GHn5RFIhDi?=
 =?us-ascii?Q?ImezQHiI8SqpcpvKVGCMNHso1lT/MYLNHULum8ml2eEvLzkBKqMu34TVw+Nj?=
 =?us-ascii?Q?tEbPtn/MWQrWrlnHcVK7Zly8/jMiMQlj+KrZmZ/VBVHXbnY6pyc1ygHQeidA?=
 =?us-ascii?Q?aKXrFecYqXdotCm0AWtEliVN0/ZA+2/LVUq+tYidiViQp2+tPmctsYxsO+Ld?=
 =?us-ascii?Q?MqznPL57qAZ5OJolCGbMJfW5smUxz8VCKYUJ9OdRFkqXwFem3HMYM5AH5Ipo?=
 =?us-ascii?Q?TpGgaEW54BHAenT42CEixyfyyp653yLQ4gshEaDIvJ/JUeXtCXFn7hJQZB72?=
 =?us-ascii?Q?pOv8mIGnONK2GY6faojL4zzQs98vlaeBP+kTS1eeeF1jkuDIX/YhTCZvWprd?=
 =?us-ascii?Q?6l1BnbQT0aj4/rqhD/YkLvY0UfIEsT3BUbbT1TMv6dlN5Vf/KChjwLTBpt8l?=
 =?us-ascii?Q?nQQ2ME6qN6NDiMIcVIZlD5iD+yPsTQeYKszh?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 17:41:59.3672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3347da-87e4-4772-8a75-08ddd9c78a0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF9C964DBFE
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 12 Aug 2025 17:42:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1967

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


