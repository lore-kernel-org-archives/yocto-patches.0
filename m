Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA93CF65DB
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 11:00:46 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17151.1769425239848988751
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 03:00:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=PBEpmmS+;
 dkim=pass header.i=@arm.com header.s=selector1 header.b=PBEpmmS+;
 spf=pass (domain: arm.com, ip: 52.101.72.50, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DEoxtb6U2Z1LQOS6x83EIcrkTXrMPARSw92D8JewWDWaKh9oxlPcKDvUiq9Ar1oi0omSBCmf37AjFXEkM0umRgpN0StPoOXDY0parzAzjx4TNnwMkzmUOIiEBIfXsGRPfxaRRT4qWIBrK7E77k3QMMgiRBGKRt3fEZVUPhgtBNF+MKzTy/WmT6oztU3+QHTP35Ou5zB2AutPi0Cj1mmxXFP+N12u8xAFNqq6yhLU5XXW9ZJ9f26UYHlHUbHnQ/IxJ5iftsQDdwrizfk/WWvU+zCXMAU7tPFYg4t8LqPBrEx9tRnRPN8KZ0VesCBuEqZOP+1NwK1+Ja/q/BqJFPz0gg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K0y3acmTRFeh8HMVuUVt4MlOPJmT75seEmGNlhVgj8=;
 b=y2c1qHmNwbjgA4Hr6NtxS6ZW/Pccv4SWE5ky1DULXzP1d2KnN2/bzZFZj2lJdfRpZUzS40H4o3uIWtCqHjmSsZFukv6Rw3WrUiTKaUdyxYhso9nrFQvSii8Xm/jAVpkOMhhD6i853uZpsyEdm76beCqWsy+MY4LCwPJXsmAnET6vSv+Vx7+QWQPD6+IshvL1Mdj71G2YFzr/Wkr7zEUvys2x2SH42dyBRs/D7obcEnZ5g0ryadBYqZ5XjYsqOkb+Gef0yldCNQFUVCgCliC3/3hjkr8u6/kmVSGALfELVc6ipnprex8IuD7xXFnKUH/0BcnazkwkLF6SlxBApwO+pg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.yoctoproject.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K0y3acmTRFeh8HMVuUVt4MlOPJmT75seEmGNlhVgj8=;
 b=PBEpmmS+Qo68n84jlUKxvjma9nY24zNWfMw2piuy5HydhUc7APEsG3hadwdeM3fnkGVXRgCsbnIdYI7+zfNpNtoVxgB8A3KyQ+VIcDiaFwn7cLucdwPdZL1Bhh5zikSCKJ3PPsSeFMHIQcjho2+aXY36Yt3yqq/G6N/07J7klYY=
Received: from DU2P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::28)
 by PAWPR08MB8984.eurprd08.prod.outlook.com (2603:10a6:102:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 11:00:34 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::60) by DU2P251CA0026.outlook.office365.com
 (2603:10a6:10:230::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 11:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Mon, 26 Jan 2026 11:00:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7h95tx3i8A1aQMAALNkGUGqjKfzlf/QBS13YDvEGOGQN8nC+psS8sHTjj2927/1dF5ZgGvWXCFLw2uNeiOnfv27t0UsLmQvYDwcSUCPbuIFosENN43/pORwjam3aADSXaWGor5FLW+QYKitnDnLsAViPvkujAaUNP72w1isU6ZJyDBB9L4SX+OKZgyoG8yC280JKepBdkAtwABGPRm76ySPPwlTtGzHyzgVNXxVCxFx54HBFmeXII54DK21gxnHXKO0I+KNTJigXgFab0S+9xuHiEV+Vhyl9rfaSOee8kbHIT8irtegWDknoQJRgCI1FzgOLwZarsBu+CYK1IUKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4K0y3acmTRFeh8HMVuUVt4MlOPJmT75seEmGNlhVgj8=;
 b=GAGiKa++ylvKrDryxBsmDFDSI2+pwlqp7EC2wKFAHCE8/LZ6QYqYXQQJdlQ5BlA9WVeFvSjCeW/cduKJ2ahwOe3bqv32umGqyWLYy7Z5DSSnoeXmZEhH3ij6hJJs6/uA/h5LkcfYJwAuFwLraL/fmoZdd7KE7Yr72mZXWBrVf7RbTzoKwzQfIffEdpps3Cq26hcwMEHyVgyDttwnYe3+KvNFaeRdz3vsdVlrWZuWOElsqHp15zsq/8CzuY7M+CLSyUDVMzavnBcLqssqvVk+NwhaoH3CDAoygz+ZUaFxzLQwmzRw3oV9l/t7TLW6flDNMeRfh19cknKVISJhnebn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4K0y3acmTRFeh8HMVuUVt4MlOPJmT75seEmGNlhVgj8=;
 b=PBEpmmS+Qo68n84jlUKxvjma9nY24zNWfMw2piuy5HydhUc7APEsG3hadwdeM3fnkGVXRgCsbnIdYI7+zfNpNtoVxgB8A3KyQ+VIcDiaFwn7cLucdwPdZL1Bhh5zikSCKJ3PPsSeFMHIQcjho2+aXY36Yt3yqq/G6N/07J7klYY=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DB9PR08MB7651.eurprd08.prod.outlook.com (2603:10a6:10:30e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:59:30 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7f73:806a:3493:7d50%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:59:29 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "yocto-patches@lists.yoctoproject.org"
	<yocto-patches@lists.yoctoproject.org>
CC: Peter Marko <peter.marko@siemens.com>
Subject: Re: [yocto-patches] [yocto-metrics][PATCH] patch-status: add
 whinlatter
Thread-Topic: [yocto-patches] [yocto-metrics][PATCH] patch-status: add
 whinlatter
Thread-Index: AQHcjWuJMqLPjUq70Ei46CgC2WIC97VkSsyA
Date: Mon, 26 Jan 2026 10:59:29 +0000
Message-ID: <F7383EE9-2EE0-44C5-91CC-AF540D574E5C@arm.com>
References: <20260124195614.1874743-1-peter.marko@siemens.com>
In-Reply-To: <20260124195614.1874743-1-peter.marko@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81.1.4)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DB9PR08MB7651:EE_|DB1PEPF000509FC:EE_|PAWPR08MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 4890887e-d272-4725-64e4-08de5cca20d4
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|1800799024|4022899009|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?U0pGVFZEZGg5c1U1SXUzdEVEVHhmcnZSM1NNbjFwQ2dIb0cycUZvTlVpWUVM?=
 =?utf-8?B?eUJDMXlsSWhRMjI3Yk9YS2VMVnF4cldCWXhqZ2ZJWDIvSzYxSUdUTHRWWFk0?=
 =?utf-8?B?bjlpVW5QTVBzZVVWbUd2YWFnaUNmbVRiL0dpdW81U3V6bWVEaGswamc3STRO?=
 =?utf-8?B?SkxveXlPSHJRNUZmd0ZzSlVQS0tIZlFucjFKWXduWHJtbVgwM2hQd3lGMkc3?=
 =?utf-8?B?NGdLeldDTkF4NWJKTGdRVFJPTWh1N25RRHdkWHFTQ0REblB3L2NUYkVsTjNy?=
 =?utf-8?B?dEZrUXZTNVU2aUlhWEVrdURmQktFUGltbi9nT0s0TFN2Q2ZOVml2UWtlZWVs?=
 =?utf-8?B?czdZTTI3ZklLd2RzT3R2dzlubU1paGdtS0pOMTBtc3h2eVJnemhxSzdWRmFQ?=
 =?utf-8?B?NDBTSGVYNVlXbVRmZUN4MXZEOUZCMDl5ZHg5RWxqWnNzWFQzekRFSFZmUnhn?=
 =?utf-8?B?cnM2bW5TMjV4REZubFpxRXlJUWk2OW9TdVJxeFRFSTVCaDh5eDFPWExSNVIx?=
 =?utf-8?B?UFFjU21mMFZhaldtY09BclVMbTljNlgvTU5nbDBzTlEwOXVxVlRyT0lwZWZk?=
 =?utf-8?B?ZEhieDBVTW1wWVF3aTdOVUNOWFErVkVCYUk2b2NUN2MvYU9qZkErYmtHR3g4?=
 =?utf-8?B?blRkUTJWQUpUM05nMEdNeVpqUGxndDFhbmZEYlU3Vm9ZUkFNQ2xBVEVBNEdD?=
 =?utf-8?B?NzY3U1FrTnNHWVlaM2l1dG9vT2NqN1J4RVE3VnVpNWo4K2UvejNhZS91SlNY?=
 =?utf-8?B?VUI3QWxndjVHbnI1YmNhdzJTS000RVBnQmZRNUJzV1pVRnRGUGo1R3pjMG1l?=
 =?utf-8?B?WGN5NXNnS2xCZXZRSytaUnFRVXRwSC9BZ1F0SmlSbi9OQ0lIa3ZoNGRpeGF4?=
 =?utf-8?B?WFJwTWIxV0licmc3ei9LZHVFWWxWNUpGSWRWS1gzWnRFQ3JuZUJsY1JZNzVi?=
 =?utf-8?B?S3kvOTlpa0UwZzhEbWpiZTYzRnhpZXFSQ2tKS1UwYXlhRElENS9LS1psMGNZ?=
 =?utf-8?B?SW5EbTBQMERxRnZ0bXRRR2tBU3NtaFd2US9JczZodmlJSjZXcktlU1Q5eGNr?=
 =?utf-8?B?cVdKTnFNek5xWjFoZlJJSUtDSVAyaGxSRENKb1MrdzRPdDlmMVVmTStLVU9m?=
 =?utf-8?B?dHZKbjFZTjRCZWJXRnNQV0tsdEpXajN4RG1mZEdTS2h4ZXFyRjBxMElHQ3pB?=
 =?utf-8?B?M28zOVFRdkp4V013M082d1NZU0hBRTlqVHhwT3l4S3pCU2xtMFBCZXE5b1Ex?=
 =?utf-8?B?dVNYa1dWTm82eWNZN3dYN3pMOHNqYnQrNUpxajRhR01mY0s3MlpqSDZxb2wx?=
 =?utf-8?B?TXlkTDhnNVVKMGc0cnZRZHczZHNLZlRzd2pwNWpnWFZDSDlSUTE3QzMxZjNT?=
 =?utf-8?B?ZjR3RC9QNmV4UTFpZU9vRUd0MDRLV1FOWFE5dkh0RnBQSnJKSWVWN1J5M2dB?=
 =?utf-8?B?RmxjaFRDRGdnR1IwZnhxZGxocDBkSy94NFhWOGJUNzhXSG5PVkd0ODlhOWNZ?=
 =?utf-8?B?elRVWTF4bWMrVWx0d2RpTnYrU1c2b1p4aDdjcUlEd0dhNlBMbWtpSkJvcGE1?=
 =?utf-8?B?NWtCV1N1R3FRUWRsWXBLa3FSeG1HbDZRdGl6OEVNaXg2elVSclNpL3JyVy9i?=
 =?utf-8?B?RTlScngzU1ZNd2t4UjljOVY1VU4xb2w3UG1tZWpRWVVTcDRwczBPQld5dzVS?=
 =?utf-8?B?cm1iVWtyamRBSm14Mng4VytTUjNsWUphM3BuMmo2WndZQVl4ZnUzTHFhUjJL?=
 =?utf-8?B?a25kRWxQYis3M1BRYklVR0RVNVVGQUV2UEV2bkhoSVY2ZllDM2t6OEZ6SWRv?=
 =?utf-8?B?NGUzUlQ4TUtJS1k2Nk93L2F6akRZNlpJRURta2swWElWZjNrTnZOQXBzOUFo?=
 =?utf-8?B?eWo4MU1pL25HUk5vYUZUSGVZYjkrbFBPakhUblJvd2ljRGZYMVdoT2kvaFdV?=
 =?utf-8?B?RldacjFLRUttelQ5ZXFGSkVRMFlqVExzSTg3Sk9CSkpKbmdDbVcvRkdlRUdq?=
 =?utf-8?B?RGVMcmhmU3VpQlJsOE1HTkxJL2ljN2VFOUFHVWsrbmpIU2NaUk9UdDZraElX?=
 =?utf-8?B?bTlRdWVHaUVwSUxvQlBZZ1pTS1IzWXVtOFJTN3NSMGFEbk9hdDgyaEVML0Ey?=
 =?utf-8?Q?W0JLawjhHaqg/e9QY+NrWlUeX?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <186F1FD382AEB941B24318453C8E3CF9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7651
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	dff84756-aecd-4b6c-a4b7-08de5cc9faa0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|35042699022|36860700013|14060799003|1800799024|376014|4022899009|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V1JHWEVkMmNuV0dXeWh4aU4reFNybnBIOHAwKzFmT1ZJQmllTWtUdnJxWVVx?=
 =?utf-8?B?L0wxRStGSCtyK2dsZDFmWitkZGhsWG1vRGp6ZDR0UENrK3dPWDF6V01ldXc4?=
 =?utf-8?B?Y1NVTjBTQlpEZ1ZEU002cmFOQUIrM0hucEg0YnJvU0FxVXUrUlBJUHpRQ29G?=
 =?utf-8?B?OUowUGxyQUJEQmVUN0RWZDZDMUNGeWdZYURuUUp6Y1JML3MvdlI2R2N4ZTl5?=
 =?utf-8?B?ZHk1ZnlXbFQvay9MMjJ2MmJzczNvVEI1QjFBN2JxQnI2OXc5N292YS9MSzVp?=
 =?utf-8?B?blFIY213NnA5TVdoTUJuYkhqVlk1L3hOK2Uwd2p0T083RW1KVkQ2RE5oSXBU?=
 =?utf-8?B?bjYrWkkvR3RHb3QxQU1mWjd0NExEaEF2bzcxVFo4MTJ6a2xOdy9pb3hKVldn?=
 =?utf-8?B?OE92UU9QZm55eG0wQ3dhRi9iUVNSRElNOWhTWHg4QUtLM1JMTGVTYkEzbGJ3?=
 =?utf-8?B?L240MG5BYWRUMnRwVGJ1OXAyZzhOdkl4V250MHFYN3ZQZUgzQ0tCcDFXWVFH?=
 =?utf-8?B?enovWHJ5aUtZVGpKN2ZQWFhkS1N4NTFVbWNHVWZUY01WR1BXQnBmNFUybFFE?=
 =?utf-8?B?Nk9kMjRVVVN0Kzg2SDdqSkRQRDFkMGNURkZDNWJHektWVjI4MVRaem1qUGlr?=
 =?utf-8?B?cXpwcHBnL2xjL2pvUkR4Y3o3SCtTTjRHbm1vdHRYYjZvbTExTUdlbVptK2No?=
 =?utf-8?B?TUh5RjgxblhPQzlKdXFNOHkzamxpVzB4NlhIQlh0VmNBTTN6YmdEV0wyb2w2?=
 =?utf-8?B?ZVo2UEcwWWI1NzNHNjRiU3gyU2oxbTBuWVJEWndwRjQrQTl4d0xzNDRyNDFo?=
 =?utf-8?B?UkFLcjlXZUtUZ0xGNGRSaEE0VlV1QlRsamM4NjhEbVBPbGc3ZXl2MTZObGdz?=
 =?utf-8?B?UmlzL0JZOTdWTUhZM1lhZHliWC9sZ25Db2w0Q3ZFVlZ1N1M5MmRQUXVvUC8r?=
 =?utf-8?B?ZUxYbERGdWpTU0QzSTk5aXBpcGp1QUF1M0JFZWtBMUtpdnlGamVyMHRvVXV1?=
 =?utf-8?B?R1ZlUTNVTCtBZGt3b2t0WC8wRE1uUWZ5ZC83TGJtSldSWFFUdWVRUUZoVDA2?=
 =?utf-8?B?YnFveGU5eWNLaTdpK2g0VU96Vk1JbjcyRlpWbHNFUldybElBZDJqVW9rSllk?=
 =?utf-8?B?b0tseFo3eC9HQ1Y3elJrWHlDZUN5dlZrUVF1Y0Q5VDVNMzZ5b1B3dnhLL3hi?=
 =?utf-8?B?OGdRMjYvOStGQWZmd2ZkVHY0U0s2VEVXYzRHbGd5N3p0UGFMT1JIUHNXL3Zt?=
 =?utf-8?B?VGY0M2lPQ1cyMktORW5QcjJBZ2RISnNFZ1Jndi85ZDYxbVhGUEJpVG5Ra0pq?=
 =?utf-8?B?dy9UaGp5ZWtkWFhlVlZ1cGx6cDNrQWJkOEI2L0Y3UVkvRHdiakxWSFkwcG9r?=
 =?utf-8?B?T2FCLzk3aUY4RnJ3aVNybExrbjZINmJpU0xqMTRvdUxHeGV5RFBFRTgxSFlC?=
 =?utf-8?B?S2ZIY3RUNVRTcjRSd1BWRzFvc3lMblRTclVHZ0JGT1RxbmZRWHhJU2E3cUlB?=
 =?utf-8?B?MkMxSlJlK2pMdHYvR0JabnlOdXV0bHZMQVgvQnhzYmNUMGEzN0tvYjhOaUw5?=
 =?utf-8?B?S1IyV0xEMkFsQ3VOTldMY0cvUjgzdHFTV2FRU1RKNG9xNDluVnhNVU9QYXhL?=
 =?utf-8?B?alNEeUJLV2s3NkFKcStTcTNNQUZXWGpmTnVHUjVjRU41T09nRHFZTXZWTThy?=
 =?utf-8?B?ZjRWTmFxNFFNTzhsZzdES0tTUXFubXpNQ08yK0dmcTUwdFdjM0ZwbldrMXpt?=
 =?utf-8?B?SzNLT0hEVjRpVUMxdG5zWEJIaVp3dGFPZmliQU5iZ0ViU3dJUlJuUTZ2YzZy?=
 =?utf-8?B?bW5tVUVxME5hd2dHYThXN3loUUMxTEFJN242aFNQcjlzTkdFZ0RVL2tpb3Rh?=
 =?utf-8?B?ZWNFSk40ZCtCNjRud2JUTHRRLzQ0SVBYcW1sZWliaWZ2N0Q2a2tpaEhBTDJz?=
 =?utf-8?B?TmJra3dBT1oyMHdIWENxa0o1TWNOVTJvODZMMnZ4aG5wZ0lTcjg5eGxqMUd0?=
 =?utf-8?B?TGNSNG5RTnovakc1VnIwUzIxSm9TdjNsQ3Fmenc4bFI2ZFBzVkRXS2Y2Rzcw?=
 =?utf-8?B?ZSthb3JYR3R3TlRZakJ6WW5yb1c1dU9SMFZ2emFSRU1ONVJiWXMyakcwamF3?=
 =?utf-8?B?WlE4QXp1NmtjMUg5a1drN2s5NWJNRW5NV2FEbXRxLzkyK09uWU5NdEtGOEZt?=
 =?utf-8?Q?jipNrlSi7P2g4EzC1/aBvB0=3D?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(36860700013)(14060799003)(1800799024)(376014)(4022899009)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:00:33.6547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4890887e-d272-4725-64e4-08de5cca20d4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8984
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 11:00:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3080

SSBhY3R1YWxseSBoYXZlIGEgcGF0Y2ggdG8gZHJvcCB0aGUgaGFyZGNvZGVkIG5hbWVzIGVudGly
ZWx5IGFuZCB1c2UgdGhlIGV4aXN0aW5nIHJlbGVhc2VzLmpzb24gZmlsZSwgYnV0IHRoYXQgd2Fz
IHBlbmRpbmcgb24gc29tZSBwYXRjaGVzIHRoYXQgSSBiZWxpZXZlIGhhdmUganVzdCBtZXJnZWQu
ICBJZiBpdOKAmXMgZ29vZCBJ4oCZbGwgcG9zdCB3aGF0IEkgaGF2ZSBhbmQgc2VlIGlmIEkgbWlz
c2VkIGFueXRoaW5nIGZyb20geW91ciBwYXRjaGVzIChJIGRpZG7igJl0IGRvIG1ldGEtb2UsIGZv
ciBvbmUpLg0KDQpSb3NzDQoNCj4gT24gMjQgSmFuIDIwMjYsIGF0IDE5OjU2LCBQZXRlciBNYXJr
byB2aWEgbGlzdHMueW9jdG9wcm9qZWN0Lm9yZyA8cGV0ZXIubWFya289c2llbWVucy5jb21AbGlz
dHMueW9jdG9wcm9qZWN0Lm9yZz4gd3JvdGU6DQo+DQo+IEZyb206IFBldGVyIE1hcmtvIDxwZXRl
ci5tYXJrb0BzaWVtZW5zLmNvbT4NCj4NCj4gU2VlIGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0
Lm9yZy9nL3lvY3RvLWFubm91bmNlL21lc3NhZ2UvMzY2DQo+DQo+IFNpZ25lZC1vZmYtYnk6IFBl
dGVyIE1hcmtvIDxwZXRlci5tYXJrb0BzaWVtZW5zLmNvbT4NCj4gLS0tDQo+IHBhdGNoLXN0YXR1
cy9pbmRleC5odG1sICAgfCAxMiArKysrKysrKysrKy0NCj4gcGF0Y2gtc3RhdHVzL3JlbGVhc2Vz
LmNzdiB8ICAxICsNCj4gMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9wYXRjaC1zdGF0dXMvaW5kZXguaHRtbCBiL3BhdGNo
LXN0YXR1cy9pbmRleC5odG1sDQo+IGluZGV4IDliZGNkNDc4Li5kZDQwNzUwMiAxMDA2NDQNCj4g
LS0tIGEvcGF0Y2gtc3RhdHVzL2luZGV4Lmh0bWwNCj4gKysrIGIvcGF0Y2gtc3RhdHVzL2luZGV4
Lmh0bWwNCj4gQEAgLTE3MCw2ICsxNzAsMTAgQEAgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1J
VA0KPiAgICAgICAgICAgPHN1bW1hcnk+bWFzdGVyPC9zdW1tYXJ5Pg0KPiAgICAgICAgICAgPGRp
diBpZD0iY3ZlX3N0YXR1c19tYXN0ZXIiPjwvZGl2Pg0KPiAgICAgICAgIDwvZGV0YWlscz4NCj4g
KyAgICAgICAgPGRldGFpbHM+DQo+ICsgICAgICAgICAgPHN1bW1hcnk+d2hpbmxhdHRlcjwvc3Vt
bWFyeT4NCj4gKyAgICAgICAgICA8ZGl2IGlkPSJjdmVfc3RhdHVzX3doaW5sYXR0ZXIiPjwvZGl2
Pg0KPiArICAgICAgICA8L2RldGFpbHM+DQo+ICAgICAgICAgPGRldGFpbHM+DQo+ICAgICAgICAg
ICA8c3VtbWFyeT53YWxuYXNjYXI8L3N1bW1hcnk+DQo+ICAgICAgICAgICA8ZGl2IGlkPSJjdmVf
c3RhdHVzX3dhbG5hc2NhciI+PC9kaXY+DQo+IEBAIC0zNjksNiArMzczLDEyIEBAIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gICAgICAgICBjcmVhdGVDVkVMaXN0KCdjdmVfc3RhdHVz
X21hc3RlcicsIGRhdGEpOw0KPiAgICAgICB9KQ0KPg0KPiArICAgIGZldGNoKCdjdmUtc3RhdHVz
LXdoaW5sYXR0ZXIudHh0JykNCj4gKyAgICAgIC50aGVuKHJlc3BvbnNlID0+IHJlc3BvbnNlLnRl
eHQoKSkNCj4gKyAgICAgIC50aGVuKGRhdGEgPT4gew0KPiArICAgICAgICBjcmVhdGVDVkVMaXN0
KCdjdmVfc3RhdHVzX3doaW5sYXR0ZXInLCBkYXRhKTsNCj4gKyAgICAgIH0pDQo+ICsNCj4gICAg
IGZldGNoKCdjdmUtc3RhdHVzLXdhbG5hc2Nhci50eHQnKQ0KPiAgICAgICAudGhlbihyZXNwb25z
ZSA9PiByZXNwb25zZS50ZXh0KCkpDQo+ICAgICAgIC50aGVuKGRhdGEgPT4gew0KPiBAQCAtNDUx
LDcgKzQ2MSw3IEBAIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQNCj4gICAgICAgdXBzdHJl
YW1fc3RhdHVzOiAnTWFsZm9ybWVkIFVwc3RyZWFtLVN0YXR1cycsDQo+ICAgICAgIGluYWN0aXZl
X3Vwc3RyZWFtOiAnSW5hY3RpdmUtVXBzdHJlYW0nDQo+ICAgICB9Ow0KPiAtICAgIGNvbnN0IGJy
YW5jaGVzID0gWydtYXN0ZXInLCAnd2FsbmFzY2FyJywgJ3N0eWhlYWQnLCAnc2NhcnRoZ2FwJywg
J25hbmJpZWxkJywgJ21pY2tsZWRvcmUnLCAnbGFuZ2RhbGUnLCAna2lya3N0b25lJywgJ2hvbmlz
dGVyJywgJ2hhcmRrbm90dCcsICdnYXRlc2dhcnRoJywgJ2R1bmZlbGwnXQ0KPiArICAgIGNvbnN0
IGJyYW5jaGVzID0gWydtYXN0ZXInLCAnd2hpbmxhdHRlcicsICd3YWxuYXNjYXInLCAnc3R5aGVh
ZCcsICdzY2FydGhnYXAnLCAnbmFuYmllbGQnLCAnbWlja2xlZG9yZScsICdsYW5nZGFsZScsICdr
aXJrc3RvbmUnLCAnaG9uaXN0ZXInLCAnaGFyZGtub3R0JywgJ2dhdGVzZ2FydGgnLCAnZHVuZmVs
bCddDQo+DQo+ICAgICBjb25zdCBnZW5lcmFsX29wdGlvbnMgPSB7DQo+ICAgICAgIHRvb2x0aXA6
IHsNCj4gZGlmZiAtLWdpdCBhL3BhdGNoLXN0YXR1cy9yZWxlYXNlcy5jc3YgYi9wYXRjaC1zdGF0
dXMvcmVsZWFzZXMuY3N2DQo+IGluZGV4IDkxYjk0YmQ5Li4xZThkOTVmMyAxMDA2NDQNCj4gLS0t
IGEvcGF0Y2gtc3RhdHVzL3JlbGVhc2VzLmNzdg0KPiArKysgYi9wYXRjaC1zdGF0dXMvcmVsZWFz
ZXMuY3N2DQo+IEBAIC0xLDQgKzEsNSBAQA0KPiBOYW1lLERhdGUNCj4gKzUuMyAoV2hpbmxhdHRl
ciksMjAyNS0xMi0xNg0KPiA1LjIgKFdhbG5hc2NhciksMjAyNS0wNS0wOA0KPiA1LjEgKFN0eWhl
YWQpLDIwMjQtMTAtMTcNCj4gNS4wIChTY2FydGhnYXApLDIwMjQtMDQtMzANCj4NCj4NCj4gLT0t
PS09LT0tPS09LT0tPS09LT0tPS0NCj4gTGlua3M6IFlvdSByZWNlaXZlIGFsbCBtZXNzYWdlcyBz
ZW50IHRvIHRoaXMgZ3JvdXAuDQo+IFZpZXcvUmVwbHkgT25saW5lICgjMzA3MCk6IGh0dHBzOi8v
bGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMvbWVzc2FnZS8zMDcwDQo+IE11
dGUgVGhpcyBUb3BpYzogaHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL210LzExNzQ0MDgy
Ni82ODc1ODg4DQo+IEdyb3VwIE93bmVyOiB5b2N0by1wYXRjaGVzK293bmVyQGxpc3RzLnlvY3Rv
cHJvamVjdC5vcmcNCj4gVW5zdWJzY3JpYmU6IGh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9y
Zy9nL3lvY3RvLXBhdGNoZXMvbGVhdmUvMTMxNjIyMTEvNjg3NTg4OC8xMzM5NzQ1MjQveHl6enkg
W3Jvc3MuYnVydG9uQGFybS5jb21dDQo+IC09LT0tPS09LT0tPS09LT0tPS09LT0tDQo+DQo+DQoN
CklNUE9SVEFOVCBOT1RJQ0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0
YWNobWVudHMgYXJlIGNvbmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYg
eW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2Vu
ZGVyIGltbWVkaWF0ZWx5IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBv
dGhlciBwZXJzb24sIHVzZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhl
IGluZm9ybWF0aW9uIGluIGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==

