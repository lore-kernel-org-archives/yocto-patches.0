Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EEBCA100C
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 12:33:38 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.web10.76240.1756816413680996646
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 02 Sep 2025 05:33:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=b4BiFPy8;
 spf=pass (domain: cherry.de, ip: 40.107.162.41, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0RBLAYI++pAKeqJt/4CEhA5QwkKo/QGIZ07jDuVbYKadlUyrbfZ4u7EjXmVv8EQDsNar1cVZ5/SfVIbR4T4/aqhCXl6C4a6s3PDOfamTOy+od8nnKNmBJMml/m22Uv6nyVunLvtEVh1fhBZQ8IgI1wy18z9jDmedmuJgZAEtrNHIqrgrQ6Fl+q7P2avig3qcyBOHKQhOJRlxiKHtUZ9ildh4hBqLBSTm3sYNXj/ssxgBbTX9E7JENYDw6eCtpFupwtBOaKwC0kgjhOxkbpJ81CjBp+w0YcqfB0ymL7qYdcrH1tn3/Gh/5tzyikfKCQ5OLxvm1JWTq/r3JJ7jm5dJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZC9/IzdeVmGA4I4+OqYIn5TrwvZmIseUDJ+C9XO/GCo=;
 b=AYUQVHFtnxGdKE90fnK0rZaQT0cWUdzb5bNm3vANVvg4LdCw8mrrnEgDXcQ8jdjow2h5FfP2egol/FQNsQxe+BW22TwmxBX9YATWX2/1Xez4KexcYqurkEXwi69R3OOzbmLVsoY4D9PRfB7SqljaGJy/3IKcgAmtRx8yJivsczMb8M7MbWlviqiO4KdlKvct0gZb/qolb3NGV96OmdxAG1gJ52MzJ6g+946OtvFExgkZg6+Q1XS+NeBRpzgU9GPTJnPTwsFOwY/tPV02JFCVTtBpCIcRBj7PHzWzWdN0674hVLxdaWG3n5adz/2ZWZjrTj+bPuod6V/kw8maCd56HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC9/IzdeVmGA4I4+OqYIn5TrwvZmIseUDJ+C9XO/GCo=;
 b=b4BiFPy8ct5cJZLEP5hUIZ05UxOckbXTLks8qUPlSuCP+r+Na9+U+G20tgrP5uYtBJrVpW5uMZbA3Yuz6ch6AvQa4AJTn4chT3EB0WDXTIF0OVCWhdzGnsYAy/RVsMhBMuC3eNn6rQtO5BqZCe3Y9mFE/oG5OGO2Wo/BPjALV+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 12:33:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 12:33:29 +0000
Message-ID: <e61f6965-cd4a-4a4f-9ad4-ce10802e5562@cherry.de>
Date: Tue, 2 Sep 2025 14:33:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 4/4] nanopc-t6: use non
 -dev kernel
