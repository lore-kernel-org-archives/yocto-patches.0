Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F96C77B7F
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 12:59:39 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.50])
 by mx.groups.io with SMTP id smtpd.web10.18999.1750683573860196958
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Jun 2025 05:59:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=gvfI0D7d;
 spf=pass (domain: cherry.de, ip: 52.101.84.50, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArY4i2FUhZ5nLWUGrjKObocgoCT2AfG8mfdTGqIhRFIkVtz4bf8vJxu/QJur3uyDoQh5Ywv0lkNIi8+fBUpQsmVweURvIVP16HkUJIiJYUlgYYaHtn9qMOs54Hhbqa9AxmG6BsGPfySvPBjy3nc3h+hEyScRLPOzQDPEr9hY3EYSQpXDuoW35fzI3Hq+WPqC0pt4Ig5Fn9tlBdR/LUDuMVv0RngffJbzMseNcBeRVtjYUdQaob2B0OJWJQsYNYo82pfnkSrRvlCHP6yT+l29D0PHyxhTdLEOlPHavm9xTr9jsSGWuzjgjVvVo0CR+p1X4zEfqgI23Uj6yHvfn1GEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3e+A2c2MVxz9etnmNJ+YFA2uEr8orgHtsTOH3jgLLU=;
 b=hi2QKH/BzdDICuaLG4tz8aVXUyFkR1wpual1ftupBECdmaerKTPQeaHqVXCJOUuP/NElmuQROBlwJ+HManWbKz3aHgwGJylYPj9vfjAvqYUGz+3Cuh88aV6ojGEHAZVBcsOE4pX9Fras9rY37fO4uFCkFmCzQtzi8COEchhIGsdl3aLx8s35v5J4o5kip08AUcKAnyUb5nOIsgkQpyLRZWEcn2qSG/wzayh5a/WQzyuOzLyBBAjkDifKbtNm1ZDiHCV5zCH7uAR/zslShQXoIL9os9Efoh9zNPcbyRmGlto8zrFY0rjh/jW3S3OdjZP3Nxx1/wxd1CCetFmPRMQwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3e+A2c2MVxz9etnmNJ+YFA2uEr8orgHtsTOH3jgLLU=;
 b=gvfI0D7db5i4xAbKTId0dYuF18R2dUVofYsddeIIO5WW72DjYHB44pKKklUwiPsmap0y8oQpcJEt2eFOlmLwYYpBwT7kkAhbH22tSZwyTJHJIt1sG6400H6RE6nltxVMQlbRlxr3rCuMcYzesjQJwNYzDF0lyysad1wV4XfD6vU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:59:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:59:30 +0000
Message-ID: <2db7249e-db5b-445c-9e66-9ca7e4d641ca@cherry.de>
Date: Mon, 23 Jun 2025 14:59:29 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v3] fitimage rework
To: yocto-patches@lists.yoctoproject.org
References: <20250613164101.20700-1-twoerner@gmail.com>
Content-Language: en-US
In-Reply-To: <20250613164101.20700-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0315.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: e14e5bf7-8374-4b0d-2d30-08ddb255ca8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RUl3RXVLdkJrbnJralg1YVhYMXFrRldGVS9KNit0cWpaR1l6Ymp2RHlMb3hu?=
 =?utf-8?B?VWZXZys4YUVhVzRJMUdCMkpocjFpTWU0L2o1dHl3ZGd6ZURLTnp5enpsWkl6?=
 =?utf-8?B?a3FGSnNXNDRncGVQUFBVdTJYb05lR1E5VnZLZk50TUdxeGZXTzJoYlBYck5G?=
 =?utf-8?B?djRscCsvOUx0cFVnQUhDMDk3OXU1Tml0T2xqdU15UHhGanlUczMxazdvYnNS?=
 =?utf-8?B?ZllmQWgxVWVpVDVsTCtXZytUcWRYbTVyVFVmVWFVZ2xnbmJBTlVqREpONVNB?=
 =?utf-8?B?TTRiV2ViaVhxQjJYbFNVOE5XWnk3WlQ2elUweWNzNlVHNHVHR2FpdVlQRlBm?=
 =?utf-8?B?MTNlMVhERUV0VDRMTDlVbTNhZEpnUUJrKzdLbGhFd3o3YTkrM0llWVF4ZGNh?=
 =?utf-8?B?RzdQVXVOM2FiZ1Y4ajNPaVkrTkZEc25zdTUxU1JhV0kvMmtxQk9QVzd0UjlW?=
 =?utf-8?B?N3p6SXpjazFxNWlkNVgrWGt0NEFqQVBiejA4cDVOMnF1VzBHdUNVbXB5ck5z?=
 =?utf-8?B?ejlIdVdMRXNRUmZqWnNDeWlWaXdDcFVFcHo0ZnFjNXhpTTl3Szl2MWxqOXlq?=
 =?utf-8?B?dUgwbUhlazgxK0k1NGxqcVhxcEU4QTBOZFh0eG9ET1lCaGRkZ0NTUHkyeUJa?=
 =?utf-8?B?aXVmT1hpZlhSVVRlZXhCRjdXWTlNcWxIdXJVZlRjRkN2Q2kwcnJRMDBGOEJy?=
 =?utf-8?B?ZWtYRjhjYTd6alB4eGRyT0xzTGVLZ1ZWZUg0TXAwa2E4NkhQOWJDREhremFW?=
 =?utf-8?B?K0YyMkJueUpzSVR0THZFdnlmOE8veGxyaWNZM3lDckUyNUw5SjBhVHJwWldv?=
 =?utf-8?B?ZUxvelJSMkpVbkpKNFRyTzl5bms2dEcycFZuY1pFZG5zYVZjbGh2cEI0bWFx?=
 =?utf-8?B?Si9jSXdGZzVOYzBYaEl0b0JuSjVMSGpWeVRDazdiS3Z3Z2JyNlY0MEhsZWd2?=
 =?utf-8?B?WXNjVkFlUzhZb3hvRlB1VGtUanpCdU1TU0dUZUY1TUljeG5PNVd2UTM5aU53?=
 =?utf-8?B?bFdQS1d2Y0x1a0J1VFR4WDVoRjNPT0tnZzVFV1NzdTZnVENyTm9MSGdtcXlj?=
 =?utf-8?B?ZzV3VzBJS2o1b2g1ZmJCUnovaEIyQzVZWFF3Q0l3VlBINldiWmFQRDloS1RQ?=
 =?utf-8?B?TERDR0FTMlIvNEFqVG1hQXBRZ2x6eFUvNWszQllqMVhIeFJ2RmVQTHlUSVFi?=
 =?utf-8?B?SFNoQ2RMTDdJSlZocDc3NG9wMThlb1h4c2JuT3JyWVFMNnpXVnBaa2ZMdzdz?=
 =?utf-8?B?YnhpZElVVEp1djdZYTV5QVBzZGhHdU40ak8xMXNvZXBkbTZ1ODVPT1k3MENF?=
 =?utf-8?B?ODhNZVhXdWtnZHk1Wkhwd2N3ZGR0RktCZTExUjRDV2tOV0RvdmhtMmRjSThE?=
 =?utf-8?B?UTBSQVhGRFBJRmpJWElRU0Z5YzRoLzJQaWRGRkxWWjBqSGhFWEVha28xZTli?=
 =?utf-8?B?am4reSsycCtKYXJrZldJc3piYWFOYXRaYlJmazNqdGRzVW1xU1pYUWdjVnF4?=
 =?utf-8?B?K25teWFhR1E5OCtBOTQweHBYNWJ1N1RKbnRDU1ZpYU9mTXJNOU1ldWJ3RXdn?=
 =?utf-8?B?ZXdxb2dHajRXQUdPckxobGNkSTYwRit3MGJUT3VjUk1iT1QrbThqUVZPREpG?=
 =?utf-8?B?MUNOSThCR0h3LzYyUW9JbndPenlSb3QwdHlJVXQxVXplL09FTEg0Z29WSTZ5?=
 =?utf-8?B?NHU2YjkrZndtY2N2ckZjK2RrUHN4MFpWSStVczN6V1RpT2ZSSnY2TS9yeUt2?=
 =?utf-8?B?c0dBbXhnMk9WNkw4UEdSZDB5SEFEdjdXaUdoVUh5TmlKaU5XY2xuVXdML0Ex?=
 =?utf-8?B?dS8wOENWMnVyR05WTGtyazZOdFVJUkk2cHJDSnFDS3RPdHVQdTVFTjdrdEYv?=
 =?utf-8?B?c1Iyc0VMUEJoT3poSnc3dko0YjY4bERBUDh4ODdJa2pEQURtRm9kSFJETUF4?=
 =?utf-8?Q?2L74RN7jeV0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S1pONXVMM0NqajJPdlN2Wld1ejZoWUJaWTZFWXBQcC9Iak9sS2tiaE83SWVx?=
 =?utf-8?B?U2MyTWJHNUltaVBEdG93cnB5ampWTTN3WDBOMGErRVZHeGhGbXd2dVViRGQw?=
 =?utf-8?B?NFY4SzJaR09jMDNGRlB4MWh5NmtWSE82YVdEU0lLZzVQYzZIK0ZGVXdoSXVm?=
 =?utf-8?B?ZkM2U1AySkZlcHBHVG1vMTNYT2lkbDl0dXBMQzZid3pyLy9UL1ZOWkxIUWhy?=
 =?utf-8?B?aXVWSkttUjBFaTBNU2ZsRDNKSkhHa2FaRVJXT084M3hqc3cyN2ozVXNMdzlU?=
 =?utf-8?B?cVpwVHc4VnlZMTlmRDB6UW11VGcrdjMrc3ErOEs0ZkppSThDWHF0TFhBMmJQ?=
 =?utf-8?B?My9QblJnVVVKVjBMamZub1NPbm1DRWtZWVBKVHlvVTB0MWNDYm9ubHdiTFR3?=
 =?utf-8?B?eS9DYi9BZzRaVmtCQ1ZkVU1DRmErMldyTkllTkJyVGgwZlNFSFFvRTIvVkl4?=
 =?utf-8?B?SmtxQ2pMVTgybEphMUVRNmxDckNySjFhRmZnSjlMdjZ6QktiRzA2bU5yMFV5?=
 =?utf-8?B?LzcrR3liOUM5WFRFZXI5RjcyZXQ3ZlpHbUppa3ZSWklXL0VDNzNBRTRTNGZN?=
 =?utf-8?B?RDE0QTV4TUMxa2Yya0ZpWEgwZDhzM0lPaUc2V0xrT3dONFdPZTU3MElXSE1Y?=
 =?utf-8?B?VTFVZG1ES1BQTkZlUEhXeGxBUEFvMUdEK0k0RlZlWVdtbTF6M09qZFZycXY4?=
 =?utf-8?B?K0J6MnRKVDBrbVlMcDNnT3lDdHI4ZGQzRENGN1Iwa2NLTGQ5Q3QwczlaQzc5?=
 =?utf-8?B?SWNienJmWnlIaTI0aWRhWUFGZGh4cjl3U2Yxdi82OEFjVStTZlFKVHNvOGc2?=
 =?utf-8?B?RkpIallMendIeG93c0p6bWs3SnY4RHBKR083Y3dGOWRHOHdQaWpjSU9iVWho?=
 =?utf-8?B?Sm83c1JNM1EyMkVuSTdIVWkrSUp0TkluSVB1bFQ2S3R6YU9SYTBCYXdQd3hz?=
 =?utf-8?B?Nk1JSW5EQVhpVk1TZFBucDdEdDA1QWdnQzdleFM5a0tPWHU2Mm1YTitmeHMx?=
 =?utf-8?B?aHJIckF2d21MRnJSdytWbkZMZWJjcGYwSmJ1bmRvNVU5NS9tdkNvTTYwR2ZR?=
 =?utf-8?B?VFhEL1pWQ3ltZHhVVGYvb0ZKSGZMY2Z5ZkRiQktKTXQxaDVBakQyOHZkZ3BM?=
 =?utf-8?B?T1hCYUFEZmJWWlNQKzhwcFFuRjN1MlNJVHlKTDNUdUR4K3hMc3VRTWNtZFpq?=
 =?utf-8?B?SlJRRzUxemZBaU5LSEJSWWc5TFMwZ05vUXVjVGZNTDhoUUdURFhaRzdreHU3?=
 =?utf-8?B?a3pEZStyVG5DLzBnb3ZxNi9QWnEvMUNZbm1wSllzWWxUMnl0RG9TVzVVQytT?=
 =?utf-8?B?cTVkd0NiVUtBQUVMeDRwNE9GMFdvbVRxbER6ODBsSmJZanlHMUN0V2RNclNZ?=
 =?utf-8?B?eUJaZ2NlaGk4UEhkbmh1em81cEx4VVpCaysxRDVTR20wZ0tpOWk0Z2dEbXc1?=
 =?utf-8?B?QWJhMlVSdUJhM3BYN09Rdm5ONmRZeFgwdnpXY05UZWlsUHhzTDd0akxnVGpK?=
 =?utf-8?B?a1paSjhkcU5HSU1QU1cvQk5VcXFPMGtuQmpUTm9jenZJbHczY0p1aEorTy9H?=
 =?utf-8?B?VUZkejh4Zkd2NUppbldVT3JudHE2M1ByU2xDeVFWTFpUVWFheGtBZUVtYnJ0?=
 =?utf-8?B?ZVZCUFJ4MmRIenlxYWxCcmNRcjc1UzJxODRNVytLcmhER0NIeHJzUFBybUdx?=
 =?utf-8?B?TS9LQjk1YTBGa1JnbENVbHpjcExZbFg1NjJnbGp2Z0FROVNqNXJDOFh5Q0tF?=
 =?utf-8?B?ZGdhOGZQMVcwbXpjL3FFZTczTXB3NW5yZTZybWNDNVN1d0k2eUQ3eFRESFEr?=
 =?utf-8?B?T2RnY1ErUkZuOEJUUWFHMlVkOTBML0lsMlI2UDR1Q2ErcUtiU01oWXVOM2Mr?=
 =?utf-8?B?d3R0N0FvZ21iV3pRQXYwWjBkQjEvQjcwL0NiWEtzdlZFSWtnY0hMK2dacmpN?=
 =?utf-8?B?WGdIaVdHVGZXQmNrSDZXdDVJTTJxVEtzRExlUFR3RnYwSkNhSUZoRlgrU2lX?=
 =?utf-8?B?WXhhalB1SGQrRE8wRzM4Y3E5MmtJVk1ITmRRVGxZZkc1QWFCUS8ya29VSm1I?=
 =?utf-8?B?M0tTSjIxSnFzdmh6L09lSWxnSWxVK3Z0YnJQQ1VCSjRlMmlhMnBhcTRCdHhi?=
 =?utf-8?B?cXpPR3NTUG1taWRkUFowV2VzaENmamE2TW03Sms1VVVTRkdjSmYzVGNIem56?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e14e5bf7-8374-4b0d-2d30-08ddb255ca8b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:59:30.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xI01GM864oOuF4xrnzFnyqvtS9eklIaDlwh9tPG8XEgg94cvnYSxS/FDojzgSm9JqHLyH88QZghYt5avTQ4ZDAuquKWGaT7eYMoSQcCI9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Jun 2025 12:59:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1676

