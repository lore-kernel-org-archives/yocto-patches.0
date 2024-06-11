Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602BBC25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 14:29:47 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.115])
 by mx.groups.io with SMTP id smtpd.web11.11037.1718116182628872549
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 11 Jun 2024 07:29:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=KIBggBwU;
 spf=pass (domain: cherry.de, ip: 40.107.21.115, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMQYcv+0qy9FlDKs5XPDzm9DAV0UwUnPNyNXHvWxxLMgHmSiO8WkuAEFEYBokkvBtLUHVhft01Gp+2nuBCw5QUmr96BgQexFGiRUWzml7gC3Qv8VgL8Kr6NmtoF5mBdNfdbsIWG+movlo6RzdwmBjggyOOtHrNeZqyku058qZL8g39ht9wizXxwwep0lQ2VIQPDczLr1UfXSsnGCuTsCJ83YIgcSHa+CDITM9pKY7cfWQsvCGpBQe0hNNa+TBqdNnb7pghgfuv+LqdSbnKdu56xklvgAfU8X6+VrD4BK46NiTo2viSk7di7WhBIwjdsBS0oJgy63wj1yoBzCPr+s2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7ljhqnHTHoqktbqvT1XRR9Rtzb94UEDcc7yk0coi2E=;
 b=CgTRs+ss1lqYIF44Gejp5uO0JB1al1aA7XXk3MX4x5wzSUkwEvAcDg87AI3CX+XCtV/KDWWW7BPy9fKQWRTT+LZmu7OUum6NM8Nh7v14/9A7Y7bb0eZLHVehOEQtfTfG+SPp5hL+b0hq/MeS6ps0kzEb5G60Mu1cs9zKL4y0FkCaXgNt+tWDKQgRuns0WRQzG7ADyNo+SOq+BMIt+xiArpTSbYpP2AqqleAh8hwByc+8t5JQHtdiXdBrW244lMm1HES0HXX6RMZvRo7tA+AKvEs7KfgAlZVuz2cc7xuYt/GfSfWp1cXTKzgfE1purIPfvFHBLLtwd/VPWyqVR/xu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7ljhqnHTHoqktbqvT1XRR9Rtzb94UEDcc7yk0coi2E=;
 b=KIBggBwUsMmJZIXBk/c+xthtSS64ILnQHuSOwHMTbLmXC2xuCSThC3v2q5h1jaCwJ0m4vAEvfsfoYBDcJAjC6nOmoWTdzvY9FOlnGHvozGeOy6AVvBnKaJ+pi1pXdY2z+JAkPggrGJOm971YqGriEs4oqZI030Ol669yxYc0Ew0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAXPR04MB8349.eurprd04.prod.outlook.com (2603:10a6:102:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 14:29:36 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:29:36 +0000
Message-ID: <7c50adeb-c82b-4a7d-b663-8f73a63ae5b3@cherry.de>
Date: Tue, 11 Jun 2024 16:29:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-yocto-dev: fix build
To: yocto-patches@lists.yoctoproject.org
References: <20240611140607.2719-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240611140607.2719-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAXPR04MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fb7fb4-425e-496d-b431-08dc8a22eb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UDBpQVoxOTN5QUZBcFJBYzdUUW4zTTVDNmdUMmFqaWdveEN4SVlpTnZmUDUx?=
 =?utf-8?B?OVlWQjFwVHRYR3Z1aHR3cUN6cHdwaUR4aWRDNDdIN1JvTE14MzAzRG82amZW?=
 =?utf-8?B?Y0JsWHVJTS8xRWdYL25kZjJsQldhT0gxNmMyK0QxVndKdUs1OEJsRkwzaWtQ?=
 =?utf-8?B?eFhqQm5NbjRITWkyKzV4RmV1cUJWczN4SkhpUEtCcndmTFJqYmFBa0hHZWVo?=
 =?utf-8?B?cU1XeWIzVGxJVVpXTE9la2JSQ1BMZFUyMlYraEJ5aXJBYkpBZlRadlhhbDY5?=
 =?utf-8?B?dy9YK3ZiMnlzZHVlQUlhWnA1cXV4dmYyOHo3ZnIvSEVZY1k1ZnBBMG5hT3Y5?=
 =?utf-8?B?cnYxZWZMK29xdk1Qb1pJdkcyVWY5MWw3MWRMN0tyY3BkcUdabFAwTWhaSGZi?=
 =?utf-8?B?dnVFTmZCWkZVM0pqWmlzVEprNXlydXNydTZ6bWZWcHp2bVpUeXZlbS9oMkFw?=
 =?utf-8?B?WHlRNmFwRXBzem1PQTdEVnpFWHlmRXVoUUdyei9kMXRveFk4NHdMME5laElo?=
 =?utf-8?B?WDdxaWhETUd5NEY3aTlMWTAwUllqYmVPSTNqUWdVUkV3Sm82cU5sMTZyVDhL?=
 =?utf-8?B?N0d2anhndFhpZlllODVEUWVCUHY3ZEhPaC80QkNjV0FacUpnSENtZVoySHdJ?=
 =?utf-8?B?UWlhRGw1S0llV1BiUTBPZmM1QjF0VC9RMlZHRm9XY0F5VDZ4cXBUZFBZRWRu?=
 =?utf-8?B?QUJqU2t2c0R1VngwTVhqYXArTnBhc1VJQUZXVHY2Tzh3YkV2S3VHM29mekFs?=
 =?utf-8?B?c3BpOURaSnFXOGFWUlhXT0hNdHRWOVlvelFLWm55MnhsL203NkJpQlR2Rkdx?=
 =?utf-8?B?MGI1cTdsMWVOWHU4NlRqWXpqR0tuekQwbWhEaU5Lc1dDSGVqT1V6bC8vUzZI?=
 =?utf-8?B?YW53T0VDcnYxQ2s5Z29BY1ZtVEg1Z1hGeVdxRk1yaERFRUQ2NlQ2NE5IODZh?=
 =?utf-8?B?TXRSdFppd3ROMlNGd2tXREZBcHRZaW9waVk4RG9aMTlaKzM2bEtySjhaT3Zm?=
 =?utf-8?B?OHhkNEZ0amt1Q05QRzlwQ01xUDNPbXpYWWJZQnE1R1Qzb2RUR1cxVGRMTEN5?=
 =?utf-8?B?Zk1mb3ArVXlCZkRHb3pOM1ZqekpOeEdWNHBKbC9aSkVyMll1ZG5qcVo3TGlw?=
 =?utf-8?B?ZzBsMFlxRUJUckFKdXFhMzhrYVpMaEpSQXhGZHRQWHRyWjdla1BJQWtpTjVR?=
 =?utf-8?B?S05YR01udDl3S2Y4YUJvMkVyQ0s0RDQ4b2lSVEFWN3VIbTdDTkVZS2Y5UDU1?=
 =?utf-8?B?dVl0cUZCMjROWkN6UHphVXNxcGpNU1JjTEtyMk1KS0ZKeWFNSWFsbjdPQzFZ?=
 =?utf-8?B?RndzL29vMHVyRVhoU0g0UXRxcUZ4cHZNRGQ4TEFNZGVOSHh5MUxMbzIrMmls?=
 =?utf-8?B?YmFDT05PRWw2RGhZWWx1SDk0S05UWEVIMGJ1RndCYUs4TTdXaGJ0S2FRSlJI?=
 =?utf-8?B?c0JNcGZRRDlNdFNkU2JwMEh6bnJqWUx4MmNXYkxNU2RLUFh1QWZUVm5Rcm5k?=
 =?utf-8?B?Rk9TNHJ1MGxOaXJ0MkVyeWN6dlYxcC9CSzVBVmI1TmNmM1pGcEhiY2pkYk5p?=
 =?utf-8?B?Sk1pK1dua3RaWFdpTjZ3SUNvckJZb3FFV3RIdHB5OWY5MloxM3AyYTVPR25N?=
 =?utf-8?B?RzFvUlFpRGxhY0lSaTZTRWZGOEJqd2ZhK3RqR0QwZE9tTkRUK3Y3bENnUzg4?=
 =?utf-8?B?NVlORVhEOENyb0d6WVFVbnBQUTRpVjVQcXQ1d09zMEYzZ0JvVTJkaDBJQXRy?=
 =?utf-8?Q?5KfBclkQZOEqBoBYJ/caNyBoVVkA3HoJzSoYrzo?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WTRSd2xIQ0NqOGt4TEI5Z3BibkRPZG1qcEJRZUs5emljdlNYVDRuR3dGK1dZ?=
 =?utf-8?B?ckxpNFhGQVFLU0lqbFdXYmlaVFNBZGRnK3hQN3BPdmFlODZYeGR0amJCNlVs?=
 =?utf-8?B?VXZFY0lJUVZRR3V4SVRWd0JNRnhWRFRyampLcGgzZU9PakFXS3JXWkJKT1dH?=
 =?utf-8?B?dUx0NFdHcEhaWVJ1QWdDQ285aXBTOVdTYmI3ZGRRbkN6aWtDaTdMRGd4Q2c1?=
 =?utf-8?B?TnZCTHZVTkJCcDJSOXUvVVRVYW51NFQ5US9HTHF6R28zU0NLRjFsdzBNL3ZV?=
 =?utf-8?B?emNIRXllTk5Qc0RBdG5BNlhpS0M2S3dNQXpKVVNEdmRLS2RNeEhVckp6Z09R?=
 =?utf-8?B?L3NMRVVOU0ZQY2tNRHVOQW9RU001aVQwZTJCY3hzZ3ZybXVnbzhVS3ZRSmw0?=
 =?utf-8?B?ck9UeFllZ2lyU004Wk85UHdtQ1ZEN3ZObjJqQVJwUUZZeEhzTEFHZ0VZTENi?=
 =?utf-8?B?WUhiWThTL1dQMnQ5LzJPS2JrZ0U3TC9SVGlXOU5ORHZFcHFMKyt4WnZyUE5Q?=
 =?utf-8?B?dlQzMC85WWQwemw3cG5lenI5bVdqRVpqU1Jnbll4Zjc3V05rRXNWVEFOSGhE?=
 =?utf-8?B?TjVmYjVIMThXU095Z3FTN0h4VTJaYW1zVkVaQjhKQ204S1J1Rk1KQnZqZnBW?=
 =?utf-8?B?a0Z0dG1HZzZPRjBieUVsdlI1UldMM2VRMjBEUWEraTdid0dwRGtjMXY5a045?=
 =?utf-8?B?TEMvQ05oMFE5N3V3M01XRGV4SUUyemd6aXFXNXVkejV5UjUreElJRThid0Np?=
 =?utf-8?B?Y1JMVDR2UFgzZFNnOFhhWS9Xb01qa1JHejZEeVVjK0lJc2tMV0lMNTdxYnVa?=
 =?utf-8?B?QTZqeU9pNVc1VDlaS1JPWXdXZ2FBamJxdEkrcnRXUGxxUDBwZ21MdnZ4U2lR?=
 =?utf-8?B?aEo4OWcycHVqNnM3NHhhZVc4U0hmT2I0bGZ3ZlZLRmlmKzgyV2VHWEpySXB5?=
 =?utf-8?B?R3pxdkxnemRKdVZjVHBNUGRISHlCUmVsNmNLMkdOZlhqY1Flbzl2ZW5LeFVB?=
 =?utf-8?B?UGdxYTJ2Uk5iWHBqU2NGdTBqdVhiTE1UTVorUVBTUFdGU1pwZHliZ2Jsd1lB?=
 =?utf-8?B?TUhINUlLcE1PVTQ1OUF1TFdxUXhXWmJleWxRWDZzOXFPVzRaQUhMZmpKcy9a?=
 =?utf-8?B?M1ZWWGJObGxQZ1FzVUJxbzY2Nm56WFM4ZE5VZEVVYm4welZ2bDVKZlVpekRh?=
 =?utf-8?B?a2JwR04xVUFSSFEzUGQrVXJOYUh2SkdVb2s5Zk9jT0JpOHM3UEh5SStRQXIz?=
 =?utf-8?B?Q0JPc0FsSnlJaE0vTGxEWHZmWkR6NXY0OW1wQnR5dEdGd0cwQmRiS0VyYlFF?=
 =?utf-8?B?SklTWjRGRXlrN0RYUHh4cWZRK2tIa0s0SkVTWkMwWE9SVE9RekVEQ04zNWM2?=
 =?utf-8?B?YmVNLzlOVjFHOUc0Kys5V2Y2cSs3RkR5VFdzalJ3R0x5dFhSbHVMY2x6cnVy?=
 =?utf-8?B?b2hieDJHenVYcXRqV1lOTFhyTG5KanRUNmN4K0JOZno3Y1FDVWlDdGVacyt2?=
 =?utf-8?B?cmd5UkNMRnNtRm1XUk9WQk1HMXJwM1dFRFRNSzhBczNIaS82MWFyZUpZb28v?=
 =?utf-8?B?dldlL3NBQlo2V0ZVUXVZMkFpU1F1RnRmUll4RXZVU2RTRnJRL0N3WXFSeHZv?=
 =?utf-8?B?Wld1WktkVGJJSTBIclVRbzFnbW1MQnI5QWQ4amF4eWV3V0VweWZCdkxIclJQ?=
 =?utf-8?B?R3IyYjBJUUdWejhEY3lEWUZ6S2NvUlJBdjBOWTBLUE5acVdzRFFJaDlWUlp6?=
 =?utf-8?B?RlUxVXQ2ajJaOHMrZnE2YWx1bG0yL2pwU0VxOUU3cE1kMU5JeEhYUFl4M2xj?=
 =?utf-8?B?NGJqZFhSSjVoR2lYaHhIZW8wT0hjMmRZNHhlbUN6d1JWQlhvZUdpNCtNWEtI?=
 =?utf-8?B?RHJ5TERncmZ5M1dLcDRrQ0FOcmE3R3NpTE5NQmhCMlBFR1ZYRVFuTHJTRjh5?=
 =?utf-8?B?Qm1xY3ZUUlR1RzJSc1V1eVhvZkhHZ3h4QXo5S3lpeXVrYkZlbWQxVGJGaldj?=
 =?utf-8?B?S2JhL1BqMjRlOEt4Z3plSnZpcXJPdWNYMnJuazdaSDBCSVlZL1d6eWhIZHkw?=
 =?utf-8?B?dkR1d0dKa09rOW5LSE1jMVlSN2J0QXhhSS8rTDBkNU1qOGdWUWg5ZFppSGFE?=
 =?utf-8?B?Vldlelo1S2lIckFjMlgycXBxZTloYXZxZlg0N25hQ0t5UjVjVkdVVzd4REZx?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fb7fb4-425e-496d-b431-08dc8a22eb75
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 14:29:36.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBPr6zT1oyQ47/7htwgzJq+fBZqY5rbM+9gj68roYJp9C6qcqeRJGo/oe7aT7fJGWuf7PhtqNZ48cpayp+ngCqxOOI3DQoDySWdYOYHJudE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8349
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 11 Jun 2024 14:29:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/300

Hi Trevor,

On 6/11/24 4:06 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> The linux-yocto-dev build was failing with:
> 	| ERROR: modpost: vmlinux: local symbol 'security_path_rmdir' was exported
> 
> Disabling some filesystem-related security options fixes the build.
> 

Is this the case for every board, including non-Rockchip ones?

Is Bruce aware of those issues? Shouldn't this rather be fixed in 
oe-core instead?

> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   recipes-kernel/linux/linux-yocto-dev.bbappend                | 1 +
>   .../linux/linux-yocto-dev/disable-some-fs-security.cfg       | 5 +++++
>   2 files changed, 6 insertions(+)
>   create mode 100644 recipes-kernel/linux/linux-yocto-dev/disable-some-fs-security.cfg
> 
> diff --git a/recipes-kernel/linux/linux-yocto-dev.bbappend b/recipes-kernel/linux/linux-yocto-dev.bbappend
> index b6a63d7b7b29..94bf737c63bd 100644
> --- a/recipes-kernel/linux/linux-yocto-dev.bbappend
> +++ b/recipes-kernel/linux/linux-yocto-dev.bbappend
> @@ -2,4 +2,5 @@ FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
>   
>   COMPATIBLE_MACHINE:orangepi-5-plus = "orangepi-5-plus"
>   
> +SRC_URI:append = " file://disable-some-fs-security.cfg"

If it is Rockchip-specific, I would suggest using 
SRC_URI:append:rockchip here, to make sure we do not modify other 
machines from other layers whenever meta-rockchip is included?

Cheers,
Quentin

