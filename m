Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF77D0E6D3
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 08:51:07 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.80])
 by mx.groups.io with SMTP id smtpd.web10.41972.1729500660394560306
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 21 Oct 2024 01:51:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=b7BdF+3a;
 spf=pass (domain: cherry.de, ip: 40.107.21.80, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ja+G471Z2OJKpVD3zbz1oyI9pw2/o/HKd8y8XSZi7gD7m8Epsuuq9Cg2+xcppNXmeEAZPvGpe91LFphv1VsYGZyIDjK8Ngpt1B0NlWoABS1y8AtXp7b1jk3UWmMPb9v+qewvqaTPreQpDnMtUxvJlV82D5kz7r9vCNucWkZmV5p//zaJJyfR2vPb6EZvBpcaP0YFG1JvbGQYghe0tHfnIjMtgNGCM5ckr/Ipn+hXXwgONfzu0y5uGK4o3aXU5rV2i4GH57HZKgFAPqgw/Pif8OwpsvXcudphyaG4b2QmXJUdypfzmMgSSekbW9hT38FEU9WW8pbwXTm2PMPeFXrdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzTBboYVYblSgOaNSqsPHC622vWFUr1J6o8lF4XLdt8=;
 b=Its38c3o/kw6XnxTJcD6o6jTey7RDorSwsVZm7BjMmx0RxaVSQHADsuupy9A/Ocb8tR9Iv4L1mNgWkB2e2zm2NJLrGqesr36mODamiOUsjFua52yNeiLSWvd/4HKKd+KLx4HwN4UtMwGMUKCkrbyJ7F9HjcwrvdTLN8dlZJ9P0YVRU1iiz778D+j/+oxgyNGqSW4I07heTcBKwOQWhJquQ82u1r/YTdwbQztB+wUhwd4qRf9yI6M9C/DTZFSIn+Xy4Ni6g1de3sHJE9vmXKgiGdabrFBhCasbHiZ46fwC0+wd4yqiagY5B8ISlUFZaCEgntIYsHHFiLbhLfXA8+seQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzTBboYVYblSgOaNSqsPHC622vWFUr1J6o8lF4XLdt8=;
 b=b7BdF+3ajRYNeJwK1Thr03gSrd8bfxZVQRDUVWy4vu9BIaec/h9zjaV24Xric6lkBsj9bCczarXb3lDr1yoDuAGCyMDYBnVEX24Pcjr4Fyh8Hb974cbFt5fCq2x13cloLpLxhcVIz6tB5Rf9R9R99DtODoj5AfzY/NVOJ+vG4Sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 08:50:56 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8069.020; Mon, 21 Oct 2024
 08:50:56 +0000
Message-ID: <306eb249-2d67-4446-8f48-bc2a95cd1bf7@cherry.de>
Date: Mon, 21 Oct 2024 10:50:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [matchbox-panel-2 1/1] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org
Cc: Dixit Parmar <dixitparmar19@gmail.com>
References: <20241020112000.452050-1-dixitparmar19@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241020112000.452050-1-dixitparmar19@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::6) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dd4236-e6c0-4c9d-0063-08dcf1ad7a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N0QvM3pSN2N4a3g3NEo1OXRLT2FmSjYybHJnVDNZcU9IYkdiU2xNS2pxRWZj?=
 =?utf-8?B?MVJmZnplNDUrSFVEdlpKelFLQXNYL1FwRXJqVUh0aURVa0JxNStIK0VZcFBr?=
 =?utf-8?B?UGxjdlJJTE5scjVVVCthRzRRT2ZhakRwSVhFQ3J1aEdoUjJXclJlV1Z4VXRI?=
 =?utf-8?B?b0IrcWNHNktiQkw1NkR6Yi9pZ1g2R1lBVFhNVGhNMk51TUhocm1xSDF2WG9u?=
 =?utf-8?B?U25vQ2h6cm1qK1c1R1gxRTZka0ZmbE1ydHFCcVBKVTBDRE5hNkpqaSt6Rjcx?=
 =?utf-8?B?NEZ2aEsyQ1cvSkk5T3c3K1JLNXg5dmlvMS9PTmNWd0RMaHZjTi93dlFzMDE1?=
 =?utf-8?B?dUlnSzkzd2MzMmNxWXJyeTBtM3BzSkhkY2h5WXlRUXVmNURFTWxWRUlhSkhT?=
 =?utf-8?B?OGV5UmtNbnVoQnV5NW9sU2hjbHB0RjN2OFNkcnVnZzNCS21PNEltenYycVZw?=
 =?utf-8?B?cHZrQmplZk5PQU94bnRrUm5CTHBDbmZ1TXc5YmkwWnBFMlZGN2hCeEgyb09l?=
 =?utf-8?B?cGduS3BjL20ydmtaTU9YNTZTa2ZMcWkveHNCb21wcGYySWRvY0tpUG15N0lp?=
 =?utf-8?B?TXBNcENKK0tjbXZkbGxKRE1HWS91MVFudnlNQ2hBTUJmVlh4UFM5NHlHa25n?=
 =?utf-8?B?SEpnQkUrK2tsaGdRYXlyZjdreGpLT2NPNUhsNEdhVGxjaXVRczJPYm4wVUhX?=
 =?utf-8?B?YWtOMkIzYlpDWDBVVGFXKzFVcFBoRUpjYktyRGdoQ3hUSGRwd3dCTG5FNFVD?=
 =?utf-8?B?NDV6OGttaHFQd0MzQlFpK0xySFM3d3RCQXFDRGgxcEdxMk5UcHdzb1VSK3I4?=
 =?utf-8?B?dFBzS3ZXRFFWNjJDU2J1Tk85TUJLL0VFS1FVU2RpSi84Mk01ZXJTb1QyM2Ru?=
 =?utf-8?B?VHllUTdaNVNFK09rNjdoT0VjU0dMbzBCRW52MXN5ZGhvc2ZoMkhSU1JYQ2RN?=
 =?utf-8?B?dVhHQWRLVDlNak05aTJENnh1UklsbzExZWl5L2ZKNDJYNVBtenZoVUYyemdK?=
 =?utf-8?B?RWIrdC9aRGI2KzAydjEwSDJmL3FsWmZLN3FVblh6MFRtQmNZOFo4WmliY0NY?=
 =?utf-8?B?MjkwbTVCQXpKdjlMSHk5NWFaUitmdjFzempZNER6NENXYUhXMFhKNVRvVTIx?=
 =?utf-8?B?TjRkNDF4aXNQSjBna2s2TnpFeWJ5Tkd1RnFpRnVSZVJ0bmZMSWVlOFFBV3JD?=
 =?utf-8?B?SXh0cE81Qm9vdllCcVk5NVBFVHZwVkp3UU1rY1RtaXdpQno4MW1hVy9rRDhQ?=
 =?utf-8?B?OGNTVGtwQ3VLMXYyRTNQNkZMV0lQVS9tNmxDQjBaMFQyZ3UxMjBtOGFVUU9P?=
 =?utf-8?B?ZHROVGxqRlc5TWFmOXNaU1FzZjhiUDcvVTgxN0p1MlZWT1JyNElBVTR4WjFN?=
 =?utf-8?B?aUtIdFQvaWY0OVJjN0VkZkRKR2pkd0wrSzdnN0YwTlllNUxzYXBhQVl5RHo1?=
 =?utf-8?B?K0hBUlBoaU9BSXpaV25rVzI2ZG54amRsQnlCNnJQa3RBVEd4UjdkTmc5aklS?=
 =?utf-8?B?bEJHRFZJZzQvMzIyTWpRZ2VnSCtzMkp5VWVITmxremxGbStQNXh4MlZXUEw5?=
 =?utf-8?B?WUs1bWlqaDhTWTVITVNGNTNlMXYyRG1WcFVld1FjMDJrSytXY05lVG1QZ1ZK?=
 =?utf-8?B?WmZDTEM3VmZQTlplMnpJbUdQUHFZL2lHYzAzQVhkQ3Z4YURoVzJZMkwrYWZl?=
 =?utf-8?B?blJXVkNzZ1QxZUdmV2NpZElBREJWS21qMWFKelBjbUFscWd3MkRzc0VWc2Zz?=
 =?utf-8?Q?F4diIxy7y8pTB/Sy3SrcrueX30SE3iV3EqkvA/M?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZjVCMHMxL2NCY3BhQkFtaGVZU3ZySlo4WmoydlA5Mm8ydlNob1hyNWMrbFY0?=
 =?utf-8?B?ZjJxQjVNZ1YzNVF2b2gwN0dFMUJlRlhCSTdFdFEyM3hHWUtITTFzeGszdC8v?=
 =?utf-8?B?RzBod0lKVGVEcEovS2hWc3Biai9ZcVBRMmpOdjkyekZaQTE3ajJZeUl1bS96?=
 =?utf-8?B?aGRBZGVxU1RKeUVnOFFvNndiOFVmSDlLdnVDKysvN1lBRXlZdHJnZkx5ZVRi?=
 =?utf-8?B?bFBnekZleUFFOW0vaWR5MmNSMUhqMjRBNEF2Q2x2NUFvbEdIdDVCd0ZyUjVC?=
 =?utf-8?B?N1EwU0tBNG1NWGdQcEtJTElrci9QMmptQlNGc0V3elZkempFd1lBOFdSWjRN?=
 =?utf-8?B?QklRVzIvbG9TZWMzUmlpQnhTSCswVWtVdXVsSVRuSWdSMEFqK295aTYxc0k4?=
 =?utf-8?B?Zkx3U1JjMWNyVnZKWjl6L2lIdGlMaEZiS0oxSTVLRXBoN21WTEtBWUFlUktD?=
 =?utf-8?B?ZTR0S1NFUXRkYk5nZnpxZjV6SlF5aTJONzQrTFNlMVNwTUJSRTU1ZW9UdEVQ?=
 =?utf-8?B?V09xVGl6NHh6QU0ycm84L3NCVnBkM3hObDNDWkM5WkFtenNuOEVDSEVVSjN1?=
 =?utf-8?B?Yy9BcFF3cW1LbjNrUW4zNkNxdjQvNGRaL2pOYWN5WFpOejQyTVVDQmdId2pj?=
 =?utf-8?B?cHhZNExJSmNYOE9ydDdUM2NobTllZHZjVGZnQ2JxNEd6RCtDcXJCd0gvdTRK?=
 =?utf-8?B?WWMxSGIvejdHR2UzZEZaRy8wSm02VjVxdFo5QmRJRkZ6ejhLclhmdEM0RHph?=
 =?utf-8?B?TmVoamMxbnVhUXhIc3FBMHZxeGRKQU0zVkNsRDM3b2lTZi9Bc2ViNUYxRXhw?=
 =?utf-8?B?a3dQZGhqVXNaS1Z3TFVGSG9YVS9ueWcwOTVCMmZnNG1DYjFWMURjbm16M3VM?=
 =?utf-8?B?NHUybDlzcGlTZVJ1VnV1dFdrWGhNTFgvc3I2MjNMODZyT1pTS3NoMEVEbUpM?=
 =?utf-8?B?VVpRZDFZa1ljeEJybmNoRk9HdjUxcGZCdzhTaVJRazQwaFlpdHBheGpXZ0tl?=
 =?utf-8?B?YXJVTWY0Z2dSeTJTemd3WS9MdzUxYW5lTEZtdGtxQm8yWnVNbjRZNjNrTDg1?=
 =?utf-8?B?dTNrcm5WUnJHSittNEY0YXJRUHU0eVFPOFlFRGNsQjVlRGgwNkR6QkxUNS84?=
 =?utf-8?B?NEdjQ1FLcFRJemtxN2JnYjVtd3I0ZXNxQWpUNm9uQVAvVVZyMmw4SzJWSGV6?=
 =?utf-8?B?c05PM0NKTDhKRFAvR1V6N3FmYkV5NE5OdGZnSUdOK3grNFdHZ3UvYVdnRXh3?=
 =?utf-8?B?S2wwZkh0ZjBGK2dXR2RrTm12OWVrc2tGa2QyVHlzMjl4RzBZNlpiU1J3WjEw?=
 =?utf-8?B?T3pDc1BTMUdSaGI3MFY4Ry81cEVnSzN3T1AxWmdHMDdtbGV5UE9VVmFoUUJN?=
 =?utf-8?B?V0syZWdOdzg5M21lZjVOVnMxWmVOK3pnNDdOMVFvWndZR05iNkFVeUd2aVFL?=
 =?utf-8?B?WkVORHpzVFlQNlozbURIQjM2QVRERE4wZTFydmticjlIbkRWNmNNdW5GYlpN?=
 =?utf-8?B?SVl6dE1la1Y5WFBMb29RUnUrVk5Rc3Frb0hsRTdwN0U5MjFsZnJyKzlNRFZD?=
 =?utf-8?B?YXZBaWJjUHY3aGh1aVlvVUFMWllBQWJ3OUxmVm5Hd2VudGlqYXZBM00zQlVh?=
 =?utf-8?B?TkZaazZPbmVBUFZnbzBCWEV3UlFIR0JsbmUyZEMxU0hHN0lmeSs3S3RzdzdO?=
 =?utf-8?B?WGJEQ1Rmbm9sWWwxMVhDNk83RWlqd2p6ekJNdFl4UTFYNDBpWVc4dXM5eFNU?=
 =?utf-8?B?VUFmcHp6a051Yk9jNnpOMVhNeEJZaGllZXFHaDVWY3N3M3lqbjVPSXBSeGdV?=
 =?utf-8?B?clpiL3FOaE5IN1NNSHZYMHRDNzV6dWZPeHFRZTZRQUlKNjdiTHFNd25Tenhp?=
 =?utf-8?B?bG1EZERpUDVkcTBEUjNDWm5BNXFzaXovN200d3VDN3pPZ0VpeW1nQW91Rjgw?=
 =?utf-8?B?V3lZWXoySDhac3o2UHVPRnZRd2ZMdXZRcEFNZVV5QzJYMFp5UklIOWkyMWhZ?=
 =?utf-8?B?VzRkNXdmcnBmUEpDVGxHNDhuN2JpbHdUUk5iYWJoTjRkYmVWZldXK1FTeXl0?=
 =?utf-8?B?Q0prTm5YTUdpRDNiakZ3RDl1YjB3MmRsdU0yaDFaSTQxZWNkUVByaEoxd0Fq?=
 =?utf-8?B?WnZhdUFjU3lFN2tpWVdwR051Rks3ZGJieG9ocHZHUHNqUjRhbkZ3U3NSeEVz?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dd4236-e6c0-4c9d-0063-08dcf1ad7a1e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 08:50:56.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkyrTkuBD+XZxEII0NZYO9vC1xF3Cem+eLfUvr8Ir4L2y6ZQQ3Xd+tnTDfaZaOX+u8bkZuolm4dtIHCaXKyVQi6k8dKHJiVkS6LQwkAKUpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 21 Oct 2024 08:51:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/723

