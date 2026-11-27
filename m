Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14772.1795781000545880769
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 27 Nov 2026 04:03:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=KCOU7I1c;
 spf=pass (domain: cherry.de, ip: 52.101.65.23, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI4VSaANHcuse+cqP56u2V0J4OcwzpX0vbnRqrlCnQULziWDgjOnj8rqbCmbFZWoxtX1gl83N/bByAYietaTBAcWKptIy4RtKlDXTTA61DDv9MztRmZkzlXyC97RQGe6+Q53T63XRHrZV1Hef+joDxRir8zObTJoaX88J/xZsz48tshurgxWKBeN3DzlOgZasKSxWfNjwAYyhVXeZVtO9CJMU9rhTmZXKCSDVRKBuaRfxrDTt6hkTzxF9cp8KJzbnh74w725YwjFNztnMJh9jTKJRNgVJy9Hr42FR0FDZcITRSYd8kimmTASmHcESyy0gA1ctRpF0rCcMr2U9/fGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUzZ0fxMj6yi1hzL/ounx9I3J+Cgk9XyO7jm0HZcbFY=;
 b=Z0vYy49BLCEuXWnX9cy5byiA3dOCmOeev5rwhuhwcR2Bp9AT94cbR/gTXlfWNn2JiCBpOviWbSTb/DrVmDcj4Y8ogrpPdIyQyto4gSmVEiTQIo8AoDU5PMiftNRS/zKJSmAdrrtFUwW8BIgJqm7thUuQHEW52yCfH3WyfKGYeKmsCzdO+WKKxrYOVM+1UKttEKH7osCHZ7nEl9hQdG5ofTEsAjesbR3mEdYcywBeET0jLbIPUBaKRuv/emcGZloZ6u2pECEZyWMrTfkYxon40r9zu6A9wfFfa35C3sPYzFcuk9PvyGjTT81lkOKQQGW20UIRb5goF682j7c41wCSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUzZ0fxMj6yi1hzL/ounx9I3J+Cgk9XyO7jm0HZcbFY=;
 b=KCOU7I1cvVzQcTVHeOvqBurkCnNxsoUVl7WHjoinZbE0yu+cygPIHu9R1UBziQAoh8ZyAxEQFopW0943rR+C2eriaipdsYoqGrm83oDBiPnLaATG0va/kuG9NcglMocYar1Hls1rbq8qe+XhPb3DrXMl6z0p8VKKBSApGMpD1D4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VE1PR04MB7376.eurprd04.prod.outlook.com (2603:10a6:800:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Fri, 27 Nov
 2026 12:03:13 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 12:03:13 +0000
Message-ID: <59d378d3-ad3c-49c1-9654-5227ac281089@cherry.de>
Date: Fri, 27 Nov 2026 13:03:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [meta-rockchip][PATCH 2/2] kernel: build the rocket NPU driver as
 a module
To: Trevor Woerner <twoerner@gmail.com>, yocto-patches@lists.yoctoproject.org
References: <20261127114049.3566943-1-twoerner@gmail.com>
 <20261127114049.3566943-2-twoerner@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261127114049.3566943-2-twoerner@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0260.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::41) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
Return-Path: quentin.schulz@cherry.de
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VE1PR04MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: f705aa44-b2a7-4dd1-5331-08df4c7e69ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|4143699003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FzKDwbMm8L126VYOQ4VjszuMHk0MYtX1GAQkAfvzPpgjTzKuvJN/I1YlOx0PfS+YwcyXhiw4YDsZ+rTjZ0MrTkxPx3Hk28HpdW2EtI3VNkR9cYWJ7ppmQROC+KSH5Qtpl6Lp0uSOhbWnHJlLrgS32+KyG+aSYu1wafy4Dw4/0sf86/olVnIox0lXc+ctt5gH5QtUpTlW8aZkIh/W3kEfa5gIZp/FF5pPB8coznSCFJfL2GImfZf+MkrZML5+/4AdaxszN+f2BhndSwgNOb4gW+k47G6Ydk59aEKROxonLMnos3uXRCeS9v9sztlrqtvlkgE+LCSfmCqDU4LQyThMsn7tUuyL+pg8IyEtdLl2bnZQ60tSTNi30Oj6QQKWUYv/xDyZBjHAQkIohfEPKEiUs8OpYUoUwyV/MSBUDs/g9xw/0Ef0aV4WWgGJZafFmQUm9VAb7EiEYvkvn2bf4AV3wnoamV5QxL5dq8w2KGPK1pYM3+EsEl/2HnxAd4c2RObVY8M/EiYY5RZshcaIK9anOyxD0UcQ8JoOFEiphZiflR4WCCi5DLMKnEoMYfOnYWNzMhtJ9NCBLTVWdP7SUT6dd0lweWyT7Ud9NhYT2Z2eLC2d72boRXY5/DmX/TN+Jr/LuSxXIW6d7BddMstPgMpO9LHfz1N5UfCIH9AU+w2GcV8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11153.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHlVN3hqYmNpNFlFcnBCSlVxYVQwcUxyS2ZDcWlIMXM0amNVSmIvWlBaVGls?=
 =?utf-8?B?dUk3Uk1YWkFJWFd1UE1KdEx6dlBvVkhMS1VOUDk0K1ExRi9GQ0hLU1VtWmpz?=
 =?utf-8?B?Z1dPbnZGVE9pdVhVb3kxS3lWUk9XRjhScFlUNUcrRjJzUUhFMHBoM0NQdjE2?=
 =?utf-8?B?Rml5dnlQWFg0dlcyc3FEY0JKQ2NKMjJYcjIvMDU4UUFyQnR6N2JFdTVicEtK?=
 =?utf-8?B?RGh4YUo5aWFhcS8yRHpqMmdDcFhjTjMxR3dsd3pjeVdvSGtSMFQ3UHNBbkNa?=
 =?utf-8?B?ajBtNENhTUs1N0xpeXh0OU9IMnBuVUdsTXdHaW9lWUFBL0lZVS9IRTFxQ2Fs?=
 =?utf-8?B?WjQwaEF0dVVPZHFRZFZ5K2pwUTA2Wms1cDZWLy91QTREM1FWMitRa1FOU01o?=
 =?utf-8?B?a09OYm1uNEc1QTZzaXZOVWZldG9Bb3JZY0w2WldRZkE3Tm5hdEJQY3p3ZEo3?=
 =?utf-8?B?M2lHMEYxWGhHeW1IZTFFYUNKcnJJRW5hVWpJWUdkM0Y4dkFyM0VoWWs0Q3pi?=
 =?utf-8?B?RXJxTjJyRzNCZFhJOVBrRHlXa2RQTW0vbGdxWUJ0aHUzRXlibklPZ2hJMFBR?=
 =?utf-8?B?eTNNbHFCMnJHWWFzaGlCenZqZFRkNEVnY0EvU2Z3eEdRdXlNSGw0OG1Ka0VD?=
 =?utf-8?B?ZGIydFhMYUlSNnpqSUNRRHJCTGZndnlraTg3U1JjSnJhY2cwUitXdUgxaTBL?=
 =?utf-8?B?aWlyOEFnb3FkYWJSNGh0VWZCTlFBcUJLd016eFdVejRGTDBkZzZieGoyUFJz?=
 =?utf-8?B?cTArK0RJY1NMaU9BdmpQdHd1VEg1ekUrTUJXbXp1eGdoVmpjWS9rVm5BVG5t?=
 =?utf-8?B?V252ZXJvbGVoWmd4V2Q1VVV6YWZnZEtPUGk1anFkWFpGb3RGSFYzZ1BleUty?=
 =?utf-8?B?OEtpOVg3dSt5RCtzenUzNmY1aGgza2ZBNTF0WlVlakRYeTl4V3gvTmdBVUZT?=
 =?utf-8?B?bE9LZ1plSm9FZHg4UTMwNkx4bjRVWnBhOHBiaGpqZ3AycTlVYXQxYmVsd3Yr?=
 =?utf-8?B?UUVlbUVOUmV4MEczNHI1MVU0azNVdDc4K0NEVnJiaytwOVN1amoxVnJ5b0NV?=
 =?utf-8?B?T01NcHkxS3ZTUms0RTlyUGhPNXNQaUxGNjEyRHRHZnRHenVTU0RFaEM0eE1I?=
 =?utf-8?B?cVJNaGs2cllualRaL3phZ2FVeGFJZkRXNTZIcG83YkJodHY5NmlxOTFHbFhi?=
 =?utf-8?B?eW1jSXBRNjUrR1I5ODV0N0ErQUhPeWdKa3NlLytVaFErVjBwSzgwWVpobjFh?=
 =?utf-8?B?TnB5L2FQai80R3V5U0ZUaVZmTVBFdERsR1htK2JYY1RFcWRTTVZoTk1PS0R1?=
 =?utf-8?B?UjhqbDlzaHBaL2NQd3ppRTJDRTVPODFxVFhhdjRzQmxNN0FTVWxRa0pFLzls?=
 =?utf-8?B?WUdqT3ZUTzQ1SDVscnR0K25wdmVyMXUrTElDTTJPaVdaaW9sYmtCQXVJZ2RP?=
 =?utf-8?B?MXd6WE83ZXU2Rlo5eEsvVktqSjgwZ0VVSWJvd0dHNlhNeWUwZmtkdlhQTUc1?=
 =?utf-8?B?cVZ3cUdCb3dzdmozc3g2b2F6aDdxTTF3YmdkcGVmRVBJSkszMEZGRHduOW51?=
 =?utf-8?B?Z0laQkNuZElrblZ0YkQ4MCtKMEphSXVWMUtNYWRkWUdFelZhMHZlZmRrYjRy?=
 =?utf-8?B?Y0tnN2l2NVl4c3pHZ1JmT0ZycDU4Q2FRNCtwc0FlOGRaaWF5dExVZUQ3dGRo?=
 =?utf-8?B?ZXlPOXIrbGErblZLc096MjFURk44cStGY2p2T0FRb0dMMnNyaU9TTmt6anVN?=
 =?utf-8?B?bkpYOUZKNkNKUTUwL2NiT3lvVXVkbUVIOUNZc05aa2hRaTZraFdRRkFMOElX?=
 =?utf-8?B?S29JNVBCL3BFRlRJQXNpSGFhY3RTWUJMd29CWGkrQitOMlRaQ0RtajVPcjZV?=
 =?utf-8?B?MGJZYUI1Rkl0ZERrSUs3WmdkNGFWTk1WNzgrL1FFNmwrRnBvcWdiQVE2WmRX?=
 =?utf-8?B?UXdMcmdHNG5kcFJkeHZwcTVXLzFHbGFZNGV6dTZnOHRpTUpoY001dFBVeWZU?=
 =?utf-8?B?TXp1RUxLWkRlTTJNU0VLVmM5NXFTQnVyYlBPNXpaMDh5SjY4UVFjSCtYYkpL?=
 =?utf-8?B?SHVwMDhNR2JXMlJYZk9xN1FPWWxkYXhZN0FvaCtlaytzNWljOFQyTnk1akJu?=
 =?utf-8?B?b25hV1I4Q1d3RVdzREoyUVlLbTloVWtrck5WQU5uaGlESzdCaGpmSGRhdHJ6?=
 =?utf-8?B?R0FYdlhFVGdnN0l5VVJFN3ZiOXZ1WUdlRHgvY3Zad1ZLbFlwUFJFaTdaQ0Uz?=
 =?utf-8?B?M3hrVUtNTVlWcklRby9yU1ZHQVIrZDFFN2VWN2RIb3ZRWHdIU3lvRHZsT2Q1?=
 =?utf-8?B?OU1GUm9ITERIbjR1eVBXZlJrR25TUjl4MkJNdXNRSDNIYjliRGVoZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f705aa44-b2a7-4dd1-5331-08df4c7e69ec
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:03:13.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3zk+kHYbMR1NFUL6RpwWTlqEKW2v1jcO26KRO5GszM3GlL7Gg4M0AyeH1u1c99BcdQujKuWSqTZ01+1GGb76c6gst1iMBPcae9hRmA5Fow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7376
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Fri, 27 Nov 2026 12:03:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5550



On 11/27/26 12:40 PM, Trevor Woerner wrote:
> DRM_ACCEL_ROCKET depends on DRM, which the arm64 defconfig builds as a
> module, so the fragment's =y always ended up as =m and the kernel config
> audit warned about the mismatch. Ask for =m.
> 
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> AI-Generated: codex/claude-opus 5.5 (xhigh)
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
