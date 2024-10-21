Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EE7D0E6D2
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 08:49:37 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.52])
 by mx.groups.io with SMTP id smtpd.web10.41832.1729500565626056328
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Oct 2024 01:49:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=RjCGufRU;
 spf=pass (domain: cherry.de, ip: 40.107.20.52, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLr4tIPhECgI8jX7WqriMEE1DThD0cyHtAm5gB4/nrMDphRDxhnqCZbCZMIPh0WG+JNCKWvKUduX81ELQc4rFQ6eDnmbN9esi4sIcBDTa9AcyY/ccM+wGlrmKfXF9nO3A2XfB6DtLP3SH0w82stK7VGPbLEuHDWtY52sjUPjaDAZz55UV8x4Jcf3NuwK/2+Yyt8tjQnEXMYiqXTaIcXgcv4HhTh473obT+VptwHJADAwJOnVVCChxXm30wOOsZm02toEgJyWiw/KmS2VwCka5mhOrI9fEep4depBR0s96mMvYXBT4hR16KtvfeDkys4IWf/jbTxleAW+qCyt5Z6pBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW0krdYGrnWcqJziNqmL03/78wzerPIOK7CbvICot68=;
 b=o9gSm3wsCRLLGBUoshzZc9BzZ/D7GQQduzGzsVyAbm8BzHCsnrs3US7v7vCJVIFfu4gNw6bN0aOQ0mal6u87vFExLdqZXmiC6shYtEypI2XEChutFK+E4Nb+ovQzQ7ZpkJy24zPSKfw86bokWt23FUtNEran7ELwqpfpWdKUZ99aGFCoTWwDvXpSQzgikNKLNgN+YVsVLNSB9eiFyE6t6ecvPrKJdSfvoRWeRD1+eQVgb9nrV2pR4k7vsEr/eVOBoPSyuSNumNhBO/OGh/Bg9e2n0TzRnqAmTbzvlFB4KAhEOkapycqX/UBX6Xge+ypqL6yhDd8KtSGhfCI9z9ZRLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW0krdYGrnWcqJziNqmL03/78wzerPIOK7CbvICot68=;
 b=RjCGufRU+mSBPQgcUAydl0Qvqw/3bvtQs6pW4MFtrPjqVhM6HiSPPS625s0njaJH5VdWg4MME72XDgecbujoB2VswnKKrKXHLjqKkbFB18dLcr9xOOnTLMfF1nekZ7HtkEweAF58aVWTZ0mP2c1W3d7pqekkGZmG7fniSynhSVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB8970.eurprd04.prod.outlook.com (2603:10a6:20b:409::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 08:49:21 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8069.020; Mon, 21 Oct 2024
 08:49:21 +0000
Message-ID: <73467172-c137-4239-90f8-cb94212600fe@cherry.de>
Date: Mon, 21 Oct 2024 10:49:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [matchbox-panel-2 1/1] add mailing-list to README
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
References: <20241020090140.451403-1-dixitparmar19@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241020090140.451403-1-dixitparmar19@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: afc297db-69bc-4e9c-f6ef-08dcf1ad41c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VlpmYllMbWN0NHovZzQzZnlQbUs4Zk9wT2U1UEJjSHlXNGhOVlZRN2prT0dx?=
 =?utf-8?B?SnpTTFAyQUl2V09ZcU5COFlJeHhYWUNKNkdnSFVwYkYvYTZQQ2xFOG1VNVd5?=
 =?utf-8?B?cldJT0MvbllKRDNwa04reVlhUTNQUHUyRTExZnBzNENCSGJ4bm5TcE1weVJU?=
 =?utf-8?B?NVc0T1VKWjIweDRuZ0NPSFc3V0FrTmdFU0EweS82dnJjWjhXdFZWRmEzSm5M?=
 =?utf-8?B?SjhiZ015QkhSdHhZRUxza0gyUWlUcEcxSjMyUHlTZ3JuNnExemV0R1RnYUJw?=
 =?utf-8?B?N0JLUGxQWk9jY1VsZjhibUVDbUN2bkE4SzVma0JPSDRvUkdpd2tmWldxdmhk?=
 =?utf-8?B?dUR1SGJLd3dsR0g4S25CbFlsWEZzTzlibFBqK0JWZUZBRlNYUlhNbXA5ZFl3?=
 =?utf-8?B?bUNjUzhLYm9Bb0piTERpdGNUQ2E4WktNKytuNmdGQWFnTU42Y0tMYWY2Y2wy?=
 =?utf-8?B?SUs3OTc4cHBZeXh6T1I4a05LdDJYN2JGeVorTEtYZ3llUlFrczIrWjI1YlYx?=
 =?utf-8?B?cmZBeFhkcUhRbWwvL1Q1blZRbnlQNEovNUhMOUtCVWZvTW1oTWtrRzVoVVBm?=
 =?utf-8?B?dCtMM3FOUVVLdG5OUTUrSnRRNVUvUVJsckV3RERiTjRPNjJmWjh1WTJkZVMw?=
 =?utf-8?B?d0RXT3pXa3E3WlQ1eTY3ZWhhSXI5Vm1yNTJYaHRDRmZ5QWg1eXRGSXRHQWQy?=
 =?utf-8?B?SjVrUUFzT0REanhycEtFa1Q1ZW83WkZLejJVWDhwV1dZT2Z6Y3VJWnF3akVZ?=
 =?utf-8?B?MlNabnowUzdNdDNYRlpaZ0Y2aDZYdlZTZzI3TVVWemlJYVR5cjBSYXI3bitL?=
 =?utf-8?B?VlJ4cXpSMytqQjVoYzNiT0N2c1ZGUTR3WERYUTlGY1VwWEpBcHFUeWwzcnVp?=
 =?utf-8?B?S0lUWk40SGlxa3d3VGpia0VacjNrSmFZZXFZSDVOUmEwcnkyeXZvNXBFWGxH?=
 =?utf-8?B?am82MS9JekJWd3JZdVJaSkd6RFQrYUZWRzV0dnZ1dVRIT2lSVExFeUUvL0h6?=
 =?utf-8?B?MUxuK2VoeFdoNy83eVBRYnFpNERrMks4a0JxVTZDQXY3MWM4ejZWV0R3Unc3?=
 =?utf-8?B?MDdvK2x2bHVsTHRaSG9FZ1ErcnBuUnBOb3YyaCs0dStSZEFuYm9vcFNpUGxM?=
 =?utf-8?B?bG5qcXphODAwR25HZmtwNFAwOWowdC93SGswQ2swT2lqd3kyZU1zMzcrUzFh?=
 =?utf-8?B?S1FpZ1ZZU1hGYXhPVXY2bnByb2dYVFk3ZDh1NUdoR25wMTMyKzV3Nms1OVJP?=
 =?utf-8?B?MHIvT1V1YzMyd0ZTTGNibjdtZjNGellTUUdMbzNsM1hYUWUyWFR0THorUFNO?=
 =?utf-8?B?YUpWMGJ5RU03VXROa3lyc1NZVXpBcDJFaWVrVFhyUTc1YU1yYmpGZU4rY0J3?=
 =?utf-8?B?UzVxRk9rUWZVWGdaY0J1TjQxNDBNQnhLdStoT3BnZkM5a1o1TTdHWUFoSGJ1?=
 =?utf-8?B?WTZqdFVRVU5jUlVVYkZVVFB0dVF6TTlBdFRHNC9qL1diaWhBaCs5MkIxUUtE?=
 =?utf-8?B?bk5LVFhsNldvNWE4NzBUdnNpa2ExbjRET1dFVUV5RWZybTdOUU80NkNzZjRq?=
 =?utf-8?B?UFQyK0dNb2Y1WmlJTUd6QWtqVFdtTk5zQ1YwYTFZK2dBbU9LYVhqZUxhYUdQ?=
 =?utf-8?B?bDNJS3c2djczdnJjWHJvMi9YK0ovdWtud3pJSy9GZ3lBSlBFcjhlbDBtVWk4?=
 =?utf-8?B?aHhzYlZXcWl4WWQzMy9jV295VWE5Yld4R09BYlBlL3pjbGFjazlOVG8yYXQ5?=
 =?utf-8?Q?0RpXkcclzG/kKfBd+AgXW/6vwZYdtMpH4vGhFIp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckFmVkh3TlVsaGFRc1NOZTVvZjF6ZTFMMG5MeVJ2bHdlSG5ISVJRUEY3QzJL?=
 =?utf-8?B?RTRDNUg1US9uTkswSFJ0UjdycGpYSkNHMmVYZUR6bE9nYk9GbzVZMExLVjlZ?=
 =?utf-8?B?Z2ZkMnR2T0Vyc2JYdUtUTVgra1dTaElrcVMrbnhvaHpzTnFpd1JlRUhzb2pS?=
 =?utf-8?B?eWo1b1N5RXJrOXY0WTh6dlBVaFJBL3pGTnRjNFZMY00yMnpPdlRZS3FRTjNi?=
 =?utf-8?B?aUxMV200anRlVzJOQzI5cEd0UkFQanQ3M09PVWlRYlc4ZStHQVJoZVVDK0c2?=
 =?utf-8?B?UTdSQTFiQisvOTRPZytCNTMrOW4wbEN2bWNuR1JwMEVPOGtQU1Y1QW9sTDF0?=
 =?utf-8?B?L3E3d2VzT1h3QWZVdCtBZVc2MXh4M1RHVVFVQU5pZU9Fb29aSWZBVlNEOVlY?=
 =?utf-8?B?blRVV2ZLSm44YmxaR1pZUHJPNS96T2Q0cGpLTEhWUkVoQ2o2Q1FSUUNRelVK?=
 =?utf-8?B?VjNqV0hrQnpGTWQ5UlhsSFFlZ0ZnS0duQ2FHWi9XWFlFVjJJakRGN2wwRlRU?=
 =?utf-8?B?VHdKRHNCUzFQVEtjS2J2aGlwY0JJeVE1K04vWFZwMEE0SzRibzdHUGFTNS9K?=
 =?utf-8?B?UklTR2VJTmxxWGhPbFM5a0FpaTc2WDNiNm03dnpLUURWSjVOMGFxd1BVam5Y?=
 =?utf-8?B?NDU4RXBtb3RRc2lQdlpQUFBvcWJBTzZ2Wm1UckM4cmJlZGd6bFRuMlBkenVz?=
 =?utf-8?B?WnBMVlhNU1FKQ1lCVlJzeGt6d2F0Z2xFdW5XZFgzaUpZWFpoNVFGaDRTbyt4?=
 =?utf-8?B?NHJxcWF6UFZKOGhmTm5mNkhRRllCbDdwY2UxQ3hVbVVrWVBrb0paSGFpWFlG?=
 =?utf-8?B?Q1I1Y1Q2SUNBcUdhVHlPYmFmRWZzdUFBeUx2WTdFVmtTWUY4NWtucHdGQktv?=
 =?utf-8?B?WDEycEczT0ttVWY0dDhWVVc5Y0h3YXg0cjRZM0xZNDhBUnkzSFV5OGJ6cTQ2?=
 =?utf-8?B?dGhmTXpMSFZVUzh5QWJWNnBWNHovQi9FRDhNaFQ5dU9HV0JENjdQaTcrL2d5?=
 =?utf-8?B?N1QyVHIxR0l2YjBiSHk1UDBSRllKNVhnblFoNFlrZEg0dHAvVXo0TWEyMWxo?=
 =?utf-8?B?cVc5ZU9aYk9veWZoc0hqaFBCSmlpSmhZVlgwaDVEZFdBTVk4Y016T1hyVnNu?=
 =?utf-8?B?b3F0Ymxpajk5T2loSXdFTFBRTWpQVy91a2JKYUxQcENTUmk2YXpzdE1GTWFl?=
 =?utf-8?B?WHVIL1VTRUh2YlU5S0crNTU2OUh2ZjVWQk5MUE1PQ3lVb1hWWHNkMHNPTi9B?=
 =?utf-8?B?MTJrZVh5cXdOcDNQak9rZXpBWkFqV3BqQUp3ZWxzR0N1WTVrY2hkT0tPZFNr?=
 =?utf-8?B?bkgrMnZLUjhlZTV4eDNKTnBwUzJEZ2Z0Y2JKWk9aY0FCLy9FTXllYjNrby90?=
 =?utf-8?B?Q0g5bC9NSlFpZFBydmtGVFowVDZId3lLUUQ4VzMvcnpsNnYvRFgzdmlrc3Zt?=
 =?utf-8?B?U0NBcUxKRVdSdG5ic0NMU0FNNWUxbmJyZ0ZPU0FYUmp4NFB1Y3ErcDNIMjNv?=
 =?utf-8?B?aGxsbkpGb2E5OTJzS1lQS2k1eEJXclEyeWJqT0N6OTR5T1hubjRuUU1PYXNH?=
 =?utf-8?B?OStwK3d5d1ZheHgwcmtzLzNvTjNRNjFrTVJnMldRb01uMkNlZ1hKL0dNK3F6?=
 =?utf-8?B?VjlUdC96djR4RWhNNzZUeTVTeEpLUlYvVysyK3lReDNtOVdidStlYkNSOHU1?=
 =?utf-8?B?Z3NKczFNOFFCeCsrZnErRERjQ1F1eG1TaTFDeFRKVWw3VGdGU2VkSS8xMjM2?=
 =?utf-8?B?Q04yQWZZbFA1QnNWaFozbUQvSnRSZWEvM3VvSWZXN0tHRWFmVXFieWduWGU4?=
 =?utf-8?B?MHBWbGpSbDB0SEpmRlorQWtRTEJ6TGJya09wSGdMRFkyREg0aFNIaE02RjdI?=
 =?utf-8?B?SDE1cnZzQ0dkWTBQbno5QTM1RHI5Ty9wMHVhT2VxeERYZUtFYXhZRklZeTN5?=
 =?utf-8?B?US9uY1MvK1RkUzNqTGpzMFNBS2M3MDFXUXJGbWs5MVNCdmM3YVZOSHV2ZUxC?=
 =?utf-8?B?d2tYOVZzTXNrdlBVZFN2WktUTHAwSWV5VTk3eUwyQmFrb2Z6aTJDd25kaTBV?=
 =?utf-8?B?NjRQa3ZaQ2lZUjU2SmhsQzdBd3lVT2c4UGc1RUtOdEpsbGVYb1VYamZ0ZDF1?=
 =?utf-8?B?UkxiT3JYNUw2dXJyM0tjOGtod09mOGtpb1pUbi96dERXd2ZtSHVVN0k5dnRh?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: afc297db-69bc-4e9c-f6ef-08dcf1ad41c9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 08:49:21.6462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4MUlefrGMlOg3Q0no0QushXoyjQCsT8AfUJ+cc5xaKNHobCJ4aEZvHDcKQ9GW5qW60qg3hNgoEwQ3Twx75wGxkFEJkx4tqwIDeqju+XVQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8970
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Oct 2024 08:49:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/722

Hi Dixit,

On 10/20/24 11:01 AM, Dixit Parmar via lists.yoctoproject.org wrote:
> [You don't often get email from dixitparmar19=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

