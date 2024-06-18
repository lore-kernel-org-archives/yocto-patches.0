Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F27C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 10:05:02 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.121])
 by mx.groups.io with SMTP id smtpd.web11.82537.1718705094132669031
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Jun 2024 03:04:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Gb7K5dTq;
 spf=pass (domain: cherry.de, ip: 40.107.21.121, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCUk5P9jQuG/a+qZ0CEFyFlLPzg+ZWa/FoO3VvNEH88kOlZ5j+0Kw1j/ejXROQ0l5XUhBlIIanCljkSsy126XNVjCLixNw5e02R0z/KvNfyEP/PWp4oGCTKA1gGhiS+zSg1bvUk9Jy8aki5Xdx6Niw4NnTpN+yHAOAW2JgT7T3VRAmCJeRABg5jST5lqVAvBTbQeV5JLnzzLicrRTNA3Cj3EIQyNLVG6bz9TTwPUn50mIYc5QkmILncbiwnFoNefo5GIMT/2QuZ7D1w596qswzKbB2Hcn6Cl/eew1l8Z6jxQ0gF+mI6JymEuzFIvhZSkuEN/RCxEZ8KGR3peJXsJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR0sbuTYqCS/U1pfFTdgIiR0xV68+IGGUBXQUoGuUkk=;
 b=gsD2MfsBga7tftT0xvCEzh3vs9ZmgsUUTyUe2VpG3kdTacINo3hEVuAle9VgFGJoOIiLdKcgGAYXBFw8TkX3Blt+lZebt/i+nWTfMpOgVi9KIp1QEGpSv8vDUmF8H0vWep7B1YgRGmDVZL0M3fvmKxZfy/+MitTSM4o2a51NKPkfqGVErJhK/7gyLOtTgPA6n0qrcWa+rUjQ0Vy2ceBqnuAuANzztjtl/J969Czg+YYbIq1BZI2yBSmuNWKQnvCw81HE/a5z6gDSZZfhL0NOKRLsEU3sFiw1herK3UBMPnkVTFDtnX3Yf8Zz3NnTIJJjJ5ULC4QYVOaZf8enmW9HmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR0sbuTYqCS/U1pfFTdgIiR0xV68+IGGUBXQUoGuUkk=;
 b=Gb7K5dTqaVquWblbV2F2BhEaEa2kPSp4RBhf9dXZxsG2G2cjL3qDsPCm2/LDjeY+ODFykcdf2bASlDMRe8ip/LA+isdoQSFXnVWqoe6nWZ5xlm5cgBHc6Wol3OdnKRp5NSy5A2y9aQwLF2YgjeIIwIA6RtK5u8rZSzTh/2UO/fA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM7PR04MB7015.eurprd04.prod.outlook.com (2603:10a6:20b:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Tue, 18 Jun
 2024 10:04:49 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 10:04:49 +0000
Message-ID: <fb7d421b-9db5-461c-b89d-05cb9c5016ee@cherry.de>
Date: Tue, 18 Jun 2024 12:04:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [meta-rockchip][PATCH] linux-torvalds-next: use
 AUTOREV
To: yocto-patches@lists.yoctoproject.org
References: <20240617230735.13593-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240617230735.13593-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM7PR04MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d943c7-ea6b-4558-0543-08dc8f7e1727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RGxrMkxoWDZIZ0NkLzJBbHhxWHVJN1VMek56ZjdzdXRlM1RpdEZQTEcvWWdK?=
 =?utf-8?B?NlFLc2psVHp1VS85VnhoZTBJMkhiQTZBTndHZzFVR2FDcko3MGFVLzJ3NGtE?=
 =?utf-8?B?aG8wcnZjTDNUS01CMVprRFJFaDdSMzl6U282N09jMWdIcTFYQ3UrUlBkZnJL?=
 =?utf-8?B?SjMxaUxFZndsZVFxQitsb0MzSkhCSSttZzVhQzVxdkVBN0VFbjlON3VrQTkv?=
 =?utf-8?B?TExqdXJ0ZHNnNXlxMWF2cTNoTnFiRlhzVlRKTll1TlhhZ1JvbkoyU1Z2VThp?=
 =?utf-8?B?d0RrOFVYYUk4bFEyb0REL2ZyalRLcEZlYW1MTDVlbTU4Zi9UbE90RExjdmt1?=
 =?utf-8?B?MnIwZ3RTZkZFa3ZVNEVESlB2MVB5MkNQTDdvYkJidUZxckdWSEcvcU54a2h5?=
 =?utf-8?B?NTUrMmN2QUFnY2dZWElNNiszV3Z2UWd6ZDdQS3lRVnU5and5V3NsdjhHNzB2?=
 =?utf-8?B?TEFCSUw1N29iazlBY0E3Q3RuMWxRejhkZ3FsWjk0ZEtnR3pjc1lYWTJ6THNr?=
 =?utf-8?B?ZjUva1VoTXFvOE00bkhza0Q2Zi9PTDc2VkZFcnpJTjZUUzBOWjlMcjZ6SE8y?=
 =?utf-8?B?NlplZEJnVkpMYlVtVmo5QUJ0NG1ZbTMzWGZnZnlqRmVUME1jb3ExMUJES2xZ?=
 =?utf-8?B?aDZkUzFDOUVFdk1NQVdZSHlqTUFOYlpENzlKaFRwZkU4YnF3Z0dWbmZGdXRD?=
 =?utf-8?B?VjFwYnFnRjErcHo1OGl3ZlE2aW42eENnRlFzNnVpTnp3TytOZklWdkUya01O?=
 =?utf-8?B?Y21zVzJnMmlxWFg0SDhmbzdaZk5uK1NJdDBOdUNYYjVtZ2FrOWRlUy8zQmI4?=
 =?utf-8?B?T29FZ1ZBejM3WFFLeXhzcXJ5NnBaTndlaFE0UStJMUl6dTRoZEJGRUkwUjR5?=
 =?utf-8?B?OUFBenN2MksvRDFHNVZiUHF6R3FoRGZrT20vWWdWckVlbFI5N045d0d4WXdv?=
 =?utf-8?B?Y2VUamxTTDc5RHBOY1JhdElzaG1RR0pWVHpvT01YcVpiU2hiK1NQKzlnV2tI?=
 =?utf-8?B?TFBsTmVncUJONlc3eGVjSFRNdXNZTEp5eFlSV24rNTNnNVFDd21SQVdQWC84?=
 =?utf-8?B?WWprRDBFMnh4c2J1RC9PcTY3VVJoUmVjTlVROHdkMmFvRFpRRzBKT2xYN25O?=
 =?utf-8?B?YXZSR253UGczRC96SnBETHFBRXpoUjFEVnRNMzd0SjBSWnhZRmcycFhZRVZI?=
 =?utf-8?B?MC9aVDNTbHF6WTZLcFE3SnhrclRkOEErdGYzdUVmanI1YXFTZHZlSWUwNTdF?=
 =?utf-8?B?d1llZ1FOM2QxbTVzdi9zdUlkemRFNVBOQ0ZUZHh2MFg5WEdkUCtYK3JlaTZx?=
 =?utf-8?B?eU42cmhUdFBkQk13dFV2RUZuUDVLU0xTY1h5cWNrMUd3bENSUDBoUG9FT2RO?=
 =?utf-8?B?ZGZuNjZyM2J4UXVFNWpEV3grZUhVYS9uNjF5SS82SEtFWUxCd0ZZeG10ZURY?=
 =?utf-8?B?a2dyREZUZUN1YkZ5QXFESDZVVXc3RmlJVkpFYlZ5NTRKS3Fmakhza0o1MVNR?=
 =?utf-8?B?OVZSSUF3RCtiRHlST3lIc1NYZDhja1l0TmwzRlZxLzJvT1lKS21zQ21pclZj?=
 =?utf-8?B?aERGaHdPMWtJZjVqZHNVbEZKK2ZNWXZCTzBwV3BockFORFdvUk9mSUMvNXpT?=
 =?utf-8?B?VnZzNFAzT3U1ZWhwb1RxVDlFdmk5WXZ4Tm5RTm95RnptYzRZV0tmVk9nREZo?=
 =?utf-8?Q?gUczkbfqeEVW+CwjlOPG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWhSWExEMnJjTGxRZjlrV24raUpIZm1FYk8yaU1xcHJRQ0YrMmZHdnNlaURm?=
 =?utf-8?B?Zm1sY1VkWHRPYU1BMUJ1c0VtcTdWU28xMXJQOHpaL1RHeC9GOTZiQ3kyemQ4?=
 =?utf-8?B?NzlzSUhGbE5ad3B5QzVMOHg1YmF1T0NHdVVEYXEydnU5NVBTSEw4TG5nL2wy?=
 =?utf-8?B?UjluaHBmNy8xQitNVFRXZ2NlQTRqcHZYTDBNWG1hSkw1U3RBdGNCSzdJbXdn?=
 =?utf-8?B?QmVIb2cveGNONjlPanA5K0ZVVzdqWE9LQWZTZW84UktzRmxIOHFrVGErS3R2?=
 =?utf-8?B?RE9Xd212U1FXNFpUZGNIM2lYR1pYUE5NY3pTUS9Nb242b2dwd1NLVkpHNlRK?=
 =?utf-8?B?UUhjUHgyODNhUUYva3ZRQTFFMmZ5YVIyMnpNdXpRTmxCeGhpbWMxNzR3SGV0?=
 =?utf-8?B?Yk9xRStkY09pMWlkMVdiT3ZsY1d2ZGl4OVRmQjVXdzhVMUlyNHVoQ29yNy93?=
 =?utf-8?B?QS9NZGtGQ2FsSTJhV0tZK3ZpUDVYeFplV1FaN3pZd3AzZklOQWNQWkxWbzVt?=
 =?utf-8?B?TkVhSENPMWVaMlNtWXpGMW9OdlBVYXFiWDVPUjhPMnNrRzkzQm5MTnp3YnN1?=
 =?utf-8?B?ZGpBQUtmWVdmR3prLzBFaUdBRVc1eXJjVUtCTnk0Qyt0b3VHMW9Fdjk3SDlK?=
 =?utf-8?B?K1hpangwZmNuZTB0TUhobzVEUSt4d1grNXhuWjNOa2tBVUx5WmZsaXVRZ3Yx?=
 =?utf-8?B?b25PYVBHY3NzTmFocW1DOG5oS1BpK0pMdDZ2WUM5ZkhneU5lTHU3TXlKRUdP?=
 =?utf-8?B?Q3NMRmtzOXowZlVhRm9tREo0MlMzSTc4cE0xRTZSdVU5K0FQbWVuZXhONTJR?=
 =?utf-8?B?RnV6amhLWE5IbUpPTnpMazBTUnJSRzJBWTBtTHBkenpnc2NmL1RkeWN3Uktn?=
 =?utf-8?B?cnU5Z2c1WGJEYnc4RFJ6SXVOKzVmWldjKzlFMjc3NzRRL2lCNTNQQlFxZ21k?=
 =?utf-8?B?VmlGTld5M0lCRWFtM3hCWmNBUkxhR3E3R0NPMTFuZkIrakVsK1FMZlJPS01m?=
 =?utf-8?B?eTJLOEFlNEpkVE83bUtlcjg5Tlh1U3BwWFFRRXhWNFRTRHVqQzFqdmlNYmlD?=
 =?utf-8?B?ek5LYzV1OEpXL0VyWklZSWtvUSt4MjFYdmZ2dWVHQ21HVFIvN1h4UXRHZEVz?=
 =?utf-8?B?Ky80UlJlVGEwMVJ0Wk9xdGtSUHJpTTRpRUFJTjhZelZSSWJWV2l2ZDNOV3JW?=
 =?utf-8?B?dEhXcnZBR1F2TnJnVzFtOHdqR2hxWG1BenNyTEc1bnBuYWtXQzFvd1RKOWJ0?=
 =?utf-8?B?OCt3N2pUK2Fibi9OSUtwWHJrYXUzUnVjazZoWFdmQ2YrWUc0VitmWlNIZy9m?=
 =?utf-8?B?SHpFM0V5VGd0M3ZVTUYwQk9lTEwxQ0Q3VHpYUG9SY2k2b2tNbXVpZGFPU0Ry?=
 =?utf-8?B?QTNXdmdtOUpHd252WXhQTVZuSHlwbHdxS0VhMXI2dzMyOHM2c1I0UkpEaDNQ?=
 =?utf-8?B?Zm0yWFl1cjNMS2RLS2FVekk1amc5UDRCNnVZam1KL1dSS21qUEVBM21RdjE5?=
 =?utf-8?B?bHUzSHRmWDNELzJ6Q3o2ZHlCdWRBWUpkOFcrMHpucjQzQVprUE5TekorYXlo?=
 =?utf-8?B?cXNUTllJN3pzS1dVTHRqenZiaWNQMFJCZDhlcjNPQnlsUDVpTnplZlVpQVZ5?=
 =?utf-8?B?ZUNJY285c2o3WHdsRS9hd056dEExQkZ4VVJIeXR0SmxpaUM1bDZDYTNXMlpn?=
 =?utf-8?B?MWt5RjlUSlR0QURnTG5IdDE3QStYWkZxN0w2S05VUkxGRGx3ZTkwaHd6YVUy?=
 =?utf-8?B?R0gxVnpVdnVNTThreEx4ekF5alFCWUdLdEZSUVhZZFhPbUhnUm5SbVJoNkQz?=
 =?utf-8?B?OWM2Y1FMaG85WnNISU1ybTVFektlOFZJUUtsb0owcWJDYXZzcGdTWDFwSi9x?=
 =?utf-8?B?OE9rWnBWaUk0Mk5YTFhVc2dadWoxdkh5TENXYXRlcDF2VkRwYnFqU3hwVW92?=
 =?utf-8?B?elBTZTU3N21WOXdTQzY2TWo0SWhrNnhLZ2JNUVd4cnppY1BDM2FETVJ3MXo4?=
 =?utf-8?B?VEZNclhCWjVHTVA0amc0WkdrUFJjZHhNeXJ3c2doOFo3Qm02QTBENG5SL0Q1?=
 =?utf-8?B?d3Jaa2hFVWtqNFM4NXEySWVBQ1JueFVoTzl2cXFVWWwyRWUyci9GdWJnRjNo?=
 =?utf-8?B?N25XekhuNXdIWUh2clVmNmJqREl2WGtYY1oyY0s4R2dVNGhONmdLRCs4MFE3?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d943c7-ea6b-4558-0543-08dc8f7e1727
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 10:04:49.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcpgPmVIJiHc4JWzUUJv+sN6TSIquTZu53ItSmK7V7ifZpi/0dWUPG2+czWDuZhhzFoTm/R0j0+LWoP8nBC3EzIuORVnOgsKErERhY8+ONw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7015
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Jun 2024 10:05:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/337

Hi Trevor,

On 6/18/24 1:07 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> Already the SRCREV that was used for -next has been rebased out of existence.

Mmmm, no. It's still there, just not in the master branch.

> Also that tag that was originally proposed no longer exists. With a repository

It still exists. 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20240611

> that is rebased so regularly, the only thing we can safely use to hope for
> valid builds that don't need to be tweaked every few days is AUTOREV.
> 

Or... use ;tag=next-20240611 in the git fetcher and force people to use 
the network for radxa-zero-e boards.

I personally would vote for using the tag instead of AUTOREV. Kernel 
maintainers rarely (have they ever done it?) move tags around so that 
should be fine. Whereas using AUTOREV on linux-next is basically hoping 
that nothing breaks from a development branch, maybe too much to ask for 
right now?

Cheers,
Quentin

