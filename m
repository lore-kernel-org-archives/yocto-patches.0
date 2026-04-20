Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F21F55809
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 10:29:55 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16221.1776680984920544971
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Apr 2026 03:29:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=DUvSAJMw;
 spf=pass (domain: cherry.de, ip: 52.101.66.41, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD//bx7HDjj6MCjf5dcLESMx6s/QI+P5CUTGYtg1GgQz8RKWlAAIP1z/yNbHVNs78xainDdtehNYWOYZb1MoB/UO/eCan0Y4Ajquv648YEzzLa1AH06KL27H8NysVmXyfgq/eoUGy/JgRvmd9lIxK8Oo9X7+jI9l1XfeWbRdQZ9ny/7E2eXCOc4V/nyCJMKOmk+sf+WhLDEe5B8Y5BQXXDyXrTHLqQzeLn1K9pVPtdI0xhQfu5wkTNByuJoz+b9QhPfKlXd7hZSAQckBcIaYRDo1I+uNzn/Ji9WUH7hEAB1Xz5ncCIzfpXggdqU0DWwk+d/e8te1kr4T2VAWgJzquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTmdzIc/p70XBboBoub0HTGbF4V0ago/+6SxDy6VD0E=;
 b=xXZQXIhMHrrdz/bIc0oB3nEIug0roWTw/QZaGcDxFac/CbfzYcUc5hx9TB/Eqn6opQer6kpAHmUVb50NgXhH7/2hWCfrG+o0TPedR+RsTXaboj69TzvgqBXoqBVlmrA3MAVOuWATA33DJMD4v/TWDS8r5exyLt7z8g0yrwQvM4V7SPk/anDtS00fZbcQQPmrbuZmaHei4P9odgk53WUV3coquk111B26eFZJU0Ctd1VLSSHpgd/EEHYED1tsS90Y9vRCSkG2EJfGzSpJh8XJ8/LeIYd6ZwOQjPjrJpmavYpfNSjTlsrehVAVRtACeqJ1wd/bd5Y9QxCsjlVC1VeNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTmdzIc/p70XBboBoub0HTGbF4V0ago/+6SxDy6VD0E=;
 b=DUvSAJMwDUjNlmLN74g8//dcCBKa8ruCHIm/aQUpp+Ijy+asbiO/r5XKj+efYaP3wKcJZ6uJ1GaySQ6RG8KPLdBt1SJ+s12PWPtZx29hZpbZyb7+dbcYiqy5lUlnQJvc7dX4y3zAqWyUKOv9Ojd/6wDPrB5RhEohLPF6CtIzq8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DBBPR04MB7769.eurprd04.prod.outlook.com (2603:10a6:10:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Mon, 20 Apr
 2026 10:29:40 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 10:29:40 +0000
Message-ID: <f458ad76-2eda-41f2-b6a5-1f6bba342752@cherry.de>
Date: Mon, 20 Apr 2026 12:29:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip] Backport patches to Whinlatter
To: Martin Herren <sputnik@on-the-web.ch>,
 "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Cc: Trevor Woerner <twoerner@gmail.com>
