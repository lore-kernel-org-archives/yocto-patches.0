Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C363D41C27
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 10:08:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web10.8868.1731492527755199325
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Nov 2024 02:08:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=cWiyacKW;
 spf=pass (domain: cherry.de, ip: 40.107.21.65, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtKAM7+BJvfMIGfGQY4gD50T3oDSwMZAqBrRlkgfPQcM71WbQUIuNEMYvTJW85KgMqVKrDJq1OzRI/d7xvdT682BNzEqk3hAz5oJ0YN3Dl+lgSHHVL2NgwdGAFIwzWXK+p1kcPp9jXjOd2wGO7y9Pa0QmwoJwRfHtfCk14Wiu9ew3U7topev+avck9dvYhs9G+piUGcwXzWL/spxnRUnrM/sDA628YE2rmO/rnVC1zO7Aj9gvDw2hNe6vi4nrV14nSTbhtaqJxyxWg9cOEawVOBItbG0zKlCbNM8OiFAGiT2mkbY4su6DU2AgW8NBFfNd1ZPAvyFTI+QQEdmkh2HJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNgEmSFnEQ45j525OT7loNTYjnlI1mZHYxY0PLbimvI=;
 b=n1NOzipShmVoefeJKem9FPFSq090j1+Bmib3WOPII9N0tNnOhWeaxCRozs8iKfEf4nPhroNYZsaZV4+1IWgLvSdmvzWeYCjS5N3proL8mJ+x5AHVuQZ8biRe2713kOF7QajDonChujGQHH9Zi+vgXOjN48veNK7Adc5iQbRk7dYlr9OQZ0lrRCHMWXqu6QTMeE3V+wlOV/jOkAb+v+tswHA5DGL5ThFAPn7XLP5um20RoyGfzwGlxKaUZBTfmu6HpdRlDwibcKS5CKJb6+l6bSTrRAoQkjEJRz6lduV5HhwnI1Kj3ELjCGw847Hse+Nlss0WRWuTASs32iFSWDLi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNgEmSFnEQ45j525OT7loNTYjnlI1mZHYxY0PLbimvI=;
 b=cWiyacKWnoxeQJp0kTRLETjKhnGnx9mfjuiPpPSPXl3QG8g1Vgtd4pgnBVG2qV8mS5eaKANhcOc0Y+2J+6SAFs/2Yp9pnXDEiSidRcT6x3F1FY6s1A7VUj5WeLofN3VIadsyDQHdsxyVFugCZLJsBlg/I9zObygjMgx4D1yiQzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB9116.eurprd04.prod.outlook.com (2603:10a6:10:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 10:08:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 10:08:39 +0000
Message-ID: <5db30b32-f058-42c9-bde9-418c6a7b6625@cherry.de>
Date: Wed, 13 Nov 2024 11:08:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
To: yocto-patches@lists.yoctoproject.org
References: <2f52ba6e-4709-4b66-b23d-838cbf8d9d3e@trifork.com>
 <2664ede8-d88f-446f-9419-6372fda41361@cherry.de>
 <bee5d935-5f5b-4347-90c0-15462e58c4ae@trifork.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <bee5d935-5f5b-4347-90c0-15462e58c4ae@trifork.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1P195CA0047.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::36) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d421ca-e7ab-499d-3af7-08dd03cb2505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z0NiZ3ZBZmlvU1RYNVRma09VR0tET1pvTDcrNGp4VEFVQ3lza3hGMFQ0bUha?=
 =?utf-8?B?eGFLN2w0cUlIZC9TWkRpM3FaSGI2NDlnNUwxRnFqM09DMWY1RjF5SFdsVm1v?=
 =?utf-8?B?OWxlQ2Y4U1loZEU4YmVuVUZ2eUF1YVpMUUsrTDA3d3BMeTNFL2tJU2Q1QWZl?=
 =?utf-8?B?aElia1NjaGVkSHRCZUZjM0xkc0VGZVo1Z3JkMlpxM0tTKzloNzZnZXdObDRH?=
 =?utf-8?B?clhuRWgzckNBZDVGd20rLzkyS21ndmd4V0FJYUkxZ3E4U2NUMzRLenNRYU9F?=
 =?utf-8?B?dGJYSjNnYWpTRWgrcG84M0dIL1A5cGZUQ253LzlRSUNTY1lCdGJ4UUdKVlJD?=
 =?utf-8?B?STg1RWMrQ0ZNVFVzMmxmbkNab1A2YjZkcjZJdHFEdHlQTW1zNC9vMzFxYnJT?=
 =?utf-8?B?Wk9aY08zajRyRWNZMFNwNTFPdkxzUFVCaE53M0h5WHNMRWord203V0FPdkRV?=
 =?utf-8?B?WVNSVXM4dS9Xc05JTHVkNitmelVzU3hXdVNQZFQxZWVwRmh5Z2MyMk9LMDR1?=
 =?utf-8?B?VVh5SmEybGI2MnhxRXl5Q1RDajJrc2pCTTArU0h4cUlLczVZTmlDL2V1WThk?=
 =?utf-8?B?ak5VUUZPU2VnS0prL2srMDBScStXUGtSNGpyVHNFYmZOS3VjbnFUN3hJNDZN?=
 =?utf-8?B?YjViMUJpUFF1WUY2YkdhN2duMWVLNWx0azROOXpjdUZzVmhhU0U4NUJkS3V4?=
 =?utf-8?B?R1ppVzh6eStEQkNCRlFBd2djcitmWlUvMk5ya09JazdpS2ZMditRblQ1WlZQ?=
 =?utf-8?B?c25VUWJVRVNzWEx0YlFWS3V4NGlVMTQ1NkMxU2dqZ2xnMytwRHYxdkNTc0NX?=
 =?utf-8?B?SFB6VnVXY1JSeTBobG5jUDZJQkpRYnRaMmFoM2RhbGgzNCs5ajEzdWxGYnVz?=
 =?utf-8?B?MFRKU3BoeFdFYVE0dkc3SG9XdlhJM0RuRytpR0s0U1F2ZW82WFJzWGZwUThn?=
 =?utf-8?B?Wk4zcDJiZHN1enZ2ZVFyQzgramhLV25MczhraTc3MUNMd2U4TW1BVCtOTlJV?=
 =?utf-8?B?VW9GNktsTi9KY2dqWVZyZ2pjd3RFZE5QYUV0WVgxemMwU2FVL2grenAxc2lu?=
 =?utf-8?B?bVVYbWJ4RHVYM0pZWG1VcVRiUEJtdVJUWmR3dnpVT2tIQjZqdEVESUZuejU4?=
 =?utf-8?B?ZCtZTUMwSmExZGVXbXZ4L3NvQnFoaGcyOVMwR1NTaTJaZUY2czExeExyWEc1?=
 =?utf-8?B?bU5LWFZSSXVFeld3eG5IUk1iNnVwb2tVaXhXbWJTVzB1d1FwOVFENDNWeVBv?=
 =?utf-8?B?RUR2MFFNN0JQRjZ4UmdiODVKcDZsWUhIZURuM1cra3diOUFHMkRyaUJkaVE1?=
 =?utf-8?B?TEZWbHNydmViSE8zTHFQcVpNMk5ZRGNJSXNscnV4TU1lTys2d1pvaVN1QTM4?=
 =?utf-8?B?d3NEcnhPTEFUWE44S3ZkdkxGWEI0NlN5WHloQnFwdGl6YWNha1NhbFNoZXN1?=
 =?utf-8?B?aTBZZCtsT1RZNy9HTitoNXRKVmpYVUVKRWhlVzdocC9qdWJLbnRhVkNzR2JC?=
 =?utf-8?B?Nm9Bay9iNnMxRldTZUM2Z3h6dFRQTmNVZWJLSFdkUk11Y0RDOGtHc3FNOXNZ?=
 =?utf-8?B?OTBnNEtHWVQwTW80UU5PMmFHaE9MMXBsbVFENUlMcEVDZmhGVGZPYmRjZkln?=
 =?utf-8?B?M2xDd2JrZFgxVUh5YSt0VEp2REM2TVhXK0g3U0hVVk1wZmJaMndqS0hybnBy?=
 =?utf-8?Q?OrWBDzVPzAeVU38MtxCk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2RjV28zTXdZZlMxY0ZVWDc0VC9PZVg3V3J3d3YrSS9LNjNTc0NzdjdCbm1j?=
 =?utf-8?B?MHZhTlJ6YmJIbDZ0WHc4dFAxb2xlaEZYcFlScDJvVzVEMGphOUJUZktQVThV?=
 =?utf-8?B?NVZmQlQ1dVBxdy9kTU9qenhMWHJWaWZZWnlWWFJKQ2RnUXhRMDFjbFVTemI0?=
 =?utf-8?B?Q3VsNDlieUY3ZFh1NElkcWNDNERaa0M5Wk10NTVwS1dhYkdIZEYvUTQzd3BH?=
 =?utf-8?B?dTFMZTUwdUxJbTNGTjhtZ1BYZ0VFUVBmeERBUm8wOEpjL29wNWhUV1kvU3B1?=
 =?utf-8?B?S3V1VGpRMjVMN1QydnVUZCtFanQ3WXdnNnVXenpwREZuUjhZUHV3eXJnZHNw?=
 =?utf-8?B?azl2bktMQkhCTVFjZU55TkZHU2Q2byszUHhkZUVRaitETFZ5VUVVeUo1ZnZV?=
 =?utf-8?B?UElxdkJxZENtV0R4ekNqWklKUk00V0l0d3lqVHhscTNUNmZYN2RZTjd1MWV0?=
 =?utf-8?B?SE4raXRNOGJoYjVuc1R1SVc3eWVhaDFQa29qMG16LzdMUU5NWlZ0RmpnYk4v?=
 =?utf-8?B?SnpUNHdJR3NSazZYb1owN2pOajVOM08zYjlTa3RXeVBaSTdFcVpTaXJ6MHpZ?=
 =?utf-8?B?VnB2VDQ0a2pSNDVpRE41RXNnWXFNaHFWMHl1anBKelZSa2VmeUgweFNGV1JC?=
 =?utf-8?B?UW93TE1XVWxEVlBENks5UFdMMEtKOFFBdEliQ1Q3enpTTTEwQzBTMmVRUytj?=
 =?utf-8?B?R2J3K1dxKzRNbzBMYUpvL0FqOGVUeXRKSVlzdjhKaWlXRWRQenJQYUs2b3dr?=
 =?utf-8?B?czMrOTlsbUQyWHdyU1FXajhYVHphVUZFV3BrK1BxZGJkMFd0VGNaaWR0ditp?=
 =?utf-8?B?VlBkbzZuV3JROWFSVGMwK2U4a2d3bkE0eHlqYUtYNHRvRkVIRmJ6bHZvQkNG?=
 =?utf-8?B?bWZ2TlFWaUI2dXlYckUyVVNTUGZoQVo4SzM1TUp5ZUhhbzNNTnNsVjZLVkpj?=
 =?utf-8?B?ME5jR3UxQms4aGZTWDY1U1pZb0ZwWGhXUGxVTHh5U25WL3NkTEtwbkxLbmUr?=
 =?utf-8?B?dkdmV3VGejhEN1JSdURjQkc2VXlTamJCSWpjR2NVaVkvUFYwbStmZjRHT0lj?=
 =?utf-8?B?Tmpwb256MWtGVzhrNlBCdzJQZlI1Y2tXT1A2amhzNlJ1bDh1K1VmcFVWeHpD?=
 =?utf-8?B?cHhLekpkNTcyNGhlYmNtQ0JVWmZnOUUwRFRIWGJIOGpRTVQ2QzRWOXJCbitu?=
 =?utf-8?B?aExLUm5lakdoNjU2UzNxZFRHZlllNWpIaWJKVzhmeVlCUEs4MmVUTkE1K2hU?=
 =?utf-8?B?bDJ6VHBhb0dWdUprWnhoVkxBMHdWK09BQ3Y4d1R6Vkw4UWN0ellVR01MUXVw?=
 =?utf-8?B?Z0h0VUdqb3dVSHlscXZsUFloTCtQbzNBeXQwZmZPNUlocUdSRmx3SlNUZ1dH?=
 =?utf-8?B?WDBuSDYvQVl2cmMxOGRDSGllRDlYZTBtU2ozSHFTS21icWptUml1U1VEZENZ?=
 =?utf-8?B?cmdKOUNnaTNCc3plVnBYV1F4VFkrekJFQy9VZkpMNlUzekczNWFwVDZqOSt6?=
 =?utf-8?B?bVJPdE0rdWZUbEJpUFlOVzFpSjUyb1Nxd1JjVEt3cC9MMHJ5eUxBREFJeEZ5?=
 =?utf-8?B?eStjN3A4Y3ZaMWp6Tm1TaHpQWjJ4K1Q2Z3hmR1VyS08wR1JhVWlyUWNuUmhw?=
 =?utf-8?B?NzY0Y014LzR4QnJlV1l0RHV0MWVQU0ZZeW9WRndaRG5Jb3VFM0JaZlExUUk1?=
 =?utf-8?B?elV0TWlDNzRGYTRVeUk3T0VsVHJ4VlF1d1U4OTBjcUFCMkFZZjAreHlJamFG?=
 =?utf-8?B?enFhd2RkNkVEZXZaeG9lSzhQcGdhSm9tRGYwUUdwaTV6NnRTU1FRY1ZlRmFz?=
 =?utf-8?B?VVJ5QzVJWGVtV1VRVFNma0F0L2QxNGRDY1B6SGZpZzRDcHhySWR5WnJwYU5o?=
 =?utf-8?B?K2xEN0JseXZOQ3NzeFQ0V3RzRzNFVDRXUTFjczRpeGpZUEZDS0ZCNWhFQkpQ?=
 =?utf-8?B?cXdVYWtkMTZmaEV2cG1ZdllNUi9oUTlxbWczaXlhS2FxNXBUcWoxR2huM3B3?=
 =?utf-8?B?UkhkdU9US1g5dzY4azNFRDZQVGZZRjhzdUdMd0JyQ2lEQklIZ1ltZXlGWHo5?=
 =?utf-8?B?WFVtNDVyL0ZoN2NtYVZ6eThaL1F0YWU4MUlXTWt5QTVPb09SN1NaS05mR05T?=
 =?utf-8?B?TCtLQ2NJQ1N2N1dFYkFnVHM0MFhVU0lWWFBRNlZOV2RZNmEyYmlRVEJFRjYx?=
 =?utf-8?Q?29DFXY6Tk3+tib4oAMHF1HA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d421ca-e7ab-499d-3af7-08dd03cb2505
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 10:08:39.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCh8y2x2VEDVHiouSysKWRuSNSFHu2sJzPb3GklIqNuAiE15DmV3NLnQ6cpVqB8Tbf5FYZ38YUrGu2db1tagnd2cdK1N9IyXGGO0L91l8Vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9116
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Nov 2024 10:08:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/795

Hi Paul,

On 11/13/24 10:52 AM, Paul M. Bendixen via lists.yoctoproject.org wrote:
> [You don't often get email from pbe=trifork.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On 13.11.2024 10.39, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Paul,
>>
>> Please do not attach the patch to the mail but have the patch be the
>> mail (the commit title the subject of the mail and the diff the body
>> of the mail), this way we can provide feedback inline and do not need
>> to open and download a file.
>>
> Ok will do.
> 
>> c.f.
>> https://docs.yoctoproject.org/contributor-guide/submit-changes.html#sending-patches-via-email
>>
>> WKS_FILE ?= "rockchip.wks"
>>
>> is unnecessary because it's already the default in rk3566.inc that you
>> cinlude.
>>
> Cool, thanks. I missed that
>>
>> Maybe we also want
>>
>> MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
>>
>> in there so that kernel modules are installed by default in
>> non-core-image-minimal images?
>>
> Yes, but the functioning of the machine does not depend on modules in
> the default case, so I thought it better to omit it in the base case?
> 

People usually want something that works out of the box. And actually, 
the upstream Linux kernel defconfig for Aarch64 machines does make 
extensive use of modules. I think most recent additions of machine conf 
file do enable it.

>> Could be nice to add a link to the SOQuartz product page as well :)
>>
> Yes, this is an oversight on my part.
> 
>> I see that there are (currently) three possible motherboards for that
>> SoM, CM4-IO, Model A and Blade. I don't know how Trevor wants to
>> handle that though?
>> - Different machine config? If so, the machine conf file should
>> probably be named after the full config and not just the SoM.
>> - Multiple Device Trees included in the image? Then we need
>> KERNEL_DEVICETREE with the three DTBs in there.
>>
>> Considering that we have a different defconfig for each variant in
>> U-Boot, I would lean more towards the first option. Do you know if
>> there's any way to detect to which motherboard the SoM is connected at
>> runtime? Maybe we could have one U-Boot binary for all three variants
>> and load the proper DTB at runtime, based on what we can detect.
>>
> To my knowledge there is no way to determine what baseboard is used and
> it is also very likely (since this is what we are doing ;) )
> that one would use the module as a starting point and create ones own
> baseboard.
> 
> In this case one would have to recreate the machine in their own setup
> instead of just building on this one.
> 
> I guess what I'd go for would be to have the SoM machine and possibly
> have further machines for each model (there are _a lot_ more than three)
> based on  this one overloading the defconfig.
> 

The thing is... I'm not entirely sure it makes sense to have a SOQuartz 
SoM machine config file.

My company sells modules with one baseboard. Considering that most 
people building their own baseboard won't upstream it, they will need 
different kernel and U-Boot recipes, with different configs and DTBs 
which is essentially the whole content of the machine configuration file.

So if we're going this route, we can simply have one machine conf file 
which is for one SOQuartz on a particular baseboard (CM4-IO it seems in 
this patch) but make it explicit in the different file names and 
contents that it's for that particular combination. We can still add a 
comment hinting at how to support a new combination though :)

Cheers,
Quentin

