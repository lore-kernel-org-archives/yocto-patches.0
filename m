Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3545FD68BC6
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 14:59:53 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.62])
 by mx.groups.io with SMTP id smtpd.web11.22558.1731682782715528945
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 15 Nov 2024 06:59:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=ZNM27NAI;
 spf=pass (domain: cherry.de, ip: 40.107.21.62, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk6dPMjLDQoKfuwFZaOxz/wT58nBdEm13hPYOjDtT8O0Lhryu1kWR7qfeGuF2RHR63lhwcbmCBNIHBGhrIH/TaM4VR7QTgLiv85s/EB0OQ49OvfVXKlpu6iZSL2Zy1ttygzqSw0/mBAiiuMt9OCbXXuO068tdk9UuuEXyoIiEn0RZ8ulGu2Y+OtLrE6nHBFUTPFknF0ES8wX1Lxsz8ngFXs5ptTdY5SMvhJVoc5gcLkVCRosiIaR7mZNJ+jetnqUwx5zDWFDFY2lIg6lo3hJ2hmRT4IBcBDtNshUbNc/438MzSaNdWKbeSAFrbngQU0InWtpQw6cNU5w6VjV3Ge1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEy7PZWNlAT0FVjNFlt80yj3F6SBYVx0pPjtqQ7Ag0g=;
 b=R4e1/chQqZ6Df7kJo0I4LyTj4drTDnGJHG+/gfdUthfN5R9coQagxn8Xgun+1OWYQvau/MgsIZqNHnmqCo2kj5/L0iuTYIHJDrS+FT2IeFMtiQ4gLdLNk10OaYFrdf5MnsAIuSPLARggHoM+fSDPi93RPffrLZoQtmHwIL5VNhotfCz++8z4o7wlcnd3RqvIzg8w4pNCeTRld+WVR2metiBO7bh9vCVMmKixKtyJEPHjdEQWQ8A/Z1gr2991WCgFiaCiCQW1hnbM3kUE7hXM1wNyQAvWq2e1VkF4+0rQlrduFHbylVVL+YlfXtt/S49e7+ajVsiN92mPL9z09pIvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEy7PZWNlAT0FVjNFlt80yj3F6SBYVx0pPjtqQ7Ag0g=;
 b=ZNM27NAISjmb9qZsyPwaSCL0AQBsTcywoKoqUMGXK+milL+6S4W+GNK5stz2nPqBOTDZozb4eh9VPa5JmnYgfDvq3n0YfGYoySmlZ4EAtBEvWlCvIrBlaCrjzYg0xDds2ozYy0R6WA1Q31CPo9o92UzdmPP9Mr9fBGS/XD82R5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7976.eurprd04.prod.outlook.com (2603:10a6:20b:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 14:59:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:59:38 +0000
Message-ID: <fb559dfd-97a7-43ff-812f-ed20952fc526@cherry.de>
Date: Fri, 15 Nov 2024 15:59:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
To: yocto-patches@lists.yoctoproject.org
CC: Trevor Woerner <twoerner@gmail.com>
References: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <3608313a-2d69-435d-807f-3dceb6326ca8@trifork.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0294.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b05389d-7793-4098-7c6b-08dd05862042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?fplp0ciaD4RO5CWuwXQ7O0W4B/jdGo0Lq/sS0LQlFFyBHZ/tPpELdHhAntyb?=
 =?us-ascii?Q?dRMQlFNfhN05NVtldEkAEu4ux7Yjvh2YhWijhmByqFdcgIhQJeQ+vzO/r1NI?=
 =?us-ascii?Q?TLgdgvRlPezMAZ/UPOPFiZwI18bCsVHUc7POZi1gpLexn5dKpqaCxkX0nz1K?=
 =?us-ascii?Q?y5rkDaP/zKKcfgUuQ6ciwdxjHID/D0ZtjKAN70TCN/fIKW98Fv4uU5FIPvIb?=
 =?us-ascii?Q?0mRPJEmqOYunbCO8Lf8aJYEplP8M9gpZQbD0keVDw7PqfVei91ugA4AIekHt?=
 =?us-ascii?Q?9TultGHmsq6K+kxqaU0gJtFysnW8ySdc5AhgT3X3j6dddaQ7Nmug623SpzKD?=
 =?us-ascii?Q?JVfpzgO6c+EAfqrLhv93+8tmUs7p5CtYazEvUO65rEXHScYnpBn1FvO69v5m?=
 =?us-ascii?Q?K1dM93J6IyCopTP6tPNj8jX09BEydYCTS7LcJGRVGOme5Ee3eDZ83xEF6olj?=
 =?us-ascii?Q?YYcuDjMd8Tf7q5weJTX2oT95qFucW6cy4GP2J/6AhGjoz6p2S0Y4/413q7b4?=
 =?us-ascii?Q?Dz3bn4VZtxVwgNuXtAvqLrCFpRE+PIDrbbMp0ZpmUkVgpErb462gfTFatEAP?=
 =?us-ascii?Q?/06W4bDF2ZFRerB2nzIi33N1Bt+I/xPj/DGwxXcp7dfQewERcjatAcB7wYHn?=
 =?us-ascii?Q?eo7PmqIUgRRiZn8/T3cpj17S9qFO+gOY5RHvjLSThWe4jYCetWzP+knIwj0t?=
 =?us-ascii?Q?xG1EfIhk4cGgju3yADhMzbTKrtMsaMCiYFJjDz3q9/N+kMtEvSiZ8Dp2X0WI?=
 =?us-ascii?Q?d5Aoft2eiPv5Ka+oWzb7nGgyVrBgR9WDNXhDxUflAms1FDQL7Yi/8EDNq507?=
 =?us-ascii?Q?Ql/IX49a1gDrhAe16tqK9cnY8FQwaeJUj8HzrN6u2dqHh3E1D51cb962rtfW?=
 =?us-ascii?Q?uIK2hw2NIC6DPPpSAkuSCuYcoAlazrulYlL6AxdLVVHzuAqxHdh9RZAqkNC9?=
 =?us-ascii?Q?wGCeBS/+orYEkCGSuiaeirElH1x1fSogEmoR1AiJnnl53OKtsRNVK8W/wM7O?=
 =?us-ascii?Q?BkuMKWYlHKDLBxMdW0NLkCUNLVqu/OKKA2Mxhs9NLMJphwKKsn/GkZm+MG9o?=
 =?us-ascii?Q?Wr09MT10X04Zf07yC2/yh0/ZIe+/ZY6IcrGMpEnUn0l0vZ4C20aKFWYSJYpM?=
 =?us-ascii?Q?+k0CoFrNV9cFM0I5EuKWipGUByaqSu5K5zxV3J44xxmLlFJRaWIWPcDjxbzY?=
 =?us-ascii?Q?7IMoU1Znw6dXQA8T4/8XC3VknvXZxSGEBx129eIXOinFtEMcP12S0jbX/OrD?=
 =?us-ascii?Q?1QgIozfuB1qjJ9tLi+mw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nao7gHuGmxqsS+VGOQnBjiP24f7BcqiH7sxLkS6Fxs0lF9zZJlrImFylOSf0?=
 =?us-ascii?Q?9Ph5ZIccS/Eas9iLlm0XoKfLescc9DoJeYSuzWwBGCQi5Nu5ZTCZppjMbDOT?=
 =?us-ascii?Q?8eTAlDtu2P3OSE+E9GzHbRQOS/+2ocTsWGBV6QEM8vgXRNf5QJJjZvDuZJ8p?=
 =?us-ascii?Q?V7WM+1PBHgErPmnDtKE39+JoeKvsYiSpd3advow7nPhe1CrCzLV+XJukYXTx?=
 =?us-ascii?Q?ZIyLCRmSRzpHPk2GLxkdETZKY3FevgqGeB66gtZSCE7i1g1sDloz8eG7Mpzj?=
 =?us-ascii?Q?NScCYbOl0v8yFtHHXbceOmWY961omLPYvY8cGJzqlwRzlmOmxp4CefsAdDI3?=
 =?us-ascii?Q?sV4aOAmHnnngLHF8ySuSk+G+8ddC8PEiqGUDpiy6P81ScNfigjbXI1XW227w?=
 =?us-ascii?Q?yQ5iKidntBFoyGCPwJG6yVZBMoUNSBg3E0ZqFhCIkvIBy9QZRo1cSzkg9uEQ?=
 =?us-ascii?Q?AWPFI+LItx5neRp9MHNvwgkeSyunlTEr3JQJ+knOEMLbJo/PP/JAzBxoxh+P?=
 =?us-ascii?Q?I2bUNFo+my//4SHwlVEBSZ3QeTwLGwoN45dPjeiHEZOyZ9kxAGkrBHstoq7R?=
 =?us-ascii?Q?n4gZpO0XqBXGvSQ9dT26XkAwlMA7Bho4W7I1ED5kPHqeykl8cwgzaVQdQGzn?=
 =?us-ascii?Q?TYTb/BpeCFORcvpZCvAlTFBrQ4LfCMTzuIv4pxpPUNRIlXv53Pv2k3I0YBmj?=
 =?us-ascii?Q?m0q/aLZ8eSn+B1e99Xu0tOtHZ9oZf5XDjfqKXdaC67Ofv8L3465r2bP8syqF?=
 =?us-ascii?Q?Sy3wZjq++uGHrE8Jk2lDGdHlFlAfc3Pa3H3kXVLsjn+u0ZAQk3wCUs4K/loP?=
 =?us-ascii?Q?xyYcNDOJ66cWalxCk8mxrLSIKBV2PDc5rz1/+FtdKsgBRAqC572E9jCnNWB9?=
 =?us-ascii?Q?JsIxI+srhaLFFzdenNLok1AmiSN76+jv7PemqCsZlhVTCqVk7E1rW4TqTxlZ?=
 =?us-ascii?Q?KJhhWyQjlKrwRTan+0hDecx+ZLkO8NroSNJeOVv7ZYkO9IWzusgWvR6lDV2q?=
 =?us-ascii?Q?+zLHboBLSun/rNzbWYXqXQjYm1jF97DZZDUB+8yPvZkyk8XCLpkH0YgCybJt?=
 =?us-ascii?Q?0JtE1EoaKbn+IHVwKi1i9vqndEzxW8RsTB+63ZLJ1PHbh3g0jp13pGQWJEBV?=
 =?us-ascii?Q?r0aZetqoSnz9ZngTFMyjEclcIEogs6+gnt4pzbc/rx6rsSP56bOUZUfxYv4P?=
 =?us-ascii?Q?arA8vaidEZETww0s+5m2RnTic23D4POq2Cjh9VMh+DQlzVHZAPxQdS03IbV4?=
 =?us-ascii?Q?pQlWIHNVR+Loiz5vuPCUR2JNtAzY1zJaVH2jsWnsAsrVRe2fY0qT1NBNfvw6?=
 =?us-ascii?Q?ZRNmgZBIfl7MEnq2hEE0Inf9rMpbdOnd5fAGlXUgmDBRHWEkWij5U6EWqCGg?=
 =?us-ascii?Q?Of91y5muI04fBBQWzw7a6/2JwiQ50VjOlmUBJq23OWUe8EuMIEeJVi3L8xzA?=
 =?us-ascii?Q?jO7NzrGwmncbfnaGwKDrJ6N6u9M4A7y7pxz2w1bOLMISXH7N4KszH63M+OA5?=
 =?us-ascii?Q?4uSa8HxmPGmeMz77CSrgvfTC1/kCm4xoJH+ZApbKhKWaDmQr+3yP6L2D1vb8?=
 =?us-ascii?Q?XLsUQ80QT4mi8q3wyLgSvzvpsiy/40ypeyvfTmKnKRa+GYWBdYN4zP/ejp2u?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b05389d-7793-4098-7c6b-08dd05862042
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:59:38.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bn0rqWLGIkkFLBVv+4iwS6htzRaMUucuOH60USQcvZ7SOLjX2J6kcmD/CwS6XtMx5G+OYJayh+ahztL56NZ0xJSryDisfqz8TcZIjdKVzng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7976
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 15 Nov 2024 14:59:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/810

Hi Paul,

Please version your patches when sending (usually -v N with N being the=20
proper version number should be enough), a vN will then appear next to=20
[PATCH in the mail subject. That is necessary for maintainers and=20
reviewers to not have to figure out which one mail is the latest and=20
greatest patch you've sent and they should review or merge.

I can also recommend using b4 which does a lot of things automatically=20
for you :)

See comment inline.

On 11/15/24 3:51 PM, Paul M. Bendixen via lists.yoctoproject.org wrote:
> [You don't often get email from pbe=3Dtrifork.com@lists.yoctoproject.org.=
 Learn why this is important at https://aka.ms/LearnAboutSenderIdentificati=
on ]
>=20
> The SOQuartz is a RK3566 based compute module and parts of Quartz64 serie=
s
> The Model-A base board is one possible board that supports it
>=20
> Website:
>       https://pine64.org/devices/soquartz/
> Wiki:
>       https://wiki.pine64.org/wiki/SOQuartz
>=20
> Specs:
> - Rockchip RK3566 Quad-core ARM Cortex-A55@1.8GHz
> - Mali-G52 2EE Bifrost GPU@800MHz
> - Raspberry Pi 4 CM form factor
> - RAM Memory Variants: 2GB, 4GB, 8GB LPDDR4.
> - optional eMMC from 8GB to 128GB
> - optional 128Mb SPI Flash
> - 10/100/1000Mbps Ethernet
> - WiFi 802.11 b/g/n/ac with Bluetooth 5.0
>=20
> Exposed preripherals:
> - 1x HDMI
> - 2x DSI
> - 1x eDP
> - 1x LVDS
> - 1x CSI 4-line
> - 1x Ethernet
> - 1x USB 2.0 OTG
> - 1x SD
> - 1x PCIe 1-line
> - 28x GPIO
>=20
> Model-A baseboard:
> - 1x microSD - bootable
> - 1x HDMI Port
> - 2x USB A 2.0 Host
> - 1x USB C 2.0 Host
> - 1x 5 pin USB expansion
> - 1x Ethernet w. PoE
> - 1x 40 pole Pi2 compatible GPIO
> - 1x MiPi-CSI 2 lanes
> - 1x MiPi-CSI 4 lanes
> - 1x MiPi-DSI 2 lanes
> - 1x MiPi-DSI 4 lanes
> - 1x PCIe open ended
>=20
> Signed-off-by: Paul M. B. Bendixen <pbe@trifork.com>
> ---
>    README                                      |=C2=A0 1 +
>    conf/machine/include/soquartz.inc           | 15 +++++++++++++++
>    conf/machine/soquartz-model-a.conf          | 12 ++++++++++++
>    recipes-kernel/linux/linux-yocto_%.bbappend |=C2=A0 1 +
>    4 files changed, 29 insertions(+)
>    create mode 100644 conf/machine/include/soquartz.inc
>    create mode 100644 conf/machine/soquartz-model-a.conf
>=20
> diff --git a/README b/README
> index 09f8691..85ab2ec 100644
> --- a/README
> +++ b/README
> @@ -45,6 +45,7 @@ Status of supported boards:
>                rock-pi-e
>                rock-pi-s
>                rock64
> +            soquartz (on model A base board)
>=20
>        builds:
>            32-bit:
> diff --git a/conf/machine/include/soquartz.inc
> b/conf/machine/include/soquartz.inc
> new file mode 100644
> index 0000000..6714efc
> --- /dev/null
> +++ b/conf/machine/include/soquartz.inc
> @@ -0,0 +1,15 @@
> +#Copyright (C) Trifork A/S 2024
> +# Released under the MIT license (see COPYING.MIT for the terms)
> +
> +# Common override for basing a SOQuartz design on
> +# https://wiki.pine64.org/wiki/SOQuartz
> +
> +MACHINEOVERRIDES =3D. "soquartz:"
> +
> +require conf/machine/include/rk3566.inc
> +
> +# A machine using this baseboard could use these options or overload the=
m

I think it is actually required to set those variables in a machine=20
configuration file since nothing else defines a default? And since those=20
are now commented out (as they should).

So I'm just nitpicking on the phrasing here. I wouldn't necessarily send=20
a new version just for that, but maybe Trevor will have a different=20
opinion (or fix it when merging).

Looks good to me otherwise!

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

