Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C210ED13C20
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 14:27:27 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20616.1769437642935243835
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 06:27:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=N0I0HWNj;
 spf=pass (domain: cherry.de, ip: 52.101.72.36, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slspZBqf3gVY2PBW4rVdiwzNuVVOQcyBbMitefDbMJhOzc/Yn3zCeJ4PSsHUYCEPvKMXAbzBBAuTxJtZ76JZUE+dXz5pj5NoODBB7MkIPJhKuBH9iBkxiywxXFx2RUG54UVCz2Wcmy+G2zpoDeVR94+4jaRtdtK7e5GpxCXdO0k7gGB/nQx3jt+5KaCi0J8oHtDHjq8IaaDkeFJl1KHF2wTtSuV2qCB0KrKEW/bRtBajAUXHB2ck9ekZC3Xo0+AX1eDX8UxxK2NNh3tUDuNWRUgHhSSJQm45eqLxbcdqRN1uyBXiGvuSa9eBdOkl81cQ2l8Yi/XG/1fPmwDhOUhQWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcK0fY4ydHprrHHRzHB3y6inwptXlpNP3LJnjYf91Yg=;
 b=OPSkerQfpzXsoID12ybcPKE79qwIpalQF6P4gNPCDRJuLGQkEqng78HzPicGqPylbCW4H5CQzLhjbkbhWt6/MSqqzfulZ0ka5B4z1k16rb+5smpHysTGlklZ5OZ4L5gCzYWYbUHEg++U4PazKo3hJC7rMAfI8/k2HrWuAx4i6RmMpvPfBtldQZuDbVjteOCwpmXsX18lI6Jolh/Su3sBX2xRVD01mx47bbv3bN6XMO+raCXv5qITgsyfRizTBzMhoLK/R5PMdfDD7Lm4jsaa5ZWxjK8F/6lpv156/BOgAcxR3D8yaPkUDohawIQ8liX0m8ToD2251XfkdEBLH/dKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcK0fY4ydHprrHHRzHB3y6inwptXlpNP3LJnjYf91Yg=;
 b=N0I0HWNj0OtHNT8txlDsd+ocSCdl4TbHkCRTEvFRjDhQtounGeWp8rz0AIeLGdQwamZV5M+/Fhn2YDdr0FLpWbu8XZBnlFIY1xZXHl/n4HWqd+cRDe/ZPnJZgE2ff0RUI0/6//H2av5OEvPg1YJmKt6Ud43pwF/scE7Dwo9uIVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 14:27:18 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 14:27:18 +0000
Message-ID: <128a6f2a-58e2-4b15-9ecc-e067c8ed8d98@cherry.de>
Date: Mon, 26 Jan 2026 15:27:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH meta-rockchip] bsp: fix upstream TF-A deploy desync
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
Cc: Trevor Woerner <twoerner@gmail.com>, Peter Hoyes <peter.hoyes@arm.com>
References: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260121-tf-a-fix-v1-1-02f7b61db7f8@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0363.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 940f1994-9b3b-40cd-14fc-08de5ce7025c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NGlQR09NaDlud25vK3hudkJWblFMejZVT0k0RUU4WVllRkRTRC8vZUhIOFBs?=
 =?utf-8?B?TmRXQ1lOQ1JUVlhJLzg2TXZoZTVRT25Mam16b0p5Tlhyd1ozNElJNEJCcnU3?=
 =?utf-8?B?aGZvSDlyeW4vVHZBZWdORm90c0NiTWhDR3pVNzFyMWR6UWtWaWI2czM2NjlG?=
 =?utf-8?B?UUMyQlB2TEY5TVlYTmV4ZDJQdUsxUkZ3MTBMbHE1MU56cmtPNWdHTlRuUEJw?=
 =?utf-8?B?djRaTzlId0o0eVUyVndyV1paWEVjdlA2NDM1NjhsNDE5V1VaSmxGUTN1TWE5?=
 =?utf-8?B?T2NNdkIxeFFUQTdPRTdFTnFsZGNQK0pvZG4zT0ZCMDNPcWdHbXZGeENyL3Rk?=
 =?utf-8?B?TndnZmk5ZDc1SEs1QXcxdnhtT3NlRUcxWTJRSHZCUXhGSHZGZHY2bVR5NjJJ?=
 =?utf-8?B?WWRMYldKOFlaNXEvOXBCdTd4T3QyQ3RUSCt0a0JZRUhzejBOVjZPN3FHVHBv?=
 =?utf-8?B?aTBSRGV0QWE2Ym0xaU5XTXRXdkZHT09GamI2cXVFSTE2YVp5alJSa0VWMzJZ?=
 =?utf-8?B?NURXUkgxTGFuK2RmS2xIM2taR3NGdExMblM4djJFMVQ2L2toTU9hZHpncEVL?=
 =?utf-8?B?R0d1YnVXZVRnQXM0c0xFVGVFMkdqNUMwR0NWM0RzSFV3OGNZYkgybGU2UjBy?=
 =?utf-8?B?SU5IZlB1SGpVZlRXajBBUXpMOHhTTFR5UlBoeTA1VTVZR3J3T09MbzRSZnpG?=
 =?utf-8?B?d1EzVFQ5SnZRSGlPKzFOR2l2dnIvMDJOZTMwRVFxZlRxeDNEenZOQ3ZWL1pC?=
 =?utf-8?B?M3NFU2pWMzN1N0M3QjNNMEhhNWIvYUU4ZnpuVjQxY3pqRzlEbUtZc01zZldZ?=
 =?utf-8?B?TXpsVC9jZ1pMeHlicnNweWF2c2lSb2t0NDRxSTZJazJxWDlMQ1pqVVlGTG84?=
 =?utf-8?B?U3pmY3o5YVZPeVowQldoN3dodGJNazFxUjY2bVY1cVUycTZha1djc25ZQWpF?=
 =?utf-8?B?N3hlbzdqZmsvN2p3SWF3ZTJNT0tOak94eTNWRy9NcjBoSllwSmJaK1ppM1po?=
 =?utf-8?B?UkhBVCtaRytZMk5saDkweXRDSnk1NW5QdEFWME12NGpNdG5YcnNNVmJobjRZ?=
 =?utf-8?B?akdOYmx1c3dhbEhhejArMVpRKzZYdDF3Tno4OFphVzdjTHhyNm5oL3ZOM2Ev?=
 =?utf-8?B?QkMvdzg5dWljOUU4WE9nZkhlKzRvb1YzKzRCUXc1aFJER3lhTy9OU3V3TnFE?=
 =?utf-8?B?bUFUTkRZWGs1N00wSlBSNnBycEtSRHBrOVBLS2tqelVjVldsQkxMNUVXR0J0?=
 =?utf-8?B?L3VaMHRvcmxTelUzRlR4Z1RJT1p1ZWk1UitiZVZZQmFXMm1rUmwxTkIrdWx4?=
 =?utf-8?B?eXhyOTVKdlRCSklqQ0hBbzNlSjkwUVlKdXlSYnkwZjIxbXU2aW5BSzlKcldn?=
 =?utf-8?B?UVlEd3N6dHpmWjh1d0JJcE14R0FJVjVGWXlhbHZ6TjJEdURyWmNaaGJyRW5t?=
 =?utf-8?B?WmtNdE5VT2NodE1kcjVVQzI2S2RvRTZqZjdDTTU0QUV6SHF5MUUrR2twb1RI?=
 =?utf-8?B?R2JzR2Nza1BBTVRMWERiUlQzT0Jndm5wcW9DYTFMVlNmaFB5NlVNOFFkZGJj?=
 =?utf-8?B?blg3RjlDSXE4dWp1RG5HdUM4K0Foa2pLOEhuVysxZi92OTJZMXZGbklUZnJk?=
 =?utf-8?B?ajdrUE01SWFwMHdhempvRE5BTDJ4WjZqVVVodkp3akprNmRDcUU1RkJsaU0x?=
 =?utf-8?B?YnppbEZnZlR3eUxhZVFHZlRYa2p1WTVzK3FrejZMU2ZiNkNyOHR3ZDZJck40?=
 =?utf-8?B?UTlQQ3RFQW1rajBocnQyUkpzYnM1elRZT0xYQVNmM3hpUzRFLzloUVhnVGRM?=
 =?utf-8?B?elVLN2owdVZ2eUV4dS9vY3ZWV29iMXdQUGkrN3k3SUVkNFh1cTJZMHZoVmxK?=
 =?utf-8?B?bld5RUVxblFlaFgxZ0k4aXYxbUZ2WTJRYU43S2d3OCtFU1FKSmZHV0pvQWJQ?=
 =?utf-8?B?bk85c0ppbG5hdVVtZUc2TDViV0pyS1BQUHIwS29ROFFCcGU5eXQyNFZjcG44?=
 =?utf-8?B?cXBwSGhLemRXVVNCemp5WmgrcGZra28yWWlUc1JNTGJLRGFLcThYVUtxK3BH?=
 =?utf-8?B?ajZQTHRmNS9vWWtnTWdQU1FhVzV2bVFPb3dsdGQxY001QVMzM05icFVSV25v?=
 =?utf-8?Q?0Al4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UjRmZkt1VFczZ2lEWitTQi9FeTB3YVhxeDUrRGhncEhqUENDQURLWGVUajlp?=
 =?utf-8?B?NlJoUDE2aCsrWHV6WHVDQXIvaWZBbXp5cDY3c0hnRDRRRzJWa0lDMUpLSHZa?=
 =?utf-8?B?K3pBNFJwc1g1N2JvYmZUUGlQUlhlN3NtZTN5WG13a21mT3pNcXQ5eVdYL1Bp?=
 =?utf-8?B?VGlHR0x6cVhxL2k3bFBySW1MeCt5TlhqWUlucDVFSU1jbkVWNklSOUpocGU2?=
 =?utf-8?B?bG5rNEhIalY1REh6dituU0ttMW84cEd0TGV3RW1ZWjNkWnkySjFaQzZlL1VG?=
 =?utf-8?B?OVp2YkExQTc2aTYvanplOFk5Y3JTaTZ5b2x5SkFKNXRCVmxreFhQRjNrbjZ2?=
 =?utf-8?B?MDkzU3RKNE9vSXI3dkZhb3cwazlubnh5eDZPZXZvckN2cTYvLytSSjFIaVcr?=
 =?utf-8?B?K09EbkhOZnJ4bEJmL2RkUDM3OFMxb0FFb2t4Yzgra2tnaCtNQWFTRWg4L1JF?=
 =?utf-8?B?MVFkZEcwcmdtK2NETXJwK2EwZVBxSE82WitSR3VDOTQzaFNnZE5yRWVmNEQ2?=
 =?utf-8?B?QVZSQlpsenNZaHhSNUNOSndsbXFTdGNQOVZYbHQrL051dkk2OExYazV1K0Fq?=
 =?utf-8?B?RitHWG9jRXR3Mk1VSVFVOVhIbFcyZ2YyQU9peVVUUnVVUml2TllBM2lmR1o1?=
 =?utf-8?B?aFJ5SldlMlozRFVFdGltNUFEK05EbzFKNElmT2ZneWJ5aXN2ZjVvbFFhamFM?=
 =?utf-8?B?dUMvS1hmVXR6RTlIUkE2a3pvTm9JelQrdWhtK1NJN1NBSGZTL0ZtYmVuU0VY?=
 =?utf-8?B?NWFiNU1IME5PYThZb25nVW5jVm1adUhuVVk4TnR0bDJkNnh4YkJmMWxjYmxj?=
 =?utf-8?B?V2oydUlvYm9neTZwd2VZMWtNV3hCZVZSLyt5cXRyQllNQTRGd255WERzNjlO?=
 =?utf-8?B?M042T0gzSU9PWTNSeFk3MTl1RUVJSHlhYlJVekhGNnJlSGRHeTZZMmVqeXJi?=
 =?utf-8?B?Y29JQTdyYVg3T2JPT2NhN1J1c3RORHdsMzRySXRFaGFBUk1DWENYRTFyalVj?=
 =?utf-8?B?WFpkajdxbkRJNmQydFgyeTB4cVRENDM1dlJHY1RPN1ViYzlPYWVBRGFzYUZG?=
 =?utf-8?B?MHZzZjFHQWFJTnFhOXBBZjZEcDhoQmVTejlsK2ZiNHppUVltVkZ6MndPWFlt?=
 =?utf-8?B?RUtIY01uaVl2ZWVVTVR0MUEvTU1xYkVhY2pvWGRnSzcyN2NNdXgxaGwyUU9k?=
 =?utf-8?B?aFhoeUJRSVpVcCtkVFZEU1o0WklQbjZFdEh5WmIxMDV3UmZJRDBvcVFEUnIz?=
 =?utf-8?B?bE1GSW84K2FPbXhRRU5ZR0dhTkxGTXc1UU9rM0I1UTdTeVR1WFMxTXhNenNF?=
 =?utf-8?B?OTl4TDRhTFpBdEszREluNVJJVVpSNTdhcUdUaXBseVlva1loVGtNSzBrOHRy?=
 =?utf-8?B?cHN5c2FMd29lTS9HUGVqTzBMR1ZpN3FqL1c5UFp5TDRNYSs5SGIvNThIRDJZ?=
 =?utf-8?B?VUd1MG5SK0ZuYm04SitRRFdxeEhMeDd1NE1IUE5rKzFuVWF3ekJuTnNpNUNN?=
 =?utf-8?B?SmJIbTk4Zk5yZFUxYlloQlpJVWZiMldnd0VMa3ZaSlg1aVhsZnhaMzJBaHBH?=
 =?utf-8?B?K3R1ZDZ5d3BmWnRiRDNXaHBzSW5TL2w2aW4vKzdqUkJzREJmdlViTTNpVTlq?=
 =?utf-8?B?czd3bldwOVVpMGdpMUFIczh0ekJKUzFQTVlmdzZXVlNPc1Qwb3VzWTJ0MFAy?=
 =?utf-8?B?SXYxZFg0QWpJNmY4VFdRSjhOZ1R0NGZGY1B3MkpNWVlwMTNkYXBMMHk5WDc4?=
 =?utf-8?B?cGRZNEw5MUMraGhlSmV1bkFDNTVHWk5EZTBaMi9rWHpjOEdCK2VidXFnWkZZ?=
 =?utf-8?B?TVUyYkNyc1N4N0lvZWJtWUg0cWlBOFNNN3BuanlSK2ttRnN5V1RxZktHTk1q?=
 =?utf-8?B?Sjc2VVFzcVZnajB5enJxdVB1bUNzVTRQeXM1OVZueUN1V0U3NlFmZ1VTeWhK?=
 =?utf-8?B?WW9xdUZLbkNka0JQUHA4UnhwaGdTOG80Q05sL3owVkIvV0F4c0p2MmZUeDBZ?=
 =?utf-8?B?RlhHLzI2V0E2dHRtcWFtMFhQVGFQeTRIVjdEZGlVVVZuQTVUdmdwTnA4Z2Q2?=
 =?utf-8?B?TXZXc1RzcXRjdU8zMTJmenMyYkRpVWpLQ1NiSWwvWUtuOEZPdFJFekN2ejJQ?=
 =?utf-8?B?TDc2N3RYS1plWnYyZEM2YmxYejMxZjBITHJiWHFPTTJEV3lkanFIUWtkU25G?=
 =?utf-8?B?VnlJcnVWU0tqQmM0cGIrcG5rNTQ3Y2lkTVpKY3J1TEpLQW1XOTlvTmhZb0x3?=
 =?utf-8?B?YzlTc1EyNG9ZY3U1OTBFbFl5Q3Y2aVhWQTVpRFZVL0NSR2Z2RGxqYXZEZnM2?=
 =?utf-8?B?NzlvY0VFRjlmbmhYQ1NBcW5mUDB3VjZWcnYzeUFTNitrZDRXU2JQbTVTWFYr?=
 =?utf-8?Q?MYH+M+rC88OkB75XKOKWsPa3VP56iD8s7cqOM?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 940f1994-9b3b-40cd-14fc-08de5ce7025c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 14:27:18.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3CEbEwjPjRUIjQPACw1k2Ro2am7IJdq/0m3H2Q8ZUtX3+qPVHixFwD87mopXm9dWlgyDqwci+mzWsahQ6MhCnHpPMxJbAhmFogTgTKRNho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 14:27:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3082

