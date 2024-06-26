Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC46DC27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 15:09:31 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.139])
 by mx.groups.io with SMTP id smtpd.web10.29327.1719414560920144804
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 26 Jun 2024 08:09:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=avuGqJhf;
 spf=pass (domain: cherry.de, ip: 40.107.241.139, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tsf6lOR8pPeO+Wt5Ris+nSw8p+eqISjRdmkzphQoP3tKzUJzOXb2K87EPABiu0nuMeV9n0IyDZlvvvhv1uhSJmhuOYvpkxgPUa0NvbiENhg5BHpzdpTjRN/p6udsm4p3AcJ9SFvfaRdknF/l9ja7LMrgECHXz5fi+bUzYyKI9s81qdfE+tjdF7TopueLdw/dNWTgKmkCCYVzgBqP5KmcH8KGpWdcVtZ7aZSXlCAYfLaslGFvqyELOSV9pI3ShWABICGY65/bLa/QBjzBg5JHHS7qtyww8iboNCpoQs9x/69bwg+Qe6qwMW48xaElnotgb/R8xC5oiZUWp4WuBIRqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YevCTqOwl1kUz7tSnKZsvVj3VfaQm91Z1bMUbLDIlDg=;
 b=LEOfB928fVEtsER7lsbMe+b+Yl5WJ7Upj6wC6GeXXaQLO+wlzy6HGAkrZOJp6/cF7zIPMlUnm08f+8cMziHJB146+PKvw5rT/ySgw6tX/EjtdaAMv0cy9SSVVIZN/5MSJ38gsULJcLVh/O4q2djifPpVBrJlnwBZbYMN9TJW0fdiWjtz0i3WxoxmBermighSYR/FnTSEfFtqe/p/s4hAIbcSsyxpHjDig2fWzY/toVamW2lhgiJ2LL+Vn6xL7NuxCJS/M2e3togUFcPMsq+UElCUTmK/zqYcgZ1lTBco+FczpAVeSjTKYkvO2BGqCbS0t7EZ360sCtuJKNDzlRSaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YevCTqOwl1kUz7tSnKZsvVj3VfaQm91Z1bMUbLDIlDg=;
 b=avuGqJhfzCczs0llgsvLg26ES7gO2OWnyuaE86mdr3Si9Htx+ZHeVJCwVWpSChEdBghfsAmk1gS6iGHemMNm+J96R9ocfQpZamdUcvwQBPJ6xTfLOi5QJmNGQDqLrEpZ8bT+hSCi8MEWYKUgF12XAcrmlKm/MEKddU4lnm7mLM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:09:16 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:09:16 +0000
Message-ID: <daeccf50-cf37-4ca7-8f08-0daaccf33502@cherry.de>
Date: Wed, 26 Jun 2024 17:09:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v3] rauc demo: add
To: yocto-patches@lists.yoctoproject.org
References: <20240626135632.1623-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240626135632.1623-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: a28538f3-ccd2-429f-466f-08dc95f1f210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|376012|366014|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eWdla3JBc1FxWDlVejhhY04wSEJjeTR3UlU3WmRPcW8zRGpTVUlHRGd3UTJX?=
 =?utf-8?B?UDIzQUswOHhyUG1NU09pSyszQklwcjhIbnZhNGZtU1V5djFjTFNTQzYvdFUv?=
 =?utf-8?B?ZHBjNFV3VnhYb0hDcFBuelNuSGl4RDRUbDE0bHZnT1QrL0tBdmoweGtmWjQ0?=
 =?utf-8?B?QnlSMWpqSlhnK3VhRWJpZVBqb1J6UHBRclBuL3I1UzQ5djJKSFlPK2FSZUY1?=
 =?utf-8?B?U0xMZ3VwUW9tTXE4Ym52T3Nxd3NGTzJabkhHUzBKengvUEoyUU9taHBRaldu?=
 =?utf-8?B?UGFnNmFmK0RpeGJrdiszckFTdHlBWHpMUlZPOGxQanhTam1BNDBSUEowdGNZ?=
 =?utf-8?B?WkRPL2x6ZUNTYmhWb09lUHNZaHhRc3JEakRpVGt4UGtMZG9tMXhvZVExTnFP?=
 =?utf-8?B?V0M0em93MWtHVEI0YUIvcmpnQ00zZWRVd1B1VFdZWmR5VC8yNnZ0Szk1Y01j?=
 =?utf-8?B?L2ZjM3BQTC8vK1ZJbkFDQllRSlc5SEc3TFBxR01pdFNaUWlxempaN2U0Smph?=
 =?utf-8?B?a2ZZMENHREFLeEJrdGF0eDcybTNNeG5lcFErejlQYkFxN0ZHd2VyZDZwdmZ1?=
 =?utf-8?B?R2djS2V3cUVWYVlCRi81WjgvMmNWdnkzeDJKa21vMjNiNDdRUnJ0SXR4OUdU?=
 =?utf-8?B?QVZwK093OGRIU0xrYXl1cWhjV0FvSjhiVGZHc2kzWGJYZzU5Y2kyZzhackVD?=
 =?utf-8?B?dXpYY3o0aFlQaWhHMmkxa2YvNStsa25Qa3paTzVxRTEyNXlUNkFyT3F5cVZE?=
 =?utf-8?B?UDcxTGVwN3hLd3hVTzh1cCtYNzNBY3FOdDVMRUdFOU5lYi94SDROeUxlVEJr?=
 =?utf-8?B?SmlLYkQ3dFhaOFV3ZHVEaU5FQmN6R1dmZjdCa2F0TkxZTE51UUt6OFNWNnJw?=
 =?utf-8?B?VzY1c1FGWlZkVHh2UjdtcWZLVHpjY0hPM09TN2xuNGxzVm4yQ3dSa2YxM1dr?=
 =?utf-8?B?REVkUWZBMzJYMzRsWnhKYklhQ0V2SCtGenEzNGppemw3dzZ5TTFtTFhTbHZR?=
 =?utf-8?B?bU9rdzRmbFRocDMrWlU5RUVQMVFxb0Nza0VlT2JkS3hNYmp3TVpTYUlkU0x2?=
 =?utf-8?B?TnNYOVU0eHFWUWVxa3dFamFTc2E2dkdtdktLQmoybldFYWxHZlRTRXkvSVQr?=
 =?utf-8?B?bndPRmJMYmFGUWJ2bktqaDZoMWZnZDhVa2tkNDdiMUdFcFFPYlFOaHZSc21I?=
 =?utf-8?B?bGxYOFVuNEZaWkdJNGVyZU9UWmM1a3dZTUNHemxTOHF1SkpqZStpdE9TK0ZY?=
 =?utf-8?B?VEVSVm43VGxVVjB1dUo2VS94Qy92RDFTNVcyMEZnY08rQ3dWdDM0cDNYOFVy?=
 =?utf-8?B?T05CQnJXcmdsWkxMNzF4a0NoRWUvRVJEL0IwOUNVanBaN0t3WHI4VVJhMnhC?=
 =?utf-8?B?dEZoYzZRMmJHTlp6L09XSVJYdVcxN050MU82NmRiWXdOZ3ZiK2hGNklzTnJv?=
 =?utf-8?B?amRkd3RQUWVXa3J3bE1KSUhtdnRXRUQ4aGZ2QzRVSjg4U2E0ZzR1a3VCamFp?=
 =?utf-8?B?YmhnWHZYQU5VcCtBc21MckI0cE9DQVJaOUhFQk1mMjdyak5NZnNSWjY1VExy?=
 =?utf-8?B?MytmVmtXUThsWXN0MDlPeEFYV0tUc1U2eTZQNXplTGF3cHRmNDh4N25FT3h6?=
 =?utf-8?B?RHJaRDQxaitScGxzRUR2MG5iRGJTNVJ3alNSMUlkbno3LzlHajFjRHJUNTRI?=
 =?utf-8?Q?js56T9M4BEzv0ZNATp/O?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(366014)(1800799022);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0lrekZ1dmJkVHE4NFNsMjhRbDFXVGtFTUtXbkZLTUZpL3JLa1pLTlZiMDRL?=
 =?utf-8?B?THlFMnNmMHpqckx4RFIyZWExdnpncTJuRzZmT0ZXZURVSE5JOVl4QzM0Z0dE?=
 =?utf-8?B?NmJ0NGU0dkZjUTJpVzdEa1Nvd1pEakxVV3N2OTFuZk1kUkJOT2xVMWVFUlBY?=
 =?utf-8?B?MHRwVGNhT0Fyam92d1JWbXhUYnVaL0JXV3lKRnYzcEhhZTU4SFNwZ08rODRh?=
 =?utf-8?B?RGtOcFAvOStOb3pUZW1kK082eHBuTFd5TkJHL05hM2N2OTNEWlMvak5CTzRy?=
 =?utf-8?B?R3VFZ0lqdktpYWY2YTFId2NwUEhYRGxSaUtFMkZrV1hDOC9oTVJUK3cvNjA2?=
 =?utf-8?B?T0tjT0xXNDZpcG1XaTBQS0F1RWtHOElWK2dEMnVxOXh3UkpVSVRVeWVkTXhF?=
 =?utf-8?B?QStaOWE4YUloN3dGdWhkUGRPMk42MnBtUkQ1QzIrUFozTWNhNU1LQ203bXdh?=
 =?utf-8?B?QVBEQ1hhWUExekFjTnU3bjlKbm0yVGplaHNVNmFvYi9FaEhTSGttRXBKMERM?=
 =?utf-8?B?akp2OEdsM25nUG5BT1RINEtRV0hLVThYWWxSN0tYUzJEeFgrMzM5V3VURFVi?=
 =?utf-8?B?Y1dJbm5hUHNqcDVRSTgrUFNNY01jS3h2ZGtSc3JKL0NzTUZxUldCSHJhbzF6?=
 =?utf-8?B?TE9TZUJpMVZDeGp5T3FzRmJoaW1BZGpOSzJIVVFudHJjT2szRXdiQVYxNS9p?=
 =?utf-8?B?eUFiSnQ1aVhzaE1kbkVoZERkKzBKOW1VMU5jSFRveURRL2VydEJkR2NlQTZ3?=
 =?utf-8?B?T01nakZyeWtlNUtWVXlsbmF6WDcxTmdUTm5UUUFYMmsvZ3FROWNEbHoyZ3Jm?=
 =?utf-8?B?MWFBT3RYRG5Ca1BVdWFjQjlYUDVKTEx4ODQxN2NRQ1JZNjArTzMrMWhVYnJy?=
 =?utf-8?B?T0RwRlJXYjViVStWeUZVZGR4ZWIzRGp2TmZxcXpYdHZrYjhLUDQzQjgyNE9n?=
 =?utf-8?B?Tm5VWExLbGNiVzFudERoUE8yZk1SeGlJTDcvSjRYeEY0UkRsNW1sUDdyVXZ5?=
 =?utf-8?B?Q2wwOUUxUkpUUnNBYU5oSjdlZ2Y3azlHcVhKQUxHZHdMNDl5TXc3OWdjRUYx?=
 =?utf-8?B?OXMxVTh6eWhzRVpPSEZMd3gwZTNHaXFIVk8zWS8vVW9uODJkWlJXTWdRdnpr?=
 =?utf-8?B?UWZtcG1uaGp1a0tVcTJBVXBCbVlYZitrVTQrTk9ybHV6MjQ4a3NjSGdJYWlj?=
 =?utf-8?B?YmpjRVJEMTQ3aFdaRWQzVXc3N0VLQ05wd2VITUY2UVJ4Nkhsb0tScFdQNVpQ?=
 =?utf-8?B?K2s4a3N2Y2pjV2RmRnJsTys5UzNFbGozRUNTSDlXZmRWL0U2M1J1WDd1Und4?=
 =?utf-8?B?Lyt5ZERGbmNXTWh2ejFlV1V2MmJ3R3hjb1F3KzR2NjF5bnBRVVh0ZlF3cXIz?=
 =?utf-8?B?VDZyWkkzSjg1MnBmMEJBb3lqMjBzNTQ1V3llVE1QM21PVXVocE00aFVuMVE1?=
 =?utf-8?B?S0puaFgzRVozMFhkdURUTVNFc2ZKUjY1T1dJOXJZdlNQUHVad1ZOMXdyUVZE?=
 =?utf-8?B?bEdrb1JCMnZINUlVMEU1OFFubnd4YUFFTjh2MTFtM0hKOHRtSzZPT0ZRTlkw?=
 =?utf-8?B?YlFoQUU3OVNlNUJtdjh6ZFZ1RjhLUkRkVXh6UzVCbWVQMmRmOVVnVDNRd0ox?=
 =?utf-8?B?bkxXRWJ1d0l4bUR5RVpkQ04rZkJyYm53VkJsU1BnRlVxL2duaEN0SHFGNHRj?=
 =?utf-8?B?bzRKL3hsUWJzSzd0YndPUWZXQWkzZFYvM3NSOE9QRGZCVHcvcHhYWnFkYnAv?=
 =?utf-8?B?bTVQaDFybUhPbUhFK3g0ajRBangzRCtRSTZNVFJaYjBOT3laK205OFJHeUwy?=
 =?utf-8?B?Ui9WSk5XbFBCU1lNRXFCUWFKdHZQSXRSdmtsd0lCNm9YcWpaWng5WE1tWG1k?=
 =?utf-8?B?RjlEbFFkYlJXT0RpRWd6ZzdlcWRBdUp4bzM1YnhFeVFLRkI1cjVkTVhXMEtV?=
 =?utf-8?B?cXZBTjFNZDU0OEsrU2dQYVhOdUVwQXVlci9PbXRlSk1QTkgzV0dnK2Y5dWtM?=
 =?utf-8?B?ZXh2MUdIWGhjSlZLRTJ4L1hWMzE0YjZlR3hNaUY2ZlZBUFdWa2lGUGI0Z0l1?=
 =?utf-8?B?dmxkbkpQQ0xKOUNnTi9JZkVUUkZOWjk0d0tuY0ZKUkxPbHVwZlE1N1BQbGZs?=
 =?utf-8?B?SmVaZk1kUmYrQUdoQnpsRGlRY2JrZzFQWG5vd25qZm5QM1pJUUxPVFpNYk9W?=
 =?utf-8?Q?ALnQA8kfITkidN8LgHuW8dI=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a28538f3-ccd2-429f-466f-08dc95f1f210
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:09:16.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJtgtoWa9VEPw3BnS6Y8G8zhScfYRHKz679iqq1JH3rRZkE1OCqH5fS+K46nIvLZWGVXYC0E4r/A5sG5070FQq9+Sjnz3sKK1PBrxmfGs/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 26 Jun 2024 15:09:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/381

