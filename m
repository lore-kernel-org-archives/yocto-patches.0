Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA50C5516F
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 16:04:30 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.813.1785513862329677969
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 31 Jul 2026 09:04:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=W5WwiU1M;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=W5WwiU1M;
 spf=pass (domain: arm.com, ip: 52.101.70.9, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FKZ22f8FUDi5UjOmvq3muZHrC+r7zk4AbWH8UBJ6bn5e2N1VnplRUULJj+QvpLHs2SGEigzmzLLN5B1TrjmXSJ6UBXg38MvDsIrpEe2zVQZy2YaBqt9AcDok3cxYRrCFwph30Uyc9Y9O9R2vEXV/UCtmU4STWGxt8Ht02UWQ8kgMzq97FfFyKdzQA6vl8+5sAf5LbVUOtitJGeo4NR9fn3jBSizqGGP3ESF+lIPIgI80nckm0z5z7TW0SLd/buWjt5PCyn3c45UHRda5K61nwmZerMy4zjiZ4+SM4tXYJ+gDhn+MrfAxH4Dg0Yq0PyYXMPb2ukpyrpC9u7UUD7sUqw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDD07FiYqz5Gert0m4p9yAplkpJxnAic9tVW8nx0cBo=;
 b=MdkHGQ8Zb99eop499Nryb1zTdGVKV+jrXWLXwXEKEV587R4GgH5CbplqQKu9J3BeJQIWWkuRRhP/OgU6NwMvszWrqkpeNomGCnIHacuWf9sDgFWbDvIobCgFntc2xFwTzzj27ySSpWgeTjBBKzHR6oktOTqixHFw0G700DDRSKROH4tVyvmLOkRttnD4ZaEXU84P8sXfDa3VAkQO4RE0soB4XSVIPdWAroDBda9Z1nIUsFLxbu/oJfkoAXPI4K59Uurhw4sNkvZUXUYe0Koz6Gv0M6HIf16V6FYimnY/PL5UK9HXWdPg4jzQz4T6LW5q8P1L/pYY3isYP/oFLkBkew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDD07FiYqz5Gert0m4p9yAplkpJxnAic9tVW8nx0cBo=;
 b=W5WwiU1MsyniKOJnYwqSQaTNdDJxWlo9VHwz2iDpMdm++IYQtizCAtCSpUqK2OmqQ/9+SRo0MNO7APAWtpbVmWFABlRQUGG4jg7QUylbLQyaFNZTfJ4raDl2r/uhEZeRNLyMTWVpBmd/P7BzcGOdZ+MXLHlRltjjc90655NxnhI=
Received: from AM0PR02CA0114.eurprd02.prod.outlook.com (2603:10a6:20b:28c::11)
 by DU2PR08MB7309.eurprd08.prod.outlook.com (2603:10a6:10:2e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 16:04:15 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::44) by AM0PR02CA0114.outlook.office365.com
 (2603:10a6:20b:28c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 16:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Fri, 31 Jul 2026 16:04:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFwBiOF0tVewfLA/EmMrqIMVnjYN41DDicfPRagLB3MZ/er4Zahh8w+Ec1+cIgaAqHw2MOMu/PBlpnXPdPYOMySS7ZpqEwnTul4vN8oD0JgUo86ImPiAubTCfd2dmqQcNf+Q3IhkAyAL++jdVTxOPgYp4OdeIi2t/UAdoxLnh6hisE/36WY8kw68U1HVpZJOL7lNhfQEa110NXC0cI241xzEQzZgCS4F7RYov4csPVXM9GqgVUWaqprB6cXuKBtCvcKOFAe/Oe53SxLI4ILLGVV54s/mJY36UwGwhrEUYOb1zMat0nVwh5uLIFTDtwRpsmwfTF/NeJXFkYj83y/A2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDD07FiYqz5Gert0m4p9yAplkpJxnAic9tVW8nx0cBo=;
 b=S36gramIELwM5pjYSmCEgGAzHFB77pAIDBj6PppbDXlmgqjwnjmOfuX6P/BmQi8+hHP1AeFIt70ksMNqK47561ioPt63cSBhB75rVPBaEsCOlArCe5Rl5Oxd9Cw6lQaXen1GyHH6anNp7k6wTks+OfoYS45/Aebk4qCoyrDp0IbX+9qlSVYvyWdoxLeVUiEOevZytdE4HFkUtB8+kWMpIdmcV82E1ugQkpffNpHYwJv25XbWo07YymH+FqXJcuVnQPBJRupjvvgTMIHJ+bsH6XK+mIO9F4dyW/8YvhoPNK52szFf+UVDgjq9vbi97Q2MkZZom0USX58iAlaTTrxTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDD07FiYqz5Gert0m4p9yAplkpJxnAic9tVW8nx0cBo=;
 b=W5WwiU1MsyniKOJnYwqSQaTNdDJxWlo9VHwz2iDpMdm++IYQtizCAtCSpUqK2OmqQ/9+SRo0MNO7APAWtpbVmWFABlRQUGG4jg7QUylbLQyaFNZTfJ4raDl2r/uhEZeRNLyMTWVpBmd/P7BzcGOdZ+MXLHlRltjjc90655NxnhI=
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com (2603:10a6:20b:287::19)
 by AM8PR08MB6612.eurprd08.prod.outlook.com (2603:10a6:20b:368::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 16:03:13 +0000
Received: from AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b]) by AM9PR08MB6258.eurprd08.prod.outlook.com
 ([fe80::171d:1f8b:720d:7a1b%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 16:03:12 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Joshua Watt <jpewhacker@gmail.com>
Subject: Re: [yocto-patches] [meta-mingw] [PATCH 3/3] mingw-w64: re-enable
 parallel builds
Thread-Topic: [yocto-patches] [meta-mingw] [PATCH 3/3] mingw-w64: re-enable
 parallel builds
Thread-Index: AQHdIQUofwHePITvm0CQ7/OXH6ZXvLaHyhWA
Date: Fri, 31 Jul 2026 16:03:12 +0000
Message-ID: <98347EF4-AB2B-4BCE-ABFA-673BD96A5997@arm.com>
References: <20260731155604.1486464-1-ross.burton@arm.com>
 <18C76AF3A9236A5A.1814903@lists.yoctoproject.org>
In-Reply-To: <18C76AF3A9236A5A.1814903@lists.yoctoproject.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.600.51.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AM9PR08MB6258:EE_|AM8PR08MB6612:EE_|AMS1EPF00000048:EE_|DU2PR08MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 80244252-a65e-4196-bb28-08deef1d5e5f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 
 ZMjfyfAYyC/csIokJFE1rdpx0yL1jXC98SfenAvFLgbj9UE+FOY9MRx7ZW2+y4Abjr46RROSmeCXpPewarqhjpEnexjN2T9qdCHe3q5Y0V5nVeCph///BwL8sYdXfTtf/OBTpfthrfNneuyjs09lhiqqovpRfYzoPsYPURNzlGVEldHx3pJIKm2zmdPFv3TTW003lnvgf7nibg4bpefOEzsXqSjzMMgccl1B1QackaSn9j9yXgTATUvQRDbjCmFcOgwr4WPQsbGD629dyEDTu0/BLiS8XFuLIBE1JH5QuTvpSCU2j6lEZF0uEtpe41eM1qzNMMFXeyiziOPCKXmZUXVI/xtq2ooHJ+YjAAVkilrSdssXwMYOvGj9xQxH07h7ikaEyjbO9STooLJNzJw2qhXFXwJUFEnqUZW5SsuRAiWC3v5HJc2piYbexZyq5kLjWRE44He+L4zkD5aQPC6v9+k2YyV5gpwcACBa7AYSVih2ErVYoTXMS7K+sTcxHp08pfXO2Z6n2rlkc0kWn0h6e5JtINnXuwK2L/OFILU3pdXhSeRFSw5vXfGZbxRlguYV2AB4D08g5jL71E0OSJcAvVU8a/XH1rr21q6JX3/eq+ADXt1/Ut7b6zv2jRMSQ+VYXbvHN5BRO9W0fOHItAwnKwyU5avMuV9eUcOfVkXAeTOBmj95PxopXlwT6t7xcDOOph20rO5Xc1WuuVTSsUZtA3UvpLfPWHThHfjxqvJMaDE=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6258.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE537A0EB81E9B42B7EE44B8EE93ED9D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 pZ4TfQw5xf1QT2viOsdUE2B8OeyiBtIVw+Eso68gzjRs2/vZAj1DeEhNtkpDyVkmAFyiPmuFyXXCbrh4QSNzXnf9rZ9b1QiD3gIY2tdo7XP1UnklZI5m6mAZDg6pxE0iAnNuH6tc77+jXHlBqWiGzuofIPzal55f0bIIjCFp09Kx2EIPQIbjRGOa0IjY2jsmrY8kezrZEQcg2P/MTU62eGlu2C31rKPOs3gurctCrCYldz6v5qV4/Eo+z0+2KweY9a11P9A6qAACVBe+7itTCQ26oeAgaKUMjaI2irIAn+J0VHxYdLnPLGBc8zd7K8w5LggrmknOaLJ+Plwk2lnmBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6612
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	15cc0e9b-9e5d-4ac1-876e-08deef1d392c
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|14060799003|35042699022|82310400026|36860700016|376014|23010399003|10067099003|11063799006|4143699003|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	rvyW55L+yT3YZ4ebRrYqbZ1n0G9QEn5BgKlaC7ie3rGNlPLYd6cW17rQC6qQOGN0Q5xKb0zSH9kzGzsdLSWE7Lm8mfffQiuaWm/y0aTmd7IBNDyiOOnB63OwBDCx9TKTxkBbWvOyiQqPRouxa+1z3tlq5HTGB/Vg76BSLLPs2A1TLU+49F25kKCb1oJWP/ZM5ZHtM+TmCpVSDQyGksVJev82LpkABbwPPqf8WA3GsWXL353UQnOcLH6ul6VZPtcVr36mchClvEakZ/9y5OCPFtFz8JTIY8yuYcb1ljyvT6Rr3lCR2fL0cJ7/nSId4eeUrqhqJPiAGTiTh7TC5w2xTEjGprv+q1W+TeLGIA7oqW9B0ufem34yThEb/LFkzXGTEKDgAcirKTrMe9l3HtMaydjA1EeaBec5qwIww4A3ZX5IdSsobrdWNK4KANC5NIXSnsQBnV6nwxUIST1fg7r2hV4ti5ypW99U7vXkvutxfueesGCSddB8bwmrHeWFucl2qKTlHJRAKrY54Nx0OaV/DfRAtfXm3TferUgH9x01zhaFBudnpBClgagX+RF0SZO9FKbaybzQHbsW1/fbn+gpNrQ8THeRztk1Ly+yoJUIUwE/9tAhfYUDLC89L1sEubdJY1gnssZutSzTmz/ihVb//mkJ8+q5xL8Y5n97ZX9a8Lg5sXaTB12A84VHZFpFa7VtXY/Idyk5c6iXWAx1hTcOiw==
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(35042699022)(82310400026)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	/5/lCvx62AR+9w4sAy3M4uAuMzdle0yVp7EkcM+qmq2DK3yn8BE0iELXyIQha0YPqbYS1bDV7JtN0FBaF7xGuYREJlhiIlJwIO4IYFHT7gsCXhFO1PQNr6T3lyLNprTjmcqPyapzaveOeyb27/gfin41cxM69suiT+5Dj6YCnXoBfh3QHZ0/XM5GbWLShg3EY1MmV1ZW9RgJsH5SCR8I/KFdXIFwSnT6O1u1QlKKrBdcFMOevjaEGnNGINcZSztMaLGpDMu5vMEtYdJyBLflQ547gO6F1Rosq3ES7KX6fnt87f7xwkhMQ5pMcT+O/3Rez0nanDSDLD6MvU7PoknJqeTJ7DTWEZmHruxMz6ejXER4H1iI2tgE+CTjdJEKohvYz7/CFYNl/iand89LHZaVJmlQ4rQ9gAFa2luuh+M/Hj+RXBIS5VMC/Uc3JhVuXQX3
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 16:04:14.9272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80244252-a65e-4196-bb28-08deef1d5e5f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7309
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 31 Jul 2026 16:04:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4615

T24gMzEgSnVsIDIwMjYsIGF0IDE2OjU2LCBSb3NzIEJ1cnRvbiB2aWEgbGlzdHMueW9jdG9wcm9q
ZWN0Lm9yZyA8cm9zcy5idXJ0b249YXJtLmNvbUBsaXN0cy55b2N0b3Byb2plY3Qub3JnPiB3cm90
ZToNCj4NCj4gVGhlIGJ1aWxkIHJhY2UgdGhhdCBjYXVzZWQgdGhpcyB0byBiZSBkaXNhYmxlZCBp
biAyMDIyWzFdIGFwcGVhcnMgdG8NCj4gaGF2ZSBiZWVuIHJlc29sdmVkLCBhbmQgdGhlIGltcHJv
dmVtZW50IGlzIHNpZ25pZmljYW50Og0KPg0KPiAgbmF0aXZlc2RrLW1pbmd3LXc2NC1ydW50aW1l
ICAgICAgICBkb19jb21waWxlICAgIC0zNjIuMXMgICAtOTcuOSUgICAgIDM2OS45cyAtPiA3Ljhz
DQo+ICBuYXRpdmVzZGstbWluZ3ctdzY0LXdpbnB0aHJlYWRzICAgIGRvX2NvbXBpbGUgICAgIC0y
Mi40cyAgIC05Ny45JSAgICAgIDIyLjlzIC0+IDAuNXMNCj4NCj4gWzFdIG1ldGEtbWluZ3cgNWVm
NzQ2MCAoIm1pbmd3LXc2NDogRGlzYWJsZSBwYXJhbGxlbCBidWlsZOKAnSkNCg0KRHJvcCB0aGlz
IG9uZSAtIEkgZm9yZ290IHRvIHR1cm4gb24gc2h1ZmZsZSBtYWtlIGZvciBuYXRpdmVzZGsgYnVp
bGRzIGFuZCBpdCBzdGlsbCBicmVha3MuDQoNCkZpbGluZyBhIHRpY2tldCB1cHN0cmVhbeKApg0K
DQpSb3NzDQoNCg0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwg
YW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2
aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90
aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVu
dHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUg
b3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K

