Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8410DD44176
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 10:48:24 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10077.1765536499469321512
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 12 Dec 2025 02:48:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=NZUBKDGj;
 spf=pass (domain: cherry.de, ip: 52.101.84.7, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZBka0UgbzG0KgRGWNBzj6DQWZb11nxEuEWYwu2gRP9lPb0NwGoS0q/j+2qJERxL1w3CHeT/EMDbubwOfSqcUzk6Jdd6SSjcfKcSs76U11jEWzjbchymVNkT6DxcwKlUWbMLNEHuZGnTD+7ZHTlvwdN0RXeYL4TQw3VsLepXb7AsQ9v1TYu2V6pWrAQdJYskB0Lvenet/nsAIBd2boVpo6wk/j8kwzlEeqhjMPXwjVJi3WREoVEziauSC6yYim/6bDLAKqI6TTWxtggQ9UfZ5jaq2CEJnFm2NkZgUhPhTpKCF8LRAq62BCQ7npin5H2ykZH3vxlk93fQH+0VL4cyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPpPzIHxtiXucqvXPlI8T4/lsg209CXq/db+PPd5iRs=;
 b=ZJ2u0YalcjKmuZbQoZwt+ZXQmGCXzV9tjsoPVH2nzvtQCnF8Q/UAVu+m0ptlW0Yu/yVzbsjPgaBDj/CO5fAI9Ac0fC/0rEc2aIBdJEpJsgkpmMxzj1YoyvDRm9iEhYDbenuLBG51kUNVkR58F9aIICGj1tN5xSyEalVuxsvaZHQKouQUHzQt1Sa+gdn1q5Ovlz/GbxGLkKZn63Gx/Ekz1F1/DKVIBEl4UPZr2Jw8mJ1zZFMrblZIv/REFrVh/T+3VMnguaHOiE9gjHFwzXO9GahagXOep6rAiurXriSdU0gxct/7riJX7X1zvyYZCCTYcqtqtDEZvFb5Q1VduLfJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPpPzIHxtiXucqvXPlI8T4/lsg209CXq/db+PPd5iRs=;
 b=NZUBKDGjdzWVA7Jz+smfsi3GMM2e9QaLMduaHGzYR6f0vgSR7GhtIP4tRReij3gPtrpBLs7w/gV6jzJPBY+PYspcBCUPM8xgtnpLbJnhzpcvRT2kIIx/1fwJ+HHH7d8kLaLMpmi/dXQjIQoBvJFwT8WJC/4es8KTxaSXS6Rc+oQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DB9PR04MB8218.eurprd04.prod.outlook.com (2603:10a6:10:24a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 10:48:15 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 10:48:15 +0000
Message-ID: <12e8c8b3-f1b4-4aaa-abac-9449f9daffd3@cherry.de>
Date: Fri, 12 Dec 2025 11:47:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] provide a filesystem
 overlay example
To: yocto-patches@lists.yoctoproject.org
References: <20251211210332.25509-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251211210332.25509-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DB9PR04MB8218:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e82518-4e9f-4216-c351-08de396bf468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bVhFYitIaFJOcWp4MDU5WWE3V0JqSDJBTlRlQWpsRzBnNk1jaXRmajJHSWQ5?=
 =?utf-8?B?NGkvTEZpdTkwbE5VeloyNlppczJ6NkNEZ1pkdTNzMTFKMklhTEpPU05rWFNU?=
 =?utf-8?B?RWx5bVIxV0RySzBvRUVib0tLWENmRHA2VkdXWFk3Qkg0bWRRM3JGWGlXR3E5?=
 =?utf-8?B?OTFHZlFqS0FnTkdwdU41U2dydS82R283NFJnVXJGYWc4OTZxV3ovLzFOcUdx?=
 =?utf-8?B?YzN6MTlIcndFRnBiMmdpMXBBUXJXclV5aWFJZjEyWWRqME5udXNZNnBLRkZu?=
 =?utf-8?B?akJrL2ZKaHBGWHVFcWUyc1JETzcvNk8xOUJLQ3M3c2NBK0luT3F6UE56RU9k?=
 =?utf-8?B?UVN5UVB3anQzdmYvdXJJMjFrWGczVUd2Yndkby9KR0lmbldXSTVyNnpqOUJw?=
 =?utf-8?B?N2JjTHBhSjBlWmM5UGwwdThEWW5rRU1DN2RyTzEyQ2VnY3VRVG94c1JQVFlJ?=
 =?utf-8?B?RU9lQmc1VGQ0QnJuZDkyV1FNMnVJdGxFTTkzUDR0UUxIYjRqUzAxNHJmSFI3?=
 =?utf-8?B?c0xBMFRJZlV3N21uUGk1RmtXQTlJOFQzeitxdVNSRWEvZ2ZFZjZWZ1hEaFFB?=
 =?utf-8?B?OXN5b2M4MEhQQm1vK29KV0J3S2gxYUc1M0NJK1VSYjhnRmVLZ0QvMFRPVWRI?=
 =?utf-8?B?MjI4VlJjNkx3Ty84NDk4bGlCSUJ3Nm13ZUtmVk5SeDRCVmoyZmh1NHpJWmhk?=
 =?utf-8?B?eWVKeldxYU9HcEwzVmowWUd0Mi8xeFJLNDN6ekpFc2JVNE1LZENNZEpnT3No?=
 =?utf-8?B?ZGttdEx5QnNmd1ZmNi9nMEZLejN6d0RmSWUwdHRSQVQyaVZCb2NaKzd2eHlU?=
 =?utf-8?B?SG1oWTFxY2p2UjFzRzF2cHF3UU1lNlBNRnB4eVlWS1YzYVVUeS9NTGY3eEZO?=
 =?utf-8?B?L2FkcDB3Y21Vblp4eHdBRTdXdE5xZ0U4K2RSRjVYaFBxdkJ1K25QVVlsVnhs?=
 =?utf-8?B?cTBwUlRlUEFXdVl5enRxZzh3SlNta2dZbkduak5ZdVBSTFhKRmVSU3E1dU5p?=
 =?utf-8?B?cndzSGVsSm9ESTB5Qm1BQ3NZQmdVck9Vd2ZWb1VWWW90RXArSE85Z0pqYmQy?=
 =?utf-8?B?aWdTa2NxVUJiQVRGdHc2MHlwbFQwMk16cDRCMFp3NHZiZHlmZGI0bUFpTTd4?=
 =?utf-8?B?RnBwUVUvUXdpMmFUTVVtbHlEdkR3VWlPcm1ZcEFxeCtSMVBaakRGdC9XVCtB?=
 =?utf-8?B?eW01TGV1L0J1R1VIVTFIR20rYWlPL3dMV1k0L2JoQzE5eS9lZ2FyMVp5M3lN?=
 =?utf-8?B?OUFLbkJaUnNzSHRtQUxvUnVqUTFpRXEyeE9oWGZXckhzSjFwWE1LRTFTMUxu?=
 =?utf-8?B?YWd3YWpyMUs2V2JzdVI3K2VtWlI0UVJvblVrTnhLSGZhcTgybGI3Q2pORWdC?=
 =?utf-8?B?SllkYmRYWlNXV3I3ek10czh2MVI0OEx3TzluRGZjMUtpbFM1bC96Z2JiSU1l?=
 =?utf-8?B?M3M3enVBRzJzS0x6WW5QSUZIUG9ITHBieHJTb3ExMDY4ZitsbS9BQm1ibFZ5?=
 =?utf-8?B?b1FkRE9sTG5KZ2VvVi8zdHlMa29aV3N0SlM1OVRENit0SytBYTVXWndSbkpk?=
 =?utf-8?B?MlEvVE5rWU1Ub2o4eHZoY043Tjc4czhnSmtXT2s2amRjdmY3RXQxR2dYZEV5?=
 =?utf-8?B?V2F3bi9Ec1pDWFc1Q0JpWWNacTBNU2RtUjlqTStUSUUxcFl2Kzl5VHdPVCth?=
 =?utf-8?B?Z3A3WEh0MU5SVmVLdlRMMWdaVFBwTnpsditpZXRXMjluUVVKS3NzbGNIUkls?=
 =?utf-8?B?NmhYb1lwV0dSTFdXa2UrUmZ3aUsyOUcxd21oZThaSGRkRk9aQ3NRdmJ0MHg1?=
 =?utf-8?B?YS9CRnVlaVZFWW5zbm02eHRkZzhtSUV0N1NVRkwyOXV5SXJ3emtvNDcrVVA5?=
 =?utf-8?B?ZHVmalRHSzVJNGRic1BScGx0bU83RDdib0hrMVVuWVJnVUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2lSblVyVGpGdTNIOC8zS2lpdHA0VmQ3VXJoM3lKQ0o3My9Bb1AwTE9WRXpI?=
 =?utf-8?B?UEozajZtRW1DR1Y4QXFBMmorMjNZZktXQ05iRXRqcFU1dVVHVmgzV0k0bmtD?=
 =?utf-8?B?bnJ0R3h5b3JLYXhsMm8rVjR6RHoxeTN2bWhwSFI1ZndzR2RoR0hGeDZKR1pl?=
 =?utf-8?B?TmxLOVNFcWpFSlFrZmxlc3R0eDRlNjdLbUJBY2pQRHRtVDBuZGJCNEhubi9Z?=
 =?utf-8?B?c2xySlR3NGJYSVU3KzJCWUZObkFibVBhMzEzMGEydEhkNmE5dXZYd3IyRk5W?=
 =?utf-8?B?VUZpK1JHTHQzM3J4SXVadys4S0owTnZ1T2xoMXFWQmRRc3RiZC8zRjYzRTNM?=
 =?utf-8?B?dlBXMS9PZ3d0NnZEY2hSNXdCcnBISWptTktuSC8raG5JZXRRN1R6Y1RPWmxJ?=
 =?utf-8?B?MnM5c1NPMkVxcVpOd2g4azU5enJWM3E5dm1FWGJwY1pyS1RJcGlwYWljVllj?=
 =?utf-8?B?Zm5pOERQSnBaQkdocjgybXVZNzNMUE5CMmFQblNxUmdSZFRKUTlTMkNHM0lT?=
 =?utf-8?B?SFBseGVTbXhMMnlQNDFTRzhKRjRlcU16Q1pSaHVCR1crLzhrQ1psTCs4WlVp?=
 =?utf-8?B?VkZHRFNyeTRxUnVNTWdqSzI1UmdrUW5ac2tVOW5ibDR3WHR6MG1Xc2xIVFhn?=
 =?utf-8?B?VTlpU1E4a1lUWDhKbVU0WEs2Wm9GU1YrZm1CNGN2dzFZa3NoSXRYS3JodWc3?=
 =?utf-8?B?UXpBZTMrVllmeSthdWZaWFo5ZnBRellsdjdDcjZtUEw1SnQ3QlBxOEpZYXVl?=
 =?utf-8?B?bmpUcys2ZTVqYk5SMFFrbXZiN2pwWGpuOVk2ZW1wNk9nWkdhd0cwWWk2MUwz?=
 =?utf-8?B?TnBRY0lHck9JWnBkRTRFMTJQTE54d3NkdzhtcVBHVThXQ3FiQVRlajRhckdh?=
 =?utf-8?B?UFhUdXZoYllOR2hibHdDOTdrelVJenVrVEFTVmNSRHBxUXpvcloraGhqSE04?=
 =?utf-8?B?R3BWODR5cWdaYXd6ZEJISklNR1J4ZGUxNXdpa2NLQjg4Mm1ITmljWDFRUXZm?=
 =?utf-8?B?ekZnaFZtTGZndnVSMDVkaEluUnRnOGY5RnM3Wk5YWnRkM0h2aWl3QitVVnB4?=
 =?utf-8?B?Q2ZtTEhKTzFuUitPUGxhNnIwKzk0M1pCODdIQlFQRkpTMzNLRDd3Sjk0amhI?=
 =?utf-8?B?Qm44SkJhY2liUzNlbktiRXgwNDRGMldhVWpOVzlXVGJzeGs1bjRXb05CcHlv?=
 =?utf-8?B?MERpUk5KZWJ4U2c3SEp1ZS9GTDFpaVozbldRNzNGK2VCclVMdWtkd1MwNDhB?=
 =?utf-8?B?dFp2OFo0US9lbWNld3BlQlV0VlB6OVFXS2N4ZnNuOXp0bVdWL251RzNiM2E4?=
 =?utf-8?B?Vi8zdnVSU1p1WUNxRW1BQTBMdk9nTmo3NVpNdFZFNjBXUldWbXVvNXYzLzFH?=
 =?utf-8?B?bWVFbWh1QjJRVXhtRDhBei9tRnFCZ1d4UUVBRUJtT1B0bjZPTWh1K21iMGlK?=
 =?utf-8?B?Y3ZFL3hBdk1TRjVPWUZZUElUK2RMeGgrTmZjT3k1TW5WYWh5VmR6OThJa2Rq?=
 =?utf-8?B?MjdiaVJiUTFiem1sUUUvNFdPcmpBSE1wenhxU2RKK2xCUjlBVzlteG52ZUFL?=
 =?utf-8?B?NTdWVGxxWHVGTEZPMFJNektkK24xRmsvQjBjaW15VWxqQmYyZzMyQVRPckFD?=
 =?utf-8?B?dGRSNDFJYlFrUGVxNjU5SWRZamJqZC9zNlBwb0ZadnFKR2Nnd3JJR3M5SmRY?=
 =?utf-8?B?M0pOanM4RFYvUzRjLzBQOTZQb216RFhuS1FzWnRlcC9wbjk4T1hlYkUrSUMy?=
 =?utf-8?B?U09rWksvaG1OZFZiNnVrTEQySDdYaER4MnE2eHk5cFB3akZaVFhuWlo0cGdj?=
 =?utf-8?B?RlFRZWxWajlZOW9YcW1DQnZPT1ZycmhubVJOWmx4cDhPVTBwNCtsUTlBZ01x?=
 =?utf-8?B?eU1EWG5jS29ya3cwS01UOE93M1hBZ29PMmNIam9MNVA5aDJUWlZ2aVV6RStL?=
 =?utf-8?B?YWpDNE9wdHk0THluNGpPQnlYMWhsZnRwUFZONkRBZ3FXcjByOFdLTlIvVWNF?=
 =?utf-8?B?akNzbFJxRHMrVXdjN2dvcmJic0dkbmlrQW9LU09DbFNaMVd4Qld5TjcrYmt2?=
 =?utf-8?B?OGtyUWlsOFpaNStOYUtFZ3lXbXBxSExJeUNnaEVvOUJTd1ZsdlgxWFJhcThy?=
 =?utf-8?B?d3hsOHgwdFF4UWd0dE4rQ0tlRVFxZHprc2pmSkR4bWZHVmFFclNSOGtFODBi?=
 =?utf-8?Q?3wIbx85bEuLWohFPv/xI/Uk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e82518-4e9f-4216-c351-08de396bf468
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 10:48:15.8759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCaNlZID9eyxO7/NN4R3hCFq2gClc+eaCimVp/1JQAPjyXxOyRnRvgbEFnWMLaCYt5DPhT5tCG7sgSx0CXPDftTC1LOYo84Oq++nFevc4Qs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8218
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 12 Dec 2025 10:48:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2771

Hi Trevor,

On 12/11/25 10:03 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Most implementations that use an A/B, full-partition update mechanism
> (such as RAUC configured for this scenario) need some way of preserving
> system configurations in a location that survives updates. The RAUC demo
> provided in this layer is an example of a full-partition update,
> therefore provide an example of using a filesystem overlay to preserve
> system configurations. This example is gated by a configuration knob:
> 
> 	RK_OVERLAY_DEMO
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   README                                        | 28 +++++++++++++++++++
>   conf/machine/include/rockchip-rauc.inc        |  1 +
>   .../systemd/data-partition-overlay_1.0.bb     | 22 +++++++++++++++
>   .../recipes-core/systemd/files/etc.mount      | 13 +++++++++
>   .../recipes-core/systemd/files/home.mount     | 13 +++++++++
>   5 files changed, 77 insertions(+)
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
>   create mode 100644 dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
> 
> diff --git a/README b/README
> index 6a13428d488d..92dc072a0833 100644
> --- a/README
> +++ b/README
> @@ -140,6 +140,34 @@ Notes:
>   	this layer, perform the same steps as above except for the step enabling
>   	RK_RAUC_DEMO.
>   
> +  /data overlay with RAUC
> +	When using RAUC for whole-partition rootfs updates, you will need some
> +	way of preserving some pieces of data between updates; this is why the
> +	DEMO scheme provided in this layer also includes a /data partition.
> +	Now that you have a /data partition that is not updated, you need some
> +	way of storing your important data there and making it available,
> +	seamlessly, into your system regardless of which slot is running.
> +
> +	One way of accomplishing this is to move your important files into
> +	/data and providing symlinks back into each running bundle. But that
> +	requires you to know ahead of time which files will be touched... which
> +	quickly can become a game of whack-a-mole. A better alternative is to
> +	use a filesystem overlay. With a filesystem overlay, multiple paths are
> +	overlaid on top of each other behind the scenes so what you see is one
> +	directory containing the aggregation of all layers. Filesystem overlays
> +	have a concept of "bottom layers" and "upper layers", if you write a new
> +	file into an overlay, the file will be written into the uppermost
> +	layer, leaving the lower layers intact. If a file is modified, the
> +	modifications are stored in the upper layer, occluding the lower layer.
> +	Therefore, creating an overlay using locations in the /data partition
> +	as the uppermost layer allows changes to persist across RAUC updates.
> +
> +	This layer includes a simple overlay scheme to demonstrate one way of
> +	making use of this mechanism. To enable the demo included in this layer
> +	RAUC must be enabled, then also enable:
> +
> +		RK_OVERLAY_DEMO
> +

You're overlaying two directories, so please make this explicit in the 
README. /etc and /home are overlaid. Now, is the root user's home 
directory in /home/root or in /root? Because you may want to overlay 
that as well?

Additionally, CONFIG_OVERLAY_FS support likely needs to be enabled in 
the kernel for this to work, so mentioning this would be nice? (though 
we also didn't mention this for the VPU, so... :) ).

>     HW video decoding with gstreamer
>   
>   	Most Rockchip SoCs have some integrated VPU, either Hantro, RKVDEC or
> diff --git a/conf/machine/include/rockchip-rauc.inc b/conf/machine/include/rockchip-rauc.inc
> index a6f79503076b..3ea95298fed6 100644
> --- a/conf/machine/include/rockchip-rauc.inc
> +++ b/conf/machine/include/rockchip-rauc.inc
> @@ -2,3 +2,4 @@
>   # rauc demo configuration from this layer
>   OVERRIDES .= "${@ ':rk-rauc-demo' if bb.utils.to_boolean(d.getVar('RK_RAUC_DEMO'), False) else ''}"
>   IMAGE_INSTALL:append:rk-rauc-demo = " abd-partition"
> +IMAGE_INSTALL:append:rk-rauc-demo = " ${@ 'data-partition-overlay' if bb.utils.to_boolean(d.getVar('RK_OVERLAY_DEMO'), False) else ''}"
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
> new file mode 100644
> index 000000000000..7d9a9e6de82b
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/data-partition-overlay_1.0.bb
> @@ -0,0 +1,22 @@
> +SUMMARY = "Overlay Logic onto the /data partition"
> +LICENSE = "OSL-3.0"
> +LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/OSL-3.0;md5=438ec6d864bbb958a49df939a56511cf"
> +
> +inherit rk-rauc-demo-features-check systemd
> +
> +SYSTEMD_SERVICE:${PN} = "etc.mount home.mount"
> +
> +S = "${UNPACKDIR}"
> +
> +SRC_URI = " \
> +        file://etc.mount \
> +        file://home.mount \
> +	"
> +
> +do_install() {
> +	install -d ${D}${sysconfdir}/systemd/system
> +	install -m 0644 ${UNPACKDIR}/etc.mount ${D}${sysconfdir}/systemd/system/
> +	install -m 0644 ${UNPACKDIR}/home.mount ${D}${sysconfdir}/systemd/system/

I see we have a couple of systemd_*unitdir variables in bitbake.conf, 
should we use one of those instead?

> +}
> +
> +RDEPENDS:${PN} += "abd-partition"

Maybe add a comment this is necessary because of the data.mount requirement?

> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
> new file mode 100644
> index 000000000000..65b896563bef
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/etc.mount
> @@ -0,0 +1,13 @@
> +[Unit]
> +Description=OverlayFS mount for /etc to /data/overlay/etc
> +Requires=data.mount
> +After=data.mount
> +

I'm wondering if this cannot be handled by

RequiresMountsFor=/data

c.f. 
https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html#RequiresMountsFor=

> +[Mount]
> +What=overlay
> +Where=/etc
> +Type=overlay
> +Options=lowerdir=/etc,upperdir=/data/overlay/etc,workdir=/data/overlay-workdir/etc
> +
> +[Install]
> +WantedBy=multi-user.target
> diff --git a/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
> new file mode 100644
> index 000000000000..d6a384fa9c75
> --- /dev/null
> +++ b/dynamic-layers/rk-rauc-demo/recipes-core/systemd/files/home.mount
> @@ -0,0 +1,13 @@
> +[Unit]
> +Description=OverlayFS mount for /home to /data/overlay/home
> +Requires=etc.mount
> +After=etc.mount
> +

Why is this not data.mount too?

Otherwise looks ok to me.

Cheers,
Quentin

