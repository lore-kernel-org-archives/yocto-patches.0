Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D5CD6E44
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 10:15:44 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7661.1779963343882373823
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 28 May 2026 03:15:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=RkKdSqAF;
 spf=pass (domain: cherry.de, ip: 52.101.65.0, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2d/cqROMAP5LWDpZSEdoxaS9gh38v6cRn/oSRheKNQF6T3Fe07d0tYNoxq9i4c+QDz3e1jZ4//5hwb91RvAiKmiaDrBLEImqTi/qxovFivKJlEcVHynWztPqv9HN69zt5XUJ/14LKqpqRAF/7+ptMJj47i0HbFQFQq1jP3TF/ePP/z4I8aSSHCprpfOWr8bKnB3Ark28OW5hfAAFwRBm+u7wIhGPXHXzIkGx+HPRpy0ZyPAkystrt8OnHsHpzcFQKJBkKGalGX5V99/9gOB2OlONeSZY7J+kkzpPOK3XKWeHaevKHKmFyoh1WDEDIOQ7ZLgsGeZgT5gJtnJSg3vEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7bbqFKFd/u1WWLc0Elg0bmffNgcA1fq4dbRjv0oY/Y=;
 b=CnEslsRB6d1H/BMmAqoEC9BrXlnrxky2ILLd8AhfFrJrFnSCSC1xEmjU0iuAWxiRzopSOIKwlHWbQUY4b/Hsr34nPMiiWc1+I16ApAfu2HFHe4a7hAUWzXsKEPGkzN9SS/oRC/r9MlkSlyWfW4E9KsZkO6KO4+gtvkT5zUzbRuNYBUbQ4bsZFy51dBe0S6amIF0yHmi0kFHx9AQRyj3Uj3SMGiu9S3OumpH4vUJKf8iwGRjq3QfMvBI4yJdDZ2jrz+l2wRSRlm77Qd9IKyxsdZC2NVDwNttCPz1jdfTTxP5QIehz6u+abGVaeWg2aM6nNbhLB1kQwKmpPGn4xZ1UhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7bbqFKFd/u1WWLc0Elg0bmffNgcA1fq4dbRjv0oY/Y=;
 b=RkKdSqAF4SPExNAgflhZoR5BEVOicvTRKeqpIWX3WQ/0iOsHzlX2dsDqRpx/N0lNHE5cKUUWbyedFsXDw3ez/Ou8sX5v17IZR/CG5fh7phlk+QLjux/8JjoZWqdSSWuo9OOhlDglWUKzOlla+8o8gHTSPMtBX/o9wp76BZKhdXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 10:15:39 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 28 May 2026
 10:15:39 +0000
Message-ID: <d288802d-3752-4da6-86b2-fd55dd0a6a5e@cherry.de>
Date: Thu, 28 May 2026 12:15:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wic] add basic b4 config file
To: Trevor Woerner <twoerner@gmail.com>
Cc: Quentin Schulz <foss+yocto@0leil.net>,
 yocto-patches@lists.yoctoproject.org
