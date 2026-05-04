Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69C1CD3423
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:36:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9215.1777876591616761972
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 03 May 2026 23:36:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=s4a31rYt;
 spf=pass (domain: ericsson.com, ip: 40.107.162.52, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuZjpcx4A0Q8pPxo7l6d/pqegVEgEY4QAAYLsghs3RLiVoVpFakTQgSZWd2A1WUShPZdRBWyySuOUPnU8RdBWcBJ7D60d86/UzY6iD2plUtDixIUKd+Us2IlnHC17ZwvSZhIR9UpgzYfcNnROFxszaBLT8jzWvQS2Q1pk2dIZurDGk+JOqfpg475qlo4arhA8J8a8vhDqHDtFMuWxSGfj5cjdrS3+/nGKf5l/ZLZWQhGs+nV6uQt8UfpxlLZQe0hCuOyFfr+9lSRrzasrcL+3MYIitMZQZPN0RSPY5ZJv3/OS0E1i26LS604V5zYOuFqCyxqjZa7bzOkmj75APphqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHdo196OjkBuT5gATVRAE4NUtY8epgvQP96zNo6jFJY=;
 b=W7hB0k8wkgmDbo6JLJ4ZIrS7hgn1NN9lFFxIXE7hT/BCmt7Vk/agvc/ruY838thq6nh9M7wBnI7yS/u2UuW9hQQTuK+UN1sZ4nVUplBF8g6ApeSf9QwXS9XiXdOBbnJ4oe4A1GSRPckOqtG6wHaEm4j8XcIKPl97VZQDbkYzuu7Tg7jULzS01Dxh0HcaJbEO85dN8Tqlp4syiXTzr0UItbgrIuwAeqydKzlpUiwMvWyqHIjEXIJm7MkYzCE6zitosX97oIo4b35Fra6In7YLRo7CPDOXQSEUROw/0+5gfSfoChcgXO1cdJkCZRKvHXqe2y/r3yPWHnc9KBcDV3x9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHdo196OjkBuT5gATVRAE4NUtY8epgvQP96zNo6jFJY=;
 b=s4a31rYtWcjXrEp/pCk5mgbqGpYj8IA41JOL951/7Jd7UJ0+5lq92iyUNdYCS1WBJwa7OoHTkTLYMmWgigUxaqcIApfkqK+frACS+9dNtE1QPqFJ+Lc7nIPUo/aFWIPR61epKVQwusykh9+wtnXO0uUTopXiqauKKTwvds9r+CO2OsHl7JScVVi2JLvD5o8/GGq2jOW8qSw7efbrRAB+244387y9VkCtY8GF1X3SnPcG9bUZXYkEEIZ2MAIX31Ks7k18BETlAgQsQSDPcsxAPgzJJS69IRdkF8oYXWWG5isK+w1zL1YQdS5lAHqP95Q6is/kfQ2cc4bY1zqFijlwqw==
Received: from DUZPR01CA0135.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::6) by AS8PR07MB8989.eurprd07.prod.outlook.com
 (2603:10a6:20b:537::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 06:36:26 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::fe) by DUZPR01CA0135.outlook.office365.com
 (2603:10a6:10:4bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 06:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 06:36:26 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 4 May 2026 08:36:23 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id BE1BE4020B70;
	Mon,  4 May 2026 08:36:22 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id A820F700CF09; Mon,  4 May 2026 08:36:22 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <daniel.turull@ericsson.com>, <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>
Subject: [AUH][PATCH v3 0/4] upgrade_helper: scarthgap compatibility and stable updates
Date: Mon, 4 May 2026 08:36:08 +0200
Message-ID: <20260504063614.3831203-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|AS8PR07MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: b158ab61-58ed-453e-f5fc-08dea9a777db
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	pSR//z7/fZnM38ud1RwJX3vyx0nEovIG6VKJWOwbABvOoU8nwV30Py8cZr+9K4uWAlyx2yDKjclr6Spq8ISCw3SCjbzR2+O09dIJx32D+jJyV5N51ApHJC9XPV1D0cukJPlL6L3/er4MEfk1u/9Hcaek/p3zCeV+5066pvjD1TsycmBs2hvY8PkEBSEy3H9Gjh6pEkvoYAX6+/TOCjbisyNregcsddOBrml7K8zK/TLew+Yxv/8rCz/5OobHZOrgNXLJfkNY66+YhwstzjpIjvwbZTLMqFYbfoYqSpMuECWBfRyEQAJLlCa2hC8RWuMT/6GVU/s/IFXXh5K2QVG/ZiWDg6t3cAjR7nVRYvN80RKJ/PP8W5ucR7bT1pODLdlfpF2eWXnyqa2YGH5pzgsltOYE85PPqhCtxyn73KIZhhAMJC9uQHFuzyxP8sTLPKnQxuE4GE/qeuNDk8Ky5J9EAkCiv8US9dnY8xkm3Cn3al7ZFGYI4MZIdHpdRG0fkaFMUztl9Z8Rx6Ka6XkxELQVbPp8Pe2x5ihcaFUHfZnroEo09Q/a1eBGtP9IXmKwWoF2/a9jAwBFPHnc7TCH8xzBahYCgX5nHQkqnrDgxRHC3OVc3TDfQMzu4y1PHUYo1zjAxpU0plY62WaD0OL9lV6XjTG3kEiC50/xwjbUXbCzhdm6Q2r6/sAQbKVV8PFstgeDbFtqieYNqsXuk0plDrfaJTi/o7RF9W9q0ho9XeeIJL3L9MpYdivXT2SA5KhEz1yK
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9zsgt/XjAu8BNT57yxHVqOrPPx2SllMNSvfGgroSe5gjGXDaV8UBKj1P9bQpQPrLqs2hQkDSTwaOA8xAqQ64C8couy8DA/jszB5qtsC3Q9ziQhhaAR2u0WHGKmQIrEX5CeCBLHErpwUXRTzSKHXP89TA1e71O4sfAU40HePv/fQ5AHrU5R+1RemFj9zl2bWmKJyuUI+aV+b5UYdmDm8Q4kxAB7LDguA07j95CTJ0DtGehkNLIq1aAFvi5jxdllUQqsc5eS4LGYI+7K2UqPdn6KsAPMJgHRVCdO7jQ/Uv26XdNxS8TpV+HQCuqJfenIk1CONYm16d+5JGqOMStwdFuI91KQanEKZ+eF7BNdMf0VT5Ui5mrxgwekfQ0ZNc1uKc27ynKetp79XM64T5mchMVjX8sLZVSVRO5L5ZCHN4lax3uJ59K5kJLht7M6MfUODX
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 06:36:26.7838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b158ab61-58ed-453e-f5fc-08dea9a777db
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8989
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 06:36:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3902

From: Daniel Turull <daniel.turull@ericsson.com>

This patch series allow to run upgrade-helper both in master and scarthgap.

This allows to be able to automatically generate patches for updating patch=
ed or
minor versions, which can help on the security work fixing vulnerabilities.

When --stable is used, AUH restricts upgrades to patch-level by default.
Per-recipe policy can be overridden via AUH_UPGRADE_POLICY, which can be
set in a configuration file (e.g. local.conf) for testing across LTS
branches without modifying recipes:

  AUH_UPGRADE_POLICY:pn-curl =3D "minor"

or directly in the recipe file for upstream inclusion:

  AUH_UPGRADE_POLICY =3D "minor"

Supported values: "patch" (default), "minor", "none"

Daniel Turull (4):
  steps.py: resolve symlinks in recipe_dir
  upgrade-helper.py: Add compatibility with Yocto scarthgap
  upgrade-helper.py: Add stable option for patch-only upgrades
  upgrade-helper.py: Add resume option to skip already attempted recipes

Tested with on openembedded-core with latest scarthgap version (2026-04-07)
../auto-upgrade-helper/upgrade-helper.py all --stable

    TOTAL: attempted=3D135 succeeded=3D81(60.00%) failed=3D54(40.00%)

[1] https://github.com/Nordix/meta-binaryaudit
[2] https://git.openembedded.org/openembedded-core-contrib/log/?h=3Ddturull=
/scarthgap-auh

Changes in v2:
- Split scarthgap compat into two commits: compatibility and
  fetch error handling
- Split --stable into its own commit (was squashed into changelog)
- Reorder commits so each feature is independently functional

Changes in v3:
- Drop layer-dir, scan_workers, changelog, prebuild, and fetch-error
  patches as per Alex Kanavin feedback (changelog to be integrated
  into devtool; prebuild covered by buildhistory; fetch error to be
  fixed in oe-core's get_recipe_upgrade_status)
- Drop --minor as separate flag; replace with per-recipe
  AUH_UPGRADE_POLICY variable (patch/minor/none) read from tinfoil
- Add steps.py symlink fix (new patch, split from scarthgap compat)
- Rework scarthgap compat: use shutil.which for bitbake-config-build
  fallback with D() logging, add tuple length assertion, fix env
  string bug (MACHINE=3Dfoo None when TCLIBC unset)
- Rework --stable: use bb.fetch2.Fetch public API (not FetchData),
  fix is_patch_update off-by-one length guard, fix _get_git_versions
  break-on-blank-line dropping remaining tags, optimize quick-path
  to skip tinfoil for recipes already at patch version
- Rework --resume: use succeed/failed symlinks created immediately
  (not at end of run) as Alex suggested, use name-based comparison
  instead of object identity for symlink classification, add
  no-previous-run warning
- Series reduced from 9 to 4 patches

Daniel Turull (4):
  steps.py: resolve symlinks in recipe_dir
  upgrade-helper.py: Add compatibility with Yocto scarthgap
  upgrade-helper.py: Add stable option for patch-only upgrades
  upgrade-helper.py: Add resume option to skip already attempted recipes

 modules/steps.py         |   2 +-
 modules/utils/bitbake.py |  11 ++-
 modules/utils/version.py | 185 +++++++++++++++++++++++++++++++++++++++
 upgrade-helper.py        | 162 ++++++++++++++++++++++++++++++++--
 4 files changed, 348 insertions(+), 12 deletions(-)
 create mode 100644 modules/utils/version.py

--=20
2.34.1


