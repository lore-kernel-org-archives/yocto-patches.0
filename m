Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFAACDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 16:58:48 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1753.1782147522260644488
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 09:58:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=U5RrXk6U;
 spf=pass (domain: cherry.de, ip: 52.101.69.24, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANe/5zvOeI30QYBxpPcGZKW50WnN0vMg7tofKQjZlqlpCjiLEtoie+LX8+njg8x4Uqo71HZT6ISmR/KueZKw6V86RjzgpMHu9pNxs/sXSlYib/ilZIQ6aeUUA/OCr3tDaY4bmN9mpsr44vbEbYNzyqjV0luPxW946XyiJWZJcAniq+AKN/lSkvQoW6F66t7GPbRRk1vRV0SdxM6fX68tj55rr9ul0dFwrUGhNk/t+L5kea+pPDlKR3szx+f1ZB7Hv4UNM1qfbFIiFDPC+Njy+U47nq0OCSnKKfvzlKxpX84NW8nsRZYhf5BkX8a0VW/OQN1kH9YakJXY+9IaQxLv5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D553Pi7e5cWWp0pUCgQCEi6Y5jNJsby+T2cLpe5oqZs=;
 b=aKqwO6e7zOsGUdT6zqay+4w4zjG/+ctAVzC+C2D+h67jP2iONtUq00GHHByqXJOGcmrfV6/9Yt4HQ9wyHWfveUhZ+nsSw8DCOGYFpJ6VJv/vFTNrPvBU3/vGCSazPo4wZR06GBgtlAaE5zxDcxMiBcWoqAUS+x8KxVLmdg8pD67bAW1mXM+7iAxg6Vzs3D85mn36XWlO1SNXynUGXtoOsfqkd7JnpVWtZj0oTcigF13+m0ZIS1Bkf+AOQ4mbGmjAcPLdJFJIzb0xAWS7Jak+kCluUvETe9x6O8sCRc8ynrdXooKz2rcJ3WgRaFgxpT+sfdqkqKNefgn9B1jeszo/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D553Pi7e5cWWp0pUCgQCEi6Y5jNJsby+T2cLpe5oqZs=;
 b=U5RrXk6UuRUsVFYeAEo5fSFZ+JHtxyXFnekBy1OMewTcJUARnt//NoMSIhm6s8Iagj7dSqNRNQwGoZijb/oZvc6U4MZkHn/9q717N2ed7SMrjpiHkBZu48LuPByHXQ9cu3ca+dxF+AwSuLOmwaXERKLmQb8uQQ+C2WhLLSUYRdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI1PR04MB6862.eurprd04.prod.outlook.com (2603:10a6:803:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 16:58:36 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:58:36 +0000
Message-ID: <e077695d-03a0-4910-8e3c-d8859dbda058@cherry.de>
Date: Mon, 22 Jun 2026 18:58:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [rockchip][PATCH 1/2] rk3576: add initial support
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
References: <20260621211915.72650-1-sputnik@on-the-web.ch>
 <20260621211915.72650-2-sputnik@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260621211915.72650-2-sputnik@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0022.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::34) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI1PR04MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f630816-8296-442f-0646-08ded07f803d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|3023799007|18002099003|22082099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info: 
	T9We7olFQjOZ1sYEuAObqL8DytJRsGMpyyPOWJWT8rPiACwGmNPoiUaVtd2h7VQaSNWVUTV2Lyw7qOW5M5p56+tlciYExDlAZuaH9sOE+czhIxuUzi3dChiIqsrpuyTodp2LzQyqRZ0sNheNJDYF2/SRUkJOtn6IpaAece5cIh0omQHElJovTMGEhxqwvmqqtZx/VjtBy8b4ulL1ZfgM+ARB968uMalNR5iVe8AY8Q9ZlAHy9OvfqhI9V0Ucns5AqO4riPZu0mqLMKd1vmiiQb8rHpSmIzsO41Rjhnc2mgrqBLz4wDBWlreotrep7FL2ijqSb3rThv2WMiDIZjkhjx/nRL6BWkTidqlevhlF2rWVBJVXZSlYbbTBLc6PKly+RqSK39hUayiqhlE3uORmllok3XBRymgyaC+HEOy+Q9FAicw/T6KlFUhG9pfqw0h0pxjr3NgK7fwZ1DgyXxWJiHjLwEzljsnj6c4pjppUToYtdo3pc5Rw3n5eTEZmaL+Ux53evoTYmaXJywmRVPJ8IaDYZOCJFWxq/zc3vqkL+q5keU1yWj6anIVyzBAWLZ4Jtr0Q8yd6L84VBR8O6XPXVThyovyTRJbSbAdqcfGXdAKa20shG/I3w/MG+qz6hgjNhO9AtTe9JNns5WoWEFlxCvjBxDj22sF+E5dF9TF07fo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rkd1UHBoVldsVnVlamk1UHI2SDJvUEZ6cmN6ZklydGVKbUNsUG1nTnpOamlk?=
 =?utf-8?B?YUxFZU82UWZUcHpFbmRERWt4cHdURG9aSEJJUEVOSDd5RVJ4TmlMTFBUMitl?=
 =?utf-8?B?OHVZQllrSHkvc0Rsek5RVHJNVGNEUmlvN01QcVY4N2tXMXM4QUVZWDFIdTB3?=
 =?utf-8?B?eVFMcEsvbnBjazhpVm04aGRadXZLS1lLM2E2eEwrbDZubTVPdklXRWs0VHJY?=
 =?utf-8?B?MWlGR1lKbTZiYVpUMFVHZGJEZnptQ0NtTmJSQ0Y0NC9PczFDSWlDRmRwZXhh?=
 =?utf-8?B?b2xvK1kzNW5UbEZETTZiMEhUOTBVQThRWkpDVDBRcFF5d1BtYUl0MHdNdFZH?=
 =?utf-8?B?L1NxQkU2WG55dkZGSGpmcVBma0h3Tzl1SGY4eDBieXNMaFJOTzhCVVNpMlRZ?=
 =?utf-8?B?MitUSWdSY2dsaVJNOFQ5MmEzZCs4NHFkOWU3QmhHZVIyUnJHTWV3RVA0R1hr?=
 =?utf-8?B?aVloRVRZR3Y3SGNvT3RkWVZ0OFRxZHQzQTJkbU14RXU1Zm93Y2s2QThJUWN4?=
 =?utf-8?B?U09ac2gzYit4NjJYMTUvdm1VU01FYzhVZDdMb1lGVlZDV2FXQklIWWJ0QnJp?=
 =?utf-8?B?L1phd3NKNC9BSGN4aGUwMFdVU0JrdTdpVFIwa3dvTFNnVloyWkZUNVdZOVJY?=
 =?utf-8?B?dHVzd292RUVvNWtuaVZZQUpaQWhkYVY5ZGQ5VUloQUxPUjBuNDdrbnVrTy93?=
 =?utf-8?B?T3dTVlZoNnNudDRKNkxuZEZvNUNhSytmak0zaUZoZkxjNENqUEEzR0lHSHgx?=
 =?utf-8?B?OVFhTzZ4cmx1VUltekdhN0VVTjIrcjdESEhaS0tFaTZNZGxtYnpyL0RCNFRM?=
 =?utf-8?B?UnFaNnZ0cThZazV1SjhXSGI5RFBGTXcvbXBvb2tERHVkU1RFWU4ySE5PQmxw?=
 =?utf-8?B?YnhXTHdzVXlSU3N2NTBjc2FjdEtkalhBRUdwSHl6Y2FxYTVDVHFON3FRZmw5?=
 =?utf-8?B?RWZqS0Y3SG4xaTBUOXM4eFZIQ0gxNGJ1YUtjYkRSdU1qL1lOd2pJTlFpQ2RV?=
 =?utf-8?B?OXZ0UGlKTEFiLzdwMEFqRUtNa0pIQ2hCS01nNHIvZUg0OEkxSzRmS0JZWnRO?=
 =?utf-8?B?d3Q0amV4OW9HcGc5elZ6WE8rM1lzcXRuQ1ArK3p5azdwN2tySEN5dEZLeHp0?=
 =?utf-8?B?QngzTEsrZkVRZ2NvaWJrR1g0STNuYVB5NGtrcXE3ay9aMU5sRDU2N2NyRS9S?=
 =?utf-8?B?YktFRlNZbXhxYmRCNCswUTc3dHdZV0JLN1NVTFBxZXV0ZkFJTVZKRWZBTmFv?=
 =?utf-8?B?T2dneDdwa3ovc2I1M2Q5R3ovODJkSlVJcFlCZTBYMGpIcG9WWFFmdHp4YzZ4?=
 =?utf-8?B?dnBJQlFFanIrQndEV1g0WTRkeWFLRWljeTM5R1JSVjlnVFNEWTlOQllERDNN?=
 =?utf-8?B?dzBHSm9OaGFhQzIxZkRDbkhYcVFkVkJJNDJseDh5Y3JQYzFkZDNFYnFDODhz?=
 =?utf-8?B?TG1BcnBEOWhKWE1sZ21ocjRLMkorL3JRb1EreXBldjkvSklPV3BGS25zOUdC?=
 =?utf-8?B?cE5qeXBRaWl2QllGa2lISlB0R0Jkd0thV2IxczlyaGJaVzBBYVhGbGl1Mjhu?=
 =?utf-8?B?RFZ6cEY3OG43M3YvM0dFQ0ZnSHdnelRtM2VES05tTEtkL01rWFUybm1XWEtK?=
 =?utf-8?B?dlR1eVYzbnR2YmlicVdPTzdYdVZWaHp3VFJQU3k4UzcwaFl1QnJlbklyb1Z3?=
 =?utf-8?B?NEhqWVBnVmxTK1JoOFJseWY3WE43K3RYZ3BwejZlQVUrUWVUdk1RR08rd1FN?=
 =?utf-8?B?enJjZ1pENEVtNk1IVkpsbVI3SmtVdW9IUmFOMnFPU3psWjlkSE1adng5Nkcx?=
 =?utf-8?B?cy9Sb09YbFlZRWtyNm9Lcm0rLzhVZlF0UFZnOGFuS2NyMTQxV3oySkFoUjFp?=
 =?utf-8?B?S3c4UXBOY3p1Ynp3RDA4Z1hMSzhYRDBtbDVsUVV1QzZlYzVLWHVjWTErWjMw?=
 =?utf-8?B?eXN3Y0lOYzAvVFllRVVjYktkQmdpcTlHR2FLNTZrMUVJeVdGRmxSM0xNc09R?=
 =?utf-8?B?eUJRV3BkbG8rYjc5UWpVaTBEcjhIWFc1V3ZuaWFRM1ZQTWlvWWdZYmZCeC9H?=
 =?utf-8?B?VGxvSGVmbnZ5UWwybVJvclNtRExDREN4UkI5S1VBQjE2STRJV2xIR1dtZ0ZX?=
 =?utf-8?B?Vmp0VURXWG5WcnpxVjBQU3VYUW1UdTF4Q3o2TUhPZ09pbDg2QVNiWCtrSVlJ?=
 =?utf-8?B?QnJLNU1wQW1tUCs5WTF6TGxoQ1BRSmdYTm9ObERGRklEVU9wdWdXcnZHQllD?=
 =?utf-8?B?aHFTMStFTXUyS0Mrb1lYdnpzTG94TkZjMzFCNzUwNWpsWkJsVk9vblVjdXZQ?=
 =?utf-8?B?Q1A3UmJFc21HM21uUFpxT3FzckVvRlJvVGxoYTlYd1MwQ2pNNEsvQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f630816-8296-442f-0646-08ded07f803d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:58:36.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijH03XPbbveEoGNTRHI6lFsaqmTqaYtXKBOGN52l9WVUELnW4jPO6bdivINXyENEG1fmSG/3cGygedXiZido/qwRW6dKFRjv3az8Sw9DnJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6862
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 16:58:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4263

