Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890CCCA0EE6
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 20:43:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.62])
 by mx.groups.io with SMTP id smtpd.web11.4307.1755636218117878211
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 19 Aug 2025 13:43:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=MpSPDNR3;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.237.62, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DS6YbLwDscor1MdkgYHkpr+78cB7iMWQVp70dMVm8hWG9zGEK2yuDbrsurWibrbq15lE1UUi6Dk3HpX/bIZW8XnnmWEvEhhypucgS63wrx2pWsIJV/dRadqrAwlfShYUX6zQWhmqZwXdhQerwiCZBHMcufLj1aYfS5pzO7M+R0DQLO3dcmpDrVS9EBnkDJ5uFBS3iXXGPHcshAn9Z0bgfosenNH2SOBSwepnQWkv7nAmJTYKBIcfqRBFTkJAIkDzBLLWbDQeU45s+V8LU5WX9C9CJTNZ4kDn14z71VHbt6otLM/QrLvIEvmEWG88SIaAyKhyaQnaz5NyshtI2ld34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jz8cQ38Ro1qs/yUxaURrFXOv8Hkvs0RHqtCqnAXTrE=;
 b=uTRlUheJlVLF4aCA3o61WmY+agph1TOM8N8eBlPk7MnO+tWCp/Q48BdY/2JeEm5W91BByloTGasclpVmTgugxnh6qBc7qlGwYwGoM41HBrPJo49u//RI5KIlnkbPdg7NscFVnq+eTb7LGVm3lfl8GJwsMkrhsd3RQBZNL5S9dR9dCE58KbwCXtZ4un59/g/PMaiGffigMyfhE22gITjfau/3C3KoUkak4PDLZ0lwonZSctKJescM+e3CNpqNPVBrLSb0uqKZ8gO9C/JnJ9kOl55K1nNSxhXTcf/M2O8M+0/4ujsLoTaBJHQMiO0PcQz3h6HESA3EoWDMrv1b/vm+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jz8cQ38Ro1qs/yUxaURrFXOv8Hkvs0RHqtCqnAXTrE=;
 b=MpSPDNR3FGJfxiQ1ppvBE6jj1a9NM9XnSoXOhyiR0PggQkiX55gcpJVQZRd4htyTJyRzN2aGzHsDpPQyJIOeQ1VImgVkjjm5wDQKaQVGrfGOeaG8PSmwpKz+6oJaLj7NUsss9Epb8/0fXQnmOBdpBdUIEF17uSfbZaDtU+rzypY=
