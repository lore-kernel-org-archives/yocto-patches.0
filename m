Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD47C369D3
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 11:40:05 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.17])
 by mx.groups.io with SMTP id smtpd.web10.37514.1745321996821774251
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 22 Apr 2025 04:39:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=YaEp07Wb;
 spf=pass (domain: cherry.de, ip: 52.101.67.17, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwhjDMVvTKF7oDIlO+7hgXRGLCOEcUCfuf8qnrdo5GIDDHrHlwnVBzceo+dEz4/D+kLWQ1hS7r+9DRiar4k+MhMG9knAprDnqU735WmNV7bD6xJ36oF6gY0gexIvBUmOn+ZwerLWH5Cs6VUv9WfYz3MPEOpLIU737EICrGcw+cErSjtG8b5SHU0GONxMI5ZHmMFC/9/AmqkirlKQR6G+ujFh45Wiq//enY8N3v+ADKJ/L2tzS6whqxA/mVd9Y67IjpC/ZxFENQzd1eDjbrBDKaCS0FRJ0wZuWeLRhKrP2FF5ipz/JdjJZytXj/lI+eXjQ+O5YdbI3dem6FYzMK6+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnP/mtaZxkoXUP+0Woz0XiIlWV/QCeYdORIvBgFKIXg=;
 b=vJ7HcosntEd4WMvlH3/FfhtsnrYz9Q5gaM1GnoLDA0VcAsekPeBmu2FFgGeOU15CNQkDcs7X202NFBkXyAV6aJrJnRiF54SUJ6rWf48hawc4WNEkOWRIELK9EYd8I91uSipejjW4dEuJ4ME4nDWyJ2OJFL6Ydh0tUnWuZVy544ejadh2bhi6g9JJlqSSSgJUrJuFEa8VGYjFzUJ1BpgLBaleWADzUokDYM9igDwUBvjTMLEkZHdKNQNDtKp0s0GxHtHSB42XvBn9sTa0g24jrdaB4J0ya04mbRIhd6RyivP2tm//+xUM6dSRyBviFr1K2Ytwgq7n3IEBA8CO1qCl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnP/mtaZxkoXUP+0Woz0XiIlWV/QCeYdORIvBgFKIXg=;
 b=YaEp07Wb6Xmwfl3b2/ELOjY6I+hbY13YProg1YsaiIMrfL153ON55zluGocLSpgGrKsC336RRZuLnpresjs3dAKcyr/dhWPm2fxgkis844p/vyxxMC62zYyjDj2WwaWjRvoqdFqC3Qk53EnSZAEb/uRriCvueY/xsjZjwYf9Hc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Tue, 22 Apr
 2025 11:39:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 11:39:53 +0000
Message-ID: <3510175f-8834-453b-aed7-31edc695da5e@cherry.de>
Date: Tue, 22 Apr 2025 13:39:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip PATCH v2 3/3] mesa: remove kmsro from
 PACKAGECONFIG
