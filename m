Return-Path: <sandeep.gundlupet-raju@amd.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A29FC9ED7
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 04:44:09 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com (BL2PR02CU003.outbound.protection.outlook.com [52.101.52.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3313.1772858639413380010
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Mar 2026 20:43:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@amd.com header.s=selector1 header.b=uV3h7+2F;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.52.1, mailfrom: sandeep.gundlupet-raju@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p87pDi4cDR+p1VkEUL8C1Yi/OdjXpRFQ7lUXv9a6msN+/B4Wsos2AyOTdsxDGzzat4moa2NUg5ny0uJJCJv4PxrJCe8GNvvAQJzbAii+ncHt5eGRWhtXqmhQ2w7bA9phiw9ppsEqLIfXUXOhoPiJRmY308pENv9KrM1rH4ZMfRKSsLnO9QbHGbcCFMn7le92Z86BR3UKPFxqNmEPX+sfvnFQ86spBg4s7uFn7vYaRVP02+b9VWj29EuZPc7yzGB27vEKy+fdtc6AR/R41RIxtS7rJtWAH+qu7m1NrI5Boe38djAPStAc4h8wkc9BOLXd0luc4Fvch397g6Jxy8rrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZ9ssqaZB14kHORNqNqffJSnlOtT9Gj9/4Z6IFzQTII=;
 b=YNROHwSjlLtzwtC+2m+RccSj2MghZpdeG2eAbOcMvOZOYes1oP7Pq4Ih4EhNG75l7WrbeDIX6xTVky9einBYcjYnSG0zDOPXJiCJT4AWYYxnWmllNuQcM2EbsdVnZDmSyKIGKdoOA3wurANm+PS5lurrm9eqNtTIMZHXx8dq1EokdEvurGEVHmKqM9q2vR1aRYBNA6Oq6BZ8mMm8kZfJm8WmPWJuWmhUNydZBpK2XWERBz1aejZZXXcwJASTcQ6KHiv+GFiyaPhpdkwlg/KLER7R9YZqCB0Opz2fDJC24sHS2qVOOxdYmRZvughnBrVvtA5NmexxAmDOy0kSqvaTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.yoctoproject.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZ9ssqaZB14kHORNqNqffJSnlOtT9Gj9/4Z6IFzQTII=;
 b=uV3h7+2Fj4s2zXST5k+KPLox19N5qNlwf/ewDjjJKY5XxIH0DH+DaZEAr2ssoRzEmUr24R6WVOM2FDHUs84UJEufO/OraGpLwW8j6Kb7ewzsIHHmhwxVVS1rbdzw6jXejZtE+d0fC8RHtmksrl0KBlM4lYJ193k8GtXpHO/da7c=
Received: from DM6PR11CA0037.namprd11.prod.outlook.com (2603:10b6:5:14c::14)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 04:43:55 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::e5) by DM6PR11CA0037.outlook.office365.com
 (2603:10b6:5:14c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Sat,
 7 Mar 2026 04:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 04:43:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 22:43:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 22:43:54 -0600
Received: from xcosswyocto01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 22:43:54 -0600
From: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <chee.yang.lee@intel.com>
Subject: [yocto-patches][meta-zephyr][master][PATCH 4/9] generate-version.py: Add verion and help options
Date: Fri, 6 Mar 2026 21:43:48 -0700
Message-ID: <20260307044353.1936182-5-sandeep.gundlupet-raju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ffae79-0564-4020-9b96-08de7c0423ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	Y8xHl2KxVwxapOEBqdVyo/MUyBNwqwy63tGb1Ld3n0hVkobNb05acR1Vzvj0l8hEKyU8AP0QEqNELYpo3agStgmMbIRBHWgEdK1PVz0Mjfv9tYL72nYc/B0dvFZ4OjinD4HbPecmX0zT85RRzT53y8NbfKdkFCHYuevHnYIC8gRiBxc4JUglVYNc9RJt3pCBkNenrZuMvUdS7n820bgIL/Z3axO6Z3CZs+sjEJu/gGv0vjDEdM+VCBCG44Fv4JQblajXRIAddtA8JdcihqVgfKSRbm0sqIprr2whow11/HmugwONTy+4QefkFOxQEJOUJHJ+2k/zVOAvYyNsVZHbVkuQElz7WnLHym5HSntoA1KTboUgmWThEFfIu0O6Wdh45uwNPUAVRm+Ntsu8RtFSHR9DbWdBJnN/dep5uujCSQugvD6M2dbM9VVjoXBOJ4nCnzjaXHKndzpDGsNVUWJgRF51UsGeeOV59G5Fkuy9kUzWBGNAX3rer4zl378Tf3xRHQsLzMih+3bg7Wrx65WxkKII5FSt0LuX232Y4seBC3ZJFMK5dzcubzG7dEcPN+8cutov8hI245AbyoUpHCTZ35AD3nJHCjdRCUIXxM9Mly5TtDKQ/F6qMbooLfon7jPw4gWbPzSHwgiXb9Ht4mTS2QvR/b4exPyXnWb17YjW+kYY3CE6oB8QxQSUmT8eQaihE+G8bE4iGhaj+oYmp+cZVEtmtyuGfcp6F1xqw6AulfQ=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	fa67e3LRHRFOGgGOpUYBbWzFAKugwv6dMZZ+HeVWWY7AMGMuu2LqHg9jC2OnU/pBg9Kh23ZyCmzGDMKQO/uT2xNMLPS/25GALcuCyxFwlQIeOu8VyPZ81s+vQb2bEDzUgFObOAtVQAxY4fXaC8oRzYNGDbAHy4JAPW0KLePuN3vhCrRRqIOX52EpqNgBrKdrCVAACc2j4wix9SZSzKrx5FOxVF4rp18fq4YmiyAXiwQeXag6d6r81meH89nnQHCvnBWCRGwm8aksiBROTDBK+1AQZq7nROKEtJRm4pwRx4zt9WiNezdogF3cLg8S6+1oKU5TC+vYSL5HaNy763dBLfWNqQmYOT4JRJnXzdPW42w7HTq3FlSIOU6sYqijUKR3+PBC9PgjmNmLyRQ+0mgIZEMJgy9VD+4oavWsMRfLJvBNYGy1ga7va0HS8EEutF4o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 04:43:55.7027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ffae79-0564-4020-9b96-08de7c0423ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 07 Mar 2026 04:44:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3356

Replace basic sys.argv argument parsing with argparse module to provide:
- Change the Zephyr version argument from a positional argument to an
  explicit -v/--version option, making the intent clearer at the command
  line.
- Proper -h/--help option with usage information.
- Better error messages for invalid version format.
- Usage examples in help text.
- Improved user experience.
- Update README.md with usage.

The script now displays helpful information when called with --help:
  $ generate-version.py --help
  usage: generate-version.py [-h] -v VERSION

  Generate Zephyr kernel source include file for a specific version

  options:
    -h, --help            show this help message and exit
    -v VERSION, --version VERSION
                        Zephyr version in the form x.y.z (e.g., 3.7.0, 4.3.=
0)

  Example:
    generate-version.py -v 3.7.0
    generate-version.py --version 4.3.0

AI-Generated: GitHub Copilot (Claude Sonnet 4.6)

Signed-off-by: Sandeep Gundlupet Raju <sandeep.gundlupet-raju@amd.com>
---
 README.md                                    |  2 +-
 meta-zephyr-core/scripts/generate-version.py | 25 ++++++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/README.md b/README.md
index 0aa55e1..4a7d75a 100644
--- a/README.md
+++ b/README.md
@@ -216,7 +216,7 @@ Yocto configuration for a Zephyr version from the West =
configuration in the
 Zephyr repository. It requires the west and jinja2 Python packages to be
 installed on the host. Run it as follows:
 ```
-    $ ./meta-zephyr-core/scripts/generate-version.py x.x.x
+    $ ./meta-zephyr-core/scripts/generate-version.py -v x.x.x
 ```
=20
 where x.x.x is the Zephyr version.
diff --git a/meta-zephyr-core/scripts/generate-version.py b/meta-zephyr-cor=
e/scripts/generate-version.py
index d795a70..c8f79d4 100755
--- a/meta-zephyr-core/scripts/generate-version.py
+++ b/meta-zephyr-core/scripts/generate-version.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python3
=20
+import argparse
 import pathlib
 import re
 import subprocess
@@ -11,10 +12,26 @@ import urllib.request
 import jinja2
 import west.manifest
=20
-# This script takes one argument - the Zephyr version in the form x.y.z
-version =3D sys.argv[1]
-if not re.match(r'\d+.\d+.\d+', version):
-    raise ValueError("Please provide a valid Zephyr version")
+# Set up argument parser
+parser =3D argparse.ArgumentParser(
+    description=3D'Generate Zephyr kernel source include file for a specif=
ic version',
+    formatter_class=3Dargparse.RawDescriptionHelpFormatter,
+    epilog=3D'''
+Example:
+  %(prog)s -v 3.7.0
+  %(prog)s --version 4.3.0
+    ''')
+parser.add_argument('-v', '--version',
+                    required=3DTrue,
+                    metavar=3D'VERSION',
+                    help=3D'Zephyr version in the form x.y.z (e.g., 3.7.0,=
 4.3.0)')
+
+args =3D parser.parse_args()
+version =3D args.version
+
+# Validate version format
+if not re.match(r'\d+\.\d+\.\d+', version):
+    parser.error(f"Invalid version format: '{version}'. Please provide a v=
alid Zephyr version (e.g., 3.7.0)")
=20
 # Obtain the West manifest and decode using west as a library
 manifest_url =3D f'https://raw.githubusercontent.com/zephyrproject-rtos/ze=
phyr/v{version}/west.yml'
--=20
2.34.1


