Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D8C5AC80
	for <webhook@archiver.kernel.org>; Thu,  6 Aug 2026 12:42:25 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18853.1786020133943842754
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Aug 2026 05:42:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=WPSQjiaV;
 spf=pass (domain: cherry.de, ip: 52.101.66.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnVCW9yUezrSqYQ8ueISEAj1D4OSUPOsPF3eBXFgh0pH018qdJl/WwaMIk35BMLY4UefNWPkJDSVHlRu18DkOaVa78Uxg82i7qcd5SYMweOAmYicAjbTf4870u/WeD2cjYb/k5Jcf83FHrLU1Hhn2KtHkmpFzgaVQ3ZCrjn7Tqh0PqnJt9QzN+cvCdyNwz+PcxBisTcmjtcxgB0R2iwROITuRaM6rVqnJCYtgrig4Zsu3cOSV/iE1IXD4Evj95rsUTTBX5Yt74ATo5YhO1tjIXsNHLxtlC4YdvcKNRIXS/3ueQhhtyGPPYAuwRrblKpm0cHrAsI4q6PLLDwU7DFrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VNgIQqAGMWt4x0efnC7be+ove+7R/pQaFExIZ2OgJM=;
 b=LPhjVt/9RYsk4FPa1mCOrPa2XWOWAYanT+sJVd7htpjs15NlJrburISJBau+J5ZFKXLRdt5patSBJ+y+pVcKZkwUqcPgt3BOixPUg6k+R8l7Rj+JDZ80OiCFg1wTh8cPHw3Zs3gwhk5/3QnqUE1PR6TbwEwk9acXLrH8TcasCwrla+aC4ZBx8Zq5SFnSTToQweIFMe8Wop8ZHFHLJG5xb8vZTSXx0RfH+B6aslMzB+vF+RmbG7kp7SI1riQEjL9l0o50dX8Hxcr69xq/md9I8rNCocsCHn7Yfm7Q70ZnxJVg5mhLJVcnm21+j8YLvYemNIjX8vRMYIqxUSCBFdp5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VNgIQqAGMWt4x0efnC7be+ove+7R/pQaFExIZ2OgJM=;
 b=WPSQjiaVo4o3jal6LZlGRMvVhr/+mUQv3KvyyQQeFMh/cxSzn51gyWnOoUqGp84mb90Z6XixFhikdU0HxmDO85PnDIbhdlaa9XxWNQKfI6kc3sOsEFTlNJrBtPmzOw0jN5jMswSdDZciBXMMXsyX9Ig89VQoShsrCGL/94fHD9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18)
 by FRRPR04MB12571.eurprd04.prod.outlook.com (2603:10a6:d10:1cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 12:42:13 +0000
Received: from AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5]) by AS8PR04MB7733.eurprd04.prod.outlook.com
 ([fe80::8f86:fafb:dce7:bcd5%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 12:42:13 +0000
Message-ID: <478c7c78-ef45-4f56-b655-0828719eb136@cherry.de>
Date: Thu, 6 Aug 2026 10:56:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] rock-5b-plus: add
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com, Vinay Patil <vinay@v-patil.com>
References: <20260801214005.3948-1-vinay@v-patil.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260801214005.3948-1-vinay@v-patil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::18) To AS8PR04MB7733.eurprd04.prod.outlook.com
 (2603:10a6:20b:288::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7733:EE_|FRRPR04MB12571:EE_
X-MS-Office365-Filtering-Correlation-Id: c36c2150-4fc8-4a25-14d3-08def3b823ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|376014|366016|13003099007|56012099006|11063799006|5023799004|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	yjVEc+556QWtHaXqCVLQsnZM60FbbB8zjmgXLNMsS0SDhMgccGZDUobsMW4Hd0cefVnEuOgPgfjDaG+tXw74EKWpcVPl/8yy2rt/RWV5Nn46x+UFTnNya8BW2TBzhVpbA30Cfh9F+wx2alpSYdT5Fp+YbOA7toGZAP0v5c4fYYu9lHrUsfkmNPpX/gpIk/wNgOcldHyEZ/rW/hWVlFhZUhdkyZKyfSy50jSbv0XyfVbJ7aDUrHS8/4oagaOdrsBiBkDuh9K5lzv8T27B6ZbuiKUWN8sI3n4Fu5IemiQSev0Rmz45XvTsCuwSJr3yY6ChosRm+SlFEdx4vq7t2rHsc1HL63QIZNAL/jque9OpR0aDq4VI+jp1t/AiBJcxkkO8UtYDRr1qJdoPy3y9sDb3Y7XfAZB0oWiF5AHT37FK8KeOuBrZNEZddX4eng8uwDvvxgD6PH2VKJObx8EHJIS9A8xq/nDQforMa49ssm+bJVIatHRT5h8Q/ILfWVTloaU/mDCO2hpxOpjcEkCcUrrpHwiqEegMHnyic09dOGedX2ug6BMSebqc59SsC6syl+wuIMAdqxG+lA1sPSmIdQygJsdHLpDHNCf42NwhRvakHL8/h8w61noNcrxc5QRGjIvgtFx7zHtTIBHJwcsbGLrdcqs7iB5UvTCyrl/y1zDR1qc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7733.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(376014)(366016)(13003099007)(56012099006)(11063799006)(5023799004)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHI5WVNhazZDc1dnOHFLOTNRYTJNNVRnOUxsYUNtODhrYmJjdW5vSFg4bjh1?=
 =?utf-8?B?MkNDalJ5d2tBL0V3VDE5c0lvbi85VHVmbFQ4dTVGSld0a0NDc1AyREppQ2ZG?=
 =?utf-8?B?UmxkUFpXTVBJUSsrZUYxMldJU3IzSEVyanArd1pCOUEvQmdYVWNjUERxQUlY?=
 =?utf-8?B?THlDUUJsbmhKcVRnRmNDbFVWRlNpdGlNU2g4eW5iR1VQRzBJS2htblFIQ25S?=
 =?utf-8?B?dFg5bTFvaDFiQUNIRTdLK0JQUndzeEMrMVRUd0l5ZzJ0elJyQXVJS09PYmQ3?=
 =?utf-8?B?NUhyalF0WUdOdUhLbm56M0w5Z2dJS1FFYzJLOEpIZ3NEY1hhZWQzOVVoOHNU?=
 =?utf-8?B?QXlZZ2g0OVNYdWxQQmJDamtSMEFXdzRpZVNKWlJ0OTVXdTJoMlduVHhOOHBS?=
 =?utf-8?B?Z2tITjJXSTVlcSthT1kvdmdsd21CTkZXclNncGFJNitEY2hia2FoQjNNVkVV?=
 =?utf-8?B?LzZpdXFjd2V1MDZFelJ6ekcrSW5Ja0lFZ3JFd2dORlpGY3pTbDVGbHBNTDlh?=
 =?utf-8?B?ZUk5RFB4ZDZVYjQvL0FCYm5JMUszTWhGNE8wVDBCSjhITVJMaUhFNnRGcXdT?=
 =?utf-8?B?OU9TZGQyTXRIS2M4SGtwdnRxMVB6MThkeW01RnZXRG4reTM4dTJ3dHFxbVlp?=
 =?utf-8?B?SG5kNHN6NlJsajQycG9CR1gyQzdzUkE2YTlteFVOQkVMdHJCdFJ5Z0srQ1RJ?=
 =?utf-8?B?c1A1TVQ1OGdod3dTRmdySHUwQmtkZVJ2L2lrM3lHM1NwdmxkODNSUUUzWmxO?=
 =?utf-8?B?Mmh4K1VDdWpBL3djZmloOWFCcnFkdnNHYTcyZWxEc3R5NGx3KzVmUTg2M1pO?=
 =?utf-8?B?enVXVkRKZnZKVTliVnhGRDFMdGdpT08rNGx2em42TWxZNWJXeVJqbGVncnc0?=
 =?utf-8?B?blhDSEVySWsvUS93dW9WaVByOVhyeEkrUGk2d25kYjRQUHU1QWR0ckw1Tjh1?=
 =?utf-8?B?M2Z0a2MwZkVDeTZraWF0V2ZQbSttZ2ZBelVRc3BEQ2V1eFdyOVNVRE9ONGMv?=
 =?utf-8?B?T0NhOWNxT3NnazZqUWxTK3hkbmxvOTJSWlhZZVNGWU50alVMU09kZStOZ2cy?=
 =?utf-8?B?VXdpVmZRdW1qbEx4QUszL2pCcjN2QzN0ZnNDQjh0VWN5SThmQzBiT0FSQkow?=
 =?utf-8?B?ak1BL1ZGZGFLT2lKVDVlYTJHWFRpOVZEczZXaEVyUVErdnhGK1Y0NG1lOW8z?=
 =?utf-8?B?WUhIYUlGNUVDdmtWTDQvcWxsLzlRZHI0cXRuQ2ZkQ0ptRHFWenRFRitySTFt?=
 =?utf-8?B?OElWWHI4NmhZUndRVDZHckRib2J0V3lRenZhSHZhWWErMkNzU0Vld0xGU3Y0?=
 =?utf-8?B?RW90Q2h1ZUtqRTZDdXptRGcyTVFQUldDeTZWK2JwaU1aS05jQTJqRlR2NTRM?=
 =?utf-8?B?YTFYeE5qUHgvclFmQmI0TGZtNHhRK3JNNnk4K2FjaEJ4S3Y5MmxFSXlxdS9h?=
 =?utf-8?B?TC9iODg3dXBOMzViZThWTER4MjgwUENFWis5d3BYVDFuaVltVWRqeUtIckpz?=
 =?utf-8?B?T0pkUm95YTBtN2VPb1hjTS9MbUg2VDBtVXc0Wi9ZZnNxcmI3TnBuMXVLSTh5?=
 =?utf-8?B?RFhDd1d5VElGNGFDTUNCaXpUZzM0TWQ0SVAvMm83T054ODRyVWpoMWRnaEtX?=
 =?utf-8?B?MGFQUVo4Y3RDRE1WUWFEMWhiem4rQlV0SDF1eVFmeUh0WCs5SEgvRVRkeFZ3?=
 =?utf-8?B?eXlkWEZuSis2c0lub21HSFpCcmxocTdYRHV0bFNlcEFMMGhoa1dFMTAvNHNF?=
 =?utf-8?B?YzdCemF4QTdvak1JUGRTZFZmNXI0ZTdxQkpVL3VWaUlhRExucER0SVN3WUNS?=
 =?utf-8?B?MHU0MmQ1TndNRzdpSFFEYk1qbHBzRS9mVnpoOGVjRXM5RVJrRElXVGdhbmk4?=
 =?utf-8?B?VTNOc2VHZXlzcnFmVGx6Z0lrejBXQUZ4TC9lSEZ0UnVQaGE4MU1Ib3VWbzRH?=
 =?utf-8?B?VDBNYzZSYjQ5bnkxQjRNNWN2djREOEVMa3FrbEtTUnpGNzhQcDlIcm9WVzNi?=
 =?utf-8?B?eFo5OStENWN2YmpOeTlodHlYdVVuQ3pUdXRsSXVjT2RKcmFYbWlSemtsdndZ?=
 =?utf-8?B?a1VBK1p4aThDUGRiTllGbkJkZTR3Q2gvdHAxQzloUER1YjZXZkFRSVdaN1JI?=
 =?utf-8?B?RXI2OUFGM25udHR6QUEzcGcySERXbmJKejBQTTBkMXJkYnJqdWZESTAxUndP?=
 =?utf-8?B?WXkrVVRDNGhMbGIwaTNlY2N0anB0eFdNeDBWTldzVTNjVHh1S3RIZ3k3dTdO?=
 =?utf-8?B?NHNTdXUzc0VabHRUNDFyMkp5MG5rbU1RbURKb3ZRajVhaHFoSmYvZzllYlEz?=
 =?utf-8?B?UGtrc1J5QVRSeW9SR0dPUnhUK20rK0IvM1VUM3JPS1E3SU5SV1FPeUR3RG9R?=
 =?utf-8?Q?1XOuZVNXcAQpu2o3JJqCyOKttOj+QnN5MmQ7VddDB/WaI?=
X-MS-Exchange-AntiSpam-MessageData-1: eK0qpS4aU/r4ebLzx/Uv6My6DFXh0MFeQm0=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c36c2150-4fc8-4a25-14d3-08def3b823ca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7733.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:42:13.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/mOD/8Y1dV+TMcEgUgKtW/1YpDtGHHer3z2AmYkQyu8+YFiqK91kehGSk8K5aQ69G4LLFLceIAjt9sHc4gsIksTkToRZFzm+Ul/z9k8wSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR04MB12571
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Aug 2026 12:42:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4638

Hi Vinay,

Thanks for the patch!

On 8/1/26 11:40 PM, Vinay Patil via lists.yoctoproject.org wrote:
> [You don't often get email from vinay=v-patil.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The Radxa ROCK 5B+ is an RK3588-based single-board computer and a
> successor to the ROCK 5B. It features LPDDR5 memory, onboard Wi-Fi 6,
> Bluetooth 5.2, dual M.2 M-Key connectors and 2.5 Gigabit Ethernet.
> 
> Product Page:
> https://radxa.com/products/rock5/5b-plus/
> 
> Documentation page:
> https://docs.radxa.com/en/rock5/rock5b
> 
> Specs:
> 
> - Rockchip RK3588
> - Quad-Core Arm Cortex-A76 @ 2.4GHz
> - Quad-Core Arm Cortex-A55 @ 1.8GHz
> - Arm Mali-G610 MP4 GPU
> - OpenGL ES 1.1/2.0/3.2
> - OpenCL 1.1/1.2/2.2
> - Vulkan 1.2
> - 6 TOPS neural processing unit
> - LPDDR5 RAM (4/8/16/32 GB)
> - Onboard eMMC socket
> - 2x M.2 M-Key connectors supporting NVMe SSDs
> - 1x M.2 E-Key connector
> - 1x MicroSD card slot
> - 2x HDMI outputs
> - 1x HDMI input
> - 1x DisplayPort over USB Type-C
> - 2x MIPI DSI
> - 2x MIPI CSI
> - Wi-Fi 6 and Bluetooth 5.2 with BLE
> - 1x 2.5 Gigabit Ethernet
> - 2x USB 3.0 HOST ports
> - 2x USB 2.0 HOST ports
> - 1x 4-ring 3.5mm audio jack
> - 40-pin GPIO header with UART, SPI, I2C, I2S, PWM and GPIO
> - USB Type-C power input
> 
> Signed-off-by: Vinay Patil <vinay@v-patil.com>
> ---
>   README                                  |  1 +
>   conf/machine/rock-5b-plus.conf          | 11 +++++++++++
>   recipes-kernel/linux/linux-rockchip.inc |  1 +
>   3 files changed, 13 insertions(+)
>   create mode 100644 conf/machine/rock-5b-plus.conf
> 
> diff --git a/README b/README
> index c2697d1..6825009 100644
> --- a/README
> +++ b/README
> @@ -41,6 +41,7 @@ Status of supported boards:
>                          rock-4c-plus
>                          rock-5a
>                          rock-5b
> +                       rock-5b-plus
>                          rock-pi-4a
>                          rock-pi-4b
>                          rock-pi-4b-plus
> diff --git a/conf/machine/rock-5b-plus.conf b/conf/machine/rock-5b-plus.conf
> new file mode 100644
> index 0000000..bfa3714
> --- /dev/null
> +++ b/conf/machine/rock-5b-plus.conf
> @@ -0,0 +1,11 @@
> +#@TYPE: Machine
> +#@NAME: Radxa Rock 5B plus
> +#@DESCRIPTION: ROCK5 is the 5th generation of SBC designed by Radxa.
> +#https://docs.radxa.com/en/rock5/rock5b
> +
> +require conf/machine/include/rk3588.inc
> +
> +KERNEL_DEVICETREE = "rockchip/rk3588-rock-5b-plus.dtb"
> +MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"
> +
> +UBOOT_MACHINE = "rock5b-rk3588_defconfig"
> diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
> index 6c62e84..6c012d4 100644
> --- a/recipes-kernel/linux/linux-rockchip.inc
> +++ b/recipes-kernel/linux/linux-rockchip.inc
> @@ -25,6 +25,7 @@ COMPATIBLE_MACHINE:rock-3a = "rock-3a"
>   COMPATIBLE_MACHINE:rock-4c-plus = "rock-4c-plus"
>   COMPATIBLE_MACHINE:rock-5a = "rock-5a"
>   COMPATIBLE_MACHINE:rock-5b = "rock-5b"
> +COMPATIBLE_MACHINE:rock-5b-plus = "rock-5b-plus"
>   COMPATIBLE_MACHINE:rock-pi-4 = "rock-pi-4"
>   COMPATIBLE_MACHINE:rock-pi-e = "rock-pi-e"
>   COMPATIBLE_MACHINE:rock-pi-s = "rock-pi-s"

This is unnecessary as U-Boot can detect whether it's running on a Rock 
5B, Rock 5B+ or even Rock 5T and select the appropriate device tree to 
use with the Linux kernel. What's important then is that this device 
tree is available to U-Boot, which it isn't at the moment.

I would recommend to instead advertise support for the Rock 5B+ (and 
Rock 5T) in the README via the rock-5b machine and in the 
conf/machine/rock-5b.conf at the top of the file, and then simply add 
the Rock 5B+ and Rock 5T device trees to KERNEL_DEVICETREE in that 
machine conf file, see board_models in 
board/radxa/rock5b-rk3588/rock5b-rk3588.c in U-Boot for reference.

This will avoid increasing the number of machines to build for to 
validate meta-rockchip still works as expected (I believe Trevor does 
that every now and then).

Cheers,
Quentin

