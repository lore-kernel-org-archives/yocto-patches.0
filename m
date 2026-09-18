Return-Path: <daniel.turull@ericsson.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94435C982DC
	for <webhook@archiver.kernel.org>; Fri, 18 Sep 2026 12:04:01 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9530.1789733033104334961
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Sep 2026 05:03:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ericsson.com header.s=selector2 header.b=gg1Wlxa+;
 spf=pass (domain: ericsson.com, ip: 40.107.162.15, mailfrom: edaturu@ericsson.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhMVgSQgfUCabeyBF+JMq3q1Oo5hZYGgRT75OwP6gT1MtPPyGQLEpjiZvMRSNUOd0DWOUVvgFudUX1NpjtojlktyDJUhnnveu+vShGytgp5RA/l9AFN1GANKMYC3ts3ezciCi9saeK9NBe5om1+iFIiVGXQOnHQtf3dPDQF3CdrHXniXgEZW3hfSGwOnGkMsbcZc2hE3v09F2kXuyrnhw0B1zWhzLCNbwCNuWhIXZZDyqz4X7hMOzUcWuglRa2X6Xjds44d5TzTD27Kw313XJNvjtQVWeiUKipwZGaS18EyBGTMTSFJZpTtYGCD/zJCQq8NaMTwrVxTX1L2G3P1m2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v6nLuPmFXWXhQ8e+sRW3yp+LP7qiNyiRwCvjErw+dI=;
 b=IJKJUauHbAryfDX5pDTIRMK0bfjYq3jZNeJwRCwEE8vOiRH9Y7BwnEX5Pfs5tKhfydmiyFOCFLv7+HFBZNa8YSoZLdXb2NyEa/+0EcnhRjCjSWTRkwPj35dDzeSD4ODMnac9Kg11djqWA/SgUmud6CbWFALAvXAYGEKOfa71ovmPR/DA1lfJM/FZ0xy4pFAoTzNRmHl+Jo2ooTXvoVnTXVs4t3MGTJrvQfdALu1AIp3A6gBjerNwoiJr3eFFAenn0meunBlLU1Itisgvrgn6BToWT0RxBYNgATJXvpXaNJmSE+jX5PyCuV41q8oqUeXY9NigpormknmqUIct0L4C/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=gmail.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v6nLuPmFXWXhQ8e+sRW3yp+LP7qiNyiRwCvjErw+dI=;
 b=gg1Wlxa+dMFNfguh5gSELjU6avzpkvWfnPEgEY8yOFQI4D8Gv1yCws2daXpHFGX1TNkaj+X22kREwD3iHWsC0cPG9umBwaSLz0bNqWQ9pITd9GxFzEqWuCHhnXEp3GCR0g61Zi+IWDqaWeMhxNIXy0tQ/ObScLq3OVX9EV13M0TlaMSUfRjnfQCzwt+DKOkfBSfMb25mLZVqanKFml+U/+O8WCyQ7JG+Vy7zLaJQm+wUtq2I+uzDcaMtx+PorLHtB1kKPmwKqcfGXSohJefRogb7t1rzKjwNTLTBZl89uA9AQyG6qRLWLTzltXGuEaybqxG/xmVEPKa2pwntNFnyEQ==
Received: from DUZPR01CA0200.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::10) by AS4PR07MB8828.eurprd07.prod.outlook.com
 (2603:10a6:20b:4f6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 12:03:49 +0000
Received: from DB1PEPF000509FD.eurprd03.prod.outlook.com
 (2603:10a6:10:4b6:cafe::1f) by DUZPR01CA0200.outlook.office365.com
 (2603:10a6:10:4b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 12:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509FD.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Fri, 18 Sep 2026 12:03:48 +0000
Received: from seroius18815.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 18 Sep 2026 14:03:48 +0200
Received: from seroius08462.sero.gic.ericsson.se (seroius08462.sero.gic.ericsson.se [10.63.237.245])
	by seroius18815.sero.gic.ericsson.se (Postfix) with ESMTP id C914E4020B4B;
	Fri, 18 Sep 2026 14:03:47 +0200 (CEST)
Received: by seroius08462.sero.gic.ericsson.se (Postfix, from userid 160155)
	id 9A259700CF29; Fri, 18 Sep 2026 14:03:47 +0200 (CEST)
From: <daniel.turull@ericsson.com>
To: <yocto-patches@lists.yoctoproject.org>
CC: <alex.kanavin@gmail.com>, Daniel Turull <daniel.turull@ericsson.com>
Subject: [auh][PATCH 4/4] steps: remove unnecessary removal of metadata
Date: Fri, 18 Sep 2026 14:03:36 +0200
Message-ID: <20260918120342.772566-4-daniel.turull@ericsson.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918120342.772566-1-daniel.turull@ericsson.com>
References: <20260918120342.772566-1-daniel.turull@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FD:EE_|AS4PR07MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3aaddf-8e53-4764-fd93-08df157ce60e
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	QOM43wi8nahAvUJIgZ8yTGfVGT12b6ISUQnDl/YACjlFywiEkaYOCs2tiIhSRA88QdOduL0+rauLoAnuQ52jp5GKMZIPMhR+x9kZb/y9y3oqwTWca+5ULsE0QfFFG49zwZ4NfZFhwLZ6cnjAInHQTypilXicAowl53jrciPmrM2clhY4cLPyXBaZ7QofEwFyzJiNhjwt0+tItf+8/BAvMrPtlCXKrpEPioxcxkg2N5FrMpBlP7sXGan56bk3JjJVoHwQRN4KDWjYVm8bxbFzimZMGh2jZiQ4R882qLG1IgIPPkANGsYuciLEH80ijpzgolIKXD/OqAjMscXLogsB7oc1RqoGddLlyOReGsN32YOcH3H22d7FNTpsgaNQEFn+lEpv9iY9TNARdu+YoJfFWdbxFTx4SzlkP8o2ma8CElfkuvx7lVYvlWTZ7GGMEFoTXnojSGim+SvF+PxMpOt/0bmsV853mdoOHs471qL6EYQpwnNYxEfXkC4uX2j3dP/V+ddG652RO5O/bUNSuA0HgV64Mv3UfB2Nyssiar9+a/0DRfpsHRag36n+26XylKbGxJU5M30UC1+m9mfjD51tg5ehMub8T0Df2rdWYTE1lPiCXyXigVrDJAj+flSPTQ++5VLhBMAc8nlH0UuycVBBM9Oayw1LsQlZqC8JhKvL343zvFoO13fsQLFiA6hd3TDQoEG4ZhNS92BpPRjy+myuqw==
X-Forefront-Antispam-Report: 
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	i0tTXswk9H5Lrb2E38x7SvcT75wrTd+MZcqf/bxQjEYZ/2f/i/BksdW6FrFOP0rzUZBOm3OdizV2hdMi5n85YZ39kZDeV6Tu6KjWPx4Etdm/DcEZzLciyMO926SDRdWvfAuByBQ+mHqVwC5FKxLw+Fb89gGORCVsekbZojnErGF3S3SMaRTYzEA/LYaTjkvOgGlBZiaryE9lZQz0Sp10TBCezIT/vQZ4Mg0YDCv9lr5Yvp1LsfvOsUjwriYOgzlVHaFsVDWBTUgyDHvYH7Odo5ynx8OH5Y2Z6EvDxUHmBMis22fs1/b+10JcHz11vtR5QwdmQ4Dhw8KyeqMhSd2BwlGqmlfzGL01yeOmjAiypyjOre/rq5mx5YTYSQkixs2lcUud5KY55tJw24Y5UcjievpeWCjkZLdy+9bHMl3VX3MjnfsmRF+eblUIqmVqdAvE
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 12:03:48.8942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3aaddf-8e53-4764-fd93-08df157ce60e
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509FD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8828
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Sep 2026 12:04:01 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4904

From: Daniel Turull <daniel.turull@ericsson.com>

In devtool upgrade now the metadata is stored in a json file and
the changelog file contains only the changelog.

Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
---
 modules/steps.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/modules/steps.py b/modules/steps.py
index b95472d..9d22a1a 100644
--- a/modules/steps.py
+++ b/modules/steps.py
@@ -102,8 +102,6 @@ def _append_changelog_to_commit_msg(group, opts):
         if 'changelog_text' not in p:
             continue
         text =3D p['changelog_text'].strip()
-        if text.startswith('Changelog for '):
-            text =3D text[text.index('\n') + 1:].strip()
         if len(text) > max_len:
             text =3D (text[:max_len] + "\n\n[Changelog truncated as it exc=
eeds {} characters; \n"
                     "the full changelog can be found in an attachment to t=
he AUH email]".format(max_len))