Hi Trevor,

On 6/26/24 3:56 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Add an example of implementing rauc on a rockchip board. Adding the meta-rauc
> layer, adding 'rauc' to DISTRO_FEATURES, and enabling RK_RAUC_DEMO will build
> an image using the example provided in dynamic-layers/rk-rauc-demo.
> 
> This example uses a simple A/B + D scheme (i.e. two root partitions and a
> non-updated /data partition). Repartitioning occurs automatically on first
> boot thanks to systemd's 'repart' mechanism.
> 
> NOTE:
> - this example only works with systemd
> 
> If you wish to provide your own implementation, simply add the meta-rauc
> layer, add 'rauc' to DISTRO_FEATURES, don't enable RK_RAUC_DEMO, and provide
> your own implementation in a separate layer.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> v3 changes:
> - change the OVERRIDE mechanism from a class to a config
> - fix the required features check to include an OVERRIDE
> - use a systemd mount unit for the /data partition
> - abd-partition recipe cleanup:
>    - remove extraneous FILESEXTRAPATHS
>    - remove OVERRIDES, this recipe will only be used with rauc
>    - remove extraneous FILES:${PN} for ${sysconfdir}
> 
> v2 changes:
> - add information/instructions to README
> - rauc-conf cleanup:
>    - remove ca.cert.pem from SRC_URI, it's already in parent
>    - rename systemd.conf.in to system.conf so the parent handles it
>    - process the system.conf file as a prepend, leaving it for the parent to manage
> - use walrus operator with THISDIR
> - break out the systemd repart config files into their own recipe so they can
>    be updated without triggering a full rebuild of systemd (and its dependents)
> - class cleanup:
>    - update the classes so they have only 1 job (each)
>    - rename the classes to reflect their jobs
>    - update recipes/configs to use the new classes
> ---
>   README                                        | 18 +++++
>   .../rk-rauc-demo-features-check.bbclass       |  8 ++
>   conf/layer.conf                               |  4 +
>   conf/machine/include/rockchip-rauc.inc        |  4 +
>   conf/machine/include/rockchip-wic.inc         |  2 +
>   .../recipes-bsp/u-boot/files/boot.cmd.in      | 51 ++++++++++++
>   .../recipes-bsp/u-boot/files/uboot-rauc.cfg   |  8 ++
>   .../recipes-bsp/u-boot/u-boot_%.bbappend      | 26 ++++++
>   .../base-files/base-files_%.bbappend          |  2 +
>   .../recipes-core/base-files/files/fstab       |  5 ++
>   .../rauc-bundles/files/development-1.cert.pem | 80 +++++++++++++++++++
>   .../rauc-bundles/files/development-1.key.pem  | 28 +++++++
>   .../rauc-bundles/rockchip-rauc-bundle.bb      | 14 ++++
>   .../recipes-core/rauc/files/ca.cert.pem       | 80 +++++++++++++++++++
>   .../recipes-core/rauc/files/system.conf       | 17 ++++
>   .../recipes-core/rauc/rauc-conf.bbappend      |  7 ++
>   .../recipes-core/systemd/abd-partition.bb     | 26 ++++++
>   .../systemd/files/25-rootfsA.conf             |  4 +
>   .../systemd/files/35-rootfsB.conf             |  7 ++
>   .../recipes-core/systemd/files/45-data.conf   |  6 ++
>   .../recipes-core/systemd/files/data.mount     | 10 +++
>   .../recipes-core/systemd/systemd_%.bbappend   |  3 +
>   22 files changed, 410 insertions(+)
>   create mode 100644 classes-recipe/rk-rauc-demo-features-check.bbclass
>   create mode 100644 conf/machine/include/rockchip-rauc.inc
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/boot.cmd.in
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/files/uboot-rauc.cfg
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-bsp/u-boot/u-boot_%.bbappend
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/base-files_%.bbappend
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/base-files/files/fstab
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.cert.pem
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/files/development-1.key.pem
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc-bundles/rockchip-rauc-bundle.bb
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/ca.cert.pem
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/abd-partition.bb
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/25-rootfsA.conf
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/35-rootfsB.conf
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/45-data.conf
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/data.mount
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/systemd_%.bbappend
> 
> diff --git a/README b/README
> index 6003e7c652fe..8ff006e942b9 100644
> --- a/README
> +++ b/README
> @@ -85,6 +85,24 @@ Notes:
>   
>   	in the configuration (e.g. conf/local.conf).
>   
> +  A/B updates with RAUC
> +	This layer now contains one example of building an A/B update using RAUC.
> +	Users are free to use/test this example, to optionally enable it, to build
> +	their own update strategies based on this one, or to ignore it completely.
> +	This example only works with
> +
> +		INIT_MANAGER = "systemd"
> +
> +	If you wish to use this example in your builds:
> +	- enable 'systemd' as your init system
> +	- add the meta-rauc layer to your build (with the corresponding branch)
> +	- add 'rauc' to your DISTRO_FEATURES
> +	- enable RK_RAUC_DEMO in your config
> +
> +	If you wish to implement your own RAUC update without using the example from
> +	this layer, perform the same steps as above except for the step enabling
> +	RK_RAUC_DEMO.
> +
>   U-Boot Environment:
>   ------------------
>   	In order to configure U-Boot to be able to store its environment into the
> diff --git a/classes-recipe/rk-rauc-demo-features-check.bbclass b/classes-recipe/rk-rauc-demo-features-check.bbclass
> new file mode 100644
> index 000000000000..946091802f8d
> --- /dev/null
> +++ b/classes-recipe/rk-rauc-demo-features-check.bbclass
> @@ -0,0 +1,8 @@
> +inherit features_check
> +
> +REQUIRED_DISTRO_FEATURES:append:rk-rauc-demo = " systemd rauc"
> +REQUIRED_MACHINE_FEATURES:append:rk-rauc-demo = " rk-u-boot-env"
> +
> +# 'RK_RAUC_DEMO' indicates the user wants to use the
> +# rauc demo configuration from this layer
> +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"