Received: from SA0PR12CA0019.namprd12.prod.outlook.com (2603:10b6:806:6f::24)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Tue, 19 Aug
 2025 20:43:35 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::d6) by SA0PR12CA0019.outlook.office365.com
 (2603:10b6:806:6f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 20:43:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 20:43:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 15:43:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 19 Aug
 2025 13:43:33 -0700
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 19 Aug 2025 15:43:33 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH v2 1/1] zephyr-kernel: Add rpmsg multi services recipe
Date: Tue, 19 Aug 2025 14:43:23 -0600
Message-ID: <20250819204323.451487-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: de1f4fe1-c6ab-4cd0-f30b-08dddf6110e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9lg+Zs4veyf2PKsAb9runkFPMhVudPjXa+hkdjJUKiHUXKk6ZduOyCdDu4XO?=
 =?us-ascii?Q?J27lqmhuTyT+gldpMzpxuMjjn23iOi7yLysoTJBMGqfTSzEmdjwkdtAMPrQw?=
 =?us-ascii?Q?E4FMj6maQNgjDvLpYxmfjgUR6+4CJFdRakAL3qMogenDBG3GPCikO9bu7ic9?=
 =?us-ascii?Q?fDC9P6hXjxuiT+pmRVqbYHK3PLuvSrGY5xaVPXch0eKp152cVmO8pMYGKNMC?=
 =?us-ascii?Q?HtMboibAznnWbQtRbhxwfNt5BxVI5qg8Msxe1PbhaZLYfRitNj34FBqW11ut?=
 =?us-ascii?Q?UShcWF2P8eoLPL29rqw6Ekc61Iaq6LoFoeFIWxoDVT/j1EWfJ8yO9Ix8AJrW?=
 =?us-ascii?Q?OkwEJFasm9pwe45zzosoQv9kh5bR4DxAh0AgasNHIKAMX1tSFL4u4gfUrnnr?=
 =?us-ascii?Q?AurJxnAo7ujJYyIdB/7vjTALvQ2h3iPuL3jOFFWFRANZ+3qayQX9DcuBUJ3P?=
 =?us-ascii?Q?TzMnGdu07hIRas8+DzvqkIqc+ZdHZoyOqIzz9OGRmMIDzUlnsZMKzKUG7f1A?=
 =?us-ascii?Q?2iLI323C6Ue0ZiajrNwl828jIa41mU5mwVnEGTaaC2vqN3718vQ54pvYM4xI?=
 =?us-ascii?Q?k3i073h8SinSFIG2oMA2nXOSiEdTXIXfDnvHFQ1BLGlIUEYjYDrYQH7UKjlh?=
 =?us-ascii?Q?Xeyc/Llypvjr2VOYpu5Xs/3LhVyDI6ApLv4QGs1k77K1gv3o2BSRQjBwtFc3?=
 =?us-ascii?Q?Qt8nt74MYd1XmXZw5ibGaY9b041Gdg+WNFbg4bLsaI1aNQUSoNuCbt6bEn6F?=
 =?us-ascii?Q?vo7hFfMJGE5UvORKcoXydECjZDk7AfSrAeetllHtJEOj8gGhtygEUt2F+l1X?=
 =?us-ascii?Q?M1yEDJjDyVtoCQgp52i6ygC6OMXf7C83AvUBx4dA+9toGsyYM+aJR3IdzaQ5?=
 =?us-ascii?Q?neCz1N2llOmxLN/Y3KVE21TBQ5QcvhI4/0TvDFM1Id+yzojia2SuX3l0JqGC?=
 =?us-ascii?Q?DKOyGG0DuhfU5bGCANva5M9mlqMolojsjtTvsxyYcya7MUkEf59wgGx9e3ps?=
 =?us-ascii?Q?iZhG0e6Uzp8efCIQjQG+uFS0MsG/tU6Gvt2duwWzWoAsngfHCk2CQWrQmVOS?=
 =?us-ascii?Q?EhRG682lfRBWQUMsqd+MrkJ9vMvHYiypgXV/cCedUb9/HgAU+4PjyoH2VFKJ?=
 =?us-ascii?Q?wAuzvT2TbgikuOJf4anL91RZtR2ez9b3a8CUN1hNu7sTahSHtbOHUHrlfCQI?=
 =?us-ascii?Q?BHmVM7Vr8VAqSSuL6vKg7+8w+l6WvbOCNjSpIuqHNMM4H7SHZnIlW7BVg6f0?=
 =?us-ascii?Q?S+8oo7wO/Jz9qrRQGdWN2Slh4c8+0acdaiSZS+1WyizhgPNTvelCSicOZcE2?=
 =?us-ascii?Q?9zpjrnVbzWYKlsM3mUsRXUXxpty8LUhSA1Ua6hW4vbQQFDS/33GUBCT6jHdi?=
 =?us-ascii?Q?en2vyxbfx+ovfqRr9xsggT+7A4315tyVmvprkglywon/WV1te04FHcTBYLjO?=
 =?us-ascii?Q?Qr6sU0wgJ4tL8/rtjMnTQJ/MBhLyoqDA02YiDEVXDjBbCGqFAWf2xvKfnoml?=
 =?us-ascii?Q?lwDA7/alpSXO3SgyOfQa/A7GJruKnqiDSPjW?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:43:34.4086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1f4fe1-c6ab-4cd0-f30b-08dddf6110e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 19 Aug 2025 20:43:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2061

Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
openamp-system-reference example applications.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
Changes in v2:
   - Fix SRC_URI path.

Testing:
Run the following commands.

$ MACHINE=3Dqemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
---
 .../zephyr-openamp-rpmsg-multi-srv.bb         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb

diff --git a/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-openamp-r=
pmsg-multi-srv.bb b/meta-zephyr-core/recipes-kernel/zephyr-kernel/zephyr-op=
enamp-rpmsg-multi-srv.bb
new file mode 100644
index 0000000..fd3a173
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
};destsuffix=3D${P}/open-amp-sys-ref \
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


