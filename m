Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A7CD98F2
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 16:34:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.57])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1125.1782146037340665368
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 09:33:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=lMl5as2g;
 spf=pass (domain: cherry.de, ip: 52.101.84.57, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnnY7wvQeyMUcWvPPEPbShSvoLQbNM1mfAPexaLtFNYcqAZA/FO6TZCWONNDLz+P4ySruJGN3VzH7fscob6k5WPAQLgU3w95EMMYtNqf7UN06z+RGXfsYixjzg6hV2MEtD7XH95Rtx8wzFvW84dc3EXtar58dCjXIJl+QJxlo0o0w+7aZhvNPCryqpGW9yKAdFUgPV1sjPAR/B6U9Y/ss0c320yecU3lBrqeeXEx0phDj9n8Yd9L6CK7rOi2/0Mk0nFlI+OubLiobPUjUWLwpIVhp0S3850WlJJ4PHbzd/6KoO9mCc08501sDKNdL1+LAuIZUxslvCERDyHq5B0KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oppwU/aAXMD9IEvrVUIOp5q4Mhkg86InONutmkvtkU=;
 b=mC2ZgX9WJG0wp2ZMvhwsbQGDCRfTdsB53O31if2tZVjz/Zv3eqhZsGS39A2hE3Lv8JXzvnd5QPduAB0AI0gI4oifiLCIEQfqO7wnvYAtM4aqwRl/92w/rv/54Pr9x6NZi7MhgeycAecMUY++b1nUOS8qkjpNzLdNbv9zhm4RC/gfEe2/4JoZu4jcsqojYXjQrgI7+592NzIlPzqXg7tY+Jq44SFxGNOcLZX5fvQRKslyflcV7NMAxjIeMwUYU69LOK++fYrZSRHgq+hEEZ86kiRYTy0GuB8XzzJ/3qFcUWbpMUaXBK5112N67bxl87UnavqMZJKtcYGb/qoFVuGuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oppwU/aAXMD9IEvrVUIOp5q4Mhkg86InONutmkvtkU=;
 b=lMl5as2g9OriFOzsJDuozBlK4+Repk85pNOzYwdbxBk8lAawsY0UznfNtcGjSxrMp97JdDuSwrb6QxamSMhjTbnCHAhERDG9IalF258NZiCt5YQhE7Eq1JOxTGNX+4UhymztoA03p4DAzsTV64HrKR0MGXUBTjqi232O9hLcaU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB7345.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 16:33:53 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:33:53 +0000
Message-ID: <c6c70d2a-92d5-4a38-b1ff-c25337965e0f@cherry.de>
Date: Mon, 22 Jun 2026 18:33:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [rockchip][PATCH 0/2] rk3576: rock-4d: initial
 support
To: yocto-patches@lists.yoctoproject.org
CC: Trevor Woerner <twoerner@gmail.com>, Martin Herren <sputnik@on-the-web.ch>
References: <20260621211915.72650-1-sputnik@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260621211915.72650-1-sputnik@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR02CA0045.eurprd02.prod.outlook.com
 (2603:10a6:802:14::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be4a484-46a8-4b99-9ad7-08ded07c0c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4022899009|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	4mA0VkgyMHcEiNknwfg99qCRZW5amq6e5hKn5CVQGKQmKZNw28shkSXIyW93RLKVIE1RCUB6R+iL+P6l7Hj78mS1Jvqk11ehUTMimprpHk+IEzrSyBOY7nBE7Mn5zfSO5xIf7P7OHiKMDrBPlY4t8U1yH8puDDd9de7/LZNPEIysGAVF7mJC3IIQL9DdWdP4zBa6UEeovoLmwAU0gHbDOpaJ/Xy5QbjBoWVQG0UB4jBjhsP312z+PxMjdoqkPmlrv2P2s7i9KYxcLZV4sd4vnRVfliIxpbnmNbQSFCSAph2V9M6CkunPYO/QnuG5Sru/Mcs8cy1PUXDBywH9oDcozISzKXG62PfuwBd2NaEnYBIrxRjKsHMPxjUHUJYbs5tXtOSPtBwF7nFVqiN7mNAOwJVzBB3AolYxOXZodizYLdYDd4lLRYP4sCFDhhG5CHVPyko6njTmZ243TtIUF+oMQpKXopvsA2SZokbBECt3JUkJWUR3hPSPcFc2TdrIpkjxxTbjF68xBA5zEwogISMNYaw3ayDm5BU6M7QlzMqjaEMAH9DbEOgjz0lVDD/FCBHO9imo8lBgYKjlE0mSsNEEwWO0hMYC/NJjfPSN1jE6PtXGH/iZUYw8h+mA0GHta9nI
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4022899009)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SiD48qq8f3Wsk0y/kC8OMPWEdIQtHLkL4SM0RgQA69AYg2NKSkEwfrvPRUtA?=
 =?us-ascii?Q?/XEqXSQbWs11TKh37mZ8ZoFsSogl9/vpkoZrlKeEpfVXYzcszfwbMw4p8h2h?=
 =?us-ascii?Q?2EtW3G0ljORhqVO/NIjAKWHpDlTN6W4uF6V1TFhbiKJ0KmNPScahSoi6Nhub?=
 =?us-ascii?Q?tn3TphRK4fuQIBRQEmAzNkoWDPeKUrZ1aEyqo0TBlnxoMXHxNUYUIjymSVbU?=
 =?us-ascii?Q?pOYWjjfjZ6BJrKMRnQ/6TgLQjQo5CQ3lyG9HGb9la8WInmIip30ocXFWo5Vf?=
 =?us-ascii?Q?uNN91ebxQDil9qViJX9LvGSiLvk/WSQs65whSdnhQ0H4tqAOSrbaVWVV34fN?=
 =?us-ascii?Q?v6tb8zF4EqaBiTkHpKlcXSOpw5j0mY8O8LloujntRoXEyVY79usKmJFsLVzD?=
 =?us-ascii?Q?cWTzBmBlkKg7SuA3/Ze5jT0hwZMSpaoqIuDxWPVBfwOcdgTg4q1hskdfJzQz?=
 =?us-ascii?Q?x6WlhiU2jRzYoEtGe3QhyTTaqYolm6onNupovoTAD+uYrqBx7ZJSRWSRTl/M?=
 =?us-ascii?Q?I9ExSI87gyTAnykCK5HBjav+BD24RAbMbpCF/WEIw4FwyNKQeenfWSN8gQpv?=
 =?us-ascii?Q?r3M4UnHayjrI7VIuGNWv0qTHo+8omUFBAcn4zqRr/4gmq6tKiYC77eLbsBY5?=
 =?us-ascii?Q?vxrvNb1GHoVfpFvR8A/qfR3jWAqoVqbvGe/n++komNGLJtW+QGZrMv4QMCO2?=
 =?us-ascii?Q?JMX84l//E+lrOLZ13rJ3mjIAm+wTZ35vVH6iwUgZn9Bpa8IapdLEv7D4PFh4?=
 =?us-ascii?Q?rl1jXud7s2MtYGuTkD3a6DhuYhVaH+Lpt7KojMqQzXCXELvQk2ziTfwxPGvB?=
 =?us-ascii?Q?sObQg6Pr6xqiA4MwjWKnnlIM9qDNOcPSU0E613KjX4j1/sU1b9DujAH5SQOF?=
 =?us-ascii?Q?fFw45t9w4ZejBwzayCFWgPJdQSLTT9ReGAN5KlVS6iEdLjqr1d4Tvnqk/h98?=
 =?us-ascii?Q?HIbQ2SXuy8DAmTwCA7KrcZ3bIdqQ9heeGYMAesHf4NUHeolI9gyNKtPAwkWq?=
 =?us-ascii?Q?qbTeqO93ZRTAsXyXrbj9Fi5pEfSYkecxoAL1EFtdP88RiCI0jvMQrTW96JS1?=
 =?us-ascii?Q?8ZEgBx/au61gA2W5eZIXcLwzJMFX81iDtGkd2+d0QjM7J2GwRkb0mAbNt7Mw?=
 =?us-ascii?Q?AN4qbZv64SVSTr8p9Xrg/czKK+B4I1D9hUDwKFNAnZYgulV3iH9xYnEPtrmy?=
 =?us-ascii?Q?6OBuNYehRnHFECiOwBVDSKaYGq549qu0O9iIODZDA0VotWPMQKfNvgXa2p0X?=
 =?us-ascii?Q?gf5X0qglSbz7d6x1Vrx1BjUBLE3bWMxA49lUJY+TUOFJNyQ1joEV4ARP0JjD?=
 =?us-ascii?Q?+21GhtbNg9xU/iq7pw1czOpvOqz0bVXVKLk9402F3L+45ApLxUAhVRJ2FRs4?=
 =?us-ascii?Q?AIC4gj9YjWDrBpBgsvg11WQoBsWbzGyG0+wVd31pJ9EbneXbY1alMJlAFOoh?=
 =?us-ascii?Q?nEPjQfQNud31mI+2VY1RNjUJno2mKkAHZCgLYbB/NYhM+bkmBN7iFTngZqud?=
 =?us-ascii?Q?cFuuqnwAsuJ+kjFzHPMPRy5nZMV/wGsxDCcUyccWtXPj0d4ydBwgT6FJ1tqH?=
 =?us-ascii?Q?TBjM36UjBfeaVd5Q73BQuzHn3aOWHCHjZTiecanXDuKTl8LmPB/SS3dD3IzJ?=
 =?us-ascii?Q?jiYves8EY5j0xQr1RBaZn6hyaEYDSRLfD2XasWPRXajGoRhbvuezNbklVY25?=
 =?us-ascii?Q?vRU8HWGhBsFIfVmSHBzHEBDj4vH86d5RUIgelrBbP5PnQZE6ZAAvsz6K/D1W?=
 =?us-ascii?Q?tIOOQmts2Q=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be4a484-46a8-4b99-9ad7-08ded07c0c59
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:33:53.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GTIAKSoiwikRVJrCh23J9Mt6zG8GiyBOmxE9cuzu9TMIphveEYInoq9DK6SDbBg3dE1rJ+1HWjYpI84Y1P337aBwHPEU/NWrcCgDm4I0lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7345
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 16:34:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4261

Hi Martin,

Thanks for the patches. Please note that your patches should have=20
[meta-rockchip] and not [rockchip], this may be important for Trevor=20
(the maintainer) to not miss your patches.

c.f. https://git.yoctoproject.org/meta-rockchip/tree/README#n261

I happened to read your LinkedIn post a few days back so I was waiting=20
for something to land on the ML :)