Hi Martin,

On 6/21/26 11:19 PM, Martin Herren via lists.yoctoproject.org wrote:
> From: Martin Herren <sputnik@on-the-web.ch>
> 
> Add basic SoC support for the Rockchip RK3576 using the mainline Linux
> kernel and Rockchip's binary TPL (DDR init), BL31 (TF-A) and BL32
> (OP-TEE) blobs from rkbin.
> 

Did you actually boot a U-Boot with OP-TEE OS from rkbin? As far as I 
know, this isn't supported by upstream U-Boot but maybe something's 
changed /me shrugs. How did you test?

> The RK3576 is an octa-core SoC (4x Cortex-A72 + 4x Cortex-A53) with a
> Mali-G52 MC3 GPU and a 6 TOPS NPU. It is the only currently supported
> rk3xxx SoC with a different RAM base address, and therefore uses a
> different UBOOT_ENTRYPOINT of 0x4a000000.
> 
> NOTE: a bootable rk3576 currently requires a U-Boot fork. Upstream
> U-Boot has the rk3576 SoC support and board defconfigs, but is missing a
> critical fix for a BootROM issue that prevents loading boot images from
> SD card; see the WIP commit "rockchip: mkimage: Add rk3576 align and
> sd-card workaround" on Kwiboo's rk3576 branch.
> > Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> ---
>   conf/machine/include/rk3576.inc               | 24 +++++++++++++++++++
>   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  4 ++++
>   ...
> /rkbin/rockchip-rkbin-optee-os_git.bb      |  4 ++++
>   recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb  |  3 +++
>   recipes-bsp/rkbin/rockchip-rkbin.inc          |  2 ++
>   .../trusted-firmware-a_%.bbappend             |  5 ++++
>   recipes-bsp/u-boot/u-boot_%.bbappend          |  5 ++++
>   7 files changed, 47 insertions(+)
>   create mode 100644 conf/machine/include/rk3576.inc
> 
> diff --git a/conf/machine/include/rk3576.inc b/conf/machine/include/rk3576.inc
> new file mode 100644
> index 0000000..acb4249
> --- /dev/null
> +++ b/conf/machine/include/rk3576.inc
> @@ -0,0 +1,24 @@
> +SOC_FAMILY ?= "rk3576"

