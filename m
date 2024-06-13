Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFBDC27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 14:11:13 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.130])
 by mx.groups.io with SMTP id smtpd.web11.9742.1718287866909238112
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Jun 2024 07:11:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=kBVPlj9C;
 spf=pass (domain: cherry.de, ip: 40.107.6.130, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er3r4ppW1YG4QHFX3xFb+wX2GnLM0udwrXrcwH1PYbAVTQLpt3a8iqckvbcQCVdXqA+N5LEkcb9n7IhXiuY4KmYbLuaCe5jherEOo3dtBR4X6pqwdY/ZhHArc23rukbmo+fmakTuBYqS+JWbqv0wZ+LdsbbxExEbQDTL+pFasELpbiXrW53MOElDw5jvuotoob1jiPJzjFeVvWg0CbCYyPpakihRXABbngPkYxgxYMQ+5Iv6AST1ahzViLYJsPjOtTHyOwlW1BRTwZ/ykoGXoX9gwAbx1k5XyP3gKzNr9tnTjEeuqSXEfwyGSNfrWPcZUybxkMVsoMqezSnzDstjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBrrBRkSU1t4Qawj2BuuQmaUbwfgYmttCdty41bzhRQ=;
 b=IzmRUCCGaf+0dQf9ThYJgoEknnFtirUpAaqjFv07qWfG3vQMZa5xNHgvPnXMI9eOir5UW0npbYGJbdbtZEG66pPokkOz+B7zkT98IFoHwWASrIpqIt5jgZ5EwPqaMoopf+cQmb5JcdlUKbf4MPJbclPeApfQBZYjLrq1YJS0LmlFm9pf/7uFxgxP9rN2Br1i/Q0AvHTbCE/HSvlgEb+75btQo+Co+7PZvjUXKCzXT2yIDgAs3h7urVBZLegbCTTjEmE9tl4SQ2FZ46JA7qiqhvATfuNkDlH3cPqugfIwxtmNMCEtSgzxfBv1WHlvTJBgl+5AtFkpimiO5IrH0YRYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBrrBRkSU1t4Qawj2BuuQmaUbwfgYmttCdty41bzhRQ=;
 b=kBVPlj9CHF4VHChgnkLVcrQfG7t9hEzE5xk6ofA8/OhjYJXHabCOxoz45ybBPZ7WpzhBx9Asl1AJtK5BuZbfSHxhsDgXvTiOBGFJeThgC0Ygi8wpPOO61yRJKyATBtbDUr2rwujWwdRKGr5NH420N0jWOIq1gMT18nHp1u6GxXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA1PR04MB10650.eurprd04.prod.outlook.com (2603:10a6:102:486::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 13 Jun
 2024 14:11:03 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 14:11:03 +0000
Message-ID: <e049c688-be1c-49e0-b922-d4f44c94885c@cherry.de>
Date: Thu, 13 Jun 2024 16:11:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 2/2] radxa-zero-3e: add
To: yocto-patches@lists.yoctoproject.org
References: <20240613133544.21164-1-twoerner@gmail.com>
 <20240613133544.21164-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240613133544.21164-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0027.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::18) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA1PR04MB10650:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1731c5-fc7b-410e-52f8-08dc8bb2a8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6bPdqNJ7UXFzTRlqQsqfHhAjpEc3oaT6BupyiNDW434pOwSVZLFKrrMOJRy4?=
 =?us-ascii?Q?wjBmiROfaDOI6y6JfZRL8+8s1QADJCeBrrNQQ1E3agYsjEPnyVjZLO5Yt9pL?=
 =?us-ascii?Q?WUL4b9gHUzqVYWANxay4GBTCEgZmraLB+MfwSuex4hQ0PbBgCL00F4/hCPil?=
 =?us-ascii?Q?xC6cOHLfg45icCZO+z3evxKOnkvauIxp4p7hD5wS9EP1/DxKC58J/CElQ+3o?=
 =?us-ascii?Q?WqRuYRLaA8hj0Jg8adu3V9dJtSBuCwsBaOiM5AhOSvJ0uYuTVewiXBhHJO/5?=
 =?us-ascii?Q?VhKWKMXSBBu9hO/U4ayvTiakkbC/8J0zXWY6HpmMAgEuDLs++QChbBkIsxLj?=
 =?us-ascii?Q?Adxg8Z0g+eeHO+5IZrn0CPGY/i3Q7vlCFnVObkEIODYVu2z2TL9LdkNSllGZ?=
 =?us-ascii?Q?GDqQ0ev40U6iSNH3GbGFW4t2gQV33TX7uacINIxXfUnGIE7zI2l5/sEdpgEX?=
 =?us-ascii?Q?d3szmlVojYFcr+3CUCQNeiPA5hAJmI+MrpIQqsdwvwV0KSQy/C29ns8pZx29?=
 =?us-ascii?Q?ckoUCpfrrX/c8wlq5g1YRvr7ageuWQe2Er16gqQRSZoSAqOmhohOT8wYAIgc?=
 =?us-ascii?Q?wvwQm+GIWVnP7XH16YjvW0b0RgUM6xbL2gHnF67bHBuYKL5C22Hw5H1FA13b?=
 =?us-ascii?Q?F4DILelBc45w8+GsSxAFaeHXHtysJtz1h18a0kli+kDTd9qhrIhvrezxvAqF?=
 =?us-ascii?Q?dyb3Ag0Lb4LMLXl596JIOYYIMwp1LEV+zrsXukT2CVN0GjjXIsH+mSUKtNR+?=
 =?us-ascii?Q?1JreYc5fkUiOAab6Tatp2EJxuGdvdyQZMH+iWpejCxVgwLYWVIo1WP5FycSY?=
 =?us-ascii?Q?4lkx4EvSrFikU2ufVJub/uipLvzisTSg35YsFyl7QTJTFs7t78+ZYDmdb4YG?=
 =?us-ascii?Q?ASFqK5nACI+D0q6jLtrgWAKf5+lOn3xDJUOFEevFtGHvac8lITCaAQfUIxrD?=
 =?us-ascii?Q?EYMHQNaT5vXbE6yssVoYLry/ErqMRehqObqW8MFQWel0lexWPQDgfis+k3aN?=
 =?us-ascii?Q?u3uwocPMMzvbvLB0VBi7UbGQKOfuc6j4lkLIguZCmyCR/15/citLZrAlRoEC?=
 =?us-ascii?Q?jZQnXKmdDD08ZbaO/hUK/zNIansVhexhTbNyMfAar5bmmnkjp5IGywWs5x6T?=
 =?us-ascii?Q?1oQpD/oy+QOrCG/IbuwEoI5GbvCoWiPmCTqVeGYcZMALxgtct3xdStnUymmE?=
 =?us-ascii?Q?QS8Bo0+VSUbxern2V/fJgNJ9WL5D5Wt8hglK85qbui3GCMuaCBSHRx3BdYSR?=
 =?us-ascii?Q?WIxoGD1KSy0dbmT24oDX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tKa6nh6Skn/SXmYKHBctdfLGL7cQ/A7fWlUCwUwVwWCXyWMUMYpGGdXI7NeN?=
 =?us-ascii?Q?KUbL0korfo54vPUKONOoj85XiWZgLIwnMKzJPm3f/Ii2YINGM+3tebOgtGC2?=
 =?us-ascii?Q?X085hO+jzLljUK9AI56nkfGQs1CcHEe5SDLTpjP0hymJctpmw2iWIKypXTAF?=
 =?us-ascii?Q?irCJlUzBqT/WFFzXNcQyGO5oanc2C9Rzf8qkakCmar31UUvCwfU6SFW/qKxl?=
 =?us-ascii?Q?Xn05KbjyQtgqeEMQBWienUBrY+ByZy6JxGiN3OlCjXW9+ei6+CK7F1l83aeB?=
 =?us-ascii?Q?1UvmHhlwypUQjp0FQ9lJZ+pmhUc7tKxIzh3adofEwd63EBQy1zBkyLaBIpyo?=
 =?us-ascii?Q?28tgVmxrxWFxfVwT1ffcwtnaUhBclqPyvkxFnaQOhBxQRixcp8xcDq9PGC4K?=
 =?us-ascii?Q?RPxmK/oxlw9GpQV01oJdYyIjZP3yxmnnB3B56J6ng/2QPb6B5v5OFZWGej1W?=
 =?us-ascii?Q?A4Fyxlrxx19hg/A4SPdQ/ff5Yl1kf9lDnDPKRtyTOyVSi1SfpFpDXFNe6VmI?=
 =?us-ascii?Q?WG0fyknFrB2FYXgtrei85ppVoTpqrq4HGN0slU3cpigquS3XQ12L4l2wjLd7?=
 =?us-ascii?Q?C+o/gt903xx0cbpPyMySMGB1FI6EzryBwhwpO1Z2Utj1WNMeIKDFLa/UxeO4?=
 =?us-ascii?Q?PwFZgCbEu/X5rPyA2KXpWl2m7hVIoIFBP6OVJ9kmNxnmJuNJsKOmtH+J+6R+?=
 =?us-ascii?Q?O41xf01Wkzec2Mtwn09xTeQ/8+2yoj/Teu9IKUVRPAZ3dfivTZhG/la9xx1R?=
 =?us-ascii?Q?oYtlRj6voZQ33kgErRHIg2UYUYpvVoP1Cb4uPGyF/d1G+ouPW0TDYq5P76wx?=
 =?us-ascii?Q?1UsuE00wrj4I1UUMspGKDR4NGsi7wfPglC52Z+fTKTELP6R07sBn/e1WouKX?=
 =?us-ascii?Q?eH2s5GsEfrn3TgTT7kybfUS1kyGOoZmvCq+XXvunfsKkk9qWKqn/ZQw2VvKN?=
 =?us-ascii?Q?zqW/A5/SsPAKXuivE7dxuL1Ub8SCqK4fY0grfYVLoJcpGuqkyFMF40yVKhDD?=
 =?us-ascii?Q?1lqLlWEeWhXK3RoJnJ5Ow9iu5WE9rsZ6pClt54vnha128k+S4Qd1e/W4e9OD?=
 =?us-ascii?Q?yWZRIuDbHyIyg0jEJOWXGr+kd4bXfgSycIe1GyJfKK5CgRbPmNAb+X+hlcKk?=
 =?us-ascii?Q?rpd/AaeLUWBkBsm+8P5lBczFMUEaSfBvQKLJ5bJxeM6BU8OXQsAxaQvufxrp?=
 =?us-ascii?Q?Ae8tNE4T1iOYKRRLiPVcumrgThBBxNfCnlrCrFTcl7ZKMnFIu4b/pc5X5kNx?=
 =?us-ascii?Q?imnQS2DHMKGCxhLd0KsduEb2RVUj6X7AMBG5IK1VJqidaN9oqCXwrpmGfYH1?=
 =?us-ascii?Q?AqN4dj92ftl7jz3861BPplq1cFz9BEdvE1BB2f2xXkZd5CyUSoda1L685CCP?=
 =?us-ascii?Q?jtBctgrXvHUEG5EWdnc/UsF0/OJh6jG4IvMrK+rkRMYDbMjY1lwWkyYsMcad?=
 =?us-ascii?Q?pRC/8TupkBLOgXAoGf+KM9HBgsS5pN0mKsR4a8zAl9DOrb5gspp1k8TFqt5D?=
 =?us-ascii?Q?Aoe5sXUjTDU0lpJlUN/Oi6C6zqmfmod5cIgAvrkOAPycKsugBgDFwQNflJSL?=
 =?us-ascii?Q?Abn9CrU/nHGRMEKCe3YQsoJWgTj4E6vlh9HipM1K/ukGo3nW6Lkuwfiay8F1?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1731c5-fc7b-410e-52f8-08dc8bb2a8b8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:11:03.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6byafek02c7M7ZflJXNXNxAvwh+cWhmJG3cI/woz3V9dYWy6vlqRlnEwhkG4lI3aD6wwuUiumWBF0n7xH/9uLRdx1tIh/gfFSi0NTlLLr6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10650
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Jun 2024 14:11:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/321

