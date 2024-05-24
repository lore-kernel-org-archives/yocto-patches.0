Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E1AC25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 08:37:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.102])
 by mx.groups.io with SMTP id smtpd.web11.11325.1716539833172464101
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 May 2024 01:37:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=ParG3SyB;
 spf=pass (domain: cherry.de, ip: 40.107.22.102, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzM2IiPYYNIAHpzG8tgcDQjW1bi0WawqU1GEH/z39Mv79bbIhRAH8JthI7KWYA6s0o/4raIss0V/9lQH3au5xWCqDvqN+3+dLPp0EIHRPOeNRpT4Hs8jaLW3cXRtW82+GHQHX3mTR3l8y+zN9Wu+yxaCvIwak41Q0ZyAim6zZIX6k0lxYomkqJm/Ph6nQZZFoV3E4NZ97yPLm67VNYvpMi6UT2eWzn1bh3SPAu2Ai4BgrzMcMgfaKEIZzxPoZsAnT+pC0F6RPuPsrW5RBIdD39F6vtTNGPMK9ojX880XsZLFjWo+KBBHMKHJj6RER2XnIRh7OOdD4zbfWYE1HyDaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kdks2sC/4QF18JIhjZA4DVKqcvpl2256lz8sqChagw=;
 b=XTOx0p80rtA2HlSmmgDqTeT3iN6cv1WQeMy7n5eTMTFDYqskXJDpeZKeUujoYA4uiPKFd3MNQoQoStYXkO0ZwDzSgvBJ9YLfQS4xr6VPHBNoW5yXnJiSmKqpWl14X4ZU9YPedGY3+gsj/sqfFHr4h3Nm95HEhaG57HB17xgBi5Jj4rIKwsh4ew37awd1Bv3ZX2SPWyYAXZp2BqHbW900+dJ4OMR3Xl/8fLW88SbUrnO6BEcwK/kVcChzTNsMca2uRyWwHnqddh70IXLGsE3YcZzvfm/l6HtKEHJ022mE9VYwwXBlFCvRtJDEs1qH9ZRUXqzz8y4mG/Rl9h7LuFIOFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kdks2sC/4QF18JIhjZA4DVKqcvpl2256lz8sqChagw=;
 b=ParG3SyBu9scr4DEJXcQrJYj2xzVfwc7tx2Sg6+QyMCYqIZPWPNwUOaUUdgSVnClDFADN911Vvlfu4g9nxW/6mGE2cS1g4uXGMgJH259419VpxyayEI1hreGCubGSPXu45JwgIO1kCmelTkvraYPYLtNelSTxCUdhpMKq1weAww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by PA1PR04MB10143.eurprd04.prod.outlook.com (2603:10a6:102:463::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 08:37:08 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:37:08 +0000
Message-ID: <c9672d9f-21b1-4102-aa32-c6d94a8b9570@cherry.de>
Date: Fri, 24 May 2024 10:37:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v7] enable stored U-Boot
 environment
To: yocto-patches@lists.yoctoproject.org
References: <20240522225345.13339-1-twoerner@gmail.com>
 <0eceea59-17f3-4e7d-bb90-f23304b896a4@cherry.de>
 <20240523192116.GA22785@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240523192116.GA22785@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0033.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::13) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|PA1PR04MB10143:EE_