Please use =, there's no reason to override the SOC_FAMILY for any board 
based on rk3576. If you took inspiration from RK3588S, it's because it's 
a mess with RK3588S and RK3588 being covered by the same override for 
convenience.

> +MACHINEOVERRIDES =. "rk3576:"

I don't think you need this MACHINEOVERRIDES with the SOC_FAMILY above.

> +DEFAULTTUNE ?= "cortexa72-cortexa53-crypto"
> +
> +ROCKCHIP_CLOSED_TPL ?= "1"
> +
> +require conf/machine/include/rockchip-defaults.inc
> +require conf/machine/include/arm/armv8a/tune-cortexa72-cortexa53.inc
> +require conf/machine/include/rockchip-wic.inc
> +
> +SERIAL_CONSOLES = "1500000;ttyS0"
> +

Please keep this in the machine conf file, the debug output is not 
specific to the SoC and thus shouldn't be defined in the SoC include file.

> +KBUILD_DEFCONFIG ?= "defconfig"
> +
> +PREFERRED_PROVIDER_trusted-firmware-a
> = "rockchip-rkbin-tf-a"

Can you use ?= here? Upstream TF-A supports RK3576 since version 2.13 
which is available in meta-arm already.

> +PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> +

Same here. OP-TEE OS just gained support for RK3576, see commit 
bddd9f2ea837 ("plat-rockchip: add support for RK3576"). No release yet 
though so that's fine I guess.

