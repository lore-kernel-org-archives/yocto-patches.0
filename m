Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E8CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 14:40:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.45])
 by mx.groups.io with SMTP id smtpd.web11.468.1755700798920226384
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 20 Aug 2025 07:39:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=sP0BaQwZ;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 40.107.220.45, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhuaSz+VWIFbP2AB6Jfpi/u3X06OtoDYIEhlCoQSET4RH/5eEJUCjszcHCqSc2yxgY6SM/QjogFFC77bJyMhR+pJFkVwZdfDVfQSy32MQCSInrydvaJJiRi+bRmZsQEL6szH46CKlx/CKIdrEz68WwA5TtoaxZ6l9szGovvkAVbckpVvJUbIk3Rji1i822wMvLIcdegmji5Jv2ivliRPQcLraHTepYG1OSXM5yqwX1JeB2ZoMJe1lL8JgwfEm9EP2CQzL8t3qjHIIYU1t1Hj2i8jJMSp/MoxSTq2Q4PJkhEfFOYOJISI99l2FrAxIV9LgBexpFEBpOYp8I/55pW6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26FiZscIiKK2rYBuTBbZ5oGflv28M4XBTidUzxhjIl4=;
 b=bxPsUiEVnYGw5E9f2FGTqD7HTG8VTfHRlOOxX97uRzz2VOIYHy4GvyLb/HrdRTS69cLhnVeMUHWMy7vnBZTrdoEycIHHuDO6ypqbqNjaEnpGn0AVwNVyYG8WkVuNPbBDLZD1kd1zgiQyk8mUPr9OFGDK/ipfp48+TMDabAXsiO3YAmLyr3FNCK9xnjxwsM9O1Z16RrTfR/oXz99rqDUGDVfaVWxjTv37KbC/3VFxDF38aH89Zv3ocJJCFjMY47jpXlR0Zox9gsptpO7OlFC6WXeilvm9+dLwzmSifjwg/1Qs0KVbRbsSdLXxPs+8VrPyb04PcxV7STYiYoi3I7AAVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26FiZscIiKK2rYBuTBbZ5oGflv28M4XBTidUzxhjIl4=;
 b=sP0BaQwZKrQ7KSBs2+CvNKJTk2BNpt1C4GuZvJmQrd8oVuEJaEtE6XHxC+Fm7NnPLiWzCSR/k0dpImpOuwPQiDH1GlmEM1d69qH2rs9VM5gREtgKXWIuxGiwqasITzE/G9iv3lu7LCc9sasSOQ40ISf/fBSN6ldkPKTmlKWSizo=
