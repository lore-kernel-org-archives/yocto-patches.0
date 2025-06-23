Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD6C7115B
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 16:03:33 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.62])
 by mx.groups.io with SMTP id smtpd.web10.724.1750694607303104969
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Jun 2025 09:03:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=Q4ynVm/+;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=Q4ynVm/+;
 spf=pass (domain: arm.com, ip: 52.101.70.62, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=RiYrk0Hw45CRh5TdFlKMTks1mfkJNcdseAgqnX6+EW1A78Je2Xwik9A4qCnvY46tUwMrEyq5KwJv3KIehotDUhvEA3Sf0G39vTiMnYTmyHhE3XVVnGpPF1+wc507m7TLaf/gG6+REp9H2YisDKH5LyUsJi7quZvgcEm3MvtW+2J6BMFIeV0QxczWYRkMXO4bDnPT7INn0Nnnlh0kQrILWIUAa3IuiUJ/2EHiQjczW46QVaxFDrOl2wS7Zdisb3AuZPPncsQwax1z+XtyMKfuOEilSFz8vu1CPGDSZNhnUCzCl27gp3/GOxR1em88l+s/r6jRTqM80mTLibBlPdW5JA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGN5la0japVdDt42fDUnspPgi8Qgc2OflU9asQOwF70=;
 b=u27C45+iOINwLbQ9fDpZ5F0CjVtNZBIiiPmZJ6tz5xKT4E35NbNSVere+D9AddSs/CvcTFrYKNcS8j8n729mJm8VnvgiCNoK7OZ5r+TFx6dtcrOToxEQlr+pkA+CRJ/fsEKRW6FJ0tlF4eVDhTR3WOqGkyYAK0G0KAtyEwyyJbkO7xMWGGAXo6qs+YkjDX2JHMwWf4e5W6P5jdDaHnOVdJ6l6as0ITNXqdMUYLE8cIlyt5JyOrVZAne0ZT6s+uq6mmj+FMxjrHFuqZGb+0folYAsQAVf/ZQ7pfsCuH3YGv86JncWF/Q44xU9ErmSrLz6AOFpMnmc5xxmrq7jly/GIw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGN5la0japVdDt42fDUnspPgi8Qgc2OflU9asQOwF70=;
 b=Q4ynVm/+niSLy3SKsTVQ9YMobzE+jKi6IWIGpUdU5me23Q7+rCLMuiPfrtHZ1q2BolPl9olUbRwGQ/dINTMGcBHU389Tu29E2d8ftw5nQlRVCYwdyvvdNLFfrCmDDKfEIkLQtIsqbO1qGCt5ZUJqGGZZiOmw4jUSssXk13BkJ5c=
Received: from AS9PR0301CA0002.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::15) by AS2PR08MB9101.eurprd08.prod.outlook.com
 (2603:10a6:20b:5fd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 16:03:23 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:468:cafe::dc) by AS9PR0301CA0002.outlook.office365.com
 (2603:10a6:20b:468::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 16:03:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Mon, 23 Jun 2025 16:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBeB9M+0YDnhO7+zPIZMGF0i3Ovg8KD+vdja4wHEtz5dZ2WUg8L68JgjPLTCTfxpQV9ISyxp38FhrQrL0vmgwH6LehGrlveXmb8giEVfl0VAESuPOXXDAk2t3DZZF4gb4Q7CXbS26TJjRpvrDitdVF3dW0Pq2Bha4BbayLkS9f9WNkQbGBZkLJB71cG74Ej8KFurJ0xeQGgpuHD2zJpBs4np8LvZ2xw3Zhn0a1vwwh9TyDAgR3Vp0G+xOE7vKHN1a3BBPptE4V5nS5cYzOHBWV5BzkAWoOZFpWUZiRLaT457k+esydL1Y8ykMWj5+zdmDdXlmPbk6ZAVgl3KSyjPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGN5la0japVdDt42fDUnspPgi8Qgc2OflU9asQOwF70=;
 b=mFbpmzIetNRVvT7k5ZJu0aBOmG9V74z7PjLKlpJfmEpPf7y4Pclj9yNoAY4YmPQ7tpMeYORsHlodfDdCJo1KARvzM7UAt8mSEuQ5/kNnrwu+p36V0HHkEntVT1g5XTSC2uKO0zUqJFJ0y0C/JrZFLq/+p5NbSWEZxgX60tmiBMDvlUxHSH4AKyxwjJJEOtKVcvx8vjzqfiI1cXn1TFpcnl7F8kD4aj6b3usjcHLnLx7q997Bgy7eYm3GG6OL736GJD8tudThwM1Ma+H5mZopO00hNX2eJ8mXiYKKYtoLVE2ovtCh3Ol3ZK+j0r4UOSl+6yX0qVBQTaso/BVu73Ycmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGN5la0japVdDt42fDUnspPgi8Qgc2OflU9asQOwF70=;
 b=Q4ynVm/+niSLy3SKsTVQ9YMobzE+jKi6IWIGpUdU5me23Q7+rCLMuiPfrtHZ1q2BolPl9olUbRwGQ/dINTMGcBHU389Tu29E2d8ftw5nQlRVCYwdyvvdNLFfrCmDDKfEIkLQtIsqbO1qGCt5ZUJqGGZZiOmw4jUSssXk13BkJ5c=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by PA6PR08MB10832.eurprd08.prod.outlook.com (2603:10a6:102:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 16:02:49 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%6]) with mapi id 15.20.8835.027; Mon, 23 Jun 2025
 16:02:48 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Dixit Parmar <dixitparmar19@gmail.com>
