Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41699D3398A
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 14:10:31 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.84])
 by mx.groups.io with SMTP id smtpd.web10.52764.1730124620851477630
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 28 Oct 2024 07:10:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=APUu/1P8;
 spf=pass (domain: cherry.de, ip: 40.107.249.84, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOjJHbUqfXbsH7LgQAJ15IjDz9iEB00P69/iu13kza0fa5daS5OgzKwDHotkW0sHWq+ZVTNGIsXeRHlODGHShIoU/N37eUcjDxOrCk5DlOO6893Pdv2cNc1mCYPxuk6FK78HX7ZbtzaHgy1N53/jbCgV6mxo+b4Gs97rWVr6VHA1Ydgha+102Je9Lq0hOyfWZ9ebT5+407VFKzmXV2fDcv4TzA9pDeMfrsaL7lgb0JcbocdZM9TOOsNvKleOsVvq6oxR28GLBnT06s5aTW+NZXhTXSpIrOpjMSSKUqNUERtG6XitaT+9nubfH62g1Ts9vS3pYebwVQy/tfy0rMs+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9Cdir2k9bC5479YpSYKYrODzeKJaEkoZHeqYP5DXG8=;
 b=QWSyCE9wBgJrHBmKJWjGd/4Uu8xjTTTkAd7jp7URJdQ0Kh+N4Ng6NA+vYIJ9gwNyiMw5kANsP9UD/k7OgJyT/eyjrgCETJk0+hxa+TKEe4FVOJcMIrm1UBABzndcRP38sJchiGzPXxtfc72reBIwz8xEktP0LK5jKnyew0dzqR9vJXxnADbCmijMB9m6Mi3KYpAPIUpfE55FmnK6NdUrpydy6s7sleD5w476up/AFhlh7yl4l7xqHQ9DRAYTgigXO7IlgI/7sxD5r4JOc/k0bzdIGcPiPEaPnd757x9FXgTbU6W3XBAcyfYxmtjlIzqJl/VJBNruolN1L3JsUyHclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9Cdir2k9bC5479YpSYKYrODzeKJaEkoZHeqYP5DXG8=;
 b=APUu/1P8wtxMke1dD+jl3kL/wPoVY02LZmULPWmveNYeXQENU8Lkxb9kxXEPETEFIavGyFrho8/2u3zjWAuCnyMETjx5C5OmOP1OyhwdY0238/vgLio8hXcKADzUg23h114II3e7JpIFPqdUAdQvorCTLSNMl9V/Rpiu8ar2S60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:10:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 14:10:17 +0000
Message-ID: <dde73304-b9df-4a7e-9b01-75dfe97df72f@cherry.de>
Date: Mon, 28 Oct 2024 15:10:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH 0/3] bsp: rkbin: split rkbin into separate
 recipes for DDR init, TF-A and OP-TEE OS
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240927-rkbin-split-recipes-v1-0-0f4a9b0cbf56@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 8314d24d-ee95-4922-e532-08dcf75a3ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TXoxajlMaG15OEN2SHQ3YjhTYUdWclNWb2VTbEEyYVpXUHBUc3lkVDhYYWpj?=
 =?utf-8?B?Z0xZblJnaXoyVmRpU1dnMzNub2JjSDc1TFdXZzlsc01vVGFHMjJLK3E4NWJi?=
 =?utf-8?B?eGVHWWFJU3VPVnozclZoZVFPWitsN25iWjVxM0tYRTR0WFRPN1picXRvMEx0?=
 =?utf-8?B?T3cvUUgyNmcvNzQzOXd6L1I3Z1BpbHF4Q3ZwNWM3ZVd6YjcyY1ZZek4rU2lP?=
 =?utf-8?B?YUdQOGJqT3Q1VGN2c0hoaXBaQURvOHYvbGsvZVVjdVFTUXJZSUNpYVNQU0ho?=
 =?utf-8?B?UnpYLzNuUzNmV0lLK2tsU3RRMmp2aldyWExKaGVnT3Eyc2gwMW5QVU04empS?=
 =?utf-8?B?aEtvV0t2dmRSQ1E2VnpCL1hOQXdVeTA1WUdlYVFBd0NDREZWdENPYTU3TVlr?=
 =?utf-8?B?SFNqTmhqdlFaVExPcWlMRVdvc3FKMEtYY1YwdCtBVVJadGFjRkhaZEx4aU1t?=
 =?utf-8?B?b0tKS3hEM0l1bWhZV2tBcUlYOEcyazRWSTk5UytvSG1pQ3ByU2paejcvenUy?=
 =?utf-8?B?Sm93M2tjOWhYWVd2ankyWUh5RWkzTGN4ODJkUEZSWXJMckVuWEw1NmRSRm5Z?=
 =?utf-8?B?WUpGY2lSR0gxRENEbm5Jb3h0RFZLck94Q2tTRUg2Q2ZsQzc5ZklGQnpVNjdi?=
 =?utf-8?B?eVliTXBPRm0wbnJORnYzdlU2ck9ERzhjMzJBanZkMWQ3K2V1K2Z3WWtWZldz?=
 =?utf-8?B?RWdJRlVBRWZYU1ZFMU5PTUtaR3ZEbzdpRFBmZzNsNngzTHRReWlLNGN1b250?=
 =?utf-8?B?ODhhdlVkOGxwczV4a0lETmNoOVFlOExtSzd3WERBckc0YVVHd2dSd1M2YVNG?=
 =?utf-8?B?aXRxRDNxaHhHQ0Z3cTFrZzVGVmFhMkFlSWtCaFRiVmFsRHB4dHllMVJBMW5R?=
 =?utf-8?B?c3JwT1hXbm00Y0tmQmJXQXcxSDFJVVpOeHNRSnJMdWdWRjZPeXg2c0RlUmxF?=
 =?utf-8?B?dWw1c3hML0E2RWRqdGVEeGtBUk1FcXZGTTFtNWhCbzI2d2V6enhjajJPT0pj?=
 =?utf-8?B?dkxVbTVMVHZZR1d3a1dRL3lwaklubkNLWUdtbHlvb2lQODVvVkRSbnpyRDNq?=
 =?utf-8?B?bFM3bUwrd3VaZ2hEUzU3VUF1Z0E5UVlkVlZmdlFzNFUwZk93b1lTQTNEUE9q?=
 =?utf-8?B?T1ErT1AxbFhjTFpwWkRBemlZQVZGdjRXVjllNGgwL1BENzc4aVM2dExmSDFR?=
 =?utf-8?B?ejVqbE1zUUlsMENpRHk5dUdML1RMWEJhaDZ3Z1pUOHJoTUZtUi83Y1ptYmkz?=
 =?utf-8?B?SjJVaEU4WDAxR0VVUXk3VWlxUnNvcERjQS9KMnlMZ1pQVU1zMVNsSzhXYy9j?=
 =?utf-8?B?a2hNRmM5ckJ0NzJsWW83d0dJODlZWWQ4SUZrdzBHZnhFNlNpdTVZMEdIQ2hN?=
 =?utf-8?B?RVZTWkpWYldTMzhCZnRWOTZ4UlFFc2w0c1BUZFpXanVwc3JGcVQ2blRkMFAw?=
 =?utf-8?B?UFRRN1Y2U0FHb1p1dGx4QjRBMXEyWllPT3NrYTZnVm9ZVnVrKzVVWkl6YkdW?=
 =?utf-8?B?ZUFsdXljUnhLRnNsczZLUkNrNGVLb0RHMEY3aEd1U0hDQytKYUF4MHU3V3Vo?=
 =?utf-8?B?NUpsZVpZRzkvNmhsNGhXSE9HRDRqMWpXekx1dFR4MlJQU1U0V1VpMHBpYXlW?=
 =?utf-8?B?aU16bklzMkdKMjZyWUp5ZGhNZ0YybllJR2R4aDN1SFlEano1SW96eUdGbnow?=
 =?utf-8?B?djVXU1d1blVkMXpkVDR5TktuNWE5QUtRS3BRN0xmZHJnNTdmVnNLT3Vhbmt1?=
 =?utf-8?Q?WySOXaG+6mqOva/0SLH3udTadtPscOfC4uPpcw0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?alpyQjdla0dKY0pTdm1IYS9mOVhJczk3WGxMZ2orYTZpTktXOGo1T3Q1SUY0?=
 =?utf-8?B?elM1by9IYWhCQlBXTE96Yld5Q1J3bzgvT2VXaXVMQmJmcFpsOUtIbUgyQWhW?=
 =?utf-8?B?aFZLd1NpdjVKQVZMa2RWN0xqcHBUR2loVzBveUMwYno0aG9WNXdldWh6WEdP?=
 =?utf-8?B?cEFkZVJ6VzdlcXF1azltek5jb1VROVFZeFc2cU85MEliOXlaUzBoQ2N5ZE9H?=
 =?utf-8?B?VlE0d3kzeXBwNkgrRzJ3TVNVVFBDaU41RVZuTDFDK0RjWVN2TWUva1NUMjY3?=
 =?utf-8?B?VVZaS1p5ZHdnMW90SGxPdTY2T2xyLzBpNDBROGd5SDdpNEhNWmlQN1BORnNG?=
 =?utf-8?B?OE52ekNjUkkwSGZYbVNmMng5T3hlSk83Y0dVZ0taRFJydkZXeDJ0UEZhamlh?=
 =?utf-8?B?d3Bid1pyL0JkbGNybFVVejhtbS9GTGJ4VE0rUVpWaFRKU2MwS3RqUTk2RFFu?=
 =?utf-8?B?NEFzc1g1ajdmRGRVK01iT3kwMTdRWllOVnFtejNQc0JONUora1FqR2o1ZXpt?=
 =?utf-8?B?ak9QTjJsM0dkTlQwTVlWSFNCbGU4RzlWQm1GZXVjd1hIKzMrMEFkYjR3TTFt?=
 =?utf-8?B?d09VRlB4Q1o1WGRuQWYyaUlhWjhzNkVFM1JjZ1lmTklzTkpZK2I5SlNUazJX?=
 =?utf-8?B?d3Z3MUhEaTdKY2NNSUFEVVJBeXFzaG5CQXBJd3AzcWgySTd5ajMzeUI2bEVD?=
 =?utf-8?B?S2ptR1lvQkRzd1B1djJqN3BqK0xyQTkvM1lzZXJsTUlZTDlwbzM5Tjc2TDUv?=
 =?utf-8?B?UjhzZ2IxOGd0T2dSeCtMLzJ5OFpkU2F4MlljVTJwUkhBTXRkM1JzRjZTZ0Fx?=
 =?utf-8?B?cWpwckhxa25TaGlQcUN6dVltVWl1L3RxUWJpWVBQMmY2MGdmQXpiWjA1cDdq?=
 =?utf-8?B?SC9LV1ZCV3RvbTM5UVUyTHdneWJ3WW1CNStRenQ3QXFLVUJ3aGx4Q2MzUFl5?=
 =?utf-8?B?alpDdHpzNTM4bXh5ZG9zYzNlY2hHUHpwUHg1UVFuTk5DRmlMUWNVSlA1UlRC?=
 =?utf-8?B?cGZYQ0E4WVU5Mm5yOUJYNHhMYXQvZHVGZGtyRDFLK3habVY3N3hMbWlyS2Rh?=
 =?utf-8?B?WVhNeVhQa3B5bFJmeUlTYXNyK1pFRndnZHBoaWo2YkJDYnJhOElsNDRaV00z?=
 =?utf-8?B?dGt4cEU0U3JJKzRjNGRmdkhocGJCaThmMDYyazdESGplU0lEZjIyanoyZmRn?=
 =?utf-8?B?ZlVqNWFTZFZsNmdOaTV5RzQyR05yeWVOWG9KK29vNzZaT2pzNGpaQzRGYnMw?=
 =?utf-8?B?aGxmN0ltcmcxbXlaREJXOW5UcGRnc0Y5TDRsbGJ4YWxwZzB4REVyVTB6OG5D?=
 =?utf-8?B?cnUvbEVxWkwwV25wY2dpdlNTbUV4V1M4WVJ3d2pZczhlbGt5L1NxWmhwSnd4?=
 =?utf-8?B?MXhXc2tMa0RrV1dXb29Zb0dJdXFybnlWOTZTMTlHWm1UdWpEdDZyM0F5RXJF?=
 =?utf-8?B?dk1Dd2w1M2pqUk4xY3NvSVljdGIwd2d4Vm5TU1BIUUtYUHZYQmExMGxUV2Fn?=
 =?utf-8?B?bWxxMTR2eTRITXAyU29Nc1FZYkUzOHBSV21oQWtTVFpRTGI3dTRlbGhMM0pZ?=
 =?utf-8?B?SGsycjRSZTNXRTdyNEFZZjNwUmxRVFJDMythWVFCYXRtUStnMWtLbGdpa2Ix?=
 =?utf-8?B?ZkJCL09PckYxbldqdlRIWkoyTXltdU9WY2tra01nd2MrQ3BUOXNwbWRTY3VD?=
 =?utf-8?B?MmVWeTVHNjZ4YksvOGpJeEhIUWxFclJHWEJzTFJCOFFjOElFcE5jZ2pvUGtO?=
 =?utf-8?B?d2Z6dVJ3TGFSNXA0SjJ3NnlzdFlnK0lyR3huajdIbWNLdzY5RDh1UWtwa3pH?=
 =?utf-8?B?YTM4VmRZTWhkVkloandJSHI0VS9SeXNTNEJ3RU4xVS9EUnBxTmo1bmNEcUZR?=
 =?utf-8?B?Wkh1VkR6dklhNjFHQnpqTGNkZDhSR0Y3bUhDbmROV2VFcG9DMXdYOTZzZUtL?=
 =?utf-8?B?QTJOL2R0K2FUNXIzaEdBSlE5MmEzYnJaemxxOWxUWEVIQldQQWZSSFNwWHFP?=
 =?utf-8?B?aXNJY3VoYjhPd0I5OWxpbERJY3cwUzdGQ3VGSk9VbDc2ekRQZHpwY25ZcTFG?=
 =?utf-8?B?Rk4rUFkxcWdLaGRVTFlvL1ZLWm1sSUI5NFovazJDaW1LZmdjUVF4WCt2cDZx?=
 =?utf-8?B?Ly9WR1JLa3BKSW1aYUJRRkJkTzJDNHhEa2duUFNjbCtmdGhUWEJWQmppU1dx?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8314d24d-ee95-4922-e532-08dcf75a3ffc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:10:17.3634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpCDye/NW9jZlOFDyoq/b7nufOq1ERrJ60v62eIWCJKJmy/TQGfrP43HcMR/OUaU6+LW1nykKTFPIi5sN+oa3zgXFxZlr7Y+87GK9t4RVOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 28 Oct 2024 14:10:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/765

