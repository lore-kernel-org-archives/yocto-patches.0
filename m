Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23094C43458
	for <webhook@archiver.kernel.org>; Tue,  7 Jul 2026 09:27:23 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.170414.1783416432792705214
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 07 Jul 2026 02:27:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Dwd93fu4;
 spf=pass (domain: cherry.de, ip: 52.101.83.7, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNFCkD2/vzooKe+Iwy15MdHYE0PX+hXc1rnQVEDdYLVhCpdcCMp1vHup3wO2+M1Nzbdc+WXKLh96yiFgpXZ+msL+BzQZ2uYVD6Oclb869j0xL7rdGRujzfYFDaGaXmiqHJkcEGZdbWxRhkTeVnhcU+/9f0woaecnuBWC5hD8ShSHyjpPk9SyGPaRUz7eEmUDw3mXahLxpwe93yItDBfiMIPU9XI0oEhbGtPYIjRXqesji8XT+BvkhKpWyH8fy1djaxQbGFrEdpecKxTZk7+O+chfETdDT906cvRfLjrEtJXfgE4kNc46i0m5HbVb/DbQzq6SqU2BEC/Ob1ITGU+hJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzz7B+oJ0+kBh8sIResHmENzkdJTaYpAApoR8ZoxcQQ=;
 b=BoccP3SnPLxg/I0Pngz1iySvsbJj+Ed+R031iSc+Y/QX2bEw/Y1smYlu7t06bXSB1bEeZ//+rtMdUabhQ22uE51TVx4XLsOp6tOAxZeuni0jR6m3D0Ag5Ej7hNLTtLiJA1bdDHjArGQVFcCEoPGw9/hCXr2j2qrCmGW0583mCT2A6QPSAVIFjDrFcKrqfdywzfr5Ynq/6q14YtV4y/ZMJt1zn88oyBAr2DUbTn2rP7n8KzHBG0MDb+wZbJrEirpYpRJ5on71BqIgYeyu/ItZtxS8qVIrCuEgw4qAkMdhUFy1M/ePHbuACaFPzwGX4ttodbmgQfvfvfNsgpTgIehoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzz7B+oJ0+kBh8sIResHmENzkdJTaYpAApoR8ZoxcQQ=;
 b=Dwd93fu4/GNHA6SAztp9laGe0CBNk84peKa6gvsbjid2dw0KS9gM97hJKo26eCYruFhA6o+PT1xou7En6hhqkkZpXfenUfjEHvjflRJYqucjl/KmmAEOF8XDhgEeGCdZ2mDVCQ4f5Jdhx9BrbbdIZ+j+MP8+QTUKccsE9IUUjw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA1PR04MB11382.eurprd04.prod.outlook.com (2603:10a6:102:4f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 09:27:07 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 09:27:06 +0000
Message-ID: <5c140ca4-f22c-4a20-b74f-01711c1bb819@cherry.de>
Date: Tue, 7 Jul 2026 11:27:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH meta-rockchip 2/2] add support for baking
 OP-TEE OS into U-Boot proper binary
To: yocto-patches@lists.yoctoproject.org
Cc: quentin.schulz=cherry.de@lists.yoctoproject.org
References: <20260126-optee-os-v1-0-874261a77dad@cherry.de>
 <20260126-optee-os-v1-2-874261a77dad@cherry.de>
 <ahcOBJWhevGNqPyF@localhost.localdomain>
 <1226166b-a604-4a40-95d1-68d8d5c64d05@cherry.de>
 <18B5F81EDB16A25D.1007@lists.yoctoproject.org>
 <akra4jhkqxfTYgq9@localhost.localdomain>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <akra4jhkqxfTYgq9@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR09CA0156.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::40) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA1PR04MB11382:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f247d49-ee40-4f26-0573-08dedc09e96c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|4022899009|23010399003|1800799024|366016|376014|18002099003|22082099003|4133799003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	j6Tw64XXFezJotImS8bJVb59HFZxgbdfACwmqLCSVJRyGtcyikLFdvHHKGPDfMsnNMNm6nh3pvQnrdQJLxRMfQgz6+j0epLCyEgtM1e+9v2OyrmiQSJbl3gzbZ+C1bKChl9Vj1gNigQlNo+lLJLXau8TA1fuJzL+6Gno48ZRgSYTS69hLQBabvYq1GBAL6yMJx0Qnbppu11FQaoWSlklxKDSk7yL5IG7/2ZkyAMjUhqP7HnVhStENh+GiHU9KqTLIrX5khfYoyf+mb2rmtRDbtALEHSwbp4T0jjjf6d9YfAz7lBa9c0wxc7la4Hhnbi5G7Y7NcAM5TkXRhYnd9hBEtF8LFh+5YHBcwfNaxnXef7nQmSn80zRjCo/Dgu9fAcbJ4Oy9cig4/NS9tIWnu70s928RVSk6F7quD04oOq8anS7RQEAW9NvrhEJSAVkldt3anm3pAO5SEkHXQ9deFFLohpOmqA0xnUnZYeYP/46wsKib68cE3GbVzY/KtjmpiUcEwN+s71yZ8DiGicNwBimPkl7w0oIPURulUBuaH4NYwKY0aExUyZp2oCZrAyMUdUoLbPha2B1ukLxKALr58Pgp3y3Cp+Kise/eaUBkNVmM/GIySC8oRWRoHtehz6yCRqp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(4133799003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmdyTjY4dGJsVktRSG84THc3Qy9OVVJCTW1WM2JTUkF3SjJ0ZWVlcWhTVzJp?=
 =?utf-8?B?SzRNb002Nm92UWMrVStVTTJFcWt1QklpeUtPbEQxM21GeTc5REVEVDFMKzFM?=
 =?utf-8?B?OFhoSHBDVUFmUU5xb2lkMmQ4OGxVUnFkWEp1MllUWk1JVE90cEhENU9XUXpw?=
 =?utf-8?B?MllrLzRLdHBQQlNDY1pYWmJvUG42UHUyQzFqM1ZsSmN0cWlqUzBCcnh5RHVX?=
 =?utf-8?B?bW5rSzJlQ1N3T2p4L2wxMEtKR2pCclhuTTREelVtV3RFYjRpbkdlVzBKRldq?=
 =?utf-8?B?aEpHVWJlL2dsYm9UQ0gwZm1ZMDQwcnRiRnpIREE2dmF6aFJxV3BQTTVFcGJQ?=
 =?utf-8?B?QmE1VFNITlgwVDgrcGZub3RQNnBRY1dGRVpTTkROUHZjUXdIbG10WnpYSzZz?=
 =?utf-8?B?bG8rUk5GV3hOTklIRmVLYVdiZXdQbUhtbmROMWJrNjU3S21YOVVuUkt4Tkwx?=
 =?utf-8?B?MjhSbVVyYVAyQWFlQmdsOEVXT1k3Z1IrOEViem1VY0h6UHdlWnlGUEg3T3du?=
 =?utf-8?B?UzZkc0Q0NHZzQmVjT0pIVGFCemxiQ01BNGNtVmdZM21VKzdmSEYvenJ6MGhz?=
 =?utf-8?B?UURMUDJ2dlIyTGx0WGdaL2lZM3ZiQUVHTnR6ZVJnQWNUUjg4VWtWUVk3ZGFa?=
 =?utf-8?B?ajBabVlqM0ROa2wwQjZpK0w0Yk9kclBlM0VlNEhrOGRaT2NVdkQyRXhRazBs?=
 =?utf-8?B?eHNBS0FSNE16NXFieHo2STFMcEJsekVWNVFCNmdxSnpZY2RUTlBnSFN0TENO?=
 =?utf-8?B?QldaK1V5MGM3VFh2RHVRT1lyR1NZb2QyOEh3aEdZelV3Sk5mbzFoeWNmdkdN?=
 =?utf-8?B?QUVhOTkzbjljaG5uTk5CTW83ZjlzRWd0MlVZNGFkbWgyVjBkT3MvT0huYkxJ?=
 =?utf-8?B?R0R2Y3Z1RTZVYmlvRmY4dWJVL0hDQXAvZ3o3WWthM21JT0M3T2FOeFBia2RM?=
 =?utf-8?B?M2JHWk9PSVkvU3I1OFhBaWl6S2hGZVhhRmcwb1g2S2MrcnV0dzd3L0RGRUlV?=
 =?utf-8?B?RkdINkd0akR6RFFCd05CUUN3Y28xbUtSRGZlQVVsbFB1d29GVEdTeUhoRy9I?=
 =?utf-8?B?WEh3c0Y0VFgxK3B2SEVUNldRMTJUSFJoSTh0R3d3NjhlaE15MmViQnBnZjVI?=
 =?utf-8?B?dTN0MmJTVll1dmNvc0NWN2krRDZBZVBZVi9ycFF6SHE0bG8xMXVqRGczRkE0?=
 =?utf-8?B?WlgzYzlVVUtzU2ZDckNhOUhqSjljM0ROWXdUK1JSZzVRZEZPVUJPRUpuS1VJ?=
 =?utf-8?B?MDE3UTRRdEZRRmdraEljNnFpQ3BaekMvUTU5QU9uT2c5UWQ4bkFYbWxLenZF?=
 =?utf-8?B?WUdzVTF0VjlRY09Dc3V5dWQ0ZXdaR3JJYVZWZWIwRXVya2ZTM1hjMlRYQU1k?=
 =?utf-8?B?NllQZDBwK1ArK3RPNnljNmN4OHpjRVFPSlFUeEVnQXBWS2tDdU03NHZvRnJr?=
 =?utf-8?B?dE9PS1F6OHN3bXV5RC9oT01tVnR2eUVqSXJJbmxaMmg2bDJYQUhSOEJDV1Vz?=
 =?utf-8?B?bTBEYTQ5SXRXcGZoemtHeER2UldUWkZpbXBwZlBCQmxseksxSTcxM2p5Y0RV?=
 =?utf-8?B?bWZINjVCY1lRSFdIMmZtQm5HNUlXQ2tpRFQ0bTVsbzl0Vkh4ZUVhLzhlS2FN?=
 =?utf-8?B?WGFxWUo5bml6VkVmQTV1QTdnSVExdWh4Yk5oVkd5YXFkZ0I1T295eCsycDRY?=
 =?utf-8?B?MWZWL0xHSVdQeFlCUmlDa1lQVmloUVZ3elpZaDA5UmZrOXU4M2ZSYnBZaHRM?=
 =?utf-8?B?eHVpSEVmYkx6dXRoTWRlTDE5dEdzSE5rb2dTNms4OTVGT1V6RnR1TDVTclBz?=
 =?utf-8?B?cmlrelQxRFJvaytkVDV5U3Y4VXJ3b1hDd3dENnpVMWdvN1JRdUx6bGJlK0da?=
 =?utf-8?B?VUh0L1BUM0J3eVNuMVVYZnN1SDcrWXNWbjh3SkVWcjVocWVkMHdxQzRUNnZh?=
 =?utf-8?B?YWp1L2YrWllESlI4MUFPRUZtU2IwVHM5Rnp5akFSUDl1MjRFVmI5S256QXpo?=
 =?utf-8?B?aU96Y2xyWGhlNHpsdURhS2JIc0F3K3NFeVcrUWpCV3pObkowZFZCWi9IZmE2?=
 =?utf-8?B?cW5NSmc1bExHUmc0aTFLTytEa0JqS3ZlNEtsUDhjMEVTRVh2VFFsdklseUM0?=
 =?utf-8?B?K1I4Mm5FNktuNnJEMndsN0toNEZyR3ZwY0JybGI1ZDBJa1pFNXhtWlFHdCta?=
 =?utf-8?B?Q0p5cTUyZmovZTJUNnh3ZTBJd1UzTkF3cmYyTis5RC91NVF5ak5zQ3pRSDVa?=
 =?utf-8?B?VDM5MUxocEZOVzJjUnRnT0lIWGNoUUh2cXRXQTlmblVNL1k1bEJESXZPQkdC?=
 =?utf-8?B?WmpCWG1nTkJuQVczcFpDamlSTkdiVTZFNFI2SGYvZWc1NGx4ZXBwQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f247d49-ee40-4f26-0573-08dedc09e96c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 09:27:06.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEq6mW4Pv9cWZsyj3KG8MM0/InzwitNEcp032MNn1MbqiFhGBKuZf/QjJVSkw5I2M3p/leAAEj90hfbVshduQ5680ZnNb71iqlWX87TIE1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11382
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 07 Jul 2026 09:27:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4450

Hi Trevor,

On 7/6/26 12:29 AM, Trevor Woerner via lists.yoctoproject.org wrote:
> It looks like I forgot to add you, Quentin, to the "to:" or "cc:" for
> this reply. Are you working on a v2?
> 

I saw the mail, no worries but I appreciate the follow-up! I have a 
local branch but I'm lacking time to test at the moment (images built, 
waiting for me to boot them and type `xtest`). Hopefully I find some 
time before end of the week but no promise.