Hi Dixit,

On 10/20/24 1:20 PM, Dixit Parmar via lists.yoctoproject.org wrote:
> [You don't often get email from dixitparmar19=gmail.com@lists.yoctoproject.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> battery applet supports reading battery and supply
> information from sysfs entries, /sys/class/power_supply/.
> 
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>
> ---
>   applets/battery/Makefile.am     |   4 +
>   applets/battery/battery-sysfs.c | 153 ++++++++++++++++++++++++++++++++
>   applets/battery/battery.h       |   5 +-
>   configure.ac                    |   4 +
>   4 files changed, 165 insertions(+), 1 deletion(-)
>   create mode 100644 applets/battery/battery-sysfs.c
> 
> diff --git a/applets/battery/Makefile.am b/applets/battery/Makefile.am
> index 9b02240..1b93a0b 100644
> --- a/applets/battery/Makefile.am
> +++ b/applets/battery/Makefile.am
> @@ -5,6 +5,10 @@ applet_LTLIBRARIES = libbattery.la
>   libbattery_la_SOURCES = battery.c battery.h
>   libbattery_la_CPPFLAGS = $(AM_CPPFLAGS) -DDATADIR=\"$(pkgdatadir)/battery/\"
> 
> +if HAVE_SYSFS
> +libbattery_la_SOURCES += battery-sysfs.c
> +endif
> +
>   if HAVE_LIBAPM
>   libbattery_la_LIBADD = -lapm
>   libbattery_la_SOURCES += battery-apm.c
> diff --git a/applets/battery/battery-sysfs.c b/applets/battery/battery-sysfs.c
> new file mode 100644
> index 0000000..c3ff45f
> --- /dev/null
> +++ b/applets/battery/battery-sysfs.c
> @@ -0,0 +1,153 @@
> +/*
> + * (C) 2008 Intel.
> + *
> + * Licensed under the GPL v2 or greater.
> + */
> +

 From where is this file imported? Could you add this information to the 
commit message?

This is a bit of an unconventional way to word "GPLv2+".

Cheers,
Quentin