> +UBOOT_SUFFIX ?= "itb"
> +UBOOT_ENTRYPOINT ?= "0x4a000000"
> +

Why this address specifically? We use 0x06000000 for all other SoCs and 
the DRAM address start at 0 for them. Considering the RK3576 starts DRAM 
at 0x40000000, why not use the same offset and have it at

0x46000000

?

At the same time, we default to 0x40800000 for RK3576 in upstream U-Boot 
for the load/entry properties (c.f. CONFIG_TEXT_BASE in 
arch/arm/rockchip-u-boot.dts).

> +TFA_PLATFORM = "rk3576"
> +TFA_BUILD_TARGET = "bl31"
> +
> +ENABLE_STATELESS_VPU_GST ?= "1"
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> index 7f1e820..7427f57 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb
> @@ -14,6 +14,10 @@ RKBIN_BINVERS:rk3568 ?= "v1.23"
>   RKBIN_BINFILE:rk3568 ?= "rk3568_ddr_1560MHz_${RKBIN_BINVERS}.bin"
>   RKBIN_DEPLOY_FILENAME:rk3568 ?= "ddr-rk3568.bin"
>   
> +RKBIN_BINVERS:rk3576 ?= "v1.09"
> +RKBIN_BINFILE:rk3576 ?= "rk3576_ddr_lp4_2112MHz_lp5_2736MHz_${RKBIN_BINVERS}.bin"
> +RKBIN_DEPLOY_FILENAME:rk3576 ?= "ddr-rk3576.bin"
> +
>   RKBIN_BINVERS:rk3588s ?= "v1.18"
>   RKBIN_BINFILE:rk3588s ?= "rk3588_ddr_lp4_2112MHz_lp5_2400MHz_${RKBIN_BINVERS}.bin"
>   RKBIN_DEPLOY_FILENAME:rk3588s ?= "ddr-rk3588.bin"
> diff -
> -git a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> index 0f3c927..35a102e 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb
> @@ -19,6 +19,10 @@ RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
>   RKBIN_BINFILE:rk3568 ?= "rk3568_bl32_${RKBIN_BINVERS}.bin"
>   RKBIN_DEPLOY_FILENAME:rk3568 ?= "tee-rk3568.bin"
>   
> +RKBIN_BINVERS:rk3576 ?= "v1.05"
> +RKBIN_BINFILE:rk3576 ?= "rk3576_bl32_${RKBIN_BINVERS}.bin"
> +RKBIN_DEPLOY_FILENAME:rk3576 ?= "tee-rk3576.bin"
> +
>   RKBIN_BINVERS:rk3588s ?= "v1.19"
>   RKBIN_BINFILE:rk3588s ?= "rk3588_bl32_${RKBIN_BINVERS}.bin"
>   RKBIN_DEPLOY_FILENAME:rk3588s ?= "tee-rk3588.bin"
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> index ece5faa..39cc7ee 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> @@ -21,5 +21,8 @@ RKBIN_B
> INFILE:rk3566 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
>   RKBIN_BINVERS:rk3568 ?= "${RKBIN_BINVERS_RK356x}"
>   RKBIN_BINFILE:rk3568 ?= "rk3568_bl31_${RKBIN_BINVERS}.elf"
>   
> +RKBIN_BINVERS:rk3576 ?= "v1.15"
> +RKBIN_BINFILE:rk3576 ?= "rk3576_bl31_${RKBIN_BINVERS}.elf"
> +

