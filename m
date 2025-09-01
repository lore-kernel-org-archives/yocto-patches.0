Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C59CA0FFD
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 11:49:39 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.0])
 by mx.groups.io with SMTP id smtpd.web10.49303.1756727369791745058
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 01 Sep 2025 04:49:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=BYllGU1o;
 spf=pass (domain: cherry.de, ip: 52.101.83.0, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ES4owJRl5fKtNrQD2TMZJ5Hw2ykpcH+KS0B7elUROn/9OBPtuRf6lPAOrl6CWHFzFYm6xfso0vg7RCEWADyxIXkbmz1iXAtNpRr0xEtl8kbxKBzE367RdBBJPItvGHRlqeNpicj/pxBsi5AoMDfCVkJCKQfe/ZmkV83jTPAkuGUiK1k7B7b5flQbUAY7tnvkBf3cCPpWg4i5TMoB6uFBJzu2JsM/+xuSsWqrHwtO/hzFsQ1BUk6eB5Owy5aTHUa6fPTFe9jLl/8FGJYUUvDM21IWB801YXF8bXvZN0DuQpc8f6JHOrJ+O8EoSvaGNNuEiqd13ILHaM65QkJqqvtrYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgTSBBkWSMqAT9qkI+N6VwHMIByo/W+o4lqtKOEzFo8=;
 b=LSvkYPDnXOzxX78cKy3uspMEJYAzvW+S4452dJ15yuT3ITrrgwXh+psJCdo8mpLQEdB8GcaJR7JHU8r5FyuZNBREUEAZQnlr/KXbrqYLK8PzAiG8HsNsRVl1VLlyI7PYfoZKUyTWbhh4QCWp53ic14REId4HiUIWeTE7QQXcRbQdo74J4XtoG95UCmpKLbDzjI3tTee1kHOkL1xmYCGCYbWDYji14Y+GZ48/swBGfu645gFjV+BwljwCZjdrZt5rdfkvOT6G7zoh70D3OLtvjN/kYN+t1OZ3Heq0HraoytT+hFs1IKdo6A8MK0/xcoK2AHKKa++6NXq3mliVRy4fHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgTSBBkWSMqAT9qkI+N6VwHMIByo/W+o4lqtKOEzFo8=;
 b=BYllGU1o+QmAGkb9zpez2ys1g9rQ8E6+4IVn53VIvc9ZeObkTASC/3+6upHCyU1MipUk+tokZ/mzSE7Axx0hR2Fl3EFSdXB34odPpXAIP+FOlWrV51s3YAGp+Hq62aUC70gUvIh4hJRMFlCOV/gk8UIvBmMguXlxERelpoMIdik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6868.eurprd04.prod.outlook.com (2603:10a6:208:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Mon, 1 Sep
 2025 11:49:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 11:49:25 +0000
Message-ID: <46735879-98bb-482c-b3d4-7e1532cfa271@cherry.de>
Date: Mon, 1 Sep 2025 13:49:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 4/4] nanopc-t6: use non
 -dev kernel
To: yocto-patches@lists.yoctoproject.org
References: <20250831114105.27494-1-twoerner@gmail.com>
 <20250831114105.27494-4-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250831114105.27494-4-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d40ad18-5634-486d-c36d-08dde94d9985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?clpmcHJVdVFvaHppejIyUjJzMnVRdndOcjYrajg3Wi9TdXlwZjJLWnROZy9k?=
 =?utf-8?B?VDYxWnNuMnpMME1mUW1BaTlBbGtGTlFYRTYyY1NFVzA1Lzl3SjZ2clBSWitp?=
 =?utf-8?B?Y09YbllyVVpuMldpWU5ENitsMVdOMFdPVkJBUmMzeGZTdUZIQ29aYWZKMnpx?=
 =?utf-8?B?WmZWS2pSOG85Yjc2Z1hqai9McEVJN21VMTluV2Vic0NpYndlMkpHc2orU1l1?=
 =?utf-8?B?T1pXUm5seVd4UW01S09peDdOa2NLeExIcG5HVlZjSFgrZnpuUHYyUGc5bXNn?=
 =?utf-8?B?S0ZlZzRXV3R6K3Q3NENhczRzby9NclVBeVN3Q2x1bFJ6WXhjczk4cC9mTE91?=
 =?utf-8?B?L0g4Qzk0YWVWeFhIOStiZHZsaXJvMDdySnB3V2VLWWlST3BhSGhwcUVCZHhy?=
 =?utf-8?B?WEp5RVdTZnVMYXJqUktqTVM0T0V6VTNqVjljNklONnI4MWg2MVRJQ08rVFI5?=
 =?utf-8?B?QVdxQktJeVpYdEREeWdBeXVxc3lPYW1uSmVReXphQm5oNFJvdlZWejE5WmN0?=
 =?utf-8?B?ZFhtdTBPZ01abnJCOVlKUUhaSzZLYWJsR1pRbEFzSUZuWm1qbjNUS0lVVS8w?=
 =?utf-8?B?NlB0cEswUll0MWxWREUrVTk1blpMSmJHMXF2elFZaklEeHh3OVVxZkorS2V6?=
 =?utf-8?B?RWJjeDhmdStnQVMzRmNzSTZuSHorOVNzdHpLUCtkREFyb2ZxK2dRV1Q4Rk51?=
 =?utf-8?B?ci9JNUVpS1lzb01vWFAwczdXOElNNGpHV0h3OTQwRXM2NmZEQ2pROU1ISDFT?=
 =?utf-8?B?NjF3SFJxaVQzRjc5MVF4clJZV0kzOVVib3JLL2VzZlVMZVdkeFo1YU9XZkp1?=
 =?utf-8?B?bHJ4TDNsWEVtMFZkTWtJOFBlTmw5V2N3RVpHbmdxN2I5S0ExcSs2dTNLZXN6?=
 =?utf-8?B?UUZoSjFSRlZ0dVBvZWoxdlZ3WkVHTE9taUx1RGpGMW9VSVQzZHpZNkFwUkVT?=
 =?utf-8?B?bHQyVHZXMTNaQUpla1I0MjU5ODlvTFVFL09lRUM1cEdNSDJ6TTVIMzJUWTUx?=
 =?utf-8?B?REFWQzd0L1VJNkdkQUMvbXVkbXNFanJIdTV6NW1IZ0hZVDNudDY2Z3B3M1Fu?=
 =?utf-8?B?ZHRQbndSMWthNm5qUEJZQ3BqYVFLUXVaWldGdGFNUlR1WlIzZnUzeE8yNmpF?=
 =?utf-8?B?dXdiMGE5a3hneUJRbkM2aTlnb3hmUVpaWlhOUUdSb1dCTjV0UCtsbG5JcjNj?=
 =?utf-8?B?V3Y4aGFGK0VaYXZDYzN3WURTcW5HN1lQVG95a0oxWW1tczIveXRSMGQxNDhj?=
 =?utf-8?B?NS84UnVKeHFrOGxMMm1aWEZML2lNT0FVMG9UTzRCUUZsTHdKOVk1dFBoOVlX?=
 =?utf-8?B?QlkxK0NmalR3U2ZMRnRQS0plVm1zQ0xRTnlFVXlTVTVWL29xeXNoOEdUeXE3?=
 =?utf-8?B?NlRMVVA0RSs4OWV4UGxucnFkWkJSUm1qZ21ZQnU4VFRpdFYrZk1laFVvTUxP?=
 =?utf-8?B?ZHFjTzBjdXVCektvTFg2dGFUTHBVZ3ozaFlBWW1hcU53RlZ5OWE2SW02WnF5?=
 =?utf-8?B?WUN5dUF3UlVMbmg2Rk94bXgxSEgwdlIxNmYvWlAybGhjcTRXb1I1dHMvSXl5?=
 =?utf-8?B?cEJPa3dIZlJGZERlOExKSEZuZ21FZFpxaFRZU1BXeVF6eklXc3FUSkhaQi9Q?=
 =?utf-8?B?MzhWMXJZakRvd2I2ajVMSWwwSllRMjR6YTRxeFdnNWpMWlUwb1QyVDNvZXdh?=
 =?utf-8?B?OGtTQjZzNEVTRWNmOGYzYXg1bFAyMmtQTWorcE0yeTRqclRWMFF0TlI0OGQr?=
 =?utf-8?B?cGVQd3A4RDJnRWFWZ2J3QWxSdEM0bUFOQzhuL3VvcDI3K3gyN3hMZzRENzk2?=
 =?utf-8?B?VjBkVDgrcWdmRG0vOWRyQ3dPVVpBUmdOV1BDczg4WUF1UnBJaUhTRndWZ3pj?=
 =?utf-8?B?MHhFR3QvWHVxVXlRRmVYRWJJa1duV1diUEg4NXVhYXlkM2c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGJnM0VtZFVnMnprdUZINXZxa0NJbHJ3NC9wMXQwelZxUG0zR0FNdE9OdlRI?=
 =?utf-8?B?UFhTZ1N5dWU5YW5wbW51WHhqUi9QaUM1Qmt3NlF3RTV3cStJd3FNekdFMm5L?=
 =?utf-8?B?dFZvZUlhczcyaGt0VG5HT09LTVd3VjZabnFmN2dhRUZ4cXB0MWJ3S0dMM25N?=
 =?utf-8?B?T3E1U1NBRjl1ZFVVMTlSMStDTnR4V0VUbldycUs1VzZlUFpUSFdYQTlKcnhl?=
 =?utf-8?B?RTNBdlRvbFZzbFdCc3pNMzlMdDV4ajI1RDdMZ3VuV2h1UlVLTGtObVlXUjFw?=
 =?utf-8?B?UkpTWkdJVXI0eTh2ZkdPQ25jWWtEb3F4TjZubTh0ZGw3M3l2eGRUajZFbzB6?=
 =?utf-8?B?bkQyVnlUaUUvUDlhMDVmbzlQZVRCa21nMTBGc3orN1Y1MDczWVlBL1pBY0Zk?=
 =?utf-8?B?bEhHREhkMmM1ZytPWVF5SHdCa0grcWhMUGxRZktlL0J4LzJLWU1IVmppNDdG?=
 =?utf-8?B?RGZqRTYzQUxLcHRmY3ZIMVFtNTZOalluTmpTS0IwZGgyZWhOMWF4Z2pmYno0?=
 =?utf-8?B?Q3ExdlVsODRVWWZaanJrZU9RektkK09NN3dXcVYvaHRkL09hYmYyd2dsRTYy?=
 =?utf-8?B?ZmNWTEZFQUhWRkw3UVlhUnhpMUY2TkFBTlRyVmx5ZUluZElLUkh5U2tNTFZ3?=
 =?utf-8?B?Ri9iWnRsVkFhK0k5K240YnFUVUJCNzZsNTczUEluZnVSUHVMd3V1b0lEbzll?=
 =?utf-8?B?bHE1S3BWVUNjb1ByNEsrWHNzV0NaZEJSYVZFVDYxL2ptS090QzYydXR6RHYv?=
 =?utf-8?B?eVY2aEt5VVBwWEZpcysrT2pIOXdwVXJQWXdYV2tHczNiSGZ5OWlxSTdTNmh1?=
 =?utf-8?B?S0N6ZnljenBTQ1ZWa015amIvYW1VQmpqYmhkTHIzY1kvemJyZ2R2TnVDb2dQ?=
 =?utf-8?B?V0hNeWNrL010dTMvYWQ0SVB5S0xucmE3U0d6NTh2NkJ4RytxQXpIeC9INCtT?=
 =?utf-8?B?a0ZiZmpSL1JHYzJHQUZCMyt3SmFuV3diRFNkdy9aRENmTVpKQ3hHcE1wTlFO?=
 =?utf-8?B?eTI4NGlGVWdZK2w4OTRGbWM0a0VCc3NvN3dkUmpGM1JtK25NeENkWG14aDRG?=
 =?utf-8?B?V1F4Tm1VWi9VSFJBOXRkNm9uM1JiWjZ1Y3BFNHRQTCsyWHBBWDVNMlRaYzVK?=
 =?utf-8?B?ZUpQYk40Y3R2V0J2dCtxYStKWi9XV3Iyd0k0bTc5VEgySE5aVTR5Z0RNOVlj?=
 =?utf-8?B?T3FkblpHVERKWDFBenlmcDhpSHM2dGxpT2w4SURrM2loOFBDQW4xVnFzYUhr?=
 =?utf-8?B?V0duS3F6aHBhektYMUR1NlNzSTlBQmhmdmxLaFg0ZUxhZFRhMUg4UGRVbnQ0?=
 =?utf-8?B?ME9CcFFYT214UG5qVlhPZ0J5VGhqQUtpeHZJcHk0bFR6VHlCdXNKZTMvRnFr?=
 =?utf-8?B?OTNxcVI2RnR3RkpDSVBpK1hIT0ZQTlRPamhoQ3RLZVdHNzVRT0d3d2UzaEUw?=
 =?utf-8?B?ZFhCejUyTllDR1RzUjRkVGI5N09TWmpKUDJjZlluTDY4UGQ2ajBnWWlaZFkw?=
 =?utf-8?B?NnByWVRaa1ZqU0UvZWQxN01UeGxUZHFlcHc4cG5xUTNSN2VqdzdnYzM1VjJz?=
 =?utf-8?B?Z3V0azlhL05BWVl4ZDhhc3JYcGl2aE1nREhCVWcxdFlPbXdvQlRoMkZ0dWJL?=
 =?utf-8?B?VzVTZVI4Y0hlbDNwYTN1UkRISW1peG04Q0NRM3dWa0dsTjBldEpZL3ZiOUN0?=
 =?utf-8?B?MEptWXFDZzlFS0V3aHdKbHk0azZmcmhDVS9IKzFaWEFmNXY0SEFvU2lyRDBB?=
 =?utf-8?B?dnRrWW41U1dOOW1aTytKN0t3aDEwODI2QmdLRWdxT0hjdStJNVBaT3R5c080?=
 =?utf-8?B?cXFVVGEwQzhjWDdpSFFWMFI1c2h0aEkzYTNwWHhmbXAwRGVHYkFobTYyTVB3?=
 =?utf-8?B?WFI4TldTZjVCMjhhQmhydURITWhUTHNYN29GZHNpOXBGNXEvb211VEYyUnRS?=
 =?utf-8?B?VkJtcVZ3dTZFRWJXeHBtcU04SkF1bWtUeng4VVFMYllpa21YMXlJUXdrckwr?=
 =?utf-8?B?TFdzcWFEcXpCeFRTSUlBQVNudFBrSjhSNnJxMXNiTEpoa2dNcTkxSWpkZmFY?=
 =?utf-8?B?MHpSdjhlT0hqa0JuTFJJdEVSeGFralF2V3ZjVVlyTStaZkh0M0xlamVFNHJO?=
 =?utf-8?B?aSt2ZFI5MXJLNGtTUnhwVlQ0aTZzendUNU1lQ3VsSWlyRUJpYi9LWWRrdXpM?=
 =?utf-8?B?Q1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d40ad18-5634-486d-c36d-08dde94d9985
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:49:25.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vjwyi2qh8V7dpymYu18/sR6lLVYwDUiwdAcXQdXGkqzhcMnnyRbyq+ivlvlooEY80kRIyJL5QPAvdd1OCUDKP7j/q4pldCYt/KpgFXPitKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6868
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 01 Sep 2025 11:49:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2101

Hi Trevor,

On 8/31/25 1:41 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Now that 6.16.y is the preferred version of the linux-yocto kernel, the
> nanopc-t6 machine that had been using the linux-yocto-dev kernel can be
> switched to using the linux-yocto kernel instead.
> 
> NOTE: keep the various pieces of linux-yocto-dev infrastructure in place
>        so it can be used more easily again should it be needed
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   conf/machine/nanopc-t6.conf                   | 1 -
>   recipes-kernel/linux/linux-yocto-dev.bbappend | 4 +---
>   recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
>   3 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/conf/machine/nanopc-t6.conf b/conf/machine/nanopc-t6.conf
> index 5ed413d1c0e5..8d524bd764f6 100644
> --- a/conf/machine/nanopc-t6.conf
> +++ b/conf/machine/nanopc-t6.conf
> @@ -5,7 +5,6 @@
>   
>   require conf/machine/include/rk3588.inc
>   
> -PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
>   KERNEL_DEVICETREE = " \
>       rockchip/rk3588-nanopc-t6.dtb \
>       rockchip/rk3588-nanopc-t6-lts.dtb \
> diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> index 6f4981fe29e6..e06c8a4f717d 100644
> --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> @@ -1,5 +1,3 @@
>   FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
>   
> -COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
> -
> -SRC_URI:append:nanopc-t6 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
> +SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"

Shouldn't we have SRC_URI:append:rockchip here instead to avoid adding 
it when building non-Rockchip boards while having meta-rockchip layer 
included in bblayers.conf?

Same remark for the existing SRC_URI:append in linux-yocto_%.bbappend.

Otherwise looks ok to me!

Cheers,
Quentin

