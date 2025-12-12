Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA83D59D89
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 19:08:33 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1155.1765566511690030093
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 11:08:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Lt1LcS9s;
 spf=pass (domain: cherry.de, ip: 40.107.162.57, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hzyu2cR/cW6FctZkdPmzwcbuYg0qfcf1QIefvmU+n0SAnf5a0qNYTp2cG3Fme4wsIuxmOEz2uS1Z5GAXZe1EujwyHdhy/CPa6WHJH+QFuuLyhcwCgFT6f//4QLm9xVbqA9EdYdfw4YqXhBWiAxIWFD97pkig5EtlgJldz7DkbhzEG2bea9Lie4MXQDrxUkUYkrTQ5S/uwEJQbdzVAsr2GQ9EUHUUSDtgpXGCmWvphuUJj721uXVr/wVd0wgFusiZ/HAtwj1MdgZWVMHnJu5xyGCg6LuYO/ImRIwiO05HQ4cNF681Pl05bjqk8RAWocUKjZPxZR2Zs5Fp/canipdCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzEaDYsIbF5L92ytgqrDlzefgMeAAMP+MFOKr71UshA=;
 b=i62m2fJxUO7RE/dom/0bD0jg3Sgt+bYlgVtQdrtMZ8GDV8i8erEye6PMmlmVhackV5QckB+Q6Hv2Z4xTbOmFt1bRRHhqFuaNqKJw9pxOKeTGUw6vr9+owQf8vg4QG5bYias/PSCoRcWbJITotzvOlcHeIKvvmjTgI+anMxn3Wsa/ylrSCg0AOATHFR+pers8pCDrGo9bHRVDrr5gbbDKieHIct7xBlTy3IWcoHTFpK0w747xb+L7eY6+mJzABGU3wSZwGlgI1q42S3DEy3gcwuoIibkg/X7pL3blDihYwJxSEgNsgSx2m/f3QbQTAMUmt6ac1BFQY+PhvKcs5xFZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzEaDYsIbF5L92ytgqrDlzefgMeAAMP+MFOKr71UshA=;
 b=Lt1LcS9sXXl0THk4pTNcahEwpRYuKhd5jEUWl+8b0Wuqon/otxJ4UQWKAeUyKREaIB67sl4/aRn+Cr4sp9125TRyUTyhr9RK1HDYpObS6XJx5+45NhMATK9T5NC4nL/5CCV0Brbeu1AKsyKQLZ9InV8zSW6aABZJgHpf4hloFAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB4PR04MB11279.eurprd04.prod.outlook.com (2603:10a6:10:5e5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 19:08:28 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 19:08:28 +0000
Message-ID: <f19d661e-7197-4341-accb-2cfc3388619b@cherry.de>
Date: Fri, 12 Dec 2025 20:08:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] make rockchip
 kernel tweaks easier to use
To: yocto-patches@lists.yoctoproject.org
References: <20251208193551.2426-1-twoerner@gmail.com>
 <e2a21a1f-050a-49da-b368-73f1c03f9157@cherry.de>
 <20251211202213.GA35676@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251211202213.GA35676@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB4PR04MB11279:EE_
X-MS-Office365-Filtering-Correlation-Id: 389f8afe-c38c-49cb-670d-08de39b1d516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QjRnRzh4bE80RnlOem9CK282M0wralZFK1RuVTdtWUFXb0duKzFHbzdvaEpI?=
 =?utf-8?B?end2bUs4NHoyY3ZuZ0I0bmgyV2tZa3o5V0NaYWhvbDdKYnJTelFLTWlBQk9j?=
 =?utf-8?B?YjlIOFFKaXI4cDZjOUNYZTNuTXNnYXNBQ0xib0N5eXE4OVVhbXo0V2dSNFJ5?=
 =?utf-8?B?djFZay9qR3pSY1hja200SmRUYUd3a2VJTk1oY0hTbkFXb2pvaDJYQnFoZmlT?=
 =?utf-8?B?dVI4aEdQMWJ1c2F6RXhIeDZOL09HWjRsZ0FrckpmczVJWlVYSEo4Z1R1d2ZC?=
 =?utf-8?B?c3ZwaXkxNkxHZHR3bi9KQUZiYzdJbG9jTmcrMG81M056VHgycWxLY2VWUGNo?=
 =?utf-8?B?MnZIeFpRWnZvU0FZSDZCSWE4dUtGa0wwaFJyOTJtRUVTK1AyN1h3aUVQTEdp?=
 =?utf-8?B?bUVyakpGQnd4blZKZ1BFYlFQOXNiKzh6TmRMTXZIUjd2eklLSGVVdW5MTFMy?=
 =?utf-8?B?NXArcGo1VDFMeTlDbGpXenBvT0RVck1hekMvOHplZHdMR0VOMTBhWVM4Wmxa?=
 =?utf-8?B?Z0dWUUZteXJCSU1ra0d5eERtMmdBR1ZiWFNZUFg5K2lnbnN0SHhuSTc5UGZJ?=
 =?utf-8?B?b3VySVhsc2NpR3dTUUdpQnRsN3gyckVuQ2dKeTcvbHZyWjRoM2FXekd5MGZN?=
 =?utf-8?B?cDNmZllaNlNCc2ptNGJZQW14aTcxUzZEamlLTUlicVJWSk1HRVBPY091NjJN?=
 =?utf-8?B?NEFwbldLVDd3QWkxMzN5MUFWSGVCU2RQZFBROGpPaGpaZmZXZUZaU1hOaTln?=
 =?utf-8?B?U0dnek9tb2VTWjl1YkoyUmZ0b2VtdElrSlNndzh5NWF6SXNCaERwM3NEVGd3?=
 =?utf-8?B?ZGR6Skg5V0hYZ2hvNlNDaU1oQVpxVUhTenlQQXNQckQ4U0J6b1YrZTgvV2ll?=
 =?utf-8?B?UEIwdFFOKzZBVS9KRFVZOEpSNmltZi9FbHR0Q3ZEazRrdTgyY2ZzaDlBTFhk?=
 =?utf-8?B?TVpuMWxRSW5LdGlWUlNRNlVKN2FFMVpna2VjOTJOTE9BRnpFVm81WmZ6VWJL?=
 =?utf-8?B?U2M2Rm1qVUlheDk5alRQSlJqcmsvVEFCNjZ6KzRYVWJYTjRyRms0c2RUOXF6?=
 =?utf-8?B?cHFkSVRTaXpSWTY5OTJXUXdzdmNvbEdxM3l5R0ppcU1rQWxsODErUmlCQWUz?=
 =?utf-8?B?aFBBY0ZmU3hWUm56Y0xLM21OQWpHNzFFaThDYWZpMmh4aG5iNE5XMGtEUkpK?=
 =?utf-8?B?SndtOEJjTGUwaTdvSjgzTXIzUlZWRmZIQ1Qyak9uUFJZNWJydVhTaURZY0VX?=
 =?utf-8?B?YUhCeGZWeTRFZkYwRjFpRm83T200MnRLU0dBYkFYTHgwNDY1WkJIWDdNT2NG?=
 =?utf-8?B?NHJMelM1NEJmalZoVGQvbjFUU05IYVhtclp0WUU4RHhqS0FWemRpZnZnWUtv?=
 =?utf-8?B?dCt6d09TNXlxMGlhVXZHV25GU1BqbndHWGNXUG8yRnRlKzdxT3MzQmc3YkM0?=
 =?utf-8?B?Qytob2s1bkFSTFRyMTJPd2dyMndJMWxjblV5YmdsR2NUVDh0Yk53bUdqN0Fu?=
 =?utf-8?B?dkFUc2kxQjBvaWdqYmtpQVp6YnQxZU5yTUFPaXlsNGJkcFRZN2RqU0hkeVRO?=
 =?utf-8?B?VG50NWYvbVl4OVNCKzk5L2w5eTMra0pUU0V4UUhLSEZJVmhQYjZYWDE5OU9a?=
 =?utf-8?B?T3JWUFhiblgzSllTODZsN1lTVC9uRmFEWjRod253UW5STHVzSzJVUnZSRnNU?=
 =?utf-8?B?WXljdFVYK3EraVpXTXRsU09LcEJrVnZVTWpIcU1lTHIwd3hZZ0o3aXFIRGlM?=
 =?utf-8?B?U1cwZXhZNUZFNEY4U1I3WURQRGZubTYwYm5UQXRMRzduYk5odU83ejM4V2Vm?=
 =?utf-8?B?L0FuK2NLRTZUZFdiTDZsbUFRYmV3VmYxVFlrWGNmeFhtbW9MOFY4WThrWUc1?=
 =?utf-8?B?KzROKzBzWXJ0RW1IV2xwQ2tQTWpGMnNpckRxOERKMjVkUTZXSkpsaGZjMzZi?=
 =?utf-8?Q?JAmk2dbWds7Rmfhpatfj9jX/GVD5UJRX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bFVjeGdUVjFiRTlqeFhSMDVzTmF2aHJ6UnBrZEwzQmlvb0xOakZBclhhckY2?=
 =?utf-8?B?RnlGK1d6MjE2Rnp3UlBtYUh2V2JzZk5HejI4Z0dmT3dnNW9oaCtXNW1oQUhl?=
 =?utf-8?B?ZFJqNFZQUXV2TDFmTk9VTjNKZE9wT1pIS0M5UXJkdjluWlRPR0JMbG12dE1N?=
 =?utf-8?B?dzN5Y3dUK3ljZS9DbWh3bVBPR2lmSE9vZEYxTFU1dDJMYjNmY1ZpdDlGeC9F?=
 =?utf-8?B?VHRDY3JvYjczd3BYZmhwS3F2QjJBSU5kelVydEpwNGxaM1Z0R3l5KzdIajQ4?=
 =?utf-8?B?VXdlbkhRV0tTSmZUd2luMVVOOHR1UVhMckw4ZkpaQ0ZaNk1sb3VNbUF2YmM5?=
 =?utf-8?B?ekFUTXRkSHRrQjdSKy8zMTZhZzVnTTVZcHU2d3haMkhYcVZ4THBPa0U2RjAr?=
 =?utf-8?B?c0dweldIU2FZQnBZRzlxRjh5TWF4ZzN2QldCTGpiNXR2Q1pRLy9ZNjdlQkdh?=
 =?utf-8?B?RUxlR1RDR2J0eHU2dTUwV1FqUFg2VVE5eDBXdmUycityTWRXUkNGWWo4ZzRk?=
 =?utf-8?B?Z05SN2J3WlR3VHNJa3I3ejhYUFA2RjdOS2FGRHJGT2hEUVhKcWhKUk12Mmx0?=
 =?utf-8?B?VHk4TS9ucDc1ZmhxUVErN29BSWorYnFNSkpNWDd0NWVZN1RpOVRITTRRTVZY?=
 =?utf-8?B?U2hRWjJmS3c4OXhMZ0QxWGRHUmlaelVBazNyMENzTHh2UXdBeHRXQ1ZEeTF1?=
 =?utf-8?B?blZlYlVEelo0WkJNVTdUNS9VNE5YdFY0MGhIemoyU2w1d3ZTWkhCa2MxUjAy?=
 =?utf-8?B?NENXYWFEblM0LzRxR0pzazRnOHNoeFhTdmZGSVl6a3dPQ2VoeG00WStIVlAz?=
 =?utf-8?B?TmpSODJWMDBYMzJWb0N2RGl3NkkzNFZqM1dibkFFb1RkL3FNcGFlcVN3VUhU?=
 =?utf-8?B?MHl2NFgyWTJDSzkvTVhoTm85b1dncE1mcTZxN3pzNmptUFRnTVhweGxSZUNs?=
 =?utf-8?B?OHQyTnhLaGNHWXQwR3Z3RnpHbmthMHhlLzhaV0tDendFZ0ZBekNiMk1uNFoy?=
 =?utf-8?B?OHVwYkZQakxsQkV0K0lDaFFOUlI2cHRCZmxuU0FsTWRiOWRIZlN4MWordWV4?=
 =?utf-8?B?L2NTZVBybVg4RTc1RTcyMTd0cTlDWGZqTHMrRVF5cnFIMytlWmxnVk1nN2VJ?=
 =?utf-8?B?aEllTFdWR3BBWFA5elRrZGl4aFN5Y2oxVWpVaU1jb0krNFRHMzFtWUNicW5L?=
 =?utf-8?B?dHBXUER0UVpCTlIzVWhWSU1qVkFYUEdPNWhlbnFHSlk5NkdGdlp5aG5DaFZN?=
 =?utf-8?B?a0U1TExsN0VTdFUrKzAxaWcwblBORlNsU0tuK0VZZDFYckR1UEkvcmJadHBF?=
 =?utf-8?B?MXJKYU0zQWQ4QTZ2MVUwdy83QXpndUdQL2dRczd4cDRRUXZnclVldmM5aUZ0?=
 =?utf-8?B?bm5YWDU2VnJUMGkzNnNiQnkvYTdwMEp4R1p4RXZJRTIzeE5nM1dwWkpjMFVS?=
 =?utf-8?B?WFBRVytHdFhVTDdIWWlSN3IwTXJDWXE1allWSm5YUC9WUE1yOC9ZaHR5NDdj?=
 =?utf-8?B?bUcwQVFxWWgyb09mT3VFUFJKU2MxVUg3UW5sd2lHYlpYZEViNWdHRGRyd3F5?=
 =?utf-8?B?YWc4Ti8xQTZtQkR5VmsvNG9zMEt3eXlTOHhTWlNIaHRGTkxPZXBoakVMNkxG?=
 =?utf-8?B?ajVVZDJzMHNhK1ZxNU40dld0SlY4WmJFWEFQcVAvK2tOVHliUUowN1BhRXAr?=
 =?utf-8?B?ZHlYK1lQazYxanhxY0RpRzJFZmFEbzg1ZmNQRjlnWWNwR1pvQlRXb2QyWTZv?=
 =?utf-8?B?aVZsdHIyRUlKN0tCUUVTRURiOEQ3cy9oRDFFOW96S3dLNWNKZSt1dmRUd0h5?=
 =?utf-8?B?NThsOFp4eDVwRHBEeUVTN3puaGlmWVo4YTFyendJd3FzcVhKMGVsL1RjcUpX?=
 =?utf-8?B?VXBERkhZMWlkZVdnVGV5T0E5M21JRWtpelcwT21oMnJ2RUpENDFqVloxRDND?=
 =?utf-8?B?MzEwRzZWaTRWeDZlQ3NNMFZXOWI5TGtHNm9VK1BHVk9Pb0t2VExzcVlsTlRk?=
 =?utf-8?B?UmJlYW94M1QxSUFyZjk5UlJaUGNyMnRaVVBKZFBnOVJnbFE2andySHRDQjZV?=
 =?utf-8?B?Ty9Odm9Wd2RraUZYWlFTYXpKdXovY3ZqcEFLaVBMWVZNRkJPUzBnY21MeXFn?=
 =?utf-8?B?c21ER0JZc3ZnTEtaRXUxU08rZHN4SmxEOCtsT3diU0VXRXJoZTRSUGlmSUFi?=
 =?utf-8?Q?YW6739SMOvFpAoB75eJMrKA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 389f8afe-c38c-49cb-670d-08de39b1d516
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 19:08:28.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IoUOCHOgqLaTX8cGXfpSKTx6Xm5ju62RmNDcnwzwafUII5Ue6YgHJU5MqCRJJjGPukBdA3WUDL0EgwnYkHrOikGUl5ZkNkrM4ndgphfKYJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB11279
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 19:08:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2778

Hi Trevor,

On 12/11/25 9:22 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Thu 2025-12-11 @ 03:13:50 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 12/8/25 8:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> If the machines defined in this layer are used, they will want to pull
>>> in the kmeta data that is also provided in this layer when configuring
>>> the Linux kernel. This all works automatically if linux-yocto or
>>> linux-yocto-dev are used. But it causes build failures if a kernel
>>> recipe is used or defined that is not one of these two.
>>>
>>
>> The issue is that we have machine configuration files settting the
>> KERNEL_FEATURES variable in a conf file instead of having it in the kernel
>> recipe.
> 
> As far as I am aware, there is no rule saying that KERNEL_FEATURES can
> only appear in kernel recipes; in fact I think that's the wrong way to
> think about them. The kernel provides many things, and each of these
> things can be configured in the kernel.
> 
> For example the kernel provides filesystem types. If you developed
> an application that, say, provided a fancy dashboard or status or
> configuration or debug interface to a particular filesystem, then
> I strongly feel the relevant KERNEL_FEATURES additions should be
> contained in the Yocto Project recipe for that application. Perhaps
> your application needs the CONFIG_*_FS_DEBUG flag enabled in the kernel
> in order to work correctly or fully, in that case the KERNEL_FEATURES
> should be specified in the recipe. There's no point having a user
> include your app in their image if the kernel doesn't provide the
> interface or data it needs to work correctly. I would even go a step
> further than that: ideally all Yocto Project recipes would include the
> KERNEL_FEATURES on which they depend, regardless of whether or not that
> feature is present by default via, say, the in-kernel defconfig. For
> example, a user might not be relying on some defconfig (regardless from
> where it comes, whether it be in-kernel or from a BSP). In that case,
> the recipe should work "out-of-the-box" for a user who is including
> it in their image. My guess is that currently throughout oe-core and
> meta-oe there are probably some recipes that have an implicit dependency
> on some kernel feature being enabled; I think those should be make
> explicit via KERNEL_FEATURES.
> 

That's simply breaking the variable context. You cannot have your 
application recipe specify KERNEL_FEATURES and have the kernel recipe 
pick it up, that's not how it works unfortunately. Also, good luck 
making sure the application recipe in layer meta-i-am-haxorr isn't 
disabling all kernel security features via KERNEL_FEATURES if that was 
the case. (But then, "user's problem to make sure it doesn't happen" I 
guess).

This kind of need historically has been handled via a combination of 
DISTRO_FEATURES and MACHINE_FEATURES I assume? Maybe we need another 
mechanism for the kernel as well. I for sure would like one for 
specifying to the image (creating the U-Boot extlinux conf file) which 
of the kernel Device Trees my kernel recipe has installed (and which one 
should be the default). This is currently not possible and you need to 
modify the machine conf file when changing the kernel recipe (I have had 
kernel recipes with different names for the "same" device tree and I'll 
soon have overlays replacing full DTB I had made by hand, included 
through the same KERNEL_DEVICETREE mechanism). This is not 
meta-rockchip-specific, just a global issue. I stumbled upon 
meta/classes-recipe/uboot-config.bbclass modifying IMAGE_FSTYPES in the 
anonymous python function, I guess this must work (have worked?)... 
Wondering if that would work for my use-case. Another topic anyway.

> Another thing a kernel provides is architecture- and SoC-specific
> code. In the same way as my user-space application example above,
> architecture- and SoC-specific KERNEL_FEATURES should be specified in
> machine configurations, not kernel recipes. Somebody building an image
> for a Rockchip-based device does not need (for example) Qualcomm support
> (and associated Qualcomm-specific drivers and features) in their kernel.
> In meta-rockchip, using one of the meta-rockchip-defined MACHINES
> disables Qualcomm (and others) support. This saves you in image size,
> it saves you in runtime RAM usage, and it shrinks the attack surface
> somewhat. You're suggesting meta-rockchip should have bbappends for
> various known kernel recipes in order to provide the user with the same
> kernel configuration adjustments, but this doesn't help a Rockchip user
> if/when they define their own kernel recipe, or use, say, linux-stable

Their kernel recipe, their problem. I'm suggesting you to *not care* 
about those recipes you have no idea about, don't try to actively be 
smart about it.

Support what you want to support. Which seems to be linux-yocto, 
possibly linux-yocto-dev for some boards when linux-yocto is "too old" 
and you seem to have had some interest about linux-mainline recently. 
Support those, and people can infer from what you've done what they need 
to do to support their own fork.

Also, how do you plan on handling Kconfig option renames? See 
c20e8c5b1203 ("mfd: rk808: Split into core and i2c") for example.

> or linux-mainline from some of the kernel-specific Yocto Project layers
> that exist. In that case they will get no error or warnings, they just
> won't have any Rockchip-specific KERNEL_FEATURES enabled.
> 

Yes. And you complained that because KERNEL_FEATURES was set in machine 
conf file but there was no bbappend for linux-mainline to add anything 
specific to KERNEL_FEATURES, it would fail building it. This is not 
fixing the issue, it's making it easier to work-around it.

Now, I'm a user of meta-rockchip and I write my own kernel recipe and 
inherit kernel-yocto because I want to. I cannot build my recipe even 
though I did everything right in the recipe, because I'm missing a file 
I never asked to be there in the first place (via KERNEL_FEATURES in the 
machine conf file). Now I have to fix my kernel recipe to ignore this 
KERNEL_FEATURES or override it in my machine configuration file, but 
then I could be building linux-yocto and will report bugs to 
meta-rockchip with a config that doesn't match the one you are expecting.

I haven't checked if the following can happen, but a glance at the code 
seems to indicate yes. Let's say I know EXACTLY what I want and I 
provide a defconfig I built myself for linux-yocto after 
vetting/auditting it. Would I expect meta-rockchip's machine conf file 
to modify my kernel recipe's defconfig to add some config fragment? And 
yet it seems it would.

> In an ideal world kernels would be configured starting with nothing,
> from the ground up, by using KERNEL_FEATURES. BSP layers would add
> KERNEL_FEATURES based on which SoC/board you are using which would come
> into your build depending on which MACHINE you chose, software layers
> would add KERNEL_FEATURES based on what software you're including. A
> basic set of KERNEL_FEATURES would be available that most people would
> want, but it could be overridden or tweaked as the user sees fit for
> their purposes.
> 
> I feel the correct location for Rockchip-specific KERNEL_FEATURES is in
> Rockchip MACHINE definitions, and I discovered they can be cumbersome to

And I disagree.

> use when they are only available for specific kernel recipes. Moving the

So stop making it apply to all kernel recipes in all layers inheriting 
kernel-yocto, by simply moving KERNEL_FEATURES in the appropriate recipe 
(via an .inc file if you want)?

> core of these files into an *.inc makes them available for all kernel
> recipes.
> 

Yes, that's fine. I don't have an issue with the patch per-se, rather 
the reason for the patch to exist in the first place. This is a zero-sum 
patch, feel free to apply it, we can still continue the discussion in 
parallel on whether KERNEL_FEATURES should really be in machine conf 
files (it shouldn't :p).

Cheers,
Quentin

