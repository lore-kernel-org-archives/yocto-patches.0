Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3055BCF8840
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 10:35:25 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31092.1763634915884738155
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 02:35:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=f3SVidMp;
 spf=pass (domain: cherry.de, ip: 40.107.159.45, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjpTLB82oTO0ql//1xiJ6kNq16FurPAyyxo96CA4m4VuFCb6Fy8zh8wyEsxG/1dU7fKtinmNjsR0g8zfH+HpAY+MNrhPmD8N8lQZ2yKO2eSrxwPR9HTkC/tDsC9l/OMgVsJmIv9wFv5/fPPpfE5v/C9LyrWzsxS7v1nx1zQlUzOo0rkJG5sqFZiVf69ACkbFPdssof2Bwa8AcEjzwVEqQoGc5fUg8Ucttcf/DtwxG42Hd4eYnjzh74n+v5R6RCabCoOvcJxfpx8nHg4fCppEmxxaTIitExOLLHHHGeI4pgme1REYgcvCIwXfGbdY1V4BGOahriryIpht38xZZ+OhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZkyRYW5BeqZqFA74XkzbETmAHAK2F5e0Syk9wKwc90=;
 b=clLGhvCMOAP2anv9iqXGMpc4PURFRUuTxZn6ur/JUHbH0nzyGaMxlVG89rxGllQzoCpkDdZrdOK/yxvej22sqmD0Gkcw91Z/ktRtVBhcf92dOmjyGoXstmSjrOEoOUjLuu0V+2UG/Oa9JNtujBxRyUxsz4kJeK3roPqaE9ctsHR4TrCKOXbr2Bh3FsnhYlzZoGbvV0ZVBYB3ghP3K8QdOMq2JQEWepY/SWfSDWIvl9C95aU5gdFMVUX3kxq4drIX1/LUcdFpcCmf3fZ+8A729f3ABT+fdhu8UFITv8OEwMV+Ws4rNCr2T4fnQ9HxcEUx1L6pOKhLt6qpuNJLtwJBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZkyRYW5BeqZqFA74XkzbETmAHAK2F5e0Syk9wKwc90=;
 b=f3SVidMpUbqoVTEfy2MhO9R9uUNxYdWQFhaVADv29DBvCX7+O8Aj6XNiPW48oJvPEN99pWgvxaqFX7MHUSbh2lfN/l3WI30jDQ9VWTK7ZZUxrk1juyU1z6K1qJe13EC3DeR3Q6Z2CJuLSSAdd6bNGX8YUPNEb2jyu1vnThzyIVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7916.eurprd04.prod.outlook.com (2603:10a6:10:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 10:35:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 10:35:10 +0000
Message-ID: <71898d93-c240-42be-a1b2-42ac1e5b854b@cherry.de>
Date: Thu, 20 Nov 2025 11:35:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip] orangepi-3b: add
To: yocto-patches@lists.yoctoproject.org
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>
References: <20251120-orangepi-3b-v1-1-3d31722d6fef@rootcommit.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251120-orangepi-3b-v1-1-3d31722d6fef@rootcommit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db8888a-c2c9-48ec-1ac2-08de28207b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VV8FrjDa4baUFTGluvhEvlDz1aUO3lQet0j3SR26WV9lOxwc/ghO3lN9Iw/P?=
 =?us-ascii?Q?vRrarZfEAe/76Wg7Jm03eGyzu+RjOo1cebexFZmcbLZ4V3FN3LI5aFH0Oe73?=
 =?us-ascii?Q?gQY/UVoWLyAilAHkC3S1IBCZOZnXfd5rZbSZ3XHQU66HSmAugV5F8yn5VT4y?=
 =?us-ascii?Q?h8bcIUbnpma+T1+pHA50hnVOeuo9YtNYQxnPDKwkUppiKYCn7DBtNkDcMJZG?=
 =?us-ascii?Q?0ouEEOwyVLgBFOlPcpyxXG7olWxR7AWMQbtaSo3V1JfcO1uB4AXEWbFKMMBI?=
 =?us-ascii?Q?EJnzlX/8LVOupZlF+BeP+tCiqLeyIyEocbXLvSEsZZx0bdMO4f3FvAGeZiPj?=
 =?us-ascii?Q?8lqvTX04ySLrK6njnQfXyx8yun5UN5CAPb52fkVwTp3hfBbkGN8qEIQIj+az?=
 =?us-ascii?Q?AynfVcS+grWT7MFoTWO39vabQ62BVrIlYck4BEG3cAIje8eiTNscv+DJ8BUV?=
 =?us-ascii?Q?LfCKN9tK9h73Kmkk7bTqrwb+mRYuhZQUecmcfmWT8Jnjru/+E+zt5gpuwwKn?=
 =?us-ascii?Q?qLlnfpyVxDKyJqBHej+bSZE4tOuA0Ko4vX6U6ZiWB8QoRLiEvdC5jT8/gjNi?=
 =?us-ascii?Q?TIh0jZituY9UvpsqWQn42HPr+Ju6ZjUot4DV0/49X71KeWUIns1eR+QeFUH0?=
 =?us-ascii?Q?vor9zMiSTMeRq592pwOVuzKlYDYgD4KVajv8aBr4h5tuL4/1PQHaqgx65L6Y?=
 =?us-ascii?Q?0AiQ08jujd0xONZYMVQNjt1SoxDPomRDkIDRtfPKTFXHzf+aYZEHHD2840aU?=
 =?us-ascii?Q?Xe5jwpJTzCa7G0gnwhaGq9P7+Q7n9tKTtsY3QkuhhuLN6yhp16NMecRAH0HI?=
 =?us-ascii?Q?k3EU5Mu3utzjy0s4A7BPwltutp6r0/bLz0tHma4yKMS3lAWUG7GN8kpVF01I?=
 =?us-ascii?Q?tijbJ/gYnmVBhPJrlqsQE+ABOIUt4Bbctns3ItDBIZkGCY7DGMJTomZOJx+s?=
 =?us-ascii?Q?XrpjJYp1Rjr2zRc23BWhSv75Qsup6IpXMXyH944DxYLjyofNkH7dOuyNcbpC?=
 =?us-ascii?Q?F1qcIxZby+La9xpgkQO1eOax2eu7frlFPKe2ip4I1JkYuILdVJusXnQGvpxP?=
 =?us-ascii?Q?JX0NSZm53Zy9PqxwsGD6d7ar/RqsvWHxnM8IRfiyG9IPkgZMWGHJfDSWptPu?=
 =?us-ascii?Q?rs9qVTVAVpUvy7W3MgBUh7hCDdcFS1EkGonYxYzrP6hd9SNx5V1lQbsyg5au?=
 =?us-ascii?Q?MhOG0JVCwHQ5y2sXIVBIUfN9Zv8S/WLjaMywG7nzvvmdGOQjrvR7ibQHzlt0?=
 =?us-ascii?Q?ZDO5PZDm3xw6+pIr0MHC8+ycBSY+Fgvc8PKGQOBS1c+2UD6tzIeQmQHS2TNG?=
 =?us-ascii?Q?7FA0Dc5jvvLKBhgm9Dfu3+ZegNRuy08c11pzvtI2atNOraORGzD5WNrtc0sA?=
 =?us-ascii?Q?4O0qUdZB9p1WnQ3n3/GXDdfw990KQHK3Exo15nEDYJPXALbN6A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1HbdVHgy7xEfx7oB1vcSOHY8gefeWQUkoHa9Ms5UFUhm3IGViKGreiti2VJ5?=
 =?us-ascii?Q?p9OQLjhTA1xDckBmfbC7oqY0AB701fkT1GR+QYvn9ENsRk/V4aKxZzBLDhP6?=
 =?us-ascii?Q?avLpErNONmAUsFk09LSwKroJbuwv9XnBeB3dOt+cd/mSD7Z1tSMWcBzmGsoa?=
 =?us-ascii?Q?ZFYuT+5Bz0/SEqxr0My0f0/dz2jovILjkACczj66bqs/taEn6OmQ0g6XnHMR?=
 =?us-ascii?Q?UsRLs85696Z/2JBNyl18G08CmvUJD8CJ0Dikio7DJNhdy4OICCRxYtRIfTlB?=
 =?us-ascii?Q?oZRHe3TJNeq4xtjwPG18BxzncX6CgGRwiU8OYLKwa0N4nKik9RcIM8sbAgJU?=
 =?us-ascii?Q?oVJZIf8weYipTctDqdB6LmjcyDaf4WRVm0YYAWTt+o4ax905D186tBjBH2G3?=
 =?us-ascii?Q?nAMW8Zj1dBLN3pnI9ShNwFArEU2VmN8AnZOfgdwZ0w7p/noKZ2a+4ZjEK0cd?=
 =?us-ascii?Q?XySuZ9CJe87HzJZoqqGgjMj2NbbmwDefQ8GuRi3syI2aUnD+sfaRl6s/kS0A?=
 =?us-ascii?Q?Kc2+Mj1jCgDyLLMnJcb2qL+viw4wXOzoMDIuf4HQEVyWOZHI/XyB4HKsK1oI?=
 =?us-ascii?Q?Jqah2Myw7CIOUtMSPuIeKkfzDRLnSYnjGn4P/U2BqYJgab+h3/fbjknHACsQ?=
 =?us-ascii?Q?U+s/wQNFH72Gq8kOd9CQcA0WN5a8YbL9UrmqRdqQXuI8eJFXZ1rXXSYDiYf7?=
 =?us-ascii?Q?ypG/uVQi/zD8I7UWY5cjcfoDkdR5jla6k1wUuOs3zrwTcejoejr/5qCdbpYI?=
 =?us-ascii?Q?CAt92K1zmX/uTg2zusT2c9g9xKwua5lt/nzBnrbdarZ55GsLla3adAFUAjUD?=
 =?us-ascii?Q?mg1dC8zz7x1rPHKAGEa10sKmg6DvPBLmXPCi5bJ0st/7wpWgSfrB+ODW9L8q?=
 =?us-ascii?Q?uDOCmCmPYFR7O/U+bdVOW5Nm+yiLqpC3+JW6NRqIU8K9zzmfSwkKLI6SGaYT?=
 =?us-ascii?Q?IOxyzAhWhC8fQBvF3TV0R7IFw16X+kLxNg3zXtVIPl81makx+gsaxi7ACkWR?=
 =?us-ascii?Q?NoA0I5SAfIuqc7VnemhMEafScGA/raHP1Qrp5fquSahkC10lM+VddOqGeq3z?=
 =?us-ascii?Q?ZF8nQjMinoFqfI82yH8MuEMVP4vaEUnNX2swDilyloAy+EHNlv1Xs+J2+2cq?=
 =?us-ascii?Q?K/Le+qhwdApTNGHvE4cl+kMPrhxyRH1Vd1ffQ8ujny1Za42en+Z7RXzBFBLD?=
 =?us-ascii?Q?H3GBty9dAFo/S+pXhl7DYdXuJ0svoKC6t8+BpHO01EiJRe6LtUfE3UmvEEu+?=
 =?us-ascii?Q?IdauSbASjbIbI2T60gmAZeSb2e43VxR+YVqKkTiXhGLra2eaVwTjmlbJYjmL?=
 =?us-ascii?Q?AB6DLAtxHWgYzOJrkRsv7VK/CJkp19J19mA+dJP8NU7MvdCVUSG91jr6mPLd?=
 =?us-ascii?Q?Vx6yZ3fKW4pPs22NdIC8bEKz27nicVtVbWpLz+/1Ne61bRb1Y2UlGNdmYw1p?=
 =?us-ascii?Q?AjjZfk4pFHdvwneWQqBWdw/sq6238f8ES2gITnkbijIH+0dAl7Bj3p55Yk/e?=
 =?us-ascii?Q?9D8CtbOeB5hub9cz16ZxVsCPMbcQYNnZ1FS9KVg4zMwvqY/Jws0qptHiMKm8?=
 =?us-ascii?Q?E3m76DM3U9iCGbFzLMhn1jRMtdxgL5QZDMeaKrKLaJA7SQ86v/lK73WUXaKO?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db8888a-c2c9-48ec-1ac2-08de28207b0e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 10:35:10.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQfovKsTt0olL1QnHAxxSTg2J0Hq1FppRQTTnI2TZAYxmks3vUZ2JELhFB1pxov5NwRAxAOaZXAcK+dn8VRV+DhQaCXGhlVFkdJ+LhnEg1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7916
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 10:35:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2623

Hi Michael,

On 11/20/25 11:25 AM, Michael Opdenacker via lists.yoctoproject.org wrote:
> The Orange Pi 3B board is a Raspberry Pi sized single board computer
> based on the Rockchip RK3566:
>=20
> http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details=
/Orange-Pi-3B.html
>=20
>      Tech specs:
>      - Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
>      - Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenC=
L 2.0)
>      - LPDDR4 RAM (2/4/8 GB)
>      - =C2=B5SD
>      - SPI flash (16/32 MB)
>      - optional eMMC pluggable module (16/32/64/128/256 GB)
>      - Wi-Fi5 + Bluetooth 5.0, BLE
>      - 1x USB 2.0 Type A OTG, 2x USB 2.0 Type A HOST, 1x USB 3.0 Type A H=
ost
>      - 1x HDMI (up to 4K @ 60fps)
>      - 1x MIPI CSI LCD port
>      - 1x MIPI CSI camera port
>      - colour-coded 40-pin GPIO (uart, spi, i2c, pwm, gpio)
>      - Gigabit Ethernet port
>      - optional M.2 M-KEY PCIe port
>      - 89 x 56 mm
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>   README                                      |  1 +
>   conf/machine/orangepi-3b.conf               | 11 +++++++++++
>   recipes-kernel/linux/linux-yocto_%.bbappend |  1 +
>   3 files changed, 13 insertions(+)
>=20
> diff --git a/README b/README
> index f55f750..6a13428 100644
> --- a/README
> +++ b/README
> @@ -31,6 +31,7 @@ Status of supported boards:
>   			nanopi-m4b
>   			nanopi-r2s
>   			nanopi-r4s
> +			orangepi-3b
>   			orangepi-5-plus
>   			radxa-zero-3e
>   			radxa-zero-3w
> diff --git a/conf/machine/orangepi-3b.conf b/conf/machine/orangepi-3b.con=
f
> new file mode 100644
> index 0000000..eadf458
> --- /dev/null
> +++ b/conf/machine/orangepi-3b.conf
> @@ -0,0 +1,11 @@
> +#@TYPE: Machine
> +#@NAME: Orange Pi 3B v2.1
> +#@DESCRIPTION: 3th generation SBC designed by Kunlong Co.,Limited.

Not sure the board identifier number really is synonym of generation. In=20
any case, should be "3rd" I guess :)

> +#http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/detai=
ls/Orange-Pi-3B.html
> +
> +require conf/machine/include/rk3566.inc
> +
> +KERNEL_DEVICETREE =3D "rockchip/rk3566-orangepi-3b-v2.1.dtb"

There's also another device tree in the kernel tree for an earlier version:

rockchip/rk3566-orangepi-3b-v1.1.dtb

I think we should probably also have it in KERNEL_DEVICETREE.

Looking at the U-Boot code, the bootloader should be able to load the=20
proper DTB based on some runtime detection.

In which case, the NAME part at the top should simply say Orange Pi 3B.

Otherwise looks good to me!

Cheers,
Quentin

