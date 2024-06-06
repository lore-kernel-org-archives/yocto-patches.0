Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC00C27C52
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 08:17:29 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.129])
 by mx.groups.io with SMTP id smtpd.web11.9260.1717661843432452874
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Jun 2024 01:17:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=DL2Bm1Sv;
 spf=pass (domain: cherry.de, ip: 40.107.20.129, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k46lIPksO3DamrSpIoD9B5D3OBVYlZ5CCwD5tGnhUJdW6N8SPLpz4kpGqdwh6MgfBa3rTBARiW9Mba4RCKiPAPeuVppKDV2RKnizw1m14rhnO0hjUub2FFEWOb0szxAk7/zKC8Od/3qSYxxdU9j80NS+zewCorB2WCdsbnseC2RLFEqv6lDRKAguDG9wSGiANs2ZzwJcFKJ0iR5Ehib8fcJaYNjIdXIDeNBwSNDSC1MlfLbIgII1nWYJnvSj8CXOVL+l7SObnML4ZP5Em+W2Kbs3T+G04ImzmivV7EcpG7mSmzR92Mua0/JCPYfTN8yVX46VZRAciuDRbpfXcC6dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg0lG5okjGuGeixNK0q4x3aZixqIl1UPgKsJYkSKmrU=;
 b=Cbz0RuFzKrGf1Inm+NQYSldtC0zLzQsrvcj30GkfWhYtAjVnhQCKJzbIwIW8Eh0ljNOnyqCBKZrhYeSAtYzspwTl1SYeEBxqBTw30XkbSoFs5d1RxdLUXhet4RMWlqgJiN6EzAi8VbMtt+dkceD9kTycFLjc0lb2VZqgwLYikcIiulEw1cK/zH4cGAeX2kxSVkdcXMrtU2GXvNDBlkp8PVFkFSkm5UnyPRwzG1+nvZtegeJgR/88V53e1MEv7+7/LX/oCOEZ5DUMTKiEfymPSnmHOEstyuNg6ewkuch3l10/M61dn+GnyA/bOQwo7gSEHLwY3E+pR3b9NT+ECzfrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hg0lG5okjGuGeixNK0q4x3aZixqIl1UPgKsJYkSKmrU=;
 b=DL2Bm1SvptKQutAO97dVQneBRgH7BaLJ9W5bfcd1qLdnHBLAYV9+OMhgQ+PgUr4GUXGxK9hqjNpFbW0NIH7jKtyJ8PcfU+a/ly0+QfVyowV5fm6ERhekOPP2JBJ/eVChjxTNHRCAJH42/q8uzqwVd9X62Gk+bda63OZivbpxgrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 08:17:20 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 08:17:19 +0000
Message-ID: <8835bd6d-80a5-43d1-93be-ec5d1cfc477d@cherry.de>
Date: Thu, 6 Jun 2024 10:17:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip master scarthgap v3 00/16]
 various reworks around u-boot and rkbin + fixes for MACHINEOVERRIDES
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20240531-rk3588-family-v3-0-629586621c5d@cherry.de>
 <20240605172312.GA11530@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240605172312.GA11530@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0017.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::16) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AS4PR04MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 37845381-bf2d-4ea2-d4bd-08dc860115aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHhaZzkvUFVzSmVMVnExbkx2MUJRMjFwTEo1NXJQT2ovRk1wd2d2Nis4RmFu?=
 =?utf-8?B?cm5OV0dKMzdRazJVUHJzN3JMMTdFNFhCRW03RjFNSWdtNmkzck11ZG9xaW0w?=
 =?utf-8?B?clFHQWFEdjZBcUZTVlJ3K1VCU0Y3WDZFbWZyTHJQa0Y3a3h5WVdzRUNIcURX?=
 =?utf-8?B?KytpbmxGTnlZb3BQM250RTZ2MlRSYWd2OUpBSVp0MlRnekxYMDU1c1ZHa1d5?=
 =?utf-8?B?cHNQdFY1a3U2SFVhSml3VHl0cFE1UnVnanJ2cjB3SmhqVTFFaklkM285dktJ?=
 =?utf-8?B?UHZydk5ldXUvdmhMUG9WZHptWmRDaWxDczN4QWQ0VnlwNEZ2YXFTbE9uSmN5?=
 =?utf-8?B?S2swd0hFT2YvRDA3YUxtNXV1RjRpMnZJcjlzdngvandoSTNRa0JZR21STDQz?=
 =?utf-8?B?cjRpbVlkKzZoNVZ1Q3h6VjU2NjlnZ084c2tEZVBvRjVETG5acEpjNG52Y1pt?=
 =?utf-8?B?a1RWbXlhSmdzYXVKVTEzRTFLbmJ4Q2xGbytwaTdVWk14MHk3Uk10aDQ4Zitq?=
 =?utf-8?B?QllIc3BpWERRbmg5VE1ENjhHTGxHMWR1bi9xS3RVOGk0bnV5RDRMY1RSVi9j?=
 =?utf-8?B?NUdIZTlTWnFkMzB6Wk9TTGQvbXVsSkNuZDZyb0xrQ205MitXMUtkc285SkNF?=
 =?utf-8?B?N0VDWkRrNzEzbmwyb3haTGF5b3lGUGsybHNQM3F1TE9scG1JTTJaMXFQMllX?=
 =?utf-8?B?eUk3c2lxY0hCMGFGbXpFQzZOSnhmNzZyeGNFV3hHNUVCdFZKT1lWZkM2QzhR?=
 =?utf-8?B?SytWSXZnSURVUHNJcG8vb1ZzSXhyNkNXblhrQnIzU3RiVndudVZUb29DeDgr?=
 =?utf-8?B?dkVXaDdIVkYvRFhDY3pkS1dEWkxJd28yTG10WDJBOWwrWW1VRC92TXp6cmdx?=
 =?utf-8?B?N0xpYThxU1RzN2tGcGpVZlRFaGZ1cjV0ajR1TXJaWjI1SmQ3QWxFSVpPRUNJ?=
 =?utf-8?B?T29ieXlSdGFRZVE4VmVkWGxuQjBtSnFKWXY5WUZjNk5qanZaRVdwUXVEK0Vr?=
 =?utf-8?B?QnBlMmJzSlBOK1FRS01vaFNyWVJhUzhuakF1WnhCZTU3YmpmOG9FaEhrM1FW?=
 =?utf-8?B?K05lZVVwYm1CTEE1K1plZEQvSS93bzB6Z29OVmY4YURSeHVxRVZVWDAwU0hC?=
 =?utf-8?B?S09ZMDAxZ0pSR2g5ZVNJVWJxU2RkSUJrUEdCQXc3Q3E1U3ludHlqazZPYnJP?=
 =?utf-8?B?ZmlnNDZwUXd6NWxDUHU3cUx5bjhqVGsvOXVvNEdwaG1rSzZVa2lWZ0hmM2F5?=
 =?utf-8?B?K1FNaFM3NTdyUWErdkZyYzFtVG93bUcxdG0xUHNNdVVhVFRFd2EwdWZpc0dY?=
 =?utf-8?B?VFJGODVIdkhQcE5JOUNENnJzSHpTZ3ptbkpTVkV1RjdleGwwTitqcEt0QWZl?=
 =?utf-8?B?NDVFWWo4V2VqaHNRWEl3WlhZVVlNUTdNR05tZHQvRFBYNTdydURaZ09wQ3ox?=
 =?utf-8?B?R25JZTJmcFluK1R5TjkxOExCczdidnYzeWJteTgrdTVJMlNyTUp0UWluOGpx?=
 =?utf-8?B?MHQrdFRibjhXQjBNK3hCZmJnUHd6aFM3VzNBN3VNOTg5aEp5aE5HY0JSV1VM?=
 =?utf-8?B?UHFFb3U5QUxFbHY5WEpDZys4Z2NxaC9iRkRQbndjalRpMEttMFE5cTNPa2Jw?=
 =?utf-8?B?MzA5RCtuQ2hYL2J3LzVBZnkvbkNockZwWWN6MDdrUDNMWFBFcDNGZWt2UTBz?=
 =?utf-8?B?b2FmWXlCUFh4clRwOUZwY2c1WS9DbUJ2WDBPaXQ5QWtlNlRZUUY2RVk1dGNj?=
 =?utf-8?Q?l27vbaoCwgIAZa7IRKS1aI/IxhOwL5rDIS7u7Hb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ckpiK1RQQ05hWDg0REswdUJQWndsTUZ3aU9iVFJIZ2pqTWs0cUluR0hzMzJD?=
 =?utf-8?B?cWptMGxwZmhRbENEZzBtbzZWVTkzVCt1V2ZYbFBSMVIyS0xaUlBvODNpODM0?=
 =?utf-8?B?YW1qNU9hMEdaQVdvcUFLbWlQRGpUMWFGM0djRmtYR0R1V3R5Q2NHQktUK3M5?=
 =?utf-8?B?M2RhRzJrenlqZTVnNUhDck8yZDVOaDk3UnhvVGVYTW9qTElQaG1Ydk1pY3lT?=
 =?utf-8?B?b3k0V2pncllmMlUvajgvSnNEalRZeUFzUFYxeXpDYnFudUNXOUpEWGhraXBF?=
 =?utf-8?B?S0dHYjZUeE1oaWYyMHpWNncxZGNaWEsrLzNiRFhEeWw3NTBKYU9sZ0pNWEFh?=
 =?utf-8?B?UDlZWDZlZFlVQ1VQR0lCRlRnamlQUkVWOGwvS3Z4VXl4N3NpcUpqckxSUnFJ?=
 =?utf-8?B?ZUlYQmhzenVib1dBeUZuVlFRZ2tCYnA4UzFQOTB0Qk9NOWg1L1cyVjR5UEla?=
 =?utf-8?B?U0lzeis4T09vY2pza21HaysyeGhwUWM4VURDTFBYbjVZRlNQRGtRVk9qSmU2?=
 =?utf-8?B?QzUwMGdDMDVldFBJREFlaVl6N3QwU3phTC9ETHo1dyt5anBoR1B6Y2lBRWs5?=
 =?utf-8?B?NFJ2bXcwdFhDV3U4RlNSRThnakcvS0g2dUZ0eUpFMmxOVzlScjFZU1pTYmE4?=
 =?utf-8?B?aGx2ZmNzQVNrVWs5NGVZbjVFRUNaR2RsWHo5V3A5MjFDSk5IN0wvNTlDQjUw?=
 =?utf-8?B?d29YdzBvVjdLUWwvSEZ5Q3ZjeE5BQkFmWlAxN1FvYWgydy9uTzlhbk1UeHJq?=
 =?utf-8?B?bVN6REFxUkJnZmxweVJiblN2a1c3YmVmQW5rRWJKejNWNTVaMC9relZxVCtL?=
 =?utf-8?B?ZVBsRldzd1d1QW5MM1JEWDBUQ3VxYllEbjI4K08zTDdyT0plUGpQOXoraks4?=
 =?utf-8?B?RHZsSUxGMDJOWXkzbnNaK3Z0UXh3a09xZzdBVWlGTlErZjVOa1hQZTgwQU1F?=
 =?utf-8?B?dlJCcS9oT0F5WmlSVXhFS1d6ZEw3bXRUTlRnTnAvQ0U2Vm5Tb29PSU9aYVk1?=
 =?utf-8?B?UHdZOGhxUlpmQXV0eE50V1lmT2w2RnlYQU9oSnh4V2J3QlRaVWJaRmhta2Ri?=
 =?utf-8?B?YTh0d1I0VUg4bkc2R2xxV2V0U21XL0VHbElqRURoSXlIcUJPd2NCWTRzM3Nx?=
 =?utf-8?B?UXJZQlNNdjdRZkN4SjViUlZZTHBpY0hRb3J3bWwyUTh5eWZMOUM3QnJRNTQ3?=
 =?utf-8?B?WmZ4V29wK1JzREtPQ3EwVm95TEJQODlKMWw2aFc1eUtTdHVXZzh1TW9Ob3VB?=
 =?utf-8?B?ZTBrL1FBTzcxUUttMDc5ZUdEazR4cFpwWmZ4UktJUnhZZ3dzMUlJY1JrRTlU?=
 =?utf-8?B?dlhWL2t2T2tLakZyb01HQzMwbXNSVldsYllndXFZT29rKzNaUHpPUkZIMVpB?=
 =?utf-8?B?eVNGWjZJRXFRQWpJaDN4K3ZCdzNzcGUwb0xEaHp1N2VqNXgyRGFFNEl6S3JH?=
 =?utf-8?B?dlFSWkNIcGRZeWpYMkMxTjM4b21uWEdVbXJ1Qm51cVQ4dklWMk5aQk4rUFEv?=
 =?utf-8?B?Yk5tS3N3S3REdmxBQ0RwZ0NTM091ZTFwV1NtRisvSFVCUmlnS1ZpR1pyMjg0?=
 =?utf-8?B?aDR6RzRFS0FrL0doaDRldVEwTVdZdDFkbERTMWhxS0pKODYrSVRtVG1IRGJD?=
 =?utf-8?B?RUF1eFFpVjRaVVlGeEFGUFdoZ0VrTE1DWGxsYVVJeTN4KzQxeWxTdGlmR2FS?=
 =?utf-8?B?eWVsaXhjOG1XclpKMUp0ZzMvcU5mVnhVU0ZqZkdVYk5PREFmaUd0Rjh5OXlw?=
 =?utf-8?B?WU90Q3pZMkFwS3BOSWQ2WVJHRURDRWtKbkQ5cGxZZEtxcWpJMXlWcUtaakJE?=
 =?utf-8?B?ZGtDaGk5elVLdzJUeXhkazRJS1RSMFpjN3JUQ0wvL3lVVDZ0R0pyRGpIY2Uw?=
 =?utf-8?B?ZkM4SnB0Mkh5czlMbDZGdVFNN2hWejJoaWpHaUlPSXFKbGYydGJ1dDFQanlp?=
 =?utf-8?B?UkU0d29zZDhUVHI5WmJhYlMrUGp1aXpyNjhTMklNbURaWjkxcE1tc1NsdzBY?=
 =?utf-8?B?d0FRaWpaY0MxQnRSMy9PVWlkZFBweUVwV0c0Ny9zRkRMZVN1dzdwUEFNbVdX?=
 =?utf-8?B?MWhzOWlUSnRjTTZvd1ZXSStHMDlQM0lrUElUc084TFBQdlIySC9LL2Rma3Rz?=
 =?utf-8?B?TFRMQzliMmMxN3N6MkZ6T2VRc0lDRGlBRElndE5TM0dVSnV6REFESjFJeFlu?=
 =?utf-8?Q?+O3poMkj4GnpgCh3DZElauk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 37845381-bf2d-4ea2-d4bd-08dc860115aa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 08:17:19.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzbMyskXR2wEwF9mQQaff4N/ABSTMhW6snnsBjbMmx+dQ7bcqA/+RWiaVhgWwigjQHEqG4TcFrO9gt/wWV2NC4DVA4p16EZ6lEYRQHBdE20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9692
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Jun 2024 08:17:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/279