Will send reviews for the patches soon.

On 6/21/26 11:19 PM, Martin Herren via lists.yoctoproject.org wrote:
> From: Martin Herren <sputnik@on-the-web.ch>
>=20
> rk3576: rock-4d: Add initial SoC and board support
>=20
> This series adds support for the Rockchip RK3576 SoC and the Radxa
> Rock 4D board to meta-rockchip.
>=20
> The RK3576 is an octa-core SoC (4x Cortex-A72 + 4x Cortex-A53) with a
> Mali-G52 MC3 GPU and a 6 TOPS NPU. The Radxa Rock 4D is the first board
> in the Rock 4 series to use this SoC (the rest use the RK3399).
>=20
> The series is split into two commits so that the SoC infrastructure can
> be reviewed and merged independently, providing a base for future
> rk3576-based boards:
>=20
>    1/2: rk3576: add initial support
>        SoC include (rk3576.inc), rkbin additions for the DDR/BL31/BL32
>        blobs, the TF-A bbappend, and the U-Boot fork bbappend.
>=20
>    2/2: rock-4d: add initial support
>        Board configuration (rock-4d.conf), the linux-rockchip.inc
>        compatibility entry, and README updates (board listing + a
>        "rk3576 booting" note documenting the SPI-flash requirement).
>=20
> KNOWN LIMITATIONS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The u-boot fork lives on a personal contributor branch
> (source.denx.de/u-boot/contributors/kwiboo, branch "rk3576") which
> could be rebased or removed. The pinned SRCREV protects reproducibility
> today, but fetch would break if the branch disappears. A versioned
> branch name (=C3=A0 la the existing rk3xxx-2024.07 convention) may be
> requested from Kwiboo.
>=20
> Martin Herren (2):
>    rk3576: add initial support
>    rock-4d: add initial support
>=20
>   README                                        | 17 +++++++++++++
>   conf/machine/include/rk3576.inc               | 24 +++++++++++++++++++
>   conf/machine/rock-4d.conf                     | 11 +++++++++
>   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb   |  4 ++++
>   .../rkbin/rockchip-rkbin-optee-os_git.bb      |  4 ++++
>   recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb  |  3 +++
>   recipes-bsp/rkbin/rockchip-rkbin.inc          |  2 ++
>   .../trusted-firmware-a_%.bbappend             |  5 ++++
>   recipes-bsp/u-boot/u-boot_%.bbappend          |  5 ++++
>   recipes-kernel/linux/linux-rockchip.inc       |  1 +
>   10 files changed, 76 insertions(+)
>   create mode 100644 conf/machine/include/rk3576.inc
>   create mode 100644 conf/machine/rock-4d.conf
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4252): https://lists.yoctoproject.org/g/yocto-patches=
/message/4252
> Mute This Topic: https://lists.yoctoproject.org/mt/119915814/6293953
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1316870=
3/6293953/1843281461/xyzzy [quentin.schulz@cherry.de]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20


