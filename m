Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B810A62DD
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 14:08:31 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.2])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48250.1774534106947459670
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 26 Mar 2026 07:08:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=LL8msmmn;
 spf=pass (domain: cherry.de, ip: 52.101.72.2, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFJ4hsy0GSUb6/fWTE7ylKjQ/lVtX3XT3F2SWmS9CnjiywuAADXU4tpAA3CBUGnc8Qi7EkfQ7PFk+zfCBrLS5JhJB5F9FpjuVNOlfHqRI9e86w0He4xgnUmpxcLPCCNS3ITkaBFiakgagcehGwDRhR/F0W/OLWOr7VN0UEyZVu/f9/T5q4S4pm/+vTp5nGuvm7WvV4O29BTu1Bx+FeGL4xOrJslY515aqlfnct2RtCS/MUfp1bxQ+CM2uwXoJWPJoEFCuqzrKJ9yVj/hAtmeXiIXnxNiUybYEiPwD+6qRKlDCyskALXrzNGpcbDwEK/nbEUcYRcieEsD8+kyOpu1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op4xFyJD2jp5sFi6q2fAhaL7tR8Y7FLnU5erctHp9u8=;
 b=jr+UuFfKfKCz1goSo16fOIgKb+CB11GTpKv8j2g7pagmcca62NvNOlEBFNBa5PZNJoZPui3yDm6zMZOviVVQJWqWO4249PtV14odoSOLh1aApmWfl94xA53QJp1by4tXl0PUnGl07iAQ4oAQliaxtduxLDyiSvRhp66SsgpMOT0LonU/Mnhvq657kaMPBs27jBMO5CCGfj9WuYQ2lLH2nbup8yTiKTRwx0SxKJS83iAUaqBrSzQEjrFg3rYz6uu75Zy0ZMc5nRQ678To5CaQEWHK7c0crETAPvOFlKf1hwLuDNfLkTqboAwExAHI4izRRsPORRJhEhAn754gdH1F9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op4xFyJD2jp5sFi6q2fAhaL7tR8Y7FLnU5erctHp9u8=;
 b=LL8msmmneXDET6xg+U3jg0/EeFYxsYpTwEIBkYqCDuplki0mOw7XcFEfKEHKyrcVrFfzaZElmqxpUjl2TXoyJaG/BKCQwCBLfe6kt4NG6NY8GC3oU0K066A35FSYhHWWa/rAORPj5MD6XrJh3ugKqpXjMyDRJPRdsKsUKQyfJZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS8PR04MB7877.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 14:08:23 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 14:08:22 +0000
Message-ID: <c653ec1d-4cfa-493d-9a12-37910a9e4937@cherry.de>
Date: Thu, 26 Mar 2026 15:08:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] add kprobes for 32-bit
 kernels
