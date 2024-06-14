Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7A6C27C6E
	for <webhook@archiver.kernel.org>; Fri, 14 Jun 2024 08:58:57 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.101])
 by mx.groups.io with SMTP id smtpd.web10.6969.1718355527301091543
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Jun 2024 01:58:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=B1UaO16k;
 spf=pass (domain: cherry.de, ip: 40.107.15.101, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM9ncf1o0o6QtbKa5r1wZ6qDVVaDLRfQK+nKPyrfFQTkUUYfeGaRKx1Rbh9Ild2BmqRSAn5tJ8ZmrRSGYo/+3B2cRAaYS48sGbctl2eKN0B1tbTRadKOcNMb6OrDs4JDvBwnw+597sXaEesIEELr7j6n7qcNbmwZ+df7rJFZQfSWJV2Z1rcdiIkfdAdwVrV9VNHjeg8K9vvKj+n9eiZVaBHAmutCcMFcyfX4Bb/AC38SKv/eKgteGv22hAnJdErRg4vXjSJ/rkLZBGvfwH4bDJ/qXQPyfZX7tp2ov4Sol9Zcmfu5TFoJchGh/oO4EKqa4RltB9gPVYuJ0Yc4/z9kHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PactCxVn4eUxpYkp2dzRrtPOKAPnOzzeflHa9AuXThc=;
 b=kaIvX89B3hg8Z1zoTvezRlJpQefMdvMyu87HLpoXWzd1KytACA1cBWrTqyYXAHfsFq6r4JSZNuq/F+UN1BtZNo6XyFaG3gaBlq1/apW4Prwqw80LL3oXZHbHgmFsXyqvilXiTu9ATxh+kSGeA6bX7cuwgDI9CDtFKMIjVwLZru4r47MWM2mq7gMYqxCmW8f/0MkxZu1OfESriGyiYH2kqZNMOiYV1jYNAkGiCTojECDa4IVW7rKzoBYoMrw51QsvGfxen6ilFA3bg857EQ/sDRFfYsMm6hPzNN/VlyxQnXTAU2xGf03g+RxuJ+TEpXH5Yp8SzR0UQxdKckiMIdin+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PactCxVn4eUxpYkp2dzRrtPOKAPnOzzeflHa9AuXThc=;
 b=B1UaO16kqRCEJA5ZUY42UO2lbsf+OZ6NYAli+YGwrzhBkyD2CzMY+oSCWSLW63AUJtGT4vEG+0sA6DukX3K7nWSZ92QKXfiixDsV3sOLyFsjgB3LjAUS5vYN87bI3ZX9qUSGGKX5bX0nCkgTn8ZACKQT3O59R38GbXw6IOqVTSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 08:58:43 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 08:58:43 +0000
Message-ID: <7753f6f6-209c-44fa-91b9-9e8ff2be7b8f@cherry.de>
Date: Fri, 14 Jun 2024 10:58:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v3 3/4] radxa-zero-3w: add
To: yocto-patches@lists.yoctoproject.org
References: <20240613170154.6441-1-twoerner@gmail.com>
 <20240613170154.6441-3-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240613170154.6441-3-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ee2ed4-2b1c-48af-9e52-08dc8c50313f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|366011|1800799019;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ITyXuTJk90mF5Trq4uZvlsWKHvau/dg6rQI4IsBdbp0TKoG+Sy0+7zap8vyq?=
 =?us-ascii?Q?IUI+SFZQRHXEtg9MadpvkuG9H0OUB1OrqCv8wJ6+e/AP8TIlovunNM7n7vFz?=
 =?us-ascii?Q?/LdqkdrCRbb3nzV5Z4D4lG1A2pOJ10PJUD3J9MeUVNXlb8OG6lbuwnCwKlEF?=
 =?us-ascii?Q?k/Mhzcq5czV8+Su7FU5Z0qbII4hP72GPgPqgjgDq6r7Rz0r/2jZFf1iU7lnl?=
 =?us-ascii?Q?n4by65yWZbq3BkDH2XurX3tOiBrYW7eNIZtXaJFRRR0+0UJTttKyJ6I0lIBt?=
 =?us-ascii?Q?lD7VDcVvMvuZDbUwVcjHBNsM9kWTZDZG0CmaHs/VM9N+1KKcCVykwVMLDaS6?=
 =?us-ascii?Q?TuLFU/+3/2UFWM3AmEtWAVQt6aIw65PKfiz7LKRQydiezm1ZFkHIQJRnQWHX?=
 =?us-ascii?Q?mZcNmgI9Am/f5Rg3OUDRbxufmuQm1cB2iu1DmDITQ8Skg742PxxSwdwz8rH1?=
 =?us-ascii?Q?neRNiR64A5o/KA3UlnM95l7VSUEHeX5NOgi8AZWJXaa1ErY9azTNKylIm3jY?=
 =?us-ascii?Q?AH/ugIBdbSEXLPhrj4+cyTFFRVSTvDL26Pt1x/ITQTmaZ5mJmxDKDbzOH0H7?=
 =?us-ascii?Q?OOEP3pDqjpIGWflr5MCO6xRLPk0b7Ljl+tYBMIwUAcRPWCy7i0j1vSX3/yvy?=
 =?us-ascii?Q?TrgODoyycCpVh8Bz35LB5DJQzaLXZBDGC0q4StX+eKzDdYfohH+FK45tXXyX?=
 =?us-ascii?Q?w3JHv8TYBU08cszKXGW8EKrSRzpaZsnWTO/BqmmXZ0Ly/OiRdoj2kvjBl+WQ?=
 =?us-ascii?Q?2XGgYMuoCXZ3ZRx31WHinXMnz8PevH5ryDx/OiILI0HyfnUjiqOBRQkpXrct?=
 =?us-ascii?Q?xsVV4736hDC9AKs6yhOQVhnNAZFKUcvl9bCU38RQu37Fdx2P89PqA4+YtVQ/?=
 =?us-ascii?Q?V7Mvzuq1FV+v982LEZmbdJEyHZY3hg/ZWjU2APkHzZlBmdBSSV18Pf9Z3WfE?=
 =?us-ascii?Q?uH0NoDozxahG2kl1V1w0D79tHXcWrFzGYh311ttZjNJOMmWWUaaVHoDgJ7mB?=
 =?us-ascii?Q?p/Z/HYZbQkZzFHQsE91BEGAZifP0Hqx1WCZI84BHATOyUQh+r+Qh0bgarUQq?=
 =?us-ascii?Q?gt98QbSx0Crlbzvs458W0jG2C1jfXbsD5nlcfIbiEj1JF4uZZVKBgUPzHJV0?=
 =?us-ascii?Q?VOKF5PFg7TS0HWO/YWLjsZQBag2e6Fa1gfcoQ98qk00+23cjM65fLKmIhEmf?=
 =?us-ascii?Q?V2egJLG3xFpKJ21JiGybVDf8y1LjVfD5AfJSMmP8PbTMM6i4SIjN/ze0iyHE?=
 =?us-ascii?Q?9HzJ5BeajB7kuifl+2s4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(366011)(1800799019);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i3qNp7PX7XWeptYDtnjyl+QTdt5KAzIFh5DajHaEqdnRPu3naDLrX+z/OPt4?=
 =?us-ascii?Q?MpYeSrq2C4v4zVXxEPtZQgzfjhnslYvGNJ+KY9MdcqmSfHEJCoz/oJkAmoch?=
 =?us-ascii?Q?eWM7GVRmtJJEdQ2AjN09pKzVX8yAazQCG5cVmxq26NbDaibW+V2T6lQp5CHr?=
 =?us-ascii?Q?JN/yxUw2qB+ZmdE8vqULBxTN5NzUKMhs7etEg1jqXlORsRrgToumUGNXgo0y?=
 =?us-ascii?Q?h5hvMMOWD7pnZurXFkXWAryYK5eADXlzCGAXj4I9+x+LOd/KzTi/rafX58JL?=
 =?us-ascii?Q?n32FWjFuSBDEJR08yss8UVuESfvD/Os571UKPHV4lQ+fdXP/ocZ9tADfthty?=
 =?us-ascii?Q?IgZZHQU0RAlSY6q7n9SNxGirwodz3jhWco46s6eOKNaCoLOZKVMKFNengL3W?=
 =?us-ascii?Q?Jl66eUt5NSZRuMQn+gZCv7iQupgsGCleXAxRG1TA0ZLPU1L5lpuAnXUKFhcc?=
 =?us-ascii?Q?aaJI0itNKYI3yvBm5qBhUUurt6ATkVRD2hKKguo493U4WD1XCVpz1QTx5wA7?=
 =?us-ascii?Q?EIShvbVmqXYnKe9iyp6pQ1mQwNA3oRmnva2NhgXoK86kzFbh+dlaoemzlaaC?=
 =?us-ascii?Q?sO18QG2QS/oHrvtDt1394U/kl1sIoRj7Gv7Mif0roaY/v5VgIeIqmCNKzLPh?=
 =?us-ascii?Q?tqgIESPezYfj7yY1qRTtFKJTUiO3o/cft+cJrA1HKIVRfustHkCtO4Ps1rxR?=
 =?us-ascii?Q?/5xfGxRKGXFy08VfqgkjsuJW1S0wopBH10cyypH3UJZ6bS8ewmCxTcGRfuCx?=
 =?us-ascii?Q?jZ2RMTnLuIHl0j92Xamr2PSxLbMgvnJTnChZhl8rfAOxFjwfEbEXJdX3t46/?=
 =?us-ascii?Q?w/pJzQ/fmu3kaaWqQ1nOYEwEpYcUKHCvxCPDUfvW2R4ughaD9d4NcHZfk3hn?=
 =?us-ascii?Q?DMh/jCpgxge+7w9PCx8WzK5nDZAI68eBON5qrzSel6JfO+Cnm1e3ohXaVpAY?=
 =?us-ascii?Q?+524d+AtJZ7lRuBXznqY6Op54LUtDtpSCgvPWJgSNI0d/Ghltp3N4nYuyi0H?=
 =?us-ascii?Q?HjhVxlwE255F1COZBHZO17kltTGK9XqqlnIHyARxc+1m0cV8bV4tTnW+t7/K?=
 =?us-ascii?Q?tVDaIbAKvJp/7JG6GtIjuA1+JtDqKyGqNAgrJeZXbXCaV58y5NfURQ9Jhsf8?=
 =?us-ascii?Q?WAoBKEdM0N83TNIA7EvkNHDd7H0Ttd9z9nnxL4BP1G3vYtGCYGttuWw5eoBz?=
 =?us-ascii?Q?PVXOWMnGdtMbaRUlyS3RcqIlYKn4Kf25ETQE4yCsYqVAlHkec4CMP29L+7gB?=
 =?us-ascii?Q?Rt9VrcNVo8uao7eXNahMGTTrCtctjhl9FYSWKqaMg6hdXj7ks7sHiXPrcF/m?=
 =?us-ascii?Q?h0Po8jGDbNv0HzXUca2ZoCGGrls+JjgSvckx7TzJJQSfjzjCQA+z0bEua+XN?=
 =?us-ascii?Q?BmNQLqGebDM9Xq84uRgd+eqhzF3vSBpBR46vu+sHpKH6q6Y8V3NcLknBAlc1?=
 =?us-ascii?Q?1JJVaO49EFTG0y5zKIG+9wYHCcugDLnLhVeBmfMCDIO+4zINpZEmAfC+e8lD?=
 =?us-ascii?Q?xEWsHMhXUTvJb+QFnERZygslwOMpe4riZZWYyUaJkwRpXMxLyNU6S4cnJmW/?=
 =?us-ascii?Q?w6zGh3+QyGSXtDRnoY5J0ceUTE3CvWxoqoATyG6icvTbd1zI+PVajNRfCTrj?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ee2ed4-2b1c-48af-9e52-08dc8c50313f
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 08:58:43.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guveVdUU2vR7j0ET8fyNGPPdTsJ6e+vyTTd+RAXARS1/cqowmTD4o9sFw2pQ1vW8QVjlbzEP4ePCKJ6vA6fCe+otGDlQCMrz7f4t6oJI2Ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Jun 2024 08:58:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/329

