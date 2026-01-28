Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C048CD3569F
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 10:35:31 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10232.1769596524054039750
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Jan 2026 02:35:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=T/saEhX9;
 spf=pass (domain: cherry.de, ip: 52.101.72.23, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBYP85FheS5fdVAhgoaLK0Ceyhm2MO3RGXKWxfDX14P4walfMkFadR9LfD3KdBgKcc+tQaMgIG1ll9o1BOdmiTsmF2KQ4+IpkFQd1N9DtHKQRcmS4yuXIN4ht7v2Zo6fxNahShZO7chSK9kRg9ErjGsyTYCoWF9+wujpYm24WX57GKdlqVk0aNxkghX3oXqpvkw205HeDzFH1ZbhsK6ObBllr3UnE6Xd631XYGcWkDVyDpOKIYn/eut/kjy+CJJ8O7S/0Vkpn396aCboor+7IQ4knIwqJs7i1829FE7VwsmFt7jyEKhAQtqSWqBqzW+SiTrv4a6RXXfwRQEQxTpiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKa37tg9XWAugdsUQUzRlWK8zQ6X9YLg9+MO5SAMeFI=;
 b=NePQxXhQeJ5GguyAFHLYz9LY1vJ6DIrkAV6MfAfoa6zs4Wei/Xa7F4Jl/8mmGNRkjKa4jIZgrNmTNVwfgKCnTxgExd32UvNM1OYW7i4vx0Yl22HOsQqe9m14h0JVuBeHx9b6dLblIFwo5vziqtswEcTNXOhxZwD1ourT5RHyewCXBcCDJjlY9oBiLq/aM1zP11YBHEwV6lJCexD1hKBz6P1LCHaAh1OpXGbxAKb2+7UoOqPcgKL3O1hBHgftnicGU0woKwks4g/YZth0HfKnS/hVheVBQYRMcKRI1SZZWNv3jWfo9LEThE7PCo+eiBaujCsjTz2A4ovKLMS3DOhIZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKa37tg9XWAugdsUQUzRlWK8zQ6X9YLg9+MO5SAMeFI=;
 b=T/saEhX9tetDfl+Zqh1+NpQWqqJgs4HT1Minmh6TtGb73TvaCTpo3pBE404nltSXn0LW1Y1+G+tpA2sKwjM2Uag5vR0mu7D9bLExbYd50oVoZS0d8mxrFtpe3/y29Ev5I/0auySxTj7pL/7UDzbO9PYqnzo3sWIjgm8aSPP/RRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Wed, 28 Jan
 2026 10:35:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 10:35:19 +0000
Message-ID: <2bf93914-dd8a-4e3c-9c97-74acb1c975ab@cherry.de>
Date: Wed, 28 Jan 2026 11:35:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] luckfox-lyra-plus: add
To: yocto-patches@lists.yoctoproject.org
Cc: mbober1@gmail.com
References: <20260127205141.26089-1-mbober1@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260127205141.26089-1-mbober1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5da490-134a-48a3-58db-08de5e58ef04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEFGR3dUUlhHK0R0NjVlamo2eW9xK0xrZjBmWSsySS81dkxCNXRUYkZ6T0Za?=
 =?utf-8?B?Q2lvSGFqMmxOQ0pYaTFoeTY3WUdVb1cwZnBtejFFNVJobVBnYk1yTmZyRkRM?=
 =?utf-8?B?dkdGdFdhM1dNa29QNEZONTk5c1p6eDN4dy93WXNPT2RPRmN4d1MyZ01uUmxS?=
 =?utf-8?B?aWxGaE9PVkNFKzFIN01DdFhZbHppNC9pMUlXQ2xweGQyTmt1MGNNaXFRa0Fo?=
 =?utf-8?B?Q00wQlRTQ1VmUldnVTRJeTZnMnE5RzhSWW13RUdKc2xvdk5oRzdNNWpJTmhQ?=
 =?utf-8?B?ZHVXN0lsazROczlBMC92UURRVWd0R1l6M0FBZWFGS1ZjM2lhVFkvdUFTdXFj?=
 =?utf-8?B?LzR0U3A5TVlLUzRsYnh5R2lTOHdYOTdsc1NKM29nTVRuSnFOaWFva05FWERp?=
 =?utf-8?B?ZitXTWFCN1RKNWdCdnltVDlla0pabTFVc0d3TmJ0VU04TGdldGxVd2tjNDB2?=
 =?utf-8?B?ZE42MlZxSVFoZ0FyZUVFY3FYNERtZkUxZTYrbnlMV2xqLytCRk5lTnNJU1l5?=
 =?utf-8?B?YkJUUEtxVFgwbEl2bnJuNGdaSzhua1ovUFk4bzNRcjRBa3gwcEZrVVFFaW4z?=
 =?utf-8?B?OGZZZVVPQzlrM2MzSXYyMzIwV3JveEd3aUxxRTNUY2Ywbm5FQTUrU3ZSWkds?=
 =?utf-8?B?SUo5SktYT0RhOFEwbjdDUWRDcGlJc01YK1hrQy9HeExCZGhQZlc3SjYyZWxJ?=
 =?utf-8?B?VGE1R0hWanNDNVRlNjVLQm03NzZ0SjJSMWU5UTA4YnoySmNXN1o4L1lyajV2?=
 =?utf-8?B?NmRlN1NLaHNCRFVoc1FWbXZlVng2VW1ibTdIUHRZcXVDOGQ1aEN2QkdmLzBQ?=
 =?utf-8?B?RFBrcU9sTFpqZmF3MG1GZlJuSFRqUmNZNytic1h2bzlveXNDM00zME92dW1x?=
 =?utf-8?B?MTcraUVGdkNlbWxZdXlKRmJnQVRURjN3d0lRczdEOFpDSis3WTd6ajF1dTFr?=
 =?utf-8?B?YWlhb1ErRG9yMlEwSVhSTG1KMitrSkcxVG1OdUJxc0VudndOdWFOelhFWmZk?=
 =?utf-8?B?RHFEZDliL0NOK29JNmpKcVFFTVQ0WkYwWnlSTi9qZ0dvVUJhVHFnOWMyWFRJ?=
 =?utf-8?B?SUtqRHpVSVlLS2FwV0syTDd3cTQ5WmxUQmxIZ2RneG5UY0xPVklJUTF4M0gr?=
 =?utf-8?B?UDBrRDRuQ1JYOTE4MjZPM0plejVUY2VaYnU2NW1hbTZhRTRtT05idVVjdm0x?=
 =?utf-8?B?SU14am5JVVFNTSt4d2pQeFZ5K0hQYUZsNkpOUHhKMkl0bDhadWVONFUwcE5I?=
 =?utf-8?B?TVdITkk1ZitGdC81UjMwR1g0ajJIWUhvR0JHbUVsTUQwUTljcW5HYzNnc3Qz?=
 =?utf-8?B?R0g4S2ZXTkF5eTFxM2J6dlkyemxJQ3BMUDNQcFFsYXR0d3JoanVpQVFLNjNn?=
 =?utf-8?B?MWdEN2czbjF0VEhFRXQ1aDFmZ3pqVnI4V2lWR3RIdFEwMThDU3AwMzlxNXY4?=
 =?utf-8?B?V05ZcWl0WFRGaUlycWZsTDZ6SVZJUTJrbFZPN0RYY1RzdDg2dXZkdHZERnBS?=
 =?utf-8?B?WE9EckZiczc1YStKcE9GZ0c5NjhnZEFNdTlaWmEyODB6WUkxb2FmRDZDaU4r?=
 =?utf-8?B?Ym5zbjNwajNXdHBTRnBtVGdZQlJKaTUxanlreHpDSSsrdWpZNkJYbE53VUtt?=
 =?utf-8?B?ZU9SYUc4emh3dFcxbDYybzdHL2MvaHNObXBZY0ZEbTJVOGRFbHB6RWlMWFRR?=
 =?utf-8?B?WFRMZnRJZEc4cGd3VG43ZXpTamJWbStQSEUwazZsRllScENNS2VTQk9yNzQv?=
 =?utf-8?B?SXlaVnh5WW5EenU2SmFsVElBaVlJTTdyZktKOU4vUlN5ZGV0WmxmallFYTRN?=
 =?utf-8?B?N1hNV2VBMzZURG9DRU04RjYrSXVLTjZGdk9QajFvMGl4U2dMOWpmNzNMczZa?=
 =?utf-8?B?c0t1OXB5c3BESVh0YWNmNWxnTEI2di9hYmhDUkxMcEE0bzBkZjJTdkhNWkZV?=
 =?utf-8?B?MGprckFYbFhSeDZ4bVRqeENKK3BrNGppRHpTL2JPQ0FPMVI0cHV0T2NQeVdF?=
 =?utf-8?B?RFF6RnpjaFpITmc2UithaXhBU0hzSmFVZmpMSk5FWmptb05TaWMvYWJ1RFls?=
 =?utf-8?Q?CTYoNQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2NhaFQwNXU3NHN5ODJscHNXbHNMcEVOQmxENVg4S3cwMU0vM2dYNHhPeFR4?=
 =?utf-8?B?dnJ1cHFxNTNqSnBVRk9rdkhkN3lSREl0K2NHNjcvUzlodUYxWW5CTU9hN1k4?=
 =?utf-8?B?Z0xxeHNIWWFOcGZ0ekh5TmR3VjhWTmhYWEVGREZhbHY4aGNvb3hWQjVJMXZm?=
 =?utf-8?B?ZnNGeU9VYmd5LzBmSHBFMVJPdVJ6TDlXdGlDSzROZmNTcVVYTnZOdjU0UDZY?=
 =?utf-8?B?Z2RlQk43WnBsV1JWK0hvT3Q5bGNlYXJIeVptSHRmNnJTbXdGVldpc2Y1elVm?=
 =?utf-8?B?QUJHdzhVZzlDc09vbW9POTJMdkhOeWsybFI5djV4QnBhaUp1Tm1RREpDZUhD?=
 =?utf-8?B?YkxiWkU3TVVmOE1kQTRxODJlKzNQVG1WU3YxQStNaTl5QitldGpNWHl6RE4v?=
 =?utf-8?B?OCt0QzcyL0pKZGVvOWpkMUNXQ0FhaER2WW1QeU9qdnZQbmdqT0dsLzIyZHdx?=
 =?utf-8?B?ajhFWi9WdituQW5RcGFZaEdIaEF1OStjbjl4ajBXMWRWcnQveVVoS2hhdTZy?=
 =?utf-8?B?SW53aEtSMVAydnNBZDBpc04yLzdJelA1MzdrQXVoY3JGQjBpNi9rSjBqMUpj?=
 =?utf-8?B?cnRTTkh3OG9hS29WUzhYdE5zNkgzcnBMK2VXRW9iM0NOMXAvM0FJTnhvTW81?=
 =?utf-8?B?c2RxZkh5MVNOSkVwRXUvZS9scW02d1pLeldmdTdLNnd6OTZlQlJvYU9USytE?=
 =?utf-8?B?RGw4UStGc1YrQUIvbVZpYjNVZWg2Nm9ETm5vQVBPVjU5a2trMEZ2ZCtBNmZJ?=
 =?utf-8?B?ZkdBSXF2VEJpcVVFYnZEWUZiT0V4LzRhVnZZTjUrSEtkWTdlUURqeUtzbUdW?=
 =?utf-8?B?WThkWXpMckJlVEJNZUhZbk1EVXZsYWxCcDBlTHRzdFVWejFmUXRGQXB1QmRY?=
 =?utf-8?B?bThNVlJLMVZQaVdhb2NTR3N4TDFPL24xTnp4N1NaWGViTGN3UFlSSytHeXBG?=
 =?utf-8?B?aEV6akpmamRxeVpETFgxSXhaZzUyWlloeUpPQ2oydWRtb3M2TEwwWEljbWxE?=
 =?utf-8?B?emlhZHM5MEJBSi82VjYxQjRYOGNwTENDMFBLTkxUWnhzZTVOQXFTWjBpdFkr?=
 =?utf-8?B?SWdka0ZCdDh5Tk5aNFp3UVRyalF0RXozY2pYOUxuZnE0QzczbXdDY1czVHJm?=
 =?utf-8?B?bCtMempNYTBYUysyaXlyZTF6RlgzNUQxc1k1Q05pbnJSS0g5VTB2eWhxMlFa?=
 =?utf-8?B?Y0ZCMnA2Ry9nYjMyaWtEWVJCU3M2M1VYMWJCVUJMdytqVzN4U3lDRHo0UUlE?=
 =?utf-8?B?eElPRmhxcTVEdHo3QWR4VUtEakJWcENTc2RSSzkxOXFqUlF6SzJjODNLZUxL?=
 =?utf-8?B?cUtrVEdNQStVNElpTlIxeERsclgwMkJQeTFpQVlPcy9CN0c1RG5ETThnSnJI?=
 =?utf-8?B?RXB4Z3ZOaHc2S3lya3E5djM4TVYvOWFTTkFXbXVmWER1dnR2K0hWVXVkREpH?=
 =?utf-8?B?SHQ1SnRzUVJONVZxRVZZYlkzRTN3MWhNT0MrN3dUK0hySmgyTWVWT1FyTi9z?=
 =?utf-8?B?TmJaeFhLNnN4NTZpdjA2bU9FYXQvVTNGTzJTQ0lqYXRZV1R0M1JkTVNWV1Y0?=
 =?utf-8?B?c0svU1FrYlhRODBOQTR5N0NrdDFNOVNMTUVBcTNUMnlQTTkxWEpPVERlS0hj?=
 =?utf-8?B?bWlZKzFreWNUNzk4ejZwNGRMMW51MzMzeFczeEVvRHlPNUI0TjEzVnF1K0tD?=
 =?utf-8?B?WVEycFdPZDYzOTZWM0VsQjdiU2pJa3laTFBWc0dHVFlnL1p0RzlBM2R4OEN0?=
 =?utf-8?B?Z09ROGNQY1BtdGxYZkRjbHR1RFBDbk1kTFN3Unp1M1FUV3FrMUN2c294cVRx?=
 =?utf-8?B?Rm5xYnloYjdMZWM3VVNIOVNIT1NWMEhGYmYwdkxvdGlmRVByZWdJSjNsS28r?=
 =?utf-8?B?bkUvaFFqNHZiZkpHTHpLRUpKZXRjVnRGdUVMaW5WbDZlb0NNOEdMZzQ0Ty9m?=
 =?utf-8?B?TXVSNm9HRHpKdW4xOEJOeWZoeVl2cS9SQnVOajBERGdqUDdPZ3hRYXhFUy9l?=
 =?utf-8?B?d1E1ZXdTQXZvd3Zvd0hmdXQyN1R4ZU5MdjM4bU94RjNSQjl0N09CMzhleWRs?=
 =?utf-8?B?QXZqclFvbXh5bTlJV1lHNU03U3pGV1VtVWdSTjBlMzVGWGZqaUFuMnM4TW5w?=
 =?utf-8?B?a1crek9UYklPTm5tZHcrZU0vRWlDWUFpc0JiaWFvYXV6VHZHNDJIN3FycURV?=
 =?utf-8?B?c1lCRjU3dmdCSWJMVm1YMFJUTTMwUi94R3Z6MndMcGhBKzhUdm9jdk1CZjcr?=
 =?utf-8?B?OFoxYkpxSTAxSGhBVHQ2L3FOVDJGQkw2bWVZaFllWkZRNkp5VzBRWVl3eGF6?=
 =?utf-8?B?dnhwQXlIcFRCdmk3dFYvbDB1TDcvOG1udW1OR2hiNGpDZTMzcmlYM05pRldC?=
 =?utf-8?Q?H/RdGO140NNH6fx8zcxf6nhF10xUGMl9DSwXE?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5da490-134a-48a3-58db-08de5e58ef04
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:35:19.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcDzSuXYLLWbSZENvNyHbuzGm1dr4Zr06mPcdXHC4yus5oHRmBMvfk4Ntz4EyO/Eyobvl4qz9wNCrdnzHOjbSGVSuFPyLd62xySXCtRiSAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Jan 2026 10:35:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3129

