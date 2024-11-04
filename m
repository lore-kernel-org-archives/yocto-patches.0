Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C54D132AB
	for <webhook@archiver.kernel.org>; Mon,  4 Nov 2024 10:46:22 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.80])
 by mx.groups.io with SMTP id smtpd.web10.54939.1730717173671203497
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 Nov 2024 02:46:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=rno9nBgu;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=rno9nBgu;
 spf=pass (domain: arm.com, ip: 40.107.247.80, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=AqYDcCZwn0JqB0YWOZX827zYOHOzVJ4JcIJtG9krIGJ7CmANMB8tDdCxJE6WVPhnJe3JODn7ZqaeYLejCbIQrgtUbPXq7ArbiCEN03eChI+kfrVyK32DKyDewMYQiU7LOK/BM7xzVU15ol1dJ0t0/p4cgckYMvNHoaNn0rptI73+yWYSbgZKs24/NjaAxg7/at3dkfPTqDR+y2z7C10u9XyiEMwHBIthZfex+dnPUWIXMEVXftx23JUSQMdrBw5B45X+ahM2Q4d6592RdvsvAhgiyJMRPiV5l9wVC+GOWjevIVaPSRAwGoxKw2d38QAGooeBwjAHYhoeU0x4x0jx0A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bOcTWWaGzvr/fTDymqrbwk1D2mPGSK2IJGg4EvCtr8=;
 b=iyjqf8x+8eq3P7yk3VhHog9voXRrTiffLA51ojUDvpbmtiwybJFYKe57Lp/eKD+fXlnJ4fdczMuKTRJbuCg01Gt3TO52kSmdPdltvJNAG/3rD2iuSba//4t2I9OcC+7uaj/6oAhju8REdG79DIhxwVxp+RXb6a5l9cfZ3pYCRRdjp3+3Re7YeLnapUAfKeVW83cf0IegBsx+iik5vBavK1tnwo45UeS27ukNGr9704Y3x+1qlxHV28Jd2a9v2hBJLjU9rz2wgwbnMFyzYF04Ga2rIOZChowSvUX8+/gXzS1HRjsIk27nf4y44cP1MaFUbpRCEmeMKbqisno0k1rdkg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bOcTWWaGzvr/fTDymqrbwk1D2mPGSK2IJGg4EvCtr8=;
 b=rno9nBgu8VmA6e0w0RZwUnLcElpetUzqZl9dhje/IIT/3ORpVq6cxnSH5alX6jUa6hn3s0Unln8Di+bJKYMYliz5MRcXSp/BwyhkQJDH3rYprtAs4khqwC/hS0jaxOGlC5DmZkIOZSNV7+q1eTtOqTSixq5ZSi8TNHpxByoObG8=
Received: from AM5PR0101CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::29) by DU4PR08MB11102.eurprd08.prod.outlook.com
 (2603:10a6:10:577::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:46:07 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:206:16:cafe::8e) by AM5PR0101CA0016.outlook.office365.com
 (2603:10a6:206:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Mon, 4 Nov 2024 10:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8137.17
 via Frontend Transport; Mon, 4 Nov 2024 10:46:06 +0000
Received: ("Tessian outbound 8223600b7a9c:v490"); Mon, 04 Nov 2024 10:46:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6c502779fedbd924
X-TessianGatewayMetadata: ND49BcDk7X1Qhmiz1c09N/W2RKue4nWcqmpE8891V1Zdxc9W5qgBYoSi9dBPUecxbwqHZuMBNbojvZTvoc7czZnZVjjIYJyEDRA9PRfHYKgNBnZDWCczSsHsqkcDNYUI4fNwgUcPpsuwZrothxa31tcD/09OsKg6XrApxySH0HQ=
X-CR-MTA-TID: 64aa7808
Received: from L90cf898a2a0a.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1F0DB147-6D04-4CA2-A403-859EEDE8321E.1;
	Mon, 04 Nov 2024 10:45:59 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L90cf898a2a0a.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 04 Nov 2024 10:45:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOrM5zsZpdALAKO2kUaklxVTcldJLYQrMVYqpR+DkB9DkB2A36CsE9TxlpJrMHoFPxufQxGDj6jdC4lvxWJf+VSbOrJjg2ECS7Ez+hUQ4k9e6Oxvd5J2JpaJ86NZ3TNynIDx0OmFZmw9hW3QpUIkQVcrQxMPHpOOhF9duiUBaAyKSrfKKUlhMwE94XLB37xFDSOuOloWvb7SFNjj5Q3gIOa0KepNpYwDeeCH+HczkMzKJxLDvjNBvkPUwzahaPYeu53+gdIa2q/yyrmOAenLBDD5yJh0uSwileDiwaZmXJILFDaEulPN/0uN4F7ka6VHPYH5BPybkjrK6eOsUTeH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bOcTWWaGzvr/fTDymqrbwk1D2mPGSK2IJGg4EvCtr8=;
 b=Gmamf4f4vrVEo25SqO41/MCkvvcQrQ6e47+4rwnjdC/NMpVowmOhiZJv7DDOvZytFBnTLfgtKp64nPNbUFVNa9FJQtuwbaYufUoikm25IP4xfqimf2NvfXmZSh9+9mcYdE4nfpFO8pr/UU5B7gow+cy8eD91D/7/I5MWU2Si0Vmusv6O4vBjV2VpNu7HemUElBETYUI4wt9OVl5aJIEjRmdWJ35aW6EAQ7/qfN2V4b1YduS9tCswLVr0R8eZR/u+46RvjN9bxxj4/OrR8PXBSW2PK40fElzi7J2xtx/tlxH1DJBz4g+4lkF7n0fydCTpohmtDsiFurFLlhQCOSCp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bOcTWWaGzvr/fTDymqrbwk1D2mPGSK2IJGg4EvCtr8=;
 b=rno9nBgu8VmA6e0w0RZwUnLcElpetUzqZl9dhje/IIT/3ORpVq6cxnSH5alX6jUa6hn3s0Unln8Di+bJKYMYliz5MRcXSp/BwyhkQJDH3rYprtAs4khqwC/hS0jaxOGlC5DmZkIOZSNV7+q1eTtOqTSixq5ZSi8TNHpxByoObG8=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by AM9PR08MB5953.eurprd08.prod.outlook.com (2603:10a6:20b:2d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:45:57 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::9206:40ba:ef7e:729e%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 10:45:57 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Dixit Parmar <dixitparmar19@gmail.com>
Subject: Re: [yocto-patches] [matchbox-panel-2 v3] panel: added sysfs support
Thread-Topic: [yocto-patches] [matchbox-panel-2 v3] panel: added sysfs support
Thread-Index: AQHbJgU+sO4hxL07RU2FLFkfGQtSs7KnAV0A
Date: Mon, 4 Nov 2024 10:45:57 +0000
Message-ID: <B5FE0B08-05D3-46D8-97E1-8E53B8E30C36@arm.com>
References: <20241024110927.494096-1-dixitparmar19@gmail.com>
In-Reply-To: <20241024110927.494096-1-dixitparmar19@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51.11.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|AM9PR08MB5953:EE_|AM2PEPF0001C713:EE_|DU4PR08MB11102:EE_
X-MS-Office365-Filtering-Correlation-Id: 61724fd9-d017-457a-0915-08dcfcbde2c1
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?T3g3VXhScnI3dDlTUzdkaWZObnRiMkVxNU84SFdxYThQQ1ltV3htTFYxN2tx?=
 =?utf-8?B?cDNweVoxUjJVakw1VGtobHdic2dqYkE4Z1JibDJKZ1ZYaG13RlJUMmZEWERT?=
 =?utf-8?B?ZW0vb1p1T2V6ZnN3bDJzOWlhUCtUVVl1ZGY4Smxqd2dSVkRzT0t2Smw4VUNi?=
 =?utf-8?B?QlRtSUFiczViZkRzTk9NdVdHL3RtYzJQeUVjY1NJQ3ZEcm9OK28vMUx2bkZE?=
 =?utf-8?B?Tmp4bTZGREk3ZHlyTnBHRzJMV1ZtS1JlZWpDdlhRMWE4dXZPQzFDMzBYenAw?=
 =?utf-8?B?VEJVVWpmNWFzSnF2MVNaSlJwWWhmdUk2UG9kSE0rcWt6TmNxbnE0WldKb1A0?=
 =?utf-8?B?c1hUM2RKR05HanNlZ09Nc2NLTmNHVEU2UEg5Tzh4aGZvVlFiR0ZvRTZseHZD?=
 =?utf-8?B?QWtjUXVGbFcvUndQZ2lmQnNZNlRVYjF4TnBDYmlnWjRwQ2NYYXk1NllKN2RY?=
 =?utf-8?B?RXVhM3A2elRsZmVTb2RtTC85VFFjQWFncDFCdTRsWlpjcUEwZXVwQVozMFBq?=
 =?utf-8?B?M045NmVXSkVROXF6dU5CYllmM0pzTXlKK3A0MVFaQ2xsSXRlWlJqMU5ONUY5?=
 =?utf-8?B?SkxnejFNZ3pDT0NDK3ROSDA0T0grYy9nNmJNKzFieWYvTnQvQ0k3QVkxMFk0?=
 =?utf-8?B?bmJYczJWN1BzeTlnSzNWQlhuN1doOG4xdklXSTBNNVcwUnV1WEF2dUU4ekpC?=
 =?utf-8?B?Z0VQcUNLRUpKcEN1WXJuMjg1TlBSczJtQXEyZEFDNVhucG5BYi9sQ1BPS2k0?=
 =?utf-8?B?L0taYVFsdjRjR1ZyUGZiSC92YXAydy94SVF6T1puTU1IdGErb0JQV2ZMMjMz?=
 =?utf-8?B?WXhjTzlDdkZWUEkvVTUxWTAwWFRDRFVCMWF1dVZGOWQ0Rk5zZjIzWGZqYjFv?=
 =?utf-8?B?WTlHa2ppZ3UweEFGTWlzb0tYSENrS1Z4L1dnZ3hvK3pCWGdGclV3ZjFmcktT?=
 =?utf-8?B?S0l0NE82dDcxbHNkTTFEbnU5VzFsbnFjaEwvc2hPUVpvUDFySGF0cVhTUHNk?=
 =?utf-8?B?ZVlrSXZKRzR5OW5XRDRyNHFrWEhKOUYxREdnWEpIV01iQUNxQ21OTmhsMFUy?=
 =?utf-8?B?SEZRSG1ONS9lNEt2bDV4SlpBK2d4aWx1Y0VkcTd4VGtDRk9qVFI4TVFyUVha?=
 =?utf-8?B?YWQ3VC9RbnJSd1JxQWZwS0dIaHFxOWwxUkJ1VkxPb3lKS29iUmF2V0ZYZHNk?=
 =?utf-8?B?enliZ2M2VjR4UXdjTmFOUGtnNHpadzdmTnowME9XQzdyTWQxZFN4eTNURzZo?=
 =?utf-8?B?TjhieXNLYnduN3RFMmJ3YkgwQ2M0UzNQcjByL2JKUGZQT00wVU9hcG9TR2py?=
 =?utf-8?B?YjhIMEtKbDdZMjhRT3BVYzJrWFRHdGMzQjk1ZzA5OVVhTFZZcWY0VFV4ajNG?=
 =?utf-8?B?dHFHWTNhWXYwUnQvNW1KMDZhcHc4cjhvdGFhL3N5aUJCWW13WUZzOHR0ZjNl?=
 =?utf-8?B?dmZiVmY4MTMrWXVMYVF6elhTQ1Z0N0xFTmg2VmlYRjR5ckx5M2VYUkdkOThr?=
 =?utf-8?B?YnljVjZhSDdVYlhkNHhXQVJxeFVwaU9aM1k0blRwNEJEVmZQL2tJK1BrU0FT?=
 =?utf-8?B?RXRubUNGdEtSV1NqanYxa0VMMzREdWYvc2tnb2ExUFN3ZTFjU3dFb0d3K3cy?=
 =?utf-8?B?Q0FVMno3WlNWRkRvdlRTT1VOalpjcDVZWW9IN3FVZzhCTmp3bHZlVDRydWEv?=
 =?utf-8?B?NU53ZjVYRW5QTTcwQzVFcFJlZVZsSmdZQkk4SXkvVnpueHBacm51Q25SQWUw?=
 =?utf-8?B?dU1FenNkTjNtaVgrS1JVdTk0aW9CcURMM0J2Q3FOWnJwUmRVTllpZFkzUDF0?=
 =?utf-8?B?czh4em5vaVowcVBCcnAwMlVDUjRUTFV0NUtxamNQdmRweU9YYjF3a2VFcUlP?=
 =?utf-8?Q?shB1ubqj+/19a?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0F5C6DAC90D2542B593134A38E013EB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5953
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: 
 ip=[2603:10a6:102:2a3::12];domain=PA4PR08MB7411.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	f1d2d141-b966-4199-c9d6-08dcfcbddd4e
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|14060799003|82310400026|36860700013|1800799024|35042699022|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RStSdFBINC9HanlQN0d3eDViL2RFTWdnVGhVazFuM3hBN2FNNzEzQmhCSG5N?=
 =?utf-8?B?WHVTbGgySTMxb2lNSlNsSTFabU5YYmN3K2lmY1c4YkYxWDhFMVhoVlppOEdz?=
 =?utf-8?B?ZkcxOUVDT0FoYzJvMGxXaEQ2ejN6dGh5ZVQ2dmcra2RidUh1SlVUelc3a1pZ?=
 =?utf-8?B?ak1iaVNuVXJVaitLaTNSVGNwd3FXMlBheUxHbU12SlJtemQ2TGt6U0NZTHEz?=
 =?utf-8?B?TUF0V1YrM0IxZG02R3BRY1lrSmM2engxYXpDaTBDd01aaTVLY2F4MDVnZmEw?=
 =?utf-8?B?WDVuemo2Sk11QjNsUkJCWW5NdytIZVV2Q1YwOEllaVBrcUpUS3hUWTU2NVRK?=
 =?utf-8?B?UkVoTEhLUWM2VTBnYllGUUZ0Znc2MjRkTms2RVRPS2hTcHNBVUIxV1prL2Zj?=
 =?utf-8?B?NkJnK1FWSzFuN3J3N1NOUWFGNWo4UTB0NUdnZGxpSmVlWlp3TFBOMDI1Rjhv?=
 =?utf-8?B?dW5vT3pNRytzV0ViY3dkOHFMQVA3TFpBUE92cWYzMzIwY3FiTzFXbWNkeElu?=
 =?utf-8?B?d0MyOW5kOHRJeTIvSDJtQzBDdXFXWkViYmRKZFp6R0g3YkxUNU0xS3R3VDJu?=
 =?utf-8?B?M0ZtTGxjeXBUVlo0RVR6OWpLcDZHemdyUG9kbGROamE2ZEpQUGFZRXQyR1FI?=
 =?utf-8?B?RFBiVnIvby9CdUFjQWV6bFlVSjVrbnBhS3VUT2tEMVpRVXB3R2Q3Zys1VUEx?=
 =?utf-8?B?bU1nc1o1QmdOS3lkWjd6WkFXbzEvNHNuWXc3cWVTZmR6TEtha2lQTkVia3pj?=
 =?utf-8?B?TFNtZUlLaVFRU2prWGpvR2d5Mk5uMkE0YmQ5SVE4NVg3bXRIbnBWbzFDVkVK?=
 =?utf-8?B?SFNwMkV4T3VjUEcwWFgyaDRxSk8rOGRYWnVtejI5UXhMMXVuNUV3WmE5UXM2?=
 =?utf-8?B?R1F0VlJCd0dlRHdOQU4vc1hkdnorUWlaUXp1YUtMTCtMZnc3K25iM05VMmdj?=
 =?utf-8?B?bXdvZGdGbUx2VlVNaU9PQXFlRVIxYWZQVW5WZUhBYXZHWEticmZ0QXNUaGVK?=
 =?utf-8?B?LytGQVh6MXVBOWhBY1F1b05mMVJtSmtVWkd2eGZPeGxJcnVtWnZGM0cyNEg2?=
 =?utf-8?B?M1R1V0tSbVRxbHMvelBLMVl1U0VFNUlpSi9ESlAvMlZTQndqaXFnVUJreU9r?=
 =?utf-8?B?cDdmRy83U0NCODc2SkdoRGNNSHJoeUh4VHJON2I1WDlDejJuSWw2TFNUTlBy?=
 =?utf-8?B?dGN2WmhHSHhCRnZMNWh5RC9PK3hwTWNXRWpFcWdhdEsrTFhYeXRZZzd3Tlpu?=
 =?utf-8?B?WGlsbEFrNEgxQVBTVjlmdmZFSzZPRUtOTGI5Y1BzOHdaYWphbzVnRk9DK3dx?=
 =?utf-8?B?c2prdk9wZ3NOMzZjaU9mU0k5YUxzajh3Y0VCVHVVem92NWdUNzdBbHQ3a21L?=
 =?utf-8?B?UkNnbXJ1MjRrL05yaWlxN0JOZDBKZWZINktkQ1cyMDc5N2NWc2dCQjRrMVY0?=
 =?utf-8?B?bWRYVFcxUHNybW1ad1dUMUJkbTM5eklFZTJDN1cyNTY2dGloRUYzOGkwTHpm?=
 =?utf-8?B?TVIzS0VQek5LN2VKd3hHK2Z5ZXAxU3lhZFhMeHhMS0xDNldhOFdVclpTamcr?=
 =?utf-8?B?akM3dUlWZEpJSm5VVFFYaUlJVk9ncHl2WHBjUDdPV1B0b1owQndMS2NCWkZE?=
 =?utf-8?B?blIvblU2UU9ic0M3aWhPbldMS1NUNlpzTlVEZllsWm5wZWxlYi9kRzVlcFow?=
 =?utf-8?B?V0Z0a0l2VkxBWUZiWkc5WmFYS2xmSk5MVXh6OGFkWDZpcjM2TWxpOXBpTmF5?=
 =?utf-8?B?UUdKekxHcmY2M3VyRmFTNzVjYlhKSGZINWs5UjdWVER0aGxpM2dyM3NZTzMz?=
 =?utf-8?B?cWNuTEpublBiQmEzL1d2cVgxM0x3STcrMGd6azVVYlFQajB3UjdBSFpySmRk?=
 =?utf-8?B?eU1ibDF4ZTlBejNDdWdxUXA3RUZYMWpIeGFzWFpRSlNINXc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(36860700013)(1800799024)(35042699022)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 10:46:06.2619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61724fd9-d017-457a-0915-08dcfcbde2c1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11102
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 Nov 2024 10:46:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/787

T24gMjQgT2N0IDIwMjQsIGF0IDEyOjA5LCBEaXhpdCBQYXJtYXIgdmlhIGxpc3RzLnlvY3RvcHJv
amVjdC5vcmcgPGRpeGl0cGFybWFyMTk9Z21haWwuY29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc+
IHdyb3RlOg0KPiBiYXR0ZXJ5IGFwcGxldCBzdXBwb3J0cyByZWFkaW5nIGJhdHRlcnkgYW5kIHN1
cHBseQ0KPiBpbmZvcm1hdGlvbiBmcm9tIHN5c2ZzIGVudHJpZXMsIC9zeXMvY2xhc3MvcG93ZXJf
c3VwcGx5Ly4NCg0KRmlyc3QsIG1hbnkgdGhhbmtzIGZvciB0aGlzLCBpdOKAmXMgYmVlbiBvbiBt
eSB0b2RvIGxpc3QgZm9yIGZhciB0b28gbG9uZyEgSG93ZXZlciwgc29tZSBjb21tZW50cyB0byBt
YWtlIHRoZSBjb2RlIG1vcmUgaWRpb21hdGljYWxseSBnbGliLg0KDQo+ICtpbnQgcmVhZF9maWxl
X2NvbnRlbnQoY29uc3QgY2hhciAqZmlsZV9wYXRoLCBjaGFyICpidWZmLCBzaXplX3QgbGVuKQ0K
DQpJbnN0ZWFkIG9mIHJlaW52ZW50aW5nIHRoZSB3aGVlbCwganVzdCB1c2UgZ19maWxlX2dldF9j
b250ZW50cygpIChodHRwczovL2RvY3MuZ3RrLm9yZy9nbGliL2Z1bmMuZmlsZV9nZXRfY29udGVu
dHMuaHRtbCkuDQoNCj4gKyBzbnByaW50ZihmaWxlX3BhdGgsIHNpemVvZihmaWxlX3BhdGgpLCAi
JXMvJXMvJXMiLCBQUk9DRlNfUFNfRElSLCBkZXYsIGYpOw0KDQpHTGliIGFsc28gcHJvdmlkZXMg
Z19idWlsZF9maWxlbmFtZSgpLg0KDQo+ICsgZGlyID0gb3BlbmRpcihQUk9DRlNfUFNfRElSKTsN
Cg0KQW5kIGdfZGlyX29wZW4oKS4NCg0KPiArIGFjX3N0cyA9IGF0b2koYnVmZik7DQoNCkFzIHBy
ZXN1bWFibHkgdGhlIGZpbGVzIGluIHN5c2ZzIGFyZSBkZWZpbmVkIGFzIGJlaW5nIEFTQ0lJIGRp
Z2l0cywgaXTigJlzIHByb2JhYmx5IHNhZmVyIHRvIHVzZSBnX2FzY2lpX3N0cnRvbGwoKSBmcm9t
IGdsaWIuICBUaGUgc3RhbmRhcmQgQyBjb252ZXJzaW9uIGZ1bmN0aW9ucyBhcmUgbG9jYWxlIHNl
bnNpdGl2ZSB3aGljaCBjYW4gY2F1c2Ug4oCcaW50ZXJlc3RpbmfigJ0gYmVoYXZpb3VyIHdoZW4g
cGFyc2luZy4NCg0KVGhhbmtzIERpeGl0IQ0KDQpSb3NzDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUg
Y29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRp
YWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8g
bm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9y
IGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVk
aXVtLiBUaGFuayB5b3UuDQo=

