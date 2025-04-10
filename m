Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405D6C3601E
	for <webhook@archiver.kernel.org>; Thu, 10 Apr 2025 11:01:40 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.33])
 by mx.groups.io with SMTP id smtpd.web11.31828.1744282890861408799
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 10 Apr 2025 04:01:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=EwNbhLuS;
 spf=pass (domain: cherry.de, ip: 52.101.66.33, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIJ0WGOK2f69LdQnK75qrZ92i8f+hC+dGB6iiu/ZQgfxuyx5TkOOhU8gUVJEOzafHcM+GAoAVLseDSvozIJtoFgGK6drwbH+7uSnuH9sJMr6PAv3d2huVjbQzRRzj92flvzEj0WFBGThmza2LXaAFy2eY56VvSzuY47a2+yZ5AIAoPJM9fmy7CjAOH28rWYW2pNiaWXY6QJybiA4EJL+cFdbRS9DrV+DizafuL5bpFCrMHhjxEQJYIR6GW1I8droF2XkdT+UUA+HkaM6FLSdnUwxNY2tMZs/ImuNoYyUcEwEYoujzktOu7k3U1TJgaAvklJJA2efoSKYZBzdKGrW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8/c5z7/r5ZfzDd8jGQsZkCttX86LM7uy74jlXglPGA=;
 b=qoCDe273NfQbmw1CuxWuLdZpkc9/nelhXhmfGh2I9GrFUJUDPJPOofMI46+J3YlP4q7acojXjPETV2mjvtEIJ3Q8/YssoiN1EPoJkaONEltGPiGWejMjYnYUdpBmqodMSFBoXjE7oeL7hCC7d13Mw62XHJa7n7Xh+jFvt1sqmTI6RoF4HQPlWSOuHSE7p+M+QrJ15RPGyFdn2kpr6lZ0rlpchoZHa8UI3ughgXYcvxsslL1LeaEofwHuqrFkZ7z4wk1/lybM1gP/AV2EesnghCXuq7CDbQ5Bq55bZ44pqznHKyGFDlfklZobFBlTVQMsUZpG+4E7T6Z81Vr5wIQRHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8/c5z7/r5ZfzDd8jGQsZkCttX86LM7uy74jlXglPGA=;
 b=EwNbhLuSxRWpmENa6FDYpQjMVhfxSCq9egsVnnncfvLsL9fT+X23uRRxUjNZzY9VhCkEiE92hpmliIwxq6eUeesjxHQfZPLLSxGozcv/LOW1+hF93nisI3C8iXeODlAiFkQ0IPXTKxiTrn5PM3+4Xwi5jMJfQx/e9b3saIq7Lgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9643.eurprd04.prod.outlook.com (2603:10a6:102:241::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 11:01:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 11:01:26 +0000
Message-ID: <220dfed0-d11d-4124-8bd8-ef221850e85c@cherry.de>
Date: Thu, 10 Apr 2025 13:01:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 0/6] rkbin: factoring ddrbin do_deploy,
 customize ddrbin and bump rkbin
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250311-ddrbin-custom-v1-0-e5c994ac25e1@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: b5339dea-9092-428c-fe01-08dd781f0a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZnQ2UjdKWForK3JzT0ZadkY5WFJBWUg5SmRqWXZ2dWVHQ203T1NYQjgreTln?=
 =?utf-8?B?V1dOb2xGcFpsbkRkY3hidnBOUFhtOU1sTTZwdXJwaDZ3emFpdndUY1h2SlpM?=
 =?utf-8?B?UGdrZ0JKbmFEc3QxTVdBQk1leXBWMDlPS2pQNjI5VCt4cnM1cndYclNBZXVx?=
 =?utf-8?B?ZEUxQzBMVU00WnZlbmZ0dERXQ2c2R1VUYTRaNmEwbEQ2QXFwV29wWndhSk44?=
 =?utf-8?B?Z0JyRU93R0syY1pTWTBoK3BIVmptZWxpL2VoT01TK0lqUTRIbmJCNUhVOUpY?=
 =?utf-8?B?NlRiQVVmZGc2b0IyS0RjdUtrbkE2Nk9tR3FON1hrUEpVK3MzK2lvalRtSUtl?=
 =?utf-8?B?Nm1lVXRGSjljYVB4V2dWbmQ4Wmxua1JheElwd3U5eVg2Q3kzcW5LQVgrZ0JB?=
 =?utf-8?B?eE40YytFT3I2VFl5MFlsaENNU0J4L1djRWMxQWlwbVpiVzFkYlBnVEZkSlhD?=
 =?utf-8?B?L3BpcC9XYzFzMXl5bTM0Q3JrelMvR3dZRExTTnVaaVJoVVBiNDFJWHVyWmdz?=
 =?utf-8?B?bnh4RmU0S2wrNnFkQWNFdU9Qb2xmdVpaYzNQcE1ocFVmUWJDQisxT3RmZXd2?=
 =?utf-8?B?dXpHb2x1VThzbDNuM1hqTzdDYlJPdDdHK1c2U21ySlRSWTFBMnFhdkh1TjZS?=
 =?utf-8?B?d0ljNDZTc3ZyczRzeVROTVh0V2o2Tkp4RUdQUUpnOCtQYUJmU0FMZFMwYmpq?=
 =?utf-8?B?anlGSGdHRFhsN0VuaVIrQ0llaEl1YjJWaFVLR21VQXFRODhNbzk5UUpiMG41?=
 =?utf-8?B?SHRnSE5yaHFYSVlORUt1UXBOTnBvWkdqWkdpOTJvWXh4bUQwUWVBL216Smtu?=
 =?utf-8?B?NzBQcmc5dVhBTzd0L2pSNlRJQlVDV3Z0WE9UTFk3QnpyTU5zVmRobmdUblYr?=
 =?utf-8?B?d1Z3MWdDL0swNGFzUFBwVmZ6dnFVcC9vNjE2ckVKVHJiWGNZSDdqWDZEeFpx?=
 =?utf-8?B?eWN1SFlIcXRIaUUxdGZjbFpPMlY2M0xWU0F6ZkpRczBwMHY4Z04xVzJvaUxY?=
 =?utf-8?B?SENjMFJ2Y0ZSZ29zNnk5akRTd3NsRHhOR0RITTh1UHpyUER1UTZZWW93SGJp?=
 =?utf-8?B?NU1MdGJabGZFR05vUndSR0t2V1Bna3R4WW0rbmNobXVhMWF4Z2QvNytyU1d6?=
 =?utf-8?B?bnVQK1ZiRlpEdjE1Q0tDemM5YTZiNVYxelI0Q0hqUnZFSlVZZnhwd3VqNTl5?=
 =?utf-8?B?NGxKenZKS3ZhZkRqclRaSy90ZzRlOGI4KzBQZ1JPdmtLZGxnR0FvczFBTkZy?=
 =?utf-8?B?bVR0alJycWt1bWY2MENYckx0bkJFTWR3K1YzdXZtWFZjN1liMzdtVlZqdnk4?=
 =?utf-8?B?RTdMcGpzc3RtNTdmNU13L1VTQ2ZIbjlneVpmakJmKzZNNElhWGVSYWE5eE1Y?=
 =?utf-8?B?eG5XVFl5QlM4bzVoNi9vditNYUMzMm9zQ1NPcXd5SFY0ZFZybUwyRWEvK0pJ?=
 =?utf-8?B?WjAyWENtME50cFJYT0IzbitOQnB5WkgwVXRoRENENnVtZ2Z6OGxOSUl0Ulc0?=
 =?utf-8?B?alNsT3l3N2hiQ0RNd1hPNS95SGM5R1NLYUYvdHo2VnBDbjkxRzZsRUdZSDIr?=
 =?utf-8?B?M2N1bmFRNSs1bEhVTDFXKzlqeTRpb1R6dTBhK2R2QXBtQU9QMlNSd09HLzlW?=
 =?utf-8?B?MVZvNGNNMUpuR2xqMkV1Qmt4SVdKZUc0VENqT0dTeVpCWW5oVVhkTXdhYmFR?=
 =?utf-8?B?cnlKaVkzMmVFWmowOGZWci9xV05UTlowdzRTZUxJQUs1VlZSZUJ5aHRaMFE4?=
 =?utf-8?B?eDFCSWdMWjV6Y0psVGhIQ1RmVStJSWpkd21vTXFQdUM4MW9IWGFabzhNSS96?=
 =?utf-8?B?QjdTSnpTYkxyT013WlRiSERmUVhlV2NJYzdiWXpJZmVTMnVjU2FNN3Z0MEFC?=
 =?utf-8?Q?EQZtrB2wAaOv0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWcyS2o5VlZmNWpTUVpFRURqc3V1czZJQUNOa2MxYzJGcERxTGVXd1hXS3M4?=
 =?utf-8?B?bm53WUhCb0Yrc2IvU2xvVmVGZG1iWTVHSlZKa0ZSS0JuYXduU05iMGtJMndj?=
 =?utf-8?B?cnhiWUNFNWtnZkJPMWcya2JNbUQrZUlXQzZ5S1RLZXVPQXRtQXhnem9zalpR?=
 =?utf-8?B?YzUzYldWSlRHcW1LNTkvU05jbGdiZldzWGl4VmpubU5IWWp4MjVCTmwxS2h4?=
 =?utf-8?B?M1ZSZ0U2TnltR2NLS2E1aXNqamJzNTVad2o5V0FVdGxuNk92NFRpSFRMODZO?=
 =?utf-8?B?SEJWbTd2alJvbmRQZTgrTGZIY0Y5NXpSNnZNclN5bWlkelFmaks0M3NadVNa?=
 =?utf-8?B?Q0F6S1pxdDFla1F1VTMreEZzZkYyYlpYZUE1ZitoN2FpSmxFeG1IdjVRS3dK?=
 =?utf-8?B?OGpJSkNSNzVYK21rak9uZEM0QjVhT3lGbWJWbEtqR2phRER5VDdKZzJaWUpu?=
 =?utf-8?B?cW5jQWJBc3pqK0hUMERmOG4xbmkxNTJyOG1HZVhtakc5WVVEVHlmM2hCcGs1?=
 =?utf-8?B?OVJEWWc0alJaTmRNSDFYSmZHQ3ZiZUxSRU0rTVNNRDFySDgrNVMycFc5TVU0?=
 =?utf-8?B?bnVUMnZ4cDlpamI3M0dmVXFCN0lEYWpkWE9nZUZiOXhlTmNxanR2TUU1TnpQ?=
 =?utf-8?B?ZjF6cVVhaHlaTVN3L1pFVnA1WjJzZytlWWNOanZXUUg4VWxZdm5vMzhwRFFo?=
 =?utf-8?B?eWNxc0ZWSEhQbUpSOUlyQzl5YjJQa2ZNMG5iZjFyQlpmRUdPbC9DWlBZZWVs?=
 =?utf-8?B?M0x5Q2d3VlpwY0RIOXM5Nno4K3VxYUxDK2Y0T2NmMXFyVFFTbHp6MkQzVk5V?=
 =?utf-8?B?SWlkNklJOGVLcTEyb1c1RnVhWi9xeXNaVjZXYXpzbVhQdWhvZ1NOOEdZZ2Nh?=
 =?utf-8?B?YkhtdERMTHQwR3JNRVRMd0pEaDRWSGZTQWlPcnM3SlExNUY5M2RucVl5ZkVx?=
 =?utf-8?B?UmdzYmdnSEQ5b25vMHVaSC9DeWQ1Q0hGU0wyN1FFVXhIU2RtbTRVM2I2U0Vn?=
 =?utf-8?B?OE5IMVZiY1ZVdmVRU2pkeDg3WExiOW1XRkF4c3JaZkFCV2RmNkU2T0xJdUJJ?=
 =?utf-8?B?VlhCTU44NXBIZXcxdDZzTXE0c1lYSjlMTlpsZUFDQzNDYVVCdFh4OUpSSUd6?=
 =?utf-8?B?di9YWHc2ZE1FcmJnK0RPeVN6RVJPRGN6UGFNbEFZT21MYVJXdno1TXhsa0ZX?=
 =?utf-8?B?THE5U1N2NWtWdU1DSkhjNUV1bW9WanR2eU9heTh0UUhPUVVKNUtZWERQVGRa?=
 =?utf-8?B?NlV1VzFLNGZEbElaK2VBM29zNmhSNWVNNkc4M0Qxb0JkWUtjemhwL3h1ZTFv?=
 =?utf-8?B?NFVOcTBQVDlYVWo5NjBxMDJYR3dMWU4zdFRTVUkvYlFoRGxDOWRScGZWNmh2?=
 =?utf-8?B?NHZ5cWlDaFBZdlNydW9HSHhXN0dzUDJGOGQwL25OTkVBS3c5YTdQcTRMR2Z1?=
 =?utf-8?B?TzREQk9VaWF5dXlibzl6UUhkVnNtZ09tNFI5K2YwRVY2MWs0YjdTU25rL3A0?=
 =?utf-8?B?a1hmZmVQZWRpcHFxcXloUCtIdWdLS1p0eXgvVzFZaTlJeGNyQ09VaERzVmJF?=
 =?utf-8?B?dEtyR3J2Q3pWay92WDNYQ3FRTU9WVEFtR2R2dzNWeXRwWi9MenhNRnVhTWg3?=
 =?utf-8?B?T2xpTWk3YVJiU2huUHlYYi8xMTlHUnhPRVJiVitFazRWMGVqTWRZT0lmVnRx?=
 =?utf-8?B?ZFdaQUYwWDRXeVRXSnl0QklybzUxTUpUWDB0eFRlODB4SWdkdlNpOFY0Q3FG?=
 =?utf-8?B?Y3EzU1dSWDN3SGxCWmlhUHF4UW9iMDRHdVpBVDFJc0Q5Ykw5a1FVS2Yrb3ls?=
 =?utf-8?B?YitjQkErSzE2cG1rQzB4Z1RtNkVIbGZBck1ac29RdWNhUzlxeWVYUUUzWllK?=
 =?utf-8?B?RnQ3bW5MVDN6NnRQcVVqb3BneVZCcXdlbWYwK2ZDQXdIeU9iMXdHR1B1QjN6?=
 =?utf-8?B?YWYwUDNzV3JqQitsekhMb3JxVVhZcVYwaDZjUTYvMEQ0SGd2ckdtREZUMHlE?=
 =?utf-8?B?Mys3bmltTFEwOFpGMmRHNlIyaVAzNExKWlRhL0VSUC8xYTVqV3lKRk9ZNVoy?=
 =?utf-8?B?eTJxSngxa1B4OXBkTjlGcVA2Sm5Tem83dWpJZE53cWlsaEJ3L2k4UDFWaXlh?=
 =?utf-8?B?eHJLMXFiaWZ1NXFtVExzU1RvUDI5Yk0xWXRxU1NvRlNTeWt0M1JhanR0QXIw?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b5339dea-9092-428c-fe01-08dd781f0a23
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 11:01:26.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tYHJPdCD01DkFHWfomzEO2OzeqEDNPWGcFiSu0wDDBTt1v/CUrUsv/6+o6TvgnzYYhRiY8Opsxw2N44uy4QTDiqn0KRxRshPsX/NCC2GNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9643
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 10 Apr 2025 11:01:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1346

Hi all,

On 3/11/25 12:26 PM, Quentin Schulz wrote:
> This simplifies rockchip-rkbin-ddr do_deploy to only have one do_deploy
> task common to all supported SoC instead of having to add a new task
> override for each new SoC. It does require to set a few more variables
> though.
> 
> Additionally, this allows to finally customize the DDR binary blob using
> Rockchip's ddrbin_tool.py tool. This is typically useful if your board
> isn't following Rockchip's HW reference design, e.g. using a different
> UART controller or pins for serial output, or using a baudrate different
> from the default of 1500000.
> 
> Finally it bumps OP-TEE OS, TF-A and DDR bin recipes to use the latest
> commit in rkbin git repo.
> 
> I am not too fond of using a file as input for the customization, but
> this is what ddrbin_tool.py uses and there are possibly too many
> corner-cases to handle by using fine-grained variables. So for now, I
> decided to go with that but that is for sure not the only possible
> implementation!
> 
> Note that the bump commit wasn't tested.
> 
> Note that I plan on backporting all but the last two patches to
> scarthgap (and I assume styhead too). The patch before the last would
> break backward compatibility if someone appends to the
> do_deploy:<override> task. The last patch could be merged but there's no
> absolute need for it?
> 
> Lastly, the patch about customizing DDR bin needs to be modified before
> being backported as it uses UNPACKDIR which doesn't exist in scarthgap.
> The logic should be safe to use with ${S} (for scarthgap) though!
> 
> @Trevor, maybe you can check if that would fix your issue with the
> RK3308 DDR blob you wanted to keep on that outdated version which is one
> of the last versions where the UART you want to use exists? It'd be nice
> to get rid of the rk3308-specific recipes I believe :)
> 

Any feedback?

Cheers,
Quentin