Hi Marcin,

On 1/27/26 9:51 PM, Marcin Bober via lists.yoctoproject.org wrote:
> [You don't often get email from mbober1=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The Luckfox Lyra Plus is ultra-small, tri-core single board computer
> based on the Rockchip RK3506G2, with a very compact form factor.
> 
> Signed-off-by: Marcin Bober <mbober1@gmail.com>
> ---
>   README                                        |  1 +
>   conf/machine/include/rk3506.inc               | 20 +++++++++++++
>   conf/machine/include/rk3568.inc               |  1 -
>   conf/machine/include/rk3588s.inc              |  1 -
>   conf/machine/luckfox-lyra-plus.conf           | 27 +++++++++++++++++
>   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  9 ++++++
>   .../rkbin/rockchip-rkbin-optee-os_git.bb      |  5 ++++
>   recipes-bsp/rkbin/rockchip-rkbin.inc          |  1 +
>   recipes-bsp/u-boot/u-boot-rockchip.inc        |  2 ++
>   recipes-bsp/u-boot/u-boot_%.bbappend          |  4 +++
>   recipes-kernel/linux/linux-armbian_git.bb     | 29 +++++++++++++++++++
>   11 files changed, 98 insertions(+), 2 deletions(-)
>   create mode 100644 conf/machine/include/rk3506.inc
>   create mode 100644 conf/machine/luckfox-lyra-plus.conf
>   create mode 100644 recipes-kernel/linux/linux-armbian_git.bb
> 
> diff --git a/README b/README
> index 6bceba0..3991415 100644
> --- a/README
> +++ b/README
> @@ -23,6 +23,7 @@ Status of supported boards:
>                          tinker-board
>                          tinker-board-s
>                          vyasa-rk3288
> +                       luckfox-lyra-plus

Please keep the list ordered alphabetically.

> 
>                  64-bit:
>                          nanopi-m4
> diff --git a/conf/machine/include/rk3506.inc b/conf/machine/include/rk3506.inc
> new file mode 100644
> index 0000000..e204283
> --- /dev/null
> +++ b/conf/machine/include/rk3506.inc
> @@ -0,0 +1,20 @@
> +MACHINEOVERRIDES =. "rk3506:"
> +SOC_FAMILY = "rk3506"
> +DEFAULTTUNE = "cortexa7thf-neon-vfpv4"
> +
> +ROCKCHIP_CLOSED_TPL ?= "1"
> +
> +require conf/machine/include/soc-family.inc
> +require conf/machine/include/rockchip-defaults.inc
> +require conf/machine/include/arm/armv7a/tune-cortexa7.inc
> +require conf/machine/include/rockchip-wic.inc
> +
> +PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> +

Ooooh, I believe this would mean OP-TEE OS blob from Rockchip can be 
used with upstream U-Boot? Have you actually tried? This would be 
interesting for me for 
https://lore.kernel.org/yocto-patches/20260126-optee-os-v1-0-874261a77dad@cherry.de/ 
to check if I got it right for rockchip-rkbin-optee-os as well.

Is OP-TEE OS *required* on rk3506 to be able to boot? Do you know?

Essentially, with the patch series listed above applied, you would need 
to set RK_UBOOT_TEE = "1" and then U-Boot would automatically add the 
necessary dependency and add the correct filepath to the TEE environment 
variable.

> +KBUILD_DEFCONFIG ?= "rk3506_defconfig"

Usually we would rather have multi_v7_defconfig and if needed apply 
.scc+.cfg config fragments (see what's been done for nanopi-r4s).

> +KERNEL_CLASSES = "kernel-fitimage"
> +KERNEL_IMAGETYPE ?= "fitImage"
> +

Isn't a FIT image the default when you include rockchip-defaults? See 
RK_KERNEL_FITIMAGE variable.

> +UBOOT_SUFFIX ?= "itb"
> +UBOOT_ENTRYPOINT ?= "0x02800000"
> +UBOOT_EXTLINUX_FDT = "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"

isn't that already handled with RK_KERNEL_FITIMAGE from within 
conf/machine/include/rockchip-extlinux.inc (you may then want to require 
this file).

> diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
> index bcf9dd8..12f0ba2 100644
> --- a/conf/machine/include/rk3568.inc
> +++ b/conf/machine/include/rk3568.inc
> @@ -10,7 +10,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
>   require conf/machine/include/rockchip-wic.inc
> 
>   KBUILD_DEFCONFIG ?= "defconfig"
> -KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"

This has nothing to do with adding support for this new device no?

>   KERNEL_CLASSES = "kernel-fitimage"
>   KERNEL_IMAGETYPE ?= "fitImage"
> 
> diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> index 6ec344a..d0654c1 100644
> --- a/conf/machine/include/rk3588s.inc
> +++ b/conf/machine/include/rk3588s.inc
> @@ -9,7 +9,6 @@ require conf/machine/include/arm/armv8-2a/tune-cortexa76-cortexa55.inc
>   require conf/machine/include/rockchip-wic.inc
> 
>   KBUILD_DEFCONFIG ?= "defconfig"
> -KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"

This has nothing to do with adding support for this new device no?

>   KERNEL_CLASSES = "kernel-fitimage"
>   KERNEL_IMAGETYPE ?= "fitImage"
> 
> diff --git a/conf/machine/luckfox-lyra-plus.conf b/conf/machine/luckfox-lyra-plus.conf
> new file mode 100644
> index 0000000..529a472
> --- /dev/null
> +++ b/conf/machine/luckfox-lyra-plus.conf
> @@ -0,0 +1,27 @@
> +#@TYPE: Machine
> +#@NAME: Luckfox Lyra Plus
> +#@DESCRIPTION: RK3506G2 based Linux Micro Development Board
> +#https://www.luckfox.com/Luckfox-Lyra-Plus
> +
> +require conf/machine/include/rk3506.inc
> +
> +KERNEL_DEVICETREE ?= "rk3506g-luckfox-lyra-plus-sd.dtb"
> +MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> +PREFERRED_PROVIDER_virtual/kernel = "linux-armbian"

I believe we only take boards which are supported by linux-yocto or 
linux-yocto-dev from the master branch of OE-Core. I don't even see 
patches on the linux-rockchip mailing list

> +EXTERNAL_KERNEL_DEVICETREE = "${DEPLOY_DIR_IMAGE}/devicetree"
> +
> +UBOOT_MACHINE = "luckfox-lyra-rk3506_defconfig"
> +
> +MACHINE_FEATURES = " \
> +  rtc \
> +  screen \
> +  serial \
> +  usbgadget \
> +  usbhost \
> +  vfat \
> +"
> +
> +KERNEL_FEATURES += " \
> +  cfg/fs/ext4.scc \
> +  features/cgroups/cgroups.scc \
> +"

KERNEL_FEATURES must be listed in the kernel recipe not in the machine.

> diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> index 3227a53..7f654ff 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> @@ -10,6 +10,15 @@ do_deploy:rk3308() {
>          install -m 644 ${S}/bin/rk33/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3308.bin
>   }
> 

Wait.... This doesn't exist anymore. Against which branch did you 
develop this patch?

The master branch has a completely different mechanism which is much 
more automatic than what's needed below.

> +DDRBIN_VERS:rk3506 ?= "v1.02"
> +DDRBIN_FILE:rk3506 ?= "rk3506_ddr_750MHz_${DDRBIN_VERS}.bin"
> +
> +do_deploy:rk3506() {
> +       # Prebuilt U-Boot TPL (DDR init)
> +       install -m 644 ${S}/bin/rk35/${DDRBIN_FILE} ${DEPLOYDIR}/ddr-rk3506.bin
> +       install -m 644 ${S}/bin/rk35/rk3506_tee_v1.23.bin ${DEPLOYDIR}/tee-rk3506.bin

This is TEE, not DRAM init blob so shouldn't be deployed in this recipe.

> +}
> +>   DDRBIN_VERS:rk3566 ?= "v1.23"
>   DDRBIN_FILE:rk3566 ?= "rk3566_ddr_1056MHz_${DDRBIN_VERS}.bin"
> 
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> index 6d25368..cbd376c 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> @@ -9,6 +9,11 @@ do_deploy:rk3308() {
>          install -m 644 ${S}/bin/rk33/rk3308_bl32_v*.bin ${DEPLOYDIR}/tee-rk3308.bin
>   }
> 
> +do_deploy:rk3506() {
> +       # Prebuilt OPTEE-OS
> +       install -m 644 ${S}/bin/rk35/rk3506_tee_v*.bin ${DEPLOYDIR}/tee-rk3506.bin
> +}
> +
>   # NOTE: the following are not typos
>   #       the rk3566 uses the same bl32 as the rk3568
>   do_deploy:rk3566() {
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
> index 9264db9..8dfdc09 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin.inc
> +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
> @@ -11,6 +11,7 @@ S = "${WORKDIR}/git"
> 
>   COMPATIBLE_MACHINE = "^$"
>   COMPATIBLE_MACHINE:rk3308 = "rk3308"
> +COMPATIBLE_MACHINE:rk3506 = "rk3506"
>   COMPATIBLE_MACHINE:rk3566 = "rk3566"
>   COMPATIBLE_MACHINE:rk3568 = "rk3568"
>   COMPATIBLE_MACHINE:rk3588s = "rk3588s"
> diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/u-boot-rockchip.inc
> index 2b5bbd7..67c4418 100644
> --- a/recipes-bsp/u-boot/u-boot-rockchip.inc
> +++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
> @@ -11,7 +11,9 @@ do_compile[depends] .= "${TFA_DEPENDS}"
>   ROCKCHIP_TPL:closed-tpl = "${DEPLOY_DIR_IMAGE}/ddr-${SOC_FAMILY}.bin"
>   # SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from rk3588
>   ROCKCHIP_TPL:closed-tpl:rk3588s = "${DEPLOY_DIR_IMAGE}/ddr-rk3588.bin"
> +ROCKCHIP_TEE:closed-tpl:rk3506 = "${DEPLOY_DIR_IMAGE}/tee-rk3506.bin"
>   EXTRA_OEMAKE:append:closed-tpl = " ROCKCHIP_TPL=${ROCKCHIP_TPL}"
> +EXTRA_OEMAKE:append:closed-tpl:rk3506 = " TEE=${ROCKCHIP_TEE}"
> 

I think you only want

ROCKCHIP_TEE:rk3506

and

EXTRA_OEMAKE:append:rk3506

as I believe TEE has nothing to do with whether we're using a DRAM init 
blob?

Also, this isn't working because you forgot to add the dependency on 
optee-os (see do_compile[depends] .= "${TFA_DEPENDS}" for how we have 
the dependency for trsuted-firmware-a on Aarch64).

>   INIT_FIRMWARE_DEPENDS ??= ""
>   INIT_FIRMWARE_DEPENDS:closed-tpl = " rockchip-rkbin-ddr:do_deploy"
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> index 08e1730..fc6a36e 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -8,6 +8,10 @@ DEPENDS:append:rk3308 = " u-boot-tools-native"
>   DEPENDS:append:rock-pi-4 = " gnutls-native"
>   DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
> 
> +BRANCH:luckfox-lyra-plus = "rk3506"
> +SRC_URI:luckfox-lyra-plus = "git://source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=https;branch=${BRANCH}"
> +SRCREV:luckfox-lyra-plus = "c6782a37feee4a8aee08d321c01b4ca0b0562f0b"
> +

That's a BIG no-no.

Have a separate recipe for this.

Knowing Jonas, there are chances this branch will get rebased, so I 
don't think we want this at all.

I see patches on the U-Boot mailing list for RK3506 support in U-Boot, 
see 
https://lore.kernel.org/u-boot/20260109005008.101506-1-jonas@kwiboo.se/ 
and Jonas "promised" a v2. Maybe work with him on getting the v2 sent 
upstream?

>   do_compile:append:rock2-square () {
>          # copy to default search path
>          if [ "${SPL_BINARY}" = "u-boot-spl-dtb.bin" ]; then
> diff --git a/recipes-kernel/linux/linux-armbian_git.bb b/recipes-kernel/linux/linux-armbian_git.bb
> new file mode 100644
> index 0000000..42dad4f
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-armbian_git.bb

I'll let Trevor speak his mind here but I don't think Armbian Linux 
kernel is something we're interested in supporting. Work with upstream 
to get the board supported in upstream Linux and then we can have it here.

Cheers,
Quentin