Hi Trevor,

Gentle ping to make sure this does get forgotten :)

Anything I can do to make the review easier for you?

Cheers,
Quentin

On 9/27/24 2:36 PM, Quentin Schulz wrote:
> This is in preparation for being able to use upstream TF-A while still
> having DDR init and OP-TEE OS come from rkbin.
> 
> This is necessary because the do_deploy task applies on the recipe level
> and not package level, so if we have two recipes deploying the same file
> (e.g. rkbin and trusted-firmware-a for bl31.elf), the order in which
> those recipes' do_deploy task will be run will decide which binary will
> be used. This is terrible, so instead the binaries provided by rkbin are
> split into multiple recipes so that only what we're interested in will
> be deployed.
> 
> Note that the rk3308 rkbin recipe wasn't changed but I assume we could
> migrate it to this new "layout" too, I just don't have a board to test I
> didn't make mistakes.
> 
> This was tested on master (styhead) branch from yesterday, plus
> https://lore.kernel.org/yocto-meta-arm/20240927-tf-a-master-v1-1-733c925c80e4@cherry.de/T/#u
> for meta-arm on an RK3588 Jaguar board, plus some patches that will be
> sent as a separate patch series since it depends on the patch from
> meta-arm to be usable.
> 
> Nothing else was build tested, but since RK356x is now supported in
> upstream TF-A too, I added support for it as well.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Quentin Schulz (3):
>        bsp: rkbin: add .inc for factoring out reusable pieces
>        bsp: rkbin: split optee-os, tf-a and ddr init from rkbin into separate recipes
>        bsp: rkbin: do not add default DEPENDS dependencies
> 
>   conf/machine/include/rk3308.inc                  |  4 +-
>   conf/machine/include/rk3566.inc                  |  4 +-
>   conf/machine/include/rk3568.inc                  |  4 +-
>   conf/machine/include/rk3588s.inc                 |  4 +-
>   recipes-bsp/rkbin/rk3308-rkbin_git.bb            |  4 +-
>   recipes-bsp/rkbin/rockchip-rkbin-ddr_git.bb      | 23 ++++++++
>   recipes-bsp/rkbin/rockchip-rkbin-optee-os_git.bb | 27 +++++++++
>   recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb     | 27 +++++++++
>   recipes-bsp/rkbin/rockchip-rkbin.inc             | 32 +++++++++++
>   recipes-bsp/rkbin/rockchip-rkbin_git.bb          | 73 ------------------------
>   recipes-bsp/u-boot/u-boot-rockchip.inc           |  2 +-
>   11 files changed, 122 insertions(+), 82 deletions(-)
> ---
> base-commit: 24a411a17f389650c4cea38bef1f9279117fab8e
> change-id: 20240927-rkbin-split-recipes-61503f078ab6
> 
> Best regards,