Hi Trevor,

On 6/13/25 6:41 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> oe-core has completely re-written the fitImage support starting roughly at
> commit [1], update meta-rockchip to match.
> 
> Most of the MACHINEs in meta-rockchip use a fitImage, but some don't. Create
> a boolean variable (RK_FITIMAGE), enabled by default, to keep track of which
> ones do and which ones don't. Use this variable to decide how to configure
> various image-related fields.
> 
> Run tested on the following with RAUC configured:
> 	- nanopi-m4b
> 	- nanopi-r2s
> 	- radxa-zero-3e
> 	- rock-pi-4b
> 	- rock-pi-e
> 	- rock-pi-s
> 
> Run tested on the following without RAUC:
> 	- radxa-zero-3e
> 	- rock-pi-e
> 	- rock-pi-s
> 
> [1] oe-core: 3442d9297dca ("oe-selftest: fitimage: test external dtb")
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
> changes in v3:
> - remove the 2nd MACHINE_ESSENTIAL_EXTRA_RDEPENDS from the
>    rockchip-extlinux.inc file and place the relevant portions into either
>    the rockchip-fitimage.inc or rockchip-unfitimage.inc files as
>    appropriate
> 
> changes in v2:
> - remove the ",False" from the bb.utils.to_boolean() calls
> - add informaton on new param (RK_FITIMAGE) to README
> - re-structure the fitimage require so it is less invasive in
>    MACHINE.conf files
> ---
>   README                                       | 7 +++++++
>   conf/machine/include/px30.inc                | 2 --
>   conf/machine/include/rk3066.inc              | 2 +-
>   conf/machine/include/rk3188.inc              | 2 +-
>   conf/machine/include/rk3288.inc              | 2 +-
>   conf/machine/include/rk3308.inc              | 2 --
>   conf/machine/include/rk3328.inc              | 2 --
>   conf/machine/include/rk3399.inc              | 2 --
>   conf/machine/include/rk3566.inc              | 2 --
>   conf/machine/include/rk3568.inc              | 2 --
>   conf/machine/include/rk3588s.inc             | 2 --
>   conf/machine/include/rockchip-defaults.inc   | 3 +++
>   conf/machine/include/rockchip-extlinux.inc   | 7 +++----
>   conf/machine/include/rockchip-fitimage.inc   | 5 +++++
>   conf/machine/include/rockchip-unfitimage.inc | 2 ++
>   15 files changed, 23 insertions(+), 21 deletions(-)
>   create mode 100644 conf/machine/include/rockchip-fitimage.inc
>   create mode 100644 conf/machine/include/rockchip-unfitimage.inc
> 
> diff --git a/README b/README
> index 9672c6ab8d5b..5a12f6118fae 100644
> --- a/README
> +++ b/README
> @@ -159,6 +159,13 @@ Notes:
>   	compatible (see Rockchip Media Process Platform (MPP) and
>   	downstream gstreamer-rockchip plugin for those kernels).
>   
> +  RK_FITIMAGE
> +
> +	When generating an image, the BSP code needs to know whether or not to
> +	package the pieces as a fitImage or not. By default it is assumed most
> +	MACHINEs will use the fitImage format. Otherwise disable the RK_FITIMAGE
> +	variable boolean to indicate otherwise.
> +

