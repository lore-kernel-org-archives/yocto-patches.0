Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0F0FC9ED9
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:09 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com (CY7PR03CU001.outbound.protection.outlook.com [40.93.198.58])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3306.1772858641774034678
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:44:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=V7McDfuo;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.93.198.58, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUd+fgXiVlGLkEJguDLerPzvi326kNL9G85sr44Zh9wRlKVIHBOpkiRnmnp+UX/J3S1NaiP+6o0eILq/Bz1dEezhseeF7MDYSKweP0ZMBP9cjt5aVjtymswTtAW7MgtTHuQKPou2b1e7dXZtCKdTRkN/Vd/DfAZGGUbgesTii/3ei6SRxUPRwGpEUDLN0WsBr5YPYzNdpvtZ5BCKjuiDlrRU5AMYdAMglxp+5SgXCDY7cqeGxXwHbqiSnHnJVxl5dx9RZk/Xs7f7Ci/wsP233BxqDeE1hlsK07AKrQLXGrEeZTKiX7rGmV3skDQwnqj3davm4FDFN5PajldIwX8HbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP2eNnHRB7M9mrfl1jcvAhyEdFf5rvzcKTz2Jkw082A=;
 b=FvlxuwFQl4Qb8QXmmcvokPYTiErG5ovShYU/iHf8vRCaHxIvSLzxkOpNoVR19opAFM67uh1LLSWmTXt5VN/0cdq5wqQTHn33a/GDkz8fDpuCSTjDsVwfjdoReRGFDedNXJUJJocz6+/0k1XPA2c4M2jrqCv4l1FJj7hdogonyIGnWqoWlZvWyAbwZIL87xM9KUwT6xf3eFo25IJm2i1YI4rsUaLXx6/zaVQURmxvvQr2RlVDI5zOJImDO3OBdu/Y/+W2goXBIy4asBjkLA8uX6A0loVlcpclVK47I5tyRV5wC/slz9/2H1kMRWEWw6k2PyUxu1cCaQeMOwSzlzXb+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP2eNnHRB7M9mrfl1jcvAhyEdFf5rvzcKTz2Jkw082A=;
 b=V7McDfuoYhcZnNgmHUxEJF4ot3y6Anj5MBnuMcDdu0ynNdRz8HErIhWQz1oXjOtcr+Ub8YBlOfxeKxAtLN7IITGhKfBftqAkJNy8MjuWi0+V06qR5odxRFPtV6ucrRc68csBf1xxGWfIEBU5ZcZCCEfQWrV1PLPcAq7GidxBBX8=
