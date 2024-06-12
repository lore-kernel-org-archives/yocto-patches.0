Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C1C27C53
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 09:03:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.115])
 by mx.groups.io with SMTP id smtpd.web10.6686.1718183002340262033
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Jun 2024 02:03:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=QS59a19Q;
 spf=pass (domain: cherry.de, ip: 40.107.22.115, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdP8l0mEoeuiEzFSudsB/QjBVlp9wcvB1zd9+X2JF2suPJedC/UWDLGO44icB3lEiC1b2OHbGY93ZSbwd+19bTS+be/s/YkpzmAswW5EsCsjwT790KCoZDF+CboZ+0LiolYjpxpqPmdwIjnOfGMnri19g9/ma0SQ1XmoItEZGJU939gBTTfn6zvsStUXq1wELsj8+oLDy095CSbWvcpW8GzJ/T+y7kfHR67r4rhZxBVtfEuBfIzPYk3/uwsLjR+N70X0tmhY/bAdm7tpaXni7eVfewe5lh/M8qTBDiciGiYgngGwi3F54p+FWfBmTO+6TKFpanZHlBf2+ptviRyLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXpF54rtMJ9PgwfvRruKRzAuSjJlAk34KQ+pWNpyY1U=;
 b=Rm5WJJoeVzLbbF9POhsYzwa98G3mOzlvnomMNbQxfdy3e6FJjyWkp5JIycselcp8G6010eH9gZD8QeAbfF6lWzRNLBHV4gqiy9WS+gnKqWwKfym8kC2Tj0WAeXbyQCyj0IKutXldCg7VbKBQIdZa0QxZAJB1oMOZu47Q/m8mvV1GPV3HJTHizC96DpwIx7prEVEXEjUIIlJycn9bM6KizHIhmVjZrD0WwUpLYG+MnYHLvdDnouZDeg5ubIBqTPuYKcaalu/KOyp/juCCAFsi/4Nk4nTr/lDpfRTKjMv28c5qRjaXHinEA2AppRM9E/7slyqf0+xcCqDZfAP+0YZvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXpF54rtMJ9PgwfvRruKRzAuSjJlAk34KQ+pWNpyY1U=;
 b=QS59a19QGa/UWcE/MS2ywV+GGMle9Nm365xcbx99WUvo7iE8nM+JjqRdZaH1XzD8Vw6NijtC+dlpPZUWywEPvO/hdigokDnMhPopKrk55DBQkFCewf4/IVzn5gn9KG6Z3OIT1BAPeYpyg5PupHOA7+DHXhUJP68X8N3fzOApB9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 09:03:15 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 09:03:15 +0000
Message-ID: <533c2092-1a89-4355-a679-1ade8a9555aa@cherry.de>
Date: Wed, 12 Jun 2024 11:03:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] radxa-zero-3e: add
To: yocto-patches@lists.yoctoproject.org
References: <20240612020116.40600-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240612020116.40600-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::14) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DBAPR04MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea2aea1-1656-488c-8951-08dc8abe7e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XRrzo8NS4TJA+iV0c4nR+MUlsWmTLar2+K93vzb/19Z1hCpN4nydP+GpfH36?=
 =?us-ascii?Q?SP1QLJuWc6l9AHy3tbJzoqDwggcohWLi1iOGcEn8tafH27IBWx7NNyrmU5Eo?=
 =?us-ascii?Q?EDZIr5J83vZU8YMHxBdUKT73RKasOnEZ7IwVKTGzLs4nZ4hm4doqjJLPjQfO?=
 =?us-ascii?Q?KYIZG9nTbuG0CDPUNMMcae+xbrpwRigcJRnh5YZvngIlmEi3xy1oJGtfOI7M?=
 =?us-ascii?Q?M7RZlBJx0Z3DykWW+ihj1TcpJItWnT0JPJIz93y5tUy/orFXeQwrPvG1COlt?=
 =?us-ascii?Q?RR+6uDwiKQJsqTfFN284izJnLhYkjDdn9ESRisDkQNm2+lfoDXG164+AEaoM?=
 =?us-ascii?Q?OCOQZROjneF2I3mh8Vaq3WAyUePqiUHVXGAyRDIR+un75pWxd+JDLg23QC20?=
 =?us-ascii?Q?mzbgzAnH5zpLa5I9HzdjOGCK5ES7uid0HkbdOC0rpaK8nzd5q68EIDvwJZgC?=
 =?us-ascii?Q?u642mrbDfidhx3jgK5RAuWNoojw/yql1bqIjiJshRSz+PH/VqLIdE5EkOWd9?=
 =?us-ascii?Q?bEfrsJp0rq5/v5W301Uzgv6GnCdBBZpLJt3w4dfSwUTQ4fStHJ9x6n42qDpC?=
 =?us-ascii?Q?iFRH8Kq14aVJwY3kgZ9XNKCboIyy3WK77h1k7UnGWtB8TapFulYkYSbI9Cyi?=
 =?us-ascii?Q?OWWiTrh/Z0t+vZ+seIQ5z9bslpSWpuLVtcJcQRTlNIDZewAVkEw3MMWd79z3?=
 =?us-ascii?Q?hlp6flay4V/C9KKWnV4SL6Pr2zu7/pB7DEndadAOugN5YofvKssESEv9DhpO?=
 =?us-ascii?Q?tXsvqUfMR+34a+M8z6lhWTqxqXD3rw2UE6QbATwVU1nfDr/RX5/veKWyt2RZ?=
 =?us-ascii?Q?Kp00e30gIprc67jgS8Sh8kGe/NDuwrOOpy5jWX1GCzYw2BICAu5MH7rmgixI?=
 =?us-ascii?Q?USI44V+M+t3UuI77oIFGVcjEqzjBTCzEtXhcLImAaJeE62GqvQNI0KQ6giIQ?=
 =?us-ascii?Q?xJ80HIwV0IEwjeHMquyNkk2G3754cPZXYoN4Jtv9OOpKyrEEjM2+glJCFFv/?=
 =?us-ascii?Q?oMAY0XRW1G/YiAZ1OSm4mIGQmv59ANg0eOBAtaJ0clVU6KJ2/0BN8HcVsV3t?=
 =?us-ascii?Q?ogrP+MLpPNBnK3qQFFf3ksFbEEIurujAixmpzviemD5Dnw+EvYgGHrfZmYKp?=
 =?us-ascii?Q?L//8Hfo5xU3TR9WpLKTujIZMKMHXs/zD7g+WgqwKFaMD2xnGJ+frt7vB77Wn?=
 =?us-ascii?Q?b6WRbDx7kiHWEjTHe468+6OmRBqNIakt2xGBTPenr67TVMrQhXkT1AL08qal?=
 =?us-ascii?Q?AqwaWRJTBFIkXj5P5Z5B?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9nKlOCyFTJV61NCF2lvmmmI9sO6dhD4PttfcnWh8jIFZm2tmdN4oF7IaozXI?=
 =?us-ascii?Q?/jhik+CdHVvRYLYtbW1UOkubZEQ8eMaK3jDb91egxOGBNpbtz2EsW5gkf/QW?=
 =?us-ascii?Q?gsaj0H+daY2Qc5upOacwGChY7DLTd8l71Vu4j0ZjL/eDmUs3tcDiJDrE7bYS?=
 =?us-ascii?Q?ReYIzcfGtXurNjVjXM1Oeb1AUwNTHRzcCWUOd8SJdCT+p67wLDDrEMbXXDo6?=
 =?us-ascii?Q?VMATcOEkAjelg3ytf7tXoTLlLEEOwEjflIVYOZWgF5V48Xuj6Zw4k53NsFvf?=
 =?us-ascii?Q?8c21u/gOa+hX/TMY6gwkiCvdxQWlyRNWp0dgQoakaLqlnmS/Aoc4Pwx48yYN?=
 =?us-ascii?Q?v87iKoqNCdtrRfxMX4sjCC82WtNGFUlg6rym+V8bmG/57GJZHKwa7+UwsF9T?=
 =?us-ascii?Q?RjbG6H+WnT36gagZlZiT3PpLUpoHs0OHjXd26hEUt2p/L5LaRqFot3xgoNuA?=
 =?us-ascii?Q?EDO6VoZ/Ay2WUsu9VzS3NjS0FaGpIBZ9+2R4+YvCsqz6zsfjwXyG2U9htRBY?=
 =?us-ascii?Q?cqmuAy/eVyYYB/7OQpvyAsqFdl2J0q7nVmfoyK2RKMJl2rRYyW7G2pioevyv?=
 =?us-ascii?Q?6waxLMQ1ITeArijye52K+8GvO5JgVlefqMhTrSUNossUyS/g+Z9qkqxRLENx?=
 =?us-ascii?Q?gopfYE3H4tc1ujLEFTIyHwH/WE6iokGutDPGuHWAMlSB89t7Sd+Ld9zcdHTh?=
 =?us-ascii?Q?QaoTld8GzGuCzsIGXo7dgHCnhkEBaJZQuB4bUzFEas4gmBEMTG4+2LAnyHuY?=
 =?us-ascii?Q?XEHDGBzI8lJpFgvxSQZkMlAnNqMUSrMLnxpxRIirE+hlgP9DxEwapiP9keTZ?=
 =?us-ascii?Q?kYRIChUllS2mRzOoUBswHgXrgKrXWTFAwtuwlypBvuU9F+ZVBvbuIBFDqvgW?=
 =?us-ascii?Q?tiCMTCsrWlNUdoBMIdCpd9hIm+PzUY6OJb3jeRQ1Zs69QOos9FGDPz1uAY9Z?=
 =?us-ascii?Q?r6LKEtYuZOXHY+tbRe9BR4N4+GhTIf/keNObTlEWKLUAPoKdbVR6dTladF5V?=
 =?us-ascii?Q?PioMnrFdSAnBus/OOtpfTcF4KjhpFBycIjn2OKwUesTbilRFXEELXcAshvQ7?=
 =?us-ascii?Q?2xnSp2G52Gv8JRnJW+IpfKgEDz/WsVkPZQ5UrHMRS+CvCR7Q5eZPVGD7b3Kf?=
 =?us-ascii?Q?eI9egrIhU0I1cXf0rQPpAAHzE/iKdreqfzhwAfXWcZt8n7h+lgrHyXTbLxx/?=
 =?us-ascii?Q?l2yN0Gu+1hkX2FIZmqXAXpeGGT+7mC9tfhbD8kzUT+5y3HX+3ogkVIl8eppX?=
 =?us-ascii?Q?CG5HO30psRGEEYqSZZpdJHRtIoDYOqWLATnDh0spK6ma+Y2mJyDCcY5a/vEY?=
 =?us-ascii?Q?3j3TqgyqqYvNCZ0T7XVMqxnjuncNkKAU+RA7z2xzm9lzQEvoSrimTX+QrUhU?=
 =?us-ascii?Q?ao+jQ4X5UdJLqvxMGWHH2Jq5Apwh4/nkKkxquag1mJgeegnD7qgk6QDPm2hp?=
 =?us-ascii?Q?XByCJVEDBUaHqpaTKBaH/hvKS0jJDAO7b49Ri3ZpzT5dsZv8W0Vyl6MKIHb1?=
 =?us-ascii?Q?XhrHzIasQmKRQ14W0PCBmaIU3PZx+mgHw65Lle5nZ84IcpCkM35PrHpHuDqG?=
 =?us-ascii?Q?ysGpDXyKth9tuuX0Xhh41TJdmVErGp5a4f0jEiVpB/Fqwbob6jlG/wvwYJJd?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea2aea1-1656-488c-8951-08dc8abe7e66
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 09:03:14.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPoJ7KI0pchybc9XLKcMNXpeos81rlfx2izCx5IM3s5CXjLs06wJ8z2gSRv/wFg5O6d7ZnD4jspSBnd42Wj33ZCZ9ZILqd/YMdpfH0K3pa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Jun 2024 09:03:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/314