References: <5bj70loXmt_k9cZvIDWvVux-3no88K7lhbMDcRw9jh3ylLLz-YDZhyOr6fM8PeXSnC88wg6wk34A9A3uz8ljvNTE_nEurXpatMj2VxFsw8c=@on-the-web.ch>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5bj70loXmt_k9cZvIDWvVux-3no88K7lhbMDcRw9jh3ylLLz-YDZhyOr6fM8PeXSnC88wg6wk34A9A3uz8ljvNTE_nEurXpatMj2VxFsw8c=@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::36) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DBBPR04MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb4515f-5c65-42ca-d8eb-08de9ec7ba9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	dajASZNhDLYpdQkIepvZEjIHvy5QljZrEMSU7FWFjqKNjO1rTwJyVQzr7skkDQESNsysYsWEI++lHgLxC4O2i44Hz7CW9VGewlHR4ECrJ5qNkQN1JZmHZAPH0slUuaH00MpNwqdMKaumuQFw8daK4I6jBB6Gc1I9LV2g/Q+jekcY19UbqeDGHQag9qbPqewrv6vBx+wN8uX7flG/5O9wMu0mVFgbz2ZtWFMRl2/Z45czWYGnpQS3glM5YDtjZmDHP1kQAiZMFk43d9ULOGqINP6opSSiekOUDGQ2PHekOjKcF+3hcCUUAgJ0tEstlRciT5NtHLkkEGnEpEGex+Ooz0iGXXhDVMBCaxSLo+hpanMeRO4rSKQpG/vsgphCHQLrFwknHusx91Z5JlBhB94Yd9p4n174SVz9DKZ1xiOiyzy9kYwhywpJ7u7D+ZsguflPoUuqbpk4hD0atiBG1dM6dPrUtNnqMFVhoGpjEJuopbgHBDPiTASrYBzMNwowD2oWttF1sFU4JtfO2V8hY41Bio0mTAuIN6mzyuuJxsmaX2UyfBnkNIfMxra0/HlFXj/dnKiUKpXgOl1a5dh7d5wEwV5PXnKgRtEsXCEI2wbDvldEo5X1E1hJ1kalNnrn/CZrHQExsriP6CVGMjgX+YKfGMmIZfEx3tauH/Gsd+gXwZFjF4U/kzQeJyCcBSL88BHlT0xRMsX8i7JL8BUZX4f0GETEIFuYACJBtqJ5Nvxoy4M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjdqN211cGpSYlhjbkdKU2l6bGl3UTNTN1lvYVlidUhCckRUMDlySDV0ZzBa?=
 =?utf-8?B?cE9NOXlsUXYwM2xMcVdZVXV1VUhxSUM2MC9pQTMrZWRrVzRrTmxxOEpmaUNY?=
 =?utf-8?B?ZCtBVlZTZjBkUldRTkk2QXdMTzZzSjkzQUgyOHgvenZKMThDUG5aeXYyLzBS?=
 =?utf-8?B?ZFl4M3RIN005TmFlSXE2MUVTTi9sN09tRUJWSkNCM2FUSnU0aGdtK0NlK0Zl?=
 =?utf-8?B?emsreGtLclJaeXJmSWR5UEx5Uk41RitKdzIrN1lPbGRHdWdWcFFQcnRDeE1Q?=
 =?utf-8?B?ejlOV0ZxNHlrTnNmLzJEUFJEYStYMHJuNWE2bmxOUHZYRWh0a1FyeEVDYnE3?=
 =?utf-8?B?NWRpaDJzQ3Y3QmR3UjYyMnNoT016cDg0SVFFOVVXRVpSMk91Qm5pdUtzZjJZ?=
 =?utf-8?B?RmQ3MEJmN2hVRUU3UzFmOFhvaU4wdDVIaS9LSXFhUmlIZ294MWllZ05RVm1l?=
 =?utf-8?B?QUN0bHNNb0VCd09MNVFhRkNYZURLT1RyQjNTTzlxeVdHQ01VT3UvbldFTnFZ?=
 =?utf-8?B?eEE0THBvRldDbGxjQWgxZEJLNGpBUVlhOVBsQVdwbnZHNW10YWlYT0ZXS3dt?=
 =?utf-8?B?azhuT1NHckYrK25SZXV3M0NLeVAyQ2ZvZStYOENhc28xL0Fra1FsMlZrd1hl?=
 =?utf-8?B?dTJIYjBZdk1oQUZ4QkVpYXV5R2x1RUVCbnBtRG0wMS9iMDdKSmR6d2xYdEZB?=
 =?utf-8?B?ZzlqdGVST0lNWitYM01lQUZpUExMRlJiQmMxSEsvRTY1eHdIQXFCNlVWRlVC?=
 =?utf-8?B?VHVTcnFqckw3aUFpYk5wb3pRK3BxWkZVV3ZFSWEzQ2NVYTdQTzhrZHdPMFN5?=
 =?utf-8?B?cXFhVS9UZ3ZiQlJNblZLK2FTYlBkY3pQb1dRYlNDYURIeHZDdjNQMEhmZW9i?=
 =?utf-8?B?NXVyeUZhdFp6M1ZqL2hPMUxhK2NjVmZjc3hmS3NYamNtbFlUc2NRNmhGS2ho?=
 =?utf-8?B?ZnJPZEM5dW5JMUdGMXh5V2Zkb0puQ2crYkNrNEVaREkrNFZrNlh5SmhFSWJC?=
 =?utf-8?B?eS9EUFk4dWhBczFoMStCK2tzSThkTS9vUnB4blJTbzZ0R0VyaHpNcWp5RzFx?=
 =?utf-8?B?cHpQVnNtODBnVDlzNU9KVU1hZUp5WHNoVVB5dW5mQUZ0TlYwVzl4NkZHWnBl?=
 =?utf-8?B?a3pSc01aMUdjakFtUlVaenlXUEdRNTFVem9QaE4vVnB0M1dqVzI4c2crdXBR?=
 =?utf-8?B?UnhRUGpEV0JpdWI5bHdnZW1oYnovZmdFd2t4Q0FDQzd5bHFCMEpoMU9WZHdo?=
 =?utf-8?B?REJ3dnQ1QitqbGo3UzE1Z2NXYUw5dHR3UGt6WHdJYUMxT21ZWFBOL1lvVitr?=
 =?utf-8?B?T0x0Tnpkb0puWS9LM1hNUUlGdnNGcTZoN2NtT203elpSb2tiS2xCdmlBQlRm?=
 =?utf-8?B?WFY0ajFRdzh3dlF3dWFiNEk0SDV1UW9lMU5Bam52K1RBZ1kyaXFDR2FUSTZZ?=
 =?utf-8?B?R2hhcFVXeFYxQitqL2JFT3RRWU9WOVlCclpSS0hmVXh3bG4rSU5VTWZXMDg0?=
 =?utf-8?B?RnRtcUpQTlhSM3d1WmQvdlNJUWRSVVFJUy9RdlhmRmVWcHh2M01RcDNjRnVJ?=
 =?utf-8?B?WmptV3p5ay9rZUNEZnM0ZmFPN1o3WkNuL2NUMVFmQk81N25vSlhsdlo2TlJt?=
 =?utf-8?B?NEM2aWJHNDFibUNLdmVrOFRLZ0JqZXk2Uk1IZUxOcDNScVB3SGR4YXpIcEpm?=
 =?utf-8?B?SEZpeFRVNHhJQnhQRloxTU5HRmZtK245bGZPRGJVMGlwdFRYVjliYU50cjQ4?=
 =?utf-8?B?VE9Da1N6NVpac2FyTDJvZVovZGp4aDErTksycUJOZnBCdm52NU1NdThjckw2?=
 =?utf-8?B?Ykd1WFFyVFJsSkhMdjh4TGtleEE2Q3piY3R0cHp5MlVYbFowSlZHYW9leDJQ?=
 =?utf-8?B?NzFqNi95ZzhiZXI2RGNkQjlzVE00cTVqQnlqekt2RHlURjl2ZnFjdU9ncXMr?=
 =?utf-8?B?bjNwM1VLaWdydjVnTG0valhsL1NFM3J3cllBWnZEQUVCa1lwZENXaUtZYVg5?=
 =?utf-8?B?TDVwSEpOWk1mY1paZ0ZWUVI0MU5EYVRTVC9SUGtRd0YyZTI3cWVlZXJsOW42?=
 =?utf-8?B?S2tKZGR2NlpBZVNnODU3aW0zSEt0eXVuWktaRDNrK1FoVXFlRDhVZis4YkNk?=
 =?utf-8?B?RHk3ZHA1T2ZWRWZrSTNkVXk2ZjZzcGxETGRRUTVQbm1pb2tON0tkdStxWW5u?=
 =?utf-8?B?R0g2STZFY0ViTk85ZTUzYTVuUUtnZnBCSWhPVlR0UlByWUtoditxNURwSFJs?=
 =?utf-8?B?ZzRNSG9abFNSRXkxaFUxV0piT0p5VFNSQ1B4M1VyVmJJem00bnZLYkFXRWhY?=
 =?utf-8?B?bUFac2xyM24zb0RCdW9ieE94TUxBU3RsdkpIS2wyOVlkUVl0VGdreGpFMC9x?=
 =?utf-8?Q?eJne+6EXIujSGNW4iOCJRsbnQbXQY0zlE+K+e?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb4515f-5c65-42ca-d8eb-08de9ec7ba9e
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 10:29:40.0992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocJoC0PLB8kiu8GVnA3Q7lqarPp96uR8yzp0Qpe6kXuwd82DIQtx9floEZjntqWgChCDt/UqgNVoNRkwbhaNZFyWHBffbcdOwaoCY30Pd6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7769
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Apr 2026 10:29:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3736