Hi Trevor,

On 1/21/26 6:06 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Since commit 7bce36a2c64b ("arm/trusted-firmware-a: Use
> firmware.bbclass") in meta-arm, the BL31 firmware is deployed in a
> subdirectory named trusted-firmware-a and the binary is simply called
> bl31.elf without any other string.
> 
> This differs from what it used to be by the use of the subdirectory and
> the name of the file itself. This is an issue for us because the U-Boot
> recipe is given the path to the BL31 binary in deploy directory and that
> now was wrong.
> 
> The second issue is that we want rockchip-rkbin-tf-a to be a drop-in
> replacement for the upstream recipe and have nothing to change in other
> recipes dependent on *an* implementation of TF-A (such as the U-Boot
> recipe).
> 
> We can either fixup the path like was done in 2a13a49da4af ("fix u-boot
> for tf-a firmware") but we'll need to do that for all current and future
> SoCs (and also wasn't a complete fix as for example px30 didn't have the
> fixup applied). Or we can simply adapt the rockchip-rkbin-tf-a recipe to
> deploy the same way that the upstream trusted-firmware-a recipe does by
> installing in a trusted-firmware-a subdirectory, simply name the binary
> bl31.elf and update the BL31 environment variable in the U-Boot recipe
> to use the new path.
> 
> Because RKBIN_DEPLOY_FILENAME now contains a directory in it, we need to
> make sure the directory is created (with install -D).
> 
> This was tested with upstream+downstream TF-A for RK3588, upstream TF-A
> for RK3399 and PX30.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This is a follow-up to
> https://lore.kernel.org/yocto-meta-arm/28377373-a3e8-4416-aa7f-488cdfdbcf55@cherry.de/T/#m76f7d4b56849cc28fe80a76953f4e6e61ff0f7cc
> and
> https://lore.kernel.org/yocto-patches/dd990ccd-a418-45bc-b708-d3b1fc763ea5@cherry.de/
> ---
>   recipes-bsp/rkbin/rk3308-rkbin_git.bb                        |  2 +-
>   recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb                 |  9 +++++----
>   recipes-bsp/rkbin/rockchip-rkbin.inc                         |  2 +-
>   recipes-bsp/trusted-firmware-a/trusted-firmware-a_%.bbappend | 11 -----------
>   recipes-bsp/u-boot/u-boot-rockchip.inc                       |  4 +---
>   5 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/recipes-bsp/rkbin/rk3308-rkbin_git.bb b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
> index ab2c70f..0661fc4 100644
> --- a/recipes-bsp/rkbin/rk3308-rkbin_git.bb
> +++ b/recipes-bsp/rkbin/rk3308-rkbin_git.bb
> @@ -28,7 +28,7 @@ ALLOW_EMPTY:${PN} = "1"
>   
>   do_deploy:rk3308() {
>   	# Prebuilt TF-A
> -	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
> +	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/trusted-firmware-a/bl31.elf

I believe we should add -D after install here. Do you mind doing this 
change when applying or should I send a v2?

Cheers,
Quentin