Received: from SA1PR02CA0010.namprd02.prod.outlook.com (2603:10b6:806:2cf::16)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Sat, 7 Mar
 2026 04:43:58 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::41) by SA1PR02CA0010.outlook.office365.com
 (2603:10b6:806:2cf::16) with Microsoft SMTP Server (version=TLS1_3,
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
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:56 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:55 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 8/9] machine: Add support for xenvm boards
Date: Fri, 6 Mar 2026 21:43:52 -0700
Message-ID: <20260307044353.1936182-9-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: afc62fbb-57a1-4b4b-920b-08de7c042591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	TEVBhmmoVgMv+TcbGZNBdwtTdK6zs7mWg+IL8kDuaz4AijANhABjuQ3ZCnAioxPbI7ijVY7Wx/jgSwzwbtzIIp46TGnInbHPCAPTMY5sfDaOHmvAaReDN7i5VKskNFFAdgI3VKxAYfD/ZAYNh1fe6DPCZjTVv+MmLPv4zBonzPKBGFK1tpqIVG1opUjrPihti1Hx3oaV0s/WkNQrlWEHCcwqnrUGNCwtFg4V22hJZvI5kE6SGiphvUi7QjQsRFfQt0F9919uret9GKHlcjlBbPu2/GDD7wZZ11VjQF2+rkdYinjlQrai8dTGLNV3wD24n17x5qYqOG1qlT/9p49RK/8g45pCxEfRPm8VZ9xau/9gUdLeXlsSVRbjEUbELZ+pekxgYwqTvlnzQs1a641r4fF/ZPYnjLxCz5UdHlRzjrQA9lyxnUReJ9ua7cR0SGdTc44q5IfnVvJst1QrE+7qupP02NdZcQCLXa9yF/NJVgcndiQ7LFbZYedqx+/grebHhSOYKomu2iKA3imd1qydlx42fxrviaOXA8RgBBQmvTW/j6N7ojCjpT1/sTUMR+LNulSy/pKeJ+il6ADoUqU7s6F1jV+OwHz3o5RU/Edrmmobg/kkzRP7vWuzmSjLaf3GNZunovvOOKmbloSJJtWCqfFHcHW+LFDQN4CbdlSd76hTJKUIZYqBEHQbqIf5i/WPnZxBeYoCXN6nj6ihfLIxbwfAl6xuNRkCDD0Q5L9oqwbrazhi0HfdSY3BmCbSYdFMD1D9sOKNZufl6Fvzja/ksA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	pLRd1f2TrXPjHYvGlrdI8+IqkC0gtVDDHBofUe5oiOkP3+JHfBaz35rKUzNjqDLwhl/zCnUahwLgZ9YGV/y/fZH6lBo1qkePaFlu52UyNOyL2s+u3vGuFAQ0Cfwp+L1sW+POigN9y9hovtoXrHrEky1pmvR29f/4L/YRrxYdvNFdeHE+544joBl8kaVWBPzsMRT4rXvloOmv866EpEm7SGtNwjChPLv+vmTyqBcdbWCstDkaBiEwPOPSz37oMrlWPXFz0i/lluoX+8Qx0osyyft/+yqvb3Uy/TWYToNVVWSpoo5Brgy/eDCpA4ln4howu3z20i2nuD/UUpWriPvkNvUKG76PSYJEU97ZmSBMd0BnGbCB/ugluNVV3ZPD5BjIDKATm1AOXHwB/dc1eCN9lU11MEgpTvUhNNbiUquafuVyMcUA0fjeWWbAt3y4MBWX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:58.4593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc62fbb-57a1-4b4b-920b-08de7c042591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3357

Add support for xenvm(gicv2) and xenvmgicv3 boards that that allows to
run Zephyr as Xen guest on any ARMv8 board that supports ARM
Virtualization Extensions.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 meta-zephyr-bsp/conf/machine/xenvm.conf      | 14 ++++++++++++++
 meta-zephyr-bsp/conf/machine/xenvmgicv3.conf | 14 ++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 meta-zephyr-bsp/conf/machine/xenvm.conf
 create mode 100644 meta-zephyr-bsp/conf/machine/xenvmgicv3.conf

diff --git a/meta-zephyr-bsp/conf/machine/xenvm.conf b/meta-zephyr-bsp/conf=
/machine/xenvm.conf
new file mode 100644
index 0000000..73cb7a1
--- /dev/null
+++ b/meta-zephyr-bsp/conf/machine/xenvm.conf
@@ -0,0 +1,14 @@
+#@TYPE: Machine
+#@NAME: xenvm
+#@DESCRIPTION: Machine for Zephyr BOARD xenvm(gicv2) that allows
+#              to run Zephyr as Xen guest on any ARMv8 board that
+#              supports ARM Virtualization Extensions.
+
+# Include tune-cortexa72-cortexa53.inc
+require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
+
+DEFAULTTUNE =3D "cortexa72-cortexa53"
+
+# Zephyr RTOS settings
+ZEPHYR_BOARD =3D "xenvm"
+ARCH:xenvm =3D "aarch64"
diff --git a/meta-zephyr-bsp/conf/machine/xenvmgicv3.conf b/meta-zephyr-bsp=
/conf/machine/xenvmgicv3.conf
new file mode 100644
index 0000000..e203fe9
--- /dev/null
+++ b/meta-zephyr-bsp/conf/machine/xenvmgicv3.conf
@@ -0,0 +1,14 @@
+#@TYPE: Machine
+#@NAME: xenvmgicv3
+#@DESCRIPTION: Machine for Zephyr BOARD xenvm gicv3 variant that
+#              to allows run Zephyr as Xen guest on any ARMv8 board
+#              that supports ARM Virtualization Extensions.
+
+# Include tune-cortexa72-cortexa53.inc
+require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
+
+DEFAULTTUNE =3D "cortexa72-cortexa53"
+
+# Zephyr RTOS settings
+ZEPHYR_BOARD =3D "xenvm/xenvm/gicv3"
+ARCH:xenvm =3D "aarch64"
--=20
2.34.1


