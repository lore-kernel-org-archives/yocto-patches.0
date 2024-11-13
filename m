Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66427D41C27
	for <webhook@archiver.kernel.org>; Wed, 13 Nov 2024 09:39:40 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.61])
 by mx.groups.io with SMTP id smtpd.web11.8098.1731490776879719865
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 13 Nov 2024 01:39:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=fBn1Khu5;
 spf=pass (domain: cherry.de, ip: 40.107.103.61, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjCotLVWH1u5ajX5KiEmDHRDbd9kXKeuk33HEsjyDgfx78/hSdMEwEtT+rYIk0SowtZ9tuhp8m6Xvw/CkwEGtBnwlwJDhtuORYzCAQ0yoBHOdnGEuCcZXEazYGN9DGeF7Lh/mDfFzEbHaHuY4m8T76j9JVS16DierxqKqQGfvGMdDI2vzW3+rUbQsoPXM7AxvEvHtfHk7r15x+54Ycd1QzqJip5WFXhmDUhbYs6zL/4R5W2RM+taL6y50Xk/Qb+OqeVE9TYG/TIlzHl9MGfgmi//5FY3H9nSpNV5n0kX1DbMlzWKqbkIdwoRKLrp+IXFbPuegesxEIlIILe/ZaV7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oh4qF0Z+qJt2uY5GqYknXoonfKdw1wmJVC6zeqq6F2g=;
 b=X6Ig6+VqGgH70M6Ag5p6N/3rPPF1yPbYfaXHHj3nmJQAkPXhqW5KhIjBK2ABG/gftxkzlTznqi8fip43sC4hqIPlAFE/qjcvlbon1Wo+dHP1TVjqXmFMUnfN8xq1VwHoX26oyKrb2rGF+G+/a2LieWT8JXGPJzrbcNYQFF5vTQ8gRTDITqYT0/fB36oaslFiAzRpQcsi9OLK8M8faI6kK+bTQsvegShe/aVkIreVcvTpVIj4opPxGiIE0tukm5HovNNhQq5qRu+UjIYfSWFJ0aaarstvs2FuqvByW5UKqWI6EnOEpwExy54JwJCvaMhsilRTklEv/nvQfFmHS9Tnzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh4qF0Z+qJt2uY5GqYknXoonfKdw1wmJVC6zeqq6F2g=;
 b=fBn1Khu5Nd9BHLQKIOsotc+K7PO6LLCJ3FVV+RR1D3FKNnbs7XA3VVVHUBEDXquOvCnrXJnFlp21MH/QaFps2MzqWqkcs5l68PLureoZn3SxgIOfMZXoNmh26pAKgJKNPSrQ5grlhwRIqioVTGkYpAqIiyLavh+TAslr1AWw2MY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB9081.eurprd04.prod.outlook.com (2603:10a6:10:2f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 09:39:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 09:39:31 +0000
Message-ID: <2664ede8-d88f-446f-9419-6372fda41361@cherry.de>
Date: Wed, 13 Nov 2024 10:39:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip] [PATCH] SOQuartz: add
To: yocto-patches@lists.yoctoproject.org
References: <2f52ba6e-4709-4b66-b23d-838cbf8d9d3e@trifork.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <2f52ba6e-4709-4b66-b23d-838cbf8d9d3e@trifork.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0167.eurprd09.prod.outlook.com
 (2603:10a6:800:120::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8800d4-b913-4cf3-eff0-08dd03c71308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjNjaFJWbEpiLzgzbnovWE05WXgyTVVxRm1QR1AxV1V5TlNlbHFEK296MlZO?=
 =?utf-8?B?dVZxYzBYRWFFNHpHQ1pwK2QzZmRLK1BkNzlnaVEwQTh4M2ZST04xTjEyTjFG?=
 =?utf-8?B?RkUwdjJhVS94cDVNVEdHckNIZlR4UTBXZUkzbUlHT0pTR2dJem1LK01YMksy?=
 =?utf-8?B?NDR0czZ3WGJjRG5lV2JuN3VXZHRxenBTT2pEN1B3bjMxTEZoQ1RxSTVqaDdr?=
 =?utf-8?B?WlBGZkhZNit3Tk9qTjE2dlRGeTc3aXVQTng5b1htNC8zQ29NRkVEeGlQSDc2?=
 =?utf-8?B?UENIaEQwTWtmN2NJVUNSTnovRkJJb0U0K0NrdzRudHNURS9JZFl6ekdkUFNK?=
 =?utf-8?B?a00xc25RS3BBWnJQY3lmMGNGVXlNS0swM1NhU0V4UEM4RGtzcDlZS0hsS0NL?=
 =?utf-8?B?R2tyTWZBS015TmRpcFIzWVhVSTVkR0tHRHdlVmQzMldkN3R3SHpVbGtPUTRo?=
 =?utf-8?B?ODNaZzFOQ3BLeEVKQzVZcGpjR3NFa0o4N3RPNFJ0bXZzMzU0VnJFTmIyYkJ2?=
 =?utf-8?B?bTJhSS9HM3BkZVR2SUtNSENHZENHcWV6TERlak5CWjBxTE12aHEraFRENTh2?=
 =?utf-8?B?M3pVNHlaLytQNXJaWEdDSVorZlZRczU1Qnl6K0MxRCtBekJjS24zalhXbnVo?=
 =?utf-8?B?S29vNEJjc1BvS2o3dTdJNWNWNFNCWG5OUlp5R01BK0puV1pQbTNuMUtCR2x5?=
 =?utf-8?B?TFVZdnppR0YxMHpsQm1COTErUmtOSnI0bFZBZEp5Z2hlT1ljazljNmcxWVhD?=
 =?utf-8?B?K21WaUpjS2xhaXA5cW04SmNjK2Y0YTNFM1pna3lESUl2UVlZM3JSOXZNdVVw?=
 =?utf-8?B?NTJDSG9JK0NPaTlVZkRCQVFPSmxXd3BRMnJiTnBhaSsycmxEalpZTFA4bW5T?=
 =?utf-8?B?bkNnU0JGa1JDKzgxUmZvajYxNzMzeUtHcWJtWVovRzFqZVRjSE5rdUtOZEFW?=
 =?utf-8?B?dVAvaWFVejdFL1pjNnZJU3JCNkdZMW5pblcwcjltZndiZGlNRDRXVnJNbHpq?=
 =?utf-8?B?S2dod1EvbUhxMG93M1d5YVk3QmdmbFBUc1NHeEJ6R3V0ZFFicHFuL1NsREp5?=
 =?utf-8?B?bUhORHcrNDMyS2ZNb2ZiYlVCc2E2NSttRGdrOXpDNUt0TS9JcitZdHNMc3VT?=
 =?utf-8?B?Mk5zSms2L2YyN2VrcmFWVUJFOTM5b1NOMlFHZkFxMkFiVW4zU0tvbFMzNGZ3?=
 =?utf-8?B?bFVad0hQc1ZXWEpRaks4VERsM1c2RDRML1BjYyt2bmErSWx5eG83QlpNRGdU?=
 =?utf-8?B?UENUQVhCbzBieW1QejhicUE2eWFianQydnpaY1lLMURsNk5VbHQyZDJMVFdk?=
 =?utf-8?B?R09YbDJRbFR0SFR5aC92SEJVbDYwZVNwU2dPcGNrdzB6UlM4dExNZmR2V1BM?=
 =?utf-8?B?STFmR0RUTVJ5S08xUmZEN3FBMXdyR0krSnBzUVZ4TkhibTFKQzVFM2pRTmxC?=
 =?utf-8?B?V3EzT1JsZ0lRZlMvNGdadWM0eWpJMnNuekFPeSs5citjcVF4MW5zMUgwK2Ew?=
 =?utf-8?B?NkpCVDRyRmdmMHIvWldrR0RuSmpwY015aWJZQTF6WTUxKzYvT3VQSjM5NHF6?=
 =?utf-8?B?ZjZiMFovWFg3dlFMUEFWSS9TQWVQZEVKKzA5WnVOeTBwZjJOMVZabjBvcDQ4?=
 =?utf-8?B?ZVp1NS96ME9ocWFZVjlTa05BWXpscjJVbkZGMHBLOGNjeTE2VWhtdnNoR1R5?=
 =?utf-8?Q?Sjanc2uPBMbux4F/Utij?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bWE2QXU4RS9FOTg3WmMvMGgza2dKaUdPMnhlVGdnbTJFTE9BMnpQdFdJK3Rk?=
 =?utf-8?B?Q1ZBZVlRUWE0aXFSSjJ5Ti9nL0hsN0Z6UEVBWmZoRWdnNGpUZXQyaEIwWnpy?=
 =?utf-8?B?MkpGcU1pTGFqMUhQOHU2YkZOenl5S2tRekRlNFk2c1c5TG1BcFp3YnA0Rmda?=
 =?utf-8?B?amZOTTdPaW5WQys0YTIyVXpRczRVeHlCRkJOR29UUlJRQzRzOWthVXQxYjFY?=
 =?utf-8?B?MXpoYVhGNThPUGdJMm5sYUNNZUpjZU5WbkxKUkg4c2ZXaFBlRzByM1JJcndJ?=
 =?utf-8?B?VllRUFBJaDNRNitGdkY1T0o5ZzBvT0pHM2hoL0pjb0lEaHgvRklzL2kvZmNa?=
 =?utf-8?B?dWgxQ0xKSTB5ZENBeU5mZXhvSkJGRTdMTFVUblFkQ0NnbDVPajBGMmd1ZkJq?=
 =?utf-8?B?SGhXUWRFajVadlEzSlZ6V2NZQy9yWHZPOTlaM3FXejdYckdjbXJjRkpodVRD?=
 =?utf-8?B?cElSNXRXNjI1ZGF0alRUMWlNUFlJVHBYOTJhdWtDcGhHdFd3K3RUZElEM205?=
 =?utf-8?B?ZVFwbW1hNERjTGpneEpMeDEwMnRIeTYzM2dyZEhva2Joc2tXREt2K3daKy9T?=
 =?utf-8?B?RXNsY1VHTEtpSllVZWpMbVVubWMzTjN3WUk0bmU3U1JjMy9sVlZSMUIyWm9j?=
 =?utf-8?B?c1kra3lqK3VMdXhQTC9DUy92aVZSbHI0OTdmTUpWSThiQTQ5ZVB3dzNwbVBR?=
 =?utf-8?B?S0VYNmxMdStLb2g2a0JwdHMwcjh1aS82elFxdDJoQkFyNHNCdDRPMGlBZ0Zi?=
 =?utf-8?B?a0FkNEVvK01ndGxyUVczUTBMSFZINFNxQStCTSt1a2dkNDhseVZiMUJhekgy?=
 =?utf-8?B?d2tpaGJNUVpZL0xvbEM2Q2Y2aVcvejZzNHhZU202WnFFWWNNeDMzQ3FCYUcz?=
 =?utf-8?B?b09yRE45NW0xQXRGakhJOGRhNDBMemd2M2dOTlZjSCtHeTM4WXUvQjdUWTdx?=
 =?utf-8?B?K3BuVFFmUU8vaWx4L3J6bUJUQW83Sm9ycFRFNExZeEJwcTFRWWdib1YzZEM3?=
 =?utf-8?B?T3ZNMmdHVzBxbzZuVGx4ZFhlWFVlcDhZUzRqVzNHM28yLzNkNUprdXZBQTFI?=
 =?utf-8?B?d0RTTHVET1c4bGJjVjNmQm44Y1dEamhPL0hOd2JybTdPT3pES3QvZ2hOeHhN?=
 =?utf-8?B?MkVjcFVxTk5jWGRaQTNlRHhUenNsMk5CeTFjQjJGdkFTbytSM3d6ZEFSR3kr?=
 =?utf-8?B?ekRXcGtLSTA2ZE9OUXJnMTR5dnhmeE5aUEtXNjJsZVhXR1IwcFk0dlNYaS9m?=
 =?utf-8?B?MlZySENDZStpd1pBa2tVSE1HeFYyT2RaUUM0VGs5OG1ianNjb0J3OGFPdFRO?=
 =?utf-8?B?SHEraXExNVIyVVhJV29aanhLbGJkYks4dmNzMXJBWUM3TnVCMTEwdEM1WEdJ?=
 =?utf-8?B?Mmk4YUFpRmxsbXJOcDBtcEQ2VTBiQlRYWURObER4MEdDNkp1VjA2OHlQWU11?=
 =?utf-8?B?aEtHcmtTSXYvREJHbGl4QWkzQXJNaXJXUnlaNlRLZTg0cHhrK0VSSHEzSlho?=
 =?utf-8?B?YXlDQjhOelNqR2dqdTVCd000NUNLOTdDelpGS0NHVXhtSVA4TVNWdFIvblRm?=
 =?utf-8?B?cUI0T0pjVDUzbWJTWm0vSk9FbnJUT3BtQzN3ZTRjTmgrVXBoZGV1cC8vYzlO?=
 =?utf-8?B?bDJ3dmh1YUYvUUJCT3dLZGdlZGhiT3c1VzZ0SEhjRk5xSmpqLzZjR2NSR2NF?=
 =?utf-8?B?bEpxSlNqbjAyWmJPenl2cUNidm8rVmc4Nm5DREVaTlNkbTZ1WFJCMG41Z0Zt?=
 =?utf-8?B?QmpDcGsxYzNjQmtkTW9xS29uVzhIQzdWWFdBemtuSTBEMmZrenVkeCsrVGk3?=
 =?utf-8?B?dFNQcC9RY0pxZGtrbFYvWFphSVhyT1hNTEJzRUhHNk53Z2JRYW9RdGRMc0Qr?=
 =?utf-8?B?MTN5dUVUMHJVNzU0MG9nNno5OHk2bUVOOC85dzNxQjdSTVRXb29XSzMwaXJk?=
 =?utf-8?B?Zm1zaXIwQnZQb2svMTh4QmthY0EzYnVNZVhoTUFvL2pTYnczc2ZmWEk2TVhs?=
 =?utf-8?B?bzJLTGRSMmNhbTFqcXZGMHpuNnMxUEtRUGo2N0wvRDFYRHpiT1JZKzJDS0lJ?=
 =?utf-8?B?aGVTTnlIcU5STi8zWVFLd3BuS3UvOUtUOGRPbTE4UCtkTXRsNUpZREpJM0xu?=
 =?utf-8?B?b1VzVGlFOWxib2s0aU53MHlMOEpHLzZRYjQwN1RCL3FUMktMZnJ2T3NmUWFW?=
 =?utf-8?Q?xJfzyi31mBJdH0rX3iFFCLg=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8800d4-b913-4cf3-eff0-08dd03c71308
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:39:31.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HozkUlQKzNtfyZKPSBWN6+Kk1Ff4YDpa6y6h2AeH+1e2hYSEZbKDOoTnea0UKelkprw0AVZt+K+ipqVrqQpb5GwIcvfzlBSbkvviS9VfvBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9081
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 13 Nov 2024 09:39:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/793

Hi Paul,

Please do not attach the patch to the mail but have the patch be the 
mail (the commit title the subject of the mail and the diff the body of 
the mail), this way we can provide feedback inline and do not need to 
open and download a file.

c.f. 
https://docs.yoctoproject.org/contributor-guide/submit-changes.html#sending-patches-via-email

WKS_FILE ?= "rockchip.wks"

is unnecessary because it's already the default in rk3566.inc that you 
cinlude.


Maybe we also want

MACHINE_EXTRA_RRECOMMENDS += "kernel-modules"

in there so that kernel modules are installed by default in 
non-core-image-minimal images?

Could be nice to add a link to the SOQuartz product page as well :)

I see that there are (currently) three possible motherboards for that 
SoM, CM4-IO, Model A and Blade. I don't know how Trevor wants to handle 
that though?
- Different machine config? If so, the machine conf file should probably 
be named after the full config and not just the SoM.
- Multiple Device Trees included in the image? Then we need 
KERNEL_DEVICETREE with the three DTBs in there.

Considering that we have a different defconfig for each variant in 
U-Boot, I would lean more towards the first option. Do you know if 
there's any way to detect to which motherboard the SoM is connected at 
runtime? Maybe we could have one U-Boot binary for all three variants 
and load the proper DTB at runtime, based on what we can detect.

Cheers,
Quentin

