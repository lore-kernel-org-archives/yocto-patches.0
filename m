Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE72E77188
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 13:05:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.23])
 by mx.groups.io with SMTP id smtpd.web10.104982.1734527096527363312
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Dec 2024 05:04:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=eYD+k4ka;
 spf=pass (domain: cherry.de, ip: 52.101.65.23, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxsgC2J7Esco34mU85WdoLWmWSnX7OezXxbw4mj53ONJJp64RDDQeZkBSsK17az2H/ZiJ3h/EdxSCzc6Bm7ix/Uxh/rm40C/IZN2XUUNDw9THczUChIhYKkGrBrUtGyognCuzlIPAZsQ9OJDSnsi2cv6vhiTJ9FzeCx7vviOHQWdbkYAV1uIcU8ty+YsdK19AeMyVOhwaK0ued6bpyGBjsGyvRKnktaWnxpxB4TKnCtJ3S2R5j+uNCIyKFvQNMFkT4lAvJK71/5Ad6PyNfWJn39hAlYFCYiaODSZpYUByPQYERJNFQmQGWDMC4k5YGriBdRX10cxBkDLmWXyshn4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1a9fWHi8pshIT53ZFA3+fngVQoLWtLmLPDt3VW/94g=;
 b=RHO/hAeUpOK7cBkF0pRQFL1WFPtLfPu416cEnm86cpcBaSVm6+5PYdvjkUrGDsTdEh7wumO++Kz9HIcuk7jpGb0nblxH3MtFoSBTLji7m5GZODABw73KatUim4Lc0uLzmVjXGkRfYhk7rsqPRvTa8SUbOE9ajeMoMEbI2siYQwFkJFGFHhBSo7njcivtq49w1WfX06de1Yow/zgMd2luICebWXbkCXnC1vsfITjOFMG+bYXMVWSvri+lrzUIq7JfxSWvsxc6HBDekpuG7/9kQcpR1nd/abYELUMNGWvr6Vq1dBComrpYp5cEVVmCln4Cuq3B0kd6Psm8DoU8wAAqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1a9fWHi8pshIT53ZFA3+fngVQoLWtLmLPDt3VW/94g=;
 b=eYD+k4kaYiZSkJq0tprt28ApSydB+VQr5LII/ynY3kBpScKGDNOddgywp85NuuvwcqoZLDYd0bZWnU1s+oPxgbf+f6AbRruBAA9pFEPE3bDhzxocJ9KJi6LFRowQqDCcuKW02Qie6JoPc7MRYxHyp2rI3SExj3/aoUpcDSxhZLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 13:04:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 13:04:53 +0000
Message-ID: <f2b42311-0f36-4f80-9878-8b2f16e44bbe@cherry.de>
Date: Wed, 18 Dec 2024 14:04:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] add Quartz64-A
To: yocto-patches@lists.yoctoproject.org
Cc: piotr.krol@3mdeb.com, maciej.pijanowski@3mdeb.com, twoerner@gmail.com
References: <20241218104557.45036-1-daniil.klimuk@3mdeb.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241218104557.45036-1-daniil.klimuk@3mdeb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: e18893a4-5573-4d51-2b09-08dd1f648ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vlc0Q0hFWFpMYTIzVmJ0aDJLanBIK2FNcmdVL3dYK0ZaYm4yZU5Za1Vzb2RO?=
 =?utf-8?B?eHpvdkJNZkZieWtCYWYrU3lGYXRuR0g5UVBmTzVIVHRwN1ZvNmF1NEgxUEpO?=
 =?utf-8?B?R3MzcS9oNCtrTUN3d2tsQWhLeDd0b2RzR0tGYUhOZWNFR0tZY1pKQmZEN0Zw?=
 =?utf-8?B?Y3BzbG52OGVtblZEOENRc3lXdHlmQ1hPWlFjN0RyNjRITHVaVXdtQXArMDZJ?=
 =?utf-8?B?dnEyb21zMG9kN05idGFjZXhsWEZqandZR29yUzl1Si8rZzN1c2lVelFMQ0tL?=
 =?utf-8?B?Q1NPZEovalF5dlJ1bE5OY3NnWlhZSElReUVuMmM5TWNDWUlJajh3ZmROL0l3?=
 =?utf-8?B?V3c2MVJ4K2ZXWGZKNjlsQUR0a1MyUlBNNjJJQlNqK3ZHUFVQTEd2OXNYdXM4?=
 =?utf-8?B?K1hyQjFLWUV1RlcrN3VzV2UrbjIzekZSTHQrNVhicE9FM0VMeVVneTd1NXov?=
 =?utf-8?B?MzVSRGE0cmQvS3pMaTRWdWpqUmFMMURNWFp2cWhESjNxVjk1YW8xMU1lb2ov?=
 =?utf-8?B?QkZKeHgyVnRNbnRnaHZjQzRWc3I0ZExYREZTenlDekZPQ0VSbW5RUzN6eEZ2?=
 =?utf-8?B?M2hrQkNvakhSK2x0RFZaS1c5dzJyVWxiYkVEQkoxWGNNeEhYQmZiNXZpbGpi?=
 =?utf-8?B?S2pjSXhiVmJ5L2pUQ3ozNDcrdE5uNlZQcHk5cEJ1ZGpUNnYxYWNpaEdJTm9l?=
 =?utf-8?B?eGt5ZUh5ZGZlbWUvZldjY1lsdVUvZGwwVmJ1aTRabmROUU1Ta0xCV3pmQkNs?=
 =?utf-8?B?bXIwUWkxWkJrYmdISllzc0RTZUpOejg3OS9SSENQZ0JiMW5JKzJuaFkxL0J5?=
 =?utf-8?B?TnlIV1hneTZrMGVRN1VTVGFsZUo0d2FGSE9RYmlCY015aFIrWTV6ZHNCVlRI?=
 =?utf-8?B?aFVrN2ZRempJTHpIekJBdnk1RjRHaEJTVXdSeGwxL2VVRndlOWpoWjhkZ1N1?=
 =?utf-8?B?UytOUEV5MlJWYlV3M1Q2am5GVWEybzl0WElHL2t1cnhnVTNFYUljK0xuRG50?=
 =?utf-8?B?RWU0TlJWWXVhRDVyODhVamZ6TWxEQzNUb3ZMdlVNL1J2RkozdlVLWG5JRzN0?=
 =?utf-8?B?VEJOTURzZmxRTHdkWGlVSVlyWm9Wc3l1VCsvMDBOY01TekQ4aXNQVmhydm44?=
 =?utf-8?B?RWxxSUZaTXppVDNoZm92ZzhmZlp0eldOcFh2RUJqQlFyWDc4SjNCd2c4a0Ft?=
 =?utf-8?B?SVUxenErQVlmWk9WMTJqU3F4dzRLTTNGdDVwOUNranpkT2NjZVdYY3pvLzE0?=
 =?utf-8?B?WnVYTDVacHZqT2xpaVhtN1RYR0d3NUx3R09zUzFWbG4yMjRRSk1RazFhQ1F1?=
 =?utf-8?B?UHZDMTh6UmJFb29PaDJIWThpUVRHTkRYV3dwbmxPN09qR2Iyalg3L1NxR2tt?=
 =?utf-8?B?UjJYMkY3bWtiT3FGUU9XT0RiTWZPc0RyQm5YdkVrTkRrR2ZIeWFWQ1MzbndN?=
 =?utf-8?B?WVRDV05PTzMxRnQzcVV5YnFtc24vZTgxS29Wc2U1ckV0a2k2bFkvY1BZenRs?=
 =?utf-8?B?bmpjbk5xbThzd3NPTWozbHJZTVJUNjYzMGlSbCs2Y2tYWDRGdmJTM3hEOSty?=
 =?utf-8?B?c08ybG1TN1FOYVgrUnNlWXFBWmd1eitxcTliVVlGc09CT3B6enNxeTd2Nnh0?=
 =?utf-8?B?aW5PeWlraDN2bWJHcG1SdzFYZGxKaDZ2OXhkZGVIN1Z0MFBlTTNSUmhqVmo3?=
 =?utf-8?B?LzZSbkhkb0YxRml3aXlqdU0vT2VNcHpuRXE0NHc3YTdLazkvVXBnODgzU2cr?=
 =?utf-8?B?MGJ6a0RpL3JVSFhhUTlmUlFaNmYySm9EWU9sNk1DUm9NOHVzbnh4UXpRM3pj?=
 =?utf-8?B?dVNyZCs4d2J3RnJpcW80UHlGdHNZSHBia3Zlcnd0ek44V2JhNmJVbzNNUnhh?=
 =?utf-8?Q?4ICYAntpC9nQp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckk3MDlPVno2ZHRVN0ZjZU9yamEwVkduU3RkTXl1UVdpdENpVE5xMS9yRm43?=
 =?utf-8?B?NUFkbjdVd0MxaWw4MEl0Z2VNRCtaaWc5bjZPV1YvazVnVTRuMDhYbEtRbCtQ?=
 =?utf-8?B?SlRKZ2pXSW9naFZiOWl2VHJXZXhqUGYvQm1qQWlNWHNqei9ERjZQdFAvVHRN?=
 =?utf-8?B?YnQ4WjlUbkN3VERBdFI0Uk5vK2RUTkl6ZmRGbDdaTG5IZVFIS3FGdlVLUllK?=
 =?utf-8?B?d0xUVTBRT0ZLcGMwVzBvVitpbkV5TllQYzNSMDgyQWxVUkZ0UGFld25EWUxN?=
 =?utf-8?B?aFR2YzdiRCtBZStFMGxyY2c0RDRpNEhmT0hOQllHVTZKcDdqa2dlbmw4UzFE?=
 =?utf-8?B?ZmtDLzdYVEdMMDFVb1dtb2lzNSt1OFc2UHA3T0J0OHBkM2lrQnhLVW1aOUNR?=
 =?utf-8?B?YjRhNlJ3VUtmZkkxSmJNQXFMWVdBMnU5M1NacTZud0lNTFZDVWh1NkRwTkhu?=
 =?utf-8?B?RStPVjJGcnZiU0hnazlVR0xoMTRVQjhCc2x6SDh4eURMZUhRNXBKOWc3THY2?=
 =?utf-8?B?OHVGdVhoTnAxVE9UYzhyRXViSGJSTTRKTjNmQ1FiYkkxNWFkMU56dFFoNmxv?=
 =?utf-8?B?dmVIb3JkS0JuOFhwVzgydGdjaStQdlVnY2g1SVVwb2tzeUg0d3d0RzNYbGVn?=
 =?utf-8?B?TzBFTVhjd1lwQVNaSjY5QTh5Y0NxWm9oaE1qa29XbWlSLzc4S1ZxNWVSQmVk?=
 =?utf-8?B?UUg4VUNLVVBydjkxVFpvcmVudWV0alZ4b2lKTU5EdGFtZk1IbisxNkpOWW0v?=
 =?utf-8?B?UWdEenVvZ1hZZno3Rk55SHZGVmdmRkd0VDlham1Rdk52VVZDbkszREdKTG1r?=
 =?utf-8?B?aCs2amNoRzFrZUlXcDM2ZHFkM3lCYXJ6eXYwbks1RWR5VXBHVjZEdHVwelJN?=
 =?utf-8?B?UlpjV216SjdScVczSlNoeTdmMWtmd2pMQzludnAwVWlPTjNudURqTk5kUzZp?=
 =?utf-8?B?S1RzV3UzT285Ujl5aHRBZjRMUTBScXEzZVFZNTdEWU9BazgrNUk5Y1lKN25L?=
 =?utf-8?B?a2gxYkxISVo1TTZQV09YSmVwajNEY29CVElGV0VMN0lyR2pmVVUwVkVCVHJn?=
 =?utf-8?B?Qm1nZHZEZmlxUjVVbjVDSllxRTRVMHE1SjQrVjJ1TEVQbXc1emRmTVcxVTA1?=
 =?utf-8?B?Q0thczV4NzU3d2w5eU9XY1RpcnNScmZXamFPNEg5TFloVjEvSDVqL1JsdEto?=
 =?utf-8?B?b1RRaVRRTTB1SXVTMzhNL3EyNXdmVGRMUmorQWNIWm1GcFl2ejhodldqdGl2?=
 =?utf-8?B?Y3pUTlJHVVgxbm1JTkdJOVJCRUNjMFVTT1J4ek8rNE8zUVBBbE1VOTg4OVNI?=
 =?utf-8?B?aGpKS1lObElnaWdpR2QzUlYzZ1JTMHlndU00ZFNoU0d2QlpyNWRZejlQOFBC?=
 =?utf-8?B?OHVoeWxjOEwxZzFaVUhGRmNtbi9xLzVUcEM2NU5OT1JNQWhVcTBKVC9TTW93?=
 =?utf-8?B?bW1qMWhYQjJVYmZEMlJKVVRsMDZUNzI2T09yOTRaY2x1cDVqOTdjNUFZZmxL?=
 =?utf-8?B?aDRHTmtCQjlET2NQeEVQMklUbFdMSjZkWE5kekdxRWJPaW5jcGZLUWNqRDE5?=
 =?utf-8?B?U2FoWGcyOWNlcFFBcElmaWUybGFoRFExQnhHUTRoK3RiMW5LRHRGa0lYeXNP?=
 =?utf-8?B?YzNzSFpwaGd3dHB2RFR0ZktsNWJxVjFZOWFsNGpPa3NORkpZL1RTMXJ2SkJB?=
 =?utf-8?B?dnppZUhmQU5kMS9ib3M0WXVpeXVRMWs1OTFyWVJlYnc4UXpJeUxQNmQxRUhX?=
 =?utf-8?B?dFZVNUJjSTF2dXpWY1h1c3ZUN2ZzK1UxWW9KTGsrOE9LeHhWR25uOFN5NHdk?=
 =?utf-8?B?ZDV3bTNNYXRsS1krNHd4TzNLc09mWjlCTHRJekFwNER6WjNFMmtHdnhXQjJL?=
 =?utf-8?B?N2Q4Wm8rQUphZFIrbHhzSWd0MExIbGhkZm9zeXFsL056Z0lmVGdybmdocDA2?=
 =?utf-8?B?b0txUkphNVdHL1BrdlAxbEY4YlhqNkh5SXQrVG96S2hLeTREWWNuYUtoOS9l?=
 =?utf-8?B?Y25sbVpWSFQraXJTdVZhdHFzUTFpM0VzaFZOV2crQTdiMklnTDd4cmFyUUNU?=
 =?utf-8?B?eDQ4T2RENEhLc3JldGk4MlN1ZGRaV3NhMGVUR3RlTEt5bHFhd2xxVWtmU0F4?=
 =?utf-8?B?c0gvOFVwL0w4QjEwcnVzaGttWWpvaklxeHd5L2tUU0MvaE9CVEtNUkVHYXRr?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e18893a4-5573-4d51-2b09-08dd1f648ff1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 13:04:53.0055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgw0Tt7gdquQt5wgZSGUDJiLrwboOBY/AVcoR7lGOtqOrb0HVJVk/WJQSQoKNMIrD2EbbO4Nd+mK7XksQ13/PMOFkOr0em2WpPujCE2OIus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 18 Dec 2024 13:05:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/936

Hi Danik,

On 12/18/24 11:45 AM, Danik via lists.yoctoproject.org wrote:
> [You don't often get email from daniil.klimuk=3mdeb.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add Quartz64-A support.
> 
> Signed-off-by: Daniil Klimuk <daniil.klimuk@3mdeb.com>
> ---
>   README                                      |  1 +
>   conf/machine/quartz64-a.conf                | 13 +++++++++++++
>   recipes-kernel/linux/linux-yocto_%.bbappend |  1 +
>   3 files changed, 15 insertions(+)
>   create mode 100644 conf/machine/quartz64-a.conf
> 
> diff --git a/README b/README
> index 4c75ac9d574d..4c50786433d5 100644
> --- a/README
> +++ b/README
> @@ -47,6 +47,7 @@ Status of supported boards:
>                          rock-pi-s
>                          rock64
>                          soquartz (on model A base board)
> +                       quartz64-a

Please order alphabetically here, so before radxa-zero-3e.

Otherwise,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