X-MS-Office365-Filtering-Correlation-Id: cc181e83-de70-424f-2c49-08dc7bccb1ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NDVSVWZIRTZ5emJkNUszTEY3N2pWTHpMNlVJNTZsY0Y3bzUvM2JtRjI4eG9x?=
 =?utf-8?B?K3lDSEQxMjJGUGhPRjBac0RJUXgvYjdidm4yRGNMQVczdW1DN3FWK05mN3I3?=
 =?utf-8?B?Z0t0b2JKdEdqQncrdEZxSWFMWnYzdjAyM3VtWXVPZm02d3pWSTk2UGpNVEg3?=
 =?utf-8?B?SWZQUjU2ejlhdUs1dklpZHZmWVlaQlFlQXhFRUJJejVpL3NYUTBhSXlPTGEr?=
 =?utf-8?B?T2t0dzRSblR2SUo3bXNlelJGRVo0NHlvZ0YxUUtGZ1dUeS9jRFZJT05USnFD?=
 =?utf-8?B?ZjBrc2lnRU5zZGVOalJVK09UTXgvUkVwYnVhdThUNTNoY0lzNkFYNmFKdHpo?=
 =?utf-8?B?TDh4VG81VVVpSXVVZ0F0c0h0alozMmhvajlRYk05ZUlnL1oya2VXY3U0Zy9J?=
 =?utf-8?B?KzVoamI0dGNkZnlBaDB4SUJpWlc0UmFTWTFZa1FjUUdhUk5wRS82SEl5NkhN?=
 =?utf-8?B?VzkxVEMvcC93ZnRMaENxY3gzZXI4Tmo0cCs4NzBYeTk0VnI0aUJlZTZEUnp3?=
 =?utf-8?B?QjdHN2t3N0hkZGNEekdhdVAycHVDMC85SzdrWEVkTmdLU3FUbWJXd2pTaG56?=
 =?utf-8?B?ZnJ4QnY2aFVWTE9YZUcyWm9DSnNRa3lTQnRhUkN0aXh5WGdoODJzdU1mWURi?=
 =?utf-8?B?SGh1dGJudFBCcThyQ1d6K1djWmNQRlovMmQ0MnV5Ni9RWUJJdTR3TkpydTBp?=
 =?utf-8?B?UXhxYmFjVXRDYjNKVWZLT05jSU5qOVVVSFdHV2x0MW9tUHh4a0ZQMENCalpt?=
 =?utf-8?B?U3lIMEFvWmhyTytqU1FnWU9MZUcwamEvbzgzdXN5R05CdENVeTNwd1V3elB2?=
 =?utf-8?B?eE1VdThxclQya04xL0g1bEttQmNDVUVNWUZ0WG94V3ZIQktkOEFBTUcvc1hZ?=
 =?utf-8?B?MnZKSUlQYmYySCtwMW5pWHNmcHIydUdvdzVpQWtlTGhBRGxQKy96bTYya2Ju?=
 =?utf-8?B?MnRDbDNRWVdQaVFsYmw4RGZiMGl3Q1h1R1B1cTBxTVg5YlBsakNDMEZWM0dO?=
 =?utf-8?B?c2FoZEQ2Sm0reXhjT3lSN0htNGlkZ1NRTkk4MTB5MS9BYnczUm5uQUk2WHJY?=
 =?utf-8?B?czQ2Uy96NlNlSzhkM2I4bkNaSEMwSVFjU1VnelRFVGZXd0cvaWI3TkRKQzVq?=
 =?utf-8?B?LzhFMVFnTkp6WTFzRVUwWFJPQ0h1UlFONVp2dWlQREQxZ3RzV0ZTNkFqei9H?=
 =?utf-8?B?VjBRRlRqdVU1OHgrVklvTzU5eThsVTFyZHl5bG9mZ2VqM3BjRXVSdFJOWU4v?=
 =?utf-8?B?VXFQNkVhMEh1cFlvb2o4V1huZnc4bWlTVWJPaktaU05CVWVhTUdmR0FXS2dn?=
 =?utf-8?B?alMrbzJtc0NINkQzWFlDMHhBWjBVNTRGcVoyMkM5emVicTRiVHc3aTd3N3F3?=
 =?utf-8?B?RFFyc0VQRmdMcm1HOEI5Z3V5TXNyY1drZGpKc0I4UmVMUG12SlVxWTUxTzV3?=
 =?utf-8?B?ZVY0RDMvaVhpc3kzc2pLTjdWWVhyMHdyeGZYUkkybDBBSUZjb2tDblk5aDdw?=
 =?utf-8?B?OGI2UFQ1MjhRQTdGaGxIbzdCQ2FOK0pBbGgzNG4xa0lWbXZUZDZyZSt0cUsw?=
 =?utf-8?B?cEt1eE1xbTE4UmRjMzJvbDVkeWs0WEd1UXpZSVVZOVZHdmNHWElHZE0veEVG?=
 =?utf-8?B?T0M4MUsyZHVyU0VhTi83Z3h6TGhMRUo5NC9Wd0pvVmpWOURoZWc5Y3BoMkYx?=
 =?utf-8?B?YkpPczFBZGMyMGZYMkxCdGN4QzVWRkFYZktwclplbDRMNlRoU2ttN3pRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUJzSlQ4a2RoQTloQjgvQitRYXNOaEhJc0p3c0FqWGVYUzFpMXZ1bGZhL3I2?=
 =?utf-8?B?aHhuQWFYM2JCbzRONzF1c3BGQjlLdmlGSmtqTWIzQmpCaWFqREdvdmJmV0lt?=
 =?utf-8?B?RUJxRDAvMnRYelFxRHFBWHRRSmEzZkpSK050ckFNemRtclVUdktvUThZZCtj?=
 =?utf-8?B?Q2hyQ0FiMkx6bmxidk5GWXlHekxNTWVGemNJdVpldUg4Ty9PWnkrYXZKWHEx?=
 =?utf-8?B?V0x2N0hpZkIxdVZEUml3NUZGMURzRnZyV09TZlNzYVN3ZmZwUDNSSjZKR2l4?=
 =?utf-8?B?L0RZUUpySlk3QUl6NTlvNENCclN6TVJHNUZUcjE5MWRkVDNZTUZxRWxhMjhz?=
 =?utf-8?B?dVRjTDJZVDZOb01kTEx6THlrT2toWW90UWNFcHkrRUxQSEVDQVlqMklPQnB4?=
 =?utf-8?B?VGYwRUxuRlBwVlZ2SHlyVnNXTnFEVWg0cStoVGhvMkRZZVRTQlJZL3gxYnND?=
 =?utf-8?B?bzlMQ05WNDV2dVdXMDBIMVN2bllyRUFvYndwWnFYUHNzVm9mL3pIbGNtRWRi?=
 =?utf-8?B?NVYvbDEzYkdPcVpBUE93eUJhbWRhSVU3THZaMjQ4SUl5dkV3QXpHclNiUGFJ?=
 =?utf-8?B?c3dneWVYM1FEVjVqWm1kVWs1WWlnb3FIaU15Wmt4MnJPaWx4QjdCZW9OajhQ?=
 =?utf-8?B?c2R0aTI5NXJ6VHo1NVNEeUthdUxnRzQ5LytVekFhT3FISS9Ka2k4SEdKVUdX?=
 =?utf-8?B?dXZOaXVQRmdQREIxSTE5SzBLaVViZUwvWlVzelRvcEhZYjk2S2NMSkMrZ3pt?=
 =?utf-8?B?RlUrTFk5VS85dnFvNDF6ZmMwSGlkd0lvei9YMmVoOHVaVytxQ256bkk5RGlI?=
 =?utf-8?B?YkpSTzRpU3pUR05ScjRuNlJVRUMwbmhRQlZjdnVCNUJMeVpUZjd2YUJycGhm?=
 =?utf-8?B?UkwwSjhETzVWdGZFSXJrRng2YURJV2JsWTJMeXJPZTE2TDUvYWVKVHMzdjhx?=
 =?utf-8?B?bXJTZXUzWlhnaEcxVXI2Yy9vYmJsTERSYXkrRlJLeHhMMnRVYnRQcXhRTnIr?=
 =?utf-8?B?U3JwMnh5cS9pYWZ4YStCbkNXcC9LTnpQNCs2bGpnVmZxRnpQd2s1aFYzcGFX?=
 =?utf-8?B?UEpMY2hCZ1ZFelZleW5GNElVcnFhNzV4YVoyZlBwdmxnbzl5VmFqZ0FtRlI1?=
 =?utf-8?B?VUl0dXVCTGJFNlJZS3ZyYWU1OEZmbHNvcncyRU1aZGJMcHhNcTRTcFg4RHMr?=
 =?utf-8?B?VXBObm5DUUtINUxCNnM2eFhWYkZrOEZBVHh0NkkrYVE2YnIxSWhCRzRpSll1?=
 =?utf-8?B?SzVUNWdXMTBUcjg4emJkc0lsQ3NYdkFTcmlEVE1zZEJ2UHFKSHFpVWxMR1Ar?=
 =?utf-8?B?WFVZaFNHaUtuNzlkTEVLWTIwdVhJKzNIb1VtSzY3dmlnc1hpb2ZCcjU5ditv?=
 =?utf-8?B?R3RZOTlHcGswRXhHZ2Q4NjFyRzhoL0FDYURla0RBOXorbHUwYnhwQkdsUzQ2?=
 =?utf-8?B?ZUZ1d2xuZlRoSTRWaThaVFN6Y1lkdWZldkdHaTZqakY1cE1VWU1Rb3ZXZUZv?=
 =?utf-8?B?VTRucFdYcjlieHZTcjRsck9NYThPYUVtSkZPTEFsMy9EM2RLUHViMVVSc2JG?=
 =?utf-8?B?eStTTWFxOEJ2MTVlTDZBZ0hMNXNqVEVJRnBjejFGeUxGdFU1T3YzQTBybVR2?=
 =?utf-8?B?T2srZTRadG15bDQ2amE0OXpncnhIYk5FYm9oeWgzbDN1ZENnOGo1NHpWVWM5?=
 =?utf-8?B?QkcwSEhZcnhwMjZOd0tveUEydm5DZmlIT213aHVuL3FNck41cFQ2Y3RwRC9Y?=
 =?utf-8?B?eE9wRkdGTHUvYk0xMzZHejliOEtWWlVFbU10SkdYUEVISTc4WU1wVy8rSVNo?=
 =?utf-8?B?SHJ2K2R3RnVxOWZXUy85MFBQeXZ5Rm1JMTVqRzk5OENnNG1HNXp0bzNGM00z?=
 =?utf-8?B?OFgwdzBmMnhvcm5kR0J6SW91ci9ReWgrNGprOGluYmFUeWIvdXRRQXJmdkhv?=
 =?utf-8?B?YnNSbm9oYUZWM3FtcDJJc0JIcXNNbklCdG5ZejJpQjQvVWhxbVVCT1dVcmhu?=
 =?utf-8?B?QzB4TjhZUlNMMWE5TTgwaWxVR2ZYZzNkN0lHR1NDeXM1aEpHTWtkTDFJM1k1?=
 =?utf-8?B?ZUlzRWJZS2NycmZlbWJjYUNyMUp6dGIwOTNpbzFwdSttUXBqNjJjdW5tS1R2?=
 =?utf-8?B?cmpabGVLNWNLMDdJeDJwNmkwWHRiU2g5MjFBeFFBS01ZNFZyalJyTVNpMHVn?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cc181e83-de70-424f-2c49-08dc7bccb1ee
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 08:37:07.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rnv80f8nojWqrXSFIWoEJolIKj79aF4EauAgOO/Gt9ha94teorZiIE4S6k5qTQEKUZeUJA/rkQvkLzaVnO2WH225G7O+5RksnOcGi6Azibg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10143
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 May 2024 08:37:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/187

