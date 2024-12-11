Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E4CE7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 09:25:33 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.56])
 by mx.groups.io with SMTP id smtpd.web10.6678.1733909130404919426
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Dec 2024 01:25:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=WoP0EZ3/;
 spf=pass (domain: cherry.de, ip: 40.107.22.56, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gkq1WjsO/Ht8x8OvEVeoQk6gi+i9LbOOw1Ngy5AmqGk4A3ayMpY/4o1BbNzCdDVxBkiKoxbO/jaw7XTcIvNJGDf2QN+f4/LZWrndzlM2ZoXzbJj/nfmX42uZTFeSf3QUVgVAkUjct3WhPlQVTG3TrZdP1Nk7JisAZ9Iku7N+/Ih5ieLFcQ2sbZiMfn/VD+A2YN5Dluw08Yh7rt3eXzVVKaQuVoTxoomna7kdHV4Ge40NfQ+XLykbkyNa/3ytralUMtqpA/MGLYzq+5GDMb6waRl9zmA3X+a7zCIfp8FfFP1AdeLCXrdhicPUAReDc05pdCJhL/B+1rpPuSVoo+y1nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHzcwtKLH8cgXZoxb6L7OfnocDDNrUolHZgaRPmkC6Y=;
 b=llr6QcnC6+Fdyu93/VzGPymv932fO11USfAToHfR7L+eezTiKYxmQif1TRt9kGmgO7IvUYm+wlnuY24qVWlVDsROj5LkIG8ANTZDzDw2bqOsyYYrRuyJx/0uKlEZjHLq6foyhffzW199gR4rSP0BZmvPFJsTy8YOiHCNfzXnOFV0rt8DBxpHFA2jwKutUsrMRZi7rz4qTMH6HmFhHXWJJarFtEJVkmzwDZlj+pOoFLQTAo2Vk3spVt/qgy06cxBEXFDgNdBK/yyABiSoT8Z/8KW0hiLu3t1aP2V4JKIE92ZCXPoTbO4BIenMH+xjFrq/GcUvLQjIDwfU+lrfAAeuVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHzcwtKLH8cgXZoxb6L7OfnocDDNrUolHZgaRPmkC6Y=;
 b=WoP0EZ3/kmor8NoGr9fRgN2gV6zrjeRfvrLCkxph6PEE2L5rNiM+FFSaX5/klEw94Ez0JVXxquda2OACl1KyVyUwbv/k/xVag+H6DoTK5Rcxt2JDf+pbIWJOiQe8QSBBptDWeeUmEGGx95q65XGkvji333HtZzla4zGGnD15mkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7554.eurprd04.prod.outlook.com (2603:10a6:20b:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 09:25:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 09:25:26 +0000
Message-ID: <9a6b9edc-b8a3-466f-9f20-391544773555@cherry.de>
Date: Wed, 11 Dec 2024 10:25:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] u-boot: Update SRCREV for
 radxa-zero-3
To: Oleksii Kurochko <oleksii.kurochko@gmail.com>,
 yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>
References: <20241207162339.10677-1-oleksii.kurochko@gmail.com>
 <4e53cd8a-0607-4816-830b-ae2ed81e5875@cherry.de>
 <de2a1774-cdad-440b-be04-7eed6207c741@gmail.com>
 <94a3c953-0c60-4d28-a496-51f94ec6c501@cherry.de>
 <ff3ea231-b311-4058-ae7c-484b6d2d6feb@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ff3ea231-b311-4058-ae7c-484b6d2d6feb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0114.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: bb491855-2df8-4ec0-51bd-08dd19c5bf1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SWVmRC9iRHlJVytmNk0wQkd6bmpONmxyZ2RNOWxJQjNISTAyTEIyc25PTmdD?=
 =?utf-8?B?aEpGblFiczZEbHhqeUhzNFMvYnpLQWhvejJKeTJwUEc2WU15MUgwTWw5Lzdk?=
 =?utf-8?B?M2xUMHJwZ3p1K1cvdkRXS2tKc3FVNjJaVzhjdXBmM3VHak85QU1XYm9UMGxV?=
 =?utf-8?B?aVF2YURwYUdJNkxUSXRPcHgxekVzT2UvcDRlTndZL0dlUWt6SE5MSk8xTnJo?=
 =?utf-8?B?QW5NMjg0eHFtUjFBL2p4bWlNZTZTdTZMV0RJWGx3YXZ4QUNjMzRvNEFVNHV6?=
 =?utf-8?B?bVZGYmFOenlYc1VTSDFpTDRlTjJiajBISG9yL0pnTTNPVzVFMXExVThETEhQ?=
 =?utf-8?B?M1cydVh1aVJaVUZORmk2MG8rSlE0TEhRdGd0TnE0djI3NXVORnFGd1hCdVlq?=
 =?utf-8?B?cGtlcGJvR1J1UkJ0Z1c2RGVSb0wrRmNOMERmU21lclRtU01PbEYreUlOR1lr?=
 =?utf-8?B?WFlRRTRnSHNVVzk2azZFajRpVzZVK2M3SnY5UlFVZDErZ0F4MWZTN1YvelVD?=
 =?utf-8?B?c3QyYU9JV2ZwUkpZSkcxYUl2cndxVW8xTTBETHczU0R3blBpVDQrZ2lGa2VR?=
 =?utf-8?B?R0FTSEI2VkJVNWxadVVTU2kxSE50T2QxZXozK0tXNkk2cE5FUVkxclBqcUpK?=
 =?utf-8?B?aWpNREY0OEZKUTVIdzRuR005VWRCQ2NERlFPRnRoM0ZTenZLSEpPWUdoZHdJ?=
 =?utf-8?B?UDFyMTBKc2RWRkxSb2pVNlZ4QmxUUU5tZ2N1U2ljWkNaNmxLb0E3Z1A3UTVu?=
 =?utf-8?B?Unh4aklkSi9oc1hGWE5ubFh0WHgwSktHYytRNVFKVjljN3RMOTNKOXVnbDRM?=
 =?utf-8?B?TkhaZStiei9IQUlOR0c2d3NhWkRQclVrNnpZbHFNd01EbDJQQjJ5Zk1NbVlu?=
 =?utf-8?B?ZlVDa3pXaWkwU3BPQVRKeXdVMjdzeXRTNkh5cWtzUTdKV2V6bjJtUzhWNWd2?=
 =?utf-8?B?bE1pcE4vbUpmandEUERDcktwYytFWTUvMFBmMThRak16RzQxOHZoS1FKVmN5?=
 =?utf-8?B?QysxdEt0UERIVVk3ZGZ2OTc1Q0c0KzJqM2NvWGI5cjJ6NzZKOU93VFFtMmV0?=
 =?utf-8?B?Q0MrWkFKRlNYRHFpWVpkWFp6UnM4RzZBVUNtMXNTWk1HS29nQnZqeERuVDhV?=
 =?utf-8?B?NXlWQzBTNmloeDRPZER5czVUMGtDVnFRS0J5MXZnaDVIMDkxNkhmWEtLUkg0?=
 =?utf-8?B?cS9PbklLZGN5ZjFmOExuWlBjMFhwNk9JaDdMN29DcFhPUGtGRUVkbHNDRnQ1?=
 =?utf-8?B?SENuMkpxeXVNZDF1N1VGNURIbUNialVtcFNHQS9rcXB3b0JnQVhVcTdWeENQ?=
 =?utf-8?B?TlVvTmhKZXByUHpGWC9SaWIxRnlXUWRKOFpSbUVOdlMzTWRNQmJxYmZqSXlq?=
 =?utf-8?B?MzZ2V2NIdmlwWmN2cVdEbjRyMXNoRG4vaVhkWkhYc2k2MVNQb200VkFKMUhw?=
 =?utf-8?B?V1BNL0EwMWlYUzlBUExkVThaQ0ZrandCd3ErL2ZMdkU0QVh4eDVlU1N4dVVS?=
 =?utf-8?B?VUNUT0tZYll4eEgrYmIzT2s2cytheG9GalUwUTFQWHJwQ2tDT0VLdVBqa2Rp?=
 =?utf-8?B?RmRKK2loaDlPWStyeEE5QTdwMHVtSi9leVM3SmkzU2x5VndJeU1DK3hlZlY4?=
 =?utf-8?B?L3l3cFdQSTNkL1hyRHBVM2JZTlpqT1pGbEpNR1BKYnhyNlJJZEw1YThpN0Ev?=
 =?utf-8?B?YU10bDF0cmVONWcyZWd0M2hXOWVLMTZodVBlRlZrbkxaVmFpejRYYnFNdndp?=
 =?utf-8?Q?Jtrf3N/hJ8UwCEIpPg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RkIySExGQjNLeUIxRDBIQnBzbC9yWUtZU3VBSXRlSFVxRW82U29uUElvZUQ3?=
 =?utf-8?B?aWtvMFBIVnh6WVFObytRaENydDZEd3VNYUQzMmo1UnRObWJpdkJtalJhcTR1?=
 =?utf-8?B?VHFTeDl4S2VTUXY1N3JrVGsyMEtTVXgvTVJEWFRrTHl0K0JhRktvRmxUQlV3?=
 =?utf-8?B?RVNEdzdWMTUvaXNRQ2tRdWNibE1sQitnMkxVUUUrdVN6c1RsdVl6YTc3L2hJ?=
 =?utf-8?B?TlBxZE5HaEZhQTFSRGk2SXVlVDZhY0duZU01R1NnT1ZZdXhSSXZpdEkzREtM?=
 =?utf-8?B?eXV6K2ZGUm80RU5pQlB2Um03V3NOcTJQekJackxGSno1MTBVbTdBNzlCNi94?=
 =?utf-8?B?ZFJzYWw5UkxsU0s0bkR2TVFWSnNUY29ZVElETWJVWGZFV2UramxYL1hTNWcv?=
 =?utf-8?B?SjE2RXdrelJUdWxQaFJSWXlXYlc4bytSNE43eWVEb3p1RE5NZVppRFRidWlk?=
 =?utf-8?B?aElhMjBONFBFeGVPUnpTZ0F3N2JFTzhQWmxJdnR4Q3FINFJXb0cvRENhU0k0?=
 =?utf-8?B?YkR1cHpQdjlhWXc5S2hEanM5aStBRklhUDljWk5iMkhVeS9ERVpVUEpza0tN?=
 =?utf-8?B?bkhyc0E2WElnZHlVakxYMWpieHpjaEVpaWgwVkVKVXNtMlk1eU16YTRwZTd6?=
 =?utf-8?B?QkFHREFZVEM3ZGJFYVM3enJtUkRvdjV3dWJsSnFuOUY1R3JFdmMyNkZCbUtC?=
 =?utf-8?B?S1ZCakN2SWI0OXZlOEJTcWtkR3RqdkdWUlNNc1RqS255MkdiQUZLS1hIcjU1?=
 =?utf-8?B?WFA3Rm01aWdZUUU0d0l6a2lSTVdOQVFBbXZUbnc1UEwrUitnM3pLc2NGSmpq?=
 =?utf-8?B?cmo2ek13SEhVVEZBNzBwd1dGdjBuN3dpbjVxM1Jsb0kvQlZHcllEMy9HNGth?=
 =?utf-8?B?b1dXdlM4SGJsUDM1S3N5Y1ZrVjMxeTFhbzVmSjY4SkFZbDNmSlBRUmJJYlJk?=
 =?utf-8?B?SGFPOW1qVDd0eEw4VnVidlg4UnJSWisycFpUc1Ixb2pTQmxvUGhrV2FJTzc0?=
 =?utf-8?B?NGhCaWIwdlZSak13cy9KeURXUUlhaWNyVG8xV0tKeVM2dVZWZWsvbWlSaTZs?=
 =?utf-8?B?Rmk1RCtIblFscTI3YVRBMDVFZXQ3eDJPUjNhMm5lYjdSdjQ5ak5sTEU5N1dQ?=
 =?utf-8?B?UTRMTWQ3c2dzT3B0TWRMY05iU2g1Z092anozT0l3Z2drNGZYY1ZDS0hDVjQy?=
 =?utf-8?B?c3RWTHN5UXhDeVZlSmFmME5SZC9wYTdiSDhWdndLREl0YWl0SlJlUnQ1Rk9J?=
 =?utf-8?B?dmJHcDNsZnBwaXR2Q0E3VnkvQnVUbXRZa0JkbkszTS9PN0p6TzJ0Sk9hNDlp?=
 =?utf-8?B?UzV1ZDlFY2hnQng4T0ViVnZOY3NiOWpMcFl6Y2t6QkE5bENKWmRDaWt2bWZF?=
 =?utf-8?B?WC9ZUGNHc3owM3YzRk5TSEFCL01ybHFBN0hTcGJKcWdEUis2eW1IcnFkWUJl?=
 =?utf-8?B?SVhYWEplMVI1aWg5czdIRmVIam4wRmhxNE5iODBIelAzbDJtdnBnYmR6NC9w?=
 =?utf-8?B?dEJJOGswcTB2R1pZeGxDTEJlQy9RUi9GaEd4U1E0WlppeFZqQnhVZHNuaCtj?=
 =?utf-8?B?MHZGWUxaNE1aK3RSMExka1EvcFloeWRnWkxhNk4zZllvdGNNV3NtbnMvMS9P?=
 =?utf-8?B?WkxnL2JPY0VPSVZJejZLNTF5NlFNT0w3Ym5sb2RyeEE4L0ltd2hZNXRJNVZk?=
 =?utf-8?B?K251TjZGei9hcmF6WDlYb1IxSmhsOXppdWo4dHhBb204TElCZmluL0NkV0Vt?=
 =?utf-8?B?cXNpeis1Nld5VG0yTHMzZkRXa1RrTEdRa1E3NENzb05laXJKeEtqUlJaK1J2?=
 =?utf-8?B?bWFrSkdWdUxSempOUVBNait3UUN4NDRMTGpSMWhkdjViZWlKMHJYb0lqMnhj?=
 =?utf-8?B?Tm5WSkJ5NWhyZnVLR0VxVDZmUmRwU3lzM2M4ZGpEMGlIL1doYWw3MjIzdWpx?=
 =?utf-8?B?aCtWWUtzbnFCR1RwSjJnaEVDRFYvY2ZlZWw4a3E1NmJPZE02YXREanRWRFVK?=
 =?utf-8?B?NTlrNlRkYnRta0xhK2tOMGwwZ2NpMmlydlpHYyszTlB3ZEtQV3prNUFvcDQw?=
 =?utf-8?B?b3M0cnc5NVZjUWNld2Y0Qlg1UXJYbm1VWlEra0FjdTk2eUhha3pDeUdkMjZU?=
 =?utf-8?B?SmtKYWNoQ2MxbGw4OFV1QTF1eVZLQlFqV1VSTTNncEllRk9xWTdIdURocWl6?=
 =?utf-8?Q?MGOwLYfnQh+w6ZfhpTDA+Gw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bb491855-2df8-4ec0-51bd-08dd19c5bf1d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:25:26.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ML+YohrYknvl9/iKXQUFOdVNMgGZ9RKtGLMfhPLKWmFoWFjVskMpofwSDol1ERJvAUxIQ4CNr4T3WqQkJeSsbsIgYfDrK+2NJ/NjTGN/1n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7554
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Dec 2024 09:25:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/885

Hi Oleksii,

On 12/10/24 8:03 PM, Oleksii Kurochko wrote:
> 
> On 12/10/24 5:37 PM, Quentin Schulz wrote:
>> Hi Oleksii,
>>
>> On 12/10/24 5:16 PM, Oleksii Kurochko wrote:
>>> Hello Quentin,
>>>
>>> On 12/9/24 4:22 PM, Quentin Schulz wrote:
>>>> Hi Oleksii,
>>>>
>>>> On 12/7/24 5:23 PM, Oleksii Kurochko via lists.yoctoproject.org wrote:
[...]
>>
>> I would recommend getting familiar with compiling and flashing the 
>> kernel and U-Boot manually on your RV1103 device before trying to 
>> compile them within Yocto, especially if there are patches to write 
>> for both to be able to boot upstream. For downstream (vendor kernel 
>> for example), that's a different topic :)
> 
> I started to play with their build system ( https://github.com/ 
> LuckfoxTECH/luckfox-pico/blob/main/project/build.sh ) but I am not 
> really like it ( at least, sometimes I have to build several times to 
> get finally compiled something ) and it is the reason why I decided to 
> start Yocto port.
> 

3000 lines of shell script, what could go wrong.

> My first step is to come up with recipes which repeat the way how they 
> are building U-boot and kernel ( based on the source code available in 
> their SDK ) as I am not understand at the moment how big difference is 
> with upstream. Does it make sense to do in that way?
> 

I would still recommend to build the kernel and U-boot and whatever else 
this monstrosity builds that you need, outside of any build system. 
It'll help you figure out what is necessary to get your source to build 
AND be functional. Which will help you writing recipes as clean as possible.

Building with Yocto (or any build system) may introduce unnecessary 
friction when developing low-level BSP code.

> And only after that start to look at how to optimize everything and make 
> it looks closer to upstream.
> 

Not sure what you mean by "optimize everything".

For what it's worth, Rockchip's U-Boot vendor tree is absolute garbage 
and I'm a strong believer that it's a waste of time to try to support 
your board or fix broken stuff. It is usually not TOO difficult to add 
support for a new SoC even porting most from Rockchip's vendor tree. You 
can have a look at the support for the RK3576 on the U-Boot mailing list 
for example, that should give you some idea of the amount of work to do 
and which files to pick.

But if you have some U-Boot that can already boot a Linux kernel, then 
maybe start with that instead, baby steps.

The kernel is an old Rockchip's vendor kernel based on 5.10. I believe 
even Rockchip doesn't maintain that anymore (they switched to 6.1 a year 
ago).

U-Boot is 2017.09, from Rockchip's vendor tree as well.

I would highly recommend getting rid of this downstream U-Boot as soon 
as possible. It actually took me more time to support our board on 
Rockchip's U-Boot than upstream for our RK3588 Jaguar and it was only 
half working.

The faster you can get yourself out of Rockchip assumptions about 
storage medium partitioning, naming, etc... the better off you'll be.

Cheers,
Quentin