Hi Trevor,

On 6/12/24 4:01 AM, Trevor Woerner via lists.yoctoproject.org wrote:
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

Jonas has added support for generic builds for some Rockchip SoCs, maybe=20
you could use that if it provides enough features for now and allows to=20
reach Linux userspace?

The target is probably generic-rk3568_defconfig for this board for example.

> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   README                                        |  1 +
>   conf/machine/include/rk3566.inc               | 21 ++++++++++++++++++
>   conf/machine/radxa-zero-3e.conf               | 12 ++++++++++
>   recipes-bsp/rkbin/rockchip-rkbin_git.bb       | 11 ++++++++++
>   recipes-bsp/u-boot/u-boot-rockchip.inc        |  2 ++
>   recipes-bsp/u-boot/u-boot_%.bbappend          |  5 +++++
>   .../linux/linux-torvalds-next_git.bb          | 22 +++++++++++++++++++
>   7 files changed, 74 insertions(+)
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
>   	builds:
>   		marsboard-rk3066
>   		radxarock
> diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk356=
6.inc
> new file mode 100644
> index 000000000000..41d0a227a988
> --- /dev/null
> +++ b/conf/machine/include/rk3566.inc > @@ -0,0 +1,21 @@
> +SOC_FAMILY =3D "rk3566"
> +
> +DEFAULTTUNE ?=3D "cortexa55"
> +
> +ROCKCHIP_CLOSED_TPL ?=3D "1"
> +
> +require conf/machine/include/soc-family.inc