To: yocto-patches@lists.yoctoproject.org
References: <20250831114105.27494-1-twoerner@gmail.com>
 <20250831114105.27494-4-twoerner@gmail.com>
 <46735879-98bb-482c-b3d4-7e1532cfa271@cherry.de>
 <20250902122046.GA35430@localhost>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250902122046.GA35430@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0186.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 177d3852-6c82-4442-ce71-08ddea1cead8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?blR0MXVuOXRZUzh4OW8vYVFFQ3N4WVpJZzVOWVg4N1QzbmU2WDZFRlpHS1NH?=
 =?utf-8?B?WG82Vk8zRjFYOENEVzJTUnRsTXprVVRjdHJBVkhjZ3FpSm5odmZHOU9jNThu?=
 =?utf-8?B?RTVnbnVYd0NFZGIzbHZIVW5lZ3RCY3c1aWFFaWY3ckIzRU03L0JFSHJ6UitG?=
 =?utf-8?B?Rm5tUzIzT2FpNW5GdzFWMk95aXVvRHFRWEJGeEl5NGVVQXZIS0JuVlI3enRQ?=
 =?utf-8?B?UXBwV3ozdytnLzNrZDFSdEJWZ0czYzJCRWFoMk1SUlQvYU8vMGh3MTBoK2NC?=
 =?utf-8?B?a0REYlRIK2FENnVUMzl3R3lUZVZKVkhVYkdtNFBVZmxsVkpMWVBVMVBEOWJ4?=
 =?utf-8?B?NHBidVJBc2Mra0w5MVNPeThnL2tyblBiWnVIeUdqS2tSUkZaYkFLVnhNSkNk?=
 =?utf-8?B?bHB0NEJWaFJ4N3FaUjNvT0V6bi9FYUhvbGN0eWdGb0pzSlZ6RUdpNTdXSWdO?=
 =?utf-8?B?OEZ3QVpyNDJObjExYVlaNXdOTEV5QWRScE1OYk8xTVF1Z09wVVk1bU95YnBx?=
 =?utf-8?B?UE5hdytRQmlSZTBZTjRra2ZCdGpLdWU0L0xLRDhQQkZMVkJOZEJhTzZBcUNN?=
 =?utf-8?B?M0xPcjdMMkpLc21nNEJVb1BMQmErUitkd2RGZHdOVmlJZ2tKMmdxWDhYTHlx?=
 =?utf-8?B?KytYdXF2L3FQWnNxaDU5ZnRLWUhGbldqU096eEs0RFpjcyt3OFVwMFpldm1V?=
 =?utf-8?B?bXozRHczQit5amx1cno4bHUwQ0Y1bjNjMUdWOGR1c2ZmdVBVOEo5NW9HcjEz?=
 =?utf-8?B?eVNuRnplbkt1OVUxWnlHWnFjc0h6TFFZUzU3Y0JTNVdMcmdUc2h4MDZBUStq?=
 =?utf-8?B?V3Z4aWtaL3N3WE11K2V6d1lZVzFUeXVsWThMREdGd1FWUnI0VlluanRhNGg5?=
 =?utf-8?B?dDN5eDR6bldKZXJvNGpLM0ttTUpiM2MvK3pvanZvb2plcG9IV09JRU5GVFlm?=
 =?utf-8?B?WXNFcS9kZWsxUEhqMVRHWXFFMHpYenVMMmYxMm9ocVZnUStUWEVyU0lkUW9X?=
 =?utf-8?B?NVRzRG1KMisxOUNSV1VwUHkxM0pHcnVXMjhuOVgrTWJMbDN3cUo3Wld1NkZ3?=
 =?utf-8?B?TnBCV3h2YmNYRWExVm9oUjNiN1d0TDkxenQzQ0g3c1RabXphZ1NvWm94dlZJ?=
 =?utf-8?B?QmFod2d6eXZGS0JBNkVFbkhZTi9CZlcvSHJzVmJkaWhYVUIwTlk3S1RDdmto?=
 =?utf-8?B?bVlGbm5SL0Z1VXJkTlEzL0VjamRxM2NHR2lBYXBkbkJZbm40bWJYQzQ4aWdN?=
 =?utf-8?B?ZTllODVacW94cWdMY0dWUHRYSnFjZ1ZvYm92Y004eU1TK2hXenNGNTV5S0c5?=
 =?utf-8?B?L1ArVzd2bnZYTHlPUUZreHVSU1FVWGVMZGQ5RkpWNDZBekJYUkhoZmZYL1Ru?=
 =?utf-8?B?OEovcFJlczZsSzNwMDBTRmZLcTc1OU5WMlkzNWJMNnUrdVo3TW1kUVRuN2Q5?=
 =?utf-8?B?dWFpUUhHR25STjRRZEs5VVNmWERSQjRXc0s4emtMei80NTRLWjJTV01WTkZh?=
 =?utf-8?B?SHJ5NHdRM3Z5RXRBWVIzTkNxTTU2SGRZa2lVdzB6M0lJNGJYY3BheStXWlUv?=
 =?utf-8?B?NmU1NkptWUNnQjJjOXdwWXgwTFFER1BwczRQMHNvT1hhdWZXOXRrVFJkZk5X?=
 =?utf-8?B?NitFNDNhbS93THlhK3FDTldnYzB6V0N5M3QzUzlZUjUvcWcvRUxGZ2tHbEMv?=
 =?utf-8?B?RnhYY2hYVGpTQ3ZIUnprVWlqSkdXbVFFYk5XZUx3elRVb1JVWjAyaEovdGI2?=
 =?utf-8?B?WTVRNkNjT1lmQUdhZGJ3OXJSYUxSSlcybUg0WTJYWDl3N25uTUtxekpJUVUv?=
 =?utf-8?B?cFBYRTkvRHFGT1A0QlFlbnVjNGRSSmtWaHZmSnVXamQ0TE5QUUI4ak9hQzZO?=
 =?utf-8?B?Y1doWVNMUzhETEY0d0VXc1ZUM21LdHRBSkFudVpLc1FZOHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RS96MEtHOHNsWXFxOUkreFNwU1U4ZlQwUlJvZE4vUWQyZldtRTJuZVBZODNm?=
 =?utf-8?B?VW9aSHQwNTN1dmhzcEVZZFEwSXdXQk5xdmlaNUZkcGlWM0JidHZQWm1QM1Bu?=
 =?utf-8?B?YUtDNmhYVVVzUms2QStEZFgwUituaDRCSHVjckI5b3NVaXhHNURoSXdVTnRF?=
 =?utf-8?B?cWhhVkx0NnlURmJBWWRtSU13bnBaQm5IemtVMkRFODV2UW9jc0M0UTFaYnRR?=
 =?utf-8?B?SFVTODZFVTRtdHFPVXNNcTluazRiZisvc01STTJPZlB4VWtkUVcxZWFaTFY5?=
 =?utf-8?B?emhKWExoR2RiQUYwbzZIUE9tcEJWMG5YUUtjM05Ga3EydUVIV0lRaHhPb2Jh?=
 =?utf-8?B?c1RveFQ0TlNrTldlM1VqRWxYTEI1Z1l0VEVXRjNUMFFIcEUzQU9JOVhRbEpB?=
 =?utf-8?B?TkxQWXkvazdHUmdqVG01Y2JDU2ErSjVUZlNJMWJjYnJNWDB0cmpjMTczV1N3?=
 =?utf-8?B?M3VadldxZjJJWWpoM3BoKy9JaFBjV3NPdUFyby9XZnlYUXQzVC90Vm1tRnUx?=
 =?utf-8?B?dHJNQ2VJdGI1SWt6U2VEeGRaRUUvSUc2dmU2aFhqRFVlZlhPUDNmNFlaT1pL?=
 =?utf-8?B?SUViTjFWcG5MWFQxcHQ4QSsxT09EN3BVN2hNRjh5VC8zTTREQ1k3ZDBmbGVB?=
 =?utf-8?B?T1NOSWd2akdHdjJISElzcmtzcWhsU0V0a0NXME4xM1VBejlURlFUbkxIdVlS?=
 =?utf-8?B?eWhjdkVpQmRGQ3BXZ0dYLzhDN2N0aHlPMk1pb2gvMVgxR1MzUStSeERZQ1Ax?=
 =?utf-8?B?bW1vNk4vME5QKy9GVU9ZRUVVcUtyMkJ1SUhoTndLR0swSjBqSkJ6U0pVTWNP?=
 =?utf-8?B?emV5a3lXaXV5cUhFSGVqalpjaUdxRjdkTVhVbi9xVW1OWXFDcDRwSkNMNEJH?=
 =?utf-8?B?ZTNvQzJFVm9meWhUMXRQQ3pmWGRSVzdENk9MSGJ5eDVqdzFxTm9CeHhVOWdQ?=
 =?utf-8?B?TU9Pd1hJZDhVRFRDL2t1WnNMa2drdHdtd2pXdkNKWmhmSVFESy9Od3d4Nkgy?=
 =?utf-8?B?Y0pNSFBVUXgrWUFjcmNDTE9URE1LZXZzQlpRM2lKUnMzMDFLSXdWOEJLQ1Jp?=
 =?utf-8?B?YTFxYkJkVTd5WFY4YlhKYVNvcUU0ckorUmFWSlhEMCtPNFVIL2RoZnFtaVVx?=
 =?utf-8?B?RUVtb1hRYUlYdjM1T3F0ODZHdUtjWmZXU21rRVlmYkdHTTJaSkN2UCtuT3Fs?=
 =?utf-8?B?TFY3TUVUM2JGL1h6SHBsc0UxTWNwa0ZaekVwQjYwWU1Mb3hDbk1rMnJQU1R4?=
 =?utf-8?B?dW1hbWdvM1grVEJjdU9sQlRxZFJVdU5pdTlKSGljc3J1NGFDNWRoNlgrTEds?=
 =?utf-8?B?UHd3OWFmai9raHBEQ1BBcWVTWWFmSW1vWENMR1ZkdC84ei9QQUtDZmlRWWVx?=
 =?utf-8?B?YkF4WHF1eHZmeHVVcUZjUTQzNmp2UWFJWnJrN2ladkVHa0pGeXFMVlJkL1NL?=
 =?utf-8?B?K3IwVU9saUdibzY1OThrbktrcFFjNGNMZytrSUlJRWUrcFQrV0lFMmhGYmls?=
 =?utf-8?B?Szg3bzNaRFdoNHBzYUtrRkdlYXBxSHZsREVGc01DcFA5eGJCeEw4bmRYcHA0?=
 =?utf-8?B?MHREdm9YK0ZuOUxnNzdzL0JsRE5KU1B5SEtMSFlKNWhsZ0l2cDJmSzNqYVZZ?=
 =?utf-8?B?MzA0MDJKY0VJc0tGd3JTODM1R0R5YXpiSHNjRXRnblJROXdDR29KOVhYVnV3?=
 =?utf-8?B?dHBQcWZhbGVHeWFGeGZIZmJjUUQ2UlRjMDRTVkFGY1dtK1Blb05ZZFJwT0ww?=
 =?utf-8?B?V05aMnJMUDkxUHFjK1dndExlcXVEY0ZZRW5jWE9MUGFES0EvQUhUNXVoL1JC?=
 =?utf-8?B?a3B6T21wRGJQSFF6Nnp0L2x4eld0ZUpncG5wTXVhbHFnRy9pQkJGbkczckhw?=
 =?utf-8?B?YlBLcXVJRTg3TDNmVzNsNnZxT29JNU5GR2FBZ3NuL0N6eHZaYm5ZQUhRN2d5?=
 =?utf-8?B?VFhFanlwMFdoUkl4YktvWFA5ZFYwemU0MkMzYjdEL0NBMDMzYm5UcUl6d2J2?=
 =?utf-8?B?T09US3VpSEIxcGZkV1QreWc1T0RPaUplVTlteWVDRFNqcHRVeDdXcktVSVJV?=
 =?utf-8?B?UXdzamRSUEc0N1RNVlU1cW9jMHozSWI5Wm5rT0lsV2gvd1V0TnV6cWowVVlD?=
 =?utf-8?B?bVovZnBKanE5dk1Yd3IvaWp5S3N0eTIxRmMxeEs3K0hXL2RERi9razZRY1Rj?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 177d3852-6c82-4442-ce71-08ddea1cead8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 12:33:27.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2q/wVAc3DswbaOiBJ9bp6+KDqUIhl7Mrol0crDVCau9pKYWf4kzNK+vVF7RmDMDiS5TWLmFFISreKu5fYbrdW2EFxqxHDwSERBdR/tjgauU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 02 Sep 2025 12:33:38 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2108

