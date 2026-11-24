Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14784.1795513865412411117
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 24 Nov 2026 01:51:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=JTwOCPXV;
 spf=pass (domain: cherry.de, ip: 40.107.130.52, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/3GJxOkboUiWFngVYVAztH24oIBoKwnQhFyzqsDBZcH7yP0B/4b9ICVNJFrYfG40j0n5cedYBry3L/CVYs7Vb9roc0iagcjcHxKlOFrqqwPkYB7KZfOBDlZ/goSTnMa3SpMnumtSGblEY8ECYS5pjLxjqhOgNktIa8C6Myw0LcunsVE76Db/mmGlSG0tA0rUw9SvMxhMg+faXCDzNVXU1QJQ4M8nY+5q6yVHn4yMNVQQ0Qtfwiu8WFsr8flQukxJCoBzi8a4oVCHa4cqmdQ5g2SmlQgkAw0o5DD+PFyP0CK+vlBiCrxEYJWUBrqM5y8Y1Bsstxw99a4CB0ENqB9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8o+xILB7K2yBW47bnwjl6YtTs5CGALh7zQylKotyT1g=;
 b=tjjZq7dxoWaVNZtdyN3PKgL7fD5me8/H3Kd177ZGk84kxOK18nQSppLsYENLf1i0oakFy+QtrpLziNA8FZtp/6HXgdA/y7avJRo7Dnu9FY/Y6QXuXQDs0wAA8vDeGfdT97jnIroCvK4AC6r5zyDJJC3EQsUt+O9F+VdBN8p55/f2vJkpVjDuFvw2f7n6ZtfVQw9sBSdtEksg5m7kec3ptUTOCXqyT6bBpAwOxXwGATYLqQNSRefcEPRZHBAYHYufY9Qof28LvPFJVXooBzWXP/WUJHYyN1G9+RpxEl8Vvr0u1oUnHkWCMdPAg2NoTAv4Yca+ry4CPSKDRxeEv2J0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o+xILB7K2yBW47bnwjl6YtTs5CGALh7zQylKotyT1g=;
 b=JTwOCPXVHVa5wGuKNkM8deosXHWhuZ9IwYYFSVHtnBpsakqObOWpXX1OcYVMDzkgZY3R1pXCPoK0QGFIH/i/5dd6tpUVLNXtou82GYdDrx2F5oEibDQgjWAa+j5XWMg0f9z2CwX1XNfgWDMHeYVgHpXzY3/njnj9fJKPJzf/8l8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 09:51:00 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 09:50:59 +0000
Message-ID: <0e03c7b8-52ec-443d-839b-76a466d40810@cherry.de>
Date: Tue, 24 Nov 2026 10:50:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] nanopc-t4: add
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
References: <20261124052240.1121147-1-deepakdas.linux@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261124052240.1121147-1-deepakdas.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0034.eurprd05.prod.outlook.com
 (2603:10a6:803:1::47) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: a00c3015-a490-4379-80f2-08df4a10717c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|18002099003|22082099003|13003099007|11063799006|56012099006|261021121427099003|261028144727099003|261102123227099003|261022075727099003|261026140227099003|261026121527099003|261022115727099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: BUIl9SSXp4UurMEP5cF/6FUtKl3ZrIRX3EBgD+zpkLH15nIwfR442M+c7J4B8TSLKeYisJXYt83S7a9lzsoQkkssf/DA9kYoW0Jp8QRInS7LthM1LyMMs/CZesSc/iARjIX8NllxY+v8yjii4rZmpC5ltjmQEE6HsFmdBILCYD1AhRosDs4Ek7Y8zM3Qwmq/MgHZtmA9LJ0bGBlvhzN+YRd9q+r0QQV05aBRpzHoLLxgYp/9m9oB7VY2y3d8b6Lh7qjnFWBS0JmJd8OXQLCB+uhVRTco/679fRNhSRWSGE+/qf4ZkkWkajUKKz2e48UyIl9yJhgDdLDiuN6itRWtbH7yIumt8IGn2hDKfNR+ql8k0KegC+4g7ZBSfOax5AHNp4Y+V+FaaXSK5jX7+xj0SCMolFa0imUXwFy+nYlhI/M6Gi/EdVNAMavSKnb3rKGSb6MGVu4gAeqqRPqwT+1+z0SFH2gbLc0Uax6dijC/EV0bl+4UUrXHWq0yisa6xv6TgPAs0fDxMK/SfK7QIlHrooDC3czHK3p1T1LwC/rrxpzPj073vraNL0C68a8hVU5xHk+XkzsCe/PM3kxz8yscz3pwM+J87PIvVlAWIKFTcos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(13003099007)(11063799006)(56012099006)(261021121427099003)(261028144727099003)(261102123227099003)(261022075727099003)(261026140227099003)(261026121527099003)(261022115727099003)(261022105027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGpMQ3Fxb21McVFVbzB5eEt4RVpaZk5ibFRVOGdmQXMzN2dhWTZEQ2Z5VlRH?=
 =?utf-8?B?Wm0vcUhhc01jV1FWV2ZkeWdYWStqTUFKckJqUVkrSUVTdXdjd3VFaVZFcFhr?=
 =?utf-8?B?dkMxelZ0UnFpU3JyTGlGZWFsZWwxZExTRERIc0t3MmtpNEwwSUhNbWZqM1Jj?=
 =?utf-8?B?dk9Vd3g0NzJ3dFQ2VnFJSU1ubS9rUHNyU1lOVU5ndTJnRDNPVkRhQ0daMWRZ?=
 =?utf-8?B?U1VxdGNNWlhMaGxCUFlxaEdvdDJybUxITThWam1JejBZZkZMcVpINE4xdFNK?=
 =?utf-8?B?WGRyd05Zbm5RaWtTK0dRN3RSNUhvSWwvdmJxV3ZPWlFHUlVUMEdqT2dGS2pJ?=
 =?utf-8?B?L2ErMmh5ZHY5Q0N4K2NzQ2xaL2s3QnBUYWpvY0drb2M4RlpKMGhPdHJPSkJ5?=
 =?utf-8?B?Z3JmNVBtVEJnQUF1MVFWenRndWhJTXVOZ1RaRytKU0FmbHZqUU91QXBqREVY?=
 =?utf-8?B?c1NZNWMyaEk2Q0tTMSsrTzgrWkpPU1AyQzlvc0x2NXBITitrSWpHY2tVOVYv?=
 =?utf-8?B?N1ZCc2JEdHkrN2h1bmk3UkNMMVZBZUtENDVmZFJLckovUVZtK2FuWXV5NVhy?=
 =?utf-8?B?RUtDMGpIbTNKZkpjUHBQYndnazg5WFlFazQzU1hhS1RkT2ZTZnUrWS9Wa1Ro?=
 =?utf-8?B?K1JOQXQ2QUpRbktkWFcwMTJqZWFwY1krR3loM2c4UlNna2c3SmNVd0JrRXR4?=
 =?utf-8?B?S0xOVDJ3dGpjZ3E1cXUyMFQ3b0RZV3ZFSi9yWnE4M2RnZEtUQndDSVp3ME1o?=
 =?utf-8?B?Mlgxd1lnSjc5aXJhc0NCT1FmdTZKZFhsUWZuM1N1bGNZUVl3SE1tNEZNaEpG?=
 =?utf-8?B?UWZ0Mm5QbmJuL0N1eVBJSDFrNlZNdVRyUTd2NnE1Mm03V01QVGRDMVJrbW83?=
 =?utf-8?B?UlNPcERhWGdmSmptd0diTE1iZWtsQ0F4VGMwYmVXenozblZ3NEVBRWsrRUVa?=
 =?utf-8?B?aWNZcGF4ZXorWDRmUzlPeDc5WFFkaStUSzVVaU5uakE0dHYvVlBkaWpNZUkx?=
 =?utf-8?B?YUQ3MkV3TmtnSE9ZSWJiT0IzekQ0RWVKM2pDKzBEVDBqaFMvZHNrcE1KY0Er?=
 =?utf-8?B?b3ZoVnEvSGtBaFNrVFh2a2JIalR1TWlJR3VrV2w4T05HYVp4Y0drQUl0R1F6?=
 =?utf-8?B?WTc2TExuVU9qbEYwcm93cU4yT3ZlUHh4RDBiSHZrYnUydmJZMzM4Sk9kcEpr?=
 =?utf-8?B?TGJFempmdzdOMEJLZ0dGSGtZUWFZT2JYUGJ4elZqQW5mTk5sUWRIQU1EZzR3?=
 =?utf-8?B?UE4wZVordXk2Q2lNMEhON2ZZYkcyVElLT21rb2VHVGtXLys3OGNTUlIxZVRF?=
 =?utf-8?B?Skljdm5Ld1lEY29odTdmZ0pnMXR6OVlOclpkUTNSd2dQS1ZEaDdMZGRwYmtS?=
 =?utf-8?B?WGZyVDd0WEQvWEtpZi9meExQZW1wclpRcWVqTWQyTXgwSHdXRXRRa2M0MkI3?=
 =?utf-8?B?TzFacTBHVVU2VFdWaytCeWlmd2NhZW9MTERBYWttV1RHSy9QNjdGZytaYTFM?=
 =?utf-8?B?ZUlaQlJzcjFMMGhubm05WmFhTGZLZDd1Nk5xK0w5b2w5NVRZTDN4NVhFcmxC?=
 =?utf-8?B?a1pBOXJCcTUrYkdlem1NUEx1YlVHQURKdWRpUTE3SHg3UTBrYzZyaHNuN0pH?=
 =?utf-8?B?RXNpWEdrMEFNeXlRYnQvZjJnL01wRFd3RkpNYVk1Z2F1Ry96Mk91MlZWSktu?=
 =?utf-8?B?dmlHalkycTlZY1o1TVdQZVZ3TlIxcXpCc1Zjd3h4enBPZHBzZXBCblhIYTV1?=
 =?utf-8?B?T1pBanNad3N0NXJ2T3NHZzdiT2RmcDlRZWpBT1U2ZGpKUHE4M0tQaU93VFk0?=
 =?utf-8?B?NVhHbjZQVjkvclhFR09GRm5KT0cxVGlvNWpZeVNGY05aMXI4dXk4ODlqOFdu?=
 =?utf-8?B?T1ozNG9zZzlSdGVmYnQ1Y0NQSmhrMlNqdGMzOWtpakhLZ0VleTI5MDFMdE9M?=
 =?utf-8?B?V2krcjdNTENJNGFWa3dkWU5xOURSVy84Qk83U0lzUVpIYWJQU0NXUXE0ZUxr?=
 =?utf-8?B?ZllLTitYTktqWlpOMUoyRUNXU3hzenZSMFlrdXo3d09wL05EQ25DZW5zRFNT?=
 =?utf-8?B?b2gyTnFqL3BLdHRidjNZTU9qTk50WEQ1OThFaTdCTSthSFBaMVRzWVUvZm5Y?=
 =?utf-8?B?SUY2QWY3Z2tnM2hRcU9tUzJWUEZLQ0JRbEhLTGM0akdlWWlJenlXVDQvNDV5?=
 =?utf-8?B?OWFyOUxjSFg5VE1OWFFPVmlySEJmdTRpSXI4SFFrQ0o0MVFJUEs0Ymd4Ynpu?=
 =?utf-8?B?bXlFSlN1S0JYaGZBbnRFblRFb2xzS0xNYVpLeFppbFBhMTZHSXdsVXdsQi9C?=
 =?utf-8?B?S0UrSzZBU3Z1Ri9aalRub0N0VTN2Rmo2ZXd0c2I3R3VCd240R0dQeXkvNWN3?=
 =?utf-8?Q?uKIjamZH4TQG/ZgffpT68JH+7N2KTfLKo6z6vr+/EeqT8?=
X-MS-Exchange-AntiSpam-MessageData-1: 7Zs0ve69ysxxsHnTpPM7rI+EWu9qNXQOGfk=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c3015-a490-4379-80f2-08df4a10717c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 09:50:59.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8b35Q9jiuIIzuOmk20Ff6YFxh2T3pAeNGFGQdHmiMpObkuDIsnkCuwZPQ4SIF+gVyGRQgrpovKM2Vdzpt0Ee7Wop/VVHUotDRGwJDr6ngHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9258
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 24 Nov 2026 09:51:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5501

Hi Deepak,

On 11/24/26 6:22 AM, Deepak Das via yocto-patches wrote:
> [You don't often get email from deepakdas.linux=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The FriendlyElec NanoPC-T4 is an RK3399 SBC with 4GB LPDDR3 RAM and
> 16GB onboard eMMC.
> 
> Documentation page:
> https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4
> 
> Specs:
> - Rockchip RK3399
> - Dual-Core Arm Cortex-A72 + Quad-Core Arm Cortex-A53
> - Arm Mali T860MP4 GPU
> - 4GB LPDDR3 RAM
> - 16GB eMMC
> - 1x Micro SD Card Slot
> - 1x M.2 M-Key (4-lane PCIe 2.1)
> - 1x Gigabit Ethernet
> - 802.11ac WiFi and Bluetooth
> - 1x USB3 Type-C, 2x USB3 HOST, 1x USB2 HOST
> - 1x HDMI 2.0, 1x eDP, 1x MIPI DSI, 2x MIPI CSI
> - 40-pin GPIO header
> - Debug UART at 1500000 baud
> - 12V DC input
> 
> Upstream U-Boot (nanopc-t4-rk3399_defconfig) and the upstream kernel
> device tree (rk3399-nanopc-t4.dts) are used.
> 
> Tested on scarthgap by building core-image-base and booting the wic
> image from the SD card to a login prompt. On master, u-boot and
> linux-yocto build successfully for this machine.
> 
> AI-Generated: Claude Code, Opus 5.5
> Signed-off-by: Deepak Das <deepakdas.linux@gmail.com>
> ---
>   README                                  |  1 +
>   conf/machine/nanopc-t4.conf             | 11 +++++++++++
>   recipes-kernel/linux/linux-rockchip.inc |  1 +
>   3 files changed, 13 insertions(+)
>   create mode 100644 conf/machine/nanopc-t4.conf
> 
> diff --git a/README b/README
> index c2697d1..3d8c568 100644
> --- a/README
> +++ b/README
> @@ -25,6 +25,7 @@ Status of supported boards:
>                          vyasa-rk3288
> 
>                  64-bit:
> +                       nanopc-t4
>                          nanopc-t6
>                          nanopi-m4
>                          nanopi-m4-2gb
> diff --git a/conf/machine/nanopc-t4.conf b/conf/machine/nanopc-t4.conf
> new file mode 100644
> index 0000000..20c47d3
> --- /dev/null
> +++ b/conf/machine/nanopc-t4.conf
> @@ -0,0 +1,11 @@
> +#@TYPE: Machine
> +#@NAME: NanoPC-T4
> +#@DESCRIPTION: NanoPC-T4 RK3399 board from FriendlyElec, 4GB LPDDR3
> +#https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T4
> +
> +require conf/machine/include/rk3399.inc
> +
> +MACHINE_FEATURES += "usbhost serial"
> +
> +KERNEL_DEVICETREE = "rockchip/rk3399-nanopc-t4.dtb"
> +UBOOT_MACHINE = "nanopc-t4-rk3399_defconfig"

question: any reason for not including

MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"

I'm assuming this would help in case the default Linux kernel config has 
modules that would be of interest for the board?

Otherwise, looks good to me.

Cheers,
Quentin