Can you specify this is for the **kernel** fitimage? There can be many 
fitimages and we actually could generate one for U-Boot (u-boot.itb is 
one for example). This impacts only the kernel fitimage. Maybe also 
rename the variable to RK_KERNEL_FITIMAGE?

There's a very important piece of information left out here, this 
variable needs to be set before any include in the machine configuration 
file otherwise it won't work (I believe, haven't tried myself). This is 
the reason why we have inherit_defer now, because "dynamic" inherit 
simply didn't work due to how BitBake parses inherit and expands the 
dynamic part of the inherit call. Since we use require here and there is 
no require_defer, we don't have a choice and need to force the user to 
set this variable before the require line is parsed.

>   U-Boot Environment:
>   ------------------
>   	In order to configure U-Boot to be able to store its environment into the
> diff --git a/conf/machine/include/px30.inc b/conf/machine/include/px30.inc
> index 8173cb19be2c..1997f6fe6a9d 100644
> --- a/conf/machine/include/px30.inc
> +++ b/conf/machine/include/px30.inc
> @@ -11,8 +11,6 @@ require conf/machine/include/arm/armv8a/tune-cortexa35.inc
>   require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
>   
>   TFA_PLATFORM = "px30"
>   TFA_BUILD_TARGET = "bl31"
> diff --git a/conf/machine/include/rk3066.inc b/conf/machine/include/rk3066.inc
> index a898309bbf88..90cadd82fbf2 100644
> --- a/conf/machine/include/rk3066.inc
> +++ b/conf/machine/include/rk3066.inc
> @@ -2,6 +2,7 @@
>   # Released under the MIT license (see COPYING.MIT for the terms)
>   
>   SOC_FAMILY = "rk3066"
> +RK_FITIMAGE = "False"

