Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FDC43458
	for <webhook@archiver.kernel.org>; Fri, 10 Jul 2026 17:15:55 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.390.1783703747827547472
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 10 Jul 2026 10:15:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=hsQxMXvl;
 spf=pass (domain: cherry.de, ip: 40.107.159.32, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NM3RR1oEBaNH4BQczL3WMnISMIefy9OCSgyaHtPpr5p/AEBuoWGRBxam/ZVErNnFDH/UNP0eWu7foduLwZbcBzDCy3hXCYo56gCdk9c4kbR89WHhrPUL2BJJhHV+8kExWko6+qW/Rc3nx8P8fGhoaJRQMKZdEHB3IsPIhH/zmVv3zIQL0dRm1hQV/XcUK/IdfADp2DtREmlzaJwYZIK9BL2Qbm1wi838B6zhosdwMDUKOpEVbpcuNnrPK3v+I44TlVOK07oSHZD3TvMSGfQZauzqvREiv9yr9OoEQmZqDW2NhjKngrtSGrMvICGePSgQvKYXLZT7ZOlz/x80Z6Jqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGyCffSCf9xO9XNHIEH4K7WYg99nL72UiMbz+W3LYoQ=;
 b=Ty0sjX/9Yn2wro1IFRP3+us4OiZqpSIGAkjYVtzkJlBr3+qJPHXuohFTEd/a4rJho5hVZfA2SFBqwCE8dOISxJiP80DmtwZJt+H/PeSpoxd94UatgwFhKC/SVCRQ6Qjn4SEYZ6rl8pvXPt7vtcUwx4Uqa4bMJGBqc4rwsYXh0WhrNv41uu/uXAuqVz8juIYqW0n73mq+sUs0eOab9c7iQfmcc4DW+N0ZojxzFNCVDtVlMPAiaIl3gTRorRC1DM7XK8wRLxOIj8fOMwjn75u4z7JleMAS30cLvkW58mv6bGM06lDRO7dpeiLbdOPSpFIAQKswQEcKW8dlWuuW6UM4lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGyCffSCf9xO9XNHIEH4K7WYg99nL72UiMbz+W3LYoQ=;
 b=hsQxMXvlP+C5xjgS3yky6XE7eDIBjDBEMdkhfq8zHD2XtMfmWOZyi48lAPkSYCT7NPS1SP+Bh+zRa2/g/r0pyO5De9mhIMGO/qEIvYb8w/xZ+j0+3BWEVliGAK8nIGKET8HUZBlpYQ6yhODBjY4WUp/XugGezEtvdh7EJ4nkFIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by FRWPR04MB11200.eurprd04.prod.outlook.com (2603:10a6:d10:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 17:15:42 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 17:15:42 +0000
Message-ID: <a3f8df2f-15d3-4921-93dc-0b0cf59af98f@cherry.de>
Date: Fri, 10 Jul 2026 19:15:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip 2/2] add support for baking
 OP-TEE OS into U-Boot proper binary
From: Quentin Schulz <quentin.schulz@cherry.de>
To: yocto-patches@lists.yoctoproject.org
References: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
 <20260126-optee-os-v1-2-874261a77dad@cherry.de>
 <ahcOBJWhevGNqPyF@localhost.localdomain>
 <1226166b-a604-4a40-95d1-68d8d5c64d05@cherry.de>
 <18B5F81EDB16A25D.1007@lists.yoctoproject.org>
 <akra4jhkqxfTYgq9@localhost.localdomain>
 <5c140ca4-f22c-4a20-b74f-01711c1bb819@cherry.de>
Content-Language: en-US
In-Reply-To: <5c140ca4-f22c-4a20-b74f-01711c1bb819@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA3PEPF00000525.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::679) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|FRWPR04MB11200:EE_
X-MS-Office365-Filtering-Correlation-Id: f5867140-a368-4ecb-4460-08dedea6df1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	YuyvHQeEkN05nIn62d98DQoeT+kyG5ivYt8d3iGbM/If78Odya2cNDdn9aPY47jpuW7o6vzdjxdA023geaPros0kwlr+2cL6yWCzKeyo0V1D3sRVgyJkJz9UhpVZOGLKSK7+8dGoxK3KEaOPUZiOMjqSyuOXJCf6WNTEJkpV0LuZq6BeJDAsPhwRRlhGA398UMAtDm2yL2ROKxMPHGW3EDyzIOGZmdYSnG6i3tHd81WY8zEbvt3YdsEkijylkrpjr/DR16NYJwwNJgWZuqLAvs/kmxw9mzutzCMGhOI2MdkTUcnTb89pLU3d3XcdGCkSNS+M3xWWBVrEcTWvQcmhl6yG8OH0Oi8wF1ob+XZDNi2W6pwOTdkoKYfUdFzs4XexW0zF8bVa2jHpGr5ez+VFQGtcJwps8naS/1G/Xc3hA3AoN1BDsP4A+8Js/Hi8FrFQtulu3UFoMIgQf9L8nAyuVjvhvm7TZd9RFZWG2G6jZGVMilWNYZTEnXedRSAMvnp1NzyRu2sUH/FiRU0xNKZa9ZwWwLvMXyLuMHMjP7G1X3fegYBVUK8FAx+jdRqLnQ/A7kjqJajyyvSAmcrtzgjoTAF0Pilf28tA/Hs93f42NE69Or+fc+fssWypuZOiO3oVz9SVKLvyCLYju7KN83QHKK5SyNWQYE7wIMlPNk7ElUY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFpCb1dNbFV2ZTY1VGdBemkxdTA3UlVEM3BXQlc3dm0ybGFWT0xrS0t0SG1p?=
 =?utf-8?B?Vk9UaHB6S1ROdDd6SHBycGZ4eE1IQnpDK09Lbk5KWElEWnFSeWNZcFZUUHAv?=
 =?utf-8?B?V1ZtVHl3UHFxbmZwN3VucVJrbUlTcGMxQWdOQ2s5eWgydllNNThPTWRweXpK?=
 =?utf-8?B?WmxObjFsQWR4VklBRDh6OWQ5VTdHTmh6Y29QLzB0SUtBalNjekoyU0pVRG9E?=
 =?utf-8?B?SmtrR0NZejhoQnZKMmtSSnhlR1dRVHZWcktQVTROMkIwMGtzZEU4bEJMYWhn?=
 =?utf-8?B?dkduL0ZGZ1pEWGZyWVI1dzN5RFNjaE1uTXltQk5QUS9DUFR5OW1MaU4xQ0J2?=
 =?utf-8?B?Z2E1amtPRi9ZYzRqeUJhT2hxU0NrQnpNTk1TT2k0eUV3OXdiMjFoakhjaVFm?=
 =?utf-8?B?WHVGVlVDUDFNcmlUUW13b2ZBcmlKR25HaHc2cisxMUd1bEhWRWg3dmdkNGVu?=
 =?utf-8?B?bkZIWGFSTXVvRnpaUGNaK2s2UWpJaEw5OWRVNmtkdm9ZSGVjODNUZ0t1dGJU?=
 =?utf-8?B?ZzRheS96Sk1JVUQxakd5ZXVXMTlybXBjQUswaG1sbk5oTy9NdHI0Zm1tL1ZP?=
 =?utf-8?B?a1JZbFRPUjJqeGhpZ3pqVlJTTjR0Q2thQU5WTGxOeUdHcHdBeDZRR0hJbnRv?=
 =?utf-8?B?VXBhWm1qYTJ5M3NhNEpSTC9BeFNNU0RXdWpWTFR3cEt0UTRSc1RvczJLUEND?=
 =?utf-8?B?OXJ3TmQwK2h4UW5GY0srREFuejFFL2Y5SFByTFJDU2pFWFZjVnZaMTRNcUxk?=
 =?utf-8?B?bGpDRWJiTFN6YWdFMzVpTHd4VHVHVkFocUMxSjk5bWh6V1l4dCtncW1WQ0hD?=
 =?utf-8?B?QnlwTG9wd05rb2FxdkFIbHB0N1FwTkE1bkNVRDhaN3l5MWltVjJQQjIvU1FD?=
 =?utf-8?B?bEJQZzdGRVh0YjNNbE9zeWdITC80RUxwak1WRzZ6N044Vll5aUEvTWgvUzh0?=
 =?utf-8?B?RmZvbW5rZUExZEhlZXdBbGJNUEsvTmtHblp2UUhnYzRoSlFrMVMySWo3MURy?=
 =?utf-8?B?TExwQVd3L3pqWVF6RktYNm5ZRlZWQ0ZsRForcktjWko0Q01RWjB0ZGVPT2hj?=
 =?utf-8?B?aUtoZW9BWFA4QmhhcWdZMHZUSXpmVWsvVDJQekYzb1BTN1djcGx0bU0xWWly?=
 =?utf-8?B?ZlQrMk5BdWQ3UHZ0ckxuZnNOSUlONXkrbFZ5TzVWQ1JtU3Ftbklid2VONkJY?=
 =?utf-8?B?WDZQUktUWE05NHo4VEM5aUJXdGdCbkpab1Y3b2V4Zk9ndkN4cW9XaXhIM0lC?=
 =?utf-8?B?RGVHSDJRT1dWYjVxVGdBSWFWSGNObUJPamlSRndKZThTN3ZkcHI0ZG1nMldV?=
 =?utf-8?B?Z2lXb093aTJSbWR2SUVOQW1jWXhVY2pXQ2RjL2w2Sm5EWTVoYzBtcEZNMkNS?=
 =?utf-8?B?Z0ZoYTZ2c3hZN2plM2M0Z3VhQ3pPNHF2d2pmMDFqb1BndVlIbjlCZ3JjV1Ax?=
 =?utf-8?B?anZmVUxuN2t4Y1hIRHh0TEYvWFl5c0ppV3dTUGpaaDBISk9mMW12UUo0bDNw?=
 =?utf-8?B?MnBIV09YZk91dnViaGVEZDZRVUtHOFJUZHJKeTdUUDd0Ymlaa3lwUXRpYzQ2?=
 =?utf-8?B?dklNVDk0TTUyN3pVc2dEZUl6dmdXeENGY0JZb2FEQVc3NXltanNMVzZVUXlE?=
 =?utf-8?B?aHhZdnc0MGhHYUJBRFMrclpVNTk4TG9kcjJFY0pQR2t1KzJGVnk0cVFJK0lF?=
 =?utf-8?B?cGdvNlozbmlPT2QxazVlV3V4aGdwRkYvSEZKeTNHTUJmRzJGd25pSmxvcFR1?=
 =?utf-8?B?bWg3WmthTlV3dU1QZUZWYTJyMlhiZ3JlL2tHUWY0dXJQWDFxekZZYlRXaVF0?=
 =?utf-8?B?a0ZCZnNoNFFablgvNCtGb3JRTmdQaW9KQUFnTGFuRTVWNVdoQ3k2RElOdURJ?=
 =?utf-8?B?TFlQNGE0bnNKcWo4VWJjY0poN0o0V1lGTG1XZVU0THNjTGV6SlV0elRndlk1?=
 =?utf-8?B?NDNodHROUHRrZlJPd2w3NWIwUGpBaFVQTjNTL1BpSVA0RjJUTHNESUxnWHlT?=
 =?utf-8?B?MnVONUVzK1BEM0ZxYmdtUEtFbVBWUmlTKzRvYVFrRHBsWUNVUnFYUHNVdG0r?=
 =?utf-8?B?MlZTb0xQMWFSQ2FIV25KdGQxUk91YXQyb2pKRWZOTWFuZDZpWFVzYmY3ZHJQ?=
 =?utf-8?B?STVUYnJjS0RIbG01dDA1SXZBNFkwNXh1YnpoOFgzTXNYNzBMeEN0L3lNSVFR?=
 =?utf-8?B?WUR6dXdTcGQraGJnR0Yxcm1XZnNVYWROTlRRZmZtODhVNXhUSmR5Z2VjNnIx?=
 =?utf-8?B?U2tVQ1RzTHRBbHN2bS8zSmVCVnFrUFhNbXZVS3BYaGxnblpYWHBpd0pVQTBx?=
 =?utf-8?B?N0UxVmRQKzZCTzBTVFZQbTdPZ2JwRExmMG5kbEF3QUhtbjl1NHRodz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f5867140-a368-4ecb-4460-08dedea6df1c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 17:15:42.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn8flNONqCZpgyUPXPr0Z7mIly0qWeKnGZdnuWMeYReDaSd3EM1Dcwh4C5h7A4TMyCp/b9EHx4C8FjOEEY47TawPX+H+4SjzJ7w3OBEDTKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11200
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 10 Jul 2026 17:15:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4469

Hi Trevor,

On 7/7/26 11:27 AM, Quentin Schulz wrote:
> Hi Trevor,
> 
> On 7/6/26 12:29 AM, Trevor Woerner via lists.yoctoproject.org wrote:
>> It looks like I forgot to add you, Quentin, to the "to:" or "cc:" for
>> this reply. Are you working on a v2?
>>
> 
> I saw the mail, no worries but I appreciate the follow-up! I have a 
> local branch but I'm lacking time to test at the moment (images built, 
> waiting for me to boot them and type `xtest`). Hopefully I find some 
> time before end of the week but no promise.
> 

It seems OP-TEE OS has regressions on PX30 unfortunately. This is the 
result of `xtest` (I'm on master of all layers when I did the checkout 
in June 26th but OP-TEE OS hasn't seen a release since so that shouldn't 
be a factor):

+-----------------------------------------------------
35460 subtests of which 6 failed
112 test cases of which 4 failed
0 test cases were skipped
TEE test application done!

RK3399 and RK3588 work fine though. I'll need to check if it's fixed in 
master or if I need to bisect and work with upstream on fixing those 
issues. For now, let's park this.

Cheers,
Quentin

