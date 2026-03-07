Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EEFC9ED5
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:09 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3312.1772858639176905117
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=IXXaDGq3;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.46.32, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSfBvEEv0+BmmBoz4Z13VnmmudlG8xnc5H8R3J5n29ylG5Kh+dwmF9Z+QaZr4T2Odgn5Eq0eNqImWkbxfn8lVPUNeQ8+GaOqi6JP4KOn0MzffbZ6esn7dNGEf/pQ9wChWU7KXvSjCamdzOZEYGwyyI5it7wTT0y03XrfLjJTPqwY+5SfRxFb5HU2MSx+v694fyuHh8jnrCBRwaG4O/FvvZnXBQmF8kF7/VBcXCHykHNVLYIx7g5gB5DiswwbgX/YyZ/05RFVTxaa8vFYklw2UBACuR5c8zX9oe5EwyOgw4To2NB33d61NHBbbwTt4WZIGADy/wnoB7F7UwjN2BwBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D90rN7FAeyOFmaROxRGtTTMViJfKU+F/OqqKaRzA2RU=;
 b=iKWTUkBWrzmRNYk3QOIqxYVjDwoYXE9IvG0kym0OTjfBhMiEtaxCBI9NYVJbrGqLVo5Ld5w6kF2uhDJtJf2RT6Kk3mqAF/jmi9u9RziSHwDPeojy27fXIcqsQ5ljr6+zHTwXjRwr7tAN4ge5b0NgrDA6QFaYEu5SBSNtnDUgA4rg2aM5Mo62fANUGC0adDPDJVgscXahTkCNYJVhh3L1xe2VHP8/+2g9YcKe0R2owU8xCpxnGSRykBEu56TSR3EQMUw3nMZyGjzJlRZvWvzXyOaNedUt9np5P0WLPmr4NFochpj9uuQzK0/7lJ+v+9T4zRnmP+3ru8h3fAIeFaYssg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D90rN7FAeyOFmaROxRGtTTMViJfKU+F/OqqKaRzA2RU=;
 b=IXXaDGq3cg3bU6JhAyA3IZP1ItAME6asMnPZJ+XQ5bq1Vz4ay2ww8mudaEs2JXfsuOblbrp16NfKL3D2dw6D0SPDXeqYjmCxIGHziszB+0iGBZ9CFuB7TEzeEwOgefl7dVflNKsUAZmAx2siZ4koIIdEiHyuwY/aGok1I9M+ZOY=
Received: from SA1PR02CA0008.namprd02.prod.outlook.com (2603:10b6:806:2cf::13)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 04:43:56 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::e2) by SA1PR02CA0008.outlook.office365.com
 (2603:10b6:806:2cf::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.20 via Frontend Transport; Sat,
 7 Mar 2026 04:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:54 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:54 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:54 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 2/9] zephyr-sdk: Add back sdk 0.16.9
Date: Fri, 6 Mar 2026 21:43:46 -0700
Message-ID: <20260307044353.1936182-3-sandeep.gundlupet-raju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
References: <20260307044353.1936182-1-sandeep.gundlupet-raju@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c768822-5724-4604-5529-08de7c0423e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	Ohcfpbzly23iRnud+GFSzjpEd4gDrhM+FJXZYVZMhZSQ7JpTAogUnDnQvfD15oLJ0XfkpBZ3kcqBL/kb3gP2VmpY0lPC5HhX4DJbeU/4UscCGkASD51C4MRtR4gFMGR8fJkiRy6nUCu9e0DOqKlHeFdgodDa8Ut4rVz6oo90CiK6CoRrb4MFfH28yf2o8COaZZR/cETCsWV9gaohjS7V+ocxSSfv2ebQjiM7cw81rgbbVTSEZDd9jrQHxvQzB/RUBSSi8IAFVmwesguYLf3wTg0AYHB+IfLr4kicOt8HbjBaaiOtB+vP9/pll7iz1i3RZYXD3R02i8C84LAaJb+e7GyTq3KcR16iehnqfpjgkJDLddvEzN6MBWXW9eT2YfdTpwL6DNp3HbAMY6zQ1RofeqwnuzsNt8U9EzarTw0Fijeutl+IhmP5m8NDPcjfMkwH39kCyY76trbddx9bGvUK+G8sAB4CUAHhgQAvVO0YEy+fjaEmaM097ZlpWtmzrz0cSUwlmpha4dpOzqPC6S2YFvOUr8B3fRrvh5WJXEn1vT9LOZqUkSs6ibezs7qInOHriSBtr2jBYJXOdQbCZrmkeI6GvU4zy1uT6PLMVQi2V5e2BJIIets0dmpPWWGmVJmAAcS+OVimP9DwPKuLEwQsw0ReRVq8+oIR+WP6dxzw01stz8a0mAN9sKRR1Rj8+y1y67Bp9yDjhf/5FRq4s0inJ+t3DQcuQUXbqZlCxLtWcJE=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	wSYbrmRt6hqtFeV6gQTO5VhY1nCT8VZeNK5zunA97dTO+6CvpQgaMweAcVHhWrSMVv0OXTuWsTZtzR7T+BqlQvz+wLm6KwGoS/ohCkNHsS4C2GXVTIVqk5HHtcDygRxQKHoCFTvwFJscR9mTmOoGsyhNeLYNdLvF96ALN0s3Utrt9aS/pK9+1oE2AvGihxXneTuTP6dGp7nUWIKrcg5zgls5qePDzDtsIz7hh3OqghwmhYiXNphQsEb4vlRU70HR9yyEzIDOglFmOoe5BZeluY9fQcAHIyGeFFCLUi/KLT5xBiw1Kh3T165/+QxB+QNFhHSpocUGzvXRDHmbjnOuvloIqMhrdrBr/6JKoEuloXYil5l1F5L51oXjd1OQtN3i36hSA5maF5VZG2Bgr7B7CwQG6CUx6WqX8ju18c/Apn0tOndR35y8MX3HtNoB4nLE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:55.6720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c768822-5724-4604-5529-08de7c0423e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3355

Add back zephyr-sdk 0.16.9 as this is required for Zephyr LTS3 (v3.7)
and v3.7 version is not compatible with 0.17.x version. For more details
see https://github.com/zephyrproject-rtos/sdk-ng/wiki/Zephyr-Version-Compat=
ibility#zephyr-sdk-version-compatibility-matrix

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 .../recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb          | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk=
_0.16.9.bb

diff --git a/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9=
.bb b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
new file mode 100644
index 0000000..ba20341
--- /dev/null
+++ b/meta-zephyr-core/recipes-devtools/zephyr-sdk/zephyr-sdk_0.16.9.bb
@@ -0,0 +1,4 @@
+require zephyr-sdk.inc
+
+SRC_URI[x86_64.sha256sum] =3D "9b4b96f8df594801a84fce1aa112a84cdfcd430efc2=
a74229907b6421fb859a8"
+SRC_URI[aarch64.sha256sum] =3D "a8c1731ad602553304e539a7ade9cdb34caabc1850=
d581585cbba0372a7493b2"
--=20
2.34.1