Hi Trevor,

On 6/5/24 7:23 PM, Trevor Woerner wrote:
> On Fri 2024-05-31 @ 11:25:07 AM, Quentin Schulz via lists.yoctoproject.org wrote:
>> This does a few reworks of how we handle TF-A and DDR bin blob
>> dependencies, hopefully in a way that makes it much easier to add
>> support for new SoCs without having to touch too many files.
>>
>> While at it, add an SOC_FAMILY entry for rk3588s/rk3588 boards.
>>
>> Additionally, make rk3308 use the PREFERRED_PROVIDER mechanism to select
>> rk3308-rkbin instead of rockchip-rkbin.
>>
>> Finally, fix a few MACHINEOVERRIDES ordering issues.
> 
> Here are the new MACHINEOVERRIDES (with these patches applied) for all the
> MACHINEs we support (with rk-u-boot-env enabled):
> 
> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:firefly-rk3288:rk-u-boot-env"
> 	MACHINEOVERRIDES="armv7a:rockchip:rk3066:marsboard-rk3066"
> 	MACHINEOVERRIDES="armv7a:rockchip:rk3188:radxarock"
> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:rock2-square"
> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board:rk-u-boot-env"
> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:tinker-board-s:rk-u-boot-env"
> 	MACHINEOVERRIDES="armv7ve:rockchip:rk3288:vyasa-rk3288:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4:nanopi-m4-2gb:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-m4b:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:nanopi-r2s:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:nanopi-r4s:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:orangepi-5-plus:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:roc-rk3308-cc:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:roc-rk3328-cc:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3568:rock-3a:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-4c-plus:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rock-5a:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa76-cortexa55:rockchip:closed-tpl:rk3588s:rk3588:rock-5b:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4a:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4b:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:cortexa72-cortexa53:rockchip:rk3399:rock-pi-4:rock-pi-4c:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock-pi-e:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:rockchip:closed-tpl:rk3308:rock-pi-s:rk-u-boot-env"
> 	MACHINEOVERRIDES="aarch64:rockchip:rk3328:rock64:rk-u-boot-env"
> 
> For uniformity, would it be nicer to have all MACHINEs include the SoC
> OVERRIDE?
> 

