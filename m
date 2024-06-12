Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C25C27C75
	for <webhook@archiver.kernel.org>; Wed, 12 Jun 2024 08:36:29 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.137])
 by mx.groups.io with SMTP id smtpd.web11.6486.1718181377599961147
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Jun 2024 01:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=XYpN1SYv;
 spf=pass (domain: cherry.de, ip: 40.107.103.137, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAN7esDACSiIeUlZSxlJYtk0AvQ7WOvFZvN6QrSMNWB7h3Bd7d4QvRei22EpFKNZqcmnOP0puL2kBrb+tgm70wu6NPQuj6qRgexjkp/GkjacdRuj06PAydRB5RvepPE2//fhJUPJJQNRTY8SBtPREiPupXt1LAt8jXr1StlH+HzQ8ncp578SVcb9y++rkceJDyqcCY7Wg96JiXVXQNhoUh5ge2Ld5nsWM5GgX9SpIgx/5WAYyX2VZJN2sPaBCfnvK+RQNHu/K3S6y3BnNkyLKn7e+3U8PPdZxNreAwWSZfS5FVkoI3wLT2ETYaWFPPW25MGH8gg8z4Izxaha4SIxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BRNvolXGXFs3v92rlnUF5m21DjHJrscRoIxjrR+pGk=;
 b=Y/tzqIcIsB7WThldt+4OyKw7MPk6AEP4MIcj9miB9yEhpxRH8eFOAUp0C/DPk55aYmjlzh5P+R+1Ub8VfxnaSAdDJ5veisUMbLUCH2PzUPSPjBUmN4qQnAJj3379XOGFacHUXoYkrPdPA9tWX+QOib9b3/0ryq0qPTMz3vjDTudxWdQw0X85Dda0NN/eZ3z2RBHQwXhNV4D9OuBFFGkVr1EHmdPpIrZOi8Jj8rcMyv17lXf8b1UDRoWwXjf6YbVI67eTF+r5yguqUeeDutQjQ09OwYA9zXed1Fa3dlCXrnm3jw50x7gDe1ElLNGRuioC97ncH0OtOM/df7wmzeE+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BRNvolXGXFs3v92rlnUF5m21DjHJrscRoIxjrR+pGk=;
 b=XYpN1SYv2yN7rR/ndDqvHHiyKTbcIY1qWpWb1nP6ArbtH11TzNML/hpbLoP1hiBh5/5hXBchUgL9ZIzbNmwMiW9Zj1lJSFbPxCAS9iDtLz2k61jcgeP8B8dQqtSsTCPxNC5YyNvX8v8Bd7dWhTXwdzIm+bmFSiNQv164Icc3+x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 08:36:13 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 08:36:13 +0000
Message-ID: <6e0f1d2a-911c-4ee6-bd4d-5dcb0824faa7@cherry.de>
Date: Wed, 12 Jun 2024 10:36:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2] user-selectable wic
 compression