Subject: Re: [yocto-patches] [matchbox-panel-2 v4] panel: added sysfs support
Thread-Topic: [yocto-patches] [matchbox-panel-2 v4] panel: added sysfs support
Thread-Index: AQHbMTDM/Zak+vbgIkix+GsUlt0xH7QSThkA
Date: Mon, 23 Jun 2025 16:02:48 +0000
Message-ID: <A6BA7B57-AFE7-4A55-A132-3C3AD2E18B72@arm.com>
References: <20241107161901.43148-1-dixitparmar19@gmail.com>
In-Reply-To: <20241107161901.43148-1-dixitparmar19@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.600.51.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|PA6PR08MB10832:EE_|AMS1EPF00000041:EE_|AS2PR08MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c5e9f3-30d9-4ed3-2cbf-08ddb26f7a84
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?aytZcXNjK1BHanJnSUV0bE1GajFWcnJPY3BpM3dUR2JRTTlaeW4wUFptazZs?=
 =?utf-8?B?QUZwYWoxU3o1VThOR0JsL0lLZG9aQjFrQU5ER1VzVGhSbjBKeTl0ai92cHZj?=
 =?utf-8?B?d2NWZkNIWWJSZlN4VElaVjhoTkZGenRSRGRwNTdBS1JldFV6dm1PN0VOSUw5?=
 =?utf-8?B?YkUwa3VJRjNYa1c3cVV0UzFPNHFTVERtSHYzNFQzOFdScDZhSFJ0R1NDK2I5?=
 =?utf-8?B?cjBzcnRnMStPOUhIN0FPZ25qM3BZenZkakY5bXBsVnNLRXlNQ0dxMUJIejhl?=
 =?utf-8?B?dmxNRElVQ1ZhRldPTDRlSWxUYWJXU0tZcEpBUm9BNzdyNDFIdStBSnFFOWlI?=
 =?utf-8?B?cjBqQWdUQmpuN25wb1VCcmRCTU1mMEJBV04ybjltSWRhUmhuNGhtWHE5NkE2?=
 =?utf-8?B?TDFxdmFZY3VDTWt2Y2dYVzd6ZlppUDFLNVRUdTRvSjZtbjVRZnNVN0Y0UGEv?=
 =?utf-8?B?dTlXNUp6d0NIbjYzWndxcVo3TjhINjJjS1NIUTU2YytJZTJVeDJ4SjFBNjR5?=
 =?utf-8?B?NG5LV05wdXg2dWlQWHZkWXFKeUpCWEtrVU43WEQ3aEZmRk9RbEtRVVJuVEVa?=
 =?utf-8?B?ajdBblorS0sxcStwUUZ4SDcwaFdXc3VaRndtT0dkU3AzbzNzNHNGNm1YMG5N?=
 =?utf-8?B?Qnl0Wlduam5teUg4ODQzeENCZjk5RUJGMjg1QURSNHRSNnhraTdHZTdyVTM4?=
 =?utf-8?B?ekdjbGdsanBtRC8vQnNMQ3Y5cHRmeGxBUEwrYStGeWZPMEdQeUxNMFQ4TEdk?=
 =?utf-8?B?cFltYmZmT21ydjNwZjN3NmJ3QVFxSlhUaVY5eU9IcWI4dmxLTmdTZ0dDbitZ?=
 =?utf-8?B?aHdYMmhhMFJ2S3BMb2hhaVJSdzJVcXJTN1plRGRiUXMwanl4K2ZWb0psS0la?=
 =?utf-8?B?M1dXWXdFREpkaDVnU3ZidzVxL3hqeGRjcEFwQ0JiWGp3dVIzdmJxL3huLzI5?=
 =?utf-8?B?dU1tVDE2TUJjN09oeFMvQnA2N3FqQlFQVmJCMXRVeHhUR242Q2hFL21sd0wy?=
 =?utf-8?B?MXU0c0xNVHhtYy9EdzZLNzgyZlEwOGU0b1R2UjgydC9uYVdGR05MRzVHWTk1?=
 =?utf-8?B?R3hza3p0TldKRmNhRTJvNUMrL3JYeWNDelJhMmh4TkhuM1FacXdyRlNaaGNp?=
 =?utf-8?B?Nk12d0xRdW50YU95cVhkbDA4MHkxR1ZvQi9pWFRLWTBFbStaeEhHL21aTjBh?=
 =?utf-8?B?T2h0dDhtYXJLZXVzeXhmZ242QXlJSVUweWg3M1NxbXNmQU92ZStEY0ZqcUpw?=
 =?utf-8?B?NHNySWlINkczc1MxMHNXS3cxMWQxaEVFOFhhWjFhajU4YTNhdGFEUDBhUFJn?=
 =?utf-8?B?L1NGbUFxVmUya2hPOFVxektRTXJnallIcndxN3I4V1Zlc2pwNlJ5OGswSzBW?=
 =?utf-8?B?ZjdMZ3ZGcFFiSG96MEtsLzRTY0VDdEdVc3hLbFNBY0svUUxxUzY2TXo2VTZl?=
 =?utf-8?B?RWVPaVJuOXcyVzlqeTZoQ3pvcDBYc0tjM1RxQm1vd0dQWnlQUUdSMmYramdz?=
 =?utf-8?B?MzRSckY2QVp4Y3pPR1ZSK1B1ekJRYjJ2N0RtVnBBU1hCQXZXdE1iQ3BlRXow?=
 =?utf-8?B?UWVVOVZFQmtMTTlNNHJYcWN3aDB2ZGxKci8vK2swZ2dpdTZPQzluT2xTNTdY?=
 =?utf-8?B?M2RsYUNUTkI2Z09ac3cyQ284MGtmV3lGUXBUM0VYK2pVSjB5T2Z0MnBYL3ZN?=
 =?utf-8?B?UjVGSENmcXhZS0REdVlSVUxoSytDZWpQNTBWQUk2bDc4RTg1VTU5dzZTNEcr?=
 =?utf-8?B?aDY2MXlNbnFxVDFVaUIrb3BRck9pcUM1RVJST3BqRzNONTI2Nm9QMUhJeFgr?=
 =?utf-8?B?WjBXQ3NpL1ZvVE16dUFMdTYySlN2TnIxczBKbkdJM2g0OGZhTmNSeHVxMUFh?=
 =?utf-8?B?dHJFd3V5VzRQU1NaajY1NmdRN3lZU1VIME9OeDFZR3liVmRQQmFVVWZsanBZ?=
 =?utf-8?B?TG41Q3F5TmViUnF2QzhqcVd6K0JPZTRmbWFQUFRyc1dYMjM4c2IybVIwVld5?=
 =?utf-8?Q?TlBX2fMcD+JR6vx0uzjQ5Ku4dhPa40=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <308241807C970B4DBC4EC3CCE0874123@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10832
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	f3bc6177-3e51-4814-120b-08ddb26f668e
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|14060799003|1800799024|35042699022|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YU0wc0MxNWpCUHc3VWtUTGk0YW1CN1pUR1FrbE1MU3hiV0hTb1RBRWplSnZn?=
 =?utf-8?B?NDI3QUJnQ3dqT2ZaYlBjdUhEMFg2RXVqNjE5MGR0NGNOWFRaT0Yvc0FIU3BG?=
 =?utf-8?B?dVlTRTgzUE1qM2tPYkVqdnZEVVhuaTIzZ1hLaWJsWEFnZHJUR29GWGNCRC9t?=
 =?utf-8?B?TnJmM3phd0RSOWgzQnh6eW83K0FMR1YzQlUwa21UcmRMWHFiaW41cC81LzNJ?=
 =?utf-8?B?cTZ5R0s2SjdZd2pyc0xzeHVWby9KV0JYOG55b0Y5bjRSMWVtV2Z1RGRTQlR0?=
 =?utf-8?B?TXRQU2MrMXZKd1JiYjU3Y1MreGZWbWVmV1NKRExhZTliVEl4YzkrejRvUFBQ?=
 =?utf-8?B?Q2doZWNESGIwUkpmZjVGUmZMRTh1eDhxWmg1TXY3WVJLYm5ETmRFSFFibTQz?=
 =?utf-8?B?bnA0M3lzcmxXY3VUaVJXUko2Q1h3bkxHazNzczZKNU4yREwxaVhRcEMxVmtH?=
 =?utf-8?B?NUh5OGYzWXFJZW40aUJPZmo3UWFkaE81c1RTRGNVcDlBMnRjb1lSZWdRc1Uw?=
 =?utf-8?B?MG5vVFFCSWYyczlSTVhqVTFsM0V5bWhQQkovaDlVdDFjbmZvc1FKbHFsd1Zv?=
 =?utf-8?B?ajY4OWVFajdZQjVGSEJNLzNIU1N4UjNPZTdhRmZuaWV2dkZPNjFkSjBacDVG?=
 =?utf-8?B?allacG8yeUp5bFlFR0s4bDZNdG0vWldxb2pVcEFaZy9zeDdwbytuaENVOXJx?=
 =?utf-8?B?cXVVNVNtNHJ0dUNLTmNrV3VXQzByeklDYWVRZWhGT3VuTzhibE9zUHJTVlZM?=
 =?utf-8?B?Rmo2OHJvMjVzQ056SjRNT0lHRlc4UkdORENZQTNpZkpiVHNsT2trS2xzYy9C?=
 =?utf-8?B?SVZaazNDRDBBaFdTMVN4SWpEZ2NyajFQODZBU1JvcUhvbngrRWN0NU5Dd3Qz?=
 =?utf-8?B?a1JBS2hJQ01jRytldGZrQkZSR0M4ZlR3R1Zua1FjUjBkWjNBdFdab2N3Z0R5?=
 =?utf-8?B?ODQ4V3ZjclBtY0c0S3E0SFZCbzVPcW9pUSsvRWhkRVZpMllpZlpSdURuMHow?=
 =?utf-8?B?L2pQd3lqUVFqbEVyazFIWUxmZEpVVTVtQWhFanJocjVFOXd1dWpUbkRxTjhs?=
 =?utf-8?B?Z1RKYmtPS1RMUGpJdmFGYXFXY3NENW5CbzM2WC9YcWgxR2RWSVRKWTVhU1R3?=
 =?utf-8?B?QmlHLy80UHF1UjNReFlzQk5ycS8ybStGTEo4bW90dVdDSnlaNCtRLzVkNmR6?=
 =?utf-8?B?NUJxaWlyR3RYZ25Cc0Z3L3dOVktjMG9uWlJKTTZwNW41TE5CZnYvUUJpTnBE?=
 =?utf-8?B?RnVRMFBNbkU1R1QzSlUzL3JEWlFFNGdtdC92czV2d1FDRzFGNlVuajRXWmlj?=
 =?utf-8?B?RmEvSWdyUjJYWURmWkJ2R1cza2k1TmhnTzMxQ2hjZkpEN2pZY3g5ZFFad1pB?=
 =?utf-8?B?Y1diUWVKMHFVaUJNUFZMV1RqUFB2V3BkV1NhM3lPTVlrZ3p0ODFiaG02NFd1?=
 =?utf-8?B?T0I2RTdOU21KcXd3WU0rSU83QUJxa1gwTmtCaGRrSkxwZ1dPWTVrUHpGVVlo?=
 =?utf-8?B?akw1N2dhMk51d0x3YUxKQUhvM1BCbExnbEZPZWNjclBHd0JRK05CeUUwQ0ZV?=
 =?utf-8?B?UFh1SGJvblJISE1QeXVJcmNkcE1FamJidU5qU1c0cjhkUzczVnJjZ0xqblFC?=
 =?utf-8?B?K0xkN2FMM3dmVUlreGxPbENOOUcrZkFHdUdrdWpuMU8zMXNSV3R6TkNaWmw2?=
 =?utf-8?B?dU5TRm1KV0ErQTVMQmlyTUhkVHpGeG05WGlldTMxMDF0OTFkVHRqbHlVYjZj?=
 =?utf-8?B?RGR4blluQUdpY3lIQmdWZWZSSTBXdlQ2OXBuKzZOdHA3NktSRitMYkt4dTRw?=
 =?utf-8?B?RGhvdy9VTmhybi9zUDQvMUhGdWcraUNWa0NFTjJLSUk5V2M3N2FkU3ozRW5L?=
 =?utf-8?B?YkdFSk1NTmVHbUt6ZDB6NTBFdXE0cG5ZbDViRWc5MUpmd3pqZGdUWXdWL2p6?=
 =?utf-8?B?TnlHNGlHUzgwVkU1WjVWTDF4YmpVMitmTkE0Q0g1aGcwbi8vTGN3VE8rZHE4?=
 =?utf-8?B?NTZVRkZnenZFdStRNEE5M3JSRWNuc1U1K2tTckgvcFZDbitXeHpESCtwZWhs?=
 =?utf-8?Q?LSEaf3?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(1800799024)(35042699022)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:03:22.2642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c5e9f3-30d9-4ed3-2cbf-08ddb26f7a84
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9101
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Jun 2025 16:03:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1677