Hi Martin, Trevor,

On 4/20/26 12:14 PM, Martin Herren wrote:
> Dear maintainers,
> 
> May I suggest the following 2 patches from meta-rockchip master to be back ported to the Whinlatter branch ?
> 
> fitimage rework: fe7cfa748bb132cfbe322c1c6d586f09557dbeb2
> 

This one is tricky. We shouldn't break existing users but this is a 
patch that isn't backward compatible as we would require users to set 
the RK_KERNEL_FITIMAGE variable to match the modifications they made to 
KERNEL_IMAGETYPE/KERNEL_CLASSES in their own machine configuration file 
based on the SoC machine include file. Can you tell us more about what 
is broken before this is backported? Maybe there's another way to 
implement a fix without breaking backward compatibility.

> bsp: rkbin: fix build since S = "${WORKDIR}/git" is implied by OE-Core: e59f6fcb66091ea5efe33f3f3d8be09b1f65bbfb
> 

git tag --contains 46480a5e6674
(the commit listed in the commit log) returns the first whinlatter tag, 
so should be fine to backport.

> I understand Whinlatter to soon enter EOL, it would make sense to have it enter EOL in a buildable state.
> 

Yes, but not by potentially breaking existing users, so special care 
needs to be taken. This is not a worry when we're working on the master.

Cheers,
Quentin