Hi Trevor,

On 9/2/25 2:20 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> On Mon 2025-09-01 @ 01:49:24 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>> Hi Trevor,
>>
>> On 8/31/25 1:41 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>> Now that 6.16.y is the preferred version of the linux-yocto kernel, the
>>> nanopc-t6 machine that had been using the linux-yocto-dev kernel can be
>>> switched to using the linux-yocto kernel instead.
>>>
>>> NOTE: keep the various pieces of linux-yocto-dev infrastructure in place
>>>         so it can be used more easily again should it be needed
>>>
>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>> ---
>>>    conf/machine/nanopc-t6.conf                   | 1 -
>>>    recipes-kernel/linux/linux-yocto-dev.bbappend | 4 +---
>>>    recipes-kernel/linux/linux-yocto_%.bbappend   | 1 +
>>>    3 files changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/conf/machine/nanopc-t6.conf b/conf/machine/nanopc-t6.conf
>>> index 5ed413d1c0e5..8d524bd764f6 100644
>>> --- a/conf/machine/nanopc-t6.conf
>>> +++ b/conf/machine/nanopc-t6.conf
>>> @@ -5,7 +5,6 @@
>>>    require conf/machine/include/rk3588.inc
>>> -PREFERRED_PROVIDER_virtual/kernel = "linux-yocto-dev"
>>>    KERNEL_DEVICETREE = " \
>>>        rockchip/rk3588-nanopc-t6.dtb \
>>>        rockchip/rk3588-nanopc-t6-lts.dtb \
>>> diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
>>> index 6f4981fe29e6..e06c8a4f717d 100644
>>> --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
>>> +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
>>> @@ -1,5 +1,3 @@
>>>    FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
>>> -COMPATIBLE_MACHINE:nanopc-t6 = "nanopc-t6"
>>> -
>>> -SRC_URI:append:nanopc-t6 = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
>>> +SRC_URI:append = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
>>
>> Shouldn't we have SRC_URI:append:rockchip here instead to avoid adding it
>> when building non-Rockchip boards while having meta-rockchip layer included
>> in bblayers.conf?
>>
>> Same remark for the existing SRC_URI:append in linux-yocto_%.bbappend.
> 
> Okay, I'll send a new series for this shortly.
> 
>> Otherwise looks ok to me!
> 
> Hmm... you have not provided any sign-off tag. Did you want to?
> 

Nope, I think we really should have SRC_URI:append:rockchip in 
linux-yocto-dev instead of SRC_URI:append. This is introduced in this 
series, so I'd prefer to have it fixed before giving my Reviewed-by :)

Quentin