References: <20260424-b4-v1-1-04ede4cc261f@cherry.de>
 <6976ce0c-ce97-4adf-bb6c-c75c89a7e674@cherry.de>
 <ahZz7v5I08_FI6Eu@localhost.localdomain>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ahZz7v5I08_FI6Eu@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI6PEPF00000234.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f0) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: e0faa315-5405-4bc1-9ca8-08debca2102b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|3023799007|4133799003|4143699003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 
	GYKMA80nLcVpnZ+fNZ/sXdwVlRJOWvbJeCSopWFWY12ooOkJDSNMMuj9CuOhk8Z2hhfIo3nwzMYjSHedYwDbfDdmgzbbBQVXM8fmHAx13XriPYR5SxP45kP4dvG9n3q+vrqFhPiPVUdSFqUzGX+tgvaMhhes07bGidtTk539x2t1gmfIQYbr9Gobou4eCepr1X8UKOTMJ80g1ail02xJR8pRm6FE0zabXiUelSGdVq/sR6PDg3KPDe4rfXA07Oj6h30PrRLtAsMFhajPNmyLRH3XlyNrBaK793ATUCj4PArOF6+F3ufnMdddfJP7c6lF23CFDKItCdGATB2l2exYAq9RmCxziGWatneke5GGQpzVsP3pw3kMRXTSHWypgd2kayb+UaMZ58F3u+iiNE8tzfl+uo3bU2BIB4ElMyp+QXHOx5MpAxF2lW/psOcaKCuwM7U7KvoVngBe8aaD8Lf02dZIzGZ490n9pu/a0LWJvJikWu/R5/Xmu9Gjqvb/Rb54N5pbpARalWTNzUOuf8OoqAT9uiGtcfX3fBloFcgxUL6MSj6MJocCFeS+OOHcBKoXr+dBiDn1KVX10MLugG/WYH9in/xFAL3phyFtP22yitrgH3+r6B6T+b3z+DKvfuPpHjjDFXgPQTi9CQturdACVw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(3023799007)(4133799003)(4143699003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkZjamVacENCR0czemtOWkJiREY0NzlnZFBFVStYRFZiaFFBSkI1TEVpTWt4?=
 =?utf-8?B?MUVaVDdtbTJJbW5TeHhjZERrM0pTenh0RlluRVU1eUZFUjNFVmc3blh4M0U4?=
 =?utf-8?B?Wmo4bHlNcFQ3TlFQZWxralVQaDFod1d3eTNabCsvUmFsQUdxMmVSUUxWdk9E?=
 =?utf-8?B?Nnh4OVpmSmQ1SWlMQzdhQ3kwZzAxdEQ0ZGt3Y3RoRzFOTXNmdkw2WUhKOTV4?=
 =?utf-8?B?VkliaWVrcVc1eHJaWE4wU3RKRmlkTEZtNVdjSS96ZkZialBmekhISlJYK1lD?=
 =?utf-8?B?UmZjQkpYYWtvaFJKS08vWkF5aHFKVnRBenhVYWxxbm5iNDdWZWg4TyszUmJu?=
 =?utf-8?B?VUxXTFdmMjNIMGtiMlowSHdTN3pJQzkxS3Npb3pnS2NucG1XNGtGNDU2U3NE?=
 =?utf-8?B?QTJaZ0YvK3hMYW1ZWXhhbUFNRlpWekNZVjJrTDBJRmFBaFRzMVNzRG5oWDRy?=
 =?utf-8?B?UDlYc3RzT3M1RnRJVXdyWWhMWUV5eGk4cUNIY0FYQk5WZTlheUV1N055VjJO?=
 =?utf-8?B?dW1tNmFRVWZDTzFrMUZuWTFhYW5Ta1U4bTYzL0t5WExFRDEyLzlxZDNPYUNQ?=
 =?utf-8?B?b2kwcTI2dE54ZjJmcDlHM1RIREN4Yk1mY21wdDlRUjRKMzluSVhSVHpZb2JN?=
 =?utf-8?B?RzgyTnB0c1R5Z24wUk9LN0xmdVZ5RXM4eDNjc3llYzlRRC9YeCt3WFh0aEZl?=
 =?utf-8?B?cXA0d254T2VBTERFNjVLYVJkMmttdGR1Mlh3eitsTlZrWFZOZjF6cWhvSGJy?=
 =?utf-8?B?OVJPak5FdGJadytSSXJyakVlckorMkdaaUxnK3FNd0N4VkVRV09jSEUrRUtq?=
 =?utf-8?B?YmZRN2FhT21EdWZjazRlMjdTOVlkZVlqQmVRL2dIOGFZWVFSU0N1UGpsNmMy?=
 =?utf-8?B?TmwzVkgvN2NYT1ZuYUVpaHZpam1yQzlCSUpyYUlUM3didVFHTitKVG1Va3E5?=
 =?utf-8?B?c2t1eE1yejhlS0ZSblJJVkxkRVQ4cDZnUHJNeFF4dThCdTZvWU1IRFhMOTJn?=
 =?utf-8?B?TjlMdVVLS2FJL0FIa2NlN0g2RzJxYytaUk1ZSmpnUEpTVHlHVVVvMTQyUTJZ?=
 =?utf-8?B?T2x6MGxCcDlVOU45b0RlWHJ4SHduQjVJYlZISnVmUmpsTVRUTjA3VmFid051?=
 =?utf-8?B?bmdsUEZPNk5iaHZSdDlXc3g0YW9ENkhhZEFaQkN6VmNUeGFFUWk1MUJGTHVq?=
 =?utf-8?B?cjZPbXRFZEZiR2pvb0tRQlBaNWZpODFZWDRnRDNpTGpldDVpV1hqaFNMWFpJ?=
 =?utf-8?B?MVdYVVpydHVrQldlTTl2ZkpHWUloMW8yTy9jMFRqamRFR3pieVFqekdvb1ZZ?=
 =?utf-8?B?MTRHbnVPZG5jZG1DV1BZTkNoLzVuWmkvV0tPMlk3WitaL1dtQ3NYQklHbzhm?=
 =?utf-8?B?UE1qSFNNMzJDWXVPY3pKcit4VjMrbksyQm4wQlVudjIzTExkaUZiL2pmZy8y?=
 =?utf-8?B?WC9nUXp0aWswRHo4aDEwaXBERWxrVEJSR1RwZXUzZWF2MXNId3JZRkREeGRa?=
 =?utf-8?B?blVXUFFhNmJjdnMvYnM4WnV4U3g1UDR4M2NsS25jNWU3MG1aZGdqQ1hmL1dw?=
 =?utf-8?B?eUM3aGhPOVpSUHg2UjVmc2pUZHpRbXFlMG9FUTVlRTdiV2doR1hYSkJRTlUx?=
 =?utf-8?B?WWNlTG5mZXBIMFNQRVZEaGNjeTFEcVFiY1l3L2xSc0VBenVKU2pSTi9Udkc2?=
 =?utf-8?B?ZklkVHpNUmtOQmcyeUlEZjhDVitoMFI5R3ZoeVVzNFRocWxTVk5aM2MzZ1ha?=
 =?utf-8?B?VEVRc1Awb1NidE5wVlluU0hFVmRrTjFzeHcxRmdUYXowajNTUk81SnFnMThh?=
 =?utf-8?B?SXBITWpaZEhMTTBmemZiMVRwL2dLcGZoNU10Vnd6M2t0QnVpWGtZdkhIcXY1?=
 =?utf-8?B?a0V1M2c0UDl4NXk2WVoxcFllREtRUGYrNzlVdGkzc253ZXR0NEh3dXY1STlQ?=
 =?utf-8?B?N2lRdVp5b29hOGRjK3lIdkkrc3ZBVlFDQjZGWTV4QUo0N2ZteFlUWU9ZcUJN?=
 =?utf-8?B?blYrbllGS3ZHTkRQNnIycmFLb1oyMWJEY2Q0VVJTK1BnRmtGVWhpRC8raVBo?=
 =?utf-8?B?eXlSUm04Mlc0RFZWWnZuamZYWmswR3RpclQ3VStONGtUQnczSjZQb1hpVXhM?=
 =?utf-8?B?blYvZnBCK0lNQlNKRnR4cmREMU54RWkzaXRHcjJ1dmxxcDFCUmRGRVpBZXJX?=
 =?utf-8?B?VDFLRHZTSFN6NFhpTUlyWUU4dTg4RjZQYWUzK0lyR2ZoazVFbThGZFphZnhR?=
 =?utf-8?B?b21Ta01oTTNsdzVPbzJCb3AxaTd5ci9tK2c2SUxwQkI4anVhZUJmb2pxK0J5?=
 =?utf-8?B?Z1kwaWdJeE9QM3U3Q09nWlZrTnJTUFRqUDJ4WWZTSmQvTWtpZHBhQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e0faa315-5405-4bc1-9ca8-08debca2102b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 10:15:38.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahmcefAirlaqbkh5eFQahcsCluB8/G4hO6YLcc+Dy8MBOmSWUFJ7yOcf3wPLVdxZuBH+g40BF52Dqj9BfgZb8ARUsVieoKmHH5G1vgh+Y1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 28 May 2026 10:15:44 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4083

Hi Trevor,

On 5/27/26 6:32 AM, Trevor Woerner wrote:
> On Fri 2026-04-24 @ 12:26:59 PM, Quentin Schulz wrote:
>> OK so this is very confusing. The default branch in cgit is
>> origin/feature/no-create and I got my info from the README.md there, which
>> differs from the README.md from instructions in the README.md in the master
>> branch where it isn't requested to Cc Trevor.
> 
> I asked Michael Halstead to take a look and change it. We think it's
> fixed now.
> 

I think too, thanks!

>>
>> On 4/24/26 12:18 PM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> b4[1] is a very nice tool for mail-based contribution. A config[2] file
>>> exists to set up a few defaults. We can use it to set the To recipients
>>> to always add, in our case the mailing list, and the Cc recipients, in
>>> our case, Trevor's address.
>>>
>>> Additionally, automatically provide a default prefix so that one doesn't
>>> need to not forget to run `b4 prep --set-prefixes wic` for each series.
>>>
>>> [1] https://pypi.org/project/b4/
>>> [2] https://b4.docs.kernel.org/en/latest/config.html
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>    .b4-config | 4 ++++
>>>    1 file changed, 4 insertions(+)
> 

Your gmail address is in the Cc recipients, which doesn't match what's 
been requested in the README.md in the master branch (only the ML in To 
recipients). Should we patch the README.md to align with .b4-config or 
the opposite?

Cheers,
Quentin

