Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F96C3ABA9
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 08:40:15 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.88])
 by mx.groups.io with SMTP id smtpd.web10.13613.1745916012149724770
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Apr 2025 01:40:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=jar6gZbX;
 spf=pass (domain: cherry.de, ip: 40.107.22.88, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHDwauhYFg831fxcGgjOA5flonnn1USjmwfyO6Twv/ZtT6voE3tg2gkDtZk9ZIwuRvE14mHBcnoID69IY5RvHk9eI1up4Jb+Y+nHuWnN/spCHdw9oRAoCqmO+SQC0mKyq+111HIvP6DIgCv+hrk4zVhXOx8j9Bl/Bu1SMgnggzSocbJuRcgxTiLC1N6LvY9lSZObog/ct5SVs5PgKGOMjppDAhWMx25WaEa5+aEL+Yu3F/wmPCSfq5DPD8sG+woNFOcO/vx5/F86axdw5IVf8Tk8SgJpaAIqh0Uc8iHmqI38L5Pz4ZKEerfYrz9u9mvaE0GJDtuG0iwv5Yh0hEpOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48vsntABIuH/9myeff9i3NEuFcVfS1ZPVf9+lhKXP4I=;
 b=pFSAXnPXH8yoiznltKfS7P6Va/LUWxUDX6rSgiGUlquxXpxf1Cjpa3Q2xR2CvL7X2kLFJtgxvap8HVfOmMve3zEu8DVI/gPcxf9WTtklNp7b0v4l0d+w9NT6FHb869gHilojN+Tel2XXRxYt+wymammaWgGbs+KGxxnc2YFB2YWvkMdOgyr6kbr9bTN/5oho/Gl9oMX1PXggJa7JmyfoR2SGcIkkr2Ol6kLkcWx7fDKFnp+LT+9qVQCpq5cgblbDEVWo46HoM+eDLuZZdzUf/h+W9Y8BatKFp3LNJ32oHCpHdPkW2bk0hhp7TMPu6ddRFuRBU5oouSZi1GUTrX8rKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48vsntABIuH/9myeff9i3NEuFcVfS1ZPVf9+lhKXP4I=;
 b=jar6gZbX1JEcZGTKWbgqtywkpVXSFvwVmv6oOSZYnJaA4vVGJYw9qsaF8kB3oUC5qC/wUjWxiS3bjQH1wKaSR2Soy6d6djLsqwVtKE27tlZ2SqeYBRHgthrhyVGB8pyKFzjKW3/ewK+PNk384rF1oTRka6g2xg22Wykv25OOHKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7086.eurprd04.prod.outlook.com (2603:10a6:800:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 29 Apr
 2025 08:40:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 08:40:06 +0000
Message-ID: <897c2e80-3df9-4be8-8996-47fcf7c56d3e@cherry.de>
Date: Tue, 29 Apr 2025 10:40:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH v2 7/9] bsp: rkbin: tf-a: factor out
 do_deploy to be SoC-agnostic
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20250418-ddrbin-custom-v2-0-700828527faf@cherry.de>
 <20250418-ddrbin-custom-v2-7-700828527faf@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250418-ddrbin-custom-v2-7-700828527faf@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c6bde4-ae89-4084-f515-08dd86f97188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZWgyeE5qcDgwVGhQRjR0S09zNDBPUHJLK1dLd29IVlNBeUZvckNzUzBtcUl1?=
 =?utf-8?B?eGNUeDZLMkJlcnpLcEcxVXVOSm1JUnRsTUNFNTVDZ0RpTDcwOWdNL3hoYUtK?=
 =?utf-8?B?ZGV0cHNDRDRkQlFqZEoyWkpndUVYUHVUWnhOcTcveEY4QkZxb1NxeC9sZlQ4?=
 =?utf-8?B?L1o3bEcvUSt1dzNUendmUEpsUTZyeHU1cSswa1lTL0JINkZxM0lLc1NaK2dz?=
 =?utf-8?B?dFR5VU1oQ2g4MW5nVWVhN3VENU1IMkxxVFdqUE5VVDRoOGNCTGNlbkFVWG5E?=
 =?utf-8?B?aDlqVVBJMjR6ZTNDUE1sZWNLR0RzM0xxVitzTU5IcitUVkdtVkJBWkZyejhv?=
 =?utf-8?B?TEoyWERlRW9GTmVDM2M4QzN2aFJLK3F0OHhGSS9ZbkdDcjFlKytRd3o1WW9j?=
 =?utf-8?B?RXlFWUFrSmZrSk1wZ2Z5eXN1RFlXeXBubUNsU0VlbGdQb1NHSGRCS3dycW0x?=
 =?utf-8?B?OVZnR0NaRUVPNitEMW5jVC9yTlFnMEw4Y0pTNGpyU3VaQ2NkV1Z2MGpycm00?=
 =?utf-8?B?czQwSVkxSHlpTEY4Rk1pY24rVWZTUC8rTVB5MU9NY2luNU5FaVJyeEgwTXVN?=
 =?utf-8?B?WjM3N1l0RmtEUmdVNVJ6SlpwZnZvYStOdXZ3M1JsM1h1MDZFd2lxNFB1VWl3?=
 =?utf-8?B?NklDQVlLTTljazVtV0ZiYVJvcjlnMWxWTU1UZWo1MWRJejlrRzNycjh3eHd4?=
 =?utf-8?B?WGVZdFVqcDlXQ1ZzNm5mWmNuR2d2TjJUQlhpVFZpVi84U1V6a0xhTzBOYVRI?=
 =?utf-8?B?TGNZUE1OMDJ3N3Z1VVdUNFEvbEQvZUJxQmtvRXhqWEZIeUhwMzRJUGdkRW1q?=
 =?utf-8?B?SmpHbnBqQTBNT3Z6aXYrL3l2aVZESHByR3dHRDBXTFBMejJZOGpNMWlvOW5P?=
 =?utf-8?B?QXFNYkdTaFZuem91UHB5MFJhbTY1VkpwaHRZYSthS3ExYlU4MWRjckhYa3FK?=
 =?utf-8?B?RWVWaGN5cHo0enBmM1JKOWRLSy9GQ290VWp6MVB3NUxidmQxWXFUcXpXNkhv?=
 =?utf-8?B?cllPR0puL1VLWEE3TWEyV1FldWtOK3IrTS9oTzZkWWc5RnAxdld5M0QrZmkv?=
 =?utf-8?B?YTJzaDc1Wnc3NDV6RzlRdkNwYmc2Ky9aTjFCWk8zeVArUnFIUzFDQ3dFK05i?=
 =?utf-8?B?dDZLZ2xXb1VTNE1Ta2RQZmxNSkFoZWt3S3UwZGFrTWlOVEdVbXNPM1NRcmhF?=
 =?utf-8?B?cDA5ai9TamlNRzd1OWJEZFBVSGxlYVFTM2ZLM0lRNHc2RGVOVkZKY21mV214?=
 =?utf-8?B?SFpudFN2R0U4RHNWamx5b3lEcHRMQXVuZVFpQXJYOFhiSXpMeDJwU1haZE5j?=
 =?utf-8?B?RHNudklPNy9HZUdETG9GWGRMN3JLZUtpV29nekorcTJ3UTlxZTVaWlI2b3p1?=
 =?utf-8?B?SUlSUXg4VGJEb0xJL2V4VlZHdjF4UlJOY1RRZ3pPZmlTTTRKTDV3THZlSHRw?=
 =?utf-8?B?QXcwQ0l5ajFyaVczODRvNCtQYVJ6V3NNL0tvOXNoOUk0NnpDQlgvWk03Q0s4?=
 =?utf-8?B?VHI0N1Z6a2tDai9jM1pPMmNoVWtwM1dZWFVwZjN4NnNhR2ZMenVMN3N1NU5R?=
 =?utf-8?B?bU1DaGpZazVPbUE0OHg0M1dLdFF3eU1acXZ0K3BDM2hNclVnSTNhWTArTXBN?=
 =?utf-8?B?ZUlqZnpUc0JoaWRMWVRMbGxwN2N4L0RTMmkxNzVZNk5WZW12UlkybDFQbDZ6?=
 =?utf-8?B?YmZtd2tkVnBRcjhxNThQdGZoY1gwLytqVStKdG5RdjNHVEU4dE13VGxFbGdq?=
 =?utf-8?B?TmdlM1RsL3laZlAxQ3hsbFJIMmVub3ZRODFCYXUzRGRrdTJkaHBKbnBkdnlk?=
 =?utf-8?B?QzRDTi9hRFlKMG1oN0pFSEM2cXVuSDZZMmFvZzEwMHhqTng5WHcwSk94Rncx?=
 =?utf-8?B?ZnZlRXRKaFJnL251bTJXdkNNT3VLTU5YMlR3UTRONDQzbHFaNDJ0REZ0QzFo?=
 =?utf-8?Q?tVZDPNdATQ0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YmU0Z2tlMzFXemE0Q040bXh5N2o2bDd3Q2lSNzdjMkZrelZTajJ3enR0TG9w?=
 =?utf-8?B?UThtSCtoNjN3M0thUHVlcWszRUIzOTMwbCtYOEVoSndkMk84dm1RVTY0Z21i?=
 =?utf-8?B?ZFYwdnFNNEZDRHRicVJra0pqREV4dURFc29paHZvS21YbG5lcUdkTTBRQVE1?=
 =?utf-8?B?NnlTRUlJQ2lTNkJRaTUrYVgyK2tRTFZiRXNWa1VwN3pIelRrbnhvTUVoWlg5?=
 =?utf-8?B?ZDNyY1UweGtjaUx3aUtOdU5JTnNyY0tBMlBuNkdXUVJmYmZjS2Y3b3Z6UWVJ?=
 =?utf-8?B?N2lpSysvbFc0cHRmOURhbEdvV2JjTnJjd0FhYmNEUEdkcjRuWG1UK2t0TXo2?=
 =?utf-8?B?OHBqWTlFQ0xGZWQ1clMyUlRCSTlsRmdZNktNK3FrcnBkNktvWGN6YmUxTnR0?=
 =?utf-8?B?LzNtQjBUZFdPWEtRTTdpQThJMnZDc0h0U3d4NlNiUHRQVDgwMTZ2eXlXb1RP?=
 =?utf-8?B?Z2NsTnBrSUNPM1ZSSU1lYmV0bzhoamhoVm1QY3hNdm1XcCt1YmNtWEdBOU0r?=
 =?utf-8?B?NTg1WDFieUVTWVlvaGl3VjFUbG1ZT0dWQWMvbE44SU01MWU5Vnl0dXVGcUNV?=
 =?utf-8?B?dHhLZDU4cGV3TVRPV3NlZ0xDd2tNeG9HWEkvWkxMYmhqcjZ3V1M5R3pEeVN0?=
 =?utf-8?B?TVJ6bDFZMEJqU0N0MUNlbFBjNzhJMW9paXFCR2N4L0RURHNiYUV6cmtSMkRF?=
 =?utf-8?B?SGNRN0F0dWFOTW90cTVBR2l1UlZJcCtKZDdIYXM4eUFHUkFsM3kycmpuK0dP?=
 =?utf-8?B?bDAyR3JMbXlHL2w5VjlWcFJBMStkZHdzelFjQ3Z2bWcwQnlCUTkyMW9HT2tp?=
 =?utf-8?B?ZFQzL29RemNLaUhKc3A3T1c4NktpbDcvZUw3SmFteXpHSnhmUEJUclB3aEMz?=
 =?utf-8?B?SEVKTGtPNjJqVXd4d0YzaEk0U2ZwSzF2THZTbHJnOWVJWmx6Zno4bGtNR25w?=
 =?utf-8?B?VTRMUWNSV1doRWp5d09oaEcyeFJIZEVCODBjS3BrZm1Hb1prRzNPdnlWNWh5?=
 =?utf-8?B?NjFEa0NIakNSa0E1T0lzWVlTVWk3TmI4QjAvRFBOSDlQSmpORmdRenBsdWRW?=
 =?utf-8?B?QVlDaGpONE4rcklvTDA1V0xsb1lMbUJydVdPZ3hRZk54UUJzZGFmR1VtTEJh?=
 =?utf-8?B?bmFDd2NHaG1BZGJQTW91aFpaUDVOUTJvMVh3UHlGaHJaWXNRS1k1M0tOYzhE?=
 =?utf-8?B?ZWVuY2xrQnpDVVhySVZQbGY3NElzaWRiNmh2ZE02UmtSYU5WN3N6TW9iTDRm?=
 =?utf-8?B?T0FMOXZTMWpXR0hvSmJnQzduTXdxZytRWUtpOWhkNXlXMlZmWVdMU0xpb1d1?=
 =?utf-8?B?dUJMTE13dWwwZGEzaXhUd0NyRzYwV3B1TFgxK1AwSktiMEpsQ0xpSnhVMjJz?=
 =?utf-8?B?VGNCUHBRWWl4WXltNXo3Rm5uVks5bmR2cTdEVWtZbWUwaFI3NU9ndDRja3JE?=
 =?utf-8?B?bElwS2doMWJ3aXpMZzJYKyt0cDFndVhIVytsbjFMZ2tSZmd6R2VVK0VTeXEx?=
 =?utf-8?B?UTZ2VTN1VFVxcGJjVDdFcER0R21oRXZzZEhuYU9ReDBNbmRhMEI2UGkyczc3?=
 =?utf-8?B?aXQwNkVPVEc1RzdvWXB6RERRRWZjNllnUmdET2VhQUVuckdRZVRGRlkwNEtj?=
 =?utf-8?B?Z0FRQlE4MjRZbnNibHRXVjlhcEFPYXVMZkl0MXlJdlRtb0xzVkc4cCswOHlm?=
 =?utf-8?B?REs5NjlvenozV2wzenFnc1cyaTdNTUc0cDUvUXQyWXg5UEpwdm1XRmc5ck4x?=
 =?utf-8?B?RWN0dXpQYi9lRlVvQXA0cHh6dDR2TXE3Q0JGOG9aZVU1dUoxM2hjUFFvaGov?=
 =?utf-8?B?dk9oQ0QxbVNzMVgyNlkwMWgxWTVXZk5kcFpNU2x0S0p2cnJRUGJIUVhxemZp?=
 =?utf-8?B?Ky9YMEJXVk42WlF5MTd5bkJCcGMvcE13V2dWNTB0WWtBNHduQnBBUks2WWVt?=
 =?utf-8?B?UTJvU2VPQ09xeG1pUnZvVTFobDB3NjRKeEhadFM3RkQ0emMwNks5cXMxMU15?=
 =?utf-8?B?QjhLSmMxY3MrbGllUVJvYmsyR1dqenFCZVJ3R01CYm5INHhFOUwvNHg5KzNs?=
 =?utf-8?B?ejRaajZ1ZnRQVmM0U2tNamkwVnhycVRZRkE5dWRtOUhoWTBlUFRZRFJPMnVm?=
 =?utf-8?B?NHBKUWtDS2txSXhEc1ZyQWR2SlpDN3Q3ZXQ0ZXVQa1AvYmlUVXFMZm4ySCsr?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c6bde4-ae89-4084-f515-08dd86f97188
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 08:40:06.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkUrTdJMq2zfHJbRRc3E5JHzjFUDuQxsQ8l/zY3c/ZBOKPOxLACjkZIJTpB3IePxsEl/kRM83N6iYAxKfd/Y6FoTx25lz3nfY8l7np7jRnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7086
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Apr 2025 08:40:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1420

Hi Trevor,

On 4/18/25 4:50 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> The do_deploy task is essentially the same for all SoCs, install a file
> from a specific path to another one.
> 
> No magic involved, so let's rather have one generic do_deploy task. For
> this to work nicely, we check that all necessary variables are set and
> notify the developer otherwise. This may be useful whenever a new SoC
> will be supported by this recipe.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb | 46 +++++++++++++++++++---------
>   1 file changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> index 0ed28a2f18daae280fe38e6939f1b4742b29a778..e6c3199c9fc06aa88173aaa42f2bc8cd365551a8 100644
> --- a/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> +++ b/recipes-bsp/rkbin/rockchip-rkbin-tf-a_git.bb
> @@ -4,24 +4,42 @@ require rockchip-rkbin.inc
>   
>   PROVIDES += "trusted-firmware-a"
>   
> -do_deploy:rk3308() {
> -	# Prebuilt TF-A
> -	install -m 644 ${S}/bin/rk33/rk3308_bl31_v*.elf ${DEPLOYDIR}/bl31-rk3308.elf
> -}
> +RKBIN_BINDIR:rk3308 ?= "bin/rk33/"
> +RKBIN_BINVERS:rk3308 ?= "v2.26"
> +RKBIN_BINFILE:rk3308 ?= "rk3308_bl31_${RKBIN_BINVERS}.elf"
> +RKBIN_DEPLOY_FILENAME:rk3308 ?= "tee-rk3308.elf"

Someone clearly made an oopsie there :)

Should be bl31- instead of tee-.

Will send a v3 fixing that, sorry for the noise. Will test build with 
U-Boot now instead of simply building rockchip-rkbin-* recipes :)

Cheers,
Quentin

