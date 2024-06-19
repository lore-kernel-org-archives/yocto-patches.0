Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BCBC2BA15
	for <webhook@archiver.kernel.org>; Wed, 19 Jun 2024 08:59:52 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.94])
 by mx.groups.io with SMTP id smtpd.web11.16245.1718787581710323846
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Jun 2024 01:59:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=ln9BfX3g;
 spf=pass (domain: cherry.de, ip: 40.107.103.94, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/jGHYRQd9ALaFNu3Gb8Pwe29uljh5XcxDug+kc7DwkR74cnZvyYzbrGw/yHZiqkPfmtTR+IPjz8XxkmDY9Sk2XULlXsHiT0Qzb5MZWX2047hE76OgyKjh/IWKzfEAxwJM79e8e7t+8RibcsIvBGOb4ihwUczeLczUghQjRmkah8ZK0Jjhj9nCPz7N7+piGk+wVSym6VtTaSoFNeQGvlao89+QvrqW5mikvxmfAs31ciP5zgRpGrnKcBrcmsVDmFrba6Sa9XrcgAH9g7S1FRrEHk2UMaueym6rc4OSEICrlmEcINY1gHZKhpKI4lpkJYib8Jp1FU3Qpnly/nO3gR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5Wobh+rNdJ1UBVfhdr35EKmF5oLCMHROqjnVfbXMq0=;
 b=Nu0EGCnMuv/KvHe03r3WcP7J47vY+cqHLt1d6PaBixnXhQ4RBxFyxQVYVImu91ejZ6N0Wm/tfiy+HyOQWvGF/glrq4OrHEueB2YZehoJcvH4AcDqjgE2cqy6966lvU/SF4olbXHsWvPGYGsl7YGX9ren5Eg48DMP5cwlX14/Z73T1+p5xfUtrYfapfH/kcyFK60yFriQIToB0p6H2ElMOfwO9P1fNhrslaEDH0xX5kYPBWnQ6QVkS8mjwnBvzz9zPkNGiB+9g+w+Q0FPproRykCK+JpcxWoLIQVIx1/YAXS2Q+kIx0x4W4AvUa1JZbGc7HAPrX03cfFFBcUZhAT2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5Wobh+rNdJ1UBVfhdr35EKmF5oLCMHROqjnVfbXMq0=;
 b=ln9BfX3gR0wY29+oHX1T7QeZJQNyH5hoHZkfe/+cGxqx/0vzWa1HPtCUyU2LHK7NOxaYgKXlHUelSSPop67s6ykkSp7FVC1X7jFFmcFsdkSG1ya9cVeGDoFMkVWqN1ZXaYGQu73HMw8wz6ru7CQzF7ClGss4MMwC4YZbRwo3XC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DBBPR04MB7977.eurprd04.prod.outlook.com (2603:10a6:10:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 08:59:38 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:59:38 +0000
Message-ID: <d7838e2a-85e8-4308-82cc-36f9eb2b69c6@cherry.de>
Date: Wed, 19 Jun 2024 10:59:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] linux-torvalds-next:
 use tag
To: yocto-patches@lists.yoctoproject.org
References: <20240618171619.9303-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240618171619.9303-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DBBPR04MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 72438144-3680-49b5-46ec-08dc903e25fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OVNHTzlzMGtzL3ZsSXY0U2huZ21xNThjdytVNDY2aEcvWThOczJhWWZkMEs4?=
 =?utf-8?B?K21jZE51OXVtcU5sTm1SdjhBQVNwK3R1SzFzZmYxeVR2YjFXTWRvOVdTbmc4?=
 =?utf-8?B?dlYrWWxidVJFU2MyOGFmaVRaQ0ttRFlsQjJzNG4zbTBqbUxHL0wrTndaSnlI?=
 =?utf-8?B?b0duZU5zaG4xSVdOZzdIM0pSWjFRZithSXNWSEErdmoyMEtmRDU4cWR2dUk1?=
 =?utf-8?B?OWJDQnpnU25KdUNWMmJIUTN2THpJTzA4T2ZzYnNVaDh2TTFJTEhrWnZOdVZE?=
 =?utf-8?B?YjJLQ3dodEgyNDdqZTJNSm40anc0dU9QYTRRRWZFY0lDS2NVNm16eUxMeVY0?=
 =?utf-8?B?TlI4NTBtRHBUL01DRzhPRWdvMDJKUkQ0ektickk0UmJSQjVqSWVaWUhmcWtt?=
 =?utf-8?B?R1ZieXdJMEE1WGVIeE44R0N6WjdZRTRRYk5nOGZVdUh2UFFXNXR6bm5SNzls?=
 =?utf-8?B?MWVKZWZZTURxTUxyNldsUzFWV1VvTytySjgwOFNsUE1LK2FoZEhDYWhObUt1?=
 =?utf-8?B?RUNDUTdIOHpLQ3BnSFp6ai8zaEwzdVlGaEo5VWk3anpvWEdqZVBDVG1hT1BF?=
 =?utf-8?B?eWxyR3JCbXQ2WFV0eGYzd0htTnFPcm13ODZncmZNNDBSN0taaUhNbWk1Q3NP?=
 =?utf-8?B?dURhVnhKQml1cTJ4MC85V1V0bGl0aTkrZ0JhS0hqSnd4Y1NZREpvWXF6aHlC?=
 =?utf-8?B?RnJKWmFjRFJ2bHZySW1JZml0YVlVd1NMWHpSWkVCRU5pZlB0UmhkYXp5R1ly?=
 =?utf-8?B?TUFEZ0owVEg4czNrdHJ1L1dLaHE3NWpWR1RpZFc0M2RMb3Z0WUp1K2V3R1Zo?=
 =?utf-8?B?aXVDS3lnUFVzdGIwbWV2ZExJakpRcERNWjRxUktIZVQ4RXIrRFR5eXNGWVFI?=
 =?utf-8?B?eFNkWG1PbTk2YnNzWlhVUXN3SGpSQUlpMG9LZi80OXQ3aWlpLytaZHZaTUZ3?=
 =?utf-8?B?UHViMGEzdkZpVitBLzhlR3M2M2txZmZHOW12cDIveEttOEROZ09EK2hwQlhE?=
 =?utf-8?B?VSt5eVZ1Z0RDWjVjYTh5VDZBWXUrZVlqa2RCN1VvZVExcE9ubGVzL0c2ZVJ3?=
 =?utf-8?B?WElxTVEwTmw3UWNCRzJXVWZCUDYvejRCdVRIZzIrc1IyNWdUZkNEaERZK1Zv?=
 =?utf-8?B?TjdYQzE1aHFzRkF4MXBHMTRCTFQwWjJOMWh4Rkt0TVRZN2FrQkFHSVN6MG5E?=
 =?utf-8?B?V0pUNm50RTVFSDU4TmpsVjFyMks3NW9pTFpCektNWHhWNFV3MUVGUXNEakFj?=
 =?utf-8?B?N1dLVmFSY0NmVEY2ZTdXYSs4UnJ1Q0hOdyt4M3dtNzZZWk9hSVFLYzVLMDZo?=
 =?utf-8?B?TlNoTGhOanhkZS9EQ0ViN2FCMzJkR1dIWjQvRGJGQzFMNVZTSVN4VS9jZmoz?=
 =?utf-8?B?UStRdmlUMUY5Q244TWs2cHRlM2JkU2dLR0dlWS8vMm5nbnJlKzBxT0U5amYw?=
 =?utf-8?B?alg0L0NaRGpoU2VaUkNpdmFNWU1WS3AxQldWcXh3ZDBaOHk0eTMvc0Z5YndN?=
 =?utf-8?B?UkNNWHhVWnlQek9mZ01wZlM0R3FpbFVjRlJpUVgvb2ZJZ3ZLd1BQMmpXV3Zt?=
 =?utf-8?B?eUNoY0tDOTZ1MHZINTJabDVraWhwOHJmanNrOENvSGdXMEFSV2Z5U2FYU2tu?=
 =?utf-8?B?NHNKZ3hwUXhNU3M0V0twN2w0OXV2M0Z2bktSaVJ5S29zd0xPQXZ3ZGZKUk9M?=
 =?utf-8?B?RmNKU2FtdmpjeFRQQ1lFTktVS2czMGVib09ZdmVoeHZiMFVxVGVlV3g5c1VQ?=
 =?utf-8?Q?HCWTs8S05QOhEFR7ArWJLtAMzFqw2SkL74sQgNu?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U1owSG8vNEdnQUhqaGZQdnFlYmU0bWJYT0NwUElkQjVHQUEwdVo1dElMeEww?=
 =?utf-8?B?bHVMbkJ4NmtTOE12KzFod1B0M0xPekdrNXJFNmI2ajlHV2ptbHhXb2t6UU82?=
 =?utf-8?B?bkh0WjdNKzFOYVY0WFNTaC9nL3dNR2xFRElucHZPdHZKZ2N6Vkx4L1VPVm1U?=
 =?utf-8?B?K0k2NGhVdDVtbWltTERVajFvNlVFT2FuRXkxcnhEYVNrOXltYWloYmNaS1lX?=
 =?utf-8?B?cXFOcG9jMFB6aHlOUkFQN1RmRXhaSXhLY3ZvT1Vvalp1cTFtNGZjc0FkTWFK?=
 =?utf-8?B?b3RDQmlMdTVoaDlZRUZCNFBJeXcvaEEwNGxDNkUybEY3WTRRUnBxQzVybGJR?=
 =?utf-8?B?UXZxSWdlUjZacURXSUVGS25mRTcwUkN5QzJpQWNOa1UzRVFsNkd3eFN5NGkv?=
 =?utf-8?B?bCsvNWdLTU9OZnVwNWlWM0YyZ2UzRmlyUTRtbUhZSXlnc05jS29YSEtvQitS?=
 =?utf-8?B?Um1GdGlxZXY4dHhGUm9sZWt5ek1FZEo2bytHbkZ0TDNFc296MGMxTzJlbHVw?=
 =?utf-8?B?SUF1UEdvalN2VzNMazVVRVpWcWIxSy9xRWdRYzZUb1E4SHJTNkkzS285dmpz?=
 =?utf-8?B?cDJFSWM3dGNCVjFKMWJ4U2N6YU5CcjN0ZHROazMwZUkzWjA4NWlZaGR0WEc4?=
 =?utf-8?B?UENiQytmTXg0bHplYjJXNHJacnRuNE1SYVMwaW81NlQ3cXp3aFlydUlYeHJu?=
 =?utf-8?B?TWRlVUdUNnp4K04rd1NGVlVOYXVmWmFtUjZMUW9zcU9JY1R4T3VMb3JzSkZT?=
 =?utf-8?B?Z010eVMrcFIvTkFRZ0Q0eGxyT2dWN21BZXJXbEdFWnpnZmRGUHUrOGcwamxJ?=
 =?utf-8?B?ZHNsZklWUG9BdklmSGJIL3dwQzV6ejZYdVJIMituNGl6RUZwcHdITXFrYkFa?=
 =?utf-8?B?aC9yVDFhQSt3N200amJXZmxHWGhvUnRhN0VmTEFxYzMxcnh4WTlvM0dtbit0?=
 =?utf-8?B?NW9CRlkyZEtKYXF1NlJWT1BlZGtLVmtIblhndElOUG0xbHRvUDZOTFhYb0Yx?=
 =?utf-8?B?SDhPVHVQWWwxcENORDRvb1dtbGN6cTBRK01GQk50ZXgrTmhaelUwK2ZtMUNm?=
 =?utf-8?B?QWs5QVVnaWlEL2Z2eTlhYnhPdmJ4bng3YlhsWTNEV0Q3WERpOE1ZalllVnFz?=
 =?utf-8?B?QUFZVW5jeTVNS3hWYmpOMWFuNTVSNWlhc0hVdUx6Y3JPODZIUEsyUHcyTFlo?=
 =?utf-8?B?dUNNTHlNd0RPUmZxeDgxSDU3L1pjWFIwMm5RbGRsemsyODcwVmM4RXZ1ZDRv?=
 =?utf-8?B?bSt5TWkwU2lCOWZERmFUTGRNdm9HNkYzT2UxUEhVdUlwK3YwQldzYUJBN09r?=
 =?utf-8?B?M0R1QnJoekc3Y0V2TjNwUkZjaGY3a2RjYUVrMXc2QzdxOHVUMjdjZ3F6ME45?=
 =?utf-8?B?QlZCbG12UDcwZFZvU0JhVmlUUzN5R1BaWTYxS0VVZGdMN0FGaXNsRWJuRWwr?=
 =?utf-8?B?V2hMUFdRRkhiZC9rTGxHZUhJMWhja2dYWHJ1MlZOVjF1NzNEeFVwZmZDak1X?=
 =?utf-8?B?dVZsdE9OSXdIbUJ2ZFNFbWQzRDQ2d0pKRHdySFpQb2tqTVdNMDQydzU5Zlk3?=
 =?utf-8?B?ZGt4WmhDeWNXOUNHc3dMUTV2QzJNUjJVRDNiYzZQOGk1eUNNK2tJa1VkQzZo?=
 =?utf-8?B?NUNIdnlNRzZ0MFdNS1gzS0lJODl2ZGVjOGpVNkJyRytvbVR5NG9nQUNoSENC?=
 =?utf-8?B?b0pUMFV3SlRQREY5T3pwcTg0RGhLZlMyZVVzaW1BVHN1TG9rWXJURlRYaWNU?=
 =?utf-8?B?eFk0R0RKai9qSGw1K1UxUzZka09PM2thbk16MU9tSTUvSm5FU2grOVJZTkd1?=
 =?utf-8?B?b3FBMEkvbkhJdGxlcU52Uy9vdE1DMVkrVjFEaVZqaXIxUmxMYTY4V3pxRUMw?=
 =?utf-8?B?RktNdlRYb01rUndGSFBJbkVjcEw5S1R2NGI1bXJadUNDemJFcERlNTAvQTV2?=
 =?utf-8?B?bDFGcTgxZXpCMTJDT0hFdXZuOGtMTlFSa3F4cFgwMlRxdGxzUTh4TVk1ZHlN?=
 =?utf-8?B?MDZqaWloZmtEeHZnS3Vxa21FUk8xR1hCOFU5b2RQWDUzNm9iWEd0VTRzandr?=
 =?utf-8?B?aDFDaVlERjdZVXNFOWg5MGtQQUx1YXcrR29tWkRjQkphRjhlK0sybm1yMnI2?=
 =?utf-8?B?SUpmY2liY09XbnlZcm0zSXZVZ2FuV2p3OU4yZGZOTXBwdXhiaGE2SVllMVg2?=
 =?utf-8?Q?sxUyet5gs9KXdcJYnw7+CtU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 72438144-3680-49b5-46ec-08dc903e25fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:59:38.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aam4ZWpg9w9OPRAjIWy5VL0NWN7xdnhWjQiaNyQUjYhwPVl4a+fxLWRjc+UES5d2ayLjLGTXyoFKkXKHuzL1ajoUaXU1YTzxwpFM4X4l1ts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7977
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Jun 2024 08:59:52 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/348

Hi Trevor,

On 6/18/24 7:16 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Use the tag name specifically; note that it is no longer reachable from any
> branch.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   recipes-kernel/linux/linux-torvalds-next_git.bb | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-kernel/linux/linux-torvalds-next_git.bb b/recipes-kernel/linux/linux-torvalds-next_git.bb
> index 9a95eb5bc4d8..1369ba1d707f 100644
> --- a/recipes-kernel/linux/linux-torvalds-next_git.bb
> +++ b/recipes-kernel/linux/linux-torvalds-next_git.bb
> @@ -10,13 +10,12 @@ COMPATIBLE_MACHINE = "^$"
>   COMPATIBLE_MACHINE:radxa-zero-3 = "radxa-zero-3"
>   
>   LINUX_VERSION = "6.10-rc3"
> +KERNEL_VERSION_SANITY_SKIP = "1"
>   PV = "${LINUX_VERSION}+git${SRCPV}"
>   SRC_URI = " \
> -	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;branch=master \
> +	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git;protocol=https;nobranch=1;tag=next-20240611 \
>   	file://rockchip-kmeta;type=kmeta;name=rockchip-kmeta;destsuffix=rockchip-kmeta \
>   	"
> -# this is tag 'next-20240611'
> -SRCREV = "a957267fa7e9159d3d2ee1421359ebf228570c68"
>   

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

