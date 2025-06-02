Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD6C5AD49
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 10:25:15 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.4])
 by mx.groups.io with SMTP id smtpd.web11.46504.1748859912701233375
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 02 Jun 2025 03:25:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=DYS4NvCt;
 spf=pass (domain: cherry.de, ip: 52.101.72.4, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=az+5g+yc4A9E0nkJaRnWdX5J7GSgcSJkLWeiggitlaPBSpxEafgDS1si3w1N/isVLf70HY0c1tqz8XHh5zwaNQsWyPBf6OuUgdD+aFH0/y8nnK50o2ws4UZc6WDubngjdLNAO/dAJz8aUxnDv6qsA7UDebrV7Y3Q3FDI3hFbx6dkdRgaY0kCgwp1vFSXlayUhtMinoXO2pyq9D6HT3czjQKpyvqoKa618AMhtyjfJl7nrYzeGKg1AVL2ZU0sCqFUyMrTFK8AEDi7yWmWckLc58jcV5G2b4zQNAvZKfADZXIGHG+371rN5Yan7r65y3jozmqkT8Fi+SRIsR+cyZ7F9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K92O2DRA/bACvuNcMnTELpQVWO+jhnlynZG62FIRtE=;
 b=S35opNjNgB8fldV4lqOtCtYWmrO6bOZzpbV6GPMsFsVpMB43my0chS/ugAsHaeBA3XbK2Eb5uzC1Z3aGXx38kL6/bIZYxxkdjVUzkm0Ai0o5BLfVyprEHM/Rjlgh8FBQqeJjUrq+jIpq3xQtk9TA4BHGeypHdOUoSVmCo+3zZjVzCyoLAZ1YW2hh+DICDJs542br4DezbQRZpHTMc3lNWzvtaOVaYDdkFJlLi9qhq6W52bEcqn7gCfeXHcNhwLV7nHWySw8lLlyCHt2BcIxslxoEk4l+3BucICxp/Mtb7bH9qJdF0NyvHJWfmD4yBoTwkn+5HZpL3KtVGc2DclIUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K92O2DRA/bACvuNcMnTELpQVWO+jhnlynZG62FIRtE=;
 b=DYS4NvCtqbzmG/WUWDs7RqGjrQ8PDrUSTowmKqQxAC1TTFqKsMwxvxx44M1+UKUozywO29nHsvA/UJwiVuBi4EhoM5gsu3g/Y7tfeMHgvAaZl/GRc0oMAe5q9SGY/Wxfvoo/r3MCd4lH+iU5plQV1H7nJGtERmbnYsjsLhohM5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB8PR04MB7067.eurprd04.prod.outlook.com (2603:10a6:10:12a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 10:25:08 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 10:25:08 +0000
Message-ID: <e012c7b8-84fb-4950-88e9-f8cc08d24a08@cherry.de>
Date: Mon, 2 Jun 2025 12:25:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH 3/3] rauc-conf: adjust PACKAGE_ARCH only
 when using the demo
To: yocto-patches@lists.yoctoproject.org
References: <20250530172156.7199-1-twoerner@gmail.com>
 <20250530172156.7199-3-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250530172156.7199-3-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0494.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB8PR04MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 909417bd-c651-4536-0d37-08dda1bfbf64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SCsyNExFQW81TXZSMXRvSWdTejVQL25qaUVrZjE5L2RHdmx5RjZaVk1qWkE3?=
 =?utf-8?B?VXV6ZVFYUWQ4b2hFYmNVLzRiV0t3T01XaVRIRlMvdDIrUEZ0dGUrcXFaNkl0?=
 =?utf-8?B?NWRwQUtZWWY2c0wvYWk4bWpUejIyOGNSSWJVV29qRStPL3VkZE5GQjhjZlln?=
 =?utf-8?B?YWZpdmdGSE8xcWRicXFZRS9MMk04UmRMOWNLSkl4T3A5NThoWnVwMVNZWUQw?=
 =?utf-8?B?cFZvVHFZQktIV255VnAyMnp1cGUyRy9hamVPcFVvakNrSVhETDVWRGV6bFA0?=
 =?utf-8?B?eVlBTTR2OW9IUUdRNUg2cjYrSXlsdTczKy9HKzRzVDhnc0hKZGgvRmMxUU1G?=
 =?utf-8?B?bitOTThackxCUkUwNDhTUGxnWGZNRjMyZHFrY0t0d05mOUE1Tk5zR2gxa3N5?=
 =?utf-8?B?OGw4d0xSeXZXa3VhSDhNUzh1SXBXQTJSeDNJN3VFSGxyR2VyMlhZMW0rejBs?=
 =?utf-8?B?NTQ2TWd2blhyUWVheWs1N0RCSGtFM1B5THNUKzhVQndFK1pBNjhobTdvQUpi?=
 =?utf-8?B?Qno5NjB5TzZtYzV6bm1WcVdjK1JTVzlyTVU2OE5GUFViYUlWSWNEV3ZIRlQ5?=
 =?utf-8?B?SzVKa1VQcTRrbWtteDF6OEJtcHhkZlpLdWNSMWpoM2ZSQlR3NmZTSUhvSlNi?=
 =?utf-8?B?ZmJrdE1EZWhRTHJIVzR1K2VsbEg1VWFFcWVKVzJuUEZOU2hwTFNxWldydXpK?=
 =?utf-8?B?U21wV2lNKzBCWEc3RkZlSXpESEZJelR1UHY2bVpnL3JMMjFubUp0KzhBdlhn?=
 =?utf-8?B?YjUyN1dXWXMxKzVVYWR4TVFrV3hGY3ZLNFplcEZvdGlWMm9iOE9GQytlaWh5?=
 =?utf-8?B?ZGdLNVdFOFREMThiaFBaWStvbnpLemhvYXh0blJLRlY2bFVSaEF2SXdnY09X?=
 =?utf-8?B?c2RERGQvTi84dEpQaWxpbCt2UnBXaThNOTBjNU0rUTM2MnNYS0ZSZTVuMEgw?=
 =?utf-8?B?Y2J6Q3kyelFUVi9QczB4eUtROGJaYnZrL0RxRVhaSVdUYkhPbUNnSGsrSE51?=
 =?utf-8?B?NW0wMFhLaEhoam5rQ0pRbC9ZSFQxazRZWnFoUmFNNVEwai9TRzliMERPazJU?=
 =?utf-8?B?QmR1ODBCSDUvZWRYNXIvak1PY1E0WFI0YmlYdVBLMXFPT3Yydzd3Rk8rM0U0?=
 =?utf-8?B?OHAxaFoxdk0rQ0g0Ym4vTXpadmplSDR3NmFnUngzVXhKckdmYXFMK2RNcGlw?=
 =?utf-8?B?Sklienl1dTB6STdmSUxCYWFwK1JoT2RKMnIrcVBPUUljV2hsR2lneEhlWUJK?=
 =?utf-8?B?NVlkemxWd2p4YWlWZTU4OXdmZ1NEWVhTMkJOY2Vna3pKUm9GYWdOSVUwdUZ3?=
 =?utf-8?B?YnlNMGRhbFRnTUFMSWpHTGZ3RU9lZUJoaDdGdjRwU3gwMzVPMVJIZmFWTjVE?=
 =?utf-8?B?dDFDdjNlT1R0ZXZLTnkyM2JnRFR1TGZZV3JOaXREZ0t5M1NFSEEwNjRWZ04r?=
 =?utf-8?B?MUNveXQzWnhJd0hpK0pxenNraWNBV3BLejNzWThrSE80aldjVUFHRjBFVVls?=
 =?utf-8?B?cVExOGVaZVV3UUtVQU94MSs4elluOHlKVWxucFVnVVRSRXdaTXNMcFJNZ2Rl?=
 =?utf-8?B?R1h5R1o0OU9jRVh3QnNoblZjRks3MHYxNk5lNk9LZy9hNm9JUHJzZy84V3Jx?=
 =?utf-8?B?OE43OFRvVUFmUWdRMG1PZnpxQWY2c1FTVmVtWHFVTzlNdFVkQXFsM3JKK1VD?=
 =?utf-8?B?dXFrK3QwNUVoaEFhZlV1M2lzakRzWlRuTmNTSjhiSlhMdGZveTVPVllqSWta?=
 =?utf-8?B?a2pVOG16bUNaQXR2TWVnc0Y3K2ZoSjRtQXRnay9vdnVMV3o2MS91a1ExNFRn?=
 =?utf-8?B?alUzM3Ruc0FNZkk0L3pGSXRZRG5vN0l3c2hJNTBMZ3RmVlFtNmFvUUg5YmVP?=
 =?utf-8?B?Y05OVnpScmpkTWhXekN6L0hqcEZRNU90MGVkM1M5MldLbXNJN0xZUUJIMVFC?=
 =?utf-8?Q?Dn3Okry7eEs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDFWekUxRTVlN1V4aG8rL1FSMHdsbmJrZmFnOSs1akhzcGhldVdkbnhObklK?=
 =?utf-8?B?WDIzeDJIRVUzdGd5anpOWVFjb2NSNUREbFc4RTJzRzNHSkhDcko1WjZlbGtI?=
 =?utf-8?B?cG1hM1F5RUtBaEl1RnVwUGVzZ2MycHlKZ0dQRnFUK25FRm1KTStBOE9zbkxo?=
 =?utf-8?B?SVBaei9iMnlWM0RWcFh0ZVJZVFgvRGFhWUpWd1ZGc2t0Z2ZpeVgrSkczV2xF?=
 =?utf-8?B?ZVpPMjR4ZStVREZ3MFNYOCtUcERVNkpIRk1mbnV5czhsMjZmdnNLb0l4eFNV?=
 =?utf-8?B?eU5PUlRsYWF5cEhaN1ZDMUdhVTkzODg0eHB5WFkxeFlnMERDL0s1d0pQOXI5?=
 =?utf-8?B?a09LZmpRSDkzTGJSQ0J1NE4ray92aVhuK0JQSmNvbmduTW8rOGRVU3VwbGVV?=
 =?utf-8?B?QmxuZHlSMmcvQ08zc3pJbUZaNlI4S1RUeFNLZ0Npa2VtZDQvMXhSWlB3RGkz?=
 =?utf-8?B?cFZQUy94SjVmT1I4L25xZ1M1Z2NoV3VUYWt0c1NlSXJCWThFTkZxMnhRc2d4?=
 =?utf-8?B?aXVGVkx5T1U0ZUkxUXhsK0thY25TRlk5cVhzYWZlWWhVMThDQkFMaDlsanZt?=
 =?utf-8?B?V1JhNzZ3dU4xcERtZEs1ajN3Z3J3Mk0wbWUvU3p1Z0kxTGc5SnQxaFEwWDU1?=
 =?utf-8?B?bHZzbmtrZmg1cHJiSlNtaHo5M2R1ZjFVUnFRL2YwbUo2WFMybVRYZEEwc1JF?=
 =?utf-8?B?MktYU3htVkZSVVZxME03SU94SzBTRUUySGlCY0cvL3Z5U3hhZWNEYmVic0JY?=
 =?utf-8?B?VGRpbXRiOXZqNDZQWDZUS2ZnMTFQZG94OEZjd3B4SlJYYjZGSmlyYitKdXF1?=
 =?utf-8?B?bGF3VWpmTkNIQS9LQjFBYnNqL1NObmxmaXE3a3dhOUtNWVhzMlRFSmhPYU1a?=
 =?utf-8?B?VHpJc05GaTJ0MEtWY2dYOTN4MlVYWXc5TlF0S2tIOWFuUGhqbWltSGVNK0di?=
 =?utf-8?B?UkVEOTN1cHZja1VLN3BzNUtwRlVCZWFHUTF3d21QUlAxRVhzSVJNUDFvVHRD?=
 =?utf-8?B?eFB5QmxPVU5rRFByRFhNODc3bW9sQ1FSYUNWWW5tUUh2WHRIM2JiaEVGUlA1?=
 =?utf-8?B?RFArTWZTeEs4bnlNNnJSUWwvTDFQUzJQVHJ1Qk9tNWRqUXFpVWtNdTByWHFS?=
 =?utf-8?B?SUNMK2pNNG90ajVpbHRvN0pORHpRU1hCa00xc29VelBDLzNQYzFxdzUyZEYw?=
 =?utf-8?B?c3h3dzBxRmw4Y1ZSQW1HVjB0TGNvRnRkcVltbzlTdGoyb2lKR2lHZUxEWG1t?=
 =?utf-8?B?aWJjTkZDeWw5cmNnd2pUaDVDQWdVaGE4Sm90Wm5pdWhQN0x5dkZ1NzRQMGFX?=
 =?utf-8?B?cXNGVXg0bUR4UFNVMmZWdEdzejRuUitSYUFkSzNJREJGTUF6WUl4Y3FSblhG?=
 =?utf-8?B?ekZMbE9HdlNRRjQwWU9ncDdnQnJCcmUzbDEvemNzZVBQOVhyN215TC9lUTFF?=
 =?utf-8?B?VDZ6NTJ0ZVNVeHhtek1LMGdpZUFaQ01TeFZqR21sN2dsYWJSQ0MrdEJ2UmpI?=
 =?utf-8?B?UnJsNXNIVXprRlNzVUszRWhmc1BPVk8rcWhEUzBuT1JDckRiTUZHSDgwNjha?=
 =?utf-8?B?bDBoTGp1WWxjd2pnY3RVN0RQeksvTVEzdU9kM2xrM3hCTjQzQlBsKzV2ZGZN?=
 =?utf-8?B?VnhqT0lSdmR3SlN0dTlveUg3MExONmlwdGV1bkVBUTF2TGZIb1VtMnJHR285?=
 =?utf-8?B?NjBCNElvT1Y5Q2haQVVTcVFUSkRXK2VLR0M0RllrZllHZlFJYURodXB6TjVN?=
 =?utf-8?B?N0JhQlZYNkxkZHVHN3lpUlIxUjIvS3hzbGR6dE5KQjFNWTBBRUZ1Y2kvK2Jw?=
 =?utf-8?B?NC93cElnZkpXenFDd2FIanBLV0M4c3ErTjRwOCs3WjYzUkY2STNPTEN0MG9X?=
 =?utf-8?B?TklkRnd6bEJSUHQ1U01kTnB2a3NVVy96UEhYYjdNWEd3aW5vQm9rOGJTWHZW?=
 =?utf-8?B?K3ZHZkZFdDFyWUs0cHg5YVFkdlJnc1BodHBLamFXYm1CQkl5NFltelZ4N1hr?=
 =?utf-8?B?dm5yNmY5Y1pRdS9hM0R1dkJIUG9mNjRCamh2ditLalhOL2xNdmxQZElRN1A0?=
 =?utf-8?B?RkxlN2xIY21OVXg3NmVEMXpPODRGU2NYN0FWSWZUYXBzVXlYYW1KZXB0WkVi?=
 =?utf-8?B?WDBqU0ExUmY2K21iVVFZRzVHR2tCczh3YlBxcEU3Mk1iNnViMXlSaUZadHZx?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 909417bd-c651-4536-0d37-08dda1bfbf64
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:25:07.9842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BwK9V4ZaN/hU6Xf1MQJoz5TvJNbla47OE8+RPojeZudqLNXvYnvkerx8hpZzEgTfnWLpj4e1Onqp9U5y+KgkyqpEYYQUNn1bjBS453DE6JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7067
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 02 Jun 2025 10:25:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1606

Hi Trevor,

On 5/30/25 7:21 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Make setting the PACKAGE_ARCH occur only when the user has enabled the
> rk-rauc-demo feature.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I assume we want that for walnascar as well? (i saw the patch for 
scarthgap already :) )

Thanks!
Quentin

