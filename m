Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC368CA0FED
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 09:10:55 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.19])
 by mx.groups.io with SMTP id smtpd.web10.16880.1757063452140468935
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 05 Sep 2025 02:10:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=n8iY2hic;
 spf=pass (domain: cherry.de, ip: 40.107.162.19, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmaCx9eFwbOeOyea6VMzWLyWIEj5198FP2LzEwa/3Vi00Xea0bCA+Bp1BkkKBSSnZSPExa4vwKpjZHVVjuT5Rq6yQ6c/cYJSIHdmri/FmQjsZ3KRsm39MbRkJ8AA92y7jD7BupsJECjOPopkdt0XoubFhaZ/tuTOb4Oh8qHgg+UiF9Wfr+Y9SinTjsA2gUGsf0JQur68aPY/UV94kWkjAIcBRt3UaHAf2UNCoIdgi8SKlI8EfXNdPLfuuhBTYFTB3Txf912D+NkE1S81rnOrhF/onQHx3JFj55OmZg8BfmKkDfnlwhAvbPWuo3w8Pw/K2IUXzOHuOV6Lzb3qBTD8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY4XuHpnpwZ7m2S18T1ohH4Fs4NG2nmqO2QtrcR3FA4=;
 b=yjeWfFP8VZoQ3WAdAXdFsSHkj95lu8eNCRzceRgDW94Tr15gKdSe+LNj5PdejSnjxQ9nAZAxXiBALxOPXYTuWD5abDdiXtQNTFqZ7kBUO8ka3KKuispho3HrsxCERqTNvPQg57+oO++0A6zwEAM4EMH4CM3ZxqBhubGduYpknmGttFgkyqrnvhlGlKWPAZCRWU8aGZHLzE9mRbNjZR7fQd+TEZFIcjhRcUHKAHpEPEHicFqSdAHaKYK6DC4xATKMp28ObNsVQV21tdfw0DpoTFuYe1d9iWRLCYiqb14aNLS6LO+au2Nv8bNNl+lwVP0I1oZJgCN0R8lazyp8cG+I5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY4XuHpnpwZ7m2S18T1ohH4Fs4NG2nmqO2QtrcR3FA4=;
 b=n8iY2hicB+HpCyEjwJYsn+InEL34epl8crBzkg/n7onYQ2osuLwyQQsJdy4639IkDjNQNirgucUohSaboaFkjsQg/jf2Z8VHQhwN8FYbsbNm3QkElKTzDZVnD04c9/gdTtdJ5LU7/Y8dzvnygJZMku7aNKgLRQwZxQH/f/Q1AE0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 09:10:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 09:10:46 +0000
Message-ID: <edc0bc23-fc67-4f2f-a59f-b98e48128942@cherry.de>
Date: Fri, 5 Sep 2025 11:10:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 2/2] nanopi-r4s: enable
 r8169 built-in
