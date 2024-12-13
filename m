Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D43E7717F
	for <webhook@archiver.kernel.org>; Fri, 13 Dec 2024 16:19:44 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.75])
 by mx.groups.io with SMTP id smtpd.web10.19805.1734106778150539799
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 13 Dec 2024 08:19:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=lf9ygv0i;
 spf=pass (domain: cherry.de, ip: 40.107.241.75, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zS/qFqG0bK1+uw+N9KFH1fksawfnWqgVJZON+Iiet9gyIw0JZS3QH8ajxSRxXabYr7YcyBCSajAUjdgGpEtrpR+WxvASepVWxLSju0R8ubJjWNlppAAuYGyH28VBou83w0q7Oe8eAVKy5XoHwNB47Kb0SQX9OcVSBm7HZyZ5+I4V6obYZsYAxzqNghzQs+exN5sz5VLsMPkAHEcrP4RVWfI3BXGbchHS+Uv9nRILMhR3/xxPf26LnYlzhDsXOqGPL+dk98xAAckFpU7BV37CDNckiw7WNjqMll0/0DeJ68qJKzi2Ggc8cfD2xzGw8J/kymd26yhdVhS056Xp6cwKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiRC7qTYQxjuzKdclyWjowFZdmV1vwGkRkMqjCVVUnI=;
 b=RAg5lc4DJAwcrD0iAOhuebTDycmjU1dfNSh40twY0y6b7GUwZYlz9Ca+Hdq8zcaM3urcNCQBYfZTkhGwgFGrcWUI3aYEvMCK4zZWFSr24/Egda6URlzThnPxtYK9jreQTpGIQ/RkF+POsOo1CYLl8FCnyNpQ/1igLaqjncl581r/VcZPZDHnpalhHE4gUEfwCDEB1EVopk24+r1wm5mvmugyMe8n03LPyGXaR3ZbKRnuh/V6C6L3p0ecJGpOxLCiePkUO7JHf5ltemUmsCHOShbiKAcb0Ul2tItE1dcNFTnC7F18MzktdM9qKdJ3mLYpCLrht43IO7WbYKNyScQg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiRC7qTYQxjuzKdclyWjowFZdmV1vwGkRkMqjCVVUnI=;
 b=lf9ygv0iksgVWyxYLzO3E63xDRCeJqa8oZzL54wzAvlyz7PC35ZxNnCzBqAOkRJc3y0i+TnM7hmSku8yWi41J3e0yHrl6hlrsCCDhsyCZ8VevJTZjtZNB9eFzmKRyGv3KiAMr8j/ABpaNGlgaMYnZ11cFSRaBAyeqvdTswZkRqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 16:19:34 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 16:19:34 +0000
Message-ID: <12a084b1-c7e4-45bd-9eb5-ec6be7136363@cherry.de>
Date: Fri, 13 Dec 2024 17:19:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/4] u-boot: switch to
 upstream SRCREV for rk-u-boot-env
