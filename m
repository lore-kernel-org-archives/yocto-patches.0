Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE17ECA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 13:43:50 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.web11.39607.1756993429740472162
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Sep 2025 06:43:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=oBr4+GIZ;
 spf=pass (domain: cherry.de, ip: 40.107.162.41, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIwuuAU/l3ZJ3MqohnuyP+naIBSg+wFYOrA4nOXmZk92SXRDNrOZiNifZwOfVy+Wx2pCtIdFQwd5wZx2qIcw8as3Gc33gkjpEIfxXV7f2iSYG0KCH++CvtZf7kT8LMBv5gCLn0r383riz9LL4ZUGTcyAga8F/6vFPTI6AAkEUZYJpsl3fzKY08u5r+ZnNMTqcsB2nDqCa4IXiJCujiXuaVzDz1L1jTVrGYqK6d57IbfXCqqZ77uE444Rm2CcupISO1HNaGIYkhHXuqAs7Qhse6SZsYYFPt7cfn8qVtt20MSYHJ3JySsMZhV2FBwmpdDbcO5lD/Jl2r80V5GKVsRiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRGNJqHn/4joaPcuZRuloqIA/mSkYGyyUFCZDuYTfhE=;
 b=l0iZByVIKCppVxssOBqkoR+1mt7rpfncq5OQY1SK2BYmbppdoSpKsf9RSLoOcOWcQSMjX8L6uAwu0pPANQckkp/MRZi7gmEvRhjkXnOB7jXidBNxoISgsPkTtO2+wIo3E2hHiSFp9OpC8Ds0f28GoTzozv4qj+wKaGc7B3lngbDBx7rI8TGN1U4ZLMmT6KwNIAIXpZ2FqYL2bLEaqT8YEIWEBqauff1EkOJBRwDntb9aOavbr2xCY+PLUn+i/CHeqaI+OXmMCeULR2s+5I+DYxG8wHZs9AWwpdmYrM2DtxGbF4lHERcNyDDcfk43ZqzO8NFeV+sKqSeSQKAQJ5w4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRGNJqHn/4joaPcuZRuloqIA/mSkYGyyUFCZDuYTfhE=;
 b=oBr4+GIZpGjmu4/ORMT3NACSofeCuHf2kGVBmZKLbzwl6r+FWrOAL8Z1TZ4evo3dPW/qWwORV9aHg+gfoxfggS53jW6Li/tmlVxmZqlVJImQm49e9r6vBiW3ZaHzdFfTv5scaQS4LvHXbRcwlqS/YCZGfKrkrceIpwBnfqLYlF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 13:43:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 13:43:46 +0000
Message-ID: <f968f8e3-b138-48c6-9fff-43276c5ab03d@cherry.de>
Date: Thu, 4 Sep 2025 15:43:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] nanopi-r4s: refresh
 device-tree patch for linux-6.16.y