Hi Trevor,

On 5/23/24 9:21 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Thu 2024-05-23 @ 03:03:53 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 5/23/24 12:53 AM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> U-Boot has the ability to store its environment variables to a permanent
>>> storage device. Whether or not it does so for any one specific device
>>> depends on whatever settings are enabled in that specific device's
>>> defconfig. In order to definitively configure U-Boot to be able to store
>>> its environment into the device from which it boots, for any device
>>> supported in this BSP, simply add the following to MACHINE_FEATURES:
>>>
>>> 	rk-u-boot-env
>>>
>>> If enabled, there is now a second choice to make: should the build also
>>> include the U-Boot environment in the image or not? The default environment,
>>> as generated by U-Boot, can be included in the generated wic image. If it
>>> is included, then flashing the image will also flash the default U-Boot
>>> environment variables and settings, wiping out anything that might have been
>>> there already. If it is not included then your device will either continue
>>> using whatever environment happens to be there (if valid), or will not use any
>>> stored environment if the stored environment has not been set or is invalid.
>>> The variable which governs this behaviour is:
>>>
>>> 	RK_IMAGE_INCLUDES_UBOOT_ENV
>>>
>>> By default this is set to "0", meaning that by default the image does not
>>> contain the U-Boot environment. To enable this behaviour, enable this
>>> variable. This variable only takes effect if rk-u-boot-env is listed in
>>> MACHINE_FEATURES, and has no effect otherwise.
>>>
>>> The script:
>>>
>>> 	scripts/dump-uboot-env-from-yocto-image.sh
>>>
>>> can be used on a rockchip wic image to see the contents of the U-Boot
>>> environment partition at build time.
>>>
>>> Tested by booting the same image on both eMMC and SDcard with the following
>>> devices, verifying the ability to read and write the U-Boot environment in
>>> both U-Boot and Linux user-space, and that changes made in one are seen in the
>>> other:
>>> 	rock-3a
>>> 	rock-5a
>>> 	rock-5b
>>> 	rock-pi-4b
>>> 	rock-pi-e
>>> 	rock64
>>>
>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>> ---
>>> v7 changes:
>>> - move u-boot's extra image install to machine/include (it wasn't having
>>>     any effect)
>>
>> Couldn't find this in the diff between v6 and v7, are you sure you sent the
>> proper version or is this outdated? You did add the inc file to the
>> rock2-square though, is that what you meant?
> 
> Oops, sorry. I have about 4 different versions of v7 and I probably got
> confused between some of them. In any case the extra packages are listed in
> the feature's inc file and it works there.
> 
>>> - only call u-boot's rk_generate_env() postfunc if the feature is in
>>>     MACHINEOVERRIDES (in which it is only *conditionally* found, unlike its
>>>     presence in MACHINE_FEATURES)
>>> - add a warning if the user is trying to build an image whereby they've
>>>     enabled the rk-u-boot-env mechanism but it isn't supported in a given
>>>     specific build
>>>
>>> v6 changes:
>>> - separate out the MACHINEOVERRIDES handling into its own include so
>>>     that it can be included more flexibly into different scenarios; i.e.
>>>     rock2-square build was failing because it is not wic-based
>>>
>>> v5 changes:
>>> - fix a bug in v4 to handle RK_IMAGE_INCLUDES_UBOOT_ENV correctly in the
>>>     bash test in postfuncs of u-boot bbappend
>>> - add extra check in do_deploy() of u-boot bbappend to only copy the
>>>     environment if RK_IMAGE_INCLUDES_UBOOT_ENV is true
>>>
>>> v4 changes:
>>> - sort WICVARS alphabetically
>>> - tweak dump-uboot-env-from-yocto-image.sh script to not just check for
>>>     the existence of the user-supplied parameter, but that it is a file
>>>     specifically
>>> - u-boot bbappend:
>>>     - use a do_compile[postfuncs] for generating the fw_env.config instead of
>>>       a do_compile:append
>>>     - move the conversion of the U-Boot text-based environment to the
>>>       required binary representation from a do_deploy:append to the newly-created
>>>       do_compile[postfuncs] created above, this will allow the user to inject
>>>       any extra U-Boot environment variables they might wish as part of a
>>>       do_compile:append and have that occur before the binary is generated
>>>       so that those additional user-supplied values are included
>>>     - add a lot of extra checking (instead of assuming various resources exist)
>>>       before making use of said resources
>>>
>>> v3 changes:
>>> - switch from using a bbclass so the `rk-u-boot-env` override can be used
>>>     directly
>>> - add SPDX header to script
>>> - drop `inherit deploy` in U-Boot bbappend
>>>
>>> v2 changes:
>>> - re-word the commit message and README for clarity
>>> - use bash's built-in math handling instead of depending on `bc`
>>> - in anticipation of the upcoming feature in U-Boot whereby rockchip
>>>     devices can automatically select the environment storage device to be
>>>     the same as the boot device, use a more recent SRCREV for builds that do
>>>     environment handling, instead of hardcoding the environment storage device
>>>     by SoC family
>>> - handle RK_IMAGE_INCLUDES_UBOOT_ENV as a boolean
>>> ---
>>>    README                                        | 20 +++++++++
>>>    .../include/rockchip-rk-u-boot-env.inc        |  4 ++
>>>    conf/machine/include/rockchip-wic.inc         |  7 +++
>>>    conf/machine/rock2-square.conf                |  1 -
>>>    .../rockchip-enable-environment-mmc.cfg       |  6 +++
>>>    recipes-bsp/u-boot/u-boot_%.bbappend          | 45 +++++++++++++++++++
>>>    scripts/dump-uboot-env-from-yocto-image.sh    | 29 ++++++++++++
>>>    wic/rockchip.wks                              |  2 +-
>>>    8 files changed, 112 insertions(+), 2 deletions(-)
>>>    create mode 100644 conf/machine/include/rockchip-rk-u-boot-env.inc
>>>    create mode 100644 recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
>>>    create mode 100755 scripts/dump-uboot-env-from-yocto-image.sh
>>>
>>> diff --git a/README b/README
>>> index c76fc9131276..605773d4ecd3 100644
>>> --- a/README
>>> +++ b/README
>>> @@ -67,6 +67,26 @@ Notes:
>>>    	
>>>    	in the configuration (e.g. conf/local.conf).
>>> +U-Boot Environment:
>>> +------------------
>>> +	In order to configure U-Boot to be able to store its environment into the
>>> +	device from which it was booted, for any device supported in this BSP,
>>> +	simply add the following to MACHINE_FEATURES:
>>> +
>>> +		rk-u-boot-env
>>> +
>>> +	If enabled, to additionally have the U-Boot environment generated and
>>> +	stored in the image, also enable the following variable (default: off):
>>> +
>>> +		RK_IMAGE_INCLUDES_UBOOT_ENV
>>> +
>>> +	The script:
>>> +
>>> +		scripts/dump-uboot-env-from-yocto-image.sh
>>> +
>>> +	can be used on a rockchip wic image to see the contents of the U-Boot
>>> +	environment partition at build time.
>>> +
>>>    Maintenance:
>>>    -----------
>>>    	Please send pull requests, patches, comments, or questions to the
>>> diff --git a/conf/machine/include/rockchip-rk-u-boot-env.inc b/conf/machine/include/rockchip-rk-u-boot-env.inc
>>> new file mode 100644
>>> index 000000000000..4eb877f77c48
>>> --- /dev/null
>>> +++ b/conf/machine/include/rockchip-rk-u-boot-env.inc
>>> @@ -0,0 +1,4 @@
>>> +# 'rk-u-boot-env' indicates the user wants to be able to save their U-Boot
>>> +# environment back to the drive from which the device was booted
>>> +MACHINEOVERRIDES .= "${@bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', ':rk-u-boot-env', '', d)}"
>>> +IMAGE_INSTALL:append:rk-u-boot-env = " u-boot-fw-utils u-boot-env"
>>> diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
>>> index 147a36685d7d..b5ee6e0c2724 100644
>>> --- a/conf/machine/include/rockchip-wic.inc
>>> +++ b/conf/machine/include/rockchip-wic.inc
>>> @@ -1,6 +1,7 @@
>>>    # common meta-rockchip wic/wks items
>>>    require conf/machine/include/rockchip-extlinux.inc
>>> +require conf/machine/include/rockchip-rk-u-boot-env.inc
>>>    SPL_BINARY ?= "idbloader.img"
>>> @@ -11,7 +12,13 @@ WKS_FILE_DEPENDS ?= " \
>>>    	virtual/bootloader \
>>>    	"
>>> +RK_IMAGE_INCLUDES_UBOOT_ENV ?= "no"
>>> +RK_UBOOT_ENV = " "
>>> +RK_UBOOT_ENV:rk-u-boot-env = "${@ '--source rawcopy --sourceparams=file=u-boot.env' \
>>> +	if bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False) else ' '}"
>>> +
>>>    WICVARS:append = " \
>>> +	RK_UBOOT_ENV \
>>>    	SPL_BINARY \
>>>    	UBOOT_SUFFIX \
>>>    	"
>>> diff --git a/conf/machine/rock2-square.conf b/conf/machine/rock2-square.conf
>>> index 9468b9a6b559..b31eb574015f 100644
>>> --- a/conf/machine/rock2-square.conf
>>> +++ b/conf/machine/rock2-square.conf
>>> @@ -16,4 +16,3 @@ UBOOT_MACHINE = "rock2_defconfig"
>>>    # image class
>>>    IMAGE_FSTYPES += "rockchip-gpt-img"
>>>    IMAGE_CLASSES += "rockchip-gpt-img"
>>> -
>>> diff --git a/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg b/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
>>> new file mode 100644
>>> index 000000000000..778772d27767
>>> --- /dev/null
>>> +++ b/recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
>>> @@ -0,0 +1,6 @@
>>> +CONFIG_ENV_SIZE=0x8000
>>> +CONFIG_ENV_OFFSET=0x3f8000
>>> +# CONFIG_ENV_IS_NOWHERE is not set
>>> +CONFIG_ENV_IS_IN_MMC=y
>>> +CONFIG_DM_SEQ_ALIAS=y
>>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> index a83179a9f007..33b521021a1c 100644
>>> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
>>> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
>>> @@ -1,7 +1,13 @@
>>> +FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>>> +
>>> +SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
>>> +SRCREV:rk-u-boot-env = "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
>>> +
>>>    # various machines require the pyelftools library for parsing dtb files
>>>    DEPENDS:append = " python3-pyelftools-native"
>>>    DEPENDS:append:rk3308 = " u-boot-tools-native"
>>>    DEPENDS:append:rock-pi-4 = " gnutls-native"
>>> +DEPENDS:append:rk-u-boot-env = " u-boot-mkenvimage-native"
>>>    EXTRA_OEMAKE:append:px30 = " BL31=${DEPLOY_DIR_IMAGE}/bl31-px30.elf"
>>>    EXTRA_OEMAKE:append:rk3308 = " \
>>> @@ -34,3 +40,42 @@ do_compile:append:rock2-square () {
>>>    		cp ${B}/spl/${SPL_BINARY} ${B}
>>>    	fi
>>>    }
>>> +
>>> +python rk_no_env() {
>>> +    if bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', True, False, d):
>>> +        bb.warn("the rk-u-boot-env MACHINE_FEATURE is not supported for this build")
>>> +}
>>> +
>>> +rk_generate_env() {
>>> +	if [ ! -f "${B}/.config" ]; then
>>> +		echo "U-Boot .config not found, can't determine environment size"
>>> +		return 1
>>> +	fi
>>> +	cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" > /dev/null
>>> +	if [ $? -ne 0 ]; then
>>> +		echo "can not find CONFIG_ENV_SIZE value in U-Boot .config"
>>> +		return 1
>>> +	fi
>>> +
>>> +	UBOOT_ENV_SIZE="$(cat ${B}/.config | grep "^CONFIG_ENV_SIZE=" | cut -d'=' -f2)"
>>> +
>>> +	# linux user-space U-Boot env config file
>>> +	echo "/dev/disk/by-partlabel/uboot_env 0x0000 ${UBOOT_ENV_SIZE}" > ${WORKDIR}/fw_env.config
>>> +
>>> +	# convert text-based environment to binary suitable for image
>>> +	if [ "${@bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False)}" = "True" ]; then
>>> +		if [ ! -f ${B}/u-boot-initial-env ]; then
>>> +			echo "initial, text-formatted U-Boot environment file \"${B}/u-boot-initial-env\" not found"
>>> +			return 1
>>> +		fi
>>> +		mkenvimage -s ${UBOOT_ENV_SIZE} ${B}/u-boot-initial-env -o ${WORKDIR}/u-boot.env
>>> +	fi
>>> +}
>>> +do_compile[postfuncs] += "${@'rk_generate_env' if 'rk-u-boot-env' in d.getVar('MACHINEOVERRIDES').split(':') else 'rk_no_env'}"
>>> +
>>
>> Could be simplified with:
>>
>> """
>> rk_generate_env() {
>>      if bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', True, False,
>> d):
>>          bb.warn("the rk-u-boot-env MACHINE_FEATURE is not supported for this
>> build")
>> }
>>
>> rk_generate_env:rk-u-boot-env() {
>> [content of rk_generate_env in v7]
>> }
>>
>> do_compile[postfuncs] += "rk_generate_env;"
>> """
> 
> "...eye of the beholder..." I guess. You've suggested this before as a
> simplification, but I guess I've never quite gotten accustomed to bitbake's
> override mechanism. To this day I still find it odd... and unique.
> 
> What I've proposed is a simple: "IF <string> IN <object> THEN <generate_env>
> ELSE <no_env>", which is mostly plain English.
> 
> With overrides you're saying "always call this function... oh
> wait! unless overrides are in place, then call this one or this other one...
> wait! are overrides in place? what are the overrides?..."
> 

Yeah, your version requires more (of my) brain parsing power to figure 
out what it's doing. Just different patterns in different people brains 
that's all :)

> In any case what you've proposed doesn't work. The non-override
> rk_generate_env() function would need a "python" prefix and try as I might, it
> seems you can't have a set of override functions with one being python and the
> other one not. Without the "python" bitbake chokes if the non-override one is
> called. With the "python" bitbake will still choke if the overridden version
> is called:
> 

That's... an interesting side effect. I don't know if this is 
expected/known? But thanks for testing and reporting.

> Try making the change you suggest, both with and without the "python"
> qualifier for the non-overridden version, then try building with both
> MACHINE=rock2-square and MACHINE=rock-5a; one or the other won't work with or
> without the "python".
> 

So, we can actually have this python code migrated to shell, if I'm not 
mistaken the following should work:

"""
rk_generate_env() {
     if [ "${@bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', 1, 
0, d)}" -eq 1 ]; then
         bbwarn "the rk-u-boot-env MACHINE_FEATURE is not supported for 
this build"
     fi
}
"""

> In any case I like my version :-)

And I like mine :D

Just a matter of taste in any case, nothing wrong with it, just 
different ways of coming to the same result :)

Cheers,
Quentin

