Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643C5C25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 14:31:37 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.112])
 by mx.groups.io with SMTP id smtpd.web10.11176.1718116292166668445
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 07:31:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=XvGMUzdr;
 spf=pass (domain: cherry.de, ip: 40.107.249.112, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiTKY0ha5jzYZMEy/kI8ldUvF6cK4kk0pT7QdZ7kqkeAMAMG/4crW/sudpgobeuJLzDmijiSkThiNR77gBj4nbK+KLvzWSJ0r9aOo/DRK9akKm0wD9aZvywUHbHA1K6hud4PFf/eTOFiLkdong59KBg+uUOXQhqFcjD0+FjIQwvdATNCRhCWw8+zLnKVgbEyv0OoUvLZyXCZX2Z0A0qtlRF2MHG3/9DLC9l4U2jvfgmFl/fzgR5W18WwWRj3rUoM1f4hF9Owe1u1jU5wtFAMk2wgSNTNhGLw8ICidrBvJx0X8cKLvIFH2VrUCmjG8YJyWaumviG6qrBz967jpc6o4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIm58X6peEkvXXQ5wL7vE+kT2AyNhA6P+T5oVNpQZVk=;
 b=VB0vFOt7p31J2p5JbTp3oNPJpGgIoNXjFjV54umiPuaMpkYVyRc7aLMrje7aJ17mgZheStZLBvHgAaFZwgYvNaNlDl4PTNbQJeMLl2xR2KxNA4VcDtXHChCAeEO20qxk92LSd/1x+Gk6E0c38o5wesVxGnqDUNFukST72k92JOgj2RtWLnadHvSUkmYEU7KEHNrfwRl7KUPZ9fHFpClJdwxPBfndtlaGv8JgErbE5vdxbtAWlNqXqyH4BGXysfTH6nhEOyAURNBoAG+7oiP4xSmHpuqj1yqtWnrZAG2r0ScqpkXIlJ5OvWzoEJq9gupvYkZSJ1m/ak/0pmYcceinjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIm58X6peEkvXXQ5wL7vE+kT2AyNhA6P+T5oVNpQZVk=;
 b=XvGMUzdrQeGGNj25Cv98eDWIlbyBHfOUGCt7JxbG6LK5sdQY7enPMWJLY+cRlHFkMjQRmx9Xk3f3855UgD0Ov3ugnzVrBVyeutUzpwYoo/Cob1Nlg5wnwstvHczRItZ2KrmK0cpM622eihk3J/hdLSFY45Ye2zl3pGYGpZJ2q/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 14:31:24 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:31:28 +0000
Message-ID: <61fc0c47-d17b-4254-832a-83c4c9d37c97@cherry.de>
Date: Tue, 11 Jun 2024 16:31:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] user-selectable wic format
To: yocto-patches@lists.yoctoproject.org
References: <20240611141540.4209-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240611141540.4209-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3ef8fd-1a0d-4503-b9e6-08dc8a232e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d2dsL2VvK3FJV1lubkw0RDFMVHRsQ0xab2k0Wk9LaUtXb24zY3ZzMDRpNGxl?=
 =?utf-8?B?M1Q3MWdCT09BK2Y1a0hNUlBKYiszRTJBVThjL1I5Rzc3dldjb1FJdjhVR0l5?=
 =?utf-8?B?QUJ1TWNySmszQlpmOEo4eUNxRWV1dUxlajhxcGkzenhQanJ2T0Q2WU9wVUUz?=
 =?utf-8?B?NlErV3I4NmNUcjNEMzEyVzhHZ0p4NzAzQmNaZ0VxcVBoWVRMWndhMkg5WkY3?=
 =?utf-8?B?Tk1xamk2K2hoZjI3RlRnZHFIV3V1RXRnOHl1VEJiM3pCNndlTjl0OXY0amlI?=
 =?utf-8?B?Umdjblhsalg5VWV1QllLZGxISlpIUVVocjd1Q2V4VGpCYXRONmJZVjIycUdL?=
 =?utf-8?B?SGxuWU9lMGQ1VTIrOWFCYnBYZ293MFdxdk9rK3pLNkRYRHZUVzhISkkySkJP?=
 =?utf-8?B?MlNKV3lGMWM5TXZDY3ZkR2djOG9FQXlvQkhpblBlU2N1dkV3VGEvSEZOcUdt?=
 =?utf-8?B?WC80L2J0V05YcUNIL1lVYUtIdG4xWGRVQzdiU2UyRlZMT3JCQlowa0FrN29T?=
 =?utf-8?B?NGMxY0xZL0Q1enV0eVhGUENuTjhqNFVySW9OZ2tPSkVlQm43a3JSYlp4ODVU?=
 =?utf-8?B?MjFoTjBxQVN0RVJtdEJ0ODkzYXpCaDJKc2dtcHRQbWg5dzVMd2ZZRUZDR3Bn?=
 =?utf-8?B?VS9QQWpOdUROOW9XVnZtZVV1UjJ5ZDBUaTREV3lBaDZ4OWpGWHhLUU14a0ZK?=
 =?utf-8?B?NG1mZEh4NGUxbzhHZGx2MnVEUHNKbFJMbHdmL2FxaXE4ZEc5TGY0Mzdta1Iw?=
 =?utf-8?B?VUhheDZzYnFFR3N5dTZvQ3UrYklXRTNDajhrUGlzSk9DOFJubmpnQWFSMTBz?=
 =?utf-8?B?NnM1M04xWC92OXpYYnJHNldORFdERzdzWVRUMEp2MnhGZTVNenlIU204Uzls?=
 =?utf-8?B?NWJMUHZXZjljd0xxNGhvckh5WnlUdmo2WXlGdmdiNEpYRmc3S2FlRjJOeW9u?=
 =?utf-8?B?V0VyYjNUTGhOU0ROYjhnamtJL2tYTnpoeXJKcHVqQyt4bXI5UDQyMG42WXk5?=
 =?utf-8?B?b1poVG9FRU5DM1NNdm5vRzFsU1VFcXhPTzh6OVhIcTJCelpabjF3MGF5bU5o?=
 =?utf-8?B?ZUQ2RjZqQnRodFFuTXl6ZVNJVlQ5b2hBbkpVTGhwUDhkdWN4Y2FPR2xvTkZj?=
 =?utf-8?B?QXFEWDIxMStIVVk3MUErS2VRbTZiQU5JVUhCUVFycFNGeTFEZUlGQXBmQ1RW?=
 =?utf-8?B?SjlVRFpCZ2JleFp1V3RuOWp6YWs5bjBnUWhWRzB0NXRXRXV5VmRqODFBWmw4?=
 =?utf-8?B?YllCZlJYTmpVM0o0bW0wSlYzemtqSmhPUTFUbkhGaDFlUTNhSVhEdHp3djh1?=
 =?utf-8?B?clB5V0JYZTE1VTdBWXdjS2xRRldhbS93TjFFc2piVE1wZ2tPRDloaUZ6RHdS?=
 =?utf-8?B?bzhyOUlUQWVXRzZxUXJNVzZFbDY1azdVbmdEcVFvOEcrcGhCOE9uQ2UzVFJi?=
 =?utf-8?B?aFlOYzRsYlpFYTQ3dWJLUDFmQ1F2dnkzOFlrR0pXNEloVmUycjBySVlKYTRT?=
 =?utf-8?B?cGQyWTJBWFpNRlNyNjloWWZSbkdac1FPVEdyeDVadHRQRitucEhodEk3UXNr?=
 =?utf-8?B?NXIvTFE2K2Z4RnFMOENsRXlWZC8yaG1iamVJa2NsS2lIcHBuL2Z4eTBZbjVW?=
 =?utf-8?B?a0g1RE5mMUJna3NQTU9JQ3lSMjZJY05raTdrTWk2Qnd1MVAxd3BhT21TS2RE?=
 =?utf-8?B?QjUycGRDV2VuU2RHdFRtZXZzSyszV2xzZkZTNFhhZGZjT1htK0t3cWlKM0tt?=
 =?utf-8?Q?h7IzQEwOALoYadZQUI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXEzdm1GQmkwMTgzdHJEMnBCWWtBSkhqVEZGK1RyRDBicm5zSUNNNU5yN1Y3?=
 =?utf-8?B?NGhqb1A3ZTJldnpxelQwZmgvWUxHTlNFQk0rTllHTnZubEVuL1hLaWNUdTBo?=
 =?utf-8?B?dW01dzBmaXpvellVSEQ5UjAwRnpDUk05QTdFL1duWlJKM2RPSEZLa3QwQzFF?=
 =?utf-8?B?QXdua3NJd3lmcUUvME80cEx4SlUyRCsvazFId252ZHZYZWIxbmpwNE5mZTZC?=
 =?utf-8?B?NWhIVHMxM0NER3lPQ3J1Y2l3c0tyV2NmdXMzTG1idmg1MHREdkhYNTNxbWRk?=
 =?utf-8?B?Z0xONUdmd1FKV0RXaGZBUmVtWUNlcjVzcXFrU3RPdnZWWC9Sc3BWQkRCOVA5?=
 =?utf-8?B?SkJOWU4rc1FtYy9odis1cVRQcEEyZ1NPbE5YNDVkdmRGZzAxMXY5RWZKTm0r?=
 =?utf-8?B?bFdSTmJlYU41U3B1RTIvSzRzUVBHZXZrQmRZYys3a3hDT0ZqUy9kK0hRazcx?=
 =?utf-8?B?VVJsUlVlYXpoaWlmRlEvYUxMRXI3cFd4dnVFbWpHRGU4citrSWpDVk8zdTdm?=
 =?utf-8?B?TXcrY05rbWgxU1gvbFFpdXRVRTBvNlVXV0JHZGxkd3FDZzVJbm1QVExVbnN6?=
 =?utf-8?B?R3haOVBVZWFUQjVML1FYRFJQRjY2aVFDRDd2NkgzZk9QOEhtbDFnRkZORGQx?=
 =?utf-8?B?U25EY0NIVm1XTzBPZ2lqTzVKdzNGMER1Ni9ieFRGdHVSUUNPMGJnT3dOS2tE?=
 =?utf-8?B?bWdweGpoTE9Gb1ZMSmxvMnVSUktzMTczN2daWm16K0pZaHNlY05Bd0Q4VS95?=
 =?utf-8?B?REJaY0JGU3VQRkJ6L0ZNQ05xNVNuY1ZrY0VyQ1I0MGF5MmdvZTlQREJrSnhk?=
 =?utf-8?B?SFNwOXdmWVNDNFFNVnl3U1F5dTU5VXRCazcybVJCOFppZWxRTFdnaEczb2s4?=
 =?utf-8?B?OEpFY0VyZTZYUndtaGhDNUFTSllNeUd6VEo1OUZrbW5QVDNLVURBNUg4Z3dF?=
 =?utf-8?B?eUJBUElERnRDOHlhenpBNnM2TzkvVS9GNll3aU1sdUYvYk5Idm9yYTRXVEpl?=
 =?utf-8?B?SGJUVDBVQlRyY2JuT29nUjdDUVdDYUxGT1ViZ1FXa0RJY2JGZVYzMzkwdFRP?=
 =?utf-8?B?RGk1ZEE3QzZFYUNCSnVYSTN6Y01UZmFHREJmZm9OZC9nbmFRVUhYOEpvbHFm?=
 =?utf-8?B?OFprcHBVWFB4L3Q0WDFia1kvVUNZdFZKTUlLc0U5Tm15QnZzNk5ndWJuRWp1?=
 =?utf-8?B?UlpoZkFBVGpqdGV5NWhMNGFycXd3WmxqOUwrbkNNd1Y4eU83MzBJQ1JycFdX?=
 =?utf-8?B?ZnU0ZUI2VjNLNjF0WmdwQkpmMmhBdXpidDVOMmgyRVhpc2s5QklldEVSOUxl?=
 =?utf-8?B?ZmVtVU9Jemc4SDI3UDhUeUhhUHppR2g3aEhOTGd0UmJxc296SW9zazRVWGly?=
 =?utf-8?B?TVFPS2N4U2pTMG5yMjNST1NZV3ZYb3ZTWWJucGFtU0JqeEdWQUV4WG1hVTJl?=
 =?utf-8?B?LzlRTG41cTNFc3VPTFZrWTFUR1cwYm5aWGhoYmJUNGt2Q0lIRVYxUTRQV1hV?=
 =?utf-8?B?RnJvcG1zekpMaWx5WVRjZ3hJWHhJeG1lTml0QzFYUWw4SkVmdmNzemxWVlhX?=
 =?utf-8?B?bkNXVmd2UFhrYWNiSmYxNFlwRGMxeDNYMVJqQm44VEhYd0owUDZwM2E5elZ4?=
 =?utf-8?B?TTdlUEFnbERHaGlBV29jWVV6QmtLQi9Vdm05cTdVOGpxYjBCcUZ3a1VHSnNT?=
 =?utf-8?B?bS9ycHQwSWgxRHQycm1kenhYNUhjR1RrVXlla2VHZTR5QldoeXdPNWVnR2Vs?=
 =?utf-8?B?MWdzeW1CSVhnRGR2V1BMQzJPL0Fsa0pvUzBLODdMVm9jaDdEaW1US0YwOFo2?=
 =?utf-8?B?amYzZVVBYWUyZklpWmtlczZUaVhZUkpBdkViM3RDeExOTld1Vkt5andoMjEy?=
 =?utf-8?B?d3ZMYXFHWlp6aGpiTHdRZVk3OTY5aC9CamgyZklVaEl6Rm1jbDliZkRvcXht?=
 =?utf-8?B?WkdRRE92Q1dmZjl4WVdWeHN1bkFhUkZSdm8xSTh0eW5iNm4vL2hZV25HQW5Q?=
 =?utf-8?B?L3BvT29Sdjl1ei9ieTRFMndERUJXeUNCWXlOdDd0dGFnaWcvRU02VTUwSldy?=
 =?utf-8?B?YXpCK0RlYmowNjVGbUkvRU91a3MrKzNCc3lYMnNUWHhyYTVHUENJc3dUdVFW?=
 =?utf-8?B?YjkyVHMrTDM3bmpwVENTOHZPcWdPZzVkTVl2TWUwMUZJWGFTalVQdU5WdUlp?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3ef8fd-1a0d-4503-b9e6-08dc8a232e5c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 14:31:28.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhPK4u61oBMf2qiVQ8gTscJBDiEciXqwy/YdDt1fuBuY3+LgyHU6lbb8rsDzIT4i+fNimJ/6Bq4QUk4YOz1k8jiMmI87kWFafe81818xtak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 14:31:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/301

Hi Trevor,

On 6/11/24 4:15 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Allow the user to choose their preferred wic image format.
> 

Can you provide some use case for this?

> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   conf/machine/include/rockchip-wic.inc | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/conf/machine/include/rockchip-wic.inc b/conf/machine/include/rockchip-wic.inc
> index dab61d83ed2c..eb895cd0b4ad 100644
> --- a/conf/machine/include/rockchip-wic.inc
> +++ b/conf/machine/include/rockchip-wic.inc
> @@ -5,7 +5,8 @@ require conf/machine/include/rockchip-rk-u-boot-env.inc
>   
>   SPL_BINARY ?= "idbloader.img"
>   
> -IMAGE_FSTYPES += "wic wic.bmap"
> +WIC_FSTYPE ?= "wic"
> +IMAGE_FSTYPES += "${WIC_FSTYPE} wic.bmap"

Would this be a way to NOT have wic in IMAGE_FSTYPES? What are we trying 
to achieve here?

If so, shouldn't we also not build wic.bmap there?

Cheers,
Quentin

