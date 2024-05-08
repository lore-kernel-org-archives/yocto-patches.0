Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22F6C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 17:45:28 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.107])
 by mx.groups.io with SMTP id smtpd.web11.3649.1715190325681491325
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 08 May 2024 10:45:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=fV33UK1+;
 spf=pass (domain: cherry.de, ip: 40.107.247.107, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRRxIgS4JCF7ttf9zGot8HaPsA/Q9Qa1v6dCN8qtKxbjNQnOg16pz0V7QEKrJaMLQhquFFIweK7GmQd9+AzGmyL0+kwi/ew2Y7YrQQdsg6S7CGoW3lZ9Dxu7tk0nzRlcl3Yad92I7azjuO43BMowMLI1ydSqT3lIyWZ+p63NeXQg0C+UUwPm4L/XgiUM2nNvtBXycPc7qxp1RzQdpmg0fLiIwwyuSmasP1jqY/pr6xDam3Fotf68liTFrHk5GBVI4kWBNSl/sZVo0XGmPVfdXDl//OvSliJ1om2SLFfiLoQIF2CQTsQpQs95ZjmuzQwMK0n/PrpOirt8o5IgV1vkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nmma34TesQDE4r3Nv0paek8TNKT+bS/lc6Au+ROzruQ=;
 b=TwG0yysXn2Ad75C0FHqdyyJjBfmI9vJy2mWMIn53hav/LmA1UxYCp8bW0/H7OKascL6JNnbGuZxAppX+xqc8s96FdoVYCEHP7D1tRRP0+ECIaeUf+VPbXP+pXIyxvJBrzmC3+Jgapao+XaGzu1sA0KrtNYwvqqEbj/Syfu3brdhYFYgDcmDJHTz35RL5l8oFOoWQ1j6jC5y0b1hEiljVSSsPE8lan2uXp+IRHsFfk1//I5efMJcfvUR0oP1oSi4q2BSsMg6tkz5DpvOfrI3bidOA6YANWOUjgB71xwCUtf3LvudxHZJPivpGqQZKteJi6QKsVLpGpRf4c8V8imjE1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nmma34TesQDE4r3Nv0paek8TNKT+bS/lc6Au+ROzruQ=;
 b=fV33UK1+JkcX+FaXYnI1TXCiqiNneJx0MSK7YK15WQudXvI7iv9TVW3ZOiwnX3p8OtRsF5v3q24yIChQFA3+5bMMkeUdUZMoWbsXxL8zB8KJy0c7p/xSJqeBA0XhDfscJ7/N/xMlFF4B1MuULy16OPtaWCh4qFCOyWfoUJDDtqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PAXPR04MB8686.eurprd04.prod.outlook.com (2603:10a6:102:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 17:45:21 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 17:45:21 +0000
Message-ID: <af927af3-3321-4298-b195-154890d99ccc@cherry.de>
Date: Wed, 8 May 2024 19:45:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v5] enable stored U-Boot
 environment
To: yocto-patches@lists.yoctoproject.org
References: <20240508144336.31500-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240508144336.31500-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::28) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PAXPR04MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee3e4cd-901f-4852-05e9-08dc6f86a1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eHV0cFlEdVNPS0RlQUZwTDhmRlpuL1ZoeHNtcXVmYXFMS2QvUVlqM0U5bzlV?=
 =?utf-8?B?dmVyNTZRSDQrU3M4SEY1OGlHc3ZJaXFSMnVJQmtUZTlmbjFZUXMrVklSdzNW?=
 =?utf-8?B?YnhmOVpyQ2I3NGR0WDdxd1RHNkZvODJYNzFEWUcwaFJ2bHZFdHFpcDN2ODFC?=
 =?utf-8?B?ZjFSUlpGZ040UmkyNnpqWU16alN2YmJwdHNmNGUrNWd4QWs2Ym1obiswZTRC?=
 =?utf-8?B?QStzSGhzdkx3VEIzY0oxM2hqeVhTRkVuVk43akppUUJHREdEdS9vRjNKdXpZ?=
 =?utf-8?B?YlpHSXlKMDRPYjBtTE9BelpJT255ejJ4WGozNWJVZzBadVhiVFI1amZ4OFhj?=
 =?utf-8?B?dWlGczRxbnpWZ3hpZXgza3d2RFVZNUdoU2M4SDVQTlkwYkdFRGJiTUlSdDRL?=
 =?utf-8?B?cURBMkpEaUVlSTdobGVISkVTOGdGREpCL1RRcElkYk5teFI0OVB3bExFR1Rt?=
 =?utf-8?B?dkZSS2E5c1F6NG5Ob2g3RHRuaitVM2tSMEROUTlrWnpLd2w1cmZnMnIwdHc4?=
 =?utf-8?B?RXFNMWx0YWpMQ1FocEI4c3hOc2lwT1cvWXlpblp6eStqWFVFbW5zUCt6ZG9C?=
 =?utf-8?B?bnhPSGZSSXRwTzNtMHdOK1BJT2JWQ2JoUURzN0NoNWNuc3A5STJ6VFRUdFd2?=
 =?utf-8?B?eXpBWXp2N0RDaDArc3NabEltZjBjaElzZG4zS3Y0RUVzL2NTL1l4Y1lSK2N6?=
 =?utf-8?B?ckl2THg4QzZkcjExcWl2U0JKTWkwYW92bXdTT1dUNFRQR21odGlZSnJQNFNO?=
 =?utf-8?B?TmhOR2Q4dUVUZ0tHWUNCYytGU05qdEREaEtObk1JaGd1WkEzKzdMSUJBUEdF?=
 =?utf-8?B?R0RpUU5aalEyQ0hOYU5kcFcvalkvS1VLdWxXbFNkTTJqbCtyZDMrMENNT21i?=
 =?utf-8?B?MVBVeWQ0Rlh2Nk85cmFnMmpFT1gySjdQdzRXRGZocmhjOGVXS2UwejlRb1lU?=
 =?utf-8?B?eU15TzdpWnkzblpRVVVCY0w3bjFUcFJQU1hEamJXWVRIVHVJbUVQS2J3Smlu?=
 =?utf-8?B?UVlyS0VNaUtNRXo1ajB3VFI2Z1J5UzVYSmN4ak5zSlZma2F3eWp1enZNWFJz?=
 =?utf-8?B?cmlwR3orVG93aTB5M0xxQ1lFMmx3MVVJK1dkS0tCblg4WGEyZ0tLZWFXRkU1?=
 =?utf-8?B?VC9KRGRxaG94K2lwRkVERW1pbWREMlpGaXh0UGlkOHB5V2g4cE93bFV0T2wx?=
 =?utf-8?B?WitHbUNkVWxaTmZhVTA5T2dVZ2MxeUtVTTNkend4YTg1UkhzRUVkMnkwek4y?=
 =?utf-8?B?R0pUbTFBOVE1MEUydVpOeHZMS3ByZytwMWJkTi9odjFid2Evdzk3aUdMUlhF?=
 =?utf-8?B?T050ZHhyV0JLbGNjeFNZTU9LaDgybmIzVEE1ZEJITWdodHZWd001RFliRzNB?=
 =?utf-8?B?UWRNM1pwQ3hMaXQ4VmlvbXMyYzgzeUo0WkRkTkdNamZqZFJFb3pjM2RDeEtD?=
 =?utf-8?B?ZmUzdzR0MTl3aEhlVFpoOHF3ZTNCWDlHOEtyclZpQTFmbWhlUEJmMnF4YnJU?=
 =?utf-8?B?d3N6d1UxOTlCNFJ3ZDgwb3djM3RyUHU1aDE0UGx3M2srVTI0ak9vK2dCMHNr?=
 =?utf-8?B?WWZKd1VzcExySE9CU1R2emhOWXlTYTh2K3FrdlVrV2Q2cTdXTnBNcnBlbmxM?=
 =?utf-8?B?SHEwUHMxZ1I5S2lTalZEa0RnOHBFMWhnR3pjUm55N1UvZ2FLMUpMcm1xb29p?=
 =?utf-8?B?amRaVFVhdUt3TkZvendwV0ZxWXErcng0a2ZwV2pWTTB6Y0pPWVVobG93PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVpuT2FuZlp1dFlsbmFCRFozYmM4V2kxcFA1Y1Yybm5mK0NFcUwwVEN2aUpq?=
 =?utf-8?B?dFdrZU13bFA4NU9HOTl0WTQxRlpFeWI1V2VySHBIMHF5RnRaT0RRbVFQbTJX?=
 =?utf-8?B?R3VSdXpEcUNvemVweFBtZytJbzY3Z2U3ejNHNU53UXlEQnZYZnByOTFvM0hY?=
 =?utf-8?B?cGFjc1FsVU5IMUV3MVVnVFlYcmMxZENWNzZGODF2c0pyQUdIcURrTmJMaXFi?=
 =?utf-8?B?MVk1dnZKNmdOWE5IWTk3WXZ0MnRpZ2lFQjZqK29OL1ZCclMzM2NWVVVaTldl?=
 =?utf-8?B?YUNXRXNIOEFUak9ua2lpY0dqWVFuY1FqWDVrSG9pbTVLc2trNUx4T280V3k3?=
 =?utf-8?B?elJiYkVaZmFhZjhwQk1VRXE0UFNBZnpCb0ppU1BWZjkxV0phS0ppNWJQWm1D?=
 =?utf-8?B?Z2syY1pPUlJIeDEzN3IrbjR2V2xvT3orM0Uzczl5VzNBTEk4VVNBaTg0ckha?=
 =?utf-8?B?YjM5aWpXS3k2cU1KelVSdHpzTExDOU1TWGJta2ZkTDlZYzc3T0pXVkJYNHVO?=
 =?utf-8?B?WjQrMU5JKzB0SmRvOHBLNG5ZNWJLSlR1SXcwTjR1Y01EYkNUdCszaDdRamZY?=
 =?utf-8?B?VWl5dGI4WDdEei9rVXA4OVpMQ2k3aVBaZEdnejBrUUlYQ1VadEdpWERwdGdo?=
 =?utf-8?B?aXF5OFN0WmtOWm43blRFRkZrK0p3U042c0tmQlBYc25yaGlkM1J0VE5ZS3RK?=
 =?utf-8?B?eU80bWFXQ2dnY3JYWTJMV1hrUms2dUVHbEc4dGlRZWpIWGVOMWREZTNleFE5?=
 =?utf-8?B?Wm01SWZsekFMMFh5NS9UMS8yMEdWbW1WM1lhLzZoT2IxVm1PeERPdzNJT3dk?=
 =?utf-8?B?Rnk1WW5oNS9EMjArUGxoTW9lak11bER6U2svMUN2RmpsZUloTml2Uyt3QWor?=
 =?utf-8?B?akszL1VVZS94dHJoYUFCa21uZ3JnY1ZCcVZoQ1VYNTEwUldjM25vbmFGRk42?=
 =?utf-8?B?dUZIWUlWTlIyc1dQU2NGRkRqdWlFdUxwVk5QTXJSQWgyUzlEUUxkNUkrWkFK?=
 =?utf-8?B?U2gwcTYxVWZGQy9DQ3RHTVVLdTdnQktjckJsV2R2eFVqaFJwQlp4MlZYRjhD?=
 =?utf-8?B?ZHkxRkpsWUp2bjJlRjBxQzZwWW1TWUsxSHJyWDI1TFVnZHZNQjVrbmcwNHV1?=
 =?utf-8?B?Y2tZemJtSml3SUx5WEhsYXQ3SU5VTnhTQWpwZjJpREdYeTIxYnB5c0pWVi83?=
 =?utf-8?B?ejYwVGtQV2JZTFBaU053dC9MaFFhNHNzbjdZSVNuWnVmSldFVkUrMlZ5c3pH?=
 =?utf-8?B?V0xUOUx0aEFEaTlPaWFEVWtZK3lmMHhHUlhvMkVLNHl3SHZZeVdOQjN3aHBq?=
 =?utf-8?B?U1JQUkpURHA1a0tHd291K1V4L2Rodi9xSHRJYklRY1RWRk1UVlVSbWxwbFpE?=
 =?utf-8?B?VTFUaWVsVjFvWXMxRklGY0ZOOFlacEQ3Njg5V2FLNi85d0pteVZ6dlRYOGVS?=
 =?utf-8?B?d1F5Wm9LV2IwWnhnRVJDMiszRGM4UG9POFQvYlhDdDBrM3UvazBXakpWN09j?=
 =?utf-8?B?NWJwNXNQSjNJRkNaU3BnMUI1Qm5NN1owN3RYZmR4YytLa2Y2NXVWcGhVdXlm?=
 =?utf-8?B?eXo5RzVQSUtIMTc1alVZQUZlWnp1ZjBwcGlyRWpyeXpwQk1xbkxHa2xEaURy?=
 =?utf-8?B?TU1yV2FhcmJ0bWU1QysrODg0d0JZTk5STG9uVnRCR2N4bE9iaGpGWGNzSyta?=
 =?utf-8?B?d3NJd01JeG1hQ2dRLzNoZitDNjR3YVl1WFpodjhqdUh5N1FuSHhONzM2ZHRp?=
 =?utf-8?B?SXl2clpRWFo3Z2JiN3BOUXBsV056OFU4cy8wWG5sc0xidjBadjlXajMwb2RB?=
 =?utf-8?B?cEtqclBWWFRBeFNIdmxVK0t6QVJBZ1VvREdsazJObWZVWXlZK3VOYVpiZXB2?=
 =?utf-8?B?SnRQeHFSQjdhMHFBQzZrM2xIbXlhNmtLVTd0WjJ4bnIvb1JtUHZsV0EzclNN?=
 =?utf-8?B?MytPTm8ydnFoYnZ6ekF1UXZ4cS8xSnUyL3VMclZhYW1DTnQwVlRhUjVSV3hY?=
 =?utf-8?B?NlZCS1pUemJ3UmJ2ZXJRTVJBb2htS0lHb2xWMnNOY3Z1eFRLeTZhd0k5bi9x?=
 =?utf-8?B?VTA5ek96dTFLcUpvTHJnNmN4Y25OMnY5SXNPaEo2dGVqV1RsTlgydjNoZ0tr?=
 =?utf-8?B?RUxhRUsxTGxyb2tPcklJMXh1bEViZmNGaFFWY24zdjRNT21SZmw1cm9STWFK?=
 =?utf-8?Q?RokNYoIW87jf2SYxJoyLcrQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee3e4cd-901f-4852-05e9-08dc6f86a1e0
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:45:21.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C054I7j1yAUHO9ktx6/0WUzP6ZnaliiYpnVnyhEPYcz/VD8lsCmHqr+zVJvqGaPbdQy37VPjxVL6al11gMarxV6X2ItYInbsKHKTp3hmOkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8686
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 08 May 2024 17:45:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/105