Hi Trevor,

On 6/13/24 7:01 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> The Radxa ZERO 3e is an ultra-small, high-performance single board comput=
er
> based on the Rockchip RK3566, with a compact form factor, and rich interf=
aces.
>=20
> 	http://radxa.com/products/zeros/zero3w/
>=20
> tech specs:
> - Rockchip RK3566 (4x Arm Cortex-A55 @ 1.6GHz)
> - Arm Mali-G52-2EE (OpenGL ES 1.1/2.0/3.0/3.1/3.2, Vulkan 1.1, OpenCL 2.0=
)
> - LPDDR4 RAM (1/2/3/8 GB)
> - =C2=B5SD
> - optional onboard eMMC (8/16/32/64 GB)
> - IEEE 802.11 b/g/n/ac/ax(WiFi6), BT5.4 with BLE
> - 1x USB 2.0 Type C OTG, 1x USB 3.0 Type C Host
> - 1x =C2=B5HDMI (1080p @ 60fps)
> - 1x MIPI CSI camera port
> - colour-coded 40-pin GPIO (uart, spi, i2c, pcm/i2s, pwm, gpio)
> - 72mm x 30mm
>=20
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v3 changes:
> - new
> ---
>   README                                          | 1 +
>   conf/machine/include/radxa-zero-3.inc           | 6 ++++++
>   conf/machine/include/rk3566.inc                 | 1 +
>   conf/machine/radxa-zero-3e.conf                 | 7 +------
>   conf/machine/radxa-zero-3w.conf                 | 7 +++++++
>   recipes-bsp/u-boot/u-boot_%.bbappend            | 6 +++---
>   recipes-kernel/linux/linux-torvalds-next_git.bb | 2 +-
>   7 files changed, 20 insertions(+), 10 deletions(-)
>   create mode 100644 conf/machine/include/radxa-zero-3.inc
>   create mode 100644 conf/machine/radxa-zero-3w.conf
>=20
> diff --git a/README b/README
> index a9a040a4308d..909840de2c0d 100644
> --- a/README
> +++ b/README
> @@ -41,6 +41,7 @@ Status of supported boards:
>   		rock-3a
>   		rock-4c-plus
>   		radxa-zero-3e
> +		radxa-zero-3w
>   	builds:
>   		marsboard-rk3066
>   		radxarock
> diff --git a/conf/machine/include/radxa-zero-3.inc b/conf/machine/include=
/radxa-zero-3.inc
> new file mode 100644
> index 000000000000..1cdcaa2214fa
> --- /dev/null
> +++ b/conf/machine/include/radxa-zero-3.inc
> @@ -0,0 +1,6 @@
> +require conf/machine/include/rk3566.inc
> +
> +PREFERRED_PROVIDER_virtual/kernel =3D "linux-torvalds-next"
> +MACHINE_EXTRA_RRECOMMENDS +=3D "kernel-modules"
> +
> +UBOOT_MACHINE =3D "radxa-zero-3-rk3566_defconfig"
> diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk356=
6.inc
> index 586d68806df6..64d47c004a1f 100644
> --- a/conf/machine/include/rk3566.inc
> +++ b/conf/machine/include/rk3566.inc
> @@ -5,6 +5,7 @@ DEFAULTTUNE ?=3D "cortexa55"
>   ROCKCHIP_CLOSED_TPL ?=3D "1"
>  =20
>   require conf/machine/include/soc-family.inc
> +MACHINEOVERRIDES .=3D "${@bb.utils.contains_any('MACHINE', 'radxa-zero-3=
e radxa-zero-3w', ':radxa-zero-3', '', d)}"

No need to pollute the rk3566 with this, I assume you could simply add:

MACHINEOVERRIDES =3D. "radxa-zero-3:"

in conf/machine/include/radxa-zero-3.inc

similarly to what's done in=20
https://git.yoctoproject.org/meta-rockchip/tree/conf/machine/include/rock-p=
i-4.inc
?

Or is this somehow messing up with the MACHINEOVERRIDES order?

Looks good to me otherwise,
Cheers,
Quentin

