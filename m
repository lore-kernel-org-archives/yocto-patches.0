Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E421ECA0FF2
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 14:06:42 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.21])
 by mx.groups.io with SMTP id smtpd.web11.13448.1756908398072021748
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 03 Sep 2025 07:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=MFzR0SQE;
 spf=pass (domain: cherry.de, ip: 52.101.66.21, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idJxoaxZl6nN3fFJkiRkxOOElDUXvkSIOZcSDAcZaq3YIJmGQpKAhQqmG2cUd+0Fx55cQ6Rb4SXd5n6LbzBfD4YC9x/k8+f4WMX4yEHfK/i3ST+QnvaR+QRXWsi8EULbNo0rCsdgD6fj3zsPboN1fpTaxNAkCDV2URwgoiWcBY7haQh3Qke25zFUtwtRIRJ56SrHlco/cKQoBIVYCpFW850qlHgD3HXCqUz4uK3IHbJ4l2knh0KR0kqMFI4ryuCheDr0+x/g1PQH+JQve78fkpPoovxhCuVEubVTpxSaBMnRcfqqH8AOeSLu+sXd0gvD4DEE2zWz8Arre1i9ckdCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itBnJZS4YYFQ/dO5CHxC9ewPvxVNHxhmHrxr/c0MPBA=;
 b=XZJUm5vx0oaCS5l2wBtWUGFJtb+xZqGEdf82qjpVVSM7kC6aT7Q431aopGVJgxm1MfYU2OkbrpQ1zpIdxDtOTlC3/veFuo6erZ1/GHA6hRFL3U+Rz5ey6E1KlW2Xx62Ml31JSwZgyY83FB6P5ZzPOtdfOoOgAzP+1XWX7g+g02Hd7/o+bCNdr5bxsXNjF09xxrTCY8rZXVmMFIjHTXEx62/6yrq0joFldpe2UpMq0w+qEm17B6W3jyXRdAk2WlhLpg4bnBFdBgRiOGuvYto9M6hxr8MPYPLdygmekRUhC9SKxRTqzJPkeECXgYvmE4aZRRm51lV+VdXPUAogzVoO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itBnJZS4YYFQ/dO5CHxC9ewPvxVNHxhmHrxr/c0MPBA=;
 b=MFzR0SQEorMmaYtzKnGub8MdkyURrAEMOHm+NVQJXplMOUdYwSdQxqZgwtTyTN7wRzYjyibeBRvK4BXZscM90EvtFGzh6WzcKMS3V9wtsPLM8Lh9MTWhA4P3zii904sjssEbt/RPvjyLRj0cmWZX6UNn4xJql4pW15RjjpNLzO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9308.eurprd04.prod.outlook.com (2603:10a6:10:36c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:06:33 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:06:33 +0000
Message-ID: <19b5b6f3-a417-4b1e-bf78-b6dab3570362@cherry.de>
Date: Wed, 3 Sep 2025 16:06:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] xf86-input-mouse: drop
To: yocto-patches@lists.yoctoproject.org
References: <20250903140251.39966-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250903140251.39966-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9308:EE_
X-MS-Office365-Filtering-Correlation-Id: 07457a41-456d-4d16-6329-08ddeaf315ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bEFkeEZack41VGtMYjlQTGZJbFpGektybXAvamM5UDhJaXhOaEJJSjYwWVBT?=
 =?utf-8?B?NFEzWDZIRjNoRjdZckpzcnhhZVV3d3Nkc1UzcUFxRUZSOGF1WXZyaXdyUDFC?=
 =?utf-8?B?b2lnV29ZOWlYc2RtVW9SVDl3aUJiSmxZWUdXQjZTTzV0Unp6enZIaEdXWGJa?=
 =?utf-8?B?TFcyMnE1UStBTWJQODZDSExUdEdtZm9sYVk2aitRNkl6TStGZVdxbk52VTVJ?=
 =?utf-8?B?cW9PN2lrZjdqYUhaMXVGR1ZOQTVjemMrMUIrZXUwellMUzFrVnlsY0p2aEQx?=
 =?utf-8?B?QW9NYS95VmZCaEhOWXVCK2Y3NWt6b2xzeEk0VU8zSFRvd0s4Zy82cGdIdGxz?=
 =?utf-8?B?SGE5RFk3clRROFV4TjU3eWdjZlVJMWY5NEY0ZHNMMGRyaTFaYm40U0Rmd3ps?=
 =?utf-8?B?UVRuSktIa2cveW5OMFBMeVhCaXVlUVdocGVVSEZxL2tNWHpsVmRleTRiSjRu?=
 =?utf-8?B?Z3hySExSdm5LdVNrSWtDb3lVU2FHY1dmbEc1QmY2dnVxdjhnLytUbDR3cksw?=
 =?utf-8?B?eHhWVkhJdktYTkdMU0s0a1NQRTZDOXVrcnhlSTNDek12cmJJQzN6V0QxVVVw?=
 =?utf-8?B?RG9MRFRXc2NvbXE0cVd2cUxYRTJubjdSZ0V4bWwxVStHNUgxVURSV1hzdk50?=
 =?utf-8?B?blk0UFJnZnZsM3pXN0ZiNVBJajFoN2pTOEsySzJGUzQ2QmJGbHUybEVXSDhs?=
 =?utf-8?B?VDhjU0xtNlVJRklTeGVXTTFUeDl4SDFwNVZoc1FhaGJlMExvdW1qUndYM3pn?=
 =?utf-8?B?SEF3NExnZUpkdnZpVkFUZm1zTmpJQUFRKzB0U0JqMTR6OTVaTEdlQUJtQkwz?=
 =?utf-8?B?YWdJVWgvZ0gvVys5aVVSRFVpRU14d0IxeE9BY0MzMlVBNzFHKy9zcm5JY1Zx?=
 =?utf-8?B?NXo1TEF3T1FyMVRpWDNNRUs1QmFUSHNTWFdRRzdzU2hDZ0cyWi9BT1FnR0Nk?=
 =?utf-8?B?MjArWHQ0UFYzbkRMaVJjUk1wKzhvVVNtUGhpQitZbUZMdHVya2VKM0tqaXEz?=
 =?utf-8?B?RDhyRjl6anRuVVlKWngxY2NHK3lmMXBsa1AySFNiUk5pNGVudmtLM3k2UURH?=
 =?utf-8?B?Z1I1aG42K1o4eDZLU25WOFZnK3JXUXVsQnU5a3A2bjFqNXE5eWhIZmxMYWIr?=
 =?utf-8?B?dGY3RG9YbG1zNmJTRzF5SHJieFNTYTNjZ2pyMWZxYlNnOWNPVEJuYkVaVTdv?=
 =?utf-8?B?ejV0OFZ1bTVVNlFYQXZZN2xlZW9ycU1KSU5rNFFVODlzWTlhc2dXbGU0SVF3?=
 =?utf-8?B?TWxKd0Fwb2tpMUNISzA4bWg0OTdZcTRFdENhMElQaGpnUzlNUjVCVEpIM3h0?=
 =?utf-8?B?QmFUNENUQ29SM09neWRpSW81QUphTEVrK014cXRhcGRnK3hmRy91Q3YwQXMr?=
 =?utf-8?B?U05vTHIyRytZMy93STE1WVYwSWZGbjZVMDRCU3M4bFVOZGVjZEs1N0RLSlBL?=
 =?utf-8?B?elgzbmhtVnl0UXNyQy96czBSUDVTbENnWEtOdnhNWEw0UTV1WTZiSUxzZlZJ?=
 =?utf-8?B?T1ptc0xScFEwNi9mY0lFSFM1L0llQU1jR1VyN0I5QnduMEF3aHd0L01ycW9j?=
 =?utf-8?B?bHRQS0crcGNNUHpBQVNndmc3Wm1FZkxDdFRsUzJkdU5meVZMQWFoVVpwU2pt?=
 =?utf-8?B?MWhqVzhSdVh2bUo5WlNLVW40L0wwZFJNeXl6cHcweWtZUVd6V29NUWtsWnlq?=
 =?utf-8?B?Tm1DSFdiS2ZrRVlYeTkyNzEyMjJzWE5uSWlvajBscmVocG9uMTVTNW00R0h2?=
 =?utf-8?B?VnFDM0tGdkZ4UVNBamVqZHBDbHMrU3orMmlWZnlHWEs4dTVBT0dxZUtzaWV4?=
 =?utf-8?B?NElTNVI0RVV1ZnBPemRHWW5jQUJIM1AyUk1pcmRUTVUzWXFLYVNBNG1HblM4?=
 =?utf-8?B?Q0dTdUhFeHFLdlp2RUg5a0duaGcxNUlYL1ZUUGFPNnUyNWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjVGL1RVc0l3THFTWlp3a0VBZFlvMmV5QldXT0U3emZrQWE0dXlBc3ZoSnFa?=
 =?utf-8?B?S29ienR3L1VvWTN4K3h1RW15RzFFeU9ib1d0ajBqOVdaM3BNM3ZHbFVMTVhs?=
 =?utf-8?B?Sjl2anF4Q3ZQY3drZnBVT3lKYjV5ako0Z0pnSFpScUVsMXJsN0FMTzJ5VkJD?=
 =?utf-8?B?NG5LTDN3Vmk4QVJpVXlHSmVrSG1VdTVTY1pwM2xwYVFDYWJRa0dWWHBJMjY2?=
 =?utf-8?B?aDJNTjV4YXFVampic3Z1OVEzTUh0VjFGa2hsZStvVW16VVdTK3hvam1rUWxF?=
 =?utf-8?B?UXFuZUJhYkRDK3JZSDZBY0ZqREYyUkZKN0ZqRjZhdTRNTTQ0bXh6VFk4RCtP?=
 =?utf-8?B?MngvT1lVbTMzYUFWQTgza0NETFNRYkRtNWtQQU1obWpvSXRVS2tXc1NHTlZO?=
 =?utf-8?B?cjdqT05wMHRrNzBoRk12SFRZN3k5M0Y5eWVMOHg5aDZCcGpHeEhjbzA4a09n?=
 =?utf-8?B?RFhHZUtockNPRzFrbnArVHJaZncvRThXRVJpRVN2MWlkVzR4MkZuYVB1U3Nr?=
 =?utf-8?B?Z1JXb04wNFdoQ1FXVUF2YjBiVWpDVkd6Wm1XdTVVQnFrQmNaNzRFVEgzUFNX?=
 =?utf-8?B?b25Jb1NTa3dJeHllUlkwR1U4M2FkVGZBeWxRMWluWkIxYkpuOU1wK3c4YTg4?=
 =?utf-8?B?S1V6RWx0YjBEbFlzckoxUTR1clRyNU92bDBBeFEycXdXSFIrM2dWWXJGUFRP?=
 =?utf-8?B?YUFxN25KOFNjZEwzaytJUVNST295UUVmcE1nb2FhVkRhZEF1QTBVMU1aam1C?=
 =?utf-8?B?VHUyK1p5WmJmWXhpZmtDVXo1aUVaeHNxdEZmTHdLSEFheFJDRVRBcWppMHNQ?=
 =?utf-8?B?b1RwUE5kYVMzZjcvQ0o0OVpQYTdZejVNemt5Wkg3VTA1WXhLalhMZzJpTHBj?=
 =?utf-8?B?dTA1Z1ZUQ3hraUhMUlZlQTBmM0Q2M2pOTy9xUkZhNG5HUXFWdHBTUWJEbDZ6?=
 =?utf-8?B?Z0paN0xXVnpqUGFCOEc0dVJ2NTBGVlA0eFRYcEN2SWIyUjNLc3RoMy9NNk5t?=
 =?utf-8?B?amQxdkl5SFZBQVFyM0lYLzc4bk9BaTdOVXdsdzhrSEV1MlNzdFpDTzFiWlc4?=
 =?utf-8?B?blRnYUFOS2docHlBTms4QUswTDgrSnA2NHdBaG9vWm1vUDVBa2N5NFhTWGcz?=
 =?utf-8?B?MUc3bjZBWnpDK2Q0WEZQSWQ1azhYOWhnK1pQZFpSeU1Ca2RvNHhwcnJQb1pF?=
 =?utf-8?B?WTRWZWdvWFRreFVTMDZvN1lhay9lekoyVHJkVisvS3VKZDRNUXR6NDQyQXNa?=
 =?utf-8?B?TU84YVJMMXdHVUZqME9rbGNLWFhTRmRlZWpRYWNSZEtJVFhqQ0l0NFFIbHBU?=
 =?utf-8?B?ejhNemV4dncxTkRHOE1yWVRzZkpFaWFvNng4RnBYUFNaMEtEUWRzVTd5ckhk?=
 =?utf-8?B?Ri9SeFliS283Uzc2bDhPNFlrNGwraWhLb1VkMXNEMVpraURYdkVQd09rWmhq?=
 =?utf-8?B?M2ROYmM2dUJDWWhuakpTVUcveTJqQTJVQXluZ1dSNXR0aDVxeU5QaE1KOVEw?=
 =?utf-8?B?NVQ4cWxKSlI2U3FkQ0xPbDRUdWxWWmlIQS9EcE85Mmg1RlZXS05FUkRvSDRv?=
 =?utf-8?B?WTd5TVQyZExQS1hwOGUxN1RLL1hqR2NBUEg5VEk0dWlac0hBTmVzSEhqdzMv?=
 =?utf-8?B?TGFnMjNyOFFBS0ZiZWlnN0JSQmlwOEZocWc4bnFIYStxbmdqNWhzS3JOR3N6?=
 =?utf-8?B?ZEJKb25uMEdRRXNJQlJuZTFORWtpVmh4dEt0WER3Y0dQUVNIaVVWVng0cXYy?=
 =?utf-8?B?c0F2KzBEbUhRTGx5NVpoOUI0U3ViMjZNU24xeWlWVzBLQlJSNXQzUWxQck9X?=
 =?utf-8?B?UW1jY1hhSDN0UjcxTzJYZ09iUnVSNDF1a1M2VlliZER4UlpKNWtQZmtsSS9E?=
 =?utf-8?B?VmJIRW95Uk04M2JpQnZJa21RQUNkU04xQTh0OU16MkR0Z2h4Q09udGZRVUxS?=
 =?utf-8?B?cldvNDllUGZudXI1VmJPYmpxSUtzRW9kbUUwR0RaRkZGVlUwZXVlSEkrWFZh?=
 =?utf-8?B?RzlzOVZQM0pYMDJscVRtQ2ZyMWlQd0NVeVQ3VURlRXhNdXVscTFvRkFSK1o3?=
 =?utf-8?B?Q2hoMlBuNjN1L1dKSXZSb0pmTWFuWE5IcGNEZVY2bkZIcnhYQmZhbStCZDZQ?=
 =?utf-8?B?anlhRFRZUzhQSC9FR0Fac3piN2JHczM5SGVsb1Iyck93TzdYcGJLT0RvUU1k?=
 =?utf-8?B?dHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 07457a41-456d-4d16-6329-08ddeaf315ea
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:06:33.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FnkwPi+keWlG3ROzhOECqmzSrsYE933OycvVhASE5Q+4QMrNl04B607wyFEOVINgssWj2haAsQ2lUUbmVjfITfQoEoICsSNkrVlcLieA2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9308
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 03 Sep 2025 14:06:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2121

Hi Trevor,

On 9/3/25 4:02 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> oe-core has dropped this recipe, therefore drop it here too.
> 
> Link: oe-core: 7c86172b7353 ("xf86-input-vmmouse, xf86-input-mouse: drop recipes")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

