Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA161CA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 17:39:39 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.50])
 by mx.groups.io with SMTP id smtpd.web11.83900.1756834773810377265
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 10:39:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=Oc0eB2Py;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=Oc0eB2Py;
 spf=pass (domain: arm.com, ip: 52.101.84.50, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dO/4snfAv/0vDkoKj/jlLpe9r83jjRzrOKr9oeBNIUMn7XQingke+JEyXvU3txX4ITz0zVuRPWj8F6zd6y6fFJ1iphLuZBlwexo6o35R4X9EVlFoniHtNu8vXbcP2Z3x+Mpm40TKCCFuvEYLdwBuO18i0Rv6SaW1xdy68RH1Op6A7wpfg3nNN1fCmJ0cCgpFI2R3rapYE/parjGrAV5R1ZZ45IS6JdMsbu4hzBKKJAPxnc+xNlw3vkhG3PDfqMgq32vozUHUdlLieZyp+FTYqg2HtxdR4MQ0KN8HVtgBZp3eLOv2yG1Wr02balReRcRThrhJeIp85NEXMhXDlOYS1w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJKnNfswqczOFTcojl5xX84vvaC8D2uss0pOZFS1+JY=;
 b=YvdPFsEKjTyypxQgUn3OJam/f81//4ydKj3AgZAi8ntKPlU7FHtAd38qUjn7l/e8JK+VOQbtOifoWi7UmpwrDUt4lWp+Kl5TFPAKLQY0hDwJ7tCUUyMPfGukrQPhTz9E9L45sjz1GD7I90NcD2tTiUpjHlVUliHpoqbPjHJDWX3GfRRfhwnw6gAxgI/D8Z+JlI7ho80q9+x4ke//sgvk7DwAd+xPJoZvyJl1QbvAKCFSmBLUmTDKKH6wT206FoWZR6bZUvX4X+32YmZzkNmOTD4q6G3oFBechrMmlpWMBTlZtPyGFCv+4G2zvQDy0SYWWNyRRdIxriw68D6LRhNdvA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJKnNfswqczOFTcojl5xX84vvaC8D2uss0pOZFS1+JY=;
 b=Oc0eB2Pydjqv28QbQ1Y5BaiD5wBjukXlrwwmOx0QRjQBWWeFx2v9l5kaEnFs9XNKJgtF1mXwYniKfP2NNniy7wO7M3MagH8RDVRDoe9Sz22otC1aqfRfkQM7JCkX+3go3PrgcaANWXz46pdCHLZLfkNN1zIfUd19YRxDY+1mm90=
Received: from DUZPR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::19) by DB9PR08MB8484.eurprd08.prod.outlook.com
 (2603:10a6:10:3d4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 17:39:29 +0000
Received: from DU2PEPF00028CFF.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::dd) by DUZPR01CA0030.outlook.office365.com
 (2603:10a6:10:46b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 17:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFF.mail.protection.outlook.com (10.167.242.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Tue, 2 Sep 2025 17:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/ukRlaT/0qy2sP28RChySE7MM8+98hGgHPZgBlbnd1xzeP8/iRo+S0EG8YohpedvvkQw39yVSZ9iYCHRpm9fANSU/cAJcuiibL4uyFO+MvFJd2shLPXBnHXo9Ef0/X+SoI+e9jVszl3ZYTmhwNErJh2XTJZB2AtzqKARFcnUgMg45sws0vXjM95K4oeEEn9I4d6d9y9bIO0l9OuT+f0IeQYZa64RlBcDDztFuRQ4T5SVGdlBCKYv+sc3tpsX08U/e+WYFg7s0dpuogDbtmcUcM+w0KdpjEzwqBiqOzqR1kqW+6oq5Evd6CmtpI1ude8FJov6QqUfg729ER+6daKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJKnNfswqczOFTcojl5xX84vvaC8D2uss0pOZFS1+JY=;
 b=guOB33+u0qS4WyJYL34ANkZ44l/Xt4HGy+5tMKRszKs/mZAPbAzimihlGqauUWhk4hVtEUbph8lQh58B0wA4eSygaXvwkMDP+Zaca48t+tx6ogVQgulJ/IEeWVuMgTW1HC2aNglBwNSFU2ntkYI1bsTAl1m9jGfS8vtcLEuxK8gIl77KAeyL1ADG1kLveJWZpFmNEKHDvfz+QRl45mTJb9lVTkur7/FKk9bE4Mi/4dnxNvGwkZl/Gz90jUU/HCWNPYqjv2uk48CZu/ZL0jUSyjDkAt216mV/vfzSksH2BEERVYW9m/QSW2Dvjt4UtU2sODF2JM+4SG12Qoq+kziS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJKnNfswqczOFTcojl5xX84vvaC8D2uss0pOZFS1+JY=;
 b=Oc0eB2Pydjqv28QbQ1Y5BaiD5wBjukXlrwwmOx0QRjQBWWeFx2v9l5kaEnFs9XNKJgtF1mXwYniKfP2NNniy7wO7M3MagH8RDVRDoe9Sz22otC1aqfRfkQM7JCkX+3go3PrgcaANWXz46pdCHLZLfkNN1zIfUd19YRxDY+1mm90=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DU4PR08MB11149.eurprd08.prod.outlook.com (2603:10a6:10:576::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 17:38:56 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 17:38:56 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Dixit Parmar <dixitparmar19@gmail.com>
Subject: Re: [yocto-patches] [PATCH v6] [matchbox-panel-2] panel: added sysfs
 support
Thread-Topic: [yocto-patches] [PATCH v6] [matchbox-panel-2] panel: added sysfs
 support
Thread-Index: AQHcDfD7g2LCA4CFRU6pCaF7oGo++bSARPsA
Date: Tue, 2 Sep 2025 17:38:56 +0000
Message-ID: <89C14622-E2D8-4A08-8D22-5C612FEE6283@arm.com>
References: <20250815142901.1742993-1-dixitparmar19@gmail.com>
In-Reply-To: <20250815142901.1742993-1-dixitparmar19@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DU4PR08MB11149:EE_|DU2PEPF00028CFF:EE_|DB9PR08MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e42444-cb3b-4c28-8c17-08ddea47ab0f
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?TDRvNExSZWdlN3dhTVpXWGhXQklHNGJXejlXWXByeU9RbGMvNVZzenkzNytV?=
 =?utf-8?B?K1l0amVDc24vblFLa0lPUHdCM1JWSWswaGFTVGlzRXNTRGEyRC9TQ2NWamg4?=
 =?utf-8?B?RFRhSmU3S1RPQnlEYTdteWI3ei9ia2hBU0pkSHUvdHl1cEhzTCtNdG5KeUR1?=
 =?utf-8?B?NHVIUW56RzNaNnliSnUrcVJPSmJzUVJqMExyUWJ6S3B4cnpqQmd0czhFUXBa?=
 =?utf-8?B?aG9jN203ZVQ4YWNEa0pzOWZRSnlBN0RCbzB1OHpLamtMSm9mNWptOUY5Wk51?=
 =?utf-8?B?RE93Z1BQN3VZVGtDeVREMjRJSFZ1SHNpZDR1T2NQaklOZHlDYkdQQ0xhUWVN?=
 =?utf-8?B?U3NpOUdzNnZ5akpLa2kvVjkrU1BKa0RiS2tUNW1tMkJFSHhCU2UwYXUya3p4?=
 =?utf-8?B?aldCdUs2SGhoS1ZMVkpXWFB0dHowYjJqRE1OZXBrR0VWSmliTUtUOWhYaG02?=
 =?utf-8?B?OFZ4VE1JTlViajh4YkZkOUUwTlF4TG12TndZY1I3VWthZ3dUZzVuOHNROTB3?=
 =?utf-8?B?QnE4enlUU0xEVkMvTjBrTjhqUHF0SE5PaFJCakZQZG55WG9OMmtRNlU0cWxS?=
 =?utf-8?B?S2NrajZLR3ZxZ3piajRsOUt0VDhFMTRJZVhaQVd5YVp4dXJDbnNvdWJlUEIx?=
 =?utf-8?B?OE9mNjZPZzRyeEUyYXJOOWdCdEJKRE1BUGx4NzhzSEc3eDJPRVRHVGRHWkpD?=
 =?utf-8?B?bUtGTkRGcVo0VEFudmRJcllWVU9UREdzTm5hNitVN0ZMRjdiNTNmeVJ0b3BQ?=
 =?utf-8?B?Q1EzQWJuTmd4TTFyQ0FIZjV2cHFVZHQ5cExaeFhOT1poc2ZoWkxRRkFOYi9w?=
 =?utf-8?B?MS9XZzhPblhzYi9mOGtkUDJHMDhjU3UrdDV6RHhDaGYrRFFLQVhDdEpVM3pM?=
 =?utf-8?B?Umo3UFBLcHJLbkkwaDB2L3JndTVxVUFXeXVzZGEwbDV0L1JYd1BOOGJWZTFS?=
 =?utf-8?B?WXRQcWhHcnZlTUY5dytJdG13WGw5REhQVDd5T1o2Q0RxbUpKT00xYlJaYkFa?=
 =?utf-8?B?L2RHcnFkS3RUY1E3VjA4aTFXR25rbGtORnRHaVN4dzI4a24yRUc0eWhFa0ty?=
 =?utf-8?B?UHpGUjIxWnJOdUhQaHJ4NkNXN1ZDeHp0UUJTc1ljWGl3c2lUbXBrSnI2c1dI?=
 =?utf-8?B?b3J2aEpwYjdqaVYveExqc1dSR2FyN3d3eTVuZ2RicjE2SE85WUJMMDMwQXhH?=
 =?utf-8?B?MnVSR2tQSEhBZDVtZ25RZmFIVkJpdHcrcFByQW9icXBWM3QyWmUwQVFIQ01v?=
 =?utf-8?B?bWFTK3pqWDRBcE1GVk1qT0t6WUNtbkNpRGwvajdZazNXbVluL3Nrd0NQL3Q2?=
 =?utf-8?B?WHdsSDREelg1elFRaXp6K3ZnNnBFR1Q0TzhaWktENmsxeU1CWldHYUlUOURI?=
 =?utf-8?B?TnUxZWlvWi91UWhrZGJ1UHVuN01INzJmekNlSUN5TERvcUV3Z0g0bmdtSkhz?=
 =?utf-8?B?elczMm9MNHQwb3FOV3FVWnlwdWt4QlhuMkUvRUlYZGhXeU1XcGF1WGRya2ZF?=
 =?utf-8?B?cDBLZzZHT2JMZXNCd0ZXWURHK2lWVkQwU3FZMXhYdjJxT0tmNEg2UHRXQkRy?=
 =?utf-8?B?VTBxamVzUHFSaHJNem5FL21Td2oxaXRuWW1ETEsrbWtKeWFmczcxMWlJd08z?=
 =?utf-8?B?d0RkMTRLazI3TmtnNFdCSExZMy9zY1hkR21tUXNwM09zcWJxRjlNZWhTL25B?=
 =?utf-8?B?eWZKNlBKdGhQMVFmTml3TUk4ZCtGc1NKZGE3MkE4V2k0cXRCR1I0Nk82cG10?=
 =?utf-8?B?ZkZpaklXTmRBZFNGRHU2M2xrRjR0Rm9RUE82MEZlSzJMbTZsUzB6a0h4QVQ3?=
 =?utf-8?B?djMwaEkrZXhPOTdkSTRXZnNZZ3pZVE5qRG9kTm1ZYVBscitXdHR6ajgwL2k3?=
 =?utf-8?B?c3VqLzNxKy85MXFLajk3Tnlud3JZTzNnMXRDYzJYSGJsdlp0bzBFbVdGSXJw?=
 =?utf-8?B?dEFCdEcxZ0FpRHVvWmFFbFZKZHFpK2RocXJVMU5tZWVhSnZ6UHMrd0ZRWk16?=
 =?utf-8?B?NUphQmZHTGVnPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB409ED46EA51C46B41A5B56F36CB9B3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11149
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	d8f8eb93-11c9-4660-f72c-08ddea4797d9
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M1o1MGRHNzFpQTd6WUZONUFtcEhuQ0M1cm9zNHdxSUxPZGtlbmduVTQ4NGhS?=
 =?utf-8?B?NE1FdHFrbzRhZWVSU2Z3Qi9CZk5GODV0blNsWGNuajRhYUtINDZEQS9McElX?=
 =?utf-8?B?Sm9WN3lKWExaUFYzOHU4Tm1YQUI1YXlNT2xObkNsV0RmQkR6OHJoNUVURTkx?=
 =?utf-8?B?NC9nWDJXQlArTjdMUXNSdDdIS2piTFRzQmxaVDNZYmlHU3dFL25HZURWWExh?=
 =?utf-8?B?ajYzdVk2b21pbDRJcEU2dGVHYTh4d0FkaUdpVm04S2JKSGRGK1VseEJrbDRP?=
 =?utf-8?B?WlRxajJaOWxOOVBNTlVpWnUzT0paNVB4NFc0djFFUHM3STRJd2MzdTZ4emho?=
 =?utf-8?B?b1dOazdremxMU1F2YmFxZFRDN24zNTF2cTFtOVRxMHhTaVI5Ky9xckZIU2tN?=
 =?utf-8?B?MEk1bGxwWndKUGR1NzRJQkN0ODQvMHhKc2tNWmFoUDYyTmVYZjR3VlJVankv?=
 =?utf-8?B?YjM3VExyNzRIU3hraGlReGxWMU1rai9QQ2tsRGRIM0M2dnFkdTl3d3hDTDVn?=
 =?utf-8?B?ak5hWTVTZndKWi9CUk8zK2NocjFLSWxoeEliMWdiWXM2U0hoZDN0aTgvWjE4?=
 =?utf-8?B?c1JFQjdMWHBtVktHMGk3aEJRUDRWS25rRTFvMVVpTGp2cUJESXMwUHNpZW1D?=
 =?utf-8?B?cDROR2FPanUvM0lhM2tVQjYxYUN3Vm9JeUViU1p5ajZkSXBkTmtaN0F4SS9a?=
 =?utf-8?B?WldsSSsrUnBLaHo3WDVZT0cyQk91L05sTXR3Y1R5Y0Z5dUVGdTNoOXczTG42?=
 =?utf-8?B?N1JwcTg0d0Q0T3I2MHFuam5GbUl0OW9OeVVRWmdlcFJGMW5FWXRzUUk4LytR?=
 =?utf-8?B?UmpqK09zZnBnYnVEajZWU0hkT2hxSnk0RElIR3h2M1QrbllyamlxYTRlTTBH?=
 =?utf-8?B?by95empSUjJwREh2ZkoraTRkRTRNK3RRcjhvb3hFWmVEK0tDTGJORjRnY2R0?=
 =?utf-8?B?VUZFRDBLSlhRUzBuTkdKN2dWZitLSU9PelIxNEpQdU1nUTJ0RVlEOENzYnIz?=
 =?utf-8?B?K0s2MW9oK3k1b0pNSHZUdkZlQWUrOWFTNDRReTZ1Z2FrUjZLWTRoZHU4dHBD?=
 =?utf-8?B?akc3UGIxQXYvVTFLMnI3R0QrRjk4ZFdpWkpPbXZ0anZaSEFqNllXaVJDYnJM?=
 =?utf-8?B?MkVaQyt2RmRnOGV5bzJrcWFuajAvYktjcStSTFI1NkU5VW1tbFpsYnhkZnBm?=
 =?utf-8?B?SlZSQzJYbzY5NDY1UjRwMzZMR2x4Z1Z5RkliMEdSN01ZY242THArTGpsanp5?=
 =?utf-8?B?UThnbVVUc3ptZDJTbGZrYjdnc3J6aWVaZXlMeHREaWY4djVFaXVqSjgyaFhU?=
 =?utf-8?B?VzJhaytuSTNCR29Lc05lL3NsTGwyL25lWXFRb2ExbDk3UmdibE82MzQ4cS9W?=
 =?utf-8?B?K0dCbFEyejhHRTY5azZ5VEM5SGhVU3Z6MXFtWW9WblBqRjNMeUZKaVFoUFJz?=
 =?utf-8?B?ajBEVVBuQVlTVUErM1VZeUw5TGpZMUgrWVZqNzd3UDJNNXNMdFVsT0lpck01?=
 =?utf-8?B?dDRtVVdVS1NLTUwwRndRakl4SEszSnlOUFYzbDJ3aVorUi9EK3drdjgxR01U?=
 =?utf-8?B?K05pK3pDb2FoM3R1elJWcVF1VUMwcTBTYXF6UnZkNU9PbWcrbWtrMURaWldr?=
 =?utf-8?B?Wk5kNTY4SE10N2k5MFRvaFBqL1hDR3VnUTF0QmE1SytkYURxZll1RGtyMnA1?=
 =?utf-8?B?a3U0bURXQ3I0UDM0bHFTcEE1Z09wcG5nQnNLM0JMdzlIV0JqeitUdzNoUURy?=
 =?utf-8?B?Nm5OYjZjK3ZuSll2K1pISjlUKzdTa0tLOGFDaDJPeEh3UUtERUJGQXgrKzA4?=
 =?utf-8?B?MWhrWU44MS9wZG41WVo4MXlEQVdud3N3Tm1NUmZVSzVXNWw4dEhzMXAyVzB2?=
 =?utf-8?B?TWwrWDhCK004Wm9wOFlaN0szV3o3R0VjZU1VbGNGbDZxUWtsVk1uUVRmU1JQ?=
 =?utf-8?B?eGt6TU9Tb0xMMzYyYzB2U3VQcXJuNkFpODdHOFRoRW1Ia3MvZFVYV1d5SnZw?=
 =?utf-8?B?MjRDVlMvY0N3aUNVWEl0cmpBSk5qRzNKcWZQQ0dOb0RQMm5TbGROVTBOOENN?=
 =?utf-8?Q?GvY2mi?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 17:39:28.9533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e42444-cb3b-4c28-8c17-08ddea47ab0f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028CFF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8484
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 17:39:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2117

T24gMTUgQXVnIDIwMjUsIGF0IDE1OjI5LCBEaXhpdCBQYXJtYXIgdmlhIGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgPGRpeGl0cGFybWFyMTk9Z21haWwuY29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+
IHdyb3RlOg0KPiArIGlmKCFhY19leGlzdCAmJiBzdHJuY21wKGZpbGVfY29udGVudCwgIk1haW5z
Iiwgc3RybGVuKCJNYWlucyIpKSA9PSAwKSB7DQoNClNvIHRoZSBkb2NzIGZvciBnX2ZpbGVfZ2V0
X2NvbnRlbnRzKCkgc2F5cyAiVGhlIHN0cmluZyBzdG9yZWQgaW4gY29udGVudHMgd2lsbCBiZSBu
dWxsLXRlcm1pbmF0ZWTigJ0gc28geW91IGNhbiBuZWF0ZW4gdGhpcyBjb2RlIGJ5IHVzaW5nIGdf
c3RyY2hvbXAoKSBvbmNlIHlvdeKAmXZlIHJlYWQgaXQgdG8gcmVtb3ZlIHRoZSB0cmFpbGluZyBu
ZXdsaW5lLCBhbmQgdGhlbiBpdOKAmXMganVzdCBhIHN0cmluZyB5b3UgY2FuIGdfc3RyY21wKGNv
bnRlbnRzLCDigJxNYWluc+KAnSkgYW5kIGdfc3RyZHVwKCkgYXQgbGVpc3VyZS4NCg0KPiArIGFj
X2RldiA9IGdfbWFsbG9jMChzdHJsZW4oc3ViZGlyX25hbWUpICsgMSk7DQo+ICsgc3RybmNweShh
Y19kZXYsIHN1YmRpcl9uYW1lLCBzdHJsZW4oc3ViZGlyX25hbWUpKTsNCg0KQXMgYWJvdmUsIG9u
Y2UgeW914oCZdmUgZ19zdHJjaG9tcCgp4oCZZCB0aGUgbmV3bGluZSBhd2F5IHRoaXMgaXMganVz
dCBhIHNpbXBsZSBhY19kZXYgPSBnX3N0cmR1cChzdWJkaXJfbmFtZSk7DQoNClRoZXJl4oCZcyBh
bHNvIGEgZmV3IHBsYWNlcyB3aGVyZSB0YWJzIGFyZSB1c2VkIGZvciBpbmRlbnRhdGlvbiwgc28g
cGxlYXNlIHJlZm9ybWF0IGNvbnNpc3RlbnRseSBhcyBpdCBpcyBtZXNzaW5nIHVwIHRoZSBmb3Jt
YXR0aW5nLg0KDQpUaGFua3MsDQpSb3NzDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMg
b2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1h
eSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGll
bnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Ns
b3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJw
b3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFu
ayB5b3UuDQo=