To: yocto-patches@lists.yoctoproject.org
References: <20260326130653.478746-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260326130653.478746-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::11) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS8PR04MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 5048c899-5cd6-40fd-b083-08de8b4123e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	takVfCVFc0FFT1ahTQ9qQPSdI7zGXnfFFqbx+DUumFDovlEDkwR8gyzy1s6ZStHoCMdsmdsmk5ICq7z/rX+Ll/fussNEXKh0Za2zhyjjtyraDDZvCFSO00gO5cQR58Efv9wbShy+IijnN9qYNXrAHf61X98piYpCeqzdBCjNHIiIecehn6+0u1+Bav0lY5AVcBmG85Jz8FlP0Nj5wtjpBctbpW8txM3N7r6OyG/AzE/bzJnUuUMn0P7iuXbT/2GLAorMiz24KYMRxQHEPP1PsnaQ5uXz4te2Ze55uKqY8zeyMe7zNK7sXa7qa7Bq04tqh8RE+nkAGSTwAvsJpXBziYGKsmtnQLeLcMIJJz3Jon8OeXVkisrpef1tWOi9cUHe1NwtQ9ibI+KGGmr/BrLoPSbJ19eYx7xVMq6oB/4THIoK7lRzkh4zy2sIC10+/a6tfwBVXYo1BAVHOgDySusPHSQ1evanjab/WgogIOxUU0JVtzbwMDp0cZM/ZWwtSZc6SP0gGrvJZchjbyhDt3ZYESeyajE13D7Ni9dXg45GuniRrgJ4jOUebsytYIuzu25PwNhAanmXLg4yq4ipH63SildeXImY09eIosMK2Wy22Y/nu0RhBoFtBiEm0iwD43nIPLt2Of+uIa8FUIPQpe/CCh5gsRewj3KAgWgPG0s89D+5w9i74LweGLYjlm2QgH0D7hfVW0ekmMz+KI4R5gK6rRTWep+8V2ATFwtGj9LDpDI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YW9pOUFiZ3BWV1U0bTYxZHByZXc3K0RBMlNWSC9ZYkR1QWtQVUpEV0JTQndF?=
 =?utf-8?B?cE5kcEh3U2hpdkZtVCs0dmt2MVhPSkNHNjlBYnMybGNHLzgxZ3p6cU1SOHF4?=
 =?utf-8?B?NFZjU1NRMkRmMGZPRmliVFNTMHBwM3FlL3huOVZPaW01YnJMc2tIdlRnTnYv?=
 =?utf-8?B?RGpQSjBmSERLc28zYXlVUXhlbzE5bFFtdzJJM1pWTlhpY3gycjBadXZ0TVBN?=
 =?utf-8?B?M3RHVkV4Z3BGOXoydHd2UXZBajVPZjhKcWhySVU5RWFMdmh6b2JSeHkrRUJK?=
 =?utf-8?B?N3FiMDRQUGlwMWVSbjRqREtEY2FiTmJVcldFa2U1RmwrbjFNMVVRNUxrYStF?=
 =?utf-8?B?Yyt0cEtSSWJpME9tenB6cXF6ZUx6YUdRVjd6UVA5OUM4bFV4OUU4ZGhXay82?=
 =?utf-8?B?VitTM0VSZWhRNW1rSWI4dG1XREE4R09KV2VycDg4SnZxY0draVc5cEhDOXB4?=
 =?utf-8?B?d1kwVzYxQVlsU3A2YVMyVjN2enE0RjlKT3dGSzRVdWJUNzhnWEZwNTJjVnlL?=
 =?utf-8?B?eWtuTXlUWm5FSVozN3VRZkgvbFBvY0pmWXBJeDJaVFhac0JtNUVDZW5sRU5x?=
 =?utf-8?B?Q2NGQ0NrR0xvUU9WQllWS1hSRUFXako3cjBWM2x1NjJvSTJCSytmNEpVSU9M?=
 =?utf-8?B?WmdVb2lBcm14WXJ3bFUwb2tsQVd5Zm9sTXg3bUdaSVhZMW5GZDFiRjVRdGJz?=
 =?utf-8?B?NkJSVjFIMmRDcW1iTEltbVh3ZC9vYmVmaTQydHFxeEFJYjdJWkpscjFyZEd1?=
 =?utf-8?B?OXg4bktKRzlLSXlTNjI1enNMMHBNQTRhd3BBK3hVNGlnZ0o5N2YrYSsyVHo2?=
 =?utf-8?B?VytMMEZUdmwydDN0MjIwcmlHdFdIOFlZVVlBUi9TK2ZoZDNIMVlSSFJ1TDFo?=
 =?utf-8?B?Ukx3VnFRdE5PR2ttM1pHMytpU05XSlpuanBuVUQxL0wvRmhjRlZGZFJQa2NE?=
 =?utf-8?B?d294MGRTTWJLVGF5dUNwVHZGbDhmNHpweCtBYW0vRW4xc2JvUzR5WjFXQWdW?=
 =?utf-8?B?anY2OVkyVk5WSCthTXJhTWc2VHlScUhYd2xOdUxPSkVNMlZyNGdkWXRMcUEz?=
 =?utf-8?B?ekJvc0MrWHFCM0MreVpEWlc1ODV0Tnl5YVhveVo1UjdOZFk3OXhGQUxRQm4w?=
 =?utf-8?B?ZS94cWdHK1J0SlRlOHU4NndHQUVvK2hmS3hhSmkxbTAraTgwdS9JdzYvdkw2?=
 =?utf-8?B?b1dIbkRvQnQ3V0RGRW9YQVhlRkZVRVVXR2NyeTMxbllZSXNocG1Ia3p0eXQy?=
 =?utf-8?B?QUhrWEtsMHFqY1lHZksveU0vNmJkaGt6M3c5aEFHdThjS0dYZlREUFVlc2ha?=
 =?utf-8?B?UzhnUTg4cGdIWkN1QUFiVXkrQ05tSEZLQlRwVGl2RXVUd05oYXVZeVVtVVNQ?=
 =?utf-8?B?VFBxZllXclFoUm02ZTR0RjNhbUV5TWtTNmsxNUZEeXVSejdqN090a2ZxVG9O?=
 =?utf-8?B?Q3JSeVVDMmZGS3lFVzdLNVVQcmlucHExR2xrV1EyZVBtcWJWYmtDbUg5bzVr?=
 =?utf-8?B?ZGNDbEF5bVY5SDJRQTFkMW15U2x2aDFUSmlEazFEVXZoZ1YxWG5JM0hpYVlF?=
 =?utf-8?B?cUxWYVRDV0ozTFJibE1nUGk1QTYvWmdJd1E1U3ZzNEFXdGpqT3AxVEdTZjl1?=
 =?utf-8?B?T2M5R2J4U3NQdmg4S1FjbVBoNjU5QlBLSVgxSCtxZSs5TE9odkdmaDlqN0xZ?=
 =?utf-8?B?UFZPWkh1MmNIa3JkU0ZXb1VNQ0Ywa0prL09LWmh4MGM3NlRsa2VSMDhZdU9I?=
 =?utf-8?B?bW02eEtvL1doRnpCMnF0NXNoS0lLRzc5QXA3SVRaMXpDeWlpSVpoTm4xc1dV?=
 =?utf-8?B?SjVsRkpRK0pHd3RmbmdkWEFFL3RMYmlFVG8yL25ZbVc3N1lmYzU0K0JvWkFT?=
 =?utf-8?B?ekl6bDduVGwyeXVlL1dkYzRlbUxISFBteWFpTTRuZjJTQW5xMENzS2NDd3pt?=
 =?utf-8?B?SXhKYVJaQlE0MkNRNEpHQWI3UVdUazk0YTd6Y3VBdWlOQ0xQenpqQm1QeVZw?=
 =?utf-8?B?aXEzQVU4aTZGR1EvaElBaTkzT2JJQnBUVk9aZDE3VEtVbTNNa1NldjUyLzc5?=
 =?utf-8?B?alM3ZnRsSDJaMXJCczNWYWtsK3hHVndPdlZ5TUxLWG1RSW8wV1RJLzRwdWR2?=
 =?utf-8?B?UXBIbWFncXpvZ3VJWHZnUVVwdDlHTGg5NlM2VUwrS2docEdCMUkwaVdmc0hw?=
 =?utf-8?B?RjJqWCtMQUhKYzJNTUJqdFhUdnVLcE0wcnNhYUtGc2VxaEhHV05ESjZ6aWx1?=
 =?utf-8?B?MXBVZEdKMlVFcGFVcDB0WUdNbVUrZzdhUDE3d2tCbVp4VlNKS1RaUnAzcVBW?=
 =?utf-8?B?WFhXcWVqM0JzWXl1SmFGZTdtUmJGc3B2dzlHV2k3RklkbytrNzJtdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5048c899-5cd6-40fd-b083-08de8b4123e9
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 14:08:22.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jnlu/ykGLYOdfdzaAiVBMoD4ZiNfs7CN4l6pNXQ/3jUq2zTIsmsZadCtvjIhxPCjsJpKCXdH5WBwf75pjg34PD9PYXUATiIcdt/ZN7xHz/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7877
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 26 Mar 2026 14:08:31 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3556

