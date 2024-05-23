Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BDFC25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 08:02:19 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.122])
 by mx.groups.io with SMTP id smtpd.web10.10323.1716451332065603053
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 23 May 2024 01:02:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=QuxFmf0Y;
 spf=pass (domain: cherry.de, ip: 40.107.105.122, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edkmkhS6F5E/k3Ba8RRmkuvCDDvVJDwOp0n73n3f9KshGYGvmjGTqNtNF37Z2noL5Z3bNb56HZxsqF0Om/YhOpqQ0ZDOgLU8nUJzB88lHBBZg7uRkTo1gmJ0y86zC+h1NAwWkTkzkVbdKkObrf2tSlh/rmhXgNE3vUfz+kAmtFowLck7s387jUZJwQZVR1NyNWEg8DQPXcEA+ntrxeg2ROd4jT4cypS9EmAlXxbcglPAjW0q2er+36ySxJZVgdMNGXBjZWR8B+GGlqknTQFdqmIAjitVDIjeDJ/F/bETjMhV8X/f/S1gtgC+iTOytM6mVOmzlf4MFuZWKIbd57n9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TByT3VtMgzG7MsrWQdX5V1ktuTPH/vKkeA8FjEX+PAw=;
 b=dsRq5tJHy89PrPK7fJMhg2sFw9y+jfT4DUmeUZ8Hxbj/fflZIuMDAhKhqv5oI9Fo4XTP71CEknZHVAVYlkp1mRBBDcIEbYlqmLSLC2MaBjzln+kPPB6yohwttPkX4O5X80CptNgqKq4TuF5kULYcJ5vjDnQcdTKJJAv/gsuN66+kTBSty9w5exgyXzAt7j/WvdvLkAp0CI28BY2DlirmvFvDPItQIN2KjcxV8oNHpTXXwZ749Xj8CcBberB9erqpDY1uHUQztaP8TSUbnFFmyiqxggRMKO2SDmch+rE2dU1tmq0y0XTqEbG3Sh1Wco26ay9FtbZRnn3KxLtfzz+mEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TByT3VtMgzG7MsrWQdX5V1ktuTPH/vKkeA8FjEX+PAw=;
 b=QuxFmf0YwtD+knMibwcxNIY+uSpfporfjk5j6P4KsMWsAeznNzXn05j7MbMtn3jdfJD3O5w6XtMV9Pq1EoGbAFzEHAI/vCBKXM1anxKnjSvEQYhfFcudb6m38eky/o3Q7KFGgwiJPchPYDyKQUwH+Q9g3FqgxoXKgL3BCnsMLFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by VI0PR04MB10104.eurprd04.prod.outlook.com (2603:10a6:800:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 08:02:07 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 08:02:07 +0000
Message-ID: <3e60a4ec-7ca8-4a59-9c2b-198e69d227ed@cherry.de>
Date: Thu, 23 May 2024 10:02:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH 3/4] u-boot: remove
 upstreamed dependency
To: yocto-patches@lists.yoctoproject.org
References: <20240522230808.14409-1-twoerner@gmail.com>
 <20240522230808.14409-3-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522230808.14409-3-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|VI0PR04MB10104:EE_
X-MS-Office365-Filtering-Correlation-Id: c3187045-5f5a-432e-e321-08dc7afea3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UWowRkdLV3NIT2ZnSTJpeHFHenRCNWxodWdDL1htQkJFTlRkaFY5QkVyc1RR?=
 =?utf-8?B?eDBXNFZzN1B3Q2NBdXpPVVEwTm1HYmU5YTFjUUpkbTZQRmxGNXpEVzhvTVRY?=
 =?utf-8?B?NmtOcXROdW9pdnZaQ25GekNlN2dHRU5pUGMrclhoUXdsdzc2Y3FPSkpLQmFV?=
 =?utf-8?B?ekJDNFN2SEx5ZFdPMFppN3pHTit6aWsrbXlDRDNBc3NES3BMd0ZYVEtxelFX?=
 =?utf-8?B?QUUwVTc2dVNwZHV6TUVzUmgxakgvYVZWZDNZQjNKN0VRL3pGZXNNSkVtM0JZ?=
 =?utf-8?B?QTlwT1AreVZISTNQaGtmZ0lobHhWdml3cW9veUl4NS9nYkxNbWFIZmU0SzRz?=
 =?utf-8?B?Yk40Q2g4dUd5SytrQTlKV0Y5dkNXOEdqeFBjQ2txelZtY0gvNnh3TnlXNDBr?=
 =?utf-8?B?K2lsUXY4NlFsVmpsNm40NEUvSDkxVThkZVRWUEF3VGVYSlhzVkh3T3A4blgy?=
 =?utf-8?B?LzFJTkJYVU0yY2VVMk9TcFFBY0Z2N1dDVkRWVWViNEVIWTZzWDh5UTZKSDFx?=
 =?utf-8?B?ZTRFWE5rRlg1Sis0alB5ekpYMHlvaUVVeEVKT1gxWDFPczE3eTZnVVFQb0xP?=
 =?utf-8?B?RkErcEc1Q1VmeFNvZWdMMkdwNHJRZVJDVDZYWmhoWlRHR1ROS1hZSmhZY2xE?=
 =?utf-8?B?cWo3TlFZMG1SSytVdnRWM28zTnJmNTRRSTJBWkFzVHpyWFE4bXY2aFJnMGVY?=
 =?utf-8?B?YlNOWjdNdi9lTDE3KzJlTVQzVnJBbktNNVlRMk9mNzZYVFlPVjhoeTl1TDhC?=
 =?utf-8?B?RTJuTXp5cXhVQU13cmU3NmJHYkFlVndIZHZqU01peEZLUXZ0V1pQd3NFNDln?=
 =?utf-8?B?dVJJdy9pd2ZvVERxR2k5UWZTTWUwSHhZbUwxWjNYNkh3a1g2MllPOTJudWlX?=
 =?utf-8?B?eXNMNWVadCtFSUNKRUh3MmRDLzRjYXQycnN1VmNxc0RtTHlvYTQ0YmNkeTlw?=
 =?utf-8?B?MEc4QnNsalQ0UnJnQjI5ODlIem5zWm9jRE1sa0xPUXR2WjRHUUgveitpU0Za?=
 =?utf-8?B?djd0eHFwSi9kclRiVEVBN1NnYWVETFF3YTFQWGpZN1ZWeUt2VE5YcmFWUU1h?=
 =?utf-8?B?bDVuMnNaWVY2N3lVVVdBUjJIc255RVQ2S3U3T0UrK3NvKzcvckFmQ1lsSnMx?=
 =?utf-8?B?UDVuRFRBcGdiNGswaDRBQ2oraklCM3FNcG55SEhhckFHWVlrZ3FXWlVRSndD?=
 =?utf-8?B?NExzdDVXaHBnWDJaeldTTTlFNFpGL0JkZjRuTnV1RWxQa0pDSTd5SHkxU3Ji?=
 =?utf-8?B?T216NTU3YVBzWVRlcTZNK1pOTVpDdGV5RmpUZHFoVm44SnBBWGdYRVA3d2h3?=
 =?utf-8?B?UXBYWURoZk0weGViTHJZc3JEcVo4aHRucnkzaXJlaWNKMjdPSEJPcStXbWdD?=
 =?utf-8?B?aC93YW9iSGdlNXRLT1lYdFlMTy91alVqbzliVEdiZ3pLblc3WHRKS2w1akNH?=
 =?utf-8?B?WldFZHRJcHFqdGU4Y0VQT2UwNUt1YVhWOVdnbFNOdk9VbHY3eXg4MlBTdUd3?=
 =?utf-8?B?bTF0U01XL2RUYVdxRkFjYnBoc0N1ZG90U3RuOWtqNC9YeXNmbFpVc3FYRHFv?=
 =?utf-8?B?QUpQTlFLcEd0MTdvT3JWRzI0UWpCQTZZcVMxbXpnb2QzeTZ3WHBUdDRURXAz?=
 =?utf-8?B?bjc1WURkUTFKSFd3elE5MFI1SXdYRlpYOGluekJLS3crRGQ5UlQwTGYrQ1Vk?=
 =?utf-8?B?Ym1PUE5WNlBCWE8yNEhoWEdVZmprcmMzUjIrcWIwT3VNRFRvSmxpVVlnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6578.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2tPcU1vczE5VmlpK21SU29yVDBVaUg0VThPUUZINWtTK3ZlRHZQUlg1TFFE?=
 =?utf-8?B?S1A3YmpSNkRTVWlFR0NWSFZVMmFoQndDb2tyZDUxYnExSzREZDIzU09EWi94?=
 =?utf-8?B?SWZ4TFptU3QvZENxalF1SXFYd3lrSjE3L1c2LzhKN0VvZ25DbFBtQjZ1cFE3?=
 =?utf-8?B?SmRreUdzVElhcWNnc2hldWtaSzFKNHkwaDE4ZTNsU2YxM3UyendYNllvQVhl?=
 =?utf-8?B?b2UxdTFOVG9zZEgwcWliNVhpRnY4NEVXYldqUEgvVFNHUGFBc0x5MGRJRG5j?=
 =?utf-8?B?MmRyZmpHbSttZUFMek92YW5jY1dFZVdUSW80MTlkZy82Q3lSYlJVK1dadW03?=
 =?utf-8?B?N2NUcUc4VHhSdHVyaEdjU3M1clV2SE9iTWZvOTRSQmFrSzdLeFNvTlhnd0J5?=
 =?utf-8?B?SDdNMEhvRkFHek01U2I5ZFhFd3BVajUxK1JCeHFzU1R3N0llaEkxT3VpS29C?=
 =?utf-8?B?YS91b1pQMjdVTWZEemhiVXFyMnMwbXkvVWJQdFpyTlFpUy9wUVJ4MGRGQmhR?=
 =?utf-8?B?S2haUGVzdWhZZUFBZWRudnV4cFpuSVIvaFd3bTdOeVR3R1V0VFRybXFyVzcx?=
 =?utf-8?B?aWUvT3dFNFdjTzI5SUlYWHcyKzZQeGVheHA3Ym54Y2V2NW0zVU4vOFdCUXZi?=
 =?utf-8?B?ajhEMDJhamlWQVIwTWY3WTBBb2c4SHBySVpHb1Z6a2dGSnd2aVVRSHhuUmw2?=
 =?utf-8?B?bTFZUE8xQlZ1K3VEdmttc3RkV3hubWxGZ0ZuSUlUazdSZWFNVFJWMU1SY3hY?=
 =?utf-8?B?T1JEK3lJTmt0UEtKTGtBOUlCL0FvbnFmSHZ1MHQ2QjZXTmgyd1ZDZWt1OVU4?=
 =?utf-8?B?dTRqaUc4OTM4K21XTzkzWnBWYmk0QXZIUnAxWVR2S2RsamltTnZIdUdlMWVL?=
 =?utf-8?B?OEVXQmZ5eFhjM1Z1NXNHN2duYmRKeWZ0TTVHODNLdTkvMC9zTGp4TFlUUkh2?=
 =?utf-8?B?ZldNRGh2U05MbVJDWmFEa29LQ3MyOUVvMTlQd0owcVgyQWkxL1NHME5mczJD?=
 =?utf-8?B?WGV2ZFEzelN2WmVuTXhBTi9YTFVMTmJWd3VwMXIvb2FHaGgzazhaRHdUMG1R?=
 =?utf-8?B?UCtjN1dPbkNldER6SFZraGVGN2hsV2ZBUWcvdlYrSEg5WDR5SFdWSEZOYUFB?=
 =?utf-8?B?c3gwcjl2Z2tLL1VtOGk5NkVHNDRiemlpWmtkREJiR2poRUEvaFBqMmhiRnM0?=
 =?utf-8?B?ZzVuUDdrbCtQOUtpWUN6MERiT1JBeXlJaTVZOXEzem5OL1JvWnowdWVmZ21u?=
 =?utf-8?B?SzY3ZlkxV3JTV3ZOQTZDRnRkQXk3Z0xsd1FmbktHbG9Sa0NkTmxnYkl1R2RV?=
 =?utf-8?B?K3BtTGdITHUzU0k2aU1zd3Y1a3l1ODRiVWxpT0cyR0Qxc1k5T0ZMWWh5VktR?=
 =?utf-8?B?V2JsNUloK0dRTEQ3NVNQK1RhM1BKcTJidVFSZUVtcVNhK2djV3lZV1JiMHAy?=
 =?utf-8?B?SjF6VncxUkJHOE5sNHEvR29Gc2xJZkt1V21GUkJXTkVrVlVYOVpwWng4MUhh?=
 =?utf-8?B?UUlHR1dYRTkxT1FxZG5XamdycC9NQjVlNzJzVGFnY3luYVNKWVRCeGthRTR0?=
 =?utf-8?B?bnVaQ2FmdjZDOVJObGpqd0w5U3FNSFJkVzJZaC9aeCt3N3hUaDZxR284QzVm?=
 =?utf-8?B?UzVGdVFiVUtGeks1U0JUZEs3djl6WXdBdHFUa0pYVGkwdDVQMmdzMzNmVGw3?=
 =?utf-8?B?a1hNRlFnYnlPa2c5UldHeFhpQVgycFZnRjJwb2VZeWtJMHZFdDgyakRxc0tM?=
 =?utf-8?B?cjROZml4eU5SMmJOSEMvTFkyWnlWdk1MWTlsN25FbGJJSkk2bXhObHF6aFdY?=
 =?utf-8?B?UGZldi9kZGVHSXhCOFFzM2J1aklzWi9NK0xUeVc5NjU5RUNEWVQxRDBZR2kz?=
 =?utf-8?B?TVh3emc5RDZEaStxeXlXQzljbWdlV0hSM3RHaktJdGhjdXJYeEcwcDEzU0JZ?=
 =?utf-8?B?ODRTSVhUN2xWT2lzRVJENExEdVNUWXpQRWFveHBZbVY0eEN6cXJkMHMxd0Nk?=
 =?utf-8?B?c3FocURzVkZMV2ZCMzV2c3FaRmhsWkJPZUpELy9VVE1RNUhtOHB0VUk4THhX?=
 =?utf-8?B?emc0VVUxT0NPMjhTdkJMS1hGM3dNdlB5ZE14SnBMUk84R2JuakxsMXhsZDlF?=
 =?utf-8?B?bk10K3Y0ZzJ3ckxYOTRkZUpjQmZpcHUxRnY3cnZtWEFldkFsVFJ1N2JWMHdN?=
 =?utf-8?Q?ZR3e0PG8s78y3gAURD+u+uw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c3187045-5f5a-432e-e321-08dc7afea3aa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 08:02:07.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSLXCwrT+iuqgcIW0lvjQfb/DPCFxYsg/AVSFkoZ5oY4Nb8hfXT04tFMiRfbiEwzFKesH8Pel+7lNkMYZi62HG6icH05+hTob8JRVZvYUWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10104
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 May 2024 08:02:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/174

Hi Trevor,

On 5/23/24 1:08 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> The dependency on pyelftools is now in upstream oe-core making this one
> redundant.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

I could add that this was added in:

70eca6a5ccf4 ("u-boot: add missing dependency on pyelftools-native")

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