To: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20250415-mesa-panthor-v2-0-a7850d0091fe@cherry.de>
 <20250415-mesa-panthor-v2-3-a7850d0091fe@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250415-mesa-panthor-v2-3-a7850d0091fe@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 861de19d-9686-45f3-c0db-08dd81926600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?T3ZZQ2QyTytMbVc0N29BRjJlNzRUTFFUMzFYQzFxZUdmNUFIaXptM05NMGJu?=
 =?utf-8?B?QXNrM25heW43QkFOdnhoOGlyY1RQUjh3NTg0UWlFVXNxVDNBUUdtMW00MGVw?=
 =?utf-8?B?Qk9UY21SMXdSeE05SlVHaWZMUnYyMSt1ZHYxUXBIeEdkeTRKWm5QQVFDT2VK?=
 =?utf-8?B?OWdGM0VjK0kxNHdXMVJ6UWdOYWFLbSs5YjhONGJmQVVzRWZRSkJOcFljVnZU?=
 =?utf-8?B?T3VjS2ZDWTJ4K3V2ZlVIY1NOeDJQRThCSVQzMUg3bER6blliVVk4ckFEbkxU?=
 =?utf-8?B?ZjdYdXdEQjAyVzNaNmhRS1MvZkg3cmswOEJjZE5zVFFDOGV6Qm9xbEFHd0Zs?=
 =?utf-8?B?Y2NrUVNIaWtYcXRmSUJtMVZ1MzcxMDFTQXpZWENCdjYwTldZL3hpdGRHcGZ1?=
 =?utf-8?B?MWNObElaQ0Ntc0p3amVzK0JtQmpsZklqRnhRME1YTnE3cmlTanpLMEt1aWRK?=
 =?utf-8?B?Njd5WDZPZ05CdzhrWCthMDVaODVYeWJDcklhb3h0MExBdm56MHc2WW1sOVNn?=
 =?utf-8?B?YVR4eHExOUFuRS9LcVorRFZoOE56RG5ROGlLbE9lU1NNR2ZsNXVVbkdsMWlB?=
 =?utf-8?B?UEloemF3NEFiRDRUZUdScXl3d1RoajAwaU9sdmFaMDFNOGwwcS8xZVk4Y01Y?=
 =?utf-8?B?TWg2MEFSUy84b29NL1daMFlxaFRVVDJxZmFhZkdiczBJby9ua3pTbXBoZGRs?=
 =?utf-8?B?eVAxekkvKzZNdzl5bVhSbzBSL0k1d3pyNnNpa0lPRW5vdlhzMDcvcmhjeXF0?=
 =?utf-8?B?bHFKbTdiMHlXRko3SFA1akJhZlFCTjdIbzgrTGJucDN4MjI1aXM4Ym5VczRp?=
 =?utf-8?B?NzNMeTlEcEk1elAyRGo1OStpc3pVRDBQY3JkZms3Yyt4ZXZkTDRkNGY5ekRZ?=
 =?utf-8?B?ZE5LcEJzT1EyeHhHQXBzeDNpQUc2cXRKdWozVlJqd2lOYzh6UHUvWXYzZlRN?=
 =?utf-8?B?WW5qbXhUNnJBT3ZxekYvNEJNQWpndk9SeFh2MlBvaHhldVBtaDFQNjNtZGNn?=
 =?utf-8?B?RlpYWE5GZEsxbXREeWthc2NaR0V1Z3EvSlpJZlBsZlRlbWg2TWRhN3NJZ0Qr?=
 =?utf-8?B?cjkxRXF4bk9oYmV1NnNnb1IvQTBZL0QrazhyeTVaL3A5bmgwWDdCSVpVQ0NM?=
 =?utf-8?B?NVFEeTdOUHJHRml3WmZzMmcyYjFmZzFzdFdXYmIrQ3l0Q0ptZ0NXQW1PQUti?=
 =?utf-8?B?UXMzdm5YOXFSTXNpeGQwR2RmZHFmTWJhZEMzb2FVaUN5V0ZzVGY3QVpQLytX?=
 =?utf-8?B?SnRQdmN3eEU1a2FKdGxxVzJ5eGxwb3dxR1R4NXExTTh2OUt0cTcrdWlYNkhK?=
 =?utf-8?B?dnVXWkhObWUyN3VaK0pMR2ZIVWp1b0RzTEN0bHVaRTdSZEZMUURVRFlVYTdD?=
 =?utf-8?B?Nk1lc0V3ZDJGekxsaDRMUUhEclB0Y1ZNd1Ezcms5Z1c1NjRLYzBtUDU0Wlpr?=
 =?utf-8?B?cHAzeExBeDAvaDZkaTUwOTBURGpRN1VnVUh6d0pGdFJrZmdPNjRSYUI4WTNm?=
 =?utf-8?B?L1BFY2FOUW9XSFlrTUZ1WmpQYU1jK2JBWDRuR3hRRGc4MkpXcUxtRXZESWxz?=
 =?utf-8?B?QVhBUk5sbHhHbmYwOEY0R3p0cUVUWnI0RW1EOWFhOU0zb29rUytSbTZhMW9r?=
 =?utf-8?B?RWZmMnptRWtNbWc5TE9IYU4wcENBeWY4ZnZiUWtMTFA3ZnVocGcyNHlCVXZI?=
 =?utf-8?B?MndiMkRtSFlsbzhYLzVMQTRhcFErYWU3cm5uaklSYjZQVFBMVEpqTHNVWEhn?=
 =?utf-8?B?NnpQVVpNQVlkWGlGdXM3UjNBWUtrbVZtQnlqczZQQloxL25WaWpKYzU2V2hh?=
 =?utf-8?B?b0pqeTZLSFFuckNncGxZNzZCMHVBRFNwOXhXdFRMcjZGaSt0WEdpTVhWUzhn?=
 =?utf-8?B?MWRXSkVxandYVVF5NmN3QjhqMU9oYVNhaXJIZnZXRmhtZFBXaHdDTExpZHNU?=
 =?utf-8?Q?VqE+ao+3xRs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dlptVmdMUHFBZHRDbHhFcHhRTXZiS3VaYzErbFl4cUliK2xsekFia3ZQTE1i?=
 =?utf-8?B?NDRSR2d1WWIwYWZET1VrT0NHbVlISDdCRndPeEI4aCtFVGc2aWFnbXRLZUNw?=
 =?utf-8?B?UkI1VTZMa3V3Y2I4QkNnSDIwUDFmWFFlMHJIVjVxTHI0WmJXNFhKeDB0SEU5?=
 =?utf-8?B?bTBYNzdHU0h1SVVvYWlicFZIcXN2UVI5UXNJL3c2T2JLb21VVk9UV1l2bkl0?=
 =?utf-8?B?QWV1R1ZRUkJOVmpnZGxZWVd3alpaMXZBRW1aK3ErbGpEMTFpci9UTXp5Tnhm?=
 =?utf-8?B?Y29KanYwRzBsSWkxT01LRlE4TWVPWDlDcE5YWjFOUzM5YzZqK2J2U1RUendj?=
 =?utf-8?B?U2tkU01yaDNUbjB1dXc4VUtxbWVDZ25qTFhTbjZSMWt3bTJMcUR3ZjNQYkMy?=
 =?utf-8?B?b3luSnIxVFI1SmVxOXhETWFOeUVxdlFVQi8zSWFnMkszRitPcjFaZVdMeHly?=
 =?utf-8?B?NzNjUHJqZEZHQ3o1eUZjKzhHNzRtQXYrL0tSaEtDcDN6dHduOEp5d3R2TEow?=
 =?utf-8?B?Y2J5QVpEU2ttZlM1b0xmdTNPKzZMdFJvNGxPVHF4KzNhRXFpN05SdE11N1F5?=
 =?utf-8?B?QjRtc3ZtcUdKc0YyWnc3K3h6TnYwOVpxbXExcXpTZy82azRITE1XS3FqZDN4?=
 =?utf-8?B?ZzRPVUFRanFPSk1PYkZmM08xK3EwcWc2VDU4a0dnNHNDYjBlc1o0NnRPZUU1?=
 =?utf-8?B?VDRaWnRCMUswTE1kOXZ1NXE1TExRMXVpVVhuTlRndjh1Q3RudkN6UjI1QVhh?=
 =?utf-8?B?Mnhlb2VIS3JJb01RZmgzaTZoVHUrUDZwRWJKWFZKWUJRMjFsVXpITW1ZeFlx?=
 =?utf-8?B?VzFEM0pxRGhFVGRNdjV2SDV1RC9lR1BOQUxPL1Bsc0pjT2JYbXluek93SW9O?=
 =?utf-8?B?N3NtUnVXRjZ4WlBtNjBiZFhWRXQ5RVNLOTlMUUN1UzJFakJjeWYzZGhGOUtG?=
 =?utf-8?B?TG1laFJhQlV2VDY2TndYdi9Sc0F6T25lKzlacXNNc3o5U254dXhaRllnSjZ1?=
 =?utf-8?B?QW5SeUJUNHEyZTVqTUthSXRQU1Q1dkVFRWxrYjFOZ2htaUcxYmRYMVMyaUcr?=
 =?utf-8?B?aDZHK2loWGVwUVBiV2tLTTU2UlVQQ0diQTZ5QnFDbWp5cXI3QWlYMGZRMHRB?=
 =?utf-8?B?R3NYYlBYYXkxMnpVYXoxbXFHeWpDTStEVmhWZFluRGN6WUxHTGwxc0ZpZHRz?=
 =?utf-8?B?TkI3Q1FrTzNia3k3djF3dXptTXM5NFpBUi91aWkxTmkzYXEzdVRXVHV3Z0c5?=
 =?utf-8?B?bnM3WVlNYnJkdktRSHdlNkNiaEVqdFl6MERYUFdtMTl1UXBtK3lqdkVkeEk4?=
 =?utf-8?B?YW1PaEx0SFdTSHFwMGVaNHdBS0V6dGRidHRMRjRpYlk0djZxVWJWU3dwZkJK?=
 =?utf-8?B?M3d3bDczQVVBcFJwcjdQSC9ZV0R3aG4rWVNZaXRtbnJLRng4VTd2SkxZbkVI?=
 =?utf-8?B?T0NHaWFoRkNhY0lYcXdFZWt2L25qc3crT2NCN2F5WHU1eEhWa2RsMW4xVCtT?=
 =?utf-8?B?cDNIdXpSOW5hT1orM0VtZVVGZ1JmQ0VXOThKdTZUNm1IdnVKRzFTTmtzejVQ?=
 =?utf-8?B?b1luMkpuNkpaZ0Q4b3VkZFMrTzJ6Mk9mcDU2MTl6ZVVmSUJybThFemNLTUFn?=
 =?utf-8?B?RGRBUHJEMDdQdTUvZ3RFQjRhdDEwQ2JRckFWTWlZblM2K0lhaWxRSzR1VW05?=
 =?utf-8?B?WmxOSWxyOCsvdGFCYTlMQzhKZHowOEtpZUw1eHRLTVZVd0JuazY5WHhhMnIx?=
 =?utf-8?B?TUxPQmhoelNkUHlyOXZiWUw3Qi9CSlZTa2F0S1d4ZGVEQ2ZhajJOY2lSTm1Y?=
 =?utf-8?B?N3UxUVRnb2cxRTFuSW9wUm41bTMveVE2MHBiNEZsSHZZbkpqWGdQTzdwU1dl?=
 =?utf-8?B?Zzl6Tzdubmg4TWJURG1DajlEbHlJN3hWUWE0TzlqU3JhWFB6Q0lScFd6d0c2?=
 =?utf-8?B?NSsvbUJOWXdaODVYQnZZOGVqMnJtOFltNUZ3RGorQXdVNWRXVGVHMGRVSGxB?=
 =?utf-8?B?bVdsQ05jcHdpdktPWkorNWNLMndvVUJhTUwvSmhZemlWU2tPWEtTSVlIOUlF?=
 =?utf-8?B?YVhiVUR0c0hGanFtZXRsQTl3SkIraTdsbUdNN09jNVhGV3pnTG5ndWlGWmR0?=
 =?utf-8?B?b0E5YndQbHdqR1pPTk5BRjU2RXNSWHlteEJ0VlFCbjZyMWFIUVZiMktVbk5r?=
 =?utf-8?B?M3RKQkJqSG02Qm5RTUV5VFBrcVZEaXNuWjdJemlhdEZtV0oxMUpJMmpGS2xQ?=
 =?utf-8?B?KzJHREgxZmt5Y0NyVXhaM1RQRGtnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 861de19d-9686-45f3-c0db-08dd81926600
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 11:39:53.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DqeD7P1R9Xr6I/PMw0wVcpCDPFWM0rPU11poMrrAHd6p4uzgHFWWz5scIbIW72rk4dXYZX5y9HQGJspRo7Kf0+lKgR3N7h7f5hsq7sx9oDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 22 Apr 2025 11:40:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1399

Hi Trevor,

On 4/15/25 1:24 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Mesa has dropped support for a separate kmsro option to the
> gallium-drivers.
> 
> It is therefore not necessary to pass it to PACKAGECONFIG anymore.
> 
> This is in anticipation to
> https://lore.kernel.org/openembedded-core/0214a9e5-0242-448b-b078-9ba202685943@oss.qualcomm.com/T/#u
> being merged.
> 

The patch was merged and meta-rockchip won't build on master anymore 
without this patch.

If you want to have this patch first and then take more time to look at 
the rk3588 support, not an issue for me, I can rebase :)

Cheers,
Quentin

