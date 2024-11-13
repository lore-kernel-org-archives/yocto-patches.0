Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B57D41C32
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 10:40:40 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.60])
 by mx.groups.io with SMTP id smtpd.web11.9051.1731494430178223707
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Nov 2024 02:40:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=KliH0+dZ;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=KliH0+dZ;
 spf=pass (domain: arm.com, ip: 40.107.105.60, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=l8MIQ3WXT3sbGlU2k66LTAAxzKsxKHA0AHiFgKvlu7taF5y8QiDcuUTtVExCRG/0i8HQQrVkWP50pkWiN96O2ZM+aVSXkF1uG1annkpSzhkY2rBItDMwGn1FKScOlkK23iI949QWJ4Bjs8wT+tmU3wuDxNK80ZLl8iRhKK3dePKH6RIy3ypuTyo+Ie+xLmaimz2Ol3yBqkcz7specQDErquBVVmpzqV5SINWDZurGYNWJUzlBPktEnHSVFD+LYkNbJmu+8Udx1EbYkw1dIpEvC5zBOaDUV/sdMca8UjZ0cIiZBhO1r3qoTBxTUANgE2EY4FVs7lQfoxbrCYw3OWC0Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgYv0onx7U/8VZQuSiyuvjjgxoxjF3PJZxhydcDMl3c=;
 b=MDpMG7APb4k5ZAVdKJr2wGgChh6g7gb7FVXswPD9OWAc3A6s8o/ixJWt0WHHse9ObIbmrFVdgYSjx95JVQIHnjqAXreUO9AV+zQkPDsX9mrKNgsS/7NM8OcHy4IOugn9yIdB4kA1a+9aej3GQKxVY9Gf2AbEd8xV4gU++adMIZKiL66UhFrZf0hvhijl96hD+oMaQaOsuEKxmzOjVqZ01dGHJXzPiu8FQikZykNjZpNt/lQkqGD0FwnG4EmO/GJ2jpU4e8e4mlK+T46pUey6lkH3tm28sj/UkeRZnhkdFZcc9fXtwKCG32TuoBrabxhwbSuXlKodxJ8p13mptY2XuA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgYv0onx7U/8VZQuSiyuvjjgxoxjF3PJZxhydcDMl3c=;
 b=KliH0+dZcHR+uWNXrD/3+YTNFNOCXYYOfnV1grbtpwWSwtOvgFnoQKP1i5zhvMAkW3bmwfQFUQx6d/gtt7+5BYR2p42H0HuLU1UclHqem58BUmvW8+iaeIa573fKmGFy3zVN0de/zQuVwwyNAsCaovXoZUQlP60Am/xtIIiOhXw=
Received: from AM0PR04CA0128.eurprd04.prod.outlook.com (2603:10a6:208:55::33)
 by PA6PR08MB10471.eurprd08.prod.outlook.com (2603:10a6:102:3d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 10:40:25 +0000
Received: from AM3PEPF0000A79B.eurprd04.prod.outlook.com
 (2603:10a6:208:55:cafe::f) by AM0PR04CA0128.outlook.office365.com
 (2603:10a6:208:55::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Wed, 13 Nov 2024 10:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM3PEPF0000A79B.mail.protection.outlook.com (10.167.16.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.14
 via Frontend Transport; Wed, 13 Nov 2024 10:40:24 +0000
Received: ("Tessian outbound f3131fc4ec00:v490"); Wed, 13 Nov 2024 10:40:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 71087961b3229bd8
X-TessianGatewayMetadata: d92nLWSTeOGie7x0JsPpDUhOTi4EgPXhXCBDpKE3vgfVm1yit4Z8T8/QFYiDzNGwnxBAO6VLOZTZBWqpOtfpR9M4BsFeQ0ixHvYZ3drvrcC/CQFxPWszkUDaDQJzYFCAW06HpWpQ93PWIoLJTwVhhv0X1H/Nbjx8kYDq22zGmd0=
X-CR-MTA-TID: 64aa7808
Received: from Le3090c061af7.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id A0070457-2520-4D04-89C2-CC9EBFF6B9C1.1;
	Wed, 13 Nov 2024 10:40:17 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Le3090c061af7.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 13 Nov 2024 10:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyXxCJDL3DiHDG9AAqbe3X1lpMgms24LdMRSopUKuxZwhHdiNJLYVK7P845z526MjkxiH/lHF70EXPmvZm3GsZRFe/lMr6pHZV9oxqKvcJ+IWBjyFQDu78PMUzotN6rsE+BrY7UhkvEOonWkVaDyTW34WKTkoyKTGMFsmXnQvo4SSRoHYVdgcf1PlPpBUcLyCftGMJivWuT0tHduylLoO1ndneIe8vi+Mw2RkEKllayWyB7fb9WT+P7QcfN/GxmAkP8Ks5mxXx/AW16irI2eXvfvEs1C2FkxI8q7mzbD6brq2LnMFQI8vPfrRB4pC82aD7R6lCXBrE68WqNPGH9fKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgYv0onx7U/8VZQuSiyuvjjgxoxjF3PJZxhydcDMl3c=;
 b=lHCpEc8asK3wsZ3uAy2islMFwH9l8sZ1T22HCe+hXac3LhQeHRZGRjqnLPu04Fka5aZb5fCPLgPLPs1euHq0JQIYu4dm9XIbz5a5WMtwddMGMKYjd9Vl38zT/MY7lADzmRzwEphUeWWZ92LLRIVwJXfXGb9132QZnxMcON3FyszRmKa7OcV8AOB5hWWZr6p210aWDcrPWjJ0fg1ocksi0xz0ggJTE0Ou09wNkI6pDNR3aT70/j1SX/ptBIyjFCU8ozI9vKPI5dKOxLVjNHUzj6aY+iUMK+AoB87RpDK5pSyp/T1avGAdXraL/rWcMLM2X0iM7sWeIYgvGTIv9BVAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgYv0onx7U/8VZQuSiyuvjjgxoxjF3PJZxhydcDMl3c=;
 b=KliH0+dZcHR+uWNXrD/3+YTNFNOCXYYOfnV1grbtpwWSwtOvgFnoQKP1i5zhvMAkW3bmwfQFUQx6d/gtt7+5BYR2p42H0HuLU1UclHqem58BUmvW8+iaeIa573fKmGFy3zVN0de/zQuVwwyNAsCaovXoZUQlP60Am/xtIIiOhXw=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DBAPR08MB5640.eurprd08.prod.outlook.com (2603:10a6:10:1a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 10:40:13 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%3]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 10:40:13 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
Thread-Topic: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
Thread-Index: AQHbNathqGTY9kKYWU+R3eNpoUoXULK09IiAgAADpoCAAAR/AIAACMeA
Date: Wed, 13 Nov 2024 10:40:13 +0000
Message-ID: <527C5D48-F150-40FC-AECF-8B84DBA9EFAA@arm.com>
References: <2f52ba6e-4709-4b66-b23d-838cbf8d9d3e@trifork.com>
 <2664ede8-d88f-446f-9419-6372fda41361@cherry.de>
 <bee5d935-5f5b-4347-90c0-15462e58c4ae@trifork.com>
 <5db30b32-f058-42c9-bde9-418c6a7b6625@cherry.de>
In-Reply-To: <5db30b32-f058-42c9-bde9-418c6a7b6625@cherry.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.200.121)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DBAPR08MB5640:EE_|AM3PEPF0000A79B:EE_|PA6PR08MB10471:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf4285d-ce22-4de2-c9b7-08dd03cf94f6
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?dmwyUlZiRFJsUWZ6bVZSS3gzUFF0SGg0ZlAyQTZYNmxPRm1Ga0p4Sk4yaFly?=
 =?utf-8?B?MW9FSFVLOUU1RHN4ejh0K1VsSm81bVJGODVnRnR6RmpLWm1EaWJvK3E5NlB1?=
 =?utf-8?B?VW5BcXlhZXdhdWRBcHo5N2tCcEdrVWdyL1FpdXhFSkJrek5UdXg3NWhnS09h?=
 =?utf-8?B?clR1SUdCUXRSR0JwaFgrcGJkdjJ6TUU3ZWxub3hDOE10OTVOU0ppU1lvREZF?=
 =?utf-8?B?Qm1ML1dBWGdjWGxLZy8rN2xsQUFCK2huWVN0ajNGM09ZYytJZjNGOVlVQ3Jw?=
 =?utf-8?B?YU8wS2xTWGRRcndpM1haaHlWcDdaTGNQT3pqQ1FVekhpZ2t6bkEzU2VSUklu?=
 =?utf-8?B?eXZqbHVidjdDNXE0ZEx0WWhHbktVZmI4c0Vyd3A0dHVaM05SaFVjVWJzMnR5?=
 =?utf-8?B?M0RCSTgreVlFaXJHSEZIR0ZjMWJxVkpDWEZuZS84ckRxUGhCVzlQVUxDQTFY?=
 =?utf-8?B?bnc3TWxteDM0YzhtcDgxajV2d3pLaVNGMVpOOC92bW9DL0M3a3RYWXlZQjd2?=
 =?utf-8?B?L2xkZTBCOUxFUEFmRVdSdldNbmtvZkdTRFIrSHZ4UGZaTDlldlF5QWR3c3ov?=
 =?utf-8?B?VnlaaWlmOXU0UDhOOEppMXRmNjlRUWpTUUJxWG5QcVJGSDlueGp5ekJ4Z1Vm?=
 =?utf-8?B?Ymh6bEJMcTRlYWVzMFRqNjhXb1Jrc2toQzBmcERZVlNidXVVSHh2ckwrTFpD?=
 =?utf-8?B?dG94eTBGWjhSWjNvZWo2eDlpVWllS3dtUGFtN251NG40V0NMZWNHOVhZNzQz?=
 =?utf-8?B?TDJVRnMvYnJ1K1o5NWs2UlNMYXNQLzgyd284RlRvVUc1TmU4cnBneXhzM3hI?=
 =?utf-8?B?eTA3VGZyTkllUDNwRE54RDFZbjlZR01xRCs2UHdQR05iMEpocHNQS3R6M292?=
 =?utf-8?B?eEF1TFJITWVGd0YyNlppZ1VDY3FQY0ZBVlZNbUNEOHZRUmlBaWhCaU9vY1F6?=
 =?utf-8?B?YmoySzhnbkxFcHR3TDBrQ1BjeVJWSzJDQ2hIWmxzTXVmVWtWTjNJR0ZPdUVQ?=
 =?utf-8?B?MXFLdm9zWHNlbGhmRXMxOG5ibmdaUGlKUzNFOXc2Z1lXeUU3SXFlckVaTXVi?=
 =?utf-8?B?VFY2WUxEUDEvVzZYL2pmM2ZzNEVkN2pOUTFzb0JiUjltZzV1NVBJdlNVYStx?=
 =?utf-8?B?Q1V2azZ5NmkzOXR5aURnNzFJU2N6bjhQRmJjcStFaFVHZUJVVHdqWndDcWda?=
 =?utf-8?B?ZUJkazJXelIyU1ZmNGFva2s2dTRlSjMyT1Z6cld4UTFvUnhNaTZHVXJTUFNK?=
 =?utf-8?B?SEtYUXpkRDJnTEVqR1RWVXZBOWZqUFh5THlDbnFheUhPUG1JcDhGV2JzN2tJ?=
 =?utf-8?B?TjYydEZwZWtVTEdocFUzc2tXYlhCVVc0dmRSRjFNeUlXY2NjS2Z5cUJFSWNY?=
 =?utf-8?B?QXRhMVBPaFV0V1VCQVlMK1hHMFc1NDBteG9WQkxVa2pMc1haQUJRdEhIaG1i?=
 =?utf-8?B?U24yMndubDFUMlZCUHNieUM2dTN0UUZ4MTdRQUZiT3ZPS3AxM3lhYzhldHQ4?=
 =?utf-8?B?eGRhUmMwVWVjallHb080WEJLM1VrZCt4NC9reUJKLy9WWkdQaXQzYXMxZ1FC?=
 =?utf-8?B?Si9LcHV1MytZTnRLOXFYUXovb3Z6ZzNKa1IzVlFkY2o2N2RmZUVrZmFtMDd3?=
 =?utf-8?B?UURKM0l0YTAxL3hhU00ybUwwcS9IZmNkT1B5Z1RYZEF3ajJaUWk4NHhTZXRa?=
 =?utf-8?B?cWwvMGJYWUIvNUgyWTJXalJmN21CYlg0bFVlVm54ZjdYMW5sYU0yZFE0SzJq?=
 =?utf-8?B?d2dmQ2diV2NYOVJKVDhrVE9CZ09MRFZzVVFDcHppOTVEVUp4aDY4YkFnd2xU?=
 =?utf-8?Q?1JixZpbIe7/ySpLJunkdzX1JoIhNzCltOgr5U=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <BABD3B3F74BA3D459DCC0883A7A0BC73@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5640
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	7b135cb6-e9b2-44f7-f1a0-08dd03cf8e37
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|35042699022|36860700013|14060799003|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VFhoOVZRVUROSEN6V3RNNE1uejFEbWVOdUpTblN1cU5ST3JReHNaVnZSSlp6?=
 =?utf-8?B?cmJ6aDA1NWVkMms0Rkora1l4SHMvanZEcmZEUlliVGs0NVhVVjhzdEJJK3JO?=
 =?utf-8?B?cHhRQ2hXQVJkY1NjNWQ2MHJtZUJ6N3puZkVYam5VbE41Q05CcnpJN01hd05p?=
 =?utf-8?B?Sm1SaThBYjFBZnVUeFptRlNqWjZHcEJOYnNFcFNOdVB0MnFFWVM1T05rQ2Zl?=
 =?utf-8?B?SUhKdkM2RE5oN1ZyU1IxLzExcVhIR1VRZ0NIMFVlMkxtZ2RqNjZWTWQwL2xF?=
 =?utf-8?B?NGlVSEFibG50UnRvb3l3U0k5Y1hoekpmall3YXhnbmVjL3RIRWJoL3RCZ3Zv?=
 =?utf-8?B?cEZ3cTh2bFpJbytlbHdlYXlPOVJrYVo0Y2lid1U5a0FSTGtlSXlJWG1GNXlO?=
 =?utf-8?B?R2dUU1JrQTdqQndCSnhjeEhDdEdSU2FQZSsweWJOemxsOTRVdUxMSHJuRTdI?=
 =?utf-8?B?amwyNlVmSk1CWXFtSkNObW5pY3FIM2RiN0ZsYWVld3BaWTVOVnozL1lWcjg1?=
 =?utf-8?B?YTBJd2czTnNXTjZNSlg5T3EvSTd5RCt6UlQxMWNnUnFRZm1vdnJodFZqM3pk?=
 =?utf-8?B?U3FhRnRjY2FvMnBtKzAyUTQ3MUgvSmlxMGlpNER6UHVqaDZJQXBZUHFoa0x6?=
 =?utf-8?B?cjM1N3c4dXJ3UmphazRqZTZrb1NpWDVQSFYxcG5PV1ZEWnNPdHEwY2c3TUto?=
 =?utf-8?B?bThob0x4QlM0a3FKZnlyUXZxa2F1SDIvanhxc25ZUjJ1N0xkdExCa1ljb0Mr?=
 =?utf-8?B?ZlAwK1l6ejF3V21UTnJmV0RWSWtIQnBZTEo0dzdiaTBFWXJwdi9OSEJHOUQ5?=
 =?utf-8?B?TjdicnBSZEFBSFkveFltNzZuTjdyY0thYSswck1iUDNpTWdPbFRuNmpPMDg5?=
 =?utf-8?B?M1V0S09mS1hkMDYvV3pBQ0p3TEEyRDQ2eXZOMFhBUUdTNUI1VmxiZ2xabjVR?=
 =?utf-8?B?UzduTFhoZDc1ajJUVjlseC9aS0JQOXdVa1dodklPQysrRkZKdjY3K2wxZFZk?=
 =?utf-8?B?K04yajhIN0Z0OFZmRmRKTDhwMjM2cTcrRzhwaU5tWjZrNnNmeVA1bUdqMFpa?=
 =?utf-8?B?bEdsMlNwYW9ONHlQSnBObEhEZTBxL0tFWFBJZTc4MlAwbFR1cTgwUHE0a0tr?=
 =?utf-8?B?ODk1VngvRmR3MWh5ZjAxbUtmTXFIeVcwRGRhZjV4UFNhSWp1ZjdydW1xWHA1?=
 =?utf-8?B?YW9jSUxZRW1qMGZwTDJBUkZKTjJ6d1psSHNyMVJ4TExoS2FZVUtTWVJuUWVu?=
 =?utf-8?B?Tm9LakpyKzhKZGZ6N3hydWJzejBYcllUYjY4U014aXY1R1piWGpBMmdab0FH?=
 =?utf-8?B?ckVZZWVYbFJlTnhwc2ZHVDZleE5HanpkZzE5NVR4T2lyWGduTERiQkZIMmNk?=
 =?utf-8?B?YkwvMWZGUWdrYzV5SEkxbi84anN1MVVxaCtZb3h6czNDUHFaTmhrcmZIZnRW?=
 =?utf-8?B?cDE0UkoxV1B2dlZHNWUwekRjc282bXZaZjN1MllOMTB1UXRnUUlRdzJDWUIw?=
 =?utf-8?B?L1FKcENvell4R1g1M1lIdlRIYVdyRE9QWXd0ZjNqQjgrOXhHK2lTZ1lDSnYx?=
 =?utf-8?B?NW8yVTV2V3VEMlpZeDRNbENCeS9LVTdFMjVUUVhPUTRUOGd6Ym54WkVJRDI1?=
 =?utf-8?B?aTFXSy8vOUN0MTJVenpYMEVDWjBFYWE1cDFQb1lUaWVKeExEeEFOcFZMUnpF?=
 =?utf-8?B?dnd0MElURGRDRDFvNXpLK3YwNW5vdjliQ0E4UTNDd3ppTk5xakxESTJUVmNi?=
 =?utf-8?B?aTduaGxxQU0yOURNcENJcFJ6cUMvWTFMeDQ5QTVSLzU4TCsxaTRzZmdtTUlY?=
 =?utf-8?B?V21xSk9EYXVwMFJkSGVQTVhKVDV5N3B5M1dOZHdBelJwRnk5OUtqRDFpUDVZ?=
 =?utf-8?B?N2pra3dSZnhDS1ozVjA5VGNOUzJiQkFISGM5Y1dhb0hKS0E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(36860700013)(14060799003)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 10:40:24.8324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf4285d-ce22-4de2-c9b7-08dd03cf94f6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A79B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10471
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Nov 2024 10:40:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/796

T24gMTMgTm92IDIwMjQsIGF0IDEwOjA4LCBRdWVudGluIFNjaHVseiB2aWEgbGlzdHMueW9jdG9w
cm9qZWN0Lm9yZyA8cXVlbnRpbi5zY2h1bHo9Y2hlcnJ5LmRlQGxpc3RzLnlvY3RvcHJvamVjdC5v
cmc+IHdyb3RlOg0KPg0KPiBUaGUgdGhpbmcgaXMuLi4gSSdtIG5vdCBlbnRpcmVseSBzdXJlIGl0
IG1ha2VzIHNlbnNlIHRvIGhhdmUgYSBTT1F1YXJ0eiBTb00gbWFjaGluZSBjb25maWcgZmlsZS4N
Cj4NCj4gTXkgY29tcGFueSBzZWxscyBtb2R1bGVzIHdpdGggb25lIGJhc2Vib2FyZC4gQ29uc2lk
ZXJpbmcgdGhhdCBtb3N0IHBlb3BsZSBidWlsZGluZyB0aGVpciBvd24gYmFzZWJvYXJkIHdvbid0
IHVwc3RyZWFtIGl0LCB0aGV5IHdpbGwgbmVlZCBkaWZmZXJlbnQga2VybmVsIGFuZCBVLUJvb3Qg
cmVjaXBlcywgd2l0aCBkaWZmZXJlbnQgY29uZmlncyBhbmQgRFRCcyB3aGljaCBpcyBlc3NlbnRp
YWxseSB0aGUgd2hvbGUgY29udGVudCBvZiB0aGUgbWFjaGluZSBjb25maWd1cmF0aW9uIGZpbGUu
DQoNCkZXSVcsIEkgYWdyZWUgdGhhdCB0aGVyZeKAmXMgbm8gcmVhbCBwb2ludCBpbiBoYXZpbmcg
YSBfbWFjaGluZSBjb25maWd1cmF0aW9uXyBmb3IgYSBTb00uICBBIGNvbW1vbiAuaW5jIGZpbGUg
KGFuZCBwb3RlbnRpYWxseSwgYSBtYWNoaW5lIG92ZXJyaWRlKSBzbyB0aGF0IGl04oCZcyB0cml2
aWFsIHRvIHdyaXRlIGEgbWFjaGluZSBtYWtlcyBtb3JlIHNlbnNlLg0KDQpSb3NzDQpJTVBPUlRB
TlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRz
IGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUg
bm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1l
ZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVy
c29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1h
dGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=

