Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B279FCF884A
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 12:15:15 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32918.1763640910831681791
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 20 Nov 2025 04:15:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=LpjT4jM5;
 spf=pass (domain: cherry.de, ip: 52.101.83.11, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy1W3WOgnJQ4It4c+tChGfoRHYfUCFvYdrzrfiCzRO+Mq6HuawdmmDX8sN21YtMCY5EIRbUiEqTEVgXijehUElIqdgZuVOp6lVSBOCDEl3I5cnoKhmg1m6Z/TPkp/Rmr6sfSmB4diVj4rHHd9q+UhfPPJxBDhLHIZYHgvhkDSS0VXPb5Ponz9zcntg/iV4QMQl0D5XGBDTKaKEUE+/P+WOE0eo/0m1aFoCxehxmAArjMdJkYEbOSvAp72PIcBR50eRXtRgl+aIdIVF4pRcj3qZHAEV7FUovHiOKq7Imgyv6AJGAyBN8nhLaJ+zUZe3zG1IQ3s5byrvd+g/1qTlplYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvrAFiLdk6JF6nRs8QVTYnFX7pWRZ+CJDNTGRmoufS4=;
 b=cJFDJfNIO8pEMsmvVegqI6gdEHxWl8c2V8KBF+GbvuAzoT8SomPEh4hdeelMBiY53GbcG/sRKHo9xCrW5SArz2p+/joBgeMGgx+XSfjYTmeLx8aZECpcje8FL9glFDenwxppfj050TnEdCWZpRQGtlj6Pw/hXEbzzODISvHqBz+6OvTCM2LddN63nIwiYadVcpUOPouvY9MDxOgy9djujdtXhuo9Nb9dD/93cQN/BP/h/a1myI9c55R+zWiI4iT180pPDJwHodSYkhDtpwAFBHAnImei0L9dhffMHqlq/EZ+UmN2iRzZnQYuLranU1xyACX0cDscW2Ahs2cUlWouvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvrAFiLdk6JF6nRs8QVTYnFX7pWRZ+CJDNTGRmoufS4=;
 b=LpjT4jM5gkJaJivFllRR2bZVRZ0iHZFtWUwXQH265dzWYSnQcYXd+vwRGSkPR9CrEl1PWocrcTY3Rg5Cnc6S+/ls4uG13SPmMjlVMFfEC4/026AnjeTaXWl+IFmtrHtJvTcPiJMRJp8IWLdGj6IyHPiSRaf5jj2fP/w++4n1vxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10481.eurprd04.prod.outlook.com (2603:10a6:10:561::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 12:15:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 12:15:05 +0000
Message-ID: <6f12c78f-15f7-4987-8cdf-905d66e43e44@cherry.de>
Date: Thu, 20 Nov 2025 13:15:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip v2] orangepi-3b: add
To: yocto-patches@lists.yoctoproject.org
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>
References: <20251120-orangepi-3b-v2-1-48df6c49609c@rootcommit.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251120-orangepi-3b-v2-1-48df6c49609c@rootcommit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10481:EE_
X-MS-Office365-Filtering-Correlation-Id: 23cd565c-7041-4fad-b57c-08de282e705c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lztIx66EBsuyahfr2L8+1gArEzqCJbf1Rb2hY+yd+RlF8BE/UpPdNOHadOtP?=
 =?us-ascii?Q?9NFQusmQr6hy91oe9kh0zVjEquxomZFvM7wl+xons6Kvs87giEjVkEjZ9v92?=
 =?us-ascii?Q?h/5NV1LG4isHuGI1UvsWyK0MPqRNRQGTKL6y1SYA+RExqRbC5mgt+Ph5LceX?=
 =?us-ascii?Q?0iE6e3fn8S2D89jVwprfODHgyIwENNtIIsxC3EQnaWO2p5ZmGS47r6egOr0X?=
 =?us-ascii?Q?QvuhkNVDTxVTk4qhvSiidOQtvcI43y8wa1h73EihUleGq7B4a3qdPS7zkDyv?=
 =?us-ascii?Q?ATYqzYh+zz9zW0ADAjjNex1bp0z9Pss0IIyLn+9TCw3tCq0Pt2cRxzS5nYrZ?=
 =?us-ascii?Q?4GM1xhluBt1vwsVLD4VrE6Jv+qHjHORbV1xbX3giMIP3VnYRo0+TAALl7pIk?=
 =?us-ascii?Q?s7pkmwNrctTU6CStAwA/UXudjw6J7IHFBTBy4l9gXz+dK4F6X9cK7hhJEzOS?=
 =?us-ascii?Q?zn8ALNsfgzM8aJZ8QiTuva9WPwt9VFWu+VK0dZZBRxTgHtOZSwnLtZ0Woxr+?=
 =?us-ascii?Q?Kf3GQ8emBrBixYRFRr+pOyOY379qiGqkb2ahX3vjDif+bYbCXCoNDP44AoAM?=
 =?us-ascii?Q?wBMu7dwms9pxA3/IvyN9+nSfNDQp8C+FkHj6UNgdi/w/fD7vcHRxu6GZigtq?=
 =?us-ascii?Q?rBC2Yw0dJ259dZ9FyvqT75wS9HF/pzsHfS54JRPy8M/wFOMd3zsJVig4an3R?=
 =?us-ascii?Q?uDX4+om00aIysPazjbxARd8jvFh2NU/fiItfuBL/luLIu2APwCeGg49kX7hg?=
 =?us-ascii?Q?F3ui69Hr3RJIbrQvLfFWC3CSAy6d4HpeF2zGbFaWeM/YeWLIdxLJet5TNuCI?=
 =?us-ascii?Q?umk7Daclu+YNdDlXNk0VkAESMk+7Khe7kMFXjGrc02er0DjSCFBU0iWDd4sp?=
 =?us-ascii?Q?+Wih+JlENEee3pe8smIXIHEVku12UvJgQJcY9RdM4wUyupT22GPKotbJLac7?=
 =?us-ascii?Q?ttSngo++Q6VCULu1g+8dq2XpZb0fWRpDNaYd10EEBxpnx5OvOR4Q9crJMA+o?=
 =?us-ascii?Q?ovnPRsylJJQRGjLwmH1lAvJHC9wBYOt2VCcZ0tImIEc8E8hrIcxlIvcPjCPU?=
 =?us-ascii?Q?swEi2ptN1apWBM+AfKJQzJK8+GmCkeylgg0JWUcCvWa0BFeeYTimePoemPTE?=
 =?us-ascii?Q?jj6ZOKl4GFj2hv+c8cLObNj44173+lCJDaKISqvvh7XsmM9FJEdEn2L+/1od?=
 =?us-ascii?Q?oluWZaIY6U2pDZUHdbEoZiDGMicp/gMXE51tbA4TVz/MdBRETqUefK+rflI4?=
 =?us-ascii?Q?VuJRzIn7oDf5LrHDp9o5YMgv/yaPG8L0QZPxmxwDB2VBOTU+3btyj3eEc3B4?=
 =?us-ascii?Q?ggdrxT53GhHbpQj5nEaeQpTuc06aJzq5VbhM2K+V3kSDgA801dykhtUedWt7?=
 =?us-ascii?Q?oWs2VFmsFZR2nGEHDzv2jSJJi+T5WMgjODxHBbaPPS12fbTxuA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wUusS1vBV6v1NGAEGMM/i6LOpIerC3R0oeWjD2ShKg1ROEy5KB09RLgNy/fy?=
 =?us-ascii?Q?A1pPasQ6SlfPiqa/L4oi+b9/+N0cOqqnrdrJSDOAnSJIrkCMP7LcORKYqaUh?=
 =?us-ascii?Q?bTRtI2u2SzmC2R7QVzTYDXAJqz87Vmh8/M2KLvz5UCm7R2nXHowLvZI0+4Kc?=
 =?us-ascii?Q?/qjjOQ3ClbpBf7EH6191h1LJ/ZsqQWHiie3Lhqb3zIjNzATtCPiirOefJtRQ?=
 =?us-ascii?Q?HtPlKmYzEoDh1fleiS0UYAp5JKnowhsGS4XBbV9zTXp0Z4+tWlwh+9iMIWXI?=
 =?us-ascii?Q?zfl30pC+5cNoXLVVcyWwAbbLnvBRd3LzdA3rcSMwph8Pw3wxV770BblU80BK?=
 =?us-ascii?Q?1f7/rEFNvpi7aPnbSC7LyZAGyRgVTTvYtl/kq/fi8ncq4Boi87bLpM0cx1yh?=
 =?us-ascii?Q?AVumXLmo7QaI8oqWj7pR6S5QDRs/MeTnu+i5UY4OHzseEpCsXkfNtX10KlaD?=
 =?us-ascii?Q?aRDYxUsycAOYxQN8QskiHJ7v2HS5RgB4tIj6phOO9uwxjhT9akasNRol+UnP?=
 =?us-ascii?Q?RXMKEA8k7rURQaRZ5zb66vOJJMDw1qtcrAa/9AQr6glsJ4YtwMJkl/zrVj5Q?=
 =?us-ascii?Q?ZvZaRxhzvHIw5w8Oz9GUpf6qiQ502e5LAH/LSqhLzdAsLptaoNBXKynSMCV1?=
 =?us-ascii?Q?Fef7UeTe+yYhD+LTuTmn7plvziROsksTCA/caACklpKKNilB3g54ItHThGNx?=
 =?us-ascii?Q?T9JtSuDVNoasRMYhONMeaFR2wQsBW53DNA003XGO1ViD9elaroFuzzxncuFY?=
 =?us-ascii?Q?HzREqZnVk99z9wfpahUwFVBXgaIvgwhPKmO4tEU/eev3QHtL8sUZJ9K+9G8T?=
 =?us-ascii?Q?Wb0H6XkZPt4D9+PeCp3GsyFxnPKOwWQQ4erdI/7oIqMd/ZHoWYOPNmEDE2uK?=
 =?us-ascii?Q?QOWO+rF9WkdhO7/3XSIHX2PeZgeD8NynXnO1+GAgh38DDnSpmceF+XRwNzRs?=
 =?us-ascii?Q?RphX7j+Hx9p+DFDds8p33z+0s8opTErBZQ3vpjwbhmyeN9xzRoswm21U63/B?=
 =?us-ascii?Q?Ck1Hjd1+lLKmLpwhEjVrWDxbNSK+HFlCWQ+HairzFFTiUputNTj5nMYUuIS3?=
 =?us-ascii?Q?dQZJwFsAnDWuZEa7RDNxC7NcWVQzO/c0RswGHt35LZ+Q72QqVhruEqHoRXs1?=
 =?us-ascii?Q?FwMlwtLz2g1RMGjAwVEVJ2C6TTZ/rAK5ddJRn9YooSxvi/+l2MXVNWLlbp6t?=
 =?us-ascii?Q?LPjJaPtZDAFH73bYr0KiBD40zSOdtUDo7ogpFmF4ubLhdUWtIKET8HluZPAr?=
 =?us-ascii?Q?A8uXYwqRHq5qc1979KpMVa3juOspc7DRmjyz1JbegDzRYQnYNmdzPcL1SQfR?=
 =?us-ascii?Q?S3JYzEAhQkBqLmv2yK9HIfq4IdVdhZjYV+543/MrP9Kwbyy0sDqOIrHBQ0zl?=
 =?us-ascii?Q?33AmhBq1HwP365cnqs/xredvgaw8+Vp5QflRn8hiDDJ4Rgn80z74bbnEW8Ig?=
 =?us-ascii?Q?Zht8NshOOlQl6TUU53E84RVP8yjpVCrMIkZIhZWViDJBsPPCLvgXpm740COm?=
 =?us-ascii?Q?6hj0BcmyKszXsBl3jCEEMJo9gp+S00vZkn20eSyg6lwFvRGT0Wp/DvsHTAAA?=
 =?us-ascii?Q?ySR3nldBwo0STG4F/2iCB27mwwixtPaH8HPABJDCyGF/umMMNanM0jW6jXiC?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cd565c-7041-4fad-b57c-08de282e705c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 12:15:05.6422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KePsCtgqwfOBcjK0U3kqI3UrXnKNwOsnGtPWxMeg9Wvf6akSfggGi0HdSHgiE77tPyxLQo+ZsMr932CfrvLdo0zQRGKN34sX0b2OaL/eGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10481
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 20 Nov 2025 12:15:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2629

Hi Michael,

On 11/20/25 1:11 PM, Michael Opdenacker via lists.yoctoproject.org wrote:
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
>      - 1x MIPI DSI LCD port
>      - 1x MIPI CSI camera port
>      - colour-coded 40-pin GPIO (uart, spi, i2c, pwm, gpio)
>      - Gigabit Ethernet port
>      - optional M.2 M-KEY PCIe port
>      - 89 x 56 mm
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