I'm not sure to follow here, the SoC name is in the override?

rk3288
rk3066
rk3188
rk3288
rk3288
rk3288
rk3288
rk3399
rk3399
rk3399
rk3328
rk3399
rk3588
rk3308
rk3328
rk3568
rk3399
rk3588s
rk3588
rk3399
rk3399
rk3399
rk3328
rk3308
rk3328

for all the above?

Aaaaaah... or you meant renaming the machines so that they have their 
SoC name in the filename? e.g. rock-pi-4a to rk3399-rock-pi-4a? I found 
it annoying when reworking to look into each machine conf to figure out 
which SoC they were based on, so I understand the pain :) If you want to 
go this route, I would suggest to prefix it with <SoC>- as is customary 
in the Linux kernel for Device Trees for example.

> Other than that this patch set looks great!
> 
> I'm not overly fond of the name "u-boot-rockchip.inc" since it sounds like
> it's an inc file for building the rockchip vendor fork of u-boot, but I can't
> really think of anything that is obviously nicer.

Could suggest u-boot-rkxxxx.inc instead? There are only a few SoCs that 
do not follow RKXXXX naming scheme (the PX family and RV families right now)

We could also add some comment at the top of this file explaining what 
this is supposed to be used for?

Let me know how you want to proceed with this,
Cheers,
Quentin

