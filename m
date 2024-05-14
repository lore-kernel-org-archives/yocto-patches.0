Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C61DC04FFE
	for <webhook@archiver.kernel.org>; Tue, 14 May 2024 14:01:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.111])
 by mx.groups.io with SMTP id smtpd.web11.16389.1715695311604065404
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 14 May 2024 07:01:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=ee7BeCua;
 spf=pass (domain: cherry.de, ip: 40.107.20.111, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e83WRxuSLfPvD4pEOTb7oGMfYwooLX4U6Qe6CT4IWe4V4TRu79Ppd3zdJ0BPkqqs0cMstpfYP6b0WZ45CAx21ow1lalBcTQMeFbJtRf1JNJEQ9k8sG7o0aJ8pbY6FgZsQt263X5fMEhMGKWlYht82v4Yaxal1LbEv+g3cwIQ4IL25v91bECSdkCuCXNy9ONdYz86OZExgq/OjNw1CJlhlLcBJQVHCHbRnNotcS9ciV5EjP9h0qpB7xR629sTakNZ1vPEiGXiPiJW0RZaq8zRCgERR6J5FuhvAsU56QKVnGYxZUjO9P+0q+41hmQtd4XpKEW2U/Wx717oFqNYov1ChQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/j0roIIA4hv8HLsUbjGQHjdwm8e908FAna7iSrwDzo=;
 b=FtSrCI0Av+tYnmXMuz5sz79p6e5a5efEjdhYwwWn/6WgeNvccYO36CHkUYgSGCfO+lRL2wLTBhHRmaTWyEylTvElglVq6DLUilfLggM0lCJ0j8n/nrrNv8RmEdPXx8QBhZkrdgPwSM8PcPVCse/kaCt2v7oJUquOMPfSWK5vAWjTUuxoBWGa68ONU49JA/K0VKi76IaV78lB0DRkc4NC822votsIPL6bv37rUWu+Pja+dqzij+UJhKu2yJDCGdCee/1FvAoR7u4a80IA8kSoMqlNBccohGlEfiNxevViT0IqNR6Glz04MiHmQRXP1jx5rq7+423BmQz+69zWtPgzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/j0roIIA4hv8HLsUbjGQHjdwm8e908FAna7iSrwDzo=;
 b=ee7BeCua+/PeBA6+xo8ei9P4Ibj/nl2WjGoRW7jRw9N8vrCm/r7/n0yeKk4MHicKnTlg8cdg3HmkriF0KGXNENu6YX1jPscjarlO67jmqnfWvU6FrHTUy0xMv18NoxM9hIuecHoBl39pfrXpLWz+GnPJoSQ+W2gs8WAhv2CB5qE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by VE1PR04MB7328.eurprd04.prod.outlook.com (2603:10a6:800:1a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 14:01:46 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 14:01:46 +0000
Message-ID: <e01261db-84e3-4914-a51b-397be9edfb14@cherry.de>
Date: Tue, 14 May 2024 16:01:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v6] enable stored U-Boot
 environment
To: yocto-patches@lists.yoctoproject.org
References: <20240512022815.39350-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240512022815.39350-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|VE1PR04MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 49dc92b5-361a-48a9-93ed-08dc741e6451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TTVyWWNVcFFOclFhZ1RyZElLTFVyVnZPd0ppaHF5Um9yMjNUa1JETng2bExW?=
 =?utf-8?B?a2EzdDFlVXFoRjRYTjROOThZVUJ3TkE0U2FqVUdHSG5iS25GS2E4YmwzRTNW?=
 =?utf-8?B?WFFPMXNKS0lINkVFcXoxV2dBSmVUcE93M3pYc1VIb1oxOXk4ZTRheFBUZTNB?=
 =?utf-8?B?czhjakJzTkU0bStUT2srWnVKWVhNNmR4S3ozZlV1ZUd3elNqcEtNTVRCa2lT?=
 =?utf-8?B?cEFwUmNmUXlCUVBVNkEyMXlNYnIxd3gyNy82SHl3WjNmODhJNk5qcE1QNUE0?=
 =?utf-8?B?R0dsS1ZmMDZtYzBzTXM3d3V5VmtDTE02aGlMTmdmTkRFOW5CMVR5TjBLc2c5?=
 =?utf-8?B?bVp6aE9OeUF3eGh6ZU10NGpVMUdOWm40di9mWTB3dzJHaDlxYnpmU2ErQjU4?=
 =?utf-8?B?L0x2SWVpeWdIcGF6OWRwbTVFVld1aC9iRWpZU0gyUzhnbnd5SGFKdXc3YzBB?=
 =?utf-8?B?cjFlazY5QURYeDBTSDNtS2F5bDBlUXFhTUUwdzNWNi9iMlNMTGcxaEFveE5a?=
 =?utf-8?B?bE55WmdZZDRiMmxQRHRsMG13enBBYWNXdHUzWW1hZEg1VjREejdSd2kxNWM2?=
 =?utf-8?B?UnBBSUNzNUJTQ2xVaVZqRmFxelgrTDZoS3g5MklXNjRuWUs1TFJCeEVlSWgv?=
 =?utf-8?B?NlFTVFV6dzhERm9yMzBNM1FKV0dvQ20xYXlVbTBWZVp4SU5zWFFFSUdhajFS?=
 =?utf-8?B?SUNYUFFJUEdpdzg5TWppQXJBU21nRTZKWnZSVXVXYUE2QXo2L0oyNlJsMXdR?=
 =?utf-8?B?S3FhQ3ZQNVhCcWI3NldnVTllcm9aZ1Qrd1ZWUk53cS9PRHN5Nm5IVTVITE9p?=
 =?utf-8?B?SFNwaXlZdmRWMXBRcGxvazBMc3NhcDQydWdScHVPSlBMUWNDTFc4SlFjcVlm?=
 =?utf-8?B?cndGMjNRUGdFNE00WTRNR00yZFdUSk1IVHdOQkFndCttZDIwbVMvSzU4aEtT?=
 =?utf-8?B?RVBpS01zZWh1UVl2eGk1bllneEFiZDM5NjZMV2gwNGJKdVYxdmRYeTUrMzZP?=
 =?utf-8?B?c3U4cEFxdFZOMDRnemh6UkdKK0wwb2ZQRkpQc0o5cW5waWVzQWVCYkxqaDhJ?=
 =?utf-8?B?a1QxaU9FYS9YZStveFJFNG9QaS9OSUNzSXV4RExPaC9hRTUzcVo2WkVBVXBi?=
 =?utf-8?B?MzNoMkFHU2hmU0J3UlRhaFJiMGs2QjY3QXNtQjdURDNEdVMxL0FOZFZRZGZP?=
 =?utf-8?B?a3d3NXRkRXVuOU5EbGJVb2F6YlNUVmpCamlzTVl2VjljRXEwUkpMVzQwQUR0?=
 =?utf-8?B?RnFoWFAyQzZyMXE3L0xRR2NKTDVLZnRRejUwTlVFTjlheDlQNEN6QmpBTWdk?=
 =?utf-8?B?VTc0aldYcmxWUnE5c0NxRkpSN3JWdEExSUpSRzQ0RnZIRHpGUlZ5SDdra2g1?=
 =?utf-8?B?N3Fwb04rSVRiT0dlQm5Ea2dzbzQ4RVYvMG9sd0laRzVONU9SL21mbTZLdXdV?=
 =?utf-8?B?TlZ4eUQ3SnVaY1N0MUlHQXN0US9tQVNUaWpCcUtjRk5scWJMaTB0cnRsQlI0?=
 =?utf-8?B?eDF6UW1EeExrTTJmZGZSVFUvZHlCazNnNFA0QU1XSUo1dzh2cTZJZ0NxbE9k?=
 =?utf-8?B?ZlBkMDliUDVvS2N5dkRhd3NVYXQ0S2lVVG9rVEI3MmdsUXdPRXg5Q0N6RnBO?=
 =?utf-8?Q?MFzKyZ9PExiHyc3rELqWHYtsNbLzIs0bdWzWCkFRDoEA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6589.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Ti9Bd2pRaXcraG45OGhadWQwU2VReTFHaFBOTU9iTUh6SUFjbFBrczdKb2hZ?=
 =?utf-8?B?RktwTGp0enBIWVZlcWZUMVh5TmJLN2NpYU8xRU1JYXNvSFZ1MStmQUQvTUdX?=
 =?utf-8?B?aEtlYXNmSVl0ZjNCOTZYQnlCNU5kNGQzT0VxVTBnQ1JIaHVjY0laTU5reTdU?=
 =?utf-8?B?RThOcFdUOUttaU1RUHlEQTNUVTdLeGdyZ2hURHVYa0w1MWNHcEdhcXVUYW5y?=
 =?utf-8?B?RWN2NlJtQjBKSDQxRnJzY0V0Q2cyRjVibWN0Y1F3b2xXUFVTNzBhWFYxdlI5?=
 =?utf-8?B?b2tUUnZBN0RlV3FocVNZeFlXR3lkeENnVS9IWmU1WnRobVhzV2swelBsbEJk?=
 =?utf-8?B?YW4zaTNjbXhYOExRaVVnZ2ZhZzkvZVpEZ285SGJJcG1ydi9SLzYwakw3YWZW?=
 =?utf-8?B?SHQ0RXlPNkJvb1ljeW5pc010Tk1hSEZsUThWRzNmQWUyaTBMN2VPc3ZNN3Jy?=
 =?utf-8?B?Tnk1ZjFSK2RaRGw5aDFOdm9JekdOQytBNEZFSjVERUdFYVVHTGhJRTVEdTBO?=
 =?utf-8?B?cFVkcmJuYjIzMy9VbGRxdktnTkduVHdmSmJBaTRmR0JXL2NtLzFDd1lJdC9l?=
 =?utf-8?B?WFoyZFNmNEtQQkdxQUtBYlhNQTNCeDJac2xVaFpIbXNwZjhWemVNRHpIUG1G?=
 =?utf-8?B?NzNMWEZmdTFRUW9XdGlLNzRUSWJxVkEvUElCM0pVbG9FU0JvU0VWcjlUWkxn?=
 =?utf-8?B?OG9odm9lT3l1a011Tmx6Y3BndW9lZ005ZjZNUDREaldGOWZIaVdFQ0NWZXgw?=
 =?utf-8?B?L2ZEVGZmRW5NUjA2bUtOSWkzQ3JIT0lhN3NrLzBTTThrcUNFMXVGWnArN3hl?=
 =?utf-8?B?VjZVQ2V1a0M3ek84KzhudDhRS1dTaVoycENKSjd4bDgzNmF0dmdKeTBZNlF5?=
 =?utf-8?B?N1hFM1FTaXArN1ZCYks3Q3BpaWx0a1NDd1dzUjR5L1d0ZGZoNi9PNm9wWGVp?=
 =?utf-8?B?bjJLNHJXYjJPMDJmdUJZTzZIUW9SYjRZclZaSWllbjUvcjd6cjlUQWM5ekFT?=
 =?utf-8?B?cWpLSnhkRy90NkZidGhjVlhVRlltOTJqMzVUaDc4YXBodHBGVDFaV2NsZGpU?=
 =?utf-8?B?WGl4Z2V4N2lUSjIrcTZRekJuWmI0aDhqcmx6WW5xODZ2bmVaWXVzN1lnblZk?=
 =?utf-8?B?bUVsV2FudjRTYzY4WVZvNjlSeU9pUElnc1JVRUZQVDJhMWpDSU0xM1d6UXl6?=
 =?utf-8?B?THk1WUh4dEQvUk1jQTJlT0JBdHlMV0F3Y1RPRXR6Nk5mVjVBaHBaNDdKelRj?=
 =?utf-8?B?MmhNbUxnaWJSZVE2blo4OGxoR0kxUlowaFNuUzVhaEk0NnhqRE81cjJNdGVy?=
 =?utf-8?B?THNsNWNCMlp4VlNtNlp3V25SMzZyL2xITnh3UUFYL1I1WWg1UysyQkE0Z1di?=
 =?utf-8?B?THN3VDdYVXo1bC9ObjBRSmlTSmlFMW1kREx3Sk5HVDhJdzRkWVZkOFBlTFhy?=
 =?utf-8?B?ZGx6c1ppZTZHU0QzZENqNzRYbXZFZHBNbmY1Y0JMS0RoVHJpM0owbkN1WHl5?=
 =?utf-8?B?NEdMRFc5WmFyQW5UNWJibzlzNjBFemNGR0VGOXpLTktLWEFPSFNyMElTVUFE?=
 =?utf-8?B?dUtMa3EyZlhKWU5UdlEzMHdrc0dFRjRKdm9jOVFwenN0NDhLK2l2MHpVRmZo?=
 =?utf-8?B?TXZHQ2VHSDMxUmVxZEE5My9IRnBOWnBiYlRtR0c4QkRDTnZDVFFHaEFhcnpI?=
 =?utf-8?B?WkxyNzVCUUpGRy95U1dmQXZRRzlzUVU5REtabEtzZE1mVDV0SGEveVJMbkZw?=
 =?utf-8?B?U1BiREhTTzhLWHZNOTkxY0JudVVFT3o1d3V5R1JtZHhpK1pQc2g2akNibTlR?=
 =?utf-8?B?aE9FOTNHbWltNXpWK0tkbDdBRHpBTTVHQm5TMldXM0tYUlhWaTZhTlkxU1Qx?=
 =?utf-8?B?R2lPNmthemMrWnl4UmQ0TWhLNVV1VVM0b1JSQ1F6TmQ5Vm5YTEtUdi9YQmZu?=
 =?utf-8?B?Wkc4WjRsMGlOK2FyeU96OTZkREpmZ0JJRk1oRlJNM1hoYkJFTVp4ckgyMW5w?=
 =?utf-8?B?ZzBYbSs4OVI4NVVnRjdKVVhsNDJPY3UvRUR3eXBqeWNtazBMUmt6OWllWUY5?=
 =?utf-8?B?M3JmbGN3YnlscjAxMzd6UFl0MmZxdFJTeGFQYmJlcG1hM01qbk9LVVVkakpP?=
 =?utf-8?B?bmdpYk9UYW0xbXNzTjg3TW9nZ1FaUmFyWDhQWUkyaldEb0lQS2w4UGZ1Szhv?=
 =?utf-8?Q?RjLha8yyOmxbPwQfOW1JeI4=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dc92b5-361a-48a9-93ed-08dc741e6451
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 14:01:46.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGxcXjJ7iCz6fhrx8/T3/KJnXUNMKz9BFZ8oTx8MtVL1iKWMEHY8aErw/5xkKYj0vnRla8s6/GfPAEx6983bzlve91YQ2lizGjLMzpjpE3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7328
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 14 May 2024 14:01:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/136

Hi Trevor,

On 5/12/24 4:28 AM, Trevor Woerner via lists.yoctoproject.org wrote:
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
> ---
> v6 changes:
> - separate out the MACHINEOVERRIDES handling into its own include so
>    that it can be included more flexibly into different scenarios; i.e.
>    rock2-square build was failing because it is not wic-based
> 
> v5 changes:
> - fix a bug in v4 to handle RK_IMAGE_INCLUDES_UBOOT_ENV correctly in the
>    bash test in postfuncs of u-boot bbappend
> - add extra check in do_deploy() of u-boot bbappend to only copy the
>    environment if RK_IMAGE_INCLUDES_UBOOT_ENV is true
> 
> v4 changes:
> - sort WICVARS alphabetically
> - tweak dump-uboot-env-from-yocto-image.sh script to not just check for
>    the existence of the user-supplied parameter, but that it is a file
>    specifically
> - u-boot bbappend:
>    - use a do_compile[postfuncs] for generating the fw_env.config instead of
>      a do_compile:append
>    - move the conversion of the U-Boot text-based environment to the
>      require binary representation from a do_deploy:append to the newly-created
>      do_compile[postfuncs] created above, this will allow the user to inject
>      any extra U-Boot environment variables they might wish as part of a
>      do_compile:append and have that occur before the binary is generated
>      so that those additional user-supplied values are included
>    - add a lot of extra checking (instead of assuming various resources exist)
>      before making use of said resources
> 
> v3 changes:
> - switch from using a bbclass so the `rk-u-boot-env` override can be used
>    directly
> - add SPDX header to script
> - drop `inherit deploy` in U-Boot bbappend
> 
> v2 changes:
> - re-word the commit message and README for clarity
> - use bash's built-in math handling instead of depending on `bc`
> - in anticipation of the upcoming feature in U-Boot whereby rockchip
>    devices can automatically select the environment storage device to be
>    the same as the boot device, use a more recent SRCREV for builds that do
>    environment handling, instead of hardcoding the environment storage device
>    by SoC family
> - handle RK_IMAGE_INCLUDES_UBOOT_ENV as a boolean
> ---
>   README                                        | 20 ++++++++++
>   .../include/rockchip-rk-u-boot-env.inc        |  4 ++
>   conf/machine/include/rockchip-wic.inc         |  7 ++++
>   conf/machine/rock2-square.conf                |  2 +-
>   .../rockchip-enable-environment-mmc.cfg       |  6 +++
>   recipes-bsp/u-boot/u-boot_%.bbappend          | 40 +++++++++++++++++++
>   scripts/dump-uboot-env-from-yocto-image.sh    | 29 ++++++++++++++
>   wic/rockchip.wks                              |  2 +-
>   8 files changed, 108 insertions(+), 2 deletions(-)
>   create mode 100644 conf/machine/include/rockchip-rk-u-boot-env.inc
>   create mode 100644 recipes-bsp/u-boot/files/rk-u-boot-env/rockchip-enable-environment-mmc.cfg
>   create mode 100755 scripts/dump-uboot-env-from-yocto-image.sh
> 
> diff --git a/README b/README
> index c76fc9131276..605773d4ecd3 100644
> --- a/README
> +++ b/README
> @@ -67,6 +67,26 @@ Notes:
>   	
>   	in the configuration (e.g. conf/local.conf).
>   
> +U-Boot Environment:
> +------------------
> +	In order to configure U-Boot to be able to store its environment into the
> +	device from which it was booted, for any device supported in this BSP,
> +	simply add the following to MACHINE_FEATURES:
> +
> +		rk-u-boot-env
> +
> +	If enabled, to additionally have the U-Boot environment generated and
> +	stored in the image, also enable the following variable (default: off):
> +
> +		RK_IMAGE_INCLUDES_UBOOT_ENV
> +
> +	The script:
> +
> +		scripts/dump-uboot-env-from-yocto-image.sh
> +
> +	can be used on a rockchip wic image to see the contents of the U-Boot
> +	environment partition at build time.
> +
>   Maintenance:
>   -----------
>   	Please send pull requests, patches, comments, or questions to the
> diff --git a/conf/machine/include/rockchip-rk-u-boot-env.inc b/conf/machine/include/rockchip-rk-u-boot-env.inc
> new file mode 100644
> index 000000000000..4eb877f77c48
> --- /dev/null
> +++ b/conf/machine/include/rockchip-rk-u-boot-env.inc
> @@ -0,0 +1,4 @@
> +# 'rk-u-boot-env' indicates the user wants to be able to save their U-Boot
> +# environment back to the drive from which the device was booted
> +MACHINEOVERRIDES .= "${@bb.utils.contains('MACHINE_FEATURES', 'rk-u-boot-env', ':rk-u-boot-env', '', d)}"
> +IMAGE_INSTALL:append:rk-u-boot-env = " u-boot-fw-utils u-boot-env"
> diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
> index 147a36685d7d..1f662116d7cf 100644
> --- a/conf/machine/include/rockchip-wic.inc
> +++ b/conf/machine/include/rockchip-wic.inc
> @@ -1,6 +1,7 @@
>   # common meta-rockchip wic/wks items
>   
>   require conf/machine/include/rockchip-extlinux.inc
> +require conf/machine/include/rockchip-rk-u-boot-env.inc
>   
>   SPL_BINARY ?= "idbloader.img"
>   
> @@ -11,7 +12,13 @@ WKS_FILE_DEPENDS ?= " \
>   	virtual/bootloader \
>   	"
>   
> +RK_IMAGE_INCLUDES_UBOOT_ENV ?= "no"
> +RK_UBOOT_ENV = " "
> +RK_UBOOT_ENV:rk-u-boot-env = "${@ '--source rawcopy --sourceparams=file=u-boot.env' if \
> +	bb.utils.to_boolean(d.getVar('RK_IMAGE_INCLUDES_UBOOT_ENV'), False) else ' '}"
> +
>   WICVARS:append = " \
> +	RK_UBOOT_ENV \
>   	SPL_BINARY \
>   	UBOOT_SUFFIX \
>   	"
> diff --git a/conf/machine/rock2-square.conf b/conf/machine/rock2-square.conf
> index 9468b9a6b559..bd36b2ecfcc7 100644
> --- a/conf/machine/rock2-square.conf
> +++ b/conf/machine/rock2-square.conf
> @@ -7,6 +7,7 @@
>   #http://radxa.com/Rock2
>   
>   require conf/machine/include/rk3288.inc
> +require conf/machine/include/rockchip-rk-u-boot-env.inc

If this board isn't using wic, would fw_env.config still be correct? 
It's defining a partition to use by its label, which we probably haven't 
set for that board?

What about adding the label + u-boot-env partition in 
classes/rockchip-gpt-img.bbclass? It wouldn't be matching the partitions 
in http://rockchip.wikidot.com/partitions, (we could reuse some of the 
reserved2 partition for example) but you could then still use the same 
thing for both wic and wic-less platforms? Otherwise just not requiring 
this file for rock2 and specify in the README/machine conf file it 
doesn't support this mechanism just yet?

Maybe we should also migrate it to TPL in upstream U-Boot so you stop 
having to maintain this part of the code that is specific to the rock2 :) ?

BTW, I think you should be able to migrate all (but rock2) rk3288 to use 
wic instead? since commit 295b58facfb37b84b1e2d871dd4822d8c171dbbd at 
the very least? It looks very similar to the offsets we have in the 
current wks file?

Cheers,
Quentin