Hi Trevor,

On 5/8/24 4:43 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> U-Boot has the ability to store its environment variables to a permanent
> storage device. Whether or not it does so for any one specific device
> depends on whatever settings are enabled in that specific device's
> defconfig. In order to definitively configure U-Boot to be able to store
> its environment into the device from which it boots, for any device
> supported in this BSP, simply add the following to MACHINE_FEATURES:
> 
> 	rk-u-boot-env
> 
> If enabled, there is now a second choice to make: should the build also
> include the U-Boot environment in the image or not? The default environment,
> as generated by U-Boot, can be included in the generated wic image. If it
> is included, then flashing the image will also flash the default U-Boot
> environment variables and settings, wiping out anything that might have been
> there already. If it is not included then your device will either continue
> using whatever environment happens to be there (if valid), or will not use any
> stored environment if the stored environment has not been set or is invalid.
> The variable which governs this behaviour is:
> 
> 	RK_IMAGE_INCLUDES_UBOOT_ENV
> 
> By default this is set to "0", meaning that by default the image does not
> contain the U-Boot environment. To enable this behaviour, enable this
> variable. This variable only takes effect if rk-u-boot-env is listed in
> MACHINE_FEATURES, and has no effect otherwise.
> 
> The script:
> 
> 	scripts/dump-uboot-env-from-yocto-image.sh
> 
> can be used on a rockchip wic image to see the contents of the U-Boot
> environment partition at build time.
> 
> Tested by booting the same image on both eMMC and SDcard with the following
> devices, verifying the ability to read and write the U-Boot environment in
> both U-Boot and Linux user-space, and that changes made in one are seen in the
> other:
> 	rock-3a
> 	rock-5a
> 	rock-5b
> 	rock-pi-4b
> 	rock-pi-e
> 	rock64
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

