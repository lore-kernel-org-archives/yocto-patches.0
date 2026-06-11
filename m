Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526EBCD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:02:35 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44905.1781182946023351034
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 11 Jun 2026 06:02:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=apoWjdAR;
 spf=pass (domain: cherry.de, ip: 52.101.69.38, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuZbEZoG/z3NOEd1t3jY+lvKC2yoVqEHtKR4avW212RO5/7CkuowarSkTus0ItVCaA9XBrSe20T3d4SEVLm9qlhosaj0mWVLfwXej6M2bPqVHlvu00LttAH84W6E0EiaENXDTl5C6HK3JMkSAicU/OOhE+fkO2zIq7/5ZZ/W4qLETdDKYQdrwUc8fJ4ZVV0ltGErt+/FT8RmeDmDTK7avKAv9XleQe2M6pQMmilJSxBqSdcw+Ldo41fMZsuvd6O374oK/JiqWLCRJevZ7ZXIKLfXa1wqL3weXeeOLPG3OWtFJOzZ7T+kUx1HGxPAgTF0hsCq94ZlghscYaXv+BV6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4uDRgt1apq1jHvRiMPs6HDMzvW25ejKlJQwO9EIodY=;
 b=vnMFwv7ZpOP1b4nwlbN2uZHAyMLtUQK/pfLKv8Rs9dp78qXObL+vUGD3UC1wBRelmysDKhTdd0/57HbNbb0CWjGof8Vqa8JQh6MyjL2u9e4Da2AYKJyudHo8EQU2SoTgajx+K5NmZMXPF2kFx6ACDLXRYh4lVy4CnhIR0rHRooI1MUmIdxgK8UXMvhohHq0Vn5wxdWFTv+38lkkh86ZJaYbSPx98Mmvw0AfvovK6anpKVEed00iiM17yi8O2sLmfPRQ5i851WO+uaFKPIQz+ZhmB0Q99J5Ytt7Fh9xfd+fAhnGcGrN0wq/jQo1Xxup39hzy+DU5DtQbyNFCK6ME6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4uDRgt1apq1jHvRiMPs6HDMzvW25ejKlJQwO9EIodY=;
 b=apoWjdAR5ZfToXWFCDgKBHyr7XvwzuGc5HNFopzxzwZr3zEn2BnqveCjDNQbhebdLIb9nYyfcBK9SbtnaY/r3X8HOyVyB6hYyqBDKQJDE63ZekPHMo2CcI4/lpMEscfxhgdApFf48VXfngh8Kx7ttzqvWOWJa130F1POTieEwrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by AM9PR04MB8257.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 13:02:21 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Thu, 11 Jun 2026
 13:02:20 +0000
Message-ID: <9786b1b7-c193-4473-97e0-492eece14a5a@cherry.de>
Date: Thu, 11 Jun 2026 15:02:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [wic][PATCH] README.md: literal cleanups
To: yocto-patches@lists.yoctoproject.org
Cc: twoerner@gmail.com
References: <20260611124208.3292869-1-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260611124208.3292869-1-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::11) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|AM9PR04MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: c6645c2e-996d-42df-3444-08dec7b9abd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	nLRRDbW8ZRZUfa/RQZhl7XC5R0MvBTc1hyMfADSlxEd8yH5pBEvjPkXt7hlpujhmbyBZzqJcNukNxTkp+GEqXLHIiJGdst8HhAObNeYRENZek14fl3xS9S02GYhqnTIA872WcXwzn0VMjYLBaI2aveaj6ATv1cn9pn5Q2qBd4aVUsLgtQ+azXiug4wmJiUlq6d6Dm+TnbRAfSsmbFb0vxmXyyW8Qa4W+u9MMiITyPDG2JWYIU3NmVzeW05DOBgcFsYJtDu/rffVW7Rqa0HLEbtu/R4FAhxxa0GrLjlqSiJizYs4/CnqTPL+daZ1YqJajQkV+GGULtxuB2mM8QmyI4ZMTm7pIPliQsglC9hrUCwQzGRZo6xX0vjMxM0vp8lr774XC+rdKPqJB27KE+Vdv6xXQVq9Cw8Wa6nFV8XJSgvE8b3sEOfs0zmQGeU06wUooPzzwoeqzaIxo7CgBi/E5LNHsYQavEl/9GOFXZb/HGuZ6A/1C3yjlCCuGZzI7FCKk7gf7+jxDGE4UTdQ2XWmTVykwL6gEHf82vW9slDnu7EyUgo+OFQmFs8fJJjGNRbzroQcDoS0xFZKM4FmFVhWEXBycaTxb/TBEs3BdrCZ/b1S6xvjV2O3m8FgQSX9j4KYLgMfMrhr921uz9D/k0GNmkg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U0ZKSWxlRkZ4YkFjV1Rpd21ubEUvRWJtTlFzejBuZ1hrM1ZDdFI3Y3pVUG1S?=
 =?utf-8?B?L0xSQzNaNTlxRnFSbkU4cGFOaFcwcUpQUHRyQzl6Q1Z2TGxiVEVWZEFxbGFI?=
 =?utf-8?B?MmVna0JHcldzUzBsVTR0TXplbkZkUDVXN1JsN3lNRWZJeWhrM0JINVVoaUE4?=
 =?utf-8?B?OWJjWHFveW8xOUhyeXNaemdFaWk5OUIrRUNVcTlqVDhCOFJPb0gvWlp4ZlZ5?=
 =?utf-8?B?eit0V2FMTlZZOFg4S2drRSt4Q0Fuc0U5ZE9vaEJaVUdWRklZeXdYTTM4UUd4?=
 =?utf-8?B?Vk5iNDdQZVpWSG5EeUZ5WmpMb0s5TGdXZ09waEFDMGRTbS9BNVBSL0F5b3o3?=
 =?utf-8?B?YnB1KzhjbVBtTmxnUE5BQmx1OXBzKzcwZW9aNjhFRVpFbE1yOXF6ZE5qOURm?=
 =?utf-8?B?cnpnYmhNQWU0Q3owbEtUU2xEaUF1VmRyTFh6WS9xMWxtNkFhOUFGNmcrTTYz?=
 =?utf-8?B?NU1VM3ZrSHRZZHFLT3ZPdFZJUTRMYzhCelVWek9WaHBmQms0OXJCVVY5Wm5s?=
 =?utf-8?B?WUdlbDlGVUdJS09uYVQvaW5MK08vS1B1cm5nNmhqdFVmeGt0L1A5UGluWkw1?=
 =?utf-8?B?cVZkOGYxOGxoMVB6RkJNbDB4OENUY2E4RExuM3Y4TERRZ1h5cnRNcEJDeTVV?=
 =?utf-8?B?YUdyQjFmUUtkUldYRXF1Z0M5TXNpcDloNld1TFhmQUhtdDNBc1lTN1JsdU0v?=
 =?utf-8?B?ZVhxcG1PdThsMkFub3dpWXEyanZkbWQ4K0NPd0RmTWlVZmpDa0Rtb1Z5K2tn?=
 =?utf-8?B?NWJJcWFKMmpONnlBSTRXWjBIMDVDQzFuTHhSbEp6elBGZEJoQlphOVBYdHJO?=
 =?utf-8?B?L1BKellwaW5MenhUMVRYMGVYaG9TYm93S3I5UzlzQVEzdUJNU0l1SFp0ZjNB?=
 =?utf-8?B?V1I3ajlwN2ZwMk54RE1rTi9DYjZWSXdOaTJsbEkyNWQwcWNVUEYzTHB2bjRn?=
 =?utf-8?B?MlEzR1lQbHhNY2lVM1gvRW9raXBQRHVqQzhhM3Z6TjYzZnJyUVFhNXM4Mlhl?=
 =?utf-8?B?N0NmalM4ci9SenBGNE1pREVzaWpyUDBlQkFaZG1rSjJRK0NpNDgxVG1BV2kv?=
 =?utf-8?B?RDIxNHNLVHN5dVBSaU1Wbk5MQ3BlL29kcC9QM3lCRmRoUDhWY3RsajBESXFE?=
 =?utf-8?B?L3lYMFBiQTJITmcwZ1lWTlJnSUhVS2xjc0djVldTNWRaNzg2TCtSdnk5bUxz?=
 =?utf-8?B?K2R2aUxYdlp0SEVENTJJQ2F4dnhhQ01EckhwcTZUMFU5Kyt0UXA0SlFRM2R5?=
 =?utf-8?B?NUpWS1BXVzZCdWFrc3JMenE2SFo3Q1IyT3JGRTNYanh1ZEpCQWV5d3pUQlI3?=
 =?utf-8?B?TEZNTC90S201bUxBQkdrem8zTytYVU5STXV0cmVVUW54OUlkSXFLWFlBdUNo?=
 =?utf-8?B?MExsbWlRaUc0QlA1NGJ5R0RzN3MrbGliS1k2aVg1YVBQbUhtUWFLRDd4WlZw?=
 =?utf-8?B?MHdQQ3RwdDd4SUorQTVsMG5HUmt3WWRNTHV4RmZiTTlzMEZyOVgvL2o5aks3?=
 =?utf-8?B?QmQ0ek9oVk9CL2JneXdFMDhxYU1Ra1cwZFU4UFk1SHlwTFlUUGlwS1N3OE1B?=
 =?utf-8?B?RWdZMDZKdDc1b2NPQXpjNE5DMjRSWDUvNkJhZ3pQdWVOMDZ0MzBmL1hXUkdP?=
 =?utf-8?B?bTZ1MWY2UFQxZThIRkhJSHRXT05Oc292WUxReldsSGpXZ0tBNXJPdHMwWGNG?=
 =?utf-8?B?dzNTMS81ZVg2clo2ZTRXaXBXM2IvMVZWOEN4MFBzYTFob1RvcXNZV3ZJRHBp?=
 =?utf-8?B?elhmTnU1d2VNWUh0Y1dpMUZ6ZytraUxzKzRZcG80b21yb3RMdlhXZHc2dDFU?=
 =?utf-8?B?WUh5b1NlSzYyNElPY0xoS05yU01ONEpiMDkwLys1UTViRlJBM0pGbHJLOXQr?=
 =?utf-8?B?NGhJRnBFSW9qeXdQT2pHaHU5ZzFnOXlvYzQzZEtTbWsxMWFwVnRLUk5pZjlZ?=
 =?utf-8?B?eHpZN2xIT05lbGkwYWxYcjB6T0lvSCtpU3JUaU1DMGFxemxTV0tjbUkzeXNr?=
 =?utf-8?B?TGROaEttTU5CZEU4Yys2dHhzcGxaZ2loTjhjVHZUZ2VXWU1FeW5WSXpkR1k4?=
 =?utf-8?B?VkExVHQ1NVN6L1ZrR1NxNmd6Smpha29DdW9HQ3I4UGJFbjcrNFVvamJkM0hE?=
 =?utf-8?B?OFhySmdrZ3YrSk81M1lDYnY1N0VNQ1NxK2dSZGlQekl1NzJyZ3pEbEdDakFK?=
 =?utf-8?B?MXZHSVdzTGp1WGdpTEJGUk5NVnJpMkF1MFlLTHU3UUxzcmZwci83WmJRbUsv?=
 =?utf-8?B?azFZZEpxTzIvR2ptNUtOZjJQbkF1aGxqS25tR0xuMEIwZnk4ZVptWWJsY0tu?=
 =?utf-8?B?aEREOWxkVWJ2eUlsbUFHT2Y3RTdHREZFcFpQaGs2am91Uzk4K2ZoZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c6645c2e-996d-42df-3444-08dec7b9abd2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 13:02:19.9949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +v3W9XHhusur05GVyMxcESncZ5qifyfccX8riHejx4sah1r57uMQCDEbhNMzE/w9fpAboJBy2H8pF4w09wSloAsATHEcS5KCbD5kMpaEjDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8257
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 11 Jun 2026 13:02:35 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4213

Hi Trevor,

On 6/11/26 2:42 PM, Trevor Woerner via lists.yoctoproject.org wrote:
> Using ```bash works in almost all markdown renderers, but unfortunately
> does not work on git.yoctoproject.org. Instead it inserts "bash" at the

TIL cgit supports markdown. Archwiki says it's done with python-markdown 
(or possibly md4c). It seems the former supports some syntax 
highlighting in fenced code blocks, c.f. 
https://python-markdown.github.io/extensions/fenced_code_blocks/#syntax-highlighting

Maybe it's something Michael could enable (but also, I'm not sure we 
should care too much about it :D).

Note that fenced blocks don't seem to be part of the Markdown "base" but 
implemented as an extension by many Markdown parsers (to varying level 
of support), see 
https://daringfireball.net/projects/markdown/syntax#precode.

> start of any such literal code block that uses it.
> 
> Technically a code block in markdown requires 4 spaces, not 3. Therefore
> the "git send-email ..." command would not be offset correctly in most
> markdown renderers. Either add another space, or delimit with ``` to
> match the other code blocks; I chose the latter.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

