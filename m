Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F134FE5219
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 11:46:26 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19328.1777031176080062533
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 04:46:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector1 header.b=LeMckSL2;
 spf=pass (domain: ericsson.com, ip: 40.107.162.30, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ClsH/ACUBHwgRnR2h6LVdFJEm3850Bee7mZF0gFdrri98hqdixfWMYgYqEWP2krZ1Xb55v5U/so2PlpQgSnJHW25S4GcE0EeDUw4oIfXCenLZLtv8qgQo22P7WBmaa1eQa+aVs/4la2RoB/QyYSCi1MgCUXM7PphAyOajtTmy4eN/xGyUFwV41C15zm04Tf57xtQ9s0NxqeyLazqB7CwYOVTStVPTf4PX/z9l4nI9mZpF+gzBGZmfo6tqcSYefuERZLfxibTrQ6oMyqXjA3wm7W1RFd2grYD8umIgGdTw3J0JU7yCIaMRMoHM3GBgugBxJe8cQnRO0eNbimawhSmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVMEHPXF3MyYoToqhlD+dEMc5JNanWeAXM3fuICoNOY=;
 b=SxEjSufn2V68weg1DSYbqOlKwN/4j2DHzBhBqf3Wo1qKrFaS9EN1MTQbQOsxAS4YUlQiHMLjOTKw0wiAji5PpPSbrcoELaX4MYp+d56s9Qq/VSKefrcnruxsCrdnzOB6kEfz1A9OMcPCjTKg2deqOOcaYy8Zyx6I/2cN3PheeBsTaqa0AOQJfoOzcD/PH0XzTCcS/waphYZodK2podphcr813K0ZfaoIXHnfouILotJ8QTYJIrJh6CW8dhhHOSw9suAvWOqMwmEMWb4iYmpIb6NumBf656YZBEMdCoA8TITulVmDzcIj8p41M2xXMMGlVWQExFe8JANS3LvEdF4tlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=arm.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVMEHPXF3MyYoToqhlD+dEMc5JNanWeAXM3fuICoNOY=;
 b=LeMckSL2tEPLrLfXXCn8o7l2kCuoC6FEHVXYFdH7v1RNmAw62Am0KNtLMw0eQ9eAqVb9F6H2MxEnFiH3YOx4mHUDuB/2KYEwfcjSiyO53oHLlkWxCNHZjEblVXRavzTNMFTScJGhLd7erFcDGdW3VXdw9f8yTb9v7qlOb2GBdnrLJU6vU7jxnCk29lp1e1btnxUHusM6PHgz0OkLjVoSZbjTwGQCOGhJfcC0It84J4IbYy0KEvg1B1IoCxb0JLbi/PVAxuRLffGXpBzTU6Gy5Z4VvCliCXGa0sE4PHrQdkkAfLZf4DWSUmxErZofWzEZoC9aodCGFRUnTGyVVCYvvA==
Received: from CWLP265CA0539.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18d::16)
 by AM7PR07MB6438.eurprd07.prod.outlook.com (2603:10a6:20b:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 11:46:11 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:400:18d:cafe::ae) by CWLP265CA0539.outlook.office365.com
 (2603:10a6:400:18d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 11:46:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 11:46:10 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 13:46:10 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id E6FCB4020B4A;
	Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id D1364700CF09; Fri, 24 Apr 2026 13:46:09 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, <paul@pbarker.dev>, <ross.burton@arm.com>,
	<yoann.congal@smile.fr>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [AUH][PATCH v2 0/9] upgrade_helper: scarthgap compatibility, stable updates and changelog extraction
Date: Fri, 24 Apr 2026 13:45:54 +0200
Message-ID: <20260424114603.2444938-1-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AM7PR07MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e367680-364e-4ae7-33e0-08dea1f714ab
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	pNmaVRdyfFIcqlNT7Me6cHPHQGV6s4GXLJDIg5PyhKEbVQiRaWOyBylxx+TEL9I451KsJ87CBCTQCE8CsPII+FCW88QNYRZhFby5uByRpw9N7nyEteSw7Lsu3vuFkOJMIOTWF38fvAnFYg/USbHCNKHATNPq6eIRAYzXQxfNVfgTN134ipbXhCnut0yvd1zIphl2Z1fPmxpxQKTcOpUkvonR8mEz2idvhkSQZogLcRHsmGkNeoj6pmZJASy00Kkv6lZVdYUWrLJgS/JqFSUacMkbkHEzuX2o8BTb2np5j84ot0/49bLt8fHKGxVcYRP8woJtqlPAQTiY+PdUuwPctNXN5rlbF8eSL3rREejeCzg9BtWOblloQ7/UNv4WRJKoqgvMybocE8Vo0HZ5t1v58Vx+31h+GNjshxk4RG+KSRb0kJ73iQ4LOQIpLQcza+5iicq/pvX1mqx6IWngrlIqcgJyN+a2FCCZqMGfy4ZGJmSSBIr8afAv8/IKBjIZGhFKFHXgfYM59lU/ySvgZmPM2yb98r6oasLvkib183gJnPNKFUzHpHPCy21y95MyDJ3idFflPfp1lBXkjBzBdLp6G0kdQJk+QLZAqimXdxBg8gkEs+s5xLspfYMRjADxwJTQ7QlOa+aQKY6hxQ23Zr3CP/1SeMJchzjsqYVboe+XzwVHLK77cyxED7y99hNBIuAA0TjVdjGyL8yOsXRQ9cTxS/vCQv0llt5qVBmBXtowVVE=
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	D9ouIiQdPbRil05oo8y+44tkiGQjEh3cB6hqdtqma1F/X6qOsyCHvHj3v2uqyWY7SYdQ0kGrtMwu4Xw6t+6nz8084P5DbF6K1uOuZA0nXg4op78CXRkWzuPB6DOlNGFhvS5Dka1ljhScc7ddbgtP6hmeti7EEmIl1pEW+/Ed2ifimYVYDbkqGp4avPH9aRMBu0hScMs+g1a0miv/kWCWELOXt8hsp6Nlx+MM/Q8MQiMLXpOYNAr9yvljv0opIuubiBnRNAzt4tWbomA9frvqLVv2IU5BIE8VaT2ziqEWfK4k6EYpgax2UX1rSrXPi1PJlW5BpfkafPNdTzjoyoNSvykkKhctXsxKVla/w1Eb5n7HAUKck1l7x32SPMv/hoU/p2owit21vvaw3CxL4eJFNZsn5R5EnF8/shBo6ok4WRre629paoE9ozAXJqI2SlzE
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 11:46:10.8365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e367680-364e-4ae7-33e0-08dea1f714ab
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6438
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 11:46:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3792

From: Daniel Turull <daniel.turull@ericsson.com>

This patch series allow to run upgrade-helper both in master and scarthgap.

This allows to be able to automatically generate patches for updating patch=
ed or
minor versions, which can help on the security work fixing vulnerabilities.

It adds also the option to extract the changelog with different strategies

It can also prebuild the recipe to be able to compare before and after the =
update,
so it could be connected with ABI changes with meta-binaryaudit [1],
so if there are incompatible changes the upgrade fails.

Example with OE-core scarthgap, there are 156 potential updates

vte: no suitable version available, skipping
 ########### The list of recipes to be upgraded #############
 , libubootenv, 0.3.5, 0.3.7, Stefano Babic <sbabic@denx.de>, 1e3511ed77f79=
4ee5decc0974d54c8e5af26f64c
 , bind, 9.18.44, 9.18.48, Unassigned <unassigned@yoctoproject.org>, N/A
 , dhcpcd, 10.0.6, 10.0.10, Unassigned <unassigned@yoctoproject.org>, N/A
 , libpcap, 1.10.4, 1.10.6, Anuj Mittal <anuj.mittal@intel.com>, N/A
 , ppp, 2.5.0, 2.5.2, Hongxu Jia <hongxu.jia@windriver.com>, N/A
 , socat, 1.8.0.0, 1.8.0.3, Hongxu Jia <hongxu.jia@windriver.com>, N/A
 , base-passwd, 3.6.3, 3.6.8, Anuj Mittal <anuj.mittal@intel.com>, N/A
 , ifupdown, 0.8.41, 0.8.45, Anuj Mittal <anuj.mittal@intel.com>, N/A
 , libxcrypt-compat, 4.4.36, 4.4.38, Khem Raj <raj.khem@gmail.com>, N/A
 , libxcrypt, 4.4.36, 4.4.38, Khem Raj <raj.khem@gmail.com>, N/A
 , ovmf, edk2-stable202402, edk2-stable202602, Unassigned <unassigned@yocto=
project.org>, b7a715f7c03c45c6b4575bf88596bfd79658b8ce
 , util-linux-libuuid, 2.39.3, 2.39.4, Chen Qi <Qi.Chen@windriver.com>, N/A
 , util-linux, 2.39.3, 2.39.4, Chen Qi <Qi.Chen@windriver.com>, N/A
...
 , numactl, 2.0.18, 2.0.19, Richard Purdie <richard.purdie@linuxfoundation.=
org>, 3bc85e37d5a30da6790cb7e8bb488bb8f679170f
 , taglib, 2.0.1, 2.0.2, Anuj Mittal <anuj.mittal@intel.com>, N/A
 , utfcpp, 4.0.5, 4.0.9, Anuj Mittal <anuj.mittal@intel.com>, 63d64de49fd6b=
829f7c8694df5ab2ee625cb7134
 , xxhash, 0.8.2, 0.8.3, Alexander Kanavin <alex.kanavin@gmail.com>, e626a7=
2bc2321cd320e953a0ccf1584cad60f363

[...]
 ############################################################
 Building gcc runtimes ...
  building gcc runtime for qemux86-64
  building gcc runtime for qemuarm_musl
 ATTEMPT PACKAGE GROUP 1/156
[...]

Tested with on openembedded-core with latest scarthgap version (2026-04-07)
../auto-upgrade-helper/upgrade-helper.py all --layer-dir ../openembedded-co=
re --changelog  --stable --prebuild

    TOTAL: attempted=3D135 succeeded=3D81(60.00%) failed=3D54(40.00%)

Examples of the patches in my contrib branch [2]

[1] https://github.com/Nordix/meta-binaryaudit
[2] https://git.openembedded.org/openembedded-core-contrib/log/?h=3Ddturull=
/scarthgap-auh

Changes in v2:
- Split scarthgap compat into two commits: compatibility [1/9] and
  fetch error handling [2/9]
- Fix iterator exhaustion: materialise executor.map() results into a
  list so a single fetch error no longer silently truncates the scan [2/9]
- Split --stable into its own commit (was squashed into changelog) [5/9]
- Fix --minor help text and docstring to accurately describe behavior
  (any same-major upgrade); drop version length equality constraint [6/9]
- Fix --prebuild to pass space-separated targets to bitbake instead
  of comma-joined group name [7/9]
- Fix --resume to match individual recipe names against the skip set
  instead of the comma-joined group name [8/9]
- Add scan_workers rate limiting to avoid overwhelming upstream servers
  during version checks (configurable via scan_workers in config) [9/9]
- Reorder commits so each feature is independently functional:
  scarthgap compat, layer-dir, changelog, stable, minor, prebuild,
  resume, scan_workers

Daniel Turull (9):
  upgrade-helper.py: Add compatibility with Yocto scarthgap
  upgrade-helper.py: Handle fetch errors gracefully during version scan
  upgrade-helper.py: allow to set the git directory from layer-dir
  upgrade-helper.py: add changelog flag
  upgrade-helper.py: Add stable option for patch-only upgrades
  upgrade-helper.py: Add minor option for minor version upgrades
  upgrade-helper.py: Add prebuild option
  upgrade-helper.py: Add resume option to skip already attempted recipes
  upgrade-helper.py: Limit number of requests to remote servers

 modules/changelog.py     | 256 +++++++++++++++++++++++++++++++++++++++
 modules/steps.py         |  22 +++-
 modules/utils/bitbake.py |   8 +-
 modules/utils/version.py | 175 ++++++++++++++++++++++++++
 upgrade-helper.py        | 152 ++++++++++++++++++++++-
 5 files changed, 609 insertions(+), 4 deletions(-)
 create mode 100644 modules/changelog.py
 create mode 100644 modules/utils/version.py

--=20
2.34.1