Hi Trevor,

On 6/13/24 3:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> The Radxa ZERO 3e is an ultra-small, high-performance single board comput=
er
> based on the Rockchip RK3566, with a compact form factor, and rich interf=
aces.
>=20
> 	http://radxa.com/products/zeros/zero3e/
>=20
> tech specs:
> - Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
> - Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL 2.0=
)
> - LPDDR4 RAM (1/2/3/8 GB)
> - =C2=B5SD
> - GbE
> - 1x USB 2.0 Type C OTG, 1x USB 3.0 Type C Host
> - 1x =C2=B5HDMI (1080p @ 60fps)
> - 1x MIPI CSI camera port
> - colour-coded 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
> - 72mm x 30mm
>=20
> NOTE: currently support for this board requires a U-Boot fork for the
> bootloader, and linux-next for the kernel. Support will probably come in =
linux
> kernel 6.11-ish, at which point U-Boot will then use that kernel's device=
 tree
> which means U-Boot support will come after the release of whichever kerne=
l
> includes support for this board.
>=20
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v2 changes:
> - copy the rk3568-based bl31/bl32 pieces to have rk3566-based names so th=
e
>    rest of the infrastructure works without tweaks
> - uncomment/implement the "remove-non-rockchip-arch" kernel scc
> - order/sort items
> - cleanup/fixup the linux-torvalds-next kernel recipe:
>    - sort oe items based on the style guide
>    - remove vestigial bits
>    - use a commit id instead of a tag name
>    - update license string
>    - add DEFAULT_PREFERENCE=3D-1
>    - add COMPATIBLE_MACHINE
> ---
>   README                                        |  1 +
>   conf/machine/include/rk3566.inc               | 21 ++++++++++++++++++
>   conf/machine/radxa-zero-3e.conf               | 12 ++++++++++
>   recipes-bsp/rkbin/rockchip-rkbin_git.bb       | 12 ++++++++++
>   recipes-bsp/u-boot/u-boot_%.bbappend          |  5 +++++
>   .../linux/linux-torvalds-next_git.bb          | 22 +++++++++++++++++++
>   6 files changed, 73 insertions(+)
>   create mode 100644 conf/machine/include/rk3566.inc
>   create mode 100644 conf/machine/radxa-zero-3e.conf
>   create mode 100644 recipes-kernel/linux/linux-torvalds-next_git.bb
>=20
> diff --git a/README b/README
> index b21e92360dcc..a9a040a4308d 100644
> --- a/README
> +++ b/README
> @@ -40,6 +40,7 @@ Status of supported boards:
>   		orangepi-5-plus
>   		rock-3a
>   		rock-4c-plus
> +		radxa-zero-3e

