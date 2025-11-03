Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D0ACCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 13:31:11 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20381.1762176669070851676
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 03 Nov 2025 05:31:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=eHikGvV5;
 spf=pass (domain: cherry.de, ip: 40.107.159.68, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnyGKyCrS+k6KKxK66GftExTrIk3erbj8yzuWxQoOXuoxpWylnVAsRnBjbqv49X4LtTVsbDxMuSVjgV8aMYmTM8OYbnHyUJQ7ExpHU2rmVZDQyqVBJzFbyoqVwNvqU8+qh6LFFHYFV17X2jN0V8Imq0b512IrPTra8EszEJ6dg3fjEzeXu5m4D6wlhzgi04pQxlZ5xgLr2hJxlzC38p/cs9tAjctlXKV/l7z7oGcrZ1Uy5I09GY1qS2Iqkv0eSY9xvwmSPG8OVK1ED2UUSVZ3Rpm/0A8wY+vLZlIPisn6+Ef1SFVGaj05Ccs4D691q2ybiSevyps5QtmBp/eW6rUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUSb9ya+CWmkXIc1F2kddCaidQNBTotjUbNveiJrdHk=;
 b=huakIBEyGNqEMMbWKwK9y4ylUOrBOy7jjTe1NzLBE3hIt+0wFxYNoKmUO79Wv4VhRVZL2bo2D84XWYJhcCFzcfrb2IWYJtp1Hc/O4BHyxCNwHXf1oj7lIMjEK8KnGMDn5UdTPB31dHqVD1weSEv5sM53AgJ74M/4LyjiMxCpWBhxa8mUq5Ppz6kRrMiN/4Xe0C3pATfUz6GIJLancQ4bMazv9clnvKk/2XXRWJIlB0mjn7FwzOoU0jQg7gRh9KJgzzh5yiWGzwlnskUQZQfDrHu9OKvUWwxlttLdFPNpaWwVKNLxWAuK59/RDAolP8Vq4nMXojDnpKQyKeBmY7knCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUSb9ya+CWmkXIc1F2kddCaidQNBTotjUbNveiJrdHk=;
 b=eHikGvV56PzP4a3a9io1NgfoF2+Kvf7z9Cmiu/nmIMB3R/q7tw7/gm+nBlm1NmIXr6B8yiuLHfeL9w+e8+XXyOHlUvui3LMIYYHZJ8A+r+XV4LxyqV4rltkFSnESLIPppX9cDy9Df9bRHfLAmpTzmf+7jlTs6sdcAcD2gjLuDeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8433.eurprd04.prod.outlook.com (2603:10a6:20b:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 13:31:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 13:31:05 +0000
Message-ID: <1c51d67c-1c7e-4934-91c8-21a214027d1d@cherry.de>
Date: Mon, 3 Nov 2025 14:31:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] rk3288: use u-boot.itb as
 bootloader image
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, mustela@erminea.space
References: <20251102132931.228967-1-mustela@erminea.space>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251102132931.228967-1-mustela@erminea.space>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 0235f220-1bff-4eb6-624b-08de1add3d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aHlwdnV5Z1BsbHpEc0UxQ2hETmp3M0dONU93N09uTlBnOW1EalRYRzlBcjB3?=
 =?utf-8?B?ZzZIUVVVSUthdU9nSXV5Mk56V2tlS0Y3ZXJNa01mS3o5Qkxra3VrUUVwY2k1?=
 =?utf-8?B?RTJxVHFUTzU1RTZUYUxSVTJQR3QwMFV0RUZ1M3NIWnc2TDlaeSt1L09XT29v?=
 =?utf-8?B?Z3JTd2I4L3pJQU5NMU5JdFpiQlB1eFBhM1A1bENKV05NdG1BYTl3aE9MWFNT?=
 =?utf-8?B?azJ2NlVaUEIxS2twTWo5Q0FGU2htK1VhZDVwOE04WmVqMUt4dVZNL2l4QWxW?=
 =?utf-8?B?VXpFNDV1cW4rWFV5ZWxyMlpMMUJFOWZ6Z0ZmaTlTZ1RZbWFENkU0c1Q5em54?=
 =?utf-8?B?aXdwbkk2Z2daOGpINnNtb0pJdCs0c2JUYVZFZzN3TjJteEFRREJWdFhhamFT?=
 =?utf-8?B?L3NMYksvV3RsTjZqcTZDN0JQUm51b1VCb240SUtSZnNOdkhhT01ub2R6eVNL?=
 =?utf-8?B?emx6em10MWVFSkN6RmtvMGZ5ZVlRRW9UYXY3bDQ0SnBjbkorZDNzK29vVWRC?=
 =?utf-8?B?VWJsdTVaZ2Q3OEtCcWhQNFlnQmR6U2xqcXJybXFGckJBMmIyYWFIV0haV0Q1?=
 =?utf-8?B?VW9uK1B6dGRPNFRGVUlTdE1PRGkzckdQMjZmZkplWFBCandyZUwwcHVhVUJF?=
 =?utf-8?B?cjVhaHYvMUtrbDQrZTEvTjBraEl6RG9UOUVVM1REWlNIczc4ZHNYTi8rRlVt?=
 =?utf-8?B?OGJFbTRoSXpDbDJnNWFjUTFDMHgrQkI2cVZUMFV3M3NneEtiUkRKM2xtbEJh?=
 =?utf-8?B?Z2o5anpHeUFDanUzNGFlell2V2pJaU14V0VlT3g1UVVtdXhUbzdrNnV1Q3BV?=
 =?utf-8?B?akVUcnZoWHYvbmhHVVNQRm5rcnMxTnBtT1YrUEdiLzNjTC9xcjBIMEk5MzhW?=
 =?utf-8?B?OHdLZzBBTXFrUldqQytzcXBEUWFtd0VxemJNcHhUa3A4QlBoL0lIeDhFTW9T?=
 =?utf-8?B?dSs5cEZhbFVqWkE1OHVuV0dVd2xRSCtJNlBocEdFNWJMOGNTd0VRcXZtOWlp?=
 =?utf-8?B?N3h4aXJQSGxMbjVIMGVEZFRDNVhIRUlJd05EcC9vVGhSc1dMbm5SYjIzTDJX?=
 =?utf-8?B?aDBoR2ZwMzErRWNVMzI2WVQ0NjVNV1VFTm9zUm1zUHFvdmR5bTE0Mk5BaWJt?=
 =?utf-8?B?VTVuMmdFUFBaNTZPa1BuTE5Yb1R2R1RUcm5kOTF4NXBNaDBmRzhSdW1IUENE?=
 =?utf-8?B?UkR6czVoenFQa1NEcXVOUVVQcklsYmFmV1FDeCtjaHEwalA3SGQ5ZTN1UTJL?=
 =?utf-8?B?RVkyWmF2c2hyUUlpckFYMU1IRHFlaE1sQTdsTWJKZjAzT1I5d2Zvck1MZXp4?=
 =?utf-8?B?a3Jyd3MrSUE4aW1LV3R3RmlLaTFDc0gxbzFzdVoxZUhsYWNEWXBhbjk3Q0k2?=
 =?utf-8?B?aDdpUDg1OEpQaVhVL2NSb1J5SjBQdTVNSlQ2TWJSbS9MNUFwZ2VMVHJEdFhM?=
 =?utf-8?B?K0h5Y2gyeVJtc0pQQWV0dUdOTno5M1BWYmJCSC9TK2VpQkZJTUtwRHpDU3dB?=
 =?utf-8?B?NUpuMHByK1Fob3JzdUxaR29oRU85dkdUSDRiYU1FbVJ2UzhheTRtSDc5ZUVP?=
 =?utf-8?B?N0RTbm5GQkJhNWZxeFQzWDJrM2djTVpiTGU3TE5BVHAzL0QrbCs4b2RINXBu?=
 =?utf-8?B?RER1bG8xQnlUWmZjdzdTY1BnZjQvZTgybm85ekRsU0RTakRwRFAvRXJXdGFr?=
 =?utf-8?B?NUsrN0ZiNStrTDJCV0hiNXZ3dmhId1I3UTlWeVJNaTBLdjdKY2V5Mk9tREZF?=
 =?utf-8?B?VkhQR3ZXMndyTlpqdTFvM0Q2dUcwTXMrLytWMnZOSGUxMUMzMkhlOUs3NXJK?=
 =?utf-8?B?SVZGZXJPK0lXVUtTei9ucGdva1J3MEJtMTRSTmhPR3Fma215aG5Vbm5WK3l0?=
 =?utf-8?B?WFMyYjZxdHZIMXdNRlBhTjdQMkRZcmdaUTlPR0tBTzNGNFpTM0l4bWxPQy9q?=
 =?utf-8?Q?vMvb7jKTiCDC87i9d26MkG4tZijZjMzA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXVIUkNOTi9HOW5aNHJZangxZGloOXJ2WE5qbCtiR0xIVGVWZllGTzVrSVJn?=
 =?utf-8?B?UVlqM0FuelRsUGw4RHdEZXdZMEVVazRJRzBldUtvK3lwaVdVUWJXZXhFU2No?=
 =?utf-8?B?WUV3Q2JJMU9BZ3F0NkhuSEMrQTNvMnJoYThtL1VjSWdyd1oyazBIcDhUdTZH?=
 =?utf-8?B?OUN6dkhZM1VmK2dvOW94V3M1VHcwelZsRER1VFp1Uy9IMzNTMElrb3lCSHVE?=
 =?utf-8?B?TitvdG5VRnBXYnlHMHZwdmVkSzFrRHM4d3owSWhpVTgrYXdEWWR4MS9VL2hs?=
 =?utf-8?B?S1ZHaVdFcVRrb0swQ2hFNytJdHpORkNXZmtBMUZOY0tDU2RDY2ZVdThtcms5?=
 =?utf-8?B?Q1IvQjFmYngyaGw2UTBEMU5ZSFNEaVdrR09uckJ6TEl4TUdySnM0SmtZNXRU?=
 =?utf-8?B?TkVqWlN5bzFSenArMUJSc1RQSkNwNXdMdklkNncxSWdtUmZrbUxnSDVZUzhP?=
 =?utf-8?B?MXliR0diODI5UEt0VkYyOU9TbHZkeWZnd0NtZjZBK2laQUROYTZaZGZ5STYx?=
 =?utf-8?B?MXNsNHRoRUU3cWZkWlR5OG5ScDFuZHZRSGNucjZaMitvWHJxaVB3NlZ4M2pH?=
 =?utf-8?B?SzIyYVhTclFyRllTTCtyZGNwc2sxbmZPYm1KSDRocTdOa1RuVDdhd0xzdUZ6?=
 =?utf-8?B?MzdvRTNLZ3g3b1NGeVRKT3lmRHFJRXBEQS9BR1NHSHp3c2dQTHNJdzZMWEJq?=
 =?utf-8?B?QzRVNnpudVJtN1RCaDNUcWpGVDNoUDRucExLTDZQcjRYN3ZaY1V2YzlsSVFB?=
 =?utf-8?B?WEJwb2xPbUM3eElsWjZ0ZVZmcXJNTjJYUWZaOFBBVi9hQkhiYTVaSGNLazla?=
 =?utf-8?B?RFR5NEtQMitsWTBPWU9oZUpzNURZaHdHamNtSWw3NHJRTjFLWkdzbFJENTIv?=
 =?utf-8?B?NXRvUUxEVldMK3JaUlFJbm50ZFpNZnRxclM1aUo2ZDBMd3NhYnJqTjAvdUsz?=
 =?utf-8?B?V3V4TTF0VW1MU3FvQ05abGxxdGVCV083YVl0VnFkNjZ6SjlpNnhMQzY2MnRF?=
 =?utf-8?B?aXFDZDhSUXdnK2xGNEFEMStXd2FNQmFxQ3Zyc0hhdzRCdVVMNlZZbDlJNTlB?=
 =?utf-8?B?Z01uR0d2R2VibzVsbTNVL3l0eWc2b2pNaWMrSnRpUDlmVWxDSXVvK3h3SWV3?=
 =?utf-8?B?V0JzYzZEYWZGQ2tMVmd5a1F2QTR6ZTZYSUxQRkNpRVVJMit3T2QvYmV3TEhF?=
 =?utf-8?B?UEUrVC9zcU5FZkVGbGFEYS9tZmdsSzREcmVKeDJnSFVnQVhKMHBDY1o1L1c1?=
 =?utf-8?B?MGE0dll2TXo2R0hPOGxwNWxQOEdMb2RYVkNMSjUvZG01U3hTRjQ3UmRMaXdF?=
 =?utf-8?B?OXdnVFJzbnE5eVpWTnBsUVhpVXhOb1Btay9PQ01IbkZHb3pxNFZ6djVoOWZx?=
 =?utf-8?B?MDlJbU1qZDVPRDQ3VytRa3hhUnNtTEpJUDFSZ3B2YmRBY1h3b05JZFdhMW1I?=
 =?utf-8?B?K1RJTE9sRk4zNVpGY3hDUkNUeE9Yell4NWt1UXpxVmFxdFJKaWJFRUpYOXlr?=
 =?utf-8?B?WkI1RzVpR0NCL3BLcEIwcUc5SVdiMzVnMXlyZ28wdnY0SXYrdGJ0elV5aW5N?=
 =?utf-8?B?NGNGQkYwSFNNWjA3aVJZbWZKNlI1ZWhYSDgyL2dOanBkK3hwTEIyOE1WOTdC?=
 =?utf-8?B?ck5XakxRKytCSzZwM0dqY3pnSWFLb3hQQ0NVcmhoVWdtd2RlVUE5YXFWdWRt?=
 =?utf-8?B?eFdQSS9XYVpweGdHelpmWTQzNDF5ckIwZUkxeVY2dmR5eFRrdmlxQjBYSHpN?=
 =?utf-8?B?dFQ5TXhoU2NFek13VVplZE1WNnh6bElQa3QxRmcxVS9lcWNZWGNGK2lxcFN4?=
 =?utf-8?B?OFNncTZETXErYnJzNXhNTjU2YnZvLzBNTEwxYS92aEhpQVZlV0NzMjZOQlhP?=
 =?utf-8?B?ZlNNRXZRYzVUcHNrVHF4NStDMTNRbE13SkZ4cnVCUThPZnEyWXM3TmlOWDZj?=
 =?utf-8?B?OVJ3VWNFYTlydENWQWNTN0RMZUpST1piMVdIRzdTMGszT3VlcE15SFY4YytD?=
 =?utf-8?B?azA4WlFobU9ieklkR2Q2MkN4SjhUQnZ3NjFYUFlVTHc0aGJ1enRPT00yQi85?=
 =?utf-8?B?ZElUZ0ttL0IycjFSdDlzbGZkbTlGcE9aV1c1Y3RtOHRubXJlVUtCOStlOTQ2?=
 =?utf-8?B?TG02N2tFQVYvVlRPZzJXRjI1RVQ4Q2NBZkVPQzJiK0UxbDJ0OGkvMEJrZWhp?=
 =?utf-8?B?cUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0235f220-1bff-4eb6-624b-08de1add3d3e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:31:05.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf1nXjesBvQdSS6mAiP1/IaXJRLv8J3qZ9TVdiJ6gZUp2b/lWQemqhV5s27kl79XuBSIyW+i4wpAhfeOtMOL1lcQJ2W5F+uroE0XnWRxlNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8433
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 03 Nov 2025 13:31:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2412

Hi Peter,

On 11/2/25 2:29 PM, Peter Shkenev via lists.yoctoproject.org wrote:
> [You don't often get email from mustela=erminea.space@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently, u-boot.bin is used for supported rk3288-based boards. But, as
> U-Boot for those boards gets built without OP-TEE, u-boot.bin is a raw
> image, and, since raw images support for those boards is disabled as
> well, u-boot will fail to boot.
> 
> Fix this by using u-boot.itb for supported rk3288 boards, which is a FIT
> image.
> 

rock2_defconfig used for the rock2-square machine doesn't build (nor 
supports booting U-Boot proper from) a FIT image. Same can be said for 
the Amarula Vyasa RK3288, so this would break the build for them.

Please build U-Boot for all RK3288 to see if it works (I didn't, but 
reading their defconfig was enough to know this will be an issue).

This change *could* be fine if it was accompanied by the necessary 
changes for the boards that cannot boot the .itb image to change their 
UBOOT_SUFFIX as well, to .img as thats what we build now (c.f. 
u-boot-img node instead of fit in arch/arm/dts/rockchip-u-boot.dtsi, and 
tools/binman/entries.rst).

You can also add a comment stating this needs to be itb if 
SPL_OPTEE_IMAGE and SPL_FIT are set in the .config, otherwise img.

On a side note, I think it should be possible to migrate away from 
classes/rockchip-gpt-img.bbclass to wks/wic and upstream U-Boot. Not 
something you need to do though.

Cheers,
Quentin