To: yocto-patches@lists.yoctoproject.org
References: <20241213154843.27592-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241213154843.27592-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0299.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: eaae62f8-d6e5-485e-fe78-08dd1b91ee68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?elRkcnMrcC9tZkZsbFFSNkVhTU0wb3orWHRJbVY2KzNmTndsUDdIVlRxME5Z?=
 =?utf-8?B?U3BYNGJuWlowYjNzaG11ek5iMWNVaWZuNGh6MmtIUEl5a0Q5OW5PRkJmc1o4?=
 =?utf-8?B?SmVaVWVYMXQrci9VNmFUMjNua0I3NWtjWjF3cTgweXg1WWVPaUZxdUxMaFpn?=
 =?utf-8?B?MVBwR2ViOHhKR2s3WUFUMm85M2E0MHdxcU9uclV2RndQTytWZXJIQzlqS1FW?=
 =?utf-8?B?S1hjSk5kdURZQnlDcnMwSUwxYkplWWx5WVFnZTlRQldKQ2JJN3JDTW5qT1Zt?=
 =?utf-8?B?ZUxTS3YwcjFGTjUreHFnSTV4UWNYbXFPZkorTG1WbXh2SC9LZURER3ByRFBN?=
 =?utf-8?B?UHdXRjRKR3ZEMjBXSXcxS2lzN1N1Nm5QSUtvR1ZUUEJqbCs5UjN1WllpOVk5?=
 =?utf-8?B?a2xES3QzcHRmYXdtWVRPeWJTOStudjVveGZLTzV6Uy8yQkQxUlVHdHpMMk4y?=
 =?utf-8?B?bkpWcmgwUFZEdW13UHZVWkJLeVlxdHYwUDdEZExHRlJTNjRXL2JyVElxNUht?=
 =?utf-8?B?blhNaS9KeEFZUEw2VG9YeGJKZUlYUFZMOHdTK1FXOGVOdXA0ZkVxcWc0Vlgr?=
 =?utf-8?B?S1QyWG15SFBKRGN6bkltY0JYSFJyWXVESUpyZkc4ZW1XRWk3R2cyTzljQUU3?=
 =?utf-8?B?dTJQN2lsRTl2ekJwdGh6MDNaNVFTQWRnRlhjM044U0M2UmlHdlNIUGdoanBX?=
 =?utf-8?B?clhQcjQyRjE3RGV5eHMyMlF3a1NTRnpGY3ZsR1NaQkRqQWtYYU0wb0s2Q0Ix?=
 =?utf-8?B?cWh3NElzSVNGM0E4aDlYTDR4YkNkUzN0eHpxbGZDYVM5WEs3Qk90SUg3eTNL?=
 =?utf-8?B?ckVtbjRncHY0NW1PRk9BZFhicDNsNExOcFNIcWllRXYxRFluMG1uN2dZcmtQ?=
 =?utf-8?B?UFl5VUwyTnk0bVdnVTRtcDhhcW40K29iS3pRQkw5eEZocFBla2dPb2o0VHBJ?=
 =?utf-8?B?M3BwcGtHbkVJVDJBckF2VitqZzJXMEFCUGdBZWNnMjB1UnBoeHczOVFLWlRW?=
 =?utf-8?B?OHhmbGRTcGZMOGh0UTdFeTh4US80MFcxa3c0VWpuOTJwUGFwN2VtTVF6aElw?=
 =?utf-8?B?c3B3dGF0NTc2ejFWaDFUdDJ3cXlYWHFuSlZaWDJmNHMwMWlhYm9DaGdKT3h4?=
 =?utf-8?B?OVFzRDF0aGU4ZHUrdmF4Z0tkbC8wTVBydVE0ZlVQYjZIVllpVGxydG5xYThU?=
 =?utf-8?B?V2p2akNaN3kzcklhVDNTblcyMHU5UHNHVHpPZzlJMnp2cU1STDMrcmRFaFFt?=
 =?utf-8?B?MUV3azdBcXNsNS96N3hTbFMvQ3N2eWowMUhlVFJ5VXoxcXV6UkkzSnVqMWZy?=
 =?utf-8?B?ZG8xU2NtOGhLWHNtR0V5R3hnV09qSVRVT2hCcmYvSkU0OGFZRGdaS29waHJq?=
 =?utf-8?B?bnNVR2hjZGNhaGtLSGtlU1E2TEpZNHdlbXo5UHdMaHV4aHlJTFpFUUVaQmtG?=
 =?utf-8?B?RmYyOEd0dTgrRVZPd3VLSmU2L3BFbjZ1K0MrOCtNdVdYZTc1TzhxUmxyemFM?=
 =?utf-8?B?a1pqcW5FZHFpSmhDOGVQbDZVSmFzUkJ3enlwdG5XZ2dDaTkyR1dCRTZnQ2Vo?=
 =?utf-8?B?SmkxMGxvOU9MZXE5TExEUmZKSE9QUFBuUnJ6M0NienFNTzN5dlZlSEx0dU16?=
 =?utf-8?B?ODc2VGx2Wlo1NFNYN2YxWnBJcms0VjJoMG1ZK3JGQjhpWGhoS0dJOGdNUmZI?=
 =?utf-8?B?cFpFRkxib29WMkowV0lsQlh6d2pyRW5QdlZUcTNYSEdHc0pCejRyRUcyc3VG?=
 =?utf-8?B?N0JJUjA1R0JKSFFpNlBLbUwydXFFdnF2WVk1Um5WcGNBT01QZnRrSGk0c1hk?=
 =?utf-8?B?WmtYV3plQWNiWXRWWG5OZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Wmw4aDl6SnVKMkg1YzBZbHFKU01EYTBtMVN2Z0U5Z3ZiVEFwbTNHODU5NUlw?=
 =?utf-8?B?emprVDFXN1VvemRMbWNjcktQNFhWSnhQK2VVV3Foak5qbmk5ZUVrZUdtZ0Vp?=
 =?utf-8?B?ZlNWZUJOTDhPMVhHYW1oWXJpbVA3Rk9hOGVubjlsNUNqNEU5dFhjaEVGMnVP?=
 =?utf-8?B?aUlhYTA5V2VLaFhUWjlPc2tPanh1ZkZCNFIyN2pFTzRiNWtva0VaQjBxcGcz?=
 =?utf-8?B?Y3p1KytrSmd0cnl6NXVuTUtJTmV1dm9CMTk2WTdsK09sMFFkdnA2aFVTcEl5?=
 =?utf-8?B?VWR6aVhIWDhrWUhUbUcwRjVSQ2I1T2h3QjQvTENXeTVZZU1pY0FDbEZIR2xQ?=
 =?utf-8?B?MlcrbWgydGp6QXcwSFF3TktqaStiZkpzYVNLRGh4Z0c0dzZiY2VGZkRYWmZa?=
 =?utf-8?B?Y2tYL0hsU0VPa3hIVVFJSXd3empERDZZOEVFM0ZVRUh2RDVISkRPbEdIRjk5?=
 =?utf-8?B?bFM2VEU1enQ3cnhnL09RSmNBT3FvQnA5ZHUrdE9UZzNmNE45NkljTy9KZVFI?=
 =?utf-8?B?bGJSWmxTN1NIMkJRUUZENXRObWRuSXpsZTY0OHQxQlM3NWVZdWgvb3VUTGlU?=
 =?utf-8?B?Njl5bzdPRDdCRVhMeHBHazB0cVV6UHVtanJIcnhIR1ZrcTFIbEx1bmRJOVNy?=
 =?utf-8?B?NDZTV2VKanFLSjNEVjcyVFBrZThnV0hYMkZGZ3V6THkxYWFWTFF5UzJMOTN5?=
 =?utf-8?B?d0YrTzR2aFNReEtHVXFqUXg4bm1ma2NwOGhZSTNEVFgySm5yZDNHUnpuMHRv?=
 =?utf-8?B?VWxPNHJtL3JTclNERVltYU16K0xRcE04UEdSVGNZRTQwTlptQUpLd3FsMk9V?=
 =?utf-8?B?SnpZTTNRZjFOQno0K284YzBpQTRLeEQrbWNCRDRRUmRweXhSdGJUVlFxYXE4?=
 =?utf-8?B?c3pBeDRSUHlWSkx3MEdXdzE2WU1wN1JYVDZuZm5mbitEU1k4aEtyZHoweFFp?=
 =?utf-8?B?MnJDQ0Z3VUlIeXVGSlBONXI3cGxpdVcwSjBFanJQcm42SFh1UlBQajArYjVO?=
 =?utf-8?B?TmozR0Z5TnJjY3N1T0dtakZZYjkveTlwVncrTjFSUGZCMlF1MldCM0lIekpO?=
 =?utf-8?B?RzdITmlBMjQ4TXVBTGZKNUZEcm5samJYQ3NFcmE0Q3ppRmNadlZRVXlLTlFR?=
 =?utf-8?B?TzFJdE0yMzU2QkhvSGlBQmdmUWcybzh6cjFuaHB0ZTVsT2N2Q1FkVzBidWNX?=
 =?utf-8?B?eUNvQ0t0Z2svQmV0WCtubUo3K0RRUUNONSthUkFLL0pQamUxVXh1UnNyUC9G?=
 =?utf-8?B?T2J2elBrbm50dTI1akxlR0VWaU5VWHpSaEx0d0xCbGRaNGREMHo4TTExYkwv?=
 =?utf-8?B?TFEwNkU2YWNVeXd2cUpBWGZIN3ZoamdqUm1ZL3R0KzBxR29NN0U0cW00Skg4?=
 =?utf-8?B?bFdOajdrUE0yZnpPTmRwVm5vZk5IQyttZzFScDI4OCtqQ09pcTIrWTRreTdB?=
 =?utf-8?B?UzlRa2U2RUY2NEN4TEthcHdjbFNFMjBGbTExd2tOUmNRK1EzWkt5WHJ6ZXBw?=
 =?utf-8?B?b1huVXZITCs3dXM1REp4NHBRQUxxbDY1eDIxYTZwdEFqUDg0VUFmbDg5YXQ2?=
 =?utf-8?B?eDNpeXpqdzU5WFNyd2NydWFSNVR6eUpvUFlpOEdSdGdTWWdpMmFGYTl4ZGMx?=
 =?utf-8?B?TE1TWm8wSTdGS1NXYWptSitOMktZQ3lzUkF1dEtQRmhndG5WZEFJVEhEcWlk?=
 =?utf-8?B?d2hCVTFpOGdFbDdYbkdWdlltaEgwdEJEUHBpR0lnUkNuNEVmQSsvRU5VN3Fm?=
 =?utf-8?B?enlFcktIaFduUTZJaGVhTFJpcHFCWGtYc1F0ZDIxYXdyREdJS2tPUXhneE8w?=
 =?utf-8?B?QTliNlBDUFF6ZlNUWHZPdDdFVGk0bWxZbE5lM3BzL0FrVVpDamZkK3k3Tzk0?=
 =?utf-8?B?UEJ5cUpiSC9PUkxZZVYyWFB2MkdYWmtPb09CT0VWUkE2QVRFQ2R4Nmt1N1ds?=
 =?utf-8?B?WGlVbzFMNXBTc3hWUU9hVnkyOUtvblczMGh2RlFzMjUxaklScU5XWkZUWGNq?=
 =?utf-8?B?U3oyVGN0RWl2N2Z2RkF3anl1UncydmpQNERNSVJzMkZNbTUwMGZtZmxhUmpv?=
 =?utf-8?B?YzY5UlhLTW1uaTJSRXRQTlpwV25hc3hCQ2RKeWtBYUpWVWpqYUxZMUNWckdp?=
 =?utf-8?B?VzdyQU56amJOTkw4WGJJd1NrTHczbnhWNU5VbXRLeSt1djNDcFlxZ051dFhP?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eaae62f8-d6e5-485e-fe78-08dd1b91ee68
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 16:19:34.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbyO2LZGVqtl9MPzvxg1Yy5Dd6qXhRqbf2ky1JW7RiJfEbEYsiWmn+cvd9Cf/3O8zF8gNMvV/RLZ3AjgBSdVoAw5ASpcku3+3ITkWFGoPXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8016
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 13 Dec 2024 16:19:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/904

Hi Trevor,

On 12/13/24 4:48 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> When the rk-u-boot-env feature was implemented, in order for it to work the
> build needed a version of U-Boot that was slightly newer than 2024.04 (the
> current release supported by Yocto at that time). Now that 2024.10 is out,
> remove the SRCREV pin since the necessary code is now part of this release.
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Patches 1, 2 and 3 are only applicable for master (walnascar). This 
won't work on Styhead. I believe we need to have a branch for Styhead 
now where this won't make it.

Cheers,
Quentin