To: yocto-patches@lists.yoctoproject.org
References: <20240611181742.1408-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240611181742.1408-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::28) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f81769-64eb-4440-f5db-08dc8abab7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TVZqQ1lUTTR5VFBidW9jSGhudEJRT3oxVVJTdTRQV1ZyREFtQlMxQStWZzVz?=
 =?utf-8?B?TnMwOVZtS29OYVlDQUNvWWEzbk1zYm9MeE5NUkJEZXhjWVlnZUg2VVZ2Uzlz?=
 =?utf-8?B?TUM2bHJCbUF5a0k5ZW5yZ1BnL0lJYXZQbFBVd3hnYWFRZGY1MFBlNTVpdFVZ?=
 =?utf-8?B?MWRHUytLU25hYVpMdzVHcWdlTVF5RG01aFFFT0crL0cyUW9pcDJpNHJaenhq?=
 =?utf-8?B?TDFjTmY2cUZKQW9pdjIyaVIrWFZBWkFyeU5jQ0s4ZVZ3UW9vTjhodjFVUVFC?=
 =?utf-8?B?UDBuQmM4cjJkTE9LbS8wcmVjcHZFd1NsSHd5MGtVNVpIaHU1cW4rUVhHYkhD?=
 =?utf-8?B?bjJaNHlQT3FkeE9ZNUZxRVF5b3cwTmptYlJwdzlFNE9ZUktKZFZOVlJQK0VQ?=
 =?utf-8?B?cmxESWVpU1JHSDhwMkpKSlB1TTNyRDdWL1locjFycDJDeGFTOFUva2NoM2FR?=
 =?utf-8?B?dU5xa3VNZXlURGEvenNUanVnOTUzY3l0YmdIZ0F1UXh6Z2pxZHJzeFBGcno2?=
 =?utf-8?B?VEdZVzJXQ0RldWhjVUdSTExVS2V3WWV6YlptV3Y3ZzRGdGpvUm5lRG9aSjJa?=
 =?utf-8?B?VmhLcm5PRWhNcC9JU1NIYzJPZVhiZ3I4czhFMnBPMEl3Sm1LNC9rdElza0J6?=
 =?utf-8?B?U3czTTFCNUNIYVBBbDdCWlRoelRMNlhVeHpqUnVGVER1eTd5dGVLMVZ4QTFP?=
 =?utf-8?B?STBieHJkREpLbEI0VWcxR3pZM0MzTytjNER4T25lYXJPSEpacEJUaTNrZ1ZK?=
 =?utf-8?B?ak9JVm85M3F5VlliakxGQnlLVnh4NU1lN3RzUHF6ZlBiVjBWWkk1czE5K1RJ?=
 =?utf-8?B?V2ZWeFE0NnNNSFFZbXREUmJoMzFiODdJNUg3UlBnRndlM1N6NkFDOUU5b1dM?=
 =?utf-8?B?MEg0WCtkQVdzcEpIN1k0NkdHbHR0d1h2aWlUTXFCTTF3V0RIUWhDd0FZUVd0?=
 =?utf-8?B?dzRxZmIyRHJ4N0VFZ3hiM0V6cEFKMW9OVmR0cmQyTUZDQWhTUVRHanBSK2Yw?=
 =?utf-8?B?M2NCZnFEMHhLTHh4L1hGK2FJZU1tWU5nQ1hDRU9YT1NhTEpjYWtDZEdXWkw0?=
 =?utf-8?B?VVBiVnRUQkUxL2g3NGNmbi9XeGpQTWVjYUZMeUMxdXljK1hvWFc4TDNPc1R1?=
 =?utf-8?B?Y3cvcjdXMHFhWll3M1VSRjBEcncvemxhSHBnMWphcndjVDlQdjdkK0xudUxF?=
 =?utf-8?B?TTBLL0VHNWcxSUhBTm0xQzBBbjZ4YU5XUzl4ZmEweTRtL21EbGUxSUdmZVVN?=
 =?utf-8?B?U1QyQXVYcWJza3g3L1pwSW1IVzZLcDJUTWlzVFBaRkw3TXExdUlEQ0pVcC9k?=
 =?utf-8?B?QVFubGgzQUozSXU5bWxIUEdPaS96bXpSVTk4dHI0RXJlbGZDK0g2cXJ2Z2Zk?=
 =?utf-8?B?RWpyUmtaREk2T1VuTWlLMm04ZXArSkFGNjJhU010bHptM0YrTUhKbEU4SW4x?=
 =?utf-8?B?YmQ2dzZFRFZoNFpQdUxWOWErRGVCaG1KUysxRHNtNDdxMzVpckJKNmxmUmZT?=
 =?utf-8?B?UWFBVGhUQVhRNTd4TVdVcUx0ZittS016eFBtM3AyTTFJdjV2UkRRc2hxSUxp?=
 =?utf-8?B?Z3FySEVIUE02V3R6K3k4NjJuL0V5R3ZacGxRS3NWaWFxMFFNNUNjTEVzUHVS?=
 =?utf-8?B?UjVVUm52TFMvTmdDNjBXTGhKSk53cHRkT3FvRkNkWlZBQ1I4Nkl3cVB5WXU1?=
 =?utf-8?B?dUxYRTBiMkRGVE5yVWV1amRvNXpGY1dFWUd2UXhzRTJGNUxIZm10QzhhNG90?=
 =?utf-8?Q?BviFhpfEnoKwGkCA8f9nR+xoJQ6dAoAEnI9csMD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUxzNDNtY1l5dEVHdjRXQ1ZCK3N1VzRzbEI4T3J0dWlhenFBWm9jME14Y0I2?=
 =?utf-8?B?NDVVOGNYNXZUbDVnamtUc3QwWnZlVzlkdWFWVHFnMXJaZXBhZ2o2eFRZTlNG?=
 =?utf-8?B?L3dZR0toTVozcWI1cE1vSE8vMWp1REs1dXBLemszeUQvcFdESGFQbXB2ZlJV?=
 =?utf-8?B?R01LRlRmSUFTeXJNK2Z1WGs2K3g1SDNtUnlhWU1NcXg5bkJFcmliMGlld0Mx?=
 =?utf-8?B?aDJYS01TYVhyMWhjMXUvMm9jVTcvZlZrUGIvTncvN0toVjY4OGFBeVhMQ21D?=
 =?utf-8?B?M0wwSEpYWFVsdmVCNWlyY2k3cGZicmpPVzV1Q1dVMTd2UnlodlNQL2lKbkl5?=
 =?utf-8?B?ZnoxV3BiQzl4Q04vSlgvWW54Q0lTbVJNNFhRK21ZMlQwYUtHK3k3V1ZDTkJs?=
 =?utf-8?B?bkwxVkZOMGM2WnlsNXZua2drcitwOTgvRmEwbEpWRXFpc0FZeEEzT2hkWUhr?=
 =?utf-8?B?WVVFeE1VUWZqUWxIZHFUeGJHZGF3VEcxcllhTSt5S2F1b1FHVC9BcVhNVXFJ?=
 =?utf-8?B?RUNOTnJoNldnN042eHJkb1J3Y0tQU1ZTMEc2RGJDS01ITXZtK0dvVkFuZ1l3?=
 =?utf-8?B?bkJFWEtGaExITzczVXRFdjdTV3RReVdIbkU4NUszckpTeEhVR3RMM0wxNDlD?=
 =?utf-8?B?VmVjbCtLa3p2aGJ5YjhOaXRMMGU0Y1VoWjlOR2F2L2hIUWV2RXZjVU5PT0Ry?=
 =?utf-8?B?MVBKSUx1MmpaNVREbDJPbFdETFdma3FWR2FSczdveWEwNHgxVU85dXFCSUh2?=
 =?utf-8?B?THZVSTN4RVhPRGVOL0NXZWNtYzFaMlBuREw0eXMvcDA0d2FzTGlRV2h6MGxY?=
 =?utf-8?B?dkJWdlVJYk9GUE5YUG40TW1yRm1tRDNLR0FTeW5kTUM1TE9ZaVlMSjAyb25z?=
 =?utf-8?B?eGdSKzNydmJGclk4eWFWaTBFQkNZaDFzL1lWL1J6eWpqWlV5OThpUjFUajk3?=
 =?utf-8?B?aldSTytOY1ZmQmJTbWFIVkxBWUdka2pGLy9qa3JOaXFnRWx4MlZxU3FXMWxl?=
 =?utf-8?B?QnI0THRWKzQ4TFdsVktGWSthT2NwQndnemtCYnRFL1FTZ3Y4SndYQXVPMmU5?=
 =?utf-8?B?SGR3Tm95SmJTUGFWUVZGM1ZLUG9CRUxzZGpyZ1ZybnNnbkxXc3NXd2RwZ0xj?=
 =?utf-8?B?OHBZWHZsdHNDamVHUnhUeWtGZ2lZQ2R0SmZZSUtLK3U4VXJCYWF3SzVoOEtx?=
 =?utf-8?B?TFU2TkcwWHYyMXRPZXNBeEZrdVVCV3FOcmVWU3ovN1M3dHZha1NvZWsveHJh?=
 =?utf-8?B?eHJRWkh5dmYzU3l6MnZoSFVzRDB5MXdtWlkrWG55bDVuRDgvMHAvWDc0MmJN?=
 =?utf-8?B?djkzdGJwcjBYQTlXamhyUEFNazkvSTRXdTNjNlBBcEhmbWpDbTZBN0IxbUxp?=
 =?utf-8?B?YVArdUswOUgya1U3eWxqMjVqSlVDcm03aE0zejJqZlJuVVI2TFhoUGVwUjJ3?=
 =?utf-8?B?WS9FZzVacDA2US83ejF4R2l4THZKQXZhK1dEQ0Rpb1oyTWQyemR0a01RaFMx?=
 =?utf-8?B?VmhZR0wzR3hOaHY5eVRGekRMNGxOL1YrYlJuNmRwaTVId1BPTGg1aEQxU1Vl?=
 =?utf-8?B?anBLYXFldnVaWHczOFlkYis5anNtNVp0R1lyWXNlbm5GY3p5OXFSNzZ5ZXFu?=
 =?utf-8?B?NVJXMU1FRE5IQ0xPY3FvRS9MTXNveDI2ZVpSMUxleDVUL3J5aEQvdG0zVm5O?=
 =?utf-8?B?dHBpV3ZrMGpGbE8wbzNJUUszQUtsZ1J1T3UxT3pONHBRVnpDcm1RaWhaWDdW?=
 =?utf-8?B?TFplcVRLSGFjZksxTk5aUjZZdkwzSnpSMUp2blhxekhLdkY0eTBqVkoyTVRL?=
 =?utf-8?B?WGh2ZThsZ3lGNHFMRW9VTDJObllGcU0yVldCb1BJVnFCYmdNRDgwU0dDaHJG?=
 =?utf-8?B?VnBPeW5yM04raDR2THUyQ1hqRFVDaHF5TkhxZHBLaGdQK3RQWmppalF6MlZa?=
 =?utf-8?B?RzlIdDlwdDV2amJqR3U4SUtETWFiVFlucVpsamVsQkFFWGR6NTBaSlNmYUN4?=
 =?utf-8?B?UkxPL1Vxako0ZVRINlRIMzFVOElsRy9hUVNXN1EyajdidE9EQm9mQ3drSGJu?=
 =?utf-8?B?dzlURU9LTzZoamx0d2JBRFhiTHk0QjVpbG1jMHRhYllJYi9OZWx4WkIwUjZh?=
 =?utf-8?B?cG1SSENVaGEyc1gzamlDaXpvMktjdGJ4YkMzbWY2ajYxVTJHbEtQdit0V2Zv?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f81769-64eb-4440-f5db-08dc8abab7d6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:36:13.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IJv9tLhbxxYjObau7Tf5mRbxmamlN9LYpDXdUs/0J0o6BnbNnjuwCpP3MUN3PXRIiS5N9tjr7R+WJc5eqFCMZpF62CbxzTGBMDoFDQcISo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Jun 2024 08:36:29 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/313

Hi Trevor,

On 6/11/24 8:17 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> For boards which build and boot wic images, the user can optionally specify
> a compression using the WIC_COMPRESSION_EXTENSION variable. By default "wic"
> images are built, but if the user would prefer, say "wic.xz" images, simply
> specify:
> 
> 	WIC_COMPRESSION_EXTENSION = ".xz"
> 
> in the configuration (e.g. conf/local.conf).
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