I don't understand why this is in a recipe bbclass, the one in 
conf/machine/include/rockchip-rauc.inc should already be enough?

[...]

> diff --git a/conf/machine/include/rockchip-rauc.inc b/conf/machine/include/rockchip-rauc.inc
> new file mode 100644
> index 000000000000..a6f79503076b
> --- /dev/null
> +++ b/conf/machine/include/rockchip-rauc.inc
> @@ -0,0 +1,4 @@
> +# 'RK_RAUC_DEMO' indicates the user wants to use the
> +# rauc demo configuration from this layer
> +OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"

[...]

> +do_compile:append:rk-rauc-demo() {
> +	# create boot script
> +	sed -e 's|@@KERNEL_BOOTFILE@@|${UBOOT_EXTLINUX_KERNEL_IMAGE}|' \
> +	    "${UNPACKDIR}/boot.cmd.in" > "${UNPACKDIR}/boot.cmd"
> +	mkimage -A ${UBOOT_ARCH} -T script -C none -n "Boot script" -d "${UNPACKDIR}/boot.cmd" ${UNPACKDIR}/boot.scr
> +

Richard has said today he'd prefer we don't use UNPACKDIR for that kind 
of things, c.f. 
https://lore.kernel.org/openembedded-core/20240623213254.3215897-1-leon.anavi@konsulko.com/T/#md4b10cea4af07c1a2e5be43e4ee8c8b1fbc6e420 
(though we "agreed" later in the thread to use ${B} instead of the 
originally suggested ${WORKDIR}).

[...]

> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
> new file mode 100644
> index 000000000000..4945c67345c4
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/files/system.conf
> @@ -0,0 +1,17 @@
> +[system]
> +compatible=@MACHINE@
> +bootloader=uboot
> +data-directory=/data/
> +
> +[keyring]
> +path=/etc/rauc/ca.cert.pem
> +
> +[slot.rootfs.0]
> +device=/dev/disk/by-partlabel/rootfsA
> +type=ext4
> +bootname=A
> +
> +[slot.rootfs.1]
> +device=/dev/disk/by-partlabel/rootfsB
> +type=ext4
> +bootname=B
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
> new file mode 100644
> index 000000000000..281eb2c4de91
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/rauc/rauc-conf.bbappend
> @@ -0,0 +1,7 @@
> +inherit rk-rauc-demo-features-check
> +
> +FILESEXTRAPATHS:prepend:rk-rauc-demo := "${THISDIR}/files:"
> +

I would recommend renaming the directory to rauc-conf here, but that's 
just up to one's preference.

Looking good otherwise :)

Cheers,
Quentin

