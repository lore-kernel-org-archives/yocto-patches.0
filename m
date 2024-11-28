Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7FD690F3
	for <webhook@archiver.kernel.org>; Thu, 28 Nov 2024 10:23:26 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.53])
 by mx.groups.io with SMTP id smtpd.web10.91427.1732789383588213424
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 Nov 2024 02:23:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=kYpHdbg5;
 spf=pass (domain: cherry.de, ip: 40.107.22.53, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4YiCkcS2TwOH7Y3y09fIu0fcqP/at7W1rIh8EzvdilSMBECxMfXY5Lp/f1suxb1mn6YhadRBt4NQGB5BaLbCCAyQpAWAyqlVZF5gTtUDQhXUOcExCX+srElo5RcNBEF78C8QdWV8+LfzTMAq6G9iCh/FuvDTh0om6+yB7LW/Tu+vrUIJX7q9XIlUkPqAOor/G/TT8oSUntOAC9nzJzLrX9/NByVrH+ngxC1x3a7NoFNRy6NoBYFTwttkgFG6PoVsXME8Tr7w6QPMH4kMcjhXP3zMYeCLxuyY23gD5fIZh3W2SYn9ozApwtLCfj8fm3/skpMMpELY3C2tnHWyQ1V/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvz3IUAm+M227QESFZ2CSN4zZCfU0gyb9dJhq+1YrHA=;
 b=HwZXG6/Uoyh4KIRLq7LPZmK3uSA1H3p1FObHpvn4JF6dc3vHymVu0eLMnmw7YCWcJMiyi8N8tW45wKnuXZWb7R9nrlDjBNBn8iisXMWFtegBKTTYmaKOi5mgmJxaI/unuqqXrteUSPTYqa37ss/xvI+KPH/JJyDtYB4UKsz0mWZe6Pms3nsyX85xARxLYDzWf5mCdTf3EXpuARt87X0LCEl+ZIl3IE6Uu/ahe6sU0iWoUNR63cI37abBicLeBxfeaspakmOO+lye2OJF08LA4jEZjz5Rc/GcA2yiKNBEsxCCmX3XXbBeVxwXMYFd6bfJxtpHIBgjuGpCEQUtkKV+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvz3IUAm+M227QESFZ2CSN4zZCfU0gyb9dJhq+1YrHA=;
 b=kYpHdbg5M245x9I5lRC6cfoQlr/Prtqmv4b1CrCH7PSvoG8i4OLpi8kPXbkxbp5XwNUOL7MEnEO9kDIA0g1nRCOoPBJobplIsr1c2xRx3xgZMfxNoaZZjsuFckbk5qKlzKzLSMaYzoRUSna7/p9ZQEwnElwXEWSuXlm4X9PnFkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Thu, 28 Nov
 2024 10:22:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 10:22:56 +0000
Message-ID: <cc7d79bf-e199-4478-a290-c4926b21e27e@cherry.de>
Date: Thu, 28 Nov 2024 11:22:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip PATCH 1/2] bsp: rkbin: rkbin-ddr:
 use glob pattern for finding DDR init
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de>
 <20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de>
 <20241128005526.GA17984@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241128005526.GA17984@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 194ecbac-55d9-4b30-809d-08dd0f96a030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ajBoVmZKdmliSzNkVFhwaElqait2YWptaDRXY1NPUWlIckFaVG9QRFdJNmNa?=
 =?utf-8?B?TEswR2huWm9HTjJSK2p1blRiTkp6YVBhODdOdGpoS3AyU0FGNG8wVFNRcnE4?=
 =?utf-8?B?cUJjNVZjMmRFNmp5UmZ4dG1VbEx4czc0Q0VkU1hkZG1FcXI1OVIvOHI0ZzdJ?=
 =?utf-8?B?cFdMOG02RDNwUmN5ME1vbWltVks3MGI3Rm5JeG90YUhRcWFjRUxOK1BPRW93?=
 =?utf-8?B?eit2em1jT0hxMEJKODRtTUpaR0NCdENLSFJBeDdNSTNHaUVYdjdsQ2Y3eC81?=
 =?utf-8?B?bDFxTUFON1hKVG9XdGo1UGFjak1CL25obUQwSzBidUNPOXlmbXNwdk9pSnZv?=
 =?utf-8?B?SnF3bnJXL1pFaVU2VlJXcnkxVmQvdG94YWZhcXl6b09WZ01xcEtNTjhPSTh2?=
 =?utf-8?B?eVgwc1U0S0tFRWN3d2JScDhzcURyNDQ5VXlaVzBCblZCNEFhZFZJTjhvNy9k?=
 =?utf-8?B?aE14aWdUMTQzNmN2dmRCRldXLythbHJQaUZMNTBVTFAwNVFjSmdUWjlSTVJN?=
 =?utf-8?B?YXhMRWYyUmE3anUxMDBpY2wzLzlqdlVzQjRBWGZZMVZrMGtmMENFOTdWMjAz?=
 =?utf-8?B?SUpVcEdWQ3dDQnhUNlhTT3k0S0FoZ3hhZE5qd01CWDRBS0lLcjFEakxvcFVO?=
 =?utf-8?B?K2U0bjhxcUt1L2pIZEVxTFBoVHhReWxrUmpvOCtxZWVZdDd6dDZPOGhjYkVX?=
 =?utf-8?B?djlYTlNtaE5EZk1LWitWN1VGZlNjT1RGRTVobTJHZmd4QmZCL2hBRFI5eklI?=
 =?utf-8?B?bW02UUovSnp0M0NQQVBReHFLenFWMVpHNU02N2ttTndUdVMvU3A0T05rREJN?=
 =?utf-8?B?WWFiOTg1Q3NnWjBIOEkwL0ZQdjFBZ1ZwYm4xU1N0WnVZWnpsME0wckxqK2Js?=
 =?utf-8?B?T0szSTBlTlJqa3lNUUVabGRSdWxYaHhUQlRYLzUvbFpsc2tUU21wYm05N0lj?=
 =?utf-8?B?aFdJbVEvTmtVbkhlcHUxWkJqUkZWZk43UEZ2MUx6a0tReEpiSk9kU1lMM2tX?=
 =?utf-8?B?ak1wUzkwbmY0M0h1eHdVTXI2TEN5dGlKQk84Z2FOM1U5Tjl1U0FQSjJFWUFH?=
 =?utf-8?B?MHh2VDdmWHpudk1FL2F2OENpdnUyMC9mekZFSFpEYmlKZUlIdFVsUGdmb0w4?=
 =?utf-8?B?dDZud0dqQUZQVCthR2dvYmdjcGVreE1telo2ZW5UeGZ1ZksyVDJWUHd1cGFj?=
 =?utf-8?B?Sld1TU1GSEt3Nkh3K09kWnNFSVE2MEhXV1NDUlBuYndVU2dRNXpobnlQajFp?=
 =?utf-8?B?cWM5K0lrdHZvdGVVK1Q0U1d6c0lvOWpxeGU1VEhSeUU0UVFjakM3anlMWm9P?=
 =?utf-8?B?cFArN2NTVjRlWHF6RzB5bDAzTkp1WG5yWXhVVXNad1ZucjNhazBYN00wZGN1?=
 =?utf-8?B?WW1rWmVwUXBhaWM0K0RHME5FeHpsaEsyMEtSVmpQOEszLy85UkRReWxIbU9J?=
 =?utf-8?B?Y0Q0T2srcUxiSC9aellhOGFpa1lwU0lFZ3JLc3NDdDJyTHFVV1lUZkI4WG1t?=
 =?utf-8?B?ZlUzK1JRVWgzWVpmWXZVQS9NRnl0N0duK0krSUlZMFNtVnhRamg1eTEzYnBR?=
 =?utf-8?B?K0d1TTdzZUt4a2ZJQUJBblNnZ1NsL1ZtQVBTTDZEZHJBdk5pdElmOFBHUjFj?=
 =?utf-8?B?R2RybnFMMXEwbmwxdnhrOGQ5dU4vWjcyUTNYTEZkNmpHNlpWYmQ4QXVzK3lr?=
 =?utf-8?B?SDJqNnMwTmxCUHNKN2l2Y1VNMjNybXFRQmUxRjh5L1JrSGFjeldwcjFoWXdz?=
 =?utf-8?B?WFJLTkNsYmZ4bTkzQjFVajdDdk1TeDA4c3hJQnRRczViSTRoaW9ia1VsaVNr?=
 =?utf-8?Q?B0Ara+mC/BvxcT8wP9MF3mk2yUTjkXN8Xg6Qc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGxsT2pGSmhmYWVrZ0tpUE9XMXpia2c2NHZHc2tLYUxQSndscjBDYXpvYWlE?=
 =?utf-8?B?MlNweCt5bkFQTjBoaVJmbnljeFlQcnBZYmRSNHYwdmtOWnp1dnV5TytHZjFm?=
 =?utf-8?B?SDcyanNsM1JZM0tVT05WU0JIOEZMWHNIWGJMK2UxV3JWcDVHZldoRjJsbUZX?=
 =?utf-8?B?V3h4NWhoekVNNGZMVks0dFAwNE1ldmN3SjI3bTRKMnB2WnNGS21DSTR3bnBs?=
 =?utf-8?B?ejRjcGkwQ1k2NnIwRDJIc2pUZ0szL2dJYWpkcjhENmhWMWVtSSs3bmZSS2Nk?=
 =?utf-8?B?OXFRQzdQOCsrUEVQZlh1SFA2andmMWdwSGJqeE0wQzgzYzlHc1ZCbXhuWXJu?=
 =?utf-8?B?UTFJTEMvZlVuZlRXVUJGWHVNOUR5NzNJVUgxVEhldEVwVUxiOElMVUcrRlFO?=
 =?utf-8?B?T3NuQzE0U3pXMjJzcEphL3FlUk1iaW45WXEzUU9BVi8rOWIzWHVxK3h5cjJ4?=
 =?utf-8?B?KytabkY2SkRxTHFjLzhqTUxtdkNLVEhXNTNsa0VzbC93Z2xIZHJLR1gyVjNk?=
 =?utf-8?B?Tm9GL3pud3JVNDQxWEZQY2UwRWEwYW9EeXEwcEdhRzZQbmk4di9MQlorcWEw?=
 =?utf-8?B?eHdOMEd1dXZ4c2k1Tmh3UkZ4eWJqeGVrOG5tSEU4Skk0elk0b0x2RVN5dWps?=
 =?utf-8?B?cDhzSXNDMDBWaitqMUtQUHFGS2lOL2xmenMyZnVibW9BMkNpL0NYYUNHZy83?=
 =?utf-8?B?d2JZdUlRVFFUNDdNa2FuWlNoQWlSdmVOcHd5K3RiV2E0QndvdnkwWWNBOUc5?=
 =?utf-8?B?d3NVSG44aU9WT08zN2dBRzBHejhUSGlzWDlhSzcxLytSZWFsZmFHZlRZQlRK?=
 =?utf-8?B?NmU0UEpSYUh1V0pxRkYyTTNrcXRMLytUekJQdFJxRDZxLytBZERubnFDVWRX?=
 =?utf-8?B?ZXFMcXE2Zlc3bzNsS055d29pZ1RBc1NPdk0vRVNvelFVbjA4ZUhnOTAzZTZ5?=
 =?utf-8?B?MlBQMnR4THNhSnprTXlLYi9MelVPQ1VpOVlWblUzVXRpZFlEeUxCL2orUUR4?=
 =?utf-8?B?cGZTbTlRS1pMZGMwV1d2eG8zamhRZGZiY0hzVW9YanJ1ajZsalJNcGlKU08y?=
 =?utf-8?B?dlVTcGY1QTdJb1dDZnRVQ2phNXBKdUxFNkFsSjJuQWZ2RWJIVEdJNThxbzVq?=
 =?utf-8?B?WVpaMUp0NFZWMWlMb2d4dlR1SndUaFJ3K3hYeWlGQXRQaGpON1dkdnRDMmtN?=
 =?utf-8?B?WnJxMTRuUFEwSkFKY1BaYnYrTGJNVSs0eWN6ZUdYbG1KWk9OMW5rc1N6V2FY?=
 =?utf-8?B?d3pzM0ozRWtXdGdSSWxmMHhIMXF0a0pIWnB4REJ6SjJ4QS93dGxhQ1gxZzNB?=
 =?utf-8?B?dFVPZ05GUkkrRVRFRXBtZmhyTXJWYmFablBRUHFEdnFkZSsyZ0UrMVpnMGFB?=
 =?utf-8?B?UTgwWDhDb05aZlpNenVpTVA4MHYySFdMY1UwUGljdi8xZ2pmRVZ0SXF2bDVG?=
 =?utf-8?B?L1loRnhsQVcvVkZyU01OQXorUGVzOXpGRmU1d3J0RDJwN21Ld1FSRkxteXJu?=
 =?utf-8?B?dkNidkxnQlpPaUlKaTZZMG5YNmo3L3lIWkh2KzVaR08vYzRwV3QxVU5ZZXNV?=
 =?utf-8?B?K085L3dCbHRsRmszdHY3cDNHYnZKZFo4UHNzTFY3cm1XQm1yc1VQVmpoUTVi?=
 =?utf-8?B?YWN5ZE52ekRUWHNuZGR5V0w0SERheXl1T0N5U0Jia294TXRVRmRCemZVbUYx?=
 =?utf-8?B?Z1ZtazdWb1haZ0ZVVGpIbW85V2VpVnBxb1dOQmZHQ2tRdGZraXJFN3diTkRK?=
 =?utf-8?B?WndOcEI3clJJdFRnbkd4TUlPSVd1cTFJMlZucHhYbGRBRlJuZWo3WGpqZVBx?=
 =?utf-8?B?UEQ3aDMveFMzcGFnbkIyVENmeERKbXV2TXIyNmMzNE5Wb0YyU1hjNVM4M01s?=
 =?utf-8?B?Wjl4dzZ1Y1JTMkZ2dDFXaDdrd29OOVpScGkxUlZKN0lUTXM5anBGUjI1QUlr?=
 =?utf-8?B?c01ZVzBQRlU0RnRva0llT08zSnR1dGxNbDlxSzFiNFR5Si9ycVk0am8wcTBY?=
 =?utf-8?B?dVVCMHRWQk1HK01UbGI4R0JJQXlsOGU5R0JKQmhpOXc1RGt1OFc3ODFnQVFS?=
 =?utf-8?B?bXVRVWtFY0MyT1E2MUdVcmE5WDRnN3ZKazF2TC9TNjU2YVBSOFBpSGdFT1Z6?=
 =?utf-8?B?Q0VUdmZDdXZ1MGRpTUFIVi9SVmJENkpYRG1sTDdGSkdvc21IM1ZscUpPUHhP?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 194ecbac-55d9-4b30-809d-08dd0f96a030
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 10:22:56.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObMDW/mQ7O0p7kSKR5iQgRzEPxUeuwOibDcAAzuN2Jeq335K0X7j65E1RYFlgc8OCnBQpXLdbve1tPm6l99IDpHZ8cdr6kC6z6s+0HvzNzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 Nov 2024 10:23:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/851