Please have them all still be ?= "False" so it can be overridden from a 
machine conf file before the rk3066 include.

>   
>   require conf/machine/include/soc-family.inc
>   require conf/machine/include/rockchip-defaults.inc
> @@ -11,6 +12,5 @@ SERIAL_CONSOLES = "115200;ttyS2"
>   
>   KBUILD_DEFCONFIG = "multi_v7_defconfig"
>   KERNEL_FEATURES:append:rk3066 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> -KERNEL_IMAGETYPE ?= "zImage"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> diff --git a/conf/machine/include/rk3188.inc b/conf/machine/include/rk3188.inc
> index 554d4f1c904d..23c2a806b3c4 100644
> --- a/conf/machine/include/rk3188.inc
> +++ b/conf/machine/include/rk3188.inc
> @@ -2,6 +2,7 @@
>   # Released under the MIT license (see COPYING.MIT for the terms)
>   
>   SOC_FAMILY  = "rk3188"
> +RK_FITIMAGE = "False"
>   
>   require conf/machine/include/soc-family.inc
>   require conf/machine/include/rockchip-defaults.inc
> @@ -11,6 +12,5 @@ SERIAL_CONSOLES = "115200;ttyFIQ0"
>   
>   KBUILD_DEFCONFIG = "multi_v7_defconfig"
>   KERNEL_FEATURES:append:rk3188 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> -KERNEL_IMAGETYPE ?= "zImage"
>   
>   ENABLE_STATELESS_VPU_GST ?= "1"
> diff --git a/conf/machine/include/rk3288.inc b/conf/machine/include/rk3288.inc
> index 06fda69a3eb7..793a80a72430 100644
> --- a/conf/machine/include/rk3288.inc
> +++ b/conf/machine/include/rk3288.inc
> @@ -2,6 +2,7 @@
>   # Released under the MIT license (see COPYING.MIT for the terms)
>   
>   SOC_FAMILY = "rk3288"
> +RK_FITIMAGE = "False"
>   
>   require conf/machine/include/soc-family.inc
>   require conf/machine/include/rockchip-defaults.inc
> @@ -11,7 +12,6 @@ SERIAL_CONSOLES = "115200;ttyS2"
>   
>   KBUILD_DEFCONFIG ?= "multi_v7_defconfig"
>   KERNEL_FEATURES:append:rk3288 = " bsp/rockchip/remove-non-rockchip-arch-arm.scc"
> -KERNEL_IMAGETYPE ?= "zImage"
>   
>   UBOOT_SUFFIX ?= "bin"
>   
> diff --git a/conf/machine/include/rk3308.inc b/conf/machine/include/rk3308.inc
> index d30901f15b4f..6876564fbcb2 100644
> --- a/conf/machine/include/rk3308.inc
> +++ b/conf/machine/include/rk3308.inc
> @@ -13,8 +13,6 @@ SERIAL_CONSOLES = "1500000;ttyS0"
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3308 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
>   
>   UBOOT_SUFFIX ?= "itb"
>   UBOOT_ENTRYPOINT ?= "0x06000000"
> diff --git a/conf/machine/include/rk3328.inc b/conf/machine/include/rk3328.inc
> index e6f810dcd2ca..2fe2710399b1 100644
> --- a/conf/machine/include/rk3328.inc
> +++ b/conf/machine/include/rk3328.inc
> @@ -12,8 +12,6 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3328 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
>   
>   TFA_PLATFORM = "rk3328"
>   TFA_BUILD_TARGET = "bl31"
> diff --git a/conf/machine/include/rk3399.inc b/conf/machine/include/rk3399.inc
> index cd1be49064ed..8d30cf7e460b 100644
> --- a/conf/machine/include/rk3399.inc
> +++ b/conf/machine/include/rk3399.inc
> @@ -12,8 +12,6 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3399 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
>   
>   TFA_PLATFORM = "rk3399"
>   TFA_BUILD_TARGET = "bl31"
> diff --git a/conf/machine/include/rk3566.inc b/conf/machine/include/rk3566.inc
> index 6386ec7eb51c..5b65ad7d4a47 100644
> --- a/conf/machine/include/rk3566.inc
> +++ b/conf/machine/include/rk3566.inc
> @@ -11,8 +11,6 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3566 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
>   
>   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
>   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> diff --git a/conf/machine/include/rk3568.inc b/conf/machine/include/rk3568.inc
> index bcf9dd8b0f44..ad3952de074c 100644
> --- a/conf/machine/include/rk3568.inc
> +++ b/conf/machine/include/rk3568.inc
> @@ -11,8 +11,6 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3568 = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
>   
>   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
>   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> diff --git a/conf/machine/include/rk3588s.inc b/conf/machine/include/rk3588s.inc
> index 6ec344abae5b..203b97c6353c 100644
> --- a/conf/machine/include/rk3588s.inc
> +++ b/conf/machine/include/rk3588s.inc
> @@ -10,8 +10,6 @@ require conf/machine/include/rockchip-wic.inc
>   
>   KBUILD_DEFCONFIG ?= "defconfig"
>   KERNEL_FEATURES:append:rk3588s = " bsp/rockchip/remove-non-rockchip-arch-arm64.scc"
> -KERNEL_CLASSES = "kernel-fitimage"
> -KERNEL_IMAGETYPE ?= "fitImage"
>   
>   PREFERRED_PROVIDER_trusted-firmware-a = "rockchip-rkbin-tf-a"
>   PREFERRED_PROVIDER_optee-os = "rockchip-rkbin-optee-os"
> diff --git a/conf/machine/include/rockchip-defaults.inc b/conf/machine/include/rockchip-defaults.inc
> index 85ec7b944d1d..4e77a6291657 100644
> --- a/conf/machine/include/rockchip-defaults.inc
> +++ b/conf/machine/include/rockchip-defaults.inc
> @@ -1,9 +1,12 @@
>   # meta-rockchip default settings
>   MACHINEOVERRIDES =. "${@bb.utils.contains('ROCKCHIP_CLOSED_TPL', '1', 'closed-tpl:', '', d)}"
>   MACHINEOVERRIDES =. "rockchip:"
> +
>   # kernel
> +RK_FITIMAGE ?= "True"
>   PREFERRED_PROVIDER_virtual/kernel ?= "linux-yocto"
>   KCONFIG_MODE ?= "alldefconfig"
> +require conf/machine/include/rockchip-${@ 'fitimage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else 'unfitimage'}.inc
>   

This limits us in terms of location for the setting of RK_FITIMAGE as it 
needs to be set before this line is parsed otherwise it has no effect 
(today, but it can lead to inconsistent behavior if it's also directly 
used in recipes for example which would then be of the proper value but 
still requiring the wrong file here). A nice comment would suffice for now.

>   # xserver
>   XSERVER = " \
> diff --git a/conf/machine/include/rockchip-extlinux.inc b/conf/machine/include/rockchip-extlinux.inc
> index fddab735bbf7..5753d062579f 100644
> --- a/conf/machine/include/rockchip-extlinux.inc
> +++ b/conf/machine/include/rockchip-extlinux.inc
> @@ -13,13 +13,12 @@ NONFITDT ?= "${@d.getVar('KERNEL_DEVICETREE').split()[0].split('/')[1]}"
>   
>   UBOOT_EXTLINUX ?= "1"
>   UBOOT_EXTLINUX_ROOT ?= "root=PARTLABEL=rootfsA"
> -UBOOT_EXTLINUX_FDTDIR ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot', d)}"
> -UBOOT_EXTLINUX_FDT ?= "${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', '/boot/${NONFITDT}', d)}"
> +UBOOT_EXTLINUX_FDTDIR ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else '/boot'}"
> +UBOOT_EXTLINUX_FDT ?= "${@ '' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else '/boot/${NONFITDT}'}"
>   UBOOT_EXTLINUX_CONSOLE ?= "earlycon console=tty1 console=${RK_CONSOLE_DEVICE},${RK_CONSOLE_BAUD}n8"
>   UBOOT_EXTLINUX_KERNEL_ARGS ?= "rootwait rw rootfstype=ext4"
> -UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${KERNEL_IMAGETYPE}"
> +UBOOT_EXTLINUX_KERNEL_IMAGE ?= "/boot/${@ 'fitImage' if bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else '${KERNEL_IMAGETYPE}'}"
>   UBOOT_EXTLINUX_LABELS ?= "default"
>   UBOOT_EXTLINUX_MENU_DESCRIPTION:default ?= "${MACHINE}"
>   
>   MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "u-boot-extlinux"
> -MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-image ${@bb.utils.contains('KERNEL_IMAGETYPE', 'fitImage', '', 'kernel-devicetree', d)}"
> diff --git a/conf/machine/include/rockchip-fitimage.inc b/conf/machine/include/rockchip-fitimage.inc
> new file mode 100644
> index 000000000000..87c1334c7060
> --- /dev/null
> +++ b/conf/machine/include/rockchip-fitimage.inc
> @@ -0,0 +1,5 @@
> +KERNEL_CLASSES += "kernel-fit-extra-artifacts"
> +KERNEL_IMAGETYPE ?= "Image"
> +RRECOMMENDS:${KERNEL_PACKAGE_NAME}-base = ""
> +KERNEL_DEPLOY_DEPEND ?= "linux-yocto-fitimage:do_deploy"
> +MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "linux-yocto-fitimage"
> diff --git a/conf/machine/include/rockchip-unfitimage.inc b/conf/machine/include/rockchip-unfitimage.inc
> new file mode 100644
> index 000000000000..6d4f23c67a65
> --- /dev/null
> +++ b/conf/machine/include/rockchip-unfitimage.inc
> @@ -0,0 +1,2 @@
> +KERNEL_IMAGETYPE ?= "zImage"
> +MACHINE_ESSENTIAL_EXTRA_RDEPENDS += "kernel-devicetree"

We could avoid this file by making those the default in 
conf/machine/include/rockchip-defaults.inc for example.

"""
require ${@ 'conf/machine/include/rockchip-fitimage.inc' if 
bb.utils.to_boolean(d.getVar('RK_FITIMAGE')) else ''}

KERNEL_IMAGETYPE ?= "zImage"
MACHINE_ESSENTIAL_EXTRA_RDEPENDS_KERNEL ?= "kernel-devicetree"
MACHINE_ESSENTIAL_EXTRA_RDEPENDS += 
"${MACHINE_ESSENTIAL_EXTRA_RDEPENDS_KERNEL}"
"""

An empty require (which we would have when RK_FITIMAGE is False) is 
legal and is a noop as far as I know.

Set MACHINE_ESSENTIAL_EXTRA_RDEPENDS_KERNEL to linux-yocto-fitimage in 
rockchip-fitimage.inc so this works.

I tested this with RK_FITIMAGE = "False" for a machine in my BSP layer 
and it did what it was supposed to :)

Cheers,
Quentin