Received: from BN9PR03CA0712.namprd03.prod.outlook.com (2603:10b6:408:ef::27)
 by BL3PR12MB6570.namprd12.prod.outlook.com (2603:10b6:208:38d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 20 Aug
 2025 14:39:52 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:ef:cafe::6) by BN9PR03CA0712.outlook.office365.com
 (2603:10b6:408:ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 14:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 14:39:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:39:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:39:51 -0500
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 20 Aug 2025 09:39:51 -0500
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>, <chee.yang.lee@intel.com>
Subject: [meta-zephyr][master][PATCH v3 1/1] zephyr-kernel: Add rpmsg multi services recipe
Date: Wed, 20 Aug 2025 08:39:51 -0600
Message-ID: <20250820143951.4033778-1-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|BL3PR12MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfbbfb4-529a-4709-5828-08dddff76c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MHAspDKRQS2N3k3NgKYeHZhkFt7Fc6aliSK+lGiAKWp+OFKE6lWeU2jAb5JR?=
 =?us-ascii?Q?NNOAp02kkkRatnZ/jr8i4vjWqDGLKbHJnrUYC9h64v909EHXkqtwl2fmDA/C?=
 =?us-ascii?Q?RwXCddv4HmXguUKfomFRw1DWBVwMF2tKCcvJyiZXiEUViebV9WLmHpWWPcG2?=
 =?us-ascii?Q?DueB5O198z5oL69AXjg6RUAImlAuu5bc9PUOAYKxyoS39CRhEHZXrdCQfwvH?=
 =?us-ascii?Q?jRNEih8/StX/ziulPSPudTJykiOe1yPqZxewGA/5PUzVbkll7p3HzAiIIE+1?=
 =?us-ascii?Q?eQuud7iQDhb6r/AFYRcnCFddkwKeTdx7EnkD0YhN7Sot0ivK/z+yhaOyzrU9?=
 =?us-ascii?Q?FAgPKgD5OZP0jPmMD1EMj/CFNLrCNK5shpBs77jn98Hf7XSRRgPXG0Kp+EUZ?=
 =?us-ascii?Q?3kswoe2I9oufG6G4udTQUzkUQS0ARSQ0qRBh1OaJCzygR1fmig7QHAuArpNA?=
 =?us-ascii?Q?UKUbYsDwpEhjvLghL/Nkf8F+Q2aw3IkZ+hD3svhefNVw3orG+6ihE6IPYXEI?=
 =?us-ascii?Q?V7TZTaOVes0SwX9DUJi7hExRm1cAIMSoKUEKJt8OX2ka7MO6DJ2Hl95zSVj4?=
 =?us-ascii?Q?fHeossiW2vG1pgguCyptPuzpgIAWEKeVXCBme8Eq81P0u1f548AS4KgVdAis?=
 =?us-ascii?Q?Cm1IOmvLMlhlWvQN9xEh6i5aWTfDRI8NVyHp5L4aPmNcVpGA/3gJEBKZf0VN?=
 =?us-ascii?Q?EJU0y29M4vXsFBjBN3gqYJ24PXP0qnHdTHCS5w8BZNkUUsYgpgJ92pYkuzCN?=
 =?us-ascii?Q?0gj/fR/sop+L3DllYMWadqtWmkVwGtXsbpatQvWAzj1LicG5BApu+bdJJI9i?=
 =?us-ascii?Q?rQw4Mg4/7CmT/i6eyAE0PXFDMLLOeM+rExj//WE/SLWZr2k08U0EmdNWrq8h?=
 =?us-ascii?Q?2mhns3wL1dCS1azC+SMYlJ5ffmbhJV7PQt/1fmKNYw+T4DzL8rcsPHmmyawB?=
 =?us-ascii?Q?RX9kTCqgjjIWT5al5IZTbaP5DZOpinpyAb4fKaK7f4x89Fxz3O6E03uz+k/q?=
 =?us-ascii?Q?UEbdyAhwKlTgERUb3tXUpH4M61NLvHyJnILgkHpmDEuHwaBKkrdbWFw+RxKz?=
 =?us-ascii?Q?TUVCM+YNeqKpqijEBqfwyk3V4HfoBSXoh8AesKExroRLd238HenfaSBlw/99?=
 =?us-ascii?Q?iUdUjJYLyCzxt1KOBcZycLhR4KMeUpjfV83HM46q7fF0vJxQWBKkXj9sjhXz?=
 =?us-ascii?Q?5lQuyNqiM8Y0e+GBZrNoLh6LSI2SQnIOaJSBQ0vdhuDWudlilXWiGTL1khga?=
 =?us-ascii?Q?MW54e3+Xy7vfsa+hfPlNcFAEfvuxOSaJb27qz4Y8d9jvUd2a4dryF2Mu8934?=
 =?us-ascii?Q?5LW2EEAl8weTWCXQP2EWq/s9076U8JKN6wOzonhPwHVzOa4CfU2AfW+9zuaC?=
 =?us-ascii?Q?byD5GvYtnQ7XDfZkkmgc4LsrX4OFbQhjvtq6TaLQiGObL8zDbcCIMync4dWL?=
 =?us-ascii?Q?csBxGYHEAyngH7bn/XnSjArQqaB6EkR595mSSas1J2O0qraf2CPzmNzfFgqG?=
 =?us-ascii?Q?+gQ/wclW8jipoNh49hOiMbMIFJQTTiZ8yxGI?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 14:39:52.1212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfbbfb4-529a-4709-5828-08dddff76c33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6570
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 20 Aug 2025 14:40:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2073

Add zephyr-openamp-rpmsg-mulit-services recipe to build out of tree
openamp-system-reference example applications.

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
Changes in v3:
   - Add machine compatible for qemu-cortex-r5 and stm32mp157c-dk2
     machines only.

Testing:

$ MACHINE=3Dqemu-cortex-r5 bitbake zephyr-openamp-rpmsg-multi-srv
$ MACHINE=3Dstm32mp157c-dk2 bitbake zephyr-openamp-rpmsg-multi-srv
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