I think the RK3566 is a stripped down version of the RK3568 and the=20
common parts are handled by rk356x.dtsi for example.

I'm wondering if we should have the same trick we have for rk3588s and=20
rk3588 to have a common override to not have to maintain=20
variable/function overrides for both SoCs?

EDIT: seems like there's a different DDR bin for RK3566 and RK3568, make=20
it make sense. Probably because the RK3568 seems to be able to support=20
ECC on DDR4?

> +require conf/machine/include/rockchip-defaults.inc
> +require conf/machine/include/arm/armv8-2a/tune-cortexa55.inc
> +require conf/machine/include/rockchip-wic.inc
> +
> +KBUILD_DEFCONFIG ?=3D "defconfig"
> +#KERNEL_FEATURES:append:rk3566 =3D " bsp/rockchip/remove-non-rockchip-ar=
ch-arm64.scc"

Did you mean to keep this comment here?

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
> index 7929c6ac3a10..6894558ef70c 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin_git.bb
> @@ -4,6 +4,7 @@ LIC_FILES_CHKSUM =3D "file://LICENSE;md5=3D15faa4a01e7eb0=
f5d33f9f2bcc7bff62"
>  =20
>   SRC_URI =3D "git://github.com/rockchip-linux/rkbin;protocol=3Dhttps;bra=
nch=3Dmaster"
>   SRCREV =3D "b4558da0860ca48bf1a571dd33ccba580b9abe23"
> +SRCREV:radxa-zero-3e =3D "a2a0b89b6c8c612dca5ed9ed8a68db8a07f68bc0"
>  =20