T24gNyBOb3YgMjAyNCwgYXQgMTY6MTksIERpeGl0IFBhcm1hciB2aWEgbGlzdHMueW9jdG9wcm9q
ZWN0Lm9yZyA8ZGl4aXRwYXJtYXIxOT1nbWFpbC5jb21AbGlzdHMueW9jdG9wcm9qZWN0Lm9yZz4g
d3JvdGU6DQo+IGJhdHRlcnkgYXBwbGV0IHN1cHBvcnRzIHJlYWRpbmcgYmF0dGVyeSBhbmQgc3Vw
cGx5DQo+IGluZm9ybWF0aW9uIGZyb20gc3lzZnMgZW50cmllcywgL3N5cy9jbGFzcy9wb3dlcl9z
dXBwbHkvLg0KDQpZYXkhDQoNCj4gKysrIGIvYXBwbGV0cy9iYXR0ZXJ5L2JhdHRlcnktc3lzZnMu
Yw0KPiBAQCAtMCwwICsxLDE0MiBAQA0KDQo+ICtzdGF0aWMgY2hhciBiYXR0X2RldlsxMjhdID0g
IiI7DQo+ICtzdGF0aWMgY2hhciBhY19kZXZbMTI4XSA9IOKAnCI7DQoNCkhhcmRjb2RlZCBhbmQg
cmVsYXRpdmVseS1zbWFsbCBidWZmZXIgc2l6ZXMgbWFrZSBtZSBhbnhpb3VzLiBUaGVzZSBzdHJp
bmdzIGFyZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQsIHNvIGRvbuKAmXQgdXNlIGZpeGVkLXNpemUg
YnVmZmVycyBhbmQganVzdCB1c2UgaGVhcCBhbGxvY2F0aW9ucyBldmVyeXdoZXJlLg0KDQo+ICtp
bnQgcmVhZF9maWxlKGNvbnN0IGNoYXIgKmRldiwgY29uc3QgY2hhciAqZiwgY2hhciAqYnVmZiwg
c2l6ZV90IGxlbikNCg0KVGhpcyBzaG91bGQgYmUgYSBzdGF0aWMgZnVuY3Rpb24uDQoNCj4gK3sN
Cj4gKyBpZihkZXYgIT0gTlVMTCAmJiBmICE9IE5VTEwgJiYgYnVmZiAhPSBOVUxMKSB7DQo+ICsg
Z2NoYXIgKmZpbGVfcGF0aCA9IGdfYnVpbGRfZmlsZW5hbWUoUFJPQ0ZTX1BTX0RJUiwgZGV2LCBm
LCBOVUxMKTsNCj4gKyBnY2hhciAqZmlsZV9jb250ZW50ID0gTlVMTDsNCj4gKyAgICAgICAgICAg
ICAgICBnc2l6ZSBsZW5ndGg7DQo+ICsgaWYgKGdfZmlsZV9nZXRfY29udGVudHMoZmlsZV9wYXRo
LCAmZmlsZV9jb250ZW50LCAmbGVuZ3RoLCBOVUxMKSkgew0KPiArIGlmKGxlbmd0aCA8PSBsZW4p
IHsNCj4gKyBtZW1zZXQoYnVmZiwgMCwgbGVuKTsNCj4gKyBtZW1jcHkoYnVmZiwgZmlsZV9jb250
ZW50LCBsZW5ndGgpOw0KPiArIH0gZWxzZSB7DQo+ICsgbGVuZ3RoID0gLTE7DQo+ICsgfQ0KDQpX
aHkgZG8gd2UgbmVlZCB0byBjb3B5IHRoZSBuZXdseSBhbGxvY2F0ZWQgYnVmZmVyIGFuZCB0aGVu
IGZyZWUgaXQ/ICBJIHRoaW5rIHRoaXMgZnVuY3Rpb24gc2hvdWxkIGJhc2ljYWxseSBqdXN0IGJl
IGdfYnVpbGRfZmlsZW5hbWU7Z19maWxlX2dldF9jb250ZW50cygpO2dfZnJlZShmaWxlbmFtZSk7
DQoNCj4gKyAvKiBDaGVjayBiYXR0ZXJ5IHByZXNlbmNlICovDQo+ICsgcmV0ID0gcmVhZF9maWxl
KGJhdHRfZGV2LCAicHJlc2VudCIsIGJ1ZmYsIHNpemVvZihidWZmKSk7DQo+ICsgaWYocmV0ID4g
MCkgew0KPiArIGJhdHRfcHJlc2VudCA9IGdfYXNjaWlfc3RydG9sbChidWZmLCAmZW5kcHRyLCAx
MCk7DQoNClRoaXMgcGF0dGVybiBvZiByZWFkX2ZpbGUvc3Ryb2xsKCkgaGFwcGVucyBhIGZldyB0
aW1lcywgcHVsbCB0aGF0IG91dCB0byBhIGxpdHRsZSBmdW5jdGlvbi4NCg0KPiAtLS0gYS9hcHBs
ZXRzL2JhdHRlcnkvYmF0dGVyeS5oDQo+ICsrKyBiL2FwcGxldHMvYmF0dGVyeS9iYXR0ZXJ5LmgN
Cj4gQEAgLTYsOCArNiw5IEBADQo+DQo+ICNpZm5kZWYgTUJfQVBQTEVUX0JBVFRFUllfSA0KPiAj
ZGVmaW5lIE1CX0FQUExFVF9CQVRURVJZX0gNCj4gLQ0KPiArI2luY2x1ZGUgPHN0ZGlvLmg+DQo+
ICNpbmNsdWRlIDxzdHJpbmcuaD4NCj4gKyNpbmNsdWRlIDxzdGRsaWIuaD4NCg0KVGhlIGhlYWRl
ciBzaG91bGQgb25seSBpbmNsdWRlIHdoYXQgaXMgbmVlZGVkIGZvciB0aGUgaGVhZGVyOiBzdHJp
bmcuaCBzaG91bGRu4oCZdCBiZSBpbiB0aGVyZSwgYW5kIHN0ZGlvL3N0ZGxpYiBzaG91bGQgYmUg
aW5jbHVkZWQgaW4gdGhlIC5jIGlmIG5lZWRlZCAoSSBjYW7igJl0IHNlZSBhbnkgc3RkaW8gcmVm
ZXJlbmNlcyB0aG91Z2gpLg0KDQpTb3JyeSBhZ2FpbiBmb3IgdGhlIGluY3JlZGlibHkgbGF0ZSBy
ZXZpZXchDQoNClRoYW5rcywNClJvc3MNCklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBv
ZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5
IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVu
dCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xv
c2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBv
c2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5r
IHlvdS4NCg==