To: yocto-patches@lists.yoctoproject.org
References: <20250904194529.22656-1-twoerner@gmail.com>
 <20250904194529.22656-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250904194529.22656-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c6a3b0-2caf-48ec-9ed2-08ddec5c1906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TjI4bU5WZXZTY0h6LzFzVGo2M3hHSHgxbEJoLzYva0FIRU9TYWEwczE2TjBG?=
 =?utf-8?B?enhYSU95SnVYMFZ1S0hQY0l6N3ZtTWZaRzdZMnIveHZHNjh6MldaejNKSnB6?=
 =?utf-8?B?cm84WmlvMnExcVRhMGphZXlPSmNCN1ZhME5UZ09tUnJpU2U2TUYxL3BEYnFS?=
 =?utf-8?B?N2tUbzU5NTNjWSt2OEYwUjdubTNxQm1xTDlMZ1dEUXIrcnJhZkFWdmt6Y0s3?=
 =?utf-8?B?ZFF6dER0citFZTRBbXM5WWl6MHB1aG1BRmdmTis5d2dWVG9oSllrUWMxOXV4?=
 =?utf-8?B?ZWpIalRmQjdWclNWQjRQU0hCR3l1SVVmdnZ1bXgrR1puTUtwU2kvWlN2V1Jy?=
 =?utf-8?B?V1cweWtVZVM1b0s4M1d0T2dpL1lFZ0FibGd4Z3ZNekZPdlVvQlNFNGdsSjEr?=
 =?utf-8?B?SmxRM2FKZ2sxdXFublRtcmd6VWpqQ2xMNGt0cHRtMkhFbUJ3YmM0Wm5ab0J4?=
 =?utf-8?B?V05yNElOTzRsZm14MGRNbmc2aGl6dS9SeVZRb2NZcjlqTS9WLzhFZlRFU0ti?=
 =?utf-8?B?Z3MxSmJIcWd5c2xudFlOalBITmR1YVFwTUJuYitRWDRiVVVOUElndWpqZlVl?=
 =?utf-8?B?ckl2K3dzYlk5ZWZ1SmlzaDc1OGNGQnErVVB5aEZ6UHB0b0lLVEgxUEk4aVN3?=
 =?utf-8?B?QmRHNFpFNmZiSXQyUi93QzdhK2x3V0RXSXlzVjI0cTNUM0FKYVBjRmpiY2xM?=
 =?utf-8?B?NVZsRENHeUwwTkMrSk1HdlM0a3RwVGNUd3FPTDVrNjdWWEpxMTM3YjdkTDhy?=
 =?utf-8?B?ZEUxdHdSWWhab3pxZ0d5NDdOQklSd3RBWGVwVk5PSUZqemV1ck1qN0tCTzM0?=
 =?utf-8?B?aUIvUjd3RDRRQlZLOVRuVE0waDlpbXZlSVRrTXBMSFptZCtFeEY3anJlVUMy?=
 =?utf-8?B?bHJIWmQ3clp2ZGZQQ3IyVFFiN3lLT24zdmR1dDcwaGZseXZ5V2JCcWNRaDAw?=
 =?utf-8?B?aWNRajdDZmJZWUdCKzlsbjVIYU4ybEZKTTh6RnJxaEZPSzVteGxoajhYakxi?=
 =?utf-8?B?V2lDeEdnbHFiWmVFVWtldlhCY2RkUU94Wi8wQ3JHblZWcExURkJscDNJZ1Zy?=
 =?utf-8?B?NXZuVWNzRkp3VGRpc1liRDR6MDhxWW9uMDhnaHRaaVo1WllJZ0Y0Z3VoVURS?=
 =?utf-8?B?VlMrTW9uR29UTU54cnd3SHc2djZtWUVBay9JQWNzV3NwZTJ3MlVJcVhoVGhz?=
 =?utf-8?B?WGtvSXd0QWVkbndLODgzdWVBV3U1S0Jhc0NkekFsdkt2dUhtZ2ViRVo1ek9p?=
 =?utf-8?B?L2Y0NmZhYUo2NlFDVktwY1BSTVUwNGVJbElSR2tuSm5ER1dqWWZXRVFTNnFz?=
 =?utf-8?B?SzZGLy85WjFVYTllei8xYWcvM2tWNzNvaWJKLzljTk1kdFR6YUtHdkN6Tld4?=
 =?utf-8?B?UFpXcFFnYy9PZGRjTTN3dEowNkEzWWt1enlNNWFMYmw0UUlqV0I4OGt1TW5j?=
 =?utf-8?B?aXh5R0o1aGhzZEJVNklua3F1KzFNMTZGbGhzczJ6bkNIZ2t1ZXJQM2YrNDhN?=
 =?utf-8?B?NlZlZzlCUUVSMG5PUnJ3eEZUclREbExVMis5NUdkTzJHeW9ybmliREtFT2xM?=
 =?utf-8?B?MzNCY0UxMDdiNy9NK0Q5VCtPZWtHUi9ZeXQ0Mml6Vm1SdldzVzd2ZVFLRkx6?=
 =?utf-8?B?S0xWREhsV2VHQTA5bVNMd20xUTZpOTRhajBXTmtBekxIWTZEMlZXbzFkRE9S?=
 =?utf-8?B?UUdFN0FrMXVJSGp4UUo0L1lDbmJ0T3IvUlVUeVpmZHQrMnFFVWkzZFpIRkNQ?=
 =?utf-8?B?Y1JGbGlYR3VKTXRZMi8yWEZmc2RpN000MDBjTFpQTDR3UnZMK2UxREFwSGxH?=
 =?utf-8?B?aTR0bkJLcnhxSGNzUlAwUjRMRDhHQnBrdmFWaE1Ea3lwODJsNEJEbGNaM09h?=
 =?utf-8?B?cGp4UnF0YlFYNTBVNWo4TDR6Qkw2MDQ5T2VOOE5jY252eHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVZGN1R6eEZkN0t6Tkg3cFdGWkdYWktjYmVJRlhqbUhqSk9ZU1JqMlJVZVBP?=
 =?utf-8?B?cTN5THAxWlRDbGZMTktCY3dXQno2K2pEQVc4OUZNTzQwTlZqNXAxY0kySHo3?=
 =?utf-8?B?ZXJJblJ0cWtRRTVPWGRnYUtYcStKcTZSYXJtMWJxRkozYnRYWkovYld4MVJK?=
 =?utf-8?B?YVFyR2t4dmNzeUZ2Ulp3emRnWGRCWG5KcjYwSXdUSHppN3I4M3l5S2RrL0Uw?=
 =?utf-8?B?K1ZuQy80VlBnQW5tZnpqbHZxcEdGLzZxQW84NjNkY2NQOTVNT0ZOMEl1MFlO?=
 =?utf-8?B?Q3ZTbDg5Q24rSnhCY2xHMW9wdkxQM0FYSEQ1N09nTW91QkI5NE5WL05zZmhB?=
 =?utf-8?B?L1ZWSXNPVHZZczVJNnZVVGwxaUh3d01xazZpd08wVlZPaVNzNElNM2ZSWTEz?=
 =?utf-8?B?UDZkWGV6dUZ6dXZZdjQxdHdQaFRkcUhveHdTM0UzdmdWeE9kU2hVNmcySUtk?=
 =?utf-8?B?STh0Q0JjdDRpbksxMDhWbG1ENlJiNmR6SjdiSUZKbGRDTXYzMllrQUNLOXF1?=
 =?utf-8?B?ampzM3d6V21Tb2ZRNUM5MGRwYnZXVjdrNjdDb2ZjNkM1U1phQjF1cHdXYjBH?=
 =?utf-8?B?YW5nemZ0UE9YdFhnbFdUMzlOd1FQc3dVWm5TMU14WGJZejU5a2JIaCtMMUhG?=
 =?utf-8?B?MGN4OHJaRlJHRkV1K2FsSGdEbUErVkhnSkxtWmVMSEI1SktLWERNbnM0c1ZG?=
 =?utf-8?B?SHQ3ejdyOFNxaVg5ckdMeElsVCtpTDJSTTVFb3dqZlk0bEQzVVc0ZVdxSEVh?=
 =?utf-8?B?a255SXIwWmh2NGlUUTZSd3dVUS9wWGNidVF0aENVanl3WXo2bmFFWmY5Q3VU?=
 =?utf-8?B?TWt6ZVVaaGVoOFdSTUk5c1R3bDZNVWcweVJvUDBHMS8vRVFZN3BXSUNYZTcw?=
 =?utf-8?B?Q01HQmpTQXRNMWhYUDNRaDgydWlDb25iOEk1YWt2REdOeXJRVDNNYUVCVWdh?=
 =?utf-8?B?UGdQb2VmUGE1cGZaanlVZFdmMmtNQW9Wc1VlNjJ4d1hMZE41VWFST3dXZDBw?=
 =?utf-8?B?WVdxZk1kTG96RU5vaU5QYmloSjhKajBjeWdyV3FKdXJ4bmhxaEtZZnJWY1Jn?=
 =?utf-8?B?R2I2SE5TSDlma1U4T2ZBK1VYZCthY3ZlSUt0ejA4eGIzcXIvVXNidmsvV09X?=
 =?utf-8?B?a3dsR2tXTk9CWk16NmtrdHArMll1YTFvTE56RWhVK0tMRWdnZFJaTnU5bnJl?=
 =?utf-8?B?QVljeG54OTJYZkpFbzI3a0ptM3lCOXFTeVhFVjNkbjdtN2lwd0tPM3NHZGRp?=
 =?utf-8?B?QVVlQktROGJtVi91VUc0WDhhNDZNaVowaVVZbGxhdWdCdVd0NUNBL3lQUmEx?=
 =?utf-8?B?anZjcjZrcHNhV0xoMW4yM1I5a0QyRVNETE9YWGZaelUxYU1CSGZ0bEkrM1pr?=
 =?utf-8?B?dkZORXBYa1NNaU5ibTRJM3pVdmV5S0Q4OUtnd1VHTk4vT1IwWk9DUlp1eHJs?=
 =?utf-8?B?S0FmMXZkZ1B6MS9EeXMxL0R4NXNoVldpSlRNZ3lsS21zYXlhY3cxcmpaMWZM?=
 =?utf-8?B?UTJReVBGWGRuQ25ObTZtRkgxTG0zb1BmYW9OQUZKMUh6WVY1N3ZOTHJhSmZO?=
 =?utf-8?B?SllCSU5SOXV5ZTkyL0FGUzl5R1h5MWlyZ2x2ZEp2eUl3Qzg3R1ZoSERsaTkw?=
 =?utf-8?B?ZHFLVDJiS1YzeGlEaFV3Sll1elM5NDVoNFNuWXBFQm9jQXljVGdxRTZ3UjFz?=
 =?utf-8?B?ajNnaVp5V2g0ZTFpNTBteFlhN2NLOFR1ajRSOFkwWEdhTTJwSlVCM1BGeW8z?=
 =?utf-8?B?bXFYTWVSY01YMHpqM3hOc080RnVxbXROTks3UWcrSGhSNnhXR04yQzVnZEtt?=
 =?utf-8?B?a0ZBcnZ6WUlqUWsrYkZuK09WdjVtSVp1SSt1VUc2L3d6SFdyVm9NMkxuV1J3?=
 =?utf-8?B?S21NWDI3a2pjeGFzRVRGeEFoTDZHdy9DM1loWStDUTI1cVZmQVFZNEFOOXFW?=
 =?utf-8?B?ZU5lalRERVEwTW5CeWFWbWdpN3NkVjk0ZUJxTDVYdmMyQXZ4QlN1Y3hoREIv?=
 =?utf-8?B?RS96VVhpaE5xUTRoQUhnc0tmZE9qbUlEZnhGOEd3WHZmdnN6U1REb0hnd3Zi?=
 =?utf-8?B?ZXMzMkhEMkcvczIxVUY1Ti8yamYxT3VlNno5RmQwN0ZWaVNiNXQ0Sm01aUhR?=
 =?utf-8?B?RHR4OWxOYjREVHBKWks3VEtPQ2Y3UGZRUlV6dkxMWGo1MDR6Z3MvSXQxdUVP?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c6a3b0-2caf-48ec-9ed2-08ddec5c1906
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 09:10:46.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8SXgwSrXVlwWN0v7nSxKjot2L9xR3ThD9G/MXKvXSkd3XYFhaYlWj4XCILPJmF+EVTAyH/fQ3MxoeVhQBWN5uhOdzQoNLodXCb96yEPMyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 05 Sep 2025 09:10:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2138

Hi Trevor,

On 9/4/25 9:45 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Since the Realtek RTL8169 is part of this board, enable it unconditionally in

The FriendlyElec wiki and product page doesn't mention this part number, 
weird (but armbian and openwrt forums do).

FYI, it seems the default value when using "defconfig" defconfig from 
upstream is R8169 driver built as a module, so you could simply install 
the kernel module instead of marking it as Y. (But then you hit some 
corner cases when you want to use NFS for rootfs for example).

While many devices supported by this driver seem to require (?) a 
firmware, the R8169 seemingly doesn't seem to require one, so I guess 
this is fine :)

> the kernel.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