To: yocto-patches@lists.yoctoproject.org
References: <20250904132717.8973-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250904132717.8973-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: a9babfc4-cec5-4bda-d637-08ddebb911ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aG5Cb3p3YlNJNWgyemo0dGtrL0lTSTZnSGdsSmRnS21hTENpNjNYdG5vSkhD?=
 =?utf-8?B?cGJVTzZlRE8vVzlsTFMrNVJsZjBwU0hvT3VVd1gwUnYyT3JpQXVnc0k3cHZM?=
 =?utf-8?B?djh5aE5pVTg3SmN2YzhNMTZvaHBGUDMzVGdqaVVvK00wc29YRzRLRnc2UFBp?=
 =?utf-8?B?OEJEMzRFRE1ja1NUeFVXSUhLT3YyMHpta09RTHYwbncrWTc0REtzdWlETG12?=
 =?utf-8?B?cXc0dG1vTk5iSUIyRUFubXpBUDJEVlV1a3ptbC8zdzBDTVdjUUlrZ2t2M2po?=
 =?utf-8?B?TzMweDZEVDB0djFBL2wvRjlwT01SRWplZTNjbkRSZjJNVEswRkJmZGZKR1lw?=
 =?utf-8?B?QjZOMXF3N1ppSUNzaERld0ZiSGxoRXFmRjNIUERiT2pISFlJZ3A1SXN6OXd6?=
 =?utf-8?B?Qlphck1tV2F4dnlHYzRuVEFvdUFCM1BiczdmdHMwTzBhbFZ3L0ltY2JoRkQy?=
 =?utf-8?B?TGxiSDg5ZEUyd1VQajNNVWNuNzVUL2M0VlpMVmNXTzRYYTRTVDNGMWU2cU1N?=
 =?utf-8?B?Y2VJejg4RzBldmltVFM1QmRTOWxEcXM4WXRNc3B4RlEwK3VCck9nbmpzS1BL?=
 =?utf-8?B?TGJLUTVYUE03MDNRcjUzYnBsWE5CMGxITHNPNFRUVzh3YklkUzB1R1A2N1kv?=
 =?utf-8?B?dzRueW9SaEQydU1QNjN5N29scHcyVzFNYlFIMnNuU0syTlkzRWhOUmE4U09v?=
 =?utf-8?B?WUVrdDE1T0dyNWJDa2VlcnN4SG5RSTQ3M0pQZ3hsS3VLM3h1dHNacWJveFkw?=
 =?utf-8?B?SFA3by92dkd3UHowa0ZnL0xIVnVoamp4VzNXWVRWOFBWdFZTQ2pOUzB6Y1RT?=
 =?utf-8?B?ZGdnckEreW5vWi9lcDR6L2RyYW11d01Fcmg2QlA5TmhuNlNlQzVIZWxVTDJ6?=
 =?utf-8?B?K0NCTTJtVFBjMENpWUFTbklqWGM2bVJmMm40YWNxU3piajE4N2RmNVNEMU9M?=
 =?utf-8?B?VUhhQnkvWFBBWFJtMXIxa0NiQzNQTFBNTVczaEEwajRROERpRVFZQnMrdS9O?=
 =?utf-8?B?RkpTYjNDK0oreUY0ckEwQzBaTGI2SVNWL3VMUHllUEN6MU5nRXpXY241a0RO?=
 =?utf-8?B?ZkhmVlRuYjBTTTdhejJQQkVQcFhHaEI4cTA3Q29ZUXRTNHU5ZHZvYWVEUkNB?=
 =?utf-8?B?T2g5cFBqKzA4dGxhVUdIcG5uMTRyWG42SEhzSW1CNDNkdndQZVlKT2xmNXMy?=
 =?utf-8?B?dVJCbEVycGlJU2V4VmVXRzlUK0tLRVg1Qmd2S1VaNzVGbVBSQjZ3M3g3TSt3?=
 =?utf-8?B?RGtSdHlkQ3hBL01sTjNQTnJlZ2tTWU5QMnlMbGk4Q0U4SDVRV0tQcmFaUEZN?=
 =?utf-8?B?Ym92RU9lekorMHJFbGpDajVPWmtUV0xMRFVyVlZpMkZuVFY1ZndST1hDL1du?=
 =?utf-8?B?ZHVVejlzUktRTjFwRjBHMFFlZlcwNEN0Uldqd3dWS3lHMmJVcUZob1U0OVhX?=
 =?utf-8?B?RjdVRUhkb2pIZTZZQTBEd1o4R0duSWx6NnYwdS9IbVBrZHVQQlBLTjNwalRr?=
 =?utf-8?B?RzRURlZpbmlGUFFrT3JuaCttMjJGcW1uWHBseTZjQkxiL0hDUXJ4TjlBdmtJ?=
 =?utf-8?B?VDNlYkFxZk5mWm9EdE55ZFZWQUZWMnJoT21zQ01ha1NxK29PNE5BU2EzZGVU?=
 =?utf-8?B?YnUwWHUzVjhudlYvOURoZlYzQURpM3NmTndPVCtCYVNMSTFKd2IzdFRQMUt6?=
 =?utf-8?B?T2lzeUxReGdRaDFiaHFzUE5aWTFLeGl4elkxR0NiNnJZZGxFd1gzT0dQUm9R?=
 =?utf-8?B?bHRZYkl5eTJlVWFaa2txenZDVm9pSHhCN1lxU1V6K0Z0Y3lIVGlFRXNEUUZj?=
 =?utf-8?Q?t6XMCBRRk2MasdeJBfKhikxkVFFJNbdN5928w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlhCaFQrL1lmcWE3aUJiK2hRVW1FMUlXS3VyZWIvMTJOM2NpUmEvclN6Y3lz?=
 =?utf-8?B?MlNxb284S0tYdS9tVGpTNzRtaXUycXVWVFZ1VTZZU2ZRRno2ancvV0xYTDR0?=
 =?utf-8?B?b0lKVWRnTnozeDhjcXAyOG9mWm5qa0E4WGFQTWtnVkh2TGtveEduYlUyMGNh?=
 =?utf-8?B?TTJ2T0hWNGRvcE8vSFREQjBYaFBqcUVSd3NlbUVYVnJseHdIV2g3cU1QdTFN?=
 =?utf-8?B?QnUvTDQyQjIzYWlkbHEwdVlnazVlaHpvQ00vZEFPelNBSi94MWlKWFVxV2hj?=
 =?utf-8?B?TWliYld6OGF4WlZDUkJhcnh1dnA3ODVZVHB3T1g3SmhYdTZjQ0xablNlRmR5?=
 =?utf-8?B?Tnh5QW1Pa0xUYVpEYTQvbk9aWUpWT1pSY0dHU3VOY01JeWljUkNRRDdEYk9C?=
 =?utf-8?B?eDNNZFpGaVRIV3JEaVNmdEluZzRWR2tONTdUaGJVZmhzMW5LejdHT04yajUr?=
 =?utf-8?B?TzBHMHZHZVd3N0pCeEloSExsSStlRm1oeG9BNzRDR1dsMnRqSEgwMVNtYUc2?=
 =?utf-8?B?aGlQUDdCSlMxci9RRFFISlFiNDd3RlJzckJzZmhrSU9IbCtnbHhQeEJEUS82?=
 =?utf-8?B?RS9MOUJzcVZ0VTZFT2k2cDFZZEcvYWdHQ1Nwc2FQY0l6K1R4Zmp0bmFERXlx?=
 =?utf-8?B?ZEVDZGoxZlFWbzJFVWtuS2RNK0N3eTJQbVBvMGRUUGRaM0FHcUxuVlY0VnJo?=
 =?utf-8?B?cUsvZVdneDVuS3FvbXBreXp3VGtZMWpmWFNKM05UcXhLaE1PeWdKaU51M043?=
 =?utf-8?B?aDlURnZ3VWh1VllBSlBzN1ZsSXJXSVhQRUZma1RyTS9vRXFEMzFDd1Y0YUla?=
 =?utf-8?B?Q2Z1RXZQWnEzbE84em1jeGt2SDQ2RzhJbVFlckkvWko5S1JZY2lWWEZ3YkJk?=
 =?utf-8?B?ZHFKQUtHdW8rZ2pOd0FvNmR5VFp4K2UwM2JkOE8vUlhITklnYzZ4YUlDYTNN?=
 =?utf-8?B?a01meFVMNThlSUI2OFkzVUFzaGkyUUhtSk5Jd2tLU0pFYXd0KzdjUGNNazRm?=
 =?utf-8?B?cVJrTUtTdDNFbDJNc2FlRGVmT3BDcnlEbVZ6My9KN0xOKzgrcjRmcGF6UU9y?=
 =?utf-8?B?WHVkZDBjYkRCSFNTbHpMSm1NaVlIT2FrUHBxQXJFQ0RVTnozYmdRaTFJNTQ0?=
 =?utf-8?B?WFB4dXk4R0pBRGprTCttWFZUV2tvblp5OVpCWU5vb1VXNlVrdWN2ajA3WHZC?=
 =?utf-8?B?UlJsQk5iREV6Y0wyVS8rN3IrdzhhZmk4YjRqdm1JZ3k1YmYzSkVxYzFVNGFE?=
 =?utf-8?B?dEhUUCtoVmtwam02TTNUWkVkTko0THFybWF5WWVsQmxHUjlxLzg0Q0ljR3k5?=
 =?utf-8?B?Z084NFdITElPaDhGcU5zUUkzS1RtY0dUWFA3WmZpNUUzWFlRR2RaL3NPaUdN?=
 =?utf-8?B?cXk4dWptdW5yUmhyY2U3Z3lZVlBVaE5Gb3EwWHNaZ0JSUkViUm8valNtNWhJ?=
 =?utf-8?B?eFJnaTRFRXVQR01NWFVvN1V3eDVXbFM2UFZlSW1ORkZBbXRNaHB5RE02L1Nm?=
 =?utf-8?B?WkQ4cjE5TkZUWGROOFNzNXhWVHhnRTRBVXVQa0RwMktWSWxYMVhCVS94clNm?=
 =?utf-8?B?OThjeStZVE1ZQkZmMWo5WWxzZWhlSTFUY3pjWUFHOVlvNDRQZDI2a2Rvckw1?=
 =?utf-8?B?TlpyT0x4OVhWaWk4eXNJK1owcVRUVDZMUEFORnd1a2Q0REhVZmR0bUpQRUF0?=
 =?utf-8?B?YVFMYk02Z3ZVWU02RElzVnJ5UGd6TkpodjI3K1dMTjlGQk9wNHNzWHNvVVN1?=
 =?utf-8?B?MENhclhHdnJFT09WU1dzamFBYkQxMHBmTTloeFF1cGtmcWdwMWhadVNrcEJX?=
 =?utf-8?B?dWN3M1ZYLzNLWFF0SFgrNGFoL3hvQ2VFL05Zd0g1VGZqVmozdEFJREdwbWVF?=
 =?utf-8?B?QWxOSGxBeVhDbHR1ODd4NDRRWDhlbjdXbjFvSWlTK3AvdEVHYXNraS83ZXBN?=
 =?utf-8?B?UjJKQXY1SXFWTFgzdXJjT2kwcU9VUnZEKy9SejVHM0NmWnFQN3VvaSs0Wkkr?=
 =?utf-8?B?QkV5eG9UZnVoK2RQOVhIaU5jSE15WGpqVHFERDU5SXJzS00vdTU1Q3RnNzFw?=
 =?utf-8?B?MVZITkpPcGhrT2V3dzRXT3JMYlRGV01qVGtnamV0SFFFUlpsdm1uTVZmQ0VQ?=
 =?utf-8?B?c3JmaCtkS2VNNGowKzRZaVRJbi9QZkQzNVdkd2h5MFJOSFlFcm5VWEkvVk91?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a9babfc4-cec5-4bda-d637-08ddebb911ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:43:46.1123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcuT1F50qLYNtQIbtZ1FGYl6BCpXGO6mCJF0yBCJEmXfPHjpHAYacpcFK/XxEKyubsvDl6oKixrays+IYicZluYqvFhFge0XKV2+R7LeD2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Sep 2025 13:43:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2127