(FYI, there's also an NPU series for meta-rockchip that never got a 
review, so if you're looking for something to keep you busy: 
https://lore.kernel.org/yocto-patches/20260423-rknn-v2-1-b9457a38c140@cherry.de/ 
(don't know if it still applies cleanly or still works))

> On Thu 2026-06-04 @ 03:40:35 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>> On Thu 2026-05-28 @ 10:48:24 AM, Quentin Schulz via lists.yoctoproject.org wrote:
>>> Hi Trevor,
>>>
>>> On 5/27/26 5:30 PM, Trevor Woerner via lists.yoctoproject.org wrote:
>>>> Hi Quentin,
>>>>
>>>> Thanks for this patch series!
>>>>
>>>
>>> Thanks for the review!
>>>
>>>> I believe there was a little fuzz required to apply patch 1 (around the
>>>> -D), perhaps a v2 against the current to clean that up?
>>>>
>>>
>>> I'm assuming due to commit 9fb264d42a20 ("bsp: fix upstream TF-A deploy
>>> desync") already being merged.
>>
>> Yes, I think so.
>>
>>>> On Mon 2026-01-26 @ 03:48:30 PM, Quentin Schulz via lists.yoctoproject.org wrote:
>>> [...]
>>>>> diff --git a/README b/README
>>>>> index c2697d1..f49fdb5 100644
>>>>> --- a/README
>>>>> +++ b/README
>>>>> @@ -222,6 +222,48 @@ Notes:
>>>>>    	NOTE: this variable must be set before any include/require in the
>>>>>    	      machine configuration file
>>>>> +  OP-TEE
>>>>> +
>>>>> +	PX30, RK3399 and RK3588 are all supported by upstream OP-TEE OS. By
>>>>> +	default, OP-TEE OS is not baked into U-Boot.
>>>>> +
>>>>> +	You can bake OP-TEE OS in U-Boot by setting:
>>>>> +
>>>>> +		RK_UBOOT_TEE = "1"
>>>>
>>>> Is it worth pointing out this is a boolean so any of
>>>> "1"/"y"/"yes"/"true" or "0"/"n"/"no"/"false" will work?
>>>>
>>>
>>> Not sure it's worth the added complexity? We also don't say that for
>>> RK_IMAGE_INCLUDES_UBOOT_ENV, RK_RAUC_DEMO, RK_KERNEL_FITIMAGE,
>>> RK_OVERLAY_DEMO but we word it differently for them.
>>>
>>> Would,
>>>
>>> You can bake OP-TEE OS in U-Boot by enabling the RK_UBOOT_TEE variable
>>> boolean.
>>>
>>> work for you?
>>
>> Sounds great!
>>
>>> [...]
>>>>> diff --git a/recipes-security/optee/optee-os_%.bbappend b/recipes-security/optee/optee-os_%.bbappend
>>>>> new file mode 100644
>>>>> index 0000000..2a5ec8b
>>>>> --- /dev/null
>>>>> +++ b/recipes-security/optee/optee-os_%.bbappend
>>>>> @@ -0,0 +1,19 @@
>>>>> +# Increase size for FDT in OP-TEE OS to the one in TF-A since v2.13 to avoid
>>>>> +# panics on 64+KiB FDT passed by U-Boot to TF-A to OP-TEE OS.
>>>>> +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7687 is merged.
>>>>> +EXTRA_OEMAKE:append:rockchip:aarch64 = " CFG_DTB_MAX_SIZE=0x60000"
>>>>> +
>>>>> +# Disable early console by default to avoid OP-TEE OS panicking on boards with
>>>>> +# their UART console different from OP-TEE OS default (UART2 for rk322x, rk3399
>>>>> +# and rk3588(s)).
>>>>> +# In-tree default changes if https://github.com/OP-TEE/optee_os/pull/7688 merged
>>>>> +OPTEE_OS_EARLY_CONSOLE ?= "n"
>>>>> +EXTRA_OEMAKE:append:rockchip = " CFG_EARLY_CONSOLE=${OPTEE_OS_EARLY_CONSOLE}"
>>>>> +
>>>>> +# Enable hardware acceleration using Arm Cryptography Extensions on PX30.
>>>>> +# Can be removed once https://github.com/OP-TEE/optee_os/pull/7689 is merged.
>>>>
>>>> Have these 3 merges occurred yet?
>>>>
>>>
>>> Yes.
>>>
>>> b6c7291c246b ("plat-rockchip: increase FDT max size to 384KiB on all Aarch64
>>> supported SoCs")
>>> 763be3b08c16 ("plat-rockchip: disable early console by default")
>>> 74eb4d9ed3ac ("plat-rockchip: px30: set CFG_CRYPTO_WITH_CE ?= y")
>>>
>>> All available in 4.10.0. However, meta-arm currently is still at 4.9.0. I
>>> don't see patches on their ML
>>> (https://lore.kernel.org/yocto-meta-arm/?q=op-tee) for a version bump so we
>>> need to keep those in for now.
>>>
>>> I guess I can change the comment to say we need to keep this until 4.10.0?
>>
>> Please do.
>>
>>> At the same time, it shouldn't hurt keeping them in even in 4.10.0 or later.
>>
>> Okay.
>>
>>> Cheers,
>>> Quentin
>>>
>>>
>>>
>>>
>>>
>>
>>
>>
>>
>>
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#4419): https://lists.yoctoproject.org/g/yocto-patches/message/4419
> Mute This Topic: https://lists.yoctoproject.org/mt/117469183/6293953
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13168703/6293953/1843281461/xyzzy [quentin.schulz@cherry.de]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 