Hi Trevor,

On 3/26/26 2:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> While building the modules for linux-yocto for 32-bit machines, the
> following error occurs:
> 
> 	| probes/Kbuild:236: CONFIG_KALLSYMS_ALL is disabled, therefore probe "writeback" is disabled. Rebuild your kernel with this configuration option enabled in order to trace this subsystem.
> 	| wrapper/kallsyms.c:20:3: error: #error "LTTng-modules requires CONFIG_KPROBES on kernels >= 5.7.0"
> 	|    20 | # error "LTTng-modules requires CONFIG_KPROBES on kernels >= 5.7.0"
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   recipes-kernel/linux/linux-rockchip.inc | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-kernel/linux/linux-rockchip.inc b/recipes-kernel/linux/linux-rockchip.inc
> index 6c62e849834c..4e67ff14f6e6 100644
> --- a/recipes-kernel/linux/linux-rockchip.inc
> +++ b/recipes-kernel/linux/linux-rockchip.inc
> @@ -34,5 +34,8 @@ COMPATIBLE_MACHINE:soquartz = "soquartz"
>   SRC_URI:append:rockchip = " file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta"
>   SRC_URI:append:nanopi-r4s = " file://realtek-r8169.cfg"
>   
> -KERNEL_FEATURES:append:rockchip:arm = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> +KERNEL_FEATURES:append:rockchip:arm = " \
> +    bsp/rockchip/remove-non-rockchip-arch-arm.scc \
> +    features/kprobes/kprobes.scc \

This is coming from the yocto-kernel-cache as far as I could tell. It's 
only available if the recipe actually points to it and only linux-yocto 
recipes do that. linux-mainline and linux-stable from 
meta-linux-mainline which you've said in the past you're using sometimes 
do not support that from a cursory look.

What happens if there's a KERNEL_FEATURES that isn't found?

Maybe we should have this in some linux-yocto bbappend instead? Or 
import this fragment into meta-rockchip (the downside being we need to 
maintain this on our own then, but it's been updated only once, 8.5y ago 
so not too much risk for this one I guess.

Cheers,
Quentin

