Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003CDCDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 17:19:08 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.27])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2182.1782148739459374322
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 10:19:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Amu39t/o;
 spf=pass (domain: cherry.de, ip: 52.101.70.27, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1zT5jYmnmRclLBN6C37XAL0XNt88cD9UgnPnYkrsVb90fvCHwvh+qRmA7i0FXJrJlwNJFZKLlGfbP8fw5XkPM/2bHqv9yOtSxamJaFLgxCsfOMhqgdRN/atFgxpBTAVlWd1i0cWXhju6uYbDckBVuudoKfIIRyq27SCJ6tPiDj740ZkSOeG+ej5cgQoJV454Wh4sBWxam2pfLzCr1OY6hIL7K8qnqRBKmedjAB+LKhNt8zdsDdiZCtmXOwW8aTGo7zHsOmKoQqqET0tVTfZauqUXgWrICjC1MvfCp5TQ6ayqLGkEojkMWyfZki/nGlDVsIgjggnaNImwDURG/PT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPPIU1DfOX7+Vx7nrSJpOegrCH/59wZApYMM3VpXegY=;
 b=JNiAgdT2VvurZdD/jvlNYKT/C9PEuOR4EkpGYJSc8Y6HDkNYwWdAD58qDTGp8C0+aBXp2NHNPoltUFUNP4DtUI3bwkFs5UjCkQuBqAQJ44kmXstJNMpnjMtM5/InsiwlpXQED2n8+krQ/wBGUVJIZxpdNzcHIxRD7wttS1klwb7/T2/e/Yf0Y9ZRNoXe3mtH/u/Mrl20QDNm1Qma8Q4wHqbBI/SQnTrvb0JZ/74qQ55DBf/fOMkhuLSKDDMU7W/ZO+tOG+1bH1JPINct7rXnGE49eYXeoUSUm/qEBMIZymowfJ4PWClh4s+6G5FwDue0CFtih3erW+A25DmICJ/Vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPPIU1DfOX7+Vx7nrSJpOegrCH/59wZApYMM3VpXegY=;
 b=Amu39t/oUI3qTMpiR2gpV9VFbjQpqiaLtof+1gZI2W9vpxddqxWd6ORC59A5qD2znhLAVbP2ALUJxrBr2vQzrsh/s30JpioHKcyVAqYgVhDIHtJNgXJVMdaDYEbUukbynP59iAkSqGoideZFHdvFpppoJVdU0v2n9bTL3B3jbYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Mon, 22 Jun
 2026 17:18:52 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 17:18:52 +0000
Message-ID: <ea1a1238-4662-4be0-a177-8728d01eeeab@cherry.de>
Date: Mon, 22 Jun 2026 19:18:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [rockchip][PATCH 2/2] rock-4d: add initial
 support
To: yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
References: <20260621211915.72650-1-sputnik@on-the-web.ch>
 <20260621211915.72650-3-sputnik@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260621211915.72650-3-sputnik@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0295.eurprd07.prod.outlook.com
 (2603:10a6:800:130::23) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB9PR04MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d17321-f736-4a41-9874-08ded08254d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|3023799007|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	Ykxkt1Jh+9h3FaB+cupN9CSY8qqoYu8k+vc2BLpiTVvL62rGYEyi8WRFMkESfIRG+1LeWMJswToWU4Urgp5lEzWYMuBWMyvqX6rcwZmY5lnMwe1pWg3WyHdUbujU7zhcx8ff9oXIlnXZYIjSTJqyY3NzkkSg5c6YZ2/dSqPhPA5uMUMS+JzCK0zbLG7RnR4rqDSbzd5eMymqX0BElc7jSc98gLfYj6znAmg9c7mNBFxQDbnilcY1v+Z3fL4Ez8XPIdu/T30zeXpiN/6om0ACRzXAd/JiY1KzRnnVJe4GVMYiPn73MkIMSOt2wa/BRCw5bVLoh0jUS29leHkvh/el99zPQfCRY5A0KOKZdW0ZP7BeVLgWdKpJ1fbA289dXH+nhfozNgXFLO/fJcCooAIf3YXpR1XCx8v4Ur50r6fcJWWrCvUqnq2VGJO1g5QfgkxAlwVlIHN3/NcsTBNjr7iLeJkFouwKiKGSzlxNk6EmA6lteLHoHX32J1zH1zggLw2qF0fStAD9O1mL2DfNtkyxDy67Mk7aLC5JBtMx4LHs/NjDqMutAsvBhC+E9vhawW9iQjY6V7F4Hg/UAjXdx1LoqdfPPooze2yaZMtFD9eGYjarqde2/2B5B1/cGH1qWMzPWrJR3C4KN31pQNpjnb8hVl6MF/kSIndmFJvUY+/gmcg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czIvZkJxeXI4RDZwU1JqTk5md2hpUTdBMm9NVjA4WVNDajhjUWhpL3BKYWZH?=
 =?utf-8?B?KzNxK09HbHcySXZTb1huT0RjUUxVbWF3RHYxUWd5YloySzUzUUtYVlduNzlX?=
 =?utf-8?B?YUpEQTBEVjhIVmx5M3B4WCttc1hlUDIzMXluYjhtUFd0MklmaWtncnR5dmxH?=
 =?utf-8?B?RTFCZU5TMWczMHRoODR4Q1dCd0gxV2hpUnFOZVBXQ1N2SWNabjllWGRrTXor?=
 =?utf-8?B?MzErdVZjeERlbFRHN2JrUlRuZjkwS1oySDlIak9zOE9pdFR2bkJ4aDFuL3lj?=
 =?utf-8?B?eXUyQy96andkTFBUa0dtaTMzKzBYZE9aMTMzU0laWmdyR2t0SDRadHZKdW0r?=
 =?utf-8?B?cFFCbWh3cHcvU1pHa2ZJWnVuaGdaQ3dZdGNFUmNPeUkxcGJ0T3FHdEpmWVFO?=
 =?utf-8?B?ZXlxQnM3MTlDTWdXcFJCS0ZwMkpjTUU1Q1g0cnpSSXFmREl2SUJ6WnZFVmFV?=
 =?utf-8?B?cDRSVG92c21mNldtR1kyWlNhTVlURWtBbFg2eWFIeDN5eFgyZ0JYT3NheTg4?=
 =?utf-8?B?bkc2Ti9TSEJKc1BkV0w4SGE4WUkwZTNDRU5icTlqckRGcFU0eTJHU3ljSlRE?=
 =?utf-8?B?RlpHZ1BWMjJoTzE3NnJGK09kYUpWQVNkc2VTZXRLVllWOVpMZWt3VXpRWVp6?=
 =?utf-8?B?RStOY3pKWi9OUURwTkM4OXdVMXErV3FrZEZDSWFVdkIyNWVTSG1uT0FKOFRr?=
 =?utf-8?B?RGJBNVdPMnc2b1BmYm5OS0xlQVFDN2wrSWZkeko1eDU3NE1JejBOaHdKeGxV?=
 =?utf-8?B?RjM0N2NZQ0I1SEtUZzVnZk9NVnJJTTRRcWNTSDVIckVOU0tnUFFEdTUwZEh5?=
 =?utf-8?B?aU9aWmJzd0hmeUxwTGpNcTNYUm0yeEJ6b2RaWnJKbUlNMWdNajJWOHRPNXJr?=
 =?utf-8?B?LzY2TjFJL01ZRWN5Umt6Si9qM0JNZC9SbjVQSUR3cURkNkdWc3V3M2lqbTk3?=
 =?utf-8?B?ZHNRTklMaGk3Z1FNYjVPWkdKRUFCUGdpRVhQMHlJZHdsbklONVRpRjlTck0x?=
 =?utf-8?B?RVJDd0F2NTg0SEV5UVdZK0c0SThqV0tCSFgyVHpiQ0dwNFhOazVUSEtwZlVP?=
 =?utf-8?B?eUs1U3dNOWxlT3BsWmZia1dNdWlFTGkzQmZoNkZHdFlaN2w0ajA1Ry9MdVJa?=
 =?utf-8?B?SFAzaXRudmNLNnJRSFBHZE9FaCtCSzFQc2xnc09iNE01NHpZZ01LbzMzWGdN?=
 =?utf-8?B?Qm1hNlM5WXU5WnZqWEgxNHFiRFUzNndwYVFxeDZWL0o5aDErR0I0eDZvVE50?=
 =?utf-8?B?WCtBbFZ1ejB5emt1clhGVGZUaFg5ZWlSQlVHWU44QzRiU2NGc0NpM2pxT1lx?=
 =?utf-8?B?Wm9mektPTTdzVldwRjYzTnFxN1ljZHloVEtmYit5ZUV3K01XU1RvTnQyTmcy?=
 =?utf-8?B?TlczdklGSVA2amR6N1NNdW0rdDFFNkNQUFJEOTkxN0xXRkNaYW1uRFBvdTRz?=
 =?utf-8?B?UDNmRW8ybXhsRjlkY0VKcWZpbGNnVFRDV005d29iMG1UOVJYRkNMcDBWS3VC?=
 =?utf-8?B?YnNvTXhLVjVqZU84ZkJScENNditpbGtvMTBkbTBJWEg3WnhZRHdSaHpLYk44?=
 =?utf-8?B?R0xFcVNDSURJMzlTeU85bUpuazZsdjZ0b2MxazgvUTJQN2hLN1Z6dWNuUDRW?=
 =?utf-8?B?blJ0SUtRaE9sdCsyZXhsWkhTZW9RT3lhRTFQSmJRRTFZTTF2YXNPNjlmVWlr?=
 =?utf-8?B?VHBYNUQrUkwyR1BmM09zK3BzelFJZThCOG0rbGNUazVHYlpXSXVUd0pabERE?=
 =?utf-8?B?RVN2M0V1c0NTeU5HcTc1aGdPSm5aenpDTXlXcWRTeWZ5TEtoclhlMGN5NWxL?=
 =?utf-8?B?WmJrbFNEQitjenNkT1hOemtOZktXRStwQ2c4OU05dTkvM0lhYzhRU3RWVFRa?=
 =?utf-8?B?T3I0WEQyVXZnTkxUNWZCcGJ2bGZGWlZoa28rMGdjN3ZnOXFMbEsySmlNc1hU?=
 =?utf-8?B?dDMrODFjeDlvckpWMmRoVldxQllDZ3d1MU0wT2JFckZwaU5qZHRRczNNREZX?=
 =?utf-8?B?dFU3bGxkRzNzeC9OZUV2YWFTNVhkTlRISXNjWENCTHdwa2RwN1dlQVg4MndT?=
 =?utf-8?B?SEtMWEY3bVFEbzJKem9IR1lRcFhHTm42c0VBOEVXRjBIaVNzTi9ySnpGSGtv?=
 =?utf-8?B?bE5qVk04T3VNYkx4RS9vKzFVdDFJMDN6d01vM1BRQ21jeW9pekt2amE4ekFy?=
 =?utf-8?B?K2plOTJZQVE0SzRwa3FYU1lGV1JXVFVrYlJPRi9zY3J4TXdRNFFkZFJ1RVZW?=
 =?utf-8?B?aTUrN1dQNE5mWVhXUk8yNjUrQU12akpIREx3cGlOZVV1eUNFOEtkcUZXbU5r?=
 =?utf-8?B?aGFxZ3BET0FYSk45SG9wdmxuYldrWnZ1bFJSWWtIa2RNWVpOSEhPZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d17321-f736-4a41-9874-08ded08254d6
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:18:52.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAkEw9DFGplBgMTx6ao99POhnGjn1TMu8vrNp9vvjijgwEaObVsQljHOjv4aK9fyMcCLRL3d/UZIcKSqmfCi/vFbgkg5AQy6KweyOYjq9Cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9626
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 17:19:08 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4264

Hi Martin,

On 6/21/26 11:19 PM, Martin Herren via lists.yoctoproject.org wrote:
> From: Martin Herren <sputnik@on-the-web.ch>
> 
> The Radxa ROCK 4D is a compact single-board computer (SBC) featuring
> numerous top-tier functions, features, and expansion options.
> 
> Equipped with the Rockchip RK3576 SoC, the ROCK 4D boasts an octa-core
> CPU (4x Cortex-A72 + 4x Cortex-A53), Mali-G52 MC3 GPU, and a 6 TOPS NPU,
> making it ideal for AI and multimedia tasks.
> 
> 	http://radxa.com/products/rock4/4d
> 
> tech specs:
> - Rockchip RK3576 (4x Arm Cortex-A72 + 4x Cortex-A53)
> - Arm Mali-G52 MC3 GPU
> - DDR5 RAM (2/4/8/16 GB)
> - uSD, eMMC/UFS module connector
> - GbE
> - 1x USB-C (power delivery only)
> - USB 3.0: 1x Type-A HOST, 1x Type-A OTG/HOST
> - USB 2.0: 2x Type-A HOST
> - 1x HDMI 2.1
> - 1x MIPI CSI camera port
> - 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
> 
> The ROCK 4D is the only board of the Rock 4 series using the new RK3576
> SoC instead of the RK3399 used in the rest of the Rock 4x serie.
> 
> NOTES:
> Due to the RK3576 boot ROM limitations, the bootloader cannot be
> loaded
> from the SD card; it must be extracted from the wic image and
> flashed to the SPI flash. The kernel and rootfs then boot from the SD
> card. See the "rk3576 booting" note in the README for details.
> 

I'm confused, if it doesn't work, what is the purpose of using Jonas's 
U-Boot fork?

> Ethernet is only partially working, mostly in degraded 100 or even 10
> Mbps mode or sometimes not at all. Investigations are still ongoing and
> if found a fix will be submitted in a future patch.
> 
> Wifi is not yet working, requires an out-of-tree kernel driver. Work on
> this will be done on a separate future patch.
> 
> Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> ---
>   README                                  | 17 +++++++++++++++++
>   conf/machine/rock-4d.conf               | 11 +++++++++++
>   recipes-kernel/linux/linux-rockchip.inc |  1 +
>   3 files changed, 29 insertions(+)
>   create mode 100644 conf/machine/rock-4d.conf
> 
> diff --git a/README b/README
> index c2697d1..8192284 100644
> --- a/README
> +++ b/README
> @@ -39,6 +39,7 @@ Status of supported boards:
>   			roc-rk3328-cc
>   			roc
> k-3a
>   			rock-4c-plus
> +			rock-4d
>   			rock-5a
>   			rock-5b
>   			rock-pi-4a
> @@ -122,6 +123,22 @@ Notes:
>   
>   	in the configuration (e.g. conf/local.conf).
>   
> +  rk3576 booting:
> +	The RK3576 boot ROM cannot load the bootloader from the SD card.

The datasheet claims otherwise.

It could simply be that the board doesn't allow you to select booting 
from SD card first. On RK35xx family, the SARADC channel 0 is used by 
the BootROM to select which devices to try loading the bootloader from. 
I'm thinking either you already have something valid on SPI and/or 
eMMC/UFS and the board starts from there, or the board is configured in 
such a way that the ADC selects a configuration for which the BootROM 
will not attempt to load from SD card. I don't have a reference design 
for the RK3576 and Radxa's schematics for the Rock4D don't provide this 
table so your guess is as good as mine as to which values select which 
devices. There's some weird circuitry on Rock4D schematics though on 
that channel, c.f. page 11.

> +	For rk3576-based boards (e.g. the rock-4d) the bootloader must be
> +	extracted from the wic image and flashed to the SPI flash; the
> +	kernel and rootfs then boot from the SD card.
> +
> +	To extract the SPI bootloader region (first 16 MiB) from a wic
> +	image:
> +
> +		dd if=<image>.wic of=spi.bin bs=1M count=16
> +

Please just make sure idbloader.img and u-boot.itb are in the deploy 
directory (or even better, u-boot-rockchip-spi.bin which contains both 
with u-boot.itb at the right offset already) and tell the user to flash 
those binaries on SPI at a specific offset. I believe you're also 
copying the partition table, which doesn't make sense on the SPI flash 
(at least not that partition table since there's for sure not enough 
room for the full system on it).

> +	Then flash spi.bin to the SPI flash, e.g. with rkdeveloptool
> +	from a host PC with the board in Maskrom mode; see the board
> +	vendor's documentation for details:

Missing newline.

> +		https://docs.radxa.com/en/rock4/rock4d/low-level-dev/spi_flash
> +

The "code" changes are fine.

Cheers,
Quentin