Hi Trevor,

On 11/28/24 1:55 AM, Trevor Woerner wrote:
> On Wed 2024-11-27 @ 04:12:58 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> To avoid both having to modify this file every time the
>> rockchip-rbin.inc SRCREV is bumped and also having to override it were
>> a user to have to mix and match versions for different products, let's
>> just use a glob pattern.
>>
>> Note that the glob pattern should only match one path, which is the case
>> right now.
> 
> I'm not overly fond of the glob method. It was only back in June of this
> year that I pushed a patch to move away from globs to using full filenames
> explicitly. The savings seem pretty thin compared to the potential surprise
> factor when, one day, multiple files might be selected.
> 
> Do you feel strongly about switching back to the glob?
> 

I feel strongly against the status quo :)

We can add a check that only one file is matched by the glob pattern if 
necessary and fail otherwise with bbfatal/bberror for example.

If we don't use globs, I need to override the do_deploy:<soc> to replace 
the path if I'm building a different version.

Here's what I needed to do on Scarthgap for example in my own layer:

"""
diff --git a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend 
b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
index 
9d381a6afadf7dd66855f6635b5f1f053eecba15..299bb2ac476bf9d988925cbd983a66158a8bdf4c 
100644
--- a/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
+++ b/meta-bsp/recipes-bsp/rkbin/rockchip-rkbin_git.bbappend
@@ -1,5 +1,12 @@
  FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

+# Remove once the following series is merged and backported:
+# 
https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-0-b90b6c04a88f@cherry.de/
+SRCREV:tiger-haikou = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
+SRCREV:jaguar = "7c35e21a8529b3758d1f051d1a5dc62aae934b2b"
+LIC_FILES_CHKSUM:tiger-haikou = 
"file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
+LIC_FILES_CHKSUM:jaguar = 
"file://LICENSE;md5=11e3673115959bf596feaaa6ea7ce9a5"
+
  # The files are created locally by running:
  #   ./tools/ddrbin_tool tools/ddrbin_param.txt RKBIN
  #
@@ -24,3 +35,14 @@ do_deploy:append:rk3588s() {
          fi
      fi
  }
+
+# Can be removed once the following patch is merged and backported
+# 
https://lore.kernel.org/yocto-patches/20241127-rkbin-bump-v1-1-b90b6c04a88f@cherry.de/
+do_deploy:rk3588s() {
+    # Prebuilt TF-A
+    install -m 644 ${S}/bin/rk35/rk3588_bl31_v*.elf 
${DEPLOYDIR}/bl31-rk3588.elf
+    # Prebuilt OPTEE-OS
+    install -m 644 ${S}/bin/rk35/rk3588_bl32_v*.bin 
${DEPLOYDIR}/tee-rk3588.bin
+    # Prebuilt U-Boot TPL (DDR init)
+    install -m 644 
${S}/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin 
${DEPLOYDIR}/ddr-rk3588.bin
+}
"""

The last part of the diff shouldn't be needed.

If you don't want a glob pattern, we could maybe use a variable to store 
the path to match so that it can be overridden in bbappends?

What do you think?

Cheers,
Quentin