Why not bump the whole rockchip-rkbin recipe? Also is there a reason for=20
bumping it? I already see rk3566 blobs in the current git commit. Not=20
against bumping it, would be nice to explain if there's a reason for it=20
other than "newer is better" (which I am a proponent of :) ).

>   PROVIDES +=3D "trusted-firmware-a"
>   PROVIDES +=3D "optee-os"
> @@ -15,6 +16,7 @@ S =3D "${WORKDIR}/git"
>   COMPATIBLE_MACHINE =3D "^$"
>   COMPATIBLE_MACHINE:rk3308 =3D "rk3308"
>   COMPATIBLE_MACHINE:rk3568 =3D "rk3568"
> +COMPATIBLE_MACHINE:rk3566 =3D "rk3566"

Maybe order alphabetically here?

>   COMPATIBLE_MACHINE:rk3588s =3D "rk3588s"
>  =20
>   PACKAGE_ARCH =3D "${MACHINE_ARCH}"
> @@ -36,6 +38,15 @@ do_deploy:rk3308() {
>   	install -m 644 ${S}/bin/rk33/rk3308_ddr_589MHz_uart?_m0_v*.bin ${DEPLO=
YDIR}/ddr-rk3308.bin
>   }
>  =20
> +do_deploy:rk3566() {
> +	# Prebuilt TF-A
> +	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk356=
8.elf
> +	# Prebuilt OPTEE-OS
> +	install -m 644 ${S}/bin/rk35/rk3568_bl32_v*.bin ${DEPLOYDIR}/tee-rk3568=
.bin
> +	# Prebuilt U-Boot TPL (DDR init)
> +	install -m 644 ${S}/bin/rk35/rk3566_ddr_1056MHz_v1.21.bin ${DEPLOYDIR}/=
ddr-rk3566.bin

Sigh... Rockchip, almost the same SoC but different DRAM init.

You could also decide to rename the bl31 and tee to use rk3566 in there=20
to avoid adding custom handling in other recipes. Not sure this=20
obfuscation is good though.

> +}
> +
>   do_deploy:rk3568() {
>   	# Prebuilt TF-A
>   	install -m 644 ${S}/bin/rk35/rk3568_bl31_v*.elf ${DEPLOYDIR}/bl31-rk35=
68.elf
> diff --git a/recipes-bsp/u-boot/u-boot-rockchip.inc b/recipes-bsp/u-boot/=
u-boot-rockchip.inc
> index d2267cc53a92..113190635bb5 100644
> --- a/recipes-bsp/u-boot/u-boot-rockchip.inc
> +++ b/recipes-bsp/u-boot/u-boot-rockchip.inc
> @@ -1,6 +1,8 @@
>   BL31:rockchip:aarch64 =3D "${DEPLOY_DIR_IMAGE}/bl31-${SOC_FAMILY}.elf"
>   # SOC_FAMILY for RK3588S is rk3588s but it should use the binaries from=
 rk3588
>   BL31:rk3588s =3D "${DEPLOY_DIR_IMAGE}/bl31-rk3588.elf"
> +# rk3566 uses the rk3568 bl31
> +BL31:rk3566 =3D "${DEPLOY_DIR_IMAGE}/bl31-rk3568.elf"

Order alphabetically maybe here?

>   EXTRA_OEMAKE:append:rockchip:aarch64 =3D " BL31=3D${BL31}"
>  =20
>   TFA_DEPENDS ??=3D ""
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
> +SRCREV:radxa-zero-3e =3D "8cdf606e616baa36751f3b4adcfaefc781126c8c"
> +SRCREV:radxa-zero-3e:rk-u-boot-env =3D "8cdf606e616baa36751f3b4adcfaefc7=
81126c8c"
> +

I think a separate recipe here is wiser? They are essentially different=20
sources from a different repo. Although, maybe the generic target is=20
good enough in which case we wouldn't need that at all?

>   SRC_URI:append:rk-u-boot-env =3D " file://rockchip-enable-environment-m=
mc.cfg"
>   SRCREV:rk-u-boot-env =3D "cdfcc37428e06f4730ab9a17cc084eeb7676ea1a"
>  =20
> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-ke=
rnel/linux/linux-torvalds-next_git.bb
> new file mode 100644
> index 000000000000..bbe4689922a7
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> @@ -0,0 +1,22 @@
> +inherit kernel
> +inherit kernel-yocto
> +require recipes-kernel/linux/linux-yocto.inc
> +
> +FILESEXTRAPATHS:prepend :=3D "${THISDIR}/files:"
> +
> +DESCRIPTION =3D "Linux Kernel"
> +SECTION =3D "kernel"
> +LICENSE =3D "GPLv2"

Deprecated, should be
GPL-2.0-only

> +LIC_FILES_CHKSUM =3D "file://COPYING;md5=3D6bc538ed5bd9a7fc9398086aedcd7=
e46"
> +

This is usually at the top of the recipe?

> +
> +LINUX_VERSION =3D "6.10"

Isn't it supposed to be 6.11?

I would recommend putting
DEFAULT_PREFERENCE =3D "-1"

to make sure it isn't mistakenly pulled implicitly.

Maybe even add a COMPATIBLE_MACHINE only for this new board?

> +KERNEL_VERSION_SANITY_SKIP =3D "1"
> +SRCREV =3D "next-20240611"

Please use commit hashes and not tags

> +PV =3D "${LINUX_VERSION}+git${SRCPV}"
> +SRC_URI =3D "git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-ne=
xt.git;protocol=3Dhttps;branch=3Dmaster"
> +SRC_URI[sha256sum] =3D "3a1c433c4ceffa52f8c3df3aab8c379ff91ca658021d409a=
528825e5e24580f4"
> +

Is this actually used by Bitbake? It's fetching code through HTTPS via=20
git and git should handle all the integrity there?

> +do_compile:append() {
> +	touch ${B}/Module.symvers
> +}

That seems odd, can you add a comment on why this is required?

Cheers,
Quentin

