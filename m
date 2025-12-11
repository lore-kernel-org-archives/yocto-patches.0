Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A5FD41D42
	for <webhook@archiver.kernel.org>; Thu, 11 Dec 2025 14:14:33 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.17])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10154.1765462463305860323
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Dec 2025 06:14:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=YWLhReIq;
 spf=pass (domain: cherry.de, ip: 40.107.162.17, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQJoWqBXraFY7fQFLd1+YiXvdZsb2Em/G7ymS7iZuR5PxgJuu4nl/GcF7hDSkRM+RyZoPWSZRdb/mKNqN9HG5JjXc3dLijLzdUHNl15snWf67Qq77iBiL+c/3y3KT/vZqkEVMgOXe3ccIFX36ZWbHnNWD6lb2X7etGvTFlvj8mDhsywNOukv9rnwDVLlkp2SdcleBZzEZHzbwtXSccL4L7fsnTMc1gPbCloTK2excPHNlXdxmpvJ3KfaRMQSEqnNC6xvtIH2e5veiFUWcl0pkEFLij6yISpLaSFt4xSGNNpv9rQgC6Vu0r/cRbexFFb8F7zNZoeth68+vAoGV6tUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iy+7WcoYxrDYikj0q2sztTuS6rqxOoK1mJO9RHseeI=;
 b=j5Sp5tpw+irXzHkgew4CxYV7o6k+KdezgLrjU8fxZU1HzUrSrcRTHr3jdndrTyD31I0YIyT4d4MHVVc8pE0wsqOGfPINZX70nY0ZCttzZIPrmiri1LXRY+COO0SSKIEKS7EYNY04TEjgOdkGjEw7+qRVIdrv1cdwtTlG/saFlwSiiw/KkJJWPeaUYItcMHEqWNlE6jQYmItjYvBudqs8ktqyM/GRraB4+FIZB9tOGjS6CP0NK8vKMyGzKmp0XU5uKBEz60hktJs8nZhzQ6FPM8VL8SXVEjLvEM6qdlfcGDQoaXpvWxrXHPLgBDLa6O1BmM3MTXeMwJ6maZBy3dapXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iy+7WcoYxrDYikj0q2sztTuS6rqxOoK1mJO9RHseeI=;
 b=YWLhReIqYFbOf8bQGBRG6ak3XCpkphjKdP0yqdpgunXwGdHTZzQQ4+dWcRpWpSGmvQ7SDUsvMIB87cB99A0Wnx7U9N75LO8BGQoCREPzupzdsOpdGSFaGLmVynW/NzBHO3GlVHDVZJ9tL0bwS6vOTVo2AZlkQparAnnvY42tpaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AMBPR04MB11718.eurprd04.prod.outlook.com (2603:10a6:20b:6f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 14:14:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 14:14:19 +0000
Message-ID: <e2a21a1f-050a-49da-b368-73f1c03f9157@cherry.de>
Date: Thu, 11 Dec 2025 15:13:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/2] make rockchip
 kernel tweaks easier to use
To: yocto-patches@lists.yoctoproject.org
References: <20251208193551.2426-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251208193551.2426-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0158.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AMBPR04MB11718:EE_
X-MS-Office365-Filtering-Correlation-Id: 07c759ad-3fe1-4bd7-f396-08de38bf932d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b0pSL2JtZ0xuUXZuSFZRbmsycUgzMHp5OHBzKzF1d1I2TVgvN0cvUU1NY0tC?=
 =?utf-8?B?NHZ2Q29vczVHdURPNjVsdStNN1VkZ21zalRUY0YvRjZKZEswcThaeUtVU1hF?=
 =?utf-8?B?cjRreER4YklDeUdqZVdUa2xRZXBabTkrUjB1OTFTTURSK2xXWE1UYURJNHhx?=
 =?utf-8?B?QUdKVzJVSHBLdnFsT2Q5bDMwSEVnOWhWdVEyektsbXhuNkc4dHIzYm5kMmhE?=
 =?utf-8?B?bEYvVVNmNFI3VjF5NHZDZ2s1b0hrZmh0WGM5Z3lBVVJkT1V1UHhuRXlUc2FH?=
 =?utf-8?B?OHcrU09YV3o5UkozNFh6VElOcG92eVUyMWlObnU4VGlqaEhPUXhML28vdWNl?=
 =?utf-8?B?RW1qaWpRbjdGS083bmd5eFVreGlpZ0g0VGdtVU51VHZFUzF3dHZvemZqYlhx?=
 =?utf-8?B?U0hHRXNZS01jcVJ1Nzk3TCs0Qm56LzluWE40T2NtMFVIMnYrR2pPQW0wbUdP?=
 =?utf-8?B?SXZsR1Q3S2JlMVFjK3Rnbjh4cUhSUVFoMHpBdTFjaE5MMnVSQnp3T0JLOFYz?=
 =?utf-8?B?aXF4SHE0M0JQeUNmaGFpVFJYYTdiUlNCOHRKMFQ0dC9xUmQrMzBQRDVGQlhU?=
 =?utf-8?B?YlI3Qnp4UXQ2cGk0T3FINmQwdUp4QVJ6eG96MmJDbURiSVRZYnNTSi9jS3Bu?=
 =?utf-8?B?c3VmTkMrWW5Ua3VLTlFQeTNQZGE5VkkxamYvUE1UWnA1MmtKVlN2d3h4eWlF?=
 =?utf-8?B?WXJLMlM2bmZ0NkRWRzlFaGkySk5BQWRsZ0dxN1JoRXhEeFYxWEdqR05HdEN1?=
 =?utf-8?B?OE9IbXI0VEdJN0daWUdhYkJsamdzYUxiLzc5Q0F0TlVnWlFXM1BRb3l0TmpF?=
 =?utf-8?B?b2xKVmxDM050d1d6RUNQRmNRL1RkY2pKNENQcm5PRGtpcTJkOVEzOE9kTTcx?=
 =?utf-8?B?S3RHV2VWVVJIdm1qR3FjTnQrVVNSU01hZHdGN2NyejM4aWc3MmR5QVdtcnJE?=
 =?utf-8?B?WmpkT1RpamdBZTZteFoxWG0rakJ0Ry9WblYzYkFiUklybGpQUWxIUGRSTno5?=
 =?utf-8?B?bEVVV3FOdjYxWDQ1cVgvdlhxd2Z3bjgyNHJMK25VL0E4SmZab1RnUEZPZkxB?=
 =?utf-8?B?Qi9LYmZ3WFQ3bnNxNEV1R0ExYjZUdkdkbk8zeXRmMnljOXJpTlM5UWRXRG5X?=
 =?utf-8?B?aWVKdjdZT0N4Um85QStGdWM4L25ueTFtV2hoeEM5U0xIcTJBWUprUjZhblZ2?=
 =?utf-8?B?dUZoRzR1dFRaRXJqY2lHODZ5MzJmMGZBVG5scEY0YmpYMm5CdW5vNWd6SUdX?=
 =?utf-8?B?cy9VVUZ6dGFLSmp1V3AxV2crNGZzcG50STh0enpqc2lZREZ4L1czTEJ3QzA3?=
 =?utf-8?B?L3BxTnpCNGorUjdpRkoyS24yeC9iaDdNTWM0MGoydVUySGVsRVNSTnRsVmVi?=
 =?utf-8?B?ZFFUTXcvTlNnSGFVVk5BUlNJdTZyamFsaUI2TTBnRzg0NHl2Sm43cDdxOWoz?=
 =?utf-8?B?NDkwTlZEZFE3bnljd0IvdlNNSmFKRjd0ZjQxRFVUNWlKd25NUVNUYXQvWTRr?=
 =?utf-8?B?QklTa3QwL3NDVFhIRWgrOEFUSS9yQmlKTnZJVkl0ZjFrN0FFRGpleThiRVNa?=
 =?utf-8?B?NFVnN1htMXYrbldWSkd3TVVhN1ZmY2xid3cxbGQ1WXlmVVU5QUN2a1BTTVBN?=
 =?utf-8?B?T0ErcnhyaTBhaGQ0a3RZZGx4UjdwQzNMQnY1ZFJRVlEwd3FCc3FGaEwxUkVk?=
 =?utf-8?B?VXFsQ1F5NHNpMDFxeFl1TVNucHJnQnprM041dHpzOG03MDdtemxuSys0ZExX?=
 =?utf-8?B?a3p1REhlNiswd0pzMWNLR1o3MHVxWWc2NWVHRmVUNXFzbmhNWDdxUmZjdWNa?=
 =?utf-8?B?UEtUeWp2anZtczg5czZWY1FNemZuaUMycmtCQlRJL0Z1bG05ajEya3pHaWJY?=
 =?utf-8?B?YitaSHJrMlRvOWJpMUt5VGcyZDhmd08yUmlZdDh6TWNjUUU3SVBWZXBndUlx?=
 =?utf-8?Q?OrZoovUV3GGQ3JiFPL94CKMX5ON9yv/O?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlJJTGVDUVUzMnhXRGVhNDZZdXZKZzBQcitDcVg4SkhRTXllRTFtb1Z3ajEx?=
 =?utf-8?B?L0pKdi9WUy9WTFlHL0RmWTdyNXAweFRDWERhM1JBQnRpY3R3Yk5XbzUwQ1dV?=
 =?utf-8?B?Z2owaHV6Y1F4dSt5NGFIR3FkZ0owYWFKazI1NkdETnFuZUZqSHBxaDBsSGgw?=
 =?utf-8?B?REhVWW1WSE1kSk9oa3FTTnpkRUFJV1hYOGVJNXdhTEh2OEE5T2hPeFRNdFdY?=
 =?utf-8?B?TWQ1REJWRm53SDl1RmhxYnZiSEJJSDV6WitIc3hnbDZScGFOUHJwWmk1a3Y3?=
 =?utf-8?B?WHZPS3ZTT2lYRi9MYmZKL0RvQ1kyQytQNmFjZXpBZzRCUXVic2UxVW1LSEpa?=
 =?utf-8?B?R3doZ1hKRGJNTFpJWU9FbHNaamJZN25rNTByZE1xVHBXZjY5dlRRRmlOaTRE?=
 =?utf-8?B?UnNERDVmcXZtZW5xUmUyMW1pdWorWWhZRmljdDg4dVNZSmo2RzROT2loTTJL?=
 =?utf-8?B?NWhOaDdRQWorb1dXeTFoQ1A5ZWd2Uk5vTm1aN2I0ZjRVcytFbXA1MW1UMlQz?=
 =?utf-8?B?aDZsWnpnYzZ6VGpZekxWbUtZLzV6Vm9XSFdndFdUUzVleVMxaUFDSUxEaTl2?=
 =?utf-8?B?UmhrSE1pU0dLN1IxaTJHbWM5QnJvWDVzUE9hUkpsVlB3RS9mVDR3aHJod1RJ?=
 =?utf-8?B?VTlQVXZVZWViaXlrODdaQ2wyajh0akt4Y1BKVkRNR0I1MFBRVlQ2SFg2Y0gr?=
 =?utf-8?B?YVRlSVd4cEE3eENJbUt5ZkhLY0NLNjB0aWU0ZmxBMFp0UXd0Q2VOOTUwVmpY?=
 =?utf-8?B?eHNHTWRSM3NoaDY3QXloSGNDTGVIQ292SEZ5ejdpVVc4dy9DSjg1aCtJOS9P?=
 =?utf-8?B?WVlkZy9WMi80Y2w2VEFNaFNvVVBVNWtVWHMxdm5WWWp1VTFrTGpSMlh3UXlt?=
 =?utf-8?B?WUV5QnBiWWFKd2J0b3liYURvV1l6alZ3TEpYd2pGUk12NU9Md093YkwwdVZx?=
 =?utf-8?B?YlRnaUVBbUpHSmdCKzg2cVBqQ20vcVVBR0lleTlCWWJXZGphb2RNVk9DQWdD?=
 =?utf-8?B?WUQwZEtWbmF0dU9TbDAvMmNvb0VzaCtodWlGMXFWQlVXeE11RENPVmRRMkxu?=
 =?utf-8?B?QU9UY3JuSFJOdUtuOGlNd0lIWDBkbTVObGh1K3JKOWFtQ1pldlZLSzQ3VENr?=
 =?utf-8?B?bWZQeHM4ZVhCWFk5eHVwdS9TQzhXczA4a0tUa1o1dHRHU2dpMG00SjlUbk9Z?=
 =?utf-8?B?R2E1S1VVLzh6aHlsSEpBeFpBbkllWGVNWFVuSmNFeDhzN1dtMzdXYlRRaFkv?=
 =?utf-8?B?R3RRRlNWdG94bUNJa2FkOGhCanBscWh6TEtMSitBUjUvc1h0Q09hSVBjQnFX?=
 =?utf-8?B?ZXd1c0hYemMrcHUyQ2h2T0xseVBSbXhjL1d6QUloa0pQcVE4YnFOcW5maTNK?=
 =?utf-8?B?WFRRUzZweXh3aG5LQVJiUnhSZTBLWUh0bWtuOEhiOTdDMVRPTkdEcFQ4dGsy?=
 =?utf-8?B?NUxFZWhhWm04bllYempwQkpJS0pIaEhXL3B2Wk04KzhyZlU4RmVQVGVSdlBL?=
 =?utf-8?B?dnBna0l3YjhiUE1obys5YXA5U3ByWVhsSHNJNFJ5WENuQ3Q1VmpmVFlHSU9q?=
 =?utf-8?B?VXMrQ0toK3FPUlJteloyRFVRSHo3U2FERzRUWnBobEQ5QjVIOGlUN1hic2tB?=
 =?utf-8?B?eERXT2IzRjUxVzRCOEhxakRTQmVJRmRoYTU2YUN3UEREdUVqcWR2T0tsQ1Vy?=
 =?utf-8?B?VU5xazU3NERMSGVRdWVUT1ArWnRIVFRZVDM1TTEvNVVieWRiRzFqTkNHRFEy?=
 =?utf-8?B?cnkyVkhsZzN0cFRZRGplQkJhcG9ETlo3SXhYWlpwWENQSDN0ZjZPRGNzY2Rq?=
 =?utf-8?B?MTJUYjhyRGhCODZocFd3cy9kZ1NTSmdCQzg0c1dNVVJQU1dSRXd2SnNZcGN2?=
 =?utf-8?B?dHhsQktBbzdocGpydDVVV2RYT1RGQ2ZPaTFFZFluclU0YzhzcUJMVDVmVzQ5?=
 =?utf-8?B?UWh4YXhHVkg5SHpCVGlOUCtNMHNEbFZyNTdTbmJKQXZaeXNzeFpGQjZncVF0?=
 =?utf-8?B?UnQvMjhsLy9VU040RytEMFQ2eEIvUUQ4MUVNK2hDK1k3N0VTRWRuZHRPVUFR?=
 =?utf-8?B?akY5TE5ySHJVaE04bDhLWndmdFNBNHhQRU9mQzhHdlJrSWdFVHJaSWZuTUp1?=
 =?utf-8?B?TmM5UC9TWlFnTVBTZ3lkUksvZHRwdUJ3M3hMZG9Pc1hHQmtQT2YzWTdSV3d2?=
 =?utf-8?Q?4F29EzqW1y43/7QEwRmDbF8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c759ad-3fe1-4bd7-f396-08de38bf932d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 14:14:19.3274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLF9mMTaeb5bBbq6SmGEYlitFTFD1izDsG5L5cZ//2R7tJfmiGncI7aH/TcOXXHJCfLffJO1X1cbO6QVeutrGkS5hyGJouv/NKJlI9BBkgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11718
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Dec 2025 14:14:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2765

Hi Trevor,

On 12/8/25 8:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> If the machines defined in this layer are used, they will want to pull
> in the kmeta data that is also provided in this layer when configuring
> the Linux kernel. This all works automatically if linux-yocto or
> linux-yocto-dev are used. But it causes build failures if a kernel
> recipe is used or defined that is not one of these two.
> 

The issue is that we have machine configuration files settting the 
KERNEL_FEATURES variable in a conf file instead of having it in the 
kernel recipe.

kernel-yocto.bbclass is the one reading the variable and expecting to 
find an associated file defining what to do based on that variable.

So, by setting KERNEL_FEATURES in the machine conf file but only adding 
the necessary files to linux-yocto and linux-yocto-dev, any other recipe 
which inherits kernel-yocto.bbclass will fail to find the file 
associated with KERNEL_FEATURES (as the former is missing, currently 
only added in local bbappens and the latter is set from a conf file so 
always set essentially).

> Putting this layer-specific metadata into an *.inc file (then
> referencing it in the kernel bbappends provided in this layer) makes
> that metadata available to any other kernel recipe through the "require"
> or "include" mechanism. Any other kernel recipe that is created can pull
> in this metadata using either of these lines in the kernel recipe:
> 
> 	require recipes-kernel/linux/linux-rockchip.inc
> 	include recipes-kernel/linux/linux-rockchip.inc
> 

That's an okay work-around but why not move KERNEL_FEATURES into the 
recipe/bbappend so we don't break by default recipes which inherits 
kernel-yocto? You can still have this into a .inc file so it's easier to 
include for other kernel-yocto-inheriting recipes.

See meta-arm, oe-core with linux-yocto. I don't understand why we have 
KERNEL_FEATURES:append:pn-linux-yocto and 
KERNEL_FEATURES:append:pn-linux-yocto-rt in 
meta/conf/machine/include/qemu.inc though. I'm assuming we can move that 
to linux-yocto and linux-yocto-rt recipes.

Cheers,
Quentin

