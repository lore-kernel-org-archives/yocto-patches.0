Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D1C87FDB
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 12:44:06 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.38])
 by mx.groups.io with SMTP id smtpd.web10.47184.1754916245588051242
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 11 Aug 2025 05:44:05 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=KL5G3HhF;
 spf=pass (domain: cherry.de, ip: 52.101.69.38, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wq2SjQUQ++6Jq8J15V4K4jO2ifew4AqpoeLwS+30KwDtaiFeuosL6abFYqmeFQKopNumcdkmTaixF5Wop4R5z93lNdoCBiUWSBEAl1pUh1Pe7qjvLSFJXCDvlTcKWcwbaVLFTIDS0YIVBF3YcNky599YSlA58Ln03I4wIxfrDxlxAVD3Q5y6CfwxMdjkX4yKiwO/UBP59sLJiGTTYJF4L4a1VSJILM2/PsXBjRAEFFhV0XjxyNx8hZG8FbFrsjOgWNz4tiXuWhwqeTjAXaMJAVYw/psWl8S/CBibK2+Q2Qd2CUH6v+QvMnB0QQipJ2D7Mr7O/4JsRSYBj7gsrWSarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kja5kx6LBIu170Sl5f085fQCHbmzDGC+IQIo0V4gHvo=;
 b=ajUeNdick/RmyF2DsB2U3ecDuy7P1dmFn3Jh9izZZ9ATnzYR4vZfvVYW3Q+raT+BhbGwexaaaeFXmZKDPm2LSqBEHPIfakEd+AwHpTjSlEHMgKeskU/hfVBX/VfnuMgoss4jtvo6JW1lQ3gKyhY0y7PXcOE+eyvRQH/6uW+4L73oxwkRDgD4snbOU/oBK+Gsrn8Qhd4kt1yiPHRtmv0it2e+FUYbuR/Oftx/w4ahy8JYysHgnI9ek9oSySahi5FbgOS2RYoCb9OjeBPhsI6rJ5SVz9DrcKZ1Y233GfZrPb7GCJsYd+vA+TfgERVeoeNEi9xu9tKttF9bYN/nI9YNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kja5kx6LBIu170Sl5f085fQCHbmzDGC+IQIo0V4gHvo=;
 b=KL5G3HhFhGGTyvfz8rHDwsoTNuj17cKLRbM/+yND91cMrxSJh5NJQI+ejHuPvbNGA9MCKfs/FGMt0HoQct6bycb9+SLEq2lXbIy2cUauiSkvePBnIaN3RE/mwXqFZRu7BSeLBhlvBciCj/6966apCuBu9D8/0N3QpvFONCzi2jA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7467.eurprd04.prod.outlook.com (2603:10a6:102:80::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 12:44:02 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 12:44:02 +0000
Message-ID: <c506e59f-b72a-43d5-a435-9fa79193fbfc@cherry.de>
Date: Mon, 11 Aug 2025 14:44:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] nanopc-t6: add
To: yocto-patches@lists.yoctoproject.org
CC: twoerner@gmail.com
References: <20250803172432.1341178-1-scott.murray@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250803172432.1341178-1-scott.murray@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: abe886d3-6b64-4356-1c17-08ddd8d4bfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Do+q60hVwTCkZV73jPlbgF7uzyIpoFxSOhi/1cIt2eNqDSBsBTjDm+gHrp19?=
 =?us-ascii?Q?7VTNp7Ta28jUuuYDwiN4U/5HaWvQ2+id1+2FwYMcqkydb7oUrvYIQV0jh8f/?=
 =?us-ascii?Q?k1hlBq8OYhuhUS2HEMegnMcd7u3yl5iGk1YvCbuPoQGgGjiAe9cBzfj2C+VC?=
 =?us-ascii?Q?F9tv+0sMeGnGckjFxzuNEwfQrCxtCkedDAWvRUxluJHvass4mXeD+xixgl94?=
 =?us-ascii?Q?jx2DEs1wl22c+IY/r1xZY17h0JfXbxVzdeI89+vL3fxPFRKeGmzR2gaYcJiD?=
 =?us-ascii?Q?STXu0Y6a7QvTxbpnQ6rfcQG8RpxC++8tKKdh1qxlTjuMTlGlDmj9c5JT7/QJ?=
 =?us-ascii?Q?MfGChs3njNVTm6W3aT3LOrUFohpdAOicEmu13fXYAb630ORWtgxkk5EQauRd?=
 =?us-ascii?Q?oi4i1jOnftvlLKIbqL/rnUr5Ql6fQfM3BLOvuXUuHjj6ymN5697t/MYTiMmZ?=
 =?us-ascii?Q?660H+j6fb0YrLRtIeyKIG7AK8LeCCEDHkaPUzrkvANd/NgNSiJY3LLx7M7Dw?=
 =?us-ascii?Q?3mII54M2Y+5IBAZSqkdDK20bzueLkwuD0OWKyceh7yX3KP7IBPNQQI4loxL0?=
 =?us-ascii?Q?x5KdBKKuvCT8cE5S6lWn8bOmC2ohiCgBw+JSaUqsE0wj6Yl+57znHpFS3rX7?=
 =?us-ascii?Q?yyx8q8Sjdb/ERxjxN0EDZK+E9Vo9VO4M0ft7LdBLx6l1c4XAzt/tKhJn+Vt9?=
 =?us-ascii?Q?Jz9uDgFYr5DsCLT6xdb+jRQu7ldjmj6h9IMf2np7V1xoU/eV24iBqaHb/sRz?=
 =?us-ascii?Q?lY7Vh78zGbJCoPlica6LlpAdmRkj4Jb1mxwfZpwMywJtw0/EGsCfCkeNp4kG?=
 =?us-ascii?Q?/1F0bx8Zew1FEI8aWbw3D8y4zI+MbmVxjAo4WbsXrMFKGIfslwA+oQW55z/E?=
 =?us-ascii?Q?WK+SdCq3+Y76wEi5GADYnmMX1Yxm8dA2QeZ4GyZ06jRl3X9fBz2LGcXRskRg?=
 =?us-ascii?Q?2r6oGhLtSWGiAeNkZaEl1RClotQaUPsNDDEvxVWKyuxf+bfgyMOsVuO7Kz/x?=
 =?us-ascii?Q?2OfqrmCnC7cVWsRRtAnvQI6OY7ZVfiqibLtOEx7YnpMHDviyqj+3WJTNKxW6?=
 =?us-ascii?Q?eKb07kdKHTTcOR5Cv5oGPOfB+6LOuurKG2SN0wx+8XVAcKPufPFVF+o7cLQm?=
 =?us-ascii?Q?3by3bK1TbHq0esBojsWsWUSFRyASP7RzdbfC1DTa5DyjKvb90wAn9Ov7ieO0?=
 =?us-ascii?Q?dHRP8V8OD16Evf3u34VGeLYLt6enVissYomjnnkVSlBG0vxemdVRobZFkhEY?=
 =?us-ascii?Q?NHo7Y4YJQyoNsbicS48h6W9P3rSL8semEGJcJLMbfoaWcxczQfChg7CjJqxM?=
 =?us-ascii?Q?WnOuooVkNRSzqAi4Zz65EV+I3PGgc2BKThhaCCYyhCG+Pd4iiRdIcf2i2LYm?=
 =?us-ascii?Q?wi2eFd0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?72sf74Mian8ipDP6qMVUGCWyw3fVOOmLwNU4I0FL9fHKTtupbQADqRRTgRSi?=
 =?us-ascii?Q?zxh3DXDC9WBo/8tCk4xzSwugKItxFaq5LCBy/Ywiz76XT3BPd4dJ5usMO1VD?=
 =?us-ascii?Q?kK41obQ0qdGxtzhXnrXiZD36sxI0DtAamrDjJoxCd6KIioFC6i8CfiV878nx?=
 =?us-ascii?Q?3az2lJQvzrLzyxCCnmXF/xiMw4bHTDgiOVkBFVH/uru5Fz6LzZSk7sg8HMBX?=
 =?us-ascii?Q?l/HR7qcNxfKYUU+//vTzwy4DTR/76ucDcrmJoCD2gctlFnhF4Clr1yu7sUvC?=
 =?us-ascii?Q?xWC5Bdnp+ioj2VM3KNe2Wj+nk2lk9TBqNPr3BkaYy+n56fJ5NoK57NhlBC4U?=
 =?us-ascii?Q?jQdWRdjK/rx0v9kLzsSLhgJgFvlo4Jp3QxgFnOnlofQyu7xswSVRFBqm1VTA?=
 =?us-ascii?Q?CPykgdsmEbkevd3G+Xksq5gTFJruyyoV4YcXK5KOVTLnWwhXsj8JsAB4tcK6?=
 =?us-ascii?Q?O2CFFo7i0cslTUiqurdsxCk8+3uC4Fq34wE1QFu/l8LvLwh0HjD8Dc7Ykf03?=
 =?us-ascii?Q?e1EFCTvxwAFyA/kvHZmAMuyff/H+kkQN5q2NAC+IKnKApw1BClkoSFiyaCeI?=
 =?us-ascii?Q?UCu9l4y7neLUVChvCnaozxbh48MOWVrdOdz3u7MT+qUaBSInG81SItB5VLAn?=
 =?us-ascii?Q?NMIC+sa0S2a6MhbUlPdcyccOlfIIvTZy5RiujePU01S5ufVQdLxIEG//OkCl?=
 =?us-ascii?Q?UEe7QpM3FDMIPVBT2HlP5EyNxJ8wJKBk4LkE7Isi0Xq5LlsanvNjeOyfjroF?=
 =?us-ascii?Q?YIFjXtDXoDM0dNg+Z+B1bLI4s92+B55at7jmoUhlo6vftGcioZSvdNVkCyCS?=
 =?us-ascii?Q?DfWbP8h3L+KXXdWYBGWyf6ZQpgQOSGvL8QFyeVKS4EYopOXuIlH2tuqu74nO?=
 =?us-ascii?Q?PtQRAO7w2PqDQ/KyGV9Q3x+HkYIr7P2cVbKsF+KVD1TK1IlgbrR9rHBdtWyV?=
 =?us-ascii?Q?/8otR18WjJ71t2uLrtEgqf+VvZPN8r1aPiUU5JQAQyOnFM6gFxlYvhY0pqK9?=
 =?us-ascii?Q?IIeczfQ18dliAwTPGVdfsUsF1vspQNoqcpNg/kT7qD3Mqw8HEJyfJrPuExub?=
 =?us-ascii?Q?C4U18VPWIKwyqparAcMp2LL33YBzDjKazrMgm9ZeZnrmGUI/F5PpJr12GJx1?=
 =?us-ascii?Q?hxDcD2TDVqO7Z9hU9FbCl0ih7VUvoy7fMQmgc7ef4lomPEBgXUwiZMv3aW7V?=
 =?us-ascii?Q?8oXlqrZ/vt34q4UPauYQSH1mbc7IwrHLuSiC4OlVA2PgDWL5rkDaPZobVSvZ?=
 =?us-ascii?Q?ibfdRiuLTOkUU5PYKiYCBDU4M3V6j8QLHKjSZpRVmmpHblnTmA3l10YLxWhT?=
 =?us-ascii?Q?vRVP2KKarzBYIIkHzz+/W/p/wSrDy+dLP3dGyUIA6PckvzrKdx2I5p6jmBfM?=
 =?us-ascii?Q?gRKr5P2jlC22/n6lTKoC3lXBQEIyIUy07AgiVsuRw2yCWYXQRxUAQRJlbFeB?=
 =?us-ascii?Q?wu3wpICWZW93TZKicN/IsFcKhvp4TjHHta9W6Qo80YudBdbHyo1cAm3+Buj+?=
 =?us-ascii?Q?+ZeeHkdtCSt+MTvQqQVYyn0Szt3x5mjAnxCVvsSiuBAv5pC22X4cb6GIxjV/?=
 =?us-ascii?Q?8ttAXqSk1gf31T/iKnemLVjm/yOI67cJ43p9+4wLxTc5gyTwz0j8u5krjWya?=
 =?us-ascii?Q?PBWERoM53V7f6yqHmXQ45+yk0jaPlpJsJ/7swB0WRv0Qyl1unvhGysUAiweL?=
 =?us-ascii?Q?IhVTDA=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: abe886d3-6b64-4356-1c17-08ddd8d4bfd3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:44:02.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOdZPQQEr1AIvPjf6Ggvz+u5P5ScEAzNM2WvNYi42Z+Blq8TPN4cQTWgLz6ItVzjutu0nn4FmwPhlk73i0HVmBpnjWeFJ8ieGD3A85+HzGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7467
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 11 Aug 2025 12:44:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1928

Hi Scott,

On 8/3/25 7:24 PM, Scott Murray via lists.yoctoproject.org wrote:
> The FriendlyElec NanoPC-T6 is a one-for-all high performance open
> source platform for edge computing, designed and developed by the
> FriendlyElec team.
>=20
> Website:
>      https://www.friendlyelec.com/index.php?route=3Dproduct/product&path=
=3D69&product_id=3D292
>=20
> Wiki:
>      https://wiki.friendlyelec.com/wiki/index.php/NanoPC-T6
>=20
> Specs:
> - Rockchip RK3588 (4x ARM Cortex-A76 + 4x Cortex-A55)
> - ARM Mali-G610 MP4 (OpenGLES 1.1, 2.0, and 3.2, OpenCL up to 2.2 and Vul=
kan 1.2)
> - 4GB/8GB/16GB LPDDR4X
> - =C2=B5SD
> - 32GB/64GB/256GB eMMC
> - 32MB SPI NOR Flash
> - 2x PCIe 2.5G Ethernet
> - 1x USB 3.0 Type A, 1x USB Type C
> - 2x USB 2.0 Type A (LTS model)
> - 1x HDMI (4Kp60) in
> - 2x HDMI (HDMI2.1, HDMI2.0, and HDMI1.4, 1x 8Kp60, 1x 4Kp60) out
> - 2x 4-lane MIPI-CSI
> - 2x 4-lane MIPI-DSI
> - 1x M.2 M-Key connector with PCIe 3.0 x4
> - 1x M.2 E-key connector with PCIe 2.1 x1 and USB2.0 Host
> - 1x Mini PCIe for 3G/4G module (non-LTS model)
> - 40-pin 2.54mm header (up to 2x SPIs, 6x UARTs, 1x I2Cs, 8x PWMs, 2x I2S=
s, 28x GPIO)
> - 110 x 80 mm
>=20
> Upstream kernel support for the T6 has matured enough to be usable, so
> add a machine configuration to allow people to migrate off of the older
> bits in the Rockchip BSP layer.  Note that there are two variants of
> the board, original and a newer "LTS" version that drops the MiniPCIe
> slot for a modem for two extra USB 2.0 ports and adds a USB-C connector
> for the debug UART.  Devicetrees for both are shipped.
>=20
> Signed-off-by: Scott Murray <scott.murray@konsulko.com>
> ---
>   conf/machine/nanopc-t6.conf                   | 15 +++++++++++++++
>   recipes-kernel/linux/linux-yocto-dev.bbappend |  2 ++
>   2 files changed, 17 insertions(+)
>   create mode 100644 conf/machine/nanopc-t6.conf
>=20
> diff --git a/conf/machine/nanopc-t6.conf b/conf/machine/nanopc-t6.conf
> new file mode 100644
> index 0000000..5ed413d
> --- /dev/null
> +++ b/conf/machine/nanopc-t6.conf
> @@ -0,0 +1,15 @@
> +#@TYPE: Machine
> +#@NAME: NanoPC-T6
> +#@DESCRIPTION: NanoPC-T6 from FriendlyElec
> +#https://www.friendlyelec.com/index.php?route=3Dproduct/product&path=3D6=
9&product_id=3D292
> +
> +require conf/machine/include/rk3588.inc
> +
> +PREFERRED_PROVIDER_virtual/kernel =3D "linux-yocto-dev"

Why do we need linux-yocto-dev here instead of linux-yocto?

Initial support was added in 6.6 and linux-yocto in master is currently=20
at 6.12.

Differences between 6.12 and 6.16 (linux-yocto-dev) is HDMI output and=20
USB support, so i guess that's the reason? It would be nice to add a=20
comment in code or commit log (too late now that it's merged) to explain=20
why we're targeting a "development" version of the kernel recipe instead=20
of the expected one so we know when to "revert" it back to using=20
linux-yocto in the future?

Cheers,
Quentin