We have much newer ddrbin, bl31 and bl32 in current master of rkbin, 
should we consider updating? I haven't looked at the various changelogs 
but maybe it's fixing important stuff.

>   RKBIN_BINVERS:rk3588s ?= "v1.48"
>   RKBIN_BINFILE:rk3588s ?= "rk3588_bl31_${RKBIN_BINVERS}.elf"
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin.inc b/recipes-bsp/rkbin/rockchip-rkbin.inc
> index 9ddd54f..a276aa6 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin.inc
> +++ b/recipes-bsp/rkbin/rockchip-rkbin.inc
> @@ -11,6 +11,7 @@ COMPATIBLE_MACHINE = "^$"
>   COMPATIBLE_MACHINE:rk3308 = "rk3308"
>   COMPATIBLE_MACHINE:rk3566 = "rk3566"
>   COMPATIBLE_MACHINE:rk3568 = "rk3568"
> +COMPATIBLE_MACHINE:rk3576 = "rk3576"
>   COMPATIBLE_MACHINE:rk3588s = "rk3588s"
>   
>   PACKAGE_ARCH = "${MACHINE_ARCH}"
> @@ -26,6 +27,7 @@ ALLOW_EMPTY:${PN} = "1"
>   RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
>   RKBIN_BINDIR:rk3566 ?= "bin/rk35/"
>   RKBIN_BINDIR:rk3568 ?= "bin/r
> k35/"
> +RKBIN_BINDIR:rk3576 ?= "bin/rk35/"
>   RKBIN_BINDIR:rk3588s ?= "bin/rk35/"
>   
>   do_deploy() {
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> index 4c7fc3c..4e7265b 100644
> --- a/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend
> @@ -7,6 +7,7 @@ COMPATIBLE_MACHINE:append:rk3328 = "|rk3328"
>   COMPATIBLE_MACHINE:append:px30 = "|px30"
>   COMPATIBLE_MACHINE:append:rk3566 = "|rk3566"
>   COMPATIBLE_MACHINE:append:rk3568 = "|rk3568"
> +COMPATIBLE_MACHINE:append:rk3576 = "|rk3576"
>   COMPATIBLE_MACHINE:append:rk3588s = "|rk3588s"
>   
>   # code bloats with clang and results in error below now
> @@ -35,6 +36,10 @@ fixup_baudrate:rk3568() {
>   	sed -i "s/#define FPGA_BAUDRATE\s\+.*/#define FPGA_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3568/rk3568_def.h
>   }
>   
> +fixup_baudrate:rk3576() {
> +	sed -i "s/#define RK_DBG_UART_BA
> UDRATE\s\+.*/#define RK_DBG_UART_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3576/rk3576_def.h
> +}
> +
>   fixup_baudrate:rk3588s() {
>   	sed -i "s/#define RK_DBG_UART_BAUDRATE\s\+.*/#define RK_DBG_UART_BAUDRATE ${RK_CONSOLE_BAUD}/" ${S}/plat/rockchip/rk3588/rk3588_def.h
>   }
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-boot_%.bbappend
> index 08e1730..ddb6fd2 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -4,6 +4,11 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
>   
>   SRC_URI:append:rk-u-boot-env = " file://rockchip-enable-environment-mmc.cfg"
>   
> +SRC_URI:rk3576 = " \
> +    git://source.denx.de/u-boot/contributors/kwiboo/u-boot.git;protocol=https;branch=rk3576 \
> +"
> +SRCREV:rk3576 = "04e6417226f50e4e3cb04272280922eb425c18ab"
> +

This is a no, sorry.

We do not accept non-upstream fork in meta-rockchip.

And even if we did, it should be its own recipe and not piggy-backing on 
the upstream U-Boot recipe which reports a different version than the 
one in Jonas (Kwiboo)'s current branch.

Jonas may rebase at his liking and we wouldn't be able to build this 
anymore. It happened in the past and likely would again.

It seems you have found the commit that fixes the issue for you, so 
maybe we should include this patch on top of upstream U-Boot here as a 
".patch" in SRC_URI. This would be acceptable to me.

I vaguely recall this was somehow related to boost DDR blob... Jonas 
hasn't sent the patch yet to the mailing list so I'm assuming he's still 
unhappy with it (or is lacking time like most of us :) ). Wondering if 
an update of the DDR blob from rkbin would make this work? Would this be 
something you could try? Change SRC_URI to ecb4fcbe954e ("README: 
Update" and update the version numbers for rk3576 to point at the right one.

Cheers,
Quentin