Hi Trevor,

On 9/4/25 3:27 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> The device-tree organization of the nanopi-r4s device changed slightly in
> the linux-6.16.y release, therefore refresh the nanopi-r4s device-tree
> patch to match.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   .../linux/linux-yocto/nanopi-r4s.scc          |  2 +-
>   ...opi-r4s.dtsi-enable-second-ethernet.patch} | 21 +++++++++----------
>   2 files changed, 11 insertions(+), 12 deletions(-)
>   rename recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/{0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch => 0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch} (56%)
> 
> diff --git a/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc b/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
> index 266b77c63fe5..3d1601e28d13 100644
> --- a/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
> +++ b/recipes-kernel/linux/linux-yocto/nanopi-r4s.scc
> @@ -3,4 +3,4 @@ define KMACHINE nanopi-r4s
>   define KTYPE standard
>   define KARCH arm64
>   
> -include bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
> +include bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
> diff --git a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
> similarity index 56%
> rename from recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
> rename to recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
> index e1f2b92665dd..a3dc23afae7e 100644
> --- a/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dts-enable-second-ethernet.patch
> +++ b/recipes-kernel/linux/linux-yocto/rockchip-kmeta/bsp/rockchip/0001-rk3399-nanopi-r4s.dtsi-enable-second-ethernet.patch
> @@ -1,9 +1,8 @@
> -From 4c867907b68b417da0711cabdde30a969e368596 Mon Sep 17 00:00:00 2001
> +From de2c28076a50e94659ea9693f9d0a307ef475132 Mon Sep 17 00:00:00 2001
>   From: Trevor Woerner <twoerner@gmail.com>
> -Date: Sun, 17 Sep 2023 17:30:43 -0400
> -Subject: [PATCH] rk3399-nanopi-r4s.dts: enable second ethernet
> +Date: Thu, 4 Sep 2025 09:11:33 -0400
> +Subject: [PATCH] rk3399-nanopi-r4s.dtsi: enable second ethernet
>   
> -# lspci

I think this isn't supposed to have disappeared from the commit log.

>   00:00.0 PCI bridge: Rockchip Electronics Co., Ltd RK3399 PCI Express Root Port
>   01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ether)
>   
> @@ -11,14 +10,14 @@ Link: https://github.com/armbian/build/pull/2415
>   Upstream-Status: Submitted [by someone else]

Where was it submitted? I cannot see it on linux-rockchip mailing list 
archive the little I searched for it?

It'd be nice to have this upstreamed so you don't have to carry it around?

It does seem odd that every address and range is 0 though...

The change does look reasonable though :)

Cheers,
Quentin