Maybe you want to order those alphabetically as well? (But they=20
absolutely aren't right now, so maybe another commit or... never :) )

>   	builds:
>   		marsboard-rk3066
>   		radxarock
> diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk356=
6.inc
> new file mode 100644
> index 000000000000..586d68806df6
> --- /dev/null
> +++ b/conf/machine/include/rk3566.inc
> @@ -0,0 +1,21 @@
> +SOC_FAMILY =3D "rk3566"
> +
> +DEFAULTTUNE ?=3D "cortexa55"
> +
> +ROCKCHIP_CLOSED_TPL ?=3D "1"
> +
> +require conf/machine/include/soc-family.inc
> +require conf/machine/include/rockchip-defaults.inc
> +require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
> +require conf/machine/include/rockchip-wic.inc
> +
> +KBUILD_DEFCONFIG ?=3D "defconfig"
> +KERNEL_FEATURES:append:rk3566 =3D " bsp/rockchip/remove-non-rockchip-arc=
h-arm64.scc"
> +KERNEL_CLASSES =3D "kernel-fitimage"
> +KERNEL_IMAGETYPE ?=3D "fitImage"
> +
> +PREFERRED_PROVIDER_trusted-firmware-a =3D "rockchip-rkbin"
> +PREFERRED_PROVIDER_optee-os =3D "rockchip-rkbin"
> +
> +UBOOT_SUFFIX ?=3D "itb"
> +UBOOT_ENTRYPOINT ?=3D "0x06000000"
> diff --git a/conf/machine/radxa-zero-3e.conf b/conf/machine/radxa-zero-3e=
.conf
> new file mode 100644
> index 000000000000..3a39d6c12a1f
> --- /dev/null
> +++ b/conf/machine/radxa-zero-3e.conf
> @@ -0,0 +1,12 @@
> +#@TYPE: Machine
> +#@NAME: Radxa Zero 3E
> +#@DESCRIPTION: The Radxa ZERO 3e is an ultra-small, high-performance sin=
gle board computer based on the Rockchip RK3566, with a compact form factor=
, and rich interfaces.
> +#http://radxa.com/products/zeros/zero3e/
> +
> +require conf/machine/include/rk3566.inc
> +
> +PREFERRED_PROVIDER_virtual/kernel =3D "linux-torvalds-next"
> +KERNEL_DEVICETREE =3D "rockchip/rk3566-radxa-zero-3e.dtb"
> +MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
> +
> +UBOOT_MACHINE =3D "radxa-zero-3-rk3566_defconfig"
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin_git.bb b/recipes-bsp/rkbin/=
rockchip-rkbin_git.bb
> index f9724ddd5cd5..1b71414e27ca 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> @@ -14,6 +14,7 @@ S =3D "${WORKDIR}/git"
>  =20
>   COMPATIBLE_MACHINE =3D "^$"
>   COMPATIBLE_MACHINE:rk3308 =3D "rk3308"
> +COMPATIBLE_MACHINE:rk3566 =3D "rk3566"
>   COMPATIBLE_MACHINE:rk3568 =3D "rk3568"
>   COMPATIBLE_MACHINE:rk3588s =3D "rk3588s"
>  =20
> @@ -36,6 +37,17 @@ do_deploy:rk3308() {
>   	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLO=
YDIR}/ddr-rk3308.bin
>   }
>  =20
> +# NOTE: the following are not typos
> +#       the rk3566 uses the same bl31/2 as the rk3568
> +do_deploy:rk3566() {
> +	# Prebuilt TF-A
> +	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk356=
6.elf
> +	# Prebuilt OPTEE-OS
> +	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3566=
.bin
> +	# Prebuilt U-Boot TPL (DDR init)
> +	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/=
ddr-rk3566.bin

Here you could use '*' instead of the version, up to you.

> +}
> +
>   do_deploy:rk3568() {
>   	# Prebuilt TF-A
>   	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk35=
68.elf
> diff --git a/recipes-bsp/u-boot/u-boot_%.bbappend b/recipes-bsp/u-boot/u-=
boot_%.bbappend
> index 1f5f63459627..dca43d2a4de0 100644
> --- a/recipes-bsp/u-boot/u-boot_%.bbappend
> +++ b/recipes-bsp/u-boot/u-boot_%.bbappend
> @@ -2,6 +2,11 @@ require u-boot-rockchip.inc
>  =20
>   FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
>  =20
> +SRC_URI:radxa-zero-3e =3D "git://github.com/Kwiboo/u-boot-rockchip.git;p=
rotocol=3Dhttps;branch=3Drk3xxx-2024.07;name=3DKwiboo"
> +SRC_URI[Kwiboo.sha256sum] =3D "5d102a658262f6d2d4ea0664fe58b77db4a9eb1eb=
c89dbd8d6f5e75c9e563810"

Is this actually used? I thought the git fetcher could handle corruption=20
on its own?

> +SRCREV:radxa-zero-3e =3D "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> +SRCREV:radxa-zero-3e:rk-u-boot-env =3D "8cdf606e616baa36751f3b4adcfaefc7=
81126c8c"
> +

Still don't like that we share the same recipe for essentially different=20
source code, but up to you.

Just being curious, did you check the generic-rk3568 defconfig in=20
upstream U-Boot?

>   SRC_URI:append:rk-u-boot-env =3D " file://rockchip-enable-environment-m=
mc.cfg"
>   SRCREV:rk-u-boot-env =3D "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
>  =20
> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-ke=
rnel/linux/linux-torvalds-next_git.bb
> new file mode 100644
> index 000000000000..88916587e259
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> @@ -0,0 +1,22 @@
> +FILESEXTRAPATHS:prepend :=3D "${THISDIR}/linux-yocto-dev:"
> +
> +DESCRIPTION =3D "Linux Kernel"
> +SECTION =3D "kernel"
> +LICENSE =3D "GPL-2.0-only"
> +LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7=
e46"
> +
> +DEFAULT_PREFERENCE =3D "-1"
> +COMPATIBLE_MACHINE =3D ""

This doesn't work, I already made the same mistake some time ago in=20
meta-rockchip :)

https://git.yoctoproject.org/meta-rockchip/commit/?id=3D36b07ec60c94eeeaa48=
66cc876bd6f7f8fd823e0

It needs to be "^$"

> +COMPATIBLE_MACHINE:radxa-zero-3e =3D "radxa-zero-3e"
> +
> +LINUX_VERSION =3D "6.10-rc3"
> +PV =3D "${LINUX_VERSION}+git${SRCPV}"
> +SRC_URI =3D " \
> +	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;proto=
col=3Dhttps;branch=3Dmaster \
> +	file://rockchip-kmeta;type=3Dkmeta;name=3Drockchip-kmeta;destsuffix=3Dr=
ockchip-kmeta \
> +	"

You could provide a comment here stating which linuix-next tag this=20
commit is referring to.

Looks good to me otherwise,

Cheers,
Quentin

