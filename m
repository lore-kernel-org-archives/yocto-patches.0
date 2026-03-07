Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192CFFC9EDB
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:10 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.33])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3315.1772858642711551766
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:44:02 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=VgViH9yc;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.200.33, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMA6up5+GLeLqbj2JVXmSpgrZaXOwStBPcVdxhGuaBPOuMDzLhfrBQypV/Ggaj/Q0qG+b5riXaPUZtR0cfZzdLXL60XL3NVqcB3RkfqBszQ/BtSaSF27a3NIQREI6co1T+vz8kn5ghFD77XqZ0/PLeByXL/Zk+Ok8uO3x0oConxFJSbLjYRlTI0qUss+Dr21+4U14CbsYG0K9SzUER1sMOzYbSFg6+me067lJV+dyP1xBG+IjnUaT7pc/QGmCFI3KvJmLp5M7ZE/ET/iOQlHqR/gi2Jx0++DF7Kn4Kh2Z0pSIHqNrFCbQswpJGqtdImeeTXUKBQlh5SpuOF4rV7XZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnRQ0fOoEEtqKIZ9S2nkSqkje4l4dgolkTpXeUWbDM0=;
 b=LkxU+5OGqril3ZLxIhz7wwpeGNhHQQzifYFghcmm7D45p5rwBM+nnsgsQu6xLiOz7QrYnUERfGBbPeceBG7q9mxmbYZ+Sh+Uc21yK2zc5ivdOSxKdbVuF0nfnEafcJPAG+VXfAW7W7GGSXz3BWpqEAto0r4uCq9BNswbrHe7WFZWzICue9j7cmiNbgupeMI0bvA/kQHsARR1XhU1KvjsTaYLR7siAVaiJ12d56m3qHjFhtn05LMsIu0P9P8f7bNqNts1JXmizKv9iNA7YDT04+P32dtLGCaa7qWP5VETQiHa/mg0fV8Rb1NPnk0T/OY9bVV1694WN8AlB4jsY9QCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnRQ0fOoEEtqKIZ9S2nkSqkje4l4dgolkTpXeUWbDM0=;
 b=VgViH9ycOrtWveWcT61zHhI+RbVef5DEAhUUr98dvydr002V0Syfvde+GxlVaTdeuR3SoTG3jNwQiOpIhx5uzNndH2AorzgEcRnOgppUXwogjir+jrBmOwihTan0I5jQ8GVJuvwzdo9cKqT7JXCG9N56Zch4OH9tGu9oYdaSApk=
Received: from SA1PR02CA0005.namprd02.prod.outlook.com (2603:10b6:806:2cf::10)
 by DS7PR12MB8275.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Sat, 7 Mar
 2026 04:43:59 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::5d) by SA1PR02CA0005.outlook.office365.com
 (2603:10b6:806:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sat,
 7 Mar 2026 04:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 22:43:56 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:56 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 9/9] zephyr-kernel: Add rpmsg multi services recipe
Date: Fri, 6 Mar 2026 21:43:53 -0700
Message-ID: <20260307044353.1936182-10-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sandeep.gundlupet-raju@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS7PR12MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: ac12e687-5cfa-4017-9cfb-08de7c0425cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014;
X-Microsoft-Antispam-Message-Info: 
	BG6Zc0mtmPjGHBsun0wyE8Nik+D0eRxFlMHYj4JHVEvSa0zBcSSzZY+CSK4yzEqIMI1XGHqpF4q92psMhlp/FFMgogWMFkVTBUW16BIySmO3wAE1R19fxpx61rEqlhus2PnRv4XZiboDCZRjwIxppCckWIydb2npzzY2LUAmx/KLK1muQaxoqMJJOkQrYf/j30JyKfwVYTmNm1BP0hTapopQNsvOyXFMWAXjX9w/rsAVldXiVdou/IZhI0zfe+f/3tgTr8H0cXR8XkWB+fmt3Qfg4CrEgIKQ+14t+fy33Qg6o1CBgVuL71bXv3H8WUgZ3uqgbY1OEZUfoK69NelR1kMLo5A1AxGBNFrWerji7tS1/ZVuTmH6iDwjWOTIHBy6t8Kco7OyDUjmpfKScnCns3iovy9RKDO8Kqgp3LDtXAChsrwWeF5p0lFs7aCqh/s2zuFnIsvqa01LOR3Wan9Y4vfAJ5FDKkMl8m6NKeVrO/JuPqtrjY7zNn086zzfN8Nn4dPzoMlQS3TDoNuvdQQYj1q9odFzJelZkwbClO/tAtQVKm6H6s4sQcpubOxVUZ602uvJkHys07DB8CP9iluOhwELDvA62lteOnwyEBVhw1LUWGQJ8LsKbwH5A9awb5hZCciT+AAEyxcJx0ciXkYtay2Q+L9feJ//GuOHo4ueWJhPoU2OJRFX3wZpmHT1CDw41O6Qt4QV+0uMUX6BEQKl+MCp8EzDQkJjKNF9/ejXSfGJyyfwaFE2TZplg1O7ppxeMgte6LnLsg1nZyzyHiobHg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7JFYPO66v+sTihMP5b/vgqO0aqN0rk3JmfWVhJBmMFkQTVAaEgNLkPyyLgVrOBwhyTZQ7aKdMMAGdy4uD/qTrnGGOg3DsXBjVu6GTpVJc32Xk5gyOMLItDBSWpVR4IUxJrvnUYjaego5TiaPlxQKl0RWgjxVoRoSaQ4HYQjt1xVCVsh68KKGP7WFjKOQHk10b9AxFnXQTYzaPoocdxAggnQqHlRN9/ingLkNk4ewKZVOX4Z8xC98GJyQ6W/p8veXOwuweXg5PEQKjDlv+lTjWH8AyqTNfQIJHxNus46qpTqQNYa1URAnuN54CJ30DGyy4RCzJHS5VE/rkRjMoV+S0BluZtyTJifHidAIMzdx4s2jrvICsU5bZWriisEhV4eS0OyVNdkCIooGfZyCwutliTcB0qfRfqfEE3Plok+UJEJGYZf4JvNW6isKA0DKYIfW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:58.8393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac12e687-5cfa-4017-9cfb-08de7c0425cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8275
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3359

Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
openamp-system-reference example applications.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../zephyr-openamp-rpmsg-multi-srv.bb         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-r=
pmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb
new file mode 100644
index 0000000..dca3b9b
--- /dev/null
+++ b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-rpmsg-mu=
lti-srv.bb
@@ -0,0 +1,25 @@
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
};destsuffix=3D${P}/open-amp-sys-ref \
+    "
+
+SRCREV_open-amp-sys-ref =3D "d78315763fbacba8a74552d0ad570bd01c42ccf9"
+
+COMPATIBLE_MACHINE =3D "(qemu-cortex-r5|stm32mp157c-dk2)"
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


